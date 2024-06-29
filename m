Return-Path: <netdev+bounces-107881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9279891CC51
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 13:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64C11C21166
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 11:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09742AF06;
	Sat, 29 Jun 2024 11:15:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF01CF8D;
	Sat, 29 Jun 2024 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719659745; cv=none; b=hqqcsDPtrO43Tqm/pVhNhfsnPUFUBjlHlYPpYh30VcL2bJ4DMaf4hMhTtjaZpVHw/KhEG/7LrZYK/Dt4KmTTkRLFBaMCsovHvhjJI6BPLvtyq7jOSS/hv0xp4og74RfwrpwMLXpncWY9x7FI79pJi2KY0wDPMhNFdvhzUbNWNnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719659745; c=relaxed/simple;
	bh=+4qCjC5qq1wDGMMrdL9vQkg9LJrUa7jM4RIgAD8gjDU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TM6AZuWbExqGfFtxakPYOZc7LMVeWltPbvec8JNIoaDWQqdOicvGI05Zt8u5tN/ZerqoIC2ZHhrbHoOWfh9+0Pb0NDsyBZh2WehlOb1nP/mwyWfEmP1csLLZZvxliwtb58z32IioVrjFnsPJsDi9M3oSalPd1IF3MTTumcjv/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WB8kY34gkzjYyx;
	Sat, 29 Jun 2024 19:11:17 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AC77180089;
	Sat, 29 Jun 2024 19:15:40 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 29 Jun
 2024 19:15:40 +0800
Subject: Re: [PATCH net-next v9 10/13] mm: page_frag: introduce
 prepare/probe/commit API
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-11-linyunsheng@huawei.com>
 <33c3c7fc00d2385e741dc6c9be0eade26c30bd12.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <38da183b-92ba-ce9d-5472-def199854563@huawei.com>
Date: Sat, 29 Jun 2024 19:15:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <33c3c7fc00d2385e741dc6c9be0eade26c30bd12.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/6/29 6:35, Alexander H Duyck wrote:
> On Tue, 2024-06-25 at 21:52 +0800, Yunsheng Lin wrote:
>> There are many use cases that need minimum memory in order
>> for forward progress, but more performant if more memory is
>> available or need to probe the cache info to use any memory
>> available for frag caoleasing reason.
>>
>> Currently skb_page_frag_refill() API is used to solve the
>> above use cases, but caller needs to know about the internal
>> detail and access the data field of 'struct page_frag' to
>> meet the requirement of the above use cases and its
>> implementation is similar to the one in mm subsystem.
>>
>> To unify those two page_frag implementations, introduce a
>> prepare API to ensure minimum memory is satisfied and return
>> how much the actual memory is available to the caller and a
>> probe API to report the current available memory to caller
>> without doing cache refilling. The caller needs to either call
>> the commit API to report how much memory it actually uses, or
>> not do so if deciding to not use any memory.
>>
>> As next patch is about to replace 'struct page_frag' with
>> 'struct page_frag_cache' in linux/sched.h, which is included
>> by the asm-offsets.s, using the virt_to_page() in the inline
>> helper of page_frag_cache.h cause a "'vmemmap' undeclared"
>> compiling error for asm-offsets.s, use a macro for probe API
>> to avoid that compiling error.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  include/linux/page_frag_cache.h |  82 +++++++++++++++++++++++
>>  mm/page_frag_cache.c            | 114 ++++++++++++++++++++++++++++++++
>>  2 files changed, 196 insertions(+)
>>
>> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
>> index b33904d4494f..e95d44a36ec9 100644
>> --- a/include/linux/page_frag_cache.h
>> +++ b/include/linux/page_frag_cache.h
>> @@ -4,6 +4,7 @@
>>  #define _LINUX_PAGE_FRAG_CACHE_H
>>  
>>  #include <linux/gfp_types.h>
>> +#include <linux/mmdebug.h>
>>  
>>  #define PAGE_FRAG_CACHE_MAX_SIZE	__ALIGN_MASK(32768, ~PAGE_MASK)
>>  #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
>> @@ -87,6 +88,9 @@ static inline unsigned int page_frag_cache_page_size(struct encoded_va *encoded_
>>  
>>  void page_frag_cache_drain(struct page_frag_cache *nc);
>>  void __page_frag_cache_drain(struct page *page, unsigned int count);
>> +struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
>> +				unsigned int *offset, unsigned int fragsz,
>> +				gfp_t gfp);
>>  void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>>  				 unsigned int fragsz, gfp_t gfp_mask,
>>  				 unsigned int align_mask);
>> @@ -99,12 +103,90 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
>>  	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, -align);
>>  }
>>  
>> +static inline unsigned int page_frag_cache_page_offset(const struct page_frag_cache *nc)
>> +{
>> +	return page_frag_cache_page_size(nc->encoded_va) - nc->remaining;
>> +}
>> +
>>  static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
>>  				       unsigned int fragsz, gfp_t gfp_mask)
>>  {
>>  	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, ~0u);
>>  }
>>  
>> +void *page_frag_alloc_va_prepare(struct page_frag_cache *nc, unsigned int *fragsz,
>> +				 gfp_t gfp);
>> +
>> +static inline void *page_frag_alloc_va_prepare_align(struct page_frag_cache *nc,
>> +						     unsigned int *fragsz,
>> +						     gfp_t gfp,
>> +						     unsigned int align)
>> +{
>> +	WARN_ON_ONCE(!is_power_of_2(align) || align > PAGE_SIZE);
>> +	nc->remaining = nc->remaining & -align;
>> +	return page_frag_alloc_va_prepare(nc, fragsz, gfp);
>> +}
>> +
>> +struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
>> +					unsigned int *offset,
>> +					unsigned int *fragsz, gfp_t gfp);
>> +
>> +struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
>> +				     unsigned int *offset,
>> +				     unsigned int *fragsz,
>> +				     void **va, gfp_t gfp);
>> +
>> +static inline struct encoded_va *__page_frag_alloc_probe(struct page_frag_cache *nc,
>> +							 unsigned int *offset,
>> +							 unsigned int *fragsz,
>> +							 void **va)
>> +{
>> +	struct encoded_va *encoded_va;
>> +
>> +	*fragsz = nc->remaining;
>> +	encoded_va = nc->encoded_va;
>> +	*offset = page_frag_cache_page_size(encoded_va) - *fragsz;
>> +	*va = encoded_page_address(encoded_va) + *offset;
>> +
>> +	return encoded_va;
>> +}
>> +
>> +#define page_frag_alloc_probe(nc, offset, fragsz, va)			\
>> +({									\
>> +	struct page *__page = NULL;					\
>> +									\
>> +	VM_BUG_ON(!*(fragsz));						\
>> +	if (likely((nc)->remaining >= *(fragsz)))			\
>> +		__page = virt_to_page(__page_frag_alloc_probe(nc,	\
>> +							      offset,	\
>> +							      fragsz,	\
>> +							      va));	\
>> +									\
>> +	__page;								\
>> +})
>> +
> 
> Why is this a macro instead of just being an inline? Are you trying to
> avoid having to include a header due to the virt_to_page?

Yes, you are right.
I tried including different headers for virt_to_page(), and it did not
work for arch/x86/kernel/asm-offsets.s, which has included linux/sched.h,
and linux/sched.h need 'struct page_frag_cache' for 'struct task_struct'
after this patchset, including page_frag_cache.h for sched.h causes the
below compiler error:

  CC      arch/x86/kernel/asm-offsets.s
In file included from ./arch/x86/include/asm/page.h:89,
                 from ./arch/x86/include/asm/thread_info.h:12,
                 from ./include/linux/thread_info.h:60,
                 from ./include/linux/spinlock.h:60,
                 from ./include/linux/swait.h:7,
                 from ./include/linux/completion.h:12,
                 from ./include/linux/crypto.h:15,
                 from arch/x86/kernel/asm-offsets.c:9:
./include/linux/page_frag_cache.h: In function ‘page_frag_alloc_align’:
./include/asm-generic/memory_model.h:37:34: error: ‘vmemmap’ undeclared (first use in this function); did you mean ‘mem_map’?
   37 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
      |                                  ^~~~~~~
./include/asm-generic/memory_model.h:65:21: note: in expansion of macro ‘__pfn_to_page’
   65 | #define pfn_to_page __pfn_to_page
      |                     ^~~~~~~~~~~~~
./arch/x86/include/asm/page.h:68:33: note: in expansion of macro ‘pfn_to_page’
   68 | #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
      |                                 ^~~~~~~~~~~
./include/linux/page_frag_cache.h:151:16: note: in expansion of macro ‘virt_to_page’
  151 |         return virt_to_page(va);
      |                ^~~~~~~~~~~~
./include/asm-generic/memory_model.h:37:34: note: each undeclared identifier is reported only once for each function it appears in
   37 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
      |                                  ^~~~~~~
./include/asm-generic/memory_model.h:65:21: note: in expansion of macro ‘__pfn_to_page’
   65 | #define pfn_to_page __pfn_to_page
      |                     ^~~~~~~~~~~~~
./arch/x86/include/asm/page.h:68:33: note: in expansion of macro ‘pfn_to_page’
   68 | #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
      |                                 ^~~~~~~~~~~
./include/linux/page_frag_cache.h:151:16: note: in expansion of macro ‘virt_to_page’
  151 |         return virt_to_page(va);


Another possible way I can think of to aovid the above problem is to
split the page_frag_cache.h to something like page_frag_cache/types.h
and page_frag_cache/helpers.h as page_pool does, so that sched.h only
need to include page_frag_cache/types.h.
But I am not sure it is the correct way or it is worth the effort, what
do you think about this?

> 
> .
> 

