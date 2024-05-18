Return-Path: <netdev+bounces-97090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C5A8C9106
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1951F210CD
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C534652D;
	Sat, 18 May 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VCcRArI4"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD374413;
	Sat, 18 May 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036244; cv=none; b=KMCxzmZCnaaWFLRTf2wqLs7Ce8VniOQZLuquhFFiNFnHYTMGnjpxmuPTwHHYFM3bd5gaVXDhvrNwcGngsEcMhnlt1nbE5r9PgRQmSryFmwi6jP9MkmTKiAHMxpS7VzxWp+/XWkec/Ei0keo2E1IqSjQgVHyZTjYCRoOuWzkNJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036244; c=relaxed/simple;
	bh=Vs6W+4IyjuzyntTqW7+e4tPXckOiXjLwmk+wB+VF1lo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saPxK3VIqJdJ7lTYH0hAqKyaqSuaka6Tm7aNWehNdSGGXAJr1dzo8t0PiFywygk97UqRdS+Y8H7R5saYDR4ylRLG7yUH6seFszmjQw/s51wuoUG6g+GtonG1l6l8om+YNxEF8k9iyUfX8qwrHC6AldBzywg0pzscE8wTW8IWtsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VCcRArI4; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44IChmPf110122;
	Sat, 18 May 2024 07:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036228;
	bh=qnXuvbGQhwcRpTOr7Phi9+6sH5BnBoym9ZcoMo85CaE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VCcRArI4/y8pRxu4DKMyqC1EfCjmqENnT/Eq6QMiH7NYOEG4qRNj8Ym9ron9RlPm4
	 wOp+xVr6NyC5jvZSxs6DT2WMd5M9Z+D8vgsd/NKTnBuWyJJDX8YvB93pY2ZnLK97FZ
	 E3rIHubDpMCo3iiE9XOpVwlYczsBxSMZBvzK0fgE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44IChmCT129590
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:43:48 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:43:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:43:48 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9V041511;
	Sat, 18 May 2024 07:43:44 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 15/28] net: ethernet: ti: cpsw-proxy-client: add helpers to (de)register MAC
Date: Sat, 18 May 2024 18:12:21 +0530
Message-ID: <20240518124234.2671651-16-s-vadapalli@ti.com>
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

Add functions "register_mac()" and "deregister_mac()" to register and
deregister MAC Address of the network interface corresponding to the
Virtual Port with EthFw. Registering the MAC Address with EthFw is
necessary to receive unicast traffic directed to the MAC Address.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 47 +++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index b0f0e5db3a74..7af4a89a1847 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -1182,6 +1182,53 @@ static int vport_rx_poll(struct napi_struct *napi_rx, int budget)
 const struct ethtool_ops cpsw_proxy_client_ethtool_ops = {
 };
 
+static int register_mac(struct virtual_port *vport)
+{
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	struct rx_dma_chan *rx_chn = &vport->rx_chans[0];
+	struct cpsw_proxy_req_params *req_p;
+	struct message resp_msg;
+	int ret;
+
+	/* Register MAC Address only for RX DMA Channel 0 */
+	mutex_lock(&proxy_priv->req_params_mutex);
+	req_p = &proxy_priv->req_params;
+	req_p->request_type = ETHFW_MAC_REGISTER;
+	req_p->token = vport->port_token;
+	req_p->rx_flow_base = rx_chn->flow_base;
+	req_p->rx_flow_offset = rx_chn->flow_offset;
+	ether_addr_copy(req_p->mac_addr, vport->mac_addr);
+	ret = send_request_get_response(proxy_priv, &resp_msg);
+	mutex_unlock(&proxy_priv->req_params_mutex);
+	if (ret)
+		dev_err(proxy_priv->dev, "failed to register MAC Address\n");
+
+	return ret;
+}
+
+static int deregister_mac(struct virtual_port *vport)
+{
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	struct rx_dma_chan *rx_chn = &vport->rx_chans[0];
+	struct cpsw_proxy_req_params *req_p;
+	struct message resp_msg;
+	int ret;
+
+	mutex_lock(&proxy_priv->req_params_mutex);
+	req_p = &proxy_priv->req_params;
+	req_p->request_type = ETHFW_MAC_DEREGISTER;
+	req_p->token = vport->port_token;
+	req_p->rx_flow_base = rx_chn->flow_base;
+	req_p->rx_flow_offset = rx_chn->flow_offset;
+	ether_addr_copy(req_p->mac_addr, vport->mac_addr);
+	ret = send_request_get_response(proxy_priv, &resp_msg);
+	mutex_unlock(&proxy_priv->req_params_mutex);
+	if (ret)
+		dev_err(proxy_priv->dev, "failed to deregister MAC Address\n");
+
+	return ret;
+}
+
 static const struct net_device_ops cpsw_proxy_client_netdev_ops = {
 };
 
-- 
2.40.1


