Return-Path: <netdev+bounces-161085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8532A1D400
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 11:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4BCC7A2BC9
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8DA1FC0F1;
	Mon, 27 Jan 2025 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apNMaAti"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7103FFD
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972124; cv=none; b=BgkfgnbdDOlexh5VFEmuOFxdJj5lPr91zgJ0xUyed0kFLOJerz7Xk5pGL2BHL0bocIVsGvoTufS5UcMyCG2DV2R4/Qw4XGKwxul7dL9f14Nju+dPzd4JUsJ4fXJghCdLhynX/EjGFHcADn8kKqSDatO6U7nM/Zo7Xt7GyuZktBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972124; c=relaxed/simple;
	bh=B8y1ONe/+TGZzQfZ6BGBlOt9/Wzs88AoO3lVq+nTh9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1o1P4z1kUiRNFfXsNx3XKVCPJwbIjlXjIe336ZqiO74uulUtBpqj/3myRrzPawHwr3L4daYN5f5JRdBP4Vmaj88lNr0OSdfdDq4Vq3JENnoyDufxKFfq6tpOYVaPG8njHzvLlvfKFJa2aHp5IhURt0bjpCNdwBeaH8BLneqgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apNMaAti; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737972121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFZOHZcg3Qx0OcvWeZvQVyEDdj3ZOmkXZvkyYP7ymEQ=;
	b=apNMaAtizsiQQIccNQvPN6KGeHUYVkDpyHtGwsSPpE8jKdj6qeP+tNDVTtqZOzWv5lZ2NQ
	7nXlFDMdW2XqS71nIejwCi5aU/snSjC+PrkOiAB9u8F8j0yP5xnVLDbdv2XQ1O2cq0cAUn
	IMjaDYY5rSFQF8tabbemwMESO+04T64=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-pIMFrqKWOd2xMYwXdbXJ1A-1; Mon, 27 Jan 2025 05:01:58 -0500
X-MC-Unique: pIMFrqKWOd2xMYwXdbXJ1A-1
X-Mimecast-MFC-AGG-ID: pIMFrqKWOd2xMYwXdbXJ1A
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38a35a65575so2793613f8f.1
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 02:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737972118; x=1738576918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFZOHZcg3Qx0OcvWeZvQVyEDdj3ZOmkXZvkyYP7ymEQ=;
        b=LxvNb3zoiQg4dEu3amPZY2iLDsi37hhbgbN/W41We7cd1HiuTyPlwjL94Tq4YQ3EfW
         L3PLBFol9TcSL7IxS9Wgf0EX+sGVX2Saf56/ijFAQ3bMlgOQJ1qPouEwitE4FjSsc6yC
         y6x+2uy7yvN7JMsmND6WZj+6sWKxXOE0d+8rCWzQE+gU/eo0fI1fVS3cTReUVyh1+t4g
         Ob/j4xlW7L4pkAfuEe8ei5QQPpWTfzxuJdQvLK1sNJD1dcv6sKhFzTVi1GHxkx2FF/7+
         mtBMVLRkTKEgRrJKf4AxN4lnYShHx664tvO6ahKwNYyTLF2t6dyYEoCx2wSynJUVHBLl
         pgGQ==
X-Gm-Message-State: AOJu0YyzBZ7z8Sl41TcmSKUDNkVA5qclwmRutameDuxhlrmWL3e+sSrr
	7hkhb+bPX2Cq8/BJQF/A3LJ9l7uJxuyfX3F6UdAzzzom1bi5+c760lJUaXeWI21V+5FPm+DqmCl
	rYsQrCwbcTznZKoYk8UqbK02zlLwmBwZrCE7e3E9lY4o9Ty5K7sEpJw==
X-Gm-Gg: ASbGncsMY76XQD34jI1fleCB3aRbxMIvOSxIMUpL1W05iQI7+U4EDuSdQMq/u0zzWLp
	6kLH3IHFvVfvyGShkASeFBugWjiXiFKf4vgZt9tI7a19knGI/jCjJ3QCtXK/nhXlIZdmBX7+ym1
	mVtoaB+mFRTnFu8zc1snOniDUfzS6FO/UyQJ9mYprQGR5H989K1NT48cKc6gzdIJO79jZrvAmYw
	AhxF0ZyAh2tSbtTGJG3SfW77/Td5VyYsf7P//0JORauBpeCCA8AVFGyjA3G9wjncB8AO8kuZOFj
	8fQJSDozQCjP0ymce/pvcUDbD61ArbEznRM=
X-Received: by 2002:a05:6000:402a:b0:38a:a047:6c0b with SMTP id ffacd0b85a97d-38bf57a97e0mr40573081f8f.35.1737972117628;
        Mon, 27 Jan 2025 02:01:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwuO7rGVsT0WbHefUe0qlzfeg7gMn97k/Ijz7A7MBN/KGcNhnXwkNx/zJv7Yq5MpgoRvH1vg==
X-Received: by 2002:a05:6000:402a:b0:38a:a047:6c0b with SMTP id ffacd0b85a97d-38bf57a97e0mr40573048f8f.35.1737972117198;
        Mon, 27 Jan 2025 02:01:57 -0800 (PST)
Received: from [192.168.88.253] (146-241-95-172.dyn.eolo.it. [146.241.95.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd54c0ecsm127069085e9.30.2025.01.27.02.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 02:01:56 -0800 (PST)
Message-ID: <2ace650b-5697-4fc4-91f9-4857fa64feea@redhat.com>
Date: Mon, 27 Jan 2025 11:01:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 05/12] net: homa: create homa_rpc.h and
 homa_rpc.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-6-ouster@cs.stanford.edu>
 <1c82f56c-4353-407b-8897-b8a485606a5f@redhat.com>
 <CAGXJAmwyp6tSO4KT_NSHKHSnUn-GSzSN=ucfjnBuXbg8uiw2pg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmwyp6tSO4KT_NSHKHSnUn-GSzSN=ucfjnBuXbg8uiw2pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/27/25 6:22 AM, John Ousterhout wrote:
> On Thu, Jan 23, 2025 at 6:30 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> ...
>> How many RPCs should concurrently exist in a real server? with 1024
>> buckets there could be a lot of them on each/some list and linear search
>> could be very expansive. And this happens with BH disabled.
> 
> Server RPCs tend to be short-lived, so my best guess is that the
> number of concurrent server RPCs will be relatively small (maybe a few
> hundred?). But this is just a guess: I won't know for sure until I can
> measure Homa in production use. If the number of concurrent RPCs turns
> out to be huge then we'll have to find a different solution.
> 
>>> +
>>> +     /* Initialize fields that don't require the socket lock. */
>>> +     srpc = kmalloc(sizeof(*srpc), GFP_ATOMIC);
>>
>> You could do the allocation outside the bucket lock, too and avoid the
>> ATOMIC flag.
> 
> In many cases this function will return an existing RPC so there won't
> be any need to allocate; I wouldn't want to pay the allocation
> overhead in that case. I could conceivably check the offset in the
> packet and pre-allocate if the offset is zero (in this case it's
> highly unlikely that there will be an existing RPC). 

If you use RCU properly here, you could do a lockless lookup. If such
lookup fail, you could do the allocation still outside the lock and
avoiding it in most of cases.

>>> +/**
>>> + * homa_find_client_rpc() - Locate client-side information about the RPC that
>>> + * a packet belongs to, if there is any. Thread-safe without socket lock.
>>> + * @hsk:      Socket via which packet was received.
>>> + * @id:       Unique identifier for the RPC.
>>> + *
>>> + * Return:    A pointer to the homa_rpc for this id, or NULL if none.
>>> + *            The RPC will be locked; the caller must eventually unlock it
>>> + *            by invoking homa_rpc_unlock.
>>
>> Why are using this lock schema? It looks like it adds quite a bit of
>> complexity. The usual way of handling this kind of hash lookup is do the
>> lookup locklessly, under RCU, and eventually add a refcnt to the
>> looked-up entity - homa_rpc - to ensure it will not change under the
>> hood after the lookup.
> 
> I considered using RCU for this, but the time period for RCU
> reclamation is too long (10's - 100's of ms, if I recall correctly).

RCU grace period usually extend on a kernel jiffy (1-10 ms depending on
your kernel build option).

> Homa needs to handle a very high rate of RPCs, so this would result in
> too much accumulated memory  (in particular, skbs don't get reclaimed
> until the RPC is reclaimed).

For the RPC struct, that above is a fair point, but why skbs need to be
freed together with the RCP struct? if you have skbs i.e. sitting in a
RX queue, you can flush such queue when the RPC goes out of scope,
without any additional delay.

> The caller must have a lock on the homa_rpc anyway, so RCU wouldn't
> save the overhead of acquiring a lock. The reason for putting the lock
> in the hash table instead of the homa_rpc is that this makes RPC
> creation/deletion atomic with respect to lookups. The lock was
> initially in the homa_rpc, but that led to complex races with hash
> table insertion/deletion. This is explained in sync.txt, but of course
> you don't have that (yet).

The per bucket RPC lock is prone to contention, a per RPC lock will
avoid such problem.

> This approach is unusual, but it has worked out really well. Before
> implementing this approach I had what seemed like a never-ending
> stream of synchronization problems over the socket hash tables; each
> "fix" introduced new problems. Once I implemented this, all the
> problems went away and the code has been very stable ever since
> (several years now).

Have you tried running a fuzzer on this code? I bet syzkaller will give
a lot of interesting results, if you teach it about the homa APIs.

/P


