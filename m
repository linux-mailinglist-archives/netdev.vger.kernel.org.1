Return-Path: <netdev+bounces-170639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67E7A496A2
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B62516C27E
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5AF260386;
	Fri, 28 Feb 2025 10:06:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3A25FA0F;
	Fri, 28 Feb 2025 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737163; cv=none; b=OpCYdoT0X+Ub2T5vdPP7K9juonfw9K/NCobmbIqF3AyWRlOvdnaEhlR18PhBg6N2bPO5dgEDjKLAoCU3aezJ5zUwGseXb0nHaSnZQ36vk/IemahoQW2kSb6wp4cfalVh3x3FP4OXKi5+LlJUA9qUfzFBz+Ck2KkBoy4Fvs2tznU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737163; c=relaxed/simple;
	bh=P7l5rykwGlDfGBGU84JonmUkeDiNrYF6Fhqrik6jU90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RijAkHhjmgqUomKuwDUnvlJQ8OLrEAUpby3CCBkrwUwg8A7V/bCu1Y3Dtn0aWCqqaCoxifnIIWW6R2gqKQjZ5J/uyt1PaP+wPd3c6Oy45h2lONTfgoMNg9Cb5ZG4Zgb0cBpE2ql7n6oFFdzR4BeFAxiuFEi5GM2vsgptVUAkT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn1Hw_1740736837 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:38 +0800
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
Subject: [PATCH net-next v3 08/14] motorcomm:yt6801: Implement the fxgmac_hw_init function
Date: Fri, 28 Feb 2025 18:00:14 +0800
Message-Id: <20250228100020.3944-9-Frank.Sae@motor-comm.com>
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

Implement some hardware init functions to set default hardware
 settings, including PHY control, Vlan related config, RX coalescing,
 and other basic function control.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 537 ++++++++++++++++++
 1 file changed, 537 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index 1918cb550..14c59cece 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -490,6 +490,319 @@ static void fxgmac_enable_msix_irqs(struct fxgmac_pdata *priv)
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
+	FXGMAC_MAC_IO_WR(priv, MAC_MACA0LR, mac_lo);
+	FXGMAC_MAC_IO_WR(priv, MAC_MACA0HR, mac_hi);
+}
+
+static void fxgmac_config_mac_address(struct fxgmac_pdata *priv)
+{
+	__fxgmac_set_mac_address(priv, priv->mac_addr);
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_PFR, HPF, 1);
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_PFR, HUC, 1);
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_PFR, HMC, 1);
+}
+
+static void fxgmac_config_crc_check_en(struct fxgmac_pdata *priv)
+{
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_ECR, DCRCC, 1);
+}
+
+static void fxgmac_config_checksum_offload(struct fxgmac_pdata *priv)
+{
+	if (priv->netdev->features & NETIF_F_RXCSUM)
+		FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, IPC, 1);
+	else
+		FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, IPC, 0);
+}
+
+static void fxgmac_set_promiscuous_mode(struct fxgmac_pdata *priv,
+					unsigned int enable)
+{
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_PFR, PR, enable);
+}
+
+static void fxgmac_enable_rx_broadcast(struct fxgmac_pdata *priv,
+				       unsigned int enable)
+{
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_PFR, DBF, enable);
+}
+
+static void fxgmac_set_all_multicast_mode(struct fxgmac_pdata *priv,
+					  unsigned int enable)
+{
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_PFR, PM, enable);
+}
+
+static void fxgmac_config_rx_mode(struct fxgmac_pdata *priv)
+{
+	u32 pr_mode, am_mode, bd_mode;
+
+	pr_mode = ((priv->netdev->flags & IFF_PROMISC) != 0);
+	am_mode = ((priv->netdev->flags & IFF_ALLMULTI) != 0);
+	bd_mode = ((priv->netdev->flags & IFF_BROADCAST) != 0);
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
+		FXGMAC_MTL_IO_WR_BITS(priv, i, MTL_Q_RQOMR, EHFC,
+				      priv->tx_pause);
+
+	/* Set MAC flow control */
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_Q0TFCR, TFE, priv->tx_pause);
+
+	if (priv->tx_pause == 1) /* Set pause time */
+		FXGMAC_MAC_IO_WR_BITS(priv, MAC_Q0TFCR, PT, 0xffff);
+}
+
+static void fxgmac_config_rx_flow_control(struct fxgmac_pdata *priv)
+{
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_RFCR, RFE, priv->rx_pause);
+}
+
+static void fxgmac_config_rx_coalesce(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+		FXGMAC_DMA_IO_WR_BITS(channel, DMA_CH_RIWT, RWT, priv->rx_riwt);
+	}
+}
+
+static void fxgmac_config_rx_fep_disable(struct fxgmac_pdata *priv)
+{
+	/* Enable the rx queue forward packet with error status
+	 * (crc error,gmii_er, watch dog timeout.or overflow)
+	 */
+	for (u32 i = 0; i < priv->rx_q_count; i++)
+		FXGMAC_MTL_IO_WR_BITS(priv, i, MTL_Q_RQOMR, FEP, 1);
+}
+
+static void fxgmac_config_rx_fup_enable(struct fxgmac_pdata *priv)
+{
+	for (u32 i = 0; i < priv->rx_q_count; i++)
+		FXGMAC_MTL_IO_WR_BITS(priv, i, MTL_Q_RQOMR, FUP, 1);
+}
+
+static void fxgmac_config_rx_buffer_size(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		FXGMAC_DMA_IO_WR_BITS(channel, DMA_CH_RCR, RBSZ,
+				      priv->rx_buf_size);
+}
+
+static void fxgmac_config_tso_mode(struct fxgmac_pdata *priv)
+{
+	FXGMAC_DMA_IO_WR_BITS(priv->channel_head, DMA_CH_TCR, TSE,
+			      priv->hw_feat.tso);
+}
+
+static void fxgmac_config_sph_mode(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		FXGMAC_DMA_IO_WR_BITS(channel, DMA_CH_CR, SPH, 0);
+
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_ECR, HDSMS, MAC_ECR_HDSMS_512B);
+}
+
+static void fxgmac_config_rx_threshold(struct fxgmac_pdata *priv,
+				       unsigned int set_val)
+{
+	for (u32 i = 0; i < priv->rx_q_count; i++)
+		FXGMAC_MTL_IO_WR_BITS(priv, i, MTL_Q_RQOMR, RTC, set_val);
+}
+
+static void fxgmac_config_mtl_mode(struct fxgmac_pdata *priv)
+{
+	/* Set Tx to weighted round robin scheduling algorithm */
+	FXGMAC_MAC_IO_WR_BITS(priv, MTL_OMR, ETSALG, MTL_ETSALG_WRR);
+
+	/* Set Tx traffic classes to use WRR algorithm with equal weights */
+	FXGMAC_MTL_IO_WR_BITS(priv, 0, MTL_TC_QWR, QW, 1);
+
+	/* Set Rx to strict priority algorithm */
+	FXGMAC_MAC_IO_WR_BITS(priv, MTL_OMR, RAA, MTL_RAA_SP);
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
+		FXGMAC_MAC_IO_WR(priv, reg, val);
+		reg += MAC_RQC2_INC;
+	}
+
+	/* Configure one to one, MTL Rx queue to DMA Rx channel mapping
+	 * ie Q0 <--> CH0, Q1 <--> CH1 ... Q7 <--> CH7
+	 */
+	val = FXGMAC_MAC_IO_RD(priv, MTL_RQDCM0R);
+	val |= (MTL_RQDCM0R_Q0MDMACH | MTL_RQDCM0R_Q1MDMACH |
+		MTL_RQDCM0R_Q2MDMACH | MTL_RQDCM0R_Q3MDMACH);
+	FXGMAC_MAC_IO_WR(priv, MTL_RQDCM0R, val);
+
+	val = FXGMAC_MAC_IO_RD(priv, MTL_RQDCM0R + MTL_RQDCM_INC);
+	val |= (MTL_RQDCM1R_Q4MDMACH | MTL_RQDCM1R_Q5MDMACH |
+		MTL_RQDCM1R_Q6MDMACH | MTL_RQDCM1R_Q7MDMACH);
+	FXGMAC_MAC_IO_WR(priv, MTL_RQDCM0R + MTL_RQDCM_INC, val);
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
+	FXGMAC_MTL_IO_WR_BITS(priv, 0, MTL_Q_TQOMR, TQS, fifo_size);
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
+		FXGMAC_MTL_IO_WR_BITS(priv, i, MTL_Q_RQOMR, RQS, fifo_size);
+}
+
+static void fxgmac_config_flow_control_threshold(struct fxgmac_pdata *priv)
+{
+	for (u32 i = 0; i < priv->rx_q_count; i++) {
+		/* Activate flow control when less than 4k left in fifo */
+		FXGMAC_MTL_IO_WR_BITS(priv, i, MTL_Q_RQOMR, RFA, 6);
+		/* De-activate flow control when more than 6k left in fifo */
+		FXGMAC_MTL_IO_WR_BITS(priv, i, MTL_Q_RQOMR, RFD, 10);
+	}
+}
+
+static void fxgmac_config_tx_threshold(struct fxgmac_pdata *priv,
+				       unsigned int set_val)
+{
+	FXGMAC_MTL_IO_WR_BITS(priv, 0, MTL_Q_TQOMR, TTC, set_val);
+}
+
+static void fxgmac_config_rsf_mode(struct fxgmac_pdata *priv,
+				   unsigned int set_val)
+{
+	for (u32 i = 0; i < priv->rx_q_count; i++)
+		FXGMAC_MTL_IO_WR_BITS(priv, i, MTL_Q_RQOMR, RSF, set_val);
+}
+
+static void fxgmac_config_tsf_mode(struct fxgmac_pdata *priv,
+				   unsigned int set_val)
+{
+	FXGMAC_MTL_IO_WR_BITS(priv, 0, MTL_Q_TQOMR, TSF, set_val);
+}
+
+static void fxgmac_config_osp_mode(struct fxgmac_pdata *priv)
+{
+	FXGMAC_DMA_IO_WR_BITS(priv->channel_head, DMA_CH_TCR, OSP,
+			      priv->tx_osp_mode);
+}
+
+static void fxgmac_config_pblx8(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		FXGMAC_DMA_IO_WR_BITS(channel, DMA_CH_CR, PBLX8, priv->pblx8);
+}
+
+static void fxgmac_config_tx_pbl_val(struct fxgmac_pdata *priv)
+{
+	FXGMAC_DMA_IO_WR_BITS(priv->channel_head, DMA_CH_TCR, PBL,
+			      priv->tx_pbl);
+}
+
+static void fxgmac_config_rx_pbl_val(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		FXGMAC_DMA_IO_WR_BITS(channel, DMA_CH_RCR, PBL, priv->rx_pbl);
+}
+
+static void fxgmac_config_mmc(struct fxgmac_pdata *priv)
+{
+	/* Set counters to reset on read, Reset the counters */
+	FXGMAC_MAC_IO_WR_BITS(priv, MMC_CR, ROR, 1);
+	FXGMAC_MAC_IO_WR_BITS(priv, MMC_CR, CR, 1);
+
+	FXGMAC_MAC_IO_WR(priv, MMC_IPC_RXINT_MASK, 0xffffffff);
+}
+
 static void fxgmac_enable_dma_interrupts(struct fxgmac_pdata *priv)
 {
 	struct fxgmac_channel *channel = priv->channel_head;
@@ -523,6 +836,230 @@ static void fxgmac_enable_dma_interrupts(struct fxgmac_pdata *priv)
 	}
 }
 
+static void fxgmac_enable_mtl_interrupts(struct fxgmac_pdata *priv)
+{
+	unsigned int mtl_q_isr;
+
+	for (u32 i = 0; i < priv->hw_feat.rx_q_cnt; i++) {
+		/* Clear all the interrupts which are set */
+		mtl_q_isr = FXGMAC_MTL_IO_RD(priv, i, MTL_Q_ISR);
+		FXGMAC_MTL_IO_WR(priv, i, MTL_Q_ISR, mtl_q_isr);
+
+		/* No MTL interrupts to be enabled */
+		FXGMAC_MTL_IO_WR(priv, i, MTL_Q_IER, 0);
+	}
+}
+
+static void fxgmac_enable_mac_interrupts(struct fxgmac_pdata *priv)
+{
+	/* Disable Timestamp interrupt */
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_IER, TSIE, 0);
+
+	FXGMAC_MAC_IO_WR_BITS(priv, MMC_RIER, ALL_INTERRUPTS, 0);
+	FXGMAC_MAC_IO_WR_BITS(priv, MMC_TIER, ALL_INTERRUPTS, 0);
+}
+
+static int fxgmac_flush_tx_queues(struct fxgmac_pdata *priv)
+{
+	u32 val, count = 2000;
+
+	FXGMAC_MTL_IO_WR_BITS(priv, 0, MTL_Q_TQOMR, FTQ, 1);
+	do {
+		fsleep(20);
+		val = FXGMAC_MTL_IO_RD(priv, 0, MTL_Q_TQOMR);
+		val = FXGMAC_GET_BITS(val, MTL_Q_TQOMR, FTQ);
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
+	u32 val = FXGMAC_MAC_IO_RD(priv, DMA_SBMR);
+
+	/* Set enhanced addressing mode */
+	FXGMAC_SET_BITS(val, DMA_SBMR, EAME, 1);
+
+	/* Out standing read/write requests */
+	FXGMAC_SET_BITS(val, DMA_SBMR, RD_OSR_LMT, 0x7);
+	FXGMAC_SET_BITS(val, DMA_SBMR, WR_OSR_LMT, 0x7);
+
+	/* Set the System Bus mode */
+	FXGMAC_SET_BITS(val, DMA_SBMR, FB, 0);
+	FXGMAC_SET_BITS(val, DMA_SBMR, BLEN_4, 1);
+	FXGMAC_SET_BITS(val, DMA_SBMR, BLEN_8, 1);
+	FXGMAC_SET_BITS(val, DMA_SBMR, BLEN_16, 1);
+	FXGMAC_SET_BITS(val, DMA_SBMR, BLEN_32, 1);
+
+	FXGMAC_MAC_IO_WR(priv, DMA_SBMR, val);
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
+	FXGMAC_DMA_IO_WR(channel, DMA_CH_RDRLR, ring->dma_desc_count - 1);
+
+	/* Update the starting address of descriptor ring */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, start_index);
+	FXGMAC_DMA_IO_WR(channel, DMA_CH_RDLR_HI,
+			 upper_32_bits(desc_data->dma_desc_addr));
+	FXGMAC_DMA_IO_WR(channel, DMA_CH_RDLR_LO,
+			 lower_32_bits(desc_data->dma_desc_addr));
+
+	/* Update the Rx Descriptor Tail Pointer */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, start_index +
+					 ring->dma_desc_count - 1);
+	FXGMAC_DMA_IO_WR(channel, DMA_CH_RDTR_LO,
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
+	FXGMAC_DMA_IO_WR(channel, DMA_CH_TDRLR,
+			 channel->priv->tx_desc_count - 1);
+
+	/* Update the starting address of descriptor ring */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, start_index);
+	FXGMAC_DMA_IO_WR(channel, DMA_CH_TDLR_HI,
+			 upper_32_bits(desc_data->dma_desc_addr));
+	FXGMAC_DMA_IO_WR(channel, DMA_CH_TDLR_LO,
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
+		yt_err(priv, "%s, flush tx queue err:%d\n", __func__, ret);
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
-- 
2.34.1


