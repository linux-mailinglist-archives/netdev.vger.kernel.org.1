Return-Path: <netdev+bounces-188917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7A0AAF5C7
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 10:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C673A8CCF
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5548C253359;
	Thu,  8 May 2025 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7ENMc9R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46621D011
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746693331; cv=none; b=RR1R3ajLFK1p42VvJB93Mpeb69hwicJXJquojxJmRGc6pV9lRkD3whkjIyF0tYatAUOT4PzVy7I6PjGsk6eYJE/ioW+1w2MDbd/UK4MdbQLnOqvMaENq3MPWWDqml57dHrTRiHznfY0BTuStCJUGbH6uliwBa7yOIP/11tG1NGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746693331; c=relaxed/simple;
	bh=d+eRaON4gKO36pVrUsewobIlwuc6N2VD9Y/OLGnVB/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFRyQkzM2p4BxWMsgB4Hlf0JIc6wzTIRBWxISa0hJ5TvHkDENTA21nRRzIMOZ4xz+NfhhWvMpMZ8Ep/luKR1SdTR+d7VcyGq6xtI9S92I9ZVYsFD/G4N3Z7BXQp3bGcyRVYYAEIfbHcVksPFUe3nqaLKLLVL5BAAys1UILtgGGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7ENMc9R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746693328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4M62nHn16mbtj43jhs1a1Ya/837c5VdSbkl1Tj6DDZM=;
	b=F7ENMc9RWULCJuAmaaub9sTdVgqGzS3E3v0UgZyPXxi32ORdIRoz/cEn+AZJhlj+ud4XJM
	i2rfRlE419E6fuKTHk7nWisDBbk2MhjId2NJGKBpkGCJXYDPfrzGERaphcC6+cfhU6ckd0
	AG/2082dlXbBcVupqawfbCNA04Zxgf8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-iGLcQJFtMI2r5DyHB4WP6w-1; Thu, 08 May 2025 04:35:27 -0400
X-MC-Unique: iGLcQJFtMI2r5DyHB4WP6w-1
X-Mimecast-MFC-AGG-ID: iGLcQJFtMI2r5DyHB4WP6w_1746693326
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39ee54d5a00so296736f8f.1
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 01:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746693325; x=1747298125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4M62nHn16mbtj43jhs1a1Ya/837c5VdSbkl1Tj6DDZM=;
        b=IAw0R0w3hKaTVsT/4EcrD6r365D1AmSla19QgSjJTdXWOJcm5r7NJ7msHptNgo0WPs
         jMhrjHsuGWXZell1INVPsBlkceC/EVVqmKKDVrFos43vqsIFzJRWjWMEMEgWDjVJR//5
         ao+jJRJCBvvI1ldLIaxGpPJ5dCcgtHSa7RlAnH+7pJNe7qcghHJCmPeoTjptxfbUo8ia
         /vBjhOLFxLfynhE4Hptkx3DFYhPMS6BPRu3dc9bXiD+MQrZq+r9sSq64ofB13GReLFKb
         iMg2hzRDzJyWGIHkwAD+NneBKeTcOeGa4YmX0THk99h2Ky/NBZr2qc5tHj+32+pbc871
         yKBA==
X-Gm-Message-State: AOJu0YzKjj7i9jP8So6yKP305apt0qvSGKr+gs7+r1wFF+i6EM6UnAtb
	Xfsh14ITqYnWqTqPGVTI6j5Nd+nb0wKRPHOrxpoDOsZGNYXCtR3HVNJ2j+2Nj7NMPSOEmkytv5x
	xKtEN+FbxaeWDDfrV6wEGqhZuchs/r2oS+M2jBa2TUKFWVAmvNgkByDtcd8XCwEsT
X-Gm-Gg: ASbGnct9oN/souluOxykK6uewHs/uWy2DIgZhvX/aIBqfYJqTpwvWwtJ8yxJ0xFiO71
	KbYUEKVOr5zCpPJuwiLmtY8ZniVzYge5TwBe//ItVkgyMw+GaKJ8JX/AIv0oE5yAT6nPSQkzYV0
	XBSmSjZqEpRhOVHc/F+CKTZIS18VL9ac5Wu/zuv9oJ3wUsSaSPmVqw45+rCLHQj29HDdw9tduIB
	MTIUQ0pEqye5AnyKgEDHAopm5Z6XDUPfLwS5r1t52DmQNpNHiYHDApbt4XIDlkmJ+TLl1BQFdvr
	Nnun7OFW88QrMHna
X-Received: by 2002:a05:6000:2088:b0:39e:e3ef:5cbf with SMTP id ffacd0b85a97d-3a0b49ad00amr5467897f8f.24.1746693325437;
        Thu, 08 May 2025 01:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdkQ12kjOaDez+X3F33D4avCR+1Fpvem1pZxMRObwT/95NwGlb2/DAOGp6j6fQnKe8BfK92w==
X-Received: by 2002:a05:6000:2088:b0:39e:e3ef:5cbf with SMTP id ffacd0b85a97d-3a0b49ad00amr5467870f8f.24.1746693325051;
        Thu, 08 May 2025 01:35:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244b:910::f39? ([2a0d:3344:244b:910::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b170b8sm19097707f8f.82.2025.05.08.01.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 01:35:24 -0700 (PDT)
Message-ID: <5196458f-202c-4ced-b2fa-08eae468233e@redhat.com>
Date: Thu, 8 May 2025 10:35:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 04/15] net: homa: create homa_pool.h and
 homa_pool.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-5-ouster@cs.stanford.edu>
 <1d7a6230-5ece-48f8-9b7d-ec19d6189677@redhat.com>
 <CAGXJAmyizsc1Jk9VytJJ8OcCOTHoqUrgzGZUc1WDeanGyEV6pg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmyizsc1Jk9VytJJ8OcCOTHoqUrgzGZUc1WDeanGyEV6pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/7/25 1:28 AM, John Ousterhout wrote:
> On Mon, May 5, 2025 at 2:51 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 5/3/25 1:37 AM, John Ousterhout wrote:
[...]
>>> +     pool->check_waiting_invoked = 0;
>>> +
>>> +     return 0;
>>> +
>>> +error:
>>> +     kfree(pool->descriptors);
>>> +     free_percpu(pool->cores);
>>
>> The above assumes that 'pool' will be zeroed at allocation time, but the
>> allocator does not do that. You should probably add the __GFP_ZERO flag
>> to the pool allocator.
> 
> The pool is allocated with kzalloc; that zeroes it, no?

You are right, I misread the alloc function used.

>>> +int homa_pool_get_pages(struct homa_pool *pool, int num_pages, u32 *pages,
>>> +                     int set_owner)
>>> +{
>>> +     int core_num = smp_processor_id();
>>> +     struct homa_pool_core *core;
>>> +     u64 now = sched_clock();
>>
>> From sched_clock() documentation:
>>
>> sched_clock() has no promise of monotonicity or bounded drift between
>> CPUs, use (which you should not) requires disabling IRQs.
>>
>> Can't be used for an expiration time. You could use 'jiffies' instead,
> 
> Jiffies are *really* coarse grain (4 ms on my servers). It's possible
> that I could make them work in this situation, but in general jiffies
> won't work for Homa. Homa needs to make decisions at
> microsecond-scale, and an RPC that takes one jiffy to complete is
> completely unacceptable. Homa needs a fine-grain (e.g. cycle level)
> clock that is monotonic and synchronous across cores, and as far as I
> know, such a clock is available on every server where Homa is likely
> to run. For example, I believe that the TSC counters on both Intel and
> AMD chips have had the right properties for at least 10-15 years. And
> isn't sched_clock based on TSC where it's available? So even though
> sched_clock makes no official promises, isn't the reality actually
> fine? Can I simply stipulate that Homa is not appropriate for any
> machine where sched_clock doesn't have the properties Homa needs (this
> won't be a significant limitation in practice)?
> 
> Ultimately I think Linux needs to bite the bullet and provide an
> official fine-grain clock with ns precision.

If you need ns precision use a ktime_get() variant. The point here is
that you should not use sched_clock().

>>> +
>>> +             /* Figure out whether this candidate is free (or can be
>>> +              * stolen). Do a quick check without locking the page, and
>>> +              * if the page looks promising, then lock it and check again
>>> +              * (must check again in case someone else snuck in and
>>> +              * grabbed the page).
>>> +              */
>>> +             if (!homa_bpage_available(bpage, now))
>>> +                     continue;
>>
>> homa_bpage_available() accesses bpage without lock, so needs READ_ONCE()
>> annotations on the relevant fields and you needed to add paied
>> WRITE_ONCE() when updating them.
> 
> I think the code is safe as is. Even though some of the fields
> accessed by homa_bpage_accessible are not atomic, it's not a disaster
> if they return stale values, since homa_bpage_available is invoked
> again after acquiring the lock before making any final decisions. The
> worst that can happen is (a) skipping over a bpage that's actually
> available or (b) acquiring the lock only to discover the bpage wasn't
> actually available (and then skipping it). Neither of these is
> problematic.
> 
> Also, I'm not sure what you mean by "READ_ONCE() annotations on the
> relevant fields". Do I need something additional in the field
> declaration, in addition to using READ_ONCE() and WRITE_ONCE() to
> access the field?

If you have concurrent access without any lock protection, fuzzers will
complains. If that is safe - I'm not sure at this point, looks like
double read anti-patterns could be possible - you should document it with:
	 READ_ONCE(<field>)
to read the relevant field outside the lock and:
	WRITE_ONCE(<field>)
to write such field. Have a look at Documentation/memory-barriers.txt
for more details.

>>> +             if (!spin_trylock_bh(&bpage->lock))
>>
>> Why only trylock? I have a vague memory on some discussion on this point
>> in a previous revision. You should at least add a comment here on in the
>> commit message explaning why a plain spin_lock does not fit.
> 
> I think the reasoning is different here than in other situations we
> may have discussed. I have added the following comment:
> "Rather than wait for a locked page to become free, just go on to the
> next page. If the page is locked, it probably won't turn out to be
> available anyway."

The main point here (and elsewhere) is that unusual constructs that
sparked a question/comment on prior revision should be documented, see:

https://elixir.bootlin.com/linux/v6.14.5/source/Documentation/process/6.Followthrough.rst#L80

I'm sorry, I spent on this series a considerably slice of my time
recently, starving a lot of other patches. I can't spend more time here
for a while.

I would like to outline that there are critical points outstanding.

The locking schema still looks problematic. I *think* that moving the
RPC in a global hash (as opposed to per socket containers) with it's own
lock could simplify the problem and help avoiding the "AB" "BA" deadlocks.

Kernel APIs usage and integration with the socket interface should be
improved.

I haven't looked yet in details to patches after 8/15 but I suspect
relevant rework is needed there, too.

/P


