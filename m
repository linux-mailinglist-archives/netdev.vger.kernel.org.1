Return-Path: <netdev+bounces-201279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D954AE8BB8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 19:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F6E5A6FAA
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178792D5C60;
	Wed, 25 Jun 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdKbrI0M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F422C08A5
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750873690; cv=none; b=RiPp2L2nz2ByuRDuLOEoc0S7333gQNbDC+4W/x1mExAbuW6qiuC1i/irTg/WsXNSI5Sx/KAR5mDHrdVbuOMTtxB8/bmnHdE7Z1lQzy/4neW1VgN4O8w+yIjXixN7RK4IIQs9lv0BMq6nuU2VoCaMN+e7RPdDcaVY/8BPlBi6OPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750873690; c=relaxed/simple;
	bh=7hhr28iehbxV1W+VLs54+Oo0mG4xdVqBfI8Lz2DxStU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=As+W8U4YPfCQc5POC6Cj0tI0iquTMBHUyrcbFnKvqPP5I/mt/Z0s9MjM3jnsbfDkRiL8T7NOACyw6w2vAMkv+u4c4+O98e7eJPwQQt9NBr6Al67oVmCWL2XF6/zhMNKfRllqmZX/kguh8XFcxHMHEIHDu85v809YyP0CP9DctGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdKbrI0M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750873687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwTu+Wt/h6v7ZrbX8K8bLUbTVXbSKmPqSY5AZLWV8nk=;
	b=BdKbrI0MxNJEQgsipoP6rljsCXBLf2z0b9AGUNpTJTM04bR/CF8Czz38LKufATtJH459PC
	RUxVr7M/EtWYk8GZJWZ/5BsPvfkW+Emmq3aVf2+mxgaj1tfuveyLq2bF7MKcDKJNJtcqvw
	Qvjzg6AdfnO1cchyUVKrIFihfd7+6UU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-_gucFBKqPre62H9hC2C9Xw-1; Wed, 25 Jun 2025 13:48:05 -0400
X-MC-Unique: _gucFBKqPre62H9hC2C9Xw-1
X-Mimecast-MFC-AGG-ID: _gucFBKqPre62H9hC2C9Xw_1750873685
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235e1d70d67so1420745ad.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750873682; x=1751478482;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwTu+Wt/h6v7ZrbX8K8bLUbTVXbSKmPqSY5AZLWV8nk=;
        b=vQIwJOlG9pGbxoFXUvbgvBzWRvVR1jRZUhJNrcX+qUFUfzd44L+eLz1aOsP2x5ff94
         sv1GqsBOPb/4bypN/FF37QIRNeAcH74/sP5tVS/0P6+NxI7iz+zu9oVyD/pJdv8MAKFF
         yEIb/d8O8K+hPtiXLafQFoYlPWt+TzqF0SbnSCOaFvP/KfrtBY/hoo5WTVVfanfp608J
         nLR7WQEDv6WXjwzXDvM314/9W90fU2v8HuLOKno81YJ2BFV837IL4RZFRSufuePS7AqH
         /A9nfNk4hnsYd1fxNbqjHFeQzf0jotHabR1hCLUbT86wKwzjY4f8zTB5Dnd4aRkDgpoD
         C1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU771eSnoFYB3cnVE3FovXwY8WGxw0/NzvIPKFdCPFlkEInKzn/45F9pkwdSAWvyLvFOI7+UHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/rpfe3T/cr4U23Pkngb0nKT8CAHSVRi9l2gK28SElZUBFR2Q
	HxywtvpsnVVQ+1WFlRIYeCPlngFMq4zYh6lmXoCDQaDvutrgFf65bz/AKuudoBZ3P+U95e4Gndh
	OVX12vx7AypMrxnei6xY26A+MwuHY1QOGGaV3GkWIPy8yAL3W5Ntb2nkRcH8ojyYu9KlG
X-Gm-Gg: ASbGncu5kygqtYwXqRobXLeduS9cWfjjSZ+mqVSYv5NbX9UNJ+J/g69bPi6OcjAghuP
	UZVCL/RO9s+4Y4nGW8pxF9Prda0ygy8rXiB1lLlRkitx0yydwavkYUQ/o8c2aN0Xgh3MFRB6en3
	sTAVjxVl1Pic+4SspD5Ga9ruxRyPX6BsVZHawjpgQ+7xXr4NwsqVaPhPMSuksez53c5/j6IA3hB
	+2JAYDHURiqH3Na13AGbh7abt4CuqNUNUZNpmU+ZDk1FzOo+0Pg+3+d05dnsKzREidxezoQpk89
	/Bzlm7f0lcKfUDrnrCYjMpUPW6xfby4j1AHVRbL5OU4Zi8+p8k4Izv3Mjp6XSAuo8t7U
X-Received: by 2002:a17:902:f68f:b0:234:ed31:fc98 with SMTP id d9443c01a7336-2382406aaf8mr66947605ad.37.1750873682151;
        Wed, 25 Jun 2025 10:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3+PJS3xebQrgq54ldrQdwtd/GmCDOD/XYhhutmas5K7tDvKj2czAREFvQqDcBLOC9o54Cog==
X-Received: by 2002:a17:902:f68f:b0:234:ed31:fc98 with SMTP id d9443c01a7336-2382406aaf8mr66947305ad.37.1750873681766;
        Wed, 25 Jun 2025 10:48:01 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86ef84fsm135684415ad.216.2025.06.25.10.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 10:48:00 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <665865d7-aa34-40a1-b985-7d6229d272b0@redhat.com>
Date: Wed, 25 Jun 2025 13:47:57 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] Introduce simple hazard pointers
To: Boqun Feng <boqun.feng@gmail.com>, Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Breno Leitao <leitao@debian.org>, aeh@meta.com, netdev@vger.kernel.org,
 edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
 Erik Lundgren <elundgren@meta.com>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <20250625031101.12555-2-boqun.feng@gmail.com>
 <c649c8ec-6c1b-41a3-90c5-43c0feed7803@redhat.com> <aFwfUCw2izpjC0wr@Mac.home>
Content-Language: en-US
In-Reply-To: <aFwfUCw2izpjC0wr@Mac.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/25/25 12:09 PM, Boqun Feng wrote:
> On Wed, Jun 25, 2025 at 11:52:04AM -0400, Waiman Long wrote:
> [...]
>>> +/*
>>> + * Acquire a hazptr slot and begin the hazard pointer critical section.
>>> + *
>>> + * Must be called with preemption disabled, and preemption must remain disabled
>>> + * until shazptr_clear().
>>> + */
>>> +static inline struct shazptr_guard shazptr_acquire(void *ptr)
>>> +{
>>> +	struct shazptr_guard guard = {
>>> +		/* Preemption is disabled. */
>>> +		.slot = this_cpu_ptr(&shazptr_slots),
>>> +		.use_wildcard = false,
>>> +	};
>>> +
>>> +	if (likely(!READ_ONCE(*guard.slot))) {
>>> +		WRITE_ONCE(*guard.slot, ptr);
>>> +	} else {
>>> +		guard.use_wildcard = true;
>>> +		WRITE_ONCE(*guard.slot, SHAZPTR_WILDCARD);
>>> +	}
>> Is it correct to assume that shazptr cannot be used in a mixed context
>> environment on the same CPU like a task context and an interrupt context
>> trying to acquire it simultaneously because the current check isn't atomic
>> with respect to that?
> I think the current implementation actually support mixed context usage,
> let see (assuming we start in a task context):
>
> 	if (likely(!READ_ONCE(*guard.slot))) {
>
> if an interrupt happens here, it's fine because the slot is still empty,
> as long as the interrupt will eventually clear the slot.
>
> 		WRITE_ONCE(*guard.slot, ptr);
>
> if an interrupt happens here, it's fine because the interrupt would
> notice that the slot is already occupied, hence the interrupt will use a
> wildcard, and because it uses a wild, it won't clear the slot after it
> returns. However the task context's shazptr_clear() will eventually
> clear the slot because its guard's .use_wildcard is false.
>
> 	} else {
>
> if an interrupt happens here, it's fine because of the same: interrupt
> will use wildcard, and it will not clear the slot, and some
> shazptr_clear() in the task context will eventually clear it.
>
> 		guard.use_wildcard = true;
> 		WRITE_ONCE(*guard.slot, SHAZPTR_WILDCARD);
>
> if an interrupt happens here, it's fine because of the same.
>
> 	}
>
>
> It's similar to why rcu_read_lock() can be just a non-atomic inc.
You are right.
>
>>> +
>>> +	smp_mb(); /* Synchronize with smp_mb() at synchronize_shazptr(). */
>>> +
>>> +	return guard;
>>> +}
>>> +
>>> +static inline void shazptr_clear(struct shazptr_guard guard)
>>> +{
>>> +	/* Only clear the slot when the outermost guard is released */
>>> +	if (likely(!guard.use_wildcard))
>>> +		smp_store_release(guard.slot, NULL); /* Pair with ACQUIRE at synchronize_shazptr() */
>>> +}
>> Is it better to name it shazptr_release() to be conformant with our current
>> locking convention?
>>
> Maybe, but I will need to think about slot reusing between
> shazptr_acquire() and shazptr_release(), in the general hazptr API,
> you can hazptr_alloc() a slot, use it and hazptr_clear() and then
> use it again, eventually hazptr_free(). I would like to keep both hazptr
> APIs consistent as well. Thanks!

Thanks for the explanation. Maybe we can reuse the general hazptr API 
names (alloc/clear/free) even though shazptr_free() will be a no-op for 
now. Just that the current acquire/clear naming looks odd to me.

Thanks,
Longman


