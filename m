Return-Path: <netdev+bounces-256015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPMhDqgbgWm0EAMAu9opvQ
	(envelope-from <netdev+bounces-256015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 22:48:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB96D1CAD
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 22:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D123015C9B
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 21:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA36831062D;
	Mon,  2 Feb 2026 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVve2JIn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2158B3009DA
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068900; cv=none; b=cTzSvLF+0LBuf8IOqP7IG7H4kJIbJaKI9oavZca1aopA/e/vY9LJnuU7LsdZyjJnJuBleUiz1cNQjbKSC1xAtUaKp2vWoWMyaqnCBX2X2lqdthEi4PyznMCoZ5ppr6UcShD8RjkRV7SIRj5yDctiHJ5FrzoS27BeQxOVpvoaMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068900; c=relaxed/simple;
	bh=StdSAzH65ZY1dquY3E1BvusTTTE0QoYRwY5Q8/IwIXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfCxSapaLrCt9OWE7BjRhPmzOSf6h5dAJWdAaX3tsT87J22GdCs5f6r7k2ODhnSAWO5Mo26rhW1/CA0MZTUB9gMNihrrNo/NJGprNQIhhziWgbqpZ9kM75s7ccwIwjrlGoxm/0hwkJlSwrAxoH1W4bgjjSUYOt1hiFF4Xoqj2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVve2JIn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-823c56765fdso1450559b3a.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 13:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770068898; x=1770673698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l93PSiyqraBCCV2RZN/CwLC26vrK1Fkxue2Ff3mkLn8=;
        b=fVve2JInw4JnqLQEdCsiepTqsy5jKEr8uNSKyyCUUoC6v3YehvBTgOywqVTWXWphIR
         tm26NTNYc4RwpqOHAEIiTiG/ld+2O0swrYxEnU9rmfDh1fdforbJzjxc/NxgJgFFvdPi
         kV78QkXNep0Vx8DNXW+vvwRUMpHisIatp0jdMirLjpS9EMJwuNkdQ4DJnTKPX2+RmFkc
         gLPTxaLmQDB9LBFZC0yqGShnmZ9N29XfPLu+pmC9TBT+FoKQ/bWpHIQ6T4LNC9nkJ+g1
         Ewo/DIkaNAcnm/Af7GPniCj7CsroSQ7aABjDzwD2yLGDv4Bk+ugJAk1jpLRGEDLcKgzc
         uWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770068898; x=1770673698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l93PSiyqraBCCV2RZN/CwLC26vrK1Fkxue2Ff3mkLn8=;
        b=kyxILNtz8QZLyjyFp3UHnMxd3Hvqw/1RHvoH6lQLKwpFsckF8QYIUj6HHIKs3NU/fh
         5UKoKOFUsCUodW3PaLlMQJEBWsxeLcQX0HWc1Wgw4m6WtYj2JR2S2Mnk4hBPZlqWK6Qk
         1fjdK5y3k9OBXiQMFp5Eku1dvCjAaqBl2EJVqMR2makhXqSUI+tBfqtGIPDcclfDOa95
         MyeY0hG6vA11iz1of1gMYAeJnkt5WxaZ9eMJZji18X0Lm1lFLdgjcwNXHUsHqNR/NTVT
         hFnC2NaRcHRcwCyCcKMeH+hrEh5IZHmY/GGpGJUM9fvsGb1tO9QybCuoWW6ZYznIpAHx
         24/Q==
X-Gm-Message-State: AOJu0YxQVPqCB0Qa28oYvnuHHea1SacLvC9VVWUFP/Rz6PVEn0+ALes6
	Uqki0L+19pS0khhEUkumJygMiUEY7J29oyLV2Xy6ntM4Ibbh04SIqIOk
X-Gm-Gg: AZuq6aKCct1/VhT5syDQuDNMP2AMe/G8BlA1h2LfCx+x2p4hMsogcTRSrrVvAWiuyt6
	76YH8n/fC5wEN53qkbT9B6cvR2v4x52JNEE4v+OuZ/QR0typniy+0pfoAnOcj+M8tNg2t0RI+IU
	7YqxCIgWoThR5B5KY0h66QlB2MACnPxwjB1fgCemFChyq42SZdkOwj+vSDlVuM6Y/xUM+waw7u+
	xPtRpfWqqYtd6lMgAMgt6/m0FCXp3C7PJ9ZM9Hv0ypZSTfbc7UlPY6Uv+UBGkcCzqNTQ2ewjj5N
	DzjgllTEZSvgJnX2tddr56mBtEoD2Wgc5H804h67ffCe2uyfcqVV1UyWsrQzCSRKqVZ8mqtikVx
	ftT4D0KXo3yhixICPOzX+bA1+legET0/Mrqlum589zQ46Tqx5N1JCwwiZDmW2V8wYJ33bhiSpL0
	BFOPTxhxR/E8gS
X-Received: by 2002:a05:6a00:92a3:b0:81c:9f57:3090 with SMTP id d2e1a72fcca58-823aa6ae8c8mr13608370b3a.24.1770068898228;
        Mon, 02 Feb 2026 13:48:18 -0800 (PST)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b48531sm16011264b3a.16.2026.02.02.13.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 13:48:17 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 1/4] bpf: Fix and refactor object relationship tracking
Date: Mon,  2 Feb 2026 13:48:14 -0800
Message-ID: <20260202214817.2853236-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-256015-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.id:url]
X-Rspamd-Queue-Id: 8DB96D1CAD
X-Rspamd-Action: no action

This patch (1) fixes the missing link between dynptr and the parent
referenced object and (2) simplifies the object relationship tracking
to allow building more complex object relationship in the future.

This patch makes dynptr tracks its parent object. After bpf qdisc is
introduced, it is now possible for an skb to be freed in a qdisc program.
However, since there is no link between the skb dynptr and the skb, the
dynptr will not be invalidated after the skb is freed, resulting in
use after free.

In addition, also take the chance to refactor object relationship
tracking. Currently ref_obj_id of an object will share the same
ref_obj_id of the object it is referencing. For dynptr slice, a separate
dynptr_id is used to track its parent.

This design works for now, but after adding link between skb and dynptr,
it becomes problematic. It cannot correctly handle the removal of some
nodes in the object relationship tree. For example, if dynptr a is
destroyed by overwriting the stack slot, release_reference(1) would be
called and all nodes will be removed. The correct handling should leave
skb, dynptr c, and slice d intact. This is not a problem before since
dynptr created from skb has ref_obj_id = 0.

In the future if we start allowing creating dynptr from slice, the current
design also cannot correctly handle the removal of dynptr e. Again, all
nodes will be removed instead of childrens of dynptr e.

Before: object (id,ref_obj_id,dynptr_id)

                      skb (1,1,0)
                             ^ (Link added in this patch)
                             +-------------------------------+
                             |           bpf_dynptr_clone    |
                 dynptr a (2,1,0)                dynptr c (4,1,0)
                           ^                               ^
        bpf_dynptr_slice   |                               |
                           |                               |
              slice b (3,1,2)                 slice d (5,1,4)
                         ^
    bpf_dynptr_from_mem  |
    (NOT allowed yet)    |
             dynptr e (6,1,0)

The new design removes dynptr_id and use ref_obj_id to track the id
of the parent object instead of sharing the ref_obj_id of the root.
For release_reference(), this means ref_obj_id argument now can aslo
contains id not acquired through acquire_reference(). Add an argument
"acquired_ref" to indicate this. If true, there is no need to call
release_reference_nomark(). In addition, when iterating the register
state, when a reg->ref_obj_id matches the to be released ref_obj_id,
other objects referencing reg->id also needs to be released. Finally,
since dynptrs reside on the stack, release_reference() will also need
to scan stack slots.

After: object (id,ref_obj_id)

Qdisc:
                        skb (1,1)
                             ^
        bpf_dynptr_from_skb  +-------------------------------+
                             |           bpf_dynptr_clone    |
                 dynptr a (2,1)                  dynptr c (4,1)
                           ^                               ^
        bpf_dynptr_slice   |                               |
                           |                               |
                slice b (3,2)                   slice d (5,4)
                         ^
    bpf_dynptr_from_mem  |
    (NOT allowed yet)    |
             dynptr e (6,3)

Referenced dynptr:

     bpf_dynptr_from_file  +---------------------------------+
                           |           bpf_dynptr_clone      |
                 dynptr a (1,1)                  dynptr c (2,1)

Other non-referenced dynptr

      bpf_dynptr_from_skb  +---------------------------------+
                           |           bpf_dynptr_clone      |
                 dynptr a (1,0)                  dynptr c (2,1)

While this change introduces a potential circular call chain of
release_reference() -> __unmark_stack_slots_dynptr(), we currently do
not allow creating dynptr from slice so the depth of the tree will be
capped at three. In the future when this is allowed, the recursion
depth will still be bounded as the number of slices is limited by the
number registers. Besides, mark_ptr_or_null_reg() also needs to preserve
reg->id of slices.

Note that the new design does not support intermediate nodes to acquire
reference. If this is needed in the future, we might need to separate
ref_obj_id into ref_obj_id and parent_id to handle it.

CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
Signed-off-by: Amery Hung <ameryhung@gmail.com>

---

This refactor is based on Kumar work in [0]

[0] https://lore.kernel.org/bpf/20250414161443.1146103-2-memxor@gmail.com/
---
 include/linux/bpf_verifier.h |   1 -
 kernel/bpf/log.c             |   2 -
 kernel/bpf/verifier.c        | 173 ++++++++++++++++-------------------
 3 files changed, 81 insertions(+), 95 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 8355b585cd18..0cb14648a269 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -66,7 +66,6 @@ struct bpf_reg_state {
 
 		struct { /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
 			u32 mem_size;
-			u32 dynptr_id; /* for dynptr slices */
 		};
 
 		/* For dynptr stack slots */
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index a0c3b35de2ce..8851adfdb581 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -808,8 +808,6 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 				verbose_a("id=%d", reg->id);
 			if (reg->ref_obj_id)
 				verbose_a("ref_id=%d", reg->ref_obj_id);
-			if (reg->dynptr_id)
-				verbose_a("dynptr_id=%d", reg->dynptr_id);
 			verbose(env, ")");
 			break;
 		case STACK_ITER:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6b62b6d57175..a357e0305139 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -204,7 +204,7 @@ struct bpf_verifier_stack_elem {
 
 static int acquire_reference(struct bpf_verifier_env *env, int insn_idx);
 static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id);
-static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
+static int release_reference(struct bpf_verifier_env *env, int ref_obj_id, bool acquired_ref);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
@@ -287,7 +287,7 @@ struct bpf_call_arg_meta {
 	int mem_size;
 	u64 msize_max_value;
 	int ref_obj_id;
-	int dynptr_id;
+	int id;
 	int func_id;
 	struct btf *btf;
 	u32 btf_id;
@@ -733,7 +733,7 @@ static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg,
 			      enum bpf_dynptr_type type,
-			      bool first_slot, int dynptr_id);
+			      bool first_slot, int id);
 
 static void __mark_reg_not_init(const struct bpf_verifier_env *env,
 				struct bpf_reg_state *reg);
@@ -764,7 +764,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 {
 	struct bpf_func_state *state = func(env, reg);
 	enum bpf_dynptr_type type;
-	int spi, i, err;
+	int spi, i, err, id;
 
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
@@ -798,22 +798,17 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
 			       &state->stack[spi - 1].spilled_ptr, type);
 
-	if (dynptr_type_refcounted(type)) {
-		/* The id is used to track proper releasing */
-		int id;
-
-		if (clone_ref_obj_id)
-			id = clone_ref_obj_id;
-		else
-			id = acquire_reference(env, insn_idx);
+	id = clone_ref_obj_id;
 
+	if (dynptr_type_refcounted(type) && !clone_ref_obj_id) {
+		id = acquire_reference(env, insn_idx);
 		if (id < 0)
 			return id;
-
-		state->stack[spi].spilled_ptr.ref_obj_id = id;
-		state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
 	}
 
+	state->stack[spi].spilled_ptr.ref_obj_id = id;
+	state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
+
 	bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi));
 
 	return 0;
@@ -834,10 +829,30 @@ static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_stat
 	bpf_mark_stack_write(env, state->frameno, BIT(spi - 1) | BIT(spi));
 }
 
+static void __unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_func_state *state,
+					int spi)
+{
+	enum bpf_dynptr_type type;
+	int id, ref_obj_id;
+
+	id = state->stack[spi].spilled_ptr.id;
+	ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
+	type = state->stack[spi].spilled_ptr.dynptr.type;
+
+	invalidate_dynptr(env, state, spi);
+
+	/* Release the reference acquired on the dynptr */
+	if (dynptr_type_refcounted(type))
+		WARN_ON_ONCE(release_reference(env, ref_obj_id, true));
+
+	/* Invalidate any slices associated with this dynptr */
+	WARN_ON_ONCE(release_reference(env, id, false));
+}
+
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, ref_obj_id, i;
+	int spi;
 
 	/*
 	 * This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
@@ -848,44 +863,12 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 		verifier_bug(env, "CONST_PTR_TO_DYNPTR cannot be released");
 		return -EFAULT;
 	}
+
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
-	 */
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
+	__unmark_stack_slots_dynptr(env, state, spi);
 	return 0;
 }
 
@@ -905,7 +888,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 {
 	struct bpf_func_state *fstate;
 	struct bpf_reg_state *dreg;
-	int i, dynptr_id;
+	int i, id;
 
 	/* We always ensure that STACK_DYNPTR is never set partially,
 	 * hence just checking for slot_type[0] is enough. This is
@@ -933,13 +916,13 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 		state->stack[spi - 1].slot_type[i] = STACK_INVALID;
 	}
 
-	dynptr_id = state->stack[spi].spilled_ptr.id;
+	id = state->stack[spi].spilled_ptr.id;
 	/* Invalidate any slices associated with this dynptr */
 	bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
 		/* Dynptr slices are only PTR_TO_MEM_OR_NULL and PTR_TO_MEM */
 		if (dreg->type != (PTR_TO_MEM | PTR_MAYBE_NULL) && dreg->type != PTR_TO_MEM)
 			continue;
-		if (dreg->dynptr_id == dynptr_id)
+		if (dreg->ref_obj_id == id)
 			mark_reg_invalid(env, dreg);
 	}));
 
@@ -1098,7 +1081,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
 		if (i == 0)
-			WARN_ON_ONCE(release_reference(env, st->ref_obj_id));
+			WARN_ON_ONCE(release_reference(env, st->ref_obj_id, true));
 
 		__mark_reg_not_init(env, st);
 
@@ -2235,7 +2218,7 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type type,
-			      bool first_slot, int dynptr_id)
+			      bool first_slot, int id)
 {
 	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
 	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so simply
@@ -2244,7 +2227,7 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type ty
 	__mark_reg_known_zero(reg);
 	reg->type = CONST_PTR_TO_DYNPTR;
 	/* Give each dynptr a unique id to uniquely associate slices to it. */
-	reg->id = dynptr_id;
+	reg->id = id;
 	reg->dynptr.type = type;
 	reg->dynptr.first_slot = first_slot;
 }
@@ -10481,22 +10464,43 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int ref_ob
  *
  * This is the release function corresponding to acquire_reference(). Idempotent.
  */
-static int release_reference(struct bpf_verifier_env *env, int ref_obj_id)
+static int release_reference(struct bpf_verifier_env *env, int ref_obj_id, bool acquired_ref)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
-	int err;
+	int err, spi;
 
-	err = release_reference_nomark(vstate, ref_obj_id);
-	if (err)
-		return err;
+	if (acquired_ref) {
+		err = release_reference_nomark(vstate, ref_obj_id);
+		if (err)
+			return err;
+	}
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->ref_obj_id == ref_obj_id)
+		if (reg->ref_obj_id == ref_obj_id) {
 			mark_reg_invalid(env, reg);
+			if (reg->id && reg->id != ref_obj_id) {
+				err = release_reference(env, reg->id, false);
+				if (err)
+					return err;
+			}
+		}
 	}));
 
+	bpf_for_each_spilled_reg(spi, state, reg, (1 << STACK_DYNPTR)) {
+		if (!reg || !reg->dynptr.first_slot)
+			continue;
+		if (reg->ref_obj_id == ref_obj_id) {
+			__unmark_stack_slots_dynptr(env, state, spi);
+			if (reg->id && reg->id != ref_obj_id) {
+				err = release_reference(env, reg->id, false);
+				if (err)
+					return err;
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -11673,7 +11677,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				}));
 			}
 		} else if (meta.ref_obj_id) {
-			err = release_reference(env, meta.ref_obj_id);
+			err = release_reference(env, meta.ref_obj_id, true);
 		} else if (register_is_null(&regs[meta.release_regno])) {
 			/* meta.ref_obj_id can only be 0 if register that is meant to be
 			 * released is NULL, which must be > R0.
@@ -11757,19 +11761,14 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	case BPF_FUNC_dynptr_data:
 	{
 		struct bpf_reg_state *reg;
-		int id, ref_obj_id;
+		int id;
 
 		reg = get_dynptr_arg_reg(env, fn, regs);
 		if (!reg)
 			return -EFAULT;
 
-
-		if (meta.dynptr_id) {
-			verifier_bug(env, "meta.dynptr_id already set");
-			return -EFAULT;
-		}
-		if (meta.ref_obj_id) {
-			verifier_bug(env, "meta.ref_obj_id already set");
+		if (meta.id) {
+			verifier_bug(env, "meta.id already set");
 			return -EFAULT;
 		}
 
@@ -11779,14 +11778,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return id;
 		}
 
-		ref_obj_id = dynptr_ref_obj_id(env, reg);
-		if (ref_obj_id < 0) {
-			verifier_bug(env, "failed to obtain dynptr ref_obj_id");
-			return ref_obj_id;
-		}
-
-		meta.dynptr_id = id;
-		meta.ref_obj_id = ref_obj_id;
+		meta.id = id;
 
 		break;
 	}
@@ -11990,10 +11982,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EFAULT;
 	}
 
-	if (is_dynptr_ref_function(func_id))
-		regs[BPF_REG_0].dynptr_id = meta.dynptr_id;
-
-	if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_id)) {
+	if (is_dynptr_ref_function(func_id)) {
+		regs[BPF_REG_0].ref_obj_id = meta.id;
+	} else if (is_ptr_cast_function(func_id)) {
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
@@ -13328,7 +13319,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		}
 
 		if (reg->ref_obj_id) {
-			if (is_kfunc_release(meta) && meta->ref_obj_id) {
+			if (meta->ref_obj_id &&
+			    (is_kfunc_release(meta) ||
+			     meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb])) {
 				verifier_bug(env, "more than one arg with ref_obj_id R%d %u %u",
 					     regno, reg->ref_obj_id,
 					     meta->ref_obj_id);
@@ -13478,6 +13471,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
+				clone_ref_obj_id = meta->ref_obj_id;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
 			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
@@ -13955,12 +13949,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 			verifier_bug(env, "no dynptr id");
 			return -EFAULT;
 		}
-		regs[BPF_REG_0].dynptr_id = meta->initialized_dynptr.id;
-
-		/* we don't need to set BPF_REG_0's ref obj id
-		 * because packet slices are not refcounted (see
-		 * dynptr_type_refcounted)
-		 */
+		regs[BPF_REG_0].ref_obj_id = meta->initialized_dynptr.id;
 	} else {
 		return 0;
 	}
@@ -14154,7 +14143,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		if (meta.initialized_dynptr.ref_obj_id) {
 			err = unmark_stack_slots_dynptr(env, reg);
 		} else {
-			err = release_reference(env, reg->ref_obj_id);
+			err = release_reference(env, reg->ref_obj_id, true);
 			if (err)
 				verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 					func_name, meta.func_id);
@@ -14176,7 +14165,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 		}
 
-		err = release_reference(env, release_ref_obj_id);
+		err = release_reference(env, release_ref_obj_id, true);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
 				func_name, meta.func_id);
-- 
2.47.3


