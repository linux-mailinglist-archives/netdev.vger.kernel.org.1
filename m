Return-Path: <netdev+bounces-41895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E37CC1C6
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF31281A3B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7636541E55;
	Tue, 17 Oct 2023 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+ykBjSv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025941AB4;
	Tue, 17 Oct 2023 11:30:27 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CBAB6;
	Tue, 17 Oct 2023 04:30:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27d1433c4ebso1134600a91.0;
        Tue, 17 Oct 2023 04:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697542225; x=1698147025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqLooJ+nsKNiK4Nzm1hO6m4l3UAoDdmX4FSjXB0x9nc=;
        b=A+ykBjSv31IxqXbeuNU/MVlKpjSN2W85FY+dHJ12myB26Vd7QKOMDToZeCInC1LS3F
         Vn6PCdkr8+ZLS4CcDAKr31+GPICd4M2yxdRXVSOAP8UPyNQVyDFJxngAAQFIyjbinj9M
         FSk2OrWIa8/EdvMmL7OMVk/10++VN/BPw8Pp86tZNg6A49zuYYfEnKrIIP2G7A38wio0
         sonwMdiFpzw01Mgy1tzAjh/jBsAxD0y+hsQlT4TB0qPWo0DNFnJ3kWy17/RC3g0qqLt6
         /J0jDbnOsQygtP3EUu8k1OvFz8S5BOmp/wyzfY31EyYVae2dHbxAu6+VCZHu/QhkahIo
         OKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697542225; x=1698147025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqLooJ+nsKNiK4Nzm1hO6m4l3UAoDdmX4FSjXB0x9nc=;
        b=SeGCzoyis93DdR8Hs9AzejGOn0VxuULrAC/bd8yAWhoEqLDi1Vo+1OiPfPx2QUvDry
         g8HpzwuCn2Wl9/bZ8Jit6D5cJN43zyLvaX0BePCTNYGKGGsD7gvfzA7ZqcR/f1gcegty
         qgnPYvYlEpWU7XDTP/mR4mFDjqgbrsNW4MEc+PmdEd9/tlAfpXKcdjhVN7zOFintWwst
         MfFvN9dbt+e+d/zp9eoSRvOKbTILsNVmHXnsEjmzpeatJvCvnTVJoRnwFZBYuGoatQm7
         wHZxl16lfsQG0I/8r+zVLdvODacghcD24GR+hl1Q4DZj92wBGx0VvaUEjtnDK3F9cT+I
         rVig==
X-Gm-Message-State: AOJu0Yy2UDLfJm4UyRkrPpAmv1F3q6VjQg8U9ojep+MOcuwV8q56pzaa
	EPhrwZpNfpsT7sowiSkAt+zgvYL3aqxeJM4+
X-Google-Smtp-Source: AGHT+IEzerGF5P4sPmYDiIRJW4SBBX96hiAzzMXUeMHQARt6iRc9ixNxoXozNzlOFekX6LFgdEYGeA==
X-Received: by 2002:a17:90b:38cf:b0:27c:f88f:11a5 with SMTP id nn15-20020a17090b38cf00b0027cf88f11a5mr1987963pjb.2.1697542224857;
        Tue, 17 Oct 2023 04:30:24 -0700 (PDT)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r16-20020a17090ad41000b002635db431a0sm1116277pju.45.2023.10.17.04.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 04:30:24 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	wedsonaf@gmail.com,
	benno.lossin@proton.me,
	greg@kroah.com,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH net-next v5 3/5] WIP rust: add second `bindgen` pass for enum exhaustiveness checking
Date: Tue, 17 Oct 2023 20:30:12 +0900
Message-Id: <20231017113014.3492773-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 87958e864be0..4a1c7a48dfad 100644
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
+        --crate-name enum_check $(obj)/bindings/bindings_enum_check.rs
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


