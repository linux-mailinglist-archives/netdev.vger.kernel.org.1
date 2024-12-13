Return-Path: <netdev+bounces-151916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2989F19FB
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 00:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21CA188DEEB
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 23:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E731F2C40;
	Fri, 13 Dec 2024 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AxpNow8P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA21F12F7
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132609; cv=none; b=D45zbZ5mmRnC981sm6v9xJBmmCi6N/exvsHss7gSaq/5p9FT5bDK8KaQb+wU3BiQ2p2U7LOdsyLoxuFzC6g5F91x4DsQyNRVneZoPXywXWpnv2GmwnoLaeQihZ1fHNN5tmlFYtZU7ptN1XfXKkRzNyqmDrzBJv1JKbLJqH08qgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132609; c=relaxed/simple;
	bh=TPzsZdNWtFW8vcRGJQby6GpfACEn3oIIRbLydlxNfio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCBgO3JWEUatkVQgrFHTw7v9U/tEyD4dz/3hYAeQ3Kosuxd0DwzA38swmccuKUVggKmqYGtkml4XRVDswbYdQoOcNcsX0jV4WlM4FctUCv7QryciP0ZYMC6+CKINWtifcRzGCVK8XU/gesYRJOGY8grQ+Bj0YKz3AQwg/SsgVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AxpNow8P; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46769b34cbfso42529251cf.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132605; x=1734737405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtjTtmMT6O6w3VZS9xHihVZl/iedzM4fQQxBhi0eNmo=;
        b=AxpNow8Pi3Y0pDaGgtyZMxBZ6HvKcgrKBrXsazFA00m4KwrQmlSivz+4crR3GjyuTz
         cZivy4kv57ob35p26nhFLi4n5jayIl9jB4SQDrWyzzqv1QiJk5iUQaI5vO3H+XCHJLfN
         m1N8e0UN6anG/+3GeFhXV4louHNUYi8eiotfD4IXWNaxYdi4eRdTG34XkKo1iM8NSxTa
         G9D8bbOVV1jlI+ocf0BdgUfIuDw07wzFuvY2TsnWlG3+bb6WgShs8tjnz/hvbyYVRiue
         LNi/v7vJ8IF8WQME0L6juJNwco55HfpNBpjP+RMMVa//Cd9D89wpzPh8SAzJWPnP0kWn
         /lAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132605; x=1734737405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtjTtmMT6O6w3VZS9xHihVZl/iedzM4fQQxBhi0eNmo=;
        b=ql8x2U4t6GdqtFZJbicXb0HTcNd6hWqsv2zrJfmizbUsBLHCPOcX7BWKeocNocNgb7
         GoeWEtqnOCdN07Ac87t27/IsG5vxqxnxf2tcs72SI9tyBTF67WCRVx7zNnQkRbPsfbyT
         jLVksswX/czMUpGTfgzfLnOH39icgnhc13WqkebLY6noAozD92oiJwhG3YpPfzaxdaO2
         XICZn1vgSwvxkYr4+DnQw/dOvXVetl1RXt3NyZcj/2+S/aH90orvqvtWYu2SbQYbTo8c
         LcDz48NneZKQNcYzhBknuebl3QA5jL8NYBIoaq0Oj3cM7BrtOl8QMgenV0aj1cVB7tHP
         3sGw==
X-Gm-Message-State: AOJu0Yx0NQmbSQH6mWXMpm4YhP9l5K3enrnY0h/+ukGFC+cimKAti5KZ
	YVWs8i7poIUJzPgKnOLl2nyZoUR4IuFDvtpEacTgoYOcblreqDjlODE7EhUH70wYU2MFt0xUHYh
	ji6s4bA==
X-Gm-Gg: ASbGnctLHeZNWl04Md6pWkEtI3HQyhQS1Am/TfjmFcVEvZSqnz+jdZDuUp36wsIMP/h
	9H0dtFSr8r2VtbPe512CnVX7ZeLI2xlB9MTPCCjMXstXGZ343zDsHr84LrviAP47iYOrBtTjczy
	7x284FDsPfA8zhe+OnsJuD1MRLNR4qWfWtlyG1pFbZkEKywRymy7Og0FQ/jAlvVwSETo97YgYyV
	cmkX78TNEBuf7OwUF4jtagFOkRghS/kNwsKKpCNRpRhkj/2VYmFyQJIM5taEADmEAdOui9YKaU8
X-Google-Smtp-Source: AGHT+IEwrvI0TWA5i3ygjy9DwZWY6eVFOFX1HCnKe1n5GIxKyiEggePCTzKUB6l8+q8IUwtnOb/khQ==
X-Received: by 2002:ac8:5d14:0:b0:466:85eb:6118 with SMTP id d75a77b69052e-467a574d124mr67024061cf.16.1734132605341;
        Fri, 13 Dec 2024 15:30:05 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:04 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 04/13] selftests/bpf: Test returning referenced kptr from struct_ops programs
Date: Fri, 13 Dec 2024 23:29:49 +0000
Message-Id: <20241213232958.2388301-5-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241213232958.2388301-1-amery.hung@bytedance.com>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test struct_ops programs returning referenced kptr. When the return type
of a struct_ops operator is pointer to struct, the verifier should
only allow programs that return a scalar NULL or a non-local kptr with the
correct type in its unmodified form.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  8 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  4 +
 .../prog_tests/test_struct_ops_kptr_return.c  | 87 +++++++++++++++++++
 .../bpf/progs/struct_ops_kptr_return.c        | 29 +++++++
 ...uct_ops_kptr_return_fail__invalid_scalar.c | 24 +++++
 .../struct_ops_kptr_return_fail__local_kptr.c | 30 +++++++
 ...uct_ops_kptr_return_fail__nonzero_offset.c | 23 +++++
 .../struct_ops_kptr_return_fail__wrong_type.c | 28 ++++++
 8 files changed, 233 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 244234546ae2..cfab09f16cc2 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -1141,11 +1141,19 @@ static int bpf_testmod_ops__test_refcounted(int dummy,
 	return 0;
 }
 
+static struct task_struct *
+bpf_testmod_ops__test_return_ref_kptr(int dummy, struct task_struct *task__ref,
+				      struct cgroup *cgrp)
+{
+	return NULL;
+}
+
 static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_1 = bpf_testmod_test_1,
 	.test_2 = bpf_testmod_test_2,
 	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
 	.test_refcounted = bpf_testmod_ops__test_refcounted,
+	.test_return_ref_kptr = bpf_testmod_ops__test_return_ref_kptr,
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index 0e31586c1353..a66659314e67 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 struct task_struct;
+struct cgroup;
 
 struct bpf_testmod_test_read_ctx {
 	char *buf;
@@ -38,6 +39,9 @@ struct bpf_testmod_ops {
 	int (*unsupported_ops)(void);
 	/* Used to test ref_acquired arguments. */
 	int (*test_refcounted)(int dummy, struct task_struct *task);
+	/* Used to test returning referenced kptr. */
+	struct task_struct *(*test_return_ref_kptr)(int dummy, struct task_struct *task,
+						    struct cgroup *cgrp);
 
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
new file mode 100644
index 000000000000..bc2fac39215a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
@@ -0,0 +1,87 @@
+#include <test_progs.h>
+
+#include "struct_ops_kptr_return.skel.h"
+#include "struct_ops_kptr_return_fail__wrong_type.skel.h"
+#include "struct_ops_kptr_return_fail__invalid_scalar.skel.h"
+#include "struct_ops_kptr_return_fail__nonzero_offset.skel.h"
+#include "struct_ops_kptr_return_fail__local_kptr.skel.h"
+
+/* Test that the verifier accepts a program that acquires a referenced
+ * kptr and releases the reference through return
+ */
+static void kptr_return(void)
+{
+	struct struct_ops_kptr_return *skel;
+
+	skel = struct_ops_kptr_return__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_and_load"))
+		return;
+
+	struct_ops_kptr_return__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that returns a kptr of the
+ * wrong type
+ */
+static void kptr_return_fail__wrong_type(void)
+{
+	struct struct_ops_kptr_return_fail__wrong_type *skel;
+
+	skel = struct_ops_kptr_return_fail__wrong_type__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__wrong_type__open_and_load"))
+		return;
+
+	struct_ops_kptr_return_fail__wrong_type__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that returns a non-null scalar */
+static void kptr_return_fail__invalid_scalar(void)
+{
+	struct struct_ops_kptr_return_fail__invalid_scalar *skel;
+
+	skel = struct_ops_kptr_return_fail__invalid_scalar__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__invalid_scalar__open_and_load"))
+		return;
+
+	struct_ops_kptr_return_fail__invalid_scalar__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that returns kptr with non-zero offset */
+static void kptr_return_fail__nonzero_offset(void)
+{
+	struct struct_ops_kptr_return_fail__nonzero_offset *skel;
+
+	skel = struct_ops_kptr_return_fail__nonzero_offset__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__nonzero_offset__open_and_load"))
+		return;
+
+	struct_ops_kptr_return_fail__nonzero_offset__destroy(skel);
+}
+
+/* Test that the verifier rejects a program that returns local kptr */
+static void kptr_return_fail__local_kptr(void)
+{
+	struct struct_ops_kptr_return_fail__local_kptr *skel;
+
+	skel = struct_ops_kptr_return_fail__local_kptr__open_and_load();
+	if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__local_kptr__open_and_load"))
+		return;
+
+	struct_ops_kptr_return_fail__local_kptr__destroy(skel);
+}
+
+void test_struct_ops_kptr_return(void)
+{
+	if (test__start_subtest("kptr_return"))
+		kptr_return();
+	if (test__start_subtest("kptr_return_fail__wrong_type"))
+		kptr_return_fail__wrong_type();
+	if (test__start_subtest("kptr_return_fail__invalid_scalar"))
+		kptr_return_fail__invalid_scalar();
+	if (test__start_subtest("kptr_return_fail__nonzero_offset"))
+		kptr_return_fail__nonzero_offset();
+	if (test__start_subtest("kptr_return_fail__local_kptr"))
+		kptr_return_fail__local_kptr();
+}
+
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
new file mode 100644
index 000000000000..29b7719cd4c9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
@@ -0,0 +1,29 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * allow a referenced kptr or a NULL pointer to be returned. A referenced kptr to task
+ * here is acquried automatically as the task argument is tagged with "__ref".
+ */
+SEC("struct_ops/test_return_ref_kptr")
+struct task_struct *BPF_PROG(test_return_ref_kptr, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	if (dummy % 2) {
+		bpf_task_release(task);
+		return NULL;
+	}
+	return task;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)test_return_ref_kptr,
+};
+
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
new file mode 100644
index 000000000000..d67982ba8224
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
@@ -0,0 +1,24 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a non-zero scalar value.
+ */
+SEC("struct_ops/test_return_ref_kptr")
+struct task_struct *BPF_PROG(test_return_ref_kptr, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	bpf_task_release(task);
+	return (struct task_struct *)1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)test_return_ref_kptr,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
new file mode 100644
index 000000000000..9a4247432539
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
@@ -0,0 +1,30 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a local kptr.
+ */
+SEC("struct_ops/test_return_ref_kptr")
+struct task_struct *BPF_PROG(test_return_ref_kptr, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	struct task_struct *t;
+
+	t = bpf_obj_new(typeof(*task));
+	if (!t)
+		return task;
+
+	return t;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)test_return_ref_kptr,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
new file mode 100644
index 000000000000..5bb0b4029d11
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
@@ -0,0 +1,23 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a modified referenced kptr.
+ */
+SEC("struct_ops/test_return_ref_kptr")
+struct task_struct *BPF_PROG(test_return_ref_kptr, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	return (struct task_struct *)&task->jobctl;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)test_return_ref_kptr,
+};
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
new file mode 100644
index 000000000000..32365cb7af49
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
@@ -0,0 +1,28 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* This test struct_ops BPF programs returning referenced kptr. The verifier should
+ * reject programs returning a referenced kptr of the wrong type.
+ */
+SEC("struct_ops/test_return_ref_kptr")
+struct task_struct *BPF_PROG(test_return_ref_kptr, int dummy,
+			     struct task_struct *task, struct cgroup *cgrp)
+{
+	struct task_struct *ret;
+
+	ret = (struct task_struct *)bpf_cgroup_acquire(cgrp);
+	bpf_task_release(task);
+
+	return ret;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_kptr_return = {
+	.test_return_ref_kptr = (void *)test_return_ref_kptr,
+};
-- 
2.20.1


