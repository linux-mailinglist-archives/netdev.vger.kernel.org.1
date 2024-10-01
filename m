Return-Path: <netdev+bounces-130827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A9C98BB02
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1610D28395B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A4F1BF81D;
	Tue,  1 Oct 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvvXvyF6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB21BF325;
	Tue,  1 Oct 2024 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782048; cv=none; b=k1uEwfNgWqkbAOrUn46f7XBGoQtmtEZYdkyzLftnP68JhItGLZ6kkbrbrVDASFhT0Rj4+yF8wsA3irBk6SK5Jg0V4liLVII2x1uzrx0qKseDoYPSxcckkBzQgN/MaxXi4MhiTMCCbU5YGf5aIZSPl119IKRrXriWLEymHC4ijbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782048; c=relaxed/simple;
	bh=yqXt66sEyXMlAC3dCH/jtRr9vQffgQTlUuFkBnLhxvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5RDY+g3FZOqgGl2XN8jFz1ITBV1NXcGmf9YLlgcGUvsOjyYIsLQz0CmOU6IrN6iOuYInxqN1B0Cj0gagsIVUIAWvm8FhwnrszKfVyQcSQn8XTrYoUcjdljESYgvDia8FKoCgENQKaMYzFpjo9/7GUncII7HXOeJiXSmHdsMxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvvXvyF6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20bb610be6aso4780085ad.1;
        Tue, 01 Oct 2024 04:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727782046; x=1728386846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlPKidIYwm3MXZtiEa4wSQXTGgPq8sJeZAg+CsgWPh0=;
        b=SvvXvyF6AwqBni8yXnxTFYFlIYC7kNE4L8n7ZEZEV775B1MsWCFIL/3HKTNJOpJozg
         50kMfQb+Cc/QoMyJiN6rNwQI19JbQGQFVR8Ep3wL9l5WVn2LxWzdUGB1J7bjoIAbalOT
         DtZQGcuac+s0TPpmiPmIQwvE38y/Xx+54DPJEYNNo/n5IdjFTxcyUBVYJPql/syUMREs
         UhbuwFohpSA5yG4zwugrdXVJ/k/Uyf0Vc5GCf3+YXUiaoLjO91MdNcZqaIqvo9/pFCXI
         xvmRI+w42kgWEo+4AmgSTQqJPhaIz7jdKzUWyAONiJgK9AdA0lest7ynDahvE4Xf6RwY
         1RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782046; x=1728386846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlPKidIYwm3MXZtiEa4wSQXTGgPq8sJeZAg+CsgWPh0=;
        b=cYceDNlVinNhYKod15OGt7GykHkNmNc3meGlj2h6HGvd85xwEA+pyogyNQuBl8y4ew
         Fewwal7pep/5H4XZ9ex1haT0b0Bppetkv/umaW1Qs4AHEBOu7IL3Hb7zhhBAdvq7ML6m
         O4xoUsqNON6MdldzIk7ZH2ckxP6r8VkR5uzNkJy+2RLKuRrBH04tDY0cKSTqrRJ9n7Qw
         uG3nQPT+dDhclNY3SmL/NC6PIG9eHxRU3sfHw6Araj+cqaWwMXhk3Ob/+DHlm1tFirci
         bBQxR1kN3NGCmoa3xKK2rsIdN9pOrWVPSQm5iWdxk5ZJL2Gc3ax+Gr0ZbmF472ccQl0/
         y0Sw==
X-Gm-Message-State: AOJu0Yx7mzyfrWaTFHL8HRh29QEc/eir78Qd4PjmIuRZgx+e9AJHNKmY
	WAv3BqR2E+RXim2IAHVGb6p3uzNPGnJR20EOavjUcFsfAk0mKnr24jgAApAZ
X-Google-Smtp-Source: AGHT+IHN4kUiwBxcyZRXS4kRKb+dMyxF01ksJUqHkgNBrMMnCnArX14RBKnUlpFLIMfvCKEnVqNyKw==
X-Received: by 2002:a17:903:41cc:b0:20b:5f81:6e8c with SMTP id d9443c01a7336-20b5f818312mr150020045ad.27.1727782045999;
        Tue, 01 Oct 2024 04:27:25 -0700 (PDT)
Received: from mew.. (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e51330sm67893655ad.254.2024.10.01.04.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:27:25 -0700 (PDT)
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
	aliceryhl@google.com
Subject: [PATCH net-next v1 1/2] rust: add delay abstraction
Date: Tue,  1 Oct 2024 11:25:11 +0000
Message-ID: <20241001112512.4861-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241001112512.4861-1-fujita.tomonori@gmail.com>
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an abstraction for sleep functions in `include/linux/delay.h` for
dealing with hardware delays.

The kernel supports several `sleep` functions for handles various
lengths of delay. This adds fsleep helper function, internally calls
an appropriate sleep function.

This is used by QT2025 PHY driver to wait until a PHY becomes ready.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/delay.c            |  8 ++++++++
 rust/helpers/helpers.c          |  1 +
 rust/kernel/delay.rs            | 18 ++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 29 insertions(+)
 create mode 100644 rust/helpers/delay.c
 create mode 100644 rust/kernel/delay.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae82e9c941af..29a2f59294ba 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
+#include <linux/delay.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
diff --git a/rust/helpers/delay.c b/rust/helpers/delay.c
new file mode 100644
index 000000000000..7ae64ad8141d
--- /dev/null
+++ b/rust/helpers/delay.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/delay.h>
+
+void rust_helper_fsleep(unsigned long usecs)
+{
+	fsleep(usecs);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 30f40149f3a9..279ea662ee3b 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -12,6 +12,7 @@
 #include "build_assert.c"
 #include "build_bug.c"
 #include "err.c"
+#include "delay.c"
 #include "kunit.c"
 #include "mutex.c"
 #include "page.c"
diff --git a/rust/kernel/delay.rs b/rust/kernel/delay.rs
new file mode 100644
index 000000000000..79f51a9608b5
--- /dev/null
+++ b/rust/kernel/delay.rs
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Delay and sleep routines.
+//!
+//! C headers: [`include/linux/delay.h`](srctree/include/linux/delay.h).
+
+use core::{ffi::c_ulong, time::Duration};
+
+/// Sleeps for a given duration.
+///
+/// Equivalent to the kernel's [`fsleep`] function, internally calls `udelay`,
+/// `usleep_range`, or `msleep`.
+///
+/// This function can only be used in a nonatomic context.
+pub fn sleep(duration: Duration) {
+    // SAFETY: FFI call.
+    unsafe { bindings::fsleep(duration.as_micros() as c_ulong) }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 22a3bfa5a9e9..c08cb5509c82 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -30,6 +30,7 @@
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 mod build_assert;
+pub mod delay;
 pub mod device;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
-- 
2.34.1


