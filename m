Return-Path: <netdev+bounces-144699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48BC9C83B5
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD7FDB283A0
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771DE1F26DB;
	Thu, 14 Nov 2024 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGI7n/3X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B651F708D;
	Thu, 14 Nov 2024 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568026; cv=none; b=Ef0ke0l3EM7qvs+WuhS5oOk58IGpUlY5W/AJx5JDopCG8Ay54U3GKaQrk0oXxdkgOb2M2T0ETimkMWOmKq7IJLc+qXLcR0P20bpz8G3uOnG67dpQW4iayTfiVURm9jyOnNkSPIUalt/EuIYjJnTGImnW7mGAmpXnC8h+/zkqrCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568026; c=relaxed/simple;
	bh=VtU5QbtZ8Kc/FmsxjH+iKgugsyaUqp7xsciNvoFPadc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avvtmnyGfzZ18ioaTNjVyFgFxNM83xVmPaELqLRxGjIxG5iAX5XxSTL6Fez8BVg/T5Uqdu2HgCJADn7W0MG3MrQp9U6KKloApPBBo1kmlzKcIBbK14Xthu4wTG+YZ8XLtJ56KbWIEXC3C+/SPBT1bt6EIxR0eKE9hVWL232xO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGI7n/3X; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20e576dbc42so2586425ad.0;
        Wed, 13 Nov 2024 23:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731568024; x=1732172824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qXPUrrsm2D4XazfdnD4Km80VNViJ3aj9orHJknL1YU=;
        b=QGI7n/3XR0PhbzTUu3fmydMQt/zhFcHF12nZzPQHE/QzJrVNYUEyZsS9WZInDv3ekf
         7w+y7mKLhGjJhQzrRyZKmafm3uJuQwFKLCSMT0KWbTU6Pr+K5R/F7lRms7mJTjTMrQKf
         QB89lz0gEE+kz4v6DsLpq/kn50aRNNqQRI5M3LIgD6WQscvOP59yWo8NwYtZMQdsfFGp
         C0YBN1BtbkSP9M0EwAFNyiTw4Z9HH5DmoPTJ2t52Ge4J0S9MCOroMdb1HjPtbPRXeIox
         YcANQJKdoEOKq++kYF28y2GnsrM6k6S4pZVYR7Nv0AnopiKzwCMQi0nzAU65FQggyocg
         eBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731568024; x=1732172824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qXPUrrsm2D4XazfdnD4Km80VNViJ3aj9orHJknL1YU=;
        b=FWBEQtjEUY6wP8RnZrtZEcsa9CBHxfPyo8fthJOP8pSYM+DEUHKRHAirNo5BMq1cRm
         puzrXGiBlgYcon9X9rAD9Pyg+W/ZgbBYpQG5JocE/syVssAH9U5hxMH1EPxaB2OEqxaT
         Vkf9pm5N/36kQUSkmTIhfOrmLkiqK4e4sP5PMDUJTWRci0Bwy8lST+fnydFY0cv6d1/b
         B2WTuANguwrfr1Qw8TsnK99LDFiclziZVglvPXmz8f8dB+jUMOHwouobsSINB/a/MGSZ
         ChuH+RQktrYq7MefowFnzggj/j7kvUdAoWO0rhgoFIDyhl8mbZb4x4ZTeg/298atgr76
         cUCA==
X-Forwarded-Encrypted: i=1; AJvYcCUtE/VlYUa8oJW0LlJTf/ku5DV3l2gSSflmrLs0oCq5NbKS/Pu+oOsViUQyBwiiLvxzhG4rvkRehadcTbsw+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiRLrr4+XnMz4egXSnP5aU/oW5YCGRYLRs7CF4D5ERvfgFwQrB
	57oqjfN3dB5GxAXdA3fP4y+Zzw0MeUI29A/6TDa6BSmX3D2HHyYsiI4TLYzF
X-Google-Smtp-Source: AGHT+IG3F/bclIC4fPNbIRxhxpkbWb1GslUeD7u/O1retYuA4k9nXmBoBd422RcNq8dURjFBzkELEw==
X-Received: by 2002:a17:902:d508:b0:20c:e6e4:9d9f with SMTP id d9443c01a7336-211b6698a53mr72386475ad.40.1731568023709;
        Wed, 13 Nov 2024 23:07:03 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d24a00sm4260315ad.244.2024.11.13.23.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:07:03 -0800 (PST)
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
Subject: [PATCH v6 4/7] rust: time: Add wrapper for fsleep function
Date: Thu, 14 Nov 2024 16:02:31 +0900
Message-ID: <20241114070234.116329-5-fujita.tomonori@gmail.com>
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

Add a wrapper for fsleep, flexible sleep functions in
`include/linux/delay.h` which typically deals with hardware delays.

The kernel supports several `sleep` functions to handle various
lengths of delay. This adds fsleep, automatically chooses the best
sleep method based on a duration.

`sleep` functions including `fsleep` belongs to TIMERS, not
TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
abstraction for TIMEKEEPING. To make Rust abstractions match the C
side, add rust/kernel/time/delay.rs for this wrapper.

fsleep() can only be used in a nonatomic context. This requirement is
not checked by these abstractions, but it is intended that klint [1]
or a similar tool will be used to check it in the future.

Link: https://rust-for-linux.com/klint [1]
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/helpers.c    |  1 +
 rust/helpers/time.c       |  8 ++++++++
 rust/kernel/time.rs       |  4 +++-
 rust/kernel/time/delay.rs | 43 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/time/delay.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 30f40149f3a9..c274546bcf78 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -21,6 +21,7 @@
 #include "slab.c"
 #include "spinlock.c"
 #include "task.c"
+#include "time.c"
 #include "uaccess.c"
 #include "wait.c"
 #include "workqueue.c"
diff --git a/rust/helpers/time.c b/rust/helpers/time.c
new file mode 100644
index 000000000000..7ae64ad8141d
--- /dev/null
+++ b/rust/helpers/time.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/delay.h>
+
+void rust_helper_fsleep(unsigned long usecs)
+{
+	fsleep(usecs);
+}
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index ae0d3e3ff475..cfaac41fa6e2 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -2,12 +2,14 @@
 
 //! Time related primitives.
 //!
-//! This module contains the kernel APIs related to time and timers that
+//! This module contains the kernel APIs related to time that
 //! have been ported or wrapped for usage by Rust code in the kernel.
 //!
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
+pub mod delay;
+
 /// The number of nanoseconds per microsecond.
 pub const NSEC_PER_USEC: i64 = bindings::NSEC_PER_USEC as i64;
 
diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
new file mode 100644
index 000000000000..e384a7f7eec4
--- /dev/null
+++ b/rust/kernel/time/delay.rs
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Delay and sleep primitives.
+//!
+//! This module contains the kernel APIs related to delay and sleep that
+//! have been ported or wrapped for usage by Rust code in the kernel.
+//!
+//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h).
+
+use super::Delta;
+use core::ffi::c_ulong;
+
+/// Sleeps for a given duration at least.
+///
+/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
+/// which automatically chooses the best sleep method based on a duration.
+///
+/// `delta` must be 0 or greater and no more than `u32::MAX / 2` microseconds.
+/// If a value outside the range is given, the function will sleep
+/// for `u32::MAX / 2` microseconds (= ~2147 seconds or ~36 minutes) at least.
+///
+/// This function can only be used in a nonatomic context.
+pub fn fsleep(delta: Delta) {
+    // The argument of fsleep is an unsigned long, 32-bit on 32-bit architectures.
+    // Considering that fsleep rounds up the duration to the nearest millisecond,
+    // set the maximum value to u32::MAX / 2 microseconds.
+    const MAX_DURATION: Delta = Delta::from_micros(u32::MAX as i64 >> 1);
+
+    let duration = if delta > MAX_DURATION || delta.is_negative() {
+        // TODO: add WARN_ONCE() when it's supported.
+        MAX_DURATION
+    } else {
+        delta
+    };
+
+    // SAFETY: FFI call.
+    unsafe {
+        // Convert the duration to microseconds and round up to preserve
+        // the guarantee; fsleep sleeps for at least the provided duration,
+        // but that it may sleep for longer under some circumstances.
+        bindings::fsleep(duration.as_micros_ceil() as c_ulong)
+    }
+}
-- 
2.43.0


