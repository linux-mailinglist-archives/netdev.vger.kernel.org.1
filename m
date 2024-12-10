Return-Path: <netdev+bounces-150573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F21619EABC0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EDA1649C0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCEC19A2A2;
	Tue, 10 Dec 2024 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="HaWkhpKj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA202AEE7
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822292; cv=none; b=dxswwX03h5emZhdo0RvDqtYIyAa0Jn2jtEifj2FpzMuYlT0tYaRZPgpSYXZKtBNvd34utyJFpihuU+DFHDri/KNV0EA+rYM2PDdpTy7q+SyxlNK5xD4VDUVqLZpl+qpteP1KNwLGk656AjdnOZy4aI29PTT7OfoYkRrxdA+CD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822292; c=relaxed/simple;
	bh=BHIwuyVRVDTramqPxGogCek36o5nJEkzLna4vKGthYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZuMNHbTsQIFa6rqa4kpZbVTjherD3j3REwpX1CGznftL+sMMTXk1a4PSxsnqE1aV/WgczZHWwPdLQaG/FT3DYuCNRdaXK8WAwJkl6S0m/cnRMGSr+nulOoSmeUfhxRGy64ONykTzcGeqVZS9HKvK6r8p9Ly0kitTftkNqkxbiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=HaWkhpKj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa679ad4265so393341966b.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 01:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733822288; x=1734427088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynIeX8CMo+FB5eBdTlxaT5BUGhWdIHXwoHgPtyiP0u4=;
        b=HaWkhpKjF5z/3LKheYmCsuL2iMtRk1xfmtw6QpMTeyHpD4LP8t+W+PxGdiITFAyOIe
         /HDzPftaL69fv/clulnqYCTyZPBO57ZW5pj8nhMEDJf0rXpVSBx4ts2LTwpFYjNQYj86
         0Yu3EoZLorqal/ASQkRRCSy4G4oG5rRmryMQGbCXrsWD2+PuNvvWe9Cv0xQsh8Aon85g
         yI7mBHkODC1Jnd7Avd6KU8txTb9LGOtBKtdPwpWASPsxQVgegsCH72k7nW6urGF+RMUB
         ZnZjd81COYwk2sBK1vpXfY9VHdW1b51lspHovb1Rot2Dr67KHYRb40r/m0NMqK4imEeT
         zS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822288; x=1734427088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynIeX8CMo+FB5eBdTlxaT5BUGhWdIHXwoHgPtyiP0u4=;
        b=LWBzoNVzNwSvp90nkWzU/YggcbYpv/mR9d1f1u8wKX8PJf82tcOzjGCGhRmEiq7Qcm
         JHxhKPxUmeUqS0l7FLOwceRxCN/KrHQ9n0Tc4INE6HZzQAOgUaHOMvxOtJX93NVHWeYG
         3sNZXgk6g4m1ZaViDpkTBhcPctm+ED5IegShIYiisC9PhqZhPZPRIK/VKE1SI38mj8aF
         I3DGNCx2WOLw+rU7x+YfByaX/C8C7GO8meGixKzPzJOf/Q/Joj6ia4cteG176WE2KNoT
         4VaJmUplh5yY14kzH8ud95GYa5K9DfPXIkyewqgfZnrBSe1tm1w9PJoQzZ3ZW6vfi1GK
         1Akw==
X-Forwarded-Encrypted: i=1; AJvYcCV9zcKtfD+Ef+5yq80YtM8gL7i4i0W9f1fq6ZV3CAjYieiixvhg3ab0aVvxK+d3XKEAwbM2zV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXy/c3w6XBNqeTB9uOz6KYNjhKSDalnzumljh0kBNb6O6EReWa
	1RmvwpONu3SZWArA4KgnmN/IeFclRIEhHM4GGW4/9WIGwI9EL2v/BaD0MZnZaU4=
X-Gm-Gg: ASbGncvzy1eW44kd0DsKPEkleAK34RERjBUjS2QsASpHk6AUZBkbxMbdoSXsT6bhMbf
	rRmYtI0bSCCZvyrFA+cJDTXIL82iID1PF2Jp8Vcu4OXPVRYOc3O/Ah4nMX/2NfsoSXbyF58HZS/
	3OX6pxQa9YFb7J1S5FfU3Pi9ImBqQ/9CkoPDxbd4Npq46OxciShI+KGcu1C4mVAuDuVJK2H5kkg
	T862jRtjADsDVu1MGYoNVrwrqK49d3o9ZbuPbXjPt7RYaSu78s40Da0
X-Google-Smtp-Source: AGHT+IHt+ztASsOAIEt43c3x+zcLdVr12T5oX+eMBT4pTUFNWrnSCeXg29EJFBXBd9jNq3Mfw6VbKA==
X-Received: by 2002:a17:906:3089:b0:aa6:7c36:3428 with SMTP id a640c23a62f3a-aa69fe12147mr278318366b.0.1733822288267;
        Tue, 10 Dec 2024 01:18:08 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67d6fcd3dsm352670366b.80.2024.12.10.01.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:18:07 -0800 (PST)
Message-ID: <2283799b-e1fe-42c2-aecc-50c4ae1f9afa@blackwall.org>
Date: Tue, 10 Dec 2024 11:18:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/bridge: Add skb drop reasons to the most
 common drop points
To: Radu Rendec <rrendec@redhat.com>, Roopa Prabhu <roopa@nvidia.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20241208221805.1543107-1-rrendec@redhat.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241208221805.1543107-1-rrendec@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 00:18, Radu Rendec wrote:
> The bridge input code may drop frames for various reasons and at various
> points in the ingress handling logic. Currently kfree_skb() is used
> everywhere, and therefore no drop reason is specified. Add drop reasons
> to the most common drop points.
> 
> The purpose of this patch is to address the most common drop points on
> the bridge ingress path. It does not exhaustively add drop reasons to
> the entire bridge code. The intention here is to incrementally add drop
> reasons to the rest of the bridge code in follow up patches.
> 
> Most of the skb drop points that are addressed in this patch can be
> easily tested by sending crafted packets. The diagram below shows a
> simple test configuration, and some examples using `packit`(*) are
> also included. The bridge is set up with STP disabled.
> (*) https://github.com/resurrecting-open-source-projects/packit
> 
> The following changes were *not* tested:
> * SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT in br_multicast_flood(). I could
>   not find an easy way to make a crafted packet get there.
> * SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD in br_handle_frame_finish()
>   when the port state is BR_STATE_DISABLED, because in that case the
>   frame is already dropped in the switch/case block at the end of
>   br_handle_frame().
> 
>     +---+---+
>     |  br0  |
>     +---+---+
>         |
>     +---+---+  veth pair  +-------+
>     | veth0 +-------------+ xeth0 |
>     +-------+             +-------+
> 
> SKB_DROP_REASON_MAC_INVALID_SOURCE - br_handle_frame()
> packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
>   -e 01:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
>   -p '0x de ad be ef' -i xeth0
> 
> SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL - br_handle_frame()
> packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
>   -e 02:22:33:44:55:66 -E 01:80:c2:00:00:01 -c 1 \
>   -p '0x de ad be ef' -i xeth0
> 
> SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD - br_handle_frame()
> bridge link set dev veth0 state 0 # disabled
> packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
>   -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
>   -p '0x de ad be ef' -i xeth0
> 
> SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD - br_handle_frame_finish()
> bridge link set dev veth0 state 2 # learning
> packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
>   -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
>   -p '0x de ad be ef' -i xeth0
> 
> SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT - br_flood()
> packit -t UDP -s 192.168.0.1 -d 192.168.0.2 -S 8000 -D 8000 \
>   -e 02:22:33:44:55:66 -E aa:bb:cc:dd:ee:ff -c 1 \
>   -p '0x de ad be ef' -i xeth0
> 
> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> ---
>  include/net/dropreason-core.h | 18 ++++++++++++++++++
>  net/bridge/br_forward.c       |  4 ++--
>  net/bridge/br_input.c         | 24 +++++++++++++++---------
>  3 files changed, 35 insertions(+), 11 deletions(-)
> 

Hi,
Thanks for working on this, a few comments below.

> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index c29282fabae6..1f2ae5b387c1 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -108,6 +108,9 @@
>  	FN(TUNNEL_TXINFO)		\
>  	FN(LOCAL_MAC)			\
>  	FN(ARP_PVLAN_DISABLE)		\
> +	FN(MAC_IEEE_MAC_CONTROL)	\
> +	FN(BRIDGE_INGRESS_PORT_NFWD)	\
> +	FN(BRIDGE_NO_EGRESS_PORT)	\
>  	FNe(MAX)
>  
>  /**
> @@ -502,6 +505,21 @@ enum skb_drop_reason {
>  	 * enabled.
>  	 */
>  	SKB_DROP_REASON_ARP_PVLAN_DISABLE,
> +	/**
> +	 * @SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL: the destination MAC address
> +	 * is an IEEE MAC Control address.
> +	 */
> +	SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL,
> +	/**
> +	 * @SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD: the STP state of the
> +	 * ingress bridge port does not allow frames to be forwarded.
> +	 */
> +	SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD,

Since this is used only when the port state causes the packet to drop, why not
rename it to something that suggests it was the state?

> +	/**
> +	 * SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT: no eligible egress port was
> +	 * found while attempting to flood the frame.
> +	 */
> +	SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT,
>  	/**
>  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>  	 * shouldn't be used as a real 'reason' - only for tracing code gen
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index e19b583ff2c6..e33e2f4fc3d9 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -249,7 +249,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
>  
>  out:
>  	if (!local_rcv)
> -		kfree_skb(skb);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);

This is not entirely correct, we can get here if we had an error forwarding
the packet to some port, but it may already have been forwarded to others.
The reason should distinguish between those two cases.

>  }
>  
>  #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
> @@ -349,6 +349,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
>  
>  out:
>  	if (!local_rcv)
> -		kfree_skb(skb);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_NO_EGRESS_PORT);

Same comment as above (br_flood).

>  }
>  #endif
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index ceaa5a89b947..fc00e172e1e1 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -96,8 +96,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  	if (br_mst_is_enabled(br)) {
>  		state = BR_STATE_FORWARDING;
>  	} else {
> -		if (p->state == BR_STATE_DISABLED)
> -			goto drop;
> +		if (p->state == BR_STATE_DISABLED) {
> +			kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> +			return 0;
> +		}
>  
>  		state = p->state;
>  	}
> @@ -155,8 +157,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  		}
>  	}
>  
> -	if (state == BR_STATE_LEARNING)
> -		goto drop;
> +	if (state == BR_STATE_LEARNING) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
> +		return 0;
> +	}>  
>  	BR_INPUT_SKB_CB(skb)->brdev = br->dev;
>  	BR_INPUT_SKB_CB(skb)->src_port_isolated = !!(p->flags & BR_ISOLATED);
> @@ -331,8 +335,10 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
>  	if (unlikely(skb->pkt_type == PACKET_LOOPBACK))
>  		return RX_HANDLER_PASS;
>  
> -	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
> -		goto drop;
> +	if (!is_valid_ether_addr(eth_hdr(skb)->h_source)) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_MAC_INVALID_SOURCE);
> +		return RX_HANDLER_CONSUMED;
> +	}
>  
>  	skb = skb_share_check(skb, GFP_ATOMIC);
>  	if (!skb)
> @@ -374,7 +380,8 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
>  			return RX_HANDLER_PASS;
>  
>  		case 0x01:	/* IEEE MAC (Pause) */
> -			goto drop;
> +			kfree_skb_reason(skb, SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL);
> +			return RX_HANDLER_CONSUMED;
>  
>  		case 0x0E:	/* 802.1AB LLDP */
>  			fwd_mask |= p->br->group_fwd_mask;
> @@ -423,8 +430,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
>  
>  		return nf_hook_bridge_pre(skb, pskb);
>  	default:
> -drop:
> -		kfree_skb(skb);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD);
>  	}
>  	return RX_HANDLER_CONSUMED;
>  }

Cheers,
 Nik


