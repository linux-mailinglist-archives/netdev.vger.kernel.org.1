Return-Path: <netdev+bounces-153597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6559F8C9D
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9471886232
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 06:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED011BDAB9;
	Fri, 20 Dec 2024 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnkaX3jB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B8019992E;
	Fri, 20 Dec 2024 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675678; cv=none; b=nKq/Oadbh4CD1cJzVVFTSBaEnPood4piqwtggPqwLctl27OfDJSSBhFVYf4BnEfoa6Ckktcy04b2M9grLIsg9JA6eurVP7sOedfSq7fi764ggHkbro82y1IBSlyJ7J84td9zKC26mnJh4g1moTNZExnKoXHOFdejHewccKYzPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675678; c=relaxed/simple;
	bh=ZXb/0NiUcW1nSbcWaHbSM4MFinXMLJootRsCvXQzwhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEMONKded6LnWuPlGUhoYTSGTQTrBrwvqdriP6HSvmx2P4RRVyAnsAkUfZ7g5l389tAc4almKGpgXFqpNKk2wwJO85H6A2KnPY9IUKuceRxXtLTExLQ771OB1s4+3ervLhqvY1sZxi6FBQ06ociH7OsqmNbnpQR9lmXxGOx0R0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnkaX3jB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728ea1573c0so1368583b3a.0;
        Thu, 19 Dec 2024 22:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734675676; x=1735280476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lsSO3XnrzhExT+J3VC9DmPLXbd0JuCQEKEpxIJs/0E=;
        b=NnkaX3jBcu5yzEK9nGwZjsoBwsy42J/bn4dD8RUocc485sbZGjZe0vDtO+LbgqxL5s
         m9Zq4gPX9SIvO4FT1xPI12HX+w0xRxUprULQ3ZStlrqzMfJZI9hReL2lVKO/zf0h6nIX
         7oWDs1i3HK/RamjnEbkxZSzr/OamUUT+IbP5T+wWSv/AiM8pAYfmBBXGG9Z7/ML8eieD
         1Cnncw1dJTP07xxEmsxFLITGc3Ym7r1EX/goSfZAgi5YYhzarIj30T9/ditceAEirOY2
         PuDwuDvNDHpJSLJ6ii+WTKS1TSI/lbiT6RrdVYGloRyuC5Bkzq0nFph4xfqErjM0HR3S
         MuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734675676; x=1735280476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lsSO3XnrzhExT+J3VC9DmPLXbd0JuCQEKEpxIJs/0E=;
        b=NHMsZ5KZJ/rXz7CLEc+kpLWMuaqp45T2a52gaJOPRfoc8zoPDfV3BUMO4cpIHIh5i1
         mVSkclolbmzpc1GiepXyyuTSPMykkh2r9dgUSqFJeCR1FWE6UuOjKEPZSNAJkNVqLysz
         5fFLyBs+yGgoVsv8TJijCY6NBTvPZVGsqwn3zG1zsJlktcGRZsMa6DhUDqPragAXJHf9
         KVvTt+WplMbAm6wz445NncsH66vEOp7WZRyNA9D1fBD7vmeWPp8uoBN+uMPC6Ok1N89X
         8WFc9to4CMDjtVEGfiYKX5wZDNZXRKLDPhnPOfckn5q8IqsoBEmDzluAHyUOAx51LEZy
         JX8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVN8x0K7BA3eDbE75wf8Ro4LP/YM3wWvYq7FUjCHqzuIiFq3k3aPS5zBkM8DX2qZCFaDn5XMxA=@vger.kernel.org, AJvYcCVvbksaGFHvggexY95WWCbTkuqCnBNgmUEDMzQgQsFnQUCrevnHsrpr7alkL1jSjSmuvQUE999lTwuMmc93Qgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8KCBEv0g7F6CwJPwOZnwJ74Ovz+Y3b2lW05uIdqeInhWz6G30
	Hvxuet3/L5FtZoYLjKrrJ3wXf1OBicmGqpAiGl5MKLm+wv8L3P8PNa+q4JmL
X-Gm-Gg: ASbGnctbE035zstUIx5Yl6/wJNpl0FlVlSki9mqA0SZvQNyS2qmMpIA0FSEodSL1UER
	d5oK/JDokhfVCVrztsJGC9Vjhpi471leI1iaq0RJ7xCZYzRHOtw8Ci086ngXp0czjNy7DBWTyWo
	IzYRI7eCjPebd3Qymd+YbbKJbRaTiZl9E3nkBoCVowRe69AVTeT+GlSgSQT1krx/ucQUhe9tnD7
	1QfkNyhpJdqTHaQEJtLXqPA2rHwFnMFr9SJtKlcfYkniOnYW032Il/KojziQn5RYRkE1FYbROdd
	cG3xqeoNmhl2bj+PmA==
X-Google-Smtp-Source: AGHT+IHYRh/hiGPAcCFwkd14QTEDgHU+GnCBivxSODUgKP0REflraKvEy+dDEn0KGk1FyUJ3fyjtDw==
X-Received: by 2002:a05:6a00:2c86:b0:725:cfa3:bc76 with SMTP id d2e1a72fcca58-72abdd4f2a7mr2880171b3a.4.1734675675736;
        Thu, 19 Dec 2024 22:21:15 -0800 (PST)
Received: from snail23.. (p7659208-ipoefx.ipoe.ocn.ne.jp. [221.188.16.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm2158548a12.23.2024.12.19.22.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 22:21:15 -0800 (PST)
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
Subject: [PATCH v7 3/7] rust: time: Introduce Instant type
Date: Fri, 20 Dec 2024 15:18:49 +0900
Message-ID: <20241220061853.2782878-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
References: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
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


