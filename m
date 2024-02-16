Return-Path: <netdev+bounces-72533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14458587AD
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B8F1F21B19
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82F613AA4D;
	Fri, 16 Feb 2024 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iqLo3002"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A013AA5A
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117717; cv=none; b=SJKGdO0FCYeSufovzSdq3F5oP2iGCozrpFsmEGsheI+BhkxmRSA7DpfyEkHt4RcK99GGDyvtquDkX7dPnZoCn/f76SPBor3tWMQpsLfzNgLbHwZoZkdQy7tChbnseRA7UNXbYMeMzUZs+KXRYZUOFF8h4KeC14Eg2ljPlJ5t9+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117717; c=relaxed/simple;
	bh=hCwqPBAuItf4DGLHSkCWqIzrHlq4ZyMsl/CC1Grr6Es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a404MdckuqEBnJle+bgAbDRsfBPykc1MZLw5BdRuea4ntzhI5VEA3Aa5aOkBvRuR+99+n/SIWTGt4lkidLrsHaOR6JMQ0P/aSTSlQQM018V76VA8WrBnUHwyxDXgCc5YEpd/CXnPJgtVZGgDNim0XBlqtKZkrwz/biwKodbChpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iqLo3002; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708117717; x=1739653717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xZODWR7XawlFzGOsIJnx2pbhkDQKUJl7Qvt31h8EWZA=;
  b=iqLo3002rYutPxIQrQdzbZd0Rf8LrUzsrWq2pbpxRheybGzzA2YPXTDk
   kavw7iWW3zDybRrr2xGAUDOZZX74/UTJI2beEviuzbkS28Zl3LZqjbinv
   226oOP+50cNGFINYz6qcqoTufOEVKHhNubmixbgBEB1UQPHhvJ/Z6kEto
   0=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="397645850"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 21:08:30 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:9323]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.119:2525] with esmtp (Farcaster)
 id 00415b02-c0ab-45f1-b51c-1abbb98a36d3; Fri, 16 Feb 2024 21:08:29 +0000 (UTC)
X-Farcaster-Flow-ID: 00415b02-c0ab-45f1-b51c-1abbb98a36d3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:08:29 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:08:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 05/14] af_unix: Fix up unix_edge.successor for embryo socket.
Date: Fri, 16 Feb 2024 13:05:47 -0800
Message-ID: <20240216210556.65913-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240216210556.65913-1-kuniyu@amazon.com>
References: <20240216210556.65913-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

To garbage collect inflight AF_UNIX sockets, we must define the
cyclic reference appropriately.  This is a bit tricky if the loop
consists of embryo sockets.

Suppose that the fd of AF_UNIX socket A is passed to D and the fd B
to C and that C and D are embryo sockets of A and B, respectively.
It may appear that there are two separate graphs, A (-> D) and
B (-> C), but this is not correct.

     A --. .-- B
          X
     C <-' `-> D

Now, D holds A's refcount, and C has B's refcount, so unix_release()
will never be called for A and B when we close() them.  However, no
one can call close() for D and C to free skbs holding refcounts of A
and B because C/D is in A/B's receive queue, which should have been
purged by unix_release() for A and B.

So, here's a new type of cyclic reference.  When a fd of an AF_UNIX
socket is passed to an embryo socket, the reference is indirectly
held by its parent listening socket.

  .-> A                            .-> B
  |   `- sk_receive_queue          |   `- sk_receive_queue
  |      `- skb                    |      `- skb
  |         `- sk == C             |         `- sk == D
  |            `- sk_receive_queue |           `- sk_receive_queue
  |               `- skb +---------'               `- skb +--.
  |                                                          |
  `----------------------------------------------------------'

Technically, the graph must be denoted as A <-> B instead of A (-> D)
and B (-> C) to find such a cyclic reference without touching each
socket's receive queue.

  .-> A --. .-- B <-.
  |        X        |  ==  A <-> B
  `-- C <-' `-> D --'

We apply this fixup in unix_add_edges() if the receiver is an embryo
socket.

We also link such edges to the embryo socket using another list_head
field, embryo_entry, because we need to restore the original separate
graphs A (-> D) and B (-> C) in unix_update_edges() once accept() is
called.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  2 ++
 net/unix/af_unix.c    |  2 +-
 net/unix/garbage.c    | 27 ++++++++++++++++++++++++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 438d2a18ba2e..2d8e93775e61 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -25,6 +25,7 @@ void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_init_vertex(struct unix_sock *u);
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
 void unix_del_edges(struct scm_fp_list *fpl);
+void unix_update_edges(struct unix_sock *receiver);
 int unix_alloc_edges(struct scm_fp_list *fpl);
 void unix_free_edges(struct scm_fp_list *fpl);
 void unix_gc(void);
@@ -40,6 +41,7 @@ struct unix_edge {
 	struct unix_vertex *predecessor;
 	struct unix_vertex *successor;
 	struct list_head entry;
+	struct list_head embryo_entry;
 };
 
 struct sock *unix_peer_get(struct sock *sk);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1ebc3c15f972..dab5d8d96e87 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1734,7 +1734,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 	}
 
 	tsk = skb->sk;
-	unix_sk(tsk)->listener = NULL;
+	unix_update_edges(unix_sk(tsk));
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 353416f38738..97a43f8ec5a5 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -114,10 +114,16 @@ static LIST_HEAD(unix_unvisited_vertices);
 
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 {
+	struct unix_vertex *successor;
 	int i = 0, j = 0;
 
 	spin_lock(&unix_gc_lock);
 
+	if (receiver->listener)
+		successor = &unix_sk(receiver->listener)->vertex;
+	else
+		successor = &receiver->vertex;
+
 	while (i < fpl->count_unix) {
 		struct unix_sock *inflight = unix_get_socket(fpl->fp[j++]);
 		struct unix_edge *edge;
@@ -127,12 +133,15 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 
 		edge = fpl->edges + i++;
 		edge->predecessor = &inflight->vertex;
-		edge->successor = &receiver->vertex;
+		edge->successor = successor;
 
 		if (!edge->predecessor->out_degree++)
 			list_add_tail(&edge->predecessor->entry, &unix_unvisited_vertices);
 
 		list_add_tail(&edge->entry, &edge->predecessor->edges);
+
+		if (receiver->listener)
+			list_add_tail(&edge->embryo_entry, &receiver->vertex.edges);
 	}
 
 	spin_unlock(&unix_gc_lock);
@@ -160,6 +169,22 @@ void unix_del_edges(struct scm_fp_list *fpl)
 	fpl->inflight = false;
 }
 
+void unix_update_edges(struct unix_sock *receiver)
+{
+	struct unix_edge *edge;
+
+	spin_lock(&unix_gc_lock);
+
+	list_for_each_entry(edge, &receiver->vertex.edges, embryo_entry)
+		edge->successor = &receiver->vertex;
+
+	list_del_init(&receiver->vertex.edges);
+
+	receiver->listener = NULL;
+
+	spin_unlock(&unix_gc_lock);
+}
+
 int unix_alloc_edges(struct scm_fp_list *fpl)
 {
 	if (!fpl->count_unix)
-- 
2.30.2


