Return-Path: <netdev+bounces-102743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B859046F6
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 00:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2ED283173
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E9D7711C;
	Tue, 11 Jun 2024 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hrz3OIWD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4EB15278E
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145164; cv=none; b=cyzNd6eW5nnEAvRzPkMQ5DillXn6rcv8dbIe1/9QlIVMpc6RUFVdarjVVFw2O95Y0OY3Cou2poPSrv8FvysisKWz0vDolKS2ctbch3hQUUmjkRaPM8FOOsV3airFI2MHKDmuEMmpDZQQ33VNGDNTLhWsFIvyGp4QfvT2170mOPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145164; c=relaxed/simple;
	bh=udUm2LC/qzSMBDJthhkDdtTFLieys9e3ldn61HccRI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pjvj8n6HVzw4sAbc4hzg0DYrQRTqA9NcsNkCwPKaFVQC9Q8T+Wj7IzgWZWCwdnEVMgEornJZurqLDrUMBctdvmvZkj+mJvCe2FlDAwZsiHb4yX+FfNbUX9on9JF5SfyQRiGGtSPC7Gims0uRq0UFUG2vTjJDeMSd+LM54A6RKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hrz3OIWD; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718145164; x=1749681164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=anwahdqBQK9r3jBx/O3HLI0cjKUMgXh8B6HzkENYRQM=;
  b=hrz3OIWDCjhDIeUnrxbN5yKLVVCHeNMisO+Z9478tOjvbePZNKdohZlS
   e+cvakdMEtYTwFBISyhA7zGV1FYtyiivQxuoBs9bGWfq85T/RzC3xx+sB
   xC6NdCvAY34uAB2YDXChtLTRXMshu8WppM+KA8bqqLYnRyMPkGXFE798c
   c=;
X-IronPort-AV: E=Sophos;i="6.08,231,1712620800"; 
   d="scan'208";a="732261512"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 22:32:37 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:64026]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.196:2525] with esmtp (Farcaster)
 id c6cd5124-1a9c-4b8e-b1e7-aaffd60bdf59; Tue, 11 Jun 2024 22:32:36 +0000 (UTC)
X-Farcaster-Flow-ID: c6cd5124-1a9c-4b8e-b1e7-aaffd60bdf59
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:32:32 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:32:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 08/11] af_unix: Define locking order for U_RECVQ_LOCK_EMBRYO in unix_collect_skb().
Date: Tue, 11 Jun 2024 15:29:02 -0700
Message-ID: <20240611222905.34695-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240611222905.34695-1-kuniyu@amazon.com>
References: <20240611222905.34695-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
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
index 8d03c5ef61df..8959ee8753d1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -170,6 +170,21 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
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
+	return 0;
+}
 #endif
 
 static unsigned int unix_unbound_hash(struct sock *sk)
@@ -1017,6 +1032,8 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
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


