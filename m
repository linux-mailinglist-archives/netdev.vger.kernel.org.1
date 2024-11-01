Return-Path: <netdev+bounces-140859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6FF9B8819
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BCDF281D83
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB6F45038;
	Fri,  1 Nov 2024 01:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSksDpoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0E04D599;
	Fri,  1 Nov 2024 01:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422948; cv=none; b=cSgalrtkDGXiN4mLd/rmu15MUHML4nIAFY2NYW4NYZ1SBC8Q2dVDUKVwvF2YtBQnNcpdLQiLV9G64ypbR3hf/nplAO5phBn9HYNICiJYAnucgs9EFhNwvKivfB9MHZEy8bm8XLgbUAPKcbw1AELhXutqaIa1XuCY1LdSg6dwT/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422948; c=relaxed/simple;
	bh=3l3DdrvXhQbQdgKLu1mca5O/A7DDoZLjSiqXMJiZBOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POSEqFWkNTSuJP7CxXWdTHGaRHXRunzdB4w/8gz87FTCvdpd0vQkDszi8W1sh6XlKzIn9T8GwAO5LmrR0MSWjvRnlgamILQrJ9cM0ZlSblaD/oEP/uwjyqZ/W5vlaDE1qG2FMevERZ8BHnX8Nq2HbUamD+wG6NhSnKE/umH09n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSksDpoJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720d01caa66so136255b3a.2;
        Thu, 31 Oct 2024 18:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730422942; x=1731027742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6DjLAHViVa3N3XgZMB4Dtmm1+ysQiv0CFhsw4EncfE=;
        b=bSksDpoJctZtCwpRWZjMVPKWeKExmKmuukk0PueILm3mJaKiJ7MF0IUmBysJ1dh1Ft
         qWVYToTUu4kjUiFJIf/bOpIKk91qR64Vuc7VQRXMjC6M6skd4LlOzTe5dUEmLvuozO2T
         ZRUurBW4S6a8u8KZQ1DDTIJGS/IXN3T5eYhbIS5FrozAV84/CxICOjX5w7zJfIIv637q
         72SYJn8KP95PZWReJvc8ZtF+zRCn4vvvz3TSPfRILwbMHAGVlgREub8N5Q3uBkqjcTM6
         Ef5ZUwOcBW3+TYCDDZ1kRjbPlTgUS6wmbSX20MqiqUCux81eXLaCfMdOXwx9m5wgxzcr
         aNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422942; x=1731027742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6DjLAHViVa3N3XgZMB4Dtmm1+ysQiv0CFhsw4EncfE=;
        b=tjCMl1t2BHdmPO+SycYBFKCxL/ggN9j2OgHHwd5PRYXIpOoDkKELjRRS4Vb4M7SLLb
         25f0v2KyhFCBLKPl6ClY+m+YGKi282ww7X121FoeuRxGUHC6t/JABTh/NjGSx8rFVoUx
         Jqs9Hc8ZAxmdjbLwMcYQvUVV3T3tfBWdF/UQh9pB9m11rQUlTzzYwXoAoULDC86W16Yf
         fHAQychi4/aczscgzTco8bVg4ptcBUUeMXX7Qmopj0GZcnb6ApXIqntbqYaUCza2UEfB
         LUc2j99BczWksOX5BRDyrrkW0mhXxOPjLmugXIiZUZKegWh+PyTmiTUHPW7qn7w1fqOf
         RN2w==
X-Forwarded-Encrypted: i=1; AJvYcCUHvhv0/hHQMCCBkIc0loA3MnWEpp93ybmioRus83zt9wBfnEECXvwSv3iBJqAoGHrJKvyFE90I1Upf5cU=@vger.kernel.org, AJvYcCXVELG4yPLenAoSd4WJHwLfj21/U8jMCVMfngO4Wo/jU8YeSey9clrSqp9a+tupF/ZDkfvdhvb55LwFKNCBKyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9pavU0g6h7bwH6jSQma7aL0D4MSDmhqhmQGmiIJDPuNZnksXL
	kG0vWHPFzb/xespfFGfZe/ZyCuttxgyqzUK5mwpYPh9gec1wVeCt
X-Google-Smtp-Source: AGHT+IEJsh82diESCENfnMqEG7eGqPX1euFeN1oc0n8jzzl3OeosbLM9F5ISpsHYs+KNLqO+dRMnVw==
X-Received: by 2002:a05:6a21:2d0b:b0:1db:8d70:25e7 with SMTP id adf61e73a8af0-1db91e68234mr6729919637.34.1730422941597;
        Thu, 31 Oct 2024 18:02:21 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ea6a1sm1743403b3a.74.2024.10.31.18.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:02:21 -0700 (PDT)
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
Subject: [PATCH v5 2/7] rust: time: Introduce Delta type
Date: Fri,  1 Nov 2024 10:01:16 +0900
Message-ID: <20241101010121.69221-3-fujita.tomonori@gmail.com>
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
 rust/kernel/time.rs | 57 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 4a7c6037c256..dc8289386b41 100644
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
 pub type Jiffies = core::ffi::c_ulong;
 
@@ -81,3 +87,54 @@ fn sub(self, other: Ktime) -> Ktime {
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


