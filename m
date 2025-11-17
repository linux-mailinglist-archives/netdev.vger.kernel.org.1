Return-Path: <netdev+bounces-239083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD49CC638E4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 73811241C7
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB3324DFF9;
	Mon, 17 Nov 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyGwAoXf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEayhzCH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0372459E5
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763375496; cv=none; b=HSxwqikCkx3XRtZq9W5BypnmK96Ot7CeN+TAoPT2XDo/LWNjpMx8r9Da3O4uDrSYOOD8x/+6KJrl2zhdiXHE45WxihioKwP0/qTHEIUAkoSOuYVcjqoQNZbW+1u7ZuAUBhkPAshill9a0Z0nfrFX0yosTEoPQP2BKJ4HEAkwc2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763375496; c=relaxed/simple;
	bh=b88KUAl8Zd6tGkohPzAcMZtQTEiL8lU7HAjSwqdprPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bcs9VCFyJpOgKQxKVkYoW3/HQfIQ0jja9c+8GfWsQxYO9X675gdLl/gmhsU7LScnJw6QOU88uVk0Ycy8so2t5TwJmaTViMb/7Dsp2GCl8Is18k3qGNMqghiat6lx+i6ZlyCGQ4B7fj1/w4Dtzi5V/FheliD7UBk2mqKEYlN5s7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyGwAoXf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NEayhzCH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763375494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqnTqzFCQtJFZggQ7LJSZuHS8ER09p5WkRmsxk7Kq3U=;
	b=OyGwAoXflE2PXIPOdRIGpKXe14B77gYOFutWz7iX4dR1OcizKtQPrK/GrvwkPsZEtlXYSL
	h+K4rVJ9Gp/2DVbMBx+BAO12yi/FLEWtISrYbEf7JYiZWoJiSZJeOAvCvzwCdhbatcY8mS
	J3eQickJ299bhPjuInX/LTrv5pv6UjQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-cPAciMF4Nfa-4XKrCpR8MA-1; Mon, 17 Nov 2025 05:31:32 -0500
X-MC-Unique: cPAciMF4Nfa-4XKrCpR8MA-1
X-Mimecast-MFC-AGG-ID: cPAciMF4Nfa-4XKrCpR8MA_1763375491
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779cb470a7so12961725e9.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 02:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763375491; x=1763980291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cqnTqzFCQtJFZggQ7LJSZuHS8ER09p5WkRmsxk7Kq3U=;
        b=NEayhzCHJdTjyrlAYV+QkWud5Lqz2YbDblCn73YPnF0GJXtma6n1QHiz+FNrvJ1cpT
         YyR9Y4ZjjbaU3tHsil/SLGXNxXNgmMhGGSzCNKVYI5vwZY4+jkZrErRoLGu7rEjN5SDT
         Unmv594BlH14KKP9m5k+/+QHNY0EBP4fz1P4dIuEF7+VUAvrvoi5gqKQ2gQxUkALaVHC
         Gw0Pg48s6JCZ+18zlPa9Cwv4x2RpZ8X4eq5P0cGzK9aWXIs6bCHHy9u5qOFf1e1vAJSN
         9GcWBMin9joL/z1lGUz4YSe7pOp9Zi0veiosdRUrvwvsHHk5rqPPYaVt7fma3+UvWXmJ
         o7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763375491; x=1763980291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqnTqzFCQtJFZggQ7LJSZuHS8ER09p5WkRmsxk7Kq3U=;
        b=fIw5BLUFOZ7X78ZZGK5SjWJLVXdbLdgJrSqbVr/8IuetE1l7kg1yO2dC1dwjA03Ift
         Q/VQXG6hxo4px3EBX7uh7p17PdYhufEWh2fYdlf/Oc4iCKH+8i/C6HPHR37MbfCgtXvL
         5x6vE6QmZ4nRsN+h6zrHHNNE3hzoG+LfkQKhk2xAKz6jtehcpcrOO2qRTY3h0k03wnmW
         c9VtzW4cg/kLtsC8T9kWO1k8+fxK4hxTDEWSMUoGEXevLBto+3udHwyMFS4coSBkrEYU
         X968xZikm65f6fhbFnGLR4sVaXyDqKdFxFTRMz34hFevsufAB6Bi9j/KT/FjTPbGhIhC
         IOSw==
X-Forwarded-Encrypted: i=1; AJvYcCUmb4wgDVRmvepC1B6jFOX8NkBrUwenWR5uxrvDLx+tui6d2wkZfRE8Lb35tZ0DdYzfntCEpbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUFyYdngw70oIwBKKPeq2yRMdONdat9KdnQXhBrKVNtyxjdJV
	Q3gWj31tzXVuLG9A7PrClri8Pu2mycCNpgMTzGNHCfPgibF0tM6YwL3hYttbjJYuNxMK63wbJq+
	7l97Rtzt7TbFjvzLeKsWHm7Ut6yvGshTkz6GAwoWKL+q6iUCuZXZDg4JCag==
X-Gm-Gg: ASbGncvlToSsrHNEvHttRuDfojq9EUzkoHkrs/Y4RKJw79IA2F0VIdJg2y7Q98raXu3
	t+m3LUURnwq/qJDOGnJk2DtBdpiKxDRWvQV6Z/soQr7E2wvbwnYIl0ki55KgWTfVdroKTTcYlSe
	QdVOo50Q8OViygljsA3g0vh/nJQrgbc08cJmWmFGDrY0V03Uy8ETFpa07nTw9L1ukeJpbrt6JOq
	xpGU/nS90c+nt4QoBfP5SKVLLo73E6KIjNGTp6Mg1iY1CdHyxxM4cDliYxtgmzsSTdlJ8O3NwD/
	/Lh56YNMqMx41m8Ba/S7jTwcrgRNzNHuuh1DD+Vx2xtMZkA5KYf81Fcw6raoI6yXd/5ieQg9AcR
	40md62PpmzDV6
X-Received: by 2002:a05:600c:630d:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-4778fea1becmr126521205e9.31.1763375491207;
        Mon, 17 Nov 2025 02:31:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc39hXxP4Hh7/0FkA7jCbVYt3Vd0aMc6zeH/KYofdSxZO6ZXPntTe/bNmO+IwQJFOikJZwNg==
X-Received: by 2002:a05:600c:630d:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-4778fea1becmr126520705e9.31.1763375490729;
        Mon, 17 Nov 2025 02:31:30 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a2422d93sm22777465e9.0.2025.11.17.02.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 02:31:30 -0800 (PST)
Message-ID: <ada0888a-7590-441e-ba01-f53038b3cc77@redhat.com>
Date: Mon, 17 Nov 2025 11:31:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/3] net: use napi_skb_cache even in process
 context
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Jason Xing
 <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20251114121243.3519133-1-edumazet@google.com>
 <20251114121243.3519133-4-edumazet@google.com>
 <74e58481-91fc-470e-9e5d-959289c8ab2c@redhat.com>
 <CANn89i+o6QAUXJkmVJv1HTCGxK05uGjtOT5SUF4ujZ4XCLQRXw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+o6QAUXJkmVJv1HTCGxK05uGjtOT5SUF4ujZ4XCLQRXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/17/25 11:19 AM, Eric Dumazet wrote:
> On Mon, Nov 17, 2025 at 2:12 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 11/14/25 1:12 PM, Eric Dumazet wrote:
>>> This is a followup of commit e20dfbad8aab ("net: fix napi_consume_skb()
>>> with alien skbs").
>>>
>>> Now the per-cpu napi_skb_cache is populated from TX completion path,
>>> we can make use of this cache, especially for cpus not used
>>> from a driver NAPI poll (primary user of napi_cache).
>>>
>>> We can use the napi_skb_cache only if current context is not from hard irq.
>>>
>>> With this patch, I consistently reach 130 Mpps on my UDP tx stress test
>>> and reduce SLUB spinlock contention to smaller values.
>>>
>>> Note there is still some SLUB contention for skb->head allocations.
>>>
>>> I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
>>> and /sys/kernel/slab/skbuff_small_head/min_partial depending
>>> on the platform taxonomy.
>>
>> Double checking I read the above correctly: you did the tune to reduce
>> the SLUB contention on skb->head and reach the 130Mpps target, am I correct?
>>
>> If so, could you please share the used values for future memory?
>>
> 
> Note that skbuff_small_head is mostly used by TCP tx packets, incoming
> GRO packets (where all payload is in page frags)
> and small UDP packets (my benchmark)
> 
> On an AMD Turin host, and IDPF nic (which unfortunately limits each
> napi poll TX completions to 256 packets),
> i had to change them to :
> 
> echo 80 >/sys/kernel/slab/skbuff_small_head/cpu_partial
> echo 45 >/sys/kernel/slab/skbuff_small_head/min_partial
> 
> An increase to 100, 80 was also showing benefits.

Many thanks! Also, I'm sorry for replying to the old revision, I'm still
behind the patches backlog.

> It is very possible recent SLUB sheaves could help, I was enable to
> test  this yet because IDPF in upstream kernels
> just does not work on my lab hosts (something probably caused by our
> own firmware code)
> 
> Anyone has a very fast NIC to test if we can leverage SLUB sheaves on
> some critical skb caches ?

Not here. I mean, I could test on 100Gbps links but I guess you need
significantly more, right? Also the CPU is nowhere near the power needed
for packet rate mentioned above.

/P


