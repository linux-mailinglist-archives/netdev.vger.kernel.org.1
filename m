Return-Path: <netdev+bounces-292938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHb8A8zwGGqrpAgAu9opvQ
	(envelope-from <netdev+bounces-292938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:50:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523D5FC1E2
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0704F3040480
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BE436492D;
	Fri, 29 May 2026 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJz8X5OH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4CE35E922
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019391; cv=none; b=W1dwmaMu1SJVdjCJe36HAEJr6m69dW1ivnL7FE0JO0ZZyzaxJupKKzk2DtHXsAxTaTxnM2Q6IUWTW0OsYTTazVap9PEMpdU1zfASaIIURqo5n4Bzg6SEEzV1tJP4iAG5EdqFXSw729HntpXtvmj90t5hCBB+jkkhYS/QxeWGh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019391; c=relaxed/simple;
	bh=BMj1Gh5dRO73t6lygmbJOmaQBjyxu2Yg11Gh6E5giw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOtegKX+wwrrbYyXEtWPkJU13/4YdtTYAOfxyGQZT0lAT1qMr/L1Cva4ymlxFsZAn2fjfBDIXxOphHfpLZbkI9cfk0++KnHw9kv6La0YQaXTxcMJeL3GeIr3bf3JWwSIpGTSnpncips6YzptY2V0q5d2acWhUu47ODEECE5KAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJz8X5OH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so497918a91.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019385; x=1780624185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFR45kKRIQzf//RPSHvzw/ArKAdxxoo9BIrQ7S7KLYo=;
        b=eJz8X5OHV5dk/VqTCjZzrWkg4HopeaK62ndL6N5g2vVIkdmDFulxoEBm4oSeQdHcNi
         dPNc5Cv1QV2IFQmKchAFtlnHbJX4YArpKiXBS7af/nJzBefLWUyUYJyun9tk8uuPp6xt
         VCd2IsIw8gdcifydctWb87N2W2sPNRNfl/mrKx09RLXqDk7WZclyAfWRcaCoWipJwPJz
         Ij7EAnxsiB9yAOWXOS0G14a61SEky7i7Qm05NkYi7b/AD8Fooc0tcMpu1TjrDZXjKa9K
         ge7n9ropiuvtocFqgqNIXlKId1O62un56LgT9cLnyuPOijFb8OaZedDOVxxs6ubpGzJ0
         Ug8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019385; x=1780624185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFR45kKRIQzf//RPSHvzw/ArKAdxxoo9BIrQ7S7KLYo=;
        b=Ks/b5eKDrybjtHrTa3GTJgGzcrWwvxj5EcGqDtGvTt/XbAezZCWyuGxRzSgsZubpU2
         AyQDJLXd+oZ0RopRQYgIxQGxYE5DOezdLvuX42Ko9Cq6ayMXMe1NliMvwRlu4Idhigds
         thIbh0BEoGMdQQSCDh5sV8LQTLFuzBLSHlQ/a71q55AW8wUzal8ppCfC3knzTxK/nFRW
         g3ceJ2g2X7uwAlrBXzhVi05hoLY3/kViUjuEAKFXBwtBB0sFaGF5pEfXnCaBKdklBPcq
         tKuy8SRseWLbXiOL0Ou7eGrAVQRIH7ayOKyq1LBVX0IIxffaltknlsiZzI/iZytd0ogp
         5mng==
X-Gm-Message-State: AOJu0YxFhSdFSTa5xgFZZW+QLgk//qU9IKLCQLm6IV3Ig95gUdv2UT7c
	TMyJiHnNT/IeQesPAREoR3nXZWpxiXf3E9RtnxKBJRg7yXOYMk4lDHqZ
X-Gm-Gg: Acq92OH2OPx/M93RuQDayBhU37Gc0Z9Dg8SetiszH3mBHCOAgh84OVCvdyOVg3PNOqs
	t20zhGELf6vCQw/VNrgpmFY6JhcNsEHWVfTeRsRBgPsklDcW/qCBizjpMn7057YWqXwh2Whcs5a
	xsZKFZqx8isOkokmzZLypGYTVfXhRIfks4zmiDGpb7BFjhpMzQovJgEkuQrtuKAtjLNorly9Qlr
	TGXH8frqqJQF0883gtymAySp2O/gNxPvz5CvG5LSkP+KUOrxKBT3We3zOY5NQUc2UXhSHP+7O//
	p9qjUiTkbj59Xp6m4o/3wUxAFju2glPtCC5fln+JEOUbrhUrYuXjTaudFkJyjRnLYbeifaMEfJi
	K2RG713lub0anzZgzChG6WdY69LYocq0maxYulAfx42ZZWFwYuAEIpnBuTN4XuBGHgr9IdQ+uZV
	GSoSYa9/3udLvKd1/z/+jbAWwE
X-Received: by 2002:a17:90b:3d4b:b0:36a:4074:9aa6 with SMTP id 98e67ed59e1d1-36bbcad6365mr1245420a91.6.1780019385205;
        Thu, 28 May 2026 18:49:45 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc02b8b57sm329545a91.7.2026.05.28.18.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 05/13] bpf: Refactor object relationship tracking and fix dynptr UAF bug
Date: Thu, 28 May 2026 18:49:28 -0700
Message-ID: <20260529014936.2811085-6-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292938-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,meta.id:url,dynptr.id:url]
X-Rspamd-Queue-Id: 9523D5FC1E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor object relationship tracking in the verifier and fix a dynptr
use-after-free bug where file/skb dynptrs are not invalidated when the
parent referenced object is freed.

Add parent_id to bpf_reg_state to precisely track child-parent
relationships. A child object's parent_id points to the parent object's
id. This replaces the PTR_TO_MEM-specific dynptr_id.

Remove ref_obj_id from bpf_reg_state by folding its role into the
existing id field. Previously, id tracked pointer identity for null
checking while ref_obj_id tracked the owning reference for lifetime
management. These are now unified: acquire helpers and kfuncs set id
to the acquired reference id, and release paths use id directly.

Add reg_is_referenced() which checks if a register is referenced by
looking up its id in the reference array. This replaces all former
ref_obj_id checks.

For release_reference(), invalidating an object now also invalidates
all descendants by traversing the object tree. This is done using
stack-based DFS to avoid recursive call chains of release_reference() ->
unmark_stack_slots_dynptr() -> release_reference(). Referenced objects
encountered during tree traversal are reported as leaked references.

Add parent_id to bpf_reference_state to enable hierarchical reference
tracking. When acquiring a reference, a parent_id can be specified to
link the new reference to an existing one (e.g., referenced dynptrs
acquire a reference with parent_id linking to the parent object's
reference).

Pointer casting:

For pointer casting helpers (bpf_sk_fullsock, bpf_tcp_sock), instead of
propagating ref_obj_id, the cast result reuses the same reference id as
the source pointer. Since the cast may return NULL for a non-NULL input,
the NULL case is explored as a separate verifier branch. This allows
releasing any of the original or cast pointers to invalidate all others.

Referenced dynptrs:

When constructing a referenced dynptr, acquire a intermediate reference
with parent_id linking to the parent referenced object. The dynptr and
all clones share the same parent_id (pointing to the intermediate ref)
but get unique ids for independent slice tracking. Releasing a
referenced dynptr releases the parent reference, which in turn
invalidates all clones and their derived slices.

Owning to non-owning reference conversion:

After converting owning to non-owning by clearing id (e.g.,
object(id=1) -> object(id=0)), the verifier releases the reference
state via release_reference_nomark().

Note that the error message "reference has not been acquired before" in
the helper and kfunc release paths is removed. This message was already
unreachable. The verifier only calls release_reference() after
confirming the reference is valid, so the condition could never trigger
in practice.

Fixes: 870c28588afa ("bpf: net_sched: Add basic bpf qdisc kfuncs")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h                           |   4 +-
 include/linux/bpf_verifier.h                  |  77 +--
 kernel/bpf/btf.c                              |   2 +-
 kernel/bpf/fixups.c                           |   2 +-
 kernel/bpf/log.c                              |  18 +-
 kernel/bpf/states.c                           |  11 +-
 kernel/bpf/verifier.c                         | 560 +++++++++---------
 .../selftests/bpf/prog_tests/spin_lock.c      |   4 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   4 +-
 .../selftests/bpf/progs/iters_state_safety.c  |   4 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |  12 +-
 11 files changed, 338 insertions(+), 360 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1c6863ce89e0..d1a17c118316 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1062,7 +1062,7 @@ struct bpf_insn_access_aux {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
-			u32 ref_obj_id;
+			u32 ref_id;
 		};
 	};
 	struct bpf_verifier_log *log; /* for verbose logs */
@@ -1631,7 +1631,7 @@ struct bpf_ctx_arg_aux {
 	enum bpf_reg_type reg_type;
 	struct btf *btf;
 	u32 btf_id;
-	u32 ref_obj_id;
+	u32 ref_id;
 	bool refcounted;
 };
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3a5c226bf1c3..75b287d8d92f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -66,7 +66,6 @@ struct bpf_reg_state {
 
 		struct { /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
 			u32 mem_size;
-			u32 dynptr_id; /* for dynptr slices */
 		};
 
 		/* For dynptr stack slots */
@@ -148,46 +147,14 @@ struct bpf_reg_state {
 #define BPF_ADD_CONST32 (1U << 30)
 #define BPF_ADD_CONST (BPF_ADD_CONST64 | BPF_ADD_CONST32)
 	u32 id;
-	/* PTR_TO_SOCKET and PTR_TO_TCP_SOCK could be a ptr returned
-	 * from a pointer-cast helper, bpf_sk_fullsock() and
-	 * bpf_tcp_sock().
-	 *
-	 * Consider the following where "sk" is a reference counted
-	 * pointer returned from "sk = bpf_sk_lookup_tcp();":
-	 *
-	 * 1: sk = bpf_sk_lookup_tcp();
-	 * 2: if (!sk) { return 0; }
-	 * 3: fullsock = bpf_sk_fullsock(sk);
-	 * 4: if (!fullsock) { bpf_sk_release(sk); return 0; }
-	 * 5: tp = bpf_tcp_sock(fullsock);
-	 * 6: if (!tp) { bpf_sk_release(sk); return 0; }
-	 * 7: bpf_sk_release(sk);
-	 * 8: snd_cwnd = tp->snd_cwnd;  // verifier will complain
-	 *
-	 * After bpf_sk_release(sk) at line 7, both "fullsock" ptr and
-	 * "tp" ptr should be invalidated also.  In order to do that,
-	 * the reg holding "fullsock" and "sk" need to remember
-	 * the original refcounted ptr id (i.e. sk_reg->id) in ref_obj_id
-	 * such that the verifier can reset all regs which have
-	 * ref_obj_id matching the sk_reg->id.
-	 *
-	 * sk_reg->ref_obj_id is set to sk_reg->id at line 1.
-	 * sk_reg->id will stay as NULL-marking purpose only.
-	 * After NULL-marking is done, sk_reg->id can be reset to 0.
-	 *
-	 * After "fullsock = bpf_sk_fullsock(sk);" at line 3,
-	 * fullsock_reg->ref_obj_id is set to sk_reg->ref_obj_id.
-	 *
-	 * After "tp = bpf_tcp_sock(fullsock);" at line 5,
-	 * tp_reg->ref_obj_id is set to fullsock_reg->ref_obj_id
-	 * which is the same as sk_reg->ref_obj_id.
-	 *
-	 * From the verifier perspective, if sk, fullsock and tp
-	 * are not NULL, they are the same ptr with different
-	 * reg->type.  In particular, bpf_sk_release(tp) is also
-	 * allowed and has the same effect as bpf_sk_release(sk).
+	/*
+	 * Tracks the parent object this register was derived from.
+	 * Used for cascading invalidation: when the parent object is
+	 * released or invalidated, all registers with matching parent_id
+	 * are also invalidated. For example, a slice from bpf_dynptr_data()
+	 * gets parent_id set to the dynptr's id.
 	 */
-	u32 ref_obj_id;
+	u32 parent_id;
 	/* Inside the callee two registers can be both PTR_TO_STACK like
 	 * R1=fp-8 and R2=fp-8, but one of them points to this function stack
 	 * while another to the caller's stack. To differentiate them 'frameno'
@@ -364,10 +331,14 @@ struct bpf_reference_state {
 	 * is used purely to inform the user of a reference leak.
 	 */
 	int insn_idx;
-	/* Use to keep track of the source object of a lock, to ensure
-	 * it matches on unlock.
-	 */
-	void *ptr;
+	union {
+		/* For REF_TYPE_PTR */
+		int parent_id;
+		/* Use to keep track of the source object of a lock, to ensure
+		 * it matches on unlock.
+		 */
+		void *ptr;
+	};
 };
 
 struct bpf_retval_range {
@@ -585,7 +556,7 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame)
 	     iter < frame->out_stack_arg_cnt;                          \
 	     iter++, reg = bpf_get_spilled_stack_arg(iter, frame))
 
-#define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __mask, __expr)   \
+#define bpf_for_each_reg_in_vstate_mask(__vst, __state, __reg, __stack, __mask, __expr)   \
 	({                                                               \
 		struct bpf_verifier_state *___vstate = __vst;            \
 		int ___i, ___j;                                          \
@@ -593,6 +564,7 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame)
 			struct bpf_reg_state *___regs;                   \
 			__state = ___vstate->frame[___i];                \
 			___regs = __state->regs;                         \
+			__stack = NULL;                                  \
 			for (___j = 0; ___j < MAX_BPF_REG; ___j++) {     \
 				__reg = &___regs[___j];                  \
 				(void)(__expr);                          \
@@ -600,8 +572,10 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame)
 			bpf_for_each_spilled_reg(___j, __state, __reg, __mask) { \
 				if (!__reg)                              \
 					continue;                        \
+				__stack = &__state->stack[___j];         \
 				(void)(__expr);                          \
 			}                                                \
+			__stack = NULL;                                  \
 			bpf_for_each_spilled_stack_arg(___j, __state, __reg) { \
 				if (!__reg)                              \
 					continue;                        \
@@ -611,8 +585,13 @@ bpf_get_spilled_stack_arg(int slot, struct bpf_func_state *frame)
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
@@ -1442,7 +1421,7 @@ struct bpf_map_desc {
 struct bpf_dynptr_desc {
 	enum bpf_dynptr_type type;
 	u32 id;
-	u32 ref_obj_id;
+	u32 parent_id;
 };
 
 struct bpf_kfunc_call_arg_meta {
@@ -1453,7 +1432,7 @@ struct bpf_kfunc_call_arg_meta {
 	const struct btf_type *func_proto;
 	const char *func_name;
 	/* Out parameters */
-	u32 ref_obj_id;
+	u32 id;
 	u8 release_regno;
 	bool r0_rdonly;
 	u32 ret_btf_id;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 17d4ab0a8206..f429f6f58cb2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6957,7 +6957,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			info->reg_type = ctx_arg_info->reg_type;
 			info->btf = ctx_arg_info->btf ? : btf_vmlinux;
 			info->btf_id = ctx_arg_info->btf_id;
-			info->ref_obj_id = ctx_arg_info->ref_obj_id;
+			info->ref_id = ctx_arg_info->ref_id;
 			return true;
 		}
 	}
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 12739add2dda..5aa3f7d99ac9 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -870,7 +870,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 		case PTR_TO_BTF_ID:
 		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
 		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
-		 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
+		 * PTR_TO_BTF_ID, and an active referenced id, but the same cannot
 		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
 		 * any faults for loads into such types. BPF_WRITE is disallowed
 		 * for this case.
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 62fe6ed18374..b740fa73ee26 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -665,8 +665,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose_a("id=%d", reg->id & ~BPF_ADD_CONST);
 	if (reg->id & BPF_ADD_CONST)
 		verbose(env, "%+d", reg->delta);
-	if (reg->ref_obj_id)
-		verbose_a("ref_obj_id=%d", reg->ref_obj_id);
+	if (reg->parent_id)
+		verbose_a("parent_id=%d", reg->parent_id);
 	if (type_is_non_owning_ref(reg->type))
 		verbose_a("%s", "non_own_ref");
 	if (type_is_map_ptr(t)) {
@@ -768,21 +768,19 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 			verbose(env, "=dynptr_%s(", dynptr_type_str(reg->dynptr.type));
 			if (reg->id)
 				verbose_a("id=%d", reg->id);
-			if (reg->ref_obj_id)
-				verbose_a("ref_id=%d", reg->ref_obj_id);
-			if (reg->dynptr_id)
-				verbose_a("dynptr_id=%d", reg->dynptr_id);
+			if (reg->parent_id)
+				verbose_a("parent_id=%d", reg->parent_id);
 			verbose(env, ")");
 			break;
 		case STACK_ITER:
-			/* only main slot has ref_obj_id set; skip others */
-			if (!reg->ref_obj_id)
+			/* only main slot has id set; skip others */
+			if (!reg->id)
 				continue;
 
-			verbose(env, " fp%d=iter_%s(ref_id=%d,state=%s,depth=%u)",
+			verbose(env, " fp%d=iter_%s(id=%d,state=%s,depth=%u)",
 				(-i - 1) * BPF_REG_SIZE,
 				iter_type_str(reg->iter.btf, reg->iter.btf_id),
-				reg->ref_obj_id, iter_state_str(reg->iter.state),
+				reg->id, iter_state_str(reg->iter.state),
 				reg->iter.depth);
 			break;
 		case STACK_MISC:
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 877338136009..5945956a7573 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -489,7 +489,7 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 {
 	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 	       check_ids(rold->id, rcur->id, idmap) &&
-	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
+	       check_ids(rold->parent_id, rcur->parent_id, idmap);
 }
 
 enum exact_level {
@@ -614,7 +614,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		       range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off) &&
 		       check_ids(rold->id, rcur->id, idmap) &&
-		       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
+		       check_ids(rold->parent_id, rcur->parent_id, idmap);
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET:
 		/* We must have at least as much range as the old ptr
@@ -794,7 +794,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			cur_reg = &cur->stack[spi].spilled_ptr;
 			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
 			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
-			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+			    !check_ids(old_reg->id, cur_reg->id, idmap) ||
+			    !check_ids(old_reg->parent_id, cur_reg->parent_id, idmap))
 				return false;
 			break;
 		case STACK_ITER:
@@ -810,13 +811,13 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			    old_reg->iter.btf_id != cur_reg->iter.btf_id ||
 			    old_reg->iter.state != cur_reg->iter.state ||
 			    /* ignore {old_reg,cur_reg}->iter.depth, see above */
-			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+			    !check_ids(old_reg->id, cur_reg->id, idmap))
 				return false;
 			break;
 		case STACK_IRQ_FLAG:
 			old_reg = &old->stack[spi].spilled_ptr;
 			cur_reg = &cur->stack[spi].spilled_ptr;
-			if (!check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap) ||
+			if (!check_ids(old_reg->id, cur_reg->id, idmap) ||
 			    old_reg->irq.kfunc_class != cur_reg->irq.kfunc_class)
 				return false;
 			break;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec10f9b896d8..062fdd6b7b59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -200,14 +200,14 @@ struct bpf_verifier_stack_elem {
 
 #define BPF_PRIV_STACK_MIN_SIZE		64
 
-static int acquire_reference(struct bpf_verifier_env *env, int insn_idx);
-static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id);
-static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
+static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int parent_id);
+static int release_reference_nomark(struct bpf_verifier_state *state, int id);
+static int release_reference(struct bpf_verifier_env *env, int id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg);
-static bool is_trusted_reg(const struct bpf_reg_state *reg);
+static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
 static inline bool in_sleepable_context(struct bpf_verifier_env *env);
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
 static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
@@ -241,7 +241,7 @@ struct bpf_call_arg_meta {
 	int access_size;
 	int mem_size;
 	u64 msize_max_value;
-	int ref_obj_id;
+	u32 id;
 	int func_id;
 	struct btf *btf;
 	u32 btf_id;
@@ -339,7 +339,7 @@ static void verbose_invalid_scalar(struct bpf_verifier_env *env,
 	verbose(env, " should have been in [%d, %d]\n", range.minval, range.maxval);
 }
 
-static bool reg_not_null(const struct bpf_reg_state *reg)
+static bool reg_not_null(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
 {
 	enum bpf_reg_type type;
 
@@ -353,7 +353,7 @@ static bool reg_not_null(const struct bpf_reg_state *reg)
 		type == PTR_TO_MAP_VALUE ||
 		type == PTR_TO_MAP_KEY ||
 		type == PTR_TO_SOCK_COMMON ||
-		(type == PTR_TO_BTF_ID && is_trusted_reg(reg)) ||
+		(type == PTR_TO_BTF_ID && is_trusted_reg(env, reg)) ||
 		(type == PTR_TO_MEM && !(reg->type & PTR_UNTRUSTED)) ||
 		type == CONST_PTR_TO_MAP;
 }
@@ -638,43 +638,44 @@ static enum bpf_type_flag get_dynptr_type_flag(enum bpf_dynptr_type type)
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
+			      bool first_slot, int id, int parent_id);
 
 
 static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *sreg1,
 				   struct bpf_reg_state *sreg2,
-				   enum bpf_dynptr_type type)
+				   enum bpf_dynptr_type type, int parent_id)
 {
 	int id = ++env->id_gen;
 
-	__mark_dynptr_reg(sreg1, type, true, id);
-	__mark_dynptr_reg(sreg2, type, false, id);
+	__mark_dynptr_reg(sreg1, type, true, id, parent_id);
+	__mark_dynptr_reg(sreg2, type, false, id, parent_id);
 }
 
 static void mark_dynptr_cb_reg(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg,
 			       enum bpf_dynptr_type type)
 {
-	__mark_dynptr_reg(reg, type, true, ++env->id_gen);
+	__mark_dynptr_reg(reg, type, true, ++env->id_gen, 0);
 }
 
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi);
 
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				   enum bpf_arg_type arg_type, int insn_idx, int clone_ref_obj_id)
+				   enum bpf_arg_type arg_type, int insn_idx, int parent_id,
+				   struct bpf_dynptr_desc *dynptr)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
-	enum bpf_dynptr_type type;
 	int spi, i, err;
+	enum bpf_dynptr_type type;
 
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
@@ -705,85 +706,62 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	if (type == BPF_DYNPTR_TYPE_INVALID)
 		return -EINVAL;
 
-	mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
-			       &state->stack[spi - 1].spilled_ptr, type);
-
-	if (dynptr_type_refcounted(type)) {
-		/* The id is used to track proper releasing */
-		int id;
+	if (dynptr->type == BPF_DYNPTR_TYPE_INVALID) { /* dynptr constructors */
+		if (dynptr_type_referenced(type)) {
+			int id;
 
-		if (clone_ref_obj_id)
-			id = clone_ref_obj_id;
-		else
-			id = acquire_reference(env, insn_idx);
-
-		if (id < 0)
-			return id;
+			/*
+			 * Create an intermediate reference that tracks the referenced
+			 * object for the referenced dynptr. Freeing a referenced dynptr
+			 * through helpers/kfuncs will invalidate all clones.
+			 */
+			id = acquire_reference(env, insn_idx, parent_id);
+			if (id < 0)
+				return id;
 
-		state->stack[spi].spilled_ptr.ref_obj_id = id;
-		state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
+			parent_id = id;
+		}
+	} else { /* bpf_dynptr_clone() */
+		parent_id = dynptr->parent_id;
 	}
 
+	mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
+			       &state->stack[spi - 1].spilled_ptr, type, parent_id);
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
+	 * For referenced dynptr, release the parent ref which cascades to
+	 * all clones and derived slices. For non-referenced dynptr, only
+	 * the dynptr and slices derived from it will be invalidated.
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
+	return release_reference(env, dynptr_type_referenced(reg->dynptr.type)
+				      ? reg->parent_id
+				      : reg->id);
 }
 
 static void __mark_reg_unknown(const struct bpf_verifier_env *env,
@@ -800,9 +778,7 @@ static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi)
 {
-	struct bpf_func_state *fstate;
-	struct bpf_reg_state *dreg;
-	int i, dynptr_id;
+	int i, err = 0;
 
 	/* We always ensure that STACK_DYNPTR is never set partially,
 	 * hence just checking for slot_type[0] is enough. This is
@@ -816,13 +792,13 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
 		spi = spi + 1;
 
-	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
-		int ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
+	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type)) {
+		int v_parent_id = state->stack[spi].spilled_ptr.parent_id;
 		int ref_cnt = 0;
 
 		/*
 		 * A referenced dynptr can be overwritten only if there is at
-		 * least one other dynptr sharing the same ref_obj_id,
+		 * least one other dynptr sharing the same virtual ref parent,
 		 * ensuring the reference can still be properly released.
 		 */
 		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
@@ -830,7 +806,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				continue;
 			if (!state->stack[i].spilled_ptr.dynptr.first_slot)
 				continue;
-			if (state->stack[i].spilled_ptr.ref_obj_id == ref_obj_id)
+			if (state->stack[i].spilled_ptr.parent_id == v_parent_id)
 				ref_cnt++;
 		}
 
@@ -840,32 +816,14 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 		}
 	}
 
-	mark_stack_slot_scratched(env, spi);
-	mark_stack_slot_scratched(env, spi - 1);
-
-	/* Writing partially to one dynptr stack slot destroys both. */
-	for (i = 0; i < BPF_REG_SIZE; i++) {
-		state->stack[spi].slot_type[i] = STACK_INVALID;
-		state->stack[spi - 1].slot_type[i] = STACK_INVALID;
+	/* Invalidate the dynptr and any derived slices */
+	err = release_reference(env, state->stack[spi].spilled_ptr.id);
+	if (!err) {
+		mark_stack_slot_scratched(env, spi);
+		mark_stack_slot_scratched(env, spi - 1);
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
-
-	return 0;
+	return err;
 }
 
 static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
@@ -965,7 +923,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 	if (spi < 0)
 		return spi;
 
-	id = acquire_reference(env, insn_idx);
+	id = acquire_reference(env, insn_idx, 0);
 	if (id < 0)
 		return id;
 
@@ -981,7 +939,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 			else
 				st->type |= PTR_UNTRUSTED;
 		}
-		st->ref_obj_id = i == 0 ? id : 0;
+		st->id = i == 0 ? id : 0;
 		st->iter.btf = btf;
 		st->iter.btf_id = btf_id;
 		st->iter.state = BPF_ITER_STATE_ACTIVE;
@@ -1011,7 +969,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
 		if (i == 0)
-			WARN_ON_ONCE(release_reference(env, st->ref_obj_id));
+			WARN_ON_ONCE(release_reference(env, st->id));
 
 		bpf_mark_reg_not_init(env, st);
 
@@ -1067,10 +1025,10 @@ static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_s
 
 		if (st->type & PTR_UNTRUSTED)
 			return -EPROTO;
-		/* only main (first) slot has ref_obj_id set */
-		if (i == 0 && !st->ref_obj_id)
+		/* only main (first) slot has id set */
+		if (i == 0 && !st->id)
 			return -EINVAL;
-		if (i != 0 && st->ref_obj_id)
+		if (i != 0 && st->id)
 			return -EINVAL;
 		if (st->iter.btf != btf || st->iter.btf_id != btf_id)
 			return -EINVAL;
@@ -1109,7 +1067,7 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 
 	__mark_reg_known_zero(st);
 	st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
-	st->ref_obj_id = id;
+	st->id = id;
 	st->irq.kfunc_class = kfunc_class;
 
 	for (i = 0; i < BPF_REG_SIZE; i++)
@@ -1143,7 +1101,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 		return -EINVAL;
 	}
 
-	err = release_irq_state(env->cur_state, st->ref_obj_id);
+	err = release_irq_state(env->cur_state, st->id);
 	WARN_ON_ONCE(err && err != -EACCES);
 	if (err) {
 		int insn_idx = 0;
@@ -1207,7 +1165,7 @@ static int is_irq_flag_reg_valid_init(struct bpf_verifier_env *env, struct bpf_r
 	slot = &state->stack[spi];
 	st = &slot->spilled_ptr;
 
-	if (!st->ref_obj_id)
+	if (!st->id)
 		return -EINVAL;
 
 	for (i = 0; i < BPF_REG_SIZE; i++)
@@ -1448,7 +1406,7 @@ static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_e
 	return &state->refs[new_ofs];
 }
 
-static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)
+static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int parent_id)
 {
 	struct bpf_reference_state *s;
 
@@ -1457,6 +1415,7 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)
 		return -ENOMEM;
 	s->type = REF_TYPE_PTR;
 	s->id = ++env->id_gen;
+	s->parent_id = parent_id;
 	return s->id;
 }
 
@@ -1513,17 +1472,25 @@ static void release_reference_state(struct bpf_verifier_state *state, int idx)
 	return;
 }
 
-static bool find_reference_state(struct bpf_verifier_state *state, int ptr_id)
+static bool find_reference_state(struct bpf_verifier_state *state, int id)
 {
 	int i;
 
-	for (i = 0; i < state->acquired_refs; i++)
-		if (state->refs[i].id == ptr_id)
+	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type != REF_TYPE_PTR)
+			continue;
+		if (state->refs[i].id == id)
 			return true;
+	}
 
 	return false;
 }
 
+static bool reg_is_referenced(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
+{
+	return find_reference_state(env->cur_state, reg->id);
+}
+
 static int release_lock_state(struct bpf_verifier_state *state, int type, int id, void *ptr)
 {
 	void *prev_ptr = NULL;
@@ -1837,7 +1804,7 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	memset(((u8 *)reg) + sizeof(reg->type), 0,
 	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
 	reg->id = 0;
-	reg->ref_obj_id = 0;
+	reg->parent_id = 0;
 	___mark_reg_known(reg, imm);
 }
 
@@ -1872,7 +1839,7 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type type,
-			      bool first_slot, int dynptr_id)
+			      bool first_slot, int id, int parent_id)
 {
 	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
 	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so simply
@@ -1881,7 +1848,8 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type ty
 	__mark_reg_known_zero(reg);
 	reg->type = CONST_PTR_TO_DYNPTR;
 	/* Give each dynptr a unique id to uniquely associate slices to it. */
-	reg->id = dynptr_id;
+	reg->id = id;
+	reg->parent_id = parent_id;
 	reg->dynptr.type = type;
 	reg->dynptr.first_slot = first_slot;
 }
@@ -2161,17 +2129,12 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
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
 
@@ -4330,7 +4293,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	 * referenced PTR_TO_BTF_ID, and that its fixed offset is 0. For the
 	 * normal store of unreferenced kptr, we must ensure var_off is zero.
 	 * Since ref_ptr cannot be accessed directly by BPF insns, check for
-	 * reg->ref_obj_id is not needed here.
+	 * reg->id is not needed here.
 	 */
 	if (__check_ptr_off_reg(env, reg, argno_from_reg(regno), true))
 		return -EACCES;
@@ -4703,8 +4666,8 @@ static int __check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int of
 		 * type of narrower access.
 		 */
 		if (base_type(info->reg_type) == PTR_TO_BTF_ID) {
-			if (info->ref_obj_id &&
-			    !find_reference_state(env->cur_state, info->ref_obj_id)) {
+			if (info->ref_id &&
+			    !find_reference_state(env->cur_state, info->ref_id)) {
 				verbose(env, "invalid bpf_context access off=%d. Reference may already be released\n",
 					off);
 				return -EACCES;
@@ -4873,10 +4836,10 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 	[CONST_PTR_TO_MAP] = btf_bpf_map_id,
 };
 
-static bool is_trusted_reg(const struct bpf_reg_state *reg)
+static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
 {
 	/* A referenced register is always trusted. */
-	if (reg->ref_obj_id)
+	if (reg_is_referenced(env, reg))
 		return true;
 
 	/* Types listed in the reg2btf_ids are always trusted */
@@ -5790,7 +5753,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		ret = env->ops->btf_struct_access(&env->log, reg, off, size);
 	} else {
 		/* Writes are permitted with default btf_struct_access for
-		 * program allocated objects (which always have ref_obj_id > 0),
+		 * program allocated objects (which always have id > 0),
 		 * but not for untrusted PTR_TO_BTF_ID | MEM_ALLOC.
 		 */
 		if (atype != BPF_READ && !type_is_ptr_alloc_obj(reg->type)) {
@@ -5799,8 +5762,8 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		}
 
 		if (type_is_alloc(reg->type) && !type_is_non_owning_ref(reg->type) &&
-		    !(reg->type & MEM_RCU) && !reg->ref_obj_id) {
-			verifier_bug(env, "ref_obj_id for allocated object must be non-zero");
+		    !(reg->type & MEM_RCU) && !reg_is_referenced(env, reg)) {
+			verifier_bug(env, "allocated object must have a referenced id");
 			return -EFAULT;
 		}
 
@@ -5819,7 +5782,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		 */
 		flag = PTR_UNTRUSTED;
 
-	} else if (is_trusted_reg(reg) || is_rcu_reg(reg)) {
+	} else if (is_trusted_reg(env, reg) || is_rcu_reg(reg)) {
 		/* By default any pointer obtained from walking a trusted pointer is no
 		 * longer trusted, unless the field being accessed has explicitly been
 		 * marked as inheriting its parent's state of trust (either full or RCU).
@@ -6217,8 +6180,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 				if (base_type(info.reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = info.btf;
 					regs[value_regno].btf_id = info.btf_id;
-					regs[value_regno].id = info.ref_obj_id;
-					regs[value_regno].ref_obj_id = info.ref_obj_id;
+					regs[value_regno].id = info.ref_id;
 				}
 				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
 					regs[value_regno].id = ++env->id_gen;
@@ -7195,7 +7157,16 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
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
@@ -7211,7 +7182,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
  */
 static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			       argno_t argno, int insn_idx, enum bpf_arg_type arg_type,
-			       int clone_ref_obj_id, struct bpf_dynptr_desc *dynptr)
+			       int parent_id, struct bpf_dynptr_desc *dynptr)
 {
 	int spi, err = 0;
 
@@ -7252,7 +7223,7 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 				return err;
 		}
 
-		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, clone_ref_obj_id);
+		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx, parent_id, dynptr);
 	} else /* OBJ_RELEASE and None case from above */ {
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) {
@@ -7294,17 +7265,17 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		if (dynptr) {
 			dynptr->type = reg->dynptr.type;
 			dynptr->id = reg->id;
-			dynptr->ref_obj_id = reg->ref_obj_id;
+			dynptr->parent_id = reg->parent_id;
 		}
 	}
 	return err;
 }
 
-static u32 iter_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int spi)
+static u32 iter_ref_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int spi)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
 
-	return state->stack[spi].spilled_ptr.ref_obj_id;
+	return state->stack[spi].spilled_ptr.id;
 }
 
 static bool is_iter_kfunc(struct bpf_kfunc_call_arg_meta *meta)
@@ -7410,7 +7381,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		/* remember meta->iter info for process_iter_next_call() */
 		meta->iter.spi = spi;
 		meta->iter.frameno = reg->frameno;
-		meta->ref_obj_id = iter_ref_obj_id(env, reg, spi);
+		meta->id = iter_ref_id(env, reg, spi);
 
 		if (is_iter_destroy_kfunc(meta)) {
 			err = unmark_stack_slots_iter(env, reg, nr_slots);
@@ -7993,7 +7964,7 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	/* When referenced register is passed to release function, its fixed
 	 * offset must be 0.
 	 *
-	 * We will check arg_type_is_release reg has ref_obj_id when storing
+	 * We will check arg_type_is_release reg has id when storing
 	 * meta->release_regno.
 	 */
 	if (arg_type_is_release(arg_type)) {
@@ -8254,7 +8225,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			 */
 			if (reg->type == PTR_TO_STACK) {
 				spi = dynptr_get_spi(env, reg);
-				if (spi < 0 || !state->stack[spi].spilled_ptr.ref_obj_id) {
+				if (spi < 0 || !state->stack[spi].spilled_ptr.id) {
 					verbose(env, "arg %d is an unacquired reference\n", regno);
 					return -EINVAL;
 				}
@@ -8262,7 +8233,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 				verbose(env, "cannot release unowned const bpf_dynptr\n");
 				return -EINVAL;
 			}
-		} else if (!reg->ref_obj_id && !bpf_register_is_null(reg)) {
+		} else if (!reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
 			verbose(env, "R%d must be referenced when passed to release function\n",
 				regno);
 			return -EINVAL;
@@ -8274,14 +8245,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		meta->release_regno = regno;
 	}
 
-	if (reg->ref_obj_id && base_type(arg_type) != ARG_KPTR_XCHG_DEST) {
-		if (meta->ref_obj_id) {
-			verbose(env, "more than one arg with ref_obj_id R%d %u %u",
-				regno, reg->ref_obj_id,
-				meta->ref_obj_id);
+	if (reg_is_referenced(env, reg) && base_type(arg_type) != ARG_KPTR_XCHG_DEST) {
+		if (meta->id) {
+			verbose(env, "more than one arg with referenced id R%d %u %u",
+				regno, reg->id,
+				meta->id);
 			return -EACCES;
 		}
-		meta->ref_obj_id = reg->ref_obj_id;
+		meta->id = reg->id;
 	}
 
 	switch (base_type(arg_type)) {
@@ -8892,14 +8863,14 @@ static void mark_pkt_end(struct bpf_verifier_state *vstate, int regn, bool range
 		reg->range = AT_PKT_END;
 }
 
-static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id)
+static int release_reference_nomark(struct bpf_verifier_state *state, int id)
 {
 	int i;
 
 	for (i = 0; i < state->acquired_refs; i++) {
 		if (state->refs[i].type != REF_TYPE_PTR)
 			continue;
-		if (state->refs[i].id == ref_obj_id) {
+		if (state->refs[i].id == id) {
 			release_reference_state(state, i);
 			return 0;
 		}
@@ -8907,26 +8878,83 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int ref_ob
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
+/* Release id and objects derived from it iteratively in a DFS manner */
+static int release_reference(struct bpf_verifier_env *env, int id)
+{
+	u32 mask = (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
 	struct bpf_verifier_state *vstate = env->cur_state;
+	struct bpf_idmap *idstack = &env->idmap_scratch;
+	struct bpf_stack_state *stack;
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
-	int err;
+	int i, err;
 
-	err = release_reference_nomark(vstate, ref_obj_id);
+	idstack->cnt = 0;
+	err = idstack_push(idstack, id);
 	if (err)
 		return err;
 
-	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->ref_obj_id == ref_obj_id)
-			mark_reg_invalid(env, reg);
-	}));
+	if (find_reference_state(vstate, id))
+		WARN_ON_ONCE(release_reference_nomark(vstate, id));
+
+	while ((id = idstack_pop(idstack))) {
+		/*
+		 * Child references are inaccessible after parent is released,
+		 * any child references that exist at this point are a leak.
+		 */
+		for (i = 0; i < vstate->acquired_refs; i++) {
+			if (vstate->refs[i].type != REF_TYPE_PTR)
+				continue;
+			if (vstate->refs[i].parent_id != id)
+				continue;
+			verbose(env, "Leaking reference id=%d alloc_insn=%d. Release it first.\n",
+				vstate->refs[i].id, vstate->refs[i].insn_idx);
+			return -EINVAL;
+		}
+
+		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
+			if (reg->id != id && reg->parent_id != id)
+				continue;
+
+			/* Free objects derived from the current object */
+			if (reg->parent_id == id) {
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
@@ -9827,7 +9855,7 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 		 * kernel. Type checks are performed later in check_return_code.
 		 */
 		if (type == BPF_PROG_TYPE_STRUCT_OPS && !exception_exit &&
-		    reg->ref_obj_id == state->refs[i].id)
+		    reg->id == state->refs[i].id)
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
@@ -10110,18 +10138,18 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = -EINVAL;
 		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
 			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
-		} else if (func_id == BPF_FUNC_kptr_xchg && meta.ref_obj_id) {
-			u32 ref_obj_id = meta.ref_obj_id;
+		} else if (func_id == BPF_FUNC_kptr_xchg && meta.id) {
+			u32 id = meta.id;
 			bool in_rcu = in_rcu_cs(env);
 			struct bpf_func_state *state;
 			struct bpf_reg_state *reg;
 
-			err = release_reference_nomark(env->cur_state, ref_obj_id);
+			err = release_reference_nomark(env->cur_state, id);
 			if (!err) {
 				bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
-					if (reg->ref_obj_id == ref_obj_id) {
+					if (reg->id == id) {
 						if (in_rcu && (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU)) {
-							reg->ref_obj_id = 0;
+							reg->id = 0;
 							reg->type &= ~MEM_ALLOC;
 							reg->type |= MEM_RCU;
 						} else {
@@ -10130,19 +10158,16 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 					}
 				}));
 			}
-		} else if (meta.ref_obj_id) {
-			err = release_reference(env, meta.ref_obj_id);
+		} else if (meta.id) {
+			err = release_reference(env, meta.id);
 		} else if (bpf_register_is_null(&regs[meta.release_regno])) {
-			/* meta.ref_obj_id can only be 0 if register that is meant to be
+			/* meta.id can only be 0 if register that is meant to be
 			 * released is NULL, which must be > R0.
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
@@ -10407,24 +10432,40 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return -EFAULT;
 	}
 
-	if (is_ptr_cast_function(func_id)) {
-		/* For release_reference() */
-		regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
+	if (is_ptr_cast_function(func_id) &&
+	    find_reference_state(env->cur_state, meta.id)) {
+		struct bpf_verifier_state *branch;
+		struct bpf_reg_state *r0;
+
+		/*
+		 * In order for a release of any of the original or cast pointers
+		 * to invalidate all other pointers, reuse the same reference id for
+		 * the cast result.
+		 * This reference id can't be used for nullness propagation,
+		 * as cast might return NULL for a non-NULL input.
+		 * Hence, explore the NULL case as a separate branch.
+		 */
+		branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
+		if (IS_ERR(branch))
+			return PTR_ERR(branch);
+
+		r0 = &branch->frame[branch->curframe]->regs[BPF_REG_0];
+		__mark_reg_known_zero(r0);
+		r0->type = SCALAR_VALUE;
+
+		regs[BPF_REG_0].type &= ~PTR_MAYBE_NULL;
+		regs[BPF_REG_0].id = meta.id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
-		int id = acquire_reference(env, insn_idx);
+		int id = acquire_reference(env, insn_idx, 0);
 
 		if (id < 0)
 			return id;
-		/* For mark_ptr_or_null_reg() */
+
 		regs[BPF_REG_0].id = id;
-		/* For release_reference() */
-		regs[BPF_REG_0].ref_obj_id = id;
 	}
 
-	if (func_id == BPF_FUNC_dynptr_data) {
-		regs[BPF_REG_0].dynptr_id = meta.dynptr.id;
-		regs[BPF_REG_0].ref_obj_id = meta.dynptr.ref_obj_id;
-	}
+	if (func_id == BPF_FUNC_dynptr_data)
+		regs[BPF_REG_0].parent_id = meta.dynptr.id;
 
 	err = do_refine_retval_range(env, regs, fn->ret_type, func_id, &meta);
 	if (err)
@@ -11236,7 +11277,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	 * btf_struct_ids_match() to walk the struct at the 0th offset, and
 	 * resolve types.
 	 */
-	if ((is_kfunc_release(meta) && reg->ref_obj_id) ||
+	if ((is_kfunc_release(meta) && reg_is_referenced(env, reg)) ||
 	    btf_type_ids_nocast_alias(&env->log, reg_btf, reg_ref_id, meta->btf, ref_id))
 		strict_type_match = true;
 
@@ -11340,36 +11381,21 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
 	return 0;
 }
 
-static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 ref_obj_id)
+static void ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 id)
 {
-	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_func_state *unused;
 	struct bpf_reg_state *reg;
-	int i;
 
-	if (!ref_obj_id) {
-		verifier_bug(env, "ref_obj_id is zero for owning -> non-owning conversion");
-		return -EFAULT;
-	}
+	WARN_ON_ONCE(release_reference_nomark(env->cur_state, id));
 
-	for (i = 0; i < state->acquired_refs; i++) {
-		if (state->refs[i].id != ref_obj_id)
-			continue;
-
-		/* Clear ref_obj_id here so release_reference doesn't clobber
-		 * the whole reg
-		 */
-		bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
-			if (reg->ref_obj_id == ref_obj_id) {
-				reg->ref_obj_id = 0;
-				ref_set_non_owning(env, reg);
-			}
-		}));
-		return 0;
-	}
+	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
+		if (reg->id == id) {
+			reg->id = 0;
+			ref_set_non_owning(env, reg);
+		}
+	}));
 
-	verifier_bug(env, "ref state missing for ref_obj_id");
-	return -EFAULT;
+	return;
 }
 
 /* Implementation details:
@@ -11901,14 +11927,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EACCES;
 		}
 
-		if (reg->ref_obj_id) {
-			if (is_kfunc_release(meta) && meta->ref_obj_id) {
-				verifier_bug(env, "more than one arg with ref_obj_id %s %u %u",
-					     reg_arg_name(env, argno), reg->ref_obj_id,
-					     meta->ref_obj_id);
+		if (reg_is_referenced(env, reg)) {
+			if (is_kfunc_release(meta) && meta->id) {
+				verifier_bug(env, "more than one arg with referenced id %s %u %u",
+					     reg_arg_name(env, argno), reg->id,
+					     meta->id);
 				return -EFAULT;
 			}
-			meta->ref_obj_id = reg->ref_obj_id;
+			meta->id = reg->id;
 			if (is_kfunc_release(meta)) {
 				if (regno < 0) {
 					verbose(env, "%s release arg cannot be a stack argument\n",
@@ -11969,7 +11995,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			fallthrough;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
-			if (!is_trusted_reg(reg)) {
+			if (!is_trusted_reg(env, reg)) {
 				if (!is_kfunc_rcu(meta)) {
 					verbose(env, "%s must be referenced or trusted\n",
 						reg_arg_name(env, argno));
@@ -12007,7 +12033,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EFAULT;
 		}
 
-		if (is_kfunc_release(meta) && reg->ref_obj_id)
+		if (is_kfunc_release(meta) && reg_is_referenced(env, reg))
 			arg_type |= OBJ_RELEASE;
 		ret = check_func_arg_reg_off(env, reg, argno, arg_type);
 		if (ret < 0)
@@ -12046,7 +12072,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (!reg->ref_obj_id) {
+			if (!reg_is_referenced(env, reg)) {
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
@@ -12058,7 +12084,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_DYNPTR:
 		{
 			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
-			int clone_ref_obj_id = 0;
 
 			if (is_kfunc_arg_uninit(btf, &args[i]))
 				dynptr_arg_type |= MEM_UNINIT;
@@ -12089,15 +12114,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
+						  meta->id, &meta->dynptr);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12120,7 +12140,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id) {
+			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) &&
+			    !reg_is_referenced(env, reg)) {
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
@@ -12135,7 +12156,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id) {
+			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) &&
+			    !reg_is_referenced(env, reg)) {
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
@@ -12145,7 +12167,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_LIST_NODE:
 			if (is_kfunc_arg_nonown_allowed(btf, &args[i]) &&
-			    type_is_non_owning_ref(reg->type) && !reg->ref_obj_id) {
+			    type_is_non_owning_ref(reg->type) && !reg_is_referenced(env, reg)) {
 				/* Allow bpf_list_front/back return value for
 				 * __nonown_allowed list-node arguments.
 				 */
@@ -12156,7 +12178,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (!reg->ref_obj_id) {
+			if (!reg_is_referenced(env, reg)) {
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
@@ -12172,12 +12194,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 						reg_arg_name(env, argno));
 					return -EINVAL;
 				}
-				if (!reg->ref_obj_id) {
+				if (!reg_is_referenced(env, reg)) {
 					verbose(env, "allocated object must be referenced\n");
 					return -EINVAL;
 				}
 			} else {
-				if (!type_is_non_owning_ref(reg->type) && !reg->ref_obj_id) {
+				if (!type_is_non_owning_ref(reg->type) &&
+				    !reg_is_referenced(env, reg)) {
 					verbose(env, "%s can only take non-owning or refcounted bpf_rb_node pointer\n", func_name);
 					return -EINVAL;
 				}
@@ -12758,12 +12781,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
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
@@ -12777,13 +12795,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
 	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
-	u32 i, nargs, ptr_type_id, release_ref_obj_id;
 	struct bpf_reg_state *regs = cur_regs(env);
 	const char *func_name, *ptr_type_name;
 	const struct btf_type *t, *ptr_type;
 	struct bpf_kfunc_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
 	int err, insn_idx = *insn_idx_p;
+	u32 i, nargs, ptr_type_id, id;
 	const struct btf_param *args;
 	struct btf *desc_btf;
 
@@ -12896,6 +12914,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (rcu_lock) {
 		env->cur_state->active_rcu_locks++;
 	} else if (rcu_unlock) {
+		struct bpf_stack_state *stack;
 		struct bpf_func_state *state;
 		struct bpf_reg_state *reg;
 		u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
@@ -12905,7 +12924,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 		if (--env->cur_state->active_rcu_locks == 0) {
-			bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_mask, ({
+			bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, clear_mask, ({
 				if (reg->type & MEM_RCU) {
 					reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
 					reg->type |= PTR_UNTRUSTED;
@@ -12944,35 +12963,20 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (meta.release_regno) {
 		struct bpf_reg_state *reg = &regs[meta.release_regno];
 
-		if (meta.dynptr.ref_obj_id) {
+		if (meta.dynptr.id) {
 			err = unmark_stack_slots_dynptr(env, reg);
 		} else {
-			err = release_reference(env, reg->ref_obj_id);
-			if (err)
-				verbose(env, "kfunc %s#%d reference has not been acquired before\n",
-					func_name, meta.func_id);
+			err = release_reference(env, reg->id);
 		}
 		if (err)
 			return err;
 	}
 
 	if (is_bpf_list_push_kfunc(meta.func_id) || is_bpf_rbtree_add_kfunc(meta.func_id)) {
-		release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
+		id = regs[BPF_REG_2].id;
 		insn_aux->insert_off = regs[BPF_REG_2].var_off.value;
 		insn_aux->kptr_struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
-		err = ref_convert_owning_non_owning(env, release_ref_obj_id);
-		if (err) {
-			verbose(env, "kfunc %s#%d conversion of owning ref to non-owning failed\n",
-				func_name, meta.func_id);
-			return err;
-		}
-
-		err = release_reference(env, release_ref_obj_id);
-		if (err) {
-			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
-				func_name, meta.func_id);
-			return err;
-		}
+		ref_convert_owning_non_owning(env, id);
 	}
 
 	if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
@@ -13057,8 +13061,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				regs[BPF_REG_0].type |= MEM_RDONLY;
 
 			/* Ensures we don't access the memory after a release_reference() */
-			if (meta.ref_obj_id)
-				regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
+			if (meta.id)
+				regs[BPF_REG_0].parent_id = meta.id;
 
 			if (is_kfunc_rcu_protected(&meta))
 				regs[BPF_REG_0].type |= MEM_RCU;
@@ -13104,13 +13108,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
-			int id = acquire_reference(env, insn_idx);
-
+			id = acquire_reference(env, insn_idx, 0);
 			if (id < 0)
 				return id;
-			if (is_kfunc_ret_null(&meta))
-				regs[BPF_REG_0].id = id;
-			regs[BPF_REG_0].ref_obj_id = id;
+			regs[BPF_REG_0].id = id;
 		} else if (is_rbtree_node_type(ptr_type) || is_list_node_type(ptr_type)) {
 			ref_set_non_owning(env, &regs[BPF_REG_0]);
 		}
@@ -15341,7 +15342,7 @@ static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *r
 		if (!is_reg_const(reg2, is_jmp32))
 			return -1;
 
-		if (!reg_not_null(reg1))
+		if (!reg_not_null(env, reg1))
 			return -1;
 
 		/* If pointer is valid tests against zero will fail so we can
@@ -15558,7 +15559,7 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 		    WARN_ON_ONCE(!tnum_equals_const(reg->var_off, 0)))
 			return;
 		if (is_null) {
-			/* We don't need id and ref_obj_id from this point
+			/* We don't need id from this point
 			 * onwards anymore, thus we should better reset it,
 			 * so that state pruning has chances to take effect.
 			 */
@@ -15585,10 +15586,9 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 {
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = state->regs, *reg;
-	u32 ref_obj_id = regs[regno].ref_obj_id;
 	u32 id = regs[regno].id;
 
-	if (ref_obj_id && ref_obj_id == id && is_null)
+	if (is_null && find_reference_state(vstate, id))
 		/* regs[regno] is in the " == NULL" branch.
 		 * No one could have freed the reference state before
 		 * doing the NULL check.
@@ -16427,7 +16427,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		ret_type = btf_type_resolve_ptr(prog->aux->attach_btf,
 						prog->aux->attach_func_proto->type,
 						NULL);
-		if (ret_type && ret_type == reg_type && reg->ref_obj_id)
+		if (ret_type && ret_type == reg_type && reg_is_referenced(env, reg))
 			return __check_ptr_off_reg(env, reg, argno_from_reg(regno), false);
 	}
 
@@ -18296,7 +18296,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				mark_reg_unknown(env, regs, i);
 			} else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
 				/* assume unspecial LOCAL dynptr type */
-				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen);
+				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen, 0);
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
 				reg->type = PTR_TO_MEM;
 				reg->type |= arg->arg_type &
@@ -18355,8 +18355,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	/* Acquire references for struct_ops program arguments tagged with "__ref" */
 	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
 		for (i = 0; i < aux->ctx_arg_info_size; i++)
-			aux->ctx_arg_info[i].ref_obj_id = aux->ctx_arg_info[i].refcounted ?
-							  acquire_reference(env, 0) : 0;
+			aux->ctx_arg_info[i].ref_id = aux->ctx_arg_info[i].refcounted ?
+						      acquire_reference(env, 0, 0) : 0;
 	}
 
 	ret = do_check(env);
diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index bbe476f4c47d..5c3579438427 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -13,8 +13,8 @@ static struct {
 	const char *err_msg;
 } spin_lock_fail_tests[] = {
 	{ "lock_id_kptr_preserve",
-	  "[0-9]\\+: (bf) r1 = r0                       ; R0=ptr_foo(id=2,ref_obj_id=2)"
-	  " R1=ptr_foo(id=2,ref_obj_id=2) refs=2\n"
+	  "[0-9]\\+: (bf) r1 = r0                       ; R0=ptr_foo(id=2)"
+	  " R1=ptr_foo(id=2) refs=2\n"
 	  "[0-9]\\+: (85) call bpf_this_cpu_ptr#154\n"
 	  "R1 type=ptr_ expected=percpu_ptr_" },
 	{ "lock_id_global_zero",
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index dbd97add5a5a..fa0beeaad1be 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -78,7 +78,7 @@ static int get_map_val_dynptr(struct bpf_dynptr *ptr)
  * bpf_ringbuf_submit/discard_dynptr call
  */
 SEC("?raw_tp")
-__failure __msg("Unreleased reference id=2")
+__failure __msg("Unreleased reference id=1")
 int ringbuf_missing_release1(void *ctx)
 {
 	struct bpf_dynptr ptr = {};
@@ -91,7 +91,7 @@ int ringbuf_missing_release1(void *ctx)
 }
 
 SEC("?raw_tp")
-__failure __msg("Unreleased reference id=4")
+__failure __msg("Unreleased reference id=3")
 int ringbuf_missing_release2(void *ctx)
 {
 	struct bpf_dynptr ptr1, ptr2;
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
index af8f9ec1ea98..646026430e9b 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -30,7 +30,7 @@ int force_clang_to_emit_btf_for_externs(void *ctx)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("fp-8=iter_num(ref_id=1,state=active,depth=0)")
+__msg("fp-8=iter_num(id=1,state=active,depth=0)")
 int create_and_destroy(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -196,7 +196,7 @@ int leak_iter_from_subprog_fail(void *ctx)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("fp-8=iter_num(ref_id=1,state=active,depth=0)")
+__msg("fp-8=iter_num(id=1,state=active,depth=0)")
 int valid_stack_reuse(void *ctx)
 {
 	struct bpf_iter_num iter;
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
index 9b760dac333e..d00888f6687a 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
@@ -20,8 +20,8 @@ __s64 res_empty;
 
 SEC("raw_tp/sys_enter")
 __success __log_level(2)
-__msg("fp-16=iter_testmod_seq(ref_id=1,state=active,depth=0)")
-__msg("fp-16=iter_testmod_seq(ref_id=1,state=drained,depth=0)")
+__msg("fp-16=iter_testmod_seq(id=1,state=active,depth=0)")
+__msg("fp-16=iter_testmod_seq(id=1,state=drained,depth=0)")
 __msg("call bpf_iter_testmod_seq_destroy")
 int testmod_seq_empty(const void *ctx)
 {
@@ -38,8 +38,8 @@ __s64 res_full;
 
 SEC("raw_tp/sys_enter")
 __success __log_level(2)
-__msg("fp-16=iter_testmod_seq(ref_id=1,state=active,depth=0)")
-__msg("fp-16=iter_testmod_seq(ref_id=1,state=drained,depth=0)")
+__msg("fp-16=iter_testmod_seq(id=1,state=active,depth=0)")
+__msg("fp-16=iter_testmod_seq(id=1,state=drained,depth=0)")
 __msg("call bpf_iter_testmod_seq_destroy")
 int testmod_seq_full(const void *ctx)
 {
@@ -58,8 +58,8 @@ static volatile int zero = 0;
 
 SEC("raw_tp/sys_enter")
 __success __log_level(2)
-__msg("fp-16=iter_testmod_seq(ref_id=1,state=active,depth=0)")
-__msg("fp-16=iter_testmod_seq(ref_id=1,state=drained,depth=0)")
+__msg("fp-16=iter_testmod_seq(id=1,state=active,depth=0)")
+__msg("fp-16=iter_testmod_seq(id=1,state=drained,depth=0)")
 __msg("call bpf_iter_testmod_seq_destroy")
 int testmod_seq_truncated(const void *ctx)
 {
-- 
2.53.0-Meta


