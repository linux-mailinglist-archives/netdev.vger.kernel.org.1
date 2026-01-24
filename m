Return-Path: <netdev+bounces-253012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPRQB+09dGnp3gAAu9opvQ
	(envelope-from <netdev+bounces-253012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:35:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C827F7C5AD
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3362730630D4
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 03:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5E326A0A7;
	Sat, 24 Jan 2026 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4sTzHWN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B13EBF3C
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 03:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225548; cv=none; b=cUvNUB/HJ2aL1oqUua8h1vodow0rpmh5myn2TaXQcD7j0g43m3YsGDb5n5J1b45tWa+SiQdFW1a1+adCVfCmslsEEguWdsnJ1Qr1pHhW8sZpS9szyyXIVabwlezR6kVZJ60S48aVxnDtB2pZ3S5nC47uiWFROy84tQm9lv26zUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225548; c=relaxed/simple;
	bh=6fOLPr5pZFj/RQ+K6yXNXzxNF1aapP52tKW6Swnvtbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrkwNbA9hluHuD+03jczlQ21irPwWsJRYJlxVux2VIFHpiRQzi9Spym3wyMAiIVs5Msd//1lImne+0oqZJepGCXqXxEvrxDnBiXUPYvD34j8ji0Xx46vBoiZ2k4EDiypfm9iwL8iUrqDfXM95lyKlThFicu6zbVqbApVkdw/W/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4sTzHWN; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a76f90872cso15233265ad.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225545; x=1769830345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=P4sTzHWN3PRDg0w0+2vgfYEanXxQwsSwI5djxfUsdXnEx0gwJbjRlFOtAwFoANjWvK
         Z4wTCb4T3A41r4t3Q/PphmNDFBZXslJYpsK/Zw05O4Iivq0nCc5uakFvpAxIkte1fxKs
         P3lUPaxtSnNdktQq3NszGF2T1Q+sbKK+dYFlF5JGprZiXPkgCxDhSRm5J7QhA/6aqNl7
         Ld64zW3potEWsHmLCthRwQODsAf034rD4vEep19b0dMcJVK27aNJgwi6t0NQMiBzR0HU
         W5B+rfBmICh61KvG/ywI6yewLwNWJ63J8hLgbtb4XUFMNcfbMGW0Q9z1wK7MShf/MHKj
         ro/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225545; x=1769830345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3QmrLYBEBYXBAfPFlkqBudM2njHTQyGi8eiKfdRBPI=;
        b=r6WAYhJhVcz1SIMyqPACr/YhO+9iD3LnDACtVIP7k/6glpU9VIpYhibdImq1sJUN8l
         xGpZZSWVQjuxCJhRmLOK8OatzSKGGCQONjOfnXDDbMqQytNJz2zczxTxs6kemNHZVuHA
         J7uKU1YqZREQWVdWbZhPggKW/X2MB76W2v+8pnGtFEvEYW1pT0h10M3MqpcdZ+nmI5uB
         ZUuZcf5wIUXtZaDKnCng6Vc+EqnhQINHlrl/EWjb9d6LhdCZb3Mfr2+xCULKp4dE0g08
         V0yjpdnNi+tO8ILkac29O8ayp+5+WzbdqP9VtOmCOPR2Jt/6SEs0VeiLFCCJD/USXxna
         9A1A==
X-Forwarded-Encrypted: i=1; AJvYcCVeVpYMrmvPkTYAEoiom9IxRZLgYAsG0PkicJwncuzDvOOassB1dmQ94jpJkpbaDop4zMez2rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDPh9Q+7R1MzwAMNJfsBUJfDss+75VSjYt1xp2ZlAasGNBSnh
	FBKOkoGk7G42o7GcYZH0+uNXJcHP6mI7mkvCkLhuaYWBUtWrd8RZeCSX
X-Gm-Gg: AZuq6aIMOQ6dTmu13GcFCF0uSWqEjJoSKx3XM8VaowShv7v3w1hyqa6+GHN2t8paRzX
	3S6T6gABrugQUiMfIzXNCXVR+8vZix95+7IWkCbeAOOjcuuvkYh+s2RGb9VTx+0FlFwhC7SBbJE
	rD7GwnzJvEtJi7Yvny4ItAWY7XMTV+N/2uvZvhLiWQMMJKcJrv5Ga/0t1Fmztmy5085885+Aenx
	XYco2nARwLareZY7oOyKuEWn96qntVIpFS5Y7KkLs1/NnHl3uxVrfsyf6SvFFamZyC5BCTT7WQj
	thcpRP2JsPq/jzWUzPePo1ndTjIFr4AZv764Gq1OZ+qiTNrs5hLTe/huRkw/CiOne4zAM0rQLXl
	xt57bd2UKYXW4YYoOPgC7nBXGibICh6CPlGeYXdIad495p5xGyKajBVaKDsYLLRoyaCdlzF4BBT
	jpIcIqZXVQ
X-Received: by 2002:a17:903:2443:b0:2a7:f369:4de8 with SMTP id d9443c01a7336-2a7fe73eb13mr49369805ad.42.1769225545358;
        Fri, 23 Jan 2026 19:32:25 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:32:25 -0800 (PST)
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
Subject: [PATCH bpf-next v12 06/13] bpf,x86: introduce emit_store_stack_imm64() for trampoline
Date: Sat, 24 Jan 2026 11:31:12 +0800
Message-ID: <20260124033119.28682-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
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
	TAGGED_FROM(0.00)[bounces-253012-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.852];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,chinatelecom.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C827F7C5AD
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


