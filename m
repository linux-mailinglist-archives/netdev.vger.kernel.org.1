Return-Path: <netdev+bounces-132364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86BC9916BC
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A201F22E97
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C86A1537CE;
	Sat,  5 Oct 2024 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THCf9Qdk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C01531C3;
	Sat,  5 Oct 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131181; cv=none; b=aTb+pn/TmDbkUWtmpv6CyYunpIilg6bjYy51jVNlvDE6Qv3CEXPOoOV0uoqKDLNwKVInnBMzwyKJYfXtdS5b/IDGGdTozdVKAOjfjGl4DeOHedAvOhGvUPbPeKpj5WcwwcrdtYG4/j9XVZbUr+7+nupD4zknffeXVJS6hseunN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131181; c=relaxed/simple;
	bh=+nc/Z5V3f5KGTXPQ+kwQEPon7lqKacKesqid2l/Atrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COoNUe2nmA0jMSfsla0/G7rH/I9kbzZ2tt8KyMDQdyjG6G6k14rjDsgCz7bkvWgK7ic6rm4IlKoSyEScm9mdhw6ssTjH+rWmXCDtf5D4LJ+B+XbaIFkch0Jugtdsq9tEoKT6JBek5ECeyX/5wmSWcTfbV8YZTcI/6ugbiLC8ro0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THCf9Qdk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71dfc78d6ddso2851b3a.0;
        Sat, 05 Oct 2024 05:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728131179; x=1728735979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKGy300dtIv/lfmSvdg2mAnHWaFMshcSd90+qpYaYEc=;
        b=THCf9QdkEVyF05CcA1c0DDqhVq4F5cZl4daXcMj0/hNOAl3QWIUcPETNy/AHUHLZFQ
         iNDfG+pSBzUfaGsNYzL+9CXMknUIOd3M2Aw7oezIRFwHf3P8FpEsGNuuYkIXsTJNjE3S
         MDBvBbXQMIPqjW+MHuDRtht32tnWl05SSoo9HPSKBVsnNyUHgMeeFM9HJg16VLjgxWNr
         A1yKMgNT6lqkSEkPwnB336VoRA3DL5lVAsRjbbRa7/fgvuIJDWxNQ9Xahjhff1uQi9au
         nMIgapzMsxPjWE1QKeB7GTNXKKpkwx342U1b86rIGRVRrccX2akAgeg4uIWd1lmgI+tn
         q4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728131179; x=1728735979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKGy300dtIv/lfmSvdg2mAnHWaFMshcSd90+qpYaYEc=;
        b=BhlYZUYTn9+AUAHhxg2TOYYFlJQaH+ODw9iGmpbE/HT5STmeB6XU0Cx4L/2NewezEv
         rKu68toqsasSxG4e6g69Y0tQ+0eLjVBgU6cLi57TR3YQkPUxx2WxynMqnvfmv0+l5Vlq
         Pd2Leh7bhXuLhdg3dWRVCyU26/7gS9CUaWcqeZnHaoVxoHFAxShCE7qfqDeSovs+4QPx
         4rw9loT7l8oydhXsitmbpC+BcpftGxrgSfsQmAK5jF3Hc8oJTgPnramjTy38mg5byrZW
         rKuU0bZLGtc5ku3eAshLs2jQYk6QIL0AD1QbMfooFVEl5okBevQmrhnjiULA+B0GBDIq
         irMA==
X-Forwarded-Encrypted: i=1; AJvYcCWd6bwiadEhXGLsNOuc0Wa5woMs20CSO5Qk9qXjjscoBhxUBuim8P5EAMqLMz17sQLDOgFWcxFi72CFrJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC7lvjgj1DGttGP3kFM0M+ETAg5AcsvczdMspyZMz0y5+OesLx
	CEbuRmWqOTyBLLH+spv0YlvGUCGWXEuyhUbpW8O/yJumDn8L+Xv775ECuX0H
X-Google-Smtp-Source: AGHT+IEO1cM5AenyITIpMoldc/U4hQBqlkR4S7eRUdgYqpXiG+HhIfXVdaOOdti14V+pqK22v0iCUg==
X-Received: by 2002:a05:6a20:d70f:b0:1d6:e852:2362 with SMTP id adf61e73a8af0-1d6e852236amr4434484637.35.1728131178997;
        Sat, 05 Oct 2024 05:26:18 -0700 (PDT)
Received: from mew.. (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd08besm1397878b3a.79.2024.10.05.05.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 05:26:18 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/6] rust: time: Implement PartialEq and PartialOrd for Ktime
Date: Sat,  5 Oct 2024 21:25:26 +0900
Message-ID: <20241005122531.20298-2-fujita.tomonori@gmail.com>
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

Implement PartialEq and PartialOrd trait for Ktime by using C's
ktime_compare function so two Ktime instances can be compared to
determine whether a timeout is met or not.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/helpers.c |  1 +
 rust/helpers/time.c    |  8 ++++++++
 rust/kernel/time.rs    | 22 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 rust/helpers/time.c

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
index 000000000000..d6f61affb2c3
--- /dev/null
+++ b/rust/helpers/time.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/ktime.h>
+
+int rust_helper_ktime_compare(const ktime_t cmp1, const ktime_t cmp2)
+{
+	return ktime_compare(cmp1, cmp2);
+}
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index e3bb5e89f88d..c40105941a2c 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -81,3 +81,25 @@ fn sub(self, other: Ktime) -> Ktime {
         }
     }
 }
+
+impl PartialEq for Ktime {
+    #[inline]
+    fn eq(&self, other: &Self) -> bool {
+        // SAFETY: FFI call.
+        let ret = unsafe { bindings::ktime_compare(self.inner, other.inner) };
+        ret == 0
+    }
+}
+
+impl PartialOrd for Ktime {
+    #[inline]
+    fn partial_cmp(&self, other: &Self) -> Option<core::cmp::Ordering> {
+        // SAFETY: FFI call.
+        let ret = unsafe { bindings::ktime_compare(self.inner, other.inner) };
+        match ret {
+            0 => Some(core::cmp::Ordering::Equal),
+            x if x < 0 => Some(core::cmp::Ordering::Less),
+            _ => Some(core::cmp::Ordering::Greater),
+        }
+    }
+}
-- 
2.34.1


