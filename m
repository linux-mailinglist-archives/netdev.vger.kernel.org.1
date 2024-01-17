Return-Path: <netdev+bounces-64016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C11B830AD9
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 17:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990E7B26A17
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEE022F0E;
	Wed, 17 Jan 2024 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="Y65dHWy2"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891E22EFA
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508187; cv=none; b=gMsNiSCoLl0fRRgjbVXI/qZJ0FLA5q2/+owzCI2o50ViTJO+8tV0TEpwNucnTp5GQUaUvp/W6h5iBhy5LNjtTiR9Naz/rC2RWHewss+UG1AQsPY2jJYKllqChYQsn5kvzA9aN29mH/FqrpYlu2lNR6LGAHSSOSKAOxoQg4qW2C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508187; c=relaxed/simple;
	bh=m1oCl2GteQT3p7Cy3NGDrHZw41300rHBsVvXHKZaXOw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID; b=L80wflYWbp/Q1jS6A2Ctx3Z33RjzBE9nHjqPIf16nQdnpygKOBoG7TXROcTPWHXrcS3cXSttLauWfjGbmeyuawpBFa9bvTeYK1U4MO7tTsWUUzEIP1jvaap5uv783I1cPkvOE3LwpF2c1TphLjoXBmnJe7tBDYIAJhrNMOUqMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=Y65dHWy2; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240117161624d4cb3b2bd6c5ae7d9d
        for <netdev@vger.kernel.org>;
        Wed, 17 Jan 2024 17:16:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vknBMSGqxm7QwJKb4mgufGpfTitGC/9Oh3kfUHYDmXY=;
 b=Y65dHWy239h1+Z3Ul3Fhzoym6/R3GEPzbtEqDE2EJnevioA6pszPgFGiEu+nsvf05/SpQu
 IrdTVPt8wW76VlPRP+A9Yiw7Xnhl8wczMlCmj78SZjr4eoeg0kN2obVNoWAqtecnMFHf/x14
 +xPPoRrQDtMEgr4r4dvq9OqX76S8w=;
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
Subject: [PATCH v2 8/8] net: ti: icssg-prueth: Wire up support for SR1.0
Date: Wed, 17 Jan 2024 16:15:02 +0000
Message-ID: <20240117161602.153233-9-diogo.ivo@siemens.com>
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

Add the function calls to enable operation for SR1.0.

Based on the work of Roger Quadros, Vignesh Raghavendra and
Grygorii Strashko in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
Changes in v2:
 - Removed explicit references to SR2.0

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 299 +++++++++++++++----
 1 file changed, 239 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index db15c8680741..352fb1cb3aba 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -169,6 +169,13 @@ static int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 						     desc_dma);
 		swdata = cppi5_hdesc_get_swdata(desc_tx);
 
+		/* was this command's TX complete? */
+		if (emac->is_sr1 && *(swdata) == emac->cmd_data) {
+			prueth_xmit_free(tx_chn, desc_tx);
+			budget++;	/* not a data packet */
+			continue;
+		}
+
 		skb = *(swdata);
 		prueth_xmit_free(tx_chn, desc_tx);
 
@@ -344,6 +351,7 @@ static int prueth_init_rx_chns(struct prueth_emac *emac,
 	struct net_device *ndev = emac->ndev;
 	u32 fdqring_id, hdesc_size;
 	int i, ret = 0, slice;
+	int flow_id_base;
 
 	slice = prueth_emac_slice(emac);
 	if (slice < 0)
@@ -384,8 +392,14 @@ static int prueth_init_rx_chns(struct prueth_emac *emac,
 		goto fail;
 	}
 
-	emac->rx_flow_id_base = k3_udma_glue_rx_get_flow_id_base(rx_chn->rx_chn);
-	netdev_dbg(ndev, "flow id base = %d\n", emac->rx_flow_id_base);
+	flow_id_base = k3_udma_glue_rx_get_flow_id_base(rx_chn->rx_chn);
+	if (!strcmp(name, "rxmgm")) {
+		emac->rx_mgm_flow_id_base = flow_id_base;
+		netdev_dbg(ndev, "mgm flow id base = %d\n", flow_id_base);
+	} else {
+		emac->rx_flow_id_base = flow_id_base;
+		netdev_dbg(ndev, "flow id base = %d\n", flow_id_base);
+	}
 
 	fdqring_id = K3_RINGACC_RING_ID_ANY;
 	for (i = 0; i < rx_cfg.flow_id_num; i++) {
@@ -494,10 +508,14 @@ static void emac_rx_timestamp(struct prueth_emac *emac,
 	struct skb_shared_hwtstamps *ssh;
 	u64 ns;
 
-	u32 hi_sw = readl(emac->prueth->shram.va +
-			  TIMESYNC_FW_WC_COUNT_HI_SW_OFFSET_OFFSET);
-	ns = icssg_ts_to_ns(hi_sw, psdata[1], psdata[0],
-			    IEP_DEFAULT_CYCLE_TIME_NS);
+	if (emac->is_sr1) {
+		ns = (u64)psdata[1] << 32 | psdata[0];
+	} else {
+		u32 hi_sw = readl(emac->prueth->shram.va +
+				  TIMESYNC_FW_WC_COUNT_HI_SW_OFFSET_OFFSET);
+		ns = icssg_ts_to_ns(hi_sw, psdata[1], psdata[0],
+				    IEP_DEFAULT_CYCLE_TIME_NS);
+	}
 
 	ssh = skb_hwtstamps(skb);
 	memset(ssh, 0, sizeof(*ssh));
@@ -1119,6 +1137,17 @@ struct icssg_firmwares {
 	char *txpru;
 };
 
+static struct icssg_firmwares icssg_emac_firmwares_sr1[] = {
+	{
+		.pru = "ti-pruss/am65x-pru0-prueth-fw.elf",
+		.rtu = "ti-pruss/am65x-rtu0-prueth-fw.elf",
+	},
+	{
+		.pru = "ti-pruss/am65x-pru1-prueth-fw.elf",
+		.rtu = "ti-pruss/am65x-rtu1-prueth-fw.elf",
+	}
+};
+
 static struct icssg_firmwares icssg_emac_firmwares[] = {
 	{
 		.pru = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
@@ -1138,7 +1167,8 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
 	struct device *dev = prueth->dev;
 	int slice, ret;
 
-	firmwares = icssg_emac_firmwares;
+	firmwares = prueth->pdata.is_sr1 ? icssg_emac_firmwares_sr1
+					 : icssg_emac_firmwares;
 
 	slice = prueth_emac_slice(emac);
 	if (slice < 0) {
@@ -1164,11 +1194,15 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
 		goto halt_pru;
 	}
 
-	ret = rproc_set_firmware(prueth->txpru[slice], firmwares[slice].txpru);
-	ret = rproc_boot(prueth->txpru[slice]);
-	if (ret) {
-		dev_err(dev, "failed to boot TX_PRU%d: %d\n", slice, ret);
-		goto halt_rtu;
+	if (!emac->is_sr1) {
+		ret = rproc_set_firmware(prueth->txpru[slice],
+					 firmwares[slice].txpru);
+		ret = rproc_boot(prueth->txpru[slice]);
+		if (ret) {
+			dev_err(dev, "failed to boot TX_PRU%d: %d\n",
+				slice, ret);
+			goto halt_rtu;
+		}
 	}
 
 	emac->fw_running = 1;
@@ -1201,7 +1235,8 @@ static void prueth_emac_stop(struct prueth_emac *emac)
 	}
 
 	emac->fw_running = 0;
-	rproc_shutdown(prueth->txpru[slice]);
+	if (!emac->is_sr1)
+		rproc_shutdown(prueth->txpru[slice]);
 	rproc_shutdown(prueth->rtu[slice]);
 	rproc_shutdown(prueth->pru[slice]);
 }
@@ -1269,11 +1304,15 @@ static void emac_adjust_link(struct net_device *ndev)
 			icssg_config_ipg(emac);
 			spin_unlock_irqrestore(&emac->lock, flags);
 			icssg_config_set_speed(emac);
-			emac_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
+			if (!emac->is_sr1)
+				emac_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
 
-		} else {
+		} else if (!emac->is_sr1) {
 			emac_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
 		}
+
+		if (emac->is_sr1 && emac->link)
+			emac_change_port_speed_duplex_sr1(emac);
 	}
 
 	if (emac->link) {
@@ -1288,8 +1327,10 @@ static void emac_adjust_link(struct net_device *ndev)
 static int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 {
 	struct prueth_emac *emac = prueth_napi_to_emac(napi_rx);
-	int rx_flow = PRUETH_RX_FLOW_DATA;
-	int flow = PRUETH_MAX_RX_FLOWS;
+	int rx_flow = emac->is_sr1 ?
+			PRUETH_RX_FLOW_DATA_SR1 : PRUETH_RX_FLOW_DATA;
+	int flow = emac->is_sr1 ?
+			PRUETH_MAX_RX_FLOWS_SR1 : PRUETH_MAX_RX_FLOWS;
 	int num_rx = 0;
 	int cur_budget;
 	int ret;
@@ -1553,11 +1594,19 @@ static int emac_ndo_open(struct net_device *ndev)
 		memset_io(prueth->shram.va, 0, ICSSG_CONFIG_OFFSET_SLICE1 * PRUETH_NUM_MACS);
 	}
 
+	if (emac->is_sr1) {
+		/* For SR1, high priority channel is used exclusively for
+		 * management messages. Do reduce number of data channels.
+		 */
+		num_data_chn--;
+	}
+
 	/* set h/w MAC as user might have re-configured */
 	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
 
 	icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
-	icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
+	if (!emac->is_sr1)
+		icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
 
 	icssg_class_default(prueth->miig_rt, slice, 0, emac->is_sr1);
 
@@ -1575,7 +1624,8 @@ static int emac_ndo_open(struct net_device *ndev)
 		return ret;
 	}
 
-	max_rx_flows = PRUETH_MAX_RX_FLOWS;
+	max_rx_flows = emac->is_sr1 ?
+			PRUETH_MAX_RX_FLOWS_SR1 : PRUETH_MAX_RX_FLOWS;
 	ret = prueth_init_rx_chns(emac, &emac->rx_chns, "rx",
 				  max_rx_flows, PRUETH_MAX_RX_DESC);
 	if (ret) {
@@ -1583,12 +1633,24 @@ static int emac_ndo_open(struct net_device *ndev)
 		goto cleanup_tx;
 	}
 
+	if (emac->is_sr1) {
+		ret = prueth_init_rx_chns(emac, &emac->rx_mgm_chn, "rxmgm",
+					  PRUETH_MAX_RX_MGM_FLOWS,
+					  PRUETH_MAX_RX_MGM_DESC);
+		if (ret) {
+			dev_err(dev, "failed to init rx mgmt channel: %d\n",
+				ret);
+			goto cleanup_rx;
+		}
+	}
+
 	ret = prueth_ndev_add_tx_napi(emac);
 	if (ret)
-		goto cleanup_rx;
+		goto cleanup_rx_mgm;
 
 	/* we use only the highest priority flow for now i.e. @irq[3] */
-	rx_flow = PRUETH_RX_FLOW_DATA;
+	rx_flow = emac->is_sr1 ?
+			PRUETH_RX_FLOW_DATA_SR1 : PRUETH_RX_FLOW_DATA;
 	ret = request_irq(emac->rx_chns.irq[rx_flow], prueth_rx_irq,
 			  IRQF_TRIGGER_HIGH, dev_name(dev), emac);
 	if (ret) {
@@ -1596,31 +1658,66 @@ static int emac_ndo_open(struct net_device *ndev)
 		goto cleanup_napi;
 	}
 
+	if (!emac->is_sr1)
+		goto skip_mgm_irq;
+
+	ret = request_threaded_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_RESPONSE],
+				   NULL, prueth_rx_mgm_rsp_thread,
+				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+				   dev_name(dev), emac);
+	if (ret) {
+		dev_err(dev, "unable to request RX Management RSP IRQ\n");
+		goto free_rx_irq;
+	}
+
+	ret = request_threaded_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_TIMESTAMP],
+				   NULL, prueth_rx_mgm_ts_thread_sr1,
+				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+				   dev_name(dev), emac);
+	if (ret) {
+		dev_err(dev, "unable to request RX Management TS IRQ\n");
+		goto free_rx_mgm_rsp_irq;
+	}
+
+skip_mgm_irq:
 	/* reset and start PRU firmware */
 	ret = prueth_emac_start(prueth, emac);
 	if (ret)
-		goto free_rx_irq;
+		goto free_rx_mgmt_ts_irq;
 
 	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
 
-	if (!prueth->emacs_initialized) {
+	if (!emac->is_sr1 && !prueth->emacs_initialized) {
 		ret = icss_iep_init(emac->iep, &prueth_iep_clockops,
 				    emac, IEP_DEFAULT_CYCLE_TIME_NS);
 	}
 
-	ret = request_threaded_irq(emac->tx_ts_irq, NULL, prueth_tx_ts_irq,
-				   IRQF_ONESHOT, dev_name(dev), emac);
-	if (ret)
-		goto stop;
+	if (!emac->is_sr1) {
+		ret = request_threaded_irq(emac->tx_ts_irq, NULL,
+					   prueth_tx_ts_irq, IRQF_ONESHOT,
+					   dev_name(dev), emac);
+		if (ret)
+			goto stop;
+	}
 
 	/* Prepare RX */
 	ret = prueth_prepare_rx_chan(emac, &emac->rx_chns, PRUETH_MAX_PKT_SIZE);
 	if (ret)
 		goto free_tx_ts_irq;
 
+	if (emac->is_sr1) {
+		ret = prueth_prepare_rx_chan(emac, &emac->rx_mgm_chn, 64);
+		if (ret)
+			goto reset_rx_chn;
+
+		ret = k3_udma_glue_enable_rx_chn(emac->rx_mgm_chn.rx_chn);
+		if (ret)
+			goto reset_rx_chn;
+	}
+
 	ret = k3_udma_glue_enable_rx_chn(emac->rx_chns.rx_chn);
 	if (ret)
-		goto reset_rx_chn;
+		goto reset_rx_mgm_chn;
 
 	for (i = 0; i < emac->tx_ch_num; i++) {
 		ret = k3_udma_glue_enable_tx_chn(emac->tx_chns[i].tx_chn);
@@ -1647,16 +1744,33 @@ static int emac_ndo_open(struct net_device *ndev)
 	 * any SKB for completion. So set false to free_skb
 	 */
 	prueth_reset_tx_chan(emac, i, false);
+reset_rx_mgm_chn:
+	if (emac->is_sr1)
+		prueth_reset_rx_chan(&emac->rx_mgm_chn,
+				     PRUETH_MAX_RX_MGM_FLOWS, true);
 reset_rx_chn:
 	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, false);
 free_tx_ts_irq:
-	free_irq(emac->tx_ts_irq, emac);
+	if (!emac->is_sr1)
+		free_irq(emac->tx_ts_irq, emac);
 stop:
 	prueth_emac_stop(emac);
+free_rx_mgmt_ts_irq:
+	if (emac->is_sr1)
+		free_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_TIMESTAMP],
+			 emac);
+free_rx_mgm_rsp_irq:
+	if (emac->is_sr1)
+		free_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_RESPONSE],
+			 emac);
 free_rx_irq:
 	free_irq(emac->rx_chns.irq[rx_flow], emac);
 cleanup_napi:
 	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
+cleanup_rx_mgm:
+	if (emac->is_sr1)
+		prueth_cleanup_rx_chns(emac, &emac->rx_mgm_chn,
+				       PRUETH_MAX_RX_MGM_FLOWS);
 cleanup_rx:
 	prueth_cleanup_rx_chns(emac, &emac->rx_chns, max_rx_flows);
 cleanup_tx:
@@ -1677,7 +1791,8 @@ static int emac_ndo_stop(struct net_device *ndev)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 	struct prueth *prueth = emac->prueth;
-	int rx_flow = PRUETH_RX_FLOW_DATA;
+	int rx_flow = emac->is_sr1 ? PRUETH_RX_FLOW_DATA_SR1 :
+				     PRUETH_RX_FLOW_DATA;
 	int max_rx_flows;
 	int ret, i;
 
@@ -1690,6 +1805,9 @@ static int emac_ndo_stop(struct net_device *ndev)
 
 	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
 
+	if (emac->is_sr1)
+		emac_send_command_sr1(emac, ICSSG_SHUTDOWN_CMD);
+
 	atomic_set(&emac->tdown_cnt, emac->tx_ch_num);
 	/* ensure new tdown_cnt value is visible */
 	smp_mb__after_atomic();
@@ -1707,10 +1825,17 @@ static int emac_ndo_stop(struct net_device *ndev)
 	for (i = 0; i < emac->tx_ch_num; i++)
 		napi_disable(&emac->tx_chns[i].napi_tx);
 
-	max_rx_flows = PRUETH_MAX_RX_FLOWS;
+	max_rx_flows = emac->is_sr1 ?
+			PRUETH_MAX_RX_FLOWS_SR1 : PRUETH_MAX_RX_FLOWS;
 	k3_udma_glue_tdown_rx_chn(emac->rx_chns.rx_chn, true);
 
 	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, true);
+	if (emac->is_sr1) {
+		/* Teardown RX MGM channel */
+		k3_udma_glue_tdown_rx_chn(emac->rx_mgm_chn.rx_chn, true);
+		prueth_reset_rx_chan(&emac->rx_mgm_chn,
+				     PRUETH_MAX_RX_MGM_FLOWS, true);
+	}
 
 	napi_disable(&emac->napi_rx);
 
@@ -1722,18 +1847,28 @@ static int emac_ndo_stop(struct net_device *ndev)
 	/* stop PRUs */
 	prueth_emac_stop(emac);
 
-	if (prueth->emacs_initialized == 1)
+	if (!emac->is_sr1 && prueth->emacs_initialized == 1)
 		icss_iep_exit(emac->iep);
 
 	/* stop PRUs */
 	prueth_emac_stop(emac);
 
-	free_irq(emac->tx_ts_irq, emac);
+	if (!emac->is_sr1)
+		free_irq(emac->tx_ts_irq, emac);
 
+	if (emac->is_sr1) {
+		free_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_TIMESTAMP],
+			 emac);
+		free_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_RESPONSE],
+			 emac);
+	}
 	free_irq(emac->rx_chns.irq[rx_flow], emac);
 	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
 	prueth_cleanup_tx_chns(emac);
 
+	if (emac->is_sr1)
+		prueth_cleanup_rx_chns(emac, &emac->rx_mgm_chn,
+				       PRUETH_MAX_RX_MGM_FLOWS);
 	prueth_cleanup_rx_chns(emac, &emac->rx_chns, max_rx_flows);
 	prueth_cleanup_tx_chns(emac);
 
@@ -1814,7 +1949,10 @@ static void emac_ndo_set_rx_mode(struct net_device *ndev)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 
-	queue_work(emac->cmd_wq, &emac->rx_mode_work);
+	if (emac->is_sr1)
+		emac_ndo_set_rx_mode_sr1(ndev);
+	else
+		queue_work(emac->cmd_wq, &emac->rx_mode_work);
 }
 
 static int emac_set_ts_config(struct net_device *ndev, struct ifreq *ifr)
@@ -1994,6 +2132,10 @@ static int prueth_netdev_init(struct prueth *prueth,
 	if (mac == PRUETH_MAC_INVALID)
 		return -EINVAL;
 
+	/* Use 1 channel for management messages on SR1 */
+	if (prueth->pdata.is_sr1)
+		num_tx_chn--;
+
 	ndev = alloc_etherdev_mq(sizeof(*emac), num_tx_chn);
 	if (!ndev)
 		return -ENOMEM;
@@ -2021,7 +2163,15 @@ static int prueth_netdev_init(struct prueth *prueth,
 		goto free_wq;
 	}
 
+	emac->is_sr1 = prueth->pdata.is_sr1;
 	emac->tx_ch_num = 1;
+	if (emac->is_sr1) {
+		/* use a dedicated high priority channel for management
+		 * messages which is +1 of highest priority data channel.
+		 */
+		emac->tx_ch_num++;
+		goto skip_irq;
+	}
 
 	irq_name = "tx_ts0";
 	if (emac->port_id == PRUETH_PORT_MII1)
@@ -2032,6 +2182,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 		goto free;
 	}
 
+skip_irq:
 	SET_NETDEV_DEV(ndev, prueth->dev);
 	spin_lock_init(&emac->lock);
 	mutex_init(&emac->cmd_lock);
@@ -2158,7 +2309,7 @@ static int prueth_get_cores(struct prueth *prueth, int slice)
 		idx = 0;
 		break;
 	case ICSS_SLICE1:
-		idx = 3;
+		idx = prueth->pdata.is_sr1 ? 2 : 3;
 		break;
 	default:
 		return -EINVAL;
@@ -2180,6 +2331,9 @@ static int prueth_get_cores(struct prueth *prueth, int slice)
 		return dev_err_probe(dev, ret, "unable to get RTU%d\n", slice);
 	}
 
+	if (prueth->pdata.is_sr1)
+		return 0;
+
 	idx++;
 	prueth->txpru[slice] = pru_rproc_get(np, idx, NULL);
 	if (IS_ERR(prueth->txpru[slice])) {
@@ -2329,14 +2483,20 @@ static int prueth_probe(struct platform_device *pdev)
 		goto put_mem;
 	}
 
-	msmc_ram_size = MSMC_RAM_SIZE;
+	msmc_ram_size = prueth->pdata.is_sr1 ? MSMC_RAM_SIZE_SR1 : MSMC_RAM_SIZE;
 
-	/* NOTE: FW bug needs buffer base to be 64KB aligned */
-	prueth->msmcram.va =
-		(void __iomem *)gen_pool_alloc_algo(prueth->sram_pool,
-						    msmc_ram_size,
-						    gen_pool_first_fit_align,
-						    &gp_data);
+	if (prueth->pdata.is_sr1) {
+		prueth->msmcram.va =
+			(void __iomem *)gen_pool_alloc(prueth->sram_pool,
+						       msmc_ram_size);
+	} else {
+		/* NOTE: FW bug needs buffer base to be 64KB aligned */
+		prueth->msmcram.va =
+			(void __iomem *)gen_pool_alloc_algo(prueth->sram_pool,
+							    msmc_ram_size,
+							    gen_pool_first_fit_align,
+							    &gp_data);
+	}
 
 	if (!prueth->msmcram.va) {
 		ret = -ENOMEM;
@@ -2350,17 +2510,19 @@ static int prueth_probe(struct platform_device *pdev)
 	dev_dbg(dev, "sram: pa %llx va %p size %zx\n", prueth->msmcram.pa,
 		prueth->msmcram.va, prueth->msmcram.size);
 
-	prueth->iep0 = icss_iep_get_idx(np, 0);
-	if (IS_ERR(prueth->iep0)) {
-		ret = dev_err_probe(dev, PTR_ERR(prueth->iep0), "iep0 get failed\n");
-		prueth->iep0 = NULL;
-		goto free_pool;
-	}
+	if (!prueth->pdata.is_sr1) {
+		prueth->iep0 = icss_iep_get_idx(np, 0);
+		if (IS_ERR(prueth->iep0)) {
+			ret = dev_err_probe(dev, PTR_ERR(prueth->iep0), "iep0 get failed\n");
+			prueth->iep0 = NULL;
+			goto free_pool;
+		}
 
-	prueth->iep1 = icss_iep_get_idx(np, 1);
-	if (IS_ERR(prueth->iep1)) {
-		ret = dev_err_probe(dev, PTR_ERR(prueth->iep1), "iep1 get failed\n");
-		goto put_iep0;
+		prueth->iep1 = icss_iep_get_idx(np, 1);
+		if (IS_ERR(prueth->iep1)) {
+			ret = dev_err_probe(dev, PTR_ERR(prueth->iep1), "iep1 get failed\n");
+			goto put_iep0;
+		}
 	}
 
 	if (prueth->pdata.quirk_10m_link_issue) {
@@ -2382,7 +2544,8 @@ static int prueth_probe(struct platform_device *pdev)
 		if (of_find_property(eth0_node, "ti,half-duplex-capable", NULL))
 			prueth->emac[PRUETH_MAC0]->half_duplex = 1;
 
-		prueth->emac[PRUETH_MAC0]->iep = prueth->iep0;
+		if (!prueth->pdata.is_sr1)
+			prueth->emac[PRUETH_MAC0]->iep = prueth->iep0;
 	}
 
 	if (eth1_node) {
@@ -2396,7 +2559,8 @@ static int prueth_probe(struct platform_device *pdev)
 		if (of_find_property(eth1_node, "ti,half-duplex-capable", NULL))
 			prueth->emac[PRUETH_MAC1]->half_duplex = 1;
 
-		prueth->emac[PRUETH_MAC1]->iep = prueth->iep0;
+		if (!prueth->pdata.is_sr1)
+			prueth->emac[PRUETH_MAC1]->iep = prueth->iep0;
 	}
 
 	/* register the network devices */
@@ -2457,10 +2621,13 @@ static int prueth_probe(struct platform_device *pdev)
 exit_iep:
 	if (prueth->pdata.quirk_10m_link_issue)
 		icss_iep_exit_fw(prueth->iep1);
-	icss_iep_put(prueth->iep1);
+
+	if (!prueth->pdata.is_sr1)
+		icss_iep_put(prueth->iep1);
 
 put_iep0:
-	icss_iep_put(prueth->iep0);
+	if (!prueth->pdata.is_sr1)
+		icss_iep_put(prueth->iep0);
 	prueth->iep0 = NULL;
 	prueth->iep1 = NULL;
 
@@ -2511,15 +2678,21 @@ static void prueth_remove(struct platform_device *pdev)
 		prueth_netdev_exit(prueth, eth_node);
 	}
 
-	if (prueth->pdata.quirk_10m_link_issue)
+	if (prueth->pdata.is_sr1) {
+		icss_iep_exit(prueth->iep1);
+		icss_iep_exit(prueth->iep0);
+	} else if (prueth->pdata.quirk_10m_link_issue) {
 		icss_iep_exit_fw(prueth->iep1);
+	}
 
-	icss_iep_put(prueth->iep1);
-	icss_iep_put(prueth->iep0);
+	if (!prueth->pdata.is_sr1) {
+		icss_iep_put(prueth->iep1);
+		icss_iep_put(prueth->iep0);
+	}
 
 	gen_pool_free(prueth->sram_pool,
 		      (unsigned long)prueth->msmcram.va,
-		      MSMC_RAM_SIZE);
+		      prueth->pdata.is_sr1 ? MSMC_RAM_SIZE_SR1 : MSMC_RAM_SIZE);
 
 	pruss_release_mem_region(prueth->pruss, &prueth->shram);
 
@@ -2588,6 +2761,11 @@ static const struct dev_pm_ops prueth_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(prueth_suspend, prueth_resume)
 };
 
+static const struct prueth_pdata am654_icssg_pdata_sr1 = {
+	.fdqring_mode = K3_RINGACC_RING_MODE_MESSAGE,
+	.is_sr1 = 1,
+};
+
 static const struct prueth_pdata am654_icssg_pdata = {
 	.fdqring_mode = K3_RINGACC_RING_MODE_MESSAGE,
 	.quirk_10m_link_issue = 1,
@@ -2598,6 +2776,7 @@ static const struct prueth_pdata am64x_icssg_pdata = {
 };
 
 static const struct of_device_id prueth_dt_match[] = {
+	{ .compatible = "ti,am654-sr1-icssg-prueth", .data = &am654_icssg_pdata_sr1 },
 	{ .compatible = "ti,am654-icssg-prueth", .data = &am654_icssg_pdata },
 	{ .compatible = "ti,am642-icssg-prueth", .data = &am64x_icssg_pdata },
 	{ /* sentinel */ }
-- 
2.43.0


