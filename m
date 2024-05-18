Return-Path: <netdev+bounces-97101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573138C9126
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E04B281B49
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46507D088;
	Sat, 18 May 2024 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XApwLL0o"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE67CF16;
	Sat, 18 May 2024 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036294; cv=none; b=bVIp86pT7ebaYonPkTPSx62yek/WsoL65mg8tGJr7Fg1v0D62TRe0L6iMDZ9u/Bd9euW0dDgn194ZmrILZLsFv/b1ShGnv75TP4YBAv85+qxGT105JVsxoDfFdllpy1NVxgJLk6Chynaqsuq+gBqXIyikNlJ49srpnefSSy/28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036294; c=relaxed/simple;
	bh=Cr1Hx/59i5Pd0utl/xEQlO3tb13qU2CGqkR40CyfqrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHTzpcZ3OB5sp0CvrAJkYbI/8CI3w+sCFXjSq0B8WPod7X02QpkNTn35hma82KmrWvGpWC+7Rt07R4irM2Lur4tdSvzEBEiVYPYFjI/5W3zggx+jI9EFYq5o6+uaad4FN9g2ZXmdtV2cq29PYq4jVYyC7E1Nhz4juDLsQQCG5Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XApwLL0o; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICidYo055082;
	Sat, 18 May 2024 07:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036279;
	bh=PBa9dvCuZos4JKSfHsV95/NYkFboZosIZz2HTkKHaWw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XApwLL0oybS7ZqecH5qupDsbrgBdWwUfB3pXK/vJe3XX8LvdkoIXbtMlp29J0t6a0
	 8cDh5EIKqMf+IZDOOvwBqTMNVwahSkVkFA3Fvur5CPNzA7o3zeTW8QdoqkhZzzC/gL
	 7MHXuJLscNU/SKjRQtsbNELBsh8u6qY4vUclf84Q=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICidik018223
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:44:39 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:44:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:44:38 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9g041511;
	Sat, 18 May 2024 07:44:34 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 26/28] net: ethernet: ti: cpsw-proxy-client: add ndo_set_rx_mode member
Date: Sat, 18 May 2024 18:12:32 +0530
Message-ID: <20240518124234.2671651-27-s-vadapalli@ti.com>
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

Add the .ndo_set_rx_mode callback named "vport_set_rx_mode()". Syncing
the Multicast Address list requires adding/deleting Multicast Addresses
registered with EthFw.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 131 ++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index 9ede3e584a06..56311b019376 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -106,6 +106,9 @@ struct virtual_port {
 	struct net_device		*ndev;
 	struct rx_dma_chan		*rx_chans;
 	struct tx_dma_chan		*tx_chans;
+	struct netdev_hw_addr_list	mcast_list;
+	struct workqueue_struct		*vport_wq;
+	struct work_struct		rx_mode_work;
 	struct completion		tdown_complete;
 	struct notifier_block		inetaddr_nb;
 	enum virtual_port_type		port_type;
@@ -1428,6 +1431,59 @@ static void vport_rx_cleanup(void *data, dma_addr_t desc_dma)
 	dev_kfree_skb_any(skb);
 }
 
+static int vport_add_mcast(struct net_device *ndev, const u8 *addr)
+{
+	struct virtual_port *vport = vport_ndev_to_vport(ndev);
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	struct rx_dma_chan *rx_chn = &vport->rx_chans[0];
+	struct cpsw_proxy_req_params *req_p;
+	struct message resp_msg;
+	int ret;
+
+	mutex_lock(&proxy_priv->req_params_mutex);
+	req_p = &proxy_priv->req_params;
+	req_p->request_type = ETHFW_MCAST_FILTER_ADD;
+	req_p->token = vport->port_token;
+	req_p->vlan_id = ETHFW_DFLT_VLAN;
+	req_p->rx_flow_base = rx_chn->flow_base;
+	req_p->rx_flow_offset = rx_chn->flow_offset;
+	ether_addr_copy(req_p->mac_addr, addr);
+	ret = send_request_get_response(proxy_priv, &resp_msg);
+	mutex_unlock(&proxy_priv->req_params_mutex);
+
+	if (ret) {
+		dev_err(proxy_priv->dev, "failed to add mcast filter, err: %d\n", ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int vport_del_mcast(struct net_device *ndev, const u8 *addr)
+{
+	struct virtual_port *vport = vport_ndev_to_vport(ndev);
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	struct cpsw_proxy_req_params *req_p;
+	struct message resp_msg;
+	int ret;
+
+	mutex_lock(&proxy_priv->req_params_mutex);
+	req_p = &proxy_priv->req_params;
+	req_p->request_type = ETHFW_MCAST_FILTER_DEL;
+	req_p->token = vport->port_token;
+	req_p->vlan_id = ETHFW_DFLT_VLAN;
+	ether_addr_copy(req_p->mac_addr, addr);
+	ret = send_request_get_response(proxy_priv, &resp_msg);
+	mutex_unlock(&proxy_priv->req_params_mutex);
+
+	if (ret) {
+		dev_err(proxy_priv->dev, "failed to delete mcast filter, err: %d\n", ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static void vport_stop(struct virtual_port *vport)
 {
 	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
@@ -1466,6 +1522,9 @@ static void vport_stop(struct virtual_port *vport)
 		napi_disable(&rx_chn->napi_rx);
 		hrtimer_cancel(&rx_chn->rx_hrtimer);
 	}
+
+	if (vport->port_features & ETHFW_MCAST_FILTERING)
+		cancel_work_sync(&vport->rx_mode_work);
 }
 
 static int vport_open(struct virtual_port *vport, netdev_features_t features)
@@ -1533,6 +1592,8 @@ static int vport_ndo_stop(struct net_device *ndev)
 		netdev_err(ndev, "failed to deregister MAC for port %u\n",
 			   vport->port_id);
 
+	__dev_mc_unsync(ndev, vport_del_mcast);
+	__hw_addr_init(&vport->mcast_list);
 	vport_stop(vport);
 
 	dev_info(proxy_priv->dev, "stopped port %u on interface %s\n",
@@ -1786,6 +1847,31 @@ static void vport_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue)
 	}
 }
 
+static void vport_set_rx_mode_work(struct work_struct *work)
+{
+	struct virtual_port *vport = container_of(work, struct virtual_port, rx_mode_work);
+	struct net_device *ndev;
+
+	if (likely(vport->port_features & ETHFW_MCAST_FILTERING)) {
+		ndev = vport->ndev;
+
+		netif_addr_lock_bh(ndev);
+		__hw_addr_sync(&vport->mcast_list, &ndev->mc, ndev->addr_len);
+		netif_addr_unlock_bh(ndev);
+
+		__hw_addr_sync_dev(&vport->mcast_list, ndev,
+				   vport_add_mcast, vport_del_mcast);
+	}
+}
+
+static void vport_set_rx_mode(struct net_device *ndev)
+{
+	struct virtual_port *vport = vport_ndev_to_vport(ndev);
+
+	if (vport->port_features & ETHFW_MCAST_FILTERING)
+		queue_work(vport->vport_wq, &vport->rx_mode_work);
+}
+
 static const struct net_device_ops cpsw_proxy_client_netdev_ops = {
 	.ndo_open		= vport_ndo_open,
 	.ndo_stop		= vport_ndo_stop,
@@ -1794,6 +1880,7 @@ static const struct net_device_ops cpsw_proxy_client_netdev_ops = {
 	.ndo_tx_timeout		= vport_ndo_tx_timeout,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= eth_mac_addr,
+	.ndo_set_rx_mode	= vport_set_rx_mode,
 };
 
 static int init_netdev(struct cpsw_proxy_priv *proxy_priv, struct virtual_port *vport)
@@ -1871,12 +1958,56 @@ static void unreg_netdevs(struct cpsw_proxy_priv *proxy_priv)
 	}
 }
 
+static void destroy_vport_wqs(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct virtual_port *vport;
+	u32 i;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+		if (vport->vport_wq)
+			destroy_workqueue(vport->vport_wq);
+	}
+}
+
+static int create_vport_wqs(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct virtual_port *vport;
+	char wq_name[IFNAMSIZ];
+	u32 i;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+		if (!(vport->port_features & ETHFW_MCAST_FILTERING))
+			continue;
+
+		snprintf(wq_name, sizeof(wq_name), "vport_%d", vport->port_id);
+		__hw_addr_init(&vport->mcast_list);
+		INIT_WORK(&vport->rx_mode_work, vport_set_rx_mode_work);
+		vport->vport_wq = create_singlethread_workqueue(wq_name);
+		if (!vport->vport_wq) {
+			dev_err(proxy_priv->dev, "failed to create wq %s\n", wq_name);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	destroy_vport_wqs(proxy_priv);
+	return -ENOMEM;
+}
+
 static int init_netdevs(struct cpsw_proxy_priv *proxy_priv)
 {
 	struct virtual_port *vport;
 	int ret;
 	u32 i;
 
+	ret = create_vport_wqs(proxy_priv);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
 		vport = &proxy_priv->virt_ports[i];
 		ret = init_netdev(proxy_priv, vport);
-- 
2.40.1


