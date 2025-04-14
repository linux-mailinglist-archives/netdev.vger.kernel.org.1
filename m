Return-Path: <netdev+bounces-182072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C7AA87AE7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A421889320
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B9D25DD0A;
	Mon, 14 Apr 2025 08:45:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61AD3C38
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620346; cv=none; b=W3eNWrIIemmz8PRnOVekOKNmWMIWOcxy1K8vNCp3GPnLcHhFA92WNj0p1Yq9BWAWTxhhgv6YqdpjG+393RHJpGU6+QZisdXDCkrOuOKGXidtHIHVzvWOqjs0iA1r/qG+8HHCHpx2dvTpD5Du1FPD6al678zT+7SLk130XHwxYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620346; c=relaxed/simple;
	bh=yB//rNiLv0ecrqI5VIiNxGEGgHVwVKfEe4oTEVbuOfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jqWll/+iG8e05aE1oP+Bkn8Bjh4U/JLVF0UlFa3W9K7iTI19jiTJIszSuopRPFvtvIvcZ5ZG1lllRG4fGkXrkIOdQJybWu+5F7QdHVVMQH8yJn85KNuKZ14xV2zjCFBkbkNTBX0Ji5BncN1FZI4yHHq5qX1YPU+XuIv8JYQviFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: izesmtp25t1744620292t0c1d936e
X-QQ-Originating-IP: yunRm6z3II1WSqleitv5z2P7ZYZfHOfk5OBnfSIjr7Q=
Received: from wxdbg.localdomain.com ( [36.20.107.143])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Apr 2025 16:44:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13069655186606783888
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
Subject: [PATCH net-next v2 1/2] net: txgbe: Support to set UDP tunnel port
Date: Mon, 14 Apr 2025 17:10:21 +0800
Message-Id: <20250414091022.383328-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250414091022.383328-1-jiawenwu@trustnetic.com>
References: <20250414091022.383328-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NHHBtKpbeb7pnSHuKUKQkFzFGUm5YsAYbJi7myWfbpi8dXyIiD/JCsR3
	6hNF0wPpjKdL8b/LmmTUUFw2w3mup0Oa3H4NMe3bnwjb2ganZkgvPE1pw8xCaPIfi2CUU0H
	6gzreqy4/lWYdswcF+nMABjXQ4a1g25P+hXe2g16LZ7lq+RlPxJdtkruwxjbcQueS0tvCE2
	Lm5ny27ppELHvK697Ttv0Y1Y33MhhOwa/FepB4YDYGxJy0xwNXr8VmE6i6R1fVnOparfwBW
	Xw84KaZP9vi2u+YqJssgZU3TAXxDT6QDqP1ACW7apyL+gEry2lZmbHiLBmLk8DgjN2wlWAR
	jWr8ztKQJ5WAO9sjFlcChoYl+fatkXv6rkq3MHt5A0iRLW4Rm3Ai0FDnkcHlKPCLRh0NgHI
	8owY2BGBMclngYv4TbTyKg/aVGkSMLnhDRG/U99esFp1uCJby4TzPYeHuneSjTs5MIJO79C
	BBa7Rr3a5IxYmWf2CZjCNiVjom9RoLpyHwqh1VSadrOdsylUqZJ0xXyqHLF/Se4/sH+yA1W
	q5nIowhdnBbHhXdMc2PEdPReNF+gEK/Z+uFpAnEDsxKsRHXZCbej1lzKp758q+3+ZqFfPAJ
	mflnKypKMAvBdpGOXUDVECAUnhC12ZIO8TSkH3gNuNvTtSIElYZVx4oRMBSpGaTGJ8BJLUd
	IgfE/fhAsTwDt6115uTuzvJ23n6h42MXicknfveusJknxJQ3h8qY1syMimNwGE5CuRbUFKd
	3iSJk0PBO40vMg07NI7EWZ2lSFSUn+xYlFcflrtGDML2IlZWvqC2LTcRchwcwl7qxmIFar7
	ro//tRBouYu0E0udKYgl7B0CntSJEymic5gTYfRgwDk9cx5Z1v592Ltc/4Td7SmuG0DFR86
	HD3NH1EVpXZhPVNqFzJwMlGCh2w8IfSThAGpo67rlqcigLb0peX2zowQr1hVgxGCV+GbZgt
	TbQIO6QF6WUW0EwjF0yP2+SInige05wwSydgz1z/t73y3BswXSC5rSI4PW5oXoFH89pE=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Tunnel types VXLAN/VXLAN_GPE/GENEVE are supported for txgbe devices. The
hardware supports to set only one port for each tunnel type.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 86 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  8 ++
 2 files changed, 94 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 6d9134a3ce4d..c3b0f15099db 100644
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
@@ -537,6 +540,87 @@ void txgbe_do_reset(struct net_device *netdev)
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
+		break;
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
+	if (ti->type == UDP_TUNNEL_TYPE_VXLAN)
+		txgbe->vxlan_port = 0;
+	else if (ti->type == UDP_TUNNEL_TYPE_VXLAN_GPE)
+		txgbe->vxlan_gpe_port = 0;
+	else
+		txgbe->geneve_port = 0;
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
@@ -632,6 +716,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	wx->driver_name = txgbe_driver_name;
 	txgbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &txgbe_netdev_ops;
+	netdev->udp_tunnel_nic_info = &txgbe_udp_tunnels;
 
 	/* setup the private structure */
 	err = txgbe_sw_init(wx);
@@ -677,6 +762,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_HIGHDMA;
 	netdev->hw_features |= NETIF_F_GRO;
 	netdev->features |= NETIF_F_GRO;
+	netdev->features |= NETIF_F_RX_UDP_TUNNEL_PORT;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 5937cbc6bd05..7923adb9ac73 100644
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
+	__be16 vxlan_gpe_port;
+	__be16 geneve_port;
 };
 
 #endif /* _TXGBE_TYPE_H_ */
-- 
2.27.0


