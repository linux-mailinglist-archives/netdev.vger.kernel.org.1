Return-Path: <netdev+bounces-72612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB8B858D16
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 04:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A37A1C20FAF
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 03:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF0D1BC2D;
	Sat, 17 Feb 2024 03:47:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E21947E
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708141622; cv=none; b=e3gvRZoz8eaPNT83D4HC/wN/Sljt+j8/81E94hrkkmNicjydqbUwTFWqwKY6g/WsRvIz8NlZNVbnHtB/wDEMZv0lXptDcBOVUvojl459zsUmPIKW+Zy/D+7MSVTk47VBj4CamUrY8CbobJ5HH++kqVwonaijDJklBKRX09I03X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708141622; c=relaxed/simple;
	bh=f2J33Ra6MZcOm5toscKELQvfNYqvLyIvbJ5/Yd7aM1s=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IHOxEajUNfAHKUHQ3HiiqeZxsPsKq8FTcOosC/TqcVVDnSnJrfuhmgtaHHuoHWpC8Pj/uHiOmwdJrQhK+dFbOpmwJ9k9FmIpv6sHLgF/4p3Y2zc9haMuvTUQzjcj7OqgiPD+qYNmkVYP7pQRkoCUXH5Vi0YVf151Za6SdskgXtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TcF3h3gpHz1FKdQ;
	Sat, 17 Feb 2024 11:42:08 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 98CEA1402CC;
	Sat, 17 Feb 2024 11:46:55 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 17 Feb
 2024 11:46:55 +0800
Subject: Re: [PATCH net-next] net: page_pool: fix recycle stats for system
 page_pool allocator
To: Lorenzo Bianconi <lorenzo@kernel.org>, <netdev@vger.kernel.org>
CC: <lorenzo.bianconi@redhat.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <hawk@kernel.org>,
	<ilias.apalodimas@linaro.org>, <toke@redhat.com>,
	<aleksander.lobakin@intel.com>
References: <87f572425e98faea3da45f76c3c68815c01a20ee.1708075412.git.lorenzo@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <2f315c01-37ba-77e2-1d0f-568f453b3166@huawei.com>
Date: Sat, 17 Feb 2024 11:46:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87f572425e98faea3da45f76c3c68815c01a20ee.1708075412.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/2/16 17:25, Lorenzo Bianconi wrote:
> Use global percpu page_pool_recycle_stats counter for system page_pool
> allocator instead of allocating a separate percpu variable for each
> (also percpu) page pool instance.

I may missed some obvious discussion in previous version due to spring
holiday.

> 
> Reviewed-by: Toke Hoiland-Jorgensen <toke@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/page_pool/types.h |  5 +++--
>  net/core/dev.c                |  1 +
>  net/core/page_pool.c          | 22 +++++++++++++++++-----
>  3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 3828396ae60c..2515cca6518b 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -18,8 +18,9 @@
>  					* Please note DMA-sync-for-CPU is still
>  					* device driver responsibility
>  					*/
> -#define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
> -				 PP_FLAG_DMA_SYNC_DEV)
> +#define PP_FLAG_SYSTEM_POOL	BIT(2) /* Global system page_pool */
> +#define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | \
> +				 PP_FLAG_SYSTEM_POOL)
>  
>  /*
>   * Fast allocation side cache array/stack
> diff --git a/net/core/dev.c b/net/core/dev.c
> index cc9c2eda65ac..c588808be77f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11738,6 +11738,7 @@ static int net_page_pool_create(int cpuid)
>  #if IS_ENABLED(CONFIG_PAGE_POOL)
>  	struct page_pool_params page_pool_params = {
>  		.pool_size = SYSTEM_PERCPU_PAGE_POOL_SIZE,
> +		.flags = PP_FLAG_SYSTEM_POOL,
>  		.nid = NUMA_NO_NODE,
>  	};
>  	struct page_pool *pp_ptr;
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 89c835fcf094..8f0c4e76181b 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -31,6 +31,8 @@
>  #define BIAS_MAX	(LONG_MAX >> 1)
>  
>  #ifdef CONFIG_PAGE_POOL_STATS
> +static DEFINE_PER_CPU(struct page_pool_recycle_stats, pp_system_recycle_stats);
> +
>  /* alloc_stat_inc is intended to be used in softirq context */
>  #define alloc_stat_inc(pool, __stat)	(pool->alloc_stats.__stat++)
>  /* recycle_stat_inc is safe to use when preemption is possible. */
> @@ -220,14 +222,23 @@ static int page_pool_init(struct page_pool *pool,
>  	pool->has_init_callback = !!pool->slow.init_callback;
>  
>  #ifdef CONFIG_PAGE_POOL_STATS
> -	pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
> -	if (!pool->recycle_stats)
> -		return -ENOMEM;
> +	if (!(pool->p.flags & PP_FLAG_SYSTEM_POOL)) {
> +		pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
> +		if (!pool->recycle_stats)
> +			return -ENOMEM;
> +	} else {
> +		/* For system page pool instance we use a singular stats object
> +		 * instead of allocating a separate percpu variable for each
> +		 * (also percpu) page pool instance.
> +		 */
> +		pool->recycle_stats = &pp_system_recycle_stats;

Do we need to return -EINVAL here if page_pool_init() is called with
pool->p.flags & PP_FLAG_SYSTEM_POOL being true and cpuid being a valid
cpu?
If yes, it seems we may be able to use the cpuid to decide if we need
to allocate a new pool->recycle_stats without adding a new flag.

If no, the API for page_pool_create_percpu() seems a litte weird as it
relies on the user calling it correctly.

Also, do we need to enforce that page_pool_create_percpu() is only called
once for the same cpu? if no, we may have two page_pool instance sharing
the same stats.

> +	}
>  #endif
>  
>  	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
>  #ifdef CONFIG_PAGE_POOL_STATS
> -		free_percpu(pool->recycle_stats);
> +		if (!(pool->p.flags & PP_FLAG_SYSTEM_POOL))
> +			free_percpu(pool->recycle_stats);
>  #endif
>  		return -ENOMEM;
>  	}
> @@ -251,7 +262,8 @@ static void page_pool_uninit(struct page_pool *pool)
>  		put_device(pool->p.dev);
>  
>  #ifdef CONFIG_PAGE_POOL_STATS
> -	free_percpu(pool->recycle_stats);
> +	if (!(pool->p.flags & PP_FLAG_SYSTEM_POOL))
> +		free_percpu(pool->recycle_stats);
>  #endif
>  }
>  
> 

