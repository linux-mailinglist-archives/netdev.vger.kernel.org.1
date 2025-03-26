Return-Path: <netdev+bounces-177791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C8AA71C08
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 17:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45053BC21B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8526F1F63F9;
	Wed, 26 Mar 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iT4Mp2gt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ECF1F416D
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007270; cv=none; b=JP6en7Qxl+4z/8xmOlGEHwWkpuP4rT3AycDYAvgL1gctRFXQ+FVtAZiGVP9DUpRamwK6EccJjOSUf6ZPxR310P6zRYeSgSeQBrgc0FFDgMWHWpP9+92W6OZgqcRiEFP4cSpMQPHZHe3u2LsbTED4xKj0+D4GYDk1jOAMmFVdaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007270; c=relaxed/simple;
	bh=RLhqAyhYeXRbvNukMia3rEah0rth3XKhMGOugwiu7bI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=inkYRAT2FzMVrvduJCniZoDhDK35T3hfT7FfjLIHzH+LiccgV/cIxPhAc3aRz3EeBddgKcMdJNyJwkRfM3NhsrqAsGyqBTcNT3zp1kiYzkRVYENKCLgRw8ZU8MVyao51IxFvxCGtniQ/oFXYnv5VenfhmUh751rVRJLe7ZzVXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iT4Mp2gt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743007265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=prPqXmv3MvlSz5eyOiIz+dUsJW9wnXJo+KXxYDUpt6Q=;
	b=iT4Mp2gt66u6GuGoyQl/4BABO7xyiJmGx2HcQ7NrFQD7/duiiAPHbmRH3BlBa2OQkbplvH
	qXA0D0zeUv6PaISbWTUlHopkQB3+B+wXy20eQzulQrNZYf7UQ7wF8cBfjIh/LDPK/QvGTh
	OotLd1Mg/0EYlTxDmPTYD/p/+NTZjnA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-SzlmV_IROgmWrZVuTzpgdQ-1; Wed, 26 Mar 2025 12:41:03 -0400
X-MC-Unique: SzlmV_IROgmWrZVuTzpgdQ-1
X-Mimecast-MFC-AGG-ID: SzlmV_IROgmWrZVuTzpgdQ_1743007262
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b4dc23f03so16629439f.1
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 09:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007262; x=1743612062;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prPqXmv3MvlSz5eyOiIz+dUsJW9wnXJo+KXxYDUpt6Q=;
        b=TtY4I2IwfvemR6ErDKjO7X3AnkyHCez/gDFBnf4VeBbQBN/rdj9OJFQL4UJ199FV6I
         4rXz1OZFIluKFRSsuUJ2M06PkrJd99XpYLvEb/t5l5S2XNENvX9aT4zmLfmYMz8ZOYo6
         lANMVB2gCrnMEn71cuPHrG1okschUpr5qdgnzwJ0nUMM/WUxrxi+gj2lkVtTTnQhblN4
         XiGIQeEmDKHLOZkK/FAkjjlqkc6GZYJntrrXumL/Cog3HAJi4aw/8NY/SXz97AIajMRu
         sn27MMcx8AnzObKacu4jRqgLHm7qv2B8HtUETNrwFr1Fn45wmPEx1rSaPRpuTwgKFUaG
         zUMg==
X-Forwarded-Encrypted: i=1; AJvYcCX+Am+ih4bvkri7IJUUn8v1ICfpkjnlI9NVO1RAH7F+EyGUOFMeE31UA6Ip+i3M4YsRwKY19Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpN5ql0qgupmG/AS+G7hYjDLEnUUXTfVMxpaRYb8roJewzVsnY
	PA5CTY0hXMcPNivx459HEjsdJAdKeNMjRdoEm6xtloX694+5zAGN/x6aDRkIL4NReiBHk55Y4nK
	om+M2dZ8tSPSu7+IYX46JpDkikJL/t2Y4GC/jaeq+7VswThSoWxJOYQ==
X-Gm-Gg: ASbGncuzbY3yBWCa7cxELEex96yatSf8efVL2eWvErG9zmCSVO8b3I2u5ZMygtmKvZd
	/d9luFagI/fF7z64oS7uGkiwwZX0QkAqkzO2oQ/uY2Ih5/ARm5LeuwmNzTvb5830jLHEbQptX65
	MgOR5+AbUveF7aJ7hS17cTFrOdHCzJRqukdmiQHu3KAN8JTyztFo0M/zGuimvvlh0a+K4Nx+GJ7
	nSPMiUNl7lQyj5rNkNZ++nAQxeivpCGUZ0iQxFiC+OFvRbSzQE5C4LZNdwE2aHENEA4p7axU+tS
	du4RdplPIW+h4QpaztezXt29slL1HCvQ52cVdyMfN92yLbRAvcsN2t8ONEBvQg==
X-Received: by 2002:a05:6602:6a88:b0:85b:48e7:14fd with SMTP id ca18e2360f4ac-85e82197d29mr66265339f.14.1743007262474;
        Wed, 26 Mar 2025 09:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR0FuVdln5+3KEEsrHMRovEFMxjY8m2mx7hohi1mp0b3BdUjHFU/zPvyYRWht1eOolplbsQg==
X-Received: by 2002:a05:6602:6a88:b0:85b:48e7:14fd with SMTP id ca18e2360f4ac-85e82197d29mr66260939f.14.1743007262037;
        Wed, 26 Mar 2025 09:41:02 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbed2504sm2919913173.145.2025.03.26.09.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 09:41:01 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <37bbf28f-911a-4fea-b531-b43cdee72915@redhat.com>
Date: Wed, 26 Mar 2025 12:40:59 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Waiman Long <llong@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, aeh@meta.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <67e1b0a6.050a0220.91d85.6caf@mx.google.com>
 <67e1b2c4.050a0220.353291.663c@mx.google.com>
 <67e1fd15.050a0220.bc49a.766e@mx.google.com>
 <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com> <Z-Il69LWz6sIand0@Mac.home>
 <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com> <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
Content-Language: en-US
In-Reply-To: <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/26/25 11:39 AM, Waiman Long wrote:
> On 3/26/25 1:25 AM, Boqun Feng wrote:
>>> It looks like you are trying hard to find a use case for hazard pointer in
>>> the kernel 🙂
>>>
>> Well, if it does the job, why not use it 😉 Also this shows how
>> flexible hazard pointers can be.
>>
>> At least when using hazard pointers, the reader side of the hash list
>> iteration is still lockless. Plus, since the synchronization part
>> doesn't need to wait for the RCU readers in the whole system, it will be
>> faster (I tried with the protecting-the-whole-hash-list approach as
>> well, it's the same result on the tc command). This is why I choose to
>> look into hazard pointers. Another mechanism can achieve the similar
>> behavior is SRCU, but SRCU is slightly heavier compared to hazard
>> pointers in this case (of course SRCU has more functionalities).
>>
>> We can provide a lockdep_unregister_key_nosync() without the
>> synchronize_rcu() in it and let users do the synchronization, but it's
>> going to be hard to enforce and review, especially when someone
>> refactors the code and move the free code to somewhere else.
> Providing a second API and ask callers to do the right thing is 
> probably not a good idea and mistake is going to be made sooner or later.
>>> Anyway, that may work. The only problem that I see is the issue of nesting
>>> of an interrupt context on top of a task context. It is possible that the
>>> first use of a raw_spinlock may happen in an interrupt context. If the
>>> interrupt happens when the task has set the hazard pointer and iterating the
>>> hash list, the value of the hazard pointer may be overwritten. Alternatively
>>> we could have multiple slots for the hazard pointer, but that will make the
>>> code more complicated. Or we could disable interrupt before setting the
>>> hazard pointer.
>> Or we can use lockdep_recursion:
>>
>> 	preempt_disable();
>> 	lockdep_recursion_inc();
>> 	barrier();
>>
>> 	WRITE_ONCE(*hazptr, ...);
>>
>> , it should prevent the re-entrant of lockdep in irq.
> That will probably work. Or we can disable irq. I am fine with both.
>>> The solution that I am thinking about is to have a simple unfair rwlock to
>>> protect just the hash list iteration. lockdep_unregister_key() and
>>> lockdep_register_key() take the write lock with interrupt disabled. While
>>> is_dynamic_key() takes the read lock. Nesting in this case isn't a problem
>>> and we don't need RCU to protect the iteration process and so the last
>>> synchronize_rcu() call isn't needed. The level of contention should be low
>>> enough that live lock isn't an issue.
>>>
>> This could work, one thing though is that locks don't compose. Using a
>> hash write_lock in lockdep_unregister_key() will create a lockdep_lock()
>> -> "hash write_lock" dependency, and that means you cannot
>> lockdep_lock() while you're holding a hash read_lock, although it's
>> not the case today, but it certainly complicates the locking design
>> inside lockdep where there's no lockdep to help 😉
>
> Thinking about it more, doing it in a lockless way is probably a good 
> idea.
>
If we are using hazard pointer for synchronization, should we also take 
off "_rcu" from the list iteration/insertion/deletion macros to avoid 
the confusion that RCU is being used?

Cheers,
Longman


