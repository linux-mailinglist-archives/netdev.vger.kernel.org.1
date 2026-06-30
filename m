Return-Path: <netdev+bounces-303268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DLGVOf/ZQ2rjkAoAu9opvQ
	(envelope-from <netdev+bounces-303268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:00:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB9D6E5AB5
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:00:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="oDp6Krr/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303268-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303268-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FF02317A05E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FE843E4B4;
	Tue, 30 Jun 2026 14:54:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A45D43E4B1
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:54:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831279; cv=none; b=Jquuiopjggg2Ve0aPQJ1j4kcckGI6j2rjyeIJlffl6Dv1mEgCpZes2n+dGIbsB46Uuxgk6qhBkKmtPCcxKNM7/6ZdkiC82AifOKxmDacc6fO7tcsNHpJM6skMfMe4aPK4ePevREQn8jm46lB3tqyeE+OxZ5IKjQmNCTA8Oes1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831279; c=relaxed/simple;
	bh=6fpn34AYa5a4NP99AEz19Q2ZqyMidgD7TtSO++tV3ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk93/AHmu/YQ2gLhHk0g6WX1cfeKCbtYnU1gF1MetRx3unOdUFN7a9Uj8iVWtOlzwCbiH0oetI5qjyQH7rKrn/2GYr129ELFqONb0+Yj7QuphAgxv0/vvVUiMqhhKUysZ7uPFw1QW4O7pINVpww2nR7wfF/x+iGgy8rhV+r1ni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDp6Krr/; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so443866a91.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782831276; x=1783436076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ8Fq141v51trmI2n1AyrBm7+0CWWqtlV8J+t5ivkWw=;
        b=oDp6Krr/zu0QGqyCQyDqG6h2gEBw0tbDrt7RTbJ+367iKPPfUCZVbqgSX4iwCjJzuU
         yT1h3nygJ0/mrmK4bR9WnggBIty8xC21xEx3fQFjGq2KLW8R3OrIksCQ+5Qex5rnQh5I
         QzMYyFX3pkJSees9bMy9i2AXzi9uT0M00GvmIcaw3YICyp6wPV/hsrbHLtSNzDYZVHmc
         VTAZsGPFj1GIbGjm+rh3vohMIRIs9u1dG+SehPOTUOpGyhphf3I9j9q2qQMSMBBxfYTS
         onxKnkiStt7CEGWQwxZZF2ikwO8zsUiFmmAPQ3M2T++PfqEdKjrlJHR48StFTrx6D+dx
         vv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782831276; x=1783436076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZ8Fq141v51trmI2n1AyrBm7+0CWWqtlV8J+t5ivkWw=;
        b=pTmwTFOKki5yIYSjGan+wq5t1Q/NCtWOQLd/qUy934JlV03DVFJPRYMEBQfVQ32OZH
         sRqW42/o5vHlcezOcRotFc++wliKp+G6uxVBdwTiiLAQ4AiYzQdOz/xLlYFEbP0hga4R
         BPtOVs7rFoQPXpc8Fn/CVwRMRd9zd/8qUf9JPU3UFRo37+kPE/XXlHdalg6APvL/Clek
         pAf3kgG1xSYlzqkXfXqBbg5DUi3gFI3t0gtJZvrut4kWuWHiuGbj0wSIQKOSHP7yPwLn
         Z5T8sftej7XWvCJVYunT5y3CJzVbnfRNUFicd+JGx5sxOdX+2PQlDl5fstXwBy6xUtdC
         cJcw==
X-Forwarded-Encrypted: i=1; AHgh+Rrz3bluGcq+lodq8xuajvsLv1mrxbycjWmjSgwWLugnmXsm8GR+Hpb4lPyba/dtMMYwZ+uTDT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmA7M2dfnruyq8QoUO8bEKgKPT5Z8Ndm+w4OTtOqr2uRQEs5TD
	tPvKRhgdWeQG7eBoHHkJR1t0z3qpGHsfB1Hsqf7qnqwJa30QuyCp80Du
X-Gm-Gg: AfdE7cnXlKO9ssQrTbWfpTiKtGLmA6nZR41RePNr9og3Hu0NG41APARmqt7Ib24AoTo
	i3mQvDvLBM4N/hvbEifIHqBjMoWvCsHFuG8auuavx5MwmZtEhhc4Vkqop6pfOZ136iMF8Y/+xyQ
	zGC7Ce8/yxyZkbs/p+zXOJKViv8tjJ1vX4zZ2zINNYruZIA0NQ+FsDakatgCB1UANWUi9BjDDQt
	ZU1yuNv/hqhff6Nv5HzaCUFhBuxob1xQOvgfaAtTSG60CTeCLGaJJfzen6jBzWcNHVpCevEDS0E
	q4upuAOBUtAiDXknGPn8G0UhBWnYboHKkt1L70Vc1BMuZk3PLCaEy2UaolTu2eIh3hHKUMGTHXO
	bE6mKq0iCzpozSaJVbxsRPlfV5XVgDzFcjA0RekDMi7//rmQDDsf/ACsQEiVssM/HnV7Qs8ixVJ
	4XOIcY1kQKJmgkZBB57GhT6Md1RcEObVtcN7/jeCNYbCKvDJJ1cf8=
X-Received: by 2002:a17:90b:520d:b0:36d:c138:e0a0 with SMTP id 98e67ed59e1d1-38067336c32mr1690613a91.2.1782831276383;
        Tue, 30 Jun 2026 07:54:36 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095b684basm20122a91.1.2026.06.30.07.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:54:35 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: drop tc/xdp/flow_dissector/socket_filter sockmap mutation tests
Date: Tue, 30 Jun 2026 14:54:06 +0000
Message-ID: <20260630145410.3648099-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303268-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:john.fastabend@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:shuah@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:sdf@fomichev.me,m:jiayuan.chen@linux.dev,m:varunrmallya@gmail.com,m:ihor.solodrai@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,etsalapatis.com,fomichev.me,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AB9D6E5AB5

tc, xdp, socket_filter and flow_dissector programs can no longer update
or delete a sockmap. Adjust the tests:

 - verifier_sockmap_mutate: the tc, xdp, socket_filter and
   flow_dissector cases now expect __failure with "cannot update sockmap
   in this context".
 - sockmap_basic: drop "sockmap update" / "sockhash update", which load
   a SEC("tc") program that copies a sock between maps.
 - fexit_bpf2bpf: drop "func_sockmap_update", whose freplace program
   updates a sockmap in the tc cls_redirect context.

Remove the now-unused test_sockmap_update.c and freplace_cls_redirect.c.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 13 -----
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 52 -------------------
 .../bpf/progs/freplace_cls_redirect.c         | 34 ------------
 .../selftests/bpf/progs/test_sockmap_update.c | 48 -----------------
 .../bpf/progs/verifier_sockmap_mutate.c       | 12 ++---
 5 files changed, 6 insertions(+), 153 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_update.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 92c20803ea76..d3a954158c33 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -336,17 +336,6 @@ static void test_fmod_ret_freplace(void)
 }
 
 
-static void test_func_sockmap_update(void)
-{
-	const char *prog_name[] = {
-		"freplace/cls_redirect",
-	};
-	test_fexit_bpf2bpf_common("./freplace_cls_redirect.bpf.o",
-				  "./test_cls_redirect.bpf.o",
-				  ARRAY_SIZE(prog_name),
-				  prog_name, false, NULL);
-}
-
 static void test_func_replace_void(void)
 {
 	const char *prog_name[] = {
@@ -599,8 +588,6 @@ void serial_test_fexit_bpf2bpf(void)
 		test_func_replace();
 	if (test__start_subtest("func_replace_verify"))
 		test_func_replace_verify();
-	if (test__start_subtest("func_sockmap_update"))
-		test_func_sockmap_update();
 	if (test__start_subtest("func_replace_return_code"))
 		test_func_replace_return_code();
 	if (test__start_subtest("func_map_prog_compatibility"))
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index cb3229711f93..33f788e2786d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -7,7 +7,6 @@
 
 #include "test_progs.h"
 #include "test_skmsg_load_helpers.skel.h"
-#include "test_sockmap_update.skel.h"
 #include "test_sockmap_invalid_update.skel.h"
 #include "test_sockmap_skb_verdict_attach.skel.h"
 #include "test_sockmap_progs_query.skel.h"
@@ -235,53 +234,6 @@ static void test_skmsg_helpers_with_link(enum bpf_map_type map_type)
 	test_skmsg_load_helpers__destroy(skel);
 }
 
-static void test_sockmap_update(enum bpf_map_type map_type)
-{
-	int err, prog, src;
-	struct test_sockmap_update *skel;
-	struct bpf_map *dst_map;
-	const __u32 zero = 0;
-	char dummy[14] = {0};
-	LIBBPF_OPTS(bpf_test_run_opts, topts,
-		.data_in = dummy,
-		.data_size_in = sizeof(dummy),
-		.repeat = 1,
-	);
-	__s64 sk;
-
-	sk = connected_socket_v4();
-	if (!ASSERT_NEQ(sk, -1, "connected_socket_v4"))
-		return;
-
-	skel = test_sockmap_update__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "open_and_load"))
-		goto close_sk;
-
-	prog = bpf_program__fd(skel->progs.copy_sock_map);
-	src = bpf_map__fd(skel->maps.src);
-	if (map_type == BPF_MAP_TYPE_SOCKMAP)
-		dst_map = skel->maps.dst_sock_map;
-	else
-		dst_map = skel->maps.dst_sock_hash;
-
-	err = bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST);
-	if (!ASSERT_OK(err, "update_elem(src)"))
-		goto out;
-
-	err = bpf_prog_test_run_opts(prog, &topts);
-	if (!ASSERT_OK(err, "test_run"))
-		goto out;
-	if (!ASSERT_NEQ(topts.retval, 0, "test_run retval"))
-		goto out;
-
-	compare_cookies(skel->maps.src, dst_map);
-
-out:
-	test_sockmap_update__destroy(skel);
-close_sk:
-	close(sk);
-}
-
 static void test_sockmap_invalid_update(void)
 {
 	struct test_sockmap_invalid_update *skel;
@@ -1385,10 +1337,6 @@ void test_sockmap_basic(void)
 		test_skmsg_helpers(BPF_MAP_TYPE_SOCKMAP);
 	if (test__start_subtest("sockhash sk_msg load helpers"))
 		test_skmsg_helpers(BPF_MAP_TYPE_SOCKHASH);
-	if (test__start_subtest("sockmap update"))
-		test_sockmap_update(BPF_MAP_TYPE_SOCKMAP);
-	if (test__start_subtest("sockhash update"))
-		test_sockmap_update(BPF_MAP_TYPE_SOCKHASH);
 	if (test__start_subtest("sockmap update in unsafe context"))
 		test_sockmap_invalid_update();
 	if (test__start_subtest("sockmap copy"))
diff --git a/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c b/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
deleted file mode 100644
index 7e94412d47a5..000000000000
--- a/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2020 Facebook
-
-#include <linux/stddef.h>
-#include <linux/bpf.h>
-#include <linux/pkt_cls.h>
-#include <bpf/bpf_endian.h>
-#include <bpf/bpf_helpers.h>
-
-struct {
-	__uint(type, BPF_MAP_TYPE_SOCKMAP);
-	__type(key, int);
-	__type(value, int);
-	__uint(max_entries, 2);
-} sock_map SEC(".maps");
-
-SEC("freplace/cls_redirect")
-int freplace_cls_redirect_test(struct __sk_buff *skb)
-{
-	int ret = 0;
-	const int zero = 0;
-	struct bpf_sock *sk;
-
-	sk = bpf_map_lookup_elem(&sock_map, &zero);
-	if (!sk)
-		return TC_ACT_SHOT;
-
-	ret = bpf_map_update_elem(&sock_map, &zero, sk, 0);
-	bpf_sk_release(sk);
-
-	return ret == 0 ? TC_ACT_OK : TC_ACT_SHOT;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_update.c b/tools/testing/selftests/bpf/progs/test_sockmap_update.c
deleted file mode 100644
index 6d64ea536e3d..000000000000
--- a/tools/testing/selftests/bpf/progs/test_sockmap_update.c
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2020 Cloudflare
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-
-struct {
-	__uint(type, BPF_MAP_TYPE_SOCKMAP);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u64);
-} src SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_SOCKMAP);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u64);
-} dst_sock_map SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_SOCKHASH);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u64);
-} dst_sock_hash SEC(".maps");
-
-SEC("tc")
-int copy_sock_map(void *ctx)
-{
-	struct bpf_sock *sk;
-	bool failed = false;
-	__u32 key = 0;
-
-	sk = bpf_map_lookup_elem(&src, &key);
-	if (!sk)
-		return SK_DROP;
-
-	if (bpf_map_update_elem(&dst_sock_map, &key, sk, 0))
-		failed = true;
-
-	if (bpf_map_update_elem(&dst_sock_hash, &key, sk, 0))
-		failed = true;
-
-	bpf_sk_release(sk);
-	return failed ? SK_DROP : SK_PASS;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
index fe4b123187b8..20332a731d4e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
@@ -74,7 +74,7 @@ static __always_inline void test_sockmap_lookup_and_mutate(void)
 }
 
 SEC("action")
-__success
+__failure __msg("cannot update sockmap in this context")
 int test_sched_act(struct __sk_buff *skb)
 {
 	test_sockmap_mutate(skb->sk);
@@ -82,7 +82,7 @@ int test_sched_act(struct __sk_buff *skb)
 }
 
 SEC("classifier")
-__success
+__failure __msg("cannot update sockmap in this context")
 int test_sched_cls(struct __sk_buff *skb)
 {
 	test_sockmap_mutate(skb->sk);
@@ -90,7 +90,7 @@ int test_sched_cls(struct __sk_buff *skb)
 }
 
 SEC("flow_dissector")
-__success
+__failure __msg("cannot update sockmap in this context")
 int test_flow_dissector_delete(struct __sk_buff *skb __always_unused)
 {
 	test_sockmap_delete();
@@ -98,7 +98,7 @@ int test_flow_dissector_delete(struct __sk_buff *skb __always_unused)
 }
 
 SEC("flow_dissector")
-__failure __msg("program of this type cannot use helper bpf_sk_release")
+__failure __msg("cannot update sockmap in this context")
 int test_flow_dissector_update(struct __sk_buff *skb __always_unused)
 {
 	test_sockmap_lookup_and_update(); /* no access to skb->sk */
@@ -146,7 +146,7 @@ int test_sk_reuseport(struct sk_reuseport_md *ctx)
 }
 
 SEC("socket")
-__success
+__failure __msg("cannot update sockmap in this context")
 int test_socket_filter(struct __sk_buff *skb)
 {
 	test_sockmap_mutate(skb->sk);
@@ -179,7 +179,7 @@ int test_sockops_update_dedicated(struct bpf_sock_ops *ctx)
 }
 
 SEC("xdp")
-__success
+__failure __msg("cannot update sockmap in this context")
 int test_xdp(struct xdp_md *ctx __always_unused)
 {
 	test_sockmap_lookup_and_mutate();
-- 
2.43.0


