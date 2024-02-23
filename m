Return-Path: <netdev+bounces-74599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A193861F3B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291122843DC
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 21:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30175146E71;
	Fri, 23 Feb 2024 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lnac7HLH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFD1448F3
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724701; cv=none; b=cieFN0e8mk38iZ+NYv9LguJHgaqRn2tywMsh7IVuc368SU0rcKefw8kLwPjJMDWJwUEg5aQyB2Z2qtqNKbMkzZ96n72fyglNh4/KAmJKy2XsfVb+6TFmiQ+SOLnFje7PtaqdjsJWDoMruVwa3OoEvgpW/+ST8PUpbn15kP1UzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724701; c=relaxed/simple;
	bh=WJqWRX17pkq66Q1C8sdJBOKrOz1tcB+JaAdkM+48D4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myWuYXG9fgz4yPIKK/iIoOdhretkGGa8w8Sb4eK8TaRChWVSjJiLYZRhaMc806BlbKkVbkzxK7H9098J/3UAaHsn3R71nXcrP9MuQkHvxL6mSLSTCuHa0Wib6PAFKllc35vNG0Hq9EBhBbbxMjXYjt7kO62x6mc1S6cvMCQ8gLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lnac7HLH; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708724699; x=1740260699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BRV4ajxR2mvRcP07lg4HMiBd+jkIMx2JZ2jRuLqqjKU=;
  b=lnac7HLHGeiEjcwb4xPlstXdnZpsBPqRMWMVt+aSURcrsJOuwTfqilrW
   tUFbcvUXGGrq8sZTPuKw9+7nZbY/5Nz9wgTLjLocYjL/vMMwjSpEO8nta
   r+EslTtx8z7OidtDOcgPI5h4IcElfjqLdVV0ExVclYkBUoKtxxCX+7lpM
   U=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="68370591"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 21:44:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:6357]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.236:2525] with esmtp (Farcaster)
 id efa6df7d-3d6a-4217-9a28-acf66c908f2d; Fri, 23 Feb 2024 21:44:57 +0000 (UTC)
X-Farcaster-Flow-ID: efa6df7d-3d6a-4217-9a28-acf66c908f2d
Received: from EX19D004ANA003.ant.amazon.com (10.37.240.184) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 21:44:56 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.9) by
 EX19D004ANA003.ant.amazon.com (10.37.240.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Fri, 23 Feb 2024 21:44:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 11/14] af_unix: Assign a unique index to SCC.
Date: Fri, 23 Feb 2024 13:40:00 -0800
Message-ID: <20240223214003.17369-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D004ANA003.ant.amazon.com (10.37.240.184)

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
that in the example above, the lowlink of D is updated with the
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
index ec040caaa4b5..696d997a5ac9 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -36,7 +36,7 @@ struct unix_vertex {
 	struct list_head scc_entry;
 	unsigned long out_degree;
 	unsigned long index;
-	unsigned long lowlink;
+	unsigned long scc_index;
 };
 
 struct unix_edge {
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 1d9a0498dec5..0eb1610c96d7 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -308,18 +308,18 @@ static bool unix_scc_cyclic(struct list_head *scc)
 
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
 
@@ -342,13 +342,13 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 			vertex = edge->predecessor->vertex;
 
-			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
+			vertex->scc_index = min(vertex->scc_index, next_vertex->scc_index);
 		} else if (next_vertex->index != unix_vertex_grouped_index) {
-			vertex->lowlink = min(vertex->lowlink, next_vertex->index);
+			vertex->scc_index = min(vertex->scc_index, next_vertex->scc_index);
 		}
 	}
 
-	if (vertex->index == vertex->lowlink) {
+	if (vertex->index == vertex->scc_index) {
 		struct list_head scc;
 
 		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
@@ -371,6 +371,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 static void unix_walk_scc(void)
 {
+	unix_vertex_last_index = UNIX_VERTEX_INDEX_START;
 	unix_graph_maybe_cyclic = false;
 
 	while (!list_empty(&unix_unvisited_vertices)) {
-- 
2.30.2


