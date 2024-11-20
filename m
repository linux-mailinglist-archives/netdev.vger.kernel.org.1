Return-Path: <netdev+bounces-146438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408719D3686
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1EE1B21EE9
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E74A193402;
	Wed, 20 Nov 2024 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SX6OTBOU"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E2E149C42;
	Wed, 20 Nov 2024 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093950; cv=none; b=gHkbsk9NCMeZ1KKcQ80/NRupjJUSpGC6QaDLImk5VtmHBeARUoT4xjMOwO5iVthqh7x8zjxA8X97wSFhcc6JEZRja/h+BNPNAaKB0+zxAV2HL6C6Y/PCUR/QvVxeeKMyIE+cnAnnues5rzAiXR9DQVqEP6jLL8V9l1+qv+dFOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093950; c=relaxed/simple;
	bh=+h6qn39iKYBYkjnAfwM2WCW/3rG7h0rqZ0p706MqXQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm1ytdShERBFcrRONzxE7HrbMLF6BXN+uwym7nj9fvNUUCoB5HCGNuTqK0uN/wYCAD5QY6+XoBX/f9Oz84khwqDKM6+DC1a2TSA7gNEPnce6gf4v6pypWnfzj0hpHXTz773ym+vMl6cFQIvDy1bZ9mYAHIPB+3pbf36AXCN4fVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SX6OTBOU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wk2X3+PQpTfNDXktHKx5N1reY89npk+liD3n+j6xvIo=; b=SX6OTBOUcOh239e6zpRF5e6Hjm
	aaczC8p43ZAau+BKYgPoqAbCP9M5KkaIAj+d6y/X1UKWi4VYa+a1sczzexsjpluoqdbeEx1UteHqZ
	cJi5wTJExX6f3YSWkdJVE8MzwNXOH1kerEpzyhMvN1aCWYHLt6SlFNSY5k65FnfakSBiP8nV46rfo
	1iuXpxL+K2dAoLL4R/W8+sGyL1RxaIZty9JUI0I5CyPHB96tTJjhT0RHK0egn83d7WgRabpZTntnP
	tWvxSadGig7B4I34GoLq1EGGmupmazf6Nvko+pS2UyN9k7NiBF+SKXO+GjXObiJfxVXd0o/lDIbun
	iOofmCpw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDgkx-00000000SXp-3ptr;
	Wed, 20 Nov 2024 09:12:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8CA523006AB; Wed, 20 Nov 2024 10:12:15 +0100 (CET)
Date: Wed, 20 Nov 2024 10:12:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ran Xiaokai <ranxiaokai627@163.com>
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org, mingo@redhat.com,
	pshelar@ovn.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn, linux-perf-users@vger.kernel.org,
	netdev@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH 2/4] perf/core: convert call_rcu(free_ctx) to kfree_rcu()
Message-ID: <20241120091215.GK39245@noisy.programming.kicks-ass.net>
References: <20241120064716.3361211-1-ranxiaokai627@163.com>
 <20241120064716.3361211-3-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120064716.3361211-3-ranxiaokai627@163.com>

On Wed, Nov 20, 2024 at 06:47:14AM +0000, Ran Xiaokai wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> The rcu callback free_ctx() simply calls kfree().
> It's better to directly call kfree_rcu().

Why is it better? 

> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  kernel/events/core.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 065f9188b44a..7f4cc9c41bbe 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1210,14 +1210,6 @@ static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
>  		kmem_cache_free(pmu->task_ctx_cache, task_ctx_data);
>  }
>  
> -static void free_ctx(struct rcu_head *head)
> -{
> -	struct perf_event_context *ctx;
> -
> -	ctx = container_of(head, struct perf_event_context, rcu_head);
> -	kfree(ctx);
> -}
> -
>  static void put_ctx(struct perf_event_context *ctx)
>  {
>  	if (refcount_dec_and_test(&ctx->refcount)) {
> @@ -1225,7 +1217,7 @@ static void put_ctx(struct perf_event_context *ctx)
>  			put_ctx(ctx->parent_ctx);
>  		if (ctx->task && ctx->task != TASK_TOMBSTONE)
>  			put_task_struct(ctx->task);
> -		call_rcu(&ctx->rcu_head, free_ctx);
> +		kfree_rcu(ctx, rcu_head);
>  	}
>  }
>  
> -- 
> 2.17.1
> 
> 

