Return-Path: <netdev+bounces-106317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79567915BCA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15FAB217FA
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689391CAB5;
	Tue, 25 Jun 2024 01:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mQuYbqiJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F11CA8D
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279652; cv=none; b=lRyuTyjwNaXklco7QEMnEbHjHevck+le2Xr/1p7iiU3v4Y1wRfYZOW0au5zOHjfyU+S9fDjOE1SfvccpmDTu1Pkweg1n5bnbu6KoJHZ46FDPGJrZOWRGgT5v0chbzcSWyLj2f7hSAMxwnaC25+UBLrVtfuG1doW4cbmBPI57Bxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279652; c=relaxed/simple;
	bh=IfSlJgyRS3s82Ip+nXwvm5Ov++aGgfWCcSdYQHisA0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGuTX8ekpmnBpcowwyAr1xTRx2z0Ged9fjpnQqBX9DZO8gk18SkXqfKFXbtNc+Rk416q39HHU/X9Jyt9tCMBpRVi8uLCpTbAAMZ/574RqPQmnS2rAqhKgjd3Nh+NoaGRZVtc/w/fvPM6bIRL4pBZoOaBpcKApP0U+Jcpvdsvoq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mQuYbqiJ; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719279650; x=1750815650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6GBfWGtzDLKE7d9GtuWyU9iPkRCpmCBiUvMEL50ZYLI=;
  b=mQuYbqiJw8sZ7FhDAH4wGWMqphg/9onaTEXBnq8HNuxe4iQOvJes8eh+
   QS7BK1JEjrQgLkSCWay2SYNAiTGg4G+axGd4fK9wUwKdUO/pBfPFSjuXg
   H+znej7taPEiOPY4POQC8dsGrbKKQbk/DyfcCgI7jrG3sRh55zgFJoGje
   k=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="428636512"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:40:44 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:11380]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.59:2525] with esmtp (Farcaster)
 id 67defade-a3f1-4de0-98eb-e4530c6c4ba9; Tue, 25 Jun 2024 01:40:44 +0000 (UTC)
X-Farcaster-Flow-ID: 67defade-a3f1-4de0-98eb-e4530c6c4ba9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:40:44 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:40:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao Shoaib <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 09/11] selftest: af_unix: Check EPOLLPRI after every send()/recv() in msg_oob.c
Date: Mon, 24 Jun 2024 18:36:43 -0700
Message-ID: <20240625013645.45034-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When OOB data is in recvq, we can detect it with epoll by checking
EPOLLPRI.

This patch add checks for EPOLLPRI after every send() and recv() in
all test cases.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/af_unix/msg_oob.c | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 123dee0b6739..28b09b36a2f1 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -6,6 +6,7 @@
 #include <unistd.h>
 
 #include <netinet/in.h>
+#include <sys/epoll.h>
 #include <sys/ioctl.h>
 #include <sys/signalfd.h>
 #include <sys/socket.h>
@@ -22,6 +23,9 @@ FIXTURE(msg_oob)
 				 * 3: TCP receiver
 				 */
 	int signal_fd;
+	int epoll_fd[2];	/* 0: AF_UNIX receiver
+				 * 1: TCP receiver
+				 */
 	bool tcp_compliant;
 };
 
@@ -109,6 +113,25 @@ static void setup_sigurg(struct __test_metadata *_metadata,
 	ASSERT_EQ(ret, -1);
 }
 
+static void setup_epollpri(struct __test_metadata *_metadata,
+			   FIXTURE_DATA(msg_oob) *self)
+{
+	struct epoll_event event = {
+		.events = EPOLLPRI,
+	};
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		int ret;
+
+		self->epoll_fd[i] = epoll_create1(0);
+		ASSERT_GE(self->epoll_fd[i], 0);
+
+		ret = epoll_ctl(self->epoll_fd[i], EPOLL_CTL_ADD, self->fd[i * 2 + 1], &event);
+		ASSERT_EQ(ret, 0);
+	}
+}
+
 static void close_sockets(FIXTURE_DATA(msg_oob) *self)
 {
 	int i;
@@ -123,6 +146,7 @@ FIXTURE_SETUP(msg_oob)
 	create_tcp_socketpair(_metadata, self);
 
 	setup_sigurg(_metadata, self);
+	setup_epollpri(_metadata, self);
 
 	self->tcp_compliant = true;
 }
@@ -132,6 +156,29 @@ FIXTURE_TEARDOWN(msg_oob)
 	close_sockets(self);
 }
 
+static void __epollpair(struct __test_metadata *_metadata,
+			FIXTURE_DATA(msg_oob) *self,
+			bool oob_remaining)
+{
+	struct epoll_event event[2] = {};
+	int i, ret[2];
+
+	for (i = 0; i < 2; i++)
+		ret[i] = epoll_wait(self->epoll_fd[i], &event[i], 1, 0);
+
+	ASSERT_EQ(ret[0], oob_remaining);
+
+	if (self->tcp_compliant)
+		ASSERT_EQ(ret[0], ret[1]);
+
+	if (oob_remaining) {
+		ASSERT_EQ(event[0].events, EPOLLPRI);
+
+		if (self->tcp_compliant)
+			ASSERT_EQ(event[0].events, event[1].events);
+	}
+}
+
 static void __sendpair(struct __test_metadata *_metadata,
 		       FIXTURE_DATA(msg_oob) *self,
 		       const void *buf, size_t len, int flags)
@@ -254,6 +301,9 @@ static void __setinlinepair(struct __test_metadata *_metadata,
 			   expected_buf, expected_len, buf_len, flags);	\
 	} while (0)
 
+#define epollpair(oob_remaining)					\
+	__epollpair(_metadata, self, oob_remaining)
+
 #define setinlinepair()							\
 	__setinlinepair(_metadata, self)
 
@@ -265,109 +315,170 @@ static void __setinlinepair(struct __test_metadata *_metadata,
 TEST_F(msg_oob, non_oob)
 {
 	sendpair("x", 1, 0);
+	epollpair(false);
 
 	recvpair("", -EINVAL, 1, MSG_OOB);
+	epollpair(false);
 }
 
 TEST_F(msg_oob, oob)
 {
 	sendpair("x", 1, MSG_OOB);
+	epollpair(true);
 
 	recvpair("x", 1, 1, MSG_OOB);
+	epollpair(false);
 }
 
 TEST_F(msg_oob, oob_drop)
 {
 	sendpair("x", 1, MSG_OOB);
+	epollpair(true);
 
 	recvpair("", -EAGAIN, 1, 0);		/* Drop OOB. */
+	epollpair(false);
+
 	recvpair("", -EINVAL, 1, MSG_OOB);
+	epollpair(false);
 }
 
 TEST_F(msg_oob, oob_ahead)
 {
 	sendpair("hello", 5, MSG_OOB);
+	epollpair(true);
 
 	recvpair("o", 1, 1, MSG_OOB);
+	epollpair(false);
+
 	recvpair("hell", 4, 4, 0);
+	epollpair(false);
 }
 
 TEST_F(msg_oob, oob_break)
 {
 	sendpair("hello", 5, MSG_OOB);
+	epollpair(true);
 
 	recvpair("hell", 4, 5, 0);		/* Break at OOB even with enough buffer. */
+	epollpair(true);
+
 	recvpair("o", 1, 1, MSG_OOB);
+	epollpair(false);
 }
 
 TEST_F(msg_oob, oob_ahead_break)
 {
 	sendpair("hello", 5, MSG_OOB);
+	epollpair(true);
+
 	sendpair("world", 5, 0);
+	epollpair(true);
 
 	recvpair("o", 1, 1, MSG_OOB);
+	epollpair(false);
+
 	recvpair("hell", 4, 9, 0);		/* Break at OOB even after it's recv()ed. */
+	epollpair(false);
+
 	recvpair("world", 5, 5, 0);
+	epollpair(false);
 }
 
 TEST_F(msg_oob, oob_break_drop)
 {
 	sendpair("hello", 5, MSG_OOB);
+	epollpair(true);
+
 	sendpair("world", 5, 0);
+	epollpair(true);
 
 	recvpair("hell", 4, 10, 0);		/* Break at OOB even with enough buffer. */
+	epollpair(true);
+
 	recvpair("world", 5, 10, 0);		/* Drop OOB and recv() the next skb. */
+	epollpair(false);
+
 	recvpair("", -EINVAL, 1, MSG_OOB);
+	epollpair(false);
 }
 
 TEST_F(msg_oob, ex_oob_break)
 {
 	sendpair("hello", 5, MSG_OOB);
+	epollpair(true);
+
 	sendpair("wor", 3, MSG_OOB);
+	epollpair(true);
+
 	sendpair("ld", 2, 0);
+	epollpair(true);
 
 	recvpair("hellowo", 7, 10, 0);		/* Break at OOB but not at ex-OOB. */
+	epollpair(true);
+
 	recvpair("r", 1, 1, MSG_OOB);
+	epollpair(false);
+
 	recvpair("ld", 2, 2, 0);
+	epollpair(false);
 }
 
 TEST_F(msg_oob, ex_oob_drop)
 {
 	sendpair("x", 1, MSG_OOB);
+	epollpair(true);
+
 	sendpair("y", 1, MSG_OOB);		/* TCP drops "x" at this moment. */
+	epollpair(true);
 
 	tcp_incompliant {
 		recvpair("x", 1, 1, 0);		/* TCP drops "y" by passing through it. */
+		epollpair(true);
+
 		recvpair("y", 1, 1, MSG_OOB);	/* TCP returns -EINVAL. */
+		epollpair(false);
 	}
 }
 
 TEST_F(msg_oob, ex_oob_drop_2)
 {
 	sendpair("x", 1, MSG_OOB);
+	epollpair(true);
+
 	sendpair("y", 1, MSG_OOB);		/* TCP drops "x" at this moment. */
+	epollpair(true);
 
 	recvpair("y", 1, 1, MSG_OOB);
+	epollpair(false);
 
 	tcp_incompliant {
 		recvpair("x", 1, 1, 0);		/* TCP returns -EAGAIN. */
+		epollpair(false);
 	}
 }
 
 TEST_F(msg_oob, ex_oob_ahead_break)
 {
 	sendpair("hello", 5, MSG_OOB);
+	epollpair(true);
+
 	sendpair("wor", 3, MSG_OOB);
+	epollpair(true);
 
 	recvpair("r", 1, 1, MSG_OOB);
+	epollpair(false);
 
 	sendpair("ld", 2, MSG_OOB);
+	epollpair(true);
 
 	tcp_incompliant {
 		recvpair("hellowol", 8, 10, 0);	/* TCP recv()s "helloworl", why "r" ?? */
 	}
 
+	epollpair(true);
+
 	recvpair("d", 1, 1, MSG_OOB);
+	epollpair(false);
 }
 
 TEST_F(msg_oob, inline_oob)
@@ -375,9 +486,13 @@ TEST_F(msg_oob, inline_oob)
 	setinlinepair();
 
 	sendpair("x", 1, MSG_OOB);
+	epollpair(true);
 
 	recvpair("", -EINVAL, 1, MSG_OOB);
+	epollpair(true);
+
 	recvpair("x", 1, 1, 0);
+	epollpair(false);
 }
 
 TEST_F(msg_oob, inline_oob_break)
@@ -385,62 +500,94 @@ TEST_F(msg_oob, inline_oob_break)
 	setinlinepair();
 
 	sendpair("hello", 5, MSG_OOB);
+	epollpair(true);
 
 	recvpair("", -EINVAL, 1, MSG_OOB);
+	epollpair(true);
+
 	recvpair("hell", 4, 5, 0);		/* Break at OOB but not at ex-OOB. */
+	epollpair(true);
+
 	recvpair("o", 1, 1, 0);
+	epollpair(false);
 }
 
 TEST_F(msg_oob, inline_oob_ahead_break)
 {
 	sendpair("hello", 5, MSG_OOB);
+	epollpair(true);
+
 	sendpair("world", 5, 0);
+	epollpair(true);
 
 	recvpair("o", 1, 1, MSG_OOB);
+	epollpair(false);
 
 	setinlinepair();
 
 	recvpair("hell", 4, 9, 0);		/* Break at OOB even with enough buffer. */
+	epollpair(false);
 
 	tcp_incompliant {
 		recvpair("world", 5, 6, 0);	/* TCP recv()s "oworld", ... "o" ??? */
 	}
+
+	epollpair(false);
 }
 
 TEST_F(msg_oob, inline_ex_oob_break)
 {
 	sendpair("hello", 5, MSG_OOB);
+	epollpair(true);
+
 	sendpair("wor", 3, MSG_OOB);
+	epollpair(true);
+
 	sendpair("ld", 2, 0);
+	epollpair(true);
 
 	setinlinepair();
 
 	recvpair("hellowo", 7, 10, 0);		/* Break at OOB but not at ex-OOB. */
+	epollpair(true);
+
 	recvpair("rld", 3, 3, 0);
+	epollpair(false);
 }
 
 TEST_F(msg_oob, inline_ex_oob_no_drop)
 {
 	sendpair("x", 1, MSG_OOB);
+	epollpair(true);
 
 	setinlinepair();
 
 	sendpair("y", 1, MSG_OOB);		/* TCP does NOT drops "x" at this moment. */
+	epollpair(true);
 
 	recvpair("x", 1, 1, 0);
+	epollpair(true);
+
 	recvpair("y", 1, 1, 0);
+	epollpair(false);
 }
 
 TEST_F(msg_oob, inline_ex_oob_drop)
 {
 	sendpair("x", 1, MSG_OOB);
+	epollpair(true);
+
 	sendpair("y", 1, MSG_OOB);		/* TCP drops "x" at this moment. */
+	epollpair(true);
 
 	setinlinepair();
 
 	tcp_incompliant {
 		recvpair("x", 1, 1, 0);		/* TCP recv()s "y". */
+		epollpair(true);
+
 		recvpair("y", 1, 1, 0);		/* TCP returns -EAGAIN. */
+		epollpair(false);
 	}
 }
 
-- 
2.30.2


