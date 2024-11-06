Return-Path: <netdev+bounces-142483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C0F9BF4F4
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2677B21812
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016DF207A36;
	Wed,  6 Nov 2024 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRPzPFUr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1232076DE;
	Wed,  6 Nov 2024 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916843; cv=none; b=NNJJ8Fq3Nne1S6jzGaJLUscxItwSF5pTTkB6fuuCOTTx8TQ6VyiHr43649QiISUh8bMbI+mFNRHx5UrxLcaDqLpYtmH6DgtKs39eA0Us6Aparwk7QML24/fGJYkrlbgJ0HQVqh5CTSD0Q+VeW7OskPVxkvbdv31urPK5vlN5Po0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916843; c=relaxed/simple;
	bh=SWOk01sSn5fcWujCF706YNaxwojISAUDKCKuNCysStw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnASYX2aiuEPJDswjMstM/jLt2nYCzmOWvomealFsfK37V4YM2C5PBLBBWDiPl/MjzJYT1KzjMfEK+Od+mp0bIe0iTkbbWDEDYOsvAG1ahCV0qkBGR/qR5xhWxbgEVgkJlq269BAvg18cuTvDAc62aRTRdOBHe3tCQ4P+6lvpTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRPzPFUr; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbf2fc28feso733656d6.0;
        Wed, 06 Nov 2024 10:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730916841; x=1731521641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87iZqhnI6xalUo1meCuWOUsEAO+KfuLV+7vVOEk+Izk=;
        b=VRPzPFUr8vx9E9GqpmDEEyc5nYWFYOmVdy9tl6yCB2XUBzeDYORWtO9YttvChLLyKc
         Ab5RxkUzrM3xBh3UrQIHqJsZgLWFBA62Gkpx/ZP+CyUjwfJx32k4C0CFmUlwgq7047B5
         5nBtUORZ3WYBWBVS75yJeHb8mFyR00ShrfjpsFtH9tFFSdTlRrIQyqXKHOa/ZBouMCyS
         igy7l7g46oDoTM7AlI1aDtTE05d4eZgJ5pihg+VdH+GCh9eEiUhSD5QA7bh/uF/K1INv
         8AT42S8/fXGGPIKGxdESFreSf6a1MuC0iv8XLFwja9DrljAUFjyOcR0Lsr7BPKJDGGk9
         pBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730916841; x=1731521641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87iZqhnI6xalUo1meCuWOUsEAO+KfuLV+7vVOEk+Izk=;
        b=VdGRRNjOLF7WM0H7dBFjU5jhsauqBKZmJk04E6orrAVMAqNHh75It9TCa8Sm4IwWPl
         CbjJNphRYVTzhEtSKYLWLfUDmt/Szts3mXJJVjolFYwusO0PorTyhfv/P1BqfuijBzcZ
         s/jswYVSbNCSWCpPMW7OCCctkN4lFkCUhvm75cz/Nv9whCVxgmfg3TzaWgzqkpdbK1M8
         0WOOq1FVmRxEfdYJ0vy0LYmypfj8lKCnDBH/NeP39XJ0vl4M/nsWSasv535LUR7dYtVq
         XmW5idBoEBa2tvMYQol+YMZS6N0TBbreWfil4XNsyAIYG10bjm2A1vq0gKsn/oXg1ecp
         4/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUi8y4iyiBuR2kAsGz1hToebpV3NPoLwuWA2PxayJHCxkJq/TKIUDMT3aWOLc3t1qxzuGzQwdlcXIGjphRtlFs=@vger.kernel.org, AJvYcCVGoTWkyfuVbu0xiloOkTT7qhQkcwnjpd7Di/zOmUUwdFK+qwX7Tptsq6S8S1cEP9NhRD26EAMH@vger.kernel.org, AJvYcCXG7SsI2g9zLZx8FaorA7KepJvY7yo443TgktEZpLsKykgut2pcstcghmK2NpsmCdktmL7dcMaOHdoDPMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFVopdZCDGppJR+vAQ4EdGqQ3s7niOCIHVZQZ3SyyANAy9hRt/
	TdHaiqkwNQYTASE4DCy/G02AXjm3movdedhZlW2mcv+mh+5dAyBX
X-Google-Smtp-Source: AGHT+IELmHNOBqTODCZEVDIbuggwbEra42wa6wcQaohzH1OeZQt39OEQO8TXd+RI+rVEN72j5Tk+kg==
X-Received: by 2002:a05:6214:5543:b0:6cc:37bb:40b with SMTP id 6a1803df08f44-6d185841246mr687937996d6.37.1730916840901;
        Wed, 06 Nov 2024 10:14:00 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353f9ef91sm75169446d6.4.2024.11.06.10.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:14:00 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9B9C21200070;
	Wed,  6 Nov 2024 13:13:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 06 Nov 2024 13:13:59 -0500
X-ME-Sender: <xms:57ErZ1UHjSQaqi-7Kmff2C-nu4iAAQGtBxVGu3S1rPtwjCTx6w8w6w>
    <xme:57ErZ1mZ9ASoK6nzy3NgG1bHgr98fUXitnEN75PphOuFZLTxphTu3cBow2rVI6wXB
    uI8GK7NayAuoa9qbg>
X-ME-Received: <xmr:57ErZxaZV2Gd43Uos5xWUaunOeAEy2r2BDoq7VyjEfyKPU9gEOOeJUEgfZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeevieeujefgtdetveevieevudegvefhvddvkeei
    vefhgfejgedtgedvhfekveeufeenucffohhmrghinheprhhushhtqdhfohhrqdhlihhnuh
    igrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghe
    dtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhes
    fhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdp
    rhgtphhtthhopegrnhhnrgdqmhgrrhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtph
    htthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhig
    sehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepjhhsthhulhhtiiesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhu
    shhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:57ErZ4VeAZ9REZ3c305-p18plbt7l4R8479YUjtbyO6wAOa8qLZa4w>
    <xmx:57ErZ_mAYKMNlwaGnuSz1-5QY-mJy_8fwkwQOtbPs7YTuWk5LJOzJg>
    <xmx:57ErZ1c8aZgqyu5CKRaRIuttOb_pCX1qJfTt2iaznVnwzehoT3XRfQ>
    <xmx:57ErZ5Fs1vU7LwKyHlimKPUPcJ13Crnb7OB0TnV0koSUko2hahKbTg>
    <xmx:57ErZ5lMMy6JWdgya1NzO_-h6LJ-48HWbWIjeBErvQPnMzTnYu0E4ZSQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 13:13:59 -0500 (EST)
Date: Wed, 6 Nov 2024 10:13:57 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de
Subject: Re: [PATCH v5 4/7] rust: time: Add wrapper for fsleep function
Message-ID: <Zyux5d33Kt6qFdaH@Boquns-Mac-mini.local>
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
 <20241101010121.69221-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101010121.69221-5-fujita.tomonori@gmail.com>

On Fri, Nov 01, 2024 at 10:01:18AM +0900, FUJITA Tomonori wrote:
> Add a wrapper for fsleep, flexible sleep functions in
> `include/linux/delay.h` which typically deals with hardware delays.
> 
> The kernel supports several `sleep` functions to handle various
> lengths of delay. This adds fsleep, automatically chooses the best
> sleep method based on a duration.
> 
> `sleep` functions including `fsleep` belongs to TIMERS, not
> TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
> abstraction for TIMEKEEPING. To make Rust abstractions match the C
> side, add rust/kernel/time/delay.rs for this wrapper.
> 
> fsleep() can only be used in a nonatomic context. This requirement is
> not checked by these abstractions, but it is intended that klint [1]
> or a similar tool will be used to check it in the future.
> 
> Link: https://rust-for-linux.com/klint [1]
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers/helpers.c    |  1 +
>  rust/helpers/time.c       |  8 ++++++++
>  rust/kernel/time.rs       |  4 +++-
>  rust/kernel/time/delay.rs | 43 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 55 insertions(+), 1 deletion(-)
>  create mode 100644 rust/helpers/time.c
>  create mode 100644 rust/kernel/time/delay.rs
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 30f40149f3a9..c274546bcf78 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -21,6 +21,7 @@
>  #include "slab.c"
>  #include "spinlock.c"
>  #include "task.c"
> +#include "time.c"
>  #include "uaccess.c"
>  #include "wait.c"
>  #include "workqueue.c"
> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
> new file mode 100644
> index 000000000000..7ae64ad8141d
> --- /dev/null
> +++ b/rust/helpers/time.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/delay.h>
> +
> +void rust_helper_fsleep(unsigned long usecs)
> +{
> +	fsleep(usecs);
> +}
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index e4f0a0f34d6d..9395739b51e0 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -2,12 +2,14 @@
>  
>  //! Time related primitives.
>  //!
> -//! This module contains the kernel APIs related to time and timers that
> +//! This module contains the kernel APIs related to time that
>  //! have been ported or wrapped for usage by Rust code in the kernel.
>  //!
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>  
> +pub mod delay;
> +
>  /// The number of nanoseconds per microsecond.
>  pub const NSEC_PER_USEC: i64 = bindings::NSEC_PER_USEC as i64;
>  
> diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
> new file mode 100644
> index 000000000000..c3c908b72a56
> --- /dev/null
> +++ b/rust/kernel/time/delay.rs
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Delay and sleep primitives.
> +//!
> +//! This module contains the kernel APIs related to delay and sleep that
> +//! have been ported or wrapped for usage by Rust code in the kernel.
> +//!
> +//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h).
> +
> +use crate::time::Delta;

Nit: I think it's better to use:

use super::Delta;

here to refer a definition in the super mod.

> +use core::ffi::c_ulong;
> +
> +/// Sleeps for a given duration at least.
> +///
> +/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
> +/// which automatically chooses the best sleep method based on a duration.
> +///
> +/// `delta` must be 0 or greater and no more than u32::MAX / 2 microseconds.

Adding backquotes on "u32::MAX / 2" would make it easier to read and
generates better documentation. For example.

/// `delta` must be 0 or greater and no more than `u32::MAX / 2` microseconds.


> +/// If a value outside the range is given, the function will sleep
> +/// for u32::MAX / 2 microseconds at least.

Same here.

I would also add the converted result in seconds of `u32::MAX / 2`
microseconds to give doc readers some intuitions, like:

the function will sleep for `u32::MAX / 2` (= ~2147 seconds or ~36
minutes) at least.

> +///
> +/// This function can only be used in a nonatomic context.
> +pub fn fsleep(delta: Delta) {
> +    // The argument of fsleep is an unsigned long, 32-bit on 32-bit architectures.
> +    // Considering that fsleep rounds up the duration to the nearest millisecond,
> +    // set the maximum value to u32::MAX / 2 microseconds.
> +    const MAX_DURATION: Delta = Delta::from_micros(u32::MAX as i64 >> 1);
> +
> +    let duration = if delta > MAX_DURATION || delta.as_nanos() < 0 {

I think it would be helpful if `Delta` has a `is_negative()` function.

The rest looks good to me. Thanks!

Regards,
Boqun

> +        // TODO: add WARN_ONCE() when it's supported.
> +        MAX_DURATION
> +    } else {
> +        delta
> +    };
> +
> +    // SAFETY: FFI call.
> +    unsafe {
> +        // Convert the duration to microseconds and round up to preserve
> +        // the guarantee; fsleep sleeps for at least the provided duration,
> +        // but that it may sleep for longer under some circumstances.
> +        bindings::fsleep(duration.as_micros_ceil() as c_ulong)
> +    }
> +}
> -- 
> 2.43.0
> 
> 

