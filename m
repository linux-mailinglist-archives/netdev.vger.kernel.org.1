Return-Path: <netdev+bounces-133329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CBF995B09
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B3BB2118E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 22:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F139217910;
	Tue,  8 Oct 2024 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+4NUAGP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8778221503B;
	Tue,  8 Oct 2024 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427455; cv=none; b=qdk6ABpWOn1LCn4+ZOw2WJssf87aaPRbQ/iAyhr1Js5l9PBwEtp5ZdaE1WOynbhvRKvijKMZ5pgG/a/1+jjJIvfW9WoOWnPAgRqes9Bo4orqJuNNh2SrdpHfY3XEcIvDALMukF28fsVhxkScFjnuKfAW85WmpFlYIcMGfkOUjs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427455; c=relaxed/simple;
	bh=/FRhju6OZTXPmsTdnMH8o1bOozrFFjuoN85+xzVaq2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7KEodmc6EDIfM2DPtdWjphGiMshQonUfC8q1nv0pDwNW4rlxw8+InGmkoAalHXESoKKVcO/flRe50UeKHrysG2zYHI9IIPUoHrF/vYe3ziqpO2cBLbGuCqov6jdjDDo87bOA/Av/ZsR8eny+CAgLCbujRLtqXlZ7px7s+1ga3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+4NUAGP; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4582f9abb43so41795341cf.2;
        Tue, 08 Oct 2024 15:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728427452; x=1729032252; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RqgiQbZha4FLfEseXSQzK7NvkT/59J//hj+63erYNfQ=;
        b=g+4NUAGPdTx18bExxntdvsvU/e44bGAHT9ZrDXRDKJQErPZlst29Lb87bhBWI2HKNA
         0gUJJ8lS6Ng0+U06bKIhlFawDxI/StF2UvJ/UL7oGKN7GSK32zUFeKuspKHEEIqqzmib
         29XV4pMrm6ppmKdh2sPxTPgYA/ChOSgqbcaMm59zrC57yxGmVeEdZdTmjnEemyxxzzSD
         C86PgGAMNGwINMClXhEYIblGUL2M2N1lBuD2TBE9BS38yvGj7D/T9Hw7OoT/aFWCykn8
         /dXN7IpG/Uu51l95NBACln+6n0dpRm/oeynL1MJe6O3Bp223LxnGNaV2Yn0oL4q8/ZYF
         Aucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427452; x=1729032252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqgiQbZha4FLfEseXSQzK7NvkT/59J//hj+63erYNfQ=;
        b=VL6wVBruW4hH5E7o834weVWXnVMNCvCm+LbOA9q7Skjm/J3GW2RxO2/La0NzBwU8kI
         ZvJSFWz2bpAwR29Nxdn4xz7Ot5ECEWfiUkPhznJu5kxqBHPaTkE5JSoAFHLe+KYjVQwN
         ZcOgVMfx5qlFpC0FXsfQRpyetBFQwuLDqDa9KTmyTdPiWsD25Ad3IhfxB50MejWyMOWv
         hddMD3rPOhgXAUPaUVDiIpn/MOeG0dlGS9CdDlehD9dzE1xC8B97xg9E4gHmQ+5bDg0I
         d3Uh0Jn8g+DiCaVBxDOdRKcOcyxuUPgy49rYVjsd5trDb9t0LjNz+E0vtRpSo69o3oWL
         niMw==
X-Forwarded-Encrypted: i=1; AJvYcCVDJxmVq/Z4ssm2MU7YHB7o1dfEUamJZMzgtYrSaOAItbbjREWzKttZOJ8A9j9kKzAO0aM/Jv4uy5fOUZUIlns=@vger.kernel.org, AJvYcCVQAZdhDyxKmAo6UZOWlE2phqa8fUOyhUnykq9HTl4ZOJnRUFCpyEl4hFK2rP+IiYIUZbAjU9iH@vger.kernel.org, AJvYcCX9AM/nI/ktRzYI2k+7+TjLqPIfstJ1B126POn2pScOgD6IVg7OF7xQDFkw9gbQOxswvHvqUp18EfyHBx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+VTRL1Fwz6Kon4q6NncY4sMpFJSmFyMt6148NnXR9emA/aV22
	RuFc1EjDRbLGnc14EYocXW7Prercdy0sBhhsy7FsqXnymyiJe926
X-Google-Smtp-Source: AGHT+IFRhQDWVAzs6gHbC0s4ucr7t2+ntbhqLuufaTyWmm0uy2soT0GvyU5CtpvXOzNcwAP8GF3uzQ==
X-Received: by 2002:a05:622a:1f18:b0:45d:9236:89f2 with SMTP id d75a77b69052e-45f9f994740mr6346581cf.2.1728427452407;
        Tue, 08 Oct 2024 15:44:12 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7afce5892ffsm60230485a.45.2024.10.08.15.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:44:12 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8840E1200066;
	Tue,  8 Oct 2024 18:44:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 08 Oct 2024 18:44:11 -0400
X-ME-Sender: <xms:u7UFZ5KIPPxzWPR-PhWShF9O32Ni2Z8qkud6hjD0DQORQ2RnLNouig>
    <xme:u7UFZ1JuB5MCVaNguSGppi6FBKnZYCTCvX0aj3zFbG7V5KzzqJcFkKhqUDhXE1nGf
    rSmCYGgX3GzAi7PaA>
X-ME-Received: <xmr:u7UFZxv9Pw6ZiZ_OMDf9itShdc312qYzQl5Brmf3Jmw_6BawWvx_MiCFrjX4ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfh
    gfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtg
    hpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhmrghilhdrtgho
    mhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehfuhhjihhtrgdrthhomhhonhhorhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqd
    hfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhk
    rghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuh
    hmihgthhdrvgguuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:u7UFZ6ZybJIzDKgLRLCR73JzP5FB0T2YKeIvuHteDkk9q_K9fnIJYw>
    <xmx:u7UFZwa5eahnWS1huXUgcxjdQZK-WsUhOlZyVlRfZAbOhst568pARg>
    <xmx:u7UFZ-DHfV5oAXienUrEcsAAT0o2dvfD_D8sAET00csJks27x5PKMg>
    <xmx:u7UFZ-brPjKhEuh2tNGTFMYFXg8bN9s4EohnbsL1eCB29w_E0Ei0qA>
    <xmx:u7UFZ8rhc-HbVL00hIDfZDJ8-3YMRKJJ2arw94Xru5Dti1nkAJ_Hu_qI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 18:44:11 -0400 (EDT)
Date: Tue, 8 Oct 2024 15:42:49 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <ZwW1aUGqEj6i4ywb@boqun-archlinux>
References: <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
 <ZwPsdvzxQVsD7wHm@boqun-archlinux>
 <5368483b-679a-4283-8ce2-f30064d07cad@lunn.ch>
 <ZwRq7PzAPzCAIBVv@boqun-archlinux>
 <c3955011-e131-45c9-bf74-da944e336842@lunn.ch>
 <CANiq72m3WFj9Eb2iRUM3mLFibWW+cupAoNQt+cqtNa4O9=jq7Q@mail.gmail.com>
 <df2c9ea8-fa3a-416e-affd-b3891b2ab3f7@lunn.ch>
 <ZwWp9C2X_QIrTJEq@boqun-archlinux>
 <32e97ba4-a47b-488a-b098-725faae21d7d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32e97ba4-a47b-488a-b098-725faae21d7d@lunn.ch>

On Wed, Oct 09, 2024 at 12:26:00AM +0200, Andrew Lunn wrote:
> On Tue, Oct 08, 2024 at 02:53:56PM -0700, Boqun Feng wrote:
> > On Tue, Oct 08, 2024 at 07:16:42PM +0200, Andrew Lunn wrote:
> > > On Tue, Oct 08, 2024 at 03:14:05PM +0200, Miguel Ojeda wrote:
> > > > On Tue, Oct 8, 2024 at 2:13 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > > >
> > > > > As far as i see, might_sleep() will cause UAF where there is going to
> > > > > be a UAF anyway. If you are using it correctly, it does not cause UAF.
> > > > 
> > > > This already implies that it is an unsafe function (in general, i.e.
> > > > modulo klint, or a way to force the user to have to write `unsafe`
> > > > somewhere else, or what I call ASHes -- "acknowledged soundness
> > > > holes").
> > > > 
> > > > If we consider as safe functions that, if used correctly, do not cause
> > > > UB, then all functions would be safe.
> > > 
> > > From what i hear, klint is still WIP. So we have to accept there will
> > > be bad code out there, which will UAF. We want to find such bad code,
> > 
> > If you don't believe in klint
> 
> I did not say that. It is WIP, and without it i assume nothing is
> detecting at compile time that the code is broken. Hence we need to
> find the problem at runtime, which is what might_sleep() is all about.
> 
> > might_sleep() is useful because it checks preemption count and task
> > state, which is provided by __might_sleep() as well. I don't think
> > causing UAF helps we detect atomic context violation faster than what
> > __might_sleep() already have. Again, could you provide an example that
> > help me understand your reasoning here?
> 
> > > while (1) {
> > >     <reader>                        <updater>
> > >     rcu_read_lock();
> > >     p = rcu_dereference(gp);
> > >     mutex_lock(&lock)
> > >     a = READ_ONCE(p->a);
> > >     mutex_unlock(&lock)
> > >     rcu_read_unlock();
> > > }
> 
> The mutex lock is likely to be uncontested, so you don't sleep, and so
> don't trigger the UAF. The code is clearly broken, but you survive.
> Until the lock is contested, you do sleep, RCU falls apart, resulting
> in a UAF.
> 
> Now if you used might_sleep(), every time you go around that loop you
> do some of the same processing as actually sleeping, so are much more
> likely to trigger the UAF.
> 
> might_sleep() as you pointed out, is also active when
> CONFIG_DEBUG_ATOMIC_SLEEP is false. Thus it is also going to trigger
> the broken code to UAF faster. And i expect a lot of testing is done
> without CONFIG_DEBUG_ATOMIC_SLEEP and CONFIG_PROVE_LOCKING.
> 

Hmm.. but that means we need to quickly detect UAF and track down to the
source, right? In a build without CONFIG_DEBUG_ATOMIC_SLEEP and
CONFIG_PROVE_LOCKING, may I assume memory sanitizer is also not
available? Then how do we detect UAF relatively quickly? Or memory
sanitizer is in fact relatively cheap, so it can still be enabled,
what's the configuration of netdev CI/testing?

Regards,
Boqun

> Once klint is completed, and detects all these problems at compile
> time, we can then discard all this might_sleep stuff. But until then,
> the faster code explodes, the more likely it is going to be quickly
> and cheaply fixed.
> 
> 	Andrew

