Return-Path: <netdev+bounces-248691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ED8D0D705
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAA73300D17A
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 14:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18483469E3;
	Sat, 10 Jan 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajndF/ju"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72D346794
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054313; cv=none; b=KEWhTzJ2Kb9dI5t54sbVmIO6oqhSYJVVnRoHNJsrLjJ63clfltRyzd3Pt59OXz7g5fLsxRtbNYUy9geIzykb0yrxTTiDHyQV/t1XI6bR94tbiyxiabH8ZUK90TKNU10zFqoEBLlwwoh27ryjz7bSzc67Cn6H5SULSt1Ma41b40Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054313; c=relaxed/simple;
	bh=VhBBi66SFeKXbV7OJrrw4WoyPdDGNe3BKHOh9sdreXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAvsK9ByA6sKOeRNGLnaGNlYHqox01N1NEiM0Hibet24AbqvOwoi/OHJ1ik6iZpKo5XS2tbfucndMnc4JAi/KO7jsKPN9OEgM7whrzd2IXSTmlKvYCagPPOJRV7yaGqFOjtCN+rnR8kKRzhQPaepD4+naNqgChMcq45bP2DksUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajndF/ju; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81f39438187so316958b3a.2
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 06:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054312; x=1768659112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjkgpIcKhjQZAa0EelYk21O9foZl8TfKrOJc4gFivFo=;
        b=ajndF/juubjoXgwPw1K/ojOEDD0b+S/fG1O6tRtBcbyT2GoMRVvgCZwVkVlrD7xeCj
         Vol8PTdD13a+ZR5VE3wjMQ2b8H+qGVpJw+gx5O0ooLNmg8/d90atIunlRyOQ0RYpq3dA
         KDu01ut0hybmtRbKy3knnl4NgfqpGz3cbvKc9C/5Uw1ezeQe1Oy5zwdmh9PqiuTl3Tqa
         xg3bUqI6nTh1dwNfTdg9M5Z41dPNUgEBKl/zv7OzJ4qrmSwI0UQjeaz0BHiS5feKEcPK
         AIHArv0dnkviIflK/1UlRZu+e1IJB02MxG29wVXPcvSWV4tOyfrXQ2YU1N91AeXG2/w9
         /06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054312; x=1768659112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rjkgpIcKhjQZAa0EelYk21O9foZl8TfKrOJc4gFivFo=;
        b=NOv4IV9aB1rLlq+NIfeXQHUS6P++YlA38peJemKOysusllndJCeE25xLchLybWJRO0
         00GqdJ643AnNWE9ESiCtbgUHUCfSYTFtdLBnisRJqrdX5PwSUv5H9q7qJE/7XWcedPYv
         A/wu7YuOtWvAm1rf4ai+BZuPjdswln/KlWpger6a8phxzFksjkyKKk14Hh1fwI1O7/ez
         iphGMYY21PAQK96c7LRSJVMzHVVULA6E2FO7zZvUUyJgTCmqg3aPDWjWT67yObOzhmdb
         eP3Bu8lhZalYipPcst/+19aE5ukX35UzmXBVBXNr2/eY5REVqAtRuCDJgg0L65jev0wV
         Tj5g==
X-Forwarded-Encrypted: i=1; AJvYcCVhaWh0egQLStkQ+g49M4dmBr47jpF/1kDj+HIMnuciJHhDdf6aAvLQEMpbgDYx5VWEbbmc1Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJJQA7gZzcc8audUqevXhBOklEs3/1mzWqTcCs21HT8la57E73
	vJICX4BAoN6PTIYT+mGCfNP1W1HO/yI6ZK9cm3KO9CtMpdrT9y6ktcSQ
X-Gm-Gg: AY/fxX5TvELHxu+nMboSS8pX2Lyfgb+OJifgFAmD1B8gvc54Rbvf0QC3EGX6TJrhzxy
	/kwekbqePPOzomdH6Czm/V8hqudEQiGUa2F6MDbEJwiJEAXIfPiBxHeYDxAheRoDgnSi3Jogu4G
	gOritsNKxGmqF/6ZsOkApBzj0pna9yziGZ/HTtWUCiLlT+vvsFPjDjFdqZcZLY93NaZhHwzjd5q
	roJhMLGobFlXNEbtUFSNCEWqPfZhmZTq5zwgskKoyanNC1Z+hezqnNGQ+xRa9UYD1HNdti2kb8A
	X7XVmGP8Mx6XEDvzlwSf4e03KWso+8v+YwvhN/WpvGYyCiUFnQuBqQdxGD/8AOKLPwQKY1erwR8
	sEAZeb3OtLkKjN3SbbbxsWt6L0cYKrvGV5oEGzJ4PVj2IgHLN0f20RiiO17OqzczUWfLBc901A9
	KOfAGLrdc=
X-Google-Smtp-Source: AGHT+IF03SXJV4ZyzcbP2okOtd6Y9ZpGDEo0yivf5cl39rEI0EE+f2l48zo7+Cf6AdRAzuVFCKfH5g==
X-Received: by 2002:a05:6a00:2f50:b0:81c:717b:9d3b with SMTP id d2e1a72fcca58-81c717ba569mr6481986b3a.47.1768054311673;
        Sat, 10 Jan 2026 06:11:51 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:11:51 -0800 (PST)
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
Subject: [PATCH bpf-next v9 02/11] bpf: use last 8-bits for the nr_args in trampoline
Date: Sat, 10 Jan 2026 22:11:06 +0800
Message-ID: <20260110141115.537055-3-dongml2@chinatelecom.cn>
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

For now, ctx[-1] is used to store the nr_args in the trampoline. However,
1-byte is enough to store such information. Therefore, we use only the
last byte of ctx[-1] to store the nr_args, and reserve the rest for other
usages.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v8:
- fix the missed get_func_arg_cnt
---
 kernel/bpf/verifier.c    | 35 +++++++++++++++++++----------------
 kernel/trace/bpf_trace.c |  6 +++---
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 774c9b0aafa3..bfff3f84fd91 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23277,15 +23277,16 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		    insn->imm == BPF_FUNC_get_func_arg) {
 			/* Load nr_args from ctx - 8 */
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
-			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
-			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
-			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
-			insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
-			insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
-			insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
-			insn_buf[7] = BPF_JMP_A(1);
-			insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
-			cnt = 9;
+			insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+			insn_buf[2] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
+			insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
+			insn_buf[4] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
+			insn_buf[5] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
+			insn_buf[6] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
+			insn_buf[7] = BPF_MOV64_IMM(BPF_REG_0, 0);
+			insn_buf[8] = BPF_JMP_A(1);
+			insn_buf[9] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
+			cnt = 10;
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -23305,12 +23306,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
-				insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
-				insn_buf[2] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
-				insn_buf[3] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
-				insn_buf[4] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
-				insn_buf[5] = BPF_MOV64_IMM(BPF_REG_0, 0);
-				cnt = 6;
+				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+				insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+				insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
+				insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
+				insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
+				insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
+				cnt = 7;
 			} else {
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
 				cnt = 1;
@@ -23331,8 +23333,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
 			/* Load nr_args from ctx - 8 */
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 2);
 			if (!new_prog)
 				return -ENOMEM;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6e076485bf70..5f621f0403f8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1194,7 +1194,7 @@ const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
 BPF_CALL_3(get_func_arg, void *, ctx, u32, n, u64 *, value)
 {
 	/* This helper call is inlined by verifier. */
-	u64 nr_args = ((u64 *)ctx)[-1];
+	u64 nr_args = ((u64 *)ctx)[-1] & 0xFF;
 
 	if ((u64) n >= nr_args)
 		return -EINVAL;
@@ -1214,7 +1214,7 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
 BPF_CALL_2(get_func_ret, void *, ctx, u64 *, value)
 {
 	/* This helper call is inlined by verifier. */
-	u64 nr_args = ((u64 *)ctx)[-1];
+	u64 nr_args = ((u64 *)ctx)[-1] & 0xFF;
 
 	*value = ((u64 *)ctx)[nr_args];
 	return 0;
@@ -1231,7 +1231,7 @@ static const struct bpf_func_proto bpf_get_func_ret_proto = {
 BPF_CALL_1(get_func_arg_cnt, void *, ctx)
 {
 	/* This helper call is inlined by verifier. */
-	return ((u64 *)ctx)[-1];
+	return ((u64 *)ctx)[-1] & 0xFF;
 }
 
 static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
-- 
2.52.0


