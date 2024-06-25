Return-Path: <netdev+bounces-106321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53942915BCF
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745341C21315
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0451B59A;
	Tue, 25 Jun 2024 01:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SV+3Jof6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017418030
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279700; cv=none; b=TW9BAloowyD2nKhRBXaB8zF9QWcSQ4Hsp87pOgSi0vp60JB63TOhk83+7uwrE+vgvM+3RfCO6JT79AkZiA8/zp4IEvqGZ42C0IBIP6hrAQyOf4j5HV0Ka16es3dK2qEkr9tKqcvgp8Gvnm4aR7NxTNbf8fFtR0/RRyj2cW2NAWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279700; c=relaxed/simple;
	bh=C4iuk6aCyTdW3LLiWQsGmvzaJZKLw2OC00ZgTooa9Kw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESekn1USBDzu+w8AV3vm4rIYxR0gFaAcz5RKTweaIAufWfDRhc0Ec0ilS455kqDKPrBAl11GXxjhq2avN33guowC7T9k5c9iSWXRzQ3Sn8zVPJjAIcf21wX/jz0eDwI/ELn6jr7upFggvGJDyrkK4QBsj4/gI20kTjsJdsnLylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SV+3Jof6; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719279698; x=1750815698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QzCye2OJ3Q1XqP1OYst842P7VKPjXqtc8fLBGrvoyEs=;
  b=SV+3Jof6/ApsrcYqwz6CeBU/tSFX+SohAtC6g6aK0vGg6vpg2WlwI6Ay
   s0eT1DNpB37aW25ErqylyOBvRdHkYWmMXxrzFxsQQORu2ovwNh2fc5Nq+
   qZGwoQvjEHkHIuMUEdG723dGK/PSN0shAAzJths7LPcj3TzS4aZs9zpHM
   k=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="99255569"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:41:38 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:32434]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.1:2525] with esmtp (Farcaster)
 id c6f5a045-bb19-401b-8502-374eccb80e38; Tue, 25 Jun 2024 01:41:37 +0000 (UTC)
X-Farcaster-Flow-ID: c6f5a045-bb19-401b-8502-374eccb80e38
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:41:34 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:41:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao Shoaib <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 11/11] selftest: af_unix: Check SIOCATMARK after every send()/recv() in msg_oob.c.
Date: Mon, 24 Jun 2024 18:36:45 -0700
Message-ID: <20240625013645.45034-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

To catch regression, let's check ioctl(SIOCATMARK) after every
send() and recv() calls.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/af_unix/msg_oob.c | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 2d0024329437..16d0c172eaeb 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -339,9 +339,11 @@ TEST_F(msg_oob, non_oob)
 {
 	sendpair("x", 1, 0);
 	epollpair(false);
+	siocatmarkpair(false);
 
 	recvpair("", -EINVAL, 1, MSG_OOB);
 	epollpair(false);
+	siocatmarkpair(false);
 }
 
 TEST_F(msg_oob, oob)
@@ -359,109 +361,142 @@ TEST_F(msg_oob, oob_drop)
 {
 	sendpair("x", 1, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(true);
 
 	recvpair("", -EAGAIN, 1, 0);		/* Drop OOB. */
 	epollpair(false);
+	siocatmarkpair(false);
 
 	recvpair("", -EINVAL, 1, MSG_OOB);
 	epollpair(false);
+	siocatmarkpair(false);
 }
 
 TEST_F(msg_oob, oob_ahead)
 {
 	sendpair("hello", 5, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	recvpair("o", 1, 1, MSG_OOB);
 	epollpair(false);
+	siocatmarkpair(false);
 
 	recvpair("hell", 4, 4, 0);
 	epollpair(false);
+	siocatmarkpair(true);
 }
 
 TEST_F(msg_oob, oob_break)
 {
 	sendpair("hello", 5, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	recvpair("hell", 4, 5, 0);		/* Break at OOB even with enough buffer. */
 	epollpair(true);
+	siocatmarkpair(true);
 
 	recvpair("o", 1, 1, MSG_OOB);
 	epollpair(false);
+	siocatmarkpair(true);
+
+	recvpair("", -EAGAIN, 1, 0);
+	siocatmarkpair(false);
 }
 
 TEST_F(msg_oob, oob_ahead_break)
 {
 	sendpair("hello", 5, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	sendpair("world", 5, 0);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	recvpair("o", 1, 1, MSG_OOB);
 	epollpair(false);
+	siocatmarkpair(false);
 
 	recvpair("hell", 4, 9, 0);		/* Break at OOB even after it's recv()ed. */
 	epollpair(false);
+	siocatmarkpair(true);
 
 	recvpair("world", 5, 5, 0);
 	epollpair(false);
+	siocatmarkpair(false);
 }
 
 TEST_F(msg_oob, oob_break_drop)
 {
 	sendpair("hello", 5, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	sendpair("world", 5, 0);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	recvpair("hell", 4, 10, 0);		/* Break at OOB even with enough buffer. */
 	epollpair(true);
+	siocatmarkpair(true);
 
 	recvpair("world", 5, 10, 0);		/* Drop OOB and recv() the next skb. */
 	epollpair(false);
+	siocatmarkpair(false);
 
 	recvpair("", -EINVAL, 1, MSG_OOB);
 	epollpair(false);
+	siocatmarkpair(false);
 }
 
 TEST_F(msg_oob, ex_oob_break)
 {
 	sendpair("hello", 5, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	sendpair("wor", 3, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	sendpair("ld", 2, 0);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	recvpair("hellowo", 7, 10, 0);		/* Break at OOB but not at ex-OOB. */
 	epollpair(true);
+	siocatmarkpair(true);
 
 	recvpair("r", 1, 1, MSG_OOB);
 	epollpair(false);
+	siocatmarkpair(true);
 
 	recvpair("ld", 2, 2, 0);
 	epollpair(false);
+	siocatmarkpair(false);
 }
 
 TEST_F(msg_oob, ex_oob_drop)
 {
 	sendpair("x", 1, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(true);
 
 	sendpair("y", 1, MSG_OOB);		/* TCP drops "x" at this moment. */
 	epollpair(true);
 
 	tcp_incompliant {
+		siocatmarkpair(false);
+
 		recvpair("x", 1, 1, 0);		/* TCP drops "y" by passing through it. */
 		epollpair(true);
+		siocatmarkpair(true);
 
 		recvpair("y", 1, 1, MSG_OOB);	/* TCP returns -EINVAL. */
 		epollpair(false);
+		siocatmarkpair(true);
 	}
 }
 
@@ -469,16 +504,24 @@ TEST_F(msg_oob, ex_oob_drop_2)
 {
 	sendpair("x", 1, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(true);
 
 	sendpair("y", 1, MSG_OOB);		/* TCP drops "x" at this moment. */
 	epollpair(true);
 
+	tcp_incompliant {
+		siocatmarkpair(false);
+	}
+
 	recvpair("y", 1, 1, MSG_OOB);
 	epollpair(false);
 
 	tcp_incompliant {
+		siocatmarkpair(false);
+
 		recvpair("x", 1, 1, 0);		/* TCP returns -EAGAIN. */
 		epollpair(false);
+		siocatmarkpair(true);
 	}
 }
 
@@ -486,24 +529,30 @@ TEST_F(msg_oob, ex_oob_ahead_break)
 {
 	sendpair("hello", 5, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	sendpair("wor", 3, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	recvpair("r", 1, 1, MSG_OOB);
 	epollpair(false);
+	siocatmarkpair(false);
 
 	sendpair("ld", 2, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	tcp_incompliant {
 		recvpair("hellowol", 8, 10, 0);	/* TCP recv()s "helloworl", why "r" ?? */
 	}
 
 	epollpair(true);
+	siocatmarkpair(true);
 
 	recvpair("d", 1, 1, MSG_OOB);
 	epollpair(false);
+	siocatmarkpair(true);
 }
 
 TEST_F(msg_oob, ex_oob_siocatmark)
@@ -548,81 +597,100 @@ TEST_F(msg_oob, inline_oob_break)
 
 	sendpair("hello", 5, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	recvpair("", -EINVAL, 1, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	recvpair("hell", 4, 5, 0);		/* Break at OOB but not at ex-OOB. */
 	epollpair(true);
+	siocatmarkpair(true);
 
 	recvpair("o", 1, 1, 0);
 	epollpair(false);
+	siocatmarkpair(false);
 }
 
 TEST_F(msg_oob, inline_oob_ahead_break)
 {
 	sendpair("hello", 5, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	sendpair("world", 5, 0);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	recvpair("o", 1, 1, MSG_OOB);
 	epollpair(false);
+	siocatmarkpair(false);
 
 	setinlinepair();
 
 	recvpair("hell", 4, 9, 0);		/* Break at OOB even with enough buffer. */
 	epollpair(false);
+	siocatmarkpair(true);
 
 	tcp_incompliant {
 		recvpair("world", 5, 6, 0);	/* TCP recv()s "oworld", ... "o" ??? */
 	}
 
 	epollpair(false);
+	siocatmarkpair(false);
 }
 
 TEST_F(msg_oob, inline_ex_oob_break)
 {
 	sendpair("hello", 5, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	sendpair("wor", 3, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	sendpair("ld", 2, 0);
 	epollpair(true);
+	siocatmarkpair(false);
 
 	setinlinepair();
 
 	recvpair("hellowo", 7, 10, 0);		/* Break at OOB but not at ex-OOB. */
 	epollpair(true);
+	siocatmarkpair(true);
 
 	recvpair("rld", 3, 3, 0);
 	epollpair(false);
+	siocatmarkpair(false);
 }
 
 TEST_F(msg_oob, inline_ex_oob_no_drop)
 {
 	sendpair("x", 1, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(true);
 
 	setinlinepair();
 
 	sendpair("y", 1, MSG_OOB);		/* TCP does NOT drops "x" at this moment. */
 	epollpair(true);
+	siocatmarkpair(false);
 
 	recvpair("x", 1, 1, 0);
 	epollpair(true);
+	siocatmarkpair(true);
 
 	recvpair("y", 1, 1, 0);
 	epollpair(false);
+	siocatmarkpair(false);
 }
 
 TEST_F(msg_oob, inline_ex_oob_drop)
 {
 	sendpair("x", 1, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(true);
 
 	sendpair("y", 1, MSG_OOB);		/* TCP drops "x" at this moment. */
 	epollpair(true);
@@ -630,11 +698,15 @@ TEST_F(msg_oob, inline_ex_oob_drop)
 	setinlinepair();
 
 	tcp_incompliant {
+		siocatmarkpair(false);
+
 		recvpair("x", 1, 1, 0);		/* TCP recv()s "y". */
 		epollpair(true);
+		siocatmarkpair(true);
 
 		recvpair("y", 1, 1, 0);		/* TCP returns -EAGAIN. */
 		epollpair(false);
+		siocatmarkpair(false);
 	}
 }
 
-- 
2.30.2


