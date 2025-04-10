Return-Path: <netdev+bounces-181112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C920A83AFF
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4982019E40A2
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4FA20C496;
	Thu, 10 Apr 2025 07:20:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55931CEEB2
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269601; cv=none; b=W7t0CdSiIoDG+rwu/hgg6MbgHLgt+ccBAmyb8ZvWyI0+Ea9sCtYKrrV7QYOtxCdC9p/JsFWihcp8dbazrMbJEJEKK0unmmvMrVqPOH/Fws0aZhK05A9TkWI1an/w3+L3Hcw0SIVCUJT7z8Yxg/rP/41jnZVQ6nh4gHIDihDV+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269601; c=relaxed/simple;
	bh=kTmE58ndy6K/bnlmL9jUzW6r76Cx/e1DVn1Feuzz0kE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXTTDO0qQbt+ru2En3qbZ1QtfNESPLIqDGFuz7R3W5gdyM4MY2BIqxuH8inCeI7mXY0ayhgeVIK2Bq20Kz3sEhxmpJZgj7JSyTBM6rUVwfYYL/a9GAKqDgWr7ugTq0wvoFdXF1Q2N+CTcomjzYN0RtMsin4JXqCzGpVcKcSGXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp25t1744269561tcba7ca4
X-QQ-Originating-IP: MoPuc4KUxsoYlga7mdOcPTi6WA5Jz0Ry11j+tgc6ci8=
Received: from wxdbg.localdomain.com ( [220.184.249.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Apr 2025 15:19:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 593996941820147345
EX-QQ-RecipientCnt: 16
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dlemoal@kernel.org,
	jdamato@fastly.com,
	saikrishnag@marvell.com,
	vadim.fedorenko@linux.dev,
	przemyslaw.kitszel@intel.com,
	ecree.xilinx@gmail.com,
	rmk+kernel@armlinux.org.uk
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 1/2] net: txgbe: Support to set UDP tunnel port
Date: Thu, 10 Apr 2025 15:44:55 +0800
Message-Id: <20250410074456.321847-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250410074456.321847-1-jiawenwu@trustnetic.com>
References: <20250410074456.321847-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ND42uzdxTIzr/c/Lyc+oOqI8jYSgj8FHiquEpnNVyCVWguPvKm1z2cB6
	v6D3fo9+7gB1y/DRN0C8zp0eymS6EaY6l90btd8dQ5fw8rGVzsX768X8rsMtgX51CKEUr79
	rOAQl0RjHy1eHg+Q9oM9TYQ58ZjQI0Xamm42o1/q0i1cRkJkMZBlsSpgwElWsqgBNABkHYP
	zGI7pdrw9IPFFI4EeIvAyvGTLeduqCxLgFA3u1ymfUWWLLzfUaZ2c6qwoeeNSgMWdl2UYDa
	T+zp36BiSUEgtBmN/4qwkXj8dFg4L3lSlcHdjC8rOF9XdVnoC/lAUTX1PyL9lo5O43RMb61
	jxzgnAg1A+aK2/XiICY4ZXLCWj/oZmu1ah/EyagP6tbbVveBaxprgEHEK/lKpk4bEkeuRrz
	vlt3ZCl1F54pZB8cXOPk+R/4hKf3QYk5p9zdT/JHWH3yV1j239XMCiyteULaLGaKwqfKAOb
	M/yDIOvxNx2ZZ/4Zdjph+dLKPmREXXXXioBWdIF55Go/nMs+XD2MvJ3Sq9RkwXgoKCrjI37
	43iw0gwxXMt0QrcgIvhW/bWYnZRr+IaOlpcpENRZ9vkH2vae1HwtV83dRshf75MqK8s0PyA
	f2ZQQs2rTWL6/sNOBjhR3S0ZE59lpAUMnGGhS9uowFiWlCRyDwpAzGcLqJesirLWjt01sEm
	HszYK5gDWi0/PopU5HSoozqlRwoylFwnyv4QVE5lZv4XM8C7O5Qee6i+1D5G5jY4EANBmwj
	KXQFnNZo3Y/LGU89VXGAnNg0HyKbrjU7Y/fxZ0FaXDvPHMvJURJqfAOx4tvmCpIqWPjofa5
	syXIYQZAzrdGs6Rh9MMX0SFG8q2qmPmI6VhYXCEjj74hzmMZHB8Xy+ARFusphF7WuSlNu3h
	JP+nSZoNYNmwvTY+j2mwWAylZjXx7R3j/4XeN0RqWsBif/0Q9YtOvhkppGTLFSGxAG/7JnT
	hC07jHwRIhYQkZrQO+0DMCD5duSJy1HD8gidDPhICOmyH5hhl7hUF7cpb
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Tunnel types VXLAN/VXLAN_GPE/GENEVE are supported for txgbe devices. The
hardware supports to set only one port for each tunnel type.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 113 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   8 ++
 2 files changed, 121 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 6d9134a3ce4d..c984745504b4 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/etherdevice.h>
 #include <linux/phylink.h>
+#include <net/udp_tunnel.h>
 #include <net/ip.h>
 #include <linux/if_vlan.h>
 
@@ -392,6 +393,8 @@ static int txgbe_open(struct net_device *netdev)
 
 	txgbe_up_complete(wx);
 
+	udp_tunnel_nic_reset_ntf(netdev);
+
 	return 0;
 
 err_free_irq:
@@ -537,6 +540,114 @@ void txgbe_do_reset(struct net_device *netdev)
 		txgbe_reset(wx);
 }
 
+static int txgbe_udp_tunnel_set(struct net_device *dev, unsigned int table,
+				unsigned int entry, struct udp_tunnel_info *ti)
+{
+	struct wx *wx = netdev_priv(dev);
+	struct txgbe *txgbe = wx->priv;
+
+	switch (ti->type) {
+	case UDP_TUNNEL_TYPE_VXLAN:
+		if (txgbe->vxlan_port == ti->port)
+			break;
+
+		if (txgbe->vxlan_port) {
+			wx_err(wx, "VXLAN port %d set, not adding port %d\n",
+			       txgbe->vxlan_port, ti->port);
+			return -EINVAL;
+		}
+
+		txgbe->vxlan_port = ti->port;
+		wr32(wx, TXGBE_CFG_VXLAN, ntohs(ti->port));
+		break;
+	case UDP_TUNNEL_TYPE_VXLAN_GPE:
+		if (txgbe->vxlan_gpe_port == ti->port)
+			break;
+
+		if (txgbe->vxlan_gpe_port) {
+			wx_err(wx, "VXLAN-GPE port %d set, not adding port %d\n",
+			       txgbe->vxlan_gpe_port, ti->port);
+			return -EINVAL;
+		}
+
+		txgbe->vxlan_gpe_port = ti->port;
+		wr32(wx, TXGBE_CFG_VXLAN_GPE, ntohs(ti->port));
+		break;
+	case UDP_TUNNEL_TYPE_GENEVE:
+		if (txgbe->geneve_port == ti->port)
+			break;
+
+		if (txgbe->geneve_port) {
+			wx_err(wx, "GENEVE port %d set, not adding port %d\n",
+			       txgbe->geneve_port, ti->port);
+			return -EINVAL;
+		}
+
+		txgbe->geneve_port = ti->port;
+		wr32(wx, TXGBE_CFG_GENEVE, ntohs(ti->port));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int txgbe_udp_tunnel_unset(struct net_device *dev,
+				  unsigned int table, unsigned int entry,
+				  struct udp_tunnel_info *ti)
+{
+	struct wx *wx = netdev_priv(dev);
+	struct txgbe *txgbe = wx->priv;
+
+	if (ti->type != UDP_TUNNEL_TYPE_VXLAN &&
+	    ti->type != UDP_TUNNEL_TYPE_VXLAN_GPE &&
+	    ti->type != UDP_TUNNEL_TYPE_GENEVE)
+		return -EINVAL;
+
+	switch (ti->type) {
+	case UDP_TUNNEL_TYPE_VXLAN:
+		if (txgbe->vxlan_port != ti->port) {
+			wx_err(wx, "VXLAN port %d not found\n", ti->port);
+			return -EINVAL;
+		}
+
+		txgbe->vxlan_port = 0;
+		break;
+	case UDP_TUNNEL_TYPE_VXLAN_GPE:
+		if (txgbe->vxlan_gpe_port != ti->port) {
+			wx_err(wx, "VXLAN-GPE port %d not found\n", ti->port);
+			return -EINVAL;
+		}
+
+		txgbe->vxlan_gpe_port = 0;
+		break;
+	case UDP_TUNNEL_TYPE_GENEVE:
+		if (txgbe->geneve_port != ti->port) {
+			wx_err(wx, "GENEVE port %d not found\n", ti->port);
+			return -EINVAL;
+		}
+
+		txgbe->geneve_port = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct udp_tunnel_nic_info txgbe_udp_tunnels = {
+	.set_port	= txgbe_udp_tunnel_set,
+	.unset_port	= txgbe_udp_tunnel_unset,
+	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP,
+	.tables		= {
+		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_VXLAN, },
+		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_VXLAN_GPE, },
+		{ .n_entries = 1, .tunnel_types = UDP_TUNNEL_TYPE_GENEVE, },
+	},
+};
+
 static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_open               = txgbe_open,
 	.ndo_stop               = txgbe_close,
@@ -632,6 +743,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	wx->driver_name = txgbe_driver_name;
 	txgbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &txgbe_netdev_ops;
+	netdev->udp_tunnel_nic_info = &txgbe_udp_tunnels;
 
 	/* setup the private structure */
 	err = txgbe_sw_init(wx);
@@ -677,6 +789,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_HIGHDMA;
 	netdev->hw_features |= NETIF_F_GRO;
 	netdev->features |= NETIF_F_GRO;
+	netdev->features |= NETIF_F_RX_UDP_TUNNEL_PORT;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 5937cbc6bd05..67ea81dfe786 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -88,6 +88,9 @@
 /* Port cfg registers */
 #define TXGBE_CFG_PORT_ST                       0x14404
 #define TXGBE_CFG_PORT_ST_LINK_UP               BIT(0)
+#define TXGBE_CFG_VXLAN                         0x14410
+#define TXGBE_CFG_VXLAN_GPE                     0x14414
+#define TXGBE_CFG_GENEVE                        0x14418
 
 /* I2C registers */
 #define TXGBE_I2C_BASE                          0x14900
@@ -359,6 +362,11 @@ struct txgbe {
 	union txgbe_atr_input fdir_mask;
 	int fdir_filter_count;
 	spinlock_t fdir_perfect_lock; /* spinlock for FDIR */
+
+	/* tunnel port */
+	__be16 vxlan_port;
+	__be16 geneve_port;
+	__be16 vxlan_gpe_port;
 };
 
 #endif /* _TXGBE_TYPE_H_ */
-- 
2.27.0


