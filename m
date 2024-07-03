Return-Path: <netdev+bounces-108834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA742925DFD
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D281C230AC
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206E8176FBB;
	Wed,  3 Jul 2024 11:25:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AAE176ADB;
	Wed,  3 Jul 2024 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005923; cv=none; b=j1NDOW0jJ+boLjgKbuL/YP1k5n1dXfGlQAL7Z+Sz/eCFfZYellaUqNxMeN+rwW98+o/aPLXYhIAKk1J9xEJ6zqRfDzTnZIc7eqmI1y0xL8KyyS/SlerSalcMNfQrslZIUbYC8hKNyo8IUAD23JK8l8kZOwrBX1tbF9Ke8fs1Ck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005923; c=relaxed/simple;
	bh=V8JyUCSg0gsZSWCO61bmxtCZLrVxKe40nDSLvdZ1wJQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=obiRolbk0hjkj74QJ32MOzTXxG5KfEKCGh/P5g4kKZBxUtlR81Heo/qjH927q8+bIJK4ls2ZhruF/k1IqvwIvxxkX8wqOKEaYX/yNcpkY4dDJBiiAtm2bBHvMMIB/fn0lxWpxIDsKZuA/WQvCz31OY/cNs8dMvbVCzv5lx/pgPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WDcrX2cW3znZ3G;
	Wed,  3 Jul 2024 19:25:00 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 48681180088;
	Wed,  3 Jul 2024 19:25:17 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Jul
 2024 19:25:17 +0800
Subject: Re: [PATCH net-next v9 03/13] mm: page_frag: use initial zero offset
 for page_frag_alloc_align()
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-4-linyunsheng@huawei.com>
 <8e80507c685be94256e0e457ee97622c4487716c.camel@gmail.com>
 <01dc5b5a-bddf-bd2d-220c-478be6b62924@huawei.com>
 <CAKgT0Ud-q-Z-ri0FQxdsHQegf1daVATEg3bKhs0cavQBcxwieg@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <5b385269-bcf0-6bba-e2cf-e714fbd2b334@huawei.com>
Date: Wed, 3 Jul 2024 19:25:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ud-q-Z-ri0FQxdsHQegf1daVATEg3bKhs0cavQBcxwieg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/3 0:00, Alexander Duyck wrote:

...

>>>> +
>>>> +    offset = __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
>>>> +    if (unlikely(offset + fragsz > size)) {
>>>
>>> The fragsz check below could be moved to here.
>>>
>>>>              page = virt_to_page(nc->va);
>>>>
>>>>              if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>>>> @@ -99,17 +100,13 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>>>                      goto refill;
>>>>              }
>>>>
>>>> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
>>>> -            /* if size can vary use size else just use PAGE_SIZE */
>>>> -            size = nc->size;
>>>> -#endif
>>>>              /* OK, page count is 0, we can safely set it */
>>>>              set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
>>>>
>>>>              /* reset page count bias and offset to start of new frag */
>>>>              nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>>> -            offset = size - fragsz;
>>>> -            if (unlikely(offset < 0)) {
>>>> +            offset = 0;
>>>> +            if (unlikely(fragsz > PAGE_SIZE)) {
>>>
>>> Since we aren't taking advantage of the flag that is left after the
>>> subtraction we might just want to look at moving this piece up to just
>>> after the offset + fragsz check. That should prevent us from trying to
>>> refill if we have a request that is larger than a single page. In
>>> addition we could probably just drop the 3 PAGE_SIZE checks above as
>>> they would be redundant.
>>
>> I am not sure I understand the 'drop the 3 PAGE_SIZE checks' part and
>> the 'redundant' part, where is the '3 PAGE_SIZE checks'? And why they
>> are redundant?
> 
> I was referring to the addition of the checks for align > PAGE_SIZE in
> the alloc functions at the start of this diff. I guess I had dropped
> them from the first half of it with the "...". Also looking back
> through the patch you misspelled "avoid" as "aovid".
> 
> The issue is there is a ton of pulling things forward that don't
> necessarily make sense into these diffs. Now that I have finished
> looking through the set I have a better idea of why those are there
> and they might make sense. It is just difficult to review since code
> is being added for things that aren't applicable to the patch being
> reviewed.

As you mentioned in other thread, perhaps the 'remaining' changing does
need to be incorporated into this patch.

> .
> 

