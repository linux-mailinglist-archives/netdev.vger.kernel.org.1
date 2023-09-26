Return-Path: <netdev+bounces-36238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078567AE794
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 10:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 208C51C2048C
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 08:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41428125A7;
	Tue, 26 Sep 2023 08:12:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570A911CB8
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 08:12:10 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82966FC;
	Tue, 26 Sep 2023 01:12:08 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; 
   d="scan'208";a="181007609"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Sep 2023 17:12:07 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C0331400BC0C;
	Tue, 26 Sep 2023 17:12:07 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Tam Nguyen <tam.nguyen.xa@renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH net v2] net: ethernet: renesas: rswitch Fix PHY station management clock setting
Date: Tue, 26 Sep 2023 17:11:56 +0900
Message-Id: <20230926081156.3930074-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix the MPIC.PSMCS value following the programming example in the
section 6.4.2 Management Data Clock (MDC) Setting, Ethernet MAC IP,
S4 Hardware User Manual Rev.1.00.

The value is calculated by
    MPIC.PSMCS = clk[MHz] / (MDC frequency[MHz] * 2) - 1
with the input clock frequency from clk_get_rate() and MDC frequency
of 2.5MHz. Otherwise, this driver cannot communicate PHYs on the R-Car
S4 Starter Kit board.

Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")
Reported-by: Tam Nguyen <tam.nguyen.xa@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
Changes from v1:
https://lore.kernel.org/all/20230925003416.3863560-1-yoshihiro.shimoda.uh@renesas.com/
 - Revise the formula on the commit description.
 - Calculate the PSMCS value by using clk_get_raate().
 -- So, change author and Add Reported-by.

 drivers/net/ethernet/renesas/rswitch.c | 13 ++++++++++++-
 drivers/net/ethernet/renesas/rswitch.h |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index ea9186178091..fc01ad3f340d 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2022 Renesas Electronics Corporation
  */
 
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/etherdevice.h>
@@ -1049,7 +1050,7 @@ static void rswitch_rmac_setting(struct rswitch_etha *etha, const u8 *mac)
 static void rswitch_etha_enable_mii(struct rswitch_etha *etha)
 {
 	rswitch_modify(etha->addr, MPIC, MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
-		       MPIC_PSMCS(0x05) | MPIC_PSMHT(0x06));
+		       MPIC_PSMCS(etha->psmcs) | MPIC_PSMHT(0x06));
 	rswitch_modify(etha->addr, MPSM, 0, MPSM_MFF_C45);
 }
 
@@ -1693,6 +1694,12 @@ static void rswitch_etha_init(struct rswitch_private *priv, int index)
 	etha->index = index;
 	etha->addr = priv->addr + RSWITCH_ETHA_OFFSET + index * RSWITCH_ETHA_SIZE;
 	etha->coma_addr = priv->addr;
+
+	/* MPIC.PSMCS = (clk [MHz] / (MDC frequency [MHz] * 2) - 1.
+	 * Calculating PSMCS value as MDC frequency = 2.5MHz. So, multiply
+	 * both the numerator and the denominator by 10.
+	 */
+	etha->psmcs = clk_get_rate(priv->clk) / 100000 / (25 * 2) - 1;
 }
 
 static int rswitch_device_alloc(struct rswitch_private *priv, int index)
@@ -1900,6 +1907,10 @@ static int renesas_eth_sw_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	spin_lock_init(&priv->lock);
 
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
 	attr = soc_device_match(rswitch_soc_no_speed_change);
 	if (attr)
 		priv->etha_no_runtime_change = true;
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index f0c16a37ea55..04f49a7a5843 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -915,6 +915,7 @@ struct rswitch_etha {
 	bool external_phy;
 	struct mii_bus *mii;
 	phy_interface_t phy_interface;
+	u32 psmcs;
 	u8 mac_addr[MAX_ADDR_LEN];
 	int link;
 	int speed;
@@ -1012,6 +1013,7 @@ struct rswitch_private {
 	struct rswitch_mfwd mfwd;
 
 	spinlock_t lock;	/* lock interrupt registers' control */
+	struct clk *clk;
 
 	bool etha_no_runtime_change;
 	bool gwca_halt;
-- 
2.25.1


