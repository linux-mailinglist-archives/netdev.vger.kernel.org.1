Return-Path: <netdev+bounces-185262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA4BA998C4
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6F04A253A
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88E7293B4A;
	Wed, 23 Apr 2025 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfjMd/Nj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F56293B44;
	Wed, 23 Apr 2025 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437299; cv=none; b=gEMf1QFK6LOCBXKhKnjlFxeJa4YS2qdzIQv3sI8jb9gSiVv+m7YFhGvrrUXZ1WxxByLgNn686u9YGshTT/44nXtjMH2jFmbWk03dQzthhKIh04agMQK7Fr74xLiaYaR22Vep7yB7Egiapa5FABzQVw9+iYyINE8c1vNslyTjuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437299; c=relaxed/simple;
	bh=lsK9WY7qkVnVZvFqrYESaXYKtbs3R7/Z7aQPheIK3ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7lSKNd/RO4mF+n02OQFcQ/BM0go+nBDWpHMHPMfalFd3+uKQZTxVq/ckWVwZECLcBhcBrnHJ5qAiX/5nLTwMeFnLDlo3jmdIUs/Wk1zwlcp1p13ooFDR0nAuTuGXRR3NLdid3DoSi22cKNIUgPF0HZbxVrLWf3wXCneMFPRKBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfjMd/Nj; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30384072398so249887a91.0;
        Wed, 23 Apr 2025 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745437297; x=1746042097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=er2NU0OhzZP3HZxJDqjfMaT/lG2NQ2R6fBjd0zqMycE=;
        b=FfjMd/NjH/2WeYRRGttPEhUP/YSqh8N5TLBEBUgYaCjAZmsv5EQHWwNNZ6gdop3soN
         Az744fAv0Z35ViaEIQIWncUNgxOMOyAg7XcEh4gmyMnuPuK3OWzhuzHpfVyjUTLlA/pK
         18mIw1XrvFy9K/AUEtmZXt7CMAnab5TAfOVLq36A1Fux3jLDX9d0pKe8AQnGSG4c5iTT
         OA2+wB2qMGSYE9rKUKp5fhp6cA8VGwIzXSCCk0tUAIhBf2FKMXHzFs19Bl3z7v6NM0Xb
         B2gPAj2lQrQKZBpwXJe8YHKvz4o2PGbq6TXY597zQw82xlRRTpdHFxMlWVspst/HR6Fh
         EscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437297; x=1746042097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=er2NU0OhzZP3HZxJDqjfMaT/lG2NQ2R6fBjd0zqMycE=;
        b=SO3dASTGXbdxqoPoMn1/8KZ2WHtwfpmNTPvCwVR2nDeP00Q1mmQHn68cNV6394INxg
         JNlM5wQqJa+OEsLsS8WbviE+x7RCasx1fFbmvzTioigtnS2UYKlC5f8dj8/NQixZPzPF
         PCcRaLCZRb6WKJ/CX6X2+KMgEM0VJ/jBe67Nq+bAaA0vTVfAByRzTEfB51mV1Q8HgdtO
         RG+TeXAqs0d2unssPG+tNAn9lvtGpii4rYreDyU5aF8pfy/mWyTjfQkALUmjhRjbmAp0
         Zx2UBRYdZvsI7RNBN7E/hdtpnGAFSv/nwGtCJxYm/bXETf+faSmIIFGaevPO0AXU7OJF
         ZXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOuFORl72kWGmqgyRvOUIJ2BNfpB/Ao6yK4zvWQQf6uiZsQqx5Mcu8qzq8HaAZCoSGTb3zc1gA@vger.kernel.org, AJvYcCWSaT9q1H9I9cSFgRhtofaZjT+KREuJEWbfto3zZOgYgR72sjX9GOsTpn1lad9cFeQKEZ7zxBE4RfEJW3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzODxERvbudLEpBSDkPWudAAr/1oM6QIrrnSbG3OGxsENIy1kXn
	w4HOx0Q+jbMn/N5jCCHbvMXoxegP0S7NZRWVD11KQ77cvtkkeDhMJfyiSHAI
X-Gm-Gg: ASbGncvKyCtjHVK1sqB/NDBFba0nH4R9XjMEnnIkvb4aheTzQK399ntxC5obGCUNelq
	oL7RYsuNoAeC+DCjy/ceKgWQ4wk00bEyEu3zC7buhg6JnoxHD0T2kizeSQumlIzG7aQYE2x5qnp
	iXNdanXJpuY6djU5iPsiF+GgVuNTS6Pt8hC/r0u69708J/JVWcsJ+h3Eo1YVBIEPxqaWhn6QdSv
	rTQHBIWUhHMyM9PVaYGzj4GM9agZUnOnKPmKI9BmBmbITLjJ0Hg8ur/wJLveEPuywkvfsqqL+Mr
	5NigDlPneM23XXMJfnwCOpykZzcroN4wgm1+HrhbcLnfwI7hZbhghilQVm4T8bjOq1SWtvSNDsG
	l0fSq0Kh8ihdqaVOEaQ==
X-Google-Smtp-Source: AGHT+IGFF+c2HJ6NFSwzqXKFZ9feRBu/4V6hZkJ+MtZjV4Sjk+P5s5vjghYnxxNq3UvdLw0xZgHjmQ==
X-Received: by 2002:a17:90b:3944:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-309ed26d30dmr78888a91.5.1745437297036;
        Wed, 23 Apr 2025 12:41:37 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309df9ef918sm2056475a91.7.2025.04.23.12.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:41:36 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
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
Subject: [PATCH v15 1/6] rust: hrtimer: Add Ktime temporarily
Date: Thu, 24 Apr 2025 04:28:51 +0900
Message-ID: <20250423192857.199712-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423192857.199712-1-fujita.tomonori@gmail.com>
References: <20250423192857.199712-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Ktime temporarily until hrtimer is refactored to use Instant and
Delta types.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time/hrtimer.rs         | 18 +++++++++++++++++-
 rust/kernel/time/hrtimer/arc.rs     |  2 +-
 rust/kernel/time/hrtimer/pin.rs     |  2 +-
 rust/kernel/time/hrtimer/pin_mut.rs |  4 ++--
 rust/kernel/time/hrtimer/tbox.rs    |  2 +-
 5 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index ce53f8579d18..17824aa0c0f3 100644
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
+// NOTE: Ktime is going to be removed when hrtimer is converted to Instant/Delta.
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


