Return-Path: <netdev+bounces-184683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6C0A96D8B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5D418845A3
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499122836A9;
	Tue, 22 Apr 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZUkaoYw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C02027FD52;
	Tue, 22 Apr 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330109; cv=none; b=dz4jfrR3SrIuxbrKviQg2dExmWQBdz3ANUrmtjOx2xi9vGZ/UZFdhwdanFO1Kc9ftfUhDQT8bTbxjZyYMxVIjmbnFD716jP6ECxO1IcepFrC/ZymPyvlnasNbYhchmX6yxDxIcgUTmhZp8oj/O9jINjFPwMIVfiCsPceVg8udhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330109; c=relaxed/simple;
	bh=ufCQ1PUh5NBQ4ErmIQQDYf2yyQHKBhO14BEcQd3RtKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=av1Tp63WCLhOSpVWIKTKwhGR7J1qNUKq4e//+EY4dLaK0fzfMKDz8yOCsXm20ExcBAtLbFb9yNJ9q5sNweMdkmx/xnQbVa2iUBkxmgoHF/I9Vogtc4glyizYfIiE/ygxFjV2N7c9Q5x0GPmqP2zIqvYkgQ6TDB8CCUvOKUPUyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZUkaoYw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7399838db7fso4973327b3a.0;
        Tue, 22 Apr 2025 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745330106; x=1745934906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0KG2q5mUlg+on9BJSeJogXT+LWqT840e3pHxK7j4lE=;
        b=LZUkaoYwl+mN2RDeakzVTl4I3aVIVz6+aTXuBPB2m0Da/uuJ6A/SIT5D5TzJM6hjdf
         2Mpz6Dx1FDL9Qq4/1fuBTwHsb6kPokCOeorU73mz6sAQm1XZ9LDSuAnU9fnmCNeCaEd9
         268GD6mtL77kbszxvkD8qHjAEJNsPzmzdvQCrCb069IEEeRIFmGN4KIu9m3ZP6f4xcj/
         PKbxelMpGzrhis4uAV96scOSJ4kgqBXUWtx3nL13XS09FQRK6WzssOltElgoWV8RckOB
         L4z5KtAa/NQ8VdAD09SFtWvaWxCyPjtqrNfIyJOOW5KAAoVMIXpHBAEqx5M14mvFEy5E
         gkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330106; x=1745934906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0KG2q5mUlg+on9BJSeJogXT+LWqT840e3pHxK7j4lE=;
        b=wHd8QOjMiWwlc56REWDs4CskD5u0yWVO2xYiWbRfh+CC48ide7zd7q92kD/hEglCnu
         34ONa7wnXwzpsWf58dSNQDC7zsdzQ8X5Wp4ca/2bdeeIXFSxsWFzW4MxhCdgzIYUL+VO
         inK31ryFudw3JmzRWfUqkjP/Jnoe0gUTc/y0TfYI4wLsSmAWBHhzDTy+CoS/5PY4Fm8x
         PVCFHESh4ZK8INzPBgCzaP6ssJGenTvk/NlJDnTeRnpvyl+P74Fz0+IgEYg+WTRxvXOQ
         JTNfCpfk7PslACQYQZAd5bMxOy2VHHIF5uxpWlbknewjpUWOnWRPG3vG0ZqqjsGhfGPt
         tIww==
X-Forwarded-Encrypted: i=1; AJvYcCURtzQcI5CI6UgV6+SsJtIBGa5IRWekiOtAK+pDRQWv0XaEqJsWO+vLTGdXO4eOVIZMjO3kkqZmSveL/7A=@vger.kernel.org, AJvYcCXs6NqyQVAsycB3oQRkuN/8TMCfVfg77XRxqn75IvUZl2cXzE5QaQlK2g6+ya64aYu/1GbMu1MA@vger.kernel.org
X-Gm-Message-State: AOJu0YzFoNHDzKfgwdYg8f3IhmtABms72h09n8cvPVRttNJmz4CPmmmv
	9bVF3PRv9EsbZqi0wyfJG2rsSUjuygYacaTKyAikXo0uPEa0U/WJJ2BRneic
X-Gm-Gg: ASbGncvXS1MCk2UTfUAKtLw41cMMsvSTqJwBFOPjMw2ceMoXGv92A7IvLwUh4giHpBC
	lCBwzr6c6zzvjdPm/yzp6YaES598hDdixcYAc9HW3mSBEbsjnqOj/kwiu3Z1G8lDWwftpTBY4TU
	eEQnu6JOXVRzkinLR8cJvGW3evVv6NsnY/g5xX6zgaE8tloGPqX9+7Qoo/44vt3/pZlHv3kN3yq
	LhXVG5temMcveMXWOmsGWhQKGUIMP/Hf/ZiFnJzE5cefDrGFqtDYXrg9PXchh1ouSz6l3N7BH9R
	v2OwosxmBefUqaZ4hk+062UD9yveLYVT+xj6jO1fIvH7pzLtGXaCJ+Gk37YWU+QE2KBb2F5NoTo
	hfBxhMJPH9QiLrFdaqw==
X-Google-Smtp-Source: AGHT+IFPptCcqZ5xALnVtQZ3cZ/yKJNd5+E1BD/Ikh2EHg40mI819ZqLy9DLUjBl7Fz0MyPeSuZr9Q==
X-Received: by 2002:a05:6a00:91c4:b0:73d:f843:5a90 with SMTP id d2e1a72fcca58-73df8435b49mr6720718b3a.1.1745330106472;
        Tue, 22 Apr 2025 06:55:06 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaaba76sm8869650b3a.143.2025.04.22.06.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:55:06 -0700 (PDT)
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
Subject: [PATCH v14 4/6] rust: time: Introduce Instant type
Date: Tue, 22 Apr 2025 22:53:33 +0900
Message-ID: <20250422135336.194579-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422135336.194579-1-fujita.tomonori@gmail.com>
References: <20250422135336.194579-1-fujita.tomonori@gmail.com>
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


