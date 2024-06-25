Return-Path: <netdev+bounces-106308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA6C915BBA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4111D1C213F1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01E417C6C;
	Tue, 25 Jun 2024 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Sp6FbdEj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3FF101D5
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279451; cv=none; b=ZN99lxxHGPNgeGhxgBDH6z/LL3q2fAMaezLAk6QhJfDKoLFqDAGCdp5YMUI3LXdIcZH1YtKBSj/xvzSX+U9fCVdryLo4/H+u2vzA2rhi8fm0y2nNXx3MmV8hG8VlBHuIpohElxBP1wtLmPlR+TVQDNLc4X1w5eV/xygoDM55mrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279451; c=relaxed/simple;
	bh=KdBXCceKVRLGT3TDfr6v/Y1ViAnOA9aQdXkRcguKNys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzLJuHRwcACa41SZDAVzlCQzSIxel+v0uxqrNNolAaWheE7/VeBdIehj+Yy4w2nG7ZCmu3YeL3MUSXgrI2cGN+oGEM1ZUskNFZlyoAV0QKRCXxqDKANEjTPL2/xYV6f+PcIcbmje+TjpBNpl2s1VOvwF51oaoLpQ9wlhCFDuvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Sp6FbdEj; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719279450; x=1750815450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TBEzQI4zURkvlXtx1krSGX3Wc0qIDpyPM052pXlH9OA=;
  b=Sp6FbdEjIvaOa+PhMrBJ7yH/7/c78LZVUuf0yvh9a0enoYdcY9IU9TCS
   fyElDZe74mTpYRXdYdQAi7YWdOxIfvCTGIXz85kARFKhRbLA7vcs2sIJB
   G+BVPmaDNreOIG4Y7eGR3vmcri4dJp9khHAjURFs/+EnE9ZfrZvB1Ij1J
   w=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="409897475"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:37:27 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:33490]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.255:2525] with esmtp (Farcaster)
 id cb94893d-e814-4025-96d1-7d58a2819b3e; Tue, 25 Jun 2024 01:37:26 +0000 (UTC)
X-Farcaster-Flow-ID: cb94893d-e814-4025-96d1-7d58a2819b3e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 25 Jun 2024 01:37:25 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:37:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao Shoaib <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 01/11] selftest: af_unix: Remove test_unix_oob.c.
Date: Mon, 24 Jun 2024 18:36:35 -0700
Message-ID: <20240625013645.45034-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240625013645.45034-1-kuniyu@amazon.com>
References: <20240625013645.45034-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

test_unix_oob.c does not fully cover AF_UNIX's MSG_OOB functionality,
thus there are discrepancies between TCP behaviour.

Also, the test uses fork() to create message producer, and it's not
easy to understand and add more test cases.

Let's remove test_unix_oob.c and rewrite a new test.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/.gitignore        |   1 -
 tools/testing/selftests/net/af_unix/Makefile  |   2 +-
 .../selftests/net/af_unix/test_unix_oob.c     | 436 ------------------
 3 files changed, 1 insertion(+), 438 deletions(-)
 delete mode 100644 tools/testing/selftests/net/af_unix/test_unix_oob.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 49a56eb5d036..666ab7d9390b 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -43,7 +43,6 @@ tap
 tcp_fastopen_backup_key
 tcp_inq
 tcp_mmap
-test_unix_oob
 timestamping
 tls
 toeplitz
diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 3b83c797650d..a25845251eed 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -1,4 +1,4 @@
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := diag_uid test_unix_oob unix_connect scm_pidfd scm_rights
+TEST_GEN_PROGS := diag_uid scm_pidfd scm_rights unix_connect
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/af_unix/test_unix_oob.c b/tools/testing/selftests/net/af_unix/test_unix_oob.c
deleted file mode 100644
index a7c51889acd5..000000000000
--- a/tools/testing/selftests/net/af_unix/test_unix_oob.c
+++ /dev/null
@@ -1,436 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/socket.h>
-#include <arpa/inet.h>
-#include <unistd.h>
-#include <string.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <errno.h>
-#include <netinet/tcp.h>
-#include <sys/un.h>
-#include <sys/signal.h>
-#include <sys/poll.h>
-
-static int pipefd[2];
-static int signal_recvd;
-static pid_t producer_id;
-static char sock_name[32];
-
-static void sig_hand(int sn, siginfo_t *si, void *p)
-{
-	signal_recvd = sn;
-}
-
-static int set_sig_handler(int signal)
-{
-	struct sigaction sa;
-
-	sa.sa_sigaction = sig_hand;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_SIGINFO | SA_RESTART;
-
-	return sigaction(signal, &sa, NULL);
-}
-
-static void set_filemode(int fd, int set)
-{
-	int flags = fcntl(fd, F_GETFL, 0);
-
-	if (set)
-		flags &= ~O_NONBLOCK;
-	else
-		flags |= O_NONBLOCK;
-	fcntl(fd, F_SETFL, flags);
-}
-
-static void signal_producer(int fd)
-{
-	char cmd;
-
-	cmd = 'S';
-	write(fd, &cmd, sizeof(cmd));
-}
-
-static void wait_for_signal(int fd)
-{
-	char buf[5];
-
-	read(fd, buf, 5);
-}
-
-static void die(int status)
-{
-	fflush(NULL);
-	unlink(sock_name);
-	kill(producer_id, SIGTERM);
-	exit(status);
-}
-
-int is_sioctatmark(int fd)
-{
-	int ans = -1;
-
-	if (ioctl(fd, SIOCATMARK, &ans, sizeof(ans)) < 0) {
-#ifdef DEBUG
-		perror("SIOCATMARK Failed");
-#endif
-	}
-	return ans;
-}
-
-void read_oob(int fd, char *c)
-{
-
-	*c = ' ';
-	if (recv(fd, c, sizeof(*c), MSG_OOB) < 0) {
-#ifdef DEBUG
-		perror("Reading MSG_OOB Failed");
-#endif
-	}
-}
-
-int read_data(int pfd, char *buf, int size)
-{
-	int len = 0;
-
-	memset(buf, size, '0');
-	len = read(pfd, buf, size);
-#ifdef DEBUG
-	if (len < 0)
-		perror("read failed");
-#endif
-	return len;
-}
-
-static void wait_for_data(int pfd, int event)
-{
-	struct pollfd pfds[1];
-
-	pfds[0].fd = pfd;
-	pfds[0].events = event;
-	poll(pfds, 1, -1);
-}
-
-void producer(struct sockaddr_un *consumer_addr)
-{
-	int cfd;
-	char buf[64];
-	int i;
-
-	memset(buf, 'x', sizeof(buf));
-	cfd = socket(AF_UNIX, SOCK_STREAM, 0);
-
-	wait_for_signal(pipefd[0]);
-	if (connect(cfd, (struct sockaddr *)consumer_addr,
-		     sizeof(*consumer_addr)) != 0) {
-		perror("Connect failed");
-		kill(0, SIGTERM);
-		exit(1);
-	}
-
-	for (i = 0; i < 2; i++) {
-		/* Test 1: Test for SIGURG and OOB */
-		wait_for_signal(pipefd[0]);
-		memset(buf, 'x', sizeof(buf));
-		buf[63] = '@';
-		send(cfd, buf, sizeof(buf), MSG_OOB);
-
-		wait_for_signal(pipefd[0]);
-
-		/* Test 2: Test for OOB being overwitten */
-		memset(buf, 'x', sizeof(buf));
-		buf[63] = '%';
-		send(cfd, buf, sizeof(buf), MSG_OOB);
-
-		memset(buf, 'x', sizeof(buf));
-		buf[63] = '#';
-		send(cfd, buf, sizeof(buf), MSG_OOB);
-
-		wait_for_signal(pipefd[0]);
-
-		/* Test 3: Test for SIOCATMARK */
-		memset(buf, 'x', sizeof(buf));
-		buf[63] = '@';
-		send(cfd, buf, sizeof(buf), MSG_OOB);
-
-		memset(buf, 'x', sizeof(buf));
-		buf[63] = '%';
-		send(cfd, buf, sizeof(buf), MSG_OOB);
-
-		memset(buf, 'x', sizeof(buf));
-		send(cfd, buf, sizeof(buf), 0);
-
-		wait_for_signal(pipefd[0]);
-
-		/* Test 4: Test for 1byte OOB msg */
-		memset(buf, 'x', sizeof(buf));
-		buf[0] = '@';
-		send(cfd, buf, 1, MSG_OOB);
-	}
-}
-
-int
-main(int argc, char **argv)
-{
-	int lfd, pfd;
-	struct sockaddr_un consumer_addr, paddr;
-	socklen_t len = sizeof(consumer_addr);
-	char buf[1024];
-	int on = 0;
-	char oob;
-	int atmark;
-
-	lfd = socket(AF_UNIX, SOCK_STREAM, 0);
-	memset(&consumer_addr, 0, sizeof(consumer_addr));
-	consumer_addr.sun_family = AF_UNIX;
-	sprintf(sock_name, "unix_oob_%d", getpid());
-	unlink(sock_name);
-	strcpy(consumer_addr.sun_path, sock_name);
-
-	if ((bind(lfd, (struct sockaddr *)&consumer_addr,
-		  sizeof(consumer_addr))) != 0) {
-		perror("socket bind failed");
-		exit(1);
-	}
-
-	pipe(pipefd);
-
-	listen(lfd, 1);
-
-	producer_id = fork();
-	if (producer_id == 0) {
-		producer(&consumer_addr);
-		exit(0);
-	}
-
-	set_sig_handler(SIGURG);
-	signal_producer(pipefd[1]);
-
-	pfd = accept(lfd, (struct sockaddr *) &paddr, &len);
-	fcntl(pfd, F_SETOWN, getpid());
-
-	signal_recvd = 0;
-	signal_producer(pipefd[1]);
-
-	/* Test 1:
-	 * veriyf that SIGURG is
-	 * delivered, 63 bytes are
-	 * read, oob is '@', and POLLPRI works.
-	 */
-	wait_for_data(pfd, POLLPRI);
-	read_oob(pfd, &oob);
-	len = read_data(pfd, buf, 1024);
-	if (!signal_recvd || len != 63 || oob != '@') {
-		fprintf(stderr, "Test 1 failed sigurg %d len %d %c\n",
-			 signal_recvd, len, oob);
-			die(1);
-	}
-
-	signal_recvd = 0;
-	signal_producer(pipefd[1]);
-
-	/* Test 2:
-	 * Verify that the first OOB is over written by
-	 * the 2nd one and the first OOB is returned as
-	 * part of the read, and sigurg is received.
-	 */
-	wait_for_data(pfd, POLLIN | POLLPRI);
-	len = 0;
-	while (len < 70)
-		len = recv(pfd, buf, 1024, MSG_PEEK);
-	len = read_data(pfd, buf, 1024);
-	read_oob(pfd, &oob);
-	if (!signal_recvd || len != 127 || oob != '#') {
-		fprintf(stderr, "Test 2 failed, sigurg %d len %d OOB %c\n",
-		signal_recvd, len, oob);
-		die(1);
-	}
-
-	signal_recvd = 0;
-	signal_producer(pipefd[1]);
-
-	/* Test 3:
-	 * verify that 2nd oob over writes
-	 * the first one and read breaks at
-	 * oob boundary returning 127 bytes
-	 * and sigurg is received and atmark
-	 * is set.
-	 * oob is '%' and second read returns
-	 * 64 bytes.
-	 */
-	len = 0;
-	wait_for_data(pfd, POLLIN | POLLPRI);
-	while (len < 150)
-		len = recv(pfd, buf, 1024, MSG_PEEK);
-	len = read_data(pfd, buf, 1024);
-	atmark = is_sioctatmark(pfd);
-	read_oob(pfd, &oob);
-
-	if (!signal_recvd || len != 127 || oob != '%' || atmark != 1) {
-		fprintf(stderr,
-			"Test 3 failed, sigurg %d len %d OOB %c atmark %d\n",
-			signal_recvd, len, oob, atmark);
-		die(1);
-	}
-
-	signal_recvd = 0;
-
-	len = read_data(pfd, buf, 1024);
-	if (len != 64) {
-		fprintf(stderr, "Test 3.1 failed, sigurg %d len %d OOB %c\n",
-			signal_recvd, len, oob);
-		die(1);
-	}
-
-	signal_recvd = 0;
-	signal_producer(pipefd[1]);
-
-	/* Test 4:
-	 * verify that a single byte
-	 * oob message is delivered.
-	 * set non blocking mode and
-	 * check proper error is
-	 * returned and sigurg is
-	 * received and correct
-	 * oob is read.
-	 */
-
-	set_filemode(pfd, 0);
-
-	wait_for_data(pfd, POLLIN | POLLPRI);
-	len = read_data(pfd, buf, 1024);
-	if ((len == -1) && (errno == 11))
-		len = 0;
-
-	read_oob(pfd, &oob);
-
-	if (!signal_recvd || len != 0 || oob != '@') {
-		fprintf(stderr, "Test 4 failed, sigurg %d len %d OOB %c\n",
-			 signal_recvd, len, oob);
-		die(1);
-	}
-
-	set_filemode(pfd, 1);
-
-	/* Inline Testing */
-
-	on = 1;
-	if (setsockopt(pfd, SOL_SOCKET, SO_OOBINLINE, &on, sizeof(on))) {
-		perror("SO_OOBINLINE");
-		die(1);
-	}
-
-	signal_recvd = 0;
-	signal_producer(pipefd[1]);
-
-	/* Test 1 -- Inline:
-	 * Check that SIGURG is
-	 * delivered and 63 bytes are
-	 * read and oob is '@'
-	 */
-
-	wait_for_data(pfd, POLLIN | POLLPRI);
-	len = read_data(pfd, buf, 1024);
-
-	if (!signal_recvd || len != 63) {
-		fprintf(stderr, "Test 1 Inline failed, sigurg %d len %d\n",
-			signal_recvd, len);
-		die(1);
-	}
-
-	len = read_data(pfd, buf, 1024);
-
-	if (len != 1) {
-		fprintf(stderr,
-			 "Test 1.1 Inline failed, sigurg %d len %d oob %c\n",
-			 signal_recvd, len, oob);
-		die(1);
-	}
-
-	signal_recvd = 0;
-	signal_producer(pipefd[1]);
-
-	/* Test 2 -- Inline:
-	 * Verify that the first OOB is over written by
-	 * the 2nd one and read breaks correctly on
-	 * 2nd OOB boundary with the first OOB returned as
-	 * part of the read, and sigurg is delivered and
-	 * siocatmark returns true.
-	 * next read returns one byte, the oob byte
-	 * and siocatmark returns false.
-	 */
-	len = 0;
-	wait_for_data(pfd, POLLIN | POLLPRI);
-	while (len < 70)
-		len = recv(pfd, buf, 1024, MSG_PEEK);
-	len = read_data(pfd, buf, 1024);
-	atmark = is_sioctatmark(pfd);
-	if (len != 127 || atmark != 1 || !signal_recvd) {
-		fprintf(stderr, "Test 2 Inline failed, len %d atmark %d\n",
-			 len, atmark);
-		die(1);
-	}
-
-	len = read_data(pfd, buf, 1024);
-	atmark = is_sioctatmark(pfd);
-	if (len != 1 || buf[0] != '#' || atmark == 1) {
-		fprintf(stderr, "Test 2.1 Inline failed, len %d data %c atmark %d\n",
-			len, buf[0], atmark);
-		die(1);
-	}
-
-	signal_recvd = 0;
-	signal_producer(pipefd[1]);
-
-	/* Test 3 -- Inline:
-	 * verify that 2nd oob over writes
-	 * the first one and read breaks at
-	 * oob boundary returning 127 bytes
-	 * and sigurg is received and siocatmark
-	 * is true after the read.
-	 * subsequent read returns 65 bytes
-	 * because of oob which should be '%'.
-	 */
-	len = 0;
-	wait_for_data(pfd, POLLIN | POLLPRI);
-	while (len < 126)
-		len = recv(pfd, buf, 1024, MSG_PEEK);
-	len = read_data(pfd, buf, 1024);
-	atmark = is_sioctatmark(pfd);
-	if (!signal_recvd || len != 127 || !atmark) {
-		fprintf(stderr,
-			 "Test 3 Inline failed, sigurg %d len %d data %c\n",
-			 signal_recvd, len, buf[0]);
-		die(1);
-	}
-
-	len = read_data(pfd, buf, 1024);
-	atmark = is_sioctatmark(pfd);
-	if (len != 65 || buf[0] != '%' || atmark != 0) {
-		fprintf(stderr,
-			 "Test 3.1 Inline failed, len %d oob %c atmark %d\n",
-			 len, buf[0], atmark);
-		die(1);
-	}
-
-	signal_recvd = 0;
-	signal_producer(pipefd[1]);
-
-	/* Test 4 -- Inline:
-	 * verify that a single
-	 * byte oob message is delivered
-	 * and read returns one byte, the oob
-	 * byte and sigurg is received
-	 */
-	wait_for_data(pfd, POLLIN | POLLPRI);
-	len = read_data(pfd, buf, 1024);
-	if (!signal_recvd || len != 1 || buf[0] != '@') {
-		fprintf(stderr,
-			"Test 4 Inline failed, signal %d len %d data %c\n",
-		signal_recvd, len, buf[0]);
-		die(1);
-	}
-	die(0);
-}
-- 
2.30.2


