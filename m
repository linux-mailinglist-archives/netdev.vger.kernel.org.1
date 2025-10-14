Return-Path: <netdev+bounces-229272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5ECBD9EC1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D48188D49C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E7931578F;
	Tue, 14 Oct 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg61uCGC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0F30C355;
	Tue, 14 Oct 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451115; cv=none; b=h4xIQJ1x4n/FwMQPi1wtjF5/EIU6HIi56KvnMQp+TKPB74LRXKEVVcYlBbfkhx/mlK8x2kAxQkkPLOSoAp1dkrxkskXxvSc0Y4NJx220cdxrIH7aHksCk5BPxbJ+Sxs3pfiZ/V/l8o+So0O30BgFe+Sq0l+eKPO3QeVFR8KkHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451115; c=relaxed/simple;
	bh=/gBS9Ec+weRR1GIYiklQkgoYwSB1yN3/uPyeEbdUeek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idu7tzbWROlA1YlVbrOHYHgpg8BY1pOQ2BISvHUCsqxtHD/XxAMFnJIMALeRtJWQpP8aMkkM1JcAO/UaOzyC0dfMxcm5gmENuLQRkt59G1WbOZDP9lUv7N6+Zqyww5roLCge0Fhr6vnxE2+D95PByOT74lCaMXWURSrtrSHAniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg61uCGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22462C113D0;
	Tue, 14 Oct 2025 14:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760451115;
	bh=/gBS9Ec+weRR1GIYiklQkgoYwSB1yN3/uPyeEbdUeek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qg61uCGCf6ldIV3YwehuWNNA6wH3MGlEiL9bwCQ/jQD4EcXejnPfTRzrnqADnbbOc
	 95IfQ5SmtxT9NbRoR7VM1DUW5NJLakPPxbPd4oJ6wdjf6rYt85xq5knE4ZCZTKYbWg
	 scRapye1FpFUaQ9Wv/kx8l/0gQNsVw284x8SHTPE+YrxP4L0DVFldmHk75zv5GDbpQ
	 LXervE0DtpTr0unmC4qi35kGZ4osel/27/5CsOWn07z0Gj9U4o9B00+FxmHisSTQ2A
	 d/kwR/meL1s448+1vZ+Sz/j/Cp99hEeUlGacNx2bppMVXqHTRQtoYSTBI91WstyHY8
	 l+mA+i2Yi8l4g==
Date: Tue, 14 Oct 2025 15:11:51 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	usamaarif642@gmail.com, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH net v2] netpoll: Fix deadlock in memory allocation under
 spinlock
Message-ID: <aO5aJ9dN5xIIdmNE@horms.kernel.org>
References: <20251014-fix_netpoll_aa-v2-1-dafa6a378649@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-fix_netpoll_aa-v2-1-dafa6a378649@debian.org>

On Tue, Oct 14, 2025 at 03:10:51AM -0700, Breno Leitao wrote:
> Fix a AA deadlock in refill_skbs() where memory allocation while holding
> skb_pool->lock can trigger a recursive lock acquisition attempt.
> 
> The deadlock scenario occurs when the system is under severe memory
> pressure:
> 
> 1. refill_skbs() acquires skb_pool->lock (spinlock)
> 2. alloc_skb() is called while holding the lock
> 3. Memory allocator fails and calls slab_out_of_memory()
> 4. This triggers printk() for the OOM warning
> 5. The console output path calls netpoll_send_udp()
> 6. netpoll_send_udp() attempts to acquire the same skb_pool->lock
> 7. Deadlock: the lock is already held by the same CPU
> 
> Call stack:
>   refill_skbs()
>     spin_lock_irqsave(&skb_pool->lock)    <- lock acquired
>     __alloc_skb()
>       kmem_cache_alloc_node_noprof()
>         slab_out_of_memory()
>           printk()
>             console_flush_all()
>               netpoll_send_udp()
>                 skb_dequeue()
>                   spin_lock_irqsave(&skb_pool->lock)     <- deadlock attempt
> 
> This bug was exposed by commit 248f6571fd4c51 ("netpoll: Optimize skb
> refilling on critical path") which removed refill_skbs() from the
> critical path (where nested printk was being deferred), letting nested
> printk being calld form inside refill_skbs()
> 
> Refactor refill_skbs() to never allocate memory while holding
> the spinlock.
> 
> Another possible solution to fix this problem is protecting the
> refill_skbs() from nested printks, basically calling
> printk_deferred_{enter,exit}() in refill_skbs(), then, any nested
> pr_warn() would be deferred.
> 
> I prefer tthis approach, given I _think_ it might be a good idea to move
> the alloc_skb() from GFP_ATOMIC to GFP_KERNEL in the future, so, having
> the alloc_skb() outside of the lock will be necessary step.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 248f6571fd4c51 ("netpoll: Optimize skb refilling on critical path")
> ---
> Changes in v2:
> - Added a return after the successful path (Rik van Riel)
> - Changed the Fixes tag to point to the commit that exposed the problem.
> - Link to v1: https://lore.kernel.org/r/20251013-fix_netpoll_aa-v1-1-94a1091f92f0@debian.org
> ---
>  net/core/netpoll.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 60a05d3b7c249..c19dada9283ce 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -232,14 +232,28 @@ static void refill_skbs(struct netpoll *np)
>  
>  	skb_pool = &np->skb_pool;
>  
> -	spin_lock_irqsave(&skb_pool->lock, flags);
> -	while (skb_pool->qlen < MAX_SKBS) {
> +	while (1) {
> +		spin_lock_irqsave(&skb_pool->lock, flags);
> +		if (skb_pool->qlen >= MAX_SKBS)
> +			goto unlock;
> +		spin_unlock_irqrestore(&skb_pool->lock, flags);
> +
>  		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
>  		if (!skb)
> -			break;
> +			return;
>  
> +		spin_lock_irqsave(&skb_pool->lock, flags);
> +		if (skb_pool->qlen >= MAX_SKBS)
> +			/* Discard if len got increased (TOCTOU) */
> +			goto discard;
>  		__skb_queue_tail(skb_pool, skb);
> +		spin_unlock_irqrestore(&skb_pool->lock, flags);
>  	}
> +
> +	return;

Maybe it is worth leaving alone for clarity.
And certainly it does no harm.
But the line above is never reached.

Flagged by Smatch.

> +discard:
> +	dev_kfree_skb_any(skb);
> +unlock:
>  	spin_unlock_irqrestore(&skb_pool->lock, flags);
>  }
>  
> 
> ---
> base-commit: c5705a2a4aa35350e504b72a94b5c71c3754833c
> change-id: 20251013-fix_netpoll_aa-c991ac5f2138
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

