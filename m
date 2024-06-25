Return-Path: <netdev+bounces-106311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CD3915BBF
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2711C213A7
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB171805A;
	Tue, 25 Jun 2024 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BCVujZ17"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352EB175BF
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279530; cv=none; b=ePAYSSLNqdUlXS38x42HTjw9ehVrpqQt0YI627ItboIqMiNXOmCWu9ELGMJt7mc7q3v8s6YyiZc+qoSrXgV8TDFdsGQAGLG3nvIjrtEzTuZLbwx8wCG66oJ0xKhNlS9f0tnP/HSkpG61C8CHG0q5/ODCNqR4cyk4gUpEBAAkZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279530; c=relaxed/simple;
	bh=R5GMoPncR6lKZfGMkonfKUC17Bb6YtFL/GPwPoIyDAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1p6sUSLYpkG6tFMZlvPDiupfWTiVRcGvGaC6lDE/tHxV2emYcsanAfbjHhuyEtlVJGu1tgTsZsoOWpYChTCOUyNqzuJvYwvXJlacZ3kzKGVaQwCxuqAY+KQKO57m5ZlIlLjPCra3ztzxG5NMDBmFQLju3f/RTZrpoYMtLR5474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BCVujZ17; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719279529; x=1750815529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fYBZg8gbnhTObb3Gnz1KwhESbOkrpO+wAYqmjCM/46U=;
  b=BCVujZ17t/kUcIEerWKNQ9nS4Bk42G7zC7P7xS0wHAEa6rWKd75bUwSm
   9Hjd4HekrxbX2W9NYrM7TQLk0+PlsP9MA97Z/O6AiGiDfOMQMzsZBWFaX
   erIlkAMsu4Ntgx0ZdwqigmMhsxqHSx9y3SyMnAnWGe1TYIuW0qOw+dJEZ
   8=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="99255108"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:38:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:60277]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.113:2525] with esmtp (Farcaster)
 id 7bdb4383-c405-4ce3-b5bb-33a986cda024; Tue, 25 Jun 2024 01:38:45 +0000 (UTC)
X-Farcaster-Flow-ID: 7bdb4383-c405-4ce3-b5bb-33a986cda024
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:38:39 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:38:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao Shoaib <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 04/11] af_unix: Don't stop recv(MSG_DONTWAIT) if consumed OOB skb is at the head.
Date: Mon, 24 Jun 2024 18:36:38 -0700
Message-ID: <20240625013645.45034-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Let's say a socket send()s "hello" with MSG_OOB and "world" without flags,

  >>> from socket import *
  >>> c1, c2 = socketpair(AF_UNIX)
  >>> c1.send(b'hello', MSG_OOB)
  5
  >>> c1.send(b'world')
  5

and its peer recv()s "hell" and "o".

  >>> c2.recv(10)
  b'hell'
  >>> c2.recv(1, MSG_OOB)
  b'o'

Now the consumed OOB skb stays at the head of recvq to return a correct
value for ioctl(SIOCATMARK), which is broken now and fixed by a later
patch.

Then, if peer issues recv() with MSG_DONTWAIT, manage_oob() returns NULL,
so recv() ends up with -EAGAIN.

  >>> c2.setblocking(False)  # This causes -EAGAIN even with available data
  >>> c2.recv(5)
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  BlockingIOError: [Errno 11] Resource temporarily unavailable

However, next recv() will return the following available data, "world".

  >>> c2.recv(5)
  b'world'

When the consumed OOB skb is at the head of the queue, we need to fetch
the next skb to fix the weird behaviour.

Note that the issue does not happen without MSG_DONTWAIT because we can
retry after manage_oob().

This patch also adds a test case that covers the issue.

Without fix:

  #  RUN           msg_oob.no_peek.ex_oob_break ...
  # msg_oob.c:134:ex_oob_break:AF_UNIX :Resource temporarily unavailable
  # msg_oob.c:135:ex_oob_break:Expected:ld
  # msg_oob.c:137:ex_oob_break:Expected ret[0] (-1) == expected_len (2)
  # ex_oob_break: Test terminated by assertion
  #          FAIL  msg_oob.no_peek.ex_oob_break
  not ok 8 msg_oob.no_peek.ex_oob_break

With fix:

  #  RUN           msg_oob.no_peek.ex_oob_break ...
  #            OK  msg_oob.no_peek.ex_oob_break
  ok 8 msg_oob.no_peek.ex_oob_break

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c                            | 19 +++++++++++++++----
 tools/testing/selftests/net/af_unix/msg_oob.c | 11 +++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 2eaecf9d78a4..b0b97f8d0d09 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2614,12 +2614,23 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 	struct unix_sock *u = unix_sk(sk);
 
 	if (!unix_skb_len(skb)) {
-		if (!(flags & MSG_PEEK)) {
-			skb_unlink(skb, &sk->sk_receive_queue);
-			consume_skb(skb);
+		struct sk_buff *unlinked_skb = NULL;
+
+		spin_lock(&sk->sk_receive_queue.lock);
+
+		if (copied) {
+			skb = NULL;
+		} else if (flags & MSG_PEEK) {
+			skb = skb_peek_next(skb, &sk->sk_receive_queue);
+		} else {
+			unlinked_skb = skb;
+			skb = skb_peek_next(skb, &sk->sk_receive_queue);
+			__skb_unlink(unlinked_skb, &sk->sk_receive_queue);
 		}
 
-		skb = NULL;
+		spin_unlock(&sk->sk_receive_queue.lock);
+
+		consume_skb(unlinked_skb);
 	} else {
 		struct sk_buff *unlinked_skb = NULL;
 
diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index de8d1fcde883..b5226ccec3ec 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -238,4 +238,15 @@ TEST_F(msg_oob, oob_break_drop)
 	recvpair("", -EINVAL, 1, MSG_OOB);
 }
 
+TEST_F(msg_oob, ex_oob_break)
+{
+	sendpair("hello", 5, MSG_OOB);
+	sendpair("wor", 3, MSG_OOB);
+	sendpair("ld", 2, 0);
+
+	recvpair("hellowo", 7, 10, 0);		/* Break at OOB but not at ex-OOB. */
+	recvpair("r", 1, 1, MSG_OOB);
+	recvpair("ld", 2, 2, 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.30.2


