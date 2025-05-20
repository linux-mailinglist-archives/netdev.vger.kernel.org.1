Return-Path: <netdev+bounces-191920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 326B0ABDDD6
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75A11BA2A0B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840C2522AB;
	Tue, 20 May 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="KVMSfZYm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DEF25228C
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752690; cv=none; b=crH67RXJ9fLj1ZcMQVlp7ABre0PlEiW1h/TZyG7UMCkDtf1WppFa3eGGRAkGxQoqJNuv1kQ8pvPhj2kfJKVQ0P4bj5JNRlSpDcIRn4+0DtPiUdXFVC+9VkqZYqYo+nzrXllJU3Fk4F/E/vppPavbQcG90WVd+TYwUiEUFb/HWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752690; c=relaxed/simple;
	bh=2tkAMlhAZoaRx0TqrjPlNgg15lg5GmPYcMCc1bfgSwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r71m4cdCUBtj/TmbDh9yU88kY6rniMiHw5v1S6Sh2Nm5ZnglK/JdqTl/4gzkonHjmklIMb1/ltMdDAnXHPFKwCKSDUSwdkNqtX3GNX728BgtU3treK4B2Onfs0k2wgLo1eEi0O3/pqvz/nCGFJxNxy6dJ3ydpEDKlrz4bfn6Nb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=KVMSfZYm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7390294782bso584351b3a.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747752688; x=1748357488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4kf3ZieW9o/TFhugnSaDvAiwleQ1fSWe8YKYPJAUM0=;
        b=KVMSfZYm76bjdzLgFpMmViUF4r1IdJDOfwmROaPyxQcoVQSbNFVGOSf3oSCEEuH81B
         VWjqJSJLe7GBUbe/WEoeDLgxxgyARy4SICfJ9x132sYybeHFTxkAVsVntN8gElItbDAr
         wOfIRY8rAIsfF+jRaNZm65iY9lPp0QozyGsGM609HoWIQ0g86eq4aaFCRfxrepewfgBu
         dP0LufT5P+bJDLjlgyVBnOlqc04eLgAO2OCt0UWmUPKcS8WlfxF4ccgCPdnLiwxuikaK
         8yGgQkOQmVycFRAIEI1WpKoxzjCMmldEkB2b0fk7bssZN4rcGK0VJ1WCo0I768iR5GqG
         Lq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752688; x=1748357488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4kf3ZieW9o/TFhugnSaDvAiwleQ1fSWe8YKYPJAUM0=;
        b=U/NF+OX4GYG+r6myWVKPQC+KkIPX5x+akeqbGz0oAT3N4SmoN/nQnamArAS23vZCjB
         cMu2MXYwPseD8ygYdKo5IVOXctno9cUAsvIpjd5MrnDa0Jvgm/GuTLSG0xVDo6SiNLKH
         g+vEZ/vml8QFJ++BkT7n3ITtZJSIqgdvUaiDu1RmCoiWfBuHdLydvsFG4gvLpraRh+Zs
         GsYi1i3zAqIQhMPoLepAsPIK18FMqJo8DegWrehum+kwGz/CFQA4rP9csqzvOQ5k4hS/
         CiymY5YayEyxn849bDGMonhIJ0KXHmhPKooUuPKiYA4PEodgk9JmE80BOAS4OhhiPIed
         5hxw==
X-Gm-Message-State: AOJu0YydTchnYZjC6LdxLqo0YPZ96c1/2ZTp5Nj8+B4Fk2P80NJOHfME
	BQOPIJUiJ1H3PE/O4f/q7I2PuI3gUbLh3HxtdtSw81TdWVcp/8CzgeGFhxhghlC2nazaasCTBjL
	lmg/FTAo=
X-Gm-Gg: ASbGncsqXECzacrBWcA7VTocAqgCLhK1ks3AbiqJDPC1KJJjfaxaHxbdWrB9FJjX1ZH
	qk0wllp/lXhpKRgryY51cBMFLapth134p/eWL0izWg1WJglWvbxdbZNaPVy/HSWb+bpam/Xwf/d
	WYeng5P9mSriTYQCby/BmIa1R8lZRbmS7cbXaYyJbh0XcYyZl3zhWCDr2c8bMHitBc4F/ql5hXd
	w1D2uv+HOQlXxxQ+lGy4qdkWVMzzGSoeVSe4pBN9qZFhiFSZMFOGI1FFR1SVInYp8tqV1xnLWp0
	Px6tv38jZn/Eo5qaX6PlLRm5HuDm7n9Hqn8TR4YS
X-Google-Smtp-Source: AGHT+IEXW7+AsDPqB0o2RuLGL90KhocP3vgD1k2sKWq0uqeTFftW6eP1ChVSOZgb9VkuPebXDgaC9A==
X-Received: by 2002:a05:6a00:aca:b0:742:938a:3eca with SMTP id d2e1a72fcca58-742a98f943dmr9816941b3a.3.1747752687937;
        Tue, 20 May 2025 07:51:27 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:276d:b09e:9f33:af8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bb3sm8242993b3a.100.2025.05.20.07.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:51:27 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v1 bpf-next 09/10] selftests/bpf: Create established sockets in socket iterator tests
Date: Tue, 20 May 2025 07:50:56 -0700
Message-ID: <20250520145059.1773738-10-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520145059.1773738-1-jordan@jrife.io>
References: <20250520145059.1773738-1-jordan@jrife.io>
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
index 847e4b87ab92..f14adda52f53 100644
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
@@ -464,13 +537,15 @@ static void do_resume_test(struct test_case *tc)
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


