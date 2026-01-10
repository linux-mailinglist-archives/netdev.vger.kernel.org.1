Return-Path: <netdev+bounces-248692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3617FD0D711
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9183C301E935
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007B23469F0;
	Sat, 10 Jan 2026 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLfJvHwu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D192346794
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054324; cv=none; b=ru45YrzIILIt98ZY+BbivG81etr0WwN+p1I84DdRENfj9R7ltm3ytylJAPDKmQBZhrrNOIayNKVSDzCZPbTDcseGZQhdGRnqTTLUHfEyWMs33kjv38Fhq8VsW0sfLw+hVBzGcGhprs8ypsFu1dGTzVdbNBIX3bEXFlFV1iTja7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054324; c=relaxed/simple;
	bh=z1FXtwKIRsZptJAyDyFFIRDl2UKWJMd6LDExUnxO6es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVWqlblzXq81+jaCpg3FC/KGdVXqb02mM9VORMRepQhAdLgjw2uaSMA7CKQCgRCIc2CAepSb9uMNkbfxoKfccgRPA2T69fmYzoPtAbzvH0LjEnwXl0A5d22Hs3v95cVUkA5zQWXk91tgfeRa7wSG4Q2xpYnMlppUbvVxgDSmwCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLfJvHwu; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so7914b3a.1
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 06:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054323; x=1768659123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfGdp4s1hudLP6FKv2EKIaTufWaeCLX1APZrG5rR5Yg=;
        b=VLfJvHwuVzL8rMClvJO4I5YzXw56cMFux6mA6esQenvUKdNhEMuGcaVtTSzlm8PDgz
         0zU9L5jMuaEMSppIGRu1lPCH+TTRRhG+MNukGOR2VXJLddLd0V9dzx36TDfbKOCEdGa4
         6emDqiGEsIWX610qkSHRpYc6NrAPR4NnkupB3d6MeUMRzgrB7ES9yM80vxaXvjoO+6Cv
         yrX2oHQxjat6APAbYiCUovf/5Aa1N4JYrzyBzwwziU9xLhfVbWG5dI9Hq5DVRcXBRCSq
         vo5IUaMAp4bvFCeNEcwU2/AAGlgUMg7xX2hiHzzUSjgChqNowuJiK1JnuncJtEAz4rr6
         fYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054323; x=1768659123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfGdp4s1hudLP6FKv2EKIaTufWaeCLX1APZrG5rR5Yg=;
        b=MejV+6D+LA+nyRAI6GEvhsjgEQniDv9UbrPmnD5Dhe7v1mfusl0uK7xRlYzTMNqgmz
         lrb8Gw0SUBGxDKnniOe7DJpCEYfSePQzeEAcMMdop14AZwmOgwPQ6A70jA5ek83YDbKq
         uEzGpyB25Ew5rqmrOViMr3fhIP2WPc9b0axnbEN0pVPHt/fdeeRyYy7XCr7ELE1FLKPI
         PsDnrAJtxFAmT2tTM9EaWahyYtDc5qIg2y8TNox5fxpho9SAuVnl9i38hr7jzhDfsnnE
         GVDVD8ws26hqSoq30AqyePRFnwVV5SVrtPF4UcN6y3b5GLI4NTUyowF02+dpjLpgfa0p
         fTpA==
X-Forwarded-Encrypted: i=1; AJvYcCX1rOaqubbFnn3eqw0vgm0iNql4NRZSJKzUZwZ2LV1l0VQUn2yHdfmOmgw0mRYwGsA/W+mVa3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykg/nIXY/gkoiBflMiz1VVKhDkuwXGfWtjlvZdwirN754nQNTi
	j4gGvrZM5ZIbHKp7OcjYIzeqxTG0naWcNfrC3JrtY3s1fUpiQRcapKd4
X-Gm-Gg: AY/fxX5ZlMphDPZFHWw12yrTokniGMSfht552bdTkkwmT7bJoZyl/8+U1r43aJQCzKL
	XAsiAe6vJim4BsgNt6rIqo8ud/ZfD+hBEXvu5a/LdwZ7Jzmf3vXdtYA+/wzz7qyUe+751XqlpK6
	S/7AE9uQsZcUC2QlG2lWB5LivSNPLGp6fNr/Qm06pw8MhKWCKpZwG6yi2eHMRju2bS/pI8goPJu
	R8XINLTUB1dGOQDmL0F5h9VyTa7SNqzPyYVOJccC7+w3XyOaKnfZ3omK6po0fFZhwnUfr2ZfWie
	/yOWwf8bMHqb7sjkIBlQYu8XwmYe5LsNsrLwhG9pgDIyRDCyLjaW+7nQHyan9msBJnX9eicqKht
	Naen4U4+cqpMoeT/4weTgpCdjHPTkl2tOv3GQlUWzmjbLFXXHIYVe7xiAO4/2+D0fD4xrfzf/pk
	XtQ3qOwhY=
X-Google-Smtp-Source: AGHT+IHFsjOI9vY+1n9I9bmJ5B1pg0vIMAkiVFjV3qYORsRqw9CiS1Ot3VqYNtj2DaTbLEq8lAlYZQ==
X-Received: by 2002:a05:6a00:4305:b0:7b9:7f18:c716 with SMTP id d2e1a72fcca58-81b7eb28136mr12520935b3a.1.1768054322695;
        Sat, 10 Jan 2026 06:12:02 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:12:02 -0800 (PST)
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
Subject: [PATCH bpf-next v9 03/11] bpf: change prototype of bpf_session_{cookie,is_return}
Date: Sat, 10 Jan 2026 22:11:07 +0800
Message-ID: <20260110141115.537055-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110141115.537055-1-dongml2@chinatelecom.cn>
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the function argument of "void *ctx" to bpf_session_cookie() and
bpf_session_is_return(), which is a preparation of the next patch.

The two kfunc is seldom used now, so it will not introduce much effect
to change their function prototype.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/bpf_trace.c                             |  4 ++--
 tools/testing/selftests/bpf/bpf_kfuncs.h             |  4 ++--
 .../bpf/progs/kprobe_multi_session_cookie.c          | 12 ++++++------
 .../selftests/bpf/progs/uprobe_multi_session.c       |  4 ++--
 .../bpf/progs/uprobe_multi_session_cookie.c          | 12 ++++++------
 .../bpf/progs/uprobe_multi_session_recursive.c       |  8 ++++----
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 5f621f0403f8..297dcafb2c55 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3316,7 +3316,7 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 
 __bpf_kfunc_start_defs();
 
-__bpf_kfunc bool bpf_session_is_return(void)
+__bpf_kfunc bool bpf_session_is_return(void *ctx)
 {
 	struct bpf_session_run_ctx *session_ctx;
 
@@ -3324,7 +3324,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
 	return session_ctx->is_return;
 }
 
-__bpf_kfunc __u64 *bpf_session_cookie(void)
+__bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
 {
 	struct bpf_session_run_ctx *session_ctx;
 
diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index e0189254bb6e..dc495cb4c22e 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -79,8 +79,8 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
 
-extern bool bpf_session_is_return(void) __ksym __weak;
-extern __u64 *bpf_session_cookie(void) __ksym __weak;
+extern bool bpf_session_is_return(void *ctx) __ksym __weak;
+extern __u64 *bpf_session_cookie(void *ctx) __ksym __weak;
 
 struct dentry;
 /* Description
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
index 0835b5edf685..4981d29e3907 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session_cookie.c
@@ -23,16 +23,16 @@ int BPF_PROG(trigger)
 	return 0;
 }
 
-static int check_cookie(__u64 val, __u64 *result)
+static int check_cookie(struct pt_regs *ctx, __u64 val, __u64 *result)
 {
 	__u64 *cookie;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
 
-	cookie = bpf_session_cookie();
+	cookie = bpf_session_cookie(ctx);
 
-	if (bpf_session_is_return())
+	if (bpf_session_is_return(ctx))
 		*result = *cookie == val ? val : 0;
 	else
 		*cookie = val;
@@ -42,17 +42,17 @@ static int check_cookie(__u64 val, __u64 *result)
 SEC("kprobe.session/bpf_fentry_test1")
 int test_kprobe_1(struct pt_regs *ctx)
 {
-	return check_cookie(1, &test_kprobe_1_result);
+	return check_cookie(ctx, 1, &test_kprobe_1_result);
 }
 
 SEC("kprobe.session/bpf_fentry_test1")
 int test_kprobe_2(struct pt_regs *ctx)
 {
-	return check_cookie(2, &test_kprobe_2_result);
+	return check_cookie(ctx, 2, &test_kprobe_2_result);
 }
 
 SEC("kprobe.session/bpf_fentry_test1")
 int test_kprobe_3(struct pt_regs *ctx)
 {
-	return check_cookie(3, &test_kprobe_3_result);
+	return check_cookie(ctx, 3, &test_kprobe_3_result);
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
index 30bff90b68dc..a06c2d7ec022 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
@@ -51,7 +51,7 @@ static int uprobe_multi_check(void *ctx, bool is_return)
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_*")
 int uprobe(struct pt_regs *ctx)
 {
-	return uprobe_multi_check(ctx, bpf_session_is_return());
+	return uprobe_multi_check(ctx, bpf_session_is_return(ctx));
 }
 
 static __always_inline bool verify_sleepable_user_copy(void)
@@ -67,5 +67,5 @@ int uprobe_sleepable(struct pt_regs *ctx)
 {
 	if (verify_sleepable_user_copy())
 		uprobe_multi_sleep_result++;
-	return uprobe_multi_check(ctx, bpf_session_is_return());
+	return uprobe_multi_check(ctx, bpf_session_is_return(ctx));
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
index 5befdf944dc6..d916d5017233 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_cookie.c
@@ -13,16 +13,16 @@ __u64 test_uprobe_1_result = 0;
 __u64 test_uprobe_2_result = 0;
 __u64 test_uprobe_3_result = 0;
 
-static int check_cookie(__u64 val, __u64 *result)
+static int check_cookie(struct pt_regs *ctx, __u64 val, __u64 *result)
 {
 	__u64 *cookie;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
 
-	cookie = bpf_session_cookie();
+	cookie = bpf_session_cookie(ctx);
 
-	if (bpf_session_is_return())
+	if (bpf_session_is_return(ctx))
 		*result = *cookie == val ? val : 0;
 	else
 		*cookie = val;
@@ -32,17 +32,17 @@ static int check_cookie(__u64 val, __u64 *result)
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_1")
 int uprobe_1(struct pt_regs *ctx)
 {
-	return check_cookie(1, &test_uprobe_1_result);
+	return check_cookie(ctx, 1, &test_uprobe_1_result);
 }
 
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_2")
 int uprobe_2(struct pt_regs *ctx)
 {
-	return check_cookie(2, &test_uprobe_2_result);
+	return check_cookie(ctx, 2, &test_uprobe_2_result);
 }
 
 SEC("uprobe.session//proc/self/exe:uprobe_multi_func_3")
 int uprobe_3(struct pt_regs *ctx)
 {
-	return check_cookie(3, &test_uprobe_3_result);
+	return check_cookie(ctx, 3, &test_uprobe_3_result);
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
index 8fbcd69fae22..d3d682512b69 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
@@ -16,11 +16,11 @@ int idx_return = 0;
 __u64 test_uprobe_cookie_entry[6];
 __u64 test_uprobe_cookie_return[3];
 
-static int check_cookie(void)
+static int check_cookie(struct pt_regs *ctx)
 {
-	__u64 *cookie = bpf_session_cookie();
+	__u64 *cookie = bpf_session_cookie(ctx);
 
-	if (bpf_session_is_return()) {
+	if (bpf_session_is_return(ctx)) {
 		if (idx_return >= ARRAY_SIZE(test_uprobe_cookie_return))
 			return 1;
 		test_uprobe_cookie_return[idx_return++] = *cookie;
@@ -40,5 +40,5 @@ int uprobe_recursive(struct pt_regs *ctx)
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 1;
 
-	return check_cookie();
+	return check_cookie(ctx);
 }
-- 
2.52.0


