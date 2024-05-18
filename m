Return-Path: <netdev+bounces-97103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7319E8C912C
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279362817DC
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC51BC59;
	Sat, 18 May 2024 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dthQdYTY"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB8B7CF16;
	Sat, 18 May 2024 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036302; cv=none; b=tiWOeikWht4q/gfg7qzx6l/N8F62700a3xMUnu7BcIhFMdbVaKdx18LLbH3LI0vz9CAN8Irf5BLlCZI31GdL7cORYHFtQLVzpTyR5vDniaMGIjKJOHYrikAxsXtliiymC35kYqVCvfJ+2OlvMCvuhpqmkkCNxL0Rf8/wTmTeOCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036302; c=relaxed/simple;
	bh=hynyAfgRm5q+1IANofou/nprgd/BjuI4O4e6YgviSjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R80z6oHbPI5QcxZIspZG6fL9+o5OwG+W4W6/YVpOdBPCxbM+3pY4KAj7xjALVG0PqeMuJhYJIXv5vxcafv2Xztd52VYSSj3S2tD6/OFY0tvVEaKUYIN3jNefI3MT+wbDT2iAOkP/8j3JLQGCtU0dT8IHX8UKlIgppW8fQHi0PBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dthQdYTY; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICimra055098;
	Sat, 18 May 2024 07:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036288;
	bh=VPaREiRTmandW1VVNogQssPNjYrkxOVaQwGJoi1ZkHI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dthQdYTYKEVD3XytPwLMxYFpI0/p2qDVk/gPrr+k4aUKGMBysbuvG7bki2vAzEaCk
	 MXkiXxWtBGnbo7EuaO+4xQM9Wd0z1zNnwL7JXxhXPyl2WXU6qXq7R0fOVNyqUCeaJB
	 URShu77GUbuGADkhaU5/RULKbY7Fv+b3uNpyx3nw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICimT0018265
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:44:48 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:44:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:44:48 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9i041511;
	Sat, 18 May 2024 07:44:44 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 28/28] net: ethernet: ti: cpsw-proxy-client: enable client driver functionality
Date: Sat, 18 May 2024 18:12:34 +0530
Message-ID: <20240518124234.2671651-29-s-vadapalli@ti.com>
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

Use the helpers added so far to enable the client driver functionality.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 82 +++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 90be8bb0e37d..3eccde764c17 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/kmemleak.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/rpmsg.h>
 #include <linux/dma/k3-udma-glue.h>
 
@@ -2227,9 +2228,33 @@ static void register_notifiers(struct cpsw_proxy_priv *proxy_priv)
 	}
 }
 
+static void show_info(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct device *dev = proxy_priv->dev;
+	struct virtual_port *vport;
+	u32 i;
+
+	dev_info(dev, "%u Virtual Switch Port(s), %u Virtual MAC Only Port(s)\n",
+		 proxy_priv->num_switch_ports, proxy_priv->num_mac_ports);
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+
+		if (vport->port_type == VIRT_SWITCH_PORT)
+			dev_info(dev, "Virt Port: %u, Type: Switch Port, Iface: %s, Num TX: %u, Num RX: %u, Token: %u\n",
+				 vport->port_id, vport->ndev->name, vport->num_tx_chan,
+				 vport->num_rx_chan, vport->port_token);
+		else
+			dev_info(dev, "Virt Port: %u, Type: MAC Port, Iface: %s, Num TX: %u, Num RX: %u, Token: %u\n",
+				 vport->port_id, vport->ndev->name, vport->num_tx_chan,
+				 vport->num_rx_chan, vport->port_token);
+	}
+}
+
 static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 {
 	struct cpsw_proxy_priv *proxy_priv;
+	int ret;
 
 	proxy_priv = devm_kzalloc(&rpdev->dev, sizeof(struct cpsw_proxy_priv), GFP_KERNEL);
 	if (!proxy_priv)
@@ -2237,22 +2262,79 @@ static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 
 	proxy_priv->rpdev = rpdev;
 	proxy_priv->dev = &rpdev->dev;
+	proxy_priv->dma_node = of_find_compatible_node(NULL, NULL,
+						       (const char *)rpdev->id.driver_data);
 	dev_set_drvdata(proxy_priv->dev, proxy_priv);
 	dev_dbg(proxy_priv->dev, "driver probed\n");
 
+	proxy_priv->req_params.token = ETHFW_TOKEN_NONE;
+	proxy_priv->req_params.client_id = ETHFW_LINUX_CLIENT_TOKEN;
+	mutex_init(&proxy_priv->req_params_mutex);
+	init_completion(&proxy_priv->wait_for_response);
+
+	ret = get_virtual_port_info(proxy_priv);
+	if (ret)
+		return -EIO;
+
+	ret = attach_virtual_ports(proxy_priv);
+	if (ret)
+		return -EIO;
+
+	ret = allocate_port_resources(proxy_priv);
+	if (ret)
+		goto err_attach;
+
+	ret = dma_coerce_mask_and_coherent(proxy_priv->dev, DMA_BIT_MASK(48));
+	if (ret) {
+		dev_err(proxy_priv->dev, "error setting dma mask: %d\n", ret);
+		goto err_attach;
+	}
+
+	ret = init_tx_chans(proxy_priv);
+	if (ret)
+		goto err_attach;
+
+	ret = init_rx_chans(proxy_priv);
+	if (ret)
+		goto err_attach;
+
+	ret = init_netdevs(proxy_priv);
+	if (ret)
+		goto err_attach;
+
+	ret = register_dma_irq_handlers(proxy_priv);
+	if (ret)
+		goto err_netdevs;
+
+	register_notifiers(proxy_priv);
+	show_info(proxy_priv);
+
 	return 0;
+
+err_netdevs:
+	unreg_netdevs(proxy_priv);
+err_attach:
+	detach_virtual_ports(proxy_priv);
+	return ret;
 }
 
 static void cpsw_proxy_client_remove(struct rpmsg_device *rpdev)
 {
+	struct cpsw_proxy_priv *proxy_priv;
 	struct device *dev = &rpdev->dev;
 
 	dev_dbg(dev, "driver removed\n");
+	proxy_priv = dev_get_drvdata(&rpdev->dev);
+	unregister_notifiers(proxy_priv);
+	unreg_netdevs(proxy_priv);
+	destroy_vport_wqs(proxy_priv);
+	detach_virtual_ports(proxy_priv);
 }
 
 static struct rpmsg_device_id cpsw_proxy_client_id_table[] = {
 	{
 		.name = ETHFW_SERVICE_EP_NAME,
+		.driver_data = (kernel_ulong_t)"ti,j721e-navss-main-udmap",
 	},
 	{},
 };
-- 
2.40.1


