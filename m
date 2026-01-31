Return-Path: <netdev+bounces-255359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN/+KLaPfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:14:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 095E9C0B8E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D760B3072DAC
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A133D6CE;
	Sat, 31 Jan 2026 05:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BphYxkxN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F9629DB65
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836180; cv=none; b=kG6/1IxpQk6g5sx0gr6lzgqDlPXoUiHR6ZB222CXLESrgmZwXMeZ3GlmmVgSDL+acaNpF7cyWbAJT8IJJOphMTaMI6s5uzEqgxrTuSJZm8XmPOgA9FHCPz2/MQy7/xZX/iBZ1k3P9/l3x/hHcsyqm0ahgfZkIS+JHNlWgChU0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836180; c=relaxed/simple;
	bh=ccp3EztJlEJzQLmiEu1DIzpJsXT5LIfKYR2G67v0qAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wq9NqZOgeFkyKhJkwECdjEaGCcl0fHos5uFVXR6Ppg7BC89GOC9/kXOnRghhPYVAvDF7o0X/AhehL8LSrBzk1bo95SvrQbye4E081pG9DDU0SJ8QhQYCXCVl2MQE8O+AG5yRiL6/Gnl+qMBUGswH1q/aaxCpfhGCvNl207Pxl4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BphYxkxN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8230c33f477so1244020b3a.2
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836178; x=1770440978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dhstHRDqQgEPx9WkzXkwbtwT/zsNcRbIl8bglWWgQI=;
        b=BphYxkxN5tYLubOHlVgz+rXYiN1QR9Y9F8iGiw4mgegdn3qCctVA5vO5q/dPXky7j4
         mnP6v2Trt/b0bIKdwscQMHt9rGlltnbR3ndZJHHD3fj1F6lJlkmB3+JWvrInR4fxH8Oe
         llmTiWDmK2GFLqbs3pHS2nmW+1ooanT/kbLoqcyhb2v4iTln3edPQId3VVIA9hj4LQSN
         ii+89QjZs7H14LgNvcjTMRwt4mq9XvOkLbdgkXy0z4iQhSAwrRhIwfdyTFzvrrhSysgJ
         H5JaUCE8mjUthkgK17B6mPj+xbfy4AejcVKjyVcDH4xwuMYFjEzKkEeveUm4tWv0+/CD
         yWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836178; x=1770440978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6dhstHRDqQgEPx9WkzXkwbtwT/zsNcRbIl8bglWWgQI=;
        b=VTqw6LgDM8vZWcUnOCiEtYWKoB+YZ434uPspvdZwQnK9rjEN4XyqWl6v2YG6C89rtn
         rGU73NLOCBIFLO7ccRYIOalT86DM1gdR4oYhUdVI4dTLvtNiDdUX4wdsCqyiC5V4VaEw
         MMQmbWXPMphJDXBOV9KTta/F2b6aqGkhBnejl5J0Ra5xDNt9W7Fz/vC2TV5lMIyJRfVk
         ZrEU9ojF/C3/xioW8aBn5XY/Yc6XdvFbiRaLG+ZQB8Bo8r0DBdx3sh07uw81Mv3rhdrQ
         6ix4RfRFxqtF7el6ruI8EHZw5MO6swcHirJ+IRYGrF6H6EYsTam0GK/xD0ClTBjHnimZ
         d1oA==
X-Gm-Message-State: AOJu0YyfCny5eoomnBtrOpcH2EV6lq0VKnpuATPid0h7AMz5lgBvgkL0
	TxvyTX9vTBC5wmzxLP3jh1ZzM2mckcYN8xeohn4315ZOGyqVjNlloZIS
X-Gm-Gg: AZuq6aJBHLJeN2HOiDtgtq3Ns6NLRZFMvOOUJHXp4I5Sqa7E2YdONdczxFc2g3YJznN
	df9qTZJg4HtSromJL9dMoYGtZqShh35Z6A6FA/8ATpwhp5t+kb6LIeFiCF2YOKBBZXDKEgMMFIs
	4vd7AP8R5IAnX1hIfTbKCe7sIzR0Tb4n7OCnXHlXf9VcbOT598Yk6Rtv4Br4EbBvGk+ARjUz2DL
	Upuwe/wSuj1ojlmg6ka3+jDSo3zxb6TPtn1oig6u35clPo7WHCqNY67ZfIuBUlq0o6u0eHYAENV
	JEFwfOvd4d9B2LoTE5ENeg2/6F9ozbQaGoPrnslulThWlmHH3vtibbyLfEcYAlDI1f69ae4FkNc
	+ugOib62OSQErvw/1qu48/2m1UPe42NpLdyp3rT1Mr9WdRvrjtOHC+f3JmIFtCkQ3SC3GytVfrE
	7/xA==
X-Received: by 2002:aa7:9062:0:b0:823:d2c:b155 with SMTP id d2e1a72fcca58-823ab65f04amr5093510b3a.14.1769836178257;
        Fri, 30 Jan 2026 21:09:38 -0800 (PST)
Received: from localhost ([2a03:2880:ff:23::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfcaadsm10653637b3a.37.2026.01.30.21.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:37 -0800 (PST)
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
Subject: [PATCH bpf-next v4 15/16] selftests/bpf: Remove test_task_storage_map_stress_lookup
Date: Fri, 30 Jan 2026 21:09:18 -0800
Message-ID: <20260131050920.2574084-16-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131050920.2574084-1-ameryhung@gmail.com>
References: <20260131050920.2574084-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255359-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 095E9C0B8E
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


