Return-Path: <netdev+bounces-252663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNiEFiElc2nCsgAAu9opvQ
	(envelope-from <netdev+bounces-252663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:37:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A3371CEB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58AF2300E0E2
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD813128BE;
	Fri, 23 Jan 2026 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSX2aH+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304F31619B
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153796; cv=none; b=s0ICyfmPKBJGkv1zY1bJTJHicdLRyoK7iTvCazMUYMwGhF+sf4ObP6MjjE3vALh7spLjaVxdsRikisS/Epe8lTNilusruCRZiMrts/+4spyzzwknlqPx4fvSWVX1Ocv7+wBLcj73ORe3mS5qeYCPCsc2KCOko+cbU3CXbwUCpCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153796; c=relaxed/simple;
	bh=6fOLPr5pZFj/RQ+K6yXNXzxNF1aapP52tKW6Swnvtbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOdgMW5cHZHfGRWtyxoxdEjG64HBUtOwSwSM/8SIK2Ges9loEu8yZovx9fxfx5s9YHGMvFP0mKY5HchiOiMPUv2Y3oHKkLUB2qZ8ZZgIukFdKtQPKuC+Rngo9id4jCxjc4INJP1mdztrFgTX1qQvx/3fy/ZSGYMJJUDCnKQAW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSX2aH+e; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82311f4070cso588569b3a.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153794; x=1769758594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=TSX2aH+eQo/qTm1BTEihbNC/pzELdZetpmmGdTUozZgukN5dWxV2b3cSuSFBBYaz8a
         wTHa3BvJdKy/9AyOTn14g6zSKbZpcwP5KS43PYMPQ69fVZnNTBQIWKpZxVRzzMqJpE0/
         O972XNZp70wnSmz+qD06KvbJ17I8o+AQSq/crp6i/hns1NJ8vkSwI0Drs/3K9I5q4Zer
         LElU/JAgesR/05of76UwKkVMCKY3uCZ/ucbXHkdjNK09lcB/naMLszs/i5JvihvfBqnX
         KO2+NXYh1O2oqdIYFleaCgGJWaP8nMeaArsl51LvFzcjfhw5N+xZW6egbGPjvR4DVUNz
         56JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153794; x=1769758594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=Npug3oa9dreUBy7PG644G8jAwEq1WTTb2JWtGg8vVe7HpZjDegEXOkiRoqwhc3JrDK
         Sz0ThTHmx/GBWtNe6w+N5JVxe1i8H2BT4Bo8VMhswKWoPOHygevymElZSnCwtaoihXcP
         szBYqhF59oUU0Arb+GEU+K7l49k4PuDKRG4CVpG8jeqR3grO9qZe7BZOD53NNoO42h54
         rdDhNVJBBHcHGKAUtN3xck4rLT7bIzrbLDgHDOEL4Lbe4p/lhpElAOZ3J1CjzXeE4g7I
         j9sXXosb/oRASqdVCG4v4ExmGEWgomqszWfXYCMmmWEz9Dsixwg1k30fTvST2B7cSV8B
         2mZg==
X-Forwarded-Encrypted: i=1; AJvYcCXrp6nQs0oIly88pRceBWHI30rEtMOPsWRgKP6WbxVPrLb1YDAo0fs8yYzDjXP8cR2EYWFtYCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPliAPpJy+5T9ulwrz8GucFVh9sIUzJoeSoXw75tWz38DhiQio
	6zdVkw810IFH8voVlGPL2FOt4mbD3Vk87akCRns788pmDOSPQ7ZW2n4+
X-Gm-Gg: AZuq6aJ3gjvSW6KqgfRpfdgUWeDvjbRal7oT4cXPeWYRTL333quXTdCikyHfhZgvOXn
	Nw2L2xWVu2u/wmFjIRqhz0MMdGD6yESDy6kXo1csactOBgdWNaWoNuJu5gjDu5wZZyVJnOXm+sX
	PEw8vRp0oWmhEeFnNRVshtAS9voUe0cRrxtDU0Hm0M/Ci7+PkEUVFB8biE3jhTxBAUS2LpN3N5r
	KUInanvkl2iIYe2mS4A3f1I2xBMdzqx/Xgjk9X1ZXOU7xfUObLvOVU3gXOeRrj2UaXdrkUinKgD
	mffweglnixQt2KN0520fIaC9OJCXV8DtAqAWcRVRv0E4DhxdnjbAz5ibY9KbqKj/4pIZMNHV+Dv
	pAgFLwYk54giHswIgQ/GIXd6nKEryZRWCG2uhmxuTc3WHa5SS9wiAjI3ZytNrAyDX7Mv5/RWaCt
	6gHRJsrcHF
X-Received: by 2002:a05:6a00:1825:b0:81f:804f:af26 with SMTP id d2e1a72fcca58-8219ede8a3emr5462181b3a.19.1769153794191;
        Thu, 22 Jan 2026 23:36:34 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:36:33 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
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
Subject: [PATCH bpf-next v11 06/12] bpf,x86: introduce emit_store_stack_imm64() for trampoline
Date: Fri, 23 Jan 2026 15:35:26 +0800
Message-ID: <20260123073532.238985-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073532.238985-1-dongml2@chinatelecom.cn>
References: <20260123073532.238985-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252663-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iogearbox.net,linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 05A3371CEB
X-Rspamd-Action: no action

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


