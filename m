Return-Path: <netdev+bounces-81780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D31788B161
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B430F1FA3CA6
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6794245C08;
	Mon, 25 Mar 2024 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mEn1toaG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9114645972
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398573; cv=none; b=azWbv+wVAHTfdtHWEdmkpkmVrmmI9i07oMRn47ewARnnJkuJxBwEcBpISReIIlaH43dLytMNAH6sndEVI3CnxtPrmGLaxhwtE7jiNzBADGcVRZrP7Fgk0cpjkG+SFZW343XZokGTMKjkOPBLtjBvaMwlGCPFUaBBjV9/GSYNuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398573; c=relaxed/simple;
	bh=w0Vrdmdimm8UuYquSrqMFzVpPdChLb0CELUeZejvTuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9w751U/czcke/uYMO22IJ5evTZihZHEWYdWw5GiPRVCezRLsJdjyomPI0lK1zbqa4xoeuArJQVbfEHKSRJ1mK9nqLrvQk/PMHHrXLBeCe77JLoQYzj+3D4QHwv5oRqMgdD/Z/OdaZzb3t6EFPl0hV7LYahCSr9VxSfYODxhmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mEn1toaG; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711398571; x=1742934571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lhheo73g5CW3+CtsXsEdNPrtaQcTOOYkkOFc6juVERk=;
  b=mEn1toaGPNQknfvQ1dPSPlgeJ1G4lTMP8EMjvTWyzHlnNrwRr0OGqDgx
   ysToLpf70RNIHGxxeeMh9Tol8u03TNmCZ8D567BlqAWUS7tKRZdGGHW8m
   DkkJSa/ryURySkesvdC85oIIOJs87yzdDcQr85p4Ltw3TcgsKDEMgv9Lo
   M=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="647498465"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 20:29:29 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:43667]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.246:2525] with esmtp (Farcaster)
 id 28f6a9a3-20fb-4d07-b4c4-7d2cd473f1be; Mon, 25 Mar 2024 20:29:28 +0000 (UTC)
X-Farcaster-Flow-ID: 28f6a9a3-20fb-4d07-b4c4-7d2cd473f1be
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:29:27 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 25 Mar 2024 20:29:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 12/15] af_unix: Assign a unique index to SCC.
Date: Mon, 25 Mar 2024 13:24:22 -0700
Message-ID: <20240325202425.60930-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The definition of the lowlink in Tarjan's algorithm is the
smallest index of a vertex that is reachable with at most one
back-edge in SCC.  This is not useful for a cross-edge.

If we start traversing from A in the following graph, the final
lowlink of D is 3.  The cross-edge here is one between D and C.

  A -> B -> D   D = (4, 3)  (index, lowlink)
  ^    |    |   C = (3, 1)
  |    V    |   B = (2, 1)
  `--- C <--'   A = (1, 1)

This is because the lowlink of D is updated with the index of C.

In the following patch, we detect a dead SCC by checking two
conditions for each vertex.

  1) vertex has no edge directed to another SCC (no bridge)
  2) vertex's out_degree is the same as the refcount of its file

If 1) is false, there is a receiver of all fds of the SCC and
its ancestor SCC.

To evaluate 1), we need to assign a unique index to each SCC and
assign it to all vertices in the SCC.

This patch changes the lowlink update logic for cross-edge so
that in the example above, the lowlink of D is updated with the
lowlink of C.

  A -> B -> D   D = (4, 1)  (index, lowlink)
  ^    |    |   C = (3, 1)
  |    V    |   B = (2, 1)
  `--- C <--'   A = (1, 1)

Then, all vertices in the same SCC have the same lowlink, and we
can quickly find the bridge connecting to different SCC if exists.

However, it is no longer called lowlink, so we rename it to
scc_index.  (It's sometimes called lowpoint.)

Also, we add a global variable to hold the last index used in DFS
so that we do not reset the initial index in each DFS.

This patch can be squashed to the SCC detection patch but is
split deliberately for anyone wondering why lowlink is not used
as used in the original Tarjan's algorithm and many reference
implementations.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  2 +-
 net/unix/garbage.c    | 29 +++++++++++++++--------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index ec040caaa4b5..696d997a5ac9 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -36,7 +36,7 @@ struct unix_vertex {
 	struct list_head scc_entry;
 	unsigned long out_degree;
 	unsigned long index;
-	unsigned long lowlink;
+	unsigned long scc_index;
 };
 
 struct unix_edge {
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 654aa8e30a8b..3f59cee3ccbc 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -312,9 +312,8 @@ static bool unix_scc_cyclic(struct list_head *scc)
 static LIST_HEAD(unix_visited_vertices);
 static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 
-static void __unix_walk_scc(struct unix_vertex *vertex)
+static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_index)
 {
-	unsigned long index = UNIX_VERTEX_INDEX_START;
 	LIST_HEAD(vertex_stack);
 	struct unix_edge *edge;
 	LIST_HEAD(edge_stack);
@@ -326,9 +325,9 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 	 */
 	list_add(&vertex->scc_entry, &vertex_stack);
 
-	vertex->index = index;
-	vertex->lowlink = index;
-	index++;
+	vertex->index = *last_index;
+	vertex->scc_index = *last_index;
+	(*last_index)++;
 
 	/* Explore neighbour vertices (receivers of the current vertex's fd). */
 	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
@@ -358,30 +357,30 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			next_vertex = vertex;
 			vertex = edge->predecessor->vertex;
 
-			/* If the successor has a smaller lowlink, two vertices
-			 * are in the same SCC, so propagate the smaller lowlink
+			/* If the successor has a smaller scc_index, two vertices
+			 * are in the same SCC, so propagate the smaller scc_index
 			 * to skip SCC finalisation.
 			 */
-			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
+			vertex->scc_index = min(vertex->scc_index, next_vertex->scc_index);
 		} else if (next_vertex->index != unix_vertex_grouped_index) {
 			/* Loop detected by a back/cross edge.
 			 *
-			 * The successor is on vertex_stack, so two vertices are
-			 * in the same SCC.  If the successor has a smaller index,
+			 * The successor is on vertex_stack, so two vertices are in
+			 * the same SCC.  If the successor has a smaller *scc_index*,
 			 * propagate it to skip SCC finalisation.
 			 */
-			vertex->lowlink = min(vertex->lowlink, next_vertex->index);
+			vertex->scc_index = min(vertex->scc_index, next_vertex->scc_index);
 		} else {
 			/* The successor was already grouped as another SCC */
 		}
 	}
 
-	if (vertex->index == vertex->lowlink) {
+	if (vertex->index == vertex->scc_index) {
 		struct list_head scc;
 
 		/* SCC finalised.
 		 *
-		 * If the lowlink was not updated, all the vertices above on
+		 * If the scc_index was not updated, all the vertices above on
 		 * vertex_stack are in the same SCC.  Group them using scc_entry.
 		 */
 		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
@@ -407,6 +406,8 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 static void unix_walk_scc(void)
 {
+	unsigned long last_index = UNIX_VERTEX_INDEX_START;
+
 	unix_graph_maybe_cyclic = false;
 
 	/* Visit every vertex exactly once.
@@ -416,7 +417,7 @@ static void unix_walk_scc(void)
 		struct unix_vertex *vertex;
 
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
-		__unix_walk_scc(vertex);
+		__unix_walk_scc(vertex, &last_index);
 	}
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
-- 
2.30.2


