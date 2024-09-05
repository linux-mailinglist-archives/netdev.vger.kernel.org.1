Return-Path: <netdev+bounces-125521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4BC96D80D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3579E1C21C2B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2469E199225;
	Thu,  5 Sep 2024 12:13:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966CC179654;
	Thu,  5 Sep 2024 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538401; cv=none; b=glHJKVZFymIsxx1QsLNmbDfhkjOy6lkemZoArfY4oVbSUxQFBRABeLhLeMQPw8lJhYeG9bOd10x6LmGNiStI0ne2Ht2syfSzN2b2+vjJILc/CKVPKtu+2LbscsJN+8Jt082d8sCDrAapYJPsO87Zk0YCzxRFwPIy7Me5XKAC7u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538401; c=relaxed/simple;
	bh=LiroZjAhJDa4RLzEQMesHLxlmeApIdE0IUNZrI4IrcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tzO2MSEGRmBPOB+yEElW5t+C7AHZ5PQ1innS0VtKKne6rBebc/fy71ZQBJt7gnneo8Tz62KK9w0jdI/oiQpgFvZ7UBKPDzJKSJyg8HcIxk73/PYZAgMfjXrurhU3NNiBQgn9Hdx0JpVUQx+Y3fYx3sL0VDUnJKC7/M/F9ssQz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WzysV5RSTz1P7SQ;
	Thu,  5 Sep 2024 20:12:14 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B655140109;
	Thu,  5 Sep 2024 20:13:13 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Sep 2024 20:13:13 +0800
Message-ID: <2cf46afa-9e80-4f34-a734-22009e277cc2@huawei.com>
Date: Thu, 5 Sep 2024 20:13:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 06/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240902120314.508180-1-linyunsheng@huawei.com>
 <20240902120314.508180-7-linyunsheng@huawei.com>
 <CAKgT0UeYy_tpbRx9C1oDNY+G9fKzsh1eoHfVg6GmFD7z-LziBw@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UeYy_tpbRx9C1oDNY+G9fKzsh1eoHfVg6GmFD7z-LziBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/5 0:14, Alexander Duyck wrote:
> On Mon, Sep 2, 2024 at 5:09 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
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
>> After this patch, the size of 'struct page_frag_cache' should be
>> the same as the size of 'struct page_frag'.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  include/linux/mm_types_task.h   | 19 +++++-----
>>  include/linux/page_frag_cache.h | 47 ++++++++++++++++++++++--
>>  mm/page_frag_cache.c            | 63 +++++++++++++++++++++------------
>>  3 files changed, 96 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
>> index cdc1e3696439..73a574a0e8f9 100644
>> --- a/include/linux/mm_types_task.h
>> +++ b/include/linux/mm_types_task.h
>> @@ -50,18 +50,21 @@ struct page_frag {
>>  #define PAGE_FRAG_CACHE_MAX_SIZE       __ALIGN_MASK(32768, ~PAGE_MASK)
>>  #define PAGE_FRAG_CACHE_MAX_ORDER      get_order(PAGE_FRAG_CACHE_MAX_SIZE)
>>  struct page_frag_cache {
>> -       void *va;
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> +       /* encoded_page consists of the virtual address, pfmemalloc bit and
>> +        * order of a page.
>> +        */
>> +       unsigned long encoded_page;
>> +
>> +       /* we maintain a pagecount bias, so that we dont dirty cache line
>> +        * containing page->_refcount every time we allocate a fragment.
>> +        */
>> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
>>         __u16 offset;
>> -       __u16 size;
>> +       __u16 pagecnt_bias;
>>  #else
>>         __u32 offset;
>> +       __u32 pagecnt_bias;
>>  #endif
>> -       /* we maintain a pagecount bias, so that we dont dirty cache line
>> -        * containing page->_refcount every time we allocate a fragment.
>> -        */
>> -       unsigned int            pagecnt_bias;
>> -       bool pfmemalloc;
>>  };
>>
>>  /* Track pages that require TLB flushes */
>> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
>> index 0a52f7a179c8..cb89cd792fcc 100644
>> --- a/include/linux/page_frag_cache.h
>> +++ b/include/linux/page_frag_cache.h
>> @@ -3,18 +3,61 @@
>>  #ifndef _LINUX_PAGE_FRAG_CACHE_H
>>  #define _LINUX_PAGE_FRAG_CACHE_H
>>
>> +#include <linux/bits.h>
>>  #include <linux/log2.h>
>> +#include <linux/mm.h>
>>  #include <linux/mm_types_task.h>
>>  #include <linux/types.h>
>>
>> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> +/* Use a full byte here to enable assembler optimization as the shift
>> + * operation is usually expecting a byte.
>> + */
>> +#define PAGE_FRAG_CACHE_ORDER_MASK             GENMASK(7, 0)
>> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT       8
>> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         BIT(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT)
>> +#else
>> +/* Compiler should be able to figure out we don't read things as any value
>> + * ANDed with 0 is 0.
>> + */
>> +#define PAGE_FRAG_CACHE_ORDER_MASK             0
>> +#define PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT       0
>> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         BIT(PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT)
>> +#endif
>> +
>> +static inline unsigned long page_frag_encoded_page_order(unsigned long encoded_page)
>> +{
>> +       return encoded_page & PAGE_FRAG_CACHE_ORDER_MASK;
>> +}
>> +
>> +static inline bool page_frag_encoded_page_pfmemalloc(unsigned long encoded_page)
>> +{
>> +       return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
>> +}
>> +
>> +static inline void *page_frag_encoded_page_address(unsigned long encoded_page)
>> +{
>> +       return (void *)(encoded_page & PAGE_MASK);
>> +}
>> +
>> +static inline struct page *page_frag_encoded_page_ptr(unsigned long encoded_page)
>> +{
>> +       return virt_to_page((void *)encoded_page);
>> +}
>> +
>>  static inline void page_frag_cache_init(struct page_frag_cache *nc)
>>  {
>> -       nc->va = NULL;
>> +       nc->encoded_page = 0;
>>  }
>>
>>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
>>  {
>> -       return !!nc->pfmemalloc;
>> +       return page_frag_encoded_page_pfmemalloc(nc->encoded_page);
>> +}
>> +
>> +static inline unsigned int page_frag_cache_page_size(unsigned long encoded_page)
>> +{
>> +       return PAGE_SIZE << page_frag_encoded_page_order(encoded_page);
>>  }
>>
>>  void page_frag_cache_drain(struct page_frag_cache *nc);
> 
> Still not a huge fan of adding all these functions that expose the
> internals. It might be better to just place them in page_frag_cache.c
> and pull them out to the .h file as needed.

Are you suggesting to move the above to page_frag_cache.c, and move
it back to page_frag_cache.h if needed in the following patch of the
same patchset?

Or are you really preferring not to expose any internals over the
performance here and thinking the moving them back to .h file is
unneeded?

> 
>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>> index 4c8e04379cb3..a5c5373cb70e 100644
>> --- a/mm/page_frag_cache.c
>> +++ b/mm/page_frag_cache.c
>> @@ -12,16 +12,28 @@
>>   * be used in the "frags" portion of skb_shared_info.
>>   */
>>
>> +#include <linux/build_bug.h>
>>  #include <linux/export.h>
>>  #include <linux/gfp_types.h>
>>  #include <linux/init.h>
>> -#include <linux/mm.h>
>>  #include <linux/page_frag_cache.h>
>>  #include "internal.h"
>>
>> +static unsigned long page_frag_encode_page(struct page *page, unsigned int order,
>> +                                          bool pfmemalloc)
>> +{
>> +       BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MASK);
>> +       BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_BIT >= PAGE_SIZE);
>> +
>> +       return (unsigned long)page_address(page) |
>> +               (order & PAGE_FRAG_CACHE_ORDER_MASK) |
>> +               ((unsigned long)pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
>> +}
>> +
>>  static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>                                              gfp_t gfp_mask)
>>  {
>> +       unsigned long order = PAGE_FRAG_CACHE_MAX_ORDER;
>>         struct page *page = NULL;
>>         gfp_t gfp = gfp_mask;
>>
>> @@ -30,23 +42,31 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>                    __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>>         page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>>                                 PAGE_FRAG_CACHE_MAX_ORDER);
>> -       nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
>>  #endif
>> -       if (unlikely(!page))
>> +       if (unlikely(!page)) {
>>                 page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
>> +               if (unlikely(!page)) {
>> +                       nc->encoded_page = 0;
>> +                       return NULL;
>> +               }
> 
> I would recommend just skipping the conditional here. No need to do
> that. You can basically just not encode the page below if you failed
> to allocate it.
> 
>> +
>> +               order = 0;
>> +       }
>>
>> -       nc->va = page ? page_address(page) : NULL;
>> +       nc->encoded_page = page_frag_encode_page(page, order,
>> +                                                page_is_pfmemalloc(page));
> 
> I would just follow the same logic with the ternary operator here. If
> page is set then encode the page, else just set it to 0.

I am assuming you meant somethig like below, right?

static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
					     gfp_t gfp_mask)
{
	unsigned long order = PAGE_FRAG_CACHE_MAX_ORDER;
	struct page *page = NULL;
	gfp_t gfp = gfp_mask;

#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
		    __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
	page = __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
			     numa_mem_id(), NULL);
#endif
	if (unlikely(!page)) {
		page = __alloc_pages(gfp, 0, numa_mem_id(), NULL);
		order = 0;
	}

	nc->encoded_page = page ?
		page_frag_encode_page(page, order, page_is_pfmemalloc(page)) : 0;

        return page;
}

> 
>>
>>         return page;
>>  }
>>
>>  void page_frag_cache_drain(struct page_frag_cache *nc)
>>  {
>> -       if (!nc->va)
>> +       if (!nc->encoded_page)
>>                 return;
>>
>> -       __page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
>> -       nc->va = NULL;
>> +       __page_frag_cache_drain(page_frag_encoded_page_ptr(nc->encoded_page),
>> +                               nc->pagecnt_bias);
>> +       nc->encoded_page = 0;
>>  }
>>  EXPORT_SYMBOL(page_frag_cache_drain);
>>
>> @@ -63,31 +83,27 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>                               unsigned int fragsz, gfp_t gfp_mask,
>>                               unsigned int align_mask)
>>  {
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> -       unsigned int size = nc->size;
>> -#else
>> -       unsigned int size = PAGE_SIZE;
>> -#endif
>> -       unsigned int offset;
>> +       unsigned long encoded_page = nc->encoded_page;
>> +       unsigned int size, offset;
>>         struct page *page;
>>
>> -       if (unlikely(!nc->va)) {
>> +       size = page_frag_cache_page_size(encoded_page);
>> +
>> +       if (unlikely(!encoded_page)) {
>>  refill:
>>                 page = __page_frag_cache_refill(nc, gfp_mask);
>>                 if (!page)
>>                         return NULL;
>>
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> -               /* if size can vary use size else just use PAGE_SIZE */
>> -               size = nc->size;
>> -#endif
>> +               encoded_page = nc->encoded_page;
>> +               size = page_frag_cache_page_size(encoded_page);
>> +
>>                 /* Even if we own the page, we do not use atomic_set().
>>                  * This would break get_page_unless_zero() users.
>>                  */
>>                 page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
>>
>>                 /* reset page count bias and offset to start of new frag */
>> -               nc->pfmemalloc = page_is_pfmemalloc(page);
>>                 nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>                 nc->offset = 0;
>>         }
> 
> It would probably make sense to move the getting of the size to just
> after this if statement since you are doing it in two different paths
> and I don't think you use size at all in the
> "if(unlikely(!encoded_page))" path otherwise.

Ack.

