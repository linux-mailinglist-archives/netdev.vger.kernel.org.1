Return-Path: <netdev+bounces-146464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD19D38D4
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6261F25816
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A72A19D89B;
	Wed, 20 Nov 2024 10:56:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747C848C;
	Wed, 20 Nov 2024 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100209; cv=none; b=rTXFeu0Uo5UayYup45o2qiWEO1ZesNTXANbNOQk6gLXpt8eRRAg+Ikoe1vbWkNffLu0QDO8YsBtWLJ7kP5Yj2Nze4k8/sxXKXAA/gAjff2wMlB/3yWpjqMiYyQt7oVbn04QumLApRN51SmBzzHQJvCZR1mJf29UKtaclkrrl5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100209; c=relaxed/simple;
	bh=C5493pXo1Jxga6RlwvxPNbMOCGdWhnyUfs5Uzx5mvYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdjnOqj9i25ubLUnWKZG1Etrd8Per1kVJzOAjPxui9tplyLjiDwUa9szGHToZDWyT6tZ4doXoA+oY7xp++ToQ3n4hyIKxExZt+fIdo38THW/2LzckVZD+fln/sE608MWNkqZbfSKYTTD14IMhbhrtQwEuaFd9RNhvIF1XybgOc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppX-_1732100201 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:41 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 05/21] motorcomm:yt6801: Implement the fxgmac_start function
Date: Wed, 20 Nov 2024 18:56:09 +0800
Message-Id: <20241120105625.22508-6-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the fxgmac_start function to connect phy and init phy lib, enable napi
, phy and msix irq.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 242 ++++++++++++++++++
 1 file changed, 242 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index 39b91cc26..eedf4dcb0 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -11,6 +11,8 @@
 #include "yt6801_desc.h"
 #include "yt6801_net.h"
 
+static void fxgmac_napi_enable(struct fxgmac_pdata *pdata);
+
 static int fxgmac_calc_rx_buf_size(struct fxgmac_pdata *pdata, unsigned int mtu)
 {
 	u32 rx_buf_size, max_mtu;
@@ -31,6 +33,26 @@ static int fxgmac_calc_rx_buf_size(struct fxgmac_pdata *pdata, unsigned int mtu)
 	return rx_buf_size;
 }
 
+static void fxgmac_enable_rx_tx_ints(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	enum fxgmac_int int_id;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		if (channel->tx_ring && channel->rx_ring)
+			int_id = FXGMAC_INT_DMA_CH_SR_TI_RI;
+		else if (channel->tx_ring)
+			int_id = FXGMAC_INT_DMA_CH_SR_TI;
+		else if (channel->rx_ring)
+			int_id = FXGMAC_INT_DMA_CH_SR_RI;
+		else
+			continue;
+
+		hw_ops->enable_channel_irq(channel, int_id);
+	}
+}
+
 #define FXGMAC_NAPI_ENABLE			0x1
 #define FXGMAC_NAPI_DISABLE			0x0
 static void fxgmac_napi_disable(struct fxgmac_pdata *pdata)
@@ -180,6 +202,160 @@ void fxgmac_free_rx_data(struct fxgmac_pdata *pdata)
 	}
 }
 
+static  void fxgmac_phylink_handler(struct net_device *ndev)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(ndev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	pdata->phy_link = pdata->phydev->link;
+	pdata->phy_speed = pdata->phydev->speed;
+	pdata->phy_duplex = pdata->phydev->duplex;
+
+	yt_dbg(pdata, "EPHY_CTRL:%x, link:%d, speed:%d,  duplex:%x.\n",
+	       rd32_mem(pdata, EPHY_CTRL), pdata->phy_link, pdata->phy_speed,
+	       pdata->phy_duplex);
+
+	if (pdata->phy_link) {
+		hw_ops->config_mac_speed(pdata);
+		hw_ops->enable_rx(pdata);
+		hw_ops->enable_tx(pdata);
+		netif_carrier_on(pdata->netdev);
+		if (netif_running(pdata->netdev)) {
+			netif_tx_wake_all_queues(pdata->netdev);
+			yt_dbg(pdata, "%s now is link up, mac_speed=%d.\n",
+			       netdev_name(pdata->netdev), pdata->phy_speed);
+		}
+	} else {
+		netif_carrier_off(pdata->netdev);
+		netif_tx_stop_all_queues(pdata->netdev);
+		hw_ops->disable_rx(pdata);
+		hw_ops->disable_tx(pdata);
+		yt_dbg(pdata, "%s now is link down\n",
+		       netdev_name(pdata->netdev));
+	}
+
+	phy_print_status(pdata->phydev);
+}
+
+static int fxgmac_phy_connect(struct fxgmac_pdata *pdata)
+{
+	struct phy_device *phydev = pdata->phydev;
+	int ret;
+
+	ret = phy_connect_direct(pdata->netdev, phydev, fxgmac_phylink_handler,
+				 PHY_INTERFACE_MODE_RGMII);
+	if (ret)
+		return ret;
+
+	phy_attached_info(phydev);
+	return 0;
+}
+
+static void fxgmac_enable_msix_irqs(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	for (u32 intid = 0; intid < MSIX_TBL_MAX_NUM; intid++)
+		hw_ops->enable_msix_one_irq(pdata, intid);
+}
+
+int fxgmac_phy_irq_enable(struct fxgmac_pdata *pdata, bool clear_phy_interrupt)
+{
+	struct phy_device *phydev = pdata->phydev;
+
+	if (clear_phy_interrupt &&
+	    phy_read(phydev, PHY_INT_STATUS) < 0)
+		return -ETIMEDOUT;
+
+	return phy_modify(phydev, PHY_INT_MASK,
+				     PHY_INT_MASK_LINK_UP |
+					     PHY_INT_MASK_LINK_DOWN,
+				     PHY_INT_MASK_LINK_UP |
+					     PHY_INT_MASK_LINK_DOWN);
+}
+
+int fxgmac_start(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	u32 val;
+	int ret;
+
+	if (pdata->dev_state != FXGMAC_DEV_OPEN &&
+	    pdata->dev_state != FXGMAC_DEV_STOP &&
+	    pdata->dev_state != FXGMAC_DEV_RESUME) {
+		yt_dbg(pdata, " dev_state err:%x\n", pdata->dev_state);
+		return 0;
+	}
+
+	if (pdata->dev_state != FXGMAC_DEV_STOP) {
+		hw_ops->reset_phy(pdata);
+		hw_ops->release_phy(pdata);
+		yt_dbg(pdata, "reset phy.\n");
+	}
+
+	if (pdata->dev_state == FXGMAC_DEV_OPEN) {
+		ret = fxgmac_phy_connect(pdata);
+		if (ret < 0)
+			return ret;
+
+		yt_dbg(pdata, "fxgmac_phy_connect.\n");
+	}
+
+	phy_init_hw(pdata->phydev);
+	phy_resume(pdata->phydev);
+
+	hw_ops->pcie_init(pdata);
+	if (test_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate)) {
+		yt_err(pdata,
+		       "fxgmac powerstate is %lu when config power up.\n",
+		       pdata->powerstate);
+	}
+
+	hw_ops->config_power_up(pdata);
+	hw_ops->dismiss_all_int(pdata);
+	ret = hw_ops->init(pdata);
+	if (ret < 0) {
+		yt_err(pdata, "fxgmac hw init error.\n");
+		return ret;
+	}
+
+	fxgmac_napi_enable(pdata);
+	ret = fxgmac_request_irqs(pdata);
+	if (ret < 0)
+		return ret;
+
+	/* Config interrupt to level signal */
+	val = rd32_mac(pdata, DMA_MR);
+	fxgmac_set_bits(&val, DMA_MR_INTM_POS, DMA_MR_INTM_LEN, 2);
+	fxgmac_set_bits(&val, DMA_MR_QUREAD_POS, DMA_MR_QUREAD_LEN, 1);
+	wr32_mac(pdata, val, DMA_MR);
+
+	hw_ops->enable_mgm_irq(pdata);
+	hw_ops->set_interrupt_moderation(pdata);
+
+	if (pdata->per_channel_irq) {
+		fxgmac_enable_msix_irqs(pdata);
+		ret = fxgmac_phy_irq_enable(pdata, true);
+		if (ret < 0)
+			goto dis_napi;
+	}
+
+	fxgmac_enable_rx_tx_ints(pdata);
+	phy_speed_up(pdata->phydev);
+	genphy_soft_reset(pdata->phydev);
+
+	pdata->dev_state = FXGMAC_DEV_START;
+	phy_start(pdata->phydev);
+
+	return 0;
+
+dis_napi:
+	fxgmac_napi_disable(pdata);
+	hw_ops->exit(pdata);
+	yt_err(pdata, "%s irq err.\n", __func__);
+	return ret;
+}
+
 static void fxgmac_disable_msix_irqs(struct fxgmac_pdata *pdata)
 {
 	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
@@ -540,4 +716,70 @@ static const struct net_device_ops fxgmac_netdev_ops = {
 const struct net_device_ops *fxgmac_get_netdev_ops(void)
 {
 	return &fxgmac_netdev_ops;
+
+static void fxgmac_napi_enable(struct fxgmac_pdata *pdata)
+{
+	u32 i, *flags = &pdata->int_flags;
+	struct fxgmac_channel *channel;
+	u32 misc_napi, tx, rx;
+
+	misc_napi = FIELD_GET(BIT(FXGMAC_FLAG_MISC_NAPI_POS), *flags);
+	tx = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_TX_NAPI_POS,
+			     FXGMAC_FLAG_TX_NAPI_LEN);
+	rx = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_RX_NAPI_POS,
+			     FXGMAC_FLAG_RX_NAPI_LEN);
+
+	if (!pdata->per_channel_irq) {
+		i = FIELD_GET(BIT(FXGMAC_FLAG_LEGACY_NAPI_POS), *flags);
+		if (i)
+			return;
+
+		netif_napi_add_weight(pdata->netdev, &pdata->napi,
+				      fxgmac_all_poll,
+				      NAPI_POLL_WEIGHT);
+
+		napi_enable(&pdata->napi);
+		fxgmac_set_bits(flags, FXGMAC_FLAG_LEGACY_NAPI_POS,
+				FXGMAC_FLAG_LEGACY_NAPI_LEN,
+				FXGMAC_NAPI_ENABLE);
+		return;
+	}
+
+	channel = pdata->channel_head;
+
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!FXGMAC_GET_BITS(rx, i, FXGMAC_FLAG_PER_RX_NAPI_LEN)) {
+			netif_napi_add_weight(pdata->netdev,
+					      &channel->napi_rx,
+					      fxgmac_one_poll_rx,
+					      NAPI_POLL_WEIGHT);
+
+			napi_enable(&channel->napi_rx);
+			fxgmac_set_bits(flags, FXGMAC_FLAG_RX_NAPI_POS + i,
+					FXGMAC_FLAG_PER_RX_NAPI_LEN,
+					FXGMAC_NAPI_ENABLE);
+		}
+
+		if (FXGMAC_IS_CHANNEL_WITH_TX_IRQ(i) && !tx) {
+			netif_napi_add_weight(pdata->netdev, &channel->napi_tx,
+					      fxgmac_one_poll_tx,
+					      NAPI_POLL_WEIGHT);
+			napi_enable(&channel->napi_tx);
+			fxgmac_set_bits(flags, FXGMAC_FLAG_TX_NAPI_POS,
+					FXGMAC_FLAG_TX_NAPI_LEN,
+					FXGMAC_NAPI_ENABLE);
+		}
+		if (netif_msg_drv(pdata))
+			yt_dbg(pdata, "msix ch%d napi enabled done.\n", i);
+	}
+
+	/* Misc */
+	if (!misc_napi) {
+		netif_napi_add_weight(pdata->netdev, &pdata->napi_misc,
+				      fxgmac_misc_poll, NAPI_POLL_WEIGHT);
+
+		napi_enable(&pdata->napi_misc);
+		fxgmac_set_bits(flags, FXGMAC_FLAG_MISC_NAPI_POS,
+				FXGMAC_FLAG_MISC_NAPI_LEN, FXGMAC_NAPI_ENABLE);
+	}
 }
-- 
2.34.1


