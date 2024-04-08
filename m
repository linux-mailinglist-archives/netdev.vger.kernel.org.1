Return-Path: <netdev+bounces-85866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9589CA0A
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 18:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4399928A210
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 16:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5C81428F7;
	Mon,  8 Apr 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KtwMKe4M"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE741428F1
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594883; cv=none; b=bWOVH4vEscwTlCbD9DdCJEKHYnfetJC37bEdBgz4qmhELwF+nMZ1pUXOEPURMpF2Yp0vOdjk4csIPauZY9oY9B5/IjuUtrcnUg+YMHFsqong9c0CcH+H07G1Cvz8VwZMT/exAgSIKieqNaL8sHuDLHx9qCZ+lwHzZo9f59YMUFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594883; c=relaxed/simple;
	bh=QVbaPDGsqOgvW1cyuBq70eIFSby+cyWLYp4KOuq/AMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LH904sJznvxxksIycqKb52khvgDnoOjNAP5s2b77Pn5Yv2bic/y2nNtLDhFDXFTVXPZ1joCjYlZOrdn4D+ZB6I479h7XFKe5tnX5jgmB0G8UNb6kNnEB+2nkIacNzpbl/Y4VTZqcDyzl0M2Moz3K9KZ3oCE+TR+M7U/WM4eQkE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KtwMKe4M; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1rtrdI-00BVA9-De; Mon, 08 Apr 2024 18:14:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=HwySkYg13T0tSBGx7Bl5y+gdkt4e93qnnix64ekngls=; b=KtwMKe4Mg+4/lA+cXjmrpqZQcn
	4aUiIdhUntJ4Fjui6R6cFKKbqkxL3D1IZ57xzj5L1pSEsTrYboYoB28kfplONLJAZnqtaTYUluCzC
	/Cy6vKh33A5ZA0YNBJDgJs8xHQv8Ukx09GdRP7tMQBplZwOVrW6/BOE+e3+FbJvIy8hsnuAPw1EVw
	2amx+6phMr7cEtNsJXyyAD4Iyx4H/tbCo09pbXzojCbZWRHGuWiMWS49mGXJ2xHranYykft4JtBzZ
	rfNle0fspZ3P57LOyg/Xv5azh21bwwk5pv3t1yXH4n8A8uHfcrLRCOGhTWPZIDGbkV4h7koPoPQR0
	kHOPT9lQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1rtrdI-000574-0R; Mon, 08 Apr 2024 18:14:08 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1rtrd3-00Gq8Q-Sa; Mon, 08 Apr 2024 18:13:53 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net 2/2] af_unix: Add GC race reproducer + slow down unix_stream_connect()
Date: Mon,  8 Apr 2024 17:58:46 +0200
Message-ID: <20240408161336.612064-3-mhal@rbox.co>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408161336.612064-1-mhal@rbox.co>
References: <20240408161336.612064-1-mhal@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attempt to crash kernel racing unix socket garbage collector.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/unix/af_unix.c                            |   2 +
 tools/testing/selftests/net/af_unix/Makefile  |   2 +-
 .../selftests/net/af_unix/gc_vs_connect.c     | 158 ++++++++++++++++++
 3 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/af_unix/gc_vs_connect.c

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5b41e2321209..8e56a094dc80 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1636,6 +1636,8 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 	unix_state_unlock(sk);
 
+	mdelay(1);
+
 	/* take ten and send info to listening sock */
 	spin_lock(&other->sk_receive_queue.lock);
 	__skb_queue_tail(&other->sk_receive_queue, skb);
diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 221c387a7d7f..3b12a9290e06 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -1,4 +1,4 @@
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := diag_uid test_unix_oob unix_connect scm_pidfd
+TEST_GEN_PROGS := diag_uid test_unix_oob unix_connect scm_pidfd gc_vs_connect
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/af_unix/gc_vs_connect.c b/tools/testing/selftests/net/af_unix/gc_vs_connect.c
new file mode 100644
index 000000000000..8b724f1616dd
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/gc_vs_connect.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <assert.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <pthread.h>
+#include <sys/un.h>
+#include <sys/socket.h>
+
+#define SOCK_TYPE	SOCK_STREAM	/* or SOCK_SEQPACKET */
+
+union {
+	char buf[CMSG_SPACE(sizeof(int))];
+	struct cmsghdr align;
+} cbuf;
+
+struct iovec io = {
+	.iov_base = (char[1]) {0},
+	.iov_len = 1
+};
+
+struct msghdr msg = {
+	.msg_iov = &io,
+	.msg_iovlen = 1,
+	.msg_control = cbuf.buf,
+	.msg_controllen = sizeof(cbuf.buf)
+};
+
+pthread_barrier_t barr;
+struct sockaddr_un saddr;
+int salen, client;
+
+static void barrier(void)
+{
+	int ret = pthread_barrier_wait(&barr);
+
+	assert(!ret || ret == PTHREAD_BARRIER_SERIAL_THREAD);
+}
+
+static int socket_unix(void)
+{
+	int sock = socket(AF_UNIX, SOCK_TYPE, 0);
+
+	assert(sock != -1);
+	return sock;
+}
+
+static int recv_fd(int socket)
+{
+	struct cmsghdr *cmsg;
+	int ret, fd;
+
+	ret = recvmsg(socket, &msg, 0);
+	assert(ret == 1 && !(msg.msg_flags & MSG_CTRUNC));
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	assert(cmsg);
+	memcpy(&fd, CMSG_DATA(cmsg), sizeof(fd));
+	assert(fd >= 0);
+
+	return fd;
+}
+
+static void send_fd(int socket, int fd)
+{
+	struct cmsghdr *cmsg;
+	int ret;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	assert(cmsg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(fd));
+
+	memcpy(CMSG_DATA(cmsg), &fd, sizeof(fd));
+
+	do {
+		ret = sendmsg(socket, &msg, 0);
+		assert(ret == 1 || (ret == -1 && errno == ENOTCONN));
+	} while (ret != 1);
+}
+
+static void *racer_connect(void *arg)
+{
+	for (;;) {
+		int ret;
+
+		barrier();
+		ret = connect(client, (struct sockaddr *)&saddr, salen);
+		assert(!ret);
+		barrier();
+	}
+
+	return NULL;
+}
+
+static void *racer_gc(void *arg)
+{
+	for (;;)
+		close(socket_unix()); /* trigger GC */
+
+	return NULL;
+}
+
+int main(void)
+{
+	pthread_t thread_conn, thread_gc;
+	int ret, pair[2];
+
+	printf("running\n");
+
+	ret = pthread_barrier_init(&barr, NULL, 2);
+	assert(!ret);
+
+	ret = pthread_create(&thread_conn, NULL, racer_connect, NULL);
+	assert(!ret);
+
+	ret = pthread_create(&thread_gc, NULL, racer_gc, NULL);
+	assert(!ret);
+
+	ret = socketpair(AF_UNIX, SOCK_TYPE, 0, pair);
+	assert(!ret);
+
+	saddr.sun_family = AF_UNIX;
+	salen = sizeof(saddr.sun_family) +
+		sprintf(saddr.sun_path, "%c/unix-gc-%d", '\0', getpid());
+
+	for (;;) {
+		int server, victim;
+
+		server = socket_unix();
+		ret = bind(server, (struct sockaddr *)&saddr, salen);
+		assert(!ret);
+		ret = listen(server, -1);
+		assert(!ret);
+
+		send_fd(pair[0], server);
+		close(server);
+
+		client = socket_unix();
+		victim = socket_unix();
+
+		barrier();
+		send_fd(client, victim);
+		close(victim);
+		barrier();
+
+		server = recv_fd(pair[1]);
+		close(client);
+		close(server);
+	}
+
+	return 0;
+}
-- 
2.44.0


