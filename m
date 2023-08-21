Return-Path: <netdev+bounces-29193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0874B782108
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 03:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9E51C20371
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 01:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E58264B;
	Mon, 21 Aug 2023 01:14:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F98627
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 01:14:21 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3972DA0
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 18:14:20 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RTZGV702TzrSDD;
	Mon, 21 Aug 2023 09:12:50 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 09:14:17 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <dhowells@redhat.com>, <marc.dionne@auristor.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liaoyu15@huawei.com>, <linux-afs@lists.infradead.org>,
	<netdev@vger.kernel.org>, <liwei391@huawei.com>
Subject: [PATCH net-next] rxrpc: use timer_shutdown_sync() for cleanup operations
Date: Mon, 21 Aug 2023 09:10:41 +0800
Message-ID: <20230821011041.3186528-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There was a race [1] between timer and rxrpc_exit_net() which was solved by
calling del_timer_sync() before and after cancel_work_sync(). A better
solution is to use timer_shutdown_sync() [2] to solve the circular
dependency problem. The correct ordering of calls in this case is:

  timer_shutdown_sync(&mything->timer);
  workqueue_destroy(&mything->workqueue);

After calling timer_shutdown_sync(), timer won't be rearmed from the
workqueue.

[1] https://lore.kernel.org/164984498582.2000115.4023190177137486137.stgit@warthog.procyon.org.uk
[2] https://lore.kernel.org/r/20221123201625.314230270@linutronix.de

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 net/rxrpc/conn_object.c | 5 ++---
 net/rxrpc/net_ns.c      | 4 +---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index ac85d4644a3c..1afd677848af 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -317,9 +317,8 @@ static void rxrpc_clean_up_connection(struct work_struct *work)
 	       !conn->channels[3].call);
 	ASSERT(list_empty(&conn->cache_link));
 
-	del_timer_sync(&conn->timer);
-	cancel_work_sync(&conn->processor); /* Processing may restart the timer */
-	del_timer_sync(&conn->timer);
+	timer_shutdown_sync(&conn->timer);
+	cancel_work_sync(&conn->processor);
 
 	write_lock(&rxnet->conn_lock);
 	list_del_init(&conn->proc_link);
diff --git a/net/rxrpc/net_ns.c b/net/rxrpc/net_ns.c
index a0319c040c25..38cfbd2c7991 100644
--- a/net/rxrpc/net_ns.c
+++ b/net/rxrpc/net_ns.c
@@ -101,10 +101,8 @@ static __net_exit void rxrpc_exit_net(struct net *net)
 	struct rxrpc_net *rxnet = rxrpc_net(net);
 
 	rxnet->live = false;
-	del_timer_sync(&rxnet->peer_keepalive_timer);
+	timer_shutdown_sync(&rxnet->peer_keepalive_timer);
 	cancel_work_sync(&rxnet->peer_keepalive_work);
-	/* Remove the timer again as the worker may have restarted it. */
-	del_timer_sync(&rxnet->peer_keepalive_timer);
 	rxrpc_destroy_all_calls(rxnet);
 	rxrpc_destroy_all_connections(rxnet);
 	rxrpc_destroy_all_peers(rxnet);
-- 
2.25.1


