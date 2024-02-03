Return-Path: <netdev+bounces-68768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B8A847FD1
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566681F23B32
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6486FCA;
	Sat,  3 Feb 2024 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="twgp5DkE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7E7483
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929573; cv=none; b=mGnBDsVL4SLla72VcythQnwg05TxpoBkNyuLDPR5EvzjPTSzjmsUdIqbDa5G/ckl4klTWZGIUaKcEgdmZo2PKSDkSRBj9Vb3PFhRcvfYlTDlMIZcX6fjojnxjQ3lhZxjv/yzJqEIEkqv2T0sGQpNBHh42ghcPdxZcxnM5tTxT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929573; c=relaxed/simple;
	bh=/HfET+wyksOk8bht9uFP2ro1mCNJ5Xvi0UZdBXqjQkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6Md04ZCglfHZVqMkxUSa98/Vtk+pjvivH7125bJVnioHBEr5mDsYjG3wjdw2cY527KVxmAYVegLePpqmrVJaDaH+spHQ1gyhW1wjwT1hRoH4C4s7gciPpwhwgrGazmX3s8Etl0LW5R+W+FlwdJZf828294YrqFOZ1wPsHTiD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=twgp5DkE; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929572; x=1738465572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ekL8pusgTytjOgGhteG67UzZEjkT1u2027DpxPQsnXs=;
  b=twgp5DkE+RcjSGChQ8ozOL0QN1udoIM2rY1QwOG5yl8D5Rvl1Qf5kc5M
   H7q2+ACqziDEKshQsgIDdZvaa4KCmgbE14pGUHulgLqLbfXYyt8OMay/O
   y+CTg4VPGf8WXt7AITgx/XBLh7n4fwxzseEuQQ5DQjSOo5OzS68s5Qu4z
   g=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="270772041"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:06:11 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:20819]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.194:2525] with esmtp (Farcaster)
 id c9964e9a-6d0d-45f3-b3b6-93429df84541; Sat, 3 Feb 2024 03:06:11 +0000 (UTC)
X-Farcaster-Flow-ID: c9964e9a-6d0d-45f3-b3b6-93429df84541
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:06:10 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Sat, 3 Feb 2024 03:06:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 12/16] af_unix: Detect dead SCC.
Date: Fri, 2 Feb 2024 19:00:54 -0800
Message-ID: <20240203030058.60750-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When iterating SCC, we call unix_vertex_dead() for each vertex
to check if the vertex is close()d and has no bridge to another
SCC.

If both conditions are true for every vertex in SCC, we can
execute garbage collection for all skb in the SCC.

The actual garbage collection is done in the following patch,
replacing the old implementation.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 3d60a5379b7b..528215527b23 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -261,6 +261,29 @@ void unix_free_edges(struct scm_fp_list *fpl)
 	kvfree(fpl->edges);
 }
 
+static bool unix_vertex_dead(struct unix_vertex *vertex)
+{
+	struct unix_edge *edge;
+	struct unix_sock *u;
+	long total_ref;
+
+	list_for_each_entry(edge, &vertex->edges, entry) {
+		if (!edge->successor->out_degree)
+			return false;
+
+		if (edge->successor->scc_index != vertex->scc_index)
+			return false;
+	}
+
+	u = container_of(vertex, typeof(*u), vertex);
+	total_ref = file_count(u->sk.sk_socket->file);
+
+	if (total_ref != vertex->out_degree)
+		return false;
+
+	return true;
+}
+
 static LIST_HEAD(unix_visited_vertices);
 static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 static unsigned long unix_vertex_last_index = UNIX_VERTEX_INDEX_START;
@@ -295,6 +318,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 	}
 
 	if (vertex->index == vertex->scc_index) {
+		bool dead = true;
 		LIST_HEAD(scc);
 
 		list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
@@ -303,6 +327,9 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			list_move_tail(&vertex->entry, &unix_visited_vertices);
 
 			vertex->index = unix_vertex_grouped_index;
+
+			if (dead)
+				dead = unix_vertex_dead(vertex);
 		}
 
 		if (!list_is_singular(&scc)) {
@@ -347,14 +374,19 @@ static void unix_walk_scc_fast(void)
 {
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
+		bool dead = true;
 		LIST_HEAD(scc);
 
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
 		list_add(&scc, &vertex->scc_entry);
 
-		list_for_each_entry_reverse(vertex, &scc, scc_entry)
+		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
 			list_move_tail(&vertex->entry, &unix_visited_vertices);
 
+			if (dead)
+				dead = unix_vertex_dead(vertex);
+		}
+
 		list_del(&scc);
 	}
 
-- 
2.30.2


