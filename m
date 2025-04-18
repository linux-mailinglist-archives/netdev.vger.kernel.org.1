Return-Path: <netdev+bounces-184102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87A5A9354C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FB64A0791
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB816199947;
	Fri, 18 Apr 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/p2O0dp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64632FBF6;
	Fri, 18 Apr 2025 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968721; cv=none; b=BAZowIlbQxocV49u9IMMuzL55IETmitwV02fXuxqDCvhrGg1fw8z9KnD+E2IKhi7UogNrBVLIyq7fTMcipSWOA5TbWgNCuLPpAs7cjd66a6y2coMJr0o+/lzq+42o+i6HbyE7DatifxGiNgdEb05+km4odBS05aunHW2DWFV2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968721; c=relaxed/simple;
	bh=64Fe7g5Lb1lqDSIJPW0LMmlwJ3M/2Mx2+lOtR94MfF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeFQuY4FDl7FxTGUCmP7yjQHS7Zoo9XbjlGPVa2H7lvLahOWXRWnRtVttdbfJn01abnBd/7M2EXL/+k9qQxdHXHyDnHHvaPrWb+Q/JR7nt5HKE2H/RB0C1U7GRWlL0gF6FDLHXMQjv/GROum5+NhKTwZcylI95b35esqVVWWvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/p2O0dp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so1261997a91.1;
        Fri, 18 Apr 2025 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744968719; x=1745573519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3FYg/pyhreZGWbxJFZYjejOIWe1QYc0OG2U9BkbWp5o=;
        b=T/p2O0dp4dv4IxLIUFvNe++Is2IB0v7/teF4oHgfThBse95k1GMdWYBFRQDcDQYQja
         Dr1SlyAw+t29miFGZtTpXsEPb0dHkaykJg8yTxMUu4VJ8n+sX4BgE47YZcIR9Uf2m14t
         LnInRkvr+mOjUEztj78Xm5/1sqKLABVcj3sBMGQZ9mQUtS6JRMS3TSQtjCz1VYzEfCGW
         9ti6xVSj0merVTGKQFi9eLieBOiV3ZC9DrRZ0ZYB5PjrZbPrFmUEMEv/b11wiRlp0z2r
         OP02DBF/k0fd3aqcx/vIv1ZQsD1JusGIuAdDwDzGwCjZ54ttqnTCmJk/zZpa+zbE7s2z
         B4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744968719; x=1745573519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FYg/pyhreZGWbxJFZYjejOIWe1QYc0OG2U9BkbWp5o=;
        b=FKALw4aIQgF+iZ65NNLHOSmMJGL11XVPcpkZDnitcdzvdRBVeBomwoePDi4GNahu4w
         P5FcF3aBs/MN/7p1hVbv4SKUiNyan7SzxT7i765Ao/zmAWnupjGURYB31Yncy2qBOzAa
         29TJQosyX+vVVo1PPi3bEqslZvZJtCzxNLIwDvG6fUBApwY4JSRzUGOEOZ2ZiFJh2YZh
         4tZZMDhJ3FF2IW0oxmfBb8/g3jJHgIkk+7NPeVJL+VgUKCnIKCB2aN8ENtQbOQmF0oDp
         wiMi0MkHQJ4JDpuBfM40A9WIG+7v03j+TidrUh67HhhrNpb11Fkt1hzPRkfNjnI44mtQ
         crZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6JpyOBar8SrxX2BzE5Q0CO16JpLKsKUclnjiudjV+tKgXYcr97UJDXl+8ybtroGkuxsgwaweU@vger.kernel.org, AJvYcCXTWOp312FRgHy8jCG1bYcsGb22s8WKMJFpC+exqEpp3w3H2kj3FysLkglGe1c7dTIDcwfxlDRnrhfM9Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnwFTD+qU3rSqIqN9RlwHvj/KzrR9AtCR8VPMM7n9P65Itq7f
	nA7RixjmYXD4aBOoyaJtdgsBVHWLP/v14/90a1MKQ7YhPZq4vcU2
X-Gm-Gg: ASbGncvxTUQqGFYvwKP/oafVzIrOaMLaq5jTFeyGXp0X6MqBqqDX3F/PMD+gN6UcUYj
	WpDW2fwZYf8BfdGv45JFNcbL0MBXn28tK7ui2bcJrGkQMILlj1ZJ6eh2/mFX5lwuObn2laZDqcy
	cK1OLLTxDpAaLTg+wZ4JLXAwZuZuaIlClBF5BFS2DOSAE8edQnpvpUBOxYhegyaryoYwWYwbLBW
	OIEKFnqn7qZRy5otQewPZOwijYCzYRsGc0PN4YsNew21RgN5NgnZMt3YK6ti2mm8b4dEz2c0HpK
	Zti9KBG7u4jc2V76vCwZEx1TLQ+dIH9C5myghnozR5KRSIo2sVnVGw8HzHIdJrq7YHYgxzBaI+A
	PfKK0K2hotgl7
X-Google-Smtp-Source: AGHT+IG01YpaHiGlIhPUDJA3SSqBHIutpbt8OgQ4nJiOEg2thJrJIEgGlxsFPPp9aG4+bqaHeeJ9kA==
X-Received: by 2002:a17:90b:5690:b0:2f9:c139:b61f with SMTP id 98e67ed59e1d1-3087bb48e25mr3652993a91.14.1744968719508;
        Fri, 18 Apr 2025 02:31:59 -0700 (PDT)
Received: from ?IPV6:2409:4080:218:8190:3fb8:76d:5206:c8c? ([2409:4080:218:8190:3fb8:76d:5206:c8c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df097aasm812800a91.11.2025.04.18.02.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 02:31:58 -0700 (PDT)
Message-ID: <43d2438f-2fea-45d9-a49e-e03a5cdc6800@gmail.com>
Date: Fri, 18 Apr 2025 15:01:52 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipv4: Fix uninitialized pointer warning in
 fnhe_remove_oldest
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <20250417094126.34352-1-purvayeshi550@gmail.com>
 <20250417220022.23265-1-kuniyu@amazon.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250417220022.23265-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/25 03:30, Kuniyuki Iwashima wrote:
> From: Purva Yeshi <purvayeshi550@gmail.com>
> Date: Thu, 17 Apr 2025 15:11:26 +0530
>> Fix Smatch-detected issue:
>> net/ipv4/route.c:605 fnhe_remove_oldest() error:
>> uninitialized symbol 'oldest_p'.
>>
>> Initialize oldest_p to NULL to avoid uninitialized pointer warning in
>> fnhe_remove_oldest.
> 
> How does it remain uninitialised ?
> 
> update_or_create_fnhe() ensures the bucket is not empty before
> calling fnhe_remove_oldest().

Hi Kuniyuki,

Thanks for the feedback.

Smatch reports this because oldest_p is conditionally assigned inside 
the loop, and it doesn't reason about the guarantees made by 
update_or_create_fnhe() (i.e., that the list is non-empty). So it flags 
oldest_p as potentially uninitialized when dereferenced.

I understand your point, logically, the code is safe, and the warning is 
a false positive.

> 
> 
>>
>> Check that oldest_p is not NULL after the loop to ensure no dereferencing
>> of uninitialized pointers.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>>   net/ipv4/route.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
>> index 753704f75b2c..2e5159127cb9 100644
>> --- a/net/ipv4/route.c
>> +++ b/net/ipv4/route.c
>> @@ -587,7 +587,7 @@ static void fnhe_flush_routes(struct fib_nh_exception *fnhe)
>>   
>>   static void fnhe_remove_oldest(struct fnhe_hash_bucket *hash)
>>   {
>> -	struct fib_nh_exception __rcu **fnhe_p, **oldest_p;
>> +	struct fib_nh_exception __rcu **fnhe_p, **oldest_p = NULL;
>>   	struct fib_nh_exception *fnhe, *oldest = NULL;
>>   
>>   	for (fnhe_p = &hash->chain; ; fnhe_p = &fnhe->fnhe_next) {
>> @@ -601,9 +601,12 @@ static void fnhe_remove_oldest(struct fnhe_hash_bucket *hash)
>>   			oldest_p = fnhe_p;
>>   		}
>>   	}
>> -	fnhe_flush_routes(oldest);
>> -	*oldest_p = oldest->fnhe_next;
>> -	kfree_rcu(oldest, rcu);
>> +
>> +	if (oldest_p) {  /* Ensure to have valid oldest_p element */
>> +		fnhe_flush_routes(oldest);
>> +		*oldest_p = oldest->fnhe_next;
>> +		kfree_rcu(oldest, rcu);
>> +	}
>>   }
>>   
>>   static u32 fnhe_hashfun(__be32 daddr)
>> -- 


