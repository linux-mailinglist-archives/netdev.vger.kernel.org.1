Return-Path: <netdev+bounces-246592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5390CEED0C
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 16:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A58493038F63
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7147923D7DE;
	Fri,  2 Jan 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CiljkX+c"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FFC23505E
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767366131; cv=none; b=Spm5n5zxtEke4YQf/EW5CbnNcXSbSAJ6+h2yIaeli1Z0+1MsOGfQ+V96tTsdaOeJ8nO4XjTywCLzGY36XCuhyM3fNMSw63n/XXFF1n0+0xQs+4FflqYMqOAJQNWeS3xDiwbqWqv6XjjHDtWpBWPXoSFuWYsI46RV48p/iqCbxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767366131; c=relaxed/simple;
	bh=OY1SBWq4Ap5M1NAc2V9iWM673yY4ujTgrAy/9xNzc+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MR97z0oPOMfzX3M4MnDaKfReOmYE1YuVxFFq99WX36NG7511jVpBVtZnuRUeCqOOh08Gqv0PGjAKF+LSr+XlS6l8ELVTkLKhHS/v5q2mFTQs9pJUVoxtE/ZMqwmL9JfbXMHGVeA7gmYLDKeSRjdicZ0Vsf/BEc2XMdVUlf7zgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CiljkX+c; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767366126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjHUFzrsqk2p5SI+Seak6yB69TLkO5KnxAZlltu8VN0=;
	b=CiljkX+cqHhZJB7ZlqBXKzmzY3XQReM24Odz2Ch2tN65WE9slo5Z85mQE+ILAgJPqr2Im7
	mLE/Ag4NWpe9g7232/7M/CRvmIwLuJRidJGsjRGDnVfIVpeZZGxi8PO4qDpg2KZgZj8UMG
	VZhWjy1LqrYgYwt/EVPSAbm1/EWuItM=
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
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next 3/4] bpf, arm64: tailcall: Eliminate max_entries and bpf_func access at runtime
Date: Fri,  2 Jan 2026 23:00:31 +0800
Message-ID: <20260102150032.53106-4-leon.hwang@linux.dev>
In-Reply-To: <20260102150032.53106-1-leon.hwang@linux.dev>
References: <20260102150032.53106-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Apply the same tail call optimization to arm64 as done for x86_64.

When the prog array map is known at verification time (dyn_array=false):
  - Embed max_entries as an immediate value instead of loading from memory
  - Use the precomputed target from array->ptrs[max_entries + index]
  - Jump directly to the cached target without dereferencing prog->bpf_func

When the map is dynamically determined (dyn_array=true):
  - Load max_entries from the array at runtime
  - Look up prog from array->ptrs[index] and compute the target address

Implement bpf_arch_tail_call_prologue_offset() returning
"PROLOGUE_OFFSET * 4" to convert the instruction count to bytes.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c | 71 +++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 0c4d44bcfbf4..bcd890bff36a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -620,8 +620,10 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	return 0;
 }
 
-static int emit_bpf_tail_call(struct jit_ctx *ctx)
+static int emit_bpf_tail_call(struct jit_ctx *ctx, u32 map_index, bool dyn_array)
 {
+	struct bpf_map *map = ctx->prog->aux->used_maps[map_index];
+
 	/* bpf_tail_call(void *prog_ctx, struct bpf_array *array, u64 index) */
 	const u8 r2 = bpf2a64[BPF_REG_2];
 	const u8 r3 = bpf2a64[BPF_REG_3];
@@ -638,9 +640,13 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	/* if (index >= array->map.max_entries)
 	 *     goto out;
 	 */
-	off = offsetof(struct bpf_array, map.max_entries);
-	emit_a64_mov_i64(tmp, off, ctx);
-	emit(A64_LDR32(tmp, r2, tmp), ctx);
+	if (dyn_array) {
+		off = offsetof(struct bpf_array, map.max_entries);
+		emit_a64_mov_i64(tmp, off, ctx);
+		emit(A64_LDR32(tmp, r2, tmp), ctx);
+	} else {
+		emit_a64_mov_i64(tmp, map->max_entries, ctx);
+	}
 	emit(A64_MOV(0, r3, r3), ctx);
 	emit(A64_CMP(0, r3, tmp), ctx);
 	branch1 = ctx->image + ctx->idx;
@@ -659,15 +665,26 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	/* (*tail_call_cnt_ptr)++; */
 	emit(A64_ADD_I(1, tcc, tcc, 1), ctx);
 
-	/* prog = array->ptrs[index];
-	 * if (prog == NULL)
-	 *     goto out;
-	 */
-	off = offsetof(struct bpf_array, ptrs);
-	emit_a64_mov_i64(tmp, off, ctx);
-	emit(A64_ADD(1, tmp, r2, tmp), ctx);
-	emit(A64_LSL(1, prg, r3, 3), ctx);
-	emit(A64_LDR64(prg, tmp, prg), ctx);
+	if (dyn_array) {
+		/* prog = array->ptrs[index];
+		 * if (prog == NULL)
+		 *     goto out;
+		 */
+		off = offsetof(struct bpf_array, ptrs);
+		emit_a64_mov_i64(tmp, off, ctx);
+		emit(A64_ADD(1, tmp, r2, tmp), ctx);
+		emit(A64_LSL(1, prg, r3, 3), ctx);
+		emit(A64_LDR64(prg, tmp, prg), ctx);
+	} else {
+		/* tgt = array->ptrs[max_entries + index];
+		 * if (tgt == 0)
+		 *     goto out;
+		 */
+		emit(A64_LSL(1, prg, r3, 3), ctx);
+		off = offsetof(struct bpf_array, ptrs) + map->max_entries * sizeof(void *);
+		emit_a64_add_i(1, prg, prg, tmp, off, ctx);
+		emit(A64_LDR64(prg, r2, prg), ctx);
+	}
 	branch3 = ctx->image + ctx->idx;
 	emit(A64_NOP, ctx);
 
@@ -680,12 +697,17 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 
 	pop_callee_regs(ctx);
 
-	/* goto *(prog->bpf_func + prologue_offset); */
-	off = offsetof(struct bpf_prog, bpf_func);
-	emit_a64_mov_i64(tmp, off, ctx);
-	emit(A64_LDR64(tmp, prg, tmp), ctx);
-	emit(A64_ADD_I(1, tmp, tmp, sizeof(u32) * PROLOGUE_OFFSET), ctx);
-	emit(A64_BR(tmp), ctx);
+	if (dyn_array) {
+		/* goto *(prog->bpf_func + prologue_offset); */
+		off = offsetof(struct bpf_prog, bpf_func);
+		emit_a64_mov_i64(tmp, off, ctx);
+		emit(A64_LDR64(tmp, prg, tmp), ctx);
+		emit(A64_ADD_I(1, tmp, tmp, sizeof(u32) * PROLOGUE_OFFSET), ctx);
+		emit(A64_BR(tmp), ctx);
+	} else {
+		/* goto *tgt; */
+		emit(A64_BR(prg), ctx);
+	}
 
 	if (ctx->image) {
 		off = &ctx->image[ctx->idx] - branch1;
@@ -701,6 +723,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	return 0;
 }
 
+int bpf_arch_tail_call_prologue_offset(void)
+{
+	/* offset is in instructions, convert to bytes */
+	return PROLOGUE_OFFSET * 4;
+}
+
 static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
 {
 	const s32 imm = insn->imm;
@@ -1617,7 +1645,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	}
 	/* tail call */
 	case BPF_JMP | BPF_TAIL_CALL:
-		if (emit_bpf_tail_call(ctx))
+		bool dynamic_array = (insn->imm >> 8) & 0xFF;
+		u32 map_index = insn->imm & 0xFF;
+
+		if (emit_bpf_tail_call(ctx, map_index, dynamic_array))
 			return -EFAULT;
 		break;
 	/* function return */
-- 
2.52.0


