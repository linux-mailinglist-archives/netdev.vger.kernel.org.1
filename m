Return-Path: <netdev+bounces-201061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3856EAE7F08
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC26171922
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBBE28935E;
	Wed, 25 Jun 2025 10:22:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA22286897
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846933; cv=none; b=cM/vgrAhIXoygrU7iBCE2cJyQqPhnwKJRg6Vr9OHq7XrxRVwgsgi5Y3l6oE7ylsAfA0mWyV5QJuZ1b6wpPygZ7yM4QRtkmPry1ifDpzZeU+SWw1eakjjtX37ebj3B8pIamNA15b3db94vltmxeuA1HNUw+IKvfXoIsbMCJPjjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846933; c=relaxed/simple;
	bh=VH6LcZQ87oA13NTtcuK4mzyH2jos9CoDOOQZGpUnUiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=klnxhnH9WSQxpV1V3YwbQnSUGQERs/VszPFIL5Ed6z8tg9VhceEsPpXP7KluwSjb1dD4K+gkk659vutOsAi+9iagDvDqWmQEmu2PdBLp3AjcZQCbmiIhl37Aueg0NhX/ohaI9tPH0O1decx7/TMly+CCZvChAEfyPE0XAiQhegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz13t1750846885t00a39f4e
X-QQ-Originating-IP: NA2nYOqRmbbllpliqVUnqn6BgWp6CGSumHIgi0pxqy4=
Received: from localhost.localdomain ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Jun 2025 18:21:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18139010080813971888
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 10/12] net: ngbevf: add sw init pci info and reset hardware
Date: Wed, 25 Jun 2025 18:20:56 +0800
Message-Id: <20250625102058.19898-11-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250625102058.19898-1-mengyuanlou@net-swift.com>
References: <20250625102058.19898-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NaX2Th1u2CKrA1TJ790d78m633cyf5DldazG2HogkWK0TwaJBWp50EHY
	uSvBeHBpwBEMQnquyV27HyufJYV4eH2TDMloPUArOArm9YI4DN6gd92NWwLNbB/Tx63N+Oz
	Na7136E3MpzXMvDATdrbG4b02y5CzO7YzwxXItM2s73Eb/dZxCVPI3/fl8luWWPyPyk+m1q
	wh4A+rocsmgXBoeaZ1KY14a3c8/UIvUGDAXFAUXfpQs0Dc+DaHQvCIZNArgRR+yOPTQcy+p
	zJDN1AE3WVvqtuXUov84zmHo6ZVCe709OqoDrI086QWTQOQcX3j2TNa3OZS1gJFSFkdmxaD
	4iGPyB7AVCry+NI75QyAgCERcmBy9Rd8ONc1VmzyVQVx4cojzLdFzyUO6XKu31xk3/BguB2
	B6l1qdUb5v02Hw3c2JFkni+H4Gqx6wz2PyKaDlI7Qx8BCJeC7ARuLCk3wf5L4mQG5FrgNkq
	4bn4TwaEPJxckBhj7If1/3cBQ4Ydbz2d3sUCo66dFnVkyb3Qauh6KWWjLAoW670iDiPFRnI
	La9gDYc1AWCljc9/Pp6BqAAwW4v8hQhTC0p8PoJ9TzmpYKtBNUmm4EG4YEnxZI648ZZ79ak
	ghrMIOIO+/Ts6Q/9kf8DVwx1tXI099VppwrVV1CA0i+3bxNs+vo/3xiWkGBs20snmv07pxm
	IwcnM2R9Wu45Hez401tlzX59izpOl/ZzBDxPP67cLjvPwIF6GaQDf34GplqvYK05HboYypN
	C2ZMh/nWIgQ00Ch41iLmde6YvnPu3+Qom9Lzcot8XqrwuxUaPd0edrfrCJPqd58OORWIceP
	uJJ0L+Fk8VN2urtPXUoXo5p0nwYyiQmufg/5zyFzKBDiq9ua4CBTeUv9vwwBHBxkBECktHY
	WE9xEB5UYiE2KBXoqVlbLZwGOzVvfBESCpMGolS8dhIcO3B6FRjMiORlXRhp9UdmQqjj14E
	YYDqwIrFYPt4zSd+wiSLWA6oQ+RznKjlzVr/fa/4M+x0Rp0hObaZK/aXul5fz4mf9Pjkcln
	PtAr4zKWeJOXgWX36yB6e+gcqpdlG2aZYJqF2nShQJFIxj0Z2Js+IRHC6u1CF8q0ShiENaU
	g==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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


