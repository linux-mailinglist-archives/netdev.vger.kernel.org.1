Return-Path: <netdev+bounces-81781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C1888B615
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECAACB296DF
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162714597D;
	Mon, 25 Mar 2024 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="wG7u8ZF1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A51CA9C
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398596; cv=none; b=gEU+FfnWtQHoVtZr527KcqAYGX2y7zJKAe5KiFK1CpYo+YX4JphllxEWN3NlWrNNm0XrRsOZtxsictWuPvG6KBG8aneES6oTj0tfyUCosSw504OAk3Yp4Fhd78EtQmjnFLdhfURO21yISyq18DJslaCV5Ds+d7Yk2yVolYnsTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398596; c=relaxed/simple;
	bh=iyLbj9cLUkJQWzK6FVbQudD3bJV+J4MED1IxXdUb8I0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e23xbqy6DhMZSd5VN0UVlkQHkyxVhf2G8/KeCRFgmTPj63oqv7tPBTcGDXp0POMw4vet4iQfIAaO0asjWoRAH0MxsVB4NBBhim9C3ofoi7QAY1t1vfbh5SVy3OD+9auAImymF9wEEG9yhX8f/SC6ycK8WtfGqKWLzQjE95Toz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=wG7u8ZF1; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711398595; x=1742934595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t330FiCJhqSQFxRYxWgnuJiNxej6KLHAyCk43tk+cjc=;
  b=wG7u8ZF1K94l2zUHVygp5sGvbUB33bIKceSJ6koe0x7gk4dyrN0Zk0YH
   jyec57xAuVsedGeNLX8CYELRVvTOnaNYv2ZaCraFwkIycHDgHcbK2P1eo
   PBmHhenYDbn1oNMNNPAO7YDSl/opd7WlIA9OzH7ov3a1z4pElePdCEjV+
   E=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="643489636"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 20:29:53 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:50058]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.115:2525] with esmtp (Farcaster)
 id c747e186-927a-4f00-a663-4e0fe5be824b; Mon, 25 Mar 2024 20:29:52 +0000 (UTC)
X-Farcaster-Flow-ID: c747e186-927a-4f00-a663-4e0fe5be824b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:29:52 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:29:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 13/15] af_unix: Detect dead SCC.
Date: Mon, 25 Mar 2024 13:24:23 -0700
Message-ID: <20240325202425.60930-14-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
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
index 3f59cee3ccbc..0a6b38da578c 100644
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


