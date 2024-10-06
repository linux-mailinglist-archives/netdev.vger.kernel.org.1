Return-Path: <netdev+bounces-132496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B42B991EF8
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 16:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75CB01C20EFF
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 14:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5C23611B;
	Sun,  6 Oct 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lATDtZJp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC7B4C74;
	Sun,  6 Oct 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728225952; cv=none; b=cEtbmIIoEYyQ0JBpNVligunJkxDcb8ndXtu+O/paC58dWqhZCw2sKIS+YQKl1whkHMiaBdDifuFPcpGFK/m+NPqMC4LGqcf120pQ9RjjEQ8BfQs6dMLSqz/k/wugsEx6JjUGP+AZzchYbrZJ7SBd+4dBx1GcJxsK7/RfysBqPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728225952; c=relaxed/simple;
	bh=2ojKdSiJX3m0RwIsErwzLLaYE7C1YwdcVnXb9B2l6zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DehH6ot+oPz2zLwxpL22KtsUAwvdoaeBtAf5BX1H/GxJ1J1amjqy4Zv0EqUDde5cVXbJlacyrPqkPr+rISUV2wtSo3SrX8c97LHxbzFA+Mu576u0YO/imshps9EBKVHosmW6LU3GoFhmPNf4yErOixfHUXsai85YcfGpIvN5WMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lATDtZJp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FkIgVPdoA8VZ2rGYtdVu+cQAsveXdhu7De0J+IqMDOc=; b=lATDtZJpRC1kMy5qcpOIDKjvHt
	YVgNiYnXKH6HURvj/Jpo6YhW/OAuD/kNPsH6MROZRIpumQEFZruvu+mqm6Oc6bkb+plDN/qm6rW8K
	0IwcOqNiyHfAXBYNYboPW7Hb2Fo79TNLnXiFG0ZRQZyovDTKpYOBcNhsLXxJQUqb5JmQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxSVd-009Bhe-1Z; Sun, 06 Oct 2024 16:45:21 +0200
Date: Sun, 6 Oct 2024 16:45:21 +0200
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
Message-ID: <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-6-fujita.tomonori@gmail.com>
 <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwG8H7u3ddYH6gRx@boqun-archlinux>

On Sat, Oct 05, 2024 at 03:22:23PM -0700, Boqun Feng wrote:
> On Sat, Oct 05, 2024 at 08:32:01PM +0200, Andrew Lunn wrote:
> > > might_sleep() is called via a wrapper so the __FILE__ and __LINE__
> > > debug info with CONFIG_DEBUG_ATOMIC_SLEEP enabled isn't what we
> > > expect; the wrapper instead of the caller.
> > 
> > So not very useful. All we know is that somewhere in Rust something is
> > sleeping in atomic context. Is it possible to do better? Does __FILE__
> > and __LINE__ exist in Rust?
> > 
> 
> Sure, you can use: 
> 
> 	https://doc.rust-lang.org/core/macro.line.html

So i guess might_sleep() needs turning into some sort of macro, calling
__might_sleep(__FILE__, __LINE__); might_resched();

> > > +    if sleep {
> > > +        // SAFETY: FFI call.
> > > +        unsafe { bindings::might_sleep() }
> > > +    }
> > 
> > What is actually unsafe about might_sleep()? It is a void foo(void)
> 
> Every extern "C" function is by default unsafe, because C doesn't have
> the concept of safe/unsafe. If you want to avoid unsafe, you could
> introduce a Rust's might_sleep() which calls into
> `bindings::might_sleep()`:
> 
> 	pub fn might_sleep() {
> 	    // SAFETY: ??
> 	    unsafe { bindings::might_sleep() }
> 	}
> 
> however, if you call a might_sleep() in a preemption disabled context
> when CONFIG_DEBUG_ATOMIC_SLEEP=n and PREEMPT=VOLUNTERY, it could means
> an unexpected RCU quiescent state, which results an early RCU grace
> period, and that may mean a use-after-free. So it's not that safe as you
> may expected.

If you call might_sleep() in a preemption disabled context you code is
already unsafe, since that is the whole point of it, to find bugs
where you use a sleeping function in atomic context. Depending on why
you are in atomic context, it might appear to work, until it does not
actually work, and bad things happen. So it is not might_sleep() which
is unsafe, it is the Rust code calling it.

	Andrew




