Return-Path: <netdev+bounces-132367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864069916C2
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5F61C2157C
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 12:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46A156C71;
	Sat,  5 Oct 2024 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6MnbTH6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CDF14F9FD;
	Sat,  5 Oct 2024 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131192; cv=none; b=KF0ytc9qWVbqjoraNMHExDeo0Z3v9E+pZaSFnC8OOKP8cZ9dKrcK1HTpJpql5zQiTjJjTYPsdkKrE/C/WFwGyj9srmahHkGi743AzEytQ3CDaKlYoKO0Mvy8vUL/kgxY/cifa1x2JgRMyilNYDQdSCODRIgPVmUQs8sNaCv32N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131192; c=relaxed/simple;
	bh=wKhSL52KtyNQuFpvg1KAEd+hgO7B46PWjlKb2ik9skw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5w2H7edGjDiSLSKQX2druzgl3cKgQue8Sg9NwYTJamOscHcYDJPm4rUydfIv+nDm7Ovlt876UAUQ0WFZNRB8ZuslxT9owCyKOSHTBqRFo/mejHvAXtvsoogR4+flVbxzo8vSGuHLqaxnixHps1khszibVjdsSR7Fdz03gEFckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6MnbTH6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71dfc250001so22907b3a.2;
        Sat, 05 Oct 2024 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728131190; x=1728735990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rp/njmks6r/M/HAsaNDxOLvQZ0JDeDbotfFoRfrRz6U=;
        b=i6MnbTH6N93gj06U2aFaDOqhxK1rjbV9YssrqD1stiSLG/xSGvt8yxSVKGAziA11J2
         jTrLOF4qNuUslkEOsgq2FlGXq6+YMI3GTBSS1W4fbNHL7jIv1q3KS1IO/f0PRsh+pgMq
         YnKL7nNVQbcSVJ8gp5Lh+6BpfCmpAmLGH8r6i2EdfBy6d286ltcZSZlNZ/W+lTAPyVRs
         c8ngndZanLkTwg6M8k3xKW1BD1uCnDq7cCP4lc67fjJ3y3BFITK+jbvGZ4RgJenhHEb7
         JV/F6/xvYlsZD4HYMJ2Vn8yHyGO7Wp/ORIZ3Lx8MBtNC6Z/x5rj+uIUOaVs9QLzR/dGd
         vTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728131190; x=1728735990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rp/njmks6r/M/HAsaNDxOLvQZ0JDeDbotfFoRfrRz6U=;
        b=oCBi3UgNIiBNYhKlP+od4eQf+ud4DdUH0cF6Kqh9P9wBCTuMsh6r6C5MJfPzUcOsf9
         j6vWiY0ZJI5iq8AnS6Lpdr0fjarfTuWzzR3viTt1WVRxxGeE+JTXCGcRV6qHZCRSyC8R
         nPXZinY3y6tziJr+R7UaSgxmFr0zVSt9rcEgnTdD4cKhlyT9YboDzJBSccblDH1FNbDb
         hrEXuKwL+lNLI4NOyIsIULd7nIG8ZWMXDCa4dGCPx/QFx6Npqte9trYCw42rcVbcjsTf
         BTMGdkR8TKLjFPhvYG1KBC8N+HjEsLXXFvOBVOH9S6CFFAbvwUzhkWtCRt9y5qpdPX5a
         93Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXNudWsx0eayk17TXmEHsfvnTRbyXX1RzxPLQwtqIsZllayhJcJxPRM5MCVQJhZf5V1iacbo3IQ+Y2yXms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOyBNAvy6jaGkbRbK0r8/Kyq+RZvWqxp4kyWBSDDJboLzO1Hjp
	h9HarX9zdNX8X+VvyIlJxxeGCB6TRSgHJykUjHpQAzOoQkFNO3Fh0nuFRxJp
X-Google-Smtp-Source: AGHT+IH+zyWHTg8WIGpAjbBHwrRfYYIR969NvgSDZjOZUwIrdguNxSgSqM8ScBgGTurIZByAW2lTPw==
X-Received: by 2002:a05:6a20:cfa6:b0:1d4:e418:c2b6 with SMTP id adf61e73a8af0-1d6dfa23c3dmr7582407637.10.1728131190554;
        Sat, 05 Oct 2024 05:26:30 -0700 (PDT)
Received: from mew.. (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd08besm1397878b3a.79.2024.10.05.05.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 05:26:30 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/6] rust: time: add wrapper for fsleep function
Date: Sat,  5 Oct 2024 21:25:29 +0900
Message-ID: <20241005122531.20298-5-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005122531.20298-1-fujita.tomonori@gmail.com>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a wrapper for fsleep, flexible sleep functions in
`include/linux/delay.h` which deals with hardware delays.

The kernel supports several `sleep` functions to handle various
lengths of delay. This adds fsleep, automatically chooses the best
sleep method based on a duration.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/time.c |  6 ++++++
 rust/kernel/time.rs | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/rust/helpers/time.c b/rust/helpers/time.c
index 60dee69f4efc..0c85bb06af63 100644
--- a/rust/helpers/time.c
+++ b/rust/helpers/time.c
@@ -1,7 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/delay.h>
 #include <linux/ktime.h>
 
+void rust_helper_fsleep(unsigned long usecs)
+{
+	fsleep(usecs);
+}
+
 ktime_t rust_helper_ktime_add_ns(const ktime_t kt, const u64 nsec)
 {
 	return ktime_add_ns(kt, nsec);
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 3e00ad22ed89..5cca9c60f74a 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -5,9 +5,12 @@
 //! This module contains the kernel APIs related to time and timers that
 //! have been ported or wrapped for usage by Rust code in the kernel.
 //!
+//! C header: [`include/linux/delay.h`](srctree/include/linux/delay.h).
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
+use core::ffi::c_ulong;
+
 /// The number of nanoseconds per microsecond.
 pub const NSEC_PER_USEC: i64 = bindings::NSEC_PER_USEC as i64;
 
@@ -178,3 +181,16 @@ fn add(self, delta: Delta) -> Ktime {
         Ktime::from_raw(t)
     }
 }
+
+/// Sleeps for a given duration.
+///
+/// Equivalent to the kernel's [`fsleep`], flexible sleep function,
+/// which automatically chooses the best sleep method based on a duration.
+///
+/// `Delta` must be longer than one microsecond.
+///
+/// This function can only be used in a nonatomic context.
+pub fn fsleep(delta: Delta) {
+    // SAFETY: FFI call.
+    unsafe { bindings::fsleep(delta.as_micros() as c_ulong) }
+}
-- 
2.34.1


