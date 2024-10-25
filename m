Return-Path: <netdev+bounces-138953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3489AF83C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1141F2482A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB6918C017;
	Fri, 25 Oct 2024 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePRO08Ss"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2718DF7E;
	Fri, 25 Oct 2024 03:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827263; cv=none; b=mhzj3VSJlPhTH6ij+sJhnOssHwNlk4j8LeN4X6KTEJBusN4CDFNZxsMc1uQl9mcwtUShumLvUHvuAKYiUmp1mGmOCj85/N6gGtMxSpnhkBfkfhh8uui1d5vO8htdPAEAE9WmtcJnXx5TNUxqxlJnlnDFqcGXvFKUnWp0C2FzHWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827263; c=relaxed/simple;
	bh=EtK+d2Bje3STOCATrvNiA6gB5neTb9iViHm5w9db8Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2EIX8Qa3EaiZTYiOLMgmBU8yWX5lRf0oTT/ZSAulnJUwpwUb5JOAF/FmWlICBzysjIsVEP75cSQYvFlG6yOTOv1Wm/hjUaRuxSBxUiM5BOLM1DWUppb/v9GQT7h0xHIUc9TaWJJLgEfedcwdC/zwdImKLtGDP52JCg5D51xDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePRO08Ss; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea8de14848so877121a12.2;
        Thu, 24 Oct 2024 20:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827261; x=1730432061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+mkaZsnPSyKLPGmS4/PHft/GFdWBAEjk0wbqgKsTGI=;
        b=ePRO08Sss2o/zfUT7f9SD4GRHYGPtXIi3whtG81QJtQgw7+/SQtkePaLDqElEcFFIb
         I90gnUjulkJZZf/jd9vZ3Xc03SvCnnypDjrhKAPhvliZHFGblHbPGwKreosRYZ7jRnBU
         K1z+EDhmbVQLofNgwpZG2I9lGJottf9K4LcYkiR2A7sPct38mTVQ7wzby2VDxTNJhSvd
         yJFekUw6ZVYI99SBhH8mvmXdOcqOSKG1M9MzSXgH7/GFpGLCW2PGc2b13vAxzi+h9DG8
         6uOeGtNfz8xDa+K0JPBKBELnyTcwF+BWJQrtNUaFBsQB0Gd8WDh+bir8K/is6Ark+34h
         S/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827261; x=1730432061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+mkaZsnPSyKLPGmS4/PHft/GFdWBAEjk0wbqgKsTGI=;
        b=mjwJ4JcXqpVYk5IlJmpch0S8bEkPMFoh0ypx9n+awN05BMhV/Yliv5mx9BMxdCzrFe
         WpxBdi0n3c9oTYuGPcYZJljjc5CK15uTcbCZLrvOcTCH8IaK+WOPUdGVD62GxqzCS5oq
         LgYL55rFrqpyZd3hYc9HVF9y9Hd0fT3X7xm4bsW+FW5R48Nl1f2eSEXZX75Oc3JLxsHO
         mpcEScmSLUDdvd6KK3pe9TPaONCFlM07wp8gwzuYkubm9H/3vJvupzGz65dsVt83gY4J
         RBCFYErqrVC7hrEZFKvxwce9gsksVxWaGdiONGzkzrx7tYFSYf+bu9K0UiIigSVHpuyH
         9Pag==
X-Forwarded-Encrypted: i=1; AJvYcCUv7Lz/q+YaSgDyK45kH6zpGf4Ys9eiYfc7ChpKR7ZV3CGZnnbsSSH/x7Sx6yBGW+LwHomIGJ7FFx2TC45r/Nw=@vger.kernel.org, AJvYcCWrqSUwKCVB9wcxHMDwb4uCZm7kB42tMqIrObknaitNkcLe2qxzqpyieKEZt346qYGcRnd+WvVIEuN9S78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxURBNe5Kaf4ngMvuJ1n3bA4SRyAyqXQF4uz5YlaY7UnDNgvvSX
	2Gx6AJl+GAnZQpXpVZpb+khBPwKirrRRvivFiIBea2WT40Bw6bo3
X-Google-Smtp-Source: AGHT+IGyfCOgPEOZjm1g0kwLiXPL5cQTwDOEe0Vo+JvYtp44kWIRMIRRGKl06H8fvAWjGdx16rCBhw==
X-Received: by 2002:a05:6a21:6711:b0:1d9:28f8:f27f with SMTP id adf61e73a8af0-1d978bad215mr9974606637.39.1729827260898;
        Thu, 24 Oct 2024 20:34:20 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791db5fsm180188b3a.11.2024.10.24.20.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:34:20 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	arnd@arndb.de
Subject: [PATCH v4 3/7] rust: time: Introduce Instant type
Date: Fri, 25 Oct 2024 12:31:14 +0900
Message-ID: <20241025033118.44452-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025033118.44452-1-fujita.tomonori@gmail.com>
References: <20241025033118.44452-1-fujita.tomonori@gmail.com>
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

The operation never overflows (Instant ranges from 0 to
`KTIME_MAX`).

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 48 +++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 574e72d3956b..3cc1a8a76777 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -31,59 +31,43 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
     unsafe { bindings::__msecs_to_jiffies(msecs) }
 }
 
-/// A Rust wrapper around a `ktime_t`.
+/// A specific point in time.
 #[repr(transparent)]
 #[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
-pub struct Ktime {
+pub struct Instant {
+    // Range from 0 to `KTIME_MAX`.
     inner: bindings::ktime_t,
 }
 
-impl Ktime {
-    /// Create a `Ktime` from a raw `ktime_t`.
+impl Instant {
+    /// Create a `Instant` from a raw `ktime_t`.
     #[inline]
-    pub fn from_raw(inner: bindings::ktime_t) -> Self {
+    fn from_raw(inner: bindings::ktime_t) -> Self {
         Self { inner }
     }
 
     /// Get the current time using `CLOCK_MONOTONIC`.
     #[inline]
-    pub fn ktime_get() -> Self {
+    pub fn now() -> Self {
         // SAFETY: It is always safe to call `ktime_get` outside of NMI context.
         Self::from_raw(unsafe { bindings::ktime_get() })
     }
 
-    /// Divide the number of nanoseconds by a compile-time constant.
     #[inline]
-    fn divns_constant<const DIV: i64>(self) -> i64 {
-        self.to_ns() / DIV
-    }
-
-    /// Returns the number of nanoseconds.
-    #[inline]
-    pub fn to_ns(self) -> i64 {
-        self.inner
-    }
-
-    /// Returns the number of milliseconds.
-    #[inline]
-    pub fn to_ms(self) -> i64 {
-        self.divns_constant::<NSEC_PER_MSEC>()
+    /// Return the amount of time elapsed since the `Instant`.
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
 
+    // never overflows
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


