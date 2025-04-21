Return-Path: <netdev+bounces-184316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FAAA94A9C
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 04:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2B4188E535
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 02:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C8D255E22;
	Mon, 21 Apr 2025 02:05:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C610A3E
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745201134; cv=none; b=TGAWtfaoGSjHCcOODKWtG6p00grmFOLXdDvcEws3F49NSM8/wgvyD/8XiTs362/tb9bdI7tARvPqJgLMgf2gm/3pQd4N4ammo3HBWAeO41jVJ3WKZJ9VLk0UG0HF3ZjZ4iX0Gm9xsGGz4j3rs3wF0/VZkfPRNf5gtuCZWXLArRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745201134; c=relaxed/simple;
	bh=bxkA/xRnTO+23LrSMmSOuH3R6DZpMeue6K8vi+sE3kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6z1w09kgSvJTrZ5nSvllSG011SQ7S85ZFqgrx5hLdzYZAPCdc6N7OGmUmwChm870F6SPU9+YRjuNW+J9VkyALmnpnNEalyaMdWYS7xlCpoiGQXM993Nj6QgLQnUVpVWo9pm6un+QBOsQ3MNHLsp59mxCgOezMBQixh0ze+CYzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz8t1745201077t07229127
X-QQ-Originating-IP: ZYRHkLjRijYZiTb67tTrI1sZc98P/fOJVVuwUzyIu7w=
Received: from wxdbg.localdomain.com ( [36.24.64.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Apr 2025 10:04:36 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9304366641775607332
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
Subject: [PATCH net-next v4 1/2] net: txgbe: Support to set UDP tunnel port
Date: Mon, 21 Apr 2025 10:29:55 +0800
Message-Id: <20250421022956.508018-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250421022956.508018-1-jiawenwu@trustnetic.com>
References: <20250421022956.508018-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NEltKXPr+ZXQfk6gkUM/LCyFFPxD+pYbbe/lWW8V3Zm/JCu3mha0XqYO
	utFEGKSF52qiVa8zZzMKqc75boi5T6wKktzGExQGtBtK6ObdZUycOdKDPdvhepEHLZ2Yd+5
	HlNl+ZTC6MMYyM8fAH7L/i0IXy7BSJDrV2JahzYjvqwk2F7TaRev8HXAMeA39DEoYXBKDHe
	FM72rDK4pooudzmwxhHhvB7JMRsXy8tu+0UeczsBLmkDwou/Y8LpkBsVscBA/hBN3rVgYDf
	Rcmnl8Pb2dLRTuhwUdTTuItq48TN+QBfnXG/CQzDbXoP28aoN/rubxcsGwY+wjEl+NNOanO
	hyYgHAKKUlBnt6DjGKCF//XBOTIQCkOLOK/jcU97P+K7wel9c4KSqIKJ7lxBTorIJVD2Qsj
	PEVtcROlRehCMhBw+qhphTob0k8PB281zbvD4K7fCUfANRFYI+7PpGq38LPD5U7rjIhKQrW
	lMPcip2cbqcxmUWMmgOMT68LAxb2YQ8bcynXInESqhpGTAtFluvtAVlIgSzTH3a2AlBlIIE
	6VjAqcO0Yaj8b9Apbg7zjpsY23lf3aSlvQTfBkyJ0VvDyPHAWKFlqxO/FVm9SKUgTk0EEnV
	teywVo2Pp8cFq06iHyF2rGyGrEfuDwELp6rOwykw9w3YXitBbHn0X13hFjmnEgZsO0f0LIK
	edtRXUhMxXCzYZbI5idIo+j9PxLQHhQcwFWGnHIAQetv4GvWQxue0dx/l1qSjalxdF6Nd8o
	2hpntVA+ClgxKLKMXP4lK+YQMlwAslOHJD6CPe6FpptjoTR6UyJhC0VnLzNdLF9r5mfH0HI
	+gdDJh0pYoO6tBamsrsxIkZ5Uux3ZgIQirxajGdNdJWwl/PuN/6tTspvtzZ7ez3qhDFvmBH
	2NApw70z/VpRW7k4gn8qnhxMzdgQkuRie2vNjQKZXGt4BUuPqqGpy6diQ9gl1tJgol2aiGK
	y1swO7h3OVo5+RXdnphH9L3uIg5Wui5LNrX3LV0zpj9+mibd7ktjSu8HdOkVB6m3fqEx82c
	6UKzjBzFEkfyUdMtjWP1sqa46IUAa6nyKJBCM8FnJJy32j3Jxzm20BDYMsnkPzvf2qQgirI
	g==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Tunnel types VXLAN/VXLAN_GPE/GENEVE are supported for txgbe devices. The
hardware supports to set only one port for each tunnel type.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 36 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  3 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 6d9134a3ce4d..83017cb0ff3a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/etherdevice.h>
 #include <linux/phylink.h>
+#include <net/udp_tunnel.h>
 #include <net/ip.h>
 #include <linux/if_vlan.h>
 
@@ -537,6 +538,39 @@ void txgbe_do_reset(struct net_device *netdev)
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
@@ -632,6 +666,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	wx->driver_name = txgbe_driver_name;
 	txgbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &txgbe_netdev_ops;
+	netdev->udp_tunnel_nic_info = &txgbe_udp_tunnels;
 
 	/* setup the private structure */
 	err = txgbe_sw_init(wx);
@@ -677,6 +712,7 @@ static int txgbe_probe(struct pci_dev *pdev,
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


