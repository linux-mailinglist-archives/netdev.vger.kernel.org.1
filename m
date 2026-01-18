Return-Path: <netdev+bounces-250762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CBCD391E9
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 361643026B37
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152DF19AD8B;
	Sun, 18 Jan 2026 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGT5POSI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52751917ED
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696574; cv=none; b=c5UKlMo9QXfKvKusVJQRKMhcJ6MGoxFT+hIGyQlkbNy+L43TtDMkAAlvnSYz/0lkolybJaFTTtoPWbZ3EvFBzmOYmQiMPQfgo7AjpqEXlGx7TRR58U3NpsvnhgNjPi8EBmo62NL/q1phse3QuecIBuVW3/mp/ZrGQR3HFgvbPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696574; c=relaxed/simple;
	bh=F+Itz4lrKH+aQKpviG49zXNwDd1xTp3BYP8gwZ+wdF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpM+4Sp90TjXcIUWni/Ao6SGWu0HRmC5rHSHrp4yXez4wbP8e5EMXfxjQSylw0qTEWKXzDffioAklgyGpKXCFwnOG+HsUkgIMRgXMZJ2gwE99BMVCKM6joSx6L1v3zZXjRRZxkyhra0KGCBhZuTwNKaw6UuDqBZrAz6hfX4Ekvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGT5POSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D12AC4CEF7;
	Sun, 18 Jan 2026 00:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768696574;
	bh=F+Itz4lrKH+aQKpviG49zXNwDd1xTp3BYP8gwZ+wdF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rGT5POSI87rOJVEIzk2fcV7RwhTcm347Cf1vtt8Gb2klbDQLRe9NqNqBGOB03o2LT
	 nCLywnAsruw16ihX0kPi2TX/GkXEjveCc5fPOLAO6n9OKpABqYEub9rJSg0KLuzmXX
	 BHWnMNQH7Y5/T9qEyVwLt3/uBjjuNWXeO6+WxEVp8k1vG13N3Lo2t1oLPrPZdBefcd
	 byCOI3rUZlDvsC3TRcRRMO6ieYHgFc2qSiBogDQZvpJTmwKAi0/W6CWwvu3APli6gM
	 rbICLmtO3CZNlcHsU1B4CoCmUkoxUtEfGRvTFMit2tbdXn3z8ZisugxwZFv44v2qVw
	 GMyFqPZhA/eiQ==
From: Jakub Kicinski <kuba@kernel.org>
To: mmietus97@yahoo.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	sd@queasysnail.net,
	Jason@zx2c4.com
Subject: Re: [net-next,v5,10/11] net: sit: convert ipip6_tunnel_xmit to use a noref dst
Date: Sat, 17 Jan 2026 16:36:13 -0800
Message-ID: <20260118003613.1042452-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113163614.6212-2-mmietus97@yahoo.com>
References: <20260113163614.6212-2-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
    net: sit: convert ipip6_tunnel_xmit to use a noref dst

This patch converts ipip6_tunnel_xmit to use dst_cache_get_ip4_rcu() and
dst_cache_steal_ip4() to avoid redundant refcount increments when using
the dst cache.

> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index a0d699082747..e9183e502242 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -933,14 +933,14 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
>  			   IPPROTO_IPV6, 0, dst, tiph->saddr, 0, 0,
>  			   sock_net_uid(tunnel->net, NULL));
>
> -	rt = dst_cache_get_ip4(&tunnel->dst_cache, &fl4.saddr);
> +	rt = dst_cache_get_ip4_rcu(&tunnel->dst_cache, &fl4.saddr);
>  	if (!rt) {
>  		rt = ip_route_output_flow(tunnel->net, &fl4, NULL);
>  		if (IS_ERR(rt)) {
>  			DEV_STATS_INC(dev, tx_carrier_errors);
>  			goto tx_error_icmp;
>  		}
> -		dst_cache_set_ip4(&tunnel->dst_cache, &rt->dst, fl4.saddr);
> +		dst_cache_steal_ip4(&tunnel->dst_cache, &rt->dst, fl4.saddr);
>  	}
>
>  	if (rt->rt_type != RTN_UNICAST && rt->rt_type != RTN_LOCAL) {
>  		ip_rt_put(rt);
>  		DEV_STATS_INC(dev, tx_carrier_errors);
>  		goto tx_error_icmp;
>  	}

When rt is obtained from dst_cache_get_ip4_rcu() (cache hit path), no
reference is taken on the dst. However, the ip_rt_put(rt) call here was
not removed. If the cache returns a valid rt but the rt_type check fails,
this will call dst_release() on a dst we do not own a reference to.

Could this cause a refcount underflow? The correct pattern (as seen in
ip_tunnel_xmit()) uses a noref boolean to track whether we own a reference,
and only calls ip_rt_put() when !noref.

[ ... ]

