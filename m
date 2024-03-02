Return-Path: <netdev+bounces-76766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE27086ED8B
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 01:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9811F231B3
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 00:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016CDA32;
	Sat,  2 Mar 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTVvXvp6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740BB80C
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709340362; cv=none; b=Hh4fMVO3MTatlmqc7wj0EGbzVCxw39jffO9LZgye4rhL+7IfVN3IgqFebS7CbBhMWIh6c7OIXIQKql8pQS07+cLUnfo733c4kKxfAXBa0XcRKoEqUJ31e8CHe4yYXxu2x99iprSrJOOCRZXKa/Fqa7Ag7/gBBc45WL/CUhMCMJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709340362; c=relaxed/simple;
	bh=9q6beoXM600ca2p9wIrZgwjaJMQA8FLD8tsapiTJG3Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qhv5XWt4BZrrx2VajN6RgmkKSOnWaCw7v7fhPAzb79H80Hh7JHTVHQDlpOFuxUFPl25/lyeBbJz9J8msxZFNZ25MW/ndOe0zPItTfEjIs27PAd8bAJEfg3fKwTjYGY/Jcr7tNXXXpxs0TDJN989/wJt3zypPhwEz3+WeY/Aeb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTVvXvp6; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60978e6f9a3so22426517b3.3
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 16:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709340360; x=1709945160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOAHHnfhsXqMBwzdCn6te3ltsmLQ5xp2TZ8uA6TLQUs=;
        b=LTVvXvp6oLoFR1Moe3oqknvBge7I547QfdMHtRQM2ntJRjpdJXI2HC768JH2L4teCq
         rtjkaZDSgzLQ7HzeNIyVKmdbTWiTCW9uxUpLR4YyeUfcZEwCel4C0dDbYzluJQyc9vk/
         hzD/AOzwQTtlybYcR+c/5/8oijBoWrgR6cs8PflPInFk1UYXOKgVglw4LIy6/iJ9XUME
         oAWMv4+o5QZWyEv6tfPqiT4jiiPSH/UtC8kSY/J96nSwmLs06a3JucSvTzjgnV9ClVXh
         8s0mSeJEUlipp/0qX/LgZTwX6jWt33vYEwbPv5KKdKsovRnZltC4SB9UKTktpnnLJIHQ
         1FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709340360; x=1709945160;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOAHHnfhsXqMBwzdCn6te3ltsmLQ5xp2TZ8uA6TLQUs=;
        b=FiinAGuTZa/7Ava8KkmUN8fSvUjxKW1jer+Tjg5MeWNvNuz9CSUzcib2CPGvNQlgVh
         LzyBdliIRb4Qr4GcfjKksjT9CFSaE9ZqDCluBGsvLKaHyTsQKGr7xWoMLH0mEdUJmRyV
         YAyxCgg4Oymvrr/q30qM9Ig2SmrI+5pwyR5ohNglsR7idPCJR9oK/fQkLLdxKmh8YRfB
         8TKMf6K49quPxNa3mIIeVLVYpdMIVn9uyHBEkdcMte/PCgyHnoRlTPe5p1aQQHk5wjy1
         2mSV/xg7hxD9zTE9x9KE3oLNWdOQHdBWX3mNXBX2vX5tT3prKkcuSeJ3oJL1IRAPaiA1
         N7HA==
X-Gm-Message-State: AOJu0YwzBfWe8ZUgTAo+K4BeYFcpjN6nK17DRtgrd9vetkZqylS8uVgG
	nzrfXxnEfjk/fe4VyTyDjKfhQS90EoJT0I8MpgodKvLKJ8K/ysYc
X-Google-Smtp-Source: AGHT+IHB956kMGSBUsUxfANQF++8iWwb3Y5LUO5m1i3uqNuv0Qi95Fucovyk5BXJzma/ejPU3pBLKw==
X-Received: by 2002:a0d:cb92:0:b0:609:840a:d094 with SMTP id n140-20020a0dcb92000000b00609840ad094mr3428282ywd.18.1709340360471;
        Fri, 01 Mar 2024 16:46:00 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:997:2bbc:b035:6e36? ([2600:1700:6cf8:1240:997:2bbc:b035:6e36])
        by smtp.gmail.com with ESMTPSA id a7-20020a81bc07000000b006077cd5fc5csm1211741ywi.11.2024.03.01.16.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 16:46:00 -0800 (PST)
Message-ID: <d2a4bcab-4fab-4750-b856-a8a9b674a31a@gmail.com>
Date: Fri, 1 Mar 2024 16:45:58 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests/net: force synchronized GC for a test.
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, kuifeng@meta.com
References: <20240223081346.2052267-1-thinker.li@gmail.com>
 <20240223182109.3cb573a2@kernel.org>
 <b1386790-905f-4bc4-8e60-c0c86030b60c@kernel.org>
 <6b73aa09-b842-4bd0-abab-7011495e7176@gmail.com>
In-Reply-To: <6b73aa09-b842-4bd0-abab-7011495e7176@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/29/24 09:39, Kui-Feng Lee wrote:
> 
> 
> On 2/23/24 19:15, David Ahern wrote:
>> On 2/23/24 7:21 PM, Jakub Kicinski wrote:
>>> On Fri, 23 Feb 2024 00:13:46 -0800 Kui-Feng Lee wrote:
>>>> Due to the slowness of the test environment
>>>
>>> Would be interesting if it's slowness, because it failed 2 times
>>> on the debug runner but 5 times on the non-debug one. We'll see.
>>
>> hmmm... that should be debugged. waiting 2*N + 1 and then requesting GC
>> and still failing suggests something else is at play
> 
> I did some tests, and found fib6_run_gc() do round_jiffies()
> for the gc timer. So, gc_interval can increase 0.75 seconds in
> some case. I am doing more investigation on this.

My conclusion is routes going to expire in N seconds can stay
for 2*N + 1 seconds.

Adding a new route going to expire in N seconds, it will starts
gc timer for N seconds. In our case, we add several routes going to
expire in N seconds consecutively. The later routes may expires in
different ticks than the first route added. So, a route may wait nearly
2*N seconds. The test case waits for 2*N + 1 seconds, that should be
enough.

However, some extra waiting may be added to it.
There are two possible extra waiting. The first one is calling
round_jiffies() in fib6_run_gc(), that may add 750ms at most. The second
one is the granularity of waiting for 5 seconds (in our case) is 512ms
for HZ 1000 according to the comment at the very begin of timer.c.
In fact, it can add 392ms for 5750ms (5000ms + 750ms). Overall, they may
contribute up to 1144ms.

Does that make sense?

Debug build is slower. So, the test scripts will be slower than normal
build. That means the script is actually waiting longer with a debug build.

