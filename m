Return-Path: <netdev+bounces-186748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86884AA0E95
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC983B153D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF732D29DC;
	Tue, 29 Apr 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRTUinlA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B32C17AE;
	Tue, 29 Apr 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936170; cv=none; b=NXTR3OSUpUU/Wdkpd34/eijqoeV4pLyz/ffwZcbtgMfQ0YqnA7TdzOJlug3m1Z4gwX+EqI19w6LMS8/cbnFZWWWhmxJhRD05KHcdlDIWuXMX9DrI99HPCHWvHH60JhuDyD5LeqsPqF8j9uM5kUcHDG2QcxOODBbnMyWhtxiY2NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936170; c=relaxed/simple;
	bh=Fjo7SXXhsO3fgXkYg77gSjxrqlP0ofEHk1fTSqv5NgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSBcA3+NWK5te1IR7NHySKdmUOWNXkDsE7DOspllthYSCWORZeKRcd1nyHDL42SBJMHGhAQ/1Qz5rkWJuyy0Zz+/CdeI2cr6Nujhtv8sOIGylDCL7ccXE9gZgd0M06t8PqI/H6sxicV5TLz4DBRM89fxLCfMlfDYRycJ7Ie4d1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRTUinlA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac3b12e8518so1028347466b.0;
        Tue, 29 Apr 2025 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745936166; x=1746540966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AS1sep8XsSLqx0Mlv2Ehtu5SaCFyrXvSF5bnyKYo9Rw=;
        b=NRTUinlAoQKQVqmvk9k5zGRR9IGNPybbvV6oiVVwR3XFouGbkzM4QBfUp6bPGz4z0x
         a+Gx/YpWQo73mRtYXRjgE8jilUhsC2neII5LrzqieJbhkUQnmYPrh+sRJGSxrIhGsSji
         v9/u5e0ChF/M5XgnFVdbUYbTW0NbkwOs1zolSrk38b9cpajlmXxpfpFWGwWT6biktIKx
         S40pdhpjdSW78MB6lWCP9vJ/2YMuKJlQUO0i7J3wjjXlITMUT0Ed9FRLoiTGT3xutw+z
         nWeXhFQhBQb9x7deyBd7hJ4kyS4hjTKTcbQnkFT3e7M0MHbhfBkhPs5NW8toKS5cqfpp
         25cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745936166; x=1746540966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AS1sep8XsSLqx0Mlv2Ehtu5SaCFyrXvSF5bnyKYo9Rw=;
        b=is4APmmh09OQQcMTczv/oiQ3/JM3eexUZ4T+g799ZlG/yMbqu+8F57If/4ULXMJ/fo
         S97yn830OOD+cgunTCBQvB4Djphok1ncdTvGqwB24xhNXJ3Ngcg9nIRvQHZ3LALVGg+t
         +GLqo+OM8anAZKx1lMWDCixmwgzSlZJNwTLOkQ6GhUkI1cbNHQNd7iJ+ZO1JC1T2ZI4m
         GHM9cxfeCLVwni5qxtrIWs7NoiFY4rWWEy2pjIGRfa0avo3ZKRIhLAYHJbzs1BifGVVS
         LT3HC+w3j34/0+PfW+ztKltregH6mjjzsFD9/DLbs1XQbQ1jS9BtULq2ocdiEo+9KugJ
         PFuA==
X-Forwarded-Encrypted: i=1; AJvYcCVYvJRdXVy9Q7u+z112MQBKwg4xnnt9G9jpGjVu/ZE20hDDiDvXR2X85sXW77H5KVyWZrhTQZdm4VvLlJ4=@vger.kernel.org, AJvYcCVhEVc6ZsO9MhmnLwVY5casRf1anXws1YBNHVjWbGEPoUXjmp3r80/GumMGS9aYhBJWfLSDCjWC@vger.kernel.org
X-Gm-Message-State: AOJu0YygB5OgQRnYx6WOjqZLI8J6tkxDoYuSewL6rSG7xjZ404dP5BvU
	m/QtQd3O8fHuwSrgMxoMw7R/rx4Ao0ab8Xk2Zo9LXfYcYfloUNvU
X-Gm-Gg: ASbGncsBqgwU5kYw4n8pnuTjm52mT8N06+r+9+NCetq0NoUxjE1BixEVNwv7Ba6dExN
	wrowW7bD2JfWpSPetZjuHXxommRcAVJv/KtmJv6X5f+Sh6Ol57AgGAq0ZVuFXbXPFYh8G03vinG
	+42XNRyQT+Q7oZbs52BCvqfr0EhsRQ4ev6VfqMSlyobX5GtcKnMOcF683lrpkYqnYlFtunIw1i6
	xiYN/TGoJJU+HnC3S6xIwwqM8a9OM6PbvE6dY+OydaadCEhXGoa9w5zPDmoj+UfWw8jS7Db71zk
	Ain5//JBlbTakclUZga3+ak8/mvhQfS85rWg45McXWyZxtFsW+nj
X-Google-Smtp-Source: AGHT+IHre+matt/IjaW7JAmHRwwQiOdzdio16HWgALdclq1dIRZFzRMJeCvhleSUIX++ascZvDE0MA==
X-Received: by 2002:a17:907:86ac:b0:abf:19ac:771 with SMTP id a640c23a62f3a-ace848c03c8mr1231291766b.2.1745936166035;
        Tue, 29 Apr 2025 07:16:06 -0700 (PDT)
Received: from [10.27.99.142] ([193.170.124.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf7397sm800699566b.92.2025.04.29.07.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:16:05 -0700 (PDT)
Message-ID: <03ccb65b-a5f8-4afc-84f5-e46f1caf96b0@gmail.com>
Date: Tue, 29 Apr 2025 16:16:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, a.hindborg@kernel.org
Cc: rust-for-linux@vger.kernel.org, gary@garyguo.net, aliceryhl@google.com,
 me@kloenk.dev, daniel.almeida@collabora.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com,
 david.laight.linux@gmail.com, boqun.feng@gmail.com, pbonzini@redhat.com,
 jfalempe@redhat.com, linux@armlinux.org.uk, linus.walleij@linaro.org
References: <6qQX4d2uzNlS_1BySS6jrsBgbZtaF9rsbHDza0bdk8rdArVf_YmGDTnaoo6eeNiU4U_tAg1-RkEOm2Wtcj7fhg==@protonmail.internalid>
 <20250423192857.199712-6-fujita.tomonori@gmail.com>
 <871ptc40ds.fsf@kernel.org>
 <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.04.25 3:17 PM, FUJITA Tomonori wrote:
> On Mon, 28 Apr 2025 20:16:47 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
> 
>> Hi Tomonori,
>>
>> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
>>
>>> Add a wrapper for fsleep(), flexible sleep functions in
>>> include/linux/delay.h which typically deals with hardware delays.
>>>
>>> The kernel supports several sleep functions to handle various lengths
>>> of delay. This adds fsleep(), automatically chooses the best sleep
>>> method based on a duration.
>>>
>>> sleep functions including fsleep() belongs to TIMERS, not
>>> TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
>>> abstraction for TIMEKEEPING. To make Rust abstractions match the C
>>> side, add rust/kernel/time/delay.rs for this wrapper.
>>>
>>> fsleep() can only be used in a nonatomic context. This requirement is
>>> not checked by these abstractions, but it is intended that klint [1]
>>> or a similar tool will be used to check it in the future.
>>
>> I get an error when building this patch for arm32:
>>
>>   + kernel-make -j 96 O=/home/aeh/src/linux-rust/test-build-arm-1.78.0 vmlinux modules
>>   ld.lld: error: undefined symbol: __aeabi_uldivmod
>>   >>> referenced by kernel.df165ca450b1fd1-cgu.0
>>   >>>               rust/kernel.o:(kernel::time::delay::fsleep) in archive vmlinux.a
>>   >>> did you mean: __aeabi_uidivmod
>>   >>> defined in: vmlinux.a(arch/arm/lib/lib1funcs.o)
>>
>> Looks like a division function of some sort is not defined. Can you
>> reproduce?
> 
> Ah, 64-bit integer division on 32-bit architectures.
> 
> I think that the DRM QR driver has the same problem:
> 
> https://lore.kernel.org/rust-for-linux/CANiq72ke45eOwckMhWHvmwxc03dxr4rnxxKvx+HvWdBLopZfrQ@mail.gmail.com/
> 
> It appears that there is still no consensus on how to resolve it. CC
> the participants in the above thread.

From what I remember from the thread is that generally 64 bit divisions
should be avoided (like the solution for DRM).

> I think that we can drop this patch and better to focus on Instant and
> Delta types in this merge window.
> 
> With the patch below, this issue could be resolved like the C side,
> but I'm not sure whether we can reach a consensus quickly.

I think adding rust bindings for this is fine (and most likely needed),
for cases where it is required.

> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 48143cdd26b3..c44d45960eb1 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -19,6 +19,7 @@
>  #include "io.c"
>  #include "jump_label.c"
>  #include "kunit.c"
> +#include "math64.c"
>  #include "mutex.c"
>  #include "page.c"
>  #include "platform.c"
> diff --git a/rust/helpers/math64.c b/rust/helpers/math64.c
> new file mode 100644
> index 000000000000..f94708cf8fcb
> --- /dev/null
> +++ b/rust/helpers/math64.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/math64.h>
> +
> +s64 rust_helper_div64_s64(s64 dividend, s64 divisor)
> +{
> +	return div64_s64(dividend, divisor);
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index de07aadd1ff5..d272e0b0b05d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -60,6 +60,7 @@
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
>  pub mod list;
> +pub mod math64;
>  pub mod miscdevice;
>  #[cfg(CONFIG_NET)]
>  pub mod net;
> diff --git a/rust/kernel/math64.rs b/rust/kernel/math64.rs
> new file mode 100644
> index 000000000000..523e47911859
> --- /dev/null
> +++ b/rust/kernel/math64.rs
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! 64-bit integer arithmetic helpers.
> +//!
> +//! C header: [`include/linux/math64.h`](srctree/include/linux/math64.h)
> +
> +/// Divide a signed 64-bit integer by another signed 64-bit integer.
> +#[inline]
> +pub fn div64_s64(dividend: i64, divisor: i64) -> i64 {
> +    // SAFETY: Calling `div64_s64()` is safe as long as `divisor` is non-zero.
The safety comment is not valid, nowhere is it guaranteed divisor is non-zero.

There's three solutions I can think of:
* Mark this function as `unsafe` and give the responsibility of checking
  this to the caller,
* return a `Result` with a division by zero error type or
* change the type of divisor to `NonZeroI64` [0].

Probably the best way is to use `NonZeroI64` since that way
it's statically guaranteed.

In that case it would also make sense to change `NSEC_PER_USEC` to be `NonZeroI64`.


Link: https://doc.rust-lang.org/nightly/core/num/type.NonZeroI64.html [0]
> +    unsafe { bindings::div64_s64(dividend, divisor) }

Is `s64` just a typedef for `int64_t` and if so this true for every
architecture? (I don't know the C side very well).

If not there might need to be some kind of conversion to make sure
they are passed correctly.

> +}
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 863385905029..7b5255893929 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -24,6 +24,8 @@
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>  
> +use crate::math64;
> +
>  pub mod delay;
>  pub mod hrtimer;
>  
> @@ -229,13 +231,16 @@ pub const fn as_nanos(self) -> i64 {
>      /// Return the smallest number of microseconds greater than or equal
>      /// to the value in the [`Delta`].
>      #[inline]
> -    pub const fn as_micros_ceil(self) -> i64 {
> -        self.as_nanos().saturating_add(NSEC_PER_USEC - 1) / NSEC_PER_USEC
> +    pub fn as_micros_ceil(self) -> i64 {
> +        math64::div64_s64(
It would make sense to change `NSEC_PER_USEC` to be `NonZeroI64`.

> +            self.as_nanos().saturating_add(NSEC_PER_USEC - 1),
> +            NSEC_PER_USEC,
> +        )
>      }
>  
>      /// Return the number of milliseconds in the [`Delta`].
>      #[inline]
> -    pub const fn as_millis(self) -> i64 {
> -        self.as_nanos() / NSEC_PER_MSEC
> +    pub fn as_millis(self) -> i64 {
> +        math64::div64_s64(self.as_nanos(), NSEC_PER_MSEC)
>      }
>  }
> 
> base-commit: da37ddd3f607897d039d82e6621671c3f7baa886

Cheers
Christian


