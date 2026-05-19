Return-Path: <netdev+bounces-289632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHGPMF3dDGphpAUAu9opvQ
	(envelope-from <netdev+bounces-289632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:59:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0B25855EE
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA6E1302A183
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D853EDAB5;
	Tue, 19 May 2026 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Smv3yG7+"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97E3EBF39
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227968; cv=none; b=TFpWH2JuFn3Nr1sAHXaxODo31UlR0Fb3uQdhSroU6JKxN9f4w+R3HuK2hv72kGiTkvtgC1DrTfxhbJurO7phlg+ljEMKEyL9gZgzK3qOwckAj9tM24X4QbCt/bJxQ9m8nesAiVxpEEli3JFAML0agfm9cC1YU67Smt8B1y+JmKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227968; c=relaxed/simple;
	bh=jii82pnFf6eqfSj4GOUI6x7GUuRI9y+hx4Jtu9AK4lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLwQQinpSVlEerfCaRtrP+0hZCkGytoinkLTj7lZ/bvILBAg2VeHdMO8SkwimEjlrlne14xQ2p2RcQIttqFO6Tg+dGZp2U/WUe4YB2aB8pYBX6DQFg4eiFVQnm4Bchq/8EQ+5heScAFGOB0ArBXRqB4savG1QLkNJfJTytYSSxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Smv3yG7+; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779227961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2V7z+2K6tysSeORT8jb2kkNeNPE/aWcyXLfPyrNl3+k=;
	b=Smv3yG7+BAHBQ2NTxnU9jrK7q3MAnEbEmDG2hxX1US3o6SslVxl3GZgRtFoWWrut82/zj4
	SmubM6+mWdDbAG2mK/z3gGxyMIBE+hsj4u3LQ2me9yTPSi44dV0XK98AJF1b7beRCD/I8Z
	rr8dBv2P3R+bngvxmxtHEMBSuo0dR+M=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Shakeel Butt ' <shakeel.butt@linux.dev>,
	'Roman Gushchin ' <roman.gushchin@linux.dev>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH bpf-next 12/12] selftests/bpf: Test attaching struct_ops to a cgroup
Date: Tue, 19 May 2026 14:58:19 -0700
Message-ID: <20260519215841.2984970-13-martin.lau@linux.dev>
In-Reply-To: <20260519215841.2984970-1-martin.lau@linux.dev>
References: <20260519215841.2984970-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289632-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0E0B25855EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Martin KaFai Lau <martin.lau@kernel.org>

Basic tests for attaching struct_ops to cgroup.

TODO:
- more than one level of cgroup setup.
- BPF_F_BEFORE/AFTER.
- bpf_link__update_map an existing struct_ops with and without BPF_F_PREORDER.
- cgroup_bpf_inherit().

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ops.c    | 207 ++++++++++++++++++
 .../testing/selftests/bpf/progs/bpf_tcp_ops.c |  97 ++++++++
 2 files changed, 304 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
new file mode 100644
index 000000000000..ae1cb874770b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <bpf/btf.h>
+#include "cgroup_helpers.h"
+#include "bpf_tcp_ops.skel.h"
+
+#define CGROUP_PATH	"/bpf_tcp_ops"
+#define TEST_NETNS	"bpf_tcp_ops"
+
+static __s32 get_bpf_tcp_ops_type_id(void)
+{
+	struct btf *vmlinux_btf;
+	__s32 type_id;
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "load_vmlinux_btf"))
+		return -1;
+
+	type_id = btf__find_by_name_kind(vmlinux_btf, "bpf_tcp_ops", BTF_KIND_STRUCT);
+	btf__free(vmlinux_btf);
+
+	ASSERT_GT(type_id, 0, "find_bpf_tcp_ops");
+	return type_id;
+}
+
+static void reset_order(struct bpf_tcp_ops *skel)
+{
+	memset(skel->bss->listen_order, 0, sizeof(skel->bss->listen_order));
+	memset(skel->bss->connect_order, 0, sizeof(skel->bss->connect_order));
+	skel->bss->listen_cnt = 0;
+	skel->bss->connect_cnt = 0;
+}
+
+static void do_listen_connect(int family)
+{
+	const char *addr = family == AF_INET ? "127.0.0.1" : "::1";
+	int server_fd, client_fd;
+
+	server_fd = start_server(family, SOCK_STREAM, addr, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		return;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (ASSERT_OK_FD(client_fd, "connect_to_fd"))
+		close(client_fd);
+
+	close(server_fd);
+}
+
+/*
+ * Attach ops1 and ops2 normally (in that order), then ops3 with
+ * BPF_F_PREORDER. Expected execution order: [3, 1, 2] — ops3 runs
+ * first despite being attached last, ops1 before ops2 by attach order.
+ */
+static void test_order(int cgroup_fd, struct bpf_tcp_ops *skel, int family)
+{
+	LIBBPF_OPTS(bpf_cgroup_opts, preorder_opts, .flags = BPF_F_PREORDER);
+	struct bpf_link *link1 = NULL, *link2 = NULL, *link3 = NULL;
+
+	link1 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops1, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link1, "attach_ops1"))
+		goto done;
+
+	link2 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops2, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link2, "attach_ops2"))
+		goto done;
+
+	link3 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops3, cgroup_fd,
+					    &preorder_opts);
+	if (!ASSERT_OK_PTR(link3, "attach_ops3_preorder"))
+		goto done;
+
+	reset_order(skel);
+	do_listen_connect(family);
+
+	ASSERT_EQ(skel->bss->listen_cnt, 3, "listen_cnt");
+	ASSERT_EQ(skel->bss->listen_order[0], 3, "listen_order[0]");
+	ASSERT_EQ(skel->bss->listen_order[1], 1, "listen_order[1]");
+	ASSERT_EQ(skel->bss->listen_order[2], 2, "listen_order[2]");
+
+	ASSERT_EQ(skel->bss->connect_cnt, 3, "connect_cnt");
+	ASSERT_EQ(skel->bss->connect_order[0], 3, "connect_order[0]");
+	ASSERT_EQ(skel->bss->connect_order[1], 1, "connect_order[1]");
+	ASSERT_EQ(skel->bss->connect_order[2], 2, "connect_order[2]");
+
+done:
+	bpf_link__destroy(link3);
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link1);
+}
+
+static void test_query(int cgroup_fd, struct bpf_tcp_ops *skel)
+{
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	LIBBPF_OPTS(bpf_prog_query_opts, query_opts);
+	struct bpf_link *link1 = NULL, *link2 = NULL;
+	__u32 map1_id, map2_id, map_ids[2] = {};
+	__s32 type_id;
+
+	type_id = get_bpf_tcp_ops_type_id();
+	if (type_id <= 0)
+		return;
+
+	bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.tcp_ops1), &info, &info_len);
+	map1_id = info.id;
+
+	bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.tcp_ops2), &info, &info_len);
+	map2_id = info.id;
+
+	link1 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops1, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link1, "attach_ops1"))
+		goto done;
+
+	link2 = bpf_map__attach_cgroup_opts(skel->maps.tcp_ops2, cgroup_fd, NULL);
+	if (!ASSERT_OK_PTR(link2, "attach_ops2"))
+		goto done;
+
+	/* query effective: expect 2 entries in attachment order */
+	query_opts.type_id = type_id;
+	query_opts.prog_ids = map_ids;
+	query_opts.count = ARRAY_SIZE(map_ids);
+	query_opts.query_flags = BPF_F_QUERY_EFFECTIVE;
+	ASSERT_OK(bpf_prog_query_opts(cgroup_fd, BPF_STRUCT_OPS, &query_opts),
+		  "query_effective");
+	ASSERT_EQ(query_opts.count, 2, "query_effective_count");
+	ASSERT_EQ(map_ids[0], map1_id, "map_ids[0]");
+	ASSERT_EQ(map_ids[1], map2_id, "map_ids[1]");
+
+	/* query attached (non-effective): expect 2 entries */
+	memset(map_ids, 0, sizeof(map_ids));
+	query_opts.query_flags = 0;
+	query_opts.count = ARRAY_SIZE(map_ids);
+	ASSERT_OK(bpf_prog_query_opts(cgroup_fd, BPF_STRUCT_OPS, &query_opts),
+		  "query_attached");
+	ASSERT_EQ(query_opts.count, 2, "query_attached_count");
+	ASSERT_EQ(map_ids[0], map1_id, "attached_map_ids[0]");
+	ASSERT_EQ(map_ids[1], map2_id, "attached_map_ids[1]");
+
+done:
+	bpf_link__destroy(link2);
+	bpf_link__destroy(link1);
+}
+
+static void run_query_subtest(void)
+{
+	struct bpf_tcp_ops *skel = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new(TEST_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto done;
+
+	skel = bpf_tcp_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	test_query(cgroup_fd, skel);
+
+done:
+	bpf_tcp_ops__destroy(skel);
+	netns_free(ns);
+	close(cgroup_fd);
+}
+
+static void run_order_subtest(void)
+{
+	struct bpf_tcp_ops *skel = NULL;
+	struct netns_obj *ns = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup(CGROUP_PATH);
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	ns = netns_new(TEST_NETNS, true);
+	if (!ASSERT_OK_PTR(ns, "netns_new"))
+		goto done;
+
+	skel = bpf_tcp_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	test_order(cgroup_fd, skel, AF_INET);
+	test_order(cgroup_fd, skel, AF_INET6);
+
+done:
+	bpf_tcp_ops__destroy(skel);
+	netns_free(ns);
+	close(cgroup_fd);
+}
+
+void test_bpf_tcp_ops(void)
+{
+	if (test__start_subtest("query"))
+		run_query_subtest();
+	if (test__start_subtest("order"))
+		run_order_subtest();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops.c b/tools/testing/selftests/bpf/progs/bpf_tcp_ops.c
new file mode 100644
index 000000000000..80590f097143
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define MAX_CGROUP_OPS 8
+
+/* Call order for listen and connect, indexed by call sequence */
+u32 listen_order[MAX_CGROUP_OPS];
+u32 listen_cnt;
+
+u32 connect_order[MAX_CGROUP_OPS];
+u32 connect_cnt;
+
+static void record_listen(int id)
+{
+	u32 idx = listen_cnt;
+
+	if (idx < MAX_CGROUP_OPS) {
+		listen_order[idx] = id;
+		listen_cnt = idx + 1;
+	}
+}
+
+static void record_connect(int id)
+{
+	u32 idx = connect_cnt;
+
+	if (idx < MAX_CGROUP_OPS) {
+		connect_order[idx] = id;
+		connect_cnt = idx + 1;
+	}
+}
+
+/* struct_ops instance 1 */
+
+SEC("struct_ops")
+void BPF_PROG(tcp_ops1_listen, struct sock *sk)
+{
+	record_listen(1);
+}
+
+SEC("struct_ops")
+void BPF_PROG(tcp_ops1_connect, struct sock *sk)
+{
+	record_connect(1);
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops tcp_ops1 = {
+	.listen  = (void *)tcp_ops1_listen,
+	.connect = (void *)tcp_ops1_connect,
+};
+
+/* struct_ops instance 2 */
+
+SEC("struct_ops")
+void BPF_PROG(tcp_ops2_listen, struct sock *sk)
+{
+	record_listen(2);
+}
+
+SEC("struct_ops")
+void BPF_PROG(tcp_ops2_connect, struct sock *sk)
+{
+	record_connect(2);
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops tcp_ops2 = {
+	.listen  = (void *)tcp_ops2_listen,
+	.connect = (void *)tcp_ops2_connect,
+};
+
+/* struct_ops instance 3 */
+
+SEC("struct_ops")
+void BPF_PROG(tcp_ops3_listen, struct sock *sk)
+{
+	record_listen(3);
+}
+
+SEC("struct_ops")
+void BPF_PROG(tcp_ops3_connect, struct sock *sk)
+{
+	record_connect(3);
+}
+
+SEC(".struct_ops.link")
+struct bpf_tcp_ops tcp_ops3 = {
+	.listen  = (void *)tcp_ops3_listen,
+	.connect = (void *)tcp_ops3_connect,
+};
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0-Meta


