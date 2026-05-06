Return-Path: <netdev+bounces-284874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFpINOpS+2khZgMAu9opvQ
	(envelope-from <netdev+bounces-284874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:40:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CAD4DC652
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC66530F44DE
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23CE27B357;
	Wed,  6 May 2026 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbb9a3DP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5C48035F
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077638; cv=none; b=nXUWmBEC2U28zSvix3HFoO13HuYh8qPQKMCqzfMvI15T+qyffWV5HLmdk9y2OlcA4AVgQWIcOOh3x0zPe0kkJmJWwwUuaUTyPG/FquESjz9U40sE2jCiFtoabahL37YZQRPc9znO0Tjb3vgJce4CWbNfYfMsWvCwEZ6GRxC7+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077638; c=relaxed/simple;
	bh=0pgG4EAZaXZyBAb5tubZjnWNu/ZeNBpH8ofG9btY/mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVjJoltts/Awx/7nehx9LWzlzz0hIbGOa0USNcqBXHRzHldKvTGDK2RHUvRYxAy+sHOM5TqzSmL0GVNDfXFZ5OnmCV/7+nrPUWi2oiQSOJ9/hZJOfU3vIpaXrjlovPJCFfl34IW2gWu7dwOKc2In08nKNPYhppap+aK7BByQgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbb9a3DP; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8d4f78fc9f6so699991185a.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 07:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077633; x=1778682433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmN01WbpmRqn1C9juDGvKSSgQ/NxP/G1nR1WMWadPa0=;
        b=Vbb9a3DPx//v9UTSc+tHm2mCAavwjyYUZNsbFPXUQlLc4o2Rr/lWYJRX8sxS9NaOTY
         QaZTkaHzpOfR9P9erpXMF6SaUOWQwZ6ZTBskpJASti2Io3oDYgeGa1gMqNs9mAoHhrrr
         82xIbrwjQjSAxBTZ06Z9pzud6gh/RfQ3v+isSuHEsKqnQuYiKOvfTkESOGcEKgdmvPhx
         RJ/FjsbGIZk9zKszngAc4OmbJEQ+seyGH5V1+FhzFmhGHkdX0x5dSIrF1LA49dzBVczS
         IkXGgNYSNc6Nd0mnHprgW3CuHYHhhF6RjqALYisuj0RROKT/xH+leFGSKdrqwMm60iOG
         h9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077633; x=1778682433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZmN01WbpmRqn1C9juDGvKSSgQ/NxP/G1nR1WMWadPa0=;
        b=ksHeEJDIwRXgO1dL3DLqAzvVO6iUHrSe7KuMz1HqJtezagwESXslaElVc26e0tmN1X
         Nh3T9Jq0vwEnlSuJMCUEJWrNCk2R3tOz/lZkDKEI0IFh9ukqTveKEv5roqbwF3XI+F+E
         63rdebV5s09HrZpJsH7doYDqMfx4jvttlJSJ9uz6+6NTrSa/6vz/UNcperAwyHO1lXfK
         lXnZ3MnDv6dtFpHRRLjhB4Jwrv4smdmWjycYaBh09yplqqbhwVKPLn2L037MUTkLjKRw
         oBLq9kKy0n4R4bZPZY9ZwB9/EgpZETSuUoOXxjqBuuk4WG7MOQ3sLSta6x4Y4A5RnIbq
         ZxMA==
X-Gm-Message-State: AOJu0YyJ3xQ8yRPzMFdQos4Ui5Pe19wOdvOAeBCq7gAydXMi2lgZAARo
	P1oXuEpwQHlnbOlsMO891V+wPGmUJ/0bJDV82giqU2DXXC1dk+8ElWv9Lv+JZV76muY=
X-Gm-Gg: AeBDievOvFJxg8MFSkaYmH4xcynEUlhr/XeBIxj4tPlpk/QQRKQQ2XmZTYDjlQrzRf6
	WNJUkDrHKAcSegnhxbCLlMtFXJ72OU0OiA9WkwqQobaAJvEhXCLn8K4x2TjTE4s6WkS1o82Hrht
	TjgVYtf2666O9Ya8yKg82ThYrj0kXA8fTENf5hjkdhhym7MmICYLkuyh4pjdLXSuSKrP9CdUJap
	Z+rBWotmU3Ar42C2VxfUQsE6hFQTG6SskdFCSgCGwMpk4evyQrtkGWStdKSUIzQe8MSMSAbmaYK
	wiq9mSAfX4Hwo5S92WHSrmUegudira9m8yiHPP6yeDi8rfPmPc4oXqrncdgx0IlaDbfGw52lz9v
	ytRsv29l6dNBIXXOqQhXG1etmPS5hzS05laN3UmtZPzQ499YIuLOA5mFJH8VggzPobhqeRuv4VQ
	94msKGiyRG2z8VkzLtxF+kFTny0Rk=
X-Received: by 2002:ae9:e60d:0:b0:905:eeb1:4d8b with SMTP id af79cd13be357-905eeb14de3mr30556585a.22.1778077632722;
        Wed, 06 May 2026 07:27:12 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:30::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253bc9sm1845439485a.27.2026.05.06.07.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:12 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 01/12] bpf: Simplify mark_stack_slot_obj_read() and callers
Date: Wed,  6 May 2026 07:26:57 -0700
Message-ID: <20260506142709.2298255-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260506142709.2298255-1-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 35CAD4DC652
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-284874-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Directly call mark_stack_slot_obj_read() from function processing
iter, dynptr and irq_flag. To prepare for unifying dynptr handling,
dynptr_get_spi() will be moved out of mark_dynptr_read(),
As mark_dynptr_read() would join mark_iter_read() as a thin wrapper of
mark_stack_slot_obj_read(), just open code the helpers.

In addition, since 6762e3a0bce5 ("bpf: simplify liveness to use
(callsite, depth) keyed func_instances") has made
mark_stack_slot_obj_read() always succeed. Return void and drop the now
unused bpf_reg_state argument.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 69 +++++++++++++------------------------------
 1 file changed, 21 insertions(+), 48 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11054ad89c14..6931012d3ee2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2972,50 +2972,13 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 	return ret;
 }
 
-static int mark_stack_slot_obj_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-				    int spi, int nr_slots)
+static void mark_stack_slot_obj_read(struct bpf_verifier_env *env,
+				     int spi, int nr_slots)
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
@@ -7078,7 +7041,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int insn_idx,
 			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
 {
-	int err;
+	int spi, err = 0;
 
 	if (reg->type != PTR_TO_STACK && reg->type != CONST_PTR_TO_DYNPTR) {
 		verbose(env,
@@ -7140,7 +7103,17 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
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
+			mark_stack_slot_obj_read(env, spi, BPF_DYNPTR_NR_SLOTS);
+		}
 	}
 	return err;
 }
@@ -7250,9 +7223,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (spi < 0)
 			return spi;
 
-		err = mark_iter_read(env, reg, spi, nr_slots);
-		if (err)
-			return err;
+		mark_stack_slot_obj_read(env, spi, nr_slots);
 
 		/* remember meta->iter info for process_iter_next_call() */
 		meta->iter.spi = spi;
@@ -11150,7 +11121,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
 			     struct bpf_kfunc_call_arg_meta *meta)
 {
-	int err, kfunc_class = IRQ_NATIVE_KFUNC;
+	int err, spi, kfunc_class = IRQ_NATIVE_KFUNC;
 	bool irq_save;
 
 	if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_save] ||
@@ -11191,9 +11162,11 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 			return err;
 		}
 
-		err = mark_irq_flag_read(env, reg);
-		if (err)
-			return err;
+		spi = irq_flag_get_spi(env, reg);
+		if (spi < 0)
+			return spi;
+
+		mark_stack_slot_obj_read(env, spi, 1);
 
 		err = unmark_stack_slot_irq_flag(env, reg, kfunc_class);
 		if (err)
-- 
2.52.0


