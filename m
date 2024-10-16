Return-Path: <netdev+bounces-136025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE24E99FFC7
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300EF1F22018
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACA418784A;
	Wed, 16 Oct 2024 03:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/csWfRZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971A18C02B;
	Wed, 16 Oct 2024 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050839; cv=none; b=H8I85+bEtuOYNLthRKCassvaqH6Blzs3OHd91M2nLGzjz7NqTr/5arTsdBH9DvBLNhpis5k9BYfNDigdP3FMt9xs1JyUp9Ur+oe7h9rEpCHYvYQPr7dRNtAba7Ghg0N/2a8W6CJt/7ds2jdKeKH2L/gNm3V3fJJGC8URwwGFVJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050839; c=relaxed/simple;
	bh=gL3wRmMknlT+8W9oXhS5GNiPGVIJ3Au148RU8vApvBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHmITJ/aWPsoNtHh0UsNnROZHTbhMFu7mLIOj1iEzrZtB1aaUo6Rc5O8H4GvtGppnIJxEBwZSzs5jsAS1ROKxnkNY+/Xl7mJKg5f5A02QDYXw2AJe2mzwe8iRbC15S9b+MkhXBChz6BSENa+Z6Rq6ivVbcd+pNyoO1PHIe8c+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/csWfRZ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2ed2230d8so3568130a91.0;
        Tue, 15 Oct 2024 20:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729050837; x=1729655637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=509eXO9XAU0pFq5wqNoTY0iWcoToJ2G4Fpozd36voIY=;
        b=c/csWfRZLuaz7gdcaOYszDb+vobCNUZelAIdHeTbLyi8W08SyLqGJGUv8EOKfEuvm2
         b2uORb3J43r9D3Q/mNiYKeWtsUWJ4qO7NeWAe+xGDBAmybJWWWvTDgN1icFWKGggNUZm
         Qku2F0+vJf9/7MjdIkVYY2rzfako0+GQXozyt5n6k1d0m+UVkCGOVeweZ5UH1V/Gr6zu
         3gyORBeThMRTBqeRZ9ERNxB/ce2V3nZoLWliFHKl8eg1UqT+XHb8POYe0d7+1IyPgM8H
         km7xZun3SetMCis5IcBEaca22z+9htfEkhXM1sNiNQKvzMZ0g1EIsmPp8qOcKS/pPrJa
         JqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729050837; x=1729655637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=509eXO9XAU0pFq5wqNoTY0iWcoToJ2G4Fpozd36voIY=;
        b=wsHf/O9T/azVW6Off3wDpipV0mO/xv6a5mIZDRhmttpKFW5LwtXTehKJy+cZvIANZh
         nmUeZ0Ox6K4vVic0Eb3XuhihJiQi/yls2A4xkteWzPmTs2e0tRzsstFhau6V/k3cCz6k
         xz5Pb+syzivDIQGct20LacfcgQARvE8UyxGMhwbUo+FVZNEdTEyEoTul+/BowIMPhhnO
         yTes3J9iG4d1thfjMiQAeRtokg9kmVS3wN2H74KkB4de76vH4LHbcuf8pR8RKi3JnULQ
         LfxPocUdDcWcr+7pbjtP90qMFDLaSAnyFnRMt9rVpKXI0pjCClV+GzJUVJBE4wOmjEo0
         lZFA==
X-Forwarded-Encrypted: i=1; AJvYcCW6uo6JEL3VDSxMR2jHLB3gc8iBjjgN54I0Ll1sH2ydUDm2S9OP+IW+79jJFZsiMFwIEivv1pszFVC2gzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBgclHL+r31sdzt0vMkf7KrGSejAKxzKDOOwyZaYJ8DeEEHQ9
	ySHIHnvtKiRrqUP3Qk3Gp0KTaEGrR+IY8qttUPQXLGA5IRUGM78/O3A5m5q1
X-Google-Smtp-Source: AGHT+IFg7rwqV8upC4BWPoICnCtWUGDEBfoBMAy3BAbFXgso/4Q4SFSyYcNXlU3zi8flIPsJUksSWw==
X-Received: by 2002:a17:90a:fa88:b0:2d8:8430:8a91 with SMTP id 98e67ed59e1d1-2e3152c0653mr18771963a91.10.1729050837327;
        Tue, 15 Oct 2024 20:53:57 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392ed1a4fsm2885691a91.17.2024.10.15.20.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:53:57 -0700 (PDT)
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
Subject: [PATCH net-next v3 5/8] rust: time: Add wrapper for fsleep function
Date: Wed, 16 Oct 2024 12:52:10 +0900
Message-ID: <20241016035214.2229-6-fujita.tomonori@gmail.com>
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

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Link: https://rust-for-linux.com/klint [1]
---
 rust/helpers/helpers.c    |  1 +
 rust/helpers/time.c       |  8 ++++++++
 rust/kernel/time.rs       |  4 +++-
 rust/kernel/time/delay.rs | 31 +++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 1 deletion(-)
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
index 9b0537b63cf7..d58daff6f928 100644
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
index 000000000000..dc7e2b3a0ab2
--- /dev/null
+++ b/rust/kernel/time/delay.rs
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Delay and sleep primitives.
+//!
+//! This module contains the kernel APIs related to delay and sleep that
+//! have been ported or wrapped for usage by Rust code in the kernel.
+//!
+//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h).
+
+use crate::time;
+use core::ffi::c_ulong;
+
+/// Sleeps for a given duration at least.
+///
+/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
+/// which automatically chooses the best sleep method based on a duration.
+///
+/// `Delta` must be longer than one microsecond.
+///
+/// This function can only be used in a nonatomic context.
+pub fn fsleep(delta: time::Delta) {
+    // SAFETY: FFI call.
+    unsafe {
+        // Convert the duration to microseconds and round up to preserve
+        // the guarantee; fsleep sleeps for at least the provided duration,
+        // but that it may sleep for longer under some circumstances.
+        bindings::fsleep(
+            ((delta.as_nanos() + time::NSEC_PER_USEC - 1) / time::NSEC_PER_USEC) as c_ulong,
+        )
+    }
+}
-- 
2.43.0


