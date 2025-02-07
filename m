Return-Path: <netdev+bounces-163985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCBFA2C3A8
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400F53AC65F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ADB1F76A8;
	Fri,  7 Feb 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPnEHZMw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37421F7575;
	Fri,  7 Feb 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935120; cv=none; b=aB6FscETk9H4wDGqxkjrj/5WcFd9p56/Chvhmko0te5W+YbJYNQr4y2GMYBns17fUDA/Ko0eWYU9ZrNDwozw8Ai8NcCdWo0pmb65wzZWS0YHhgh+D9Uy1DztyFVk4if839Uav+4mXSDzs/H4yqAKNJEMv7Z4gAL9Jv1Dm0oAVKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935120; c=relaxed/simple;
	bh=tkxX2CG2orzaTnWrp0cyRIUHv6uwgeKEZY/HfCxkTrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcPqiSNM6g3Or4McKl+5qbyI+x7ytAlrZS7tLjlzPkR4z8XEseJhvMlyWa0N4FfxCbrlZmN9nfiofCc9p0y7OWo9BhJEjnW4u5S7LQV952pIqsagwQPRa91o6v8OhWDqoLyxAsj6okZ4mciEH+ac6RwzouxfqMz2V01toWl/2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPnEHZMw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21670dce0a7so48612775ad.1;
        Fri, 07 Feb 2025 05:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738935118; x=1739539918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFYCZZuPRIZuvCHcVAdtpHrS6egFrahgsjkjSvHAJYk=;
        b=kPnEHZMwBPBH4vTyIPxtAy6+tgZOMEz4HMbb43G7j2exdCLu732AUyeOj0hknx13G5
         ovdENPHaN3yT0kt9ZY1x1DODcxouLldCTuA+AeidTE8P6sD9ZhVSDRlfOuG3wy4dXqep
         6euabecOSfUVFdWGnplZTz1H18hEa4mPQkOTDL6wBuf/khD/ASJsa2d6narISM4phYBz
         4VXzUUqm5e0onRQOVjfTXgYLG+tEatq7eI4NazpNIEgGkWtJnPyqEdVRrdoPz6JkW+O6
         YHHIwQyiaKSrHKueKFmlVs5JGPxo6eFgq5WccjtDYM/bWh+ULSMq/OCfhTKyChig7ufH
         iEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738935118; x=1739539918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFYCZZuPRIZuvCHcVAdtpHrS6egFrahgsjkjSvHAJYk=;
        b=KJR3CXThCzQOf2KvFqY7rbvFcR4JMYTEIUdjQ/pumUud43C2PJyi1ngenog7FN5l9m
         KQ7LxMlvyI6D0toyfOqXo9JvJ1yKQHm9vn2eAj6Ht8exRo0NyuWYioJoHgJ0jFP4Up2J
         cnmSZeqYL8ZQ2WrX3+/IVqbilihV5Viw5VmoyRJKGmzv7ORUNigdKMUxMjJPckiazfh2
         Wu9Dzx5vTy+zFj7JV5XfYrtCUj/tzKs0h7+D/CYYmTsgVWoY7YZmT2r2cIt5ySfsOuxb
         x6k/WlbypTV0HnSIFY2O/nPoLxx7pRM+Vk9lOvHvaI3i3GD0c+S7fghN2BzsBNY7T/gh
         H4Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUdylcK7q88ZUAh5c85mEALNNvObxpyG2jyEwp37r3iqc3UPzMShYUWGIr3pHV6Ur18WKWGiLbdKhOhsQ224Vg=@vger.kernel.org, AJvYcCV5IDmFvuodnNAU9NAECpMnzEVbMWwzzC5sqKWrL+UUcg2FXEGWm016mf0NmahPNJkScOEW1iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7LkP3grC0ebWNQZsqW2f/dXVLB0BXd1TxPNUr65EsCvD50gY
	cTRQmjmx2Cb8U7UtKSb6rNuajsdnpgUvqmptk+jw3bU/QXEb3O5xYHKilKTF
X-Gm-Gg: ASbGncutKX9vXWXV39UyKX+vsJrSy2VoN34OXZ0PJYgx2YhyFMP2dqcB5AmLAxYaWhP
	c8qx8AV6zONTgjnYRjdAxqI4dIDDihlNcndqxSLr4MbhtY9hmJ+9vEbXrfrJE3lUcfLP4yDmj1M
	tukPrX65nquc29qBi5v/4qE68YGmDEJkN7J4tg4ZWwZdmgQEYhoICyuhNUO2tMUx2/U8r0I02oa
	yXHsP1HhD+ijpFt/13pgxQS4Jeu/1YmgzIRKlaKi5d5y+5DMQL0Xu1nHtrUSK5VAjuy+zAc4iXW
	WsjFVTmZDC8tMryNwYXJGJUAXb94qOw9yByCC7Rz90kfZmRh84xixEzm2QWzU4wcNnQ=
X-Google-Smtp-Source: AGHT+IEwez1doH7I2JYz3hgpJz1XgrqvXlZONG1xIqx3m/yRFH0PBiG4dWyQCDtYDJOmS9jCBfNL1Q==
X-Received: by 2002:a05:6a21:9017:b0:1ed:a812:c3b with SMTP id adf61e73a8af0-1ee03a1db85mr7026491637.2.1738935116421;
        Fri, 07 Feb 2025 05:31:56 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51ea79a47sm2877843a12.76.2025.02.07.05.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:31:56 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Fiona Behrens <me@kloenk.dev>,
	rust-for-linux@vger.kernel.org,
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
	tgunders@redhat.com
Subject: [PATCH v10 4/8] rust: time: Introduce Instant type
Date: Fri,  7 Feb 2025 22:26:19 +0900
Message-ID: <20250207132623.168854-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207132623.168854-1-fujita.tomonori@gmail.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
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
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 77 +++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 622cd01e24d7..d64a05a4f4d1 100644
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
 
@@ -31,59 +47,44 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
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


