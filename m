Return-Path: <netdev+bounces-183632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5248A9156E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0293AE2D1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF671FBCA7;
	Thu, 17 Apr 2025 07:38:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91321A431
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875535; cv=none; b=PEMS7Wz6EVPcoOTbrAhZ5wMyGtqSunRNoy9UH+GoFAtsFeqln+og4iPPSjLYy1ikp5dUMmHsTiXE92SxrFRKwe0cxx3AfuORiof04frXNn9cRotT8pTa9mV4STN+c+iILcuo1gBUK174FJ119A5lBhroFPuTA1PNxtHbBcxH4jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875535; c=relaxed/simple;
	bh=GqulGJ13HXfmmnbZYa2G+bOfdapO+4JVPbhx5Te4nQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mnqazqrtpqhtpnefVuhGaNOgzyL93YrPqCTkqKuodisjLk8FPYO+n9r20VoxoMExGFPU0ZR+LJbHVzBglPEijaeyJ9rfvAc2oEpWA2P3p0Od1iDL746zftimJRu1/sr1M/tEnWpWPJqYB9Iqa5E2+ZfcZDcDSo3UjLPnd2em+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz7t1744875479tde347f71
X-QQ-Originating-IP: UUkWQXDZLL8XrNoyoKq1yBXnLUfxizL6AAOici9hFYg=
Received: from wxdbg.localdomain.com ( [36.20.107.143])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Apr 2025 15:37:57 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9696252232013015513
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
Subject: [PATCH net-next v3 1/2] net: txgbe: Support to set UDP tunnel port
Date: Thu, 17 Apr 2025 16:03:27 +0800
Message-Id: <20250417080328.426554-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250417080328.426554-1-jiawenwu@trustnetic.com>
References: <20250417080328.426554-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MkhAA4qIuU0ppQof0gOONMyAXWPsDYFO71AWgC9v2gOvYOKkkJTX1OX6
	86WMlFP9OK16hKUgFuAU3q9tRMtR0VUBkkIouXLSDm6a1jWDRAeGOsL/L3ukeKiHZc478r7
	VoCEdzG+UoBJF+2RqNErC2LTg/iw0oPfBQRtO8lntUVfAs1xif3BStZ1oTpDs/tbNkjP9jb
	FkKAPOUuRGST0S8VI4ymAfB4JEFkwVeIDTgBSsr3/fnrXwmTnC1euIq9qvBvUGgsHJxjZ8P
	pIZ9Vl7hGu6DtcOkFO0X45pQm1q1TnCr7e63l+pIrLbd4P4RF3KlPVW+udrG/BRuqeGMvN2
	9HZ6OVYgRMayGnEqvwwtvjo0jbez7/fztraC6eMlHOa6gxaeFe34mXUi1KfdycCiCHAM2mJ
	nPIrz7ee9gtBgHmMVhnoR2BenWYVvhyIiw/qCVeeTIYds/0/0tSp6r6Id8fS1/KRQGDd/C5
	yjh+SfdQ1AAR0F32sWm2dbrbFT9JmrwyfqseViY76oiRRozw8s4iJxPMQA3dZESGFbF6lmf
	zTZ+50vFtsMks/vbMl9ofaRTJV9mn3rb6a+4rmsm2d3J9crVQehSdg7ninJOgg1mAjJJ5n+
	g4N1bdltyhRU1tJAgK/p0j0nDtlXgozhnzlO/Q/ZD6qhyBg4Y0+JIWHfydR9RyWIywwkMwL
	hpznLMekOt/lzTWRGHbnkXH4z2rZvf5dJppYYHiq7VD2g/a/SuO11A82Pv1IM1kk+JzfdN3
	ns+VDZGlpLrgCbcNzOmDQ53euJHoWAcOQ1cSsgLTbichQSXdj7rlZKnQ2z5hanqm3ANJ1Sq
	v/7xphcJxeNPaFgbKgXeH250Sdo9fdntToEaFlNKI5BLPrvuqUHmDh4PRAX83Bq9ANSe1Px
	br4pkmOP5VtlHycT1nkBoeQXgchLjzKQEnVXMH5E2JXXfLH5BYYYVjEF9PVSmbmSBVTfq6y
	XzSSe+ek+zlBUPYwEDhqcQAs4O62RCU8R0KM7e1bgybkCVm75I+JlF8fhVne55n9dLvfl3e
	3YV8BMwytqgzuDXpeu8TBont8eoaH4d3clDJ3rZ8S1RPVHmrtdkUWSJzh7xTFCdAPkGG1+v
	A==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Tunnel types VXLAN/VXLAN_GPE/GENEVE are supported for txgbe devices. The
hardware supports to set only one port for each tunnel type.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 38 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  3 ++
 2 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 6d9134a3ce4d..95e5262a1e9c 100644
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
@@ -537,6 +540,39 @@ void txgbe_do_reset(struct net_device *netdev)
 		txgbe_reset(wx);
 }
 
+static int txgbe_udp_tunnel_sync(struct net_device *dev, unsigned int table)
+{
+	struct wx *wx = netdev_priv(dev);
+	struct udp_tunnel_info ti;
+
+	udp_tunnel_nic_get_port(dev, table, 0, &ti);
+	switch (ti.type) {
+	case UDP_TUNNEL_TYPE_VXLAN:
+		wr32(wx, TXGBE_CFG_VXLAN, ntohs(ti.port));
+		break;
+	case UDP_TUNNEL_TYPE_VXLAN_GPE:
+		wr32(wx, TXGBE_CFG_VXLAN_GPE, ntohs(ti.port));
+		break;
+	case UDP_TUNNEL_TYPE_GENEVE:
+		wr32(wx, TXGBE_CFG_GENEVE, ntohs(ti.port));
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct udp_tunnel_nic_info txgbe_udp_tunnels = {
+	.sync_table	= txgbe_udp_tunnel_sync,
+	.flags		= UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
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
@@ -632,6 +668,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	wx->driver_name = txgbe_driver_name;
 	txgbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &txgbe_netdev_ops;
+	netdev->udp_tunnel_nic_info = &txgbe_udp_tunnels;
 
 	/* setup the private structure */
 	err = txgbe_sw_init(wx);
@@ -677,6 +714,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_HIGHDMA;
 	netdev->hw_features |= NETIF_F_GRO;
 	netdev->features |= NETIF_F_GRO;
+	netdev->features |= NETIF_F_RX_UDP_TUNNEL_PORT;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 5937cbc6bd05..cb553318641d 100644
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
-- 
2.27.0


