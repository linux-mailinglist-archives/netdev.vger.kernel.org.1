Return-Path: <netdev+bounces-111204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE3B9303BF
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B741B22327
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97F1AAD7;
	Sat, 13 Jul 2024 05:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGYERUyR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9418C08;
	Sat, 13 Jul 2024 05:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720848043; cv=none; b=RD+HePnxrSGMUhdSTQtX3M4zeHWoGm8gTcMAAV+2EsYHyU9sdDZiwQkPd5JLRsEIAfZH6JWaWgjfisEychVrJNuurZjUZGgVFC4dc5kpeN0rMuyKepuUQs2kqbswjWBElVsTdty4jxh9Bb/4lXlNdvAssMjMP5ZuMO/8QBK+0Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720848043; c=relaxed/simple;
	bh=lULtPqUHkTDa0iWtJSMypwqkrBT7ZesCSXk+Uxk8uco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVbV2GhTc3ZLdPqXhQpY82aRnKaTCrPDkW+IaSSGXlw7RzXLvuqPj50ybsnoOePF20vWpZAR8RXRZIlukn2hEchfel3rg4jA4EMs0ZGq9PWYUNVJgZhHjxyh6kcn0CR8G6iD18FF8zyxSSgPdLm3yUD+Ehj8pjWzdSYrKh7O4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGYERUyR; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1fbda48631cso20935695ad.0;
        Fri, 12 Jul 2024 22:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720848041; x=1721452841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBuAPTxuJ1qWiqRFJmaR6A1QoF7tFS7Qxz1CmzK7cLI=;
        b=WGYERUyRcD4wCVfUKlov3FhW7jEdu1oA3dVeSrZUSoGnig6s7W5s/6qSiW5xZCkYCZ
         xx5ROtd5FSM/LMURS+scGQyc3KTwDLDIpjmi2jW53h6S5DxcZ6JnFc/ECDzajUNNp0n5
         4jigIr0dN/HFVQ53aqaQ1asBvaIVxT6j+SgBbzfTCl0ZHqtqwx9fYoQNlaV+qVh6svIa
         8mwIje/TY6km+fJaTR6EkVu9f2OJ8OnMtJTbQtH1JJSuG2ymxWbM1W15emrQI83bbSR6
         1ygJO4YkrPZGRxW+dViuwSNlB4JGgE5ezFm/IsiUCKFtSlYuPjYlEC6DUfj+R5Y3zd9a
         9KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720848041; x=1721452841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cBuAPTxuJ1qWiqRFJmaR6A1QoF7tFS7Qxz1CmzK7cLI=;
        b=hSE6gprS6k+1sqchd9SfwRmxeFpt/JT3HvoNN//94L4HvlJAvKGr02N4LQifxOlbV3
         juegW/12Vb6azVEWsABTDUMf5UwCzjNdtCGh7YWiGUGSrR3xliVYxu1DorzTb+hIvhtT
         YSSUuJw8mvHzj1/2N+NafovWs9w1iyKXGJx4fadzV2BerRx+jo1DTgczThnif5MYZr80
         nqCfXjXhDuFIAInftD9pMHzP0Q8HmmtYYgPZe6SuGU5VOF0fAyBOZ3qx1OAk3bbFuBLg
         hnGE98LaqGFdvGkxJA6H8ypSuwuHTvMH3iildSEkTUmeTNkzmxENfNiXPe+JUQ5sXfsl
         4xtw==
X-Forwarded-Encrypted: i=1; AJvYcCWyvrxoCM4w6oaBJsEprfpstFxUWRv74ejP5wBvqxz76Z1P5HMAAwlkAk8MZToiiuaYWTKfuscwpzFyUH8rrfvA1FKtQ6k/cnlXtZeWMOm7LpbMJslA6fVMO8Uwl3njOWvSZ2gI
X-Gm-Message-State: AOJu0YwORUiqEidt1XrcX+GA4wqIAwGT7YaUnq5iYtwdIYWxMpgjvEql
	rXKcl29WOxPQY5evNzrwKQWe5hffw1KLiJs3bB6arc57FFKP30Bg
X-Google-Smtp-Source: AGHT+IFDHWc+KpYHI28jTeC/TwB29uz66eJr6hcqhJNhYanXrECcS38Qw4kUj7KmG0CM7iU/vYMRIg==
X-Received: by 2002:a17:902:e843:b0:1fb:80a3:5826 with SMTP id d9443c01a7336-1fc0b4b4829mr11092165ad.4.1720848040723;
        Fri, 12 Jul 2024 22:20:40 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:e4df:44a3:8745:57ef? ([2409:8a55:301b:e120:e4df:44a3:8745:57ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc3921bsm2927965ad.227.2024.07.12.22.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 22:20:40 -0700 (PDT)
Message-ID: <29e8ac53-f7da-4896-8121-2abc25ec2c95@gmail.com>
Date: Sat, 13 Jul 2024 13:20:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space for
 'size' and 'pfmemalloc'
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-7-linyunsheng@huawei.com>
 <12a8b9ddbcb2da8431f77c5ec952ccfb2a77b7ec.camel@gmail.com>
 <808be796-6333-c116-6ecb-95a39f7ad76e@huawei.com>
 <a026c32218cabc7b6dc579ced1306aefd7029b10.camel@gmail.com>
 <f4ff5a42-9371-bc54-8523-b11d8511c39a@huawei.com>
 <96b04ebb7f46d73482d5f71213bd800c8195f00d.camel@gmail.com>
 <5daed410-063b-4d86-b544-d1a85bd86375@huawei.com>
 <CAKgT0UdJPcnfOJ=-1ZzXbiFiA=8a0z_oVBgQC-itKB1HWBU+yA@mail.gmail.com>
 <df38c0fb-64a9-48da-95d7-d6729cc6cf34@huawei.com>
 <CAKgT0UdSjmJoaQvTOz3STjBi2PazQ=piWY5wqFsYFBFLcPrLjQ@mail.gmail.com>
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAKgT0UdSjmJoaQvTOz3STjBi2PazQ=piWY5wqFsYFBFLcPrLjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/13/2024 12:55 AM, Alexander Duyck wrote:

...

>>
>> So it is about ensuring the additional room due to alignment requirement
>> being placed at the end of a fragment, in order to avoid false sharing
>> between the last fragment and the current fragment as much as possible,
>> right?
>>
>> I am generally agreed with above if we can also ensure skb coaleasing by
>> doing offset count-up instead of offset countdown.
>>
>> If there is conflict between them, I am assuming that enabling skb frag
>> coaleasing is prefered over avoiding false sharing, right?
> 
> The question I would have is where do we have opportunities for this
> to result in coalescing? If we are using this to allocate skb->data
> then there isn't such a chance as the tailroom gets in the way.
> 
> If this is for a device allocating for an Rx buffer we won't get that
> chance as we have to preallocate some fixed size not knowing the
> buffer that is coming, and it needs to usually be DMA aligned in order
> to avoid causing partial cacheline reads/writes. The only way these
> would combine well is if you are doing aligned fixed blocks and are
> the only consumer of the page frag cache. It is essentially just
> optimizing for jumbo frames in that case.

And hw-gro or sw-gro.

> 
> If this is for some software interface why wouldn't it request the
> coalesced size and do one allocation rather than trying to figure out
> how to perform a bunch of smaller allocations and then trying to merge
> them together after the fact.

I am not sure I understand what 'some software interface' is referring
to, I hope you are not suggesting the below optimizations utilizing of
skb_can_coalesce() checking is unnecessary:(

https://elixir.bootlin.com/linux/v6.10-rc7/C/ident/skb_can_coalesce

Most of the usecases do that for the reason below as mentioned in the
Documentation/mm/page_frags.rst as my understanding:
"There is also a use case that needs minimum memory in order for forward 
progress, but more performant if more memory is available."

> 
>>>
>>>> The above is why I added the below paragraph in the doc to make the semantic
>>>> more explicit:
>>>> "Depending on different aligning requirement, the page_frag API caller may call
>>>> page_frag_alloc*_align*() to ensure the returned virtual address or offset of
>>>> the page is aligned according to the 'align/alignment' parameter. Note the size
>>>> of the allocated fragment is not aligned, the caller needs to provide an aligned
>>>> fragsz if there is an alignment requirement for the size of the fragment."
>>>>
>>>> And existing callers of page_frag aligned API does seems to follow the above
>>>> rule last time I checked.
>>>>
>>>> Or did I miss something obvious here?
>>>
>>> No you didn't miss anything. It is just that there is now more
>>> potential for error than there was before.
>>
>> I guess the 'error' is referred to the 'false sharing' mentioned above,
>> right? If it is indeed an error, are we not supposed to fix it instead
>> of allowing such implicit implication? Allowing implicit implication
>> seems to make the 'error' harder to reproduce and debug.
> 
> The concern with the code as it stands is that if I am not mistaken
> remaining isn't actually aligned. You aligned it, then added fragsz.
> That becomes the start of the next frame so if fragsz isn't aligned
> the next requester will be getting an unaligned buffer, or one that is
> only aligned to the previous caller's alignment.

As mentioned below:
https://lore.kernel.org/all/3da33d4c-a70e-23a4-8e00-23fe96dd0c1a@huawei.com/

what alignment semantics are we providing here:
1. Ensure alignment for both offset and fragsz.
2. Ensure alignment for offset only.
3. Ensure alignment for fragsz only.

As my understanding, the original code before this patchset is only 
ensuring alignment for offset too. So there may be 'false sharing'
both before this patchset and after this patchset. It would be better
not to argue about which implementation having more/less potential
to avoid the 'false sharing', it is an undefined behavior, the argument
would be endless depending on usecase and personal preference.

As I said before, I would love to retain the old undefined behavior
when there is a reasonable way to support the new usecases.

> 
>>>
>>>>> need to align the remaining, then add fragsz, and then I guess you
>>>>> could store remaining and then subtract fragsz from your final virtual
>>>>> address to get back to where the starting offset is actually located.
>>>>
>>>> remaining = __ALIGN_KERNEL_MASK(nc->remaining, ~align_mask);
>>>> remaining += fragsz;
>>>> nc->remaining = remaining;
>>>> return encoded_page_address(nc->encoded_va) + (size + remaining) - fragsz;
>>>>
>>>> If yes, I am not sure what is the point of doing the above yet, it
>>>> just seem to make thing more complicated and harder to understand.
>>>
>>> That isn't right. I am not sure why you are adding size + remaining or
>>> what those are supposed to represent.
>>
>> As the above assumes 'remaining' is a negative value as you suggested,
>> (size + remaining) is supposed to represent the offset of next fragment
>> to ensure we have count-up offset for enabling skb frag coaleasing, and
>> '- fragsz' is used to get the offset of current fragment.
>>
>>>
>>> The issue was that the "remaining" ends up being an unaligned value as
>>> you were starting by aligning it and then adding fragsz. So by
>>> subtracting fragsz you can get back to the aliglined start. What this
>>> patch was doing before was adding the raw unaligned nc->remaining at
>>> the end of the function.
>>>
>>>>>
>>>>> Basically your "remaining" value isn't a safe number to use for an
>>>>> offset since it isn't aligned to your starting value at any point.
>>>>
>>>> Does using 'aligned_remaining' local variable to make it more obvious
>>>> seem reasonable to you?
>>>
>>> No, as the value you are storing above isn't guaranteed to be aligned.
>>> If you stored it before adding fragsz then it would be aligned.
>>
>> I have a feeling that what you are proposing may be conflict with enabling
>> skb frag coaleasing, as doing offset count-up seems to need some room to
>> be reserved at the begin of a allocated fragment due to alignment requirement,
>> and that may mean we need to do both fragsz and offset aligning.
>>
>> Perhaps the 'remaining' changing in this patch does seems to make things
>> harder to discuss. Anyway, it would be more helpful if there is some pseudo
>> code to show the steps of how the above can be done in your mind.
> 
> Basically what you would really need do for all this is:
>    remaining = __ALIGN_KERNEL_MASK(nc->remaining, ~align_mask);
>    nc->remaining = remaining + fragsz;
>    return encoded_page_address(nc->encoded_va) + size + remaining;

I am assuming 'size + remaining' is supposed to represent the offset of 
current allocted fragment?
Are you sure the above is what you wanted?

suppose remaining = -32768 & size = 32768 initially:
Step 1: __page_frag_alloc_align() is called with fragsz=7 and
         align_mask=~0u, the remaining after this is -32761, the true
         fragsz is 7, the offset is 0

Step 2: __page_frag_alloc_align() is called with fragsz=7 and
         align_mask=-16, the offset after this is -32745, the true
         fragsz is 7, the offset = 16

The semantics of the above implementation seems to be the same as
the semantics of implementation of patch 3 in v10：
https://lore.kernel.org/all/20240709132741.47751-4-linyunsheng@huawei.com/
     aligned_remaining = nc->remaining & align_mask;
     remaining = aligned_remaining - fragsz;
     nc->remaining = remaining;
     return encoded_page_address(encoded_va) + size - aligned_remaining;

The main difference seems to be about using a negative value for 
nc->remaining or not, if yes, I am not sure what is other gain of
using a negative value for nc->remaining besides the LEA instruction
opt trick.

As using a unsigned value and a 'aligned_remaining' local variable
does seems to make thing easier to understand and avoid adding three 
checkings as mentioned below.

> 
> The issue is you cannot be using page_frag_cache_current_va as that
> pointer will always be garbage as it isn't aligned to anything. It
> isn't like the code that I had that was working backwards as the
> offset cannot be used as soon as you compute it since you add fragsz
> to it.

The above was a mistake in v9, the intend is to do:
nc->remaining &= align_mask;

That was why there were three 'align > PAGE_SIZE' checking in v10 to
avoid doing 'nc->remaining &= align_mask' prematurely if caller passes
a large align_mask value.

So 'aligned_remaining' local variable in v10 is used to avoid doing 
'nc->remaining &= align_mask', thus three 'align > PAGE_SIZE' checking
is not needed too.

> 
> For any countup you have to align the current offset/remaining value,
> then that value is used for computing the page address, and you store
> the offset/remaining plus fragsz adjustment. At which point your
> offset/remaining pointer value isn't good for the current buffer
> anymore.
> 

