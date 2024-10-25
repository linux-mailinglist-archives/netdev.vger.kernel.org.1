Return-Path: <netdev+bounces-138954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3FE9AF83E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBDFB21A51
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BD318DF7E;
	Fri, 25 Oct 2024 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7HV722M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07CF18C026;
	Fri, 25 Oct 2024 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827269; cv=none; b=pb2wTVZ7cBuN7RtPFXOXX2WphpGx28LAOqS3MqLoZUc8S9LB5lu7RuDr48BkbMPqE/AwdMAloPCu9BLtTiyDNd5SjWGHDfhNCrKNV+HNb6ui3Fni6CG9mGHhPZVeuas3I0Ovh/uMOrOeLUVtWQhTNhgoG5eIrbZ+OifVY8chFyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827269; c=relaxed/simple;
	bh=mWHpPnrTF6Q0Hm9rpOdF2THfrTVg9CjRiAj6+nSsZHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SF2KD8OY2WxJ1hQ37vY2TzLZyPMMffjykp/kgx8dSxnt7HDj+L0Bd/IZibURSdZQ6EfRADmf26LzPpyQP6vm1xoVaP9Nlnu510ZYwWdlEcPhvABM8W9LoV7iMJdRuV2ZM/kmM6a8NaFnnMxPnBWCiHRz/6XCZlCar/NAEOKoahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7HV722M; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea9739647bso1055376a12.0;
        Thu, 24 Oct 2024 20:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827265; x=1730432065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Wl4GcGidfDtEyCvPxvj7s9PVtdkPVOt/OW937eNjmM=;
        b=k7HV722MnuP3K8DxKZSYSgXxj2prQ0uI00o+dsb/8aP3HEQvqxrqrgrpYHSaz6WO98
         r39fq/JApOybN1tDUgMrp9zeFSiC+XbjT74p+YIVbJDntjQGI+66hMn2vMwaJWfDX2gB
         i/9XYUP6fygq686E9sImFBFD3tEXRqf0NqIso+i49ZgiNRP3mTZ31d/U34nDJirwb0yh
         UL6+dY/YJazHk1GecPQmPgjqr3DMxWLhwQTk8lYIqbbni3TTJ5UbPc7F0dL3TNWL+KTR
         al0AY4LAChlOIwVT5/ih6a1mfpu2477mGz4ZSLxUsJZTvir4QIQJBp35a+gOY/a8UK5E
         YpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827265; x=1730432065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Wl4GcGidfDtEyCvPxvj7s9PVtdkPVOt/OW937eNjmM=;
        b=lKoUpUcu4rm9ux//fcls4lQOm9eAUBIf5q+9GcFQwd34wrX3ffXsGb6ZPxw+lj9QzB
         DDTrBOQYaLGGc38uausbeLyVOFGgDcwxeUddoIytCPsEXFTOhNh6+E4MZWvWZcatXIdD
         hQxrJAkYK+ZgSDETZ6MEouca81vESkUeBdQ1wwS7Oot9PpOKHZYbnay66dwIHKtttity
         gubIDyNBSlQRh3M73Q6VCYHbQr9RaJpxEdawSDnlUcIVqEtCflHD6ikxwLn21hEP2LGG
         U3yyb8oaj/HzW8cvp96Goe9Jyo5Z/CHQ+xzh8rbbfrjVd5He9w/xA3axnRKgsN51qrdL
         TELQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl40DgPaDZSBBMCvOyZ32OwvlRdxzdFqE4WsD9SnwjXdIa2iVsqSzIXVDbZGOHjhBOrVyHWXcM09kr/TkE9D8=@vger.kernel.org, AJvYcCXnhFHvMMTg24MpIfIZ/35CDvaTtrI5olqGU3sAeA7xwuxA+h9c9cCAwNamFc8YEoUYp3mij1Isx+KQnNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcYJ4/1j4X/Mr5RS91irEoGm7TV9RNNP0atQv3Rqa0uYR2Wohp
	5hPR8eGyZGvfJBqBXT18pTyLNtzWLOULVe9UtuUHORnQ3IcOv6Wc
X-Google-Smtp-Source: AGHT+IENknjlGegsPU/e1TwHHmrvQOxgBVrGDqADb+JbLIbhsoAzJAABlkXR9uMzGPrG7+R6ORm8eQ==
X-Received: by 2002:a05:6a21:9206:b0:1d9:21cb:ecdb with SMTP id adf61e73a8af0-1d989d039f8mr4980104637.41.1729827264905;
        Thu, 24 Oct 2024 20:34:24 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791db5fsm180188b3a.11.2024.10.24.20.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:34:24 -0700 (PDT)
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
Subject: [PATCH v4 4/7] rust: time: Add wrapper for fsleep function
Date: Fri, 25 Oct 2024 12:31:15 +0900
Message-ID: <20241025033118.44452-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025033118.44452-1-fujita.tomonori@gmail.com>
References: <20241025033118.44452-1-fujita.tomonori@gmail.com>
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
 rust/kernel/time/delay.rs | 30 ++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
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
index 3cc1a8a76777..cfc31f908710 100644
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
index 000000000000..f80f35f50949
--- /dev/null
+++ b/rust/kernel/time/delay.rs
@@ -0,0 +1,30 @@
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
+/// The function sleeps infinitely (MAX_JIFFY_OFFSET) if `Delta` is negative
+/// or exceedes i32::MAX milliseconds.
+///
+/// This function can only be used in a nonatomic context.
+pub fn fsleep(delta: time::Delta) {
+    // SAFETY: FFI call.
+    unsafe {
+        // Convert the duration to microseconds and round up to preserve
+        // the guarantee; fsleep sleeps for at least the provided duration,
+        // but that it may sleep for longer under some circumstances.
+        bindings::fsleep(delta.as_micros_ceil() as c_ulong)
+    }
+}
-- 
2.43.0


