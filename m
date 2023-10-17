Return-Path: <netdev+bounces-41782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B1F7CBE35
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5414EB21029
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A947B3CD1B;
	Tue, 17 Oct 2023 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ADE3CD01
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:53:52 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 320B2F2;
	Tue, 17 Oct 2023 01:53:50 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,231,1694703600"; 
   d="scan'208";a="183356602"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Oct 2023 17:53:49 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 79DC041B263B;
	Tue, 17 Oct 2023 17:53:49 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH net] ravb: Fix races between ravb_tx_timeout_work() and net related ops
Date: Tue, 17 Oct 2023 17:53:41 +0900
Message-Id: <20231017085341.813335-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix races between ravb_tx_timeout_work() and functions of net_device_ops
and ethtool_ops by using rtnl_trylock() and rtnl_unlock(). Note that
since ravb_close() is under the rtnl lock and calls cancel_work_sync(),
ravb_tx_timeout_work() calls rtnl_trylock() to avoid a deadlock.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0ef0b88b7145..b53533ab4599 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1874,6 +1874,9 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	struct net_device *ndev = priv->ndev;
 	int error;
 
+	if (!rtnl_trylock())
+		return;
+
 	netif_tx_stop_all_queues(ndev);
 
 	/* Stop PTP Clock driver */
@@ -1907,6 +1910,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		 */
 		netdev_err(ndev, "%s: ravb_dmac_init() failed, error %d\n",
 			   __func__, error);
+		rtnl_unlock();
 		return;
 	}
 	ravb_emac_init(ndev);
@@ -1917,6 +1921,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	netif_tx_start_all_queues(ndev);
+	rtnl_unlock();
 }
 
 /* Packet transmit function for Ethernet AVB */
-- 
2.25.1


