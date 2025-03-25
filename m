Return-Path: <netdev+bounces-177563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5647A70991
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 19:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9E3173B57
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA4D191F95;
	Tue, 25 Mar 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jryr+F8N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4541ACEAF;
	Tue, 25 Mar 2025 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928319; cv=none; b=Mpd2dQDFpVkIJAl5cVr3SKOsmtMTf8kL75RaeExnXZhdjXjbuUAEmFZA1LeG93LLwn1EcxOvTepNbXV0BRvAWrwJSV8lkA/XFJiK2hDPMwNCbGkZANcc7hd828w3xW04SHl4YeKtD0wSm9XNXAgZBXjx+uLkFLnB0IS3wEZIsjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928319; c=relaxed/simple;
	bh=qEZFpIWuRP6Vtk/zsOA2rHTCTf0R9H6Scu1+vTSY+FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTIOE3uBA+dG1NAveTPDZiaDmHp5YLIBFG+oOlHHosRHzUrynfVj3Gkepq+FzyqbF2OyLSR6sKkh6RiU8oLvdgyNY10fIuYXtU2/K34IUqBr/9mejNTHLxeQPERqZFX3nSB22ya+iYWpH31ZtfafNnI95GZE0aROcW4H8JfHP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jryr+F8N; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e41e18137bso39589546d6.1;
        Tue, 25 Mar 2025 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742928315; x=1743533115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8aPKsDM7p9B6xrmjt8jZxRum7krTVtb3aktsBDZ1x6Q=;
        b=jryr+F8Nkt3bpxw7d9IsQToPEcPgTp9oU8D0CS/RRkcR8W78WpPJcNhC/V7KyIOm2m
         EXNtcM/QWxhBqSZSh0VJBgAOlSgIn/ejL9SeoiojcZK/ssqRhDsFxXQ2WINYG9syUsKa
         QDyrdxjaVWY4F2bn9bixl52H+CsVl18LKtPTF9xvUDxvuPTSbvscOcP5o6JmugAJITyV
         XqLRpwg96VG9Ha4dVuRCPXJtbqD6gkacy8L9kOxs1w7ITpC1p9wkJo974y5tih2FKEQS
         2cytTB1G8Cl7y/afP/6mK6O8AOStWENPIsSxMM2nKKhAOCKThNBe0+gF8Dhr8nL2L2/D
         PaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742928315; x=1743533115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aPKsDM7p9B6xrmjt8jZxRum7krTVtb3aktsBDZ1x6Q=;
        b=fVVE8sR+zh08/UMPL92qL8lQaLX/SXou8ZXy6IOXyuMGHC9oJcU3y2R6gs1c7sSGX0
         ZHzII4Oj1BFlht0bMVErKFQik7xRT4HB/FIjBFKNmzruQNvuqCGUIF8Xincs9igCznLB
         oDCL3mBPpxf+0S3Hxnw1QByGWI7Y7n/Vk1hot/yFlniackloV1DQkjmRsJV6yq2LwzBS
         k693eBe0A1OPqO0MoPA3/bfXYG2GsBqMTsah0liROjo4KiO8QNKVD/oyy9yUr8tzUUhI
         dC44ZZIG1AA8643AyDaRHBRxFa7axEYlSF4HIMgB8TJ7rn/XH3fJPSQWLvVwJHuDyDm9
         mhaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjbF8t4PSg7ELxJJ3+4PzeVdVUk7rD/KzkUMS/j3+w0wbPY+Sstgulg/iF/ZA0r03mQzWAkcqA@vger.kernel.org, AJvYcCUl56LmfHVtqWeuHbQnJtz/0rhs2grdSi0lFykFl4EwlqVeGAWIhGVPEsXegFvpDYDiZVMshxX2jkJoWdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ58U7DfiZxaMfaUAL8am/fj1bwI5Kqm+eDTzJGOGFjrrqwGE4
	ajPlnmo0L1DNxBh/WvaQA1UQZNgv0aZRAGbs5MZ62jmPpUQ3v+IC
X-Gm-Gg: ASbGnct8d0CGwy8eVT9mH3rvKMu1R0UM2PAMAHyh0p31ekG1zM0Xh7k15bvO+CXl6gp
	MOIO/FJTe/zgFG8N3qy9FKQEVzs1YlbrvlVh5yHgKKUPYofOor5V3eBJ66QBVXHPj10Lh7tsIw2
	g8zAX48dCH+Cifp89p21X/qaNTkE9QkXHeBZyuV4dYo05yVzNaGoKrYSPIlhpeGYV9AmgnHy7G8
	wu+i/cv9u0Y1ECFOp9kYNP7lDAi+O01UNYfDSgUA0wXXNWEGvnKD5urqaT95pi0RoyMFn+ChNoT
	cvKgHjK9QqNWp9Af48oWAv8yEzJKtcCWV0+jVUCv1NnZGHeUvIjGcOi6qUcbRo3I9bEIAtKKHBL
	WomTaHZCKlzhs15hA38yPfG8DSQDlgS/p7+g=
X-Google-Smtp-Source: AGHT+IEGIus1ahdCyxVweaHDXayVNNh7SgLahfHaUgX6eTX8evXnJ2LakhywiNTIR2n89E8qS/+ekg==
X-Received: by 2002:ad4:5aa5:0:b0:6ea:d604:9e59 with SMTP id 6a1803df08f44-6eb3f294df4mr318896326d6.9.1742928314522;
        Tue, 25 Mar 2025 11:45:14 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efe0c0esm58929916d6.97.2025.03.25.11.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:45:14 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id B79E6120007E;
	Tue, 25 Mar 2025 14:45:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 14:45:13 -0400
X-ME-Sender: <xms:ufniZ4RWnQ_xJyIRxLoMCpuBMtn3gORmzYQDOWCGX7vMk-RZeyugpw>
    <xme:ufniZ1yKXoMbTq5P4fptVDaT86ULWrheSjmv5taCOI-hnpdCT81Nk9mO0FlgALFmT
    Gl1tQhTnJHmwenO1w>
X-ME-Received: <xmr:ufniZ13pvyvZAum-RVa9zi_MTtSKs-b9aqjwgXEyxK20Z4M6i8pHhH7yzpY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefgeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ufniZ8BW_xilf_KGdl4Y9zTy4f-KJvH7UP1N57CYG_WfLsdjOBaZJg>
    <xmx:ufniZxg07MFwuRkmYlhXDAM5RCnDJHsxy8-dzkrMbWdCKg0TkjN-Fw>
    <xmx:ufniZ4paZh-vVaSFp-oukE8QyzST9iRwH3gmE1pzOtXSuisb3siGVw>
    <xmx:ufniZ0gawul0Yg7QnW6F5wMP6LspDmoAJA4fI4SWIOpFiH_rREtdkQ>
    <xmx:ufniZ4StUp4jAuJBMCkkGXE8WsHcGT_WERaUWaiL2RPWInrA2TCpZnWZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 14:45:13 -0400 (EDT)
Date: Tue, 25 Mar 2025 11:45:10 -0700
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
Message-ID: <Z-L5ttC9qllTAEbO@boqun-archlinux>
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
 <20250324121202.GG14944@noisy.programming.kicks-ass.net>
 <CANn89iKykrnUVUsqML7dqMuHx6OuGnKWg-xRUV4ch4vGJtUTeg@mail.gmail.com>
 <67e1b0a6.050a0220.91d85.6caf@mx.google.com>
 <67e1b2c4.050a0220.353291.663c@mx.google.com>
 <67e1fd15.050a0220.bc49a.766e@mx.google.com>
 <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com>
 <Z-Il69LWz6sIand0@Mac.home>
 <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>

On Tue, Mar 25, 2025 at 10:52:16AM -0400, Waiman Long wrote:
> On 3/24/25 11:41 PM, Boqun Feng wrote:
> > On Mon, Mar 24, 2025 at 09:56:25PM -0400, Waiman Long wrote:
> > > On 3/24/25 8:47 PM, Boqun Feng wrote:
> > > > On Mon, Mar 24, 2025 at 12:30:10PM -0700, Boqun Feng wrote:
> > > > > On Mon, Mar 24, 2025 at 12:21:07PM -0700, Boqun Feng wrote:
> > > > > > On Mon, Mar 24, 2025 at 01:23:50PM +0100, Eric Dumazet wrote:
> > > > > > [...]
> > > > > > > > > ---
> > > > > > > > >    kernel/locking/lockdep.c | 6 ++++--
> > > > > > > > >    1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > > > > > > > > index 4470680f02269..a79030ac36dd4 100644
> > > > > > > > > --- a/kernel/locking/lockdep.c
> > > > > > > > > +++ b/kernel/locking/lockdep.c
> > > > > > > > > @@ -6595,8 +6595,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
> > > > > > > > >         if (need_callback)
> > > > > > > > >                 call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> > > > > > > > > 
> > > > > > > > > -     /* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
> > > > > > > > > -     synchronize_rcu();
> > > > > > I feel a bit confusing even for the old comment, normally I would expect
> > > > > > the caller of lockdep_unregister_key() should guarantee the key has been
> > > > > > unpublished, in other words, there is no way a lockdep_unregister_key()
> > > > > > could race with a register_lock_class()/lockdep_init_map_type(). The
> > > > > > synchronize_rcu() is not needed then.
> > > > > > 
> > > > > > Let's say someone breaks my assumption above, then when doing a
> > > > > > register_lock_class() with a key about to be unregister, I cannot see
> > > > > > anything stops the following:
> > > > > > 
> > > > > > 	CPU 0				CPU 1
> > > > > > 	=====				=====
> > > > > > 	register_lock_class():
> > > > > > 	  ...
> > > > > > 	  } else if (... && !is_dynamic_key(lock->key)) {
> > > > > > 	  	// ->key is not unregistered yet, so this branch is not
> > > > > > 		// taken.
> > > > > > 	  	return NULL;
> > > > > > 	  }
> > > > > > 	  				lockdep_unregister_key(..);
> > > > > > 					// key unregister, can be free
> > > > > > 					// any time.
> > > > > > 	  key = lock->key->subkeys + subclass; // BOOM! UAF.
> > This is not a UAF :(
> > 
> > > > > > So either we don't need the synchronize_rcu() here or the
> > > > > > synchronize_rcu() doesn't help at all. Am I missing something subtle
> > > > > > here?
> > > > > > 
> > > > > Oh! Maybe I was missing register_lock_class() must be called with irq
> > > > > disabled, which is also an RCU read-side critical section.
> > > > > 
> > > > Since register_lock_class() will be call with irq disabled, maybe hazard
> > > > pointers [1] is better because most of the case we only have nr_cpus
> > > > readers, so the potential hazard pointer slots are fixed.
> > > > 
> > > > So the below patch can reduce the time of the tc command from real ~1.7
> > > > second (v6.14) to real ~0.05 second (v6.14 + patch) in my test env,
> > > > which is not surprising given it's a dedicated hazard pointers for
> > > > lock_class_key.
> > > > 
> > > > Thoughts?
> > > My understanding is that it is not a race between register_lock_class() and
> > > lockdep_unregister_key(). It is the fact that the structure that holds the
> > > lock_class_key may be freed immediately after return from
> > > lockdep_unregister_key(). So any processes that are in the process of
> > > iterating the hash_list containing the hash_entry to be unregistered may hit
> > You mean the lock_keys_hash table, right? I used register_lock_class()
> > as an example, because it's one of the places that iterates
> > lock_keys_hash. IIUC lock_keys_hash is only used in
> > lockdep_{un,}register_key() and is_dynamic_key() (which are only called
> > by lockdep_init_map_type() and register_lock_class()).
> > 
> > > a UAF problem. See commit 61cc4534b6550 ("locking/lockdep: Avoid potential
> > > access of invalid memory in lock_class") for a discussion of this kind of
> > > UAF problem.
> > > 
> > That commit seemed fixing a race between disabling lockdep and
> > unregistering key, and most importantly, call zap_class() for the
> > unregistered key even if lockdep is disabled (debug_locks = 0). It might
> > be related, but I'm not sure that's the reason of putting
> > synchronize_rcu() there. Say you want to synchronize between
> > /proc/lockdep and lockdep_unregister_key(), and you have
> > synchronize_rcu() in lockdep_unregister_key(), what's the RCU read-side
> > critical section at /proc/lockdep?
> I agree that the commit that I mentioned is not relevant to the current
> case. You are right that is_dynamic_key() is the only function that is
> problematic, the other two are protected by the lockdep_lock. So they are
> safe. Anyway, I believe that the actual race happens in the iteration of the
> hashed list in is_dynamic_key(). The key that you save in the
> lockdep_key_hazptr in your proposed patch should never be the key (dead_key)

The key stored in lockdep_key_hazptr is the one that the rest of the
function will use after is_dynamic_key() return true. That is,

	CPU 0				CPU 1
	=====				=====
	WRITE_ONCE(*lockdep_key_hazptr, key);
	smp_mb();

	is_dynamic_key():
	  hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
	    if (k == key) {
	      found = true;
	      break;
	    }
	  }
	  				lockdep_unregister_key():
					  hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
					    if (k == key) {
					      hlist_del_rcu(&k->hash_entry);
				              found = true;
				              break;
					    }
					  }

				        smp_mb();

					synchronize_lockdep_key_hazptr():
					  for_each_possible_cpu(cpu) {
					    <wait for the hazptr slot on
					    that CPU to be not equal to
					    the removed key>
					  }


, so that if is_dynamic_key() finds a key was in the hash, even though
later on the key would be removed by lockdep_unregister_key(), the
hazard pointers guarantee lockdep_unregister_key() would wait for the
hazard pointer to release.

> that is passed to lockdep_unregister_key(). In is_dynamic_key():
> 
>     hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
>                 if (k == key) {
>                         found = true;
>                         break;
>                 }
>         }
> 
> key != k (dead_key), but before accessing its content to get to hash_entry,

It is the dead_key.

> an interrupt/NMI can happen. In the mean time, the structure holding the key
> is freed and its content can be overwritten with some garbage. When
> interrupt/NMI returns, hash_entry can point to anything leading to crash or
> an infinite loop.  Perhaps we can use some kind of synchronization mechanism

No, hash_entry cannot be freed or overwritten because the user has
protect the key with hazard pointers, only when the user reset the
hazard pointer to NULL, lockdep_unregister_key() can then return and the
key can be freed.

> between is_dynamic_key() and lockdep_unregister_key() to prevent this kind
> of racing. For example, we can have an atomic counter associated with each

The hazard pointer I proposed provides the exact synchronization ;-)

Regards,
Boqun

> head of the hashed table. is_dynamic_key() can increment the counter if it
> is not zero to proceed and lockdep_unregister_key() have to make sure it can
> safely decrement the counter to 0 before going ahead. Just a thought!
> 
> Cheers,
> Longman

