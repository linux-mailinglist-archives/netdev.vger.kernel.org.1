Return-Path: <netdev+bounces-76407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6767B86D9B8
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 03:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02B5283013
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA70F3A8D6;
	Fri,  1 Mar 2024 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B8gBvtIW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6975F224D1
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709260031; cv=none; b=NI16IEGNavKzOOBJqKaDzzwvaMM5ozGI6Y2weeAB3sA/POTpfey8oES2vs+nNUfqpu03XrdujnYV/jDMr1ERiJXGLa8IMrdfvJfjp1o0L3EohdxbWDd6Ql1sHDB+RMe/hSo9YaGObKCEGkSya6bOZdwRuwOWPOqIJp0+iVOobFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709260031; c=relaxed/simple;
	bh=lmWvJRjgg19m7fWk7i9rnn/U/d+TPu6adgIopM/U7Pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhjfWtwDuTfhJJ8hA+HEo9hJ4L6/Xhd2T9Nt28CYa8lCP+8juuAgpziKQZm06syiBobO/b/nz6F/xYKCf2XTSzqEt8VJShf3qdfEjPPzFtnjs29/6qSkr8Dx8kIouDyjUp72EYgOaidH3Hrpt7FbVBPK7Hos5vawdnERZ+bUK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=B8gBvtIW; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709260030; x=1740796030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2cTboeGfd5dvTuPw5/S5Z9siN60YbHPYweT9rrc4uis=;
  b=B8gBvtIWilv4GizcUOe9ftpJK5wdVWE/E40pdEMxTJhP+6tgp9R6rkm4
   gOaE0uKbMnEIpfopaMvwFzWnktfnNz5PyHBzQAzGuCanztf1puS96YkXr
   OO2xYuMKibL8JV8sYExYQO90C3mcfIGvkOVF/00FfJYZfHgmPT0+HKSc6
   Y=;
X-IronPort-AV: E=Sophos;i="6.06,194,1705363200"; 
   d="scan'208";a="69866657"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 02:27:10 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:7329]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.3:2525] with esmtp (Farcaster)
 id 620bd488-3582-4675-8793-ec1544dd0501; Fri, 1 Mar 2024 02:27:09 +0000 (UTC)
X-Farcaster-Flow-ID: 620bd488-3582-4675-8793-ec1544dd0501
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:27:09 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 1 Mar 2024 02:27:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 10/15] af_unix: Skip GC if no cycle exists.
Date: Thu, 29 Feb 2024 18:22:38 -0800
Message-ID: <20240301022243.73908-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
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
index 3f55656c377e..a9bd087b430c 100644
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
+	/* Multiple vertices form a circle ? */
+	if (!list_is_singular(scc))
+		return true;
+
+	vertex = list_first_entry(scc, typeof(*vertex), scc_entry);
+
+	/* Self-reference or a embryo-listener circle exists ? */
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


