Return-Path: <netdev+bounces-80293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD0C87E27B
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 04:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0968A1F2165F
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 03:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934281E86A;
	Mon, 18 Mar 2024 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYRrne4B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE861E866
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710732117; cv=none; b=M21v3dJi+lnCDgz4W7u7C+Z8KseiEEMh/GFyIKFwhtve3rR/sP0qGH4QfLFpSV8S9XGluNpCoBLyfIgX53krjmZedMILy5g7LWsz3IzL+HYwuUg/PRzrC3w0CZsux6o0IrwYKsbqL0ijB4nc74CMAA193c/BxqSejBBEZyfLgVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710732117; c=relaxed/simple;
	bh=1b+jIYsFMZiQ+brvQrHYX2I9JvQ12SxKM8slO/IjM+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+qX6iGkDBW5cTH1qFZVfEoZrISmvqU5+Sv23xwFZTHAc8vSfomYWt4otMMe4g8kdoiDunqbBdPxolgIhU8FUBLCLeWDCH7JJUSkzhs4uPd2T9RQ3HnDolWr9U2p4fGynJPlCMC8boWOiAsgVogN96quFlwvd+bzIXs1dtN9R5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYRrne4B; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56acd06c016so223616a12.3
        for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 20:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710732114; x=1711336914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fa2J8AekP07I0JSi+DvM6gK1aNzLQ0k3ycUKIV68zfs=;
        b=aYRrne4BVkTPM04LGyelywEDLC1fbfxW6sEI5naZdycWfjaO7aUC6jivHKePQGfxua
         RMjG5EZawx0Ebt39nz+8skD04QsoxTePF395X6ythgP9Kg7dLHaZwO/q8Ywtxzsb2bkv
         3zUNkEZuY0UGXtqkU2cO+xGMh0KMKipYAL+C+nHOMuRscFMRk1iLu5Tb9MW8TZyeY/B7
         rBnRuwaUmbmhqUJsB6ySXBtvSgVPo53wAeV7+jSyvUeuM3LBMs1y0rAs4fF6W4IS/Hpw
         4MJM35Vjm9iFFRerjBL+MyopFhdfpcsnxZ2mscEKPe2fQ5H0+BJuii9Lb1oxt6wO4F3+
         IlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710732114; x=1711336914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fa2J8AekP07I0JSi+DvM6gK1aNzLQ0k3ycUKIV68zfs=;
        b=Tdag0JAm+r0Xpvj6YF/jVtZkOyIRD59s78ab5Kneii+Sdak1Fqca+M+aZGbVDTETep
         GHsN67xUUKyWHhPvOutLdsDsEBz2JAQI7ZLxK/p23rRN55Tw9FO5KXZrqYoSxem9k3fh
         P0KZp3MSkyn8BbUChbhTftk2ejsNWW9JV8Z0MbMrgziV9IAWnHfdyi6KrXrmsPEAUyXG
         HnVjIlMDizFNlNmm5r7qoMMa2nZB+3I10zXs1ffibZcrFaLG02Sc2yLX+IGXo7Mo3/X/
         Avzw+viSdwPy89D2H577NSMrINRTdfwYQSUApGrOE5Wn/WUJepCXvYzDiz1Duq0s/2kf
         Y6nw==
X-Gm-Message-State: AOJu0Yw6xG8k9m2+kDMlQT/12a+VBeqVfInFTw5ljYeVnd+iCbBZnf+Q
	qEU8oTDElkqjhMUr6Ss/wT0HCUfMfBj8HxJhehxNAkXJVVXeiJib
X-Google-Smtp-Source: AGHT+IFutayT3PJuQ7i7junPNFLhjHXH3Jg3UVbb/04KTyoJFQE+ERf515xHzGZd29q2TdpMoHD7Lg==
X-Received: by 2002:a17:907:9621:b0:a46:6f8f:d7f0 with SMTP id gb33-20020a170907962100b00a466f8fd7f0mr8915493ejc.3.1710732113874;
        Sun, 17 Mar 2024 20:21:53 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.232.181])
        by smtp.gmail.com with ESMTPSA id x25-20020a1709065ad900b00a466af74ef2sm4325761ejs.2.2024.03.17.20.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 20:21:53 -0700 (PDT)
Message-ID: <48dab68e-2c10-444c-a219-0e1c05091573@gmail.com>
Date: Mon, 18 Mar 2024 03:20:33 +0000
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
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
References: <1a4e901d6ecb9b091888c4d92256fa4a56cb83a4.1710715791.git.asml.silence@gmail.com>
 <CAL+tcoA=3KNFGNv4DSqnWcUu4LTY3Pz5ex+fRr4LkyS8ZNNKwQ@mail.gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAL+tcoA=3KNFGNv4DSqnWcUu4LTY3Pz5ex+fRr4LkyS8ZNNKwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/24 02:44, Jason Xing wrote:
> On Mon, Mar 18, 2024 at 8:46 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> Optimise skb_attempt_defer_free() when run by the same CPU the skb was
>> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
>> disable softirqs and put the buffer into cpu local caches.
>>
>> CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a 1%
>> throughput increase (392.2 -> 396.4 Krps). Cross checking with profiles,
>> the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Note,
> 
> I suspect that we can stably gain this improvement. The reason why I
> ask is because it might be caused by some factor of chance.

I guess it might be the kernel is even booting only by
some factor of chance, but no, the testing was quite stable :)

>> I'd expect the win doubled with rx only benchmarks, as the optimisation
>> is for the receive path, but the test spends >55% of CPU doing writes.
> 
> I wonder how you did this test? Could you tell us more, please.

Well, the way I did it: choose a NIC, redirect all its IRQs
to a single CPU of your choice, taskset your rx side to that
CPU. You might want to make sure there is no much traffic
apart from the test program, but I was lucky to have 2 NICs
in the system. Instead of IRQs you can also try to configure
steering.

I used netbench [1] for both rx and tx, but that shouldn't be
important as long as you drive enough traffic, you can try
iperf or something else.

[1] https://github.com/DylanZA/netbench


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
> 
> __napi_kfree_skb() doesn't care much about why we drop in the rx path,
> I think. How about replacing it with SKB_CONSUMED like
> napi_skb_finish() does?

I'm sticking here with the current behaviour, __kfree_skb(),
which it replaces, passes SKB_DROP_REASON_NOT_SPECIFIED.

I can make the change if maintainers ack it, but maybe
it should better be done in a separate patch with a proper
explanation.

-- 
Pavel Begunkov

