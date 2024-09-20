Return-Path: <netdev+bounces-129072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053B697D543
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4831C21403
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1912514A60E;
	Fri, 20 Sep 2024 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b="Mhto5tcn"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E513B2B0;
	Fri, 20 Sep 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726834238; cv=none; b=ZRatcCe1wpfih4J0Fd2VqIQSUKx8re82ZbLOeYOAkWgGw+ZgpDVHuUG61nS8tj0ZaxaFu/gTmOaIuAIepAz8aNsc7oY1n4Fu9B2+0NZMjjHZHAPLtL7QAiJZwIhnh+MLgyNbQZeIgIPURdfefmO5Uy435TS9BhjxMjFPGgLjTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726834238; c=relaxed/simple;
	bh=eeeglKdd2yUKzDw/2EMwRMUT79B0VjxLBjNWQ8B9h1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3VnPvvlQFVL9lz1ghVhWqbAJTnboJ9Pg65qfYrW5Qd5rK1EoItRsrPqM4kx8xwvDFrZgFRA4M3xnLZ17cDdu9Bp6kZMof6VtS8ljaePCN4rKfZ82cFoM7OOuYdaWo1mqlzijHqpYDf6sK30QXXN6zWFLvdJ9ObH6nI6Tot7/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr; spf=pass smtp.mailfrom=gmx.fr; dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b=Mhto5tcn; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.fr;
	s=s31663417; t=1726834218; x=1727439018; i=benoit.monin@gmx.fr;
	bh=ZG5LEgDGOCZ1qbH6MY33QIaisjVOagxUHDkc1XMdF8A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Mhto5tcnkEOAVtX3FABVGqDyZZAfFRsDEdpN2j9ISrqxxgAeHyvLIZBtEaqZoLTE
	 3RT9BHmjxvz4BHEovf8ih4pw8sFKKwtCQYF6GkICrWA7QqP0pLt5PNHUbpzRbiwY+
	 NrNYCDcfD+Jt1WVz9tOSgXJdTStRgPNmOn9mPak8olAJuzbOZ+CqAFuYPAvWFufUX
	 g/GgUxKvj5qzr9hvNNiN6dEQkQ4GgDllUQtNGj8c216Arx9PDNSJmplLVEcClaS+0
	 Kq59mc3MsZTMUs+Wp2V3ySTRDOdlfbQdl+Bh9oJA0434skq9fKyYZrp8/qgw6Fdd2
	 MTrEOoBRwWJU+hSfqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pianobar.pianonet ([176.145.30.241]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWzfv-1sT4OR1s2j-00M2n1; Fri, 20
 Sep 2024 14:10:18 +0200
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@gmx.fr>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: invalid udp checksum with ip6gre-in-udp
Date: Fri, 20 Sep 2024 14:10:17 +0200
Message-ID: <26568720.1r3eYUQgxm@benoit.monin>
In-Reply-To: <2147205.9o76ZdvQCi@benoit.monin>
References:
 <26548921.1r3eYUQgxm@benoit.monin> <2147205.9o76ZdvQCi@benoit.monin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V03:K1:0reAuMyc8Oh/3IDxFOSYOXKCFoAGUF8XDhO8gMHQpFL6QP8ld7Q
 I4SMD/pqhFzJgDOoyV04fkie+JrPCjlX4FhdDIWSfMXDoa+/Ud97nxe4NC5vVDwYLa+DjjU
 6LpwXuhrMh55gALrD3hs/NCrzPnSOmisHEyWNfU/WGltyVoBYTIloSzgmNbTTadd1EPs3DM
 /gyafl+k9lBUSlpbi6NUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uI21kq+TfR4=;w1/wZZd5893nOybtzzZUVYYrFjR
 2Nmn1iZgUqN6LqVC2SFQwvrq60sS7ddasnXI7GtFjvCTu6NNVomVo/a13fnKAsrtYjyPMlZrN
 ZHZBVTv9WNwJB9JijQTIKJXVnKRJS96wbdUBg3HM/9wJythxvbW2+YhAgjI4YSL6JXhqX4JYa
 xTyHTPG19QoH9VGzgUuQh6iKALRiegTkymJnz0Pea/g/3CtYMcBiXlE89HlJ2WoN4X/qqvt86
 UZ7qNA8EUODtf2D9YSJNs4kfhiVNpl2N7zQ+f/Xk+Q1RX8CTIv63AFYg3vhfasTp+6bDeV8yl
 luaRW02LU+Yfei0V/arqjsQx5ifDEYXLFlazlYIn/DmEWpFZ0qwDWJmmmqxTJ0lod0QBruURm
 cajPSxaIsVK7OvO0AU6YCryHWdxYpdMd2rUMDsBCwnn2tsc7L9eRkevz/hBns9kkth2Y2rTH4
 YTmdk7ixcIXNM57WNBqyKyOFbUNIo1E/Ce31hcAeC0JSF9H6dr5JyCHtd7DYLJVgQEP9aYlHm
 6cQc6uW/KCjwsWKYIBcBE0B/gr7+UtCD4OVt7z6CtXgok12atXJHE0JWycZ0jTFae4RD4esyo
 B+XI/aOEnl8av0VbrjdC/wfv5H0UrbBUCa/mV6d1eOs/UID9NcmdMmGj4BtNx8AlClSL4C4O0
 OlAkiMghDpueG5GsTGLmzlA9vh+g0scA0r5y55nNwqgXNZAtCyecDiQL8N39FrIfb6kF9hHSb
 HQEz7w3EEJgVkEZE0uJBT69O+Dd/pQFD0OyQvt4dauOtCVY+ZrtczwtKiXO+YY2FEmAFTglw4
 32590g+wSFaPh3GHAFjv3EDLAcLy0Q+xj68PhtULlWEEeem58slCYrBFweLFsMDD0Nu0ghEy3
 0u5fzAnPdcJELIQ==

Hi,

12/09/2024 Beno=C3=AEt Monin :
> Hi again,
>=20
> 05/09/2024 Beno=C3=AEt Monin :
> > Hi all,
> >=20
> > I am having issue with GRE-in-UDP (GRE with fou encapsulation) over=20
> > IPv6: the outer UDP checksum is only valid if an inner checksum is=20
> > present and valid. This problem is only present over IPv6, not IPv4,=20
> > and reproducible with different kernel versions and cpu architecture.
> >=20
> > Here is the test setup I used:
> >=20
> >     +----------+                                    +------------+
> >     |          | fd00::2/64              fd00::1/64 |            |
> >     |  tester  | 10.0.0.33/24          10.0.0.11/24 |    DUT     |
> >     |          |------------------------------------|            |
> >     +----------+                                    +------------+
> >=20
> > Two machines are connected with an ethernet cable, and each side is=20
> > setup with an ipv4 and an ipv6 address.
> >=20
> > On the device under test, two GRE-in-UDP tunnels are setup, one over=20
> > ipv6 and one over ipv4, aimed at the tester. Each tunnel is configured=
=20
> > with an ipv4 address:
> >=20
> >     modprobe -a fou fou6
> >=20
> >     ip link add gre6 type ip6gre local fd00::1 remote fd00::2 encap fou=
 encap-sport 1234 encap-dport 4567
> >     ip link set up gre6
> >     ip address add 172.20.6.1/24 dev gre6
> >=20
> >     ip link add gre4 type gre local 10.0.0.11 remote 10.0.0.33 encap fo=
u encap-sport 3456 encap-dport 6789 encap-csum
> >     ip link set up gre4
> >     ip address add 172.20.4.1/24 dev gre4
> >=20
> > On the tester, no setup is done, it is only running tcpdump to capture=
=20
> > the traffic emitted by the DUT.
> >=20
> > The following commands are used on the device under test to send=20
> > packets via the tunnels:
> >=20
> >     ping -c1 -W0.1 172.20.6.2
> >     ./send_udp 172.20.6.2 5555 "ip6gre-in-udp with inner udp csum"
> >     SO_NO_CHECK=3D1 ./send_udp 172.20.6.2 5555 "ip6gre-in-udp without i=
nner udp csum"
> >     ping -c1 -W0.1 172.20.4.2
> >     ./send_udp 172.20.4.2 5555 "gre-in-udp with inner udp csum"
> >     SO_NO_CHECK=3D1 ./send_udp 172.20.4.2 5555 "gre-in-udp without inne=
r udp csum"
> >=20
> > Three packets are sent in each GRE tunnels :
> > * One ICMP echo request
> > * One UDP packet with a valid checksum
> > * One UDP packet with the checksum set to 0
> >=20
> > Here is a link to the pcap containing the six packets generated by the=
=20
> > previous commands:
> > https://onaip.mooo.com/pub/tmp/bug_ip6gre-in-udp.pcap
> >=20
> > Some details about the captured packets:
> > IP6 fd00::1 > fd00::2: 1234 > 4567: [bad udp cksum 0xfa75 -> 0xe680!]
> > IP6 fd00::1 > fd00::2: 1234 > 4567: [udp sum ok]
> > IP6 fd00::1 > fd00::2: 1234 > 4567: [bad udp cksum 0xfa62 -> 0xb57c!]
> > IP 10.0.0.11.3456 > 10.0.0.33.6789: [udp sum ok]
> > IP 10.0.0.11.3456 > 10.0.0.33.6789: [udp sum ok]
> > IP 10.0.0.11.3456 > 10.0.0.33.6789: [udp sum ok]
> >=20
> > For the tunnel over ipv6, only the UDP packet sent with a valid=20
> > checksum get encapsulated with a valid checksum. For the ping and the=20
> > UDP packet with a zero checksum, the outer UDP checksum matches the=20
> > partial checksum of the pseudo-header.
> >=20
> > For ipv4, the UDP checksum of the encapsulation are all valid.
> >=20
> > The device under test used for the capture is an x86-64 machine with a=
=20
> > realtek ethernet adapter (r8169 driver) running a 6.10.7 kernel.
> >=20
> > The problem was also seen on an arm64 board (freescale ls1046) with=20
> > dpaa ethernet driver running a 4.14 kernel. on this hardware, the=20
> > packets that would have an invalid checksum are not emitted and the tx=
=20
> > error counter of the ethernet interface increases.
> >=20
> > In all cases, disabling hardware checksumming for ipv6 with ethtool can=
=20
> > be used as a work-around:
> >=20
> >     ethtool -K eth0 tx-checksum-ipv6 off
> >=20
> > This and the partial checksum value seems to point to an error in the=20
> > handling of hardware checksumming in the particular case of fou6=20
> > encapsulation, but I have not been able to figure out what could be=20
> > causing it.
> >=20
> > Did I miss a configuration parameter for ip6gre-in-udp? Any advise on=20
> > how to debug that would be appreciated.
> >=20
> I did some more digging with 6.11-rc7, and it is not a problem in the=20
> common code or udp encapsulation, I just got "lucky" with my tests...
>=20
> First in fou6.c, fou6_build_udp constructs the upd header and calls=20
> udp6_set_csum. If the inner packet has a valid checksum, the outer udp=20
> get computed by reusing it, otherwise the partial checksum is set.
>=20
> Next the outer ipv6 is built in ip6tunnel.c:ip6_tnl_xmit. With the=20
> default value of encaplimit (4), an destination options header is=20
> inserted to pass that value. This means that ipv6_hdr(skb)->nexthdr is=20
> set to 60 (NEXTHDR_DEST), not 17 (IPPROTO_UDP).
>=20
> So when sending a packet without a valid checksum in a ip6gre-in-udp,=20
> we pass a skb with a partial udp checksum and an ipv6 header with an=20
> extension to ndo_start_xmit.
>=20
> Finally, what are the odds of testing two different hardware and=20
> finding two similar bugs?
>=20
> For the LS1046 platform, the Tx checksum is done in=20
> dpaa_enable_tx_csum. For ipv6, the layer 4 protocol is extracted from=20
> the skb with l4_proto =3D ipv6h->nexthdr. Since the value does not match=
=20
> IPPROTO_UDP nor IPPROTO_TCP, the function errors out and the packet is=20
> discarded.
>=20
> For the PC with a realtek 8169 card, the code is similar in=20
> rtl8169_tso_csum_v2, with ip_protocol =3D ipv6_hdr(skb)->nexthdr. The=20
> error case then triggers a WARN_ON_ONCE(1) and the packet is still sent=20
> on the wire with a partial udp checksum.
>=20
> There seems to be quite a few places in drivers/net/ethernet that use=20
> ipv6_hdr(skb)->nexthdr as the IP protocol, with only some of them=20
> calling ipv6_skip_exthdr afterward to take care of the extension=20
> headers. So my proposal is to add a small helper (ipv6_protocol?) and=20
> fix the drivers where needed.
>=20
> I'll try to come up with a patch set, unless someone has a better idea.
>=20
Looking more into this, I don't think the problem is in the ethernet=20
drivers. Both dpaa and r8169 declare NETIF_F_IPV6_CSUM in their=20
hw_features. The documentation for this flag says "IPv6 extension=20
headers are not supported with this feature". Yet in the call-path=20
described in my previous email, the driver gets handed an skb with both=20
an IPv6 extension header and a UDP header with a partial checksum.

Below is the ftrace of a ping sent through an ip6gre-in-udp tunnel,=20
when reaching the validate_xmit_skb call of the ethernet driver:

 3)               |                                                validate=
_xmit_skb_list() {
 3)               |                                                  valida=
te_xmit_skb() {
 3)               |                                                    neti=
f_skb_features() {
 3)               |                                                      rt=
l8169_features_check [r8169]() {
 3)   0.576 us    |                                                        =
rtl_quirk_packet_padto [r8169]();
 3)   1.812 us    |                                                      }
 3)   0.492 us    |                                                      sk=
b_network_protocol();
 3)   4.152 us    |                                                    }
 3)   0.504 us    |                                                    skb_=
csum_hwoffload_help();
 3)   0.480 us    |                                                    vali=
date_xmit_xfrm();
 3)   7.128 us    |                                                  }
 3)   8.076 us    |                                                }

The call to skb_csum_hwoffload_help does not trigger a call to=20
skb_checksum_help. I guess the bug can be reproduced with any ethernet=20
card that has tx-checksum-ipv6 set to on in its offload features.

It looks like skb_csum_hwoffload_help does not catch that particular=20
case. Again, any help would be appreciated.

=2D-=20
Beno=C3=AEt



