Return-Path: <netdev+bounces-158750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA20A13212
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0EB73A5780
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D28D172BD5;
	Thu, 16 Jan 2025 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhGB1PYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C8EC4;
	Thu, 16 Jan 2025 04:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737002570; cv=none; b=N2gPBakSFcUxDASgj5yB4FBqInhyiFNVP9LWZHKnGvDvm0PSMFiojJ6j662CAXl1zJlQHlaBXefnkat4PgEyWcLJls+wrpVSUqZTwFtBZXMYfimP7xzwAGi4jB90wLL4JL5Bl0g7ZbW0nS8wIkdQdJfLUhVb0+lYXWArF2562+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737002570; c=relaxed/simple;
	bh=ZXb/0NiUcW1nSbcWaHbSM4MFinXMLJootRsCvXQzwhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAhkNm/TVJ3HjXd1yGl/Mtb7M3N/cK1Nh9jBz2Xz2aHFwDZkGn44iDoQQVNlgKM/VlW6xNzz7RE34N25e4nntIL4gfkf14hWZ53sVo6VO2LlUdT1w6GNYlRvsTuJ12XFJO8idG6wOuVBOnFGw90wGjhQ8omXeYXgay9gQODl4Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhGB1PYJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21644aca3a0so9879245ad.3;
        Wed, 15 Jan 2025 20:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737002568; x=1737607368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lsSO3XnrzhExT+J3VC9DmPLXbd0JuCQEKEpxIJs/0E=;
        b=IhGB1PYJyXoc+gnS7vRHzN+C3tFKIXx+CzXkA/OxljUiYOcJ21CSexOx4oGrOL+sBL
         /UUBZob9PjDKPdZJ//+dSDTa9UZrILfMAQsUwrGDsmYiJyVQpf9c6htqbWBE+x0Y7DwU
         TWpwdsdyM9Mx/DbidwwKP3mJYVGUp62RwB9HPtlWaheodNbzj3GgVDwDF+fkbTERhnho
         6B+C0kKMm8tAUeaowrpXkhVnGRB3gM3+ZGbWOWmecsbYTW+5zOk0zAuToCZfBu48iRuC
         2gCB0lsDNjyBWjOIwkiu/S6H3JSuzkqMiFC1iJdJPeDqV6DQjbQKZQ43abY+6dw+FThR
         u2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737002568; x=1737607368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lsSO3XnrzhExT+J3VC9DmPLXbd0JuCQEKEpxIJs/0E=;
        b=m28w7+Y9rp6aPRnLI5wiMY5WaCpT9/bz7FtTVeRv49E5yeBCoeE+DyNCnCcI1Rw0hc
         T9Wxe0m41x+qfRbfGQjK8lcKvHIPkLGNJpDUDrOYC6xB2ZN7eDpgQR03vrGgZ2wh2tTV
         bYXDPclW+pzqgMirJZlC6PgyRglLDkIMnoopszI62D7JW7EMbhWv47x4hg5+HsHTVcaj
         FB3d/66JaBf62J9qgBXTjuMqInYJ8RYiZPQ/3y3cxcpKskUWm/8ixZZ69YXnbtoheDoO
         t4DifbNO5U0ikFierc1AkRxmSLcNvos3P7ee/ItzUSiX21AvFIIZwv9rNtMPGO+N4kdP
         OZZA==
X-Forwarded-Encrypted: i=1; AJvYcCU226tQQu0P3oUG3nZkQwTE0xqjQZQArRrnDfiV0P07vV3Q7A430MBRxZG3frjS7DyZn26GO4l+M18F19zlWBY=@vger.kernel.org, AJvYcCXOARYdMn+llX9sixDlMr9CU/eelN/0CUSoZMRlIegNDdjUUfCXKFKCHdlRgv6F3OEL+55BxcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzup9q9MYpEXv7WXjnCtOz4QJHyVuFnKFUULRg0UC1OhzCtVKIM
	lBB1u+YoHEiuRO9J/TPecVnfxQhDcRRQsELZpQOIXfGmcmHFCJBQFbt+fJXN
X-Gm-Gg: ASbGncsjtwncZc9t71Ie915noKt01ceC75QTPBSzDVvzrVOWsi6Fg+RngD+2e/LpCPV
	SyueCVu/Z4Hlh/8rxt2pmyz5FQ8d+YXI0TNSrtkhSjcq9MqCfgYJXMZxRS9zGQ6h2ELe2sfPrz0
	g52w9jbFX/ivI5e/DJIrhw6/iALc+slHH7RohV0C3+tJElGs5BsKIaEOClm/20W/8oNO6CRgDOc
	vxLT7ML33BthHOVYPv0cnlYDKRmmQhBjFMCJG0blyI8oZDZKHjLQUmv1re/LyBsO34tengAJXN/
	cx39+KOYcCcOZ8sIMi7vJp9jAHGvCp1h
X-Google-Smtp-Source: AGHT+IFoRbOB1iCutLQdzx68G+wIpR567sAM2ad+/yzfbp0H/NK8qiOzYGirpt1+1g92EyxWS8i8QQ==
X-Received: by 2002:a17:902:cec3:b0:211:ce91:63ea with SMTP id d9443c01a7336-21a83f56f9emr492179465ad.15.1737002568451;
        Wed, 15 Jan 2025 20:42:48 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217a60sm89161045ad.158.2025.01.15.20.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 20:42:48 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org,
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
	vschneid@redhat.com
Subject: [PATCH v8 3/7] rust: time: Introduce Instant type
Date: Thu, 16 Jan 2025 13:40:55 +0900
Message-ID: <20250116044100.80679-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116044100.80679-1-fujita.tomonori@gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
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
index 55a365af85a3..da54a70f8f1f 100644
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


