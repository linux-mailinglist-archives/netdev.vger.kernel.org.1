Return-Path: <netdev+bounces-230061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 055E5BE373D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A573F4F2381
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF8331D732;
	Thu, 16 Oct 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXLfHvP3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20712E7160;
	Thu, 16 Oct 2025 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618461; cv=none; b=OD3cFtvYyYeyMVo4DORFNeW6MstLQ9TD/t80DxNTyueruBglyGmUBlgkfoj/u6u2yGDnSXlsshZX63jA2EVm1CVEvSp8mjpAqFw22vbOcJmdS8A5o1R55DBrxDEm0iTyb/mC9Ivpv5atxACdafUNeUAAHk0gdB+RGrJmC8fFjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618461; c=relaxed/simple;
	bh=AAgRO/7qY39JW32gJVblEC/MfMeqdOQxBMrwj+I2tIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpNOvPwV7ypipGyDJwreCdOSQxAiGHzoCno8FQsrLjIkRYzJYTyU5UXaNTlkPXOpjp+xO7xWH9SKRVHdpmTxrl3DKlxb1hfmNjXAWqBhmmVkKFh16JLsoquhdcfbWg5RIEXqB0lV4Nv0145+qNHpEnBG1R3x1wE2VDrGMWg5Tuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXLfHvP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918BFC4CEF1;
	Thu, 16 Oct 2025 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760618460;
	bh=AAgRO/7qY39JW32gJVblEC/MfMeqdOQxBMrwj+I2tIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXLfHvP3Bpe80YvoAjzYze5ZIBQVitMRwtdoFYa98bXzYV767GdrJH8ukRWDT285J
	 LDe3mqXYqhobZKD1vhzk4W2JSsOn/Mw0GPparTs6vFN5BZ6YYqYUCB3nZ9N7wCCaQb
	 UMhmZo2qw+HV1LbGIQq8JoDs8IU27UGN3lIzhxxy3bSpBbrMRCp6roEPOgbtWTYgcU
	 mn7an0UN+rzxI9IDv9HQwFbK5ndFC+DU7FMpWjmLstbXDLxa4+OTKVpTWWg5hdZUQl
	 +tlYggrllMx5wj/ebagnmkrVcMY1foaPi3EYLuyivXk0kSCYa/ZUGjA3S4nQjySg8y
	 i+xiwb9t5kEQw==
Date: Thu, 16 Oct 2025 13:40:56 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net v3] netpoll: Fix deadlock in memory allocation under
 spinlock
Message-ID: <aPDn2OIpD31U-TEU@horms.kernel.org>
References: <20251014-fix_netpoll_aa-v3-1-bff72762294e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-fix_netpoll_aa-v3-1-bff72762294e@debian.org>

On Tue, Oct 14, 2025 at 09:37:50AM -0700, Breno Leitao wrote:
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
> Changes in v3:
> - Removed the "return" before the exit labels. (Simon)
> - Link to v2: https://lore.kernel.org/r/20251014-fix_netpoll_aa-v2-1-dafa6a378649@debian.org
> 
> Changes in v2:
> - Added a return after the successful path (Rik van Riel)
> - Changed the Fixes tag to point to the commit that exposed the problem.
> - Link to v1: https://lore.kernel.org/r/20251013-fix_netpoll_aa-v1-1-94a1091f92f0@debian.org

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


