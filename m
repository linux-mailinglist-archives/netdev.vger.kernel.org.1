Return-Path: <netdev+bounces-64015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726EF830AD8
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 17:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF42228E83A
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 16:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E6022EFF;
	Wed, 17 Jan 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="AV6fFSL1"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2522EE5
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508185; cv=none; b=gzs0g7yA/7DSoZIddWktbm3wfAKMNLXoir9R48FuwVIXpj40dUSuY1DhMBqOwR1ZxkAO1HGreHpsvz+SRMYua4+XS6ooZiYViAaGa9KyORaOlzkzvKUINGuTlRvjdzkHei1BHmvDfR9DwOfdoxX02KKI+fDhZgOcg0DFR4IKPJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508185; c=relaxed/simple;
	bh=wUn/ifBBqYaaY/Anp1WMHkIrJSvlwlsgF3cQjps8nS8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID; b=sTY9GPZGyEcK/B30eyDIAJTKTOr4iU6rRFLIzqxGjkcprHwqFsUvAsWM33feQyYSVm/H4kbanb5tE4Pk+PnDM0cwcOMmNYrZZFa8IZu/bwTa/OrZlYiEYAlhXCWsYbqn3qwOfMX+xvYn45uLMRLvfvDh7xb2qUTu/E3gKy23scM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=AV6fFSL1; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240117161623f2db75faac4e1b1085
        for <netdev@vger.kernel.org>;
        Wed, 17 Jan 2024 17:16:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EEwZrH5Feku4V3FDACLnjgOFKj5BNY9868YFvEGGx/w=;
 b=AV6fFSL1c3mAYsYNlZm1SHUJ0+VwViX0QiolCnjJoJlIM+561gmi1HLW3kWMjJcKzYgeRq
 w+b8Iy+p1t1WDJPZQc8pJS9EIJRIYTaWdbWm0pZibRD1WtLXo05diA3wMwVyA5pUMdyz5zrX
 cvhMec6rHZ/VlZydq4E4wslq8w7Ac=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	dan.carpenter@linaro.org,
	robh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 7/8] net: ti: iccsg-prueth: Add necessary functions for SR1.0 support
Date: Wed, 17 Jan 2024 16:15:01 +0000
Message-ID: <20240117161602.153233-8-diogo.ivo@siemens.com>
In-Reply-To: <20240117161602.153233-1-diogo.ivo@siemens.com>
References: <20240117161602.153233-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Add functions required to correctly program the SR1.0 firmware for
network operation.

Based on the work of Roger Quadros, Vignesh Raghavendra and
Grygorii Strashko in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 255 +++++++++++++++++++
 1 file changed, 255 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 5ec2cdc16c51..db15c8680741 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -616,6 +616,101 @@ static int emac_get_tx_ts(struct prueth_emac *emac,
 	return 0;
 }
 
+static int emac_send_command_sr1(struct prueth_emac *emac, u32 cmd)
+{
+	dma_addr_t desc_dma, buf_dma;
+	struct prueth_tx_chn *tx_chn;
+	struct cppi5_host_desc_t *first_desc;
+	u32 *data = emac->cmd_data;
+	u32 pkt_len = sizeof(emac->cmd_data);
+	void **swdata;
+	int ret = 0;
+	u32 *epib;
+
+	netdev_dbg(emac->ndev, "Sending cmd %x\n", cmd);
+
+	/* only one command at a time allowed to firmware */
+	mutex_lock(&emac->cmd_lock);
+	data[0] = cpu_to_le32(cmd);
+
+	/* highest priority channel for management messages */
+	tx_chn = &emac->tx_chns[emac->tx_ch_num - 1];
+
+	/* Map the linear buffer */
+	buf_dma = dma_map_single(tx_chn->dma_dev, data, pkt_len, DMA_TO_DEVICE);
+	if (dma_mapping_error(tx_chn->dma_dev, buf_dma)) {
+		netdev_err(emac->ndev, "cmd %x: failed to map cmd buffer\n", cmd);
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
+	first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
+	if (!first_desc) {
+		netdev_err(emac->ndev, "cmd %x: failed to allocate descriptor\n", cmd);
+		dma_unmap_single(tx_chn->dma_dev, buf_dma, pkt_len, DMA_TO_DEVICE);
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	cppi5_hdesc_init(first_desc, CPPI5_INFO0_HDESC_EPIB_PRESENT,
+			 PRUETH_NAV_PS_DATA_SIZE);
+	cppi5_hdesc_set_pkttype(first_desc, PRUETH_PKT_TYPE_CMD);
+	epib = first_desc->epib;
+	epib[0] = 0;
+	epib[1] = 0;
+
+	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
+	swdata = cppi5_hdesc_get_swdata(first_desc);
+	*swdata = data;
+
+	cppi5_hdesc_set_pktlen(first_desc, pkt_len);
+	desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
+
+	/* send command */
+	reinit_completion(&emac->cmd_complete);
+	ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
+	if (ret) {
+		netdev_err(emac->ndev, "cmd %x: push failed: %d\n", cmd, ret);
+		goto free_desc;
+	}
+	ret = wait_for_completion_timeout(&emac->cmd_complete, msecs_to_jiffies(100));
+	if (!ret)
+		netdev_err(emac->ndev, "cmd %x: completion timeout\n", cmd);
+
+	mutex_unlock(&emac->cmd_lock);
+
+	return ret;
+free_desc:
+	prueth_xmit_free(tx_chn, first_desc);
+err_unlock:
+	mutex_unlock(&emac->cmd_lock);
+
+	return ret;
+}
+
+static void emac_change_port_speed_duplex_sr1(struct prueth_emac *emac)
+{
+	u32 cmd = ICSSG_PSTATE_SPEED_DUPLEX_CMD, val;
+	struct prueth *prueth = emac->prueth;
+	int slice = prueth_emac_slice(emac);
+
+	/* only full duplex supported for now */
+	if (emac->duplex != DUPLEX_FULL)
+		return;
+
+	val = icssg_rgmii_get_speed(prueth->miig_rt, slice);
+	/* firmware expects full duplex settings in bit 2-1 */
+	val <<= 1;
+	cmd |= val;
+
+	val = icssg_rgmii_get_fullduplex(prueth->miig_rt, slice);
+	/* firmware expects full duplex settings in bit 3 */
+	val <<= 3;
+	cmd |= val;
+
+	emac_send_command_sr1(emac, cmd);
+}
+
 static void tx_ts_work(struct prueth_emac *emac)
 {
 	struct skb_shared_hwtstamps ssh;
@@ -873,6 +968,141 @@ static irqreturn_t prueth_tx_ts_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/* get one packet from requested flow_id
+ *
+ * Returns skb pointer if packet found else NULL
+ * Caller must free the returned skb.
+ */
+static struct sk_buff *prueth_process_rx_mgm(struct prueth_emac *emac,
+					     u32 flow_id)
+{
+	struct prueth_rx_chn *rx_chn = &emac->rx_mgm_chn;
+	struct net_device *ndev = emac->ndev;
+	struct cppi5_host_desc_t *desc_rx;
+	struct sk_buff *skb, *new_skb;
+	dma_addr_t desc_dma, buf_dma;
+	u32 buf_dma_len, pkt_len;
+	void **swdata;
+	int ret;
+
+	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
+	if (ret) {
+		if (ret != -ENODATA)
+			netdev_err(ndev, "rx mgm pop: failed: %d\n", ret);
+		return NULL;
+	}
+
+	if (cppi5_desc_is_tdcm(desc_dma)) /* Teardown */
+		return NULL;
+
+	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
+
+	/* Fix FW bug about incorrect PSDATA size */
+	if (cppi5_hdesc_get_psdata_size(desc_rx) != PRUETH_NAV_PS_DATA_SIZE) {
+		cppi5_hdesc_update_psdata_size(desc_rx,
+					       PRUETH_NAV_PS_DATA_SIZE);
+	}
+
+	swdata = cppi5_hdesc_get_swdata(desc_rx);
+	skb = *swdata;
+	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
+	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
+
+	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
+	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
+
+	new_skb = netdev_alloc_skb_ip_align(ndev, PRUETH_MAX_PKT_SIZE);
+	/* if allocation fails we drop the packet but push the
+	 * descriptor back to the ring with old skb to prevent a stall
+	 */
+	if (!new_skb) {
+		netdev_err(ndev,
+			   "skb alloc failed, dropped mgm pkt from flow %d\n",
+			   flow_id);
+		new_skb = skb;
+		skb = NULL;	/* return NULL */
+	} else {
+		/* return the filled skb */
+		skb_put(skb, pkt_len);
+	}
+
+	/* queue another DMA */
+	ret = prueth_dma_rx_push(emac, new_skb, &emac->rx_mgm_chn);
+	if (WARN_ON(ret < 0))
+		dev_kfree_skb_any(new_skb);
+
+	return skb;
+}
+
+static void prueth_tx_ts_sr1(struct prueth_emac *emac,
+			     struct emac_tx_ts_response_sr1 *tsr)
+{
+	u64 ns;
+	struct skb_shared_hwtstamps ssh;
+	struct sk_buff *skb;
+
+	ns = (u64)tsr->hi_ts << 32 | tsr->lo_ts;
+
+	if (tsr->cookie >= PRUETH_MAX_TX_TS_REQUESTS) {
+		netdev_dbg(emac->ndev, "Invalid TX TS cookie 0x%x\n",
+			   tsr->cookie);
+		return;
+	}
+
+	skb = emac->tx_ts_skb[tsr->cookie];
+	emac->tx_ts_skb[tsr->cookie] = NULL;	/* free slot */
+
+	memset(&ssh, 0, sizeof(ssh));
+	ssh.hwtstamp = ns_to_ktime(ns);
+
+	skb_tstamp_tx(skb, &ssh);
+	dev_consume_skb_any(skb);
+}
+
+static irqreturn_t prueth_rx_mgm_ts_thread_sr1(int irq, void *dev_id)
+{
+	struct prueth_emac *emac = dev_id;
+	struct sk_buff *skb;
+
+	skb = prueth_process_rx_mgm(emac, PRUETH_RX_MGM_FLOW_TIMESTAMP);
+	if (!skb)
+		return IRQ_NONE;
+
+	prueth_tx_ts_sr1(emac, (void *)skb->data);
+	dev_kfree_skb_any(skb);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t prueth_rx_mgm_rsp_thread(int irq, void *dev_id)
+{
+	struct prueth_emac *emac = dev_id;
+	struct sk_buff *skb;
+	u32 rsp;
+
+	skb = prueth_process_rx_mgm(emac, PRUETH_RX_MGM_FLOW_RESPONSE);
+	if (!skb)
+		return IRQ_NONE;
+
+	/* Process command response */
+	rsp = le32_to_cpu(*(u32 *)skb->data);
+	if ((rsp & 0xffff0000) == ICSSG_SHUTDOWN_CMD) {
+		netdev_dbg(emac->ndev,
+			   "f/w Shutdown cmd resp %x\n", rsp);
+		complete(&emac->cmd_complete);
+	} else if ((rsp & 0xffff0000) ==
+		ICSSG_PSTATE_SPEED_DUPLEX_CMD) {
+		netdev_dbg(emac->ndev,
+			   "f/w Speed/Duplex cmd rsp %x\n",
+			    rsp);
+		complete(&emac->cmd_complete);
+	}
+
+	dev_kfree_skb_any(skb);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t prueth_rx_irq(int irq, void *dev_id)
 {
 	struct prueth_emac *emac = dev_id;
@@ -1517,6 +1747,31 @@ static void emac_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue)
 	ndev->stats.tx_errors++;
 }
 
+static void emac_ndo_set_rx_mode_sr1(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	int slice = prueth_emac_slice(emac);
+	bool promisc = ndev->flags & IFF_PROMISC;
+	bool allmulti = ndev->flags & IFF_ALLMULTI;
+
+	if (promisc) {
+		icssg_class_promiscuous_sr1(prueth->miig_rt, slice);
+		return;
+	}
+
+	if (allmulti) {
+		icssg_class_default(prueth->miig_rt, slice, 1, true);
+		return;
+	}
+
+	icssg_class_default(prueth->miig_rt, slice, 0, true);
+	if (!netdev_mc_empty(ndev)) {
+		/* program multicast address list into Classifier */
+		icssg_class_add_mcast_sr1(prueth->miig_rt, slice, ndev);
+	}
+}
+
 static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 {
 	struct prueth_emac *emac = container_of(work, struct prueth_emac, rx_mode_work);
-- 
2.43.0


