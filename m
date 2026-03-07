Return-Path: <netdev+bounces-265100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMgcCA7Lq2n7gwEAu9opvQ
	(envelope-from <netdev+bounces-265100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:51:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E56D22A821
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E06FF30707BC
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5888837F8BD;
	Sat,  7 Mar 2026 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1Qv9R1f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC237B03C
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865890; cv=none; b=J2CtbA67LARZPjhrctGd2LeyU4eiSmPiCyzyiWFU+5SEdd1zlYZXeIbmMhuoQq0fEZZ5XxrP71STzpf95WNiKv4iCXYzU9INLYTDk73EfZiqx8yoVveN89v8P7yh9XySDEDUivA7D9gbwpqvX6QF7ENnntq7yDTGPI4qmm1FE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865890; c=relaxed/simple;
	bh=220J2NF5yCyk7tRF95PoeS+Bz3Vq8x488ZxOVCO6gxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bph7NFaVPTchEDvpyRdrUKsvUonZZyiCR4WOxnSIacZf3WycGlc19gdWOipEVY92u/pyVHXFBEQuibQT8KuwpPrZlUTGdMJCeB0j6c13gklpkVAhaRMyyEflnAZZaHHv8ZTIxLM7lww3ylWDOw8cTQxUgDXNm2bz5Rl/g6Gg9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1Qv9R1f; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82989744ee0so2179698b3a.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865888; x=1773470688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etdBLDx36dMtVbyrSAhU63rVIi5uq5aFdbc/ugTsJBw=;
        b=K1Qv9R1fN1e+kaWl38fkUKUgv9e9uS7dCpWSR1Ur4bpDneOKZzgqhLmJtCcIoXg9wL
         Q2leoUWiAeHWoNTnuuq6ebnKMGYcjpE7kTIaXr8DEnmhB9CvvUmRYsK7D7Lgf6uTP/LO
         2zv0JXIsYukWYnhwl/pz9rCIBmtHLn0kvAfDTCbhb33efEJ1oMAnWz4kl89ViZxP7v2v
         EqOfNICGGdPP0ehFIXQMYGGvz5ZgsiygaUtYTfCCs5DMtM4KiU6ikXApcZrGO/G2rjXy
         M21q3n01ca3SjC+OGES61RrnOh6Q28MFlXqeuwqMb0ooxdJNCrwP9jincr7Lnvt0odOK
         MRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865888; x=1773470688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etdBLDx36dMtVbyrSAhU63rVIi5uq5aFdbc/ugTsJBw=;
        b=fZBEs/swOftCuE3UGtmEb7WEjqaq3Vao52cK4k5AI7Kp7Ox5DSYlosMcApX1QU++pq
         rp/QVvL2iN9bHpwJKtmjIrMxhMSaamL+F9sZj3U0Qg2ulwK36QT9FoIOEhxBJYPU24ac
         hId/79fXjMbvZsvLSMkveSjGZ89R0WsTCdU8di4r5jadpeA63auxWkFYK8etUkwGhUh4
         EjFdSj1x2D6Uji4adnwuWI4oHO7Bff7Qbv7jkjdsMVX7UUcPcOqOlxqi9MhCJpYZrphZ
         rh668vzFS/M6IbXNvilp+XIS9sFFQ1bTCw75ePlFcgB4c6eK593ZfbqvTkge7/uKompp
         AApw==
X-Gm-Message-State: AOJu0YyDOYEI69lwmvxiubUtz64DZehwQJ7lh27wzB1uHbrTy6lLTA0W
	6UCaOofDBsosauB1F3/jt4itr6uBPMO0mdse4FcXRrLXMhNAx6usDvmT
X-Gm-Gg: ATEYQzzcV5hMMJ3rWozh0Df3wK3NArPFZYtArfwDlCoxzNdd4jNVtRvLWMYmb98cItR
	Jp7+X46UcAHt48oX/rhFwwP80+n8e+Srba4jP2+c7g5ljm+dmpI31WcK5erPIgTPCqVlx96Cl4u
	sSAbM41qv9t9I6VY4vrwzquhsviz8eztTp1fl1L4XyzljZKsRH/6+uWPBdBJEOwYxFNwTj0dzRB
	IsYaqfa29o8LZUpNM3+P6m/Cgz1v7XUpabgeLH19TCMK8BpPyGQ21PIqSoRAW7vkVcv9Y4EvP8V
	7MIqz/HszmP+tUiLqXVw9uZjXzA6uqpXbDIHtdsvcymV+GT3pdhBvi+OnRZBoNE4uFkMDkimnRf
	idT8kPcvXumj8UQEn6u8QZGCcvOrNfkCW8mkkZoSBZ5iZcygRQXcbPtpACAblkngJ7a27i7JI4k
	HkBFg7yo72wK/5
X-Received: by 2002:a05:6a00:1c87:b0:81e:d7c3:2f3a with SMTP id d2e1a72fcca58-829a2f5a754mr4012267b3a.46.1772865888530;
        Fri, 06 Mar 2026 22:44:48 -0800 (PST)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4676187sm4391941b3a.27.2026.03.06.22.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:48 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 07/11] bpf: Remove redundant dynptr arg check for helper
Date: Fri,  6 Mar 2026 22:44:35 -0800
Message-ID: <20260307064439.3247440-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E56D22A821
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265100-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
index 0436fc4d9107..80b9ef6f329f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9737,26 +9737,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
 skip_type_check:
 	if (arg_type_is_release(arg_type)) {
-		if (arg_type_is_dynptr(arg_type)) {
-			struct bpf_func_state *state = func(env, reg);
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
-		} else if (!reg->ref_obj_id && !register_is_null(reg)) {
+		if (!arg_type_is_dynptr(arg_type) && !reg->ref_obj_id && !register_is_null(reg)) {
 			verbose(env, "R%d must be referenced when passed to release function\n",
 				regno);
 			return -EINVAL;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 5e1b1cf4ea8e..631e37500ec6 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -135,7 +135,7 @@ int ringbuf_missing_release_callback(void *ctx)
 
 /* Can't call bpf_ringbuf_submit/discard_dynptr on a non-initialized dynptr */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int ringbuf_release_uninit_dynptr(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -649,7 +649,7 @@ int invalid_offset(void *ctx)
 
 /* Can't release a dynptr twice */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int release_twice(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -676,7 +676,7 @@ static int release_twice_callback_fn(__u32 index, void *data)
  * within a callback function, fails
  */
 SEC("?raw_tp")
-__failure __msg("arg 1 is an unacquired reference")
+__failure __msg("Expected an initialized dynptr as arg #0")
 int release_twice_callback(void *ctx)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index 54de0389f878..e8f4ae86470f 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -146,7 +146,7 @@ try_discard_dynptr(struct bpf_dynptr *dynptr, void *context)
  * not be able to read past the end of the pointer.
  */
 SEC("?raw_tp")
-__failure __msg("cannot release unowned const bpf_dynptr")
+__failure __msg("cannot pass pointer to const bpf_dynptr, the helper mutates it")
 int user_ringbuf_callback_discard_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_discard_dynptr, NULL, 0);
@@ -166,7 +166,7 @@ try_submit_dynptr(struct bpf_dynptr *dynptr, void *context)
  * not be able to read past the end of the pointer.
  */
 SEC("?raw_tp")
-__failure __msg("cannot release unowned const bpf_dynptr")
+__failure __msg("cannot pass pointer to const bpf_dynptr, the helper mutates it")
 int user_ringbuf_callback_submit_dynptr(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, try_submit_dynptr, NULL, 0);
-- 
2.47.3


