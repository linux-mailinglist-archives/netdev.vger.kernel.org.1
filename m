Return-Path: <netdev+bounces-69876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E243084CE65
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C058287159
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E337FBBE;
	Wed,  7 Feb 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPFw9Ndb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095EA7F7D2
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321060; cv=none; b=UVLJ/srQ2fu4W9vknHpi/tHN0Wh/3v8CIudvlSiBf4z8/TxmG5Wh9a7wxy/zKmO59VmbZJ48Mx3fPYwYclU/QANOuxQVjJ+jwgyI817DEZmZkMxa6w1Mi8t/jlduJUEeaiCKfJYAtTGLevN2nZ8ZM7wTadDyGf7JUSI612iNPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321060; c=relaxed/simple;
	bh=SX+Kq++o0TPMFgg5eVbsOtCTK4HsHoiMyw0WAVgqdfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaHxj9ITAn7w93OgLAc6dkNKgnjLRFz4yy6SBf/mrsPSX/Z6rZ+zErDgQpDECYfrNvN1VYJ0VU4WYjbp06DSziuMsRRboMHds4s9FWqKzFoElC3JWqJjb+WFcuLbAG++MKfCqULzvvIsS1Q1W63zLxraxyxvBemxUA0MxbZ9Ha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPFw9Ndb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so107704566b.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 07:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707321056; x=1707925856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nC5VUnmVgr6sCFDNscHx0AtkwZkxGob2Nt7t8dX9CFU=;
        b=bPFw9NdbQnJaGb9+6XA+nzGqozoslwO8+YxVeVBeGsUN1eIfaRszLDB/37D0WwpZ7+
         XM9pVo6liudGlxF+HVhw5VBYKLA9hZTRNRxpabHKPKxaoD7Ss5k8pTOa4rXvOypcByjb
         boqn3+2bSwIynKlGSj6yNJBcBcVhYm1WcVheWH2tf0UV9yC65n4beSYzM9KRsiQ8GucN
         HpZXMbIJYa3kV38Prl087JmmW+jUVAJzGSzgxKNQhrkNTsT/KtxyNCuS0IRg27vEta61
         BC8WNS34We2/FbGXoEEZyGfiDJ4jAjVeaoMGn3joirUtENfvQup4QYMmtkISnBxifJxY
         3ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707321056; x=1707925856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nC5VUnmVgr6sCFDNscHx0AtkwZkxGob2Nt7t8dX9CFU=;
        b=INV848LeMTRZRVeI4u3gWUdurTw9A8zMoVgPhvYTRwFb1s7XDdQQPRoXSMAc4mnSnY
         aatDU4B4ie10Sx6ZOgv/eppb7siPvqsXrftlzcZLgM5Xw52X4dbdC/mUbQ3haU7Xanp2
         zywXA3aB2E/YNPsBFdolTer+GOUcczp6vG34YA9tIcyjrKC5Y8LdBwSoXR5OJr9d9iEf
         Lhy8fymQFaHdw+xSQ+ZD5GSkbdDtAp327fXfMEXBl3ybU7GefXEARaZretBM25qDJNKR
         nr+MJ56yXCl6hiMytW5+hrTveFF9/HXBaI+hmHMNWjbZEMIIp5TbfpXdcF7l86cJ3YY8
         FF5w==
X-Gm-Message-State: AOJu0Yw38K0IGJUb8JwCrqgbdxqAkhtUt+qZeZiKb5VybL7WHD5o0gQE
	YZX3Y3Hbme9QNI+PNwRGOLeFO93TT39XWR9sbP2sCl528Z62ZxDC
X-Google-Smtp-Source: AGHT+IEsq/H7VHmk3fcW9yAiyWEHcWfLDC6P4mpxtPqK8DQt/h0HQBUnw4KbUMGkq3ETE2KtT/ykBw==
X-Received: by 2002:a17:906:ee1:b0:a37:3881:77e with SMTP id x1-20020a1709060ee100b00a373881077emr4257698eji.45.1707321056122;
        Wed, 07 Feb 2024 07:50:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGjSi40t/eg6HAcRe0qd/gujJzlxwe3gmMqFfj6EjG5ZLdYARB50OuOMFU2w+UVnAOg5fm+fRIgT0QIq/B6MbtzMubJADwXTlIUkFGPxTmnx0T3XMhOwCJO6aOhUk5E/eHU/6ZTorE43WAbcha+CFvuCiLwXna/hlFsCE=
Received: from ?IPV6:2620:10d:c096:310::23d8? ([2620:10d:c092:600::1:fbbf])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709064ad200b00a35922ecbccsm878356ejt.203.2024.02.07.07.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 07:50:55 -0800 (PST)
Message-ID: <8de1d5d4-ec9e-4684-827b-92db59a3a173@gmail.com>
Date: Wed, 7 Feb 2024 15:49:16 +0000
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
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CANn89i+tkdGsKVR6hhCSj2Cz8aioBw1xJrwDYLr9fB=Vzb65TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/7/24 15:26, Eric Dumazet wrote:
> On Wed, Feb 7, 2024 at 3:42 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
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
>>   net/core/skbuff.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index edbbef563d4d..5ac3c353c8a4 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -6877,6 +6877,20 @@ void __skb_ext_put(struct skb_ext *ext)
>>   EXPORT_SYMBOL(__skb_ext_put);
>>   #endif /* CONFIG_SKB_EXTENSIONS */
>>
>> +static void kfree_skb_napi_cache(struct sk_buff *skb)
>> +{
>> +       /* if SKB is a clone, don't handle this case */
>> +       if (skb->fclone != SKB_FCLONE_UNAVAILABLE || in_hardirq()) {
> 
> skb_attempt_defer_free() can not run from hard irq, please do not add
> code suggesting otherwise...

I'll add the change, thanks

>> +               __kfree_skb(skb);
>> +               return;
>> +       }
>> +
>> +       local_bh_disable();
>> +       skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED, false);
>> +       napi_skb_cache_put(skb);
>> +       local_bh_enable();
>> +}
>> +
> 
> I had a patch adding local per-cpu caches of ~8 skbs, to batch
> sd->defer_lock acquisitions,
> it seems I forgot to finish it.

I played with some naive batching approaches there before but couldn't
get anything out of it. From my observations,  skb_attempt_defer_free was
rarely getting SKBs targeting the same CPU, but there are probably irq
affinity configurations where it'd make more sense.

Just to note that this patch is targeting cases with perfect affinity, so
it's orthogonal or complimentary to defer batching.

-- 
Pavel Begunkov

