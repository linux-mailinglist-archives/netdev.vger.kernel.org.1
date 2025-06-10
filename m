Return-Path: <netdev+bounces-195935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4794AD2CD6
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 06:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8297A7AEE
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 04:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CBB21FF32;
	Tue, 10 Jun 2025 04:44:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065721322F
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 04:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749530660; cv=none; b=JliWfrAsGzYcGsWepk2AXKA3H5N3ir4efRbnGy1MK3vlFw3rckdmBFsDGv26uDV7AH6KKDMF21WvSlOBMlN3lRsXj6t60knNds6fbL23RSmYQ6QntrHp+FGYAizDY+zKR1CAAWB9xVBArWyvprGUtC27bzC3x8r76V8AgmIWSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749530660; c=relaxed/simple;
	bh=y7gce7+dQNMk/0n1VB4nl0chbXw5aSwyueGZLJIsCkk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PseL14P+h1GDc3BUYtY/fqD5O7/+v71x2emQknN8WEI6Zt26qGmo28EVM3TOR52vh9hjl020FP59M3SgajkJQ5Axrq0b7AAlHD/NME2SsUxBdWWro0mL4zVYwSK68HAZ/B3znnrN5OC+u/Ydn8AlD3/VMi2LOGKPS3UvWQjYIY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz1t1749530577t6c3085c9
X-QQ-Originating-IP: Wdzbb8MqYq0Zjmnmk5Dy8LJiANUZVRigVHC9ajTAw38=
Received: from smtpclient.apple ( [111.202.70.101])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Jun 2025 12:42:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2666862806305707451
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH net-next v1 1/1] net: bonding: add bond_is_icmpv6_nd()
 helper
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <4a7d32c2-1ea4-469f-bb7e-74c9ce21ab81@redhat.com>
Date: Tue, 10 Jun 2025 12:42:43 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0A9154E-B6C3-43C5-9FB3-41C08371CE3C@bamaicloud.com>
References: <20250522085703.16475-1-tonghao@bamaicloud.com>
 <4a7d32c2-1ea4-469f-bb7e-74c9ce21ab81@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>,
 Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Me7Lc1PqlyGB763eDPGj1/uHstr1YFiSuvkjri+igJGVyEc00Mon/FNW
	Wo3eBCjGkflcwr1Qgo9uEnuun82DFPBuqtaaIcTN6NV3mjTA9a/T50v+tKh/73qNzfPAXbT
	qOREQtVHlemZBG5tnSlWI9EI6JxfuguAoI4hgpyD6D+z11XyBYx1L6fNSJsHma2knGhZRaj
	lilJS2+2zJBSi0/85Pyiy/jLFJheTjK/U8qJdXT97oV5VSB5wGreHA1xXVqOL/wlhFi5bq7
	VirYGQVvozmlP06zulfT1atvPeJ+vZPL8Wh9G4gfYaFTNWvQEtMW+eTmzKRvrkg9l/b0UMu
	gWPzo33yUCQqfGICNTY3fbTlGbL98UWOclOtTcO0Yl5cxtY1If3oMZPaOwdTmK2LZTHmyR6
	uUWRtnopFF9tcbdjuNemZ4D4Jf0INS0R1CLCOzGKAJKiOpX5N65aaHM8ssxr6iC6FrwlsTz
	d2/9NMQrJgbZ/+6I2+BStfsX6RGyBBpZzPEfNTLw0HxN7x/pwKkmy+iQawZoBcGF+EkTaq5
	t6fkLbePLww+MCcL08A5QFDUB4nvU4RltjFJEodYDKAPYupGoygZlPJmtd71KovpVWKtcmo
	tu1SYVeJ+6t+UBMc/sFIkUAN3EClYc1q/g5nk2oyUjWO5eSKOnP8TLk41ZHgO+gkQsWB/gZ
	yb5UUl36NoevFCXi82nEfSY859xvNz4AmR8eQW2ZD6USB8ZtYcl+gIidFGvemfOMuClN6Ac
	/fkUz62kCRlAc1wtiegBgb6KKElT+F/Zl/LELDJvj+2FypHdYSxLXbcNe3mhv2qoeJqUhM1
	7NJm5wfAtE5CmT4CxEKCrPrBIvpC9TiMViRrKi1U3zTX9MKQcOZNsJijZIhttoFee7OUrMW
	vLTetRItWhKj1apHKxPDu1K5zTXO+4zd3ztU3PAEiPVmd3D9vXUqDnO0Ylqoqk98M/BAO1c
	I1miCUGNjLnF3IYkFSl9cwZ3HmNgLH0Cj3/dd49wxIX61d013yHhfHSmloSTVekDuu+51Jb
	m06Uq73Ug26sJCeGRrQMGXmcDVKTiFR+RTCuuLMM3wsf5bNi1I
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8828=E6=97=A5 14:39=EF=BC=8CPaolo Abeni =
<pabeni@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 5/22/25 10:57 AM, Tonghao Zhang wrote:
>> Introduce ipv6 ns/nd checking helper, using skb_header_pointer()
>> instead of pskb_network_may_pull() on tx path.
>>=20
>> alb_determine_nd introduced from commit 0da8aa00bfcfe
>=20
> The patch does not apply cleanly. Please rebase and repost after the
> merge window.
>=20
>> diff --git a/include/net/bonding.h b/include/net/bonding.h
>> index e06f0d63b2c1..32d9fcca858c 100644
>> --- a/include/net/bonding.h
>> +++ b/include/net/bonding.h
>> @@ -29,6 +29,7 @@
>> #include <net/bond_options.h>
>> #include <net/ipv6.h>
>> #include <net/addrconf.h>
>> +#include <net/ndisc.h>
>>=20
>> #define BOND_MAX_ARP_TARGETS 16
>> #define BOND_MAX_NS_TARGETS BOND_MAX_ARP_TARGETS
>> @@ -814,4 +815,22 @@ static inline netdev_tx_t bond_tx_drop(struct =
net_device *dev, struct sk_buff *s
>> return NET_XMIT_DROP;
>> }
>>=20
>> +static inline bool bond_is_icmpv6_nd(struct sk_buff *skb)
>> +{
>> + struct {
>> + struct ipv6hdr ip6;
>> + struct icmp6hdr icmp6;
>> + } *combined, _combined;
>> +
>> + combined =3D skb_header_pointer(skb, skb_mac_header_len(skb),
>> +      sizeof(_combined),
>> +      &_combined);
>> + if (combined && combined->ip6.nexthdr =3D=3D NEXTHDR_ICMP &&
>> +    (combined->icmp6.icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION =
||
>> +     combined->icmp6.icmp6_type =3D=3D =
NDISC_NEIGHBOUR_ADVERTISEMENT))
>> + return true;
>> +
>> + return false;
>> +}
>=20
> No need to put this helper in public headers, you could use
> drivers/net/bonding/bonding_priv.h instead.

I found most public functions are in include/net/bonding.h. They are not =
in drivers/net/bonding/bonding_priv.h. So placing this new function in =
include/net/bonding.h is better.

Also, this patch is an optimization based on my other patch set. Merge =
this patch after that set is accepted.

> /P
>=20
>=20


