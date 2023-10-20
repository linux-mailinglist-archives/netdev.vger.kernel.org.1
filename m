Return-Path: <netdev+bounces-42867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6927D06D9
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456CD1C20F50
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26ED1376;
	Fri, 20 Oct 2023 03:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZ5pGjCx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBE31870
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:28:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245B3D4C;
	Thu, 19 Oct 2023 20:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697772530; x=1729308530;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=96Gky6mpZZHpzgNi964Tps4EK4L+Pft4fZHmTBB7PZs=;
  b=SZ5pGjCx+5SdJ/o0PCwaYnm8gfySxrz1JJNucTi/XSx7Q7L8Li+9ByK8
   bL/+tCdVU/JYrJ0Hwi77jDyHwYqrCgpKgDoJoZJT4ftxZh7sgJYZmZbjg
   ecIHF5aWZyP0KoS4SpkVZ8kIYoQwIbFXoa3rHig4LErYH5BgYNCiV40e0
   Bvr/TGa6t//NmZlCAVOqgWzbqA5OqJcwpGoH+RY/UNC2jVgUopVQrDL9R
   SaqJgQX+P7+45khGHwHnLIMcENTJU5BQgzxpDlhGuvAVW3NO4IWg8Bz76
   9pW95xj36WGtZoOY3QSzpX0A6NRmG37tu/zYmKzQGaNcM0yqL4Kht0bXH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472645905"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472645905"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 20:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="827592040"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="827592040"
Received: from ssid-ilbpg3-teeminta.png.intel.com ([10.88.227.74])
  by fmsmga004.fm.intel.com with ESMTP; 19 Oct 2023 20:28:45 -0700
From: Gan Yi Fang <yi.fang.gan@intel.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Looi Hong Aun <hong.aun.looi@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Gan Yi Fang <yi.fang.gan@intel.com>
Subject: [PATCH net v2 1/1] net: stmmac: update MAC capabilities when tx queues are updated
Date: Fri, 20 Oct 2023 11:25:35 +0800
Message-Id: <20231020032535.1777746-1-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>

Upon boot up, the driver will configure the MAC capabilities based on
the maximum number of tx and rx queues. When the user changes the
tx queues to single queue, the MAC should be capable of supporting Half
Duplex, but the driver does not update the MAC capabilities when it is
configured so.

Using the stmmac_reinit_queues() to check the number of tx queues
and set the MAC capabilities accordingly.

Fixes: 0366f7e06a6b ("net: stmmac: add ethtool support for get/set channels")
Cc: <stable@vger.kernel.org> # 5.17+
Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c   | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ed1a5a31a491..5801f4d50f95 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1197,6 +1197,17 @@ static int stmmac_init_phy(struct net_device *dev)
 	return ret;
 }
 
+static void stmmac_set_half_duplex(struct stmmac_priv *priv)
+{
+	/* Half-Duplex can only work with single tx queue */
+	if (priv->plat->tx_queues_to_use > 1)
+		priv->phylink_config.mac_capabilities &=
+			~(MAC_10HD | MAC_100HD | MAC_1000HD);
+	else
+		priv->phylink_config.mac_capabilities |=
+			(MAC_10HD | MAC_100HD | MAC_1000HD);
+}
+
 static int stmmac_phy_setup(struct stmmac_priv *priv)
 {
 	struct stmmac_mdio_bus_data *mdio_bus_data;
@@ -1228,10 +1239,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 						MAC_10FD | MAC_100FD |
 						MAC_1000FD;
 
-	/* Half-Duplex can only work with single queue */
-	if (priv->plat->tx_queues_to_use <= 1)
-		priv->phylink_config.mac_capabilities |= MAC_10HD | MAC_100HD |
-							 MAC_1000HD;
+	stmmac_set_half_duplex(priv);
 
 	/* Get the MAC specific capabilities */
 	stmmac_mac_phylink_get_caps(priv);
@@ -7172,6 +7180,7 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
 			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
 									rx_cnt);
 
+	stmmac_set_half_duplex(priv);
 	stmmac_napi_add(dev);
 
 	if (netif_running(dev))
-- 
2.34.1


