Return-Path: <netdev+bounces-182943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F88A8A642
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921A916E1D0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C49821A952;
	Tue, 15 Apr 2025 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYVcKBBM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9496FC3;
	Tue, 15 Apr 2025 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740098; cv=none; b=oSJc7I0n6MduMnZCrdJ02STRoIjTB+wza/HR3OEXSg0QAvvjaZkFAfjWIJXMVqat2fSyusfB9oJXqrN4qMf4+Q18zNqe9shR1Ozcbit968M+U6duD0I8/E5X8bCkDxGzlfmhWaDtFTPgqJO/LWfPlNNIWaVu8+MmmyFO9q9x1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740098; c=relaxed/simple;
	bh=Oyl04NWi/JqRZmoGsQCWaLqNDEYwjRUG+ojZwnBLlhQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmWbygRr0mqKotAINqyoQ12MA1lyevfwUrVCG+qQF54/K0SNh2BdCKiiZIrtnQPzXYwbQrjVRusC8yP8ocaNhpDjoXVCPyhjR5Ss8WWO5gclijnJxTve0LLW7i8xSB1mq+SBbJqB1H+ha8DRqJZu9VhFmX0VNOZ8YQauRd+biaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYVcKBBM; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8fce04655so51112116d6.3;
        Tue, 15 Apr 2025 11:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740095; x=1745344895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA0CtAVC2wdEx4gzh+vGRjkn5KNLgMNI98hQKcHoy1I=;
        b=QYVcKBBM2WVMaoAXp1I20gIEo1nXShRcNXt0AE2YI/hiRxAzBrksZB0HKpgDV3jj9A
         oNyFIngZqelQeZmEikmevwZjRKJ42dOl6eTBx63XhqJqtu4XT3ILdubTelmPe3ty9/jF
         5d+ATJMVhmShfMXuktQ6H/UV/z0N9jEJONC1cfLitf5/hjWyty10Doz3HYUh/uG2iREv
         pKJhYT8Mdl8SQbgbyQ6eT1I6zO8PqHTfuDnKBxqMV85s7QAvgJlyllr0qbRobCBUOPbl
         8GXHXQcJC3PBDoA+/nKdQFjes63Z/lFTrYJckJw54pg7mxOIiUy/q4YPUB9ztsPEOqFE
         32Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740095; x=1745344895;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA0CtAVC2wdEx4gzh+vGRjkn5KNLgMNI98hQKcHoy1I=;
        b=K9Cgna9NpQBhob09FysAK/dG/hKzCi6j7pdYXLH/FlnSMiiadjxrSJmHTOE9E4CQj6
         VvgaO93DURDu8M01T4rUJvFN66CBe34gBl6gcJxagdtEDrPdDNcN/3i9NyEvwjTsOVfC
         KAxsSFsxwU9u1rkYaLKTKxFzkke2im3UtEw6YLTEo8uf7qwXYkI+EcenVBlE5TFtU7qA
         8ENASKXmu+Xvf/1p7MTBrseTqhEhdUOmDC/UOjKYpJfiU07LFPLV6K+f1uTNBmU5uy/O
         TNYrVUdYZfJrA94+l1SQW1odk7Dr6h6xRS1JXpD7s1E8wI5PH43eUS1S5oHA/iEXhclg
         TYxA==
X-Forwarded-Encrypted: i=1; AJvYcCUr6zicZ5RR4vrRKQAItNiA+gM0TV+pfa0eDf8W+7gAIfRDUNBUYXIaM4/7mYApgvnkc3Nj1u1QIt/Kz4s=@vger.kernel.org, AJvYcCVot7dGIYzD5f9vldaRwIviMcgm201MYyqOgFwT0xw9NpZK3fewfQEYLdMnW4IrmAYNG3wtZnBQ6DatvMvG4gM=@vger.kernel.org, AJvYcCWkeR/L7HL206onCgrmQqQkYqcDnov0tKTUVzYyKKkRkvGQYLg0pa9L6MyHt05IAELWQk7GN/2s@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+ezxeer8O+Jw6zgqudTPmH8fRSwxOV7fnJED0KHSTHNfHpdV
	B3dzamCS2CtfgYHIE2wbr76TZbnFt+rg66v5/XXlCeb38HB4/0bS
X-Gm-Gg: ASbGncvQoc9BHpeXIJf7zduuki64TsSOlGhUSL2P2BNMYRrcqwG+IBJZPK5yLKDny33
	phgzfFq9y+thuCXLByDU6gfFYzf+Ha2H1vjc9pfMBxESHsei7S7YdvDIVv+qsZfite7XEfwKM/1
	6BsdJiLv48mGrO31TkLrZa8vMkfRl7zO0NtumfoomtBEyf7BriHSHAW+Tq6VL32gwVKnoYaHf59
	K2318aFDC4G8lwyzMbm8eGaLwdAEEqrqdM7w19yTIiXBqotx401Ukgl288lBIC5aVJDBPnhHBsN
	JZJMTxFY0UfxNANGAGA89irJmm9BQJqn/hpceM42rogLLDgmPuhZmsc1Of0BmI14nnkYhpdOf5s
	GmF5JcujaWT4f6e17ngCKGcRpUz45akU=
X-Google-Smtp-Source: AGHT+IH2H9ZQfhj7ONNNbe+1qSRDKH68DnsA1sMkiXsweJ2o8iNpctUpY25jaPCJFlKJiy/yl4ZiiA==
X-Received: by 2002:ad4:5d4b:0:b0:6e6:5f28:9874 with SMTP id 6a1803df08f44-6f2ad849619mr7442486d6.2.1744740094818;
        Tue, 15 Apr 2025 11:01:34 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea08028sm104199106d6.90.2025.04.15.11.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:01:34 -0700 (PDT)
Message-ID: <67fe9efe.d40a0220.aa401.b05f@mx.google.com>
X-Google-Original-Message-ID: <Z_6e-r8XTVppZuR1@winterfell.>
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 693E5120007A;
	Tue, 15 Apr 2025 14:01:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 14:01:33 -0400
X-ME-Sender: <xms:_Z7-Z-9__PIJQwET5VY1mxcFB1_X5mTYytcuhxYBPEhJQEJB7hoH7A>
    <xme:_Z7-Z-tOvcqMGmO_BEMkLp2rRB5Wi-6MdqfviYT9Y0BBw3byC9QFKwiQQ-br9p4Og
    vsJekL2OX4pPs5iJQ>
X-ME-Received: <xmr:_Z7-Z0AUhunII-roeNxaYAEifPaO-TwFDaLhNLQDfzoLLjbYt_5HPGdv66QU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeefhedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthho
    pegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqd
    hfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgr
    rhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepmhgvsehklhhovghnkhdruggvvh
    dprhgtphhtthhopegurghnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrnhgurhgvfieslhhunhhnrdgthh
X-ME-Proxy: <xmx:_Z7-Z2eLK1Rf4oKOIqE17w1hFDSetO11YE9I6t1AYjyPulk115wyNg>
    <xmx:_Z7-ZzOpAAdgSYLaizuF5OGRfvM9s2B5l2ceetBl83_bqlnhls6_rw>
    <xmx:_Z7-Zwl5Nkm9Q7BXRdXpCPSnb9gErbgSURjLI8YdE5jzhoUEpGCVzQ>
    <xmx:_Z7-Z1sw2fEX4JruWIJW-mwXl1hchTBekTE37cKVzDFGU_QQg3M7CA>
    <xmx:_Z7-Z5slgKHrHgSmzWpMc8Cr5R3itbM9_-ztNLPlJyaJvL2j1VIvIgn6>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 14:01:32 -0400 (EDT)
Date: Tue, 15 Apr 2025 11:01:30 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, rust-for-linux@vger.kernel.org, gary@garyguo.net,
	me@kloenk.dev, daniel.almeida@collabora.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
	sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v13 3/5] rust: time: Introduce Instant type
References: <gfamC5NjhLe9s4hmTvSZ7QKdHWaDanKv8IgocjF5GbeWMHvfFm0bGedvpqm5ZedrHFp-Nl6jEQC3618e3UQRrQ==@protonmail.internalid>
 <67fc517b.050a0220.301460.dfe7@mx.google.com>
 <87lds3cjgx.fsf@kernel.org>
 <20250414.205954.2258973048785103265.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414.205954.2258973048785103265.fujita.tomonori@gmail.com>

On Mon, Apr 14, 2025 at 08:59:54PM +0900, FUJITA Tomonori wrote:
> On Mon, 14 Apr 2025 09:04:14 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
> 
> > "Boqun Feng" <boqun.feng@gmail.com> writes:
> > 
> >> On Sun, Apr 13, 2025 at 07:43:08PM +0900, FUJITA Tomonori wrote:
> >>> Introduce a type representing a specific point in time. We could use
> >>> the Ktime type but C's ktime_t is used for both timestamp and
> >>> timedelta. To avoid confusion, introduce a new Instant type for
> >>> timestamp.
> >>>
> >>> Rename Ktime to Instant and modify their methods for timestamp.
> >>>
> >>> Implement the subtraction operator for Instant:
> >>>
> >>> Delta = Instant A - Instant B
> >>>
> >>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> >>
> >> I probably need to drop my Reviewed-by because of something below:
> >>
> >>> Reviewed-by: Gary Guo <gary@garyguo.net>
> >>> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> >>> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> >>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> >>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> >>> ---
> >> [...]
> >>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> >>> index ce53f8579d18..27243eaaf8ed 100644
> >>> --- a/rust/kernel/time/hrtimer.rs
> >>> +++ b/rust/kernel/time/hrtimer.rs
> >>> @@ -68,7 +68,7 @@
> >>>  //! `start` operation.
> >>>
> >>>  use super::ClockId;
> >>> -use crate::{prelude::*, time::Ktime, types::Opaque};
> >>> +use crate::{prelude::*, time::Instant, types::Opaque};
> >>>  use core::marker::PhantomData;
> >>>  use pin_init::PinInit;
> >>>
> >>> @@ -189,7 +189,7 @@ pub trait HrTimerPointer: Sync + Sized {
> >>>
> >>>      /// Start the timer with expiry after `expires` time units. If the timer was
> >>>      /// already running, it is restarted with the new expiry time.
> >>> -    fn start(self, expires: Ktime) -> Self::TimerHandle;
> >>> +    fn start(self, expires: Instant) -> Self::TimerHandle;
> >>
> >> We should be able to use what I suggested:
> >>
> >> 	https://lore.kernel.org/rust-for-linux/Z_ALZsnwN53ZPBrB@boqun-archlinux/
> >>
> >> to make different timer modes (rel or abs) choose different expire type.
> >>
> >> I don't think we can merge this patch as it is, unfortunately, because
> >> it doesn't make sense for a relative timer to take an Instant as expires
> >> value.
> > 
> > I told Tomo he could use `Instant` in this location and either he or I
> > would fix it up later [1].
> > 

I saw that, however, I don't think we can put `Instant` as the parameter
for HrTimerPointer::start() because we don't yet know how long would the
fix-it-up-later take. And it would confuse users if they need a put an
Instant for relative time.

> > I don't want to block the series on this since the new API is not worse
> > than the old one where Ktime is overloaded for both uses.

How about we keep Ktime? That is HrTimerPointer::start() still uses
Ktime, until we totally finish the refactoring as Tomo show below?
`Ktime` is much better here because it at least matches C API behavior,
we can remove `Ktime` once the dust is settled. Thoughts?

Regards,
Boqun

> 
> Here's the fix that I've worked on. As Boqun suggested, I added
> `HrTimerExpireMode` trait since `HrTimerMode` is already used. It
> compiles, but I'm not sure if it's what everyone had in mind.
> 
> Since many parts need to be made generic, I think the changes will be
> complicated. Rather than including this in the instant and duration
> patchset, I think it would be better to review this change separately.
> 
> 
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index 27243eaaf8ed..db3f99662222 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -68,10 +68,16 @@
>  //! `start` operation.
>  
>  use super::ClockId;
> -use crate::{prelude::*, time::Instant, types::Opaque};
> +use crate::{prelude::*, types::Opaque};
>  use core::marker::PhantomData;
>  use pin_init::PinInit;
>  
> +pub trait HrTimerExpireMode {
> +    type Expires; /* either Delta or Instant */
> +
> +    fn as_nanos(expires: Self::Expires) -> bindings::ktime_t;
> +}
> +
>  /// A timer backed by a C `struct hrtimer`.
>  ///
>  /// # Invariants
> @@ -176,7 +182,7 @@ pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
>  /// that more than one [`HrTimerHandle`] associated with a [`HrTimerPointer`] may
>  /// exist. A timer can be manipulated through any of the handles, and a handle
>  /// may represent a cancelled timer.
> -pub trait HrTimerPointer: Sync + Sized {
> +pub trait HrTimerPointer<Mode: HrTimerExpireMode>: Sync + Sized {
>      /// A handle representing a started or restarted timer.
>      ///
>      /// If the timer is running or if the timer callback is executing when the
> @@ -189,7 +195,7 @@ pub trait HrTimerPointer: Sync + Sized {
>  
>      /// Start the timer with expiry after `expires` time units. If the timer was
>      /// already running, it is restarted with the new expiry time.
> -    fn start(self, expires: Instant) -> Self::TimerHandle;
> +    fn start(self, expires: Mode::Expires) -> Self::TimerHandle;
>  }
>  
>  /// Unsafe version of [`HrTimerPointer`] for situations where leaking the
> @@ -203,7 +209,7 @@ pub trait HrTimerPointer: Sync + Sized {
>  /// Implementers of this trait must ensure that instances of types implementing
>  /// [`UnsafeHrTimerPointer`] outlives any associated [`HrTimerPointer::TimerHandle`]
>  /// instances.
> -pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
> +pub unsafe trait UnsafeHrTimerPointer<Mode: HrTimerExpireMode>: Sync + Sized {
>      /// A handle representing a running timer.
>      ///
>      /// # Safety
> @@ -220,7 +226,7 @@ pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
>      ///
>      /// Caller promises keep the timer structure alive until the timer is dead.
>      /// Caller can ensure this by not leaking the returned [`Self::TimerHandle`].
> -    unsafe fn start(self, expires: Instant) -> Self::TimerHandle;
> +    unsafe fn start(self, expires: Mode::Expires) -> Self::TimerHandle;
>  }
>  
>  /// A trait for stack allocated timers.
> @@ -229,10 +235,10 @@ pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
>  ///
>  /// Implementers must ensure that `start_scoped` does not return until the
>  /// timer is dead and the timer handler is not running.
> -pub unsafe trait ScopedHrTimerPointer {
> +pub unsafe trait ScopedHrTimerPointer<Mode: HrTimerExpireMode> {
>      /// Start the timer to run after `expires` time units and immediately
>      /// after call `f`. When `f` returns, the timer is cancelled.
> -    fn start_scoped<T, F>(self, expires: Instant, f: F) -> T
> +    fn start_scoped<T, F>(self, expires: Mode::Expires, f: F) -> T
>      where
>          F: FnOnce() -> T;
>  }
> @@ -240,11 +246,12 @@ fn start_scoped<T, F>(self, expires: Instant, f: F) -> T
>  // SAFETY: By the safety requirement of [`UnsafeHrTimerPointer`], dropping the
>  // handle returned by [`UnsafeHrTimerPointer::start`] ensures that the timer is
>  // killed.
> -unsafe impl<T> ScopedHrTimerPointer for T
> +unsafe impl<T, Mode> ScopedHrTimerPointer<Mode> for T
>  where
> -    T: UnsafeHrTimerPointer,
> +    T: UnsafeHrTimerPointer<Mode>,
> +    Mode: HrTimerExpireMode,
>  {
> -    fn start_scoped<U, F>(self, expires: Instant, f: F) -> U
> +    fn start_scoped<U, F>(self, expires: Mode::Expires, f: F) -> U
>      where
>          F: FnOnce() -> U,
>      {
> @@ -319,6 +326,7 @@ pub unsafe trait HrTimerHandle {
>  /// their documentation. All the methods of this trait must operate on the same
>  /// field.
>  pub unsafe trait HasHrTimer<T> {
> +    type Mode: HrTimerExpireMode;
>      /// Return a pointer to the [`HrTimer`] within `Self`.
>      ///
>      /// This function is useful to get access to the value without creating
> @@ -366,12 +374,15 @@ unsafe fn c_timer_ptr(this: *const Self) -> *const bindings::hrtimer {
>      /// - `this` must point to a valid `Self`.
>      /// - Caller must ensure that the pointee of `this` lives until the timer
>      ///   fires or is canceled.
> -    unsafe fn start(this: *const Self, expires: Instant) {
> +    unsafe fn start(
> +        this: *const Self,
> +        expires: <<Self as HasHrTimer<T>>::Mode as HrTimerExpireMode>::Expires,
> +    ) {
>          // SAFETY: By function safety requirement, `this` is a valid `Self`.
>          unsafe {
>              bindings::hrtimer_start_range_ns(
>                  Self::c_timer_ptr(this).cast_mut(),
> -                expires.as_nanos(),
> +                Self::Mode::as_nanos(expires),
>                  0,
>                  (*Self::raw_get_timer(this)).mode.into_c(),
>              );
> diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
> index acc70a0ea1be..90cf0edf4509 100644
> --- a/rust/kernel/time/hrtimer/arc.rs
> +++ b/rust/kernel/time/hrtimer/arc.rs
> @@ -3,12 +3,12 @@
>  use super::HasHrTimer;
>  use super::HrTimer;
>  use super::HrTimerCallback;
> +use super::HrTimerExpireMode;
>  use super::HrTimerHandle;
>  use super::HrTimerPointer;
>  use super::RawHrTimerCallback;
>  use crate::sync::Arc;
>  use crate::sync::ArcBorrow;
> -use crate::time::Instant;
>  
>  /// A handle for an `Arc<HasHrTimer<T>>` returned by a call to
>  /// [`HrTimerPointer::start`].
> @@ -47,7 +47,7 @@ fn drop(&mut self) {
>      }
>  }
>  
> -impl<T> HrTimerPointer for Arc<T>
> +impl<T> HrTimerPointer<<T as HasHrTimer<T>>::Mode> for Arc<T>
>  where
>      T: 'static,
>      T: Send + Sync,
> @@ -56,7 +56,10 @@ impl<T> HrTimerPointer for Arc<T>
>  {
>      type TimerHandle = ArcHrTimerHandle<T>;
>  
> -    fn start(self, expires: Instant) -> ArcHrTimerHandle<T> {
> +    fn start(
> +        self,
> +        expires: <<T as HasHrTimer<T>>::Mode as HrTimerExpireMode>::Expires,
> +    ) -> ArcHrTimerHandle<T> {
>          // SAFETY:
>          //  - We keep `self` alive by wrapping it in a handle below.
>          //  - Since we generate the pointer passed to `start` from a valid
> diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
> index dba22d11a95f..5b79cbcaca3f 100644
> --- a/rust/kernel/time/hrtimer/pin.rs
> +++ b/rust/kernel/time/hrtimer/pin.rs
> @@ -3,6 +3,7 @@
>  use super::HasHrTimer;
>  use super::HrTimer;
>  use super::HrTimerCallback;
> +use super::HrTimerExpireMode;
>  use super::HrTimerHandle;
>  use super::RawHrTimerCallback;
>  use super::UnsafeHrTimerPointer;
> @@ -48,7 +49,7 @@ fn drop(&mut self) {
>  
>  // SAFETY: We capture the lifetime of `Self` when we create a `PinHrTimerHandle`,
>  // so `Self` will outlive the handle.
> -unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a T>
> +unsafe impl<'a, T> UnsafeHrTimerPointer<<T as HasHrTimer<T>>::Mode> for Pin<&'a T>
>  where
>      T: Send + Sync,
>      T: HasHrTimer<T>,
> @@ -56,7 +57,10 @@ unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a T>
>  {
>      type TimerHandle = PinHrTimerHandle<'a, T>;
>  
> -    unsafe fn start(self, expires: Instant) -> Self::TimerHandle {
> +    unsafe fn start(
> +        self,
> +        expires: <<T as HasHrTimer<T>>::Mode as HrTimerExpireMode>::Expires,
> +    ) -> Self::TimerHandle {
>          // Cast to pointer
>          let self_ptr: *const T = self.get_ref();
>  
> diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
> index aeff8e102e1d..82d7ecdbbfb6 100644
> --- a/rust/kernel/time/hrtimer/pin_mut.rs
> +++ b/rust/kernel/time/hrtimer/pin_mut.rs
> @@ -1,7 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  use super::{
> -    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, RawHrTimerCallback, UnsafeHrTimerPointer,
> +    HasHrTimer, HrTimer, HrTimerCallback, HrTimerExpireMode, HrTimerHandle, RawHrTimerCallback,
> +    UnsafeHrTimerPointer,
>  };
>  use crate::time::Instant;
>  use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
> @@ -46,7 +47,7 @@ fn drop(&mut self) {
>  
>  // SAFETY: We capture the lifetime of `Self` when we create a
>  // `PinMutHrTimerHandle`, so `Self` will outlive the handle.
> -unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a mut T>
> +unsafe impl<'a, T> UnsafeHrTimerPointer<<T as HasHrTimer<T>>::Mode> for Pin<&'a mut T>
>  where
>      T: Send + Sync,
>      T: HasHrTimer<T>,
> @@ -54,7 +55,10 @@ unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a mut T>
>  {
>      type TimerHandle = PinMutHrTimerHandle<'a, T>;
>  
> -    unsafe fn start(mut self, expires: Instant) -> Self::TimerHandle {
> +    unsafe fn start(
> +        mut self,
> +        expires: <<T as HasHrTimer<T>>::Mode as HrTimerExpireMode>::Expires,
> +    ) -> Self::TimerHandle {
>          // SAFETY:
>          // - We promise not to move out of `self`. We only pass `self`
>          //   back to the caller as a `Pin<&mut self>`.
> diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
> index 3df4e359e9bb..21aa0aa61cc8 100644
> --- a/rust/kernel/time/hrtimer/tbox.rs
> +++ b/rust/kernel/time/hrtimer/tbox.rs
> @@ -3,6 +3,7 @@
>  use super::HasHrTimer;
>  use super::HrTimer;
>  use super::HrTimerCallback;
> +use super::HrTimerExpireMode;
>  use super::HrTimerHandle;
>  use super::HrTimerPointer;
>  use super::RawHrTimerCallback;
> @@ -56,7 +57,7 @@ fn drop(&mut self) {
>      }
>  }
>  
> -impl<T, A> HrTimerPointer for Pin<Box<T, A>>
> +impl<T, A> HrTimerPointer<<T as HasHrTimer<T>>::Mode> for Pin<Box<T, A>>
>  where
>      T: 'static,
>      T: Send + Sync,
> @@ -66,7 +67,10 @@ impl<T, A> HrTimerPointer for Pin<Box<T, A>>
>  {
>      type TimerHandle = BoxHrTimerHandle<T, A>;
>  
> -    fn start(self, expires: Instant) -> Self::TimerHandle {
> +    fn start(
> +        self,
> +        expires: <<T as HasHrTimer<T>>::Mode as HrTimerExpireMode>::Expires,
> +    ) -> Self::TimerHandle {
>          // SAFETY:
>          //  - We will not move out of this box during timer callback (we pass an
>          //    immutable reference to the callback).
> 

