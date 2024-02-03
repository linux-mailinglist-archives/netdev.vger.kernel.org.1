Return-Path: <netdev+bounces-68766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 394E6847FCF
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE671F2570B
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC2B7464;
	Sat,  3 Feb 2024 03:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LoGQd1wq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B879C6
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929525; cv=none; b=lqVmbZda7gbI4cSb6uqWgE0IrciFoYjaGLs9KDcPz6iurx0c4n+tLVUkPMxbZu+cfmtLhFXcF06ef0w/mVZUEp3DNbwEv4l97kKJh4GGWT2PhPx9fosbES1GaqZnwQHPCciM1rMzNdkbc/e1RwasZWaXSjynk7RAmbFExg+dGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929525; c=relaxed/simple;
	bh=mqa9wMjyKPIrGlXTENHxrsqbk/EkYl9AVtVEY/m4ub4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEfCW/XjPvAcZspYP2Bz9m6fXPbpyfHpmVEyW4bYsVNTKghhNvFfrojNulWqT4YLR9MfcWbJTVd3oPD8O2cA2q+VwzykxpUieMBrKxNLZieGr7ZgnhNu0FUf+JriMU8UOwb+MZPvZD0mqrVC4eJbU3kJPSxqg9S9o3QYHC4KCjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LoGQd1wq; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929524; x=1738465524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7UakUoJro4RmeeEv/43fuBfuMIWMSIu6IbW/EpP7hT8=;
  b=LoGQd1wqgOHORHYm9RhB9IJ4ofAoy5QfdoCAknq6pcINH8pMG6xyEWZa
   gjnDeOjdG3Nvf+3T6GT0vAYhD72Xig3KRL2DmCw0oKv7kiq2H4DLaUJTx
   nsTX5Oa1IDMpjkaHxnziPee0E3iSgUR5MfRpbU1s+EWw7oFbxlZVSzH3Z
   U=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="384065108"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:05:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:27277]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.239:2525] with esmtp (Farcaster)
 id 2b383267-85df-484a-bc00-8723fe22c87b; Sat, 3 Feb 2024 03:05:21 +0000 (UTC)
X-Farcaster-Flow-ID: 2b383267-85df-484a-bc00-8723fe22c87b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:05:21 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:05:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 10/16] af_unix: Skip GC if no cycle exists.
Date: Fri, 2 Feb 2024 19:00:52 -0800
Message-ID: <20240203030058.60750-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once we run Tarjan's algorithm, we know whether cyclic references
exist.  If there is no cycle, we set unix_graph_maybe_cyclic to
false and can skip the entire garbage collection next time.

When finalising SCC, we set unix_graph_maybe_cyclic to true if SCC
consists of multiple vertices.

Even if SCC is a single vertex, a cycle might exist as self-fd passing.

To detect the corner case, we can check all edges of the vertex, but
instead, we add a new field that counts the number of self-references
to finish the decision in O(1).

With this change, __unix_gc() is just a spin_lock dance in the normal
usage.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  1 +
 net/unix/garbage.c    | 27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

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
index 0f46df05a019..cbddca5d8dd1 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -106,12 +106,14 @@ void unix_init_vertex(struct unix_sock *u)
 	struct unix_vertex *vertex = &u->vertex;
 
 	vertex->out_degree = 0;
+	vertex->self_degree = 0;
 	INIT_LIST_HEAD(&vertex->edges);
 	INIT_LIST_HEAD(&vertex->entry);
 	INIT_LIST_HEAD(&vertex->scc_entry);
 }
 
 static bool unix_graph_updated;
+static bool unix_graph_maybe_cyclic;
 
 static void unix_graph_update(struct unix_edge *edge)
 {
@@ -122,6 +124,7 @@ static void unix_graph_update(struct unix_edge *edge)
 		return;
 
 	unix_graph_updated = true;
+	unix_graph_maybe_cyclic = true;
 }
 
 DEFINE_SPINLOCK(unix_gc_lock);
@@ -159,6 +162,9 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 		edge->predecessor = &inflight->vertex;
 		edge->successor = successor;
 
+		if (edge->predecessor == edge->successor)
+			edge->predecessor->self_degree++;
+
 		if (!edge->predecessor->out_degree++) {
 			edge->predecessor->index = unix_vertex_unvisited_index;
 
@@ -199,6 +205,9 @@ void unix_del_edges(struct scm_fp_list *fpl)
 
 		if (!--edge->predecessor->out_degree)
 			list_del_init(&edge->predecessor->entry);
+
+		if (edge->predecessor == edge->successor)
+			edge->predecessor->self_degree--;
 	}
 
 	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
@@ -218,6 +227,9 @@ void unix_update_edges(struct unix_sock *receiver)
 	list_for_each_entry(edge, &receiver->vertex.edges, embryo_entry) {
 		unix_graph_update(edge);
 
+		if (edge->predecessor == edge->successor)
+			edge->predecessor->self_degree--;
+
 		edge->successor = &receiver->vertex;
 	}
 
@@ -293,6 +305,14 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			vertex->index = unix_vertex_grouped_index;
 		}
 
+		if (!list_is_singular(&scc)) {
+			unix_graph_maybe_cyclic = true;
+		} else {
+			vertex = list_first_entry(&scc, typeof(*vertex), scc_entry);
+			if (vertex->self_degree)
+				unix_graph_maybe_cyclic = true;
+		}
+
 		list_del(&scc);
 	}
 
@@ -308,6 +328,8 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 static void unix_walk_scc(void)
 {
+	unix_graph_maybe_cyclic = false;
+
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
 
@@ -485,6 +507,9 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_lock(&unix_gc_lock);
 
+	if (!unix_graph_maybe_cyclic)
+		goto skip_gc;
+
 	if (unix_graph_updated)
 		unix_walk_scc();
 	else
@@ -573,7 +598,7 @@ static void __unix_gc(struct work_struct *work)
 
 	/* All candidates should have been detached by now. */
 	WARN_ON_ONCE(!list_empty(&gc_candidates));
-
+skip_gc:
 	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
 	WRITE_ONCE(gc_in_progress, false);
 
-- 
2.30.2


