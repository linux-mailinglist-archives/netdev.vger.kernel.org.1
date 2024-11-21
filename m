Return-Path: <netdev+bounces-146602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF199D486D
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C96B1F22222
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0AC18660C;
	Thu, 21 Nov 2024 08:03:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E85E146A6B;
	Thu, 21 Nov 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176211; cv=none; b=qRNekxN98GDqJu+tqvQiQDPS5DUBnN9RViTy3Po+uI+tbkouFtIaV37zQellrUvC+VHMgEkAp+bDPtygK5fBRZg9qZtNBdpXleDO9lDkq/Ee8SN4xjbgaVtxiGv3mwO1OAyzE64vNLo+Tj9WjX46upsRrnXgS1+MbO6uurzMDxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176211; c=relaxed/simple;
	bh=QpQUzQdGqFnQeB4YaCZR9Di+RNpOjgc+Ht1vo+KoRZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uwIKU+HFRz/nKvsDd4kBD3V8q0Meq4+joc0mETJ9hnt1ugZdkgsAowPzc9QSgLNnDKB9B7ztGM2PPtsuXwfFrdXRhgX3Ffjp+vheQwdiwwz5ZeoJOminy+t89ilXRlhd17LuvPyGbNdqHtye4u0QtsPE1PqV6hgIun+sacdKnaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xv9gF0LHrz21lfD;
	Thu, 21 Nov 2024 16:02:01 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 28AF918001B;
	Thu, 21 Nov 2024 16:03:24 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Nov 2024 16:03:23 +0800
Message-ID: <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
Date: Thu, 21 Nov 2024 16:03:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has
 already unbound
To: Jesper Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-3-linyunsheng@huawei.com>
 <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/20 23:10, Jesper Dangaard Brouer wrote:

...

>>         /* No more consumers should exist, but producers could still
>>        * be in-flight.
>> @@ -1119,6 +1134,58 @@ void page_pool_disable_direct_recycling(struct page_pool *pool)
>>   }
>>   EXPORT_SYMBOL(page_pool_disable_direct_recycling);
>>   +static void page_pool_inflight_unmap(struct page_pool *pool)
>> +{
>> +    unsigned int unmapped = 0;
>> +    struct zone *zone;
>> +    int inflight;
>> +
>> +    if (!pool->dma_map || pool->mp_priv)
>> +        return;
>> +
>> +    get_online_mems();
>> +    spin_lock_bh(&pool->destroy_lock);
>> +
>> +    inflight = page_pool_inflight(pool, false);
>> +    for_each_populated_zone(zone) {
>> +        unsigned long end_pfn = zone_end_pfn(zone);
>> +        unsigned long pfn;
>> +
>> +        for (pfn = zone->zone_start_pfn; pfn < end_pfn; pfn++) {
>> +            struct page *page = pfn_to_online_page(pfn);
>> +
>> +            if (!page || !page_count(page) ||
>> +                (page->pp_magic & ~0x3UL) != PP_SIGNATURE ||
>> +                page->pp != pool)
>> +                continue;
>> +
>> +            dma_unmap_page_attrs(pool->p.dev,
>> +                         page_pool_get_dma_addr(page),
>> +                         PAGE_SIZE << pool->p.order,
>> +                         pool->p.dma_dir,
>> +                         DMA_ATTR_SKIP_CPU_SYNC |
>> +                         DMA_ATTR_WEAK_ORDERING);
>> +            page_pool_set_dma_addr(page, 0);
>> +
> 
> I feel this belongs in a helper function call.
> 
> Previously we had a function called: page_pool_release_page().

Previously I was going to reuse __page_pool_release_page_dma() for the above,
but it seems __page_pool_release_page_dma() has the duplicated pool->dma_map
checking for each page as page_pool_inflight_unmap() already check that before
calling __page_pool_release_page_dma().

> 
> This was used to convert the page into a normal page again, releasing
> page_pool dependencies.  It was used when packet transitioned into the
> netstack, but it was removed when we decided it was safe to let netstack
> return pp pages.
> 
> Removed in commits:
>  - 535b9c61bdef ("net: page_pool: hide page_pool_release_page()")
>  - 07e0c7d3179d ("net: page_pool: merge page_pool_release_page() with page_pool_return_page()")
> 
> 
>> +            unmapped++;
>> +
>> +            /* Skip scanning all pages when debug is disabled */
>> +            if (!IS_ENABLED(CONFIG_DEBUG_NET) &&
>> +                inflight == unmapped)
>> +                goto out;
>> +        }
>> +    }
>> +
>> +out:
>> +    WARN_ONCE(page_pool_inflight(pool, false) != unmapped,
>> +          "page_pool(%u): unmapped(%u) != inflight pages(%d)\n",
>> +          pool->user.id, unmapped, inflight);
>> +
>> +    pool->dma_map = false;
>> +    spin_unlock_bh(&pool->destroy_lock);
>> +    put_online_mems();
>> +}
>> +
>>   void page_pool_destroy(struct page_pool *pool)
>>   {
>>       if (!pool)
>> @@ -1139,6 +1206,8 @@ void page_pool_destroy(struct page_pool *pool)
>>        */
>>       synchronize_rcu();
>>   +    page_pool_inflight_unmap(pool);
>> +
> 
> Reaching here means we have detected in-flight packets/pages.
> 
> In "page_pool_inflight_unmap" we scan and find those in-flight pages to
> DMA unmap them. Then below we wait for these in-flight pages again.
> Why don't we just "release" (page_pool_release_page) those in-flight
> pages from belonging to the page_pool, when we found them during scanning?
> 
> If doing so, we can hopefully remove the periodic checking code below.

I thought about that too, but it means more complicated work than just
calling the page_pool_release_page() as page->pp_ref_count need to be
converted into page->_refcount for the above to work, it seems hard to
do that with least performance degradation as the racing against
page_pool_put_page() being called concurrently.

> 
>>       page_pool_detached(pool);
>>       pool->defer_start = jiffies;
>>       pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
>> @@ -1159,7 +1228,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
>>       /* Flush pool alloc cache, as refill will check NUMA node */
>>       while (pool->alloc.count) {
>>           netmem = pool->alloc.cache[--pool->alloc.count];
>> -        page_pool_return_page(pool, netmem);
>> +        __page_pool_return_page(pool, netmem);
>>       }
>>   }
>>   EXPORT_SYMBOL(page_pool_update_nid);
> 
> Thanks for continuing to work on this :-)

I am not sure how scalable the scanning is going to be if the memory size became
bigger, which is one of the reason I was posting it as RFC for this version.

For some quick searching here, it seems there might be server with max ram capacity
of 12.3TB, which means the scanning might take up to about 10 secs for those systems.
The spin_lock is used to avoid concurrency as the page_pool_put_page() API might be
called from the softirq context, which might mean there might be spinning of 12 secs
in the softirq context.

And it seems hard to call cond_resched() when the scanning and unmapping takes a lot
of time as page_pool_put_page() might be called concurrently when pool->destroy_lock
is released, which might means page_pool_get_dma_addr() need to be checked to decide
if the mapping is already done or not for each page.

Also, I am not sure it is appropriate to stall the driver unbound up to 10 secs here
for those large memory systems.

https://www.broadberry.com/12tb-ram-supermicro-servers?srsltid=AfmBOorCPCZQBSv91mOGH3WTg9Cq0MhksnVYL_eXxOHtHJyuYzjyvwgH

> 
> --Jesper

