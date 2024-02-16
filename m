Return-Path: <netdev+bounces-72538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7728587BB
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7BE1C22071
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFB11419A2;
	Fri, 16 Feb 2024 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gsPP1QbY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0F13B2B0
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117842; cv=none; b=RHVg9VVpUKpVgheXtl7tiyYubcS0Ni0S/yiVswq7svv+qai8E1JCU7EiDTGeYUmJN/ideGSQS75Lynhvi0Ru9DrgG+tdjO+RBfYJ1exVX5l6rugfrE7gzEE8oqH0ON59HQGu/Ju/5EFbv41w1IOcOtkuZW3JJVa5gmUysD8GoAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117842; c=relaxed/simple;
	bh=om2KiYiXfx9A7FKxWJkriC4dRUIL4j/VE4Kkq5P9SpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYrjYBquZptAndeg4ph3PciWqKvv833eKUWMWh0dMv2/ohd7hjwZeabs4DaHb8QEifZ9wkOSmiMfUJZobt1a11wvWNtmonPw05DK3szM8yGroGszi2riQuVtf3wOKNy4/PiMtxsji/z8qVHsIg+uu8QbK25wT5OCJOEiYdnHJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gsPP1QbY; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708117842; x=1739653842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Azdzob6nOha7/2OEEk3/SUdpmEW/QIS5v0/CKo44i1o=;
  b=gsPP1QbYXXaCzzlc5QBSX8UIzNU+laNKmQn4PAtEePEnh9FilBjyrL43
   /yWC7+kPo1+2PfvWuspvzhIs53quknEwv8SmfYhZMTeolAZVv2pwh12Ct
   R9Y6pvgUAOxBqEGiD4oAR+tAOdINhAZCP8k+geAxFlstGSbkKkjCFAnQW
   U=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="274710986"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 21:10:41 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:45431]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.203:2525] with esmtp (Farcaster)
 id 5f2ce72e-6a33-40da-a0f3-a1bdbfea4768; Fri, 16 Feb 2024 21:10:40 +0000 (UTC)
X-Farcaster-Flow-ID: 5f2ce72e-6a33-40da-a0f3-a1bdbfea4768
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:10:33 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Fri, 16 Feb 2024 21:10:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 10/14] af_unix: Avoid Tarjan's algorithm if unnecessary.
Date: Fri, 16 Feb 2024 13:05:52 -0800
Message-ID: <20240216210556.65913-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once a cyclic reference is formed, we need to run GC to check if
there is dead SCC.

However, we do not need to run Tarjan's algorithm if we know that
the shape of the inflight graph has not been changed.

If an edge is added/updated/deleted and the edge's successor is
inflight, we set false to unix_graph_grouped, which means we need
to re-classify SCC.

Once we finalise SCC, we set false to unix_graph_grouped.

While unix_graph_grouped is false, we can iterate the grouped
SCC using vertex->scc_entry in unix_walk_scc_fast().

list_add() and list_for_each_entry_reverse() uses seem weird, but
they are to keep the vertex order consistent and make writing test
easier.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 90f04d786dae..1e919fe65737 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -108,9 +108,11 @@ void unix_init_vertex(struct unix_sock *u)
 	vertex->out_degree = 0;
 	vertex->self_degree = 0;
 	INIT_LIST_HEAD(&vertex->edges);
+	INIT_LIST_HEAD(&vertex->scc_entry);
 }
 
 static bool unix_graph_maybe_cyclic;
+static bool unix_graph_grouped;
 
 static void unix_graph_update(struct unix_edge *edge)
 {
@@ -121,6 +123,7 @@ static void unix_graph_update(struct unix_edge *edge)
 		return;
 
 	unix_graph_maybe_cyclic = true;
+	unix_graph_grouped = false;
 }
 
 DEFINE_SPINLOCK(unix_gc_lock);
@@ -339,6 +342,25 @@ static void unix_walk_scc(void)
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
+	unix_graph_grouped = true;
+}
+
+static void unix_walk_scc_fast(void)
+{
+	while (!list_empty(&unix_unvisited_vertices)) {
+		struct unix_vertex *vertex;
+		struct list_head scc;
+
+		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
+		list_add(&scc, &vertex->scc_entry);
+
+		list_for_each_entry_reverse(vertex, &scc, scc_entry)
+			list_move_tail(&vertex->entry, &unix_visited_vertices);
+
+		list_del(&scc);
+	}
+
+	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 }
 
 static LIST_HEAD(gc_candidates);
@@ -491,7 +513,10 @@ static void __unix_gc(struct work_struct *work)
 	if (!unix_graph_maybe_cyclic)
 		goto skip_gc;
 
-	unix_walk_scc();
+	if (unix_graph_grouped)
+		unix_walk_scc_fast();
+	else
+		unix_walk_scc();
 
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
-- 
2.30.2


