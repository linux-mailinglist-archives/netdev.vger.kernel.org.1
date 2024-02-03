Return-Path: <netdev+bounces-68763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85400847FCC
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E99D285208
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF4428EF;
	Sat,  3 Feb 2024 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QvYIMe2D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B1D79C0
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929452; cv=none; b=rIRnX6D778XvKbwRB5kQQqg5stGo7gEKXDXh6jEXtQv3Zwux4TMhBkrbv9BRpYWocYURyAdWT9WCrHRcK8RHpaQXd2cjunpF1ZLGHozOgCyX84d/w/bm/CcWKakeAeRBX9ElWS1wNyhb3gWcL/4GEMurNHE7DUoijLU40puXGdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929452; c=relaxed/simple;
	bh=7L0Adk+zGt8TRlw0I9xgxeom77U6i1AKxJang1oFe1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFwZg/JZlb5tMO8K3uoGioQlVVdnlP/wM9wpe3diZTfCaeB7sEWlvf+w7BUJEjsWafjgbLV/1CMmzRQ8M5uW0L+2ID90lSqsOq+Aoz1YR/5cBGGgnN1V8S2Pq69cXNe+369kbcxWo29vBrxFZEQHFmZL8bNrMvQnzweg72AGi2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QvYIMe2D; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929451; x=1738465451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AUQNE99V0v27fkMLeodwcbWyB1aPRvUXwQmlu2J+AsA=;
  b=QvYIMe2DYpXA+8ktrQcJtv0z7ItDndSgAcOVbzF0Y1E0ButuX/uLFEAK
   DDIpW6eSuv/U5eL6mmSBkB0JbIDvVO8Xh6V6m+o1wevdV6lMWtbt8J/b6
   84vD2I7Kml6jvYzlP29oyJD9LMD6Vys503izc1yHzpvu2wU/KqALXAuVK
   4=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="182303310"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:04:09 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:36443]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.186:2525] with esmtp (Farcaster)
 id 40bf6270-c923-426d-9a99-60f5ffdabea4; Sat, 3 Feb 2024 03:04:07 +0000 (UTC)
X-Farcaster-Flow-ID: 40bf6270-c923-426d-9a99-60f5ffdabea4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:04:07 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:04:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 07/16] af_unix: Detect Strongly Connected Components.
Date: Fri, 2 Feb 2024 19:00:49 -0800
Message-ID: <20240203030058.60750-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240203030058.60750-1-kuniyu@amazon.com>
References: <20240203030058.60750-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In the new GC, we use a simple graph algorithm, Tarjan's Strongly
Connected Components (SCC) algorithm, to find cyclic references.

The algorithm visits every vertex exactly once using depth-first
search (DFS).  We implement it without recursion so that no one can
abuse it.

There could be multiple graphs, so we iterate unix_unvisited_vertices
in unix_walk_scc() and do DFS in __unix_walk_scc(), where we move
visited vertices to another list, unix_visited_vertices, not to
restart DFS twice on a visited vertex later in unix_walk_scc().

DFS starts by pushing an input vertex to a stack and assigning it
a unique number.  Two fields, index and lowlink, are initialised
with the number, but lowlink could be updated later during DFS.

If a vertex has an edge to an unvisited inflight vertex, we visit
it and do the same processing.  So, we will have vertices in the
stack in the order they appear and number them consecutively in
the same order.

If a vertex has an edge to a visited vertex in stack, so-called
back-edge, we update the predecessor's lowlink with the successor's
index.

After iterating edges from the vertex, we check if its index
equals its lowlink.

If the lowlink is different from the index, it shows there was a
back-edge.  Then, we propagate the lowlink to its predecessor.

If the lowlink is the same as the index, we pop vertices before
and including the vertex from the stack.  Then, the set of vertices
is SCC, possibly forming a cycle.  At the same time, we move the
vertices to unix_visited_vertices.

When we finish the algorithm, all vertices in each SCC will be
linked via unix_vertex.scc_entry.

Let's take an example.  We have a graph including five inflight
vertices (F is not inflight):

  A -> B -> C -> D -> E (-> F)
       ^         |
       `---------'

Suppose that we start DFS from C.  We will visit C, D, and B first
and initialise their index and lowlink.  Then, the stack looks like
this:

  > B = (3, 3)  (index, lowlink)
    D = (2, 2)
    C = (1, 1)

When checking B's edge to C, we update B's lowlink with C's index
and propagate it to D.

  > B = (3, 1)  (index, lowlink)
    D = (2, 1)
    C = (1, 1)

Next, we visit E, which has no edge to an inflight vertex.

  > E = (4, 4)  (index, lowlink)
    B = (3, 1)
    D = (2, 1)
    C = (1, 1)

When we leave from E, its index and lowlink are the same, so we pop
E from the stack.

    B = (3, 1)  (index, lowlink)
    D = (2, 1)
  > C = (1, 1)

Then, we leave C, whose index and lowlink are the same, so we pop
B, D and C as SCC.

Last, we do DFS for the rest of vertices, A, which is also a
single-vertex SCC.

Finally, each unix_vertex.scc_entry is linked as follows:

  A -.  B -> C -> D  E -.
  ^  |  ^         |  ^  |
  `--'  `---------'  `--'

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  5 +++
 net/unix/garbage.c    | 80 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 2d8e93775e61..0874f6b41adc 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -34,7 +34,11 @@ void wait_for_unix_gc(struct scm_fp_list *fpl);
 struct unix_vertex {
 	struct list_head edges;
 	struct list_head entry;
+	struct list_head scc_entry;
 	unsigned long out_degree;
+	unsigned long index;
+	unsigned long lowlink;
+	bool on_stack;
 };
 
 struct unix_edge {
@@ -42,6 +46,7 @@ struct unix_edge {
 	struct unix_vertex *successor;
 	struct list_head entry;
 	struct list_head embryo_entry;
+	struct list_head stack_entry;
 };
 
 struct sock *unix_peer_get(struct sock *sk);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 42ed886c75d1..e235c03ee3c3 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -108,6 +108,7 @@ void unix_init_vertex(struct unix_sock *u)
 	vertex->out_degree = 0;
 	INIT_LIST_HEAD(&vertex->edges);
 	INIT_LIST_HEAD(&vertex->entry);
+	INIT_LIST_HEAD(&vertex->scc_entry);
 }
 
 DEFINE_SPINLOCK(unix_gc_lock);
@@ -217,6 +218,83 @@ void unix_free_edges(struct scm_fp_list *fpl)
 	kvfree(fpl->edges);
 }
 
+enum unix_vertex_index {
+	UNIX_VERTEX_INDEX_UNVISITED,
+	UNIX_VERTEX_INDEX_START,
+};
+
+static LIST_HEAD(unix_visited_vertices);
+
+static void __unix_walk_scc(struct unix_vertex *vertex)
+{
+	unsigned long index = UNIX_VERTEX_INDEX_START;
+	LIST_HEAD(vertex_stack);
+	struct unix_edge *edge;
+	LIST_HEAD(edge_stack);
+
+next_vertex:
+	vertex->index = index;
+	vertex->lowlink = index;
+	index++;
+
+	vertex->on_stack = true;
+	list_move(&vertex->scc_entry, &vertex_stack);
+
+	list_for_each_entry(edge, &vertex->edges, entry) {
+		if (!edge->successor->out_degree)
+			continue;
+
+		if (edge->successor->index == UNIX_VERTEX_INDEX_UNVISITED) {
+			list_add(&edge->stack_entry, &edge_stack);
+
+			vertex = edge->successor;
+			goto next_vertex;
+		}
+
+		if (edge->successor->on_stack)
+			vertex->lowlink = min(vertex->lowlink, edge->successor->index);
+next_edge:
+	}
+
+	if (vertex->index == vertex->lowlink) {
+		LIST_HEAD(scc);
+
+		list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
+
+		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
+			list_move_tail(&vertex->entry, &unix_visited_vertices);
+
+			vertex->on_stack = false;
+		}
+
+		list_del(&scc);
+	}
+
+	if (!list_empty(&edge_stack)) {
+		edge = list_first_entry(&edge_stack, typeof(*edge), stack_entry);
+		list_del_init(&edge->stack_entry);
+
+		vertex = edge->predecessor;
+		vertex->lowlink = min(vertex->lowlink, edge->successor->lowlink);
+		goto next_edge;
+	}
+}
+
+static void unix_walk_scc(void)
+{
+	struct unix_vertex *vertex;
+
+	list_for_each_entry(vertex, &unix_unvisited_vertices, entry)
+		vertex->index = UNIX_VERTEX_INDEX_UNVISITED;
+
+	while (!list_empty(&unix_unvisited_vertices)) {
+		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
+		__unix_walk_scc(vertex);
+	}
+
+	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
+}
+
 static LIST_HEAD(gc_candidates);
 static LIST_HEAD(gc_inflight_list);
 
@@ -364,6 +442,8 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_lock(&unix_gc_lock);
 
+	unix_walk_scc();
+
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
 	 * which don't have any external reference.
-- 
2.30.2


