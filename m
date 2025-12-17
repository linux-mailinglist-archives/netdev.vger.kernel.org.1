Return-Path: <netdev+bounces-245103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A34ECC6E68
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12D44304C660
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9629346FCF;
	Wed, 17 Dec 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MP9jn1xi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1044E33AD86
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965310; cv=none; b=rXjaqsW0cz+z2ce5YSF8eT+bYNYQBdiiBuPfW/BZsAq2vNMTy2Jtch9I9tePtF+S3AVOwhYc43op9qip3rkC1tB2nP9wvRYExgSilbBTNm3qD+ZsExNaUPvHVhEmxWKfdhte2W+8a/zHLkeGrzxMnDxDaYlCOf58jKvZ+7heJ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965310; c=relaxed/simple;
	bh=jNDDbcagd7GAuu2ax19vRmL3haiq1I8BaTv4/D338Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdvyDdpcRpkcx9Fqk0E5ZGKUgH95+UeEj+fRMUuKiiRZ5+Aufvh/13smzjCaBCz0Jc4TqVydqFEvP61Q8mG6VkLulHCmBaWvoVpcUCAOpx5P6gBBjEz4UfGDNKw3ZasQ7Jg3pNdrSR/ERjtWbtNmiA2vcxnOMPElQQPcUE87mDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MP9jn1xi; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29f30233d8aso55938515ad.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 01:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965308; x=1766570108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqU7Z+qRZovJUMSBsI+FDu17KbC0yuT8froZI9mKrQc=;
        b=MP9jn1xi0iE4uyh0iTVjLkcKV3V1Y94KL82so/SPnbVLs+QYkZ+o0q6VJkyP5cfJ54
         sOYDHtnzv4fe26+hIcFE2ErUJd67fbm90Tv4TBBfD+2oIue9lmQ3HngRtzoaPPXE3kzl
         h4CV8ngd/UqgvfWbHMggps9H+XC3wz8bnLMng+1E1SFgXEZlfiw+BU4HuDwwKWMqFqP4
         j2eDadkQyu7vZVjPnhUMPLMFAMcVTowHPoD2e+LIokG/NlYfc6wCvY0D0VCUON0eKNrV
         aSvE0zlqiQNJUWHiiUFcfHWk0vI6t0XKWXRse6RJdXZJTD/lnTE/78fbFmacGTgrdj93
         f8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965308; x=1766570108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uqU7Z+qRZovJUMSBsI+FDu17KbC0yuT8froZI9mKrQc=;
        b=Ppw1bWsLA+by1LEb+0dRsznuDdOvHeRMTEQTIW/8CbJlpZ+WkntFXViaUkoZH5Xqt9
         fPZu3rlXchT08Zc5aYlpLoCO9NqUhwEaU0J/jC3XGdQdZ/QCOnfQN62ZFXyXUqtKKlap
         M3gxHNshnAJtrlyBNAK5dRDzAe7QMCYDHc6xM9/OvQ1zMNzN7b1UiMxLoAhRTpJ23y7i
         /ZZXOThymFNybGsg7NRbYjaggubf5rCBFJ+gFPq+Mdfhi4txmqNZqcYo+kDIVgE1X3pu
         zLIlizQDUOB3HD8IxHce0DxlZRiB3ecRRbjAbwxbkkJQiMxWPV3CB5pUa+e9/gxIVlo4
         dQdw==
X-Forwarded-Encrypted: i=1; AJvYcCX487rMcdz+m5G5tYiCUX2nm1QR/Mh12Bd2AIEZ1uLjmfsBaec/CxyB01XQkBbUYlrmdN07qnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9k62K2uRTdgZgV5OIeMNMVaMjp1E35WlQ2+vPyvzKNvindsA
	4/7iBGkoJe5pVfxqvPUqZqiJBBpX81AjXGXq6JRX11MfWhDY1I7zXREG
X-Gm-Gg: AY/fxX5zeP2UTr0IlZwXmw7cRfkHnB5lND7Mow6oTPA6q1cGiIqy+P82E7n/T/3k3nx
	I4um2DnKZaWJ8grtssKrMAWnaGwu5k/DbvwX/i4ev+E/SlTSHHwY4hr8ajSVdT3AwgWG8KKMXQw
	eh5saaRq/cph3gDmk4PuAdcPr0Sd9gfoszwlucrrCqke1mt6VAP+q5fBaCSwbOgysCt8FP9Fa2o
	E9qIoDsdvit8AUnUrAQ7HAzp3r6mwpSU02YCQX+cIlCi/Z9Ss32IMlgpX63sSXzxO644hU7RC0X
	GuDJEjuyyz8VL0gbDclqabDnMtiWqFUx3pGGGXAQ4o/XgQK8ssI2O5gQ1mWjYSoNzr6t+SvZCfY
	mozhP6JkxLsOVc/DtvbWxfskaP2eYvcUDHpY2Z1c32AtnW02Nd1DQl6tDvnO+sE5gasO71EPG/Z
	0ZNHc9h7E=
X-Google-Smtp-Source: AGHT+IFILQ9PCGB1k7TzRUfGk8NAtRn8WD9pgKOijI5EAUlfitwWLOp+2LpFyNyqCtqlHGTd0BF75w==
X-Received: by 2002:a17:902:f54b:b0:2a0:8963:c147 with SMTP id d9443c01a7336-2a08963c3fbmr154939745ad.45.1765965308289;
        Wed, 17 Dec 2025 01:55:08 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a07fa0b1aasm140715945ad.3.2025.12.17.01.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:55:07 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 2/9] bpf: use last 8-bits for the nr_args in trampoline
Date: Wed, 17 Dec 2025 17:54:38 +0800
Message-ID: <20251217095445.218428-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217095445.218428-1-dongml2@chinatelecom.cn>
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, ctx[-1] is used to store the nr_args in the trampoline. However,
1-byte is enough to store such information. Therefor, we use only the last
byts of ctx[-1] to store the nr_args, and reverve the rest for other
usages.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/verifier.c    | 35 +++++++++++++++++++----------------
 kernel/trace/bpf_trace.c |  4 ++--
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d399bfd2413f..96753833c090 100644
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


