Return-Path: <netdev+bounces-50335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593937F560B
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DE9281626
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008B51C05;
	Thu, 23 Nov 2023 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lt8Mj2dX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B091191
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700704162; x=1732240162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DSN8QTiB9XD9Pf25ag8DE3MTHEiEdtLwc5TPl0aF+GI=;
  b=lt8Mj2dXJ2hQNRi1u//d4wt9RXk1uwcRl6Y37C2Vpm1uSZu8GzmaXGmD
   FUFCZ3fqmi24RDri/KcR8KsF7kb1jPU08lE7Nn69NHJ9Umyld+xDvYSFm
   hWuGqbhv4TUku1hnQ3LGhWlnUMbSMcVpCdk1foRt8vlgItclyLhwpcFql
   8=;
X-IronPort-AV: E=Sophos;i="6.04,220,1695686400"; 
   d="scan'208";a="686577695"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 01:49:16 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com (Postfix) with ESMTPS id 1A897C20F4;
	Thu, 23 Nov 2023 01:49:13 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:22511]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.242:2525] with esmtp (Farcaster)
 id 13a0309e-9f90-4f8e-a01f-fca215617fbf; Thu, 23 Nov 2023 01:49:13 +0000 (UTC)
X-Farcaster-Flow-ID: 13a0309e-9f90-4f8e-a01f-fca215617fbf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:49:12 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:49:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 3/4] af_unix: Run GC on only one CPU.
Date: Wed, 22 Nov 2023 17:47:46 -0800
Message-ID: <20231123014747.66063-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231123014747.66063-1-kuniyu@amazon.com>
References: <20231123014747.66063-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

If more than 16000 inflight AF_UNIX sockets exist and the garbage
collector is not running, unix_(dgram|stream)_sendmsg() call unix_gc().
Also, they wait for unix_gc() to complete.

In unix_gc(), all inflight AF_UNIX sockets are traversed at least once,
and more if they are the GC candidate.  Thus, sendmsg() significantly
slows down with too many inflight AF_UNIX sockets.

There is a small window to invoke multiple unix_gc() instances, which
will then be blocked by the same spinlock except for one.

Let's convert unix_gc() to use struct work so that it will not consume
CPUs unnecessarily.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 4d634f5f6a55..8bc93a7e745f 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -86,7 +86,9 @@
 /* Internal data structures and random procedures: */
 
 static LIST_HEAD(gc_candidates);
-static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
+
+static void __unix_gc(struct work_struct *work);
+static DECLARE_WORK(unix_gc_work, __unix_gc);
 
 static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			  struct sk_buff_head *hitlist)
@@ -181,24 +183,22 @@ static void inc_inflight_move_tail(struct unix_sock *u)
 		list_move_tail(&u->link, &gc_candidates);
 }
 
-static bool gc_in_progress;
 #define UNIX_INFLIGHT_TRIGGER_GC 16000
 
 void wait_for_unix_gc(void)
 {
-	/* If number of inflight sockets is insane,
-	 * force a garbage collect right now.
+	/* If number of inflight sockets is insane, kick a
+	 * garbage collect right now.
 	 * Paired with the WRITE_ONCE() in unix_inflight(),
-	 * unix_notinflight() and gc_in_progress().
+	 * unix_notinflight().
 	 */
-	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
-	    !READ_ONCE(gc_in_progress))
-		unix_gc();
-	wait_event(unix_gc_wait, gc_in_progress == false);
+	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC)
+		queue_work(system_unbound_wq, &unix_gc_work);
+
+	flush_work(&unix_gc_work);
 }
 
-/* The external entry point: unix_gc() */
-void unix_gc(void)
+static void __unix_gc(struct work_struct *work)
 {
 	struct sk_buff *next_skb, *skb;
 	struct unix_sock *u;
@@ -209,13 +209,6 @@ void unix_gc(void)
 
 	spin_lock(&unix_gc_lock);
 
-	/* Avoid a recursive GC. */
-	if (gc_in_progress)
-		goto out;
-
-	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
-	WRITE_ONCE(gc_in_progress, true);
-
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
 	 * which don't have any external reference.
@@ -319,11 +312,10 @@ void unix_gc(void)
 	/* All candidates should have been detached by now. */
 	BUG_ON(!list_empty(&gc_candidates));
 
-	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
-	WRITE_ONCE(gc_in_progress, false);
-
-	wake_up(&unix_gc_wait);
-
- out:
 	spin_unlock(&unix_gc_lock);
 }
+
+void unix_gc(void)
+{
+	queue_work(system_unbound_wq, &unix_gc_work);
+}
-- 
2.30.2


