Return-Path: <netdev+bounces-180110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBFDA7F98B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3433D189473D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECD226656B;
	Tue,  8 Apr 2025 09:29:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-23.us.a.mail.aliyun.com (out198-23.us.a.mail.aliyun.com [47.90.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA7264FA5;
	Tue,  8 Apr 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104554; cv=none; b=fiB2OVq94WQHHEaRClUY7bU0TxQnuDto2DGmbSLZ6ZFPaeXFWn/A7v/R3kajFU7oSt1ypqm0g54GZgtVAR6TZ1bXhiqpMUs4G94HGzzhRx2904ePmaVV+pGoUR1+vihqVqopsyM8LmYQ1kwc1rudQ5WRgxmIpTX+qZJZ1vKms0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104554; c=relaxed/simple;
	bh=RLLOkO43wtpdPHJ+o9kyOUY3/I2aX3P1cWkGdrW3ltw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=doEfdoF6iCA1CSoX5b6rRBa8mwyGcEKSsd7Fgbbttv0nLf6RYNw9ldUAjZifz6ahzm2YxHRbKeXjqTyAdaGmBOn7Of5ChKz/W/qZejZfteJXdQYIu9wxKLNFCYMO5il8evdih+4rJI2wLnGviAvgvu+NL+mhb/PRUb8ZH6o9NyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cGww7QX_1744104536 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 17:28:57 +0800
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
Subject: [PATCH net-next v4 08/14] yt6801: Implement the fxgmac_hw_init function
Date: Tue,  8 Apr 2025 17:28:29 +0800
Message-Id: <20250408092835.3952-9-Frank.Sae@motor-comm.com>
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

Implement some hardware init functions to set default hardware
 settings, including PHY control, Vlan related config, RX coalescing,
 and other basic function control.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_main.c   | 546 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_type.h   | 193 +++++++
 2 files changed, 739 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
index 34ccefdf9..5922a2449 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
@@ -484,6 +484,325 @@ static void fxgmac_enable_msix_irqs(struct fxgmac_pdata *priv)
 		fxgmac_enable_msix_one_irq(priv, intid);
 }
 
+static void __fxgmac_set_mac_address(struct fxgmac_pdata *priv, u8 *addr)
+{
+	u32 mac_hi, mac_lo;
+
+	mac_lo = (u32)addr[0] | ((u32)addr[1] << 8) | ((u32)addr[2] << 16) |
+		 ((u32)addr[3] << 24);
+
+	mac_hi = (u32)addr[4] | ((u32)addr[5] << 8);
+
+	fxgmac_io_wr(priv, MAC_MACA0LR, mac_lo);
+	fxgmac_io_wr(priv, MAC_MACA0HR, mac_hi);
+}
+
+static void fxgmac_config_mac_address(struct fxgmac_pdata *priv)
+{
+	__fxgmac_set_mac_address(priv, priv->mac_addr);
+	fxgmac_io_wr_bits(priv, MAC_PFR, MAC_PFR_HPF, 1);
+	fxgmac_io_wr_bits(priv, MAC_PFR, MAC_PFR_HUC, 1);
+	fxgmac_io_wr_bits(priv, MAC_PFR, MAC_PFR_HMC, 1);
+}
+
+static void fxgmac_config_crc_check_en(struct fxgmac_pdata *priv)
+{
+	fxgmac_io_wr_bits(priv, MAC_ECR, MAC_ECR_DCRCC, 1);
+}
+
+static void fxgmac_config_checksum_offload(struct fxgmac_pdata *priv)
+{
+	if (priv->ndev->features & NETIF_F_RXCSUM)
+		fxgmac_io_wr_bits(priv, MAC_CR, MAC_CR_IPC, 1);
+	else
+		fxgmac_io_wr_bits(priv, MAC_CR, MAC_CR_IPC, 0);
+}
+
+static void fxgmac_set_promiscuous_mode(struct fxgmac_pdata *priv,
+					unsigned int enable)
+{
+	fxgmac_io_wr_bits(priv, MAC_PFR, MAC_PFR_PR, enable);
+}
+
+static void fxgmac_enable_rx_broadcast(struct fxgmac_pdata *priv,
+				       unsigned int enable)
+{
+	fxgmac_io_wr_bits(priv, MAC_PFR, MAC_PFR_DBF, enable);
+}
+
+static void fxgmac_set_all_multicast_mode(struct fxgmac_pdata *priv,
+					  unsigned int enable)
+{
+	fxgmac_io_wr_bits(priv, MAC_PFR, MAC_PFR_PM, enable);
+}
+
+static void fxgmac_config_rx_mode(struct fxgmac_pdata *priv)
+{
+	u32 pr_mode, am_mode, bd_mode;
+
+	pr_mode = ((priv->ndev->flags & IFF_PROMISC) != 0);
+	am_mode = ((priv->ndev->flags & IFF_ALLMULTI) != 0);
+	bd_mode = ((priv->ndev->flags & IFF_BROADCAST) != 0);
+
+	fxgmac_enable_rx_broadcast(priv, bd_mode);
+	fxgmac_set_promiscuous_mode(priv, pr_mode);
+	fxgmac_set_all_multicast_mode(priv, am_mode);
+}
+
+static void fxgmac_config_tx_flow_control(struct fxgmac_pdata *priv)
+{
+	/* Set MTL flow control */
+	for (u32 i = 0; i < priv->rx_q_count; i++)
+		fxgmac_mtl_wr_bits(priv, i, MTL_Q_RQOMR, MTL_Q_RQOMR_EHFC,
+				   priv->tx_pause);
+
+	/* Set MAC flow control */
+	fxgmac_io_wr_bits(priv, MAC_Q0TFCR, MAC_Q0TFCR_TFE, priv->tx_pause);
+
+	if (priv->tx_pause == 1) /* Set pause time */
+		fxgmac_io_wr_bits(priv, MAC_Q0TFCR, MAC_Q0TFCR_PT, 0xffff);
+}
+
+static void fxgmac_config_rx_flow_control(struct fxgmac_pdata *priv)
+{
+	fxgmac_io_wr_bits(priv, MAC_RFCR, MAC_RFCR_RFE, priv->rx_pause);
+}
+
+static void fxgmac_config_rx_coalesce(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+		fxgmac_dma_wr_bits(channel, DMA_CH_RIWT, DMA_CH_RIWT_RWT,
+				   priv->rx_riwt);
+	}
+}
+
+static void fxgmac_config_rx_fep_disable(struct fxgmac_pdata *priv)
+{
+	/* Enable the rx queue forward packet with error status
+	 * (crc error,gmii_er, watch dog timeout.or overflow)
+	 */
+	for (u32 i = 0; i < priv->rx_q_count; i++)
+		fxgmac_mtl_wr_bits(priv, i, MTL_Q_RQOMR, MTL_Q_RQOMR_FEP, 1);
+}
+
+static void fxgmac_config_rx_fup_enable(struct fxgmac_pdata *priv)
+{
+	for (u32 i = 0; i < priv->rx_q_count; i++)
+		fxgmac_mtl_wr_bits(priv, i, MTL_Q_RQOMR, MTL_Q_RQOMR_FUP, 1);
+}
+
+static void fxgmac_config_rx_buffer_size(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		fxgmac_dma_wr_bits(channel, DMA_CH_RCR, DMA_CH_RCR_RBSZ,
+				   priv->rx_buf_size);
+}
+
+static void fxgmac_config_tso_mode(struct fxgmac_pdata *priv)
+{
+	fxgmac_dma_wr_bits(priv->channel_head, DMA_CH_TCR, DMA_CH_TCR_TSE,
+			   priv->hw_feat.tso);
+}
+
+static void fxgmac_config_sph_mode(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		fxgmac_dma_wr_bits(channel, DMA_CH_CR, DMA_CH_CR_SPH, 0);
+
+	fxgmac_io_wr_bits(priv, MAC_ECR, MAC_ECR_HDSMS, MAC_ECR_HDSMS_512B);
+}
+
+static void fxgmac_config_rx_threshold(struct fxgmac_pdata *priv,
+				       unsigned int set_val)
+{
+	for (u32 i = 0; i < priv->rx_q_count; i++)
+		fxgmac_mtl_wr_bits(priv, i, MTL_Q_RQOMR, MTL_Q_RQOMR_RTC,
+				   set_val);
+}
+
+static void fxgmac_config_mtl_mode(struct fxgmac_pdata *priv)
+{
+	/* Set Tx to weighted round robin scheduling algorithm */
+	fxgmac_io_wr_bits(priv, MTL_OMR, MTL_OMR_ETSALG, MTL_ETSALG_WRR);
+
+	/* Set Tx traffic classes to use WRR algorithm with equal weights */
+	fxgmac_mtl_wr_bits(priv, 0, MTL_TC_QWR, MTL_TC_QWR_QW, 1);
+
+	/* Set Rx to strict priority algorithm */
+	fxgmac_io_wr_bits(priv, MTL_OMR, MTL_OMR_RAA, MTL_RAA_SP);
+}
+
+static void fxgmac_config_queue_mapping(struct fxgmac_pdata *priv)
+{
+	unsigned int ppq, ppq_extra, prio_queues;
+	unsigned int __maybe_unused prio;
+	unsigned int reg, val, mask;
+
+	/* Map the 8 VLAN priority values to available MTL Rx queues */
+	prio_queues =
+		min_t(unsigned int, IEEE_8021QAZ_MAX_TCS, priv->rx_q_count);
+	ppq = IEEE_8021QAZ_MAX_TCS / prio_queues;
+	ppq_extra = IEEE_8021QAZ_MAX_TCS % prio_queues;
+
+	reg = MAC_RQC2R;
+	for (u32 i = 0, prio = 0; i < prio_queues;) {
+		val = 0;
+		mask = 0;
+		for (u32 j = 0; j < ppq; j++) {
+			mask |= (1 << prio);
+			prio++;
+		}
+
+		if (i < ppq_extra) {
+			mask |= (1 << prio);
+			prio++;
+		}
+
+		val |= (mask << ((i++ % MAC_RQC2_Q_PER_REG) << 3));
+
+		if ((i % MAC_RQC2_Q_PER_REG) && i != prio_queues)
+			continue;
+
+		fxgmac_io_wr(priv, reg, val);
+		reg += MAC_RQC2_INC;
+	}
+
+	/* Configure one to one, MTL Rx queue to DMA Rx channel mapping
+	 * ie Q0 <--> CH0, Q1 <--> CH1 ... Q7 <--> CH7
+	 */
+	val = fxgmac_io_rd(priv, MTL_RQDCM0R);
+	val |= (MTL_RQDCM0R_Q0MDMACH | MTL_RQDCM0R_Q1MDMACH |
+		MTL_RQDCM0R_Q2MDMACH | MTL_RQDCM0R_Q3MDMACH);
+	fxgmac_io_wr(priv, MTL_RQDCM0R, val);
+
+	val = fxgmac_io_rd(priv, MTL_RQDCM0R + MTL_RQDCM_INC);
+	val |= (MTL_RQDCM1R_Q4MDMACH | MTL_RQDCM1R_Q5MDMACH |
+		MTL_RQDCM1R_Q6MDMACH | MTL_RQDCM1R_Q7MDMACH);
+	fxgmac_io_wr(priv, MTL_RQDCM0R + MTL_RQDCM_INC, val);
+}
+
+static unsigned int fxgmac_calculate_per_queue_fifo(unsigned int fifo_size,
+						    unsigned int queue_count)
+{
+	u32 q_fifo_size, p_fifo;
+
+	/* Calculate the configured fifo size */
+	q_fifo_size = 1 << (fifo_size + 7);
+
+#define FXGMAC_MAX_FIFO 81920
+	/* The configured value may not be the actual amount of fifo RAM */
+	q_fifo_size = min_t(unsigned int, FXGMAC_MAX_FIFO, q_fifo_size);
+	q_fifo_size = q_fifo_size / queue_count;
+
+	/* Each increment in the queue fifo size represents 256 bytes of
+	 * fifo, with 0 representing 256 bytes. Distribute the fifo equally
+	 * between the queues.
+	 */
+	p_fifo = q_fifo_size / 256;
+	if (p_fifo)
+		p_fifo--;
+
+	return p_fifo;
+}
+
+static void fxgmac_config_tx_fifo_size(struct fxgmac_pdata *priv)
+{
+	u32 fifo_size;
+
+	fifo_size = fxgmac_calculate_per_queue_fifo(priv->hw_feat.tx_fifo_size,
+						    FXGMAC_TX_1_Q);
+	fxgmac_mtl_wr_bits(priv, 0, MTL_Q_TQOMR, MTL_Q_TQOMR_TQS, fifo_size);
+}
+
+static void fxgmac_config_rx_fifo_size(struct fxgmac_pdata *priv)
+{
+	u32 fifo_size;
+
+	fifo_size = fxgmac_calculate_per_queue_fifo(priv->hw_feat.rx_fifo_size,
+						    priv->rx_q_count);
+
+	for (u32 i = 0; i < priv->rx_q_count; i++)
+		fxgmac_mtl_wr_bits(priv, i, MTL_Q_RQOMR, MTL_Q_RQOMR_RQS,
+				   fifo_size);
+}
+
+static void fxgmac_config_flow_control_threshold(struct fxgmac_pdata *priv)
+{
+	for (u32 i = 0; i < priv->rx_q_count; i++) {
+		/* Activate flow control when less than 4k left in fifo */
+		fxgmac_mtl_wr_bits(priv, i, MTL_Q_RQOMR, MTL_Q_RQOMR_RFA, 6);
+		/* De-activate flow control when more than 6k left in fifo */
+		fxgmac_mtl_wr_bits(priv, i, MTL_Q_RQOMR, MTL_Q_RQOMR_RFD, 10);
+	}
+}
+
+static void fxgmac_config_tx_threshold(struct fxgmac_pdata *priv,
+				       unsigned int set_val)
+{
+	fxgmac_mtl_wr_bits(priv, 0, MTL_Q_TQOMR, MTL_Q_TQOMR_TTC, set_val);
+}
+
+static void fxgmac_config_rsf_mode(struct fxgmac_pdata *priv,
+				   unsigned int set_val)
+{
+	for (u32 i = 0; i < priv->rx_q_count; i++)
+		fxgmac_mtl_wr_bits(priv, i, MTL_Q_RQOMR, MTL_Q_RQOMR_RSF,
+				   set_val);
+}
+
+static void fxgmac_config_tsf_mode(struct fxgmac_pdata *priv,
+				   unsigned int set_val)
+{
+	fxgmac_mtl_wr_bits(priv, 0, MTL_Q_TQOMR, MTL_Q_TQOMR_TSF, set_val);
+}
+
+static void fxgmac_config_osp_mode(struct fxgmac_pdata *priv)
+{
+	fxgmac_dma_wr_bits(priv->channel_head, DMA_CH_TCR, DMA_CH_TCR_OSP,
+			   priv->tx_osp_mode);
+}
+
+static void fxgmac_config_pblx8(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		fxgmac_dma_wr_bits(channel, DMA_CH_CR, DMA_CH_CR_PBLX8,
+				   priv->pblx8);
+}
+
+static void fxgmac_config_tx_pbl_val(struct fxgmac_pdata *priv)
+{
+	fxgmac_dma_wr_bits(priv->channel_head, DMA_CH_TCR, DMA_CH_TCR_PBL,
+			   priv->tx_pbl);
+}
+
+static void fxgmac_config_rx_pbl_val(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		fxgmac_dma_wr_bits(channel, DMA_CH_RCR, DMA_CH_RCR_PBL,
+				   priv->rx_pbl);
+}
+
+static void fxgmac_config_mmc(struct fxgmac_pdata *priv)
+{
+	/* Set counters to reset on read, Reset the counters */
+	fxgmac_io_wr_bits(priv, MMC_CR, MMC_CR_ROR, 1);
+	fxgmac_io_wr_bits(priv, MMC_CR, MMC_CR_CR, 1);
+
+	fxgmac_io_wr(priv, MMC_IPC_RXINT_MASK, 0xffffffff);
+}
+
 static void fxgmac_enable_dma_interrupts(struct fxgmac_pdata *priv)
 {
 	struct fxgmac_channel *channel = priv->channel_head;
@@ -514,6 +833,233 @@ static void fxgmac_enable_dma_interrupts(struct fxgmac_pdata *priv)
 	}
 }
 
+static void fxgmac_enable_mtl_interrupts(struct fxgmac_pdata *priv)
+{
+	unsigned int mtl_q_isr;
+
+	for (u32 i = 0; i < priv->hw_feat.rx_q_cnt; i++) {
+		/* Clear all the interrupts which are set */
+		mtl_q_isr = fxgmac_mtl_io_rd(priv, i, MTL_Q_IR);
+		fxgmac_mtl_io_wr(priv, i, MTL_Q_IR, mtl_q_isr);
+
+		/* No MTL interrupts to be enabled */
+		fxgmac_mtl_io_wr(priv, i, MTL_Q_IR, 0);
+	}
+}
+
+static void fxgmac_enable_mac_interrupts(struct fxgmac_pdata *priv)
+{
+	/* Disable Timestamp interrupt */
+	fxgmac_io_wr_bits(priv, MAC_IER, MAC_IER_TSIE, 0);
+
+	fxgmac_io_wr_bits(priv, MMC_RIER, MMC_RIER_ALL_INTERRUPTS, 0);
+	fxgmac_io_wr_bits(priv, MMC_TIER, MMC_TIER_ALL_INTERRUPTS, 0);
+}
+
+static int fxgmac_flush_tx_queues(struct fxgmac_pdata *priv)
+{
+	u32 val, count = 2000;
+
+	fxgmac_mtl_wr_bits(priv, 0, MTL_Q_TQOMR, MTL_Q_TQOMR_FTQ, 1);
+	do {
+		fsleep(20);
+		val = fxgmac_mtl_io_rd(priv, 0, MTL_Q_TQOMR);
+		val = FIELD_GET(MTL_Q_TQOMR_FTQ, val);
+
+	} while (--count && val);
+
+	if (val)
+		return -EBUSY;
+
+	return 0;
+}
+
+static void fxgmac_config_dma_bus(struct fxgmac_pdata *priv)
+{
+	u32 val = fxgmac_io_rd(priv, DMA_SBMR);
+
+	val &= ~(DMA_SBMR_EAME | DMA_SBMR_RD_OSR_LMT |
+		 DMA_SBMR_WR_OSR_LMT | DMA_SBMR_FB);
+
+	/* Set enhanced addressing mode */
+	val |= DMA_SBMR_EAME;
+
+	/* Out standing read/write requests */
+	val |= FIELD_PREP(DMA_SBMR_RD_OSR_LMT, 0x7);
+	val |= FIELD_PREP(DMA_SBMR_WR_OSR_LMT, 0x7);
+
+	/* Set the System Bus mode */
+	val |= (DMA_SBMR_BLEN_4 | DMA_SBMR_BLEN_8 |
+		DMA_SBMR_BLEN_16 | DMA_SBMR_BLEN_32);
+
+	fxgmac_io_wr(priv, DMA_SBMR, val);
+}
+
+static void fxgmac_desc_rx_channel_init(struct fxgmac_channel *channel)
+{
+	struct fxgmac_ring *ring = channel->rx_ring;
+	unsigned int start_index = ring->cur;
+	struct fxgmac_desc_data *desc_data;
+
+	/* Initialize all descriptors */
+	for (u32 i = 0; i < ring->dma_desc_count; i++) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, i);
+		fxgmac_desc_rx_reset(desc_data); /* Initialize Rx descriptor */
+	}
+
+	/* Update the total number of Rx descriptors */
+	fxgmac_dma_io_wr(channel, DMA_CH_RDRLR, ring->dma_desc_count - 1);
+
+	/* Update the starting address of descriptor ring */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, start_index);
+
+	fxgmac_dma_io_wr(channel, DMA_CH_RDLR_HI,
+			 upper_32_bits(desc_data->dma_desc_addr));
+	fxgmac_dma_io_wr(channel, DMA_CH_RDLR_LO,
+			 lower_32_bits(desc_data->dma_desc_addr));
+
+	/* Update the Rx Descriptor Tail Pointer */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, start_index +
+					 ring->dma_desc_count - 1);
+	fxgmac_dma_io_wr(channel, DMA_CH_RDTR_LO,
+			 lower_32_bits(desc_data->dma_desc_addr));
+}
+
+static void fxgmac_desc_rx_init(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	dma_addr_t dma_desc_addr;
+	struct fxgmac_ring *ring;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++) {
+		ring = channel->rx_ring;
+		dma_desc = ring->dma_desc_head;
+		dma_desc_addr = ring->dma_desc_head_addr;
+
+		for (u32 j = 0; j < ring->dma_desc_count; j++) {
+			desc_data = FXGMAC_GET_DESC_DATA(ring, j);
+			desc_data->dma_desc = dma_desc;
+			desc_data->dma_desc_addr = dma_desc_addr;
+			if (fxgmac_rx_buffe_map(priv, ring, desc_data))
+				break;
+
+			dma_desc++;
+			dma_desc_addr += sizeof(struct fxgmac_dma_desc);
+		}
+
+		ring->cur = 0;
+		ring->dirty = 0;
+
+		fxgmac_desc_rx_channel_init(channel);
+	}
+}
+
+static void fxgmac_desc_tx_channel_init(struct fxgmac_channel *channel)
+{
+	struct fxgmac_ring *ring = channel->tx_ring;
+	struct fxgmac_desc_data *desc_data;
+	int start_index = ring->cur;
+
+	/* Initialize all descriptors */
+	for (u32 i = 0; i < ring->dma_desc_count; i++) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, i);
+		fxgmac_desc_tx_reset(desc_data); /* Initialize Tx descriptor */
+	}
+
+	/* Update the total number of Tx descriptors */
+	fxgmac_dma_io_wr(channel, DMA_CH_TDRLR,
+			 channel->priv->tx_desc_count - 1);
+
+	/* Update the starting address of descriptor ring */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, start_index);
+
+	fxgmac_dma_io_wr(channel, DMA_CH_TDLR_HI,
+			 upper_32_bits(desc_data->dma_desc_addr));
+	fxgmac_dma_io_wr(channel, DMA_CH_TDLR_LO,
+			 lower_32_bits(desc_data->dma_desc_addr));
+}
+
+static void fxgmac_desc_tx_init(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	struct fxgmac_ring *ring = channel->tx_ring;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	dma_addr_t dma_desc_addr;
+
+	dma_desc = ring->dma_desc_head;
+	dma_desc_addr = ring->dma_desc_head_addr;
+
+	for (u32 j = 0; j < ring->dma_desc_count; j++) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, j);
+		desc_data->dma_desc = dma_desc;
+		desc_data->dma_desc_addr = dma_desc_addr;
+
+		dma_desc++;
+		dma_desc_addr += sizeof(struct fxgmac_dma_desc);
+	}
+
+	ring->cur = 0;
+	ring->dirty = 0;
+	memset(&ring->tx, 0, sizeof(ring->tx));
+	fxgmac_desc_tx_channel_init(priv->channel_head);
+}
+
+static int fxgmac_hw_init(struct fxgmac_pdata *priv)
+{
+	int ret;
+
+	ret = fxgmac_flush_tx_queues(priv); /* Flush Tx queues */
+	if (ret < 0) {
+		dev_err(priv->dev, "%s, flush tx queue failed:%d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	/* Initialize DMA related features */
+	fxgmac_config_dma_bus(priv);
+	fxgmac_config_osp_mode(priv);
+	fxgmac_config_pblx8(priv);
+	fxgmac_config_tx_pbl_val(priv);
+	fxgmac_config_rx_pbl_val(priv);
+	fxgmac_config_rx_coalesce(priv);
+	fxgmac_config_rx_buffer_size(priv);
+	fxgmac_config_tso_mode(priv);
+	fxgmac_config_sph_mode(priv);
+	fxgmac_desc_tx_init(priv);
+	fxgmac_desc_rx_init(priv);
+	fxgmac_enable_dma_interrupts(priv);
+
+	/* Initialize MTL related features */
+	fxgmac_config_mtl_mode(priv);
+	fxgmac_config_queue_mapping(priv);
+	fxgmac_config_tsf_mode(priv, priv->tx_sf_mode);
+	fxgmac_config_rsf_mode(priv, priv->rx_sf_mode);
+	fxgmac_config_tx_threshold(priv, priv->tx_threshold);
+	fxgmac_config_rx_threshold(priv, priv->rx_threshold);
+	fxgmac_config_tx_fifo_size(priv);
+	fxgmac_config_rx_fifo_size(priv);
+	fxgmac_config_flow_control_threshold(priv);
+	fxgmac_config_rx_fep_disable(priv);
+	fxgmac_config_rx_fup_enable(priv);
+	fxgmac_enable_mtl_interrupts(priv);
+
+	/* Initialize MAC related features */
+	fxgmac_config_mac_address(priv);
+	fxgmac_config_crc_check_en(priv);
+	fxgmac_config_rx_mode(priv);
+	fxgmac_config_tx_flow_control(priv);
+	fxgmac_config_rx_flow_control(priv);
+	fxgmac_config_mac_speed(priv);
+	fxgmac_config_checksum_offload(priv);
+	fxgmac_config_mmc(priv);
+	fxgmac_enable_mac_interrupts(priv);
+
+	return 0;
+}
+
 static void fxgmac_dismiss_all_int(struct fxgmac_pdata *priv)
 {
 	struct fxgmac_channel *channel = priv->channel_head;
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
index 4afc6d4cd..4702ed1dc 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
@@ -134,6 +134,33 @@
 #define MAC_CR_IPC			BIT(27)
 #define MAC_CR_ARPEN			BIT(31)
 
+#define MAC_ECR				0x2004
+#define MAC_ECR_DCRCC			BIT(16)
+#define MAC_ECR_HDSMS			GENMASK(22, 20)
+#define  MAC_ECR_HDSMS_64B		0
+#define  MAC_ECR_HDSMS_128B		1
+#define  MAC_ECR_HDSMS_256B		2
+#define  MAC_ECR_HDSMS_512B		3
+#define  MAC_ECR_HDSMS_1023B		4
+
+#define MAC_PFR				0x3008
+#define MAC_PFR_PR			BIT(0) /*  Promiscuous Mode. */
+#define MAC_PFR_HUC			BIT(1) /*  Hash Unicast Mode. */
+#define MAC_PFR_HMC			BIT(2)
+#define MAC_PFR_PM			BIT(4) /* Pass all Multicast. */
+#define MAC_PFR_DBF			BIT(5) /* Disable Broadcast Packets. */
+#define MAC_PFR_HPF			BIT(10)
+#define MAC_PFR_VTFE			BIT(16)
+
+#define MAC_Q0TFCR			0x2070
+#define MAC_Q0TFCR_TFE			BIT(1)
+#define MAC_Q0TFCR_PT			GENMASK(31, 16)
+
+#define MAC_RFCR			0x2090
+#define MAC_RFCR_RFE			BIT(0)
+#define MAC_RFCR_UP			BIT(1)
+#define MAC_RFCR_PFCE			BIT(8)
+
 #define MAC_RQC0R			0x20a0
 #define MAC_RQC1R			0x20a4
 #define MAC_RQC2R			0x20a8
@@ -230,6 +257,60 @@
 #define MAC_MDIO_DATA_GD		GENMASK(15, 0)
 #define MAC_MDIO_DATA_RA		GENMASK(31, 16)
 
+#define MAC_GPIO_CR			0x2208
+#define MAC_GPIO_SR			0x220c
+#define MAC_ARP_PROTO_ADDR		0x2210
+#define MAC_CSR_SW_CTRL			0x2230
+#define MAC_MACA0HR			0x2300
+#define MAC_MACA0LR			0x2304
+#define MAC_MACA1HR			0x2308
+#define MAC_MACA1LR			0x230c
+
+/* MMC registers */
+#define MMC_CR				0x2700
+#define MMC_CR_CR			BIT(0)
+#define MMC_CR_CSR			BIT(1)
+#define MMC_CR_ROR			BIT(2)
+#define MMC_CR_MCF			BIT(3)
+
+#define MMC_RISR			0x2704
+#define MMC_TISR			0x2708
+
+#define MMC_RIER			0x270c
+#define MMC_RIER_ALL_INTERRUPTS		GENMASK(27, 0)
+
+#define MMC_TIER			0x2710
+#define MMC_TIER_ALL_INTERRUPTS		GENMASK(27, 0)
+
+#define MMC_IPC_RXINT_MASK		0x2800
+#define MMC_IPC_RXINT			0x2808
+
+/* MTL registers */
+#define MTL_OMR				0x2c00
+#define MTL_OMR_RAA			BIT(2)
+#define MTL_OMR_ETSALG			GENMASK(6, 5)
+
+#define MTL_FDCR			0x2c08
+#define MTL_FDSR			0x2c0c
+#define MTL_FDDR			0x2c10
+#define MTL_INT_SR			0x2c20
+
+#define MTL_RQDCM_INC			4
+#define MTL_RQDCM_Q_PER_REG		4
+
+#define MTL_RQDCM0R			0x2c30
+#define MTL_RQDCM0R_Q0MDMACH		0x0
+#define MTL_RQDCM0R_Q1MDMACH		0x00000100
+#define MTL_RQDCM0R_Q2MDMACH		0x00020000
+#define MTL_RQDCM0R_Q3MDMACH		0x03000000
+
+#define MTL_ECC_INT_SR			0x2ccc
+
+#define MTL_RQDCM1R_Q4MDMACH		0x00000004
+#define MTL_RQDCM1R_Q5MDMACH		0x00000500
+#define MTL_RQDCM1R_Q6MDMACH		0x00060000
+#define MTL_RQDCM1R_Q7MDMACH		0x07000000
+
 /* MTL queue registers */
 #define MTL_Q_BASE			0x2d00
 #define MTL_Q_INC			0x40
@@ -242,11 +323,69 @@
 #define MTL_Q_EN_IF_AV			0x01
 #define MTL_Q_ENABLED			0x02
 
+#define MTL_Q_TQOMR_TTC			GENMASK(6, 4)
+#define  MTL_Q_TQOMR_TTC_THRESHOLD_32	0x00
+#define  MTL_Q_TQOMR_TTC_THRESHOLD_64	0x01
+#define  MTL_Q_TQOMR_TTC_THRESHOLD_96	0x02
+#define  MTL_Q_TQOMR_TTC_THRESHOLD_128	0x03
+#define  MTL_Q_TQOMR_TTC_THRESHOLD_192	0x04
+#define  MTL_Q_TQOMR_TTC_THRESHOLD_256	0x05
+#define  MTL_Q_TQOMR_TTC_THRESHOLD_384	0x06
+#define  MTL_Q_TQOMR_TTC_THRESHOLD_512	0x07
+
+#define MTL_Q_TQOMR_TQS			GENMASK(22, 16)
+
+#define MTL_Q_TQUR			0x04
+#define MTL_Q_TXDEG			0x08 /* Transmit debug */
 #define MTL_Q_IR			0x2c /* Interrupt control status */
+
+#define MTL_Q_RQOMR			0x30
+#define MTL_Q_RQOMR_RTC			GENMASK(1, 0)
+#define  MTL_Q_RQOMR_RTC_THRESHOLD_64	0x00
+#define  MTL_Q_RQOMR_RTC_THRESHOLD_32	0x01
+#define  MTL_Q_RQOMR_RTC_THRESHOLD_96	0x02
+#define  MTL_Q_RQOMR_RTC_THRESHOLD_128	0x03
+
+#define MTL_Q_RQOMR_FUP			BIT(3)
+#define MTL_Q_RQOMR_FEP			BIT(4)
+#define MTL_Q_RQOMR_RSF			BIT(5)
+#define MTL_Q_RQOMR_EHFC		BIT(7)
+#define MTL_Q_RQOMR_RFA			GENMASK(13, 8)
+#define MTL_Q_RQOMR_RFD			GENMASK(19, 14)
+#define MTL_Q_RQOMR_RQS			GENMASK(28, 20)
+
+#define MTL_Q_RQMPOCR			0x34
+
 #define MTL_Q_RQDR			0x38
 #define MTL_Q_RQDR_RXQSTS		GENMASK(5, 4)
 #define MTL_Q_RQDR_PRXQ			GENMASK(29, 16)
 
+#define MTL_Q_RQCR			0x3c
+
+/* MTL queue registers */
+#define MTL_ETSALG_WRR				0x00
+#define MTL_ETSALG_WFQ				0x01
+#define MTL_ETSALG_DWRR				0x02
+#define MTL_ETSALG_SP				0x03
+
+#define MTL_RAA_SP				0x00
+#define MTL_RAA_WSP				0x01
+
+/* MTL traffic class registers */
+#define MTL_TC_BASE				MTL_Q_BASE
+#define MTL_TC_INC				MTL_Q_INC
+
+#define MTL_TC_TQDR				0x08
+#define MTL_TC_TQDR_TRCSTS			GENMASK(2, 1)
+#define MTL_TC_TQDR_TXQSTS			BIT(4)
+
+#define MTL_TC_ETSCR				0x10
+#define MTL_TC_ETSCR_TSA			GENMASK(1, 0)
+
+#define MTL_TC_ETSSR				0x14
+#define MTL_TC_QWR				0x18
+#define MTL_TC_QWR_QW				GENMASK(20, 0)
+
 /* DMA registers */
 #define DMA_MR					0x3000
 #define DMA_MR_SWR				BIT(0)
@@ -256,16 +395,50 @@
 #define DMA_MR_TNDF				GENMASK(21, 20)
 #define DMA_MR_RNDF				GENMASK(23, 22)
 
+#define DMA_SBMR				0x3004
+#define DMA_SBMR_FB				BIT(0)
+#define DMA_SBMR_BLEN_4				BIT(1)
+#define DMA_SBMR_BLEN_8				BIT(2)
+#define DMA_SBMR_BLEN_16			BIT(3)
+#define DMA_SBMR_BLEN_32			BIT(4)
+#define DMA_SBMR_BLEN_64			BIT(5)
+#define DMA_SBMR_BLEN_128			BIT(6)
+#define DMA_SBMR_BLEN_256			BIT(7)
+#define DMA_SBMR_AALE				BIT(10)
+#define DMA_SBMR_EAME				BIT(11)
+#define DMA_SBMR_AAL				BIT(12)
+#define DMA_SBMR_RD_OSR_LMT			GENMASK(23, 16)
+#define DMA_SBMR_WR_OSR_LMT			GENMASK(29, 24)
+#define DMA_SBMR_LPI_XIT_PKT			BIT(30)
+#define DMA_SBMR_EN_LPI				BIT(31)
+
+#define DMA_ISR					0x3008
+#define DMA_ISR_MTLIS				BIT(16)
+#define DMA_ISR_MACIS				BIT(17)
+
 #define DMA_DSRX_INC				4
 #define DMA_DSR0				0x300c
 #define DMA_DSR0_TPS				GENMASK(15, 12)
 #define  DMA_TPS_STOPPED			0x00
 #define  DMA_TPS_SUSPENDED			0x06
 
+#define DMA_DSR1				0x3010
+#define DMA_DSR2				0x3014
+#define DMA_AXIARCR				0x3020
+#define DMA_AXIAWCR				0x3024
+#define DMA_AXIAWRCR				0x3028
+#define DMA_SAFE_ISR				0x3080
+#define DMA_ECC_IE				0x3084
+#define DMA_ECC_INT_SR				0x3088
+
 /* DMA channel registers */
 #define DMA_CH_BASE			0x3100
 #define DMA_CH_INC			0x80
 
+#define DMA_CH_CR			0x00
+#define DMA_CH_CR_PBLX8			BIT(16)
+#define DMA_CH_CR_SPH			BIT(24)
+
 #define DMA_CH_TCR			0x04
 #define DMA_CH_TCR_ST			BIT(0)
 #define DMA_CH_TCR_OSP			BIT(4)
@@ -286,6 +459,15 @@
 #define DMA_CH_RCR_RBSZ			GENMASK(14, 1)
 #define DMA_CH_RCR_PBL			GENMASK(21, 16)
 
+#define DMA_CH_TDLR_HI			0x10
+#define DMA_CH_TDLR_LO			0x14
+#define DMA_CH_RDLR_HI			0x18
+#define DMA_CH_RDLR_LO			0x1c
+#define DMA_CH_TDTR_LO			0x20
+#define DMA_CH_RDTR_LO			0x28
+#define DMA_CH_TDRLR			0x2c
+#define DMA_CH_RDRLR			0x30
+
 #define DMA_CH_IER			0x34
 #define DMA_CH_IER_TIE			BIT(0)
 #define DMA_CH_IER_TXSE			BIT(1)
@@ -297,6 +479,16 @@
 #define DMA_CH_IER_AIE			BIT(14)
 #define DMA_CH_IER_NIE			BIT(15)
 
+#define DMA_CH_RIWT			0x38
+#define DMA_CH_RIWT_RWT			GENMASK(7, 0)
+
+#define DMA_CH_CATDR_LO			0x44
+#define DMA_CH_CARDR_LO			0x4c
+#define DMA_CH_CATBR_HI			0x50
+#define DMA_CH_CATBR_LO			0x54
+#define DMA_CH_CARBR_HI			0x58
+#define DMA_CH_CARBR_LO			0x5c
+
 #define DMA_CH_SR			0x60
 #define DMA_CH_SR_TI			BIT(0)
 #define DMA_CH_SR_TPS			BIT(1)
@@ -558,6 +750,7 @@ struct fxgmac_pdata {
 
 	/* ndev related settings */
 	unsigned char mac_addr[ETH_ALEN];
+	struct napi_struct napi;
 
 	int mac_speed;
 	int mac_duplex;
-- 
2.34.1


