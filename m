Return-Path: <netdev+bounces-97079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2948C90E5
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CDF1F21241
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E6046453;
	Sat, 18 May 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mTAdO6AE"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461FA3BBE3;
	Sat, 18 May 2024 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036200; cv=none; b=sZwWM+96fcRqFxm1w2GFnv2y7jE4EUzk834mnEBmMeJnTbYaGRuwdbuWXB5OoGTLWsZf4eL0uU+6C08zRpbSKsOXTpLrtn3zj97XemGyJJaA/5gd6HMm+o384KwODRDLYyFjTeiW4Hq9P3EPO2+IDldDJPR4AAkKW2sBjUS2Boc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036200; c=relaxed/simple;
	bh=BX65I4hCBY8znLybw93RUD7npF1xBbqeKvfk+x/ftRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiRR0bEznybILGw+/TWEbSeo4WS/Lf8CAuob0TTFoneGv7LRusS76POBmTOIN2eay7FwwA3ZUrEKU0vPAVr+PMU6gaVXxS6U5xg7vR/cmWtv1gtdUiUlQHyH6MYLdl4M6IaV6IpoHdulhBfV0UIBAZmBSYaEeLX4sda24Ic7j/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mTAdO6AE; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICh7UH110072;
	Sat, 18 May 2024 07:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036187;
	bh=GzbWPgN25doQLrvoohmHb3qEO5wj31NYefx2WCnThbE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mTAdO6AEQ2X6QJpHVLNvdhUnNHarZvzJB1Ma7BjZAESkzuQBNqrJdGXbFsOSvpF5p
	 zKqra/ufKI8noIjiJOm40MvcjzSMoYFicL55NJdT9sTXAhxWTx6OYsdXmWTnoz9eRt
	 B05Os9C35r2BdMvhaXzGf0W4wsuKkqFOoVhhKTdE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICh7qX129339
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:43:07 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:43:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:43:06 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9M041511;
	Sat, 18 May 2024 07:43:02 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 06/28] net: ethernet: ti: cpsw-proxy-client: add helper to get virtual port info
Date: Sat, 18 May 2024 18:12:12 +0530
Message-ID: <20240518124234.2671651-7-s-vadapalli@ti.com>
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

Add the helper function "get_virtual_port_info()" to send the
ETHFW_VIRT_PORT_INFO request and store details of virtual port
allocation. The details include type of virtual port, the virtual
port ID and the token identifying the virtual port.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 75 +++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 70b8cfe67921..262fbf59ac72 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -14,6 +14,11 @@
 
 #define ETHFW_RESPONSE_TIMEOUT_MS	500
 
+enum virtual_port_type {
+	VIRT_SWITCH_PORT,
+	VIRT_MAC_ONLY_PORT,
+};
+
 struct cpsw_proxy_req_params {
 	struct message	req_msg;	/* Request message to be filled */
 	u32		token;
@@ -30,13 +35,26 @@ struct cpsw_proxy_req_params {
 	u8		ipv4_addr[ETHFW_IPV4ADDRLEN];
 };
 
+struct virtual_port {
+	struct cpsw_proxy_priv		*proxy_priv;
+	enum virtual_port_type		port_type;
+	u32				port_id;
+};
+
 struct cpsw_proxy_priv {
 	struct rpmsg_device		*rpdev;
 	struct device			*dev;
+	struct virtual_port		*virt_ports;
 	struct cpsw_proxy_req_params	req_params;
+	struct mutex			req_params_mutex; /* Request params mutex */
 	struct message			resp_msg;
 	struct completion		wait_for_response;
 	int				resp_msg_len;
+	u32				vswitch_ports; /* Bitmask of Virtual Switch Port IDs */
+	u32				vmac_ports /* Bitmask of Virtual MAC Only Port IDs */;
+	u32				num_switch_ports;
+	u32				num_mac_ports;
+	u32				num_virt_ports;
 };
 
 static int cpsw_proxy_client_cb(struct rpmsg_device *rpdev, void *data,
@@ -275,6 +293,63 @@ static int send_request_get_response(struct cpsw_proxy_priv *proxy_priv,
 	return ret;
 }
 
+static int get_virtual_port_info(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct virt_port_info_response *vpi_resp;
+	struct cpsw_proxy_req_params *req_p;
+	struct virtual_port *vport;
+	struct message resp_msg;
+	unsigned int vp_id, i;
+	int ret;
+
+	mutex_lock(&proxy_priv->req_params_mutex);
+	req_p = &proxy_priv->req_params;
+	req_p->request_type = ETHFW_VIRT_PORT_INFO;
+	ret = send_request_get_response(proxy_priv, &resp_msg);
+	mutex_unlock(&proxy_priv->req_params_mutex);
+
+	if (ret) {
+		dev_err(proxy_priv->dev, "failed to get virtual port info\n");
+		return ret;
+	}
+
+	vpi_resp = (struct virt_port_info_response *)&resp_msg;
+	proxy_priv->vswitch_ports = vpi_resp->switch_port_mask;
+	proxy_priv->vmac_ports = vpi_resp->mac_port_mask;
+	/* Number of 1s set in vswitch_ports is the count of switch ports */
+	proxy_priv->num_switch_ports = hweight32(proxy_priv->vswitch_ports);
+	proxy_priv->num_virt_ports = proxy_priv->num_switch_ports;
+	/* Number of 1s set in vmac_ports is the count of mac ports */
+	proxy_priv->num_mac_ports = hweight32(proxy_priv->vmac_ports);
+	proxy_priv->num_virt_ports += proxy_priv->num_mac_ports;
+
+	proxy_priv->virt_ports = devm_kcalloc(proxy_priv->dev,
+					      proxy_priv->num_virt_ports,
+					      sizeof(*proxy_priv->virt_ports),
+					      GFP_KERNEL);
+
+	vp_id = 0;
+	for (i = 0; i < proxy_priv->num_switch_ports; i++) {
+		vport = &proxy_priv->virt_ports[vp_id];
+		vport->proxy_priv = proxy_priv;
+		vport->port_type = VIRT_SWITCH_PORT;
+		/* Port ID is derived from the bit set in the bitmask */
+		vport->port_id = fns(proxy_priv->vswitch_ports, i);
+		vp_id++;
+	}
+
+	for (i = 0; i < proxy_priv->num_mac_ports; i++) {
+		vport = &proxy_priv->virt_ports[vp_id];
+		vport->proxy_priv = proxy_priv;
+		vport->port_type = VIRT_MAC_ONLY_PORT;
+		/* Port ID is derived from the bit set in the bitmask */
+		vport->port_id = fns(proxy_priv->vmac_ports, i);
+		vp_id++;
+	}
+
+	return 0;
+}
+
 static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 {
 	struct cpsw_proxy_priv *proxy_priv;
-- 
2.40.1


