Return-Path: <netdev+bounces-81776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF63388B15C
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A656B30653E
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990404597D;
	Mon, 25 Mar 2024 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="l7cZbZbw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C43535D4
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398475; cv=none; b=OsieAiSoMxKzK1+mmU48nvaQmVHOrK7mVlYOVbov91NORXKijg+AIFUuI9zoXTlpWXq8c3Y2VCQZJFSA/mzGpOkfRV8ZAbar4t3FQVnh97zuhVDgMQkoBbFoC/5dkPeh3hoOuxcwymZJ8FfYo1LNYeHzicAcbOPyMxvdcddKKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398475; c=relaxed/simple;
	bh=fMNo5fTNohMnyJLbk2mLIG3DR4lnfsRZBiVmOqueyfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwM7yyZzl2ALMxGdPN0RcWKtvlc336aG1gr7Y24gLKtmk7pYIa60yNnQxEniUJp6y/P1vlBw4ElkU+2nYOTY9p1JOQ6J5kE1cdvAw7GEf4ZpJkImVb5r35OCA5DR0k6f//Y284X/rA2F9j8vIyVCIWEO2BUeP/5lSOIhIrXadRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=l7cZbZbw; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711398474; x=1742934474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iVCz26quLMy3v5LmxdtliORIVFIpNx7M1m4xqBeJoes=;
  b=l7cZbZbwlXsjSLTiWoA50zx89H83/Xgj/eje6jGwpOwUp+lVoSzGBEBc
   FshfFjGDpiWeedSJndDry05T3VHhElgIQjSLkpLvllp8HUrQ0/QCdb8ai
   Tj40lXoC3qOCqDbMNi++8ZxVwTq/JN/0ho1+uhyKdDQ0HaHkFHwtGEp3v
   g=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="622262724"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 20:27:52 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:9932]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.115:2525] with esmtp (Farcaster)
 id 2e28201e-854a-4cc1-ad71-d9ee598015b6; Mon, 25 Mar 2024 20:27:51 +0000 (UTC)
X-Farcaster-Flow-ID: 2e28201e-854a-4cc1-ad71-d9ee598015b6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:27:51 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:27:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 08/15] af_unix: Fix up unix_edge.successor for embryo socket.
Date: Mon, 25 Mar 2024 13:24:18 -0700
Message-ID: <20240325202425.60930-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
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

So, here's another type of cyclic reference.  When a fd of an AF_UNIX
socket is passed to an embryo socket, the reference is indirectly held
by its parent listening socket.

  .-> A                            .-> B
  |   `- sk_receive_queue          |   `- sk_receive_queue
  |      `- skb                    |      `- skb
  |         `- sk == C             |         `- sk == D
  |            `- sk_receive_queue |           `- sk_receive_queue
  |               `- skb +---------'               `- skb +-.
  |                                                         |
  `---------------------------------------------------------'

Technically, the graph must be denoted as A <-> B instead of A (-> D)
and B (-> C) to find such a cyclic reference without touching each
socket's receive queue.

  .-> A --. .-- B <-.
  |        X        |  ==  A <-> B
  `-- C <-' `-> D --'

We apply this fixup during GC by fetching the real successor by
unix_edge_successor().

When we call accept(), we clear unix_sock.listener under unix_gc_lock
not to confuse GC.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  1 +
 net/unix/af_unix.c    |  2 +-
 net/unix/garbage.c    | 20 +++++++++++++++++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index dc7469191195..414463803b7e 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -24,6 +24,7 @@ void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
 void unix_del_edges(struct scm_fp_list *fpl);
+void unix_update_edges(struct unix_sock *receiver);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
 void unix_gc(void);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index af74e7ebc35a..ae77e2dc0dae 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1721,7 +1721,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 	}
 
 	tsk = skb->sk;
-	unix_sk(tsk)->listener = NULL;
+	unix_update_edges(unix_sk(tsk));
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 33aadaa35346..8d0912c1d01a 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -101,6 +101,17 @@ struct unix_sock *unix_get_socket(struct file *filp)
 	return NULL;
 }
 
+static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
+{
+	/* If an embryo socket has a fd,
+	 * the listener indirectly holds the fd's refcnt.
+	 */
+	if (edge->successor->listener)
+		return unix_sk(edge->successor->listener)->vertex;
+
+	return edge->successor->vertex;
+}
+
 static LIST_HEAD(unix_unvisited_vertices);
 
 enum unix_vertex_index {
@@ -209,6 +220,13 @@ void unix_del_edges(struct scm_fp_list *fpl)
 	fpl->inflight = false;
 }
 
+void unix_update_edges(struct unix_sock *receiver)
+{
+	spin_lock(&unix_gc_lock);
+	receiver->listener = NULL;
+	spin_unlock(&unix_gc_lock);
+}
+
 int unix_prepare_fpl(struct scm_fp_list *fpl)
 {
 	struct unix_vertex *vertex;
@@ -268,7 +286,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 	/* Explore neighbour vertices (receivers of the current vertex's fd). */
 	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
-		struct unix_vertex *next_vertex = edge->successor->vertex;
+		struct unix_vertex *next_vertex = unix_edge_successor(edge);
 
 		if (!next_vertex)
 			continue;
-- 
2.30.2


