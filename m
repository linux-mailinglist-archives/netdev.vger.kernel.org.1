Return-Path: <netdev+bounces-229215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C73CBD96A7
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DCB3A6240
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1176314A7A;
	Tue, 14 Oct 2025 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="0MmqSsPB"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21370313E15;
	Tue, 14 Oct 2025 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445690; cv=none; b=NIYKvs0FcuqfDs7lZrCKSYiOGnorOqFMv1MkqGiwJgBtIZvpVrI1/qMhtRvKVtoM86BqnvyQuzLa9/ahQc4tfEMME5vpZ3YF4dENUOo9mq1t9HgbPj5iWCpiZdIBNp4Dj/J7q2kYNOJyLmkC0eljcT3WKHkL5ZHA0D5xbFaRTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445690; c=relaxed/simple;
	bh=A1ouLTOVwReMxhPo6k59CV3BaZ95iMOQH1URpjiWIfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOaX7wufKRDZoKkP1f6Ibi6DwR3UH2UD30hKqyEbWhoC5gmGHxM9564DT3XPW0odfjqau220mpqNnH0gOWQCXFET95rowOhoYPQ067wD1pmbrjX6aJoGjz7qyA0T1EgLAr/GcbLJUFHDW9nDCMUlofJFHiukIcK5lff1Y3lH6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=0MmqSsPB; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mOHkHVywbLeQ/LtvsAejgNFh3jdNFZLdtteBtmXIhto=; b=0MmqSsPBsGMYgQWisZzt7844Cq
	kmdiC5O5BKOYA5sha5fh/D21rL/EYNPrinIIFCXqMAFVd0n1G3CzGFmv9XMZ6MFwBwjiWC3TG7Vxx
	GAGPtlxXGJA2VsLUPlLi3qOAD9aN20LZ8jcqSTEdg6L+8Uz8gF1ObWpE1hwqDMQ5BbWUR5Mk8SeSX
	mVpkG+a/nR4OO52xD1f+Y3BpwrtD7ohQm162g3YUIBIXyH8RiGUMjRoCYMhLlTFOvgKKqtaxH6q0p
	GDdtcwW9LpW8e29AKPqSVb9XtwylpnBdGIRRcKzJCSOZUtsa/OFRLMcxONA8VSc9ZfWtO+0wM4aOk
	6dXRTplw==;
Received: from [122.175.9.182] (port=2147 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1v8eLF-00000005NDu-1n8S;
	Tue, 14 Oct 2025 08:41:26 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	basharath@couthit.com,
	afd@ti.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v3 3/3] net: ti: icssm-prueth: Adds support for ICSSM RSTP switch
Date: Tue, 14 Oct 2025 18:09:01 +0530
Message-ID: <20251014124018.1596900-4-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014124018.1596900-1-parvathi@couthit.com>
References: <20251014124018.1596900-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Roger Quadros <rogerq@ti.com>

Adds support for RSTP switch mode by enhancing the existing ICSSM dual EMAC
driver with switchdev support.

With this patch, the PRU-ICSSM is now capable of operating in switch mode
with the 2 PRU ports acting as external ports and the host acting as an
internal port. Packets received from the PRU ports will be forwarded to
the host (store and forward mode) and also to the other PRU port (either
using store and forward mode or via cut-through mode). Packets coming
from the host will be transmitted either from one or both of the PRU ports
(depending on the FDB decision).

By default, the dual EMAC firmware will be loaded in the PRU-ICSS
subsystem. To configure the PRU-ICSS to operate as a switch, a different
firmware must to be loaded.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  | 338 ++++++++++++++-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |   6 +
 .../ethernet/ti/icssm/icssm_prueth_switch.c   | 385 ++++++++++++++++++
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |   8 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |  77 ++++
 5 files changed, 793 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 9bcece1b09fc..bed542f593d6 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -162,7 +162,7 @@ static const struct prueth_queue_info queue_infos[][NUM_QUEUES] = {
 	},
 };
 
-static const struct prueth_queue_desc queue_descs[][NUM_QUEUES] = {
+const struct prueth_queue_desc queue_descs[][NUM_QUEUES] = {
 	[PRUETH_PORT_QUEUE_HOST] = {
 		{ .rd_ptr = P0_Q1_BD_OFFSET, .wr_ptr = P0_Q1_BD_OFFSET, },
 		{ .rd_ptr = P0_Q2_BD_OFFSET, .wr_ptr = P0_Q2_BD_OFFSET, },
@@ -222,9 +222,9 @@ static void icssm_prueth_hostconfig(struct prueth *prueth)
 
 static void icssm_prueth_mii_init(struct prueth *prueth)
 {
+	u32 txcfg_reg, txcfg, txcfg2;
 	struct regmap *mii_rt;
 	u32 rxcfg_reg, rxcfg;
-	u32 txcfg_reg, txcfg;
 
 	mii_rt = prueth->mii_rt;
 
@@ -252,17 +252,23 @@ static void icssm_prueth_mii_init(struct prueth *prueth)
 		(TX_START_DELAY << PRUSS_MII_RT_TXCFG_TX_START_DELAY_SHIFT) |
 		(TX_CLK_DELAY_100M << PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_SHIFT);
 
+	txcfg2 = txcfg;
+	if (!PRUETH_IS_EMAC(prueth))
+		txcfg2 |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
+
 	/* Configuration of Port 0 Tx */
 	txcfg_reg = PRUSS_MII_RT_TXCFG0;
 
-	regmap_write(mii_rt, txcfg_reg, txcfg);
+	regmap_write(mii_rt, txcfg_reg, txcfg2);
 
-	txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
+	txcfg2 = txcfg;
+	if (PRUETH_IS_EMAC(prueth))
+		txcfg2 |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
 
 	/* Configuration of Port 1 Tx */
 	txcfg_reg = PRUSS_MII_RT_TXCFG1;
 
-	regmap_write(mii_rt, txcfg_reg, txcfg);
+	regmap_write(mii_rt, txcfg_reg, txcfg2);
 
 	txcfg_reg = PRUSS_MII_RT_RX_FRMS0;
 
@@ -309,7 +315,10 @@ static void icssm_prueth_hostinit(struct prueth *prueth)
 		icssm_prueth_clearmem(prueth, PRUETH_MEM_DRAM1);
 
 	/* Initialize host queues in shared RAM */
-	icssm_prueth_hostconfig(prueth);
+	if (!PRUETH_IS_EMAC(prueth))
+		icssm_prueth_sw_hostconfig(prueth);
+	else
+		icssm_prueth_hostconfig(prueth);
 
 	/* Configure MII_RT */
 	icssm_prueth_mii_init(prueth);
@@ -517,19 +526,24 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 	struct prueth_queue_desc __iomem *queue_desc;
 	const struct prueth_queue_info *txqueue;
 	struct net_device *ndev = emac->ndev;
+	struct prueth *prueth = emac->prueth;
 	unsigned int buffer_desc_count;
 	int free_blocks, update_block;
 	bool buffer_wrapped = false;
 	int write_block, read_block;
 	void *src_addr, *dst_addr;
 	int pkt_block_size;
+	void __iomem *sram;
 	void __iomem *dram;
 	int txport, pktlen;
 	u16 update_wr_ptr;
 	u32 wr_buf_desc;
 	void *ocmc_ram;
 
-	dram = emac->prueth->mem[emac->dram].va;
+	if (!PRUETH_IS_EMAC(prueth))
+		dram = prueth->mem[PRUETH_MEM_DRAM1].va;
+	else
+		dram = emac->prueth->mem[emac->dram].va;
 	if (eth_skb_pad(skb)) {
 		if (netif_msg_tx_err(emac) && net_ratelimit())
 			netdev_err(ndev, "packet pad failed\n");
@@ -542,7 +556,10 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 	pktlen = skb->len;
 	/* Get the tx queue */
 	queue_desc = emac->tx_queue_descs + queue_id;
-	txqueue = &queue_infos[txport][queue_id];
+	if (!PRUETH_IS_EMAC(prueth))
+		txqueue = &sw_queue_infos[txport][queue_id];
+	else
+		txqueue = &queue_infos[txport][queue_id];
 
 	buffer_desc_count = icssm_get_buff_desc_count(txqueue);
 
@@ -608,7 +625,11 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
        /* update first buffer descriptor */
 	wr_buf_desc = (pktlen << PRUETH_BD_LENGTH_SHIFT) &
 		       PRUETH_BD_LENGTH_MASK;
-	writel(wr_buf_desc, dram + readw(&queue_desc->wr_ptr));
+	sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+	if (!PRUETH_IS_EMAC(prueth))
+		writel(wr_buf_desc, sram + readw(&queue_desc->wr_ptr));
+	else
+		writel(wr_buf_desc, dram + readw(&queue_desc->wr_ptr));
 
 	/* update the write pointer in this queue descriptor, the firmware
 	 * polls for this change so this will signal the start of transmission
@@ -622,7 +643,6 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
 void icssm_parse_packet_info(struct prueth *prueth, u32 buffer_descriptor,
 			     struct prueth_packet_info *pkt_info)
 {
-	pkt_info->shadow = !!(buffer_descriptor & PRUETH_BD_SHADOW_MASK);
 	pkt_info->port = (buffer_descriptor & PRUETH_BD_PORT_MASK) >>
 			 PRUETH_BD_PORT_SHIFT;
 	pkt_info->length = (buffer_descriptor & PRUETH_BD_LENGTH_MASK) >>
@@ -731,11 +751,19 @@ int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 		src_addr += actual_pkt_len;
 	}
 
+	if (PRUETH_IS_SWITCH(emac->prueth)) {
+		skb->offload_fwd_mark = emac->offload_fwd_mark;
+		if (!pkt_info->lookup_success)
+			icssm_prueth_sw_learn_fdb(emac, skb->data + ETH_ALEN);
+	}
+
 	skb_put(skb, actual_pkt_len);
 
 	/* send packet up the stack */
 	skb->protocol = eth_type_trans(skb, ndev);
+	local_bh_disable();
 	netif_receive_skb(skb);
+	local_bh_enable();
 
 	/* update stats */
 	emac->stats.rx_bytes += actual_pkt_len;
@@ -761,6 +789,7 @@ static int icssm_emac_rx_packets(struct prueth_emac *emac, int budget)
 
 	shared_ram = emac->prueth->mem[PRUETH_MEM_SHARED_RAM].va;
 
+	/* Start and end queue is made common for EMAC, RSTP */
 	start_queue = emac->rx_queue_start;
 	end_queue = emac->rx_queue_end;
 
@@ -771,8 +800,10 @@ static int icssm_emac_rx_packets(struct prueth_emac *emac, int budget)
 	/* search host queues for packets */
 	for (i = start_queue; i <= end_queue; i++) {
 		queue_desc = emac->rx_queue_descs + i;
-		rxqueue = &queue_infos[PRUETH_PORT_HOST][i];
-
+		if (PRUETH_IS_SWITCH(emac->prueth))
+			rxqueue = &sw_queue_infos[PRUETH_PORT_HOST][i];
+		else
+			rxqueue = &queue_infos[PRUETH_PORT_HOST][i];
 		overflow_cnt = readb(&queue_desc->overflow_cnt);
 		if (overflow_cnt > 0) {
 			emac->stats.rx_over_errors += overflow_cnt;
@@ -897,6 +928,13 @@ static int icssm_emac_request_irqs(struct prueth_emac *emac)
 	return ret;
 }
 
+/* Function to free memory related to sw */
+static void icssm_prueth_free_memory(struct prueth *prueth)
+{
+	if (PRUETH_IS_SWITCH(prueth))
+		icssm_prueth_sw_free_fdb_table(prueth);
+}
+
 static void icssm_ptp_dram_init(struct prueth_emac *emac)
 {
 	void __iomem *sram = emac->prueth->mem[PRUETH_MEM_SHARED_RAM].va;
@@ -959,20 +997,38 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 	if (!prueth->emac_configured)
 		icssm_prueth_init_ethernet_mode(prueth);
 
-	icssm_prueth_emac_config(emac);
+	/* reset and start PRU firmware */
+	if (PRUETH_IS_SWITCH(prueth)) {
+		ret = icssm_prueth_sw_emac_config(emac);
+		if (ret)
+			return ret;
+
+		ret = icssm_prueth_sw_init_fdb_table(prueth);
+		if (ret)
+			return ret;
+	} else {
+		icssm_prueth_emac_config(emac);
+	}
 
 	if (!prueth->emac_configured) {
 		icssm_ptp_dram_init(emac);
 		ret = icss_iep_init(prueth->iep, NULL, NULL, 0);
 		if (ret) {
 			netdev_err(ndev, "Failed to initialize iep: %d\n", ret);
-			goto iep_exit;
+			goto free_mem;
 		}
 	}
 
-	ret = icssm_emac_set_boot_pru(emac, ndev);
-	if (ret)
-		goto iep_exit;
+	if (!PRUETH_IS_EMAC(prueth)) {
+		ret = icssm_prueth_sw_boot_prus(prueth, ndev);
+		if (ret)
+			goto iep_exit;
+	} else {
+		/* boot the PRU */
+		ret = icssm_emac_set_boot_pru(emac, ndev);
+		if (ret)
+			goto iep_exit;
+	}
 
 	ret = icssm_emac_request_irqs(emac);
 	if (ret)
@@ -987,19 +1043,25 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 	icssm_prueth_port_enable(emac, true);
 
 	prueth->emac_configured |= BIT(emac->port_id);
-
+	if (PRUETH_IS_SWITCH(prueth))
+		icssm_prueth_sw_port_set_stp_state(prueth, emac->port_id,
+						   BR_STATE_LEARNING);
 	if (netif_msg_drv(emac))
 		dev_notice(&ndev->dev, "started\n");
 
 	return 0;
 
 rproc_shutdown:
-	rproc_shutdown(emac->pru);
+	if (!PRUETH_IS_EMAC(prueth))
+		icssm_prueth_sw_shutdown_prus(emac, ndev);
+	else
+		rproc_shutdown(emac->pru);
 
 iep_exit:
 	if (!prueth->emac_configured)
 		icss_iep_exit(prueth->iep);
-
+free_mem:
+	icssm_prueth_free_memory(emac->prueth);
 	return ret;
 }
 
@@ -1028,17 +1090,74 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
 	hrtimer_cancel(&emac->tx_hrtimer);
 
 	/* stop the PRU */
-	rproc_shutdown(emac->pru);
+	if (!PRUETH_IS_EMAC(prueth))
+		icssm_prueth_sw_shutdown_prus(emac, ndev);
+	else
+		rproc_shutdown(emac->pru);
+
+	/* free table memory of the switch */
+	if (PRUETH_IS_SWITCH(emac->prueth))
+		icssm_prueth_sw_free_fdb_table(prueth);
 
 	/* free rx interrupts */
 	free_irq(emac->rx_irq, ndev);
 
+	/* free memory related to sw */
+	icssm_prueth_free_memory(emac->prueth);
+
 	if (netif_msg_drv(emac))
 		dev_notice(&ndev->dev, "stopped\n");
 
 	return 0;
 }
 
+static int icssm_prueth_change_mode(struct prueth *prueth,
+				    enum pruss_ethtype mode)
+{
+	bool portstatus[PRUETH_NUM_MACS];
+	struct prueth_emac *emac;
+	struct net_device *ndev;
+	int i, ret;
+
+	for (i = 0; i < PRUETH_NUM_MACS; i++) {
+		emac = prueth->emac[i];
+		ndev = emac->ndev;
+
+		portstatus[i] = netif_running(ndev);
+		if (!portstatus[i])
+			continue;
+
+		ret = ndev->netdev_ops->ndo_stop(ndev);
+		if (ret < 0) {
+			netdev_err(ndev, "failed to stop: %d", ret);
+			return ret;
+		}
+	}
+
+	if (mode == PRUSS_ETHTYPE_EMAC || mode == PRUSS_ETHTYPE_SWITCH) {
+		prueth->eth_type = mode;
+	} else {
+		dev_err(prueth->dev, "unknown mode\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < PRUETH_NUM_MACS; i++) {
+		emac = prueth->emac[i];
+		ndev = emac->ndev;
+
+		if (!portstatus[i])
+			continue;
+
+		ret = ndev->netdev_ops->ndo_open(ndev);
+		if (ret < 0) {
+			netdev_err(ndev, "failed to start: %d", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /* VLAN-tag PCP to priority queue map for EMAC/Switch/HSR/PRP used by driver
  * Index is PCP val / 2.
  *   low  - pcp 0..3 maps to Q4 for Host
@@ -1313,6 +1432,15 @@ static void icssm_emac_ndo_set_rx_mode(struct net_device *ndev)
 		icssm_emac_mc_filter_bin_allow(emac, hash);
 	}
 
+	/* Add bridge device's MC addresses as well */
+	if (prueth->hw_bridge_dev) {
+		netdev_for_each_mc_addr(ha, prueth->hw_bridge_dev) {
+			hash = icssm_emac_get_mc_hash(ha->addr,
+						      emac->mc_filter_mask);
+			icssm_emac_mc_filter_bin_allow(emac, hash);
+		}
+	}
+
 unlock:
 	spin_unlock_irqrestore(&emac->addr_lock, flags);
 }
@@ -1375,6 +1503,7 @@ static enum hrtimer_restart icssm_emac_tx_timer_callback(struct hrtimer *timer)
 static int icssm_prueth_netdev_init(struct prueth *prueth,
 				    struct device_node *eth_node)
 {
+	const struct prueth_private_data *fw_data = prueth->fw_data;
 	struct prueth_emac *emac;
 	struct net_device *ndev;
 	enum prueth_port port;
@@ -1461,6 +1590,14 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
 	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_Pause_BIT);
 	phy_remove_link_mode(emac->phydev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
 
+	/* Protocol switching
+	 * Enabling L2 Firmware offloading
+	 */
+	if (fw_data->support_switch) {
+		ndev->features |= NETIF_F_HW_L2FW_DOFFLOAD;
+		ndev->hw_features |= NETIF_F_HW_L2FW_DOFFLOAD;
+	}
+
 	ndev->dev.of_node = eth_node;
 	ndev->netdev_ops = &emac_netdev_ops;
 
@@ -1508,6 +1645,140 @@ bool icssm_prueth_sw_port_dev_check(const struct net_device *ndev)
 	return false;
 }
 
+static int icssm_prueth_port_offload_fwd_mark_update(struct prueth *prueth)
+{
+	int set_val = 0;
+	int i, ret = 0;
+	u8 all_slaves;
+
+	all_slaves = BIT(PRUETH_PORT_MII0) | BIT(PRUETH_PORT_MII1);
+
+	if (prueth->br_members == all_slaves)
+		set_val = 1;
+
+	dev_dbg(prueth->dev, "set offload_fwd_mark %d, mbrs=0x%x\n",
+		set_val, prueth->br_members);
+
+	for (i = 0; i < PRUETH_NUM_MACS; i++)
+		prueth->emac[i]->offload_fwd_mark = set_val;
+
+	/* Bridge is created, load switch firmware,
+	 * if not already in that mode
+	 */
+	if (set_val && !PRUETH_IS_SWITCH(prueth)) {
+		ret = icssm_prueth_change_mode(prueth, PRUSS_ETHTYPE_SWITCH);
+		if (ret < 0)
+			dev_err(prueth->dev, "Failed to enable Switch mode\n");
+		else
+			dev_info(prueth->dev,
+				 "TI PRU ethernet now in Switch mode\n");
+	}
+
+	/* Bridge is deleted, switch to Dual EMAC mode */
+	if (!prueth->br_members && !PRUETH_IS_EMAC(prueth)) {
+		ret = icssm_prueth_change_mode(prueth, PRUSS_ETHTYPE_EMAC);
+		if (ret < 0)
+			dev_err(prueth->dev, "Failed to enable Dual EMAC mode\n");
+		else
+			dev_info(prueth->dev,
+				 "TI PRU ethernet now in Dual EMAC mode\n");
+	}
+
+	return ret;
+}
+
+static int icssm_prueth_ndev_port_link(struct net_device *ndev,
+				       struct net_device *br_ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	int ret = 0;
+
+	dev_dbg(prueth->dev, "%s: br_mbrs=0x%x %s\n",
+		__func__, prueth->br_members, ndev->name);
+
+	if (!prueth->br_members) {
+		prueth->hw_bridge_dev = br_ndev;
+	} else {
+		/* This is adding the port to a second bridge,
+		 * this is unsupported
+		 */
+		if (prueth->hw_bridge_dev != br_ndev)
+			return -EOPNOTSUPP;
+	}
+
+	prueth->br_members |= BIT(emac->port_id);
+
+	ret = icssm_prueth_port_offload_fwd_mark_update(prueth);
+
+	return ret;
+}
+
+static int icssm_prueth_ndev_port_unlink(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	int ret = 0;
+
+	dev_dbg(prueth->dev, "emac_sw_ndev_port_unlink\n");
+
+	prueth->br_members &= ~BIT(emac->port_id);
+
+	ret = icssm_prueth_port_offload_fwd_mark_update(prueth);
+
+	if (!prueth->br_members)
+		prueth->hw_bridge_dev = NULL;
+
+	return ret;
+}
+
+static int icssm_prueth_ndev_event(struct notifier_block *unused,
+				   unsigned long event, void *ptr)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changeupper_info *info;
+	int ret = NOTIFY_DONE;
+
+	if (!icssm_prueth_sw_port_dev_check(ndev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		info = ptr;
+		if (netif_is_bridge_master(info->upper_dev)) {
+			if (info->linking)
+				ret = icssm_prueth_ndev_port_link
+					(ndev, info->upper_dev);
+			else
+				ret = icssm_prueth_ndev_port_unlink(ndev);
+		}
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static int icssm_prueth_register_notifiers(struct prueth *prueth)
+{
+	int ret = 0;
+
+	prueth->prueth_netdevice_nb.notifier_call = icssm_prueth_ndev_event;
+	ret = register_netdevice_notifier(&prueth->prueth_netdevice_nb);
+	if (ret) {
+		dev_err(prueth->dev,
+			"register netdevice notifier failed ret: %d\n", ret);
+		return ret;
+	}
+
+	ret = icssm_prueth_sw_register_notifiers(prueth);
+	if (ret)
+		unregister_netdevice_notifier(&prueth->prueth_netdevice_nb);
+
+	return ret;
+}
+
 static int icssm_prueth_probe(struct platform_device *pdev)
 {
 	struct device_node *eth0_node = NULL, *eth1_node = NULL;
@@ -1728,6 +1999,12 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 			prueth->emac[PRUETH_MAC1]->ndev;
 	}
 
+	ret = icssm_prueth_register_notifiers(prueth);
+	if (ret) {
+		dev_err(dev, "can't register switchdev notifiers");
+		goto netdev_unregister;
+	}
+
 	dev_info(dev, "TI PRU ethernet driver initialized: %s EMAC mode\n",
 		 (!eth0_node || !eth1_node) ? "single" : "dual");
 
@@ -1788,6 +2065,9 @@ static void icssm_prueth_remove(struct platform_device *pdev)
 	struct device_node *eth_node;
 	int i;
 
+	unregister_netdevice_notifier(&prueth->prueth_netdevice_nb);
+	icssm_prueth_sw_unregister_notifiers(prueth);
+
 	for (i = 0; i < PRUETH_NUM_MACS; i++) {
 		if (!prueth->registered_netdevs[i])
 			continue;
@@ -1887,11 +2167,16 @@ static struct prueth_private_data am335x_prueth_pdata = {
 	.fw_pru[PRUSS_PRU0] = {
 		.fw_name[PRUSS_ETHTYPE_EMAC] =
 			"ti-pruss/am335x-pru0-prueth-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_SWITCH] =
+			"ti-pruss/am335x-pru0-prusw-fw.elf",
 	},
 	.fw_pru[PRUSS_PRU1] = {
 		.fw_name[PRUSS_ETHTYPE_EMAC] =
 			"ti-pruss/am335x-pru1-prueth-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_SWITCH] =
+			"ti-pruss/am335x-pru1-prusw-fw.elf",
 	},
+	.support_switch = true,
 };
 
 /* AM437x SoC-specific firmware data */
@@ -1900,11 +2185,16 @@ static struct prueth_private_data am437x_prueth_pdata = {
 	.fw_pru[PRUSS_PRU0] = {
 		.fw_name[PRUSS_ETHTYPE_EMAC] =
 			"ti-pruss/am437x-pru0-prueth-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_SWITCH] =
+			"ti-pruss/am437x-pru0-prusw-fw.elf",
 	},
 	.fw_pru[PRUSS_PRU1] = {
 		.fw_name[PRUSS_ETHTYPE_EMAC] =
 			"ti-pruss/am437x-pru1-prueth-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_SWITCH] =
+			"ti-pruss/am437x-pru1-prusw-fw.elf",
 	},
+	.support_switch = true,
 };
 
 /* AM57xx SoC-specific firmware data */
@@ -1913,11 +2203,17 @@ static struct prueth_private_data am57xx_prueth_pdata = {
 	.fw_pru[PRUSS_PRU0] = {
 		.fw_name[PRUSS_ETHTYPE_EMAC] =
 			"ti-pruss/am57xx-pru0-prueth-fw.elf",
+	.fw_name[PRUSS_ETHTYPE_SWITCH] =
+			"ti-pruss/am57xx-pru0-prusw-fw.elf",
 	},
 	.fw_pru[PRUSS_PRU1] = {
 		.fw_name[PRUSS_ETHTYPE_EMAC] =
 			"ti-pruss/am57xx-pru1-prueth-fw.elf",
+		.fw_name[PRUSS_ETHTYPE_SWITCH] =
+			"ti-pruss/am57xx-pru1-prusw-fw.elf",
+
 	},
+	.support_switch = true,
 };
 
 static const struct of_device_id prueth_dt_match[] = {
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
index c98ed2cd76e7..a4e3d0ac96c7 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
@@ -189,10 +189,12 @@ struct prueth_fw_offsets {
  * struct prueth_private_data - PRU Ethernet private data
  * @driver_data: PRU Ethernet device name
  * @fw_pru: firmware names to be used for PRUSS ethernet usecases
+ * @support_switch: boolean to indicate if switch is enabled
  */
 struct prueth_private_data {
 	enum pruss_device driver_data;
 	const struct prueth_firmware fw_pru[PRUSS_NUM_PRUS];
+	bool support_switch;
 };
 
 struct prueth_emac_stats {
@@ -240,6 +242,7 @@ struct prueth_emac {
 
 	struct hrtimer tx_hrtimer;
 	struct prueth_emac_stats stats;
+	int offload_fwd_mark;
 };
 
 struct prueth {
@@ -268,8 +271,11 @@ struct prueth {
 	unsigned int eth_type;
 	size_t ocmc_ram_size;
 	u8 emac_configured;
+	u8 br_members;
 };
 
+extern const struct prueth_queue_desc queue_descs[][NUM_QUEUES];
+
 void icssm_parse_packet_info(struct prueth *prueth, u32 buffer_descriptor,
 			     struct prueth_packet_info *pkt_info);
 int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
index fdd349a8bc72..e837e127510b 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
@@ -25,6 +25,176 @@ struct icssm_prueth_sw_fdb_work {
 	int event;
 };
 
+const struct prueth_queue_info sw_queue_infos[][NUM_QUEUES] = {
+	[PRUETH_PORT_QUEUE_HOST] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q1_BUFFER_OFFSET,
+			P0_QUEUE_DESC_OFFSET,
+			P0_Q1_BD_OFFSET,
+			P0_Q1_BD_OFFSET + ((HOST_QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q2_BUFFER_OFFSET,
+			P0_QUEUE_DESC_OFFSET + 8,
+			P0_Q2_BD_OFFSET,
+			P0_Q2_BD_OFFSET + ((HOST_QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P0_Q3_BUFFER_OFFSET,
+			P0_QUEUE_DESC_OFFSET + 16,
+			P0_Q3_BD_OFFSET,
+			P0_Q3_BD_OFFSET + ((HOST_QUEUE_3_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P0_Q4_BUFFER_OFFSET,
+			P0_QUEUE_DESC_OFFSET + 24,
+			P0_Q4_BD_OFFSET,
+			P0_Q4_BD_OFFSET + ((HOST_QUEUE_4_SIZE - 1) * BD_SIZE),
+		},
+	},
+	[PRUETH_PORT_QUEUE_MII0] = {
+		[PRUETH_QUEUE1] = {
+			P1_Q1_BUFFER_OFFSET,
+			P1_Q1_BUFFER_OFFSET +
+				((QUEUE_1_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P1_Q1_BD_OFFSET,
+			P1_Q1_BD_OFFSET + ((QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P1_Q2_BUFFER_OFFSET,
+			P1_Q2_BUFFER_OFFSET +
+				((QUEUE_2_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P1_Q2_BD_OFFSET,
+			P1_Q2_BD_OFFSET + ((QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P1_Q3_BUFFER_OFFSET,
+			P1_Q3_BUFFER_OFFSET +
+				((QUEUE_3_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P1_Q3_BD_OFFSET,
+			P1_Q3_BD_OFFSET + ((QUEUE_3_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P1_Q4_BUFFER_OFFSET,
+			P1_Q4_BUFFER_OFFSET +
+				((QUEUE_4_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P1_Q4_BD_OFFSET,
+			P1_Q4_BD_OFFSET + ((QUEUE_4_SIZE - 1) * BD_SIZE),
+		},
+	},
+	[PRUETH_PORT_QUEUE_MII1] = {
+		[PRUETH_QUEUE1] = {
+			P2_Q1_BUFFER_OFFSET,
+			P2_Q1_BUFFER_OFFSET +
+				((QUEUE_1_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P2_Q1_BD_OFFSET,
+			P2_Q1_BD_OFFSET + ((QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P2_Q2_BUFFER_OFFSET,
+			P2_Q2_BUFFER_OFFSET +
+				((QUEUE_2_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P2_Q2_BD_OFFSET,
+			P2_Q2_BD_OFFSET + ((QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P2_Q3_BUFFER_OFFSET,
+			P2_Q3_BUFFER_OFFSET +
+				((QUEUE_3_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P2_Q3_BD_OFFSET,
+			P2_Q3_BD_OFFSET + ((QUEUE_3_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P2_Q4_BUFFER_OFFSET,
+			P2_Q4_BUFFER_OFFSET +
+				((QUEUE_4_SIZE - 1) * ICSS_BLOCK_SIZE),
+			P2_Q4_BD_OFFSET,
+			P2_Q4_BD_OFFSET + ((QUEUE_4_SIZE - 1) * BD_SIZE),
+		},
+	},
+};
+
+static const struct prueth_queue_info rx_queue_infos[][NUM_QUEUES] = {
+	[PRUETH_PORT_QUEUE_HOST] = {
+		[PRUETH_QUEUE1] = {
+			P0_Q1_BUFFER_OFFSET,
+			HOST_QUEUE_DESC_OFFSET,
+			P0_Q1_BD_OFFSET,
+			P0_Q1_BD_OFFSET + ((HOST_QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P0_Q2_BUFFER_OFFSET,
+			HOST_QUEUE_DESC_OFFSET + 8,
+			P0_Q2_BD_OFFSET,
+			P0_Q2_BD_OFFSET + ((HOST_QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P0_Q3_BUFFER_OFFSET,
+			HOST_QUEUE_DESC_OFFSET + 16,
+			P0_Q3_BD_OFFSET,
+			P0_Q3_BD_OFFSET + ((HOST_QUEUE_3_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P0_Q4_BUFFER_OFFSET,
+			HOST_QUEUE_DESC_OFFSET + 24,
+			P0_Q4_BD_OFFSET,
+			P0_Q4_BD_OFFSET + ((HOST_QUEUE_4_SIZE - 1) * BD_SIZE),
+		},
+	},
+	[PRUETH_PORT_QUEUE_MII0] = {
+		[PRUETH_QUEUE1] = {
+			P1_Q1_BUFFER_OFFSET,
+			P1_QUEUE_DESC_OFFSET,
+			P1_Q1_BD_OFFSET,
+			P1_Q1_BD_OFFSET + ((QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P1_Q2_BUFFER_OFFSET,
+			P1_QUEUE_DESC_OFFSET + 8,
+			P1_Q2_BD_OFFSET,
+			P1_Q2_BD_OFFSET + ((QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P1_Q3_BUFFER_OFFSET,
+			P1_QUEUE_DESC_OFFSET + 16,
+			P1_Q3_BD_OFFSET,
+			P1_Q3_BD_OFFSET + ((QUEUE_3_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P1_Q4_BUFFER_OFFSET,
+			P1_QUEUE_DESC_OFFSET + 24,
+			P1_Q4_BD_OFFSET,
+			P1_Q4_BD_OFFSET + ((QUEUE_4_SIZE - 1) * BD_SIZE),
+		},
+	},
+	[PRUETH_PORT_QUEUE_MII1] = {
+		[PRUETH_QUEUE1] = {
+			P2_Q1_BUFFER_OFFSET,
+			P2_QUEUE_DESC_OFFSET,
+			P2_Q1_BD_OFFSET,
+			P2_Q1_BD_OFFSET + ((QUEUE_1_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE2] = {
+			P2_Q2_BUFFER_OFFSET,
+			P2_QUEUE_DESC_OFFSET + 8,
+			P2_Q2_BD_OFFSET,
+			P2_Q2_BD_OFFSET + ((QUEUE_2_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE3] = {
+			P2_Q3_BUFFER_OFFSET,
+			P2_QUEUE_DESC_OFFSET + 16,
+			P2_Q3_BD_OFFSET,
+			P2_Q3_BD_OFFSET + ((QUEUE_3_SIZE - 1) * BD_SIZE),
+		},
+		[PRUETH_QUEUE4] = {
+			P2_Q4_BUFFER_OFFSET,
+			P2_QUEUE_DESC_OFFSET + 24,
+			P2_Q4_BD_OFFSET,
+			P2_Q4_BD_OFFSET + ((QUEUE_4_SIZE - 1) * BD_SIZE),
+		},
+	},
+};
+
 void icssm_prueth_sw_free_fdb_table(struct prueth *prueth)
 {
 	if (prueth->emac_configured)
@@ -617,3 +787,218 @@ int icssm_prueth_sw_purge_fdb(struct prueth_emac *emac)
 	queue_work(system_long_wq, &fdb_work->work);
 	return 0;
 }
+
+void icssm_prueth_sw_hostconfig(struct prueth *prueth)
+{
+	void __iomem *dram1_base = prueth->mem[PRUETH_MEM_DRAM1].va;
+	void __iomem *dram;
+
+	/* queue information table */
+	dram = dram1_base + P0_Q1_RX_CONTEXT_OFFSET;
+	memcpy_toio(dram, sw_queue_infos[PRUETH_PORT_QUEUE_HOST],
+		    sizeof(sw_queue_infos[PRUETH_PORT_QUEUE_HOST]));
+
+	/* buffer descriptor offset table*/
+	dram = dram1_base + QUEUE_DESCRIPTOR_OFFSET_ADDR;
+	writew(P0_Q1_BD_OFFSET, dram);
+	writew(P0_Q2_BD_OFFSET, dram + 2);
+	writew(P0_Q3_BD_OFFSET, dram + 4);
+	writew(P0_Q4_BD_OFFSET, dram + 6);
+
+	/* buffer offset table */
+	dram = dram1_base + QUEUE_OFFSET_ADDR;
+	writew(P0_Q1_BUFFER_OFFSET, dram);
+	writew(P0_Q2_BUFFER_OFFSET, dram + 2);
+	writew(P0_Q3_BUFFER_OFFSET, dram + 4);
+	writew(P0_Q4_BUFFER_OFFSET, dram + 6);
+
+	/* queue size lookup table */
+	dram = dram1_base + QUEUE_SIZE_ADDR;
+	writew(HOST_QUEUE_1_SIZE, dram);
+	writew(HOST_QUEUE_1_SIZE, dram + 2);
+	writew(HOST_QUEUE_1_SIZE, dram + 4);
+	writew(HOST_QUEUE_1_SIZE, dram + 6);
+
+	/* queue table */
+	dram = dram1_base + P0_QUEUE_DESC_OFFSET;
+	memcpy_toio(dram, queue_descs[PRUETH_PORT_QUEUE_HOST],
+		    sizeof(queue_descs[PRUETH_PORT_QUEUE_HOST]));
+}
+
+static int icssm_prueth_sw_port_config(struct prueth *prueth,
+				       enum prueth_port port_id)
+{
+	unsigned int tx_context_ofs_addr, rx_context_ofs, queue_desc_ofs;
+	void __iomem *dram, *dram_base, *dram_mac;
+	struct prueth_emac *emac;
+	void __iomem *dram1_base;
+
+	dram1_base = prueth->mem[PRUETH_MEM_DRAM1].va;
+	emac = prueth->emac[port_id - 1];
+	switch (port_id) {
+	case PRUETH_PORT_MII0:
+		tx_context_ofs_addr     = TX_CONTEXT_P1_Q1_OFFSET_ADDR;
+		rx_context_ofs          = P1_Q1_RX_CONTEXT_OFFSET;
+		queue_desc_ofs          = P1_QUEUE_DESC_OFFSET;
+
+		/* for switch PORT MII0 mac addr is in DRAM0. */
+		dram_mac = prueth->mem[PRUETH_MEM_DRAM0].va;
+		break;
+	case PRUETH_PORT_MII1:
+		tx_context_ofs_addr     = TX_CONTEXT_P2_Q1_OFFSET_ADDR;
+		rx_context_ofs          = P2_Q1_RX_CONTEXT_OFFSET;
+		queue_desc_ofs          = P2_QUEUE_DESC_OFFSET;
+
+		/* for switch PORT MII1 mac addr is in DRAM1. */
+		dram_mac = prueth->mem[PRUETH_MEM_DRAM1].va;
+		break;
+	default:
+		netdev_err(emac->ndev, "invalid port\n");
+		return -EINVAL;
+	}
+
+	/* setup mac address */
+	memcpy_toio(dram_mac + PORT_MAC_ADDR, emac->mac_addr, 6);
+
+	/* Remaining switch port configs are in DRAM1 */
+	dram_base = prueth->mem[PRUETH_MEM_DRAM1].va;
+
+	/* queue information table */
+	memcpy_toio(dram_base + tx_context_ofs_addr,
+		    sw_queue_infos[port_id],
+		    sizeof(sw_queue_infos[port_id]));
+
+	memcpy_toio(dram_base + rx_context_ofs,
+		    rx_queue_infos[port_id],
+		    sizeof(rx_queue_infos[port_id]));
+
+	/* buffer descriptor offset table*/
+	dram = dram_base + QUEUE_DESCRIPTOR_OFFSET_ADDR +
+	       (port_id * NUM_QUEUES * sizeof(u16));
+	writew(sw_queue_infos[port_id][PRUETH_QUEUE1].buffer_desc_offset, dram);
+	writew(sw_queue_infos[port_id][PRUETH_QUEUE2].buffer_desc_offset,
+	       dram + 2);
+	writew(sw_queue_infos[port_id][PRUETH_QUEUE3].buffer_desc_offset,
+	       dram + 4);
+	writew(sw_queue_infos[port_id][PRUETH_QUEUE4].buffer_desc_offset,
+	       dram + 6);
+
+	/* buffer offset table */
+	dram = dram_base + QUEUE_OFFSET_ADDR +
+	       port_id * NUM_QUEUES * sizeof(u16);
+	writew(sw_queue_infos[port_id][PRUETH_QUEUE1].buffer_offset, dram);
+	writew(sw_queue_infos[port_id][PRUETH_QUEUE2].buffer_offset,
+	       dram + 2);
+	writew(sw_queue_infos[port_id][PRUETH_QUEUE3].buffer_offset,
+	       dram + 4);
+	writew(sw_queue_infos[port_id][PRUETH_QUEUE4].buffer_offset,
+	       dram + 6);
+
+	/* queue size lookup table */
+	dram = dram_base + QUEUE_SIZE_ADDR +
+	       port_id * NUM_QUEUES * sizeof(u16);
+	writew(QUEUE_1_SIZE, dram);
+	writew(QUEUE_2_SIZE, dram + 2);
+	writew(QUEUE_3_SIZE, dram + 4);
+	writew(QUEUE_4_SIZE, dram + 6);
+
+	/* queue table */
+	memcpy_toio(dram_base + queue_desc_ofs,
+		    &queue_descs[port_id][0],
+		    4 * sizeof(queue_descs[port_id][0]));
+
+	emac->rx_queue_descs = dram1_base + P0_QUEUE_DESC_OFFSET;
+	emac->tx_queue_descs = dram1_base +
+		rx_queue_infos[port_id][PRUETH_QUEUE1].queue_desc_offset;
+
+	return 0;
+}
+
+int icssm_prueth_sw_emac_config(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+	u32 sharedramaddr, ocmcaddr;
+	int ret;
+
+	/* PRU needs local shared RAM address for C28 */
+	sharedramaddr = ICSS_LOCAL_SHARED_RAM;
+	/* PRU needs real global OCMC address for C30*/
+	ocmcaddr = (u32)prueth->mem[PRUETH_MEM_OCMC].pa;
+
+	if (prueth->emac_configured & BIT(emac->port_id))
+		return 0;
+
+	ret = icssm_prueth_sw_port_config(prueth, emac->port_id);
+	if (ret)
+		return ret;
+
+	if (!prueth->emac_configured) {
+		/* Set in constant table C28 of PRUn to ICSS Shared memory */
+		pru_rproc_set_ctable(prueth->pru0, PRU_C28, sharedramaddr);
+		pru_rproc_set_ctable(prueth->pru1, PRU_C28, sharedramaddr);
+
+		/* Set in constant table C30 of PRUn to OCMC memory */
+		pru_rproc_set_ctable(prueth->pru0, PRU_C30, ocmcaddr);
+		pru_rproc_set_ctable(prueth->pru1, PRU_C30, ocmcaddr);
+	}
+	return 0;
+}
+
+int icssm_prueth_sw_boot_prus(struct prueth *prueth, struct net_device *ndev)
+{
+	const struct prueth_firmware *pru_firmwares;
+	const char *fw_name, *fw_name1;
+	int ret;
+
+	if (prueth->emac_configured)
+		return 0;
+
+	pru_firmwares = &prueth->fw_data->fw_pru[PRUSS_PRU0];
+	fw_name = pru_firmwares->fw_name[prueth->eth_type];
+	pru_firmwares = &prueth->fw_data->fw_pru[PRUSS_PRU1];
+	fw_name1 = pru_firmwares->fw_name[prueth->eth_type];
+
+	ret = rproc_set_firmware(prueth->pru0, fw_name);
+	if (ret) {
+		netdev_err(ndev, "failed to set PRU0 firmware %s: %d\n",
+			   fw_name, ret);
+		return ret;
+	}
+	ret = rproc_boot(prueth->pru0);
+	if (ret) {
+		netdev_err(ndev, "failed to boot PRU0: %d\n", ret);
+		return ret;
+	}
+
+	ret = rproc_set_firmware(prueth->pru1, fw_name1);
+	if (ret) {
+		netdev_err(ndev, "failed to set PRU1 firmware %s: %d\n",
+			   fw_name1, ret);
+		goto rproc0_shutdown;
+	}
+	ret = rproc_boot(prueth->pru1);
+	if (ret) {
+		netdev_err(ndev, "failed to boot PRU1: %d\n", ret);
+		goto rproc0_shutdown;
+	}
+
+	return 0;
+
+rproc0_shutdown:
+	rproc_shutdown(prueth->pru0);
+	return ret;
+}
+
+int icssm_prueth_sw_shutdown_prus(struct prueth_emac *emac,
+				  struct net_device *ndev)
+{
+	struct prueth *prueth = emac->prueth;
+
+	if (prueth->emac_configured)
+		return 0;
+
+	rproc_shutdown(prueth->pru0);
+	rproc_shutdown(prueth->pru1);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
index d1a092b173a5..fa71b48ea63e 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
@@ -16,6 +16,8 @@ void icssm_prueth_sw_port_set_stp_state(struct prueth *prueth,
 u8 icssm_prueth_sw_port_get_stp_state(struct prueth *prueth,
 				      enum prueth_port port);
 
+extern const struct prueth_queue_info sw_queue_infos[][4];
+
 void icssm_prueth_sw_fdb_tbl_init(struct prueth *prueth);
 int icssm_prueth_sw_init_fdb_table(struct prueth *prueth);
 void icssm_prueth_sw_free_fdb_table(struct prueth *prueth);
@@ -26,4 +28,10 @@ void icssm_prueth_sw_fdb_del(struct prueth_emac *emac,
 			     struct switchdev_notifier_fdb_info *fdb);
 int icssm_prueth_sw_learn_fdb(struct prueth_emac *emac, u8 *src_mac);
 int icssm_prueth_sw_purge_fdb(struct prueth_emac *emac);
+void icssm_prueth_sw_hostconfig(struct prueth *prueth);
+int icssm_prueth_sw_emac_config(struct prueth_emac *emac);
+int icssm_prueth_sw_boot_prus(struct prueth *prueth, struct net_device *ndev);
+int icssm_prueth_sw_shutdown_prus(struct prueth_emac *emac,
+				  struct net_device *ndev);
+
 #endif /* __NET_TI_PRUETH_SWITCH_H */
diff --git a/drivers/net/ethernet/ti/icssm/icssm_switch.h b/drivers/net/ethernet/ti/icssm/icssm_switch.h
index 44b8ae06df9c..6469dda7ad66 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_switch.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_switch.h
@@ -117,6 +117,15 @@
 #define STATISTICS_OFFSET	0x1F00
 #define STAT_SIZE		0x98
 
+/* The following offsets indicate which sections of the memory are used
+ * for switch internal tasks
+ */
+#define SWITCH_SPECIFIC_DRAM0_START_SIZE		0x100
+#define SWITCH_SPECIFIC_DRAM0_START_OFFSET		0x1F00
+
+#define SWITCH_SPECIFIC_DRAM1_START_SIZE		0x300
+#define SWITCH_SPECIFIC_DRAM1_START_OFFSET		0x1D00
+
 /* Offset for storing
  * 1. Storm Prevention Params
  * 2. PHY Speed Offset
@@ -146,6 +155,74 @@
 /* 4 bytes ? */
 #define STP_INVALID_STATE_OFFSET	(STATISTICS_OFFSET + STAT_SIZE + 33)
 
+/* DRAM1 Offsets for Switch */
+/* 4 queue descriptors for port 0 (host receive) */
+#define P0_QUEUE_DESC_OFFSET		0x1E7C
+#define P1_QUEUE_DESC_OFFSET		0x1E9C
+#define P2_QUEUE_DESC_OFFSET		0x1EBC
+/* collision descriptor of port 0 */
+#define P0_COL_QUEUE_DESC_OFFSET	0x1E64
+#define P1_COL_QUEUE_DESC_OFFSET	0x1E6C
+#define P2_COL_QUEUE_DESC_OFFSET	0x1E74
+/* Collision Status Register
+ *    P0: bit 0 is pending flag, bit 1..2 indicates which queue,
+ *    P1: bit 8 is pending flag, 9..10 is queue number
+ *    P2: bit 16 is pending flag, 17..18 is queue number, remaining bits are 0.
+ */
+#define COLLISION_STATUS_ADDR		0x1E60
+
+#define INTERFACE_MAC_ADDR		0x1E58
+#define P2_MAC_ADDR			0x1E50
+#define P1_MAC_ADDR			0x1E48
+
+#define QUEUE_SIZE_ADDR			0x1E30
+#define QUEUE_OFFSET_ADDR		0x1E18
+#define QUEUE_DESCRIPTOR_OFFSET_ADDR	0x1E00
+
+#define COL_RX_CONTEXT_P2_OFFSET_ADDR	(COL_RX_CONTEXT_P1_OFFSET_ADDR + 12)
+#define COL_RX_CONTEXT_P1_OFFSET_ADDR	(COL_RX_CONTEXT_P0_OFFSET_ADDR + 12)
+#define COL_RX_CONTEXT_P0_OFFSET_ADDR	(P2_Q4_RX_CONTEXT_OFFSET + 8)
+
+/* Port 2 Rx Context */
+#define P2_Q4_RX_CONTEXT_OFFSET		(P2_Q3_RX_CONTEXT_OFFSET + 8)
+#define P2_Q3_RX_CONTEXT_OFFSET		(P2_Q2_RX_CONTEXT_OFFSET + 8)
+#define P2_Q2_RX_CONTEXT_OFFSET		(P2_Q1_RX_CONTEXT_OFFSET + 8)
+#define P2_Q1_RX_CONTEXT_OFFSET		RX_CONTEXT_P2_Q1_OFFSET_ADDR
+#define RX_CONTEXT_P2_Q1_OFFSET_ADDR	(P1_Q4_RX_CONTEXT_OFFSET + 8)
+
+/* Port 1 Rx Context */
+#define P1_Q4_RX_CONTEXT_OFFSET		(P1_Q3_RX_CONTEXT_OFFSET + 8)
+#define P1_Q3_RX_CONTEXT_OFFSET		(P1_Q2_RX_CONTEXT_OFFSET + 8)
+#define P1_Q2_RX_CONTEXT_OFFSET		(P1_Q1_RX_CONTEXT_OFFSET + 8)
+#define P1_Q1_RX_CONTEXT_OFFSET		(RX_CONTEXT_P1_Q1_OFFSET_ADDR)
+#define RX_CONTEXT_P1_Q1_OFFSET_ADDR	(P0_Q4_RX_CONTEXT_OFFSET + 8)
+
+/* Host Port Rx Context */
+#define P0_Q4_RX_CONTEXT_OFFSET		(P0_Q3_RX_CONTEXT_OFFSET + 8)
+#define P0_Q3_RX_CONTEXT_OFFSET		(P0_Q2_RX_CONTEXT_OFFSET + 8)
+#define P0_Q2_RX_CONTEXT_OFFSET		(P0_Q1_RX_CONTEXT_OFFSET + 8)
+#define P0_Q1_RX_CONTEXT_OFFSET		RX_CONTEXT_P0_Q1_OFFSET_ADDR
+#define RX_CONTEXT_P0_Q1_OFFSET_ADDR	(COL_TX_CONTEXT_P2_Q1_OFFSET_ADDR + 8)
+
+/* Port 2 Tx Collision Context */
+#define COL_TX_CONTEXT_P2_Q1_OFFSET_ADDR (COL_TX_CONTEXT_P1_Q1_OFFSET_ADDR + 8)
+/* Port 1 Tx Collision Context */
+#define COL_TX_CONTEXT_P1_Q1_OFFSET_ADDR (P2_Q4_TX_CONTEXT_OFFSET + 8)
+
+/* Port 2 */
+#define P2_Q4_TX_CONTEXT_OFFSET		(P2_Q3_TX_CONTEXT_OFFSET + 8)
+#define P2_Q3_TX_CONTEXT_OFFSET		(P2_Q2_TX_CONTEXT_OFFSET + 8)
+#define P2_Q2_TX_CONTEXT_OFFSET		(P2_Q1_TX_CONTEXT_OFFSET + 8)
+#define P2_Q1_TX_CONTEXT_OFFSET		TX_CONTEXT_P2_Q1_OFFSET_ADDR
+#define TX_CONTEXT_P2_Q1_OFFSET_ADDR	(P1_Q4_TX_CONTEXT_OFFSET + 8)
+
+/* Port 1 */
+#define P1_Q4_TX_CONTEXT_OFFSET		(P1_Q3_TX_CONTEXT_OFFSET + 8)
+#define P1_Q3_TX_CONTEXT_OFFSET		(P1_Q2_TX_CONTEXT_OFFSET + 8)
+#define P1_Q2_TX_CONTEXT_OFFSET		(P1_Q1_TX_CONTEXT_OFFSET + 8)
+#define P1_Q1_TX_CONTEXT_OFFSET		TX_CONTEXT_P1_Q1_OFFSET_ADDR
+#define TX_CONTEXT_P1_Q1_OFFSET_ADDR	SWITCH_SPECIFIC_DRAM1_START_OFFSET
+
 /* DRAM Offsets for EMAC
  * Present on Both DRAM0 and DRAM1
  */
-- 
2.43.0


