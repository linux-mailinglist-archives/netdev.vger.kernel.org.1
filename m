Return-Path: <netdev+bounces-177581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F606A70AA5
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0378F16E15A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93B91EE7B1;
	Tue, 25 Mar 2025 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjO7E8p2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2AC198851;
	Tue, 25 Mar 2025 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931747; cv=none; b=O5yL1wAIcmrlG1Qc4YOZHxwfPpNKXOyM3X4iz7BgQM31DCgfNxV2v4aZqzxLxQK8GB1CvssQMYuh93a33sJTZsTQGugB5o2oOUcEdGZ9Vktsjk5Y+ZfnVFra9fox7Xm2xPGH/SuSUh8Qu50isM/gJRcofOdwTAyaGr3Fxc0hSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931747; c=relaxed/simple;
	bh=/4Tr2YHezReD5GfIXzuly0inwea4xXnaQgrkkdIt3hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/WTSTSyeWTHvfQNeSSHCXFt+yytwaSJxGBHFT7MJg40nPKfpqYSoU4k932+IqmbS6Tyl0551sAWPgDV7YwPp2lfJ/Vfm+jX8b0mVA13+rd8b0I4gFEQ0lDEGqbooFmJdc6JA9RkacQ0I6MZtOtMl6KpW6JFwchrt74bYXsPG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjO7E8p2; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4766631a6a4so60350311cf.2;
        Tue, 25 Mar 2025 12:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742931745; x=1743536545; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4kuWfubrYLQqCtXqxj3ycgJGcbDPfPrIR6m9CHzJJoM=;
        b=GjO7E8p2ndznE5YMJ2NXJ+ZxXcT1gSSLJxriR6tI9KO4EDe6xugBdPC/brn7cYkEPS
         wUh1eRTQKHn72dcOfCOaMiJQnwJdRE8bbbVVSI1qFMoWqFGQpNixF5Su+7mKjBUZ+wSO
         3IJK9J0fZAPwFBnlY2RWkZnWO4BmZP80rLeymm2DwSjsyTcCr9hludAGdbXq6wr4TKru
         eef9yXzFeY5B63Wpht6LeFg+k/2GBVRNIozLhuiVFZTAFfNm2ghcgL3JQDUFMS+c/tuM
         0LGVX5UmefBzQeSyqgTquCx22ZekF/LHVL300b3vc9nOPq2CWqUmAMP1YTD2Hc4MiEz+
         NZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742931745; x=1743536545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kuWfubrYLQqCtXqxj3ycgJGcbDPfPrIR6m9CHzJJoM=;
        b=r5PxOfooaFcKjGgyIOML6/WaY0YnIaB7LfUGhgdbWwzpFMD9pliIDV/7k55L81p27w
         NWi1Kx3YSCRI4mPyoBVWTISfSvoZX5wEEsSqY+iM82PE/QAHqTlGU622oSeIB4EJhDnj
         4p5pWki/JmlAzkwNC9InAV59zeUh646q7yB8DU+dvjaXDyb7NkEVbYaApqhO4rl+Mhw1
         URjuBsTWt+ssJzJcQa16FOcPrlDq+cwSu15zCrgQArUzXtd99GnzmUX7cQBP0ZFLPak1
         gtlgVevLF/7Ue4XvI6acsrsCjxmQhcKQeer1VDP7yBpdurGLr/H6EQkYzSCQCXsSzR8c
         4n1A==
X-Forwarded-Encrypted: i=1; AJvYcCUmdE7xIeo5FvQPrdqhqbZH4HJF9wRspN9Zd1MkpqVy/c7biVMbM1lbKfJeSQo/UbBZl9q7ZdkC2woPWo0=@vger.kernel.org, AJvYcCVUtlxYdxkPTshada7KOrTjz0FExRgtbR9Ayc1RArzNCqDoeUAuS71IO7wc88W8ruAz6qtjEC2r@vger.kernel.org
X-Gm-Message-State: AOJu0YwcP1zLEEOWSmCzFtx4xq89rQCKZWZSoYkG20odwYSexZIhrIst
	ortaE5z1k7BPZMcYSnOxVlDVQ1OfSe8gt5y+w3jidmCH5L4AIPYJ
X-Gm-Gg: ASbGnct0nryTE/IDFCbj4nAEndO7HZmdQggskDV9Heq2qzfwRc9t6+rXVXAoFhYseF5
	hO1mN5uJ5ND/WD4+v7Cv4rckQQNil8xoeaYZtrdPF9gGM8I6IYM5uVb/D9yg3phHoViuUWlFuKF
	r9wMIUM2u36Vu7Z/K42gsdP0kpkyt972mMoMNbVQh3jYCsXeJAffQM4tLlJaPklf4YR4suOU+Gr
	f1up5x2Sns1kxnbOMpbfp1K9LSrIQl1z/RoWaYsY2uejog46mzEhl/5CEqERZLlsxCu2T9iKFxZ
	RFjhlFJGalc6rsvZdXKffaAL4ffdoPd2VyIC9x4olnSOXU8kcSinq2ynshzjHP5sxOefzX04b2m
	EstgqsERrVsxJjtnTXtka8VfCi6isl1hKxbw=
X-Google-Smtp-Source: AGHT+IFWeGo6VJgDw5xCYNe/SKyK2rIPG277FLuDdhfuIuOtMtnu+14mPmK1jSw23WpemqZy8m5wug==
X-Received: by 2002:a05:622a:410e:b0:476:79d2:af58 with SMTP id d75a77b69052e-4771dd88c0emr317945971cf.23.1742931744785;
        Tue, 25 Mar 2025 12:42:24 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d17611esm63704461cf.21.2025.03.25.12.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 12:42:24 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id C8D951200043;
	Tue, 25 Mar 2025 15:42:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 25 Mar 2025 15:42:23 -0400
X-ME-Sender: <xms:HwfjZysUPbJ6C8n1_5Id-I_krUgT0OtN2kcPI_Ux2Gaz74uuOw3_LA>
    <xme:HwfjZ3dUuu3emfHLzrG8TPR8xkiJeBFArkssjIsJq7paNjDqNGqEw3U3gjSNK446X
    2BMTk-wmRGUJpwJjA>
X-ME-Received: <xmr:HwfjZ9w4Tae2okXP5oOMjb8epI-tufP8ev8cH1_q9DMd79ZONniOvV2mKh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefhedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:HwfjZ9NJqhQ4kTASTOPxLZ8AFpQgi8Fq-5e3hKABW0ZwAnownBudtw>
    <xmx:HwfjZy_FnA_7i_WTqHoHZdOZ6Gl5rDnIVS128YYIKMGCgRxIbJoZPA>
    <xmx:HwfjZ1XLIokqKyLvbTPdkbfxzUbfFGVZD423K86mdF8OaeBRip61QQ>
    <xmx:HwfjZ7eCeEFODzVH6R5FkCNuW60XdP4D-b1z6-BBKfaeGLVEhNCQJQ>
    <xmx:HwfjZ8feJGE_xSBOb5B8_lueZVKLYlIouTszXqJADDJTvGdxy-Jqb96h>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 15:42:23 -0400 (EDT)
Date: Tue, 25 Mar 2025 12:42:20 -0700
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
Message-ID: <Z-MHHFTS3kcfWIlL@boqun-archlinux>
References: <20250324121202.GG14944@noisy.programming.kicks-ass.net>
 <CANn89iKykrnUVUsqML7dqMuHx6OuGnKWg-xRUV4ch4vGJtUTeg@mail.gmail.com>
 <67e1b0a6.050a0220.91d85.6caf@mx.google.com>
 <67e1b2c4.050a0220.353291.663c@mx.google.com>
 <67e1fd15.050a0220.bc49a.766e@mx.google.com>
 <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com>
 <Z-Il69LWz6sIand0@Mac.home>
 <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>

On Tue, Mar 25, 2025 at 03:23:30PM -0400, Waiman Long wrote:
[...]
> > > > That commit seemed fixing a race between disabling lockdep and
> > > > unregistering key, and most importantly, call zap_class() for the
> > > > unregistered key even if lockdep is disabled (debug_locks = 0). It might
> > > > be related, but I'm not sure that's the reason of putting
> > > > synchronize_rcu() there. Say you want to synchronize between
> > > > /proc/lockdep and lockdep_unregister_key(), and you have
> > > > synchronize_rcu() in lockdep_unregister_key(), what's the RCU read-side
> > > > critical section at /proc/lockdep?
> > > I agree that the commit that I mentioned is not relevant to the current
> > > case. You are right that is_dynamic_key() is the only function that is
> > > problematic, the other two are protected by the lockdep_lock. So they are
> > > safe. Anyway, I believe that the actual race happens in the iteration of the
> > > hashed list in is_dynamic_key(). The key that you save in the
> > > lockdep_key_hazptr in your proposed patch should never be the key (dead_key)
> > The key stored in lockdep_key_hazptr is the one that the rest of the
> > function will use after is_dynamic_key() return true. That is,
> > 
> > 	CPU 0				CPU 1
> > 	=====				=====
> > 	WRITE_ONCE(*lockdep_key_hazptr, key);
> > 	smp_mb();
> > 
> > 	is_dynamic_key():
> > 	  hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> > 	    if (k == key) {
> > 	      found = true;
> > 	      break;
> > 	    }
> > 	  }
> > 	  				lockdep_unregister_key():
> > 					  hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> > 					    if (k == key) {
> > 					      hlist_del_rcu(&k->hash_entry);
> > 				              found = true;
> > 				              break;
> > 					    }
> > 					  }
> > 
> > 				        smp_mb();
> > 
> > 					synchronize_lockdep_key_hazptr():
> > 					  for_each_possible_cpu(cpu) {
> > 					    <wait for the hazptr slot on
> > 					    that CPU to be not equal to
> > 					    the removed key>
> > 					  }
> > 
> > 
> > , so that if is_dynamic_key() finds a key was in the hash, even though
> > later on the key would be removed by lockdep_unregister_key(), the
> > hazard pointers guarantee lockdep_unregister_key() would wait for the
> > hazard pointer to release.
> > 
> > > that is passed to lockdep_unregister_key(). In is_dynamic_key():
> > > 
> > >      hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> > >                  if (k == key) {
> > >                          found = true;
> > >                          break;
> > >                  }
> > >          }
> > > 
> > > key != k (dead_key), but before accessing its content to get to hash_entry,
> > It is the dead_key.
> > 
> > > an interrupt/NMI can happen. In the mean time, the structure holding the key
> > > is freed and its content can be overwritten with some garbage. When
> > > interrupt/NMI returns, hash_entry can point to anything leading to crash or
> > > an infinite loop.  Perhaps we can use some kind of synchronization mechanism
> > No, hash_entry cannot be freed or overwritten because the user has
> > protect the key with hazard pointers, only when the user reset the
> > hazard pointer to NULL, lockdep_unregister_key() can then return and the
> > key can be freed.
> > 
> > > between is_dynamic_key() and lockdep_unregister_key() to prevent this kind
> > > of racing. For example, we can have an atomic counter associated with each
> > The hazard pointer I proposed provides the exact synchronization ;-)
> 
> What I am saying is that register_lock_class() is trying to find a newkey
> while lockdep_unregister_key() is trying to take out an oldkey (newkey !=
> oldkey). If they happens in the same hash list, register_lock_class() will
> put newkey into the hazard pointer, but synchronize_lockdep_key_hazptr()
> call from lockdep_unregister_key() is checking for oldkey which is not the
> one saved in the hazard pointer. So lockdep_unregister_key() will return and
> the key will be freed and reused while is_dynamic_key() may just have a
> reference to the oldkey and trying to access its content which is invalid. I
> think this is a possible scenario.
> 

Oh, I see. And yes, the hazard pointers I proposed cannot prevent this
race unfortunately. (Well, technically we can still use an extra slot to
hold the key in the hash list iteration, but that would generates a lot
of stores, so it won't be ideal). But...

[...]
> > > head of the hashed table. is_dynamic_key() can increment the counter if it
> > > is not zero to proceed and lockdep_unregister_key() have to make sure it can
> > > safely decrement the counter to 0 before going ahead. Just a thought!
> > > 

Your idea inspires another solution with hazard pointers, we can
put the pointer of the hash_head into the hazard pointer slot ;-)

in register_lock_class():

		/* hazptr: protect the key */
		WRITE_ONCE(*key_hazptr, keyhashentry(lock->key));

		/* Synchronizes with the smp_mb() in synchronize_lockdep_key_hazptr() */
		smp_mb();

		if (!static_obj(lock->key) && !is_dynamic_key(lock->key)) {
			return NULL;
		}

in lockdep_unregister_key():

	/* Wait until register_lock_class() has finished accessing k->hash_entry. */
	synchronize_lockdep_key_hazptr(keyhashentry(key));


which is more space efficient than per hash list atomic or lock unless
you have 1024 or more CPUs.

Regards,
Boqun

> > > Cheers,
> > > Longman
> 

