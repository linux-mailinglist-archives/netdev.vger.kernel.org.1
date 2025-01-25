Return-Path: <netdev+bounces-160916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E9BA1C2B4
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 11:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1884D16923E
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11851E7C08;
	Sat, 25 Jan 2025 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbnr978/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556ED207DFB;
	Sat, 25 Jan 2025 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737800423; cv=none; b=IAVHxinC+OGRCV6eBkw5JqMQH3c6O97CB/NuhmQiU8FxqYBK49BRVTaB0lg5I8fdMOR5Vebo2KL9qXZYQc+I9FvOx3eM9qomsbjxPc6emnYDhNyeivwgHxoMGPghUVTdCuFhTqWjhKKCHBlxpRKU7iYrjQyE59jenej4aPxHlpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737800423; c=relaxed/simple;
	bh=npkLO44nwRn09hWn3AQ/PzjMZSoIiZHcvuD7B+YVOC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT9ZFFNyVVS6dD9/xCEVXekwb5NgMlZAij3itfiKMvbALm0OKa3fQ/fq/bd3H7NhWV+dd6j6wKh6XDYMiPJjB5aL2zM4J+I43lTGk93BH+Hxo8uWDzwfqMiWxbMksfY6z3se1UvtRMQZRNINSt1k42EGthPel2dATEIzls7ZeAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pbnr978/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21a7ed0155cso49813755ad.3;
        Sat, 25 Jan 2025 02:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737800421; x=1738405221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1QG+0Fo21HAylZ+jKq45RlAJ6ob2hW+fSi9sEos4xU=;
        b=Pbnr978/6NqzS3wmOmDow2cHlDEsfDowVLzjl6Ei7ixypGgI0mHEEgBC5VlvNpLBpz
         jFhk862UOGbqMkExahWXwbDZibldIr4CNSftcgIcwzp45YIec0v6NVvO57dUkgot6nL2
         ie1nRVzr9sGcaq/b1x8p0iu//tQufXzTzq2RMmZSGRshMkw0MtURG7f7QUJohO+To022
         ghQuaNm5/gDR6DZFJEaLjWgdzB+Nl6vG/okFMYpN6YKLzy8jmwBSLtfuJE3SVww8IZTq
         /S9g3MUjEEw+q24VNQVJhGnCP0tJnEXPOsGOkQ3ZFqMwJTUf3OJ125U9hpapryhSZpbf
         rwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737800421; x=1738405221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1QG+0Fo21HAylZ+jKq45RlAJ6ob2hW+fSi9sEos4xU=;
        b=kBP+qWiy0U2RuXjDmc3LfJ6PVbc4HNWDuwUwaLcPDtWYDjjORJnEePAOEuMJZq5BHr
         ndaght0oY8roeQy+M9Oe9XgtZc3V9rFX92Rtf4Yh8zlzw51eCTSioQgLpz+w3rNBN28b
         neGdgfHvX2X4KrheEPXLjRP3n5ru9Fg+OEFlBfYASUgCnQlK2viz6MnWsF4xgfIc3L3i
         iPRM622RZ23JKhP9x5O6TiYE+gPEsLcruJBJf3x02cQhpTZ5bkkWFrLTMxJJdWd/6BoD
         as5hRsd7Un2tIWDICgC7+fekQibueiQUM00K5/CGqmN5tzR33grQLkbXVv+A8AEFn05T
         Q+3w==
X-Forwarded-Encrypted: i=1; AJvYcCVFGq0cgBoOX5i9E1pnkwrqbF9w1wRX3xLsK4wxzzcjG0GTWbse0dAaBn+gDBmw7o4JEfJ7wQ+1QHfY+LlDE1g=@vger.kernel.org, AJvYcCVMb8IEiFJETJTioNDpeVjxtfYo4WUnL1iZz2r+VrzIAJHA4ztIAH01NbyTQXdP7nIkQGv1OxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ItAunYjrCdI/5ySnzyUL1kYvCrNprqWOs1hcdvAqFWZLouh9
	TMX6docIGMgmVL2K+S1PJmOGBs+wqUEGFpug0XOhCZRqOrLvoWCIcmNgcANo
X-Gm-Gg: ASbGncsnqDyAg3MfwqHwbj9zlEx/OKivy9Fo4qjriKARAf/5MFitd/+TmR9ixTkyvbA
	i4K71AT9q+MBK4KCpZv83PGo7eoA7AdWDrJXEy+ScCKn1a0SHbaEsseLqt+mQz32z6Xkq07WElt
	v7srbOOY62qY5y26iNo5vSKINforksl+ykrOJNUebXR0Pta+ZtgxOOygYQGBpYv18APc1lkyWLd
	r9HSgEl5KFNVNI7bYjYjUhnvYu3Xc7GMzsJW1yBYWjQIkcKFY2REPMw16Zvvsn+wLYZres0pQJA
	Or/KDT3J6lvfO4m7vP7ZTiXPi0vU2bS+o6yFkpqJON/oKSvXzXyaDG3A
X-Google-Smtp-Source: AGHT+IGv468mmgGS62YxtkiQFRdIB4WPhA26i87pIVtcrJQloApknPyQDlTxlAkWqdOMuQGlH5+m/w==
X-Received: by 2002:a17:902:d48a:b0:216:5cbd:5449 with SMTP id d9443c01a7336-21c35407dcfmr514223625ad.13.1737800421376;
        Sat, 25 Jan 2025 02:20:21 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424f344sm29461155ad.232.2025.01.25.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 02:20:20 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
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
	tgunders@redhat.com
Subject: [PATCH v9 3/8] rust: time: Introduce Delta type
Date: Sat, 25 Jan 2025 19:18:48 +0900
Message-ID: <20250125101854.112261-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250125101854.112261-1-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
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
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 88 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 48b71e6641ce..622cd01e24d7 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -8,9 +8,15 @@
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
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
 
@@ -81,3 +87,85 @@ fn sub(self, other: Ktime) -> Ktime {
         }
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


