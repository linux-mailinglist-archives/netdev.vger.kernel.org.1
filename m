Return-Path: <netdev+bounces-159250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E1FA14ED9
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C15D3A79EC
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA811FE46C;
	Fri, 17 Jan 2025 11:56:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165B01FC7F4;
	Fri, 17 Jan 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737115012; cv=none; b=I6bJeg78cg9EETX+c7wCJI1HroRGpJZiI4gh5Mgir/aq4q14N9e2WFnf7VCUjB47CYY5Bg7LK/k3sxx2f8Kx78TUzE4Qdaf8rVdN+WFQd3C8riTpmA32aztVQ+XQpzPg2q8Eid7Vw0s2e14xuV4RgDlN9sB03liky0J1dfGd4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737115012; c=relaxed/simple;
	bh=OiYBgnz3IGiJXe7D4Bb/Hd/+rJTTtMQ0L6UcAC8oT3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uu7/Y0cGxH4oEoZxeUDor5azuKXM43X5oIl4QQKoQCFNsGVJr8FzVUEygtZKa7BP8cHL6xpiRPY33PJwaS4PJSrYDySe20ETnQJY7+J7Ze/F7F3xpoKjPbqW7WzPaB9hl1IQnPXMc9Zd+TgZPV0SwKNcq62ct0BtbsWEu8cFYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YZJ7117hBz22l21;
	Fri, 17 Jan 2025 19:54:21 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F21F11400CB;
	Fri, 17 Jan 2025 19:56:45 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jan 2025 19:56:43 +0800
Message-ID: <92bb3a19-a619-4bf7-9ef5-b9eb12a57983@huawei.com>
Date: Fri, 17 Jan 2025 19:56:43 +0800
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
 <2b5a58f3-d67a-4bf7-921a-033326958ac6@huawei.com>
 <95f258b2-52f5-4a80-a670-b9a182caec7c@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <95f258b2-52f5-4a80-a670-b9a182caec7c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/1/17 0:09, Jesper Dangaard Brouer wrote:

...

>> Mainly because there is no space available for keeping tracking of inflight
>> pages, using page->pp can only find the page_pool owning the page, but page_pool
>> is not able to keep track of the inflight page when the page is handled by
>> networking stack.
>>
>> By using page_pool_item as below, the state is used to tell if a specific
>> item is being used/dma mapped or not by scanning all the item blocks in
>> pool->item_blocks. If a specific item is used by a page, then 'pp_netmem'
>> will point to that page so that dma unmapping can be done for that page
>> when page_pool_destroy() is called, otherwise free items sit in the
>> pool->hold_items or pool->release_items by using 'lentry':
>>
>> struct page_pool_item {
>>     unsigned long state;
>>     
>>     union {
>>         netmem_ref pp_netmem;
>>         struct llist_node lentry;
>>     };
>> };
> 
> pahole  -C page_pool_item vmlinux
> struct page_pool_item {
>     /* An 'encoded_next' is a pointer to next item, lower 2 bits is used to
>      * indicate the state of current item.
>      */   
>     long unsigned int          encoded_next;     /*     0     8 */
>     union {
>         netmem_ref         pp_netmem;        /*     8     8 */
>         struct llist_node  lentry;           /*     8     8 */
>     };                                           /*     8     8 */
> 
>     /* size: 16, cachelines: 1, members: 2 */
>     /* last cacheline: 16 bytes */
> };
> 
> 
>> When a page is added to the page_pool, a item is deleted from pool->hold_items
>> or pool->release_items and set the 'pp_netmem' pointing to that page and set
>> 'state' accordingly in order to keep track of that page.
>>
>> When a page is deleted from the page_pool, it is able to tell which page_pool
>> this page belong to by using the below function, and after clearing the 'state',
>> the item is added back to pool->release_items so that the item is reused for new
>> pages.
>>
> 
> To understand below, I'm listing struct page_pool_item_block for other
> reviewers:
> 
> pahole  -C page_pool_item_block vmlinux
> struct page_pool_item_block {
>     struct page_pool *         pp;               /*     0     8 */
>     struct list_head           list;             /*     8    16 */
>     unsigned int               flags;            /*    24     4 */
>     refcount_t                 ref;              /*    28     4 */
>     struct page_pool_item      items[];          /*    32     0 */
> 
>     /* size: 32, cachelines: 1, members: 5 */
>     /* last cacheline: 32 bytes */
> };
> 
>> static inline struct page_pool_item_block *
>> page_pool_item_to_block(struct page_pool_item *item)
>> {
>>     return (struct page_pool_item_block *)((unsigned long)item & PAGE_MASK);
> 
> This trick requires some comments explaining what is going on!
> Please correct me if I'm wrong: Here you a masking off the lower bits of
> the pointer to page_pool_item *item, as you know that a struct
> page_pool_item_block is stored in the top of a struct page.  This trick
> is like a "container_of" for going from page_pool_item to
> page_pool_item_block, right?

Yes, you are right.

> 
> I do notice that you have a comment above struct page_pool_item_block
> (that says "item_block is always PAGE_SIZE"), which is nice, but to be
> more explicit/clear:
>  I want a big comment block (placed above the main code here) that
> explains the design and intention behind this newly invented
> "item-block" scheme, like e.g. the connection between
> page_pool_item_block and page_pool_item. Like the advantage/trick that
> allows page->pp pointer to be an "item" and be mapped back to a "block"
> to find the page_pool object it belongs to.  Don't write *what* the code
> does, but write about the intended purpose and design reasons behind the
> code.

The comment for page_pool_item_block is below, it seems I also wrote about
intended purpose and design reasons here.

/* The size of item_block is always PAGE_SIZE, so that the address of item_block
 * for a specific item can be calculated using 'item & PAGE_MASK'
 */

Anyway, If putting something like above for page_pool_item_to_block() does
make it clearer, will add some comment for page_pool_item_to_block() too.

> 
> 
>> }
>>
>>   static inline struct page_pool *page_pool_get_pp(struct page *page)
>>   {
>>        return page_pool_item_to_block(page->pp_item)->pp;
>>   }
>>
>>
>>>
>>>> +static void __page_pool_item_init(struct page_pool *pool, struct page *page)
>>>> +{
>>>
>>> Function name is confusing.  First I though this was init'ing a single
>>> item, but looking at the code it is iterating over ITEMS_PER_PAGE.
>>>
>>> Maybe it should be called page_pool_item_block_init ?
>>
>> The __page_pool_item_init() is added to make the below
>> page_pool_item_init() function more readable or maintainable, changing
>> it to page_pool_item_block_init doesn't seems consistent?
> 
> You (of-cause) also have to rename the other function, I though that was
> implicitly understood.
> 
> BUT does my suggested rename make sense?  What I'm seeing is that all
> the *items* in the "block" is getting inited. But we are also setting up
> the "block" (e.g.  "block->pp=pool").

I am not really sure about that, as using the PAGE_SIZE block to hold the
item seems like a implementation detail, which might change in the future,
renaming other function to something like that doesn't seem right to me IMHO.

Also the next patch will add page_pool_item_blk_add() to support unlimited
inflight pages, it seems a better name is needed for that too, perheps rename
page_pool_item_blk_add() to page_pool_dynamic_item_add()?

For __page_pool_item_init(), perhaps just inline it back to page_pool_item_init()
as __page_pool_item_init() is only used by page_pool_item_init(), and both of them
are not really large function.

