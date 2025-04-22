Return-Path: <netdev+bounces-184693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5861EA96E34
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDF5188CE3E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C512281351;
	Tue, 22 Apr 2025 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrFHVoPx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3097188A3A;
	Tue, 22 Apr 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331571; cv=none; b=fogR1BzdOURLm9zQRUAjq4qaNEQ73zzy3XyN+zQFpHrK9KN4Y72TjF7uerxG7y6+3JQes6SCRpYlz4z9bL1WmPPm3mnnVo9YbW9+p5e9zoAtfiOLz6+EambWQ6Ak9T64tz6gW/lo5zvxALRq99oklsKYed2RRRrUQNQOtTeKiyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331571; c=relaxed/simple;
	bh=sTvn2SNQ+ZpniSh/FDJBNpGSM6rarHUX5zKO2AGg8PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCxD0YkJPigwt6IgDJFrsE5gK8kAHZ9LtUBQqDs7VRQ9ns8ea7I0zlVH2F04+Qfeje0OIZZH/AS68ZLHl0lbKbxrRNMvNDFxBhbokXccDSMKM8u1O8hoJM4W+M3I5qT9JPLM0n7JCKs+m8laYurQBm901I+XPRqLs9gbo+UvsnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrFHVoPx; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ecfc7fb2aaso47987966d6.0;
        Tue, 22 Apr 2025 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745331569; x=1745936369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5Wm7tWJGtPPpr9hk/vOfHw1mqCFRXfEN5VZTQ6ISoQ=;
        b=lrFHVoPxYVbtDbJdS8K2L1bZ4mEZWdyl2HihfNiLOAQli4qWD4VswSNqZW/han81Vd
         xU5SOuDgAcJDrPJMCJDWMGv9+110TCHNlTcNBlmP2T6Vbc07NPZdR1JKtU5JexydimDx
         XKhsF2FdB7GSUrdSL48BHk3HHRbMFCYgBfYRaX0Lywg0kRULPHdLOvs4iN2HCf5uU0dt
         DI9x1z8/4EabFbchCb6iE8DSj8Mfw3AU2npDvulqLqOFJN1xedK7yoA87bJwJChJ8A8v
         SQYSrHpXfOhSBPa6rwkQzjWDe9qIzHGp+W3cYxV8XV/LHs+vWRANUmdjzLqeEoAKbm+l
         GJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745331569; x=1745936369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5Wm7tWJGtPPpr9hk/vOfHw1mqCFRXfEN5VZTQ6ISoQ=;
        b=cwaoNHzs1dyAPbri/F23la8bFQqnBBkKFk8PVtZ/igVW72wL9b3bx+kOgo5IAa0Zfu
         Wn55Hc43ZEWPoHmr1XD/skh5ZmGofWTHVA60h7+lh7+3L3UmfPyKWHt5kcZvPYHBUrlg
         s+ag+OgCPY+9MLkRD9fxWNHY8gj39bxXgBYFFXM070bw8bwFkMJcp0NJ7fFbxG5fH5t2
         O9j4O0R9QmzhRRvkqvaAM8bruUuowLrQRVSA/cSX/BB/y3A+5KrRhr20ybV8fugRdiwT
         9PiyCpi3YBcZmFZbKRYh0MSB+IItE6ew6Q+AtQe9Pfo1A3aOKiy0AoJirFWs1AtI/sq/
         yRrw==
X-Forwarded-Encrypted: i=1; AJvYcCVKsDfm7yzKhVYZOhMpi+hEcAquxjUUi3/qzC5BKBGQ4mU2cb8zFlO9M69v9ahztFq5ebwsxSrJ@vger.kernel.org, AJvYcCXOrT/WiDkPFqYyJm9ccoB4KOO/qqmkHmx8FeS+02rg6qmzwKg3Ld3DG8TPpGLfjnc+Ht3NBxgLgGsDHQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjAVpB1hkTWVj6MOApIVeqbyplerRD2M6q4p9W4F0khuLCdd/Y
	BoBQ9XlWIu9frAAUKVF+3PPstqTi873Hls0l3DCFIgUtEv5rBl2X
X-Gm-Gg: ASbGncvrvy+m1+CvyYYLmAC1PaOLW8akUJahXAKy80rvbEDQdmsmxx//R0adMQNNnI9
	ios3O31Fx8+9PQ3iiK9HxpTRtZOS3+kQZ5yHwK2eOS0t4WoCtEOGaM0Ysi3EsinRnxZY/+vZTKv
	7qXdNeTYgseCEL5f5RviahqSd1hF0maynwLWjVBLZ/qeA4ebDtSpN7MMTZ/DzFA3gQa/9It1VRG
	i9dpEjGNTdBAEZwIfBQbbT5E8jO++Ug0/3fQa+Wat+rG3SQKRR8n8E/cOLWez7ZlKgQeWjIymzy
	QqkXSmoHx0GdT4TSc4EQncMUmdORtqXt6qTjTGI0UUNXwzI2JnaBPWuAL+Y/di4njMyZN7g6dR5
	F3M4vaOjLgk0Tf0OGXQ7cWR131VJ0dkdEsDHnnZAqTQ==
X-Google-Smtp-Source: AGHT+IE73CW+oCiynw5eX4Psiy4DGeXeUQENMFdsM01Wevqr+m1bEw12kjylzjeOE7o9qLk2uljBkg==
X-Received: by 2002:ad4:5ae8:0:b0:6e6:6964:ca77 with SMTP id 6a1803df08f44-6f2c4678e76mr304643956d6.28.1745331568633;
        Tue, 22 Apr 2025 07:19:28 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2bfcdf9sm58271506d6.89.2025.04.22.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:19:28 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7800A1200069;
	Tue, 22 Apr 2025 10:19:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 22 Apr 2025 10:19:27 -0400
X-ME-Sender: <xms:b6UHaObS8bqCAF0eLA4xD4BzbVAGQ6MQTBHkmc596-F-dHt8EwR9dg>
    <xme:b6UHaBaMbwQr7IfoV6GVz5lZFxXp_iq9kNC5rPQ8cZGngIMCDczNIxwyxdgWKnint
    eeo3TAUE8cYVfaAUg>
X-ME-Received: <xmr:b6UHaI_BAkvsonWwGyE7yCGjNqKf2UjdKHtThws7pTSqyiss1C-E34DJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpth
    htohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmghhr
    ohhsshesuhhmihgthhdrvgguuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:b6UHaApQyiB_Ya9LCpQ59oyMydlELRDSsEp69_IimhPbED-C0xvvOQ>
    <xmx:b6UHaJrUiGuNG2qMONQqxNzjsYZzoek52OFIPx7VrPy7v8G3NAT13Q>
    <xmx:b6UHaOR9I8Pj80gQAKhaV6ICLu7MemOhKuwh_r2AdLHt_AAXvHBJsg>
    <xmx:b6UHaJoDBTLBh3xeZJOuGelMRcjjmfwKEVC8wvljW0NrGFPwDDwGdg>
    <xmx:b6UHaG6xB7R7gOguso5Eh6x2xGr04SuzEf6iM0oyQt7_YsqMPaydgjUT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 10:19:26 -0400 (EDT)
Date: Tue, 22 Apr 2025 07:19:25 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v14 1/6] rust: hrtimer: Add Ktime temporarily
Message-ID: <aAelbeiWVZgL-kMh@Mac.home>
References: <20250422135336.194579-1-fujita.tomonori@gmail.com>
 <20250422135336.194579-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422135336.194579-2-fujita.tomonori@gmail.com>

On Tue, Apr 22, 2025 at 10:53:30PM +0900, FUJITA Tomonori wrote:
> Add Ktime temporarily until hrtimer is refactored to use Instant and
> Duration types.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

(Tomo: seems you didn't add me Cced in a few patches, could you add me
Cced for all the patches in the future, thanks!)

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/kernel/time/hrtimer.rs         | 18 +++++++++++++++++-
>  rust/kernel/time/hrtimer/arc.rs     |  2 +-
>  rust/kernel/time/hrtimer/pin.rs     |  2 +-
>  rust/kernel/time/hrtimer/pin_mut.rs |  4 ++--
>  rust/kernel/time/hrtimer/tbox.rs    |  2 +-
>  5 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index ce53f8579d18..9fd95f13e53b 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -68,10 +68,26 @@
>  //! `start` operation.
>  
>  use super::ClockId;
> -use crate::{prelude::*, time::Ktime, types::Opaque};
> +use crate::{prelude::*, types::Opaque};
>  use core::marker::PhantomData;
>  use pin_init::PinInit;
>  
> +/// A Rust wrapper around a `ktime_t`.
> +// NOTE: Ktime is going to be removed when hrtimer is converted to Instant/Duration.
> +#[repr(transparent)]
> +#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
> +pub struct Ktime {
> +    inner: bindings::ktime_t,
> +}
> +
> +impl Ktime {
> +    /// Returns the number of nanoseconds.
> +    #[inline]
> +    pub fn to_ns(self) -> i64 {
> +        self.inner
> +    }
> +}
> +
>  /// A timer backed by a C `struct hrtimer`.
>  ///
>  /// # Invariants
> diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
> index 4a984d85b4a1..ccf1e66e5b2d 100644
> --- a/rust/kernel/time/hrtimer/arc.rs
> +++ b/rust/kernel/time/hrtimer/arc.rs
> @@ -5,10 +5,10 @@
>  use super::HrTimerCallback;
>  use super::HrTimerHandle;
>  use super::HrTimerPointer;
> +use super::Ktime;
>  use super::RawHrTimerCallback;
>  use crate::sync::Arc;
>  use crate::sync::ArcBorrow;
> -use crate::time::Ktime;
>  
>  /// A handle for an `Arc<HasHrTimer<T>>` returned by a call to
>  /// [`HrTimerPointer::start`].
> diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
> index f760db265c7b..293ca9cf058c 100644
> --- a/rust/kernel/time/hrtimer/pin.rs
> +++ b/rust/kernel/time/hrtimer/pin.rs
> @@ -4,9 +4,9 @@
>  use super::HrTimer;
>  use super::HrTimerCallback;
>  use super::HrTimerHandle;
> +use super::Ktime;
>  use super::RawHrTimerCallback;
>  use super::UnsafeHrTimerPointer;
> -use crate::time::Ktime;
>  use core::pin::Pin;
>  
>  /// A handle for a `Pin<&HasHrTimer>`. When the handle exists, the timer might be
> diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
> index 90c0351d62e4..6033572d35ad 100644
> --- a/rust/kernel/time/hrtimer/pin_mut.rs
> +++ b/rust/kernel/time/hrtimer/pin_mut.rs
> @@ -1,9 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  use super::{
> -    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, RawHrTimerCallback, UnsafeHrTimerPointer,
> +    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, Ktime, RawHrTimerCallback,
> +    UnsafeHrTimerPointer,
>  };
> -use crate::time::Ktime;
>  use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
>  
>  /// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the timer might
> diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
> index 2071cae07234..29526a5da203 100644
> --- a/rust/kernel/time/hrtimer/tbox.rs
> +++ b/rust/kernel/time/hrtimer/tbox.rs
> @@ -5,9 +5,9 @@
>  use super::HrTimerCallback;
>  use super::HrTimerHandle;
>  use super::HrTimerPointer;
> +use super::Ktime;
>  use super::RawHrTimerCallback;
>  use crate::prelude::*;
> -use crate::time::Ktime;
>  use core::ptr::NonNull;
>  
>  /// A handle for a [`Box<HasHrTimer<T>>`] returned by a call to
> -- 
> 2.43.0
> 
> 

