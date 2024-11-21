Return-Path: <netdev+bounces-146563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CA29D458D
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 02:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36344B226F8
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 01:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BA02AF1B;
	Thu, 21 Nov 2024 01:52:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A712309AD;
	Thu, 21 Nov 2024 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732153968; cv=none; b=hZpsSC4uRYHXLzSRqtFQw8mhoyAVLuJITRz0blb4TYPUhBSXkmte7UnzZGYKkje3X+31zKwnKrgknkuMUkRQo2byDDxd62zz88pe+m3YgEW13FMCJn6/fIUIyafogoqDJ5E34s6kX54BfKmN5G0DZ89boAk8ukL98usB2+r6JlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732153968; c=relaxed/simple;
	bh=nodBHlsgDMpE39eUPrvJI0c0X0haBk+764EdJBAzAW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iGQfquH/WULfzt3dr7Xz4KZqCA1VZ6JfBaXmwWZQ+vUnngf73Y4xNdPC95dAcinw9m+g+rOaj1P4jqYhx/QOGp3Cz5o2N99u1F4McpTg5k3YX/cqKte93ZqQMvI3iqqlEqEtvGbrnntdlvrNMA0Ru7O7LOX5WguStVj6v2EFf/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppYW_1732100202 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:42 +0800
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
Subject: [PATCH net-next v2 07/21] motorcomm:yt6801: Implement the fxgmac_init function
Date: Thu, 21 Nov 2024 09:52:37 +0800
Message-Id: <20241120105625.22508-8-Frank.Sae@motor-comm.com>
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

Implement the fxgmac_init to init hardware settings, including setting function
pointers, default configuration data, irq, base_addr, MAC address, DMA mask,
device operations and device features.
It alseo populates the hardware features, initialize RSS hash key and lookup
table and other configure.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 555 ++++++++++++++++++
 1 file changed, 555 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index 2033267d9..aa51ecdd7 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -11,6 +11,7 @@
 #include "yt6801_desc.h"
 #include "yt6801_net.h"
 
+const struct net_device_ops *fxgmac_get_netdev_ops(void);
 static void fxgmac_napi_enable(struct fxgmac_pdata *pdata);
 
 static unsigned int fxgmac_desc_tx_avail(struct fxgmac_ring *ring)
@@ -795,6 +796,560 @@ static int fxgmac_open(struct net_device *netdev)
 	return ret;
 }
 
+#define FXGMAC_SYSCLOCK 125000000 /* System clock is 125 MHz */
+
+static void fxgmac_default_config(struct fxgmac_pdata *pdata)
+{
+	pdata->tx_threshold = MTL_TX_THRESHOLD_128;
+	pdata->rx_threshold = MTL_RX_THRESHOLD_128;
+	pdata->tx_osp_mode = DMA_OSP_ENABLE;
+	pdata->tx_sf_mode = MTL_TSF_ENABLE;
+	pdata->rx_sf_mode = MTL_RSF_ENABLE;
+	pdata->pblx8 = DMA_PBL_X8_ENABLE;
+	pdata->tx_pbl = DMA_PBL_16;
+	pdata->rx_pbl = DMA_PBL_4;
+	pdata->crc_check = 1;
+	pdata->tx_pause = 1;	/* Enable tx pause */
+	pdata->rx_pause = 1;	/* Enable rx pause */
+	pdata->intr_mod = 1;
+	pdata->intr_mod_timer = INT_MOD_200_US;
+	pdata->vlan_strip = 1;
+	pdata->rss = 1;
+
+	pdata->phy_autoeng = AUTONEG_ENABLE;
+	pdata->phy_duplex = DUPLEX_FULL;
+	pdata->phy_speed = SPEED_1000;
+	pdata->phy_link = false;
+
+	pdata->sysclk_rate = FXGMAC_SYSCLOCK;
+	pdata->wol = WAKE_MAGIC;
+
+	strscpy(pdata->drv_name, FXGMAC_DRV_NAME, sizeof(pdata->drv_name));
+	strscpy(pdata->drv_ver, FXGMAC_DRV_VERSION, sizeof(pdata->drv_ver));
+	yt_dbg(pdata, "drv_name:%s, drv_ver:%s\n", FXGMAC_DRV_NAME,
+	       FXGMAC_DRV_VERSION);
+}
+
+static void fxgmac_get_all_hw_features(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_hw_features *hw_feat = &pdata->hw_feat;
+	unsigned int mac_hfr0, mac_hfr1, mac_hfr2, mac_hfr3;
+
+	mac_hfr0 = rd32_mac(pdata, MAC_HWF0R);
+	mac_hfr1 = rd32_mac(pdata, MAC_HWF1R);
+	mac_hfr2 = rd32_mac(pdata, MAC_HWF2R);
+	mac_hfr3 = rd32_mac(pdata, MAC_HWF3R);
+	memset(hw_feat, 0, sizeof(*hw_feat));
+	hw_feat->version = rd32_mac(pdata, MAC_VR);
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "Mac ver=%#x\n", hw_feat->version);
+
+	/* Hardware feature register 0 */
+	hw_feat->phyifsel = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_ACTPHYIFSEL_POS,
+					    MAC_HWF0R_ACTPHYIFSEL_LEN);
+	hw_feat->vlhash = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_VLHASH_POS,
+					  MAC_HWF0R_VLHASH_LEN);
+	hw_feat->sma = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_SMASEL_POS,
+				       MAC_HWF0R_SMASEL_LEN);
+	hw_feat->rwk = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_RWKSEL_POS,
+				       MAC_HWF0R_RWKSEL_LEN);
+	hw_feat->mgk = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_MGKSEL_POS,
+				       MAC_HWF0R_MGKSEL_LEN);
+	hw_feat->mmc = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_MMCSEL_POS,
+				       MAC_HWF0R_MMCSEL_LEN);
+	hw_feat->aoe = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_ARPOFFSEL_POS,
+				       MAC_HWF0R_ARPOFFSEL_LEN);
+	hw_feat->ts = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_TSSEL_POS,
+				      MAC_HWF0R_TSSEL_LEN);
+	hw_feat->eee = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_EEESEL_POS,
+				       MAC_HWF0R_EEESEL_LEN);
+	hw_feat->tx_coe = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_TXCOESEL_POS,
+					  MAC_HWF0R_TXCOESEL_LEN);
+	hw_feat->rx_coe = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_RXCOESEL_POS,
+					  MAC_HWF0R_RXCOESEL_LEN);
+	hw_feat->addn_mac = FXGMAC_GET_BITS(mac_hfr0,
+					    MAC_HWF0R_ADDMACADRSEL_POS,
+					    MAC_HWF0R_ADDMACADRSEL_LEN);
+	hw_feat->ts_src = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_TSSTSSEL_POS,
+					  MAC_HWF0R_TSSTSSEL_LEN);
+	hw_feat->sa_vlan_ins = FXGMAC_GET_BITS(mac_hfr0,
+					       MAC_HWF0R_SAVLANINS_POS,
+					       MAC_HWF0R_SAVLANINS_LEN);
+
+	/* Hardware feature register 1 */
+	hw_feat->rx_fifo_size = FXGMAC_GET_BITS(mac_hfr1,
+						MAC_HWF1R_RXFIFOSIZE_POS,
+						MAC_HWF1R_RXFIFOSIZE_LEN);
+	hw_feat->tx_fifo_size = FXGMAC_GET_BITS(mac_hfr1,
+						MAC_HWF1R_TXFIFOSIZE_POS,
+						MAC_HWF1R_TXFIFOSIZE_LEN);
+	hw_feat->adv_ts_hi = FXGMAC_GET_BITS(mac_hfr1,
+					     MAC_HWF1R_ADVTHWORD_POS,
+					     MAC_HWF1R_ADVTHWORD_LEN);
+	hw_feat->dma_width = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_ADDR64_POS,
+					     MAC_HWF1R_ADDR64_LEN);
+	hw_feat->dcb = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_DCBEN_POS,
+				       MAC_HWF1R_DCBEN_LEN);
+	hw_feat->sph = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_SPHEN_POS,
+				       MAC_HWF1R_SPHEN_LEN);
+	hw_feat->tso = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_TSOEN_POS,
+				       MAC_HWF1R_TSOEN_LEN);
+	hw_feat->dma_debug = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_DBGMEMA_POS,
+					     MAC_HWF1R_DBGMEMA_LEN);
+	hw_feat->avsel = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_RAVSEL_POS,
+					 MAC_HWF1R_RAVSEL_LEN);
+	hw_feat->ravsel = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_RAVSEL_POS,
+					  MAC_HWF1R_RAVSEL_LEN);
+	hw_feat->hash_table_size = FXGMAC_GET_BITS(mac_hfr1,
+						   MAC_HWF1R_HASHTBLSZ_POS,
+						   MAC_HWF1R_HASHTBLSZ_LEN);
+	hw_feat->l3l4_filter_num = FXGMAC_GET_BITS(mac_hfr1,
+						   MAC_HWF1R_L3L4FNUM_POS,
+						   MAC_HWF1R_L3L4FNUM_LEN);
+	hw_feat->tx_q_cnt = FXGMAC_GET_BITS(mac_hfr2, MAC_HWF2R_TXQCNT_POS,
+					    MAC_HWF2R_TXQCNT_LEN);
+	hw_feat->rx_ch_cnt = FXGMAC_GET_BITS(mac_hfr2, MAC_HWF2R_RXCHCNT_POS,
+					     MAC_HWF2R_RXCHCNT_LEN);
+	hw_feat->tx_ch_cnt = FXGMAC_GET_BITS(mac_hfr2, MAC_HWF2R_TXCHCNT_POS,
+					     MAC_HWF2R_TXCHCNT_LEN);
+	hw_feat->pps_out_num = FXGMAC_GET_BITS(mac_hfr2,
+					       MAC_HWF2R_PPSOUTNUM_POS,
+					       MAC_HWF2R_PPSOUTNUM_LEN);
+	hw_feat->aux_snap_num = FXGMAC_GET_BITS(mac_hfr2,
+						MAC_HWF2R_AUXSNAPNUM_POS,
+						MAC_HWF2R_AUXSNAPNUM_LEN);
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
+static void fxgmac_print_all_hw_features(struct fxgmac_pdata *pdata)
+{
+	char *str;
+
+	yt_dbg(pdata, "\n");
+	yt_dbg(pdata, "====================================================\n");
+	yt_dbg(pdata, "\n");
+	yt_dbg(pdata, "HW support following feature\n");
+	yt_dbg(pdata, "\n");
+
+	/* HW Feature Register0 */
+	yt_dbg(pdata, "VLAN Hash Filter Selected                        : %s\n",
+	       pdata->hw_feat.vlhash ? "YES" : "NO");
+	yt_dbg(pdata, "SMA (MDIO) Interface                             : %s\n",
+	       pdata->hw_feat.sma ? "YES" : "NO");
+	yt_dbg(pdata, "PMT Remote Wake-up Packet Enable                 : %s\n",
+	       pdata->hw_feat.rwk ? "YES" : "NO");
+	yt_dbg(pdata, "PMT Magic Packet Enable                          : %s\n",
+	       pdata->hw_feat.mgk ? "YES" : "NO");
+	yt_dbg(pdata, "RMON/MMC Module Enable                           : %s\n",
+	       pdata->hw_feat.mmc ? "YES" : "NO");
+	yt_dbg(pdata, "ARP Offload Enabled                              : %s\n",
+	       pdata->hw_feat.aoe ? "YES" : "NO");
+	yt_dbg(pdata, "IEEE 1588-2008 Timestamp Enabled                 : %s\n",
+	       pdata->hw_feat.ts ? "YES" : "NO");
+	yt_dbg(pdata, "Energy Efficient Ethernet Enabled                : %s\n",
+	       pdata->hw_feat.eee ? "YES" : "NO");
+	yt_dbg(pdata, "Transmit Checksum Offload Enabled                : %s\n",
+	       pdata->hw_feat.tx_coe ? "YES" : "NO");
+	yt_dbg(pdata, "Receive Checksum Offload Enabled                 : %s\n",
+	       pdata->hw_feat.rx_coe ? "YES" : "NO");
+	yt_dbg(pdata, "Additional MAC Addresses 1-31 Selected           : %s\n",
+	       pdata->hw_feat.addn_mac ? "YES" : "NO");
+
+	switch (pdata->hw_feat.ts_src) {
+	case 0:
+		str = "RESERVED";
+		break;
+	case 1:
+		str = "INTERNAL";
+		break;
+	case 2:
+		str = "EXTERNAL";
+		break;
+	case 3:
+		str = "BOTH";
+		break;
+	}
+	yt_dbg(pdata, "Timestamp System Time Source                     : %s\n",
+	       str);
+	yt_dbg(pdata, "Source Address or VLAN Insertion Enable          : %s\n",
+	       pdata->hw_feat.sa_vlan_ins ? "YES" : "NO");
+
+	/* HW Feature Register1 */
+	switch (pdata->hw_feat.rx_fifo_size) {
+	case 0:
+		str = "128 bytes";
+		break;
+	case 1:
+		str = "256 bytes";
+		break;
+	case 2:
+		str = "512 bytes";
+		break;
+	case 3:
+		str = "1 KBytes";
+		break;
+	case 4:
+		str = "2 KBytes";
+		break;
+	case 5:
+		str = "4 KBytes";
+		break;
+	case 6:
+		str = "8 KBytes";
+		break;
+	case 7:
+		str = "16 KBytes";
+		break;
+	case 8:
+		str = "32 kBytes";
+		break;
+	case 9:
+		str = "64 KBytes";
+		break;
+	case 10:
+		str = "128 KBytes";
+		break;
+	case 11:
+		str = "256 KBytes";
+		break;
+	default:
+		str = "RESERVED";
+	}
+	yt_dbg(pdata, "MTL Receive FIFO Size                            : %s\n",
+	       str);
+
+	switch (pdata->hw_feat.tx_fifo_size) {
+	case 0:
+		str = "128 bytes";
+		break;
+	case 1:
+		str = "256 bytes";
+		break;
+	case 2:
+		str = "512 bytes";
+		break;
+	case 3:
+		str = "1 KBytes";
+		break;
+	case 4:
+		str = "2 KBytes";
+		break;
+	case 5:
+		str = "4 KBytes";
+		break;
+	case 6:
+		str = "8 KBytes";
+		break;
+	case 7:
+		str = "16 KBytes";
+		break;
+	case 8:
+		str = "32 kBytes";
+		break;
+	case 9:
+		str = "64 KBytes";
+		break;
+	case 10:
+		str = "128 KBytes";
+		break;
+	case 11:
+		str = "256 KBytes";
+		break;
+	default:
+		str = "RESERVED";
+	}
+	yt_dbg(pdata, "MTL Transmit FIFO Size                           : %s\n",
+	       str);
+	yt_dbg(pdata, "IEEE 1588 High Word Register Enable              : %s\n",
+	       pdata->hw_feat.adv_ts_hi ? "YES" : "NO");
+	yt_dbg(pdata, "Address width                                    : %u\n",
+	       pdata->hw_feat.dma_width);
+	yt_dbg(pdata, "DCB Feature Enable                               : %s\n",
+	       pdata->hw_feat.dcb ? "YES" : "NO");
+	yt_dbg(pdata, "Split Header Feature Enable                      : %s\n",
+	       pdata->hw_feat.sph ? "YES" : "NO");
+	yt_dbg(pdata, "TCP Segmentation Offload Enable                  : %s\n",
+	       pdata->hw_feat.tso ? "YES" : "NO");
+	yt_dbg(pdata, "DMA Debug Registers Enabled                      : %s\n",
+	       pdata->hw_feat.dma_debug ? "YES" : "NO");
+	yt_dbg(pdata, "RSS Feature Enabled                              : %s\n",
+	       "YES");
+	yt_dbg(pdata, "AV Feature Enabled                               : %s\n",
+	       pdata->hw_feat.avsel ? "YES" : "NO");
+	yt_dbg(pdata, "Rx Side Only AV Feature Enabled                  : %s\n",
+	       (pdata->hw_feat.ravsel ? "YES" : "NO"));
+	yt_dbg(pdata, "Hash Table Size                                  : %u\n",
+	       pdata->hw_feat.hash_table_size);
+	yt_dbg(pdata, "Total number of L3 or L4 Filters                 : %u\n",
+	       pdata->hw_feat.l3l4_filter_num);
+
+	/* HW Feature Register2 */
+	yt_dbg(pdata, "Number of MTL Receive Queues                     : %u\n",
+	       pdata->hw_feat.rx_q_cnt);
+	yt_dbg(pdata, "Number of MTL Transmit Queues                    : %u\n",
+	       pdata->hw_feat.tx_q_cnt);
+	yt_dbg(pdata, "Number of DMA Receive Channels                   : %u\n",
+	       pdata->hw_feat.rx_ch_cnt);
+	yt_dbg(pdata, "Number of DMA Transmit Channels                  : %u\n",
+	       pdata->hw_feat.tx_ch_cnt);
+
+	switch (pdata->hw_feat.pps_out_num) {
+	case 0:
+		str = "No PPS output";
+		break;
+	case 1:
+		str = "1 PPS output";
+		break;
+	case 2:
+		str = "2 PPS output";
+		break;
+	case 3:
+		str = "3 PPS output";
+		break;
+	case 4:
+		str = "4 PPS output";
+		break;
+	default:
+		str = "RESERVED";
+	}
+	yt_dbg(pdata, "Number of PPS Outputs                            : %s\n",
+	       str);
+
+	switch (pdata->hw_feat.aux_snap_num) {
+	case 0:
+		str = "No auxiliary input";
+		break;
+	case 1:
+		str = "1 auxiliary input";
+		break;
+	case 2:
+		str = "2 auxiliary input";
+		break;
+	case 3:
+		str = "3 auxiliary input";
+		break;
+	case 4:
+		str = "4 auxiliary input";
+		break;
+	default:
+		str = "RESERVED";
+	}
+	yt_dbg(pdata, "Number of Auxiliary Snapshot Inputs              : %s\n",
+	       str);
+
+	yt_dbg(pdata, "\n");
+	yt_dbg(pdata, "====================================================\n");
+	yt_dbg(pdata, "\n");
+}
+
+static int fxgmac_init(struct fxgmac_pdata *pdata, bool save_private_reg)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct net_device *netdev = pdata->netdev;
+	int ret;
+
+	fxgmac_hw_ops_init(hw_ops);	/* Set hw the function pointers */
+	fxgmac_default_config(pdata);	/* Set default configuration data */
+
+	/* Set irq, base_addr, MAC address */
+	netdev->irq = pdata->dev_irq;
+	netdev->base_addr = (unsigned long)pdata->hw_addr;
+
+	ret = fxgmac_read_mac_addr(pdata);
+	if (ret) {
+		yt_err(pdata, "fxgmac_read_mac_addr err:%d\n", ret);
+		return ret;
+	}
+	eth_hw_addr_set(netdev, pdata->mac_addr);
+
+	if (save_private_reg)
+		hw_ops->save_nonstick_reg(pdata);
+
+	hw_ops->exit(pdata);	/* Reset here to get hw features correctly */
+
+	/* Populate the hardware features */
+	fxgmac_get_all_hw_features(pdata);
+	fxgmac_print_all_hw_features(pdata);
+
+	/* Set the DMA mask */
+	ret = dma_set_mask_and_coherent(pdata->dev,
+					DMA_BIT_MASK(pdata->hw_feat.dma_width));
+	if (ret) {
+		yt_err(pdata, "dma_set_mask_and_coherent err:%d\n", ret);
+		return ret;
+	}
+	if (pdata->int_flags & FXGMAC_FLAG_LEGACY_ENABLED) {
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
+		pci_disable_msi(to_pci_dev(pdata->dev));
+		pci_disable_msix(to_pci_dev(pdata->dev));
+	}
+
+	BUILD_BUG_ON_NOT_POWER_OF_2(FXGMAC_TX_DESC_CNT);
+	pdata->tx_desc_count = FXGMAC_TX_DESC_CNT;
+	BUILD_BUG_ON_NOT_POWER_OF_2(FXGMAC_RX_DESC_CNT);
+	pdata->rx_desc_count = FXGMAC_RX_DESC_CNT;
+
+	ret = netif_set_real_num_tx_queues(netdev, FXGMAC_TX_1_Q);
+	yt_dbg(pdata,
+	       "num_online_cpus:%u, tx:ch_cnt:%u, q_cnt:%u, ring_count:%u\n",
+	       num_online_cpus(), pdata->hw_feat.tx_ch_cnt,
+	       pdata->hw_feat.tx_q_cnt, FXGMAC_TX_1_RING);
+	if (ret) {
+		yt_err(pdata, "error setting real tx queue count\n");
+		return ret;
+	}
+
+	pdata->rx_ring_count = min_t(unsigned int,
+				     netif_get_num_default_rss_queues(),
+				     pdata->hw_feat.rx_ch_cnt);
+	pdata->rx_ring_count = min_t(unsigned int, pdata->rx_ring_count,
+				     pdata->hw_feat.rx_q_cnt);
+	pdata->rx_q_count = pdata->rx_ring_count;
+	ret = netif_set_real_num_rx_queues(netdev, pdata->rx_q_count);
+	if (ret) {
+		yt_err(pdata, "error setting real rx queue count\n");
+		return ret;
+	}
+
+	pdata->channel_count =
+		max_t(unsigned int, FXGMAC_TX_1_RING, pdata->rx_ring_count);
+
+	yt_dbg(pdata,
+	       "default rss queues:%u, rx:ch_cnt:%u, q_cnt:%u, ring_count:%u, channel_count:%u, netdev tx channel_num=%u\n",
+	       netif_get_num_default_rss_queues(), pdata->hw_feat.rx_ch_cnt,
+	       pdata->hw_feat.rx_q_cnt, pdata->rx_ring_count,
+	       pdata->channel_count, netdev->real_num_tx_queues);
+
+	/* Initialize RSS hash key and lookup table */
+	netdev_rss_key_fill(pdata->rss_key, sizeof(pdata->rss_key));
+
+	for (u32 i = 0; i < FXGMAC_RSS_MAX_TABLE_SIZE; i++) {
+		fxgmac_set_bits(&pdata->rss_table[i], MAC_RSSDR_DMCH_POS,
+				MAC_RSSDR_DMCH_LEN, i % pdata->rx_ring_count);
+	}
+
+	pdata->rss_options |= FXGMAC_RSS_IP4TE | FXGMAC_RSS_TCP4TE |
+			      FXGMAC_RSS_UDP4TE;
+
+	netdev->min_mtu = ETH_MIN_MTU;
+	netdev->max_mtu =
+		FXGMAC_JUMBO_PACKET_MTU + (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
+
+	yt_dbg(pdata, "rss_options:0x%x\n", pdata->rss_options);
+
+	/* Set device operations */
+	netdev->netdev_ops = fxgmac_get_netdev_ops();
+	netdev->ethtool_ops = fxgmac_get_ethtool_ops();
+
+	/* Set device features */
+	if (pdata->hw_feat.tso) {
+		netdev->hw_features = NETIF_F_TSO;
+		netdev->hw_features |= NETIF_F_TSO6;
+		netdev->hw_features |= NETIF_F_SG;
+		netdev->hw_features |= NETIF_F_IP_CSUM;
+		netdev->hw_features |= NETIF_F_IPV6_CSUM;
+	} else if (pdata->hw_feat.tx_coe) {
+		netdev->hw_features = NETIF_F_IP_CSUM;
+		netdev->hw_features |= NETIF_F_IPV6_CSUM;
+	}
+
+	if (pdata->hw_feat.rx_coe) {
+		netdev->hw_features |= NETIF_F_RXCSUM;
+		netdev->hw_features |= NETIF_F_GRO;
+	}
+
+	netdev->hw_features |= NETIF_F_RXHASH;
+	netdev->vlan_features |= netdev->hw_features;
+
+	netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
+
+	if (pdata->hw_feat.sa_vlan_ins)
+		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_TX;
+
+	netdev->features |= netdev->hw_features;
+	pdata->netdev_features = netdev->features;
+
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->watchdog_timeo = msecs_to_jiffies(5000);
+
+#define NIC_MAX_TCP_OFFLOAD_SIZE 7300
+
+	netif_set_tso_max_size(netdev, NIC_MAX_TCP_OFFLOAD_SIZE);
+
+/* Default coalescing parameters */
+#define FXGMAC_INIT_DMA_TX_USECS INT_MOD_200_US
+#define FXGMAC_INIT_DMA_TX_FRAMES 25
+#define FXGMAC_INIT_DMA_RX_USECS INT_MOD_200_US
+#define FXGMAC_INIT_DMA_RX_FRAMES 25
+
+	/* Tx coalesce parameters initialization */
+	pdata->tx_usecs = FXGMAC_INIT_DMA_TX_USECS;
+	pdata->tx_frames = FXGMAC_INIT_DMA_TX_FRAMES;
+
+	/* Rx coalesce parameters initialization */
+	pdata->rx_riwt = hw_ops->usec_to_riwt(pdata, FXGMAC_INIT_DMA_RX_USECS);
+	pdata->rx_usecs = FXGMAC_INIT_DMA_RX_USECS;
+	pdata->rx_frames = FXGMAC_INIT_DMA_RX_FRAMES;
+
+	mutex_init(&pdata->mutex);
+	yt_dbg(pdata, "%s ok.\n", __func__);
+
+	return 0;
+}
+
 #ifdef CONFIG_PCI_MSI
 static void fxgmac_init_interrupt_scheme(struct fxgmac_pdata *pdata)
 {
-- 
2.34.1


