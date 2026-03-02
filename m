Return-Path: <netdev+bounces-262645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ+OOM6KpWk4DgYAu9opvQ
	(envelope-from <netdev+bounces-262645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:04:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 902DA1D96C7
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06DB83016B94
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 13:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A427A3D9035;
	Mon,  2 Mar 2026 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="WbmfOg+4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59C93D7D7C
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456550; cv=none; b=A9sz1zHNSAT/9KjFlW5CxEG3DPZ8ieyYPqW4OwJNW8e3rIV3M02rtj9LlpaDtmKF0Jyv4ycMgPTburO0LG1j87Vpz3O0qAHcvg/J3k4Xp69in2Oi7FezIyVqd6exoqQJo0gTz8kKn74gms74JItXH4NtpFD5qltCuVP0VKqVR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456550; c=relaxed/simple;
	bh=vE/lYEZyUZyWrX7dEGM1mz947xLpTBkb/sXTqs/xZFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN1GOzMABWEWij1EbbcfCK5RVoQKBAOp5n+DMAudRbLSQ7COY7DGvhJF6o4M96m0Bh5Ty6qO/CzJttI4ns53hZQLmCFmE4MceEQifrK0RATmmnWFUyhqVf4OmSZS0WzD2wGrvaE14jCsx7r6bWI+MP2gLLvdJDQteMaOsqcGc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=WbmfOg+4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4837634de51so18038515e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 05:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1772456545; x=1773061345; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9/FjIYbH8rLK7M1wySsOhpB5kk1nqA9iYm40NdHpoF0=;
        b=WbmfOg+4ow9kuF9P3jAI1SaJTSMTL/u6tjQCU6gOJBD398MbGU+5T8maX3qgkb2tym
         CapHJc2xBAA4ZExmPfyphB5I7gRnl3rdY4VEEGBvV2Mv6OUG5cCUByaJStveC9TbqPll
         5te5CFawWlBaYFWpppzHQNdK7YRtDQqzftM9a5sXmEr8FgqMeH94UCMNpBUxKeQYdwXs
         /5aoktT/xPjw1upWPVCLbyyt68MxAdwGjiAk9ItH2r8jjXzdXYtsc8BZZX47nZ/9hvzv
         RcSpqZYU2Gqr6LG54jNjknsqFJtTa/FXkX4wa42DBg+atHQ8+GoYSy4sbQ5+LWN+C41U
         HyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772456545; x=1773061345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/FjIYbH8rLK7M1wySsOhpB5kk1nqA9iYm40NdHpoF0=;
        b=IpqKD/AejEabZhRZqDc/Bd96YLi6PdhHlgyfbjgfE2WkImki3KW6ULRHcBTP59eIa3
         hyPHoZpENy6JGoYoiAkuefWh9Rd2E9TBm25tQQ5N9REo2usyy9HHAJml0+PBiebUWQnP
         Pmxoil9hKLX08IScIZQEOIQ13tlE1vIy9GC6/qtDZNg37zVs54ayXFoihzYXJ6EU0sNJ
         JH7zmmUiDpSHCaw4idH/A9zSIJEYFnmTfcaqL9e864+gPnQp3A5Ah3IUuTv4VslBkdR7
         TQyHjJjw6+X04dNDRy/VhufGgJCJNlUNoAp0sc1uzTVJRd3kwAZIkavw58qqpezy58aJ
         oaNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVFf0cqOAcSplZ3yzjS6JySU9VHskU5u9uicgtagfe6uVo6aUSoWAnjsJ3NXL91RCn/ZEWfMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT3IOK4K/lro7FJwUwd3n394wDi9ML+JHs1wNPAj40oW13ZMRp
	asl1TCsMJU3bp0vlj35uOoemQ9B3dIcdAJ4GZm/nigS3rxyk2nCHAkWvCUUEsoEFaaYf6U7YnRD
	pRquiC60=
X-Gm-Gg: ATEYQzx+VVhgo1YW834VxE5re83guDXVWmWprPjWmiP827oP8/jTYW1UOwK1ZH4UEUY
	f4Y2eDJFNl3ZxDBk6z2YELu0gd0l9VBeScwYXKGXgFrVono72vONrgoTragP0eK9D6P9Fi1XvzT
	M5c926xHWKzDunx1rCygkkLztKqKOsptQw/qh6Bt0Fx30m6DqCX7tYkxf3unIbshbNyo3tUWVzs
	LSxNOYx48KmvHt8opuPgUXRF/ylAkM2lrIqZMfqUrQG8U2fSy6IUSHd8BQo7rg/Q5bSaCOmH5HY
	TtJPCa44Ic8SyUPAgBDMfpDPY+/0hcdSs2i3Jn7l4ZGxHLPgJBluDxjygviSS55y64My5zb5eSB
	lgx3MPmTl1vRGrzn9vgmslISo9/GS141qkRIwcklg8lRjIxZupSMdSU3LyCgIihKDS//xsIIOEz
	909faatvgjLqcxJClhrX4KOgaYDvhCitHAvmtNqXuQUQEoSfHIDBIwcSHHqg==
X-Received: by 2002:a05:600c:3542:b0:480:1e8f:d15f with SMTP id 5b1f17b1804b1-483c9bc5596mr224330125e9.2.1772456544273;
        Mon, 02 Mar 2026 05:02:24 -0800 (PST)
Received: from localhost (176.111.181.188.kyiv.nat.volia.net. [176.111.181.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b7713csm262504675e9.11.2026.03.02.05.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:02:23 -0800 (PST)
Date: Mon, 2 Mar 2026 15:02:22 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>, shuah@kernel.org
Subject: Re: [PATCH net-next v3 13/14] net: bridge: mcast: use combined
 active state in fast/data path
Message-ID: <aaWKXh24aEudngaV@penguin>
References: <20260302054008.21638-1-linus.luessing@c0d3.blue>
 <20260302054008.21638-14-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302054008.21638-14-linus.luessing@c0d3.blue>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262645-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:dkim,c0d3.blue:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 902DA1D96C7
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:40:07AM +0100, Linus Lüssing wrote:
> As the multicast active state variable is now always up to date and
> functionally equivalent to our manual, extensive checks in fast path
> we can just use this state variable in fast path, too. This allows to
> save some CPU cycles for every multicast packet in the fast/data path.
> 
> Next to using brmctx->ip4_active / brmctx->ip6_active in fast path this
> mostly just moves some code around to not expose it via br_private.h
> anymore. While at it now also passing the ethernet protocol number
> directly, instead of a pointer into the ethernet header.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_device.c    |  3 ++-
>  net/bridge/br_input.c     |  3 ++-
>  net/bridge/br_multicast.c | 41 ++++++++++++++++++++++++++++++++++-----
>  net/bridge/br_private.h   | 38 ++++++++----------------------------
>  4 files changed, 48 insertions(+), 37 deletions(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index ee01122f466f..1ac363826b4c 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -102,7 +102,8 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
>  		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
> -		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst))
> +		    br_multicast_snooping_active(brmctx, eth_hdr(skb)->h_proto,
> +						 mdst))
>  			br_multicast_flood(mdst, skb, brmctx, false, true);
>  		else
>  			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 1405f1061a54..e79963e3d05f 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -187,7 +187,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  	case BR_PKT_MULTICAST:
>  		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
>  		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
> -		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
> +		    br_multicast_snooping_active(brmctx, eth_hdr(skb)->h_proto,
> +						 mdst)) {
>  			if ((mdst && mdst->host_joined) ||
>  			    br_multicast_is_router(brmctx, skb) ||
>  			    br->dev->flags & IFF_ALLMULTI) {
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 715a0e0aa5ad..4a1005bb68f1 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1067,6 +1067,26 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
>  	return skb;
>  }
>  
> +static bool
> +__br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> +			      struct bridge_mcast_other_query *querier,
> +			      bool is_ipv6)
> +{
> +	bool own_querier_enabled;
> +
> +	if (brmctx->multicast_querier) {
> +		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
> +			own_querier_enabled = false;
> +		else
> +			own_querier_enabled = true;
> +	} else {
> +		own_querier_enabled = false;
> +	}
> +
> +	return !timer_pending(&querier->delay_timer) &&
> +	       (own_querier_enabled || timer_pending(&querier->timer));
> +}
> +
>  static bool br_ip4_multicast_querier_exists(struct net_bridge_mcast *brmctx)
>  {
>  	return __br_multicast_querier_exists(brmctx, &brmctx->ip4_other_query, false);
> @@ -1079,6 +1099,21 @@ static bool br_ip6_multicast_querier_exists(struct net_bridge_mcast *brmctx)
>  }
>  #endif
>  
> +static bool
> +br_multicast_querier_exists(struct net_bridge_mcast *brmctx, u16 proto)
> +{
> +	switch (proto) {
> +	case ETH_P_IP:
> +		return br_ip4_multicast_querier_exists(brmctx);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case ETH_P_IPV6:
> +		return br_ip6_multicast_querier_exists(brmctx);
> +#endif
> +	default:
> +		return false;
> +	}
> +}
> +
>  static void br_ip4_multicast_update_active(struct net_bridge_mcast *brmctx,
>  					   bool force_inactive)
>  {
> @@ -5132,7 +5167,6 @@ bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto)
>  {
>  	struct net_bridge *br;
>  	struct net_bridge_port *port;
> -	struct ethhdr eth;
>  	bool ret = false;
>  
>  	rcu_read_lock();
> @@ -5145,10 +5179,7 @@ bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto)
>  
>  	br = port->br;
>  
> -	memset(&eth, 0, sizeof(eth));
> -	eth.h_proto = htons(proto);
> -
> -	ret = br_multicast_querier_exists(&br->multicast_ctx, &eth, NULL);
> +	ret = br_multicast_querier_exists(&br->multicast_ctx, proto);
>  
>  unlock:
>  	rcu_read_unlock();
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 8150ecc2c919..75684f8079f2 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1159,37 +1159,15 @@ br_multicast_is_router(struct net_bridge_mcast *brmctx, struct sk_buff *skb)
>  }
>  
>  static inline bool
> -__br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> -			      struct bridge_mcast_other_query *querier,
> -			      const bool is_ipv6)
> +br_multicast_snooping_active(struct net_bridge_mcast *brmctx, __be16 eth_proto,

const brmctx

> +			     const struct net_bridge_mdb_entry *mdb)
>  {
> -	bool own_querier_enabled;
> -
> -	if (brmctx->multicast_querier) {
> -		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
> -			own_querier_enabled = false;
> -		else
> -			own_querier_enabled = true;
> -	} else {
> -		own_querier_enabled = false;
> -	}
> -
> -	return !timer_pending(&querier->delay_timer) &&
> -	       (own_querier_enabled || timer_pending(&querier->timer));
> -}
> -
> -static inline bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> -					       struct ethhdr *eth,
> -					       const struct net_bridge_mdb_entry *mdb)
> -{
> -	switch (eth->h_proto) {
> +	switch (eth_proto) {
>  	case (htons(ETH_P_IP)):

since you're changing it, could you please remove the extra ()?
they're unnecessary and don't help readability

> -		return __br_multicast_querier_exists(brmctx,
> -			&brmctx->ip4_other_query, false);
> +		return READ_ONCE(brmctx->ip4_active);
>  #if IS_ENABLED(CONFIG_IPV6)
>  	case (htons(ETH_P_IPV6)):
> -		return __br_multicast_querier_exists(brmctx,
> -			&brmctx->ip6_other_query, true);
> +		return READ_ONCE(brmctx->ip6_active);
>  #endif
>  	default:
>  		return !!mdb && br_group_is_l2(&mdb->addr);
> @@ -1448,9 +1426,9 @@ static inline bool br_multicast_is_router(struct net_bridge_mcast *brmctx,
>  	return false;
>  }
>  
> -static inline bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> -					       struct ethhdr *eth,
> -					       const struct net_bridge_mdb_entry *mdb)
> +static inline bool
> +br_multicast_snooping_active(struct net_bridge_mcast *brmctx, __be16 eth_proto,
> +			     const struct net_bridge_mdb_entry *mdb)
>  {
>  	return false;
>  }
> -- 
> 2.51.0
> 

