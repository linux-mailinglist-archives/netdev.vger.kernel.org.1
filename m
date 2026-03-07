Return-Path: <netdev+bounces-265095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFTHKIHKq2n7gwEAu9opvQ
	(envelope-from <netdev+bounces-265095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:49:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A676322A7B8
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C637303E793
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D784379998;
	Sat,  7 Mar 2026 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDOKoCWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22271376BF6
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865885; cv=none; b=FxwG7jHdOw6iNFin4GWEy6R/ldQS1RHUyQa2QByAHPBQxObID8jv5iAnPQspYuzt0wUxlk0aW+q7EH1uDw/TrlbTudRYl6cFFzKY0BDsyPAjn2OnjlrZDm79/w1xwXfhOtTxIqgSCiOYL2XpzJnQ5Lpbtc7X4JssgC0QPLDuc6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865885; c=relaxed/simple;
	bh=tVYgDTwlhQGaqP5jUbtmbK0POx4ylr+E1xKOUDLHxoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpcWNzwOxyxucNDJJ4ohb5Jol9Ja0qR+TZToWvrgJcN/TOmzi4kmjWm+UetYgKlLvhcHepdtq8t75HL8uEBzqoyHWspUW9NnnCyDyiSpb9BwSQpR8f03HGTRQ2bPZfW/zi5l8xgC4Zxtihgdg/YRFvcSakuLJcFGVwNnAWKws54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDOKoCWY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35994d84c6dso2635808a91.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865883; x=1773470683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24B35N+9xKOQKPzMnszSj5WzoicfoSOub9MhHTgHYkk=;
        b=jDOKoCWYOrsnEDQKxnmrNqisDKdKekvL16xQqTDjcLiv1KmNb24Pv1dh7768HPeY6R
         d5W9Wy4jOWorr/dGqRtRH6hYBuYM2JyJl9ad6hXaHp2/KMpLTqBkwIapn6iJb79c9oAb
         VkZUT1nL+UxSj/WP4UsUZ8h3uVzF6/KSBc5hlX5DVZ7MmQ4DUxgI7sjsqi+EQ0SgclHt
         gz5h5Ru8t6xWmKWxuTzTiJLT0mzXt9sUC77S6h/9gvOSxeVbtV2Q44/Y5fBSfwmDjDZd
         B+GW1F31DXSqYxS+2ohT3kFyICWJfvCNeFIeFlTfkkntjN1MqpLbnyUtGEcYJpip1lMc
         ZOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865883; x=1773470683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24B35N+9xKOQKPzMnszSj5WzoicfoSOub9MhHTgHYkk=;
        b=VmmbGvwX/njOeIidzbcUssaOvcaVWuWmm2YgOlmjh17Mwzte526ny5uZAIDvThSu8Y
         4nm59aIhJRohHJET+A2rH8ooAJ/JHnJyYFusN1610GRj2qRqszABSdDYdAituKi72lbE
         URS3E40dDxiR+VR331UVO5vkBMzFklo0kQV+YSjZVqud8+ISgSO4Qv3HuDqBXc0tw8rP
         FU5t2uWrXlmDVnKTkS+Xql35aK/D1Qt6hRKKK1gTgDrn7mM7ecC3N0W8qv5rduwyex+z
         z+H/CjwA2ebkZSomnur0ChAml6+DOP3NLHfCi2AwU3jgs5tkH/D+7SfNkro8l6LKZ73K
         50iw==
X-Gm-Message-State: AOJu0YwFgkpXd4IEyL1jSC7TsvFx6AVx9PqIgtuNtd4iysxzVKwG0zwp
	m26tCCNquyFndcCLR+ldktEIXvDPXD16+604/c0xoHjQC2qYh9TcBDGX
X-Gm-Gg: ATEYQzxR77SzoftYGRHPNCYFK2H5l11oLCnwpiQTZd7M0VZUeFWzsI76cdrmGxFrrkg
	9v0HGtLZf/XLRrkmU44PHViAw0AqKDJ38PazzxUVZKTSvWWdYMuYqEs/bIxaXXwlLuiSBnOTWRM
	HXNBCmPGCU+RTWerW83vWPz2mojFSgVlvhUz75xmuD2/n6zS/G+Q3juHKChnt9E/RysjnMa0/po
	aFdOvm3dpSaD9kLcxyFQRpS8jVZiAolFPebdQsR+f86Aq2hwU616fC0PpM/ZdAApIQZoRtDHKo/
	Z+Wh7jIH6WfUNJr1t+/t11RXsB/VRy7Y1FeELQTqamGM4Ueo8FDBJOXnG/L7WrwbnYpH6l0hx8I
	E8CM0mZLQvNNQKXs8FfdJPJXhOvWBUzZ5MxlCY1H6xjTZRX9bHCqVE9P3jyhEaQtFovWMStYeZS
	MpH/JKXb8arh40
X-Received: by 2002:a17:90b:4acb:b0:34c:6124:3616 with SMTP id 98e67ed59e1d1-359be38b06fmr4380798a91.27.1772865883496;
        Fri, 06 Mar 2026 22:44:43 -0800 (PST)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2de7c33sm7207425a91.11.2026.03.06.22.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:43 -0800 (PST)
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
Subject: [RFC PATCH bpf-next v2 02/11] selftests/bpf: Test passing CONST_PTR_TO_DYNPTR to kfunc that may mutate dynptr
Date: Fri,  6 Mar 2026 22:44:30 -0800
Message-ID: <20260307064439.3247440-3-ameryhung@gmail.com>
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
X-Rspamd-Queue-Id: A676322A7B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265095-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Make sure for kfunc that takes mutable dynptr argument, verifier rejects
passing CONST_PTR_TO_DYNPTR to it.

Rename struct sample to test_sample to avoid a conflict with the
definition in vmlinux.h

In test_kfunc_dynptr_param.c, initialize dynptr to 0 to avoid
-Wuninitialized-const-pointer warning.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 37 +++++++++++++++----
 .../bpf/progs/test_kfunc_dynptr_param.c       |  2 +-
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 8f2ae9640886..5e1b1cf4ea8e 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1,15 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Facebook */
 
+#include <vmlinux.h>
 #include <errno.h>
 #include <string.h>
-#include <stdbool.h>
-#include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include <linux/if_ether.h>
 #include "bpf_misc.h"
 #include "bpf_kfuncs.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -46,7 +45,7 @@ struct {
 	__type(value, __u64);
 } array_map4 SEC(".maps");
 
-struct sample {
+struct test_sample {
 	int pid;
 	long value;
 	char comm[16];
@@ -95,7 +94,7 @@ __failure __msg("Unreleased reference id=4")
 int ringbuf_missing_release2(void *ctx)
 {
 	struct bpf_dynptr ptr1, ptr2;
-	struct sample *sample;
+	struct test_sample *sample;
 
 	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr1);
 	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
@@ -173,7 +172,7 @@ __failure __msg("type=mem expected=ringbuf_mem")
 int ringbuf_invalid_api(void *ctx)
 {
 	struct bpf_dynptr ptr;
-	struct sample *sample;
+	struct test_sample *sample;
 
 	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
 	sample = bpf_dynptr_data(&ptr, 0, sizeof(*sample));
@@ -315,7 +314,7 @@ __failure __msg("invalid mem access 'scalar'")
 int data_slice_use_after_release1(void *ctx)
 {
 	struct bpf_dynptr ptr;
-	struct sample *sample;
+	struct test_sample *sample;
 
 	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
 	sample = bpf_dynptr_data(&ptr, 0, sizeof(*sample));
@@ -347,7 +346,7 @@ __failure __msg("invalid mem access 'scalar'")
 int data_slice_use_after_release2(void *ctx)
 {
 	struct bpf_dynptr ptr1, ptr2;
-	struct sample *sample;
+	struct test_sample *sample;
 
 	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr1);
 	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
@@ -1993,3 +1992,25 @@ int test_dynptr_reg_type(void *ctx)
 	global_call_bpf_dynptr((const struct bpf_dynptr *)current);
 	return 0;
 }
+
+/* Cannot pass CONST_PTR_TO_DYNPTR to bpf_kfunc_dynptr_test() that may mutate the dynptr */
+__noinline int global_subprog_dynptr_mutable(const struct bpf_dynptr *dynptr)
+{
+	long ret = 0;
+
+	/* this should fail */
+	bpf_kfunc_dynptr_test((struct bpf_dynptr *)dynptr, NULL);
+	__sink(ret);
+	return ret;
+}
+
+SEC("tc")
+__failure __msg("cannot pass pointer to const bpf_dynptr, the helper mutates it")
+int kfunc_dynptr_const_to_mutable(struct __sk_buff *skb)
+{
+	struct bpf_dynptr data;
+
+	bpf_dynptr_from_skb(skb, 0, &data);
+	global_subprog_dynptr_mutable(&data);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
index c3631fd41977..1c6cfd0888ba 100644
--- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -33,7 +33,7 @@ SEC("?lsm.s/bpf")
 __failure __msg("cannot pass in dynptr at an offset=-8")
 int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
 {
-	unsigned long val;
+	unsigned long val = 0;
 
 	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)&val,
 					  (struct bpf_dynptr *)&val, NULL);
-- 
2.47.3


