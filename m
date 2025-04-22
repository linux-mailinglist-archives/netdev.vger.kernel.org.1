Return-Path: <netdev+bounces-184680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A95A96D81
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7DC188A86E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19643284B3C;
	Tue, 22 Apr 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hyrc6uPC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769FB28150B;
	Tue, 22 Apr 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330088; cv=none; b=G/a4hMLygA1rbvoLDxXVjlTUvJsOE6cUBAAoFeAr+XyKpAmh0HegHnHCs/ZiMnGowjKrdU/MP45BGR5TgWmSaV1mcDjP3mJI1q0e7cHXxRw49Zm8VDL1QRTh3X0uRBTu+lsoCpCRU0ZHRBH2FUXI27ioK8kfhg2Y+0U/atV7CaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330088; c=relaxed/simple;
	bh=4aLvKP6lQ8GjRHg63r079oXM9vZ1FD3mZH7QUK6gTOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3zcS1Zp5rdoAMy3sMyin8CGhmzKh6tN2ZCyVRtaiBjM840j/oKA59H/75UFta1dF2TbKpbMqhkYjJ4xVQIcowzzyiiG4galfiDvANkiPM7a24cuaMkDZEsbu9E0vDFSYotSNtocuchdSjZHp/xmD7fnmW9mFjZZyCCbyWLswB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hyrc6uPC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso6800760b3a.2;
        Tue, 22 Apr 2025 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745330085; x=1745934885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLtyTPuaBTipMrEx7bQNxRqQVJ7fg+0+s1IB11VDitE=;
        b=Hyrc6uPC05nkwZwGm5cSI+yGhmAytnp1GNrvq1+i626RNjQF7a6nN6LOoyGW77nKSV
         slwC+ZqgJNpEb4mbqUmUQSISM6GClSOTcAr9x/vzaAkYhqVtWWpsbHneDKgUqADoo4Li
         a9bCL/rIAJI7VSZe+6phiIAhDnSuFqb5l5H8r12blmOu5WZUuMb4L63KApW6dXRXzieP
         wg7JcfLmt11WKke70ZIs9gmQF+sSLT0aMKrVOerYxRIsrnt+tFr+ctDfbGsygro9+3OE
         YerfOgs3qL8fYN9f9NDxFUHjjK1/Ty36nwnur5DODXf0/3GpPY5AGOlHwJ6VuQuK7HYW
         Hdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330085; x=1745934885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLtyTPuaBTipMrEx7bQNxRqQVJ7fg+0+s1IB11VDitE=;
        b=KqKhkKoNFb9w1mnAN+uIvTlhoix3EaZwmNXdgcLmCE5ewywKEIt6cdqyAZsNd1qqjB
         jpsWiqy6G+DrBZb5hOJC1Yw3FlJh7I4eESV4z7faUmyqVgJ18IrzPxia7GUbd7UK+LBW
         R8HHebpgEc3JON1GS7TVjfgTJrNvyMg4pN0uv3uAsM9zDPq9woRhfK8Iw18Igx6cH8Kk
         eLxabsnmGhIgOl02rsbAHjcWLV5kcJJZcgL6Sbi6+xTfpteJ0VEw/P66Io5077KNkUcR
         OK3IR3TMY4qlMnFAJTrK3cSjSgo5On9ZMVqE8nooo0yvaOlMf2TLhnjfSQNF1+jZfQKZ
         ucvA==
X-Forwarded-Encrypted: i=1; AJvYcCXq8TRATV4skZY9NleSTEq9e0lTIxhD7romxwbjLbqtRp2OZULfxDSJy7xu88HSXxtd0gO/5u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ01fV2hPoARedITH2ErWrNyrnNNNc47BnRqw7rX+OSn0zUtaV
	344s2wOS8DwEt4ZJZ9bMBL9uxaZ897R0vRDOm3aun3HFAijQTiAz+Tx1Lb8Q
X-Gm-Gg: ASbGnct5UsClLsZAcp1jM7kXdJn+gbw9aorEvfUk5aNgrGla7gDiI/lw9KihPn3j5Zw
	GlYzqwLSwqTgZkPjIKhSmeEFQNl/DoyT9eYRjIzC8Zu3HZ/bewUqb0znxkK+dSLxGwFeYfC+H/I
	OeJmcBbzWwpApS8zIA3fLQkbl5z9wqY8fAMzjRUmr7UftNi0Vs+2vRu4VM2vQpnOyh/Bu3IjYZr
	49URZk/ljJ+Krj+IES2yn8ZGPt6V9HNrcJLRIbk6/8+d7zrZt3JaL/aupm71YiK/RqDYjE0gzxu
	wTkEuhGAlIpnWaNls27iPLxJy4ok0bPXv4tZC4Fv+O7fVlJdRJGiFA6CVUllo1DJ/8G8B5p2vHW
	dNIlSPcLXuNfZLdqfpA==
X-Google-Smtp-Source: AGHT+IFEtFs6G1at12i5xHemksV9iy9alSSFhXgEe+f1Fol4yjtoLkgo0CM/jEvZxc2728b72i5AHw==
X-Received: by 2002:a05:6a00:6f0c:b0:73e:598:7e5b with SMTP id d2e1a72fcca58-73e0598909cmr2765434b3a.1.1745330085427;
        Tue, 22 Apr 2025 06:54:45 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaaba76sm8869650b3a.143.2025.04.22.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:54:45 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
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
	tgunders@redhat.com,
	me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: [PATCH v14 1/6] rust: hrtimer: Add Ktime temporarily
Date: Tue, 22 Apr 2025 22:53:30 +0900
Message-ID: <20250422135336.194579-2-fujita.tomonori@gmail.com>
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

Add Ktime temporarily until hrtimer is refactored to use Instant and
Duration types.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time/hrtimer.rs         | 18 +++++++++++++++++-
 rust/kernel/time/hrtimer/arc.rs     |  2 +-
 rust/kernel/time/hrtimer/pin.rs     |  2 +-
 rust/kernel/time/hrtimer/pin_mut.rs |  4 ++--
 rust/kernel/time/hrtimer/tbox.rs    |  2 +-
 5 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index ce53f8579d18..9fd95f13e53b 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -68,10 +68,26 @@
 //! `start` operation.
 
 use super::ClockId;
-use crate::{prelude::*, time::Ktime, types::Opaque};
+use crate::{prelude::*, types::Opaque};
 use core::marker::PhantomData;
 use pin_init::PinInit;
 
+/// A Rust wrapper around a `ktime_t`.
+// NOTE: Ktime is going to be removed when hrtimer is converted to Instant/Duration.
+#[repr(transparent)]
+#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
+pub struct Ktime {
+    inner: bindings::ktime_t,
+}
+
+impl Ktime {
+    /// Returns the number of nanoseconds.
+    #[inline]
+    pub fn to_ns(self) -> i64 {
+        self.inner
+    }
+}
+
 /// A timer backed by a C `struct hrtimer`.
 ///
 /// # Invariants
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
index 4a984d85b4a1..ccf1e66e5b2d 100644
--- a/rust/kernel/time/hrtimer/arc.rs
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -5,10 +5,10 @@
 use super::HrTimerCallback;
 use super::HrTimerHandle;
 use super::HrTimerPointer;
+use super::Ktime;
 use super::RawHrTimerCallback;
 use crate::sync::Arc;
 use crate::sync::ArcBorrow;
-use crate::time::Ktime;
 
 /// A handle for an `Arc<HasHrTimer<T>>` returned by a call to
 /// [`HrTimerPointer::start`].
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
index f760db265c7b..293ca9cf058c 100644
--- a/rust/kernel/time/hrtimer/pin.rs
+++ b/rust/kernel/time/hrtimer/pin.rs
@@ -4,9 +4,9 @@
 use super::HrTimer;
 use super::HrTimerCallback;
 use super::HrTimerHandle;
+use super::Ktime;
 use super::RawHrTimerCallback;
 use super::UnsafeHrTimerPointer;
-use crate::time::Ktime;
 use core::pin::Pin;
 
 /// A handle for a `Pin<&HasHrTimer>`. When the handle exists, the timer might be
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
index 90c0351d62e4..6033572d35ad 100644
--- a/rust/kernel/time/hrtimer/pin_mut.rs
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use super::{
-    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, RawHrTimerCallback, UnsafeHrTimerPointer,
+    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, Ktime, RawHrTimerCallback,
+    UnsafeHrTimerPointer,
 };
-use crate::time::Ktime;
 use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
 
 /// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the timer might
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
index 2071cae07234..29526a5da203 100644
--- a/rust/kernel/time/hrtimer/tbox.rs
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -5,9 +5,9 @@
 use super::HrTimerCallback;
 use super::HrTimerHandle;
 use super::HrTimerPointer;
+use super::Ktime;
 use super::RawHrTimerCallback;
 use crate::prelude::*;
-use crate::time::Ktime;
 use core::ptr::NonNull;
 
 /// A handle for a [`Box<HasHrTimer<T>>`] returned by a call to
-- 
2.43.0


