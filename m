Return-Path: <netdev+bounces-136022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C7399FFC1
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D38DB22640
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEC0187877;
	Wed, 16 Oct 2024 03:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlYtNLoS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD622189F57;
	Wed, 16 Oct 2024 03:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050827; cv=none; b=tTPt+y450fQJ3z4n69mjNVhv4hUYjkn46u006HLRVUnKnm+rCFG7iTtZQc5pR26scstsWtd9otm/khymPiDampj8eoFbhczCZlin1ZYmPxI8UJ6mrXT0EI8+4IAG1ZY6KQ6D7QD/iAPvcX3VNbG3sDfyhIfhcXEzmLsMGDFVwTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050827; c=relaxed/simple;
	bh=XI/dyKxyCoddGtpKIJe6JLnuD35Wsjc8XEV+pb1YPb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNawTScpiDpF0Y9pp1ttjNNMv3FIztn0Z5Y96Z+Xywjg5Sbo8LgGO8hi1BUEXPGFL3Qr8PujKT50usDdsO2SR/auJq8nnVzYQYoeUi/grAfGF0ydGUnkBXlEEQ7UNESu3R/sP8LmsOL3B1ivvb+gUSoxy7yiHXWfaJFuG4mMCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlYtNLoS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2d1858cdfso3949839a91.1;
        Tue, 15 Oct 2024 20:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729050825; x=1729655625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLHaMTl/OaXFHW2jFEe7sxZ89COHw7ReQgLHZorTXMI=;
        b=YlYtNLoS1TXicTMT+FCQ5Y/Trn2imQq1eiO0MVPqMhkAPpQDbIOHsWSwNfLR4Kv2Eu
         DxrrjQ0/tn6lBF8XZttXlEXjLkct6xw7Hj+eVImjN8YYOJ5JtfsrSPiS/FMccwoFAFmN
         E5YNR2yc26GzYSkSVnc/WJwzZH+xxtLA3NLpsTB20MAr0h3yJltlu/R7uJPBmwVN9f9Y
         Jw95xTE2V6xXXiI2MC5hUb0iijH9umLv2ZPRBBO5gG0f7Rb5qlFtrIQowAntwCFTLzux
         Shcx+nV3/B//F1V1kyoSEN2gWVRqU/5R8ExW8RE/vyzMyHZ/mCXF6yVxGEgAsTKxRzKp
         /uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729050825; x=1729655625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLHaMTl/OaXFHW2jFEe7sxZ89COHw7ReQgLHZorTXMI=;
        b=QaGfswWQaxqCIcV/LbAy7EdKZvZTeeVrHSzfJ55m66QErQywfAOCSV8u2U7pi56Q2u
         eqt6MGZP/ErHaESgO2fSKcZtkcuiEWeNXgHtyG2vxzoJ+vzrIalCJo7il51JHfapNt6G
         j0rWq3vrlxx/D3t/fVscsYA9zeIrhn8qrTezjRc/g7/g+oyVMYZVPx1euzFQvXtUK4+i
         kAC+p4tG95CYgITssXfm1RtkZn7kIbdeiGf7/fI1iHXEoxlYXESUysoFd6m6lxkX0v1Z
         bYYyNGQn1vv5k/UxCvP6YdfuUjbNgSb0vFKhlmIBBCyOpa2LWI7nCnu7MutJZ6CiodIq
         zGHA==
X-Forwarded-Encrypted: i=1; AJvYcCWvv23HY0AJHpwdI++Vp3fKKXS6dM0YLHlFyxyWVgcxTo6Y8UTnrneurc4mr0mFcSlhL0HfNk0uZP+rLXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+utyafuu2BeDeUBuJWmSl7+ETvtSy+d5TXJWImq5d5fcaonvn
	lx2Ero6w/E4FV9oeZBqHCsVYWrohZeU6suKkSrUxTPrBtF4/izb0YUJ17y2t
X-Google-Smtp-Source: AGHT+IEgKH2ShojJVIfEMs51cddGgBeRJfBJxZiCq/Vo2hQCTzQJ54d8PUKdqtT2ctc9egSBNnYfKA==
X-Received: by 2002:a17:90a:b00d:b0:2e2:c98e:c33f with SMTP id 98e67ed59e1d1-2e3ab7c78a3mr3231821a91.1.1729050824834;
        Tue, 15 Oct 2024 20:53:44 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392ed1a4fsm2885691a91.17.2024.10.15.20.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:53:44 -0700 (PDT)
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
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
Date: Wed, 16 Oct 2024 12:52:07 +0900
Message-ID: <20241016035214.2229-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016035214.2229-1-fujita.tomonori@gmail.com>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
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

Delta::from_[micro|millis|secs] APIs take i64. When a span of time
overflows, i64::MAX is used.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 4a7c6037c256..38a70dc98083 100644
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
 
@@ -81,3 +87,71 @@ fn sub(self, other: Ktime) -> Ktime {
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
+    pub fn from_nanos(nanos: i64) -> Self {
+        Self { nanos }
+    }
+
+    /// Create a new `Delta` from a number of microseconds.
+    #[inline]
+    pub fn from_micros(micros: i64) -> Self {
+        Self {
+            nanos: micros.saturating_mul(NSEC_PER_USEC),
+        }
+    }
+
+    /// Create a new `Delta` from a number of milliseconds.
+    #[inline]
+    pub fn from_millis(millis: i64) -> Self {
+        Self {
+            nanos: millis.saturating_mul(NSEC_PER_MSEC),
+        }
+    }
+
+    /// Create a new `Delta` from a number of seconds.
+    #[inline]
+    pub fn from_secs(secs: i64) -> Self {
+        Self {
+            nanos: secs.saturating_mul(NSEC_PER_SEC),
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
+
+    /// Return the number of milliseconds in the `Delta`.
+    #[inline]
+    pub fn as_millis(self) -> i64 {
+        self.nanos / NSEC_PER_MSEC
+    }
+
+    /// Return the number of seconds in the `Delta`.
+    #[inline]
+    pub fn as_secs(self) -> i64 {
+        self.nanos / NSEC_PER_SEC
+    }
+}
-- 
2.43.0


