Return-Path: <netdev+bounces-112585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF82693A12E
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36401C2226C
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35371527BE;
	Tue, 23 Jul 2024 13:19:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF3B14E2D0;
	Tue, 23 Jul 2024 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740790; cv=none; b=XvqAmRsth1Y3aQhtcvG7ltqjlWZSd0i4l6Xd/2U4yZ0iZW36efu6YcsclO6rTOFqIimb08znesWb+a1vsZkglU68HBNbjRluOKhC/aEmk+Zct/t5OCiglrKxzUfa6Au3SE3v8q6csJ1XUiMSJEpvbf2nLN428etcJMCkWVKW1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740790; c=relaxed/simple;
	bh=zl6zSPEBXbpkSORWIW46uub+HDKFTK1TCAEyNhxAi1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=orCBp1/flTIHYV+i9clLud3DF9lPY9Xx9eqZ6psf8anvn1BT2OKkEZSxnr1vzTBGy4TykhDmxamiOrmicik6gXmzHcE9rmWpEeXChE8XQgFD+rnE96xG6SPndtbGrYnNeq/+Wy5IDUJ9oUtCDxynyWIPo5XOM1Hjc6Gw/qWRAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WSyLw1wslzQmbK;
	Tue, 23 Jul 2024 21:15:36 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EA3C180102;
	Tue, 23 Jul 2024 21:19:46 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Jul 2024 21:19:46 +0800
Message-ID: <5a0e12c1-0e98-426a-ab4d-50de2b09f36f@huawei.com>
Date: Tue, 23 Jul 2024 21:19:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v11 08/14] mm: page_frag: some minor refactoring before
 adding new API
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
 <20240719093338.55117-9-linyunsheng@huawei.com>
 <dbf876b000158aed8380d6ac3a3f6e8dd40ace7b.camel@gmail.com>
 <fdc778be-907a-49bd-bf10-086f45716181@huawei.com>
 <CAKgT0UeQ9gwYo7qttak0UgXC9+kunO2gedm_yjtPiMk4VJp9yQ@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UeQ9gwYo7qttak0UgXC9+kunO2gedm_yjtPiMk4VJp9yQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/22 23:32, Alexander Duyck wrote:
> On Mon, Jul 22, 2024 at 5:55 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/7/22 7:40, Alexander H Duyck wrote:
>>> On Fri, 2024-07-19 at 17:33 +0800, Yunsheng Lin wrote:
>>>> Refactor common codes from __page_frag_alloc_va_align()
>>>> to __page_frag_cache_refill(), so that the new API can
>>>> make use of them.
>>>>
>>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>> ---
>>>>  include/linux/page_frag_cache.h |  2 +-
>>>>  mm/page_frag_cache.c            | 93 +++++++++++++++++----------------
>>>>  2 files changed, 49 insertions(+), 46 deletions(-)
>>>>
>>>> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
>>>> index 12a16f8e8ad0..5aa45de7a9a5 100644
>>>> --- a/include/linux/page_frag_cache.h
>>>> +++ b/include/linux/page_frag_cache.h
>>>> @@ -50,7 +50,7 @@ static inline void *encoded_page_address(unsigned long encoded_va)
>>>>
>>>>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>>>>  {
>>>> -    nc->encoded_va = 0;
>>>> +    memset(nc, 0, sizeof(*nc));
>>>>  }
>>>>
>>>
>>> I do not like requiring the entire structure to be reset as a part of
>>> init. If encoded_va is 0 then we have reset the page and the flags.
>>> There shouldn't be anything else we need to reset as remaining and bias
>>> will be reset when we reallocate.
>>
>> The argument is about aoviding one checking for fast path by doing the
>> memset in the slow path, which you might already know accroding to your
>> comment in previous version.
>>
>> It is just sometimes hard to understand your preference for maintainability
>> over performance here as sometimes your comment seems to perfer performance
>> over maintainability, like the LEA trick you mentioned and offset count-down
>> before this patchset. It would be good to be more consistent about this,
>> otherwise it is sometimes confusing when doing the refactoring.
> 
> The use of a negative offset is arguably more maintainable in my mind
> rather than being a performance trick. Essentially if you use the
> negative value you can just mask off the upper bits and it is the
> offset in the page. As such it is actually easier for me to read
> versus "remaining" which is an offset from the end of the page.
> Assuming you read the offset in hex anyway.

Reading the above doesn't seems maintainable to me:(

> 
>>>
>>>>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
>>>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>>>> index 7928e5d50711..d9c9cad17af7 100644
>>>> --- a/mm/page_frag_cache.c
>>>> +++ b/mm/page_frag_cache.c
>>>> @@ -19,6 +19,28 @@
>>>>  #include <linux/page_frag_cache.h>
>>>>  #include "internal.h"
>>>>
>>>> +static struct page *__page_frag_cache_recharge(struct page_frag_cache *nc)
>>>> +{
>>>> +    unsigned long encoded_va = nc->encoded_va;
>>>> +    struct page *page;
>>>> +
>>>> +    page = virt_to_page((void *)encoded_va);
>>>> +    if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>>>> +            return NULL;
>>>> +
>>>> +    if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
>>>> +            VM_BUG_ON(compound_order(page) !=
>>>> +                      encoded_page_order(encoded_va));
>>>> +            free_unref_page(page, encoded_page_order(encoded_va));
>>>> +            return NULL;
>>>> +    }
>>>> +
>>>> +    /* OK, page count is 0, we can safely set it */
>>>> +    set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>>>> +
>>>> +    return page;
>>>> +}
>>>> +
>>>>  static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>>>                                           gfp_t gfp_mask)
>>>>  {
>>>> @@ -26,6 +48,14 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>>>      struct page *page = NULL;
>>>>      gfp_t gfp = gfp_mask;
>>>>
>>>> +    if (likely(nc->encoded_va)) {
>>>> +            page = __page_frag_cache_recharge(nc);
>>>> +            if (page) {
>>>> +                    order = encoded_page_order(nc->encoded_va);
>>>> +                    goto out;
>>>> +            }
>>>> +    }
>>>> +
>>>
>>> This code has no business here. This is refill, you just dropped
>>> recharge in here which will make a complete mess of the ordering and be
>>> confusing to say the least.
>>>
>>> The expectation was that if we are calling this function it is going to
>>> overwrite the virtual address to NULL on failure so we discard the old
>>> page if there is one present. This changes that behaviour. What you
>>> effectively did is made __page_frag_cache_refill into the recharge
>>> function.
>>
>> The idea is to reuse the below for both __page_frag_cache_refill() and
>> __page_frag_cache_recharge(), which seems to be about maintainability
>> to not having duplicated code. If there is a better idea to avoid that
>> duplicated code while keeping the old behaviour, I am happy to change
>> it.
>>
>>         /* reset page count bias and remaining to start of new frag */
>>         nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>         nc->remaining = PAGE_SIZE << order;
>>
> 
> The only piece that is really reused here is the pagecnt_bias
> assignment. What is obfuscated away is that the order is gotten
> through one of two paths. Really order isn't order here it is size.
> Which should have been fetched already. What you end up doing with
> this change is duplicating a bunch of code throughout the function.
> You end up having to fetch size multiple times multiple ways. here you
> are generating it with order. Then you have to turn around and get it
> again at the start of the function, and again after calling this
> function in order to pull it back out.

I am assuming you would like to reserve old behavior as below?

	if(!encoded_va) {
refill:
		__page_frag_cache_refill()
	}


	if(remaining < fragsz) {
		if(!__page_frag_cache_recharge())
			goto refill;
	}

As we are adding new APIs, are we expecting new APIs also duplicate
the above pattern?

> 
>>>
>>>>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>>>      gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>>>>                 __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>>>> @@ -35,7 +65,7 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>>>      if (unlikely(!page)) {
>>>>              page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>>>>              if (unlikely(!page)) {
>>>> -                    nc->encoded_va = 0;
>>>> +                    memset(nc, 0, sizeof(*nc));
>>>>                      return NULL;
>>>>              }
>>>>
>>>
>>> The memset will take a few more instructions than the existing code
>>> did. I would prefer to keep this as is if at all possible.
>>
>> It will not take more instructions for arm64 as it has 'stp' instruction for
>> __HAVE_ARCH_MEMSET is set.
>> There is something similar for x64?
> 
> The x64 does not last I knew without getting into the SSE/AVX type
> stuff. This becomes two seperate 8B store instructions.

I can check later when I get hold of a x64 server.
But doesn't it make sense to have one extra 8B store instructions in slow path
to avoid a checking in fast path?

> 
>>>
>>>> @@ -45,6 +75,16 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>>>      nc->encoded_va = encode_aligned_va(page_address(page), order,
>>>>                                         page_is_pfmemalloc(page));
>>>>
>>>> +    /* Even if we own the page, we do not use atomic_set().
>>>> +     * This would break get_page_unless_zero() users.
>>>> +     */
>>>> +    page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>>>> +
>>>> +out:
>>>> +    /* reset page count bias and remaining to start of new frag */
>>>> +    nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>>> +    nc->remaining = PAGE_SIZE << order;
>>>> +
>>>>      return page;
>>>>  }
>>>>
>>>
>>> Why bother returning a page at all? It doesn't seem like you don't use
>>> it anymore. It looks like the use cases you have for it in patch 11/12
>>> all appear to be broken from what I can tell as you are adding page as
>>> a variable when we don't need to be passing internal details to the
>>> callers of the function when just a simple error return code would do.
>>
>> It would be good to be more specific about the 'broken' part here.
> 
> We are passing internals to the caller. Basically this is generally
> frowned upon for many implementations of things as the general idea is
> that the internal page we are using should be a pseudo-private value.

It is implementation detail and it is about avoid calling virt_to_page()
as mentioned below, I am not sure why it is referred as 'broken', it would
be better to provide more doc about why it is bad idea here, as using
'pseudo-private ' wording doesn't seems to justify the 'broken' part here.

> I understand that you have one or two callers that need it for the use
> cases you have in patches 11/12, but it also seems like you are just
> passing it regardless. For example I noticed in a few cases you added
> the page pointer in 12 to handle the return value, but then just used
> it to check for NULL. My thought would be that rather than returning
> the page here you would be better off just returning 0 or an error and
> then doing the virt_to_page translation for all the cases where the
> page is actually needed since you have to go that route for a cached
> page anyway.

Yes, it is about aovid calling virt_to_page() as much as possible.



