Return-Path: <netdev+bounces-161260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC33A205D5
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 09:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A3518849F8
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37901DE2CD;
	Tue, 28 Jan 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2Q0vRjD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE916C854
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052403; cv=none; b=HiduCa7rDqkIrZMjEWtWyyP+hOx1H6mP+z3si86Bzxutr4rIEyUOA9xQkfMzFQyStjLyReXNcwU279HUPnU1R9vD0M42VUMr9L1Owmz1VpwT93TaIjhVbT373t+0yl+7dzAlz9MhDvMidSPSIbwyyrRIUVbW5rkHv/93mxNOWMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052403; c=relaxed/simple;
	bh=5bcnrgMQiPs/r/JIbQ+OuUkJ6Iiok9y5FLYKFuHRVWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SP3K+4kpiFrqqgNSnkWeKgR+npsPEwKUnsuDwAk0cCMk1PGoXY5K9jXf8sCeAxdqkcH0N7F8vAjzdqyG5QXRzA+44V6Pv9jsVN8CACzcQ5oKHr/rY/VrK9vdApjoe/emzpbsok9rmdZgpaB1FyzPEwtVpkY/1o4pUORwKMNjCRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2Q0vRjD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738052400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0bxDKLYhWUNP5aIDJ1K+Fu0QhdRQhKGB9VXaWw/c8A=;
	b=d2Q0vRjD17vJ3TaIUhgHQhhpv+8XoGjyalO3Jwy9Qr9E76qxpukks8tPE3KNYO9iu83jDb
	VloYr89YDbPq28wPEva8Kk/QuV4lmSJSVzvQgwo/JjjoS8MKzBRsIJg9+vMI1HenUEpIPS
	f0V+nypdGKqvj1aklJeJd/x0l1KakOA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-xK03aPzsOD-o3Z0yCreM1g-1; Tue, 28 Jan 2025 03:19:58 -0500
X-MC-Unique: xK03aPzsOD-o3Z0yCreM1g-1
X-Mimecast-MFC-AGG-ID: xK03aPzsOD-o3Z0yCreM1g
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361b090d23so27007045e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 00:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738052397; x=1738657197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0bxDKLYhWUNP5aIDJ1K+Fu0QhdRQhKGB9VXaWw/c8A=;
        b=FOypRVFWdNndysUJb0XNWPEqLOuX1RyqmBXvPOllJvgdwnRDcxbH1jtfUWL2IwSNzb
         XIRupPq029xbODsUR6cIsbgPRUODOb8PB69JXRFlosHs0gw/0uLtbP9YN0mHvhDxDXtW
         7opdmxUNewmBNqq1jXddOzc8LEWkJcCs6L0bYpQL6jHbhSTMG1+OyKDinmZTx5HtWINQ
         1j4Z7Pc9EFRKNlMujS02kYUWybcsUpx2a5P1K9eJzQCW9YBu7ozzh57UO3pTzevDxQ8c
         OZlycjQO61s9uvvHFcU0Vyy8c5q98QzITe/pBYHj2MJfq2pGpEoX7T09DHcNgmW8niO/
         zkfg==
X-Gm-Message-State: AOJu0YxH7iovejwmAXBn5WeFW4mg/2rFPGiAOpySscE2TpgYqB54S505
	WHzHPNaOzn+zvZvTI58+8GA8On3X1OZGxC4AH8h5j7PCpXtdFog45nlmO2kZRwLUGceM+hLTMdo
	dC8aSIyvQsVlNKABD+/KImVAHwakjMEJqXplxkn6sFyFfaCblDwkp3w==
X-Gm-Gg: ASbGncshoLV+oWQ0YSquyBggREdGvpU+ir64YGCFlieQQv2jwThzrvipMCZb2LPE8fb
	azEaoJRUepnp0/IPkzScxHeBF65Glpkn5mkDCF+rxKwp19V+fsTzWwoqros2EtEmro0b+iAPcBW
	7AVFE+o0OEbJNe1+jkJF6D+LH/eDEKky7w4MCt3p9RMgrSqVqjS9/OTB6MleOtIWt/eyKQKky/o
	7ReWWRcq0kh6WZtPQ39fgTcNlHEtNPyOOIqYZlpw/7o+CjcbEblN4LOTEzNlfesQ/1XewOznaQJ
	Bw6UOQHXJXhfDQ3Hh7FH5y4sK/3c3rbbPEQ=
X-Received: by 2002:a7b:c8c9:0:b0:436:fb02:e68 with SMTP id 5b1f17b1804b1-438913bdd6cmr381205625e9.2.1738052397076;
        Tue, 28 Jan 2025 00:19:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESc+BjCH2gIJSeUPJD+pmbUhRdxr97EbDvnpFP6lZIQMAZTqiM15WeuqCKfwwuaBNDqgDmsQ==
X-Received: by 2002:a7b:c8c9:0:b0:436:fb02:e68 with SMTP id 5b1f17b1804b1-438913bdd6cmr381205255e9.2.1738052396639;
        Tue, 28 Jan 2025 00:19:56 -0800 (PST)
Received: from [192.168.88.253] (146-241-48-130.dyn.eolo.it. [146.241.48.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4857b8sm158550725e9.15.2025.01.28.00.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 00:19:56 -0800 (PST)
Message-ID: <9209dfbb-ca3a-4fb7-a2fb-0567394f8cda@redhat.com>
Date: Tue, 28 Jan 2025 09:19:54 +0100
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
 <2ace650b-5697-4fc4-91f9-4857fa64feea@redhat.com>
 <CAGXJAmxHDVhxKb3M0--rySAgewmLpmfJkAeRSBNRgZ=cQonDtg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmxHDVhxKb3M0--rySAgewmLpmfJkAeRSBNRgZ=cQonDtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/27/25 7:03 PM, John Ousterhout wrote:
> On Mon, Jan 27, 2025 at 2:02 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 1/27/25 6:22 AM, John Ousterhout wrote:
>>> On Thu, Jan 23, 2025 at 6:30 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>> ...
>>>> How many RPCs should concurrently exist in a real server? with 1024
>>>> buckets there could be a lot of them on each/some list and linear search
>>>> could be very expansive. And this happens with BH disabled.
>>>
>>> Server RPCs tend to be short-lived, so my best guess is that the
>>> number of concurrent server RPCs will be relatively small (maybe a few
>>> hundred?). But this is just a guess: I won't know for sure until I can
>>> measure Homa in production use. If the number of concurrent RPCs turns
>>> out to be huge then we'll have to find a different solution.
>>>
>>>>> +
>>>>> +     /* Initialize fields that don't require the socket lock. */
>>>>> +     srpc = kmalloc(sizeof(*srpc), GFP_ATOMIC);
>>>>
>>>> You could do the allocation outside the bucket lock, too and avoid the
>>>> ATOMIC flag.
>>>
>>> In many cases this function will return an existing RPC so there won't
>>> be any need to allocate; I wouldn't want to pay the allocation
>>> overhead in that case. I could conceivably check the offset in the
>>> packet and pre-allocate if the offset is zero (in this case it's
>>> highly unlikely that there will be an existing RPC).
>>
>> If you use RCU properly here, you could do a lockless lookup. If such
>> lookup fail, you could do the allocation still outside the lock and
>> avoiding it in most of cases.
> 
> I think that might work, but it would suffer from the slow reclamation
> problem I mentioned with RCU. It would also create more complexity in
> the code (e.g. the allocation might still turn out to be redundant, so
> there would need to be additional code to check for that: the lookup
> would essentially have to be done twice in the case of creating a new
> RPC). I'd rather not incur this complexity until there's evidence that
> GFP_ATOMIC is causing problems.

Have a look at tcp established socket lookup and the
SLAB_TYPESAFE_BY_RCU flag usage for slab-based allocations. A combo of
such flag for RPC allocation (using a dedicated kmem_cache) and RCU
lookup should improve consistently the performances, with a consolidate
code layout and no unmanageable problems with large number of objects
waiting for the grace period.

>>> Homa needs to handle a very high rate of RPCs, so this would result in
>>> too much accumulated memory  (in particular, skbs don't get reclaimed
>>> until the RPC is reclaimed).
>>
>> For the RPC struct, that above is a fair point, but why skbs need to be
>> freed together with the RCP struct? if you have skbs i.e. sitting in a
>> RX queue, you can flush such queue when the RPC goes out of scope,
>> without any additional delay.
> 
> Reclaiming the skbs inline would be too expensive; 

Why? For other protocols the main skb free cost is due to memory
accounting, that homa is currently not implementing, so I don't see why
it should be critically expansive at this point (note that homa should
performat least rmem/wmem accounting, but let put this aside for a
moment). Could you please elaborate on this topic?

>>> The caller must have a lock on the homa_rpc anyway, so RCU wouldn't
>>> save the overhead of acquiring a lock. The reason for putting the lock
>>> in the hash table instead of the homa_rpc is that this makes RPC
>>> creation/deletion atomic with respect to lookups. The lock was
>>> initially in the homa_rpc, but that led to complex races with hash
>>> table insertion/deletion. This is explained in sync.txt, but of course
>>> you don't have that (yet).
>>
>> The per bucket RPC lock is prone to contention, a per RPC lock will
>> avoid such problem.
> 
> There are a lot of buckets (1024); this was done intentionally to
> reduce the likelihood of contention between different RPCs  trying to
> acquire the same bucket lock. 

1024 does not look to big for internet standard, but I must admit the
usage pattern is not 110% clear to me.

[...]
> Note that the bucket locks would be needed even with RCU usage, in
> order to permit concurrent RPC creation in different buckets. Thus
> Homa's locking scheme doesn't introduce additional locks; it
> eliminates locks that would otherwise be needed on individual RPCs and
> uses the bucket locks for 2 purposes.

It depends on the relative frequency of RPC lookup vs RPC
insertion/deletion. i.e. for TCP connections the lookup frequency is
expected to be significantly higher than the socket creation and
destruction.

I understand the expected patter in quite different with homa RPC? If so
you should at least consider a dedicated kmem_cache for such structs.

/P


