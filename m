Return-Path: <netdev+bounces-97088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A65E8C90FF
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB592814DA
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8C345026;
	Sat, 18 May 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L8mkyL21"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64C71B5C;
	Sat, 18 May 2024 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036235; cv=none; b=At6NX0Je3PbVW5shpDko3jvM9xrug64wQ6PTWpT6+tqsNJDK0lMLUqCBP/rm8+rs7CR6I1iCGT+xU7Rh6EMhwb2lbdPRNQHLEZBbcb0fcQuRWYZ+3Sv0JY826XN/bSW8WOzGZ30sR4QUXvfXWX0lbsQEg/uykoy8kJrtwhGltds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036235; c=relaxed/simple;
	bh=NFlMcR2OvOGa5KH83GGrhf/DAKBykXJk9Yz4ChOs2/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/MSZNwWn5zJJt4HLcRqFjdI6pm5a+1qvkNxYApvYLxADWeiudV0LdiG/dpUrBDjDqV9yI9JIKVVvaJUMeKOB2sSf5Daeu+j42tcn1m2ybw3E6G3WSGaxk/hjP5zeYXa6G4Y1xQ7ZVah+Vt5ILik7Aov0oUn0E94UdcZJjvaje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L8mkyL21; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44IChdGU017302;
	Sat, 18 May 2024 07:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036219;
	bh=JwuJzNh8I8iVqcX/z+Q5XQWtzHIZzmIwva4vCStI6+U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=L8mkyL21BhOgbyPfkReoRNFCZ/ow3iMSQzpYWoF7fH76tv/j0ggEbcup5QShbcvbL
	 sPRs23XsLB2qY1JU6kchl6pU4Qw7vv7HhdbXS0aXyxzzo1hsM0fgAGRsI/2J8NU4Wn
	 kUV72+hTdEYPBlGgBUGngVrqrjK54CyQ7rcGs15g=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44IChd6e129545
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:43:39 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:43:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:43:39 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9T041511;
	Sat, 18 May 2024 07:43:35 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 13/28] net: ethernet: ti: cpsw-proxy-client: add helper to create netdevs
Date: Sat, 18 May 2024 18:12:19 +0530
Message-ID: <20240518124234.2671651-14-s-vadapalli@ti.com>
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

Add the function "init_netdevs()" to initialize and register net-device
for each Virtual Port.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 102 ++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 6926f65a4613..30d53a8e174e 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/if_vlan.h>
 #include <linux/kernel.h>
 #include <linux/kmemleak.h>
@@ -25,6 +26,7 @@
 #define MAX_RX_DESC	500
 #define MAX_RX_FLOWS	1
 
+#define MIN_PACKET_SIZE	ETH_ZLEN
 #define MAX_PACKET_SIZE	(VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
 
 #define CHAN_NAME_LEN	128
@@ -1177,6 +1179,106 @@ static int vport_rx_poll(struct napi_struct *napi_rx, int budget)
 	return num_rx;
 }
 
+const struct ethtool_ops cpsw_proxy_client_ethtool_ops = {
+};
+
+static const struct net_device_ops cpsw_proxy_client_netdev_ops = {
+};
+
+static int init_netdev(struct cpsw_proxy_priv *proxy_priv, struct virtual_port *vport)
+{
+	struct device *dev = proxy_priv->dev;
+	struct vport_netdev_priv *ndev_priv;
+	struct rx_dma_chan *rx_chn;
+	struct tx_dma_chan *tx_chn;
+	int ret = 0;
+	u32 i;
+
+	vport->ndev = devm_alloc_etherdev_mqs(dev, sizeof(struct vport_netdev_priv),
+					      vport->num_tx_chan, vport->num_rx_chan);
+
+	if (!vport->ndev) {
+		dev_err(dev, "error allocating netdev for port %u\n", vport->port_id);
+		return -ENOMEM;
+	}
+
+	ndev_priv = netdev_priv(vport->ndev);
+	ndev_priv->vport = vport;
+	SET_NETDEV_DEV(vport->ndev, dev);
+
+	if (is_valid_ether_addr(vport->mac_addr))
+		eth_hw_addr_set(vport->ndev, vport->mac_addr);
+
+	vport->ndev->min_mtu = MIN_PACKET_SIZE;
+	vport->ndev->max_mtu = MAX_PACKET_SIZE;
+	vport->ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM;
+	vport->ndev->features = vport->ndev->hw_features;
+	vport->ndev->vlan_features |= NETIF_F_SG;
+	vport->ndev->netdev_ops = &cpsw_proxy_client_netdev_ops;
+	vport->ndev->ethtool_ops = &cpsw_proxy_client_ethtool_ops;
+
+	ndev_priv->stats = netdev_alloc_pcpu_stats(struct vport_netdev_stats);
+	if (!ndev_priv->stats)
+		return -ENOMEM;
+
+	ret = devm_add_action_or_reset(dev, (void(*)(void *))free_percpu, ndev_priv->stats);
+	if (ret) {
+		dev_err(dev, "failed to add free_percpu action, err: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < vport->num_tx_chan; i++) {
+		tx_chn = &vport->tx_chans[i];
+		netif_napi_add_tx(vport->ndev, &tx_chn->napi_tx, vport_tx_poll);
+	}
+
+	for (i = 0; i < vport->num_rx_chan; i++) {
+		rx_chn = &vport->rx_chans[i];
+		netif_napi_add(vport->ndev, &rx_chn->napi_rx, vport_rx_poll);
+	}
+
+	ret = register_netdev(vport->ndev);
+	if (ret)
+		dev_err(dev, "error registering net device, err: %d\n", ret);
+
+	return ret;
+}
+
+static void unreg_netdevs(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct virtual_port *vport;
+	u32 i;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+		if (vport->ndev)
+			unregister_netdev(vport->ndev);
+	}
+}
+
+static int init_netdevs(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct virtual_port *vport;
+	int ret;
+	u32 i;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+		ret = init_netdev(proxy_priv, vport);
+		if (ret) {
+			dev_err(proxy_priv->dev, "failed to initialize ndev for port %u\n",
+				vport->port_id);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	unreg_netdevs(proxy_priv);
+	return ret;
+}
+
 static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 {
 	struct cpsw_proxy_priv *proxy_priv;
-- 
2.40.1


