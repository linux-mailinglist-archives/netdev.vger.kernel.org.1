Return-Path: <netdev+bounces-230220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C1BBE56CC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 503EC4EA5E5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096C22E2DD4;
	Thu, 16 Oct 2025 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPZVpy5b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532E2E2DFC
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647510; cv=none; b=EeebjQxuvuOzk2Vbj2fCag2RiriUblEykuLztmDk9Fxh6IgNP0+CSQKFn7GBTMr3DvXsK52EMUY+CDAan3+MdInNbsZPnna+gFbw/TyjUF1Du9+8EPXYknhFWkLsIRKam5FTNcQCt6UCjJXQYf68qYHum7/RigR+9242nUWRYPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647510; c=relaxed/simple;
	bh=ebSyqUmTaqlQFe917l76DH1LGlZkQnKy2RzeOT+rBzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tn2/CJPsSH80Jy2P9gNP+FhHDrS/e09QppN21gtFFGzbdJfJ0sBikho0WyJage/sEwG2U68C42fkIo14X/Gs9FXs61fxoXKOddGXJBaAHO4cijZoaPx2babv2NuWLXPlu8bxnT3OqWyTQwEsPWH5YAOb5UI3o7Ve54qQaxUcHt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPZVpy5b; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b609a32a9b6so696481a12.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 13:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647508; x=1761252308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goMYlunssrkEJPcWMdE5dc68waHUsAIz5euIIkqUs4M=;
        b=NPZVpy5b7nscoczqAAFZxAvRBXRdOI3TqnNJWA5niwS2Twrac6iAGK5Cj3qEHY131e
         Gx3CZgneOTDZ+C+iZLKNQjSXjFb8Ydwo5Xrsj8NCO3xbcF5bEqztBRnGuoPcAeW5wIR5
         iy20E6N1FkyY6+UfXsi4vIJXO5Gz9aSZpUD68F/IXMQjnr6jIlqWmqTflkMUu1fLeW9M
         Soh4Am4dOZkxPNHtkWyDyruD4hOjO4phpiYMYWX0jVt4d7Sj0Ii0TO31dijzs+gvualt
         oOUWsOAbARkcr8I1RPprWYOMKbnZxSEPTkkwSPWdXbOav+7LCnftO9dbp0t8BR50M6EU
         ETIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647508; x=1761252308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goMYlunssrkEJPcWMdE5dc68waHUsAIz5euIIkqUs4M=;
        b=Ki+wNi3hNWLqMHfZqY0XcuVm5hL/A0ja/K2vQAuhGkL95LF0s+FRVuKrGVLcwqDCVd
         I+tSUwpiUCf1d2Zi0CZxMOEG6cPw7iDR+DVnWVJyV20QR7IKgGb4n9O0+XYQXGf+usWo
         VxVK7+Smp5R6xNib/iBxrlj4Hi34VJXML3iIJ/SMe0hrpIHfBxllKLNiEm5+k4rzDq19
         IoWw9P1jgQQxOhPb7t3DPo0E7nVKZVZu2oy6/w7edm0vVGshnTshqMfRa8MfjjKcQOGb
         1njo1QIlJqXasVU3NqGVNhOLQ/oQISU6hiV8ccA71aywBT7p2gBbKgTDRdfB/L3wlvC+
         B2yQ==
X-Gm-Message-State: AOJu0YwK9bnsFt5Nqa0WolIPoedIEuf7mtLUhDuB36KygQm7tnwt88Ct
	2eLLKXCCOSYkg4PD9bd8wQwF5Hwv2a24EePB6wqkd36kU1Se8yh1iMmM
X-Gm-Gg: ASbGncsUsC/4qKb7EaHH7l7RjAbQNiudH8SZp6DvrXZ7cWteo3aOxB3UfF1me6qrdsD
	O5XddJW9cKQ2CW8hjbcz8UQnJeBcBR3LZlxPRJrZP1j4gbjHi66yDCbg4K8P1rP/+AF8giUBEic
	un+eP0qdsRkM0Ce6i6kfd5Wy251C62/JR9pY3HATexP5wpmALR/mf5JccolkESZUt+pUG48NG5H
	O7l0q76EDmYhxBeblx4S4cilhnn7FKIVOjp0e4qTum4cqjV5PI2nWSIFJ+F4ryYmw3NqVlGAK0c
	zyg+RTmszFWGrYJUp0hfJUBWtVzZ8OMIooj6dErL3HtJZH9q/Ty9Yu3Kqal8NSWw6y8eeq3j7Rv
	LWRRB+KK8KOvdKP0rlF4ujnDv8D8paU2Uh6+0EJwu6TZptVJD+HKUwgmMMYWcSLirDTfQWi5Ihg
	2O
X-Google-Smtp-Source: AGHT+IGM0XRH/VqCusm73ZFwx/TQb0R29IEV/jb74wbcha+qzTOzVeVHJU2rHMtm/5pdWbvpVgnacw==
X-Received: by 2002:a17:903:8c6:b0:26d:353c:75cd with SMTP id d9443c01a7336-290c9cc30b8mr14826075ad.21.1760647507878;
        Thu, 16 Oct 2025 13:45:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7ddb6sm40284015ad.73.2025.10.16.13.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:45:07 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 4/4] selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS command
Date: Thu, 16 Oct 2025 13:45:03 -0700
Message-ID: <20251016204503.3203690-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016204503.3203690-1-ameryhung@gmail.com>
References: <20251016204503.3203690-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test BPF_PROG_ASSOC_STRUCT_OPS command that associates a BPF program
with a struct_ops. The test follows the same logic in commit
ba7000f1c360 ("selftests/bpf: Test multi_st_ops and calling kfuncs from
different programs"), but instead of using map id to identify a specific
struct_ops, this test uses the new BPF command to associate a struct_ops
with a program.

The test consists of two sets of almost identical struct_ops maps and BPF
programs associated with the map. Their only difference is the unique
value returned by bpf_testmod_multi_st_ops::test_1().

The test first loads the programs and associates them with struct_ops
maps. Then, it exercises the BPF programs. They will in turn call kfunc
bpf_kfunc_multi_st_ops_test_1_prog_arg() to trigger test_1() of the
associated struct_ops map, and then check if the right unique value is
returned.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_assoc.c    |  76 +++++++++++++
 .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  17 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
 4 files changed, 199 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
new file mode 100644
index 000000000000..cf8b104cbfb7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "struct_ops_assoc.skel.h"
+
+static void test_st_ops_assoc(void)
+{
+	int sys_enter_prog_a_fd, sys_enter_prog_b_fd;
+	int syscall_prog_a_fd, syscall_prog_b_fd;
+	struct struct_ops_assoc *skel = NULL;
+	int err, pid, map_a_fd, map_b_fd;
+
+	skel = struct_ops_assoc__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_assoc__open"))
+		goto out;
+
+	sys_enter_prog_a_fd = bpf_program__fd(skel->progs.sys_enter_prog_a);
+	sys_enter_prog_b_fd = bpf_program__fd(skel->progs.sys_enter_prog_b);
+	syscall_prog_a_fd = bpf_program__fd(skel->progs.syscall_prog_a);
+	syscall_prog_b_fd = bpf_program__fd(skel->progs.syscall_prog_b);
+	map_a_fd = bpf_map__fd(skel->maps.st_ops_map_a);
+	map_b_fd = bpf_map__fd(skel->maps.st_ops_map_b);
+
+	err = bpf_prog_assoc_struct_ops(map_a_fd, syscall_prog_a_fd, NULL);
+	if (!ASSERT_OK(err, "bpf_prog_assoc_struct_ops"))
+		goto out;
+
+	err = bpf_prog_assoc_struct_ops(map_a_fd, sys_enter_prog_a_fd, NULL);
+	if (!ASSERT_OK(err, "bpf_prog_assoc_struct_ops"))
+		goto out;
+
+	err = bpf_prog_assoc_struct_ops(map_b_fd, syscall_prog_b_fd, NULL);
+	if (!ASSERT_OK(err, "bpf_prog_assoc_struct_ops"))
+		goto out;
+
+	err = bpf_prog_assoc_struct_ops(map_b_fd, sys_enter_prog_b_fd, NULL);
+	if (!ASSERT_OK(err, "bpf_prog_assoc_struct_ops"))
+		goto out;
+
+	/* sys_enter_prog_a already associated with map_a */
+	err = bpf_prog_assoc_struct_ops(map_b_fd, sys_enter_prog_a_fd, NULL);
+	if (!ASSERT_ERR(err, "bpf_prog_assoc_struct_ops"))
+		goto out;
+
+	err = struct_ops_assoc__attach(skel);
+	if (!ASSERT_OK(err, "struct_ops_assoc__attach"))
+		goto out;
+
+	/* run tracing prog that calls .test_1 and checks return */
+	pid = getpid();
+	skel->bss->test_pid = pid;
+	sys_gettid();
+	skel->bss->test_pid = 0;
+
+	ASSERT_EQ(skel->bss->test_err_a, 0, "skel->bss->test_err_a");
+	ASSERT_EQ(skel->bss->test_err_b, 0, "skel->bss->test_err_b");
+
+	/* run syscall_prog that calls .test_1 and checks return */
+	err = bpf_prog_test_run_opts(syscall_prog_a_fd, NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	err = bpf_prog_test_run_opts(syscall_prog_b_fd, NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	ASSERT_EQ(skel->bss->test_err_a, 0, "skel->bss->test_err");
+	ASSERT_EQ(skel->bss->test_err_b, 0, "skel->bss->test_err");
+
+out:
+	struct_ops_assoc__destroy(skel);
+}
+
+void test_struct_ops_assoc(void)
+{
+	if (test__start_subtest("st_ops_assoc"))
+		test_st_ops_assoc();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
new file mode 100644
index 000000000000..fe47287a49f0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int test_pid;
+
+/* Programs associated with st_ops_map_a */
+
+#define MAP_A_MAGIC 1234
+int test_err_a;
+
+SEC("struct_ops")
+int BPF_PROG(test_1_a, struct st_ops_args *args)
+{
+	return MAP_A_MAGIC;
+}
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(sys_enter_prog_a, struct pt_regs *regs, long id)
+{
+	struct st_ops_args args = {};
+	struct task_struct *task;
+	int ret;
+
+	task = bpf_get_current_task_btf();
+	if (!test_pid || task->pid != test_pid)
+		return 0;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
+	if (ret != MAP_A_MAGIC)
+		test_err_a++;
+
+	return 0;
+}
+
+SEC("syscall")
+int syscall_prog_a(void *ctx)
+{
+	struct st_ops_args args = {};
+	int ret;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
+	if (ret != MAP_A_MAGIC)
+		test_err_a++;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_multi_st_ops st_ops_map_a = {
+	.test_1 = (void *)test_1_a,
+};
+
+/* Programs associated with st_ops_map_b */
+
+#define MAP_B_MAGIC 5678
+int test_err_b;
+
+SEC("struct_ops")
+int BPF_PROG(test_1_b, struct st_ops_args *args)
+{
+	return MAP_B_MAGIC;
+}
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(sys_enter_prog_b, struct pt_regs *regs, long id)
+{
+	struct st_ops_args args = {};
+	struct task_struct *task;
+	int ret;
+
+	task = bpf_get_current_task_btf();
+	if (!test_pid || task->pid != test_pid)
+		return 0;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
+	if (ret != MAP_B_MAGIC)
+		test_err_b++;
+
+	return 0;
+}
+
+SEC("syscall")
+int syscall_prog_b(void *ctx)
+{
+	struct st_ops_args args = {};
+	int ret;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
+	if (ret != MAP_B_MAGIC)
+		test_err_b++;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_multi_st_ops st_ops_map_b = {
+	.test_1 = (void *)test_1_b,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 6df6475f5dbc..d3c3a8f1e63b 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1101,6 +1101,7 @@ __bpf_kfunc int bpf_kfunc_st_ops_inc10(struct st_ops_args *args)
 }
 
 __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id);
+__bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, void *aux_prog);
 
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
@@ -1143,6 +1144,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABL
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_prog_arg, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -1604,6 +1606,7 @@ static struct bpf_testmod_multi_st_ops *multi_st_ops_find_nolock(u32 id)
 	return NULL;
 }
 
+/* Call test_1() of the struct_ops map identified by the id */
 int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id)
 {
 	struct bpf_testmod_multi_st_ops *st_ops;
@@ -1619,6 +1622,20 @@ int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id)
 	return ret;
 }
 
+/* Call test_1() of the associated struct_ops map */
+int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, void *aux__prog)
+{
+	struct bpf_prog_aux *prog_aux = (struct bpf_prog_aux *)aux__prog;
+	struct bpf_testmod_multi_st_ops *st_ops;
+	int ret = -1;
+
+	st_ops = (struct bpf_testmod_multi_st_ops *)bpf_prog_get_assoc_struct_ops(prog_aux);
+	if (st_ops)
+		ret = st_ops->test_1(args);
+
+	return ret;
+}
+
 static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_multi_st_ops *st_ops =
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 4df6fa6a92cb..d40f4cddbd1e 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -162,5 +162,6 @@ struct task_struct *bpf_kfunc_ret_rcu_test(void) __ksym;
 int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
 
 int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __ksym;
+int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, void *aux__prog) __ksym;
 
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.47.3


