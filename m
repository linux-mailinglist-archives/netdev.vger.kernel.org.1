Return-Path: <netdev+bounces-139246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF879B124A
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18741F22690
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 22:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAC71CEE98;
	Fri, 25 Oct 2024 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsfHVAf7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C830217F2C;
	Fri, 25 Oct 2024 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893824; cv=none; b=a3YSjQ2+sOQRGP1rvHPrP/zE85O9L5baKWvUOnT576HxjXAkg4F5SjeHlUORtEDJ+ipDyR0nn+A4hesrhBu861pvqaceRiyLvIH7oL0jwWgoX/IQwECL+8yJwnFNUkOMP6k8jxKbDZhfStqIK1KwHsV4hU8YQfFgOWO4Pz3kPhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893824; c=relaxed/simple;
	bh=FOTLbL7gbW7YTtHMiRM1I70X/lPdVT4Cyr/dpLlXWgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8hQ4FiyY4FDnCYqPmwXgK2pXhzKyfi+GBBSMi/IW0Ka9/0sC3i3QA9Ko3oaoYyMoK4iFjwQbglo8bIOJFyd7A11E/oYVERVG8nI99yusk4oA0i4kjntn4fjYEyEdTbw0juWxsKbCvbIaNEM5of09EHcZ7Dp/CSlDDOKJRmaycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsfHVAf7; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460b16d4534so12649111cf.3;
        Fri, 25 Oct 2024 15:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729893821; x=1730498621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT5COGsxViqKRAdujVI1CBo0jutDQ8MfmHu6RZKf300=;
        b=LsfHVAf7yCd5k5G3EEDwXi4uyVvkSUFCyVcflnuaqgHoWICMqNwb9bh+b+VgPFDdwR
         2ysYGZC+RfYz7CUJqx/h9RPOB4id3KZ2HJn/KS7/RpeRUPJvnafTiFT40Vh9+46zGaQI
         Bc38WRUcYf1/lxGLsRXSPqrXiMvLvM8X8pSYBWfHtp0VuHKQ7wWSqBb6IyEHpfvns6uf
         zvE0ceWW24fLshjThhaMzqvSq7Hd7P1UWOm+lT/xP0gNfTADIybJ6v2CJtgOTkhdp/xN
         l3X87svaE3gyObKR+8ca1r+2j54N4xVThI5k1dlcGx6oGEf5iwJBourzPOtCOnqYKWx0
         w6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729893821; x=1730498621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JT5COGsxViqKRAdujVI1CBo0jutDQ8MfmHu6RZKf300=;
        b=DFr5kFV2jmlMcc7bihPeSnqYBTMqUNDiSFLikHrPO6ZSts9Mh18CqoMeoW1XPEXW+K
         yVAiyLtfEk9OgSMHggD+1IbJeDUpZTGUf4LZt5EHMyodck5SHSHw4pfLL+VzKbSa2Vm4
         p4NKqBiHiCeF6wk3dcdaZqT/Ru8bI1q6cfu6X8LyMvJP5lqWteHscLH2X9TIy+bBk4i2
         04QKKYCe25yYPG/U6apK4VfLsvHBLUSM2rAT+rajaIDQ8zBh3/FAq0ApiHMs51mDH1H9
         Zxz2dRgCcJYcUhddR77vdjuvYs1xeUmaAEdGQZXWjaR0LFNwlemPA9qsSEBzx5eTXrOt
         rQTw==
X-Forwarded-Encrypted: i=1; AJvYcCW8ISeT5MzORLG1jeB3kgh+7VxhXA31nj6xMZFB6dvSxAkIUX7MehnBYEqbu/Y7Vkiz9ojux4i3@vger.kernel.org, AJvYcCWTxGsLUcYibedImUD/U9opTiWxIO8eM4n1UFiLV2WwXp8adkjdnAYx9RN7erpF6Y/frUZUUDstz8sFf3E=@vger.kernel.org, AJvYcCXCgQUI0WwLfCXHpEfrd5nc5ptl/Oqg2JMvJB0dj3Ptbgbcle6IgaUDbmF60eO+kUmvgcHtwlTTVHAvDsVydDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5r4PiFr9Oet4nrbH9dvXxlep2tpzZHEplwiUiRL4AJ5Go3ujq
	doGo3WLD/VQbG69km2fZTbK/+S97P3AUHuTmIfao/+d3mZKt0GBBpaLK7g==
X-Google-Smtp-Source: AGHT+IFfvSEpk8tbWKhiexx3cSY8b2ZjrPMrXV0fEahdYXPYpGoYpmPb5mOS2mmhspGWWMBQJFIz/g==
X-Received: by 2002:a05:622a:54d:b0:460:b2ce:ce96 with SMTP id d75a77b69052e-4613c177337mr9454031cf.41.1729893820827;
        Fri, 25 Oct 2024 15:03:40 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613237f394sm10110511cf.65.2024.10.25.15.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 15:03:40 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 82AEF1200068;
	Fri, 25 Oct 2024 18:03:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 25 Oct 2024 18:03:39 -0400
X-ME-Sender: <xms:uxUcZzYxhY7zfrSCndYL7pFXUJX3f5URE3g4Ltc-HQC3V54qxmlP3g>
    <xme:uxUcZyaUqtKwMFwlx1JWOD9IYOHPvcVoeFU2-rKOMoPX8KuO53crmL0gNbiR7FrLh
    1vxYiE2eua3II_vhA>
X-ME-Received: <xmr:uxUcZ1-QI3IfrtnWaGvuSKQl1IbpBpABd1Rr4Qmb_iLL1RwcnT-Ft5CNUAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejfedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeevuefgjeeugfeuveeifeegjeetleffleegteek
    ueethfdvgfekgeffuefghfejffenucffohhmrghinheprhhushhtqdhfohhrqdhlihhnuh
    igrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonh
    grlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghnghep
    pehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddupd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhi
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnnhgrqdhmrghrihgrsehlihhnuhhtrh
    honhhigidruggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehjsh
    htuhhlthiisehgohhoghhlvgdrtghomhdprhgtphhtthhopehssghohigusehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:uxUcZ5o-UUs0Pe01KdXEw3y_1xWpIUaaYsd_x5_YWJ2NJZDrxd6mcg>
    <xmx:uxUcZ-rHEY4nYpTu-5sXpLU9S1tv_cosR8sjlxDwmy3nNZZI4o7bAQ>
    <xmx:uxUcZ_T2zC9gvKM31wpKJ0XgRAVOyjZ0y-p5HDIqDvMaHZ-pmrqAcA>
    <xmx:uxUcZ2rvsTNO_PXsqPrKGvbw_QFbyyGRJEa1Jh5IqqYEQfaUXdJa_w>
    <xmx:uxUcZ_74RIpdOOfPuT4syf-7MFTCfOvM29GPdr45ky6VxFZLn5odLHqZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 18:03:38 -0400 (EDT)
Date: Fri, 25 Oct 2024 15:03:37 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de
Subject: Re: [PATCH v4 4/7] rust: time: Add wrapper for fsleep function
Message-ID: <ZxwVuceNORRAI7FV@Boquns-Mac-mini.local>
References: <20241025033118.44452-1-fujita.tomonori@gmail.com>
 <20241025033118.44452-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025033118.44452-5-fujita.tomonori@gmail.com>

On Fri, Oct 25, 2024 at 12:31:15PM +0900, FUJITA Tomonori wrote:
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
>  rust/kernel/time/delay.rs | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 42 insertions(+), 1 deletion(-)
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
> index 3cc1a8a76777..cfc31f908710 100644
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
> index 000000000000..f80f35f50949
> --- /dev/null
> +++ b/rust/kernel/time/delay.rs
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Delay and sleep primitives.
> +//!
> +//! This module contains the kernel APIs related to delay and sleep that
> +//! have been ported or wrapped for usage by Rust code in the kernel.
> +//!
> +//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h).
> +
> +use crate::time;
> +use core::ffi::c_ulong;
> +
> +/// Sleeps for a given duration at least.
> +///
> +/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
> +/// which automatically chooses the best sleep method based on a duration.
> +///
> +/// The function sleeps infinitely (MAX_JIFFY_OFFSET) if `Delta` is negative
> +/// or exceedes i32::MAX milliseconds.
> +///

I know Miguel has made his suggestion:

	https://lore.kernel.org/rust-for-linux/CANiq72kWqSCSkUk1efZyAi+0ScNTtfALn+wiJY_aoQefu2TNvg@mail.gmail.com/

, but I think what we should really do here is just panic if `Delta` is
negative or exceedes i32::MAX milliseconds, and document clearly that
this function expects `Delta` to be in a certain range, i.e. it's the
user's responsibility to check. Because:

*	You can simply call schedule() with task state set properly to
	"sleep infinitely".

*	Most of the users of fsleep() don't need this "sleep infinitely"
	functionality. Instead, they want to sleep with a reasonable
	short time.

> +/// This function can only be used in a nonatomic context.
> +pub fn fsleep(delta: time::Delta) {
> +    // SAFETY: FFI call.
> +    unsafe {
> +        // Convert the duration to microseconds and round up to preserve
> +        // the guarantee; fsleep sleeps for at least the provided duration,
> +        // but that it may sleep for longer under some circumstances.
> +        bindings::fsleep(delta.as_micros_ceil() as c_ulong)

If delta is 0x10000_0000i64 * 1000_000 (=0xf424000000000i64), which
exceeds i32::MAX milliseconds, the result of `delta.as_micros_ceil() as
c_ulong` is:

*	0 on 32bit
*	0x3e800000000 on 64bit

, if I got my math right. The first is obviously not "sleeps
infinitely".

Continue on 64bit case, in C's fsleep(), 0x3e800000000 will be cast to
"int" (to call msleep()), which results as 0, still not "sleep
infinitely"?

Regards,
Boqun

> +    }
> +}
> -- 
> 2.43.0
> 
> 

