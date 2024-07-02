Return-Path: <netdev+bounces-108451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF1923DDA
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51271C24899
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD7171E60;
	Tue,  2 Jul 2024 12:28:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61A15CD7A;
	Tue,  2 Jul 2024 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923330; cv=none; b=QeUORDxJKDcUAb/0pb1B2j3mkminOf4aFi+aR1EGoB93dxAIpYo7VijraoOJZvkj/P026HHBrB94ajRO0lUIRzm/+UjpmbQ6BiCb99MfYzDfUkp+T9qLR/uZz8XUqkZcToNHSCCd3ba4aXhtr3K7F652hMDDFBTy3Hz2ojfBlKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923330; c=relaxed/simple;
	bh=O/fFJvf7yfrAM2sSNiI5YSjh0/0/XRYmc8TSpfAKlhY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XBYrwKoRBbIMYvhTWDNst73n241LAIv+OjqNgxVyZUIDHdHnV0iFrAYDYwQGgoq6PadBaamuhS1x+/EgwluXSdGbY3YgH0G8XElmMH4D5gD1JVqmoWVkjeBYSctYvac+1OhSUkFWadpL8+oS8JIMYtJ64WFHGYYt3NWXjhvwmtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WD2D81rGszQk09;
	Tue,  2 Jul 2024 20:24:56 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FB66140134;
	Tue,  2 Jul 2024 20:28:43 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 2 Jul
 2024 20:28:43 +0800
Subject: Re: [PATCH net-next v9 03/13] mm: page_frag: use initial zero offset
 for page_frag_alloc_align()
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-4-linyunsheng@huawei.com>
 <8e80507c685be94256e0e457ee97622c4487716c.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <01dc5b5a-bddf-bd2d-220c-478be6b62924@huawei.com>
Date: Tue, 2 Jul 2024 20:28:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8e80507c685be94256e0e457ee97622c4487716c.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/2 7:27, Alexander H Duyck wrote:
> On Tue, 2024-06-25 at 21:52 +0800, Yunsheng Lin wrote:
>> We are above to use page_frag_alloc_*() API to not just
> "about to use", not "above to use"

Ack.

> 
>> allocate memory for skb->data, but also use them to do
>> the memory allocation for skb frag too. Currently the
>> implementation of page_frag in mm subsystem is running
>> the offset as a countdown rather than count-up value,
>> there may have several advantages to that as mentioned
>> in [1], but it may have some disadvantages, for example,
>> it may disable skb frag coaleasing and more correct cache
>> prefetching
>>

...

>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>> index 88f567ef0e29..da244851b8a4 100644
>> --- a/mm/page_frag_cache.c
>> +++ b/mm/page_frag_cache.c
>> @@ -72,10 +72,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>  		if (!page)
>>  			return NULL;
>>  
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> -		/* if size can vary use size else just use PAGE_SIZE */
>> -		size = nc->size;
>> -#endif
>>  		/* Even if we own the page, we do not use atomic_set().
>>  		 * This would break get_page_unless_zero() users.
>>  		 */
>> @@ -84,11 +80,16 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>  		/* reset page count bias and offset to start of new frag */
>>  		nc->pfmemalloc = page_is_pfmemalloc(page);
>>  		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>> -		nc->offset = size;
>> +		nc->offset = 0;
>>  	}
>>  
>> -	offset = nc->offset - fragsz;
>> -	if (unlikely(offset < 0)) {
>> +#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> +	/* if size can vary use size else just use PAGE_SIZE */
>> +	size = nc->size;
>> +#endif
>> +
>> +	offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
>> +	if (unlikely(offset + fragsz > size)) {
> 
> The fragsz check below could be moved to here.
> 
>>  		page = virt_to_page(nc->va);
>>  
>>  		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>> @@ -99,17 +100,13 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>  			goto refill;
>>  		}
>>  
>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>> -		/* if size can vary use size else just use PAGE_SIZE */
>> -		size = nc->size;
>> -#endif
>>  		/* OK, page count is 0, we can safely set it */
>>  		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>>  
>>  		/* reset page count bias and offset to start of new frag */
>>  		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>> -		offset = size - fragsz;
>> -		if (unlikely(offset < 0)) {
>> +		offset = 0;
>> +		if (unlikely(fragsz > PAGE_SIZE)) {
> 
> Since we aren't taking advantage of the flag that is left after the
> subtraction we might just want to look at moving this piece up to just
> after the offset + fragsz check. That should prevent us from trying to
> refill if we have a request that is larger than a single page. In
> addition we could probably just drop the 3 PAGE_SIZE checks above as
> they would be redundant.

I am not sure I understand the 'drop the 3 PAGE_SIZE checks' part and
the 'redundant' part, where is the '3 PAGE_SIZE checks'? And why they
are redundant?

> 
>>  			/*
>>  			 * The caller is trying to allocate a fragment
>>  			 * with fragsz > PAGE_SIZE but the cache isn't big
>> @@ -124,8 +121,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>  	}
>>  
>>  	nc->pagecnt_bias--;
>> -	offset &= align_mask;
>> -	nc->offset = offset;
>> +	nc->offset = offset + fragsz;
>>  
>>  	return nc->va + offset;
>>  }
> 
> 
> .
> 

