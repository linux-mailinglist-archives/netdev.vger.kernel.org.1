Return-Path: <netdev+bounces-292939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGvSErLxGGr4pAgAu9opvQ
	(envelope-from <netdev+bounces-292939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:53:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F9D5FC2C1
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA1CE31964D5
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA863630A9;
	Fri, 29 May 2026 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ny9rpJu8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F4B3603E8
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019392; cv=none; b=BjjL7u05eqmmFPAAv8L+4l4yK3gvrhR4ZMTu9JldNLkoRbtcQVvYJk7sjclrrkESd5BMGQA13EMYoGnQfS+1WEALAoN2xoIF1S+OJAEClZBLf+GrqAQrPPpfK1tMIaXn+py9W9yxf12bX88vYbE8NAoyl5xfHzd0XgTdNqj2wJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019392; c=relaxed/simple;
	bh=O1PihKKyybnh0OrGueQapQSt0HIjf9J3uBUeibbhu00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODBaqcBYDKmKFBfGMJuvyQuHbwCR57BwT4Qu86cv15loRhVZZmeXeC6RsnLGJ8vdlMCRFCotstEvKTtoa7c41wLKVHp9gWe86qp7+NZSJ2gH5dulTjVudt12jbRTY8+iz22najvcgLC9xgpx2E8k9Q3yqRMXJhT2T67YyTfrV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ny9rpJu8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bd80b3aa13so89631385ad.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019389; x=1780624189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfGQBj3Jm2Q/AGII8DfWgnJibd71heaT0bL8CgHQHYA=;
        b=ny9rpJu8DXR+cUKXF9ZMmLh2jEhl6BhSK1wf5/3mJnnjwhJAHbYZ7aWHsKLRVCcNrD
         gsYkuPrx1MzdXD81ts68haZGAVCRfBnIpEhWFss9/UTQ5jFf7tWRvPkwRGlth77WdMAV
         8MsESl4zKj9M5Us0lhhpik3gE7TUqs6rJUIc9A/ey8fOUhnWc/xmloz8eRQcEW7Nn0mF
         xaqc2zroaMYTh08gR485WIT3FgCgm6Nx99hZHfdVOU8od5NkvDLSctek0+I4RViy0O4U
         f2L+ND/TRo/undJInbTkjGVcwQZ17NTscQLvTLNiYjf4ZkdVeKzZCyDRGL6ZbadxOQUM
         3Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019389; x=1780624189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AfGQBj3Jm2Q/AGII8DfWgnJibd71heaT0bL8CgHQHYA=;
        b=Ii3lRa2KwLlrMwBQGpFnUnLdnfIvw/RDWXCiNn7AXC/fyKLioF7wxa3MhmQbzNXC5X
         tH3ck2II9sdmaPdsS3ZSeV8wnEYIraBNApp8tyBg1oxuiC/UCIC6LTE8X9gnAGThg9nJ
         +bVm/vpqFdn5KJXni8hGh+UsSwpl7k05yrFuz9wd9j0BTIL+xivqO282K4dqQqSK/jmQ
         93npiwjxq7QQsO6vcDaH29n8hBltKk2afI2r07oZbXqrhJ/M4NhQ2k9niO1yRUYuCGQ6
         fxGA6dMxjUNpa71sV0GTLcremUdrRdVkJgEpl8017dfqVaL/CTp3TfGoYbOR5Z0ImV1S
         DX7w==
X-Gm-Message-State: AOJu0YwjLDBxtKbz2P5FYp8mpLjx4hmGjeaJXA/RGujn1t/je+f4Jot1
	vMCK/WAWIdM3/ue9AMhTYLD5uNw9sNHgs4YEMb9LOBhwLyFo3jR6Lbqg
X-Gm-Gg: Acq92OEJf9SWPLRMmPfFDNV4P0Ybx9kDiZguZ8/QLPSh1p75FlxBI8L3ndRLhPjkL9D
	I1BISykbjuBQxO9WhS+o1myw6ebJzklQSOY5YpKras/tbv53qY6XbGcfI/yayi9VB/m926NRhAP
	Kr/uc6MsVS++J/iJH3uHSIIRv0xR46RBrYz6hwUGPkXzUDiVsaamAQOJJDZYgdPFq+pfU4HZsZI
	gN56tRcL1zoxaZY5BASpQ14Vcr2D7ZATJ/fO+rt0sSxiEaTMx/RRiqKemhaXC+F7XnSNqKZRAC5
	J65HV7Bc3f7cwb3n3PjnWj9WCPgND4ACZcBF+VthPk8Xrh9u/K2eAvlj4KDm4Vy7n/AjWfNTtS+
	v4JhM7qmtFv601uzThk7+3c+v48jOH7cQzo6WvpsqEAVq1M7YqtVU+5t7NVQIj9PvmKEFv+LJ7k
	Zr5kS5miFoStPjfk/iRWkxh8iq
X-Received: by 2002:a17:902:c412:b0:2be:260b:fa58 with SMTP id d9443c01a7336-2bf204f3f1amr10101415ad.1.1780019389405;
        Thu, 28 May 2026 18:49:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b00ebcsm664285ad.51.2026.05.28.18.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 09/13] bpf: Fix dynptr ref counting to scan all call frames
Date: Thu, 28 May 2026 18:49:32 -0700
Message-ID: <20260529014936.2811085-10-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-292939-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A3F9D5FC2C1
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 52 ++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 375e5e5f9131..3a4233396aae 100644
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
-- 
2.53.0-Meta


