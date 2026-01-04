Return-Path: <netdev+bounces-246759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 939CCCF0FB5
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 14:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0D653032FE5
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 13:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F93302163;
	Sun,  4 Jan 2026 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC19nzPq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E430148D
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767532630; cv=none; b=DMQoh6bPrZtun7SoS/V7+AdpnSQym7rnl5HrdQwR3h7n2jzQtmnaTDqhpXbuFlxCBGRnVqMqwCWjH0SyvGrrslP3roKT2wdvmwj2uyXspcUaVcYWhwNoJ0FkWImrqAEKhfkaDDB/N01KP4bBWUBY2Ys6AGJCbV9TZ3wiqq80l30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767532630; c=relaxed/simple;
	bh=/qur8w2m3vMGNgXbvDT1SsOMMmCsCxiM8C5YcQdLMW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuXvwJoD7jIdgi5VyyJodalK6ifg192UhNuo7aCwvuWoNDx95770/7LNOGEKWV4y6N+Lg3JnGMbNdx6NVv9i/RQR553YlEctfQ21yV/ZTGuBGEGJoFUBErpymzF7uwtHRO5pqkQWoV7KPbSuSbyVEJmc+RRJQMbx9oW0NPJ9AH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eC19nzPq; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34b75f7a134so9664955a91.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 05:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767532625; x=1768137425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZWi9RoYleJZ65oSevNjm7jxGwIwYCJsYhnSjqS+rL0=;
        b=eC19nzPqpukaTS/kMlsUq6SmoU3TEpSkG1Kuyvwf35oWlxAdSrUVd31/X4fEfpjKWi
         2Jii6diZL0WU//ZLmfzC16N7ngU3rctdDeAIafWtM+sH4GRVovLX9St6Uk10TkYR32W7
         BueWSJU0qNBh8GnZOt4Te3Ab1/gcg+Ut3iLThKkCj6O89m+0vD7KWCxxmaGYZcCCyS58
         nu5oInQoFaD+2uJKrGXkZ4m/Qx2ZsWz+R+kJUV0YQVWUbjBCOkGw9T16dCc5kw36/xJ6
         thWnkRQ2q2iqsBefjuqxYM0UBLq71yrwku27BufL3VsW6RnGLiIe8x0HrpBqsiRfoxb/
         vFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767532625; x=1768137425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BZWi9RoYleJZ65oSevNjm7jxGwIwYCJsYhnSjqS+rL0=;
        b=cyx1JDgouBesdAEo31L7pOc+mOyKDo97DQ3NEmbdMucwc+T2K1qxCEWHv4BYR9KzLN
         SZ1lpfp4lBFSvPdtbYFlHhSJuAvyfndx15oIjwtl8pSWbgBh+WfyDUvlfKwUemitWYp4
         6xaG60/3U2B7yDhqlOHq0wf2THLUO965AIiXdbwtQE4qDebKmyt+Jno6SJdzAJnAGNsF
         Ca3yMFTgHgsgIDcaNmZQgrVW7PdPCiRZVabluowSJm//ybMSsgXuO2gaWMXZy/eCi4rM
         F1xUmngdkzIDF8dF4Y95PyXcA8OKgAKTj8wd+ZLTNfo1IeMDb5e63bZIqkUzrOTgfDcq
         ayXg==
X-Forwarded-Encrypted: i=1; AJvYcCWUtGDFG/oRnnBNd+CpWq32dqIVrPqC9cBpYaz1U1ReqdvF0PgHDIKqx0kHUA/XF/3EgTqwZn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpOzPF9MW2SCUr8drrLtqjeI+4/AoILpgVDcbTu3NLeTb0tUso
	aScIbRcanlumSTK+wQXSLaCZ3aJXIhO+RuMiwPO6ZQdJgas9ptVpS+q2IBNLqPuCjYo2iQ==
X-Gm-Gg: AY/fxX69z5ncOxrNVsULwTo8OLoGEs6BHW/hg/Pz2VKNuMn/7gXJP4RdAlL7VKj57n4
	aVIcKll5R8t5f1cIuaCvoZ7xhj7FRAn/e9hhBFeSmWTfXbuRqkowJQ+0hAoZ5Vj0Sw54Z1R9fJJ
	37stdrWA0ZaXKxA+Ns73W5cZfszA4l2T6vUw7CmogezV0hTCfXDQX1WWvh1OVzqIerg9LtPSHF3
	aKsL75dXCd8e4LibFqpInUNj12UrUz64b/lbFghstJ2MAAMgLIpVuJi3+orrbPKkf8mR1RBcHyY
	QXOHSLoO6SsaFaYeu2NirstNAZHS/n1WwiVEnU1xA6FqWR6AN9u+nI6ANYj/1BiHifK5FMAmD/4
	0g8W1MpTf6i2iB+U/B41j4vi0guHI7OXex8k2tbouOoXyKF2cgmwDqvcBFl2MzcUt0AhNK6wi2a
	O9imVE8ZE=
X-Google-Smtp-Source: AGHT+IG0dPYNFfnc0boh/nEnep4wDuUjmOO/6IO4xvFFOws0Hne1b/dfxRdokETIhohuNf3Ig79YzQ==
X-Received: by 2002:a17:90b:3f90:b0:340:bc27:97bd with SMTP id 98e67ed59e1d1-34e92129212mr35917760a91.9.1767532624769;
        Sun, 04 Jan 2026 05:17:04 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f4777b765sm3701582a91.17.2026.01.04.05.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 05:17:04 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/2] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Sun,  4 Jan 2026 21:16:34 +0800
Message-ID: <20260104131635.27621-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104131635.27621-1-dongml2@chinatelecom.cn>
References: <20260104131635.27621-1-dongml2@chinatelecom.cn>
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

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- check the variable type in emit_ldx_percpu_r0 with __verify_pcpu_ptr
- remove the usage of const_current_task
---
 arch/x86/net/bpf_jit_comp.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3b1c4b1d550..f5ff7c77aad7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1300,6 +1300,25 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
+static void __emit_ldx_percpu_r0(u8 **pprog, __force unsigned long ptr)
+{
+	u8 *prog = *pprog;
+
+	/* mov rax, gs:[ptr] */
+	EMIT2(0x65, 0x48);
+	EMIT2(0x8B, 0x04);
+	EMIT1(0x25);
+	EMIT((u32)ptr, 4);
+
+	*pprog = prog;
+}
+
+#define emit_ldx_percpu_r0(prog, variable)					\
+	do {									\
+		__verify_pcpu_ptr(&(variable));					\
+		__emit_ldx_percpu_r0(&prog, (__force unsigned long)&(variable));\
+	} while (0)
+
 static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -2441,6 +2460,12 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			u8 *ip = image + addrs[i - 1];
 
+			if (insn->src_reg == 0 && (insn->imm == BPF_FUNC_get_current_task ||
+						   insn->imm == BPF_FUNC_get_current_task_btf)) {
+				emit_ldx_percpu_r0(prog, current_task);
+				break;
+			}
+
 			func = (u8 *) __bpf_call_base + imm32;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
@@ -4082,3 +4107,14 @@ bool bpf_jit_supports_timed_may_goto(void)
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


