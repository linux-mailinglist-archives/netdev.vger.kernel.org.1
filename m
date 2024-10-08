Return-Path: <netdev+bounces-133315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41452995976
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98076B22256
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F4D206962;
	Tue,  8 Oct 2024 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHJBA7lP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E614A82;
	Tue,  8 Oct 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424522; cv=none; b=RPXuK5mBgnJP6QwKJfyP8vYuLS4KT5avjDTksCsl6cjzuCCDCd8SYQ2XW1A41VQ8BvawHaOadRzLPIsRPFYX/kZAijwPgUIuxITizPaCC9tTsiVL2RlisQMTNiAqyoIdnBEFJDbtZVKyp1c4QY+YN6+ItyxY20dRa/isb2emtGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424522; c=relaxed/simple;
	bh=W+9IY9LvQ2FdsLivElEZAxYzLCEMLOTPRTTp4h8pVUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/X58rYN/aqg9mUjnsYhJXDZ+zwDgPhVn5/8sitU/TydUsZl1nf3nDfsw4aX+mrL+FZJHS0nmfcZulh2lV2Y+dag+wCKe6OEFLY3WlW5hAHWSVu/3kEksR1vFBK/GBtE5wrhfGpbuK66OzZ50CEc9jNJvvdWXOmEt1O+clJ52Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHJBA7lP; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbc40d9fa0so6988426d6.3;
        Tue, 08 Oct 2024 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728424520; x=1729029320; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dEkYiKryFotjPtytS297RDOyprMAcbzHxWXUdSzZWQM=;
        b=KHJBA7lPsfOQg3J9R7H3weFlUnhn3QuicN+w222bIzRXX5bGWgLbSRUeX1GszBYzYV
         HX/V0E0T+sfTIZlq416yDRmaqiJvf38oTFfYOuxgGJ8xRLks/tGb6qt/dDbzmO1Xb6xa
         B6X3ohHULYYFEH5Z+iU4bWlmXQ5blY2g17dDdcNb7AMm0c91y9R4EWu2MyE9EBY6uY28
         ozS/dF0x2ErTQ31lV94MFXKUwY6xvHxH/20ungWK/vBLQ0HSmUUTSqTV1dqGy5UoY+yE
         4bdJzaxzhVGPtfxyetnB6qRk3jm/bI0Wgz3IJiuoi8PAptoyYkm66PuyvDwIdoWl0vq4
         wZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728424520; x=1729029320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEkYiKryFotjPtytS297RDOyprMAcbzHxWXUdSzZWQM=;
        b=GxQueqOVkohBSwC7dAlBQrHdygC+0wsl3ZvQHKPWfKaqFsmRDgx5lGGzr0L+MSK5B4
         3RTQIYJfYcISABDlvC7R4LfQTs6KevpOz1XlO76x3VueSzEgv1r9VRNLtLNy1+4+SVbG
         gTvW+kanV9VrL7vMRMvT1hCc4FGMG6JNBRbShgSwaLRVANuEUO2Fz1q9swFPh+Qfrnis
         LBYfxtmmtUQZ7MOZXNU3FzXB+3OWuFVZGjbEBGoFKpSSvmrtKEKpLSmcCy5KLkwTgXN5
         f1nLP+LUgmY0TK4vbn36y3UnmIdJZt58NMCn9L6+M7qlj9sHLXSGpv5Fib6VIMAtCFH2
         A0sw==
X-Forwarded-Encrypted: i=1; AJvYcCVwmmdMNDHahS3lvZuLautOIm3oiMiJx4YsQI7tEHYrQf/t4bPbLR9setXnSWMOY25C4yUAaNA8LAc88qg=@vger.kernel.org, AJvYcCX5cE/ffX7JmX0TNOaujY3faIjgJXcAo1wUB1hQPE/x5Ia3FU20nKOqKzZQo/N2MIR4VMgUGu2V/PPkV3aLgGE=@vger.kernel.org, AJvYcCX9ih26PFQLQSd1Pd6B2rdUlZRkLkmaqgtkN7topJk8JpJpfk26L7o+KucAhGpu5xLeRK+XrKUE@vger.kernel.org
X-Gm-Message-State: AOJu0YwjAEkYzHLXbUlZGjpd8xcWGJ11vEaNtJHazGiNgAvNRc9OU50n
	B29WPqvQI5KUposgw9M6r2NbHNafiFcUMGJn5kLbXedw5Uyui7wVOLRvSA==
X-Google-Smtp-Source: AGHT+IEF/NkQAgcCJkU2mKbr8QRToXoHjVTdnjcIoApyIGZnBhAJmpONJ+nMP7+hi14bodf+sSJ7ow==
X-Received: by 2002:a05:6214:3bc6:b0:6cb:c6d2:3567 with SMTP id 6a1803df08f44-6cbc942ef1bmr7188786d6.3.1728424520104;
        Tue, 08 Oct 2024 14:55:20 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46cd0f4sm39395566d6.8.2024.10.08.14.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 14:55:19 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BE60B1200086;
	Tue,  8 Oct 2024 17:55:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 08 Oct 2024 17:55:18 -0400
X-ME-Sender: <xms:RqoFZ4wam08Rr0GML4Hev5lh_UDbnxMvyPcMq1hZSJiTkTD-74gqTg>
    <xme:RqoFZ8Qx6mdOEq0w76zQ0_R9bAtVgcyXPb3OcIFZ02hcmzjwkV5KeCRHLooROmYYy
    FjJQyCrVvQwfahyuA>
X-ME-Received: <xmr:RqoFZ6WgfXfSmhz0P4eNxiktUJTq5xqj9WgvWinfCq6kRVGAV7T3Y86hg9sEYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddgtdegucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:RqoFZ2gQ0TEEkQUBMgfp9ZwzSbUFanO2ci19QSNJTuCvtDFAXKyXRg>
    <xmx:RqoFZ6Aw5ZZA-6RHmo8Yw8imcA2M5zfcQdin6oTajsrw06Y8nlVTXw>
    <xmx:RqoFZ3IQrD3rQRD0dpXzoEQlx7oiv33RNN9oBSCQj8xWAHq2fuFo9g>
    <xmx:RqoFZxD-vlARtrv5WkI-4F3Y6672emLUjJ4JDX889iD4Rc51iTDJPg>
    <xmx:RqoFZ6xZBRlR2jbGmyyzuJFRzBzy2t416UB_uQxST-x98KMKTcK65_m_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 17:55:18 -0400 (EDT)
Date: Tue, 8 Oct 2024 14:53:56 -0700
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
Message-ID: <ZwWp9C2X_QIrTJEq@boqun-archlinux>
References: <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux>
 <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
 <ZwPsdvzxQVsD7wHm@boqun-archlinux>
 <5368483b-679a-4283-8ce2-f30064d07cad@lunn.ch>
 <ZwRq7PzAPzCAIBVv@boqun-archlinux>
 <c3955011-e131-45c9-bf74-da944e336842@lunn.ch>
 <CANiq72m3WFj9Eb2iRUM3mLFibWW+cupAoNQt+cqtNa4O9=jq7Q@mail.gmail.com>
 <df2c9ea8-fa3a-416e-affd-b3891b2ab3f7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df2c9ea8-fa3a-416e-affd-b3891b2ab3f7@lunn.ch>

On Tue, Oct 08, 2024 at 07:16:42PM +0200, Andrew Lunn wrote:
> On Tue, Oct 08, 2024 at 03:14:05PM +0200, Miguel Ojeda wrote:
> > On Tue, Oct 8, 2024 at 2:13 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > As far as i see, might_sleep() will cause UAF where there is going to
> > > be a UAF anyway. If you are using it correctly, it does not cause UAF.
> > 
> > This already implies that it is an unsafe function (in general, i.e.
> > modulo klint, or a way to force the user to have to write `unsafe`
> > somewhere else, or what I call ASHes -- "acknowledged soundness
> > holes").
> > 
> > If we consider as safe functions that, if used correctly, do not cause
> > UB, then all functions would be safe.
> 
> From what i hear, klint is still WIP. So we have to accept there will
> be bad code out there, which will UAF. We want to find such bad code,

If you don't believe in klint, then we need to mark might_sleep() as
unsafe, as I already explain a million times, might_sleep() is unsafe
without the klint compile time check. You have to accept that an unsafe
function should really be marked as unsafe. And yes, in this way, all
sleep functions would be marked as unsafe as well (or we could mark all
preemption disable function as unsafe), but still an unsafe function is
unsafe.

Again, as Miguel mentioned, we can only mark might_sleep() because sleep
in atomic context is an ASH, not because it's really safe.

> and the easiest way to find it at the moment is to make it UAF as
> fast as possible. might_sleep() does that, __might_sleep() does not,
> and using neither is the slowest way.
> 

might_sleep() is useful because it checks preemption count and task
state, which is provided by __might_sleep() as well. I don't think
causing UAF helps we detect atomic context violation faster than what
__might_sleep() already have. Again, could you provide an example that
help me understand your reasoning here?

Regards,
Boqun

> 	Andrew

