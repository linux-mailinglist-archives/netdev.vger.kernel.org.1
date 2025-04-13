Return-Path: <netdev+bounces-181962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C5A871AA
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 12:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E32B3AD6ED
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081ED1A3171;
	Sun, 13 Apr 2025 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvGhtNRI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAC11AAE2E;
	Sun, 13 Apr 2025 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744541050; cv=none; b=UIdFQJ+QS2DmrPkS8ScSA2k+4GTKAGtusT6w+grVZ+/bRrUC4ugYS3rZ8ky+eSBrYzWwkVbqLK6lIJ58BPFJcPp4pvLqkQHnEYYfMXlkYMILHfGnT4DKpd+05/0sRJaGKQ1vxYYRSnThXej12GPRmccmF1Y1BCwLkhvMpY18eoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744541050; c=relaxed/simple;
	bh=FRv0zURbSztvldjjHd6IPO8aj6GITfpWGVJmSmvg/MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0PmP8Tz/76IboQ+btCDz8ZVY07sCJ9sJHPFFqbtVx6UNnYbX7Pq7wq8pbYqj0QpSaBP/3jdYVIJiOpS9mo+7B2YRmSTddeD3f2P+L9sZWGj6cpB9vyMxM+Hn2JxS2olVThV1gJ0lPK9+PH8bk/hJFjb46NQFR9oKNC2gfKjRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvGhtNRI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22403cbb47fso35312455ad.0;
        Sun, 13 Apr 2025 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744541047; x=1745145847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXYh9opa2X5pw5Rnzm4RLKwzbCVPmlk5ZFIxldQ6nv8=;
        b=RvGhtNRIwjXPUXxMAnw5DHiEx5LlyNbbTU52baIfgMOGcnluMc2o2ygBMXcwB3LvWF
         8B+srV5piOKLuEAoE7Aq3Akw0aSvRLxMY5yPT8fUeRb2SCeMxW1IkbqjZFkoEJo+rpZY
         HKupA12/34qjhv7SyMlm3Kb2sd84P/bo7VNNdE7t6GZxSXHQCjNxjp567PPKzMWQkAMV
         ELyJgvaWc6uYBPknc62yhU6j5ldNUPWm+DCUbh330IX+TjYnGV8e8VFHK3FK70P9mHap
         +f4qsNEYDMB/MC/k8YGBT6C+Ejnbs+XRFG5XFeIqBHMQIKyJBHM6OVvZPL5YtF+Cu+yD
         HNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744541047; x=1745145847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXYh9opa2X5pw5Rnzm4RLKwzbCVPmlk5ZFIxldQ6nv8=;
        b=iDDxdf32zVcfIr129SoIKpmTbtvlVKTYt7Py+YgxYZhoaqMTMmICE9tsgDGb8+kDBv
         zbe2WfDZZbhjoKnsRe7sr/dmCSyTsXWk3Ep0Dg99J4NHAciZRxA8Txpj+D4qkRfbykEm
         sPIhRXTcDFw9l+w9xZWsTTBZytKdhR1+A7ENbbkLxw2z0GrTSojYr5+xW5QnmaJ3pqlX
         By5zypZan+YKG3MoROPeU89XzAKG56YlK1bQv6ZIRGtMzei2YUFSNZiD4UL+uB7oA91j
         gxDuElN4rpbDwP9N5icBwULeUXEVK8xvqBYBVHpKQmK0FqxzcipxK7Qm2oB2ATwoQVNi
         Eftw==
X-Forwarded-Encrypted: i=1; AJvYcCUO5rdMHLzx2DtCJlpA2uWgT10FD6FcpHO18aH59nVVBOTcP7FiyIHctE2N7lLJwmyVBYepZjdV@vger.kernel.org, AJvYcCUXpvUbdgmHmbugXDZCwBAk2smDjPeYlmXQJT+m6hyo2QRCIzriqJHHvmbZMwt1Cz0e8fXNPdICZGXzUwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwddJaiWTT6KMikRZAPWKHsX4ROu1ccX/20EGgolxYe7huJmA/3
	TZt6xwQF/MYjiTdDNX93+vrzaVeleJq4SwiUPDDPOf2KMnc1+25a7F/NU4U+
X-Gm-Gg: ASbGnctK7htoNiIzSZ7M+YHaERql8eSh6xP3/TgaFedCrQaqfcnzlHeoL+Li4kkdPMM
	CRm0hUeYzjrjGXClDYAamGQoCt3X6q8kDH9qGm5ZkerA2+uGmj/AK+7v1MeHetyY65mwT+SvAui
	Xa3RpeqeZ6xaOq8IDHxCg/7iqFEkxJEW618wEfQkptCB1ImMTlTry45PtjMKxgsOJdugrADski5
	3ITEokRA4PNYEqljbD8S1/rV6Z5rV7K+3xJu4xlqThhU2kGAbAl6zQeSqzFNbj2TM5fyX8L+LoR
	wNwJNHkZxfTwkscpkPLRg1r02Q9kRnhCxiRUqLjRWFRkEc8yt9cQBJ3DnAkL8JlO/z3jSwZorTF
	TU4XeRYZO0aFO7WWQdA==
X-Google-Smtp-Source: AGHT+IFypWOBT4wfsDQKHBuJUDjAJz72aQLPZ2NaN1OHXhRN1dQG4TjZcQjsuIdLpwZtdcbDumqOpQ==
X-Received: by 2002:a17:902:e5c8:b0:224:78e:4eb4 with SMTP id d9443c01a7336-22bea50017emr120282245ad.39.1744541046974;
        Sun, 13 Apr 2025 03:44:06 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8af56sm80160885ad.66.2025.04.13.03.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 03:44:06 -0700 (PDT)
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
Subject: [PATCH v13 4/5] rust: time: Add wrapper for fsleep() function
Date: Sun, 13 Apr 2025 19:43:09 +0900
Message-ID: <20250413104310.162045-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250413104310.162045-1-fujita.tomonori@gmail.com>
References: <20250413104310.162045-1-fujita.tomonori@gmail.com>
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


