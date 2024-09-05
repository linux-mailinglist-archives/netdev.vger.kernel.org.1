Return-Path: <netdev+bounces-125664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B7596E344
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEC028AF01
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A8F188939;
	Thu,  5 Sep 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FtDb24jx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173FC4400
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564831; cv=none; b=gEwCtHx9c0kQmJkXS1R0lMGus+sB/HwQGtEPuJ5hlIBte4JPM0g67WE+CHJmv2RrQ0vYH/WTM86PyomJDBPh4h/Per7KihOgQnf17zk+NVI6j/QdA73HX3CIZFy/VihQ/o52BM7ND7W1zJZNCpcqf+h3PB7tgzM8PIQgbRomFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564831; c=relaxed/simple;
	bh=wOGHh3jEzZYsmWWQ/zEWPpdp9zK41EvhoR1SEDiLYXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZFwk3v3bewmiJteAXwXiaXZdvvYAUZc55dDdGkXD3+01CFlzzt2f9sAuqW9nDMRy4q1bvLtLBM6ct867CFxU9R/fhdOvbVXPJ2t+Rmh6AoxHTpTy2qIRpgHF/B1ixuOaCgiyf9jgeXzqG+g4ZYMeNn9G8dHe+h+p5J9waHJJfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FtDb24jx; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725564830; x=1757100830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Nt1zZuJa9NmUopyfNBWfzYut+u4RiPXkSpuEU80OAs=;
  b=FtDb24jxj6wvcyWfWAatkyp4jvbdhOPodRB95ZzXh2Z+xCF1zpeOtMod
   oXQWZrYbAWHWIwGK1fQJ8mC7P9OOBSKfva/BaCHH4DcjhH7TUVb7UVjms
   KU4DqG4ki2jv5T8nJKpKUKJxDcxkxAxJwGfxB71Eq1hg4NT+C6D8KRPB6
   I=;
X-IronPort-AV: E=Sophos;i="6.10,205,1719878400"; 
   d="scan'208";a="123043612"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 19:33:48 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:4137]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.196:2525] with esmtp (Farcaster)
 id 513968b2-acc6-41cf-802b-9622d95a0379; Thu, 5 Sep 2024 19:33:47 +0000 (UTC)
X-Farcaster-Flow-ID: 513968b2-acc6-41cf-802b-9622d95a0379
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Sep 2024 19:33:45 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Sep 2024 19:33:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/4] af_unix: Rename unlinked_skb in manage_oob().
Date: Thu, 5 Sep 2024 12:32:38 -0700
Message-ID: <20240905193240.17565-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240905193240.17565-1-kuniyu@amazon.com>
References: <20240905193240.17565-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When OOB skb has been already consumed, manage_oob() returns the next
skb if exists.  In such a case, we need to fall back to the else branch
below.

Then, we need to keep two skbs and free them later with consume_skb()
and kfree_skb().

Let's rename unlinked_skb accordingly.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 03820454bc72..91d7877a1079 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2654,7 +2654,7 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 				  int flags, int copied)
 {
-	struct sk_buff *unlinked_skb = NULL;
+	struct sk_buff *read_skb = NULL, *unread_skb = NULL;
 	struct unix_sock *u = unix_sk(sk);
 
 	if (!unix_skb_len(skb)) {
@@ -2665,14 +2665,14 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 		} else if (flags & MSG_PEEK) {
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 		} else {
-			unlinked_skb = skb;
+			read_skb = skb;
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
-			__skb_unlink(unlinked_skb, &sk->sk_receive_queue);
+			__skb_unlink(read_skb, &sk->sk_receive_queue);
 		}
 
 		spin_unlock(&sk->sk_receive_queue.lock);
 
-		consume_skb(unlinked_skb);
+		consume_skb(read_skb);
 		return skb;
 	}
 
@@ -2688,7 +2688,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 
 		if (!sock_flag(sk, SOCK_URGINLINE)) {
 			__skb_unlink(skb, &sk->sk_receive_queue);
-			unlinked_skb = skb;
+			unread_skb = skb;
 			skb = skb_peek(&sk->sk_receive_queue);
 		}
 	} else if (!sock_flag(sk, SOCK_URGINLINE)) {
@@ -2698,7 +2698,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 unlock:
 	spin_unlock(&sk->sk_receive_queue.lock);
 
-	kfree_skb(unlinked_skb);
+	kfree_skb(unread_skb);
 
 	return skb;
 }
-- 
2.30.2


