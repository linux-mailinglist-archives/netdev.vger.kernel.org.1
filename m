Return-Path: <netdev+bounces-50331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF0C7F5605
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAEF1C20BB8
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A591385;
	Thu, 23 Nov 2023 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx310.baidu.com [180.101.52.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3109812A;
	Wed, 22 Nov 2023 17:45:39 -0800 (PST)
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id E01AB7F000A9;
	Thu, 23 Nov 2023 09:45:37 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	wintera@linux.ibm.com,
	dust.li@linux.alibaba.com
Subject: [PATCH net-next v4] net/smc: remove unneeded atomic operations in smc_tx_sndbuf_nonempty
Date: Thu, 23 Nov 2023 09:45:37 +0800
Message-Id: <20231123014537.9786-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The commit dcd2cf5f2fc0 ("net/smc: add autocorking support") adds an
atomic variable tx_pushing in smc_connection to make sure only one can
send to let it cork more and save CDC slot. since smc_tx_pending can be
called in the soft IRQ without checking sock_owned_by_user() at that
time, which would cause a race condition because bh_lock_sock() did
not honor sock_lock()

After commit 6b88af839d20 ("net/smc: don't send in the BH context if
sock_owned_by_user"), the transmission is deferred to when sock_lock()
is held by the user. Therefore, we no longer need tx_pending to hold
message.

So remove atomic variable tx_pushing and its operation, and
smc_tx_sndbuf_nonempty becomes a wrapper of __smc_tx_sndbuf_nonempty,
so rename __smc_tx_sndbuf_nonempty back to smc_tx_sndbuf_nonempty

Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
Co-developed-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
diff v4: remove atomic variable tx_pushing
diff v3: improvements in the commit body and comments
diff v2: fix a typo in commit body and add net-next subject-prefix

 net/smc/smc.h    |  1 -
 net/smc/smc_tx.c | 30 +-----------------------------
 2 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index e377980..cd51261 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -196,7 +196,6 @@ struct smc_connection {
 						 * - dec on polled tx cqe
 						 */
 	wait_queue_head_t	cdc_pend_tx_wq; /* wakeup on no cdc_pend_tx_wr*/
-	atomic_t		tx_pushing;     /* nr_threads trying tx push */
 	struct delayed_work	tx_work;	/* retry of smc_cdc_msg_send */
 	u32			tx_off;		/* base offset in peer rmb */
 
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 3b0ff3b..214ac3c 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -621,7 +621,7 @@ static int smcd_tx_sndbuf_nonempty(struct smc_connection *conn)
 	return rc;
 }
 
-static int __smc_tx_sndbuf_nonempty(struct smc_connection *conn)
+int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
 {
 	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
 	int rc = 0;
@@ -655,34 +655,6 @@ static int __smc_tx_sndbuf_nonempty(struct smc_connection *conn)
 	return rc;
 }
 
-int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
-{
-	int rc;
-
-	/* This make sure only one can send simultaneously to prevent wasting
-	 * of CPU and CDC slot.
-	 * Record whether someone has tried to push while we are pushing.
-	 */
-	if (atomic_inc_return(&conn->tx_pushing) > 1)
-		return 0;
-
-again:
-	atomic_set(&conn->tx_pushing, 1);
-	smp_wmb(); /* Make sure tx_pushing is 1 before real send */
-	rc = __smc_tx_sndbuf_nonempty(conn);
-
-	/* We need to check whether someone else have added some data into
-	 * the send queue and tried to push but failed after the atomic_set()
-	 * when we are pushing.
-	 * If so, we need to push again to prevent those data hang in the send
-	 * queue.
-	 */
-	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing)))
-		goto again;
-
-	return rc;
-}
-
 /* Wakeup sndbuf consumers from process context
  * since there is more data to transmit. The caller
  * must hold sock lock.
-- 
2.9.4


