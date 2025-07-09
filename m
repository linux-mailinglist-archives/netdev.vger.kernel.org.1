Return-Path: <netdev+bounces-205211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D990FAFDCED
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1171C22E76
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94B156F4A;
	Wed,  9 Jul 2025 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6Cr1snx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B380C1C
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024561; cv=none; b=g8tseaFAZpUEbKqoaNT2SOhSTGKRbgJVbZPMbMinc/chHY7RqAKNIdO57XnNeOhVQC3BpmGl/PeRUQPDiQ9EZJrcHRlYloTUvDtapg4dmBT+CvFBgnQQw0rUtwM6ws74//LiPRCeLcZ8pLtJqtR0VaPeFFOA4KN268cbS+C6qJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024561; c=relaxed/simple;
	bh=bzY0BMdmvnQ5JUK9Qyphy/5Xs3B4///qbMxcLeo/Zjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKjnA4mIGq/xiXCUdWVdkFnpVZahpIV3u5Jo/LrR2e6daTim1JzFQrOjg/myuOZkDVZPDtecUZsqg2E4SUDRQYKls0Fgi9xNOan++0kzgyUTRKX+O0tml95fX+rijIMHWYeoIHLHvV63e/7l0i94Fq6SabZL07S2zYwGZTv8Nvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6Cr1snx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234b9dfb842so46035715ad.1
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 18:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752024559; x=1752629359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mbIP4XY2LBVGDkge568xIuQUN1/lWfpXfznkvCCzeRs=;
        b=K6Cr1snxEvbjokSCTORepTHHHS3WxH+v3dSebmun38ki0M2VZKEAVH9MifS8VA2woH
         ZMARR35i3CL4HwY0pY1p179WrZicY/QEgkMkhLmfwseu100/BycQdq1IJNeqFRFskcWR
         iNi8Of4WwWqdclGM+SX+MHONrs36nfb0ybb/L7QOgfXJ+S++6xJyNdeCX25h+ZSbd8Pc
         IBKkMhOV6VvbAPFrLaF65AuWQoFu0DxmGqG9tqnmakYAfjaBoSSKQBLZZZH84yAuX0cO
         3BUAk8UeYWDBoni7Zsq7pXLScyKtZZGRqQz4mrRUZZk50Qfh7Fqmg6V537L44eUA5YuD
         nSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752024559; x=1752629359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbIP4XY2LBVGDkge568xIuQUN1/lWfpXfznkvCCzeRs=;
        b=NcpQOKR7ayV9PCFu3kL/kbIHSCfkoH9LkIMA1+fjHlMm2yilE9pJ8ZDDa9xSbAJ6wr
         e/Aq4R102la0uhDCFLrK9POBXc374CzAH3JVuMRP5Vc/wXx0dhKDE2RuNVgb84hAT+OG
         bEwioS3beJXQM7IpjH/by8WBNmCnnZussgl198AQvql+jIUr1zpnvH4fXMUCDRpQyLOz
         8l22QWN1yKrbG7950/qVJuCfKGZ8hb373ltVfVtqenE+Ef9tLDlwMcImypQ8JhsyGL43
         kX7tojxNSKDvnbi3Jyf1sL7lpFXUlPcWLTnXP8PS0ifpFhDlJ2cMRGtrw9Vfd7SZk6ul
         oc7Q==
X-Gm-Message-State: AOJu0Yy0BEoxKdHB1ROZrZ10lrlzmbUGMXcjnob4ORYt8xZy8TN8dlhx
	IPS8FpGDWhaRhk2CJ++s74D5JsZSfj1juS/6R+b1UiaEP3a4wkksUJUWYuGPD2GV
X-Gm-Gg: ASbGncsvNBYWAC9bTk8/tvFS1+FzeH8MAJTETH+d+8uZ9Sc+AqA6J8aTndoWaX6KVJl
	POswABLh7TL+HDhGZDQvswIIpVDf5XEkR8BFwjsu8W/OPfIb5OJePyxrWeXiu1P8j/wSj9a5QzG
	hTma1yp/KbkFOCAZh/xR1dLP/kzHasrsIx/U+/Iq9Zz4J1pHhDuYvaqtjNDterDkDg8EiNq+tAr
	0zLF99XEsOKUWtVmXuPq2Fs+DZRoHT1C/ZvePeehilfjSCTQAMyZo2OHWzVKGC4iK1vwvBLgP23
	OUgrHUl5AGgvYfroZDL1P27KXpMMXku4lEwfY00dqVPZW0vxSdtcyj8QOD1DRJyExS8=
X-Google-Smtp-Source: AGHT+IH8aYggj+EU/WQOpwpjNYimKQOIRZgm4GcaWqKyIM60ErEohxxD8ybbWUlZTeCXuUuovAMJ7w==
X-Received: by 2002:a17:902:d541:b0:235:225d:3098 with SMTP id d9443c01a7336-23ddb327711mr10125245ad.46.1752024558676;
        Tue, 08 Jul 2025 18:29:18 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8435022dsm130578285ad.86.2025.07.08.18.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:29:18 -0700 (PDT)
Date: Wed, 9 Jul 2025 01:29:10 +0000
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
Subject: Re: [PATCH net-next RESEND] net: bonding: add bond_is_icmpv6_nd()
 helper
Message-ID: <aG3F5mPOQiD8yIjK@fedora>
References: <20250708123251.2475-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708123251.2475-1-tonghao@bamaicloud.com>

On Tue, Jul 08, 2025 at 08:32:51PM +0800, Tonghao Zhang wrote:
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
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
> ---
>  drivers/net/bonding/bond_alb.c  | 32 +++++++-------------------------
>  drivers/net/bonding/bond_main.c | 17 ++---------------
>  include/net/bonding.h           | 19 +++++++++++++++++++
>  3 files changed, 28 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 2d37b07c8215..8e5b9ce52077 100644
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
> @@ -1467,16 +1445,20 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
>  			break;
>  		}
>  
> -		if (alb_determine_nd(skb, bond)) {
> +		if (bond_is_icmpv6_nd(skb)) {
>  			do_tx_balance = false;
>  			break;
>  		}
>  
> -		/* The IPv6 header is pulled by alb_determine_nd */
>  		/* Additionally, DAD probes should not be tx-balanced as that
>  		 * will lead to false positives for duplicate addresses and
>  		 * prevent address configuration from working.
>  		 */
> +		if (!pskb_network_may_pull(skb, sizeof(*ip6hdr))) {
> +			do_tx_balance = false;
> +			break;
> +		}
> +
>  		ip6hdr = ipv6_hdr(skb);
>  		if (ipv6_addr_any(&ip6hdr->saddr)) {
>  			do_tx_balance = false;
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

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

