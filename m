Return-Path: <netdev+bounces-247593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B36A4CFC369
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 07:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23D5C3077454
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 06:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD3127510B;
	Wed,  7 Jan 2026 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNCB4OIB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13A5274652
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768282; cv=none; b=bNMmdD+oeVuwYXC+n05Pinn6jPiqvRcvvA61c4FKFy6gCvgnXXo2JyAHVgVa/fs/5QNFQRuYFNj0/hwdS4G901kwmW3vxp0ZfqH/oadct2OIsIuT+GDFwzWr9Y1dPQqDTHvy8LGkwfHuganKLTN7PdOQxWUv/RcxQ8noudjj8kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768282; c=relaxed/simple;
	bh=Sdw4L0/f+9bOJgVp2ygjRzjO2Tv4jyY7wvq3smW/QB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfOT3ABnFc4MFVhbwaIblleJK8kW0q0F3X4a/LO+EbXxCRSOBc936OabN+EUJA9s0DroHhTzxoAIiMYLEFBxv8X4B5zVqC9aJhXcZ+8XdDHKgwOdol7fkDMiFUcmPZb6uKj6YVBCNAAGxVfwLnchwfvyX7vNDKkFWOo5eLxjhWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNCB4OIB; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78c6a53187dso16272557b3.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 22:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768280; x=1768373080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQDASkcIUkEroCZV//8nWKbw5U27O0xyAZ07smAcNKo=;
        b=mNCB4OIBCahqEKCMjToPO4K5s4kpTgTnZ+apMI3lC3nlaVRrp07SZ/5IQcT+Gpukkd
         FGbrAR2PzINBnF2JWTSFpqshrnz9gxQVObBvBs01CGSB1M8Rt7shnWt9UdV5ADd3wrQ5
         3/3Zsczyrpi9U6hELqBzaDb/E/f2rp3CueGVDWlvLpUYUv21YMFXNM7PMKQK5cqIrlrf
         a75Eodnnp2+erWjR2lXl5UrQYWo//D74/FJKrhXGYgd0mqCpZFC2cigd/vzPKCPyTBdg
         js26BFulBq6c97WN2SL56P44lYN6jSdvOBfp4ZImdJJ1+HBJt4eXm7dJTGYbm8ZwSUJ6
         FVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768280; x=1768373080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQDASkcIUkEroCZV//8nWKbw5U27O0xyAZ07smAcNKo=;
        b=afyr0VmY7ypzTyyxCMSKQbtVSal2ZBXWINJGIwwlJJCe01hrOVnCf4pbC5OY75ZDbt
         /YmTGnDv6/D9TyqxC/2SiFeldJBLAXzKDAaqUbMgeTCiMqeWqpOx9PvctDxsEqmS5UJ6
         8Iw330t8rx8SETyqiF+eHalIc0L3niQRSo76ygDCGfRkfIo8ccrQcYnUMwwzM916xIN6
         sWdC+4I0vWGxxBnrW0B7XjDqgx/K61VN5o4lznnSq8XPieSuY18A6DUFfIqwLsajTLyG
         SEkm0Iex8EiXpJ8GDujtr7BACp/KTREpPMf0Sf/erQfqIdqcQKMuYzdtoqSHvCyrqppC
         QRVw==
X-Forwarded-Encrypted: i=1; AJvYcCUmapjN966NaZrEg1UEIx6XC60nRYo/SXkkfmJAsF7grF/lX4EcCaOLJfT728Qh3IAIrt+9wAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNu8KquyH7qrdZ+QtK8scjgnHh28lZNBkjL1w8AKfjwP5LNxB
	j08qfm1oVq9dr++2f3Q75m3sRCxyW2wSMVxOz4nyf3t+f5zepR8JM7ep
X-Gm-Gg: AY/fxX755TfhbfR/J3/WSLtckgAdPDJHsQXiBs1s7fXPYNHe/EBz6apoNY/jVKjlJHp
	FnzXDmRJHrHn4kWD1u7CBUDg7gsV+WkzR1FLkZ7xe09WmgYOxGxCE6uJYkq0qgdjGd3japmAYUP
	Hcy/t2Q+Qwiyx8w+LvartZ2+NsI5E5ugHVWbyFQAmni8E0g+YEEt5t75QfWlIM4PVnS9kWdt6vT
	iWGS/EXYWrtojeTVou2+o7b3j143B5fpboRL1+GxV8NyPW53PYp+9kt0kFw0E7d9eWKYpHa57tB
	1ILpyVOMlP7O9GksPDFquhS4dPp5xtw5S7m35dtTl97F4SThp8Az39u8DP6ZPieZTOgjsRYdIoG
	+GiU/bQOfcP+4dBiSvv5tO9B2zXV6e5SPeOKJHhw2s1Mx3D1wpkRgi5zVhMlaxOg6E8ZofNDnHO
	plZDsk7hQ=
X-Google-Smtp-Source: AGHT+IEYbAJN2zDEdJ4wR6Exhr9eYMufUcV3fos/4HPG3TLaZ6izLosvDABjzLd25Bx5/62Rx2G7Fg==
X-Received: by 2002:a05:690c:6712:b0:78f:858b:95a5 with SMTP id 00721157ae682-790b55ed7fbmr17319057b3.27.1767768279756;
        Tue, 06 Jan 2026 22:44:39 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:44:39 -0800 (PST)
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
Subject: [PATCH bpf-next v7 03/11] bpf: change prototype of bpf_session_{cookie,is_return}
Date: Wed,  7 Jan 2026 14:43:44 +0800
Message-ID: <20260107064352.291069-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107064352.291069-1-dongml2@chinatelecom.cn>
References: <20260107064352.291069-1-dongml2@chinatelecom.cn>
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
index 6b58f9a4dc92..736b32cf2195 100644
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


