Return-Path: <netdev+bounces-146533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 059809D3FE3
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 17:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BEE2812D4
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28735141987;
	Wed, 20 Nov 2024 16:18:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE085A4D5;
	Wed, 20 Nov 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119487; cv=none; b=ScFja+CcaxUIq5O78CJq/MDs7pgTqvciwNGINXRZS2nFvTuCGHMz1dAFM9VMJ48G3qcgY6/+7MS2DCMOTmP4oTgLyiaMDhhUHqdPdiVnXfV23UsPF5UPxmhpE2QD5UGSLbat1yxjHtHBl6403NzvFF+L/bv4N4AsreodtICck8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119487; c=relaxed/simple;
	bh=steiTH9WgmEuOIfuCUhnix08ztBgjaw+7hd+ArWDPkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QDAaLgbSBU+zuA1+rtd62QXp3vWL3FqEbjLYky6+juHNENjZ7GXmqAVpbIrXpcjND6Ns/yDdvs2nl+4sYBnkFH9rIgRxoLfxnQCV2I6vYTFRU5HI+HjMDcuWMR4Bvs7vu5Gbdparrcf/W3dhZTH5dLQ2YgoPE4aoTntKsmKMqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86D201480;
	Wed, 20 Nov 2024 08:18:32 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97A8A3F66E;
	Wed, 20 Nov 2024 08:18:00 -0800 (PST)
Message-ID: <15f937d7-7ac1-4a7f-abcd-abfede191b51@arm.com>
Date: Wed, 20 Nov 2024 16:17:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 3/3] page_pool: skip dma sync operation for
 inflight pages
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, IOMMU <iommu@lists.linux.dev>,
 MM <linux-mm@kvack.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-4-linyunsheng@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241120103456.396577-4-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/11/2024 10:34 am, Yunsheng Lin wrote:
> Skip dma sync operation for inflight pages before the
> page_pool_destroy() returns to the driver as DMA API
> expects to be called with a valid device bound to a
> driver as mentioned in [1].
> 
> After page_pool_destroy() is called, the page is not
> expected to be recycled back to pool->alloc cache and
> dma sync operation is not needed when the page is not
> recyclable or pool->ring is full, so only skip the dma
> sync operation for the infilght pages by clearing the
> pool->dma_sync under protection of rcu lock when page
> is recycled to pool->ring to ensure that there is no
> dma sync operation called after page_pool_destroy() is
> returned.

Something feels off here - either this is a micro-optimisation which I 
wouldn't really expect to be meaningful, or it means patch #2 doesn't 
actually do what it claims. If it really is possible to attempt to 
dma_sync a page *after* page_pool_inflight_unmap() has already reclaimed 
and unmapped it, that represents yet another DMA API lifecycle issue, 
which as well as being even more obviously incorrect usage-wise, could 
also still lead to the same crash (if the device is non-coherent).

Otherwise, I don't imagine it's really worth worrying about optimising 
out syncs for any pages which happen to get naturally returned after 
page_pool_destroy() starts but before they're explicitly reclaimed. 
Realistically, the kinds of big server systems where reclaim takes an 
appreciable amount of time are going to be coherent and skipping syncs 
anyway.

Thanks,
Robin.

> 1. https://lore.kernel.org/all/caf31b5e-0e8f-4844-b7ba-ef59ed13b74e@arm.com/
> CC: Robin Murphy <robin.murphy@arm.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: IOMMU <iommu@lists.linux.dev>
> CC: MM <linux-mm@kvack.org>
> Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>   net/core/page_pool.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 33a314abbba4..0bde7c6c781a 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -712,7 +712,8 @@ static void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
>   	rcu_read_unlock();
>   }
>   
> -static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
> +static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem,
> +				      unsigned int dma_sync_size)
>   {
>   	int ret;
>   	/* BH protection not needed if current is softirq */
> @@ -723,10 +724,13 @@ static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
>   
>   	if (!ret) {
>   		recycle_stat_inc(pool, ring);
> -		return true;
> +
> +		rcu_read_lock();
> +		page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
> +		rcu_read_unlock();
>   	}
>   
> -	return false;
> +	return !ret;
>   }
>   
>   /* Only allow direct recycling in special circumstances, into the
> @@ -779,10 +783,11 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
>   	if (likely(__page_pool_page_can_be_recycled(netmem))) {
>   		/* Read barrier done in page_ref_count / READ_ONCE */
>   
> -		page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
> -
> -		if (allow_direct && page_pool_recycle_in_cache(netmem, pool))
> +		if (allow_direct && page_pool_recycle_in_cache(netmem, pool)) {
> +			page_pool_dma_sync_for_device(pool, netmem,
> +						      dma_sync_size);
>   			return 0;
> +		}
>   
>   		/* Page found as candidate for recycling */
>   		return netmem;
> @@ -845,7 +850,7 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
>   
>   	netmem =
>   		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
> -	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
> +	if (netmem && !page_pool_recycle_in_ring(pool, netmem, dma_sync_size)) {
>   		/* Cache full, fallback to free pages */
>   		recycle_stat_inc(pool, ring_full);
>   		page_pool_return_page(pool, netmem);
> @@ -903,14 +908,18 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
>   
>   	/* Bulk producer into ptr_ring page_pool cache */
>   	in_softirq = page_pool_producer_lock(pool);
> +	rcu_read_lock();
>   	for (i = 0; i < bulk_len; i++) {
>   		if (__ptr_ring_produce(&pool->ring, data[i])) {
>   			/* ring full */
>   			recycle_stat_inc(pool, ring_full);
>   			break;
>   		}
> +		page_pool_dma_sync_for_device(pool, (__force netmem_ref)data[i],
> +					      -1);
>   	}
>   	recycle_stat_add(pool, ring, i);
> +	rcu_read_unlock();
>   	page_pool_producer_unlock(pool, in_softirq);
>   
>   	/* Hopefully all pages was return into ptr_ring */
> @@ -1200,6 +1209,8 @@ void page_pool_destroy(struct page_pool *pool)
>   	if (!page_pool_release(pool))
>   		return;
>   
> +	pool->dma_sync = false;
> +
>   	/* Paired with rcu lock in page_pool_napi_local() to enable clearing
>   	 * of pool->p.napi in page_pool_disable_direct_recycling() is seen
>   	 * before returning to driver to free the napi instance.

