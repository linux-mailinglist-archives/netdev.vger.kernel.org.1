Return-Path: <netdev+bounces-74596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8843861F37
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B5D1C23C23
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 21:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC6814CAA7;
	Fri, 23 Feb 2024 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HJ8IBVN9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1A149388
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724630; cv=none; b=G2wE/dcCqzCzULUCUCsHjOtwoHYbKAUClbA1Bqu+PGYyGpO3tUfmAICoScHK+vCiHu0xSZTs0jXvRcWAadOKK7IgSlRk29Cuhwl+0eZpx/4ipk6AauwIV2g5Jmy2lFBksGcieafUpHzqZnNIVpgdsd8/KK6WsQispTD6eTzTi84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724630; c=relaxed/simple;
	bh=foGhaZ4RKL53QyewcUle6fezrl8/29cd9NXAJpMITjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ErUuYmFcG4yNmqqCEGsaP/xZaaovpdzUWGIaOc4uNMWRB4cmRjF9JZR+epYvwMMeDzxrcowl9Lx0kU+lgyMDYppwtZLNHKGooRFCcd6eZZT46nQ10SXTjtwVtH/BE4OuYUzxHaxTfKMleFmsxm8nwuOAVcxnHWAor5obeBwN4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HJ8IBVN9; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708724628; x=1740260628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oMudsZ6SlzLVP8C3qThUZJlSPRoeY/TNX/CcDjR/xVc=;
  b=HJ8IBVN9nFBo/DS6ikG2khHnHZSp6GdanDQx0xXCgGbJwHzH/3r/lHTR
   nMXF32v3rpOT+Xf3q+MwLVNINLDXmujcCrNl4BKFk+Pt3+XjUjwIP8Fd0
   OXvKLVyClwmlZd2NVOMcp1yzwZeHPz85qdQ/c18As/QDvhNG7rjaq4nml
   w=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="640117864"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 21:43:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:2576]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.154:2525] with esmtp (Farcaster)
 id ddfabf47-698e-48c7-be88-ebc2a3bbdafe; Fri, 23 Feb 2024 21:43:44 +0000 (UTC)
X-Farcaster-Flow-ID: ddfabf47-698e-48c7-be88-ebc2a3bbdafe
Received: from EX19D004ANA003.ant.amazon.com (10.37.240.184) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 21:43:42 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.9) by
 EX19D004ANA003.ant.amazon.com (10.37.240.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Fri, 23 Feb 2024 21:43:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 08/14] af_unix: Save O(n) setup of Tarjan's algo.
Date: Fri, 23 Feb 2024 13:39:57 -0800
Message-ID: <20240223214003.17369-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA003.ant.amazon.com (10.37.240.184)

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
 net/unix/garbage.c    | 22 ++++++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

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
index a21dbbbd9bc7..a2cd24ee953b 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -112,16 +112,20 @@ static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
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
 
@@ -266,6 +270,7 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 }
 
 static LIST_HEAD(unix_visited_vertices);
+static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 
 static void __unix_walk_scc(struct unix_vertex *vertex)
 {
@@ -279,7 +284,6 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 	vertex->lowlink = index;
 	index++;
 
-	vertex->on_stack = true;
 	list_add(&vertex->scc_entry, &vertex_stack);
 
 	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
@@ -288,7 +292,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 		if (!next_vertex)
 			continue;
 
-		if (next_vertex->index == UNIX_VERTEX_INDEX_UNVISITED) {
+		if (next_vertex->index == unix_vertex_unvisited_index) {
 			list_add(&edge->stack_entry, &edge_stack);
 
 			vertex = next_vertex;
@@ -302,7 +306,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			vertex = edge->predecessor->vertex;
 
 			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
-		} else if (edge->successor->vertex->on_stack) {
+		} else if (next_vertex->index != unix_vertex_grouped_index) {
 			vertex->lowlink = min(vertex->lowlink, next_vertex->index);
 		}
 	}
@@ -315,7 +319,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
 			list_move_tail(&vertex->entry, &unix_visited_vertices);
 
-			vertex->on_stack = false;
+			vertex->index = unix_vertex_grouped_index;
 		}
 
 		list_del(&scc);
@@ -327,17 +331,15 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
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


