Return-Path: <netdev+bounces-250120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDF4D24293
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB082303D54F
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB446379981;
	Thu, 15 Jan 2026 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN+GTzai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAC03793B8
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476278; cv=none; b=a5as2kSiNgA7m89j+Rzw2FkVSC1B388rIZ/ncXPj9pXMColXjp6n4pjrb8ezzzW2YTh848ZHhQZo9BrerQsEnlcD12850FeynNCJipoax5l5pQxXUirgM6NFF8gG1aXJk0KVYTR/kbG/roSGLEDWIWrMMYW4A3wIhJoC4Cg3HLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476278; c=relaxed/simple;
	bh=tNyw0RMF3OxHkN5cM2BejvwuZpXkAcKTmu7JJGqwwVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lvh1SDUq62T1/q5hQWqzGfoJ+sk8yWOTXL75j3Kn9NtwiSj5g4i8G3v77EeHXoBwfX7jdIQJ1dECP8bPBPeywnTA8oTrTcXR6iRO4YkrCO1r88nIjlZm1x5EZou+AtMjilanhU4h7nQCxB5E+zG/IKt0ovsmy7AA2EbrvDoyMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN+GTzai; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0f3f74587so5567595ad.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476275; x=1769081075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlyqjJg45w/WwCBTFkaauQNGPumY1lkyqYrB1pbejjE=;
        b=cN+GTzaiLM42FIhv18Ppi9PPUlZ3eM8QPPzHKNWJ33RMlOD53zfdRFLmEIfUFYhv5V
         qeWHbWsk5HP3awH7fn4kGSeficnGxVHFIz34k2GWOn5k4JqxUw+Oae7vbmbBEYZymecE
         nYZ6tZr9gkNTPOcX+v7pAM0ewVYtlt+bIydEABkcDCVajEQ2zb6VnGsZB0JdSMwsrZch
         4wKlCyaeGD9dQGNHrZ2BZx1n91yQOmtaRjUdEYBTvRAViLclGgcriL+muAdKAyaZmnU1
         WgHnQLx+eq43gqQ9cFDhQU5YSJFdgwJ5DVdbIEFKXAV9sQLIqxJ7bbptBTDf1YMyH17S
         fIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476275; x=1769081075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tlyqjJg45w/WwCBTFkaauQNGPumY1lkyqYrB1pbejjE=;
        b=UP8HhumrrVdRPdeNpmozQNz2PCLZxoIxTn++sBnRdQHH6Ytz61kDZyqBCk1F/7S7ZH
         Acc5TTRXhhlfdCjKM7YJ+UuYTnl5YIQaUJGsO7WAUO7x8PhvwXKBm6PvD3R36z08Bc1u
         9dVmJ9LH6NghpzG4nSViQ3rfa2QJXwxQK/Qu5OR6QTuTNHP2m09uLfRn/BqCV2kHq+EI
         XD6oHEdfp/jPVW0nNj+yh43euvQXkPRm4iz0KpFkWAPBr0UEaE76SzCdPvfOzeXbVP1I
         cxm26WwTYWeg1mAMXgeDoa9BvD3Gh9YCMqR3I2x2ahxRA/cUj4uUa/YNkJEg5zxkavL2
         n8Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVpmHWhaQUYXr3VlnCTMgiLcTAWNcOeHng+flWdHcT4LAzD4Qxf3HUMUmorSQT5YS3BwCjX+Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiRtxQKo/hFtgEleBl+R5pftcfliyrYf0nmcxxN+wDCeeIay/G
	0F281ai8RWJwme70DN0Q9B+uGz7taJntSl/K+8w4A9HwHD670rWHBcF2
X-Gm-Gg: AY/fxX4UBDWFd4ZKFV0aFzeY6xKpCZWcHYEF/LUydEEC6UzTAEWiIyma2zStHf0Bih2
	XHeCIYVL5gkL+k301w4HG0KS5F9A+wq3zYVlfYWEOqQn3T6MmiCG2doxYEfTCIellL7R1RfQDGT
	F5w01Yq1Xdj7OeoyNYBDHRvz4qaMYJ61GREDDS1TWC4zG5VdnwjqKOQuv60bDYYEJcnkpn+1WCO
	klnkah5EyRG1TOdTc1k8boO3nxrmlX7s4aiiONOoiWnNTthQjlPp2I8aI52Jxa9tVuTAcQfKmHV
	ab9+NjbR+q4SdT1ncKdBQ19SPVJQDwrl+UoMwo5nzeFjsyGRxrjgUpRdIhSzkxIhuWQ5H0apjfU
	Phgx7M/eKn6uzkgC5MxVje3tORZIHBOwBCD+4onokrGbTSpDgyyNFu0K7fDrdDaalSVzS/RRcpr
	0E3QPIqIF5GZOMgOVXEA==
X-Received: by 2002:a17:903:2289:b0:2a0:e80e:b118 with SMTP id d9443c01a7336-2a599da82edmr62777645ad.7.1768476275385;
        Thu, 15 Jan 2026 03:24:35 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:24:34 -0800 (PST)
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
Subject: [PATCH bpf-next v10 10/12] selftests/bpf: add testcases for fsession
Date: Thu, 15 Jan 2026 19:22:44 +0800
Message-ID: <20260115112246.221082-11-dongml2@chinatelecom.cn>
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

Add testcases for BPF_TRACE_FSESSION. The function arguments and return
value are tested both in the entry and exit. And the kfunc
bpf_session_is_ret() is also tested.

As the layout of the stack changed for fsession, so we also test
bpf_get_func_ip() for it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/prog_tests/fsession_test.c  |  90 ++++++++++++++
 .../selftests/bpf/progs/fsession_test.c       | 110 ++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
new file mode 100644
index 000000000000..75bb42942b67
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <test_progs.h>
+#include "fsession_test.skel.h"
+
+static int check_result(struct fsession_test *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* Trigger test function calls */
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return err;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return topts.retval;
+
+	for (int i = 0; i < sizeof(*skel->bss) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(((__u64 *)skel->bss)[i], 1, "test_result"))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void test_fsession_basic(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+		goto cleanup;
+
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_attach"))
+		goto cleanup;
+
+	check_result(skel);
+cleanup:
+	fsession_test__destroy(skel);
+}
+
+static void test_fsession_reattach(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+		goto cleanup;
+
+	/* first attach */
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_first_attach"))
+		goto cleanup;
+
+	if (check_result(skel))
+		goto cleanup;
+
+	/* detach */
+	fsession_test__detach(skel);
+
+	/* reset counters */
+	memset(skel->bss, 0, sizeof(*skel->bss));
+
+	/* second attach */
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_second_attach"))
+		goto cleanup;
+
+	if (check_result(skel))
+		goto cleanup;
+
+cleanup:
+	fsession_test__destroy(skel);
+}
+
+void test_fsession_test(void)
+{
+#if !defined(__x86_64__)
+	test__skip();
+	return;
+#endif
+	if (test__start_subtest("fsession_test"))
+		test_fsession_basic();
+	if (test__start_subtest("fsession_reattach"))
+		test_fsession_reattach();
+}
diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
new file mode 100644
index 000000000000..f504984d42f2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_entry_result = 0;
+__u64 test1_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test1, int a, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		test1_entry_result = a == 1 && ret == 0;
+		return 0;
+	}
+
+	test1_exit_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test2_entry_result = 0;
+__u64 test2_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test3")
+int BPF_PROG(test2, char a, int b, __u64 c, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		test2_entry_result = a == 4 && b == 5 && c == 6 && ret == 0;
+		return 0;
+	}
+
+	test2_exit_result = a == 4 && b == 5 && c == 6 && ret == 15;
+	return 0;
+}
+
+__u64 test3_entry_result = 0;
+__u64 test3_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test4")
+int BPF_PROG(test3, void *a, char b, int c, __u64 d, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		test3_entry_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 0;
+		return 0;
+	}
+
+	test3_exit_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 34;
+	return 0;
+}
+
+__u64 test4_entry_result = 0;
+__u64 test4_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test5")
+int BPF_PROG(test4, __u64 a, void *b, short c, int d, __u64 e, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		test4_entry_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+			e == 15 && ret == 0;
+		return 0;
+	}
+
+	test4_exit_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15 && ret == 65;
+	return 0;
+}
+
+__u64 test5_entry_result = 0;
+__u64 test5_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test7")
+int BPF_PROG(test5, struct bpf_fentry_test_t *arg, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		if (!arg)
+			test5_entry_result = ret == 0;
+		return 0;
+	}
+
+	if (!arg)
+		test5_exit_result = 1;
+	return 0;
+}
+
+__u64 test6_entry_result = 0;
+__u64 test6_exit_result = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test6, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_session_is_return(ctx))
+		test6_exit_result = (const void *) addr == &bpf_fentry_test1;
+	else
+		test6_entry_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
-- 
2.52.0


