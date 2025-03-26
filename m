Return-Path: <netdev+bounces-177663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A484A7101D
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 06:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632937A2E4E
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 05:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383E417B506;
	Wed, 26 Mar 2025 05:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK547f0z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A71F16B;
	Wed, 26 Mar 2025 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742966735; cv=none; b=KMLpbvaByypr532Kuvl5ChHLPcZ7valxug2BywMZgBWcqOdkSJPsnGj9c5gOZN6M38WPF0qxuUEUTtXvkHgAk5wJ4xUosKpCOsqKRWSXZEcW2zWutjTcnQmPeECPAveD3aPDxu2Ra5pdMWbXwnVkgGA9iP0x2SckvB8TSIdFgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742966735; c=relaxed/simple;
	bh=6p22P6aJ3R7iByl6TF3R4bJSCYXNPxwoS4bL5Twd4io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2SVf2HeHXn/rp1J6kYhYvAjlNYmdWb0Gk+awDh5HBFmbgo0wfTLSkSsPo71Y6NR9uX2dlfrAmNrLn7l/m+eHh1Gu+ukaMWCAduu5WTQLE3CeUwXxCsy3TdVeXnBCUoPouaDqcX5zzg9UtizLBMiSK08z74FbLrwOhVrFm8mEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IK547f0z; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e89a2501a0so61127656d6.1;
        Tue, 25 Mar 2025 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742966732; x=1743571532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VJBvguYGH4f+pr17a1nyN6pA9fJBnK+7uyQqZIkKBzY=;
        b=IK547f0zUF6t+Aoxn6jQZFP1p4NKoeo8hzeLgCPQGgERL62UPtuD76j9Cp07KOheAy
         CwON3/nWsrQhwLUe7qdwWHiuwmvWysioJz9Lvzfr4T2Ly7B+zjnwpbelpclopXTseiJL
         rGozCyqCU2Oagtz5mFBjdnWsQWhymXqNf72nxhJMk6tvEaIPL0K3EnUdtIHc/rf1yc3t
         bZqgdXKeS/gHN+QPIMJ9COSEuvVl93PlUfFqBONt3glwcj4HBD8wSnTDNJgnxSU0MJKQ
         naIVUzEh0Q98Tb0Y7aLcPGLarr/pYfcvkqbrJIcstqLWl7/LXWgHX3CHVKbBLoWwBIIr
         j2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742966732; x=1743571532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJBvguYGH4f+pr17a1nyN6pA9fJBnK+7uyQqZIkKBzY=;
        b=wAEz2cxFC0fdIo0FDyXcp9PyMEQS8vzsfoZoMkP2Z9rU4etDrjgpqjE1OTzT2uCtTi
         JErAbja9NI+pACdddrICVUl/Llm+fkGO7Q8g3PNHMP05L30snrb61YZffsxDr6pXfumh
         AakZT56TJCFUb9jkxwX0D0P5TDJPOc+yR6bJ4ghegrOan6ya6W2K2eaAm2/q6kSE2+UK
         pmtDp6WXSzBEtnoCM7jw80KciZ/FVX/3Upp0q6J5i56pJ94+9TtkfHXIdviOtvqj1/0B
         hIiMnNXlxqhfEjqTaizrbQl1VYRZWCjOYtOl0BYvpiCNNs3uapF/TMnt3ADtnD9tm/e7
         XYgg==
X-Forwarded-Encrypted: i=1; AJvYcCVBuwPmtfPyMYmatfrZFAxrpb4iYZcXSiYsmlZhMVOc/9ZA3aSFkJ5OS6njOW1LnK/oRHgp/JM9@vger.kernel.org, AJvYcCXC20HyndytiVoWUuXOZ1c0GfcdBa8Gx35lXq+I2NhVsvZsRbODoGbaMy7jKGTSN6SrBseV8i30hAhxbk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMa04Ee0amWn91ASsk6T3sYf1U6tECHdS1/VLc5EnuW3WZnumn
	ZCoBhL7Q/8We4hsdgsujAbI0Xnbr8poWUNeSJiyFdXtZv/fuhiCZ
X-Gm-Gg: ASbGncuzV7frNlEvbyNUXMQ5Z4/CU0g4L7zGiV+t4Oo/WizWBm9WW16yb+rKYpPqOvj
	2pWWT5r60Qid2pZUltbC5fBoMUI10XTwmFNMQWIpb9nENEeBzGrUP1cd1D/fA9ckKdR9jdSnUsq
	kL1x8MRX9+P8MtUP1fNBLWE8/AQQOQdIgzKBZmQTPiN9Lq+7mifKFGbaOyWCYVKdIWEp11IYURH
	GYA/dDuTxux2lKtO1UQqC4CxIlOec5UkJhK58no60JjTvz8QIU16LL6L6kuXx4GcXbJoGOTNpBA
	nhlyHXM9TGmNqXaAG9T61+e13ETxET1w91WEHFiPfmABXgqg1qnqbv0f2dp4n3gFvUZK7t9z295
	Mb44dkrY9qbJGigEWeEDeZ5+9HuBYs3oESqQ=
X-Google-Smtp-Source: AGHT+IEX8Mm48J9uw8izft2BGYqHE2+syPpYZEFkQKomLSfbTA+OSh6ZP6WdswSV3v1dw6ZyzndIfQ==
X-Received: by 2002:ad4:5cad:0:b0:6e8:fb7e:d33b with SMTP id 6a1803df08f44-6eb3f33c469mr344993366d6.33.1742966731843;
        Tue, 25 Mar 2025 22:25:31 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f5ccsm64051766d6.37.2025.03.25.22.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 22:25:31 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id B05D91200066;
	Wed, 26 Mar 2025 01:25:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 26 Mar 2025 01:25:30 -0400
X-ME-Sender: <xms:yo_jZ-WuA8ihqbXKZy3KSNT-prpQ98xI87Q-fYd5__yiunjTpxqmtw>
    <xme:yo_jZ6lRxZHWuCJPIMjRRuUUnCgNrmIE0IBoT7tUlf3wX5B6ZDtvV2jRQRffRHb5F
    8aGrOFyx4UoI9YtIw>
X-ME-Received: <xmr:yo_jZybzjSWirarXWH0cjQlzNadmHAXbXm8MbDvb00K4j7sYaa36hRHd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tddunecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnheptdegheelveffudejffegvdelgffhhfel
    keeiieefgeevteejvdegveeuffeihefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedugedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhlohhnghesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlvghithgroh
    esuggvsghirghnrdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrvghhse
    hmvghtrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:yo_jZ1UX0OWgB3smckJ99ZF1cL1kuBudxleKN0pC4tyWzR4Tjb9O_w>
    <xmx:yo_jZ4kRMEPMoGXrRW3qULozRI7LAO_5ZLjnAa-R3zZj-vazfjjPLQ>
    <xmx:yo_jZ6cpa0TyXRoitjuUUOybmu0gWFLdJIxgoQBwHltnU9ww6-13zg>
    <xmx:yo_jZ6FXnhPJBLmHEdK_yOgx8wJNcIPuHTZCcz5Ejv1SNZYjSVOXrA>
    <xmx:yo_jZ2nCQgxhjPxbsD-a3k2wTpLziz0acNUclk8OyyxOvWbTDzrhlTQ8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 01:25:30 -0400 (EDT)
Date: Tue, 25 Mar 2025 22:25:29 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
Message-ID: <Z-OPya5HoqbKmMGj@Mac.home>
References: <67e1b0a6.050a0220.91d85.6caf@mx.google.com>
 <67e1b2c4.050a0220.353291.663c@mx.google.com>
 <67e1fd15.050a0220.bc49a.766e@mx.google.com>
 <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com>
 <Z-Il69LWz6sIand0@Mac.home>
 <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com>

On Tue, Mar 25, 2025 at 07:20:44PM -0400, Waiman Long wrote:
> On 3/25/25 3:42 PM, Boqun Feng wrote:
> > On Tue, Mar 25, 2025 at 03:23:30PM -0400, Waiman Long wrote:
> > [...]
> > > > > > That commit seemed fixing a race between disabling lockdep and
> > > > > > unregistering key, and most importantly, call zap_class() for the
> > > > > > unregistered key even if lockdep is disabled (debug_locks = 0). It might
> > > > > > be related, but I'm not sure that's the reason of putting
> > > > > > synchronize_rcu() there. Say you want to synchronize between
> > > > > > /proc/lockdep and lockdep_unregister_key(), and you have
> > > > > > synchronize_rcu() in lockdep_unregister_key(), what's the RCU read-side
> > > > > > critical section at /proc/lockdep?
> > > > > I agree that the commit that I mentioned is not relevant to the current
> > > > > case. You are right that is_dynamic_key() is the only function that is
> > > > > problematic, the other two are protected by the lockdep_lock. So they are
> > > > > safe. Anyway, I believe that the actual race happens in the iteration of the
> > > > > hashed list in is_dynamic_key(). The key that you save in the
> > > > > lockdep_key_hazptr in your proposed patch should never be the key (dead_key)
> > > > The key stored in lockdep_key_hazptr is the one that the rest of the
> > > > function will use after is_dynamic_key() return true. That is,
> > > > 
> > > > 	CPU 0				CPU 1
> > > > 	=====				=====
> > > > 	WRITE_ONCE(*lockdep_key_hazptr, key);
> > > > 	smp_mb();
> > > > 
> > > > 	is_dynamic_key():
> > > > 	  hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> > > > 	    if (k == key) {
> > > > 	      found = true;
> > > > 	      break;
> > > > 	    }
> > > > 	  }
> > > > 	  				lockdep_unregister_key():
> > > > 					  hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> > > > 					    if (k == key) {
> > > > 					      hlist_del_rcu(&k->hash_entry);
> > > > 				              found = true;
> > > > 				              break;
> > > > 					    }
> > > > 					  }
> > > > 
> > > > 				        smp_mb();
> > > > 
> > > > 					synchronize_lockdep_key_hazptr():
> > > > 					  for_each_possible_cpu(cpu) {
> > > > 					    <wait for the hazptr slot on
> > > > 					    that CPU to be not equal to
> > > > 					    the removed key>
> > > > 					  }
> > > > 
> > > > 
> > > > , so that if is_dynamic_key() finds a key was in the hash, even though
> > > > later on the key would be removed by lockdep_unregister_key(), the
> > > > hazard pointers guarantee lockdep_unregister_key() would wait for the
> > > > hazard pointer to release.
> > > > 
> > > > > that is passed to lockdep_unregister_key(). In is_dynamic_key():
> > > > > 
> > > > >       hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> > > > >                   if (k == key) {
> > > > >                           found = true;
> > > > >                           break;
> > > > >                   }
> > > > >           }
> > > > > 
> > > > > key != k (dead_key), but before accessing its content to get to hash_entry,
> > > > It is the dead_key.
> > > > 
> > > > > an interrupt/NMI can happen. In the mean time, the structure holding the key
> > > > > is freed and its content can be overwritten with some garbage. When
> > > > > interrupt/NMI returns, hash_entry can point to anything leading to crash or
> > > > > an infinite loop.  Perhaps we can use some kind of synchronization mechanism
> > > > No, hash_entry cannot be freed or overwritten because the user has
> > > > protect the key with hazard pointers, only when the user reset the
> > > > hazard pointer to NULL, lockdep_unregister_key() can then return and the
> > > > key can be freed.
> > > > 
> > > > > between is_dynamic_key() and lockdep_unregister_key() to prevent this kind
> > > > > of racing. For example, we can have an atomic counter associated with each
> > > > The hazard pointer I proposed provides the exact synchronization ;-)
> > > What I am saying is that register_lock_class() is trying to find a newkey
> > > while lockdep_unregister_key() is trying to take out an oldkey (newkey !=
> > > oldkey). If they happens in the same hash list, register_lock_class() will
> > > put newkey into the hazard pointer, but synchronize_lockdep_key_hazptr()
> > > call from lockdep_unregister_key() is checking for oldkey which is not the
> > > one saved in the hazard pointer. So lockdep_unregister_key() will return and
> > > the key will be freed and reused while is_dynamic_key() may just have a
> > > reference to the oldkey and trying to access its content which is invalid. I
> > > think this is a possible scenario.
> > > 
> > Oh, I see. And yes, the hazard pointers I proposed cannot prevent this
> > race unfortunately. (Well, technically we can still use an extra slot to
> > hold the key in the hash list iteration, but that would generates a lot
> > of stores, so it won't be ideal). But...
> > 
> > [...]
> > > > > head of the hashed table. is_dynamic_key() can increment the counter if it
> > > > > is not zero to proceed and lockdep_unregister_key() have to make sure it can
> > > > > safely decrement the counter to 0 before going ahead. Just a thought!
> > > > > 
> > Your idea inspires another solution with hazard pointers, we can
> > put the pointer of the hash_head into the hazard pointer slot ;-)
> > 
> > in register_lock_class():
> > 
> > 		/* hazptr: protect the key */
> > 		WRITE_ONCE(*key_hazptr, keyhashentry(lock->key));
> > 
> > 		/* Synchronizes with the smp_mb() in synchronize_lockdep_key_hazptr() */
> > 		smp_mb();
> > 
> > 		if (!static_obj(lock->key) && !is_dynamic_key(lock->key)) {
> > 			return NULL;
> > 		}
> > 
> > in lockdep_unregister_key():
> > 
> > 	/* Wait until register_lock_class() has finished accessing k->hash_entry. */
> > 	synchronize_lockdep_key_hazptr(keyhashentry(key));
> > 
> > 
> > which is more space efficient than per hash list atomic or lock unless
> > you have 1024 or more CPUs.
> 
> It looks like you are trying hard to find a use case for hazard pointer in
> the kernel :-)
> 

Well, if it does the job, why not use it ;-) Also this shows how
flexible hazard pointers can be.

At least when using hazard pointers, the reader side of the hash list
iteration is still lockless. Plus, since the synchronization part
doesn't need to wait for the RCU readers in the whole system, it will be
faster (I tried with the protecting-the-whole-hash-list approach as
well, it's the same result on the tc command). This is why I choose to
look into hazard pointers. Another mechanism can achieve the similar
behavior is SRCU, but SRCU is slightly heavier compared to hazard
pointers in this case (of course SRCU has more functionalities).

We can provide a lockdep_unregister_key_nosync() without the
synchronize_rcu() in it and let users do the synchronization, but it's
going to be hard to enforce and review, especially when someone
refactors the code and move the free code to somewhere else.

> Anyway, that may work. The only problem that I see is the issue of nesting
> of an interrupt context on top of a task context. It is possible that the
> first use of a raw_spinlock may happen in an interrupt context. If the
> interrupt happens when the task has set the hazard pointer and iterating the
> hash list, the value of the hazard pointer may be overwritten. Alternatively
> we could have multiple slots for the hazard pointer, but that will make the
> code more complicated. Or we could disable interrupt before setting the
> hazard pointer.

Or we can use lockdep_recursion:

	preempt_disable();
	lockdep_recursion_inc();
	barrier();

	WRITE_ONCE(*hazptr, ...);

, it should prevent the re-entrant of lockdep in irq.

> 
> The solution that I am thinking about is to have a simple unfair rwlock to
> protect just the hash list iteration. lockdep_unregister_key() and
> lockdep_register_key() take the write lock with interrupt disabled. While
> is_dynamic_key() takes the read lock. Nesting in this case isn't a problem
> and we don't need RCU to protect the iteration process and so the last
> synchronize_rcu() call isn't needed. The level of contention should be low
> enough that live lock isn't an issue.
> 

This could work, one thing though is that locks don't compose. Using a
hash write_lock in lockdep_unregister_key() will create a lockdep_lock()
-> "hash write_lock" dependency, and that means you cannot
lockdep_lock() while you're holding a hash read_lock, although it's
not the case today, but it certainly complicates the locking design
inside lockdep where there's no lockdep to help ;-)

Regards,
Boqun

> Cheers,
> Longman
> 
> 

