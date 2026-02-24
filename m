Return-Path: <netdev+bounces-260577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBuPIvXHnWk8SAQAu9opvQ
	(envelope-from <netdev+bounces-260577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:47:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EF6189434
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 903FA3089BA1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B61B3A640B;
	Tue, 24 Feb 2026 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GVMrA6rW"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5B3A640A
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947780; cv=none; b=vBKNHgBuutvNh/+IZw3w66DVuHfk88m6tk6/i+KbFTWDG29yzhBbSzin4d/YZz1iyjdWexbVirJht5JT+HS0pnV7ZCFqJwmXlsj74rodWYtklZEfarSXROSntSwz+y9NYOUHZ4+bhmcvv3SUgrwYETKtVdyaO+Zd9y6DVcfRFkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947780; c=relaxed/simple;
	bh=f849xKyoZAajEGHjpBZZX77DXEVvDQzC30RhKa7IJuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCahCOpR2ddd9/xgJieXNEHwo3aHbi87ddNpbgsJvekJhTOhbV4VRs34QPe7sQ3JMNS9/BXeev/lC58jbRywk+lr40Nveq1agSRIgngLpiQRKp44gIE0k4ull9Qq0FZykPPaqREKW51JCVd1Pkcb53IXRj9wLK4OrT3YcBLviMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GVMrA6rW; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771947765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJFu39HW6jkSyHpZDpx94eEtrHBuJjXZaAVXvr0cMw0=;
	b=GVMrA6rW0c99pjcn5e96vFYBY1ETaJKSNpNlkk7cNHwOOR90o6NpkBH+s0SzgoEYbqkZMZ
	Ts+NmrtYx/bRwSVCM3kikcfF7SE/wHQ9rppddZkUt0gmLow9yXpdIjf+5+rHGfHnpl41jo
	6MaU+ltZq5yHbC9eVqYhE62PQc2yoyU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Leon Hwang <leon.hwang@linux.dev>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 6/8] selftests/bpf: Add a test to verify kprobe_write_ctx compatibility enforcement
Date: Tue, 24 Feb 2026 23:40:22 +0800
Message-ID: <20260224154024.12504-7-leon.hwang@linux.dev>
In-Reply-To: <20260224154024.12504-1-leon.hwang@linux.dev>
References: <20260224154024.12504-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-260577-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: E5EF6189434
X-Rspamd-Action: no action

Add prog_array coverage for kprobe programs with and without
kprobe_write_ctx requirements.

The test verifies one-way enforcement: !kprobe_write_ctx programs
cannot tail-call kprobe_write_ctx programs.

Assisted-by: Codex:gpt-5.3-codex
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 44 +++++++++++++++++++
 .../selftests/bpf/progs/kprobe_write_ctx.c    |  6 +++
 2 files changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 9e77e5da7097..a9444db92246 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -220,11 +220,53 @@ static void test_attach_kprobe_write_ctx(void)
 
 	kprobe_write_ctx__destroy(skel);
 }
+
+static void test_kprobe_write_ctx_prog_array_compat(void)
+{
+	__u32 key = 0, read_prog_fd, write_prog_fd;
+	struct kprobe_write_ctx *skel = NULL;
+	int map_fd = -1, err;
+
+	skel = kprobe_write_ctx__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_write_ctx__open_and_load"))
+		return;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_PROG_ARRAY, NULL, sizeof(key),
+				sizeof(__u32), 1, NULL);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
+		goto cleanup;
+
+	read_prog_fd = bpf_program__fd(skel->progs.kprobe_read_ctx);
+	write_prog_fd = bpf_program__fd(skel->progs.kprobe_write_ctx);
+	if (!ASSERT_GE(read_prog_fd, 0, "read_prog_fd"))
+		goto cleanup;
+	if (!ASSERT_GE(write_prog_fd, 0, "write_prog_fd"))
+		goto cleanup;
+
+	err = bpf_map_update_elem(map_fd, &key, &read_prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem success"))
+		goto cleanup;
+
+	err = bpf_map_update_elem(map_fd, &key, &write_prog_fd, BPF_ANY);
+	if (!ASSERT_ERR(err, "bpf_map_update_elem failure"))
+		goto cleanup;
+	ASSERT_EQ(errno, EINVAL, "bpf_map_update_elem errno");
+
+cleanup:
+	if (map_fd >= 0)
+		close(map_fd);
+	kprobe_write_ctx__destroy(skel);
+}
 #else
 static void test_attach_kprobe_write_ctx(void)
 {
 	test__skip();
 }
+
+static void test_kprobe_write_ctx_prog_array_compat(void)
+{
+	test__skip();
+}
 #endif
 
 static void test_attach_probe_auto(struct test_attach_probe *skel)
@@ -434,6 +476,8 @@ void test_attach_probe(void)
 		test_attach_kprobe_long_event_name();
 	if (test__start_subtest("kprobe-write-ctx"))
 		test_attach_kprobe_write_ctx();
+	if (test__start_subtest("kprobe-write-ctx-prog-array-compat"))
+		test_kprobe_write_ctx_prog_array_compat();
 
 cleanup:
 	test_attach_probe__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
index f77aef0474d3..09e0c487bde5 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
@@ -13,6 +13,12 @@ int kprobe_write_ctx(struct pt_regs *ctx)
 	return 0;
 }
 
+SEC("kprobe")
+int kprobe_read_ctx(struct pt_regs *ctx)
+{
+	return 0;
+}
+
 SEC("kprobe.multi")
 int kprobe_multi_write_ctx(struct pt_regs *ctx)
 {
-- 
2.52.0


