Return-Path: <netdev+bounces-253040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC07Dc9ldGnb5AAAu9opvQ
	(envelope-from <netdev+bounces-253040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:25:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 878A07CB28
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C4633017265
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442D1280CC9;
	Sat, 24 Jan 2026 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAnOG9jN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9572580DE
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235677; cv=none; b=kIcYD2C3xMj2MIEGX/2IdhsuySoNOUX9VG7Qx1WBICo1qWN905OwwXYMNGeqbH73YOd83/gJY3IgzBEdmGv+jgT6GNoY05yyAdze4okZ/pD06aLN+ZM2TQqpX2TIOdrgu4nQkUGZYlyLOouBBRR9HsrrQjvKIhhr5DlSKczWJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235677; c=relaxed/simple;
	bh=6fOLPr5pZFj/RQ+K6yXNXzxNF1aapP52tKW6Swnvtbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6MhsX1KGUjkrSnI0GnczR2zH9WqocPMHCD9q4uT+9AAtiEtAZB6BZsdNnedbPmRGAlXTXb9KYhOAxoEjzibJ3z2PKZRGx4qtxoG7I/eGcUUFOwB2+p1TnRlttGJfFuR9KJKtqbQMaS7WcvUIMdcDfxC4WuJF6xpLy+GyugpPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAnOG9jN; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a743050256so19985315ad.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 22:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235675; x=1769840475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=GAnOG9jNJ2TOgwjjI475jP2tsUk1AIN1smo/Qyx34s+JXA9DgjvdBcYZZzZlssUDrx
         mvE5RIwQkVQhRXtkKdOZ/wR0s+8/TDJ/u8odXMpIuJX15/9gb+g7xu1cCUbgzgmQhaT7
         jF+9mLVLsyoHDe88oIdhOW01CsG5Kev8REsm5ZZyJVeGWsvQ8vp3AhLe6x2zX5jjpgPi
         2kg7RfNdPxxOVa2XsAMcRoO9LzgPmkUG3r3niNphoRSHHtqypgKT4aljQRxm2N7WqOaG
         6/xDkQ1VFR+D7PO40wHhmFC3SPI7Npd81Rlk4nnM1fD7N9HCbdag8hAbbftldrNm9YwD
         RAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235675; x=1769840475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=iuAazlauj7zQ2utU6dV2p9dLejznKKVlTVXjFJKi4fm20Eev1tK+cUSQRR8WIIRWa9
         rFQq0FkZ9e+pNrhuTxmi4RVUWwsFKUl+lV32/B8dhP5C5J2vPRnIR8XrUcW3XSo2pFSV
         q+p6u80HgalL0CtDRNElXmAwYMsYN4Ps9IYRr79E26VkdiX+DvarMPvVwvMciowP8aWH
         gtRtuIzhCkYyg67JsS0JogxmAUna7QVbNycIJQ5WbaBQd6BgjwTO7KXjAGPo+P8l8Dfm
         /d+YRwvmIN19u5B1mhXxuEwDAYWGWrVNG9pv5VqokxItadlkhZ8+H0dNRu/gwwgq/Fq2
         rKUw==
X-Forwarded-Encrypted: i=1; AJvYcCWJHp3ZKWY2QLNiP2gMtK6YvIPirmWbV+X26uvea3mrToX5lbtyguqb8QfZk0Ys2Tjo37DiQYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnuixbhDt1Cs8CL/1hk0qodNkzyOP8VuUUszheCK4RJtGCHuXe
	QhVDQOc5/nWnDdl3ISDDkRhBj6TvakTsCuk58aYqkyUXfINS62N800kA
X-Gm-Gg: AZuq6aKmJMfNLo0u/COevIq543pOWwnIKSTmIdzWA4K1zUDH6gnSygsLS6QoytOxfvP
	ED21ldAd178cVgbTVxXvfIDpPrzo36q0PJQgthePfMw6Ny6u9e5swBpEDmKhU+cc4fE6TUTx3ya
	Owvn5uKoxSmIWXihw7J6EmDIFhPofBScc2iZ+wFEjH21nJZEFBN7lw0VJJ8rJYppqWeP+0ltDnu
	USq3JK3ozkG4JlaMJqoNqXij5PHbAPymuWvlrh/vLHlYFwdRgkQg5u13Ohx4BclKRK1aNgP+TN1
	UdBD1aGrRzK5iqgNhrCQTLo/RIi1u83Jv6OVj52zYWs8OuFXx7Cdolao9pgoLbavOWQfo6X6KVY
	xTTU06DAW7qsuyKWAX1K76xnYMvdT9m8aJE+r9JiXx9+6F7Xxz3RF5pySHGgQv4/bLDXnLqjw4b
	NaBHUUl1hT
X-Received: by 2002:a17:90b:4c4b:b0:34e:5aa2:cf61 with SMTP id 98e67ed59e1d1-35368c436e7mr4201938a91.28.1769235675250;
        Fri, 23 Jan 2026 22:21:15 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:21:14 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
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
Subject: [PATCH bpf-next v13 06/13] bpf,x86: introduce emit_store_stack_imm64() for trampoline
Date: Sat, 24 Jan 2026 14:20:01 +0800
Message-ID: <20260124062008.8657-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	URIBL_RED(0.50)[chinatelecom.cn:mid,chinatelecom.cn:email];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253040-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.872];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,chinatelecom.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 878A07CB28
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


