Return-Path: <netdev+bounces-177273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B79A6E823
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 02:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735B0189691A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 01:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33F1156C79;
	Tue, 25 Mar 2025 01:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WT1DjQ4L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C002B42A9D
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867792; cv=none; b=SC7iwTyIbECVjUFfi+RwZzJbwFH1OPMSi7oTX6N0m4FD+NorDm8iGJBkfL+SSEjSGHSZgWMzcuTQJEh7ebL39AaGw0dQ+U+Px9gTuePvbhiLW+gpGZBl2Jq0wrwED2D5qezFmFN22VSKkr3dwumjktUzvMxzoMpW4Nv/ALeNpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867792; c=relaxed/simple;
	bh=fK/UsrCxMTb/bFeRcKZI1xKhJ5uNZYEiUm6hg7SWcH4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GQW+j2livK2KxR6qAonxO6km7Kp+fPuFyAKcW9DfvpZv23wOci6YYsjBX//LaX69jqDYKuNmVje5aR1TqFB4b4nTEcxfuwWexUcntMrX4Jzr4QGwspsWsvhtpkJ2tFRPwJxvZiwyvnqlH8LfvCYQ33ha45zhheHLoXE+mj58hkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WT1DjQ4L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742867789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGi7NAnxBHUh6gjg9N+ded9e6tq7Gp9efHz1x28aF8Y=;
	b=WT1DjQ4LW2lZjnQL3JL0xOXnkIZInUDEoaRKFyAmanu3CvOufnzpmo/wfikAzfPUD3FcCA
	Rde9VEkp4AWkJ+4KekqqUAG6KPZfskSDz++wFsRhNZqwQ0s1ykOgJ9k6cBrcV/MpwVT0E4
	YlbIS+eoG46ZFNyDfrEkDPVocDy+tuc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-2T2jsWKxOiG8E7b5rvNJyg-1; Mon, 24 Mar 2025 21:56:28 -0400
X-MC-Unique: 2T2jsWKxOiG8E7b5rvNJyg-1
X-Mimecast-MFC-AGG-ID: 2T2jsWKxOiG8E7b5rvNJyg_1742867788
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4768656f608so104467841cf.1
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 18:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742867788; x=1743472588;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aGi7NAnxBHUh6gjg9N+ded9e6tq7Gp9efHz1x28aF8Y=;
        b=rT95EKEYjsfJXa2fWzLuP7d2x0wTmcfJGEUateXa2yfDgE911hLmZ0PpOe9gU4WwUg
         1DTgvRIUJqvvQaEpj+wlEA+ogU9EWwPy5TOlV22uZOKAycN60pdBOYpZqP/p2MXjNuFZ
         K/cj1q2SdkGB8GyHzqX5tXw+5iHpx8IXvSpol31iuH/aTfyZopViZ0HfDl8q0vH70oVx
         H9ALSjhsN6gKLd8QTx4eq38UDinbhkD4JtWebH8QTVfvdSMsZmHYETcK/0afc8WBolhS
         Lv7r2RnlsE+DtiGYPKWRic2q0f6+9AuSC1JHRfQA+6lmUqgGgE98PP8hdzTZTrec1Y/z
         UYOw==
X-Forwarded-Encrypted: i=1; AJvYcCVNbrKHwJ2RACsvvA9aq3hUD1NgItl8zTmFXsrW5ncJarcPBN/MJoUlDufKe1bpBEsGS4/jZSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQV7vgV5C1Wkb/y5GTJ4GAxz5wgs1gy4/sCMmxgu3/wFpb9ROl
	F4h1agY5mi4ZK4FVBFO+J3bGlBiKauKrHtfvWaE2g3aOVOScul/6prSu2DBjYgd88FibegXKasy
	Ci/AVX/LfuGUS+goX+BOi192it1RQc7sEkBU0YCBpx9ntJb7zgQ29MQ==
X-Gm-Gg: ASbGncsdzXjql5Qx1ggPqnRyP1ZEvm85YLcZRUXlJFEMXbkFxRAhtlsEK7TUCZHKk3p
	oVbVMHmPE99TfWsXjk9UxFOmRullzL3LON0vGaE63RdI83WcMLNT/vPDRwGFHlMlx0HKcvdtcjN
	LWJ+JPldc+U2ysbl94ifAxp174yRU36SAwjKjR4baqeqWJODPQYROgmrKDW3bXvH3cGLUe3a+DD
	+Oj8PXqvcn7jTq02oy9RmJzfVCRf0jjEtBY26WS2PLDPWmmFuuTgNWw3DsKp6DoqobYZFOE6VEr
	f/I9I2qtubHOQKcji7Tz7OKu6N0zSFSalfAo2xPqCzoVD6qAcMDPONh1YHLyCA==
X-Received: by 2002:a05:622a:4c8a:b0:476:aead:802c with SMTP id d75a77b69052e-4771ddf06a6mr253342351cf.36.1742867787641;
        Mon, 24 Mar 2025 18:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZHSdt8gryK7O+AdpXsKRXlm4DRU4seZmKB5+iQXgPpdf8Tf3GXj6xgUGJTZ621axJfD0q0A==
X-Received: by 2002:a05:622a:4c8a:b0:476:aead:802c with SMTP id d75a77b69052e-4771ddf06a6mr253342101cf.36.1742867787152;
        Mon, 24 Mar 2025 18:56:27 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d17b320sm54082861cf.31.2025.03.24.18.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 18:56:26 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com>
Date: Mon, 24 Mar 2025 21:56:25 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Boqun Feng <boqun.feng@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Breno Leitao <leitao@debian.org>,
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
Content-Language: en-US
In-Reply-To: <67e1fd15.050a0220.bc49a.766e@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/25 8:47 PM, Boqun Feng wrote:
> On Mon, Mar 24, 2025 at 12:30:10PM -0700, Boqun Feng wrote:
>> On Mon, Mar 24, 2025 at 12:21:07PM -0700, Boqun Feng wrote:
>>> On Mon, Mar 24, 2025 at 01:23:50PM +0100, Eric Dumazet wrote:
>>> [...]
>>>>>> ---
>>>>>>   kernel/locking/lockdep.c | 6 ++++--
>>>>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>>>>>> index 4470680f02269..a79030ac36dd4 100644
>>>>>> --- a/kernel/locking/lockdep.c
>>>>>> +++ b/kernel/locking/lockdep.c
>>>>>> @@ -6595,8 +6595,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
>>>>>>        if (need_callback)
>>>>>>                call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>>>>>>
>>>>>> -     /* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
>>>>>> -     synchronize_rcu();
>>> I feel a bit confusing even for the old comment, normally I would expect
>>> the caller of lockdep_unregister_key() should guarantee the key has been
>>> unpublished, in other words, there is no way a lockdep_unregister_key()
>>> could race with a register_lock_class()/lockdep_init_map_type(). The
>>> synchronize_rcu() is not needed then.
>>>
>>> Let's say someone breaks my assumption above, then when doing a
>>> register_lock_class() with a key about to be unregister, I cannot see
>>> anything stops the following:
>>>
>>> 	CPU 0				CPU 1
>>> 	=====				=====
>>> 	register_lock_class():
>>> 	  ...
>>> 	  } else if (... && !is_dynamic_key(lock->key)) {
>>> 	  	// ->key is not unregistered yet, so this branch is not
>>> 		// taken.
>>> 	  	return NULL;
>>> 	  }
>>> 	  				lockdep_unregister_key(..);
>>> 					// key unregister, can be free
>>> 					// any time.
>>> 	  key = lock->key->subkeys + subclass; // BOOM! UAF.
>>>
>>> So either we don't need the synchronize_rcu() here or the
>>> synchronize_rcu() doesn't help at all. Am I missing something subtle
>>> here?
>>>
>> Oh! Maybe I was missing register_lock_class() must be called with irq
>> disabled, which is also an RCU read-side critical section.
>>
> Since register_lock_class() will be call with irq disabled, maybe hazard
> pointers [1] is better because most of the case we only have nr_cpus
> readers, so the potential hazard pointer slots are fixed.
>
> So the below patch can reduce the time of the tc command from real ~1.7
> second (v6.14) to real ~0.05 second (v6.14 + patch) in my test env,
> which is not surprising given it's a dedicated hazard pointers for
> lock_class_key.
>
> Thoughts?

My understanding is that it is not a race between register_lock_class() 
and lockdep_unregister_key(). It is the fact that the structure that 
holds the lock_class_key may be freed immediately after return from 
lockdep_unregister_key(). So any processes that are in the process of 
iterating the hash_list containing the hash_entry to be unregistered may 
hit a UAF problem. See commit 61cc4534b6550 ("locking/lockdep: Avoid 
potential access of invalid memory in lock_class") for a discussion of 
this kind of UAF problem.

As suggested by Eric, one possible solution is to add a 
lockdep_unregister_key() variant function that presumes the structure 
holding the key won't be freed until after a RCU delay. In this case, we 
can skip the last synchronize_rcu() call. Any callers that need 
immediate return should use kfree_rcu() to free the structure after 
calling the lockdep_unregister_key() variant.

Cheers,
Longman


