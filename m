Return-Path: <netdev+bounces-277641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF7UCh6q2WnGrwgAu9opvQ
	(envelope-from <netdev+bounces-277641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:55:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B483DDEAC
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 114A130364B9
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF5E282F16;
	Sat, 11 Apr 2026 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZLK//Kr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EFF24BBF0
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775872463; cv=none; b=ewHKOv8M0jU9dEB6LtxdmmOI+FVEoq/QxzkzuVoJ3XalnwJ6Hnm3Y18XjzYy2tXxgT1e2LZrOEKuoHag+VGfrwW3Oawcc/x5I8RVw0Weu5MYFlvUVgmEihwhT3PWjcJebqrBVfdKJiKPTs8aR2LKpX4ISkcSHAKrxXNtp42pgEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775872463; c=relaxed/simple;
	bh=SudG+jDJunOsI/OEMque3c7RwjkfU8QMeUquLEG2qAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUYgLWF4iHDnRacscHKD+4vuuw7Z5kZNUsl5i1Ekd9ADQPtPvDIXUP9tjMdJTFIZ2gf2VsjO+w45MaqGQcxu9W/Mv54GUQI5PCytDVZ9XLedUg5lQcSO3u4I80D+DAG+jPxVrFjToNdd6iBN73+WonnYwt+kTFkBbq87E+8yoKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZLK//Kr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2503753efso22323685ad.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775872462; x=1776477262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6+ORxmBxUJDC+8lFcSXAEheocoFoy9EPciA5CoKp8Y=;
        b=bZLK//Kr03FTFNLQsZWxuVvvhzkGb16SeRv1kX0HPT0UA51pwK5Q4ymFSl7/MqPjQW
         8vjv1KDZ3JqDe8AwO9w8AYFqnUcmu78vDz1C89+HUEW5XVGSyg0xlh2uPLGoLrdIxNpu
         WXBmV5kXf0VvxDIKERPfzzAonBhnDprx0df6L3xFjG3jDc7F+ltUZSm9rFtFxwC1a/zG
         E0GLeYZmbvJac804c4ReC/ULOv6J+E+1E0sObDz40v54pxc9KxQNhpwfKUfCD1Wea/2A
         YyXL7WwV8KvvgE2YSoIOkpKDPJoQE4FGu8Q14MWojFzKVzkekBCbSYv3NkDQos42P5h0
         agiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775872462; x=1776477262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6+ORxmBxUJDC+8lFcSXAEheocoFoy9EPciA5CoKp8Y=;
        b=gDMBL4DeSLjP+G7mps6u6wvYSQKboIdNXmC9boFYgUaAsP/t79j2n4nQ1eYOYv/lj+
         XyHS8sXDN/dbsMD/83mmU/wkhx5etbI0guXSVU6S6HSATP5Mebb05uG2D0hBK60/Cpn9
         EMP5S/tWTywVUjFGsnsdnMOdzavOfKRGXNM87Q+XXR+BWYvjSf2VC0pYsGGAa7gWZlx7
         onyalKDksFjomBY9Ms0pel5yc3yW8JT2ZRM3SrKwUebVoRbwataIcKwhn1Zbmd+/WnOu
         mY7fd6s+BzbKMHsbeEkSjI2Qr1QNgKVJSdtYhwvvknD05k6YgJ9dA3URHG+EE5iln1NV
         pCqg==
X-Gm-Message-State: AOJu0YxVaAcaBGCD4MBRC1zwMSokimQw5dqsCd8XJbc2JgU9rfkoZvxZ
	invlF7ogZdNCw/nNfkBB1LGO/vYXHyycMPTT+8x6fdbBjgAb0eNjLMCK
X-Gm-Gg: AeBDievzv9wtbx4kCTKdxh6q4/vGJYFQgJ55DQ3VHx7UXtZOZ5MuwUfBZZSqJ9knQJ1
	piSu1j/knNUANEuoZftyi+VB2R7tgXIwizFlXpR94rQrgdqY8f60+xecy3PqLQBTrIynKnRZWHY
	4ei3O6L76gy7W4Yo4X5UHjbTllrmE235qatPYqKMnGRGeWx+L1yT8GiUkeGEN6VMyZnEJhS5geO
	m68X3CeICy1/OBXWKPGXZN4GmaW3Q1TAHrPVhEbQA0jNsrBiwyf5+SRrYKDVTOsJ6bwb1wSV9iE
	h4Hg/Z9WjnjVcn/dAPy1B5E7AVG/o7B3fWJwDO7qKW7x61hR90os+0BgQ+XmN9a88MN+ig+x+zg
	x02KKsQCB0BIoh/GXdCi7qPfTxN6/S/YU+qzwow0Lf50pvU8sRsAjY+e24bbpX6Gi6wwcmy1ACd
	k9cJ0xRdNwCXt82Q==
X-Received: by 2002:a17:902:cf04:b0:2b0:5b4e:370c with SMTP id d9443c01a7336-2b2d5a5d686mr62852115ad.32.1775872461485;
        Fri, 10 Apr 2026 18:54:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dd5cfasm53672975ad.18.2026.04.10.18.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:54:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: Remove kmalloc tracing from local storage create bench
Date: Fri, 10 Apr 2026 18:54:16 -0700
Message-ID: <20260411015419.114016-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260411015419.114016-1-ameryhung@gmail.com>
References: <20260411015419.114016-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-277641-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9B483DDEAC
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


