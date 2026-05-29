Return-Path: <netdev+bounces-292935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNXKM1nxGGqrpAgAu9opvQ
	(envelope-from <netdev+bounces-292935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:52:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B3E5FC257
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7433312ECF6
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8084B362139;
	Fri, 29 May 2026 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7DI2Evo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F9B35C1A0
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019389; cv=none; b=emMJKeligHShDt32vYrdYyx1/QneD5kVrZKo+my13dFxBy+yhZEt44O9ngr3dSZO+rwWH2juGxEksfNxTLOiMXGthgav+6s970L2bWhsv7SvG+N0JtKzNPtdSbwzDyv+ZXhaO/nFJPYby48Yi6ghK9phym+0b0nNTagOT2+DQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019389; c=relaxed/simple;
	bh=vNX0q94QJ5cQoHE6fikuIVXjqQmntQt191a0ixMZde0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIJXZfXxnePcJ76pMo2/BFYh2CwbKKSfdg9gIXle1MJQkhgdh79+fo1N8QvnFBwvaAuLmfjYkoYpdrUuzzCIjS1aCd0d4q6TRQ3lSNKEtoEyA1/GARdVX6+aV/qa+lCVIuZSpFTr5yGFM1S5njryDnXnyN4+KfcaIiEVnrHaltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o7DI2Evo; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8367df48711so5891804b3a.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019386; x=1780624186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YwDcqRVN8dmz1Un30/apqJWiI4e1R7/M4peDTSJvVc=;
        b=o7DI2Evo4hTIUfAYzOb9j9/LGGubGqyqEDcWdb17XKLkxcE7vZrQgoAWB9CF5Ixjk7
         c1o5zwK0s5z2e9n4UpbYcnTFf7AiaNwZQw59kFaLrX/MbwFR0gnNIuD2jVTOUr1CHUOy
         1GKhNRIreXgarVtdViLlvvunwOz4gGO/+Fj2KujAKOeCpuXQlNKJ8iilJ3F9uTvDNeu/
         cTMNL2UNS0EEVo+c0bRARvqQ66fkfm2bp1eqnKbJoJwwu6zZioNBStfT7Fz8KpvVaA10
         qtOSvEhxIqdpa9paXukiYfzKDgND2bJgI7f/c4T/SaQ4g7Oth6xX5EnUBCJGthK4HtaN
         2naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019386; x=1780624186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5YwDcqRVN8dmz1Un30/apqJWiI4e1R7/M4peDTSJvVc=;
        b=oMcv+wDzix4e9VJPqgCDf2p65MX5c+ucW7IVlWyDI2iln13S3pxP+MhKxqKz/Y11U3
         hUu81WBrhVxlxLvcjws8HuUGUqVFF82YjFrBuJ+xN7hiCuNtwnUhBmVRKHTeAI/781a6
         wIl/pZxoM+b2ocpW8kJbCNW2UYSA+yg2B45SVtXn5c7QFBB7wO4qI9ebjCRDih2PWN9W
         JMBuPPojvf3vTh4mGrTvBfuKcINpHg6R5N/oqU8PYo6emfZRrUOp4a0YR4NcPxCDgYrQ
         jNRBrJoYgDN3dNiOHmFWRxWVd8Xt/rIQgZ0t0gG6LS3MbMB5W146VQo6n0KvLZCX/mwS
         Agiw==
X-Gm-Message-State: AOJu0YyoN3/rxDczz4Ew1y9RUduXkYKECDf4R6kx9S5a95xKQM/Elf0e
	5f2w++rQKoABm0Hahp+yU9jvbOz5L8ISPTkeQLc1C45KnzxbZzu6Wc5F
X-Gm-Gg: Acq92OHCdD4axxXWyTFfdq37tQ8MXKExA84RJdWMSBK7u7DNQoAkQqhNn1u6M6j6lC8
	mvpY0LUWQM+XAvrhspjUdZJF4kgslZohrhVfPgdOpGZfLaP4pBxRuB5hb5evnu96HES7mWK1mvp
	A3yXmU17ig9xhp6t+uJG3E7ecI3054YQd0a8oEBToTGZf9oAoIOMV/r8h78Z3FWYrwNUIUyymtI
	mRp17XOLjwpHASbq8bNvDrhZGA8TWFEpjEegsvqnL7OuhIXDdW7Xpyp08bdxSaxGkbS6TXLMRuo
	1lD5z7E+JkcAsZoDN0E0Iyn1gLWRvrDQFVTRwaVocLAO+011BXf4ROQ3EbLdhCIoigrhbxmUGss
	+06oVE5MFLOaFkypeCbRbn93XUrkr1NZMSG2bu06LVJ0EmvXi0Tq+M9tbck/XoHYL2cMGyym+z7
	tk0Tt1wKPZRR/jw+gs07s79P0=
X-Received: by 2002:a05:6a21:9d45:b0:35d:5d40:6d79 with SMTP id adf61e73a8af0-3b41205b148mr792846637.12.1780019386260;
        Thu, 28 May 2026 18:49:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214c931a3sm81975b3a.37.2026.05.28.18.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 06/13] bpf: Remove redundant dynptr arg check for helper
Date: Thu, 28 May 2026 18:49:29 -0700
Message-ID: <20260529014936.2811085-7-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-292935-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 78B3E5FC257
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

unmark_stack_slots_dynptr() already makes sure that CONST_PTR_TO_DYNPTR
cannot be released. process_dynptr_func() also prevents passing
uninitialized dynptr to helpers expecting initialized dynptr. Now that
unmark_stack_slots_dynptr() also reports error returned from
release_reference(), there should be no reason to keep these redundant
checks.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 21 +------------------
 .../testing/selftests/bpf/progs/dynptr_fail.c |  6 +++---
 .../selftests/bpf/progs/user_ringbuf_fail.c   |  4 ++--
 3 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 062fdd6b7b59..3db0f1db475a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8214,26 +8214,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
 skip_type_check:
 	if (arg_type_is_release(arg_type)) {
-		if (arg_type_is_dynptr(arg_type)) {
-			struct bpf_func_state *state = bpf_func(env, reg);
-			int spi;
-
-			/* Only dynptr created on stack can be released, thus
-			 * the get_spi and stack state checks for spilled_ptr
-			 * should only be done before process_dynptr_func for
-			 * PTR_TO_STACK.
-			 */
-			if (reg->type == PTR_TO_STACK) {
-				spi = dynptr_get_spi(env, reg);
-				if (spi < 0 || !state->stack[spi].spilled_ptr.id) {
-					verbose(env, "arg %d is an unacquired reference\n", regno);
-					return -EINVAL;
-				}
-			} else {
-				verbose(env, "cannot release unowned const bpf_dynptr\n");
-				return -EINVAL;
-			}
-		} else if (!reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
+		if (!arg_type_is_dynptr(arg_type) && !reg_is_referenced(env, reg) && !bpf_register_is_null(reg)) {
 			verbose(env, "R%d must be referenced when passed to release function\n",
 				regno);
 			return -EINVAL;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index fa0beeaad1be..40a14a5174a5 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -136,7 +136,7 @@ int ringbuf_missing_release_callback(void *ctx)
 
 /* Can't call bpf_ringbuf_submit/discard_dynptr on a non-initialized dynptr */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as R1")
 int ringbuf_release_uninit_dynptr(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -650,7 +650,7 @@ int invalid_offset(void *ctx)
 
 /* Can't release a dynptr twice */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as R1")
 int release_twice(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -677,7 +677,7 @@ static int release_twice_callback_fn(__u32 index, void *data)
  * within a callback function, fails
  */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as R1")
 int release_twice_callback(void *ctx)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index 54de0389f878..c0d0422b8030 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -146,7 +146,7 @@ try_discard_dynptr(struct bpf_dynptr *dynptr, void *context)
  * not be able to read past the end of the pointer.
  */
 SEC("?raw_tp")
-__failure __msg("cannot release unowned const bpf_dynptr")
+__failure __msg("CONST_PTR_TO_DYNPTR cannot be released")
 int user_ringbuf_callback_discard_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_discard_dynptr, NULL, 0);
@@ -166,7 +166,7 @@ try_submit_dynptr(struct bpf_dynptr *dynptr, void *context)
  * not be able to read past the end of the pointer.
  */
 SEC("?raw_tp")
-__failure __msg("cannot release unowned const bpf_dynptr")
+__failure __msg("CONST_PTR_TO_DYNPTR cannot be released")
 int user_ringbuf_callback_submit_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_submit_dynptr, NULL, 0);
-- 
2.53.0-Meta


