Return-Path: <netdev+bounces-250116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D77F0D2426D
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCF7F30213E1
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841B7379964;
	Thu, 15 Jan 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9babHY/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E63793D5
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476242; cv=none; b=hf5thhWzrY2sVYynNFty3k2oo/3Ke67t4MsYiXwd1wPrkYtHUHZVJbbBPM2nhKOY1pbUc9J/VZt8xSGn1sRQ/MRyz2O+W1G3UzDn9+eZPCkUIMwYKgPUjkzOM6fbyCS9zI7hA2a7KPYrglo9bwL4mfHvounu3H+aCeHv8kEIAHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476242; c=relaxed/simple;
	bh=6fOLPr5pZFj/RQ+K6yXNXzxNF1aapP52tKW6Swnvtbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldEAkdpWIKS+ioworfXjowXRinpx78yCdtvJXiGp6SvVNEsc6SDuNj/Xyi/OoIDDzw2MY+OhwUj49LS/OCkpkwNX1fHVuMpdaEsTa+1z349MNSFjkBvMfggP0Ich2Uef0ajTnumnG2Gk2k28Cwazthe5B489Y8MgYjlB/8cKeBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9babHY/; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0a33d0585so5470685ad.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476239; x=1769081039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=K9babHY/ckbeMC7JWrc2N9zaJeIR32aum9bXI+ItToFP1vuPRVa/ZT3//LSHjBu1bl
         Fa3fR9nS1pWJmLQJCqqadWNhoPSDJUi0pTF188aG7f+0q13f6SOHK562sCxRuIIaExRX
         avhBNwopcFqyjsNQ2t0RISqyHDe7qak5/v1h0TOn65LKzD+gDcvSZnodzMHjYeWTIPfF
         TJdGsMtZ60F741Unep2stHo7TQTLa+SSnBCXapMZz3Pazj1XFt7BPpZF04shZbRx1dvY
         PHVuW/jT+lpHM4KgTIzY2xSTTFS+x4oys3WFnqXWfz5Dpz/dgVqcJWWxLefGmMzd2+U4
         G8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476239; x=1769081039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=aswq2mWlM9gbAZHzg42R7Af6pJoLGwOyVzjGldHeBBUA7zj8wzm/JJhnv59OmdM/Ek
         fIgJqoR/iv5q+EQQcdBbPMb2Pa17vuGBpB6B0shw2ciUkGUPHZMqLN9zBGSIqJsz1FLM
         FdebXtq55UUBbjKO2Jr5E+4X5cLHYBEZs73KzGWTODpEBmmDBUHefkbMJH4IgGF/b8XD
         uztshG81tVJCYnq8uQSmmc+GE0HzJK5VeCpWpSBsgcxltja83433BOfSkdxlmfkh6tui
         4NVxEPer+UnpmANzLZvFMNYSBGFvXIzqwGgcL6ITg6bsydoGB4jN97ue0vkCrp0EMzun
         gH9A==
X-Forwarded-Encrypted: i=1; AJvYcCVICG+mn5UW32n/PxfeUIDAMzbL01Ov6PuBvOoMZf3wfCSBE7IdQLO6YZGpwOsmelbnv0ne8MA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe4vS5sDlDg898dxBm7zylKc3+aAfV7UR8NZMIv4vV2wkv2Z1n
	5fzcP2pFxegiwqAWnqssh6jHjVkG8+e7kvQf4+OosAeZJSqN3u7YFx12
X-Gm-Gg: AY/fxX7+O7MUPTvtfy1Vn4JrQOj5RFenKE1TPEE33JE4Gd+/FYY7/KYkxvI6b30CFQT
	GYqYlkPBzZ+zB3uQoeKT3wEicmNS6iCp7Wie8cdq1tjhQOs9vvIh8ANNjRAILfgn15SoULQtAct
	7oWpovsF+phFZjIIGhEbBY8rqzn6XSuw9BfIuqF1VI3oaZO2F0M2oxKxy49hmhM2s8YlRUUunnd
	cY3LVJSpujVEWHxc7XUnXuCS1JS/quFkd9qihNAhw8AK3FfUFKWtGiE2cj7PfsBGGfGAVZUD/ef
	7suNWwb+EIi8BQxJsrkbXADVJJ5udNPNZggNeV9PnjYuhfOlhiqJGjq5CFTzdhaUo9Ui5r9ccUz
	O0HS3gqJwUfeAo8YJ8p2U+y+TzqNDNVUTxr17tW0uPRBf8lz2piiLDDGjzFPc0cCYD8ZZXU7TVA
	iEQbsbHxU=
X-Received: by 2002:a17:902:e784:b0:2a0:c58b:ed6 with SMTP id d9443c01a7336-2a599e347d0mr61989615ad.29.1768476239321;
        Thu, 15 Jan 2026 03:23:59 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:23:58 -0800 (PST)
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
Subject: [PATCH bpf-next v10 06/12] bpf,x86: introduce emit_store_stack_imm64() for trampoline
Date: Thu, 15 Jan 2026 19:22:40 +0800
Message-ID: <20260115112246.221082-7-dongml2@chinatelecom.cn>
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

Introduce the helper emit_store_stack_imm64(), which is used to store a
imm64 to the stack with the help of a register.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v10:
- add the "reg" to the function arguments of emit_store_stack_imm64()
- use the positive offset in emit_store_stack_imm64()
- remove some unnecessary comment, as we already have proper comment in
  emit_store_stack_imm64()

v9:
- rename emit_st_r0_imm64() to emit_store_stack_imm64()
---
 arch/x86/net/bpf_jit_comp.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3b1c4b1d550..2f31331955b5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1300,6 +1300,16 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
+static void emit_store_stack_imm64(u8 **pprog, int reg, int stack_off, u64 imm64)
+{
+	/*
+	 * mov reg, imm64
+	 * mov QWORD PTR [rbp + stack_off], reg
+	 */
+	emit_mov_imm64(pprog, reg, imm64 >> 32, (u32) imm64);
+	emit_stx(pprog, BPF_DW, BPF_REG_FP, reg, stack_off);
+}
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -3348,20 +3358,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
-	/* Store number of argument registers of the traced function:
-	 *   mov rax, nr_regs
-	 *   mov QWORD PTR [rbp - nregs_off], rax
-	 */
-	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
+	/* Store number of argument registers of the traced function */
+	emit_store_stack_imm64(&prog, BPF_REG_0, -nregs_off, nr_regs);
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
-		/* Store IP address of the traced function:
-		 * movabsq rax, func_addr
-		 * mov QWORD PTR [rbp - ip_off], rax
-		 */
-		emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, (u32) (long) func_addr);
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
+		/* Store IP address of the traced function */
+		emit_store_stack_imm64(&prog, BPF_REG_0, -ip_off, (long)func_addr);
 	}
 
 	save_args(m, &prog, regs_off, false, flags);
-- 
2.52.0


