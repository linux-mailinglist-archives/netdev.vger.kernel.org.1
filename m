Return-Path: <netdev+bounces-37906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8C87B7B72
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 11:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7580C281831
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3541096A;
	Wed,  4 Oct 2023 09:13:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FDB10951
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 09:13:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D02F98;
	Wed,  4 Oct 2023 02:13:06 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,199,1694703600"; 
   d="scan'208";a="181890598"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Oct 2023 18:13:05 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B9EA641BB248;
	Wed,  4 Oct 2023 18:13:05 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH net 0/2] ravb: Fix use-after-free issues
Date: Wed,  4 Oct 2023 18:12:51 +0900
Message-Id: <20231004091253.4194205-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series fixes use-after-free issues in ravb_remove().
The original patch is made by Zheng Wang [1]. And, I made the patch
1/2 which I found other issue in the ravb_remove().

The issue is difficult to be reproduced. So, I checked this with a fault
injection code which I made like below:
---
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1874,6 +1874,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	struct net_device *ndev = priv->ndev;
 	int error;
 
+	netdev_info(ndev, "%s: enter\n", __func__);
 	netif_tx_stop_all_queues(ndev);
 
 	/* Stop PTP Clock driver */
@@ -1911,12 +1912,15 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	}
 	ravb_emac_init(ndev);
 
+	msleep(100);
+
 out:
 	/* Initialise PTP Clock driver */
 	if (info->gptp)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	netif_tx_start_all_queues(ndev);
+	netdev_info(ndev, "%s: exit\n", __func__);
 }
 
 /* Packet transmit function for Ethernet AVB */
@@ -2886,6 +2890,7 @@ static int ravb_remove(struct platform_device *pdev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 
+	netdev_info(ndev, "%s: enter\n", __func__);
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
@@ -2895,6 +2900,11 @@ static int ravb_remove(struct platform_device *pdev)
 
 	/* Set reset mode */
 	ravb_write(ndev, CCC_OPC_RESET, CCC);
+
+	/* fault injection for tx timeout */
+	if (netif_running(ndev))
+		schedule_work(&priv->work);
+
 	unregister_netdev(ndev);
 	if (info->nc_queues)
 		netif_napi_del(&priv->napi[RAVB_NC]);
@@ -2907,6 +2917,7 @@ static int ravb_remove(struct platform_device *pdev)
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
 	platform_set_drvdata(pdev, NULL);
+	netdev_info(ndev, "%s: exit\n", __func__);
 
 	return 0;
 }
---

Before the patches are applied, the following message output if unbind:
# echo e6800000.ethernet > unbind
ravb e6800000.ethernet eth0: ravb_remove: enter
ravb e6800000.ethernet eth0: ravb_tx_timeout_work: enter
ravb e6800000.ethernet eth0: Link is Down
ravb e6800000.ethernet eth0 (released): ravb_remove: exit
platform e6800000.ethernet eth0 (released): ravb_tx_timeout_work: exit

After the patches were appliedy, "released" ravb_tx_timeout_work disappeared:
ravb e6800000.ethernet eth0: ravb_remove: enter
ravb e6800000.ethernet eth0: ravb_tx_timeout_work: enter
ravb e6800000.ethernet eth0: Link is Down
ravb e6800000.ethernet eth0: ravb_tx_timeout_work: exit
ravb e6800000.ethernet eth0 (released): ravb_remove: exit

[1]
https://lore.kernel.org/netdev/20230725030026.1664873-1-zyytlz.wz@163.com/

Yoshihiro Shimoda (2):
  ravb: Fix dma_free_coherent() of desc_bat timing in ravb_remove()
  ravb: Fix use-after-free issue in ravb_remove and ravb_tx_timeout_work

 drivers/net/ethernet/renesas/ravb_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1


