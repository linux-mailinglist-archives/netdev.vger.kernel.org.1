Return-Path: <netdev+bounces-133104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0757C994C0F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1071F2435E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8C91DE4CD;
	Tue,  8 Oct 2024 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez9uRhVz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED901D54D1;
	Tue,  8 Oct 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391801; cv=none; b=eBXo+3bWNyELxv9kGQUfn0V2bV6/2g1XfFsExjSo9XwGlFEBtWWFtu8/rS2M7/bE7St7BheAJ+VOKxH9sAQS+XUbscoxIYG4+atF/6QAastaFP56dVT0ZQEGH9QM/+pTAfNp7643nydNtg4YeOZQeqGDvOIuybpzhknUQ77DYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391801; c=relaxed/simple;
	bh=7uitOnMWc0zBWsicuLDSVHvJIWH/59RgVHi9L15FheM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StsqPg2ffqXH+hXPHQGd5jR0DWqAN9AtYj1mCaPA/nczW2pZ3bKALGXmMwjG1vzjjpRSl0oRcd/gdCdplMPbzABeb+ciE1buoFvMepyd4MdTFTSWaCzNrwoVDpvp2MmYh8hlV2KfmF9wH8KgvKK5RKoU4C14QU+Ym+EpKMIxwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez9uRhVz; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4584a719ff5so48078901cf.0;
        Tue, 08 Oct 2024 05:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728391799; x=1728996599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AVqUL39JBlPDkoFAhxbXBFaFnwRA+fM++dHdsEdtYs=;
        b=Ez9uRhVzzhhn73yUd3XbRlPKyPoqpo++icK4GW5jI1Gu6di3DoXpT1b7WZJVrAOAIG
         u1sN/Z6X5iej2obyZXPfVYUquB264gS0zX/teJasyhTmLDepJl66YX8RzSnNCKWCwnlr
         qFYYmkr6RbRAFf5OMJ/Q1ufL7uyJMTNS/5981dK2kiXfC70D3Li8QuQKN6DHJY2t6ZdU
         Qmg9y9KJsk6pj7IGX1LQvN87+dXNAxSpiB+2GL0UeVtl6/N6F3T0YHEJBvyXNbswgYd+
         Qt3WncIln7X0T0ScTfoxIRQxkl9WWbP2ZNXnJRB80UcKTRGRiTxr0hlOepdvA4QD3x21
         ofbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728391799; x=1728996599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AVqUL39JBlPDkoFAhxbXBFaFnwRA+fM++dHdsEdtYs=;
        b=aIWjaWOR1Ks8x6mONq8ea1hvcSHCAbP5sQ+GcTI2N/CTPjcsWlWuSMatU82rev0o5+
         L6+UjddxCjjDsXfTXKFLBZwzSRFAZY72IoDZX3qLpOkcy1g+FU3X3EEbN1Ket6KgkR6n
         JuEliKTFVgY3Acs1fgdc4jocXXm58aFjocgYZs7wXjjZ2WKsgoBG+RCDXHXyhhc8kp8O
         sYSyWhaA+PQb9ASzcIqgeIgrfxnwS9GDZXXlSj/dqpa+bvZIBkGCXjfduFpAshP2HlYg
         OdsNi+Nwx7MoN2dKBiCv06ZPFRtFm/vvZp+o6qlM8y+MYQSVtsuEWc2CeuD2oqXLYsox
         Rb6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHYA+VT25xHYcnuEIJzmF2hA15Goo3B6QRn9gtW5yhyyb6EAA+MxeVYaTtrN/8i8FDF9scAe7VjOIGaLBucDQ=@vger.kernel.org, AJvYcCW4FBOw4s066sOA3Krnd6WOtwk3pFA9AV8OFQ5nMjGtM8jgwaZimT37BlaZ+HiWbFIpBqXFvgcfhTDxArs=@vger.kernel.org, AJvYcCXC4SV+tRf9sxcpNszl5b73bB3URqKVVJuOkhKc1vXOSp6fvKsTx8x79AXYJqcZPUpzBps3VskH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfqu0Kr+KwWZCCVz1SseSHgohmT5+Oe/etkfCcQ0q1QBGl9ZXs
	9PtNirAcGkxSGp4mQ22S2UST/W4V91N6y0nBNvVT+gk5kTMUvC2f
X-Google-Smtp-Source: AGHT+IHt0EHnMv9mbkUi2LlMsRHySKd/GHz1C100sVO3xdEvY728kYl+eVWlbuWZQNtjB3PscEO6hQ==
X-Received: by 2002:a05:622a:315:b0:458:5419:4474 with SMTP id d75a77b69052e-45d9ba44c1cmr267525621cf.16.1728391798999;
        Tue, 08 Oct 2024 05:49:58 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45f04e2cc7bsm3051531cf.49.2024.10.08.05.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:49:58 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 03B82120006C;
	Tue,  8 Oct 2024 08:49:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 08 Oct 2024 08:49:58 -0400
X-ME-Sender: <xms:dSoFZ8VYOSGpfd6P3AQGi3lnx5V1xqJ04E98edeL5DqXaXyIYYh8yw>
    <xme:dSoFZwnmvZ7XUSGwyGwgdi0U8FertnDkyKeFFCnmo8L0ASKCxqezCFfaXxMOdSb9X
    pxCpJqP_57qC3cNgQ>
X-ME-Received: <xmr:dSoFZwZgMwl44yHPbndFuce8Jfb83BHDewCKs8fUF_pnQ1c2Yy5LJJDCPtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpedvgeejhefhgeekjeeguefgvdegheeufeevleev
    feefvddufffhfeehfeduueejheenucffohhmrghinhepfihikhhiphgvughirgdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrlhhitggvrhihhhhl
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopehojh
    gvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:dSoFZ7WykBEHXMPSp2wNnQCxjdawz0OiUsa9eNrzwvgYSSUTGpaieA>
    <xmx:dSoFZ2l5Smy0EZtsYhDV_aZUA0Ntg2TIdiKoyShHZPJrKOkiN2KVSQ>
    <xmx:dSoFZwekfIAu7xUSa1wwKmfNTM4xY63Irll26P_-KnE4lw6x39r3zw>
    <xmx:dSoFZ4GygWvZW2q1RXN26IFoO8NlYqiDifYJ9Eg1atRyu-O_EZ6GgQ>
    <xmx:dSoFZ8mzNcLq0L-V6ch2Sx3nijL2YLLlhkQz5a_RQNxcPseaRgh8fxwJ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 08:49:57 -0400 (EDT)
Date: Tue, 8 Oct 2024 05:48:36 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <ZwUqJIatd97ArcV_@boqun-archlinux>
References: <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux>
 <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux>
 <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
 <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
 <ZwPsdvzxQVsD7wHm@boqun-archlinux>
 <5368483b-679a-4283-8ce2-f30064d07cad@lunn.ch>
 <ZwRq7PzAPzCAIBVv@boqun-archlinux>
 <c3955011-e131-45c9-bf74-da944e336842@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3955011-e131-45c9-bf74-da944e336842@lunn.ch>

On Tue, Oct 08, 2024 at 02:12:51PM +0200, Andrew Lunn wrote:
> > Because of the might_resched() in might_sleep(), it will report the
> > quiescent state of the current CPU, and RCU will pass a grace period if
> > all CPUs have passed a quiescent state. So for example if someone writes
> > the following:
> > 
> >     <reader>			<updater>
> >     rcu_read_lock();
> >     p = rcu_dereference(gp);
> >     might_sleep():
> >       might_resched():
> > 				todo = gp;
> > 				rcu_assign_pointer(gp, NULL);
> > 				synchronize_rcu();
> > 
> >         rcu_all_qs(); // report a quiescent state inside RCU read-side
> > 	              // critical section, which may make a grace period
> > 		      // pass even there is an active RCU reader
> > 
> > 				kfree(todo);
> > 
> 
> You are obviously missing something here. The call that actually sleeps
> 
>       mutex_lock(&lock)
> 
> >     a = READ_ONCE(p->a); // UAF
> >     rcu_read_unlock();
> 
> A might_sleep() should be paired with something which does actually
> sleep, under some condition.  At least, that is how it is used in C.

How do you guarantee the "should" part? How can a compiler detect a
might_sleep() that doesn't have a paired "something which does actually
sleep"? I feel like we are just talking through each other, what I was
trying to say is might_sleep() is unsafe because the rule of Rust safe
code (if we don't consider klint) and I'm using an example here to
explain why. And when we are talking about the safe/unsafe attribute of
a function, we cannot use the reasoning "this function should be always
used with another function".

> The iopoll being re-implemented here is an example of that.
> 
> So take the might_sleep out above, just leaving the mutex_lock. If the
> mutex is uncontested, the code does not sleep and everything is O.K?
> If it needs to wait for the mutex, it triggers a UAF.
> 
> The might_sleep() will also trigger a stack trace, if its is enabled,
> because you are not allowed to sleep inside rcu_read_lock(), it is an
> example of atomic context.

These functionalities you mentioned above are also provided by
__might_sleep(), no?

> 
> As far as i see, might_sleep() will cause UAF where there is going to
> be a UAF anyway. If you are using it correctly, it does not cause UAF.
> 

Again, I agree with your assumption that might_sleep() will always be
paired with a sleep function, but we cannot mark might_sleep() as safe
because of that. We can, however, mark might_sleep() as safe because
klint is supposed to cover the detection of atomic context violations.
But we have a better option: __might_sleep().

> > We probably call the reader side code a "wrong annotation", however,
> > it's still unsafe code because of the UAF. Also you seems to assume that
> > might_sleep() is always attached to a sleepable function, which is not
> > an invalid assumption, but we couldn't use it for reasoning the
> > safe/unsafe property of Rust functions unless we can encode this in the
> > type system.
> 
> How are any of the sleeping call encoded in the type system? I assume

There's no easy way, something might work is introducing effect system
[1] into Rust, but that's very complicated and may take years. When
there's no easy way to encode something in the type system, it's usually
the time that unsafe comes to happen, an unsafe function can have a
requirement that cannot be easily detected by compilers, and via unsafe
block and safety comments, programmers provide the reasons why these
requirements are fulfilled.

> any use of a mutex lock, sleep, wait for completion, etc are not all
> marked as unsafe? There is some sort of wrapper around them? Why not

They are marked as safe because of the klint extension of safe Rust rule
I mentioned.

> just extend that wrapper to might_sleep().
> 
> > For Rust code, without klint rule, might_sleep() needs to
> > be unsafe. So we have two options for might_sleep().
> > 
> > * Since we rely on klint for atomic context detection, we can mark the
> >   trivial wrapper (as what Alice presented in the other email) as safe,
> >   but we need to begin to add klint annotation for that function, unless
> >   Gary finds a smart way to auto-annotate functions.
> 
> Are there klint annotations for all sleeping functions?
> 

Not yet, klint is still WIP. But we generally agree that atomic context
violations should be detected by klint (instead of making sleep
functions unsafe or using type system to encode sleep functions).

> > * Instead of might_sleep(), we provide the wrapper of __might_sleep(),
> >   since it doesn't have might_resched() in it, it should be safe. And
> >   all we care about here is the debugging rather than voluntary context
> >   switch. (Besides I think preempt=volunatry is eventually going to be
> >   gone because of PREEMPT_AUTO [1], if that happens I think the
> >   might_resched() might be dropped entirely).
> 
> __might_sleep() might be safe, but your code is still broken and going
> to UAF at some point. Don't you want that UAF to happen more reliably
> and faster so you can find the issue? That would be the advantage of
> might_sleep() over __might_sleep().
> 

Could you give me an example that might_sleep() can detect a bug while
__might_sleep() cannot? IIUC, __might_sleep() is the core of atomic
context detection in might_sleep(), so when CONFIG_DEBUG_ATOMIC_SLEEP=y,
__might_sleep() should detect all bugs that might_sleep() would detect.
Or you are talking about detecting even when
CONFIG_DEBUG_ATOMIC_SLEEP=n?

[1]: https://en.wikipedia.org/wiki/Effect_system

Regards,
Boqun

> 	Andrew

