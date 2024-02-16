Return-Path: <netdev+bounces-72537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3AC8587B9
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744E6283299
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAF913B29C;
	Fri, 16 Feb 2024 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ecEe42zI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322013AA56
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117812; cv=none; b=QJvfG/T8AiT+g54MRAKhs2loIf+/DRhGthjGIot9UyaTVxW0Bz26d8ecYavhY4tHLsFOn8YjbZt2DTC4HWrk+xP2c+7adsbOvbHj7AYF8RLsWxbKtCb8g0WD0+BXXhskrgoqlrlp8e/32qhJZps7GlwP0gHLaL9Dno9tXlgItRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117812; c=relaxed/simple;
	bh=/kZiRb1yIFoJSVnUziampAWeEyV/3r8K0NTgu4ftgfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kxu8w6FK307Ucpslf64P2k2ymGOCqhhxSZIb4sr+6R/rMfhbN7R0HjR5m90F6BmxVvYio+gNJE7uaM3UDjyfYvpWpzeXD9lJXI8zKnr+37josH2hWa2n8RpphGYCUaXsIdDG6k/S/xzvLMPy0aqnJeJv7r18p8mOEMyKwHDRfuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ecEe42zI; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708117811; x=1739653811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vtnCMCUQF7ArhEzE0pVnCCGxDgoMWXbqrkikXkjoIWw=;
  b=ecEe42zIhdcNtTx0ZsunIas7rWWOK1i8OuzOQpPi4MG0d5Cpvt1f9E89
   r3T8uz6QAKPhETafy4flmH+uEYW13omnVs/UwwDZOB/EOjiHnOCzDWaQD
   uIwRC0WWReuWOWlYJcBBp553Y6OL6LKuyB9T4lx9R+/xRIyx5kSNUu9RJ
   s=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="381673179"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 21:10:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:41155]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.203:2525] with esmtp (Farcaster)
 id af8c69d7-8d0a-4ba2-8bb0-ad0a53fd645b; Fri, 16 Feb 2024 21:10:08 +0000 (UTC)
X-Farcaster-Flow-ID: af8c69d7-8d0a-4ba2-8bb0-ad0a53fd645b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:10:08 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:10:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 09/14] af_unix: Skip GC if no cycle exists.
Date: Fri, 16 Feb 2024 13:05:51 -0800
Message-ID: <20240216210556.65913-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We do not need to run GC if there is no possible cyclic reference.
We use unix_graph_maybe_cyclic to decide if we should run GC.

If a fd of an AF_UNIX socket is passed to an already inflight AF_UNIX
socket, they could form a cyclic reference.  Then, we set true to
unix_graph_maybe_cyclic and later run Tarjan's algorithm to group
them into SCC.

Once we run Tarjan's algorithm, we are 100% sure whether cyclic
references exist or not.  If there is no cycle, we set false to
unix_graph_maybe_cyclic and can skip the entire garbage collection
next time.

When finalising SCC, we set true to unix_graph_maybe_cyclic if SCC
consists of multiple vertices.

Even if SCC is a single vertex, a cycle might exist as self-fd passing.

To detect the corner case, we can check all edges of the vertex, but
instead, we add a new field that counts the number of self-references
to finish the decision in O(1) time.

With this change, __unix_gc() is just a spin_lock() dance in the normal
usage.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  1 +
 net/unix/garbage.c    | 56 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index b3ba5e949d62..59ec8d7880ce 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -36,6 +36,7 @@ struct unix_vertex {
 	struct list_head entry;
 	struct list_head scc_entry;
 	unsigned long out_degree;
+	unsigned long self_degree;
 	unsigned long index;
 	unsigned long lowlink;
 };
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index c4b0cc438c64..90f04d786dae 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -106,9 +106,23 @@ void unix_init_vertex(struct unix_sock *u)
 	struct unix_vertex *vertex = &u->vertex;
 
 	vertex->out_degree = 0;
+	vertex->self_degree = 0;
 	INIT_LIST_HEAD(&vertex->edges);
 }
 
+static bool unix_graph_maybe_cyclic;
+
+static void unix_graph_update(struct unix_edge *edge)
+{
+	if (unix_graph_maybe_cyclic)
+		return;
+
+	if (!edge->successor->out_degree)
+		return;
+
+	unix_graph_maybe_cyclic = true;
+}
+
 DEFINE_SPINLOCK(unix_gc_lock);
 static LIST_HEAD(unix_unvisited_vertices);
 unsigned int unix_tot_inflight;
@@ -144,6 +158,9 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 		edge->predecessor = &inflight->vertex;
 		edge->successor = successor;
 
+		if (edge->predecessor == edge->successor)
+			edge->predecessor->self_degree++;
+
 		if (!edge->predecessor->out_degree++) {
 			edge->predecessor->index = unix_vertex_unvisited_index;
 
@@ -154,6 +171,8 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 
 		if (receiver->listener)
 			list_add_tail(&edge->embryo_entry, &receiver->vertex.edges);
+
+		unix_graph_update(edge);
 	}
 
 	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + fpl->count_unix);
@@ -173,10 +192,15 @@ void unix_del_edges(struct scm_fp_list *fpl)
 	while (i < fpl->count_unix) {
 		struct unix_edge *edge = fpl->edges + i++;
 
+		unix_graph_update(edge);
+
 		list_del(&edge->entry);
 
 		if (!--edge->predecessor->out_degree)
 			list_del_init(&edge->predecessor->entry);
+
+		if (edge->predecessor == edge->successor)
+			edge->predecessor->self_degree--;
 	}
 
 	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
@@ -193,8 +217,14 @@ void unix_update_edges(struct unix_sock *receiver)
 
 	spin_lock(&unix_gc_lock);
 
-	list_for_each_entry(edge, &receiver->vertex.edges, embryo_entry)
+	list_for_each_entry(edge, &receiver->vertex.edges, embryo_entry) {
+		unix_graph_update(edge);
+
+		if (edge->predecessor == edge->successor)
+			edge->predecessor->self_degree--;
+
 		edge->successor = &receiver->vertex;
+	}
 
 	list_del_init(&receiver->vertex.edges);
 
@@ -224,6 +254,20 @@ void unix_free_edges(struct scm_fp_list *fpl)
 	kvfree(fpl->edges);
 }
 
+static bool unix_scc_cyclic(struct list_head *scc)
+{
+	struct unix_vertex *vertex;
+
+	if (!list_is_singular(scc))
+		return true;
+
+	vertex = list_first_entry(scc, typeof(*vertex), scc_entry);
+	if (vertex->self_degree)
+		return true;
+
+	return false;
+}
+
 static LIST_HEAD(unix_visited_vertices);
 static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 
@@ -272,6 +316,9 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			vertex->index = unix_vertex_grouped_index;
 		}
 
+		if (!unix_graph_maybe_cyclic)
+			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
+
 		list_del(&scc);
 	}
 
@@ -281,6 +328,8 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 static void unix_walk_scc(void)
 {
+	unix_graph_maybe_cyclic = false;
+
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
 
@@ -439,6 +488,9 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_lock(&unix_gc_lock);
 
+	if (!unix_graph_maybe_cyclic)
+		goto skip_gc;
+
 	unix_walk_scc();
 
 	/* First, select candidates for garbage collection.  Only
@@ -536,7 +588,7 @@ static void __unix_gc(struct work_struct *work)
 
 	/* All candidates should have been detached by now. */
 	WARN_ON_ONCE(!list_empty(&gc_candidates));
-
+skip_gc:
 	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
 	WRITE_ONCE(gc_in_progress, false);
 
-- 
2.30.2


