Return-Path: <netdev+bounces-69911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630E384D025
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF981F26D80
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8A8823B9;
	Wed,  7 Feb 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXpUaqN+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FDB82893
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328038; cv=none; b=TSwjH8VGRl2XpW+HHQbUByQEPsvub0yExqfdcCHUzxi4HFmQqq6aGqMidcxDt5nT8Qi0Jn6s/aHHiKwZV7jnC7DKH88GwrYUVv4GUDTtqq+M8uIiy+NlALwR4PsW+bp+XmVxkHrdZ8KqQR5BcM6w8NHCGVrUlc0Zca64lqdyTjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328038; c=relaxed/simple;
	bh=QCIgXqDdLMbR/ntvHygyLt1lnwlfvs4mpIbnbRIvnAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqyFNb7jFsT8D3vLv4xM61cB1/PZtDY0Zfy41HZVTSMuTl7jzUpnww+m74AXUAXVVzT3Wry0vgnnmefntEavxEXwAIclD7RyKOq/Cxn/DQwDItq32Qd6FOGJb5H8dVQ36hALSTWQ7XU5slQAf7A5wgIAbTJVQeIxIMXFAAO+CZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXpUaqN+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a370328e8b8so114438566b.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 09:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707328035; x=1707932835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msQN9cUP2xwa8/ADyNbdaUVAHzMXh8Y0eLy+a+OQKLA=;
        b=KXpUaqN+r2PjOUmR/gyfcIcQLuPTsrP64dtTypONMcVKE7+HzwhnxgnXA+Oj+fz1mR
         ARW5tJdO21UJGCLJ3wFhdVNb7S2qnb28cac0jtcRhW2rtkK8RjyXjwlKJnEjEl7+hYK+
         fM11ld2ppc+oAPQMRhC2Ej2YAQtyVv9+TLnGSS3SWOSyMcaq3qeJg1RdVbYxenv1OOdx
         pFPFvKQZwHO7bQFj6eMZmkDU4YJqhy1jt42dQma32jR5YhwD+/XSna8LlgZjWS8fL40G
         wtLmBEfrfk4v3BVCi3kBStmYWIVv0oMs3tdvgCQs9rNgAI0a1QHa5FInhZN7tyqTxSdQ
         c8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707328035; x=1707932835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msQN9cUP2xwa8/ADyNbdaUVAHzMXh8Y0eLy+a+OQKLA=;
        b=iNJmV6cPKEcHbawJo6WzpaDxpygjfG21Wcta1WH2YxY+smKKNMMdhF/vjxWmQaZPWJ
         PokKa67C/3Eij714sRIJqJCH4z0Gix2XopBUOSvMxvjjmE+9ShHMUoTQss4ISxFw+e8g
         vZ3vpIIqJRa9EXt7wPkF74vZNO2yMVYON102HINO0SEIdISFJ5kYnISy2Q/6beYS9NTj
         yt0CGEUEhVrXrKRamaWIhBxX664cFn6GFXOjwe/nroVb2v37j5G0bXswelx1/TPmbBp5
         wsgH0IGyLza1yMp08oHVYupi33/ZnPXKPDvGClipEKSIteupmmZNS5BzaAJ8QgSRZDYh
         Y06g==
X-Gm-Message-State: AOJu0YwhJ2NH0IdwjzNr2/FiT/2/REWBGr2cD1YDfcX9A3GQhEmVxv2M
	vGJ8xYMDmiapBHXMvKr0vzncdbtXxE+4rsBCs/RzWea+Vz6fQGuM
X-Google-Smtp-Source: AGHT+IGw39N5BoCbq4D+LBSToR5mZ/hydCqW3wgz/P98qmxs8xqhW1GS6l5WOgOPF6C+SnHOtQuZBA==
X-Received: by 2002:a17:906:3e16:b0:a38:982d:82b5 with SMTP id k22-20020a1709063e1600b00a38982d82b5mr943110eji.12.1707328035062;
        Wed, 07 Feb 2024 09:47:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqFHWsGttEsyGfCi0DgphrktO1RGKmI8HdboKrGUHRnnmHQbj/UlQ3Y/7TgKJOp6D0gFCWjKvkXZ0Tq8F7OigQy78CDNNjA7bgUKPVzOnATLPlnHTsl7oNI6QNl3tn7vMeQCdexMzn4aVp+XGQ3/7tEeHHM46wdH6VGdY=
Received: from ?IPV6:2620:10d:c096:310::23d8? ([2620:10d:c092:600::1:fbbf])
        by smtp.gmail.com with ESMTPSA id fj17-20020a1709069c9100b00a377a476692sm985755ejc.213.2024.02.07.09.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 09:47:14 -0800 (PST)
Message-ID: <99f32c4f-0c20-4029-9aaa-64ed955718a6@gmail.com>
Date: Wed, 7 Feb 2024 17:45:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: cache for same cpu skb_attempt_defer_free
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, kuba@kernel.org
References: <2b94ee2e65cfd4d2d7f30896ec796f3f9af0a733.1707316651.git.asml.silence@gmail.com>
 <CANn89i+tkdGsKVR6hhCSj2Cz8aioBw1xJrwDYLr9fB=Vzb65TQ@mail.gmail.com>
 <8de1d5d4-ec9e-4684-827b-92db59a3a173@gmail.com>
 <CANn89iKyg6ryhCnUxsGdjjRrpqWzP9MpZtzttjNXXpB1jXn5sA@mail.gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CANn89iKyg6ryhCnUxsGdjjRrpqWzP9MpZtzttjNXXpB1jXn5sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/7/24 15:56, Eric Dumazet wrote:
> On Wed, Feb 7, 2024 at 4:50 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 2/7/24 15:26, Eric Dumazet wrote:
>>> On Wed, Feb 7, 2024 at 3:42 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>
>>>> Optimise skb_attempt_defer_free() executed by the CPU the skb was
>>>> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
>>>> disable softirqs and put the buffer into cpu local caches.
>>>>
>>>> Trying it with a TCP CPU bound ping pong benchmark (i.e. netbench), it
>>>> showed a 1% throughput improvement (392.2 -> 396.4 Krps). Cross checking
>>>> with profiles, the total CPU share of skb_attempt_defer_free() dropped by
>>>> 0.6%. Note, I'd expect the win doubled with rx only benchmarks, as the
>>>> optimisation is for the receive path, but the test spends >55% of CPU
>>>> doing writes.
>>>>
>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>> ---
>>>>    net/core/skbuff.c | 16 +++++++++++++++-
>>>>    1 file changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>>> index edbbef563d4d..5ac3c353c8a4 100644
>>>> --- a/net/core/skbuff.c
>>>> +++ b/net/core/skbuff.c
>>>> @@ -6877,6 +6877,20 @@ void __skb_ext_put(struct skb_ext *ext)
>>>>    EXPORT_SYMBOL(__skb_ext_put);
>>>>    #endif /* CONFIG_SKB_EXTENSIONS */
>>>>
>>>> +static void kfree_skb_napi_cache(struct sk_buff *skb)
>>>> +{
>>>> +       /* if SKB is a clone, don't handle this case */
>>>> +       if (skb->fclone != SKB_FCLONE_UNAVAILABLE || in_hardirq()) {
>>>
>>> skb_attempt_defer_free() can not run from hard irq, please do not add
>>> code suggesting otherwise...
>>
>> I'll add the change, thanks
>>
>>>> +               __kfree_skb(skb);
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       local_bh_disable();
>>>> +       skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED, false);
>>>> +       napi_skb_cache_put(skb);
>>>> +       local_bh_enable();
>>>> +}
>>>> +
>>>
>>> I had a patch adding local per-cpu caches of ~8 skbs, to batch
>>> sd->defer_lock acquisitions,
>>> it seems I forgot to finish it.
>>
>> I played with some naive batching approaches there before but couldn't
>> get anything out of it. From my observations,  skb_attempt_defer_free was
>> rarely getting SKBs targeting the same CPU, but there are probably irq
>> affinity configurations where it'd make more sense.
> 
> Well, you mentioned a high cost in cpu profiles for skb_attempt_defer_free()
> 
> This is what my patch was trying to reduce. Reducing false sharing
> (acquiring remote spinlocks) was the goal.

That would be great. My point was that if there are 2 skbs with
->alloc_cpu X and Y, it'd still need to take 2 locks, for CPUs
X and Y, and that's what was happening. But there are likely smarter
ways than the approach I tried.

>> Just to note that this patch is targeting cases with perfect affinity, so
>> it's orthogonal or complimentary to defer batching.

-- 
Pavel Begunkov

