Return-Path: <netdev+bounces-93388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C62D8BB7A3
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42654B21D4D
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E5277F08;
	Fri,  3 May 2024 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TjS/+F25"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECF84A52
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 22:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775670; cv=none; b=IQUlD48R/j7P+T3edHtil/idp4I1WaivPZhPYrD2jf8aYZGciigbhdbGUVyj14VYsjB6wIqEhqH6yaISFyJiTDp+CIdNwoFTjA0HRbPym2fozCgFt2O3tybjH70R6rUqczq17qbIdNKR58i4mXCE/6deytc3aZXKZGAi8hUbWQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775670; c=relaxed/simple;
	bh=ZajLOb9jV4zmgIw2oL0s2pKlMKG8s7USQqyz1aBgkwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYlVtA1t+t6hA+a1BLqywjPn6JyTTlgzmpKDaKtZ6+Mwvtb+tLvAcBXYxJ0OyCuIj9TXSYqwAfPTSgywzW8AVZO8l3HGVcslbpMPViP7IwgEZ848/9Eu22FwSBDMfRx/xXMhSmTBcdZxkw8Y5RkeUAa1h5U9atjbkVlbXFZmlSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TjS/+F25; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714775669; x=1746311669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8vQ+M0cbMKRhEiF1UmeexocvcoDcl1UjVusgW7tFfsg=;
  b=TjS/+F25wbSALsuKc89RC1mA8buNP0/hqjJDMe7l1hUMGO3M6y5Mjnzg
   9FB4u4VEBHX7vk19xPC/EyOqQy+vQyB7qeV7GgW2j4XnTb+WjyzSvREID
   6jbKpny9/1y07xGkEgzAsosECgCgpWFLbFNSDuUxg4OFZbr+8zwny0lYw
   E=;
X-IronPort-AV: E=Sophos;i="6.07,252,1708387200"; 
   d="scan'208";a="342642134"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 22:34:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:22906]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.7:2525] with esmtp (Farcaster)
 id 4f86ff23-c05b-4227-9912-c60a3abfbab8; Fri, 3 May 2024 22:34:26 +0000 (UTC)
X-Farcaster-Flow-ID: 4f86ff23-c05b-4227-9912-c60a3abfbab8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 22:34:25 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 22:34:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 6/6] af_unix: Schedule GC only if loop exists during close().
Date: Fri, 3 May 2024 15:31:50 -0700
Message-ID: <20240503223150.6035-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

If unix_tot_inflight is not 0 when AF_UNIX socket is close()d, GC is
always scheduled.

However, we need not do so if we know no loop exists in the inflight
graph.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  3 +--
 net/unix/af_unix.c    |  3 +--
 net/unix/garbage.c    | 30 +++++++++++++++---------------
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index ebd1b3ca8906..1270b2c08b8f 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -17,13 +17,12 @@ static inline struct unix_sock *unix_get_socket(struct file *filp)
 }
 #endif
 
-extern unsigned int unix_tot_inflight;
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
 void unix_del_edges(struct scm_fp_list *fpl);
 void unix_update_edges(struct unix_sock *receiver);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
-void unix_gc(void);
+void unix_schedule_gc(void);
 
 struct unix_vertex {
 	struct list_head edges;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 863058be35f3..b99f7170835e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -677,8 +677,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	 *	  What the above comment does talk about? --ANK(980817)
 	 */
 
-	if (READ_ONCE(unix_tot_inflight))
-		unix_gc();		/* Garbage collect fds */
+	unix_schedule_gc();
 }
 
 static void init_peercred(struct sock *sk)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 48cea3cf4a42..2cecbb97882c 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -189,7 +189,7 @@ static void unix_free_vertices(struct scm_fp_list *fpl)
 }
 
 static DEFINE_SPINLOCK(unix_gc_lock);
-unsigned int unix_tot_inflight;
+static unsigned int unix_tot_inflight;
 
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 {
@@ -577,11 +577,6 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_lock(&unix_gc_lock);
 
-	if (unix_graph_state == UNIX_GRAPH_NOT_CYCLIC) {
-		spin_unlock(&unix_gc_lock);
-		goto skip_gc;
-	}
-
 	__skb_queue_head_init(&hitlist);
 
 	if (unix_graph_state == UNIX_GRAPH_CYCLIC)
@@ -597,18 +592,12 @@ static void __unix_gc(struct work_struct *work)
 	}
 
 	__skb_queue_purge(&hitlist);
-skip_gc:
+
 	WRITE_ONCE(gc_in_progress, false);
 }
 
 static DECLARE_WORK(unix_gc_work, __unix_gc);
 
-void unix_gc(void)
-{
-	WRITE_ONCE(gc_in_progress, true);
-	queue_work(system_unbound_wq, &unix_gc_work);
-}
-
 #define UNIX_INFLIGHT_SANE_CIRCLES (1 << 10)
 #define UNIX_INFLIGHT_SANE_SOCKETS (1 << 14)
 #define UNIX_INFLIGHT_SANE_USER (SCM_MAX_FD * 8)
@@ -621,6 +610,9 @@ static void __unix_schedule_gc(struct scm_fp_list *fpl)
 	if (graph_state == UNIX_GRAPH_NOT_CYCLIC)
 		return;
 
+	if (!fpl)
+		goto schedule;
+
 	/* If the number of inflight sockets or cyclic references
 	 * is insane, schedule garbage collector if not running.
 	 */
@@ -638,9 +630,17 @@ static void __unix_schedule_gc(struct scm_fp_list *fpl)
 	if (READ_ONCE(fpl->user->unix_inflight) > UNIX_INFLIGHT_SANE_USER)
 		wait = true;
 
-	if (!READ_ONCE(gc_in_progress))
-		unix_gc();
+schedule:
+	if (!READ_ONCE(gc_in_progress)) {
+		WRITE_ONCE(gc_in_progress, true);
+		queue_work(system_unbound_wq, &unix_gc_work);
+	}
 
 	if (wait)
 		flush_work(&unix_gc_work);
 }
+
+void unix_schedule_gc(void)
+{
+	__unix_schedule_gc(NULL);
+}
-- 
2.30.2


