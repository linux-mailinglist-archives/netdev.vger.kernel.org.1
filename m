Return-Path: <netdev+bounces-289568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKxXFB6pDGoIkgUAu9opvQ
	(envelope-from <netdev+bounces-289568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:17:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB4058385D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DB7430C45CF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC83446AB;
	Tue, 19 May 2026 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrHDFHZa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D834028B
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214408; cv=none; b=Uu7TWxdgun9uBGmpNjDL4ZOg1WOI0rOhuuBK0c1rIbUHrIk8ICg7t5CJgWt+k5ovZr74goqjh1UViD2VGp3iHvOWgnnvWZH6Y5piR+SZLbfUygI2erD8WvKMpfZTDjIJwCfPqVZIjTtu2upPxjyE0oypQrgv4eVIOTEaxykFDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214408; c=relaxed/simple;
	bh=1KWgzZ1+BahlE5r9ggr5K4FHVlQb6En7F3DVsRLIPd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQGsdx2rpSgWMk620oetlxfDXhM/CJ/1GazcsSmmyUdqPJ+6vMdF2ztnJRNeytgyyESkgmuOIMW9IjYtIFEYBmCRmgpTIFanY6R5L896Lqi4zL+WAWeAjVf89qzHKyAE1UCfOO7bg8+aKbQ9cTqQa5HAi6VgUDsqbVPJ2c+wFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrHDFHZa; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-654672a6d68so3965453d50.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214405; x=1779819205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mXL77+0mg8e6mgzNlsAvrB2ziUWBHacNwaVLem3R9Y=;
        b=lrHDFHZaTroVy3Pq6WX9rmnvMRlJOkqPlGmMC4hNmVpDzzn22eXHWvSoKUjax0350f
         8MouUPGj1803QL/8QdQTaLkvT1g20hxpO3K0gK7iXdVFw7ms8LbgdUZ/Apiu2gUpR3Jr
         hqff4d0uwt2kDzc4q33neja4Py+/Z+Yn0s3IDFbbpXJlJ1RCAynOKDYKP0fLArKopOJm
         g8Gi/5a2UtnjqJHLD9/0gfZxCx95vtBurtVKnxRZ+m+LdNmZBJUkMZmGbJm+UDllDd6y
         758znNnLSewGTJNKqg6k+z/6ZdvBNVxbT0BQTPUrC/VnS0uKirH0uh+DqRl5RSEe7KQx
         kmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214405; x=1779819205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9mXL77+0mg8e6mgzNlsAvrB2ziUWBHacNwaVLem3R9Y=;
        b=jvlGcEXmPXQRwyUgm3d0NlPG9JfFi4EUif2VSJ3OUXi50dahdG4BNK3dgteehtg3nl
         8tReWMSVQCvyhsgpom/rXm514BKFXJyywZ8I6DdQvS0K/lA4z1CgqTSXe23NZ4qPDSP5
         Q1z+kekKVm9rbVpGqOrvL0iLxe+tm93B+Fvq4PYIE3VXQDPCDhac/hvaLm76i7JJxSmU
         BZO2/oWEAkXxu7A7eLh9+424pAaB73VqlJ0FmSVkCe1x/9yxYHZudfpFY5FPKEsYj/ah
         XoFqxDDmm+a4yZrmtNBx985lQPc5zN9ItnS3/wD3ZZ+Kfcuw6KE63HU7MpLXNHm6yxZt
         zXPw==
X-Gm-Message-State: AOJu0YwNN3bBDmVbyjOA4OYBDz3NzIIKvhu0CLDb+n/o8Jgi1maUFzqb
	x5q2EJPyC/ogDW+wD34teVBMpYbKz1nuxYXl9fUKXNxSlhTdqn0Lipo7
X-Gm-Gg: Acq92OHyin97JeoXw+ZCZlDpb8gmV23R9SMXuRiU41oHfELkxpBddyapwzuSgqKlPuq
	HaQLFZ7vWIF56gndlHtG0Wgb/qb48Ox+6ZlqriB9sAhiNLAonoy/1UQWdfCfE0Tks++5Na9uRg3
	r2QckvsQe5MoxDAwmH4qTieH0KDwSdt85HEmVD57/jQrMNzXT2cbs0bOQKdnt7EhXC1kEIHclyV
	9udXmZgF5cxCHFnFDiDHHXC+PzeTeRtxrDeT1ldNE7SdYU/sHEtHKgUnjg7pekSghnA79NgmmeF
	aC791nSM7pk20dkKxerVu1jWAAzmfDSq0EKtEew4TeXDEGn2JoO0Wc2QB7s70F1ezquow1DA1vG
	S/ctrxwl4mJe9xdWOwZV8rOmo5oIK8Um4k1HmnwsG1WR1+GGy5zpgyxTSSWA4ZmJBgoaA/eeIrY
	NRe6PUisV2AZDt/nF1yccndFkWhBM=
X-Received: by 2002:a53:ac82:0:b0:65e:41a4:54d2 with SMTP id 956f58d0204a3-65e41a45a4fmr13520322d50.32.1779214405014;
        Tue, 19 May 2026 11:13:25 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:39::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b11esm8170548d50.11.2026.05.19.11.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 06/14] bpf: Remove redundant dynptr arg check for helper
Date: Tue, 19 May 2026 11:13:04 -0700
Message-ID: <20260519181314.2731658-7-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289568-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ADB4058385D
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
index 89c219df6591..edebeb3ad363 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8205,26 +8205,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
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
index dbd97add5a5a..96e23c79560b 100644
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


