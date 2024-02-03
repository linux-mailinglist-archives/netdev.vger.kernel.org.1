Return-Path: <netdev+bounces-68767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A793847FD0
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506882854BA
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCDD7468;
	Sat,  3 Feb 2024 03:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Hmp6aMn0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248279C0
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929550; cv=none; b=S+fFqE4CQ8dRzNDP79RairzquvBgkWiTRBOVR5v4gMMPbJZjN/1VrZts+Va+8fFhCCg1iGmLnXA4mTNVWV+h07XVKaPgWjL5/6HravNJQ6CLQiB0zZNKsmaR5JXslYVZaof7iypZ6ngfk/2xI2pZJWLibVEKXGoAjg6lwb3LHIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929550; c=relaxed/simple;
	bh=cq8TgJIzIyxYKrg/YzpbIg5Tuqg2FYk7z+GAwiwKY7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XizMRFWNq7J5QuKQvp7lB5oxlcbrtt8cm9cfVbk/GqBjpwQmSuBdoCYyASELxF3k7PxHcTDP5xBL5Mph6tTXW026h7AGeuPwcvcRd6lhjmDjLlVeAEF6/9pUPVzzWJSqFLXJHUfLy+5kvwUyRhWYqG/mZ2nd/oZYrZkFgbNeE2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Hmp6aMn0; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929549; x=1738465549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MUF3U+v+rbGyg73T2dafbluksmChkf/9CLlhqcv2SQs=;
  b=Hmp6aMn0LQghsC9c2HCgOMWwaNIkSvWmGwRRi4oh8y5x5HaAizS5Uewc
   XxooJLnstPQRq/+iWP4ScwM24l77Afqf7xPi+cpeZvD2RxAz570LS7bx8
   9Ohsfyg00byjmyF8ZouGj9GYfpHR3WZTiB0/AcA4HLn9yvElMrvlkJeK6
   8=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="635435959"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:05:47 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:26755]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.239:2525] with esmtp (Farcaster)
 id a500922a-0ff7-4461-8b5d-5b83ed31bbc9; Sat, 3 Feb 2024 03:05:46 +0000 (UTC)
X-Farcaster-Flow-ID: a500922a-0ff7-4461-8b5d-5b83ed31bbc9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:05:46 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:05:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 11/16] af_unix: Assign a unique index to SCC.
Date: Fri, 2 Feb 2024 19:00:53 -0800
Message-ID: <20240203030058.60750-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The definition of the lowlink in Tarjan's algorithm is the
smallest index of a vertex that is reachable with at most one
back-edge in SCC.

If we start traversing from A in the following graph, the final
lowlink of D is 3.

  A -> B -> D   D = (4, 3)  (index, lowlink)
  ^    |    |   C = (3, 1)
  |    V    |   B = (2, 1)
  `--- C <--'   A = (1, 1)

This is because the lowlink of D is updated with the index of C.

In the following patch, we detect a dead SCC by checking two
conditions for each vertex.

  1) vertex has no edge directed to another SCC (no bridge)
  2) vertex's out_degree is the same as the refcount of its file

If 1) is false, there is a receiver of all fds of the SCC.

To evaluate 1), we need to assign a unique index to a SCC and
assign it to all vertices in the SCC.

This patch changes the lowlink update logic so that in the above
example, the lowlink of D is updated with the lowlink of C.

  A -> B -> D   D = (4, 1)  (index, lowlink)
  ^    |    |   C = (3, 1)
  |    V    |   B = (2, 1)
  `--- C <--'   A = (1, 1)

Then, all vertices in the same SCC have the same lowlink, and we
can quickly find the bridge if exists.

However, it is no longer called lowlink, so we rename it to
scc_index.

Also, we add a global variable to hold the last index used in DFS
so that we do not reset the initial index in each DFS.

This patch can be squashed to the SCC detection patch but is
split deliberately for anyone wondering why lowlink is not used
as used in the original Tarjan's algorithm.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  2 +-
 net/unix/garbage.c    | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 59ec8d7880ce..66c8cf835625 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -38,7 +38,7 @@ struct unix_vertex {
 	unsigned long out_degree;
 	unsigned long self_degree;
 	unsigned long index;
-	unsigned long lowlink;
+	unsigned long scc_index;
 };
 
 struct unix_edge {
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index cbddca5d8dd1..3d60a5379b7b 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -263,18 +263,18 @@ void unix_free_edges(struct scm_fp_list *fpl)
 
 static LIST_HEAD(unix_visited_vertices);
 static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
+static unsigned long unix_vertex_last_index = UNIX_VERTEX_INDEX_START;
 
 static void __unix_walk_scc(struct unix_vertex *vertex)
 {
-	unsigned long index = UNIX_VERTEX_INDEX_START;
 	LIST_HEAD(vertex_stack);
 	struct unix_edge *edge;
 	LIST_HEAD(edge_stack);
 
 next_vertex:
-	vertex->index = index;
-	vertex->lowlink = index;
-	index++;
+	vertex->index = unix_vertex_last_index;
+	vertex->scc_index = unix_vertex_last_index;
+	unix_vertex_last_index++;
 
 	list_move(&vertex->scc_entry, &vertex_stack);
 
@@ -290,11 +290,11 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 		}
 
 		if (edge->successor->index != unix_vertex_grouped_index)
-			vertex->lowlink = min(vertex->lowlink, edge->successor->index);
+			vertex->scc_index = min(vertex->scc_index, edge->successor->scc_index);
 next_edge:
 	}
 
-	if (vertex->index == vertex->lowlink) {
+	if (vertex->index == vertex->scc_index) {
 		LIST_HEAD(scc);
 
 		list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
@@ -321,13 +321,14 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 		list_del_init(&edge->stack_entry);
 
 		vertex = edge->predecessor;
-		vertex->lowlink = min(vertex->lowlink, edge->successor->lowlink);
+		vertex->scc_index = min(vertex->scc_index, edge->successor->scc_index);
 		goto next_edge;
 	}
 }
 
 static void unix_walk_scc(void)
 {
+	unix_vertex_last_index = UNIX_VERTEX_INDEX_START;
 	unix_graph_maybe_cyclic = false;
 
 	while (!list_empty(&unix_unvisited_vertices)) {
-- 
2.30.2


