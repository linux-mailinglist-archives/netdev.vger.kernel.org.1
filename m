Return-Path: <netdev+bounces-186741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFB5AA0D4F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45B846018F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 13:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D052D1931;
	Tue, 29 Apr 2025 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j47b98Xv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472B2C2ABC;
	Tue, 29 Apr 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745932675; cv=none; b=Vp4MMXgTlLm6/sELn5NGqJKPAlEWWHHh2fb1p3J5eCPs0mWFJA379rn4RcZ+Ov9C+nvUuVZgxRUoQXEoDJHp+9NMpO/8kabT4+MetRCbYi78q51KFqyBysXZHtm9pqmYM7K+s8r1PI7VC3LQm+mY2PM1/ld/B92HypQRlZny9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745932675; c=relaxed/simple;
	bh=13u4nULt1pp3rMM9Q+ih5iWZwsTcc4n3mmfV8mtcU1c=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=e0NaVtPhjEhuC67wi9bVN1HYU7juuEPAGtFroKvvhghodvpootvaRaUKxjdNsgdiueRr7UXyiIHsLGOUv2n+DZ+4Ec6eNGVD5d0ghGiwQxn5CMI9tnn/Q54wVuhW3JUNwMUWhDUKl+oLbCE99HyuRjJIerR5uSZlAhKjG+j3gqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j47b98Xv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-301cda78d48so7478426a91.0;
        Tue, 29 Apr 2025 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745932673; x=1746537473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fFyGhsYuAsCKMmGCS1jhd9ZOFAOyHJ81xtQ8hlgOHo=;
        b=j47b98XvD2VXbioZRaNM/hQachrh/+V+t+ZqX0iR37IsZm401mSH+h5hdFcNEhgQdL
         URvDhcU/irpZwDJYDd2iGhhQ+93U46tGoT+CTpLp0WhLNoHBZVVCcy/5EowKkyg2iUB1
         CwgOiEEjzpqIX+5S9fC69p0QBj+OitrqNNfAjXftZS0bLnv4ax7tb1WRgmhapK3PqA0m
         L3csS0B1iPrR0EjzucX8AH/VoxSFogsLhMRVu/yYYPLlN6NjdUbmM1UO1m8qcpUb38qC
         ZhNgsVd/3qYNXKK1y8RbJqY3YPrQRBXqhlAta+oPgjBot+8zMSARPrj7zt1EY5q5AmJw
         r+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745932673; x=1746537473;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6fFyGhsYuAsCKMmGCS1jhd9ZOFAOyHJ81xtQ8hlgOHo=;
        b=NUFTn72R0KRRL5pvMlchE7XQXwn5/acPiqcHKhhVmIlyVkjF54WpMiFWagWtfF1yYg
         Te7r6EyYoCcJGBhma/EKapdRmVUhTMaJjIQwHndz8kMpaSUZ0SEliRbFn4NzsPSU7Ozb
         9v9iANcUDRd4Wq7SyFY7gWCdf7RsJ/CRWdtgz2ywQgfTSZuMQd/6hP5647+Ze74VAUeW
         lmb1ubsRFE0HXRSely34mG0BPppJT0+0KU1YbNtiqixrFwyo1jf7CNUr8ZmyBppsa7Da
         XHdrxh0mNwbCLsl1o6awSLf747npeup8L0fy3/OtUrKvYlG0CJu4mBeb0hKreGbqvuz4
         GCsA==
X-Forwarded-Encrypted: i=1; AJvYcCVr0m5X8UEY26UnAsZEC4XoD4VrBb6Rp6HLVzBFBirR1Q1hCjKi+2qfpyFu2T2cvdb5ifBUcGkO@vger.kernel.org, AJvYcCXHoYoCyKlqhKIX2uXCahNY24eVId7/+c6Uvlyvr05oBD9iLyMl82hWxwKeNRQDrES3yOf5j1FD+O+HBzA=@vger.kernel.org, AJvYcCXbgWx1j5MtPArSo9fbWxLHOxoMs28xtfID7LYWQWzbQWS4nFyJc0a7IX7MnpESplXMTMK9lRAKzBBMjaKm3RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzYrmXu1m8ponS69fsqMBr2zl22fYfMkmyTL2Td7vVhr7GWyq
	YtU3zDfB1UCPZt9ay2HVsGnScnsfETdYSN3HORXPJRei2yGusAPQ
X-Gm-Gg: ASbGnct8A+Krk5YLWg9A+F0PNh7Y402mg808BYejiHGvWqwUvlEGFps7cC9GSf8vEal
	K/SP4nqNJ7TwEYFmdy8LmJJJOY81uX6LWCEbbpE+Cf3sR3EylSj+BADiUPG13kU8OBRhofK7KSw
	bQwWim+1DwWHwuY/b/BvDXxidFFk49nSvTYKwjTktT/75sP/UEyf3T3dgpP+EzLypJsH6/fqH0t
	UoiDiZiIZHXg7G1ZCO9wzFBPqr2So8O6n+graRs2PubMIFOtAcjpuN4dQMaFU60bjqNma3Q7hsy
	+OUObpQpKMkg1eBhtSzhBSyGUHKZh0ycH812v3YJxCwfCrapQu2pU6o1uMswhZYkFsATvRdVjZI
	GUzIivOY62dEK0b3t0dte0i8=
X-Google-Smtp-Source: AGHT+IEbS4hdKtSzuo6oEZXKv47QnIuQs8efH07eWwnFKokvGzRUKI31iJKMmkahZfUtYQNLwUrycg==
X-Received: by 2002:a17:90a:d644:b0:2fc:3264:3657 with SMTP id 98e67ed59e1d1-30a214bcad9mr6765939a91.0.1745932673157;
        Tue, 29 Apr 2025 06:17:53 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f78486e5sm9293315a91.40.2025.04.29.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:17:52 -0700 (PDT)
Date: Tue, 29 Apr 2025 22:17:33 +0900 (JST)
Message-Id: <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: fujita.tomonori@gmail.com, rust-for-linux@vger.kernel.org,
 gary@garyguo.net, aliceryhl@google.com, me@kloenk.dev,
 daniel.almeida@collabora.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com,
 david.laight.linux@gmail.com, boqun.feng@gmail.com, pbonzini@redhat.com,
 jfalempe@redhat.com, linux@armlinux.org.uk, chrisi.schrefl@gmail.com,
 arnd@arndb.de, linus.walleij@linaro.org
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <871ptc40ds.fsf@kernel.org>
References: <6qQX4d2uzNlS_1BySS6jrsBgbZtaF9rsbHDza0bdk8rdArVf_YmGDTnaoo6eeNiU4U_tAg1-RkEOm2Wtcj7fhg==@protonmail.internalid>
	<20250423192857.199712-6-fujita.tomonori@gmail.com>
	<871ptc40ds.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 20:16:47 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> Hi Tomonori,
> 
> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
> 
>> Add a wrapper for fsleep(), flexible sleep functions in
>> include/linux/delay.h which typically deals with hardware delays.
>>
>> The kernel supports several sleep functions to handle various lengths
>> of delay. This adds fsleep(), automatically chooses the best sleep
>> method based on a duration.
>>
>> sleep functions including fsleep() belongs to TIMERS, not
>> TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
>> abstraction for TIMEKEEPING. To make Rust abstractions match the C
>> side, add rust/kernel/time/delay.rs for this wrapper.
>>
>> fsleep() can only be used in a nonatomic context. This requirement is
>> not checked by these abstractions, but it is intended that klint [1]
>> or a similar tool will be used to check it in the future.
> 
> I get an error when building this patch for arm32:
> 
>   + kernel-make -j 96 O=/home/aeh/src/linux-rust/test-build-arm-1.78.0 vmlinux modules
>   ld.lld: error: undefined symbol: __aeabi_uldivmod
>   >>> referenced by kernel.df165ca450b1fd1-cgu.0
>   >>>               rust/kernel.o:(kernel::time::delay::fsleep) in archive vmlinux.a
>   >>> did you mean: __aeabi_uidivmod
>   >>> defined in: vmlinux.a(arch/arm/lib/lib1funcs.o)
> 
> Looks like a division function of some sort is not defined. Can you
> reproduce?

Ah, 64-bit integer division on 32-bit architectures.

I think that the DRM QR driver has the same problem:

https://lore.kernel.org/rust-for-linux/CANiq72ke45eOwckMhWHvmwxc03dxr4rnxxKvx+HvWdBLopZfrQ@mail.gmail.com/

It appears that there is still no consensus on how to resolve it. CC
the participants in the above thread.

I think that we can drop this patch and better to focus on Instant and
Delta types in this merge window.

With the patch below, this issue could be resolved like the C side,
but I'm not sure whether we can reach a consensus quickly.

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 48143cdd26b3..c44d45960eb1 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -19,6 +19,7 @@
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
+#include "math64.c"
 #include "mutex.c"
 #include "page.c"
 #include "platform.c"
diff --git a/rust/helpers/math64.c b/rust/helpers/math64.c
new file mode 100644
index 000000000000..f94708cf8fcb
--- /dev/null
+++ b/rust/helpers/math64.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/math64.h>
+
+s64 rust_helper_div64_s64(s64 dividend, s64 divisor)
+{
+	return div64_s64(dividend, divisor);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index de07aadd1ff5..d272e0b0b05d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -60,6 +60,7 @@
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 pub mod list;
+pub mod math64;
 pub mod miscdevice;
 #[cfg(CONFIG_NET)]
 pub mod net;
diff --git a/rust/kernel/math64.rs b/rust/kernel/math64.rs
new file mode 100644
index 000000000000..523e47911859
--- /dev/null
+++ b/rust/kernel/math64.rs
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! 64-bit integer arithmetic helpers.
+//!
+//! C header: [`include/linux/math64.h`](srctree/include/linux/math64.h)
+
+/// Divide a signed 64-bit integer by another signed 64-bit integer.
+#[inline]
+pub fn div64_s64(dividend: i64, divisor: i64) -> i64 {
+    // SAFETY: Calling `div64_s64()` is safe as long as `divisor` is non-zero.
+    unsafe { bindings::div64_s64(dividend, divisor) }
+}
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 863385905029..7b5255893929 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -24,6 +24,8 @@
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
+use crate::math64;
+
 pub mod delay;
 pub mod hrtimer;
 
@@ -229,13 +231,16 @@ pub const fn as_nanos(self) -> i64 {
     /// Return the smallest number of microseconds greater than or equal
     /// to the value in the [`Delta`].
     #[inline]
-    pub const fn as_micros_ceil(self) -> i64 {
-        self.as_nanos().saturating_add(NSEC_PER_USEC - 1) / NSEC_PER_USEC
+    pub fn as_micros_ceil(self) -> i64 {
+        math64::div64_s64(
+            self.as_nanos().saturating_add(NSEC_PER_USEC - 1),
+            NSEC_PER_USEC,
+        )
     }
 
     /// Return the number of milliseconds in the [`Delta`].
     #[inline]
-    pub const fn as_millis(self) -> i64 {
-        self.as_nanos() / NSEC_PER_MSEC
+    pub fn as_millis(self) -> i64 {
+        math64::div64_s64(self.as_nanos(), NSEC_PER_MSEC)
     }
 }

base-commit: da37ddd3f607897d039d82e6621671c3f7baa886
-- 
2.43.0


