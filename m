Return-Path: <netdev+bounces-153093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033069F6C38
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD2F164DD7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5611FA172;
	Wed, 18 Dec 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GTrR7uvP"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A288F1FA140
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734542400; cv=none; b=Rt6teGjGmeD+E0+1V2Bkx5mFF847qVNSqItIqnTBR4xAX4sEJtl82V/tmze4njOXJ7HXxUG7YVBB3gJ9GPVNmNOhMkAl4gGdXOGAf88G+lDgArtN5zSscFLZBHnMXl9+0j1mHxsH2RfO4Xg4AELhj9fNR7dUXWRbwnv4Vjbu2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734542400; c=relaxed/simple;
	bh=AivMHb8ytoGNObpNWW6UTdjhuHqHAsh+xUyQPvj0Kb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7LX5Jxx6wTIT+A03yMGZyEfX5QwVVgofrW4Ipensj9TUBYBFVj7hP20N3TGeIDF3bN6PNF1ylYaslfF2SVZtR5PbixvU6ybk67cVxGe9bsn5Bn8kfJk0B4DrCM5cHtK1X/p0YVLuVKU68hhO9/bek3OFhd3lZ9vN0SHjvEU6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GTrR7uvP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D47C1114019F;
	Wed, 18 Dec 2024 12:19:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 18 Dec 2024 12:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734542397; x=1734628797; bh=rWj9AFzfLSFtxPyoHRPozXP4/VlVljX3WTe
	Nl3+GOnM=; b=GTrR7uvPLKr8JXgOQ32c4p6uWlU3t40VesLATLkQ+RLyVFo/EtS
	s/5hoOEyR1khfFSlrexZDBWXU7lQCMx0EXDD+0OLstw9mrUUAELs1cWna7XT4ozs
	XB83YQeaNwPAlbF+5RAukhUgd/MfZztBd7nNTygMQ3S6fCSqCoZePsA36JruxHCy
	RIFkd6KfczUi8JA5KIBcHuQ1MIrIpvw3w8wtSN28tIG10pa3bqYTfG4HV9WXpyfo
	y3+EU6wqPipmvSHqwJ7+OHB6SVxwhIWQg0ocrGWcVjw0dfxdKog7bDmw7QZC21Mp
	r2o/d1++dCn6S7ASZuQAHmQY35defzBlPBw==
X-ME-Sender: <xms:PQRjZ8xk8MUXcmBI3QxR-_x20aV3NpBbbKRo08PTXc_3DVvbJGsejw>
    <xme:PQRjZwRP8F3tZPoYphNK1nHIIXI2c5OCGwBjYTNUsTGOjAL7gvjpKDJLakHZI-5vW
    TBuqjLmYdPMfG8>
X-ME-Received: <xmr:PQRjZ-WUXy1OIzmZJwLVWD3eSDIc1sIXC0HvZgF5JeENV1F72gdw7SqlYwEq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefg
    leekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthho
    pedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhrvghnuggvtgesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrghdp
    rhgtphhtthhopehrohhophgrsehnvhhiughirgdrtghomhdprhgtphhtthhopegsrhhiug
    hgvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    khhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:PQRjZ6iPd0-Fwuua7B_20bO1G-6Gaf0a9uqLDiDcIBF7jDW_W9zUrQ>
    <xmx:PQRjZ-DeHJyterGXPDzpu54lyls4i7-Kg--YFmwE6sXOTf0qVg1Tfw>
    <xmx:PQRjZ7LB7p88vNAug-LkE6f6mqJ_Uv3r25rhfmj8gH8Nlrax95mWjw>
    <xmx:PQRjZ1D2Y_lfKxCfiFknvZFQSowqy0Jo55MdZF7SdDDY6kkad4-uEw>
    <xmx:PQRjZ2vqr1FTBvpzF0p33MBoMl6Y5jY-7WRwjc7op0p3GgrHXOsUTeUE>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 12:19:56 -0500 (EST)
Date: Wed, 18 Dec 2024 19:19:54 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Radu Rendec <rrendec@redhat.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 2/2] net: bridge: add skb drop reasons to the
 most common drop points
Message-ID: <Z2MEOvn4dNToq5Fq@shredder>
References: <20241217230711.192781-1-rrendec@redhat.com>
 <20241217230711.192781-3-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217230711.192781-3-rrendec@redhat.com>

On Tue, Dec 17, 2024 at 06:07:11PM -0500, Radu Rendec wrote:
> @@ -520,6 +522,16 @@ enum skb_drop_reason {
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

s/SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD/SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE/

> +	 * ingress bridge port does not allow frames to be forwarded.
> +	 */
> +	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
>  	/**
>  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>  	 * shouldn't be used as a real 'reason' - only for tracing code gen
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index e19b583ff2c6d..3e9b462809b0e 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -201,6 +201,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
>  	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig,
>  	      u16 vid)
>  {
> +	enum skb_drop_reason reason = SKB_DROP_REASON_NO_TX_TARGET;
>  	struct net_bridge_port *prev = NULL;
>  	struct net_bridge_port *p;
>  
> @@ -234,8 +235,11 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
>  			continue;
>  
>  		prev = maybe_deliver(prev, p, skb, local_orig);
> -		if (IS_ERR(prev))
> +		if (IS_ERR(prev)) {
> +			WARN_ON_ONCE(PTR_ERR(prev) != -ENOMEM);

I don't think we want to see a stack trace just because someone forgot
to adjust the drop reason to the error code. Maybe just set it to
'NOMEM' if error code is '-ENOMEM', otherwise to 'NOT_SPECIFIED'.

> +			reason = SKB_DROP_REASON_NOMEM;
>  			goto out;
> +		}
>  	}
>  
>  	if (!prev)
> @@ -249,7 +253,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
>  
>  out:
>  	if (!local_rcv)
> -		kfree_skb(skb);
> +		kfree_skb_reason(skb, reason);
>  }
>  
>  #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
> @@ -289,6 +293,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
>  			struct net_bridge_mcast *brmctx,
>  			bool local_rcv, bool local_orig)
>  {
> +	enum skb_drop_reason reason = SKB_DROP_REASON_NO_TX_TARGET;
>  	struct net_bridge_port *prev = NULL;
>  	struct net_bridge_port_group *p;
>  	bool allow_mode_include = true;
> @@ -329,8 +334,11 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
>  		}
>  
>  		prev = maybe_deliver(prev, port, skb, local_orig);
> -		if (IS_ERR(prev))
> +		if (IS_ERR(prev)) {
> +			WARN_ON_ONCE(PTR_ERR(prev) != -ENOMEM);

Likewise

> +			reason = SKB_DROP_REASON_NOMEM;
>  			goto out;
> +		}
>  delivered:
>  		if ((unsigned long)lport >= (unsigned long)port)
>  			p = rcu_dereference(p->next);
> @@ -349,6 +357,6 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
>  
>  out:
>  	if (!local_rcv)
> -		kfree_skb(skb);
> +		kfree_skb_reason(skb, reason);
>  }
>  #endif
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index ceaa5a89b947f..0adad3986c77d 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -96,8 +96,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  	if (br_mst_is_enabled(br)) {
>  		state = BR_STATE_FORWARDING;
>  	} else {
> -		if (p->state == BR_STATE_DISABLED)
> -			goto drop;
> +		if (p->state == BR_STATE_DISABLED) {
> +			kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE);
> +			return 0;
> +		}

It would be good to keep the error path consolidated with 'goto drop' in
case we ever want to increment a drop counter or do something else that
is common to all the drops.

Did you consider adding a 'reason' variable that is initialized to
'SKB_DROP_REASON_NOT_SPECIFIED' and setting it to the appropriate reason
before 'goto drop'? Seems like a common pattern.

Same in br_handle_frame().

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
> +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE);
> +		return 0;
> +	}
>  
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
> +		kfree_skb_reason(skb, SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE);
>  	}
>  	return RX_HANDLER_CONSUMED;
>  }
> -- 
> 2.47.1
> 

