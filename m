Return-Path: <netdev+bounces-105461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A38CB9113FB
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 22:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CAF9B21213
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C976034;
	Thu, 20 Jun 2024 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Yy7nfwkl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8159B65D
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917194; cv=none; b=a1ymsHARmLOOqgupGay4Jj6JyHtJgN0s7UxZbr5VQYnrlj+JGSpNBQmc3C1nANw9/BZzLNzAEuf7/O5oLjT4VaSNvmbfs2AzhXCxPKGnBx3Bfi76jJwQIzgzqS+wosfQyAVLokJyeXISDKTCD2H32vPidYD/WFFIsLx2iJcOvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917194; c=relaxed/simple;
	bh=hsHWj+NcexK9Fc13vXoTteOhKpzRk/mOp830nzaV1E4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUoWd0b12MAFB1waLP5NYofxJ2InMCDktIcKPpRttL+GxyQZ4K3y/4pjQP7ikY2HaT1t1+/2L1ZCPEdTaWcZy0aXYg2N7bt72ihYukM6NJfzAJdBldsh+0Egudn+6I2XF/uybAHMiHH2Fv5z/zh/vMG9inBRWVW52PcMotvDdpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Yy7nfwkl; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718917192; x=1750453192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F71af1BFR2E1f0MNtZTa4G7D06i+oGkaFnGVcVZIC7w=;
  b=Yy7nfwklk0Ks8URH6ZMI3TjB0tTMtVO5e/Twi1UsUE+hP5dNadRO15wS
   8zvF0NMzG3Yrw0uAYvQXykzhEv2nm6gUdKr0UIL6BuHC7IPSJQFkQ6NAb
   g5SlRMX3iFQKt5WCaiWnyB/YH/sRezWoiN9muGdxHMyYRHb5VbLorxAZ7
   E=;
X-IronPort-AV: E=Sophos;i="6.08,252,1712620800"; 
   d="scan'208";a="98286012"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 20:59:49 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:10634]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.61:2525] with esmtp (Farcaster)
 id e89bf957-e242-4643-9998-fb539ab9d8f1; Thu, 20 Jun 2024 20:59:49 +0000 (UTC)
X-Farcaster-Flow-ID: e89bf957-e242-4643-9998-fb539ab9d8f1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 20:59:48 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 20:59:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 08/11] af_unix: Define locking order for U_RECVQ_LOCK_EMBRYO in unix_collect_skb().
Date: Thu, 20 Jun 2024 13:56:20 -0700
Message-ID: <20240620205623.60139-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

While GC is cleaning up cyclic references by SCM_RIGHTS,
unix_collect_skb() collects skb in the socket's recvq.

If the socket is TCP_LISTEN, we need to collect skb in the
embryo's queue.  Then, both the listener's recvq lock and
the embroy's one are held.

The locking is always done in the listener -> embryo order.

Let's define it as unix_recvq_lock_cmp_fn() instead of using
spin_lock_nested().

Note that the reverse order is defined for consistency.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 21 +++++++++++++++++++++
 net/unix/garbage.c |  8 +-------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a092d6999ae0..89675879038d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -181,6 +181,25 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
 	/* unix_state_double_lock(): ascending address order. */
 	return cmp_ptr(a, b);
 }
+
+static int unix_recvq_lock_cmp_fn(const struct lockdep_map *_a,
+				  const struct lockdep_map *_b)
+{
+	const struct sock *a, *b;
+
+	a = container_of(_a, struct sock, sk_receive_queue.lock.dep_map);
+	b = container_of(_b, struct sock, sk_receive_queue.lock.dep_map);
+
+	/* unix_collect_skb(): listener -> embryo order. */
+	if (a->sk_state == TCP_LISTEN && unix_sk(b)->listener == a)
+		return -1;
+
+	/* Should never happen.  Just to be symmetric. */
+	if (b->sk_state == TCP_LISTEN && unix_sk(a)->listener == b)
+		return 1;
+
+	return 0;
+}
 #endif
 
 static unsigned int unix_unbound_hash(struct sock *sk)
@@ -1028,6 +1047,8 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_write_space	= unix_write_space;
 	sk->sk_max_ack_backlog	= READ_ONCE(net->unx.sysctl_max_dgram_qlen);
 	sk->sk_destruct		= unix_sock_destructor;
+	lock_set_cmp_fn(&sk->sk_receive_queue.lock, unix_recvq_lock_cmp_fn, NULL);
+
 	u = unix_sk(sk);
 	u->listener = NULL;
 	u->vertex = NULL;
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index dfe94a90ece4..eb8aa5171a68 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -337,11 +337,6 @@ static bool unix_vertex_dead(struct unix_vertex *vertex)
 	return true;
 }
 
-enum unix_recv_queue_lock_class {
-	U_RECVQ_LOCK_NORMAL,
-	U_RECVQ_LOCK_EMBRYO,
-};
-
 static void unix_collect_queue(struct unix_sock *u, struct sk_buff_head *hitlist)
 {
 	skb_queue_splice_init(&u->sk.sk_receive_queue, hitlist);
@@ -375,8 +370,7 @@ static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist
 			skb_queue_walk(queue, skb) {
 				struct sk_buff_head *embryo_queue = &skb->sk->sk_receive_queue;
 
-				/* listener -> embryo order, the inversion never happens. */
-				spin_lock_nested(&embryo_queue->lock, U_RECVQ_LOCK_EMBRYO);
+				spin_lock(&embryo_queue->lock);
 				unix_collect_queue(unix_sk(skb->sk), hitlist);
 				spin_unlock(&embryo_queue->lock);
 			}
-- 
2.30.2


