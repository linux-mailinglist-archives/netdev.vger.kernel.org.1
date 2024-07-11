Return-Path: <netdev+bounces-110749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AADE92E1D7
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9911C2137C
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 08:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D899144D00;
	Thu, 11 Jul 2024 08:16:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095BC2555B;
	Thu, 11 Jul 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685807; cv=none; b=R/y5YQqbcRGdZhM3Qo5EEe6p9RZCeyIi1MO4NUTJtehfvjskhRmpoKQQOwZGurPbetlV+mYw5lwT/A0EUhCpfu15sio+Xojj1ctDLbcl/3uTNa6QjVDNnLv7aOFmUARuxx1gBX3wY7bDnzMqgAEvW2Su3YpZ0g9GGkkNvDbWB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685807; c=relaxed/simple;
	bh=6E0bME+fwnz7yNunFqFDkevQI/+czIyqZ8dfJylmHsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZL4/FGzcIVmnIruv3VaGaP0/X3xNL2yT2mBSok4XhQ/zSn5hK9b7hoLfG4Zy0pIc+H9q863KdXVdT9xkhM4lqyteo/x2cPvUlUwBVGx7O6H/Wi+mCkiOZj/tHWumzhqAzAS89j63aSejI7/oVqA9h19KgNBRYSYc8XsgZhfmW4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WKSFZ1skxzdhJX;
	Thu, 11 Jul 2024 16:14:58 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2047B140382;
	Thu, 11 Jul 2024 16:16:39 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Jul 2024 16:16:38 +0800
Message-ID: <5daed410-063b-4d86-b544-d1a85bd86375@huawei.com>
Date: Thu, 11 Jul 2024 16:16:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <f4ff5a42-9371-bc54-8523-b11d8511c39a@huawei.com>
 <96b04ebb7f46d73482d5f71213bd800c8195f00d.camel@gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <96b04ebb7f46d73482d5f71213bd800c8195f00d.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/10 23:28, Alexander H Duyck wrote:

...

>>>>
>>>>>
>>>>> What I would suggest doing since "remaining" is a negative offset
>>>>> anyway would be to look at just storing it as a signed negative number.
>>>>> At least with that you can keep to your original approach and would
>>>>> only have to change your check to be for "remaining + fragsz <= 0".
>>>>
>>>> Did you mean by using s16/s32 for 'remaining'? And set nc->remaining like
>>>> below?
>>>> nc->remaining = -PAGE_SIZE or
>>>> nc->remaining = -PAGE_FRAG_CACHE_MAX_SIZE
>>>
>>> Yes. Basically if we used it as a signed value then you could just work
>>> your way up and do your aligned math still.
>>
>> For the aligned math, I am not sure how can 'align_mask' be appiled to
>> a signed value yet. It seems that after masking nc->remaining leans
>> towards -PAGE_SIZE/-PAGE_FRAG_CACHE_MAX_SIZE instead of zero for
>> a unsigned value, for example:
>>
>> nc->remaining = -4094;
>> nc->remaining &= -64;
>>
>> It seems we got -4096 for above, is that what we are expecting?
> 
> No, you have to do an addition and then the mask like you were before
> using __ALIGN_KERNEL.
> 
> As it stands I realized your alignment approach in this patch is
> broken. You should be aligning the remaining at the start of this
> function and then storing it before you call
> page_frag_cache_current_va. Instead you do it after so the start of
> your block may not be aligned to the requested mask if you have
> multiple callers sharing this function or if you are passing an
> unaligned size in the request.

Yes, you seems right about it, the intention is to do the below as patch
3 does in v10:
aligned_remaining = nc->remaining & align_mask;
remaining = aligned_remaining - fragsz;
nc->remaining = remaining;
return encoded_page_address(nc->encoded_va) + (size - aligned_remaining);

> 
>>>
>>>> struct page_frag_cache {
>>>>         struct encoded_va *encoded_va;
>>>>
>>>> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
>>>>         u16 pagecnt_bias;
>>>>         s16 remaining;
>>>> #else
>>>>         u32 pagecnt_bias;
>>>>         s32 remaining;
>>>> #endif
>>>> };
>>>>
>>>> If I understand above correctly, it seems we really need a better name
>>>> than 'remaining' to reflect that.
>>>
>>> It would effectively work like a countdown. Instead of T - X in this
>>> case it is size - X.
>>>
>>>>> With that you can still do your math but it becomes an addition instead
>>>>> of a subtraction.
>>>>
>>>> And I am not really sure what is the gain here by using an addition
>>>> instead of a subtraction here.
>>>>
>>>
>>> The "remaining" as it currently stands is doing the same thing so odds
>>> are it isn't too big a deal. It is just that the original code was
>>> already somewhat confusing and this is just making it that much more
>>> complex.
>>>
>>>>>> +		page = virt_to_page(encoded_va);
>>>>>>  		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>>>>>>  			goto refill;
>>>>>>  
>>>>>> -		if (unlikely(nc->pfmemalloc)) {
>>>>>> -			free_unref_page(page, compound_order(page));
>>>>>> +		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
>>>>>> +			VM_BUG_ON(compound_order(page) !=
>>>>>> +				  encoded_page_order(encoded_va));
>>>>>> +			free_unref_page(page, encoded_page_order(encoded_va));
>>>>>>  			goto refill;
>>>>>>  		}
>>>>>>  
>>>>>>  		/* OK, page count is 0, we can safely set it */
>>>>>>  		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>>>>>>  
>>>>>> -		/* reset page count bias and offset to start of new frag */
>>>>>> +		/* reset page count bias and remaining of new frag */
>>>>>>  		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>>>>> -		offset = 0;
>>>>>> -		if (unlikely(fragsz > PAGE_SIZE)) {
>>>>>> +		nc->remaining = remaining = page_frag_cache_page_size(encoded_va);
>>>>>> +		remaining -= fragsz;
>>>>>> +		if (unlikely(remaining < 0)) {
>>>>>>  			/*
>>>>>>  			 * The caller is trying to allocate a fragment
>>>>>>  			 * with fragsz > PAGE_SIZE but the cache isn't big
>>>>>
>>>>> I find it really amusing that you went to all the trouble of flipping
>>>>> the logic just to flip it back to being a countdown setup. If you were
>>>>> going to bother with all that then why not just make the remaining
>>>>> negative instead? You could save yourself a ton of trouble that way and
>>>>> all you would need to do is flip a few signs.
>>>>
>>>> I am not sure I understand the 'a ton of trouble' part here, if 'flipping
>>>> a few signs' does save a ton of trouble here, I would like to avoid 'a
>>>> ton of trouble' here, but I am not really understand the gain here yet as
>>>> mentioned above.
>>>
>>> It isn't about flipping the signs. It is more the fact that the logic
>>> has now become even more complex then it originally was. With my work
>>> backwards approach the advantage was that the offset could be updated
>>> and then we just recorded everything and reported it up. Now we have to
>>
>> I am supposing the above is referring to 'offset countdown' way
>> before this patchset, right?
>>
>>> keep a temporary "remaining" value, generate our virtual address and
>>> store that to a temp variable, we can record the new "remaining" value,
>>> and then we can report the virtual address. If we get the ordering on
>>
>> Yes, I noticed it when coding too, that is why current virtual address is
>> generated in page_frag_cache_current_va() basing on nc->remaining instead
>> of the local variable 'remaining' before assigning the local variable
>> 'remaining' to nc->remaining. But I am not sure I understand how using a
>> signed negative number for 'remaining' will change the above steps. If
>> not, I still fail to see the gain of using a signed negative number for
>> 'nc->remaining'.
>>
>>> the steps 2 and 3 in this it will cause issues as we will be pointing
>>> to the wrong values. It is something I can see someone easily messing
>>> up.
>>
>> Yes, agreed. It would be good to be more specific about how to avoid
>> the above problem using a signed negative number for 'remaining' as
>> I am not sure how it can be done yet.
>>
> 
> My advice would be to go back to patch 3 and figure out how to do this
> re-ordering without changing the alignment behaviour. The old code
> essentially aligned both the offset and fragsz by combining the two and
> then doing the alignment. Since you are doing a count up setup you will

I am not sure I understand 'aligned both the offset and fragsz ' part, as
'fragsz' being aligned or not seems to depend on last caller' align_mask,
for the same page_frag_cache instance, suppose offset = 32768 initially for
the old code:
Step 1: __page_frag_alloc_align() is called with fragsz=7 and align_mask=~0u
       the offset after this is 32761, the true fragsz is 7 too.

Step 2: __page_frag_alloc_align() is called with fragsz=7 and align_mask=-16
        the offset after this is 32752, the true fragsz is 9, which does
        not seems to be aligned.

The above is why I added the below paragraph in the doc to make the semantic
more explicit:
"Depending on different aligning requirement, the page_frag API caller may call
page_frag_alloc*_align*() to ensure the returned virtual address or offset of
the page is aligned according to the 'align/alignment' parameter. Note the size
of the allocated fragment is not aligned, the caller needs to provide an aligned
fragsz if there is an alignment requirement for the size of the fragment."

And existing callers of page_frag aligned API does seems to follow the above
rule last time I checked.

Or did I miss something obvious here?

> need to align the remaining, then add fragsz, and then I guess you
> could store remaining and then subtract fragsz from your final virtual
> address to get back to where the starting offset is actually located.

remaining = __ALIGN_KERNEL_MASK(nc->remaining, ~align_mask);
remaining += fragsz;
nc->remaining = remaining;
return encoded_page_address(nc->encoded_va) + (size + remaining) - fragsz;

If yes, I am not sure what is the point of doing the above yet, it
just seem to make thing more complicated and harder to understand.

> 
> Basically your "remaining" value isn't a safe number to use for an
> offset since it isn't aligned to your starting value at any point.

Does using 'aligned_remaining' local variable to make it more obvious
seem reasonable to you?

> 
> As far as the negative value, it is more about making it easier to keep
> track of what is actually going on. Basically we can use regular
> pointer math and as such I suspect the compiler is having to do extra
> instructions to flip your value negative before it can combine the
> values via something like the LEA (load effective address) assembler
> call.

I am not an asm expert here, I am not sure I understand the optimization
trick here.

