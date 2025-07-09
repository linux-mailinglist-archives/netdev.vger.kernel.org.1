Return-Path: <netdev+bounces-205397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE07CAFE7E8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301D01698D4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A437E2D662D;
	Wed,  9 Jul 2025 11:36:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D72D8371
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061002; cv=none; b=MOzd0+Gj7d3YO3schLoLWemIw62DWnGhHwdw1TXN919khcH59xanXgQlH2wBnSiOTwewpkUzf9YnU295FTglSceaFNS10rrleFerUbMyj+Wa7t+KAdH0fD1RcmiYQdl86gLymeJPNjIWa60/2EImUQKqloI6gdvlX0nWyMQq1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061002; c=relaxed/simple;
	bh=vdK/mUulvNzF6GHgqpXR4Sz42DranKVzw9eQoQxzUmI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pARRYn2mAY9arhTrdrF19u/xx5LVNB0AZ5zvtR9BI+KQRoDhrl5NdV5JE3pee0NruO+b5UkseLItwwW61Hc3U8xhR+pkw+DagyjOZqpGAvsiXrgtPio7QdOiImXaR44bKbSCggDoDYmcG7rzYDzmbblsiRUs4skh9CPLlKknVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz9t1752060908t1022b59e
X-QQ-Originating-IP: FTJ+5qZNlxt1l1iEpdpB/ODOkEJ1zOq6LDrWxFSxA+I=
Received: from smtpclient.apple ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 09 Jul 2025 19:35:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5700698603634300007
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH net-next RESEND] net: bonding: add bond_is_icmpv6_nd()
 helper
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <196743.1752026655@famine>
Date: Wed, 9 Jul 2025 19:34:55 +0800
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3527729-560E-485C-8E1F-F335236699FD@bamaicloud.com>
References: <20250708123251.2475-1-tonghao@bamaicloud.com>
 <196743.1752026655@famine>
To: Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OBUGnm9pFasAFq/FKAKa8hVmI4obhriXcEW33RocD19GtIRM8xf2rQJQ
	RU0DFYTHVrEVQmeUAFZM3CAamneZxy75KjYrBCN5QiUlTcf4QX/qnwfHMiA7zbn5kC3+JlN
	69y9XEUTRAV79NcBburN0Je3ZINOunw5wnhk+Fz6xmEWwdfqr6YYRQB/UXzwwX33fnjVD9j
	wvz+1QNrRe3RjZsWstJECc/F881qLisJTs1pZqxfHbQjKBRlX0xfUXwN7ZdrDwunbzTEGk3
	K5QZzXJEHz2NGKbf04Bi7KGhAFlYB+F60Qcm7iOOIhBzyFcg+FPJ5oAQKZwZA++KAhDvv+j
	NEVEm6SZwZ5Cl0fbBmEWqSKR1yy/S8CdTSZOotNPbAIlmTrRRYKPjaY8g4Hj+duHAbyJgd5
	y6KJ+jSeuYUkxPgKEBAJqCmmYf3Q98AwB5JlcLd+WqNJtb3h9l9ygiBft1hp2upjWDWLnoj
	9YTYI+RXjH4A+pecUZAuSyvvFIrePRaqLweZruByGXaHGQqUuQDyO4za5jGg+Zf2whJmsSb
	EMJj38+1zWUc99guqPtsyv6du6u7d88TI+umIBiZEOkqKmxdTbVemL9vYBKiFqSaYoA829v
	q8jgcgljNKRHUxDwvAU7UCdQr28LeE2e8IXBG50jjMhYqAMsoYbEa7J2u1RNT+vm9Z6uhfF
	7XAdkwvlLRTdCUAircATWJ4js1QQJCt0rIUse6Iu6iOao3+iT9RkdfJL4eJSv0+TbPZk0O2
	bL7BnNDIDLUqo3aIgChHCA6yLgNAtCV/7MpGyzKpdZ9D3WajixYnNMKQddQ4PxhQ8HRNJdz
	fsyT6xNkANm3vKW1P0qS89FIMA9b6996D5oG68K9hs3NFdUx3ax25DOUxLUP6AnUlJGoamn
	Ywsx5oQ/kP3rBUaq6gbhYgkhblzLfhoo3JlhROU4STgVzz1Fnsz3SF7G/i13XyNxEV+h9ho
	WRAeQt4k8oDiiyrWfNuZ2uJ3RRemQ+YnNr4xANjd5RnOXhQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B47=E6=9C=889=E6=97=A5 10:04=EF=BC=8CJay Vosburgh =
<jv@jvosburgh.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>=20
>> Introduce ipv6 ns/nd checking helper, using skb_header_pointer()
>> instead of pskb_network_may_pull() on tx path.
>>=20
>> alb_determine_nd introduced from commit 0da8aa00bfcfe
>>=20
>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Cc: Nikolay Aleksandrov <razor@blackwall.org>
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>> ---
>> drivers/net/bonding/bond_alb.c  | 32 +++++++-------------------------
>> drivers/net/bonding/bond_main.c | 17 ++---------------
>> include/net/bonding.h           | 19 +++++++++++++++++++
>> 3 files changed, 28 insertions(+), 40 deletions(-)
>>=20
>> diff --git a/drivers/net/bonding/bond_alb.c =
b/drivers/net/bonding/bond_alb.c
>> index 2d37b07c8215..8e5b9ce52077 100644
>> --- a/drivers/net/bonding/bond_alb.c
>> +++ b/drivers/net/bonding/bond_alb.c
>> @@ -19,7 +19,6 @@
>> #include <linux/in.h>
>> #include <net/arp.h>
>> #include <net/ipv6.h>
>> -#include <net/ndisc.h>
>> #include <asm/byteorder.h>
>> #include <net/bonding.h>
>> #include <net/bond_alb.h>
>> @@ -1280,27 +1279,6 @@ static int alb_set_mac_address(struct bonding =
*bond, void *addr)
>> return res;
>> }
>>=20
>> -/* determine if the packet is NA or NS */
>> -static bool alb_determine_nd(struct sk_buff *skb, struct bonding =
*bond)
>> -{
>> - struct ipv6hdr *ip6hdr;
>> - struct icmp6hdr *hdr;
>> -
>> - if (!pskb_network_may_pull(skb, sizeof(*ip6hdr)))
>> - return true;
>> -
>> - ip6hdr =3D ipv6_hdr(skb);
>> - if (ip6hdr->nexthdr !=3D IPPROTO_ICMPV6)
>> - return false;
>> -
>> - if (!pskb_network_may_pull(skb, sizeof(*ip6hdr) + sizeof(*hdr)))
>> - return true;
>> -
>> - hdr =3D icmp6_hdr(skb);
>> - return hdr->icmp6_type =3D=3D NDISC_NEIGHBOUR_ADVERTISEMENT ||
>> - hdr->icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION;
>> -}
>> -
>> /************************ exported alb functions =
************************/
>>=20
>> int bond_alb_initialize(struct bonding *bond, int rlb_enabled)
>> @@ -1381,7 +1359,7 @@ struct slave *bond_xmit_tlb_slave_get(struct =
bonding *bond,
>> if (!is_multicast_ether_addr(eth_data->h_dest)) {
>> switch (skb->protocol) {
>> case htons(ETH_P_IPV6):
>> - if (alb_determine_nd(skb, bond))
>> + if (bond_is_icmpv6_nd(skb))
>> break;
>> fallthrough;
>> case htons(ETH_P_IP):
>> @@ -1467,16 +1445,20 @@ struct slave *bond_xmit_alb_slave_get(struct =
bonding *bond,
>> break;
>> }
>>=20
>> - if (alb_determine_nd(skb, bond)) {
>> + if (bond_is_icmpv6_nd(skb)) {
>> do_tx_balance =3D false;
>> break;
>> }
>>=20
>> - /* The IPv6 header is pulled by alb_determine_nd */
>> /* Additionally, DAD probes should not be tx-balanced as that
>>  * will lead to false positives for duplicate addresses and
>>  * prevent address configuration from working.
>>  */
>> + if (!pskb_network_may_pull(skb, sizeof(*ip6hdr))) {
>> + do_tx_balance =3D false;
>> + break;
>> + }
>> +
>=20
> It's nice to consolidate some duplicate code and use the more
> efficient skb_header_pointer, but the above will do a pull anyway for
> nearly every packet that passed through the function.
>=20
> Would it be better to not use the bond_is_icmpv6_nd helper here,
> but instead call skb_header_pointer directly, and then reuse its
> returned data for the hash computation that occurs just after this =
point
> in the code?
sounds good.
>=20
>> ip6hdr =3D ipv6_hdr(skb);
>> if (ipv6_addr_any(&ip6hdr->saddr)) {
>> do_tx_balance =3D false;
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index 17c7542be6a5..a8034a561011 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -5338,10 +5338,6 @@ static bool =
bond_should_broadcast_neighbor(struct sk_buff *skb,
>>    struct net_device *dev)
>> {
>> struct bonding *bond =3D netdev_priv(dev);
>> - struct {
>> - struct ipv6hdr ip6;
>> - struct icmp6hdr icmp6;
>> - } *combined, _combined;
>>=20
>> if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
>> return false;
>> @@ -5349,19 +5345,10 @@ static bool =
bond_should_broadcast_neighbor(struct sk_buff *skb,
>> if (!bond->params.broadcast_neighbor)
>> return false;
>>=20
>> - if (skb->protocol =3D=3D htons(ETH_P_ARP))
>> + if (skb->protocol =3D=3D htons(ETH_P_ARP) ||
>> +     (skb->protocol =3D=3D htons(ETH_P_IPV6) && =
bond_is_icmpv6_nd(skb)))
>> return true;
>>=20
>> - if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
>> - combined =3D skb_header_pointer(skb, skb_mac_header_len(skb),
>> -       sizeof(_combined),
>> -       &_combined);
>> - if (combined && combined->ip6.nexthdr =3D=3D NEXTHDR_ICMP &&
>> -     (combined->icmp6.icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION =
||
>> -      combined->icmp6.icmp6_type =3D=3D =
NDISC_NEIGHBOUR_ADVERTISEMENT))
>> - return true;
>> - }
>> -
>> return false;
>> }
>>=20
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
>=20
> Minor nit: no need to specify inline, the compiler will decide.
Hi Jay
If we don=E2=80=99t use the inline in the header file, the linker will =
report an error. I think we should keep the =E2=80=98inline=E2=80=99.
ld: drivers/net/bonding/bond_procfs.o: in function `bond_is_icmpv6_nd':
/root/net-next/./include/net/bonding.h:819: multiple definition of =
`bond_is_icmpv6_nd'; =
drivers/net/bonding/bond_main.o:/root/net-next/./include/net/bonding.h:819=
: first defined here
>=20
> -J
>=20
>> + struct {
>> + struct ipv6hdr ip6;
>> + struct icmp6hdr icmp6;
>> + } *combined, _combined;
>> +
>> + combined =3D skb_header_pointer(skb, skb_mac_header_len(skb),
>> +       sizeof(_combined),
>> +       &_combined);
>> + if (combined && combined->ip6.nexthdr =3D=3D NEXTHDR_ICMP &&
>> +     (combined->icmp6.icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION =
||
>> +      combined->icmp6.icmp6_type =3D=3D =
NDISC_NEIGHBOUR_ADVERTISEMENT))
>> + return true;
>> +
>> + return false;
>> +}
>> +
>> #endif /* _NET_BONDING_H */
>> --=20
>> 2.34.1
>>=20
>=20
> ---
> -Jay Vosburgh, jv@jvosburgh.net



