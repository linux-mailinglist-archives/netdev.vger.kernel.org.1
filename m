Return-Path: <netdev+bounces-227695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81B3BB593D
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 00:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320923AD633
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 22:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3222C159A;
	Thu,  2 Oct 2025 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7OY1Px2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A402C11C3
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445649; cv=none; b=iG2XzuQYe7sDuAdhGEi3By07syuB8F2VFhmAHqv7WxH8+ecYAu9ys3ka7q2+pZO+NELn4GwTAs7wwasqbCKSmc95JcW6223bHvdFYy4fJQXl4CNjDlfBuL9mpLZfVPc6FmeiJ1z3J4w2/uTF93k0cV9iwlM92bnk6eF8ByKHgko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445649; c=relaxed/simple;
	bh=ccp3EztJlEJzQLmiEu1DIzpJsXT5LIfKYR2G67v0qAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfFxkz0w36zV17YpHSoL971LftGOeUiqFcqoVDklYWtr02HrNXNDoA1gdoA6B3eWvlK5/49gRzmSv5n1OOJICXFg5ZCdGUbMDE8uKJy48e4tP00ScwfvE1ieod8wXoF5A7ifzVVnQQwpHimgfagechsvidIryyyxlx0YtWTDfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7OY1Px2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7811a02316bso1216666b3a.3
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 15:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445647; x=1760050447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dhstHRDqQgEPx9WkzXkwbtwT/zsNcRbIl8bglWWgQI=;
        b=F7OY1Px2WNY4hmzwxTbcjClF/0oKKT4vPRtII9id1bGPK9ZpYxhKxF099i5iZ75+bg
         pIvJhCUzmOfLGZhhwPhJTP7gtBkz7u/oNurtTyi1VYjarNKajgzLi56ECPUcoDarKCBx
         JjywmTPYB9X4Ipwt5ZsBL1BK4FD0WLTLnhKcd5rObHcNRs7A2r7vsgTQGjqMwZA2ZriG
         C6Yyzrz0Yi7VSMbIRd1oVuGH7o3oSrOsdSOQ1DPentEL4E0RCe9ngfvUgZqTaG48WZ3t
         c8slFyc3twvaMEz8wBD8MGgzasbcE51ZkuyzU+ZDMaG/AeDhADqtFXzMynwQWWMv5/iU
         OkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445647; x=1760050447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dhstHRDqQgEPx9WkzXkwbtwT/zsNcRbIl8bglWWgQI=;
        b=quireyCL8qJQcDEy6a96HwYVdxtav8MVAF0faT/aOwd6GBggceiz4P355b9MKe04ms
         qZIJMlkcBH2Ilt9IAzMrtD6GAhadBUG+KK4U2Nydg+RswiiPsb7FyCCvfKEmeteONP8M
         ZrkGtOfGKHotioI7bP65MSLnwfE8Z1S1cVRQ2npYULEmB7BHzaxlon7QQhj9JQh8TqdS
         U7/k5JHBq2XCmDj7dyjGjFOCC4HFs1XYRKASLlQFCNWBKP8GEZXKd3YH+j9UFudMg3s6
         f6jj5sdQkNwyuqPL8Z8OvljoGzAWyFnmNrpDh+Ta7LjoiLGyLcE3VB8mCAvQKdBwzYw9
         pgBg==
X-Gm-Message-State: AOJu0YzmeFnYiuMFnBlNBMr3bUuji9XG4jce7N/ua1WqO8eYksErtqo/
	F5ZsSzQaONZZLj12pBMUNBJna56Aqn8ryiBwOWGXsVjyt/6h6HJ9QRmsr52fBg==
X-Gm-Gg: ASbGncvYU69o4uQHiwm2+3yyzDblEUwZyf+NrDMDvyJxLphoTvX0VZ18RyVCQXQLqf9
	vt6qtky+V4Kjv/9x0qvOqlz/Gn/oxxiYbh9BVERgU9w9BiUrWINVg3eMXQJAE8NrZ4E35Tv2vks
	URbq90gUQmU5hAolZaXdY+tmsRzSI1QwxRztTSkbhaaaDT03MSWcOFjmQXWPoGi9ol6ooXucG1T
	/XaN/LJMYLWCkKL5KG4O+1vJS6U3nAOT3Rth0c4I8hoHAgf/UCEtC9EKfX5lh2TNymsQikJ0+jG
	CFbjSE2I+FLCYK8xOb7kGQMrjif+6yVMaEPAV4Fll+PQbLqD1wacZSD9JCjg9zok5FzQicqgOmf
	M0XhR6p7Cmihsq13fG0X3f4YhA5wPIEMlN+e1Lw==
X-Google-Smtp-Source: AGHT+IGv6A+Jvq5qXGGZlhBiT6kH3Hocefmej6BKU9IfabM1utn/i4BDA8eKXllX2J8OtuMkFc0U3A==
X-Received: by 2002:a05:6a20:2587:b0:249:ba7b:e361 with SMTP id adf61e73a8af0-32b620e88dcmr1283789637.49.1759445647527;
        Thu, 02 Oct 2025 15:54:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb281bsm3117137b3a.37.2025.10.02.15.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:54:07 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 11/12] selftests/bpf: Remove test_task_storage_map_stress_lookup
Date: Thu,  2 Oct 2025 15:53:50 -0700
Message-ID: <20251002225356.1505480-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002225356.1505480-1-ameryhung@gmail.com>
References: <20251002225356.1505480-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a test in test_maps that checks if the updating of the percpu
counter in task local storage map is preemption safe as the percpu
counter is now removed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/map_tests/task_storage_map.c          | 128 ------------------
 .../bpf/progs/read_bpf_task_storage_busy.c    |  38 ------
 2 files changed, 166 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/map_tests/task_storage_map.c
 delete mode 100644 tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c

diff --git a/tools/testing/selftests/bpf/map_tests/task_storage_map.c b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
deleted file mode 100644
index a4121d2248ac..000000000000
--- a/tools/testing/selftests/bpf/map_tests/task_storage_map.c
+++ /dev/null
@@ -1,128 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
-#define _GNU_SOURCE
-#include <sched.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <errno.h>
-#include <string.h>
-#include <pthread.h>
-
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "bpf_util.h"
-#include "test_maps.h"
-#include "task_local_storage_helpers.h"
-#include "read_bpf_task_storage_busy.skel.h"
-
-struct lookup_ctx {
-	bool start;
-	bool stop;
-	int pid_fd;
-	int map_fd;
-	int loop;
-};
-
-static void *lookup_fn(void *arg)
-{
-	struct lookup_ctx *ctx = arg;
-	long value;
-	int i = 0;
-
-	while (!ctx->start)
-		usleep(1);
-
-	while (!ctx->stop && i++ < ctx->loop)
-		bpf_map_lookup_elem(ctx->map_fd, &ctx->pid_fd, &value);
-	return NULL;
-}
-
-static void abort_lookup(struct lookup_ctx *ctx, pthread_t *tids, unsigned int nr)
-{
-	unsigned int i;
-
-	ctx->stop = true;
-	ctx->start = true;
-	for (i = 0; i < nr; i++)
-		pthread_join(tids[i], NULL);
-}
-
-void test_task_storage_map_stress_lookup(void)
-{
-#define MAX_NR_THREAD 4096
-	unsigned int i, nr = 256, loop = 8192, cpu = 0;
-	struct read_bpf_task_storage_busy *skel;
-	pthread_t tids[MAX_NR_THREAD];
-	struct lookup_ctx ctx;
-	cpu_set_t old, new;
-	const char *cfg;
-	int err;
-
-	cfg = getenv("TASK_STORAGE_MAP_NR_THREAD");
-	if (cfg) {
-		nr = atoi(cfg);
-		if (nr > MAX_NR_THREAD)
-			nr = MAX_NR_THREAD;
-	}
-	cfg = getenv("TASK_STORAGE_MAP_NR_LOOP");
-	if (cfg)
-		loop = atoi(cfg);
-	cfg = getenv("TASK_STORAGE_MAP_PIN_CPU");
-	if (cfg)
-		cpu = atoi(cfg);
-
-	skel = read_bpf_task_storage_busy__open_and_load();
-	err = libbpf_get_error(skel);
-	CHECK(err, "open_and_load", "error %d\n", err);
-
-	/* Only for a fully preemptible kernel */
-	if (!skel->kconfig->CONFIG_PREEMPTION) {
-		printf("%s SKIP (no CONFIG_PREEMPTION)\n", __func__);
-		read_bpf_task_storage_busy__destroy(skel);
-		skips++;
-		return;
-	}
-
-	/* Save the old affinity setting */
-	sched_getaffinity(getpid(), sizeof(old), &old);
-
-	/* Pinned on a specific CPU */
-	CPU_ZERO(&new);
-	CPU_SET(cpu, &new);
-	sched_setaffinity(getpid(), sizeof(new), &new);
-
-	ctx.start = false;
-	ctx.stop = false;
-	ctx.pid_fd = sys_pidfd_open(getpid(), 0);
-	ctx.map_fd = bpf_map__fd(skel->maps.task);
-	ctx.loop = loop;
-	for (i = 0; i < nr; i++) {
-		err = pthread_create(&tids[i], NULL, lookup_fn, &ctx);
-		if (err) {
-			abort_lookup(&ctx, tids, i);
-			CHECK(err, "pthread_create", "error %d\n", err);
-			goto out;
-		}
-	}
-
-	ctx.start = true;
-	for (i = 0; i < nr; i++)
-		pthread_join(tids[i], NULL);
-
-	skel->bss->pid = getpid();
-	err = read_bpf_task_storage_busy__attach(skel);
-	CHECK(err, "attach", "error %d\n", err);
-
-	/* Trigger program */
-	sys_gettid();
-	skel->bss->pid = 0;
-
-	CHECK(skel->bss->busy != 0, "bad bpf_task_storage_busy", "got %d\n", skel->bss->busy);
-out:
-	read_bpf_task_storage_busy__destroy(skel);
-	/* Restore affinity setting */
-	sched_setaffinity(getpid(), sizeof(old), &old);
-	printf("%s:PASS\n", __func__);
-}
diff --git a/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c b/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
deleted file mode 100644
index 69da05bb6c63..000000000000
--- a/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-extern bool CONFIG_PREEMPTION __kconfig __weak;
-extern const int bpf_task_storage_busy __ksym;
-
-char _license[] SEC("license") = "GPL";
-
-int pid = 0;
-int busy = 0;
-
-struct {
-	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
-	__uint(map_flags, BPF_F_NO_PREALLOC);
-	__type(key, int);
-	__type(value, long);
-} task SEC(".maps");
-
-SEC("raw_tp/sys_enter")
-int BPF_PROG(read_bpf_task_storage_busy)
-{
-	int *value;
-
-	if (!CONFIG_PREEMPTION)
-		return 0;
-
-	if (bpf_get_current_pid_tgid() >> 32 != pid)
-		return 0;
-
-	value = bpf_this_cpu_ptr(&bpf_task_storage_busy);
-	if (value)
-		busy = *value;
-
-	return 0;
-}
-- 
2.47.3


