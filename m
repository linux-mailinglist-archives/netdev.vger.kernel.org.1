Return-Path: <netdev+bounces-232717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5866FC082F4
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 23:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69DE1C20ECD
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 21:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E787306B1A;
	Fri, 24 Oct 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvVyih89"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6F130505C
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341364; cv=none; b=niBz+GrufRAK9Q61zhB6OgOSzsbMO5X6k74h+zw0cddv12YXXSPhuATJgOZtR/t4ssGVwcvVL8vQaxFoPnRiXPi5QWkGIC4vZtN1SmAKKINGyfKQBKcwQpTAaulWxn4MpRWKFgP/5ZmMrX181nANXWKnfRpaVLpeBSDnJBnJI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341364; c=relaxed/simple;
	bh=k08iaBDrENEA4IJk8Zm0aDdo/pxxxTnaTC6RUbVgWWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uE8D++ne0SYlfQn6Mm3Z/cgOSzTKfKMFEQkjPiEAukzmHSup0G5IGDQhvo7XUfqMumfgvmH9AXeaxnZo0e3etruy0Qbl1lfi7E0KupvDKbwAvkZ447KlcrjkWJYeXjbJ3JUp/phDvf2N6wpM7JMYIX4f0ntgxRFCm6CfAvvTeBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvVyih89; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ceb3b68feso2037077a12.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761341361; x=1761946161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgvXDrHO9mcvAIi8X5p2Xm3BC5hOk4tpDInioO0JtN0=;
        b=JvVyih89UP4ZVaIPY7rcCdYyUDMNH3IZeyTSIylXkA/VjlrSYdRHtOo90cddyyNt3e
         iN7ryMdMziMqK+7raZjzNyfDW8FG1IC11XN2bIJQhFQw2FgsTfLSf1SnoWi1Wb2Lj2cM
         3+DWhnokPAnMHHlW5BqL7D4u9xXyJIcbFXjNKpjw8LoCQVqMEVMu54WeBQVy9K9ReAlL
         cZkCtibEH1qNrqRW9Yayt/5HPXhKMVOllBk6pe2SiiIGFBi6rSgbS21+cObDc5Nmnej+
         /z/cwXtNF3qizzDI5H/Wkab1pSLEIGCiTUN5EkvYt/+kF5Y14b4NhxbZ4H+dAzON6V/2
         KnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761341361; x=1761946161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgvXDrHO9mcvAIi8X5p2Xm3BC5hOk4tpDInioO0JtN0=;
        b=Bzjl5Xsk5mgnrL5SFmobOcm10eEfSfCmJeZ7MYSVszejTfBvKo9J9JPOmNI/bg773a
         K2yGcp/0tnvcPpbcjRsPXHN4TK4rn97fOohdEbGAlJ7BgLR77zauAgzZvgEB2FTUVqvO
         Lwb/5YcszTn9SZgky/T6bEroWIQ7mlBbJyVglCd/OZfDDT+sYGOsZKREQl6O81Xt+YNG
         WEGJcWrcoqeKzrG7PLI5Rc1UqwcNHCw43FO0dObFdZ31GdbniImPz7IE5HudU3c4u2UO
         yRcB0lgI1GQ5UibGxq6plaCv9KkSkbzwiHpoRxU3JXMr/1YbahkYC33K7i0LvOusEonl
         JJEA==
X-Gm-Message-State: AOJu0YxREUPGX7pDHsVTImNHgKN0wVFksnZqkjIwZnmbcwGD9FkCj+2n
	/aXZY6/DDoW74xNwsdcT2ezYUlhNaCFYMCb8pu8TKbmyWzJaQ+7c3GDT
X-Gm-Gg: ASbGncvqbrnWqzn43r/inF0b+Bl6dk0bY4tHiFcM4X94fOS3x32v/WiVUoxIzxCMc4b
	qOqtuuu8E83WkSkPdKUyhQ4v3COJFVq//XR+pTEQL2u70/shM37n53bIZ78XexGPKTGKwvYsbxw
	6R5GuoykRY6/FBtndoS3WRXKW+bZKSozhAbwRwOJLfID5gsKXedXgl6P9Zac4zghmug3Wg8Qa3/
	fv3gPVrG8KG0hjp7YXjhomhb9A4jYiMWxNfTAPgaaqleM0n3oBAegaeTWwI7QwoHk5orJ4tpEbj
	iGbSBO+bjCY1FD2LpidHbtT8PlBke1i+WsAFTOjNPUqTvaouwLX4PkL+fXZvWdGjTbI4t3oxGnz
	VHgD26ZrMe6OYexGBNhBqfTY0eoHBIb2dBNndG9BNyzKLrnWEN7bYjGk9PEQQNem9ypk=
X-Google-Smtp-Source: AGHT+IGbnH4W5o+L/c0LN2OduGiHje0QclJWnafMjIfkBB0/Dl8ak3G8kcQ4jCJrp8HoJU6Bn+6edg==
X-Received: by 2002:a17:902:ef4e:b0:290:d8f0:60be with SMTP id d9443c01a7336-29489e70291mr53236995ad.30.1761341360829;
        Fri, 24 Oct 2025 14:29:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed70a83csm117468a91.4.2025.10.24.14.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 14:29:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: Test getting associated struct_ops in timer callback
Date: Fri, 24 Oct 2025 14:29:14 -0700
Message-ID: <20251024212914.1474337-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024212914.1474337-1-ameryhung@gmail.com>
References: <20251024212914.1474337-1-ameryhung@gmail.com>
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
 .../bpf/prog_tests/test_struct_ops_assoc.c    | 80 +++++++++++++++++++
 .../bpf/progs/struct_ops_assoc_in_timer.c     | 77 ++++++++++++++++++
 2 files changed, 157 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index f69306cb8974..3a08d3afc0c6 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include "struct_ops_assoc.skel.h"
 #include "struct_ops_assoc_reuse.skel.h"
+#include "struct_ops_assoc_in_timer.skel.h"
 
 static void test_st_ops_assoc(void)
 {
@@ -101,10 +102,89 @@ static void test_st_ops_assoc_reuse(void)
 	struct_ops_assoc_reuse__destroy(skel);
 }
 
+static void test_st_ops_assoc_in_timer(void)
+{
+	struct struct_ops_assoc_in_timer *skel = NULL;
+	int err;
+
+	skel = struct_ops_assoc_in_timer__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_assoc_reuse__open"))
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
+	/* run syscall_prog that calls .test_1 and checks return */
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog), NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	/*
+	 * .test_1 has scheduled timer_cb that calls bpf_kfunc_multi_st_ops_test_1_prog_arg()
+	 * again. Check the return of the kfunc after timer_cb run.
+	 */
+	while (!READ_ONCE(skel->bss->timer_cb_run))
+		sched_yield();
+	ASSERT_EQ(skel->bss->timer_test_1_ret, 1234, "skel->bss->timer_test_1_ret");
+	ASSERT_EQ(skel->bss->test_err, 0, "skel->bss->test_err_a");
+out:
+	struct_ops_assoc_in_timer__destroy(skel);
+}
+
+static void test_st_ops_assoc_in_timer_after_detach(void)
+{
+	struct struct_ops_assoc_in_timer *skel = NULL;
+	struct bpf_link *link;
+	int err;
+
+	skel = struct_ops_assoc_in_timer__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_assoc_reuse__open"))
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
+	/* timer_cb will run 500ms after syscall_prog_run when st_ops_map is gone */
+	skel->bss->timer_ns = 500000000;
+
+	/* run syscall_prog that calls .test_1 and checks return */
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog), NULL);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	/* detach and free struct_ops map */
+	bpf_link__destroy(link);
+	close(bpf_program__fd(skel->progs.syscall_prog));
+	close(bpf_map__fd(skel->maps.st_ops_map));
+
+	/*
+	 * .test_1 has scheduled timer_cb that calls bpf_kfunc_multi_st_ops_test_1_prog_arg()
+	 * again. Check the return of the kfunc after timer_cb run.
+	 */
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
+	if (test__start_subtest("st_ops_assoc_in_timer_after_detach"))
+		test_st_ops_assoc_in_timer_after_detach();
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc_in_timer.c
new file mode 100644
index 000000000000..9d4e427568b2
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
+	timer_test_1_ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
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
+	ret = bpf_kfunc_multi_st_ops_test_1_prog_arg(&args, NULL);
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


