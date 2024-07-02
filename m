Return-Path: <netdev+bounces-108453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B7A923E01
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C83828C8C3
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20F816D316;
	Tue,  2 Jul 2024 12:35:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E11534E1;
	Tue,  2 Jul 2024 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923707; cv=none; b=P7IH9UV9w3fjqd9dKrdXbI1HHq/kaQls52ljtND+W9DzUcWM78fUFqUVF0dlnsPI/1JQntEocRKVGoOYZ7OEunrJWZBQkeuSfTmJCVReTMBEwaDbo2ZnCvXieRoD6g0nrSilfv951Jq9saE0XOrB7CNMR0kijNpC9x0KlzjXadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923707; c=relaxed/simple;
	bh=oWiM+1Ip9myVix4kwM/ElvXmULemOp+ULnhEyFq7gxs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KKjpSAN3+EVV76nZ+BsHJVu1Vubg+MkZB8AdYwOp4FJqeXLEn+SwNgfZ0pdF+2GFZDnSD2BQ1q72GEVVlCDSc9r+UO3cn+wCxS+T72/HnJYI+pt0pzeuhEIMAlg44K9XY049V7AoSFXlMftXVYPOnsRfxENsX5Urgl3RtIwEgc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WD2Lg4vzRzxTsF;
	Tue,  2 Jul 2024 20:30:35 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3170F180A9C;
	Tue,  2 Jul 2024 20:35:02 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 2 Jul
 2024 20:35:01 +0800
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space for
 'size' and 'pfmemalloc'
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-7-linyunsheng@huawei.com>
 <12a8b9ddbcb2da8431f77c5ec952ccfb2a77b7ec.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <808be796-6333-c116-6ecb-95a39f7ad76e@huawei.com>
Date: Tue, 2 Jul 2024 20:35:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <12a8b9ddbcb2da8431f77c5ec952ccfb2a77b7ec.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/2 8:08, Alexander H Duyck wrote:
> On Tue, 2024-06-25 at 21:52 +0800, Yunsheng Lin wrote:
>> Currently there is one 'struct page_frag' for every 'struct
>> sock' and 'struct task_struct', we are about to replace the
>> 'struct page_frag' with 'struct page_frag_cache' for them.
>> Before begin the replacing, we need to ensure the size of
>> 'struct page_frag_cache' is not bigger than the size of
>> 'struct page_frag', as there may be tens of thousands of
>> 'struct sock' and 'struct task_struct' instances in the
>> system.
>>
>> By or'ing the page order & pfmemalloc with lower bits of
>> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
>> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
>> And page address & pfmemalloc & order is unchanged for the
>> same page in the same 'page_frag_cache' instance, it makes
>> sense to fit them together.
>>
>> Also, it is better to replace 'offset' with 'remaining', which
>> is the remaining size for the cache in a 'page_frag_cache'
>> instance, we are able to do a single 'fragsz > remaining'
>> checking for the case of cache not being enough, which should be
>> the fast path if we ensure size is zoro when 'va' == NULL by
>> memset'ing 'struct page_frag_cache' in page_frag_cache_init()
>> and page_frag_cache_drain().
>>
>> After this patch, the size of 'struct page_frag_cache' should be
>> the same as the size of 'struct page_frag'.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  include/linux/page_frag_cache.h | 76 +++++++++++++++++++++++-----
>>  mm/page_frag_cache.c            | 90 ++++++++++++++++++++-------------
>>  2 files changed, 118 insertions(+), 48 deletions(-)
>>
>> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
>> index 6ac3a25089d1..b33904d4494f 100644
>> --- a/include/linux/page_frag_cache.h
>> +++ b/include/linux/page_frag_cache.h
>> @@ -8,29 +8,81 @@
>>  #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
>>  #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
>>  
>> -struct page_frag_cache {
>> -	void *va;
>> +/*
>> + * struct encoded_va - a nonexistent type marking this pointer
>> + *
>> + * An 'encoded_va' pointer is a pointer to a aligned virtual address, which is
>> + * at least aligned to PAGE_SIZE, that means there are at least 12 lower bits
>> + * space available for other purposes.
>> + *
>> + * Currently we use the lower 8 bits and bit 9 for the order and PFMEMALLOC
>> + * flag of the page this 'va' is corresponding to.
>> + *
>> + * Use the supplied helper functions to endcode/decode the pointer and bits.
>> + */
>> +struct encoded_va;
>> +
> 
> Why did you create a struct for this? The way you use it below it is
> just a pointer. No point in defining a struct that doesn't exist
> anywhere.

The encoded_va is mirroring the encoded_page below:
https://elixir.bootlin.com/linux/v6.10-rc6/source/include/linux/mm_types.h#L222
https://github.com/torvalds/linux/commit/70fb4fdff5826a48886152fd5c5db04eb6c59a40

"So this introduces a 'struct encoded_page' pointer that cannot be used for
anything else than to encode a real page pointer and a couple of extra
bits in the low bits.  That way the compiler can trivially track the state
of the pointer and you just explicitly encode and decode the extra bits."

It seems to be similar for encoded_va case too, I guess this is more of personal
preference for using a struct or unsigned long here, I have no strong preference
here and it can be changed if you really insist.

> 
>> +#define PAGE_FRAG_CACHE_ORDER_MASK		GENMASK(7, 0)
>> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT		BIT(8)
>> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT	8
>> +
>> +static inline struct encoded_va *encode_aligned_va(void *va,
>> +						   unsigned int order,
>> +						   bool pfmemalloc)
>> +{
>>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> -	__u16 offset;
>> -	__u16 size;
>> +	return (struct encoded_va *)((unsigned long)va | order |
>> +			pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
>>  #else
>> -	__u32 offset;
>> +	return (struct encoded_va *)((unsigned long)va |
>> +			pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
>> +#endif
>> +}
>> +
>> +static inline unsigned long encoded_page_order(struct encoded_va *encoded_va)
>> +{
>> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> +	return PAGE_FRAG_CACHE_ORDER_MASK & (unsigned long)encoded_va;
>> +#else
>> +	return 0;
>> +#endif
>> +}
>> +
>> +static inline bool encoded_page_pfmemalloc(struct encoded_va *encoded_va)
>> +{
>> +	return PAGE_FRAG_CACHE_PFMEMALLOC_BIT & (unsigned long)encoded_va;
>> +}
>> +
> 
> My advice is that if you just make encoded_va an unsigned long this
> just becomes some FIELD_GET and bit operations.

As above.

> 
>> +static inline void *encoded_page_address(struct encoded_va *encoded_va)
>> +{
>> +	return (void *)((unsigned long)encoded_va & PAGE_MASK);
>> +}
>> +
>> +struct page_frag_cache {
>> +	struct encoded_va *encoded_va;
> 
> This should be an unsigned long, not a pointer since you are storing
> data other than just a pointer in here. The pointer is just one of the
> things you extract out of it.
> 
>> +
>> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
>> +	u16 pagecnt_bias;
>> +	u16 remaining;
>> +#else
>> +	u32 pagecnt_bias;
>> +	u32 remaining;
>>  #endif
>> -	/* we maintain a pagecount bias, so that we dont dirty cache line
>> -	 * containing page->_refcount every time we allocate a fragment.
>> -	 */
>> -	unsigned int		pagecnt_bias;
>> -	bool pfmemalloc;
>>  };
>>  
>>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>>  {
>> -	nc->va = NULL;
>> +	memset(nc, 0, sizeof(*nc));
> 
> Shouldn't need to memset 0 the whole thing. Just setting page and order
> to 0 should be enough to indicate that there isn't anything there.

As mentioned in the commit log:
'Also, it is better to replace 'offset' with 'remaining', which
is the remaining size for the cache in a 'page_frag_cache'
instance, we are able to do a single 'fragsz > remaining'
checking for the case of cache not being enough, which should be
the fast path if we ensure 'remaining' is zero when 'va' == NULL by
memset'ing 'struct page_frag_cache' in page_frag_cache_init()
and page_frag_cache_drain().'

Yes, we are only really depending on nc->remaining being zero
when 'va' == NULL untill next patch refactors more codes in
__page_frag_alloc_va_align() to __page_frag_cache_refill().
Perhap I should do the memset() thing in next patch.

> 
>>  }
>>  
>>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
>>  {
>> -	return !!nc->pfmemalloc;
>> +	return encoded_page_pfmemalloc(nc->encoded_va);
>> +}
>> +
>> +static inline unsigned int page_frag_cache_page_size(struct encoded_va *encoded_va)
>> +{
>> +	return PAGE_SIZE << encoded_page_order(encoded_va);
>>  }
>>  
>>  void page_frag_cache_drain(struct page_frag_cache *nc);
>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>> index dd640af5607a..a3316dd50eff 100644
>> --- a/mm/page_frag_cache.c
>> +++ b/mm/page_frag_cache.c
>> @@ -18,34 +18,61 @@
>>  #include <linux/page_frag_cache.h>
>>  #include "internal.h"
>>  
>> +static void *page_frag_cache_current_va(struct page_frag_cache *nc)
>> +{
>> +	struct encoded_va *encoded_va = nc->encoded_va;
>> +
>> +	return (void *)(((unsigned long)encoded_va & PAGE_MASK) |
>> +		(page_frag_cache_page_size(encoded_va) - nc->remaining));
>> +}
>> +
> 
> Rather than an OR here I would rather see this just use addition.
> Otherwise this logic becomes overly complicated.

Sure.

> 
>>  static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>  					     gfp_t gfp_mask)
>>  {
>>  	struct page *page = NULL;
>>  	gfp_t gfp = gfp_mask;
>> +	unsigned int order;
>>  
>>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>  	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
>>  		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>>  	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>>  				PAGE_FRAG_CACHE_MAX_ORDER);
>> -	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
>>  #endif
>> -	if (unlikely(!page))
>> +	if (unlikely(!page)) {
>>  		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>> +		if (unlikely(!page)) {
>> +			memset(nc, 0, sizeof(*nc));
>> +			return NULL;
>> +		}
>> +
>> +		order = 0;
>> +		nc->remaining = PAGE_SIZE;
>> +	} else {
>> +		order = PAGE_FRAG_CACHE_MAX_ORDER;
>> +		nc->remaining = PAGE_FRAG_CACHE_MAX_SIZE;
>> +	}
>>  
>> -	nc->va = page ? page_address(page) : NULL;
>> +	/* Even if we own the page, we do not use atomic_set().
>> +	 * This would break get_page_unless_zero() users.
>> +	 */
>> +	page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>>  
>> +	/* reset page count bias of new frag */
>> +	nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
> 
> I would rather keep the pagecnt_bias, page reference addition, and
> resetting of remaining outside of this. The only fields we should be
> setting are order, the virtual address, and pfmemalloc since those are
> what is encoded in your unsigned long variable.

Is there any reason why you want to keep them outside of this?

For resetting of remaining, it seems we need more check to decide the
value of remaining if it is kept outside of this.

Also, for the next patch, more common codes are refactored out of
 __page_frag_alloc_va_align() to __page_frag_cache_refill(), so that
the new API can make use of them, so I am not sure it really matter
that much.

> 
>> +	nc->encoded_va = encode_aligned_va(page_address(page), order,
>> +					   page_is_pfmemalloc(page));
>>  	return page;
>>  }
>>  
>>  void page_frag_cache_drain(struct page_frag_cache *nc)
>>  {
>> -	if (!nc->va)
>> +	if (!nc->encoded_va)
>>  		return;
>>  
>> -	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
>> -	nc->va = NULL;
>> +	__page_frag_cache_drain(virt_to_head_page(nc->encoded_va),
>> +				nc->pagecnt_bias);
>> +	memset(nc, 0, sizeof(*nc));
> 
> Again, no need for memset when "nv->encoded_va = 0" will do.
> 
>>  }
>>  EXPORT_SYMBOL(page_frag_cache_drain);
>>  
>> @@ -62,51 +89,41 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>>  				 unsigned int fragsz, gfp_t gfp_mask,
>>  				 unsigned int align_mask)
>>  {
>> -	unsigned int size = PAGE_SIZE;
>> +	struct encoded_va *encoded_va = nc->encoded_va;
>>  	struct page *page;
>> -	int offset;
>> +	int remaining;
>> +	void *va;
>>  
>> -	if (unlikely(!nc->va)) {
>> +	if (unlikely(!encoded_va)) {
>>  refill:
>> -		page = __page_frag_cache_refill(nc, gfp_mask);
>> -		if (!page)
>> +		if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
>>  			return NULL;
>>  
>> -		/* Even if we own the page, we do not use atomic_set().
>> -		 * This would break get_page_unless_zero() users.
>> -		 */
>> -		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>> -
>> -		/* reset page count bias and offset to start of new frag */
>> -		nc->pfmemalloc = page_is_pfmemalloc(page);
>> -		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>> -		nc->offset = 0;
>> +		encoded_va = nc->encoded_va;
>>  	}
>>  
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> -	/* if size can vary use size else just use PAGE_SIZE */
>> -	size = nc->size;
>> -#endif
>> -
>> -	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
>> -	if (unlikely(offset + fragsz > size)) {
>> -		page = virt_to_page(nc->va);
>> -
>> +	remaining = nc->remaining & align_mask;
>> +	remaining -= fragsz;
>> +	if (unlikely(remaining < 0)) {
> 
> Now this is just getting confusing. You essentially just added an
> additional addition step and went back to the countdown approach I was
> using before except for the fact that you are starting at 0 whereas I
> was actually moving down through the page.

Does the 'additional addition step' mean the additional step to calculate
the offset using the new 'remaining' field? I guess that is the disadvantage
by changing 'offset' to 'remaining', but it also some advantages too:

1. it is better to replace 'offset' with 'remaining', which
   is the remaining size for the cache in a 'page_frag_cache'
   instance, we are able to do a single 'fragsz > remaining'
   checking for the case of cache not being enough, which should be
   the fast path if we ensure size is zoro when 'va' == NULL by
   memset'ing 'struct page_frag_cache' in page_frag_cache_init()
   and page_frag_cache_drain().
2. It seems more convenient to implement the commit/probe API too
   when using 'remaining' instead of 'offset' as those API needs
   the remaining size of the page_frag_cache anyway.

So it is really a trade-off between using 'offset' and 'remaining',
it is like the similar argument about trade-off between allocating
fragment 'countdown' and 'countup' way.

About confusing part, as the nc->remaining does mean how much cache
is left in the 'nc', and nc->remaining does start from
PAGE_FRAG_CACHE_MAX_SIZE/PAGE_SIZE to zero naturally if that was what
you meant by 'countdown', but it is different from the 'offset countdown'
before this patchset as my understanding.

> 
> What I would suggest doing since "remaining" is a negative offset
> anyway would be to look at just storing it as a signed negative number.
> At least with that you can keep to your original approach and would
> only have to change your check to be for "remaining + fragsz <= 0".

Did you mean by using s16/s32 for 'remaining'? And set nc->remaining like
below?
nc->remaining = -PAGE_SIZE or
nc->remaining = -PAGE_FRAG_CACHE_MAX_SIZE

struct page_frag_cache {
        struct encoded_va *encoded_va;

#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
        u16 pagecnt_bias;
        s16 remaining;
#else
        u32 pagecnt_bias;
        s32 remaining;
#endif
};

If I understand above correctly, it seems we really need a better name
than 'remaining' to reflect that.

> With that you can still do your math but it becomes an addition instead
> of a subtraction.

And I am not really sure what is the gain here by using an addition
instead of a subtraction here.

> 
>> +		page = virt_to_page(encoded_va);
>>  		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>>  			goto refill;
>>  
>> -		if (unlikely(nc->pfmemalloc)) {
>> -			free_unref_page(page, compound_order(page));
>> +		if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
>> +			VM_BUG_ON(compound_order(page) !=
>> +				  encoded_page_order(encoded_va));
>> +			free_unref_page(page, encoded_page_order(encoded_va));
>>  			goto refill;
>>  		}
>>  
>>  		/* OK, page count is 0, we can safely set it */
>>  		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>>  
>> -		/* reset page count bias and offset to start of new frag */
>> +		/* reset page count bias and remaining of new frag */
>>  		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>> -		offset = 0;
>> -		if (unlikely(fragsz > PAGE_SIZE)) {
>> +		nc->remaining = remaining = page_frag_cache_page_size(encoded_va);
>> +		remaining -= fragsz;
>> +		if (unlikely(remaining < 0)) {
>>  			/*
>>  			 * The caller is trying to allocate a fragment
>>  			 * with fragsz > PAGE_SIZE but the cache isn't big
> 
> I find it really amusing that you went to all the trouble of flipping
> the logic just to flip it back to being a countdown setup. If you were
> going to bother with all that then why not just make the remaining
> negative instead? You could save yourself a ton of trouble that way and
> all you would need to do is flip a few signs.

I am not sure I understand the 'a ton of trouble' part here, if 'flipping
a few signs' does save a ton of trouble here, I would like to avoid 'a
ton of trouble' here, but I am not really understand the gain here yet as
mentioned above.

