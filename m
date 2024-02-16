Return-Path: <netdev+bounces-72536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F468587B7
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B111F21EEA
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80181419A2;
	Fri, 16 Feb 2024 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qQ0RtDgj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D6913B29C
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117793; cv=none; b=LNtILpvPkk1pscRWptRqjvN2Nt2M2F00gUAOeDLmExsEJLNh5+NxFAu4X2HYo5DLtJnuEfK2BQfwN0oNUjchVj73r7j0jXZBZgHWmbjLQO3bcyQbeESL948e6IbeSb9AGFSmwVpEqYeLkCnSTDy1DX7rB53Y9W4Z7KnFO0WNhws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117793; c=relaxed/simple;
	bh=8l2IQcj/DxcpYYAKGZMLOrPBJKyixD4ON4AJleqr1UI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnJ3ZEVmAsq3kDlrAigP3dXnE5FCPKDYJMF54NUNQm16nZ3tNPfKVG7uLMl7t1QNwxANGBurM3nVlbgE4ZCP8na2yHTTmwre15ReAIEK8BTP5KRjULq1LffOY4z/YGTRLrrnHW4wCY0JD/4Y8OB+j+2RTcu61/AjJ1/Da/0TGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qQ0RtDgj; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708117793; x=1739653793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=flBnMQuUWz5Ku01zH+goXy5ogq60Z4U0TsGH1/1+M04=;
  b=qQ0RtDgjZAZfe+3Ye576+OjdEuzi/znWwg6UyHnPJq2uxT0i4nPR32Cv
   FDt/UOP3cIs49MIP1C+WZB6dsGA3+UYfsS4GLqlqW2CTIEohHujUgFsR+
   96DAbmxS4itMnVR5UFzAYhfYd/cEzr/tmCVSkXlWSnTYdRRqEM/uxe0P1
   g=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="327503569"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 21:09:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:11508]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.174:2525] with esmtp (Farcaster)
 id 44cf3147-5a15-4227-a056-630072136d3e; Fri, 16 Feb 2024 21:09:43 +0000 (UTC)
X-Farcaster-Flow-ID: 44cf3147-5a15-4227-a056-630072136d3e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:09:43 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:09:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 08/14] af_unix: Save O(n) setup of Tarjan's algo.
Date: Fri, 16 Feb 2024 13:05:50 -0800
Message-ID: <20240216210556.65913-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
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
index 88f370307c80..c4b0cc438c64 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -113,6 +113,14 @@ DEFINE_SPINLOCK(unix_gc_lock);
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
@@ -136,8 +144,11 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 		edge->predecessor = &inflight->vertex;
 		edge->successor = successor;
 
-		if (!edge->predecessor->out_degree++)
+		if (!edge->predecessor->out_degree++) {
+			edge->predecessor->index = unix_vertex_unvisited_index;
+
 			list_add_tail(&edge->predecessor->entry, &unix_unvisited_vertices);
+		}
 
 		list_add_tail(&edge->entry, &edge->predecessor->edges);
 
@@ -213,12 +224,8 @@ void unix_free_edges(struct scm_fp_list *fpl)
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
@@ -232,14 +239,13 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 	vertex->lowlink = index;
 	index++;
 
-	vertex->on_stack = true;
 	list_add(&vertex->scc_entry, &vertex_stack);
 
 	list_for_each_entry(edge, &vertex->edges, entry) {
 		if (!edge->successor->out_degree)
 			continue;
 
-		if (edge->successor->index == UNIX_VERTEX_INDEX_UNVISITED) {
+		if (edge->successor->index == unix_vertex_unvisited_index) {
 			list_add(&edge->stack_entry, &edge_stack);
 
 			vertex = edge->successor;
@@ -250,7 +256,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 			vertex = edge->predecessor;
 			vertex->lowlink = min(vertex->lowlink, edge->successor->lowlink);
-		} else if (edge->successor->on_stack) {
+		} else if (edge->successor->index != unix_vertex_grouped_index) {
 			vertex->lowlink = min(vertex->lowlink, edge->successor->index);
 		}
 	}
@@ -263,7 +269,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
 			list_move_tail(&vertex->entry, &unix_visited_vertices);
 
-			vertex->on_stack = false;
+			vertex->index = unix_vertex_grouped_index;
 		}
 
 		list_del(&scc);
@@ -275,17 +281,15 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
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


