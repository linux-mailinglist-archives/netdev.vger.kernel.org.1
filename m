Return-Path: <netdev+bounces-302755-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HMJCO3uuQmqd/gkAu9opvQ
	(envelope-from <netdev+bounces-302755-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:42:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FE56DDD5D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:42:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HDICKZ50;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302755-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302755-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7ED143022C33
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A9947A0B6;
	Mon, 29 Jun 2026 17:27:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3753F47278B
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 17:27:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754052; cv=none; b=nRVfAB+2pyD7voKx8aWC4/J1bcXlrER0drAj4t//yPmt8ZyyFBjVk9fsGbbtP8/taqmeoOPY2Ro19ymEr1n7lo2WSBRyQylgnAFrrxCXdaL9vymGHJcdDALPbnLwOASJqC4sjRSPnHXXV2B4vEZw73fZa4UqPbm8LPlzSE4RsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754052; c=relaxed/simple;
	bh=BJeyjpSrE3nFrrnXnTELicRfP0xiuDtfrJZGnuaoXQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mnq7FQir/MecboZsNds1ctycqeGH1oUZuLqhPSkbifZ/12sl9JlIaDdPTX8yIGEVbzV3gdo0g1+4ZCIDXtPdZWIC+nrNWCwVaXnIWOg56uo2u8hNIG69Oax2ek1Fmd26Mi0SIYRNtcXMhwG74frft0BWq4Et11ui8h1DwyYjPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDICKZ50; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-846970f0acaso1263796b3a.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782754050; x=1783358850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfTqAPF2z3x4FKe96v+KSKZ7cZLPBUPyaVvC2qekN80=;
        b=HDICKZ50/BAkrs1cqwcM9agHV5LJ9XOP0MduaiNTH+CSH11Yk2YzPAjAkcv1c2zfDd
         gTFbrClZUivkNpJIRgvxGuCWdGHhLeNrEUQNIT5atUTQd1NvXm4F8UoXmZ5ntcSGY4xI
         YpRq3hNyy++bIwvPwJP0PzQNxmfsPXYj7h5oOMq1j8pN6lRfbz/+HVME97+wpQ0GGNVe
         hK5QRNOYmDmjOGNOJMk/YajAbhOMmDcSRd7xXVTnbtK56nDZK+Xv05geXoWp1lRSmxcQ
         Lw2mLMxbYARkcA5buG6+rkvVSk+YVU2JBHXj5W3w8JA+OmR9mgIsEkiK5OuBQIZM104Z
         mydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754050; x=1783358850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SfTqAPF2z3x4FKe96v+KSKZ7cZLPBUPyaVvC2qekN80=;
        b=PBQqUymwMSPyYbHNvv6I4qbiZDkt2aq7+9taxC3w6+2WUhNIJ7V/I6kzmLWSBd6sLK
         jWVbeUEO8P5QtJaKfZ2DPLrzy0s8CJQQfXs5K37RVtTWzZQCBwLLIKPdH+H6wzazLMSB
         igg5eR/Ccj0+dgDU4ltot4PxyAYrtLo5yOy6RIpwvVYpgG/3cw/rhRW0wSochcYN9pS2
         mFJP4sxGBIbzXsdEoMa8kPlAUoibOy45Y2WjBtNh2fTnuIn7rtZfm43WjV5XVGramvjW
         bH1A9wXplj4q0oVFVSmEYuQcNboVBibWzxNC8OqtiJXzBDCRX55xYYz7CWDZEukCBSsN
         So/A==
X-Forwarded-Encrypted: i=1; AFNElJ9z0xCn9smWPdIA0vPOYudmB8XVJZSl4A6y3Y/qYTWUgPffos+8MMjgCE42cT3+aaPX+KlP4vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywip7P7C/r6ghoOi5IOxOmPciiLVgpA15fAx72A3WbWidOktocs
	CXMCI+jdMwCdtqMwhkoQMWHrYRkE9xqDNwgAMi5zUE6KSJ2TVN7f0m0v
X-Gm-Gg: AfdE7clRNeeutTZ7fUWuvFzGrn/h2z+ndGQsqmr73IAf/tgcTqWx1pRWMA4qhvzgmwz
	isnPgRgUJx2kFnH/2nPFIXqTRpzN8czzXykWwEsQnOiHhH/6N9X55RMYjV03MU7BTYQ6LIXZkJL
	lJbuP+9aaQxrYeFTprE5RCmufyse3cKfM1PhTt6PO7lD3koUBGrzaQpYTXpcGLx8gwe/Ww3B4nM
	PfRSr5G9lEMW9/4TkAFqs4Wr1XOWvsq9Op4Z5KZFDQygS94Yoc5GyckT1DNvIIy4zX/tAYYo5WV
	SkavH4XWlXcE1sSBiqNJduY5WnrA+DVFwwQqr1Du+49Aqa/hMlx8oYHO7nx5ktF8HX/u1FhksC4
	b8KiguBzvhNDoMia4vqb4HN0nNRoaAx6NpgvNpPxixpPlTbq1CADnGX143wpYlxFiS9tXb30KxQ
	7VG0Jt/GoQ3W6hBzKakj3S+t3JxhByEukkehRLa0iv4y+9YiMfuZrVdatdx+8Q1Q==
X-Received: by 2002:a05:6a00:368e:b0:845:4fec:3f8f with SMTP id d2e1a72fcca58-8479f27b7d6mr294845b3a.40.1782754050415;
        Mon, 29 Jun 2026 10:27:30 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a039f2afsm78542b3a.53.2026.06.29.10.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:27:30 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Lorenz Bauer <lmb@isovalent.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: drop tc/xdp/flow_dissector sockmap mutation tests
Date: Mon, 29 Jun 2026 17:27:01 +0000
Message-ID: <20260629172704.1302218-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
References: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302755-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:eddyz87@gmail.com,m:memxor@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:sdf@fomichev.me,m:emil@etsalapatis.com,m:lmb@isovalent.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:shuah@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00FE56DDD5D

tc, xdp and flow_dissector programs can no longer update or delete a
sockmap. Adjust the tests:

 - verifier_sockmap_mutate: the tc, xdp and flow_dissector cases now
   expect __failure with "cannot update sockmap in this context".
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
 .../bpf/progs/verifier_sockmap_mutate.c       | 10 ++--
 5 files changed, 5 insertions(+), 152 deletions(-)
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
index fe4b123187b8..b11026123690 100644
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


