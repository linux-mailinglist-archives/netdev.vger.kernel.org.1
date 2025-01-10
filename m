Return-Path: <netdev+bounces-157031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04273A08C3A
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41603AA538
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EF920767F;
	Fri, 10 Jan 2025 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gwi9DenA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01320C46E
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501382; cv=none; b=tDSRI2Cq3XiATDW+ZmkJTw4EzmaWdZCF2+ioGWVsKuoR8IrRrRsIamGlZy8Gf2ICEa7Q6jHTPqU/CfPwdzuqhfS46hS96Jr/ruRxVqc0XqzuZNKRTixsfVA56xjXkcUS2EJy7M3MzSVjVXiekl/BKxth5I4R091XGZc1mosWb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501382; c=relaxed/simple;
	bh=8h8sjxSYvc03RuT3+nX5S1XuL4N5VDBMjfLQggkcSg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZDSKNMV+QGEAiLePZwJc9KyXBdzvV0+vIIbx1dfMtPjjiw6m8TYfbfk7u5m+w68/4m944S5+e7911s+DyzBaN4FQFyS/v1VOI6h7mAnwUnq1V2KKiqh8BGSl+UGxGzV3ZNV34v8mXnGSxUDYG7o9Ma0rYj330GQKDv3Zuyfy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gwi9DenA; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736501381; x=1768037381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=80uBm5XK40kyyRdwYeGa58p6tHnZvw7FqLJ+2n5VezQ=;
  b=gwi9DenAiOoYWVWUpgNtgDaOrRY4ioNitPGn4itPC4B1NAxFsuPPluTd
   JSuGFp9KfskH6Q9qz5om/9v89oaIhN1Y/C/TdEbjPLxfXKNMpkMfs780s
   Fx04hW9kX73x2VVml8QGPlLXMPaWwfM5wVgPC9Aunt/Zd3WzfjhfyUKzm
   g=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="13335074"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:29:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:51011]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.134:2525] with esmtp (Farcaster)
 id bf29fd59-7e2a-44cc-9f7c-b33f8b2d4a00; Fri, 10 Jan 2025 09:29:38 +0000 (UTC)
X-Farcaster-Flow-ID: bf29fd59-7e2a-44cc-9f7c-b33f8b2d4a00
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:29:37 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:29:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 06/12] af_unix: Reuse out_pipe label in unix_stream_sendmsg().
Date: Fri, 10 Jan 2025 18:26:35 +0900
Message-ID: <20250110092641.85905-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250110092641.85905-1-kuniyu@amazon.com>
References: <20250110092641.85905-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This is a follow-up of commit d460b04bc452 ("af_unix: Clean up
error paths in unix_stream_sendmsg().").

If we initialise skb with NULL in unix_stream_sendmsg(), we can
reuse the existing out_pipe label for the SEND_SHUTDOWN check.

Let's rename do it and adjust the existing label as out_pipe_lock.

While at it, size and data_len are moved to the while loop scope.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b190ea8b8e9d..6505eeab9957 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2250,13 +2250,11 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			       size_t len)
 {
 	struct sock *sk = sock->sk;
+	struct sk_buff *skb = NULL;
 	struct sock *other = NULL;
-	int err, size;
-	struct sk_buff *skb;
-	int sent = 0;
 	struct scm_cookie scm;
 	bool fds_sent = false;
-	int data_len;
+	int err, sent = 0;
 
 	err = scm_send(sock, msg, &scm, false);
 	if (err < 0)
@@ -2285,16 +2283,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		}
 	}
 
-	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) {
-		if (!(msg->msg_flags & MSG_NOSIGNAL))
-			send_sig(SIGPIPE, current, 0);
-
-		err = -EPIPE;
-		goto out_err;
-	}
+	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
+		goto out_pipe;
 
 	while (sent < len) {
-		size = len - sent;
+		int size = len - sent;
+		int data_len;
 
 		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
 			skb = sock_alloc_send_pskb(sk, 0, 0,
@@ -2347,7 +2341,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 		if (sock_flag(other, SOCK_DEAD) ||
 		    (other->sk_shutdown & RCV_SHUTDOWN))
-			goto out_pipe;
+			goto out_pipe_unlock;
 
 		maybe_add_creds(skb, sock, other);
 		scm_stat_add(other, skb);
@@ -2370,8 +2364,9 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	return sent;
 
-out_pipe:
+out_pipe_unlock:
 	unix_state_unlock(other);
+out_pipe:
 	if (!sent && !(msg->msg_flags & MSG_NOSIGNAL))
 		send_sig(SIGPIPE, current, 0);
 	err = -EPIPE;
-- 
2.39.5 (Apple Git-154)


