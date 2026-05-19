Return-Path: <netdev+bounces-289564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJDIFk2oDGoIkgUAu9opvQ
	(envelope-from <netdev+bounces-289564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:13:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD74E5837AC
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3FFA304B7F9
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0CD33F58B;
	Tue, 19 May 2026 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpFzbuLG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31333F5B5
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214402; cv=none; b=KjTpHWLdtbuHSxmhhfg92Pole3g/jrQf3MYYMGdZ6kegRK/SBTNi1iZWM0lB5OsLTjvN08jqk1Zu3BgtwPQxgculrn1KOD8l0fDa6B86Otdg32IFWTiiMMNeBgSfwfPHLY6Aw6t+6Bz+whkZCWeS2Au6LJsFOc+A/+hl9nAq6Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214402; c=relaxed/simple;
	bh=0zmmE9owoJmpjX5rkdO8Vz4Y4T7Hn5V0BRd4YzX7FcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoNQCyQVYWu6FWNG5AmJySAflgAKPgxQ9TBycqwbJy5QqFWqjZpHnEYGvHRC2jirj5vioDMESRiK3gOa83Y0Nm724FkKW7kraoPL6PqaUf0ER+7im2ouG0P1BIbHRC/RjVINhIzT9C9VBWjVVoB2jBBH6YF+BmVmh6pgl151txg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpFzbuLG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7c5d8f45465so35024237b3.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214397; x=1779819197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aXd2hCKEAmm1cF4JsLY+ElpPbpclBdFYzFFzCGJ0EA=;
        b=NpFzbuLGGf+gDopIWEG4vabApCiYe4fLwld3h8LEy0bpINRnq/GfreKAA+1QS9UjYm
         DtqvkXXwgx5cQXXjZwDDzPC5axcy3J/AQiSuLbd/CgZmEwfWewQk6tltAq1+2GIXYEHV
         D+yLRXuvVbvDNRBtBs/+u1Jug7QZO4iMFkC8hNJs2CxqPBDSa2xHewd6spPzTegGbm26
         9ReaqAwjsHIljzu3znO1Vo7tg5MfAh7ly/z1VSlDZn6m36Mu4CE7nBFTck1djS/wrge/
         VA644z3N/Ck1QcteGK8g3HP0pS1QT8CreZzDBYoGu6JabUVh6qkFcnD45o67NUuTy8jg
         rRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214397; x=1779819197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3aXd2hCKEAmm1cF4JsLY+ElpPbpclBdFYzFFzCGJ0EA=;
        b=be7B2CgQ3IS/93AYkUi/eyXU5S/Zl7dmDPRwgI5flYR4aXe4SY9INZBCHaASp5UPiw
         lQSX8bM0P08O3Zaz9yUYB1vHeIlpGliyQ02iIJ3x51LnGF4lo0thLbXDc69+3jcZoct5
         apMARRDjwecWjZ4sqvyExpklGxgw5kHt/Vgj/m4sLBtnuJEl8tc9Ve4ANwKhbmEFYi7P
         KmMhgZ0jKmnKEHY2tIkup6kfi+K6RAn/PYIfLRvPRGV3pY78lzaQspflMqDPmtE7MK0Z
         kmawIWFemAesS8Z7ZWuOungRAVFkBlXoiu+nSwySJj9oMEWewJ9So4ew9KsYQn6i9J5z
         57sQ==
X-Gm-Message-State: AOJu0YwXR0zFuD8ZkqIdD3Ok2LBDk2ZJZDaMgP0vLJ7S2EiwgFT4ETqr
	udxeFb9ylUcU0IYMw/sM3i503OP5dEynMcsfpELljBzAI8+NyH49Ur50
X-Gm-Gg: Acq92OG4QVjI7WDcsM3Jg9C4+lQRzrvULSkwRZhRW5+8d67gdFOZLVl4fj4JAuuXEQ7
	IRXJ9IksQUJgk/a0G8YA9hvajPuvj+mwUu5cL9f19EXSOOwVC/e5ZohYBKtfbO7sXUM/aUXPeGz
	Vl+ezf0788+D2kFyDD9ceETOg0Mb2H226/mQD1iJ2FmbLtEbVUqceLlcM9jpHVMBUjBTp+as6K1
	aHVKaqEbdfZi2dn0rHTX2No8j7IMRFkrDXO3tAeQ4V4Yt7s9RmzQvLePsl3cLkxiV+iMBWBetSn
	nOTvRPAWjxJAXdizgUmn+rAOk8GMHmHOuffHE0wJihJAOplBRj3JBfpmE95drgvMADBtZQQ7fw1
	EgoS8J8iMb9t5New/lkjGeVl3RJsWVIPjekP19PDoRz0QWiw+7QTXb4KlJ3puBClYZ/4bX+D2TW
	iD605jQuCU/2hMcA==
X-Received: by 2002:a05:690c:e3e8:b0:7bd:a6ea:c508 with SMTP id 00721157ae682-7c95c7ede98mr216896037b3.24.1779214397379;
        Tue, 19 May 2026 11:13:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc991c9bd9sm40743897b3.4.2026.05.19.11.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 01/14] bpf: Simplify mark_stack_slot_obj_read() and callers
Date: Tue, 19 May 2026 11:12:59 -0700
Message-ID: <20260519181314.2731658-2-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-289564-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: CD74E5837AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename mark_stack_slot_obj_read() as mark_stack_slots_scratched() and
directly call it from functions processing iter, dynptr and irq_flag.
Commit 6762e3a0bce5 ("bpf: simplify liveness to use (callsite, depth)
keyed func_instances") has removed the dynamic liveness component in
mark_stack_slot_obj_read(). The function effectively only marks stack
slots as scratched and always succeed. Therefore, return void, drop the
unused bpf_reg_state argument and rename it to
mark_stack_slots_scratched() to reflect what it does now.

In addition, to prepare for unifying dynptr handling, dynptr_get_spi()
will be moved out of mark_dynptr_read(). As mark_dynptr_read() would join
mark_iter_read() as a thin wrapper of mark_stack_slots_scratched(), just
open code these helpers.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 69 +++++++++++++------------------------------
 1 file changed, 21 insertions(+), 48 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8dd79b735a69..9daa5555db39 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3007,50 +3007,13 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 	return ret;
 }
 
-static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				    int spi, int nr_slots)
+static void mark_stack_slots_scratched(struct bpf_verifier_env *env,
+				       int spi, int nr_slots)
 {
 	int i;
 
 	for (i = 0; i < nr_slots; i++)
 		mark_stack_slot_scratched(env, spi - i);
-	return 0;
-}
-
-static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
-{
-	int spi;
-
-	/* For CONST_PTR_TO_DYNPTR, it must have already been done by
-	 * check_reg_arg in check_helper_call and mark_btf_func_reg_size in
-	 * check_kfunc_call.
-	 */
-	if (reg->type == CONST_PTR_TO_DYNPTR)
-		return 0;
-	spi = dynptr_get_spi(env, reg);
-	if (spi < 0)
-		return spi;
-	/* Caller ensures dynptr is valid and initialized, which means spi is in
-	 * bounds and spi is the first dynptr slot. Simply mark stack slot as
-	 * read.
-	 */
-	return mark_stack_slot_obj_read(env, reg, spi, BPF_DYNPTR_NR_SLOTS);
-}
-
-static int mark_iter_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			  int spi, int nr_slots)
-{
-	return mark_stack_slot_obj_read(env, reg, spi, nr_slots);
-}
-
-static int mark_irq_flag_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
-{
-	int spi;
-
-	spi = irq_flag_get_spi(env, reg);
-	if (spi < 0)
-		return spi;
-	return mark_stack_slot_obj_read(env, reg, spi, 1);
 }
 
 /* This function is supposed to be used by the following 32-bit optimization
@@ -7256,7 +7219,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int insn_idx,
 			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
 {
-	int err;
+	int spi, err = 0;
 
 	if (reg->type != PTR_TO_STACK && reg->type != CONST_PTR_TO_DYNPTR) {
 		verbose(env,
@@ -7318,7 +7281,17 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			return -EINVAL;
 		}
 
-		err = mark_dynptr_read(env, reg);
+		if (reg->type != CONST_PTR_TO_DYNPTR) {
+			spi = dynptr_get_spi(env, reg);
+			if (spi < 0)
+				return spi;
+
+			/*
+			 * For CONST_PTR_TO_DYNPTR, reg is already scratched by check_reg_arg
+			 * in check_helper_call and mark_btf_func_reg_size in check_kfunc_call.
+			 */
+			mark_stack_slots_scratched(env, spi, BPF_DYNPTR_NR_SLOTS);
+		}
 	}
 	return err;
 }
@@ -7428,9 +7401,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (spi < 0)
 			return spi;
 
-		err = mark_iter_read(env, reg, spi, nr_slots);
-		if (err)
-			return err;
+		mark_stack_slots_scratched(env, spi, nr_slots);
 
 		/* remember meta->iter info for process_iter_next_call() */
 		meta->iter.spi = spi;
@@ -11360,7 +11331,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
 			     struct bpf_kfunc_call_arg_meta *meta)
 {
-	int err, kfunc_class = IRQ_NATIVE_KFUNC;
+	int err, spi, kfunc_class = IRQ_NATIVE_KFUNC;
 	bool irq_save;
 
 	if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_save] ||
@@ -11401,9 +11372,11 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 			return err;
 		}
 
-		err = mark_irq_flag_read(env, reg);
-		if (err)
-			return err;
+		spi = irq_flag_get_spi(env, reg);
+		if (spi < 0)
+			return spi;
+
+		mark_stack_slots_scratched(env, spi, 1);
 
 		err = unmark_stack_slot_irq_flag(env, reg, kfunc_class);
 		if (err)
-- 
2.53.0-Meta


