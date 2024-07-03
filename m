Return-Path: <netdev+bounces-108849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B082C926068
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F101C22C4A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71C0176255;
	Wed,  3 Jul 2024 12:33:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF6143C6B;
	Wed,  3 Jul 2024 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010014; cv=none; b=e4GutjJqtRiP+77rMwHP7Me5xUn4tVV5bcsyY4iaLwsD3pDcdjUR+x6SQyDx9XzPzDan8HZmq2abjeiUeBzBohEHEdai6Jb7j8C39tF433ksKZPu/zlKfkdy/kP7PiP5sOdb1cOBHkzHz69cPe/ypD8ExSrOnnNh4qe2dG/R9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010014; c=relaxed/simple;
	bh=oJF3ZZFDxds2NZbtSxugjvB5JbDhf1rpoRrsPly2gFc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mN+FStkKZhabrk7ZpwmDHDzjY7hCaItbvAaNR1a7WArjNgMRfomM4Wg8wY89DPNRD0IyJFyqfeWTbzCkrQlBnuyJ3lWEdgN+PuDTBHqiwPFKt8Bgih6fqU07e8hmnVQKySqqcmW93xA16DQrM0qEqjmAIsglE2Y2XR5wf0tEB3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WDfGG3Yv8z1T4tD;
	Wed,  3 Jul 2024 20:28:54 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E58C3180087;
	Wed,  3 Jul 2024 20:33:27 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Jul
 2024 20:33:27 +0800
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space for
 'size' and 'pfmemalloc'
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-7-linyunsheng@huawei.com>
 <12a8b9ddbcb2da8431f77c5ec952ccfb2a77b7ec.camel@gmail.com>
 <808be796-6333-c116-6ecb-95a39f7ad76e@huawei.com>
 <a026c32218cabc7b6dc579ced1306aefd7029b10.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <f4ff5a42-9371-bc54-8523-b11d8511c39a@huawei.com>
Date: Wed, 3 Jul 2024 20:33:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a026c32218cabc7b6dc579ced1306aefd7029b10.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/2 22:55, Alexander H Duyck wrote:

...

> 
>>>
>>>> +#define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)
>>>> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(8)
>>>> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	8
>>>> +
>>>> +static inline struct encoded_va *encode_aligned_va(void *va,
>>>> +						   unsigned int order,
>>>> +						   bool pfmemalloc)
>>>> +{
>>>>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>>> -	__u16 offset;
>>>> -	__u16 size;
>>>> +	return (struct encoded_va *)((unsigned long)va | order |
>>>> +			pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
>>>>  #else
>>>> -	__u32 offset;
>>>> +	return (struct encoded_va *)((unsigned long)va |
>>>> +			pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
>>>> +#endif
>>>> +}
>>>> +
> 
> This is missing any and all protection of the example you cited. If I
> want to pass order as a 32b value I can and I can corrupt the virtual
> address. Same thing with pfmemalloc. Lets only hope you don't hit an
> architecture where a bool is a u8 in size as otherwise that shift is
> going to wipe out the value, and if it is a u32 which is usually the
> case lets hope they stick to the values of 0 and 1.

I explicitly checked that the protection is not really needed due to
performance consideration:
1. For the 'pfmemalloc' part, it does always stick to the values of 0
   and 1 as below:
https://elixir.bootlin.com/linux/v6.10-rc6/source/Documentation/process/coding-style.rst#L1053

2. For the 'order' part, its range can only be within 0~3.

> 
>>>> +static inline unsigned long encoded_page_order(struct encoded_va *encoded_va)
>>>> +{
>>>> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>>> +	return PAGE_FRAG_CACHE_ORDER_MASK & (unsigned long)encoded_va;
>>>> +#else
>>>> +	return 0;
>>>> +#endif
>>>> +}
>>>> +
>>>> +static inline bool encoded_page_pfmemalloc(struct encoded_va *encoded_va)
>>>> +{
>>>> +	return PAGE_FRAG_CACHE_PFMEMALLOC_BIT & (unsigned long)encoded_va;
>>>> +}
>>>> +
>>>
>>> My advice is that if you just make encoded_va an unsigned long this
>>> just becomes some FIELD_GET and bit operations.
>>
>> As above.
>>
> 
> The code you mentioned had one extra block of bits that was in it and
> had strict protections on what went into and out of those bits. You
> don't have any of those protections.

As above, the protection masking/checking is explicitly avoided due
to performance consideration and reasons as above for encoded_va.

But I guess it doesn't hurt to have a VM_BUG_ON() checking to catch
possible future mistake.

> 
> I suggest you just use a long and don't bother storing this as a
> pointer.
> 

...

>>>> -
>>>> +	remaining = nc->remaining & align_mask;
>>>> +	remaining -= fragsz;
>>>> +	if (unlikely(remaining < 0)) {
>>>
>>> Now this is just getting confusing. You essentially just added an
>>> additional addition step and went back to the countdown approach I was
>>> using before except for the fact that you are starting at 0 whereas I
>>> was actually moving down through the page.
>>
>> Does the 'additional addition step' mean the additional step to calculate
>> the offset using the new 'remaining' field? I guess that is the disadvantage
>> by changing 'offset' to 'remaining', but it also some advantages too:
>>
>> 1. it is better to replace 'offset' with 'remaining', which
>>    is the remaining size for the cache in a 'page_frag_cache'
>>    instance, we are able to do a single 'fragsz > remaining'
>>    checking for the case of cache not being enough, which should be
>>    the fast path if we ensure size is zoro when 'va' == NULL by
>>    memset'ing 'struct page_frag_cache' in page_frag_cache_init()
>>    and page_frag_cache_drain().
>> 2. It seems more convenient to implement the commit/probe API too
>>    when using 'remaining' instead of 'offset' as those API needs
>>    the remaining size of the page_frag_cache anyway.
>>
>> So it is really a trade-off between using 'offset' and 'remaining',
>> it is like the similar argument about trade-off between allocating
>> fragment 'countdown' and 'countup' way.
>>
>> About confusing part, as the nc->remaining does mean how much cache
>> is left in the 'nc', and nc->remaining does start from
>> PAGE_FRAG_CACHE_MAX_SIZE/PAGE_SIZE to zero naturally if that was what
>> you meant by 'countdown', but it is different from the 'offset countdown'
>> before this patchset as my understanding.
>>
>>>
>>> What I would suggest doing since "remaining" is a negative offset
>>> anyway would be to look at just storing it as a signed negative number.
>>> At least with that you can keep to your original approach and would
>>> only have to change your check to be for "remaining + fragsz <= 0".
>>
>> Did you mean by using s16/s32 for 'remaining'? And set nc->remaining like
>> below?
>> nc->remaining = -PAGE_SIZE or
>> nc->remaining = -PAGE_FRAG_CACHE_MAX_SIZE
> 
> Yes. Basically if we used it as a signed value then you could just work
> your way up and do your aligned math still.

For the aligned math, I am not sure how can 'align_mask' be appiled to
a signed value yet. It seems that after masking nc->remaining leans
towards -PAGE_SIZE/-PAGE_FRAG_CACHE_MAX_SIZE instead of zero for
a unsigned value, for example:

nc->remaining = -4094;
nc->remaining &= -64;

It seems we got -4096 for above, is that what we are expecting?

> 
>> struct page_frag_cache {
>>         struct encoded_va *encoded_va;
>>
>> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
>>         u16 pagecnt_bias;
>>         s16 remaining;
>> #else
>>         u32 pagecnt_bias;
>>         s32 remaining;
>> #endif
>> };
>>
>> If I understand above correctly, it seems we really need a better name
>> than 'remaining' to reflect that.
> 
> It would effectively work like a countdown. Instead of T - X in this
> case it is size - X.
> 
>>> With that you can still do your math but it becomes an addition instead
>>> of a subtraction.
>>
>> And I am not really sure what is the gain here by using an addition
>> instead of a subtraction here.
>>
> 
> The "remaining" as it currently stands is doing the same thing so odds
> are it isn't too big a deal. It is just that the original code was
> already somewhat confusing and this is just making it that much more
> complex.
> 
>>>> +		page = virt_to_page(encoded_va);
>>>>  		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>>>>  			goto refill;
>>>>  
>>>> -		if (unlikely(nc->pfmemalloc)) {
>>>> -			free_unref_page(page, compound_order(page));
>>>> +		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
>>>> +			VM_BUG_ON(compound_order(page) !=
>>>> +				  encoded_page_order(encoded_va));
>>>> +			free_unref_page(page, encoded_page_order(encoded_va));
>>>>  			goto refill;
>>>>  		}
>>>>  
>>>>  		/* OK, page count is 0, we can safely set it */
>>>>  		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>>>>  
>>>> -		/* reset page count bias and offset to start of new frag */
>>>> +		/* reset page count bias and remaining of new frag */
>>>>  		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>>> -		offset = 0;
>>>> -		if (unlikely(fragsz > PAGE_SIZE)) {
>>>> +		nc->remaining = remaining = page_frag_cache_page_size(encoded_va);
>>>> +		remaining -= fragsz;
>>>> +		if (unlikely(remaining < 0)) {
>>>>  			/*
>>>>  			 * The caller is trying to allocate a fragment
>>>>  			 * with fragsz > PAGE_SIZE but the cache isn't big
>>>
>>> I find it really amusing that you went to all the trouble of flipping
>>> the logic just to flip it back to being a countdown setup. If you were
>>> going to bother with all that then why not just make the remaining
>>> negative instead? You could save yourself a ton of trouble that way and
>>> all you would need to do is flip a few signs.
>>
>> I am not sure I understand the 'a ton of trouble' part here, if 'flipping
>> a few signs' does save a ton of trouble here, I would like to avoid 'a
>> ton of trouble' here, but I am not really understand the gain here yet as
>> mentioned above.
> 
> It isn't about flipping the signs. It is more the fact that the logic
> has now become even more complex then it originally was. With my work
> backwards approach the advantage was that the offset could be updated
> and then we just recorded everything and reported it up. Now we have to

I am supposing the above is referring to 'offset countdown' way
before this patchset, right?

> keep a temporary "remaining" value, generate our virtual address and
> store that to a temp variable, we can record the new "remaining" value,
> and then we can report the virtual address. If we get the ordering on

Yes, I noticed it when coding too, that is why current virtual address is
generated in page_frag_cache_current_va() basing on nc->remaining instead
of the local variable 'remaining' before assigning the local variable
'remaining' to nc->remaining. But I am not sure I understand how using a
signed negative number for 'remaining' will change the above steps. If
not, I still fail to see the gain of using a signed negative number for
'nc->remaining'.

> the steps 2 and 3 in this it will cause issues as we will be pointing
> to the wrong values. It is something I can see someone easily messing
> up.

Yes, agreed. It would be good to be more specific about how to avoid
the above problem using a signed negative number for 'remaining' as
I am not sure how it can be done yet.

> 

