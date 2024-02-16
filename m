Return-Path: <netdev+bounces-72540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0748587FF
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C7EAB2B66E
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C263014535A;
	Fri, 16 Feb 2024 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="n8uwNghp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A5713B28A
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117886; cv=none; b=LorylLlZ8jqgMuVWapiMYgKyhwegZoBxVrn5pbPqpYhYzw1WgBRlgTEoK9o0+ZUechWu22C1hfz28enc+7IjGVnevmzrtonJbPOvzTCHP/IOL9go5PoHI+kNlcTIdf/INvhTn44XHyTAhN0Vdj8orPQkORomKN+r0WTqFibCHwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117886; c=relaxed/simple;
	bh=gf0vTbPpX1LCvKbzQHi5j60WPkcLJCDKrXKOcVmzOps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4lkektVl7p/bzRVkhvPV+ZnblYD5F5pqCLga7bA+McrxgU7ehnY3szJ2cCB6F6OGigdEcBbqnWhnoQlKhJjlkTWVkDs4Y/D+C75n3VA57FPeoe4a7BznNuxf/eDsGXMSgVIguCDEH8QMduJQ3b0wYJZcmBCAo12msa7BwkxGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=n8uwNghp; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708117885; x=1739653885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TWxM1xmb/7bDwinWjOLbnmklphkrIJCVu0dPu3MlM1E=;
  b=n8uwNghpWTgFT/nnnLCbFMuhtnOg5Qn0mnDfVKdcazYOwDpW8rMPDV5v
   Luu7KuhcHc42w/fjSChNgIXHVIU4XhoF33/ags1V81MUQv+yz31BJ0MRH
   yK96qqG1oZ/I4wikiEZIDqu/fAQG1hu0RxPKBJHAuzF6VMotKqWlcKEIR
   0=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="613620823"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 21:11:24 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:15121]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.209:2525] with esmtp (Farcaster)
 id a4e98a01-a458-48ac-a262-e2065bcd7c5f; Fri, 16 Feb 2024 21:11:23 +0000 (UTC)
X-Farcaster-Flow-ID: a4e98a01-a458-48ac-a262-e2065bcd7c5f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:11:22 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:11:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 12/14] af_unix: Detect dead SCC.
Date: Fri, 16 Feb 2024 13:05:54 -0800
Message-ID: <20240216210556.65913-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
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
index 0e6d0e96e7cf..bdfee2788db5 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -257,6 +257,29 @@ void unix_free_edges(struct scm_fp_list *fpl)
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
 static bool unix_scc_cyclic(struct list_head *scc)
 {
 	struct unix_vertex *vertex;
@@ -310,6 +333,7 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 
 	if (vertex->index == vertex->scc_index) {
 		struct list_head scc;
+		bool dead = true;
 
 		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
 
@@ -317,6 +341,9 @@ static void __unix_walk_scc(struct unix_vertex *vertex)
 			list_move_tail(&vertex->entry, &unix_visited_vertices);
 
 			vertex->index = unix_vertex_grouped_index;
+
+			if (dead)
+				dead = unix_vertex_dead(vertex);
 		}
 
 		if (!unix_graph_maybe_cyclic)
@@ -351,13 +378,18 @@ static void unix_walk_scc_fast(void)
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


