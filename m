Return-Path: <netdev+bounces-292930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEX9McDwGGqrpAgAu9opvQ
	(envelope-from <netdev+bounces-292930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:49:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 581325FC1C4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50A7A301B93E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB94635E922;
	Fri, 29 May 2026 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIw9X7Te"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E214A8B
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019382; cv=none; b=jsCVNd6bIwRzPI1aTvy/ua/+VWC0fvYXbNWAX5MyWwHsMu2lYgmHvOcF05thfrwxrSI8nzvSpBwiRkGeEMYJJoAxtu2uHYXyU2W6m3HYdGXehVoQU8G4oDbjnq422lAKZ7z8JBY5luXgF5IvUxw0TQ82e8uxDA5uKmNfob5VDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019382; c=relaxed/simple;
	bh=fdfsijbBflqFEuAxkZbueumL1yuwDsPXh5sSEJRNQco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBPjT9XB8TKUg+4581UJfxsLVt1kdVZ7q6XzsTgKFFEvOXKgDP1ETp/e+HDcJt4NQx/2Amop628zP8i0yC++kd+0Ah6KkTxpe09ysvS+pK+m6wWvny9lCMP42WCN5blUqJpGW+0/SrnJ1cZzpWbWcYA1XliGRFzI5oCaOXer9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIw9X7Te; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so6129058b3a.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019381; x=1780624181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFJ8lJ3WZbUM+5dZDblxkoFzvWV/3TNTZFcHmswWkQ4=;
        b=FIw9X7TeNPA0gr/kRr3iVXaB5ve29yUbEUj7nLYvK7rzXB0b6+mc3UgK8Ctoqu/p7E
         azNVUIng2Mv+F8mrawR//qN6Sv9cxCnGmF3/+bk4RJPyHXxMZVbmpKiRW5icZb3YH3dv
         IqT64doWWqp4vcyU7tYP6gMbp1o2u1iUvfzr9hmx1RMyg9kt1QiITnbKXvodl+2juH1F
         Eg6CpIjorWzBupqpqkLCxlnBaScqTvdnAGHzJ5uBCCTRU8kCiENC76qgV656a0vlYPQ+
         dm53ItCZh8AebTDcMymw5xmIQBjCe6UHly9CRv93iiItpw/7nL3of0+9mkFiloCeFLul
         ZWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019381; x=1780624181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OFJ8lJ3WZbUM+5dZDblxkoFzvWV/3TNTZFcHmswWkQ4=;
        b=c1whrF50qi3JF0MoG6gtDrt5U7debKwgji926uRBbKNvO46XqSDz4ngVSw05K0Uo/u
         ZG1JutNDZuCYD8CbgVUho7+1vSCD9FV9ArLeN2Z5vWfzFQZbWKIjecm4GTGdgdrp0tK1
         BkVVnUOXbDg/wI7gRtWnooXu79ZuMUA6ZcmtyL6yMe7KyRkFvDYKgj67uZnJNSV/REE9
         MlEPA3SeyIbiB6Wjpjdz40A9Iwck9fXmTGO5s5Hvs4xPDWFYQiTqpOz9WHn+bhvhE1fJ
         Kos3fnIRbCpm1IDCNM6gJsRxn45EmELR73vIDdQcUV9hstkn/8ZnU+H2WGEXrRoNxt2q
         zMTA==
X-Gm-Message-State: AOJu0YzvZh1zC85ZCe9k4adC5sWeqXaCx4prfYfblBdG/9ABUf92NBYz
	7ZZ9ewOjZ6e1UfhteIZFLyEEtf950EucBPsypEC0DYa8+IME8eWtv0yc
X-Gm-Gg: Acq92OGHLBsqzIHQxerIE7fWj5hveufOGpnEq8ou3s7NXb8/9n97cAXMAGBQ9UQcoP/
	kbEs7S7rlY0piIhi0Mv+aHirThCvU1Jns9GX2pe/CXwV/Qzelee5ArukXAWY9xErEExWs6Y2fgZ
	CLsI68lEqZWKMFOXiRkZl/zVjdC8CJghcpwEDIJUgGhtXS7ElTuLidgnzCDo8RYT7rgGCFhqWm/
	9jAjU89IC4hEETdpR63p2B9tybECxwdXqCn6QZvQX/RW9k2cChwHjClrQOjNBMR1G12Aonmbfq2
	+kksrASDxViNd/Lwbqw59dd/gITgRe3LmWY1yK2lizzEZ+utocmQ4+DfFZEUXZo867yBVscInyb
	Sr0kdlvXLopNhqv5XZnhIY+V2KWvsMYGGk5RMvJarNKg+7qkPuB3EtPPqZ/V7gQ/sbY3uicXRIi
	gCuVcR00HMYE7kuUJ4y1BqIGAO
X-Received: by 2002:a05:6a00:2905:b0:838:5145:c1c5 with SMTP id d2e1a72fcca58-84210b3b262mr788348b3a.21.1780019380945;
        Thu, 28 May 2026 18:49:40 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b30d4asm96257b3a.20.2026.05.28.18.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 01/13] bpf: Simplify mark_stack_slot_obj_read() and callers
Date: Thu, 28 May 2026 18:49:24 -0700
Message-ID: <20260529014936.2811085-2-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-292930-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 581325FC1C4
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
index c8d980fdd709..cddbdb4f78aa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3006,50 +3006,13 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
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
@@ -7255,7 +7218,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int insn_idx,
 			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
 {
-	int err;
+	int spi, err = 0;
 
 	if (reg->type != PTR_TO_STACK && reg->type != CONST_PTR_TO_DYNPTR) {
 		verbose(env,
@@ -7317,7 +7280,17 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
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
@@ -7427,9 +7400,7 @@ static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *
 		if (spi < 0)
 			return spi;
 
-		err = mark_iter_read(env, reg, spi, nr_slots);
-		if (err)
-			return err;
+		mark_stack_slots_scratched(env, spi, nr_slots);
 
 		/* remember meta->iter info for process_iter_next_call() */
 		meta->iter.spi = spi;
@@ -11393,7 +11364,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
 			     struct bpf_kfunc_call_arg_meta *meta)
 {
-	int err, kfunc_class = IRQ_NATIVE_KFUNC;
+	int err, spi, kfunc_class = IRQ_NATIVE_KFUNC;
 	bool irq_save;
 
 	if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_save] ||
@@ -11434,9 +11405,11 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
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


