Return-Path: <netdev+bounces-238796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAEFC5F801
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 23:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4F4E4E3DCB
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAE635C1B6;
	Fri, 14 Nov 2025 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmjnY6te"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1644353892
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158670; cv=none; b=ZQvjNSMwtl8qNWhAbRN+G0xi9laCAt8ij8SlOvfO2JWpySUwdEI/37tmn4Ai2zdyfsBnoJGOp4mntjbfclTJvWUAIClkhf5Lrok/YQYzyA4CUzFSz5upgYm0ejoaVPGVOgafPlbyIzp9J43Svt4XB2EatUbQozxTvAkyrqeyJu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158670; c=relaxed/simple;
	bh=r2cpypKNtoxrCoOvB0Flt6y7nwCGfjTBReWiMPCT4XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnwM/s/BkTDyDubaqv9QZwOzqlrmQpoAoSVWOrwXr8UIyV3hgQ2ldwGiAYA2pnANxUrY2zyJ4V1iVNjeyNBEbE3AZxrOrejcP8hjZXTDzTcqAva/MEMNk5Doy2wdd1tqMjtebt6MgrHwJl287U9OLqbQdb17v8N0zyxp8JdQDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmjnY6te; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297dd95ffe4so21557985ad.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158668; x=1763763468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kxji5vPXaBJXOxG97hmDiCyJP+BVSgMVlP1dhR088Aw=;
        b=AmjnY6teqTEpzmIT4DoSUri9ILgjxx9vLJb2jwLBsMRFeJmEvVL4rywPel6BC0go/5
         b5FtMz/8NDI3rMaWR230Rju+7hEo72eKyFcsauHjMmd3gYIRXwGdbxwlPO5h6lhSMW17
         ejBP4BBt/zTAymw9eiLAmxOEKJ2+DaYxNFt6sT+kLONRKsHekNPrJfOEniVqR++PN+n8
         XE+Rop0ApNQidpvdNxwwq96Z9tGMsOEgxzzYxbXupVZrgW2976F7CiI6rlq73+7Cjzr0
         4zHACU6n99O0vt8Q+yVztSbIcsVd1crGEwkF1x60n3bQgUcmv/nLOPUYf3vQh+SfCxrn
         qdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158668; x=1763763468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kxji5vPXaBJXOxG97hmDiCyJP+BVSgMVlP1dhR088Aw=;
        b=KlGydYqQDeGd+Tl3TH94VaYDoCBj8Rdeq+JrCJfthMozjmzd6BXx7Gj8hYGfda0bzQ
         crzZa51rHEqF2f/vSvCVeML/m85Qg3Dt4SafqU4fuBgf0DMr6vPAzfjsuqury/MXVf+i
         jEGYxWrQXSjwAS/g72AT1GA45RCNJTVAj5uxQAgn3oXICqJvIJS9riYg0r4Claw//0ev
         ljEp9oVvgcW9E0UP5oOlScjesH0xKHUAUJPGg9I1y9DgzzuPlKKwjkL6vfHPZz/k5vKF
         VDeKOatAwm+JLZkM9T4N/jahnrxlR/KvrDKw37VbNHZFpariAW5ZIdocUOHPku2EDPqn
         GZXQ==
X-Gm-Message-State: AOJu0Yw40scIMQ+1uFUGN3ZxVIAcf8LWquOqrnzmnQr9oQ2vIlT4MjCG
	D2p1vUv6U9xQz9keB/GIzLXIP4c3H8loRi1dzd9kfikX8OWxP5rt3wW6
X-Gm-Gg: ASbGnctrfTyoQt/c7Y6wPoPMXNyx00eSwnN+EAgnpNbP83Rmw808rdNq191fqW0yb1d
	zPm7u+MZgKyK0K2mIzT8aGmUTKPLWiIVTDnHR1n6vfCbdnE+Wn8O14RlxiXY9GcXVxK+TWd6B6t
	0pKlZb7RsN07gj6DkWHdSluA/gP0PtxqsAba7jE9WUR/2KKbN9N3XK/7GQo1J8zPzJaVTq1GgA9
	W3TVG25gFlMQfofV+lIhu6yY7HT1kuZ13ALaOy1Lrn6NXATBc8wBV2uxI68aqXt4hGMligbebMQ
	tfXQPlZlD+ZYZum5dRrLnS/a8Udkq1FRbIH5/yEniVG83ovx0uwfgd635mZ9453pxImY3U4WnZ7
	gvFjz3jMrjhfiGY1DyYVEc0KU9RXkcezIzejrBFzx2EMAIFZq/qshwKMV6UReJfcKDbWR45fYtJ
	wTbwHyjVvEWMJPnw==
X-Google-Smtp-Source: AGHT+IEmFfXkKxYhMiStKIjUrR/feDoN6KsgV40RUBMVKR07wG8d2iMbPXKT+gqGac/9hLiWXY9MNg==
X-Received: by 2002:a17:903:1a2e:b0:295:f508:9d32 with SMTP id d9443c01a7336-2986a733373mr57910365ad.37.1763158668201;
        Fri, 14 Nov 2025 14:17:48 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245007sm65420765ad.31.2025.11.14.14.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:17:47 -0800 (PST)
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
Subject: [PATCH bpf-next v6 5/6] selftests/bpf: Test ambiguous associated struct_ops
Date: Fri, 14 Nov 2025 14:17:40 -0800
Message-ID: <20251114221741.317631-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114221741.317631-1-ameryhung@gmail.com>
References: <20251114221741.317631-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to make sure implicit struct_ops association does not
break backward compatibility nor return incorrect struct_ops.
struct_ops programs should still be allowed to be reused in
different struct_ops map. The associated struct_ops map set implicitly
however will be poisoned. Trying to read it through the helper
bpf_prog_get_assoc_struct_ops() should result in a NULL pointer.

While recursion of test_1() cannot happen due to the associated
struct_ops being ambiguois, explicitly check for it to prevent stack
overflow if the test regresses.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_assoc.c    | 38 ++++++++++
 .../bpf/progs/struct_ops_assoc_reuse.c        | 75 +++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index 29e8b58a14fa..f69306cb8974 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 #include "struct_ops_assoc.skel.h"
+#include "struct_ops_assoc_reuse.skel.h"
 
 static void test_st_ops_assoc(void)
 {
@@ -65,8 +66,45 @@ static void test_st_ops_assoc(void)
 	struct_ops_assoc__destroy(skel);
 }
 
+static void test_st_ops_assoc_reuse(void)
+{
+	struct struct_ops_assoc_reuse *skel = NULL;
+	int err;
+
+	skel = struct_ops_assoc_reuse__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_assoc_reuse__open"))
+		goto out;
+
+	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog_a,
+					    skel->maps.st_ops_map_a, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops");
+
+	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog_b,
+					    skel->maps.st_ops_map_b, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops");
+
+	err = struct_ops_assoc_reuse__attach(skel);
+	if (!ASSERT_OK(err, "struct_ops_assoc__attach"))
+		goto out;
+
+	/* run syscall_prog that calls .test_1 and checks return */
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog_a), NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog_b), NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	ASSERT_EQ(skel->bss->test_err_a, 0, "skel->bss->test_err_a");
+	ASSERT_EQ(skel->bss->test_err_b, 0, "skel->bss->test_err_b");
+
+out:
+	struct_ops_assoc_reuse__destroy(skel);
+}
+
 void test_struct_ops_assoc(void)
 {
 	if (test__start_subtest("st_ops_assoc"))
 		test_st_ops_assoc();
+	if (test__start_subtest("st_ops_assoc_reuse"))
+		test_st_ops_assoc_reuse();
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c
new file mode 100644
index 000000000000..caaa45bdccc2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc_reuse.c
@@ -0,0 +1,75 @@
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
+#define MAP_A_MAGIC 1234
+int test_err_a;
+int recur;
+
+/*
+ * test_1_a is reused. The kfunc should not be able to get the associated
+ * struct_ops and call test_1 recursively as it is ambiguous.
+ */
+SEC("struct_ops")
+int BPF_PROG(test_1_a, struct st_ops_args *args)
+{
+	int ret;
+
+	if (!recur) {
+		recur++;
+		ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(args, NULL);
+		if (ret != -1)
+			test_err_a++;
+		recur--;
+	}
+
+	return MAP_A_MAGIC;
+}
+
+/* Programs associated with st_ops_map_a */
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
+int test_err_b;
+
+SEC("syscall")
+int syscall_prog_b(void *ctx)
+{
+	struct st_ops_args args = {};
+	int ret;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
+	if (ret != MAP_A_MAGIC)
+		test_err_b++;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_multi_st_ops st_ops_map_b = {
+	.test_1 = (void *)test_1_a,
+};
-- 
2.47.3


