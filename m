Return-Path: <netdev+bounces-80373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F331387E8C6
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 12:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F522820E2
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6B236B1D;
	Mon, 18 Mar 2024 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7ehth7G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27975364BA
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762182; cv=none; b=VJJfaC0iZy05n3oI9MKOrak7JJpo/70G0IG4eXJYKT8K+bypZ7qY8y1d2ptb90A+7sZAdWxaHG3gxPlQWD9yW7QGFzG/iOOT1kySu5E7ZRFPKENYoK2oPjPeGLwWxaeJl25vRH4NPzsbZo1K+TmXwSfKlkpz8GmkNvUdLTIjpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762182; c=relaxed/simple;
	bh=ydCjg7WCfRCyIvfnADy2yNEvf55uAUczcxqVaJoVHxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQu1aYVTLrGSwJqZDNq6K5gwPFKhw48P2YID7mHqmgTHilREsBiTh9qNM3SGd99h6lmvQrSaipMP+jevMQmeBhdk7RV7QDkRr0bEE2NXsVq3i29DnyLrUqOVyMhHPwJyfPx4IDlCZWdnrNJbxqhdFyf5UmAPg9xzeHvtl8wpQFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7ehth7G; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso5210760a12.2
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 04:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710762179; x=1711366979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qzPpswY2qCrdrGdBta2PdmbQ5Tzy66/0xgT8VwbFvnM=;
        b=f7ehth7GEpgbJLSr5KsvF3qleoOgcToNnDH4tRpxf1wd7POhr5U46UMpM120qiKifJ
         4EoBnWkSRKrgCZbwoCVFB0L2sqq6JRoTj+FyG4CA4TCxgVcXB+GN5ks4LEqeXURp8CjM
         Cc1U9oWKoRkARrrSmgNNQ6DBCD2kFFxbfov6V3zRBs8m4p+2zCnPo3Zz4VF1v8pHGywB
         SsbeGg9jJ+4M/N3T0tpYwTgUbYCyGY46Yqm+n5xbcYl6kz3hTQ7FNUMziO7NlSFhoml/
         f10L0QnIfWuZINCVg2XLJj6YEp3eKjxoRT4oTmKvNXQeYQeATZLuFyjOh/yr6xMG+MdD
         p05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710762179; x=1711366979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzPpswY2qCrdrGdBta2PdmbQ5Tzy66/0xgT8VwbFvnM=;
        b=RAqNW1lflbcsAHO0k5VE5tJ33tyYx33hWQTKVwWf9Ur+bm5u06iWenZzjb2YJWX7Ll
         1ffMjlvqaD/pcSwJD90yml3YSWTo6O1ulah26CS5GMxAJppIMtmt/vT8IEdkuc4bBqTl
         kJqKqI+EYy6uArodAjk3kLi6kI7QGjykLk3FrqmXS3yhoBZYGOWfc89DzTAS79JA7cu7
         WMp/yIYCVMW7/vJatgYXvb+ozcTK2Zjva/8jz01jDY/IWDv3jk/ricZzwekEpTAh40SW
         48toYdecFef7KjStjAUJRbD+b+ErcmvqSCh0mKlLdiU3Hn3JF19iqOORls77bm2uv4oR
         RgNQ==
X-Gm-Message-State: AOJu0YxjQNP3/5KmY43iMK1rl3iWNh/UcnO1+letQDU0hMJuwaTlgnBX
	5walaLcIvoHTdbHU97UhRJM2vUaOEjXo1jYPLDFPdYj0FkLzA8Mmkr2oghy7
X-Google-Smtp-Source: AGHT+IGhgWl50DiWMArrbwtRvdq1neDMuEC08LESWKpsoNN0lFdJPjnEu5tTQX0gJlE8JM2lAbTCYA==
X-Received: by 2002:a05:6402:550b:b0:565:bb25:bb7a with SMTP id fi11-20020a056402550b00b00565bb25bb7amr8854849edb.24.1710762179389;
        Mon, 18 Mar 2024 04:42:59 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.232.181])
        by smtp.gmail.com with ESMTPSA id a89-20020a509ee2000000b00568c299eaedsm2459165edf.81.2024.03.18.04.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 04:42:57 -0700 (PDT)
Message-ID: <ca2a217e-d8a0-4280-8d53-4b6cea4ba34c@gmail.com>
Date: Mon, 18 Mar 2024 11:41:26 +0000
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
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, kuba@kernel.org
References: <1a4e901d6ecb9b091888c4d92256fa4a56cb83a4.1710715791.git.asml.silence@gmail.com>
 <CANn89iLjH52pLPn5-eWqsgeX2AmwEFHJ9=M40fAvAA-MhJKFpQ@mail.gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CANn89iLjH52pLPn5-eWqsgeX2AmwEFHJ9=M40fAvAA-MhJKFpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/24 10:11, Eric Dumazet wrote:
> On Mon, Mar 18, 2024 at 1:46 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> Optimise skb_attempt_defer_free() when run by the same CPU the skb was
>> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
>> disable softirqs and put the buffer into cpu local caches.
>>
>> CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a 1%
>> throughput increase (392.2 -> 396.4 Krps). Cross checking with profiles,
>> the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Note,
>> I'd expect the win doubled with rx only benchmarks, as the optimisation
>> is for the receive path, but the test spends >55% of CPU doing writes.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>
>> v2: pass @napi_safe=true by using __napi_kfree_skb()
>>
>>   net/core/skbuff.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index b99127712e67..35d37ae70a3d 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -6995,6 +6995,19 @@ void __skb_ext_put(struct skb_ext *ext)
>>   EXPORT_SYMBOL(__skb_ext_put);
>>   #endif /* CONFIG_SKB_EXTENSIONS */
>>
>> +static void kfree_skb_napi_cache(struct sk_buff *skb)
>> +{
>> +       /* if SKB is a clone, don't handle this case */
>> +       if (skb->fclone != SKB_FCLONE_UNAVAILABLE) {
>> +               __kfree_skb(skb);
>> +               return;
>> +       }
>> +
>> +       local_bh_disable();
>> +       __napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
>> +       local_bh_enable();
>> +}
>> +
>>   /**
>>    * skb_attempt_defer_free - queue skb for remote freeing
>>    * @skb: buffer
>> @@ -7013,7 +7026,7 @@ void skb_attempt_defer_free(struct sk_buff *skb)
>>          if (WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
>>              !cpu_online(cpu) ||
>>              cpu == raw_smp_processor_id()) {
>> -nodefer:       __kfree_skb(skb);
>> +nodefer:       kfree_skb_napi_cache(skb);
>>                  return;
>>          }
>>
>> --
>> 2.44.0
>>
> 
> 1) net-next is currently closed.

Ok

> 2) No NUMA awareness. SLUB does not guarantee the sk_buff was on the
> correct node.

Let me see if I read you right. You're saying that SLUB can
allocate an skb from a different node, so skb->alloc_cpu
might be not indicative of the node, and so we might locally
cache an skb of a foreign numa node?

If that's the case I don't see how it's different from the
cpu != raw_smp_processor_id() path, which will transfer the
skb to another cpu and still put it in the local cache in
softirq.


> 3) Given that many skbs (like TCP ACK) are freed using __kfree_skb(),  I wonder
> why trying to cache the sk_buff in this particular path is needed.
> 
> Why not change __kfree_skb() instead ?

IIRC kfree_skb() can be called from any context including irqoff,
it's convenient to have a function that just does the job without
too much of extra care. Theoretically it can have a separate path
inside based on irqs_disabled(), but that would be ugly.

-- 
Pavel Begunkov

