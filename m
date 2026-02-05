Return-Path: <netdev+bounces-257004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E2ZHORAhGng1wMAu9opvQ
	(envelope-from <netdev+bounces-257004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:04:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DD1EF3D1
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1B6D3019315
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B5D35DD13;
	Thu,  5 Feb 2026 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnXpJV8/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977D035DD12
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274947; cv=none; b=QPIanm6v7Y3HbELKzflQj1Mf/2kfxl/FG6s/fYVl+ssHvtJh1qEDN227oF/S6wFBbs0LHMwNKFl3FpdXfA5X0wl9RF5mq14DBAqKobQ14lvscGrTax4OgUMt2eeOLhsK4z4HXgyO9nJSh/1HPgKUUa6FDKtLINkSJp+fgOdxhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274947; c=relaxed/simple;
	bh=ccp3EztJlEJzQLmiEu1DIzpJsXT5LIfKYR2G67v0qAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBTjLtOMwH0IWEJ5KFrLAIZyl6MvANSPACi8Nv20Kfgjg824aR5V7xbkb+WnH1YpHPFoyS2GGGwAdDpU/4jc6jUdjGAboUua3OQv3SX3neKuNLTQ8M1hl3iyR+16U90SsHEOmIwHe2K1dSv2o7tygA+23E/KyVB+1UfQgbX21jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnXpJV8/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c635559e1c3so308588a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274947; x=1770879747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dhstHRDqQgEPx9WkzXkwbtwT/zsNcRbIl8bglWWgQI=;
        b=WnXpJV8/caJc8pfCmOynKPnZcu1aAXMMqY6NpGHFsdLzENReub49epW7WrdlyyqIuM
         NjlCuEMEV54kzMHPGF2p/nDNFxrLZNy7ygZNzmNG/mpqdGSg9Z0Uy6vTSAeO9OMCe+vO
         /X1q8gUqAPxrb6I4qHH9I/fIJz1R0gOlEe9HMKlV8hZe+MY2xkL25FiF5xtVbj4p833y
         mwcK3+GHrYIgAfZFOOg6LzuRJhkYuKZ84aul4ktIWjN1JbiA8rRyOAkTl6IZxc3YoaO1
         XBd1pTbrCiKZfThFwIZoMPqeJah93vuic9QGCtiW2LQQr3/CIN1vRONdpVoGjP482mSl
         cuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274947; x=1770879747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6dhstHRDqQgEPx9WkzXkwbtwT/zsNcRbIl8bglWWgQI=;
        b=FNR1qcy2ER+NYtearAh8G76GU0n9tRwDP8oYKLaqYMyGvjsB7likm404NScpmph0VR
         aCtwxmmszxxCcIr+G/OWuYhQsOpZaxYSOUkyc8VTziYmjubZPoEbGLquX4HQGQx7ytyf
         1mT94rtEBZ6d02ndEaK9B/GzaZOMV9uEKpE0Bp1EfHbD6lq/6vjFG2AEclwMpqOu40j9
         56O46N5ReVXiVZPW2VfU4PW+foShhYmmn5rb8VJ6kF4RspdzUY5j3OI2rQW7Zd8hRmFP
         Ap6MW/s6te6fsiQhxoK/Znwc+mJ1+WkLJFrP1T2cp8Qvic3mnUXWDObSh5ZojI+xRg/v
         CKnQ==
X-Gm-Message-State: AOJu0Yx+NHsNuwAMpVx6rKyW+t0Nd1LW4kqGZzCKLHW61VhE1kFPdv64
	U22fk+bd6+b3Smkh0jxMY4uyH78f+NvU9Gr94rT0M2zXY2e0fu8WlTCy
X-Gm-Gg: AZuq6aIDt/MfvGJE2x4WjBeEVe1oHt5mf1E+0RHtR6DxeBdwG7ImJDj5OkH2CarFGbZ
	lYfWFzcW6C6+FVycuZjGHd76YvzobJhduGKg90P7dhyhg3IxBcUDGbWD3KdZj8bXYeY1qie2mk9
	guf9RfrkqhkInSiqqOeTLMp2fe825RqD5FBWIZgGLQ34WBPtaYT0iPvSSOevBs8nyN1WSc7Q5kn
	+xuPL/6kCnewuXTq8SN3nT2VU8Yu+nLdohVwcuTq/hWX0bsdh2jnYgHJtGeayC/R32W7qoMdHFD
	RjiR1eL+d49yxUIntW0olu85RM5g0Lg8we0c3IC9Qj+r3yHulwPoNjrxJhvWTT5HAOQ9cPnbwq4
	b07bgRI2jM7MT9702iHFVpMoWZVJlxX0hMXmqf7wcLXuZxOjRs2C3xTMkNBlt/rsAcvmSCVc/5/
	kGsg==
X-Received: by 2002:a05:6a20:43ac:b0:35f:14ae:4a7a with SMTP id adf61e73a8af0-3938f98a77fmr1973210637.13.1770274946873;
        Wed, 04 Feb 2026 23:02:26 -0800 (PST)
Received: from localhost ([2a03:2880:ff:19::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c8506377esm4175968a12.25.2026.02.04.23.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:26 -0800 (PST)
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
Subject: [PATCH bpf-next v6 15/17] selftests/bpf: Remove test_task_storage_map_stress_lookup
Date: Wed,  4 Feb 2026 23:02:04 -0800
Message-ID: <20260205070208.186382-16-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257004-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59DD1EF3D1
X-Rspamd-Action: no action

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


