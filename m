Return-Path: <netdev+bounces-260634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLuMIGH3nWlzSwQAu9opvQ
	(envelope-from <netdev+bounces-260634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:09:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D8C18BAFF
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE54C319AF0B
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84862EDD6B;
	Tue, 24 Feb 2026 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeQe/3hx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A43002DD
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959925; cv=none; b=oB9mvb2XLMqTbSSDdvj1tIDfb4N8FFmGpXwIazAxa01mqQ8vsPuQju1Ts2ylEJYM0TiRfC6MbDfX9/zP7IDt0pO/vENf1wEzjnNTxzOHF//0WwsQ8DM+ZC/YSnZjWICTfd+o15WM6oF+D7WQB6nTuCpAcZWUkBTvtT+XeVgt9gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959925; c=relaxed/simple;
	bh=552Y4pNyEWbkFeaV8F/wPoQk1xZe53R6fpyi2qf53Hg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gBGJb05iCmyFexPNeRX846HVHdIT0wV7aeFjyGH9zye8EUNmDf5GcLn14BvzgLc5NnDcQC+zKJwOP9ccSaAOvU0awrGvg1077axl7tJYIq5fQE8NLkApwtMsq52xm0aNaXFnMiUytWIq8nSAkbL19iy07nIjtD3QhipQBzarUeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OeQe/3hx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aaeafeadbcso67150635ad.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771959922; x=1772564722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fwm6jg8ZPLLWy9k7FZg5vuDxiOfPvk4tb+T81oXf3nE=;
        b=OeQe/3hxinwNOMtxYq7fDh/dvzWFC1sFrZq/Bg/JpaGe1aQ2R1nR58N+RximCgb0BL
         6nNrmZSnOEq77fK/HEZ8wKz8GPKCvFGNtFGk8yFHShUi8eYGsiES+0/fWR6PS2wlzCt7
         48+JktH/iIug5u3K9MnWHPOfe/D0O5fQDoDzvB8qBjCP29FYZtutQx65nKrtxYvJpCu7
         RujPcdUSsnfc4mi6ssRun8ownqZRWChQT922o2ynVQ1WfhvO4sKX8huj2GSn7SGlam/J
         XAA/y6+yIycAM754XlOtpoVgKg02SBIs6jM53a0O+lALD/5G3nSWDS6WQVDbLVpWVP6D
         xs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959922; x=1772564722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwm6jg8ZPLLWy9k7FZg5vuDxiOfPvk4tb+T81oXf3nE=;
        b=AT99TIp3H3mwHxoI40o55RpQ/VLXe0h4kLdnFPvHsiwoVOtyYdr8pZSmGsQk0DBsfn
         V243zEyWXMpjA3i4/uMwi5QYdBld0DBtEc7asKqs0IYBJBTrWVdRm44rJWYBs3y2/w2z
         tVSdejRgi2NHSukwf52HIztbt7ln1CQgps859D1ANi5EgTbXMCBKi1ROKM/VkCTLjHvC
         D/PhMI2s8Qw1Ueqd7Gowbk5s6UCjqO/NBnl2UV7jiXFAN9TBuh6SwJwu2KCjakPmnzV9
         7iXV9QznS3Te+BDj3zUB/IM5OfnlAjcF3Nr2cDKgH2+u8tnBhr5qTXTAuMvs4pcjfcQF
         COZg==
X-Gm-Message-State: AOJu0Yy5GZJ5y/RIt1KIFune0JikthXGdSJC/eUBbU/NyHCoIufbMb5t
	irPozZEpFEmKw/KZHQiZRcKxRkE11UMGkB65v5NLJCDfyvMfjGSuh8XBXX9okJK0QuPWU6nvDsT
	5xjvQe5L+WB00lMAkrxA+XeFBa5jApoilFf8B8c9znj8hhhf7KWLNYaiZlSh3AtqbsRhe/Me1uz
	ZbwNms27+hDXzOV9ghB0k1zS4PNd+RNms=
X-Received: from plbaz2.prod.google.com ([2002:a17:902:a582:b0:290:aaff:140b])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c5:b0:2aa:f9d7:68aa
 with SMTP id d9443c01a7336-2ad74467e33mr134392265ad.21.1771959921791; Tue, 24
 Feb 2026 11:05:21 -0800 (PST)
Date: Tue, 24 Feb 2026 19:04:46 +0000
In-Reply-To: <20260224190516.2102048-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260224190516.2102048-1-jrife@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260224190516.2102048-3-jrife@google.com>
Subject: [PATCH net-next v1 2/2] selftests/bpf: Ensure dst addr/port are
 preserved after socket abort
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260634-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jrife@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.953];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4D8C18BAFF
X-Rspamd-Action: no action

Ensure that sock_release hooks see the original dst_ip4, dst_ip6, and
dst_port values for connected UDP and TCP sockets following a socket
abort.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../bpf/prog_tests/sock_destroy_release.c     | 135 ++++++++++++++++++
 .../bpf/progs/sock_destroy_release.c          |  59 ++++++++
 2 files changed, 194 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_release.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
new file mode 100644
index 000000000000..9bd2be4d45a2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "network_helpers.h"
+#include "sock_destroy_release.skel.h"
+
+#define TEST_NS "sock_destroy_release_netns"
+
+static __u64 socket_cookie(int fd)
+{
+	__u64 cookie;
+	socklen_t cookie_len = sizeof(cookie);
+
+	if (!ASSERT_OK(getsockopt(fd, SOL_SOCKET, SO_COOKIE, &cookie,
+				  &cookie_len), "getsockopt(SO_COOKIE)"))
+		return 0;
+	return cookie;
+}
+
+static void destroy(struct sock_destroy_release *skel, int fd, int sock_type)
+{
+	__u64 cookie = socket_cookie(fd);
+	struct bpf_link *link = NULL;
+	int iter_fd = -1;
+	int nread;
+	__u64 out;
+
+	skel->bss->abort_cookie = cookie;
+
+	link = bpf_program__attach_iter(sock_type == SOCK_STREAM ?
+					skel->progs.abort_tcp :
+					skel->progs.abort_udp, NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
+		goto done;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_OK_FD(iter_fd, "bpf_iter_create"))
+		goto done;
+
+	/* Delete matching socket. */
+	nread = read(iter_fd, &out, sizeof(out));
+	ASSERT_GE(nread, 0, "nread");
+	if (nread)
+		ASSERT_EQ(out, cookie, "cookie matches");
+done:
+	if (iter_fd >= 0)
+		close(iter_fd);
+	bpf_link__destroy(link);
+	close(fd);
+}
+
+static void do_test(struct sock_destroy_release *skel, int sock_type,
+		    int family)
+{
+	const char *addr = family == AF_INET ? "127.0.0.1" : "::1";
+	int listen_fd = -1, connect_fd = -1;
+	static const int port = 10001;
+
+	listen_fd = start_server(family, sock_type, addr, port, 0);
+	if (!ASSERT_OK_FD(listen_fd, "start_server"))
+		goto cleanup;
+
+	connect_fd = connect_to_fd(listen_fd, 0);
+	if (!ASSERT_OK_FD(connect_fd, "connect_to_fd"))
+		goto cleanup;
+
+	memset(&skel->bss->sk, 0, sizeof(skel->bss->sk));
+	destroy(skel, connect_fd, sock_type);
+	if (!ASSERT_EQ(ntohs(skel->bss->sk.dst_port), port, "dst_port"))
+		goto cleanup;
+	if (family == AF_INET) {
+		if (!ASSERT_EQ(ntohl(skel->bss->sk.dst_ip4), 0x7f000001,
+			       "dst_ip4"))
+			goto cleanup;
+	} else {
+		if (!ASSERT_EQ(skel->bss->sk.dst_ip6[0], 0, "dst_ip6[0]"))
+			goto cleanup;
+		if (!ASSERT_EQ(skel->bss->sk.dst_ip6[1], 0, "dst_ip6[1]"))
+			goto cleanup;
+		if (!ASSERT_EQ(skel->bss->sk.dst_ip6[2], 0, "dst_ip6[2]"))
+			goto cleanup;
+		if (!ASSERT_EQ(ntohl(skel->bss->sk.dst_ip6[3]), 0x1,
+			       "dst_ip6[3]"))
+			goto cleanup;
+	}
+cleanup:
+	if (connect_fd >= 0)
+		close(connect_fd);
+	if (listen_fd >= 0)
+		close(listen_fd);
+}
+
+void test_sock_destroy_release(void)
+{
+	struct sock_destroy_release *skel = NULL;
+	struct nstoken *nstoken = NULL;
+	int cgroup_fd = -1;
+
+	skel = sock_destroy_release__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto done;
+
+	cgroup_fd = test__join_cgroup("/sock_destroy_release");
+	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup"))
+		goto done;
+
+	skel->links.sock_release = bpf_program__attach_cgroup(
+		skel->progs.sock_release, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.sock_release, "attach_cgroup"))
+		goto done;
+
+	SYS_NOFAIL("ip netns del " TEST_NS);
+	SYS(done, "ip netns add %s", TEST_NS);
+	SYS(done, "ip -net %s link set dev lo up", TEST_NS);
+
+	nstoken = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
+		goto done;
+
+	if (test__start_subtest("tcp")) {
+		do_test(skel, SOCK_STREAM, AF_INET);
+		do_test(skel, SOCK_STREAM, AF_INET6);
+	}
+	if (test__start_subtest("udp")) {
+		do_test(skel, SOCK_DGRAM, AF_INET);
+		do_test(skel, SOCK_DGRAM, AF_INET6);
+	}
+done:
+	if (nstoken)
+		close_netns(nstoken);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	SYS_NOFAIL("ip netns del " TEST_NS);
+	sock_destroy_release__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_release.c b/tools/testing/selftests/bpf/progs/sock_destroy_release.c
new file mode 100644
index 000000000000..add322ab1303
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_release.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_kfuncs.h"
+
+volatile __u64 abort_cookie;
+
+void maybe_abort(struct sock_common *sk, struct seq_file *seq)
+{
+	__u64 sock_cookie;
+
+	if (!sk)
+		return;
+
+	sock_cookie = bpf_get_socket_cookie(sk);
+	if (sock_cookie != abort_cookie)
+		return;
+
+	bpf_sock_destroy(sk);
+	bpf_seq_write(seq, &sock_cookie, sizeof(sock_cookie));
+}
+
+SEC("iter/udp")
+int abort_udp(struct bpf_iter__udp *ctx)
+{
+	maybe_abort((struct sock_common *)ctx->udp_sk,
+		    ctx->meta->seq);
+
+	return 0;
+}
+
+SEC("iter/tcp")
+int abort_tcp(struct bpf_iter__tcp *ctx)
+{
+	maybe_abort((struct sock_common *)ctx->sk_common,
+		    ctx->meta->seq);
+
+	return 0;
+}
+
+struct bpf_sock sk = {};
+
+SEC("cgroup/sock_release")
+int sock_release(struct bpf_sock *ctx)
+{
+	sk.dst_ip4 = ctx->dst_ip4;
+	sk.dst_ip6[0] = ctx->dst_ip6[0];
+	sk.dst_ip6[1] = ctx->dst_ip6[1];
+	sk.dst_ip6[2] = ctx->dst_ip6[2];
+	sk.dst_ip6[3] = ctx->dst_ip6[3];
+	sk.dst_port = ctx->dst_port;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0.414.gf7e9f6c205-goog


