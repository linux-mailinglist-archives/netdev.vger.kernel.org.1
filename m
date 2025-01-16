Return-Path: <netdev+bounces-158749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38984A1320C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F8E1887AE2
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96541482F5;
	Thu, 16 Jan 2025 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBMGVxNc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CB86323;
	Thu, 16 Jan 2025 04:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737002563; cv=none; b=s24yh9GYWJdD3oxRLvZuHKiSSZ8ws+jH1elBSQCF31HDR3SIVn3/KkneN0YdgUW2XjbrBgnrS5JgUqoBlPt9AC1m2fsxJpZ6ZNcYROhR9MtythT4WoORjWWTWlrd9NibRLUAj60upSATnQ1Zf2PKjtOlmX7cPRpI4eFsEFO1aaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737002563; c=relaxed/simple;
	bh=CNoU4j5DemidNSsl2YlTp/ZxnKxH4rxzD9POXhZ+6rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEPhmeUtKrd2KCu029XykCp0sz5ldZ5BrQEUV/kANpYgQJb59KefTFnEy8/XE67wNXzKegPnyztKHo2E6TPfwaOuX+zynBCzoMU3+mIrWVrF3W/R4IGTivc9mA9DD1z1NcB1Z9TqrSHaBAxe4YmFYvCy1cf2CE6gJ5sbMkNUehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBMGVxNc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21634338cfdso10385255ad.2;
        Wed, 15 Jan 2025 20:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737002561; x=1737607361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JybksRFzIQq0QOOnjY7EbBhGN4P7Dv0rI/iDUoagoPM=;
        b=iBMGVxNcV6A1rmgVHFY75TG/d9hIL0JDQEv9k5gu2nGwoCfsFuKe+wJte/zi9zSlbi
         0t3foy+uIcDjkklo8st0B5BS7zZcJoI24TQ+NcmQgfOVHealu7tGuAYtZ7x6RKLIjYJt
         jx5i/ATXVGQ7neZOKXtgfqN0cWl5BP3UOobUrvk9HDK2ugZr4peYmkU7mL0SbMQ6Sg8N
         PfEBY3OujtB9tHERENduz+MqQ5BPXQjwI0fPf6d8vYb69F/nJbg+xbbwqJMp/PDGsvgb
         ch/H8+m3eiHpCRUb2M0/cbMMqMXPl2mkVqhym/X+VLDzgkEnFdC99I5o+xw7DfKWcHqF
         C5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737002561; x=1737607361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JybksRFzIQq0QOOnjY7EbBhGN4P7Dv0rI/iDUoagoPM=;
        b=QtI8NLM9YlAyCpVm8JF6vToqrCZs1e9XPF7PLfaeEQlqRyxqSQ6flxiAQIg5MDcv7b
         I6OooWgqKW10ZuaAjGfGP9zZc80ZoGRUTfT7/hZpsRDH05BdWjeLiHbdKc7WTY4nqsKF
         1k1MuIyT6gbSfV50s0KxsJfaQduCC3A1/tGdqJwyaS1KZ1oRW+mxWVkcXrZ65rHOZ6Sv
         CZc6lPTeUw+4B1TwP5mq6z0aI0wICFiHZfEzJ28PAAURofwRv855M41ac+WIPGqdT4Ce
         +ahM3+fs+eEujAmvgPgMZjTiJKKzerqNji/h6g+VvhMMkNmPZmTSSj58vFpu+hTnYaYy
         EAJA==
X-Forwarded-Encrypted: i=1; AJvYcCUNHscYRxbYdcB6R3dCoZpSl/Q5Msd/AxBCXTRQFlkPcRKGLbjbw7MJwdG6q4WfAp9CM2yeTZTB6Depueog1a4=@vger.kernel.org, AJvYcCUzARaEUDTF9bbWeCHO1Z1o+NtGAyJwexcI5DO1cBFQ3PXrNv+TefVYKt+vDrZ5gZshtLw+FaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMUL3U69gXVByRaNinCC4qppx4k3MqNXD1Tx3c+iarOm3cAhrD
	dAb8xERCBlj1kdLCuLMgLxZGO7SmUYG5FCQwHm8xJXioydTjTmKGC6ZXf+Gc
X-Gm-Gg: ASbGncvfJTZQtR9qboQA7y3vZazN9Pf1uGizCFYGKQedpgECiVpKWcjfJryckbltvvv
	bEaxON6/07+U7UOhdf2b5Jnk63hYoacX5PjGvb3DVB3wCNCJ1r753939K3koU/pGd7Xju37/8Bj
	oehMKlE+cpkUuFzpW+sLi2PfvEQtrq1E4pDiS60lPM18P1QDpuz7l7BhAcxgtkmPoUoONjCUc/x
	1+u75oA6HIUISxpHqBg+oJlhLXsq6R5gJ9/ftItiLxwwtRC5EMwCzbshI7XEw1aL+BbS28HXL0g
	A4ArftnvMeu3gp4GPXwWrTworYO/DE0D
X-Google-Smtp-Source: AGHT+IEr2vOJf92WyBIfEJbp1W0orVXFV9U/V2tiUnsAO/7H9HpuqdhAioJi1KdurZDvqN7TgJEnuw==
X-Received: by 2002:a17:903:2301:b0:211:3275:3fe with SMTP id d9443c01a7336-21a83f5243cmr268617295ad.17.1737002561053;
        Wed, 15 Jan 2025 20:42:41 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217a60sm89161045ad.158.2025.01.15.20.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 20:42:40 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
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
Subject: [PATCH v8 2/7] rust: time: Introduce Delta type
Date: Thu, 16 Jan 2025 13:40:54 +0900
Message-ID: <20250116044100.80679-3-fujita.tomonori@gmail.com>
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
KTIME_MAX, which different from Delta.

Delta::from_[millis|secs] APIs take i64. When a span of time
overflows, i64::MAX is used.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 63 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 48b71e6641ce..55a365af85a3 100644
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
 
@@ -81,3 +87,60 @@ fn sub(self, other: Ktime) -> Ktime {
         }
     }
 }
+
+/// A span of time.
+#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord, Debug)]
+pub struct Delta {
+    nanos: i64,
+}
+
+impl Delta {
+    /// Create a new `Delta` from a number of microseconds.
+    #[inline]
+    pub const fn from_micros(micros: i64) -> Self {
+        Self {
+            nanos: micros.saturating_mul(NSEC_PER_USEC),
+        }
+    }
+
+    /// Create a new `Delta` from a number of milliseconds.
+    #[inline]
+    pub const fn from_millis(millis: i64) -> Self {
+        Self {
+            nanos: millis.saturating_mul(NSEC_PER_MSEC),
+        }
+    }
+
+    /// Create a new `Delta` from a number of seconds.
+    #[inline]
+    pub const fn from_secs(secs: i64) -> Self {
+        Self {
+            nanos: secs.saturating_mul(NSEC_PER_SEC),
+        }
+    }
+
+    /// Return `true` if the `Detla` spans no time.
+    #[inline]
+    pub fn is_zero(self) -> bool {
+        self.as_nanos() == 0
+    }
+
+    /// Return `true` if the `Detla` spans a negative amount of time.
+    #[inline]
+    pub fn is_negative(self) -> bool {
+        self.as_nanos() < 0
+    }
+
+    /// Return the number of nanoseconds in the `Delta`.
+    #[inline]
+    pub fn as_nanos(self) -> i64 {
+        self.nanos
+    }
+
+    /// Return the smallest number of microseconds greater than or equal
+    /// to the value in the `Delta`.
+    #[inline]
+    pub fn as_micros_ceil(self) -> i64 {
+        self.as_nanos().saturating_add(NSEC_PER_USEC - 1) / NSEC_PER_USEC
+    }
+}
-- 
2.43.0


