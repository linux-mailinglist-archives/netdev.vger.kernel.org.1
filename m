Return-Path: <netdev+bounces-118696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD295281A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 05:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCB22857B1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 03:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AC737147;
	Thu, 15 Aug 2024 03:04:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E23B18641;
	Thu, 15 Aug 2024 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691051; cv=none; b=e25OKyjmZUJp29SFgX3fefMG/sdWCsVA9okenViZrFQZ29607Tmxcz2ol3HKSuxb8HdLX+z3rJG8x5aOVqhYdejY9lSE6iYBWKMxIqc6mS0WBHpyOra+JraVj63LaOHkEz8dh/Y60ksXwwepKpO++2xXHzcH8n4cgo9kkbFjXyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691051; c=relaxed/simple;
	bh=gcpoaIIxeNLcQfhBxNRy+vr76gHVNnEZRZkhQvVZjtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vCimSzGkUm5H5Ik3jD0i71o9ji9P4AMvsRl9lnzC/2NSkZSyBD019KmAAQUp6BQHg8ympLi4HQQsr4fqE0b7IciwodXdlHo2pwY9cB8o9/odMuMyiYnlyjOjvuwdCMkTSdT+o+XLPDhqy0qDE9nNtDFvwEoRxhB+NWg9ttgLu0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wkqg85bLQzpSwK;
	Thu, 15 Aug 2024 11:02:44 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DF5A1800A5;
	Thu, 15 Aug 2024 11:04:06 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Aug 2024 11:04:06 +0800
Message-ID: <82cc55f0-35e9-4e54-8316-00312389de3f@huawei.com>
Date: Thu, 15 Aug 2024 11:04:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 08/14] mm: page_frag: some minor refactoring
 before adding new API
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-9-linyunsheng@huawei.com>
 <7d16ba784eb564f9d556f532d670b9bc4698d913.camel@gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <7d16ba784eb564f9d556f532d670b9bc4698d913.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/15 1:54, Alexander H Duyck wrote:
> On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
>> Refactor common codes from __page_frag_alloc_va_align()
>> to __page_frag_cache_reload(), so that the new API can
>> make use of them.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  include/linux/page_frag_cache.h |   2 +-
>>  mm/page_frag_cache.c            | 138 ++++++++++++++++++--------------
>>  2 files changed, 81 insertions(+), 59 deletions(-)
>>
>> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
>> index 4ce924eaf1b1..0abffdd10a1c 100644
>> --- a/include/linux/page_frag_cache.h
>> +++ b/include/linux/page_frag_cache.h
>> @@ -52,7 +52,7 @@ static inline void *encoded_page_address(unsigned long encoded_va)
>>  
>>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>>  {
>> -	nc->encoded_va = 0;
>> +	memset(nc, 0, sizeof(*nc));
>>  }
>>  
> 
> Still not a fan of this. Just setting encoded_va to 0 should be enough
> as the other fields will automatically be overwritten when the new page
> is allocated.
> 
> Relying on memset is problematic at best since you then introduce the
> potential for issues where remaining somehow gets corrupted but
> encoded_va/page is 0. I would rather have both of these being checked
> as a part of allocation than just just assuming it is valid if
> remaining is set.

Does adding something like VM_BUG_ON(!nc->encoded_va && nc->remaining) to
catch the above problem address your above concern?

> 
> I would prefer to keep the check for a non-0 encoded_page value and
> then check remaining rather than just rely on remaining as it creates a
> single point of failure. With that we can safely tear away a page and
> the next caller to try to allocate will populated a new page and the
> associated fields.

As mentioned before, the memset() is used mainly because of:
1. avoid a checking in the fast path.
2. avoid duplicating the checking pattern you mentioned above for the
   new API.

> 
>>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>> index 2544b292375a..4e6b1c4684f0 100644
>> --- a/mm/page_frag_cache.c
>> +++ b/mm/page_frag_cache.c
>> @@ -19,8 +19,27 @@
>>  #include <linux/page_frag_cache.h>
>>  #include "internal.h"
>>  

...

>> +
>> +/* Reload cache by reusing the old cache if it is possible, or
>> + * refilling from the page allocator.
>> + */
>> +static bool __page_frag_cache_reload(struct page_frag_cache *nc,
>> +				     gfp_t gfp_mask)
>> +{
>> +	if (likely(nc->encoded_va)) {
>> +		if (__page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias))
>> +			goto out;
>> +	}
>> +
>> +	if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
>> +		return false;
>> +
>> +out:
>> +	/* reset page count bias and remaining to start of new frag */
>> +	nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>> +	nc->remaining = page_frag_cache_page_size(nc->encoded_va);
> 
> One thought I am having is that it might be better to have the
> pagecnt_bias get set at the same time as the page_ref_add or the
> set_page_count call. In addition setting the remaining value at the
> same time probably would make sense as in the refill case you can make
> use of the "order" value directly instead of having to write/read it
> out of the encoded va/page.

Probably, there is always tradeoff to make regarding avoid code
duplication and avoid reading the order, I am not sure it matters
for both for case, I would rather keep the above pattern if there
is not obvious benefit for the other pattern.

> 
> With that we could simplify this function and get something closer to
> what we had for the original alloc_va_align code.
> 
>> +	return true;
>>  }
>>  
>>  void page_frag_cache_drain(struct page_frag_cache *nc)
>> @@ -55,7 +100,7 @@ void page_frag_cache_drain(struct page_frag_cache *nc)
>>  
>>  	__page_frag_cache_drain(virt_to_head_page((void *)nc->encoded_va),
>>  				nc->pagecnt_bias);
>> -	nc->encoded_va = 0;
>> +	memset(nc, 0, sizeof(*nc));
>>  }
>>  EXPORT_SYMBOL(page_frag_cache_drain);
>>  
>> @@ -73,67 +118,44 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>>  				 unsigned int align_mask)
>>  {
>>  	unsigned long encoded_va = nc->encoded_va;
>> -	unsigned int size, remaining;
>> -	struct page *page;
>> -
>> -	if (unlikely(!encoded_va)) {
> 
> We should still be checking this before we even touch remaining.
> Otherwise we greatly increase the risk of providing a bad virtual
> address and have greatly decreased the likelihood of us catching
> potential errors gracefully.
> 
>> -refill:
>> -		page = __page_frag_cache_refill(nc, gfp_mask);
>> -		if (!page)
>> -			return NULL;
>> -
>> -		encoded_va = nc->encoded_va;
>> -		size = page_frag_cache_page_size(encoded_va);
>> -
>> -		/* Even if we own the page, we do not use atomic_set().
>> -		 * This would break get_page_unless_zero() users.
>> -		 */
>> -		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>> -
>> -		/* reset page count bias and remaining to start of new frag */
>> -		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>> -		nc->remaining = size;
> 
> With my suggested change above you could essentially just drop the
> block starting from the comment and this function wouldn't need to
> change as much as it is.

It seems you are still suggesting that new API also duplicates the old
checking pattern in __page_frag_alloc_va_align()?

I would rather avoid the above if something like VM_BUG_ON() can address
your above concern.

