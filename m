Return-Path: <netdev+bounces-141679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 007DC9BC055
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3180A1C21E65
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94741A727F;
	Mon,  4 Nov 2024 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJLUFFpp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C8D1925B0
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757079; cv=none; b=NlmsLb2x6L6WwVrQrbwezsBqP9Qdn/vav6y1cbyaWV2x2qBp8s+tpTkSmusWVkR5QbP37ZmXtF/AaWtZEqkWDcnCDvn3LbRnsdNUl7HmeE++4vWpG0Q+gOTZIwL2sOCaSz9CxIC/UdlHMMqZMrH5N9JNwBu0JzEUvNOQ48od1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757079; c=relaxed/simple;
	bh=XLRXEvnAXwUON/+i55ZnkHupHs67s7I1Hdyt0tIigbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8Rq5MF5ra9UWnpur7a6gpBncVNFtRojH0L92HaxJdW5boHlbMLP6rMVKDxrnghJd/uxW5gpWBndh4mNMQNLQ7WXaXl+1KwC/I5JZiHVKIhCzsCNsEtuQypH9UqsbjldaZzCoiXqvUdxPnwkVjWFcjfB7AIVNi0i59E5gw3cTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJLUFFpp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9abe139088so718021066b.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 13:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730757076; x=1731361876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9H9IWpL2XNPeCcHHUZvuIYcyD7Cge4TmSOpY7bl0VHk=;
        b=eJLUFFpp+0lCOQ798OwBSQUVxPAGmm0qJY6CDdnweoIpGb5OjGR+9wd0DQoEU1NaXm
         BmqeEO032mrRUDNucbwPbGusA6NPpyOEETcSydQwnlKFCS/CNXr0PEJch3gGt1SYGAFK
         csz8eZDzyNeH+m7d2ltqgCXYK3vbSLml1gCqMw/Eo0uUIr0UILXYcTgPJZc6QTpHddzw
         lAP2BWsR883knbmGVTiONuGvLS9HA817lsQ1qj319PXQ2ZAnwmz2ylW75ZuUzNzNw/VJ
         sa8mylEZx1ibnqZ36qxMHWkSlCXe5+Q3+aAr7F9JtscArlniWli041noWGji8sisb+gE
         uxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757076; x=1731361876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9H9IWpL2XNPeCcHHUZvuIYcyD7Cge4TmSOpY7bl0VHk=;
        b=CznvOp+W0YSzTvAmLIP6+RGAA4C40m5Jsu1Zo/PGverjJJTpECPdZEh7tvhrQ7DZMB
         BY9WcUvfFr9Ft02NbQTp0HON+XDbTYH2v8hVrQL49QirHaRDAB7QpmtHGGRp6ZfQ/3bB
         Zb8j9N3N6bL0oooa3x/qEwTGTZHGDnXTYJ2J3Ssj8v2bL51aDKO5/ySOfc6YJ7ozBra7
         bEhYBReudIqd6Rrv1f96WUMFxVq03lTJ1jzzgU1uTbG5/CqfMvKAxfX34uedXWaKlV72
         j8m4KZlo1gzZgWUbEBprnmGTOCG2B32BSvEmCMjzq0skMPS4X4NRePSEsMkNqe6EfuZk
         SC3A==
X-Forwarded-Encrypted: i=1; AJvYcCWWL5y3FjlWh0u26DdCjBJXT/u1f1o10fWJK9H77Hun6mHFASC+3foJKNcwmf0fMcstzxQTFZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya0jRr1XllmjqJoIblsNG1qxje1FckrgQaYmzmlJ5WzgtMQYl3
	fvwLmfSXJf0L5Ss1Ho11Zrex2m3kXxJX0YTy6tsNluyhD2ER0C8N
X-Google-Smtp-Source: AGHT+IHLh3AaX61UCc01keFl+xyCoM5uyV9aJPOg0Bdayl+eOvoonzcyJ01KNtnRImnTscrRWmhPyA==
X-Received: by 2002:a17:907:3dac:b0:a9e:b5d0:4ab7 with SMTP id a640c23a62f3a-a9eb5d05117mr4770966b.52.1730757075901;
        Mon, 04 Nov 2024 13:51:15 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17f9416sm34724066b.151.2024.11.04.13.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 13:51:15 -0800 (PST)
Message-ID: <46ddc6aa-486e-4080-a89b-365340ef7c54@gmail.com>
Date: Mon, 4 Nov 2024 22:51:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Fix u32's systematic failure to free IDR entries for
 hnodes.
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 Pedro Tammela <pctammela@mojatatu.com>, edumazet@google.com
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <20241104102615.257784-1-alexandre.ferrieux@orange.com>
 <433f99bd-5f68-4f4a-87c4-f8fd22bea95f@mojatatu.com>
 <b08fb88f-129d-4e4a-8656-5f11334df300@gmail.com>
 <27042bd2-0b71-4001-acf8-19a0fa4a467b@linux.dev>
Content-Language: en-US
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
In-Reply-To: <27042bd2-0b71-4001-acf8-19a0fa4a467b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2024 22:33, Vadim Fedorenko wrote:
> On 04/11/2024 20:26, Alexandre Ferrieux wrote:
>> On 04/11/2024 18:00, Pedro Tammela wrote:
>>>>
>>>> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
>>>
>>> SoB does not match sender, probably missing 'From:' tag
>> 
>> Due to dumb administrativia at my organization, I am compelled to post from my
>> personal gmail accout in order for my posts to be acceptable on this mailing
>> list; while I'd like to keep my official address in commit logs. Is it possible ?
> 
> Yes, it's possible, the author of commit in your local git should use
> email account of company, then git format-patch will generate proper header.

That's exactly what I did, and the file generated by format-patch does have the
proper From:, but it gets overridden by Gmail when sending. That's why, as a
last resort, I tried Signed-off-by... Any hope ?

> you can add
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Ok.

>>> 'static inline' is discouraged in .c files
>> 
>> Why ?
>> 
>> It could have been a local macro, but an inline has (a bit) better type
>> checking. And I didn't want to add it to a .h that is included by many other
>> unrelated components, as it makes no sense to them. So, what is the recommendation ?
> 
> Either move it to some local header file, or use 'static u32 
> handle2id(u32 h)'
> and let compiler decide whether to include it or not.

I believe you mean "let the compiler decide whether to _inline_ it or not".
Sure, with a sufficiently modern Gcc this will do. However, what about more
exotic environments ? Wouldn't it risk a perf regression for style reasons ?

And speaking of style, what about the dozens of instances of "static inline" in
net/sched/*.c alone ? Why is it a concern suddenly ?

> But in either
> cases use u32 as types to be consistent with other types in the
> functions you modify.

Ok.



