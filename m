Return-Path: <netdev+bounces-93709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A49E8BCE03
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153DE28029C
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6381C695;
	Mon,  6 May 2024 12:34:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FE018C19;
	Mon,  6 May 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998844; cv=none; b=PSRMYV+ZLfKrbcvD7KgmYPwK2O84xwqm8Kj0m2rKkM0qp3Li+Ae5A0mvC218QH+V3lcdW4R3mm3u6caJp5MVzhWXqgaHeGsHmSjvB92HdNBop29UTR3PIcrFzxJB4Z5BrxAo/s2uu159nUenwPthWBaNnOX8IzHmL01JZRVdXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998844; c=relaxed/simple;
	bh=PgyTVlJCUcjAwmhhcUzIv+WBWnSQfv9IW0ppT4XeW48=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nnCDjpMMdZxW73RM4xMEpAz+oubStnHKkGGnmrXXqdoMBFyt1tKKw/9uS56DJRj6IBEMzBe7/H3V4vy1+uRJwkxqQuaT+ULPjT/oQAxJtBhMO8mPzZuvAotlbk4pNjkSq4QCE7QRZHtfsP5NuDBIOR5Nvtl7yoNADHMWshZGD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VY13k4Gv5zNw6b;
	Mon,  6 May 2024 20:31:14 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C073140134;
	Mon,  6 May 2024 20:33:59 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 6 May
 2024 20:33:58 +0800
Subject: Re: [PATCH net-next v2 09/15] mm: page_frag: reuse MSB of 'size'
 field for pfmemalloc
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-10-linyunsheng@huawei.com>
 <37d012438d4850c3d7090e784e09088d02a2780c.camel@gmail.com>
 <8b7361c2-6f45-72e8-5aca-92e8a41a7e5e@huawei.com>
 <17066b6a4f941eea3ef567767450b311096da22b.camel@gmail.com>
 <c45fdd75-44be-82a6-8e47-42bbc5ee4795@huawei.com>
 <efd21f1d-8c67-b060-5ad2-0d500fac2ba6@huawei.com>
 <CAKgT0UfQWEkaWM_mfk=FhCErTL_ZS3RL6x3iMzPdEP3FD+9zZQ@mail.gmail.com>
 <ceb36a97-31b5-62df-a216-8598210bbba8@huawei.com>
 <CAKgT0Ufm0=1cmyRLcrcu1_FAAeBokj3rpFAXJvVxgARXSStAuA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <a208cde1-41f2-c838-0bd1-a37d58f2179b@huawei.com>
Date: Mon, 6 May 2024 20:33:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ufm0=1cmyRLcrcu1_FAAeBokj3rpFAXJvVxgARXSStAuA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/30 22:54, Alexander Duyck wrote:
> On Tue, Apr 30, 2024 at 5:06 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/4/29 22:49, Alexander Duyck wrote:
>>
>> ...
>>
>>>>>
>>>>
>>>> After considering a few different layouts for 'struct page_frag_cache',
>>>> it seems the below is more optimized:
>>>>
>>>> struct page_frag_cache {
>>>>         /* page address & pfmemalloc & order */
>>>>         void *va;
>>>
>>> I see. So basically just pack the much smaller bitfields in here.
>>>
>>>>
>>>> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
>>>>         u16 pagecnt_bias;
>>>>         u16 size;
>>>> #else
>>>>         u32 pagecnt_bias;
>>>>         u32 size;
>>>> #endif
>>>> }
>>>>
>>>> The lower bits of 'va' is or'ed with the page order & pfmemalloc instead
>>>> of offset or pagecnt_bias, so that we don't have to add more checking
>>>> for handling the problem of not having enough space for offset or
>>>> pagecnt_bias for PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE and 32 bits system.
>>>> And page address & pfmemalloc & order is unchanged for the same page
>>>> in the same 'page_frag_cache' instance, it makes sense to fit them
>>>> together.
>>>>
>>>> Also, it seems it is better to replace 'offset' with 'size', which indicates
>>>> the remaining size for the cache in a 'page_frag_cache' instance, and we
>>>> might be able to do a single 'size >= fragsz' checking for the case of cache
>>>> being enough, which should be the fast path if we ensure size is zoro when
>>>> 'va' == NULL.
>>>
>>> I'm not sure the rename to size is called for as it is going to be
>>> confusing. Maybe something like "remaining"?
>>
>> Yes, using 'size' for that is a bit confusing.
>> Beside the above 'remaining', by googling, it seems we may have below
>> options too:
>> 'residual','unused', 'surplus'
>>
>>>
>>>> Something like below:
>>>>
>>>> #define PAGE_FRAG_CACHE_ORDER_MASK      GENMASK(1, 0)
>>>> #define PAGE_FRAG_CACHE_PFMEMALLOC_BIT  BIT(2)
>>>
>>> The only downside is that it is ossifying things so that we can only
>>
>> There is 12 bits that is always useful, we can always extend ORDER_MASK
>> to more bits if lager order number is needed.
>>
>>> ever do order 3 as the maximum cache size. It might be better to do a
>>> full 8 bytes as on x86 it would just mean accessing the low end of a
>>> 16b register. Then you can have pfmemalloc at bit 8.
>>
>> I am not sure I understand the above as it seems we may have below option:
>> 1. Use somthing like the above ORDER_MASK and PFMEMALLOC_BIT.
>> 2. Use bitfield as something like below:
>>
>> unsigned long va:20;---or 52 for 64bit system
>> unsigned long pfmemalloc:1
>> unsigned long order:11;
>>
>> Or is there a better idea in your mind?
> 
> All I was suggesting was to make the ORDER_MASK 8 bits. Doing that the
> compiler can just store VA in a register such as RCX and instead of
> having to bother with a mask it could then just use CL to access the
> order. As far as the flag bits such as pfmemalloc the 4 bits starting
> at 8 would make the most sense since it doesn't naturally align to
> anything and would have to be masked anyway.

Ok.

> 
> Using a bitfield like you suggest would be problematic as the compiler
> would assume a shift is needed so you would have to add a shift to
> your code to offset it for accessing VA.
> 
>>>
>>>> struct page_frag_cache {
>>>>         /* page address & pfmemalloc & order */
>>>>         void *va;
>>>>
>>>
>>> When you start combining things like this we normally would convert va
>>> to an unsigned long.
>>
>> Ack.

It seems it makes more sense to convert va to something like 'struct encoded_va'
mirroring 'struct encoded_page' in below:

https://elixir.bootlin.com/linux/v6.7-rc8/source/include/linux/mm_types.h#L222

>>
>>>
>>>> #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
>>>>         u16 pagecnt_bias;
>>>>         u16 size;
>>>> #else
>>>>         u32 pagecnt_bias;
>>>>         u32 size;
>>>> #endif
>>>> };
>>>>
>>>>


