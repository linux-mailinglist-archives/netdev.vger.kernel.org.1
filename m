Return-Path: <netdev+bounces-259485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCtAGj4fl2m9uwIAu9opvQ
	(envelope-from <netdev+bounces-259485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:33:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2665C15F887
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 615C2302A180
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C77E33F8BA;
	Thu, 19 Feb 2026 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XDu1ztxs"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2733EAE7
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511491; cv=none; b=QBNcYywh/w6SVuweYC6Y5iUE+wj2Q7g9vPdkHorMsGDdozX9VremznXkdnZ4xZwU4NUHW7sS4XBd1dP55Q/wMMk7HoSqYqshHjwHFW2I3EJGk9s7QM8HYATG5JKkc22kLOKywkJVhc3qKkvLbnUaN5wIjZZ1IM8ty3syvhCw3D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511491; c=relaxed/simple;
	bh=okXF8hqTMNtslj4tawfqT6rUWjNbqU+Szo2bMXHuVtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyhtXKmFcr+tnI3m60pPh0Wpj2svkte2AmwdfYBPlCOosksOuusnqWXzmid7NmOVKSzZUBdYzHioR73brboCF10PPpcNTsfmMc7bnCNVjgLKxxlqLL1iznw5AIWS2cb7pRUAFgs8vtzDQp6juUfIFDxFehfwUD3A51hkpLwyQDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XDu1ztxs; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771511487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9I9TydWVo15yKzkAGFLtCWQjvdOPQocpTW8F8p/JRI=;
	b=XDu1ztxsOwv2MmylQD0qb4UCW5fqcEoF4pFpbhXOIVlzj8Js4KnUzKViS3VL1nbB5t0aI6
	C0VmxmzJKZmbudyuazDQ2XpWcujZ2AsRVwShzv0kR39Hbv8mwH8uz8qS4aJawcAPwkLhxh
	vTPPAFLMR1eemfo9bIwXvWuSpLfUEVs=
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
Subject: [PATCH bpf-next v2 3/6] bpf, arm64: Add 64-bit bitops kfuncs support
Date: Thu, 19 Feb 2026 22:29:25 +0800
Message-ID: <20260219142933.13904-4-leon.hwang@linux.dev>
In-Reply-To: <20260219142933.13904-1-leon.hwang@linux.dev>
References: <20260219142933.13904-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,huaweicloud.com,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,fau.de,lists.infradead.org,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-259485-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2665C15F887
X-Rspamd-Action: no action

Implement JIT inlining of the 64-bit bitops kfuncs on arm64.

bpf_clz64(), bpf_ffs64(), bpf_fls64(), and bpf_bitrev64() are always
inlined using mandatory ARMv8 CLZ/RBIT instructions. bpf_ctz64() is
inlined via RBIT + CLZ, or via the native CTZ instruction when
FEAT_CSSC is available. bpf_rol64() and bpf_ror64() are always inlined
via RORV.

bpf_popcnt64() is not inlined as the native population count instruction
requires NEON/SIMD registers, which should not be touched from BPF
programs. It therefore falls back to a regular function call.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c | 123 ++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 7a530ea4f5ae..f03f732063d9 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1192,6 +1192,127 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	return 0;
 }
 
+static inline u32 a64_clz64(u8 rd, u8 rn)
+{
+	/*
+	 * Arm Architecture Reference Manual for A-profile architecture
+	 * (Document number: ARM DDI 0487)
+	 *
+	 *   A64 Base Instruction Descriptions
+	 *   C6.2 Alphabetical list of A64 base instructions
+	 *
+	 *   C6.2.91 CLZ
+	 *
+	 *     Count leading zeros
+	 *
+	 *     This instruction counts the number of consecutive binary zero bits,
+	 *     starting from the most significant bit in the source register,
+	 *     and places the count in the destination register.
+	 */
+	/* CLZ Xd, Xn */
+	return 0xdac01000 | (rn << 5) | rd;
+}
+
+static inline u32 a64_ctz64(u8 rd, u8 rn)
+{
+	/*
+	 * Arm Architecture Reference Manual for A-profile architecture
+	 * (Document number: ARM DDI 0487)
+	 *
+	 *   A64 Base Instruction Descriptions
+	 *   C6.2 Alphabetical list of A64 base instructions
+	 *
+	 *   C6.2.144 CTZ
+	 *
+	 *     Count trailing zeros
+	 *
+	 *     This instruction counts the number of consecutive binary zero bits,
+	 *     starting from the least significant bit in the source register,
+	 *     and places the count in the destination register.
+	 *
+	 *     This instruction requires FEAT_CSSC.
+	 */
+	/* CTZ Xd, Xn */
+	return 0xdac01800 | (rn << 5) | rd;
+}
+
+static inline u32 a64_rbit64(u8 rd, u8 rn)
+{
+	/*
+	 * Arm Architecture Reference Manual for A-profile architecture
+	 * (Document number: ARM DDI 0487)
+	 *
+	 *   A64 Base Instruction Descriptions
+	 *   C6.2 Alphabetical list of A64 base instructions
+	 *
+	 *   C6.2.320 RBIT
+	 *
+	 *     Reverse bits
+	 *
+	 *     This instruction reverses the bit order in a register.
+	 */
+	/* RBIT Xd, Xn */
+	return 0xdac00000 | (rn << 5) | rd;
+}
+
+static inline bool boot_cpu_supports_cssc(void)
+{
+	/*
+	 * Documentation/arch/arm64/cpu-feature-registers.rst
+	 *
+	 *   ID_AA64ISAR2_EL1 - Instruction set attribute register 2
+	 *
+	 *     CSSC
+	 */
+	return cpuid_feature_extract_unsigned_field(read_sanitised_ftr_reg(SYS_ID_AA64ISAR2_EL1),
+						    ID_AA64ISAR2_EL1_CSSC_SHIFT);
+}
+
+static bool bpf_inlines_func_call(struct jit_ctx *ctx, void *func_addr)
+{
+	const u8 tmp = bpf2a64[TMP_REG_1];
+	const u8 r0 = bpf2a64[BPF_REG_0];
+	const u8 r1 = bpf2a64[BPF_REG_1];
+	const u8 r2 = bpf2a64[BPF_REG_2];
+	bool inlined = true;
+
+	if (func_addr == bpf_clz64) {
+		emit(a64_clz64(r0, r1), ctx);
+	} else if (func_addr == bpf_ctz64 || func_addr == bpf_ffs64) {
+		if (boot_cpu_supports_cssc()) {
+			emit(a64_ctz64(r0, r1), ctx);
+		} else {
+			emit(a64_rbit64(tmp, r1), ctx);
+			emit(a64_clz64(r0, tmp), ctx);
+		}
+	} else if (func_addr == bpf_fls64) {
+		emit(a64_clz64(tmp, r1), ctx);
+		emit(A64_NEG(1, tmp, tmp), ctx);
+		emit(A64_ADD_I(1, r0, tmp, 64), ctx);
+	} else if (func_addr == bpf_bitrev64) {
+		emit(a64_rbit64(r0, r1), ctx);
+	} else if (func_addr == bpf_rol64) {
+		emit(A64_NEG(1, tmp, r2), ctx);
+		emit(A64_DATA2(1, r0, r1, tmp, RORV), ctx);
+	} else if (func_addr == bpf_ror64) {
+		emit(A64_DATA2(1, r0, r1, r2, RORV), ctx);
+	} else {
+		inlined = false;
+	}
+
+	return inlined;
+}
+
+bool bpf_jit_inlines_kfunc_call(void *func_addr)
+{
+	if (func_addr == bpf_clz64 || func_addr == bpf_ctz64 ||
+	    func_addr == bpf_ffs64 || func_addr == bpf_fls64 ||
+	    func_addr == bpf_rol64 || func_addr == bpf_ror64 ||
+	    func_addr == bpf_bitrev64)
+		return true;
+	return false;
+}
+
 /* JITs an eBPF instruction.
  * Returns:
  * 0  - successfully JITed an 8-byte eBPF instruction.
@@ -1598,6 +1719,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 					    &func_addr, &func_addr_fixed);
 		if (ret < 0)
 			return ret;
+		if (bpf_inlines_func_call(ctx, (void *) func_addr))
+			break;
 		emit_call(func_addr, ctx);
 		/*
 		 * Call to arch_bpf_timed_may_goto() is emitted by the
-- 
2.52.0


