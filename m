Return-Path: <netdev+bounces-161079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0083A1D3AC
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5033A1F4D
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 09:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C1D1FCFE6;
	Mon, 27 Jan 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnFwG6HO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7031FBEBC
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970882; cv=none; b=R9XKv/AlJmPNholATnRj6qcWyHb4q6++/6ThNpMGjLlQxgwSSyN4O2dSMjlL2kei33CQ+0NFiX4QCwTkkJKW3y6tjGCVammaXiNKvnZEu/lw1ZDKmeN4ihvFUgW3Ka/T71AJUciwrAOhRGt7TyhF/duIEU496K7xYfm9f6uNYjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970882; c=relaxed/simple;
	bh=Vh0YpHIcneIEqjkfRJ3WsAFw3UXgK6dGsGV67o4k9ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UP84WPNMftOrhXXEGQGRocgNxKq3oBVwWsSkm33w9blYDU4KVFlYmJAZUcH2cyNfX0LLrpOaF4UysdavA/DSdmSB0eLuspfh/PhBLyfp4DFgqOQRtj3vW9TJTQXrF1Gc6buOFRhkgEaq43aIduBoYy1fkZb4dx+iGv8fvcpfbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnFwG6HO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737970878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZ2hI7n69a4AOR2SoCss1C4rYT+akeHKKW1KyuNfloI=;
	b=SnFwG6HOLOhvxmU6VIskwJfMh8PAIjcCoodp9J/rpbfbB/PRTeyLN2hGRlrgyGg5PVdAbK
	r4oCfY1JqanFdI7mTH61SJSL86kwb6er3H7H2+SerBZ+SIh2yBWQEaHcwgJO8+Ke9ZuKco
	Qu5AWm0J/bNoAfEt4wfYyLLA++XWSjs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-X0lim3nFO3Oy8RvfdaQkow-1; Mon, 27 Jan 2025 04:41:17 -0500
X-MC-Unique: X0lim3nFO3Oy8RvfdaQkow-1
X-Mimecast-MFC-AGG-ID: X0lim3nFO3Oy8RvfdaQkow
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43625ceae52so22686905e9.0
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 01:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737970876; x=1738575676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZ2hI7n69a4AOR2SoCss1C4rYT+akeHKKW1KyuNfloI=;
        b=vErKKcIjycYm8vr1+/eGxc8CLONJ5VsN9GYRlchNM5ZyX6K8q+LIHELPwvIb+wlbci
         cvKwev2BnaWUEqZJvBE8/gik9JkEI74puD1W5j+i6jVHiguAnKFaMd4wwtvl8fmKBFYu
         TEzdvo9utxJnrJ7Yv81qgb3X4AUncZWiYSCYD6PVsXB8a3YPT1cvrJTEcPFOrVBAE1Wp
         FuiISUux6k5E+/BoPlvR4SP6gRaEen5eK+JVMu2WgnGouBGVShO+A+Q1t8XPj4iW6Awe
         uFsfmLLuBNye9BuwFgCqrith9cIf0yp24cIlCy0QNC1ll7RXnQklcUSn+cknR4iiN9i+
         L/WQ==
X-Gm-Message-State: AOJu0YzfrStMVTthzB12xjWF6TPLI3tBO5cSUvnccwhv1UPsjXXbG7+w
	P0KZOfO6XEnRKY9tH/nRxqb7OBSN/pB0cx5shdYLzGj8dYCkh3BsEu9YKRP/+FkLD2z8TND9aic
	AjDdEsRGZiYrcieGrinDcrS5V9uT9TSc9oZFvasnl56Ge4ZB98BpF0Dhaa5MV4w==
X-Gm-Gg: ASbGnctT5iedTJEHLc9B7IpVmBYCxdzD1dOoLVtYE+3aPXu/px3I5y+YGa824tz0yQ5
	hfFC68JXbVM77odkWLxK5d7P6DSdGX4jCmLpZjmoYOkoOgCInQb1VNzsDXTduM94xu2TebfbS8Z
	x4cZpDYDXoLLqdp6Zo5TOPtCvasywZqLhpBQBFQi4w4u1I1eUel4EcDW+jkcLfKUehV28s6auj8
	z+Mb65B3j6b6dAT/nt06DaQSvik05UetqiusIPWlgv+6gzVwZ3i47Z9EXINSUTkCvRETIJIta1s
	QOFCZCxNv5sB0iAgPgY6/pZwU07YInA3KV8=
X-Received: by 2002:a05:600c:3484:b0:434:f8e5:1bb with SMTP id 5b1f17b1804b1-438913e48fdmr379299165e9.12.1737970875862;
        Mon, 27 Jan 2025 01:41:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMPPIIceVzpoSemVrt5k8yJHPC7Scw8DAuNcRNiO58raIiIAPmuqfE+MMKuaa4Z2AgVZYVsw==
X-Received: by 2002:a05:600c:3484:b0:434:f8e5:1bb with SMTP id 5b1f17b1804b1-438913e48fdmr379298925e9.12.1737970875540;
        Mon, 27 Jan 2025 01:41:15 -0800 (PST)
Received: from [192.168.88.253] (146-241-95-172.dyn.eolo.it. [146.241.95.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb0dfsm10814583f8f.63.2025.01.27.01.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 01:41:14 -0800 (PST)
Message-ID: <4e43078f-a41e-4953-9ee9-de579bd92914@redhat.com>
Date: Mon, 27 Jan 2025 10:41:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 04/12] net: homa: create homa_pool.h and
 homa_pool.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-5-ouster@cs.stanford.edu>
 <a39c8c5c-4e39-42e6-8d8a-7bfdc6ace688@redhat.com>
 <CAGXJAmw95dDUxUFNa7UjV3XRd66vQRByAP5T_zra6KWdavr2Pg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmw95dDUxUFNa7UjV3XRd66vQRByAP5T_zra6KWdavr2Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/25/25 12:53 AM, John Ousterhout wrote:
> On Thu, Jan 23, 2025 at 4:06 AM Paolo Abeni <pabeni@redhat.com> wrote:
> ...
>>> +     pool->descriptors = kmalloc_array(pool->num_bpages,
>>> +                                       sizeof(struct homa_bpage),
>>> +                                       GFP_ATOMIC);
>>
>> Possibly wort adding '| __GFP_ZERO' and avoid zeroing some fields later.
> 
> I prefer to do all the initialization explicitly (this makes it
> totally clear that a zero value is intended, as opposed to accidental
> omission of an initializer). If you still think I should use
> __GFP_ZERO, let me know and I'll add it.

Indeed the __GFP_ZERO flag is the preferred for such allocation, as it
at very least reduce the generated code size.

>>> +int homa_pool_get_pages(struct homa_pool *pool, int num_pages, __u32 *pages,
>>> +                     int set_owner)
>>> +{
>>> +     int core_num = raw_smp_processor_id();
>>
>> Why the 'raw' variant? If this code is pre-emptible it means another
>> process could be scheduled on the same core...
> 
> My understanding is that raw_smp_processor_id is faster.
> homa_pool_get_pages is invoked with a spinlock held, so there is no
> risk of a core switch while it is executing. Is there some other
> problem I have missed?

raw_* variants, alike __* ones, fall under the 'use at your own risk'
category.

In this specific case raw_smp_processor_id() is supposed to be used if
you don't care the process being move on other cores while using the
'id' value.

Using raw_smp_processor_id() and building with the CONFIG_DEBUG_PREEMPT
knob, the generated code will miss run-time check for preemption being
actually disabled at invocation time. Such check will be added while
using smp_processor_id(), with no performance cost for non debug build.

>>> +struct homa_bpage {
>>> +     union {
>>> +             /**
>>> +              * @cache_line: Ensures that each homa_bpage object
>>> +              * is exactly one cache line long.
>>> +              */
>>> +             char cache_line[L1_CACHE_BYTES];
>>> +             struct {
>>> +                     /** @lock: to synchronize shared access. */
>>> +                     spinlock_t lock;
>>> +
>>> +                     /**
>>> +                      * @refs: Counts number of distinct uses of this
>>> +                      * bpage (1 tick for each message that is using
>>> +                      * this page, plus an additional tick if the @owner
>>> +                      * field is set).
>>> +                      */
>>> +                     atomic_t refs;
>>> +
>>> +                     /**
>>> +                      * @owner: kernel core that currently owns this page
>>> +                      * (< 0 if none).
>>> +                      */
>>> +                     int owner;
>>> +
>>> +                     /**
>>> +                      * @expiration: time (in sched_clock() units) after
>>> +                      * which it's OK to steal this page from its current
>>> +                      * owner (if @refs is 1).
>>> +                      */
>>> +                     __u64 expiration;
>>> +             };
>>
>> ____cacheline_aligned instead of inserting the struct into an union
>> should suffice.
> 
> Done (but now that alloc_percpu_gfp is being used I'm not sure this is
> needed to ensure alignment?).

Yep, cacheline alignment should not be needed for percpu data.

/P


