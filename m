Return-Path: <netdev+bounces-172581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D80D4A5570B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04947169EC9
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53622144BC;
	Thu,  6 Mar 2025 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMa/IQUy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACDF148314
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290373; cv=none; b=G3lhmkc5LqVTY0+8Tk4bllpeRqKazcMoxD6ArIF3kTIvKw0Q5M7nXJXFrlgLK33IQEswuwe2nRBdASCUO9NT2/XhJj4KLpFzuBieRpdlL7QgXETKuBqg/hxCrGN/vwqTyNYhJMV8h6iz7NJWggucAM3/kg4YxbD9Oy5y2A9h1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290373; c=relaxed/simple;
	bh=B5oYCUDiXJRPSIxTuF8KFgEim0tvNpsmW4IVlBPg3uw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DJDCkRzuFwv+4ndT0w1QDDM2amf997atg+V4j1H8pfBYXVY3W8/h44QjbthVC3YOD+nrGRJphLYow6OVtNdi/8kNRs75s988WDGg+D+t6lxMC5w+Wgycjp3y0jozxBwhB/zlohR7papmjOi+/CXiJoMoLoB0NComC7Bcx3ELgPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMa/IQUy; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7be49f6b331so109328785a.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 11:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741290371; x=1741895171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxGYGRYSDNdStuSmdSlabpFgOvSQPsIL63FXXfxwn0Y=;
        b=JMa/IQUy/a/1Q2bZeVrU5FozTxQeMa9ff6PcWvuaqI32JBuFytgCztNbwAQbC5K0vr
         vhPy6zdug9BgKvv7zR6uuUx5Kcpim5yfarsLLU/1Z2Xnt/H+FmCrOZlLEbllKZ5IgH/0
         dVmOVmqgNU9m0qIGGyuCXdAWWQGQwsv3RWcSpkBMBj4YMWWhZ+KB44OwbKM8WTKHMjKP
         IKu9B9Da6WoysDaJtsvPxfnwehiV9XHhDpx7XZJesdLwi9+7TGKKQkDekeUJ/1Ul+j6R
         31WOXPWPtCTA1Tw7nJu0hmE+IAEbm4rnBxn+hPDHOaOtCxBiOsnXgGfkTjOBBrwZ7oR6
         5fEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290371; x=1741895171;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QxGYGRYSDNdStuSmdSlabpFgOvSQPsIL63FXXfxwn0Y=;
        b=KeTj4IfrnrREz2V+e/yR2uBdjvImlAkUj2yi10Ru3BJuZkfsYX7xOI9nH7NcV3ypOP
         aONgXtUn9vWRgHkpB7yTFOggYH++qq7+cR8aynfzPbxQM0Vgwk3/qVStQ7PeVVxC0CCJ
         1TlwN4L6ZmEv6l2/XMaAmQNH2gTECfPryA9WnqYNz+92F5AoPgZ3oJ16uy7eOrPcVeDI
         Smgm7drSPG7+8jTOUAGz34eF5qrFnvMfY5MHpchLNnlubZxK7RoJclyQ6fAgXigOo+B1
         gqZcJzdo4SB+pn4AfP4KkTFmNmFC0wcQNzLnfVmgyg5rEZqnQI/F/RQTb3EA7YkA3mUM
         EZCw==
X-Forwarded-Encrypted: i=1; AJvYcCUBKW6g73QVb9sz2QMuTgjrJxemt1052ukWU4uwMH88d195ixqjRumGIRaIkFvg3VYCwNXI2Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHBQiPLN8yjBtFvfwcIPCKVnKaOpxzM5qs3F6KQEkPh1hthc5X
	IT5x+qgA8FYzDvbiyA0gc1V/UpgnuOpXH0+7X6VlqkT4KmP1qbiK
X-Gm-Gg: ASbGncsO9Md8yhhsXtLH1w+ksi1iKrT6Xw2+Ld7X2Pqy6vJvEzBx8+xCpgVys7WZ1xv
	+1lIzOK0BQogwQTjNTJ3zqazihbQVmBchj0ZTUS3Jo+bsBSOp9xWS4ehmZWMPMMo77/ll5qLZlb
	620gjLwRovcG75ytA5J/qnpXNsICYhj4fsSmm0uhjRj6eJE//O++Kx2wFXq7Ol1rNkaUYl7bvGJ
	lFfcUvZQP/g+jSBk0znwhkhd3q8qn1hjakOHePtHObggxRou/x/52NcNTCXKsKA1JFqBj5ormCq
	FclSxKPHnV8vLkks9PIm1VC7rgoyCivGdX2OfKO3DMJ43U2U/qgbgZWinPfsr+vBqSs7YYcRz7w
	hoCXdZcbbMWCmhBjk6M823w==
X-Google-Smtp-Source: AGHT+IFqwQs7wC4SLJzojIVKW3j84xSAVeMVRBb4OMV+8pMl2d+QJ2rryBRUBYxxeuYD24K7Jd5ZOg==
X-Received: by 2002:a05:620a:4394:b0:7c0:b1aa:ba49 with SMTP id af79cd13be357-7c4e6112106mr78762785a.30.1741290370986;
        Thu, 06 Mar 2025 11:46:10 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e7c0a266sm105608185a.30.2025.03.06.11.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:46:10 -0800 (PST)
Date: Thu, 06 Mar 2025 14:46:09 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <67c9fb8199ef0_15800294cc@willemb.c.googlers.com.notmuch>
In-Reply-To: <ef5aa34bd772ec9b6759cf0fde2d2854b3e98913.1741275846.git.pabeni@redhat.com>
References: <cover.1741275846.git.pabeni@redhat.com>
 <ef5aa34bd772ec9b6759cf0fde2d2854b3e98913.1741275846.git.pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] udp_tunnel: create a fast-path GRO lookup.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> Most UDP tunnels bind a socket to a local port, with ANY address, no
> peer and no interface index specified.
> Additionally it's quite common to have a single tunnel device per
> namespace.
> 
> Track in each namespace the UDP tunnel socket respecting the above.
> When only a single one is present, store a reference in the netns.
> 
> When such reference is not NULL, UDP tunnel GRO lookup just need to
> match the incoming packet destination port vs the socket local port.
> 
> The tunnel socket never set the reuse[port] flag[s], when bound to no
> address and interface, no other socket can exist in the same netns
> matching the specified local port.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index c1a85b300ee87..ac6dd2703190e 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -12,6 +12,38 @@
>  #include <net/udp.h>
>  #include <net/protocol.h>
>  #include <net/inet_common.h>
> +#include <net/udp_tunnel.h>
> +
> +#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
> +static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
> +
> +void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
> +{
> +	bool is_ipv6 = sk->sk_family == AF_INET6;
> +	struct udp_sock *tup, *up = udp_sk(sk);
> +	struct udp_tunnel_gro *udp_tunnel_gro;
> +
> +	spin_lock(&udp_tunnel_gro_lock);
> +	udp_tunnel_gro = &net->ipv4.udp_tunnel_gro[is_ipv6];

It's a bit odd to have an ipv6 member in netns.ipv4. Does it
significantly simplify the code vs a separate entry in netns.ipv6?


> +	if (add)
> +		hlist_add_head(&up->tunnel_list, &udp_tunnel_gro->list);
> +	else
> +		hlist_del_init(&up->tunnel_list);
> +
> +	if (udp_tunnel_gro->list.first &&
> +	    !udp_tunnel_gro->list.first->next) {
> +		tup = hlist_entry(udp_tunnel_gro->list.first, struct udp_sock,
> +				  tunnel_list);
> +
> +		rcu_assign_pointer(udp_tunnel_gro->sk, (struct sock *)tup);
> +	} else {
> +		rcu_assign_pointer(udp_tunnel_gro->sk, NULL);
> +	}
> +
> +	spin_unlock(&udp_tunnel_gro_lock);
> +}
> +EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_lookup);
> +#endif
>  
>  static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
>  	netdev_features_t features,
> @@ -631,8 +663,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
>  {
>  	const struct iphdr *iph = skb_gro_network_header(skb);
>  	struct net *net = dev_net_rcu(skb->dev);
> +	struct sock *sk;
>  	int iif, sdif;
>  
> +	sk = udp_tunnel_sk(net, false);
> +	if (sk && dport == htons(sk->sk_num))
> +		return sk;
> +

This improves tunnel performance at a slight cost to everything else,
by having the tunnel check before the normal socket path.

Does a 5% best case gain warrant that? Not snark, I don't have a
good answer.

>  	inet_get_iif_sdif(skb, &iif, &sdif);
>  
>  	return __udp4_lib_lookup(net, iph->saddr, sport,

