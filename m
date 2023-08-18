Return-Path: <netdev+bounces-28820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD84780D12
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D69B1C21617
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 13:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB33318C1E;
	Fri, 18 Aug 2023 13:54:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5E018C0E
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 13:54:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD214FC;
	Fri, 18 Aug 2023 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692366850; x=1723902850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JDFUtXRUDrxtVzEusowNhWGcSf1zOgP5VGknWG1AdaE=;
  b=hDYMaQZ+SLHHh6e+pa0/FLPeW61PJSlKyQOkS+ORBGcaUJVDWjk7DL+C
   AR21AkX0w8SV6NecmukyuyxznrhaSj9hqxQKWwcfq4hQsaaCclHtI82cr
   8uhWYiQjKfHKYemwEPzzTfa8b5RX+E2kemxoE3MsAj6QXbZx4mlMpLvcj
   thkUIRIz8B+Fyg1Y04GHKEyogy5zpnISGUML+USngB7NOtS2e/3ZJ0Nj4
   /4CAANA9yHkMUv2ZuU28ujm7N7cUVFlTCW6fGFsjuHVZo1/WqYZvwyGjM
   cwCfPVnOjvq/I6q6k4EmOZUE5ExBcisNMeBbr1dQs/dIwqYUYliaHpH0V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="353408041"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="353408041"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 06:54:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="849307172"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="849307172"
Received: from pglc00067.png.intel.com ([10.221.207.87])
  by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 06:54:06 -0700
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>
Subject: [PATCH net-next v4 2/2] net: stmmac: Tx coe sw fallback
Date: Fri, 18 Aug 2023 21:53:50 +0800
Message-Id: <20230818135350.12474-3-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230818135350.12474-1-rohan.g.thomas@intel.com>
References: <20230818135350.12474-1-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add sw fallback of tx checksum calculation for those tx queues that
don't support tx checksum offloading. Because, some DWMAC IPs support
tx checksum offloading only for a few initial tx queues, starting
from tx queue 0.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  5 +++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  4 ++++
 include/linux/stmmac.h                        |  1 +
 4 files changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 3401e888a9f6..64d7dbe474bd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -210,12 +210,17 @@ struct stmmac_dma_conf {
 	unsigned int dma_tx_size;
 };
 
+#define STMMAC_PRIV_FLG_TXQ_COE_LIMIT	BIT(0)
+
 struct stmmac_priv {
 	/* Frequently used values are kept adjacent for cache effect */
 	u32 tx_coal_frames[MTL_MAX_TX_QUEUES];
 	u32 tx_coal_timer[MTL_MAX_TX_QUEUES];
 	u32 rx_coal_frames[MTL_MAX_TX_QUEUES];
 
+	u32 flags;
+
+	u32 tx_q_with_coe;
 	int hwts_tx_en;
 	bool tx_path_in_lpi_mode;
 	bool tso;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 733b5e900817..f9ab6635218c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4409,6 +4409,17 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	WARN_ON(tx_q->tx_skbuff[first_entry]);
 
 	csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
+	/* Some DWMAC IPs support tx coe only for a few initial tx queues,
+	 * starting from tx queue 0. So checksum offloading for those queues
+	 * that don't support tx coe needs to fallback to software checksum
+	 * calculation.
+	 */
+	if (csum_insertion && (priv->flags & STMMAC_PRIV_FLG_TXQ_COE_LIMIT) &&
+	    queue >= priv->tx_q_with_coe) {
+		if (unlikely(skb_checksum_help(skb)))
+			goto dma_map_err;
+		csum_insertion = !csum_insertion;
+	}
 
 	if (likely(priv->extend_desc))
 		desc = (struct dma_desc *)(tx_q->dma_etx + entry);
@@ -7401,6 +7412,14 @@ int stmmac_dvr_probe(struct device *device,
 		dev_info(priv->device, "SPH feature enabled\n");
 	}
 
+	if (priv->plat->tx_coe &&
+	    priv->plat->tx_queues_with_coe < priv->plat->tx_queues_to_use) {
+		priv->flags |= STMMAC_PRIV_FLG_TXQ_COE_LIMIT;
+		priv->tx_q_with_coe = priv->plat->tx_queues_with_coe;
+		dev_info(priv->device, "TX COE limited to %u tx queues\n",
+			 priv->tx_q_with_coe);
+	}
+
 	/* Ideally our host DMA address width is the same as for the
 	 * device. However, it may differ and then we have to use our
 	 * host DMA width for allocation and the device DMA width for
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index be8e79c7aa34..0138b7c9c7ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -225,6 +225,10 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 				 &plat->tx_queues_to_use))
 		plat->tx_queues_to_use = 1;
 
+	if (of_property_read_u32(tx_node, "snps,tx-queues-with-coe",
+				 &plat->tx_queues_with_coe))
+		plat->tx_queues_with_coe = plat->tx_queues_to_use;
+
 	if (of_property_read_bool(tx_node, "snps,tx-sched-wrr"))
 		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_WRR;
 	else if (of_property_read_bool(tx_node, "snps,tx-sched-wfq"))
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 784277d666eb..cb508164eaea 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -252,6 +252,7 @@ struct plat_stmmacenet_data {
 	u32 host_dma_width;
 	u32 rx_queues_to_use;
 	u32 tx_queues_to_use;
+	u32 tx_queues_with_coe;
 	u8 rx_sched_algorithm;
 	u8 tx_sched_algorithm;
 	struct stmmac_rxq_cfg rx_queues_cfg[MTL_MAX_RX_QUEUES];
-- 
2.19.0


