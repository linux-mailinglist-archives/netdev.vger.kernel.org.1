Return-Path: <netdev+bounces-289569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GWbGyqpDGoIkgUAu9opvQ
	(envelope-from <netdev+bounces-289569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:17:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB3558386B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C2D230C9F47
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB13451CC;
	Tue, 19 May 2026 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEO/Al1b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7D342510
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214408; cv=none; b=uUHo2jzjmIdGYrfY4XvTz4gthitHT2rkm58AJrtvff7fXRN3cKXQTP+mCpISEfalbWSFmZEmnJXv9BUFnNcpLcqe/VJRSwj9BhSx8wPFDiS02boSDuS9J0X7FnoaNUwucNPwVTN32vocURAr6a44vs+h9GB9Q3qRxTIA10LkwMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214408; c=relaxed/simple;
	bh=NHDhlKSfNAeY+ZADwb1fHwoUEzDVnHa7N4kk52TuGj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfgQ4qVkXhSDunFM+0Y896p92nSpnzWhh5d0bK4gGNsaFUeWShuj9gF4YvW92oW0Iv9Ht46omzl9EQJxkeE13FjM82wMzGUQr1jzI1Fyd9+u9xgCjNMnJPjJ95Sq3yn7Auu3c4tB7xFycfQtWXDpFRshiIdCUzLRTwEuab3eNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEO/Al1b; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7cff695e6b1so7657337b3.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214404; x=1779819204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ISsbFB16c6AG88qW/EFh4KlJwyGkDeWfrFxp74ABDE=;
        b=dEO/Al1bF8DuKQjg4rXxr3gh8OilS2NJsfULZeY5qj2DqMYjU+uZeVvNHWhsK4n889
         lzkRRNiAdwmwHSufv1r+sZyU1UXL3AEjwIF9XnB4HhY7uJNIJC1Rvq+eNm/Iauk58p4a
         czFBFRpgWeoxTYFk2EgevJrOa0K9cANAz5oSPIHCAYEpOMAJN/so7JZliGdx49MlRChi
         0kd+DhvTfg/c5gQ7YX8AIq174ttNXXWjqVcVkH3sjAe8DKGh8kmxxQpdrrGFnppnRZQU
         Q3KSaSkd87sJ1stjtS7Oh/8dmSicVP02k7GcAZ6XFprcU11eDguMr4Qbtl/I7CJ5VCnG
         trTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214404; x=1779819204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ISsbFB16c6AG88qW/EFh4KlJwyGkDeWfrFxp74ABDE=;
        b=pVGqBVZpH8dGKeDY5HRL4BLMTmS6tKSwmoaM01+uiFhGlgohunfNjWJAXSP9nR4jjH
         INZ07MisuZCjqqZ3Vnofg6WgikQazkrKIjPUgzy1XnDAw94gXrmhQcRuNpLM8wmJ7zWq
         7lmwRKt3epHRB2ruHfiN69FD3RAty+ETIxRjezgXfOeDW7EeTxh6D221UdgOGDK1OllZ
         Oa9YN3oXXzfrfJnXFBU5KggwjDEIrqrcaiUsjx6oldlJPuw39fKKlAzCYZec7rLFRHGx
         ICqIUCfZVjm5d0Q6yfORUCldpWQruVEUv/CDCu3abjUPe0U+76CuU/pvZUe6QJFQe0Z0
         vfPQ==
X-Gm-Message-State: AOJu0YwmHcZ6a4a9wggaz8lSaMwhlXULmAvPFn5n/31CSHxVOMLUrtxF
	6xzM2oOHrHjSGA2HJ7uB3vDAyPTJxgs5V0fh5Kc5GiMpS1VM4sctmuz6
X-Gm-Gg: Acq92OE9/0WhoFEsYfEy2w/WdM+YHdqTBdE9LAqRpYo173z5VtQYxSUNujrwPbWBJV7
	V0IVItvfvRaKIEDJFW0sfJoO42vokckmdYdCXFoBg2b/vun75N9V1qE9kXiNjV4P+hajcXY7VLN
	ZRZehfrdVnbkejxh3pG26PfyqelRArE6KtDz5DBGQ+gcsmygsuXwCGv/XhpeIqqVKcQZ1c0GcPH
	hftW6aiWVOoXb7P34AWat1R/Q1SATUG34WlPPUR3VN0PoYo3a7xQ6bN9NPCcdcPDtx1YBTHCdV9
	9Stfw4iluUr3BmdFHglAEDHaZ8MCo2gh/e9xxIrDWZ+qGUWmsLuhUIdAubbIVqaCiTnKKqZSaNP
	Jqb780ZlgVlTMnhqu3QZ1MFVyVnu92fYX/QeO9ouhijicF/uv8+4a7Rs7zAuHv4H8l57rxC9nQ1
	Bg/fQmiyz8+VU4t466
X-Received: by 2002:a05:690c:9304:b0:78f:bc2b:83f5 with SMTP id 00721157ae682-7c95a087a51mr196660987b3.20.1779214403505;
        Tue, 19 May 2026 11:13:23 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:22::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9d18c769sm40510157b3.47.2026.05.19.11.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 05/14] bpf: Refactor object relationship tracking and fix dynptr UAF bug
Date: Tue, 19 May 2026 11:13:03 -0700
Message-ID: <20260519181314.2731658-6-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289569-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BEB3558386B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor object relationship tracking in the verifier and fix a dynptr
use-after-free bug where file/skb dynptrs are not invalidated when the
parent referenced object is freed.

Add parent_id to bpf_reg_state to precisely track child-parent
relationships. A child object's parent_id points to the parent object's
id. This replaces the PTR_TO_MEM-specific dynptr_id and does not
increase the size of bpf_reg_state on 64-bit machines as there is
existing padding.

When calling dynptr constructors (i.e., process_dynptr_func() with
MEM_UNINIT argument), track the parent's id if the parent is a
referenced object. This only applies to file dynptr and skb dynptr,
so only pass parent reg->id to kfunc constructors.

For release_reference(), invalidating an object now also invalidates
all descendants by traversing the object tree. This is done using
stack-based DFS to avoid recursive call chains of release_reference() ->
unmark_stack_slots_dynptr() -> release_reference(). Referenced objects
encountered during tree traversal cannot be indirectly released. They
require an explicit helper/kfunc call to release the acquired resources.

While the new design changes how object relationships are tracked in
the verifier, it does not change the verifier's behavior. Here is the
implication for dynptr, pointer casting, and owning/non-owning
references:

Dynptr:

When initializing a dynptr, referenced dynptrs acquire a reference for
ref_obj_id. If the dynptr has a referenced parent, parent_id tracks the
parent's id. When cloning, ref_obj_id and parent_id are copied from the
original. Releasing a referenced dynptr via release_reference(ref_obj_id)
invalidates all clones and derived slices. For non-referenced dynptrs,
only the specific dynptr and its children are invalidated.

Pointer casting:

Referenced socket pointers and their casted counterparts share the same
lifetime but have different nullness — they have different id but the
same ref_obj_id.

Owning to non-owning reference conversion:

After converting owning to non-owning by clearing ref_obj_id (e.g.,
object(id=1, ref_obj_id=1) -> object(id=1, ref_obj_id=0)), the
verifier only needs to release the reference state, so it calls
release_reference_nomark() instead of release_reference().

Note that the error message "reference has not been acquired before" in
the helper and kfunc release paths is removed. This message was already
unreachable. The verifier only calls release_reference() after
confirming meta.ref_obj_id is valid, so the condition could never
trigger in practice (no selftest exercises it either). With the
refactor, release_reference() can now be called with non-acquired ids
and have different error conditions. Report directly in
release_reference() instead.

Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h |  24 ++-
 kernel/bpf/log.c             |   8 +-
 kernel/bpf/states.c          |  10 +-
 kernel/bpf/verifier.c        | 305 +++++++++++++++++------------------
 4 files changed, 182 insertions(+), 165 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2cb4c7b0eab6..d83b9fbfef7f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -66,7 +66,6 @@ struct bpf_reg_state {
 
 		struct { /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
 			u32 mem_size;
-			u32 dynptr_id; /* for dynptr slices */
 		};
 
 		/* For dynptr stack slots */
@@ -188,6 +187,13 @@ struct bpf_reg_state {
 	 * allowed and has the same effect as bpf_sk_release(sk).
 	 */
 	u32 ref_obj_id;
+	/* Tracks the parent object this register was derived from.
+	 * Used for cascading invalidation: when the parent object is
+	 * released or invalidated, all registers with matching parent_id
+	 * are also invalidated. For example, a slice from bpf_dynptr_data()
+	 * gets parent_id set to the dynptr's id.
+	 */
+	u32 parent_id;
 	/* Inside the callee two registers can be both PTR_TO_STACK like
 	 * R1=fp-8 and R2=fp-8, but one of them points to this function stack
 	 * while another to the caller's stack. To differentiate them 'frameno'
@@ -585,7 +591,7 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame)
 	     iter < frame->out_stack_arg_cnt;                          \
 	     iter++, reg = bpf_get_spilled_stack_arg(iter, frame))
 
-#define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, __expr)   \
+#define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __stack, __mask, __expr)   \
 	({                                                               \
 		struct bpf_verifier_state *___vstate = __vst;            \
 		int ___i, ___j;                                          \
@@ -593,6 +599,7 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame)
 			struct bpf_reg_state *___regs;                   \
 			__state = ___vstate->frame[___i];                \
 			___regs = __state->regs;                         \
+			__stack = NULL;                                  \
 			for (___j = 0; ___j < MAX_BPF_REG; ___j++) {     \
 				__reg = &___regs[___j];                  \
 				(void)(__expr);                          \
@@ -600,19 +607,26 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame)
 			bpf_for_each_spilled_reg(___j, __state, __reg, __mask) { \
 				if (!__reg)                              \
 					continue;                        \
+				__stack = &__state->stack[___j];         \
 				(void)(__expr);                          \
 			}                                                \
 			bpf_for_each_spilled_stack_arg(___j, __state, __reg) { \
 				if (!__reg)                              \
 					continue;                        \
+				__stack = &__state->stack[___j];         \
 				(void)(__expr);                          \
 			}						 \
 		}                                                        \
 	})
 
 /* Invoke __expr over regsiters in __vst, setting __state and __reg */
-#define bpf_for_each_reg_in_vstate(__vst, __state, __reg, __expr) \
-	bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, 1 << STACK_SPILL, __expr)
+#define bpf_for_each_reg_in_vstate(__vst, __state, __reg, __expr)		\
+	({									\
+		struct bpf_stack_state * ___stack;                        	\
+		(void)___stack;							\
+		bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, ___stack,\
+						1 << STACK_SPILL, __expr);	\
+	})
 
 /* linked list of verifier states used to prune search */
 struct bpf_verifier_state_list {
@@ -1441,6 +1455,7 @@ struct bpf_dynptr_desc {
 	enum bpf_dynptr_type type;
 	u32 id;
 	u32 ref_obj_id;
+	u32 parent_id;
 };
 
 struct bpf_kfunc_call_arg_meta {
@@ -1452,6 +1467,7 @@ struct bpf_kfunc_call_arg_meta {
 	const char *func_name;
 	/* Out parameters */
 	u32 ref_obj_id;
+	u32 id;
 	u8 release_regno;
 	bool r0_rdonly;
 	u32 ret_btf_id;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 62fe6ed18374..a4e86cfc7ef9 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -667,6 +667,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose(env, "%+d", reg->delta);
 	if (reg->ref_obj_id)
 		verbose_a("ref_obj_id=%d", reg->ref_obj_id);
+	if (reg->parent_id)
+		verbose_a("parent_id=%d", reg->parent_id);
 	if (type_is_non_owning_ref(reg->type))
 		verbose_a("%s", "non_own_ref");
 	if (type_is_map_ptr(t)) {
@@ -769,9 +771,9 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 			if (reg->id)
 				verbose_a("id=%d", reg->id);
 			if (reg->ref_obj_id)
-				verbose_a("ref_id=%d", reg->ref_obj_id);
-			if (reg->dynptr_id)
-				verbose_a("dynptr_id=%d", reg->dynptr_id);
+				verbose_a("ref_obj_id=%d", reg->ref_obj_id);
+			if (reg->parent_id)
+				verbose_a("parent_id=%d", reg->parent_id);
 			verbose(env, ")");
 			break;
 		case STACK_ITER:
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 877338136009..6103c3bea620 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -489,7 +489,8 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 {
 	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 	       check_ids(rold->id, rcur->id, idmap) &&
-	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
+	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap) &&
+	       check_ids(rold->parent_id, rcur->parent_id, idmap);
 }
 
 enum exact_level {
@@ -614,7 +615,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		       range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off) &&
 		       check_ids(rold->id, rcur->id, idmap) &&
-		       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
+		       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap) &&
+		       check_ids(rold->parent_id, rcur->parent_id, idmap);
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET:
 		/* We must have at least as much range as the old ptr
@@ -794,7 +796,9 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			cur_reg = &cur->stack[spi].spilled_ptr;
 			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
 			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
-			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+			    !check_ids(old_reg->id, cur_reg->id, idmap) ||
+			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap) ||
+			    !check_ids(old_reg->parent_id, cur_reg->parent_id, idmap))
 				return false;
 			break;
 		case STACK_ITER:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 753681b0a987..89c219df6591 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -202,7 +202,7 @@ struct bpf_verifier_stack_elem {
 
 static int acquire_reference(struct bpf_verifier_env *env, int insn_idx);
 static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id);
-static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
+static int release_reference(struct bpf_verifier_env *env, int id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
@@ -242,6 +242,7 @@ struct bpf_call_arg_meta {
 	int mem_size;
 	u64 msize_max_value;
 	int ref_obj_id;
+	u32 id;
 	int func_id;
 	struct btf *btf;
 	u32 btf_id;
@@ -639,43 +640,42 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
 	}
 }
 
-static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
+static bool dynptr_type_referenced(enum bpf_dynptr_type type)
 {
 	return type == BPF_DYNPTR_TYPE_RINGBUF || type == BPF_DYNPTR_TYPE_FILE;
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg,
 			      enum bpf_dynptr_type type,
-			      bool first_slot, int dynptr_id);
+			      bool first_slot, int id, int ref_obj_id, int parent_id);
 
 
 static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *sreg1,
 				   struct bpf_reg_state *sreg2,
-				   enum bpf_dynptr_type type)
+				   enum bpf_dynptr_type type, int id, int ref_obj_id, int parent_id)
 {
-	int id = ++env->id_gen;
-
-	__mark_dynptr_reg(sreg1, type, true, id);
-	__mark_dynptr_reg(sreg2, type, false, id);
+	__mark_dynptr_reg(sreg1, type, true, id, ref_obj_id, parent_id);
+	__mark_dynptr_reg(sreg2, type, false, id, ref_obj_id, parent_id);
 }
 
 static void mark_dynptr_cb_reg(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg,
 			       enum bpf_dynptr_type type)
 {
-	__mark_dynptr_reg(reg, type, true, ++env->id_gen);
+	__mark_dynptr_reg(reg, type, true, ++env->id_gen, 0, 0);
 }
 
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi);
 
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				   enum bpf_arg_type arg_type, int insn_idx, int clone_ref_obj_id)
+				   enum bpf_arg_type arg_type, int insn_idx, int parent_id,
+				   struct bpf_dynptr_desc *dynptr)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
+	int spi, i, err, ref_obj_id = 0;
 	enum bpf_dynptr_type type;
-	int spi, i, err;
 
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
@@ -706,85 +706,54 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	if (type == BPF_DYNPTR_TYPE_INVALID)
 		return -EINVAL;
 
-	mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
-			       &state->stack[spi - 1].spilled_ptr, type);
-
-	if (dynptr_type_refcounted(type)) {
-		/* The id is used to track proper releasing */
-		int id;
-
-		if (clone_ref_obj_id)
-			id = clone_ref_obj_id;
-		else
-			id = acquire_reference(env, insn_idx);
-
-		if (id < 0)
-			return id;
-
-		state->stack[spi].spilled_ptr.ref_obj_id = id;
-		state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
+	if (dynptr->type == BPF_DYNPTR_TYPE_INVALID) { /* dynptr constructors */
+		if (dynptr_type_referenced(type)) {
+			ref_obj_id = acquire_reference(env, insn_idx);
+			if (ref_obj_id < 0)
+				return ref_obj_id;
+		}
+		/* Track parent's id if the parent is a referenced object */
+	} else { /* bpf_dynptr_clone() */
+		ref_obj_id = dynptr->ref_obj_id;
+		parent_id = dynptr->parent_id;
 	}
 
+	mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
+			       &state->stack[spi - 1].spilled_ptr, type, ++env->id_gen, ref_obj_id, parent_id);
+
 	return 0;
 }
 
-static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_state *state, int spi)
+static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_stack_state *stack)
 {
 	int i;
 
 	for (i = 0; i < BPF_REG_SIZE; i++) {
-		state->stack[spi].slot_type[i] = STACK_INVALID;
-		state->stack[spi - 1].slot_type[i] = STACK_INVALID;
+		stack[0].slot_type[i] = STACK_INVALID;
+		stack[1].slot_type[i] = STACK_INVALID;
 	}
 
-	bpf_mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
-	bpf_mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
+	bpf_mark_reg_not_init(env, &stack[0].spilled_ptr);
+	bpf_mark_reg_not_init(env, &stack[1].spilled_ptr);
 }
 
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi, ref_obj_id, i;
+	int spi;
 
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
 		return spi;
 
-	if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
-		invalidate_dynptr(env, state, spi);
-		return 0;
-	}
-
-	ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
-
-	/* If the dynptr has a ref_obj_id, then we need to invalidate
-	 * two things:
-	 *
-	 * 1) Any dynptrs with a matching ref_obj_id (clones)
-	 * 2) Any slices derived from this dynptr.
+	/*
+	 * For referenced dynptr, the clones share the same ref_obj_id and will be
+	 * invalidated too. For non-referenced dynptr, only the dynptr and slices
+	 * derived from it will be invalidated.
 	 */
-
-	/* Invalidate any slices associated with this dynptr */
-	WARN_ON_ONCE(release_reference(env, ref_obj_id));
-
-	/* Invalidate any dynptr clones */
-	for (i = 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-		if (state->stack[i].spilled_ptr.ref_obj_id != ref_obj_id)
-			continue;
-
-		/* it should always be the case that if the ref obj id
-		 * matches then the stack slot also belongs to a
-		 * dynptr
-		 */
-		if (state->stack[i].slot_type[0] != STACK_DYNPTR) {
-			verifier_bug(env, "misconfigured ref_obj_id");
-			return -EFAULT;
-		}
-		if (state->stack[i].spilled_ptr.dynptr.first_slot)
-			invalidate_dynptr(env, state, i);
-	}
-
-	return 0;
+	reg = &state->stack[spi].spilled_ptr;
+	return release_reference(env, dynptr_type_referenced(reg->dynptr.type) ?
+				      reg->ref_obj_id : reg->id);
 }
 
 static void __mark_reg_unknown(const struct bpf_verifier_env *env,
@@ -801,9 +770,7 @@ static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi)
 {
-	struct bpf_func_state *fstate;
-	struct bpf_reg_state *dreg;
-	int i, dynptr_id;
+	int i, err = 0;
 
 	/* We always ensure that STACK_DYNPTR is never set partially,
 	 * hence just checking for slot_type[0] is enough. This is
@@ -817,7 +784,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
 		spi = spi + 1;
 
-	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
+	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type)) {
 		int ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
 		int ref_cnt = 0;
 
@@ -839,34 +806,20 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 			verbose(env, "cannot overwrite referenced dynptr\n");
 			return -EINVAL;
 		}
-	}
 
-	mark_stack_slot_scratched(env, spi);
-	mark_stack_slot_scratched(env, spi - 1);
 
-	/* Writing partially to one dynptr stack slot destroys both. */
-	for (i = 0; i < BPF_REG_SIZE; i++) {
-		state->stack[spi].slot_type[i] = STACK_INVALID;
-		state->stack[spi - 1].slot_type[i] = STACK_INVALID;
+		invalidate_dynptr(env, &state->stack[spi - 1]);
+	} else {
+		/* Invalidate the dynptr and any derived slices */
+		err = release_reference(env, state->stack[spi].spilled_ptr.id);
 	}
 
-	dynptr_id = state->stack[spi].spilled_ptr.id;
-	/* Invalidate any slices associated with this dynptr */
-	bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
-		/* Dynptr slices are only PTR_TO_MEM_OR_NULL and PTR_TO_MEM */
-		if (dreg->type != (PTR_TO_MEM | PTR_MAYBE_NULL) && dreg->type != PTR_TO_MEM)
-			continue;
-		if (dreg->dynptr_id == dynptr_id)
-			mark_reg_invalid(env, dreg);
-	}));
-
-	/* Do not release reference state, we are destroying dynptr on stack,
-	 * not using some helper to release it. Just reset register.
-	 */
-	bpf_mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
-	bpf_mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
+	if (!err) {
+		mark_stack_slot_scratched(env, spi);
+		mark_stack_slot_scratched(env, spi - 1);
+	}
 
-	return 0;
+	return err;
 }
 
 static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
@@ -1514,15 +1467,15 @@ static void release_reference_state(struct bpf_verifier_state *state, int idx)
 	return;
 }
 
-static bool find_reference_state(struct bpf_verifier_state *state, int ptr_id)
+static struct bpf_reference_state *find_reference_state(struct bpf_verifier_state *state, int ptr_id)
 {
 	int i;
 
 	for (i = 0; i < state->acquired_refs; i++)
 		if (state->refs[i].id == ptr_id)
-			return true;
+			return &state->refs[i];
 
-	return false;
+	return NULL;
 }
 
 static int release_lock_state(struct bpf_verifier_state *state, int type, int id, void *ptr)
@@ -1839,6 +1792,7 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
 	reg->id = 0;
 	reg->ref_obj_id = 0;
+	reg->parent_id = 0;
 	___mark_reg_known(reg, imm);
 }
 
@@ -1873,7 +1827,7 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type type,
-			      bool first_slot, int dynptr_id)
+			      bool first_slot, int id, int ref_obj_id, int parent_id)
 {
 	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
 	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so simply
@@ -1882,7 +1836,9 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type ty
 	__mark_reg_known_zero(reg);
 	reg->type = CONST_PTR_TO_DYNPTR;
 	/* Give each dynptr a unique id to uniquely associate slices to it. */
-	reg->id = dynptr_id;
+	reg->id = id;
+	reg->ref_obj_id = ref_obj_id;
+	reg->parent_id = parent_id;
 	reg->dynptr.type = type;
 	reg->dynptr.first_slot = first_slot;
 }
@@ -2162,17 +2118,12 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 /* Mark a register as having a completely unknown (scalar) value. */
 void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
 {
-	/*
-	 * Clear type, off, and union(map_ptr, range) and
-	 * padding between 'type' and union
-	 */
-	memset(reg, 0, offsetof(struct bpf_reg_state, var_off));
+	s32 subreg_def = reg->subreg_def;
+
+	memset(reg, 0, sizeof(*reg));
 	reg->type = SCALAR_VALUE;
-	reg->id = 0;
-	reg->ref_obj_id = 0;
 	reg->var_off = tnum_unknown;
-	reg->frameno = 0;
-	reg->precise = false;
+	reg->subreg_def = subreg_def;
 	__mark_reg_unbounded(reg);
 }
 
@@ -7196,7 +7147,16 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
-/* There are two register types representing a bpf_dynptr, one is PTR_TO_STACK
+/*
+ * Validate dynptr arguments for helper, kfunc and subprog.
+ *
+ * @dynptr is both input and output. It is populated when the argument is
+ * tagged with MEM_UNINIT (i.e., the dynptr argument that will be constructed)
+ * and consumed when the argument is expecting to be an initialized dynptr.
+ * @parent_id is used to track the referenced parent object (e.g., file or skb in
+ * qdisc program) when constructing a dynptr.
+ *
+ * There are two register types representing a bpf_dynptr, one is PTR_TO_STACK
  * which points to a stack slot, and the other is CONST_PTR_TO_DYNPTR.
  *
  * In both cases we deal with the first 8 bytes, but need to mark the next 8
@@ -7212,7 +7172,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
  */
 static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			       argno_t argno, int insn_idx, enum bpf_arg_type arg_type,
-			       int clone_ref_obj_id, struct bpf_dynptr_desc *dynptr)
+			       int parent_id, struct bpf_dynptr_desc *dynptr)
 {
 	int spi, err = 0;
 
@@ -7253,7 +7213,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 				return err;
 		}
 
-		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, clone_ref_obj_id);
+		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, parent_id, dynptr);
 	} else /* OBJ_RELEASE and None case from above */ {
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) {
@@ -7296,6 +7256,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			dynptr->type = reg->dynptr.type;
 			dynptr->id = reg->id;
 			dynptr->ref_obj_id = reg->ref_obj_id;
+			dynptr->parent_id = reg->parent_id;
 		}
 	}
 	return err;
@@ -8255,7 +8216,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			 */
 			if (reg->type == PTR_TO_STACK) {
 				spi = dynptr_get_spi(env, reg);
-				if (spi < 0 || !state->stack[spi].spilled_ptr.ref_obj_id) {
+				if (spi < 0 || !state->stack[spi].spilled_ptr.id) {
 					verbose(env, "arg %d is an unacquired reference\n", regno);
 					return -EINVAL;
 				}
@@ -8283,6 +8244,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		meta->ref_obj_id = reg->ref_obj_id;
+		meta->id = reg->id;
 	}
 
 	switch (base_type(arg_type)) {
@@ -8908,26 +8870,76 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int ref_ob
 	return -EINVAL;
 }
 
-/* The pointer with the specified id has released its reference to kernel
- * resources. Identify all copies of the same pointer and clear the reference.
- *
- * This is the release function corresponding to acquire_reference(). Idempotent.
- */
-static int release_reference(struct bpf_verifier_env *env, int ref_obj_id)
+static int idstack_push(struct bpf_idmap *idmap, u32 id)
+{
+	int i;
+
+	if (!id)
+		return 0;
+
+	for (i = 0; i < idmap->cnt; i++)
+		if (idmap->map[i].old == id)
+			return 0;
+
+	if (WARN_ON_ONCE(idmap->cnt >= BPF_ID_MAP_SIZE))
+		return -EFAULT;
+
+	idmap->map[idmap->cnt++].old = id;
+	return 0;
+}
+
+static int idstack_pop(struct bpf_idmap *idmap)
 {
+	if (!idmap->cnt)
+		return 0;
+
+	return idmap->map[--idmap->cnt].old;
+}
+
+/* Release id and objects referencing the id iteratively in a DFS manner */
+static int release_reference(struct bpf_verifier_env *env, int id)
+{
+	u32 mask = (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
 	struct bpf_verifier_state *vstate = env->cur_state;
+	struct bpf_idmap *idstack = &env->idmap_scratch;
+	struct bpf_stack_state *stack;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
-	int err;
+	int root_id = id, err;
 
-	err = release_reference_nomark(vstate, ref_obj_id);
-	if (err)
-		return err;
+	idstack->cnt = 0;
+	idstack_push(idstack, id);
 
-	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->ref_obj_id == ref_obj_id)
-			mark_reg_invalid(env, reg);
-	}));
+	if (find_reference_state(vstate, id))
+		WARN_ON_ONCE(release_reference_nomark(vstate, id));
+
+	while ((id = idstack_pop(idstack))) {
+		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
+			if (reg->id != id && reg->parent_id != id && reg->ref_obj_id != id)
+				continue;
+
+			if (reg->ref_obj_id && reg->ref_obj_id != root_id) {
+				struct bpf_reference_state *ref_state;
+
+				ref_state = find_reference_state(env->cur_state, reg->ref_obj_id);
+				verbose(env, "Leaking reference id=%d alloc_insn=%d. Release it first.\n",
+					ref_state->id, ref_state->insn_idx);
+				return -EINVAL;
+			}
+
+			/* Free objects derived from the current object */
+			if (reg->id != id) {
+				err = idstack_push(idstack, reg->id);
+				if (err)
+					return err;
+			}
+
+			if (!stack || stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL)
+				mark_reg_invalid(env, reg);
+			else if (stack->slot_type[BPF_REG_SIZE - 1] == STACK_DYNPTR)
+				invalidate_dynptr(env, stack);
+		}));
+	}
 
 	return 0;
 }
@@ -10125,11 +10137,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			 */
 			err = 0;
 		}
-		if (err) {
-			verbose(env, "func %s#%d reference has not been acquired before\n",
-				func_id_name(func_id), func_id);
+		if (err)
 			return err;
-		}
 	}
 
 	switch (func_id) {
@@ -10408,10 +10417,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].ref_obj_id = id;
 	}
 
-	if (func_id == BPF_FUNC_dynptr_data) {
-		regs[BPF_REG_0].dynptr_id = meta.dynptr.id;
-		regs[BPF_REG_0].ref_obj_id = meta.dynptr.ref_obj_id;
-	}
+	if (func_id == BPF_FUNC_dynptr_data)
+		regs[BPF_REG_0].parent_id = meta.dynptr.id;
 
 	err = do_refine_retval_range(env, regs, fn->ret_type, func_id, &meta);
 	if (err)
@@ -11869,6 +11876,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EFAULT;
 			}
 			meta->ref_obj_id = reg->ref_obj_id;
+			meta->id = reg->id;
 			if (is_kfunc_release(meta)) {
 				if (regno < 0) {
 					verbose(env, "%s release arg cannot be a stack argument\n",
@@ -12018,7 +12026,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_DYNPTR:
 		{
 			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
-			int clone_ref_obj_id = 0;
 
 			if (is_kfunc_arg_uninit(btf, &args[i]))
 				dynptr_arg_type |= MEM_UNINIT;
@@ -12049,15 +12056,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				}
 
 				dynptr_arg_type |= (unsigned int)get_dynptr_type_flag(parent_type);
-				clone_ref_obj_id = meta->dynptr.ref_obj_id;
-				if (dynptr_type_refcounted(parent_type) && !clone_ref_obj_id) {
-					verifier_bug(env, "missing ref obj id for parent of clone");
-					return -EFAULT;
-				}
 			}
 
 			ret = process_dynptr_func(env, reg, argno, insn_idx, dynptr_arg_type,
-						  clone_ref_obj_id, &meta->dynptr);
+						  meta->ref_obj_id ? meta->id : 0, &meta->dynptr);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12710,12 +12712,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 			verifier_bug(env, "no dynptr id");
 			return -EFAULT;
 		}
-		regs[BPF_REG_0].dynptr_id = meta->dynptr.id;
-
-		/* we don't need to set BPF_REG_0's ref obj id
-		 * because packet slices are not refcounted (see
-		 * dynptr_type_refcounted)
-		 */
+		regs[BPF_REG_0].parent_id = meta->dynptr.id;
 	} else {
 		return 0;
 	}
@@ -12850,6 +12847,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (rcu_lock) {
 		env->cur_state->active_rcu_locks++;
 	} else if (rcu_unlock) {
+		struct bpf_stack_state *stack;
 		struct bpf_func_state *state;
 		struct bpf_reg_state *reg;
 		u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
@@ -12859,7 +12857,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 		if (--env->cur_state->active_rcu_locks == 0) {
-			bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_mask, ({
+			bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, clear_mask, ({
 				if (reg->type & MEM_RCU) {
 					reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
 					reg->type |= PTR_UNTRUSTED;
@@ -12902,9 +12900,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			err = unmark_stack_slots_dynptr(env, reg);
 		} else {
 			err = release_reference(env, reg->ref_obj_id);
-			if (err)
-				verbose(env, "kfunc %s#%d reference has not been acquired before\n",
-					func_name, meta.func_id);
 		}
 		if (err)
 			return err;
@@ -12921,7 +12916,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 		}
 
-		err = release_reference(env, release_ref_obj_id);
+		err = release_reference_nomark(env->cur_state, release_ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 				func_name, meta.func_id);
@@ -13012,7 +13007,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 			/* Ensures we don't access the memory after a release_reference() */
 			if (meta.ref_obj_id)
-				regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
+				regs[BPF_REG_0].parent_id = meta.ref_obj_id;
 
 			if (is_kfunc_rcu_protected(&meta))
 				regs[BPF_REG_0].type |= MEM_RCU;
@@ -18250,7 +18245,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				mark_reg_unknown(env, regs, i);
 			} else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
 				/* assume unspecial LOCAL dynptr type */
-				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen);
+				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen, 0, 0);
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
 				reg->type = PTR_TO_MEM;
 				reg->type |= arg->arg_type &
-- 
2.53.0-Meta


