Return-Path: <netdev+bounces-56222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A074F80E31A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C61F282126
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84826BE4D;
	Tue, 12 Dec 2023 03:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from anchovy2.45ru.net.au (anchovy2.45ru.net.au [203.30.46.146])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FADCCD
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 19:57:46 -0800 (PST)
Received: (qmail 4698 invoked by uid 5089); 12 Dec 2023 03:57:44 -0000
Received: by simscan 1.2.0 ppid: 4475, pid: 4477, t: 2.0227s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Level: 
Received: from unknown (HELO ?192.168.2.4?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 12 Dec 2023 03:57:41 -0000
Message-ID: <8ba4d31f-9436-43ad-afd7-997a4d3a4bf2@electromag.com.au>
Date: Tue, 12 Dec 2023 11:57:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: STMMAC Ethernet Driver support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, vinschen@redhat.com,
  netdev@vger.kernel.org
References: <e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au>
 <20231208101216.3fca85b1@kernel.org>
 <8a0850d8-a2e4-4eb0-81e1-d067f18c2263@electromag.com.au>
 <41903b8b-d145-4fdf-a942-79d7f88f9068@electromag.com.au>
 <f47b0230-1513-4a81-9d78-3f092b979c48@electromag.com.au>
 <2139624b-e098-457a-bda4-0387d576b53a@lunn.ch>
From: Richard Tresidder <rtresidd@electromag.com.au>
In-Reply-To: <2139624b-e098-457a-bda4-0387d576b53a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


<font face="monospace">Richard Tresidder</font>


On 12/12/2023 12:16 am, Andrew Lunn wrote:
>> We use the SOC's internal  STMMAC interface to connect to a Marvel switch IC
>> and expose each port individually using vlan, I'd forgot that part.
>> It's an  88E6352-xx-TFJ2I000  device utilising the 'marvell,mv88e6085'
>> compatible driver  in drivers\net\dsa\mv88e6xxx
> Its odd you need VLANs. Each port should already be exposed to the
> host as netdev interfaces. That is what DSA does.
>
>       Andrew
Hi Andrew
    I'll read further on that one as this is the first time I've had to 
dig into this side of the system.
It had always "just worked".
The ports show up in an 'ip l' list in the same style as a vlan with an 
@ symbol, naming isn't quite vlan style though.
That in concert with the fact this 'vlan_feature' line broke things has 
possibly distorted my view of how they're propagated.
It's a rather trimmed down busybox image, so I'm missing some tools I'd 
usually use to examine stuff.

This is the config in the dts
**************************************
//------------------------------------------------------------------------------
// connected to dsa network switch
&gmac1 {
   clock-names = "stmmaceth", "clk_ptp_ref";
   clocks = <&emac1_clk &hps_eosc1>;
   f2h_ptp_ref_clk;
   fixed-link {
     speed = <1000>;
     full-duplex;
   };
};

//------------------------------------------------------------------------------
&mdio1 {
   #address-cells = <1>;
   #size-cells = <0>;

   switch0: switch0@0 {
     compatible = "marvell,mv88e6085";
     #address-cells = <1>;
     reg = <0>;
     //reset-gpios = <&pio_a0 2 GPIO_ACTIVE_LOW>;

     dsa,member = <0 0>;

     ports {
       #address-cells = <1>;
       #size-cells = <0>;

       port@2 {
         reg = <2>;
         label = "lan1";
         phy-handle = <&switch1phy2>;
       };

       port@3 {
         reg = <3>;
         label = "lan2";
         phy-handle = <&switch1phy3>;
       };

       port@4 {
         reg = <4>;
         label = "lan3";
         phy-handle = <&switch1phy4>;
       };

       port@5 {
         reg = <5>;
         label = "wifi";
         fixed-link {
           speed = <100>;
           full-duplex;
         };
       };

       port@6 {
         reg = <6>;
         label = "cpu";
         ethernet = <&gmac1>;
         fixed-link {
           speed = <1000>;
           full-duplex;
         };
       };

     };

     mdio {
       #address-cells = <1>;
       #size-cells = <0>;
       switch1phy2: switch1phy2@2 {
         reg = <2>;
         marvell,reg-init = <0 0x10 0 0x0200>; // Sense only on Rx 
Energy Detect, no FLPs sents
       };
       switch1phy3: switch1phy3@3 {
         reg = <3>;
         marvell,reg-init = <0 0x10 0 0x0200>; // Sense only on Rx 
Energy Detect, no FLPs sents
       };
       switch1phy4: switch1phy4@4 {
         reg = <4>;
         marvell,reg-init = <0 0x10 0 0x0200>; // Sense only on Rx 
Energy Detect, no FLPs sents
       };
     };

     };
};
*************************************************

This is how they appear using 'ip l'
The @ symbol got me as I've usually associated this with vlan's in my 
day to day networking.
But the config files don't configure them as vlans.
*************************************************
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1508 qdisc mq qlen 1000
     link/ether 04:91:62:cf:4f:06 brd ff:ff:ff:ff:ff:ff
3: sit0@NONE: <NOARP> mtu 1480 qdisc noop qlen 1000
     link/sit 0.0.0.0 brd 0.0.0.0
4: lan1@eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue 
qlen 1000
     link/ether 04:91:62:cf:4f:06 brd ff:ff:ff:ff:ff:ff
5: lan2@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue 
qlen 1000
     link/ether 04:91:62:cf:4f:06 brd ff:ff:ff:ff:ff:ff
6: lan3@eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue 
qlen 1000
     link/ether 04:91:62:cf:4f:06 brd ff:ff:ff:ff:ff:ff
7: wifi@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue 
qlen 1000
     link/ether 04:91:62:cf:4f:06 brd ff:ff:ff:ff:ff:ff

*************************************************

And these are the systemd config files
No vlan mentioned in there..
*************************************************
/etc/systemd/network/eth0.network
[Match]
Name=eth0

[Network]

/etc/systemd/network/lan.network
[Match]
Name=lan*

[Network]
DHCP=yes
BindCarrier=eth0
LinkLocalAddressing=yes

[DHCP]
UseDomains=yes
ClientIdentifier=mac

*************************************************

Cheers
    Richard

