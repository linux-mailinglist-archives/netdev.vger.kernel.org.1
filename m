Return-Path: <netdev+bounces-106319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD69E915BCC
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494A11F22358
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE6519BA6;
	Tue, 25 Jun 2024 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jsrgZS2Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C21218EA1
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279673; cv=none; b=MxyVlBmDQaulRE382yykSF0nb18kulzTMtrm5cbuQsLc5tgz4e8o6NVTeXot0pQr8KHNetWmVPZh7Up0Fo9T9I/f0wSdQ9f9JPRxe+ySXJat0tcRGc3HTTuc0THuFUOV6ptpp0YL+dR2Sr9S0ev0brypwCin8PrasGQcS2fyrQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279673; c=relaxed/simple;
	bh=hcAIoUwuXORCDNzCU3xnQdLv1fiKr7vfFxx3O0bLHMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQuPd7QgdDjZ5vGPoKeXgnNzT6HZivJwGgijIxTmC+2p6v0EKnIGFLfQGXUFkqA+G77j7lZerpmbb5hK/TCcxVWoX14/TOvQKxdMu36pkTUH5tYa0HEr5vkB4JO4D3Xey1+ovCjxHBb2+LNMmBg3RMxklNBNa/y16P4/i+NvXZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jsrgZS2Z; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719279671; x=1750815671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+0MPNjaZf578gxOBY2b1jMdTkoaSi2YxgSPx492s1RU=;
  b=jsrgZS2Z48BI+89KAcxeZKRzauzdWAe3JadnGfk6Gm3YG/9qGoJsJd6/
   lzVt0ho+3CkZqJ52DRJXnXWo5Le5gmhYM+rqN9YTUZrNa9th1+2PJ8aKn
   OhV+IsAAMgkgSpxLX8Oj+hilVJJTFTR7brb+i+uv3ln8VcKBB9G8P4sN0
   8=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="99274634"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:41:09 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:24665]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.222:2525] with esmtp (Farcaster)
 id 1a6aa5d4-590c-4fb7-8edd-f72ed0e1435f; Tue, 25 Jun 2024 01:41:09 +0000 (UTC)
X-Farcaster-Flow-ID: 1a6aa5d4-590c-4fb7-8edd-f72ed0e1435f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:41:09 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:41:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao Shoaib <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 10/11] af_unix: Fix wrong ioctl(SIOCATMARK) when consumed OOB skb is at the head.
Date: Mon, 24 Jun 2024 18:36:44 -0700
Message-ID: <20240625013645.45034-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Even if OOB data is recv()ed, ioctl(SIOCATMARK) must return 1 when the
OOB skb is at the head of the receive queue and no new OOB data is queued.

Without fix:

  #  RUN           msg_oob.no_peek.oob ...
  # msg_oob.c:305:oob:Expected answ[0] (0) == oob_head (1)
  # oob: Test terminated by assertion
  #          FAIL  msg_oob.no_peek.oob
  not ok 2 msg_oob.no_peek.oob

With fix:

  #  RUN           msg_oob.no_peek.oob ...
  #            OK  msg_oob.no_peek.oob
  ok 2 msg_oob.no_peek.oob

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c                            | 15 +++-
 tools/testing/selftests/net/af_unix/msg_oob.c | 68 +++++++++++++++++++
 2 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 07f5eaa04b5b..142f56770b77 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3107,12 +3107,23 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 	case SIOCATMARK:
 		{
+			struct unix_sock *u = unix_sk(sk);
 			struct sk_buff *skb;
 			int answ = 0;
 
+			mutex_lock(&u->iolock);
+
 			skb = skb_peek(&sk->sk_receive_queue);
-			if (skb && skb == READ_ONCE(unix_sk(sk)->oob_skb))
-				answ = 1;
+			if (skb) {
+				struct sk_buff *oob_skb = READ_ONCE(u->oob_skb);
+
+				if (skb == oob_skb ||
+				    (!oob_skb && !unix_skb_len(skb)))
+					answ = 1;
+			}
+
+			mutex_unlock(&u->iolock);
+
 			err = put_user(answ, (int __user *)arg);
 		}
 		break;
diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 28b09b36a2f1..2d0024329437 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -288,6 +288,26 @@ static void __setinlinepair(struct __test_metadata *_metadata,
 	}
 }
 
+static void __siocatmarkpair(struct __test_metadata *_metadata,
+			     FIXTURE_DATA(msg_oob) *self,
+			     bool oob_head)
+{
+	int answ[2] = {};
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		int ret;
+
+		ret = ioctl(self->fd[i * 2 + 1], SIOCATMARK, &answ[i]);
+		ASSERT_EQ(ret, 0);
+	}
+
+	ASSERT_EQ(answ[0], oob_head);
+
+	if (self->tcp_compliant)
+		ASSERT_EQ(answ[0], answ[1]);
+}
+
 #define sendpair(buf, len, flags)					\
 	__sendpair(_metadata, self, buf, len, flags)
 
@@ -304,6 +324,9 @@ static void __setinlinepair(struct __test_metadata *_metadata,
 #define epollpair(oob_remaining)					\
 	__epollpair(_metadata, self, oob_remaining)
 
+#define siocatmarkpair(oob_head)					\
+	__siocatmarkpair(_metadata, self, oob_head)
+
 #define setinlinepair()							\
 	__setinlinepair(_metadata, self)
 
@@ -325,9 +348,11 @@ TEST_F(msg_oob, oob)
 {
 	sendpair("x", 1, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(true);
 
 	recvpair("x", 1, 1, MSG_OOB);
 	epollpair(false);
+	siocatmarkpair(true);
 }
 
 TEST_F(msg_oob, oob_drop)
@@ -481,18 +506,40 @@ TEST_F(msg_oob, ex_oob_ahead_break)
 	epollpair(false);
 }
 
+TEST_F(msg_oob, ex_oob_siocatmark)
+{
+	sendpair("hello", 5, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(false);
+
+	recvpair("o", 1, 1, MSG_OOB);
+	epollpair(false);
+	siocatmarkpair(false);
+
+	sendpair("world", 5, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(false);
+
+	recvpair("hell", 4, 4, 0);		/* Intentionally stop at ex-OOB. */
+	epollpair(true);
+	siocatmarkpair(false);
+}
+
 TEST_F(msg_oob, inline_oob)
 {
 	setinlinepair();
 
 	sendpair("x", 1, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(true);
 
 	recvpair("", -EINVAL, 1, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(true);
 
 	recvpair("x", 1, 1, 0);
 	epollpair(false);
+	siocatmarkpair(false);
 }
 
 TEST_F(msg_oob, inline_oob_break)
@@ -591,4 +638,25 @@ TEST_F(msg_oob, inline_ex_oob_drop)
 	}
 }
 
+TEST_F(msg_oob, inline_ex_oob_siocatmark)
+{
+	sendpair("hello", 5, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(false);
+
+	recvpair("o", 1, 1, MSG_OOB);
+	epollpair(false);
+	siocatmarkpair(false);
+
+	setinlinepair();
+
+	sendpair("world", 5, MSG_OOB);
+	epollpair(true);
+	siocatmarkpair(false);
+
+	recvpair("hell", 4, 4, 0);		/* Intentionally stop at ex-OOB. */
+	epollpair(true);
+	siocatmarkpair(false);
+}
+
 TEST_HARNESS_MAIN
-- 
2.30.2


