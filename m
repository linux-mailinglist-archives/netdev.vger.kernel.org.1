Return-Path: <netdev+bounces-202615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D96AEE584
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC6BF7AB8F7
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7562BEFF4;
	Mon, 30 Jun 2025 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="llpSXkpQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCB29CB4F
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303860; cv=none; b=lng4L8op09scj/38DTNh4JyQu6LjRfUO/272Cs1YwrHmXzzyN1Gtsl7deh/8D/GUJSL2IQwl6u5lE2aMb0G6xr7edT+tN/L76MN0OY3zXhwyyPXFjaFEUBnvY/PAJuloQ6ZdWHbeodBhOzHJSmBUlS/CYgHmph4Mc9vn5/UqcCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303860; c=relaxed/simple;
	bh=zvL7otWia4aCQkmTWeYiWGA5c95LwW9WEAyFjDzkpIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWtN1wzUv7hZHiih488AjJAmPffKvqUncmWYXRwMlmqUsNFtbckl+5+Ujt83k6HYqrPiBvk11PTQkSWHPqT99O/jHPF8etJQOebgz1UZ+cbzlEi5K95lbpEJ0J9rX5NnFgtQhgAr00VN4aAZs+3f0FzB6ouLf2lrgLe5OVzUXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=llpSXkpQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742ad4a71a0so276740b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303858; x=1751908658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Zcg8bD4DRfyLDHEcbStZky5pf6pw83OI9yD6JCFNPs=;
        b=llpSXkpQMT5tVUsiHNFhV+RC9vYvRPRfTXVCWGw/1GTWQxC8cgb0GrtiR5HkO1QY/7
         TEL5x1hkRm+2BQfHyIiqvMux6r9Ovi4kn9ht8uzHsymFjxw78kjhZMfqWV59vesO4pEj
         +xK9pLa2X1zSRd0IGLBNyT8kp/bgIKWx9n3hlMODpo7ktiOOet32KqZkhSQ4nLpdT4af
         FpLvZQI+2uMAQcDxGYF008sB1adXP8YawUstBu5w9oswQV+ouzQxxRQDqSyBzzKmB4Aq
         FFsXMVQcwovS2/IauYML4/ETMjTlCo3vZ2NwG8KXWB5hYa6BN3qHpSTup88WFnyNqvXd
         ia/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303858; x=1751908658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Zcg8bD4DRfyLDHEcbStZky5pf6pw83OI9yD6JCFNPs=;
        b=uGvy96EGsu5Nf/UdBw/DJrs3Ug71ckyalMPg9955rHtQNpWDWT4NC4D2HmPdb5QsBv
         01y3pmgEKokdcNHeZxRhPb913uJXsv6Svj/APIfughcHyIRS2aMg/tnmKI3Jlu6auufI
         UpPoiyXfOlUhrPG3vf/dsAmEXLM27rvhdbT9LT6zipqDDeQWDAbGx0EOb9PlCAbsvOud
         g0hWdLTLYLDNtqz0aZQtAWpOkRMVFkTRA1YCLVUB8IGsCZAPQwqQFDxWYbub6aGKvyGk
         wlk+Ihgj8r2s4gXia9Gb6pk+E308gnbWcdx2fcf6c2IozAwIgEf/gPOg5QdT4RnNox/E
         VuNQ==
X-Gm-Message-State: AOJu0YzAhG2LUW80tTLqPUXi8Pd5JPoSCLACn/H8rxQT3ypSQ6mczdAC
	8WnM3/Xehw616BBpFYSjNscmXtY5wNW30W5cL2D2kuVezLyGHV5fiMmBRJQgiBWkBMQwtuBNTmd
	OROWQsJ0=
X-Gm-Gg: ASbGncsiJWOO+/5x1Ur8Df6iriTK2he1YpsiLtxzPxjvo2Hh4IbXktrA+IImjIilwda
	3QnuHwGbKzDTFXS8hsMF5tLityqpSCuXTXfjkcePg00zHzJ1ondVeK79GfKc3hYbt1jWVhed+Cv
	Fx/RTWkvaOCTdyWx/o2lx5zlScW18fSTZ5CQh7KivYneXuQ+Fkfb+8upS29gw8GgEpcovnVtu6e
	KeZt+Zd2FgsXAH8OLYl79NiACD/z27CJgqictklZQjCMhZOI6NKDiS4DoTw775ASPfSxWbn4JCR
	XM2bqjQ4K58GdNcKupthyKJXMJQ84YmP6svPvsPE6i1gZKLcgOB0bQ90/KK9
X-Google-Smtp-Source: AGHT+IH9wE6P/rUdO585kn8Jl1FfSKTVOdsiLOWyta69H2F1dwdG4wzM27GOJ/Sc3evVJ5tU9bpaUg==
X-Received: by 2002:a05:6a00:3d4d:b0:748:f854:b76b with SMTP id d2e1a72fcca58-74b0a63bc5dmr5214668b3a.3.1751303857902;
        Mon, 30 Jun 2025 10:17:37 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:37 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v3 bpf-next 10/12] selftests/bpf: Create established sockets in socket iterator tests
Date: Mon, 30 Jun 2025 10:17:03 -0700
Message-ID: <20250630171709.113813-11-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630171709.113813-1-jordan@jrife.io>
References: <20250630171709.113813-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for bucket resume tests for established TCP sockets by creating
established sockets. Collect socket fds from connect() and accept()
sides and pass them to test cases.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 83 ++++++++++++++++++-
 1 file changed, 79 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 4c145c5415f1..2b0504cb127b 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -153,8 +153,66 @@ static void check_n_were_seen_once(int *fds, int fds_len, int n,
 	ASSERT_EQ(seen_once, n, "seen_once");
 }
 
+static int accept_from_one(int *server_fds, int server_fds_len)
+{
+	int i = 0;
+	int fd;
+
+	for (; i < server_fds_len; i++) {
+		fd = accept(server_fds[i], NULL, NULL);
+		if (fd >= 0)
+			return fd;
+		if (!ASSERT_EQ(errno, EWOULDBLOCK, "EWOULDBLOCK"))
+			return -1;
+	}
+
+	return -1;
+}
+
+static int *connect_to_server(int family, int sock_type, const char *addr,
+			      __u16 port, int nr_connects, int *server_fds,
+			      int server_fds_len)
+{
+	struct network_helper_opts opts = {
+		.timeout_ms = 0,
+	};
+	int *established_socks;
+	int i;
+
+	/* Make sure accept() doesn't block. */
+	for (i = 0; i < server_fds_len; i++)
+		if (!ASSERT_OK(fcntl(server_fds[i], F_SETFL, O_NONBLOCK),
+			       "fcntl(O_NONBLOCK)"))
+			return NULL;
+
+	established_socks = malloc(sizeof(int) * nr_connects*2);
+	if (!ASSERT_OK_PTR(established_socks, "established_socks"))
+		return NULL;
+
+	i = 0;
+
+	while (nr_connects--) {
+		established_socks[i] = connect_to_addr_str(family, sock_type,
+							   addr, port, &opts);
+		if (!ASSERT_OK_FD(established_socks[i], "connect_to_addr_str"))
+			goto error;
+		i++;
+		established_socks[i] = accept_from_one(server_fds,
+						       server_fds_len);
+		if (!ASSERT_OK_FD(established_socks[i], "accept_from_one"))
+			goto error;
+		i++;
+	}
+
+	return established_socks;
+error:
+	free_fds(established_socks, i);
+	return NULL;
+}
+
 static void remove_seen(int family, int sock_type, const char *addr, __u16 port,
-			int *socks, int socks_len, struct sock_count *counts,
+			int *socks, int socks_len, int *established_socks,
+			int established_socks_len, struct sock_count *counts,
 			int counts_len, struct bpf_link *link, int iter_fd)
 {
 	int close_idx;
@@ -185,6 +243,7 @@ static void remove_seen(int family, int sock_type, const char *addr, __u16 port,
 
 static void remove_unseen(int family, int sock_type, const char *addr,
 			  __u16 port, int *socks, int socks_len,
+			  int *established_socks, int established_socks_len,
 			  struct sock_count *counts, int counts_len,
 			  struct bpf_link *link, int iter_fd)
 {
@@ -217,6 +276,7 @@ static void remove_unseen(int family, int sock_type, const char *addr,
 
 static void remove_all(int family, int sock_type, const char *addr,
 		       __u16 port, int *socks, int socks_len,
+		       int *established_socks, int established_socks_len,
 		       struct sock_count *counts, int counts_len,
 		       struct bpf_link *link, int iter_fd)
 {
@@ -244,7 +304,8 @@ static void remove_all(int family, int sock_type, const char *addr,
 }
 
 static void add_some(int family, int sock_type, const char *addr, __u16 port,
-		     int *socks, int socks_len, struct sock_count *counts,
+		     int *socks, int socks_len, int *established_socks,
+		     int established_socks_len, struct sock_count *counts,
 		     int counts_len, struct bpf_link *link, int iter_fd)
 {
 	int *new_socks = NULL;
@@ -274,6 +335,7 @@ static void add_some(int family, int sock_type, const char *addr, __u16 port,
 
 static void force_realloc(int family, int sock_type, const char *addr,
 			  __u16 port, int *socks, int socks_len,
+			  int *established_socks, int established_socks_len,
 			  struct sock_count *counts, int counts_len,
 			  struct bpf_link *link, int iter_fd)
 {
@@ -302,10 +364,12 @@ static void force_realloc(int family, int sock_type, const char *addr,
 
 struct test_case {
 	void (*test)(int family, int sock_type, const char *addr, __u16 port,
-		     int *socks, int socks_len, struct sock_count *counts,
+		     int *socks, int socks_len, int *established_socks,
+		     int established_socks_len, struct sock_count *counts,
 		     int counts_len, struct bpf_link *link, int iter_fd);
 	const char *description;
 	int ehash_buckets;
+	int connections;
 	int init_socks;
 	int max_socks;
 	int sock_type;
@@ -416,6 +480,7 @@ static void do_resume_test(struct test_case *tc)
 	static const __u16 port = 10001;
 	struct nstoken *nstoken = NULL;
 	struct bpf_link *link = NULL;
+	int *established_fds = NULL;
 	int err, iter_fd = -1;
 	const char *addr;
 	int *fds = NULL;
@@ -444,6 +509,14 @@ static void do_resume_test(struct test_case *tc)
 				     tc->init_socks);
 	if (!ASSERT_OK_PTR(fds, "start_reuseport_server"))
 		goto done;
+	if (tc->connections) {
+		established_fds = connect_to_server(tc->family, tc->sock_type,
+						    addr, port,
+						    tc->connections, fds,
+						    tc->init_socks);
+		if (!ASSERT_OK_PTR(established_fds, "connect_to_server"))
+			goto done;
+	}
 	skel->rodata->ports[0] = 0;
 	skel->rodata->ports[1] = 0;
 	skel->rodata->sf = tc->family;
@@ -465,13 +538,15 @@ static void do_resume_test(struct test_case *tc)
 		goto done;
 
 	tc->test(tc->family, tc->sock_type, addr, port, fds, tc->init_socks,
-		 counts, tc->max_socks, link, iter_fd);
+		 established_fds, tc->connections*2, counts, tc->max_socks,
+		 link, iter_fd);
 done:
 	close_netns(nstoken);
 	SYS_NOFAIL("ip netns del " TEST_CHILD_NS);
 	SYS_NOFAIL("sysctl -w net.ipv4.tcp_child_ehash_entries=0");
 	free(counts);
 	free_fds(fds, tc->init_socks);
+	free_fds(established_fds, tc->connections*2);
 	if (iter_fd >= 0)
 		close(iter_fd);
 	bpf_link__destroy(link);
-- 
2.43.0


