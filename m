Return-Path: <netdev+bounces-147614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8529DAAD1
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 16:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DBD1637FA
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E70E3C488;
	Wed, 27 Nov 2024 15:31:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E850240BF2;
	Wed, 27 Nov 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721480; cv=none; b=KEXtAsF9b6T6FLiKlXgAs1VN9JqZIjIZvSQnU7i2Ouft0W5SkOKzt3vSzJ8T2RMEz0gzYQlgnes/nBzq/T8Yp+qdVD2uDrWSlrudZpEma6Ob1u33/TARxGTpJboknZJlDJKhvvPkbkpF5VtWTZF2/jNLC/nRojRKWtKT1NKP15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721480; c=relaxed/simple;
	bh=pubFsu2duy/OPMVsYcsHApVWHA9DZRmxt9oXT1BKVEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjX5M9xd9hpoST/RQOWP/z7n2X25obhfofqZzLq2zdRCL5MWfm7PIWfnUAaeKpz4iyHe0OAJIM254LpEToUpK1ZNmvExu1tP8yqEhQ3qM3eYaH0B1BSfAK3kOll2ai9RYa+aj7XUKjD+jY4k34j/1OoPe11jXZjsOiGaCpOPhYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5813C1477;
	Wed, 27 Nov 2024 07:31:46 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C7FA3F58B;
	Wed, 27 Nov 2024 07:31:13 -0800 (PST)
Message-ID: <41dfc444-1bab-4f9d-af11-4bbd93a9fe4b@arm.com>
Date: Wed, 27 Nov 2024 15:31:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Mina Almasry <almasrymina@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, liuyonglong@huawei.com,
 fanghaiqing@huawei.com, zhangkun09@huawei.com, IOMMU
 <iommu@lists.linux.dev>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-3-linyunsheng@huawei.com>
 <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
 <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
 <CAHS8izM+sK=48gfa3gRNffu=T6t6-2vaS60QvH79zFA3gSDv9g@mail.gmail.com>
 <CAKgT0Uc-SDHsGkgmLeAuo5GLE0H43i3h7mmzG88BQojfCoQGGA@mail.gmail.com>
 <8f45cc4f-f5fc-4066-9ee1-ba59bf684b07@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <8f45cc4f-f5fc-4066-9ee1-ba59bf684b07@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/11/2024 9:35 am, Yunsheng Lin wrote:
> On 2024/11/27 7:53, Alexander Duyck wrote:
>> On Tue, Nov 26, 2024 at 1:51 PM Mina Almasry <almasrymina@google.com> wrote:
>>>
>>> On Thu, Nov 21, 2024 at 12:03 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>>
>>>> On 2024/11/20 23:10, Jesper Dangaard Brouer wrote:
>>>>>
>>>>>>        page_pool_detached(pool);
>>>>>>        pool->defer_start = jiffies;
>>>>>>        pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
>>>>>> @@ -1159,7 +1228,7 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
>>>>>>        /* Flush pool alloc cache, as refill will check NUMA node */
>>>>>>        while (pool->alloc.count) {
>>>>>>            netmem = pool->alloc.cache[--pool->alloc.count];
>>>>>> -        page_pool_return_page(pool, netmem);
>>>>>> +        __page_pool_return_page(pool, netmem);
>>>>>>        }
>>>>>>    }
>>>>>>    EXPORT_SYMBOL(page_pool_update_nid);
>>>>>
>>>>> Thanks for continuing to work on this :-)
>>>>
>>>> I am not sure how scalable the scanning is going to be if the memory size became
>>>> bigger, which is one of the reason I was posting it as RFC for this version.
>>>>
>>>> For some quick searching here, it seems there might be server with max ram capacity
>>>> of 12.3TB, which means the scanning might take up to about 10 secs for those systems.
>>>> The spin_lock is used to avoid concurrency as the page_pool_put_page() API might be
>>>> called from the softirq context, which might mean there might be spinning of 12 secs
>>>> in the softirq context.
>>>>
>>>> And it seems hard to call cond_resched() when the scanning and unmapping takes a lot
>>>> of time as page_pool_put_page() might be called concurrently when pool->destroy_lock
>>>> is released, which might means page_pool_get_dma_addr() need to be checked to decide
>>>> if the mapping is already done or not for each page.
>>>>
>>>> Also, I am not sure it is appropriate to stall the driver unbound up to 10 secs here
>>>> for those large memory systems.
>>>>
>>>> https://www.broadberry.com/12tb-ram-supermicro-servers?srsltid=AfmBOorCPCZQBSv91mOGH3WTg9Cq0MhksnVYL_eXxOHtHJyuYzjyvwgH
>>>>
>>>
>>> FWIW I'm also concerned about the looping of all memory on the system.
>>> In addition to the performance, I think (but not sure), that
>>> CONFIG_MEMORY_HOTPLUG may mess such a loop as memory may appear or
>>> disappear concurrently. Even if not, the CPU cost of this may be
>>> significant. I'm imagining the possibility of having many page_pools
>>> allocated on the system for many hardware queues, (and maybe multiple
>>> pp's per queue for applications like devmem TCP), and each pp looping
>>> over the entire xTB memory on page_pool_destroy()...
>>>
>>> My 2 cents here is that a more reasonable approach is to have the pp
>>> track all pages it has dma-mapped, without the problems in the
>>> previous iterations of this patch:
>>>
>>> 1. When we dma-map a page, we add it to some pp->dma_mapped data
>>> structure (maybe xarray or rculist).
>>> 2. When we dma-unmap a page, we remove it from pp->dma_mapped.
>>> 3 When we destroy the pp, we traverse pp->dma_mapped and unmap all the
>>> pages there.
>>
>> The thing is this should be a very rare event as it should apply only
>> when a device is removed and still has pages outstanding shouldn't it?
>> The problem is that maintaining a list of in-flight DMA pages will be
>> very costly and will make the use of page pool expensive enough that I
>> would worry it might be considered less than useful. Once we add too
>> much overhead the caching of the DMA address doesn't gain us much on
>> most systems in that case.
>>
>>> I haven't looked deeply, but with the right data structure we may be
>>> able to synchronize 1, 2, and 3 without any additional locks. From a
>>> quick skim it seems maybe rculist and xarray can do this without
>>> additional locks, maybe.
> 
> I am not sure how the above right data structure without any additional
> locks will work, but my feeling is that the issues mentioned in [1] will
> likely apply to the above right data structure too.
> 
> 1. https://lore.kernel.org/all/6233e2c3-3fea-4ed0-bdcc-9a625270da37@huawei.com/
> 
>>>
>>> Like stated in the previous iterations of this approach, we should not
>>> be putting any hard limit on the amount of memory the pp can allocate,
>>> and we should not have to mess with the page->pp entry in struct page.
> 
> It would be good to be more specific about how it is done without 'messing'
> with the page->pp entry in struct page using some pseudocode or RFC if you
> call the renaming as messing.
> 
>>
>> I agree with you on the fact that we shouldn't be setting any sort of
>> limit. The current approach to doing the unmapping is more-or-less the
>> brute force way of doing it working around the DMA api. I wonder if we
>> couldn't look at working with it instead and see if there wouldn't be
>> some way for us to reduce the overhead instead of having to do the
>> full scan of the page table.
>>
>> One thought in that regard though would be to see if there were a way
>> to have the DMA API itself provide some of that info. I know the DMA
>> API should be storing some of that data for the mapping as we have to
>> go through and invalidate it if it is stored.
>>
>> Another alternative would be to see if we have the option to just
>> invalidate the DMA side of things entirely for the device. Essentially
>> unregister the device from the IOMMU instead of the mappings. If that
>> is an option then we could look at leaving the page pool in a state
>> where it would essentially claim it no longer has to do the DMA unmap
>> operations and is just freeing the remaining lingering pages.
> 
> If we are going to 'invalidate the DMA side of things entirely for the
> device', synchronization from page_pool might just go to the DMA core as
> concurrent calling for dma unmapping API and 'invalidating' operation still
> exist. If the invalidating is a common feature, perhaps it makes sense to
> do that in the DMA core, otherwise it might just add unnecessary overhead
> for other callers of DMA API.
> 
> As mentioned by Robin in [2], the DMA core seems to make a great deal of
> effort to catch DMA API misuse in kernel/dma/debug.c, it seems doing the
> above might invalidate some of the dma debug checking.

Has nobody paused to consider *why* dma-debug is an optional feature 
with an explicit performance warning? If you're concerned about the 
impact of keeping track of DMA mappings within the confines of the 
page_pool usage model, do you really imagine it could somehow be cheaper 
to keep track of them at the generic DMA API level without the benefit 
of any assumptions at all?

Yes, in principle we could add a set of "robust" DMA APIs which make 
sure racy sync calls are safe and offer a "clean up all my outstanding 
mappings" op, and they would offer approximately as terrible performance 
as the current streaming APIs with dma-debug enabled, because it would 
be little different from what dma-debug already does. The checks 
themselves aren't complicated; the generally-prohibitive cost lies in 
keeping track of mappings and allocations so that they *can* be checked 
internally.

Whatever you think is hard to do in the page_pool code to fix that 
code's own behaviour, it's even harder to do from elsewhere with less 
information.

Thanks,
Robin.

> 
> 2. https://lore.kernel.org/all/caf31b5e-0e8f-4844-b7ba-ef59ed13b74e@arm.com/
> 
>>

