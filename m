Return-Path: <netdev+bounces-280258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F51AGH252kVDgIAu9opvQ
	(envelope-from <netdev+bounces-280258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:12:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 986E344005C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 957B6307886A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB82382377;
	Tue, 21 Apr 2026 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecCp8hIx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902AC37F010
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809422; cv=none; b=BAECuHHs1EWNnfr++UEb/HtoR5hS7sxgSAScESmu8LwGIemIglv6BmzrR1drUj/uD+YJt2rktokEJESN/EgN8k9cMZC1XaFJgD/l3f73cL+GPHj6ps9jzPoxTTYGA/xuN3hJ6IL5DpZGcfJdGUFYlrgMY/rEERDGl7jT2J4SX2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809422; c=relaxed/simple;
	bh=imC1/ZWlbJwf2xBYdrrZR7vKi1m+forARsLCVDK9s+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFJd/IAXZEBoKS+uz9hnXVGXrbm6SMkBNCwox5Qbsm9xrP4QQiwGQHWgV5V23qqtG0D0gHHcKoDqO7EaluPMsKm8QWqFAYJ4y24K7f5MHHWyzckiLjTEElWlttbZrsHtIcBSJEXPou7yRoVnFXYi0p0qcC/SFwBaKFblSwXZSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecCp8hIx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so2270002a91.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809420; x=1777414220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMWDyDSbFoQuBpzWs/5W+MxvNfGgb8L13He3B9ogV/I=;
        b=ecCp8hIxwrYO+wSRSq4OeSZPOKtWFJ+GIq/zZK7fDgV4lfKxIEk1nBhChJeYaotFxJ
         qeFdgODq8TWEwS/0GyVxjBrGyaqnShXQHOG0V8YQcaZHE6/h/NvBWZgOoezsAB0hOp0H
         N8FA7+YhwZJbY3gt6waLS/vCMjsFU4nRlFgMbfswY6F4PAZdkIxS22uON6SUnHBLR0Qi
         5DSxHsZO4JTMphpC9AobUWvfbdgGrqIk3HLUqK2uKQlImsaxYon44BqPIGlxPn6XnOL4
         RneDotvyZXBybIrHddkQzRTTKZOV9KltuP4dh6xLpnodHzKwUI1zDWeJQoPUbdPjX0Bc
         UIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809420; x=1777414220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WMWDyDSbFoQuBpzWs/5W+MxvNfGgb8L13He3B9ogV/I=;
        b=DjV2LqVO3rPLNbKs1L1tNZLpLmsMxFVy2i/GpZ9pw2zVCQPDbS6vm7d1gjCRxa8bVI
         2SfpjMQN9DyoF84OMmdlvgHMfmPmgMyBGHOffV+TESp1GunZwOrJibTIr7NlgpOIw55u
         0CI4FwEwnaul/Kx5kKL1a4Bel1d8l4QyrgtKx53Ua3Y4YlxseM6jxkKuoPDvnx5gfmYE
         5fgiJYJfYjSq2nuij/gSwVJLIuKeritESVXp181dHNmGHrMKnpwImzhNvTW4cUjA5U2I
         dvX9WnqCI+CbCLpr+WusuY4G1/+UKeqGlYbKZj2wYron9PjDiE7FoWn7ld96lxDMAqTI
         I7TA==
X-Gm-Message-State: AOJu0YxeOnpBIH8C7EpeQHnQ9eUj4Yhs6usRcR3YwLjrkKG44TFQskZD
	t6aKUj+MZ28hLmos2PGPv1zzwBIpZS2xjbwjxD5BnpsMjDa4T13dPXAW
X-Gm-Gg: AeBDietckt5Fg9Ho2XCrygvF7VER48viEgy6s2KcWB6nraTfzOMtMXZqrFeUmG/Uigm
	P39lhVHy1E/8lHuuents2IkMjrsiPL0cM/SCEeVkHNgC5/3x+Bu+w2b5didIR9yFRj6k6hqNWV3
	zgqJBN0fdaUXCQMX7BLsT3u2b5QuzdAH/Fbp/l2hUl+K9HiUYHqlS2lHZndZJkAoN+ajEj17aT+
	AjLULEqGxBNRUy4rAj+rNG9rIRdAk1/4ySJOM+vAyN/cxDNcRTevO3XLOLzqeFwzUlF08RDYfFQ
	MFxcRec9jNXRjCG1BsOUEyXpLafDrCoKz8G2Ukmd/sDdQ7+xUAP6N66h61MGOISinfE2Tyus6pw
	Gn9FmRQAAao1m2OnovKA0Q8m0Zo2yDysp5f6lKfzhWIU2rjz3nEH5CfJjMQk6SM4rMv+a//Jnaz
	4fVcy02mbdcuEm534e2ruB3ZI=
X-Received: by 2002:a17:90b:510e:b0:35d:a1ce:c1 with SMTP id 98e67ed59e1d1-361401f8290mr17190649a91.8.1776809419943;
        Tue, 21 Apr 2026 15:10:19 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-362bbf963c9sm4809715a91.16.2026.04.21.15.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 1/9] bpf: Unify dynptr handling in the verifier
Date: Tue, 21 Apr 2026 15:10:08 -0700
Message-ID: <20260421221016.2967924-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280258-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 986E344005C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simplify dynptr checking for helper and kfunc by unifying it. Remember
the initialized dynptr (i.e.,g !(arg_type |= MEM_UNINIT)) pass to a
dynptr kfunc during process_dynptr_func() so that we can easily
retrieve the information for verification later. By saving it in
meta->dynptr, there is no need to call dynptr helpers such as
dynptr_id(), dynptr_ref_obj_id() and dynptr_type() in check_func_arg().

Remove and open code the helpers in process_dynptr_func() when
saving id, ref_obj_id, and type. It is okay to drop spi < 0 check as
is_dynptr_reg_valid_init() has made sure the dynptr is valid.

Besides, since dynptr ref_obj_id information is now pass around in
meta->bpf_dynptr_desc, drop the check in helper_multiple_ref_obj_use.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h |  12 ++-
 kernel/bpf/verifier.c        | 178 +++++++----------------------------
 2 files changed, 41 insertions(+), 149 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b148f816f25b..dc0cff59246d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1319,6 +1319,12 @@ struct bpf_map_desc {
 	int uid;
 };
 
+struct bpf_dynptr_desc {
+	enum bpf_dynptr_type type;
+	u32 id;
+	u32 ref_obj_id;
+};
+
 struct bpf_kfunc_call_arg_meta {
 	/* In parameters */
 	struct btf *btf;
@@ -1359,16 +1365,12 @@ struct bpf_kfunc_call_arg_meta {
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
index 185210b73385..41e4ea41c72e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -232,6 +232,7 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
 
 struct bpf_call_arg_meta {
 	struct bpf_map_desc map;
+	struct bpf_dynptr_desc dynptr;
 	bool raw_mode;
 	bool pkt_access;
 	u8 release_regno;
@@ -240,7 +241,6 @@ struct bpf_call_arg_meta {
 	int mem_size;
 	u64 msize_max_value;
 	int ref_obj_id;
-	int dynptr_id;
 	int func_id;
 	struct btf *btf;
 	u32 btf_id;
@@ -434,11 +434,6 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
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
@@ -507,8 +502,6 @@ static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
 		ref_obj_uses++;
 	if (is_acquire_function(func_id, map))
 		ref_obj_uses++;
-	if (is_dynptr_ref_function(func_id))
-		ref_obj_uses++;
 
 	return ref_obj_uses > 1;
 }
@@ -7433,7 +7426,8 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
  * and checked dynamically during runtime.
  */
 static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn_idx,
-			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
+			       enum bpf_arg_type arg_type, int clone_ref_obj_id,
+			       struct bpf_dynptr_desc *dynptr)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	int err;
@@ -7499,6 +7493,20 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn
 		}
 
 		err = mark_dynptr_read(env, reg);
+
+		if (dynptr) {
+			struct bpf_func_state *state = bpf_func(env, reg);
+			int spi;
+
+			if (reg->type != CONST_PTR_TO_DYNPTR) {
+				spi = dynptr_get_spi(env, reg);
+				reg = &state->stack[spi].spilled_ptr;
+			}
+
+			dynptr->id = reg->id;
+			dynptr->type = reg->dynptr.type;
+			dynptr->ref_obj_id = reg->ref_obj_id;
+		}
 	}
 	return err;
 }
@@ -8263,72 +8271,6 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
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
 static int check_reg_const_str(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg, u32 regno)
 {
@@ -8683,7 +8625,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0);
+		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0, &meta->dynptr);
 		if (err)
 			return err;
 		break;
@@ -9342,7 +9284,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (ret)
 				return ret;
 
-			ret = process_dynptr_func(env, regno, -1, arg->arg_type, 0);
+			ret = process_dynptr_func(env, regno, -1, arg->arg_type, 0, NULL);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
@@ -10429,52 +10371,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
 
@@ -10665,10 +10565,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -10682,6 +10579,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -12260,7 +12162,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				meta->release_regno = regno;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
 				   (dynptr_arg_type & MEM_UNINIT)) {
-				enum bpf_dynptr_type parent_type = meta->initialized_dynptr.type;
+				enum bpf_dynptr_type parent_type = meta->dynptr.type;
 
 				if (parent_type == BPF_DYNPTR_TYPE_INVALID) {
 					verifier_bug(env, "no dynptr type for parent of clone");
@@ -12268,29 +12170,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 
 				dynptr_arg_type |= (unsigned int)get_dynptr_type_flag(parent_type);
-				clone_ref_obj_id = meta->initialized_dynptr.ref_obj_id;
+				clone_ref_obj_id = meta->dynptr.ref_obj_id;
 				if (dynptr_type_refcounted(parent_type) && !clone_ref_obj_id) {
 					verifier_bug(env, "missing ref obj id for parent of clone");
 					return -EFAULT;
 				}
 			}
 
-			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id);
+			ret = process_dynptr_func(env, regno, insn_idx, dynptr_arg_type, clone_ref_obj_id,
+						  &meta->dynptr);
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
@@ -12894,7 +12784,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 		}
 	} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice] ||
 		   meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
-		enum bpf_type_flag type_flag = get_dynptr_type_flag(meta->initialized_dynptr.type);
+		enum bpf_type_flag type_flag = get_dynptr_type_flag(meta->dynptr.type);
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 
@@ -12918,11 +12808,11 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
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
@@ -13110,7 +13000,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (meta.release_regno) {
 		struct bpf_reg_state *reg = &regs[meta.release_regno];
 
-		if (meta.initialized_dynptr.ref_obj_id) {
+		if (meta.dynptr.ref_obj_id) {
 			err = unmark_stack_slots_dynptr(env, reg);
 		} else {
 			err = release_reference(env, reg->ref_obj_id);
-- 
2.52.0


