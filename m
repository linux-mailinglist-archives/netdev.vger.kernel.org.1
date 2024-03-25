Return-Path: <netdev+bounces-81782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08BB88B166
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676FA2C1E84
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2135810D;
	Mon, 25 Mar 2024 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v3CtLKWe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702BF12B87
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398622; cv=none; b=iqNPA5IkC9nPx2ASIW2Ec8wVS3vlnSsJ3d7sNhuhP4CDkeBvbg0PFEEdvrfnclerPJPUFfDv+j5UCQkO1qx05iNddwYfJ15JsIAld0JojYJb2BeiQ5IIbRpsRlI6GTYiv5MfQ2JAD6Dktp1aq+FppQxNbPCYCt4CpluV/kFaSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398622; c=relaxed/simple;
	bh=SmVsW/8w8U8lz79iK/8D4EdYvZSRaMxqJLCsp75zjoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5CS7bjLojqUV2AJvT1rYZcmEqULpgaX5U6WcvwIPtPH/HNRmYPJmR1XD4TfriO6Z/8NNaTnoha2EjVHMBFtYZO+VF3YCGMxp6xR/gWIdaIwJLxh95yOZ2GQN+dNRlkKGRkkfNimuKBtztadDNQYMMUct0JhuAJ22qj1gU0yurU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=v3CtLKWe; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711398621; x=1742934621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5FQSQC4F5dYzrZG+44maqHNSw3qhe6NgmSvkvTbI0s0=;
  b=v3CtLKWe6WLvTPsVa2aQdeNQXqFNmiYg6HIUAPIrWCefsSgEnXyn9RV3
   qur9femlOSf/LYDbyn9QqhEGD+pWQYObA78JvygRwPrzZsCGX2ETrPZk8
   Kxt6lEruJjFXv8AmyHK5A4jhNjpyTgoI0ho1gdpO9mBWJzfs4+jWUiRKp
   I=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="194255746"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 20:30:18 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:6692]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.88:2525] with esmtp (Farcaster)
 id 23112c7d-77c3-40cf-94d8-47b1b6813e09; Mon, 25 Mar 2024 20:30:16 +0000 (UTC)
X-Farcaster-Flow-ID: 23112c7d-77c3-40cf-94d8-47b1b6813e09
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:30:16 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:30:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 14/15] af_unix: Replace garbage collection algorithm.
Date: Mon, 25 Mar 2024 13:24:24 -0700
Message-ID: <20240325202425.60930-15-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240325202425.60930-1-kuniyu@amazon.com>
References: <20240325202425.60930-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

If we find a dead SCC during iteration, we call unix_collect_skb()
to splice all skb in the SCC to the global sk_buff_head, hitlist.

After iterating all SCC, we unlock unix_gc_lock and purge the queue.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |   8 --
 net/unix/af_unix.c    |  12 --
 net/unix/garbage.c    | 302 +++++++++---------------------------------
 3 files changed, 64 insertions(+), 258 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 696d997a5ac9..226a8da2cbe3 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -19,9 +19,6 @@ static inline struct unix_sock *unix_get_socket(struct file *filp)
 
 extern spinlock_t unix_gc_lock;
 extern unsigned int unix_tot_inflight;
-
-void unix_inflight(struct user_struct *user, struct file *fp);
-void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
 void unix_del_edges(struct scm_fp_list *fpl);
 void unix_update_edges(struct unix_sock *receiver);
@@ -85,12 +82,7 @@ struct unix_sock {
 	struct sock		*peer;
 	struct sock		*listener;
 	struct unix_vertex	*vertex;
-	struct list_head	link;
-	unsigned long		inflight;
 	spinlock_t		lock;
-	unsigned long		gc_flags;
-#define UNIX_GC_CANDIDATE	0
-#define UNIX_GC_MAYBE_CYCLE	1
 	struct socket_wq	peer_wq;
 	wait_queue_entry_t	peer_wake;
 	struct scm_stat		scm_stat;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ae77e2dc0dae..27ca50ab1cd1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -980,12 +980,10 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
 	u->listener = NULL;
-	u->inflight = 0;
 	u->vertex = NULL;
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	spin_lock_init(&u->lock);
-	INIT_LIST_HEAD(&u->link);
 	mutex_init(&u->iolock); /* single task reading lock */
 	mutex_init(&u->bindlock); /* single task binding lock */
 	init_waitqueue_head(&u->peer_wait);
@@ -1793,8 +1791,6 @@ static inline bool too_many_unix_fds(struct task_struct *p)
 
 static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	int i;
-
 	if (too_many_unix_fds(current))
 		return -ETOOMANYREFS;
 
@@ -1806,9 +1802,6 @@ static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	if (!UNIXCB(skb).fp)
 		return -ENOMEM;
 
-	for (i = scm->fp->count - 1; i >= 0; i--)
-		unix_inflight(scm->fp->user, scm->fp->fp[i]);
-
 	if (unix_prepare_fpl(UNIXCB(skb).fp))
 		return -ENOMEM;
 
@@ -1817,15 +1810,10 @@ static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 
 static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	int i;
-
 	scm->fp = UNIXCB(skb).fp;
 	UNIXCB(skb).fp = NULL;
 
 	unix_destroy_fpl(scm->fp);
-
-	for (i = scm->fp->count - 1; i >= 0; i--)
-		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
 }
 
 static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 0a6b38da578c..89ea71d9297b 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -322,6 +322,52 @@ static bool unix_vertex_dead(struct unix_vertex *vertex)
 	return true;
 }
 
+enum unix_recv_queue_lock_class {
+	U_RECVQ_LOCK_NORMAL,
+	U_RECVQ_LOCK_EMBRYO,
+};
+
+static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist)
+{
+	struct unix_vertex *vertex;
+
+	list_for_each_entry_reverse(vertex, scc, scc_entry) {
+		struct sk_buff_head *queue;
+		struct unix_edge *edge;
+		struct unix_sock *u;
+
+		edge = list_first_entry(&vertex->edges, typeof(*edge), vertex_entry);
+		u = edge->predecessor;
+		queue = &u->sk.sk_receive_queue;
+
+		spin_lock(&queue->lock);
+
+		if (u->sk.sk_state == TCP_LISTEN) {
+			struct sk_buff *skb;
+
+			skb_queue_walk(queue, skb) {
+				struct sk_buff_head *embryo_queue = &skb->sk->sk_receive_queue;
+
+				/* listener -> embryo order, the inversion never happens. */
+				spin_lock_nested(&embryo_queue->lock, U_RECVQ_LOCK_EMBRYO);
+				skb_queue_splice_init(embryo_queue, hitlist);
+				spin_unlock(&embryo_queue->lock);
+			}
+		} else {
+			skb_queue_splice_init(queue, hitlist);
+
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+			if (u->oob_skb) {
+				kfree_skb(u->oob_skb);
+				u->oob_skb = NULL;
+			}
+#endif
+		}
+
+		spin_unlock(&queue->lock);
+	}
+}
+
 static bool unix_scc_cyclic(struct list_head *scc)
 {
 	struct unix_vertex *vertex;
@@ -345,7 +391,8 @@ static bool unix_scc_cyclic(struct list_head *scc)
 static LIST_HEAD(unix_visited_vertices);
 static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 
-static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_index)
+static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_index,
+			    struct sk_buff_head *hitlist)
 {
 	LIST_HEAD(vertex_stack);
 	struct unix_edge *edge;
@@ -430,7 +477,9 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 				scc_dead = unix_vertex_dead(vertex);
 		}
 
-		if (!unix_graph_maybe_cyclic)
+		if (scc_dead)
+			unix_collect_skb(&scc, hitlist);
+		else if (!unix_graph_maybe_cyclic)
 			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
 
 		list_del(&scc);
@@ -441,7 +490,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 		goto prev_vertex;
 }
 
-static void unix_walk_scc(void)
+static void unix_walk_scc(struct sk_buff_head *hitlist)
 {
 	unsigned long last_index = UNIX_VERTEX_INDEX_START;
 
@@ -454,7 +503,7 @@ static void unix_walk_scc(void)
 		struct unix_vertex *vertex;
 
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
-		__unix_walk_scc(vertex, &last_index);
+		__unix_walk_scc(vertex, &last_index, hitlist);
 	}
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
@@ -463,7 +512,7 @@ static void unix_walk_scc(void)
 	unix_graph_grouped = true;
 }
 
-static void unix_walk_scc_fast(void)
+static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 {
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
@@ -480,263 +529,40 @@ static void unix_walk_scc_fast(void)
 				scc_dead = unix_vertex_dead(vertex);
 		}
 
+		if (scc_dead)
+			unix_collect_skb(&scc, hitlist);
+
 		list_del(&scc);
 	}
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 }
 
-static LIST_HEAD(gc_candidates);
-static LIST_HEAD(gc_inflight_list);
-
-/* Keep the number of times in flight count for the file
- * descriptor if it is for an AF_UNIX socket.
- */
-void unix_inflight(struct user_struct *user, struct file *filp)
-{
-	struct unix_sock *u = unix_get_socket(filp);
-
-	spin_lock(&unix_gc_lock);
-
-	if (u) {
-		if (!u->inflight) {
-			WARN_ON_ONCE(!list_empty(&u->link));
-			list_add_tail(&u->link, &gc_inflight_list);
-		} else {
-			WARN_ON_ONCE(list_empty(&u->link));
-		}
-		u->inflight++;
-	}
-
-	spin_unlock(&unix_gc_lock);
-}
-
-void unix_notinflight(struct user_struct *user, struct file *filp)
-{
-	struct unix_sock *u = unix_get_socket(filp);
-
-	spin_lock(&unix_gc_lock);
-
-	if (u) {
-		WARN_ON_ONCE(!u->inflight);
-		WARN_ON_ONCE(list_empty(&u->link));
-
-		u->inflight--;
-		if (!u->inflight)
-			list_del_init(&u->link);
-	}
-
-	spin_unlock(&unix_gc_lock);
-}
-
-static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
-			  struct sk_buff_head *hitlist)
-{
-	struct sk_buff *skb;
-	struct sk_buff *next;
-
-	spin_lock(&x->sk_receive_queue.lock);
-	skb_queue_walk_safe(&x->sk_receive_queue, skb, next) {
-		/* Do we have file descriptors ? */
-		if (UNIXCB(skb).fp) {
-			bool hit = false;
-			/* Process the descriptors of this socket */
-			int nfd = UNIXCB(skb).fp->count;
-			struct file **fp = UNIXCB(skb).fp->fp;
-
-			while (nfd--) {
-				/* Get the socket the fd matches if it indeed does so */
-				struct unix_sock *u = unix_get_socket(*fp++);
-
-				/* Ignore non-candidates, they could have been added
-				 * to the queues after starting the garbage collection
-				 */
-				if (u && test_bit(UNIX_GC_CANDIDATE, &u->gc_flags)) {
-					hit = true;
-
-					func(u);
-				}
-			}
-			if (hit && hitlist != NULL) {
-				__skb_unlink(skb, &x->sk_receive_queue);
-				__skb_queue_tail(hitlist, skb);
-			}
-		}
-	}
-	spin_unlock(&x->sk_receive_queue.lock);
-}
-
-static void scan_children(struct sock *x, void (*func)(struct unix_sock *),
-			  struct sk_buff_head *hitlist)
-{
-	if (x->sk_state != TCP_LISTEN) {
-		scan_inflight(x, func, hitlist);
-	} else {
-		struct sk_buff *skb;
-		struct sk_buff *next;
-		struct unix_sock *u;
-		LIST_HEAD(embryos);
-
-		/* For a listening socket collect the queued embryos
-		 * and perform a scan on them as well.
-		 */
-		spin_lock(&x->sk_receive_queue.lock);
-		skb_queue_walk_safe(&x->sk_receive_queue, skb, next) {
-			u = unix_sk(skb->sk);
-
-			/* An embryo cannot be in-flight, so it's safe
-			 * to use the list link.
-			 */
-			WARN_ON_ONCE(!list_empty(&u->link));
-			list_add_tail(&u->link, &embryos);
-		}
-		spin_unlock(&x->sk_receive_queue.lock);
-
-		while (!list_empty(&embryos)) {
-			u = list_entry(embryos.next, struct unix_sock, link);
-			scan_inflight(&u->sk, func, hitlist);
-			list_del_init(&u->link);
-		}
-	}
-}
-
-static void dec_inflight(struct unix_sock *usk)
-{
-	usk->inflight--;
-}
-
-static void inc_inflight(struct unix_sock *usk)
-{
-	usk->inflight++;
-}
-
-static void inc_inflight_move_tail(struct unix_sock *u)
-{
-	u->inflight++;
-
-	/* If this still might be part of a cycle, move it to the end
-	 * of the list, so that it's checked even if it was already
-	 * passed over
-	 */
-	if (test_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags))
-		list_move_tail(&u->link, &gc_candidates);
-}
-
 static bool gc_in_progress;
 
 static void __unix_gc(struct work_struct *work)
 {
 	struct sk_buff_head hitlist;
-	struct unix_sock *u, *next;
-	LIST_HEAD(not_cycle_list);
-	struct list_head cursor;
 
 	spin_lock(&unix_gc_lock);
 
-	if (!unix_graph_maybe_cyclic)
+	if (!unix_graph_maybe_cyclic) {
+		spin_unlock(&unix_gc_lock);
 		goto skip_gc;
-
-	if (unix_graph_grouped)
-		unix_walk_scc_fast();
-	else
-		unix_walk_scc();
-
-	/* First, select candidates for garbage collection.  Only
-	 * in-flight sockets are considered, and from those only ones
-	 * which don't have any external reference.
-	 *
-	 * Holding unix_gc_lock will protect these candidates from
-	 * being detached, and hence from gaining an external
-	 * reference.  Since there are no possible receivers, all
-	 * buffers currently on the candidates' queues stay there
-	 * during the garbage collection.
-	 *
-	 * We also know that no new candidate can be added onto the
-	 * receive queues.  Other, non candidate sockets _can_ be
-	 * added to queue, so we must make sure only to touch
-	 * candidates.
-	 */
-	list_for_each_entry_safe(u, next, &gc_inflight_list, link) {
-		long total_refs;
-
-		total_refs = file_count(u->sk.sk_socket->file);
-
-		WARN_ON_ONCE(!u->inflight);
-		WARN_ON_ONCE(total_refs < u->inflight);
-		if (total_refs == u->inflight) {
-			list_move_tail(&u->link, &gc_candidates);
-			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
-			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
-		}
-	}
-
-	/* Now remove all internal in-flight reference to children of
-	 * the candidates.
-	 */
-	list_for_each_entry(u, &gc_candidates, link)
-		scan_children(&u->sk, dec_inflight, NULL);
-
-	/* Restore the references for children of all candidates,
-	 * which have remaining references.  Do this recursively, so
-	 * only those remain, which form cyclic references.
-	 *
-	 * Use a "cursor" link, to make the list traversal safe, even
-	 * though elements might be moved about.
-	 */
-	list_add(&cursor, &gc_candidates);
-	while (cursor.next != &gc_candidates) {
-		u = list_entry(cursor.next, struct unix_sock, link);
-
-		/* Move cursor to after the current position. */
-		list_move(&cursor, &u->link);
-
-		if (u->inflight) {
-			list_move_tail(&u->link, &not_cycle_list);
-			__clear_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
-			scan_children(&u->sk, inc_inflight_move_tail, NULL);
-		}
 	}
-	list_del(&cursor);
 
-	/* Now gc_candidates contains only garbage.  Restore original
-	 * inflight counters for these as well, and remove the skbuffs
-	 * which are creating the cycle(s).
-	 */
-	skb_queue_head_init(&hitlist);
-	list_for_each_entry(u, &gc_candidates, link) {
-		scan_children(&u->sk, inc_inflight, &hitlist);
+	__skb_queue_head_init(&hitlist);
 
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-		if (u->oob_skb) {
-			kfree_skb(u->oob_skb);
-			u->oob_skb = NULL;
-		}
-#endif
-	}
-
-	/* not_cycle_list contains those sockets which do not make up a
-	 * cycle.  Restore these to the inflight list.
-	 */
-	while (!list_empty(&not_cycle_list)) {
-		u = list_entry(not_cycle_list.next, struct unix_sock, link);
-		__clear_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
-		list_move_tail(&u->link, &gc_inflight_list);
-	}
+	if (unix_graph_grouped)
+		unix_walk_scc_fast(&hitlist);
+	else
+		unix_walk_scc(&hitlist);
 
 	spin_unlock(&unix_gc_lock);
 
-	/* Here we are. Hitlist is filled. Die. */
 	__skb_queue_purge(&hitlist);
-
-	spin_lock(&unix_gc_lock);
-
-	/* All candidates should have been detached by now. */
-	WARN_ON_ONCE(!list_empty(&gc_candidates));
 skip_gc:
-	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
 	WRITE_ONCE(gc_in_progress, false);
-
-	spin_unlock(&unix_gc_lock);
 }
 
 static DECLARE_WORK(unix_gc_work, __unix_gc);
-- 
2.30.2


