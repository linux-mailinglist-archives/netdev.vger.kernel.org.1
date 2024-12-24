Return-Path: <netdev+bounces-154154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F29FBB2E
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 10:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22011163944
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8D71A724C;
	Tue, 24 Dec 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSVbYoGp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8D18E050
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735032631; cv=none; b=XOur+9e0ood1lmGTizmP5A7RaIP1RgJAAmi0bk9x9RC8w+tBPKj2kf7pPRzx9ccR68rrwSnlvxsnwX/l+aPTfvYBjqBHX/V1yCm3qjbNXYvejRlt3w2rVdLWE2A3kRN1Akn5hcbYdNFmkmKuFlCzMPjEMozdzNSoewfgdjpL898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735032631; c=relaxed/simple;
	bh=OjwodsqVQbjFLszmVPnNS0CgWhI04ALjfsmPdecExvU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=upy1UF7/KTQ7R/JoQPmM0oboSVai0BGGXNtrqwLcVtY+6J78NulCQDwdggVgNAmg5ZX0gVDY5NsBfGijcMI8itUAhEp1e3iwpbRVTJj24QcVFrORJDxNlqb/r3qLnNgwJpF4G9/Nn7jwsznckqVzMftsdTfuE5ncQfLm5d27f28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSVbYoGp; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3a26de697fso4144079276.3
        for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 01:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735032628; x=1735637428; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WochUn6GiL3X6QO5zV4N4V0EDUvDaWbTFgki3x95WRg=;
        b=eSVbYoGpW6k3nrAOwyzdxCZMA1y0Dt8gT1zXxBUS0hKmRrMGhZzeSXt9ZCEZGjThTx
         JvUEnam6sq94fiexKT1UB2YA5QaQjY6rJQ/WSZJJnyhRR4wU729mzAhOveUwPmNrMExz
         3mHhdqFRMbNw37ROG+Vnh8kCMmA1NzXPiPLnb8P+HQTcVLAqb86tQp1TcBCYtEjvNEn+
         fQVdowofsFWMHf3CMe4RPRpv+P/d7lajvGUbcpMGb95B2c/LOz20NQd8VXvLJS5ljJP9
         qw7jo/7q+e7/xdGq8Lkmox7qo4W7EvYDKlEygPSCiSVvSQCA8iqDLngT0S0znK4Y3Mo0
         0ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735032628; x=1735637428;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WochUn6GiL3X6QO5zV4N4V0EDUvDaWbTFgki3x95WRg=;
        b=qG/kt13/QqpSwZHNeQxOptkLdXiHGoVO9Ngh2TgGrQtug42g/T3r1WVbiPaRvFOqWA
         iFnQhLvTtffQfayiWplIXHGxkjBL6pLLVyqGm2iZM7ctNQgdVPt24PVSmHp8kWyQuYkQ
         nVQnYFgnoi2EIAKVJ2KaOGA0xOuMxhFSmQCVXTxknA4nC9xJfHjZ7s2xHuqdHbMGGkHY
         BmOOSyVbBAZpVdMVlvkvs15fJeOGLc4tNgd+VmYd51nH/cTHkiFnJhig7uPKatJz1Of5
         fFHCF9w+KdYhCvjvQfnpogU6Y+3CubU/2H/kPSXDcim1RtEbVOTDSf13grRB7zgWLQZq
         +tCA==
X-Gm-Message-State: AOJu0YwcM5J5Os4+uPHeEWsuiNb7yRuJunnkRRHFVvt/KigSj60ITKfk
	ZGh8X+qFOsx54OrfjsCCoMN4zBkax34jqmfQgBV0rgly2hO4GlZiQywLuvUriwj6REOSnR5gxSI
	cX4Q8+7ed5b7cKisCIgP7bS6vtAZDCO+7
X-Gm-Gg: ASbGncvQI3RreqxoiILt9I6h+V6zAMaQb070KF8nn/bEYgVswCIJpgDBSefn1z2Em7/
	d2rO2EbBM5NeV9S1CZW1bQkVEVVXTwc773gLC
X-Google-Smtp-Source: AGHT+IExtRWboF5Rky++IK3VV0ldmh/ngxQ3IwBP2MVNr3WFlQ2so1+chtSnkagVjxPSHVUOk0KvNcdyiMt0ywK8IdM=
X-Received: by 2002:a25:841:0:b0:e4c:bd70:8532 with SMTP id
 3f1490d57ef6-e538c2854eemr9898405276.23.1735032628328; Tue, 24 Dec 2024
 01:30:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: sai kumar <skmr537@gmail.com>
Date: Tue, 24 Dec 2024 15:00:17 +0530
Message-ID: <CAA=kqWJWjEr36iZXZ+GFeaqxx35kXTO0WdGZXsL4Q7cvsT3GYg@mail.gmail.com>
Subject: DSA Switch: query: Switch configuration, data plane doesn't work
 whereas control plane works
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Team,

This could be basic question related to DSA, if possible please help
to share your feedback,. Thanks.


External CPU eth1 ---RGMII---- Switch Port 0 (cpu port)
Switch Port 1 (lan1) --- DHCP client

I am using marvell 88E6390 evaluation board, modified the device tree
to support MDIO control over USB.
The switch control plane works, we are unable to dump registers and
see port status.

The kernel version on board with external cpu is 6.1

I have connected a dhcp client to port 1 of the switch and the
discover packet is not reaching the cpu port (port 0) and external cpu
interface eth1.
Using the bridge without vlan to configure, able to see the client
device mac addr in bridge fdb show
with vlan id as 4095.

tcpdump on external cpu port eth1 and bridge br0 to listen for
incoming packets from the client . No discover packets are being
received on those interfaces.

Could you please let us know if any configuration is being missed for
switch data plane to work ? Thanks.


The below are the commands used to configure the bridge:

ip link set eth1 up
ip link set lan1 up
ip link set lan2 up
ip link set lan3 up
ip link set lan4 up
ip link set lan5 up
ip link set lan6 up
ip link set lan7 up
ip link set lan8 up
ip link add br0 type bridge
ip link set br0 up
ip link set lan1 master br0
ip link set lan2 master br0
ip link set lan3 master br0
ip link set lan4 master br0
ip link set lan5 master br0
ip link set lan6 master br0
ip link set lan7 master br0
ip link set lan8 master br0

bridge link show
6: lan1@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0
state forwarding priority 32 cost 19
7: lan2@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 master br0
state disabled priority 32 cost 100
8: lan3@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 master br0
state disabled priority 32 cost 100
9: lan4@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 master br0
state disabled priority 32 cost 100
10: lan5@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 master br0
state disabled priority 32 cost 100
11: lan6@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 master br0
state disabled priority 32 cost 100
12: lan7@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 master br0
state disabled priority 32 cost 100
13: lan8@eth1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 master br0
state disabled priority 32 cost 100

 bridge vlan show
port              vlan-id

bridge fdb show

xx:xx:xx:01:cf:c1 dev lan1 master br0 permanent
xx:xx:xx:8e:27:01 dev lan1 vlan 4095 self

Below are the debug logs:

 ./mv88e6xxx_dump --ports
Using device <mdio_bus/mvusb-1-1:1.0:00>
               0    1    2    3    4    5    6    7    8    9   10
00 Port status            0e07 1d0f 100f 100f 100f 100f 100f 100f 100f 0049 0049
01 Physical control       e03e 0003 0003 0003 0003 0003 0003 0003 0003 0003 0003
02 Flow control           0100 0100 0100 0100 0100 0100 0100 0100 0100 0000 0000
03 Switch ID              3901 3901 3901 3901 3901 3901 3901 3901 3901 3901 3901
04 Port control           013f 043f 043c 043c 043c 043c 043c 043c 043c 007c 007c
05 Port control 1         0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
06 Port base VLAN map     07fe 01fd 01fb 01f7 01ef 01df 01bf 017f 00ff 05ff 03ff
07 Def VLAN ID & Prio     0000 0fff 0fff 0fff 0fff 0fff 0fff 0fff 0fff 0001 0001
08 Port control 2         2c80 2080 2080 2080 2080 2080 2080 2080 2080 2080 2080
09 Egress rate control    0001 0001 0001 0001 0001 0001 0001 0001 0001 0001 0001
0a Egress rate control 2  0000 0000 0000 0000 0000 0000 0000 0000 0000 8000 8000
0b Port association vec   0001 0002 0004 0008 0010 0020 0040 0080 0100 0200 0400
0c Port ATU control       0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0d Override               0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0e Policy control         0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0f Port ether type        9100 9100 9100 9100 9100 9100 9100 9100 9100 9100 9100
10 Reserved               0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
11 Reserved               0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
12 Reserved               0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
13 Reserved               0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
14 Reserved               0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
15 Reserved               0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
16 LED control            0000 0033 0033 0033 0033 0033 0033 0033 0033 0033 0033
17 IP prio map table      0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
18 IEEE prio map table    3e07 3e07 3e07 3e07 3e07 3e07 3e07 3e07 3e07 0000 0000
19 Port control 3         0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
1a Reserved               0000 0000 0000 0000 7d40 01c0 0000 0000 0000 0000 0000
1b Queue counters         8000 8000 8000 8000 8000 8000 8000 8000 8000 8000 8000
1c Queue control          0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
1d Reserved               0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
1e Cut through control    0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
1f Debug counters         0000 009f 0000 0000 0000 0000 0000 0000 0000 0000 0000

./mv88e6xxx_dump --port 0
Using device <mdio_bus/mvusb-1-1:1.0:00>
00 Port status                            0x0e07
      Transmit Pause Enable bit            0
      Receive Pause Enable bit             0
      802.3 PHY Detected                   0
      Link Status                          Up
      Duplex                               Full
      Speed                                1000 Mbps
      Duplex Fixed                         0
      EEE Enabled                          0
      Transmitter Paused                   0
      Flow Control                         0
      Config Mode                          0x7
01 Physical control                       0xe03e
      RGMII Receive Timing Control         Delay
      RGMII Transmit Timing Control        Delay
      Force Speed                          1
      Alternate Speed Mode                 Normal
      MII PHY Mode                         MAC
      EEE force value                      0
      Force EEE                            0
      Link's Forced value                  Up
      Force Link                           1
      Duplex's Forced value                Full
      Force Duplex                         1
      Force Speed                          1000 Mbps
02 Flow control                           0x0100
03 Switch ID                              0x3901
04 Port control                           0x013f
      Source Address Filtering controls    Disabled
      Egress Mode                          Unmodified
      Ingress & Egress Header Mode         0
      IGMP and MLD Snooping                0
      Frame Mode                           DSA
      VLAN Tunnel                          0
      TagIfBoth                            0
      Initial Priority assignment          Tag & IP Priority
      Egress Flooding mode                 Allow unknown DA
      Port State                           Forwarding
05 Port control 1                         0x0000
      Message Port                         0
      LAG Port                             0
      VTU Page                             0
      LAG ID                               0
      FID[11:4]                            0x000
06 Port base VLAN map                     0x07fe
      FID[3:0]                             0x000
      Force Mapping                        0
      VLANTable                            1 2 3 4 5 6 7 8 9 10
07 Def VLAN ID & Prio                     0x0000
      Default Priority                     0x0
      Force to use Default VID             0
      Default VLAN Identifier              0
08 Port control 2                         0x2c80
      Force good FCS in the frame          0
      Allow bad FCS                        0
      Jumbo Mode                           10240
      802.1QMode                           Secure
      Discard Tagged Frames                0
      Discard Untagged Frames              0
      Map using DA hits                    1
      ARP Mirror enable                    0
      Egress Monitor Source Port           0
      Ingress Monitor Source Port          0
      Allow VID of Zero                    0
      Default Queue Priority               0x0
09 Egress rate control                    0x0001
0a Egress rate control 2                  0x0000
0b Port association vec                   0x0001
0c Port ATU control                       0x0000
0d Override                               0x0000
0e Policy control                         0x0000
0f Port ether type                        0x9100
10 Reserved                               0x0000
11 Reserved                               0x0000
12 Reserved                               0x0000
13 Reserved                               0x0000
14 Reserved                               0x0000
15 Reserved                               0x0000
16 LED control                            0x0000
17 IP prio map table                      0x0000
18 IEEE prio map table                    0x3e07
19 Port control 3                         0x0000
1a Reserved                               0x0000
1b Queue counters                         0x8000
1c Queue control                          0x0000
1d Reserved                               0x0000
1e Cut through control                    0x0000
1f Debug counters                         0x0000

 ./mv88e6xxx_dump --port 1
Using device <mdio_bus/mvusb-1-1:1.0:00>
00 Port status                            0x1d0f
      Transmit Pause Enable bit            0
      Receive Pause Enable bit             0
      802.3 PHY Detected                   1
      Link Status                          Up
      Duplex                               Full
      Speed                                100 or 200 Mbps
      Duplex Fixed                         0
      EEE Enabled                          0
      Transmitter Paused                   0
      Flow Control                         0
      Config Mode                          0xf
01 Physical control                       0x0003
      RGMII Receive Timing Control         Default
      RGMII Transmit Timing Control        Default
      Force Speed                          0
      Alternate Speed Mode                 Normal
      MII PHY Mode                         MAC
      EEE force value                      0
      Force EEE                            0
      Link's Forced value                  Down
      Force Link                           0
      Duplex's Forced value                Half
      Force Duplex                         0
      Force Speed                          10 Gb or 2500 Mbps
02 Flow control                           0x0100
03 Switch ID                              0x3901
04 Port control                           0x043f
      Source Address Filtering controls    Disabled
      Egress Mode                          Unmodified
      Ingress & Egress Header Mode         0
      IGMP and MLD Snooping                1
      Frame Mode                           Normal
      VLAN Tunnel                          0
      TagIfBoth                            0
      Initial Priority assignment          Tag & IP Priority
      Egress Flooding mode                 Allow unknown DA
      Port State                           Forwarding
05 Port control 1                         0x0000
      Message Port                         0
      LAG Port                             0
      VTU Page                             0
      LAG ID                               0
      FID[11:4]                            0x000
06 Port base VLAN map                     0x01fd
      FID[3:0]                             0x000
      Force Mapping                        0
      VLANTable                            0 2 3 4 5 6 7 8
07 Def VLAN ID & Prio                     0x0fff
      Default Priority                     0x0
      Force to use Default VID             0
      Default VLAN Identifier              4095
08 Port control 2                         0x2080
      Force good FCS in the frame          0
      Allow bad FCS                        0
      Jumbo Mode                           10240
      802.1QMode                           Disabled
      Discard Tagged Frames                0
      Discard Untagged Frames              0
      Map using DA hits                    1
      ARP Mirror enable                    0
      Egress Monitor Source Port           0
      Ingress Monitor Source Port          0
      Allow VID of Zero                    0
      Default Queue Priority               0x0
09 Egress rate control                    0x0001
0a Egress rate control 2                  0x0000
0b Port association vec                   0x0002
0c Port ATU control                       0x0000
0d Override                               0x0000
0e Policy control                         0x0000
0f Port ether type                        0x9100
10 Reserved                               0x0000
11 Reserved                               0x0000
12 Reserved                               0x0000
13 Reserved                               0x0000
14 Reserved                               0x0000
15 Reserved                               0x0000
16 LED control                            0x0033
17 IP prio map table                      0x0000
18 IEEE prio map table                    0x3e07
19 Port control 3                         0x0000
1a Reserved                               0x0000
1b Queue counters                         0x8000
1c Queue control                          0x0000
1d Reserved                               0x0000
1e Cut through control                    0x0000
1f Debug counters                         0x00a1

 ./mv88e6xxx_dump --vtu
Using device <mdio_bus/mvusb-1-1:1.0:00>
VTU:
    V - a member, egress not modified
    U - a member, egress untagged
    T - a member, egress tagged
    X - not a member, Ingress frames with VID discarded
P  VID 0123456789a  FID  SID QPrio FPrio VidPolicy
0    0 VVVVVVVVVVV    0    0     -     -     1
0 4095 VVVVVVVVVVV    1    0     -     -     0

 ./mv88e6xxx_dump --atu
Using device <mdio_bus/mvusb-1-1:1.0:00>
ATU:
FID  MAC           T 0123456789A Prio State
   1 xx:xx:xx:01:cf:c1   10000000000    0 Static
   1 xx:xx:xx:8e:27:01   01000000000    0 Age 7
   1 ff:ff:ff:ff:ff:ff   11111111100    0 Static

./mv88e6xxx_dump --global1
Using device <mdio_bus/mvusb-1-1:1.0:00>
Global1:
00 Global status                    c801
01 ATU FID                          0001
02 VTU FID                          0001
03 VTU SID                          0000
04 Global control                   40a8
05 VTU operations                   4000
06 VTU VID                          2fff
07 VTU/STU Data 0-7                 0000
08 VTU/STU Data 8-10                003c
09 Reserved                         0000
0a ATU control                      0509
0b ATU operations                   4000
0c ATU data                         1ff7
0d ATU MAC bytes 0 & 1              ffff
0e ATU MAC bytes 2 & 3              ffff
0f ATU MAC bytes 4 & 5              ffff
10 Reserved                         0000
11 Reserved                         0000
12 Reserved                         0000
13 Reserved                         0000
14 Reserved                         0000
15 Reserved                         0000
16 Reserved                         0000
17 Reserved                         0000
18 Reserved                         0000
19 Reserved                         0000
1a Monitor & management Control     03ff
1b Total free counter               03fe
1c Global control 2                 07c0
1d Stats operation                  441f
1e Stats counter bytes 3 & 2        0000
1f Stats counter bytes 1 & 0        0000

 ./mv88e6xxx_dump --global2
Using device <mdio_bus/mvusb-1-1:1.0:00>
Global2:
00 Interrupt source                 0000
01 Interrupt mask                   81fe
02 Reserved                         0000
03 Reserved                         0000
04 Flow control delays              0258
05 Managment                        0400
06 Device mapping                   1f1f
07 LAG mask                         77ff
08 LAG mapping                      7800
09 Ingress rate command             2a00
0a Ingress rate data                0000
0b Cross chip port VLAN addr        3010
0c Cross chip port VLAN data        01ff
0d Switch MAC/WoL/WoF               0542
0e ATU Stats                        0003
0f Priority override table          0f00
10 Reserved                         0000
11 Reserved                         0000
12 Energy management                0000
13 IMP comm/debug                   0303
14 EEPROM command                   0000
15 EEPROM addr                      0000
16 AVB/TSN command                  0000
17 AVB/TSN data                     0000
18 SMI PHY command                  1456
19 SMI PHY data                     0000
1a Scratch & Misc                   0000
1b Watchdog control                 1100
1c QoS Weights                      0000
1d Misc                             0000
1e Reserved                         0000
1f Cut through control              0000

