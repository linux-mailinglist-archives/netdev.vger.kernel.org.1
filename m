Return-Path: <netdev+bounces-132702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68189992DB1
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C24A1C220EB
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FC61D4326;
	Mon,  7 Oct 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v7eN2z1T"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BAC1D2223;
	Mon,  7 Oct 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308912; cv=none; b=hf3ifbTYMVcAjdH+K4iPqkB/Dr/joFD69mpEMaZXJ6JH5yddf6T1xhXORrjlCA0K/sDf+G3nO2aVTI/XlVqp3f5n77Iw8Z6cIWMpD2D7gWKwUF7a6Vfg/tGfZPg42QYwrX+syHG2sPcc1KLXzZBHH03S6md41im1QMEIbfZTY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308912; c=relaxed/simple;
	bh=aNfKhpR+COGAnurrQ1qEerAhVLsQXkQtnBVsPQoSfMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pcozi52amN1dE7eVNGPYtfxd6i3SAb7DEZMq3EG+xmDeh+s1Q0oCT8KMYhyEZeqelzyiZf9TqAYCvOU02N8Z4Pzoy5/4eyRxMoQBGcwbrNjBBYGVd+FqI0aHyM11XmJDWyPgCkvNYEHwpwlrUUPYnKoqwzSh/Nef2439C0wiTMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v7eN2z1T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zbDRG+fwMPbFuvhcpRI9/YsPLmcflro4JIwDOxVyV7E=; b=v7eN2z1TVnKvaGtrEhYPpmvcqG
	1vKz3QGMgAEt0Ox91HV2wx8QhJPUTklG3d6XyHc7A/IFc3aSxI+QcJABcvvwltGpZ+JpiR9V6V8Df
	grGl2TlUGkTQkI6VWfqS5ejQxh64lRBc9HRqqwJbfCAFAXYJnzroYtwm+1CzuDVAdjQE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxo5p-009GeI-5l; Mon, 07 Oct 2024 15:48:09 +0200
Date: Mon, 7 Oct 2024 15:48:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-6-fujita.tomonori@gmail.com>
 <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux>
 <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwPT7HZvG1aYONkQ@boqun-archlinux>

On Mon, Oct 07, 2024 at 05:28:28AM -0700, Boqun Feng wrote:
> On Sun, Oct 06, 2024 at 04:45:21PM +0200, Andrew Lunn wrote:
> [...]
> > > > > +    if sleep {
> > > > > +        // SAFETY: FFI call.
> > > > > +        unsafe { bindings::might_sleep() }
> > > > > +    }
> > > > 
> > > > What is actually unsafe about might_sleep()? It is a void foo(void)
> > > 
> > > Every extern "C" function is by default unsafe, because C doesn't have
> > > the concept of safe/unsafe. If you want to avoid unsafe, you could
> > > introduce a Rust's might_sleep() which calls into
> > > `bindings::might_sleep()`:
> > > 
> > > 	pub fn might_sleep() {
> > > 	    // SAFETY: ??
> > > 	    unsafe { bindings::might_sleep() }
> > > 	}
> > > 
> > > however, if you call a might_sleep() in a preemption disabled context
> > > when CONFIG_DEBUG_ATOMIC_SLEEP=n and PREEMPT=VOLUNTERY, it could means
> > > an unexpected RCU quiescent state, which results an early RCU grace
> > > period, and that may mean a use-after-free. So it's not that safe as you
> > > may expected.
> > 
> > If you call might_sleep() in a preemption disabled context you code is
> > already unsafe, since that is the whole point of it, to find bugs
> 
> Well, in Rust, the rule is: any type-checked (compiled successfully)
> code that only calls safe Rust functions cannot be unsafe. So the fact
> that calling might_sleep() in a preemption disabled context is unsafe
> means that something has to be unsafe.
> 
> This eventually can turn into a "blaming game" in the design space: we
> can either design the preemption disable function as unsafe or the
> might_sleep() function as unsafe. But one of them has to be unsafe
> function, otherwise we are breaking the safe code guarantee.

Just keep in mind, it could of been C which put you into atomic
context before calling into Rust. An interrupt handler would be a good
example, and i'm sure there are others.

> However, this is actually a special case: currently we want to use klint
> [1] to detect all context mis-matches at compile time. So the above rule
> extends for kernel: any type-checked *and klint-checked* code that only
> calls safe Rust functions cannot be unsafe. I.e. we add additional
> compile time checking for unsafe code. So if might_sleep() has the
> proper klint annotation, and we actually enable klint for kernel code,
> then we can make it safe (along with preemption disable functions being
> safe).
> 
> > where you use a sleeping function in atomic context. Depending on why
> > you are in atomic context, it might appear to work, until it does not
> > actually work, and bad things happen. So it is not might_sleep() which
> > is unsafe, it is the Rust code calling it.
> 
> The whole point of unsafe functions is that calling it may result into
> unsafe code, so that's why all extern "C" functions are unsafe, so are
> might_sleep() (without klint in the picture).

There is a psychological part to this. might_sleep() is a good debug
tool, which costs very little in normal builds, but finds logic bugs
when enabled in debug builds. What we don't want is Rust developers
not scattering it though their code because it adds unsafe code, and
the aim is not to have any unsafe code.

	Andrew

