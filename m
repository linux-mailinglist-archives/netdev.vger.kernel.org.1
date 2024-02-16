Return-Path: <netdev+bounces-72539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0598587BC
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1EF1F21EEA
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103821419A2;
	Fri, 16 Feb 2024 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jB7eo/dE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2CF13B28A
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117863; cv=none; b=f/FZSHwsvaseDL5nDtanLJr2ES5bmj/6OaFLc2BHUXu3U7xry6n/oXcmbItMw5frOA3B1sspPoYoxSHr6XeHzxJU3gnDBali5Z3rhTUTnfSqvk1gXTOwHjmcbuKdHO2CGb1M+M9Rgf3MzXlCmHHTtbcjqZrP9emSjxayZBL/jJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117863; c=relaxed/simple;
	bh=t+K6TPSa1pn/JpKaEXeOObpcVpPJHu1lLvIO1290eAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTVl9Wr3w7WWzfI/fWbG8g23e8qyseoONZ+MgtTPBJFpnUb96zEYy7txt5yG7wwofS/IgtGMje/AbwCm7KgLOUhiXU/gAiWsUnLJU04wq2GtIxzYqewpm4+INwDkXYqvJnDiACHLAIv7DNjF7R3U0VAbHvFbp9Q8H+VAMkbe020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jB7eo/dE; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708117861; x=1739653861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UWC5UepUZrX8qqz7ixo7Z2YuG2Ofb+J/MZNYAmaR/sA=;
  b=jB7eo/dEYj6q5OQEkGZdMpQoAcZG2nJ8lAQE8smHd8TuSYE3Mcz1hbsW
   8yzVmca+1nCFY3iaBSRwyiOkNNENj+1c6kLSH3RqAlcsRmeIcoeWtetEU
   gnNKlolCN5nHD9YmfeWwdMTOHmzTB7mMieqXtkHZHegoZ/FzLAvYpvVtn
   k=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="613620788"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 21:11:00 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:43556]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.119:2525] with esmtp (Farcaster)
 id e741216a-4536-4b13-8d3b-d9658720e2f7; Fri, 16 Feb 2024 21:10:58 +0000 (UTC)
X-Farcaster-Flow-ID: e741216a-4536-4b13-8d3b-d9658720e2f7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:10:58 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:10:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 11/14] af_unix: Assign a unique index to SCC.
Date: Fri, 16 Feb 2024 13:05:53 -0800
Message-ID: <20240216210556.65913-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
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
that in the above example, the lowlink of D is updated with the
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
index 1e919fe65737..0e6d0e96e7cf 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -273,18 +273,18 @@ static bool unix_scc_cyclic(struct list_head *scc)
 
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
 
 	list_add(&vertex->scc_entry, &vertex_stack);
 
@@ -302,13 +302,13 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			list_del_init(&edge->stack_entry);
 
 			vertex = edge->predecessor;
-			vertex->lowlink = min(vertex->lowlink, edge->successor->lowlink);
+			vertex->scc_index = min(vertex->scc_index, edge->successor->scc_index);
 		} else if (edge->successor->index != unix_vertex_grouped_index) {
-			vertex->lowlink = min(vertex->lowlink, edge->successor->index);
+			vertex->scc_index = min(vertex->scc_index, edge->successor->scc_index);
 		}
 	}
 
-	if (vertex->index == vertex->lowlink) {
+	if (vertex->index == vertex->scc_index) {
 		struct list_head scc;
 
 		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
@@ -331,6 +331,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 static void unix_walk_scc(void)
 {
+	unix_vertex_last_index = UNIX_VERTEX_INDEX_START;
 	unix_graph_maybe_cyclic = false;
 
 	while (!list_empty(&unix_unvisited_vertices)) {
-- 
2.30.2


