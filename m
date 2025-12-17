Return-Path: <netdev+bounces-245106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF8ACC6EA1
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8F923019F8D
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5073C33D6D4;
	Wed, 17 Dec 2025 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbkszo+i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91DC340D8C
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965329; cv=none; b=AvObvXNu6k6j2/XcIQT3aX9jcO7L4DYyDb4kdxGuz0HxScwumsFbR5BVVw9ubJ+AuDzcJCRZ6TxZfRmuYELMWGtgWYbEVvy7zwHkIrSdQKEJqU+31trOh1kVe/+CJatTbvRae+lkGeKrWjruaK5CzJqaF9T/Av0BjOqWRcNNy8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965329; c=relaxed/simple;
	bh=8UjztYwJ3V5glcGLXb6BENiANc0oStuVeMSUdlMadWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiG8JR31u4X+qTL/TQAhMHiRyHpFJyrdXKAA8prvQlOmibe6qrwmFyI14chRl24DKBbyAcixS7e/JD84kS0e1twqhtn1X82H2qcoKcT/loJz5ampkBwXPQ3zrvOTQOdbZ7wrq8V0URKd9XQeKwahJldbNRgf/IasLByRcO8xoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fbkszo+i; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0ac29fca1so34937735ad.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 01:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965327; x=1766570127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYyVRjly71IVaO9XpSMOkg3chszPFkxF2ByaNmXFw0U=;
        b=Fbkszo+iU6QUDZU9moPXyAruR9ZREYm1i8fjwUcaCiDoWdKXKmYw8bOm1T032GmC/T
         JNRR+1f4IYSE7FP4UEsbVUBRqEy8fl24BrMu2EnUBWG5GzYB5vqc2RVOWJZVnSi5nFUR
         I2KKkHweTuYcOtpbZD9YZeb2MGdqcMBO9QZNytUj0minXz8FJWnO4H3+AjYJQCMftoh6
         +1QGjhUdMXER33v9O40gD/JCxtVrPmt0anrJ0qqE15dUSw7UO4izjCd9GBJmtRsz2bFV
         EPkYuRTQudx7NceiwuUCU0GfQ/PvOVIrtFnqOV/zdfFuH7APzM785tz+Y30KqpMr01jp
         tnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965327; x=1766570127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zYyVRjly71IVaO9XpSMOkg3chszPFkxF2ByaNmXFw0U=;
        b=vWAl/iRDP/UpMZDz219Vo/hetkgtd9oXg05q9/i68omQDSRGRsaoF/qxzN0lylsM1Q
         sWiMPJH2giHelx08BcSBmGiy9t2y3US0ED/p02/al0JdxlcqXtaZmI0v95AZZeEAwD+7
         iDipAQbgk3bN6/oduJZqQYUjB4T9N8Di6wcD3n3rhQtps1MmkpgPJtRxN7j4qxTwlfl2
         DG4G5wJCGaNF+pGbMDbXz39NRPheb2kuTNfRz4CrHZrSGK/noZHPWOEQSEcXN66BvhHp
         3J183CA0GxkmqiIEtbhlfeWLHHZw5rlDEQYJ5477yn+5GCyLwdr1ixjUEvHuFD+T8xHS
         epZg==
X-Forwarded-Encrypted: i=1; AJvYcCVEWcZPKeliVQ0NLLqHZ7j56dltG+PXjGdtcHj1L7Tev/gfryiAMVX2Scd2zEqXpmNN11O9gmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwoKmk9VEBkwF+kLmN5s1fp10oiUWSo/uvy/5BPghUIlrFVRAp
	xUmDnCPbliXXHB+4Umq2HxxizXpPzo8BtkBHpQOTOnkaXiuTctyu2UDn
X-Gm-Gg: AY/fxX6ke8fHm1nk3p6kPb1xxucen44yidub4CsVzAP5lOjLRza4FWXTFrim958M4dX
	/+4gkrdp+0AdZ3cMY2XIrAkXH7bfNOELguR/kz4KfNyJOt/R/TJ9KCv+jFDIGMuM0PHJF5LjRXP
	nfqNX4q9Y8Ync6SvqQy22OuEVea6SKnJaarDTHGydb4NibEoTLJf+wLZRK1Eps3MgFYhNSFQjBC
	n8p7FGnSyxxRRR9oSFmHCPy+RrCNYKIMgzqlRnRu31R5NyBCUfPq4jylnOlETDYEw3mkhrN+UMC
	Phrbg/HZLlkt4sEr07RxR5L+Bzp2aWgTooQYa62cVbjhYl5yqE6ESLKoAqWt/QIAfU43wpTj1j3
	i/PcVqpSJXjW6zh1Tr1c7Ly/1HoZaJ5mEOj3huO8O9mY27xd3JplUPcr4rJLxFWQvjCIgR+NjXI
	p8e+d4Mbc=
X-Google-Smtp-Source: AGHT+IEJALUlnag/srZc+nNutVyqUv3oQE6iSsJThTk62+uYDbyqqh3e2Gc3Am2sWZ6ZqH4wfrfqdg==
X-Received: by 2002:a17:902:d488:b0:2a0:d149:5d0f with SMTP id d9443c01a7336-2a0d1495d3emr117851165ad.17.1765965326939;
        Wed, 17 Dec 2025 01:55:26 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a07fa0b1aasm140715945ad.3.2025.12.17.01.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:55:26 -0800 (PST)
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
Subject: [PATCH bpf-next v4 5/9] bpf,x86: introduce emit_st_r0_imm64() for trampoline
Date: Wed, 17 Dec 2025 17:54:41 +0800
Message-ID: <20251217095445.218428-6-dongml2@chinatelecom.cn>
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

Introduce the helper emit_st_r0_imm64(), which is used to store a imm64 to
the stack with the help of r0.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b69dc7194e2c..8cbeefb26192 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1300,6 +1300,15 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
+static void emit_st_r0_imm64(u8 **pprog, u64 value, int off)
+{
+	/* mov rax, value
+	 * mov QWORD PTR [rbp - off], rax
+	 */
+	emit_mov_imm64(pprog, BPF_REG_0, value >> 32, (u32) value);
+	emit_stx(pprog, BPF_DW, BPF_REG_FP, BPF_REG_0, -off);
+}
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -3341,16 +3350,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *   mov rax, nr_regs
 	 *   mov QWORD PTR [rbp - nregs_off], rax
 	 */
-	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
+	emit_st_r0_imm64(&prog, nr_regs, nregs_off);
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* Store IP address of the traced function:
 		 * movabsq rax, func_addr
 		 * mov QWORD PTR [rbp - ip_off], rax
 		 */
-		emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, (u32) (long) func_addr);
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
+		emit_st_r0_imm64(&prog, (long)func_addr, ip_off);
 	}
 
 	save_args(m, &prog, regs_off, false, flags);
-- 
2.52.0


