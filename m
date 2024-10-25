Return-Path: <netdev+bounces-138952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06499AF839
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C437B21B63
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80EF18BC33;
	Fri, 25 Oct 2024 03:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7soFECB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C318BC2C;
	Fri, 25 Oct 2024 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827259; cv=none; b=I4hoCOtowzbPisa8ksQ8WIYDdzw7ypPOj/C80Nx4r5gVib+LEAsW6HLzsNk7Kl5s+JtUpbn2y8T3iZsox3vdzmltBQY/1sYv9lKjtEcyZhFtgk6D0VQylezQveUOVfE75gWyT8v3yDW5Weuta1lbERI3Ft4AdJkbZX4CXpN5yrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827259; c=relaxed/simple;
	bh=WWGtuJTu9wvkpnnoH5LcrVExK3FmcpN1yivlxzaEd3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLJ+4UhQAFznijbVM6ORa34T1OgJ4JANJEVFp+TVf7Od2xkHS0YNgQ0I09l/NVLsj8arqP7O5wS95XgWjtxDxslRJFPnTqZ3W0HBP4mpp2Z8llchSivUbUNvoc6hRr31feUFLDL1tVJU8SNrEnnGhek7bOl5Jt04tt6ZDPfagBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7soFECB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e49ef3bb9so1033506b3a.1;
        Thu, 24 Oct 2024 20:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827257; x=1730432057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mh8fo9bwk1aebkWeaKEj5F1BlHtvnaOEw/7UyLur6g=;
        b=B7soFECBFz2Goofp+0lJ7pQp539oe1R1JeVd1j8sFj0pZinEGtytKbMv5KB5FtFiab
         S5NT9ceB1aAsOeW6XCNzWoIK4Xkw98MGk2FXex1u+oSonsd4k42YhOWkOYh5p789AOQK
         MuJ1EE/L1QLncA89IGAbY2zYDYLILCTKi0jx6or2nS4v1AU4lnceJbclhwF1L2D+y1xe
         rZWV7UIt+Wa9VMeF3jmz3Nm6j4dHIYwdsyy9wkk+eWlWy9l7xqEUeTmXle+QSWEion5M
         gU+OqT8OXqnUwOdpglSltje4951KDFh9aCG5rqS8EeWtEqoQTx1KZ6Vg4l5L8mcu/+jm
         88hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827257; x=1730432057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mh8fo9bwk1aebkWeaKEj5F1BlHtvnaOEw/7UyLur6g=;
        b=NeIib7vnkzJeStY0eryagfzvtCjWjVhJeELdXLMsq4wRlKDYEbX5RFRQj+bGfiaZHv
         +XyiCaXMIVYGTC6BXweL2EuXOfmsH6cyXtrR8TqgbCBoSyOPTrNp/TMA/30k1Anhtwdb
         r3AiFSTypBakEXcoJAVKtyqXnyHnbFQ+q3cLRq/VIp5/4nbtqbrj15OOqBKrjLT0Ct2X
         ASDWtJUbw5Vhia+Hp5t1M3DNOjnbvuST8pc3SiKDvR/UZv/SKS1XH75W7bhsNHIXlp+L
         BIw/NhMU9coYW5v8AM4Is9AdYSRxYFNG0bBo4MByfWJIzqoO1WtgAaPpC3Dq/pNcNqhk
         5nDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhMrv7igzVPLK8vUlg6BpMjFTQfXnxFIL7OcVxaswIeMhTrHg6fwfndeXJFY0Ncctr8jn1rl/FqBM11PRmntA=@vger.kernel.org, AJvYcCXSb0swQLXKaFax+uAFnguGxYI4FK5YBWPonznpy2+Cu+xDBIusobn9iO63nzW003HQXhuIb2N/pC6WcoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKI7S9ilzd1zUruJqbwoKI7vsHVjvDgpuLodACRPPaINUvkjsT
	k0Lv07M3B5bBtNtECDem0bXPQwWUejQrwV5kUb4Dtk3PAjHRpbrK
X-Google-Smtp-Source: AGHT+IEn5Qc+9HP5rdo2t6yCvtM4U01ZPbrRv09yZk7sTwAUlKD6bKTKT+vNP8qetO6KZzb72CMkaA==
X-Received: by 2002:a05:6a00:2ea9:b0:71e:6fcb:7693 with SMTP id d2e1a72fcca58-720452ddbf9mr5562279b3a.12.1729827256864;
        Thu, 24 Oct 2024 20:34:16 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791db5fsm180188b3a.11.2024.10.24.20.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:34:16 -0700 (PDT)
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
Subject: [PATCH v4 2/7] rust: time: Introduce Delta type
Date: Fri, 25 Oct 2024 12:31:13 +0900
Message-ID: <20241025033118.44452-3-fujita.tomonori@gmail.com>
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

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 4a7c6037c256..574e72d3956b 100644
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
 
@@ -81,3 +87,46 @@ fn sub(self, other: Ktime) -> Ktime {
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


