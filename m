Return-Path: <netdev+bounces-76410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5D286D9BB
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 03:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD8C1F2348A
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E15F3A8DB;
	Fri,  1 Mar 2024 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A22AgaM5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4603A8CE
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 02:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709260106; cv=none; b=Z5HZyigsluUx71Y/r5qG8mKPc5pUJwM8FvfAz5E+zy3ylqhfHuuSG3JOtuziyW1624FoU7AkauyRTFZMKwFcd98b7iWv/zBeOWUftxfkWdRqduJhi1WNB6FaAMhUSomGVYkEirZfDJfWXlL8KtOy/PixNi6d37yHzG4B9EB7oZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709260106; c=relaxed/simple;
	bh=9aAAFqV+HVfPwcKEbIFjsnn/qOmU8MdYzW4xui/KGDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhOaK7Oyki+r0eJRQipy3z9+v1xaOQGtJw8eApLgCLJQqzCkePek7lGHcJSxuu5yoBLMUoqUnWXr9T5gq+jUInmqZMBbDId1vjQBXz2R/Med10P4BHcB1tZYpiBr1d25hk0JSSTIOMvjjiZp18JYeA12kSJqx1FB6GhCXp+PSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=A22AgaM5; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709260105; x=1740796105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i5YU4r6UKU5wGp568TtEeO/PtnKforC7HEDFIMlZ3Cs=;
  b=A22AgaM5a3AnBTpmR41qeNiXzauhPz7cxTH2HVlmHvVwcNeyU05T7Qae
   ManznYehgHhgR6AeqzzMpKnmpRNeezQppu7rweSjazY4mPcQrcmVb4zso
   8BdJzksRK3NOmzqOB8FTs5aW8NIx5YaEU2AckAegCcSeW+R2OMNGUUmdn
   E=;
X-IronPort-AV: E=Sophos;i="6.06,194,1705363200"; 
   d="scan'208";a="69867880"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 02:28:24 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:47538]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.165:2525] with esmtp (Farcaster)
 id 015f77d3-d483-41aa-86ec-386aef0b7e33; Fri, 1 Mar 2024 02:28:24 +0000 (UTC)
X-Farcaster-Flow-ID: 015f77d3-d483-41aa-86ec-386aef0b7e33
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:28:23 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 1 Mar 2024 02:28:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 13/15] af_unix: Detect dead SCC.
Date: Thu, 29 Feb 2024 18:22:41 -0800
Message-ID: <20240301022243.73908-14-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
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
 net/unix/garbage.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index e825894d8bca..684e2c843b1e 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -289,6 +289,39 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
+static bool unix_vertex_dead(struct unix_vertex *vertex)
+{
+	struct unix_edge *edge;
+	struct unix_sock *u;
+	long total_ref;
+
+	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
+		struct unix_vertex *next_vertex = unix_edge_successor(edge);
+
+		/* The vertex's fd can be received by a non-inflight socket. */
+		if (!next_vertex)
+			return false;
+
+		/* The vertex's fd can be received by an inflight socket in
+		 * another SCC.
+		 */
+		if (next_vertex->scc_index != vertex->scc_index)
+			return false;
+	}
+
+	/* No receiver exists out of the same SCC. */
+
+	edge = list_first_entry(&vertex->edges, typeof(*edge), vertex_entry);
+	u = edge->predecessor;
+	total_ref = file_count(u->sk.sk_socket->file);
+
+	/* If not close()d, total_ref > out_degree. */
+	if (total_ref != vertex->out_degree)
+		return false;
+
+	return true;
+}
+
 static bool unix_scc_cyclic(struct list_head *scc)
 {
 	struct unix_vertex *vertex;
@@ -377,6 +410,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 
 	if (vertex->index == vertex->scc_index) {
 		struct list_head scc;
+		bool scc_dead = true;
 
 		/* SCC finalised.
 		 *
@@ -391,6 +425,9 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 
 			/* Mark vertex as off-stack. */
 			vertex->index = unix_vertex_grouped_index;
+
+			if (scc_dead)
+				scc_dead = unix_vertex_dead(vertex);
 		}
 
 		if (!unix_graph_maybe_cyclic)
@@ -431,13 +468,18 @@ static void unix_walk_scc_fast(void)
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
 		struct list_head scc;
+		bool scc_dead = true;
 
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
 		list_add(&scc, &vertex->scc_entry);
 
-		list_for_each_entry_reverse(vertex, &scc, scc_entry)
+		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
 			list_move_tail(&vertex->entry, &unix_visited_vertices);
 
+			if (scc_dead)
+				scc_dead = unix_vertex_dead(vertex);
+		}
+
 		list_del(&scc);
 	}
 
-- 
2.30.2


