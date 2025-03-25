Return-Path: <netdev+bounces-177573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A4A70A5F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF378189D735
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 19:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788FB1F3FD7;
	Tue, 25 Mar 2025 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nm9f4hVn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397F1EEA34
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930620; cv=none; b=UL2J0WOQBYejCH2bVuf97aPyBYXQQXSqRofGvokeV6qG+vmdjBleAesLXSNVPNqPOqAeruLnkPQOcKsR4AXtiXD4y+VmiUr4Q5wBIGd0DsbGF0aoKY6e1KdzOH5Hf5JAGNEtzXUuQzZsYKygwC35gVhB+P5H4/xOUpc0bPmKxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930620; c=relaxed/simple;
	bh=8z94sMCyK4xn3BNGUZOo9yevWIuKH3eaWMKO1mo26yE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dmbzXHZp6WH1MWBrlZwfRMPwak80EL4sih5b88TeMZXA3A/Nt4Ah3TwvvxG89YsUuWBBjz27bhGpEHkwE5k0V2aEdRPTRsGqmBbCRkPOid8QbyP6F8a+/YmwftMGGp0zyNKJWWlf0zs7Wl1TK2gQqkDkM7AGMEeYJ7Gectht0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nm9f4hVn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742930616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGPc+KKvUVF0/VjyiBK6ry9YOHGHtkPR3f81nyTsSVw=;
	b=Nm9f4hVnhJD/WQilA7iHwerEzjxGxG/Qw3trHCkJSEFN3goFVRSTPWPEm447lL3tDEL8IF
	9bEacy0AyL9mqqXdYCayf8EVU/0I4schgTv9b30QnFfbjsQEoUuT48LjBmBL9/TMJYj+fy
	tSAVpXiB2bt5UqfUWHu4BdhUrtsKHhM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-6o2r3U6ENt2LxGyVhr6oow-1; Tue, 25 Mar 2025 15:23:34 -0400
X-MC-Unique: 6o2r3U6ENt2LxGyVhr6oow-1
X-Mimecast-MFC-AGG-ID: 6o2r3U6ENt2LxGyVhr6oow_1742930614
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5cd0f8961so510986185a.1
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 12:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742930613; x=1743535413;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGPc+KKvUVF0/VjyiBK6ry9YOHGHtkPR3f81nyTsSVw=;
        b=agpgrL5p8Wf9a+lYN+EPx8pQw3OIwoT3Mx4NaK8apIArwkkyYXzzxY8JNqoDBrmjmq
         UrLBHEBE8r4AwE1JrJz0RHuzapfQVIrV+TMjRyjQlL2AKKguG1h7RfpctJ2/LJ+jtBpw
         zfUfw+RJCb0ibT4ehJAgwhyYKF94/5EimH7YvUnsQ5IDujF+f4p7yEMP9JOgradxJ+B2
         xqe6L031Hxf39dWO4fagbxR3lXFUnqfGw0jdd9x+GSPd2l8PxespMwYZdnphUkzhkIM0
         IKHmjrdVMGZ+J4On4gcifzD2f/h9NAcyGvFqakPWCm0TiBOtEOhy+/DndEpKl/M600Rm
         AvOg==
X-Forwarded-Encrypted: i=1; AJvYcCV3wNDTOPPsT5KIO+/wLnER20ls5+V4UGY+ZoyoiYYRA04L5pYS+uVV7FB8ISAd6sW3epjvHUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/2HO6f3+OkliQJGmTFRBLUL7yJX/K5e5sZxgZEB5LR3gpshf
	GV96WT+sy1KLcQdz5x519MgFlu4rDPEfeIXsFFw3zJrlC8A8n4FXuqMvcv8Z0NuwJrPiUkS4aF0
	/q8Y4zM8T22PF6oA9pDeclJIBQRk7f7iDSxHmxJ2XDY9pX5MYoC0aPQeqJbR/rg==
X-Gm-Gg: ASbGnctERqRxcT2ztdsaDoUMnsGx45RpNfBRM5hqaTql4j33hBhKYj9bcGK4ft6uhJN
	zwzeVxXTsMlehGS2A9idXzWbXUkQb0KP54dPSQ9QwRMoFuqqTOhj0wAqdIcsaJkCwtFlWi9Szry
	dTDk3MtOFSJuYsTWY7kpZKYScdDNIeEiDlF6nH8ePu48nFX6lmwIva21Xw0B4CcnIFbdXdI75Zl
	2rWdxPlMjfKBcZ3sdwHpT5GgK+j4kUIqdNh/6ZH257J9GqGr1T9DWhB7gAH4Gp9V7v9Pi0uMFQW
	V+3lGAIwnXn5MDv84Io56dXPKnqTqMn870fBx6A957+0xsZGJsLFgawylllkcA==
X-Received: by 2002:a05:620a:2683:b0:7c5:6b15:1483 with SMTP id af79cd13be357-7c5ba12cb62mr2775738785a.6.1742930613372;
        Tue, 25 Mar 2025 12:23:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFogfXST9P0quyNTvTYHHUG/U9QamkUBcHk6+jhsZnC+sfG6DsPIcTVrpmHkrdnH+xI8GXzUA==
X-Received: by 2002:a05:620a:2683:b0:7c5:6b15:1483 with SMTP id af79cd13be357-7c5ba12cb62mr2775733185a.6.1742930612876;
        Tue, 25 Mar 2025 12:23:32 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b93554c6sm671693185a.101.2025.03.25.12.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 12:23:32 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
Date: Tue, 25 Mar 2025 15:23:30 -0400
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
Cc: Eric Dumazet <edumazet@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, aeh@meta.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
 <20250324121202.GG14944@noisy.programming.kicks-ass.net>
 <CANn89iKykrnUVUsqML7dqMuHx6OuGnKWg-xRUV4ch4vGJtUTeg@mail.gmail.com>
 <67e1b0a6.050a0220.91d85.6caf@mx.google.com>
 <67e1b2c4.050a0220.353291.663c@mx.google.com>
 <67e1fd15.050a0220.bc49a.766e@mx.google.com>
 <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com> <Z-Il69LWz6sIand0@Mac.home>
 <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux>
Content-Language: en-US
In-Reply-To: <Z-L5ttC9qllTAEbO@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/25 2:45 PM, Boqun Feng wrote:
> On Tue, Mar 25, 2025 at 10:52:16AM -0400, Waiman Long wrote:
>> On 3/24/25 11:41 PM, Boqun Feng wrote:
>>> On Mon, Mar 24, 2025 at 09:56:25PM -0400, Waiman Long wrote:
>>>> On 3/24/25 8:47 PM, Boqun Feng wrote:
>>>>> On Mon, Mar 24, 2025 at 12:30:10PM -0700, Boqun Feng wrote:
>>>>>> On Mon, Mar 24, 2025 at 12:21:07PM -0700, Boqun Feng wrote:
>>>>>>> On Mon, Mar 24, 2025 at 01:23:50PM +0100, Eric Dumazet wrote:
>>>>>>> [...]
>>>>>>>>>> ---
>>>>>>>>>>     kernel/locking/lockdep.c | 6 ++++--
>>>>>>>>>>     1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>>>>>>>>>> index 4470680f02269..a79030ac36dd4 100644
>>>>>>>>>> --- a/kernel/locking/lockdep.c
>>>>>>>>>> +++ b/kernel/locking/lockdep.c
>>>>>>>>>> @@ -6595,8 +6595,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
>>>>>>>>>>          if (need_callback)
>>>>>>>>>>                  call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>>>>>>>>>>
>>>>>>>>>> -     /* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
>>>>>>>>>> -     synchronize_rcu();
>>>>>>> I feel a bit confusing even for the old comment, normally I would expect
>>>>>>> the caller of lockdep_unregister_key() should guarantee the key has been
>>>>>>> unpublished, in other words, there is no way a lockdep_unregister_key()
>>>>>>> could race with a register_lock_class()/lockdep_init_map_type(). The
>>>>>>> synchronize_rcu() is not needed then.
>>>>>>>
>>>>>>> Let's say someone breaks my assumption above, then when doing a
>>>>>>> register_lock_class() with a key about to be unregister, I cannot see
>>>>>>> anything stops the following:
>>>>>>>
>>>>>>> 	CPU 0				CPU 1
>>>>>>> 	=====				=====
>>>>>>> 	register_lock_class():
>>>>>>> 	  ...
>>>>>>> 	  } else if (... && !is_dynamic_key(lock->key)) {
>>>>>>> 	  	// ->key is not unregistered yet, so this branch is not
>>>>>>> 		// taken.
>>>>>>> 	  	return NULL;
>>>>>>> 	  }
>>>>>>> 	  				lockdep_unregister_key(..);
>>>>>>> 					// key unregister, can be free
>>>>>>> 					// any time.
>>>>>>> 	  key = lock->key->subkeys + subclass; // BOOM! UAF.
>>> This is not a UAF :(
>>>
>>>>>>> So either we don't need the synchronize_rcu() here or the
>>>>>>> synchronize_rcu() doesn't help at all. Am I missing something subtle
>>>>>>> here?
>>>>>>>
>>>>>> Oh! Maybe I was missing register_lock_class() must be called with irq
>>>>>> disabled, which is also an RCU read-side critical section.
>>>>>>
>>>>> Since register_lock_class() will be call with irq disabled, maybe hazard
>>>>> pointers [1] is better because most of the case we only have nr_cpus
>>>>> readers, so the potential hazard pointer slots are fixed.
>>>>>
>>>>> So the below patch can reduce the time of the tc command from real ~1.7
>>>>> second (v6.14) to real ~0.05 second (v6.14 + patch) in my test env,
>>>>> which is not surprising given it's a dedicated hazard pointers for
>>>>> lock_class_key.
>>>>>
>>>>> Thoughts?
>>>> My understanding is that it is not a race between register_lock_class() and
>>>> lockdep_unregister_key(). It is the fact that the structure that holds the
>>>> lock_class_key may be freed immediately after return from
>>>> lockdep_unregister_key(). So any processes that are in the process of
>>>> iterating the hash_list containing the hash_entry to be unregistered may hit
>>> You mean the lock_keys_hash table, right? I used register_lock_class()
>>> as an example, because it's one of the places that iterates
>>> lock_keys_hash. IIUC lock_keys_hash is only used in
>>> lockdep_{un,}register_key() and is_dynamic_key() (which are only called
>>> by lockdep_init_map_type() and register_lock_class()).
>>>
>>>> a UAF problem. See commit 61cc4534b6550 ("locking/lockdep: Avoid potential
>>>> access of invalid memory in lock_class") for a discussion of this kind of
>>>> UAF problem.
>>>>
>>> That commit seemed fixing a race between disabling lockdep and
>>> unregistering key, and most importantly, call zap_class() for the
>>> unregistered key even if lockdep is disabled (debug_locks = 0). It might
>>> be related, but I'm not sure that's the reason of putting
>>> synchronize_rcu() there. Say you want to synchronize between
>>> /proc/lockdep and lockdep_unregister_key(), and you have
>>> synchronize_rcu() in lockdep_unregister_key(), what's the RCU read-side
>>> critical section at /proc/lockdep?
>> I agree that the commit that I mentioned is not relevant to the current
>> case. You are right that is_dynamic_key() is the only function that is
>> problematic, the other two are protected by the lockdep_lock. So they are
>> safe. Anyway, I believe that the actual race happens in the iteration of the
>> hashed list in is_dynamic_key(). The key that you save in the
>> lockdep_key_hazptr in your proposed patch should never be the key (dead_key)
> The key stored in lockdep_key_hazptr is the one that the rest of the
> function will use after is_dynamic_key() return true. That is,
>
> 	CPU 0				CPU 1
> 	=====				=====
> 	WRITE_ONCE(*lockdep_key_hazptr, key);
> 	smp_mb();
>
> 	is_dynamic_key():
> 	  hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> 	    if (k == key) {
> 	      found = true;
> 	      break;
> 	    }
> 	  }
> 	  				lockdep_unregister_key():
> 					  hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> 					    if (k == key) {
> 					      hlist_del_rcu(&k->hash_entry);
> 				              found = true;
> 				              break;
> 					    }
> 					  }
>
> 				        smp_mb();
>
> 					synchronize_lockdep_key_hazptr():
> 					  for_each_possible_cpu(cpu) {
> 					    <wait for the hazptr slot on
> 					    that CPU to be not equal to
> 					    the removed key>
> 					  }
>
>
> , so that if is_dynamic_key() finds a key was in the hash, even though
> later on the key would be removed by lockdep_unregister_key(), the
> hazard pointers guarantee lockdep_unregister_key() would wait for the
> hazard pointer to release.
>
>> that is passed to lockdep_unregister_key(). In is_dynamic_key():
>>
>>      hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
>>                  if (k == key) {
>>                          found = true;
>>                          break;
>>                  }
>>          }
>>
>> key != k (dead_key), but before accessing its content to get to hash_entry,
> It is the dead_key.
>
>> an interrupt/NMI can happen. In the mean time, the structure holding the key
>> is freed and its content can be overwritten with some garbage. When
>> interrupt/NMI returns, hash_entry can point to anything leading to crash or
>> an infinite loop.  Perhaps we can use some kind of synchronization mechanism
> No, hash_entry cannot be freed or overwritten because the user has
> protect the key with hazard pointers, only when the user reset the
> hazard pointer to NULL, lockdep_unregister_key() can then return and the
> key can be freed.
>
>> between is_dynamic_key() and lockdep_unregister_key() to prevent this kind
>> of racing. For example, we can have an atomic counter associated with each
> The hazard pointer I proposed provides the exact synchronization ;-)

What I am saying is that register_lock_class() is trying to find a 
newkey while lockdep_unregister_key() is trying to take out an oldkey 
(newkey != oldkey). If they happens in the same hash list, 
register_lock_class() will put newkey into the hazard pointer, but 
synchronize_lockdep_key_hazptr() call from lockdep_unregister_key() is 
checking for oldkey which is not the one saved in the hazard pointer. So 
lockdep_unregister_key() will return and the key will be freed and 
reused while is_dynamic_key() may just have a reference to the oldkey 
and trying to access its content which is invalid. I think this is a 
possible scenario.

Cheers, Longman

>
> Regards,
> Boqun
>
>> head of the hashed table. is_dynamic_key() can increment the counter if it
>> is not zero to proceed and lockdep_unregister_key() have to make sure it can
>> safely decrement the counter to 0 before going ahead. Just a thought!
>>
>> Cheers,
>> Longman


