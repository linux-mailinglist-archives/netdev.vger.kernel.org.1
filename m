Return-Path: <netdev+bounces-205583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F52AFF533
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC41B1C4164A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C91254854;
	Wed,  9 Jul 2025 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="3KEPYDmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3203253925
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 23:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102232; cv=none; b=qt2RNAPrvbQ5CRvbvCCIf8H2L09WHnZzArOXAyQujXWbL54v7C7LeCsCs/umEaZ2PifQD3VnU7BEvxJ5M4FAzUaYoCOLCIiqyhqBgc6g8bW9s9eaS4FWESsoth9eC7UxsdhajYrbbEU2CZopKihhMt2zUZD2OMRtCdKTWYQR9bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102232; c=relaxed/simple;
	bh=Qfz5W+kBzk0ALQvaktO0O8WJb1rvJHyV51fTo3LPPXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3YcnEJPSy9+D/0B4Hh4j69ufqxhuiWZ5RLLNwrTMfg8wqtG6qHBZcU73Mk6VDzuLbqv/xTLk8Drkm+dpmFkelSk2S04tftSPMfKEwHGVkPvH87g7xK5aLcZS9seI8aNg2V+8Yc4toueJP+Jg7rVy4kxq8VA/LmDGGWSAH2AgeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=3KEPYDmZ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b31d4886c50so85943a12.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102230; x=1752707030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05ov+T5n9BEKTxmfOYn08NF2ipokkSRnsb3r66QuKro=;
        b=3KEPYDmZTxpAktrwjF8K+4XdOYdKBZCO7fgu8UpvwDBt90oC/ALDM44elwICS7CDyr
         kkS0PdJGckUKLX5fQMNw+8Fq3pdm7tbkU5r+qLCLm8TxaztY1m6C6Fg6qKBtWoEs+j+s
         1jZtLJz1qtIOk7bdG5KpgbzgFusc3Wh+NcgwC6W4pbHeo2I/tPDw90OIZbyca9hLLK3i
         BxbDXOpV9OHWOzotCltK8/yTLwRupAyeJFH7Xr7/Pea6dMFslrYoiwmu8/d8t7Bn3G+c
         18FXYYbGNAIc5U6uxSBky84riEQiLNMJXf3ili6JpWK1JXbzgnGJH5uV/FlMLuTLWRfi
         oZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102230; x=1752707030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05ov+T5n9BEKTxmfOYn08NF2ipokkSRnsb3r66QuKro=;
        b=rtvtqrwJ54srO87GQvnylkCBelgqEh/5RPKhb4HPjhLBMMCj9EHALRl5SX5fZZtViZ
         PRTnYhDLCckSVBWi+jdlxgaCBZhKJ0RLOdfgAFoEgaEfP3GE+607geY/Jp9fn9fxA10b
         ndqXyqp17jqtrd1g/WFdt5ibwXKINOwof2UUbViS1LUCAiW0Xfq/Wrj8r0TTsH0w16e0
         sCMft/v/g2pf0H9f2kWZF0aUZ500wHlaJgzCZXr9DZNzIQ10UEHApI08ePjDVEfWJkic
         kkIdGMAxRy2U3UfOmHUAz9ld4QrcJGThtGO3cp99WBI07q06gI8YPXL/MwbqkxXmIoQI
         s9Dw==
X-Gm-Message-State: AOJu0YzmZQ7r8asPVLIX1OeIMkMRG60S+16xlacc48vi0xzOLD5WTCpY
	OiM3edbqUHzOnSah17f7alEn55OxIO42dcg+cQq5USuKcBXCLRM+OtEnLhG9ekw7CKqftV/b1uI
	K3V6v
X-Gm-Gg: ASbGncsSigqwUuhpy30FFTXEWQK7t0L6YVZuWnaHCsTdWB1BnlOBY4e30xjjrJgm//l
	SQwJDcdBcn59iF9tmfS0oKz7u4bdk8FSlsJuipRgFkvvAcYmai9xvkWxSj8+HwHnKr3sI7DBdQG
	ZRGaiLVIzVAVc9o1XLYPWXgxbkZZcBUtKh4Hd6LqTgLVS3e5NaQ092Z01a6vM739YDGkt3QKK9Y
	KWr9jR7sEJ+RA9yBsOKvv9PLtCRx8+eWCU6FAwhplk8F+NB1lwFjYMM2peVenaDxVFktELpBjzz
	0N/yM6XkMuYNJNjoZasziGxIeUPjY0pN4JBx9VuJ4YeTNabSTdQ=
X-Google-Smtp-Source: AGHT+IH0jSVoxgP4BnDJOtMH4COsezREsKPLsXCyGGf9EhAp6rgxT4hP6WCEv2x3Tqy7RQUdwzPIfg==
X-Received: by 2002:a17:902:e5cd:b0:234:ba37:87a3 with SMTP id d9443c01a7336-23ddb19b4e4mr26912815ad.3.1752102229919;
        Wed, 09 Jul 2025 16:03:49 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:49 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 10/12] selftests/bpf: Create established sockets in socket iterator tests
Date: Wed,  9 Jul 2025 16:03:30 -0700
Message-ID: <20250709230333.926222-11-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709230333.926222-1-jordan@jrife.io>
References: <20250709230333.926222-1-jordan@jrife.io>
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
index 18da2d901af7..d21b7a918700 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -153,8 +153,66 @@ static void check_n_were_seen_once(int *fds, int fds_len, int n,
 	ASSERT_EQ(seen_once, n, "seen_once");
 }
 
+static int accept_from_one(int *server_fds, int server_fds_len)
+{
+	int fd;
+	int i;
+
+	for (i = 0; i < server_fds_len; i++) {
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


