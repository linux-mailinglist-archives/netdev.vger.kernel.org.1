Return-Path: <netdev+bounces-97082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4A08C9137
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EF11F22007
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3048369DF7;
	Sat, 18 May 2024 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BVoN369O"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F2604B3;
	Sat, 18 May 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036207; cv=none; b=Q7CgWt0Wu3JC2jXObGmlwt0XFlIpxaHWfYXlPMyeQASgNA9OafodDNNoJStN44q0p29P5xuRKg9XpidMRfNcIJBnZPXsVmnFmk70tvCitEMCVLzS9bUxyvUFS6yTOJ7eKQNECGHiuiC4c4b8F2pifsDkaK9in0uK5nxxZjHFoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036207; c=relaxed/simple;
	bh=DSow4JVM3Wc+nMlDPSHNLhUp0GWyFpMgBLlgLiWErLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjM6O3Nd1eWG1Myhi1rjnnC6mexECxKzqRJpXE7BLwgn5NetWYOptVFODxOz0IwjAQLJ4mrrnnL+T+Fh7wdWIsc16RMyMYg5LiZ42cNFQ+lyttf5cWZBk4B7QY2WM7jS6Xs7TaegrTfFxnNvbiGNDXi3Pw+hIzfOuNWza00N//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BVoN369O; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44IChBWO054960;
	Sat, 18 May 2024 07:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036191;
	bh=msXRCMz8oqQ3jcF0j+F0nb50w6sdf+t+D/WHZUaXasU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BVoN369OF6MYQmWlCDzJJCH6BjxlN2uW2/XHv4gCXcZEhx48lBRNxf4AEBQcNCeMJ
	 vL6ionP0iBpzfgXiPpANMcZe/Y+8LPHY4wv7Vhf1C6Ge7/ZgRPEubiMdQ7DeWl+fCS
	 oODBs8EVhvFYDIbOzJf2UR3DtUXYeaMu2nHcBI7s=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44IChBpW129379
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:43:11 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:43:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:43:11 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9N041511;
	Sat, 18 May 2024 07:43:07 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 07/28] net: ethernet: ti: cpsw-proxy-client: add helper to attach virtual ports
Date: Sat, 18 May 2024 18:12:13 +0530
Message-ID: <20240518124234.2671651-8-s-vadapalli@ti.com>
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

Add the helper function "attach_virtual_ports()" to send the
ETHFW_ATTACH_VIRT_PORT request for each virtual port and store details
of features corresponding to the virtual port, the number of TX DMA
Channels allocated to the virtual port and the number of RX DMA Channels
allocated to the virtual port. If attaching any of the virtual ports
fails, detach all previously attached virtual ports.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 90 +++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 262fbf59ac72..691b36bc3715 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -35,10 +35,26 @@ struct cpsw_proxy_req_params {
 	u8		ipv4_addr[ETHFW_IPV4ADDRLEN];
 };
 
+struct rx_dma_chan {
+	struct virtual_port		*vport;
+	u32				rel_chan_idx;
+};
+
+struct tx_dma_chan {
+	struct virtual_port		*vport;
+	u32				rel_chan_idx;
+};
+
 struct virtual_port {
 	struct cpsw_proxy_priv		*proxy_priv;
+	struct rx_dma_chan		*rx_chans;
+	struct tx_dma_chan		*tx_chans;
 	enum virtual_port_type		port_type;
 	u32				port_id;
+	u32				port_token;
+	u32				port_features;
+	u32				num_rx_chan;
+	u32				num_tx_chan;
 };
 
 struct cpsw_proxy_priv {
@@ -350,6 +366,80 @@ static int get_virtual_port_info(struct cpsw_proxy_priv *proxy_priv)
 	return 0;
 }
 
+static int attach_virtual_ports(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct cpsw_proxy_req_params *req_p;
+	struct attach_response *att_resp;
+	struct rx_dma_chan *rx_chn;
+	struct tx_dma_chan *tx_chn;
+	struct virtual_port *vport;
+	struct message resp_msg;
+	unsigned int i, j;
+	u32 port_id;
+	int ret;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+		port_id = vport->port_id;
+
+		mutex_lock(&proxy_priv->req_params_mutex);
+		req_p = &proxy_priv->req_params;
+		req_p->port_id = port_id;
+		req_p->request_type = ETHFW_VIRT_PORT_ATTACH;
+		ret = send_request_get_response(proxy_priv, &resp_msg);
+		mutex_unlock(&proxy_priv->req_params_mutex);
+
+		if (ret) {
+			dev_err(proxy_priv->dev, "attaching virtual port failed\n");
+			goto err;
+		}
+
+		att_resp = (struct attach_response *)&resp_msg;
+		vport->port_token = att_resp->response_msg_hdr.msg_hdr.token;
+		vport->port_features = att_resp->features;
+		vport->num_tx_chan = att_resp->num_tx_chan;
+		vport->num_rx_chan = att_resp->num_rx_flow;
+
+		vport->rx_chans = devm_kcalloc(proxy_priv->dev,
+					       vport->num_rx_chan,
+					       sizeof(*vport->rx_chans),
+					       GFP_KERNEL);
+		for (j = 0; j < vport->num_rx_chan; j++) {
+			rx_chn = &vport->rx_chans[j];
+			rx_chn->vport = vport;
+			rx_chn->rel_chan_idx = j;
+		}
+
+		vport->tx_chans = devm_kcalloc(proxy_priv->dev,
+					       vport->num_tx_chan,
+					       sizeof(*vport->tx_chans),
+					       GFP_KERNEL);
+		for (j = 0; j < vport->num_tx_chan; j++) {
+			tx_chn = &vport->tx_chans[j];
+			tx_chn->vport = vport;
+			tx_chn->rel_chan_idx = j;
+		}
+	}
+
+	return 0;
+
+err:
+	/* Detach virtual ports which were successfully attached */
+	while (i--) {
+		vport = &proxy_priv->virt_ports[i];
+		port_id = vport->port_id;
+		mutex_lock(&proxy_priv->req_params_mutex);
+		req_p = &proxy_priv->req_params;
+		req_p->request_type = ETHFW_VIRT_PORT_DETACH;
+		req_p->token = vport->port_token;
+		ret = send_request_get_response(proxy_priv, &resp_msg);
+		mutex_unlock(&proxy_priv->req_params_mutex);
+		if (ret)
+			dev_err(proxy_priv->dev, "detaching virtual port %u failed\n", port_id);
+	}
+	return -EIO;
+}
+
 static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 {
 	struct cpsw_proxy_priv *proxy_priv;
-- 
2.40.1


