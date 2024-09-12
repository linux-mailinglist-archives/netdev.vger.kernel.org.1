Return-Path: <netdev+bounces-127822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ECF976B86
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099E0289188
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B501B984E;
	Thu, 12 Sep 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b="g087BWUA"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D90E1B12CB;
	Thu, 12 Sep 2024 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149912; cv=none; b=T1x7tKuWrPtGvEHNJe4IDwR6oxsGvvDNUUvwYggCD5L81TgDPaagjkSOutrTeHDfIiF0RWLZgT0dluEspcMAlunCbShggsnik/1akYKrk6MLhaUFrDZad48JIFxmp307mnQhi6fuI/FGs/6t+Jvkxa0Sdlz5VBkOTnFHqV5tWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149912; c=relaxed/simple;
	bh=ECou34zWvN1ytfZHrwau3tKOsNAzqJ0JrivmBLLufLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nF1dzj1U7RgTvBXrrFlXdUhvefzCT154jYxapenae77eyjbacbYnPOFNvOztZ/k+XeSVJUQSiS+UtCDVuPDqrPY8b8c65kQ6rSy21Kft396UDDSSXWgZ6dX844fDiJM3ohFD+VJJ2mZideVr92aALW39wogcPM9vbeC98U0qfdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr; spf=pass smtp.mailfrom=gmx.fr; dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b=g087BWUA; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.fr;
	s=s31663417; t=1726149892; x=1726754692; i=benoit.monin@gmx.fr;
	bh=efT/Up7ScMohXpWJFmc5DycLKqzQ4PPdYA/TTzoptME=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g087BWUAmKO2YwG1u4EuiFHE2/zYzho4oMIn+aG4aa49m4QuuUIrkU2izsSz0e6c
	 U4Ft9toASeDCX97JOwfuwn2WOmrv/lGm7HNiDcE7rTidTBUohvhcUzLZanurnU7cV
	 P/sJyQmTBkAb9zCoegTpMl9wIhmn7rgYtZnRONmqv9moRisoOxhQhs3vgyntghRjn
	 E6P4HsGuh+VpNFbUnUZS6ZL7fbY+VL9wjWtBEAd6RpnXr064ETfDUvSD6Cbch/k7i
	 orwmFCDnusc6JRgFD5a2ZzWjdsfq4K9cFOg3j4ToVJ8j/JdkFlksfsUYmV/o7U9h0
	 9MzWTKV0QYl0zPQQZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pianobar.pianonet ([176.145.30.241]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEFvj-1shHf71ktZ-003QKH; Thu, 12
 Sep 2024 16:04:52 +0200
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@gmx.fr>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: invalid udp checksum with ip6gre-in-udp
Date: Thu, 12 Sep 2024 16:04:51 +0200
Message-ID: <2147205.9o76ZdvQCi@benoit.monin>
In-Reply-To: <26548921.1r3eYUQgxm@benoit.monin>
References: <26548921.1r3eYUQgxm@benoit.monin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V03:K1:u8+r9LWfW0QCUPVusfVyPS8Z+zK3hjgLLsveXXsIcNBOW7lNifZ
 wpGRPnUlxGJO+Fe/2QX8mXBKC4GdSR4B7Mc8c2se4SJ1iTa8pevzLc18APAQixdEE7QyRlv
 Bx354jl9A4IUxG3wNBXs4f90j9EPItVMVdemmB4YgvDqFArWfLjKssBNhsgroTM7UKe+JTH
 WlOkiDmB6dLJP8DCrSwGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yJBgJ5hMg7I=;i2ia4Sx2nCaYIqf/bwILA3ogFpy
 e61gS5e/iDxXRMBmSyEffXgn7keS8uztgRp9qYTvE+8dytVLheWkIY+1zRwsi6vvnWEqUFUcE
 PIWie3Xtx7cjgXr/bpolMfdwyc9ysvpuhw0y+IKvoA5uYFKU0Q+s2Of7YaJK2gTC9Imv7Z81H
 16n9U5qfydgx5JelKmeu6C57USmk6p2QT35rTexhDQo+VC8H0JNgqns8qp1cseQRP6Wm+qNwy
 ZuHTRW22FvpzZ6+2CF5KDN8te+r6Tvl+/cayr67vz2hY08o4r/7ZBf3HWcLAAUR2fAw9Cocu0
 i9kTKpkcKSVTft0i1j93ybS0oU6rGjRU0mkHorVEwNvTk0F3dAUvbCVdDTfKH+02qSwNL1kKI
 lsBfbkEXMDBw78mm7b9gVReoenb2AzUA6FjvTz2YRxjFPoQ+DRs5aK3ceLM4dyIQdRTV5HK1s
 oCqudT5JZJhkxYkvmk8Kij7Q8rLtZh1ct5LBJifjn490RaTrP+QgYFUSo9itiV0bob3X6KVnK
 4ROsggNbT+NZ/8HWwlEJGv5drxZPC3ncwdbhz9YAVe3ATlipxYbxnso7IbxD/24ssH6uD3G+w
 KnPvtJdei6nkN7eFhOhVdmX09C+fqPrRtDhV1Rc65QnvA4RseNdb/CjgCQkhvLZrUjtQYmV0A
 MggaTpvPdUUr7sYGd4galbWAaciZ4kjMC8haXL2nGdej/ZwqDKjAxzVnWZsrcYjFHCpl390EN
 Rm2XFE7UCpaubtec9addhjjltU3KFNvB4fPY41Xx+x4HU603hKS/e02KjNVL+F+gwOGIp4xHo
 cp5wb56Kg41wfGCJ8mE2sDonjZ1j2TbxJ9rrxpUc3p+u4e47EZCkoEnjzyFXRXseSkhzdwOpG
 jsKyTndK3BgrU5A==

Hi again,

05/09/2024 Beno=C3=AEt Monin :
> Hi all,
>=20
> I am having issue with GRE-in-UDP (GRE with fou encapsulation) over=20
> IPv6: the outer UDP checksum is only valid if an inner checksum is=20
> present and valid. This problem is only present over IPv6, not IPv4,=20
> and reproducible with different kernel versions and cpu architecture.
>=20
> Here is the test setup I used:
>=20
>     +----------+                                    +------------+
>     |          | fd00::2/64              fd00::1/64 |            |
>     |  tester  | 10.0.0.33/24          10.0.0.11/24 |    DUT     |
>     |          |------------------------------------|            |
>     +----------+                                    +------------+
>=20
> Two machines are connected with an ethernet cable, and each side is=20
> setup with an ipv4 and an ipv6 address.
>=20
> On the device under test, two GRE-in-UDP tunnels are setup, one over=20
> ipv6 and one over ipv4, aimed at the tester. Each tunnel is configured=20
> with an ipv4 address:
>=20
>     modprobe -a fou fou6
>=20
>     ip link add gre6 type ip6gre local fd00::1 remote fd00::2 encap fou e=
ncap-sport 1234 encap-dport 4567
>     ip link set up gre6
>     ip address add 172.20.6.1/24 dev gre6
>=20
>     ip link add gre4 type gre local 10.0.0.11 remote 10.0.0.33 encap fou =
encap-sport 3456 encap-dport 6789 encap-csum
>     ip link set up gre4
>     ip address add 172.20.4.1/24 dev gre4
>=20
> On the tester, no setup is done, it is only running tcpdump to capture=20
> the traffic emitted by the DUT.
>=20
> The following commands are used on the device under test to send=20
> packets via the tunnels:
>=20
>     ping -c1 -W0.1 172.20.6.2
>     ./send_udp 172.20.6.2 5555 "ip6gre-in-udp with inner udp csum"
>     SO_NO_CHECK=3D1 ./send_udp 172.20.6.2 5555 "ip6gre-in-udp without inn=
er udp csum"
>     ping -c1 -W0.1 172.20.4.2
>     ./send_udp 172.20.4.2 5555 "gre-in-udp with inner udp csum"
>     SO_NO_CHECK=3D1 ./send_udp 172.20.4.2 5555 "gre-in-udp without inner =
udp csum"
>=20
> Three packets are sent in each GRE tunnels :
> * One ICMP echo request
> * One UDP packet with a valid checksum
> * One UDP packet with the checksum set to 0
>=20
> Here is a link to the pcap containing the six packets generated by the=20
> previous commands:
> https://onaip.mooo.com/pub/tmp/bug_ip6gre-in-udp.pcap
>=20
> Some details about the captured packets:
> IP6 fd00::1 > fd00::2: 1234 > 4567: [bad udp cksum 0xfa75 -> 0xe680!]
> IP6 fd00::1 > fd00::2: 1234 > 4567: [udp sum ok]
> IP6 fd00::1 > fd00::2: 1234 > 4567: [bad udp cksum 0xfa62 -> 0xb57c!]
> IP 10.0.0.11.3456 > 10.0.0.33.6789: [udp sum ok]
> IP 10.0.0.11.3456 > 10.0.0.33.6789: [udp sum ok]
> IP 10.0.0.11.3456 > 10.0.0.33.6789: [udp sum ok]
>=20
> For the tunnel over ipv6, only the UDP packet sent with a valid=20
> checksum get encapsulated with a valid checksum. For the ping and the=20
> UDP packet with a zero checksum, the outer UDP checksum matches the=20
> partial checksum of the pseudo-header.
>=20
> For ipv4, the UDP checksum of the encapsulation are all valid.
>=20
> The device under test used for the capture is an x86-64 machine with a=20
> realtek ethernet adapter (r8169 driver) running a 6.10.7 kernel.
>=20
> The problem was also seen on an arm64 board (freescale ls1046) with=20
> dpaa ethernet driver running a 4.14 kernel. on this hardware, the=20
> packets that would have an invalid checksum are not emitted and the tx=20
> error counter of the ethernet interface increases.
>=20
> In all cases, disabling hardware checksumming for ipv6 with ethtool can=20
> be used as a work-around:
>=20
>     ethtool -K eth0 tx-checksum-ipv6 off
>=20
> This and the partial checksum value seems to point to an error in the=20
> handling of hardware checksumming in the particular case of fou6=20
> encapsulation, but I have not been able to figure out what could be=20
> causing it.
>=20
> Did I miss a configuration parameter for ip6gre-in-udp? Any advise on=20
> how to debug that would be appreciated.
>=20
I did some more digging with 6.11-rc7, and it is not a problem in the=20
common code or udp encapsulation, I just got "lucky" with my tests...

=46irst in fou6.c, fou6_build_udp constructs the upd header and calls=20
udp6_set_csum. If the inner packet has a valid checksum, the outer udp=20
get computed by reusing it, otherwise the partial checksum is set.

Next the outer ipv6 is built in ip6tunnel.c:ip6_tnl_xmit. With the=20
default value of encaplimit (4), an destination options header is=20
inserted to pass that value. This means that ipv6_hdr(skb)->nexthdr is=20
set to 60 (NEXTHDR_DEST), not 17 (IPPROTO_UDP).

So when sending a packet without a valid checksum in a ip6gre-in-udp,=20
we pass a skb with a partial udp checksum and an ipv6 header with an=20
extension to ndo_start_xmit.

=46inally, what are the odds of testing two different hardware and=20
finding two similar bugs?

=46or the LS1046 platform, the Tx checksum is done in=20
dpaa_enable_tx_csum. For ipv6, the layer 4 protocol is extracted from=20
the skb with l4_proto =3D ipv6h->nexthdr. Since the value does not match=20
IPPROTO_UDP nor IPPROTO_TCP, the function errors out and the packet is=20
discarded.

=46or the PC with a realtek 8169 card, the code is similar in=20
rtl8169_tso_csum_v2, with ip_protocol =3D ipv6_hdr(skb)->nexthdr. The=20
error case then triggers a WARN_ON_ONCE(1) and the packet is still sent=20
on the wire with a partial udp checksum.

There seems to be quite a few places in drivers/net/ethernet that use=20
ipv6_hdr(skb)->nexthdr as the IP protocol, with only some of them=20
calling ipv6_skip_exthdr afterward to take care of the extension=20
headers. So my proposal is to add a small helper (ipv6_protocol?) and=20
fix the drivers where needed.

I'll try to come up with a patch set, unless someone has a better idea.

=2D-=20
Beno=C3=AEt



