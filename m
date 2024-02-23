Return-Path: <netdev+bounces-74597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB895861F38
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05591C23932
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736E41493AC;
	Fri, 23 Feb 2024 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vnDikkAs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6C1493A5
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724652; cv=none; b=MDoBz8IXLdqH0E4IxMud3YpVkkPjZ5HkQFtCwHNa6pl8mW3jmYyKAcc2yxGMwepCXmJ/bqvcMIbOH/oTKfDF1nfo1WeG14T5mFI3SaQF0OFHXRLxlgwsPpBDrdrKQGe6k/WCvmH+fVFqwlv/J+iEXP5gj/68yf8+k57NgzIBEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724652; c=relaxed/simple;
	bh=vyPHFsYy+8ltNjBmfIne5QhgppWWdroRFbjJhO4zyo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuQpdVG1gWGK3W8S0OKGb+O1VHJZCBGiDYMADVpcwj7kTxCNkpRVzcK8dGVkFpXkuRPKVnQT1Yabe3bXXClTBmNSOVy1Kt8pMYlCd5jMye5IIX+7wEaDDSWfd06oeATaDJIavOgsfssmezfIQTiyWec4qRbAE5ocIBjb9mxoXLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vnDikkAs; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708724651; x=1740260651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vRTgDQ9UOFexuvV8bRclfeaMJUgz63h5oJNEuEp8ya8=;
  b=vnDikkAsh/G4J9SKek5jn8LHkdDXN0QGxAyxNI1mRG8zdpHoxa59rBuO
   l90VM1pYUuMmRL6WJY/X7GczEB9OHeDeWmJVKdV4f27PtpxHnJKYJf/Ax
   pAFC/xkp9/LPMtVWsnOHlErC8YS4VAJddBEA/l9rR7ok3mp7kpM/n1hu/
   U=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="275499484"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 21:44:08 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:34406]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.236:2525] with esmtp (Farcaster)
 id f3b6900e-48ff-4edd-bc34-558666b41b11; Fri, 23 Feb 2024 21:44:07 +0000 (UTC)
X-Farcaster-Flow-ID: f3b6900e-48ff-4edd-bc34-558666b41b11
Received: from EX19D004ANA003.ant.amazon.com (10.37.240.184) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 21:44:07 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.9) by
 EX19D004ANA003.ant.amazon.com (10.37.240.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 21:44:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 09/14] af_unix: Skip GC if no cycle exists.
Date: Fri, 23 Feb 2024 13:39:58 -0800
Message-ID: <20240223214003.17369-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA003.ant.amazon.com (10.37.240.184)

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
 net/unix/garbage.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index a2cd24ee953b..28506b32dcb2 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -109,6 +109,19 @@ static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
 	return edge->successor->vertex;
 }
 
+static bool unix_graph_maybe_cyclic;
+
+static void unix_graph_update(struct unix_vertex *vertex)
+{
+	if (unix_graph_maybe_cyclic)
+		return;
+
+	if (!vertex)
+		return;
+
+	unix_graph_maybe_cyclic = true;
+}
+
 static LIST_HEAD(unix_unvisited_vertices);
 
 enum unix_vertex_index {
@@ -137,12 +150,14 @@ static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 	vertex->out_degree++;
 
 	list_add_tail(&edge->vertex_entry, &vertex->edges);
+	unix_graph_update(unix_edge_successor(edge));
 }
 
 static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
 	struct unix_vertex *vertex = edge->predecessor->vertex;
 
+	unix_graph_update(unix_edge_successor(edge));
 	list_del(&edge->vertex_entry);
 
 	vertex->out_degree--;
@@ -228,6 +243,7 @@ void unix_del_edges(struct scm_fp_list *fpl)
 void unix_update_edges(struct unix_sock *receiver)
 {
 	spin_lock(&unix_gc_lock);
+	unix_graph_update(unix_sk(receiver->listener)->vertex);
 	receiver->listener = NULL;
 	spin_unlock(&unix_gc_lock);
 }
@@ -269,6 +285,24 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
+static bool unix_scc_cyclic(struct list_head *scc)
+{
+	struct unix_vertex *vertex;
+	struct unix_edge *edge;
+
+	if (!list_is_singular(scc))
+		return true;
+
+	vertex = list_first_entry(scc, typeof(*vertex), scc_entry);
+
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
 
@@ -322,6 +356,9 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			vertex->index = unix_vertex_grouped_index;
 		}
 
+		if (!unix_graph_maybe_cyclic)
+			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
+
 		list_del(&scc);
 	}
 
@@ -331,6 +368,8 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 static void unix_walk_scc(void)
 {
+	unix_graph_maybe_cyclic = false;
+
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
 
@@ -489,6 +528,9 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_lock(&unix_gc_lock);
 
+	if (!unix_graph_maybe_cyclic)
+		goto skip_gc;
+
 	unix_walk_scc();
 
 	/* First, select candidates for garbage collection.  Only
@@ -582,7 +624,7 @@ static void __unix_gc(struct work_struct *work)
 
 	/* All candidates should have been detached by now. */
 	WARN_ON_ONCE(!list_empty(&gc_candidates));
-
+skip_gc:
 	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
 	WRITE_ONCE(gc_in_progress, false);
 
-- 
2.30.2


