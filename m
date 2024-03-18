Return-Path: <netdev+bounces-80490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA4687F3D9
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 00:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08190B21400
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 23:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC345D72C;
	Mon, 18 Mar 2024 23:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJE8/Tlo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00955D486
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803619; cv=none; b=Bv44oL2Rnr3Kg+6W3reDo0w382n/CkRF4lWj83wXvWocdBYq9t5dqLsjG1ox1r6XXflqPtn6WmHnzh1LK2TsAcl4qNvr4xmbjMXrZx9dI9VCHNBgKcA8OONib8aEzEILbe0fX7sOnCrOTpHDqF4yyic6dICuzS4KfhGPXVmImMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803619; c=relaxed/simple;
	bh=jSdaQfCNFu7bR0RgK1AvZcKyrf4YRoUHlBAzsc6Lu0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zgr34PPB+MHziYk3maid8rCqaIrIVJwl+Ppe3fU/H5WcQdealA2P+6KBj3efGvt/IC1EYPnjzNwgorqGt0rzOnQu4kEM2D95SoDwUu8OP8EOodL7/rzXZpMLvdjNqMfQ7jYifI2I8jfaa5mvPs5TS2vXyT62z1HOnogvGqJkv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJE8/Tlo; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so85075261fa.3
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710803616; x=1711408416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRrKWgvCg0yO7AL47JrOXbwO0gNC1Jou3jvC+WmYhJk=;
        b=GJE8/Tloj5T1aBbcoyA9O7cnQrMI5b7W7jBQmT8u4PdbD7fusp/1IbnLBkhw/rM+JQ
         Xy7uo9dHsXIgls/M/jE3tAjvo95FQZc9oastFrXEQgO/N8uMKdOt1MdsjSNT9boY2owx
         TapLkoBut6i3Dlhk51k/IpQTdfX9wJDllylMf3z8cv6MivAJ8ou7XM8KTmryJmsFjFaq
         a4m90sG5/C6oq7E1iJeI81v38KO486lc88DjeYFyeICbuxw9sKKJNdhtYXSd7C3yCP1t
         iHQk77gs/+av61ndGknMd5ayLq+8wlPW65a8qcbWMb8yNXOT6rc4avW1xgUl8dyMrSMj
         6WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710803616; x=1711408416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRrKWgvCg0yO7AL47JrOXbwO0gNC1Jou3jvC+WmYhJk=;
        b=seOj09YKhEVqg7Nyspx5H27JO6Z7+Sjle3z2RmsSBR7mR3J3SVn8b07CX6sujeSmMo
         ULpIVJKpE5QL7OZ68DZEtV/kGUrBTL1Ivj4kyomKp2f0Sb+yUFESbV/+UTgLdqIqPA3U
         J5f78CKsmi3FB6ML3515wNTcCqTjbaSTLWiW+pG0BMaKUOQe+Mm4x9zoZztwZCsGPrZh
         /bMpKm27xboWGEQt8vfmypIfhRaYQjlVrSt9Y+SB4zL6V4XCXcwljsMYnvbVboRgi8Dd
         2n3jo5Iv2ooKygohuY3bi9L0lHrtSHOa52eur6GgpyUo7qH6etHeocAOpqjL7f+VjXew
         AXlg==
X-Gm-Message-State: AOJu0Yx60I5tBNT5OL3anm+ykEpEoUqZ1kqkVSNmPVsKbS5N/WzyQIrb
	GrNhqeR1PAyPI1KWPpabY/V0MdUIKxdo64otm5Lj92malSkX0oee
X-Google-Smtp-Source: AGHT+IGn/48HsZWANbyMcsllTut33sRLOp8q/h71GRZ2aEMYCAv7ahk3aQoIj6zP7PhXor8aRUwIAg==
X-Received: by 2002:ac2:53ba:0:b0:513:22ef:4144 with SMTP id j26-20020ac253ba000000b0051322ef4144mr5909966lfh.19.1710803615695;
        Mon, 18 Mar 2024 16:13:35 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.146.160])
        by smtp.gmail.com with ESMTPSA id p5-20020a170906b20500b00a4660dc5174sm5298918ejz.51.2024.03.18.16.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 16:13:35 -0700 (PDT)
Message-ID: <3087f631-6342-49de-a5ae-ceb24b3a51b4@gmail.com>
Date: Mon, 18 Mar 2024 23:12:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: cache for same cpu
 skb_attempt_defer_free
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, kuba@kernel.org
References: <1a4e901d6ecb9b091888c4d92256fa4a56cb83a4.1710715791.git.asml.silence@gmail.com>
 <CANn89iLjH52pLPn5-eWqsgeX2AmwEFHJ9=M40fAvAA-MhJKFpQ@mail.gmail.com>
 <ca2a217e-d8a0-4280-8d53-4b6cea4ba34c@gmail.com>
 <CANn89iKV+P1yCoXHF0DZLjiZK6JL37+4KzAcYcvJgXu7hpEJiA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CANn89iKV+P1yCoXHF0DZLjiZK6JL37+4KzAcYcvJgXu7hpEJiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/24 14:33, Eric Dumazet wrote:
> On Mon, Mar 18, 2024 at 12:43 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 3/18/24 10:11, Eric Dumazet wrote:
>>> On Mon, Mar 18, 2024 at 1:46 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
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
>>>> v2: pass @napi_safe=true by using __napi_kfree_skb()
>>>>
>>>>    net/core/skbuff.c | 15 ++++++++++++++-
>>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>>> index b99127712e67..35d37ae70a3d 100644
>>>> --- a/net/core/skbuff.c
>>>> +++ b/net/core/skbuff.c
>>>> @@ -6995,6 +6995,19 @@ void __skb_ext_put(struct skb_ext *ext)
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
>>>> +       local_bh_enable();
>>>> +}
>>>> +
>>>>    /**
>>>>     * skb_attempt_defer_free - queue skb for remote freeing
>>>>     * @skb: buffer
>>>> @@ -7013,7 +7026,7 @@ void skb_attempt_defer_free(struct sk_buff *skb)
>>>>           if (WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
>>>>               !cpu_online(cpu) ||
>>>>               cpu == raw_smp_processor_id()) {
>>>> -nodefer:       __kfree_skb(skb);
>>>> +nodefer:       kfree_skb_napi_cache(skb);
>>>>                   return;
>>>>           }
>>>>
>>>> --
>>>> 2.44.0
>>>>
>>>
>>> 1) net-next is currently closed.
>>
>> Ok
>>
>>> 2) No NUMA awareness. SLUB does not guarantee the sk_buff was on the
>>> correct node.
>>
>> Let me see if I read you right. You're saying that SLUB can
>> allocate an skb from a different node, so skb->alloc_cpu
>> might be not indicative of the node, and so we might locally
>> cache an skb of a foreign numa node?
>>
>> If that's the case I don't see how it's different from the
>> cpu != raw_smp_processor_id() path, which will transfer the
>> skb to another cpu and still put it in the local cache in
>> softirq.
> 
> The big win for skb_attempt_defer_free() is for the many pages that are attached
> to TCP incoming GRO packets.
> 
> A typical GRO packet can have 45 page fragments.

That's great and probably a dominating optimisation for
GRO, however it's a path that all TCP reads would go through,
large GRO'ed skbs or not. Even if there is a single frag, the
patch at least enables the skb cache and gives the frag a
chance to hit the pp's lockless cache.

> Pages are not recycled by a NIC if the NUMA node does not match.

Great, looking it up it seems that it's only true for pages
ending up in the pp's ptr_ring but not recycled directly.

> If the win was only for sk_buff itself, I think we should have asked
> SLUB maintainers
> why SLUB needs another cache to optimize SLUB fast cache !

Well, it's just slow for hot paths, not awfully slow but enough
to be noticeable and take 1-2% per allocation per request. There
are caches in io_uring, because it was slow, there are cache
in the block layer. And there are skb and other caches in net,
I assume all for the same reasons. Not like I'm adding a new
one.

I remember someone was poking into similar questions, but I
haven't seen any drastic SLUB performance changes.

Eric, I'm seriously getting lost in the arguments and don't
really see what you're ultimately against. Summing up topics:

1) Is there a NUMA awareness problem in the patch that I missed?
If so, can you elaborate? I'll try to address it.
Is it a regression comparing to the current state or something
that would be nice to have?

2) Do you trust the numbers for the test described? I.e. the
rx server have multiple connections, each does small packet
(<100B) ping pong style traffic. It's pinned to a CPU and all
completions are ensured to run on that CPU.

3) Do you agree that it's a valid use case? Or are you shrugging
it off as something that nobody cares about?

4) Maybe you're against the design?


>>> 3) Given that many skbs (like TCP ACK) are freed using __kfree_skb(),  I wonder
>>> why trying to cache the sk_buff in this particular path is needed.
>>>
>>> Why not change __kfree_skb() instead ?
>>
>> IIRC kfree_skb() can be called from any context including irqoff,
>> it's convenient to have a function that just does the job without
>> too much of extra care. Theoretically it can have a separate path
>> inside based on irqs_disabled(), but that would be ugly.
> 
> Well, adding one case here, another here, and another here is also ugly.

And fwiw, irqs_disabled() is not great for hot paths. Not to the
extent of irq_disable(), but it still trashes up a bit the pipeline
or so IIRC.

-- 
Pavel Begunkov

