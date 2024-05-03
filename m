Return-Path: <netdev+bounces-93384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1C88BB79E
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9138F1F2575C
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB971824AC;
	Fri,  3 May 2024 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r2CaK2gF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31068137749
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775578; cv=none; b=u9sIxsR+ITPd7SZsqTEM0jUaf3HFr9lxX6n22mXW5jsVYd4k+Yrf7OzgL62XamoNA+cuRKhb0eOhYN1XYGh5oq8/Qh7Cnc5z7JfWI4WF5MCZ7zUpG57UiwLYIvbj3v6xZxrKu0y2/BNTVTxxQSzfbFYKZb3d/GzNoBxdXr8ynZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775578; c=relaxed/simple;
	bh=kFAiNMew9eE5IO6wYhpGJqrCtW1OtcqF03jNP9Hkonc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWqVcErWrUqNbtumu8GMUZXf6ITH/2VxbgN5BwsoJrbYrDkXO/b3oHATWtd++Pjvf+nYibC/I9SHEcZCrtxHT51zThpVb96JIMTIv4n2xu/tv0n5Gf0wAfJ8Mry67y12CmKuOkm5ufEU5sm6bCONSG7lKGsXy+o2W03VSD52txk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=r2CaK2gF; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714775577; x=1746311577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9PXod9CnmezhySErZOmJWIDiqtplhQZNHyrxRmDfD3I=;
  b=r2CaK2gFjnTRsEc75ZyS21FjgB5P5M/NNQgi8o7DXlKGEmu7Vb8FcX4R
   m4UEYF24XnFHVNK1Wg/bM+FBBykI02ligvWcdLLBDJWuLGKTzfONOSCOh
   8qqDw7t5+O44QYeXaN0+lr7eC5ReJen6AnMAa98gW1qnmJgz2W46wo1fb
   E=;
X-IronPort-AV: E=Sophos;i="6.07,252,1708387200"; 
   d="scan'208";a="416766960"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 22:32:50 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:9422]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.142:2525] with esmtp (Farcaster)
 id 6e063397-e104-4e88-8933-7dbc2a2b14bc; Fri, 3 May 2024 22:32:50 +0000 (UTC)
X-Farcaster-Flow-ID: 6e063397-e104-4e88-8933-7dbc2a2b14bc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 22:32:50 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 3 May 2024 22:32:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/6] af_unix: Save the number of loops in inflight graph.
Date: Fri, 3 May 2024 15:31:46 -0700
Message-ID: <20240503223150.6035-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240503223150.6035-1-kuniyu@amazon.com>
References: <20240503223150.6035-1-kuniyu@amazon.com>
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

unix_walk_scc_fast() calls unix_scc_cyclic() for every SCC so that we
can make unix_graph_maybe_cyclic false when all SCC are cleaned up.

If we count the number of loops in the graph during Tarjan's algorithm,
we need not call unix_scc_cyclic() in unix_walk_scc_fast().

Instead, we can just decrement the number when calling unix_collect_skb()
and update unix_graph_maybe_cyclic based on the count.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 1f8b8cdfcdc8..7ffb80dd422c 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -405,6 +405,7 @@ static bool unix_scc_cyclic(struct list_head *scc)
 
 static LIST_HEAD(unix_visited_vertices);
 static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
+static unsigned long unix_graph_circles;
 
 static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_index,
 			    struct sk_buff_head *hitlist)
@@ -494,8 +495,8 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 
 		if (scc_dead)
 			unix_collect_skb(&scc, hitlist);
-		else if (!unix_graph_maybe_cyclic)
-			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
+		else if (unix_scc_cyclic(&scc))
+			unix_graph_circles++;
 
 		list_del(&scc);
 	}
@@ -509,7 +510,7 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
 {
 	unsigned long last_index = UNIX_VERTEX_INDEX_START;
 
-	unix_graph_maybe_cyclic = false;
+	unix_graph_circles = 0;
 
 	/* Visit every vertex exactly once.
 	 * __unix_walk_scc() moves visited vertices to unix_visited_vertices.
@@ -524,13 +525,12 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
 
+	unix_graph_maybe_cyclic = !!unix_graph_circles;
 	unix_graph_grouped = true;
 }
 
 static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 {
-	unix_graph_maybe_cyclic = false;
-
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
 		struct list_head scc;
@@ -546,15 +546,18 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 				scc_dead = unix_vertex_dead(vertex);
 		}
 
-		if (scc_dead)
+		if (scc_dead) {
 			unix_collect_skb(&scc, hitlist);
-		else if (!unix_graph_maybe_cyclic)
-			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
+			unix_graph_circles--;
+		}
 
 		list_del(&scc);
 	}
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
+
+	if (!unix_graph_circles)
+		unix_graph_maybe_cyclic = false;
 }
 
 static bool gc_in_progress;
-- 
2.30.2


