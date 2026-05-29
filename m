Return-Path: <netdev+bounces-292936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG3wHWjxGGqrpAgAu9opvQ
	(envelope-from <netdev+bounces-292936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:52:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C68125FC26D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D7FC313FF96
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531073630BC;
	Fri, 29 May 2026 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHzeOh0P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEEF3624CF
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019390; cv=none; b=sEeL2cSD/AYVrRi1sv1snlPDAxswnFD+YKP36z7x2YYORTn33pCeTjEeZmv26sG5pCQ7WiplYdgDFjui/SpPjKlQDZLoEkstoI17Ydoo8sxYYtSVLSM3e46mqRgSY1ZHdr8lBH7uK2IuufvQ0BICaGKQ05BV3wPf83wWy0RZNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019390; c=relaxed/simple;
	bh=t1yMf42pgMgwBNY9WCveIPR4/v7VcQg+KeBTo/cS58E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTdM+bfiYbYN1jDEy81pAK7FpINQYfEuHmsaT3xGuWRrBOUHHV8tvZmUjvWYByQRW8brafGCxijQxMYK02s9QGba4DdXqM+APfynuIJ3kGRSqrDydS1TIwfacRIVRT8EmZVhjN1WsygM0trHEKImONL2j/TkMQP9DzZcXMR4aeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHzeOh0P; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8025f1c227so10164941a12.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019387; x=1780624187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qH/Wi3kNdOPOr1dd7HIjwLLmRveMTdWcHpSKisBslBc=;
        b=OHzeOh0POjvHbGXStZ8x4TI9NSgGwoCPz8YGRINwe/q2LiOuCY5wZhkAx7l837HdJT
         W/wtcRiH3YBf1AwMAyaJG+K+5Ffbve1dE/QXpJUj4fTNx5vq5nEIvWuQpwrB99bb9WCp
         oZAc2P4hpUVyVo9WIjfPWY9tTwpGByFwd5+jfN+9m4WCvhl4wifY2ezDIzKNe7ln3J2O
         TM56wXux82qvqZfPmoeOm7iqb1W0QnsA28JH1CKLJUhQ45vT0U+SsGfh3DBEhQJvd7fa
         BAHu5Fixy6Vx8OjPIbzKngY5kBCzoucTRXDazpBhtpmj9vwcwzM9RytXsfDmpOebV3/u
         M8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019387; x=1780624187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qH/Wi3kNdOPOr1dd7HIjwLLmRveMTdWcHpSKisBslBc=;
        b=bdsh6+Bg+w70kWReGWV1Axke9CL2t8+Sp6RxsccOXK0CovrzaCHLwucNqrbT9J/Slq
         uCZLmVWb0wxDsGknrlhao9K4gj7VZ8ug/u8S8U+BYlbrWUDNBkX8d3FhvBrU7/m5UuBP
         lPUXLEfoGA02+fyw0a2H5Ix3HvsWbOybypqFUhp1+CsnqL5IqXs5deI3STBt6C638uYX
         Gttu93Nc9plMd7uFwmh88iYolPMV1shBzrXnDJXLC0mK+3kcSv8ifjCtEW8XiQC73baC
         8Vq8vmqnb6thbDG2qHiSaVlQ+PiqsHvKKTPP73uBHWKDDIGuDW0QIXpcb1RSTugYvmQ6
         bvIg==
X-Gm-Message-State: AOJu0YzpMMG+fVGzC2Lj3Cs397z6/KSQv+2h9VpwNZNRzE2qUuRcq/GU
	UlUMJ21fDcoe7+e/ENfnfDWzvGuFvMb+77Ylq/czpy/kaAFV6QmwENNU
X-Gm-Gg: Acq92OEhTd4dopz7b8A+G1lJ1MbZex9Ga6WDZK7aaGexU3FcHRr8ZtOL8c2pGyT8pEE
	buLhXcGe9aovbevRYjP11xH2PpntZAocMYc2rVujdlnJokmM1NE94UvPv3x4d2+swjWn55K0HsC
	Q8olWoYMkJ3NawD7hCyatkPv7WkEma+fAFbsELjHsMrOHlsYgAWg9dTmBFdaU04y2P9J7AqasEb
	U8L1zV4REXrwy/m6vkocIXIeHlG7LYi8ng5vr8cHo1SqvmGSlkVkoQFkyGPQeVXrd/S1oPOx4Mf
	VzIH6AXPff6vKPGdcyloq1aPpQQ5hsHsRSqVz8FP2IRVk6HkrBS6+9qA/5lZlUmSLJxVQapybbz
	fr/z24iOE13FQo6hD0iDij3vWB+uvdbJH9n5iZNqjc4bSLwJd91vN59mZyFdJ/WRQbWT+lvOReh
	wbvvIIZd+8hSoRPe5EvPvhnt68
X-Received: by 2002:a05:6a20:938e:b0:3a2:e26b:2940 with SMTP id adf61e73a8af0-3b411a00d73mr796524637.0.1780019387351;
        Thu, 28 May 2026 18:49:47 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85771be71esm122971a12.8.2026.05.28.18.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:46 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 07/13] bpf: Unify referenced object tracking in verifier
Date: Thu, 28 May 2026 18:49:30 -0700
Message-ID: <20260529014936.2811085-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292936-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ref_obj.id:url,meta.id:url]
X-Rspamd-Queue-Id: C68125FC26D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Helpers and kfuncs independently tracked referenced object metadata
using standalone id fields in their respective arg_meta structs.
This led to duplicated logic and inconsistent error handling between the
two paths.

Introduce struct ref_obj_desc to consolidate id and parent_id along with
a count of how many arguments carry a reference. Add update_ref_obj() to
populate it from a bpf_reg_state, replacing open-coded assignments in
check_func_arg(), check_kfunc_args(), and process_iter_arg(). Add
validate_ref_obj() to check for ambiguous ref_obj before using it.

For ref_obj releasing helpers and kfuncs, keep checking it before
calling update_ref_obj() for now. A later patch will make these
functions not depending on ref_obj. For other users of ref_obj, move the
checks to the use locations. For helper, this means moving the checks
inside helper_multiple_ref_obj_use() to use locations.
is_acquire_function() is dropped as ref_obj is never used.

Pass ref_obj_desc into process_dynptr_func()/mark_stack_slots_dynptr()
instead of a bare parent_id to make it less confusing.

Drop the selftest introduced in 7ec899ac90a2 ("selftests/bpf: Negative
test case for ref_obj_id in args") since the verifier no longer
complains about ambiguous ref_obj if it is not used.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h                  |  14 +-
 kernel/bpf/verifier.c                         | 122 +++++++++---------
 .../bpf/progs/test_ringbuf_map_key.c          |  11 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  24 ----
 4 files changed, 78 insertions(+), 93 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 75b287d8d92f..b0521ba7787a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1424,6 +1424,18 @@ struct bpf_dynptr_desc {
 	u32 parent_id;
 };
 
+/*
+ * The last seen rereferenced object; Updated by update_ref_obj() when a register refers to a
+ * referenced object. Used when the helper or kfunc is releasing a referenced object, casting
+ * a referenced object, returning allocated memory derived from referenced object or creating
+ * a dynptr with a referenced object as parent.
+ */
+struct ref_obj_desc {
+	u32 id;
+	u32 parent_id;
+	u8 cnt;
+};
+
 struct bpf_kfunc_call_arg_meta {
 	/* In parameters */
 	struct btf *btf;
@@ -1432,7 +1444,6 @@ struct bpf_kfunc_call_arg_meta {
 	const struct btf_type *func_proto;
 	const char *func_name;
 	/* Out parameters */
-	u32 id;
 	u8 release_regno;
 	bool r0_rdonly;
 	u32 ret_btf_id;
@@ -1470,6 +1481,7 @@ struct bpf_kfunc_call_arg_meta {
 	} iter;
 	struct bpf_map_desc map;
 	struct bpf_dynptr_desc dynptr;
+	struct ref_obj_desc ref_obj;
 	u64 mem_size;
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3db0f1db475a..1a49e5194bb4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -231,9 +231,28 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
 			     (poisoned ? BPF_MAP_KEY_POISON : 0ULL);
 }
 
+static void update_ref_obj(struct ref_obj_desc *ref_obj, struct bpf_reg_state *reg)
+{
+	ref_obj->id = reg->id;
+	ref_obj->parent_id = reg->parent_id;
+	ref_obj->cnt++;
+}
+
+static int validate_ref_obj(struct bpf_verifier_env *env, struct ref_obj_desc *ref_obj)
+{
+	if (ref_obj->cnt > 1) {
+		verifier_bug(env, "function expects only one referenced object but got %d\n",
+			     ref_obj->cnt);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 struct bpf_call_arg_meta {
 	struct bpf_map_desc map;
 	struct bpf_dynptr_desc dynptr;
+	struct ref_obj_desc ref_obj;
 	bool raw_mode;
 	bool pkt_access;
 	u8 release_regno;
@@ -241,7 +260,6 @@ struct bpf_call_arg_meta {
 	int access_size;
 	int mem_size;
 	u64 msize_max_value;
-	u32 id;
 	int func_id;
 	struct btf *btf;
 	u32 btf_id;
@@ -528,20 +546,6 @@ bool bpf_is_may_goto_insn(struct bpf_insn *insn)
 	return insn->code == (BPF_JMP | BPF_JCOND) && insn->src_reg == BPF_MAY_GOTO;
 }
 
-static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
-					const struct bpf_map *map)
-{
-	int ref_obj_uses = 0;
-
-	if (is_ptr_cast_function(func_id))
-		ref_obj_uses++;
-	if (is_acquire_function(func_id, map))
-		ref_obj_uses++;
-
-	return ref_obj_uses > 1;
-}
-
-
 static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_slots)
 {
        int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
@@ -670,11 +674,11 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi);
 
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				   enum bpf_arg_type arg_type, int insn_idx, int parent_id,
-				   struct bpf_dynptr_desc *dynptr)
+				   enum bpf_arg_type arg_type, int insn_idx,
+				   struct ref_obj_desc *ref_obj, struct bpf_dynptr_desc *dynptr)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi, i, err;
+	int spi, i, err, parent_id = 0;
 	enum bpf_dynptr_type type;
 
 	spi = dynptr_get_spi(env, reg);
@@ -707,6 +711,13 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		return -EINVAL;
 
 	if (dynptr->type == BPF_DYNPTR_TYPE_INVALID) { /* dynptr constructors */
+		err = validate_ref_obj(env, ref_obj);
+		if (err)
+			return err;
+
+		/* Track parent's id if the parent is a referenced object */
+		parent_id = ref_obj->id;
+
 		if (dynptr_type_referenced(type)) {
 			int id;
 
@@ -7182,7 +7193,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
  */
 static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			       argno_t argno, int insn_idx, enum bpf_arg_type arg_type,
-			       int parent_id, struct bpf_dynptr_desc *dynptr)
+			       struct ref_obj_desc *ref_obj, struct bpf_dynptr_desc *dynptr)
 {
 	int spi, err = 0;
 
@@ -7223,7 +7234,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 				return err;
 		}
 
-		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, parent_id, dynptr);
+		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, ref_obj, dynptr);
 	} else /* OBJ_RELEASE and None case from above */ {
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) {
@@ -7271,13 +7282,6 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 	return err;
 }
 
-static u32 iter_ref_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int spi)
-{
-	struct bpf_func_state *state = bpf_func(env, reg);
-
-	return state->stack[spi].spilled_ptr.id;
-}
-
 static bool is_iter_kfunc(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY);
@@ -7310,6 +7314,7 @@ static bool is_kfunc_arg_iter(struct bpf_kfunc_call_arg_meta *meta, int arg_idx,
 static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int insn_idx,
 			    struct bpf_kfunc_call_arg_meta *meta)
 {
+	struct bpf_func_state *state = bpf_func(env, reg);
 	const struct btf_type *t;
 	u32 arg_idx = arg_idx_from_argno(argno);
 	int spi, err, i, nr_slots, btf_id;
@@ -7381,7 +7386,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		/* remember meta->iter info for process_iter_next_call() */
 		meta->iter.spi = spi;
 		meta->iter.frameno = reg->frameno;
-		meta->id = iter_ref_id(env, reg, spi);
+		update_ref_obj(&meta->ref_obj, &state->stack[spi].spilled_ptr);
 
 		if (is_iter_destroy_kfunc(meta)) {
 			err = unmark_stack_slots_iter(env, reg, nr_slots);
@@ -8160,6 +8165,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	u32 regno = BPF_REG_1 + arg;
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
+	argno_t argno = argno_from_arg(arg + 1);
 	enum bpf_reg_type type = reg->type;
 	u32 *arg_btf_id = NULL;
 	u32 key_size;
@@ -8226,15 +8232,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		meta->release_regno = regno;
 	}
 
-	if (reg_is_referenced(env, reg) && base_type(arg_type) != ARG_KPTR_XCHG_DEST) {
-		if (meta->id) {
-			verbose(env, "more than one arg with referenced id R%d %u %u",
-				regno, reg->id,
-				meta->id);
-			return -EACCES;
-		}
-		meta->id = reg->id;
-	}
+	if (reg_is_referenced(env, reg))
+		update_ref_obj(&meta->ref_obj, reg);
 
 	switch (base_type(arg_type)) {
 	case ARG_CONST_MAP_PTR:
@@ -8373,7 +8372,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, reg, argno_from_reg(regno), insn_idx, arg_type, 0,
+		err = process_dynptr_func(env, reg, argno_from_reg(regno), insn_idx, arg_type, &meta->ref_obj,
 					  &meta->dynptr);
 		if (err)
 			return err;
@@ -9036,6 +9035,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
 	struct bpf_func_state *caller = cur_func(env);
 	struct bpf_verifier_log *log = &env->log;
+	struct ref_obj_desc ref_obj = {};
 	u32 i;
 	int ret, err;
 
@@ -9113,7 +9113,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (ret)
 				return ret;
 
-			ret = process_dynptr_func(env, reg, argno, -1, arg->arg_type, 0, NULL);
+			ret = process_dynptr_func(env, reg, argno, -1, arg->arg_type, &ref_obj, NULL);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
@@ -10119,8 +10119,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = -EINVAL;
 		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
 			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
-		} else if (func_id == BPF_FUNC_kptr_xchg && meta.id) {
-			u32 id = meta.id;
+		} else if (func_id == BPF_FUNC_kptr_xchg && meta.ref_obj.id) {
+			u32 id = meta.ref_obj.id;
 			bool in_rcu = in_rcu_cs(env);
 			struct bpf_func_state *state;
 			struct bpf_reg_state *reg;
@@ -10139,10 +10139,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 					}
 				}));
 			}
-		} else if (meta.id) {
-			err = release_reference(env, meta.id);
+		} else if (meta.ref_obj.id) {
+			err = release_reference(env, meta.ref_obj.id);
 		} else if (bpf_register_is_null(&regs[meta.release_regno])) {
-			/* meta.id can only be 0 if register that is meant to be
+			/* meta.ref_obj.id can only be 0 if register that is meant to be
 			 * released is NULL, which must be > R0.
 			 */
 			err = 0;
@@ -10407,17 +10407,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (type_may_be_null(regs[BPF_REG_0].type))
 		regs[BPF_REG_0].id = ++env->id_gen;
 
-	if (helper_multiple_ref_obj_use(func_id, meta.map.ptr)) {
-		verifier_bug(env, "func %s#%d sets ref_obj_id more than once",
-			     func_id_name(func_id), func_id);
-		return -EFAULT;
-	}
-
 	if (is_ptr_cast_function(func_id) &&
-	    find_reference_state(env->cur_state, meta.id)) {
+	    find_reference_state(env->cur_state, meta.ref_obj.id)) {
 		struct bpf_verifier_state *branch;
 		struct bpf_reg_state *r0;
 
+		err = validate_ref_obj(env, &meta.ref_obj);
+		if (err)
+			return err;
+
 		/*
 		 * In order for a release of any of the original or cast pointers
 		 * to invalidate all other pointers, reuse the same reference id for
@@ -10435,7 +10433,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		r0->type = SCALAR_VALUE;
 
 		regs[BPF_REG_0].type &= ~PTR_MAYBE_NULL;
-		regs[BPF_REG_0].id = meta.id;
+		regs[BPF_REG_0].id = meta.ref_obj.id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
 		int id = acquire_reference(env, insn_idx, 0);
 
@@ -11909,13 +11907,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		}
 
 		if (reg_is_referenced(env, reg)) {
-			if (is_kfunc_release(meta) && meta->id) {
-				verifier_bug(env, "more than one arg with referenced id %s %u %u",
-					     reg_arg_name(env, argno), reg->id,
-					     meta->id);
+			if (is_kfunc_release(meta) && meta->ref_obj.cnt) {
+				verbose(env, "more than one arg with referenced id %s %u %u",
+					reg_arg_name(env, argno), reg->id,
+					meta->ref_obj.id);
 				return -EFAULT;
 			}
-			meta->id = reg->id;
+			update_ref_obj(&meta->ref_obj, reg);
 			if (is_kfunc_release(meta)) {
 				if (regno < 0) {
 					verbose(env, "%s release arg cannot be a stack argument\n",
@@ -12098,7 +12096,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			}
 
 			ret = process_dynptr_func(env, reg, argno, insn_idx, dynptr_arg_type,
-						  meta->id, &meta->dynptr);
+						  &meta->ref_obj, &meta->dynptr);
 			if (ret < 0)
 				return ret;
 			break;
@@ -13042,8 +13040,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				regs[BPF_REG_0].type |= MEM_RDONLY;
 
 			/* Ensures we don't access the memory after a release_reference() */
-			if (meta.id)
-				regs[BPF_REG_0].parent_id = meta.id;
+			if (meta.ref_obj.id) {
+				err = validate_ref_obj(env, &meta.ref_obj);
+				if (err)
+					return err;
+				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
+			}
 
 			if (is_kfunc_rcu_protected(&meta))
 				regs[BPF_REG_0].type |= MEM_RCU;
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
index 21bb7da90ea5..0efafa927a3d 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_map_key.c
@@ -35,7 +35,7 @@ SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int test_ringbuf_mem_map_key(void *ctx)
 {
 	int cur_pid = bpf_get_current_pid_tgid() >> 32;
-	struct sample *sample, sample_copy;
+	struct sample *sample;
 	int *lookup_val;
 
 	if (cur_pid != pid)
@@ -55,16 +55,11 @@ int test_ringbuf_mem_map_key(void *ctx)
 	lookup_val = (int *)bpf_map_lookup_elem(&hash_map, sample);
 	__sink(lookup_val);
 
-	/* workaround - memcpy is necessary so that verifier doesn't
-	 * complain with:
-	 *   verifier internal error: more than one arg with ref_obj_id R3
-	 * when trying to do bpf_map_update_elem(&hash_map, sample, &sample->seq, BPF_ANY);
-	 *
+	/*
 	 * Since bpf_map_lookup_elem above uses 'sample' as key, test using
 	 * sample field as value below
 	 */
-	__builtin_memcpy(&sample_copy, sample, sizeof(struct sample));
-	bpf_map_update_elem(&hash_map, &sample_copy, &sample->seq, BPF_ANY);
+	bpf_map_update_elem(&hash_map, sample, &sample->seq, BPF_ANY);
 
 	bpf_ringbuf_submit(sample, 0);
 	return 0;
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 0bb4337552c8..42d523a21a43 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -2410,27 +2410,3 @@
 	.errstr_unpriv = "",
 	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
 },
-{
-	"calls: several args with ref_obj_id",
-	.insns = {
-	/* Reserve at least sizeof(struct iphdr) bytes in the ring buffer.
-	 * With a smaller size, the verifier would reject the call to
-	 * bpf_tcp_raw_gen_syncookie_ipv4 before we can reach the
-	 * ref_obj_id error.
-	 */
-	BPF_MOV64_IMM(BPF_REG_2, 20),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
-	/* if r0 == 0 goto <exit> */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_tcp_raw_gen_syncookie_ipv4),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_ringbuf = { 2 },
-	.result = REJECT,
-	.errstr = "more than one arg with ref_obj_id",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-- 
2.53.0-Meta


