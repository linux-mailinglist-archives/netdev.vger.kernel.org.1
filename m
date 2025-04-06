Return-Path: <netdev+bounces-179447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81A1A7CC77
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 03:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36091776E2
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 01:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DD53AC1C;
	Sun,  6 Apr 2025 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btwZxAxO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E5145B27;
	Sun,  6 Apr 2025 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743903333; cv=none; b=SUTGVuX6OYp61kS2QYHHLb7lfFFCV46FN/4r/O+SHwk81uGNKqJNUGffFzYkog5ALF2r31ZE0Zm3LxaFzQHUlURxXaDa/NffZu8FthS6QjFiS6g5FTgtNesQzYEGhGSeP0sXjthPnaM42d5MRsv5utWjBRU+LRrtD2m85SaI1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743903333; c=relaxed/simple;
	bh=12o8EpFplw5vxKVaPZGoT3TplIy82zwNzBv2WcTOE8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYcqmBCDxXLi4VWID7diBfoPMI6crGlxs1Oeo7Lfie9/ys3YfWDxE/GY9QDynUahVm9Jzi+nzwhSTXyBTHtik1ptksoOqJaPgvl/DBb1SBXEbUS0KpBPGCBk7DDjZXNWa143lPLvAhb3rH1mNnkM4yg3dqL1S1B7QjpMW3FEv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btwZxAxO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7398d65476eso2435515b3a.1;
        Sat, 05 Apr 2025 18:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743903330; x=1744508130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB3yUUfhGJKZTpW8owaV/xnUEivaCxVXrQXi/bn6tLQ=;
        b=btwZxAxOt1+n8xv3VDlLyyYpAArQlAaN4yyRwN+/PLYQwCc845ZTypkQN0TajPd00o
         /ESashceJQ/ZpG0ZNr7SUbEV9buWVYp2QxvtrHAaWQbcFdOOr402uOCI9dXmfyU8FROh
         vltMULZLN6cV39Gdm9w3apNTXFGc8gY6aE0/u0jJpcSngAk6WjjV/yHAttSyi8uX55tG
         IRvf0/s/LY5UGZYk5hjRAOEJjGP2s6I90Er1EFaYJTO7JDMa7lvf+wG4ItGNdmMt2kEI
         oC92ljbecIG/fGClU/kqQBVpI5ubyPJiyKwjJec1QqsTdB/jsbfZml84hppkCaYwBkgD
         ZSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743903330; x=1744508130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB3yUUfhGJKZTpW8owaV/xnUEivaCxVXrQXi/bn6tLQ=;
        b=ckXNRFxtofSkMLwaGbugGVxwMWmNS7kRNkewqouGN/Z/p58tSNZQJK68fXi0B5RTjH
         pprT/GFd2vMuwtJlfOEw0yGfm8gDAxA2W+HAYOaRRFTgzr4gRIlJHa5ajBKcGDxNWjzk
         waVexHokDY1igxXJjmMzutlUfCyJOhTVHRQFsvGsWc/ynQrIPxPijeMA2R5QpCCRnbZT
         m613Q6/Ft+zLbjzq8bOKW+OVDB0iL3ly9H6sYKWCz7c+3b9k9G0YtVh+Oy8vvQ2EkvTH
         1RjhlAVyMfkeAwEbm3IZEMYyu4V1uk8wv7LniSNYmJERVEJp67Eyds3YswbGuzhb3sJ7
         841A==
X-Forwarded-Encrypted: i=1; AJvYcCUPP9leJSEybTk5mmkUTnuzBflR/YsNmC1Jmz0QvbQ2aeJicLzhWYCY0xQfhVSQfkdTX9wFmNTxDG9CWXw=@vger.kernel.org, AJvYcCWJpAH5KbGqo9UmBAXGa8iRn65t/6nK4B720AKB6r7dYRxfLD5mnjGKq3+gtVELD0smu0TKtKMd@vger.kernel.org
X-Gm-Message-State: AOJu0YweQVSZeb2Wi+ApbcC1C1bfiF7OAS55ti/szDK9ia2xFxgbowy4
	W6MRnTTZ2pcmSZfJIEAZIkGDbhNxUTrIR4DVKEYFTnJcMyfZrSXVC3bwIkj3
X-Gm-Gg: ASbGnctR8rjZAKUHuUuPH8uUSL4NbV28Bz6pDtXIETa7ejNkbYy6aCEPKbfUIwGBUJq
	e/CuD96Wk7h2/86s8O79pH6LrRhUYOOh7LE7axw3tORo3/Ur9esnkzatJELUQSLEbRBjXqQfVFi
	msQwpWDDs2N9IEnnjtZN+EJ6xzGlSti9aExxaLEw9FXdU/fzRFoPLcrO0TfWKz8XIRH4OecxzZ0
	FddjFMBfC8zYVyOqC4uGTaYM+0TAX0Uuzc169Px/6mpZbg1AA1acHzD7aUzi4qHZHZJsmO4OpC6
	Cn7HVTfdYNDnF27+oLqs5iAzs+Qw+Teh+90CxPKCWE3TyK6Ke6gUYnD7qL5qdf7DsDQNkj3Us28
	QyTCVcyUsb/0rbzvnvLFRJw==
X-Google-Smtp-Source: AGHT+IEbwgDdA/kX+ABcQShgFyEHV5XHvuy/sTlvOc5sIg+Mq92JK95U6Bk7PTZeuiIQ7Iv6uPQtnw==
X-Received: by 2002:a05:6a00:8617:b0:727:39a4:30cc with SMTP id d2e1a72fcca58-739d6351a52mr13604341b3a.1.1743903329587;
        Sat, 05 Apr 2025 18:35:29 -0700 (PDT)
Received: from mew.. (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0bc052sm5846849b3a.156.2025.04.05.18.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 18:35:29 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Fiona Behrens <me@kloenk.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	arnd@arndb.de,
	jstultz@google.com,
	sboyd@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tgunders@redhat.com,
	david.laight.linux@gmail.com
Subject: [PATCH v12 2/5] rust: time: Introduce Delta type
Date: Sun,  6 Apr 2025 10:34:42 +0900
Message-ID: <20250406013445.124688-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250406013445.124688-1-fujita.tomonori@gmail.com>
References: <20250406013445.124688-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a type representing a span of time. Define our own type
because `core::time::Duration` is large and could panic during
creation.

time::Ktime could be also used for time duration but timestamp and
timedelta are different so better to use a new type.

i64 is used instead of u64 to represent a span of time; some C drivers
uses negative Deltas and i64 is more compatible with Ktime using i64
too (e.g., ktime_[us|ms]_delta() APIs return i64 so we create Delta
object without type conversion.

i64 is used instead of bindings::ktime_t because when the ktime_t
type is used as timestamp, it represents values from 0 to
KTIME_MAX, which is different from Delta.

as_millis() method isn't used in this patchset. It's planned to be
used in Binder driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 88 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 9d57e8a5552a..e00b9a853e6a 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -10,9 +10,15 @@
 
 pub mod hrtimer;
 
+/// The number of nanoseconds per microsecond.
+pub const NSEC_PER_USEC: i64 = bindings::NSEC_PER_USEC as i64;
+
 /// The number of nanoseconds per millisecond.
 pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
 
+/// The number of nanoseconds per second.
+pub const NSEC_PER_SEC: i64 = bindings::NSEC_PER_SEC as i64;
+
 /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
 pub type Jiffies = crate::ffi::c_ulong;
 
@@ -149,3 +155,85 @@ fn into_c(self) -> bindings::clockid_t {
         self as bindings::clockid_t
     }
 }
+
+/// A span of time.
+///
+/// This struct represents a span of time, with its value stored as nanoseconds.
+/// The value can represent any valid i64 value, including negative, zero, and
+/// positive numbers.
+#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord, Debug)]
+pub struct Delta {
+    nanos: i64,
+}
+
+impl Delta {
+    /// A span of time equal to zero.
+    pub const ZERO: Self = Self { nanos: 0 };
+
+    /// Create a new [`Delta`] from a number of microseconds.
+    ///
+    /// The `micros` can range from -9_223_372_036_854_775 to 9_223_372_036_854_775.
+    /// If `micros` is outside this range, `i64::MIN` is used for negative values,
+    /// and `i64::MAX` is used for positive values due to saturation.
+    #[inline]
+    pub const fn from_micros(micros: i64) -> Self {
+        Self {
+            nanos: micros.saturating_mul(NSEC_PER_USEC),
+        }
+    }
+
+    /// Create a new [`Delta`] from a number of milliseconds.
+    ///
+    /// The `millis` can range from -9_223_372_036_854 to 9_223_372_036_854.
+    /// If `millis` is outside this range, `i64::MIN` is used for negative values,
+    /// and `i64::MAX` is used for positive values due to saturation.
+    #[inline]
+    pub const fn from_millis(millis: i64) -> Self {
+        Self {
+            nanos: millis.saturating_mul(NSEC_PER_MSEC),
+        }
+    }
+
+    /// Create a new [`Delta`] from a number of seconds.
+    ///
+    /// The `secs` can range from -9_223_372_036 to 9_223_372_036.
+    /// If `secs` is outside this range, `i64::MIN` is used for negative values,
+    /// and `i64::MAX` is used for positive values due to saturation.
+    #[inline]
+    pub const fn from_secs(secs: i64) -> Self {
+        Self {
+            nanos: secs.saturating_mul(NSEC_PER_SEC),
+        }
+    }
+
+    /// Return `true` if the [`Delta`] spans no time.
+    #[inline]
+    pub fn is_zero(self) -> bool {
+        self.as_nanos() == 0
+    }
+
+    /// Return `true` if the [`Delta`] spans a negative amount of time.
+    #[inline]
+    pub fn is_negative(self) -> bool {
+        self.as_nanos() < 0
+    }
+
+    /// Return the number of nanoseconds in the [`Delta`].
+    #[inline]
+    pub const fn as_nanos(self) -> i64 {
+        self.nanos
+    }
+
+    /// Return the smallest number of microseconds greater than or equal
+    /// to the value in the [`Delta`].
+    #[inline]
+    pub const fn as_micros_ceil(self) -> i64 {
+        self.as_nanos().saturating_add(NSEC_PER_USEC - 1) / NSEC_PER_USEC
+    }
+
+    /// Return the number of milliseconds in the [`Delta`].
+    #[inline]
+    pub const fn as_millis(self) -> i64 {
+        self.as_nanos() / NSEC_PER_MSEC
+    }
+}
-- 
2.43.0


