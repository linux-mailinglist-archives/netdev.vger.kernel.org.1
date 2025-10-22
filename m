Return-Path: <netdev+bounces-231850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFC6BFDFE7
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89DC8189B77C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E3233507E;
	Wed, 22 Oct 2025 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzmBWSJc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF3321428
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160637; cv=none; b=pybl0/cpPxyrjvOJOPAjcVhD8zl8tkD6/LYVvOTCyyTRiBwb7nTiMlU8XsuqsZPa7qG+lghN1eDkhacmRMLWym9fuuv2D/kQJSNCMjtFKot4tyvpG1QnJqGiFWYQabYSvJL2VwPs82WOkKzbcl+xNZsqmZ4+wedzGjOvZL3G6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160637; c=relaxed/simple;
	bh=wmAmGNSEVHU8Hyx06ClPgR73jfAMqR2AV6yRCA1xvoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJXsoAclQuia1KwZ4smXclAnhPP7QHTG8Ilr/JTYE233R6737VhY5sRFUMZyUNcvV/BcM0y+ha/8pUbuvq3e9Q85u5Rpiq6FceH6UegO4LyOQM1jQpGf5lQ0VPlN7T2clcRMh3zOUerRmJQBswwM0rT9+Tj0qSdYBA1Cx32Vrd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzmBWSJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBF7C4CEE7
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160637;
	bh=wmAmGNSEVHU8Hyx06ClPgR73jfAMqR2AV6yRCA1xvoQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FzmBWSJciy8cy8XBhfm+xid0ZrWvD+jX1JNKfRziT11xcZUPCLfkxRiKgLHhIBbZR
	 isrSx4pzawxzO8dfkXltxEQtPRZGj1m5nfvm5rDX3QESUsRlWQhDdULOgcYWDJqccU
	 rBumuI8TRYiv4Q7u4Wx9XeAEE/S0795WDIGbsZ13ueH8gYcmwaf2EHnej15Aa0TKHG
	 p+t5SwdHXJRJNFupr3DQViC6IJS7YvovOxZV1hc5AJjcJVLavjaSuhUYEnYOPP0Tb7
	 pi+HWvvEBQXI083cxhXxNnlHyMJRyDEGHW0LO+/jlHswZXoqYPNE+9j5Y+6jhDqxCP
	 d0uthCx4DRblw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Subject: [RFC 02/15] net/rds: Give each connection its own workqueue
Date: Wed, 22 Oct 2025 12:17:02 -0700
Message-ID: <20251022191715.157755-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022191715.157755-1-achender@kernel.org>
References: <20251022191715.157755-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Håkon Bugge <haakon.bugge@oracle.com>

RDS was written to require ordered workqueues for "cp->cp_wq":
Work is executed in the order scheduled, one item at a time.

If these workqueues are shared across connections,
then work executed on behalf of one connection blocks work
scheduled for a different and unrelated connection.

Luckily we don't need to share these workqueues.
While it obviously makes sense to limit the number of
workers (processes) that ought to be allocated on a system,
a workqueue that doesn't have a rescue worker attached,
has a tiny footprint compared to the connection as a whole:
A workqueue costs ~800 bytes, while an RDS/IB connection
totals ~5 MBytes.

So we're getting a signficant performance gain
(90% of connections fail over under 3 seconds vs. 40%)
for a less than 0.02% overhead.

RDS doesn't even benefit from the additional rescue workers:
of all the reasons that RDS blocks workers, allocation under
memory pressue is the least of our concerns.
And even if RDS was stalling due to the memory-reclaim process,
the work executed by the rescue workers are highly unlikely
to free up any memory.
If anything, they might try to allocate even more.

By giving each connection its own workqueues, we allow RDS
to better utilize the unbound workers that the system
has available.

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c | 12 +++++++++++-
 net/rds/ib.c         |  5 +++++
 net/rds/rds.h        |  1 +
 net/rds/threads.c    |  1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index dc7323707f45..ac555f02c045 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -269,7 +269,14 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 		__rds_conn_path_init(conn, &conn->c_path[i],
 				     is_outgoing);
 		conn->c_path[i].cp_index = i;
-		conn->c_path[i].cp_wq = rds_wq;
+		conn->c_path[i].cp_wq = alloc_ordered_workqueue("krds_cp_wq#%lu/%d", 0,
+								rds_conn_count, i);
+		if (!conn->c_path[i].cp_wq) {
+			while (--i >= 0)
+				destroy_workqueue(conn->c_path[i].cp_wq);
+			conn = ERR_PTR(-ENOMEM);
+			goto out;
+		}
 	}
 	rcu_read_lock();
 	if (rds_destroy_pending(conn))
@@ -471,6 +478,9 @@ static void rds_conn_path_destroy(struct rds_conn_path *cp)
 	WARN_ON(work_pending(&cp->cp_down_w));
 
 	cp->cp_conn->c_trans->conn_free(cp->cp_transport_data);
+
+	destroy_workqueue(cp->cp_wq);
+	cp->cp_wq = NULL;
 }
 
 /*
diff --git a/net/rds/ib.c b/net/rds/ib.c
index 9826fe7f9d00..6694d31e6cfd 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -491,9 +491,14 @@ static int rds_ib_laddr_check(struct net *net, const struct in6_addr *addr,
 
 static void rds_ib_unregister_client(void)
 {
+	int i;
+
 	ib_unregister_client(&rds_ib_client);
 	/* wait for rds_ib_dev_free() to complete */
 	flush_workqueue(rds_wq);
+
+	for (i = 0; i < RDS_NMBR_CP_WQS; ++i)
+		flush_workqueue(rds_cp_wqs[i]);
 }
 
 static void rds_ib_set_unloading(void)
diff --git a/net/rds/rds.h b/net/rds/rds.h
index 11fa304f2164..3b7ac773208b 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -40,6 +40,7 @@
 #ifdef ATOMIC64_INIT
 #define KERNEL_HAS_ATOMIC64
 #endif
+
 #ifdef RDS_DEBUG
 #define rdsdebug(fmt, args...) pr_debug("%s(): " fmt, __func__ , ##args)
 #else
diff --git a/net/rds/threads.c b/net/rds/threads.c
index 639302bab51e..956811f8f764 100644
--- a/net/rds/threads.c
+++ b/net/rds/threads.c
@@ -33,6 +33,7 @@
 #include <linux/kernel.h>
 #include <linux/random.h>
 #include <linux/export.h>
+#include <linux/workqueue.h>
 
 #include "rds.h"
 
-- 
2.43.0


