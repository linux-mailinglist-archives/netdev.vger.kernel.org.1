Return-Path: <netdev+bounces-243480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7660CA1FA5
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 00:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE63E30446A6
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 23:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AEA2DEA6E;
	Wed,  3 Dec 2025 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6jIap+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2E2FB62A
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805080; cv=none; b=R43WcvS1hjf1TxrhqHP8cqi3FSMbqcp71QVcicD0gjujZ8HtwXSQpfdITRIw6pbCJPVCAdxa2KA/6vuWXj8D7Kvj+xU3AfJ66ZT02sm3Ps5r/BbaZwE99zzsYdjQ83aP6V7QP3efFzYk5sJS34W5hVZpdGlsxdSk/fhRxxYuclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805080; c=relaxed/simple;
	bh=8NLOqWpy8a/MH0MMPMLfZ6h0+k39D7hvZU/ngyrCqQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQGoUY0iiMu/OGRp6N1xPx+v5Qr1Cix2/2voDv95N4pnN3GfZ/SnKGaggZQ8Z36ltGEh+DowJDax//6y8YMLQucMWfJ3hjxPdrElP8QYtnmwdCGLgqHEyCM/MAgFIUa2vy4YwqEpyasxfrzG3bZUl6Yy/niJg/bNb8QqUqLkezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6jIap+e; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-343dfb673a8so247408a91.0
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 15:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764805077; x=1765409877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOAg0Vgw0476GlI1Inqs3Yf2nsrBp/ozmOPyb10gL2M=;
        b=c6jIap+eTgsMowY5Xz7O6fKpWMPZQWp8y5Y50nZnw00YBRnmTGnK1pHEetLiBiqn1U
         aj0CZ65QGKdN0efpekwYNR9mikUiFS/2rHREdFaCOSfKQNs+ow7ygaOG94aionyWxk4d
         nA3DNWiU2sFyv6Rj9PZyCdYydU5ludML79Zsajwepeb26JeyZMSWwrwi9iLnGDixybhf
         mqYuUzEI7pLSKJThhJn8mw+7QOqiNGmT5Pgl3BGUPaCQ7OcNEcnEiaSlaWOrLU0foEeR
         xRj7GIoarPtI6LndYsrAmmVU8Otr7W+ohLYovKtkNioy81vI8EIUoJYIYB4o9CyCM+lV
         ZlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764805077; x=1765409877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eOAg0Vgw0476GlI1Inqs3Yf2nsrBp/ozmOPyb10gL2M=;
        b=rkq7FdnckauyI+516JR/M7drV7FtI01a3mJg9mthlrxCF/MmejJJnGpkJiZm1yX0NF
         IVxZJu1hQREokQNOCWqVnc6Pz1Bw+VZmLkwpmssUbMQmVhrirs7f+nCIz/NJzqBaoy75
         vaCWLyN2tZVJWE4YGN7YfJWuyIIZhJMheQQN3MQ/HlHcnm8c6X4hUkeuzDP7gON3Dvjv
         CiWqhAwOlEU0xqX8AqeZb2apdA6jzERwNk0Z4XH1dFvJbOFZpqtqcMs7JUWln18eR+qN
         Aq1zTqUIqaTKIjkiOdttakFhdgEOO+pQ3ib1fu0izpAzJeHSVl1cE7S4qG8T3dqEBWdS
         z8bA==
X-Gm-Message-State: AOJu0Yw8mJd1+vz2YUBWguFQhXEi1xF4wVKAdfocdaj8vDhdfvBD9SCH
	ymg2JgMvW//pfGVjjtK7cVhnUV4+2qqC1/yQA4g74slhUEtuO/X5YNvs
X-Gm-Gg: ASbGnct7Ctd5yx9Xea4QZBH9BwY+HGv2NSjb/N8phbsKKBTa0Biqmm6Eq1K7St36+Kr
	J8hwS+hMkNpVyhP+hxA79FEcOqKUCEhuHLgjV1M9GMAM2os6GWSnLwuiMyvnombQZ11a4LoZpng
	IZDPaWAKizaCkRSk446CdP8D4cc5NYRuQBI8JPck4yhRYcD8xD5oBaP2QzwbJLrJVtgcv1riayN
	emckduX+RqAe7BQX2Tg7ZN2e4TFIoGiAomtH3TjBYxuQGqWnTayWohUg37XcZgII0FfSoEk4/U5
	Mwq0CLH4YH6eGckeO270Xb4/OACQdk8/2MjZ/UfYrrKYIGRT4MtimzGZAAcH9Sl5rPsJHb3Be23
	DVkGnLVzKnvdwqfAkQCVtITLH7zUJ7QNKvNeYICmAT4T8wd5oH5JNu0cB9FMSWttcpECcuIHd78
	4use7THdOv2vF6
X-Google-Smtp-Source: AGHT+IGiIe5fSv49kIYchgHbKHUlodIWmlai40URoBJmwcLqDlBxcUIBHjpvix1/X37kkdJ4ynyTaQ==
X-Received: by 2002:a17:90b:4b85:b0:349:3fe6:ab97 with SMTP id 98e67ed59e1d1-3493fe6ad75mr1256359a91.22.1764805077212;
        Wed, 03 Dec 2025 15:37:57 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494e84f577sm93288a91.6.2025.12.03.15.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 15:37:56 -0800 (PST)
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
Subject: [PATCH bpf-next v8 6/6] selftests/bpf: Test getting associated struct_ops in timer callback
Date: Wed,  3 Dec 2025 15:37:48 -0800
Message-ID: <20251203233748.668365-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203233748.668365-1-ameryhung@gmail.com>
References: <20251203233748.668365-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure 1) a timer callback can also reference the associated
struct_ops, and then make sure 2) the timer callback cannot get a
dangled pointer to the struct_ops when the map is freed.

The test schedules a timer callback from a struct_ops program since
struct_ops programs do not pin the map. It is possible for the timer
callback to run after the map is freed. The timer callback calls a
kfunc that runs .test_1() of the associated struct_ops, which should
return MAP_MAGIC when the map is still alive or -1 when the map is
gone.

The first subtest added in this patch schedules the timer callback to
run immediately, while the map is still alive. The second subtest added
schedules the callback to run 500ms after syscall_prog runs and then
frees the map right after syscall_prog runs. Both subtests then wait
until the callback runs to check the return of the kfunc.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_assoc.c    | 81 +++++++++++++++++++
 .../bpf/progs/struct_ops_assoc_in_timer.c     | 77 ++++++++++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index 02173504f675..461ded722351 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include "struct_ops_assoc.skel.h"
 #include "struct_ops_assoc_reuse.skel.h"
+#include "struct_ops_assoc_in_timer.skel.h"
 
 static void test_st_ops_assoc(void)
 {
@@ -101,10 +102,90 @@ static void test_st_ops_assoc_reuse(void)
 	struct_ops_assoc_reuse__destroy(skel);
 }
 
+static void test_st_ops_assoc_in_timer(void)
+{
+	struct struct_ops_assoc_in_timer *skel = NULL;
+	int err;
+
+	skel = struct_ops_assoc_in_timer__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_assoc_in_timer__open"))
+		goto out;
+
+	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog,
+					    skel->maps.st_ops_map, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops");
+
+	err = struct_ops_assoc_in_timer__attach(skel);
+	if (!ASSERT_OK(err, "struct_ops_assoc__attach"))
+		goto out;
+
+	/*
+	 * Run .test_1 by calling kfunc bpf_kfunc_multi_st_ops_test_1_prog_arg() and checks
+	 * the return value. .test_1 will also schedule timer_cb that runs .test_1 again
+	 * immediately.
+	 */
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog), NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	/* Check the return of the kfunc after timer_cb runs */
+	while (!READ_ONCE(skel->bss->timer_cb_run))
+		sched_yield();
+	ASSERT_EQ(skel->bss->timer_test_1_ret, 1234, "skel->bss->timer_test_1_ret");
+	ASSERT_EQ(skel->bss->test_err, 0, "skel->bss->test_err_a");
+out:
+	struct_ops_assoc_in_timer__destroy(skel);
+}
+
+static void test_st_ops_assoc_in_timer_no_uref(void)
+{
+	struct struct_ops_assoc_in_timer *skel = NULL;
+	struct bpf_link *link;
+	int err;
+
+	skel = struct_ops_assoc_in_timer__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_assoc_in_timer__open"))
+		goto out;
+
+	err = bpf_program__assoc_struct_ops(skel->progs.syscall_prog,
+					    skel->maps.st_ops_map, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops");
+
+	link = bpf_map__attach_struct_ops(skel->maps.st_ops_map);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		goto out;
+
+	/*
+	 * Run .test_1 by calling kfunc bpf_kfunc_multi_st_ops_test_1_prog_arg() and checks
+	 * the return value. .test_1 will also schedule timer_cb that runs .test_1 again.
+	 * timer_cb will run 500ms after syscall_prog runs, when the user space no longer
+	 * holds a reference to st_ops_map.
+	 */
+	skel->bss->timer_ns = 500000000;
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog), NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	/* Detach and close struct_ops map to cause it to be freed */
+	bpf_link__destroy(link);
+	close(bpf_program__fd(skel->progs.syscall_prog));
+	close(bpf_map__fd(skel->maps.st_ops_map));
+
+	/* Check the return of the kfunc after timer_cb runs */
+	while (!READ_ONCE(skel->bss->timer_cb_run))
+		sched_yield();
+	ASSERT_EQ(skel->bss->timer_test_1_ret, -1, "skel->bss->timer_test_1_ret");
+	ASSERT_EQ(skel->bss->test_err, 0, "skel->bss->test_err_a");
+out:
+	struct_ops_assoc_in_timer__destroy(skel);
+}
+
 void test_struct_ops_assoc(void)
 {
 	if (test__start_subtest("st_ops_assoc"))
 		test_st_ops_assoc();
 	if (test__start_subtest("st_ops_assoc_reuse"))
 		test_st_ops_assoc_reuse();
+	if (test__start_subtest("st_ops_assoc_in_timer"))
+		test_st_ops_assoc_in_timer();
+	if (test__start_subtest("st_ops_assoc_in_timer_no_uref"))
+		test_st_ops_assoc_in_timer_no_uref();
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
new file mode 100644
index 000000000000..d5a2ea934284
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
@@ -0,0 +1,77 @@
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
+struct elem {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} array_map SEC(".maps");
+
+#define MAP_MAGIC 1234
+int recur;
+int test_err;
+int timer_ns;
+int timer_test_1_ret;
+int timer_cb_run;
+
+__noinline static int timer_cb(void *map, int *key, struct bpf_timer *timer)
+{
+	struct st_ops_args args = {};
+
+	recur++;
+	timer_test_1_ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
+	recur--;
+
+	timer_cb_run++;
+
+	return 0;
+}
+
+SEC("struct_ops")
+int BPF_PROG(test_1, struct st_ops_args *args)
+{
+	struct bpf_timer *timer;
+	int key = 0;
+
+	if (!recur) {
+		timer = bpf_map_lookup_elem(&array_map, &key);
+		if (!timer)
+			return 0;
+
+		bpf_timer_init(timer, &array_map, 1);
+		bpf_timer_set_callback(timer, timer_cb);
+		bpf_timer_start(timer, timer_ns, 0);
+	}
+
+	return MAP_MAGIC;
+}
+
+SEC("syscall")
+int syscall_prog(void *ctx)
+{
+	struct st_ops_args args = {};
+	int ret;
+
+	ret = bpf_kfunc_multi_st_ops_test_1_impl(&args, NULL);
+	if (ret != MAP_MAGIC)
+		test_err++;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_multi_st_ops st_ops_map = {
+	.test_1 = (void *)test_1,
+};
-- 
2.47.3


