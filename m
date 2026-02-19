Return-Path: <netdev+bounces-259484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGonBMoel2m9uwIAu9opvQ
	(envelope-from <netdev+bounces-259484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:31:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 867E515F7F1
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D96DC304FA4E
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84CB215F7D;
	Thu, 19 Feb 2026 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WATtM/3Q"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931D33A6FB
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511443; cv=none; b=SV83+IczBPlA6PTotZKivrdm7mTAPuk0a3NGXtsu4n0JFc7MhkV6zIuWxGJ3tt+LXk5VTFIb/D54sSqGr4kqzJ+wZe3WWClDUi+DaiUXh9QKdFtr11USZS5V5q97nEvU1gou4wi+GMidedaSnBwSbuGu2kfwM4a7zydY0Mw0rSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511443; c=relaxed/simple;
	bh=4ca/FLms+iViJ1tTVUEuHvLAF1+L3KEPpXg3rugt9ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0jaBdQ5eFz6DWwAEH8MgQZNeldWRRzpFCn0yRbUDLAjEQkP3LWqazLvbDYwdzalQGceTZcDq0suM30gI0E4t35z7ET6PoaQ4wlrQTidSmLnTvw6HOyFcFZ+XTKANKGcpMmyt/0/KgfIldoFj7t3k/BJhVAHwPJGocXtRPAnS7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WATtM/3Q; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771511440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbyH7r/+43Qi6pmkbYmF9oCsizXUoRzTF9X7Dq2Fsj8=;
	b=WATtM/3QzNXG5tUxfI9ZvXAHFtiYkE/toigRhrNoHvE1xC4pC3wH0zs+iR3XZEr9AyDElM
	sRqdRfkYLJJPNVpFvSttasDvnKplXkgPHcqyGcpy5M70F7J13M/is1d3qRiI9issMtdkeM
	xqMk/r3eiR5vHe5oCQOYbIj8/SO8e7E=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Peilin Ye <yepeilin@google.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Viktor Malik <vmalik@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 2/6] bpf, x86: Add 64-bit bitops kfuncs support for x86_64
Date: Thu, 19 Feb 2026 22:29:24 +0800
Message-ID: <20260219142933.13904-3-leon.hwang@linux.dev>
In-Reply-To: <20260219142933.13904-1-leon.hwang@linux.dev>
References: <20260219142933.13904-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259484-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,huaweicloud.com,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,fau.de,lists.infradead.org,vger.kernel.org,fb.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,wikipedia.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 867E515F7F1
X-Rspamd-Action: no action

Implement JIT inlining of the 64-bit bitops kfuncs on x86_64.

bpf_rol64() and bpf_ror64() are always supported via ROL/ROR.

bpf_ctz64() and bpf_ffs64() are supported when the CPU has
X86_FEATURE_BMI1 (TZCNT).

bpf_clz64() and bpf_fls64() are supported when the CPU has
X86_FEATURE_ABM (LZCNT).

bpf_popcnt64() is supported when the CPU has X86_FEATURE_POPCNT.

bpf_bitrev64() is not inlined as x86_64 has no native bit-reverse
instruction, so it falls back to a regular function call.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 141 ++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 070ba80e39d7..193e1e2d7aa8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -19,6 +19,7 @@
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
 #include <asm/cfi.h>
+#include <asm/cpufeatures.h>
 
 static bool all_callee_regs_used[4] = {true, true, true, true};
 
@@ -1604,6 +1605,127 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
 	*pprog = prog;
 }
 
+static bool bpf_inlines_func_call(u8 **pprog, void *func)
+{
+	bool has_popcnt = boot_cpu_has(X86_FEATURE_POPCNT);
+	bool has_bmi1 = boot_cpu_has(X86_FEATURE_BMI1);
+	bool has_abm = boot_cpu_has(X86_FEATURE_ABM);
+	bool inlined = true;
+	u8 *prog = *pprog;
+
+	/*
+	 * x86 Bit manipulation instruction set
+	 * https://en.wikipedia.org/wiki/X86_Bit_manipulation_instruction_set
+	 */
+
+	if (func == bpf_clz64 && has_abm) {
+		/*
+		 * Intel® 64 and IA-32 Architectures Software Developer's Manual (June 2023)
+		 *
+		 *   LZCNT - Count the Number of Leading Zero Bits
+		 *
+		 *     Opcode/Instruction
+		 *     F3 REX.W 0F BD /r
+		 *     LZCNT r64, r/m64
+		 *
+		 *     Op/En
+		 *     RVM
+		 *
+		 *     64/32-bit Mode
+		 *     V/N.E.
+		 *
+		 *     CPUID Feature Flag
+		 *     LZCNT
+		 *
+		 *     Description
+		 *     Count the number of leading zero bits in r/m64, return
+		 *     result in r64.
+		 */
+		/* emit: x ? 64 - fls64(x) : 64 */
+		/* lzcnt rax, rdi */
+		EMIT5(0xF3, 0x48, 0x0F, 0xBD, 0xC7);
+	} else if (func == bpf_ctz64 && has_bmi1) {
+		/*
+		 * Intel® 64 and IA-32 Architectures Software Developer's Manual (June 2023)
+		 *
+		 *   TZCNT - Count the Number of Trailing Zero Bits
+		 *
+		 *     Opcode/Instruction
+		 *     F3 REX.W 0F BC /r
+		 *     TZCNT r64, r/m64
+		 *
+		 *     Op/En
+		 *     RVM
+		 *
+		 *     64/32-bit Mode
+		 *     V/N.E.
+		 *
+		 *     CPUID Feature Flag
+		 *     BMI1
+		 *
+		 *     Description
+		 *     Count the number of trailing zero bits in r/m64, return
+		 *     result in r64.
+		 */
+		/* emit: x ? __ffs64(x) : 64 */
+		/* tzcnt rax, rdi */
+		EMIT5(0xF3, 0x48, 0x0F, 0xBC, 0xC7);
+	} else if (func == bpf_ffs64 && has_bmi1) {
+		/* emit: __ffs64(x); x == 0 has been handled in verifier */
+		/* tzcnt rax, rdi */
+		EMIT5(0xF3, 0x48, 0x0F, 0xBC, 0xC7);
+	} else if (func == bpf_fls64 && has_abm) {
+		/* emit: fls64(x) */
+		/* lzcnt rax, rdi */
+		EMIT5(0xF3, 0x48, 0x0F, 0xBD, 0xC7);
+		EMIT3(0x48, 0xF7, 0xD8);       /* neg rax */
+		EMIT4(0x48, 0x83, 0xC0, 0x40); /* add rax, 64 */
+	} else if (func == bpf_popcnt64 && has_popcnt) {
+		/*
+		 * Intel® 64 and IA-32 Architectures Software Developer's Manual (June 2023)
+		 *
+		 *   POPCNT - Return the Count of Number of Bits Set to 1
+		 *
+		 *     Opcode/Instruction
+		 *     F3 REX.W 0F B8 /r
+		 *     POPCNT r64, r/m64
+		 *
+		 *     Op/En
+		 *     RM
+		 *
+		 *     64 Mode
+		 *     Valid
+		 *
+		 *     Compat/Leg Mode
+		 *     N.E.
+		 *
+		 *     Description
+		 *     POPCNT on r/m64
+		 */
+		/* popcnt rax, rdi */
+		EMIT5(0xF3, 0x48, 0x0F, 0xB8, 0xC7);
+	} else if (func == bpf_rol64) {
+		EMIT1(0x51);             /* push rcx */
+		/* emit: rol64(x, s) */
+		EMIT3(0x48, 0x89, 0xF1); /* mov rcx, rsi */
+		EMIT3(0x48, 0x89, 0xF8); /* mov rax, rdi */
+		EMIT3(0x48, 0xD3, 0xC0); /* rol rax, cl */
+		EMIT1(0x59);             /* pop rcx */
+	} else if (func == bpf_ror64) {
+		EMIT1(0x51);             /* push rcx */
+		/* emit: ror64(x, s) */
+		EMIT3(0x48, 0x89, 0xF1); /* mov rcx, rsi */
+		EMIT3(0x48, 0x89, 0xF8); /* mov rax, rdi */
+		EMIT3(0x48, 0xD3, 0xC8); /* ror rax, cl */
+		EMIT1(0x59);             /* pop rcx */
+	} else {
+		inlined = false;
+	}
+
+	*pprog = prog;
+	return inlined;
+}
+
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
 #define __LOAD_TCC_PTR(off)			\
@@ -2452,6 +2574,8 @@ st:			if (is_imm8(insn->off))
 			u8 *ip = image + addrs[i - 1];
 
 			func = (u8 *) __bpf_call_base + imm32;
+			if (bpf_inlines_func_call(&prog, func))
+				break;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
 				ip += 7;
@@ -4117,3 +4241,20 @@ bool bpf_jit_supports_fsession(void)
 {
 	return true;
 }
+
+bool bpf_jit_inlines_kfunc_call(void *func_addr)
+{
+	if (func_addr == bpf_ctz64 || func_addr == bpf_ffs64)
+		return boot_cpu_has(X86_FEATURE_BMI1);
+
+	if (func_addr == bpf_clz64 || func_addr == bpf_fls64)
+		return boot_cpu_has(X86_FEATURE_ABM);
+
+	if (func_addr == bpf_popcnt64)
+		return boot_cpu_has(X86_FEATURE_POPCNT);
+
+	if (func_addr == bpf_rol64 || func_addr == bpf_ror64)
+		return true;
+
+	return false;
+}
-- 
2.52.0


