Return-Path: <netdev+bounces-140860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4749B881B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02E1B21865
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C419A38FA3;
	Fri,  1 Nov 2024 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgebQ3iF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FC982D91;
	Fri,  1 Nov 2024 01:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422955; cv=none; b=hXwVNRNdZYjc/d6X2tsL63hGocIqw7/+joSJNj+pFBUhXEFdrZ8BKIOAAsuqPSkdetJqsts3ovjJQX2cuEilUky55k9IfuCN4tHS4vA0sevePBlZehnkuOfYurYy02Pv8sooZBIEVrzmIZ9ymbMFZ6anf19/d8ySso/X7XS4EYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422955; c=relaxed/simple;
	bh=8NjLDyCC+D7+b9Udwktjf3Mpe3Crs3poHbrK2jYZmEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blHYZKWaSBrnPISZZcuBMWWogJsSLccGUgkdRHNZ5774YZZJjnHUCuUYe4faBEzoXxVp1znspTJmPeoED+wkE++NOGTIYrlqoI/OL1qxE2KZMrc0VdrbhuCy5f1Ihl9/PWTyfnjeqHdxsJ1cUYaOfmSpGDZwsyxI4b0/5NYig/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgebQ3iF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720be27db74so879624b3a.1;
        Thu, 31 Oct 2024 18:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730422946; x=1731027746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik2J1cGAabc4dT5du2CznrsW5mp7db+YsB0nTu9yjmc=;
        b=CgebQ3iF69hGh7FWBSN1+C/c9KTma+ijAmLDS+buopdXW8eGEhZVFumtr0Ac5alMxf
         vpnZd2v7yyqcWFpSSEkm1eUJRdyYLd5xdExQHmYFH9PTBVOJQGuhPHjJzdlpXiZNAQ80
         Rm4er66OJ2rOgv6X6wHQ2N1hyIYK3mibLNs83NhmFiy0Tauf1LovQfaaKeh/R1I8jwDk
         iSQ5m43F8G+rKlzFALsDjnlQdvGT1Pke50Tn5EgXtIW7z2U5IEIGWv2QdDXvhA/FLEPs
         i1h/UCRLjP097wCgykHVL6m+eE2xQ1u1b4OC0zH8jeBzr1aF6eM9ZoFn6ULkH2OHGX59
         5b3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422946; x=1731027746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ik2J1cGAabc4dT5du2CznrsW5mp7db+YsB0nTu9yjmc=;
        b=ifWVfUxSbaAzuaqOtVzpvSoJPTLW+Z2GLRC3CvCJVwNgzttW4YvtbOQD0xBKMEUhTn
         8Chy3omVuudFRqR4ZQs+CG7vMZiKHvnDT5RFb7qmaJg/z91dhc6rhwekmNjCRSudsMtf
         E+xyc0EdVaMW4HwJPC8ZsK7dPi/b5Le5FMZGpT9QG1m2ZwuM9+B1k4o7EufuwFTVWDt7
         gtY6AsXQ8/kWt4R3+3XoE/FCTxIb792fQPMm63SFDCXd5VLify1xgED9b8CIhkuNId71
         fu3YpvMyNKyn5l/V+Y6DXSMKwB+WwUIA5OFNA9C9aET/495MIQqA0U21B3DP4VqnZdUr
         ljdg==
X-Forwarded-Encrypted: i=1; AJvYcCVEepiq8hRG5vZQozBl6GRwZ6aZukHdQM51ZO/x5RWJkCWjUUYyZlGZ6Uw9DXHdeUuqb7NBkpa06n8AZVM=@vger.kernel.org, AJvYcCX8DEd5Q6dCg0wWdTNnLpYk47er6n13WhXm28f+dm2mDr62MKCEllVCEeuvk48QoMIYGfW0BNWF9/O1LsdKy38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmM2HEomvCx7qSsuXAY0nZ3Pr6kF1pK0SEH+M2x+SpOD+tBEB5
	Q5C45R02T0uKODsb/EiyMOsk3GVKM8JrtUEstlTLB4bTnabBnjGE
X-Google-Smtp-Source: AGHT+IF04EKGKp5c3JjUwNqnvXlSR6AJv+5qa9eq/VlZ+Ae2bswJdsHXXNHY5K2mBkCEsXNcBe21YA==
X-Received: by 2002:a05:6a00:a05:b0:71e:5252:2412 with SMTP id d2e1a72fcca58-720c9628be0mr3079329b3a.2.1730422945905;
        Thu, 31 Oct 2024 18:02:25 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ea6a1sm1743403b3a.74.2024.10.31.18.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:02:25 -0700 (PDT)
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
	arnd@arndb.de,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v5 3/7] rust: time: Introduce Instant type
Date: Fri,  1 Nov 2024 10:01:17 +0900
Message-ID: <20241101010121.69221-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101010121.69221-1-fujita.tomonori@gmail.com>
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
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

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 48 +++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index dc8289386b41..e4f0a0f34d6d 100644
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


