Return-Path: <netdev+bounces-97100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE1A8C9123
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4DC1C21649
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5026C7BAE7;
	Sat, 18 May 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PUDyOwSh"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0A78C90;
	Sat, 18 May 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036288; cv=none; b=I+PBPip7LOcGA7GJ8dPvVlDj7YRrHHnIEJHIAiMO/K7EZpNe7MHiveS/NBGhZZSiOghVuE2PDehOG005yzgE1V38Bkke8mLfXc1E8kyErvJ16O/rYrzIno+ntZnn7yRsLrqDBQyPd8MBZdJvXQM79NnFyBdSCdY7+pVUnoTw26M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036288; c=relaxed/simple;
	bh=JeL3kwHWA27IQ2xJNUr2/T733iTEUzbEQ8JMyAkCjw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+UXLwJpgoQFT/REp8UocdPAzP6bd00QWlDvt8mEC8Ix3z6WErwt4DF5iDoydcxWozchJI0SP+RVVPiaHeRd9/bGvjN0JMjbkB5ZhqVMMwPduZOI2ZnMzFet5NVKtCQ64fQsGTwZqjNhp1x4CTlGey+pT7NHS83+fScEy3358bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PUDyOwSh; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICiYIA055074;
	Sat, 18 May 2024 07:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036274;
	bh=0ukhBT1ImvjnHFh3BaA3f4C26i8afBnuBDClD1lDvQc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PUDyOwShCQFYYmfFIrHVZtG2mkkAWFSWPitVmTUF4wTB5oefF8sv8BC714Jfr53jF
	 pxMtCd/+n4eDD7gvW9XURjsBkLFwyGQ0H4IeeqRDadCKJtQJG2INNbTSmB/B2No1kK
	 fntnmtnEEQP6QWhZieVsMMM1ZZi8kNFakbILRKOU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICiYl9005092
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:44:34 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:44:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:44:34 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9f041511;
	Sat, 18 May 2024 07:44:30 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 25/28] net: ethernet: ti: cpsw-proxy-client: add helpers to (de)register IPv4
Date: Sat, 18 May 2024 18:12:31 +0530
Message-ID: <20240518124234.2671651-26-s-vadapalli@ti.com>
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

Add functions "register_ipv4()" and "deregister_ipv4()" to register and
deregister IPv4 Address of the network interface corresponding to the
Virtual Switch Port with EthFw. Registering the IPv4 Address with EthFw
is necessary in the case of the Virtual Switch Port. This is because all
Broadcast packets received on any of the Switch Ports are consumed by
EthFw. This includes the ARP request for the IPv4 Address of the network
interface corresponding to the Virtual Switch Port as well. Thus,
registering the IPv4 Address with EthFw results in EthFw responding to
the ARP request thereby enabling subsequent Unicast communication with
the network interface corresponding to the Virtual Switch Port.

Add a notifier block to register/deregister the IPv4 address with EthFw
corresponding to interface state changes as well as IPv4 Address
changes.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 121 ++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
index b42be0d389b8..9ede3e584a06 100644
--- a/drivers/net/ethernet/ti/cpsw-proxy-client.c
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -8,6 +8,7 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
+#include <linux/inetdevice.h>
 #include <linux/kernel.h>
 #include <linux/kmemleak.h>
 #include <linux/module.h>
@@ -106,6 +107,7 @@ struct virtual_port {
 	struct rx_dma_chan		*rx_chans;
 	struct tx_dma_chan		*tx_chans;
 	struct completion		tdown_complete;
+	struct notifier_block		inetaddr_nb;
 	enum virtual_port_type		port_type;
 	atomic_t			tdown_cnt;
 	u32				port_id;
@@ -113,6 +115,7 @@ struct virtual_port {
 	u32				port_features;
 	u32				num_rx_chan;
 	u32				num_tx_chan;
+	u8				ipv4_addr[ETHFW_IPV4ADDRLEN];
 	u8				mac_addr[ETH_ALEN];
 	bool				mac_in_use;
 };
@@ -1952,6 +1955,124 @@ static int register_dma_irq_handlers(struct cpsw_proxy_priv *proxy_priv)
 	return 0;
 }
 
+static int register_ipv4(struct virtual_port *vport)
+{
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	struct device *dev = proxy_priv->dev;
+	struct cpsw_proxy_req_params *req_p;
+	struct message resp_msg;
+	int ret;
+
+	mutex_lock(&proxy_priv->req_params_mutex);
+	req_p = &proxy_priv->req_params;
+	req_p->request_type = ETHFW_IPv4_REGISTER;
+	memcpy(req_p->ipv4_addr, vport->ipv4_addr, ETHFW_IPV4ADDRLEN);
+	ether_addr_copy(req_p->mac_addr, vport->mac_addr);
+	ret = send_request_get_response(proxy_priv, &resp_msg);
+	mutex_unlock(&proxy_priv->req_params_mutex);
+
+	if (ret) {
+		dev_err(dev, "failed to register IPv4 Address err: %d\n", ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int deregister_ipv4(struct virtual_port *vport)
+{
+	struct cpsw_proxy_priv *proxy_priv = vport->proxy_priv;
+	struct device *dev = proxy_priv->dev;
+	struct cpsw_proxy_req_params *req_p;
+	struct message resp_msg;
+	int ret;
+
+	mutex_lock(&proxy_priv->req_params_mutex);
+	req_p = &proxy_priv->req_params;
+	req_p->request_type = ETHFW_IPv4_DEREGISTER;
+	memcpy(req_p->ipv4_addr, vport->ipv4_addr, ETHFW_IPV4ADDRLEN);
+	ret = send_request_get_response(proxy_priv, &resp_msg);
+	mutex_unlock(&proxy_priv->req_params_mutex);
+
+	if (ret) {
+		dev_err(dev, "failed to deregister IPv4 Address err: %d\n", ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static bool cpsw_proxy_client_check(const struct net_device *ndev)
+{
+	struct virtual_port *vport = vport_ndev_to_vport(ndev);
+
+	return ndev->netdev_ops == &cpsw_proxy_client_netdev_ops &&
+				   vport->port_type == VIRT_SWITCH_PORT;
+}
+
+static int cpsw_proxy_client_inetaddr(struct notifier_block *unused,
+				      unsigned long event, void *ptr)
+{
+	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
+	struct virtual_port *vport;
+	struct net_device *ndev;
+	int ret = 0;
+
+	ndev = ifa->ifa_dev ? ifa->ifa_dev->dev : NULL;
+	if (!ndev)
+		return NOTIFY_DONE;
+
+	if (!cpsw_proxy_client_check(ndev))
+		return NOTIFY_DONE;
+
+	vport = vport_ndev_to_vport(ndev);
+	memcpy(vport->ipv4_addr, &ifa->ifa_address, ETHFW_IPV4ADDRLEN);
+
+	switch (event) {
+	case NETDEV_UP:
+	case NETDEV_CHANGEADDR:
+		ret = register_ipv4(vport);
+		if (ret)
+			netdev_err(ndev, "IPv4 register failed: %d\n", ret);
+		break;
+
+	case NETDEV_DOWN:
+	case NETDEV_PRE_CHANGEADDR:
+		ret = deregister_ipv4(vport);
+		if (ret)
+			netdev_err(ndev, "IPv4 deregister failed: %d\n", ret);
+		break;
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static void unregister_notifiers(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct virtual_port *vport;
+	u32 i;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+		if (vport->port_type == VIRT_SWITCH_PORT)
+			unregister_inetaddr_notifier(&vport->inetaddr_nb);
+	}
+}
+
+static void register_notifiers(struct cpsw_proxy_priv *proxy_priv)
+{
+	struct virtual_port *vport;
+	u32 i;
+
+	for (i = 0; i < proxy_priv->num_virt_ports; i++) {
+		vport = &proxy_priv->virt_ports[i];
+		if (vport->port_type == VIRT_SWITCH_PORT) {
+			vport->inetaddr_nb.notifier_call = cpsw_proxy_client_inetaddr;
+			register_inetaddr_notifier(&vport->inetaddr_nb);
+		}
+	}
+}
+
 static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
 {
 	struct cpsw_proxy_priv *proxy_priv;
-- 
2.40.1


