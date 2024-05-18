Return-Path: <netdev+bounces-97083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7638C90F0
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CC21C21445
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460E93D97A;
	Sat, 18 May 2024 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K+kal9ku"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825BA6BFAA;
	Sat, 18 May 2024 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036212; cv=none; b=nKIU/MfTIMlZpfA9lNWPc70Ovt4E1QlVxCZU5lbjxvDlyib4t8frCFmbdTeNaCBw/8+nTYeSQgh1yF+qSlSy+wKL51LnhblQh620a1JpEcSuDqIvuPJ9lIbWvGSbtF9PSW0yaaKMRdar8HEz19TtUUAuKNMb9fCjsInDlL8Qe/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036212; c=relaxed/simple;
	bh=Jw4P8bVK9c/AccL9Hj+9pVXPKjs7iZ+nzu6OlcqM2iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYLydIL4RijsMVWeraZoKvtomyLcZUOn0xJV1InpSVPX7fK4YHSUN/gsn9K3fHOK79r2y3xvWSVwT5pT4ZNauuw/+lEeL+sK05obEH5B/ZZw89JVKa/Z/2dWl6OwON8MyjJh7+BJJribsnLovA9BGwfK/l4htKBuJ+FTAcPqgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K+kal9ku; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44IChGiU054968;
	Sat, 18 May 2024 07:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036196;
	bh=520vVll/ZFOoW9AjksFfU8ARoVZ/aAksC0ZgDCAKvsQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=K+kal9kuyL7dqvtYhLglioTDuaXqSUb2D0aq/uPAD6rJfl65QnJ8+LN39k6CpMiH3
	 AO0ngQ8WL9r4hsKGfartCIMXCfSvrw0LvR1pNxB/LGQ+EGoWysR/HZNH391entYFAM
	 lGr33E4eNwVYlrlcHfF37oLwh7N1JSzLjnJJ97KA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44IChGGR129426
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:43:16 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:43:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:43:16 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9O041511;
	Sat, 18 May 2024 07:43:12 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 08/28] net: ethernet: ti: cpsw-proxy-client: add helpers to alloc/free resources
Date: Sat, 18 May 2024 18:12:14 +0530
Message-ID: <20240518124234.2671651-9-s-vadapalli@ti.com>
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

Add the function "allocate_port_resources()" to request EthFw to
allocate TX and RX DMA Channels and MAC Address for each Virtual Port
which has been allocated to the Client. If allocating any of the
resources fails, release all resources which were allocated earlier
through the "free_port_resources()" function. During the process of
freeing resources, if any request fails, avoid attempting to release
other resources. This is due to the assumption that EthFw is
non-functional and all further requests to free resources will most
likely fail.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 165 ++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 691b36bc3715..b057cf4b7bea 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -38,11 +38,17 @@ struct cpsw_proxy_req_params {
 struct rx_dma_chan {
 	struct virtual_port		*vport;
 	u32				rel_chan_idx;
+	u32				flow_base;
+	u32				flow_offset;
+	u32				thread_id;
+	bool				in_use;
 };
 
 struct tx_dma_chan {
 	struct virtual_port		*vport;
 	u32				rel_chan_idx;
+	u32				thread_id;
+	bool				in_use;
 };
 
 struct virtual_port {
@@ -55,6 +61,8 @@ struct virtual_port {
 	u32				port_features;
 	u32				num_rx_chan;
 	u32				num_tx_chan;
+	u8				mac_addr[ETH_ALEN];
+	bool				mac_in_use;
 };
 
 struct cpsw_proxy_priv {
@@ -440,6 +448,163 @@ static int attach_virtual_ports(struct cpsw_proxy_priv *proxy_priv)
 	return -EIO;
 }
 
+static void free_port_resources(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct cpsw_proxy_req_params *req_p;
+	struct rx_dma_chan *rx_chn;
+	struct tx_dma_chan *tx_chn;
+	struct virtual_port *vport;
+	struct message resp_msg;
+	u32 port_id, i, j;
+	int ret;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+		port_id = vport->port_id;
+
+		/* Free allocated MAC */
+		if (vport->mac_in_use) {
+			mutex_lock(&proxy_priv->req_params_mutex);
+			req_p = &proxy_priv->req_params;
+			req_p->request_type = ETHFW_FREE_MAC;
+			req_p->token = vport->port_token;
+			ether_addr_copy(req_p->mac_addr, vport->mac_addr);
+			ret = send_request_get_response(proxy_priv, &resp_msg);
+			mutex_unlock(&proxy_priv->req_params_mutex);
+			if (ret) {
+				dev_err(proxy_priv->dev,
+					"failed to free MAC Address for port %u err: %d\n",
+					port_id, ret);
+				return;
+			}
+		}
+
+		/* Free TX DMA Channels */
+		for (j = 0; j < vport->num_tx_chan; j++) {
+			tx_chn = &vport->tx_chans[j];
+			if (!tx_chn->in_use)
+				continue;
+			mutex_lock(&proxy_priv->req_params_mutex);
+			req_p = &proxy_priv->req_params;
+			req_p->request_type = ETHFW_FREE_TX;
+			req_p->token = vport->port_token;
+			req_p->tx_thread_id = tx_chn->thread_id;
+			ret = send_request_get_response(proxy_priv, &resp_msg);
+			mutex_unlock(&proxy_priv->req_params_mutex);
+			if (ret) {
+				dev_err(proxy_priv->dev,
+					"failed to free TX Channel for port %u err: %d\n",
+					port_id, ret);
+				return;
+			}
+		}
+
+		/* Free RX DMA Channels */
+		for (j = 0; j < vport->num_rx_chan; j++) {
+			rx_chn = &vport->rx_chans[j];
+			if (!rx_chn->in_use)
+				continue;
+			mutex_lock(&proxy_priv->req_params_mutex);
+			req_p = &proxy_priv->req_params;
+			req_p->request_type = ETHFW_FREE_RX;
+			req_p->token = vport->port_token;
+			req_p->rx_flow_base = rx_chn->flow_base;
+			req_p->rx_flow_offset = rx_chn->flow_offset;
+			ret = send_request_get_response(proxy_priv, &resp_msg);
+			mutex_unlock(&proxy_priv->req_params_mutex);
+			if (ret) {
+				dev_err(proxy_priv->dev,
+					"failed to free RX Channel for port %u err: %d\n",
+					port_id, ret);
+				return;
+			}
+		}
+	}
+}
+
+static int allocate_port_resources(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct tx_thread_alloc_response *tta_resp;
+	struct rx_flow_alloc_response *rfa_resp;
+	struct cpsw_proxy_req_params *req_p;
+	struct mac_alloc_response *ma_resp;
+	struct rx_dma_chan *rx_chn;
+	struct tx_dma_chan *tx_chn;
+	struct virtual_port *vport;
+	struct message resp_msg;
+	u32 port_id, i, j;
+	int ret;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+		port_id = vport->port_id;
+
+		/* Request RX DMA Flow allocation */
+		for (j = 0; j < vport->num_rx_chan; j++) {
+			mutex_lock(&proxy_priv->req_params_mutex);
+			req_p = &proxy_priv->req_params;
+			req_p->request_type = ETHFW_ALLOC_RX;
+			req_p->token = vport->port_token;
+			req_p->rx_tx_idx = j;
+			ret = send_request_get_response(proxy_priv, &resp_msg);
+			mutex_unlock(&proxy_priv->req_params_mutex);
+			if (ret) {
+				dev_err(proxy_priv->dev, "RX Alloc for port %u failed\n", port_id);
+				goto err;
+			}
+
+			rfa_resp = (struct rx_flow_alloc_response *)&resp_msg;
+			rx_chn = &vport->rx_chans[j];
+			rx_chn->flow_base = rfa_resp->rx_flow_idx_base;
+			rx_chn->flow_offset = rfa_resp->rx_flow_idx_offset;
+			rx_chn->thread_id = rfa_resp->rx_psil_src_id;
+			rx_chn->in_use = 1;
+		}
+
+		/* Request TX DMA Channel allocation */
+		for (j = 0; j < vport->num_tx_chan; j++) {
+			mutex_lock(&proxy_priv->req_params_mutex);
+			req_p = &proxy_priv->req_params;
+			req_p->request_type = ETHFW_ALLOC_TX;
+			req_p->token = vport->port_token;
+			req_p->rx_tx_idx = j;
+			ret = send_request_get_response(proxy_priv, &resp_msg);
+			mutex_unlock(&proxy_priv->req_params_mutex);
+			if (ret) {
+				dev_err(proxy_priv->dev, "TX Alloc for port %u failed\n", port_id);
+				goto err;
+			}
+
+			tta_resp = (struct tx_thread_alloc_response *)&resp_msg;
+			tx_chn = &vport->tx_chans[j];
+			tx_chn->thread_id = tta_resp->tx_psil_dest_id;
+			tx_chn->in_use = 1;
+		}
+
+		/* Request MAC allocation */
+		mutex_lock(&proxy_priv->req_params_mutex);
+		req_p = &proxy_priv->req_params;
+		req_p->request_type = ETHFW_ALLOC_MAC;
+		req_p->token = vport->port_token;
+		ret = send_request_get_response(proxy_priv, &resp_msg);
+		mutex_unlock(&proxy_priv->req_params_mutex);
+		if (ret) {
+			dev_err(proxy_priv->dev, "MAC Alloc for port %u failed\n", port_id);
+			goto err;
+		}
+
+		ma_resp = (struct mac_alloc_response *)&resp_msg;
+		ether_addr_copy(vport->mac_addr, ma_resp->mac_addr);
+		vport->mac_in_use = 1;
+	}
+
+	return 0;
+
+err:
+	free_port_resources(proxy_priv);
+	return -EIO;
+}
+
 static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 {
 	struct cpsw_proxy_priv *proxy_priv;
-- 
2.40.1


