Return-Path: <netdev+bounces-235554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B51C0C3253B
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C372345D5F
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3C533C507;
	Tue,  4 Nov 2025 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwQNW4e+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60AA33BBAB
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277224; cv=none; b=XTKHMncTERjEpncFYl23r6437W3+cwvwlO1gOe+yY6Vrlsoqe6IL3WO0z0UMepNC//DyYkwgIKiFvxGG4kWkafIVKWGrgFaTQLFv65ySc3QKuG9LgL3pu4pweRNnD+LTduUAzm5zUolMhVUV2HhtUL+Hg2ZVtmPub1RH7jxkl40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277224; c=relaxed/simple;
	bh=r2cpypKNtoxrCoOvB0Flt6y7nwCGfjTBReWiMPCT4XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYZi6VuZth35jbXq/gzPiPZnD7e1arLfBaEXqCREaBcPI/xQatkeUrWouJFjJ4G5dPV9Whee09yzYE7bsOJ3z8UpylPtcGkgjfH0s2Ghyxxf/2D8Q75y5Pn2DTJtL+z7KW0q0ybhVxLz8XxIOjhcEgvSuLID6AkjZ+iycgqOEAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwQNW4e+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3410c86070dso1933605a91.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 09:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762277222; x=1762882022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kxji5vPXaBJXOxG97hmDiCyJP+BVSgMVlP1dhR088Aw=;
        b=OwQNW4e+al5L7w57iRaXvlo0C87EnQjtuXMu8rSliCJOjrjmKs5815+ny5xLeGrP6t
         18AULJuHzSIiC3Xdnuj8GY/jx7Qkd1qNmUj2oYNVWJQFYGy4jloMs2vTpDBlSv+vqj8I
         8kXHQqF8w2yOsJeppTR5V6r7ByIdDI5pDpvoQcCSjsASXHqmmmk2ZrLgbybz+Q2jqtlr
         VW6qzcSquqsgNlKQ36e3mMZprYorADia0nlJEeN6rEhTlF6EVOMmVeoyU6rpmQ+KVF6q
         o3po9SotPKHjxoXpi7HcRo9nGHwOsSIwBvW/Kzl8Zam/25RYZAUvv0BiYG0o6HpL7qst
         c9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277222; x=1762882022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kxji5vPXaBJXOxG97hmDiCyJP+BVSgMVlP1dhR088Aw=;
        b=mNEVJkXr+ZV01/M4CAu0JBGOlpihOQiMFbawC22qQHbS7l7Wb1buyIHveZr+Q2JWs7
         9kQ27ObMTd7QmWnSKoOAuT9kmBM34hj1ks+3sfBljmahNDIeyMzNml4Yr1BMJs/294N2
         YH7In43J6yhenSlPkDZ/0s0TyucTWM0u4BluzaLTJGGtVy5IlpoVQGYKsjX1lmt3m1zQ
         fXm3Lccrn8Ep3j/Ir8r4LltPU3xeDF+XZaNAJfIj42bgJJ9JMn9OndcEeNKEK8WWWZ6O
         8BXeZeYzRcvA0WSTvJbbJYB6q5jyDq9g+9kCOnqlinVKduE8tOj+5A/hIikeU6fe9rDc
         Pd2A==
X-Gm-Message-State: AOJu0YyZ3aDdwjJv+cvpRGYMepzxXb7IxzF+f5H19QhTFJaOP+WwJT5j
	r+czdldzhTLCd8kUAWP9XCrPkl8Ef9twtnQrgLSToEaH4h5vmDSYzFGq
X-Gm-Gg: ASbGnctvsWWe/u45ao99g8L/MxnYKxXJdhoXUCkkZMHq5KcDeLrDCLOYxCsfvf/3uwK
	xtRVulvO6+MuF3r9HkyaVyDQxfI62YA/tM6Oz/jvsFV6ArSCpZaVTWDeu337uuUPHN7b1IUgjDI
	/ZmSdPOwE7sIdPz6W5FutIOi0Y1CvxG5qAq+KDiKXa9LsxdZJskoNtEvnneTRTvGRkqMbjoj/xq
	5I+DvEnl6hq2FJ/EcAwXH3ahYi6P9VzK3sPNlZnlxyAm4Kg53gKn2cPzBduaR7bzpt52FtHkh6y
	W4kTPtmqGVNIMM3BHYlHythc/rl1d9/OVdlGwpFeMxpTO//9I+4wNCOBHw+co9VwGDNoAdI7OKh
	zIKCOo/GPot9mCs1pH8gaQ/fKCiA8VPbtOVQ+HdLiqT0fimGb9gi1ZP+5Df+fjkFraKE=
X-Google-Smtp-Source: AGHT+IG/E1nI2xIOUSHJpYUim7QvzeH+jJfrJjKKLMZucYDyvCaKU0j//lrTd0viRHjvVhB84Ia6Pg==
X-Received: by 2002:a17:90b:4b:b0:340:bfcd:6af8 with SMTP id 98e67ed59e1d1-340bfcd735bmr13250774a91.4.1762277222170;
        Tue, 04 Nov 2025 09:27:02 -0800 (PST)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a699c98dsm42357a91.17.2025.11.04.09.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:27:01 -0800 (PST)
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
Subject: [PATCH bpf-next v5 6/7] selftests/bpf: Test ambiguous associated struct_ops
Date: Tue,  4 Nov 2025 09:26:51 -0800
Message-ID: <20251104172652.1746988-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104172652.1746988-1-ameryhung@gmail.com>
References: <20251104172652.1746988-1-ameryhung@gmail.com>
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


