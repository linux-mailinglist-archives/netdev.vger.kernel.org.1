Return-Path: <netdev+bounces-71403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8315A8532CF
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60581C21000
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3688D56767;
	Tue, 13 Feb 2024 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtUYQLxz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287657330
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833833; cv=none; b=DgXJB2AhZQNmvblnjJmu604R5PdHxmoJCvzwsNbn7rElICN6vTgqIfJk2ZL/DWyvsPiep6CeIV6rocOYdQkMvXczFW16316S5jQlATw0OSbCusoUGHKAzU7wm/P5SEX4R4KbcEqmOpLphmL85T0q/eZemqOfFidSaGu4HQ0L//c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833833; c=relaxed/simple;
	bh=1yv4fNNbd/o6NRBAIASYgG8PuELSoJ6POdZaIqR/irI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqV1I4kh1h0JG8bxlYGgDxF1CxtOkwXT1psCcad+Zkn3kDCGtRMfIFSjEnsOgWK6PeM8b46WSzTLP5MI6FRuBx3CZ9if9JYwtvTfbJjc1iwaDBz9LrotyENY1mQlreogqMn3LvBKFI0b3pMFeWIR23p3RJzX7TE5i/Pj5i/sD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtUYQLxz; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3c1a6c10bbso364283166b.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707833830; x=1708438630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4vnPOkRcfrGk0vvN7qRQ/HZPA059UBJYk1OiZw40yQk=;
        b=RtUYQLxz6Mh5xyoPCqb9+Zc0WMyA9EHKCm/BfJKHAEUQLwCynlA48SPqcUU7pU69+o
         OPulkqpEc6C5G9AtbkVTVTI0UuuWtcmMEjchZo/eRxdeXMOAkgffu63LJ3qmBleKH4Dv
         tOz32OhQTuYMo7tJYnYDobL8QZI9bQ7n2RvmlUQ7MFnZOE4Tt6DrIb3bQI/O6MXONzEQ
         xMapn0vzZ/ay16af4iTXNzmE6Jdfs9V/RIpCsEbJdVO3z/U6YvLYYnbsJYnI8x/cc+3D
         vJAsoxqThe0DhHDsKnMF6CW0PMOfy4L/nl4yYbIVjDU0V6sZTABFSL/V5H4KA4cF9W2S
         eIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833830; x=1708438630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vnPOkRcfrGk0vvN7qRQ/HZPA059UBJYk1OiZw40yQk=;
        b=gAfnR7YrCI0EaiGRwT2H9Mik/susWIcE8Cr0zfEjpTON8bglKzbQbKkWFgzasZI711
         AroVGR2g35gKoH094Vvp1Sh9YqO0AqubxabQ8KaRo/Qt0OZJvN3V5TbuTBWchJfSN2lD
         KiLHidHpi0rpwOq82lAONcvvxaXvXsXl17GlEIw/PT+AaDM82g5ivPLCmThc8rkdoZN3
         EWTk5hGI1lORYQS9asJZpiDtbe8SobhEoUu/OdQ4rbI9XN+I4fBjL0Bv9C4bDOuSsr2z
         J+lyeScaccqqiumsjtHHmV457yw054Oec/nn4j9v2ZZ3mPdxA3nw1sjV2Yz6EA63DL+S
         Yakw==
X-Gm-Message-State: AOJu0Yz9RLEh8SJ1//z/IfXVhd/3yisPmkAr4At7V6NCebLCczvxja1S
	VAGUIVTzPkMmJX1yJv3z3Rbz8aOdd29pUkt8hnYsoyP8RKQUV6uF
X-Google-Smtp-Source: AGHT+IHH2OkEIL66DTWpF8+AX2b5nzo14YFDxoNcRDT+Xpkembm1p0TNW2dpYCMES3xF0Ph5S88lYw==
X-Received: by 2002:a17:906:ad91:b0:a3d:4fd:3945 with SMTP id la17-20020a170906ad9100b00a3d04fd3945mr1400825ejb.43.1707833829594;
        Tue, 13 Feb 2024 06:17:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIPFtDLI/+8KYtcNP9ncaLNw7KvoPM4I6riO/FtPxSkz4fFXeg783qH3EAXFl1HF/rPl7V2XXhPzlSXtKMnwh9/7ttNtDogan14YzmOFtKtGxFNU3WLSh2HKnPB9xIdbdtDm0Gb2lvC+k621AHXgRfZ2eczupe5SF9C+4=
Received: from ?IPV6:2620:10d:c096:310::23d8? ([2620:10d:c092:600::1:a107])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170906ae4800b00a3c6528ec4csm1329350ejb.135.2024.02.13.06.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 06:17:09 -0800 (PST)
Message-ID: <457b4869-8f35-4619-8807-f79fc0122313@gmail.com>
Date: Tue, 13 Feb 2024 14:07:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: cache for same cpu skb_attempt_defer_free
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, kuba@kernel.org
References: <7a01e4c7ddb84292cc284b6664c794b9a6e713a8.1707759574.git.asml.silence@gmail.com>
 <CANn89iJBQLv7JKq5OUYu7gv2y9nh4HOFmG_N7g1S1fVfbn=-uA@mail.gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CANn89iJBQLv7JKq5OUYu7gv2y9nh4HOFmG_N7g1S1fVfbn=-uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/13/24 13:53, Eric Dumazet wrote:
> On Tue, Feb 13, 2024 at 2:42 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> Optimise skb_attempt_defer_free() executed by the CPU the skb was
>> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
>> disable softirqs and put the buffer into cpu local caches.
>>
>> Trying it with a TCP CPU bound ping pong benchmark (i.e. netbench), it
>> showed a 1% throughput improvement (392.2 -> 396.4 Krps). Cross checking
>> with profiles, the total CPU share of skb_attempt_defer_free() dropped by
>> 0.6%. Note, I'd expect the win doubled with rx only benchmarks, as the
>> optimisation is for the receive path, but the test spends >55% of CPU
>> doing writes.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>
>> v2: remove in_hardirq()
>>
>>   net/core/skbuff.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 9b790994da0c..f32f358ef1d8 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -6947,6 +6947,20 @@ void __skb_ext_put(struct skb_ext *ext)
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
>> +       skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED, false);
> 
> I am trying to understand why we use false instead of true here ?
> Or if you prefer:
> local_bh_disable();
> __napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
> local_bh_enable();

Maybe it's my misunderstanding but disabled bh != "napi safe",
e.g. the napi_struct we're interested in might be scheduled for
another CPU. Which is also why "napi" prefix in percpu
napi_alloc_cache sounds a bit misleading to me.

The second reason is that it shouldn't change anything
performance wise

napi_pp_put_page(napi_safe) {
     ...
     if (napi_safe || in_softirq()) { ... }
}


>> +       napi_skb_cache_put(skb);
>> +       local_bh_enable();
>> +}
>> +
>>   /**
>>    * skb_attempt_defer_free - queue skb for remote freeing
>>    * @skb: buffer
>> @@ -6965,7 +6979,7 @@ void skb_attempt_defer_free(struct sk_buff *skb)
>>          if (WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
>>              !cpu_online(cpu) ||
>>              cpu == raw_smp_processor_id()) {
>> -nodefer:       __kfree_skb(skb);
>> +nodefer:       kfree_skb_napi_cache(skb);
>>                  return;
>>          }
>>
>> --
>> 2.43.0
>>

-- 
Pavel Begunkov

