Return-Path: <netdev+bounces-80412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115CA87EAA5
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 15:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013531C210FE
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12CE481B2;
	Mon, 18 Mar 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVUzysKg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C481E86E
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771376; cv=none; b=Yj3gZnW7CSTwBRVimNQuBzutpiyelTesB+jOXU+upp+KN0qZKSj0BjywcUZTPkEtKbkbdiXLnXl8QiX3cbyg8ij3s7C3t8FPk1sJMFbaq3WVZg6xY/P65Ab7wq1m8GUxucEwne3DbnTmi6KJYXTTSfZU7S8zSpCzknbcLcKnuCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771376; c=relaxed/simple;
	bh=Kbgq9KNwax+JyqxjEe64y7Pp4O+k3UFCtlumCL7/BiM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RR0TPWmR80TNzK3JG+rhMJi6lfegzxDUTqh/IzbKdifQalL3lmGxRDFgQ7iSWJAKUUR2wQhrF77MVBwIfJ9PhRDuQSBNWlD31TZAnXnIReno6IO+rDv/AuH5zNnJMoLGULLyn/dG0X2Ooz3UiBrXInQEHgVGBXPosmM4C6Oz9vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVUzysKg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so982960666b.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710771373; x=1711376173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRRXX75c5xplCOg7woN5HW73CrrXdy2Xy3FFprc99g4=;
        b=YVUzysKgrolOXV/Nme2U3cogDk8hBL3dwuVEkKNiZlXusOuctBWihQGSmPZ4/sldO7
         s3Yu1GF1QlTturPzFEQ4t+aIcy2Ko3GCDMyVhI8CZ877vpja2/NtZeh/I/fKoi61KRIr
         CvyXQgWHFFZ4ff0SrLKE64XbJW8wUwEqF1u7oV48tm1tSPolfblaCItn1e0956Gn8Do/
         m5wd5AGYvEXFdJBVI7VZQ0pgaYB8eecNNZfbsS4WsPGrxkTFRropsLc4kx7oQ/pVA2og
         KioZhDVrUvSVREIqSqeP5r22fDsz0lyFyVfw693NePlkOnNBbL/eW5I13I2uTlnobjsc
         M+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710771373; x=1711376173;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRRXX75c5xplCOg7woN5HW73CrrXdy2Xy3FFprc99g4=;
        b=GOhIOpZGmUi5WercNzIpV+lhiE3fgcbNOTuSGrIGkYZ4Dj2LYqVvdTEMom7tCX1PFQ
         BIrqBDAEscfTzJzQ5zPUgce4W8eUj4BahEeFbWKnlU7ykHV224nt9FDDBw83Xg/lJ4HB
         l8YGy1ncLgBTFoGNHG1fvim94mo45DnU+w0irkwP+yppGz22cVkV2ArTZHqBMpKkLE4u
         kJ+84UJJhp0pMXg4qrD9gUqDpmZ+IMjofkfO/BGZO9LmzysG5J6NquZdhS2sY2uY0J0r
         nv30Uxqd0x1AVyVHkWKClxXv1HIzJKbC+VatA7qxBgVPocZSc07/srkOBQlgqGalpGVJ
         neLg==
X-Gm-Message-State: AOJu0YwRbeh4aVVcaMS0hyzaQYPt4xff7kL/nkRncAjWm5ZljGqM+XNY
	IIcaUtFfxeQ2kTP9QuqygiW5+gV7ANAGCsKYYZREpGN3ivgZfs5I
X-Google-Smtp-Source: AGHT+IFtu7fMxV1VJguPru/8lMf2jwQrPSc6Z4atm6+9qTLwiaSxPzqWwYXt0QcSqgoBgeBS9jrSKQ==
X-Received: by 2002:a17:907:7283:b0:a46:b43e:fa3c with SMTP id dt3-20020a170907728300b00a46b43efa3cmr4145998ejc.15.1710771373205;
        Mon, 18 Mar 2024 07:16:13 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:310::2181? ([2620:10d:c092:600::1:429a])
        by smtp.gmail.com with ESMTPSA id p4-20020a05640210c400b0056b0af78d80sm756383edu.34.2024.03.18.07.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 07:16:12 -0700 (PDT)
Message-ID: <13b616bb-52f1-426e-8529-0bbb7b279d89@gmail.com>
Date: Mon, 18 Mar 2024 14:14:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: cache for same cpu
 skb_attempt_defer_free
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, kuba@kernel.org
References: <1a4e901d6ecb9b091888c4d92256fa4a56cb83a4.1710715791.git.asml.silence@gmail.com>
 <CANn89iLjH52pLPn5-eWqsgeX2AmwEFHJ9=M40fAvAA-MhJKFpQ@mail.gmail.com>
 <ca2a217e-d8a0-4280-8d53-4b6cea4ba34c@gmail.com>
In-Reply-To: <ca2a217e-d8a0-4280-8d53-4b6cea4ba34c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/24 11:41, Pavel Begunkov wrote:
> On 3/18/24 10:11, Eric Dumazet wrote:
>> On Mon, Mar 18, 2024 at 1:46 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>
>>> Optimise skb_attempt_defer_free() when run by the same CPU the skb was
>>> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
>>> disable softirqs and put the buffer into cpu local caches.
>>>
>>> CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a 1%
>>> throughput increase (392.2 -> 396.4 Krps). Cross checking with profiles,
>>> the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Note,
>>> I'd expect the win doubled with rx only benchmarks, as the optimisation
>>> is for the receive path, but the test spends >55% of CPU doing writes.
>>>
>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>> ---
>>>
>>> v2: pass @napi_safe=true by using __napi_kfree_skb()
>>>
>>>   net/core/skbuff.c | 15 ++++++++++++++-
>>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>> index b99127712e67..35d37ae70a3d 100644
>>> --- a/net/core/skbuff.c
>>> +++ b/net/core/skbuff.c
>>> @@ -6995,6 +6995,19 @@ void __skb_ext_put(struct skb_ext *ext)
>>>   EXPORT_SYMBOL(__skb_ext_put);
>>>   #endif /* CONFIG_SKB_EXTENSIONS */
>>>
>>> +static void kfree_skb_napi_cache(struct sk_buff *skb)
>>> +{
>>> +       /* if SKB is a clone, don't handle this case */
>>> +       if (skb->fclone != SKB_FCLONE_UNAVAILABLE) {
>>> +               __kfree_skb(skb);
>>> +               return;
>>> +       }
>>> +
>>> +       local_bh_disable();
>>> +       __napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
>>> +       local_bh_enable();
>>> +}
>>> +
>>>   /**
>>>    * skb_attempt_defer_free - queue skb for remote freeing
>>>    * @skb: buffer
>>> @@ -7013,7 +7026,7 @@ void skb_attempt_defer_free(struct sk_buff *skb)
>>>          if (WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
>>>              !cpu_online(cpu) ||
>>>              cpu == raw_smp_processor_id()) {
>>> -nodefer:       __kfree_skb(skb);
>>> +nodefer:       kfree_skb_napi_cache(skb);
>>>                  return;
>>>          }
>>>
>>> -- 
>>> 2.44.0
>>>
>>
>> 1) net-next is currently closed.
> 
> Ok
> 
>> 2) No NUMA awareness. SLUB does not guarantee the sk_buff was on the
>> correct node.
> 
> Let me see if I read you right. You're saying that SLUB can
> allocate an skb from a different node, so skb->alloc_cpu
> might be not indicative of the node, and so we might locally
> cache an skb of a foreign numa node?
> 
> If that's the case I don't see how it's different from the
> cpu != raw_smp_processor_id() path, which will transfer the
> skb to another cpu and still put it in the local cache in
> softirq.
> 
> 
>> 3) Given that many skbs (like TCP ACK) are freed using __kfree_skb(),  I wonder
>> why trying to cache the sk_buff in this particular path is needed.
>>
>> Why not change __kfree_skb() instead ?
> 
> IIRC kfree_skb() can be called from any context including irqoff,

On the other hand there is napi_pp_put_page() inside which
assumes hardirq off, so maybe not, I'd appreciate if someone
can clarify it. I was sure that drivers allocating in hardirq
via e.g. __netdev_alloc_skb() might want to use kfree_skb(),
but maybe they're consistently sticking to dev_kfree_sk*().


> it's convenient to have a function that just does the job without
> too much of extra care. Theoretically it can have a separate path
> inside based on irqs_disabled(), but that would be ugly.

-- 
Pavel Begunkov

