Return-Path: <netdev+bounces-158951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0F0A13EED
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C57A53F4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E625922CBD4;
	Thu, 16 Jan 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxuT5UpI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85B722CA1F;
	Thu, 16 Jan 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043797; cv=none; b=WoG/ncElZHoKsxSLMkjSAckTFViyMZ00m7mIGPg/GyYYpcHSPVWhU/GpDgwWzl4X8fvgCgKbcYZtd137xhrCeh2/T4h1Yn+SUoMRfie+e6Uacg0rCMu4wTYW+yNTzMEUQ8UOaPMwYh4pCpOCGIIdThm634q8+jtk/ST7KPZ8ivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043797; c=relaxed/simple;
	bh=FqbKc2fY/kv4BYvAVtzqn0MGRJpWCRDnHMTimy8za7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dV35kGF0/j2B++i5E6GJRcv/O4/vFjfOfmSMu7zRjL/x6IjSjCIZWQiM7v/BB7PT1/E3U6IUYzLF4uEtJ18oLJTqAJj1l9kSSjzn2xvFM/25SpVE4bBxlgIKVCyzW06uDjkF5iUu4Xu9DVn353xSYYK7yMg2B1wknJ2sEfmIl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxuT5UpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11286C4CED6;
	Thu, 16 Jan 2025 16:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737043797;
	bh=FqbKc2fY/kv4BYvAVtzqn0MGRJpWCRDnHMTimy8za7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sxuT5UpIvmPd54H7pV1pDlE+i24u9gdhhGNalpaGB0IoY1cEO9YDsNhnTbt+cCPE9
	 +UZZmlWaxQI64Fz5wvDD4of2tBGjYNcCw+oBvumOxHz71EomCdOsbs/x1QwDoL1k4g
	 v/R9cqv9TrvGJPHBrMgv617wC/T28H5UVk+5cw2hfrMKnR6Ho6mc4Ky4kiUe5ej3cr
	 pIC5dPOO75LkWD8x1oiueuZO46WJNr1MZeSLqv4g9QXbWkV4C5dinK0YYdSq6tzDsC
	 JE9GJtBXCLTYMQcWk0o8KY+/OLWv+mw99t8V44E8ZtF1V3qxeN7rctOr5xkaP9pBK9
	 PP6bBRCpJ0WvA==
Message-ID: <95f258b2-52f5-4a80-a670-b9a182caec7c@kernel.org>
Date: Thu, 16 Jan 2025 17:09:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/8] page_pool: fix IOMMU crash when driver
 has already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-4-linyunsheng@huawei.com>
 <921c827c-41b7-40af-8c01-c21adbe8f41f@kernel.org>
 <2b5a58f3-d67a-4bf7-921a-033326958ac6@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <2b5a58f3-d67a-4bf7-921a-033326958ac6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 16/01/2025 13.52, Yunsheng Lin wrote:
> On 2025/1/16 0:29, Jesper Dangaard Brouer wrote:
>>
>>
>> On 10/01/2025 14.06, Yunsheng Lin wrote:
>> [...]
>>> In order not to call DMA APIs to do DMA unmmapping after driver
>>> has already unbound and stall the unloading of the networking
>>> driver, use some pre-allocated item blocks to record inflight
>>> pages including the ones which are handed over to network stack,
>>> so the page_pool can do the DMA unmmapping for those pages when
>>> page_pool_destroy() is called. As the pre-allocated item blocks
>>> need to be large enough to avoid performance degradation, add a
>>> 'item_fast_empty' stat to indicate the unavailability of the
>>> pre-allocated item blocks.
>>>
>>
> 
> ...
> 
>>> +
>>> +static __always_inline void __page_pool_release_page_dma(struct page_pool *pool,
>>> +                             netmem_ref netmem,
>>> +                             bool destroyed)
>>> +{
>>> +    struct page_pool_item *item;
>>> +    dma_addr_t dma;
>>> +
>>> +    if (!pool->dma_map)
>>> +        /* Always account for inflight pages, even if we didn't
>>> +         * map them
>>> +         */
>>> +        return;
>>> +
>>> +    dma = page_pool_get_dma_addr_netmem(netmem);
>>> +    item = netmem_get_pp_item(netmem);
>>> +
>>> +    /* dma unmapping is always needed when page_pool_destory() is not called
>>> +     * yet.
>>> +     */
>>> +    DEBUG_NET_WARN_ON_ONCE(!destroyed && !page_pool_item_is_mapped(item));
>>> +    if (unlikely(destroyed && !page_pool_item_is_mapped(item)))
>>> +        return;
>>> +
>>> +    /* When page is unmapped, it cannot be returned to our pool */
>>> +    dma_unmap_page_attrs(pool->p.dev, dma,
>>> +                 PAGE_SIZE << pool->p.order, pool->p.dma_dir,
>>> +                 DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
>>> +    page_pool_set_dma_addr_netmem(netmem, 0);
>>> +    page_pool_item_clear_mapped(item);
>>> +}
>>> +
>>
>> I have a hard time reading/reviewing/maintaining below code, without
>> some design description.  This code needs more comments on what is the
>> *intend* and design it's trying to achieve.
>>
>>  From patch description the only hint I have is:
>>   "use some pre-allocated item blocks to record inflight pages"
>>
>> E.g. Why is it needed/smart to hijack the page->pp pointer?
> 
> Mainly because there is no space available for keeping tracking of inflight
> pages, using page->pp can only find the page_pool owning the page, but page_pool
> is not able to keep track of the inflight page when the page is handled by
> networking stack.
> 
> By using page_pool_item as below, the state is used to tell if a specific
> item is being used/dma mapped or not by scanning all the item blocks in
> pool->item_blocks. If a specific item is used by a page, then 'pp_netmem'
> will point to that page so that dma unmapping can be done for that page
> when page_pool_destroy() is called, otherwise free items sit in the
> pool->hold_items or pool->release_items by using 'lentry':
> 
> struct page_pool_item {
> 	unsigned long state;
> 	
> 	union {
> 		netmem_ref pp_netmem;
> 		struct llist_node lentry;
> 	};
> };

pahole  -C page_pool_item vmlinux
struct page_pool_item {
	/* An 'encoded_next' is a pointer to next item, lower 2 bits is used to
	 * indicate the state of current item.
	 */	
	long unsigned int          encoded_next;     /*     0     8 */
	union {
		netmem_ref         pp_netmem;        /*     8     8 */
		struct llist_node  lentry;           /*     8     8 */
	};                                           /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* last cacheline: 16 bytes */
};


> When a page is added to the page_pool, a item is deleted from pool->hold_items
> or pool->release_items and set the 'pp_netmem' pointing to that page and set
> 'state' accordingly in order to keep track of that page.
> 
> When a page is deleted from the page_pool, it is able to tell which page_pool
> this page belong to by using the below function, and after clearing the 'state',
> the item is added back to pool->release_items so that the item is reused for new
> pages.
> 

To understand below, I'm listing struct page_pool_item_block for other
reviewers:

pahole  -C page_pool_item_block vmlinux
struct page_pool_item_block {
	struct page_pool *         pp;               /*     0     8 */
	struct list_head           list;             /*     8    16 */
	unsigned int               flags;            /*    24     4 */
	refcount_t                 ref;              /*    28     4 */
	struct page_pool_item      items[];          /*    32     0 */

	/* size: 32, cachelines: 1, members: 5 */
	/* last cacheline: 32 bytes */
};

> static inline struct page_pool_item_block *
> page_pool_item_to_block(struct page_pool_item *item)
> {
> 	return (struct page_pool_item_block *)((unsigned long)item & PAGE_MASK);

This trick requires some comments explaining what is going on!
Please correct me if I'm wrong: Here you a masking off the lower bits of
the pointer to page_pool_item *item, as you know that a struct
page_pool_item_block is stored in the top of a struct page.  This trick
is like a "container_of" for going from page_pool_item to
page_pool_item_block, right?

I do notice that you have a comment above struct page_pool_item_block
(that says "item_block is always PAGE_SIZE"), which is nice, but to be
more explicit/clear:
  I want a big comment block (placed above the main code here) that
explains the design and intention behind this newly invented
"item-block" scheme, like e.g. the connection between
page_pool_item_block and page_pool_item. Like the advantage/trick that
allows page->pp pointer to be an "item" and be mapped back to a "block"
to find the page_pool object it belongs to.  Don't write *what* the code
does, but write about the intended purpose and design reasons behind the
code.


> }
> 
>   static inline struct page_pool *page_pool_get_pp(struct page *page)
>   {
>        return page_pool_item_to_block(page->pp_item)->pp;
>   }
> 
> 
>>
>>> +static void __page_pool_item_init(struct page_pool *pool, struct page *page)
>>> +{
>>
>> Function name is confusing.  First I though this was init'ing a single
>> item, but looking at the code it is iterating over ITEMS_PER_PAGE.
>>
>> Maybe it should be called page_pool_item_block_init ?
> 
> The __page_pool_item_init() is added to make the below
> page_pool_item_init() function more readable or maintainable, changing
> it to page_pool_item_block_init doesn't seems consistent?

You (of-cause) also have to rename the other function, I though that was
implicitly understood.

BUT does my suggested rename make sense?  What I'm seeing is that all
the *items* in the "block" is getting inited. But we are also setting up
the "block" (e.g.  "block->pp=pool").

>>
>>> +    struct page_pool_item_block *block = page_address(page);
>>> +    struct page_pool_item *items = block->items;
>>> +    unsigned int i;
>>> +
>>> +    list_add(&block->list, &pool->item_blocks);
>>> +    block->pp = pool;
>>> +
>>> +    for (i = 0; i < ITEMS_PER_PAGE; i++) {
>>> +        page_pool_item_init_state(&items[i]);
>>> +        __llist_add(&items[i].lentry, &pool->hold_items);
>>> +    }
>>> +}
>>> +
>>> +static int page_pool_item_init(struct page_pool *pool)
>>> +{
>>> +#define PAGE_POOL_MIN_INFLIGHT_ITEMS        512
>>> +    struct page_pool_item_block *block;
>>> +    int item_cnt;
>>> +
>>> +    INIT_LIST_HEAD(&pool->item_blocks);
>>> +    init_llist_head(&pool->hold_items);
>>> +    init_llist_head(&pool->release_items);
>>> +
>>> +    item_cnt = pool->p.pool_size * 2 + PP_ALLOC_CACHE_SIZE +
>>> +        PAGE_POOL_MIN_INFLIGHT_ITEMS;
>>> +    while (item_cnt > 0) {
>>> +        struct page *page;
>>> +
>>> +        page = alloc_pages_node(pool->p.nid, GFP_KERNEL, 0);
>>> +        if (!page)
>>> +            goto err;
>>> +
>>> +        __page_pool_item_init(pool, page);
>>> +        item_cnt -= ITEMS_PER_PAGE;
>>> +    }
>>> +
>>> +    return 0;
>>> +err:
>>> +    list_for_each_entry(block, &pool->item_blocks, list)
>>> +        put_page(virt_to_page(block));
> 
> This one also have used-after-free problem as the page_pool_item_uninit
> in the previous version.
> 
>>> +
>>> +    return -ENOMEM;
>>> +}
>>> +
> 

