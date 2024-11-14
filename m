Return-Path: <netdev+bounces-144698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B278C9C83B3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20ABB26960
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A527B1EF95B;
	Thu, 14 Nov 2024 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHgNlbkb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C21EE018;
	Thu, 14 Nov 2024 07:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568020; cv=none; b=cvh0Xnpxyn4fktJcCd2py2W6iiDcnpN5NkQIdMSWpn1rpwcrz6ntsvg5nMowbAra1LX1etbihBYlAIK3qPTeVi4KNkS5JJ4VRoWODD2hDv7DXQdcIrx+sCgYm4bp5mKXXDWNPv7HiDPUtrXhKiwWTHHlNcst/ICl+zTByRd5lXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568020; c=relaxed/simple;
	bh=tZkOshAWSGactm0EQv1YdTABOHlR5Eq+JZM9H1xmWhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6TdXvLkeKYVv7orJkgZlP212ko2dECK4JbDVZ4t5onj95081ETan5OAIO7QGIf2aanbfApezps2+sjeSZUyhNFexXb8F7I/G49BHLl8yEHvKARqxAFITPpt5IGoiBuGPkvDXYg4WHzMobI2RjbW18k5J1HclRqmXaN7jkV3xuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHgNlbkb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21145812538so2010085ad.0;
        Wed, 13 Nov 2024 23:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731568018; x=1732172818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKV96Ua35gYpKAf6j7w0Qp3ANNf3E5xmw9JmIBsPCj0=;
        b=GHgNlbkbC0M/CTgv87KTeXaYoNfMpYxuW6Omz/p2BW75BXrLcToNkxmYjnX/MApqMP
         4hH/kK9jDIpoc5961s2cFINmG5QyVyHRnQ3HrSUIknMlgu8RcQ5nKW4hNGGf5g66ekRp
         QCCYXHr+N8nV6Ronks8b5PEm5NubXQI3QtFjE3lvy4+0BTAWADaBjPxy1ve3UeZi4iz4
         7NCPhFkB+azo6eNPmAA4SJMBK+bP+3V3FOTwZknFiek1zYIP5lAYBFqOGapi4elSmZh5
         Y0LG7ZinHqMEyw3qTbg9VbM/y9Q+A8XpyEgoESdXMwcMqI9TGrb+weS6X1Fnr2r2lZKq
         xILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731568018; x=1732172818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKV96Ua35gYpKAf6j7w0Qp3ANNf3E5xmw9JmIBsPCj0=;
        b=AKS5RyvEkpxfkveUSZ0W+FxGxM48inZcm+vHPkZ+b6mIB1F9fsc6/+6xCx3UWf8/9M
         h4ZwWbC95/0jyYnPNJp6cNyAzPNjSUzvEV6oBCO2uKWIf9VjnGNpD1VZN/HhFz1Z/sSN
         nNZBSEQP11x/hbSQJf0Ou241Fjv43KmN14rs1SD/QLtugGlIvVs7C3QyxJadnAsA6+F+
         MxdXbmXjr4N1hJaNKiZTfnXGOLpXfqXLzcPiS1umMfP5PvUz7UUbstQ/xlduFIOzNfHi
         8aZGrVM24JAXpaThOjigqRnW3E0kjAet1vW2ZXSOLBAs/Xgi/e+PEHJ/JCFs9MtSZCY7
         kYsA==
X-Forwarded-Encrypted: i=1; AJvYcCVulVIYjnexNaa4rF7DJzdcvvzNtzJC3Spm1X9KvXpARCNdKVUOf+ItlIW+P+WTthi92ap/AcUokmoe5F7U5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJoGpWZO9VBD8ptspeNERjVrx9XnRg9S7zvTYYiSkk2/ZBRWrc
	xjZj/+CkRNi5/NGuDPaOxyY7aVBKYU0+LIDH3UI0kTfCYQspOHbO+PbDy1w6
X-Google-Smtp-Source: AGHT+IGKcSsT5X+tYlpniPsTidkG7q/kgD54IMaWvC1NkgcDlj4G6Tjs6npWNur7rSbaHiezyTdREA==
X-Received: by 2002:a17:902:d508:b0:210:f6ba:a8c9 with SMTP id d9443c01a7336-21183c8cc59mr323740565ad.17.1731568018175;
        Wed, 13 Nov 2024 23:06:58 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d24a00sm4260315ad.244.2024.11.13.23.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:06:57 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
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
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v6 3/7] rust: time: Introduce Instant type
Date: Thu, 14 Nov 2024 16:02:30 +0900
Message-ID: <20241114070234.116329-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114070234.116329-1-fujita.tomonori@gmail.com>
References: <20241114070234.116329-1-fujita.tomonori@gmail.com>
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
index 1df6ab32636d..ae0d3e3ff475 100644
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


