//
//  XMPP.swift
//  IOS_SDK
//
//  Created by Aditya Malik on 03/08/18.
//  Copyright © 2018 Aditya Malik. All rights reserved.
//

import Foundation
import XMPPFramework

enum XMPPControllerError: Error {
    case wrongUserJID
}

class XMPPController: NSObject, XMPPStreamDelegate {
    var xmppStream: XMPPStream
    
    let hostName: String
    let userJID: XMPPJID
    let hostPort: UInt16
    let password: String
    
    let xmppRosterStorage = XMPPRosterCoreDataStorage()
    var xmppRoster: XMPPRoster!
    
    
    
    init(hostName: String, userJIDString: String, hostPort: UInt16 = 5222, password: String) throws {
        guard let userJID = XMPPJID(string: userJIDString) else {
            throw XMPPControllerError.wrongUserJID
        }
        print(userJID)
        self.hostName = hostName
        self.userJID = userJID
        self.hostPort = hostPort
        self.password = password
        
        
        //Stream Config
        self.xmppStream = XMPPStream()
        self.xmppStream.hostName = hostName
        self.xmppStream.hostPort = hostPort
        self.xmppStream.startTLSPolicy = XMPPStreamStartTLSPolicy.allowed
        self.xmppStream.myJID = userJID
        
        super.init()
        
        self.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
        
    
    }
    
    func connect() -> Bool {
        if !self.xmppStream.isDisconnected
        {
            NSLog("Stream: Already connected")
            return true
        }
        NSLog("Stream: Trying to connect")
        do
        {
            try! self.xmppStream.connect(withTimeout: XMPPStreamTimeoutNone)
        }
//        catch{
//            NSLog("Stream: Can not connect")
//            return false
//        }
        return true
        
        
    }
    
    func xmppStreamDidConnect(_ stream: XMPPStream!) {
        NSLog("Stream: Connected")
        try! stream.authenticate(withPassword: self.password)
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        self.xmppStream.send(XMPPPresence())
        NSLog("Stream: Authenticated")
    }
    
    func sendMessage(_ sender: XMPPStream!) {
        if !self.xmppStream.isDisconnected
        {
            print("Stream: disconnected")
            return
        }
        
//        XMLElement *body
        //XMLElement.element(withName: "body")
        
        
    }
    
    func didReceiveMessage(_ sender: XMPPStream!, _ message: XMPPMessage!) {
        print("HERE")
        NSLog("Stream: Recieved message", message)
//        NSXMLElement 
        
    }
    
    
}
