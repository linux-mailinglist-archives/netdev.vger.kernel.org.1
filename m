Return-Path: <netdev+bounces-161907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C23BA248ED
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 13:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3D27A16DD
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54901AAA00;
	Sat,  1 Feb 2025 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KOqBbc7o"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC061A00F8;
	Sat,  1 Feb 2025 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738412195; cv=none; b=FnPsbcUnDRhfIjZHwjiJaytjFFm4IiZLuAeKpRvYXM4dqlPZc5PMvzVTR74mIDfnB/9JgXsm+TvK7vN7YLM9+HPIyj6BTp9R7IMFZTjL6VibJ1FdXa/UdrpqB7NnTTXhZVUlsLDDwXleQteRLTbko9U6ndLNM+4g0fa6b26GCCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738412195; c=relaxed/simple;
	bh=6ygYfFgJRBrBWpChngQqE9jWlxFUSeWN1NPdhi6DIwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CllmQFNOrqOQ6S7wo4gklhlqYWrhNbr56tRD1rHEOp1zm/7kSt7T5+l70Ck4pyvDu1jstb4AbbylsJQgJj5WNkNWSWMCwoUlGGoFHqknnzc8Rf/ORAD8/JvAFH1YGWTwEU+xA2BQM/ioZMNe5olyHEhHXnnuSI4ZgwskfS5fnHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KOqBbc7o; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dsMvg7ZCVh7m4D+6zs5L9cte2LOA+U4GyXDWvKKgXhs=; b=KOqBbc7oAX0DgppuJE6DoHHn/r
	GBTiXN1x8ubMhszPUQbNsJU5IlSYItizXFMXEBQ6lPvpU/mhMak39Iwb07VAnxCioudJz4yQQnF6x
	zNTMIulgJStVIHRknvsV5vcCK/GbNPQ6RJIw3FHwcDHuywJ9PlnreZH9MrWI0uYF3hM2XrA8pw2Q5
	tzNudU4K4aAThsPubFz+7Ve6CPwHjgaRFi6/QqHkhLoBR+LaBgXKtSp/cjLBGdLT9aAs9DUB+ht/1
	K0/5BvjV/Zv0bO8H6sPSg7wyKGlC/NhlixbgnNU2fiFt2XhG0OJvtd8cdh8BatAKC2vMJPBNUwwJ6
	YBSW758w==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1teCQ3-0000000Fi18-1Y17;
	Sat, 01 Feb 2025 12:16:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2014530050D; Sat,  1 Feb 2025 13:16:14 +0100 (CET)
Date: Sat, 1 Feb 2025 13:16:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 1/8] sched/core: Add __might_sleep_precision()
Message-ID: <20250201121613.GC8256@noisy.programming.kicks-ass.net>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
 <20250125101854.112261-2-fujita.tomonori@gmail.com>
 <20250128113738.GC7145@noisy.programming.kicks-ass.net>
 <20250130.085644.2298700991414831587.fujita.tomonori@gmail.com>
 <Z5rSjsdwG2aonZrB@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5rSjsdwG2aonZrB@boqun-archlinux>

On Wed, Jan 29, 2025 at 05:14:54PM -0800, Boqun Feng wrote:
> On Thu, Jan 30, 2025 at 08:56:44AM +0900, FUJITA Tomonori wrote:
> > On Tue, 28 Jan 2025 12:37:38 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Sat, Jan 25, 2025 at 07:18:46PM +0900, FUJITA Tomonori wrote:
> > >> Add __might_sleep_precision(), Rust friendly version of
> > >> __might_sleep(), which takes a pointer to a string with the length
> > >> instead of a null-terminated string.
> > >> 
> > >> Rust's core::panic::Location::file(), which gives the file name of a
> > >> caller, doesn't provide a null-terminated
> > >> string. __might_sleep_precision() uses a precision specifier in the
> > >> printk format, which specifies the length of a string; a string
> > >> doesn't need to be a null-terminated.
> > >> 
> > >> Modify __might_sleep() to call __might_sleep_precision() but the
> > >> impact should be negligible. strlen() isn't called in a normal case;
> > >> it's called only when printing the error (sleeping function called
> > >> from invalid context).
> > >> 
> > >> Note that Location::file() providing a null-terminated string for
> > >> better C interoperability is under discussion [1].
> > > 
> > > Urgh :/
> > 
> > Yeah... so not acceptable?

Just frustrated we 'need' more ugly to deal with Rust being stupid.

> I would like to see some concrete and technical reasons for why it's not
> acceptable ;-) I'm not sure whether Peter was against this patch or just
> not happy about Location::file() providing a null-terminated string is a
> WIP.

The latter.

I just hate on Rust for being designed by a bunch of C haters, not
wanting to acknowledge the whole frigging world runs on C and they
*have* to deal with interoperability.

That got us a whole pile of ugly including this.



