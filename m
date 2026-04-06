Return-Path: <netdev+bounces-275523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDt/EUkl02lxfAcAu9opvQ
	(envelope-from <netdev+bounces-275523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:15:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F003A149B
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 05:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98FC6301A929
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 03:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5FB33C194;
	Mon,  6 Apr 2026 03:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qPa4Bynx"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC52EAB61
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 03:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775445269; cv=none; b=gsRHSClBbyMJXR5Q0/7g8emFgkndTG9OjD/VcaFPozlAzl4EVFuvMu3gHT0ZtZMpHgDwrdzKLTTlGNYbDeQu/jTEFKlRxgOWx2X8FP8lOFeUn86a8fb5kGBgnDC0EHJxu11ZYf3yFaMe1YaFQXdsWJhqUXAGgBVXPdl95bbFo5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775445269; c=relaxed/simple;
	bh=IaQBJhZq22U/AqidD8mlM6KHpzkK9UrNrCDYgLDGXmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWe/rMNOgf31JAixMGFSEZ0drPKAEqMbBCvKY/swmIs9kV2WQEgnYFgK6X+WORd7MPx+5wyozvNyhq4jS/4wtRF7sq2BQIAMfqQlbqky118+PpXUnomPOFu2eSJl5GBVCUi9jn1830CD1QA3mFl9XfjH9wnfflGRpyo3q9/E6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qPa4Bynx; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775445263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikZtbZMewTqC6nCN77M39tHB8LncJ0K7vUTKUc1uO90=;
	b=qPa4BynxA8X7czn/0YBEbkKCUidwebDq2ve+wDhpbhFP7HcBDNw6aEdDPRFhwXSPvGkxxm
	sMHDfeNXRnTvVpygKye0W37eQUN8EtAzBx79XUoV67hi/O6GxzYRd+0+Zyyn4Zt8lKlH2O
	gZwpxCI0apb9YLgN28R3d0XPOmhIzOA=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add tests for sock_ops ctx access with same src/dst register
Date: Mon,  6 Apr 2026 11:12:51 +0800
Message-ID: <20260406031330.187630-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260406031330.187630-1-jiayuan.chen@linux.dev>
References: <20260406031330.187630-1-jiayuan.chen@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-275523-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2F003A149B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add selftests to verify SOCK_OPS_GET_SK() and SOCK_OPS_GET_FIELD()
correctly return NULL/zero when dst_reg == src_reg and is_fullsock == 0.

Three subtests are included:
 - get_sk: ctx->sk with same src/dst register (SOCK_OPS_GET_SK)
 - get_field: ctx->snd_cwnd with same src/dst register (SOCK_OPS_GET_FIELD)
 - get_sk_diff_reg: ctx->sk with different src/dst register (baseline)

Each BPF program uses inline asm (__naked) to force specific register
allocation, reads is_fullsock first, then loads the field using the same
(or different) register. The test triggers TCP_NEW_SYN_RECV via a TCP
handshake and checks that the result is NULL/zero when is_fullsock == 0.

Test:
	./test_progs -a sock_ops_get_sk -v
	test_sock_ops_get_sk:PASS:join_cgroup 0 nsec
	test_sock_ops_get_sk:PASS:skel_open_load 0 nsec
	run_sock_ops_test:PASS:prog_attach 0 nsec
	run_sock_ops_test:PASS:start_server 0 nsec
	run_sock_ops_test:PASS:connect_to_fd 0 nsec
	test_sock_ops_get_sk:PASS:null_seen 0 nsec
	test_sock_ops_get_sk:PASS:bug_not_detected 0 nsec
	#419/1   sock_ops_get_sk/get_sk:OK
	run_sock_ops_test:PASS:prog_attach 0 nsec
	run_sock_ops_test:PASS:start_server 0 nsec
	run_sock_ops_test:PASS:connect_to_fd 0 nsec
	test_sock_ops_get_sk:PASS:field_null_seen 0 nsec
	test_sock_ops_get_sk:PASS:field_bug_not_detected 0 nsec
	#419/2   sock_ops_get_sk/get_field:OK
	run_sock_ops_test:PASS:prog_attach 0 nsec
	run_sock_ops_test:PASS:start_server 0 nsec
	run_sock_ops_test:PASS:connect_to_fd 0 nsec
	test_sock_ops_get_sk:PASS:diff_reg_null_seen 0 nsec
	test_sock_ops_get_sk:PASS:diff_reg_bug_not_detected 0 nsec
	#419/3   sock_ops_get_sk/get_sk_diff_reg:OK
	#419     sock_ops_get_sk:OK
	Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../bpf/prog_tests/sock_ops_get_sk.c          |  77 ++++++++++++
 .../selftests/bpf/progs/sock_ops_get_sk.c     | 117 ++++++++++++++++++
 2 files changed, 194 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_ops_get_sk.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c b/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
new file mode 100644
index 0000000000000..e086f7abb197e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_ops_get_sk.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+#include "sock_ops_get_sk.skel.h"
+
+/* See progs/sock_ops_get_sk.c for the bug description. */
+static void run_sock_ops_test(struct sock_ops_get_sk *skel, int cgroup_fd,
+			      int prog_fd)
+{
+	int server_fd, client_fd, err;
+
+	err = bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
+	if (!ASSERT_OK(err, "prog_attach"))
+		return;
+
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto detach;
+
+	/* Trigger TCP handshake which causes TCP_NEW_SYN_RECV state where
+	 * is_fullsock == 0 and is_locked_tcp_sock == 0.
+	 */
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
+		goto close_server;
+
+	close(client_fd);
+
+close_server:
+	close(server_fd);
+detach:
+	bpf_prog_detach(cgroup_fd, BPF_CGROUP_SOCK_OPS);
+}
+
+void test_sock_ops_get_sk(void)
+{
+	struct sock_ops_get_sk *skel;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/sock_ops_get_sk");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	skel = sock_ops_get_sk__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
+		goto close_cgroup;
+
+	/* Test SOCK_OPS_GET_SK with same src/dst register */
+	if (test__start_subtest("get_sk")) {
+		run_sock_ops_test(skel, cgroup_fd,
+				  bpf_program__fd(skel->progs.sock_ops_get_sk_same_reg));
+		ASSERT_EQ(skel->bss->null_seen, 1, "null_seen");
+		ASSERT_EQ(skel->bss->bug_detected, 0, "bug_not_detected");
+	}
+
+	/* Test SOCK_OPS_GET_FIELD with same src/dst register */
+	if (test__start_subtest("get_field")) {
+		run_sock_ops_test(skel, cgroup_fd,
+				  bpf_program__fd(skel->progs.sock_ops_get_field_same_reg));
+		ASSERT_EQ(skel->bss->field_null_seen, 1, "field_null_seen");
+		ASSERT_EQ(skel->bss->field_bug_detected, 0, "field_bug_not_detected");
+	}
+
+	/* Test SOCK_OPS_GET_SK with different src/dst register */
+	if (test__start_subtest("get_sk_diff_reg")) {
+		run_sock_ops_test(skel, cgroup_fd,
+				  bpf_program__fd(skel->progs.sock_ops_get_sk_diff_reg));
+		ASSERT_EQ(skel->bss->diff_reg_null_seen, 1, "diff_reg_null_seen");
+		ASSERT_EQ(skel->bss->diff_reg_bug_detected, 0, "diff_reg_bug_not_detected");
+	}
+
+	sock_ops_get_sk__destroy(skel);
+close_cgroup:
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/sock_ops_get_sk.c b/tools/testing/selftests/bpf/progs/sock_ops_get_sk.c
new file mode 100644
index 0000000000000..3a0689f8ce7ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_ops_get_sk.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/*
+ * Test the SOCK_OPS_GET_SK() and SOCK_OPS_GET_FIELD() macros in
+ * sock_ops_convert_ctx_access() when dst_reg == src_reg.
+ *
+ * When dst_reg == src_reg, the macros borrow a temporary register to load
+ * is_fullsock / is_locked_tcp_sock, because dst_reg holds the ctx pointer
+ * and cannot be clobbered before ctx->sk / ctx->field is read. If
+ * is_fullsock == 0 (e.g., TCP_NEW_SYN_RECV with a request_sock), the macro
+ * must still zero dst_reg so the verifier's PTR_TO_SOCKET_OR_NULL /
+ * SCALAR_VALUE type is correct at runtime. A missing clear leaves a stale
+ * ctx pointer in dst_reg that passes NULL checks (GET_SK) or leaks a kernel
+ * address as a scalar (GET_FIELD).
+ *
+ * When dst_reg != src_reg, dst_reg itself is used to load is_fullsock, so
+ * the JEQ (dst_reg == 0) naturally leaves it zeroed on the !fullsock path.
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
+/* SOCK_OPS_GET_FIELD: same-register, is_locked_tcp_sock == 0 path. */
+int field_bug_detected;
+int field_null_seen;
+
+SEC("sockops")
+__naked void sock_ops_get_field_same_reg(void)
+{
+	asm volatile (
+		"r7 = *(u32 *)(r1 + %[is_fullsock_off]);"
+		"r1 = *(u32 *)(r1 + %[snd_cwnd_off]);"
+		"if r7 != 0 goto 2f;"
+		"if r1 == 0 goto 1f;"
+		"r1 = %[field_bug_detected] ll;"
+		"r2 = 1;"
+		"*(u32 *)(r1 + 0) = r2;"
+		"goto 2f;"
+	"1:"
+		"r1 = %[field_null_seen] ll;"
+		"r2 = 1;"
+		"*(u32 *)(r1 + 0) = r2;"
+	"2:"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_const(is_fullsock_off, offsetof(struct bpf_sock_ops, is_fullsock)),
+		  __imm_const(snd_cwnd_off, offsetof(struct bpf_sock_ops, snd_cwnd)),
+		  __imm_addr(field_bug_detected),
+		  __imm_addr(field_null_seen)
+		: __clobber_all);
+}
+
+/* SOCK_OPS_GET_SK: different-register, is_fullsock == 0 path. */
+int diff_reg_bug_detected;
+int diff_reg_null_seen;
+
+SEC("sockops")
+__naked void sock_ops_get_sk_diff_reg(void)
+{
+	asm volatile (
+		"r7 = r1;"
+		"r6 = *(u32 *)(r7 + %[is_fullsock_off]);"
+		"r2 = *(u64 *)(r7 + %[sk_off]);"
+		"if r6 != 0 goto 2f;"
+		"if r2 == 0 goto 1f;"
+		"r1 = %[diff_reg_bug_detected] ll;"
+		"r3 = 1;"
+		"*(u32 *)(r1 + 0) = r3;"
+		"goto 2f;"
+	"1:"
+		"r1 = %[diff_reg_null_seen] ll;"
+		"r3 = 1;"
+		"*(u32 *)(r1 + 0) = r3;"
+	"2:"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_const(is_fullsock_off, offsetof(struct bpf_sock_ops, is_fullsock)),
+		  __imm_const(sk_off, offsetof(struct bpf_sock_ops, sk)),
+		  __imm_addr(diff_reg_bug_detected),
+		  __imm_addr(diff_reg_null_seen)
+		: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


