Return-Path: <netdev+bounces-289565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEBfA1SoDGodkgUAu9opvQ
	(envelope-from <netdev+bounces-289565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:13:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 777315837B3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80CFB304DAF4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37211342514;
	Tue, 19 May 2026 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sb7VcBtm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DBC341660
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214404; cv=none; b=XonFtEpQ/rZAYJBbprC7n6mAsxPNCxAibqlwpDEgrQiWbRQEJfmYvt84J0wsq5gItPEUoqmzfIgAFItR/HeZ+ugvgSTfKSNbW72ZAlZc8JfuaQaY471awrQ2vf+zNYQKzsUUUsknCM6bbzqphmgfBEjP4SHj5MH5oV+UxcURMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214404; c=relaxed/simple;
	bh=N46B2RyO0HQe3w45aQOO4auxRvAQMJmzhXniUC1yhqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osvsymdOVtLil2BG5oe9FBtsaLEWiqsJz2aCZIFwfQKh7uONGywC07c5qAcyxRJ5QNMLHtQoXu8IAv9rDUXGEev28X40vyQU15OOV23HqcKfXjWeJL/1HZLL8cglFSQo6+xMj/Bp+S4JV6K8S1QUF6W+H7jJSwYKqdfqo5SmPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sb7VcBtm; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65dd9b25829so3115938d50.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214399; x=1779819199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aI4YSELm3yHCs5ZiFYOWMxI4dOxRrhYM4hPBCVVVT1o=;
        b=sb7VcBtmW7iPYNI3eMHH93HejW26yxgEuoGXEUomwqVn4m9loW2bpycEa4aiQOQ3L/
         EJ0eOGQZBFdXzQrGM9CSNJdGx9ofxYRxt0Vqt38coIyBgFnktPVcLQp12xca5ipaLv+u
         KR4VdOp4y+DocRwobEUObNo5FGsZsMF5gmsVcxZnkQBo46/gsGsqEp3bRcyRIbf4/x8u
         QjycdRP+0MP4fBdwTF10nY70dSN+TxnVbLo8y+t0E2lxCMONCnNKbMwn4YYJA1JrHxYy
         XeYDmndCkArHIwGyDqde9GVDD9l5lpAvZXT4YKEGywKpvCeurJUcGgPaa7fK5e5mDuDv
         Or9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214399; x=1779819199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aI4YSELm3yHCs5ZiFYOWMxI4dOxRrhYM4hPBCVVVT1o=;
        b=C53dOteFZnMwIPSK6JEdAFinZzmuiXeIPIvrm2x8rbZBH/zrytkMCZsWxfDjYvThKf
         +No7lkWwHNZ5+bxI4M3xGE6Kb2q6qVq13lJ9Va3iRS/wNegAiZ6XeOMPFyjA4Bd+6Kr3
         nkks6r8im17datFZ7r76ojrcUk65lV5vtzKX/KKUScRei3ugoqhCzAZt+vElGzT4vJ9u
         00yeqQKmllqfoImiGKY+skWrxIs5d0fsKhOa3nzsOHs96XSjL3lW4/gMOGUcHmv7iHkH
         D6FmiIYIcx4Da7Dez/mwfTfKvQLiChDpS/fq9WM06S4aqE/DylxC+AG7ilIhptPZR11B
         fe4A==
X-Gm-Message-State: AOJu0YzqHe2H4KF+INpm5zvGqbYnWgQiBqXFi6W59J5knE4/6dlE6Yvq
	/vJwzSlK6OhPOmCvkeRtqAy1uK0nXWdZzSAQFzwL1SP5KsrdnPXxwIMb
X-Gm-Gg: Acq92OH7H8PfwBMkcbADg7z2P6Z5+qZWQOvuqYeBxLXS1e2SiSCYj5Z6x91U7t7Y4Sk
	YytQtvtjegNF4fsniEI1GYw6BsO1Z/nBWcFNsL0gRITQR5cjLSn4sghadmjxklIH8fdoFmkGeVy
	iVDDYwREIbN3VAHZGwsUrpYiamLeXLoL2ceOW+yFERTA/s1/NJJqNvsHmv8V//3FEx9GPlP0jEw
	MOFOpS7/YPs4hzTaHtLnxtG2AHa3TomGNQdIPjUgYZCnL/C3Hbm8f8G3fRVuQjLI0kdxMTS8EqF
	6IBKuaA3NuN1UgZnXB5+/6QqXW5sR0Sem/H3JR0JdwRlY3K35PNDPppJDZjPQnVG5BNOJdS1ue1
	zhsnrxslXxLV4bT2x5LTVcRT2Kaxp8XOUjcyShyEOC/qgHe1uP9RfcwDEGx6QNuArcimWzTxpy6
	NAtq9TZio+Mdg/M9Oj
X-Received: by 2002:a05:690e:b45:b0:651:b40a:d6ce with SMTP id 956f58d0204a3-65e226babcemr21124814d50.14.1779214398899;
        Tue, 19 May 2026 11:13:18 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:46::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d8e60c5sm8138663d50.7.2026.05.19.11.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:18 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 02/14] bpf: Unify dynptr handling in the verifier
Date: Tue, 19 May 2026 11:13:00 -0700
Message-ID: <20260519181314.2731658-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519181314.2731658-1-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289565-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 777315837B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simplify dynptr checking for helper and kfunc by unifying it. Remember
the initialized dynptr (i.e.,g !(arg_type |= MEM_UNINIT)) pass to a
dynptr kfunc during process_dynptr_func() so that we can easily
retrieve the information for verification later. By saving it in
meta->dynptr, there is no need to call dynptr helpers such as
dynptr_id(), dynptr_ref_obj_id() and dynptr_type() in check_func_arg().

Remove and open code the helpers in process_dynptr_func() when
saving id, ref_obj_id, and type.

Besides, since dynptr ref_obj_id information is now pass around in
meta->bpf_dynptr_desc, drop the check in helper_multiple_ref_obj_use.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h |  13 ++-
 kernel/bpf/verifier.c        | 178 +++++++----------------------------
 2 files changed, 40 insertions(+), 151 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 20c421b43849..2cb4c7b0eab6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1436,6 +1436,13 @@ struct bpf_map_desc {
 	int uid;
 };
 
+/* The last initialized dynptr; Populated by process_dynptr_func() */
+struct bpf_dynptr_desc {
+	enum bpf_dynptr_type type;
+	u32 id;
+	u32 ref_obj_id;
+};
+
 struct bpf_kfunc_call_arg_meta {
 	/* In parameters */
 	struct btf *btf;
@@ -1476,16 +1483,12 @@ struct bpf_kfunc_call_arg_meta {
 	struct {
 		struct btf_field *field;
 	} arg_rbtree_root;
-	struct {
-		enum bpf_dynptr_type type;
-		u32 id;
-		u32 ref_obj_id;
-	} initialized_dynptr;
 	struct {
 		u8 spi;
 		u8 frameno;
 	} iter;
 	struct bpf_map_desc map;
+	struct bpf_dynptr_desc dynptr;
 	u64 mem_size;
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9daa5555db39..564679f70afd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -233,6 +233,7 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
 
 struct bpf_call_arg_meta {
 	struct bpf_map_desc map;
+	struct bpf_dynptr_desc dynptr;
 	bool raw_mode;
 	bool pkt_access;
 	u8 release_regno;
@@ -241,7 +242,6 @@ struct bpf_call_arg_meta {
 	int mem_size;
 	u64 msize_max_value;
 	int ref_obj_id;
-	int dynptr_id;
 	int func_id;
 	struct btf *btf;
 	u32 btf_id;
@@ -470,11 +470,6 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
 		func_id == BPF_FUNC_skc_to_tcp_request_sock;
 }
 
-static bool is_dynptr_ref_function(enum bpf_func_id func_id)
-{
-	return func_id == BPF_FUNC_dynptr_data;
-}
-
 static bool is_sync_callback_calling_kfunc(u32 btf_id);
 static bool is_async_callback_calling_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
@@ -543,8 +538,6 @@ static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
 		ref_obj_uses++;
 	if (is_acquire_function(func_id, map))
 		ref_obj_uses++;
-	if (is_dynptr_ref_function(func_id))
-		ref_obj_uses++;
 
 	return ref_obj_uses > 1;
 }
@@ -7216,8 +7209,9 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
  * use case. The second level is tracked using the upper bit of bpf_dynptr->size
  * and checked dynamically during runtime.
  */
-static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int insn_idx,
-			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
+static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+			       argno_t argno, int insn_idx, enum bpf_arg_type arg_type,
+			       int clone_ref_obj_id, struct bpf_dynptr_desc *dynptr)
 {
 	int spi, err = 0;
 
@@ -7282,6 +7276,8 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		}
 
 		if (reg->type != CONST_PTR_TO_DYNPTR) {
+			struct bpf_func_state *state = bpf_func(env, reg);
+
 			spi = dynptr_get_spi(env, reg);
 			if (spi < 0)
 				return spi;
@@ -7291,6 +7287,14 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			 * in check_helper_call and mark_btf_func_reg_size in check_kfunc_call.
 			 */
 			mark_stack_slots_scratched(env, spi, BPF_DYNPTR_NR_SLOTS);
+
+			reg = &state->stack[spi].spilled_ptr;
+		}
+
+		if (dynptr) {
+			dynptr->type = reg->dynptr.type;
+			dynptr->id = reg->id;
+			dynptr->ref_obj_id = reg->ref_obj_id;
 		}
 	}
 	return err;
@@ -8060,72 +8064,6 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	}
 }
 
-static struct bpf_reg_state *get_dynptr_arg_reg(struct bpf_verifier_env *env,
-						const struct bpf_func_proto *fn,
-						struct bpf_reg_state *regs)
-{
-	struct bpf_reg_state *state = NULL;
-	int i;
-
-	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
-		if (arg_type_is_dynptr(fn->arg_type[i])) {
-			if (state) {
-				verbose(env, "verifier internal error: multiple dynptr args\n");
-				return NULL;
-			}
-			state = &regs[BPF_REG_1 + i];
-		}
-
-	if (!state)
-		verbose(env, "verifier internal error: no dynptr arg found\n");
-
-	return state;
-}
-
-static int dynptr_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
-{
-	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi;
-
-	if (reg->type == CONST_PTR_TO_DYNPTR)
-		return reg->id;
-	spi = dynptr_get_spi(env, reg);
-	if (spi < 0)
-		return spi;
-	return state->stack[spi].spilled_ptr.id;
-}
-
-static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
-{
-	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi;
-
-	if (reg->type == CONST_PTR_TO_DYNPTR)
-		return reg->ref_obj_id;
-	spi = dynptr_get_spi(env, reg);
-	if (spi < 0)
-		return spi;
-	return state->stack[spi].spilled_ptr.ref_obj_id;
-}
-
-static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *env,
-					    struct bpf_reg_state *reg)
-{
-	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi;
-
-	if (reg->type == CONST_PTR_TO_DYNPTR)
-		return reg->dynptr.type;
-
-	spi = bpf_get_spi(reg->var_off.value);
-	if (spi < 0) {
-		verbose(env, "verifier internal error: invalid spi when querying dynptr type\n");
-		return BPF_DYNPTR_TYPE_INVALID;
-	}
-
-	return state->stack[spi].spilled_ptr.dynptr.type;
-}
-
 static int check_arg_const_str(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg, argno_t argno)
 {
@@ -8483,7 +8421,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, reg, argno_from_reg(regno), insn_idx, arg_type, 0);
+		err = process_dynptr_func(env, reg, argno_from_reg(regno), insn_idx, arg_type, 0,
+					  &meta->dynptr);
 		if (err)
 			return err;
 		break;
@@ -9165,7 +9104,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (ret)
 				return ret;
 
-			ret = process_dynptr_func(env, reg, argno, -1, arg->arg_type, 0);
+			ret = process_dynptr_func(env, reg, argno, -1, arg->arg_type, 0, NULL);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
@@ -10259,52 +10198,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			}
 		}
 		break;
-	case BPF_FUNC_dynptr_data:
-	{
-		struct bpf_reg_state *reg;
-		int id, ref_obj_id;
-
-		reg = get_dynptr_arg_reg(env, fn, regs);
-		if (!reg)
-			return -EFAULT;
-
-
-		if (meta.dynptr_id) {
-			verifier_bug(env, "meta.dynptr_id already set");
-			return -EFAULT;
-		}
-		if (meta.ref_obj_id) {
-			verifier_bug(env, "meta.ref_obj_id already set");
-			return -EFAULT;
-		}
-
-		id = dynptr_id(env, reg);
-		if (id < 0) {
-			verifier_bug(env, "failed to obtain dynptr id");
-			return id;
-		}
-
-		ref_obj_id = dynptr_ref_obj_id(env, reg);
-		if (ref_obj_id < 0) {
-			verifier_bug(env, "failed to obtain dynptr ref_obj_id");
-			return ref_obj_id;
-		}
-
-		meta.dynptr_id = id;
-		meta.ref_obj_id = ref_obj_id;
-
-		break;
-	}
 	case BPF_FUNC_dynptr_write:
 	{
-		enum bpf_dynptr_type dynptr_type;
-		struct bpf_reg_state *reg;
+		enum bpf_dynptr_type dynptr_type = meta.dynptr.type;
 
-		reg = get_dynptr_arg_reg(env, fn, regs);
-		if (!reg)
-			return -EFAULT;
-
-		dynptr_type = dynptr_get_type(env, reg);
 		if (dynptr_type == BPF_DYNPTR_TYPE_INVALID)
 			return -EFAULT;
 
@@ -10496,10 +10393,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EFAULT;
 	}
 
-	if (is_dynptr_ref_function(func_id))
-		regs[BPF_REG_0].dynptr_id = meta.dynptr_id;
-
-	if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_id)) {
+	if (is_ptr_cast_function(func_id)) {
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
@@ -10513,6 +10407,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].ref_obj_id = id;
 	}
 
+	if (func_id == BPF_FUNC_dynptr_data) {
+		regs[BPF_REG_0].dynptr_id = meta.dynptr.id;
+		regs[BPF_REG_0].ref_obj_id = meta.dynptr.ref_obj_id;
+	}
+
 	err = do_refine_retval_range(env, regs, fn->ret_type, func_id, &meta);
 	if (err)
 		return err;
@@ -12141,7 +12040,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				meta->release_regno = regno;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
 				   (dynptr_arg_type & MEM_UNINIT)) {
-				enum bpf_dynptr_type parent_type = meta->initialized_dynptr.type;
+				enum bpf_dynptr_type parent_type = meta->dynptr.type;
 
 				if (parent_type == BPF_DYNPTR_TYPE_INVALID) {
 					verifier_bug(env, "no dynptr type for parent of clone");
@@ -12149,30 +12048,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 
 				dynptr_arg_type |= (unsigned int)get_dynptr_type_flag(parent_type);
-				clone_ref_obj_id = meta->initialized_dynptr.ref_obj_id;
+				clone_ref_obj_id = meta->dynptr.ref_obj_id;
 				if (dynptr_type_refcounted(parent_type) && !clone_ref_obj_id) {
 					verifier_bug(env, "missing ref obj id for parent of clone");
 					return -EFAULT;
 				}
 			}
 
-			ret = process_dynptr_func(env, reg, argno, insn_idx,
-						  dynptr_arg_type, clone_ref_obj_id);
+			ret = process_dynptr_func(env, reg, argno, insn_idx, dynptr_arg_type,
+						  clone_ref_obj_id, &meta->dynptr);
 			if (ret < 0)
 				return ret;
-
-			if (!(dynptr_arg_type & MEM_UNINIT)) {
-				int id = dynptr_id(env, reg);
-
-				if (id < 0) {
-					verifier_bug(env, "failed to obtain dynptr id");
-					return id;
-				}
-				meta->initialized_dynptr.id = id;
-				meta->initialized_dynptr.type = dynptr_get_type(env, reg);
-				meta->initialized_dynptr.ref_obj_id = dynptr_ref_obj_id(env, reg);
-			}
-
 			break;
 		}
 		case KF_ARG_PTR_TO_ITER:
@@ -12795,7 +12681,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 		}
 	} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice] ||
 		   meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
-		enum bpf_type_flag type_flag = get_dynptr_type_flag(meta->initialized_dynptr.type);
+		enum bpf_type_flag type_flag = get_dynptr_type_flag(meta->dynptr.type);
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 
@@ -12819,11 +12705,11 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 			}
 		}
 
-		if (!meta->initialized_dynptr.id) {
+		if (!meta->dynptr.id) {
 			verifier_bug(env, "no dynptr id");
 			return -EFAULT;
 		}
-		regs[BPF_REG_0].dynptr_id = meta->initialized_dynptr.id;
+		regs[BPF_REG_0].dynptr_id = meta->dynptr.id;
 
 		/* we don't need to set BPF_REG_0's ref obj id
 		 * because packet slices are not refcounted (see
@@ -13011,7 +12897,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (meta.release_regno) {
 		struct bpf_reg_state *reg = &regs[meta.release_regno];
 
-		if (meta.initialized_dynptr.ref_obj_id) {
+		if (meta.dynptr.ref_obj_id) {
 			err = unmark_stack_slots_dynptr(env, reg);
 		} else {
 			err = release_reference(env, reg->ref_obj_id);
-- 
2.53.0-Meta


