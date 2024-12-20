Return-Path: <netdev+bounces-153596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BEA9F8C9B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BFD1896DD3
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 06:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547491A00ED;
	Fri, 20 Dec 2024 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP//NTQC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FB819992E;
	Fri, 20 Dec 2024 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675673; cv=none; b=hGSyfi+7wBD+UZTjHpUwCX8r87Jw7OJub7E9Ge5agrvYjZ5NHeXIj1/foXdEQpJUGBLHvgpAV8cdKPye535dufqBFKGSWunKb9TQOkDizIF4vX6vSSTbmAY5ss0yL/wdoz4Tq2xmLmGweDOK79wVLj57OGIomAgKY09Ew9iQf7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675673; c=relaxed/simple;
	bh=CNoU4j5DemidNSsl2YlTp/ZxnKxH4rxzD9POXhZ+6rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZd4D7omofZFiQLH2K13LlvhrZ04+CTes56SGLkoiKahnNWx+qRUcGVS3R7xjLBn8HZ5i+VTnQ9frvDoiGEY6tvDRyiyMJuZ3yzdxoB9vWKFTabFfkZ9Breystcd+jX7ClQJbFgc5dDGwRQenZYZf9uAV4CiQW27M546+AWr1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP//NTQC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728f337a921so1670291b3a.3;
        Thu, 19 Dec 2024 22:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734675670; x=1735280470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JybksRFzIQq0QOOnjY7EbBhGN4P7Dv0rI/iDUoagoPM=;
        b=HP//NTQCI71V7tG5U0M6B1gXdJ/o2E8rJMreudSviqkRKLWFZW5HCMxXSbDPYXRASH
         ax9+AcEDQDOxpi/ZyD7C7UvMRGuBdoHV2GzxvRcPXdFZo6ke1j6v7JQRIiw7Gxu73nqi
         eZ0C2VWc5f6NMniq5XlNY4F0NcSLJkwgs62tFcnH2EgzsIHz1vaHiBelGVbCPyrDlRP/
         1b2huwsYeguLTU2u/QSLPMDujKqUB78EP0RxvDUxTBegp/iVoVJnN60jGBVLI1yED7H9
         AiqMhIat6o9ArwKnTREnmZ2jlEqRigZ0P3IrsuhIdxwYVmaVj7KURNOaui3gHQ8CM9gX
         ICWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734675670; x=1735280470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JybksRFzIQq0QOOnjY7EbBhGN4P7Dv0rI/iDUoagoPM=;
        b=ccF8j0Bp+j58zsr49elYpjjmG3kOA0O/8lBhLUGXYeb36DdVoNcmn78xNgBabNtd2W
         nEHyZw6GS1KD/v04+mQXLDb3ZUGTw4l8K1kwJ3j1T99Q4mymU1LrSM5AlB6s+SLevMup
         jCQZ2+TBiixCVczOlIMcVBOSRNM2a7Y6RhNjzbZ+O85tyTxWzkIr9o0AHut/vY0q4SL6
         uEGivoCDvCvVcG2ZMLQMaqCJO6JpHBne7tPdBxR0sSRG2EtWol2Jlw57hJFB8J2aSmwj
         CiU7iACY7drjhMME24gv3IN5avakv7fN0t1F7q1AYxqiRMSRwbgE99cfZPW1pu1PJSaI
         tO2g==
X-Forwarded-Encrypted: i=1; AJvYcCUNwucPskVFgezUp1xN/KogZQlNq5EDhuK76Fr8aoD8BQtqButUOFd3C5epFTEv4G3+oS/WltorNLuTaUUp4wg=@vger.kernel.org, AJvYcCX8B6LhxJr2ZHYqEfhgmeAYTS2/z44Cu2YMuFVezAlz//tgQDZ3+J/kFQU09UFBQPbwXDqUffo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztv7GO8iNFrZkz1CGSRlk2aaDyfNYLSngW3XcEXxwUuSjhbNor
	nFJyRR+mInk3SRJF32oQe0Un3/QwMN3XMwiEzS6fuPj57EUxIMiljVpdYl0+
X-Gm-Gg: ASbGncuczTYT0vcSqogFwfL2k38x481ogPo81COvdoVhUhCI5iEslScbro0H2mlwJAo
	08gqC3OcFr6BtmY9FPLyLLepHOYY8gx8WTgC07aVJCczFv9pklE3t5V1OLyOXWloiQMB9EwsX+/
	Cmy49gJTsZmvmeZ4BItLJ9BECq7BiQbPlOZXduUYHks48N70rlw3oic9ES8JfiN6TLJld6BvvL7
	VPXoikniINId4CkyM8kAUxf81sPoNoqG9B0LN2nJeGGET4OkFSYenCZwTe5mn8q6usvjayk2173
	452PVnrHTOPsOvauZQ==
X-Google-Smtp-Source: AGHT+IG19mcv21P2d2vJSQG45OU3NBCDfrtktwnunWgNY4wcL35ZaRl+SNGmky9n5T3eNEKVbK8o3g==
X-Received: by 2002:a05:6a21:9985:b0:1e1:b183:2243 with SMTP id adf61e73a8af0-1e5e08432ecmr3394485637.39.1734675669726;
        Thu, 19 Dec 2024 22:21:09 -0800 (PST)
Received: from snail23.. (p7659208-ipoefx.ipoe.ocn.ne.jp. [221.188.16.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm2158548a12.23.2024.12.19.22.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 22:21:09 -0800 (PST)
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
Subject: [PATCH v7 2/7] rust: time: Introduce Delta type
Date: Fri, 20 Dec 2024 15:18:48 +0900
Message-ID: <20241220061853.2782878-3-fujita.tomonori@gmail.com>
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


