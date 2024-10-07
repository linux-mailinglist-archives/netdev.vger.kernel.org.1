Return-Path: <netdev+bounces-132739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F020992EE9
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A2A28396D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773E11D54DC;
	Mon,  7 Oct 2024 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO37LcoC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD671D2F4B;
	Mon,  7 Oct 2024 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310878; cv=none; b=J0sCf9rDFKnXpjY0YslNMEKFhcFelmPVzwXN+SKhxr11JlC1hj/axTN+y+oOBhfdKR/bDbghfifzInhuXqTbNIMOkqMnuXDVWPHUmg9kPKfNrIHkepgWkSWpHcRUz7FNwFwczNHADxt4LUXvAZNpGwh64/FTf4zrl3xgSEK1Aoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310878; c=relaxed/simple;
	bh=wXq6DEfl+otX2OUYDSxRKZTFFqZwgJsq20ZiWsYFZ3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFnhLJwR9hk6v1Z3M4PJ3DfEP5cMSQ/DwYd603vhFrIP48gfB2J+Vtp8/4Pi+qgMf191WqYUk7lNULQy7M1kl+Vrinbr3tn+DrWfKJgmsjl/Q3CzZE+PJnUqnXs1TgpbSaRDzlEQDegCjxvwi5APmn8X+9A+Y8CQNATe8kWWT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO37LcoC; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb2ad51162so41084316d6.3;
        Mon, 07 Oct 2024 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310876; x=1728915676; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zAK4XymC3L6i3k241V0wt6B7pOPxNyzbjvvZCbkfkKY=;
        b=GO37LcoCamNNtpCcRc2RdmBeOhZWAZNtM8+BDRfp9fSYZceaDQrhdmWxWQfTiuDxej
         cS+zUgk4NYr81vFtV0Ian+MnfZqtbuSvHIg60x0QPRq3zwS3inPtOOW6lQte6r2whnwO
         sKCjWD48HFvsWIk146qSJj1h/XHjUKExZ/B55533ZHNe0B3u4ajtqNIMQ9yQiX7YOl4G
         LoFQ3hnk6RrJ7RLz9ox1mEv3wlFOjAj1KrdBUrHgh3FZKNhj6Ka8D8lcyXdFJ6+ASeIz
         KP5JuIpr93tj/04bYZPRCyDZLm1J3u/vh+R8dV3OabpEr5yviFAuTKTS4O04U1ziMPIx
         o9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310876; x=1728915676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAK4XymC3L6i3k241V0wt6B7pOPxNyzbjvvZCbkfkKY=;
        b=im1XW9pVSn70Jkl1jQjFOBuEEBt2kzTbjKsEPI/fq1trN2GxvurF9UKPpvabTAGk3V
         N2ca1QCb2aPOI9f0zCHqDKmnYS2agurBqVgg7oJLaxMcTENJnM7bz9Xc4I+54ve7xNd4
         DN+PX3Ix+yMLDW91zamou94dp4upMFiAyyI0+ydN4Nd8gVTlnowq/nvMRhb4CYj9GHqS
         ZdPBwROQCxENudluVWV4sqUIn0MXIxdlRNVi+m2ROAgThm2Xa8+sIuJPUqVnxgonZzq3
         3dXiMDoU4z+3VhFGgk5vZMsmt8WKXwD3QeTWx9GOl8k2sE6HOGB7Nhil2sqwPqe3rBjV
         r+kg==
X-Forwarded-Encrypted: i=1; AJvYcCUVLgVXKheFjG0taI5DEOO7jBkck/9xmtifxZ8ZXAGdlyNhtoGDsxk9IRYaG+0o7P0q6KWj8uiI2NpVSaruGGk=@vger.kernel.org, AJvYcCVw80w4WUK+3BCLus5e0ubpyWiIASdzndq4qBrOX1D4OUt8zBUhw6ZlXyA/ap/Xettb29/3n0IQBA7BZyo=@vger.kernel.org, AJvYcCXGc4vnzuQRd+WYw84bN+/Jjx/itrXOOSLtVdeR2yFDYp7pFnbt3xE8ikadmU0RyueEGlD/HnRW@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLkKUyZd1DfgOe+whK964ubi9jVP2AtvgybZLFEIl9VajIANV
	q4pxEM+Lq4pNd+c36pjOyJGHsfzXzcZUE+nAR2DVnoAuFpBnTASs
X-Google-Smtp-Source: AGHT+IGRJoduihx98XE39c8bw2PlpbXpydpc9CbQWwkox+aktEDVzndR66sqj0UTcswncSC6H7Za4g==
X-Received: by 2002:a05:6214:4993:b0:6c3:5e7c:8613 with SMTP id 6a1803df08f44-6cb9a2f586amr205645026d6.16.1728310875729;
        Mon, 07 Oct 2024 07:21:15 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46cebccsm25706456d6.21.2024.10.07.07.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:21:15 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id E4814120006E;
	Mon,  7 Oct 2024 10:21:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 07 Oct 2024 10:21:14 -0400
X-ME-Sender: <xms:Wu4DZ8ya6MHD3a5kScy-k4euejkfWV2i_cUaQB9GnRQhkEZgiZ5Uwg>
    <xme:Wu4DZwRNI286qyLwDS5ZdKRxUoP3Ss__cP6yiNSdNqokfuLjto_15MQ7gLrO1hXkK
    RW9FF7xPKud0JlQBA>
X-ME-Received: <xmr:Wu4DZ-W6SXjIIHoOUFDhQIR_qT7CsRGhW11uNO-fQayKUbWrNYd998h9A6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgjeeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:Wu4DZ6i9TZs7C-fP7GPW4CDfrG7K0k7J8B6CYgYVaz-w8QHdSld8Xg>
    <xmx:Wu4DZ-B0orvb_WiSEOTCaubwqoulMwpD_nAsMsVbBZdnwz9Aw94Gmw>
    <xmx:Wu4DZ7Kfk1gtRUdNhd8pTcshofhvD577R4tN3czBiqZipA1n7KRJhQ>
    <xmx:Wu4DZ1B8Cl9moU7ckKOg6Leofrb1ImodvGMxyFFr62r3ghFEKmMxtg>
    <xmx:Wu4DZ-yal-UwvjnqKHhQtEsTZL3Jb-mUCNozW5uCh3sW7IPEUfIIpWgl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 10:21:14 -0400 (EDT)
Date: Mon, 7 Oct 2024 07:19:56 -0700
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
Message-ID: <ZwPuDE16YBS4PKkx@boqun-archlinux>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-6-fujita.tomonori@gmail.com>
 <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux>
 <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux>
 <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
 <ZwPsdvzxQVsD7wHm@boqun-archlinux>
 <CAH5fLgigW6STtMBxBRTvTtGqPkSSk+EjjphpHXAwXDuCDDfVRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgigW6STtMBxBRTvTtGqPkSSk+EjjphpHXAwXDuCDDfVRw@mail.gmail.com>

On Mon, Oct 07, 2024 at 04:16:46PM +0200, Alice Ryhl wrote:
> On Mon, Oct 7, 2024 at 4:14 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Oct 07, 2024 at 04:08:48PM +0200, Alice Ryhl wrote:
> > > On Mon, Oct 7, 2024 at 3:48 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > >
> > > > On Mon, Oct 07, 2024 at 05:28:28AM -0700, Boqun Feng wrote:
> > > > > On Sun, Oct 06, 2024 at 04:45:21PM +0200, Andrew Lunn wrote:
> > > > > However, this is actually a special case: currently we want to use klint
> > > > > [1] to detect all context mis-matches at compile time. So the above rule
> > > > > extends for kernel: any type-checked *and klint-checked* code that only
> > > > > calls safe Rust functions cannot be unsafe. I.e. we add additional
> > > > > compile time checking for unsafe code. So if might_sleep() has the
> > > > > proper klint annotation, and we actually enable klint for kernel code,
> > > > > then we can make it safe (along with preemption disable functions being
> > > > > safe).
> > > > >
> > > > > > where you use a sleeping function in atomic context. Depending on why
> > > > > > you are in atomic context, it might appear to work, until it does not
> > > > > > actually work, and bad things happen. So it is not might_sleep() which
> > > > > > is unsafe, it is the Rust code calling it.
> > > > >
> > > > > The whole point of unsafe functions is that calling it may result into
> > > > > unsafe code, so that's why all extern "C" functions are unsafe, so are
> > > > > might_sleep() (without klint in the picture).
> > > >
> > > > There is a psychological part to this. might_sleep() is a good debug
> > > > tool, which costs very little in normal builds, but finds logic bugs
> > > > when enabled in debug builds. What we don't want is Rust developers
> > > > not scattering it though their code because it adds unsafe code, and
> > > > the aim is not to have any unsafe code.
> > >
> > > We can add a safe wrapper for it:
> > >
> > > pub fn might_sleep() {
> > >     // SAFETY: Always safe to call.
> > >     unsafe { bindings::might_sleep() };
> >
> > It's not always safe to call, because might_sleep() has a
> > might_resched() and in preempt=voluntary kernel, that's a
> > cond_resched(), which may eventually call __schedule() and report a
> > quiescent state of RCU. This could means an unexpected early grace
> > period, and that means a potential use-afer-free.
> 
> Atomicity violations are intended to be caught by klint. If you want

Yes, I already mentioned this to Andrew previously.

> to change that decision, you'll have to add unsafe to all functions
> that sleep including Mutex::lock, CondVar::wait, and many others.

No, I'm not trying to change that decision, just to make it clear that
we can mark might_sleep() as safe because of the decision, not because
it's really safe even without klint...

Regards,
Boqun

> 
> Alice

