Return-Path: <netdev+bounces-122746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE1996269E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45491F237BB
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A54173320;
	Wed, 28 Aug 2024 12:12:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C8F172BDC;
	Wed, 28 Aug 2024 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847170; cv=none; b=NDFhIq4A0XtBhx5vx5rMG75goySUm+4K0hz5/N2Y/uX9qqEhOm1cSQ3xObcfokIRBHxoyxXKoOLlmdGAbSbxauUCNwbKc2TdzXIaMAcRX9+uKSRTq8qcSTblTYFm35PuSfgAlhV1PaCGEQOfQ/hdRNp7YCCWRbUo+HQGCGKEpUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847170; c=relaxed/simple;
	bh=3tK3XP9eaoRWp2CsV0xK++e4PqhPlJcXiz3LEX4J3/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qVohTxfyhaxYshOOsFvtw8lR1N4opDRk2ibAuDPTDeycqZnVN8Zp8usbU+2DaTQptM4lkib6Uzp+eDyf85FfrKF158XLaIajHkQ8df64vAbom92QIcRjrqtSVy89U/Wvxie3v/s3DxafBTCxKHoYxC1yRuK53ftjI7QRvQWPlyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wv3FY2kH9z1S9H3;
	Wed, 28 Aug 2024 20:12:33 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DC201A016C;
	Wed, 28 Aug 2024 20:12:45 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Aug 2024 20:12:44 +0800
Message-ID: <08bd1189-2dac-4a28-a267-81a696b0f7cb@huawei.com>
Date: Wed, 28 Aug 2024 20:12:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 07/13] mm: page_frag: some minor refactoring
 before adding new API
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240826124021.2635705-1-linyunsheng@huawei.com>
 <20240826124021.2635705-8-linyunsheng@huawei.com>
 <CAKgT0UcD7BqqQiEzuZUh9CEy4=pPHqWHwD5NGNtckk3HFx2DNw@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UcD7BqqQiEzuZUh9CEy4=pPHqWHwD5NGNtckk3HFx2DNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/28 0:00, Alexander Duyck wrote:
> On Mon, Aug 26, 2024 at 5:46 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> Refactor common codes from __page_frag_alloc_va_align() to
>> __page_frag_cache_prepare() and __page_frag_cache_commit(),
>> so that the new API can make use of them.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  include/linux/page_frag_cache.h | 51 +++++++++++++++++++++++++++++++--
>>  mm/page_frag_cache.c            | 20 ++++++-------
>>  2 files changed, 59 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
>> index 372d6ed7e20a..2cc18a525936 100644
>> --- a/include/linux/page_frag_cache.h
>> +++ b/include/linux/page_frag_cache.h
>> @@ -7,6 +7,7 @@
>>  #include <linux/build_bug.h>
>>  #include <linux/log2.h>
>>  #include <linux/mm.h>
>> +#include <linux/mmdebug.h>
>>  #include <linux/mm_types_task.h>
>>  #include <linux/types.h>
>>
>> @@ -75,8 +76,54 @@ static inline unsigned int page_frag_cache_page_size(unsigned long encoded_page)
>>
>>  void page_frag_cache_drain(struct page_frag_cache *nc);
>>  void __page_frag_cache_drain(struct page *page, unsigned int count);
>> -void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
>> -                             gfp_t gfp_mask, unsigned int align_mask);
>> +void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
>> +                               struct page_frag *pfrag, gfp_t gfp_mask,
>> +                               unsigned int align_mask);
>> +
>> +static inline void __page_frag_cache_commit(struct page_frag_cache *nc,
>> +                                           struct page_frag *pfrag, bool referenced,
>> +                                           unsigned int used_sz)
>> +{
>> +       if (referenced) {
>> +               VM_BUG_ON(!nc->pagecnt_bias);
>> +               nc->pagecnt_bias--;
>> +       }
>> +
>> +       VM_BUG_ON(used_sz > pfrag->size);
>> +       VM_BUG_ON(pfrag->page != page_frag_encoded_page_ptr(nc->encoded_page));
>> +
>> +       /* nc->offset is not reset when reusing an old page, so do not check for the
>> +        * first fragment.
>> +        * Committed offset might be bigger than the current offset due to alignment
>> +        */
> 
> nc->offset should be reset when you are allocating a new page. I would

It is reset when a new page is allocated, but not when reusing a old page.

> suggest making that change as you should be able to verify that the
> fragment you are working with contains the frag you are working with.
> The page and offset should essentially be equal.

For the part why offset is not equal, currently we do the alignment for
local variable 'offset' and set it to pfrag->offset instead of nc->offset
in below __page_frag_cache_prepare().

> 
>> +       VM_BUG_ON(pfrag->offset && nc->offset > pfrag->offset);
>> +       VM_BUG_ON(pfrag->offset &&
>> +                 pfrag->offset + pfrag->size > page_frag_cache_page_size(nc->encoded_page));
>> +
>> +       pfrag->size = used_sz;
>> +
>> +       /* Calculate true size for the fragment due to alignment, nc->offset is not
>> +        * reset for the first fragment when reusing an old page.
>> +        */
>> +       pfrag->size += pfrag->offset ? (pfrag->offset - nc->offset) : 0;
> 
> The pfrag->size should be the truesize already. You should have stored
> it as fragsz so that all you really need to do is push the offset
> forward by pfrag->size.

The general idea is below:
The pfrag->size is set to indicate the max available cache of page_frag_cache
when caller calls __page_frag_cache_prepare(), after deciding how much cache
to use, the caller calls __page_frag_cache_commit() with 'used_sz', and
__page_frag_cache_commit() returns the true size back to the caller by
considering the offset alignment.

And the above is mainly used to support the prepare API in patch 10.

> 
>> +
>> +       nc->offset = pfrag->offset + used_sz;
>> +}
>> +
> 
> I think this function might be better to keep in the .c file versus
> having it in the header file.
> 
> ...
> 
>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>> index 228cff9a4cdb..bba59c87d478 100644
>> --- a/mm/page_frag_cache.c
>> +++ b/mm/page_frag_cache.c
>> @@ -67,16 +67,14 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
>>  }
>>  EXPORT_SYMBOL(__page_frag_cache_drain);
>>
>> -void *__page_frag_alloc_align(struct page_frag_cache *nc,
>> -                             unsigned int fragsz, gfp_t gfp_mask,
>> -                             unsigned int align_mask)
>> +void *__page_frag_cache_prepare(struct page_frag_cache *nc, unsigned int fragsz,
>> +                               struct page_frag *pfrag, gfp_t gfp_mask,
>> +                               unsigned int align_mask)
>>  {
>>         unsigned long encoded_page = nc->encoded_page;
>>         unsigned int size, offset;
> 
> The 3 changes below can all be dropped. They are unnecessary
> optimizations of the unlikely path.
> 
>>         struct page *page;
>>
>> -       size = page_frag_cache_page_size(encoded_page);
>> -
>>         if (unlikely(!encoded_page)) {
>>  refill:
>>                 page = __page_frag_cache_refill(nc, gfp_mask);
>> @@ -94,6 +92,9 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>                 /* reset page count bias and offset to start of new frag */
>>                 nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>                 nc->offset = 0;
> 
> Your code above said that offset wasn't reset. But it looks like it is
> reset here isn't it?

This is refilling a new page for page_frag_cache, not reusing a old page for
page_frag_cache as mentioned above, nc->offset not being reset is in below:

https://elixir.free-electrons.com/linux/v6.11-rc5/source/mm/page_alloc.c#L4902

> 
>> +       } else {
>> +               size = page_frag_cache_page_size(encoded_page);
>> +               page = page_frag_encoded_page_ptr(encoded_page);
>>         }
>>
>>         offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
>> @@ -111,8 +112,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>                         return NULL;
>>                 }
>>
>> -               page = page_frag_encoded_page_ptr(encoded_page);
>> -
>>                 if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>>                         goto refill;
>>
> 
> These 3 changes to move the size and page are unnecessary
> optimization. I would recommend just dropping them and leave the code
> as is as you are just optimizing for unlikely paths.

It is not an optimization, the page need to be set to pfrag->page in this
patch, and page_frag_encoded_page_ptr() is only called when refill a new
page and reusing a old page before this patch, the above changes enable the
calling of page_frag_encoded_page_ptr() for all cases in this patch.

> 
>> @@ -130,12 +129,13 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>                 offset = 0;
>>         }
>>
>> -       nc->pagecnt_bias--;
>> -       nc->offset = offset + fragsz;
>> +       pfrag->page = page;
>> +       pfrag->offset = offset;
>> +       pfrag->size = size - offset;
> 
> Why are you subtracting the offset from the size? Shouldn't this just be fragsz?

As above, it is about supporting the prepare API in patch 10.

> 
>>
>>         return page_frag_encoded_page_address(encoded_page) + offset;
>>  }
>> -EXPORT_SYMBOL(__page_frag_alloc_align);
>> +EXPORT_SYMBOL(__page_frag_cache_prepare);
>>
>>  /*
>>   * Frees a page fragment allocated out of either a compound or order 0 page.
>> --
>> 2.33.0
>>

