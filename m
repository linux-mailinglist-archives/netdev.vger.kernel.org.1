Return-Path: <netdev+bounces-81779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0CE88B15F
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19536305783
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF746444;
	Mon, 25 Mar 2024 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XNTVQEcu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1745972
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398551; cv=none; b=q8rDbd1HF/ai4Sw0UAdVgX6lGNWNmsd15RW+dPRJyrNK3RCbTSJtCrDa7IdtJG9paF0ccDSvFgp3hYyPrv/tVMyQeRY0Ofa46w8qZcl0C8KEkeb5SZ80+Iq38OtGYO2TZwVMA/6hpTLl9urgbTecoxHZPmlH1X/RPMxwvDqGZ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398551; c=relaxed/simple;
	bh=4RU+h+5donowN8bS3OtgmVLABK8LqXyfrHQiX4dXwJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKB8SluHkAsJ38/JnGdgPCHSHPIvYD1z1Kn/wuXvEeKXXeMk+WxOK/FKTrnH3FvHPQuH3yYIzH3msd6Pz9u0U7h5B6tLll1uIbbUD3fkp3yRAowH//8MXuwO89gp76LzkhFIXjXV2N0jqTBa4NyYDct0lylC3mZYXcvXuBkepC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XNTVQEcu; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711398548; x=1742934548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lJOQdYNUXyb8txp+ZSSVJSROSCRjARTHKFWayP/P3Vo=;
  b=XNTVQEcuC0eCVO77XvlOK5QXEAQW+T74e5iqzY800+UEv4LoODMzadlw
   E4yhroDWmAvcl3f0Xp8CO1VBrD2LkA8p6f3SaET7wQ3TKqKyiYxmXAYCN
   p7hj9C/sMUpulZwPiprMfagfRAEPUqKkk9bU5DO/pDJFVEe+QylKCg7RM
   A=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="643489446"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 20:29:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:10737]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.88:2525] with esmtp (Farcaster)
 id c37b3c0f-67ce-42a3-9dfc-6c80d9df32f9; Mon, 25 Mar 2024 20:29:04 +0000 (UTC)
X-Farcaster-Flow-ID: c37b3c0f-67ce-42a3-9dfc-6c80d9df32f9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:29:03 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Mon, 25 Mar 2024 20:29:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 11/15] af_unix: Avoid Tarjan's algorithm if unnecessary.
Date: Mon, 25 Mar 2024 13:24:21 -0700
Message-ID: <20240325202425.60930-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once a cyclic reference is formed, we need to run GC to check if
there is dead SCC.

However, we do not need to run Tarjan's algorithm if we know that
the shape of the inflight graph has not been changed.

If an edge is added/updated/deleted and the edge's successor is
inflight, we set false to unix_graph_grouped, which means we need
to re-classify SCC.

Once we finalise SCC, we set true to unix_graph_grouped.

While unix_graph_grouped is true, we can iterate the grouped
SCC using vertex->scc_entry in unix_walk_scc_fast().

list_add() and list_for_each_entry_reverse() uses seem weird, but
they are to keep the vertex order consistent and make writing test
easier.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 5a1fae78d6dc..654aa8e30a8b 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -113,6 +113,7 @@ static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
 }
 
 static bool unix_graph_maybe_cyclic;
+static bool unix_graph_grouped;
 
 static void unix_update_graph(struct unix_vertex *vertex)
 {
@@ -123,6 +124,7 @@ static void unix_update_graph(struct unix_vertex *vertex)
 		return;
 
 	unix_graph_maybe_cyclic = true;
+	unix_graph_grouped = false;
 }
 
 static LIST_HEAD(unix_unvisited_vertices);
@@ -144,6 +146,7 @@ static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 		vertex->index = unix_vertex_unvisited_index;
 		vertex->out_degree = 0;
 		INIT_LIST_HEAD(&vertex->edges);
+		INIT_LIST_HEAD(&vertex->scc_entry);
 
 		list_move_tail(&vertex->entry, &unix_unvisited_vertices);
 		edge->predecessor->vertex = vertex;
@@ -418,6 +421,26 @@ static void unix_walk_scc(void)
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
+
+	unix_graph_grouped = true;
+}
+
+static void unix_walk_scc_fast(void)
+{
+	while (!list_empty(&unix_unvisited_vertices)) {
+		struct unix_vertex *vertex;
+		struct list_head scc;
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
@@ -570,7 +593,10 @@ static void __unix_gc(struct work_struct *work)
 	if (!unix_graph_maybe_cyclic)
 		goto skip_gc;
 
-	unix_walk_scc();
+	if (unix_graph_grouped)
+		unix_walk_scc_fast();
+	else
+		unix_walk_scc();
 
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
-- 
2.30.2


