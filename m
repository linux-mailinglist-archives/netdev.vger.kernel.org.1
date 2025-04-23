Return-Path: <netdev+bounces-185265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A4DA998D0
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295053BB28E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 19:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5AA293B53;
	Wed, 23 Apr 2025 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBUVkdYp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8714293461;
	Wed, 23 Apr 2025 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437321; cv=none; b=Q2dZgcFli1UEW1cOhP0lbieZ3F53vdbzjaThIAGWm/qew/Yd82YqwQX+E5VdoP01VwchZdK2ZZgOgc69dBxEs9y7O/wgsA+oQAMlZ4Q2DoFqOH8pYK9F9pF0vgcesrmmv86zu+AzU39xDcwYYqDlNNJuTHW3xyHQn60qkx3IyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437321; c=relaxed/simple;
	bh=ufCQ1PUh5NBQ4ErmIQQDYf2yyQHKBhO14BEcQd3RtKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxzXDzteOMRLToPDKhnOzfDZrQXxvPQmZaSX3mI/FrofsYGAfbP3rn9LB9X8X37QZ9dgf6w5buxj75/XHhaB6AG6YTB7ztmKteggDVRaPO2PY4zEnyF6HqMe/eXO4If7+mYSNCPjRHuOn8STXqOLRsa++nlv8Ux/4Kc0Ibzn2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBUVkdYp; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af91fc1fa90so149843a12.0;
        Wed, 23 Apr 2025 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745437319; x=1746042119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0KG2q5mUlg+on9BJSeJogXT+LWqT840e3pHxK7j4lE=;
        b=WBUVkdYpE8kZZKz1ndbzNVucd/8aY3VomdeSv34+N7SLZ4gUQR79+1aNIFPKTi9XeF
         aWsw3KCCQEXsCXpnFOgUyDfsILKpBIOmA5tIM5IHyHMcATjxpRj/EqP3d2XsEQyR6I4R
         cfI0Pm+AHvwtHu4Y9e40Oo23miB3cTyOUGIpPQwPMlv08rPMLMLgXQG1Gq8aW9qi6vVo
         X+IQbBPmmklzGUkWeuVy0gR8Xa5LsTSwrBUmUdpqSNC4WZlNquUb8kxZK1MFWkHy3mZP
         ujFqAngMnsXByfe/aem9854kqCwvVmjUPhYraQKHRwFIl5hsOkUpDcDs7yHc+iC4r49A
         pjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437319; x=1746042119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0KG2q5mUlg+on9BJSeJogXT+LWqT840e3pHxK7j4lE=;
        b=GkoSF6sJpf9SYIHF4nsteueL65ZHxyp5Zqtl1mBZ9bZrmdMreveOV4xp252Yg/XjOD
         GvVq/tlUv/kLSVBk5arEY07MmMhKViksyWpMvywbw3klb0hrRfBnhKabCR0xQOPw6szc
         sPMx9CitppquDlBswauVCy0lSaOBh2fbRZBRhredADw8Zg19Y5Kk792ZGB9dAStD7X+Q
         uy3sBZ7otC9uHmuQzoDM/JserqZ1StVOPfLkL6lT2HeLQIK04LlPOo1nJVQUQvGJVJCU
         P+HDB+uDYn18ZrevJM4/YGZ4XEcHxw1AUejCUqBLUQAVrVqtp1GXZtg5ilzzzVgYfuPN
         F/tA==
X-Forwarded-Encrypted: i=1; AJvYcCUUafgw4BEut8hSsGep6V1m69kEUVC/r89tQcJKLTbKot9sNWVx7qtOhwPmqBGpGwF1BjvbA1bxAB4JT3Y=@vger.kernel.org, AJvYcCWLK1/UCAvLwTe8tDscfhLFN3/VNk3NKZKre4y7qbWxTk0w3bz6GRTIGW3h+T/QpirJiKtpRDDN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywla/zmlpWmlCW+RuhZCIEAxpjqs5PnjKw9p7zweQ40hXIFL2P3
	UiMVSsshpHcIuROMosyxqFy/vEtcfDcSmRT/RZ/KyUZAxkxp2rZzU82WMzdj
X-Gm-Gg: ASbGnctwsUrdr+63katjx1+jyIedhwrygkVsrhoR8rF5XICxSBcyF6rOqbq37v+h1C1
	JWATpzdCPz735MohHp25f9mYpBN+fl3YUHG84F5jlXzpBZAtmt4+9o5Bs3vJraGhpLoaimA0WGL
	0T1kgFHr/dm3JWwAmYoHtmlUbUW/e8WPd7oTjQWH2Qr5eo/sJDobaPCCLdHOOBeeOoJAy+PfGoO
	Osc6zPh5SkagSa0Fs01KkOgT/lal+YmJTiHTW1GgD7r1kmRDzGwHp8w2ubTrUfxGQzpcqywTUsw
	GpS2EseDMdYbSLbe1JnfzuWx5NO0ee+cI95YSkUf57OKmKpwOd7jwRdYCgXtiOSGU5xsup24qsk
	RDTnIO3TaFH+6/eY4Ha9qn+cB9xxx
X-Google-Smtp-Source: AGHT+IGc04nUGzIrSEBI2qVLeNYjmY0J6y6WGmruN5Q5GVF7JxZEot0hHFzEye0UTPAVmOmBS2b8Ag==
X-Received: by 2002:a17:90b:280b:b0:2fe:a79e:f56f with SMTP id 98e67ed59e1d1-309ed270a56mr85519a91.13.1745437318359;
        Wed, 23 Apr 2025 12:41:58 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309df9ef918sm2056475a91.7.2025.04.23.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:41:58 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Fiona Behrens <me@kloenk.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
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
Subject: [PATCH v15 4/6] rust: time: Introduce Instant type
Date: Thu, 24 Apr 2025 04:28:54 +0900
Message-ID: <20250423192857.199712-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423192857.199712-1-fujita.tomonori@gmail.com>
References: <20250423192857.199712-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a type representing a specific point in time. We could use
the Ktime type but C's ktime_t is used for both timestamp and
timedelta. To avoid confusion, introduce a new Instant type for
timestamp.

Rename Ktime to Instant and modify their methods for timestamp.

Implement the subtraction operator for Instant:

Delta = Instant A - Instant B

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 77 +++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index e00b9a853e6a..a8089a98da9e 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -5,6 +5,22 @@
 //! This module contains the kernel APIs related to time and timers that
 //! have been ported or wrapped for usage by Rust code in the kernel.
 //!
+//! There are two types in this module:
+//!
+//! - The [`Instant`] type represents a specific point in time.
+//! - The [`Delta`] type represents a span of time.
+//!
+//! Note that the C side uses `ktime_t` type to represent both. However, timestamp
+//! and timedelta are different. To avoid confusion, we use two different types.
+//!
+//! A [`Instant`] object can be created by calling the [`Instant::now()`] function.
+//! It represents a point in time at which the object was created.
+//! By calling the [`Instant::elapsed()`] method, a [`Delta`] object representing
+//! the elapsed time can be created. The [`Delta`] object can also be created
+//! by subtracting two [`Instant`] objects.
+//!
+//! A [`Delta`] type supports methods to retrieve the duration in various units.
+//!
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
@@ -33,59 +49,44 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
     unsafe { bindings::__msecs_to_jiffies(msecs) }
 }
 
-/// A Rust wrapper around a `ktime_t`.
+/// A specific point in time.
+///
+/// # Invariants
+///
+/// The `inner` value is in the range from 0 to `KTIME_MAX`.
 #[repr(transparent)]
 #[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
-pub struct Ktime {
+pub struct Instant {
     inner: bindings::ktime_t,
 }
 
-impl Ktime {
-    /// Create a `Ktime` from a raw `ktime_t`.
-    #[inline]
-    pub fn from_raw(inner: bindings::ktime_t) -> Self {
-        Self { inner }
-    }
-
+impl Instant {
     /// Get the current time using `CLOCK_MONOTONIC`.
     #[inline]
-    pub fn ktime_get() -> Self {
-        // SAFETY: It is always safe to call `ktime_get` outside of NMI context.
-        Self::from_raw(unsafe { bindings::ktime_get() })
-    }
-
-    /// Divide the number of nanoseconds by a compile-time constant.
-    #[inline]
-    fn divns_constant<const DIV: i64>(self) -> i64 {
-        self.to_ns() / DIV
-    }
-
-    /// Returns the number of nanoseconds.
-    #[inline]
-    pub fn to_ns(self) -> i64 {
-        self.inner
+    pub fn now() -> Self {
+        // INVARIANT: The `ktime_get()` function returns a value in the range
+        // from 0 to `KTIME_MAX`.
+        Self {
+            // SAFETY: It is always safe to call `ktime_get()` outside of NMI context.
+            inner: unsafe { bindings::ktime_get() },
+        }
     }
 
-    /// Returns the number of milliseconds.
+    /// Return the amount of time elapsed since the [`Instant`].
     #[inline]
-    pub fn to_ms(self) -> i64 {
-        self.divns_constant::<NSEC_PER_MSEC>()
+    pub fn elapsed(&self) -> Delta {
+        Self::now() - *self
     }
 }
 
-/// Returns the number of milliseconds between two ktimes.
-#[inline]
-pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
-    (later - earlier).to_ms()
-}
-
-impl core::ops::Sub for Ktime {
-    type Output = Ktime;
+impl core::ops::Sub for Instant {
+    type Output = Delta;
 
+    // By the type invariant, it never overflows.
     #[inline]
-    fn sub(self, other: Ktime) -> Ktime {
-        Self {
-            inner: self.inner - other.inner,
+    fn sub(self, other: Instant) -> Delta {
+        Delta {
+            nanos: self.inner - other.inner,
         }
     }
 }
-- 
2.43.0


