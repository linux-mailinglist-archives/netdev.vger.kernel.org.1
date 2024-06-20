Return-Path: <netdev+bounces-105458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABAB9113F3
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 22:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F63B217EE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F157350E;
	Thu, 20 Jun 2024 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Es2jshCo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD574E3D
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917130; cv=none; b=nWCdrpvCKwi5aqxff13CWTYPqsM3SERlD753pK4MIwoPwKrV8/28C5z4nI4fcpEWW0gywjxXiHB1kvaOw7mrSniRkIZT48JMmpUVwsbaDuooKcajrlcpVjgoLoAqC1pKW1KXKHJrQvrJ9H0Ff5Vi6iDJNkvB2kYDGb2YyNi7EK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917130; c=relaxed/simple;
	bh=IMMXUONo88bfbozKksdsXdqq8kI6YKG0w3+D32DhhjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTOUFzuc7Nn4nsIz4dFBTrNiZnLbJQeJ3DWNV2xfOrW9RL/UDluyUfWUbLgRX2eEP/9ZvadRi9VmvcpKJT/s9ojeTvn7KsgLcTiGflbsqei+gN3Um/rpCJ/DixfJyIDVKYdNJlLXcStptqTru7kWXPg5JENvcTl+jz0vRW8dukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Es2jshCo; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718917129; x=1750453129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FMtfoZtz6DBaLn34IQSpkLseHXJiHAnjjhdWRt9JpVM=;
  b=Es2jshCozW/KDEUrZAkO+MwZfuzn25Eb8WTt6STdaQD6n+LRE6g2sOLI
   qB6paVY2SuzdRzftmdIjP00qwO6xZkExtIhf6z5komhHqmBH09nZbr7WP
   pzXu8AGq05TIoXYcgMxZ9Opa7LIffm0oSIF4LDs9bBqB9nBBMBA315HZ2
   g=;
X-IronPort-AV: E=Sophos;i="6.08,252,1712620800"; 
   d="scan'208";a="734311704"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 20:58:43 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:7756]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.237:2525] with esmtp (Farcaster)
 id 88c310fa-21d9-4e5c-8892-d8b7411d3478; Thu, 20 Jun 2024 20:58:42 +0000 (UTC)
X-Farcaster-Flow-ID: 88c310fa-21d9-4e5c-8892-d8b7411d3478
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 20:58:35 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 20:58:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 05/11] af_unix: Don't acquire unix_state_lock() for sock_i_ino().
Date: Thu, 20 Jun 2024 13:56:17 -0700
Message-ID: <20240620205623.60139-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240620205623.60139-1-kuniyu@amazon.com>
References: <20240620205623.60139-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sk_diag_dump_peer() and sk_diag_dump() call unix_state_lock() for
sock_i_ino() which reads SOCK_INODE(sk->sk_socket)->i_ino, but it's
protected by sk->sk_callback_lock.

Let's remove unnecessary unix_state_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/diag.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/net/unix/diag.c b/net/unix/diag.c
index 937edf4afed4..d2d66727b0da 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -47,9 +47,7 @@ static int sk_diag_dump_peer(struct sock *sk, struct sk_buff *nlskb)
 
 	peer = unix_peer_get(sk);
 	if (peer) {
-		unix_state_lock(peer);
 		ino = sock_i_ino(peer);
-		unix_state_unlock(peer);
 		sock_put(peer);
 
 		return nla_put_u32(nlskb, UNIX_DIAG_PEER, ino);
@@ -180,22 +178,6 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb, struct unix_diag_r
 	return -EMSGSIZE;
 }
 
-static int sk_diag_dump(struct sock *sk, struct sk_buff *skb, struct unix_diag_req *req,
-			struct user_namespace *user_ns,
-			u32 portid, u32 seq, u32 flags)
-{
-	int sk_ino;
-
-	unix_state_lock(sk);
-	sk_ino = sock_i_ino(sk);
-	unix_state_unlock(sk);
-
-	if (!sk_ino)
-		return 0;
-
-	return sk_diag_fill(sk, skb, req, user_ns, portid, seq, flags, sk_ino);
-}
-
 static int unix_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(skb->sk);
@@ -213,14 +195,22 @@ static int unix_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		num = 0;
 		spin_lock(&net->unx.table.locks[slot]);
 		sk_for_each(sk, &net->unx.table.buckets[slot]) {
+			int sk_ino;
+
 			if (num < s_num)
 				goto next;
+
 			if (!(req->udiag_states & (1 << READ_ONCE(sk->sk_state))))
 				goto next;
-			if (sk_diag_dump(sk, skb, req, sk_user_ns(skb->sk),
+
+			sk_ino = sock_i_ino(sk);
+			if (!sk_ino)
+				goto next;
+
+			if (sk_diag_fill(sk, skb, req, sk_user_ns(skb->sk),
 					 NETLINK_CB(cb->skb).portid,
 					 cb->nlh->nlmsg_seq,
-					 NLM_F_MULTI) < 0) {
+					 NLM_F_MULTI, sk_ino) < 0) {
 				spin_unlock(&net->unx.table.locks[slot]);
 				goto done;
 			}
-- 
2.30.2


