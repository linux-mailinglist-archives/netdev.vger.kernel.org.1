Return-Path: <netdev+bounces-81773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCAA88B624
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B856BBA3710
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5724CDFB;
	Mon, 25 Mar 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R4tlxAGL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA246444
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398413; cv=none; b=RnaHGJOw+8WI3GcQBtfXDAHTkxTyjxhrb6XgpHAugNotDjj6FAN7Y0r6/PUj4eG8F8HUHYNgiVk5hq3PQhuyc95SFx5EzimnEbG9sPrCoIt5rU26iG1QWxngdaih0EM5xBfa/Zetup7pdovoDqkbBdkrUdy1TzBfpb/lJo8e25E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398413; c=relaxed/simple;
	bh=ph2yf7J6LKq4YYRMk+Y5URfzdxOTm+QE2Ee2wVW/qI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9f14tecdQLl/fX2tE8miEjNY4G/C1z2W3Y0G6Op7W9XaVOVu20EZUbFHv5brEtyLp5IeSE5pkaBp4HvY2RL7WPbE1/D5lLcRN3hygQ5GPrQ9VKcEk151DkP4X8LXE0k6h9aF+1R+mBrK4Is9oND0hZW0P0OHTPrGRk+YzKFq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R4tlxAGL; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711398412; x=1742934412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GT6vMIEY3HLrFx24YMvpjbDCcF/1ON4MQ2a4ka0flj0=;
  b=R4tlxAGL9OeAl2vu6jXQVPU1DrJAs7fc6tYARNfij5McP0bOTC74LjHs
   Xw8ag15KgdhFnwQvZAn/Sb24eBVaO/cEI3kEJIVIBnTDootMfYgCV6luP
   23QIcqsDQjFYe7jr7HWW3UyTBnJsvuEggmDUv/CCq9QqFOjRGIloihQ7p
   M=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="282771327"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 20:26:48 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:10915]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.10:2525] with esmtp (Farcaster)
 id 7c44c0f6-d099-4d0f-abba-646504841a95; Mon, 25 Mar 2024 20:26:47 +0000 (UTC)
X-Farcaster-Flow-ID: 7c44c0f6-d099-4d0f-abba-646504841a95
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:26:38 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:26:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 05/15] af_unix: Iterate all vertices by DFS.
Date: Mon, 25 Mar 2024 13:24:15 -0700
Message-ID: <20240325202425.60930-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The new GC will use a depth first search graph algorithm to find
cyclic references.  The algorithm visits every vertex exactly once.

Here, we implement the DFS part without recursion so that no one
can abuse it.

unix_walk_scc() marks every vertex unvisited by initialising index
as UNIX_VERTEX_INDEX_UNVISITED and iterates inflight vertices in
unix_unvisited_vertices and call __unix_walk_scc() to start DFS from
an arbitrary vertex.

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


