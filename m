Return-Path: <netdev+bounces-68765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124DC847FCE
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1249E1C2082D
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC126FD8;
	Sat,  3 Feb 2024 03:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ma4CRQzV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733179C0
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929500; cv=none; b=ZwB4Z0waNmvv5P8osRUspo/k9Jql318QUh52s3uuhtyntmwznoxtMrtMl9NaQtDCqHI7Q/k+Akhh/9fWx9Pe1qcWtOsERBRlCw+eTMbHAqf0o4d8SwzrB87mqVWdncAV0GCI53I7mZiRzuukyEbc1xYqIfeaskHfi5PK6yTZ96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929500; c=relaxed/simple;
	bh=zvF6bon/gW69Y4QEFRwrxYA828JR9BNKKwp0CIkEcLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ifk5FnVa6xi9Nd81XeWFMXpqMDhKICvGrDyloiMJRuyH4qG/mGhrIQf8I/pn17qLfoRKuL56UlBuoOiP9FF9s2J5Ui4BuzawOEw1I7QZFrSj01Bm/OqtzM83hoBllb/ficNAdoCMZwoElIIXRg8KxSy3sFGbexV8m/AnV+5ExOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ma4CRQzV; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929499; x=1738465499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qEIDte6FsKe2pKAoa8EkbTFi+SmGLHBNHRNKgb9VQyo=;
  b=ma4CRQzV7w3WFiI4fXjfI69buTmC0VNgux/Nn5ColbaAVNEuISUDNOpi
   ge40fYld5OWGAf0kw9MsgyZWvuvPnsfzq1lsVZJgVjR3oLhtIV6/XRufn
   +apTnzDTXBUx7tsH80afu+XA6jxFdm0GnrVloX2Hkh1O98sPBodnVh4jl
   0=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="635435894"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:04:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:61982]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.69:2525] with esmtp (Farcaster)
 id 3746c16c-ec84-48ae-8751-ff27d962b3cc; Sat, 3 Feb 2024 03:04:57 +0000 (UTC)
X-Farcaster-Flow-ID: 3746c16c-ec84-48ae-8751-ff27d962b3cc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:04:56 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:04:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 09/16] af_unix: Avoid Tarjan's algorithm if unnecessary.
Date: Fri, 2 Feb 2024 19:00:51 -0800
Message-ID: <20240203030058.60750-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In a typical use case, there should be no cyclic references, so we
should skip full cycle detection as much as possible.

Every time we add/delete/update an edge, we check if the successor
is already inflight.

The vertex does not form a cycle if the successor is not inflight.
Thus, we do not need to run Tarjan's algorithm.  Instead, we can
just iterate the already grouped SCC in unix_walk_scc_fast().

But if the successor is already in flight, we set unix_graph_updated
to true and do the grouping again later in unix_walk_scc().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 24137bf95e02..0f46df05a019 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -111,6 +111,19 @@ void unix_init_vertex(struct unix_sock *u)
 	INIT_LIST_HEAD(&vertex->scc_entry);
 }
 
+static bool unix_graph_updated;
+
+static void unix_graph_update(struct unix_edge *edge)
+{
+	if (unix_graph_updated)
+		return;
+
+	if (!edge->successor->out_degree)
+		return;
+
+	unix_graph_updated = true;
+}
+
 DEFINE_SPINLOCK(unix_gc_lock);
 static LIST_HEAD(unix_unvisited_vertices);
 unsigned int unix_tot_inflight;
@@ -159,6 +172,8 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 			INIT_LIST_HEAD(&edge->embryo_entry);
 			list_add_tail(&edge->embryo_entry, &receiver->vertex.edges);
 		}
+
+		unix_graph_update(edge);
 	}
 
 	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + fpl->count_unix);
@@ -178,6 +193,8 @@ void unix_del_edges(struct scm_fp_list *fpl)
 	while (i < fpl->count_unix) {
 		struct unix_edge *edge = fpl->edges + i++;
 
+		unix_graph_update(edge);
+
 		list_del(&edge->entry);
 
 		if (!--edge->predecessor->out_degree)
@@ -198,8 +215,11 @@ void unix_update_edges(struct unix_sock *receiver)
 
 	spin_lock(&unix_gc_lock);
 
-	list_for_each_entry(edge, &receiver->vertex.edges, embryo_entry)
+	list_for_each_entry(edge, &receiver->vertex.edges, embryo_entry) {
+		unix_graph_update(edge);
+
 		edge->successor = &receiver->vertex;
+	}
 
 	list_del_init(&receiver->vertex.edges);
 
@@ -297,6 +317,25 @@ static void unix_walk_scc(void)
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
+	unix_graph_updated = false;
+}
+
+static void unix_walk_scc_fast(void)
+{
+	while (!list_empty(&unix_unvisited_vertices)) {
+		struct unix_vertex *vertex;
+		LIST_HEAD(scc);
+
+		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
+		list_add(&scc, &vertex->scc_entry);
+
+		list_for_each_entry_reverse(vertex, &scc, scc_entry)
+			list_move_tail(&vertex->entry, &unix_visited_vertices);
+
+		list_del(&scc);
+	}
+
+	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 }
 
 static LIST_HEAD(gc_candidates);
@@ -446,7 +485,10 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_lock(&unix_gc_lock);
 
-	unix_walk_scc();
+	if (unix_graph_updated)
+		unix_walk_scc();
+	else
+		unix_walk_scc_fast();
 
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
-- 
2.30.2


