Return-Path: <netdev+bounces-206953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E2BB04D94
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 03:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527EA4A8194
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 01:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CDC28A712;
	Tue, 15 Jul 2025 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOvx3atA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E82A1AA
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752544158; cv=none; b=SiYv0tquJLKC4gqp7kJaxXGRh6FG9LGzraTb4bO5cQGwNlKfwlPIhTwy9MgcOAoTCVnFBzs9fv1CrUueUW5MD919dnRficuAku6cjjQsdwMc3KQizKXHeP+Tnf/qCb9NFFE34RH6ZoQx0WeYy5hha5DBo+2vZlw4xjnGoEZ4eBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752544158; c=relaxed/simple;
	bh=BsaZCLrlh5B/uzOEgng7lqbSAUSDeXwCSWxQQLtXOqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XV6bAIw3EftNBju/Mkj+Q0w/VZ9baCUomTJffFEb8oDqbzXizvI3GVtJpqhv4QxhhvDzMZTscO/WcXBTHx49qgF7+5pp970G36MvebWWKZijsI1h05IH4UTeAj9dmU6eCLssnYT5ZwfMx2pFlcWBm37ubaKrsp3NB3RuBPR+8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOvx3atA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2352400344aso45613655ad.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 18:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752544156; x=1753148956; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GluZJ4MVmr0UaAUgjzT4xAuRKlIbFwHjXvX0NXbmRI0=;
        b=hOvx3atArak1nPUbAydqqbJNFCR0OvJkGXTDWz7Rjzv5tawqz6pV83eA80umHumzaq
         dbNSmF3JpMF1MOxYr/954CA9h04o03sp+s5b+CgU6zgGuQI1FK+SqbrIm0NlO9xZItfu
         rp5h/s+SStEwAQNoZ0YnSkoLL56SZrOuSaiFunm3v6zxiOzVjSygndQ1cgohDHe6pu5d
         LlhuF8v4dhFNT2igvbyLtZCjbuNYp/mXiDJ+7mUmxE4x1hxImMFX2xA0mRu+eGgR/+iC
         RgC8lh8q4bEGCyWxaFj7jomEldyk/roQX+TlZksNNqtmBrJfbZQtwdIfEKMcxEGg5LcY
         LRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752544156; x=1753148956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GluZJ4MVmr0UaAUgjzT4xAuRKlIbFwHjXvX0NXbmRI0=;
        b=o75EfcJxCb8iea1UBnwL5nDdKNpEN+2OOHk+X4qoS6mpXMM/lAtG05NP/Ag38DobZ0
         B1GE4zH72hWZUMhwtaZ2EyH96GA1bI/6LKMMNlfI5x0nIArA9sQkD4s5qSTTTgS1XjqG
         OrpRqdxk7Wfv7jWVjMjdYDJXeD5sNCOPw3QYGQbvVndQBlGwOEL3cPjbCKjMmI+6qsAh
         XKWm5ZlVvb+c28j2RBAiMkQ90WH7RkD+gYBuU8luqopCWXzLFWex+L9+PvRgnHNfPyNr
         q8baSkR1fA/0dK3K/IkgB42vFCX27xBe399K8QD1+W/u/ZdrnjZ47ZQ9PADUS53i0CqZ
         aVgQ==
X-Gm-Message-State: AOJu0Yy/LE9djaIY9taQAa2GKwLyREzZhPvIwo4cyXP5jl+aNFNapxyg
	dj7SH6MaGbymD7zRX6OTxHC8LhHy0b9r6P6DW7YENzou4HU0p2E9FT8N
X-Gm-Gg: ASbGncvW9t5IbIfz8L/P03O+qg7X6yFqhopsQ7PciJIt2gJYb3IvHy/D1HldnCUS55Y
	eL3ErO6yThe4VwS/e2n21xTUy3o8n6rzKwSz7rKy/MODMa95EUpDKmZOPiG7p70oLVlxBwip8/1
	CBFx9OT7hEtG8Zg18A2nBBS8AKPhvNDVPtfDC1ump7PN1ed/zkQEFZQPHb5ouNKBWvGnkboyhQW
	+ZmFneyrHZWRqPQNL6/l9lmMpkX8qsOUC1BG2xP2aO4xgHSeGR8746aFc0/735AsGkJ00VOxudt
	qzBK6sgFP6O8gOprFaqb7vTKhDCBEUBOCjIY8lCiD2cjbiCLMvuYG1XOn8VWZSZdlroPVvbjwan
	kGhZQ2q9nJhyJnNLXpJGD9iwRmGtyIsBWd6wAKw==
X-Google-Smtp-Source: AGHT+IFrNXVPv6Hqk6RlNtbNwukTPFkou3888D9k+xN4qo0LgrjrhRXYSuVPyvM7TThgGWbvOdyDRw==
X-Received: by 2002:a17:903:a8f:b0:223:7006:4db2 with SMTP id d9443c01a7336-23df08e5749mr182027265ad.31.1752544155839;
        Mon, 14 Jul 2025 18:49:15 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359b22sm96163755ad.209.2025.07.14.18.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 18:49:15 -0700 (PDT)
Date: Tue, 15 Jul 2025 01:49:07 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: Re: [PATCH net-next v2] net: bonding: add bond_is_icmpv6_nd() helper
Message-ID: <aHWzk3NwurSH-Jjt@fedora>
References: <20250710091636.90641-1-tonghao@bamaicloud.com>
 <aHSt_BX4K4DK5CEz@fedora>
 <125F3BD1-1DC7-42AF-AAB4-167AD665D687@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <125F3BD1-1DC7-42AF-AAB4-167AD665D687@bamaicloud.com>

On Mon, Jul 14, 2025 at 08:53:31PM +0800, Tonghao Zhang wrote:
> 
> 
> > 2025年7月14日 15:13，Hangbin Liu <liuhangbin@gmail.com> 写道：
> > 
> > 
> > Hmm, I don’t see much improvement with this patch compared to without it.
> > So I don’t think this update is necessary.
> 
> This patch use the skb_header_pointer instead of pskb_network_may_pull. The skb_header_pointer is more efficient than pskb_network_may_pull.

I don't think skb_header_pointer is more efficient.

>  And use the comm helper can consolidate some duplicate code.
> 
> Did you see the comments by Jay. BTW, I find you add the reviewed-by tag on v1 patch.

Yes. I add review tag for v1. But for v2 I feel this doesn't reduce much
duplicate code, while it make the code more complex. Just my feeling, no offense.

I will left the patch review to Jay.

Thanks
Hangbin

> 
> > 
> > On Thu, Jul 10, 2025 at 05:16:36PM +0800, Tonghao Zhang wrote:
> >> Introduce ipv6 ns/nd checking helper, using skb_header_pointer()
> >> instead of pskb_network_may_pull() on tx path.
> >> 
> >> alb_determine_nd introduced from commit 0da8aa00bfcfe
> >> 
> >> Cc: Jay Vosburgh <jv@jvosburgh.net>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: Eric Dumazet <edumazet@google.com>
> >> Cc: Jakub Kicinski <kuba@kernel.org>
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Cc: Simon Horman <horms@kernel.org>
> >> Cc: Jonathan Corbet <corbet@lwn.net>
> >> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> >> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> >> Cc: Hangbin Liu <liuhangbin@gmail.com>
> >> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> >> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
> >> ---
> >> v2:
> >> - in alb mode, replace bond_is_icmpv6_nd with skb_header_pointer directly,
> >> - and then reuse its returned data for the hash computation.
> >> 
> >> v1:
> >> - https://patchwork.kernel.org/project/netdevbpf/patch/20250708123251.2475-1-tonghao@bamaicloud.com/
> >> ---
> >> drivers/net/bonding/bond_alb.c  | 47 +++++++++++----------------------
> >> drivers/net/bonding/bond_main.c | 17 ++----------
> >> include/net/bonding.h           | 19 +++++++++++++
> >> 3 files changed, 37 insertions(+), 46 deletions(-)
> >> 
> >> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> >> index 2d37b07c8215..a37709fd7475 100644
> >> --- a/drivers/net/bonding/bond_alb.c
> >> +++ b/drivers/net/bonding/bond_alb.c
> >> @@ -19,7 +19,6 @@
> >> #include <linux/in.h>
> >> #include <net/arp.h>
> >> #include <net/ipv6.h>
> >> -#include <net/ndisc.h>
> >> #include <asm/byteorder.h>
> >> #include <net/bonding.h>
> >> #include <net/bond_alb.h>
> >> @@ -1280,27 +1279,6 @@ static int alb_set_mac_address(struct bonding *bond, void *addr)
> >> return res;
> >> }
> >> 
> >> -/* determine if the packet is NA or NS */
> >> -static bool alb_determine_nd(struct sk_buff *skb, struct bonding *bond)
> >> -{
> >> - struct ipv6hdr *ip6hdr;
> >> - struct icmp6hdr *hdr;
> >> -
> >> - if (!pskb_network_may_pull(skb, sizeof(*ip6hdr)))
> >> - return true;
> >> -
> >> - ip6hdr = ipv6_hdr(skb);
> >> - if (ip6hdr->nexthdr != IPPROTO_ICMPV6)
> >> - return false;
> >> -
> >> - if (!pskb_network_may_pull(skb, sizeof(*ip6hdr) + sizeof(*hdr)))
> >> - return true;
> >> -
> >> - hdr = icmp6_hdr(skb);
> >> - return hdr->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT ||
> >> - hdr->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION;
> >> -}
> >> -
> >> /************************ exported alb functions ************************/
> >> 
> >> int bond_alb_initialize(struct bonding *bond, int rlb_enabled)
> >> @@ -1381,7 +1359,7 @@ struct slave *bond_xmit_tlb_slave_get(struct bonding *bond,
> >> if (!is_multicast_ether_addr(eth_data->h_dest)) {
> >> switch (skb->protocol) {
> >> case htons(ETH_P_IPV6):
> >> - if (alb_determine_nd(skb, bond))
> >> + if (bond_is_icmpv6_nd(skb))
> >> break;
> >> fallthrough;
> >> case htons(ETH_P_IP):
> >> @@ -1426,6 +1404,10 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
> >> struct ethhdr *eth_data;
> >> u32 hash_index = 0;
> >> int hash_size = 0;
> >> + struct {
> >> + struct ipv6hdr ip6;
> >> + struct icmp6hdr icmp6;
> >> + } *combined, _combined;
> >> 
> >> skb_reset_mac_header(skb);
> >> eth_data = eth_hdr(skb);
> >> @@ -1449,8 +1431,6 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
> >> break;
> >> }
> >> case ETH_P_IPV6: {
> >> - const struct ipv6hdr *ip6hdr;
> >> -
> >> /* IPv6 doesn't really use broadcast mac address, but leave
> >> * that here just in case.
> >> */
> >> @@ -1467,24 +1447,29 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
> >> break;
> >> }
> >> 
> >> - if (alb_determine_nd(skb, bond)) {
> >> + /* Do not tx balance any IPv6 NS/NA packets. */
> >> + combined = skb_header_pointer(skb, skb_mac_header_len(skb),
> >> +      sizeof(_combined), &_combined);
> >> + if (!combined || (combined->ip6.nexthdr == NEXTHDR_ICMP &&
> >> +  (combined->icmp6.icmp6_type ==
> >> +   NDISC_NEIGHBOUR_SOLICITATION ||
> >> +   combined->icmp6.icmp6_type ==
> >> +   NDISC_NEIGHBOUR_ADVERTISEMENT))) {
> >> do_tx_balance = false;
> >> break;
> >> }
> >> 
> >> - /* The IPv6 header is pulled by alb_determine_nd */
> >> /* Additionally, DAD probes should not be tx-balanced as that
> >> * will lead to false positives for duplicate addresses and
> >> * prevent address configuration from working.
> >> */
> >> - ip6hdr = ipv6_hdr(skb);
> >> - if (ipv6_addr_any(&ip6hdr->saddr)) {
> >> + if (ipv6_addr_any(&combined->ip6.saddr)) {
> >> do_tx_balance = false;
> >> break;
> >> }
> >> 
> >> - hash_start = (char *)&ip6hdr->daddr;
> >> - hash_size = sizeof(ip6hdr->daddr);
> >> + hash_start = (char *)&combined->ip6.daddr;
> >> + hash_size = sizeof(combined->ip6.daddr);
> >> break;
> >> }
> >> case ETH_P_ARP:
> >> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >> index 17c7542be6a5..a8034a561011 100644
> >> --- a/drivers/net/bonding/bond_main.c
> >> +++ b/drivers/net/bonding/bond_main.c
> >> @@ -5338,10 +5338,6 @@ static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
> >>   struct net_device *dev)
> >> {
> >> struct bonding *bond = netdev_priv(dev);
> >> - struct {
> >> - struct ipv6hdr ip6;
> >> - struct icmp6hdr icmp6;
> >> - } *combined, _combined;
> >> 
> >> if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
> >> return false;
> >> @@ -5349,19 +5345,10 @@ static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
> >> if (!bond->params.broadcast_neighbor)
> >> return false;
> >> 
> >> - if (skb->protocol == htons(ETH_P_ARP))
> >> + if (skb->protocol == htons(ETH_P_ARP) ||
> >> +    (skb->protocol == htons(ETH_P_IPV6) && bond_is_icmpv6_nd(skb)))
> >> return true;
> >> 
> >> - if (skb->protocol == htons(ETH_P_IPV6)) {
> >> - combined = skb_header_pointer(skb, skb_mac_header_len(skb),
> >> -      sizeof(_combined),
> >> -      &_combined);
> >> - if (combined && combined->ip6.nexthdr == NEXTHDR_ICMP &&
> >> -    (combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
> >> -     combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT))
> >> - return true;
> >> - }
> >> -
> >> return false;
> >> }
> >> 
> >> diff --git a/include/net/bonding.h b/include/net/bonding.h
> >> index e06f0d63b2c1..32d9fcca858c 100644
> >> --- a/include/net/bonding.h
> >> +++ b/include/net/bonding.h
> >> @@ -29,6 +29,7 @@
> >> #include <net/bond_options.h>
> >> #include <net/ipv6.h>
> >> #include <net/addrconf.h>
> >> +#include <net/ndisc.h>
> >> 
> >> #define BOND_MAX_ARP_TARGETS 16
> >> #define BOND_MAX_NS_TARGETS BOND_MAX_ARP_TARGETS
> >> @@ -814,4 +815,22 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
> >> return NET_XMIT_DROP;
> >> }
> >> 
> >> +static inline bool bond_is_icmpv6_nd(struct sk_buff *skb)
> >> +{
> >> + struct {
> >> + struct ipv6hdr ip6;
> >> + struct icmp6hdr icmp6;
> >> + } *combined, _combined;
> >> +
> >> + combined = skb_header_pointer(skb, skb_mac_header_len(skb),
> >> +      sizeof(_combined),
> >> +      &_combined);
> >> + if (combined && combined->ip6.nexthdr == NEXTHDR_ICMP &&
> >> +    (combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
> >> +     combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT))
> >> + return true;
> >> +
> >> + return false;
> >> +}
> >> +
> >> #endif /* _NET_BONDING_H */
> >> -- 
> >> 2.34.1
> >> 
> > 
> > 
> 

