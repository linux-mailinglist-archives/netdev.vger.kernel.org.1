Return-Path: <netdev+bounces-158751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7927FA13215
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FB43A57A4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC2915252D;
	Thu, 16 Jan 2025 04:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCTT1sPq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E58152532;
	Thu, 16 Jan 2025 04:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737002578; cv=none; b=HDnPrQjKjKO6DlUyKqZafUv/swsG4cSXdlvldjqcyEBqZLX+m+drTBiJ7UEXJeiulcsDhSh4YdeCBjRIL6uCr1BH/XM4PSwpjCp9NgJnmtSVv/u7PI4TBKrj6pD2lCnlg0nR0aldvibwd4QjySk5Cph+0+fcFoArRW4D7g1dfyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737002578; c=relaxed/simple;
	bh=O+kqL+5YpnCiY6731vR15kXmZyQfCfEoPbqW1DePO80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6xyulPI/XEbgNHeXhv86ea+6bZbqYz39MfFYCeH2qYyRSuLAgobSGu9lxE6hyRzcxNkfTbTqUEwBDuhq7/bVssquVFq7o83H5G88f96HFuKbnQjZ0WxyUxSt+FNUVbHEZzO82x3CgyGeF5qXSNMyBLcTur/d7JQLTMtUiLDa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCTT1sPq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21654fdd5daso7335345ad.1;
        Wed, 15 Jan 2025 20:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737002576; x=1737607376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG2rfgEzsdeXdQBcUUB2Ws17wlCYVB4wC33Z9prKhtg=;
        b=HCTT1sPqt3xvCQFnhS8PRc9owhQIUShOaDC8ViHgxEYGT6v8pRFBsGrIjystVv7Aks
         LPm8AZm8lxbkl+Ite5mjUTtD8SKifxDCFH0Wsayb8wvfhAMnP1bHPeQakDc9OvN9axp5
         yxs0RmiK7Fj29bhhpSkHNOF9NptdJRyO/KL+UbRJs8H5tMkVViICCq0kYtBdkJKaP0TT
         UJwSl2LJElF7fdIl56fsiPttmTOHYbMao1Kn0wuMn2Km2y9Y2QNuPQLFBqXD5xh/25HY
         l//vDLfgLivFGb3iX2lsPuzLlxCjrfYYiess+775ejiQVik3QVErMaJ92HUd869rJYAD
         r7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737002576; x=1737607376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tG2rfgEzsdeXdQBcUUB2Ws17wlCYVB4wC33Z9prKhtg=;
        b=hd6zY0kEATfYbLzBBfXt4BGDBQmuBMykDvw1YE7Ur65iWs1F3sYmDH/5oDvC11jXdy
         j38zBVBCqQATtdxy5EoySHMGWWx8d90Q2+5OSkecp5kFvsQrQJAPToveoDv3NIe9yLRW
         K5uY9R1IPJyc1L3USyYc5+n/8Nmb6dbvfjgz1gy3682pjLu/YY/eGI3p2IBzdzR72N6x
         KH1GjBuAQIUJq2axWbk1tz4LxzBff4vjdkhHNrFgmpwB2zy0sZbtaV4kl01U2N8/NwzO
         AkjIJkh66KRbVDinNzUPCDLpuMQbKERBiDfWxXAtWlDFuvKfdIxyQQRfooygrNtkcm6m
         omaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUyP8gz+QWxxYp6zL0yUovGaQfs/U6RgJS3Ld6We5jvN9Xf84DFFT59lae/rbGtM2B3cUq1cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwGgOrw4T5GrbeHGx2p/IugifQyyUR84+qeeBN7of8mSat62cE
	o2JEwJWWPhCFRCA26YZtXjcXrRgAd585eddmXT150X1LaoT4qGO8h4C0Lkq3
X-Gm-Gg: ASbGncvFCDq5747dWpg97lk93luKA3SYH6c1Y31iZV7FzipFm/HOdCgK5eNDVCwPjub
	VK3BDgxDDAEnYvO93USEa+bGKe/Zkl60BYTbVftEg8oI4TWD+RUnFNVwjnVSRu8GAi7zZb4zMML
	shyI9j1G5ZI8zOlZGa3TLeGZH59E19GIb2qwDpQTHYHbxfRK29G7N28laNDb4iSoUmRALfcmLs4
	BFtzUIcH32M+gTyb6KfJSa1QxEjSrr3sudfVv7lCfyXEAXkjdOIHU/mlRlHvqROyl/akAD+h+vI
	BYbSUDJx7hSVJVCMTIEM1AGJMSVrM20I
X-Google-Smtp-Source: AGHT+IE2kXmwBJ24RxcaisRLSIyxRU4mEX0ssGEXixCP4azmT5AeNYwOMqu6fbffIqx+JO2OiYe6eA==
X-Received: by 2002:a17:903:2285:b0:216:386e:dbc with SMTP id d9443c01a7336-21a83f54a7dmr463185215ad.13.1737002575812;
        Wed, 15 Jan 2025 20:42:55 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217a60sm89161045ad.158.2025.01.15.20.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 20:42:55 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
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
	vschneid@redhat.com
Subject: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
Date: Thu, 16 Jan 2025 13:40:56 +0900
Message-ID: <20250116044100.80679-5-fujita.tomonori@gmail.com>
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
index dcf827a61b52..d16aeda7a558 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -26,6 +26,7 @@
 #include "slab.c"
 #include "spinlock.c"
 #include "task.c"
+#include "time.c"
 #include "uaccess.c"
 #include "vmalloc.c"
 #include "wait.c"
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
index da54a70f8f1f..3be2bf578519 100644
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
index 000000000000..db5c08b0f230
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
+use crate::ffi::c_ulong;
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


