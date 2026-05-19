Return-Path: <netdev+bounces-289570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGIkOn6oDGoIkgUAu9opvQ
	(envelope-from <netdev+bounces-289570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:14:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6510C5837E5
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E605230684B9
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A30F344D91;
	Tue, 19 May 2026 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aiafw/lG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440D341660
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214410; cv=none; b=PoehVn3g9natC0C28SwoeY3FeiXfgrvmlJE8IEsNk189/yp0WraNgz2J1gFCVINuKgVyFVN2C2GJDdkyyhnzGIWsj8/E+elzeOXd1UgAZI/i8LtM+hTHmPDCh64eSeonE96OxYvdC1VjxXBkfu2XkNgUSHJXYZwIZxUoWyzbKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214410; c=relaxed/simple;
	bh=ouzmvsnRkwpZ8W/u3WwzPzLXyf7uqdRs1Ent+qWBP2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZSECxHq39kk1/iajiVQ2OevLoV4QB8zGJUQlHbz7+yDjDHo39syXyrctzjzRZnm139TZVAq+sW7PfV3N00ejadCQR5Qyp3IOqxFmJD/nVz0yDrfFNFiz03llt3Lk6e2h7sN0C0RZwx+21QtpFB2N+KvqubXvWDZIkzwlSplCBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aiafw/lG; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-651c5d525f6so4015252d50.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214407; x=1779819207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9vuEZ9clKtyiX6S1pd6lRPe1pCSfFS2thpXEIF4jKY=;
        b=Aiafw/lGxMSt4j0uYqtngEABcNau1mJzabom5QvBFVbclrBoHxrP3AM1t349tcRVhZ
         Cpn6pSwe5P3e1ewSHf0+nh8YFC3KXgTYdFm47TRA/KzETVwoP0eHO+d9FTyq8tAWAh/K
         k4hNaITlfQkhCjtP/++efanhpVjYvCSDMJdCpb2coWMsRxuNfxYW7i11HCDG9snum7+Q
         ypitkJ2wc5fLoZC3ZsL3Vui5CK0e8YXQiwTnAR6d7t4gtYZyZp7DZ3kyhh79SvO8vrcp
         Z45RZALLG56Y+tOMvpfGLHFkWxaYM8dEtvyzsTw7FhprEX8oJ8YSBtgoScsHS0Aos+Nw
         LWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214407; x=1779819207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9vuEZ9clKtyiX6S1pd6lRPe1pCSfFS2thpXEIF4jKY=;
        b=ToQFyJrpBgtPDG4SY0FUVQlJhGRPo+DwyNMZDOavFrxVL3oMRqabzLNwromDCHkUFp
         36hkHYCWT3L7mJNOW4fAIxeiWJDFMEK8wsl/bvDGnsRfDFVaU4aPj2IzDxm7eWMSVJeG
         u2byPrXGj0PzlHjg1SBmMPLt0eO7xSdkEyduMB8BXHPLZdacKlTZ7gV2alR3LG8WafGO
         JArjwHdD9R6diMavBvfdZiK8516AREh9WRzHKSXNu/XaQ3CC0Mo7GGlkHm850YZaRg1/
         D0agHnUnCB9FdgYQuhXapZfp9p4A1eo7nEZ7fhaaEuF9iNyzz0KyYqxphlGeG7FPGMFn
         wLMA==
X-Gm-Message-State: AOJu0YzpHBXp/sHjKiuETxE0uarARLZZVftF+ETL/1ByY2BHK3R1BoMp
	b11CZYi0FudKJQbLXEV/H83+VaEX7iqyYTxq7+0UI2pO4YAgJLAi4z6i
X-Gm-Gg: Acq92OHD1uzNfpJnbvRETj6ZY5bSV57E7HHCOKLuFv/Kd/BUg/e30ZPyW2ao264Z9Ei
	JQlVmJjAIib0BfDA8bva9xAcwLuo6C7dgbE4VIxTLcl+Ksv2Fl3SbEXaMPS5PGzsSdQTS0nR38l
	MIZGRZIZhtQXuMwMfno5nnEc5zHyaUEZaxF6npacJymw5RzYnltJD/Nx6Y9tka5qYhuJDAkAZpt
	RHoyhhqxv9x+jVTzH9+LXTEahumnRhuQqzIIu5tgFkZ/VrVHgpReA4+G3dWDjmb18yYKL8SaG8G
	dU8yyPMwWZlBOY5aFHMYTEuUycVL63kMH6Dl1IGk67zP0SEnCSA1rxosbSwnmb1YR6+XKpW6smq
	fVAKBJYYN7g+OaNL4Hrmea8Q7Pl+Lf7DuVoAwGDNzQHHjHunouBBjYbhF2UjvdGKjumAVSpZE0S
	PxLIbcZOvrAzRx2CkXD+qIrQp5Jrw=
X-Received: by 2002:a05:690e:150c:b0:658:e645:7736 with SMTP id 956f58d0204a3-65e2280daf5mr17154025d50.39.1779214406523;
        Tue, 19 May 2026 11:13:26 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:39::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d8e60c5sm8138834d50.7.2026.05.19.11.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 07/14] bpf: Unify referenced object tracking in verifier
Date: Tue, 19 May 2026 11:13:05 -0700
Message-ID: <20260519181314.2731658-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519181314.2731658-1-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289570-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6510C5837E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Helpers and kfuncs independently tracked referenced object metadata (id,
ref_obj_id) using separate fields in their respective arg_meta structs.
This led to duplicated logic and inconsistent error handling between the
two paths.

Introduce struct ref_obj_desc to consolidate these fields along with a
count of how many arguments carry a reference. Add update_ref_obj() to
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

Drop the selftest introduced in 7ec899ac90a2 (“selftests/bpf: Negative
test case for ref_obj_id in args”) since the verifier no longer
complains about ambiguous ref_obj if it is not used.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h                  |  15 ++-
 kernel/bpf/verifier.c                         | 118 +++++++++---------
 .../bpf/progs/test_ringbuf_map_key.c          |  11 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  24 ----
 4 files changed, 78 insertions(+), 90 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d83b9fbfef7f..0e27b92749a7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1458,6 +1458,18 @@ struct bpf_dynptr_desc {
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
@@ -1466,8 +1478,6 @@ struct bpf_kfunc_call_arg_meta {
 	const struct btf_type *func_proto;
 	const char *func_name;
 	/* Out parameters */
-	u32 ref_obj_id;
-	u32 id;
 	u8 release_regno;
 	bool r0_rdonly;
 	u32 ret_btf_id;
@@ -1505,6 +1515,7 @@ struct bpf_kfunc_call_arg_meta {
 	} iter;
 	struct bpf_map_desc map;
 	struct bpf_dynptr_desc dynptr;
+	struct ref_obj_desc ref_obj;
 	u64 mem_size;
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edebeb3ad363..bc7f8725cc69 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -231,9 +231,28 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
 			     (poisoned ? BPF_MAP_KEY_POISON : 0ULL);
 }
 
+static void update_ref_obj(struct ref_obj_desc *ref_obj, struct bpf_reg_state *reg)
+{
+	ref_obj->id = reg->id;
+	ref_obj->ref_obj_id = reg->ref_obj_id;
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
@@ -530,20 +549,6 @@ bool bpf_is_may_goto_insn(struct bpf_insn *insn)
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
@@ -670,11 +675,11 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
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
@@ -707,12 +712,18 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		return -EINVAL;
 
 	if (dynptr->type == BPF_DYNPTR_TYPE_INVALID) { /* dynptr constructors */
+		err = validate_ref_obj(env, ref_obj);
+		if (err)
+			return err;
+
 		if (dynptr_type_referenced(type)) {
 			ref_obj_id = acquire_reference(env, insn_idx);
 			if (ref_obj_id < 0)
 				return ref_obj_id;
 		}
+
 		/* Track parent's id if the parent is a referenced object */
+		parent_id = ref_obj->id;
 	} else { /* bpf_dynptr_clone() */
 		ref_obj_id = dynptr->ref_obj_id;
 		parent_id = dynptr->parent_id;
@@ -7172,7 +7183,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
  */
 static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			       argno_t argno, int insn_idx, enum bpf_arg_type arg_type,
-			       int parent_id, struct bpf_dynptr_desc *dynptr)
+			       struct ref_obj_desc *ref_obj, struct bpf_dynptr_desc *dynptr)
 {
 	int spi, err = 0;
 
@@ -7213,7 +7224,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 				return err;
 		}
 
-		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, parent_id, dynptr);
+		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, ref_obj, dynptr);
 	} else /* OBJ_RELEASE and None case from above */ {
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) {
@@ -7262,13 +7273,6 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
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
@@ -7301,6 +7305,7 @@ static bool is_kfunc_arg_iter(struct bpf_kfunc_call_arg_meta *meta, int arg_idx,
 static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int insn_idx,
 			    struct bpf_kfunc_call_arg_meta *meta)
 {
+	struct bpf_func_state *state = bpf_func(env, reg);
 	const struct btf_type *t;
 	u32 arg_idx = arg_idx_from_argno(argno);
 	int spi, err, i, nr_slots, btf_id;
@@ -7372,7 +7377,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		/* remember meta->iter info for process_iter_next_call() */
 		meta->iter.spi = spi;
 		meta->iter.frameno = reg->frameno;
-		meta->ref_obj_id = iter_ref_obj_id(env, reg, spi);
+		update_ref_obj(&meta->ref_obj, &state->stack[spi].spilled_ptr);
 
 		if (is_iter_destroy_kfunc(meta)) {
 			err = unmark_stack_slots_iter(env, reg, nr_slots);
@@ -8151,6 +8156,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	u32 regno = BPF_REG_1 + arg;
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
+	argno_t argno = argno_from_arg(arg + 1);
 	enum bpf_reg_type type = reg->type;
 	u32 *arg_btf_id = NULL;
 	u32 key_size;
@@ -8218,14 +8224,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -8365,7 +8370,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, reg, argno_from_reg(regno), insn_idx, arg_type, 0,
+		err = process_dynptr_func(env, reg, argno_from_reg(regno), insn_idx, arg_type, &meta->ref_obj,
 					  &meta->dynptr);
 		if (err)
 			return err;
@@ -9021,6 +9026,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
 	struct bpf_func_state *caller = cur_func(env);
 	struct bpf_verifier_log *log = &env->log;
+	struct ref_obj_desc ref_obj = {};
 	u32 i;
 	int ret, err;
 
@@ -9098,7 +9104,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (ret)
 				return ret;
 
-			ret = process_dynptr_func(env, reg, argno, -1, arg->arg_type, 0, NULL);
+			ret = process_dynptr_func(env, reg, argno, -1, arg->arg_type, &ref_obj, NULL);
 			if (ret)
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
@@ -10090,8 +10096,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -10110,10 +10116,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -10378,15 +10384,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
+		err = validate_ref_obj(env, &meta.ref_obj);
+		if (err)
+			return err;
+		regs[BPF_REG_0].ref_obj_id = meta.ref_obj.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
 		int id = acquire_reference(env, insn_idx);
 
@@ -11850,14 +11853,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
 			if (is_kfunc_release(meta)) {
 				if (regno < 0) {
 					verbose(env, "%s release arg cannot be a stack argument\n",
@@ -12040,7 +12042,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			}
 
 			ret = process_dynptr_func(env, reg, argno, insn_idx, dynptr_arg_type,
-						  meta->ref_obj_id ? meta->id : 0, &meta->dynptr);
+						  &meta->ref_obj, &meta->dynptr);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12987,8 +12989,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				regs[BPF_REG_0].type |= MEM_RDONLY;
 
 			/* Ensures we don't access the memory after a release_reference() */
-			if (meta.ref_obj_id)
-				regs[BPF_REG_0].parent_id = meta.ref_obj_id;
+			if (meta.ref_obj.ref_obj_id) {
+				err = validate_ref_obj(env, &meta.ref_obj);
+				if (err)
+					return err;
+				regs[BPF_REG_0].parent_id = meta.ref_obj.ref_obj_id;
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


