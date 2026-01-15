Return-Path: <netdev+bounces-250111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7B4D2424B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36A33302F2CA
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D23793A4;
	Thu, 15 Jan 2026 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHiCp2SW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8220376BE1
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476205; cv=none; b=iMwVBRl5r7i4YZt8B55cFFsIJwfQDUe5j5iVgW9C6goyVTx50JKfyMeqwzXD0MR8iPxTSBPX+umOj6m1USt4m/nyoJgqG2VgKOIygQhPe2GQibcx5IhP0DFH2v9BbkSy4oQgE2PbwN09CdPbdIrTQsbYBGpVtirDgE31EvKIKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476205; c=relaxed/simple;
	bh=KE/DuWBKYg5O3zJs9ZIF7Q/rT/si5I5pQpUSMKjYNMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzNChE7fr68tSwKRobhxiBsVrRDrC82+y2/wZyBE5n6wHkbeUTX3OsMwCdEHpAI9eEh+XHnLfx4nJm/BotMajDF0BX+QUXqe5zV3uCagY3xLUMPe3twZl5cVMIbSBZ4IZVTsrSSJNRcxkZrnaiks0pqViX9v83VAAk+bBCBtLro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHiCp2SW; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29f0f875bc5so5752575ad.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476202; x=1769081002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5zxBe3+cTqgASBHb1dABIGIsf05vgOpwgQe3a0CdAI=;
        b=HHiCp2SW9ps9kuUx99iTzW59K8BgI4UeMVR0BEgxcx96i7XChRwaMwbfQUFAUb7zqO
         pS5ygA7Q9yPx2bsdW4ZNCeMDCJRPE6YiTL1WL0wv/ZouyLyo5t3VJvmJ9SPC+F9o0xh2
         f4bFYW7CwHErPoqi9fyLAcgfGD+A8PgIJgerfRQr+zHV6KCNPVUuQbPGW8CE9bu0OIKO
         Vw0iTnu+iRQOrd5TatT0hclJmLCEoWHOrJqD6Bu3y/NotJV2YHoCKQudko0bW8MdEX1g
         p7oG44wyWaW1e0b8yI988glLKV7GJK2cLVza/zn5VL/6K2yHwdjwSaGDwxac5SyVT8CB
         Jxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476202; x=1769081002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m5zxBe3+cTqgASBHb1dABIGIsf05vgOpwgQe3a0CdAI=;
        b=QJGcYEyfnQbwbd+sYHYW5Tl08doOBo0nZl5yrf9P7VwTZpZszXTqow/OobbpoR3p09
         IY7LZydWjj4X2XMhtIBVIWycBWi4U/tH9Kv0O0gCy55XOKefzT+XXvGtUGrwDETaZtJB
         j5LQhozI4Ka3K/y9NcaXepFWgIN9IZ2ue8GnKwQFPcZdHlQV4cIM8is46pl9mK5pgdO1
         /fN+uy7nToP9V/iUEdrPpEUkXiVvX1vEzYw9MLHRvEWysHKIqTS0lsJkW2fN6yCsF0DR
         IJjJURPkPCMqAVls67QUYuL8I3lsrSH1npn/kTRR47kr97BrE0/nANYYrm4vr9KL/6RO
         29Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWHAyi5y1bBZ8Do0EO8sxLWoLka9ZbI2sZfe5KPdvErv67M87qtg+oakFuDkgjiq7Zk6qEZaVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEQgM3GfBD8fPqVaLmzwRtYZUU4m0G9T1s1dEd4I6JobuPmYop
	AOiMURZua6qKAt48TJKgil90ipWva4X6MkgMCvYY5dxAl+JMKilrD0OU
X-Gm-Gg: AY/fxX7wahMRE4KKBuwixWLIbi/ytiwoQTBWG73eLXiVLChPACycEuFNK2+w6xevEEj
	+3rO2lVosD2rkaZB9jHwxAiv+rE/VYyfI5pPpJySE7P9OzfjVDzu+Kpeq6HUi0+7RskC8JTw/EK
	4TSah3Ezq6SrNQHuR7XFF9qZePRj/NKtN/IwPOH7FdJOnN0W8Zich/oXFymdn+wJh++CV5d7TJG
	ohls9CurmkydkzCXqjFKLWsravaUnYbdElVvX2FQrb7C9iFJ58lY0JdP2HmCZq2uOYvQuqC0jtT
	bskTJKoN0pdBYsNAHGoG7/U5bCRgbvLouuhGHSXEssYeH/1NwfxsRRrsyok7i1aAkVfhIK6t6oZ
	QdSsFdJwBarZrAbT5TFUQ1+eiE8oBEjxTq61Wi5DRafKxzOk0bYnIPQ/9BT7MULjctzNSGo1h+S
	ACkulds2hLThrNCmHgKg==
X-Received: by 2002:a17:902:fc48:b0:2a0:a9f8:48f7 with SMTP id d9443c01a7336-2a59bc4a116mr53857735ad.55.1768476202044;
        Thu, 15 Jan 2026 03:23:22 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:23:21 -0800 (PST)
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
Subject: [PATCH bpf-next v10 02/12] bpf: use the least significant byte for the nr_args in trampoline
Date: Thu, 15 Jan 2026 19:22:36 +0800
Message-ID: <20260115112246.221082-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, ((u64 *)ctx)[-1] is used to store the nr_args in the trampoline.
However, 1 byte is enough to store such information. Therefore, we use
only the least significant byte of ((u64 *)ctx)[-1] to store the nr_args,
and reserve the rest for other usages.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v10:
- some adjustment to the subject and commit log to make the description
  more precise.

v8:
- fix the missed get_func_arg_cnt
---
 kernel/bpf/verifier.c    | 35 +++++++++++++++++++----------------
 kernel/trace/bpf_trace.c |  6 +++---
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index db935eaddc2d..f7eec19df803 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23319,15 +23319,16 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -23347,12 +23348,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
@@ -23373,8 +23375,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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


