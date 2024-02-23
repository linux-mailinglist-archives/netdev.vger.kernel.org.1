Return-Path: <netdev+bounces-74600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F0D861F3C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F021F1C20FB2
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 21:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801A5146E81;
	Fri, 23 Feb 2024 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LxobkT2s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059A8146E71
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724729; cv=none; b=XkAqadrGv7VPOV7BH40KdjoXITFtESO7sLZ+BU4jPWSPYFfBZqQzAtdLFoC6i7EJA+c6Bt7hy8LrynVJjexjE6LboZm2fSUwpMdXZHE8+y23t3IT352cadEMy0rvcEUt1LyHYTwYXMRCGDeoB/P0akYym16Xtjzv3mHS9UGKaYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724729; c=relaxed/simple;
	bh=UrnhIari++KSIifVWaqi+lr3ut7FAafiBel5RP941W0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9idaOyVmo6Lf2pZOC7IHdGeHOQFgyRqp02rI+DA62Hfd+X7QoVMGaa7lT1AL0u8qlRPrTChJeWf1jYNIhQ5fG4yJlnHRyPS9JuHnbfSJ17Y7y1Xd7K8suFYcQhJyTkOnGPoU4byI2N0AmpouC5tIVKurbav7iJzRkUrzj5hETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LxobkT2s; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708724728; x=1740260728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YYoX8Rk6ojmSlrOJAsk3YtaYCneWU9KEhYNUz4Ws2o8=;
  b=LxobkT2sn7kx2LA8nHN7V00bOcwV/AQ1yriemH22c/rXOKHfG5/ZhrOD
   eoMWx6dZXaJaNSY+sbkrMBV/SNTu66uGixkxcHQpVyBhGbfvHB5aKEXK2
   9q3PKEAVCCuLRcAPHRcQN2Rkt6MhhfamYwQHy8X3u9XGUcSP23b3RUfYM
   w=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="706491968"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 21:45:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:51364]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.154:2525] with esmtp (Farcaster)
 id 70e236fb-1277-4169-9a07-0147965d2ebe; Fri, 23 Feb 2024 21:45:22 +0000 (UTC)
X-Farcaster-Flow-ID: 70e236fb-1277-4169-9a07-0147965d2ebe
Received: from EX19D004ANA003.ant.amazon.com (10.37.240.184) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 21:45:22 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.9) by
 EX19D004ANA003.ant.amazon.com (10.37.240.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Fri, 23 Feb 2024 21:45:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 12/14] af_unix: Detect dead SCC.
Date: Fri, 23 Feb 2024 13:40:01 -0800
Message-ID: <20240223214003.17369-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA003.ant.amazon.com (10.37.240.184)

When iterating SCC, we call unix_vertex_dead() for each vertex
to check if the vertex is close()d and has no bridge to another
SCC.

If both conditions are true for every vertex in SCC, we can
execute garbage collection for all skb in the SCC.

The actual garbage collection is done in the following patch,
replacing the old implementation.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 0eb1610c96d7..060e81be3614 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -288,6 +288,32 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
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
+		if (!next_vertex)
+			return false;
+
+		if (next_vertex->scc_index != vertex->scc_index)
+			return false;
+	}
+
+	edge = list_first_entry(&vertex->edges, typeof(*edge), vertex_entry);
+	u = edge->predecessor;
+	total_ref = file_count(u->sk.sk_socket->file);
+
+	if (total_ref != vertex->out_degree)
+		return false;
+
+	return true;
+}
+
 static bool unix_scc_cyclic(struct list_head *scc)
 {
 	struct unix_vertex *vertex;
@@ -350,6 +376,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 	if (vertex->index == vertex->scc_index) {
 		struct list_head scc;
+		bool dead = true;
 
 		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
 
@@ -357,6 +384,9 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			list_move_tail(&vertex->entry, &unix_visited_vertices);
 
 			vertex->index = unix_vertex_grouped_index;
+
+			if (dead)
+				dead = unix_vertex_dead(vertex);
 		}
 
 		if (!unix_graph_maybe_cyclic)
@@ -392,13 +422,18 @@ static void unix_walk_scc_fast(void)
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
 		struct list_head scc;
+		bool dead = true;
 
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


