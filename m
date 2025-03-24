Return-Path: <netdev+bounces-177189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39436A6E38C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5D497A5579
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A10319DF77;
	Mon, 24 Mar 2025 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4CVFu+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C674157A46;
	Mon, 24 Mar 2025 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844615; cv=none; b=EPJ5PlGKbtabzsnaySgmigdJzmc753xYcXyuk5X+oj/+rPnn+EQ7D3tta3r7HBw6A2OQLruwrbFSpXB7QID5hMhQ8sZ0Ti8gvo9IiHbNzQ5O/06GzCmqZ12lWjbl6rltkE6m9nMBqxknOk+rg4eE7Y4wXSGJ+ovO1pXXiW5Y9bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844615; c=relaxed/simple;
	bh=z4Bmz8QEbS8bemOrvtD2u3Ao/zjB4T8szLjDdqwXF24=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxhPrPMpRT8xl74j/2+Rba8d1LVjHzIBOeoko2LsrTGBsTnYr10FB67Yg5M2mPdlwXoWqzsk7XfajpWLUEs1ZiL4X+5V48qYdDmu2w1Pg2J6B2TgWkx5HaZs+OZGvAhgi4OPmUxgTqfHEOoA9bourFJsqHDcf7YcM8gDc/gAa9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4CVFu+s; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c08fc20194so989997585a.2;
        Mon, 24 Mar 2025 12:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742844613; x=1743449413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLwcfCvl0y0TOE8vM9dZorE+bZgWQzp6dmKQBP8YWtY=;
        b=O4CVFu+sVmnfHwi8Wpy7Ii7mPLeOHc5bcPw0t0zxTAYdEq/am2tcCts+ZAaO+X6by0
         BedCKnCPbZIbDpHPTJZZCKGfVX4W2O+2+RGEpEiNMmaLDY97zZb6EUNZL3hqHzJCbahd
         5TyytXgHsQ7in2LgbtJTZnhm/FYU+QmF2Rqzd4EnIUcR3fv2wF0IsAYQPFftY93RGN0T
         bujdk6m313TSTponbdI+HFIqGlZDULw1OB4a/EwRf+Cju8ysIk+tKfkEjOWp8zWlhkcf
         QxZCohPWvmLe2qpKt6NlTOL1XFJ+K+p3QT4+9epXuJB5Is+QAV74FfwGENIZ83XxCk/g
         PUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742844613; x=1743449413;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLwcfCvl0y0TOE8vM9dZorE+bZgWQzp6dmKQBP8YWtY=;
        b=gZ627Vap88fgvy/P+VvIybmv3TFz9kJE/H0VJ6LdYeeCMkxTR3EdDj5rHi0aTr6jAa
         f/SnXoHOeMY1Jj5TU9lVB66BByqQa3l7ZbvrDBtwwO4MDGHZpyT2YD3Z5h3ucCR098ub
         mpSnieBVTizmeRa8uMT3MiIG1DoaahNGvctJqfIt0ABCVxKw3g4AfqZWDd13PaEX86T9
         3iaaop4k4NXy7aduAkoY1bQe2v1ahA7pNPNTWzxGVjOOeWFbAQeocWU//IDCW9YCZFCX
         4cVG+B9wqnqhFENxxwQtAsxYCEJHhQlDE2Ve/zGyVXmbW6ymz2vmMSoaPxAxqVcHLJqe
         6UYw==
X-Forwarded-Encrypted: i=1; AJvYcCVhYdaSTRxJDqgQQDj/xWFZmAB4fCi56VLbcTjqyiLqD2zsh2nJz3xNqOfJizr79T7ToIWRGYs25H+5aS0=@vger.kernel.org, AJvYcCW/sV7ZhpgkEDlIo3+/z5eCHctFvnVi2S67km4Sj36kkKp3pMB/ZgBiA8l9frWPW3UMqBrONPVy@vger.kernel.org
X-Gm-Message-State: AOJu0YxV1bsWtuWrGZIM0adCBdOkrGQvZYzd/7kkNHeDsJ9a0BbU/Bie
	MBJhmHS8FX+np9J8Cal+QHbo5QlN/F7WwHz57CiQ3U2oimwFK9k+
X-Gm-Gg: ASbGnctvFhfN4IwRCLJRoDSHksHHrOxadp7aZht7CFxa3+XIqjAozRn5k9cuu/fBnj8
	/FSCPH1eNm7uwWqd6gl67HJ6BFApOBhBWF0WA4MjmteiKKNDLtoVN/rz144I+rrx1ob7dgsYEtw
	MPAbIO5VmjOgdUgRCtzCs5fCLXOz8HSl4yfDrkUq9AmaUkwu0SbBhAUVYcrEPSBE9bv7gZ7YcBY
	7p+Ph6/LKebRspIKqC6d6lmGgQR64MxydBDtZIauPgNOncd0rv4DNo/Zqa/LnIwLCoTTnEMBjkp
	D+hcLPXTVr5YYadCItR9GtqL/21MGa3+23e21OMqt4ZIIxzwJElTqUzDWawXQeLhcU43A8ZAMm5
	P8Jo9UnJtrVK8qpl4dCD37DzZXa89vDmRT0g=
X-Google-Smtp-Source: AGHT+IFrpyIFCPZY9VniQnxujcY9Z2QJCar8QwZDVHX4Q4jyqC+BCirHlv7hbrTGkCMjTV8EvLyE7A==
X-Received: by 2002:a05:620a:d8a:b0:7c5:97ca:3ea0 with SMTP id af79cd13be357-7c5ba090be5mr2107778485a.0.1742844612845;
        Mon, 24 Mar 2025 12:30:12 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b93582d9sm546351685a.96.2025.03.24.12.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 12:30:12 -0700 (PDT)
Message-ID: <67e1b2c4.050a0220.353291.663c@mx.google.com>
X-Google-Original-Message-ID: <Z-Gywg0B93SL4hKx@winterfell.>
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 127281200068;
	Mon, 24 Mar 2025 15:30:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 24 Mar 2025 15:30:12 -0400
X-ME-Sender: <xms:w7LhZ5i3xcp37D9tLhFuXCJqUJ1RZhh_gQf_Xqt4uNVpO5YKE6xIhw>
    <xme:w7LhZ-DXN1GL8HxpoqZE7LJEKO_1993LXOdRpR0BRUDD-C244Z73HprSQ8kHUv4Kn
    F_Na3AM3fJ3d47o5g>
X-ME-Received: <xmr:w7LhZ5GCmvp-FdQd1AEMaRFXSuN9GH7TuCaXoB6Q7MUZsGnoGm0wrgssfKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghp
    thhtoheplhgvihhtrghoseguvggsihgrnhdrohhrghdprhgtphhtthhopehmihhnghhose
    hrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprggvhh
    esmhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:xLLhZ-RJp-Vq56OUoV23i3dgsor0kB9z2zh_r6cmE_OmrGCNh4mc3g>
    <xmx:xLLhZ2wSESeeF_UrqtSRcyNku_ljrE09O5HOvtRlrREUKX4d82XScQ>
    <xmx:xLLhZ058SB1sJabzYbndBqL0iL43_fa_r4Q9Fz_Em9QQwNLSf2iJLw>
    <xmx:xLLhZ7ySEEbu8tSYxD7avqYmQId3MaYIaofg4ob_FsxVx9_MrrYZsA>
    <xmx:xLLhZ-gu5A7cC5Bi0UzLU47GVeJr6TDVovvmK1Ofv3f6R0a1Giv6tesd>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 15:30:11 -0400 (EDT)
Date: Mon, 24 Mar 2025 12:30:10 -0700
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e1b0a6.050a0220.91d85.6caf@mx.google.com>

On Mon, Mar 24, 2025 at 12:21:07PM -0700, Boqun Feng wrote:
> On Mon, Mar 24, 2025 at 01:23:50PM +0100, Eric Dumazet wrote:
> [...]
> > > > ---
> > > >  kernel/locking/lockdep.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > > > index 4470680f02269..a79030ac36dd4 100644
> > > > --- a/kernel/locking/lockdep.c
> > > > +++ b/kernel/locking/lockdep.c
> > > > @@ -6595,8 +6595,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
> > > >       if (need_callback)
> > > >               call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> > > >
> > > > -     /* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
> > > > -     synchronize_rcu();
> 
> I feel a bit confusing even for the old comment, normally I would expect
> the caller of lockdep_unregister_key() should guarantee the key has been
> unpublished, in other words, there is no way a lockdep_unregister_key()
> could race with a register_lock_class()/lockdep_init_map_type(). The
> synchronize_rcu() is not needed then.
> 
> Let's say someone breaks my assumption above, then when doing a
> register_lock_class() with a key about to be unregister, I cannot see
> anything stops the following:
> 
> 	CPU 0				CPU 1
> 	=====				=====
> 	register_lock_class():
> 	  ...
> 	  } else if (... && !is_dynamic_key(lock->key)) {
> 	  	// ->key is not unregistered yet, so this branch is not
> 		// taken.
> 	  	return NULL;
> 	  }
> 	  				lockdep_unregister_key(..);
> 					// key unregister, can be free
> 					// any time.
> 	  key = lock->key->subkeys + subclass; // BOOM! UAF.
> 
> So either we don't need the synchronize_rcu() here or the
> synchronize_rcu() doesn't help at all. Am I missing something subtle
> here?
> 

Oh! Maybe I was missing register_lock_class() must be called with irq
disabled, which is also an RCU read-side critical section.

Regards,
Boqun

> Regards,
> Boqun
> 
> > > > +     /* Wait until is_dynamic_key() has finished accessing k->hash_entry.
> > > > +      * This needs to be quick, since it is called in critical sections
> > > > +      */
> > > > +     synchronize_rcu_expedited();
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(lockdep_unregister_key);
> > >
> > > So I fundamentally despise synchronize_rcu_expedited(), also your
> > > comment style is broken.
> > >
> > > Why can't qdisc call this outside of the lock?
> > 
> > Good luck with that, and anyway the time to call it 256 times would
> > still hurt Breno use case.
> > 
> > My suggestion was to change lockdep_unregister_key() contract, and use
> > kfree_rcu() there
> > 
> > > I think we should redesign lockdep_unregister_key() to work on a separately
> > > allocated piece of memory,
> > > then use kfree_rcu() in it.
> > >
> > > Ie not embed a "struct lock_class_key" in the struct Qdisc, but a pointer to
> > >
> > > struct ... {
> > >      struct lock_class_key key;
> > >      struct rcu_head  rcu;
> > > }
> > 
> > More work because it requires changing all lockdep_unregister_key() users.

