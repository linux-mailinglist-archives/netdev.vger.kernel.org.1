Return-Path: <netdev+bounces-252895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLPHEHCqc2nOxwAAu9opvQ
	(envelope-from <netdev+bounces-252895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:05:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF83B78C6C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3684C3027337
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D430BBBC;
	Fri, 23 Jan 2026 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OXP2ymJz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAC1290DBB
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187936; cv=none; b=lCjIX8jqfi/OqqpPw1Q32R/HMVVntW2iA2TW6zk2X5tSu36IbzIXCLfQZCEYrmeAZXLXF2xjI4tZSwcLyn6ydnfWa2dH505CjR74stncUX/CVEQamNzBE8pffdwffk9dHJzewTr6SSJWM9YEktlUeEUspq5kNvLfiyM9aFtw8uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187936; c=relaxed/simple;
	bh=FZph9IV8rAQJz0gX5JawMm59xWKu8ACieH1pNlvriEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nfJ4Z1RLsTERngDtkG9LtftDUJWAQaLc5EEXyVJD+s5345zvYE6orewa5R2urabcQOLsP25NVsXBK7l/uoGXg1hn930Y3qHSkM15BxyBm0iyRM0IJUs7C9zxr2TiEofUHQuJH7wAzv2TMOdCN+33EtbN6pAnUX2hi8ACkBmuXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OXP2ymJz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so3386790a12.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769187932; x=1769792732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1X9uw3m1KzZgxmGpwRkGtH9I7YAOqbbW1p3NEbA+Lg=;
        b=OXP2ymJzVVizZtyLCmqPa5b3/gptVXB2Popd31q6jzmmZEeCK8aUoO1IYCsudx+m2L
         3rHUrQStVb1SWynYCEdlu+0jSPynLeh7yop4iFAk5EERW8HFC75xNaYHsSXDuARJREsg
         JqmarKNFRU+yx5hLkMNTLAE2E77Dt8GfUWw0jMhWyWE9WhPnI1F7AtqjuZ3SWT4UcipE
         QovYBwyLDm5MEC2OGgFmSWJ3Et2IhEW17RlR7QMwv9PDphSZaOTJxhGhHyypmvXQWhuc
         u1lw0aNp9Pgl3Tr1RRFcpAcQfebe3D+4LYI4c9dcLDK6re5+eZEjwS07WlsdQQjiSt8b
         RigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187932; x=1769792732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x1X9uw3m1KzZgxmGpwRkGtH9I7YAOqbbW1p3NEbA+Lg=;
        b=TaP3IgpDlXIouxC9UeiPFDfBB/BilHh1567H84I1v2/CpKyop7W0Qg3GDxXL7N1UHt
         pPWMW/Rp7nmBc2xrfyroBpuuobcccGO0VSJf6NHMCQTY64VQQtRUNy08AzV7xOg+TmUs
         9MpH1KFxfiJQBcQk0XyY7xAb/OzkAUBxWT982gj24S4D2uldi1GmiLsUQMIiH2OZ6oOO
         6vvrrj6ZAVNA/TbJJtFO9j0a60ijwqXFrDemqUDxbgohUV8FImOcHYyrKF0lx2kpokiQ
         USBiq7C7hY2IdKujSLmcYgDIK7oyUicQIcxGpgjTaFndk2HC+yfddaPgwq/gwYCmTtAG
         YV8A==
X-Forwarded-Encrypted: i=1; AJvYcCVlFKjO4Y0d91b4l+uZZQ5fRePPPYoatJfQlKCciMTWvfiWXOvL5+8VrEY77m3IVUkleuWFnXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykY9w8DJcpHW24GLSynYt9b6TTQPJ8wxe9yEaHzObFIkrCpJ8z
	RHjDnCrSVkc0HsyiPjuntFP8/HsRadDBqpphTmRbWeuuUkn1WR3h8Dk8s63AYfjKItw=
X-Gm-Gg: AZuq6aKnM2kLgDnzTB0nT3ZtvyiBRogawhMTU32yh5Zuz3I2bdufvUd75YPXtdDZB+q
	Uk7cWBu4K7cEZ0Jsk9+rv2FHFwhNPaDnc6kzU9zjVJ6g5/QzcoakLghfWsqYT4oT8SJqgqdA6cm
	Imp2EPRPwG2BsTU/Bsgh727MY1BwzYHt9ywLCUfFBHAcIGy4srxXF4fvPz9YJqIkhPjfoB5FdVX
	A1MNSLvvd74qsUDG8monSQG/hHDdsoOAfoIYFOK8RzjpY2Bokw2mkriXiIsqaDypqMmJc7VGH6g
	xSHUAFTYc9oD7z4dsn/OXIJPd/vodoCZ5OE2pXE9Gv54v6KPCMBVBUIHrIa3knUsHmQk5p3Lcry
	iSRVNRca/7j3SOKvzTldH1nNLD0uHgyQdw6lw36j9VxLF4DRo7xPRSFbCe+uAC3W6SKFD6NfXyo
	Ms2UIu5cqAMZwEe6xC+j96OqQOvfajwDboYyEP3wxOlI1s717+IIs=
X-Received: by 2002:a17:906:fe0a:b0:b87:63a8:8849 with SMTP id a640c23a62f3a-b885ae8019dmr300711466b.46.1769187932380;
        Fri, 23 Jan 2026 09:05:32 -0800 (PST)
Received: from cloudflare.com (79.191.62.3.ipv4.supernova.orange.pl. [79.191.62.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b417339sm134754166b.22.2026.01.23.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:05:31 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 23 Jan 2026 18:05:18 +0100
Subject: [PATCH bpf-next v2 1/4] bpf, verifier: Support direct helper calls
 from prologue/epilogue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-1-0e50db4d4663@cloudflare.com>
References: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
In-Reply-To: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,vger.kernel.org,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252895-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid]
X-Rspamd-Queue-Id: AF83B78C6C
X-Rspamd-Action: no action

Prepare to remove support for calling kfuncs from prologue & epilogue.

Instead allow direct helpers calls using BPF_EMIT_CALL. Such calls already
contain helper offset relative to __bpf_call_base and must bypass the
verifier's patch_call_imm fixup, which expects BPF helper IDs rather than a
pre-resolved offsets.

Add a finalized_call flag to bpf_insn_aux_data to mark call instructions
with resolved offsets so the verifier can skip patch_call_imm fixup for
these calls.

Note that the target of BPF_EMIT_CALL should be wrapped with BPF_CALL_x to
prevent an ABI mismatch between BPF and C on 32-bit architectures.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 29 ++++++++++++++++++++++++++---
 net/core/filter.c            |  3 +--
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 8355b585cd18..1ccbb47aca2d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -561,6 +561,7 @@ struct bpf_insn_aux_data {
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
+	bool finalized_call; /* call holds resolved helper offset relative to __bpf_call_base */
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c7f5234d5fd2..0b4feedc14c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22201,6 +22201,19 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* Mark helper calls within prog->insns[off ... off+cnt-1] range as resolved,
+ * meaning imm contains the helper offset. Used for prologue & epilogue.
+ */
+static void mark_helper_calls_finalized(struct bpf_verifier_env *env, int off, int cnt)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++) {
+		if (bpf_helper_call(&env->prog->insnsi[i + off]))
+			env->insn_aux_data[i + off].finalized_call = true;
+	}
+}
+
 /* convert load instructions that access fields of a context type into a
  * sequence of instructions that access fields of the underlying structure:
  *     struct __sk_buff    -> struct sk_buff
@@ -22267,6 +22280,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
 			if (ret < 0)
 				return ret;
+
+			mark_helper_calls_finalized(env, 0, cnt - 1);
 		}
 	}
 
@@ -22280,6 +22295,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		bpf_convert_ctx_access_t convert_ctx_access;
+		bool finalize_helper_calls = false;
 		u8 mode;
 
 		if (env->insn_aux_data[i + delta].nospec) {
@@ -22346,6 +22362,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 				 * epilogue.
 				 */
 				epilogue_idx = i + delta;
+				finalize_helper_calls = true;
 			}
 			goto patch_insn_buf;
 		} else {
@@ -22495,12 +22512,14 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 		if (!new_prog)
 			return -ENOMEM;
+		env->prog = new_prog;
 
-		delta += cnt - 1;
+		if (finalize_helper_calls)
+			mark_helper_calls_finalized(env, i + delta, cnt - 1);
 
 		/* keep walking new program and skip insns we just inserted */
-		env->prog = new_prog;
-		insn      = new_prog->insnsi + i + delta;
+		delta += cnt - 1;
+		insn = new_prog->insnsi + i + delta;
 	}
 
 	return 0;
@@ -23909,6 +23928,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 patch_call_imm:
+		if (env->insn_aux_data[i + delta].finalized_call)
+			goto next_insn;
+
 		fn = env->ops->get_func_proto(insn->imm, env->prog);
 		/* all functions that have prototype and verifier allowed
 		 * programs to call them, must be real in-kernel functions
@@ -23920,6 +23942,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			return -EFAULT;
 		}
 		insn->imm = fn->func - __bpf_call_base;
+		env->insn_aux_data[i + delta].finalized_call = true;
 next_insn:
 		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
 			subprogs[cur_subprog].stack_depth += stack_depth_extra;
diff --git a/net/core/filter.c b/net/core/filter.c
index d14401193b01..cb39388f69a9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9082,8 +9082,7 @@ static int bpf_unclone_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	/* ret = bpf_skb_pull_data(skb, 0); */
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


