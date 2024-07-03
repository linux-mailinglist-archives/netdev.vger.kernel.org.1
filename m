Return-Path: <netdev+bounces-108851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF69926079
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A042C1C21CAC
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD69176ABB;
	Wed,  3 Jul 2024 12:36:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3D176255;
	Wed,  3 Jul 2024 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010169; cv=none; b=K9onwRaG6s/r1Us25VSbqtjLwm1wXEywIEAatbpiVl5UG95mQY/s+IyN1eT96TocKfvja31rOTztYoLunTcAzyI4ObgDk6XEHOQEI+7PfbDHls3yR0dJR9tI1vT9CInNmjcHgxq2I4eto5uKGjm0h3wa57Rq2Fdo2mKimrtCllo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010169; c=relaxed/simple;
	bh=yY64PjcKHGe2LA/qnYBJLLgIK2uJmMMYRq8Oig0HjkE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SLhYw0Ol6X4SYUXazdst3VqZujYp4dUtLT9+0ZOO385IJzM6UAYaHmHoHgvz0J84Y72kDtXquZRBfGC75l5Wr4x0maNyR6V8v6Z9KLs4zT5PMNtmmE6hHlzfSwLtVKNVcbZBbL1kNCal01Brj8PMX6EXVwHA2GiRlFPGmaVaDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WDfL73ypgzQk7y;
	Wed,  3 Jul 2024 20:32:15 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C14EC18006C;
	Wed,  3 Jul 2024 20:36:03 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Jul
 2024 20:36:03 +0800
Subject: Re: [PATCH net-next v9 07/13] mm: page_frag: some minor refactoring
 before adding new API
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-8-linyunsheng@huawei.com>
 <ce969484bc8deee1438a019f19b97618937b0047.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <3f816006-2949-e81a-be6f-b0b63322a1d5@huawei.com>
Date: Wed, 3 Jul 2024 20:36:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ce969484bc8deee1438a019f19b97618937b0047.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/2 23:30, Alexander H Duyck wrote:
> On Tue, 2024-06-25 at 21:52 +0800, Yunsheng Lin wrote:
>> Refactor common codes from __page_frag_alloc_va_align()
>> to __page_frag_cache_refill(), so that the new API can
>> make use of them.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> 
> I am generally not a fan of the concept behind this patch. I really
> think we should keep the page_frag_cache_refill function to just
> allocating the page, or in this case the encoded_va and populating only
> that portion of the struct.

As my understanding, the above mainly depends on how you look at it,
at least it seems odd to me that part of a struct is populated in
one function and other part of the same struct is populated in other
function.

> 
>> ---
>>  mm/page_frag_cache.c | 61 ++++++++++++++++++++++----------------------
>>  1 file changed, 31 insertions(+), 30 deletions(-)
>>
>> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
>> index a3316dd50eff..4fd421d4f22c 100644
>> --- a/mm/page_frag_cache.c
>> +++ b/mm/page_frag_cache.c
>> @@ -29,10 +29,36 @@ static void *page_frag_cache_current_va(struct page_frag_cache *nc)
>>  static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>>  					     gfp_t gfp_mask)
>>  {
>> -	struct page *page = NULL;
>> +	struct encoded_va *encoded_va = nc->encoded_va;
>>  	gfp_t gfp = gfp_mask;
>>  	unsigned int order;
>> +	struct page *page;
>> +
>> +	if (unlikely(!encoded_va))
>> +		goto alloc;
>> +
>> +	page = virt_to_page(encoded_va);
>> +	if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>> +		goto alloc;
>> +
>> +	if (unlikely(encoded_page_pfmemalloc(encoded_va))) {
>> +		VM_BUG_ON(compound_order(page) !=
>> +			  encoded_page_order(encoded_va));
>> +		free_unref_page(page, encoded_page_order(encoded_va));
>> +		goto alloc;
>> +	}
>> +
>> +	/* OK, page count is 0, we can safely set it */
>> +	set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
> 
> Why not just make this block of code a function onto itself? You put an
> if statement at the top that essentially is just merging two functions
> into one. Perhaps this logic could be __page_frag_cache_recharge which
> would return an error if the page is busy or the wrong type. Then
> acting on that you could switch to the refill attempt.
> 
> Also thinking about it more the set_page_count in this function and
> page_ref_add in the other can probably be merged into the recharge and
> refill functions since they are acting directly on the encoded page and
> not interacting with the other parts of the page_frag_cache.

So we are agreed that the below is merged into __page_frag_cache_recharge()?
set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;

The below is merged into __page_frag_cache_refill()?
page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;

> 
>> +
>> +	/* reset page count bias and remaining of new frag */
>> +	nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>> +	nc->remaining = page_frag_cache_page_size(encoded_va);
> 
> These two parts are more or less agnostic to the setup and could be
> applied to refill or recharge. Also one thought occurs to me. You were
> encoding "order" into the encoded VA. Why use that when your choices
> are either PAGE_FRAG_CACHE_MAX_SIZE or PAGE_SIZE. It should be a single
> bit and doesn't need to be a fully byte to store that. That would allow
> you to reduce this down to just 2 bits, one for pfmemalloc and one for
> max order vs order 0.

I thought about the above and implemented it actually, but it turned out
that it was not as good as encoding "order" into the encoded VA, at least
for the generated asm code size, it didn't seem better. Using one bit,
we need a checking to decide it is PAGE_FRAG_CACHE_MAX_SIZE or PAGE_SIZE.
And we can use that to replace compound_order(page) when calling
free_unref_page() too.

> 
>> +
>> +	return page;

