Return-Path: <netdev+bounces-114148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0FE941305
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2E71C22F15
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3121A00D7;
	Tue, 30 Jul 2024 13:21:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E51A01BC;
	Tue, 30 Jul 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345660; cv=none; b=GAQLf9J3OS6kFkPT0ntxRXK+x4QKjJZHV6TapHxUud6DT6/+0L3MZ/PA2xQDzo2G4xC3uir7eaXCK2b3/xDkzDJ6+EB4QbPkQHIDG0kaFj1xje2HHWYFjtfu7X5LJUqsipHusicJPHqmpHHnQUGFQp0kFGZD7+Q3Onkwgm3XQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345660; c=relaxed/simple;
	bh=86jGSWIkrbKu/7gkAqtGQWZSRGbwqKx5WmmXkLl8Qkw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=NU4b4RvyQDrzjQjPzbEQJq1D0v67PR9L+FZl9+GTdjaK/1DYn2OOskan8fWCDI+ZmYQc3az9mXHWX4YyaI2L2g5k7lqhqX+m7cYOs70Bii6yWMJnXfq689/fmxQKFjo7M7zn6EFjNOxmyWLWUpjj2fSe8imUKGc3+GnuK74K+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WYG6Y1HPNzncv0;
	Tue, 30 Jul 2024 21:19:49 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 472C7140FAA;
	Tue, 30 Jul 2024 21:20:47 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Jul 2024 21:20:46 +0800
Message-ID: <af06fc13-ae3f-41ca-9723-af1c8d9d051d@huawei.com>
Date: Tue, 30 Jul 2024 21:20:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v11 08/14] mm: page_frag: some minor refactoring before
 adding new API
From: Yunsheng Lin <linyunsheng@huawei.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
 <20240719093338.55117-9-linyunsheng@huawei.com>
 <dbf876b000158aed8380d6ac3a3f6e8dd40ace7b.camel@gmail.com>
 <fdc778be-907a-49bd-bf10-086f45716181@huawei.com>
 <CAKgT0UeQ9gwYo7qttak0UgXC9+kunO2gedm_yjtPiMk4VJp9yQ@mail.gmail.com>
 <5a0e12c1-0e98-426a-ab4d-50de2b09f36f@huawei.com>
Content-Language: en-US
In-Reply-To: <5a0e12c1-0e98-426a-ab4d-50de2b09f36f@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/23 21:19, Yunsheng Lin wrote:

...

>>>>>  static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>>>>                                           gfp_t gfp_mask)
>>>>>  {
>>>>> @@ -26,6 +48,14 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>>>>      struct page *page = NULL;
>>>>>      gfp_t gfp = gfp_mask;
>>>>>
>>>>> +    if (likely(nc->encoded_va)) {
>>>>> +            page = __page_frag_cache_recharge(nc);
>>>>> +            if (page) {
>>>>> +                    order = encoded_page_order(nc->encoded_va);
>>>>> +                    goto out;
>>>>> +            }
>>>>> +    }
>>>>> +
>>>>
>>>> This code has no business here. This is refill, you just dropped
>>>> recharge in here which will make a complete mess of the ordering and be
>>>> confusing to say the least.
>>>>
>>>> The expectation was that if we are calling this function it is going to
>>>> overwrite the virtual address to NULL on failure so we discard the old
>>>> page if there is one present. This changes that behaviour. What you
>>>> effectively did is made __page_frag_cache_refill into the recharge
>>>> function.
>>>
>>> The idea is to reuse the below for both __page_frag_cache_refill() and
>>> __page_frag_cache_recharge(), which seems to be about maintainability
>>> to not having duplicated code. If there is a better idea to avoid that
>>> duplicated code while keeping the old behaviour, I am happy to change
>>> it.
>>>
>>>         /* reset page count bias and remaining to start of new frag */
>>>         nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>>         nc->remaining = PAGE_SIZE << order;
>>>
>>
>> The only piece that is really reused here is the pagecnt_bias
>> assignment. What is obfuscated away is that the order is gotten
>> through one of two paths. Really order isn't order here it is size.
>> Which should have been fetched already. What you end up doing with
>> this change is duplicating a bunch of code throughout the function.
>> You end up having to fetch size multiple times multiple ways. here you
>> are generating it with order. Then you have to turn around and get it
>> again at the start of the function, and again after calling this
>> function in order to pull it back out.
> 
> I am assuming you would like to reserve old behavior as below?
> 
> 	if(!encoded_va) {
> refill:
> 		__page_frag_cache_refill()
> 	}
> 
> 
> 	if(remaining < fragsz) {
> 		if(!__page_frag_cache_recharge())
> 			goto refill;
> 	}
> 
> As we are adding new APIs, are we expecting new APIs also duplicate
> the above pattern?
> 
>>

How about something like below? __page_frag_cache_refill() and
__page_frag_cache_reuse() does what their function name suggests
as much as possible, __page_frag_cache_reload() is added to avoid
new APIs duplicating similar pattern as much as possible, also
avoid fetching size multiple times multiple ways as much as possible.

static struct page *__page_frag_cache_reuse(unsigned long encoded_va,
                                            unsigned int pagecnt_bias)
{
        struct page *page;

        page = virt_to_page((void *)encoded_va);
        if (!page_ref_sub_and_test(page, pagecnt_bias))
                return NULL;

        if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
                VM_BUG_ON(compound_order(page) !=
                          encoded_page_order(encoded_va));
                free_unref_page(page, encoded_page_order(encoded_va));
                return NULL;
        }

        /* OK, page count is 0, we can safely set it */
        set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
        return page;
}

static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
                                             gfp_t gfp_mask)
{
        unsigned long order = PAGE_FRAG_CACHE_MAX_ORDER;
        struct page *page = NULL;
        gfp_t gfp = gfp_mask;

#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
        gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
                   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
        page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
                                PAGE_FRAG_CACHE_MAX_ORDER);
#endif
        if (unlikely(!page)) {
                page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
                if (unlikely(!page)) {
                        memset(nc, 0, sizeof(*nc));
                        return NULL;
                }

                order = 0;
        }

        nc->encoded_va = encode_aligned_va(page_address(page), order,
                                           page_is_pfmemalloc(page));

        /* Even if we own the page, we do not use atomic_set().
         * This would break get_page_unless_zero() users.
         */
        page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);

        return page;
}

static struct page *__page_frag_cache_reload(struct page_frag_cache *nc,
                                             gfp_t gfp_mask)
{
        struct page *page;

        if (likely(nc->encoded_va)) {
                page = __page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias);
                if (page)
                        goto out;
        }

        page = __page_frag_cache_refill(nc, gfp_mask);
        if (unlikely(!page))
                return NULL;

out:
        nc->remaining = page_frag_cache_page_size(nc->encoded_va);
        nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
        return page;
}

void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
                                 unsigned int fragsz, gfp_t gfp_mask,
                                 unsigned int align_mask)
{
        unsigned long encoded_va = nc->encoded_va;
        unsigned int remaining;

        remaining = nc->remaining & align_mask;
        if (unlikely(remaining < fragsz)) {
                if (unlikely(fragsz > PAGE_SIZE)) {
                        /*
                         * The caller is trying to allocate a fragment
                         * with fragsz > PAGE_SIZE but the cache isn't big
                         * enough to satisfy the request, this may
                         * happen in low memory conditions.
                         * We don't release the cache page because
                         * it could make memory pressure worse
                         * so we simply return NULL here.
                         */
                        return NULL;
                }

                if (unlikely(!__page_frag_cache_reload(nc, gfp_mask)))
                        return NULL;

                nc->pagecnt_bias--;
                nc->remaining -= fragsz;

                return encoded_page_address(nc->encoded_va);
        }

        nc->pagecnt_bias--;
        nc->remaining = remaining - fragsz;

        return encoded_page_address(encoded_va) +
                (page_frag_cache_page_size(encoded_va) - remaining);
}




