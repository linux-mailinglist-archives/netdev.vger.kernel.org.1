Return-Path: <netdev+bounces-184291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A753FA94453
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 17:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F75189EBCC
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22211DFE0A;
	Sat, 19 Apr 2025 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="gH1UmjI0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079171DF246
	for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745078296; cv=none; b=MzQg4N0WFYOwD6F9Ul4hgouM/aVDYOSorY0VEdOkN3TkXWETy4QkkdYYGoHrNkj0Io8VIAB1VWB4xQ/4wI4iJ2ibW6/1xDCRpxOEvgUtV7zTBv7Hoo6YmUA57RZEVYgsg+KbFUP7mVroejkasYClIAZIiuutA1xtQLIyP1+NF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745078296; c=relaxed/simple;
	bh=8D3K8jEJFy2ljx8/dNSQp4nr5+k3ju7eECDWQX6lssg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T03p9xp0yQWmcTMFvnK1dqf17Eqbe714jxc2XT5th8Shvnd5OF8j9lvQzpnUa3MQnt1o2y/yEU2+RHv9iQtiCCuO4IA02YfuNC/IM1jSqcWB9v94UWOBc4SVNouOao7AvKRdJ19eTU74RUxaIpK6qpFjCtXLYQs++5V7Z80e54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=gH1UmjI0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af90510be2eso236719a12.3
        for <netdev@vger.kernel.org>; Sat, 19 Apr 2025 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745078293; x=1745683093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4N8moraxYLNX0qhNglQq0LQLGcDgagzwGmqz/6Y4IFY=;
        b=gH1UmjI0EHDLFeK+GirBxHFTbur0MeU2LRL/3sm6IiojmEwwf1UDwbv8QVcnvIyoP3
         mkE6AScOevvfnnmqWpgusvoSdtMbGr7vW4CaEz9YljR+6vRTfaTmdGntsMRpmqZn5yeT
         6zEUd9eLuhibLmXPJqf99S61pUbG8I6pkES/ae8Y6EcMWnXm0dx7poHg6wxfsSm6cHht
         C+foV+1vRXkSYuqBZLxJVBq36f66eGcnNgfnaYc/8RjFMGteDHw9QuJETKcSqxc2Hssq
         sN1t12MXN3mQMDz+QHees9fASD0OQTtLcB3LwfA8SbAMI/VsBYeGqI9sPWez3Xk+qio7
         NqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745078293; x=1745683093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4N8moraxYLNX0qhNglQq0LQLGcDgagzwGmqz/6Y4IFY=;
        b=YDL8S0BK7O2/EMhwoQ4tLuZdlmLR+5m9fkZmPWrpctv5zwb5Jd+HGT4XD73qEQzdjP
         +1WvMXK34D4HtRO2WrASZt1aa3fVtySSCDwHZczNP0QD8G3A23NzOFjBSFOcTJA6XfU1
         GdTt1zhr6z8CMGt60EHRLAymBujfVSklzmCR9WOddyr9SN1UWTtKaVbRIxWZYuz/R9wY
         0jC+kigz7BqBIArsYIYvgKqwexb0FMpJitnLF3ufJwgFbIgDz1pLRjHUg2qNsqXSs0S+
         9pL5n4zNIOEL9iS4HL2jA6/V+nTByENexrv6kfhADntBlN9r31MZWSisoLegilmXz8Bl
         w9rg==
X-Gm-Message-State: AOJu0YzAB/hB9BIDWIDBNMi+Z2QxA/if/CjHbbORvn5Rl6F//UJp54Dl
	PqZDPd3RLYnu3a5WIlecUu2BoVgmYd6rodE/u4k2wGSJZcAiMVsizCtehgqvw/ZMv05RDaoqHsk
	5dLE=
X-Gm-Gg: ASbGncujDAubCZwCKETspQX3QDYun0uBIfB6n1KpLun0KTlNIEBclBkw3Yfo5o53GeD
	FRJH2uC0S5m6pkr7OhsO52b/flptTQ2LEXmUQLz8eoqZGHlzMlJrttjptCtXvrAsV6pQDL1gmtf
	laI3LliaaaAI7vlY6FLjmRkP93m/9iRditl5Sk/Km+gR8moD/tEfmNpqIr5AQR0ZGBPALjZctDe
	VfOYKKSoXyktwYmVlvYXEtZJ1+2NVOr+bXBQSpH5dXhmgurgr0AHMMjN+Sll2C2ECl/uw6XHD0i
	YKKEnPu4NB20zq/6dJu7h66d5scW3DLrhsoBS8Vx
X-Google-Smtp-Source: AGHT+IGwr1IoVc4T9jwUrTdcFgxHzIfi4vUqD/KzsCN1sRmqeSTCogZygbF0wjg5Ag7ap8jFKeKlnw==
X-Received: by 2002:a05:6a00:3984:b0:730:8c9d:5842 with SMTP id d2e1a72fcca58-73dc1612e3dmr2724601b3a.5.1745078292998;
        Sat, 19 Apr 2025 08:58:12 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:1195:fa96:2874:6b2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8be876sm3464157b3a.36.2025.04.19.08.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 08:58:12 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v4 bpf-next 5/6] selftests/bpf: Return socket cookies from sock_iter_batch progs
Date: Sat, 19 Apr 2025 08:58:02 -0700
Message-ID: <20250419155804.2337261-6-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250419155804.2337261-1-jordan@jrife.io>
References: <20250419155804.2337261-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the iter_udp_soreuse and iter_tcp_soreuse programs to write the
cookie of the current socket, so that we can track the identity of the
sockets that the iterator has seen so far. Update the existing do_test
function to account for this change to the iterator program output. At
the same time, teach both programs to work with AF_INET as well.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 33 +++++++++++--------
 .../selftests/bpf/progs/bpf_tracing_net.h     |  1 +
 .../selftests/bpf/progs/sock_iter_batch.c     | 24 +++++++++++---
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index d56e18b25528..74dbe91806a0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -9,12 +9,18 @@
 
 static const int nr_soreuse = 4;
 
+struct iter_out {
+	int idx;
+	__u64 cookie;
+} __packed;
+
 static void do_test(int sock_type, bool onebyone)
 {
 	int err, i, nread, to_read, total_read, iter_fd = -1;
-	int first_idx, second_idx, indices[nr_soreuse];
+	struct iter_out outputs[nr_soreuse];
 	struct bpf_link *link = NULL;
 	struct sock_iter_batch *skel;
+	int first_idx, second_idx;
 	int *fds[2] = {};
 
 	skel = sock_iter_batch__open();
@@ -34,6 +40,7 @@ static void do_test(int sock_type, bool onebyone)
 			goto done;
 		skel->rodata->ports[i] = ntohs(local_port);
 	}
+	skel->rodata->sf = AF_INET6;
 
 	err = sock_iter_batch__load(skel);
 	if (!ASSERT_OK(err, "sock_iter_batch__load"))
@@ -55,38 +62,38 @@ static void do_test(int sock_type, bool onebyone)
 	 * from a bucket and leave one socket out from
 	 * that bucket on purpose.
 	 */
-	to_read = (nr_soreuse - 1) * sizeof(*indices);
+	to_read = (nr_soreuse - 1) * sizeof(*outputs);
 	total_read = 0;
 	first_idx = -1;
 	do {
-		nread = read(iter_fd, indices, onebyone ? sizeof(*indices) : to_read);
-		if (nread <= 0 || nread % sizeof(*indices))
+		nread = read(iter_fd, outputs, onebyone ? sizeof(*outputs) : to_read);
+		if (nread <= 0 || nread % sizeof(*outputs))
 			break;
 		total_read += nread;
 
 		if (first_idx == -1)
-			first_idx = indices[0];
-		for (i = 0; i < nread / sizeof(*indices); i++)
-			ASSERT_EQ(indices[i], first_idx, "first_idx");
+			first_idx = outputs[0].idx;
+		for (i = 0; i < nread / sizeof(*outputs); i++)
+			ASSERT_EQ(outputs[i].idx, first_idx, "first_idx");
 	} while (total_read < to_read);
-	ASSERT_EQ(nread, onebyone ? sizeof(*indices) : to_read, "nread");
+	ASSERT_EQ(nread, onebyone ? sizeof(*outputs) : to_read, "nread");
 	ASSERT_EQ(total_read, to_read, "total_read");
 
 	free_fds(fds[first_idx], nr_soreuse);
 	fds[first_idx] = NULL;
 
 	/* Read the "whole" second bucket */
-	to_read = nr_soreuse * sizeof(*indices);
+	to_read = nr_soreuse * sizeof(*outputs);
 	total_read = 0;
 	second_idx = !first_idx;
 	do {
-		nread = read(iter_fd, indices, onebyone ? sizeof(*indices) : to_read);
-		if (nread <= 0 || nread % sizeof(*indices))
+		nread = read(iter_fd, outputs, onebyone ? sizeof(*outputs) : to_read);
+		if (nread <= 0 || nread % sizeof(*outputs))
 			break;
 		total_read += nread;
 
-		for (i = 0; i < nread / sizeof(*indices); i++)
-			ASSERT_EQ(indices[i], second_idx, "second_idx");
+		for (i = 0; i < nread / sizeof(*outputs); i++)
+			ASSERT_EQ(outputs[i].idx, second_idx, "second_idx");
 	} while (total_read <= to_read);
 	ASSERT_EQ(nread, 0, "nread");
 	/* Both so_reuseport ports should be in different buckets, so
diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index 659694162739..17db400f0e0d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -128,6 +128,7 @@
 #define sk_refcnt		__sk_common.skc_refcnt
 #define sk_state		__sk_common.skc_state
 #define sk_net			__sk_common.skc_net
+#define sk_rcv_saddr		__sk_common.skc_rcv_saddr
 #define sk_v6_daddr		__sk_common.skc_v6_daddr
 #define sk_v6_rcv_saddr		__sk_common.skc_v6_rcv_saddr
 #define sk_flags		__sk_common.skc_flags
diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index 96531b0d9d55..8f483337e103 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -17,6 +17,12 @@ static bool ipv6_addr_loopback(const struct in6_addr *a)
 		a->s6_addr32[2] | (a->s6_addr32[3] ^ bpf_htonl(1))) == 0;
 }
 
+static bool ipv4_addr_loopback(__be32 a)
+{
+	return a == bpf_ntohl(0x7f000001);
+}
+
+volatile const unsigned int sf;
 volatile const __u16 ports[2];
 unsigned int bucket[2];
 
@@ -26,16 +32,20 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 	struct sock *sk = (struct sock *)ctx->sk_common;
 	struct inet_hashinfo *hinfo;
 	unsigned int hash;
+	__u64 sock_cookie;
 	struct net *net;
 	int idx;
 
 	if (!sk)
 		return 0;
 
+	sock_cookie = bpf_get_socket_cookie(sk);
 	sk = bpf_core_cast(sk, struct sock);
-	if (sk->sk_family != AF_INET6 ||
+	if (sk->sk_family != sf ||
 	    sk->sk_state != TCP_LISTEN ||
-	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr))
+	    sk->sk_family == AF_INET6 ?
+	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr) :
+	    !ipv4_addr_loopback(sk->sk_rcv_saddr))
 		return 0;
 
 	if (sk->sk_num == ports[0])
@@ -52,6 +62,7 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 	hinfo = net->ipv4.tcp_death_row.hashinfo;
 	bucket[idx] = hash & hinfo->lhash2_mask;
 	bpf_seq_write(ctx->meta->seq, &idx, sizeof(idx));
+	bpf_seq_write(ctx->meta->seq, &sock_cookie, sizeof(sock_cookie));
 
 	return 0;
 }
@@ -63,14 +74,18 @@ int iter_udp_soreuse(struct bpf_iter__udp *ctx)
 {
 	struct sock *sk = (struct sock *)ctx->udp_sk;
 	struct udp_table *udptable;
+	__u64 sock_cookie;
 	int idx;
 
 	if (!sk)
 		return 0;
 
+	sock_cookie = bpf_get_socket_cookie(sk);
 	sk = bpf_core_cast(sk, struct sock);
-	if (sk->sk_family != AF_INET6 ||
-	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr))
+	if (sk->sk_family != sf ||
+	    sk->sk_family == AF_INET6 ?
+	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr) :
+	    !ipv4_addr_loopback(sk->sk_rcv_saddr))
 		return 0;
 
 	if (sk->sk_num == ports[0])
@@ -84,6 +99,7 @@ int iter_udp_soreuse(struct bpf_iter__udp *ctx)
 	udptable = sk->sk_net.net->ipv4.udp_table;
 	bucket[idx] = udp_sk(sk)->udp_portaddr_hash & udptable->mask;
 	bpf_seq_write(ctx->meta->seq, &idx, sizeof(idx));
+	bpf_seq_write(ctx->meta->seq, &sock_cookie, sizeof(sock_cookie));
 
 	return 0;
 }
-- 
2.43.0


