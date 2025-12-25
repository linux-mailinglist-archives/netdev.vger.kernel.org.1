Return-Path: <netdev+bounces-246051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E464CCDDB15
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E818030084FD
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174CC2FC881;
	Thu, 25 Dec 2025 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZOS1OEN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DA2F12AE
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766659517; cv=none; b=KALO1aVT0BUe9zM4ASPbsiF9p7uteJ2yh4soq0jtO0Nd1VKGJ9GmR9bFKxFX1x/1nhln9ZrVfyqLqFiMazGNA2RcT1ADRLGB4SgBhe4hEn5hSG05VS/b+HLavjyWj6OEsSHVEKSXQnvLDefFs58k/tz2VbjcMxCuacn6cEySIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766659517; c=relaxed/simple;
	bh=ooda17nRlgzaWXxyIFbJgZPuJX16QrZkoNK6HccLzn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IuU5esuGPqHf++EZBMCZCewrHDY/yeNFDxpENXbYKX7Dsa1/LxSrGzYf1K6cyF6RtvBmi7gQw29COY/r2m/rNbjShiBuAZ3j+MXs7yugwGBv9CQ7bJCpzS7Ex+VdIJevRH1aqoEL/KUsTFprd4DnQIT0pLw/SyWFhi/zQL3sv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZOS1OEN; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34c708702dfso6762843a91.1
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 02:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766659515; x=1767264315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xxF3kFQmHFC/i/qRiYm9vYsPAXcnfy31W/R9Oc0Ir4=;
        b=jZOS1OENxyCDycYyFRnAzbgDKGu8RGWN5fLhaRz0DtTXSWSA14R0z54n2nmcJQGZ1g
         wnDs2ZQKluUEWGYipQ0If8tGPxFskWCPBdad9vc47i+fkyiMLLh+rDq6yDPjvx6RHdxN
         xjnCHcXpASY4WhdXGDHWW2SA7voN3+hAYXgySiQjyJpMmSlg3o0YMVZZOKX5dRxpsTDA
         bidHh9MAOA7k3PSbdVTPVLofwjQ1Ho5aL0/N8oM1M7WKVU0byyuT3tipPiZgAXlf42qX
         ISwo+aP4bwDkwyazV3Tu/yA6ewJ6ZaDnMjqpMlcfi+7/0GVN+INy79agYOhpX13exk8A
         D+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766659515; x=1767264315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xxF3kFQmHFC/i/qRiYm9vYsPAXcnfy31W/R9Oc0Ir4=;
        b=xGCNh+/vLkhpu9UATymnuK2dzvT/HUPR8HeLhaObE6Wdb4gJzCeXVP1/hwrlYg3hpw
         UEcWXcxWouKr7D4fUAJGHl16Tn489IJLUvjfpucEB7mK+LTG8NoWzP0T/7ZylnrjL/nq
         e9iz1BQ8AGhMDi/eDn53Y69vUTcQo9fGszf4swVAwo7OF4O5aHyIPWiZQ3NOGkxR6vUo
         AHPd5vJEOmM4jJksw0Sh0B+dpoy7R9KLRGsyPWcsJWDaWBe39cLCDYWAbZnb9G/oc5C+
         tzhX0VSPWM2gY+HVPIRfCYpFmTKsK0/yhbnV2D+MQvnr9FMQhtpUXJHO73tZ/j00PPkM
         zHiA==
X-Forwarded-Encrypted: i=1; AJvYcCUl7WMY1wV2x7U904HXWq0ad53BE8/2zVeiXEyjCF5euWMrQT/MjDzwTWde+laOuge/YlIkZFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgflyPs8PF3W9zNKOjIOM82PwTH0eFdq45HUVpbQVZ2fSZu832
	1rtGXaJJagTr5QjgUKKjnRtn9BvbIyyy7Xx1V0+ghEMHnUfJdlVLucA/
X-Gm-Gg: AY/fxX6R1Id1TA9/i4nHqAylpOYoHD3cbIIHrIfi4iJpnyL+s5+0bZrVi1sUoY7rSlO
	QYeyPAVTq5Iwqynh5QDLedVWOuDcfCNsiT5845A3anEhvsUW+GE6Gkp4ns+H+uh2fG7BNo41Ai8
	7zYcPaaltvcMtImKTKTmykj43n8P8Fky665VCfuEieCkvx0eH+vaoqQMr/jDyR7zXR7Kp9JBdHx
	m0mJiklDFuSMJB4+95Pbb3uDsvZtCYvYvEaM9xKsDIh4iBab2Efov19PzxoQAD3nmiIzY46ICRX
	feMPWha1BOH+gVDVnYm2Vv6qVbEz6NG0FpPrItyRFiC1Gwnl7vLFiVUZRfXT5NCazVm5/u3BSKa
	WgHo8vPat7DAxWPps34MOtVw070NubtmlTu6DGuiMok349oICUH9fFjh5ezBLAVXJsxLYFvOvUQ
	v4uhpdQfVQ38vZ1Oli1g==
X-Google-Smtp-Source: AGHT+IFbVIhBTT0zROCFj/DYziq38CbJr650ni+iD1kul5A+SyuRB0jXgOZgjQFJ5hvYqb5XPA1zVA==
X-Received: by 2002:a17:90b:3c4e:b0:349:8116:a2d8 with SMTP id 98e67ed59e1d1-34e9211367cmr18738470a91.7.1766659514802;
        Thu, 25 Dec 2025 02:45:14 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac06fsm9091379a91.11.2025.12.25.02.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 02:45:14 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
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
	jiang.biao@linux.dev,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Thu, 25 Dec 2025 18:44:59 +0800
Message-ID: <20251225104459.204104-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
to obtain better performance. The instruction we use here is:

  65 48 8B 04 25 [offset] // mov rax, gs:[offset]

Not sure if there is any side effect here.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b69dc7194e2c..7f38481816f0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1300,6 +1300,19 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
+static void emit_ldx_percpu_r0(u8 **pprog, const void __percpu *ptr)
+{
+	u8 *prog = *pprog;
+
+	/* mov rax, gs:[offset] */
+	EMIT2(0x65, 0x48);
+	EMIT2(0x8B, 0x04);
+	EMIT1(0x25);
+	EMIT((u32)(unsigned long)ptr, 4);
+
+	*pprog = prog;
+}
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -2435,6 +2448,15 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			u8 *ip = image + addrs[i - 1];
 
+			if (insn->src_reg == 0 && (insn->imm == BPF_FUNC_get_current_task ||
+						   insn->imm == BPF_FUNC_get_current_task_btf)) {
+				if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
+					emit_ldx_percpu_r0(&prog, &const_current_task);
+				else
+					emit_ldx_percpu_r0(&prog, &current_task);
+				break;
+			}
+
 			func = (u8 *) __bpf_call_base + imm32;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
@@ -4067,3 +4089,14 @@ bool bpf_jit_supports_timed_may_goto(void)
 {
 	return true;
 }
+
+bool bpf_jit_inlines_helper_call(s32 imm)
+{
+	switch (imm) {
+	case BPF_FUNC_get_current_task:
+	case BPF_FUNC_get_current_task_btf:
+		return true;
+	default:
+		return false;
+	}
+}
-- 
2.52.0


