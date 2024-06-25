Return-Path: <netdev+bounces-106310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12943915BBE
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB5A1F2248B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7A8175BF;
	Tue, 25 Jun 2024 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qxRoc9A1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC43182D8
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279499; cv=none; b=uRh18rWagPHQKl2TZFwjGlGk/iw2LwhvcXREM6JCVlT+ooxnIREbocGTEYxcdSW6E/CSg4PHc0+YJKv7StJnjhdInfqopuj6Os79+4u9jjpCkei21pNzrnWCXTilo0bLO5ymy3zDxTTfPPeRZWSRMcfKakBVul4DYQz3FWEYGJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279499; c=relaxed/simple;
	bh=G/EktXldJUD4CFgzoh4X9s0E0sCXcTlDxU+CmgMam0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1C14DmTlKL8JaS18ukKnBFQO3rWMSgPsIySIVshXopji9lXA05J+4AzEUZSoB8/ixEMFTP+xBCMAKihfmLJ/ZkU5TywxMG1GWdHcX3QEBYCC1cfeBY378hmDXebi/uqAq9UuT7kRrLgRViEO2hhlg4KzDZJxZzmk70aiLJmqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qxRoc9A1; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719279498; x=1750815498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EQvf4wqy8TeLJNHL5uWUJYSWQischmfcuL073NzeqjQ=;
  b=qxRoc9A1wUayDaSbH0azTM5zJWV6kK0ozwl8BG6naKC6MEPdBesSe/cz
   BccwRAzh0HTfxjtT4aUXEVQWQ0IAZR5ucxFmN27ESziqlhls9CYANBbbf
   Z9j82U0pLab6am0k4DtkeL8KdKkrZWBs9Xu3/sIvkIKeyi5owLKZ71b+I
   o=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="641436961"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:38:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:40379]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.113:2525] with esmtp (Farcaster)
 id 2a07d43d-8d0c-4454-8d02-6c477d8ea94c; Tue, 25 Jun 2024 01:38:15 +0000 (UTC)
X-Farcaster-Flow-ID: 2a07d43d-8d0c-4454-8d02-6c477d8ea94c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:38:14 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:38:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao Shoaib <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 03/11] af_unix: Stop recv(MSG_PEEK) at consumed OOB skb.
Date: Mon, 24 Jun 2024 18:36:37 -0700
Message-ID: <20240625013645.45034-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

After consuming OOB data, recv() reading the preceding data must break at
the OOB skb regardless of MSG_PEEK.

Currently, MSG_PEEK does not stop recv() for AF_UNIX, and the behaviour is
not compliant with TCP.

  >>> from socket import *
  >>> c1, c2 = socketpair(AF_UNIX)
  >>> c1.send(b'hello', MSG_OOB)
  5
  >>> c1.send(b'world')
  5
  >>> c2.recv(1, MSG_OOB)
  b'o'
  >>> c2.recv(9, MSG_PEEK)  # This should return b'hell'
  b'hellworld'              # even with enough buffer.

Let's fix it by returning NULL for consumed skb and unlinking it only if
MSG_PEEK is not specified.

This patch also adds test cases that add recv(MSG_PEEK) before each recv().

Without fix:

  #  RUN           msg_oob.peek.oob_ahead_break ...
  # msg_oob.c:134:oob_ahead_break:AF_UNIX :hellworld
  # msg_oob.c:135:oob_ahead_break:Expected:hell
  # msg_oob.c:137:oob_ahead_break:Expected ret[0] (9) == expected_len (4)
  # oob_ahead_break: Test terminated by assertion
  #          FAIL  msg_oob.peek.oob_ahead_break
  not ok 13 msg_oob.peek.oob_ahead_break

With fix:

  #  RUN           msg_oob.peek.oob_ahead_break ...
  #            OK  msg_oob.peek.oob_ahead_break
  ok 13 msg_oob.peek.oob_ahead_break

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c                            |  9 ++++---
 tools/testing/selftests/net/af_unix/msg_oob.c | 25 +++++++++++++++++--
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5e695a9a609c..2eaecf9d78a4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2613,9 +2613,12 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 {
 	struct unix_sock *u = unix_sk(sk);
 
-	if (!unix_skb_len(skb) && !(flags & MSG_PEEK)) {
-		skb_unlink(skb, &sk->sk_receive_queue);
-		consume_skb(skb);
+	if (!unix_skb_len(skb)) {
+		if (!(flags & MSG_PEEK)) {
+			skb_unlink(skb, &sk->sk_receive_queue);
+			consume_skb(skb);
+		}
+
 		skb = NULL;
 	} else {
 		struct sk_buff *unlinked_skb = NULL;
diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index d427d39d0806..de8d1fcde883 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -21,6 +21,21 @@ FIXTURE(msg_oob)
 				 */
 };
 
+FIXTURE_VARIANT(msg_oob)
+{
+	bool peek;
+};
+
+FIXTURE_VARIANT_ADD(msg_oob, no_peek)
+{
+	.peek = false,
+};
+
+FIXTURE_VARIANT_ADD(msg_oob, peek)
+{
+	.peek = true
+};
+
 static void create_unix_socketpair(struct __test_metadata *_metadata,
 				   FIXTURE_DATA(msg_oob) *self)
 {
@@ -156,8 +171,14 @@ static void __recvpair(struct __test_metadata *_metadata,
 	__sendpair(_metadata, self, buf, len, flags)
 
 #define recvpair(expected_buf, expected_len, buf_len, flags)		\
-	__recvpair(_metadata, self,					\
-		   expected_buf, expected_len, buf_len, flags)
+	do {								\
+		if (variant->peek)					\
+			__recvpair(_metadata, self,			\
+				   expected_buf, expected_len,		\
+				   buf_len, (flags) | MSG_PEEK);	\
+		__recvpair(_metadata, self,				\
+			   expected_buf, expected_len, buf_len, flags);	\
+	} while (0)
 
 TEST_F(msg_oob, non_oob)
 {
-- 
2.30.2


