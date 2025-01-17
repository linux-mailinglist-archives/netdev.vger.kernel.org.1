Return-Path: <netdev+bounces-159374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19156A1550F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399871697B7
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A261C19F41C;
	Fri, 17 Jan 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb6YIGt0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5619DF4B;
	Fri, 17 Jan 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132996; cv=none; b=HHX9tiO82HPnM0WQTt6QGj4MwlDns2R3QfOpFb8AjNGhY9gKB3db1tBrMus0m7wV6dD9ewC/iDKjZU5+uSfELEIwHsKHrKRFD3qjE1Ig8FY4ZJjEiFTPSrhZBM7wkpBRLFMnyxDYPztqIwznjYSLxJSEXozRPaiLE0b0llsnfus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132996; c=relaxed/simple;
	bh=zcK8WB4ZaeZlWpWWyW2l5kp3TFVT9q3fShc6jxCxxIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAG2mlYfFzHTbdPD3I8Q7v8asoQui4QUJlTCtUFgfnMCvLlCoUy73VmtvRLzUr3UY0HzMPxs2bGHdZQTiaWo0uyTi1OrN17nqoxUyLkARpmCritIWO4hLPY0M8mUqIPmMl2kcCb1a2I1I8P3dsrziGOWtSFXbkp0szKXa6Lp9sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb6YIGt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93E5C4CEDD;
	Fri, 17 Jan 2025 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737132996;
	bh=zcK8WB4ZaeZlWpWWyW2l5kp3TFVT9q3fShc6jxCxxIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bb6YIGt0sTIzbYBBsMO6q1tiNahm67G18z2l6sNOqX2eN+qeVvyCapie3vOm3YNkc
	 NSPdxJAZyk5vpWT8H8OfMoNtSDf6aa9OV/EUUiONZtRngj21qQDt8EiK7ffyJYnRts
	 ArS8w77jxFubn3ytE4/vD7zSe/IvGJXpOp4Fm8O6N1S/oarFpQxX9aW4oPlB+kS1Lu
	 T2IZlwshC9xtUyQPamQxYQoraNqsDBvQDLZyrATTmn1z5XG3QLla27QAb8TbuA3IjD
	 9nSIXx80DDPulxnKHoBBgGp2nO3oY78eTlKe2BDnpB5egabBnxjby1utKSUTHgQ0g5
	 deI9gnMIYNj7w==
Message-ID: <eb2381d2-34a4-4915-b0b5-b07cc81646d3@kernel.org>
Date: Fri, 17 Jan 2025 17:56:29 +0100
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
 <95f258b2-52f5-4a80-a670-b9a182caec7c@kernel.org>
 <92bb3a19-a619-4bf7-9ef5-b9eb12a57983@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <92bb3a19-a619-4bf7-9ef5-b9eb12a57983@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/01/2025 12.56, Yunsheng Lin wrote:
> On 2025/1/17 0:09, Jesper Dangaard Brouer wrote:
> 
> ...
> 
>>> Mainly because there is no space available for keeping tracking of inflight
>>> pages, using page->pp can only find the page_pool owning the page, but page_pool
>>> is not able to keep track of the inflight page when the page is handled by
>>> networking stack.
>>>
>>> By using page_pool_item as below, the state is used to tell if a specific
>>> item is being used/dma mapped or not by scanning all the item blocks in
>>> pool->item_blocks. If a specific item is used by a page, then 'pp_netmem'
>>> will point to that page so that dma unmapping can be done for that page
>>> when page_pool_destroy() is called, otherwise free items sit in the
>>> pool->hold_items or pool->release_items by using 'lentry':
>>>
>>> struct page_pool_item {
>>>      unsigned long state;
>>>      
>>>      union {
>>>          netmem_ref pp_netmem;
>>>          struct llist_node lentry;
>>>      };
>>> };
>>
>> pahole  -C page_pool_item vmlinux
>> struct page_pool_item {
>>      /* An 'encoded_next' is a pointer to next item, lower 2 bits is used to
>>       * indicate the state of current item.
>>       */
>>      long unsigned int          encoded_next;     /*     0     8 */
>>      union {
>>          netmem_ref         pp_netmem;        /*     8     8 */
>>          struct llist_node  lentry;           /*     8     8 */
>>      };                                           /*     8     8 */
>>
>>      /* size: 16, cachelines: 1, members: 2 */
>>      /* last cacheline: 16 bytes */
>> };
>>
>>
>>> When a page is added to the page_pool, a item is deleted from pool->hold_items
>>> or pool->release_items and set the 'pp_netmem' pointing to that page and set
>>> 'state' accordingly in order to keep track of that page.
>>>
>>> When a page is deleted from the page_pool, it is able to tell which page_pool
>>> this page belong to by using the below function, and after clearing the 'state',
>>> the item is added back to pool->release_items so that the item is reused for new
>>> pages.
>>>
>>
>> To understand below, I'm listing struct page_pool_item_block for other
>> reviewers:
>>
>> pahole  -C page_pool_item_block vmlinux
>> struct page_pool_item_block {
>>      struct page_pool *         pp;               /*     0     8 */
>>      struct list_head           list;             /*     8    16 */
>>      unsigned int               flags;            /*    24     4 */
>>      refcount_t                 ref;              /*    28     4 */
>>      struct page_pool_item      items[];          /*    32     0 */
>>
>>      /* size: 32, cachelines: 1, members: 5 */
>>      /* last cacheline: 32 bytes */
>> };
>>
>>> static inline struct page_pool_item_block *
>>> page_pool_item_to_block(struct page_pool_item *item)
>>> {
>>>      return (struct page_pool_item_block *)((unsigned long)item & PAGE_MASK);
>>
>> This trick requires some comments explaining what is going on!
>> Please correct me if I'm wrong: Here you a masking off the lower bits of
>> the pointer to page_pool_item *item, as you know that a struct
>> page_pool_item_block is stored in the top of a struct page.  This trick
>> is like a "container_of" for going from page_pool_item to
>> page_pool_item_block, right?
> 
> Yes, you are right.
> 
>>
>> I do notice that you have a comment above struct page_pool_item_block
>> (that says "item_block is always PAGE_SIZE"), which is nice, but to be
>> more explicit/clear:
>>   I want a big comment block (placed above the main code here) that
>> explains the design and intention behind this newly invented
>> "item-block" scheme, like e.g. the connection between
>> page_pool_item_block and page_pool_item. Like the advantage/trick that
>> allows page->pp pointer to be an "item" and be mapped back to a "block"
>> to find the page_pool object it belongs to.  Don't write *what* the code
>> does, but write about the intended purpose and design reasons behind the
>> code.
> 
> The comment for page_pool_item_block is below, it seems I also wrote about
> intended purpose and design reasons here.
> 
> /* The size of item_block is always PAGE_SIZE, so that the address of item_block
>   * for a specific item can be calculated using 'item & PAGE_MASK'
>   */
> 
> Anyway, If putting something like above for page_pool_item_to_block() does
> make it clearer, will add some comment for page_pool_item_to_block() too.
> 
>>
>>
>>> }
>>>
>>>    static inline struct page_pool *page_pool_get_pp(struct page *page)
>>>    {
>>>         return page_pool_item_to_block(page->pp_item)->pp;
>>>    }
>>>
>>>
>>>>
>>>>> +static void __page_pool_item_init(struct page_pool *pool, struct page *page)
>>>>> +{
>>>>
>>>> Function name is confusing.  First I though this was init'ing a single
>>>> item, but looking at the code it is iterating over ITEMS_PER_PAGE.
>>>>
>>>> Maybe it should be called page_pool_item_block_init ?
>>>
>>> The __page_pool_item_init() is added to make the below
>>> page_pool_item_init() function more readable or maintainable, changing
>>> it to page_pool_item_block_init doesn't seems consistent?
>>
>> You (of-cause) also have to rename the other function, I though that was
>> implicitly understood.
>>
>> BUT does my suggested rename make sense?  What I'm seeing is that all
>> the *items* in the "block" is getting inited. But we are also setting up
>> the "block" (e.g.  "block->pp=pool").
> 
> I am not really sure about that, as using the PAGE_SIZE block to hold the
> item seems like a implementation detail, which might change in the future,
> renaming other function to something like that doesn't seem right to me IMHO.
> 
> Also the next patch will add page_pool_item_blk_add() to support unlimited
> inflight pages, it seems a better name is needed for that too, perheps rename
> page_pool_item_blk_add() to page_pool_dynamic_item_add()?
> 

Hmmm... not sure about this.
I think I prefer page_pool_item_blk_add() over page_pool_dynamic_item_add().

> For __page_pool_item_init(), perhaps just inline it back to page_pool_item_init()
> as __page_pool_item_init() is only used by page_pool_item_init(), and both of them
> are not really large function.

I like that you had a helper function. So, don't merge 
__page_pool_item_init() into page_pool_item_init() just to avoid naming 
it differently.

Let me be more explicit what I'm asking for:

IMHO you should rename:
  - __page_pool_item_init() to __page_pool_item_block_init()
and rename:
  - page_pool_item_init() to page_pool_item_block_init()

I hope this make it more clear what I'm saying.

--Jesper

