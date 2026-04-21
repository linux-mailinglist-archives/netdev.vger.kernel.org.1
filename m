Return-Path: <netdev+bounces-280261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ7tNan252kVDgIAu9opvQ
	(envelope-from <netdev+bounces-280261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:14:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE144009F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E31F308D9A5
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC9039D6D5;
	Tue, 21 Apr 2026 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlNe7MbX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B5B3A5E68
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809425; cv=none; b=DmxSCXi6agnBK8Tc8kekTCEh5gfjeWSm/W5dQAQZ294b3RjgZY6JFEefPiJTSk26wgXoIXCe+cU+peTur9MEIZB3w+jbV6+bC+I31QJd02EJjFKcgu3SpYYnUDV7DmEcIE8YVwsvXNegAuWU1WgbSz0+wOgREfXxnmqyOdLFMsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809425; c=relaxed/simple;
	bh=IfoM9T1xOdM8W8X1McjYa4aJasEgRFewu8AP1FwNcz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjUNLudjdP/DWlKfJQR3atbuHVuEoeOto2u7DTKqjM4rybxRxzTLCNNfIZafHMNoejLu7+EWc0wj+UwduTVyrCI/40C8KoiIdme3S4sNElvXaztVUq5tF9CCcM9RZIMhwvae6cx3XPBqYrVC+IbrzjJ8RlvU7Zr1oE4smfOzy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlNe7MbX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35fb7c1a455so1903239a91.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809424; x=1777414224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcVDCQ0r2jAEHOWL1njreNq4j1EL9+ea24V2ROuP5aM=;
        b=FlNe7MbXSbZtvcDCLaGFNFb4cabVFfUY7mVsEEXtbK7WKsLqHylm3/fF0CmGD9a5Vy
         JShWhVm5Aggv+RTqR8xPrxuNfQ5KZOMzCjEPJBH2y3qt7WuFoEZdeXOtsMvhVKiTt/IZ
         8nlxeBb7X1a8m6Su4JBAcQRXI0tV/Ey6jmZcqSXWcl+PtmXkZJL9IujpSI4BU14fPT3s
         p51212ci9osZNTGKaTHpDZA87JhivUcHvOpResMTLa7By2oriaiB1yG2kq/Cuc99Z39S
         zmawnrMXxIphHgKUBT8rtDcXLphJwcV1HnWoFGX4bE4mPxxoieIuniw6everar6Ey+8i
         xLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809424; x=1777414224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AcVDCQ0r2jAEHOWL1njreNq4j1EL9+ea24V2ROuP5aM=;
        b=SCx2B19TjN09xz+CLxjxb57zaTzn////FpUZh2j5rBfyEIR1z/nZlQoAIB/XEtU4cc
         g/+NfCR8fWD1aET+FHO12AxZJbUhJKKVxGFua5Gbdmsz4NK8K+/nn0dKh1Lbm4rYgtLa
         ClDY3LEvvjsWcFxr54cG8WEDLzeOOZDc5M52lyTk6PKeeoevCxGxlRno+1GaqSNQvpAK
         Nzce5OKVbMDUag08f3EPsBuyXHnnWApiHVNJFDsX0tTmWpYLaEgh/NahQotcB74qWnD6
         Sw+Of25ILKgqOY1QaVNmbEFwip71AeCcYUFsdG39MXA0PbEiTIITL6TdVoY5+Ssx1+qx
         GIdg==
X-Gm-Message-State: AOJu0Yx0YUfwfFtj9kY2e6AvffVwuK2vhzUrOvSPnFhR/CtJq/Cruw01
	sKcCGZh27bCh8BRW5yfUvZQ+8AWGvA4I6fJLunoWWJMLn5gqUgQxtZGK
X-Gm-Gg: AeBDiesITAUr7xLcsQ36PaZPfU8LXFkPsxu4ZsVNo0lTIPdCFiIrrGXmg1aXRatDrQl
	vFf9ZepC29NGHtxpU0zYSjhlKa5Yd5asFpwS+gqVDx/AEb9qRrtc1EI+PLBvEYKoMUUOa8eQOsI
	w17k7dZCV4+etomtam4ivhiejBzDSn5x+a93fmcxfh8zMIjwUeoJH70eZR+e8gJ+50lCG5iKO5k
	Dd8ml9X3zbZ3g2yjVpMJu6AkADJGjcFK12H2VcG9CWZh1BEVkIAqgrb2zr9O93X3jUyvxDSZhee
	LWbKcwtjK8Bft8R61UV5AQmK5ypFgA/UG3ryV9K9IeZugfJd3PjemnxWNwX/7/TYIfCdSZm7OeF
	FgWxMYcCZSI2sZb+VqJcvvCSEcKV8cw6n21C6AolENjlGCPFRUoqnq+lFzgpRNGPVAiLhIUCKHk
	Yif16q7QJy6tc+eM6dYEX6MF3e
X-Received: by 2002:a17:90a:e7ca:b0:35d:8fdb:4f36 with SMTP id 98e67ed59e1d1-3614048a21bmr20260535a91.18.1776809423914;
        Tue, 21 Apr 2026 15:10:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm14968773a91.3.2026.04.21.15.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/9] bpf: Remove redundant dynptr arg check for helper
Date: Tue, 21 Apr 2026 15:10:12 -0700
Message-ID: <20260421221016.2967924-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280261-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92CE144009F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

unmark_stack_slots_dynptr() already makes sure that CONST_PTR_TO_DYNPTR
cannot be released. process_dynptr_func() also prevents passing
uninitialized dynptr to helpers expecting initialized dynptr. Now that
unmark_stack_slots_dynptr() also error returned from
release_reference(), there should be no reason to keep these redundant
checks.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 21 +------------------
 .../testing/selftests/bpf/progs/dynptr_fail.c |  6 +++---
 .../selftests/bpf/progs/user_ringbuf_fail.c   |  4 ++--
 3 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 908a3af0e7c4..3ab9bc2fe0e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8405,26 +8405,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
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
-		} else if (!reg->ref_obj_id && !bpf_register_is_null(reg)) {
+		if (!arg_type_is_dynptr(arg_type) && !reg->ref_obj_id && !bpf_register_is_null(reg)) {
 			verbose(env, "R%d must be referenced when passed to release function\n",
 				regno);
 			return -EINVAL;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index b62773ce5219..b5fbc9b5c484 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -136,7 +136,7 @@ int ringbuf_missing_release_callback(void *ctx)
 
 /* Can't call bpf_ringbuf_submit/discard_dynptr on a non-initialized dynptr */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int ringbuf_release_uninit_dynptr(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -650,7 +650,7 @@ int invalid_offset(void *ctx)
 
 /* Can't release a dynptr twice */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int release_twice(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -677,7 +677,7 @@ static int release_twice_callback_fn(__u32 index, void *data)
  * within a callback function, fails
  */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as arg #0")
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
2.52.0


