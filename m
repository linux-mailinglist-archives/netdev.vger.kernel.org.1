Return-Path: <netdev+bounces-184682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC916A96D88
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECF71892615
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB8D2857F4;
	Tue, 22 Apr 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWOCzF8S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C5281535;
	Tue, 22 Apr 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330102; cv=none; b=izv+cVqZO9oCKmt7CP75EKBUVhnO4ckgcD5fmYjAs7+pBaQVZ9PJ8nkuBAlKS7+tPUaKPwkPLFJ8KSZ1PsI/uXvZc8iP+RtKa6Xp9FY8r6Vq17QK0YtwkFwmIyrnSpSBLAyq4J88D8Vhl2qhIomSoPeVxlLyre2z2WLps29WJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330102; c=relaxed/simple;
	bh=12o8EpFplw5vxKVaPZGoT3TplIy82zwNzBv2WcTOE8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4BPfenBCkUm/nFSMd9ohzUVR8CC5tw5RD1N40bGE+DKgJvSeb4loZlt8YbELTaX+BCoDjRVdZ8IBaflDopzS/Gmgp4WwL3Q1ffsZd2kw9GYb/kf9OIufqwkULF0qeOgfKyYzyi6O1GPpBe2bBK8iQE6PUUdcBX3btFv7kooMv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWOCzF8S; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7396f13b750so5576286b3a.1;
        Tue, 22 Apr 2025 06:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745330100; x=1745934900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB3yUUfhGJKZTpW8owaV/xnUEivaCxVXrQXi/bn6tLQ=;
        b=nWOCzF8SehbRYtsPUK93Gnuf21f2ElWXu3KdERKPIbR7yHa9jpJtRrxvM/ir6qQDiC
         fmdarECqxZbng+e2tJK1qAJslORAvFgHKVHlzyO1zM3iMs175JFMTw1DOoRhvXC2hXcv
         R0mArAH1i7Ei2gGAp+CGWJhVqAq1h9VtAk8AGA1ShuEdZ5MFVUWUTJ4bUHI6LyOnKLSB
         mRE6pZdXO6QERcBPeKEe4n9JIh8L67XgaHkgCOvSHNhXgOhaargP0dqMFEzUKMpfEO3J
         Qc0nKQZyCtLoGR/aevI9i4W0U5JBsdREL7pTQy+jcB3OtthWhit6lhW45+S6XAN+unZY
         0s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330100; x=1745934900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB3yUUfhGJKZTpW8owaV/xnUEivaCxVXrQXi/bn6tLQ=;
        b=Sc2yR8k0x0mVJ7Bm0GBo4fJ0xMInaV0lVlx7OO5q9zady6Q59M8LJT+rc+cjD8YfbR
         6848F5ukpFW7mz5DaQXn2sg/5w3dJeF/CvHyZwXUqihEFL1bQQV0pGIs1KhXWqkJBUg0
         cYZtasik/FQaBkyIxEsXcZU6D5T9gJpsLUiFai1RQUti0YOQCqfcsh2sK2peF3CdcK5D
         YzA1Hn2pFajZ5hWZpYsvaC9Xn4Sy9fRGStIcrf3iLGhWaA7+p3skqiPDyc5fGVGVsoxe
         M3A747tDKG6YKJSiJ6QnztFdBLNU9AS/BXML1GDksS1D7hIx+8jQSMYdt9JVGm/2UIHC
         38LA==
X-Forwarded-Encrypted: i=1; AJvYcCXKyEs1XwTvEHbHO+SRBVMQf8dnqhNjKUj2NSIGvG7sKAGi0xFRQEgPogzSjAZWhRVUa+jfZ+WThb1Bqyg=@vger.kernel.org, AJvYcCXUGF4PChWxTNocY++fculYz743ua3nrKCVg8YTNm+UGl248hRdnorABX72E5La8HW4gmV6xTzM@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyVTb5e4sXqiaVsUTHVPav7+rRJEdEenRJIamujSfRT4ExO6m
	QPJcuPM/DNlZ04QiNBxHPZKKmsWwQeUc+7rUGPWDJYTas9/8rv2AgYiRyz7u
X-Gm-Gg: ASbGncsM2U/r3GwUQ6gFrCH4yAaMzaeDayQ13pTVWwErumEuq4qVNC1QS28XPYc1za2
	RyjQtNv6kCKDYHrvYsZklNxvF9wEMN1synfY48Y0BOhDZS1IrOW+fM7Jn878eT8k7Jn3Nhq4yaN
	gH0nnuhvoDzu2NQ1JQJUXddGt/peqLO9+dZdXD/BS4fQlL6AtK8IOD2Bygq7t9Y9XaVgaEBLgMJ
	HjruSh0FIH84w6RdNpUqaczQY/OnjdUzVi+DleYHAJV09p3fMF6AAmxwp/62mUWcH6sF4qn6YRx
	/a2cO5z5T4C/1jWm9boe0o0uw1vCi1Yik5kkenZfX4Myz60nqtFa6S0MY5OITyXfdZSDjn6AzXG
	O8w3cJ5QleBI9elkj2g==
X-Google-Smtp-Source: AGHT+IEWWLVFHgHeX0ZNZinSLQVyEdVz9dK9N1V/I9vxsqL6DoRE7khqVk3usst5VG+jmkiuGGkm7w==
X-Received: by 2002:a05:6a00:8d93:b0:73b:71a9:a5ad with SMTP id d2e1a72fcca58-73dc15a06bamr20436799b3a.16.1745330098603;
        Tue, 22 Apr 2025 06:54:58 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaaba76sm8869650b3a.143.2025.04.22.06.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:54:58 -0700 (PDT)
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
Subject: [PATCH v14 3/6] rust: time: Introduce Delta type
Date: Tue, 22 Apr 2025 22:53:32 +0900
Message-ID: <20250422135336.194579-4-fujita.tomonori@gmail.com>
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


