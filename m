Return-Path: <netdev+bounces-245973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 710FECDC52F
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 14:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2A930A585E
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 13:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E3E33A71E;
	Wed, 24 Dec 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmf0PApH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ABE33A01A
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581701; cv=none; b=uS6yD4tn0yAhPUU8ZaM67hFWmmOq+Um4Uc5YLjVTSNYhMjS3DPyww+Kvk9Y82zn821cb+qhIxkNhUToUii4HKYcQ6k60FHUHC+pSw/hJs9TX5XVXD8b6PedqYham5bL2HDek/T6cRXc9om4NVTziTAutZSgZxIsaOwIFjxcmJKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581701; c=relaxed/simple;
	bh=KfUROJWj+WZRegyU3vO1Susv7TMJMQE38QMpRIDYxrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxZO1aUKK2+/DLBPsdZAnVgfyTGCmyFru8ZWQVuaHu9axdc0i6gqov0VQ6JRvSdWJ6CkVrziW6koR8mYYO+QRSUQIh4Yrgl6PcXZULY8aKgz5WPZG+tP3ACARfbgan+HOHCsMuLZfjqZs+9rvLIpkhTE6JFTLhHGii3uYyYuJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmf0PApH; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso4854369b3a.0
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 05:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766581699; x=1767186499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnD1gjr4XFspTsO3rXAFVOp0yxAXlXjec2rCDPwFC1I=;
        b=dmf0PApHFUenpAGL+cp3Z74EInEEH0wTvP1pfHNPcmLH2Lb6ewS/d3OCY3nhMj7Z06
         8DUPF7oG5LFkDSEk2pkgqUuud4YIR4YTERabEo+weCuZ1aCf8v7AM+tI8O7w44EbrbDp
         XF7LgKLbK8HEzxRBrmeFukbpDzkYrF0PWNH5E6QWLKtBue2+4+MEAqHndqtkHEO1dAvE
         OQ/d6Q1PFbxFcfl3/onk/ADa+CpKW8UhZzLOk+i4rqS3iaB8S6MZmKqDBhg4kpwoobI6
         KXK3sa+srnbN95zg4C/hSVhjZKh5cY+iPBfH1ELUHNppUqASTu2xEdx0FP0rfm/SvNKp
         Hdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581699; x=1767186499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GnD1gjr4XFspTsO3rXAFVOp0yxAXlXjec2rCDPwFC1I=;
        b=uqI4zQh/B3Zcb77QL/+0qsq2pi7jTiOuVywisz8sauIk99GZmmqQrgsm5DMtT1e+Cw
         7WcmszkhJkDDJxXO2A6CIgaZYqAilRuB35AH+XzivFowZu9PF/jDmjx0w8RIYki8pOt4
         9wtjaGWY6/BhbORQ0aHwYZFl98xW9hvQxB6qrxUr71TUHX9TeTjunXVmLo8Fo/Q/q7Vl
         cketdfG7CW6qF9pOjFITfBxQm9jyPUNGbm/3THtIAlBsfv5qUzIhsl3DIP9fjN/ScJ9r
         zf1YC72kxE3VGjvdV83c8XzhsuUimnyb/4foJ91ZqpN0hV50thkdIYfYJrbisv0rYP/Z
         FD1w==
X-Forwarded-Encrypted: i=1; AJvYcCWDkoxkilusfwdt7EHrRhucKtANY+akjOIe8MBnLukjbtUHFbDVy5xnfO31ahkCD14ufUrhQKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy82yyPmURcPZ/gpJUHrv+zoWkAXRAWNDHl48byanKvQqtBDO8W
	Ro1UYMdjuGHumCVkQCKU5WjY1Ye8zSRs8VkRdQBHr4T3LHMRHi3/BvDv
X-Gm-Gg: AY/fxX5argms9xYYUFm+OG3CBdZQz611aKs5ce+1KjyJD4JRSuc4v2Od+XKhmfwZutt
	j5cPlEGKebtCweKc3BQ72IffuwsN5gmXBrAl8W5RRPd61xMvD9zQ2hn6FFR0RF8YmOa25f2EG0N
	OWYPr4HohcGz3cqJEou8CIdowQFYRVEglaDqkrRrrpGw+XdO+ewDkb1DzxpLudgj3SmFDkdk2yz
	qHIM4Z1CYtYC4hZSbSatDWwt9KUyrdCzoKoYWwDy+UViDAxBuYKhl9DDpKA3Vd8Wv5BjdXtZex0
	j8416QX91z/0kA46GC177EGIIKAiCHExcq2S+2DuSQv5P4yW85Dk7qkwhaAYvC/eSXA6jfKDbvO
	Y5LJlXFZSWXiU1efxTk3L7X5hi0q6jzdKTedKlSpkzjiou1PJhPoKjVkVHD0Vj1ombARCFeiHXy
	qVoXrGAk8=
X-Google-Smtp-Source: AGHT+IHprwedyAHBDG0D1dfPHlSVYg6dF0Z26rF6OK1U5LEGp6giH3ZZn20unITKVgvBwuK5w/x85g==
X-Received: by 2002:a05:6a00:b902:b0:7f7:3518:4be0 with SMTP id d2e1a72fcca58-7ff648e505bmr15249130b3a.20.1766581699346;
        Wed, 24 Dec 2025 05:08:19 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm16841173b3a.32.2025.12.24.05.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:08:18 -0800 (PST)
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
Subject: [PATCH bpf-next v5 02/10] bpf: use last 8-bits for the nr_args in trampoline
Date: Wed, 24 Dec 2025 21:07:27 +0800
Message-ID: <20251224130735.201422-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224130735.201422-1-dongml2@chinatelecom.cn>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
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
 kernel/bpf/verifier.c    | 35 +++++++++++++++++++----------------
 kernel/trace/bpf_trace.c |  4 ++--
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9714a7c3c5f..a99e286a504d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23275,15 +23275,16 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -23303,12 +23304,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -23329,8 +23331,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
 			/* Load nr_args from ctx - 8 */
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+			insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 2);
 			if (!new_prog)
 				return -ENOMEM;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d57727abaade..10c9992d2745 100644
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
-- 
2.52.0


