Return-Path: <netdev+bounces-178439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5880DA77052
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779671887D06
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D8D21A437;
	Mon, 31 Mar 2025 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4SZKNK2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30CF214A8F
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743457667; cv=none; b=ue5iZBOdidZjfT9yoRqhrKOclbbGn30iuLQbguR8yZCMlt/RGPcpTA/3eFTtBrdSjn9VR/bcf1vl82ao9wP6N9RncCY5WO1x+n+cp1o0NjdGRVZxJpWoCwi8EJlLTHvFEhBBMf8XPTsG469Ap5v85yO0RKqFtlhOm11B/cIOwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743457667; c=relaxed/simple;
	bh=6BurWuxDIhUOOXVLTYnfhaXSK23mdZmlzzymf8T3KCI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tCZ/Yx7HzRZ2CR4RtBC/xyvivjDE5W2/c18uHqrYEDV/1YCNcrFqP/qv9eEoQEQmAKae2gRU6s2KTzuEaezzyDyQppte6cf6pLW4ZSvBbwVMWqzXccn+qP5GN+q9OJCQxWhc09ySd5d+pObl/a+RUxuqA1wyOuwJRbx6ectq3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4SZKNK2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743457664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDJbnUrOniIR2J6H6BkhNER/mfCp9Qw+yHpfNn5RwqU=;
	b=C4SZKNK2+uanTa8EPPps3UQ8QhHScGvDt3kQxaOAL8P/H8pCX38j7NYdVpPDnzB2/XVzAu
	Kr2+HXcshB9Vg7syPlPtVPOJiu6aBJ7e60W7pzLqgbnq8GxJZxTowZcpOvttQzcegTlepT
	iuVqm2bKLak4P1TqVk6GEhEYbbh7JEk=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-gRdx6KBEOXW_xOn1Gma_hQ-1; Mon, 31 Mar 2025 17:47:43 -0400
X-MC-Unique: gRdx6KBEOXW_xOn1Gma_hQ-1
X-Mimecast-MFC-AGG-ID: gRdx6KBEOXW_xOn1Gma_hQ_1743457663
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d5a9e7dd5aso53420015ab.3
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 14:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743457662; x=1744062462;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDJbnUrOniIR2J6H6BkhNER/mfCp9Qw+yHpfNn5RwqU=;
        b=oiEIoS7W36nyMvE+mB3ew1idzcKHYLYkdqA2QIq7QkGr3TK9CYR+M7ma/rTx2YAjTo
         008Em+jzUKAL4sheYL6owfW7SwxvlFcyQ2S9hdEi3CNh5HFO26SONY8Nkf+YJy3td7wB
         L+4JQ6lMphZa8N6Wbr/4Fh3RF6DVDtCNg2k9y4QdWbOBDf740zDzCti3WR9jF+MIFW99
         As7AoHwAz6/PEp6B4ey3IwTapP5sKLZ/0ns+MlX1FeX7mKyOjC+Xf2u1ybu7aFtuOoKj
         ODTeQ/LA09ekX3YXAcZWbT2nfB18h5i60mJnwDBazNnnGLZAXPTI5SlTsBqMl+DG0W4B
         /PtA==
X-Forwarded-Encrypted: i=1; AJvYcCWNmcY7qtdQ7tE9xoFeB1BB4vySAQF9pKv1ZYoQ6gNUDk0HymfMa+uiVJtnJbx3oIPd5X3zf18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqn9bOoA61aiqJIkeyMVZB8zapF8UdnKJMsOk2QZDO+Q3lsk5t
	hhh3UdrxtmoQrdGkKKWsqMJdsyjmyRdCRJg0UZxOG7iSPzLn2BnV1AvIfK6/L6LfM9qhK9Y+wdm
	xgvOROSG5hqF8KAMWTLvpylSRRaxHbQ8NA1nvcdegEDBcZSabrqIIvhZgHjyLgQ==
X-Gm-Gg: ASbGncvrsHdZ5Sa2ZMXxZFfy4aD6zrPkqCuveSyttgjjUBKLj4gD9F/F0Cvm9SvbAbL
	mV8E+qKgWpb5qUlnHCzcYJJPYuA0oK/zKlhFObOVRf9moxJ67D+f2eAC+Z3whhkIk0EtaRbeBme
	hShGMrfFidBr0OFdVeqeDrsDkWVM/5SVx+CUy2AcHggmNH7zwWDaOmQ4nGACCv6BKvsnXYMS6AV
	KpR6Vdz8E4o8Isgn4gPXrk/izW3ztMihS+lBdNDOpkzMnQGqqQyyAxKIs5xhmBowcgBDF0RYGkn
	p8DZE1gmD/oldQMKs0SLLnTopoqVX4A2IdJS1pteVL24DXwPxz85g5nT/Ub2qw==
X-Received: by 2002:a05:6e02:194c:b0:3d3:dece:3dab with SMTP id e9e14a558f8ab-3d5e08edf07mr110960195ab.1.1743457662375;
        Mon, 31 Mar 2025 14:47:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBGBOzEXu+JrcUBSFzxSpUz21XUJZCsbyiZxYzdOIp5SIemYXEPArY5yCXN4IgVSefrR39dw==
X-Received: by 2002:a05:6e02:194c:b0:3d3:dece:3dab with SMTP id e9e14a558f8ab-3d5e08edf07mr110959925ab.1.1743457661886;
        Mon, 31 Mar 2025 14:47:41 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f464871f77sm2070867173.77.2025.03.31.14.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 14:47:41 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b23d56c5-da54-4fbd-81ec-743cc53e0162@redhat.com>
Date: Mon, 31 Mar 2025 17:47:39 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Boqun Feng <boqun.feng@gmail.com>, Waiman Long <llong@redhat.com>
Cc: paulmck@kernel.org, Eric Dumazet <edumazet@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, aeh@meta.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>
References: <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com> <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
 <Z-rQNzYRMTinrDSl@boqun-archlinux>
 <9f5b500a-1106-4565-9559-bd44143e3ea6@redhat.com>
 <35039448-d8e8-4a7d-b59b-758d81330d4b@paulmck-laptop>
 <69592dc7-5c21-485b-b00e-1c34ffb4cee8@redhat.com>
 <Z-sHWAQ2TnLMEIls@boqun-archlinux>
Content-Language: en-US
In-Reply-To: <Z-sHWAQ2TnLMEIls@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/25 5:21 PM, Boqun Feng wrote:
> On Mon, Mar 31, 2025 at 02:57:20PM -0400, Waiman Long wrote:
>> On 3/31/25 2:33 PM, Paul E. McKenney wrote:
>>> On Mon, Mar 31, 2025 at 01:33:22PM -0400, Waiman Long wrote:
>>>> On 3/31/25 1:26 PM, Boqun Feng wrote:
>>>>> On Wed, Mar 26, 2025 at 11:39:49AM -0400, Waiman Long wrote:
>>>>> [...]
>>>>>>>> Anyway, that may work. The only problem that I see is the issue of nesting
>>>>>>>> of an interrupt context on top of a task context. It is possible that the
>>>>>>>> first use of a raw_spinlock may happen in an interrupt context. If the
>>>>>>>> interrupt happens when the task has set the hazard pointer and iterating the
>>>>>>>> hash list, the value of the hazard pointer may be overwritten. Alternatively
>>>>>>>> we could have multiple slots for the hazard pointer, but that will make the
>>>>>>>> code more complicated. Or we could disable interrupt before setting the
>>>>>>>> hazard pointer.
>>>>>>> Or we can use lockdep_recursion:
>>>>>>>
>>>>>>> 	preempt_disable();
>>>>>>> 	lockdep_recursion_inc();
>>>>>>> 	barrier();
>>>>>>>
>>>>>>> 	WRITE_ONCE(*hazptr, ...);
>>>>>>>
>>>>>>> , it should prevent the re-entrant of lockdep in irq.
>>>>>> That will probably work. Or we can disable irq. I am fine with both.
>>>>> Disabling irq may not work in this case, because an NMI can also happen
>>>>> and call register_lock_class().
>>>> Right, disabling irq doesn't work with NMI. So incrementing the recursion
>>>> count is likely the way to go and I think it will work even in the NMI case.
>>>>
>>>>> I'm experimenting a new idea here, it might be better (for general
>>>>> cases), and this has the similar spirit that we could move the
>>>>> protection scope of a hazard pointer from a key to a hash_list: we can
>>>>> introduce a wildcard address, and whenever we do a synchronize_hazptr(),
>>>>> if the hazptr slot equal to wildcard, we treat as it matches to any ptr,
>>>>> hence synchronize_hazptr() will still wait until it's zero'd. Not only
>>>>> this could help in the nesting case, it can also be used if the users
>>>>> want to protect multiple things with this simple hazard pointer
>>>>> implementation.
>>>> I think it is a good idea to add a wildcard for the general use case.
>>>> Setting the hazptr to the list head will be enough for this particular case.
>>> Careful!  If we enable use of wildcards outside of the special case
>>> of synchronize_hazptr(), we give up the small-memory-footprint advantages
>>> of hazard pointers.  You end up having to wait on all hazard-pointer
>>> readers, which was exactly why RCU was troublesome here.  ;-)
> Technically, only the hazard-pointer readers that have switched to
> wildcard mode because multiple hazptr critical sections ;-)
>
>> If the plan is to have one global set of hazard pointers for all the
> A global set of hazard pointers for all the possible use cases is the
> current plan (at least it should be when we have fully-featured hazptr
> [1]). Because the hazard pointer value already points the the data to
> protect, so no need to group things into "domain"s.
>
>> possible use cases, supporting wildcard may be a problem. If we allow
> I had some off-list discussions with Paul, and I ended up with the idea
> of user-specific wildcard (i.e. different users can have different
> wildcards) + one global set of hazard pointers. However, it just occured
> to me that it won'd quite work in this simple hazard pointer
> implementation (one slot per-CPU) :( Because you can have a user A's
> hazptr critical interrupted by a user B's interrupt handler, and if both
> A & B are using customized wildcard but they don't know each other, it's
> not going to work by setting either wildcard value into the slot.
>
> To make it clear for the discussion, we have two hazard pointer
> implementations:
>
> 1. The fully-featured one [1], which allow users to provide memory for
>     hazptr slots, so no issue about nesting/re-entry etc. And wildcard
>     doesn't make sense in this implemenation.
>
> 2. The simple variant, which is what I've proposed in this thread, and
>     since it only has one slot per CPU, either all the users need to
>     prevent the re-entries or we need a global wildcard. Also the readers
>     of the simple variant need to disable preemption regardlessly because
>     it only has one hazptr slot to use. That means its read-side critical
>     section should be short usually.
>
> I could try to use the fully-featured one in lockdep, what I need to do
> is creating enough hazard_context so we have enough slots for lockdep
> and may or may not need lockdep_recursion to prevent reentries. However,
> I still believe (or I don't have data to show otherwise) that the simple
> variant with one slot per CPU + global wildcard will work fine in
> practice.
>
> So what I would like to do is introducing the simple variant as a
> general API with a global wildcard (because without it, it cannot be a
> general API because one user have to prevent entering another user's
> critical section), and lockdep can use it. And we can monitor the
> delay of synchronize_shazptr() and if wildcard becomes a problem, move
> to a fully-featured hazptr implementation. Sounds like a plan?
>
> [1]: https://lore.kernel.org/lkml/20240917143402.930114-2-boqun.feng@gmail.com/

Thank for the detailed explanation. I am looking forward to your new 
hazptr patch series.

Cheers,
Longman

>
> Regards,
> Boqun
>
>> different sets of hazard pointers for different use cases, it will be less
>> an issue. Anyway, maybe we should skip wildcard for the current case so that
>> we have more time to think through it first.
>>
>> Cheers,
>> Longman
>>


