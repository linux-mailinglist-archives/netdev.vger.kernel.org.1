Return-Path: <netdev+bounces-177271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B99A6E7C2
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 01:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46983AE402
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 00:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498F5DDAB;
	Tue, 25 Mar 2025 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHNyNHcD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695672F5B;
	Tue, 25 Mar 2025 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863642; cv=none; b=DxqXyUVkwOQy6dDtVdCYk5gHxVk9RRSSIQiw5A2fGVECjUDbR1NXlftoGKX0FFOKcwC7vE16C2W/gBsROO7KHZoKiJ4KVKchHKVQ0+/XTH4eChz/HON+GM7ut3s2wVJdHriSq0qZBTUQjtIV5uj1Djhz/aiZBWV82AtX4XXzmsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863642; c=relaxed/simple;
	bh=kJqe6zy2w6R/dZTxWSDYd3ztOPrkyEEXLHnNxQzmgxs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmNx8kqIx5MB4yY5H0ZNN1FN8Ew/COu8nH5v5spYkF48fmDVjzVjNQWLnTl8tFm8LxKO118HbUmBSNS1sjUwyakQOU8vz35SSEvMKFJODki4I7lm4GCWCJdsGBkWhFlprOxD4E9n22cYwwR9uQOQ/cpjlERBfr7d5wZio5jslG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHNyNHcD; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5aecec8f3so742697285a.1;
        Mon, 24 Mar 2025 17:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742863638; x=1743468438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGFoPX02J0rKdWIT35Fkavu1u/h8I3AS9Vn20GaG3Rw=;
        b=MHNyNHcD7FCVKwGTiYGQUAnMtGkBo3k/BqPPdrxu2czlWP7drdvDGJ88b61c06uQCS
         XPBrCDDraQBzIJ4O0yETOloOTBz/5UCqMmy2i9IXf6gO4TOLGhMQLNVylEiu26VS6lMb
         OcJF9IAHpK2/JNC6HSnCL1Mq1UrFcmdOUGHVl4ZzzaYARyyCM/seKcz34Hbv+/aAZBma
         4LhcOPI2qBn2EzlHrLGpC8p7M6Vv0GpO6v5nPojJ2rjcDSx9j/XJimTj/bNoNa4F3+R2
         kZ6altmY/xtqwytU3zIt3mkVDUHkkeKZ9G1h2cmS0dbGUUSuwm9OmnQvWwMwRDXeQXIc
         HdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742863638; x=1743468438;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGFoPX02J0rKdWIT35Fkavu1u/h8I3AS9Vn20GaG3Rw=;
        b=mn2FScMgttyp8aCLBK/QT9g1uWP3zcilE0ag6CXrSu+cPkXzJBP013R0I/bQDF2viE
         Q/oLudQYUScXolp9LXMYKGH9O8CcTZnhh9ja61PJB3b9UqqdLJoI+Sm3aXcNmk2O5UBT
         A8c/bbdVySV5bX+DWr2MVvHuyUCfHwLmBlEV0r1kJuEH0zJMMG87DMVMY9wOve820hGD
         KxXwABEb0/D7RfYsQeeBoXqpha9WeG59X7INxA/duM3n4+AhCvMz2QquTFrWzjVcQV0Z
         z2ArKNSTCiwsxOda/TWdizmetBOn1zss2AngelQoIGqdWsE7E9rSLcBdyRIOCymNobdd
         fKzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWoib1nn5bRDWicnVtkUBnnhOnbg5cJq+SJrj7JW1QqUuTnICP9bwGJcrjjdWsDRE+Fyaqi1ReXHTRn8c=@vger.kernel.org, AJvYcCX9K3aIaGZe1BBv9HXoToLID5LIJixSuwv8x0r/2xxaF3RkS/LvttTYPf3yv8J/NZtGuTjNcCzj@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8tZS0t11WHvQybdEjnY01E47BVkVAC736ZP6PS/MF2bjf5Ke
	yS0h+S/rNKBm/RT+3KDkis1fch5PI4jEmqs+YCIQe7y6h98BM5ci
X-Gm-Gg: ASbGncveNW6FYoenlEUhk1Q4V9s38yKPNUcfuu7weNBfc0HGr+jItGQXolCOjDeANQQ
	QwZAXg9dCy7x//8tkL2fwrmvZAsteIjB8JsJ3jAkRokBCWbc92woXYyEvbCWc3QZV9HNKt5cSGi
	86uNayyHo4ah/HMIDcBN0xpVR8SXKH9/TnMEkxDcXXWQySYqv5stCHTncY9jhbpzwCrbiTMw4If
	EQiGGUC2KHaXp92a0yJVcJPiaTbvxyW6IyuoD+CQUEq0X8YxgKrSAzbzUT/s++SyIunQzT16sc5
	KzWVwR1Zao4vLmYF2n9CuUSyq8Y9T6kRhTsTAR41iqVIbAnrBKbmf2WGmCSbiW8P0VmWTod81m9
	tf+7VXvq1a4V2R4/p6pBlw2bhhmgcXGs3Lmihr5ghwXhlBw==
X-Google-Smtp-Source: AGHT+IGVceQWklvknfSNjdYbovTerDYG7U/iebFPCkPnd3AnDaRQ+MKOXvTZVTz9KabbQGTzK/y9ig==
X-Received: by 2002:a05:620a:4108:b0:7c5:48bc:8c89 with SMTP id af79cd13be357-7c5ba194e9emr2173961185a.27.1742863637927;
        Mon, 24 Mar 2025 17:47:17 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92d88dasm575160685a.43.2025.03.24.17.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:47:17 -0700 (PDT)
Message-ID: <67e1fd15.050a0220.bc49a.766e@mx.google.com>
X-Google-Original-Message-ID: <Z-H9E7TtssgC65xe@winterfell.>
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id F2E951200043;
	Mon, 24 Mar 2025 20:47:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 24 Mar 2025 20:47:17 -0400
X-ME-Sender: <xms:FP3hZyU5GR_O2S1IbWa3U3I4eyWzDtaHRr5DP_qOWt0z8GuChrFQZw>
    <xme:FP3hZ-muJvOPjy5UKb0n0zfYxFY-HHLIFTqDV6W4igJh7IeS-QZN3fqQR8XfuX8jq
    yQwoVKsiM4dKrMWUg>
X-ME-Received: <xmr:FP3hZ2Ynyoz79ITMY-cOYkM9hrPyf00GevC7G4XFZc2i2jv960Wqr2QQ7sJQHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieduvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghtvghr
    iiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlvghithgrohesuggvsghirg
    hnrdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthht
    ohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopegrvghhsehmvghtrgdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FP3hZ5XWY5x0nKqFkmlkyscef7HeCfK7du_5_vleoNH6ka87SbzHkg>
    <xmx:FP3hZ8n_64wGiCs_-E7ijrM7aFBuMgxtPxZiNgbKT5a_4iHqbdRZ9w>
    <xmx:FP3hZ-cafaTnG6wwzHRtWNFwP9GjE2NKiw9pdmBz7oP9BIUpzLwaDA>
    <xmx:FP3hZ-GPAQFcl4Kp-wfUsOmgXw-BNmCvkO3bCtHoz74Zxpz6da0ncA>
    <xmx:FP3hZ6k1C5-F9272UodwNalyjV4_VkTszdJyo8f8w4FVXkku5f3R6lFN>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 20:47:16 -0400 (EDT)
Date: Mon, 24 Mar 2025 17:47:15 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Breno Leitao <leitao@debian.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
 <20250324121202.GG14944@noisy.programming.kicks-ass.net>
 <CANn89iKykrnUVUsqML7dqMuHx6OuGnKWg-xRUV4ch4vGJtUTeg@mail.gmail.com>
 <67e1b0a6.050a0220.91d85.6caf@mx.google.com>
 <67e1b2c4.050a0220.353291.663c@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e1b2c4.050a0220.353291.663c@mx.google.com>

On Mon, Mar 24, 2025 at 12:30:10PM -0700, Boqun Feng wrote:
> On Mon, Mar 24, 2025 at 12:21:07PM -0700, Boqun Feng wrote:
> > On Mon, Mar 24, 2025 at 01:23:50PM +0100, Eric Dumazet wrote:
> > [...]
> > > > > ---
> > > > >  kernel/locking/lockdep.c | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > > > > index 4470680f02269..a79030ac36dd4 100644
> > > > > --- a/kernel/locking/lockdep.c
> > > > > +++ b/kernel/locking/lockdep.c
> > > > > @@ -6595,8 +6595,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
> > > > >       if (need_callback)
> > > > >               call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> > > > >
> > > > > -     /* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
> > > > > -     synchronize_rcu();
> > 
> > I feel a bit confusing even for the old comment, normally I would expect
> > the caller of lockdep_unregister_key() should guarantee the key has been
> > unpublished, in other words, there is no way a lockdep_unregister_key()
> > could race with a register_lock_class()/lockdep_init_map_type(). The
> > synchronize_rcu() is not needed then.
> > 
> > Let's say someone breaks my assumption above, then when doing a
> > register_lock_class() with a key about to be unregister, I cannot see
> > anything stops the following:
> > 
> > 	CPU 0				CPU 1
> > 	=====				=====
> > 	register_lock_class():
> > 	  ...
> > 	  } else if (... && !is_dynamic_key(lock->key)) {
> > 	  	// ->key is not unregistered yet, so this branch is not
> > 		// taken.
> > 	  	return NULL;
> > 	  }
> > 	  				lockdep_unregister_key(..);
> > 					// key unregister, can be free
> > 					// any time.
> > 	  key = lock->key->subkeys + subclass; // BOOM! UAF.
> > 
> > So either we don't need the synchronize_rcu() here or the
> > synchronize_rcu() doesn't help at all. Am I missing something subtle
> > here?
> > 
> 
> Oh! Maybe I was missing register_lock_class() must be called with irq
> disabled, which is also an RCU read-side critical section.
> 

Since register_lock_class() will be call with irq disabled, maybe hazard
pointers [1] is better because most of the case we only have nr_cpus
readers, so the potential hazard pointer slots are fixed.

So the below patch can reduce the time of the tc command from real ~1.7
second (v6.14) to real ~0.05 second (v6.14 + patch) in my test env,
which is not surprising given it's a dedicated hazard pointers for
lock_class_key.

Thoughts?

[1]: https://lore.kernel.org/lkml/20240917143402.930114-1-boqun.feng@gmail.com/

Regards,
Boqun

---------------------------------->8
From: Boqun Feng <boqun.feng@gmail.com>
Date: Mon, 24 Mar 2025 13:38:15 -0700
Subject: [PATCH] WIP

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 65 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4470680f0226..0b6e78d56cfe 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -111,6 +111,29 @@ late_initcall(kernel_lockdep_sysctls_init);
 DEFINE_PER_CPU(unsigned int, lockdep_recursion);
 EXPORT_PER_CPU_SYMBOL_GPL(lockdep_recursion);
 
+/* hazptr free always clears the slot */
+DEFINE_FREE(lockdep_key_hazptr, struct lock_class_key **, if (_T) smp_store_release((_T), NULL));
+DEFINE_PER_CPU(struct lock_class_key *, lockdep_key_hazptr);
+
+static void synchronize_lockdep_key_hazptr(struct lock_class_key *key)
+{
+	int cpu;
+
+	if (!key)
+		return;
+	/*
+	 * Synchronizes with the smp_mb() after protecting the pointer with
+	 * WRITE_ONCE().
+	 */
+	smp_mb();
+
+	for_each_possible_cpu(cpu) {
+		struct lock_class_key **hazptr = per_cpu_ptr(&lockdep_key_hazptr, cpu);
+
+		smp_cond_load_acquire(hazptr, VAL != key);
+	}
+}
+
 static __always_inline bool lockdep_enabled(void)
 {
 	if (!debug_locks)
@@ -1283,6 +1306,7 @@ static struct lock_class *
 register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 {
 	struct lockdep_subclass_key *key;
+	struct lock_class_key **key_hazptr __free(lockdep_key_hazptr) = NULL;
 	struct hlist_head *hash_head;
 	struct lock_class *class;
 	int idx;
@@ -1293,11 +1317,25 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	if (likely(class))
 		goto out_set_class_cache;
 
+	/* Interrupts are disabled hence it's safe to acquire the hazptr slot */
+	key_hazptr = this_cpu_ptr(&lockdep_key_hazptr);
+
+	/* hazptr slot must be unusued */
+	BUG_ON(*key_hazptr);
+
 	if (!lock->key) {
 		if (!assign_lock_key(lock))
 			return NULL;
-	} else if (!static_obj(lock->key) && !is_dynamic_key(lock->key)) {
-		return NULL;
+	} else {
+		/* hazptr: protect the key */
+		WRITE_ONCE(*key_hazptr, lock->key);
+
+		/* Synchronizes with the smp_mb() in synchronize_lockdep_key_hazptr() */
+		smp_mb();
+
+		if (!static_obj(lock->key) && !is_dynamic_key(lock->key)) {
+			return NULL;
+		}
 	}
 
 	key = lock->key->subkeys + subclass;
@@ -4964,16 +5002,35 @@ void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 	 */
 	if (DEBUG_LOCKS_WARN_ON(!key))
 		return;
+
+	preempt_disable();
+	struct lock_class_key **hazptr __free(lockdep_key_hazptr) = this_cpu_ptr(&lockdep_key_hazptr);
+
+	/* hapztr: Protect the key */
+	WRITE_ONCE(*hazptr, key);
+
+	/* Synchronizes with the smp_mb() in synchronize_lockdep_key_hazptr() */
+	smp_mb();
+
 	/*
 	 * Sanity check, the lock-class key must either have been allocated
 	 * statically or must have been registered as a dynamic key.
 	 */
 	if (!static_obj(key) && !is_dynamic_key(key)) {
+		preempt_enable();
 		if (debug_locks)
 			printk(KERN_ERR "BUG: key %px has not been registered!\n", key);
 		DEBUG_LOCKS_WARN_ON(1);
 		return;
 	}
+
+	/* hazptr: Release the key */
+	smp_store_release(hazptr, NULL);
+
+	/* Do not auto clean up*/
+	hazptr = NULL;
+	preempt_enable();
+
 	lock->key = key;
 
 	if (unlikely(!debug_locks))
@@ -6595,8 +6652,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	if (need_callback)
 		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 
-	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-	synchronize_rcu();
+	/* Wait until register_lock_class() has finished accessing key. */
+	synchronize_lockdep_key_hazptr(key);
 }
 EXPORT_SYMBOL_GPL(lockdep_unregister_key);
 
-- 
2.48.1



