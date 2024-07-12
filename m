Return-Path: <netdev+bounces-111032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 042CA92F721
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 10:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 715FFB222CB
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 08:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C01140E58;
	Fri, 12 Jul 2024 08:42:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206127702;
	Fri, 12 Jul 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720773732; cv=none; b=j0vgxosWOfLuJUZNIki3kXQ4eVEul8xtxLj9PnQ74MfFfkPSzFYdaA1bA+TJP4xKmOJKKOk4M/vEuTV3xwdplkV7SdVFyopygur4zJLak0TDVlGaFzcGlzKV19cE+fcZlb2wRIC5rFFQemjsdk1CsSai2FZjLApv5hnqrOAlfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720773732; c=relaxed/simple;
	bh=deIY9WdhSs7IZNSJ93+yMXTu61kSfvMEpDIe3BbF73w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PhNFfJ9/IU8aQAitPLP4HpFds/5Jr08k7ti66BpYaZWj4bKQI2bSEaKlHgUnftD4yKt0jFvDeu2V9Ls2IEjoVVDDnxvzF27RKumQqeZPAxNYxvFdJ83jHs9J31RFG6nEWns09Sc2OCPH8L5aesKUn1BmdP0YwqbG7mJK960p6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WL4j44lGNzxWGD;
	Fri, 12 Jul 2024 16:37:28 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id ECB2E140156;
	Fri, 12 Jul 2024 16:42:05 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Jul 2024 16:42:05 +0800
Message-ID: <df38c0fb-64a9-48da-95d7-d6729cc6cf34@huawei.com>
Date: Fri, 12 Jul 2024 16:42:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space for
 'size' and 'pfmemalloc'
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-7-linyunsheng@huawei.com>
 <12a8b9ddbcb2da8431f77c5ec952ccfb2a77b7ec.camel@gmail.com>
 <808be796-6333-c116-6ecb-95a39f7ad76e@huawei.com>
 <a026c32218cabc7b6dc579ced1306aefd7029b10.camel@gmail.com>
 <f4ff5a42-9371-bc54-8523-b11d8511c39a@huawei.com>
 <96b04ebb7f46d73482d5f71213bd800c8195f00d.camel@gmail.com>
 <5daed410-063b-4d86-b544-d1a85bd86375@huawei.com>
 <CAKgT0UdJPcnfOJ=-1ZzXbiFiA=8a0z_oVBgQC-itKB1HWBU+yA@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UdJPcnfOJ=-1ZzXbiFiA=8a0z_oVBgQC-itKB1HWBU+yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/12 0:49, Alexander Duyck wrote:
> On Thu, Jul 11, 2024 at 1:16 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/7/10 23:28, Alexander H Duyck wrote:
> 
> ...
> 
>>>>
>>>> Yes, agreed. It would be good to be more specific about how to avoid
>>>> the above problem using a signed negative number for 'remaining' as
>>>> I am not sure how it can be done yet.
>>>>
>>>
>>> My advice would be to go back to patch 3 and figure out how to do this
>>> re-ordering without changing the alignment behaviour. The old code
>>> essentially aligned both the offset and fragsz by combining the two and
>>> then doing the alignment. Since you are doing a count up setup you will
>>
>> I am not sure I understand 'aligned both the offset and fragsz ' part, as
>> 'fragsz' being aligned or not seems to depend on last caller' align_mask,
>> for the same page_frag_cache instance, suppose offset = 32768 initially for
>> the old code:
>> Step 1: __page_frag_alloc_align() is called with fragsz=7 and align_mask=~0u
>>        the offset after this is 32761, the true fragsz is 7 too.
>>
>> Step 2: __page_frag_alloc_align() is called with fragsz=7 and align_mask=-16
>>         the offset after this is 32752, the true fragsz is 9, which does
>>         not seems to be aligned.
> 
> I was referring to my original code before this patchset. I was doing
> the subtraction of the fragsz first, and then aligning which would end
> up padding the end of the frame as it was adding to the total size by
> pulling the offset down *after* I had already subtracted fragsz. The
> result was that I was always adding additional room depending on the
> setting of the fragsz and how it related to the alignment. After
> changing the code to realign on the start of the next frag the fragsz
> is at the mercy of the next caller's alignment. In the event that the
> caller didn't bother to align the fragsz by the align mask before hand
> they can end up with a scenario that might result in false sharing.

So it is about ensuring the additional room due to alignment requirement
being placed at the end of a fragment, in order to avoid false sharing
between the last fragment and the current fragment as much as possible,
right?

I am generally agreed with above if we can also ensure skb coaleasing by
doing offset count-up instead of offset countdown.

If there is conflict between them, I am assuming that enabling skb frag
coaleasing is prefered over avoiding false sharing, right?

> 
>> The above is why I added the below paragraph in the doc to make the semantic
>> more explicit:
>> "Depending on different aligning requirement, the page_frag API caller may call
>> page_frag_alloc*_align*() to ensure the returned virtual address or offset of
>> the page is aligned according to the 'align/alignment' parameter. Note the size
>> of the allocated fragment is not aligned, the caller needs to provide an aligned
>> fragsz if there is an alignment requirement for the size of the fragment."
>>
>> And existing callers of page_frag aligned API does seems to follow the above
>> rule last time I checked.
>>
>> Or did I miss something obvious here?
> 
> No you didn't miss anything. It is just that there is now more
> potential for error than there was before.

I guess the 'error' is referred to the 'false sharing' mentioned above,
right? If it is indeed an error, are we not supposed to fix it instead
of allowing such implicit implication? Allowing implicit implication
seems to make the 'error' harder to reproduce and debug.

> 
>>> need to align the remaining, then add fragsz, and then I guess you
>>> could store remaining and then subtract fragsz from your final virtual
>>> address to get back to where the starting offset is actually located.
>>
>> remaining = __ALIGN_KERNEL_MASK(nc->remaining, ~align_mask);
>> remaining += fragsz;
>> nc->remaining = remaining;
>> return encoded_page_address(nc->encoded_va) + (size + remaining) - fragsz;
>>
>> If yes, I am not sure what is the point of doing the above yet, it
>> just seem to make thing more complicated and harder to understand.
> 
> That isn't right. I am not sure why you are adding size + remaining or
> what those are supposed to represent.

As the above assumes 'remaining' is a negative value as you suggested,
(size + remaining) is supposed to represent the offset of next fragment
to ensure we have count-up offset for enabling skb frag coaleasing, and
'- fragsz' is used to get the offset of current fragment.

> 
> The issue was that the "remaining" ends up being an unaligned value as
> you were starting by aligning it and then adding fragsz. So by
> subtracting fragsz you can get back to the aliglined start. What this
> patch was doing before was adding the raw unaligned nc->remaining at
> the end of the function.
> 
>>>
>>> Basically your "remaining" value isn't a safe number to use for an
>>> offset since it isn't aligned to your starting value at any point.
>>
>> Does using 'aligned_remaining' local variable to make it more obvious
>> seem reasonable to you?
> 
> No, as the value you are storing above isn't guaranteed to be aligned.
> If you stored it before adding fragsz then it would be aligned.

I have a feeling that what you are proposing may be conflict with enabling
skb frag coaleasing, as doing offset count-up seems to need some room to
be reserved at the begin of a allocated fragment due to alignment requirement,
and that may mean we need to do both fragsz and offset aligning.

Perhaps the 'remaining' changing in this patch does seems to make things
harder to discuss. Anyway, it would be more helpful if there is some pseudo
code to show the steps of how the above can be done in your mind.

> 
>>>
>>> As far as the negative value, it is more about making it easier to keep
>>> track of what is actually going on. Basically we can use regular
>>> pointer math and as such I suspect the compiler is having to do extra
>>> instructions to flip your value negative before it can combine the
>>> values via something like the LEA (load effective address) assembler
>>> call.
>>
>> I am not an asm expert here, I am not sure I understand the optimization
>> trick here.
> 
> The LEA instruction takes a base address adds 1/2/4/8 times a multiple
> and then a fixed offset all in one function and provides an address as
> an output. The general idea is that you could look at converting
> things such that you are putting together the page address +
> remaining*1 + PAGE_SIZE. Basically what I was getting at is that
> addition works, but it doesn't do negative values for the multiple.

