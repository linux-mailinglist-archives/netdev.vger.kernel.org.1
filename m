Return-Path: <netdev+bounces-85224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0742B899D1F
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA2C1F215E2
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BB71E88D;
	Fri,  5 Apr 2024 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Csa+ZMGq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3231DDD1
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320547; cv=none; b=dTKk5AOgKQnG72qu8JslUbOBmLXhNF9eBxhKdLIevuSaXIjVonp9aA4UYu/jAGYwVDIoQVLpjVyresV9fHU3JT+0bAoewuBEzO0r9HGHXkpgtPGXgPlc8zAG6rFPHwldCp9UeqSD++yn2SQYovGZw/ykJiCqWtcXM54aF4DrX9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320547; c=relaxed/simple;
	bh=Q9vhm5FRlOkkkbfDsZj7HumJJiJ4VtgzxtuyLrqEiXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gh8+8tDauW+GG1ylat+5b0k44Qu7sds2zevIU8dp8qq/P3Ye3gC7tZALm3/XKL/1HGpdzG3p/nPxcAc+czBJu+AtpXGKca7pADiGIm2HJZCy7XH/om8IADUH9rc2hMgwt6SWYdlCuRQjqjxIy5wFTB59YndvCNF4uj56WrWr4d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Csa+ZMGq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4a393b699fso354558066b.0
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 05:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712320544; x=1712925344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPEf7BaqLAvEZyxALaYiZtGhgUAPswFGj7PStVcK48s=;
        b=Csa+ZMGqUCLaCaU3uc3t99yLTx8jE5+bf4Pk/ZQcPrWgvgxPcj5zLxfohzGVTFrTBJ
         wH9O5GH7lj8CG7e/KRplAEe5HWsYaC3evEwkz39d3bqvmI5DSal2Yo16zFEgsD8WyTsA
         MC9NdYjxSrJeKeDhIz8mPo7Ii6j/yqWXlzv6j4fUhX4g1NzRUi/Rh7d4H5dZ4JcFcayU
         IUk9giLrACErGKXu6+H7gWb4Ssg97C0ccVf8KIWXfso4Zb/zQpNIlqi5VDF/N1Y5JpjT
         OcIYN7jLqWYGES2lZ83BX7C0Zy7GO5fDCVFtRFXR/Cj1Jj2g6WZyPQ5zkbUxJtp5sRMC
         z9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712320544; x=1712925344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPEf7BaqLAvEZyxALaYiZtGhgUAPswFGj7PStVcK48s=;
        b=SBeTnbof0xv0N3rvj12gH321zzqSmSBJJPVHqv/vJsb5W+2lP6moUzc3Ut6BtmRlGM
         Lm53F1MkUeqC7Qla+4JvHEEUguxxlwW+NuPropEmUXB2Ig6tk3qPVyVVfNeSHax0YtKn
         6bb+KUUUf3Obe+zG1AAzWQoYg/h+YWXvaXYcaJKg7VKshny3yZRSAVWGPAoBfcIZ+2t3
         DHEbWoNYvtw7s0SOb/wyXElcyXIgC6gm2hZfqCypMe7lXkzOFClOc9VJ0FEo2tQuEJj+
         7IckIQwFhFgS/MJs2P5uYhwDNlOptLTmPMKlZ5WFWx7surk5Z1czJ4WcUP68jPZPeqCN
         SRuA==
X-Gm-Message-State: AOJu0YzF+2RKJYfhS+rQKgq7Qvpn1V9PULPP2ike5aK38XeNgGIA36r3
	o0BOM/iexmbiVALGLXz+zNnahA10Gs3TdvxkQ77cFn2VGBujGIWb
X-Google-Smtp-Source: AGHT+IFCR8wEkRoIl0YOcEXHehxTEq6uIG2KzGjxKQeKqWt01HcaN1jAMpxNGJzCEzRmWxw0/NUr0Q==
X-Received: by 2002:a17:906:260d:b0:a51:7e6f:a73 with SMTP id h13-20020a170906260d00b00a517e6f0a73mr1385954ejc.17.1712320543649;
        Fri, 05 Apr 2024 05:35:43 -0700 (PDT)
Received: from [192.168.42.78] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id u15-20020a170906408f00b00a4e583adcc7sm780651ejj.99.2024.04.05.05.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 05:35:43 -0700 (PDT)
Message-ID: <30882f03-0094-42c7-b459-3f240ae94f20@gmail.com>
Date: Fri, 5 Apr 2024 13:35:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v3] net: cache for same cpu
 skb_attempt_defer_free
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, kuba@kernel.org
References: <00c5b7641c0c854b630a80038d0131d148c2c81a.1712270285.git.asml.silence@gmail.com>
 <CANn89i+XZtjD1RVBiFxfmsqZPMtN0156XgjUOkoOf8ohc7n+RQ@mail.gmail.com>
 <d475498f-f6db-476c-8c33-66c9f6685acf@gmail.com>
 <CANn89iKZ4_ENsdOsMECd_7Np5imhqkJGatNXfrwMrgcgrLaUjg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CANn89iKZ4_ENsdOsMECd_7Np5imhqkJGatNXfrwMrgcgrLaUjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/5/24 13:18, Eric Dumazet wrote:
> On Fri, Apr 5, 2024 at 1:55 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 4/5/24 09:46, Eric Dumazet wrote:
>>> On Fri, Apr 5, 2024 at 1:38 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>
>>>> Optimise skb_attempt_defer_free() when run by the same CPU the skb was
>>>> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
>>>> disable softirqs and put the buffer into cpu local caches.
>>>>
>>>> CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a 1%
>>>> throughput increase (392.2 -> 396.4 Krps). Cross checking with profiles,
>>>> the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Note,
>>>> I'd expect the win doubled with rx only benchmarks, as the optimisation
>>>> is for the receive path, but the test spends >55% of CPU doing writes.
>>>>
>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>> ---
>>>>
>>>> v3: rebased, no changes otherwise
>>>>
>>>> v2: pass @napi_safe=true by using __napi_kfree_skb()
>>>>
>>>>    net/core/skbuff.c | 15 ++++++++++++++-
>>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>>> index 2a5ce6667bbb..c4d36e462a9a 100644
>>>> --- a/net/core/skbuff.c
>>>> +++ b/net/core/skbuff.c
>>>> @@ -6968,6 +6968,19 @@ void __skb_ext_put(struct skb_ext *ext)
>>>>    EXPORT_SYMBOL(__skb_ext_put);
>>>>    #endif /* CONFIG_SKB_EXTENSIONS */
>>>>
>>>> +static void kfree_skb_napi_cache(struct sk_buff *skb)
>>>> +{
>>>> +       /* if SKB is a clone, don't handle this case */
>>>> +       if (skb->fclone != SKB_FCLONE_UNAVAILABLE) {
>>>> +               __kfree_skb(skb);
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       local_bh_disable();
>>>> +       __napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
>>>
>>> This needs to be SKB_CONSUMED
>>
>> Net folks and yourself were previously strictly insisting that
>> every patch should do only one thing at a time without introducing
>> unrelated changes. Considering it replaces __kfree_skb, which
>> passes SKB_DROP_REASON_NOT_SPECIFIED, that should rather be a
>> separate patch.
> 
> OK, I will send a patch myself.

Ok, alternatively, I can make it a series adding it on top.


> __kfree_skb(skb) had no drop reason yet.
> 
> Here you are explicitly adding one wrong reason, this is why I gave feedback.

-- 
Pavel Begunkov

