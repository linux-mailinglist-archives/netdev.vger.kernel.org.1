Return-Path: <netdev+bounces-76402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76386D9B1
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 03:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323511F220A7
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3BE3A8CB;
	Fri,  1 Mar 2024 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LpQqPXVx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033F2B9A8
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259911; cv=none; b=gmHpa0orcCJ/lpc7zDbfDU/Hbb4LJ3UG4+I1VKRG2ThgxmhOvQOIwF3N8STAKLlAagEswbbKDp6aMjnQH1W6DciU/cgbd3btQFlmhSqjItha1p9tO1V0kQA5vipwEDanSC6bdFFPNhUAHVIP1znWSwNyy9/BqO6aP7uXyHJTGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259911; c=relaxed/simple;
	bh=IYLfxIrw1uqV+2hZDKCRo5GngOFbCBnwszD8LZjdrCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b95pxjSKmLn9Zc9UL6k4LTQgJv4RVomP3Yvi/VNkMaQli437PzuNgnMwNGW+cIjF05DXMsWygnifTYJcmOY9HjAXTbTa5DTHN6i2+mD/ZnnJyPaThDPjlZEyMzq+1c5zrR34sUorGuPiT5j5iFkxxcIq+FryZekK6peWb+pXvxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LpQqPXVx; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709259907; x=1740795907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w3DFlID+IBzcy1AsqD2JVvMz0z6OgJ2x+i+wyiHP7DY=;
  b=LpQqPXVxIKuNq3FG10zzXenwDXBwE4hkT8moAZbIgubK8Hz8w1e3YSuW
   OYpyrzuEymeSwT3UT5HHHjXXubngaYwmPS1ibHVFtQc4FObWYGKgKeyxZ
   xcgjE6O3PCfPvYj8hVeP2x6Gjt8dt/mM7EgFdYzffEx0CjwFvI+3u9VWV
   E=;
X-IronPort-AV: E=Sophos;i="6.06,194,1705363200"; 
   d="scan'208";a="69867546"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 02:25:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:34478]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.52:2525] with esmtp (Farcaster)
 id 8c089680-3cfa-49a6-92f0-64f3820d20d7; Fri, 1 Mar 2024 02:25:05 +0000 (UTC)
X-Farcaster-Flow-ID: 8c089680-3cfa-49a6-92f0-64f3820d20d7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:25:04 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 1 Mar 2024 02:25:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 05/15] af_unix: Iterate all vertices by DFS.
Date: Thu, 29 Feb 2024 18:22:33 -0800
Message-ID: <20240301022243.73908-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The new GC will use a depth first search graph algorithm to find
cyclic references.  The algorithm visits every vertex exactly once.

Here, we implement its DFS part without recursion so that no one
can abuse it.

unix_walk_scc() marks every vertex unvisited by initialising index
as UNIX_VERTEX_INDEX_UNVISITED, iterates inflight vertices in
unix_unvisited_vertices, and call __unix_walk_scc() to start DFS
from an arbitrary vertex.

__unix_walk_scc() iterates all edges starting from the vertex and
explores the neighbour vertices with DFS using edge_stack.

After visiting all neighbours, __unix_walk_scc() moves the visited
vertex to unix_visited_vertices so that unix_walk_scc() will not
restart DFS from the visited vertex.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  2 ++
 net/unix/garbage.c    | 74 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index f31ad1166346..970a91da2239 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -33,12 +33,14 @@ struct unix_vertex {
 	struct list_head edges;
 	struct list_head entry;
 	unsigned long out_degree;
+	unsigned long index;
 };
 
 struct unix_edge {
 	struct unix_sock *predecessor;
 	struct unix_sock *successor;
 	struct list_head vertex_entry;
+	struct list_head stack_entry;
 };
 
 struct sock *unix_peer_get(struct sock *sk);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 84c8ea524a98..8b16ab9e240e 100644
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
@@ -241,6 +246,73 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
+static LIST_HEAD(unix_visited_vertices);
+
+static void __unix_walk_scc(struct unix_vertex *vertex)
+{
+	unsigned long index = UNIX_VERTEX_INDEX_START;
+	struct unix_edge *edge;
+	LIST_HEAD(edge_stack);
+
+next_vertex:
+	vertex->index = index;
+	index++;
+
+	/* Explore neighbour vertices (receivers of the current vertex's fd). */
+	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
+		struct unix_vertex *next_vertex = edge->successor->vertex;
+
+		if (!next_vertex)
+			continue;
+
+		if (next_vertex->index == UNIX_VERTEX_INDEX_UNVISITED) {
+			/* Iterative deepening depth first search
+			 *
+			 *   1. Push a forward edge to edge_stack and set
+			 *      the successor to vertex for the next iteration.
+			 */
+			list_add(&edge->stack_entry, &edge_stack);
+
+			vertex = next_vertex;
+			goto next_vertex;
+
+			/*   2. Pop the edge directed to the current vertex
+			 *      and restore the ancestor for backtracking.
+			 */
+prev_vertex:
+			edge = list_first_entry(&edge_stack, typeof(*edge), stack_entry);
+			list_del_init(&edge->stack_entry);
+
+			vertex = edge->predecessor->vertex;
+		}
+	}
+
+	/* Don't restart DFS from this vertex in unix_walk_scc(). */
+	list_move_tail(&vertex->entry, &unix_visited_vertices);
+
+	/* Need backtracking ? */
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
+	/* Visit every vertex exactly once.
+	 * __unix_walk_scc() moves visited vertices to unix_visited_vertices.
+	 */
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
 
@@ -388,6 +460,8 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_lock(&unix_gc_lock);
 
+	unix_walk_scc();
+
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
 	 * which don't have any external reference.
-- 
2.30.2


