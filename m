Return-Path: <netdev+bounces-97085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167C38C90F5
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391CD1C21181
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF616BFAA;
	Sat, 18 May 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="STbMyYOs"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41E96CDAB;
	Sat, 18 May 2024 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036223; cv=none; b=djjklaSpfK2GOx3ShGcUwNxA7QXqA7Mo4MjQMBTuGDbDF4TN6tEnrQqIhBRfz8upjQZukGLa6z8LRCVy5L4khf7A9YZu99ZzGsAyZlJ4LGBJbGNGYTmV/rpNMPE1EZOJOAcxUStfaxcePWAZU5N796I7ovjRbtOPt14bqyuDAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036223; c=relaxed/simple;
	bh=ONWwtb/E5rDMX5BawuZhOKVUHmz5hGEN7uIBo5U6++c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfPEHuuQ3Y+xCrqciiWCqV+ePvFaW3G9H+hqkh4rSG51+s+cPuiP/IZ01ptT6rHEN0TvB9eJNaznEUxc8un/GjhUA05mjNDUsnv9jSc6vO0F3MfIz+rqsQOZpzNj0NoQDQ6Hyw7ZYMQ7H6EKPBdlA8it5I9S/aQaqUEiHYFHV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=STbMyYOs; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44IChPl6002785;
	Sat, 18 May 2024 07:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036205;
	bh=0GrwBlSU/Vcks+HbbBXVZ6OE94NII5ICaCjwmTrIL4Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=STbMyYOsqOucYTiFz+Bcl+qpGizPVtHQUzuXBJG+CQoNEEEh7l3Wx+VGjYCyZ1xNL
	 8I4LSpgJLohdCWh6d0/up686qtusvvYlZQ33HOJIVIbdpq3yQ/UbXf/r1B/3YEcC0T
	 m7IZez6l6IJGuFpmQvTBkth1zzHQpWbxBc9uJW7w=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44IChP6R017301
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:43:25 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:43:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:43:25 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9Q041511;
	Sat, 18 May 2024 07:43:21 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 10/28] net: ethernet: ti: cpsw-proxy-client: add helper to init RX DMA Channels
Date: Sat, 18 May 2024 18:12:16 +0530
Message-ID: <20240518124234.2671651-11-s-vadapalli@ti.com>
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

Add the "init_rx_chans()" function to initialize the RX DMA Channels.
With the knowledge of the PSI-L Thread ID for the RX Channel along with
the details of the RX Flow Base and RX Flow Offset, the RX DMA Flow on
the RX Channel can be setup using the DMA APIs.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 128 ++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index efb44ff04b6a..16e8e585adce 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -20,6 +20,8 @@
 #define SW_DATA_SIZE	16
 
 #define MAX_TX_DESC	500
+#define MAX_RX_DESC	500
+#define MAX_RX_FLOWS	1
 
 #define CHAN_NAME_LEN	128
 
@@ -46,10 +48,16 @@ struct cpsw_proxy_req_params {
 
 struct rx_dma_chan {
 	struct virtual_port		*vport;
+	struct device			*dev;
+	struct k3_cppi_desc_pool	*desc_pool;
+	struct k3_udma_glue_rx_channel	*rx_chan;
 	u32				rel_chan_idx;
 	u32				flow_base;
 	u32				flow_offset;
 	u32				thread_id;
+	u32				num_descs;
+	unsigned int			irq;
+	char				rx_chan_name[CHAN_NAME_LEN];
 	bool				in_use;
 };
 
@@ -96,6 +104,7 @@ struct cpsw_proxy_priv {
 	u32				num_mac_ports;
 	u32				num_virt_ports;
 	u32				num_active_tx_chans;
+	u32				num_active_rx_chans;
 };
 
 static int cpsw_proxy_client_cb(struct rpmsg_device *rpdev, void *data,
@@ -720,6 +729,125 @@ static int init_tx_chans(struct cpsw_proxy_priv *proxy_priv)
 	return ret;
 }
 
+static void free_rx_chns(void *data)
+{
+	struct cpsw_proxy_priv *proxy_priv = data;
+	struct rx_dma_chan *rx_chn;
+	struct virtual_port *vport;
+	u32 i, j;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+
+		for (j = 0; j < vport->num_rx_chan; j++) {
+			rx_chn = &vport->rx_chans[j];
+
+			if (!IS_ERR_OR_NULL(rx_chn->desc_pool))
+				k3_cppi_desc_pool_destroy(rx_chn->desc_pool);
+
+			if (!IS_ERR_OR_NULL(rx_chn->rx_chan))
+				k3_udma_glue_release_rx_chn(rx_chn->rx_chan);
+		}
+	}
+}
+
+static int init_rx_chans(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct k3_udma_glue_rx_channel_cfg rx_cfg = {0};
+	struct device *dev = proxy_priv->dev;
+	u32 hdesc_size, rx_chn_num, i, j;
+	u32  max_desc_num = MAX_RX_DESC;
+	char rx_chn_name[CHAN_NAME_LEN];
+	struct rx_dma_chan *rx_chn;
+	struct virtual_port *vport;
+	struct k3_ring_cfg rxring_cfg = {
+		.elm_size = K3_RINGACC_RING_ELSIZE_8,
+		.mode = K3_RINGACC_RING_MODE_MESSAGE,
+		.flags = 0,
+	};
+	struct k3_ring_cfg fdqring_cfg = {
+		.elm_size = K3_RINGACC_RING_ELSIZE_8,
+		.mode = K3_RINGACC_RING_MODE_MESSAGE,
+		.flags = 0,
+	};
+	struct k3_udma_glue_rx_flow_cfg rx_flow_cfg = {
+		.rx_cfg = rxring_cfg,
+		.rxfdq_cfg = fdqring_cfg,
+		.ring_rxq_id = K3_RINGACC_RING_ID_ANY,
+		.ring_rxfdq0_id = K3_RINGACC_RING_ID_ANY,
+		.src_tag_lo_sel = K3_UDMA_GLUE_SRC_TAG_LO_USE_REMOTE_SRC_TAG,
+	};
+	int ret = 0, ret1;
+
+	hdesc_size = cppi5_hdesc_calc_size(true, PS_DATA_SIZE, SW_DATA_SIZE);
+
+	rx_cfg.swdata_size = SW_DATA_SIZE;
+	rx_cfg.flow_id_num = MAX_RX_FLOWS;
+	rx_cfg.remote = true;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+
+		for (j = 0; j < vport->num_rx_chan; j++) {
+			rx_chn = &vport->rx_chans[j];
+
+			rx_chn_num = proxy_priv->num_active_rx_chans++;
+			snprintf(rx_chn_name, sizeof(rx_chn_name), "rx%u-virt-port-%u", rx_chn_num,
+				 vport->port_id);
+			strscpy(rx_chn->rx_chan_name, rx_chn_name, sizeof(rx_chn->rx_chan_name));
+
+			rx_cfg.flow_id_base = rx_chn->flow_base + rx_chn->flow_offset;
+
+			/* init all flows */
+			rx_chn->dev = dev;
+			rx_chn->num_descs = max_desc_num;
+			rx_chn->desc_pool = k3_cppi_desc_pool_create_name(dev,
+									  rx_chn->num_descs,
+									  hdesc_size,
+									  rx_chn_name);
+			if (IS_ERR(rx_chn->desc_pool)) {
+				ret = PTR_ERR(rx_chn->desc_pool);
+				dev_err(dev, "Failed to create rx pool %d\n", ret);
+				goto err;
+			}
+
+			rx_chn->rx_chan =
+			k3_udma_glue_request_remote_rx_chn_for_thread_id(dev, &rx_cfg,
+									 proxy_priv->dma_node,
+									 rx_chn->thread_id);
+			if (IS_ERR(rx_chn->rx_chan)) {
+				ret = PTR_ERR(rx_chn->rx_chan);
+				dev_err(dev, "Failed to request rx dma channel %d\n", ret);
+				goto err;
+			}
+
+			rx_flow_cfg.rx_cfg.size = max_desc_num;
+			rx_flow_cfg.rxfdq_cfg.size = max_desc_num;
+			ret = k3_udma_glue_rx_flow_init(rx_chn->rx_chan,
+							0, &rx_flow_cfg);
+			if (ret) {
+				dev_err(dev, "Failed to init rx flow %d\n", ret);
+				goto err;
+			}
+
+			rx_chn->irq = k3_udma_glue_rx_get_irq(rx_chn->rx_chan, 0);
+			if (rx_chn->irq <= 0) {
+				ret = -ENXIO;
+				dev_err(dev, "Failed to get rx dma irq %d\n", rx_chn->irq);
+			}
+		}
+	}
+
+err:
+	ret1 = devm_add_action(dev, free_rx_chns, proxy_priv);
+	if (ret1) {
+		dev_err(dev, "failed to add free_rx_chns action %d", ret1);
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


