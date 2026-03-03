Return-Path: <netdev+bounces-263335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGTgOcYUp2ncdQAAu9opvQ
	(envelope-from <netdev+bounces-263335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:05:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE511F461E
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 18:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4315A309BB94
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 17:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0008F4EA399;
	Tue,  3 Mar 2026 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7mw7AbO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18944F7979
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557274; cv=none; b=Q2rKxAJwsQ/8ZCwsq2/lQ6z2o80OweDYffCzsjTcP21lS+bKGLFCsSVW6Cax/be1iG3FqJYN3ijRnKEZMR1YIrG12vwd52N2ajbYdWtmpFlW3JfTi9NpfpkBhhDcp2TDTQ1Y2hdVH5WeR7nnBOcVznJ1nGaIiIb+ksaFLtFFuxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557274; c=relaxed/simple;
	bh=JigWNMGvmaqLz9gNJo9scOfVQ5332TtH1CV3c8Fx5Zk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lhoh+5gGwfApLCS+sd/n0R/RiC6EebeLVUwQY7Wxqvb1AXHBijLW3Gg4KoRPtRNzytRlQepXibKivKupnDwdps2My42Hzj7mAXaxqwiXjk+SEk6OP99W9cYyWkXCnD2RMi/NZ1asummTvWNAOrenZfRqfwePDRiXV3GleOkD7vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C7mw7AbO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae467f128fso26093255ad.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 09:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772557273; x=1773162073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rvr9XkY/ko1+sFzIvoHqF1W2S3aBl/jHK/RTg7obYs0=;
        b=C7mw7AbOdSIQLQMj7loEa7NVhR4pjbI1nSkpq/8Oqu/OoQ9jB98NISmQamRrH15ad2
         sMPQxRyY9sccPLqjnUb/hhf4Xe+x4Iu7RjfAnA0C4SnvmsYPeqldHRRoHdjYVBA4z+5Q
         /X0Ytgm8zuDwxrSVOZgaqJAs9FfU2fBQVxEVrrZ0qpjNmcTVy1FhgVj2iuDRj34rKe0Q
         jMzjhtjH8livjpIB1Ji1COItDjcNJT8lWHhs+/e2/OOyJwsGY4VESA4PQZqQv6RJoN9r
         KoziAo/J+6kuOCO4fc3RiZZ0qmsAfInAAcdTj3YuWe3w9g8FoNrgxERRWBxZD5D+KCdw
         BwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772557273; x=1773162073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvr9XkY/ko1+sFzIvoHqF1W2S3aBl/jHK/RTg7obYs0=;
        b=kXUXCzY6QSDUzkMztqM1RNePAUH02knhL6TwNWs6QMDritgcMxplx2BacFRyac8FLq
         8QC4+xoNlnvXaVIviQR1T4SgnYEgNFPTbwqwAZfI3eRlwzj27basw8ULFam2dh7WO6co
         E4WUKub6hxFXYZcXJZLeIak40L/m3AirmBZ67zrVVk5fwaOMJngBxOPgF/nf9nZdDL4d
         oA3dGCgh7oftSfx1+oc6vi0Y0HaGYeQlU/C27Ie/mz804V7Lhohop5bOpYh0ba+1q1hJ
         ETnwKhq2vkhMDpzg1CHenHp/w4QurPkidLxaE121LzLygN6vZ9VvNa+zeWnK9BtA4VFo
         BVJg==
X-Gm-Message-State: AOJu0Yw1n56xdk0NXqlSqrECdTZyTCIuWRYikpuEW/IBuebuoRnWw4nV
	afSZGYIcVtToN2oXPrGBqrwTW83mXQh056kvNRnqovr4dpuS5XO9HagxaRngj1qErJK00JmSw3l
	qy2X0cTa8CR1++5zpTJAMal2qPl8PMxQMjJtCxk2is0z9DZL+Xhq77M9w5n1SmkzKD6rFmXG7tr
	e7vJJuX+6lkDoSf4yfq5AJ4AhQIX+8sK8=
X-Received: from plblf4.prod.google.com ([2002:a17:902:fb44:b0:2ae:41d1:2788])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8d:b0:2ae:5848:baf0
 with SMTP id d9443c01a7336-2ae5848bcc4mr60259455ad.2.1772557272638; Tue, 03
 Mar 2026 09:01:12 -0800 (PST)
Date: Tue,  3 Mar 2026 17:01:03 +0000
In-Reply-To: <20260303170106.129698-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303170106.129698-1-jrife@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303170106.129698-3-jrife@google.com>
Subject: [PATCH net-next v2 2/2] selftests/bpf: Ensure dst addr/port are
 preserved after socket abort
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5EE511F461E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263335-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jrife@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Ensure that sock_release hooks see the original dst_ip4, dst_ip6, and
dst_port values for connected UDP and TCP sockets following a socket
abort.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../bpf/prog_tests/sock_destroy_release.c     | 136 ++++++++++++++++++
 .../bpf/progs/sock_destroy_release.c          |  59 ++++++++
 2 files changed, 195 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_release.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
new file mode 100644
index 000000000000..a2db4f31f6fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
@@ -0,0 +1,136 @@
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
+	connect_fd = -1;
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
2.53.0.473.g4a7958ca14-goog


