Return-Path: <netdev+bounces-77476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F10871E49
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1716D284C02
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD95D58208;
	Tue,  5 Mar 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="knH79Typ"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980256B8A
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639511; cv=none; b=XN/BILUN7tJxA3SDQlBnvI/MQ93ezKmgf6IQowOUX0MlIexiAHaODkPEpkTE+S7IT/kwzpiSKJkyPjsSq66MzJMxdbx/7m0qKe/cdV9x3bjEN7gPqQv2Gxpm/VWInBdppxUVOOlTGFth9I/GMZStbdpuklW+1/WrkovMDEjfej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639511; c=relaxed/simple;
	bh=3jx+DZS8UXa9h5hN39TxxYD1H3AV9vGFLsN1pTf4f6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2uelcb1lZPppzeih2tkOpY5H4SQHKO+1gAgr3jqf6FoNskVpOgwDb2dQzDW0Jt8kvyZrXRSWHu3kR7kInFEWxNO20LlnvOFnF2kVQdBl8MId5bkf3JFYF460OQGfhlstGrzFfQsOeryBMWTZEUmbhBJBh6XOO0c33rv+4EwL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=knH79Typ; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240305114115e9dbbce50dd6696f0b
        for <netdev@vger.kernel.org>;
        Tue, 05 Mar 2024 12:41:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0IFPQGPGEI072jEKp1opo/0RdBBMiLD3/OEmOLJBEt0=;
 b=knH79TypnseRi1OnMO1K15LC5j42bzbhkCVmKFLzPK4AJw+rCOmbq5mOPPr0glXWXhCKU7
 0rXaPdKCUQ4Q6Kb6nAeHcqZMrUJyYC472NOPmnhTfG5nr8ZXPqu67xjZsOF8gkdidgN53ED/
 tPybn+ZVHhAr9OU6fbVF7QqfuiqVQ=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	dan.carpenter@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	jan.kiszka@siemens.com
Subject: [PATCH net-next v4 09/10] net: ti: icssg-prueth: Modify common functions for SR1.0
Date: Tue,  5 Mar 2024 11:40:29 +0000
Message-ID: <20240305114045.388893-10-diogo.ivo@siemens.com>
In-Reply-To: <20240305114045.388893-1-diogo.ivo@siemens.com>
References: <20240305114045.388893-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Some parts of the logic differ only slightly between Silicon Revisions.
In these cases add the bits that differ to a common function that
executes those bits conditionally based on the Silicon Revision.

Based on the work of Roger Quadros, Vignesh Raghavendra and
Grygorii Strashko in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
Changes in v4:
 - Explicitly check for SR1.0 when managing rxmgm channel
 - Pass is_sr1 = false to prueth_get_cores() from SR2.0 driver

 drivers/net/ethernet/ti/icssg/icssg_common.c | 46 +++++++++++++++-----
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |  4 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 +-
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 99f27ecc9352..862467771910 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -152,6 +152,13 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 						     desc_dma);
 		swdata = cppi5_hdesc_get_swdata(desc_tx);
 
+		/* was this command's TX complete? */
+		if (emac->is_sr1 && *(swdata) == emac->cmd_data) {
+			prueth_xmit_free(tx_chn, desc_tx);
+			budget++;       /* not a data packet */
+			continue;
+		}
+
 		skb = *(swdata);
 		prueth_xmit_free(tx_chn, desc_tx);
 
@@ -327,6 +334,7 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
 	struct net_device *ndev = emac->ndev;
 	u32 fdqring_id, hdesc_size;
 	int i, ret = 0, slice;
+	int flow_id_base;
 
 	slice = prueth_emac_slice(emac);
 	if (slice < 0)
@@ -367,8 +375,14 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
 		goto fail;
 	}
 
-	emac->rx_flow_id_base = k3_udma_glue_rx_get_flow_id_base(rx_chn->rx_chn);
-	netdev_dbg(ndev, "flow id base = %d\n", emac->rx_flow_id_base);
+	flow_id_base = k3_udma_glue_rx_get_flow_id_base(rx_chn->rx_chn);
+	if (emac->is_sr1 && !strcmp(name, "rxmgm")) {
+		emac->rx_mgm_flow_id_base = flow_id_base;
+		netdev_dbg(ndev, "mgm flow id base = %d\n", flow_id_base);
+	} else {
+		emac->rx_flow_id_base = flow_id_base;
+		netdev_dbg(ndev, "flow id base = %d\n", flow_id_base);
+	}
 
 	fdqring_id = K3_RINGACC_RING_ID_ANY;
 	for (i = 0; i < rx_cfg.flow_id_num; i++) {
@@ -477,10 +491,14 @@ void emac_rx_timestamp(struct prueth_emac *emac,
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
@@ -809,7 +827,8 @@ void prueth_emac_stop(struct prueth_emac *emac)
 	}
 
 	emac->fw_running = 0;
-	rproc_shutdown(prueth->txpru[slice]);
+	if (!emac->is_sr1)
+		rproc_shutdown(prueth->txpru[slice]);
 	rproc_shutdown(prueth->rtu[slice]);
 	rproc_shutdown(prueth->pru[slice]);
 }
@@ -829,8 +848,10 @@ void prueth_cleanup_tx_ts(struct prueth_emac *emac)
 int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 {
 	struct prueth_emac *emac = prueth_napi_to_emac(napi_rx);
-	int rx_flow = PRUETH_RX_FLOW_DATA;
-	int flow = PRUETH_MAX_RX_FLOWS;
+	int rx_flow = emac->is_sr1 ?
+		PRUETH_RX_FLOW_DATA_SR1 : PRUETH_RX_FLOW_DATA;
+	int flow = emac->is_sr1 ?
+		PRUETH_MAX_RX_FLOWS_SR1 : PRUETH_MAX_RX_FLOWS;
 	int num_rx = 0;
 	int cur_budget;
 	int ret;
@@ -1082,7 +1103,7 @@ void prueth_netdev_exit(struct prueth *prueth,
 	prueth->emac[mac] = NULL;
 }
 
-int prueth_get_cores(struct prueth *prueth, int slice)
+int prueth_get_cores(struct prueth *prueth, int slice, bool is_sr1)
 {
 	struct device *dev = prueth->dev;
 	enum pruss_pru_id pruss_id;
@@ -1096,7 +1117,7 @@ int prueth_get_cores(struct prueth *prueth, int slice)
 		idx = 0;
 		break;
 	case ICSS_SLICE1:
-		idx = 3;
+		idx = is_sr1 ? 2 : 3;
 		break;
 	default:
 		return -EINVAL;
@@ -1118,6 +1139,9 @@ int prueth_get_cores(struct prueth *prueth, int slice)
 		return dev_err_probe(dev, ret, "unable to get RTU%d\n", slice);
 	}
 
+	if (is_sr1)
+		return 0;
+
 	idx++;
 	prueth->txpru[slice] = pru_rproc_get(np, idx, NULL);
 	if (IS_ERR(prueth->txpru[slice])) {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 7d9db9683e18..186b0365c2e5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -907,13 +907,13 @@ static int prueth_probe(struct platform_device *pdev)
 	}
 
 	if (eth0_node) {
-		ret = prueth_get_cores(prueth, ICSS_SLICE0);
+		ret = prueth_get_cores(prueth, ICSS_SLICE0, false);
 		if (ret)
 			goto put_cores;
 	}
 
 	if (eth1_node) {
-		ret = prueth_get_cores(prueth, ICSS_SLICE1);
+		ret = prueth_get_cores(prueth, ICSS_SLICE1, false);
 		if (ret)
 			goto put_cores;
 	}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 21bdb219736a..0a1f127b2cf7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -354,7 +354,7 @@ int prueth_node_port(struct device_node *eth_node);
 int prueth_node_mac(struct device_node *eth_node);
 void prueth_netdev_exit(struct prueth *prueth,
 			struct device_node *eth_node);
-int prueth_get_cores(struct prueth *prueth, int slice);
+int prueth_get_cores(struct prueth *prueth, int slice, bool is_sr1);
 void prueth_put_cores(struct prueth *prueth, int slice);
 
 /* Revision specific helper */
-- 
2.44.0


