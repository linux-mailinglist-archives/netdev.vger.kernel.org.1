Return-Path: <netdev+bounces-221346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 661EFB503D3
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C0A4E1BC5
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0048A2DFA38;
	Tue,  9 Sep 2025 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ISrdpp8O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A48371E89
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437232; cv=none; b=DYGV3jlx7OcYsUEtMcOejoLr2WmS1xCU2px1GiTeSxKY2CqIwM7yS+A8RaqL4UxwfG229zVi4XeQunXxX/WSJrYKIn0B0A7y13zqmGD9o14UNOa7kBYYMVtLpg3gJOZazERUe3tbjKj8Sr1EsPx9sN0dq5FJzTgj26JfoQ1fLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437232; c=relaxed/simple;
	bh=tGDHJIgCTUUPwRtopnD/nRijjraAsc7+FnfoSWhHjLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtc11mZ33Gy+vfYs9t3eUnqTsOKCsIz0Pyk30o4wIcmJEeywe5XPg/SeKqeEGt61QnnCVrQVRj8XFhSq4cQGHZ2I7RB40z13J/rLRuxSRQtZMedC2cX5xG33A0ppkb1+8RW4I96O7vu9YpQQUWjmiDHla5cFxqVK2721ShMjTrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ISrdpp8O; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4741e1cde5so641786a12.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437230; x=1758042030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnDZGyoYcvbN/fAhHed4VoGwhEHHH/8bxxHpG8Zt2E4=;
        b=ISrdpp8OKkzTM1dkB+jD+wwrY/pIYprtqmOFT2l8XQrYN1Nqig++Hx8OhS6AKcunqJ
         MJG8C8tuW5NTPoUpmdIt6Iic0ziLK1Kft13qelUvs39qSvtexLAu9G3ardM0avG8sunb
         xHY9rBoJn5F8F3og6HiA1LWoJ0cgfhvtQf+zJMvclnc/AUaD3CH+IqY/OQo50U+5QfrQ
         FxqmdvHZehte8wb57YUP76T2O1IpzsxrDhvGj9iWiZXtpA8dtzPp6SYH5T7Ca66DXxaS
         e5KLQm/gNVWo1G/TFHMZG5rQFkYbxuFWKM7JjphA/ZxRdIyP7/WHZ4M2QqY4R66ltLI9
         2C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437230; x=1758042030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnDZGyoYcvbN/fAhHed4VoGwhEHHH/8bxxHpG8Zt2E4=;
        b=kycsCZfXbVJa53Efz/0Xdo8ugJdgNXjwRxLpBArQg8/iyoOUN0+xGqS9WEBxJ3INyF
         jP2ttvObQpxMFucb9oB2LLUFlvhosSeQ7MpaVljwydZPqwTQvSboP88j1himEaa6v/3E
         aQvcmoBHpjhg2OGlNgUcQ0dq5d/xhxF71rtgAxY1VMMb6amHJEtOQa2MmkNrzIVA9PWC
         Bn28E9S+2L11Mc5wIozGWjEoXSiv2qwHSgVqtJCeFoHzzYV5F0MgDxLHzEJYcRJpUou4
         UW3y5p98JzHS7qFM1gOP7S6xAqxzPX378TN56j6UE1ZWcqK3h/f22EFpvJPcnbuj/Rzq
         UOeg==
X-Forwarded-Encrypted: i=1; AJvYcCWEta8jJudAJQAk1kEIGL5Vq5kjVEG96qWyAAt4gSVKrPT1AYYsAMJq5XqPV9JAZK+boJySKRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOfuUGtWMKe1Ynxq5TOS/Pfh0z7N/rj8xyP1dXy0CtgqJDmMk
	2QZE7bYK9fgtcMwNBrldCyLZWNrqDntDe9dP0JeFxToSy9eRW9JKRhNrzC8oANX18og=
X-Gm-Gg: ASbGncuS5TCZ9NG3Cj2KZiUf242Sn4V83rQvF31V4KEFmIH7VJrpe2zMcRNUCi7yaHN
	bVyaI46l3Foc3rAbU9MyVoIy31yH/GXPMR+4qN+/cskMDE8jyDol7etZcoyB6v5Qq7tw+RAuZvk
	OKZYVeq4LBFV2eCuN61OQ1IIHHa8wLg1m37DP2OfaiWLJQeDSRn79iUP6JVCeXpEu4z2qSaJdq7
	Jwc/dFrzIXyiNP4Hb9RmSzJcH3vXDxADuwW35gLMzogBlasU/BrM/ym+xsHRFa+XLNjqHOTqtC9
	DPb2WXgFZbsllM82qo/L12B2Hv02W4+gnWHjEbokwBxA8LnG8gtZrijrztbmAmb3W9oDzArTDtA
	tpsUwOvG5r3ousWkoIchDEikd
X-Google-Smtp-Source: AGHT+IFyxjVSMtlEkbxXV8DgdUiK7K23TWlpUVj53Sf/Vqhsr07QctML3Y77JRwPj85vC/mneF0wVw==
X-Received: by 2002:a05:6a21:6da1:b0:252:3a33:660f with SMTP id adf61e73a8af0-2534441f65amr9965493637.4.1757437230316;
        Tue, 09 Sep 2025 10:00:30 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:29 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 05/14] selftests/bpf: Test bpf_sock_destroy() with sockmap iterators
Date: Tue,  9 Sep 2025 09:59:59 -0700
Message-ID: <20250909170011.239356-6-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expand the suite of tests for bpf_sock_destroy() to include invocation
from socket map and socket hash iterators.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../selftests/bpf/prog_tests/sock_destroy.c   | 119 +++++++++++++++---
 .../selftests/bpf/progs/sock_destroy_prog.c   |  63 ++++++++++
 2 files changed, 164 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
index 9c11938fe597..829e6fb9c1d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
@@ -8,13 +8,20 @@
 
 #define TEST_NS "sock_destroy_netns"
 
-static void start_iter_sockets(struct bpf_program *prog)
+static void start_iter_sockets(struct bpf_program *prog, struct bpf_map *map)
 {
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo = {};
 	struct bpf_link *link;
 	char buf[50] = {};
 	int iter_fd, len;
 
-	link = bpf_program__attach_iter(prog, NULL);
+	if (map)
+		linfo.map.map_fd = bpf_map__fd(map);
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(prog, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_iter"))
 		return;
 
@@ -32,7 +39,22 @@ static void start_iter_sockets(struct bpf_program *prog)
 	bpf_link__destroy(link);
 }
 
-static void test_tcp_client(struct sock_destroy_prog *skel)
+static int insert_socket(struct bpf_map *socks, int fd, __u32 key)
+{
+	int map_fd = bpf_map__fd(socks);
+	__s64 sfd = fd;
+	int ret;
+
+	ret = bpf_map_update_elem(map_fd, &key, &sfd, BPF_NOEXIST);
+	if (!ASSERT_OK(ret, "map_update"))
+		return -1;
+
+	return 0;
+}
+
+static void test_tcp_client(struct sock_destroy_prog *skel,
+			    struct bpf_program *prog,
+			    struct bpf_map *socks)
 {
 	int serv = -1, clien = -1, accept_serv = -1, n;
 
@@ -52,8 +74,17 @@ static void test_tcp_client(struct sock_destroy_prog *skel)
 	if (!ASSERT_EQ(n, 1, "client send"))
 		goto cleanup;
 
+	if (socks) {
+		if (!ASSERT_OK(insert_socket(socks, clien, 0),
+			       "insert_socket"))
+			goto cleanup;
+		if (!ASSERT_OK(insert_socket(socks, serv, 1),
+			       "insert_socket"))
+			goto cleanup;
+	}
+
 	/* Run iterator program that destroys connected client sockets. */
-	start_iter_sockets(skel->progs.iter_tcp6_client);
+	start_iter_sockets(prog, socks);
 
 	n = send(clien, "t", 1, 0);
 	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
@@ -69,7 +100,9 @@ static void test_tcp_client(struct sock_destroy_prog *skel)
 		close(serv);
 }
 
-static void test_tcp_server(struct sock_destroy_prog *skel)
+static void test_tcp_server(struct sock_destroy_prog *skel,
+			    struct bpf_program *prog,
+			    struct bpf_map *socks)
 {
 	int serv = -1, clien = -1, accept_serv = -1, n, serv_port;
 
@@ -93,8 +126,17 @@ static void test_tcp_server(struct sock_destroy_prog *skel)
 	if (!ASSERT_EQ(n, 1, "client send"))
 		goto cleanup;
 
+	if (socks) {
+		if (!ASSERT_OK(insert_socket(socks, clien, 0),
+			       "insert_socket"))
+			goto cleanup;
+		if (!ASSERT_OK(insert_socket(socks, accept_serv, 1),
+			       "insert_socket"))
+			goto cleanup;
+	}
+
 	/* Run iterator program that destroys server sockets. */
-	start_iter_sockets(skel->progs.iter_tcp6_server);
+	start_iter_sockets(prog, socks);
 
 	n = send(clien, "t", 1, 0);
 	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
@@ -110,7 +152,9 @@ static void test_tcp_server(struct sock_destroy_prog *skel)
 		close(serv);
 }
 
-static void test_udp_client(struct sock_destroy_prog *skel)
+static void test_udp_client(struct sock_destroy_prog *skel,
+			    struct bpf_program *prog,
+			    struct bpf_map *socks)
 {
 	int serv = -1, clien = -1, n = 0;
 
@@ -126,8 +170,17 @@ static void test_udp_client(struct sock_destroy_prog *skel)
 	if (!ASSERT_EQ(n, 1, "client send"))
 		goto cleanup;
 
+	if (socks) {
+		if (!ASSERT_OK(insert_socket(socks, clien, 0),
+			       "insert_socket"))
+			goto cleanup;
+		if (!ASSERT_OK(insert_socket(socks, serv, 1),
+			       "insert_socket"))
+			goto cleanup;
+	}
+
 	/* Run iterator program that destroys sockets. */
-	start_iter_sockets(skel->progs.iter_udp6_client);
+	start_iter_sockets(prog, socks);
 
 	n = send(clien, "t", 1, 0);
 	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
@@ -143,11 +196,14 @@ static void test_udp_client(struct sock_destroy_prog *skel)
 		close(serv);
 }
 
-static void test_udp_server(struct sock_destroy_prog *skel)
+static void test_udp_server(struct sock_destroy_prog *skel,
+			    struct bpf_program *prog,
+			    struct bpf_map *socks)
 {
 	int *listen_fds = NULL, n, i, serv_port;
 	unsigned int num_listens = 5;
 	char buf[1];
+	__u32 key;
 
 	/* Start reuseport servers. */
 	listen_fds = start_reuseport_server(AF_INET6, SOCK_DGRAM,
@@ -159,8 +215,15 @@ static void test_udp_server(struct sock_destroy_prog *skel)
 		goto cleanup;
 	skel->bss->serv_port = (__be16) serv_port;
 
+	if (socks)
+		for (key = 0; key < num_listens; key++)
+			if (!ASSERT_OK(insert_socket(socks, listen_fds[key],
+						     key),
+				       "insert_socket"))
+				goto cleanup;
+
 	/* Run iterator program that destroys server sockets. */
-	start_iter_sockets(skel->progs.iter_udp6_server);
+	start_iter_sockets(prog, socks);
 
 	for (i = 0; i < num_listens; ++i) {
 		n = read(listen_fds[i], buf, sizeof(buf));
@@ -200,14 +263,34 @@ void test_sock_destroy(void)
 	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
 		goto cleanup;
 
-	if (test__start_subtest("tcp_client"))
-		test_tcp_client(skel);
-	if (test__start_subtest("tcp_server"))
-		test_tcp_server(skel);
-	if (test__start_subtest("udp_client"))
-		test_udp_client(skel);
-	if (test__start_subtest("udp_server"))
-		test_udp_server(skel);
+	if (test__start_subtest("tcp_client")) {
+		test_tcp_client(skel, skel->progs.iter_tcp6_client, NULL);
+		test_tcp_client(skel, skel->progs.iter_sockmap_client,
+				skel->maps.sock_map);
+		test_tcp_client(skel, skel->progs.iter_sockmap_client,
+				skel->maps.sock_hash);
+	}
+	if (test__start_subtest("tcp_server")) {
+		test_tcp_server(skel, skel->progs.iter_tcp6_server, NULL);
+		test_tcp_server(skel, skel->progs.iter_sockmap_server,
+				skel->maps.sock_map);
+		test_tcp_server(skel, skel->progs.iter_sockmap_server,
+				skel->maps.sock_hash);
+	}
+	if (test__start_subtest("udp_client")) {
+		test_udp_client(skel, skel->progs.iter_udp6_client, NULL);
+		test_udp_client(skel, skel->progs.iter_sockmap_client,
+				skel->maps.sock_map);
+		test_udp_client(skel, skel->progs.iter_sockmap_client,
+				skel->maps.sock_hash);
+	}
+	if (test__start_subtest("udp_server")) {
+		test_udp_server(skel, skel->progs.iter_udp6_server, NULL);
+		test_udp_server(skel, skel->progs.iter_sockmap_server,
+				skel->maps.sock_map);
+		test_udp_server(skel, skel->progs.iter_sockmap_server,
+				skel->maps.sock_hash);
+	}
 
 	RUN_TESTS(sock_destroy_prog_fail);
 
diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
index 9e0bf7a54cec..d91f75190bbf 100644
--- a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
+++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
@@ -24,6 +24,20 @@ struct {
 	__type(value, __u64);
 } udp_conn_sockets SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 5);
+	__type(key, __u32);
+	__type(value, __u64);
+} sock_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 5);
+	__type(key, __u32);
+	__type(value, __u64);
+} sock_hash SEC(".maps");
+
 SEC("cgroup/connect6")
 int sock_connect(struct bpf_sock_addr *ctx)
 {
@@ -142,4 +156,53 @@ int iter_udp6_server(struct bpf_iter__udp *ctx)
 	return 0;
 }
 
+SEC("iter/sockmap")
+int iter_sockmap_client(struct bpf_iter__sockmap *ctx)
+{
+	__u64 sock_cookie = 0, *val;
+	struct sock *sk = ctx->sk;
+	__u32 *key = ctx->key;
+	__u32 zero = 0;
+
+	if (!key || !sk)
+		return 0;
+
+	sock_cookie  = bpf_get_socket_cookie(sk);
+	val = bpf_map_lookup_elem(&udp_conn_sockets, &zero);
+	if (val && *val == sock_cookie)
+		goto destroy;
+	val = bpf_map_lookup_elem(&tcp_conn_sockets, &zero);
+	if (val && *val == sock_cookie)
+		goto destroy;
+	goto out;
+destroy:
+	bpf_sock_destroy((struct sock_common *)sk);
+out:
+	return 0;
+}
+
+SEC("iter/sockmap")
+int iter_sockmap_server(struct bpf_iter__sockmap *ctx)
+{
+	struct sock *sk = ctx->sk;
+	struct tcp6_sock *tcp_sk;
+	struct udp6_sock *udp_sk;
+	__u32 *key = ctx->key;
+
+	if (!key || !sk)
+		return 0;
+
+	tcp_sk = bpf_skc_to_tcp6_sock(sk);
+	if (tcp_sk && tcp_sk->tcp.inet_conn.icsk_inet.inet_sport == serv_port)
+		goto destroy;
+	udp_sk = bpf_skc_to_udp6_sock(sk);
+	if (udp_sk && udp_sk->udp.inet.inet_sport == serv_port)
+		goto destroy;
+	goto out;
+destroy:
+	bpf_sock_destroy((struct sock_common *)sk);
+out:
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


