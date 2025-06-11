Return-Path: <netdev+bounces-196465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622F4AD4E98
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EB03A8154
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8E523E25B;
	Wed, 11 Jun 2025 08:37:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E38243370
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631062; cv=none; b=kpL8PuXBHUrZBXcQj1JpeXU9Y6secFvv+Ed+fGi9f8o4n13ie3B6QVxl9rTYcr9CGiQ9ZPn7amdt7+flvFOCTZ671fLjgAxJkaJ9TqsY8aQr2nbid+58BTKCu7GSAAqGbmp+MUvGjLzqjq3dPIp7daLlh/IQU5PURuytcz/yIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631062; c=relaxed/simple;
	bh=VH6LcZQ87oA13NTtcuK4mzyH2jos9CoDOOQZGpUnUiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xkrbgnw7KLfAfKH3CEUNWPekwmkomeGIzJSN6NOSbIZDHfLFQGyaPsXS+FmEztdufueufG3Gczew6G+netKG8GALAUpfVsufjla7uqRfZJgzzp6d2LRYFUhDnYjn90MCsdkvLg2/S5APoMIOFMEynrtDaURY4Ho5O5xmmy6jgZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1749630987tac3954a3
X-QQ-Originating-IP: 8dsxyq44S7zM4g3s7j4ep/DwTOllQqfneftFCLdXjeI=
Received: from localhost.localdomain ( [36.20.60.58])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 16:36:26 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10097942522635946619
EX-QQ-RecipientCnt: 9
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 10/12] net: ngbevf: add sw init pci info and reset hardware
Date: Wed, 11 Jun 2025 16:35:57 +0800
Message-Id: <20250611083559.14175-11-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250611083559.14175-1-mengyuanlou@net-swift.com>
References: <20250611083559.14175-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NvIr6BtGSx+/kOHSnyZ2+gakUP10bTtoA3fOXWEKMYO0EtPdQAo1NYW9
	4Ls2pZ5sFDkOv6K+qR9Nd2aYYvAdNyDZLGkFvqhM29g/yMn5IBbRmoIpNSO9bR6I4UnoV5W
	QGZBVm7rnzfDUhTrVwogMJg9jOaYb4vBrHO7yVk9u2xCoUOfKsIuYmt1mzqSLXEUVyuDCN6
	dwAZJWAV3OOG97ewoaNrAlhWKNsCfeLn0hFxIRyzYN6v7zTqiyxZqr9KHCy5GDBs3GcJjHr
	WkNpZ/WwiGVfehdAPaZfRoOhBQNHvxZDCk9phCIyVXJA7h9WqEjtMao92QFpWpC56wAlYjV
	RCx9drFV14rbgaqsMhZQ+Vpe2hV6w7sJLvtpnR5dgsMJXyN4aoPxnxV8mYsrPZEkBgIcsf6
	4BTRQMuHtwvonuaZGiQ+tG3Y494SV23hgkXNBChT64ZIwK/jsPQtZgTShgeU0GLKvltNs2k
	2exE9bfX34yMAM6sHCPtkmLCzNexzh0E2rVg4twCivhDYNZOhWPKH5RXPapyGtDrHBGIqA7
	j1vdqzxsq8TC+wETfzN/8OAhtxdV1sqlPWfYfOlGvEqoAcAQJbe0qpQ1Ubqsi7GRBUxn9fL
	KTLgbSxjed7neH42h0KzideXhOdjhrrmMKdK7tFRnw7WFOyk5Ygg6/w9lLn0Z5ym27T9BDN
	zrpK2ocC2X+hjjJv8xWvwPfbvs/zi36m3W/SmZ+QfWqnFe8BbC22PCZNAOY70Xj7phHOAqr
	Lspeyq/6sDWo20FPuNTrZ58XpyM8Eu7nNN80D0o7Nd5M5uVXYPHQLcEM1munePrQr22Zeb6
	KOoNaZcDbl/mmn4jFkJe40UfNeviH7cUw4bUiPmpVz2LIzWaHnIlUABfoxx33LZwRUNBPzl
	uZpvuVzKe9Ka6ZcBWbZLKlP5H99i0u/RnLQL6Fx6CyN/1NRvnvscjK+l9bC9UxTX+oKPK8P
	HbR6EzdcjxHzbqxl1V2/g1CjepjCGH0w+FIjF4Xcl7AQAGtE05Dq/ixhFlB77r8LOKDv2G6
	Wx6RFhR3OlFff9WrXR/Bl4OPsvefKjkuTh0aUarKS/aiNBX1gFDanNRYFm8q0bujrjjpoQ7
	Sjacx9baYYLbeNW/2pvKXuEzyNtHPiaw/mAgLMvABiKfDREZduUzE4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Do sw init and reset hw for ngbevf virtual functions, then
register netdev.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c | 91 +++++++++++++++++++
 .../net/ethernet/wangxun/ngbevf/ngbevf_type.h |  4 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index 77025e7deeeb..4eea682f024b 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -9,6 +9,9 @@
 #include <linux/etherdevice.h>
 
 #include "../libwx/wx_type.h"
+#include "../libwx/wx_hw.h"
+#include "../libwx/wx_mbx.h"
+#include "../libwx/wx_vf.h"
 #include "../libwx/wx_vf_common.h"
 #include "ngbevf_type.h"
 
@@ -37,6 +40,75 @@ static const struct pci_device_id ngbevf_pci_tbl[] = {
 	{ .device = 0 }
 };
 
+static const struct net_device_ops ngbevf_netdev_ops = {
+	.ndo_open               = wxvf_open,
+	.ndo_stop               = wxvf_close,
+	.ndo_validate_addr      = eth_validate_addr,
+	.ndo_set_mac_address    = wx_set_mac_vf,
+};
+
+static int ngbevf_sw_init(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	struct pci_dev *pdev = wx->pdev;
+	int err;
+
+	/* Initialize pcie info and common capability flags */
+	err = wx_sw_init(wx);
+	if (err < 0)
+		goto err_wx_sw_init;
+
+	/* Initialize the mailbox */
+	err = wx_init_mbx_params_vf(wx);
+	if (err)
+		goto err_init_mbx_params;
+
+	/* Initialize the device type */
+	wx->mac.type = wx_mac_em;
+	/* lock to protect mailbox accesses */
+	spin_lock_init(&wx->mbx.mbx_lock);
+
+	err = wx_reset_hw_vf(wx);
+	if (err) {
+		wx_err(wx, "PF still in reset state. Is the PF interface up?\n");
+		goto err_reset_hw;
+	}
+	wx_init_hw_vf(wx);
+	wx_negotiate_api_vf(wx);
+	if (is_zero_ether_addr(wx->mac.addr))
+		dev_info(&pdev->dev,
+			 "MAC address not assigned by administrator.\n");
+	eth_hw_addr_set(netdev, wx->mac.addr);
+
+	if (!is_valid_ether_addr(netdev->dev_addr)) {
+		dev_info(&pdev->dev, "Assigning random MAC address\n");
+		eth_hw_addr_random(netdev);
+		ether_addr_copy(wx->mac.addr, netdev->dev_addr);
+		ether_addr_copy(wx->mac.perm_addr, netdev->dev_addr);
+	}
+
+	wx->mac.max_tx_queues = NGBEVF_MAX_TX_QUEUES;
+	wx->mac.max_rx_queues = NGBEVF_MAX_RX_QUEUES;
+	/* Enable dynamic interrupt throttling rates */
+	wx->rx_itr_setting = 1;
+	wx->tx_itr_setting = 1;
+	/* set default ring sizes */
+	wx->tx_ring_count = NGBEVF_DEFAULT_TXD;
+	wx->rx_ring_count = NGBEVF_DEFAULT_RXD;
+	/* set default work limits */
+	wx->tx_work_limit = NGBEVF_DEFAULT_TX_WORK;
+	wx->rx_work_limit = NGBEVF_DEFAULT_RX_WORK;
+
+	return 0;
+err_reset_hw:
+	kfree(wx->vfinfo);
+err_init_mbx_params:
+	kfree(wx->rss_key);
+	kfree(wx->mac_table);
+err_wx_sw_init:
+	return err;
+}
+
 /**
  * ngbevf_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -102,11 +174,30 @@ static int ngbevf_probe(struct pci_dev *pdev,
 		goto err_pci_release_regions;
 	}
 
+	netdev->netdev_ops = &ngbevf_netdev_ops;
+
+	/* setup the private structure */
+	err = ngbevf_sw_init(wx);
+	if (err)
+		goto err_pci_release_regions;
+
 	netdev->features |= NETIF_F_HIGHDMA;
+
+	eth_hw_addr_set(netdev, wx->mac.perm_addr);
+	ether_addr_copy(netdev->perm_addr, wx->mac.addr);
+
+	err = register_netdev(netdev);
+	if (err)
+		goto err_register;
+
 	pci_set_drvdata(pdev, wx);
 
 	return 0;
 
+err_register:
+	kfree(wx->vfinfo);
+	kfree(wx->rss_key);
+	kfree(wx->mac_table);
 err_pci_release_regions:
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
index c71a244ec6b9..dc29349304f1 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
@@ -20,5 +20,9 @@
 
 #define NGBEVF_MAX_RX_QUEUES                  1
 #define NGBEVF_MAX_TX_QUEUES                  1
+#define NGBEVF_DEFAULT_TXD                    128
+#define NGBEVF_DEFAULT_RXD                    128
+#define NGBEVF_DEFAULT_TX_WORK                256
+#define NGBEVF_DEFAULT_RX_WORK                256
 
 #endif /* _NGBEVF_TYPE_H_ */
-- 
2.30.1


