Return-Path: <netdev+bounces-263270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA54OCb7pmltbwAAu9opvQ
	(envelope-from <netdev+bounces-263270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:15:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F201F24CE
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 463613070DCE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC42F48033E;
	Tue,  3 Mar 2026 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OQq0Fu2c"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7148165E
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550554; cv=none; b=SAAe15gl6nOOdQOE07EbHpSxlA5k0lUDKWE6vZ4YyiCUUOw+e5++l8IN21b4tPTFFt+pIkinvEdTX/ID8PIIGD1u+SYOg+J6KwNzu0X16HsxKXwTS71h2Lb4SxoFYH0ve6OWkb8GOSwwR3inOYZPPjKyaC7abSc4PLa8wce8tU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550554; c=relaxed/simple;
	bh=P0lp57O3xVx8qjH4XeIzmvz7D2tk1xI95GIqlyzq810=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoD3WgqJVqtaK8GbDuPxVWnZ16DTDxazMRmnVzOPkr+EtOOaqAgY+m1CXMZ7TbYwRYaFYnxeqG5lAtobd/666KEnDyRtqkh5GqrIGitNdLYuFQ9Fj0H449jb72RqKobpKkO0JvtbLBX5Akp1AWyZzz6t13+HiulDpyk1feHgHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OQq0Fu2c; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772550551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALIJ7LIlV+z/PhSVVXXCJAIsp2KMkktx7GQtroRZcKI=;
	b=OQq0Fu2cy9cgIa0MBtWggp966iyuOuCotoKjX4+y10OD0SMW2KgN52DH5TiVNakRYuVQwr
	W+Ri1qTl/tIwTfc2nMxOSGX+5lMmxO1fVrO6Vbx+7eC3PsL2C2H+Pzy+AiL4XXpDE7izIv
	IrmBadGnVVVMRUpeskMauF5PAh5W888=
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
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: Add tests to verify prog_array map compatibility
Date: Tue,  3 Mar 2026 23:06:39 +0800
Message-ID: <20260303150639.85007-7-leon.hwang@linux.dev>
In-Reply-To: <20260303150639.85007-1-leon.hwang@linux.dev>
References: <20260303150639.85007-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 41F201F24CE
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-263270-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add tests to verify the following tail call restrictions:

* !kprobe_write_ctx progs are not compatible with kprobe_write_ctx progs.
* !call_get_func_ip progs are not compatible with call_get_func_ip progs.
* !call_session_cookie progs are not compatible with call_session_cookie
  progs.

For kprobe_write_ctx, call_get_func_ip, and call_session_cookie, a
prog_array map cannot be shared between progs with different values.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 319 ++++++++++++++++++
 .../bpf/progs/tailcall_map_compatible.c       | 103 ++++++
 2 files changed, 422 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_map_compatible.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 7d534fde0af9..1063e73ecffa 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -9,6 +9,7 @@
 #include "tc_bpf2bpf.skel.h"
 #include "tailcall_fail.skel.h"
 #include "tailcall_sleepable.skel.h"
+#include "tailcall_map_compatible.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -1725,6 +1726,312 @@ static void test_tailcall_sleepable(void)
 	tailcall_sleepable__destroy(skel);
 }
 
+#ifdef __x86_64__
+/* uprobe attach point */
+static noinline int trigger_uprobe_fn(int a)
+{
+	asm volatile ("" : "+r"(a));
+	return a;
+}
+
+static void test_map_compatible_update_kprobe_write_ctx(void)
+{
+	struct bpf_program *dummy, *kprobe, *fsession;
+	struct tailcall_map_compatible *skel;
+	struct bpf_link *link = NULL;
+	int err, prog_fd, key = 0;
+	struct bpf_map *map;
+	LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
+	LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = tailcall_map_compatible__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_map_compatible__open"))
+		return;
+
+	dummy = skel->progs.dummy_kprobe;
+	bpf_program__set_autoload(dummy, true);
+
+	kprobe = skel->progs.kprobe;
+	bpf_program__set_autoload(kprobe, true);
+
+	fsession = skel->progs.fsession_tailcall;
+	bpf_program__set_autoload(fsession, true);
+
+	skel->bss->data = 0xdeadbeef;
+
+	err = tailcall_map_compatible__load(skel);
+	if (!ASSERT_OK(err, "tailcall_map_compatible__load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(kprobe);
+	map = skel->maps.prog_array_dummy;
+	err = bpf_map_update_elem(bpf_map__fd(map), &key, &prog_fd, BPF_ANY);
+	ASSERT_ERR(err, "bpf_map_update_elem kprobe");
+
+	skel->links.dummy_kprobe = bpf_program__attach_kprobe_opts(dummy, "bpf_fentry_test1",
+								   &kprobe_opts);
+	if (!ASSERT_OK_PTR(skel->links.dummy_kprobe, "bpf_program__attach_kprobe_opts"))
+		goto out;
+
+	skel->links.fsession_tailcall = bpf_program__attach_trace(fsession);
+	if (!ASSERT_OK_PTR(skel->links.fsession_tailcall, "bpf_program__attach_trace"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(fsession), &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts fsession");
+
+	ASSERT_EQ(topts.retval, 0, "dummy retval");
+	ASSERT_EQ(skel->bss->dummy_run, 1, "dummy_run");
+	ASSERT_EQ(skel->bss->data, 0xdeadbeef, "data");
+
+	err = bpf_map_delete_elem(bpf_map__fd(map), &key);
+	ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_delete_elem");
+
+	uprobe_opts.func_name = "trigger_uprobe_fn";
+	link = bpf_program__attach_uprobe_opts(kprobe, 0, "/proc/self/exe", 0, &uprobe_opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
+		goto out;
+
+	prog_fd = bpf_program__fd(dummy);
+	map = skel->maps.prog_array_kprobe;
+	err = bpf_map_update_elem(bpf_map__fd(map), &key, &prog_fd, BPF_ANY);
+	ASSERT_OK(err, "bpf_map_update_elem dummy");
+
+	ASSERT_EQ(trigger_uprobe_fn(1), 0, "trigger_uprobe_fn retval"); /* modified by uprobe */
+
+	ASSERT_EQ(topts.retval, 0, "dummy retval");
+	ASSERT_EQ(skel->bss->dummy_run, 2, "dummy_run");
+	ASSERT_EQ(skel->bss->data, 0, "data");
+
+out:
+	bpf_link__destroy(link);
+	tailcall_map_compatible__destroy(skel);
+}
+#else
+static void test_map_compatible_update_kprobe_write_ctx(void)
+{
+	test__skip();
+}
+#endif
+
+static void test_map_compatible_update_get_func_ip(void)
+{
+	struct tailcall_map_compatible *skel;
+	struct bpf_program *dummy, *fentry;
+	struct bpf_link *link = NULL;
+	int err, prog_fd, key = 0;
+	struct bpf_map *map;
+	__u64 func_ip;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = tailcall_map_compatible__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_map_compatible__open"))
+		return;
+
+	dummy = skel->progs.dummy_fentry;
+	bpf_program__set_autoload(dummy, true);
+
+	fentry = skel->progs.fentry;
+	bpf_program__set_autoload(fentry, true);
+
+	err = tailcall_map_compatible__load(skel);
+	if (!ASSERT_OK(err, "tailcall_map_compatible__load"))
+		goto out;
+
+	link = bpf_program__attach_trace(fentry);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_trace fentry"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(fentry), &topts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts fentry"))
+		goto out;
+
+	ASSERT_EQ(topts.retval, 0, "fentry retval");
+	ASSERT_EQ(skel->bss->dummy_run, 0, "dummy_run");
+	ASSERT_NEQ(skel->bss->data, 0, "data");
+	func_ip = skel->bss->data;
+
+	skel->bss->data = 0xdeadbeef;
+
+	err = bpf_link__destroy(link);
+	link = NULL;
+	if (!ASSERT_OK(err, "bpf_link__destroy"))
+		goto out;
+
+	prog_fd = bpf_program__fd(fentry);
+	map = skel->maps.prog_array_dummy;
+	err = bpf_map_update_elem(bpf_map__fd(map), &key, &prog_fd, BPF_ANY);
+	ASSERT_ERR(err, "bpf_map_update_elem fentry");
+
+	link = bpf_program__attach_trace(dummy);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_trace dummy"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(dummy), &topts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts dummy"))
+		goto out;
+
+	ASSERT_EQ(topts.retval, 0, "dummy retval");
+	ASSERT_EQ(skel->bss->dummy_run, 1, "dummy_run");
+	ASSERT_EQ(skel->bss->data, 0xdeadbeef, "data");
+	ASSERT_NEQ(skel->bss->data, func_ip, "data func_ip");
+
+	err = bpf_link__destroy(link);
+	link = NULL;
+	if (!ASSERT_OK(err, "bpf_link__destroy"))
+		goto out;
+
+	err = bpf_map_delete_elem(bpf_map__fd(map), &key);
+	ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_delete_elem");
+
+	prog_fd = bpf_program__fd(dummy);
+	map = skel->maps.prog_array_tracing;
+	err = bpf_map_update_elem(bpf_map__fd(map), &key, &prog_fd, BPF_ANY);
+	ASSERT_OK(err, "bpf_map_update_elem dummy");
+
+	link = bpf_program__attach_trace(fentry);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_trace fentry"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(fentry), &topts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts fentry"))
+		goto out;
+
+	ASSERT_EQ(topts.retval, 0, "fentry retval");
+	ASSERT_EQ(skel->bss->dummy_run, 2, "dummy_run");
+	ASSERT_EQ(skel->bss->data, func_ip, "data");
+
+out:
+	bpf_link__destroy(link);
+	tailcall_map_compatible__destroy(skel);
+}
+
+static void test_map_compatible_update_session_cookie(void)
+{
+	struct tailcall_map_compatible *skel;
+	struct bpf_program *dummy, *fsession;
+	struct bpf_link *link = NULL;
+	int err, prog_fd, key = 0;
+	struct bpf_map *map;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = tailcall_map_compatible__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_map_compatible__open"))
+		return;
+
+	dummy = skel->progs.dummy_fsession;
+	bpf_program__set_autoload(dummy, true);
+
+	fsession = skel->progs.fsession_cookie;
+	bpf_program__set_autoload(fsession, true);
+
+	skel->bss->data = 0xdeadbeef;
+
+	err = tailcall_map_compatible__load(skel);
+	if (err == -EOPNOTSUPP) {
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_OK(err, "tailcall_map_compatible__load"))
+		goto out;
+
+	prog_fd = bpf_program__fd(fsession);
+	map = skel->maps.prog_array_dummy;
+	err = bpf_map_update_elem(bpf_map__fd(map), &key, &prog_fd, BPF_ANY);
+	ASSERT_ERR(err, "bpf_map_update_elem fsession");
+
+	link = bpf_program__attach_trace(dummy);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_trace dummy"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(dummy), &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts dummy");
+
+	ASSERT_EQ(topts.retval, 0, "dummy retval");
+	ASSERT_EQ(skel->bss->dummy_run, 2, "dummy_run");
+	ASSERT_EQ(skel->bss->data, 0xdeadbeef, "data");
+
+	err = bpf_link__destroy(link);
+	link = NULL;
+	if (!ASSERT_OK(err, "bpf_link__destroy"))
+		goto out;
+
+	err = bpf_map_delete_elem(bpf_map__fd(map), &key);
+	ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_delete_elem");
+
+	prog_fd = bpf_program__fd(dummy);
+	map = skel->maps.prog_array_tracing;
+	err = bpf_map_update_elem(bpf_map__fd(map), &key, &prog_fd, BPF_ANY);
+	ASSERT_OK(err, "bpf_map_update_elem dummy");
+
+	link = bpf_program__attach_trace(fsession);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_trace fsession"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(fsession), &topts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts fsession"))
+		goto out;
+
+	ASSERT_EQ(topts.retval, 0, "fsession retval");
+	ASSERT_EQ(skel->bss->dummy_run, 4, "dummy_run");
+	ASSERT_EQ(skel->bss->data, 0, "data");
+
+out:
+	bpf_link__destroy(link);
+	tailcall_map_compatible__destroy(skel);
+}
+
+static void test_map_compatible_init(const char *prog1, const char *prog2)
+{
+	struct tailcall_map_compatible *skel;
+	struct bpf_program *p1, *p2;
+	int err;
+
+	skel = tailcall_map_compatible__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_map_compatible__open"))
+		return;
+
+	p1 = bpf_object__find_program_by_name(skel->obj, prog1);
+	if (!ASSERT_OK_PTR(p1, "bpf_object__find_program_by_name prog1"))
+		goto out;
+	bpf_program__set_autoload(p1, true);
+
+	p2 = bpf_object__find_program_by_name(skel->obj, prog2);
+	if (!ASSERT_OK_PTR(p2, "bpf_object__find_program_by_name prog2"))
+		goto out;
+	bpf_program__set_autoload(p2, true);
+
+	err = tailcall_map_compatible__load(skel);
+	if (err == -EOPNOTSUPP) {
+		test__skip();
+		goto out;
+	}
+	ASSERT_ERR(err, "tailcall_map_compatible__load");
+
+out:
+	tailcall_map_compatible__destroy(skel);
+}
+
+static void test_map_compatible_init_kprobe_write_ctx(void)
+{
+#ifdef __x86_64__
+	test_map_compatible_init("kprobe", "kprobe_tailcall");
+#else
+	test__skip();
+#endif
+}
+
+static void test_map_compatible_init_call_get_func_ip(void)
+{
+	test_map_compatible_init("fentry", "fentry_tailcall");
+}
+
+static void test_map_compatible_init_call_session_cookie(void)
+{
+	test_map_compatible_init("fsession_cookie", "fsession_tailcall");
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1781,4 +2088,16 @@ void test_tailcalls(void)
 		test_tailcall_failure();
 	if (test__start_subtest("tailcall_sleepable"))
 		test_tailcall_sleepable();
+	if (test__start_subtest("map_compatible/update/kprobe_write_ctx"))
+		test_map_compatible_update_kprobe_write_ctx();
+	if (test__start_subtest("map_compatible/update/get_func_ip"))
+		test_map_compatible_update_get_func_ip();
+	if (test__start_subtest("map_compatible/update/session_cookie"))
+		test_map_compatible_update_session_cookie();
+	if (test__start_subtest("map_compatible/init/kprobe_write_ctx"))
+		test_map_compatible_init_kprobe_write_ctx();
+	if (test__start_subtest("map_compatible/init/call_get_func_ip"))
+		test_map_compatible_init_call_get_func_ip();
+	if (test__start_subtest("map_compatible/init/call_session_cookie"))
+		test_map_compatible_init_call_session_cookie();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_map_compatible.c b/tools/testing/selftests/bpf/progs/tailcall_map_compatible.c
new file mode 100644
index 000000000000..991b799c89ac
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_map_compatible.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+int dummy_run;
+u64 data;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array_dummy SEC(".maps");
+
+#if defined(__TARGET_ARCH_x86)
+SEC("?kprobe")
+int dummy_kprobe(void *ctx)
+{
+	dummy_run++;
+	bpf_tail_call_static(ctx, &prog_array_dummy, 0);
+	return 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array_kprobe SEC(".maps");
+
+SEC("?kprobe")
+int kprobe(struct pt_regs *regs)
+{
+	data = regs->di = 0;
+	bpf_tail_call_static(regs, &prog_array_kprobe, 0);
+	return 0;
+}
+
+SEC("?kprobe")
+int kprobe_tailcall(struct pt_regs *regs)
+{
+	bpf_tail_call_static(regs, &prog_array_kprobe, 0);
+	return 0;
+}
+#endif
+
+SEC("?fentry/bpf_fentry_test1")
+int dummy_fentry(void *ctx)
+{
+	dummy_run++;
+	bpf_tail_call_static(ctx, &prog_array_dummy, 0);
+	return 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array_tracing SEC(".maps");
+
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(fentry)
+{
+	data = bpf_get_func_ip(ctx);
+	bpf_tail_call_static(ctx, &prog_array_tracing, 0);
+	return 0;
+}
+
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(fentry_tailcall)
+{
+	bpf_tail_call_static(ctx, &prog_array_tracing, 0);
+	return 0;
+}
+
+SEC("?fsession/bpf_fentry_test2")
+int dummy_fsession(void *ctx)
+{
+	dummy_run++;
+	bpf_tail_call_static(ctx, &prog_array_dummy, 0);
+	return 0;
+}
+
+SEC("?fsession/bpf_fentry_test2")
+int BPF_PROG(fsession_cookie)
+{
+	u64 *cookie = bpf_session_cookie(ctx);
+
+	data = *cookie = 0;
+	bpf_tail_call_static(ctx, &prog_array_tracing, 0);
+	return 0;
+}
+
+SEC("?fsession/bpf_fentry_test2")
+int BPF_PROG(fsession_tailcall)
+{
+	bpf_tail_call_static(ctx, &prog_array_tracing, 0);
+	return 0;
+}
-- 
2.52.0


