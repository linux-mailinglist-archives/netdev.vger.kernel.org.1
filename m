Return-Path: <netdev+bounces-122274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC73960991
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FE51C22565
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9F41A0737;
	Tue, 27 Aug 2024 12:06:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F41A071C;
	Tue, 27 Aug 2024 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760391; cv=none; b=i6QmFj49EOj8qEwtzZaV7la8Wd3FA8y7Pa26amxbHqSjy+u2Khpc82Xgjg/8CtejF7PEX49p6Shtlhbddpcb3y4BwKzGIlaJOEdEwByzrVPg4AzPjRKU1J6pcrh5pizDh3icdzfwZTJzDig4cpe+sl3KMYnQV+63pwltNLmHdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760391; c=relaxed/simple;
	bh=6YJq1hhwKp95TpEHIWxsqN/ZylP9QYdpHhh5SU/YxPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kP/4nu3Z2kJfArMYp1cn+SfNppVmZE13sAc7+OK0qQ/jf13Zwd+bX7aJRtNvjTDIccLVOrdklMRQ/aSCObQCV/xCtLeYyP9aAxM+iFbQW8NauOIBLidwi/S6rM+vDbQqWTbx5kwGEa7EfwuBd849sHY+y1FRiKZ9jBNSwmLhgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WtR8338KDz14DV3;
	Tue, 27 Aug 2024 20:05:39 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E7F4140137;
	Tue, 27 Aug 2024 20:06:26 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Aug 2024 20:06:25 +0800
Message-ID: <82be328d-8f04-417f-bdf2-e8c0f6f58057@huawei.com>
Date: Tue, 27 Aug 2024 20:06:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 06/13] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240826124021.2635705-1-linyunsheng@huawei.com>
 <20240826124021.2635705-7-linyunsheng@huawei.com>
 <CAKgT0Uc7tRi6uGTpx2n9_JAK+sbPg7QcOOOSLK+a41cFMcqCWg@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Uc7tRi6uGTpx2n9_JAK+sbPg7QcOOOSLK+a41cFMcqCWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/27 0:46, Alexander Duyck wrote:
> On Mon, Aug 26, 2024 at 5:46 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
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
>>  include/linux/mm_types_task.h   | 19 ++++++-----
>>  include/linux/page_frag_cache.h | 60 +++++++++++++++++++++++++++++++--
>>  mm/page_frag_cache.c            | 51 +++++++++++++++-------------
>>  3 files changed, 97 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
>> index cdc1e3696439..a8635460e027 100644
>> --- a/include/linux/mm_types_task.h
>> +++ b/include/linux/mm_types_task.h
>> @@ -50,18 +50,21 @@ struct page_frag {
>>  #define PAGE_FRAG_CACHE_MAX_SIZE       __ALIGN_MASK(32768, ~PAGE_MASK)
>>  #define PAGE_FRAG_CACHE_MAX_ORDER      get_order(PAGE_FRAG_CACHE_MAX_SIZE)
>>  struct page_frag_cache {
>> -       void *va;
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> +       /* encoded_page consists of the virtual address, pfmemalloc bit and order
>> +        * of a page.
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
>> index 0a52f7a179c8..372d6ed7e20a 100644
>> --- a/include/linux/page_frag_cache.h
>> +++ b/include/linux/page_frag_cache.h
>> @@ -3,18 +3,74 @@
>>  #ifndef _LINUX_PAGE_FRAG_CACHE_H
>>  #define _LINUX_PAGE_FRAG_CACHE_H
>>
>> +#include <linux/bits.h>
>> +#include <linux/build_bug.h>
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
>> +static inline unsigned long page_frag_encode_page(struct page *page,
>> +                                                 unsigned int order,
>> +                                                 bool pfmemalloc)
>> +{
>> +       BUILD_BUG_ON(PAGE_FRAG_CACHE_MAX_ORDER > PAGE_FRAG_CACHE_ORDER_MASK);
>> +       BUILD_BUG_ON(PAGE_FRAG_CACHE_PFMEMALLOC_BIT >= PAGE_SIZE);
>> +
>> +       return (unsigned long)page_address(page) |
>> +               (order & PAGE_FRAG_CACHE_ORDER_MASK) |
>> +               ((unsigned long)pfmemalloc << PAGE_FRAG_CACHE_PFMEMALLOC_SHIFT);
>> +}
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
> So how many of these additions are actually needed outside of the
> page_frag_cache.c file? I'm just wondering if we could look at moving

At least page_frag_cache_is_pfmemalloc(), page_frag_encoded_page_order(),
page_frag_encoded_page_ptr(), page_frag_encoded_page_address() are needed
out of the page_frag_cache.c file for now, which are used mostly in
__page_frag_cache_commit() and __page_frag_alloc_refill_probe_align() for
debugging and performance reason, see patch 7 & 10.

The only left one is page_frag_encode_page(), I am not sure if it makes
much sense to move it to page_frag_cache.c while the rest of them are in
.h file.

> most of these into the c file itself instead of making them accessible
> to all callers as I don't believe we currently have anyone looking
> into the size of the frag cache or anything like that and I would
> prefer to avoid exposing such functionality if possible. As the
> non-order0 allocation problem with this has pointed out people will
> exploit any interface exposed even if unintentionally.
> 
> I would want to move the size/order logic as well as splitting out the
> virtual address as we shouldn't be allowing the user to look at that
> without going through an allocation function.

I am generally agreed with the above argument if there are ways to do
that without sacrificing the above mentioned debugging and performance.

