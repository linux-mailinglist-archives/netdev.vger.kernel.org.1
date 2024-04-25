Return-Path: <netdev+bounces-91413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CEE8B27AA
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF7F1C210E2
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3698214E2DF;
	Thu, 25 Apr 2024 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk+R3gTW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A7F1482EF
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714066675; cv=none; b=fb0kUw62ixDjp5sUlFDsYVhW/UQ+D+HH5swB628o/HMsaD9yqjt+ZUzH+no1URmI/T/Empahb1ydEyEyNXRBWPcxoHDjn/h7ue2JJv+/JwmWsyLWWaUbclVxvRHoXFEmtZinb5WYmvWlI7BpomNKOWb0kdLk99nncYWpVljigWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714066675; c=relaxed/simple;
	bh=/hmjgBOtERn93PRpfNC2owH8sucOV0Pu7ZVO51oyf/s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rQX2mC/PJAjXidRMh7ZuuBaxx0YYtkR7l8ABjpcUJvV1M5MQ1QauJYPf06tEV/rkp35sgWjsDBix3UygjDHfyo3cXszesQ/99bUuLYKHmbBIQiiPp+YPAxypiftjFIzk5RiyJ0OGYEM5YKk1Z3NERYN8Lz7zyFLwGdgYY6OG++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk+R3gTW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a564ca6f67so1157775a91.2
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714066671; x=1714671471; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3jKghnHlab/g25IBRiSCz6SLK6w0PaJ+nLOiMSnCJic=;
        b=kk+R3gTWPo4ENKzS0pgnoyoasBIkC9kJoUUDRqpN23jOF370BdP94gdp7XsY8PXBht
         sLzrjrfS0VWHAZaG2wnulIVdvFtj5x5mn5TmsyPenGvThd5OeJhLYjALyhUFyrZ/x59O
         /7t+vcINaZ8K2CyBBv43eUdAIwSGZoMyES6sGfxvjGbFBRsNvrK0TTRAs+jE3qcWy3iL
         do0rDB4wjnUDtS1j6ecDHkK9y1gb4w2eDeV8FLr1BWx9T+y9RuXxibrZWG3uvszH5HN3
         /NpEeACVeTDkDZC/VYaDIdr9kS9wlkNlWBXTFQVJLdSf7PZTjE5bSl6oaoSRLoY0N8iX
         FDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714066671; x=1714671471;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jKghnHlab/g25IBRiSCz6SLK6w0PaJ+nLOiMSnCJic=;
        b=e9skv1lY20BkKTrHV9dfyQFiHKM82YAGRb1ETJUt094K20EQsf5gwQlwirM/FiVpey
         3Mx9IB+QwMPrOIuKH+02XFlnvp21O6fBAOzYQRr+5rnclqNn4/9dh+Oo2t/9GEA+Xb5G
         w9OorUtzvbAchYYHFO9LgJU0iCNYd1W5xUsdjfaaAS/ES+b4DayFtgBMMgo+H2tYe7do
         u1C/DpmihLQWTM3hfmESX4T38wkbMmg6IxzNbX7C63f7cXd1WbVkIRsor9FsoGsoIQx0
         Vzs/DS7eYzKFFoNCODMOLks4lFIV5TZW7q2v2sUXsn6L22vahqsdSCNUUVoo8xs4XJYD
         dUpA==
X-Gm-Message-State: AOJu0YyoI2zupeMKGe0M93QPXfMvkNfBNqyCvpKPuMJgaOYkjRpVpCBy
	V6xjXu92McjTRyJ+A0919szyohilabp3v5rVAvboZEZStqsJW4llCFXIT2RPv0dhRuoSnCtFUF8
	TUFyv/PHrgfXCz6IbVLTU6389d0THx7sd
X-Google-Smtp-Source: AGHT+IG8CsY+JjcELrscc9TgzygwD0tzIa90ERTU3p+/l0EsDMuLh1XKT22pBa2iNVjAkXRa1YZor+fnTs1BIFQYtXw=
X-Received: by 2002:a17:90a:d158:b0:2af:2dce:707c with SMTP id
 t24-20020a17090ad15800b002af2dce707cmr246849pjw.35.1714066670792; Thu, 25 Apr
 2024 10:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: SIMON BABY <simonkbaby@gmail.com>
Date: Thu, 25 Apr 2024 10:37:38 -0700
Message-ID: <CAEFUPH1q9MPNBrfzhSmCawM4y+A6SKe47Pc1PjqShy-0Oo4-2w@mail.gmail.com>
Subject: ping test with DSA ports failing
To: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Content-Type: multipart/mixed; boundary="00000000000008db8b0616ef3f13"

--00000000000008db8b0616ef3f13
Content-Type: multipart/alternative; boundary="00000000000008db8a0616ef3f11"

--00000000000008db8a0616ef3f11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello team,

My test setup with DSA ports is below. Please confirm if it is a valid test
case for ping.

Ping is failing most of the time but succeeds sometimes. Attached is the
Wireshark capture from my laptop and the tcpdump from sama7 processor.



__________
_______________   192.168.0.119/24                  192.168.0.155/24
 _________

|                    |
|                                |____________lan1__________________
____|                   |

|  SAMA7     |  eth0 (RGMII)                           |  marvel 88e6390
|___________  lan2                                                  |
laptop      |

|        gmac0|---------------------------------------|port0 (RGMII)
|___________  lan3
                         |________ |

|_________|
|                                |___________  lan4


     |
|___________  lan5


|                                |___________  lan6


|______________ |







eth0 =E2=80=93 DSA master interface, gmac0 of sama7 and port0 of marvel are=
 RGMII
connected. For the testing I have connected via a PHY on both sides with an
ethernet cable.  No IP address configured on this master interface and
interface is UP.

lan1, lan2, lan3 =E2=80=A6 etc  are the DSA slave ports

lan1 is directly connected to a laptop.

lan1 ip address: 192.168.0.119/24

laptop ip address: 192.168.0.115/24





ping from sama7 processor to laptop ip address. I believe it should go from
CPU to eth0 and then lan1 to laptop.

Ping is failing most of the times. Interestingly it is passing sometime.
Below are the logs.



root@sama7g5ek-sd:~# ifconfig lan1 192.168.0.119/24 up

mv88e6085 e2800000.ethernet-ffffffff:10 lan1: configuring for phy/gmii link
mode

root@sama7g5ek-sd:~# mv88e6085 e2800000.ethernet-ffffffff:10 lan1: Link is
Up - 1Gbps/Full - flow control rx/tx

IPv6: ADDRCONF(NETDEV_CHANGE): lan1: link becomes ready



root@sama7g5ek-sd:~# ifconfig

eth0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1504

        inet6 fe80::691:62ff:fef2:fd1c  prefixlen 64  scopeid 0x20<link>

        ether 04:91:62:f2:fd:1c  txqueuelen 1000  (Ethernet)

        RX packets 128  bytes 13882 (13.5 KiB)

        RX errors 0  dropped 0  overruns 0  frame 0

        TX packets 40  bytes 5052 (4.9 KiB)

        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

        device interrupt 172



lan1: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500

        inet 192.168.0.119  netmask 255.255.255.0  broadcast 192.168.0.255

        inet6 fe80::691:62ff:fef2:fd1c  prefixlen 64  scopeid 0x20<link>

        ether 04:91:62:f2:fd:1c  txqueuelen 1000  (Ethernet)

        RX packets 118  bytes 11744 (11.4 KiB)

        RX errors 0  dropped 4  overruns 0  frame 0

        TX packets 18  bytes 1456 (1.4 KiB)

        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0



root@sama7g5ek-sd:~# ping 192.168.0.115

PING 192.168.0.115 (192.168.0.115) 56(84) bytes of data.

From 192.168.0.119 icmp_seq=3D1 Destination Host Unreachable

From 192.168.0.119 icmp_seq=3D2 Destination Host Unreachable

From 192.168.0.119 icmp_seq=3D3 Destination Host Unreachable

64 bytes from 192.168.0.115: icmp_seq=3D6 ttl=3D128 time=3D1.04 ms

64 bytes from 192.168.0.115: icmp_seq=3D7 ttl=3D128 time=3D1.28 ms

64 bytes from 192.168.0.115: icmp_seq=3D10 ttl=3D128 time=3D1.19 ms

64 bytes from 192.168.0.115: icmp_seq=3D14 ttl=3D128 time=3D0.822 ms

64 bytes from 192.168.0.115: icmp_seq=3D24 ttl=3D128 time=3D11.2 ms

64 bytes from 192.168.0.115: icmp_seq=3D26 ttl=3D128 time=3D0.770 ms

64 bytes from 192.168.0.115: icmp_seq=3D28 ttl=3D128 time=3D0.769 ms

64 bytes from 192.168.0.115: icmp_seq=3D32 ttl=3D128 time=3D0.757 ms

From 192.168.0.119 icmp_seq=3D71 Destination Host Unreachable

From 192.168.0.119 icmp_seq=3D72 Destination Host Unreachable

From 192.168.0.119 icmp_seq=3D73 Destination Host Unreachable

From 192.168.0.119 icmp_seq=3D74 Destination Host Unreachable

From 192.168.0.119 icmp_seq=3D75 Destination Host Unreachable

From 192.168.0.119 icmp_seq=3D76 Destination Host Unreachable

From 192.168.0.119 icmp_seq=3D77 Destination Host Unreachable

From 192.168.0.119 icmp_seq=3D78 Destination Host Unreachable

From 192.168.0.119 icmp_seq=3D79 Destination Host Unreachable

64 bytes from 192.168.0.115: icmp_seq=3D80 ttl=3D128 time=3D1.49 ms

64 bytes from 192.168.0.115: icmp_seq=3D81 ttl=3D128 time=3D0.821 ms

64 bytes from 192.168.0.115: icmp_seq=3D83 ttl=3D128 time=3D0.788 ms

64 bytes from 192.168.0.115: icmp_seq=3D87 ttl=3D128 time=3D0.774 ms

64 bytes from 192.168.0.115: icmp_seq=3D92 ttl=3D128 time=3D0.892 ms

64 bytes from 192.168.0.115: icmp_seq=3D96 ttl=3D128 time=3D0.887 ms

64 bytes from 192.168.0.115: icmp_seq=3D99 ttl=3D128 time=3D1.13 ms

64 bytes from 192.168.0.115: icmp_seq=3D102 ttl=3D128 time=3D0.962 ms

64 bytes from 192.168.0.115: icmp_seq=3D111 ttl=3D128 time=3D16.2 ms

64 bytes from 192.168.0.115: icmp_seq=3D115 ttl=3D128 time=3D1.61 ms

64 bytes from 192.168.0.115: icmp_seq=3D118 ttl=3D128 time=3D0.817 ms



root@sama7g5ek-sd:~# ip route

192.168.0.0/24 dev lan1 proto kernel scope link src 192.168.0.119

root@sama7g5ek-sd:~#



My device tree used for DSA is below:



&gmac0 {

        phy-mode =3D "rgmii-id";

        phy-handle =3D <&switch0cpu>;

        status =3D "okay";

        fixed-link {

                speed =3D <1000>;

                full-duplex;

        };



        mdio {

                status =3D "okay";

                switch: switch@10 {

                        compatible =3D "marvell,mv88e6190";

                        reg =3D <0x10>;



                        ports {

                                #address-cells =3D <1>;

                                #size-cells =3D <0>;

                                switch0cpu: port@0 {

                                        reg =3D <0>;

                                        ethernet =3D <&gmac0>;

                                        phy-mode =3D "rgmii";

                                        fixed-link {

                                                speed =3D <1000>;

                                                full-duplex;

                                        };

                                };



                                port@1 {

                                        reg =3D <0x1>;

                                        label =3D "lan1";

                                };



                                port@2 {

                                        reg =3D <0x2>;

                                        label =3D "lan2";

                                };



                                port@3 {

                                        reg =3D <0x3>;

                                        label =3D "lan3";

                                };



                                port@4 {

                                        reg =3D <0x4>;

                                        label =3D "lan4";

                                };



                                port@5 {

                                        reg =3D <0x5>;

                                          label =3D "lan5";

                                };



                                port@6 {

                                        reg =3D <0x6>;

                                        label =3D "lan6";

                                };

                        };

                };

        };

};








Regards

Simon

--00000000000008db8a0616ef3f11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello team,<div><br></div><div><p class=3D"MsoNormal" styl=
e=3D"margin:0in;font-size:12pt;font-family:Aptos,sans-serif"><span style=3D=
"font-size:11pt;font-family:Calibri,sans-serif">My
test setup with DSA ports is below. Please confirm if it is a valid test ca=
se
for ping.=C2=A0</span></p><p class=3D"MsoNormal" style=3D"margin:0in;font-s=
ize:12pt;font-family:Aptos,sans-serif"><span style=3D"font-size:11pt;font-f=
amily:Calibri,sans-serif">Ping is failing most of the time but succeeds som=
etimes.
Attached is the Wireshark capture from my laptop and the tcpdump from sama7=
 processor.=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
__________=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
_______________=C2=A0=C2=A0
<a href=3D"http://192.168.0.119/24">192.168.0.119/24</a>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<a href=3D"http://192=
.168.0.155/24">192.168.0.155/24</a>
=C2=A0_________</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|____________lan1________________=
__
____|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
|</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
|=C2=A0
SAMA7 =C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0 eth0
(RGMII)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =C2=A0marvel 88e6390
|___________=C2=A0 lan2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|
laptop=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
|=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0gmac0|---------------------------------=
------|port0
(RGMII)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |___________=C2=A0
lan3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
|________
|</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
|_________|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|___________
=C2=A0lan4 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
|___________ =C2=A0lan5</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
|___________=C2=A0 lan6</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
|______________ | </span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
eth0
=E2=80=93 DSA master interface, gmac0 of sama7 and port0 of marvel are RGMI=
I connected.
For the testing I have connected via a PHY on both sides with an ethernet c=
able.
=C2=A0No IP address configured on this master interface and interface is UP=
.</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
lan1,
lan2, lan3 =E2=80=A6 etc =C2=A0are the DSA slave ports </span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
lan1
is directly connected to a laptop.</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
lan1
ip address: <a href=3D"http://192.168.0.119/24">192.168.0.119/24</a></span>=
</p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
laptop
ip address: <a href=3D"http://192.168.0.115/24">192.168.0.115/24</a></span>=
</p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
ping
from sama7 processor to laptop ip address. I believe it should go from CPU =
to
eth0 and then lan1 to laptop. </span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
Ping
is failing most of the times. Interestingly it is passing sometime. Below a=
re
the logs.</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">root@sama7g5ek-sd:~# ifconfig lan1 <a href=3D"http://=
192.168.0.119/24">192.168.0.119/24</a> up</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">mv88e6085 e2800000.ethernet-ffffffff:10 lan1: configu=
ring for
phy/gmii link mode</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">root@sama7g5ek-sd:~# mv88e6085 e2800000.ethernet-ffff=
ffff:10
lan1: Link is Up - 1Gbps/Full - flow control rx/tx</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">IPv6: ADDRCONF(NETDEV_CHANGE): lan1: link becomes rea=
dy</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">root@sama7g5ek-sd:~# ifconfig</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">eth0: flags=3D4163&lt;UP,BROADCAST,RUNNING,MULTICAST&=
gt;=C2=A0 mtu
1504</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet6
fe80::691:62ff:fef2:fd1c=C2=A0 prefixlen 64=C2=A0 scopeid 0x20&lt;link&gt;<=
/span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ether
04:91:62:f2:fd:1c=C2=A0 txqueuelen 1000=C2=A0 (Ethernet)</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX packets=
 128=C2=A0
bytes 13882 (13.5 KiB)</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX errors =
0=C2=A0
dropped 0=C2=A0 overruns 0=C2=A0 frame 0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX packets=
 40=C2=A0
bytes 5052 (4.9 KiB)</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TX errors =
0=C2=A0
dropped 0 overruns 0=C2=A0 carrier 0=C2=A0 collisions 0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device int=
errupt 172</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">lan1: flags=3D4163&lt;UP,BROADCAST,RUNNING,MULTICAST&=
gt;=C2=A0 mtu
1500</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet
192.168.0.119=C2=A0 netmask 255.255.255.0=C2=A0 broadcast 192.168.0.255</sp=
an></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet6
fe80::691:62ff:fef2:fd1c=C2=A0 prefixlen 64=C2=A0 scopeid 0x20&lt;link&gt;<=
/span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ether
04:91:62:f2:fd:1c=C2=A0 txqueuelen 1000=C2=A0 (Ethernet)</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX packets=
 118=C2=A0
bytes 11744 (11.4 KiB)</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX errors =
0=C2=A0
dropped 4=C2=A0 overruns 0=C2=A0 frame 0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX packets=
 18=C2=A0
bytes 1456 (1.4 KiB)</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX errors =
0=C2=A0
dropped 0 overruns 0=C2=A0 carrier 0=C2=A0 collisions 0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">root@sama7g5ek-sd:~# ping 192.168.0.115</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">PING 192.168.0.115 (192.168.0.115) 56(84) bytes of da=
ta.</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:red">From 192.168.0.119 icmp_seq=3D1 Destination Host Unreachable</spa=
n></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:red">From 192.168.0.119 icmp_seq=3D2 Destination Host Unreachable</spa=
n></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:red">From 192.168.0.119 icmp_seq=3D3 Destination Host Unreachable</spa=
n></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D6 ttl=3D128 time=3D1.04 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D7 ttl=3D128 time=3D1.28 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D10 ttl=3D128 time=3D1.19 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D14 ttl=3D128 time=3D0.822 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D24 ttl=3D128 time=3D11.2 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D26 ttl=3D128 time=3D0.770 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D28 ttl=3D128 time=3D0.769 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D32 ttl=3D128 time=3D0.757 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:red">From 192.168.0.119 icmp_seq=3D71 Destination Host Unreachable</sp=
an></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:red">From 192.168.0.119 icmp_seq=3D72 Destination Host Unreachable</sp=
an></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:red">From 192.168.0.119 icmp_seq=3D73 Destination Host Unreachable</sp=
an></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:red">From 192.168.0.119 icmp_seq=3D74 Destination Host Unreachable</sp=
an></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:red">From 192.168.0.119 icmp_seq=3D75 Destination Host Unreachable</sp=
an></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:red">From 192.168.0.119 icmp_seq=3D76 Destination Host Unreachable</sp=
an></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:red">From 192.168.0.119 icmp_seq=3D77 Destination Host Unreachable</sp=
an></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:red">From 192.168.0.119 icmp_seq=3D78 Destination Host Unreachable</sp=
an></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:red">From 192.168.0.119 icmp_seq=3D79 Destination Host Unreachable</sp=
an></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D80 ttl=3D128 time=3D1.49 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D81 ttl=3D128 time=3D0.821 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D83 ttl=3D128 time=3D0.788 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D87 ttl=3D128 time=3D0.774 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D92 ttl=3D128 time=3D0.892 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D96 ttl=3D128 time=3D0.887 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D99 ttl=3D128 time=3D1.13 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D102 ttl=3D128 time=3D0.962 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D111 ttl=3D128 time=3D16.2 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D115 ttl=3D128 time=3D1.61 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">64 bytes from <a href=3D"http://192.168.0.115">192.16=
8.0.115</a>: icmp_seq=3D118 ttl=3D128 time=3D0.817 ms</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
root@sama7g5ek-sd:~#
ip route</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
<a href=3D"http://192.168.0.0/24">192.168.0.0/24</a>
dev lan1 proto kernel scope link src 192.168.0.119</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
root@sama7g5ek-sd:~#</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
My
device tree used for DSA is below:</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">&amp;gmac0 {</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy-mode =
=3D
&quot;rgmii-id&quot;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy-handle=
 =3D
&lt;&amp;switch0cpu&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D
&quot;okay&quot;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fixed-link=
 {</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
speed =3D &lt;1000&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
full-duplex;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };</span><=
/p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mdio {</sp=
an></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
status =3D &quot;okay&quot;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
switch: switch@10 {</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
compatible =3D &quot;marvell,mv88e6190&quot;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
reg =3D &lt;0x10&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
ports {</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
#address-cells =3D &lt;1&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
#size-cells =3D &lt;0&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch0cpu: por=
t@0
{</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
reg =3D &lt;0&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
ethernet =3D &lt;&amp;gmac0&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
phy-mode =3D &quot;rgmii&quot;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
fixed-link {</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
speed =3D &lt;1000&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
full-duplex;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
};</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
};</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
port@1 {</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reg
=3D &lt;0x1&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
label =3D &quot;lan1&quot;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
};</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
port@2 {</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
reg =3D &lt;0x2&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
label =3D &quot;lan2&quot;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
};</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
port@3 {</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0reg
=3D &lt;0x3&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
label =3D &quot;lan3&quot;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
};</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
port@4 {</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
reg =3D &lt;0x4&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
label =3D &quot;lan4&quot;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
};</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
port@5 {</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
reg =3D &lt;0x5&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0label =3D &quot=
;lan5&quot;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
port@6 {</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
reg =3D &lt;0x6&gt;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
label =3D &quot;lan6&quot;;</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0=C2=A0=C2=A0};</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
};</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
};</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };</span><=
/p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif;c=
olor:rgb(68,114,196)">};</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
Regards</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
Simon</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in;font-size:12pt;font-family:Aptos=
,sans-serif"><span style=3D"font-size:11pt;font-family:Calibri,sans-serif">=
=C2=A0</span></p></div></div>

--00000000000008db8a0616ef3f11--
--00000000000008db8b0616ef3f13
Content-Type: text/plain; charset="US-ASCII"; 
	name="tcpdump_sama7_eth0_lan1_withping_from_laptop.txt"
Content-Disposition: attachment; 
	filename="tcpdump_sama7_eth0_lan1_withping_from_laptop.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lvfj124j1>
X-Attachment-Id: f_lvfj124j1

cm9vdEBzYW1hN2c1ZWstc2Q6fiMgdGNwZHVtcCAtaSBldGgwIC1lIC12DQp0Y3BkdW1wOiBsaXN0
ZW5pbmcgb24gZXRoMCwgbGluay10eXBlIERTQV9UQUdfRFNBIChNYXJ2ZWxsIERTQSksIHNuYXBz
aG90IGxlbmd0aCAyNjIxNDQgYnl0ZXMNCjE3OjUxOjA4LjA0OTI4MiAwNDo5MTo2MjpmMjpmZDox
YyAob3VpIFVua25vd24pID4gQnJvYWRjYXN0LCBNYXJ2ZWxsIERTQSBtb2RlIFRvIENQVSwgc291
cmNlIGRldiA4LCBwb3J0IDAsIGNvZGUgQlBEVSAoTUdNVCkgVHJhcCwgdW50YWdnZWQsIFZJRCAx
NDcyLCBGUHJpIDIsIDgwMi4zLCBsZW5ndGggMzA3OiBMTEMsIGRzYXAgTnVsbCAoMHgwMCkgSW5k
aXZpZHVhbCwgc3NhcCBOdWxsICgweDAwKSBDb21tYW5kLCBjdHJsIDB4MDAwMDogSW5mb3JtYXRp
b24sIHNlbmQgc2VxIDAsIHJjdiBzZXEgMCwgRmxhZ3MgW0NvbW1hbmRdLCBsZW5ndGggMzA3DQog
ICAgICAgIDB4MDAwMDogIDAwMDAgMDAwMCA0MDExIDc4ZjcgMDAwMCAwMDAwIGZmZmYgZmZmZiAg
Li4uLkAueC4uLi4uLi4uLg0KICAgICAgICAweDAwMTA6ICAwMDQ0IDAwNDMgMDEyMyBkODRiIDAx
MDEgMDYwMCA1ZGQ0IGE3NTIgIC5ELkMuIy5LLi4uLl0uLlINCiAgICAgICAgMHgwMDIwOiAgMDIw
MSAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwICAuLi4uLi4uLi4uLi4uLi4uDQog
ICAgICAgIDB4MDAzMDogIDAwMDAgMDAwMCAwNDkxIDYyZjIgZmQxYyAwMDAwIDAwMDAgMDAwMCAg
Li4uLi4uYi4uLi4uLi4uLg0KICAgICAgICAweDAwNDA6ICAwMDAwIDAwMDAgMDAwMCAwMDAwIDAw
MDAgMDAwMCAwMDAwIDAwMDAgIC4uLi4uLi4uLi4uLi4uLi4NCiAgICAgICAgMHgwMDUwOiAgMDAw
MCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwICAuLi4uLi4uLi4uLi4uLi4uDQog
ICAgICAgIDB4MDA2MDogIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAg
Li4uLi4uLi4uLi4uLi4uLg0KICAgICAgICAweDAwNzA6ICAwMDAwIDAwMDAgMDAwMCAwMDAwIDAw
MDAgMDAwMCAwMDAwIDAwMDAgIC4uLi4uLi4uLi4uLi4uLi4NCiAgICAgICAgMHgwMDgwOiAgMDAw
MCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwICAuLi4uLi4uLi4uLi4uLi4uDQog
ICAgICAgIDB4MDA5MDogIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAg
Li4uLi4uLi4uLi4uLi4uLg0KICAgICAgICAweDAwYTA6ICAwMDAwIDAwMDAgMDAwMCAwMDAwIDAw
MDAgMDAwMCAwMDAwIDAwMDAgIC4uLi4uLi4uLi4uLi4uLi4NCiAgICAgICAgMHgwMGIwOiAgMDAw
MCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwICAuLi4uLi4uLi4uLi4uLi4uDQog
ICAgICAgIDB4MDBjMDogIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAg
Li4uLi4uLi4uLi4uLi4uLg0KICAgICAgICAweDAwZDA6ICAwMDAwIDAwMDAgMDAwMCAwMDAwIDAw
MDAgMDAwMCAwMDAwIDAwMDAgIC4uLi4uLi4uLi4uLi4uLi4NCiAgICAgICAgMHgwMGUwOiAgMDAw
MCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwICAuLi4uLi4uLi4uLi4uLi4uDQog
ICAgICAgIDB4MDBmMDogIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAg
Li4uLi4uLi4uLi4uLi4uLg0KICAgICAgICAweDAxMDA6ICAwMDAwIDAwMDAgNjM4MiA1MzYzIDM1
MDEgMDEzZCAwNzAxIDA0OTEgIC4uLi5jLlNjNS4uPS4uLi4NCiAgICAgICAgMHgwMTEwOiAgNjJm
MiBmZDFjIDM3MGEgMDEwMyAwNjBjIDBmMWEgMjEyYSA3ODc5ICBiLi4uNy4uLi4uLi4hKnh5DQog
ICAgICAgIDB4MDEyMDogIDM5MDIgMDI0MCAwYzBjIDczNjEgNmQ2MSAzNzY3IDM1NjUgNmIyZCAg
OS4uQC4uc2FtYTdnNWVrLQ0KICAgICAgICAweDAxMzA6ICA3MzY0IGZmICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNkLg0KMTc6NTE6MDkuMTc3NTMwIGEwOjI5OjE5Ojg5OmM5OjRj
IChvdWkgVW5rbm93bikgPiBCcm9hZGNhc3QsIE1hcnZlbGwgRFNBIG1vZGUgRm9yd2FyZCwgZGV2
IDAsIHBvcnQgMSwgdW50YWdnZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBJUHY0ICgweDA4
MDApLCBsZW5ndGggOTY6ICh0b3MgMHgwLCB0dGwgMTI4LCBpZCA0NTUxLCBvZmZzZXQgMCwgZmxh
Z3MgW25vbmVdLCBwcm90byBVRFAgKDE3KSwgbGVuZ3RoIDc4KQ0KICAgIDE5Mi4xNjguMC4xMTUu
bmV0Ymlvcy1ucyA+IDE5Mi4xNjguMC4yNTUubmV0Ymlvcy1uczogVURQLCBsZW5ndGggNTANCjE3
OjUxOjA5LjE3NzUzMiBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pID4gMDE6MDA6NWU6
MDA6MDA6ZmIgKG91aSBVbmtub3duKSwgTWFydmVsbCBEU0EgbW9kZSBGb3J3YXJkLCBkZXYgMCwg
cG9ydCAxLCB1bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwgZXRoZXJ0eXBlIElQdjQgKDB4MDgwMCks
IGxlbmd0aCA4NTogKHRvcyAweDAsIHR0bCAxLCBpZCA0OTU3Niwgb2Zmc2V0IDAsIGZsYWdzIFtu
b25lXSwgcHJvdG8gVURQICgxNyksIGxlbmd0aCA2NykNCiAgICAxOTIuMTY4LjAuMTE1Lm1kbnMg
PiAyMjQuMC4wLjI1MS5tZG5zOiAwIEEgKFFNKT8gdXMyLXZwYXBwLXRhYzAxLmxvY2FsLiAoMzkp
DQoxNzo1MTowOS4xNzc1MzUgYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+IDMzOjMz
OjAwOjAwOjAwOmZiIChvdWkgVW5rbm93biksIE1hcnZlbGwgRFNBIG1vZGUgRm9yd2FyZCwgZGV2
IDAsIHBvcnQgMSwgdW50YWdnZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBJUHY2ICgweDg2
ZGQpLCBsZW5ndGggMTA1OiAoZmxvd2xhYmVsIDB4YWIyNmYsIGhsaW0gMSwgbmV4dC1oZWFkZXIg
VURQICgxNykgcGF5bG9hZCBsZW5ndGg6IDQ3KSBmZTgwOjpmNWQ1Ojg0ODg6YjA5MzoxMGJhLm1k
bnMgPiBmZjAyOjpmYi5tZG5zOiBbdWRwIHN1bSBva10gMCBBIChRTSk/IHVzMi12cGFwcC10YWMw
MS5sb2NhbC4gKDM5KQ0KMTc6NTE6MDkuMTc3NTM3IGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5r
bm93bikgPiAwMTowMDo1ZTowMDowMDpmYiAob3VpIFVua25vd24pLCBNYXJ2ZWxsIERTQSBtb2Rl
IEZvcndhcmQsIGRldiAwLCBwb3J0IDEsIHVudGFnZ2VkLCBWSUQgMCwgRlByaSAwLCBldGhlcnR5
cGUgSVB2NCAoMHgwODAwKSwgbGVuZ3RoIDg1OiAodG9zIDB4MCwgdHRsIDEsIGlkIDQ5NTc3LCBv
ZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAgKDE3KSwgbGVuZ3RoIDY3KQ0KICAgIDE5
Mi4xNjguMC4xMTUubWRucyA+IDIyNC4wLjAuMjUxLm1kbnM6IDAgQUFBQSAoUU0pPyB1czItdnBh
cHAtdGFjMDEubG9jYWwuICgzOSkNCjE3OjUxOjA5LjE3NzUzOCBhMDoyOToxOTo4OTpjOTo0YyAo
b3VpIFVua25vd24pID4gMzM6MzM6MDA6MDA6MDA6ZmIgKG91aSBVbmtub3duKSwgTWFydmVsbCBE
U0EgbW9kZSBGb3J3YXJkLCBkZXYgMCwgcG9ydCAxLCB1bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwg
ZXRoZXJ0eXBlIElQdjYgKDB4ODZkZCksIGxlbmd0aCAxMDU6IChmbG93bGFiZWwgMHhhYjI2Ziwg
aGxpbSAxLCBuZXh0LWhlYWRlciBVRFAgKDE3KSBwYXlsb2FkIGxlbmd0aDogNDcpIGZlODA6OmY1
ZDU6ODQ4ODpiMDkzOjEwYmEubWRucyA+IGZmMDI6OmZiLm1kbnM6IFt1ZHAgc3VtIG9rXSAwIEFB
QUEgKFFNKT8gdXMyLXZwYXBwLXRhYzAxLmxvY2FsLiAoMzkpDQoxNzo1MTowOS4xNzc1NDAgYTA6
Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+IDMzOjMzOjAwOjAxOjAwOjAzIChvdWkgVW5r
bm93biksIE1hcnZlbGwgRFNBIG1vZGUgRm9yd2FyZCwgZGV2IDAsIHBvcnQgMSwgdW50YWdnZWQs
IFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBJUHY2ICgweDg2ZGQpLCBsZW5ndGggOTk6IChmbG93
bGFiZWwgMHhkNmVmMSwgaGxpbSAxLCBuZXh0LWhlYWRlciBVRFAgKDE3KSBwYXlsb2FkIGxlbmd0
aDogNDEpIGZlODA6OmY1ZDU6ODQ4ODpiMDkzOjEwYmEuNjExMTIgPiBmZjAyOjoxOjMuNTM1NTog
W3VkcCBzdW0gb2tdIFVEUCwgbGVuZ3RoIDMzDQoxNzo1MTowOS4xNzc1NDIgYTA6Mjk6MTk6ODk6
Yzk6NGMgKG91aSBVbmtub3duKSA+IDAxOjAwOjVlOjAwOjAwOmZjIChvdWkgVW5rbm93biksIE1h
cnZlbGwgRFNBIG1vZGUgRm9yd2FyZCwgZGV2IDAsIHBvcnQgMSwgdW50YWdnZWQsIFZJRCAwLCBG
UHJpIDAsIGV0aGVydHlwZSBJUHY0ICgweDA4MDApLCBsZW5ndGggNzk6ICh0b3MgMHgwLCB0dGwg
MSwgaWQgMTkzMzMsIG9mZnNldCAwLCBmbGFncyBbbm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5n
dGggNjEpDQogICAgMTkyLjE2OC4wLjExNS42MTExMiA+IDIyNC4wLjAuMjUyLjUzNTU6IFVEUCwg
bGVuZ3RoIDMzDQoxNzo1MTowOS4xNzc1NDQgYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3du
KSA+IDMzOjMzOjAwOjAxOjAwOjAzIChvdWkgVW5rbm93biksIE1hcnZlbGwgRFNBIG1vZGUgRm9y
d2FyZCwgZGV2IDAsIHBvcnQgMSwgdW50YWdnZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBJ
UHY2ICgweDg2ZGQpLCBsZW5ndGggOTk6IChmbG93bGFiZWwgMHhiNjgzMSwgaGxpbSAxLCBuZXh0
LWhlYWRlciBVRFAgKDE3KSBwYXlsb2FkIGxlbmd0aDogNDEpIGZlODA6OmY1ZDU6ODQ4ODpiMDkz
OjEwYmEuNjMwMTggPiBmZjAyOjoxOjMuNTM1NTogW3VkcCBzdW0gb2tdIFVEUCwgbGVuZ3RoIDMz
DQoxNzo1MTowOS4xNzgxMTIgYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+IDAxOjAw
OjVlOjAwOjAwOmZjIChvdWkgVW5rbm93biksIE1hcnZlbGwgRFNBIG1vZGUgRm9yd2FyZCwgZGV2
IDAsIHBvcnQgMSwgdW50YWdnZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBJUHY0ICgweDA4
MDApLCBsZW5ndGggNzk6ICh0b3MgMHgwLCB0dGwgMSwgaWQgMTkzMzQsIG9mZnNldCAwLCBmbGFn
cyBbbm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggNjEpDQogICAgMTkyLjE2OC4wLjExNS42
MzAxOCA+IDIyNC4wLjAuMjUyLjUzNTU6IFVEUCwgbGVuZ3RoIDMzDQoxNzo1MTowOS45MTc5MDMg
YTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+IEJyb2FkY2FzdCwgTWFydmVsbCBEU0Eg
bW9kZSBGb3J3YXJkLCBkZXYgMCwgcG9ydCAxLCB1bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwgZXRo
ZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCA5NjogKHRvcyAweDAsIHR0bCAxMjgsIGlkIDQ1
NTIsIG9mZnNldCAwLCBmbGFncyBbbm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggNzgpDQog
ICAgMTkyLjE2OC4wLjExNS5uZXRiaW9zLW5zID4gMTkyLjE2OC4wLjI1NS5uZXRiaW9zLW5zOiBV
RFAsIGxlbmd0aCA1MA0KMTc6NTE6MTAuNjczODIzIGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5r
bm93bikgPiBCcm9hZGNhc3QsIE1hcnZlbGwgRFNBIG1vZGUgRm9yd2FyZCwgZGV2IDAsIHBvcnQg
MSwgdW50YWdnZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBJUHY0ICgweDA4MDApLCBsZW5n
dGggOTY6ICh0b3MgMHgwLCB0dGwgMTI4LCBpZCA0NTUzLCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVd
LCBwcm90byBVRFAgKDE3KSwgbGVuZ3RoIDc4KQ0KICAgIDE5Mi4xNjguMC4xMTUubmV0Ymlvcy1u
cyA+IDE5Mi4xNjguMC4yNTUubmV0Ymlvcy1uczogVURQLCBsZW5ndGggNTANCjE3OjUxOjI3Ljgx
MDcxMyBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pID4gMDQ6OTE6NjI6ZjI6ZmQ6MWMg
KG91aSBVbmtub3duKSwgTWFydmVsbCBEU0EgbW9kZSBGb3J3YXJkLCBkZXYgMCwgcG9ydCAxLCB1
bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwgZXRoZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCA3
ODogKHRvcyAweDAsIHR0bCAxMjgsIGlkIDM4MjU2LCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBw
cm90byBJQ01QICgxKSwgbGVuZ3RoIDYwKQ0KICAgIDE5Mi4xNjguMC4xMTUgPiBzYW1hN2c1ZWst
c2Q6IElDTVAgZWNobyByZXF1ZXN0LCBpZCAxLCBzZXEgMjAsIGxlbmd0aCA0MA0KMTc6NTE6Mjcu
ODExMjgxIDA0OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5rbm93bikgPiBhMDoyOToxOTo4OTpjOTo0
YyAob3VpIFVua25vd24pLCBNYXJ2ZWxsIERTQSBtb2RlIEZyb20gQ1BVLCB0YXJnZXQgZGV2IDAs
IHBvcnQgMSwgdW50YWdnZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBJUHY0ICgweDA4MDAp
LCBsZW5ndGggNzg6ICh0b3MgMHgwLCB0dGwgNjQsIGlkIDIzMTU3LCBvZmZzZXQgMCwgZmxhZ3Mg
W25vbmVdLCBwcm90byBJQ01QICgxKSwgbGVuZ3RoIDYwKQ0KICAgIHNhbWE3ZzVlay1zZCA+IDE5
Mi4xNjguMC4xMTU6IElDTVAgZWNobyByZXBseSwgaWQgMSwgc2VxIDIwLCBsZW5ndGggNDANCjE3
OjUxOjMyLjYyMjYwMyBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pID4gMDQ6OTE6NjI6
ZjI6ZmQ6MWMgKG91aSBVbmtub3duKSwgTWFydmVsbCBEU0EgbW9kZSBGb3J3YXJkLCBkZXYgMCwg
cG9ydCAxLCB1bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwgZXRoZXJ0eXBlIEFSUCAoMHgwODA2KSwg
bGVuZ3RoIDY0OiBFdGhlcm5ldCAobGVuIDYpLCBJUHY0IChsZW4gNCksIFJlcXVlc3Qgd2hvLWhh
cyBzYW1hN2c1ZWstc2QgKDA0OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5rbm93bikpIHRlbGwgMTky
LjE2OC4wLjExNSwgbGVuZ3RoIDQ2DQoxNzo1MTozMi42MjI5MzggMDQ6OTE6NjI6ZjI6ZmQ6MWMg
KG91aSBVbmtub3duKSA+IGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93biksIE1hcnZlbGwg
RFNBIG1vZGUgRnJvbSBDUFUsIHRhcmdldCBkZXYgMCwgcG9ydCAxLCB1bnRhZ2dlZCwgVklEIDAs
IEZQcmkgMCwgZXRoZXJ0eXBlIEFSUCAoMHgwODA2KSwgbGVuZ3RoIDQ2OiBFdGhlcm5ldCAobGVu
IDYpLCBJUHY0IChsZW4gNCksIFJlcGx5IHNhbWE3ZzVlay1zZCBpcy1hdCAwNDo5MTo2MjpmMjpm
ZDoxYyAob3VpIFVua25vd24pLCBsZW5ndGggMjgNCjE3OjUxOjMyLjY3MjA4NSBhMDoyOToxOTo4
OTpjOTo0YyAob3VpIFVua25vd24pID4gMDQ6OTE6NjI6ZjI6ZmQ6MWMgKG91aSBVbmtub3duKSwg
TWFydmVsbCBEU0EgbW9kZSBGb3J3YXJkLCBkZXYgMCwgcG9ydCAxLCB1bnRhZ2dlZCwgVklEIDAs
IEZQcmkgMCwgZXRoZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCA3ODogKHRvcyAweDAsIHR0
bCAxMjgsIGlkIDM4MjU3LCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBJQ01QICgxKSwg
bGVuZ3RoIDYwKQ0KICAgIDE5Mi4xNjguMC4xMTUgPiBzYW1hN2c1ZWstc2Q6IElDTVAgZWNobyBy
ZXF1ZXN0LCBpZCAxLCBzZXEgMjEsIGxlbmd0aCA0MA0KMTc6NTE6MzIuNjcyNTczIDA0OjkxOjYy
OmYyOmZkOjFjIChvdWkgVW5rbm93bikgPiBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24p
LCBNYXJ2ZWxsIERTQSBtb2RlIEZyb20gQ1BVLCB0YXJnZXQgZGV2IDAsIHBvcnQgMSwgdW50YWdn
ZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBJUHY0ICgweDA4MDApLCBsZW5ndGggNzg6ICh0
b3MgMHgwLCB0dGwgNjQsIGlkIDIzNDY4LCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBJ
Q01QICgxKSwgbGVuZ3RoIDYwKQ0KICAgIHNhbWE3ZzVlay1zZCA+IDE5Mi4xNjguMC4xMTU6IElD
TVAgZWNobyByZXBseSwgaWQgMSwgc2VxIDIxLCBsZW5ndGggNDANCjE3OjUxOjMyLjg4NjgwNSAw
NDo5MTo2MjpmMjpmZDoxYyAob3VpIFVua25vd24pID4gYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBV
bmtub3duKSwgTWFydmVsbCBEU0EgbW9kZSBGcm9tIENQVSwgdGFyZ2V0IGRldiAwLCBwb3J0IDEs
IHVudGFnZ2VkLCBWSUQgMCwgRlByaSAwLCBldGhlcnR5cGUgQVJQICgweDA4MDYpLCBsZW5ndGgg
NDY6IEV0aGVybmV0IChsZW4gNiksIElQdjQgKGxlbiA0KSwgUmVxdWVzdCB3aG8taGFzIDE5Mi4x
NjguMC4xMTUgdGVsbCBzYW1hN2c1ZWstc2QsIGxlbmd0aCAyOA0KMTc6NTE6MzMuNjE4Mjg4IGEw
OjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93bikgPiAwNDo5MTo2MjpmMjpmZDoxYyAob3VpIFVu
a25vd24pLCBNYXJ2ZWxsIERTQSBtb2RlIEZvcndhcmQsIGRldiAwLCBwb3J0IDEsIHVudGFnZ2Vk
LCBWSUQgMCwgRlByaSAwLCBldGhlcnR5cGUgQVJQICgweDA4MDYpLCBsZW5ndGggNjQ6IEV0aGVy
bmV0IChsZW4gNiksIElQdjQgKGxlbiA0KSwgUmVxdWVzdCB3aG8taGFzIHNhbWE3ZzVlay1zZCAo
MDQ6OTE6NjI6ZjI6ZmQ6MWMgKG91aSBVbmtub3duKSkgdGVsbCAxOTIuMTY4LjAuMTE1LCBsZW5n
dGggNDYNCjE3OjUxOjMzLjYxODU4OSAwNDo5MTo2MjpmMjpmZDoxYyAob3VpIFVua25vd24pID4g
YTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSwgTWFydmVsbCBEU0EgbW9kZSBGcm9tIENQ
VSwgdGFyZ2V0IGRldiAwLCBwb3J0IDEsIHVudGFnZ2VkLCBWSUQgMCwgRlByaSAwLCBldGhlcnR5
cGUgQVJQICgweDA4MDYpLCBsZW5ndGggNDY6IEV0aGVybmV0IChsZW4gNiksIElQdjQgKGxlbiA0
KSwgUmVwbHkgc2FtYTdnNWVrLXNkIGlzLWF0IDA0OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5rbm93
biksIGxlbmd0aCAyOA0KMTc6NTE6MzMuOTI2Nzc4IDA0OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5r
bm93bikgPiBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pLCBNYXJ2ZWxsIERTQSBtb2Rl
IEZyb20gQ1BVLCB0YXJnZXQgZGV2IDAsIHBvcnQgMSwgdW50YWdnZWQsIFZJRCAwLCBGUHJpIDAs
IGV0aGVydHlwZSBBUlAgKDB4MDgwNiksIGxlbmd0aCA0NjogRXRoZXJuZXQgKGxlbiA2KSwgSVB2
NCAobGVuIDQpLCBSZXF1ZXN0IHdoby1oYXMgMTkyLjE2OC4wLjExNSB0ZWxsIHNhbWE3ZzVlay1z
ZCwgbGVuZ3RoIDI4DQoxNzo1MTozNC42MjA1OTMgYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtu
b3duKSA+IDA0OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5rbm93biksIE1hcnZlbGwgRFNBIG1vZGUg
Rm9yd2FyZCwgZGV2IDAsIHBvcnQgMSwgdW50YWdnZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlw
ZSBBUlAgKDB4MDgwNiksIGxlbmd0aCA2NDogRXRoZXJuZXQgKGxlbiA2KSwgSVB2NCAobGVuIDQp
LCBSZXF1ZXN0IHdoby1oYXMgc2FtYTdnNWVrLXNkICgwNDo5MTo2MjpmMjpmZDoxYyAob3VpIFVu
a25vd24pKSB0ZWxsIDE5Mi4xNjguMC4xMTUsIGxlbmd0aCA0Ng0KMTc6NTE6MzQuNjIwODc4IDA0
OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5rbm93bikgPiBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVu
a25vd24pLCBNYXJ2ZWxsIERTQSBtb2RlIEZyb20gQ1BVLCB0YXJnZXQgZGV2IDAsIHBvcnQgMSwg
dW50YWdnZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBBUlAgKDB4MDgwNiksIGxlbmd0aCA0
NjogRXRoZXJuZXQgKGxlbiA2KSwgSVB2NCAobGVuIDQpLCBSZXBseSBzYW1hN2c1ZWstc2QgaXMt
YXQgMDQ6OTE6NjI6ZjI6ZmQ6MWMgKG91aSBVbmtub3duKSwgbGVuZ3RoIDI4DQoxNzo1MTozNC45
NjY3NzMgMDQ6OTE6NjI6ZjI6ZmQ6MWMgKG91aSBVbmtub3duKSA+IGEwOjI5OjE5Ojg5OmM5OjRj
IChvdWkgVW5rbm93biksIE1hcnZlbGwgRFNBIG1vZGUgRnJvbSBDUFUsIHRhcmdldCBkZXYgMCwg
cG9ydCAxLCB1bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwgZXRoZXJ0eXBlIEFSUCAoMHgwODA2KSwg
bGVuZ3RoIDQ2OiBFdGhlcm5ldCAobGVuIDYpLCBJUHY0IChsZW4gNCksIFJlcXVlc3Qgd2hvLWhh
cyAxOTIuMTY4LjAuMTE1IHRlbGwgc2FtYTdnNWVrLXNkLCBsZW5ndGggMjgNCjE3OjUxOjM3LjY1
MDE4MiBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pID4gMDQ6OTE6NjI6ZjI6ZmQ6MWMg
KG91aSBVbmtub3duKSwgTWFydmVsbCBEU0EgbW9kZSBGb3J3YXJkLCBkZXYgMCwgcG9ydCAxLCB1
bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwgZXRoZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCA3
ODogKHRvcyAweDAsIHR0bCAxMjgsIGlkIDM4MjU4LCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBw
cm90byBJQ01QICgxKSwgbGVuZ3RoIDYwKQ0KICAgIDE5Mi4xNjguMC4xMTUgPiBzYW1hN2c1ZWst
c2Q6IElDTVAgZWNobyByZXF1ZXN0LCBpZCAxLCBzZXEgMjIsIGxlbmd0aCA0MA0KMTc6NTE6Mzcu
NjUwNzE5IDA0OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5rbm93bikgPiBCcm9hZGNhc3QsIE1hcnZl
bGwgRFNBIG1vZGUgRnJvbSBDUFUsIHRhcmdldCBkZXYgMCwgcG9ydCAxLCB1bnRhZ2dlZCwgVklE
IDAsIEZQcmkgMCwgZXRoZXJ0eXBlIEFSUCAoMHgwODA2KSwgbGVuZ3RoIDQ2OiBFdGhlcm5ldCAo
bGVuIDYpLCBJUHY0IChsZW4gNCksIFJlcXVlc3Qgd2hvLWhhcyAxOTIuMTY4LjAuMTE1IHRlbGwg
c2FtYTdnNWVrLXNkLCBsZW5ndGggMjgNCjE3OjUxOjM3Ljc4OTM5NiBhMDoyOToxOTo4OTpjOTo0
YyAob3VpIFVua25vd24pID4gMDE6MDA6NWU6N2Y6ZmY6ZmEgKG91aSBVbmtub3duKSwgTWFydmVs
bCBEU0EgbW9kZSBGb3J3YXJkLCBkZXYgMCwgcG9ydCAxLCB1bnRhZ2dlZCwgVklEIDAsIEZQcmkg
MCwgZXRoZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCAyMjA6ICh0b3MgMHgwLCB0dGwgMSwg
aWQgNTc2MjksIG9mZnNldCAwLCBmbGFncyBbbm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGgg
MjAyKQ0KICAgIDE5Mi4xNjguMC4xMTUuNTg1MjggPiAyMzkuMjU1LjI1NS4yNTAuMTkwMDogVURQ
LCBsZW5ndGggMTc0DQoxNzo1MTozNy43ODk2NzIgYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtu
b3duKSA+IDAxOjAwOjVlOjdmOmZmOmZhIChvdWkgVW5rbm93biksIE1hcnZlbGwgRFNBIG1vZGUg
Rm9yd2FyZCwgZGV2IDAsIHBvcnQgMSwgdW50YWdnZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlw
ZSBJUHY0ICgweDA4MDApLCBsZW5ndGggMjIxOiAodG9zIDB4MCwgdHRsIDEsIGlkIDU3NjMwLCBv
ZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAgKDE3KSwgbGVuZ3RoIDIwMykNCiAgICAx
OTIuMTY4LjAuMTE1LjU4NTMxID4gMjM5LjI1NS4yNTUuMjUwLjE5MDA6IFVEUCwgbGVuZ3RoIDE3
NQ0KMTc6NTE6MzguNzI2OTIxIDA0OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5rbm93bikgPiBCcm9h
ZGNhc3QsIE1hcnZlbGwgRFNBIG1vZGUgRnJvbSBDUFUsIHRhcmdldCBkZXYgMCwgcG9ydCAxLCB1
bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwgZXRoZXJ0eXBlIEFSUCAoMHgwODA2KSwgbGVuZ3RoIDQ2
OiBFdGhlcm5ldCAobGVuIDYpLCBJUHY0IChsZW4gNCksIFJlcXVlc3Qgd2hvLWhhcyAxOTIuMTY4
LjAuMTE1IHRlbGwgc2FtYTdnNWVrLXNkLCBsZW5ndGggMjgNCjE3OjUxOjM4LjgwMDY1OCBhMDoy
OToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pID4gMDE6MDA6NWU6N2Y6ZmY6ZmEgKG91aSBVbmtu
b3duKSwgTWFydmVsbCBEU0EgbW9kZSBGb3J3YXJkLCBkZXYgMCwgcG9ydCAxLCB1bnRhZ2dlZCwg
VklEIDAsIEZQcmkgMCwgZXRoZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCAyMjA6ICh0b3Mg
MHgwLCB0dGwgMSwgaWQgNTc2MzEsIG9mZnNldCAwLCBmbGFncyBbbm9uZV0sIHByb3RvIFVEUCAo
MTcpLCBsZW5ndGggMjAyKQ0KICAgIDE5Mi4xNjguMC4xMTUuNTg1MjggPiAyMzkuMjU1LjI1NS4y
NTAuMTkwMDogVURQLCBsZW5ndGggMTc0DQoxNzo1MTozOC44MDA2NjEgYTA6Mjk6MTk6ODk6Yzk6
NGMgKG91aSBVbmtub3duKSA+IDAxOjAwOjVlOjdmOmZmOmZhIChvdWkgVW5rbm93biksIE1hcnZl
bGwgRFNBIG1vZGUgRm9yd2FyZCwgZGV2IDAsIHBvcnQgMSwgdW50YWdnZWQsIFZJRCAwLCBGUHJp
IDAsIGV0aGVydHlwZSBJUHY0ICgweDA4MDApLCBsZW5ndGggMjIxOiAodG9zIDB4MCwgdHRsIDEs
IGlkIDU3NjMyLCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAgKDE3KSwgbGVuZ3Ro
IDIwMykNCiAgICAxOTIuMTY4LjAuMTE1LjU4NTMxID4gMjM5LjI1NS4yNTUuMjUwLjE5MDA6IFVE
UCwgbGVuZ3RoIDE3NQ0KMTc6NTE6MzkuNzY2NjgxIDA0OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5r
bm93bikgPiBCcm9hZGNhc3QsIE1hcnZlbGwgRFNBIG1vZGUgRnJvbSBDUFUsIHRhcmdldCBkZXYg
MCwgcG9ydCAxLCB1bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwgZXRoZXJ0eXBlIEFSUCAoMHgwODA2
KSwgbGVuZ3RoIDQ2OiBFdGhlcm5ldCAobGVuIDYpLCBJUHY0IChsZW4gNCksIFJlcXVlc3Qgd2hv
LWhhcyAxOTIuMTY4LjAuMTE1IHRlbGwgc2FtYTdnNWVrLXNkLCBsZW5ndGggMjgNCjE3OjUxOjM5
LjgwMzU3MSBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pID4gMDE6MDA6NWU6N2Y6ZmY6
ZmEgKG91aSBVbmtub3duKSwgTWFydmVsbCBEU0EgbW9kZSBGb3J3YXJkLCBkZXYgMCwgcG9ydCAx
LCB1bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwgZXRoZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0
aCAyMjA6ICh0b3MgMHgwLCB0dGwgMSwgaWQgNTc2MzMsIG9mZnNldCAwLCBmbGFncyBbbm9uZV0s
IHByb3RvIFVEUCAoMTcpLCBsZW5ndGggMjAyKQ0KICAgIDE5Mi4xNjguMC4xMTUuNTg1MjggPiAy
MzkuMjU1LjI1NS4yNTAuMTkwMDogVURQLCBsZW5ndGggMTc0DQoxNzo1MTozOS44MDM1NzQgYTA6
Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+IDAxOjAwOjVlOjdmOmZmOmZhIChvdWkgVW5r
bm93biksIE1hcnZlbGwgRFNBIG1vZGUgRm9yd2FyZCwgZGV2IDAsIHBvcnQgMSwgdW50YWdnZWQs
IFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBJUHY0ICgweDA4MDApLCBsZW5ndGggMjIxOiAodG9z
IDB4MCwgdHRsIDEsIGlkIDU3NjM0LCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAg
KDE3KSwgbGVuZ3RoIDIwMykNCiAgICAxOTIuMTY4LjAuMTE1LjU4NTMxID4gMjM5LjI1NS4yNTUu
MjUwLjE5MDA6IFVEUCwgbGVuZ3RoIDE3NQ0KMTc6NTE6NDAuODA1MTQ4IGEwOjI5OjE5Ojg5OmM5
OjRjIChvdWkgVW5rbm93bikgPiAwMTowMDo1ZTo3ZjpmZjpmYSAob3VpIFVua25vd24pLCBNYXJ2
ZWxsIERTQSBtb2RlIEZvcndhcmQsIGRldiAwLCBwb3J0IDEsIHVudGFnZ2VkLCBWSUQgMCwgRlBy
aSAwLCBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwgbGVuZ3RoIDIyMDogKHRvcyAweDAsIHR0bCAx
LCBpZCA1NzYzNiwgb2Zmc2V0IDAsIGZsYWdzIFtub25lXSwgcHJvdG8gVURQICgxNyksIGxlbmd0
aCAyMDIpDQogICAgMTkyLjE2OC4wLjExNS41ODUyOCA+IDIzOS4yNTUuMjU1LjI1MC4xOTAwOiBV
RFAsIGxlbmd0aCAxNzQNCjE3OjUxOjQwLjgwNTE1MSBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVu
a25vd24pID4gMDE6MDA6NWU6N2Y6ZmY6ZmEgKG91aSBVbmtub3duKSwgTWFydmVsbCBEU0EgbW9k
ZSBGb3J3YXJkLCBkZXYgMCwgcG9ydCAxLCB1bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwgZXRoZXJ0
eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCAyMjE6ICh0b3MgMHgwLCB0dGwgMSwgaWQgNTc2MzUs
IG9mZnNldCAwLCBmbGFncyBbbm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggMjAzKQ0KICAg
IDE5Mi4xNjguMC4xMTUuNTg1MzEgPiAyMzkuMjU1LjI1NS4yNTAuMTkwMDogVURQLCBsZW5ndGgg
MTc1DQoxNzo1MTo0Mi42MjUwNTEgYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+IDA0
OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5rbm93biksIE1hcnZlbGwgRFNBIG1vZGUgRm9yd2FyZCwg
ZGV2IDAsIHBvcnQgMSwgdW50YWdnZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBJUHY0ICgw
eDA4MDApLCBsZW5ndGggNzg6ICh0b3MgMHgwLCB0dGwgMTI4LCBpZCAzODI1OSwgb2Zmc2V0IDAs
IGZsYWdzIFtub25lXSwgcHJvdG8gSUNNUCAoMSksIGxlbmd0aCA2MCkNCiAgICAxOTIuMTY4LjAu
MTE1ID4gc2FtYTdnNWVrLXNkOiBJQ01QIGVjaG8gcmVxdWVzdCwgaWQgMSwgc2VxIDIzLCBsZW5n
dGggNDANCjE3OjUxOjQyLjYyNTU4NSAwNDo5MTo2MjpmMjpmZDoxYyAob3VpIFVua25vd24pID4g
QnJvYWRjYXN0LCBNYXJ2ZWxsIERTQSBtb2RlIEZyb20gQ1BVLCB0YXJnZXQgZGV2IDAsIHBvcnQg
MSwgdW50YWdnZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBBUlAgKDB4MDgwNiksIGxlbmd0
aCA0NjogRXRoZXJuZXQgKGxlbiA2KSwgSVB2NCAobGVuIDQpLCBSZXF1ZXN0IHdoby1oYXMgMTky
LjE2OC4wLjExNSB0ZWxsIHNhbWE3ZzVlay1zZCwgbGVuZ3RoIDI4DQoxNzo1MTo0My42ODY3Njgg
MDQ6OTE6NjI6ZjI6ZmQ6MWMgKG91aSBVbmtub3duKSA+IEJyb2FkY2FzdCwgTWFydmVsbCBEU0Eg
bW9kZSBGcm9tIENQVSwgdGFyZ2V0IGRldiAwLCBwb3J0IDEsIHVudGFnZ2VkLCBWSUQgMCwgRlBy
aSAwLCBldGhlcnR5cGUgQVJQICgweDA4MDYpLCBsZW5ndGggNDY6IEV0aGVybmV0IChsZW4gNiks
IElQdjQgKGxlbiA0KSwgUmVxdWVzdCB3aG8taGFzIDE5Mi4xNjguMC4xMTUgdGVsbCBzYW1hN2c1
ZWstc2QsIGxlbmd0aCAyOA0KMTc6NTE6NDQuNzI2Nzg5IDA0OjkxOjYyOmYyOmZkOjFjIChvdWkg
VW5rbm93bikgPiBCcm9hZGNhc3QsIE1hcnZlbGwgRFNBIG1vZGUgRnJvbSBDUFUsIHRhcmdldCBk
ZXYgMCwgcG9ydCAxLCB1bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwgZXRoZXJ0eXBlIEFSUCAoMHgw
ODA2KSwgbGVuZ3RoIDQ2OiBFdGhlcm5ldCAobGVuIDYpLCBJUHY0IChsZW4gNCksIFJlcXVlc3Qg
d2hvLWhhcyAxOTIuMTY4LjAuMTE1IHRlbGwgc2FtYTdnNWVrLXNkLCBsZW5ndGggMjgNCjE3OjUx
OjQ0Ljk2MTc0MSBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pID4gMDE6MDA6NWU6N2Y6
ZmY6ZmEgKG91aSBVbmtub3duKSwgTWFydmVsbCBEU0EgbW9kZSBGb3J3YXJkLCBkZXYgMCwgcG9y
dCAxLCB1bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwgZXRoZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxl
bmd0aCAxODM6ICh0b3MgMHgwLCB0dGwgNCwgaWQgNTc2MzcsIG9mZnNldCAwLCBmbGFncyBbbm9u
ZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggMTY1KQ0KICAgIDE5Mi4xNjguMC4xMTUuNDk4NDcg
PiAyMzkuMjU1LjI1NS4yNTAuMTkwMDogVURQLCBsZW5ndGggMTM3DQoxNzo1MTo0Ny45NjEyNTAg
YTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+IDAxOjAwOjVlOjdmOmZmOmZhIChvdWkg
VW5rbm93biksIE1hcnZlbGwgRFNBIG1vZGUgRm9yd2FyZCwgZGV2IDAsIHBvcnQgMSwgdW50YWdn
ZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBJUHY0ICgweDA4MDApLCBsZW5ndGggMTgzOiAo
dG9zIDB4MCwgdHRsIDQsIGlkIDU3NjM4LCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBV
RFAgKDE3KSwgbGVuZ3RoIDE2NSkNCiAgICAxOTIuMTY4LjAuMTE1LjQ5ODQ3ID4gMjM5LjI1NS4y
NTUuMjUwLjE5MDA6IFVEUCwgbGVuZ3RoIDEzNw0KMTc6NTE6NTAuOTY2Mzg3IGEwOjI5OjE5Ojg5
OmM5OjRjIChvdWkgVW5rbm93bikgPiAwMTowMDo1ZTo3ZjpmZjpmYSAob3VpIFVua25vd24pLCBN
YXJ2ZWxsIERTQSBtb2RlIEZvcndhcmQsIGRldiAwLCBwb3J0IDEsIHVudGFnZ2VkLCBWSUQgMCwg
RlByaSAwLCBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwgbGVuZ3RoIDE4MzogKHRvcyAweDAsIHR0
bCA0LCBpZCA1NzYzOSwgb2Zmc2V0IDAsIGZsYWdzIFtub25lXSwgcHJvdG8gVURQICgxNyksIGxl
bmd0aCAxNjUpDQogICAgMTkyLjE2OC4wLjExNS40OTg0NyA+IDIzOS4yNTUuMjU1LjI1MC4xOTAw
OiBVRFAsIGxlbmd0aCAxMzcNCjE3OjUxOjUzLjk4MzkyMiBhMDoyOToxOTo4OTpjOTo0YyAob3Vp
IFVua25vd24pID4gMDE6MDA6NWU6N2Y6ZmY6ZmEgKG91aSBVbmtub3duKSwgTWFydmVsbCBEU0Eg
bW9kZSBGb3J3YXJkLCBkZXYgMCwgcG9ydCAxLCB1bnRhZ2dlZCwgVklEIDAsIEZQcmkgMCwgZXRo
ZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCAxODM6ICh0b3MgMHgwLCB0dGwgNCwgaWQgNTc2
NDAsIG9mZnNldCAwLCBmbGFncyBbbm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggMTY1KQ0K
ICAgIDE5Mi4xNjguMC4xMTUuNDk4NDcgPiAyMzkuMjU1LjI1NS4yNTAuMTkwMDogVURQLCBsZW5n
dGggMTM3DQoxNzo1MTo1Ni45NzY4MDIgYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+
IDAxOjAwOjVlOjdmOmZmOmZhIChvdWkgVW5rbm93biksIE1hcnZlbGwgRFNBIG1vZGUgRm9yd2Fy
ZCwgZGV2IDAsIHBvcnQgMSwgdW50YWdnZWQsIFZJRCAwLCBGUHJpIDAsIGV0aGVydHlwZSBJUHY0
ICgweDA4MDApLCBsZW5ndGggMTgzOiAodG9zIDB4MCwgdHRsIDQsIGlkIDU3NjQxLCBvZmZzZXQg
MCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAgKDE3KSwgbGVuZ3RoIDE2NSkNCiAgICAxOTIuMTY4
LjAuMTE1LjQ5ODQ3ID4gMjM5LjI1NS4yNTUuMjUwLjE5MDA6IFVEUCwgbGVuZ3RoIDEzNw0KMTc6
NTE6NTkuOTg0MTg3IGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93bikgPiAwMTowMDo1ZTo3
ZjpmZjpmYSAob3VpIFVua25vd24pLCBNYXJ2ZWxsIERTQSBtb2RlIEZvcndhcmQsIGRldiAwLCBw
b3J0IDEsIHVudGFnZ2VkLCBWSUQgMCwgRlByaSAwLCBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwg
bGVuZ3RoIDE4MzogKHRvcyAweDAsIHR0bCA0LCBpZCA1NzY0Miwgb2Zmc2V0IDAsIGZsYWdzIFtu
b25lXSwgcHJvdG8gVURQICgxNyksIGxlbmd0aCAxNjUpDQogICAgMTkyLjE2OC4wLjExNS40OTg0
NyA+IDIzOS4yNTUuMjU1LjI1MC4xOTAwOiBVRFAsIGxlbmd0aCAxMzcNCg0KDQoNCg0KDQoNCg0K
cm9vdEBzYW1hN2c1ZWstc2Q6fiMgdGNwZHVtcCAtaSBsYW4xIC1lIC12DQpkZXZpY2UgbGFuMSBl
bnRlcmVkIHByb21pc2N1b3VzIG1vZGUNCnRjcGR1bXA6IGxpc3RlbmluZyBvbiBsYW4xLCBsaW5r
LXR5cGUgRU4xME1CIChFdGhlcm5ldCksIHNuYXBzaG90IGxlbmd0aCAyNjIxNDQgYnl0ZXMNCjE3
OjUyOjM4LjkxNzQzNCBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pID4gQnJvYWRjYXN0
LCBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwgbGVuZ3RoIDIxNjogKHRvcyAweDAsIHR0bCAxMjgs
IGlkIDQ1NTcsIG9mZnNldCAwLCBmbGFncyBbbm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGgg
MjAyKQ0KICAgIDE5Mi4xNjguMC4xMTUubmV0Ymlvcy1kZ20gPiAxOTIuMTY4LjAuMjU1Lm5ldGJp
b3MtZGdtOiBVRFAsIGxlbmd0aCAxNzQNCjE3OjUyOjM4LjkxNzQzOCBhMDoyOToxOTo4OTpjOTo0
YyAob3VpIFVua25vd24pID4gQnJvYWRjYXN0LCBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwgbGVu
Z3RoIDkyOiAodG9zIDB4MCwgdHRsIDEyOCwgaWQgNDU1OCwgb2Zmc2V0IDAsIGZsYWdzIFtub25l
XSwgcHJvdG8gVURQICgxNyksIGxlbmd0aCA3OCkNCiAgICAxOTIuMTY4LjAuMTE1Lm5ldGJpb3Mt
bnMgPiAxOTIuMTY4LjAuMjU1Lm5ldGJpb3MtbnM6IFVEUCwgbGVuZ3RoIDUwDQoxNzo1MjozOS42
NzA5NTMgYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+IEJyb2FkY2FzdCwgZXRoZXJ0
eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCA5MjogKHRvcyAweDAsIHR0bCAxMjgsIGlkIDQ1NTks
IG9mZnNldCAwLCBmbGFncyBbbm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggNzgpDQogICAg
MTkyLjE2OC4wLjExNS5uZXRiaW9zLW5zID4gMTkyLjE2OC4wLjI1NS5uZXRiaW9zLW5zOiBVRFAs
IGxlbmd0aCA1MA0KMTc6NTI6NDAuNDI2NzU4IGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93
bikgPiBCcm9hZGNhc3QsIGV0aGVydHlwZSBJUHY0ICgweDA4MDApLCBsZW5ndGggOTI6ICh0b3Mg
MHgwLCB0dGwgMTI4LCBpZCA0NTYwLCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAg
KDE3KSwgbGVuZ3RoIDc4KQ0KICAgIDE5Mi4xNjguMC4xMTUubmV0Ymlvcy1ucyA+IDE5Mi4xNjgu
MC4yNTUubmV0Ymlvcy1uczogVURQLCBsZW5ndGggNTANCjE3OjUyOjQyLjE5NDIzOCBhMDoyOTox
OTo4OTpjOTo0YyAob3VpIFVua25vd24pID4gQnJvYWRjYXN0LCBldGhlcnR5cGUgSVB2NCAoMHgw
ODAwKSwgbGVuZ3RoIDIxNjogKHRvcyAweDAsIHR0bCAxMjgsIGlkIDQ1NjEsIG9mZnNldCAwLCBm
bGFncyBbbm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggMjAyKQ0KICAgIDE5Mi4xNjguMC4x
MTUubmV0Ymlvcy1kZ20gPiAxOTIuMTY4LjAuMjU1Lm5ldGJpb3MtZGdtOiBVRFAsIGxlbmd0aCAx
NzQNCjE3OjUyOjQyLjE5NDI0MSBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pID4gQnJv
YWRjYXN0LCBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwgbGVuZ3RoIDkyOiAodG9zIDB4MCwgdHRs
IDEyOCwgaWQgNDU2Miwgb2Zmc2V0IDAsIGZsYWdzIFtub25lXSwgcHJvdG8gVURQICgxNyksIGxl
bmd0aCA3OCkNCiAgICAxOTIuMTY4LjAuMTE1Lm5ldGJpb3MtbnMgPiAxOTIuMTY4LjAuMjU1Lm5l
dGJpb3MtbnM6IFVEUCwgbGVuZ3RoIDUwDQoxNzo1Mjo0Mi45NTExNjYgYTA6Mjk6MTk6ODk6Yzk6
NGMgKG91aSBVbmtub3duKSA+IEJyb2FkY2FzdCwgZXRoZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxl
bmd0aCA5MjogKHRvcyAweDAsIHR0bCAxMjgsIGlkIDQ1NjMsIG9mZnNldCAwLCBmbGFncyBbbm9u
ZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggNzgpDQogICAgMTkyLjE2OC4wLjExNS5uZXRiaW9z
LW5zID4gMTkyLjE2OC4wLjI1NS5uZXRiaW9zLW5zOiBVRFAsIGxlbmd0aCA1MA0KMTc6NTI6NDMu
NzIxNzIxIGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93bikgPiBCcm9hZGNhc3QsIGV0aGVy
dHlwZSBJUHY0ICgweDA4MDApLCBsZW5ndGggOTI6ICh0b3MgMHgwLCB0dGwgMTI4LCBpZCA0NTY0
LCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAgKDE3KSwgbGVuZ3RoIDc4KQ0KICAg
IDE5Mi4xNjguMC4xMTUubmV0Ymlvcy1ucyA+IDE5Mi4xNjguMC4yNTUubmV0Ymlvcy1uczogVURQ
LCBsZW5ndGggNTANCjE3OjUyOjQ1LjMzNTE5MSBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25v
d24pID4gMDE6MDA6NWU6N2Y6ZmY6ZmEgKG91aSBVbmtub3duKSwgZXRoZXJ0eXBlIElQdjQgKDB4
MDgwMCksIGxlbmd0aCAxNzk6ICh0b3MgMHgwLCB0dGwgNCwgaWQgNTc2NTIsIG9mZnNldCAwLCBm
bGFncyBbbm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggMTY1KQ0KICAgIDE5Mi4xNjguMC4x
MTUuNDk4NDcgPiAyMzkuMjU1LjI1NS4yNTAuMTkwMDogVURQLCBsZW5ndGggMTM3DQoxNzo1Mjo0
NS40ODk0NzggYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+IEJyb2FkY2FzdCwgZXRo
ZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCAyMTY6ICh0b3MgMHgwLCB0dGwgMTI4LCBpZCA0
NTY1LCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAgKDE3KSwgbGVuZ3RoIDIwMikN
CiAgICAxOTIuMTY4LjAuMTE1Lm5ldGJpb3MtZGdtID4gMTkyLjE2OC4wLjI1NS5uZXRiaW9zLWRn
bTogVURQLCBsZW5ndGggMTc0DQoxNzo1Mjo0NS40ODk0ODIgYTA6Mjk6MTk6ODk6Yzk6NGMgKG91
aSBVbmtub3duKSA+IEJyb2FkY2FzdCwgZXRoZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCA5
MjogKHRvcyAweDAsIHR0bCAxMjgsIGlkIDQ1NjYsIG9mZnNldCAwLCBmbGFncyBbbm9uZV0sIHBy
b3RvIFVEUCAoMTcpLCBsZW5ndGggNzgpDQogICAgMTkyLjE2OC4wLjExNS5uZXRiaW9zLW5zID4g
MTkyLjE2OC4wLjI1NS5uZXRiaW9zLW5zOiBVRFAsIGxlbmd0aCA1MA0KMTc6NTI6NDYuMjU5NTM3
IGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93bikgPiBCcm9hZGNhc3QsIGV0aGVydHlwZSBJ
UHY0ICgweDA4MDApLCBsZW5ndGggOTI6ICh0b3MgMHgwLCB0dGwgMTI4LCBpZCA0NTY3LCBvZmZz
ZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAgKDE3KSwgbGVuZ3RoIDc4KQ0KICAgIDE5Mi4x
NjguMC4xMTUubmV0Ymlvcy1ucyA+IDE5Mi4xNjguMC4yNTUubmV0Ymlvcy1uczogVURQLCBsZW5n
dGggNTANCjE3OjUyOjQ3LjAyMzkyNSBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pID4g
QnJvYWRjYXN0LCBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwgbGVuZ3RoIDkyOiAodG9zIDB4MCwg
dHRsIDEyOCwgaWQgNDU2OCwgb2Zmc2V0IDAsIGZsYWdzIFtub25lXSwgcHJvdG8gVURQICgxNyks
IGxlbmd0aCA3OCkNCiAgICAxOTIuMTY4LjAuMTE1Lm5ldGJpb3MtbnMgPiAxOTIuMTY4LjAuMjU1
Lm5ldGJpb3MtbnM6IFVEUCwgbGVuZ3RoIDUwDQoxNzo1Mjo0OC4zNDQ2MzggYTA6Mjk6MTk6ODk6
Yzk6NGMgKG91aSBVbmtub3duKSA+IDAxOjAwOjVlOjdmOmZmOmZhIChvdWkgVW5rbm93biksIGV0
aGVydHlwZSBJUHY0ICgweDA4MDApLCBsZW5ndGggMTc5OiAodG9zIDB4MCwgdHRsIDQsIGlkIDU3
NjUzLCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAgKDE3KSwgbGVuZ3RoIDE2NSkN
CiAgICAxOTIuMTY4LjAuMTE1LjQ5ODQ3ID4gMjM5LjI1NS4yNTUuMjUwLjE5MDA6IFVEUCwgbGVu
Z3RoIDEzNw0KMTc6NTI6NDguNzgzNzcwIGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93bikg
PiBCcm9hZGNhc3QsIGV0aGVydHlwZSBJUHY0ICgweDA4MDApLCBsZW5ndGggOTI6ICh0b3MgMHgw
LCB0dGwgMTI4LCBpZCA0NTY5LCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAgKDE3
KSwgbGVuZ3RoIDc4KQ0KICAgIDE5Mi4xNjguMC4xMTUubmV0Ymlvcy1ucyA+IDE5Mi4xNjguMC4y
NTUubmV0Ymlvcy1uczogVURQLCBsZW5ndGggNTANCjE3OjUyOjQ5LjU0ODYyMSBhMDoyOToxOTo4
OTpjOTo0YyAob3VpIFVua25vd24pID4gQnJvYWRjYXN0LCBldGhlcnR5cGUgSVB2NCAoMHgwODAw
KSwgbGVuZ3RoIDkyOiAodG9zIDB4MCwgdHRsIDEyOCwgaWQgNDU3MCwgb2Zmc2V0IDAsIGZsYWdz
IFtub25lXSwgcHJvdG8gVURQICgxNyksIGxlbmd0aCA3OCkNCiAgICAxOTIuMTY4LjAuMTE1Lm5l
dGJpb3MtbnMgPiAxOTIuMTY4LjAuMjU1Lm5ldGJpb3MtbnM6IFVEUCwgbGVuZ3RoIDUwDQoxNzo1
Mjo1MC4zMDM2NjYgYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+IEJyb2FkY2FzdCwg
ZXRoZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCA5MjogKHRvcyAweDAsIHR0bCAxMjgsIGlk
IDQ1NzEsIG9mZnNldCAwLCBmbGFncyBbbm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggNzgp
DQogICAgMTkyLjE2OC4wLjExNS5uZXRiaW9zLW5zID4gMTkyLjE2OC4wLjI1NS5uZXRiaW9zLW5z
OiBVRFAsIGxlbmd0aCA1MA0KMTc6NTI6NTEuMDY4MTkxIGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkg
VW5rbm93bikgPiBCcm9hZGNhc3QsIGV0aGVydHlwZSBJUHY0ICgweDA4MDApLCBsZW5ndGggMjE2
OiAodG9zIDB4MCwgdHRsIDEyOCwgaWQgNDU3Miwgb2Zmc2V0IDAsIGZsYWdzIFtub25lXSwgcHJv
dG8gVURQICgxNyksIGxlbmd0aCAyMDIpDQogICAgMTkyLjE2OC4wLjExNS5uZXRiaW9zLWRnbSA+
IDE5Mi4xNjguMC4yNTUubmV0Ymlvcy1kZ206IFVEUCwgbGVuZ3RoIDE3NA0KMTc6NTI6NTEuMDY4
NDY0IGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93bikgPiBCcm9hZGNhc3QsIGV0aGVydHlw
ZSBJUHY0ICgweDA4MDApLCBsZW5ndGggOTI6ICh0b3MgMHgwLCB0dGwgMTI4LCBpZCA0NTczLCBv
ZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAgKDE3KSwgbGVuZ3RoIDc4KQ0KICAgIDE5
Mi4xNjguMC4xMTUubmV0Ymlvcy1ucyA+IDE5Mi4xNjguMC4yNTUubmV0Ymlvcy1uczogVURQLCBs
ZW5ndGggNTANCjE3OjUzOjE4LjIwNDgxMyBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24p
ID4gMDQ6OTE6NjI6ZjI6ZmQ6MWMgKG91aSBVbmtub3duKSwgZXRoZXJ0eXBlIElQdjQgKDB4MDgw
MCksIGxlbmd0aCA3NDogKHRvcyAweDAsIHR0bCAxMjgsIGlkIDM4MjYwLCBvZmZzZXQgMCwgZmxh
Z3MgW25vbmVdLCBwcm90byBJQ01QICgxKSwgbGVuZ3RoIDYwKQ0KICAgIDE5Mi4xNjguMC4xMTUg
PiBzYW1hN2c1ZWstc2Q6IElDTVAgZWNobyByZXF1ZXN0LCBpZCAxLCBzZXEgMjUsIGxlbmd0aCA0
MA0KMTc6NTM6MTguMjA1MzI5IDA0OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5rbm93bikgPiBCcm9h
ZGNhc3QsIGV0aGVydHlwZSBBUlAgKDB4MDgwNiksIGxlbmd0aCA0MjogRXRoZXJuZXQgKGxlbiA2
KSwgSVB2NCAobGVuIDQpLCBSZXF1ZXN0IHdoby1oYXMgMTkyLjE2OC4wLjExNSB0ZWxsIHNhbWE3
ZzVlay1zZCwgbGVuZ3RoIDI4DQoxNzo1MzoxOC4yMDU4NjEgYTA6Mjk6MTk6ODk6Yzk6NGMgKG91
aSBVbmtub3duKSA+IDA0OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5rbm93biksIGV0aGVydHlwZSBB
UlAgKDB4MDgwNiksIGxlbmd0aCA2MDogRXRoZXJuZXQgKGxlbiA2KSwgSVB2NCAobGVuIDQpLCBS
ZXBseSAxOTIuMTY4LjAuMTE1IGlzLWF0IGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93biks
IGxlbmd0aCA0Ng0KMTc6NTM6MTguMjA2MDQ4IDA0OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5rbm93
bikgPiBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pLCBldGhlcnR5cGUgSVB2NCAoMHgw
ODAwKSwgbGVuZ3RoIDc0OiAodG9zIDB4MCwgdHRsIDY0LCBpZCAzMTY0OCwgb2Zmc2V0IDAsIGZs
YWdzIFtub25lXSwgcHJvdG8gSUNNUCAoMSksIGxlbmd0aCA2MCkNCiAgICBzYW1hN2c1ZWstc2Qg
PiAxOTIuMTY4LjAuMTE1OiBJQ01QIGVjaG8gcmVwbHksIGlkIDEsIHNlcSAyNSwgbGVuZ3RoIDQw
DQoxNzo1MzoyMy4xMjI3MTIgYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+IDA0Ojkx
OjYyOmYyOmZkOjFjIChvdWkgVW5rbm93biksIGV0aGVydHlwZSBBUlAgKDB4MDgwNiksIGxlbmd0
aCA2MDogRXRoZXJuZXQgKGxlbiA2KSwgSVB2NCAobGVuIDQpLCBSZXF1ZXN0IHdoby1oYXMgc2Ft
YTdnNWVrLXNkICgwNDo5MTo2MjpmMjpmZDoxYyAob3VpIFVua25vd24pKSB0ZWxsIDE5Mi4xNjgu
MC4xMTUsIGxlbmd0aCA0Ng0KMTc6NTM6MjMuMTIyOTgyIDA0OjkxOjYyOmYyOmZkOjFjIChvdWkg
VW5rbm93bikgPiBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pLCBldGhlcnR5cGUgQVJQ
ICgweDA4MDYpLCBsZW5ndGggNDI6IEV0aGVybmV0IChsZW4gNiksIElQdjQgKGxlbiA0KSwgUmVw
bHkgc2FtYTdnNWVrLXNkIGlzLWF0IDA0OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5rbm93biksIGxl
bmd0aCAyOA0KMTc6NTM6MjMuMTIzMjM5IGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93bikg
PiAwNDo5MTo2MjpmMjpmZDoxYyAob3VpIFVua25vd24pLCBldGhlcnR5cGUgSVB2NCAoMHgwODAw
KSwgbGVuZ3RoIDc0OiAodG9zIDB4MCwgdHRsIDEyOCwgaWQgMzgyNjEsIG9mZnNldCAwLCBmbGFn
cyBbbm9uZV0sIHByb3RvIElDTVAgKDEpLCBsZW5ndGggNjApDQogICAgMTkyLjE2OC4wLjExNSA+
IHNhbWE3ZzVlay1zZDogSUNNUCBlY2hvIHJlcXVlc3QsIGlkIDEsIHNlcSAyNiwgbGVuZ3RoIDQw
DQoxNzo1MzoyMy4xMjM2MzQgMDQ6OTE6NjI6ZjI6ZmQ6MWMgKG91aSBVbmtub3duKSA+IGEwOjI5
OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93biksIGV0aGVydHlwZSBJUHY0ICgweDA4MDApLCBsZW5n
dGggNzQ6ICh0b3MgMHgwLCB0dGwgNjQsIGlkIDMyMDg2LCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVd
LCBwcm90byBJQ01QICgxKSwgbGVuZ3RoIDYwKQ0KICAgIHNhbWE3ZzVlay1zZCA+IDE5Mi4xNjgu
MC4xMTU6IElDTVAgZWNobyByZXBseSwgaWQgMSwgc2VxIDI2LCBsZW5ndGggNDANCjE3OjUzOjI4
LjEzMzQ4MyBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pID4gMDQ6OTE6NjI6ZjI6ZmQ6
MWMgKG91aSBVbmtub3duKSwgZXRoZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCA3NDogKHRv
cyAweDAsIHR0bCAxMjgsIGlkIDM4MjYyLCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBJ
Q01QICgxKSwgbGVuZ3RoIDYwKQ0KICAgIDE5Mi4xNjguMC4xMTUgPiBzYW1hN2c1ZWstc2Q6IElD
TVAgZWNobyByZXF1ZXN0LCBpZCAxLCBzZXEgMjcsIGxlbmd0aCA0MA0KMTc6NTM6MjguMTMzOTIx
IDA0OjkxOjYyOmYyOmZkOjFjIChvdWkgVW5rbm93bikgPiBhMDoyOToxOTo4OTpjOTo0YyAob3Vp
IFVua25vd24pLCBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwgbGVuZ3RoIDc0OiAodG9zIDB4MCwg
dHRsIDY0LCBpZCAzMjQ4OSwgb2Zmc2V0IDAsIGZsYWdzIFtub25lXSwgcHJvdG8gSUNNUCAoMSks
IGxlbmd0aCA2MCkNCiAgICBzYW1hN2c1ZWstc2QgPiAxOTIuMTY4LjAuMTE1OiBJQ01QIGVjaG8g
cmVwbHksIGlkIDEsIHNlcSAyNywgbGVuZ3RoIDQwDQogICAgMTkyLjE2OC4wLjExNS5uZXRiaW9z
LW5zID4gMTkyLjE2OC4wLjI1NS5uZXRiaW9zLW5zOiBVRFAsIGxlbmd0aCA1MA0KMTc6NTI6NTEu
MzUzMzQwIGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93bikgPiAwMTowMDo1ZTo3ZjpmZjpm
YSAob3VpIFVua25vd24pLCBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwgbGVuZ3RoIDE3OTogKHRv
cyAweDAsIHR0bCA0LCBpZCA1NzY1NCwgb2Zmc2V0IDAsIGZsYWdzIFtub25lXSwgcHJvdG8gVURQ
ICgxNyksIGxlbmd0aCAxNjUpDQogICAgMTkyLjE2OC4wLjExNS40OTg0NyA+IDIzOS4yNTUuMjU1
LjI1MC4xOTAwOiBVRFAsIGxlbmd0aCAxMzcNCjE3OjUyOjUxLjgyMzYyNiBhMDoyOToxOTo4OTpj
OTo0YyAob3VpIFVua25vd24pID4gQnJvYWRjYXN0LCBldGhlcnR5cGUgSVB2NCAoMHgwODAwKSwg
bGVuZ3RoIDkyOiAodG9zIDB4MCwgdHRsIDEyOCwgaWQgNDU3NCwgb2Zmc2V0IDAsIGZsYWdzIFtu
b25lXSwgcHJvdG8gVURQICgxNyksIGxlbmd0aCA3OCkNCiAgICAxOTIuMTY4LjAuMTE1Lm5ldGJp
b3MtbnMgPiAxOTIuMTY4LjAuMjU1Lm5ldGJpb3MtbnM6IFVEUCwgbGVuZ3RoIDUwDQoxNzo1Mjo1
Mi41OTQ2MjkgYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+IEJyb2FkY2FzdCwgZXRo
ZXJ0eXBlIElQdjQgKDB4MDgwMCksIGxlbmd0aCA5MjogKHRvcyAweDAsIHR0bCAxMjgsIGlkIDQ1
NzUsIG9mZnNldCAwLCBmbGFncyBbbm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggNzgpDQog
ICAgMTkyLjE2OC4wLjExNS5uZXRiaW9zLW5zID4gMTkyLjE2OC4wLjI1NS5uZXRiaW9zLW5zOiBV
RFAsIGxlbmd0aCA1MA0KMTc6NTI6NTQuMzYyNjE2IGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5r
bm93bikgPiBCcm9hZGNhc3QsIGV0aGVydHlwZSBJUHY0ICgweDA4MDApLCBsZW5ndGggMjE2OiAo
dG9zIDB4MCwgdHRsIDEyOCwgaWQgNDU3Niwgb2Zmc2V0IDAsIGZsYWdzIFtub25lXSwgcHJvdG8g
VURQICgxNyksIGxlbmd0aCAyMDIpDQogICAgMTkyLjE2OC4wLjExNS5uZXRiaW9zLWRnbSA+IDE5
Mi4xNjguMC4yNTUubmV0Ymlvcy1kZ206IFVEUCwgbGVuZ3RoIDE3NA0KMTc6NTI6NTQuMzYyNjE5
IGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93bikgPiBCcm9hZGNhc3QsIGV0aGVydHlwZSBJ
UHY0ICgweDA4MDApLCBsZW5ndGggOTI6ICh0b3MgMHgwLCB0dGwgMTI4LCBpZCA0NTc3LCBvZmZz
ZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAgKDE3KSwgbGVuZ3RoIDc4KQ0KICAgIDE5Mi4x
NjguMC4xMTUubmV0Ymlvcy1ucyA+IDE5Mi4xNjguMC4yNTUubmV0Ymlvcy1uczogVURQLCBsZW5n
dGggNTANCjE3OjUyOjU0LjM3MTc5NSBhMDoyOToxOTo4OTpjOTo0YyAob3VpIFVua25vd24pID4g
MDE6MDA6NWU6N2Y6ZmY6ZmEgKG91aSBVbmtub3duKSwgZXRoZXJ0eXBlIElQdjQgKDB4MDgwMCks
IGxlbmd0aCAxNzk6ICh0b3MgMHgwLCB0dGwgNCwgaWQgNTc2NTUsIG9mZnNldCAwLCBmbGFncyBb
bm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggMTY1KQ0KICAgIDE5Mi4xNjguMC4xMTUuNDk4
NDcgPiAyMzkuMjU1LjI1NS4yNTAuMTkwMDogVURQLCBsZW5ndGggMTM3DQoxNzo1Mjo1NS4xMTY3
NjggYTA6Mjk6MTk6ODk6Yzk6NGMgKG91aSBVbmtub3duKSA+IEJyb2FkY2FzdCwgZXRoZXJ0eXBl
IElQdjQgKDB4MDgwMCksIGxlbmd0aCA5MjogKHRvcyAweDAsIHR0bCAxMjgsIGlkIDQ1NzgsIG9m
ZnNldCAwLCBmbGFncyBbbm9uZV0sIHByb3RvIFVEUCAoMTcpLCBsZW5ndGggNzgpDQogICAgMTky
LjE2OC4wLjExNS5uZXRiaW9zLW5zID4gMTkyLjE2OC4wLjI1NS5uZXRiaW9zLW5zOiBVRFAsIGxl
bmd0aCA1MA0KMTc6NTI6NTUuODgyMTYxIGEwOjI5OjE5Ojg5OmM5OjRjIChvdWkgVW5rbm93bikg
PiBCcm9hZGNhc3QsIGV0aGVydHlwZSBJUHY0ICgweDA4MDApLCBsZW5ndGggOTI6ICh0b3MgMHgw
LCB0dGwgMTI4LCBpZCA0NTc5LCBvZmZzZXQgMCwgZmxhZ3MgW25vbmVdLCBwcm90byBVRFAgKDE3
KSwgbGVuZ3RoIDc4KQ0KICAgIDE5Mi4xNjguMC4xMTUubmV0Ymlvcy1ucyA+IDE5Mi4xNjguMC4y
NTUubmV0Ymlvcy1uczogVURQLCBsZW5ndGggNTANCg0K
--00000000000008db8b0616ef3f13
Content-Type: application/octet-stream; name="wireshark_dsa.pcapng"
Content-Disposition: attachment; filename="wireshark_dsa.pcapng"
Content-Transfer-Encoding: base64
Content-ID: <f_lvfj0i4n0>
X-Attachment-Id: f_lvfj0i4n0

Cg0NCsQAAABNPCsaAQAAAP//////////AgA8ADExdGggR2VuIEludGVsKFIpIENvcmUoVE0pIGk3
LTExODAwSCBAIDIuMzBHSHogKHdpdGggU1NFNC4yKQMAJQA2NC1iaXQgV2luZG93cyAxMCAoMjJI
MiksIGJ1aWxkIDE5MDQ1AAAABAA0AER1bXBjYXAgKFdpcmVzaGFyaykgNC4wLjE0ICh2NC4wLjE0
LTAtZ2MxZmNkYTRjYTBmYikAAAAAxAAAAAEAAACUAAAAAQAAAAAABAACADIAXERldmljZVxOUEZf
e0U3RkQ5RDQyLUFBMjQtNDJCMC1CMkRBLTY1NzI0NDNDRDg2OH0AAAMACgBFdGhlcm5ldCA0AAAJ
AAEABgAAAAwAJQA2NC1iaXQgV2luZG93cyAxMCAoMjJIMiksIGJ1aWxkIDE5MDQ1AAAAAAAAAJQA
AAAGAAAAhAAAAAAAAADvFgYAzwAaAmIAAABiAAAAoCkZiclMBJFi8v0cCABFAABUEtNAAEABpZvA
qAB3wKgAcwgAobcAAQAgndJqYmHvAQAICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygp
KissLS4vMDEyMzQ1NjcAAIQAAAAGAAAAhAAAAAAAAADvFgYAKwEaAmIAAABiAAAABJFi8v0coCkZ
iclMCABFAABUlU0AAIABAADAqABzwKgAdwAAqbcAAQAgndJqYmHvAQAICQoLDA0ODxAREhMUFRYX
GBkaGxwdHh8gISIjJCUmJygpKissLS4vMDEyMzQ1NjcAAIQAAAAGAAAA1AAAAAAAAADvFgYAFwnK
ArMAAACzAAAAAQBef//6oCkZiclMCABFAACl4P8AAAQRAADAqABz7///+sK3B2wAkZF0TS1TRUFS
Q0ggKiBIVFRQLzEuMQ0KSG9zdDogMjM5LjI1NS4yNTUuMjUwOjE5MDANClNUOiB1cm46c2NoZW1h
cy11cG5wLW9yZzpkZXZpY2U6SW50ZXJuZXRHYXRld2F5RGV2aWNlOjENCk1hbjogInNzZHA6ZGlz
Y292ZXIiDQpNWDogMw0KDQoA1AAAAAYAAADUAAAAAAAAAO8WBgDh9/cCswAAALMAAAABAF5///qg
KRmJyUwIAEUAAKXhAAAABBEAAMCoAHPv///6wrcHbACRkXRNLVNFQVJDSCAqIEhUVFAvMS4xDQpI
b3N0OiAyMzkuMjU1LjI1NS4yNTA6MTkwMA0KU1Q6IHVybjpzY2hlbWFzLXVwbnAtb3JnOmRldmlj
ZTpJbnRlcm5ldEdhdGV3YXlEZXZpY2U6MQ0KTWFuOiAic3NkcDpkaXNjb3ZlciINCk1YOiAzDQoN
CgDUAAAABgAAANQAAAAAAAAA7xYGAPPcJQOzAAAAswAAAAEAXn//+qApGYnJTAgARQAApeEBAAAE
EQAAwKgAc+////rCtwdsAJGRdE0tU0VBUkNIICogSFRUUC8xLjENCkhvc3Q6IDIzOS4yNTUuMjU1
LjI1MDoxOTAwDQpTVDogdXJuOnNjaGVtYXMtdXBucC1vcmc6ZGV2aWNlOkludGVybmV0R2F0ZXdh
eURldmljZToxDQpNYW46ICJzc2RwOmRpc2NvdmVyIg0KTVg6IDMNCg0KANQAAAAGAAAA1AAAAAAA
AADvFgYATwdUA7MAAACzAAAAAQBef//6oCkZiclMCABFAACl4QIAAAQRAADAqABz7///+sK3B2wA
kZF0TS1TRUFSQ0ggKiBIVFRQLzEuMQ0KSG9zdDogMjM5LjI1NS4yNTUuMjUwOjE5MDANClNUOiB1
cm46c2NoZW1hcy11cG5wLW9yZzpkZXZpY2U6SW50ZXJuZXRHYXRld2F5RGV2aWNlOjENCk1hbjog
InNzZHA6ZGlzY292ZXIiDQpNWDogMw0KDQoA1AAAAAYAAADUAAAAAAAAAO8WBgDw3oEDswAAALMA
AAABAF5///qgKRmJyUwIAEUAAKXhAwAABBEAAMCoAHPv///6wrcHbACRkXRNLVNFQVJDSCAqIEhU
VFAvMS4xDQpIb3N0OiAyMzkuMjU1LjI1NS4yNTA6MTkwMA0KU1Q6IHVybjpzY2hlbWFzLXVwbnAt
b3JnOmRldmljZTpJbnRlcm5ldEdhdGV3YXlEZXZpY2U6MQ0KTWFuOiAic3NkcDpkaXNjb3ZlciIN
Ck1YOiAzDQoNCgDUAAAABgAAAGgAAAAAAAAA7xYGACuoigNGAAAARgAAADMzAAAAAgSRYvL9HIbd
YAAAAAAQOv/+gAAAAAAAAAaRYv/+8v0c/wIAAAAAAAAAAAAAAAAAAoUAse0AAAAAAQEEkWLy/RwA
AGgAAAAGAAAA1AAAAAAAAADvFgYANravA7MAAACzAAAAAQBef//6oCkZiclMCABFAACl4QQAAAQR
AADAqABz7///+sK3B2wAkZF0TS1TRUFSQ0ggKiBIVFRQLzEuMQ0KSG9zdDogMjM5LjI1NS4yNTUu
MjUwOjE5MDANClNUOiB1cm46c2NoZW1hcy11cG5wLW9yZzpkZXZpY2U6SW50ZXJuZXRHYXRld2F5
RGV2aWNlOjENCk1hbjogInNzZHA6ZGlzY292ZXIiDQpNWDogMw0KDQoA1AAAAAYAAAD4AAAAAAAA
AO8WBgDj/kgE2AAAANgAAAABAF5///qgKRmJyUwIAEUAAMrhBQAAAREAAMCoAHPv///6694HbAC2
WG9NLVNFQVJDSCAqIEhUVFAvMS4xDQpIT1NUOiAyMzkuMjU1LjI1NS4yNTA6MTkwMA0KTUFOOiAi
c3NkcDpkaXNjb3ZlciINCk1YOiAxDQpTVDogdXJuOmRpYWwtbXVsdGlzY3JlZW4tb3JnOnNlcnZp
Y2U6ZGlhbDoxDQpVU0VSLUFHRU5UOiBHb29nbGUgQ2hyb21lLzEyNC4wLjYzNjcuNjEgV2luZG93
cw0KDQr4AAAABgAAAPwAAAAAAAAA7xYGAIb/SATZAAAA2QAAAAEAXn//+qApGYnJTAgARQAAy+EG
AAABEQAAwKgAc+////rr4QdsALfbeE0tU0VBUkNIICogSFRUUC8xLjENCkhPU1Q6IDIzOS4yNTUu
MjU1LjI1MDoxOTAwDQpNQU46ICJzc2RwOmRpc2NvdmVyIg0KTVg6IDENClNUOiB1cm46ZGlhbC1t
dWx0aXNjcmVlbi1vcmc6c2VydmljZTpkaWFsOjENClVTRVItQUdFTlQ6IE1pY3Jvc29mdCBFZGdl
LzEyNC4wLjI0NzguNTEgV2luZG93cw0KDQoAAAD8AAAABgAAAPwAAAAAAAAA7xYGAP2MWATZAAAA
2QAAAAEAXn//+qApGYnJTAgARQAAy+EHAAABEQAAwKgAc+////rr4QdsALfbeE0tU0VBUkNIICog
SFRUUC8xLjENCkhPU1Q6IDIzOS4yNTUuMjU1LjI1MDoxOTAwDQpNQU46ICJzc2RwOmRpc2NvdmVy
Ig0KTVg6IDENClNUOiB1cm46ZGlhbC1tdWx0aXNjcmVlbi1vcmc6c2VydmljZTpkaWFsOjENClVT
RVItQUdFTlQ6IE1pY3Jvc29mdCBFZGdlLzEyNC4wLjI0NzguNTEgV2luZG93cw0KDQoAAAD8AAAA
BgAAAPgAAAAAAAAA7xYGAA2NWATYAAAA2AAAAAEAXn//+qApGYnJTAgARQAAyuEIAAABEQAAwKgA
c+////rr3gdsALZYb00tU0VBUkNIICogSFRUUC8xLjENCkhPU1Q6IDIzOS4yNTUuMjU1LjI1MDox
OTAwDQpNQU46ICJzc2RwOmRpc2NvdmVyIg0KTVg6IDENClNUOiB1cm46ZGlhbC1tdWx0aXNjcmVl
bi1vcmc6c2VydmljZTpkaWFsOjENClVTRVItQUdFTlQ6IEdvb2dsZSBDaHJvbWUvMTI0LjAuNjM2
Ny42MSBXaW5kb3dzDQoNCvgAAAAGAAAA+AAAAAAAAADvFgYAmP1nBNgAAADYAAAAAQBef//6oCkZ
iclMCABFAADK4QkAAAERAADAqABz7///+uveB2wAtlhvTS1TRUFSQ0ggKiBIVFRQLzEuMQ0KSE9T
VDogMjM5LjI1NS4yNTUuMjUwOjE5MDANCk1BTjogInNzZHA6ZGlzY292ZXIiDQpNWDogMQ0KU1Q6
IHVybjpkaWFsLW11bHRpc2NyZWVuLW9yZzpzZXJ2aWNlOmRpYWw6MQ0KVVNFUi1BR0VOVDogR29v
Z2xlIENocm9tZS8xMjQuMC42MzY3LjYxIFdpbmRvd3MNCg0K+AAAAAYAAAD8AAAAAAAAAO8WBgDH
/WcE2QAAANkAAAABAF5///qgKRmJyUwIAEUAAMvhCgAAAREAAMCoAHPv///66+EHbAC323hNLVNF
QVJDSCAqIEhUVFAvMS4xDQpIT1NUOiAyMzkuMjU1LjI1NS4yNTA6MTkwMA0KTUFOOiAic3NkcDpk
aXNjb3ZlciINCk1YOiAxDQpTVDogdXJuOmRpYWwtbXVsdGlzY3JlZW4tb3JnOnNlcnZpY2U6ZGlh
bDoxDQpVU0VSLUFHRU5UOiBNaWNyb3NvZnQgRWRnZS8xMjQuMC4yNDc4LjUxIFdpbmRvd3MNCg0K
AAAA/AAAAAYAAAB8AAAAAAAAAO8WBgAFhW0EXAAAAFwAAAD///////+gKRmJyUwIAEUAAE4RvgAA
gBEAAMCoAHPAqAD/AIkAiQA6D73tYAEQAAEAAAAAAAAgRUZFTUZEQ05GR0ZBRkRGR0ZEQ05GQUZD
RkVEQUREQ0EAACAAAXwAAAAGAAAAdAAAAAAAAADvFgYAUYdtBFEAAABRAAAAAQBeAAD7oCkZiclM
CABFAABDwZQAAAERAADAqABz4AAA+xTpFOkAL/scAAAAAAABAAAAAAAAD2Vscy12cHN2cy1wcnQw
MwVsb2NhbAAAAQABAAAAdAAAAAYAAACIAAAAAAAAAO8WBgAGim0EZQAAAGUAAAAzMwAAAPugKRmJ
yUyG3WAKsm8ALxEB/oAAAAAAAAD11YSIsJMQuv8CAAAAAAAAAAAAAAAAAPsU6RTpAC9jCQAAAAAA
AQAAAAAAAA9lbHMtdnBzdnMtcHJ0MDMFbG9jYWwAAAEAAQAAAIgAAAAGAAAAdAAAAAAAAADvFgYA
QIxtBFEAAABRAAAAAQBeAAD7oCkZiclMCABFAABDwZUAAAERAADAqABz4AAA+xTpFOkAL+AcAAAA
AAABAAAAAAAAD2Vscy12cHN2cy1wcnQwMwVsb2NhbAAAHAABAAAAdAAAAAYAAACIAAAAAAAAAO8W
BgCUjW0EZQAAAGUAAAAzMwAAAPugKRmJyUyG3WAKsm8ALxEB/oAAAAAAAAD11YSIsJMQuv8CAAAA
AAAAAAAAAAAAAPsU6RTpAC9ICQAAAAAAAQAAAAAAAA9lbHMtdnBzdnMtcHJ0MDMFbG9jYWwAABwA
AQAAAIgAAAAGAAAAgAAAAAAAAADvFgYAL5BtBF8AAABfAAAAMzMAAQADoCkZiclMht1gD5QWACkR
Af6AAAAAAAAA9dWEiLCTELr/AgAAAAAAAAAAAAAAAQAD6RsU6wApyZucdwAAAAEAAAAAAAAPZWxz
LXZwc3ZzLXBydDAzAAABAAEAgAAAAAYAAABsAAAAAAAAAO8WBgCTkG0ESwAAAEsAAAABAF4AAPyg
KRmJyUwIAEUAAD1LfQAAAREAAMCoAHPgAAD86RsU6wApYLecdwAAAAEAAAAAAAAPZWxzLXZwc3Zz
LXBydDAzAAABAAEAbAAAAAYAAACAAAAAAAAAAO8WBgAxkm0EXwAAAF8AAAAzMwABAAOgKRmJyUyG
3WADKEYAKREB/oAAAAAAAAD11YSIsJMQuv8CAAAAAAAAAAAAAAABAAPCABTrACmBW/DSAAAAAQAA
AAAAAA9lbHMtdnBzdnMtcHJ0MDMAABwAAQCAAAAABgAAAGwAAAAAAAAA7xYGAICSbQRLAAAASwAA
AAEAXgAA/KApGYnJTAgARQAAPUt+AAABEQAAwKgAc+AAAPzCABTrACkYd/DSAAAAAQAAAAAAAA9l
bHMtdnBzdnMtcHJ0MDMAABwAAQBsAAAABgAAAPwAAAAAAAAA7xYGACJtdwTZAAAA2QAAAAEAXn//
+qApGYnJTAgARQAAy+ELAAABEQAAwKgAc+////rr4QdsALfbeE0tU0VBUkNIICogSFRUUC8xLjEN
CkhPU1Q6IDIzOS4yNTUuMjU1LjI1MDoxOTAwDQpNQU46ICJzc2RwOmRpc2NvdmVyIg0KTVg6IDEN
ClNUOiB1cm46ZGlhbC1tdWx0aXNjcmVlbi1vcmc6c2VydmljZTpkaWFsOjENClVTRVItQUdFTlQ6
IE1pY3Jvc29mdCBFZGdlLzEyNC4wLjI0NzguNTEgV2luZG93cw0KDQoAAAD8AAAABgAAAPgAAAAA
AAAA7xYGAC9tdwTYAAAA2AAAAAEAXn//+qApGYnJTAgARQAAyuEMAAABEQAAwKgAc+////rr3gds
ALZYb00tU0VBUkNIICogSFRUUC8xLjENCkhPU1Q6IDIzOS4yNTUuMjU1LjI1MDoxOTAwDQpNQU46
ICJzc2RwOmRpc2NvdmVyIg0KTVg6IDENClNUOiB1cm46ZGlhbC1tdWx0aXNjcmVlbi1vcmc6c2Vy
dmljZTpkaWFsOjENClVTRVItQUdFTlQ6IEdvb2dsZSBDaHJvbWUvMTI0LjAuNjM2Ny42MSBXaW5k
b3dzDQoNCvgAAAAGAAAAfAAAAAAAAADvFgYA8xF5BFwAAABcAAAA////////oCkZiclMCABFAABO
Eb8AAIARAADAqABzwKgA/wCJAIkAOg+97WABEAABAAAAAAAAIEVGRU1GRENORkdGQUZERkdGRENO
RkFGQ0ZFREFERENBAAAgAAF8AAAABgAAAHwAAAAAAAAA7xYGAPGMhARcAAAAXAAAAP///////6Ap
GYnJTAgARQAAThHAAACAEQAAwKgAc8CoAP8AiQCJADoPve1gARAAAQAAAAAAACBFRkVNRkRDTkZH
RkFGREZHRkRDTkZBRkNGRURBRERDQQAAIAABfAAAAAYAAAB8AAAAAAAAAO8WBgCUFgcFWgAAAFoA
AAAzMwAAABagKRmJyUyG3WAAAAAAJAAB/oAAAAAAAAD11YSIsJMQuv8CAAAAAAAAAAAAAAAAABY6
AAUCAAABAI8ANVsAAAABAwAAAP8CAAAAAAAAAAAAAAABAAMAAHwAAAAGAAAAWAAAAAAAAADvFgYA
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
AAAgRkVFRENORURFUEVPRUdFTUZGRUZFT0VERUZDQUNBQUEAACAAAXwAAAAGAAAAfAAAAAAAAADv
FgYAd89DCFwAAABcAAAA////////oCkZiclMCABFAABOEcMAAIARAADAqABzwKgA/wCJAIkAOvLD
7WIBEAABAAAAAAAAIEZFRURDTkVERVBFT0VHRU1GRkVGRU9FREVGQ0FDQUFBAAAgAAF8AAAABgAA
AIQAAAAAAAAA7xYGADy3SwhiAAAAYgAAAKApGYnJTASRYvL9HAgARQAAVCjFQABAAY+pwKgAd8Co
AHMIAOqLAAEAhAXTamKxtgAACAkKCwwNDg8QERITFBUWFxgZGhscHR4fICEiIyQlJicoKSorLC0u
LzAxMjM0NTY3AACEAAAABgAAAIQAAAAAAAAA7xYGAJPHSwhiAAAAYgAAAASRYvL9HKApGYnJTAgA
RQAAVJVaAACAAQAAwKgAc8CoAHcAAPKLAAEAhAXTamKxtgAACAkKCwwNDg8QERITFBUWFxgZGhsc
HR4fICEiIyQlJicoKSorLC0uLzAxMjM0NTY3AACEAAAABQAAAGwAAAAAAAAA7xYGABMafQgBABwA
Q291bnRlcnMgcHJvdmlkZWQgYnkgZHVtcGNhcAIACADvFgYAUckJAgMACADvFgYAExp9CAQACABj
AAAAAAAAAAUACAAAAAAAAAAAAAAAAABsAAAA
--00000000000008db8b0616ef3f13--

