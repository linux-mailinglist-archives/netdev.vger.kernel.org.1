Return-Path: <netdev+bounces-132721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02803992E51
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A07280F3F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00C61D45FE;
	Mon,  7 Oct 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1vQxPZd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB61C2DAE;
	Mon,  7 Oct 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310068; cv=none; b=jEdD2WzuWoxag724OTomeU2PHtJUiXRveUr1dxD4H7uptd8CGXjaGybGJiDcDwlxYfSccyqTYQmxpbSu6NR70We/qwysjpK2J16A8bviD9AvMZcBlFpiqt9N/LByQUdVefSqUnnXxY7jU7lnBLOAsSOqK9f7kDxrb88rIXWKXFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310068; c=relaxed/simple;
	bh=0948W7zjnRwlUXjoRbFmDrfT0HX3FVVObqbgE+MF5p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7IG2cjm4kdy3YQ7QznxGe/JzbWuu/zs7q7BPmaMdXcyk1ubpUepUkorGuiKTdKLWpWd7IXVJPyvoATCALgw/DhWWj39fqvky0gKDK9KBYS9lW+b0LLnCchzCfm0fWh8Q8dZUh4kxvjuIjMBL44yTizGCavQcRoTm/iQ7jUgp+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1vQxPZd; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4582760b79cso20813841cf.2;
        Mon, 07 Oct 2024 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310066; x=1728914866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNHiYOcXwPXdyGbmdnES8zS1AwkSRtDTdeiEf4FuqYQ=;
        b=i1vQxPZdUvuhYoLN9+eVdg1t63QDmht2Y5lUVnH6dNf4CoZY5lhAjYQ0g1agC34ALW
         4cPYmH4CNsOrCNrNAmnFONyst0mmtG0pNpjrAKjedmCBV2u4J8atX2IUBCJ6Gmx1xVDZ
         cpuxlVvrl/YFObpcku3inEWb+XRe6TCPGm7uzuH5QQ6GELwAAEnoM8wxarEXKH/E21/2
         xbuCQ3bhWWnda/fsVzN12Blb/A0yD0syhcrOxfErOq565do6s6LI8AHB+2+TgJ/QkZyo
         JBPhAHxjsEUqmU2Rd7pxkdeoxhan4Dt/NbkRibYxiDI+ms4ltrOi+296riZy+Mm9H32K
         Tmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310066; x=1728914866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNHiYOcXwPXdyGbmdnES8zS1AwkSRtDTdeiEf4FuqYQ=;
        b=pTi7+sl4gziZa/64WdXdzw54+D9iUiP/I7b6oqA/Aey+I8w/4mc0x1ezlyc1x6628j
         CFs0CiZMhOwaeSsd4wrQaSFXhc5/Xz/wewJegO7446lKc46IBMtfBm7Pasj6yh6rsdT2
         UQD5L49sl3swzl6zvZKDDLjwWsC45XRi7gqAwzdqB+nvYcH6clGlCtzuTNWefrbczjBA
         S6Sl71Wz48+C8YZ5JOBZcLx7tCQj15GzDLzJtsxu1hwEAa75zcwyqmKSE6dgAYdobPZ+
         rK7JtDG6xyJnvrWJUu8jbH3+mSbLLCQq4Ue+3WiQDFtayDndJgf24TgcIHNcj1N60Kqr
         V6iw==
X-Forwarded-Encrypted: i=1; AJvYcCUZBApOAth8CeeFxW8i3Z2k5pyXjasUwJST9FQ5Vg1kuaekYyHSPzK3qMrdAIX9SN2EKWddkEj4Xtdr9ns=@vger.kernel.org, AJvYcCUkWRw254lE7RS+jQ5gDDw/flpbVtq/5t5crE4QVQ7kcDcbjO+02homVDoP65DODzGpUAb6ckHa@vger.kernel.org, AJvYcCVFBD9Lvpmziy1fagoF31HOQIHy/5Nx/DU8o+AkkEeYYPrEgT4a3cHo4zXYLxGMMynCuz/M3DoDKmv3ZCFxpc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziFKZhx7N7R6x0D2gdW3PIj5+XkA+arhq7thkgbtvXd8U+TSdK
	NhBZBy0Sf09x7Cz+b2bH0pX9TxN3NdcOrjEKzOmj20QWkPBdfD+9
X-Google-Smtp-Source: AGHT+IEaQKoPog7diPp7yN6N8AKS36H35OJETpZTKMZ/Pc3VrlvxzxqS82rqrRSfuYRgDxYKvFOS0A==
X-Received: by 2002:a05:6214:3384:b0:6c5:17cf:d9fc with SMTP id 6a1803df08f44-6cb9a5300fcmr183625326d6.46.1728310065875;
        Mon, 07 Oct 2024 07:07:45 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4751920sm26041906d6.98.2024.10.07.07.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:07:45 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1F72C120006E;
	Mon,  7 Oct 2024 10:07:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 07 Oct 2024 10:07:45 -0400
X-ME-Sender: <xms:MesDZxwDoiGuYrpqBL7SDSKTKPKwT4fR6yVrrHDGMT-6KJgbwaNYgw>
    <xme:MesDZxSXjE75K1bvQbiydvJ6O01f8Qm98NqLj364OWlBnjSEcBQpq-0h3cUw5HkZj
    OOjsS-qcv76n8IVjw>
X-ME-Received: <xmr:MesDZ7WjaFcwRrzC8o-MA_qXoAwmVGiQ7b_VFdR9xXdcYK3eTpIG5Vx7noCUNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtph
    htthhopehfuhhjihhtrgdrthhomhhonhhorhhisehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhush
    htqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmghhrohhssh
    esuhhmihgthhdrvgguuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghgrrhihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:MesDZzi-YWAAP4COWeMfUgXMlbpZLnSLe5TbZo48ZngzHI-sDq32ug>
    <xmx:MesDZzASaAL8bIgKE1UjUgZQ7VaGHebrhrIwU8k6PbKVOshug38koQ>
    <xmx:MesDZ8J6zWtid3dOTmwvtLXoQd6zVkPbF16Ba-in7rAOsBAgAuZkUw>
    <xmx:MesDZyAiPVxFYZHkd8iFGH7W1uTAJdY8u6MmR6tUfxUlFP_g-EpzYg>
    <xmx:MesDZ3wU4XCN_-7lqgtoLYNbAE2t6g8mifCyuUaxTxG1n5KGLEEkYQ6R>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 10:07:44 -0400 (EDT)
Date: Mon, 7 Oct 2024 07:06:26 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <ZwPq4pdvcz9ADNTM@boqun-archlinux>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-6-fujita.tomonori@gmail.com>
 <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux>
 <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux>
 <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>

On Mon, Oct 07, 2024 at 03:48:09PM +0200, Andrew Lunn wrote:
> On Mon, Oct 07, 2024 at 05:28:28AM -0700, Boqun Feng wrote:
> > On Sun, Oct 06, 2024 at 04:45:21PM +0200, Andrew Lunn wrote:
> > [...]
> > > > > > +    if sleep {
> > > > > > +        // SAFETY: FFI call.
> > > > > > +        unsafe { bindings::might_sleep() }
> > > > > > +    }
> > > > > 
> > > > > What is actually unsafe about might_sleep()? It is a void foo(void)
> > > > 
> > > > Every extern "C" function is by default unsafe, because C doesn't have
> > > > the concept of safe/unsafe. If you want to avoid unsafe, you could
> > > > introduce a Rust's might_sleep() which calls into
> > > > `bindings::might_sleep()`:
> > > > 
> > > > 	pub fn might_sleep() {
> > > > 	    // SAFETY: ??
> > > > 	    unsafe { bindings::might_sleep() }
> > > > 	}
> > > > 
> > > > however, if you call a might_sleep() in a preemption disabled context
> > > > when CONFIG_DEBUG_ATOMIC_SLEEP=n and PREEMPT=VOLUNTERY, it could means
> > > > an unexpected RCU quiescent state, which results an early RCU grace
> > > > period, and that may mean a use-after-free. So it's not that safe as you
> > > > may expected.
> > > 
> > > If you call might_sleep() in a preemption disabled context you code is
> > > already unsafe, since that is the whole point of it, to find bugs
> > 
> > Well, in Rust, the rule is: any type-checked (compiled successfully)
> > code that only calls safe Rust functions cannot be unsafe. So the fact
> > that calling might_sleep() in a preemption disabled context is unsafe
> > means that something has to be unsafe.
> > 
> > This eventually can turn into a "blaming game" in the design space: we
> > can either design the preemption disable function as unsafe or the
> > might_sleep() function as unsafe. But one of them has to be unsafe
> > function, otherwise we are breaking the safe code guarantee.
> 
> Just keep in mind, it could of been C which put you into atomic
> context before calling into Rust. An interrupt handler would be a good
> example, and i'm sure there are others.
> 

That's why the klint approach is preferred right now. Without klint, and
if we don't want to mark might_sleep() as unsafe, we probably need to
mark the registration of an interrupt handler unsafe, and the safety
requirement would be "making sure the handler doesn't call schedule()".

> > However, this is actually a special case: currently we want to use klint
> > [1] to detect all context mis-matches at compile time. So the above rule
> > extends for kernel: any type-checked *and klint-checked* code that only
> > calls safe Rust functions cannot be unsafe. I.e. we add additional
> > compile time checking for unsafe code. So if might_sleep() has the
> > proper klint annotation, and we actually enable klint for kernel code,
> > then we can make it safe (along with preemption disable functions being
> > safe).
> > 
> > > where you use a sleeping function in atomic context. Depending on why
> > > you are in atomic context, it might appear to work, until it does not
> > > actually work, and bad things happen. So it is not might_sleep() which
> > > is unsafe, it is the Rust code calling it.
> > 
> > The whole point of unsafe functions is that calling it may result into
> > unsafe code, so that's why all extern "C" functions are unsafe, so are
> > might_sleep() (without klint in the picture).
> 
> There is a psychological part to this. might_sleep() is a good debug
> tool, which costs very little in normal builds, but finds logic bugs
> when enabled in debug builds. What we don't want is Rust developers
> not scattering it though their code because it adds unsafe code, and
> the aim is not to have any unsafe code.
> 

Sure, but my point is these need to be put together into a proper
design. For example, spin_lock() is currently exposed into Rust as a
safe API lock(), so the following code is unsafe:

	let g = lock1.lock(); // lock1 is a spinlock
	might_sleep();
	drop(g);

without the klint rule, if we want to mark might_sleep() as safe, then
we need to mark lock() as unsafe, otherwise, it's an unsafe code block
constructed by pure safe functions. However, compared to might_sleep(),
I think we would like keep lock() as safe since it is used more widely.

Regards,
Boqun

> 	Andrew

