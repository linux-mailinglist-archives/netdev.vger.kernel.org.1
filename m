Return-Path: <netdev+bounces-81774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6078D88B159
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846441C364DF
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5749247F45;
	Mon, 25 Mar 2024 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JpEkVQ8+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6545BE1
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398428; cv=none; b=TwuspH3WJ5qHTlrsKCDXBxocQOeyQjtxazMFOBytBx1SiQIVG3Ym+Hl12vMst50R3DXoUCKabtoieR6qpYAEZ/AMaIIzV4JbcGdvyAIiYz/ANh53Q6ZlGPQ677LLT1dOoGMwEgFwFAeegs0StobzgjobMH8H/2NqI2T+XGWCHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398428; c=relaxed/simple;
	bh=Y9TiENNXjMbVM4Omft3lFQ3UrG16LedJwh5qux3ba90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGdteLpvVsYQKS/I7K0ouhBib89Aj7VUBQPC4XK68zt/XCHX9RQE+oO6hwJBob5jeKMSMEXhszILLSUKxcHNdwjxZ+2ag1r8ItjhJmSdjKbYkFOmWFNjUTmB+iqp/QvVpnFjCGbYheutGgNC3nBaBbIOpq18Q8LipWgQUXywU5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JpEkVQ8+; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711398426; x=1742934426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hh17owvbeYZuCpueUg7lO9ANNgjljH7sMZQVKp3izgI=;
  b=JpEkVQ8+PF8umXt0dRA/Rp0gr1m4FAYmVpfb7oa5LIjVVGfjwyPkG9cB
   MsLtpj4MaEUIem35HmJIF8ZRulMPNIKrujwYupTV0qdZtr1SPXntSOKlO
   fCmuJVRhQ2kp7eHXYz0mk68HM62uGf3c0l67T712QHcIQAq0cW1Z515HV
   A=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="395948520"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 20:27:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:18014]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.112:2525] with esmtp (Farcaster)
 id b884be06-3e13-4f1a-9ed8-01b9f31fe68c; Mon, 25 Mar 2024 20:27:04 +0000 (UTC)
X-Farcaster-Flow-ID: b884be06-3e13-4f1a-9ed8-01b9f31fe68c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:27:02 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:27:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 06/15] af_unix: Detect Strongly Connected Components.
Date: Mon, 25 Mar 2024 13:24:16 -0700
Message-ID: <20240325202425.60930-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In the new GC, we use a simple graph algorithm, Tarjan's Strongly
Connected Components (SCC) algorithm, to find cyclic references.

The algorithm visits every vertex exactly once using depth-first
search (DFS).

DFS starts by pushing an input vertex to a stack and assigning it
a unique number.  Two fields, index and lowlink, are initialised
with the number, but lowlink could be updated later during DFS.

If a vertex has an edge to an unvisited inflight vertex, we visit
it and do the same processing.  So, we will have vertices in the
stack in the order they appear and number them consecutively in
the same order.

If a vertex has a back-edge to a visited vertex in the stack,
we update the predecessor's lowlink with the successor's index.

After iterating edges from the vertex, we check if its index
equals its lowlink.

If the lowlink is different from the index, it shows there was a
back-edge.  Then, we go backtracking and propagate the lowlink to
its predecessor and resume the previous edge iteration from the
next edge.

If the lowlink is the same as the index, we pop vertices before
and including the vertex from the stack.  Then, the set of vertices
is SCC, possibly forming a cycle.  At the same time, we move the
vertices to unix_visited_vertices.

When we finish the algorithm, all vertices in each SCC will be
linked via unix_vertex.scc_entry.

Let's take an example.  We have a graph including five inflight
vertices (F is not inflight):

  A -> B -> C -> D -> E (-> F)
       ^         |
       `---------'

Suppose that we start DFS from C.  We will visit C, D, and B first
and initialise their index and lowlink.  Then, the stack looks like
this:

  > B = (3, 3)  (index, lowlink)
    D = (2, 2)
    C = (1, 1)

When checking B's edge to C, we update B's lowlink with C's index
and propagate it to D.

    B = (3, 1)  (index, lowlink)
  > D = (2, 1)
    C = (1, 1)

Next, we visit E, which has no edge to an inflight vertex.

  > E = (4, 4)  (index, lowlink)
    B = (3, 1)
    D = (2, 1)
    C = (1, 1)

When we leave from E, its index and lowlink are the same, so we
pop E from the stack as single-vertex SCC.  Next, we leave from
B and D but do nothing because their lowlink are different from
their index.

    B = (3, 1)  (index, lowlink)
    D = (2, 1)
  > C = (1, 1)

Then, we leave from C, whose index and lowlink are the same, so
we pop B, D and C as SCC.

Last, we do DFS for the rest of vertices, A, which is also a
single-vertex SCC.

Finally, each unix_vertex.scc_entry is linked as follows:

  A -.  B -> C -> D  E -.
  ^  |  ^         |  ^  |
  `--'  `---------'  `--'

We use SCC later to decide whether we can garbage-collect the
sockets.

Note that we still cannot detect SCC properly if an edge points
to an embryo socket.  The following two patches will sort it out.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  3 +++
 net/unix/garbage.c    | 46 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 970a91da2239..67736767b616 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -32,8 +32,11 @@ void wait_for_unix_gc(struct scm_fp_list *fpl);
 struct unix_vertex {
 	struct list_head edges;
 	struct list_head entry;
+	struct list_head scc_entry;
 	unsigned long out_degree;
 	unsigned long index;
+	unsigned long lowlink;
+	bool on_stack;
 };
 
 struct unix_edge {
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 8b16ab9e240e..33aadaa35346 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -251,11 +251,19 @@ static LIST_HEAD(unix_visited_vertices);
 static void __unix_walk_scc(struct unix_vertex *vertex)
 {
 	unsigned long index = UNIX_VERTEX_INDEX_START;
+	LIST_HEAD(vertex_stack);
 	struct unix_edge *edge;
 	LIST_HEAD(edge_stack);
 
 next_vertex:
+	/* Push vertex to vertex_stack.
+	 * The vertex will be popped when finalising SCC later.
+	 */
+	vertex->on_stack = true;
+	list_add(&vertex->scc_entry, &vertex_stack);
+
 	vertex->index = index;
+	vertex->lowlink = index;
 	index++;
 
 	/* Explore neighbour vertices (receivers of the current vertex's fd). */
@@ -283,12 +291,46 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			edge = list_first_entry(&edge_stack, typeof(*edge), stack_entry);
 			list_del_init(&edge->stack_entry);
 
+			next_vertex = vertex;
 			vertex = edge->predecessor->vertex;
+
+			/* If the successor has a smaller lowlink, two vertices
+			 * are in the same SCC, so propagate the smaller lowlink
+			 * to skip SCC finalisation.
+			 */
+			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
+		} else if (next_vertex->on_stack) {
+			/* Loop detected by a back/cross edge.
+			 *
+			 * The successor is on vertex_stack, so two vertices are
+			 * in the same SCC.  If the successor has a smaller index,
+			 * propagate it to skip SCC finalisation.
+			 */
+			vertex->lowlink = min(vertex->lowlink, next_vertex->index);
+		} else {
+			/* The successor was already grouped as another SCC */
 		}
 	}
 
-	/* Don't restart DFS from this vertex in unix_walk_scc(). */
-	list_move_tail(&vertex->entry, &unix_visited_vertices);
+	if (vertex->index == vertex->lowlink) {
+		struct list_head scc;
+
+		/* SCC finalised.
+		 *
+		 * If the lowlink was not updated, all the vertices above on
+		 * vertex_stack are in the same SCC.  Group them using scc_entry.
+		 */
+		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
+
+		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
+			/* Don't restart DFS from this vertex in unix_walk_scc(). */
+			list_move_tail(&vertex->entry, &unix_visited_vertices);
+
+			vertex->on_stack = false;
+		}
+
+		list_del(&scc);
+	}
 
 	/* Need backtracking ? */
 	if (!list_empty(&edge_stack))
-- 
2.30.2


