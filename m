Return-Path: <netdev+bounces-247779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 152F9CFE5E0
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A0D130B8CF4
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448434DCC9;
	Wed,  7 Jan 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="a43gj3jN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C10A34DB60
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796112; cv=none; b=muVVH/RDCMLLk5qbBns26eEr/konlPSWyIh6tNZimney2WJ3EoLn2UTGC+pY79RXbNXz3q7gZyzyKJkfg4w+lZkZc3rgBTOPHy8a3DcO3YwZxx2jWh4Hv4c25MUK5gIFzBl7Grlb9x9Z0YGPjyKzdLpjEYbtiJuHmzh3IXA2AZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796112; c=relaxed/simple;
	bh=9Nkg5+9yHPlpPwp9nF6PKpTxzXwCWPm/mZB+YcWF76s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j3VpwDDmiLmTC+AGHaQ5Jj90G2gGpqJ9NVHuyzS4VbKwAzGlJ/q+N0t8dY3x/hASUXEM9VWc6++GwgWtfIymvtrIM2gWAFJneGDGe9bMZQc963r7aNR5I+R7lWPqbGaTxpo31ngdHMhL/35biBoxs3Fk6mmqLhh52D1b/Wo4nTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=a43gj3jN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79ea617f55so440777566b.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796107; x=1768400907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/14zXsBs003XOvy4U1i82NqonKMu3HQa+ln0OAs3us=;
        b=a43gj3jNdfdYSv4gSSQS1oeN9NV32Ra8DtqbY0X7Vsy4hETHQOptKzlRPAzSfW5C5J
         rqYsS0BxJUHewgw26mvVzXNfgt3thkrIKFG31h+4UcHp0Ls1o87201G4kq+71TWrRSCj
         Wza6WJePRH9B+7gbHGbP4RBHBxPJygffji6TbH3E+aCLGdSvmDw3pEjvPqstcFSVqY6h
         D74V3Nl52qyvee6ZS6NLG+eCYDQcevBW/Hexfq9k/4eAaSZ9Zb0ghbqGctCwyDpimU5t
         CdowmE8eB2zONDsAMfJNV0jtR/VcUcYa/eSBLfFdmGqd0GO3WPfm/MrxPXXnt/17q8M1
         Bt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796107; x=1768400907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4/14zXsBs003XOvy4U1i82NqonKMu3HQa+ln0OAs3us=;
        b=I+Fd7LTCf4OXmPd9vfGwU825sKwSwZy/VXKwjw1cGI3FtTPqlQpSEuuT+u+uJoLxy1
         Oq+vkR4qZ+b/Ba23tPxNBe17jFRy9272tN6cjK37X3GHRDR/ITRvEL/GUsNQNiFGdx1h
         gRVHuyQQ1mVkqjDM4Qhe/+1nTuc2GvHhHRJYCPlxdcheDEOnEkSrUk0jzGVD0Rn+1TWC
         gpgNpdedMZ9sNDy5jFNSCh6t+FYIzIEVg9qAjeNLBdbUHp9FvSxqDAnjwkGgUi6K1uYl
         ZVM6BG2nJWQ2wSbf5awTDeYMKbGXo1pVAhNfPhnrA71Eg1WTUPK45spemwvt+6Eugik5
         1gGw==
X-Gm-Message-State: AOJu0YxIBy9m90O0r3BoTkSUsgKIrV0FL8dbYiX2PTnoo0Ed38DVxiFy
	ZYTlXa12VaEcm8cmTlmnmFfrrN1VV0D6CKj1GN4SHn00gd+dzmKSwFraR4PJ9NoHpF0=
X-Gm-Gg: AY/fxX7+1wutiKgu7rQvDizJqCaOMWl2z3X0mhUear1p67uTfjLXz0XhVZ9blslWSLO
	7epNipsY+z/uV8kA/SjzTnFMzaLt9rRyrzsZ0TBT1SpRor1D/6gPIWWq7hhDddFLYsBbqcWIfPO
	knyffqQ5QE/xZrbijeC+DUiP08KQvrrUnhlagAtWEFoO+vJIyxuyHUXVsfhrrP85Fu3X4Dtst8a
	XiLOMQB80g6pZ+EiEVFoavliCv/ebvuMoLM+bdB1HfVTt01ZoQ6sAgAgjQEsn8wAecBd7fs6VHI
	Pt044nik4FzuPxZMYaMHm4KOGVe8C1mBsxv5LFqI1b6a2r0w+35sTIb4dv/KSyPReP7Rx2yNfni
	w01QRM53d3XNYrDSFGwfT5LTpCaiAUlQWAsLOeDt1nHwg3DTtw6t0f+6w0BLWfn5DL2Opm5859s
	cHyv883E0yBgDl1yfb4nga2T3Xpfi8qfhPXpCgD/iOHqTok/6vHYs6jSX5EI8=
X-Google-Smtp-Source: AGHT+IFuKBW87SwWKv45NowNyF6gDSC4dEqUaQmH0tDRwaae0GNWQln5Te3nVrJsyyGSAJHCYyWCOw==
X-Received: by 2002:a17:906:fe05:b0:b75:7b39:847a with SMTP id a640c23a62f3a-b8445216dccmr283429566b.60.1767796107483;
        Wed, 07 Jan 2026 06:28:27 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a235c0fsm527881766b.9.2026.01.07.06.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:27 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:15 +0100
Subject: [PATCH bpf-next v3 15/17] bpf, verifier: Support direct kernel
 calls in gen_prologue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-15-0d461c5e4764@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare ground for the next patch to emit a call to a regular kernel
function, not a kfunc or a BPF helper, from the prologue generator using
BPF_EMIT_CALL.

These calls use offsets relative to __bpf_call_base and must bypass the
verifier's patch_call_imm fixup, which expects BPF helper IDs rather than
pre-resolved offsets.

Add a finalized_call flag to bpf_insn_aux_data to mark call instructions
with finalized offsets so the verifier can skip patch_call_imm fixup for
these calls.

As a follow-up, existing gen_prologue and gen_epilogue callbacks using
kfuncs can be converted to BPF_EMIT_CALL, removing the need for kfunc
resolution during prologue/epilogue generation.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 12 ++++++++++++
 net/core/filter.c            |  5 +++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b32ddf0f0ab3..9ccd56c04a45 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -561,6 +561,7 @@ struct bpf_insn_aux_data {
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
+	bool finalized_call; /* call holds function offset relative to __bpf_base_call */
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 76f2befc8159..219e233cc4c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21816,6 +21816,14 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			env->prog = new_prog;
 			delta += cnt - 1;
 
+			/* gen_prologue emits function calls with target address
+			 * relative to __bpf_call_base. Skip patch_call_imm fixup.
+			 */
+			for (i = 0; i < cnt - 1; i++) {
+				if (bpf_helper_call(&env->prog->insnsi[i]))
+					env->insn_aux_data[i].finalized_call = true;
+			}
+
 			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
 			if (ret < 0)
 				return ret;
@@ -23422,6 +23430,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 patch_call_imm:
+		if (env->insn_aux_data[i + delta].finalized_call)
+			goto next_insn;
+
 		fn = env->ops->get_func_proto(insn->imm, env->prog);
 		/* all functions that have prototype and verifier allowed
 		 * programs to call them, must be real in-kernel functions
@@ -23433,6 +23444,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			return -EFAULT;
 		}
 		insn->imm = fn->func - __bpf_call_base;
+		env->insn_aux_data[i + delta].finalized_call = true;
 next_insn:
 		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
 			subprogs[cur_subprog].stack_depth += stack_depth_extra;
diff --git a/net/core/filter.c b/net/core/filter.c
index 07af2a94cc9a..e91d5a39e0a7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9080,10 +9080,11 @@ static int bpf_unclone_prologue(struct bpf_insn *insn_buf, u32 pkt_access_flags,
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 7);
 
 	/* ret = bpf_skb_pull_data(skb, 0); */
+	BUILD_BUG_ON(!__same_type(btf_bpf_skb_pull_data,
+				  (u64 (*)(struct sk_buff *, u32))NULL));
 	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
 	*insn++ = BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
-	*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			       BPF_FUNC_skb_pull_data);
+	*insn++ = BPF_EMIT_CALL(bpf_skb_pull_data);
 	/* if (!ret)
 	 *      goto restore;
 	 * return TC_ACT_SHOT;

-- 
2.43.0


