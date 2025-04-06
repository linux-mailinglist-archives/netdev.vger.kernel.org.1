Return-Path: <netdev+bounces-179449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACD4A7CC7B
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 03:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EE4177045
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 01:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1801160783;
	Sun,  6 Apr 2025 01:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKoeXlP8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1821581E1;
	Sun,  6 Apr 2025 01:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743903345; cv=none; b=nQwrvBdrXZlSioXxXmnbc03DeQij4Npco8llxBPzcgclPIOOnvpk/c1BRN/sVtceR3F8iryu6aLDdvSc9yqlkNyhF3mBDM3348qmFsQADztMeulKl714nSxjvIXDh9st1hPKL654rKmN6YVZbkbU0Hb5fWqKufp1mKms1Y2xVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743903345; c=relaxed/simple;
	bh=FRv0zURbSztvldjjHd6IPO8aj6GITfpWGVJmSmvg/MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTQLMlPEYuNDbroL5PydMYtzrRQOFpxc5eXdXeb3XliXclwBani49fmGW4gTKLOQZBxjtXh/emPy0n27MyN6algHTu40PadR9ZRmEpj/czURqDAd0ZXbNdJTQrsuiG8/IOfcM9Rb0wO8j6sNUtAfB4O1I4P6cxoV8118RKRt8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKoeXlP8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736b350a22cso2704340b3a.1;
        Sat, 05 Apr 2025 18:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743903343; x=1744508143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXYh9opa2X5pw5Rnzm4RLKwzbCVPmlk5ZFIxldQ6nv8=;
        b=HKoeXlP8SLDchTCERi8lpGK3R/P1wkGHaKwhlOh6J47VvfYk+Kr2lHWFE+rQX3zMjd
         Xn2erNnn9XOqL4A/6x12CAKSvE24fAFDOc+jy3KaI+7o8xfvR53ljj8vXYmsYIZIFy60
         Qsl11mH4+6GKTEOFOjYmTbCnRTirDEC3bTzRY1yu66nux8R20tgGay/Rrgxp86FZoYne
         FMU/eFBJ/atxdn1SA5VEQuQ52V5ehJ5gGF/NQ+fUyoymm+MChT+hEvOnL+ngQNLn6sjX
         yFgv/utX6rI7DeUNyACKUQx2LOKa5HhPHdLDOLiSUK3RfHkJp6EcbkRs0w1QhzHLcLBQ
         Mqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743903343; x=1744508143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXYh9opa2X5pw5Rnzm4RLKwzbCVPmlk5ZFIxldQ6nv8=;
        b=iOOvnGpiztkJa69loJXWzrTVg6VX6k3D+MnGff7H/rsRbsM25pvCkHXGQ9BxNL7Gwz
         1sfAemDR4VZGxIDCQXCc6aNqwnFA5IdK8Be8xhdbul0uejTFXtpqoO09EO0KwNwR4fuM
         0q07NBp8Ty+g7sZYXvDmdi4hgiA3Hw5frrUFrKUtjkdOe2QUe9C92n2L1ShyalJ0L72Z
         9tOb+g1+5iSMaMV3VXpfdPBq/DgCLKXg13dzCEU4slfnuFcNZtvhIs5ibShGPrdN2z5X
         zqHE5U+KInHVal1bMPnvRLKmC94HkdPadUIA8RGVcOmfq07NuiPWuxP/0MC0dNZRRtFt
         vqYA==
X-Forwarded-Encrypted: i=1; AJvYcCX69TLEWg2KA/TZAKwCIc3S3ijmYWDh3/hN8FLseKA4wXBkVHiJTTVi/CukCdDdUvgdzS08tsIG@vger.kernel.org, AJvYcCX9Hq/qfdsumwnvekQrD+xApj5XjHXEVvb1L48akBEBIcQWRCYjWyVLly2hBZhNhQBnZo/LbGsgMo7RQYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8wQ6P99phcaZ7gixHrSFGUxB3rfNn00Nl+x3un074YV+QDHJZ
	rJC+Vp+VbMMN2WPVlLbqNqmWjpgLOcRGc7xX68jxbJrSk3Ii9wqYWHbR7lcX
X-Gm-Gg: ASbGncs2wac+4YLwVMQKzBcR+WnPe4gpVjDWo8zif7dCfhZhjM+pvemt65km7OczXy8
	8JcG6GKsJiDjp0UIPTN6bNe4wCp9YnFXFEiJbiFypFWIZxsf2jYBq6m3iSkEeEV1LWlu6AuMkyL
	46Itjcq3Pjnxml70Mpyi4CHQV+nMOYp9vHA1TT7fkxzSbXhlBcP9DoDk7LJaoD8l6Hdl6fRpwJi
	c0uliJNZ6sDbghq0nC4PwnHaIGiPzyKojmOp65ZUN2jYoa48dy0VonaCxYPC5K9O7jR1EX4xLXX
	LYqyqf1EsLWR9Rp6KD6q138a1vN/feKuMVgQipJ70umZAoMbWP/HSF9foK+76J/mJ68hi0CT4SN
	1P16lnfS21hsSZSuMoqPwsQ==
X-Google-Smtp-Source: AGHT+IG6hE0mQ449T9GZriMtq73qyEdn8TF9CAcRp5qLKDDBJzPLbaW8MFSTKxQTDCfVOH/tGo1Ttg==
X-Received: by 2002:a05:6a21:2d06:b0:1f5:8a1d:38fd with SMTP id adf61e73a8af0-2010447b3f7mr14210091637.2.1743903343181;
        Sat, 05 Apr 2025 18:35:43 -0700 (PDT)
Received: from mew.. (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0bc052sm5846849b3a.156.2025.04.05.18.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 18:35:42 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Fiona Behrens <me@kloenk.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
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
	david.laight.linux@gmail.com
Subject: [PATCH v12 4/5] rust: time: Add wrapper for fsleep() function
Date: Sun,  6 Apr 2025 10:34:44 +0900
Message-ID: <20250406013445.124688-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250406013445.124688-1-fujita.tomonori@gmail.com>
References: <20250406013445.124688-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a wrapper for fsleep(), flexible sleep functions in
include/linux/delay.h which typically deals with hardware delays.

The kernel supports several sleep functions to handle various lengths
of delay. This adds fsleep(), automatically chooses the best sleep
method based on a duration.

sleep functions including fsleep() belongs to TIMERS, not
TIMEKEEPING. They are maintained separately. rust/kernel/time.rs is an
abstraction for TIMEKEEPING. To make Rust abstractions match the C
side, add rust/kernel/time/delay.rs for this wrapper.

fsleep() can only be used in a nonatomic context. This requirement is
not checked by these abstractions, but it is intended that klint [1]
or a similar tool will be used to check it in the future.

Link: https://rust-for-linux.com/klint [1]
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/helpers.c    |  1 +
 rust/helpers/time.c       |  8 +++++++
 rust/kernel/time.rs       |  1 +
 rust/kernel/time/delay.rs | 49 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/time/delay.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index e1c21eba9b15..48143cdd26b3 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -33,6 +33,7 @@
 #include "spinlock.c"
 #include "sync.c"
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
index bc5082c01152..8d6aa88724ad 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -24,6 +24,7 @@
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
+pub mod delay;
 pub mod hrtimer;
 
 /// The number of nanoseconds per microsecond.
diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
new file mode 100644
index 000000000000..02b8731433c7
--- /dev/null
+++ b/rust/kernel/time/delay.rs
@@ -0,0 +1,49 @@
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
+/// Equivalent to the C side [`fsleep()`], flexible sleep function,
+/// which automatically chooses the best sleep method based on a duration.
+///
+/// `delta` must be within `[0, i32::MAX]` microseconds;
+/// otherwise, it is erroneous behavior. That is, it is considered a bug
+/// to call this function with an out-of-range value, in which case the function
+/// will sleep for at least the maximum value in the range and may warn
+/// in the future.
+///
+/// The behavior above differs from the C side [`fsleep()`] for which out-of-range
+/// values mean "infinite timeout" instead.
+///
+/// This function can only be used in a nonatomic context.
+///
+/// [`fsleep`]: https://docs.kernel.org/timers/delay_sleep_functions.html#c.fsleep
+pub fn fsleep(delta: Delta) {
+    // The maximum value is set to `i32::MAX` microseconds to prevent integer
+    // overflow inside fsleep, which could lead to unintentional infinite sleep.
+    const MAX_DELTA: Delta = Delta::from_micros(i32::MAX as i64);
+
+    let delta = if (Delta::ZERO..=MAX_DELTA).contains(&delta) {
+        delta
+    } else {
+        // TODO: Add WARN_ONCE() when it's supported.
+        MAX_DELTA
+    };
+
+    // SAFETY: It is always safe to call `fsleep()` with any duration.
+    unsafe {
+        // Convert the duration to microseconds and round up to preserve
+        // the guarantee; `fsleep()` sleeps for at least the provided duration,
+        // but that it may sleep for longer under some circumstances.
+        bindings::fsleep(delta.as_micros_ceil() as c_ulong)
+    }
+}
-- 
2.43.0


