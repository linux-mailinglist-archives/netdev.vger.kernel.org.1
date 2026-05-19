Return-Path: <netdev+bounces-289571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A+XAF+oDGodkgUAu9opvQ
	(envelope-from <netdev+bounces-289571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:13:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1A5837C9
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FD353057B5B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BEC34167B;
	Tue, 19 May 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgSUmvNF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7BC340A43
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214415; cv=none; b=F/u+ynLiGYARkOdltj6DLW1C4RTmeOYN9uGldvk7iuYrPIckckgxLXBt0GH5ZgE5X4x4+HKiJmS32klcTFZaK9mdWcc9NBSnkQ3OepI+hbjlJFFxbtAt81dDkpizzDoCxAB4EXjjvokHOj/Dh8cskuEiGqrIuhm/JVKWHoc50Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214415; c=relaxed/simple;
	bh=+zqSAS8c+h2YdQqBmrRHCzOWiPW16rTxiK6b2aWWYns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cf66yKW3TOlgnozE/SLfZEKWf+GpH1UOkt517LAo3NvezmBEPh8Rzx189L3pIjpOKM5BP3xV5nkEfBlRhbrDXn/fEf+i0C4a3aqst9bwri7JX+X67hobJaaf1J/UMooT7JYjWX9EUJdNmiu357+k6ydFt6Ns7nlx7uryKFRIeoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgSUmvNF; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65dead17c24so3671255d50.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214410; x=1779819210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2m7er4d2BdVaVPyBXrLLD0arzZx9JXyiy4RElrDlJo=;
        b=cgSUmvNF2NhmBAppmSXHLjfDTW9NW2y7NnRFiIygJYAOrb25xreTVs4xwhc3q8nPfL
         0Rdv09DTd6bRsGUm/PuIrdycLJtL3bqsrk5q1ffWZ7Hbir9znK42+eFgkmEyDOWL38v8
         tMGjLIKLvM5KP7bj1IGTl7DrdmqZEzvTt9taup6WgzgfgTXA/1f3N7UIQOd6oV0s4AYL
         uqnan2mCysnwflWbkiwdoaeW5fskYUQTvnwUaIKIEnww11ZDdU5IB+0VoNJNQEMtaWKy
         tUKZSp2RK9xa6cdQevOPCuVazivnhmmL46pSccv0i8Je2cAbTrOJvSgRW987tY/MMSHI
         dZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214410; x=1779819210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G2m7er4d2BdVaVPyBXrLLD0arzZx9JXyiy4RElrDlJo=;
        b=C3BiKBMr8SODAt2JwUU7vEp5wCIJGp5tqbnijqaiU6QKIKo+6CWDgDnrVdj84bbMXE
         GmjKB1oK1XG495eLFfCD6LvGQ2dmgQ9GFDQFAUo4GUqjRzqDQ7znGYaOSeU4TDM56YEu
         OHciXOD6FKlJmQ39FfDzja5cF4mdFT96LPGKKUvMgyXqww+oTWLpAXmfMlqggm6dz4k0
         apbnNUyImn3/Vc1/8iQwPgjUy6KuMWJpCcdW8TzqpaZKXgQ3bwYyr57LvSqm6OYvePU6
         i5veBGHu1Hf8AHZVImFBCYaodiUS5f0pc0yDTEQHuFPgdPA1JHhiasGXZCytgL5q5JyE
         aDLw==
X-Gm-Message-State: AOJu0YzM8Lh6AXj8ihWd96+LpTVHrtUFkxDhD6ZIk5J9JypQKwunqJA5
	yjABM6IkrE3Ut1DyNdg9F1w2gtiZUiGXMGNK78Kl7yU/SeyGR6jZDzH+
X-Gm-Gg: Acq92OExTq07OY2f54UIKY/uL6OFivo+oxfVlFfJhM1e99x/clHM2bVs9lJL84OcB1o
	2OVmQOLpXe2TwTGzdtUpiSraTfeUZccaPbrSVEDEaqnhlNJDGeSGAxKWilIYHO9Ou65IOWhc9TY
	SPUabDxAVZIZvrYigo91QtNTV7PrOpw374zoSbQokvYhZK2NF5gsUbsK+rIzCPQ44Pu9YxF0+ir
	8WBc2uuKEOo292Rgw78lOpX2Pghu8kUtKTspqCA2X+S1AN+AB0L16Jw5ShFZmmClq4/Afq8nC37
	fWknAyRwC3U82cBWcxusOyJ+2kkqzCOQU75vU2vzuxJLIGZQRpmeDHrS4HDDjgJifQvqZGhbdOT
	hYSB8Vj9s4rYJ+6BZRi7Zd+kXjPrYOBEjav4+wWKuqI/7kaRdMNSg1/CRyzyaiMdoYYOgKG2YqW
	hq5PLmoz4rKXlf38c=
X-Received: by 2002:a05:690e:4193:b0:64a:db29:5e57 with SMTP id 956f58d0204a3-65e2261ebafmr19167139d50.8.1779214409843;
        Tue, 19 May 2026 11:13:29 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:8::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d658373sm8277363d50.0.2026.05.19.11.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 09/14] bpf: Fold ref_obj_id into id and introduce virtual references
Date: Tue, 19 May 2026 11:13:07 -0700
Message-ID: <20260519181314.2731658-10-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289571-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ref_obj.id:url]
X-Rspamd-Queue-Id: 86F1A5837C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove ref_obj_id from bpf_reg_state by folding its role into the
existing id field. Previously, id tracked pointer identity for null
checking while ref_obj_id tracked the owning reference for lifetime
management. These are now unified: acquire helpers and kfuncs set id
to the acquired reference id, and release paths use id directly.

To handle cases where objects share the same lifetime but need distinct
identities, pointer casting (bpf_sk_fullsock, bpf_tcp_sock) and
referenced dynptr clones, introduce virtual references. A virtual
reference is a bpf_reference_state entry with is_virtual=true that
serves as a lifetime anchor. It has no backing register or stack slot
and exists only in acquired_refs.

For pointer casting, the first cast from a referenced pointer creates a
virtual reference, converts the source to a non-referenced pointer with
parent_id pointing to the virtual ref, and gives the cast result its own
unique id with the same parent_id. Chained casts reuse the same virtual
ref. Each pointer retains a unique id for independent null checking via
mark_ptr_or_null_regs, while releasing any of them releases the shared
virtual ref and invalidates all siblings.

For referenced dynptrs, the constructor creates a virtual reference
instead of a regular one. All clones share the same parent_id (the
virtual ref) but get unique ids for independent slice tracking.
Releasing a referenced dynptr releases the virtual reference, which in
turn invalidates all clones and their derived slices.

The release_reference() DFS is extended to detect virtual refs whose
parent is being released and report them as leaked references, matching
the existing behavior for regular refs encountered during cascading.

Also add reg_is_referenced() which checks if a register is referenced
either directly (id in the reference table) or indirectly (parent_id
points to a virtual ref). This replaces all former ref_obj_id checks.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h                           |   4 +-
 include/linux/bpf_verifier.h                  |  58 +--
 kernel/bpf/btf.c                              |   2 +-
 kernel/bpf/fixups.c                           |   2 +-
 kernel/bpf/log.c                              |  12 +-
 kernel/bpf/states.c                           |   7 +-
 kernel/bpf/verifier.c                         | 392 +++++++++++-------
 .../selftests/bpf/prog_tests/spin_lock.c      |   4 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   4 +-
 .../selftests/bpf/progs/iters_state_safety.c  |   4 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |  12 +-
 11 files changed, 271 insertions(+), 230 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1b28cacc3075..7f3fb57dacf9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1051,7 +1051,7 @@ struct bpf_insn_access_aux {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
-			u32 ref_obj_id;
+			u32 ref_id;
 		};
 	};
 	struct bpf_verifier_log *log; /* for verbose logs */
@@ -1620,7 +1620,7 @@ struct bpf_ctx_arg_aux {
 	enum bpf_reg_type reg_type;
 	struct btf *btf;
 	u32 btf_id;
-	u32 ref_obj_id;
+	u32 ref_id;
 	bool refcounted;
 };
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1391bd0c4259..4aa9424b763e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -147,46 +147,6 @@ struct bpf_reg_state {
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
-	 */
-	u32 ref_obj_id;
 	/* Tracks the parent object this register was derived from.
 	 * Used for cascading invalidation: when the parent object is
 	 * released or invalidated, all registers with matching parent_id
@@ -370,10 +330,17 @@ struct bpf_reference_state {
 	 * is used purely to inform the user of a reference leak.
 	 */
 	int insn_idx;
-	/* Use to keep track of the source object of a lock, to ensure
-	 * it matches on unlock.
-	 */
-	void *ptr;
+	union {
+		/* For REF_TYPE_PTR */
+		struct {
+			int parent_id;
+			bool is_virtual;
+		};
+		/* Use to keep track of the source object of a lock, to ensure
+		 * it matches on unlock.
+		 */
+		void *ptr;
+	};
 };
 
 struct bpf_retval_range {
@@ -1454,7 +1421,6 @@ struct bpf_map_desc {
 struct bpf_dynptr_desc {
 	enum bpf_dynptr_type type;
 	u32 id;
-	u32 ref_obj_id;
 	u32 parent_id;
 };
 
@@ -1466,7 +1432,7 @@ struct bpf_dynptr_desc {
  */
 struct ref_obj_desc {
 	u32 id;
-	u32 ref_obj_id;
+	u32 parent_id;
 	u8 cnt;
 };
 
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
index 52535671cb9a..a9946625a4a8 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -870,7 +870,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 		case PTR_TO_BTF_ID:
 		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
 		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
-		 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
+		 * PTR_TO_BTF_ID, and an active id, but the same cannot
 		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
 		 * any faults for loads into such types. BPF_WRITE is disallowed
 		 * for this case.
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index a4e86cfc7ef9..b740fa73ee26 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -665,8 +665,6 @@ static void print_reg_state(struct bpf_verifier_env *env,
 		verbose_a("id=%d", reg->id & ~BPF_ADD_CONST);
 	if (reg->id & BPF_ADD_CONST)
 		verbose(env, "%+d", reg->delta);
-	if (reg->ref_obj_id)
-		verbose_a("ref_obj_id=%d", reg->ref_obj_id);
 	if (reg->parent_id)
 		verbose_a("parent_id=%d", reg->parent_id);
 	if (type_is_non_owning_ref(reg->type))
@@ -770,21 +768,19 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 			verbose(env, "=dynptr_%s(", dynptr_type_str(reg->dynptr.type));
 			if (reg->id)
 				verbose_a("id=%d", reg->id);
-			if (reg->ref_obj_id)
-				verbose_a("ref_obj_id=%d", reg->ref_obj_id);
 			if (reg->parent_id)
 				verbose_a("parent_id=%d", reg->parent_id);
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
index 6103c3bea620..5945956a7573 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -489,7 +489,6 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 {
 	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 	       check_ids(rold->id, rcur->id, idmap) &&
-	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap) &&
 	       check_ids(rold->parent_id, rcur->parent_id, idmap);
 }
 
@@ -615,7 +614,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		       range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off) &&
 		       check_ids(rold->id, rcur->id, idmap) &&
-		       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap) &&
 		       check_ids(rold->parent_id, rcur->parent_id, idmap);
 	case PTR_TO_PACKET_META:
 	case PTR_TO_PACKET:
@@ -797,7 +795,6 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			if (old_reg->dynptr.type != cur_reg->dynptr.type ||
 			    old_reg->dynptr.first_slot != cur_reg->dynptr.first_slot ||
 			    !check_ids(old_reg->id, cur_reg->id, idmap) ||
-			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap) ||
 			    !check_ids(old_reg->parent_id, cur_reg->parent_id, idmap))
 				return false;
 			break;
@@ -814,13 +811,13 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
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
index c4b4b1dfdfda..b7984c42ca14 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -201,13 +201,16 @@ struct bpf_verifier_stack_elem {
 #define BPF_PRIV_STACK_MIN_SIZE		64
 
 static int acquire_reference(struct bpf_verifier_env *env, int insn_idx);
-static int release_reference_nomark(struct bpf_verifier_state *state, int ref_obj_id);
-static int release_reference(struct bpf_verifier_env *env, int id);
+static int acquire_virtual_reference(struct bpf_verifier_env *env, int insn_idx, int parent_id);
+static struct bpf_reference_state *find_reference_state(struct bpf_verifier_state *state, int ptr_id);
+static int release_reference_nomark(struct bpf_verifier_state *state, int id);
+static int release_reference(struct bpf_verifier_env *env, struct bpf_reg_state *reg, bool release_v_parent);
+static int validate_ref_obj(struct bpf_verifier_env *env, struct ref_obj_desc *ref_obj);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg);
-static bool is_trusted_reg(const struct bpf_reg_state *reg);
+static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg);
 static inline bool in_sleepable_context(struct bpf_verifier_env *env);
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
 static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
@@ -234,7 +237,7 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
 static void update_ref_obj(struct ref_obj_desc *ref_obj, struct bpf_reg_state *reg)
 {
 	ref_obj->id = reg->id;
-	ref_obj->ref_obj_id = reg->ref_obj_id;
+	ref_obj->parent_id = reg->parent_id;
 	ref_obj->cnt++;
 }
 
@@ -260,7 +263,6 @@ struct bpf_call_arg_meta {
 	int access_size;
 	int mem_size;
 	u64 msize_max_value;
-	int ref_obj_id;
 	u32 id;
 	int func_id;
 	struct btf *btf;
@@ -359,7 +361,7 @@ static void verbose_invalid_scalar(struct bpf_verifier_env *env,
 	verbose(env, " should have been in [%d, %d]\n", range.minval, range.maxval);
 }
 
-static bool reg_not_null(const struct bpf_reg_state *reg)
+static bool reg_not_null(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
 {
 	enum bpf_reg_type type;
 
@@ -373,7 +375,7 @@ static bool reg_not_null(const struct bpf_reg_state *reg)
 		type == PTR_TO_MAP_VALUE ||
 		type == PTR_TO_MAP_KEY ||
 		type == PTR_TO_SOCK_COMMON ||
-		(type == PTR_TO_BTF_ID && is_trusted_reg(reg)) ||
+		(type == PTR_TO_BTF_ID && is_trusted_reg(env, reg)) ||
 		(type == PTR_TO_MEM && !(reg->type & PTR_UNTRUSTED)) ||
 		type == CONST_PTR_TO_MAP;
 }
@@ -652,23 +654,23 @@ static bool dynptr_type_referenced(enum bpf_dynptr_type type)
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg,
 			      enum bpf_dynptr_type type,
-			      bool first_slot, int id, int ref_obj_id, int parent_id);
+			      bool first_slot, int id, int parent_id);
 
 
 static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *sreg1,
 				   struct bpf_reg_state *sreg2,
-				   enum bpf_dynptr_type type, int id, int ref_obj_id, int parent_id)
+				   enum bpf_dynptr_type type, int id, int parent_id)
 {
-	__mark_dynptr_reg(sreg1, type, true, id, ref_obj_id, parent_id);
-	__mark_dynptr_reg(sreg2, type, false, id, ref_obj_id, parent_id);
+	__mark_dynptr_reg(sreg1, type, true, id, parent_id);
+	__mark_dynptr_reg(sreg2, type, false, id, parent_id);
 }
 
 static void mark_dynptr_cb_reg(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg,
 			       enum bpf_dynptr_type type)
 {
-	__mark_dynptr_reg(reg, type, true, ++env->id_gen, 0, 0);
+	__mark_dynptr_reg(reg, type, true, ++env->id_gen, 0);
 }
 
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
@@ -679,7 +681,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 				   struct ref_obj_desc *ref_obj, struct bpf_dynptr_desc *dynptr)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
-	int spi, i, err, ref_obj_id = 0, parent_id = 0;
+	int spi, i, err, parent_id = 0;
 	enum bpf_dynptr_type type;
 
 	spi = dynptr_get_spi(env, reg);
@@ -717,20 +719,27 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 			return err;
 
 		if (dynptr_type_referenced(type)) {
-			ref_obj_id = acquire_reference(env, insn_idx);
-			if (ref_obj_id < 0)
-				return ref_obj_id;
-		}
+			int v_parent_id;
+
+			/*
+			 * Create a virtual reference that tracks the referenced object for
+			 * referenced dynptr. Freeing a referenced dynptr through helpers/kfuncs
+			 * will invalidate all clones.
+			 */
+			v_parent_id = acquire_virtual_reference(env, insn_idx, ref_obj->id);
+			if (v_parent_id < 0)
+				return v_parent_id;
 
-		/* Track parent's id if the parent is a referenced object */
-		parent_id = ref_obj->id;
+			parent_id = v_parent_id;
+		} else {
+			parent_id = ref_obj->id;
+		}
 	} else { /* bpf_dynptr_clone() */
-		ref_obj_id = dynptr->ref_obj_id;
 		parent_id = dynptr->parent_id;
 	}
 
 	mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
-			       &state->stack[spi - 1].spilled_ptr, type, ++env->id_gen, ref_obj_id, parent_id);
+			       &state->stack[spi - 1].spilled_ptr, type, ++env->id_gen, parent_id);
 
 	return 0;
 }
@@ -758,13 +767,12 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 		return spi;
 
 	/*
-	 * For referenced dynptr, the clones share the same ref_obj_id and will be
-	 * invalidated too. For non-referenced dynptr, only the dynptr and slices
-	 * derived from it will be invalidated.
+	 * For referenced dynptr, release the virtual ref (parent_id) which
+	 * cascades to all clones and derived slices. For non-referenced dynptr,
+	 * only the dynptr and slices derived from it will be invalidated.
 	 */
 	reg = &state->stack[spi].spilled_ptr;
-	return release_reference(env, dynptr_type_referenced(reg->dynptr.type) ?
-				      reg->ref_obj_id : reg->id);
+	return release_reference(env, reg, true);
 }
 
 static void __mark_reg_unknown(const struct bpf_verifier_env *env,
@@ -796,12 +804,12 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 		spi = spi + 1;
 
 	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type)) {
-		int ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
+		int v_parent_id = state->stack[spi].spilled_ptr.parent_id;
 		int ref_cnt = 0;
 
 		/*
 		 * A referenced dynptr can be overwritten only if there is at
-		 * least one other dynptr sharing the same ref_obj_id,
+		 * least one other dynptr sharing the same virtual ref parent,
 		 * ensuring the reference can still be properly released.
 		 */
 		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
@@ -809,7 +817,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				continue;
 			if (!state->stack[i].spilled_ptr.dynptr.first_slot)
 				continue;
-			if (state->stack[i].spilled_ptr.ref_obj_id == ref_obj_id)
+			if (state->stack[i].spilled_ptr.parent_id == v_parent_id)
 				ref_cnt++;
 		}
 
@@ -817,14 +825,10 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 			verbose(env, "cannot overwrite referenced dynptr\n");
 			return -EINVAL;
 		}
-
-
-		invalidate_dynptr(env, &state->stack[spi - 1]);
-	} else {
-		/* Invalidate the dynptr and any derived slices */
-		err = release_reference(env, state->stack[spi].spilled_ptr.id);
 	}
 
+	/* Invalidate the dynptr and any derived slices */
+	err = release_reference(env, &state->stack[spi].spilled_ptr, false);
 	if (!err) {
 		mark_stack_slot_scratched(env, spi);
 		mark_stack_slot_scratched(env, spi - 1);
@@ -946,7 +950,7 @@ static int mark_stack_slots_iter(struct bpf_verifier_env *env,
 			else
 				st->type |= PTR_UNTRUSTED;
 		}
-		st->ref_obj_id = i == 0 ? id : 0;
+		st->id = i == 0 ? id : 0;
 		st->iter.btf = btf;
 		st->iter.btf_id = btf_id;
 		st->iter.state = BPF_ITER_STATE_ACTIVE;
@@ -976,7 +980,7 @@ static int unmark_stack_slots_iter(struct bpf_verifier_env *env,
 		struct bpf_reg_state *st = &slot->spilled_ptr;
 
 		if (i == 0)
-			WARN_ON_ONCE(release_reference(env, st->ref_obj_id));
+			WARN_ON_ONCE(release_reference(env, st, true));
 
 		bpf_mark_reg_not_init(env, st);
 
@@ -1032,10 +1036,10 @@ static int is_iter_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_s
 
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
@@ -1074,7 +1078,7 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 
 	__mark_reg_known_zero(st);
 	st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
-	st->ref_obj_id = id;
+	st->id = id;
 	st->irq.kfunc_class = kfunc_class;
 
 	for (i = 0; i < BPF_REG_SIZE; i++)
@@ -1108,7 +1112,7 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 		return -EINVAL;
 	}
 
-	err = release_irq_state(env->cur_state, st->ref_obj_id);
+	err = release_irq_state(env->cur_state, st->id);
 	WARN_ON_ONCE(err && err != -EACCES);
 	if (err) {
 		int insn_idx = 0;
@@ -1172,7 +1176,7 @@ static int is_irq_flag_reg_valid_init(struct bpf_verifier_env *env, struct bpf_r
 	slot = &state->stack[spi];
 	st = &slot->spilled_ptr;
 
-	if (!st->ref_obj_id)
+	if (!st->id)
 		return -EINVAL;
 
 	for (i = 0; i < BPF_REG_SIZE; i++)
@@ -1425,6 +1429,33 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)
 	return s->id;
 }
 
+/*
+ * A virtual reference has no backing register or stack slot — it exists only as an entry in
+ * env->cur_state->refs. It serves as a lifetime anchor for objects that share the same
+ * lifetime but need distinct identities (e.g., pointer casting results, referenced dynptr
+ * clones).
+ *
+ * A register derived from a virtual reference has its parent_id points to the virtual
+ * reference. The register in this case is also considered referenced, just like one whose
+ * id is directly in the reference table. Use reg_is_referenced() to check for both cases.
+ *
+ * Releasing such a register releases the virtual reference, which in turn invalidates all
+ * objects derived from that virtual reference and their children.
+ */
+static int acquire_virtual_reference(struct bpf_verifier_env *env, int insn_idx, int parent_id)
+{
+	struct bpf_reference_state *s;
+
+	s = acquire_reference_state(env, insn_idx);
+	if (!s)
+		return -ENOMEM;
+	s->type = REF_TYPE_PTR;
+	s->id = ++env->id_gen;
+	s->parent_id = parent_id;
+	s->is_virtual = true;
+	return s->id;
+}
+
 static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum ref_state_type type,
 			      int id, void *ptr)
 {
@@ -1489,6 +1520,23 @@ static struct bpf_reference_state *find_reference_state(struct bpf_verifier_stat
 	return NULL;
 }
 
+static bool reg_is_referenced(struct bpf_verifier_env *env,
+			      const struct bpf_reg_state *reg)
+{
+	struct bpf_reference_state *s;
+
+	s = find_reference_state(env->cur_state, reg->id);
+	if (s)
+		return true;
+
+	if (reg->parent_id) {
+		s = find_reference_state(env->cur_state, reg->parent_id);
+		if (s && s->is_virtual)
+			return true;
+	}
+	return false;
+}
+
 static int release_lock_state(struct bpf_verifier_state *state, int type, int id, void *ptr)
 {
 	void *prev_ptr = NULL;
@@ -1802,7 +1850,6 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	memset(((u8 *)reg) + sizeof(reg->type), 0,
 	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
 	reg->id = 0;
-	reg->ref_obj_id = 0;
 	reg->parent_id = 0;
 	___mark_reg_known(reg, imm);
 }
@@ -1838,7 +1885,7 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
 }
 
 static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type type,
-			      bool first_slot, int id, int ref_obj_id, int parent_id)
+			      bool first_slot, int id, int parent_id)
 {
 	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
 	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so simply
@@ -1848,7 +1895,6 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type ty
 	reg->type = CONST_PTR_TO_DYNPTR;
 	/* Give each dynptr a unique id to uniquely associate slices to it. */
 	reg->id = id;
-	reg->ref_obj_id = ref_obj_id;
 	reg->parent_id = parent_id;
 	reg->dynptr.type = type;
 	reg->dynptr.first_slot = first_slot;
@@ -4293,7 +4339,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	 * referenced PTR_TO_BTF_ID, and that its fixed offset is 0. For the
 	 * normal store of unreferenced kptr, we must ensure var_off is zero.
 	 * Since ref_ptr cannot be accessed directly by BPF insns, check for
-	 * reg->ref_obj_id is not needed here.
+	 * reg->id is not needed here.
 	 */
 	if (__check_ptr_off_reg(env, reg, argno_from_reg(regno), true))
 		return -EACCES;
@@ -4666,8 +4712,8 @@ static int __check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int of
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
@@ -4836,10 +4882,10 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
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
@@ -5753,7 +5799,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		ret = env->ops->btf_struct_access(&env->log, reg, off, size);
 	} else {
 		/* Writes are permitted with default btf_struct_access for
-		 * program allocated objects (which always have ref_obj_id > 0),
+		 * program allocated objects (which always have id > 0),
 		 * but not for untrusted PTR_TO_BTF_ID | MEM_ALLOC.
 		 */
 		if (atype != BPF_READ && !type_is_ptr_alloc_obj(reg->type)) {
@@ -5762,8 +5808,8 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		}
 
 		if (type_is_alloc(reg->type) && !type_is_non_owning_ref(reg->type) &&
-		    !(reg->type & MEM_RCU) && !reg->ref_obj_id) {
-			verifier_bug(env, "ref_obj_id for allocated object must be non-zero");
+		    !(reg->type & MEM_RCU) && !reg_is_referenced(env, reg)) {
+			verifier_bug(env, "allocated object must have a referenced id");
 			return -EFAULT;
 		}
 
@@ -5782,7 +5828,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		 */
 		flag = PTR_UNTRUSTED;
 
-	} else if (is_trusted_reg(reg) || is_rcu_reg(reg)) {
+	} else if (is_trusted_reg(env, reg) || is_rcu_reg(reg)) {
 		/* By default any pointer obtained from walking a trusted pointer is no
 		 * longer trusted, unless the field being accessed has explicitly been
 		 * marked as inheriting its parent's state of trust (either full or RCU).
@@ -6180,8 +6226,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 				if (base_type(info.reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = info.btf;
 					regs[value_regno].btf_id = info.btf_id;
-					regs[value_regno].id = info.ref_obj_id;
-					regs[value_regno].ref_obj_id = info.ref_obj_id;
+					regs[value_regno].id = info.ref_id;
 				}
 				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
 					regs[value_regno].id = ++env->id_gen;
@@ -7266,7 +7311,6 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 		if (dynptr) {
 			dynptr->type = reg->dynptr.type;
 			dynptr->id = reg->id;
-			dynptr->ref_obj_id = reg->ref_obj_id;
 			dynptr->parent_id = reg->parent_id;
 		}
 	}
@@ -7960,7 +8004,7 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	/* When referenced register is passed to release function, its fixed
 	 * offset must be 0.
 	 *
-	 * We will check arg_type_is_release reg has ref_obj_id when storing
+	 * We will check arg_type_is_release reg has id when storing
 	 * meta->release_regno.
 	 */
 	if (arg_type_is_release(arg_type)) {
@@ -8211,13 +8255,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
 skip_type_check:
 	if (arg_type_is_release(arg_type) && !arg_type_is_dynptr(arg_type) &&
-	    !reg->ref_obj_id && !bpf_register_is_null(reg)) {
+	    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
 		verbose(env, "release helper %s expects referenced PTR_TO_BTF_ID passed to %s\n",
 			func_id_name(meta->func_id), reg_arg_name(env, argno));
 		return -EINVAL;
 	}
 
-	if (reg->ref_obj_id)
+	if (reg_is_referenced(env, reg))
 		update_ref_obj(&meta->ref_obj, reg);
 
 	switch (base_type(arg_type)) {
@@ -8846,14 +8890,14 @@ static void mark_pkt_end(struct bpf_verifier_state *vstate, int regn, bool range
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
@@ -8887,16 +8931,25 @@ static int idstack_pop(struct bpf_idmap *idmap)
 	return idmap->map[--idmap->cnt].old;
 }
 
-/* Release id and objects referencing the id iteratively in a DFS manner */
-static int release_reference(struct bpf_verifier_env *env, int id)
+/* Release id and objects derived from it iteratively in a DFS manner */
+static int release_reference(struct bpf_verifier_env *env, struct bpf_reg_state *reg, bool release_v_parent)
 {
 	u32 mask = (1 << STACK_SPILL) | (1 << STACK_DYNPTR);
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_idmap *idstack = &env->idmap_scratch;
+	struct bpf_reference_state *ref;
 	struct bpf_stack_state *stack;
 	struct bpf_func_state *state;
-	struct bpf_reg_state *reg;
-	int root_id = id, err;
+	int i, id, root_id, err;
+
+	/* Free the parent virtual reference if the reg is derived from it */
+	id = reg->id;
+	if (reg->parent_id && release_v_parent) {
+		ref = find_reference_state(env->cur_state, reg->parent_id);
+		if (ref && ref->is_virtual)
+			id = reg->parent_id;
+	}
+	root_id = id;
 
 	idstack->cnt = 0;
 	idstack_push(idstack, id);
@@ -8906,13 +8959,13 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 
 	while ((id = idstack_pop(idstack))) {
 		bpf_for_each_reg_in_vstate_mask(vstate, state, reg, stack, mask, ({
-			if (reg->id != id && reg->parent_id != id && reg->ref_obj_id != id)
+			if (reg->id != id && reg->parent_id != id)
 				continue;
 
-			if (reg->ref_obj_id && reg->ref_obj_id != root_id) {
+			if (find_reference_state(env->cur_state, reg->id) && reg->id != root_id) {
 				struct bpf_reference_state *ref_state;
 
-				ref_state = find_reference_state(env->cur_state, reg->ref_obj_id);
+				ref_state = find_reference_state(env->cur_state, reg->id);
 				verbose(env, "Leaking reference id=%d alloc_insn=%d. Release it first.\n",
 					ref_state->id, ref_state->insn_idx);
 				return -EINVAL;
@@ -8930,6 +8983,19 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 			else if (stack->slot_type[BPF_REG_SIZE - 1] == STACK_DYNPTR)
 				invalidate_dynptr(env, stack);
 		}));
+
+		/* Check for virtual refs whose parent is being released */
+		for (i = 0; i < vstate->acquired_refs; i++) {
+			if (vstate->refs[i].type != REF_TYPE_PTR)
+				continue;
+			if (!vstate->refs[i].is_virtual)
+				continue;
+			if (vstate->refs[i].parent_id != id)
+				continue;
+			verbose(env, "Leaking reference id=%d alloc_insn=%d. Release it first.\n",
+				vstate->refs[i].id, vstate->refs[i].insn_idx);
+			return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -8961,19 +9027,19 @@ static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
 	}));
 }
 
-static int ref_convert_alloc_rcu_protected(struct bpf_verifier_env *env, u32 ref_obj_id)
+static int ref_convert_alloc_rcu_protected(struct bpf_verifier_env *env, u32 id)
 {
 	struct bpf_func_state *state;
 	struct bpf_reg_state *reg;
 	int err;
 
-	err = release_reference_nomark(env->cur_state, ref_obj_id);
+	err = release_reference_nomark(env->cur_state, id);
 
 	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
-		if (reg->ref_obj_id != ref_obj_id)
+		if (reg->id != id)
 			continue;
 		if ((reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU)) {
-			reg->ref_obj_id = 0;
+			reg->id = 0;
 			reg->type &= ~MEM_ALLOC;
 			reg->type |= MEM_RCU;
 		}
@@ -9854,7 +9920,7 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 		 * kernel. Type checks are performed later in check_return_code.
 		 */
 		if (type == BPF_PROG_TYPE_STRUCT_OPS && !exception_exit &&
-		    reg->ref_obj_id == state->refs[i].id)
+		    reg->id == state->refs[i].id)
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
@@ -10045,18 +10111,63 @@ static int release_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 {
 	int err = -EINVAL;
 
-	if (release_dynptr)
+	if (release_dynptr) {
 		err = unmark_stack_slots_dynptr(env, reg);
-	else if (convert_rcu)
-		err = ref_convert_alloc_rcu_protected(env, reg->ref_obj_id);
-	else if (reg->ref_obj_id)
-		err = release_reference(env, reg->ref_obj_id);
-	else if (bpf_register_is_null(reg))
+	} else if (convert_rcu) {
+		err = ref_convert_alloc_rcu_protected(env, reg->id);
+	} else if (reg_is_referenced(env, reg)) {
+		err = release_reference(env, reg, true);
+	} else if (bpf_register_is_null(reg)) {
 		err = 0;
+	}
 
 	return err;
 }
 
+/*
+ * Pointer casting helpers (bpf_sk_fullsock, bpf_tcp_sock, etc.) return a different view
+ * of the same kernel object. All casted pointers share the same lifetime as the original.
+ *
+ * Use a virtual reference as a lifetime anchor: the original pointer and all cast results
+ * get parent_id = V (the virtual reference). Each gets a unique non-referenced id for
+ * independent null-checking. Releasing any of them releases V, which in turn invalidates
+ * all siblings.
+ */
+static int cast_from_ref_obj(struct bpf_verifier_env *env, struct ref_obj_desc *ref_obj)
+{
+	struct bpf_reference_state *ref;
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+	int err, v_parent_id = 0;
+
+	err = validate_ref_obj(env, ref_obj);
+	if (err)
+		return err;
+
+	ref = find_reference_state(env->cur_state, ref_obj->id);
+	if (ref) {
+		/*
+		 * First cast from a referenced ptr: Create a virtual reference, grafted the
+		 * referenced objects to it and convert to non-referenced
+		 */
+		v_parent_id = acquire_virtual_reference(env, ref->insn_idx, 0);
+		if (v_parent_id < 0)
+			return v_parent_id;
+
+		release_reference_nomark(env->cur_state, ref_obj->id);
+
+		bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
+			if (reg->id == ref_obj->id)
+				reg->parent_id = v_parent_id;
+		}));
+	} else {
+		/* Subsequent casts: return the already created virtual reference */
+		v_parent_id = ref_obj->parent_id;
+	}
+
+	return v_parent_id;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -10155,7 +10266,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		bool convert_rcu = (func_id == BPF_FUNC_kptr_xchg) && in_rcu_cs(env) &&
 				   (reg->type & MEM_ALLOC) && (reg->type & MEM_PERCPU);
 
-		err = release_reg(env, reg, convert_rcu, !!meta.dynptr.ref_obj_id);
+		err = release_reg(env, reg, convert_rcu, !!meta.dynptr.id);
 		if (err)
 			return err;
 	}
@@ -10417,20 +10528,19 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].id = ++env->id_gen;
 
 	if (is_ptr_cast_function(func_id)) {
-		/* For release_reference() */
-		err = validate_ref_obj(env, &meta.ref_obj);
-		if (err)
-			return err;
-		regs[BPF_REG_0].ref_obj_id = meta.ref_obj.ref_obj_id;
+		int parent_id = cast_from_ref_obj(env, &meta.ref_obj);
+
+		if (parent_id < 0)
+			return parent_id;
+
+		regs[BPF_REG_0].parent_id = parent_id;
 	} else if (is_acquire_function(func_id, meta.map.ptr)) {
 		int id = acquire_reference(env, insn_idx);
 
 		if (id < 0)
 			return id;
-		/* For mark_ptr_or_null_reg() */
+
 		regs[BPF_REG_0].id = id;
-		/* For release_reference() */
-		regs[BPF_REG_0].ref_obj_id = id;
 	}
 
 	if (func_id == BPF_FUNC_dynptr_data)
@@ -11225,7 +11335,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	 * btf_struct_ids_match() to walk the struct at the 0th offset, and
 	 * resolve types.
 	 */
-	if ((is_kfunc_release(meta) && reg->ref_obj_id) ||
+	if ((is_kfunc_release(meta) && reg_is_referenced(env, reg)) ||
 	    btf_type_ids_nocast_alias(&env->log, reg_btf, reg_ref_id, meta->btf, ref_id))
 		strict_type_match = true;
 
@@ -11329,36 +11439,21 @@ static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state
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
-
-	for (i = 0; i < state->acquired_refs; i++) {
-		if (state->refs[i].id != ref_obj_id)
-			continue;
+	WARN_ON_ONCE(release_reference_nomark(env->cur_state, id));
 
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
@@ -11884,13 +11979,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		}
 
 		if (regno == meta->release_regno && !is_kfunc_arg_dynptr(meta->btf, &args[i]) &&
-		    !reg->ref_obj_id && !bpf_register_is_null(reg)) {
+		    !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
 			verbose(env, "release kfunc %s expects referenced PTR_TO_BTF_ID passed to %s\n",
 				func_name, reg_arg_name(env, argno));
 			return -EINVAL;
 		}
 
-		if (reg->ref_obj_id)
+		if (reg_is_referenced(env, reg))
 			update_ref_obj(&meta->ref_obj, reg);
 
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
@@ -11943,7 +12038,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			fallthrough;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
-			if (!is_trusted_reg(reg)) {
+			if (!is_trusted_reg(env, reg)) {
 				if (!is_kfunc_rcu(meta)) {
 					verbose(env, "%s must be referenced or trusted\n",
 						reg_arg_name(env, argno));
@@ -12022,7 +12117,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (!reg->ref_obj_id) {
+			if (!reg_is_referenced(env, reg)) {
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
@@ -12084,7 +12179,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id) {
+			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) &&
+			    !reg_is_referenced(env, reg)) {
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
@@ -12099,7 +12195,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) && !reg->ref_obj_id) {
+			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC) &&
+			    !reg_is_referenced(env, reg)) {
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
@@ -12113,7 +12210,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (!reg->ref_obj_id) {
+			if (!reg_is_referenced(env, reg)) {
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
@@ -12128,12 +12225,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -12728,13 +12826,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
 
@@ -12883,28 +12981,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
 	if (meta.release_regno) {
-		err = release_reg(env, &regs[meta.release_regno], false, !!meta.dynptr.ref_obj_id);
+		err = release_reg(env, &regs[meta.release_regno], false, !!meta.dynptr.id);
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
-		err = release_reference_nomark(env->cur_state, release_ref_obj_id);
-		if (err) {
-			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
-				func_name, meta.func_id);
-			return err;
-		}
+		ref_convert_owning_non_owning(env, id);
 	}
 
 	if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
@@ -12989,11 +13075,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				regs[BPF_REG_0].type |= MEM_RDONLY;
 
 			/* Ensures we don't access the memory after a release_reference() */
-			if (meta.ref_obj.ref_obj_id) {
+			if (meta.ref_obj.id) {
 				err = validate_ref_obj(env, &meta.ref_obj);
 				if (err)
 					return err;
-				regs[BPF_REG_0].parent_id = meta.ref_obj.ref_obj_id;
+				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
 			}
 
 			if (is_kfunc_rcu_protected(&meta))
@@ -13040,13 +13126,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
-			int id = acquire_reference(env, insn_idx);
-
+			id = acquire_reference(env, insn_idx);
 			if (id < 0)
 				return id;
-			if (is_kfunc_ret_null(&meta))
-				regs[BPF_REG_0].id = id;
-			regs[BPF_REG_0].ref_obj_id = id;
+			regs[BPF_REG_0].id = id;
 		} else if (is_rbtree_node_type(ptr_type) || is_list_node_type(ptr_type)) {
 			ref_set_non_owning(env, &regs[BPF_REG_0]);
 		}
@@ -15277,7 +15360,7 @@ static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *r
 		if (!is_reg_const(reg2, is_jmp32))
 			return -1;
 
-		if (!reg_not_null(reg1))
+		if (!reg_not_null(env, reg1))
 			return -1;
 
 		/* If pointer is valid tests against zero will fail so we can
@@ -15494,7 +15577,7 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 		    WARN_ON_ONCE(!tnum_equals_const(reg->var_off, 0)))
 			return;
 		if (is_null) {
-			/* We don't need id and ref_obj_id from this point
+			/* We don't need id from this point
 			 * onwards anymore, thus we should better reset it,
 			 * so that state pruning has chances to take effect.
 			 */
@@ -15521,10 +15604,9 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
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
@@ -16363,7 +16445,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		ret_type = btf_type_resolve_ptr(prog->aux->attach_btf,
 						prog->aux->attach_func_proto->type,
 						NULL);
-		if (ret_type && ret_type == reg_type && reg->ref_obj_id)
+		if (ret_type && ret_type == reg_type && reg_is_referenced(env, reg))
 			return __check_ptr_off_reg(env, reg, argno_from_reg(regno), false);
 	}
 
@@ -18232,7 +18314,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				mark_reg_unknown(env, regs, i);
 			} else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
 				/* assume unspecial LOCAL dynptr type */
-				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen, 0, 0);
+				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen, 0);
 			} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
 				reg->type = PTR_TO_MEM;
 				reg->type |= arg->arg_type &
@@ -18291,8 +18373,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	/* Acquire references for struct_ops program arguments tagged with "__ref" */
 	if (!subprog && env->prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
 		for (i = 0; i < aux->ctx_arg_info_size; i++)
-			aux->ctx_arg_info[i].ref_obj_id = aux->ctx_arg_info[i].refcounted ?
-							  acquire_reference(env, 0) : 0;
+			aux->ctx_arg_info[i].ref_id = aux->ctx_arg_info[i].refcounted ?
+						      acquire_reference(env, 0) : 0;
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
index 96e23c79560b..40a14a5174a5 100644
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


