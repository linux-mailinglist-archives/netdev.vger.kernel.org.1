Return-Path: <netdev+bounces-305173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gOUAGqb5S2q0dwEAu9opvQ
	(envelope-from <netdev+bounces-305173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:53:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B213A714B25
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:53:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=R7LLjrD1;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305173-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305173-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9220343F7CF
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B0C3B7778;
	Mon,  6 Jul 2026 17:20:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E158430306
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:20:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358402; cv=none; b=eYotiWjvId1npdNnD1Etv54MnJ2Nyw5alk/mnq0EyHzh/XHJjKpuG45CeVnamzNf5u9dAdVcq9M9Mzud/teIiqCtD7fdfUrghdibmRMdEyqPrb14K0kC2yw7egkqCPcZVzTiioDstwbH5i9WSM54VeuJwDOfH0BgdzFD3jp/6sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358402; c=relaxed/simple;
	bh=DRI9lTXlNY8X+aZ/TtlGehyx9dfo6ufCxum4m0pIEhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGhYCMwtMlH4ETQMy2ZQ+pGYUQDg9Az0oo66ruH8PLc59/oOYSQso7dmX+poxMuKsU6JVKMb2JhnznTzWZ71rVs7KckE4Ld328376oWHcUunAt2JXu1AkrOhpXDTq1kqUKqcu7i8lQ9WJfi09ecG4BFoFT0vmYPFv+8Of5K3wr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7LLjrD1; arc=none smtp.client-ip=209.85.161.49
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a1888969ddso1897230eaf.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358399; x=1783963199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihmVpVi5dMWw2IgjLFhZZAh/H0Js4t1Vws4EjykXpCU=;
        b=R7LLjrD1yuPaglAkYEnE9ROV3xdJ9kvduHgSHRzMYucCBLwHf0lioNfTtIsMMQ+lIC
         VnzeRU9/xBlQ/hN9Z4fJD45XBVJGmaNU7Y6p3CUKZL0FL0Z/vX2dRuJ72lGtMq/aqB6e
         QRhHb7m5IJqmRgW971MzPni3dTQHNnMZddP4mFD6A4dHZVxcp5nAtQlhMvfmXtdMrEoY
         zmEJqprzXbN8Q5tKnY37biqGx8i0JLFtg74MJagVQojOpPKf+HNtOGyl2THqDAzKi8z5
         9kBESa5JZPLd5+wHcjUGqlHJaQsn3hBp1x6AzhbEC0M7Ayh7jql3Pcp0jUiA3MhT9uF1
         IvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358399; x=1783963199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihmVpVi5dMWw2IgjLFhZZAh/H0Js4t1Vws4EjykXpCU=;
        b=qRJJ8LKbgqI6qiroHZxqYAOMmmJHDERk34mhq8s/vKQpbuk5gM4Z11GTE8RVhWlNrp
         EwhxM7ok93e+wzNqS0sPaNJsmwpU/c9AocH/0GXJSB63VrIUTqc9/Un8r/1iW1N9KQMn
         pEXaK7gbte7SmBdIkEBekECClT0P7XWyMAH3Ma+vZMBLoJesxAQrOiKByAL+EEXsb2Pn
         Y2gpAxvR+qcaXSyZaHpzzrykhZZEVtaeHWx/7YGg2ye7k8Kyk+238qB5CX54Qu12QACk
         t+LqzFnoTjLCK8PumnLl2E2wU4zMaldwoFtOUd9oj6b8i5cW+M2ogNCIbLtK+L2VNXHI
         Dy6Q==
X-Gm-Message-State: AOJu0YzEzZ0gggkunJ4WP440jXjIiUQjGHyHSEER8LQF4qzmdd/Q64BP
	WtBZiCqIJiuy027iU4uKuIAF8LPVpwTiNSw6lqvp4pwq5I9dtw7yW7IT
X-Gm-Gg: AfdE7cmKrg/43qJngVptTQi0QESDwHrkZyFN/T+RxdigmJyVCjYivd8OwiPSF0qBCf0
	r48GGVmnQ/sqpGSKZC4igNbH0+EM7i6EgoKyLe62+EVvZ19lm3FEFi+CVxYh9iBsug/YVejJM7x
	bkuUHWfUFrY8pTc3BdGASuGx1JUeJfpi1nNnPZJa8T1rTLdtLSytK7rmwdKt0KYr5DH6OXL8Etw
	cPFhVS8MPIXD5FkvB0I0nPwPqEmpacQ4ZFPwriYKLNgzXVcD05VHm/ILaS6CU4Ub4TWfHqbdqm6
	n8ASDLwfjY0vVVEchFoNBD9WpiDUV/RCR60NuMPNsjEyq+BEFvYGa1c+gKFJk4AMX3s33F4Vr/E
	F0CFWIQSEultJNxUPPi9e/8HMdCAa58HsGt7oqztv0p9x545uvTcBz9sAfnbGo2XEGGhm7nPyiI
	kXHNU=
X-Received: by 2002:a05:6820:a0e:b0:6a3:10fc:766d with SMTP id 006d021491bc7-6a35538cd00mr888205eaf.47.1783358399391;
        Mon, 06 Jul 2026 10:19:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a32132dae4sm7233935eaf.1.2026.07.06.10.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:58 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 15/15] selftests/bpf: Add test for bpf_tcp_ops header option hooks
Date: Mon,  6 Jul 2026 10:19:17 -0700
Message-ID: <20260706171918.317102-16-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-305173-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B213A714B25

Add a test exercising the bpf_tcp_ops parse_hdr, hdr_opt_len and
write_hdr_opt members together with the header option helpers.

The struct_ops program (progs/bpf_tcp_ops_hdr.c) reserves space in
hdr_opt_len via bpf_reserve_hdr_opt(), writes an experimental option in
write_hdr_opt via bpf_store_hdr_opt(), and recovers it in parse_hdr via
bpf_load_hdr_opt() on the incoming skb. Each hook bumps a counter and the
parse hook records the option payload, so the three callbacks and all
three overloaded helpers are covered.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/bpf_tcp_ops_hdr.c          | 77 +++++++++++++++++
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     | 83 +++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
new file mode 100644
index 000000000000..244605e69e40
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "cgroup_helpers.h"
+#include "bpf_tcp_ops_hdr.skel.h"
+
+#define CGROUP_PATH	"/bpf_tcp_ops_hdr"
+#define TEST_NETNS	"bpf_tcp_ops_hdr"
+
+#define TEST_OPT_D0	0xAB
+#define TEST_OPT_D1	0xCD
+
+static void run_hdr_opt(void)
+{
+	struct bpf_tcp_ops_hdr *skel = NULL;
+	struct bpf_link *link = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd, lfd = -1, fd = -1;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new(TEST_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto done;
+
+	skel = bpf_tcp_ops_hdr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	link = bpf_map__attach_cgroup_opts(skel->maps.test_hdr_ops, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link, "attach_cgroup"))
+		goto done;
+
+	/*
+	 * One direction of data is enough to exercise all hooks: both peers
+	 * share the cgroup struct_ops, so the sender runs hdr_opt_len/write
+	 * and the receiver runs parse.
+	 */
+	lfd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
+	if (!ASSERT_GE(lfd, 0, "start_server"))
+		goto done;
+
+	fd = connect_to_fd(lfd, 0);
+	if (!ASSERT_OK_FD(fd, "connect_to_fd"))
+		goto done;
+
+	if (!ASSERT_OK(send_recv_data(lfd, fd, 64), "send_recv_data"))
+		goto done;
+
+	/* Reserve + write hooks ran while sending. */
+	ASSERT_GT(skel->bss->hdr_opt_len_cnt, 0, "hdr_opt_len_cnt");
+	ASSERT_GT(skel->bss->write_cnt, 0, "write_cnt");
+	/* Parse hook ran and recovered our option on the receive side. */
+	ASSERT_GT(skel->bss->parse_cnt, 0, "parse_cnt");
+	ASSERT_GT(skel->bss->found_cnt, 0, "found_cnt");
+	ASSERT_EQ(skel->bss->found_d0, TEST_OPT_D0, "found_d0");
+	ASSERT_EQ(skel->bss->found_d1, TEST_OPT_D1, "found_d1");
+
+done:
+	if (fd >= 0)
+		close(fd);
+	if (lfd >= 0)
+		close(lfd);
+	bpf_link__destroy(link);
+	bpf_tcp_ops_hdr__destroy(skel);
+	netns_free(ns);
+	close(cgroup_fd);
+}
+
+void test_bpf_tcp_ops_hdr(void)
+{
+	run_hdr_opt();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
new file mode 100644
index 000000000000..46618a604d96
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* Experimental option kind and payload written/parsed by this test. */
+#define TEST_OPT_KIND	0xFD
+#define TEST_OPT_LEN	4
+#define TEST_OPT_D0	0xAB
+#define TEST_OPT_D1	0xCD
+
+int hdr_opt_len_cnt;
+int write_cnt;
+int parse_cnt;
+int found_cnt;
+__u8 found_d0;
+__u8 found_d1;
+
+SEC("struct_ops")
+void BPF_PROG(test_hdr_opt_len, struct sock *sk, struct sk_buff *skb,
+	      struct request_sock *req, struct sk_buff *syn_skb,
+	      enum tcp_synack_type synack_type, unsigned int *remaining)
+{
+	hdr_opt_len_cnt++;
+
+	/* Reserve TEST_OPT_LEN bytes; the helper decrements *remaining. Stacks
+	 * with other progs in the cgroup hierarchy.
+	 */
+	bpf_reserve_hdr_opt(ctx, TEST_OPT_LEN, 0);
+}
+
+SEC("struct_ops")
+void BPF_PROG(test_write_hdr_opt, struct sock *sk, struct sk_buff *skb,
+	      struct request_sock *req, struct sk_buff *syn_skb,
+	      enum tcp_synack_type synack_type, __u32 opt_off)
+{
+	__u8 opt[TEST_OPT_LEN] = {
+		TEST_OPT_KIND, TEST_OPT_LEN, TEST_OPT_D0, TEST_OPT_D1,
+	};
+
+	/* bpf_store_hdr_opt() takes the program ctx (the kernel reads the
+	 * outgoing skb from it); it appends after any options already written
+	 * in the reserved window, rejects duplicates, and confines the write to
+	 * the header option scratch. Stacks across progs in the cgroup hierarchy.
+	 */
+	if (bpf_store_hdr_opt(ctx, opt, sizeof(opt), 0))
+		return;
+
+	write_cnt++;
+}
+
+SEC("struct_ops")
+void BPF_PROG(test_parse_hdr, struct sock *sk, struct sk_buff *skb)
+{
+	__u8 opt[TEST_OPT_LEN] = {
+		TEST_OPT_KIND, TEST_OPT_LEN, TEST_OPT_D0, TEST_OPT_D1,
+	};
+
+	parse_cnt++;
+
+	/* Look up the experimental option written by test_write_hdr_opt() in
+	 * the incoming skb. For an experimental kind the search matches on the
+	 * 2-byte magic in opt[2..3]; on a match the found option is copied back
+	 * into opt[].
+	 */
+	if (bpf_load_hdr_opt(ctx, opt, sizeof(opt), 0) < 0)
+		return;
+
+	found_d0 = opt[2];
+	found_d1 = opt[3];
+	found_cnt++;
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops test_hdr_ops = {
+	.hdr_opt_len	= (void *)test_hdr_opt_len,
+	.write_hdr_opt	= (void *)test_write_hdr_opt,
+	.parse_hdr	= (void *)test_parse_hdr,
+};
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0


