Return-Path: <netdev+bounces-300139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5YWtKOWGMmoV1gUAu9opvQ
	(envelope-from <netdev+bounces-300139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:37:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DB8699274
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:37:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cVGeaHlm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300139-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300139-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBF6230C8CB2
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94141283FD4;
	Wed, 17 Jun 2026 11:18:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2DD3B27D8;
	Wed, 17 Jun 2026 11:18:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695138; cv=none; b=txSkYhf/cJ0bMIjwoGJwE0yJT9q3b2UkXYLPQVheylq6vZRgW/FGqDdeuC09wo6WW7aIeR4gkvcvqZPpjpVHK11bUFL76joFgNMBrXTtpqY6jjkldTMyYzZTneAU7r2zaa+FTaAMGYi9D1wuVqYo722jwQmfUEoI5jrPDeKLLRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695138; c=relaxed/simple;
	bh=ra/SosPM5YDK4tjlZCqYgXEuvLFMbvxTb2iOnmAHkC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uoLXah/6NKhnd9TROHPb7+9g8osJZP8WXl9YRA84EiF+ngNVZ3SCJ1a75t666IipqrDm2D7Qeb5+XUOmTj9rCUcJuJarepSxEZKc7Mc2IwhLKF/2OGs2l+ynDOdbqawPrKEQ0w3Zv9I58R6PKKwXfwmBQg08cKYZ1WcAwc7y+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVGeaHlm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB641F00A3E;
	Wed, 17 Jun 2026 11:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781695134;
	bh=C7Wky8L+E0GSOUejAPBMmsYNLikj0wAMW6BI6PnSpI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cVGeaHlmaNkX+eFPOHRDz8iZ6xCBWtVyTrZurYLRd6qGud4kY/8zX4CLW+EvVnGtA
	 /wFjKMoTYe6ITe68ksMkN/NWSGvbVfHrutS/UWAQ6JIEZtIvBIlDCtS4z7Dda9E5uU
	 sfoMYoISWCHYMOy+MZfaO1C5NY2afyqCcen5lYko65TzWYD5aSr3lte/2BjKNwueIb
	 /LqHc0bumqFOPliClYHXT7nDzP9LSp0gGBtiyaA6gEjJXYpuUZokTqT7zOy2ZpquzX
	 7fUZV6sFhHhw02M7scfBPX+UzGlNWGhe2yOGln3gcdtiJid2Vs3Zyjrlol6JilB9Pl
	 uN7ARgMRYt/0Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 17 Jun 2026 13:18:28 +0200
Subject: [PATCH 2/2] selftests/bpf: Add test for bpf_sock_read_xattr()
 kfunc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-work-bpf-sock-xattr-v1-2-a1276f7c9da3@kernel.org>
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
In-Reply-To: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4090c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4950; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ra/SosPM5YDK4tjlZCqYgXEuvLFMbvxTb2iOnmAHkC0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZNfU7v1ku7r3k0Z3p/hmvb/HJva7qupDDGvFt71EP5
 pI8C+7sjhIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInsFGb4Zl+031L57A/+Az0M
 Zj03ntwslCrc0v58U+aPfz/TG+95MvxmuZ778c/3rHDBfeHPnlkuWW+ycqH3n2l2zZuZba3F45x
 4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300139-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:horms@kernel.org,m:kuniyu@google.com,m:willemb@google.com,m:linux-fsdevel@vger.kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,kernel.org,google.com,vger.kernel.org,linux.dev,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98DB8699274

Add a selftest that loads the kfunc in sleepable and non-sleepable
lsm/socket_connect programs and checks that a value set via fsetxattr()
on a socket is read back.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/bpf/bpf_experimental.h     |  3 +
 .../testing/selftests/bpf/prog_tests/sock_xattr.c  | 67 ++++++++++++++++++++++
 .../testing/selftests/bpf/progs/sock_read_xattr.c  | 54 +++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2234bd6bc9d3..5b825157b125 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -446,6 +446,9 @@ extern void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it) __weak __ksym;
 extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
 				 struct bpf_dynptr *value_p) __weak __ksym;
 
+extern int bpf_sock_read_xattr(struct socket *sock, const char *name__str,
+			       struct bpf_dynptr *value_p) __weak __ksym;
+
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	4
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_xattr.c b/tools/testing/selftests/bpf/prog_tests/sock_xattr.c
new file mode 100644
index 000000000000..b5816e90f01a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_xattr.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Christian Brauner */
+
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/xattr.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <test_progs.h>
+
+#include "sock_read_xattr.skel.h"
+
+static const char xattr_value[] = "bpf_sock_value";
+static const char xattr_name[] = "user.bpf_test";
+
+static void test_read_sock_xattr(void)
+{
+	struct sockaddr_in addr = {};
+	struct sock_read_xattr *skel = NULL;
+	struct bpf_link *link = NULL;
+	int sock_fd = -1, err;
+
+	sock_fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (!ASSERT_OK_FD(sock_fd, "socket"))
+		return;
+
+	err = fsetxattr(sock_fd, xattr_name, xattr_value, sizeof(xattr_value), 0);
+	if (!ASSERT_OK(err, "fsetxattr"))
+		goto out;
+
+	skel = sock_read_xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "sock_read_xattr__open_and_load"))
+		goto out;
+
+	skel->bss->monitored_pid = sys_gettid();
+
+	/* Only attach the functional program; the verifier-only programs
+	 * above are not pid-gated and would clobber the shared globals.
+	 */
+	link = bpf_program__attach(skel->progs.read_sock_xattr);
+	if (!ASSERT_OK_PTR(link, "attach read_sock_xattr"))
+		goto out;
+
+	addr.sin_family = AF_INET;
+	addr.sin_port = htons(1234);
+	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	/* Only the lsm/socket_connect hook matters; the connect may fail. */
+	connect(sock_fd, (struct sockaddr *)&addr, sizeof(addr));
+
+	ASSERT_EQ(skel->data->read_ret, sizeof(xattr_value), "read_ret");
+	ASSERT_STREQ(skel->bss->value, xattr_value, "value");
+
+out:
+	bpf_link__destroy(link);
+	if (sock_fd >= 0)
+		close(sock_fd);
+	sock_read_xattr__destroy(skel);
+}
+
+void test_sock_xattr(void)
+{
+	RUN_TESTS(sock_read_xattr);
+
+	if (test__start_subtest("read_sock_xattr"))
+		test_read_sock_xattr();
+}
diff --git a/tools/testing/selftests/bpf/progs/sock_read_xattr.c b/tools/testing/selftests/bpf/progs/sock_read_xattr.c
new file mode 100644
index 000000000000..c4a8eae8cc3c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_read_xattr.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Christian Brauner */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+char value[16];
+int read_ret = -1;
+__u32 monitored_pid = 0;
+
+static __always_inline void read_xattr(struct socket *sock)
+{
+	struct bpf_dynptr value_ptr;
+
+	bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
+	bpf_sock_read_xattr(sock, "user.bpf_test", &value_ptr);
+}
+
+SEC("lsm.s/socket_connect")
+__success
+int BPF_PROG(trusted_sock_ptr_sleepable, struct socket *sock)
+{
+	read_xattr(sock);
+	return 0;
+}
+
+SEC("lsm/socket_connect")
+__success
+int BPF_PROG(trusted_sock_ptr_non_sleepable, struct socket *sock)
+{
+	read_xattr(sock);
+	return 0;
+}
+
+SEC("lsm.s/socket_connect")
+__success
+int BPF_PROG(read_sock_xattr, struct socket *sock)
+{
+	struct bpf_dynptr value_ptr;
+	__u32 pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != monitored_pid)
+		return 0;
+
+	bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
+	read_ret = bpf_sock_read_xattr(sock, "user.bpf_test", &value_ptr);
+	return 0;
+}

-- 
2.47.3


