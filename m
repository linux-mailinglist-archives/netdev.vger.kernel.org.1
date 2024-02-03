Return-Path: <netdev+bounces-68764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCDE847FCD
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C9D1F2730A
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701896FC9;
	Sat,  3 Feb 2024 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TcURo7kW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F0A7469
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929478; cv=none; b=bt5ug7TxVHH24UY8c8FmvDBjfxwW+XPCNoi7MOkZsIrRV9zTjgVId1TV8p38yLsC5N/0qMMhQMTLrbA2AmasVBjqkgh0ccViQOhfAUo4CPOfbEePn9bYLuX/BqEflc0bomU8467witvMT3EdlslijCksvJrzqbe32lqZcZs8r/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929478; c=relaxed/simple;
	bh=9Cfmv2UMlbC+J7NatkFZ+2b981QGA8KOO+cMmrCXpiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoAzGcaqzDiLJMSJ9t4CPQI+fnsKI1+L/JYS4YPzsvHD3QTm936e3SYHOHbyNvJ8KITF3TYHdVc1b6+tcmJ6PjfiorpMEcQqBOovPHSWrkRhc9OHyU8Orzh7o4u2tSserXT61glbKjRpOCMe8y8FIvFB6miPEXu0kf5YAl+ElxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TcURo7kW; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929476; x=1738465476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YjUBPYkvYZAyuAzc42N+47T6tnxjAhqSE2C4o0JLz4I=;
  b=TcURo7kW/IPuwcLUrPsJ5/PJGntR40RhMjG2vn7s2PiOSdDzB/r3xlON
   4qmXUeDuQTycla6WdQ+tZx/YLLV2n757+t5so8cLYeaWGoY3p6DX6dFIz
   Tq7yljLryE1AgImRkfL/CEPC+oeV615KjnQhVKyWY67Gnwr6stV3/2eVN
   s=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="63381016"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:04:35 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:59325]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.177:2525] with esmtp (Farcaster)
 id 83aca9f8-2c01-4a54-bdc7-c3ee3ec1a79f; Sat, 3 Feb 2024 03:04:34 +0000 (UTC)
X-Farcaster-Flow-ID: 83aca9f8-2c01-4a54-bdc7-c3ee3ec1a79f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:04:31 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:04:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 08/16] af_unix: Save O(n) setup of Tarjan's algo.
Date: Fri, 2 Feb 2024 19:00:50 -0800
Message-ID: <20240203030058.60750-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Before starting Tarjan's algorithm, we need to mark all vertices
as unvisited.  We can save this O(n) setup by reserving two special
indices (0, 1) and using two variables.

The first time we link a vertex to unix_unvisited_vertices, we set
unix_vertex_unvisited_index to index.

During DFS, we can see that the index of unvisited vertices is the
same as unix_vertex_unvisited_index.

When we finalise SCC later, we set unix_vertex_grouped_index to each
vertex's index.

Then, we can know that the index of a visited vertex is >= 2 if the
vertex is on the stack, and if the index is unix_vertex_grouped_index,
it is not on the stack and belongs to a different SCC.

After the whole algorithm, all indices of vertices are set as
unix_vertex_grouped_index.

Next time we start DFS, we know that all unvisited vertices have
unix_vertex_grouped_index, and we can use unix_vertex_unvisited_index
as the not-on-stack marker.

To do this, we swap unix_vertex_(grouped|unvisited)_index at the end
of Tarjan's algorithm.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  1 -
 net/unix/garbage.c    | 34 +++++++++++++++++++---------------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 0874f6b41adc..b3ba5e949d62 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -38,7 +38,6 @@ struct unix_vertex {
 	unsigned long out_degree;
 	unsigned long index;
 	unsigned long lowlink;
-	bool on_stack;
 };
 
 struct unix_edge {
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index e235c03ee3c3..24137bf95e02 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -115,6 +115,14 @@ DEFINE_SPINLOCK(unix_gc_lock);
 static LIST_HEAD(unix_unvisited_vertices);
 unsigned int unix_tot_inflight;
 
+enum unix_vertex_index {
+	UNIX_VERTEX_INDEX_MARK1,
+	UNIX_VERTEX_INDEX_MARK2,
+	UNIX_VERTEX_INDEX_START,
+};
+
+static unsigned long unix_vertex_unvisited_index = UNIX_VERTEX_INDEX_MARK1;
+
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 {
 	struct unix_vertex *successor;
@@ -138,8 +146,11 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 		edge->predecessor = &inflight->vertex;
 		edge->successor = successor;
 
-		if (!edge->predecessor->out_degree++)
+		if (!edge->predecessor->out_degree++) {
+			edge->predecessor->index = unix_vertex_unvisited_index;
+
 			list_add_tail(&edge->predecessor->entry, &unix_unvisited_vertices);
+		}
 
 		INIT_LIST_HEAD(&edge->entry);
 		list_add_tail(&edge->entry, &edge->predecessor->edges);
@@ -218,12 +229,8 @@ void unix_free_edges(struct scm_fp_list *fpl)
 	kvfree(fpl->edges);
 }
 
-enum unix_vertex_index {
-	UNIX_VERTEX_INDEX_UNVISITED,
-	UNIX_VERTEX_INDEX_START,
-};
-
 static LIST_HEAD(unix_visited_vertices);
+static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 
 static void __unix_walk_scc(struct unix_vertex *vertex)
 {
@@ -237,21 +244,20 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 	vertex->lowlink = index;
 	index++;
 
-	vertex->on_stack = true;
 	list_move(&vertex->scc_entry, &vertex_stack);
 
 	list_for_each_entry(edge, &vertex->edges, entry) {
 		if (!edge->successor->out_degree)
 			continue;
 
-		if (edge->successor->index == UNIX_VERTEX_INDEX_UNVISITED) {
+		if (edge->successor->index == unix_vertex_unvisited_index) {
 			list_add(&edge->stack_entry, &edge_stack);
 
 			vertex = edge->successor;
 			goto next_vertex;
 		}
 
-		if (edge->successor->on_stack)
+		if (edge->successor->index != unix_vertex_grouped_index)
 			vertex->lowlink = min(vertex->lowlink, edge->successor->index);
 next_edge:
 	}
@@ -264,7 +270,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
 			list_move_tail(&vertex->entry, &unix_visited_vertices);
 
-			vertex->on_stack = false;
+			vertex->index = unix_vertex_grouped_index;
 		}
 
 		list_del(&scc);
@@ -282,17 +288,15 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 static void unix_walk_scc(void)
 {
-	struct unix_vertex *vertex;
-
-	list_for_each_entry(vertex, &unix_unvisited_vertices, entry)
-		vertex->index = UNIX_VERTEX_INDEX_UNVISITED;
-
 	while (!list_empty(&unix_unvisited_vertices)) {
+		struct unix_vertex *vertex;
+
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
 		__unix_walk_scc(vertex);
 	}
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
+	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
 }
 
 static LIST_HEAD(gc_candidates);
-- 
2.30.2


