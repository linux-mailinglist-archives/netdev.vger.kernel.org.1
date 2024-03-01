Return-Path: <netdev+bounces-76406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F18286D9B7
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 03:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83A628314C
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5816A3A8CB;
	Fri,  1 Mar 2024 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PaPxaKHn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D44224D1
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709260010; cv=none; b=Jhb/HRpeUYNQ/bRAUqNhNkPxbRWuE992a9gTCAy7bo+MIRiU5obh4P7JA7vp0Ax5IZGxYB3NqUam39ApoMmVECRrU9kIeWG1DamM+2pCW1N8xMp27KIo65nO4pTa7WdNlkMFTcNLnlCd7MsrNuZ/HMlavgRR/loN4exX7rd8WUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709260010; c=relaxed/simple;
	bh=0kbNyoWJChyQZsQ/Xi2KLsRg1DIZAk3yoiMvY8C2NZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/j1il6CF9skdJJzqzYF3H3cRut2dEmjIGclPR73eFxvo+z5Q2BYnWkYw5DtNjttndmwPFBqNXkyWIfVMZS7HUJKv3yFiH7A/zokON8IbWl2x7tKCg6D1m584DZGMubqhJAiy1gmChWGOS39pYdlOgUSUPMx1NuzYADmDcmEdA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PaPxaKHn; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709260008; x=1740796008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=grLsVX9rjklIpE303xhCBzF6MFs9JhMsNle8Neqbzf4=;
  b=PaPxaKHnVZFk5/fYgoySWxay7Gioxm3gx8UpworohhiB2nCrpK9AnVZZ
   NLPr9Qisb4nyksig4x7nPva2TmWst994TlpFzAPAIRpQ2k465LjpxO4QT
   /SyWB6+9lHbZjdMlR/wuLbMInc63XmgKynEAaRBBW87wNRzM3JGwY3h7K
   E=;
X-IronPort-AV: E=Sophos;i="6.06,194,1705363200"; 
   d="scan'208";a="69866614"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 02:26:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:7459]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.165:2525] with esmtp (Farcaster)
 id d9b74466-ff90-4676-ab2b-bd034c67914f; Fri, 1 Mar 2024 02:26:46 +0000 (UTC)
X-Farcaster-Flow-ID: d9b74466-ff90-4676-ab2b-bd034c67914f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:26:44 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:26:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 09/15] af_unix: Save O(n) setup of Tarjan's algo.
Date: Thu, 29 Feb 2024 18:22:37 -0800
Message-ID: <20240301022243.73908-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
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

Then, we can know (i) that the vertex is on the stack if the index
of a visited vertex is >= 2 and (ii) that it is not on the stack and
belongs to a different SCC if the index is unix_vertex_grouped_index.

After the whole algorithm, all indices of vertices are set as
unix_vertex_grouped_index.

Next time we start DFS, we know that all unvisited vertices have
unix_vertex_grouped_index, and we can use unix_vertex_unvisited_index
as the not-on-stack marker.

To use the same variable in __unix_walk_scc(), we can swap
unix_vertex_(grouped|unvisited)_index at the end of Tarjan's
algorithm.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  1 -
 net/unix/garbage.c    | 26 +++++++++++++++-----------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 414463803b7e..ec040caaa4b5 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -37,7 +37,6 @@ struct unix_vertex {
 	unsigned long out_degree;
 	unsigned long index;
 	unsigned long lowlink;
-	bool on_stack;
 };
 
 struct unix_edge {
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 40a40028261b..3f55656c377e 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -115,16 +115,20 @@ static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
 static LIST_HEAD(unix_unvisited_vertices);
 
 enum unix_vertex_index {
-	UNIX_VERTEX_INDEX_UNVISITED,
+	UNIX_VERTEX_INDEX_MARK1,
+	UNIX_VERTEX_INDEX_MARK2,
 	UNIX_VERTEX_INDEX_START,
 };
 
+static unsigned long unix_vertex_unvisited_index = UNIX_VERTEX_INDEX_MARK1;
+
 static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
 	struct unix_vertex *vertex = edge->predecessor->vertex;
 
 	if (!vertex) {
 		vertex = list_first_entry(&fpl->vertices, typeof(*vertex), entry);
+		vertex->index = unix_vertex_unvisited_index;
 		vertex->out_degree = 0;
 		INIT_LIST_HEAD(&vertex->edges);
 
@@ -265,6 +269,7 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 }
 
 static LIST_HEAD(unix_visited_vertices);
+static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 
 static void __unix_walk_scc(struct unix_vertex *vertex)
 {
@@ -274,10 +279,10 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 	LIST_HEAD(edge_stack);
 
 next_vertex:
-	/* Push vertex to vertex_stack.
+	/* Push vertex to vertex_stack and mark it as on-stack
+	 * (index >= UNIX_VERTEX_INDEX_START).
 	 * The vertex will be popped when finalising SCC later.
 	 */
-	vertex->on_stack = true;
 	list_add(&vertex->scc_entry, &vertex_stack);
 
 	vertex->index = index;
@@ -291,7 +296,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 		if (!next_vertex)
 			continue;
 
-		if (next_vertex->index == UNIX_VERTEX_INDEX_UNVISITED) {
+		if (next_vertex->index == unix_vertex_unvisited_index) {
 			/* Iterative deepening depth first search
 			 *
 			 *   1. Push a forward edge to edge_stack and set
@@ -317,7 +322,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			 * to skip SCC finalisation.
 			 */
 			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
-		} else if (next_vertex->on_stack) {
+		} else if (next_vertex->index != unix_vertex_grouped_index) {
 			/* Loop detected by a back/cross edge.
 			 *
 			 * The successor is on vertex_stack, so two vertices are
@@ -344,7 +349,8 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			/* Don't restart DFS from this vertex in unix_walk_scc(). */
 			list_move_tail(&vertex->entry, &unix_visited_vertices);
 
-			vertex->on_stack = false;
+			/* Mark vertex as off-stack. */
+			vertex->index = unix_vertex_grouped_index;
 		}
 
 		list_del(&scc);
@@ -357,20 +363,18 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 static void unix_walk_scc(void)
 {
-	struct unix_vertex *vertex;
-
-	list_for_each_entry(vertex, &unix_unvisited_vertices, entry)
-		vertex->index = UNIX_VERTEX_INDEX_UNVISITED;
-
 	/* Visit every vertex exactly once.
 	 * __unix_walk_scc() moves visited vertices to unix_visited_vertices.
 	 */
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


