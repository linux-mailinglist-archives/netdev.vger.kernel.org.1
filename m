Return-Path: <netdev+bounces-93383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68198BB716
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94251C20CB0
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEFD5CDE6;
	Fri,  3 May 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BwB1aI5y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997C5290F
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775551; cv=none; b=QvoJfggkSgN+cC27+y19K7QODVlWJzndsmShxKdcg2tsBwRMcLqZiLmuM2pfAnjze218SSPTJEvp7xcDjNxlYZ9pEeD7C7Vfb53VDC2XLlWmMxmO06e+4h20mSgNpfTC+bWBTK5Mp29Ceu64eDzGyv78yDik6Y3xYoaDssV69Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775551; c=relaxed/simple;
	bh=68jEzkxLIir83oGSB9RS/2TTjim1XB6frA/leiPlURQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F74J/7g1c5POdNsUTaSNAp4A85LheibvlbCzM7sqlQQX602UZ2sfXKW5nEI7WqDHoPurjI2jV5V+K6rPe6ag6M6JTMNbzymS/MVxTreh24iucqwpLPR95oRorDLjhyQiVGyLrvIyL0KSeIHul9HZnnzeT9GCeWV6on48pcBUZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BwB1aI5y; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714775550; x=1746311550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Bdg3MzvrsoNG9rOHa0+yM6/qrkHrO8W/nDfkAcnnzk=;
  b=BwB1aI5ySCaKRu4RQO/CbcOGPVj5ALz4x6n0HwNZG03qMjcEBcPFgA8H
   kAoehUPOGA2xOhAvEJd5NsP3rEyQ/f9BYxPTfj62SX7XLHwxW/5dzZAGo
   nsO9aDeuBOT44W1i1DlZz/wMFPToESlmTf5W7TaRZYU5tCBFEzOUm2MnC
   0=;
X-IronPort-AV: E=Sophos;i="6.07,252,1708387200"; 
   d="scan'208";a="630825643"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 22:32:27 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:39401]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.7:2525] with esmtp (Farcaster)
 id f505cff7-f9c1-44ab-b3b7-9af5e92a6fc0; Fri, 3 May 2024 22:32:26 +0000 (UTC)
X-Farcaster-Flow-ID: f505cff7-f9c1-44ab-b3b7-9af5e92a6fc0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 22:32:26 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 3 May 2024 22:32:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/6] af_unix: Add dead flag to struct scm_fp_list.
Date: Fri, 3 May 2024 15:31:45 -0700
Message-ID: <20240503223150.6035-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit 1af2dface5d2 ("af_unix: Don't access successor in unix_del_edges()
during GC.") fixed use-after-free by avoid accessing edge->successor while
GC is in progress.

However, there could be a small race window where another process could
call unix_del_edges() while gc_in_progress is true and __skb_queue_purge()
is on the way.

So, we cannot rely on gc_in_progress and need another marker per struct
scm_fp_list which indicates if the skb is garbage-collected.

This patch adds dead flag in struct scm_fp_list and set it true before
calling __skb_queue_purge() in __unix_gc().

Fixes: 1af2dface5d2 ("af_unix: Don't access successor in unix_del_edges() during GC.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/scm.h  |  1 +
 net/core/scm.c     |  1 +
 net/unix/garbage.c | 14 ++++++++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index bbc5527809d1..0d35c7c77a74 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -33,6 +33,7 @@ struct scm_fp_list {
 	short			max;
 #ifdef CONFIG_UNIX
 	bool			inflight;
+	bool			dead;
 	struct list_head	vertices;
 	struct unix_edge	*edges;
 #endif
diff --git a/net/core/scm.c b/net/core/scm.c
index 5763f3320358..4f6a14babe5a 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -91,6 +91,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		fpl->user = NULL;
 #if IS_ENABLED(CONFIG_UNIX)
 		fpl->inflight = false;
+		fpl->dead = false;
 		fpl->edges = NULL;
 		INIT_LIST_HEAD(&fpl->vertices);
 #endif
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index d76450133e4f..1f8b8cdfcdc8 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -158,13 +158,11 @@ static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 	unix_update_graph(unix_edge_successor(edge));
 }
 
-static bool gc_in_progress;
-
 static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
 	struct unix_vertex *vertex = edge->predecessor->vertex;
 
-	if (!gc_in_progress)
+	if (!fpl->dead)
 		unix_update_graph(unix_edge_successor(edge));
 
 	list_del(&edge->vertex_entry);
@@ -240,7 +238,7 @@ void unix_del_edges(struct scm_fp_list *fpl)
 		unix_del_edge(fpl, edge);
 	} while (i < fpl->count_unix);
 
-	if (!gc_in_progress) {
+	if (!fpl->dead) {
 		receiver = fpl->edges[0].successor;
 		receiver->scm_stat.nr_unix_fds -= fpl->count_unix;
 	}
@@ -559,9 +557,12 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 }
 
+static bool gc_in_progress;
+
 static void __unix_gc(struct work_struct *work)
 {
 	struct sk_buff_head hitlist;
+	struct sk_buff *skb;
 
 	spin_lock(&unix_gc_lock);
 
@@ -579,6 +580,11 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_unlock(&unix_gc_lock);
 
+	skb_queue_walk(&hitlist, skb) {
+		if (UNIXCB(skb).fp)
+			UNIXCB(skb).fp->dead = true;
+	}
+
 	__skb_queue_purge(&hitlist);
 skip_gc:
 	WRITE_ONCE(gc_in_progress, false);
-- 
2.30.2


