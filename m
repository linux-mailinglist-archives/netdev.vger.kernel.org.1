Return-Path: <netdev+bounces-216368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F24BB3353F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF5A3AF122
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19469281532;
	Mon, 25 Aug 2025 04:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXmmoFxU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374D281508;
	Mon, 25 Aug 2025 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096630; cv=none; b=s/CrRjchCRUG8qcQYhYfd9kGb4D1hsYH49M7WMynkXkyF2Wf7Scy3yFnSjpWLxWaGFINAo9ewL4jvqgaHRZGtnRvoJES9Cm+dZpjuarS0DiijuCIog5ncpuRO5piH4DJwB+PCdiT7FJU09KKX/OaCmB45uEFZRDB080LNaMM8FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096630; c=relaxed/simple;
	bh=ybvae2Us24QQdhHAuMB8pyUUuzHIpPAy3rGRBQp46KE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qsbnO3tDAZHPvlqCtH+4HApgqHHmPEHtaXLKOz72L5ZgniHeP6pCZ2GFuze/6IUhsVJ0GJCN0XVUjudvEBHuTrjTDOo5HChHHUMxqUdoIfFAgFxwKmh7Xssu3fvq4K8+BE0ohi8YtKvgvzSSrHuXA4OkAhh/Bw2zik/tSVOQB1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXmmoFxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ED3BC16AAE;
	Mon, 25 Aug 2025 04:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756096629;
	bh=ybvae2Us24QQdhHAuMB8pyUUuzHIpPAy3rGRBQp46KE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VXmmoFxUvmN/RKP8X0WxHWlcHErhqkKv1nEW0RhAykBgxI0mfX5y/4/yrzC8jx6r/
	 NGjh1mMo0BnMceW1Ijx9w10M2wwRS1IjO+ju5Vt4fB40qTApKQst4itHEpLbkdjDuc
	 6pg129cnxGr6dJ1mUWoFbdxolbiGsOw/CmfHoOc1m45iQ6SsilfwFmp6weQKN1rt7z
	 F/uybpcGCZfeMxcQAb8cQ8cdrQmn+JnHO5GTldhbK8rAPz5fEB1bgR189JZofHS9cV
	 G4d9CPDzeHJwi+IhG0SVaEdyNpud2EgYNp4ylTXfRZzcCsHlFZkijd0BpOEkcmwShm
	 djo6xk0NAsRYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCB7CA0FE7;
	Mon, 25 Aug 2025 04:37:09 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Mon, 25 Aug 2025 12:36:53 +0800
Subject: [PATCH net v3 2/3] net: stmmac: xgmac: Correct supported speed
 modes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-xgmac-minor-fixes-v3-2-c225fe4444c0@altera.com>
References: <20250825-xgmac-minor-fixes-v3-0-c225fe4444c0@altera.com>
In-Reply-To: <20250825-xgmac-minor-fixes-v3-0-c225fe4444c0@altera.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Serge Semin <fancer.lancer@gmail.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756096627; l=3721;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=v7jKKlpJKKZxKVJEECl3l+uzpfLCSrlkjiiQ+9FsT98=;
 b=1bxAqjx4gTVyMo0s/j495nV6T5gag2LNSexWze59UHl5vLoX4KlIumiId0x8JibbHqsJtRdZ5
 2jaVP0lehYnAkmbx4ZPsC1O8IjeVED7mxH1hrxVI63HkBrcp54lrKpk
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

Correct supported speed modes as per the XGMAC databook.
Commit 9cb54af214a7 ("net: stmmac: Fix IP-cores specific
MAC capabilities") removes support for 10M, 100M and
1000HD. 1000HD is not supported by XGMAC IP, but it does
support 10M and 100M FD mode for XGMAC version >= 2_20,
and it also supports 10M and 100M HD mode if the HDSEL bit
is set in the MAC_HW_FEATURE0 reg. This commit enables support
for 10M and 100M speed modes for XGMAC IP based on XGMAC
version and MAC capabilities.

Fixes: 9cb54af214a7 ("net: stmmac: Fix IP-cores specific MAC capabilities")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 13 +++++++++++--
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c  |  5 +++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 6cadf8de4fdfdb18af1a112b883b3d33a53da638..00e929bf280baec7aa8d2a75fc5ceea4a52c9979 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -49,6 +49,14 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
 	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
 }
 
+static void dwxgmac2_update_caps(struct stmmac_priv *priv)
+{
+	if (!priv->dma_cap.mbps_10_100)
+		priv->hw->link.caps &= ~(MAC_10 | MAC_100);
+	else if (!priv->dma_cap.half_duplex)
+		priv->hw->link.caps &= ~(MAC_10HD | MAC_100HD);
+}
+
 static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
 {
 	u32 tx = readl(ioaddr + XGMAC_TX_CONFIG);
@@ -1424,6 +1432,7 @@ static void dwxgmac2_set_arp_offload(struct mac_device_info *hw, bool en,
 
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
+	.update_caps = dwxgmac2_update_caps,
 	.set_mac = dwxgmac2_set_mac,
 	.rx_ipc = dwxgmac2_rx_ipc,
 	.rx_queue_enable = dwxgmac2_rx_queue_enable,
@@ -1532,8 +1541,8 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
 
 	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
-			 MAC_10000FD;
+			 MAC_10 | MAC_100 | MAC_1000FD |
+			 MAC_2500FD | MAC_5000FD | MAC_10000FD;
 	mac->link.duplex = 0;
 	mac->link.speed10 = XGMAC_CONFIG_SS_10_MII;
 	mac->link.speed100 = XGMAC_CONFIG_SS_100_MII;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 7201a38842651a865493fce0cefe757d6ae9bafa..4d6bb995d8d84cd31b8c552036a647281de06fbb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -382,8 +382,11 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 				   struct dma_features *dma_cap)
 {
+	struct stmmac_priv *priv;
 	u32 hw_cap;
 
+	priv = container_of(dma_cap, struct stmmac_priv, dma_cap);
+
 	/* MAC HW feature 0 */
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE0);
 	dma_cap->edma = (hw_cap & XGMAC_HWFEAT_EDMA) >> 31;
@@ -406,6 +409,8 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 	dma_cap->vlhash = (hw_cap & XGMAC_HWFEAT_VLHASH) >> 4;
 	dma_cap->half_duplex = (hw_cap & XGMAC_HWFEAT_HDSEL) >> 3;
 	dma_cap->mbps_1000 = (hw_cap & XGMAC_HWFEAT_GMIISEL) >> 1;
+	if (dma_cap->mbps_1000 && priv->synopsys_id >= DWXGMAC_CORE_2_20)
+		dma_cap->mbps_10_100 = 1;
 
 	/* MAC HW feature 1 */
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE1);

-- 
2.25.1



