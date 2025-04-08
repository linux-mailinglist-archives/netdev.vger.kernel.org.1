Return-Path: <netdev+bounces-180142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D00A7FBA1
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCD53B1C20
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D147267F69;
	Tue,  8 Apr 2025 10:14:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8E265613;
	Tue,  8 Apr 2025 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107282; cv=none; b=qXljcyY9KtQzii5nCv7WaiYLtHsh4WfG/g+DUgwhaZKEyFDmLQBRTa82lBc+v/fnIWSHtd36vNTSXMylm1Uwl3pZe9Qy7q1mzDZfc1+iIMPeJXniWOrb2BgbmqNNuNjIJ+CLkebvipNgLY/qSmAAEO+cpIB40LpjuMY8wE+NZoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107282; c=relaxed/simple;
	bh=fmWGpCETeN53oJoff+aufir42TIpg3qtHXjpXolBJW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABa/SXIKXifROV+0cP6MNWb1n9hnJ/Iz0E4rrPX2eEQ6kA8yaN0l5WNt3pB998wTVVyATTM5MkF84rvRK7ijvl49Bm429LkJVZtL2AcsxZNNAwr2eFJDTC4yH76xe6heJ+XtV/7+xP8oNYnhR5UFUIjL0cC7OjoRUS8vy4lGn/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cGww7MW_1744104533 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 17:28:54 +0800
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
	"andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>,
	lee@trager.us,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	geert+renesas@glider.be,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v4 04/14] yt6801: Implement the fxgmac_init function
Date: Tue, 08 Apr 2025 18:14:32 +0800
Message-Id: <20250408092835.3952-5-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
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
 .../ethernet/motorcomm/yt6801/yt6801_main.c   | 440 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_type.h   | 177 +++++++
 2 files changed, 617 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
index 8baabeb53..5294ca638 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
@@ -293,6 +293,12 @@ static void fxgmac_disable_rx(struct fxgmac_pdata *priv)
 		fxgmac_dma_wr_bits(channel, DMA_CH_RCR, DMA_CH_RCR_SR, 0);
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
@@ -320,10 +326,49 @@ static void fxgmac_pre_powerdown(struct fxgmac_pdata *priv)
 	fxgmac_set_oob_wol(priv, 1);
 	fsleep(2000);
 }
+
+static void fxgmac_restore_nonstick_reg(struct fxgmac_pdata *priv)
+{
+	for (u32 i = GLOBAL_CTRL0; i < MSI_PBA; i += 4)
+		fxgmac_io_wr(priv, i,
+			     priv->reg_nonstick[(i - GLOBAL_CTRL0) >> 2]);
+}
+
 static void fxgmac_phy_release(struct fxgmac_pdata *priv)
 {
 	fxgmac_io_wr_bits(priv, EPHY_CTRL, EPHY_CTRL_RESET, 1);
 	fsleep(100);
+}
+
+static void fxgmac_hw_exit(struct fxgmac_pdata *priv)
+{
+	/* Reset CHIP, it will reset trigger circuit and reload efuse patch */
+	fxgmac_io_wr_bits(priv, SYS_RESET, SYS_RESET_RESET, 1);
+	fsleep(9000);
+
+	fxgmac_phy_release(priv);
+
+	/* Reset will clear nonstick registers. */
+	fxgmac_restore_nonstick_reg(priv);
+}
+
+static void fxgmac_pcie_init(struct fxgmac_pdata *priv)
+{
+	/* snoopy + non-snoopy */
+	fxgmac_io_wr_bits(priv, LTR_IDLE_ENTER, LTR_IDLE_ENTER_REQUIRE, 1);
+	fxgmac_io_wr_bits(priv, LTR_IDLE_ENTER, LTR_IDLE_ENTER_SCALE,
+			  LTR_IDLE_ENTER_SCALE_1024_NS);
+	fxgmac_io_wr_bits(priv, LTR_IDLE_ENTER, LTR_IDLE_ENTER_ENTER,
+			  LTR_IDLE_ENTER_900_US);
+
+	/* snoopy + non-snoopy */
+	fxgmac_io_wr_bits(priv, LTR_IDLE_EXIT, LTR_IDLE_EXIT_REQUIRE, 1);
+	fxgmac_io_wr_bits(priv, LTR_IDLE_EXIT, LTR_IDLE_EXIT_SCALE, 2);
+	fxgmac_io_wr_bits(priv, LTR_IDLE_EXIT, LTR_IDLE_EXIT_EXIT,
+			  LTR_IDLE_EXIT_171_US);
+
+	fxgmac_io_wr_bits(priv, PCIE_SERDES_PLL, PCIE_SERDES_PLL_AUTOOFF, 1);
+}
 
 static void fxgmac_phy_reset(struct fxgmac_pdata *priv)
 {
@@ -407,6 +452,401 @@ static int fxgmac_net_powerdown(struct fxgmac_pdata *priv)
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
+	val |= FIELD_PREP(EFUSE_OP_ADDR, offset);
+	val |= EFUSE_OP_START;
+	val |= FIELD_PREP(EFUSE_OP_MODE, EFUSE_OP_MODE_ROW_READ);
+	fxgmac_io_wr(priv, EFUSE_OP_CTRL_0, val);
+
+	while (wait--) {
+		fsleep(20);
+		val = fxgmac_io_rd(priv, EFUSE_OP_CTRL_1);
+		if (FIELD_GET(EFUSE_OP_DONE, val)) {
+			ret = true;
+			break;
+		}
+	}
+
+	if (!ret) {
+		dev_err(priv->dev, "Reading efuse Byte:%d failed\n", offset);
+		return ret;
+	}
+
+	if (value)
+		*value = FIELD_GET(EFUSE_OP_RD_DATA, val) & 0xff;
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
+		dev_err(priv->dev, "Reading efuse out of range, index %d\n",
+			index);
+		return false;
+	}
+
+	for (i = EFUSE_PATCH_ADDR_START; i < EFUSE_PATCH_DATA_START; i++) {
+		addr = EFUSE_REGION_A_B_LENGTH + index * EFUSE_PATCH_SIZE + i;
+		ret = fxgmac_efuse_read_data(priv, addr,
+					     tmp + i - EFUSE_PATCH_ADDR_START);
+		if (!ret) {
+			dev_err(priv->dev, "Reading efuse Byte:%d failed\n",
+				addr);
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
+			dev_err(priv->dev, "Reading efuse Byte:%d failed\n",
+				addr);
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
+	struct net_device *ndev = priv->ndev;
+	int ret;
+
+	/* If efuse have mac addr, use it. if not, use static mac address. */
+	ret = fxgmac_efuse_read_mac_subsys(priv, priv->mac_addr, NULL, NULL);
+	if (!ret)
+		return -1;
+
+	if (is_zero_ether_addr(priv->mac_addr))
+		/* Use a static mac address for test */
+		memcpy(priv->mac_addr, default_addr, ndev->addr_len);
+
+	return 0;
+}
+
+static void fxgmac_default_config(struct fxgmac_pdata *priv)
+{
+	priv->sysclk_rate = 125000000; /* System clock is 125 MHz */
+	priv->tx_threshold = MTL_Q_TQOMR_TTC_THRESHOLD_128;
+	priv->rx_threshold = MTL_Q_RQOMR_RTC_THRESHOLD_128;
+	priv->tx_osp_mode =  1;	/* Enable DMA OSP */
+	priv->tx_sf_mode = 1;	/* Enable MTL TSF */
+	priv->rx_sf_mode = 1;	/* Enable MTL RSF */
+	priv->pblx8 = 1;	/* Enable DMA PBL X8 */
+	priv->tx_pause = 1;	/* Enable tx pause */
+	priv->rx_pause = 1;	/* Enable rx pause */
+	priv->tx_pbl = DMA_CH_PBL_16;
+	priv->rx_pbl = DMA_CH_PBL_4;
+
+	fxgmac_default_speed_duplex_config(priv);
+}
+
+static void fxgmac_get_all_hw_features(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_hw_features *hw_feat = &priv->hw_feat;
+	unsigned int mac_hfr0, mac_hfr1, mac_hfr2, mac_hfr3;
+
+	mac_hfr0 = fxgmac_io_rd(priv, MAC_HWF0R);
+	mac_hfr1 = fxgmac_io_rd(priv, MAC_HWF1R);
+	mac_hfr2 = fxgmac_io_rd(priv, MAC_HWF2R);
+	mac_hfr3 = fxgmac_io_rd(priv, MAC_HWF3R);
+	memset(hw_feat, 0, sizeof(*hw_feat));
+	hw_feat->version = fxgmac_io_rd(priv, MAC_VR);
+
+	/* Hardware feature register 0 */
+	hw_feat->phyifsel = FIELD_GET(MAC_HWF0R_ACTPHYIFSEL, mac_hfr0);
+	hw_feat->vlhash = FIELD_GET(MAC_HWF0R_VLHASH, mac_hfr0);
+	hw_feat->sma = FIELD_GET(MAC_HWF0R_SMASEL, mac_hfr0);
+	hw_feat->rwk = FIELD_GET(MAC_HWF0R_RWKSEL, mac_hfr0);
+	hw_feat->mgk = FIELD_GET(MAC_HWF0R_MGKSEL, mac_hfr0);
+	hw_feat->mmc = FIELD_GET(MAC_HWF0R_MMCSEL, mac_hfr0);
+	hw_feat->aoe = FIELD_GET(MAC_HWF0R_ARPOFFSEL, mac_hfr0);
+	hw_feat->ts = FIELD_GET(MAC_HWF0R_TSSEL, mac_hfr0);
+	hw_feat->eee = FIELD_GET(MAC_HWF0R_EEESEL, mac_hfr0);
+	hw_feat->tx_coe = FIELD_GET(MAC_HWF0R_TXCOESEL, mac_hfr0);
+	hw_feat->rx_coe = FIELD_GET(MAC_HWF0R_RXCOESEL, mac_hfr0);
+	hw_feat->addn_mac = FIELD_GET(MAC_HWF0R_ADDMACADRSEL, mac_hfr0);
+	hw_feat->ts_src = FIELD_GET(MAC_HWF0R_TSSTSSEL, mac_hfr0);
+	hw_feat->sa_vlan_ins = FIELD_GET(MAC_HWF0R_SAVLANINS, mac_hfr0);
+
+	/* Hardware feature register 1 */
+	hw_feat->rx_fifo_size = FIELD_GET(MAC_HWF1R_RXFIFOSIZE, mac_hfr1);
+	hw_feat->tx_fifo_size = FIELD_GET(MAC_HWF1R_TXFIFOSIZE, mac_hfr1);
+	hw_feat->adv_ts_hi = FIELD_GET(MAC_HWF1R_ADVTHWORD, mac_hfr1);
+	hw_feat->dma_width = FIELD_GET(MAC_HWF1R_ADDR64, mac_hfr1);
+	hw_feat->dcb = FIELD_GET(MAC_HWF1R_DCBEN, mac_hfr1);
+	hw_feat->sph = FIELD_GET(MAC_HWF1R_SPHEN, mac_hfr1);
+	hw_feat->tso = FIELD_GET(MAC_HWF1R_TSOEN, mac_hfr1);
+	hw_feat->dma_debug = FIELD_GET(MAC_HWF1R_DBGMEMA, mac_hfr1);
+	hw_feat->avsel = FIELD_GET(MAC_HWF1R_AVSEL, mac_hfr1);
+	hw_feat->ravsel = FIELD_GET(MAC_HWF1R_RAVSEL, mac_hfr1);
+	hw_feat->hash_table_size = FIELD_GET(MAC_HWF1R_HASHTBLSZ, mac_hfr1);
+	hw_feat->l3l4_filter_num = FIELD_GET(MAC_HWF1R_L3L4FNUM, mac_hfr1);
+	hw_feat->tx_q_cnt = FIELD_GET(MAC_HWF2R_TXQCNT, mac_hfr1);
+	hw_feat->rx_ch_cnt = FIELD_GET(MAC_HWF2R_RXCHCNT, mac_hfr1);
+	hw_feat->tx_ch_cnt = FIELD_GET(MAC_HWF2R_TXCHCNT, mac_hfr1);
+	hw_feat->pps_out_num = FIELD_GET(MAC_HWF2R_PPSOUTNUM, mac_hfr1);
+	hw_feat->aux_snap_num = FIELD_GET(MAC_HWF2R_AUXSNAPNUM, mac_hfr1);
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
+			fxgmac_io_rd(priv, i);
+	}
+}
+
+static int fxgmac_init(struct fxgmac_pdata *priv, bool save_private_reg)
+{
+	struct net_device *ndev = priv->ndev;
+	int ret;
+
+	fxgmac_default_config(priv);	/* Set default configuration data */
+	ndev->irq = priv->dev_irq;
+	ndev->base_addr = (unsigned long)priv->hw_addr;
+
+	ret = fxgmac_read_mac_addr(priv);
+	if (ret) {
+		dev_err(priv->dev, "Read mac addr failed:%d\n", ret);
+		return ret;
+	}
+	eth_hw_addr_set(ndev, priv->mac_addr);
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
+			dev_err(priv->dev, "No usable DMA configuration, aborting\n");
+			return ret;
+		}
+	}
+
+	if (FIELD_GET(INT_FLAG_LEGACY, priv->int_flag)) {
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
+	ret = netif_set_real_num_tx_queues(ndev, FXGMAC_TX_1_Q);
+	if (ret) {
+		dev_err(priv->dev, "Setting real tx queue count failed\n");
+		return ret;
+	}
+
+	priv->rx_ring_count = min_t(unsigned int,
+				    netif_get_num_default_rss_queues(),
+				    priv->hw_feat.rx_ch_cnt);
+	priv->rx_ring_count = min_t(unsigned int, priv->rx_ring_count,
+				    priv->hw_feat.rx_q_cnt);
+	priv->rx_q_count = priv->rx_ring_count;
+	ret = netif_set_real_num_rx_queues(ndev, priv->rx_q_count);
+	if (ret) {
+		dev_err(priv->dev, "Setting real rx queue count failed\n");
+		return ret;
+	}
+
+	priv->channel_count =
+		max_t(unsigned int, FXGMAC_TX_1_RING, priv->rx_ring_count);
+
+	ndev->min_mtu = ETH_MIN_MTU;
+	ndev->max_mtu =
+		FXGMAC_JUMBO_PACKET_MTU + (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
+
+	ndev->netdev_ops = fxgmac_get_netdev_ops();/* Set device operations */
+
+	/* Set device features */
+	if (priv->hw_feat.tso) {
+		ndev->hw_features = NETIF_F_TSO;
+		ndev->hw_features |= NETIF_F_TSO6;
+		ndev->hw_features |= NETIF_F_SG;
+		ndev->hw_features |= NETIF_F_IP_CSUM;
+		ndev->hw_features |= NETIF_F_IPV6_CSUM;
+	} else if (priv->hw_feat.tx_coe) {
+		ndev->hw_features = NETIF_F_IP_CSUM;
+		ndev->hw_features |= NETIF_F_IPV6_CSUM;
+	}
+
+	if (priv->hw_feat.rx_coe) {
+		ndev->hw_features |= NETIF_F_RXCSUM;
+		ndev->hw_features |= NETIF_F_GRO;
+	}
+
+	ndev->hw_features |= NETIF_F_RXHASH;
+	ndev->vlan_features |= ndev->hw_features;
+	ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
+
+	if (priv->hw_feat.sa_vlan_ins)
+		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_TX;
+
+	ndev->features |= ndev->hw_features;
+
+	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->watchdog_timeo = msecs_to_jiffies(5000);
+
+#define NIC_MAX_TCP_OFFLOAD_SIZE 7300
+	netif_set_tso_max_size(ndev, NIC_MAX_TCP_OFFLOAD_SIZE);
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
 static void fxgmac_init_interrupt_scheme(struct fxgmac_pdata *priv)
 {
 	struct pci_dev *pdev = to_pci_dev(priv->dev);
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
index 124860602..87095f8a2 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
@@ -28,6 +28,9 @@
 #define FXGMAC_MAX_DMA_CHANNELS                                           \
 	(FXGMAC_MAX_DMA_RX_CHANNELS + FXGMAC_MAX_DMA_TX_CHANNELS)
 
+/****************  Other configuration register. *********************/
+#define GLOBAL_CTRL0				0x1000
+
 #define EPHY_CTRL				0x1004
 #define EPHY_CTRL_RESET				BIT(0)
 #define EPHY_CTRL_STA_LINKUP			BIT(1)
@@ -52,6 +55,25 @@
 #define  MGMT_INT_CTRL0_INT_MASK_DISABLE	0xf000
 #define  MGMT_INT_CTRL0_INT_MASK_MASK		0xffff
 
+/* LTR_CTRL3, LTR latency message, only for System IDLE Start. */
+#define LTR_IDLE_ENTER				0x113c
+#define LTR_IDLE_ENTER_ENTER			GENMASK(9, 0)
+#define  LTR_IDLE_ENTER_900_US			900
+#define LTR_IDLE_ENTER_SCALE			GENMASK(14, 10)
+#define  LTR_IDLE_ENTER_SCALE_1_NS		0
+#define  LTR_IDLE_ENTER_SCALE_32_NS		1
+#define  LTR_IDLE_ENTER_SCALE_1024_NS		2
+#define  LTR_IDLE_ENTER_SCALE_32768_NS		3
+#define  LTR_IDLE_ENTER_SCALE_1048576_NS	4
+#define  LTR_IDLE_ENTER_SCALE_33554432_NS	5
+#define LTR_IDLE_ENTER_REQUIRE			BIT(15)
+
+/* LTR_CTRL4, LTR latency message, only for System IDLE End. */
+#define LTR_IDLE_EXIT				0x1140
+#define LTR_IDLE_EXIT_EXIT			GENMASK(9, 0)
+#define  LTR_IDLE_EXIT_171_US			171
+#define LTR_IDLE_EXIT_SCALE			GENMASK(14, 10)
+#define LTR_IDLE_EXIT_REQUIRE			BIT(15)
 /* msi table */
 #define MSI_ID_RXQ0				0
 #define MSI_ID_RXQ1				1
@@ -60,6 +82,35 @@
 #define MSI_ID_TXQ0				4
 #define MSIX_TBL_MAX_NUM			5
 
+#define MSI_PBA					0x1300
+
+#define EFUSE_OP_CTRL_0				0x1500
+#define EFUSE_OP_MODE				GENMASK(1, 0)
+#define  EFUSE_OP_MODE_ROW_WRITE		0x0
+#define  EFUSE_OP_MODE_ROW_READ			0x1
+#define  EFUSE_OP_MODE_AUTO_LOAD		0x2
+#define  EFUSE_OP_MODE_READ_BLANK		0x3
+#define EFUSE_OP_START				BIT(2)
+#define EFUSE_OP_ADDR				GENMASK(15, 8)
+#define EFUSE_OP_WR_DATA			GENMASK(23, 16)
+
+#define EFUSE_OP_CTRL_1				0x1504
+#define EFUSE_OP_DONE				BIT(1)
+#define EFUSE_OP_PGM_PASS			BIT(2)
+#define EFUSE_OP_BIST_ERR_CNT			GENMASK(15, 8)
+#define EFUSE_OP_BIST_ERR_ADDR			GENMASK(23, 16)
+#define EFUSE_OP_RD_DATA			GENMASK(31, 24)
+
+/* MAC addr can be configured through effuse */
+#define MACA0LR_FROM_EFUSE			0x1520
+#define MACA0HR_FROM_EFUSE			0x1524
+
+#define SYS_RESET				0x152c
+#define SYS_RESET_RESET				BIT(31)
+
+#define PCIE_SERDES_PLL				0x199c
+#define PCIE_SERDES_PLL_AUTOOFF			BIT(0)
+
 /****************  GMAC register. *********************/
 #define MAC_CR				0x2000
 #define MAC_CR_RE			BIT(0)
@@ -89,6 +140,47 @@
 #define MAC_PMT_STA_GLBLUCAST		BIT(9)
 #define MAC_PMT_STA_RWKPTR		GENMASK(27, 24)
 #define MAC_PMT_STA_RWKFILTERST		BIT(31)
+
+#define MAC_HWF0R			0x211c
+#define MAC_HWF0R_VLHASH		BIT(4)
+#define MAC_HWF0R_SMASEL		BIT(5)
+#define MAC_HWF0R_RWKSEL		BIT(6)
+#define MAC_HWF0R_MGKSEL		BIT(7)
+#define MAC_HWF0R_MMCSEL		BIT(8)
+#define MAC_HWF0R_ARPOFFSEL		BIT(9)
+#define MAC_HWF0R_TSSEL			BIT(12)
+#define MAC_HWF0R_EEESEL		BIT(13)
+#define MAC_HWF0R_TXCOESEL		BIT(14)
+#define MAC_HWF0R_RXCOESEL		BIT(16)
+#define MAC_HWF0R_ADDMACADRSEL		GENMASK(22, 18)
+#define MAC_HWF0R_TSSTSSEL		GENMASK(26, 25)
+#define MAC_HWF0R_SAVLANINS		BIT(27)
+#define MAC_HWF0R_ACTPHYIFSEL		GENMASK(30, 28)
+
+#define MAC_HWF1R			0x2120
+#define MAC_HWF1R_RXFIFOSIZE		GENMASK(4, 0)
+#define MAC_HWF1R_TXFIFOSIZE		GENMASK(10, 6)
+#define MAC_HWF1R_ADVTHWORD		BIT(13)
+#define MAC_HWF1R_ADDR64		GENMASK(15, 14)
+#define MAC_HWF1R_DCBEN			BIT(16)
+#define MAC_HWF1R_SPHEN			BIT(17)
+#define MAC_HWF1R_TSOEN			BIT(18)
+#define MAC_HWF1R_DBGMEMA		BIT(19)
+#define MAC_HWF1R_AVSEL			BIT(20)
+#define MAC_HWF1R_RAVSEL		BIT(21)
+#define MAC_HWF1R_HASHTBLSZ		GENMASK(25, 24)
+#define MAC_HWF1R_L3L4FNUM		GENMASK(30, 27)
+
+#define MAC_HWF2R			0x2124
+#define MAC_HWF2R_RXQCNT		GENMASK(3, 0)
+#define MAC_HWF2R_TXQCNT		GENMASK(9, 6)
+#define MAC_HWF2R_RXCHCNT		GENMASK(15, 12)
+#define MAC_HWF2R_TXCHCNT		GENMASK(21, 18)
+#define MAC_HWF2R_PPSOUTNUM		GENMASK(26, 24)
+#define MAC_HWF2R_AUXSNAPNUM		GENMASK(30, 28)
+
+#define MAC_HWF3R			0x2128
+
 #define MAC_MDIO_ADDR			0x2200
 #define MAC_MDIO_ADDR_BUSY		BIT(0)
 #define MAC_MDIO_ADDR_GOC		GENMASK(3, 2)
@@ -112,6 +204,7 @@
 #define MTL_Q_RQDR			0x38
 #define MTL_Q_RQDR_RXQSTS		GENMASK(5, 4)
 #define MTL_Q_RQDR_PRXQ			GENMASK(29, 16)
+
 #define DMA_DSRX_INC				4
 #define DMA_DSR0				0x300c
 #define DMA_DSR0_TPS				GENMASK(15, 12)
@@ -244,6 +337,55 @@ struct fxgmac_channel {
 	struct fxgmac_ring *rx_ring;
 } ____cacheline_aligned;
 
+/* This structure contains flags that indicate what hardware features
+ * or configurations are present in the device.
+ */
+struct fxgmac_hw_features {
+	unsigned int version;		/* HW Version */
+
+	/* HW Feature Register0 */
+	unsigned int phyifsel;		/* PHY interface support */
+	unsigned int vlhash;		/* VLAN Hash Filter */
+	unsigned int sma;		/* SMA(MDIO) Interface */
+	unsigned int rwk;		/* PMT remote wake-up packet */
+	unsigned int mgk;		/* PMT magic packet */
+	unsigned int mmc;		/* RMON module */
+	unsigned int aoe;		/* ARP Offload */
+	unsigned int ts;		/* IEEE 1588-2008 Advanced Timestamp */
+	unsigned int eee;		/* Energy Efficient Ethernet */
+	unsigned int tx_coe;		/* Tx Checksum Offload */
+	unsigned int rx_coe;		/* Rx Checksum Offload */
+	unsigned int addn_mac;		/* Additional MAC Addresses */
+	unsigned int ts_src;		/* Timestamp Source */
+	unsigned int sa_vlan_ins;	/* Source Address or VLAN Insertion */
+
+	/* HW Feature Register1 */
+	unsigned int rx_fifo_size;	/* MTL Receive FIFO Size */
+	unsigned int tx_fifo_size;	/* MTL Transmit FIFO Size */
+	unsigned int adv_ts_hi;		/* Advance Timestamping High Word */
+	unsigned int dma_width;		/* DMA width */
+	unsigned int dcb;		/* DCB Feature */
+	unsigned int sph;		/* Split Header Feature */
+	unsigned int tso;		/* TCP Segmentation Offload */
+	unsigned int dma_debug;		/* DMA Debug Registers */
+	unsigned int rss;		/* Receive Side Scaling */
+	unsigned int tc_cnt;		/* Number of Traffic Classes */
+	unsigned int avsel;		/* AV Feature Enable */
+	unsigned int ravsel;		/* Rx Side Only AV Feature Enable */
+	unsigned int hash_table_size;	/* Hash Table Size */
+	unsigned int l3l4_filter_num;	/* Number of L3-L4 Filters */
+
+	/* HW Feature Register2 */
+	unsigned int rx_q_cnt;		/* Number of MTL Receive Queues */
+	unsigned int tx_q_cnt;		/* Number of MTL Transmit Queues */
+	unsigned int rx_ch_cnt;		/* Number of DMA Receive Channels */
+	unsigned int tx_ch_cnt;		/* Number of DMA Transmit Channels */
+	unsigned int pps_out_num;	/* Number of PPS outputs */
+	unsigned int aux_snap_num;	/* Number of Aux snapshot inputs */
+
+	u32 hwfr3;			/* HW Feature Register3 */
+};
+
 struct fxgmac_resources {
 	void __iomem *addr;
 	int irq;
@@ -264,6 +406,7 @@ struct fxgmac_pdata {
 	struct device *dev;
 	struct phy_device *phydev;
 
+	struct fxgmac_hw_features hw_feat;	/* Hardware features */
 	void __iomem *hw_addr;			/* Registers base */
 
 	/* Rings for Tx/Rx on a DMA channel */
@@ -276,6 +419,33 @@ struct fxgmac_pdata {
 #define FXGMAC_TX_1_Q		1
 	unsigned int tx_desc_count;
 
+	unsigned long sysclk_rate;		/* Device clocks */
+	unsigned int pblx8;			/* Tx/Rx common settings */
+
+	/* Tx settings */
+	unsigned int tx_sf_mode;
+	unsigned int tx_threshold;
+	unsigned int tx_pbl;
+	unsigned int tx_osp_mode;
+
+	/* Rx settings */
+	unsigned int rx_sf_mode;
+	unsigned int rx_threshold;
+	unsigned int rx_pbl;
+
+	/* Tx coalescing settings */
+	unsigned int tx_usecs;
+	unsigned int tx_frames;
+
+	/* Rx coalescing settings */
+	unsigned int rx_riwt;
+	unsigned int rx_usecs;
+	unsigned int rx_frames;
+
+	/* Flow control settings */
+	unsigned int tx_pause;
+	unsigned int rx_pause;
+
 	/* Device interrupt */
 	int dev_irq;
 	unsigned int per_channel_irq;
@@ -299,7 +469,14 @@ struct fxgmac_pdata {
 #define INT_FLAG_LEGACY_IRQ		BIT(31)
 	u32 int_flag;		/* interrupt flag */
 
+	/* ndev related settings */
+	unsigned char mac_addr[ETH_ALEN];
+
+	int mac_speed;
+	int mac_duplex;
+
 	u32 msg_enable;
+	u32 reg_nonstick[(MSI_PBA - GLOBAL_CTRL0) >> 2];
 	enum fxgmac_dev_state dev_state;
 #define FXGMAC_POWER_STATE_DOWN			0
 #define FXGMAC_POWER_STATE_UP			1
-- 
2.34.1


