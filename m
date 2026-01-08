Return-Path: <netdev+bounces-247931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF510D00A71
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 823C0300385F
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B3D26E16C;
	Thu,  8 Jan 2026 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnXpZC+t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363671E1C02
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839129; cv=none; b=ZPZeCPmUOxbQAg7QbcFlDhevIPQHKt4dSr8frSisSi+7Xh+Zwiqx5xpZnF8d4dHM/EWXGIOytttBxLlqEsfd+joNV6G0dpI2M/y5xScap8ZaQWSb/FKg4quKB3PdMcVBWM9lAZyZrLMhFuwe21dQP7i6pIP5lUElZX6KwPoVFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839129; c=relaxed/simple;
	bh=VhBBi66SFeKXbV7OJrrw4WoyPdDGNe3BKHOh9sdreXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slMTEJEXxlsa2pj7hT6g8oS2RqOYt/+t+HbsrdBB6KeM12PCBobejN6NofP32x8gB1qH2aF0/ECckVX2Gxsudv4TSj5iFYMQOUIeeRXapjqOQv5Shx12q1QkyaNwUASZQUNCpB6X1Jphgt9Bq3RwFiiXMI/wmRw24/1wyiCU3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnXpZC+t; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7900ab67562so27462257b3.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 18:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839127; x=1768443927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjkgpIcKhjQZAa0EelYk21O9foZl8TfKrOJc4gFivFo=;
        b=EnXpZC+tZWVJVIn6TyUS+mZD4Xyrsdah7+b/PL/ss/eaCKfyEu6HOnhT+K5mM5vf9C
         gdFjmSs5/y6GJiPwqp1RK1gSN8oYsYaH0RIHcQDZNexcR9bz93F3UXuGUWhqNnVPTZZN
         GAQapJeE8z7QmX3YHyvvxhzL+YeupiocPTav3KKvMmtpOznLdi2GFjq2kXEFATl6/eaE
         SjZ6xhY8D3+Q9YzX/DLmnJy272MX8cWoxqpIiQnXHdPLZnPVEg81ygk3Cn4VuDp6VUR8
         0KJQOtEX969+POO9qIXckycUMFHk3JHy0OyyLc/P61Wum073pH0wv6DtsumYOCchEnUi
         KuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839127; x=1768443927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rjkgpIcKhjQZAa0EelYk21O9foZl8TfKrOJc4gFivFo=;
        b=Vag+XBfi51uQbBvx1R1AvtK10w23XfMgd0RpSh7GCXzxaXe62esjWNjP8Ky5DCLNt7
         1/8GboGWM8IoiQkd5KtJSXHHbRbZV306yz9OlKCWIPtEOjQ/b8c7IarpOxDbB61TvPl6
         QPjAT9Ze2X/0uYuPuKutpio5NCgTIJyg6sut7r1vDuShFqK/WL7sK3MWhvXUQtNCOEmT
         CInAAkdsSPzAcbly6dVWyEEpDbW9qVwwXECVuNRsHhKs4yC90jnsCDDDS1uqvWerVQRB
         KjgSNSmLZKWIgeB66zhIy4Lj4NkuSWyGKUgkjm7T3L5NceIuodC/dpH7v0rB2qyDBsRD
         mlHA==
X-Forwarded-Encrypted: i=1; AJvYcCVDVNqd6ggAyh0cn4esonsqUxrYiC+J/KpQhIal+6IdyMR29O4vwaE/YxXLzfgIpSSfqksmfO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JMvKgQkD7qBpyXi6zzP4eUN3kEvbvy7oFFOgN8GtOJhCuXkj
	Lgu1dwT38gymSyZEDxkimb3eaahH6Ns1YVCEoplE2NXpCLhEJiHP0zvu
X-Gm-Gg: AY/fxX4qN89GAlvZznHnJti3w4decDK6CKZCXKHMC26pWk1DSJ9PgOM0YsA/ROpbIZT
	Xa0i2gPn2R1172xiyMetgdmeW6W50HhZrhxoOgxvOX9y7rXyJ3hfDwgxgjE7/nn8p8J/MICDPA+
	AtDoXPWMl8vrRJmtKv75NrvzCfKEIY6sefs+OWdMnV+Iadex+UIwGr1x3BxHcnmK8pE9PEFfu6M
	6UvtnKDmnRSds8C3atRAbt9gd46qY2x4BVJixSZVPbdsgB4DofBoqxEYSmk5xEl6hfj5iHt7X4M
	JIsK/3NMvzT1lzbLUMjvdFbXRz2HybJTql7wm2zhmNa+JFUzpd7PlrNRg/nMAVJXgiNlp4BzCu+
	TxcsDsbmpaLgkRPihsePmnHasVrgopY14M8L2Ywgl8/Idm48X0yWtxrsZcjRNQQXFk3j5FAxAbY
	lPZ7hBWXQ=
X-Google-Smtp-Source: AGHT+IF6oe+CNyD8YMJskeioT2pg3/Psy/o0qTkXNquKhbC5SDD6nywKNBGuaI6KxZg9JJ5rrEbQ8Q==
X-Received: by 2002:a05:690c:64c4:b0:78d:6f35:bdb9 with SMTP id 00721157ae682-790b58250d6mr40899167b3.51.1767839127164;
        Wed, 07 Jan 2026 18:25:27 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:25:26 -0800 (PST)
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
Subject: [PATCH bpf-next v8 02/11] bpf: use last 8-bits for the nr_args in trampoline
Date: Thu,  8 Jan 2026 10:24:41 +0800
Message-ID: <20260108022450.88086-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108022450.88086-1-dongml2@chinatelecom.cn>
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
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


