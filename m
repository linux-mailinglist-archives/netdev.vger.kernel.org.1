Return-Path: <netdev+bounces-260578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OWZCgfInWk8SAQAu9opvQ
	(envelope-from <netdev+bounces-260578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:47:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEF189458
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE5BD308D78E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D363A641B;
	Tue, 24 Feb 2026 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uZEM5850"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D213A6412;
	Tue, 24 Feb 2026 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947781; cv=none; b=gHUvIn+a8BnvzZHc0GPh5+cvzEuDlwPNqqBeyYFwfxwEV5dVfQPABBZWLVHW4QymgCzYyP6WCpiQLTJu2Z76r/bSs5TRcya+tgnL7H/4OtDgB/K4sPzFhPg52PpGzfVIK06dzBt7/Gkui4YzY0KpHOOykWWlPa/iyWVlm0xR0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947781; c=relaxed/simple;
	bh=uuVhZPMLQTKvEryzY971QiuVD2Q5biMcf6jIeRvmjdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTeLT5rVYs/P6UPMDKsJp+QAanZmDq+7BjIjulTV4+Ou7SxZgGfRhNTbeADirl43l/E0rzi2XM6UVLRUPkkcHfFkOiWOD3U0p9cIkAcCLcOPZXYYhQufGBxFF8B4i6pW6pX3rpi5Hgi9v7zJntogrCznvK8NxmKaPYb3ElC0Lrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uZEM5850; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771947777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajSl2pdKTk9QEmR1MISxYniJhjrbh949cm//bffiNdc=;
	b=uZEM5850Y3+L8n2F0E2j8gvf1S+N/9cpVe6vGsjsonYOWoAP+wN70FqWvPpNA7+gBckmtT
	HOu+F0hkzQan8fKFArHhGjZLnnjnOCPgEOIAtOhLsGSO4rVauNeoxJaaQNWNnK4H5uqgjU
	hFEvDwCEjejr491rTRD/pxQDq4bn4CQ=
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
Subject: [PATCH bpf-next 8/8] selftests/bpf: Add a test to verify session-kfunc compatibility enforcement
Date: Tue, 24 Feb 2026 23:40:24 +0800
Message-ID: <20260224154024.12504-9-leon.hwang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-260578-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 3CCEF189458
X-Rspamd-Action: no action

Add prog_array coverage for tracing programs that differ in
bpf_session_cookie() / bpf_session_is_return() usage.

The test verifies one-way enforcement: !call_session_* programs
cannot tail-call call_session_* programs.

Assisted-by: Codex:gpt-5.3-codex
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 47 +++++++++++++++++++
 .../selftests/bpf/progs/fsession_test.c       |  6 +++
 2 files changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
index a299aeb8cc2e..304986544a8d 100644
--- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -129,6 +129,51 @@ static void test_fsession_cookie(void)
 	fsession_test__destroy(skel);
 }
 
+static void test_fsession_prog_array_session_kfunc_compat(void)
+{
+	struct fsession_test *skel = NULL;
+	__u32 key = 0, session_kfunc_prog_fd, no_session_kfunc_prog_fd;
+	int map_fd = -1, err;
+
+	skel = fsession_test__open();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open"))
+		goto cleanup;
+
+	err = fsession_test__load(skel);
+	if (err == -EOPNOTSUPP) {
+		test__skip();
+		goto cleanup;
+	}
+	if (!ASSERT_OK(err, "fsession_test__load"))
+		goto cleanup;
+
+	session_kfunc_prog_fd = bpf_program__fd(skel->progs.test9);
+	no_session_kfunc_prog_fd = bpf_program__fd(skel->progs.test12);
+	if (!ASSERT_GE(session_kfunc_prog_fd, 0, "session_kfunc_prog_fd"))
+		goto cleanup;
+	if (!ASSERT_GE(no_session_kfunc_prog_fd, 0, "no_session_kfunc_prog_fd"))
+		goto cleanup;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_PROG_ARRAY, NULL, sizeof(key),
+				sizeof(__u32), 1, NULL);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
+		goto cleanup;
+
+	err = bpf_map_update_elem(map_fd, &key, &no_session_kfunc_prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "bpf_map_update_elem success"))
+		goto cleanup;
+
+	err = bpf_map_update_elem(map_fd, &key, &session_kfunc_prog_fd, BPF_ANY);
+	if (!ASSERT_ERR(err, "bpf_map_update_elem failure"))
+		goto cleanup;
+	ASSERT_EQ(errno, EINVAL, "bpf_map_update_elem errno");
+
+cleanup:
+	if (map_fd >= 0)
+		close(map_fd);
+	fsession_test__destroy(skel);
+}
+
 void test_fsession_test(void)
 {
 	if (test__start_subtest("fsession_test"))
@@ -137,4 +182,6 @@ void test_fsession_test(void)
 		test_fsession_reattach();
 	if (test__start_subtest("fsession_cookie"))
 		test_fsession_cookie();
+	if (test__start_subtest("fsession_prog_array_session_kfunc_compat"))
+		test_fsession_prog_array_session_kfunc_compat();
 }
diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 86e8a2fe467e..1e6be28bcc3d 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -177,3 +177,9 @@ int BPF_PROG(test11, int a)
 	test11_result = a == 1;
 	return 0;
 }
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test12, int a, int ret)
+{
+	return 0;
+}
-- 
2.52.0


