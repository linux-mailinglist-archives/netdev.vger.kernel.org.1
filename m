Return-Path: <netdev+bounces-271121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIwjCwOswmkyggQAu9opvQ
	(envelope-from <netdev+bounces-271121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:21:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D001B317EA9
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D385430A46DB
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EF0407567;
	Tue, 24 Mar 2026 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PstxDbUC"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB76405ABC
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364757; cv=none; b=nyvYsROubFomYuAONY0VfON9BD5Ym8bXgY6lKVHjETggn0axdjCP2qu41AdTahF+larzI7GHoUCPd6lTeRlaJr7dBkYfS97aiCdccCn8MmNZEjt4mYOz3rcJvZMv52RjsCXnpX4LuPYKQZxnjxpGR99UJX74/oflmJzSr1yAhBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364757; c=relaxed/simple;
	bh=WpqSBwwF7aTsP4Iam39AX17BQ0WaTx8bICKzwcui9Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCxmptpZXnrN4bHGC/Nicu4FvBUI1rM3zZuKIUaf/+p1g0d8pN7KdhogrWAr9GYwp2Zbiq5mAqgnXSAjxlga6EAZytcvzYGXZP76DLFq33ajhzDsz1sT85MvCQDWqZkSOM8cUa2SjiXtl1sUD9+7xsRu1dCpjP3dpTiRjZJhuR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PstxDbUC; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774364753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pwjzUaoLKRQGRwW5/62J5f/rc6uv0cMUcHFUjKNYB4=;
	b=PstxDbUClb3pwXjZ5bGeV4kDIZQr/cECrUYdrG0sIy+q8IHeRTWQwSHRJzJWJyxzS+LCUr
	WZyHV9vFhHu/k8MUFJDfZ/EhHthGwKbU5WYlNiKVTbeNFE1c6c9TcAUDdsYKZ0t2rPw0bk
	Lqt0FXUXHL22aXapbXPEd4IZGbuD1jc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add tests to verify freplace compatibility
Date: Tue, 24 Mar 2026 23:04:44 +0800
Message-ID: <20260324150444.68166-4-leon.hwang@linux.dev>
In-Reply-To: <20260324150444.68166-1-leon.hwang@linux.dev>
References: <20260324150444.68166-1-leon.hwang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-271121-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D001B317EA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add tests to verify the issues:

* xdp_has_frags: The backwards compatibility can be broken via freplace.
* kprobe_write_ctx: It can be abused to modify struct pt_regs of kernel
  functions via kprobe_write_ctx=true freplace progs.

Without the fixes, the issues are verified:

xdp_has_frags=true freplace prog is allowed to attach to
xdp_has_frags=false XDP prog.

kprobe_write_ctx=true freplace prog is allowed to attach to
kprobe_write_ctx=false kprobe prog. Then, the first arg of
bpf_fentry_test1 will be set as 0, and bpf_prog_test_run_opts() gets
-EFAULT instead of 0.

With the fixes, the issues are rejected by verifier:

 Extension program cannot have different xdp_has_frags value with target prog
 #134/1   freplace_compatible/xdp_has_frags:OK
 Extension program cannot have different kprobe_write_ctx value with target prog
 #134/2   freplace_compatible/kprobe_write_ctx:OK

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/freplace_compatible.c      | 124 ++++++++++++++++++
 .../selftests/bpf/progs/freplace_compatible.c |  40 ++++++
 2 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/freplace_compatible.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_compatible.c

diff --git a/tools/testing/selftests/bpf/prog_tests/freplace_compatible.c b/tools/testing/selftests/bpf/prog_tests/freplace_compatible.c
new file mode 100644
index 000000000000..251e17ef4e52
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/freplace_compatible.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "freplace_compatible.skel.h"
+
+static void test_xdp_has_frags(void)
+{
+	struct freplace_compatible *skel_xdp, *skel_ext = NULL;
+	struct bpf_program *prog_xdp, *prog_ext;
+	struct bpf_link *link = NULL;
+	char buff[128] = {};
+	int err, prog_fd;
+	__u32 flags;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = buff,
+		.data_size_in = sizeof(buff),
+		.repeat = 1,
+	);
+
+	skel_xdp = freplace_compatible__open();
+	if (!ASSERT_OK_PTR(skel_xdp, "freplace_compatible__open xdp"))
+		return;
+
+	prog_xdp = skel_xdp->progs.xdp;
+	bpf_program__set_autoload(prog_xdp, true);
+
+	err = freplace_compatible__load(skel_xdp);
+	if (!ASSERT_OK(err, "freplace_compatible__load xdp"))
+		goto out;
+
+	skel_ext = freplace_compatible__open();
+	if (!ASSERT_OK_PTR(skel_ext, "freplace_compatible__open ext"))
+		goto out;
+
+	prog_ext = skel_ext->progs.freplace_xdp;
+	bpf_program__set_autoload(prog_ext, true);
+
+	flags = bpf_program__flags(prog_ext) | BPF_F_XDP_HAS_FRAGS;
+	bpf_program__set_flags(prog_ext, flags);
+
+	prog_fd = bpf_program__fd(prog_xdp);
+	bpf_program__set_attach_target(prog_ext, prog_fd, "xdp");
+
+	err = freplace_compatible__load(skel_ext);
+	ASSERT_ERR(err, "freplace_compatible__load ext");
+
+	link = bpf_program__attach_freplace(prog_ext, prog_fd, "xdp");
+	ASSERT_ERR_PTR(link, "bpf_program__attach_freplace");
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
+		goto out;
+
+	ASSERT_EQ(topts.retval, XDP_PASS, "xdp retval");
+
+out:
+	bpf_link__destroy(link);
+	freplace_compatible__destroy(skel_ext);
+	freplace_compatible__destroy(skel_xdp);
+}
+
+#ifdef __x86_64__
+static void test_kprobe_write_ctx(void)
+{
+	struct freplace_compatible *skel_kprobe, *skel_ext = NULL;
+	struct bpf_program *prog_kprobe, *prog_ext, *prog_fentry;
+	struct bpf_link *link_kprobe = NULL, *link_ext = NULL;
+	int err;
+	LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel_kprobe = freplace_compatible__open();
+	if (!ASSERT_OK_PTR(skel_kprobe, "freplace_compatible__open kprobe"))
+		return;
+
+	prog_kprobe = skel_kprobe->progs.kprobe;
+	bpf_program__set_autoload(prog_kprobe, true);
+
+	prog_fentry = skel_kprobe->progs.fentry;
+	bpf_program__set_autoload(prog_fentry, true);
+
+	err = freplace_compatible__load(skel_kprobe);
+	if (!ASSERT_OK(err, "freplace_compatible__load kprobe"))
+		goto out;
+
+	skel_ext = freplace_compatible__open();
+	if (!ASSERT_OK_PTR(skel_ext, "freplace_compatible__open ext"))
+		goto out;
+
+	prog_ext = skel_ext->progs.freplace_kprobe;
+	bpf_program__set_autoload(prog_ext, true);
+
+	bpf_program__set_attach_target(prog_ext, bpf_program__fd(prog_kprobe), "kprobe");
+
+	err = freplace_compatible__load(skel_ext);
+	ASSERT_ERR(err, "freplace_compatible__load ext");
+
+	link_ext = bpf_program__attach_freplace(prog_ext, 0, NULL);
+	ASSERT_ERR_PTR(link_ext, "bpf_program__attach_freplace");
+
+	link_kprobe = bpf_program__attach_kprobe_opts(prog_kprobe, "bpf_fentry_test1",
+						      &kprobe_opts);
+	if (!ASSERT_OK_PTR(link_kprobe, "bpf_program__attach_kprobe_opts"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog_fentry), &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+out:
+	bpf_link__destroy(link_ext);
+	bpf_link__destroy(link_kprobe);
+	freplace_compatible__destroy(skel_ext);
+	freplace_compatible__destroy(skel_kprobe);
+}
+#endif
+
+void test_freplace_compatible(void)
+{
+	if (test__start_subtest("xdp_has_frags"))
+		test_xdp_has_frags();
+#ifdef __x86_64__
+	if (test__start_subtest("kprobe_write_ctx"))
+		test_kprobe_write_ctx();
+#endif
+}
diff --git a/tools/testing/selftests/bpf/progs/freplace_compatible.c b/tools/testing/selftests/bpf/progs/freplace_compatible.c
new file mode 100644
index 000000000000..f13b4878268b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_compatible.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("?xdp")
+int xdp(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
+
+SEC("?freplace")
+int freplace_xdp(struct xdp_md *ctx)
+{
+	return 0xFF;
+}
+
+#if defined(__TARGET_ARCH_x86)
+SEC("?kprobe")
+int kprobe(struct pt_regs *regs)
+{
+	return 0;
+}
+
+SEC("?freplace")
+int freplace_kprobe(struct pt_regs *regs)
+{
+	regs->di = 0;
+	return 0;
+}
+
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(fentry)
+{
+	return 0;
+}
+#endif
+
+char _license[] SEC("license") = "GPL";
+
-- 
2.53.0


