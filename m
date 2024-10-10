Return-Path: <netdev+bounces-134183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF4C998501
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D07B22A81
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9BD1C2430;
	Thu, 10 Oct 2024 11:32:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F38183CD9;
	Thu, 10 Oct 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559926; cv=none; b=VFNCGCSAME2bK7oUIGaNBKfVROdvb2z3/wm1RAer0CSTtR3JV4oxG/AApCdEAYZRQVnbyNHo5UEm6arE75w/18keq3b1fl20RUEEHUtwgJqJVQVGRBnE9pG2AkupqfgXoOuE4h++aGNqoUqQXnMKh8HSlUErtoBjAIgiAYDdqeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559926; c=relaxed/simple;
	bh=gPzDUJV3KuHc26ZbDdUjpL4o1pEXg7IvnfbuFERHNoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VJCY1GI71tYZBZSfOPc8vft4CZZKhBlRnh66AYa1QVTZHeNJpWZnjeUH7AHPyQB+V88FZVydzdFnIv8rwBJ28rde9Mj+EwwYDUmu4y5LyMpiyfy4t9NQJfNXdMkXGkjhR57dqA9m+CGnLHIqdNLGk6ETM1B+x9Cn6w2ZewkjrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XPSGd2tJSzpWgV;
	Thu, 10 Oct 2024 19:30:01 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F39FD18010F;
	Thu, 10 Oct 2024 19:32:00 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 19:32:00 +0800
Message-ID: <8bc47d27-b8ea-4573-937a-0056bdd8ea2c@huawei.com>
Date: Thu, 10 Oct 2024 19:32:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 06/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
 <20241008112049.2279307-7-linyunsheng@huawei.com>
 <CAKgT0UdgoyE0BzZoyXzxWYtAakJGWKORSZ25LbO1-=Q_Stiq9w@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UdgoyE0BzZoyXzxWYtAakJGWKORSZ25LbO1-=Q_Stiq9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/10 7:50, Alexander Duyck wrote:

...

>> +
>> +#define PAGE_FRAG_CACHE_PFMEMALLOC_BIT         (PAGE_FRAG_CACHE_ORDER_MASK + 1)
>> +
>> +static inline bool page_frag_encoded_page_pfmemalloc(unsigned long encoded_page)
>> +{
>> +       return !!(encoded_page & PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
>> +}
>> +
> 
> Rather than calling this encoded_page_pfmemalloc you might just go
> with decode_pfmemalloc. Also rather than passing the unsigned long we
> might just want to pass the page_frag_cache pointer.
As the page_frag_encoded_page_pfmemalloc() is also called in
__page_frag_alloc_align(), and __page_frag_alloc_align() uses a
local variable for 'nc->encoded_page' to avoid fetching from
page_frag_cache pointer multi-times, so passing an 'unsigned long'
is perferred here?

I am not sure if decode_pfmemalloc() is simple enough that it
might be conflicted with naming from other subsystem in the
future. I thought about adding a '__' prefix to it, but the naming
seems long enough that some inline helper' naming is over 80 characters.

> 
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
>>  }
>>
>>  void page_frag_cache_drain(struct page_frag_cache *nc);
>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>> index 4c8e04379cb3..4bff4de58808 100644
>> --- a/mm/page_frag_cache.c
>> +++ b/mm/page_frag_cache.c
>> @@ -12,6 +12,7 @@
>>   * be used in the "frags" portion of skb_shared_info.
>>   */
>>
>> +#include <linux/build_bug.h>
>>  #include <linux/export.h>
>>  #include <linux/gfp_types.h>
>>  #include <linux/init.h>
>> @@ -19,9 +20,41 @@
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
>> +               ((unsigned long)pfmemalloc * PAGE_FRAG_CACHE_PFMEMALLOC_BIT);
>> +}
>> +
>> +static unsigned long page_frag_encoded_page_order(unsigned long encoded_page)
>> +{
>> +       return encoded_page & PAGE_FRAG_CACHE_ORDER_MASK;
>> +}
>> +
>> +static void *page_frag_encoded_page_address(unsigned long encoded_page)
>> +{
>> +       return (void *)(encoded_page & PAGE_MASK);
>> +}
>> +
>> +static struct page *page_frag_encoded_page_ptr(unsigned long encoded_page)
>> +{
>> +       return virt_to_page((void *)encoded_page);
>> +}
>> +
> 
> Same with these. Instead of calling it encoded_page_XXX we could
> probably just go with decode_page, decode_order, and decode_address.
> Also instead of passing an unsigned long it would make more sense to
> be passing the page_frag_cache pointer, especially once you start
> pulling these out of this block.

For the not passing the page_frag_cache pointer part, it is the same
as above, it is mainly to avoid fetching from pointer multi-times.

> 
> If you are wanting to just work with the raw unsigned long value in
> the file it might make more sense to drop the "page_frag_" prefix from
> it and just have functions for handling your "encoded_page_" value. In
> that case you might rename page_frag_encode_page to
> "encoded_page_encode" or something like that.

It am supposing you meant 'encoded_page_decode' here instead of
"encoded_page_encode"?
Something like below?
encoded_page_decode_pfmemalloc()
encoded_page_decode_order()
encoded_page_decode_page()
encoded_page_decode_virt()

> 
> 

