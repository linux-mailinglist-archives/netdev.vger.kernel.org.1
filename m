Return-Path: <netdev+bounces-284880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP74M3VQ+2mSZQMAu9opvQ
	(envelope-from <netdev+bounces-284880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:30:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB884DC34B
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09096303F550
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0CD480976;
	Wed,  6 May 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcCbAN+m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED6481659
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077650; cv=none; b=REd606wSFE/vDAsVKdOJcxTG/fJ5UEdRamc3Bi+m1MlGQYJvvfPSsvTvzzVMgN3lYqLrs4MkVSNrcW9bwziPWE6kDZ5Rs9j0Y1mZa4LlTi3mjEq3XOJxB7/pnt8VEcgOq9UVtBbOuOwgG08ebmxn/ZtZdbv+kRuyU+CuItnQlW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077650; c=relaxed/simple;
	bh=nu7HCh40/khQJQqO3ag9UG91eaq2muyTJaFV3sOa7Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2PworBwATa6gFHOXqSZZaW+gkvq0tutZASoTVOF0UaVZMPqpMA1wNK4252tVjj6dwcseeDH07uMUwgsGz59lmsbQvMnk3b0oPYyKn1/6fUXm8+OEb3GOA9S25V35zmx0dMFixjQ8jEXkRy+CTC5dp8207AriMXj7lXmlPekiio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcCbAN+m; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899d6b7b073so66981556d6.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077644; x=1778682444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rhYIiaH0ksDkYjBc2M4IA/64uP8u9PyFNIgG+K84cw=;
        b=UcCbAN+m5A73QPHzKZ4BsNCD9do6TMj5dP/4fNi1lJg9JZ+meRFVfGDMc3ql3VjK5I
         3uMJ8nF2C+1IudV3A2HIyAqIF+euhz4l8Wtl0hN9iUweNU/i8pNJmFxViIOamx8PxEl2
         xWX53nLUpkBPSz3SyyVjBiO3W1/c9qDIXkeor8oOpUeq990dWcgXo4pw7IcZmdGNtp1M
         A0WKZWwz7oUT19YQQEUdQdNBtpQJ90KRRK7xqdLxDABlFt6aLA6mml4yK24jCufkgPKP
         ZJFT+6WWKecBzk8HiA9Xtg9swzMJOL9+hPSKS/KJInUkfllEp2afeSIorqsvkJTGztdr
         fUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077644; x=1778682444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+rhYIiaH0ksDkYjBc2M4IA/64uP8u9PyFNIgG+K84cw=;
        b=D1Ff14912lBrfx7kPSoZOX7Cqa3kGqcPhMAT3q+HHjWOW5C1fy/I8olOhKMgVWpyAx
         5Nqxf2DDVQFH63K0y7qUokeS3wUWsitITeoq5jDwRxB0OMa8yhA2p5ErwKHIJF4J8+lL
         xDGOvXN8LAVFvHrthlT/kcAcQbUde0mUns5Wg+A6lGTH1FFNa9bwx1an64ebICmsqisy
         TlLqtPH3Yvgkk0xZumuUvg0laCSxwbWRaH8fab7QTaVWj/gioln8R1GyGEFc+eNrMSAr
         PFrbnk9Cm23Rf0a0+5Fxm29c6ytv0c0069cQ9HPUGx7w0+J2vZZ+8eZyNqrjd5f40k5d
         nNXQ==
X-Gm-Message-State: AOJu0Yzhv91ONCeOKBZVYDiDi2R+6CKzmBRumw52s5fi1dA/bZq2Tnmg
	aauGhT4xF8RoKbZzUStjm3kGvWEZFhAEwapPN/gpvDTZyApsT/TRjQub
X-Gm-Gg: AeBDieuDKsxNx1sDVoKiV/9iZx1q4zP4du2ANa16RU68K1Wcm3ANfVurPY2uN2bEnX5
	IQ3h/dNpIGk8vAon1miNDetVKd/Y1GdK4hy9C7rvXyJLy/S8OBvmqInctJa/YoP2PBIbClj+rbE
	YRIRtGf2PP7YO8tCKe7PAQXLwqqGqVmgApvFQMdO+7fVnQk9vYkrUMx1AKW1tN3HfRFwWY6LuZ7
	b1ibKPU9FXAOM9G8fso/IoPVIk7+mVbU1lV0tDnN8cZpY7A55BO6aBIHhtFfYyB/EfDiQo0a+FC
	8OY0y65AqYCl3wgz36Bq2/UDWfsr1ZJHLHjZxb2E8kJ/vxBf5XQSGl7U3eyPUg4sMCPOiymQGho
	x6LXLcmuy6GR5ILXH8jNU9cCpMCATqwkD5jO+gQnSRBsNFav6rIz+3Hbhuwq18yPI/p8dlI2cuF
	PN9wXmBDsMNisToyiErc4E0CfPsKo=
X-Received: by 2002:a05:6214:246e:b0:8a6:1216:fb7d with SMTP id 6a1803df08f44-8bc45845af7mr50668996d6.45.1778077643423;
        Wed, 06 May 2026 07:27:23 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:30::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c6b8092sm196940606d6.34.2026.05.06.07.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking in verifier
Date: Wed,  6 May 2026 07:27:03 -0700
Message-ID: <20260506142709.2298255-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260506142709.2298255-1-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7AB884DC34B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284880-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Helpers and kfuncs independently tracked referenced object metadata (id,
ref_obj_id) using separate fields on their respective arg_meta structs.
This led to duplicated logic and inconsistent error handling between the
two paths.

Introduce struct ref_obj_desc to consolidate these fields along with a
count of how many arguments carry a reference. Add update_ref_obj() to
populate it from a bpf_reg_state, replacing open-coded assignments in
check_func_arg(), check_kfunc_args(), and process_iter_arg().

Both helper and kfunc now use ref_obj.cnt to detect ambiguous ref_obj
args. For ref_obj releasing helpers and kfuncs, keep checking it before
calling update_ref_obj() for now. A later patch will make these
functions not depending on ref_obj. For other users of ref_obj, move the
checks to the use locations. For helper, this means moving the checks
inside helper_multiple_ref_obj_use() to use locations.
is_acquire_function() is dropped as ref_obj is never used.

Pass ref_obj_desc into process_dynptr_func()/mark_stack_slots_dynptr()
instead of a bare parent_id to make it less confusing.

Drop the selftest introduced in 7ec899ac90a2 (“selftests/bpf: Negative
test case for ref_obj_id in args”) since the verifier no longer
complains about ambiguous ref_obj if it is not used.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h                 |  15 ++-
 kernel/bpf/verifier.c                        | 111 +++++++++----------
 tools/testing/selftests/bpf/verifier/calls.c |  24 ----
 3 files changed, 68 insertions(+), 82 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 51d5f5dd6e5b..a531be98fedf 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1397,6 +1397,18 @@ struct bpf_dynptr_desc {
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
+	u32 ref_obj_id;
+	u8 cnt;
+};
+
 struct bpf_kfunc_call_arg_meta {
 	/* In parameters */
 	struct btf *btf;
@@ -1405,8 +1417,6 @@ struct bpf_kfunc_call_arg_meta {
 	const struct btf_type *func_proto;
 	const char *func_name;
 	/* Out parameters */
-	u32 ref_obj_id;
-	u32 id;
 	u8 release_regno;
 	bool r0_rdonly;
 	u32 ret_btf_id;
@@ -1444,6 +1454,7 @@ struct bpf_kfunc_call_arg_meta {
 	} iter;
 	struct bpf_map_desc map;
 	struct bpf_dynptr_desc dynptr;
+	struct ref_obj_desc ref_obj;
 	u64 mem_size;
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 792e61e07b06..542912c7983f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -234,6 +234,7 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
 struct bpf_call_arg_meta {
 	struct bpf_map_desc map;
 	struct bpf_dynptr_desc dynptr;
+	struct ref_obj_desc ref_obj;
 	bool raw_mode;
 	bool pkt_access;
 	u8 release_regno;
@@ -525,20 +526,6 @@ bool bpf_is_may_goto_insn(struct bpf_insn *insn)
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
@@ -667,11 +654,11 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi);
 
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				   enum bpf_arg_type arg_type, int insn_idx, int parent_id,
-				   struct bpf_dynptr_desc *dynptr)
+				   enum bpf_arg_type arg_type, int insn_idx,
+				   struct ref_obj_desc *ref_obj, struct bpf_dynptr_desc *dynptr)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi, i, err, ref_obj_id = 0;
+	int spi, i, err, ref_obj_id = 0, parent_id = 0;
 	enum bpf_dynptr_type type;
 
 	spi = dynptr_get_spi(env, reg);
@@ -713,6 +700,13 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 				return ref_obj_id;
 		}
 		/* Track parent's id if the parent is a referenced object */
+		if (ref_obj && ref_obj->ref_obj_id) {
+			if (ref_obj->cnt > 1) {
+				verifier_bug(env, "function expects only one referenced object but got %d\n", ref_obj->cnt);
+				return -EFAULT;
+			}
+			parent_id = ref_obj->id;
+		}
 	} else { /* bpf_dynptr_clone() */
 		ref_obj_id = dynptr->ref_obj_id;
 		parent_id = dynptr->parent_id;
@@ -6982,7 +6976,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
  */
 static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			       argno_t argno, int insn_idx, enum bpf_arg_type arg_type,
-			       int parent_id, struct bpf_dynptr_desc *dynptr)
+			       struct ref_obj_desc *ref_obj, struct bpf_dynptr_desc *dynptr)
 {
 	int spi, err = 0;
 
@@ -7023,7 +7017,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 				return err;
 		}
 
-		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, parent_id, dynptr);
+		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, ref_obj, dynptr);
 	} else /* OBJ_RELEASE and None case from above */ {
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) {
@@ -7072,13 +7066,6 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 	return err;
 }
 
-static u32 iter_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int spi)
-{
-	struct bpf_func_state *state = bpf_func(env, reg);
-
-	return state->stack[spi].spilled_ptr.ref_obj_id;
-}
-
 static bool is_iter_kfunc(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY);
@@ -7108,9 +7095,17 @@ static bool is_kfunc_arg_iter(struct bpf_kfunc_call_arg_meta *meta, int arg_idx,
 	return btf_param_match_suffix(meta->btf, arg, "__iter");
 }
 
+static void update_ref_obj(struct ref_obj_desc *ref_obj, struct bpf_reg_state *reg)
+{
+	ref_obj->id = reg->id;
+	ref_obj->ref_obj_id = reg->ref_obj_id;
+	ref_obj->cnt++;
+}
+
 static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int insn_idx,
 			    struct bpf_kfunc_call_arg_meta *meta)
 {
+	struct bpf_func_state *state = bpf_func(env, reg);
 	const struct btf_type *t;
 	u32 arg_idx = arg_from_argno(argno) - 1;
 	int spi, err, i, nr_slots, btf_id;
@@ -7182,7 +7177,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		/* remember meta->iter info for process_iter_next_call() */
 		meta->iter.spi = spi;
 		meta->iter.frameno = reg->frameno;
-		meta->ref_obj_id = iter_ref_obj_id(env, reg, spi);
+		update_ref_obj(&meta->ref_obj, &state->stack[spi].spilled_ptr);
 
 		if (is_iter_destroy_kfunc(meta)) {
 			err = unmark_stack_slots_iter(env, reg, nr_slots);
@@ -7961,6 +7956,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	u32 regno = BPF_REG_1 + arg;
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
+	argno_t argno = argno_from_arg(arg + 1);
 	enum bpf_reg_type type = reg->type;
 	u32 *arg_btf_id = NULL;
 	u32 key_size;
@@ -8028,14 +8024,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	}
 
 	if (reg->ref_obj_id && base_type(arg_type) != ARG_KPTR_XCHG_DEST) {
-		if (meta->ref_obj_id) {
-			verbose(env, "more than one arg with ref_obj_id R%d %u %u",
-				regno, reg->ref_obj_id,
-				meta->ref_obj_id);
+		if (meta->release_regno && meta->ref_obj.cnt) {
+			verbose(env, "more than one arg with ref_obj_id %s %u %u",
+				reg_arg_name(env, argno), reg->ref_obj_id,
+				meta->ref_obj.ref_obj_id);
 			return -EACCES;
 		}
-		meta->ref_obj_id = reg->ref_obj_id;
-		meta->id = reg->id;
+		update_ref_obj(&meta->ref_obj, reg);
 	}
 
 	switch (base_type(arg_type)) {
@@ -8175,7 +8170,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, reg, argno_from_reg(regno), insn_idx, arg_type, 0,
+		err = process_dynptr_func(env, reg, argno_from_reg(regno), insn_idx, arg_type, NULL,
 					  &meta->dynptr);
 		if (err)
 			return err;
@@ -8900,7 +8895,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (ret)
 				return ret;
 
-			ret = process_dynptr_func(env, reg, argno, -1, arg->arg_type, 0, NULL);
+			ret = process_dynptr_func(env, reg, argno, -1, arg->arg_type, NULL, NULL);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
@@ -9878,8 +9873,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = -EINVAL;
 		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
 			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
-		} else if (func_id == BPF_FUNC_kptr_xchg && meta.ref_obj_id) {
-			u32 ref_obj_id = meta.ref_obj_id;
+		} else if (func_id == BPF_FUNC_kptr_xchg && meta.ref_obj.ref_obj_id) {
+			u32 ref_obj_id = meta.ref_obj.ref_obj_id;
 			bool in_rcu = in_rcu_cs(env);
 			struct bpf_func_state *state;
 			struct bpf_reg_state *reg;
@@ -9898,10 +9893,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 					}
 				}));
 			}
-		} else if (meta.ref_obj_id) {
-			err = release_reference(env, meta.ref_obj_id);
+		} else if (meta.ref_obj.ref_obj_id) {
+			err = release_reference(env, meta.ref_obj.ref_obj_id);
 		} else if (bpf_register_is_null(&regs[meta.release_regno])) {
-			/* meta.ref_obj_id can only be 0 if register that is meant to be
+			/* meta.ref_obj.ref_obj_id can only be 0 if register that is meant to be
 			 * released is NULL, which must be > R0.
 			 */
 			err = 0;
@@ -10165,15 +10160,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (type_may_be_null(regs[BPF_REG_0].type))
 		regs[BPF_REG_0].id = ++env->id_gen;
 
-	if (helper_multiple_ref_obj_use(func_id, meta.map.ptr)) {
-		verifier_bug(env, "func %s#%d sets ref_obj_id more than once",
-			     func_id_name(func_id), func_id);
-		return -EFAULT;
-	}
-
 	if (is_ptr_cast_function(func_id)) {
 		/* For release_reference() */
-		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
+		if (meta.ref_obj.cnt > 1) {
+			verifier_bug(env, "function expects only one referenced object but got %d\n",
+				     meta.ref_obj.cnt);
+			return -EFAULT;
+		}
+		regs[BPF_REG_0].ref_obj_id = meta.ref_obj.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
 		int id = acquire_reference(env, insn_idx);
 
@@ -11616,14 +11610,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		}
 
 		if (reg->ref_obj_id) {
-			if (is_kfunc_release(meta) && meta->ref_obj_id) {
-				verifier_bug(env, "more than one arg with ref_obj_id %s %u %u",
-					     reg_arg_name(env, argno), reg->ref_obj_id,
-					     meta->ref_obj_id);
+			if (is_kfunc_release(meta) && meta->ref_obj.cnt) {
+				verbose(env, "more than one arg with ref_obj_id %s %u %u",
+					reg_arg_name(env, argno), reg->ref_obj_id,
+					meta->ref_obj.ref_obj_id);
 				return -EFAULT;
 			}
-			meta->ref_obj_id = reg->ref_obj_id;
-			meta->id = reg->id;
+			update_ref_obj(&meta->ref_obj, reg);
 			if (is_kfunc_release(meta))
 				meta->release_regno = regno;
 		}
@@ -11794,7 +11787,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			}
 
 			ret = process_dynptr_func(env, reg, argno, insn_idx, dynptr_arg_type,
-						  meta->ref_obj_id ? meta->id : 0, &meta->dynptr);
+						  &meta->ref_obj, &meta->dynptr);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12740,8 +12733,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				regs[BPF_REG_0].type |= MEM_RDONLY;
 
 			/* Ensures we don't access the memory after a release_reference() */
-			if (meta.ref_obj_id)
-				regs[BPF_REG_0].parent_id = meta.ref_obj_id;
+			if (meta.ref_obj.ref_obj_id) {
+				if (meta.ref_obj.cnt > 1) {
+					verifier_bug(env, "function expects only one referenced object but got %d\n",
+						     meta.ref_obj.cnt);
+					return -EFAULT;
+				}
+				regs[BPF_REG_0].parent_id = meta.ref_obj.ref_obj_id;
+			}
 
 			if (is_kfunc_rcu_protected(&meta))
 				regs[BPF_REG_0].type |= MEM_RCU;
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
2.52.0


