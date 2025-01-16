Return-Path: <netdev+bounces-158884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E8DA13A3E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDF23A7BE0
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB251DE8A9;
	Thu, 16 Jan 2025 12:53:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B01DD877;
	Thu, 16 Jan 2025 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737031983; cv=none; b=nuDWNuqLEdEuLwFec1+ui3a69MZ2oY7vhAB70LhWSVDJbVIGn1NJtBmEVIXRNo7Jypm1K97SQ1jXUC/H0dZWlS1MbQ0RYIQ9BghCRGczqejWgrcuUAao7e+mavOphtqUIq1JugnnLHfAEJmXYNLEIVhnNptcU13XkA4rIYKoVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737031983; c=relaxed/simple;
	bh=JX+FZ+4pEGK/AUxs/jOM6wYs5it6Xt2+CUUfeUB2yUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZA46Ux3NJYrYJ2ORi74Nh01uwgWJHjwz6IjfQ7Uml14Xi2fhiOZgtvJHN6p3Z5B3MC/iMEslFPZAv7zAtu+u8tpeXm4PdbZGEEifhxT/bPBZXjSIwn73gjduSXGcyl2BG6zgsbGmnocYVGhNB4eF0KoUAW2T+9q6AsO7IWqACnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YYjPb35bPzbnp2;
	Thu, 16 Jan 2025 20:49:55 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F2BD61401F4;
	Thu, 16 Jan 2025 20:52:58 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Jan 2025 20:52:58 +0800
Message-ID: <2b5a58f3-d67a-4bf7-921a-033326958ac6@huawei.com>
Date: Thu, 16 Jan 2025 20:52:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/8] page_pool: fix IOMMU crash when driver
 has already unbound
To: Jesper Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-4-linyunsheng@huawei.com>
 <921c827c-41b7-40af-8c01-c21adbe8f41f@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <921c827c-41b7-40af-8c01-c21adbe8f41f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/1/16 0:29, Jesper Dangaard Brouer wrote:
> 
> 
> On 10/01/2025 14.06, Yunsheng Lin wrote:
> [...]
>> In order not to call DMA APIs to do DMA unmmapping after driver
>> has already unbound and stall the unloading of the networking
>> driver, use some pre-allocated item blocks to record inflight
>> pages including the ones which are handed over to network stack,
>> so the page_pool can do the DMA unmmapping for those pages when
>> page_pool_destroy() is called. As the pre-allocated item blocks
>> need to be large enough to avoid performance degradation, add a
>> 'item_fast_empty' stat to indicate the unavailability of the
>> pre-allocated item blocks.
>>
> 

...

>> +
>> +static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
>> +                             netmem_ref netmem,
>> +                             bool destroyed)
>> +{
>> +    struct page_pool_item *item;
>> +    dma_addr_t dma;
>> +
>> +    if (!pool->dma_map)
>> +        /* Always account for inflight pages, even if we didn't
>> +         * map them
>> +         */
>> +        return;
>> +
>> +    dma = page_pool_get_dma_addr_netmem(netmem);
>> +    item = netmem_get_pp_item(netmem);
>> +
>> +    /* dma unmapping is always needed when page_pool_destory() is not called
>> +     * yet.
>> +     */
>> +    DEBUG_NET_WARN_ON_ONCE(!destroyed && !page_pool_item_is_mapped(item));
>> +    if (unlikely(destroyed && !page_pool_item_is_mapped(item)))
>> +        return;
>> +
>> +    /* When page is unmapped, it cannot be returned to our pool */
>> +    dma_unmap_page_attrs(pool->p.dev, dma,
>> +                 PAGE_SIZE << pool->p.order, pool->p.dma_dir,
>> +                 DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
>> +    page_pool_set_dma_addr_netmem(netmem, 0);
>> +    page_pool_item_clear_mapped(item);
>> +}
>> +
> 
> I have a hard time reading/reviewing/maintaining below code, without
> some design description.  This code needs more comments on what is the
> *intend* and design it's trying to achieve.
> 
> From patch description the only hint I have is:
>  "use some pre-allocated item blocks to record inflight pages"
> 
> E.g. Why is it needed/smart to hijack the page->pp pointer?

Mainly because there is no space available for keeping tracking of inflight
pages, using page->pp can only find the page_pool owning the page, but page_pool
is not able to keep track of the inflight page when the page is handled by
networking stack.

By using page_pool_item as below, the state is used to tell if a specific
item is being used/dma mapped or not by scanning all the item blocks in
pool->item_blocks. If a specific item is used by a page, then 'pp_netmem'
will point to that page so that dma unmapping can be done for that page
when page_pool_destroy() is called, otherwise free items sit in the
pool->hold_items or pool->release_items by using 'lentry':

struct page_pool_item {
	unsigned long state;
	
	union {
		netmem_ref pp_netmem;
		struct llist_node lentry;
	};
};

When a page is added to the page_pool, a item is deleted from pool->hold_items
or pool->release_items and set the 'pp_netmem' pointing to that page and set
'state' accordingly in order to keep track of that page.

When a page is deleted from the page_pool, it is able to tell which page_pool
this page belong to by using the below function, and after clearing the 'state',
the item is added back to pool->release_items so that the item is reused for new
pages.

static inline struct page_pool_item_block *
page_pool_item_to_block(struct page_pool_item *item)
{
	return (struct page_pool_item_block *)((unsigned long)item & PAGE_MASK);
}

 static inline struct page_pool *page_pool_get_pp(struct page *page)
 {
      return page_pool_item_to_block(page->pp_item)->pp;
 }


> 
>> +static void __page_pool_item_init(struct page_pool *pool, struct page *page)
>> +{
> 
> Function name is confusing.  First I though this was init'ing a single
> item, but looking at the code it is iterating over ITEMS_PER_PAGE.
> 
> Maybe it should be called page_pool_item_block_init ?

The __page_pool_item_init() is added to make the below
page_pool_item_init() function more readable or maintainable, changing
it to page_pool_item_block_init doesn't seems consistent?

> 
>> +    struct page_pool_item_block *block = page_address(page);
>> +    struct page_pool_item *items = block->items;
>> +    unsigned int i;
>> +
>> +    list_add(&block->list, &pool->item_blocks);
>> +    block->pp = pool;
>> +
>> +    for (i = 0; i < ITEMS_PER_PAGE; i++) {
>> +        page_pool_item_init_state(&items[i]);
>> +        __llist_add(&items[i].lentry, &pool->hold_items);
>> +    }
>> +}
>> +
>> +static int page_pool_item_init(struct page_pool *pool)
>> +{
>> +#define PAGE_POOL_MIN_INFLIGHT_ITEMS        512
>> +    struct page_pool_item_block *block;
>> +    int item_cnt;
>> +
>> +    INIT_LIST_HEAD(&pool->item_blocks);
>> +    init_llist_head(&pool->hold_items);
>> +    init_llist_head(&pool->release_items);
>> +
>> +    item_cnt = pool->p.pool_size * 2 + PP_ALLOC_CACHE_SIZE +
>> +        PAGE_POOL_MIN_INFLIGHT_ITEMS;
>> +    while (item_cnt > 0) {
>> +        struct page *page;
>> +
>> +        page = alloc_pages_node(pool->p.nid, GFP_KERNEL, 0);
>> +        if (!page)
>> +            goto err;
>> +
>> +        __page_pool_item_init(pool, page);
>> +        item_cnt -= ITEMS_PER_PAGE;
>> +    }
>> +
>> +    return 0;
>> +err:
>> +    list_for_each_entry(block, &pool->item_blocks, list)
>> +        put_page(virt_to_page(block));

This one also have used-after-free problem as the page_pool_item_uninit
in the previous version.

>> +
>> +    return -ENOMEM;
>> +}
>> +


