Return-Path: <netdev+bounces-111059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164F192F9F7
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 14:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC11281C89
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 12:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C350716B3A5;
	Fri, 12 Jul 2024 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H1xhSthX"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D091D512;
	Fri, 12 Jul 2024 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720786033; cv=none; b=TIMyRa814KByKLQwiTp/FXIf2TsBa0ZQQ4isYyMgudareinf7dnw7nbmgvP9m4EvIGfTuipAeZ/eTBiBHTaB00mVjrZmPySALhPcha4AtI8rVhJynFAxYFFEaTzrmn21IGAmYfpNszENGB8XDcGmi6BG0VucQ8IlWjXIm00WvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720786033; c=relaxed/simple;
	bh=8DCeMdtDmQ69MBP+vf8TCy0iGXjdp/J8exd8ROhW1GI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ob3guMVQCgh43l5+uTkgQHiuD+WH4q3AFmx9oAu5DTAkY2aEA+lqMtyPni2kiJrs62Y/BJXw2W8+JYLjLYHHny0NaooakHcEBA/Aa3gFCuMILDk5t1Op2Ix/kAO1APBBYRu4ufE1DhI8XDFZNrjEoOIq+l4SUMpL2yl4fv5vuNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H1xhSthX; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46CC6dIm066262;
	Fri, 12 Jul 2024 07:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720785999;
	bh=gQBBZZsiIpC/32IdS6Vv7a9bHbDaf7WVgr403T/ZfJQ=;
	h=From:To:CC:Subject:Date;
	b=H1xhSthXu5LY75+chDa+MpPZl/pWa6/6aoQ0+cDlfC8EBaZS9sqL5CA4QY4Ccryjk
	 Ri2JtCObtMc1VryTWyrdb91TakPk7YjovluQHEwsdEVRioemwdWmPJNeQKGa3Rojq0
	 sGYKWJWrU+ya49Vd75j/CPsJl1X2GlTWUHy0s3ko=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46CC6dFa116464
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jul 2024 07:06:39 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jul 2024 07:06:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jul 2024 07:06:39 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46CC6dbY085301;
	Fri, 12 Jul 2024 07:06:39 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 46CC6c6V005273;
	Fri, 12 Jul 2024 07:06:38 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Simon Horman <horms@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>, Paolo
 Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH net-next v3] net: ti: icssg-prueth: Split out common object into module
Date: Fri, 12 Jul 2024 17:36:36 +0530
Message-ID: <20240712120636.814564-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

icssg_prueth.c and icssg_prueth_sr1.c drivers use multiple common .c
files. These common objects are getting added to multiple modules. As a
result when both drivers are enabled in .config, below warning is seen.

drivers/net/ethernet/ti/Makefile: icssg/icssg_common.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
drivers/net/ethernet/ti/Makefile: icssg/icssg_classifier.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
drivers/net/ethernet/ti/Makefile: icssg/icssg_config.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
drivers/net/ethernet/ti/Makefile: icssg/icssg_mii_cfg.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
drivers/net/ethernet/ti/Makefile: icssg/icssg_stats.o is added to multiple modules: icssg-prueth icssg-prueth-sr1
drivers/net/ethernet/ti/Makefile: icssg/icssg_ethtool.o is added to multiple modules: icssg-prueth icssg-prueth-sr1

Fix this by building a new module (icssg.o) for all the common objects.
Both the driver can then depend on this common module.

Some APIs being exported have emac_ as the prefix which may result into
confusion with other existing APIs with emac_ prefix, to avoid
confusion, rename the APIs being exported with emac_ to icssg_ prefix.

This also fixes below error seen when both drivers are built.
ERROR: modpost: "icssg_queue_pop"
[drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!
ERROR: modpost: "icssg_queue_push"
[drivers/net/ethernet/ti/icssg-prueth-sr1.ko] undefined!

Reported-and-tested-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/oe-kbuild-all/202405182038.ncf1mL7Z-lkp@intel.com/
Fixes: 487f7323f39a ("net: ti: icssg-prueth: Add helper functions to configure FDB")
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Thorsten Leemhuis <linux@leemhuis.info>

NOTE: This is only applicable on net-next but not on net as the patch that
introduced this dependency is part of net-next.

v2 -> v3:
*) Renamed APIs being exported with emac_ prefix to icssg_ prefix as suggested
   by Andrew Lunn <andrew@lunn.ch> to avoid confusion with arc/emac_rockchip.c,
   allwinner/sun4i-emac.c, ibm/emac/, and qualcomm/emac/
*) Modified commit message to describe renaming APIs as part of this commit as well.
*) Rebased on latest net-next/main.
*) Added RB tag of Roger Quadros <rogerq@kernel.org>
*) Added Reported-and-tested-by tag of Thorsten Leemhuis <linux@leemhuis.info>

v1 -> v2:
*) Instead of just adding the missing module to icssg-prueth-sr1, the
   patch also splits the common objects into new module as suggested by
   Andrew Lunn <andrew@lunn.ch>
*) Not carrying Tested-by tag of Thorsten Leemhuis <linux@leemhuis.info>
   as this patch has significant diff over v1. I would like him to test
   this patch again.

v1 https://lore.kernel.org/all/20240605035617.2189393-1-danishanwar@ti.com/
v2 https://lore.kernel.org/all/20240606073639.3299252-1-danishanwar@ti.com/#t

 drivers/net/ethernet/ti/Makefile              | 32 ++++++------
 .../net/ethernet/ti/icssg/icssg_classifier.c  |  6 +++
 drivers/net/ethernet/ti/icssg/icssg_common.c  | 50 +++++++++++++++----
 drivers/net/ethernet/ti/icssg/icssg_config.c  | 15 +++++-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  1 +
 drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c |  4 ++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 38 +++++++-------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  | 22 ++++----
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  | 14 +++---
 drivers/net/ethernet/ti/icssg/icssg_queues.c  |  2 +
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |  3 +-
 .../net/ethernet/ti/icssg/icssg_switchdev.c   |  4 +-
 12 files changed, 122 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 59cd20a38267..cbcf44806924 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -31,22 +31,18 @@ ti-am65-cpsw-nuss-$(CONFIG_TI_AM65_CPSW_QOS) += am65-cpsw-qos.o
 ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
 obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
 
-obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o
-icssg-prueth-y := icssg/icssg_prueth.o \
-		  icssg/icssg_common.o \
-		  icssg/icssg_classifier.o \
-		  icssg/icssg_queues.o \
-		  icssg/icssg_config.o \
-		  icssg/icssg_mii_cfg.o \
-		  icssg/icssg_stats.o \
-		  icssg/icssg_ethtool.o \
-		  icssg/icssg_switchdev.o
-obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o
-icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o \
-		      icssg/icssg_common.o \
-		      icssg/icssg_classifier.o \
-		      icssg/icssg_config.o \
-		      icssg/icssg_mii_cfg.o \
-		      icssg/icssg_stats.o \
-		      icssg/icssg_ethtool.o
+obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o icssg.o
+icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o
+
+obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o icssg.o
+icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o
+
+icssg-y := icssg/icssg_common.o \
+	   icssg/icssg_classifier.o \
+	   icssg/icssg_queues.o \
+	   icssg/icssg_config.o \
+	   icssg/icssg_mii_cfg.o \
+	   icssg/icssg_stats.o \
+	   icssg/icssg_ethtool.o
+
 obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
index f7d21da1a0fb..9ec504d976d6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
@@ -297,6 +297,7 @@ void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
 		     mac[2] << 16 | mac[3] << 24));
 	regmap_write(miig_rt, offs[slice].mac1, (u32)(mac[4] | mac[5] << 8));
 }
+EXPORT_SYMBOL_GPL(icssg_class_set_mac_addr);
 
 static void icssg_class_ft1_add_mcast(struct regmap *miig_rt, int slice,
 				      int slot, const u8 *addr, const u8 *mask)
@@ -360,6 +361,7 @@ void icssg_class_disable(struct regmap *miig_rt, int slice)
 	/* clear CFG2 */
 	regmap_write(miig_rt, offs[slice].rx_class_cfg2, 0);
 }
+EXPORT_SYMBOL_GPL(icssg_class_disable);
 
 void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti,
 			 bool is_sr1)
@@ -390,6 +392,7 @@ void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti,
 	/* clear CFG2 */
 	regmap_write(miig_rt, offs[slice].rx_class_cfg2, 0);
 }
+EXPORT_SYMBOL_GPL(icssg_class_default);
 
 void icssg_class_promiscuous_sr1(struct regmap *miig_rt, int slice)
 {
@@ -408,6 +411,7 @@ void icssg_class_promiscuous_sr1(struct regmap *miig_rt, int slice)
 		regmap_write(miig_rt, offset, data);
 	}
 }
+EXPORT_SYMBOL_GPL(icssg_class_promiscuous_sr1);
 
 void icssg_class_add_mcast_sr1(struct regmap *miig_rt, int slice,
 			       struct net_device *ndev)
@@ -449,6 +453,7 @@ void icssg_class_add_mcast_sr1(struct regmap *miig_rt, int slice,
 		slot++;
 	}
 }
+EXPORT_SYMBOL_GPL(icssg_class_add_mcast_sr1);
 
 /* required for SAV check */
 void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
@@ -460,3 +465,4 @@ void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
 	rx_class_ft1_set_da_mask(miig_rt, slice, 0, mask_addr);
 	rx_class_ft1_cfg_set_type(miig_rt, slice, 0, FT1_CFG_TYPE_EQ);
 }
+EXPORT_SYMBOL_GPL(icssg_ft1_set_mac_addr);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 2f716c0d7060..b9d8a93d1680 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -51,6 +51,7 @@ void prueth_cleanup_rx_chns(struct prueth_emac *emac,
 	if (rx_chn->rx_chn)
 		k3_udma_glue_release_rx_chn(rx_chn->rx_chn);
 }
+EXPORT_SYMBOL_GPL(prueth_cleanup_rx_chns);
 
 void prueth_cleanup_tx_chns(struct prueth_emac *emac)
 {
@@ -71,6 +72,7 @@ void prueth_cleanup_tx_chns(struct prueth_emac *emac)
 		memset(tx_chn, 0, sizeof(*tx_chn));
 	}
 }
+EXPORT_SYMBOL_GPL(prueth_cleanup_tx_chns);
 
 void prueth_ndev_del_tx_napi(struct prueth_emac *emac, int num)
 {
@@ -84,6 +86,7 @@ void prueth_ndev_del_tx_napi(struct prueth_emac *emac, int num)
 		netif_napi_del(&tx_chn->napi_tx);
 	}
 }
+EXPORT_SYMBOL_GPL(prueth_ndev_del_tx_napi);
 
 void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 		      struct cppi5_host_desc_t *desc)
@@ -120,6 +123,7 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 
 	k3_cppi_desc_pool_free(tx_chn->desc_pool, first_desc);
 }
+EXPORT_SYMBOL_GPL(prueth_xmit_free);
 
 int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 			     int budget, bool *tdown)
@@ -264,6 +268,7 @@ int prueth_ndev_add_tx_napi(struct prueth_emac *emac)
 	prueth_ndev_del_tx_napi(emac, i);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(prueth_ndev_add_tx_napi);
 
 int prueth_init_tx_chns(struct prueth_emac *emac)
 {
@@ -344,6 +349,7 @@ int prueth_init_tx_chns(struct prueth_emac *emac)
 	prueth_cleanup_tx_chns(emac);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(prueth_init_tx_chns);
 
 int prueth_init_rx_chns(struct prueth_emac *emac,
 			struct prueth_rx_chn *rx_chn,
@@ -453,6 +459,7 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
 	prueth_cleanup_rx_chns(emac, rx_chn, max_rflows);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(prueth_init_rx_chns);
 
 int prueth_dma_rx_push(struct prueth_emac *emac,
 		       struct sk_buff *skb,
@@ -490,6 +497,7 @@ int prueth_dma_rx_push(struct prueth_emac *emac,
 	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, 0,
 					desc_rx, desc_dma);
 }
+EXPORT_SYMBOL_GPL(prueth_dma_rx_push);
 
 u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32 cycle_time_ns)
 {
@@ -505,6 +513,7 @@ u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32 cycle_time_ns)
 
 	return ns;
 }
+EXPORT_SYMBOL_GPL(icssg_ts_to_ns);
 
 void emac_rx_timestamp(struct prueth_emac *emac,
 		       struct sk_buff *skb, u32 *psdata)
@@ -636,7 +645,7 @@ static int prueth_tx_ts_cookie_get(struct prueth_emac *emac)
 }
 
 /**
- * emac_ndo_start_xmit - EMAC Transmit function
+ * icssg_ndo_start_xmit - EMAC Transmit function
  * @skb: SKB pointer
  * @ndev: EMAC network adapter
  *
@@ -647,7 +656,7 @@ static int prueth_tx_ts_cookie_get(struct prueth_emac *emac)
  *
  * Return: enum netdev_tx
  */
-enum netdev_tx emac_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct cppi5_host_desc_t *first_desc, *next_desc, *cur_desc;
 	struct prueth_emac *emac = netdev_priv(ndev);
@@ -806,6 +815,7 @@ enum netdev_tx emac_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	netif_tx_stop_queue(netif_txq);
 	return NETDEV_TX_BUSY;
 }
+EXPORT_SYMBOL_GPL(icssg_ndo_start_xmit);
 
 static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
 {
@@ -831,6 +841,7 @@ irqreturn_t prueth_rx_irq(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL_GPL(prueth_rx_irq);
 
 void prueth_emac_stop(struct prueth_emac *emac)
 {
@@ -855,6 +866,7 @@ void prueth_emac_stop(struct prueth_emac *emac)
 	rproc_shutdown(prueth->rtu[slice]);
 	rproc_shutdown(prueth->pru[slice]);
 }
+EXPORT_SYMBOL_GPL(prueth_emac_stop);
 
 void prueth_cleanup_tx_ts(struct prueth_emac *emac)
 {
@@ -867,8 +879,9 @@ void prueth_cleanup_tx_ts(struct prueth_emac *emac)
 		}
 	}
 }
+EXPORT_SYMBOL_GPL(prueth_cleanup_tx_ts);
 
-int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
+int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 {
 	struct prueth_emac *emac = prueth_napi_to_emac(napi_rx);
 	int rx_flow = emac->is_sr1 ?
@@ -905,6 +918,7 @@ int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 
 	return num_rx;
 }
+EXPORT_SYMBOL_GPL(icssg_napi_rx_poll);
 
 int prueth_prepare_rx_chan(struct prueth_emac *emac,
 			   struct prueth_rx_chn *chn,
@@ -930,6 +944,7 @@ int prueth_prepare_rx_chan(struct prueth_emac *emac,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(prueth_prepare_rx_chan);
 
 void prueth_reset_tx_chan(struct prueth_emac *emac, int ch_num,
 			  bool free_skb)
@@ -944,6 +959,7 @@ void prueth_reset_tx_chan(struct prueth_emac *emac, int ch_num,
 		k3_udma_glue_disable_tx_chn(emac->tx_chns[i].tx_chn);
 	}
 }
+EXPORT_SYMBOL_GPL(prueth_reset_tx_chan);
 
 void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
 			  int num_flows, bool disable)
@@ -956,11 +972,13 @@ void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
 	if (disable)
 		k3_udma_glue_disable_rx_chn(chn->rx_chn);
 }
+EXPORT_SYMBOL_GPL(prueth_reset_rx_chan);
 
-void emac_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue)
+void icssg_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue)
 {
 	ndev->stats.tx_errors++;
 }
+EXPORT_SYMBOL_GPL(icssg_ndo_tx_timeout);
 
 static int emac_set_ts_config(struct net_device *ndev, struct ifreq *ifr)
 {
@@ -1024,7 +1042,7 @@ static int emac_get_ts_config(struct net_device *ndev, struct ifreq *ifr)
 			    -EFAULT : 0;
 }
 
-int emac_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
+int icssg_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
 {
 	switch (cmd) {
 	case SIOCGHWTSTAMP:
@@ -1037,9 +1055,10 @@ int emac_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
 
 	return phy_do_ioctl(ndev, ifr, cmd);
 }
+EXPORT_SYMBOL_GPL(icssg_ndo_ioctl);
 
-void emac_ndo_get_stats64(struct net_device *ndev,
-			  struct rtnl_link_stats64 *stats)
+void icssg_ndo_get_stats64(struct net_device *ndev,
+			   struct rtnl_link_stats64 *stats)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 
@@ -1058,9 +1077,10 @@ void emac_ndo_get_stats64(struct net_device *ndev,
 	stats->tx_errors  = ndev->stats.tx_errors;
 	stats->tx_dropped = ndev->stats.tx_dropped;
 }
+EXPORT_SYMBOL_GPL(icssg_ndo_get_stats64);
 
-int emac_ndo_get_phys_port_name(struct net_device *ndev, char *name,
-				size_t len)
+int icssg_ndo_get_phys_port_name(struct net_device *ndev, char *name,
+				 size_t len)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 	int ret;
@@ -1071,6 +1091,7 @@ int emac_ndo_get_phys_port_name(struct net_device *ndev, char *name,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(icssg_ndo_get_phys_port_name);
 
 /* get emac_port corresponding to eth_node name */
 int prueth_node_port(struct device_node *eth_node)
@@ -1089,6 +1110,7 @@ int prueth_node_port(struct device_node *eth_node)
 	else
 		return PRUETH_PORT_INVALID;
 }
+EXPORT_SYMBOL_GPL(prueth_node_port);
 
 /* get MAC instance corresponding to eth_node name */
 int prueth_node_mac(struct device_node *eth_node)
@@ -1107,6 +1129,7 @@ int prueth_node_mac(struct device_node *eth_node)
 	else
 		return PRUETH_MAC_INVALID;
 }
+EXPORT_SYMBOL_GPL(prueth_node_mac);
 
 void prueth_netdev_exit(struct prueth *prueth,
 			struct device_node *eth_node)
@@ -1132,6 +1155,7 @@ void prueth_netdev_exit(struct prueth *prueth,
 	free_netdev(emac->ndev);
 	prueth->emac[mac] = NULL;
 }
+EXPORT_SYMBOL_GPL(prueth_netdev_exit);
 
 int prueth_get_cores(struct prueth *prueth, int slice, bool is_sr1)
 {
@@ -1182,6 +1206,7 @@ int prueth_get_cores(struct prueth *prueth, int slice, bool is_sr1)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(prueth_get_cores);
 
 void prueth_put_cores(struct prueth *prueth, int slice)
 {
@@ -1194,6 +1219,7 @@ void prueth_put_cores(struct prueth *prueth, int slice)
 	if (prueth->pru[slice])
 		pru_rproc_put(prueth->pru[slice]);
 }
+EXPORT_SYMBOL_GPL(prueth_put_cores);
 
 #ifdef CONFIG_PM_SLEEP
 static int prueth_suspend(struct device *dev)
@@ -1250,3 +1276,9 @@ static int prueth_resume(struct device *dev)
 const struct dev_pm_ops prueth_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(prueth_suspend, prueth_resume)
 };
+EXPORT_SYMBOL_GPL(prueth_dev_pm_ops);
+
+MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
+MODULE_AUTHOR("Md Danish Anwar <danishanwar@ti.com>");
+MODULE_DESCRIPTION("PRUSS ICSSG Ethernet Driver Common Module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 9444e56b7672..dae52a83a378 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -248,6 +248,7 @@ void icssg_config_ipg(struct prueth_emac *emac)
 
 	icssg_mii_update_ipg(prueth->mii_rt, slice, ipg);
 }
+EXPORT_SYMBOL_GPL(icssg_config_ipg);
 
 static void emac_r30_cmd_init(struct prueth_emac *emac)
 {
@@ -508,6 +509,7 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(icssg_config);
 
 /* Bitmask for ICSSG r30 commands */
 static const struct icssg_r30_cmd emac_r32_bitmask[] = {
@@ -532,8 +534,8 @@ static const struct icssg_r30_cmd emac_r32_bitmask[] = {
 	{{0xffef0000,  EMAC_NONE, 0xffef0000, EMAC_NONE}}	/* VLAN UNWARE*/
 };
 
-int emac_set_port_state(struct prueth_emac *emac,
-			enum icssg_port_state_cmd cmd)
+int icssg_set_port_state(struct prueth_emac *emac,
+			 enum icssg_port_state_cmd cmd)
 {
 	struct icssg_r30_cmd __iomem *p;
 	int ret = -ETIMEDOUT;
@@ -564,6 +566,7 @@ int emac_set_port_state(struct prueth_emac *emac,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(icssg_set_port_state);
 
 void icssg_config_half_duplex(struct prueth_emac *emac)
 {
@@ -575,6 +578,7 @@ void icssg_config_half_duplex(struct prueth_emac *emac)
 	val = get_random_u32();
 	writel(val, emac->dram.va + HD_RAND_SEED_OFFSET);
 }
+EXPORT_SYMBOL_GPL(icssg_config_half_duplex);
 
 void icssg_config_set_speed(struct prueth_emac *emac)
 {
@@ -601,6 +605,7 @@ void icssg_config_set_speed(struct prueth_emac *emac)
 
 	writeb(fw_speed, emac->dram.va + PORT_LINK_SPEED_OFFSET);
 }
+EXPORT_SYMBOL_GPL(icssg_config_set_speed);
 
 int icssg_send_fdb_msg(struct prueth_emac *emac, struct mgmt_cmd *cmd,
 		       struct mgmt_cmd_rsp *rsp)
@@ -635,6 +640,7 @@ int icssg_send_fdb_msg(struct prueth_emac *emac, struct mgmt_cmd *cmd,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(icssg_send_fdb_msg);
 
 static void icssg_fdb_setup(struct prueth_emac *emac, struct mgmt_cmd *fdb_cmd,
 			    const unsigned char *addr, u8 fid, int cmd)
@@ -687,6 +693,7 @@ int icssg_fdb_add_del(struct prueth_emac *emac, const unsigned char *addr,
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(icssg_fdb_add_del);
 
 int icssg_fdb_lookup(struct prueth_emac *emac, const unsigned char *addr,
 		     u8 vid)
@@ -716,6 +723,7 @@ int icssg_fdb_lookup(struct prueth_emac *emac, const unsigned char *addr,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(icssg_fdb_lookup);
 
 void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
 		       u8 untag_mask, bool add)
@@ -741,6 +749,7 @@ void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
 
 	tbl[vid].fid_c1 = fid_c1;
 }
+EXPORT_SYMBOL_GPL(icssg_vtbl_modify);
 
 u16 icssg_get_pvid(struct prueth_emac *emac)
 {
@@ -756,6 +765,7 @@ u16 icssg_get_pvid(struct prueth_emac *emac)
 
 	return pvid;
 }
+EXPORT_SYMBOL_GPL(icssg_get_pvid);
 
 void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port)
 {
@@ -771,3 +781,4 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port)
 	else
 		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT0_DEFAULT_VLAN_OFFSET);
 }
+EXPORT_SYMBOL_GPL(icssg_set_pvid);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index c8d0f45cc5b1..131eb4cae1c3 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -312,3 +312,4 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.nway_reset = emac_nway_reset,
 	.get_rmon_stats = emac_get_rmon_stats,
 };
+EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c b/drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c
index 92718ae40d7e..b64955438bb2 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_mii_cfg.c
@@ -40,6 +40,7 @@ void icssg_mii_update_mtu(struct regmap *mii_rt, int mii, int mtu)
 				   (mtu - 1) << PRUSS_MII_RT_RX_FRMS_MAX_FRM_SHIFT);
 	}
 }
+EXPORT_SYMBOL_GPL(icssg_mii_update_mtu);
 
 void icssg_update_rgmii_cfg(struct regmap *miig_rt, struct prueth_emac *emac)
 {
@@ -66,6 +67,7 @@ void icssg_update_rgmii_cfg(struct regmap *miig_rt, struct prueth_emac *emac)
 	regmap_update_bits(miig_rt, RGMII_CFG_OFFSET, full_duplex_mask,
 			   full_duplex_val);
 }
+EXPORT_SYMBOL_GPL(icssg_update_rgmii_cfg);
 
 void icssg_miig_set_interface_mode(struct regmap *miig_rt, int mii, phy_interface_t phy_if)
 {
@@ -105,6 +107,7 @@ u32 icssg_rgmii_get_speed(struct regmap *miig_rt, int mii)
 
 	return icssg_rgmii_cfg_get_bitfield(miig_rt, mask, shift);
 }
+EXPORT_SYMBOL_GPL(icssg_rgmii_get_speed);
 
 u32 icssg_rgmii_get_fullduplex(struct regmap *miig_rt, int mii)
 {
@@ -118,3 +121,4 @@ u32 icssg_rgmii_get_fullduplex(struct regmap *miig_rt, int mii)
 
 	return icssg_rgmii_cfg_get_bitfield(miig_rt, mask, shift);
 }
+EXPORT_SYMBOL_GPL(icssg_rgmii_get_fullduplex);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index e13835100754..3e51b3a9b0a5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -249,10 +249,10 @@ static void emac_adjust_link(struct net_device *ndev)
 			icssg_config_ipg(emac);
 			spin_unlock_irqrestore(&emac->lock, flags);
 			icssg_config_set_speed(emac);
-			emac_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
+			icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
 
 		} else {
-			emac_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
+			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
 		}
 	}
 
@@ -694,17 +694,17 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 
 	promisc = ndev->flags & IFF_PROMISC;
 	allmulti = ndev->flags & IFF_ALLMULTI;
-	emac_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_DISABLE);
-	emac_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_DISABLE);
+	icssg_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_DISABLE);
+	icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_DISABLE);
 
 	if (promisc) {
-		emac_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_ENABLE);
-		emac_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
+		icssg_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_ENABLE);
+		icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
 		return;
 	}
 
 	if (allmulti) {
-		emac_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
+		icssg_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
 		return;
 	}
 
@@ -728,14 +728,14 @@ static void emac_ndo_set_rx_mode(struct net_device *ndev)
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = emac_ndo_open,
 	.ndo_stop = emac_ndo_stop,
-	.ndo_start_xmit = emac_ndo_start_xmit,
+	.ndo_start_xmit = icssg_ndo_start_xmit,
 	.ndo_set_mac_address = eth_mac_addr,
 	.ndo_validate_addr = eth_validate_addr,
-	.ndo_tx_timeout = emac_ndo_tx_timeout,
+	.ndo_tx_timeout = icssg_ndo_tx_timeout,
 	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
-	.ndo_eth_ioctl = emac_ndo_ioctl,
-	.ndo_get_stats64 = emac_ndo_get_stats64,
-	.ndo_get_phys_port_name = emac_ndo_get_phys_port_name,
+	.ndo_eth_ioctl = icssg_ndo_ioctl,
+	.ndo_get_stats64 = icssg_ndo_get_stats64,
+	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -771,7 +771,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	}
 	INIT_WORK(&emac->rx_mode_work, emac_ndo_set_rx_mode_work);
 
-	INIT_DELAYED_WORK(&emac->stats_work, emac_stats_work_handler);
+	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
 
 	ret = pruss_request_mem_region(prueth->pruss,
 				       port == PRUETH_PORT_MII0 ?
@@ -864,7 +864,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->hw_features = NETIF_F_SG;
 	ndev->features = ndev->hw_features;
 
-	netif_napi_add(ndev, &emac->napi_rx, emac_napi_rx_poll);
+	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
 	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL_PINNED);
 	emac->rx_hrtimer.function = &emac_rx_timer_callback;
@@ -927,8 +927,8 @@ static void prueth_emac_restart(struct prueth *prueth)
 		netif_device_detach(emac1->ndev);
 
 	/* Disable both PRUeth ports */
-	emac_set_port_state(emac0, ICSSG_EMAC_PORT_DISABLE);
-	emac_set_port_state(emac1, ICSSG_EMAC_PORT_DISABLE);
+	icssg_set_port_state(emac0, ICSSG_EMAC_PORT_DISABLE);
+	icssg_set_port_state(emac1, ICSSG_EMAC_PORT_DISABLE);
 
 	/* Stop both pru cores for both PRUeth ports*/
 	prueth_emac_stop(emac0);
@@ -943,8 +943,8 @@ static void prueth_emac_restart(struct prueth *prueth)
 	prueth->emacs_initialized++;
 
 	/* Enable forwarding for both PRUeth ports */
-	emac_set_port_state(emac0, ICSSG_EMAC_PORT_FORWARD);
-	emac_set_port_state(emac1, ICSSG_EMAC_PORT_FORWARD);
+	icssg_set_port_state(emac0, ICSSG_EMAC_PORT_FORWARD);
+	icssg_set_port_state(emac1, ICSSG_EMAC_PORT_FORWARD);
 
 	/* Attache net_device for both PRUeth ports */
 	netif_device_attach(emac0->ndev);
@@ -972,7 +972,7 @@ static void icssg_enable_switch_mode(struct prueth *prueth)
 					  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
 					  true);
 			icssg_set_pvid(prueth, emac->port_vlan, emac->port_id);
-			emac_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
+			icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
 		}
 	}
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 5eeeccb73665..f678d656a3ed 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -329,8 +329,8 @@ void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr);
 void icssg_config_ipg(struct prueth_emac *emac);
 int icssg_config(struct prueth *prueth, struct prueth_emac *emac,
 		 int slice);
-int emac_set_port_state(struct prueth_emac *emac,
-			enum icssg_port_state_cmd state);
+int icssg_set_port_state(struct prueth_emac *emac,
+			 enum icssg_port_state_cmd state);
 void icssg_config_set_speed(struct prueth_emac *emac);
 void icssg_config_half_duplex(struct prueth_emac *emac);
 
@@ -352,7 +352,7 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
 #define prueth_napi_to_tx_chn(pnapi) \
 	container_of(pnapi, struct prueth_tx_chn, napi_tx)
 
-void emac_stats_work_handler(struct work_struct *work);
+void icssg_stats_work_handler(struct work_struct *work);
 void emac_update_hardware_stats(struct prueth_emac *emac);
 int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
 
@@ -377,11 +377,11 @@ int prueth_dma_rx_push(struct prueth_emac *emac,
 		       struct prueth_rx_chn *rx_chn);
 void emac_rx_timestamp(struct prueth_emac *emac,
 		       struct sk_buff *skb, u32 *psdata);
-enum netdev_tx emac_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev);
+enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev);
 irqreturn_t prueth_rx_irq(int irq, void *dev_id);
 void prueth_emac_stop(struct prueth_emac *emac);
 void prueth_cleanup_tx_ts(struct prueth_emac *emac);
-int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget);
+int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget);
 int prueth_prepare_rx_chan(struct prueth_emac *emac,
 			   struct prueth_rx_chn *chn,
 			   int buf_size);
@@ -389,12 +389,12 @@ void prueth_reset_tx_chan(struct prueth_emac *emac, int ch_num,
 			  bool free_skb);
 void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
 			  int num_flows, bool disable);
-void emac_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue);
-int emac_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd);
-void emac_ndo_get_stats64(struct net_device *ndev,
-			  struct rtnl_link_stats64 *stats);
-int emac_ndo_get_phys_port_name(struct net_device *ndev, char *name,
-				size_t len);
+void icssg_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue);
+int icssg_ndo_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd);
+void icssg_ndo_get_stats64(struct net_device *ndev,
+			   struct rtnl_link_stats64 *stats);
+int icssg_ndo_get_phys_port_name(struct net_device *ndev, char *name,
+				 size_t len);
 int prueth_node_port(struct device_node *eth_node);
 int prueth_node_mac(struct device_node *eth_node);
 void prueth_netdev_exit(struct prueth *prueth,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index fa98bdb11ece..e180c1166170 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -722,14 +722,14 @@ static void emac_ndo_set_rx_mode_sr1(struct net_device *ndev)
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = emac_ndo_open,
 	.ndo_stop = emac_ndo_stop,
-	.ndo_start_xmit = emac_ndo_start_xmit,
+	.ndo_start_xmit = icssg_ndo_start_xmit,
 	.ndo_set_mac_address = eth_mac_addr,
 	.ndo_validate_addr = eth_validate_addr,
-	.ndo_tx_timeout = emac_ndo_tx_timeout,
+	.ndo_tx_timeout = icssg_ndo_tx_timeout,
 	.ndo_set_rx_mode = emac_ndo_set_rx_mode_sr1,
-	.ndo_eth_ioctl = emac_ndo_ioctl,
-	.ndo_get_stats64 = emac_ndo_get_stats64,
-	.ndo_get_phys_port_name = emac_ndo_get_phys_port_name,
+	.ndo_eth_ioctl = icssg_ndo_ioctl,
+	.ndo_get_stats64 = icssg_ndo_get_stats64,
+	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -767,7 +767,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 		goto free_ndev;
 	}
 
-	INIT_DELAYED_WORK(&emac->stats_work, emac_stats_work_handler);
+	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
 
 	ret = pruss_request_mem_region(prueth->pruss,
 				       port == PRUETH_PORT_MII0 ?
@@ -854,7 +854,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->hw_features = NETIF_F_SG;
 	ndev->features = ndev->hw_features;
 
-	netif_napi_add(ndev, &emac->napi_rx, emac_napi_rx_poll);
+	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
 	prueth->emac[mac] = emac;
 
 	return 0;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_queues.c b/drivers/net/ethernet/ti/icssg/icssg_queues.c
index 3c34f61ad40b..e5052d9e7807 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_queues.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_queues.c
@@ -28,6 +28,7 @@ int icssg_queue_pop(struct prueth *prueth, u8 queue)
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(icssg_queue_pop);
 
 void icssg_queue_push(struct prueth *prueth, int queue, u16 addr)
 {
@@ -36,6 +37,7 @@ void icssg_queue_push(struct prueth *prueth, int queue, u16 addr)
 
 	regmap_write(prueth->miig_rt, ICSSG_QUEUE_OFFSET + 4 * queue, addr);
 }
+EXPORT_SYMBOL_GPL(icssg_queue_push);
 
 u32 icssg_queue_level(struct prueth *prueth, int queue)
 {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 3dbadddd7e35..2fb150c13078 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -42,7 +42,7 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 	}
 }
 
-void emac_stats_work_handler(struct work_struct *work)
+void icssg_stats_work_handler(struct work_struct *work)
 {
 	struct prueth_emac *emac = container_of(work, struct prueth_emac,
 						stats_work.work);
@@ -51,6 +51,7 @@ void emac_stats_work_handler(struct work_struct *work)
 	queue_delayed_work(system_long_wq, &emac->stats_work,
 			   msecs_to_jiffies((STATS_TIME_LIMIT_1G_MS * 1000) / emac->speed));
 }
+EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
 
 int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
index fceb8bb7d34e..67e2927e176d 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_switchdev.c
@@ -44,7 +44,7 @@ static int prueth_switchdev_stp_state_set(struct prueth_emac *emac,
 		return -EOPNOTSUPP;
 	}
 
-	emac_set_port_state(emac, emac_state);
+	icssg_set_port_state(emac, emac_state);
 	netdev_dbg(emac->ndev, "STP state: %u\n", emac_state);
 
 	return ret;
@@ -64,7 +64,7 @@ static int prueth_switchdev_attr_br_flags_set(struct prueth_emac *emac,
 	netdev_dbg(emac->ndev, "BR_MCAST_FLOOD: %d port %u\n",
 		   emac_state, emac->port_id);
 
-	emac_set_port_state(emac, emac_state);
+	icssg_set_port_state(emac, emac_state);
 
 	return 0;
 }

base-commit: 2146b7dd354c2a1384381ca3cd5751bfff6137d6
-- 
2.34.1


