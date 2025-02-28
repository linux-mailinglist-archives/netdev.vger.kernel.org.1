Return-Path: <netdev+bounces-170645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13554A496DE
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4912316B221
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D674525DAEB;
	Fri, 28 Feb 2025 10:16:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D225DAE0;
	Fri, 28 Feb 2025 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737814; cv=none; b=aipi5BhKJiRHNIHxFUTHO5oWr1kd99ISlBqVCEsfCyj9dEjI0rCNpCPjrtLtq8mAwoXPBTtjCCHO3ydV88yojS4lLCLjMf8KeN1uQJBr7e4IkNqqzu/Qlpntz/1akL0yx7vMzC3zKnh5W1EgVcfz76I0edSS1XV5vKYhWDmq6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737814; c=relaxed/simple;
	bh=RKmWoPNOf1kAlKhPJ+SYwGXfq2TmfaPQrjzaw1Hbt60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E78fMj+7Kpoo5wnNrMwDNm2iCA4BPPWpedeeTVPbPTK0SBwwVX1TeLbtOHDYIipCb8NUEZcUHld7Irj6DOWh5rKnsLiXOXCwAxM97XtK3AyeWZVuEDit6H+8ErB/FeOkIKLm5RmQUlmCpIJKudvNuCH/7/OoVPU3ydyWqSdYkzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn1C7_1740736834 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:34 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank <Frank.Sae@motor-comm.com>,
	netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v3 04/14] motorcomm:yt6801: Implement the fxgmac_init function
Date: Fri, 28 Feb 2025 18:01:11 +0800
Message-Id: <20250228100020.3944-5-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the fxgmac_init to init hardware settings, including setting
 function pointers, default configuration data, irq, base_addr, MAC
 address, DMA mask, device operations and device features.
Implement the fxgmac_read_mac_addr function to read mac address form
  efuse.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 423 ++++++++++++++++++
 1 file changed, 423 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index 7d557f6b0..350510174 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -302,6 +302,12 @@ static void fxgmac_disable_rx(struct fxgmac_pdata *priv)
 		FXGMAC_DMA_IO_WR_BITS(channel, DMA_CH_RCR, SR, 0);
 }
 
+static void fxgmac_default_speed_duplex_config(struct fxgmac_pdata *priv)
+{
+	priv->mac_duplex = DUPLEX_FULL;
+	priv->mac_speed = SPEED_1000;
+}
+
 /**
  * fxgmac_set_oob_wol - disable or enable oob wol crtl function
  * @priv: driver private struct
@@ -322,12 +328,30 @@ static void fxgmac_pre_powerdown(struct fxgmac_pdata *priv)
 	fsleep(2000);
 }
 
+static void fxgmac_restore_nonstick_reg(struct fxgmac_pdata *priv)
+{
+	for (u32 i = GLOBAL_CTRL0; i < MSI_PBA; i += 4)
+		FXGMAC_IO_WR(priv, i,
+			     priv->reg_nonstick[(i - GLOBAL_CTRL0) >> 2]);
+}
+
 static void fxgmac_phy_release(struct fxgmac_pdata *priv)
 {
 	FXGMAC_IO_WR_BITS(priv, EPHY_CTRL, RESET, 1);
 	fsleep(100);
 }
 
+static void fxgmac_hw_exit(struct fxgmac_pdata *priv)
+{
+	/* Reset CHIP, it will reset trigger circuit and reload efuse patch */
+	FXGMAC_IO_WR_BITS(priv, SYS_RESET, RESET, 1);
+	fsleep(9000);
+
+	fxgmac_phy_release(priv);
+
+	/* Reset will clear nonstick registers. */
+	fxgmac_restore_nonstick_reg(priv);
+}
 void fxgmac_phy_reset(struct fxgmac_pdata *priv)
 {
 	FXGMAC_IO_WR_BITS(priv, EPHY_CTRL, RESET, 0);
@@ -411,6 +435,405 @@ int fxgmac_net_powerdown(struct fxgmac_pdata *priv)
 	return 0;
 }
 
+#define EFUSE_FISRT_UPDATE_ADDR				255
+#define EFUSE_SECOND_UPDATE_ADDR			209
+#define EFUSE_MAX_ENTRY					39
+#define EFUSE_PATCH_ADDR_START				0
+#define EFUSE_PATCH_DATA_START				2
+#define EFUSE_PATCH_SIZE				6
+#define EFUSE_REGION_A_B_LENGTH				18
+
+static bool fxgmac_efuse_read_data(struct fxgmac_pdata *priv, u32 offset,
+				   u8 *value)
+{
+	u32 val = 0, wait = 1000;
+	bool ret = false;
+
+	FXGMAC_SET_BITS(val, EFUSE_OP, ADDR, offset);
+	FXGMAC_SET_BITS(val, EFUSE_OP, START, 1);
+	FXGMAC_SET_BITS(val, EFUSE_OP, MODE, EFUSE_OP_MODE_ROW_READ);
+	FXGMAC_IO_WR(priv, EFUSE_OP_CTRL_0, val);
+
+	while (wait--) {
+		fsleep(20);
+		val = FXGMAC_IO_RD(priv, EFUSE_OP_CTRL_1);
+		if (FXGMAC_GET_BITS(val, EFUSE_OP, DONE)) {
+			ret = true;
+			break;
+		}
+	}
+
+	if (!ret) {
+		yt_err(priv, "Fail to reading efuse Byte%d\n", offset);
+		return ret;
+	}
+
+	if (value)
+		*value = FXGMAC_GET_BITS(val, EFUSE_OP, RD_DATA) & 0xff;
+
+	return ret;
+}
+
+static bool fxgmac_efuse_read_index_patch(struct fxgmac_pdata *priv, u8 index,
+					  u32 *offset, u32 *value)
+{
+	u8 tmp[EFUSE_PATCH_SIZE - EFUSE_PATCH_DATA_START];
+	u32 addr, i;
+	bool ret;
+
+	if (index >= EFUSE_MAX_ENTRY) {
+		yt_err(priv, "Reading efuse out of range, index %d\n", index);
+		return false;
+	}
+
+	for (i = EFUSE_PATCH_ADDR_START; i < EFUSE_PATCH_DATA_START; i++) {
+		addr = EFUSE_REGION_A_B_LENGTH + index * EFUSE_PATCH_SIZE + i;
+		ret = fxgmac_efuse_read_data(priv, addr,
+					     tmp + i - EFUSE_PATCH_ADDR_START);
+		if (!ret) {
+			yt_err(priv, "Fail to reading efuse Byte%d\n", addr);
+			return ret;
+		}
+	}
+	/* tmp[0] is low 8bit date, tmp[1] is high 8bit date */
+	if (offset)
+		*offset = tmp[0] | (tmp[1] << 8);
+
+	for (i = EFUSE_PATCH_DATA_START; i < EFUSE_PATCH_SIZE; i++) {
+		addr = EFUSE_REGION_A_B_LENGTH + index * EFUSE_PATCH_SIZE + i;
+		ret = fxgmac_efuse_read_data(priv, addr,
+					     tmp + i - EFUSE_PATCH_DATA_START);
+		if (!ret) {
+			yt_err(priv, "Fail to reading efuse Byte%d\n", addr);
+			return ret;
+		}
+	}
+	/* tmp[0] is low 8bit date, tmp[1] is low 8bit date
+	 * ...  tmp[3] is highest 8bit date
+	 */
+	if (value)
+		*value = tmp[0] | (tmp[1] << 8) | (tmp[2] << 16) |
+			 (tmp[3] << 24);
+
+	return ret;
+}
+
+static bool fxgmac_efuse_read_mac_subsys(struct fxgmac_pdata *priv,
+					 u8 *mac_addr, u32 *subsys, u32 *revid)
+{
+	u32 machr = 0, maclr = 0, offset = 0, val = 0;
+
+	for (u8 index = 0; index < EFUSE_MAX_ENTRY; index++) {
+		if (!fxgmac_efuse_read_index_patch(priv, index, &offset, &val))
+			return false;
+
+		if (offset == 0x00)
+			break; /* Reach the blank. */
+		if (offset == MACA0LR_FROM_EFUSE)
+			maclr = val;
+		if (offset == MACA0HR_FROM_EFUSE)
+			machr = val;
+		if (offset == PCI_REVISION_ID && revid)
+			*revid = val;
+		if (offset == PCI_SUBSYSTEM_VENDOR_ID && subsys)
+			*subsys = val;
+	}
+
+	if (mac_addr) {
+		mac_addr[5] = (u8)(maclr & 0xFF);
+		mac_addr[4] = (u8)((maclr >> 8) & 0xFF);
+		mac_addr[3] = (u8)((maclr >> 16) & 0xFF);
+		mac_addr[2] = (u8)((maclr >> 24) & 0xFF);
+		mac_addr[1] = (u8)(machr & 0xFF);
+		mac_addr[0] = (u8)((machr >> 8) & 0xFF);
+	}
+
+	return true;
+}
+
+static int fxgmac_read_mac_addr(struct fxgmac_pdata *priv)
+{
+	u8 default_addr[ETH_ALEN] = { 0, 0x55, 0x7b, 0xb5, 0x7d, 0xf7 };
+	struct net_device *netdev = priv->netdev;
+	int ret;
+
+	/* If efuse have mac addr, use it. if not, use static mac address. */
+	ret = fxgmac_efuse_read_mac_subsys(priv, priv->mac_addr, NULL, NULL);
+	if (!ret)
+		return -1;
+
+	if (is_zero_ether_addr(priv->mac_addr))
+		/* Use a static mac address for test */
+		memcpy(priv->mac_addr, default_addr, netdev->addr_len);
+
+	return 0;
+}
+
+static void fxgmac_default_config(struct fxgmac_pdata *priv)
+{
+	priv->sysclk_rate = 125000000; /* System clock is 125 MHz */
+	priv->tx_threshold = MTL_TX_THRESHOLD_128;
+	priv->rx_threshold = MTL_RX_THRESHOLD_128;
+	priv->tx_osp_mode = DMA_OSP_ENABLE;
+	priv->tx_sf_mode = MTL_TSF_ENABLE;
+	priv->rx_sf_mode = MTL_RSF_ENABLE;
+	priv->pblx8 = DMA_PBL_X8_ENABLE;
+	priv->tx_pbl = DMA_PBL_16;
+	priv->rx_pbl = DMA_PBL_4;
+	priv->tx_pause = 1;	/* Enable tx pause */
+	priv->rx_pause = 1;	/* Enable rx pause */
+
+	fxgmac_default_speed_duplex_config(priv);
+}
+
+static void fxgmac_get_all_hw_features(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_hw_features *hw_feat = &priv->hw_feat;
+	unsigned int mac_hfr0, mac_hfr1, mac_hfr2, mac_hfr3;
+
+	mac_hfr0 = FXGMAC_MAC_IO_RD(priv, MAC_HWF0R);
+	mac_hfr1 = FXGMAC_MAC_IO_RD(priv, MAC_HWF1R);
+	mac_hfr2 = FXGMAC_MAC_IO_RD(priv, MAC_HWF2R);
+	mac_hfr3 = FXGMAC_MAC_IO_RD(priv, MAC_HWF3R);
+	memset(hw_feat, 0, sizeof(*hw_feat));
+	hw_feat->version = FXGMAC_MAC_IO_RD(priv, MAC_VR);
+
+	/* Hardware feature register 0 */
+	hw_feat->phyifsel = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, ACTPHYIFSEL);
+	hw_feat->vlhash = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, VLHASH);
+	hw_feat->sma = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, SMASEL);
+	hw_feat->rwk = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, RWKSEL);
+	hw_feat->mgk = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, MGKSEL);
+	hw_feat->mmc = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, MMCSEL);
+	hw_feat->aoe = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, ARPOFFSEL);
+	hw_feat->ts = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, TSSEL);
+	hw_feat->eee = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, EEESEL);
+	hw_feat->tx_coe = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, TXCOESEL);
+	hw_feat->rx_coe = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, RXCOESEL);
+	hw_feat->addn_mac = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, ADDMACADRSEL);
+	hw_feat->ts_src = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, TSSTSSEL);
+	hw_feat->sa_vlan_ins = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R, SAVLANINS);
+
+	/* Hardware feature register 1 */
+	hw_feat->rx_fifo_size =
+		FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R, RXFIFOSIZE);
+	hw_feat->tx_fifo_size =
+		FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R, TXFIFOSIZE);
+	hw_feat->adv_ts_hi = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R, ADVTHWORD);
+	hw_feat->dma_width = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R, ADDR64);
+	hw_feat->dcb = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R, DCBEN);
+	hw_feat->sph = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R, SPHEN);
+	hw_feat->tso = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R, TSOEN);
+	hw_feat->dma_debug = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R, DBGMEMA);
+	hw_feat->avsel = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R, RAVSEL);
+	hw_feat->ravsel = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R, RAVSEL);
+	hw_feat->hash_table_size =
+		FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R, HASHTBLSZ);
+	hw_feat->l3l4_filter_num =
+		FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R, L3L4FNUM);
+	hw_feat->tx_q_cnt = FXGMAC_GET_BITS(mac_hfr2, MAC_HWF2R, TXQCNT);
+	hw_feat->rx_ch_cnt = FXGMAC_GET_BITS(mac_hfr2, MAC_HWF2R, RXCHCNT);
+	hw_feat->tx_ch_cnt = FXGMAC_GET_BITS(mac_hfr2, MAC_HWF2R, TXCHCNT);
+	hw_feat->pps_out_num = FXGMAC_GET_BITS(mac_hfr2, MAC_HWF2R, PPSOUTNUM);
+	hw_feat->aux_snap_num =
+		FXGMAC_GET_BITS(mac_hfr2, MAC_HWF2R, AUXSNAPNUM);
+
+	/* Translate the Hash Table size into actual number */
+	switch (hw_feat->hash_table_size) {
+	case 0:
+		break;
+	case 1:
+		hw_feat->hash_table_size = 64;
+		break;
+	case 2:
+		hw_feat->hash_table_size = 128;
+		break;
+	case 3:
+		hw_feat->hash_table_size = 256;
+		break;
+	}
+
+	/* Translate the address width setting into actual number */
+	switch (hw_feat->dma_width) {
+	case 0:
+		hw_feat->dma_width = 32;
+		break;
+	case 1:
+		hw_feat->dma_width = 40;
+		break;
+	case 2:
+		hw_feat->dma_width = 48;
+		break;
+	default:
+		hw_feat->dma_width = 32;
+	}
+
+	/* The Queue, Channel are zero based so increment them
+	 * to get the actual number
+	 */
+	hw_feat->tx_q_cnt++;
+	hw_feat->rx_ch_cnt++;
+	hw_feat->tx_ch_cnt++;
+
+	/* HW implement 1 rx fifo, 4 dma channel.  but from software
+	 * we see 4 logical queues. hardcode to 4 queues.
+	 */
+	hw_feat->rx_q_cnt = 4;
+
+	hw_feat->hwfr3 = mac_hfr3;
+}
+
+static unsigned int fxgmac_usec_to_riwt(struct fxgmac_pdata *priv,
+					unsigned int usec)
+{
+	/* Convert the input usec value to the watchdog timer value. Each
+	 * watchdog timer value is equivalent to 256 clock cycles.
+	 * Calculate the required value as:
+	 *  ( usec * ( system_clock_mhz / 10^6) / 256
+	 */
+	return (usec * (priv->sysclk_rate / 1000000)) / 256;
+}
+
+static void fxgmac_save_nonstick_reg(struct fxgmac_pdata *priv)
+{
+	for (u32 i = GLOBAL_CTRL0; i < MSI_PBA; i += 4) {
+		priv->reg_nonstick[(i - GLOBAL_CTRL0) >> 2] =
+			FXGMAC_IO_RD(priv, i);
+	}
+}
+
+static int fxgmac_init(struct fxgmac_pdata *priv, bool save_private_reg)
+{
+	struct net_device *netdev = priv->netdev;
+	int ret;
+
+	fxgmac_default_config(priv);	/* Set default configuration data */
+	netdev->irq = priv->dev_irq;
+	netdev->base_addr = (unsigned long)priv->hw_addr;
+
+	ret = fxgmac_read_mac_addr(priv);
+	if (ret) {
+		yt_err(priv, "fxgmac_read_mac_addr err:%d\n", ret);
+		return ret;
+	}
+	eth_hw_addr_set(netdev, priv->mac_addr);
+
+	if (save_private_reg)
+		fxgmac_save_nonstick_reg(priv);
+
+	fxgmac_hw_exit(priv);	/* Reset here to get hw features correctly */
+	fxgmac_get_all_hw_features(priv);
+
+	/* Set the DMA mask */
+	ret = dma_set_mask_and_coherent(priv->dev,
+					DMA_BIT_MASK(priv->hw_feat.dma_width));
+	if (ret) {
+		ret = dma_set_mask_and_coherent(priv->dev, DMA_BIT_MASK(32));
+		if (ret) {
+			yt_err(priv, "No usable DMA configuration, aborting\n");
+			return ret;
+		}
+	}
+
+	if (FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, LEGACY)) {
+		/* We should disable msi and msix here when we use legacy
+		 * interrupt,for two reasons:
+		 * 1. Exit will restore msi and msix config regisiter,
+		 * that may enable them.
+		 * 2. When the driver that uses the msix interrupt by default
+		 * is compiled into the OS, uninstall the driver through rmmod,
+		 * and then install the driver that uses the legacy interrupt,
+		 * at which time the msix enable will be turned on again by
+		 * default after waking up from S4 on some
+		 * platform. such as UOS platform.
+		 */
+		pci_disable_msi(to_pci_dev(priv->dev));
+		pci_disable_msix(to_pci_dev(priv->dev));
+	}
+
+	BUILD_BUG_ON_NOT_POWER_OF_2(FXGMAC_TX_DESC_CNT);
+	priv->tx_desc_count = FXGMAC_TX_DESC_CNT;
+	BUILD_BUG_ON_NOT_POWER_OF_2(FXGMAC_RX_DESC_CNT);
+	priv->rx_desc_count = FXGMAC_RX_DESC_CNT;
+
+	ret = netif_set_real_num_tx_queues(netdev, FXGMAC_TX_1_Q);
+	if (ret) {
+		yt_err(priv, "error setting real tx queue count\n");
+		return ret;
+	}
+
+	priv->rx_ring_count = min_t(unsigned int,
+				    netif_get_num_default_rss_queues(),
+				    priv->hw_feat.rx_ch_cnt);
+	priv->rx_ring_count = min_t(unsigned int, priv->rx_ring_count,
+				    priv->hw_feat.rx_q_cnt);
+	priv->rx_q_count = priv->rx_ring_count;
+	ret = netif_set_real_num_rx_queues(netdev, priv->rx_q_count);
+	if (ret) {
+		yt_err(priv, "error setting real rx queue count\n");
+		return ret;
+	}
+
+	priv->channel_count =
+		max_t(unsigned int, FXGMAC_TX_1_RING, priv->rx_ring_count);
+
+	netdev->min_mtu = ETH_MIN_MTU;
+	netdev->max_mtu =
+		FXGMAC_JUMBO_PACKET_MTU + (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
+
+	netdev->netdev_ops = fxgmac_get_netdev_ops();/* Set device operations */
+
+	/* Set device features */
+	if (priv->hw_feat.tso) {
+		netdev->hw_features = NETIF_F_TSO;
+		netdev->hw_features |= NETIF_F_TSO6;
+		netdev->hw_features |= NETIF_F_SG;
+		netdev->hw_features |= NETIF_F_IP_CSUM;
+		netdev->hw_features |= NETIF_F_IPV6_CSUM;
+	} else if (priv->hw_feat.tx_coe) {
+		netdev->hw_features = NETIF_F_IP_CSUM;
+		netdev->hw_features |= NETIF_F_IPV6_CSUM;
+	}
+
+	if (priv->hw_feat.rx_coe) {
+		netdev->hw_features |= NETIF_F_RXCSUM;
+		netdev->hw_features |= NETIF_F_GRO;
+	}
+
+	netdev->hw_features |= NETIF_F_RXHASH;
+	netdev->vlan_features |= netdev->hw_features;
+	netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
+
+	if (priv->hw_feat.sa_vlan_ins)
+		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_TX;
+
+	netdev->features |= netdev->hw_features;
+	priv->netdev_features = netdev->features;
+
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->watchdog_timeo = msecs_to_jiffies(5000);
+
+#define NIC_MAX_TCP_OFFLOAD_SIZE 7300
+	netif_set_tso_max_size(netdev, NIC_MAX_TCP_OFFLOAD_SIZE);
+
+/* Default coalescing parameters */
+#define FXGMAC_INIT_DMA_TX_USECS INT_MOD_200_US
+#define FXGMAC_INIT_DMA_TX_FRAMES 25
+#define FXGMAC_INIT_DMA_RX_USECS INT_MOD_200_US
+#define FXGMAC_INIT_DMA_RX_FRAMES 25
+
+	/* Tx coalesce parameters initialization */
+	priv->tx_usecs = FXGMAC_INIT_DMA_TX_USECS;
+	priv->tx_frames = FXGMAC_INIT_DMA_TX_FRAMES;
+
+	/* Rx coalesce parameters initialization */
+	priv->rx_riwt = fxgmac_usec_to_riwt(priv, FXGMAC_INIT_DMA_RX_USECS);
+	priv->rx_usecs = FXGMAC_INIT_DMA_RX_USECS;
+	priv->rx_frames = FXGMAC_INIT_DMA_RX_FRAMES;
+
+	return 0;
+}
+
 #ifdef CONFIG_PCI_MSI
 static void fxgmac_init_interrupt_scheme(struct fxgmac_pdata *priv)
 {
-- 
2.34.1


