Return-Path: <netdev+bounces-132746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E1C992F91
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E6C1F21252
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F161D54CD;
	Mon,  7 Oct 2024 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiqPuw5M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B11D47BD;
	Mon,  7 Oct 2024 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311974; cv=none; b=ixPSmMLyLuCjkMHtegezdQzdfH+mRKrqi7sMbnhFNAwiNurT6HnvvtRdHGeQD024kFZWLiwzDAqi17K6qukWCY9RC1BGS08bhiat+f6f2XOKiMPoquj4s6ut7mrKbs1BFveW0iBee+pxk0gixjBCc0xR+1mYy4RWdAvj8Q9Tttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311974; c=relaxed/simple;
	bh=so8+PFP40cxP5c7KplFeXeV+kA3v4pE5SsNcauIXn2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmmcpDsRdKdLr2Lvyu5s5xtg4jpa/8iZxnGki86C5m0IsAJHAmR4HZbHCnPBI8yoWIEQvKj64skJnUeRq/2ZtYpZUK8H5/v3dXD618UqFdIb/3lLpkrmzQ8wGXuf5RaVX2hwNhEnJFjvPbrqA1v5Ug2C86ugcJwotNxVL6m3SVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiqPuw5M; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4581d15c3e3so42257051cf.0;
        Mon, 07 Oct 2024 07:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728311972; x=1728916772; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L2NUlWjL9y/WZi8efC7Jo1TiWi8UslGryubu+8tPTWY=;
        b=hiqPuw5MgWUJVjdeEZHC/76/CPpD63MZZy50y6gsrji+r+1QJZKNTJTvFZhv2LEvD/
         OgHOA/mP3W/fnQLLgIXNHYSKDWWH8yO9XyrcWnLBHvNUcSkxFhMVGjtRzo2OqD02rr9+
         G7EpyMzpkzy79jTCZeu49/bFaivEtZ7lZ2AdgxbfOPO/rmLD45IKcAmFgJ4fsojbUbNP
         /MbrHLgJGBUjmJtyjE9yxDPKSWRYjIHkIyp8P6+Oj2TiXUUH/4Y1DTai0kD2BpIONbx8
         OHAo4ucGTNP8lTpYGUjf8qIysGJMWCRBIgIVYKAvcFW6wbD9S+i5FaUjODWRefKCySso
         aOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311972; x=1728916772;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2NUlWjL9y/WZi8efC7Jo1TiWi8UslGryubu+8tPTWY=;
        b=oRSK168AGw4ppYQJF13lysVJQVV2mFgjSBJikPMLS2dYJAI9vfXJPhcJAqhEM8GHpD
         Vc3bHLqw1/OGca8dh+BPqecNKwqfbiT+L+uOizJodn/l8V3KN98WFedr473yrDYivIeM
         TTRM0Eccot0fOZThgaWadJ5iak8NINBRHXpdXzD9qb9e+zMwLV9nymCYkfXfdrZk5Arb
         hPnrIr8a6TNGPiT6nXtZlruEneX/KM7lWkv0SUmxU0kn08oNdlusNF1yWV60ie2uoH0X
         ZveTEhj1KhDll2Th4VueKe1SPC32m2IiAn+GaCUOC+4s5fuGxQsj/XRCSNs7QeZl/0lz
         8CKg==
X-Forwarded-Encrypted: i=1; AJvYcCUqwIIt5L0kLpufMe3ix8RVgyfKwXdB+qSOQP66jhthS6mHjeskYuAw2Q+Czxw5eklN4lEL+u9EQYnXKiLP2YA=@vger.kernel.org, AJvYcCV04bHfuGeX2HAh1aDhA6hRufI5gandQCucsK67taGPSylj3UleaBMMmCPAEbW62l6AINUYT/QOQt3KF1Q=@vger.kernel.org, AJvYcCXVq1qP13vwZmrX97Gk6JxKv3JTi27wWUqsyLDt+YYrsWvvnALGkgA7X4YyBwtEMH1PDL4NqQTv@vger.kernel.org
X-Gm-Message-State: AOJu0YyIgqi2OrIU/4b6sItb0TOPSsTevEh3epyE3HCUc7z/H2tJn1Z2
	N7/LjOUpuVfKdDNSRUzc+Oqw7n3fWE5BpVe4MF/jO85CTARfUYXP
X-Google-Smtp-Source: AGHT+IEvnrBmO0gL56giaA4K7aDMcaigRPYt1ZcAc0Hv3Vnvd3pPB0800aGBBfyYeAUJOEzcIEdWGw==
X-Received: by 2002:ac8:7f0a:0:b0:45b:f451:ad25 with SMTP id d75a77b69052e-45d9baed4cemr183013091cf.48.1728311972264;
        Mon, 07 Oct 2024 07:39:32 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45daea175e4sm20348911cf.3.2024.10.07.07.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:39:31 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5AE67120006B;
	Mon,  7 Oct 2024 10:39:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 07 Oct 2024 10:39:31 -0400
X-ME-Sender: <xms:o_IDZ8co8cyq1p4oAuno9zIobACwlbI48IN3xuv3Hu_Db0yRmggwqQ>
    <xme:o_IDZ-NCu14s5_mPIIcp5gmgKVy4NIA9TlMLPYG2VUQUWlpXBYweNPvUxK_11CzJb
    UitzJ0PBDXcSOg52w>
X-ME-Received: <xmr:o_IDZ9jEdw7ZtfTqgk0GTGCoWL9Eoy-_9EE13jWhLh7--RsbM0yTfjaQEFeUAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfh
    gfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepfhhu
    jhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtug
    gvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdq
    lhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhkhgrlhhlfi
    gvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghh
    rdgvughupdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:o_IDZx9M3M947n7V3dVE3XeXcT6IMqO0bjDc94WqJUT_dIdCgRYLaA>
    <xmx:o_IDZ4sHCLg3eEifRmmEwwhMJMJqbBILgptOIiA2hihF7n2OnOYQ0w>
    <xmx:o_IDZ4G0PJFemnTl7Htsj0SWs6sgZ-UtRfcqaHPzTTCIUGNyjpVKCA>
    <xmx:o_IDZ3NSjhgyo8_Hf05GEEWJMQKE5KOIA7q2k1H7TAq-P4qByxp4zg>
    <xmx:o_IDZ9M5YReu2yf4KoJ3z6nwp-4myZqeexyFEAlt5qm77mPS6hV2kBbx>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 10:39:30 -0400 (EDT)
Date: Mon, 7 Oct 2024 07:38:12 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <ZwPyVHH2UbVeJBs5@boqun-archlinux>
References: <20241005122531.20298-6-fujita.tomonori@gmail.com>
 <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux>
 <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux>
 <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
 <ZwPsdvzxQVsD7wHm@boqun-archlinux>
 <CAH5fLgigW6STtMBxBRTvTtGqPkSSk+EjjphpHXAwXDuCDDfVRw@mail.gmail.com>
 <ZwPuDE16YBS4PKkx@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwPuDE16YBS4PKkx@boqun-archlinux>

On Mon, Oct 07, 2024 at 07:19:56AM -0700, Boqun Feng wrote:
> On Mon, Oct 07, 2024 at 04:16:46PM +0200, Alice Ryhl wrote:
> > On Mon, Oct 7, 2024 at 4:14 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > On Mon, Oct 07, 2024 at 04:08:48PM +0200, Alice Ryhl wrote:
> > > > On Mon, Oct 7, 2024 at 3:48 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > > >
> > > > > On Mon, Oct 07, 2024 at 05:28:28AM -0700, Boqun Feng wrote:
> > > > > > On Sun, Oct 06, 2024 at 04:45:21PM +0200, Andrew Lunn wrote:
> > > > > > However, this is actually a special case: currently we want to use klint
> > > > > > [1] to detect all context mis-matches at compile time. So the above rule
> > > > > > extends for kernel: any type-checked *and klint-checked* code that only
> > > > > > calls safe Rust functions cannot be unsafe. I.e. we add additional
> > > > > > compile time checking for unsafe code. So if might_sleep() has the
> > > > > > proper klint annotation, and we actually enable klint for kernel code,
> > > > > > then we can make it safe (along with preemption disable functions being
> > > > > > safe).
> > > > > >
> > > > > > > where you use a sleeping function in atomic context. Depending on why
> > > > > > > you are in atomic context, it might appear to work, until it does not
> > > > > > > actually work, and bad things happen. So it is not might_sleep() which
> > > > > > > is unsafe, it is the Rust code calling it.
> > > > > >
> > > > > > The whole point of unsafe functions is that calling it may result into
> > > > > > unsafe code, so that's why all extern "C" functions are unsafe, so are
> > > > > > might_sleep() (without klint in the picture).
> > > > >
> > > > > There is a psychological part to this. might_sleep() is a good debug
> > > > > tool, which costs very little in normal builds, but finds logic bugs
> > > > > when enabled in debug builds. What we don't want is Rust developers
> > > > > not scattering it though their code because it adds unsafe code, and
> > > > > the aim is not to have any unsafe code.
> > > >
> > > > We can add a safe wrapper for it:
> > > >
> > > > pub fn might_sleep() {
> > > >     // SAFETY: Always safe to call.
> > > >     unsafe { bindings::might_sleep() };
> > >
> > > It's not always safe to call, because might_sleep() has a
> > > might_resched() and in preempt=voluntary kernel, that's a
> > > cond_resched(), which may eventually call __schedule() and report a
> > > quiescent state of RCU. This could means an unexpected early grace
> > > period, and that means a potential use-afer-free.
> > 
> > Atomicity violations are intended to be caught by klint. If you want
> 
> Yes, I already mentioned this to Andrew previously.
> 
> > to change that decision, you'll have to add unsafe to all functions
> > that sleep including Mutex::lock, CondVar::wait, and many others.
> 
> No, I'm not trying to change that decision, just to make it clear that
> we can mark might_sleep() as safe because of the decision, not because
> it's really safe even without klint...
> 

Anyway, I think Tomo needs to call __might_sleep() instead of
might_sleep(), and __might_sleep() seems a pure debug function (not
involved with schedule at all). So the wrapper of __might_sleep() can be
perfectly safe.

Regards,
Boqun

> Regards,
> Boqun
> 
> > 
> > Alice

