Return-Path: <netdev+bounces-289572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A0vD42oDGoIkgUAu9opvQ
	(envelope-from <netdev+bounces-289572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:14:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBF25837F5
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C69D304CF60
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B6534028B;
	Tue, 19 May 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzlLLodl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8C345736
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214415; cv=none; b=N1D5HbCV+E4qjIvq3MsHAxRcQooZV8m/PuCRG4tpTwaoddPULoYpWO+PO2Wt4lyR/P0lxnhL6TxeXrQkhGS+r0MMWxr3U/2AXhpiXqRb7g4mNbShy0fH7N0fUL5AWH3h+UruWXB2KOBo9hi5xKru2UuoDZswxrPlcXoF3DrklV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214415; c=relaxed/simple;
	bh=2qmsqelTzaUPE+QK1mvrHRxBWfuhpXdRbMayHHlrJeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Top3WqdxB5yXVs0dN9Xjg8aQg0hhsVzTqp3kAMBWLCeZFisSogW1zAMZAMM9Ofw9rfoUHPge1GvVOQBcBwrLSx2RzVwRGon20OAfHAkI04OlXk/HQofmwiVyHJSVpQvxJqZmHBOobha+D8rWIgkqeqB0cA7y2bw1rURMHjooDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzlLLodl; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7c52e49d978so36081467b3.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214408; x=1779819208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aggv8QASjdRQfG/woLFGI7y1SYOCff2twxV5smHA+GQ=;
        b=KzlLLodlhqSUGWBTyMnHbZmgLFymd2GKM4LIQp0rdBiyQOrSMwD5uqtf4dsTyKVW41
         UbGeS8dRf1m+eySeseIUkWn8EY0YdslJA5moaSwfunCWP5okjZ3FcaeNw7Cqt/7wrsZc
         +FT0GgP0Q764Z8FtQK3mx5DJzBYoKdSqwTkIzuFzOIN0aGGWIpd+tkH11L+xm+ZQJtqf
         lNpMSg8lP1eYpa8DQd8nWA8r2HZDTsn6I8xkULBLc7qTnHQFFoSb0TsTURSDVxmMnicj
         LYQ5umgoOoN9kUj1h5fFNim64qtcB1mIID51GdvlWl4EwZRFzZ6cEHZwYhLPq+cPpWce
         3EJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214408; x=1779819208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aggv8QASjdRQfG/woLFGI7y1SYOCff2twxV5smHA+GQ=;
        b=Y03ubZKHC56ixcFd7IGYIyww9GFkSP/kWEYmco6URI/+yf7HNqly1L9sRX6Ezr/mkk
         t2ogurSB17r/E+T8/gs+XcjT2B/HizBNpu6nSj+uu9LO0NjFJwzkstza1ELYw/Ca+MYB
         opOGl+fD0gPIQrrsSdlobvbFVSTGglr4OaFAyDg/zuOTyhX9CLbPU+lG2qTw0FEedqxc
         WYCijN3ef4ilv2YCh6ie1jyswVJYzoRl2Wgv5c8Ym0T3htwM34LYTLoq32JFrMOLMQgB
         KhdNXF6VSUG8duearOWvLLnav89TlGs4vC4YYFssstu8GUJOEyKbnuLvaS8DgWrAhIzI
         aeCQ==
X-Gm-Message-State: AOJu0YwJNSjWVvt2e6MMEqqvyQ//qcWiMRTKG6J2mOz4u25SV2rWlkbW
	xa1K8Br89FQWZOsrSmcyNMRVBxydmdqi1XQMB5V5plSFT4I/06yYSW7o
X-Gm-Gg: Acq92OG3TczkQysVjUZsezRlwV7tszBeCWsHh+pXpbNltmVKzhrbLMdopU2uJVD91Lz
	DkKyFFxPYkj2SDiX4TZuE5mDemaOLTZoywMDGrhQ5vwf3sppYcYVZxb6l/US5wAv9u2GGkE74YX
	m5Vrx16Ju31mbYwBXvb0dbRmgC/+13Mx++gVthCx2mVVLtD35AAosMX3qkPYKELREsyXyGsYp21
	fSbAwUjwALh2ejwLrDhhdlWPSQ8PKB6b5EcwjnQPJDF1LN5VO9H3q8E1WH3/vxxqu/zco7MwVRd
	ZDMu2au4BFkKT3qauoMv+PBkJjL3wXb6WK4jhl4pm9CrmUqQ1Xu+k/ezrMg408CWCAVZ4p0Hew0
	zfdS6rsOiftTBxu9lKsB5PYyo2OUPoZvHIwocUTqp0/nY79vPrgWrgQPYCV9fZJBopePntHdEjD
	5g6jx3bAhiDZ04++Pi
X-Received: by 2002:a05:690c:c6ce:20b0:7bf:55b:8f9e with SMTP id 00721157ae682-7c95bf12374mr167301097b3.28.1779214408146;
        Tue, 19 May 2026 11:13:28 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:3e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc991ca758sm40805727b3.5.2026.05.19.11.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 08/14] bpf: Unify release handling for helpers and kfuncs
Date: Tue, 19 May 2026 11:13:06 -0700
Message-ID: <20260519181314.2731658-9-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-289572-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CCBF25837F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce release_reg() to consolidate the release logic shared by both
helpers and kfuncs: dynptr release, kptr_xchg percpu-to-RCU conversion,
regular reference release, and NULL pass-through. NULL pass-through is
only allowed if the prototype indicates the argument may be null.

Determine release_regno from the function prototype/metadata before
argument checking, rather than discovering it dynamically during
argument processing. For helpers, scan the arg_type array in
check_func_proto() via check_proto_release_reg(). For kfuncs, set
release_regno to BPF_REG_1 in bpf_fetch_kfunc_arg_meta() when
KF_RELEASE is set. In the future when we start adding decl_tag to
kfunc arguments, we can just look at the function prototype instead
of a release_regno.

Extract ref_convert_alloc_rcu_protected() and
invalidate_rcu_protected_refs() to make it more clear what the code is
doing. For ref_convert_alloc_rcu_protected(), it pre-converts
MEM_ALLOC | MEM_PERCPU registers to MEM_RCU (clearing ref_obj_id so they
survive), then calls release_reference() to invalidate the remaining
registers and release the reference state.

Add KF_RELEASE to bpf_dynptr_file_discard() so its release_regno is set
via fetch_kfunc_meta rather than being assigned manually in the dynptr
argument processing. Set arg_type to ARG_PTR_TO_DYNPTR for
KF_ARG_PTR_TO_DYNPTR so that check_func_arg_reg_off() correctly allows
non-zero stack offsets for dynptr release arguments same as helper.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h                  |   6 +-
 kernel/bpf/helpers.c                          |   2 +-
 kernel/bpf/verifier.c                         | 206 +++++++++---------
 .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |   6 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |   6 +-
 .../bpf/progs/verifier_global_ptr_args.c      |   2 +-
 .../bpf/progs/verifier_ref_tracking.c         |   2 +-
 .../selftests/bpf/progs/verifier_sock.c       |   6 +-
 .../selftests/bpf/progs/verifier_vfs_reject.c |   2 +-
 11 files changed, 121 insertions(+), 121 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0e27b92749a7..1391bd0c4259 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1460,9 +1460,9 @@ struct bpf_dynptr_desc {
 
 /*
  * The last seen rereferenced object; Updated by update_ref_obj() when a register refers to a
- * referenced object. Used when the helper or kfunc is releasing a referenced object, casting
- * a referenced object, returning allocated memory derived from referenced object or creating
- * a dynptr with a referenced object as parent.
+ * referenced object. Used when the helper or kfunc is casting a referenced object, returning
+ * allocated memory derived from referenced object or creating a dynptr with a referenced
+ * object as parent.
  */
 struct ref_obj_desc {
 	u32 id;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 07de26e7314c..da1b55aea1bd 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4857,7 +4857,7 @@ BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
-BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
+BTF_ID_FLAGS(func, bpf_dynptr_file_discard, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
 BTF_KFUNCS_END(common_btf_ids)
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bc7f8725cc69..c4b4b1dfdfda 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8210,28 +8210,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return err;
 
 skip_type_check:
-	if (arg_type_is_release(arg_type)) {
-		if (!arg_type_is_dynptr(arg_type) && !reg->ref_obj_id && !bpf_register_is_null(reg)) {
-			verbose(env, "R%d must be referenced when passed to release function\n",
-				regno);
-			return -EINVAL;
-		}
-		if (meta->release_regno) {
-			verifier_bug(env, "more than one release argument");
-			return -EFAULT;
-		}
-		meta->release_regno = regno;
+	if (arg_type_is_release(arg_type) && !arg_type_is_dynptr(arg_type) &&
+	    !reg->ref_obj_id && !bpf_register_is_null(reg)) {
+		verbose(env, "release helper %s expects referenced PTR_TO_BTF_ID passed to %s\n",
+			func_id_name(meta->func_id), reg_arg_name(env, argno));
+		return -EINVAL;
 	}
 
-	if (reg->ref_obj_id && base_type(arg_type) != ARG_KPTR_XCHG_DEST) {
-		if (meta->release_regno && meta->ref_obj.cnt) {
-			verbose(env, "more than one arg with ref_obj_id %s %u %u",
-				reg_arg_name(env, argno), reg->ref_obj_id,
-				meta->ref_obj.ref_obj_id);
-			return -EACCES;
-		}
+	if (reg->ref_obj_id)
 		update_ref_obj(&meta->ref_obj, reg);
-	}
 
 	switch (base_type(arg_type)) {
 	case ARG_CONST_MAP_PTR:
@@ -8790,11 +8777,29 @@ static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
 	return true;
 }
 
-static int check_func_proto(const struct bpf_func_proto *fn)
+static bool check_proto_release_reg(const struct bpf_func_proto *fn, struct bpf_call_arg_meta *meta)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+		enum bpf_arg_type arg_type = fn->arg_type[i];
+
+		if (arg_type_is_release(arg_type)) {
+			if (meta->release_regno)
+				return false;
+			meta->release_regno = i + 1;
+		}
+	}
+
+	return true;
+}
+
+static int check_func_proto(const struct bpf_func_proto *fn, struct bpf_call_arg_meta *meta)
 {
 	return check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
 	       check_mem_arg_rw_flag_ok(fn) &&
+	       check_proto_release_reg(fn, meta) &&
 	       check_btf_id_ok(fn) ? 0 : -EINVAL;
 }
 
@@ -8941,6 +8946,42 @@ static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 	}));
 }
 
+static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
+{
+	struct bpf_stack_state *stack;
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+	u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
+
+	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, clear_mask, ({
+		if (reg->type & MEM_RCU) {
+			reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
+			reg->type |= PTR_UNTRUSTED;
+		}
+	}));
+}
+
+static int ref_convert_alloc_rcu_protected(struct bpf_verifier_env *env, u32 ref_obj_id)
+{
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+	int err;
+
+	err = release_reference_nomark(env->cur_state, ref_obj_id);
+
+	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
+		if (reg->ref_obj_id != ref_obj_id)
+			continue;
+		if ((reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU)) {
+			reg->ref_obj_id = 0;
+			reg->type &= ~MEM_ALLOC;
+			reg->type |= MEM_RCU;
+		}
+	}));
+
+	return err;
+}
+
 static void clear_caller_saved_regs(struct bpf_verifier_env *env,
 				    struct bpf_reg_state *regs)
 {
@@ -9999,6 +10040,23 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *en
 	return "non-sleepable prog";
 }
 
+static int release_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+		       bool convert_rcu, bool release_dynptr)
+{
+	int err = -EINVAL;
+
+	if (release_dynptr)
+		err = unmark_stack_slots_dynptr(env, reg);
+	else if (convert_rcu)
+		err = ref_convert_alloc_rcu_protected(env, reg->ref_obj_id);
+	else if (reg->ref_obj_id)
+		err = release_reference(env, reg->ref_obj_id);
+	else if (bpf_register_is_null(reg))
+		err = 0;
+
+	return err;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -10048,7 +10106,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	memset(&meta, 0, sizeof(meta));
 	meta.pkt_access = fn->pkt_access;
 
-	err = check_func_proto(fn);
+	err = check_func_proto(fn, &meta);
 	if (err) {
 		verifier_bug(env, "incorrect func proto %s#%d", func_id_name(func_id), func_id);
 		return err;
@@ -10093,37 +10151,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 
 	if (meta.release_regno) {
-		err = -EINVAL;
-		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
-			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
-		} else if (func_id == BPF_FUNC_kptr_xchg && meta.ref_obj.ref_obj_id) {
-			u32 ref_obj_id = meta.ref_obj.ref_obj_id;
-			bool in_rcu = in_rcu_cs(env);
-			struct bpf_func_state *state;
-			struct bpf_reg_state *reg;
-
-			err = release_reference_nomark(env->cur_state, ref_obj_id);
-			if (!err) {
-				bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
-					if (reg->ref_obj_id == ref_obj_id) {
-						if (in_rcu && (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU)) {
-							reg->ref_obj_id = 0;
-							reg->type &= ~MEM_ALLOC;
-							reg->type |= MEM_RCU;
-						} else {
-							mark_reg_invalid(env, reg);
-						}
-					}
-				}));
-			}
-		} else if (meta.ref_obj.ref_obj_id) {
-			err = release_reference(env, meta.ref_obj.ref_obj_id);
-		} else if (bpf_register_is_null(&regs[meta.release_regno])) {
-			/* meta.ref_obj.ref_obj_id can only be 0 if register that is meant to be
-			 * released is NULL, which must be > R0.
-			 */
-			err = 0;
-		}
+		struct bpf_reg_state *reg = &regs[meta.release_regno];
+		bool convert_rcu = (func_id == BPF_FUNC_kptr_xchg) && in_rcu_cs(env) &&
+				   (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU);
+
+		err = release_reg(env, reg, convert_rcu, !!meta.dynptr.ref_obj_id);
 		if (err)
 			return err;
 	}
@@ -10499,7 +10531,6 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RELEASE;
 }
 
-
 static bool is_kfunc_destructive(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_DESTRUCTIVE;
@@ -11852,24 +11883,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EACCES;
 		}
 
-		if (reg->ref_obj_id) {
-			if (is_kfunc_release(meta) && meta->ref_obj.cnt) {
-				verbose(env, "more than one arg with ref_obj_id %s %u %u",
-					reg_arg_name(env, argno), reg->ref_obj_id,
-					meta->ref_obj.ref_obj_id);
-				return -EFAULT;
-			}
-			update_ref_obj(&meta->ref_obj, reg);
-			if (is_kfunc_release(meta)) {
-				if (regno < 0) {
-					verbose(env, "%s release arg cannot be a stack argument\n",
-						reg_arg_name(env, argno));
-					return -EINVAL;
-				}
-				meta->release_regno = regno;
-			}
+		if (regno == meta->release_regno && !is_kfunc_arg_dynptr(meta->btf, &args[i]) &&
+		    !reg->ref_obj_id && !bpf_register_is_null(reg)) {
+			verbose(env, "release kfunc %s expects referenced PTR_TO_BTF_ID passed to %s\n",
+				func_name, reg_arg_name(env, argno));
+			return -EINVAL;
 		}
 
+		if (reg->ref_obj_id)
+			update_ref_obj(&meta->ref_obj, reg);
+
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
@@ -11933,7 +11956,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 			}
 			fallthrough;
-		case KF_ARG_PTR_TO_DYNPTR:
 		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
 		case KF_ARG_PTR_TO_LIST_NODE:
@@ -11950,6 +11972,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
 			break;
+		case KF_ARG_PTR_TO_DYNPTR:
+			arg_type = ARG_PTR_TO_DYNPTR;
+			break;
 		case KF_ARG_PTR_TO_CTX:
 			arg_type = ARG_PTR_TO_CTX;
 			break;
@@ -11958,7 +11983,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EFAULT;
 		}
 
-		if (is_kfunc_release(meta) && reg->ref_obj_id)
+		if (regno == meta->release_regno)
 			arg_type |= OBJ_RELEASE;
 		ret = check_func_arg_reg_off(env, reg, argno, arg_type);
 		if (ret < 0)
@@ -12023,12 +12048,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				dynptr_arg_type |= DYNPTR_TYPE_FILE;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_file_discard]) {
 				dynptr_arg_type |= DYNPTR_TYPE_FILE | OBJ_RELEASE;
-				if (regno < 0) {
-					verbose(env, "%s release arg cannot be a stack argument\n",
-						reg_arg_name(env, argno));
-					return -EINVAL;
-				}
-				meta->release_regno = regno;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
 				   (dynptr_arg_type & MEM_UNINIT)) {
 				enum bpf_dynptr_type parent_type = meta->dynptr.type;
@@ -12306,12 +12325,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		}
 	}
 
-	if (is_kfunc_release(meta) && !meta->release_regno) {
-		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
-			func_name);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -12338,6 +12351,10 @@ int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
 
 	meta->kfunc_flags = *kfunc.flags;
 
+	/* Only support release referenced argument passed by register */
+	if (is_kfunc_release(meta))
+		meta->release_regno = BPF_REG_1;
+
 	return 0;
 }
 
@@ -12830,23 +12847,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (rcu_lock) {
 		env->cur_state->active_rcu_locks++;
 	} else if (rcu_unlock) {
-		struct bpf_stack_state *stack;
-		struct bpf_func_state *state;
-		struct bpf_reg_state *reg;
-		u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
-
 		if (env->cur_state->active_rcu_locks == 0) {
 			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
 			return -EINVAL;
 		}
-		if (--env->cur_state->active_rcu_locks == 0) {
-			bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, clear_mask, ({
-				if (reg->type & MEM_RCU) {
-					reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
-					reg->type |= PTR_UNTRUSTED;
-				}
-			}));
-		}
+		if (--env->cur_state->active_rcu_locks == 0)
+			invalidate_rcu_protected_refs(env);
 	} else if (preempt_disable) {
 		env->cur_state->active_preempt_locks++;
 	} else if (preempt_enable) {
@@ -12877,13 +12883,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
 	if (meta.release_regno) {
-		struct bpf_reg_state *reg = &regs[meta.release_regno];
-
-		if (meta.dynptr.ref_obj_id) {
-			err = unmark_stack_slots_dynptr(env, reg);
-		} else {
-			err = release_reference(env, reg->ref_obj_id);
-		}
+		err = release_reg(env, &regs[meta.release_regno], false, !!meta.dynptr.ref_obj_id);
 		if (err)
 			return err;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
index 6300b67a3a84..78566b817fd7 100644
--- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@ -11,7 +11,7 @@ struct {
 	const char *prog_name;
 	const char *err_msg;
 } cb_refs_tests[] = {
-	{ "underflow_prog", "must point to scalar, or struct with scalar" },
+	{ "underflow_prog", "release kfunc bpf_kfunc_call_test_release expects referenced PTR_TO_BTF_ID passed to R1" },
 	{ "leak_prog", "Possibly NULL pointer passed to helper R2" },
 	{ "nested_cb", "Unreleased reference id=4 alloc_insn=2" }, /* alloc_insn=2{4,5} */
 	{ "non_cb_transfer_ref", "Unreleased reference id=4 alloc_insn=1" }, /* alloc_insn=1{1,2} */
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
index a875ba8e5007..d0d65d6d450c 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
@@ -154,7 +154,7 @@ int BPF_PROG(cgrp_kfunc_xchg_unreleased, struct cgroup *cgrp, const char *path)
 }
 
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("must be referenced or trusted")
+__failure __msg("release kfunc bpf_cgroup_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(cgrp_kfunc_rcu_get_release, struct cgroup *cgrp, const char *path)
 {
 	struct cgroup *kptr;
@@ -191,7 +191,7 @@ int BPF_PROG(cgrp_kfunc_release_untrusted, struct cgroup *cgrp, const char *path
 }
 
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("R1 pointer type STRUCT cgroup must point")
+__failure __msg("release kfunc bpf_cgroup_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(cgrp_kfunc_release_fp, struct cgroup *cgrp, const char *path)
 {
 	struct cgroup *acquired = (struct cgroup *)&path;
@@ -237,7 +237,7 @@ int BPF_PROG(cgrp_kfunc_release_null, struct cgroup *cgrp, const char *path)
 }
 
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("release kernel function bpf_cgroup_release expects")
+__failure __msg("release kfunc bpf_cgroup_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(cgrp_kfunc_release_unacquired, struct cgroup *cgrp, const char *path)
 {
 	/* Cannot release trusted cgroup pointer which was not acquired. */
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index 8f36e74fd8f9..f11848dfa78f 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -252,7 +252,7 @@ int reject_untrusted_store_to_ref(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("R2 must be referenced")
+__failure __msg("release helper bpf_kptr_xchg expects referenced PTR_TO_BTF_ID passed to R2")
 int reject_untrusted_xchg(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *p;
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 41047d81ec42..8e947d445f8e 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -178,7 +178,7 @@ int BPF_PROG(task_kfunc_release_untrusted, struct task_struct *task, u64 clone_f
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("R1 pointer type STRUCT task_struct must point")
+__failure __msg("release kfunc bpf_task_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(task_kfunc_release_fp, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired = (struct task_struct *)&clone_flags;
@@ -224,7 +224,7 @@ int BPF_PROG(task_kfunc_release_null, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("release kernel function bpf_task_release expects")
+__failure __msg("release kfunc bpf_task_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(task_kfunc_release_unacquired, struct task_struct *task, u64 clone_flags)
 {
 	/* Cannot release trusted task pointer which was not acquired. */
@@ -313,7 +313,7 @@ int BPF_PROG(task_access_comm4, struct task_struct *task, const char *buf, bool
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("R1 must be referenced or trusted")
+__failure __msg("release kfunc bpf_task_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(task_kfunc_release_in_map, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *local;
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index e7dae0cf9c17..ea273e152209 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -153,7 +153,7 @@ __weak int subprog_trusted_destroy(struct task_struct *task __arg_trusted)
 
 SEC("?tp_btf/task_newtask")
 __failure __log_level(2)
-__msg("release kernel function bpf_task_release expects refcounted PTR_TO_BTF_ID")
+__msg("release kfunc bpf_task_release expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(trusted_destroy_fail, struct task_struct *task, u64 clone_flags)
 {
 	return subprog_trusted_destroy(task);
diff --git a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
index 139f70bb3595..199ad18f8eb5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ref_tracking.c
@@ -1288,7 +1288,7 @@ l1_%=:	r1 = r6;					\
 
 SEC("tc")
 __description("reference tracking: bpf_sk_release(listen_sk)")
-__failure __msg("R1 must be referenced when passed to release function")
+__failure __msg("release helper bpf_sk_release expects referenced PTR_TO_BTF_ID passed to R1")
 __naked void bpf_sk_release_listen_sk(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index a2132c72d3b8..9f680cf44512 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -603,7 +603,7 @@ l2_%=:	r0 = *(u32*)(r0 + %[bpf_tcp_sock_snd_cwnd]);	\
 
 SEC("tc")
 __description("bpf_sk_release(skb->sk)")
-__failure __msg("R1 must be referenced when passed to release function")
+__failure __msg("release helper bpf_sk_release expects referenced PTR_TO_BTF_ID passed to R1")
 __naked void bpf_sk_release_skb_sk(void)
 {
 	asm volatile ("					\
@@ -620,7 +620,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tc")
 __description("bpf_sk_release(bpf_sk_fullsock(skb->sk))")
-__failure __msg("R1 must be referenced when passed to release function")
+__failure __msg("release helper bpf_sk_release expects referenced PTR_TO_BTF_ID passed to R1")
 __naked void bpf_sk_fullsock_skb_sk(void)
 {
 	asm volatile ("					\
@@ -644,7 +644,7 @@ l1_%=:	r1 = r0;					\
 
 SEC("tc")
 __description("bpf_sk_release(bpf_tcp_sock(skb->sk))")
-__failure __msg("R1 must be referenced when passed to release function")
+__failure __msg("release helper bpf_sk_release expects referenced PTR_TO_BTF_ID passed to R1")
 __naked void bpf_tcp_sock_skb_sk(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index 0990de076844..2870738d93f7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -80,7 +80,7 @@ int BPF_PROG(get_task_exe_file_kfunc_unreleased)
 }
 
 SEC("lsm.s/file_open")
-__failure __msg("release kernel function bpf_put_file expects")
+__failure __msg("release kfunc bpf_put_file expects referenced PTR_TO_BTF_ID passed to R1")
 int BPF_PROG(put_file_kfunc_unacquired, struct file *file)
 {
 	/* Can't release an unacquired pointer. */
-- 
2.53.0-Meta


