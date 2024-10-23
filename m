Return-Path: <netdev+bounces-138143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 012919AC281
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301D91C20B43
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0651714A3;
	Wed, 23 Oct 2024 09:00:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528FA15B554;
	Wed, 23 Oct 2024 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674000; cv=none; b=J9dgge+H+JtYopCskwCA9HvI3742YVGEVJn9flbRQWGVMLnJXSfQ7/FxfGs4fOcyjNWE8xAbi02gWRjsimisSG9by1AzUM0LZVozpMYoZxM56ohK8bKxoQRHN6OJD/N6OEQ9m0uZogs6sHW07frzkT2tCKROtm0wL6tUjJASOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674000; c=relaxed/simple;
	bh=Jw+DmzBHar7iZZ6B+14E8lFU06r4nIFW7AqGx1XmAQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RyjK951X4iw/HnS7ZIarqtrtOOopVoRYMIUBH4Eb2d+jtT9Z6SDBiDlHAoNkzlLSZlKgQELTSCp9AhZ6H7lmPJAAJiB44znEpYQ/984Ap5IYD4gHrDt5nNKndEvA4rWOvupLLO6w88qKch+AodKwPmWxL442bs/ijcgIZbs5yMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XYNKY549Yz1ylvv;
	Wed, 23 Oct 2024 17:00:01 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 73BF41A0188;
	Wed, 23 Oct 2024 16:59:54 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 16:59:53 +0800
Message-ID: <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com>
Date: Wed, 23 Oct 2024 16:59:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
To: Jesper Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <fanghaiqing@huawei.com>,
	<liuyonglong@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, kernel-team
	<kernel-team@cloudflare.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/23 2:14, Jesper Dangaard Brouer wrote:
> 
> 
> On 22/10/2024 05.22, Yunsheng Lin wrote:
>> Networking driver with page_pool support may hand over page
>> still with dma mapping to network stack and try to reuse that
>> page after network stack is done with it and passes it back
>> to page_pool to avoid the penalty of dma mapping/unmapping.
>> With all the caching in the network stack, some pages may be
>> held in the network stack without returning to the page_pool
>> soon enough, and with VF disable causing the driver unbound,
>> the page_pool does not stop the driver from doing it's
>> unbounding work, instead page_pool uses workqueue to check
>> if there is some pages coming back from the network stack
>> periodically, if there is any, it will do the dma unmmapping
>> related cleanup work.
>>
>> As mentioned in [1], attempting DMA unmaps after the driver
>> has already unbound may leak resources or at worst corrupt
>> memory. Fundamentally, the page pool code cannot allow DMA
>> mappings to outlive the driver they belong to.
>>
>> Currently it seems there are at least two cases that the page
>> is not released fast enough causing dma unmmapping done after
>> driver has already unbound:
>> 1. ipv4 packet defragmentation timeout: this seems to cause
>>     delay up to 30 secs.
>> 2. skb_defer_free_flush(): this may cause infinite delay if
>>     there is no triggering for net_rx_action().
>>
>> In order not to do the dma unmmapping after driver has already
>> unbound and stall the unloading of the networking driver, add
>> the pool->items array to record all the pages including the ones
>> which are handed over to network stack, so the page_pool can
> 
> I really really dislike this approach!
> 
> Nacked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> Having to keep an array to record all the pages including the ones
> which are handed over to network stack, goes against the very principle
> behind page_pool. We added members to struct page, such that pages could
> be "outstanding".

Before and after this patch both support "outstanding", the difference is
how many "outstanding" pages do they support.

The question seems to be do we really need unlimited inflight page for
page_pool to work as mentioned in [1]?

1. https://lore.kernel.org/all/5d9ea7bd-67bb-4a9d-a120-c8f290c31a47@huawei.com/

> 
> The page_pool already have a system for waiting for these outstanding /
> inflight packets to get returned.  As I suggested before, the page_pool
> should simply take over the responsability (from net_device) to free the
> struct device (after inflight reach zero), where AFAIK the DMA device is
> connected via.

It seems you mentioned some similar suggestion in previous version,
it would be good to show some code about the idea in your mind, I am sure
that Yonglong Liu Cc'ed will be happy to test it if there some code like
POC/RFC is provided.

I should mention that it seems that DMA device is not longer vaild when
remove() function of the device driver returns, as mentioned in [2], which
means dma API is not allowed to called after remove() function of the device
driver returns.

2. https://www.spinics.net/lists/netdev/msg1030641.html

> 
> The alternative is what Kuba suggested (and proposed an RFC for),  that
> the net_device teardown waits for the page_pool inflight packets.

As above, the question is how long does the waiting take here?
Yonglong tested Kuba's RFC, see [3], the waiting took forever due to
reason as mentioned in commit log:
"skb_defer_free_flush(): this may cause infinite delay if there is no
triggering for net_rx_action()."

And there seems to be some device lock held during the waiting causing
hung_task log in [3] too, as it is the vf disabling causing the driver
unbound.

3. https://lore.kernel.org/netdev/758b4d47-c980-4f66-b4a4-949c3fc4b040@huawei.com/

> 
> 
>> do the dma unmmapping for those pages when page_pool_destroy()
>> is called. As the pool->items need to be large enough to avoid
>> performance degradation, add a 'item_full' stat to indicate the
>> allocation failure due to unavailability of pool->items.
> 
> Are you saying page_pool will do allocation failures, based on the size
> of this pool->items array?

Yes.

> 
> Production workloads will have very large number of outstanding packet
> memory in e.g. in TCP sockets.  In production I'm seeing TCP memory
> reach 24 GiB (on machines with 384GiB memory).

It would be good to provide more information here:
1. How much is the above '24 GiB' memory it is about rx?
2. What is value of /proc/sys/net/ipv4/tcp_rmem?
3. How many network port does the machine is using?
4. How many queues and what is queue depth of each network port?

Like there need to be a specific number of entries that a nic hw queue
are using, I believe there need to be a specific number of inflight pages
for page_pool to reach the best performance, it just can not be unlimit,
otherwise it will eat up all of the '384GiB memory'.

If the number of inflight pages needed is so dynamic and hard to calculate,
linked list can always be used instead of fixed array here, but I am not
sure if it is worthing the complexity here yet.

> 
> 
>> Note, the devmem patchset seems to make the bug harder to fix,
>> and may make backporting harder too. As there is no actual user
>> for the devmem and the fixing for devmem is unclear for now,
>> this patch does not consider fixing the case for devmem yet.
>>
>> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
>>
>> Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>> CC: Robin Murphy <robin.murphy@arm.com>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> CC: IOMMU <iommu@lists.linux.dev>
>> ---
>>   include/linux/mm_types.h        |   2 +-
>>   include/linux/skbuff.h          |   1 +
>>   include/net/netmem.h            |  10 +-
>>   include/net/page_pool/helpers.h |   4 +-
>>   include/net/page_pool/types.h   |  17 ++-
>>   net/core/devmem.c               |   4 +-
>>   net/core/netmem_priv.h          |   5 +-
>>   net/core/page_pool.c            | 213 ++++++++++++++++++++++++++------
>>   net/core/page_pool_priv.h       |  10 +-
>>   9 files changed, 210 insertions(+), 56 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 6e3bdf8e38bc..d3e30dcfa021 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -120,7 +120,7 @@ struct page {
>>                * page_pool allocated pages.
>>                */
>>               unsigned long pp_magic;
>> -            struct page_pool *pp;
>> +            struct page_pool_item *pp_item;
> 
> Why do we need to change the pp pointer?
> 
> Why can't we access the "items" array like pp->items?

The info about which entry of pp->items a specific 'struct page' is
using need to be in the 'struct page', so that the specific entry of
pp->items can be reused for another new page when the old page is
returned back to the page allocator.

And we still need the info about which page_pool does a specific
page belong to, that info is avaliable through the below helper:

static inline struct page_pool *page_pool_to_pp(struct page *page)
{
	struct page_pool_item *item = page->pp_item;

	return container_of(item, struct page_pool, items[item->pp_idx]);
}

> 
> 
>>               unsigned long _pp_mapping_pad;
>>               unsigned long dma_addr;
>>               atomic_long_t pp_ref_count;

