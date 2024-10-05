Return-Path: <netdev+bounces-132365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA3A9916BE
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12481F22DCF
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6918F15532A;
	Sat,  5 Oct 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS0lBMEo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9A1552EB;
	Sat,  5 Oct 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131185; cv=none; b=VCWI+6n5Xz2VEFZu7+kyr3VrfOZnecNAALeY+mTVYN3pH2sP6wFFypOvZ+w6O67YUda7OzYNNaBVzpEFQIL1IH997qu9inav0oQc8yZUPFEkWYnIwxYYWeRxYgZZRBvMP2Qo3efrQsmEGUMRSRhYbwMT23NJvoEYU8OR8lS8vEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131185; c=relaxed/simple;
	bh=JNqDJ7f9UtL2t6PrWNiRsLuZ8p//mFWPbl9Ykus8zqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvvndRojryn5Hf3iaWbik7d/WKm1LVtZ29+2/0K8l0j5pdk3GR52RWzU8nPcW1WOyLd9eiQIEdUMW0SlbmAcaCRJQc4OcoWtvG66bwKtV5rHK20D+qnv9Zj+MiVoijawhPTP7iVkXeaY2KS8OF7T5QN5Y9uOlyARZerYG0u7yCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FS0lBMEo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7179069d029so2305377b3a.2;
        Sat, 05 Oct 2024 05:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728131183; x=1728735983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tvk/vZ/FBEf3YBO7h5QV1zQaPOZaXxyH6QMku/LV1UE=;
        b=FS0lBMEomQpxXYdMMJxmn81uDVaG2XIMKYlFCDOQ3XwvYKC/oBO7JOu+he3SKQ9SAQ
         VH73tvd5LxVYylzCJB6gBDJTjk91o0JXyJMX5k00ViI+G3JpUq6RBxLrIT51FxsT+IkC
         KfmnOkgiIxJp06k7qqcjQOVH0hrwl9knhJZY9uZVmpLDfWl9sfxLEbf7HcpwkHJqwFT+
         kPbLpbwBZMrsqiM6I8iu5zv0aIR9/tFp94n7i7ILc4YawJpi6kDnTNiknvtAOZCm4t+O
         3qNHbk8uX0+aSAnZC7uJuLYS6cEDIWDKPj1zsis5L9mdvDugnN0WBK8ON4NTGdxv2trp
         j8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728131183; x=1728735983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tvk/vZ/FBEf3YBO7h5QV1zQaPOZaXxyH6QMku/LV1UE=;
        b=XOxfx2bS2I05TpoXiR1Rzpp1L418/WFpb2/lzdU1v/okGeVXVAYFEO3gCBYhwLSsfy
         yX06DlnCD+Q6jQE/49H89+dlBYFlbEGVlNvhHuoSC3Epe9ZyxxKjAimMeGVMMyumDOkm
         KGMUDW+ZiKJVUx4RgQ8LIS+e3ey0KQ43RyGMPpuhuDcAUYzcMTK9h3PfTUEQffVLxWg9
         qTTOmmNMSF7kPAP/ihL6SDRUnSw6qFpdXp79zcuVZQutG8NjChD+v9UDGtxdXt5jv+nL
         kBI2ApdZ+7yLbnfno8j8L9HFXqhUAqNBlCPK2LLRjksWnECn06lAfpTJ3/vkhPmB+K9n
         zW5A==
X-Forwarded-Encrypted: i=1; AJvYcCVCviQNsIIaKwfdx/QH0KmM2hQf4DQXC9JLJF7hepL4d0vL2TEVmLW/ut8XgzAUBzeDaXdkSYqg1hQyt1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMmYK/D0HkRcbaXiZ0h3JvfbV/gkOxNSUF1SBX/O5/8YUesYH
	rPRsJZG/kho7G4bDfywoJT1rJDohMIJNz5kiUdtMRWB7uJA7vWHpuSOoV/Yc
X-Google-Smtp-Source: AGHT+IFVQJR9Cm7+64FWR6kRSvxRdFLHQ+iNTReOqxqohFrFYjZvpqPNfuGQmV2v9HjjgzYxo/GMXQ==
X-Received: by 2002:a05:6a00:178e:b0:714:173f:7e6b with SMTP id d2e1a72fcca58-71de23a691dmr8474920b3a.2.1728131182885;
        Sat, 05 Oct 2024 05:26:22 -0700 (PDT)
Received: from mew.. (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd08besm1397878b3a.79.2024.10.05.05.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 05:26:22 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/6] rust: time: Introduce Delta type
Date: Sat,  5 Oct 2024 21:25:27 +0900
Message-ID: <20241005122531.20298-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005122531.20298-1-fujita.tomonori@gmail.com>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
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

We could use time::Ktime for time duration but timestamp and timedelta
are different so better to use a new type.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 64 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index c40105941a2c..6c5a1c50c5f1 100644
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
 
@@ -103,3 +109,61 @@ fn partial_cmp(&self, other: &Self) -> Option<core::cmp::Ordering> {
         }
     }
 }
+
+/// A span of time.
+#[derive(Copy, Clone)]
+pub struct Delta {
+    nanos: i64,
+}
+
+impl Delta {
+    /// Create a new `Delta` from a number of nanoseconds.
+    #[inline]
+    pub fn from_nanos(nanos: u16) -> Self {
+        Self {
+            nanos: nanos.into(),
+        }
+    }
+
+    /// Create a new `Delta` from a number of microseconds.
+    #[inline]
+    pub fn from_micros(micros: u16) -> Self {
+        Self {
+            nanos: micros as i64 * NSEC_PER_USEC,
+        }
+    }
+
+    /// Create a new `Delta` from a number of milliseconds.
+    #[inline]
+    pub fn from_millis(millis: u16) -> Self {
+        Self {
+            nanos: millis as i64 * NSEC_PER_MSEC,
+        }
+    }
+
+    /// Create a new `Delta` from a number of seconds.
+    #[inline]
+    pub fn from_secs(secs: u16) -> Self {
+        Self {
+            nanos: secs as i64 * NSEC_PER_SEC,
+        }
+    }
+
+    /// Return `true` if the `Detla` spans no time.
+    #[inline]
+    pub fn is_zero(self) -> bool {
+        self.nanos == 0
+    }
+
+    /// Return the number of nanoseconds in the `Delta`.
+    #[inline]
+    pub fn as_nanos(self) -> i64 {
+        self.nanos
+    }
+
+    /// Return the number of microseconds in the `Delta`.
+    #[inline]
+    pub fn as_micros(self) -> i64 {
+        self.nanos / NSEC_PER_USEC
+    }
+}
-- 
2.34.1


