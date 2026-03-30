Return-Path: <netdev+bounces-273335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPPkHlvzymlaBwYAu9opvQ
	(envelope-from <netdev+bounces-273335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:04:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A94361BB5
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F80B30721AB
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0173A962B;
	Mon, 30 Mar 2026 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hglfrKjJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB6D3A900B
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907840; cv=none; b=VWBDbIjtA8SsdrIZpova/q7079lvi3Aslx1xLgxF8cS7Xqp/QK24CSDLfVPjk85KyTczG0lAhKaCocGv+in4wxI3RySfBekM9RQ3FNTRT5ukZGA1mTmVRD/prD//fR9nxYMY/kQKBY1WZALLy3ukx46o7/CNNuIFxuzRS1TF8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907840; c=relaxed/simple;
	bh=CxR+Pe23WASmZBuQZaxxX17xPnkhIzOYlohudURjhDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GN8qSsxmwseA/HT4zyOMqfab1Pzyjuy1Qr42wL9eZr6En3XmraUNDngbuJe//7ks4ltdBU4u2BSy4Nw/Rb4inrhcqXPV4q6I8hAQm5UDeqWBIm2ijrQ/SBokzo+8jiwPnnyXItY7D4Qq0XZPQT+aCm3BwRig65AHiItdg80PSd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hglfrKjJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b242062308so79816545ad.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 14:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774907836; x=1775512636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=23MQmI5iu/9tUe+qkST+OSiXLF23vjtZ10wE6fADUos=;
        b=hglfrKjJpE89k+mEUJkqte3LJxG9uoMSM2TscMQ1cozKOkFbrJCDCY1l5byT7QxwYz
         Fj+pePB5llBbtKvdVP9ZTZaq132rQJbFLjKnOgeDrVBjvT6lfZMVi8bm2AQKi7SzhmSu
         OhZW4n5/rA4zohSZL03zTws1Musy3ZnHlsjhZj8FxIJ+NtFtTvgA/u0+y5ww8zk/vrlA
         jpz3dyM3F0EC7yr0xmZiDoLp9C7TaS6NGo+QbGtbNDLwuV3ffF3bO3AlNck8r4QFSnAB
         KoIy82UEDu3WBPkHByBUpWV/A32WED6XBKkqxZ+hRSy7kFK7n4LN5eG4QDue8oV7x6cJ
         mrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907836; x=1775512636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23MQmI5iu/9tUe+qkST+OSiXLF23vjtZ10wE6fADUos=;
        b=T0Ohv8DjHMAI3fTe3jWZr/CfTC/ylT6y9NvcWEcwCL6RE+d6rcrYrle0zQm0v6pxuu
         52vj9mtJSF7NBVVjC1ervTe0Onpl2pFEwBPGcLmzwr3yRXgHeiKBg3YMKIqzKzM75+FC
         rm/7aba9LzkmdX9IU77RHx+gTNGNIgUNc2T8mSmgQ4utSp16jLwlsCov+qQS2wwaXM5d
         1WFJ262vZkcKi/cUD0+tgFyBAyrd+3W1Ae4/FtJ7oneD9Iu2Ras38bHet32A3/RLFybX
         L6Z8Qtx1C/YYuj5W809HB5QsNWVwqkzudlnf4dQL6HM2DCUY4bOW8TMbLAaiPdOn3f0E
         9rAw==
X-Gm-Message-State: AOJu0Yy8Qnl58TWAg/prL57zpx6BfVUwLukP/8FtHj7ePBx3rxDXp33f
	vhlrRuslBGA5tqZ2WxyyAlPe9CRxslFPKIfLDKwOK0J2rFFqdCv2KZpuxmJivY+Ayw8WRNA7Cbh
	C/s+PLYty5RHZnkklRlzfOnlAsjWCPLjMin8HqHmf8VlFrEHiCL1z8Yw/szMr1ioQplfNvxhHdo
	QkXw3uEs8k+EK4AAVi+IazOcUjSvL3l4I=
X-Received: from plsk9.prod.google.com ([2002:a17:902:ba89:b0:2b0:5b78:8e47])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:98d:b0:2b0:60f1:de58
 with SMTP id d9443c01a7336-2b0cdcfae43mr147648385ad.45.1774907836137; Mon, 30
 Mar 2026 14:57:16 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:57:04 +0000
In-Reply-To: <20260330215707.2374657-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260330215707.2374657-1-jrife@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260330215707.2374657-5-jrife@google.com>
Subject: [PATCH net-next v3 4/4] selftests/bpf: Ensure dst addr/port are
 preserved after socket abort
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273335-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jrife@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5A94361BB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ensure that sock_release hooks see the original dst_ip4, dst_ip6, and
dst_port values for connected UDP and TCP sockets following a socket
abort.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../bpf/prog_tests/sock_destroy_release.c     | 180 ++++++++++++++++++
 .../bpf/progs/sock_destroy_release.c          |  56 ++++++
 2 files changed, 236 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_release.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
new file mode 100644
index 000000000000..022031332b83
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "network_helpers.h"
+#include "sock_destroy_release.skel.h"
+
+#define TEST_NS "sock_destroy_release_netns"
+#define BIND_ADDR4 "127.0.0.1"
+#define BIND_ADDR6 "::1"
+#define ANY_ADDR4 "0.0.0.0"
+#define ANY_ADDR6 "::"
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
+}
+
+static void do_test(struct sock_destroy_release *skel, int sock_type,
+		    int family, const char *bind_addr_str, const int bind_port)
+{
+	const char *addr = family == AF_INET ? BIND_ADDR4 : BIND_ADDR6;
+	int listen_fd = -1, connect_fd = -1, accept_fd = -1;
+	struct sockaddr_storage bind_addr;
+	static const int port = 10001;
+	socklen_t bind_addr_len;
+
+	listen_fd = start_server(family, sock_type, addr, port, 0);
+	if (!ASSERT_OK_FD(listen_fd, "start_server"))
+		goto cleanup;
+
+	connect_fd = client_socket(family, sock_type, NULL);
+	if (!ASSERT_OK_FD(connect_fd, "client_socket"))
+		goto cleanup;
+
+	if (bind_addr_str) {
+		if (!ASSERT_OK(make_sockaddr(family, bind_addr_str, bind_port,
+					     &bind_addr, &bind_addr_len),
+			       "make_sockaddr"))
+			goto cleanup;
+		if (!ASSERT_OK(bind(connect_fd, (struct sockaddr *)&bind_addr,
+				    bind_addr_len), "bind"))
+			goto cleanup;
+	}
+
+	if (!ASSERT_OK(connect_fd_to_fd(connect_fd, listen_fd, 0),
+		       "connect_fd_to_fd"))
+		goto cleanup;
+
+	memset(&skel->bss->sk, 0, sizeof(skel->bss->sk));
+	destroy(skel, connect_fd, sock_type);
+	close(connect_fd);
+	connect_fd = -1;
+	ASSERT_EQ(ntohs(skel->bss->sk.dst_port), port, "dst_port");
+	if (family == AF_INET) {
+		ASSERT_EQ(ntohl(skel->bss->sk.dst_ip4), 0x7f000001, "dst_ip4");
+	} else {
+		ASSERT_EQ(skel->bss->sk.dst_ip6[0], 0, "dst_ip6[0]");
+		ASSERT_EQ(skel->bss->sk.dst_ip6[1], 0, "dst_ip6[1]");
+		ASSERT_EQ(skel->bss->sk.dst_ip6[2], 0, "dst_ip6[2]");
+		ASSERT_EQ(ntohl(skel->bss->sk.dst_ip6[3]), 0x1, "dst_ip6[3]");
+	}
+cleanup:
+	if (connect_fd >= 0)
+		close(connect_fd);
+	if (accept_fd >= 0)
+		close(accept_fd);
+	if (listen_fd >= 0)
+		close(listen_fd);
+}
+
+static void do_tests(struct sock_destroy_release *skel, int sock_type,
+		     int family, const char * const *bind_addrs,
+		     size_t bind_addrs_len, const int *bind_ports,
+		     size_t bind_ports_len)
+{
+	const char *protocol_name = sock_type == SOCK_STREAM ? "tcp" : "udp";
+	const char *family_name = family == AF_INET ? "ipv4" : "ipv6";
+	char name[256];
+
+	for (size_t i = 0; i < bind_addrs_len; i++) {
+		for (size_t j = 0; j < bind_ports_len; j++) {
+			snprintf(name, sizeof(name), "%s/%s/destroy/%s:%d",
+				 protocol_name, family_name, bind_addrs[i],
+				 bind_ports[j]);
+			if (test__start_subtest(name))
+				do_test(skel, sock_type, family, bind_addrs[i],
+					bind_ports[j]);
+		}
+	}
+}
+
+void test_sock_destroy_release(void)
+{
+	static const char * const bind4_addresses[] = {NULL, ANY_ADDR4,
+						       BIND_ADDR4};
+	static const char * const bind6_addresses[] = {NULL, ANY_ADDR6,
+						       BIND_ADDR6};
+	static const int bind_ports[] = {0, 10002};
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
+	do_tests(skel, SOCK_STREAM, AF_INET, bind4_addresses,
+		 ARRAY_SIZE(bind4_addresses), bind_ports,
+		 ARRAY_SIZE(bind_ports));
+	do_tests(skel, SOCK_STREAM, AF_INET6, bind6_addresses,
+		 ARRAY_SIZE(bind6_addresses), bind_ports,
+		 ARRAY_SIZE(bind_ports));
+	do_tests(skel, SOCK_DGRAM, AF_INET, bind4_addresses,
+		 ARRAY_SIZE(bind4_addresses), bind_ports,
+		 ARRAY_SIZE(bind_ports));
+	do_tests(skel, SOCK_DGRAM, AF_INET6, bind6_addresses,
+		 ARRAY_SIZE(bind6_addresses), bind_ports,
+		 ARRAY_SIZE(bind_ports));
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
index 000000000000..5389f79226f9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_release.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
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
2.53.0.1118.gaef5881109-goog


