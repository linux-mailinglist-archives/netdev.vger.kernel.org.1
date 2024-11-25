Return-Path: <netdev+bounces-147242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978E69D893F
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 16:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596F12857F6
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9471B3958;
	Mon, 25 Nov 2024 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEMeddgZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32CD1946B9;
	Mon, 25 Nov 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548306; cv=none; b=ZBwaRtQiZciz9vDIi8N+p405qscxWm+5Zv2K3swoFZYxIA5/G7JHMwtK495/pubreMJR6I2BJllUGsS9fW3HX2w5KE55jDZ60kXShIKbkkCccDYwd2+jxLFC8YaBJXqCzTq59TbJ401s8RhGK/km9eA5X6Xl4YtJzBTMTdRmn50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548306; c=relaxed/simple;
	bh=4byW/QD7+fKVTiPxqW/XqUJMc0hrhxtLwUZUEghQ5aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jf972rL7xDVqFZnN77+8eBJ4XD16Ywr+qNUPrT2rc4CmMIkz2dXmHTpX3K4jbmnf6p8Et53HbpILeDLdy4W+rfzzsScniQ/jF6xPENHfV/IQd3wcRIGqJESDycxY4Q16IegN2AIziu/k4pWENvLbPiw8Lz/x/0MPlKh5uDEd4K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEMeddgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED967C4CECE;
	Mon, 25 Nov 2024 15:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548306;
	bh=4byW/QD7+fKVTiPxqW/XqUJMc0hrhxtLwUZUEghQ5aI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nEMeddgZsERoLXjYA6kQwUDbYrbDhZgqVxE//BCslRj93/sPev9/ppY2zAvKAl8Wu
	 qa0uRTJjUMpSXi3Y2RCiM2ZqxYuGRb55fBKr5KhZoeDaIBeC0KGVpkAu5VEtJ0Qjfm
	 PdW+tIKckO0r3O78mNTefAXG7MmWd8ukFBQmsOf4LZWFAKRDbfxTzS5Dnv0NcHzXta
	 FNUYIg05YecceTWElO4RT2jknVWpGm1hWtks5rW3ubWj+lnb58Jn6DVEZfBSYXe8mY
	 JWHP4pOx883giciJBHpkvBoojCC+WZier+vnGbdL3XgpkovqyM9S2W7b4s4DNgF93k
	 jlhDc5iVEmFlQ==
Message-ID: <ac728cc1-2ccb-4207-ae11-527a3ed8fbb6@kernel.org>
Date: Mon, 25 Nov 2024 16:25:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-3-linyunsheng@huawei.com>
 <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
 <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/11/2024 09.03, Yunsheng Lin wrote:
> On 2024/11/20 23:10, Jesper Dangaard Brouer wrote:
> 
> ...
> 
>>>          /* No more consumers should exist, but producers could still
>>>         * be in-flight.
>>> @@ -1119,6 +1134,58 @@ void page_pool_disable_direct_recycling(struct page_pool *pool)
>>>    }
>>>    EXPORT_SYMBOL(page_pool_disable_direct_recycling);
>>>    +static void page_pool_inflight_unmap(struct page_pool *pool)
>>> +{
>>> +    unsigned int unmapped = 0;
>>> +    struct zone *zone;
>>> +    int inflight;
>>> +
>>> +    if (!pool->dma_map || pool->mp_priv)
>>> +        return;
>>> +
>>> +    get_online_mems();
>>> +    spin_lock_bh(&pool->destroy_lock);
>>> +
>>> +    inflight = page_pool_inflight(pool, false);
>>> +    for_each_populated_zone(zone) {
>>> +        unsigned long end_pfn = zone_end_pfn(zone);
>>> +        unsigned long pfn;
>>> +
>>> +        for (pfn = zone->zone_start_pfn; pfn < end_pfn; pfn++) {
>>> +            struct page *page = pfn_to_online_page(pfn);
>>> +
>>> +            if (!page || !page_count(page) ||
>>> +                (page->pp_magic & ~0x3UL) != PP_SIGNATURE ||
>>> +                page->pp != pool)
>>> +                continue;
>>> +
>>> +            dma_unmap_page_attrs(pool->p.dev,
>>> +                         page_pool_get_dma_addr(page),
>>> +                         PAGE_SIZE << pool->p.order,
>>> +                         pool->p.dma_dir,
>>> +                         DMA_ATTR_SKIP_CPU_SYNC |
>>> +                         DMA_ATTR_WEAK_ORDERING);
>>> +            page_pool_set_dma_addr(page, 0);
>>> +
>>
>> I feel this belongs in a helper function call.
>>
>> Previously we had a function called: page_pool_release_page().
> 
> Previously I was going to reuse __page_pool_release_page_dma() for the above,
> but it seems __page_pool_release_page_dma() has the duplicated pool->dma_map
> checking for each page as page_pool_inflight_unmap() already check that before
> calling __page_pool_release_page_dma().
> 
>>
>> This was used to convert the page into a normal page again, releasing
>> page_pool dependencies.  It was used when packet transitioned into the
>> netstack, but it was removed when we decided it was safe to let netstack
>> return pp pages.
>>
>> Removed in commits:
>>   - 535b9c61bdef ("net: page_pool: hide page_pool_release_page()")
>>   - 07e0c7d3179d ("net: page_pool: merge page_pool_release_page() with page_pool_return_page()")
>>
>>
>>> +            unmapped++;
>>> +
>>> +            /* Skip scanning all pages when debug is disabled */
>>> +            if (!IS_ENABLED(CONFIG_DEBUG_NET) &&
>>> +                inflight == unmapped)
>>> +                goto out;
>>> +        }
>>> +    }
>>> +
>>> +out:
>>> +    WARN_ONCE(page_pool_inflight(pool, false) != unmapped,
>>> +          "page_pool(%u): unmapped(%u) != inflight pages(%d)\n",
>>> +          pool->user.id, unmapped, inflight);
>>> +
>>> +    pool->dma_map = false;
>>> +    spin_unlock_bh(&pool->destroy_lock);
>>> +    put_online_mems();
>>> +}
>>> +
>>>    void page_pool_destroy(struct page_pool *pool)
>>>    {
>>>        if (!pool)
>>> @@ -1139,6 +1206,8 @@ void page_pool_destroy(struct page_pool *pool)
>>>         */
>>>        synchronize_rcu();
>>>    +    page_pool_inflight_unmap(pool);
>>> +
>>
>> Reaching here means we have detected in-flight packets/pages.
>>
>> In "page_pool_inflight_unmap" we scan and find those in-flight pages to
>> DMA unmap them. Then below we wait for these in-flight pages again.
>> Why don't we just "release" (page_pool_release_page) those in-flight
>> pages from belonging to the page_pool, when we found them during scanning?
>>
>> If doing so, we can hopefully remove the periodic checking code below.
> 
> I thought about that too, but it means more complicated work than just
> calling the page_pool_release_page() as page->pp_ref_count need to be
> converted into page->_refcount for the above to work, it seems hard to
> do that with least performance degradation as the racing against
> page_pool_put_page() being called concurrently.
> 

Maybe we can have a design that avoid/reduce concurrency.  Can we
convert the suggested pool->destroy_lock into an atomic?
(Doing an *atomic* READ in page_pool_return_page, should be fast if we
keep this cache in in (cache coherence) Shared state).

In your new/proposed page_pool_return_page() when we see the
"destroy_cnt" (now atomic READ) bigger than zero, then we can do nothing
(or maybe we need decrement page-refcnt?), as we know the destroy code
will be taking care of "releasing" the pages from the page pool.

Once the a page is release from a page pool it becomes a normal page,
that adhere to normal page refcnt'ing. That is how it worked before with
page_pool_release_page().
The later extensions with page fragment support and devmem might have
complicated this code path.


>>
>>>        page_pool_detached(pool);
>>>        pool->defer_start = jiffies;
>>>        pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
>>> @@ -1159,7 +1228,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
>>>        /* Flush pool alloc cache, as refill will check NUMA node */
>>>        while (pool->alloc.count) {
>>>            netmem = pool->alloc.cache[--pool->alloc.count];
>>> -        page_pool_return_page(pool, netmem);
>>> +        __page_pool_return_page(pool, netmem);
>>>        }
>>>    }
>>>    EXPORT_SYMBOL(page_pool_update_nid);
>>
>> Thanks for continuing to work on this :-)
> 
> I am not sure how scalable the scanning is going to be if the memory size became
> bigger, which is one of the reason I was posting it as RFC for this version.
> 
> For some quick searching here, it seems there might be server with max ram capacity
> of 12.3TB, which means the scanning might take up to about 10 secs for those systems.
> The spin_lock is used to avoid concurrency as the page_pool_put_page() API might be
> called from the softirq context, which might mean there might be spinning of 12 secs
> in the softirq context.
> 
> And it seems hard to call cond_resched() when the scanning and unmapping takes a lot
> of time as page_pool_put_page() might be called concurrently when pool->destroy_lock
> is released, which might means page_pool_get_dma_addr() need to be checked to decide
> if the mapping is already done or not for each page.
> 

As explained above, once the "destroy" phase have started, I hope we can
avoid concurrently returned pages to wait on a lock.   As IMHO it will
be problematic to stall the page_pool_return_page() call for this long.
The take down "destroy" of a page pool is always initiated from
userspace, so is possible to call cond_resched() from this context.

--Jesper

