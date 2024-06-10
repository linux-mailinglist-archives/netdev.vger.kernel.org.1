Return-Path: <netdev+bounces-102377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9FA902BD0
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D67A1C20E68
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF35715099A;
	Mon, 10 Jun 2024 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lYZMvabs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F30150993
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718059118; cv=none; b=bJGdGEGXLTqu2jQDb2J7T4X+5nC492kuM+mpVXVximA/7XngnrKkJoo7Kw+vqUmPrZKAe69U7lKoguQcLPOhjYdgcVvahVv2QV38cdFUNb+j3hUTTPEQQJ363M9JUnnsYGNRrsuTGl3jM5SoA9ryxBRooe+6/8dXVC1Uc7XMWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718059118; c=relaxed/simple;
	bh=CRv/nE9T8vZcqoMTeCGORlSleTQ4ouJkaBdsBkA7pXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/rcOUfUiUo+6KxG2/fx+FY6zafdKX/eHxMEvRn3bSiw9a3ymW9G6iI5wlV/sBJA9XoBoBZWFcyNP9DFLsT1ItLnd63NpFoEvEg/+p4nNCrDOA/sgbBoxUGjsD3PtruiIAAvzSiyBF9l4HhqHM9JazUJUhYVADaGcPqdqUwi7Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lYZMvabs; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718059118; x=1749595118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0l8gKxu7GLr8aBuLIVqxLFNM2gu+c4sj4uKtpYn8KhE=;
  b=lYZMvabsGXr1ybbDtT5vGp2qBcqmdAMDR3t9mF66JFt0LZcavLaPnoZX
   ftV280ZePlKI17tFTcc1edRqPYXmHpdLG1a0zlqpKbBbKV5kB5V1PE2oa
   bwf5+Gu/qplPPX8noOUd0NGPQpQEm/7iFNc+KnyL+afXZeKzWhqsMNu/d
   o=;
X-IronPort-AV: E=Sophos;i="6.08,228,1712620800"; 
   d="scan'208";a="4088231"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:38:36 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:50934]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.23:2525] with esmtp (Farcaster)
 id bcc697db-4487-45d2-aab4-645e293e53d6; Mon, 10 Jun 2024 22:38:34 +0000 (UTC)
X-Farcaster-Flow-ID: bcc697db-4487-45d2-aab4-645e293e53d6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:38:30 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:38:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 08/11] af_unix: Remove U_RECVQ_LOCK_EMBRYO.
Date: Mon, 10 Jun 2024 15:34:58 -0700
Message-ID: <20240610223501.73191-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610223501.73191-1-kuniyu@amazon.com>
References: <20240610223501.73191-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

While GC is cleaning up cyclic references by SCM_RIGHTS,
unix_collect_skb() collects skb in the socket's recvq.

If the socket is TCP_LISTEN, we need to collect skb in the
embryo's queue.  Then, both the listener's recvq lock and
the embroy's one are held.

The locking is always done in the listener -> embryo order.

Let's define it as unix_recvq_lock_cmp_fn() instead of using
spin_lock_nested().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 17 +++++++++++++++++
 net/unix/garbage.c |  8 +-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7402ffd999ce..1869830e8d60 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -168,6 +168,21 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
 	/* unix_state_double_lock(): ascending address order. */
 	return a < b ? -1 : 0;
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
+	return 0;
+}
 #endif
 
 static unsigned int unix_unbound_hash(struct sock *sk)
@@ -1015,6 +1030,8 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
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


