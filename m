Return-Path: <netdev+bounces-250112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52316D24251
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AEC6B3018693
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98D5378D92;
	Thu, 15 Jan 2026 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGuap/zh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3663246FD
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476213; cv=none; b=dpPK4DEaqORo5FyZnZqiLw6HDITXHoEQVDeVpqUiXCSXeKOsPTEgKhOIKjUJDk0i9OLlyCvw+PgUR4NXzvmo4rZj7tR4rzV1J6DrvRGr1009ODp7tOCKuPtkgXhzlESwLv37vMo3OwYMI14psnMwJD6AlEUlH2CUS3Zvl/prmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476213; c=relaxed/simple;
	bh=JKCHfq/RfD0Iu7xpNMldqPQCwqMrsRWsliZhXQHUBMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBR1rxsxluYeDiAj/wtDD48UuXlG7msExhvleQ+mXRQRsVtERgn7TFYo3NDFNKYI6aGOKy3pJzAzFxJ9VrRy33bYr61NW9t37bfKhXIv+gI0Iu/hS1F4R0mhoPXouGpdTRRYfygKufNEch2V3eGxTdQ5y+iLG1K9wDNnGiTunm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGuap/zh; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0833b5aeeso7805185ad.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476211; x=1769081011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zknBPP+RIEO6/XhrUklVV0uXdmqx/DuLBRgSks+XejI=;
        b=NGuap/zhPJYPOM0DxyNmT9ytXECN1+mwQl+XCix3NTk7sgtEQhhWwhg8AR7uSZa2EF
         ayebdT2ZwVq4tRjJHh4ULijzrutB1Gwf+1M6EO4QNIXesB9YWY482dnIAhzMw+pSbfqn
         CyWQ7GPcKbWH1WAzghr+Q74286UppqPGuE9mDBDHFt6e/D4JLfjo3btj5NRGHrhv30pt
         UyI3e1gl4ugA1/ou2lCbdKstYSb8vA42Wg3bXCnlJ2KXLq1PIA2dXI0qDigXAZXrxw2Z
         UoVHTO45C3dncHlb0FIaWZBztVl/HrqmQ25TeJfQNq9dOnjbh3wUb/no7lt7XPJ/PvJa
         Ldtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476211; x=1769081011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zknBPP+RIEO6/XhrUklVV0uXdmqx/DuLBRgSks+XejI=;
        b=ldYMutTYowLDUIDKljCVWN60SnBK+NRFJxUw/lCcZGicM6zg3tXA2XaInTskPhkNu+
         OVchZswPZK/T7szlclhAx6CNSiqIOYaGU7vPdK0q31SY0AldlOmUOta+e4ArpdWKpOY5
         P9YXuUDzbpXquH2p+Vw3hzUhTdkMfZEXc4UgSiYHO2VFrwjJCqNV/kRdytEB6dJiyGWM
         twe81DTQLYj9KAnOpMbJZYwhxSKbqq5aa2TtnKbswAWkaHDKDN6c0N23PvEGJaFCgDCf
         VrY9S+j9qaJ5hui9UuStNSdEakn1q1UwiO6unUnk//cp9f6qY5I6vA4rwOtA3qvTXtAY
         EVfg==
X-Forwarded-Encrypted: i=1; AJvYcCU37UP0bWW5i3e6tn9bv3R5cZDYi0gRTg1naaca6L4FDyu2Z+yJr+MiynY+Xll8fLhvH8SKrPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcIn/nRwYeFKHlQn6u17KE6SKoEpxMXMq4X1eOZePNa5dvmzM7
	caYvA0PI/NIF4Mf9NuswKMQhUmExAs2m+B2BaCtRTnPnzFr9AgyFuBX7
X-Gm-Gg: AY/fxX5QIfT9xq4y6vfavJ1OP4PZABVDg8kkDyuxXRA27LJoRANe/0iRyV3U+9PI9yo
	Ju07IwJwk/xBjH6U/oe7O/lGvVLF7JE98CPyBF48bIBun8GOv6QQTLEZAm4CeEEBLGAccYyymlZ
	FFupVAdL0x4urXsKPna0kJgTEJZfBh/kg8uDB332e2PGfZIsA5RxynYD4xZRw/lXUd0T5T8IxAa
	jk/NCjjK23zcSfaGxPe17Tpaq9S23rUf4vhViDIPbeIyAbMCpjf/U/9/GedC1YL+eLhyg2l4FiW
	PdxKyAwt0SfKBeuGY7Xy6ZJWg4jaFNX4//17TZbxGmrMxXsl1puTOu8y0cvBIp/Zw9ocT+NjgOG
	Sda7U5AK2NcIT35fWQvFdIPtcUmPV8J9PnS+66YFG8Uve6+6gTE6mCRnnueMb8+M91oMjG+wZYN
	DomvVfOaQ3ZbyHtm/cFw==
X-Received: by 2002:a17:903:f86:b0:2a0:de4f:cad with SMTP id d9443c01a7336-2a599e719e7mr53720365ad.60.1768476211241;
        Thu, 15 Jan 2026 03:23:31 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:23:30 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v10 03/12] bpf: change prototype of bpf_session_{cookie,is_return}
Date: Thu, 15 Jan 2026 19:22:37 +0800
Message-ID: <20260115112246.221082-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the function argument of "void *ctx" to bpf_session_cookie() and
bpf_session_is_return(), which is a preparation of the next patch.

The two kfunc is seldom used now, so it will not introduce much effect
to change their function prototype.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
v10:
- drop the declaration of bpf_session_is_return() and bpf_session_cookie()
---
 kernel/bpf/verifier.c                             |  6 +++++-
 kernel/trace/bpf_trace.c                          |  4 ++--
 tools/testing/selftests/bpf/bpf_kfuncs.h          |  3 ---
 .../bpf/progs/kprobe_multi_session_cookie.c       | 15 +++++++--------
 .../selftests/bpf/progs/uprobe_multi_session.c    |  7 +++----
 .../bpf/progs/uprobe_multi_session_cookie.c       | 15 +++++++--------
 .../bpf/progs/uprobe_multi_session_recursive.c    | 11 +++++------
 7 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f7eec19df803..1ed41ba8b54c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12370,6 +12370,7 @@ enum special_kfunc_type {
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_arena_reserve_pages,
+	KF_bpf_session_is_return,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12447,6 +12448,7 @@ BTF_ID(func, bpf_task_work_schedule_resume_impl)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
+BTF_ID(func, bpf_session_is_return)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12501,7 +12503,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_session_cookie])
 		return KF_ARG_PTR_TO_CTX;
 
 	if (argno + 1 < nargs &&
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5f621f0403f8..297dcafb2c55 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3316,7 +3316,7 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 
 __bpf_kfunc_start_defs();
 
-__bpf_kfunc bool bpf_session_is_return(void)
+__bpf_kfunc bool bpf_session_is_return(void *ctx)
 {
 	struct bpf_session_run_ctx *session_ctx;
 
@@ -3324,7 +3324,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
 	return session_ctx->is_return;
 }
 
-__bpf_kfunc __u64 *bpf_session_cookie(void)
+__bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
 {
 	struct bpf_session_run_ctx *session_ctx;
 
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index e0189254bb6e..7dad01439391 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -79,9 +79,6 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
 
-extern bool bpf_session_is_return(void) __ksym __weak;
-extern __u64 *bpf_session_cookie(void) __ksym __weak;
-
 struct dentry;
 /* Description
  *  Returns xattr of a dentry
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
index 0835b5edf685..ad627016e3e5 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
-#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -23,16 +22,16 @@ int BPF_PROG(trigger)
 	return 0;
 }
 
-static int check_cookie(__u64 val, __u64 *result)
+static int check_cookie(struct pt_regs *ctx, __u64 val, __u64 *result)
 {
 	__u64 *cookie;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
 
-	cookie = bpf_session_cookie();
+	cookie = bpf_session_cookie(ctx);
 
-	if (bpf_session_is_return())
+	if (bpf_session_is_return(ctx))
 		*result = *cookie == val ? val : 0;
 	else
 		*cookie = val;
@@ -42,17 +41,17 @@ static int check_cookie(__u64 val, __u64 *result)
 SEC("kprobe.session/bpf_fentry_test1")
 int test_kprobe_1(struct pt_regs *ctx)
 {
-	return check_cookie(1, &test_kprobe_1_result);
+	return check_cookie(ctx, 1, &test_kprobe_1_result);
 }
 
 SEC("kprobe.session/bpf_fentry_test1")
 int test_kprobe_2(struct pt_regs *ctx)
 {
-	return check_cookie(2, &test_kprobe_2_result);
+	return check_cookie(ctx, 2, &test_kprobe_2_result);
 }
 
 SEC("kprobe.session/bpf_fentry_test1")
 int test_kprobe_3(struct pt_regs *ctx)
 {
-	return check_cookie(3, &test_kprobe_3_result);
+	return check_cookie(ctx, 3, &test_kprobe_3_result);
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
index 30bff90b68dc..6e46bb00ff58 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
-#include "bpf_kfuncs.h"
 #include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
@@ -51,7 +50,7 @@ static int uprobe_multi_check(void *ctx, bool is_return)
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_*")
 int uprobe(struct pt_regs *ctx)
 {
-	return uprobe_multi_check(ctx, bpf_session_is_return());
+	return uprobe_multi_check(ctx, bpf_session_is_return(ctx));
 }
 
 static __always_inline bool verify_sleepable_user_copy(void)
@@ -67,5 +66,5 @@ int uprobe_sleepable(struct pt_regs *ctx)
 {
 	if (verify_sleepable_user_copy())
 		uprobe_multi_sleep_result++;
-	return uprobe_multi_check(ctx, bpf_session_is_return());
+	return uprobe_multi_check(ctx, bpf_session_is_return(ctx));
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
index 5befdf944dc6..b5db196614a9 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
-#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -13,16 +12,16 @@ __u64 test_uprobe_1_result = 0;
 __u64 test_uprobe_2_result = 0;
 __u64 test_uprobe_3_result = 0;
 
-static int check_cookie(__u64 val, __u64 *result)
+static int check_cookie(struct pt_regs *ctx, __u64 val, __u64 *result)
 {
 	__u64 *cookie;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
 
-	cookie = bpf_session_cookie();
+	cookie = bpf_session_cookie(ctx);
 
-	if (bpf_session_is_return())
+	if (bpf_session_is_return(ctx))
 		*result = *cookie == val ? val : 0;
 	else
 		*cookie = val;
@@ -32,17 +31,17 @@ static int check_cookie(__u64 val, __u64 *result)
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
 int uprobe_1(struct pt_regs *ctx)
 {
-	return check_cookie(1, &test_uprobe_1_result);
+	return check_cookie(ctx, 1, &test_uprobe_1_result);
 }
 
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_2")
 int uprobe_2(struct pt_regs *ctx)
 {
-	return check_cookie(2, &test_uprobe_2_result);
+	return check_cookie(ctx, 2, &test_uprobe_2_result);
 }
 
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_3")
 int uprobe_3(struct pt_regs *ctx)
 {
-	return check_cookie(3, &test_uprobe_3_result);
+	return check_cookie(ctx, 3, &test_uprobe_3_result);
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
index 8fbcd69fae22..3ce309248a04 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
-#include "bpf_kfuncs.h"
 #include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
@@ -16,11 +15,11 @@ int idx_return = 0;
 __u64 test_uprobe_cookie_entry[6];
 __u64 test_uprobe_cookie_return[3];
 
-static int check_cookie(void)
+static int check_cookie(struct pt_regs *ctx)
 {
-	__u64 *cookie = bpf_session_cookie();
+	__u64 *cookie = bpf_session_cookie(ctx);
 
-	if (bpf_session_is_return()) {
+	if (bpf_session_is_return(ctx)) {
 		if (idx_return >= ARRAY_SIZE(test_uprobe_cookie_return))
 			return 1;
 		test_uprobe_cookie_return[idx_return++] = *cookie;
@@ -40,5 +39,5 @@ int uprobe_recursive(struct pt_regs *ctx)
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
 
-	return check_cookie();
+	return check_cookie(ctx);
 }
-- 
2.52.0


