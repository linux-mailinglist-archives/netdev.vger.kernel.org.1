Return-Path: <netdev+bounces-125604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2734496DDFF
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228571F229E9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C65319E7D1;
	Thu,  5 Sep 2024 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b="k/GdhCu4"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC219DF70;
	Thu,  5 Sep 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549796; cv=none; b=gAHcn/Ue2u5NN5JICGvdUhcYbHapEQAHJmxzJQrpMDzuTDBR51u/0votsTh5ORNx51sAS+kiy5hxQ/wzxbuc2z4jkG1QHLbINk2Ogyo0wTdJ6l+JdNVMhQ8HIa5avvJDkNxFLSmhj66zcCWLI5B6lGepC8nJTbWvnk2Q61f32Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549796; c=relaxed/simple;
	bh=Fq6gfVMnb7XXGw6XnD3/dWGf6Z3Pqz0FnV2LoLUj+Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cvYhv0etk10W7DvgwiJijHJ/MlUNYqYVpKoXtSM0U8hnxS9JditVwpRLHpscv6gsED/YLVvX+9peU/K+vKZEWknVJIFep54HstgKcQJwCgn43DviuDSyvoIcYqVM2HJ6p4XodrQ8DxXrnn2ydmQ7sOXWaEJt96fu1k4ezzrifVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr; spf=pass smtp.mailfrom=gmx.fr; dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b=k/GdhCu4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.fr;
	s=s31663417; t=1725549776; x=1726154576; i=benoit.monin@gmx.fr;
	bh=A+73DQqdUmroEfD5LrBL5i9gFjFca3l16HgnvLmjCSQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k/GdhCu4tUwf9d3+gniA0SOK/fYh+Myrh32YWg+q1kgObfgpBE9qabPudwY5D/oP
	 pT33Z5l6eiBrfRjFyGxT0S5A60BAQglAjkUtHXBNp+O6txTn3IAxr5ozGy0JhUq/M
	 eYD6XzwE1jT1MKaOEvoqdaj5aCVGi07esGwUDcc+ENMohhF4V89Pw4eb+6x/S8fKI
	 H+pAjaSS8zfIIgS/ntb9lpTl/uX99B7t/MNCwCSfHQRzrXLGRb1HGAt20lMUGLX1d
	 aqyrlNhb+o1rSUwPiuVmuzTC7uni95WrvOkMHYKgRBv3KHUeycDpx8HM/8W0wNMOa
	 LFa1swTkuAY+PGpEPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pianobar.pianonet ([176.145.30.241]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCbEf-1svLH926bb-002rog; Thu, 05
 Sep 2024 17:22:56 +0200
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@gmx.fr>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PROBLEM: invalid udp checksum with ip6gre-in-udp
Date: Thu, 05 Sep 2024 17:22:55 +0200
Message-ID: <26548921.1r3eYUQgxm@benoit.monin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V03:K1:WxdXQ3Tf1h0qzBrJlrW6OZ/t2UxuYFPJFpxD8rEbSOiLEzhaey3
 KXCnOsxUWv4mUumATS4Hs/PRL043Jn8Ew9zMB0jkZcQ56ua+JQhAtLtLHLBPlRmszeBkF3c
 y2K6Rge+BneX4q+VdLlaDbvCipxqE+FaHcKYg7tOs+Nj1q8QLTy8+Z8dT9GwJxIE4QrI3Y1
 KyPHP22g20jL3vXdQW+8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:crNeHL7etfg=;NZzUwn7SS/a9ni+pb9Z12ihKjQZ
 7zn+vxeW5Pqk0tE64SiJb5yFrWTNe73MwE94eh9QKc/KvO8PAl5UYIEXp7+6tgdFihK8msT15
 VMr2JGBzjRurehbLDu7cVWzmlGePrgJh/jNrmKpdqQ9enmZnreN1B/LfD6YJQ6rriUVFb0Ryh
 GJqaeAb0gRu3Scm5Wot/KEEa6X5Sw5s/WorNlCflR70rQ/ufxHNrrikNGxmEDjx5Y3RUEHS3G
 ZBvSJhsOGaTAjJmnjk/TEX2Q2ZYN99wuc5gj6BYrShyTxq87Rx1UYYlyGcn15o40LqFEb5dyN
 n7MelA/eUoxH7c5YoUkCWtEL2ek+4ltPvu7y8dcYk+s6xzT+7/KdD8+KS2oRXZNYQM8u3aMLr
 8uL7jRH9DR53S4UXi3T8WF0HR81NLdrIfiOjvaVCoG88tfRmIi9nrI0ij2yuYLdkkaQnQBwUo
 reWaRqW7MMIC8Mzs4WGrANHfzJmRpy8CTQXAzKlNB+u8GeQKdJXhufdBMEvRBDTBRiLMh3CBl
 MOA7YE1/GG4FS/CmIPH9rCCLHnv0jtekl9YT/Hi25WmqeyzvoSZP1Fy1hbHL92C5L/2RNx75m
 wt5f6GfpD8DAolrmgiqXVWLqnLSQF3/mfGoUOUaU8Tqm1HxRCFTekw9T5UbSGsUPWU07sOEh9
 8pSGFVMbvfQZa+U0EOa6DtXAzTw+Y26Z8xFMdpRgsv+Dn2pMtonL8ru8DBVRn4yIdvJANu58T
 0KU4K9+vFMfUEMlvDsH5CFVwIJsCEMVmlc6TdyO4T4NvBEXSPC4fqkTvqDbtEhBjIVaafMmjC
 OPxGu6FCq/pY1S5siB5kx6YRPA48kI4Y/oM40foO6mtvw5QxLj28ezwKicHc4Dgw7jiEej10f
 3oQPuRkeP7S+rBw==

Hi all,

I am having issue with GRE-in-UDP (GRE with fou encapsulation) over=20
IPv6: the outer UDP checksum is only valid if an inner checksum is=20
present and valid. This problem is only present over IPv6, not IPv4,=20
and reproducible with different kernel versions and cpu architecture.

Here is the test setup I used:

    +----------+                                    +------------+
    |          | fd00::2/64              fd00::1/64 |            |
    |  tester  | 10.0.0.33/24          10.0.0.11/24 |    DUT     |
    |          |------------------------------------|            |
    +----------+                                    +------------+

Two machines are connected with an ethernet cable, and each side is=20
setup with an ipv4 and an ipv6 address.

On the device under test, two GRE-in-UDP tunnels are setup, one over=20
ipv6 and one over ipv4, aimed at the tester. Each tunnel is configured=20
with an ipv4 address:

    modprobe -a fou fou6

    ip link add gre6 type ip6gre local fd00::1 remote fd00::2 encap fou enc=
ap-sport 1234 encap-dport 4567
    ip link set up gre6
    ip address add 172.20.6.1/24 dev gre6

    ip link add gre4 type gre local 10.0.0.11 remote 10.0.0.33 encap fou en=
cap-sport 3456 encap-dport 6789 encap-csum
    ip link set up gre4
    ip address add 172.20.4.1/24 dev gre4

On the tester, no setup is done, it is only running tcpdump to capture=20
the traffic emitted by the DUT.

The following commands are used on the device under test to send=20
packets via the tunnels:

    ping -c1 -W0.1 172.20.6.2
    ./send_udp 172.20.6.2 5555 "ip6gre-in-udp with inner udp csum"
    SO_NO_CHECK=3D1 ./send_udp 172.20.6.2 5555 "ip6gre-in-udp without inner=
 udp csum"
    ping -c1 -W0.1 172.20.4.2
    ./send_udp 172.20.4.2 5555 "gre-in-udp with inner udp csum"
    SO_NO_CHECK=3D1 ./send_udp 172.20.4.2 5555 "gre-in-udp without inner ud=
p csum"

Three packets are sent in each GRE tunnels :
* One ICMP echo request
* One UDP packet with a valid checksum
* One UDP packet with the checksum set to 0

Here is a link to the pcap containing the six packets generated by the=20
previous commands:
https://onaip.mooo.com/pub/tmp/bug_ip6gre-in-udp.pcap

Some details about the captured packets:
IP6 fd00::1 > fd00::2: 1234 > 4567: [bad udp cksum 0xfa75 -> 0xe680!]
IP6 fd00::1 > fd00::2: 1234 > 4567: [udp sum ok]
IP6 fd00::1 > fd00::2: 1234 > 4567: [bad udp cksum 0xfa62 -> 0xb57c!]
IP 10.0.0.11.3456 > 10.0.0.33.6789: [udp sum ok]
IP 10.0.0.11.3456 > 10.0.0.33.6789: [udp sum ok]
IP 10.0.0.11.3456 > 10.0.0.33.6789: [udp sum ok]

=46or the tunnel over ipv6, only the UDP packet sent with a valid=20
checksum get encapsulated with a valid checksum. For the ping and the=20
UDP packet with a zero checksum, the outer UDP checksum matches the=20
partial checksum of the pseudo-header.

=46or ipv4, the UDP checksum of the encapsulation are all valid.

The device under test used for the capture is an x86-64 machine with a=20
realtek ethernet adapter (r8169 driver) running a 6.10.7 kernel.

The problem was also seen on an arm64 board (freescale ls1046) with=20
dpaa ethernet driver running a 4.14 kernel. on this hardware, the=20
packets that would have an invalid checksum are not emitted and the tx=20
error counter of the ethernet interface increases.

In all cases, disabling hardware checksumming for ipv6 with ethtool can=20
be used as a work-around:

    ethtool -K eth0 tx-checksum-ipv6 off

This and the partial checksum value seems to point to an error in the=20
handling of hardware checksumming in the particular case of fou6=20
encapsulation, but I have not been able to figure out what could be=20
causing it.

Did I miss a configuration parameter for ip6gre-in-udp? Any advise on=20
how to debug that would be appreciated.

=2D-=20
Beno=C3=AEt



