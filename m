Return-Path: <netdev+bounces-228560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A04BCE27C
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 19:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1BA19A3333
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 17:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3E62FC00D;
	Fri, 10 Oct 2025 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVVuIlv2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9D2229B2A
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118601; cv=none; b=tgNVwACTnQ2t8f4IQNmMapm6TzwZJHdScWdF5RJdLcsjLWhXAqb3wlMlToa4cg3L0sjM/fAlLD7oH+FDu2QiUjGZ6m7r4BW0CpRShfEVFo8xX0fk0qNo3wqSRupVQoMSYNbKBUZe/yU527jPAmVvkxnHje8Tx/xoueRthoizRwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118601; c=relaxed/simple;
	bh=mWaDCZFbCMh1qhUpVI4DwUMVYmkW8sW1xN3IEexkaoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q51EziFeG8XD3iOwZ/G3KJI7RaJ3/wtD3puwT8wY8vXZGQyckyGZsa1olHCXWxq+SeOFAq+aL4uRDp+WOT2IS9BECusEOXi7A76gtKbvdgF7r4c0qyVpXmyj7JaaNWwRfnpOBBA18ZhmEr4dQtXEDduSKEd+Z3aDoEcj2j0QqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVVuIlv2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so3315533a91.3
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760118598; x=1760723398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pC1XqHtSZtfoF25deLc+WDahXm1aPtXUF5kJ4vM8Q3Y=;
        b=IVVuIlv2sNb9S4qth/ehmL/DgYfkUunyv3pFx7nVQiJfN98Ls5JvO5q84Wqzh1h3a4
         7nEl7v70SaRcVbBVfX18cJEkRZF4jfmLHNxwg13RTjstgOsRCnAZH9nDktohLhUZFc7H
         PAbEwTjBru4BEQRb16GMZI5wmta14MGFO9bcJYfb1i+/v4lm2i89Xvu/5I9IvKRSQSsS
         4yycgsS9/zzVeQFmAKnzWobymQf4Wcut0RcM0wRltYM2AXA96mLAgAFEueukDEad2qmZ
         Ezx4SRuUBysQiV/DjEcbnehpxlRBM4DK4ZDXgzhmwx0gmsap8eZJ8Ml0j1lXxjdCKEGh
         c/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118598; x=1760723398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pC1XqHtSZtfoF25deLc+WDahXm1aPtXUF5kJ4vM8Q3Y=;
        b=IjzZQncGYXRMPMPT5O0bEQ7T1EDj0jE4aIfKVbtlb7Y1yn1oqgVNhzLb0I49DkXbCd
         Te8WUQJ+/5r8LH2Bo4A8u0bYwvKfHDNkpeGxZa/Z4SSWhjhIVEs3QJal8C4WC92mltix
         LXSpse8sF9LtP37PzASJACZ88J8oYJDPAMm6c7VQuAc31un4jhWMQe8u2jTYF0v5AiJV
         l6jcOGckCZjDIcIwnvxhpv5eC2IpwjGVQTsr2SQtdKvce1HXJT4s4fJv59xKfO6fj4GH
         7h1jqZ4jYosIOPfPWT88vlZkq0uhQDwcvXizwt4yXOkT2hKB0SeAdGU7rneqjyWuYfdI
         cDQQ==
X-Gm-Message-State: AOJu0Yw41XfHH4u1lZTyt5c4KzosOfdp016RDg3duJQVRmKvxUfp4oNI
	UlyIPnukkSYU6pdnsNKGzSqofkmNSjJ0YNL+XvxzPkC0iB6KKYYvE9Xo
X-Gm-Gg: ASbGncu2Thxyyrm0UOzVtqJyERmHVw+mv5uzjbR2VYJOsPXMSUKaHwffn7kr6us3FI9
	baDTp+xgn1n6xqyI7ZQsLYaWxsnuTuPgOI+/Ru9ZJM5n4ovDdCCKWx0rx2eCwHHGv9oSA74KgvD
	Z2oEpuwuYpLdnM/l3hhuYkkK2OWBPHGqrN3rS7LDgnYG5dHMyib7djo7j7KH7VcVezjx3w9y5Aw
	RnY3aWuCQn19YyepfXADsTDem3InCCEA4tSbTjehvaS+nlQr4hF4YW5HdxWOPj/7Z1NAkPY69Rr
	rvGUbJEZ0O2URMjfWUnBG5zjKJXVuvdGenAtKbRNp4te8dZgGZbX8U1L2jrBtQfxcCYPnRvtWtK
	gIsljnkAoHy75TMQzlkhkLIlYbJom1XkeFZPk5kgXJ+o=
X-Google-Smtp-Source: AGHT+IEMyFr4jLrYUYvjUv/utedylVFl1b8DeTwxRNtDA8/G24WXxhzAKFUpC4ugMu8eWWU6+SltSw==
X-Received: by 2002:a17:903:1b4c:b0:27e:e1f3:f853 with SMTP id d9443c01a7336-29027356951mr140927965ad.8.1760118598324;
        Fri, 10 Oct 2025 10:49:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034dea554sm63153515ad.2.2025.10.10.10.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:49:58 -0700 (PDT)
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
Subject: [RFC PATCH v1 bpf-next 4/4] selftests/bpf: Test BPF_STRUCT_OPS_ASSOCIATE_PROG command
Date: Fri, 10 Oct 2025 10:49:53 -0700
Message-ID: <20251010174953.2884682-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010174953.2884682-1-ameryhung@gmail.com>
References: <20251010174953.2884682-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test BPF_STRUCT_OPS_ASSOCIATE_PROG command that associates a BPF program
with a struct_ops. The test follows the same logic in commit
ba7000f1c360 ("selftests/bpf: Test multi_st_ops and calling kfuncs from
different programs"), but instead of using map id to identify a specific
struct_ops this test uses the new BPF command to associate a struct_ops
with a program.

The test consists of two set of almost identical struct_ops maps and BPF
programs associated with the map. Their only difference is a unique value
returned by bpf_testmod_multi_st_ops::test_1().

The test first loads the programs and associates them with struct_ops
maps. Then, the test exercises the BPF programs. They will in turn call
kfunc bpf_kfunc_multi_st_ops_test_1_prog_arg() to trigger test_1()
of the associated struct_ops map, and then check if the right unique
value is returned.

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
index 000000000000..da8fab0fe5cf
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
+	err = bpf_struct_ops_associate_prog(map_a_fd, syscall_prog_a_fd, NULL);
+	if (!ASSERT_OK(err, "bpf_struct_ops_associate_prog"))
+		goto out;
+
+	err = bpf_struct_ops_associate_prog(map_a_fd, sys_enter_prog_a_fd, NULL);
+	if (!ASSERT_OK(err, "bpf_struct_ops_associate_prog"))
+		goto out;
+
+	err = bpf_struct_ops_associate_prog(map_b_fd, syscall_prog_b_fd, NULL);
+	if (!ASSERT_OK(err, "bpf_struct_ops_associate_prog"))
+		goto out;
+
+	err = bpf_struct_ops_associate_prog(map_b_fd, sys_enter_prog_b_fd, NULL);
+	if (!ASSERT_OK(err, "bpf_struct_ops_associate_prog"))
+		goto out;
+
+	/* sys_enter_prog_a already associated with map_a */
+	err = bpf_struct_ops_associate_prog(map_b_fd, sys_enter_prog_a_fd, NULL);
+	if (!ASSERT_ERR(err, "bpf_struct_ops_associate_prog"))
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
index 6df6475f5dbc..2e83a041cbe0 100644
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
+	st_ops = (struct bpf_testmod_multi_st_ops *)prog_aux->st_ops_assoc;
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


