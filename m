Return-Path: <netdev+bounces-245227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C39BBCC9413
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B772630F6C22
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 18:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846A233FE2F;
	Wed, 17 Dec 2025 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdGlgC/4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028813DBA0
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995164; cv=none; b=PMwJIixEg01tKCuXk6PX+t/0hoUYMFH2Ni/hTJxyDN+SPBL5fcmtjKnvk1FzHKzTpjWQvLCKGnN9vRDSE8QDRUA4Fbj8dIuq8lduRFJQM4Q/Hx+2DrRLpalxfHxH5+fj+Uj5vAVN23klSUOzPDwZBmWq6Z/OYBdJtWg8Ys6Xcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995164; c=relaxed/simple;
	bh=Btn/e79eN7ovQAPmHnhb0d8yhq10fIOSyLkws8LR2uE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gifw/DZp2tVEdqc/Da4RbT1nauRF8V2oke3Mp+hNk7+FG3FcqNJ+nr3OheNoskmCLPv8Scps8pzZpoxV3ZfE1nA/MuYinnJDOqHb9LAkNBAN3oDHSuHgg10UQPfSgVyNSQf3950kG43Du8WxiV96uEPMYSMVvyuBTfVLbueLuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdGlgC/4; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-596ba07504dso6144584e87.1
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 10:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765995155; x=1766599955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWDVTcbeN5bBA7b/fB7A8gJyMmAFiIZBGr/pLyGnvWw=;
        b=mdGlgC/4bGskD8vhG1bF6wfwggtrbIVUqUKc0jeWmrX0OXpDzcOG5esv177Upxk4eb
         Z7tNO16HKVWRRsisHP2qDSCkbFmMn0mdNpc0I0QDOjyaZlH8Jo2nf+7Rru4y5JiQ3IE2
         lR4zBE3SXnQm/ifLg2X2G9XF2o4Q8lS+Fj9n900r9pvFaPue3Ldo0jXPTUwCrNbvycPa
         18/LGl7CvoelkAoioM+KuQHWPSHiwHV7zWvIJcWn8YmTnnq7+y5NRKZ61+NB2srUm4Ne
         ZDKl/D/Vzn+38JMDsbHSyOUHId3vy0yDp0jwFH8vkY+bo3oQv7qQefwGOlOrY+cMo9QL
         +CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995155; x=1766599955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YWDVTcbeN5bBA7b/fB7A8gJyMmAFiIZBGr/pLyGnvWw=;
        b=oaW9AdGpacUa4c8DxAJqVmMo78fMv8eIjvWcZusdxWf2a8Ea3G1aJumYvSE9mJqrKb
         Wf/toSMHTyex6xiIm40jqZX3fVfCcbkatkNHp0pnoGCqy4xPu4Ao3uvCP1NBLVt3uiyZ
         7XmOBWAyiUyU/qiXHBsWtHhwpbOV87V6KQcx79N6sUN4Iq0zi/lIFYVv8GRItSzbx7e1
         1PthmU4AawXVFhSjt643+LVKgHxrDZW6ycwSavXFSclNQtrVjWFeB1WvnkMjWZ3KA1/4
         RzkwczMyUHiEiGBSWBOqbzxUA2U4fmnyNOXSHNlF8mEm8STfJVA6gYoqYxfwz9w85jqj
         N+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYRS9iuz3KmM0uziNJmzqhsm7uGKM9iO3e58vY/1/t2N4icAyDU/wyVCCxbvZCT/9sPsYkNXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+t8iE/sg67twLHZEOZs8l4ybcEbx8eYAzbiPkmFPfETeIsZRl
	0WVPQaK6664YggThnRqmne8A3efCNo9gzAOZDfcQvmNEdxsXrcsC/toI
X-Gm-Gg: AY/fxX4stIUb+Z/96P2MBM0STuPor87pEGEr2WOISmmlJp8lh5exPdQNQ7lBCwz/VOZ
	+IJfrWjJOip5sFZu2iLuWygmuLMmPu64Ybf7TITVjR15eoMmxX5kTkHwIpcyW35hsfQESkt9NCb
	UgUiYEQf6bl/2DRm6lRAyuMoKSwSaGK7sOnX2F83/ZG7vbHDf2JRpQElAFI+SzAlOF425xtKacy
	UO1+Kr9kBK/UC65462WsnWfRqysUe5cDGcwn+w4stCZ5GyjNnMqqTveX+4gW8CIZl4vtCAnYppk
	C8TnhG7XAJrLSDpaB3Vz6LG6mwigpfma31zJ0brxLIkc1WGB3XNwZHWfyT0/WkkXtM7I+Ut6MWA
	ZrlRQHBKQP9LfkR7Ctbs3NOPghg5AZbzeu0WtGsudFCMF/ZyrvCkoMVf2C0+VudR6UvuAONT0GC
	YFlGc10LqTaP8=
X-Google-Smtp-Source: AGHT+IGKE6+oXrVS7pwbxHPAdksD1QodGnRBGOe+h7uD8J+gXsamVw7BpLRSwSnFwpf8bb0Jng+hIA==
X-Received: by 2002:a05:6512:3d07:b0:59a:107a:45a5 with SMTP id 2adb3069b0e04-59a107a46cdmr754855e87.23.1765995154644;
        Wed, 17 Dec 2025 10:12:34 -0800 (PST)
Received: from Ubuntu-2204-jammy-amd64-base.. ([2a01:4f9:6a:4e9f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5990da790efsm2591419e87.102.2025.12.17.10.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 10:12:34 -0800 (PST)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH net v4 4/4] vsock/test: add stream TX credit bounds test
Date: Wed, 17 Dec 2025 19:12:06 +0100
Message-Id: <20251217181206.3681159-5-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217181206.3681159-1-mlbnkm1@gmail.com>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for the TX credit bounds fix. The test verifies
that a sender with a small local buffer size cannot queue excessive
data even when the peer advertises a large receive buffer.

The client:
  - Sets a small buffer size (64 KiB)
  - Connects to server (which advertises 2 MiB buffer)
  - Sends in non-blocking mode until EAGAIN
  - Verifies total queued data is bounded

This guards against the original vulnerability where a remote peer
could cause unbounded kernel memory allocation by advertising a large
buffer and reading slowly.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 tools/testing/vsock/vsock_test.c | 103 +++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 0e8e173dfbdc..9f4598ee45f9 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -347,6 +347,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 }
 
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
+#define SMALL_SOCK_BUF_SIZE (64 * 1024ULL)
 #define MAX_MSG_PAGES 4
 
 static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
@@ -2203,6 +2204,103 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void test_stream_tx_credit_bounds_client(const struct test_opts *opts)
+{
+	unsigned long long sock_buf_size;
+	char buf[4096];
+	size_t total = 0;
+	ssize_t sent;
+	int fd;
+	int flags;
+
+	memset(buf, 'A', sizeof(buf));
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	sock_buf_size = SMALL_SOCK_BUF_SIZE;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
+	flags = fcntl(fd, F_GETFL);
+	if (flags < 0) {
+		perror("fcntl(F_GETFL)");
+		exit(EXIT_FAILURE);
+	}
+
+	if (fcntl(fd, F_SETFL, flags | O_NONBLOCK) < 0) {
+		perror("fcntl(F_SETFL)");
+		exit(EXIT_FAILURE);
+	}
+
+	control_expectln("SRVREADY");
+
+	for (;;) {
+		sent = send(fd, buf, sizeof(buf), 0);
+		if (sent > 0) {
+			total += sent;
+			continue;
+		}
+		if (sent < 0 && (errno == EAGAIN || errno == EWOULDBLOCK))
+			break;
+
+		perror("send");
+		exit(EXIT_FAILURE);
+	}
+
+	/*
+	 * With TX credit bounded by local buffer size, sending should
+	 * stall quickly. Allow some overhead but fail if we queued an
+	 * unreasonable amount.
+	 */
+	if (total > (size_t)(SMALL_SOCK_BUF_SIZE * 4)) {
+		fprintf(stderr,
+			"TX credit too large: queued %zu bytes (expected <= %llu)\n",
+			total, (unsigned long long)(SMALL_SOCK_BUF_SIZE * 4));
+		exit(EXIT_FAILURE);
+	}
+
+	control_writeln("CLIDONE");
+	close(fd);
+}
+
+static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
+{
+	unsigned long long sock_buf_size;
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Server advertises large buffer; client should still be bounded */
+	sock_buf_size = SOCK_BUF_SIZE;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			     sock_buf_size,
+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
+	control_writeln("SRVREADY");
+	control_expectln("CLIDONE");
+
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -2382,6 +2480,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_seqpacket_unread_bytes_client,
 		.run_server = test_seqpacket_unread_bytes_server,
 	},
+	{
+		.name = "SOCK_STREAM TX credit bounds",
+		.run_client = test_stream_tx_credit_bounds_client,
+		.run_server = test_stream_tx_credit_bounds_server,
+	},
 	{},
 };
 
-- 
2.34.1


