Return-Path: <netdev+bounces-81778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4391388B15E
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4E330674F
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074EC45C08;
	Mon, 25 Mar 2024 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HrN3rUAY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586BE45037
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398542; cv=none; b=YvOxvXWVQ8WOsTcP5GkFOWx7ivzBaJ1e8ro/Z3HhitBoqmo1yGN9cyhQIudVv/n8QCX0Mu9ZFtCjzA1w6VZ7gj58GPPUvG/u+BbqBB2CEfzIBh44fMYyZsWlcn+sS1e/z1QAxIe+EQ3H4mfCpLmmjd1EVVP/K2h3uHfnEOt3H+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398542; c=relaxed/simple;
	bh=oHc5lY+1upZyboSRysdLhLg6IEQJYdqe+Zf0MKp/Uo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVWZn5oTj1JjXKDdyoMS9w1Vh7GwOLlndyibzowk4anL6liCghTSAE1mJxm0AuE7jC0Oe9Md7Eh1njb3LhGEeQG02tyVYiS0fAWD0idv/xtks3BNQu9aEAn4ipr3ORkwzmWVZQAeXB+ar0bMO+7Ioor54yXiH9DggxBabMWD9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HrN3rUAY; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711398541; x=1742934541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QnSXI56Eclyl3I2hheFsjL3bUFOtceUbzamdSwVdlqs=;
  b=HrN3rUAYc4VnrfYfHirZDM5gcsj+adM2C4zdW2XRAzZyLoHqwtyvo47D
   4LAUps6i+mpcvXAeQdWDIxU/fzUaZT+0BMTxZ9deMfCt6WzsEvpVXKekK
   0wDmml/YfS0BrITljIyIg9vZiYGzumMYycXp0brJLNGGB498RrhiIbJuw
   8=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="406641177"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 20:28:43 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:9185]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.164:2525] with esmtp (Farcaster)
 id c1fa2a4b-452f-4547-a356-32735a71d3c6; Mon, 25 Mar 2024 20:28:42 +0000 (UTC)
X-Farcaster-Flow-ID: c1fa2a4b-452f-4547-a356-32735a71d3c6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:28:39 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:28:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 10/15] af_unix: Skip GC if no cycle exists.
Date: Mon, 25 Mar 2024 13:24:20 -0700
Message-ID: <20240325202425.60930-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
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
Given the corner case is rare, we detect it by checking all edges of
the vertex and set true to unix_graph_maybe_cyclic.

With this change, __unix_gc() is just a spin_lock() dance in the normal
usage.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 48 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index cec6189126ba..5a1fae78d6dc 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -112,6 +112,19 @@ static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
 	return edge->successor->vertex;
 }
 
+static bool unix_graph_maybe_cyclic;
+
+static void unix_update_graph(struct unix_vertex *vertex)
+{
+	/* If the receiver socket is not inflight, no cyclic
+	 * reference could be formed.
+	 */
+	if (!vertex)
+		return;
+
+	unix_graph_maybe_cyclic = true;
+}
+
 static LIST_HEAD(unix_unvisited_vertices);
 
 enum unix_vertex_index {
@@ -138,12 +151,16 @@ static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 
 	vertex->out_degree++;
 	list_add_tail(&edge->vertex_entry, &vertex->edges);
+
+	unix_update_graph(unix_edge_successor(edge));
 }
 
 static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
 	struct unix_vertex *vertex = edge->predecessor->vertex;
 
+	unix_update_graph(unix_edge_successor(edge));
+
 	list_del(&edge->vertex_entry);
 	vertex->out_degree--;
 
@@ -227,6 +244,7 @@ void unix_del_edges(struct scm_fp_list *fpl)
 void unix_update_edges(struct unix_sock *receiver)
 {
 	spin_lock(&unix_gc_lock);
+	unix_update_graph(unix_sk(receiver->listener)->vertex);
 	receiver->listener = NULL;
 	spin_unlock(&unix_gc_lock);
 }
@@ -268,6 +286,26 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
+static bool unix_scc_cyclic(struct list_head *scc)
+{
+	struct unix_vertex *vertex;
+	struct unix_edge *edge;
+
+	/* SCC containing multiple vertices ? */
+	if (!list_is_singular(scc))
+		return true;
+
+	vertex = list_first_entry(scc, typeof(*vertex), scc_entry);
+
+	/* Self-reference or a embryo-listener circle ? */
+	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
+		if (unix_edge_successor(edge) == vertex)
+			return true;
+	}
+
+	return false;
+}
+
 static LIST_HEAD(unix_visited_vertices);
 static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 
@@ -353,6 +391,9 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			vertex->index = unix_vertex_grouped_index;
 		}
 
+		if (!unix_graph_maybe_cyclic)
+			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
+
 		list_del(&scc);
 	}
 
@@ -363,6 +404,8 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 static void unix_walk_scc(void)
 {
+	unix_graph_maybe_cyclic = false;
+
 	/* Visit every vertex exactly once.
 	 * __unix_walk_scc() moves visited vertices to unix_visited_vertices.
 	 */
@@ -524,6 +567,9 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_lock(&unix_gc_lock);
 
+	if (!unix_graph_maybe_cyclic)
+		goto skip_gc;
+
 	unix_walk_scc();
 
 	/* First, select candidates for garbage collection.  Only
@@ -617,7 +663,7 @@ static void __unix_gc(struct work_struct *work)
 
 	/* All candidates should have been detached by now. */
 	WARN_ON_ONCE(!list_empty(&gc_candidates));
-
+skip_gc:
 	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
 	WRITE_ONCE(gc_in_progress, false);
 
-- 
2.30.2


