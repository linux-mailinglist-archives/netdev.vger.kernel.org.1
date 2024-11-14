Return-Path: <netdev+bounces-144697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3FD9C83B1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D5D1F236ED
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA541EBFF6;
	Thu, 14 Nov 2024 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agGCwBwq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA81EBA19;
	Thu, 14 Nov 2024 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568014; cv=none; b=Q2IPZITqoALSRWt+eMwCa7DPKr9cRR8gv2xDqQ3JS3dikUzNsXKKVbuCKyYivipCslwk9JmOq16r5iYpRp4eP8OSa4FIXuJzgDraG8XEKrf14kKHR7itZR/+hUt3KnY9gfpkwvIgwvwlp4yq7VmzuptAk84DCPeeIE6Gq5sMTy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568014; c=relaxed/simple;
	bh=9FuytnUSrj6P+R6JWfz0Tu5tze1hGWVWVAysMwNaFVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sO/P7kNzlxQNgqh/TRTLn8dC+C6wCfo+CLPqW1iPLMP8/9JMHtMzB1FbHFafusH9+GTtjJ99Jaq+865J0HxRFv1bdgSw20g3Ie9HQstNX2GYZoOU0XlUUzrxOL097vjE2n9QDUpfYdxv4DWoVdpBK00bOlRG9e7uhWfMPWDOkHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agGCwBwq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ca388d242so2273515ad.2;
        Wed, 13 Nov 2024 23:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731568012; x=1732172812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtyoKIARQ8seXM8o5IIvlTX2rizP8oksd7bJLCrQQXo=;
        b=agGCwBwqFi4RPJ33veY2P1HJjxTbItp0UeqE0Nstv72PzlRAkg0ehkOQzkyQiHy3Cn
         SlnBx6gr+ZueuTJdwtxSR/1e8T6/tCIvCGXRswhFVaqYsx047H6kaulkOEk05rdn7iMd
         HvqCgAHqMgG/vfKjpYZtUD0BDwyKPwdPEnqCzupbKiSk6hOSb2tSr2MHUOWXEJSAohSx
         Zs4orrgcNdRsDxiUNP5hWmjCECR2OClVqCjkMjA1LK1E/cmqEH0A168FkO1GF9KF9zwR
         maVXH6gWwtpmOE3X5We9cbY1Rizb/qz72RZP/3Ad3Sv6APx+WmrUCmPxZ2YO8rtpGcf3
         Ncog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731568012; x=1732172812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtyoKIARQ8seXM8o5IIvlTX2rizP8oksd7bJLCrQQXo=;
        b=Hi2COiGsfIP5rMUdqZXPtjGczOmLAifK3BS7Knk2urvz6YBAYLOQkMj4HjIqpHP2Xs
         VUH2o2TIuV1nWxCbwqBQLIsjTLEY/frczV8JhDkJTzKQJ76tE64RTonuv7YrQ/uDdgoq
         bIM1Dxp6WWW1QXHZsh2rYSFqxjajwC7X67KIBHA2YbiI8RmLAklkr8bXKHd0iwwoyu+q
         /Tl/50ARM3adXrXB9g9LJLE3t0ZnzaiEtQiJp5KadoQMj3iObWjlvQ9ITTEr/l1jV//M
         co8OW+GgKCWZFd+aBUqUI7k74M8lqeHNYqy4+0fAx+oGLWh60ZNxv/cQKOHJcy6FMErF
         cgog==
X-Forwarded-Encrypted: i=1; AJvYcCXzWB/08UtToYvA+0Mf1VsIX7mhKaGW1umZdxk4EC92WM2MzqUxlSh7i04UirpFKKv5yuRhhJORz88gVa9tAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhiXCuraq2y+f+X9DGxt6zh2STQxULC/AfoOrmWpskhnhufZ7v
	uXgRl2MdfsiF6LTvnKZGnbZxRLIh5Mo7oNmxTPx5J7UIVK5eFjCdc2xc86Gu
X-Google-Smtp-Source: AGHT+IHLEu9jgn7WM091IKVmw7rzozNDxfAJ44mO9V+ZimaQMFmr8Az19ay0Ko5lPTIYn1NJUv0LQg==
X-Received: by 2002:a17:902:e5c9:b0:20c:ac9a:d751 with SMTP id d9443c01a7336-211c501cc43mr17208895ad.32.1731568012440;
        Wed, 13 Nov 2024 23:06:52 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d24a00sm4260315ad.244.2024.11.13.23.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:06:52 -0800 (PST)
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
	vschneid@redhat.com
Subject: [PATCH v6 2/7] rust: time: Introduce Delta type
Date: Thu, 14 Nov 2024 16:02:29 +0900
Message-ID: <20241114070234.116329-3-fujita.tomonori@gmail.com>
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
index 4a7c6037c256..1df6ab32636d 100644
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


