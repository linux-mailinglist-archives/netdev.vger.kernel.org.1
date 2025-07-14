Return-Path: <netdev+bounces-206662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16CDB03F06
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1267A1BE4
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B89248863;
	Mon, 14 Jul 2025 12:54:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55683248F5A
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497642; cv=none; b=NTVsrgRzr+khiKkaNQH/5r5WWQJJEgZYsSMaG/G/eLyK1pjchpTxchCbE8KkHzyPUWHg7CNv5mK3WVn85QoNleKGwHdtlZLWGYRtryel5Trh5mEmMrK5St1VWjDY23c1u8/Hc0dJHsg7qsT7X8wQkfxNCUzbUbfq4ffwzp2cGNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497642; c=relaxed/simple;
	bh=eMuYi+uAVnEHJHgGMPVoBHLqa0/2g+J1mUmquTijqmI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WyD8QxPrNKgXv2ePijoZwmxZvyrzTyepLqAAIif701oHEzXcNOhjmNwTaakw+0GrARS+O51ElpoL8LKogZjA2qeEAGW4xTiX1HCIptRMQaC2KPKFAHswrYmIByVFQsNy/7Y1YhBqj+nkoolXSwRI49D5HlBr7yjVmnEl1fOPbzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz3t1752497624tf4886e3c
X-QQ-Originating-IP: QAOvHlqTloy6qt4HVumgTAm/DGT7/TyBYPLR4xObBmk=
Received: from smtpclient.apple ( [111.202.70.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Jul 2025 20:53:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16128484870943750075
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH net-next v2] net: bonding: add bond_is_icmpv6_nd() helper
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <aHSt_BX4K4DK5CEz@fedora>
Date: Mon, 14 Jul 2025 20:53:31 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
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
Message-Id: <125F3BD1-1DC7-42AF-AAB4-167AD665D687@bamaicloud.com>
References: <20250710091636.90641-1-tonghao@bamaicloud.com>
 <aHSt_BX4K4DK5CEz@fedora>
To: Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NqN/wpVFVRYXE5sYSpd2Lc/HXyC19vUCvhBIq2EzgPi0B+CISLjElDd2
	UOO++Aoo0YFmhGurE6Z4eTCid2dIssXCC0lfCAjLW/cM+8Ztyu0oE7nMOHCm29F2MJiwqkJ
	3bkc5WeLQnWZSDLuY8e1TWgQAxJ4U3zT6wNh6gdG2Qrc3M7SDzVvWoiYW0JU21CWGaY3Pl3
	jI4O+YYjdMQPXDQIkya10aTZ5p1G85nXhk7/ZqRKKZCI2av/8kVjNnfhnrUDaJwTgJeBXlK
	gOSvvrZhDz62IZf+kBbr7m9jLMxFrtOC4gaYVVcfcJXb3Tz/u5x6Hi4Ki5lvYneWN71CDJs
	h9pjN3P0udgjsB/7amlGAXuCheUsK6wlTn1aCwRD5CoFX/qOBbGFX4DMofb8bfWgE4t37S4
	8//lhGjEbHeKyEQNxLiY/G+vH8s0Pln7J81PXGAfxVxvxurw0B5o14o8cQfkhaY7SdGu2SX
	EWy/7zUni6FZ/nGhUMeA+O5iln2z5pcfUnX+flx5pjAgIgvslu8kWrcWAnGujybDJgEP9qG
	y0yOZ96ge6BQh8pz55tTlvyy7QIngL2FFBDzYMSjeHVg6K1LaKN/hDAdnCH+KlG4+pKYd3M
	9EME6aBdattt4A7vK4+LMCxPC1/a0NtZKRzO90mq1Sr8oVI0FJ6+vVlhBcFHfgic7IE2Cw2
	rJOk9pG38ikiXWJAo5ZNkY2TjB8yYQLlxXwYWKDas01uA9Hxjc19HdeVxm4Kx/IO4epeGoV
	iDDLouDcTUkCS4O0/LGO1s2RkzNwpLEykzQZ4rRU4eR5QngHn19ZxrYDTsHq03Os0aZtO3I
	7kpDfgYJPh4Os2n7MvAckWchVapYCTdnenBU1RmDoiA4yf5mlqpXZpWzID0v/qiCu4lr/Xo
	0Guc+X0EQaj1zHOrqmAP8WinKqAjLB6sEsaT9IMDsVfPpxM4d0zX4UwtV7VxiA13upJY4I9
	cZfXoDVeMxw2iNs/oHfXhhLsivd5NSNJrZ9w4kygrxHcZq4+SCS6U24dLffNnv2pmTIg=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B47=E6=9C=8814=E6=97=A5 15:13=EF=BC=8CHangbin Liu =
<liuhangbin@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> Hmm, I don=E2=80=99t see much improvement with this patch compared to =
without it.
> So I don=E2=80=99t think this update is necessary.

This patch use the skb_header_pointer instead of pskb_network_may_pull. =
The skb_header_pointer is more efficient than pskb_network_may_pull.
 And use the comm helper can consolidate some duplicate code.

Did you see the comments by Jay. BTW, I find you add the reviewed-by tag =
on v1 patch.

>=20
> On Thu, Jul 10, 2025 at 05:16:36PM +0800, Tonghao Zhang wrote:
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
>> Cc: Hangbin Liu <liuhangbin@gmail.com>
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>> ---
>> v2:
>> - in alb mode, replace bond_is_icmpv6_nd with skb_header_pointer =
directly,
>> - and then reuse its returned data for the hash computation.
>>=20
>> v1:
>> - =
https://patchwork.kernel.org/project/netdevbpf/patch/20250708123251.2475-1=
-tonghao@bamaicloud.com/
>> ---
>> drivers/net/bonding/bond_alb.c  | 47 =
+++++++++++----------------------
>> drivers/net/bonding/bond_main.c | 17 ++----------
>> include/net/bonding.h           | 19 +++++++++++++
>> 3 files changed, 37 insertions(+), 46 deletions(-)
>>=20
>> diff --git a/drivers/net/bonding/bond_alb.c =
b/drivers/net/bonding/bond_alb.c
>> index 2d37b07c8215..a37709fd7475 100644
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
>> @@ -1426,6 +1404,10 @@ struct slave *bond_xmit_alb_slave_get(struct =
bonding *bond,
>> struct ethhdr *eth_data;
>> u32 hash_index =3D 0;
>> int hash_size =3D 0;
>> + struct {
>> + struct ipv6hdr ip6;
>> + struct icmp6hdr icmp6;
>> + } *combined, _combined;
>>=20
>> skb_reset_mac_header(skb);
>> eth_data =3D eth_hdr(skb);
>> @@ -1449,8 +1431,6 @@ struct slave *bond_xmit_alb_slave_get(struct =
bonding *bond,
>> break;
>> }
>> case ETH_P_IPV6: {
>> - const struct ipv6hdr *ip6hdr;
>> -
>> /* IPv6 doesn't really use broadcast mac address, but leave
>> * that here just in case.
>> */
>> @@ -1467,24 +1447,29 @@ struct slave *bond_xmit_alb_slave_get(struct =
bonding *bond,
>> break;
>> }
>>=20
>> - if (alb_determine_nd(skb, bond)) {
>> + /* Do not tx balance any IPv6 NS/NA packets. */
>> + combined =3D skb_header_pointer(skb, skb_mac_header_len(skb),
>> +      sizeof(_combined), &_combined);
>> + if (!combined || (combined->ip6.nexthdr =3D=3D NEXTHDR_ICMP &&
>> +  (combined->icmp6.icmp6_type =3D=3D
>> +   NDISC_NEIGHBOUR_SOLICITATION ||
>> +   combined->icmp6.icmp6_type =3D=3D
>> +   NDISC_NEIGHBOUR_ADVERTISEMENT))) {
>> do_tx_balance =3D false;
>> break;
>> }
>>=20
>> - /* The IPv6 header is pulled by alb_determine_nd */
>> /* Additionally, DAD probes should not be tx-balanced as that
>> * will lead to false positives for duplicate addresses and
>> * prevent address configuration from working.
>> */
>> - ip6hdr =3D ipv6_hdr(skb);
>> - if (ipv6_addr_any(&ip6hdr->saddr)) {
>> + if (ipv6_addr_any(&combined->ip6.saddr)) {
>> do_tx_balance =3D false;
>> break;
>> }
>>=20
>> - hash_start =3D (char *)&ip6hdr->daddr;
>> - hash_size =3D sizeof(ip6hdr->daddr);
>> + hash_start =3D (char *)&combined->ip6.daddr;
>> + hash_size =3D sizeof(combined->ip6.daddr);
>> break;
>> }
>> case ETH_P_ARP:
>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>> index 17c7542be6a5..a8034a561011 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -5338,10 +5338,6 @@ static bool =
bond_should_broadcast_neighbor(struct sk_buff *skb,
>>   struct net_device *dev)
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
>> +    (skb->protocol =3D=3D htons(ETH_P_IPV6) && =
bond_is_icmpv6_nd(skb)))
>> return true;
>>=20
>> - if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
>> - combined =3D skb_header_pointer(skb, skb_mac_header_len(skb),
>> -      sizeof(_combined),
>> -      &_combined);
>> - if (combined && combined->ip6.nexthdr =3D=3D NEXTHDR_ICMP &&
>> -    (combined->icmp6.icmp6_type =3D=3D NDISC_NEIGHBOUR_SOLICITATION =
||
>> -     combined->icmp6.icmp6_type =3D=3D =
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
>> +
>> #endif /* _NET_BONDING_H */
>> --=20
>> 2.34.1
>>=20
>=20
>=20


