Return-Path: <netdev+bounces-103723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F89909337
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F76D287D00
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346A91A3BA1;
	Fri, 14 Jun 2024 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nrr2+BVK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867D41A2549
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395856; cv=none; b=saPO5pV3rxC9/d0/CDFkJ6p7ESGcqD/IFxNzByZMgvvXS3qFAnBQZsO+BoFh2NoCrjycA9N3TLRjUy62xZpVc8o+N79WQJTHYur4QkcVdQawFm2fla07q/l6TGJFRONAMg5V+aRhHGR8bJNiPgoJZFmFujjEghkeY8Dn5NKG9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395856; c=relaxed/simple;
	bh=3XzUQFIgZLyJInCVl3arIYPHSEZ8MszMe/nnaSrfTXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Adjtz9hLqqLpcN/TddUcbY41cy/NojkwN9siUgnEVCL0jzYLwSSLBUGhq7+a1zLBVC4c1lSJx2zZyIeLoeCCBd5PRyipsvQ9XNfi9CSvohM1Vj6ns74zstKLswoDUOvS/rFzYhTB6fVu6ToPxm7dR/1T1PTTuSyGIiyBEKzhYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nrr2+BVK; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718395854; x=1749931854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hi4eE1pBj4QgRg5N1Jj961UvVNbJpxC8UbOzajxnvT4=;
  b=nrr2+BVKUTvPHWclPwOt+WqKDy4UdvK8vExZvGIIav+l+ygmLewJWI8a
   8HZGzrxLx92fsEHMWHHN3VZkkwgNt8Ycwypd+QOP+0IYBxHlWe4TjudxC
   bMSy9H/hpVR6kbkwtiiJxfiqDTKJjBHxCGHinYNqcwwl9creYU+/Pq/Xc
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,238,1712620800"; 
   d="scan'208";a="407907009"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 20:10:53 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:46457]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.96:2525] with esmtp (Farcaster)
 id 61532a0a-c9ab-4720-a6cd-65e8b9e36c38; Fri, 14 Jun 2024 20:10:52 +0000 (UTC)
X-Farcaster-Flow-ID: 61532a0a-c9ab-4720-a6cd-65e8b9e36c38
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:10:52 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:10:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 08/11] af_unix: Define locking order for U_RECVQ_LOCK_EMBRYO in unix_collect_skb().
Date: Fri, 14 Jun 2024 13:07:12 -0700
Message-ID: <20240614200715.93150-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240614200715.93150-1-kuniyu@amazon.com>
References: <20240614200715.93150-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
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
 net/unix/af_unix.c | 20 ++++++++++++++++++++
 net/unix/garbage.c |  8 +-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5d2728e33f3f..9bbd112926ad 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -170,6 +170,24 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
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
+	if (b->sk_state == TCP_LISTEN && unix_sk(a)->listener == b)
+		return 1;
+
+	return 0;
+}
 #endif
 
 static unsigned int unix_unbound_hash(struct sock *sk)
@@ -1017,6 +1035,8 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
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


