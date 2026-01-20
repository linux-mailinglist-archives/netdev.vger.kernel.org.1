Return-Path: <netdev+bounces-251362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB8D3C021
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 08:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C0BE5403E7
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 07:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F338B7BD;
	Tue, 20 Jan 2026 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIpbwsK8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B953815DB
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892790; cv=none; b=ZoTaVPMEM0Cfk5FhfeArXPaSwwRVbV8Rnzo8xgu8gGugNxZAf46DCMX+KoW8caGpr7HmbJlPVRzSBH8xXZn7YblNDFvnRtKiSPfwJCCAp0i4l8Yq+2RYdGBskS7AvB1iuoDtlq8H/cAb/GAm917CuXd8+cTpQ1mVcEaw/p1vtjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892790; c=relaxed/simple;
	bh=bkEnpN35ROgLb1TaATahFCU+nYmJUOdqiUA5VNDzRiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/f5N8BGFg9QnT4fFrYFk0MxO29x66+vA6c77Jx73RRQ53R+Mm9dgIm9uY3SMRZo0b0mP3S0IlrVNzNw3zO7jQ6wR8ltrz5YkkN8qB5M9BrId2Ff4QEnSrLxxyyss6UUHwM9aQ1N3Rqq3I696p+aFJzgI8j2EcjyJ8XTRFS4ddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIpbwsK8; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0c20ee83dso45739535ad.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 23:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768892778; x=1769497578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoyD4uV9eCRwWiRSuwU/fXn0oAa1lUGxNCw5PqJhjBU=;
        b=BIpbwsK8IFYvCZ5UM6BF2qr/i7osYi3MA2+M0lEvSqHQZMB7VpEkGSrGTrqxQPMsVt
         xffOdLinNu8OWRhyJ02aZ2eDeS/nugwYSGWlw4KLjNsfPG8vynnNzWi66SIHDvK5V/GD
         /2qipx/jpeol5mIg1oe05eSfOmtJ45bAC/z/VQ8Gp0HSo6uDxpTIxoatzullIsxzb+0y
         tNRiF1E/KG/FwyJcNl2ZYpkv0fWN5hiYmV70w5qznyUqmZebvIb0OVjvsCVzPJkWLWeU
         7BWhuIjM7tT//vqyvXofo4qckw0DTktmhTr//XRKFRttrFkIDvbAEOFRL//2jm1/HV3e
         q23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768892778; x=1769497578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AoyD4uV9eCRwWiRSuwU/fXn0oAa1lUGxNCw5PqJhjBU=;
        b=tP92Nv5fphmXLIMqAOgucWuGAsReCc11KZNKZQ9W+oZVbSwF0jyvPR4xclrZqRmLz1
         9ZH8egEZAlfgSlsg45StkVcw+FTw4YQ+umgEC7v+e4dosT0KAzbcfC043UhIzLVLoxPW
         c8sf2txu7JiLpupAcmbQMeSTwQEEX3T2+gAZZaf7TuRC7J6vfJjSUk90rq0p1ru0E8nb
         w2h8nvRGv77Ox4+mi270EzERv/VvxEfiWDgeu/hDhFcTYv7mFdIhQNEmKKyfukS/SiKO
         fXDWqL4OoVBzNhcFLWw25FMbfVC8VocPLoonTPsyoVvFKoASh7GNljtmAHybp6g9VVwm
         GOXw==
X-Forwarded-Encrypted: i=1; AJvYcCUOs2mO9up4yvBOcQmNxxLGOcGqXfcORlbWQ4z8Ey8RpGxG2fIKX6DXZv1Cg5qMIZ0KX9AixP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv2Fmc5P757tqmLTblc+kvfjwz0lf1g7bBDU/Azzq5Cfom8kvY
	rKvePAKElZE+Q6bjwbl+liv6stV7RC1/7RSLjOt87LLLr+sWZHbbEZxC
X-Gm-Gg: AZuq6aJ+Bxltq64Kip8LCXrXALB0TuKtvZvj9ixXrDD8LSb51OL+Gm9iVLMqST31dtO
	HqebMqHtP89DJHOzVfU/dY/E3SH1lO9GilcRRib/TkBLEIb5WvKox9tgCJ1lnt08PX6SqHIDD/J
	bJG3OzuVSh8TdZGv0lOBS5Lo8nhwppyJFl5F1lV3L27Uj9ahbCI6+b/p8zeHHgEEAIZINlCC0Qq
	Tmo7myPTNCQQlITYLGPKfnMXBhMTpyI///6BtPXNhNsAVDxAPeqiX08iBoDih7aJmZTMiRJcPfH
	xlsT1Z53t6Fyru6Pl2XC5JfLj+BxuY6pwvIVZh8pNsg1TZ1vYlaZ2sx6Avifo5+lFHLh6mWjRA+
	Wy91wqgeHqbQXT+YatTAkK5CDS1f1TnLsyOyXvhjTmZuPl9cQeqRjduwmOiG+0E8Z/b5J9yLb+k
	SpGJ30zS/R
X-Received: by 2002:a17:903:1a2e:b0:298:6a79:397b with SMTP id d9443c01a7336-2a7176cc35bmr123268025ad.56.1768892778110;
        Mon, 19 Jan 2026 23:06:18 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce534sm111695665ad.27.2026.01.19.23.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:06:17 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
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
Subject: [PATCH bpf-next v6 1/2] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Tue, 20 Jan 2026 15:05:54 +0800
Message-ID: <20260120070555.233486-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120070555.233486-1-dongml2@chinatelecom.cn>
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
to obtain better performance.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
v5:
- don't support the !CONFIG_SMP case

v4:
- handle the !CONFIG_SMP case

v3:
- implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
  x86_64 JIT.
---
 kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9de0ec0c3ed9..c4e2ffadfb1f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17739,6 +17739,10 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	switch (imm) {
 #ifdef CONFIG_X86_64
 	case BPF_FUNC_get_smp_processor_id:
+#ifdef CONFIG_SMP
+	case BPF_FUNC_get_current_task_btf:
+	case BPF_FUNC_get_current_task:
+#endif
 		return env->prog->jit_requested && bpf_jit_supports_percpu_insn();
 #endif
 	default:
@@ -23319,6 +23323,24 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			insn      = new_prog->insnsi + i + delta;
 			goto next_insn;
 		}
+
+		/* Implement bpf_get_current_task() and bpf_get_current_task_btf() inline. */
+		if ((insn->imm == BPF_FUNC_get_current_task || insn->imm == BPF_FUNC_get_current_task_btf) &&
+		    verifier_inlines_helper_call(env, insn->imm)) {
+			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&current_task);
+			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
+			cnt = 3;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
 #endif
 		/* Implement bpf_get_func_arg inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
-- 
2.52.0


