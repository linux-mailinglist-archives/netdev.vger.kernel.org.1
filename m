Return-Path: <netdev+bounces-277623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFxeNxyT2WnxqwgAu9opvQ
	(envelope-from <netdev+bounces-277623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 02:17:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 669463DDB0D
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 02:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84E0A3037F28
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5229285072;
	Sat, 11 Apr 2026 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhzDiyYK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7821A6815
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775866636; cv=none; b=BmnLjkBy6lnixUdSGJyHj3ihxuezGPJYEjqU6aDLCrBDYnkXqDPEb3fPDGnq9f/oW1Do2UgotrwmGs177g0yF/VrzBNdUA9ktiHr79P2Lj/DpayBchqg8u2kAPdnY0QbRhsfCWzwT5cvdytAKkbMTpTWS4FX0AcJxIE4AN6xgWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775866636; c=relaxed/simple;
	bh=SudG+jDJunOsI/OEMque3c7RwjkfU8QMeUquLEG2qAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmEvw8zmqhZ3eXtt6MxRPrN+8OPUBh488Go1vEQ4OTPKBjhGQGxtsSc+o3O3aQ0E3gpqfJxkOx7uBKUVx/1M58hTBCUTpPStz8jnryj3x+V9iiIFLinS0BOurRcvFH34FkGYy5/7Apr8JTxfEBDGs199GkTG2qOaoL6kVprmesQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhzDiyYK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35c1a131946so1570469a91.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 17:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775866635; x=1776471435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6+ORxmBxUJDC+8lFcSXAEheocoFoy9EPciA5CoKp8Y=;
        b=mhzDiyYKgo+/1S3/vLy2la7BlnTm7YkwmJxlcXmUBOfFd7C3CejOZTdkDDO7XQE+Ol
         vX35vwx+MUj2pwcIF2xJYC9tpLUHPQcq9/dLSV0Sc1xU0eFVEbP7RAXWbia+57tyr/xl
         RWAG2hfVmom88ci9lKx8FtEvqmCE70IjmRa744qXSW1j4o7YYSkq44KoqW0+PDVBoCnA
         WmzlS9YCHLZeN3ZApRqCs93C8eQMouIjFZYg+Bj37TWFmWf5O7d2g6clFVjxvVQT69gP
         f7LOSgYNUpziCNVO/VY19LgyqH9U6bo7K5iejtCdHS70CdXsHHVmmYuK0ZRyKnJNnwC3
         07dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775866635; x=1776471435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6+ORxmBxUJDC+8lFcSXAEheocoFoy9EPciA5CoKp8Y=;
        b=e6WcboBV8cPV0+N39bqFfTKlG65SLlv0MfnIDEz1GjyfmBxjlcEikLeepI+MR1Z9VJ
         OWcjdYimOca/N+2CNY42LVSpNOS+mWvadKsuc1r6M4JiHgXlQrj2F/6aGYFzbAVegTuV
         tdD5f47GWKZwLJf1AbSwTXPydPZ4Zx9UknAw3gYZuU5gzQskf3jQV+dhxHodkvr+X4np
         BnAnch6lkGOwtUjB7BXaIqDVwUoS7sgHHA+YQQ6AYxLIoEDqDG2rJSZSO/kl67uRSFqH
         74NPAKOtKRpNWI7g8CzDir2NsA3ugRup0vgCBnIdQJ9KZrTT0oEeRxoh45sx5hB2h7Bt
         F1Rg==
X-Gm-Message-State: AOJu0YwoHB9NbuxZTiWF94Rft+o45f0+RFih8EuMteTuiYPpyQImSfNM
	i9IzR2d+aE8VJpj3XjYM1TAiOVUp1blDDhG1qcbS5ei55k6SkQW95KAt
X-Gm-Gg: AeBDiesC5W1rDgO3bZpcvIgGW4zP3CFdEdtd3USZxsTk+FsCRg1Bn8VaALEkWlKHbsd
	yJDNTC+HuG0vbwQ9Hw+HDoaFAZxbNCRvldnqCnHhlO82H+YHwPfF7d1yLVjFhD1mFOWd/V/x1WM
	nmkZh7qKlR5l86krotC9qdcRtLbJPoZ6K9j/WbFuUhKAQ8g/8ryQ0jmhW+q7tJl38y/OTO4rTcW
	uIuYOpQBVHLaYYysVRRHl5/tLKl15vYI0Khlw5Lcty5vY0M87nnGAS/03/Si5LCp7R9yfP6eq3H
	QaVt45syXaGAkxTtDIQXOyb8Wi3FVEL6tuchfJ0B4bYnwWqWF1ds5rfYEKpvjDgVZCBBNcuQ2Mm
	C8v2rA2y2GbSLEDrjVS0LdhOJ5aJsXyaWUTS7ifB821mDkAGMzVYGXrAel2MqV7g0Kx5PCDJISW
	jwEkpuuN2bkgB7
X-Received: by 2002:a17:90a:fc4e:b0:35d:9fe9:f830 with SMTP id 98e67ed59e1d1-35e430e512cmr3658710a91.12.1775866634931;
        Fri, 10 Apr 2026 17:17:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e35156445sm7729654a91.14.2026.04.10.17.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 17:17:14 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] selftests/bpf: Remove kmalloc tracing from local storage create bench
Date: Fri, 10 Apr 2026 17:17:09 -0700
Message-ID: <20260411001711.3418264-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260411001711.3418264-1-ameryhung@gmail.com>
References: <20260411001711.3418264-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-277623-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 669463DDB0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the raw_tp/kmalloc BPF program and its associated reporting from
the local storage create benchmark. The kmalloc count per create is not
a useful metric as different code paths use different allocators (e.g.
kmalloc_nolock vs kzalloc), introducing noise that makes the number
hard to interpret.

Keep total_creates in the summary output as it is useful for normalizing
perf statistics collected alongside the benchmark.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/benchs/bench_local_storage_create.c   | 21 ++++++-------------
 .../bpf/progs/bench_local_storage_create.c    | 11 ----------
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
index e2ff8ea1cb79..71e38000ee06 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
@@ -101,11 +101,6 @@ static void setup(void)
 		}
 	}
 
-	if (!bpf_program__attach(skel->progs.kmalloc)) {
-		fprintf(stderr, "Error attaching bpf program\n");
-		exit(1);
-	}
-
 	threads = calloc(env.producer_cnt, sizeof(*threads));
 
 	if (!threads) {
@@ -140,7 +135,6 @@ static void setup(void)
 static void measure(struct bench_res *res)
 {
 	res->hits = atomic_swap(&skel->bss->create_cnts, 0);
-	res->drops = atomic_swap(&skel->bss->kmalloc_cnts, 0);
 }
 
 static void *sk_producer(void *input)
@@ -203,28 +197,25 @@ static void *producer(void *input)
 
 static void report_progress(int iter, struct bench_res *res, long delta_ns)
 {
-	double creates_per_sec, kmallocs_per_create;
+	double creates_per_sec;
 
 	creates_per_sec = res->hits / 1000.0 / (delta_ns / 1000000000.0);
-	kmallocs_per_create = (double)res->drops / res->hits;
 
 	printf("Iter %3d (%7.3lfus): ",
 	       iter, (delta_ns - 1000000000) / 1000.0);
-	printf("creates %8.3lfk/s (%7.3lfk/prod), ",
+	printf("creates %8.3lfk/s (%7.3lfk/prod)\n",
 	       creates_per_sec, creates_per_sec / env.producer_cnt);
-	printf("%3.2lf kmallocs/create\n", kmallocs_per_create);
 }
 
 static void report_final(struct bench_res res[], int res_cnt)
 {
 	double creates_mean = 0.0, creates_stddev = 0.0;
-	long total_creates = 0, total_kmallocs = 0;
+	long total_creates = 0;
 	int i;
 
 	for (i = 0; i < res_cnt; i++) {
 		creates_mean += res[i].hits / 1000.0 / (0.0 + res_cnt);
 		total_creates += res[i].hits;
-		total_kmallocs += res[i].drops;
 	}
 
 	if (res_cnt > 1)  {
@@ -234,9 +225,9 @@ static void report_final(struct bench_res res[], int res_cnt)
 				       (res_cnt - 1.0);
 		creates_stddev = sqrt(creates_stddev);
 	}
-	printf("Summary: creates %8.3lf \u00B1 %5.3lfk/s (%7.3lfk/prod), ",
-	       creates_mean, creates_stddev, creates_mean / env.producer_cnt);
-	printf("%4.2lf kmallocs/create\n", (double)total_kmallocs / total_creates);
+	printf("Summary: creates %8.3lf \u00B1 %5.3lfk/s (%7.3lfk/prod), %ld total\n",
+	       creates_mean, creates_stddev, creates_mean / env.producer_cnt,
+	       total_creates);
 	if (create_owner_errs || skel->bss->create_errs)
 		printf("%s() errors %ld create_errs %ld\n",
 		       storage_type == BPF_MAP_TYPE_SK_STORAGE ?
diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
index c8ec0d0368e4..25ca6045fea3 100644
--- a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
@@ -8,7 +8,6 @@
 
 long create_errs = 0;
 long create_cnts = 0;
-long kmalloc_cnts = 0;
 __u32 bench_pid = 0;
 
 struct storage {
@@ -29,16 +28,6 @@ struct {
 	__type(value, struct storage);
 } task_storage_map SEC(".maps");
 
-SEC("raw_tp/kmalloc")
-int BPF_PROG(kmalloc, unsigned long call_site, const void *ptr,
-	     size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags,
-	     int node)
-{
-	__sync_fetch_and_add(&kmalloc_cnts, 1);
-
-	return 0;
-}
-
 SEC("tp_btf/sched_process_fork")
 int BPF_PROG(sched_process_fork, struct task_struct *parent, struct task_struct *child)
 {
-- 
2.52.0


