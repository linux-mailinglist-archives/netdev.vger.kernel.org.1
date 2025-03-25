Return-Path: <netdev+bounces-177281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75BCA6E8BA
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 04:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A833B4183
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 03:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E3719EED3;
	Tue, 25 Mar 2025 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNf4iE0k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B48E502B1;
	Tue, 25 Mar 2025 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742874675; cv=none; b=NA4PtmbDGQHNtZP/MxS+Zsek88Ek+1t5lSksGnCd9tJts978gvLetHAhWlxoQxnyiMuu8qqATPRKKzLeJKbQlu9vnZ+GdGtuNIZQDzR7QMPrWaT2QQmy0oE4L2RfK3t41d7UoAIAK7y0EqfML/Wgi9Bv3y0m6hVnLX4G7Imzzgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742874675; c=relaxed/simple;
	bh=eUs830lRhUAS0o8QXZJJqZihKu3k2SgBBk0bl9MB6Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1Sj8xg4piAidWgHUrsceDnNvIQaoJNYXC9GKEmrQ4wimSRn7tZiocw2K3kujwHsmvNu1tRt3lwGPAGZQ9Tbiri0uRj9MuodiPB5PCOwoJ5R6UkClbQYSJ1H7FcQ/4eCriBRz5UcOVS4HxMEx5IqjaVDA8oz3vPEw8gnYGFWlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNf4iE0k; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c58974ed57so519793085a.2;
        Mon, 24 Mar 2025 20:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742874672; x=1743479472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jACLMS8kLVgwcIoWZ4cpXM5EuNr98m6uVIclazt/90k=;
        b=nNf4iE0kqTH4IXnHaaouaAlJeUnxC+jKQCWc41E+rCVV54EBvF70bOt3lm2i8S03fx
         Z0VBwqFgfzEeQ53ZHlLE4AtaWyQfw9mS2pAOK2XDQZpNL4N+1TJrJmKY9GD9N4DreajP
         J12ATjM1he+cM9VnqmoS17PmgjOGDzPFIZ7p1Fut14GPN8mppVO5dyc7rzHEZNjgu54f
         f4xcCaRI1p0ppbGeah9zHKCkPwir44kcEE+0Ht213PfNHsiRrDwtr7nmuiTWRKzv3LJz
         HAWQS3PUyXUnDETsPllS0ucGGFVD+gtDlXz2AHRHa9DqUHNMrnrYOuewJI0zMWX/ZK3P
         dTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742874672; x=1743479472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jACLMS8kLVgwcIoWZ4cpXM5EuNr98m6uVIclazt/90k=;
        b=cIioGk3CX3Rx6UMRwz2rBd6UorAkLWDfZurhOMLhlScfesuOU8YaXLNZpieNEYp/IF
         7H9fZLgNERnr/Gxclv18vGKTzlMsbVk6HqGMxa4n5jyPQLGg4xqNHAuHWh8EU4vYFBos
         wctLuBn6p2vyZ4GJNvV5HTkMkWjqfYM4Ax2nl7O88pgRqIUixDHxwqWsyLh7wHcFaLak
         xylhtF7dXwMZhMzf2xjLZU2b5GCa1zXn5HmDs/g9isOrgvnSq+ktPV/sWPj7LngF2bxU
         49ZzxP2O/8cQ2Rd4J9uHmj0yWj9Tukk6ROlJoDhu1aZbYPk9Cdc3aMTIdkxD6ieEex6b
         3C0g==
X-Forwarded-Encrypted: i=1; AJvYcCUK1de7hpAOcwf8p0xDrx51gvkr2DrFlUW1MlyKtfsw23W4UcnjTJr9RH8Bb+64U34IOK9Dli5B@vger.kernel.org, AJvYcCX5k6Hgyj1n0dTRiJLPYixBxES401YuPuI7XsunD1evn84xpvQDgwmKJlzswfRM+MFkgDOOiBUa9F1Y6Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/4Xfeq5AprwSas1zkbfDJJQ9AVWE0v4i1q+QjFPyRsKh+c8L
	sEOKJpkTR9CceT3GOuv+0iIWpkLI5Md76Sl4SvoQgVAutrcn5B81
X-Gm-Gg: ASbGncvTgQKWAqbdEAieyklAF56ZUDFvuJp9Upgds81k/EP09WNBMkmziFru8RTEDdm
	7T5vowIA6X3VW88dFZj5qjYs+r5iWsoEN3GmsIc3eoJbLnJ+8UqcPKDyYgoFJYatQss7SQoJJN4
	wvpZSH1FUjzSgLHQbB/AHDko8MPHsz0sjS3i7OBY/LZSVQIKcT209zNCVoxaqNqNHbUfgRUTNL7
	otLsf2f6fn7STV9UAwIiyyHCwyZw3jERGHEluwqCI1IOYWRfbOY7lPgRaTDzEUslK2Jjjr0bqW4
	bgqF0AlVRhVxCv/HgTCwCKcvtmwUkqFktE3uRAOk7saV0/FvtbYpSfNaGDqw6AYjcQdVIaaqAUG
	9nebXDXLqsnqLxe5h9lClrhqjcwvjT3X0x1Q=
X-Google-Smtp-Source: AGHT+IGZcrNcUIdofGMok+EQgbGq9PvMQUgblQJa8WffNGEiyeTDF7DfrYOWSiajp7tWBmDULC5BqA==
X-Received: by 2002:a05:620a:2a10:b0:7c5:55c0:db9b with SMTP id af79cd13be357-7c5ba20f0afmr2021710085a.58.1742874671977;
        Mon, 24 Mar 2025 20:51:11 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b9357ab8sm593610185a.92.2025.03.24.20.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 20:51:11 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 402411200043;
	Mon, 24 Mar 2025 23:41:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 24 Mar 2025 23:41:33 -0400
X-ME-Sender: <xms:7SXiZ7nOSPGtRcsSkym-A2pKYEJWObeNsPxSKA1kFoHSDt91TMti7w>
    <xme:7SXiZ-1WPG54AQnRSTzRuc4pIseUaMFacQQh_8J4GexePzMFubJO1GcRbbRK2YL_R
    AH_OAc0JPiEWwRxIg>
X-ME-Received: <xmr:7SXiZxpJpsU6R2ngerUV2wMrEWrTupDsOe1gUNvT12QJvQxJJlvHcPtG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieduiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehllhhonhhgsehrvgguhhgrthdrtghomh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    phgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhgvihhtrghose
    guvggsihgrnhdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggvhhesmh
    gvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:7SXiZznoVcKD5hTcANLgxtFF3_gPankIl-YnbGvMmkobiRH8J6QVew>
    <xmx:7SXiZ53aBqzvqHeGHq-jM0H0AkCJwFC8bx38VlfPjnHC9hnUh5oE0Q>
    <xmx:7SXiZyu_9pa_orIhE5PaJ9u3B8c1dULC4ygBEpz_zaYJRFArDFNNdg>
    <xmx:7SXiZ9WYEe-nMMDInC9sZMX-ZkPs32yHD0sWrv8tbra5xE8-_XYwbQ>
    <xmx:7SXiZ4092jwy67tX9FZK8JEqLI2TXqOQSjUJKcQNbwYJ9YzoFTTf7ZvL>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 23:41:32 -0400 (EDT)
Date: Mon, 24 Mar 2025 20:41:31 -0700
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
Message-ID: <Z-Il69LWz6sIand0@Mac.home>
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
 <20250324121202.GG14944@noisy.programming.kicks-ass.net>
 <CANn89iKykrnUVUsqML7dqMuHx6OuGnKWg-xRUV4ch4vGJtUTeg@mail.gmail.com>
 <67e1b0a6.050a0220.91d85.6caf@mx.google.com>
 <67e1b2c4.050a0220.353291.663c@mx.google.com>
 <67e1fd15.050a0220.bc49a.766e@mx.google.com>
 <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com>

On Mon, Mar 24, 2025 at 09:56:25PM -0400, Waiman Long wrote:
> On 3/24/25 8:47 PM, Boqun Feng wrote:
> > On Mon, Mar 24, 2025 at 12:30:10PM -0700, Boqun Feng wrote:
> > > On Mon, Mar 24, 2025 at 12:21:07PM -0700, Boqun Feng wrote:
> > > > On Mon, Mar 24, 2025 at 01:23:50PM +0100, Eric Dumazet wrote:
> > > > [...]
> > > > > > > ---
> > > > > > >   kernel/locking/lockdep.c | 6 ++++--
> > > > > > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > > > > > > index 4470680f02269..a79030ac36dd4 100644
> > > > > > > --- a/kernel/locking/lockdep.c
> > > > > > > +++ b/kernel/locking/lockdep.c
> > > > > > > @@ -6595,8 +6595,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
> > > > > > >        if (need_callback)
> > > > > > >                call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> > > > > > > 
> > > > > > > -     /* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
> > > > > > > -     synchronize_rcu();
> > > > I feel a bit confusing even for the old comment, normally I would expect
> > > > the caller of lockdep_unregister_key() should guarantee the key has been
> > > > unpublished, in other words, there is no way a lockdep_unregister_key()
> > > > could race with a register_lock_class()/lockdep_init_map_type(). The
> > > > synchronize_rcu() is not needed then.
> > > > 
> > > > Let's say someone breaks my assumption above, then when doing a
> > > > register_lock_class() with a key about to be unregister, I cannot see
> > > > anything stops the following:
> > > > 
> > > > 	CPU 0				CPU 1
> > > > 	=====				=====
> > > > 	register_lock_class():
> > > > 	  ...
> > > > 	  } else if (... && !is_dynamic_key(lock->key)) {
> > > > 	  	// ->key is not unregistered yet, so this branch is not
> > > > 		// taken.
> > > > 	  	return NULL;
> > > > 	  }
> > > > 	  				lockdep_unregister_key(..);
> > > > 					// key unregister, can be free
> > > > 					// any time.
> > > > 	  key = lock->key->subkeys + subclass; // BOOM! UAF.

This is not a UAF :(

> > > > 
> > > > So either we don't need the synchronize_rcu() here or the
> > > > synchronize_rcu() doesn't help at all. Am I missing something subtle
> > > > here?
> > > > 
> > > Oh! Maybe I was missing register_lock_class() must be called with irq
> > > disabled, which is also an RCU read-side critical section.
> > > 
> > Since register_lock_class() will be call with irq disabled, maybe hazard
> > pointers [1] is better because most of the case we only have nr_cpus
> > readers, so the potential hazard pointer slots are fixed.
> > 
> > So the below patch can reduce the time of the tc command from real ~1.7
> > second (v6.14) to real ~0.05 second (v6.14 + patch) in my test env,
> > which is not surprising given it's a dedicated hazard pointers for
> > lock_class_key.
> > 
> > Thoughts?
> 
> My understanding is that it is not a race between register_lock_class() and
> lockdep_unregister_key(). It is the fact that the structure that holds the
> lock_class_key may be freed immediately after return from
> lockdep_unregister_key(). So any processes that are in the process of
> iterating the hash_list containing the hash_entry to be unregistered may hit

You mean the lock_keys_hash table, right? I used register_lock_class()
as an example, because it's one of the places that iterates
lock_keys_hash. IIUC lock_keys_hash is only used in
lockdep_{un,}register_key() and is_dynamic_key() (which are only called
by lockdep_init_map_type() and register_lock_class()).

> a UAF problem. See commit 61cc4534b6550 ("locking/lockdep: Avoid potential
> access of invalid memory in lock_class") for a discussion of this kind of
> UAF problem.
> 

That commit seemed fixing a race between disabling lockdep and
unregistering key, and most importantly, call zap_class() for the
unregistered key even if lockdep is disabled (debug_locks = 0). It might
be related, but I'm not sure that's the reason of putting
synchronize_rcu() there. Say you want to synchronize between
/proc/lockdep and lockdep_unregister_key(), and you have
synchronize_rcu() in lockdep_unregister_key(), what's the RCU read-side
critical section at /proc/lockdep?

Regards,
Boqun

> As suggested by Eric, one possible solution is to add a
> lockdep_unregister_key() variant function that presumes the structure
> holding the key won't be freed until after a RCU delay. In this case, we can
> skip the last synchronize_rcu() call. Any callers that need immediate return
> should use kfree_rcu() to free the structure after calling the
> lockdep_unregister_key() variant.
> 
> Cheers,
> Longman
> 

