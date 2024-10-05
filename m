Return-Path: <netdev+bounces-132377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C4999170D
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 15:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3901F2225B
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 13:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53625149E09;
	Sat,  5 Oct 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ady644DQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D24231C95;
	Sat,  5 Oct 2024 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728135882; cv=none; b=Xd+1AXBDKuDbJl6zcd6PhR79cwNmzKXPJM/vl9F//J8daSzi8YGHF9zFUvwD86aLO2AGJhTzP8FGu9suwSlGN3dAbdzXgbXlyewytRnoby+nuzpUc4pWOec6IWcXwMqMkHUtZ/hH2YVS/aqYL5wuCrHuBn7vdqN2T3xEQyDCS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728135882; c=relaxed/simple;
	bh=OCqLnu3FOYh2BYZ/k3XElebh9F3QXzEQhB43B85DKkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlVBYXHRk52u0NB7ZM335A8DCBaFzMRRfekZEeeoJT8zTw/caucmXDUBn0FMIfKCxuIjEGjRgMabH8KKAjpfl+BATUOFdm65PnCfNKX1YdJVWGboHMSb6+ZSzmTC10hhnCOwUeQZNdxGGdgHSxZmmPXcNpOW6ejoGNcbUMp9uw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ady644DQ; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso2557714a12.1;
        Sat, 05 Oct 2024 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728135880; x=1728740680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vk0lcaHAU8ayzUn9Owq/N1n4bRzRycGQWXSMMukOCCY=;
        b=Ady644DQaVb7xEBkLJJ1GcXmWH6qSEKnqgrUGovZc7kXmGItpOY4YxdnrqZmiBdD0j
         be1XgA4QUpYX3mzK7LMZgZvl1gAuH8Amc5YO6+cDgFN5AoCdfqdNpJn01sm4pvaxQxBE
         ew1n8fVS2t0pbSJN9yzlC9+M5KbQO5P/JT4q1pnqMiPlx3gYwV0bEImtGW3OMRPVP0/w
         q3UIKFQH9FL3jKKc5RQQBn3T7VzuYPGNqxUM3hP/4VjEgPK5DETXRl6t0h/JS8tNnPlf
         IgFUm8DF3CxGhiMJi/xAbrVmtv3hNmqcPfoT16+fAASKwT6ej/xoWRe9HpTimTMe+giq
         WFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728135880; x=1728740680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vk0lcaHAU8ayzUn9Owq/N1n4bRzRycGQWXSMMukOCCY=;
        b=lSAQLyypE1Ky615BZ2+w83uPi3KxXgJZH03VTgB5KXWLaqij8jiMUcOEkWbwCG+799
         iEisiyV/9qiMjJpu8p5azJmFsivYdTsIQq+Jh8m4oacGVJ9OgZHm7k+tL4WAD9CIYG14
         Pt89fXD4/joysnqyqR4BDc2CqHFEqWZIosw7JnQa6C77XxnX9y0F816GPpzN6I4gPLz1
         xURE5IA1IW2Yz5nqZegYvtvPmwF7bxsGhVukBfuvZC+3BWZ1qtwPiPmblnrRoBTL+WJn
         +RfS0RiLoAYhQdJNYAG5kZqFKj4MOlT4Vht0mRl+sMbGYfrfQToSQ+VtfYiSLn/qyb0j
         COIw==
X-Forwarded-Encrypted: i=1; AJvYcCWLMeWV1U5kYjhLf3Z4zCqeBpYBvh1D3gW52XNsDVZk0obDkRnEu06+KGkfVwIKv69KJUjnBdfsuNtOWq4=@vger.kernel.org, AJvYcCXeMmvFRbfVqObsPw679yiBPAnxA9fRKpLiLHjinpto1F3S9+JRX65eGSx3nOgIolYyXyb44bcd@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwf65LxZM8cXOuU5w+omKWiqMFdTaYqnBW8tr8L+YaEm7iko1
	zxPN1bIyC67PuyqinV7wF1FC0ocIKV6PCNVqeXDESkJiT1zjV0a1
X-Google-Smtp-Source: AGHT+IE38rSN5FwwRg9a5f0P9ymdYfCJ4Qh1cT/tuSWC/KxzzN+IZeGm4rseorbhwbVgoU1XAV7epA==
X-Received: by 2002:a17:90b:109:b0:2e0:89f2:f60c with SMTP id 98e67ed59e1d1-2e1e5d63376mr8974088a91.11.1728135879828;
        Sat, 05 Oct 2024 06:44:39 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:3c3f:d401:ec20:dbc7? ([2409:8a55:301b:e120:3c3f:d401:ec20:dbc7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f9053sm1824890a91.41.2024.10.05.06.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 06:44:39 -0700 (PDT)
Message-ID: <c9860411-fa9c-4e1b-bca2-a10e6737f9b0@gmail.com>
Date: Sat, 5 Oct 2024 21:44:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 09/14] net: rename skb_copy_to_page_nocache()
 helper
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yunsheng Lin <linyunsheng@huawei.com>, Eric Dumazet <edumazet@google.com>,
 David Ahern <dsahern@kernel.org>
References: <20241001075858.48936-1-linyunsheng@huawei.com>
 <20241001075858.48936-10-linyunsheng@huawei.com>
 <CAKgT0UeSbXTXoOuTZS918pZQcCVZBXiTseN-NUBTGt71ctQ2Vw@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAKgT0UeSbXTXoOuTZS918pZQcCVZBXiTseN-NUBTGt71ctQ2Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/2024 11:00 AM, Alexander Duyck wrote:
> On Tue, Oct 1, 2024 at 12:59 AM Yunsheng Lin <yunshenglin0825@gmail.com> wrote:
>>
>> Rename skb_copy_to_page_nocache() to skb_copy_to_va_nocache()
>> to avoid calling virt_to_page() as we are about to pass virtual
>> address directly.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>   include/net/sock.h | 10 ++++------
>>   net/ipv4/tcp.c     |  7 +++----
>>   net/kcm/kcmsock.c  |  7 +++----
>>   3 files changed, 10 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index c58ca8dd561b..7d0b606d6251 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -2185,15 +2185,13 @@ static inline int skb_add_data_nocache(struct sock *sk, struct sk_buff *skb,
>>          return err;
>>   }
>>
>> -static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *from,
>> -                                          struct sk_buff *skb,
>> -                                          struct page *page,
>> -                                          int off, int copy)
>> +static inline int skb_copy_to_va_nocache(struct sock *sk, struct iov_iter *from,
>> +                                        struct sk_buff *skb, char *va,
>> +                                        int copy)
>>   {
> 
> This new naming is kind of confusing. Currently the only other
> "skb_copy_to" functions are skb_copy_to_linear_data and
> skb_copy_to_linear_data_offset. The naming before basically indicated

I am not sure if the above "skb_copy_to" functions are really related
here, as they are in include/linux/skbuff.h and don't take '*sk' as
first input param.

As "skb_copy_to" function in include/net/sock.h does take '*sk' as first
input param, perhaps the "skb_copy_to" functions in include/net/sock.h
can be renamed to "sk_skb_copy_to" in the future as most of functions
do in include/net/sock.h

> which part of the skb the data was being copied into. So before we
> were copying into the "page" frags. With the new naming this function
> is much less clear as technically the linear data can also be a
> virtual address.

I guess it is ok to use it for linear data if there is a need, why
invent another function for the linear data when both linear data and
non-linear data can be used as a virtual address?

> 
> I would recommend maybe replacing "va" with "frag", "page_frag" or
> maybe "pfrag" as what we are doing is copying the data to one of the
> pages in the paged frags section of the skb before they are added to
> the skb itself.

Don't "frag", "page_frag" or "pfrag" also seem confusing enough that
it does not take any 'frag' as the input param?

Does skb_copy_data() make more sense here as it can work on both
linear and non-linear data, as skb_do_copy_data_nocache() and
skb_copy_to_page_nocache() in the same header file seem to have a
similar style?

