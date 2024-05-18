Return-Path: <netdev+bounces-97084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A13D8C90F4
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7E8281403
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96BD39FEF;
	Sat, 18 May 2024 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AL78jLzy"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF3C6CDA6;
	Sat, 18 May 2024 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036222; cv=none; b=p4/2arIdrwk64fKS+0gpaaplQpPeQDAq0OvGGH6GEno/8MopvAUs5oYHqSjwQdbwTBJ6rWCMvKstBDdagEDIy6ze4rvmC3rxpLOZaeGiWBE8bKq6HmRcvfxy0irm0iw7skt+xc8o4y49SBB/JpA3fGYMrjisVWB2qWtYRFzQO2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036222; c=relaxed/simple;
	bh=gIyVwz0Wcg0LkmdC28gikWPE100JFMVOaly/w6xEQOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bX5slzN6EPu1rzOZwQwxilH3va8iqrpURiIPmGXS6BXwQ3UELV+veJE5+9x19ywlC4hQ/tGllXAXF0JH9nuhEglj/SgGgkcxsv24FpcJLf07loB+x4SaTDuZC2ASgapyL5Jt7KeerRxXayHp3ZFSiFIVD+4J67FMjaZbj87Y9QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AL78jLzy; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44IChLLq002777;
	Sat, 18 May 2024 07:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036201;
	bh=X4OG+ZvQd9VrF6yQRJQsEZaaVWKIzPyaHgTp/GtXj38=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AL78jLzyitLh7oyJmklgJCxhd4015R4pvSE2xNdc+rbrwqLYI/gORKTAniovoX+zj
	 y2txWgDV6T3U3av6IUllFUOuRtxZ9c4oqb1z9SNuYy5lAUxwmOU7FUlkemvuFRo2MX
	 x+yz5zJr2PXO5i/ANVhnkicr8EQkdwTpTLm30n2U=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44IChLJb129471
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:43:21 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:43:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:43:20 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9P041511;
	Sat, 18 May 2024 07:43:16 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 09/28] net: ethernet: ti: cpsw-proxy-client: add helper to init TX DMA Channels
Date: Sat, 18 May 2024 18:12:15 +0530
Message-ID: <20240518124234.2671651-10-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240518124234.2671651-1-s-vadapalli@ti.com>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add the "init_tx_chans()" function to initialize the TX DMA Channels.
With the knowledge of the PSI-L Thread IDs allocated to the Client for
each Virtual Port, the TX DMA Channels can be setup using the DMA APIs.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 115 ++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index b057cf4b7bea..efb44ff04b6a 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -9,11 +9,20 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/rpmsg.h>
+#include <linux/dma/k3-udma-glue.h>
 
 #include "ethfw_abi.h"
+#include "k3-cppi-desc-pool.h"
 
 #define ETHFW_RESPONSE_TIMEOUT_MS	500
 
+#define PS_DATA_SIZE	16
+#define SW_DATA_SIZE	16
+
+#define MAX_TX_DESC	500
+
+#define CHAN_NAME_LEN	128
+
 enum virtual_port_type {
 	VIRT_SWITCH_PORT,
 	VIRT_MAC_ONLY_PORT,
@@ -46,8 +55,14 @@ struct rx_dma_chan {
 
 struct tx_dma_chan {
 	struct virtual_port		*vport;
+	struct device			*dev;
+	struct k3_cppi_desc_pool	*desc_pool;
+	struct k3_udma_glue_tx_channel	*tx_chan;
 	u32				rel_chan_idx;
 	u32				thread_id;
+	u32				num_descs;
+	unsigned int			irq;
+	char				tx_chan_name[CHAN_NAME_LEN];
 	bool				in_use;
 };
 
@@ -68,6 +83,7 @@ struct virtual_port {
 struct cpsw_proxy_priv {
 	struct rpmsg_device		*rpdev;
 	struct device			*dev;
+	struct device_node		*dma_node;
 	struct virtual_port		*virt_ports;
 	struct cpsw_proxy_req_params	req_params;
 	struct mutex			req_params_mutex; /* Request params mutex */
@@ -79,6 +95,7 @@ struct cpsw_proxy_priv {
 	u32				num_switch_ports;
 	u32				num_mac_ports;
 	u32				num_virt_ports;
+	u32				num_active_tx_chans;
 };
 
 static int cpsw_proxy_client_cb(struct rpmsg_device *rpdev, void *data,
@@ -605,6 +622,104 @@ static int allocate_port_resources(struct cpsw_proxy_priv *proxy_priv)
 	return -EIO;
 }
 
+static void free_tx_chns(void *data)
+{
+	struct cpsw_proxy_priv *proxy_priv = data;
+	struct tx_dma_chan *tx_chn;
+	struct virtual_port *vport;
+	u32 i, j;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+		for (j = 0; j < vport->num_tx_chan; j++) {
+			tx_chn = &vport->tx_chans[j];
+
+			if (!IS_ERR_OR_NULL(tx_chn->desc_pool))
+				k3_cppi_desc_pool_destroy(tx_chn->desc_pool);
+
+			if (!IS_ERR_OR_NULL(tx_chn->tx_chan))
+				k3_udma_glue_release_tx_chn(tx_chn->tx_chan);
+
+			memset(tx_chn, 0, sizeof(*tx_chn));
+		}
+	}
+}
+
+static int init_tx_chans(struct cpsw_proxy_priv *proxy_priv)
+{
+	u32 max_desc_num = ALIGN(MAX_TX_DESC, MAX_SKB_FRAGS);
+	struct k3_udma_glue_tx_channel_cfg tx_cfg = { 0 };
+	struct device *dev = proxy_priv->dev;
+	u32 hdesc_size, tx_chn_num, i, j;
+	char tx_chn_name[CHAN_NAME_LEN];
+	struct k3_ring_cfg ring_cfg = {
+		.elm_size = K3_RINGACC_RING_ELSIZE_8,
+		.mode = K3_RINGACC_RING_MODE_RING,
+		.flags = 0
+	};
+	struct tx_dma_chan *tx_chn;
+	struct virtual_port *vport;
+	int ret = 0, ret1;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+
+		for (j = 0; j < vport->num_tx_chan; j++) {
+			tx_chn = &vport->tx_chans[j];
+
+			tx_chn_num = proxy_priv->num_active_tx_chans++;
+			snprintf(tx_chn_name, sizeof(tx_chn_name), "tx%u-virt-port-%u",
+				 tx_chn_num, vport->port_id);
+			strscpy(tx_chn->tx_chan_name, tx_chn_name, sizeof(tx_chn->tx_chan_name));
+
+			hdesc_size = cppi5_hdesc_calc_size(true, PS_DATA_SIZE, SW_DATA_SIZE);
+
+			tx_cfg.swdata_size = SW_DATA_SIZE;
+			tx_cfg.tx_cfg = ring_cfg;
+			tx_cfg.txcq_cfg = ring_cfg;
+			tx_cfg.tx_cfg.size = max_desc_num;
+			tx_cfg.txcq_cfg.size = max_desc_num;
+
+			tx_chn->dev = dev;
+			tx_chn->num_descs = max_desc_num;
+			tx_chn->desc_pool = k3_cppi_desc_pool_create_name(dev,
+									  tx_chn->num_descs,
+									  hdesc_size,
+									  tx_chn_name);
+			if (IS_ERR(tx_chn->desc_pool)) {
+				ret = PTR_ERR(tx_chn->desc_pool);
+				dev_err(dev, "failed to create tx pool %d\n", ret);
+				goto err;
+			}
+
+			tx_chn->tx_chan =
+				k3_udma_glue_request_tx_chn_for_thread_id(dev, &tx_cfg,
+									  proxy_priv->dma_node,
+									  tx_chn->thread_id);
+			if (IS_ERR(tx_chn->tx_chan)) {
+				ret = PTR_ERR(tx_chn->tx_chan);
+				dev_err(dev, "Failed to request tx dma channel %d\n", ret);
+				goto err;
+			}
+
+			tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chan);
+			if (tx_chn->irq <= 0) {
+				dev_err(dev, "Failed to get tx dma irq %d\n", tx_chn->irq);
+				ret = -ENXIO;
+			}
+		}
+	}
+
+err:
+	ret1 = devm_add_action(dev, free_tx_chns, proxy_priv);
+	if (ret1) {
+		dev_err(dev, "failed to add free_tx_chns action %d", ret1);
+		return ret1;
+	}
+
+	return ret;
+}
+
 static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 {
 	struct cpsw_proxy_priv *proxy_priv;
-- 
2.40.1


