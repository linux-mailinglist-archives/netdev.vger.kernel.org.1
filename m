Return-Path: <netdev+bounces-289574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEjjBJOoDGoIkgUAu9opvQ
	(envelope-from <netdev+bounces-289574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:14:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B53DD583804
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 288C6307D037
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C2033F8A1;
	Tue, 19 May 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zuv4Hmr4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3F33FE2F
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214416; cv=none; b=GQRXU9dckgihljZ1GBEzWenPklLug/OqTPP9Vn9tHQgCbb2F9Evo3usDxzhmGAgJGtP35hfUwXDk5+0cxwUsqbtvG2R0wQekn/RJyUlg0uAqI+z31Dd//Y9uPNE70qpnbABKPCfRi0ierJvW9WVDlb6lxAzgyh9ou1U822yaJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214416; c=relaxed/simple;
	bh=CbH0GQGnrqtdv+IXNXwA+lMpTJgcvOCY20p6I9jjt2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LY6sKAzBkLyM9N9oVfm/oz9vF0WSwN6ah9mYwtGxBN3AMf4Yyvv9m+I7RVZZCShn1vtkxGtCM4JbD9BCOgXklxLzQd/HPLKg3r93Yrw4DBLazM25TnYkowik+6TWzUGF/snIGmfgs6As5OY3mjjtUCtKErwb62TQzLuq4s3MANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zuv4Hmr4; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6530287803cso4050614d50.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214412; x=1779819212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0yAWHTYUvXRF9uWUqsfdJogZ4AYkoOMfCE+mxoxLKA=;
        b=Zuv4Hmr4pluZhDh4pnJA1IIVWXSWfw+GPIXOIPHErZgKRq2PAvSuj6JHJWohBNk/mO
         loCTjvNTcqpAgbKhJEaM5m+IVYxVlj7gR/APuMcCuO6mPWY/PEkXKYIHoosX4LzKzwch
         Zk0AXQ/QxFIyxyCZoeSeD8TBFeLhkO0AN9Uo3hd7Po3Sp/F0nlo4wkOGCHyqoeSO/21h
         847DouI+zyzE0SAbrbJPGNNjlmwpRlAaWzbmB5ndXR5AtocvxHr1jq8CeBCENcff4kLe
         0ejTL5E0bRpGXthZs6EEhw4X71H2nGp7F9qrf31wNETyf8zHhf49kiabRI3e/+Ji3hJO
         ux7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214412; x=1779819212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d0yAWHTYUvXRF9uWUqsfdJogZ4AYkoOMfCE+mxoxLKA=;
        b=U3zAPzPlhbA+Mc+L86s/yhLZoqBQwsrE1cGrqNYne9nKFFMgj6nA3oEvS11ioHyhxH
         l+pq9xMkDI4F4uqBSAx4GCollQpvTQ/8rfHLL3UDvvBSWgIi0VLR5auuDFc2J3X0flrw
         oQX8Qrialrj51GZy7CtpLugrOksQIA0AYxwEQDmu5S+gbdMbZTKecWniIKHOJi2Oo+xD
         bLRakzthn2Q0pWRARNrzXMInMDD0JTbY0bNPHkSUmJ8zJyy/kqohcC4GlZKoSUr61OA4
         4sPtqs3smu/MNOCl7wjMLHYoqJcgWlysB37kIi+vnyl8xIakzUz3Tm2VjqpWs9++OoI4
         Qj2Q==
X-Gm-Message-State: AOJu0Yy2y6t9RIgSCy8lJ7a6FxxrkgKnIO1QiLIER+H7YdImh2naaAWX
	nDKKGVprcLcchtOKCxaB1KUlBXRjeAIYDLXd05wZ3Aln8OZ+PrRwnZn2kCg3T1Cm
X-Gm-Gg: Acq92OFcoEJLRFgW/mu+P4DmeEyZLe9pfb2Htlk07TLAi3QUq05PFumH5LPFr6nt7+K
	yyNMqmDScE6GsS1sScb3waqt2cqO5088Mi1Z5aDg7ZscEQbvZVUKvswb+weJoOsrNYE6IH2Na0a
	G6oUyA7t0KLrXO5F0asiKUEH9G9dQ1aI79dofubWnEhDSnQd2itimjaoEQ6a2chUNk+kpng4Ugd
	N/QvB1HFQDipCubopTl/FUXYa59BxyZ/ag9ZbgDuZSmNA2apRWPgEqdjW10zJh8T5MHv+vQBDyr
	hd7lq4su21EnOpXC5gwlJywlxzqy97rKHLso1M7ivPCA9jA5d7ictDI441DYXBNRUURZ7nRN/HB
	aj2+EVBx6CvgB+54++hN4EJKk8HCEeRr9qmPQBwQT6sM43/PzAEuaTFwL7D1AX77FKRpXrXrV9a
	NaG5pyB6kcSFXk07/nK4Z7YUvHqV4=
X-Received: by 2002:a53:c043:0:10b0:654:5120:60aa with SMTP id 956f58d0204a3-65e228060a4mr16888047d50.45.1779214411475;
        Tue, 19 May 2026 11:13:31 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:51::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0dbd101asm8138986d50.19.2026.05.19.11.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 10/14] bpf: Fix dynptr ref counting to scan all call frames
Date: Tue, 19 May 2026 11:13:08 -0700
Message-ID: <20260519181314.2731658-11-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289574-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: B53DD583804
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When checking whether a referenced dynptr can be overwritten,
destroy_if_dynptr_stack_slot only counted sibling dynptrs in the
current call frame. If a clone sharing the same virtual ref parent
existed in a different frame (e.g., passed to a subprog), it would
not be counted, causing the verifier to incorrectly reject the
overwrite with "cannot overwrite referenced dynptr".

Fix by extracting the counting into dynptr_ref_cnt() which uses
bpf_for_each_reg_in_vstate_mask() to scan dynptr stack slots across
all call frames.

Fixes: 017f5c4ef73c ("bpf: Allow overwriting referenced dynptr when refcnt > 1")
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 52 +++++++++++--------
 .../selftests/bpf/progs/wakeup_source_fail.c  |  2 +-
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b7984c42ca14..97eb8033d732 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -786,10 +786,29 @@ static void mark_reg_invalid(const struct bpf_verifier_env *env, struct bpf_reg_
 		__mark_reg_unknown(env, reg);
 }
 
+static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
+{
+	struct bpf_stack_state *stack;
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+	int ref_cnt = 0;
+
+	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, 1 << STACK_DYNPTR, ({
+		if (!stack || stack->slot_type[0] != STACK_DYNPTR)
+			continue;
+		if (!stack->spilled_ptr.dynptr.first_slot)
+			continue;
+		if (stack->spilled_ptr.parent_id == v_parent_id)
+			ref_cnt++;
+	}));
+
+	return ref_cnt;
+}
+
 static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 				        struct bpf_func_state *state, int spi)
 {
-	int i, err = 0;
+	int err = 0;
 
 	/* We always ensure that STACK_DYNPTR is never set partially,
 	 * hence just checking for slot_type[0] is enough. This is
@@ -803,28 +822,15 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
 		spi = spi + 1;
 
-	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type)) {
-		int v_parent_id = state->stack[spi].spilled_ptr.parent_id;
-		int ref_cnt = 0;
-
-		/*
-		 * A referenced dynptr can be overwritten only if there is at
-		 * least one other dynptr sharing the same virtual ref parent,
-		 * ensuring the reference can still be properly released.
-		 */
-		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-			if (state->stack[i].slot_type[0] != STACK_DYNPTR)
-				continue;
-			if (!state->stack[i].spilled_ptr.dynptr.first_slot)
-				continue;
-			if (state->stack[i].spilled_ptr.parent_id == v_parent_id)
-				ref_cnt++;
-		}
-
-		if (ref_cnt <= 1) {
-			verbose(env, "cannot overwrite referenced dynptr\n");
-			return -EINVAL;
-		}
+	/*
+	 * A referenced dynptr can be overwritten only if there is at
+	 * least one other dynptr sharing the same virtual ref parent,
+	 * ensuring the reference can still be properly released.
+	 */
+	if (dynptr_type_referenced(state->stack[spi].spilled_ptr.dynptr.type) &&
+	    dynptr_ref_cnt(env, state->stack[spi].spilled_ptr.parent_id) <= 1) {
+		verbose(env, "cannot overwrite referenced dynptr\n");
+		return -EINVAL;
 	}
 
 	/* Invalidate the dynptr and any derived slices */
diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
index b8bbb61d4d4e..d4d0f1610853 100644
--- a/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
+++ b/tools/testing/selftests/bpf/progs/wakeup_source_fail.c
@@ -42,7 +42,7 @@ int wakeup_source_access_lock_fields(void *ctx)
 }
 
 SEC("syscall")
-__failure __msg("type=scalar expected=fp")
+__failure __msg("release kfunc bpf_wakeup_sources_read_unlock expects referenced PTR_TO_BTF_ID passed to R1")
 int wakeup_source_unlock_no_lock(void *ctx)
 {
 	struct bpf_ws_lock *lock = (void *)0x1;
-- 
2.53.0-Meta


