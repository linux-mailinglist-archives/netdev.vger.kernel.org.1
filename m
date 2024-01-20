Return-Path: <netdev+bounces-64447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3371C833297
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 04:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A101C20FEC
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 03:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A735ED6;
	Sat, 20 Jan 2024 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uECDhwe+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD04ED4
	for <netdev@vger.kernel.org>; Sat, 20 Jan 2024 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705720624; cv=none; b=G2zXLs1BCpTt4BsKdjszpIoesP9Deor0z96jWhuRFK8++tZdXuYu6IIW0qiva/yXzsF0fSKsmBmqqpU42M4Vpatb1ZooXSv85hNoxTAg9FKAI8R7NhlwG6jD5newaENmwr3f62EfajVPgnd7QIO2QBdPVqJIIq2Wl1VMevhvxuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705720624; c=relaxed/simple;
	bh=1S0jjY7jhpHpYKmXR+qxrH53rDiZXxvHRAn2HZEb0O0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PRwfYId4qK5rybX0e08HCCCnIlQCn42ZgN3ToB9xrjkwyLS/jtOBy8UYU0iRSxQz9xFqZLaO3giq7nXTwU1J4ERohemcOgjlVvXJfaC7QNXre7IELEcQp2h6EQsECexRmxEyK42yHVhk3vfXklekLCr6eFh4Mo2ag+vmN3f4s6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uECDhwe+; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705720623; x=1737256623;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7IG4AE0o14gMkbFRNrn4ELN9P3qUsp3aG6jOQpn9PsA=;
  b=uECDhwe+cfPo75TwDBmW83RvutPuc/ltmsAAWVGHUHIiyGeuCZDNw1+5
   /g0HmAvBqsKLitiF+EO9ASpb0gfASX6QF8tWiSFpiLVpSDvRmGu8WuC0A
   +Mnms9eryh4/R40QGg/2TX9W55xDyzXugcAbHPUGTwWaaMn0cOAxk7bAO
   U=;
X-IronPort-AV: E=Sophos;i="6.05,206,1701129600"; 
   d="scan'208";a="267343169"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 03:17:01 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com (Postfix) with ESMTPS id 8B6C940D9E;
	Sat, 20 Jan 2024 03:17:00 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:29791]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.181:2525] with esmtp (Farcaster)
 id 7f4bb79f-6b4c-4a5c-b7a7-03a633cab2d8; Sat, 20 Jan 2024 03:16:59 +0000 (UTC)
X-Farcaster-Flow-ID: 7f4bb79f-6b4c-4a5c-b7a7-03a633cab2d8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 20 Jan 2024 03:16:59 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 20 Jan 2024 03:16:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net] selftest: Don't reuse port for SO_INCOMING_CPU test.
Date: Fri, 19 Jan 2024 19:16:42 -0800
Message-ID: <20240120031642.67014-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Jakub reported that ASSERT_EQ(cpu, i) in so_incoming_cpu.c seems to
fire somewhat randomly.

  # #  RUN           so_incoming_cpu.before_reuseport.test3 ...
  # # so_incoming_cpu.c:191:test3:Expected cpu (32) == i (0)
  # # test3: Test terminated by assertion
  # #          FAIL  so_incoming_cpu.before_reuseport.test3
  # not ok 3 so_incoming_cpu.before_reuseport.test3

When the test failed, not-yet-accepted CLOSE_WAIT sockets received
SYN with a "challenging" SEQ number, which was sent from an unexpected
CPU that did not create the receiver.

The test basically does:

  1. for each cpu:
    1-1. create a server
    1-2. set SO_INCOMING_CPU

  2. for each cpu:
    2-1. set cpu affinity
    2-2. create some clients
    2-3. let clients connect() to the server on the same cpu
    2-4. close() clients

  3. for each server:
    3-1. accept() all child sockets
    3-2. check if all children have the same SO_INCOMING_CPU with the server

The root cause was the close() in 2-4. and net.ipv4.tcp_tw_reuse.

In a loop of 2., close() changed the client state to FIN_WAIT_2, and
the peer transitioned to CLOSE_WAIT.

In another loop of 2., connect() happened to select the same port of
the FIN_WAIT_2 socket, and it was reused as the default value of
net.ipv4.tcp_tw_reuse is 2.

As a result, the new client sent SYN to the CLOSE_WAIT socket from
a different CPU, and the receiver's sk_incoming_cpu was overwritten
with unexpected CPU ID.

Also, the SYN had a different SEQ number, so the CLOSE_WAIT socket
responded with Challenge ACK.  The new client properly returned RST
and effectively killed the CLOSE_WAIT socket.

This way, all clients were created successfully, but the error was
detected later by 3-2., ASSERT_EQ(cpu, i).

To avoid the failure, let's make sure that (i) the number of clients
is less than the number of available ports and (ii) such reuse never
happens.

Fixes: 6df96146b202 ("selftest: Add test for SO_INCOMING_CPU.")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/so_incoming_cpu.c | 68 ++++++++++++++-----
 1 file changed, 50 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/so_incoming_cpu.c b/tools/testing/selftests/net/so_incoming_cpu.c
index a14818164102..e9fa14e10732 100644
--- a/tools/testing/selftests/net/so_incoming_cpu.c
+++ b/tools/testing/selftests/net/so_incoming_cpu.c
@@ -3,19 +3,16 @@
 #define _GNU_SOURCE
 #include <sched.h>
 
+#include <fcntl.h>
+
 #include <netinet/in.h>
 #include <sys/socket.h>
 #include <sys/sysinfo.h>
 
 #include "../kselftest_harness.h"
 
-#define CLIENT_PER_SERVER	32 /* More sockets, more reliable */
-#define NR_SERVER		self->nproc
-#define NR_CLIENT		(CLIENT_PER_SERVER * NR_SERVER)
-
 FIXTURE(so_incoming_cpu)
 {
-	int nproc;
 	int *servers;
 	union {
 		struct sockaddr addr;
@@ -56,12 +53,47 @@ FIXTURE_VARIANT_ADD(so_incoming_cpu, after_all_listen)
 	.when_to_set = AFTER_ALL_LISTEN,
 };
 
+static void write_sysctl(struct __test_metadata *_metadata,
+			 char *filename, char *string)
+{
+	int fd, len, ret;
+
+	fd = open(filename, O_WRONLY);
+	ASSERT_NE(fd, -1);
+
+	len = strlen(string);
+	ret = write(fd, string, len);
+	ASSERT_EQ(ret, len);
+}
+
+static void setup_netns(struct __test_metadata *_metadata)
+{
+	ASSERT_EQ(unshare(CLONE_NEWNET), 0);
+	ASSERT_EQ(system("ip link set lo up"), 0);
+
+	write_sysctl(_metadata, "/proc/sys/net/ipv4/ip_local_port_range", "10000 60001");
+	write_sysctl(_metadata, "/proc/sys/net/ipv4/tcp_tw_reuse", "0");
+}
+
+#define NR_PORT				(60001 - 10000 - 1)
+#define NR_CLIENT_PER_SERVER_DEFAULT	32
+static int nr_client_per_server, nr_server, nr_client;
+
 FIXTURE_SETUP(so_incoming_cpu)
 {
-	self->nproc = get_nprocs();
-	ASSERT_LE(2, self->nproc);
+	setup_netns(_metadata);
+
+	nr_server = get_nprocs();
+	ASSERT_LE(2, nr_server);
+
+	if (NR_CLIENT_PER_SERVER_DEFAULT * nr_server < NR_PORT)
+		nr_client_per_server = NR_CLIENT_PER_SERVER_DEFAULT;
+	else
+		nr_client_per_server = NR_PORT / nr_server;
+
+	nr_client = nr_client_per_server * nr_server;
 
-	self->servers = malloc(sizeof(int) * NR_SERVER);
+	self->servers = malloc(sizeof(int) * nr_server);
 	ASSERT_NE(self->servers, NULL);
 
 	self->in_addr.sin_family = AF_INET;
@@ -74,7 +106,7 @@ FIXTURE_TEARDOWN(so_incoming_cpu)
 {
 	int i;
 
-	for (i = 0; i < NR_SERVER; i++)
+	for (i = 0; i < nr_server; i++)
 		close(self->servers[i]);
 
 	free(self->servers);
@@ -110,10 +142,10 @@ int create_server(struct __test_metadata *_metadata,
 	if (variant->when_to_set == BEFORE_LISTEN)
 		set_so_incoming_cpu(_metadata, fd, cpu);
 
-	/* We don't use CLIENT_PER_SERVER here not to block
+	/* We don't use nr_client_per_server here not to block
 	 * this test at connect() if SO_INCOMING_CPU is broken.
 	 */
-	ret = listen(fd, NR_CLIENT);
+	ret = listen(fd, nr_client);
 	ASSERT_EQ(ret, 0);
 
 	if (variant->when_to_set == AFTER_LISTEN)
@@ -128,7 +160,7 @@ void create_servers(struct __test_metadata *_metadata,
 {
 	int i, ret;
 
-	for (i = 0; i < NR_SERVER; i++) {
+	for (i = 0; i < nr_server; i++) {
 		self->servers[i] = create_server(_metadata, self, variant, i);
 
 		if (i == 0) {
@@ -138,7 +170,7 @@ void create_servers(struct __test_metadata *_metadata,
 	}
 
 	if (variant->when_to_set == AFTER_ALL_LISTEN) {
-		for (i = 0; i < NR_SERVER; i++)
+		for (i = 0; i < nr_server; i++)
 			set_so_incoming_cpu(_metadata, self->servers[i], i);
 	}
 }
@@ -149,7 +181,7 @@ void create_clients(struct __test_metadata *_metadata,
 	cpu_set_t cpu_set;
 	int i, j, fd, ret;
 
-	for (i = 0; i < NR_SERVER; i++) {
+	for (i = 0; i < nr_server; i++) {
 		CPU_ZERO(&cpu_set);
 
 		CPU_SET(i, &cpu_set);
@@ -162,7 +194,7 @@ void create_clients(struct __test_metadata *_metadata,
 		ret = sched_setaffinity(0, sizeof(cpu_set), &cpu_set);
 		ASSERT_EQ(ret, 0);
 
-		for (j = 0; j < CLIENT_PER_SERVER; j++) {
+		for (j = 0; j < nr_client_per_server; j++) {
 			fd  = socket(AF_INET, SOCK_STREAM, 0);
 			ASSERT_NE(fd, -1);
 
@@ -180,8 +212,8 @@ void verify_incoming_cpu(struct __test_metadata *_metadata,
 	int i, j, fd, cpu, ret, total = 0;
 	socklen_t len = sizeof(int);
 
-	for (i = 0; i < NR_SERVER; i++) {
-		for (j = 0; j < CLIENT_PER_SERVER; j++) {
+	for (i = 0; i < nr_server; i++) {
+		for (j = 0; j < nr_client_per_server; j++) {
 			/* If we see -EAGAIN here, SO_INCOMING_CPU is broken */
 			fd = accept(self->servers[i], &self->addr, &self->addrlen);
 			ASSERT_NE(fd, -1);
@@ -195,7 +227,7 @@ void verify_incoming_cpu(struct __test_metadata *_metadata,
 		}
 	}
 
-	ASSERT_EQ(total, NR_CLIENT);
+	ASSERT_EQ(total, nr_client);
 	TH_LOG("SO_INCOMING_CPU is very likely to be "
 	       "working correctly with %d sockets.", total);
 }
-- 
2.30.2


