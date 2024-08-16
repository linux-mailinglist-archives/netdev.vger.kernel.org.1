Return-Path: <netdev+bounces-119185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ECB954866
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7711C203B8
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D3119FA91;
	Fri, 16 Aug 2024 11:58:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091215B12C;
	Fri, 16 Aug 2024 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809498; cv=none; b=NHG2AGJoZU/euUIOVyRW6UpsfwCSecdImdpC/mRcILxyKrAh/lQ4ZU0KrU9lR7fVNw3C/rIrGIiI8oqA+6PoXQNeT+w4jS0NAab8hd4Nan1tXsIQxdz2nSDc8ynGZAr9Mv6luP1nUFYz71ZJYFCn9XVtf69Tv+Piji+lG4s36do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809498; c=relaxed/simple;
	bh=9naL2R4gWIIu1gcPGYAMnaQNDml2CkZCg7ht5GhFC+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QhcmuTk4LyJMbv8xMMb6OOPiA6p2zuzyRXMJHKtV2+pEctNNbwlP9W2bvcPvsfn5sjo45IpeZcR5VEx64Ocfu3TYVFpN0HOFHM2BaUxJdDKzAWH7tnt8w09k/DsQdBAd2ryg/D9ItRjlsB7DaUcJOgWCOhQZ2CKNO8m8HaA5YIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WlgVF37chzcdXH;
	Fri, 16 Aug 2024 19:57:57 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A002B1800A4;
	Fri, 16 Aug 2024 19:58:14 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Aug 2024 19:58:14 +0800
Message-ID: <4741c680-2959-489d-a774-005dd9c27697@huawei.com>
Date: Fri, 16 Aug 2024 19:58:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 08/14] mm: page_frag: some minor refactoring
 before adding new API
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-9-linyunsheng@huawei.com>
 <7d16ba784eb564f9d556f532d670b9bc4698d913.camel@gmail.com>
 <82cc55f0-35e9-4e54-8316-00312389de3f@huawei.com>
 <CAKgT0Ud6EnT0ggwmVUEubX9TPkgGb9+5TTWK-_XnTBbqaec8Gw@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Ud6EnT0ggwmVUEubX9TPkgGb9+5TTWK-_XnTBbqaec8Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/15 23:09, Alexander Duyck wrote:
> On Wed, Aug 14, 2024 at 8:04 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/8/15 1:54, Alexander H Duyck wrote:
>>> On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
>>>> Refactor common codes from __page_frag_alloc_va_align()
>>>> to __page_frag_cache_reload(), so that the new API can
>>>> make use of them.
>>>>
>>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>> ---
>>>>  include/linux/page_frag_cache.h |   2 +-
>>>>  mm/page_frag_cache.c            | 138 ++++++++++++++++++--------------
>>>>  2 files changed, 81 insertions(+), 59 deletions(-)
>>>>
>>>> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
>>>> index 4ce924eaf1b1..0abffdd10a1c 100644
>>>> --- a/include/linux/page_frag_cache.h
>>>> +++ b/include/linux/page_frag_cache.h
>>>> @@ -52,7 +52,7 @@ static inline void *encoded_page_address(unsigned long encoded_va)
>>>>
>>>>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>>>>  {
>>>> -    nc->encoded_va = 0;
>>>> +    memset(nc, 0, sizeof(*nc));
>>>>  }
>>>>
>>>
>>> Still not a fan of this. Just setting encoded_va to 0 should be enough
>>> as the other fields will automatically be overwritten when the new page
>>> is allocated.
>>>
>>> Relying on memset is problematic at best since you then introduce the
>>> potential for issues where remaining somehow gets corrupted but
>>> encoded_va/page is 0. I would rather have both of these being checked
>>> as a part of allocation than just just assuming it is valid if
>>> remaining is set.
>>
>> Does adding something like VM_BUG_ON(!nc->encoded_va && nc->remaining) to
>> catch the above problem address your above concern?
> 
> Not really. I would prefer to just retain the existing behavior.
As my understanding, it is a implementation detail that API caller does
not need to care about if the API is used correctly. If not, we have bigger
problem than above.

If there is a error in that implementation, it would be good to point it
out. And there is already a comment explaining that implementation detail
in this patch, doesn't adding a explicit VM_BUG_ON() make it more obvious.

> 
>>>
>>> I would prefer to keep the check for a non-0 encoded_page value and
>>> then check remaining rather than just rely on remaining as it creates a
>>> single point of failure. With that we can safely tear away a page and
>>> the next caller to try to allocate will populated a new page and the
>>> associated fields.
>>
>> As mentioned before, the memset() is used mainly because of:
>> 1. avoid a checking in the fast path.
>> 2. avoid duplicating the checking pattern you mentioned above for the
>>    new API.
> 
> I'm not a fan of the new code flow after getting rid of the checking
> in the fast path. The code is becoming a tangled mess of spaghetti

I am not sure if you get the point that getting rid of nc->encoded_va
checking in the fast path is the reason we are able able to refactor
common codes into __page_frag_cache_reload(), so that both the old API
and new APIs can reuse the common codes.

> code in my opinion. Arguably the patches don't help as you are taking
> huge steps in many of these patches and it is making it hard to read.
> In addition the code becomes more obfuscated with each patch which is
> one of the reasons why I would have preferred to see this set broken
> into a couple sets so we can give it some time for any of the kinks to
> get worked out.

If there is no new APIs added, I guess I am agreed with your above
argument.
With the new API for new use case, the refactoring in this patch make
code more reusable and maintainable, that is why I would have preferred
not to break this patchset into more patchsets as it is already hard to
argue the reason behind the refactoring.

> 
>>>
>>>>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
>>>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>>>> index 2544b292375a..4e6b1c4684f0 100644
>>>> --- a/mm/page_frag_cache.c
>>>> +++ b/mm/page_frag_cache.c
>>>> @@ -19,8 +19,27 @@
>>>>  #include <linux/page_frag_cache.h>
>>>>  #include "internal.h"
>>>>
>>
>> ...
>>
>>>> +
>>>> +/* Reload cache by reusing the old cache if it is possible, or
>>>> + * refilling from the page allocator.
>>>> + */
>>>> +static bool __page_frag_cache_reload(struct page_frag_cache *nc,
>>>> +                                 gfp_t gfp_mask)
>>>> +{
>>>> +    if (likely(nc->encoded_va)) {
>>>> +            if (__page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias))
>>>> +                    goto out;
>>>> +    }
>>>> +
>>>> +    if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
>>>> +            return false;
>>>> +
>>>> +out:
>>>> +    /* reset page count bias and remaining to start of new frag */
>>>> +    nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>>> +    nc->remaining = page_frag_cache_page_size(nc->encoded_va);
>>>
>>> One thought I am having is that it might be better to have the
>>> pagecnt_bias get set at the same time as the page_ref_add or the
>>> set_page_count call. In addition setting the remaining value at the
>>> same time probably would make sense as in the refill case you can make
>>> use of the "order" value directly instead of having to write/read it
>>> out of the encoded va/page.
>>
>> Probably, there is always tradeoff to make regarding avoid code
>> duplication and avoid reading the order, I am not sure it matters
>> for both for case, I would rather keep the above pattern if there
>> is not obvious benefit for the other pattern.
> 
> Part of it is more about keeping the functions contained to generating
> self contained objects. I am not a fan of us splitting up the page
> init into a few sections as it makes it much easier to mess up a page
> by changing one spot and overlooking the fact that an additional page
> is needed somewhere else.

To be honest, I am not so obsessed with where are pagecnt_bias and
remaining set.
I am obsessed with whether the __page_frag_cache_reload() is needed.
Let's be more specific about your suggestion here: are you suggesting to
remove __page_frag_cache_reload()?
If yes, are you really expecting both old and new API duplicating the
below checking pattern? Why?

if (likely(nc->encoded_va)) {
	if (__page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias))
		...
}

if (unlikely(remaining < fragsz)) {
	page = __page_frag_cache_refill(nc, gfp_mask);
	....
}

If no, doesn't it make sense to call __page_frag_cache_reload() for both
old and new API?

> 
>>>
>>> With that we could simplify this function and get something closer to
>>> what we had for the original alloc_va_align code.
>>>
>>>> +    return true;
>>>>  }
>>>>
>>>>  void page_frag_cache_drain(struct page_frag_cache *nc)
>>>> @@ -55,7 +100,7 @@ void page_frag_cache_drain(struct page_frag_cache *nc)
>>>>
>>>>      __page_frag_cache_drain(virt_to_head_page((void *)nc->encoded_va),
>>>>                              nc->pagecnt_bias);
>>>> -    nc->encoded_va = 0;
>>>> +    memset(nc, 0, sizeof(*nc));
>>>>  }
>>>>  EXPORT_SYMBOL(page_frag_cache_drain);
>>>>
>>>> @@ -73,67 +118,44 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>>>>                               unsigned int align_mask)
>>>>  {
>>>>      unsigned long encoded_va = nc->encoded_va;
>>>> -    unsigned int size, remaining;
>>>> -    struct page *page;
>>>> -
>>>> -    if (unlikely(!encoded_va)) {
>>>
>>> We should still be checking this before we even touch remaining.
>>> Otherwise we greatly increase the risk of providing a bad virtual
>>> address and have greatly decreased the likelihood of us catching
>>> potential errors gracefully.

I would argue that by duplicating the above checking for both the old
and new API will make the code less maintainable, for example, when
fixing bug or making changing to the duplicated checking, it is more
likely miss to change some of them if there are duplicated checking
codes.

>>>
>>>> -refill:
>>>> -            page = __page_frag_cache_refill(nc, gfp_mask);
>>>> -            if (!page)
>>>> -                    return NULL;
>>>> -
>>>> -            encoded_va = nc->encoded_va;
>>>> -            size = page_frag_cache_page_size(encoded_va);
>>>> -
>>>> -            /* Even if we own the page, we do not use atomic_set().
>>>> -             * This would break get_page_unless_zero() users.
>>>> -             */
>>>> -            page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>>>> -
>>>> -            /* reset page count bias and remaining to start of new frag */
>>>> -            nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>>> -            nc->remaining = size;
>>>
>>> With my suggested change above you could essentially just drop the
>>> block starting from the comment and this function wouldn't need to
>>> change as much as it is.
>>
>> It seems you are still suggesting that new API also duplicates the old
>> checking pattern in __page_frag_alloc_va_align()?
>>
>> I would rather avoid the above if something like VM_BUG_ON() can address
>> your above concern.
> 
> Yes, that is what I am suggesting. It makes the code much less prone
> to any sort of possible races as resetting encoded_va would make it so
> that reads for all the other fields would be skipped versus having to
> use a memset which differs in implementation depending on the
> architecture.

It would good to be more specific about what is the race here? if it does
exist, we can fix it.

And it would be good to have more specific suggestion and argument too,
othewise it just you arguing for preserving old behavior to make
the code much less prone to any sort of possible races, and me arguing
for making the old code more reusable and maintainable for the new API.

