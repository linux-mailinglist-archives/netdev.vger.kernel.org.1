Return-Path: <netdev+bounces-106313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565BD915BC5
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20B2281551
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5731805A;
	Tue, 25 Jun 2024 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eXcdxK6/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28E11CAB5
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279573; cv=none; b=EBxHLC8aWuyPIi7g+GEkuNCZJbGplqXhpHe0EpsggbNlBS6V+cSKO/SeauocCIE0+Xf5VhEEUmUgTNCjQ1Br+Jm6tJYTKTYVtkLZGUGBzvzL6TSjglkHGS6YiqSH0R+Wc8HQTcNUK2wrCS7YQikt1JmVXyvwO9/efROx0EXZmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279573; c=relaxed/simple;
	bh=Xaedk2VNk5zuVUP0TDR/0LgZmaETjeJNZFV5DESmJDc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqbVxtRisRGj5preAz2UwUPwOBA1TxZ8NEF/XNaADnjEzhrZMeMAJTIUcH/SmIVz0w5Av8suyhbsjwcRR9O4VCxfIILYQZGVlqYDLlG2mL+B7XmkDBlDBBVJCGU5jPjKA6QHmYYrL+lkzbJeb/GQBZsYb5HjwMtUJvuLXrdiy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eXcdxK6/; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719279571; x=1750815571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UtW40gPydvX0+UTsWOYR000OIfrIKHpB1bj+RQvsMGs=;
  b=eXcdxK6/KKgm45suhxG0aPphlM3BTsKj+PQZLat0R0jEOZrjVCqSYnRO
   nGvSmN2DXaYMTa8hP4zOxbDgKcdxjHEWzfoPlwwTcmq+bRtSa3HC9waRT
   8QTW6P9pjLRxIu9WEhgoy6sbVbLq5q9PMZdv5es6fHFgkwbcQjyp+YIqN
   I=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="99255329"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:39:30 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:55322]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.193:2525] with esmtp (Farcaster)
 id 985438de-728a-4203-b333-d79305bc5bad; Tue, 25 Jun 2024 01:39:30 +0000 (UTC)
X-Farcaster-Flow-ID: 985438de-728a-4203-b333-d79305bc5bad
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:39:29 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:39:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao Shoaib <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 06/11] af_unix: Don't stop recv() at consumed ex-OOB skb.
Date: Mon, 24 Jun 2024 18:36:40 -0700
Message-ID: <20240625013645.45034-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, recv() is stopped at a consumed OOB skb even if a new
OOB skb is queued and we can ignore the old OOB skb.

  >>> from socket import *
  >>> c1, c2 = socket(AF_UNIX, SOCK_STREAM)
  >>> c1.send(b'hellowor', MSG_OOB)
  8
  >>> c2.recv(1, MSG_OOB)  # consume OOB data stays at middle of recvq.
  b'r'
  >>> c1.send(b'ld', MSG_OOB)
  2
  >>> c2.recv(10)          # recv() stops at the old consumed OOB
  b'hellowo'               # should be 'hellowol'

manage_oob() should not stop recv() at the old consumed OOB skb if
there is a new OOB data queued.

Note that TCP behaviour is apparently wrong in this test case because
we can recv() the same OOB data twice.

Without fix:

  #  RUN           msg_oob.no_peek.ex_oob_ahead_break ...
  # msg_oob.c:138:ex_oob_ahead_break:AF_UNIX :hellowo
  # msg_oob.c:139:ex_oob_ahead_break:Expected:hellowol
  # msg_oob.c:141:ex_oob_ahead_break:Expected ret[0] (7) == expected_len (8)
  # ex_oob_ahead_break: Test terminated by assertion
  #          FAIL  msg_oob.no_peek.ex_oob_ahead_break
  not ok 11 msg_oob.no_peek.ex_oob_ahead_break

With fix:

  #  RUN           msg_oob.no_peek.ex_oob_ahead_break ...
  # msg_oob.c:146:ex_oob_ahead_break:AF_UNIX :hellowol
  # msg_oob.c:147:ex_oob_ahead_break:TCP     :helloworl
  #            OK  msg_oob.no_peek.ex_oob_ahead_break
  ok 11 msg_oob.no_peek.ex_oob_ahead_break

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c                            |  2 +-
 tools/testing/selftests/net/af_unix/msg_oob.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b0b97f8d0d09..07f5eaa04b5b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2618,7 +2618,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 
 		spin_lock(&sk->sk_receive_queue.lock);
 
-		if (copied) {
+		if (copied && (!u->oob_skb || skb == u->oob_skb)) {
 			skb = NULL;
 		} else if (flags & MSG_PEEK) {
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 46e92d06b0a3..acf4bd0afe17 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -288,4 +288,20 @@ TEST_F(msg_oob, ex_oob_drop_2)
 	}
 }
 
+TEST_F(msg_oob, ex_oob_ahead_break)
+{
+	sendpair("hello", 5, MSG_OOB);
+	sendpair("wor", 3, MSG_OOB);
+
+	recvpair("r", 1, 1, MSG_OOB);
+
+	sendpair("ld", 2, MSG_OOB);
+
+	tcp_incompliant {
+		recvpair("hellowol", 8, 10, 0);	/* TCP recv()s "helloworl", why "r" ?? */
+	}
+
+	recvpair("d", 1, 1, MSG_OOB);
+}
+
 TEST_HARNESS_MAIN
-- 
2.30.2


