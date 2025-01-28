Return-Path: <netdev+bounces-161308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C3FA209C6
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 12:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB824163B57
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7CF19FA8D;
	Tue, 28 Jan 2025 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GmaINHki"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F225519F111;
	Tue, 28 Jan 2025 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738064275; cv=none; b=R3W4Jx8kRnooV8AK9nAh49Igtqvqzggo1a9+UyHC6Gznj5NgpTJLnCsIXCNkym3v6YL+LN2zJWWkv0zJH81lIC2HrTMAcPvK9IHajOms+HEn+q0BWYEKZRTHy1h+TRVZ99Cw4gp9rcTpiKY/ri82XNsPSUcZ7ozoA8fArGOIgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738064275; c=relaxed/simple;
	bh=iW5mPyaVRt58KWqGX4R/8fXMgM94ROxcwullrfypsII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDC3YlGeZPBAzyoffYUIa7ifUwtj1bdR4GEImvDs3GshmSMmFvZp5Zi7thOYwTXaSBvIdO2Ye/cAzIwAa+tc9M5z5D47FmlgJL/WrtxXcyesp9l4af0jDXKB3xsYm4KrCGLiY2b0C8hHfvm3dJewaFYweje4P5IGIe5Ar51FJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GmaINHki; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YxJMDJpcb0hx8brZC1qpWzYpsXcI2/beMqyx1/b0dls=; b=GmaINHkipIqeyIHm8B8iyv4eFx
	ZBMl2CTVmOB0jPxCTN+f/eZowzz8VbS3UmTSzHMDP6LzyQA4F9rhSBvVSDrUgkPQbJWY5d8kzrZr3
	sgUBTOZGYPVK5Xjj2Rs2aeoYyFLFmulTtOelCQWky7VOjENUNEMy4BjPG+JPMLgVKg57xz2fAf8tL
	F2KBPUEdqGRmaJREzNhZJ4QKUssS7WnreKoIopdtH25tLd6vIAi7N3LWyF1jH2Os+OtAXst1PgzWZ
	xfVUHPFgiGdVTeFFPZwhLtnzaVZD7ujz9STh710eZ8N61LLEKDQ6RPEzMTaSlS3ggLEgLQQm6Q6bj
	YNH+kdVw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcjuV-0000000Evlv-1CKE;
	Tue, 28 Jan 2025 11:37:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A3DBA30050D; Tue, 28 Jan 2025 12:37:38 +0100 (CET)
Date: Tue, 28 Jan 2025 12:37:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 1/8] sched/core: Add __might_sleep_precision()
Message-ID: <20250128113738.GC7145@noisy.programming.kicks-ass.net>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
 <20250125101854.112261-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250125101854.112261-2-fujita.tomonori@gmail.com>

On Sat, Jan 25, 2025 at 07:18:46PM +0900, FUJITA Tomonori wrote:
> Add __might_sleep_precision(), Rust friendly version of
> __might_sleep(), which takes a pointer to a string with the length
> instead of a null-terminated string.
> 
> Rust's core::panic::Location::file(), which gives the file name of a
> caller, doesn't provide a null-terminated
> string. __might_sleep_precision() uses a precision specifier in the
> printk format, which specifies the length of a string; a string
> doesn't need to be a null-terminated.
> 
> Modify __might_sleep() to call __might_sleep_precision() but the
> impact should be negligible. strlen() isn't called in a normal case;
> it's called only when printing the error (sleeping function called
> from invalid context).
> 
> Note that Location::file() providing a null-terminated string for
> better C interoperability is under discussion [1].

Urgh :/

