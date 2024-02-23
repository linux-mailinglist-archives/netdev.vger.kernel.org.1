Return-Path: <netdev+bounces-74593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460FE861F29
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640111C23112
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 21:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54FC1493B7;
	Fri, 23 Feb 2024 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vOVmRBCU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A1149381
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724556; cv=none; b=onShzb/+I3Q/yuAqHBE8+oA0L3ecZ9nQj2B/TYvmFJKiPFWE/ordfZ5DwbWaIUvVC56KCrUa/c3U+J0KaDdLxfaIskmgz10p1N4G8k6KqYRpz58mwvdz3y/fzQ3qdPprSC0sFDk5oL1RaY6RFq78GBPbDVkRU/yfDYIUOuIBT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724556; c=relaxed/simple;
	bh=aASPhid2LXOKaHzGvFhPZoMc1fQ0ybWirfd9mtapSdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOjKVTxIeK7kDE4Jil+9xnuQykWoxddRu+iW0tEQyFYQ/Iic6ynHLuj1fTkv/CTWqg7S4FdPPB2gREX/oZFQr1VuZKuvIAyPDGPVsVmgw57XrD/67d4KdtueKd0+lvC0S4gZMmyTce7CDTsvqvPZzsRfuqraCDn/e30K/WjN4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vOVmRBCU; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708724555; x=1740260555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BnG5PsxcueZutSFH2g3HBzD2OJzM6nxVNAzArujreVI=;
  b=vOVmRBCUQRdYN7Ws2T36Hp7pbs2Bw4hWUb8eQSe9+nqj/cLw1ZGxbeH/
   pnWpTr4dggJlntXI8Ye9EL4WtPDzSnICPU4qRDxpsfEe3r+EhegOeWrl7
   SUaJdvrpNMyQLxnmNV0vZvFhEX2vpqpUy6AD1GREzfdImxusLuaX17BPa
   Y=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="399310788"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 21:42:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:55520]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.236:2525] with esmtp (Farcaster)
 id 6559d1f8-9ff2-470a-bc5e-1629ea711940; Fri, 23 Feb 2024 21:42:28 +0000 (UTC)
X-Farcaster-Flow-ID: 6559d1f8-9ff2-470a-bc5e-1629ea711940
Received: from EX19D004ANA003.ant.amazon.com (10.37.240.184) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 21:42:27 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.9) by
 EX19D004ANA003.ant.amazon.com (10.37.240.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 21:42:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 05/14] af_unix: Detect Strongly Connected Components.
Date: Fri, 23 Feb 2024 13:39:54 -0800
Message-ID: <20240223214003.17369-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223214003.17369-1-kuniyu@amazon.com>
References: <20240223214003.17369-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA003.ant.amazon.com (10.37.240.184)

In the new GC, we use a simple graph algorithm, Tarjan's Strongly
Connected Components (SCC) algorithm, to find cyclic references.

The algorithm visits every vertex exactly once using depth-first
search (DFS).  We implement it without recursion so that no one
can abuse it.

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

If a vertex has a back-edge to a visited vertex in the stack,
we update the predecessor's lowlink with the successor's index.

After iterating edges from the vertex, we check if its index
equals its lowlink.

If the lowlink is different from the index, it shows there was a
back-edge.  Then, we propagate the lowlink to its predecessor and
go back to the predecessor to resume checking from the next edge
of the back-edge.

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

    B = (3, 1)  (index, lowlink)
  > D = (2, 1)
    C = (1, 1)

Next, we visit E, which has no edge to an inflight vertex.

  > E = (4, 4)  (index, lowlink)
    B = (3, 1)
    D = (2, 1)
    C = (1, 1)

When we leave from E, its index and lowlink are the same, so we
pop E from the stack as single-vertex SCC.  Next, we leave from
D but do nothing because its lowlink is different from its index.

    B = (3, 1)  (index, lowlink)
    D = (2, 1)
  > C = (1, 1)

Then, we leave from C, whose index and lowlink are the same, so
we pop B, D and C as SCC.

Last, we do DFS for the rest of vertices, A, which is also a
single-vertex SCC.

Finally, each unix_vertex.scc_entry is linked as follows:

  A -.  B -> C -> D  E -.
  ^  |  ^         |  ^  |
  `--'  `---------'  `--'

We use SCC later to decide whether we can garbage-collect the
sockets.

Note that we still cannot detect SCC properly if an edge points
to an embryo socket.  The following two patches will sort it out.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  5 +++
 net/unix/garbage.c    | 82 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index f31ad1166346..67736767b616 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -32,13 +32,18 @@ void wait_for_unix_gc(struct scm_fp_list *fpl);
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
 	struct unix_sock *predecessor;
 	struct unix_sock *successor;
 	struct list_head vertex_entry;
+	struct list_head stack_entry;
 };
 
 struct sock *unix_peer_get(struct sock *sk);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index e8fe08796d02..7e90663513f9 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -103,6 +103,11 @@ struct unix_sock *unix_get_socket(struct file *filp)
 
 static LIST_HEAD(unix_unvisited_vertices);
 
+enum unix_vertex_index {
+	UNIX_VERTEX_INDEX_UNVISITED,
+	UNIX_VERTEX_INDEX_START,
+};
+
 static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
 	struct unix_vertex *vertex = edge->predecessor->vertex;
@@ -245,6 +250,81 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
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
+	list_add(&vertex->scc_entry, &vertex_stack);
+
+	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
+		struct unix_vertex *next_vertex = edge->successor->vertex;
+
+		if (!next_vertex)
+			continue;
+
+		if (next_vertex->index == UNIX_VERTEX_INDEX_UNVISITED) {
+			list_add(&edge->stack_entry, &edge_stack);
+
+			vertex = next_vertex;
+			goto next_vertex;
+prev_vertex:
+			next_vertex = vertex;
+
+			edge = list_first_entry(&edge_stack, typeof(*edge), stack_entry);
+			list_del_init(&edge->stack_entry);
+
+			vertex = edge->predecessor->vertex;
+
+			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
+		} else if (edge->successor->vertex->on_stack) {
+			vertex->lowlink = min(vertex->lowlink, next_vertex->index);
+		}
+	}
+
+	if (vertex->index == vertex->lowlink) {
+		struct list_head scc;
+
+		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
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
+	if (!list_empty(&edge_stack))
+		goto prev_vertex;
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
 
@@ -392,6 +472,8 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_lock(&unix_gc_lock);
 
+	unix_walk_scc();
+
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
 	 * which don't have any external reference.
-- 
2.30.2


