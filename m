Return-Path: <netdev+bounces-259483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PRenFZMel2m9uwIAu9opvQ
	(envelope-from <netdev+bounces-259483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:30:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFF215F7CD
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A8E3301060F
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B381133FE11;
	Thu, 19 Feb 2026 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LdLGVj3J"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED433F8DA
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511431; cv=none; b=f1nNH2GfOoK4P4nlzPovO/EnHrQDVbLmk4bFO/3iRFRScr+KF1P940CyATkBUvR9kazgTpXf+hGSVZSbgRMuur5Rkf8eKBKlqSgSMCpYJE3KRR2eKKv/cHRbZlAVTpvlnu2VPHA2OcsXxKDrliPtwrxnDT1yl7B4nNe87oxCe1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511431; c=relaxed/simple;
	bh=NV9xlLs/FXCt8nqvw59dK19Va73ZVQVrRXiraIES+Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKwTmXI98KnUa+DtqOUIQxq/EhmYV+7ezmpJ8C1Uo8Gx5QqxJd54AlhulI3PM66WfwHjD/78pxaRqfnmnkC1OlpwnirKZxLa+XJlYZ5Ys8pYb4UbVNjgYxrNPIfMJxHBSQmjTecU5inWaPR5d7KzTMiWk71O7dUziN44v8shqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LdLGVj3J; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771511428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+sGQUoFknPrYwnhrHGJoAgCpCs1zVsEElKhl0yi99I=;
	b=LdLGVj3JZVjoaC4PviPKhiaOGm4q8cPa83+pWAmoAjKnYhX5qUqu+FxPsdRrQXpeF0GQLE
	Zwqhen5nJJovrxh5oVLCDsPl+TM+8VTaL8zh3tlcVVGXorFEutTkIBqXrR4uvHnjdmooml
	pogdAz+4IAVZMGWa44hnUB7tulcT+UM=
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
Subject: [PATCH bpf-next v2 1/6] bpf: Introduce 64-bit bitops kfuncs
Date: Thu, 19 Feb 2026 22:29:23 +0800
Message-ID: <20260219142933.13904-2-leon.hwang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,huaweicloud.com,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,fau.de,lists.infradead.org,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-259483-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDFF215F7CD
X-Rspamd-Action: no action

Add the following generic 64-bit bitops kfuncs:

* bpf_clz64(): Count leading zeros.
* bpf_ctz64(): Count trailing zeros.
* bpf_ffs64(): Find first set bit, 1-based index, returns 0 when input
  is 0.
* bpf_fls64(): Find last set bit, 1-based index.
* bpf_bitrev64(): Reverse bits.
* bpf_popcnt64(): Population count.
* bpf_rol64(): Rotate left.
* bpf_ror64(): Rotate right.

Defined zero-input behavior:

* bpf_clz64(0) = 64
* bpf_ctz64(0) = 64
* bpf_ffs64(0) = 0
* bpf_fls64(0) = 0

These kfuncs are inlined by JIT backends when the required CPU features are
available. Otherwise, they fall back to regular function calls.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/filter.h | 10 ++++++++
 kernel/bpf/core.c      |  6 +++++
 kernel/bpf/helpers.c   | 50 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c  | 53 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 44d7ae95ddbc..b8a538bec5c6 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1157,6 +1157,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
+bool bpf_jit_inlines_kfunc_call(void *func_addr);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
@@ -1837,4 +1838,13 @@ static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
 }
 #endif /* CONFIG_NET */
 
+u64 bpf_clz64(u64 x);
+u64 bpf_ctz64(u64 x);
+u64 bpf_ffs64(u64 x);
+u64 bpf_fls64(u64 x);
+u64 bpf_popcnt64(u64 x);
+u64 bpf_bitrev64(u64 x);
+u64 bpf_rol64(u64 x, u64 s);
+u64 bpf_ror64(u64 x, u64 s);
+
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5ab6bace7d0d..5f37309d83fc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3114,6 +3114,12 @@ bool __weak bpf_jit_inlines_helper_call(s32 imm)
 	return false;
 }
 
+/* Return TRUE if the JIT backend inlines the kfunc. */
+bool __weak bpf_jit_inlines_kfunc_call(void *func_addr)
+{
+	return false;
+}
+
 /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool __weak bpf_jit_supports_subprog_tailcalls(void)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7ac32798eb04..6bf73c46af72 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -29,6 +29,8 @@
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
 #include <linux/buildid.h>
+#include <linux/bitops.h>
+#include <linux/bitrev.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -4501,6 +4503,46 @@ __bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
 	}
 }
 
+__bpf_kfunc u64 bpf_clz64(u64 x)
+{
+	return x ? 64 - fls64(x) : 64;
+}
+
+__bpf_kfunc u64 bpf_ctz64(u64 x)
+{
+	return x ? __ffs64(x) : 64;
+}
+
+__bpf_kfunc u64 bpf_ffs64(u64 x)
+{
+	return x ? __ffs64(x) + 1 : 0;
+}
+
+__bpf_kfunc u64 bpf_fls64(u64 x)
+{
+	return fls64(x);
+}
+
+__bpf_kfunc u64 bpf_popcnt64(u64 x)
+{
+	return hweight64(x);
+}
+
+__bpf_kfunc u64 bpf_bitrev64(u64 x)
+{
+	return ((u64)bitrev32(x & 0xFFFFFFFF) << 32) | bitrev32(x >> 32);
+}
+
+__bpf_kfunc u64 bpf_rol64(u64 x, u64 s)
+{
+	return rol64(x, s);
+}
+
+__bpf_kfunc u64 bpf_ror64(u64 x, u64 s)
+{
+	return ror64(x, s);
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4578,6 +4620,14 @@ BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
 #endif
 #endif
+BTF_ID_FLAGS(func, bpf_clz64, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_ctz64, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_ffs64, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_fls64, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_popcnt64, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_bitrev64, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_rol64, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_ror64, KF_FASTCALL)
 BTF_KFUNCS_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0162f946032f..2cb29bc1b3c3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12461,6 +12461,14 @@ enum special_kfunc_type {
 	KF_bpf_session_is_return,
 	KF_bpf_stream_vprintk,
 	KF_bpf_stream_print_stack,
+	KF_bpf_clz64,
+	KF_bpf_ctz64,
+	KF_bpf_ffs64,
+	KF_bpf_fls64,
+	KF_bpf_bitrev64,
+	KF_bpf_popcnt64,
+	KF_bpf_rol64,
+	KF_bpf_ror64,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12541,6 +12549,14 @@ BTF_ID(func, bpf_arena_reserve_pages)
 BTF_ID(func, bpf_session_is_return)
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
+BTF_ID(func, bpf_clz64)
+BTF_ID(func, bpf_ctz64)
+BTF_ID(func, bpf_ffs64)
+BTF_ID(func, bpf_fls64)
+BTF_ID(func, bpf_bitrev64)
+BTF_ID(func, bpf_popcnt64)
+BTF_ID(func, bpf_rol64)
+BTF_ID(func, bpf_ror64)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -18204,6 +18220,34 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	}
 }
 
+static bool bpf_kfunc_is_fastcall(struct bpf_verifier_env *env, u32 func_id, u32 flags)
+{
+	if (!(flags & KF_FASTCALL))
+		return false;
+
+	if (!env->prog->jit_requested)
+		return true;
+
+	if (func_id == special_kfunc_list[KF_bpf_clz64])
+		return bpf_jit_inlines_kfunc_call(bpf_clz64);
+	if (func_id == special_kfunc_list[KF_bpf_ctz64])
+		return bpf_jit_inlines_kfunc_call(bpf_ctz64);
+	if (func_id == special_kfunc_list[KF_bpf_ffs64])
+		return bpf_jit_inlines_kfunc_call(bpf_ffs64);
+	if (func_id == special_kfunc_list[KF_bpf_fls64])
+		return bpf_jit_inlines_kfunc_call(bpf_fls64);
+	if (func_id == special_kfunc_list[KF_bpf_bitrev64])
+		return bpf_jit_inlines_kfunc_call(bpf_bitrev64);
+	if (func_id == special_kfunc_list[KF_bpf_popcnt64])
+		return bpf_jit_inlines_kfunc_call(bpf_popcnt64);
+	if (func_id == special_kfunc_list[KF_bpf_rol64])
+		return bpf_jit_inlines_kfunc_call(bpf_rol64);
+	if (func_id == special_kfunc_list[KF_bpf_ror64])
+		return bpf_jit_inlines_kfunc_call(bpf_ror64);
+
+	return true;
+}
+
 struct call_summary {
 	u8 num_params;
 	bool is_void;
@@ -18246,7 +18290,7 @@ static bool get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call
 			/* error would be reported later */
 			return false;
 		cs->num_params = btf_type_vlen(meta.func_proto);
-		cs->fastcall = meta.kfunc_flags & KF_FASTCALL;
+		cs->fastcall = bpf_kfunc_is_fastcall(env, meta.func_id, meta.kfunc_flags);
 		cs->is_void = btf_type_is_void(btf_type_by_id(meta.btf, meta.func_proto->type));
 		return true;
 	}
@@ -23186,6 +23230,13 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
 		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
 		*cnt = 6;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_ffs64] &&
+		   bpf_jit_inlines_kfunc_call(bpf_ffs64)) {
+		insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, 0);
+		insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 2);
+		insn_buf[2] = *insn;
+		insn_buf[3] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1);
+		*cnt = 4;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.52.0


