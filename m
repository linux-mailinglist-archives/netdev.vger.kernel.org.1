Return-Path: <netdev+bounces-76405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B94E86D9B6
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 03:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB982830DA
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301A73A8D8;
	Fri,  1 Mar 2024 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Nl7unz/H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DE3A8CE
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259982; cv=none; b=GMpOnHMDfEl8mZb047LHjE3xc1TFmTI/1sA9+Y5Ig2iiLKxg8aSqrpntSWLqA8guVdlzgCFb3GZ6pfTA6vA/dIfS+09m5H1jT8dO4zG3djtvMt1dHsbwpi24TRWIE5vCNyF7+ciyq0BG8Qa336zJ4ULPYU9sGkiiViBmNiLeyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259982; c=relaxed/simple;
	bh=VUC89oCJSUYc177OmNOAMNGvYQn7qu/R9h5ZapyV+C0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JASST4x3u1zOWTKi5UUbIDZWqpkJs7rdfyaswmoBMIKPRvRlHUDy/08S6HxPwXFeeLWvZBedZzP0Hu/mfy2x77YJT/oO7/1MRvcahFF9WHW9ycGmYcbNoxOh5Y9Iux0qWfnZRm5w5Th6h3/MPXNUVppBs+ocGEA9I4nLfJPiaqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Nl7unz/H; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709259981; x=1740795981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/q+9NcYae9yQsc7sKzUEfIEF9uL+betC0g35o4Ak4Ac=;
  b=Nl7unz/HdYA2nTfXqozYWruMCA1KLRZRDsb5ioE+bLK3Mcu2FGhOmMiF
   kGcfb/oZHz/QIshlWujxo7/eKHZcnlOTtGigRmWjgGcWEGcpxo5sUVpsl
   QJEvdD90zQ3Fpp63WgUySgKoscK4Nj1YeMViAmisd0xzaZSPZUGnalH08
   Q=;
X-IronPort-AV: E=Sophos;i="6.06,194,1705363200"; 
   d="scan'208";a="277804962"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 02:26:21 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:5632]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.165:2525] with esmtp (Farcaster)
 id b9e0327e-9e01-4262-a163-f5ead7b4ce1a; Fri, 1 Mar 2024 02:26:19 +0000 (UTC)
X-Farcaster-Flow-ID: b9e0327e-9e01-4262-a163-f5ead7b4ce1a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:26:19 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:26:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 08/15] af_unix: Fix up unix_edge.successor for embryo socket.
Date: Thu, 29 Feb 2024 18:22:36 -0800
Message-ID: <20240301022243.73908-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240301022243.73908-1-kuniyu@amazon.com>
References: <20240301022243.73908-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
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
index 33aadaa35346..40a40028261b 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -101,6 +101,17 @@ struct unix_sock *unix_get_socket(struct file *filp)
 	return NULL;
 }
 
+static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
+{
+	/* If an embryo socket has a fd, the listener has
+	 * indirectly holds the fd's refcnt.
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


