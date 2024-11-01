Return-Path: <netdev+bounces-140861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C5F9B881D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABBD1F223A2
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD1D132139;
	Fri,  1 Nov 2024 01:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0dnR0Zs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D587C29D19;
	Fri,  1 Nov 2024 01:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422956; cv=none; b=LTM6ht27ffXEIIZB0nLBoXCxr4LxJZEMlgJHS9A61xRD82t7FnMddYRgGbc4aocDmHPabzvbptjqHxN9jOymJRv6IE8/5Obe0h2O5BgIW78u8uF0gtgUu+UKjB/kJbeYEwfScCnhY3GPnh1omelnsXkT/XM44Xk3mHmVURR860w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422956; c=relaxed/simple;
	bh=FvpqWnzB0jVSnw59sQwssA4N+d90d6I3eymP7JQbvn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9vNc6PQmrdyJuFIB0V5xgP+KkzWfKxRSm5qz6b3zLXyc8y8YGMUT3k0Qhurz7h+QX9lkXHSZQX095SdYJQVo8U31N08liFKqDr9qj/k86XtVuVNHNgeQk68A12kxta85jbR2rAO51L15O334QWUSnlUlXutsST3V+IL/7PKSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0dnR0Zs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so1304721b3a.1;
        Thu, 31 Oct 2024 18:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730422950; x=1731027750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YjnWtPONxIMZE5drgHndbLVFH/a0haqtE8goaJuGsg=;
        b=L0dnR0ZswCXvmuhLoxBurEL9SzwdG7BRhL5kwJaApsE7AYKUJ1dPcqoQOMAKE7eHeV
         ga0b2kmucaL00QF8GoQTHtGY4fRcKZPOV+9eljRfBqKmJsc2t+UpioWAsYujI6loaXhD
         ScRNAWyKFxYwkP3vxEuQrCny5YErSpd56HdIlZmom/R220Ban9Sf1ZTl5mTqGrPWknie
         PldF22EynhBJVeQl+CVlAOcc7KB4lRiUuNnkc7Yh/j9+W9ulc2sANLYKU1rhgU4CaXox
         0Pn8zI18/GGHWg/eeZDYlitTUiq5TmDflhkbe+HQN47Jyd1Wj8EdDi8LzNpNBxS2yIxY
         /iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422950; x=1731027750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YjnWtPONxIMZE5drgHndbLVFH/a0haqtE8goaJuGsg=;
        b=U0/M6H3Pv2J6RW1Cqd4dQXJh9iMvuuvmTsz5gnpwcijnFejaA09djw38p3yEb53SYh
         AayqOoTUwjiayS31wqt5uIFw7tUSW/xN7u+iv1ZzzemEQzcJVy1brdunzymoce1u7W9Y
         g6pLcJQ1titQ8tF2W35wHjXB219/+FK1VWrTtccW/ovQzSQKPJFZ+E+3HAPu6T/qoHRE
         mE3yPAs/1eE4q6t7SdWSComDpc2LlPsm+g2RmKU8XQ1falc2RNuFDqAEpElNbXK/JRv7
         UuTw90AlbzePMMVU+zWQkU2Iio9IxOi08FB9IfuYpAZHBt4iLxI8qHZpZjK6d2BRdxn2
         jnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/POqJEEzgjrCLt5sRB5gU0Ek3l3Jko8OK84RdItY03sHu51fCRiDOqb55ZzAvvIE+psuNJq2AwDf1HS6ZyY=@vger.kernel.org, AJvYcCXeuirqZIeiUneYm6Mlo6vc24ax/3Eb7f6zGPsSgCtCzwUIVZXhAvQzvRUj6EeeWGYrXGeGJuWTYQhehsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHGbM34FKqMP6Qn7b1R+LnpU05nGNQnoWf4s7s/glNhW2FuJ1
	b3NVDTofsQIECsaQsilRO4TQmqP6wonsYPJFOU3npJEa7Xq0vYPU
X-Google-Smtp-Source: AGHT+IH/mMWTOXxIyKN1UpAnVdpI4tYSCS0MdqWDYFilbE3n9k4VQVdfEhU/HA2cLajGDyUZycdNkQ==
X-Received: by 2002:a05:6a00:2385:b0:71e:3b51:e856 with SMTP id d2e1a72fcca58-720c98833a6mr2643314b3a.1.1730422950021;
        Thu, 31 Oct 2024 18:02:30 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ea6a1sm1743403b3a.74.2024.10.31.18.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:02:29 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
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
	arnd@arndb.de
Subject: [PATCH v5 4/7] rust: time: Add wrapper for fsleep function
Date: Fri,  1 Nov 2024 10:01:18 +0900
Message-ID: <20241101010121.69221-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101010121.69221-1-fujita.tomonori@gmail.com>
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
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
index e4f0a0f34d6d..9395739b51e0 100644
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
index 000000000000..c3c908b72a56
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
+use crate::time::Delta;
+use core::ffi::c_ulong;
+
+/// Sleeps for a given duration at least.
+///
+/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
+/// which automatically chooses the best sleep method based on a duration.
+///
+/// `delta` must be 0 or greater and no more than u32::MAX / 2 microseconds.
+/// If a value outside the range is given, the function will sleep
+/// for u32::MAX / 2 microseconds at least.
+///
+/// This function can only be used in a nonatomic context.
+pub fn fsleep(delta: Delta) {
+    // The argument of fsleep is an unsigned long, 32-bit on 32-bit architectures.
+    // Considering that fsleep rounds up the duration to the nearest millisecond,
+    // set the maximum value to u32::MAX / 2 microseconds.
+    const MAX_DURATION: Delta = Delta::from_micros(u32::MAX as i64 >> 1);
+
+    let duration = if delta > MAX_DURATION || delta.as_nanos() < 0 {
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


