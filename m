Return-Path: <netdev+bounces-43699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C767D4468
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBFE2816E8
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E88C53B9;
	Tue, 24 Oct 2023 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSOVk1cO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC234A39;
	Tue, 24 Oct 2023 01:01:50 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6057110;
	Mon, 23 Oct 2023 18:01:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d1433c4ebso1062932a91.0;
        Mon, 23 Oct 2023 18:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698109308; x=1698714108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XiLqoqW7LAgzUHly2D/6acSOw9sz0aSWoxH7wPsZeE=;
        b=hSOVk1cOoEjOSXZhecQJ4KKz8HJ/ybCyu1Qr4SPtfPfYi7vfiRlimDYztu12u0nuy8
         vpW6cFtlO9Bi0b6lpqqJrB6qpth9KZT3fpQyt/rrzhefqpz4inLcnxodkZa7NLajHrgC
         VxrSKwQy1IQTInq6/M+uBF8amAqMDuqcQCsg6NYy2ogx1kN+lGwJcUlCZL0xuwqIMlbf
         ojgMbfZ59N7pFJTzDtIREYjnPtuTgyHAgRYr2t2cNb5C95d0LHdy5OOBZv1eToMSa9gU
         Cs2Lw+ibW7ojI9cj17tXr1gl7HoAR7nYML5Y0sL/4VPMJ+AtpXYkMsFeoWqtNti+s0nc
         UJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698109308; x=1698714108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XiLqoqW7LAgzUHly2D/6acSOw9sz0aSWoxH7wPsZeE=;
        b=Fapr51fcoZ6A+GIeqx2axI2JbtR2+WMZimhyVAkbw2WBbufuWAP2VBvn4i6dDUOzp/
         Jjcy7LmNDuGyXrkhP7bWervAZg8ZsitpMEsOgjonekJOf8qJVuIcj+CPCnNDjTRyYQlP
         Hg+gt4bHgqk4TaN5gCxkSTh73i3Hzi43GFZzpC/TOXd84lGklwFCFGK9dsZ2ZVpRBBy6
         55Fj83xlHRu1XVFFJuKelrqN4WD68bgo/CN/jg80vqB7gdsMqxRGwJcGhLISMn7qWR0p
         IqojmMWLc7VTXbSZh3uFZ6x9+9aA3XtWX1/EFKImwGAB4euPBF2O7CFxEYtD10B2CLx9
         0yrw==
X-Gm-Message-State: AOJu0YxIQ2ZpaHC774AIr1sGWTxQeWNDx7lTMR5AC9lk1RMgwg7BZia8
	p22NWtSGpdTygy5Q7jvpyGgxvInHr7yETw==
X-Google-Smtp-Source: AGHT+IHuVJpIVPpMtsX0oIZquZ/lwAa/T2jkVkztawya77MTw8SkSi1qluSffS5xGHo3Bh4xnR7E4g==
X-Received: by 2002:a05:6a20:e68c:b0:15c:b7ba:e9ba with SMTP id mz12-20020a056a20e68c00b0015cb7bae9bamr11092183pzb.0.1698109307725;
        Mon, 23 Oct 2023 18:01:47 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id k6-20020aa78206000000b006be077531aesm6707888pfi.220.2023.10.23.18.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 18:01:47 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	wedsonaf@gmail.com,
	greg@kroah.com,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH net-next v6 3/5] rust: add second `bindgen` pass for enum exhaustiveness checking
Date: Tue, 24 Oct 2023 09:58:40 +0900
Message-Id: <20231024005842.1059620-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024005842.1059620-1-fujita.tomonori@gmail.com>
References: <20231024005842.1059620-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miguel Ojeda <ojeda@kernel.org>

    error[E0005]: refutable pattern in function argument
         --> rust/bindings/bindings_enum_check.rs:29:6
          |
    29    |       (phy_state::PHY_DOWN
          |  ______^
    30    | |     | phy_state::PHY_READY
    31    | |     | phy_state::PHY_HALTED
    32    | |     | phy_state::PHY_ERROR
    ...     |
    35    | |     | phy_state::PHY_NOLINK
    36    | |     | phy_state::PHY_CABLETEST): phy_state,
          | |______________________________^ pattern `phy_state::PHY_NEW` not covered
          |
    note: `phy_state` defined here
         --> rust/bindings/bindings_generated_enum_check.rs:60739:10
          |
    60739 | pub enum phy_state {
          |          ^^^^^^^^^
    ...
    60745 |     PHY_NEW = 5,
          |     ------- not covered
          = note: the matched value is of type `phy_state`

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/.gitignore                      |  1 +
 rust/Makefile                        | 14 +++++++++++
 rust/bindings/bindings_enum_check.rs | 36 ++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 rust/bindings/bindings_enum_check.rs

diff --git a/rust/.gitignore b/rust/.gitignore
index d3829ffab80b..1a76ad0d6603 100644
--- a/rust/.gitignore
+++ b/rust/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 bindings_generated.rs
+bindings_generated_enum_check.rs
 bindings_helpers_generated.rs
 doctests_kernel_generated.rs
 doctests_kernel_generated_kunit.c
diff --git a/rust/Makefile b/rust/Makefile
index 87958e864be0..a622111c8c50 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -15,6 +15,7 @@ always-$(CONFIG_RUST) += libmacros.so
 no-clean-files += libmacros.so
 
 always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
+always-$(CONFIG_RUST) += bindings/bindings_generated_enum_check.rs
 obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
 always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
     exports_kernel_generated.h
@@ -341,6 +342,19 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
     $(src)/bindgen_parameters FORCE
 	$(call if_changed_dep,bindgen)
 
+$(obj)/bindings/bindings_generated_enum_check.rs: private bindgen_target_flags = \
+    $(shell grep -v '^#\|^$$' $(srctree)/$(src)/bindgen_parameters) \
+    --default-enum-style rust
+$(obj)/bindings/bindings_generated_enum_check.rs: private bindgen_target_extra = ; \
+    OBJTREE=$(abspath $(objtree)) $(RUSTC_OR_CLIPPY) $(rust_flags) $(rustc_target_flags) \
+        --crate-type rlib -L$(objtree)/$(obj) \
+        --emit=dep-info=$(obj)/bindings/.bindings_enum_check.rs.d \
+        --emit=metadata=$(obj)/bindings/libbindings_enum_check.rmeta \
+        --crate-name enum_check $(srctree)/$(src)/bindings/bindings_enum_check.rs
+$(obj)/bindings/bindings_generated_enum_check.rs: $(src)/bindings/bindings_helper.h \
+    $(src)/bindings/bindings_enum_check.rs $(src)/bindgen_parameters FORCE
+	$(call if_changed_dep,bindgen)
+
 $(obj)/uapi/uapi_generated.rs: private bindgen_target_flags = \
     $(shell grep -v '^#\|^$$' $(srctree)/$(src)/bindgen_parameters)
 $(obj)/uapi/uapi_generated.rs: $(src)/uapi/uapi_helper.h \
diff --git a/rust/bindings/bindings_enum_check.rs b/rust/bindings/bindings_enum_check.rs
new file mode 100644
index 000000000000..eef7e9ca3c54
--- /dev/null
+++ b/rust/bindings/bindings_enum_check.rs
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bindings' enum exhaustiveness check.
+//!
+//! Eventually, this should be replaced by a safe version of `--rustified-enum`, see
+//! https://github.com/rust-lang/rust-bindgen/issues/2646.
+
+#![no_std]
+#![allow(
+    clippy::all,
+    dead_code,
+    missing_docs,
+    non_camel_case_types,
+    non_upper_case_globals,
+    non_snake_case,
+    improper_ctypes,
+    unreachable_pub,
+    unsafe_op_in_unsafe_fn
+)]
+
+include!(concat!(
+    env!("OBJTREE"),
+    "/rust/bindings/bindings_generated_enum_check.rs"
+));
+
+fn check_phy_state(
+    (phy_state::PHY_DOWN
+    | phy_state::PHY_READY
+    | phy_state::PHY_HALTED
+    | phy_state::PHY_ERROR
+    | phy_state::PHY_UP
+    | phy_state::PHY_RUNNING
+    | phy_state::PHY_NOLINK
+    | phy_state::PHY_CABLETEST): phy_state,
+) {
+}
-- 
2.34.1


