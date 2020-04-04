import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class Lobby extends StatefulWidget {
  @override
  LobbyState createState() => LobbyState();
}

class LobbyState extends State<Lobby> {
  CameraController _cameraController;

  bool isFlashing;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFlashing = false;
    _cameraController = CameraController(cameras[0], ResolutionPreset.low);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  void _startPharo() {
    _cameraController.startImageStream((CameraImage image) {});
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return Container(
        color: Colors.blueGrey.shade900,
        height: double.infinity,
        width: double.infinity,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AspectRatio(
              aspectRatio: _cameraController.value.aspectRatio,
              child: CameraPreview(_cameraController)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFlashing ? Colors.white : Colors.blueGrey.shade900,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.flash_on,
                      color:
                          !isFlashing ? Colors.white : Colors.blueGrey.shade900,
                    ),
                    onPressed: () {
                      _cameraController.flash(!isFlashing);
                      setState(() {
                        isFlashing = !isFlashing;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey.shade900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                      )),
                  height: 200,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
