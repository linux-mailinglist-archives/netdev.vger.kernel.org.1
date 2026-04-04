Return-Path: <netdev+bounces-275379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBTeJO0b0WlVFQcAu9opvQ
	(envelope-from <netdev+bounces-275379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 16:10:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D21839B4F7
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 16:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2915300E5FA
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 14:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC2A34FF62;
	Sat,  4 Apr 2026 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q+ChptpM"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D22ED15D
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775311850; cv=none; b=q8A0YPd2lndJoA6Y6AvV97A0IETBk5QJ7E+vJaCGB7jgPfqLqk+Hc2/qC3ywn0ovf6ydmAR8JSKAfJDXxwszQA9n9cRNzqCFym6E/g5M8EuWyST080UX0V8W2lI9+Eh7X8Ba3Uy7AY9gsfSwEQWSwnCMxekhqJvzihLJkbRth1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775311850; c=relaxed/simple;
	bh=KTWo3PndBl8l0Yr/7vBW3BHEP5AtXJC9ZGj0azdh7p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Htn6g2J9Hiz4H+1NfyGIc3bdCgX419XEIYg1MrMV9XqQ9kuNLFENLo/mbeThA5hc2KeUA6G5PZk+TSy8xtOc0uWoGE1oXQR6FOPB1X8/exmWjlm0ehRo8LrRqCJfoBKYReQjJr1RGsTr9rd8SjDM02teSX+EK5RujWOw2LARims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q+ChptpM; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775311846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTxm1gO+uQokVa5ZTkfG5P++4Zf4NZJ7ANI/E5qXuqU=;
	b=Q+ChptpMm8TkwMfguv8zzDyml9s6V/71ZSNH05t8F+uG/5Zde4EbJi0ab2QZmtClzzSKmA
	5eI3hYAnIyXYtvCgmNiUdUj2gQfmhnB65RPhnFP7zoS2E5fxjRQUtxCRn6Q2zyceNt76NO
	nkp9Dqr9Arghme9SOtYvLUetYUVD4yk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v1 2/2] selftests/bpf: Add test for SOCK_OPS_GET_SK with same src/dst register
Date: Sat,  4 Apr 2026 22:09:36 +0800
Message-ID: <20260404141010.247536-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260404141010.247536-1-jiayuan.chen@linux.dev>
References: <20260404141010.247536-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,fomichev.me,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-275379-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D21839B4F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a selftest that verifies SOCK_OPS_GET_SK() correctly returns NULL
when dst_reg == src_reg and is_fullsock == 0.

The BPF program reads ctx->is_fullsock, then loads ctx->sk using the
same register for source and destination. When is_fullsock == 0, sk
must be NULL. The test triggers this path via a TCP handshake (which
causes TCP_NEW_SYN_RECV state) and checks:
 - null_seen == 1: the is_fullsock==0 path was hit with correct NULL sk
 - bug_detected == 0: sk was never non-NULL when is_fullsock==0

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../bpf/prog_tests/sock_ops_get_sk.c          | 62 +++++++++++++++++++
 .../selftests/bpf/progs/sock_ops_get_sk.c     | 44 +++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_ops_get_sk.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c b/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
new file mode 100644
index 0000000000000..9eaf97786c1d9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+#include "sock_ops_get_sk.skel.h"
+
+/*
+ * Test that reading ctx->sk with dst_reg == src_reg in a sock_ops program
+ * correctly returns NULL when is_fullsock == 0 (TCP_NEW_SYN_RECV state).
+ *
+ * The bug was in SOCK_OPS_GET_SK() macro which failed to zero the destination
+ * register when it was the same as the source register and the socket was not
+ * a full socket. This left the ctx pointer in the register, which then passed
+ * the NULL check and could be used as a socket pointer, causing OOB access.
+ */
+void test_sock_ops_get_sk(void)
+{
+	struct sock_ops_get_sk *skel;
+	int cgroup_fd, server_fd, client_fd;
+	int prog_fd, err;
+
+	cgroup_fd = test__join_cgroup("/sock_ops_get_sk");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	skel = sock_ops_get_sk__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
+		goto close_cgroup;
+
+	prog_fd = bpf_program__fd(skel->progs.sock_ops_get_sk_same_reg);
+	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
+	if (!ASSERT_OK(err, "prog_attach"))
+		goto destroy_skel;
+
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto detach;
+
+	/* Trigger TCP handshake which causes TCP_NEW_SYN_RECV state where
+	 * is_fullsock == 0. With the bug, ctx->sk loaded with same src/dst
+	 * register would return a stale ctx pointer instead of NULL.
+	 */
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
+		goto close_server;
+
+	close(client_fd);
+
+	/* Verify that the is_fullsock == 0 path was hit and sk was NULL */
+	ASSERT_EQ(skel->bss->null_seen, 1, "null_seen");
+	ASSERT_EQ(skel->bss->bug_detected, 0, "bug_not_detected");
+
+close_server:
+	close(server_fd);
+detach:
+	bpf_prog_detach(cgroup_fd, BPF_CGROUP_SOCK_OPS);
+destroy_skel:
+	sock_ops_get_sk__destroy(skel);
+close_cgroup:
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/sock_ops_get_sk.c b/tools/testing/selftests/bpf/progs/sock_ops_get_sk.c
new file mode 100644
index 0000000000000..4a75614b21eb5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_ops_get_sk.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/*
+ * Test that SOCK_OPS_GET_SK() correctly returns NULL when dst_reg == src_reg
+ * and is_fullsock == 0 (e.g., during TCP_NEW_SYN_RECV). Before the fix, the
+ * macro failed to zero the destination register, leaving a stale ctx pointer
+ * that bypassed the NULL check.
+ */
+
+int bug_detected;
+int null_seen;
+
+SEC("sockops")
+__naked void sock_ops_get_sk_same_reg(void)
+{
+	asm volatile (
+		"r7 = *(u32 *)(r1 + %[is_fullsock_off]);"
+		"r1 = *(u64 *)(r1 + %[sk_off]);"
+		"if r7 != 0 goto 2f;"
+		"if r1 == 0 goto 1f;"
+		"r1 = %[bug_detected] ll;"
+		"r2 = 1;"
+		"*(u32 *)(r1 + 0) = r2;"
+		"goto 2f;"
+	"1:"
+		"r1 = %[null_seen] ll;"
+		"r2 = 1;"
+		"*(u32 *)(r1 + 0) = r2;"
+	"2:"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_const(is_fullsock_off, offsetof(struct bpf_sock_ops, is_fullsock)),
+		  __imm_const(sk_off, offsetof(struct bpf_sock_ops, sk)),
+		  __imm_addr(bug_detected),
+		  __imm_addr(null_seen)
+		: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


