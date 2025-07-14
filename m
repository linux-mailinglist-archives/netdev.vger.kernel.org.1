Return-Path: <netdev+bounces-206561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6B8B037A3
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B420D188B861
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 07:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A71D22F762;
	Mon, 14 Jul 2025 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTViHupd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1569C1F3BA2
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477192; cv=none; b=fbNTca3klkTPJaWedxKvzx0joXDG4adDzaj+HuWuq71kMVG7ygUD+J8K+l3wamAePlkmL6jwnRn4XtivhZpHjY8gmj1DE2I0A4JUZRuHDBJGoEIZkLvEu1d+m6yfcTI4R3mLEAj9/F8VOR2fdTdBGXFvZZF8sCPHVbY1H0BVLZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477192; c=relaxed/simple;
	bh=clh3ftnHGnHvVcTdhpoB5quFwCDIgPRwKBWdLRGjbGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHvchKZaBPKEoitt1OyVgGJA4FZq6TKf/ymjRr5SwhCLHNZQMtP15e432dIBoaJXTU73H0M6eUvVpcFbrWze4fsaNfy1KfxmMYqCkxoPRjgRVJNqRxWwtMAzjqdWjtIZBjiwF4hXJqnU2j9sPnW1cDHPTI49LHXPdhi3hl5YgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTViHupd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7494999de5cso2437370b3a.3
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752477189; x=1753081989; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fETbeHfn8KWIu4QUCfHcN4QdA6GyDx3n1ZVT8FwO0ns=;
        b=MTViHupdj6IdeyL6Dg4cZbiWk7Lwf/v4++bcYlXbUGpU+8Qb33ReJ1b5Rs7usFQg96
         Ffc00CSeiVE+yrZ1LwxNxODYb+UfsjsQGUbEZue2X5wVvI0vpOpkLSxgpAPCl3jE6ZkM
         xthYc6dQuKvmn7s4eHLzIyaXOnaQOmJN4HK33HT+ZlngZ+LZZl8LD0tdUkxdQl3N0mwU
         gxwZ7nQNs6oh95zY+ej+jTQ0Cl/8PEOTCYL/e2YQVDww+sIfvi72JH4B/RtT8ql4orV1
         g0+b2PltU+tzg/e7kZY3wy6hrJrnw9zPIz61Ve1CPNpLBYSlCr5TzC2859nGHYZQHgEy
         hoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752477189; x=1753081989;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fETbeHfn8KWIu4QUCfHcN4QdA6GyDx3n1ZVT8FwO0ns=;
        b=aXhv8GDS//zIgLQgdrwCgqJxYMjPUFaVZvOlUPsDy60Bgghgp2YZannahX3GuHL4x6
         SlO50rECG+GhwmWHa50pl8sMpuKVWfYn+ZgczNXBP84iG+1dA1aRlKTRyZAuOgJQJzwe
         IAgpBEfSz3VyeRJuWTKI2+X3TdW8MD4swlfvg40KnMEoWbpLDSzcskMnFWt6KLDb8Vr3
         9pHptTDfQoWwDlAPelEldLw0JZ+twmZaVCyhDK9FruoEmeWdrjvmodxVsiJcB17opgpO
         QmCQzYni5tTgJiqv/45i1WA1QQO9v75eVtVuj3xfTN/CsZpY0MXkyokIDth5t2kbFm/E
         XO6Q==
X-Gm-Message-State: AOJu0YzMBHz1irxNyifIhnzXf1FqEqSALYlU1tUi89oSRlRRk9Qr0Mw6
	OxUhkFV7KDncoCc/eynbbTPP41elk44kl77QptgI15F3zCLbyqE0GB5e
X-Gm-Gg: ASbGnctN+2gouFRJSPurRMtpxIekLy2AHqKyEdHetRlUzDLNPiSA8sJVvNO1d7VWdiE
	kmT5jwu8bEp2Kx/3wMyGjmTW1v1PTWNaISZZ9i2mo2Ls7rAim6o8Pyqw1JZ4UJeUEZ2pSROG4Uu
	3romHMa1ZsCb0NT8gyyMsLWdLGNa8xjKlFa/NtqspAF+BX9dqlr5fAja5SZAskKBmF8eo+E4r6s
	HyrHECHBersesf7jbX2XkECN9gS7IlfE746+aqYRMmWzVw7gfu5oEXuQCsAnarIMusuFDUpun+s
	CEDv0ft7/ROo1+pfS+6YHKke4/xQ140Mk4aVh8VXQ07LYh+3FKjLe/SVY3xLS4gzZbFkNqbpNnv
	JWIEbiMFBbqDdDdlXCwA/KtzOLlk=
X-Google-Smtp-Source: AGHT+IF2CtDtTSrMi+xtz3ctYjIv6xyd6RR408p2MUHdWKAwKRmJ6/eIEBJXfLiWXXPVx875eUFFgg==
X-Received: by 2002:a05:6a00:1a93:b0:742:3fb4:f992 with SMTP id d2e1a72fcca58-74ee0ab681bmr16244999b3a.10.1752477189129;
        Mon, 14 Jul 2025 00:13:09 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e0697esm9800146b3a.59.2025.07.14.00.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 00:13:08 -0700 (PDT)
Date: Mon, 14 Jul 2025 07:13:00 +0000
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
Message-ID: <aHSt_BX4K4DK5CEz@fedora>
References: <20250710091636.90641-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250710091636.90641-1-tonghao@bamaicloud.com>


Hmm, I don’t see much improvement with this patch compared to without it.
So I don’t think this update is necessary.

On Thu, Jul 10, 2025 at 05:16:36PM +0800, Tonghao Zhang wrote:
> Introduce ipv6 ns/nd checking helper, using skb_header_pointer()
> instead of pskb_network_may_pull() on tx path.
> 
> alb_determine_nd introduced from commit 0da8aa00bfcfe
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
> ---
> v2:
> - in alb mode, replace bond_is_icmpv6_nd with skb_header_pointer directly,
> - and then reuse its returned data for the hash computation.
> 
> v1:
> - https://patchwork.kernel.org/project/netdevbpf/patch/20250708123251.2475-1-tonghao@bamaicloud.com/
> ---
>  drivers/net/bonding/bond_alb.c  | 47 +++++++++++----------------------
>  drivers/net/bonding/bond_main.c | 17 ++----------
>  include/net/bonding.h           | 19 +++++++++++++
>  3 files changed, 37 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 2d37b07c8215..a37709fd7475 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -19,7 +19,6 @@
>  #include <linux/in.h>
>  #include <net/arp.h>
>  #include <net/ipv6.h>
> -#include <net/ndisc.h>
>  #include <asm/byteorder.h>
>  #include <net/bonding.h>
>  #include <net/bond_alb.h>
> @@ -1280,27 +1279,6 @@ static int alb_set_mac_address(struct bonding *bond, void *addr)
>  	return res;
>  }
>  
> -/* determine if the packet is NA or NS */
> -static bool alb_determine_nd(struct sk_buff *skb, struct bonding *bond)
> -{
> -	struct ipv6hdr *ip6hdr;
> -	struct icmp6hdr *hdr;
> -
> -	if (!pskb_network_may_pull(skb, sizeof(*ip6hdr)))
> -		return true;
> -
> -	ip6hdr = ipv6_hdr(skb);
> -	if (ip6hdr->nexthdr != IPPROTO_ICMPV6)
> -		return false;
> -
> -	if (!pskb_network_may_pull(skb, sizeof(*ip6hdr) + sizeof(*hdr)))
> -		return true;
> -
> -	hdr = icmp6_hdr(skb);
> -	return hdr->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT ||
> -		hdr->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION;
> -}
> -
>  /************************ exported alb functions ************************/
>  
>  int bond_alb_initialize(struct bonding *bond, int rlb_enabled)
> @@ -1381,7 +1359,7 @@ struct slave *bond_xmit_tlb_slave_get(struct bonding *bond,
>  	if (!is_multicast_ether_addr(eth_data->h_dest)) {
>  		switch (skb->protocol) {
>  		case htons(ETH_P_IPV6):
> -			if (alb_determine_nd(skb, bond))
> +			if (bond_is_icmpv6_nd(skb))
>  				break;
>  			fallthrough;
>  		case htons(ETH_P_IP):
> @@ -1426,6 +1404,10 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
>  	struct ethhdr *eth_data;
>  	u32 hash_index = 0;
>  	int hash_size = 0;
> +	struct {
> +		struct ipv6hdr ip6;
> +		struct icmp6hdr icmp6;
> +	} *combined, _combined;
>  
>  	skb_reset_mac_header(skb);
>  	eth_data = eth_hdr(skb);
> @@ -1449,8 +1431,6 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
>  		break;
>  	}
>  	case ETH_P_IPV6: {
> -		const struct ipv6hdr *ip6hdr;
> -
>  		/* IPv6 doesn't really use broadcast mac address, but leave
>  		 * that here just in case.
>  		 */
> @@ -1467,24 +1447,29 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
>  			break;
>  		}
>  
> -		if (alb_determine_nd(skb, bond)) {
> +		/* Do not tx balance any IPv6 NS/NA packets. */
> +		combined = skb_header_pointer(skb, skb_mac_header_len(skb),
> +					      sizeof(_combined), &_combined);
> +		if (!combined || (combined->ip6.nexthdr == NEXTHDR_ICMP &&
> +				  (combined->icmp6.icmp6_type ==
> +					   NDISC_NEIGHBOUR_SOLICITATION ||
> +				   combined->icmp6.icmp6_type ==
> +					   NDISC_NEIGHBOUR_ADVERTISEMENT))) {
>  			do_tx_balance = false;
>  			break;
>  		}
>  
> -		/* The IPv6 header is pulled by alb_determine_nd */
>  		/* Additionally, DAD probes should not be tx-balanced as that
>  		 * will lead to false positives for duplicate addresses and
>  		 * prevent address configuration from working.
>  		 */
> -		ip6hdr = ipv6_hdr(skb);
> -		if (ipv6_addr_any(&ip6hdr->saddr)) {
> +		if (ipv6_addr_any(&combined->ip6.saddr)) {
>  			do_tx_balance = false;
>  			break;
>  		}
>  
> -		hash_start = (char *)&ip6hdr->daddr;
> -		hash_size = sizeof(ip6hdr->daddr);
> +		hash_start = (char *)&combined->ip6.daddr;
> +		hash_size = sizeof(combined->ip6.daddr);
>  		break;
>  	}
>  	case ETH_P_ARP:
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 17c7542be6a5..a8034a561011 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5338,10 +5338,6 @@ static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
>  					   struct net_device *dev)
>  {
>  	struct bonding *bond = netdev_priv(dev);
> -	struct {
> -		struct ipv6hdr ip6;
> -		struct icmp6hdr icmp6;
> -	} *combined, _combined;
>  
>  	if (!static_branch_unlikely(&bond_bcast_neigh_enabled))
>  		return false;
> @@ -5349,19 +5345,10 @@ static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
>  	if (!bond->params.broadcast_neighbor)
>  		return false;
>  
> -	if (skb->protocol == htons(ETH_P_ARP))
> +	if (skb->protocol == htons(ETH_P_ARP) ||
> +	    (skb->protocol == htons(ETH_P_IPV6) && bond_is_icmpv6_nd(skb)))
>  		return true;
>  
> -	if (skb->protocol == htons(ETH_P_IPV6)) {
> -		combined = skb_header_pointer(skb, skb_mac_header_len(skb),
> -					      sizeof(_combined),
> -					      &_combined);
> -		if (combined && combined->ip6.nexthdr == NEXTHDR_ICMP &&
> -		    (combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
> -		     combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT))
> -			return true;
> -	}
> -
>  	return false;
>  }
>  
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index e06f0d63b2c1..32d9fcca858c 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -29,6 +29,7 @@
>  #include <net/bond_options.h>
>  #include <net/ipv6.h>
>  #include <net/addrconf.h>
> +#include <net/ndisc.h>
>  
>  #define BOND_MAX_ARP_TARGETS	16
>  #define BOND_MAX_NS_TARGETS	BOND_MAX_ARP_TARGETS
> @@ -814,4 +815,22 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
>  	return NET_XMIT_DROP;
>  }
>  
> +static inline bool bond_is_icmpv6_nd(struct sk_buff *skb)
> +{
> +	struct {
> +		struct ipv6hdr ip6;
> +		struct icmp6hdr icmp6;
> +	} *combined, _combined;
> +
> +	combined = skb_header_pointer(skb, skb_mac_header_len(skb),
> +				      sizeof(_combined),
> +				      &_combined);
> +	if (combined && combined->ip6.nexthdr == NEXTHDR_ICMP &&
> +	    (combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
> +	     combined->icmp6.icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT))
> +		return true;
> +
> +	return false;
> +}
> +
>  #endif /* _NET_BONDING_H */
> -- 
> 2.34.1
> 

