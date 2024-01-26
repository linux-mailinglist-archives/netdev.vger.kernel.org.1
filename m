Return-Path: <netdev+bounces-66079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C3483D28B
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 03:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA371F25CCE
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 02:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B90079D9;
	Fri, 26 Jan 2024 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg4lLBkc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD0A936
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 02:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235994; cv=none; b=DJGxS2OgR03z1BFeG3KyDEe287l5Yd/OnDPb//dRst+xggmNFw/d8pSAa53006tor6+S+rmyYp8XtJq1HqTDaTtjxRZv7/gHbzllYRbtCKgUbYo2l7dx4jkZG56oZ3Ezmi1Sv0KRM2gsHEXcLJnhQYJTjNOC0Fij0+qbVeWRFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235994; c=relaxed/simple;
	bh=DDbiQPgPkoqqE0jTWMaUwc77p2Zvuzgw/HUYCXF2vWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEeDGB2T4bk2zdISFGWig4U3UnF7nBlooseDz1Tk1aBvEZp11oD6nXAg5EiZIoLBIPEzQCf2Sv+HPTNau7TRXA8cDsffGL0x+ItkvzhmwCcNwT0x5xbiY3oXCiOgOCB/kUw0u0F7pVRvaNpwrnudAuMcX3F2bieZZaF0WF+xfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg4lLBkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E74C433C7;
	Fri, 26 Jan 2024 02:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706235993;
	bh=DDbiQPgPkoqqE0jTWMaUwc77p2Zvuzgw/HUYCXF2vWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kg4lLBkcmiEvFqgRASDR7uYwbdpOw1GhPd3iWUb1up/Pe/YNbZuUh/eAIXO8BgXG/
	 o5C5W0c7hU5Wrh2SRoJnhJ0zmbjqp7bDvEEV+JOsaJr3t5DrQV6/8u6T7OeBOF0wID
	 35lkXTtB4nGtul1UL8e3OCoZb90FzNvTJ7MPh+cZy7Boc2n+ZRw4+G9BzjDwFLKCjM
	 5X5f5AaJ/Hj699cUdRd3rsyODL9yG3CqjAtqSK83YsFkrRSZ8Wn+tjRhPcQ29OjXcg
	 MVpR06OGlTgEQKtwBQnfiQT6upSM+mQaw2GiPCylH/s7x81OBMsLxvLwDxz/VdSbsp
	 YVI0r1S2jdiHA==
Date: Thu, 25 Jan 2024 18:26:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v6 2/4] netdevsim: forward skbs from one
 connected port to another
Message-ID: <20240125182632.47652d20@kernel.org>
In-Reply-To: <20240126012357.535494-3-dw@davidwei.uk>
References: <20240126012357.535494-1-dw@davidwei.uk>
	<20240126012357.535494-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 17:23:55 -0800 David Wei wrote:
>  	struct netdevsim *ns = netdev_priv(dev);
> +	struct netdevsim *peer_ns;
> +	unsigned int len = skb->len;
> +	int ret = NETDEV_TX_OK;

nit: order variables longest to shortest

>  	if (!nsim_ipsec_tx(ns, skb))
>  		goto out;
>  
> +	rcu_read_lock();
> +	peer_ns = rcu_dereference(ns->peer);
> +	if (!peer_ns)
> +		goto out_stats;
> +
> +	skb_tx_timestamp(skb);
> +	if (unlikely(dev_forward_skb(peer_ns->netdev, skb) == NET_RX_DROP))
> +		ret = NET_XMIT_DROP;
> +
> +out_stats:
> +	rcu_read_unlock();
>  	u64_stats_update_begin(&ns->syncp);
>  	ns->tx_packets++;
> -	ns->tx_bytes += skb->len;
> +	ns->tx_bytes += len;
> +	if (ret == NET_XMIT_DROP)
> +		ns->tx_dropped++;

drops should not be counted as Tx

>  	u64_stats_update_end(&ns->syncp);
> +	return ret;

