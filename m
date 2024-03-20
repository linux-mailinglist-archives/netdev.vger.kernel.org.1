Return-Path: <netdev+bounces-80841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E314588139F
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 15:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9757328174E
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6824AEE9;
	Wed, 20 Mar 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="fFefvEj1"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878253E1B
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945785; cv=none; b=faeIZ89vmZQU8IosR/C2azBtofTkLi0Oji1qyvcuSZ0ePpv+0BDT8uN1zbVy78fxq+hCDPCCaP2KwQ4AhKcPWpeN8G50HUhcWgxUF7KB+ZUCbnidt9br6kDqcxdxWhqwanamcPczZNhEyOTP+SgbP03DvtTR5ihcvcXCH8hnCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945785; c=relaxed/simple;
	bh=wGuScA0+mq3WRcdEzGgawnzHvgr59KU6VjVX9H5E3GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhgbcDAAW5vjlGpbj4h5QHKxwK58nnbgN7KJUfVg9c3/2czm8J6nWfg6nkZwbvHDUZeJiQysUsM2DV5+73v/yyxd3fIgnig9sPYkrybT+OP1W4p+Th0DGVtgsuT0+KA/dS7oCYrakrHKHwcOxWByqc69lByQpSEzIqJ8HE1IwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=fFefvEj1; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202403201443033a713aee48bc1d280c
        for <netdev@vger.kernel.org>;
        Wed, 20 Mar 2024 15:43:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=eAigabP96mtQRrBxZH1unm3nC79Le5TV/KKCB07ZYko=;
 b=fFefvEj1uQxAhkwOQG+7QWEGuuF4b60pDyJxdaOtotYZRLzLZR9RgKDwHeOozNGqP8pERL
 cos2VLzVOSmwxUOjzGkuiLt/XkDF/3w2y4izlG/R4meniYZkuXxSGKMke6QlAwMNacTWHGnN
 eImZKJTr6cAS3whvqibydsKtf0lb8=;
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
Subject: [PATCH net-next v5 09/10] net: ti: icssg-prueth: Modify common functions for SR1.0
Date: Wed, 20 Mar 2024 14:42:31 +0000
Message-ID: <20240320144234.313672-10-diogo.ivo@siemens.com>
In-Reply-To: <20240320144234.313672-1-diogo.ivo@siemens.com>
References: <20240320144234.313672-1-diogo.ivo@siemens.com>
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
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
---
Changes in v5: 
 - Remove useless budget++ in emac_tx_complete_packets()
 - Added Reviewed-by tags from Roger and Danish

Changes in v4:
 - Explicitly check for SR1.0 when managing rxmgm channel
 - Pass is_sr1 = false to prueth_get_cores() from SR2.0 driver

 drivers/net/ethernet/ti/icssg/icssg_common.c | 45 +++++++++++++++-----
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |  4 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 +-
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 99f27ecc9352..1d62c05b5f7c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -152,6 +152,12 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 						     desc_dma);
 		swdata = cppi5_hdesc_get_swdata(desc_tx);
 
+		/* was this command's TX complete? */
+		if (emac->is_sr1 && *(swdata) == emac->cmd_data) {
+			prueth_xmit_free(tx_chn, desc_tx);
+			continue;
+		}
+
 		skb = *(swdata);
 		prueth_xmit_free(tx_chn, desc_tx);
 
@@ -327,6 +333,7 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
 	struct net_device *ndev = emac->ndev;
 	u32 fdqring_id, hdesc_size;
 	int i, ret = 0, slice;
+	int flow_id_base;
 
 	slice = prueth_emac_slice(emac);
 	if (slice < 0)
@@ -367,8 +374,14 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
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
@@ -477,10 +490,14 @@ void emac_rx_timestamp(struct prueth_emac *emac,
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
@@ -809,7 +826,8 @@ void prueth_emac_stop(struct prueth_emac *emac)
 	}
 
 	emac->fw_running = 0;
-	rproc_shutdown(prueth->txpru[slice]);
+	if (!emac->is_sr1)
+		rproc_shutdown(prueth->txpru[slice]);
 	rproc_shutdown(prueth->rtu[slice]);
 	rproc_shutdown(prueth->pru[slice]);
 }
@@ -829,8 +847,10 @@ void prueth_cleanup_tx_ts(struct prueth_emac *emac)
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
@@ -1082,7 +1102,7 @@ void prueth_netdev_exit(struct prueth *prueth,
 	prueth->emac[mac] = NULL;
 }
 
-int prueth_get_cores(struct prueth *prueth, int slice)
+int prueth_get_cores(struct prueth *prueth, int slice, bool is_sr1)
 {
 	struct device *dev = prueth->dev;
 	enum pruss_pru_id pruss_id;
@@ -1096,7 +1116,7 @@ int prueth_get_cores(struct prueth *prueth, int slice)
 		idx = 0;
 		break;
 	case ICSS_SLICE1:
-		idx = 3;
+		idx = is_sr1 ? 2 : 3;
 		break;
 	default:
 		return -EINVAL;
@@ -1118,6 +1138,9 @@ int prueth_get_cores(struct prueth *prueth, int slice)
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


