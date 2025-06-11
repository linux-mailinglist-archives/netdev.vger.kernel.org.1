Return-Path: <netdev+bounces-196454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40325AD4E87
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386DC1BC0C5E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097EF23C8C9;
	Wed, 11 Jun 2025 08:36:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D07A2309B6
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631016; cv=none; b=BJOpRKhZQHtoynCkYaDfjf7XS/liaz6EMhwfd2Bi76kN00I4jdgi6Ku5gxedu8jQizJuCoYkC8Fvi7dov6ydjv2tjk+i0FiIn4eG2JTfbcVh1bvan+Thn6KFbGYYJvNTdKehbprNSM4I1WgXSr3db8mg+WH5fgkp42NuR6crPmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631016; c=relaxed/simple;
	bh=pBTxogemTtCQ7K/6Iw3KEzjKNyFBzW6VMn0fHtMbJzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9a4odSvZlDqBwN3WwMAG9rTungShmVjmuz1BGpn3hT74ASoWVxmJ0OZFuCslF5zOsLu6qAupH1nG9vRNfzVOaOW1VNzKY1bZq4g4wBnI+gKRrVb5BmyEkT2wS20eWv1W/67lqo7JaqqibJW3lW/MOd9XcQc82Hmd+hTf/PeLzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1749630976t2635fab0
X-QQ-Originating-IP: Y/k0kVagGLMdZ+cuj9fP7l1NHVg0eHXdBIqB6eW1eKk=
Received: from localhost.localdomain ( [36.20.60.58])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 16:36:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 255318855100585078
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
Subject: [PATCH net-next 05/12] net: txgbevf: add sw init pci info and reset hardware
Date: Wed, 11 Jun 2025 16:35:52 +0800
Message-Id: <20250611083559.14175-6-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: MH0b2UY04H/eZaUu+JMCFGagFWg4T3Q1Wr2kLHsH3//Y6TuBTObgf2O9
	p+zK0U5qMgQjw3DLZSTadsXqT6ImT+2uKvS4OvTwsVXtQl+axRihQsM38e4VIdZ8mbnotWn
	KV8yUexQt2PDoDlrnsNeG92KffSoQOiczAcgfFWjpyKNLR5MNpwix6oS0+IUciwufd/p4hB
	rA2VB2LOfMS6KG4dr3U+zxkm9qjdpXydjrOpXmi76O9cakXSN03DuhcBqazjNKZ4R37ul11
	dpqOJ/I6JGOFm9nMc7uoalkbLn73AuYdjz6MGegGBx+jv8+p6EuLU/VnQYZwTRnhX807x1w
	zf1dQj9uiUS7KyqKkRHnjzfX9Ctr7v1iWOpeAwu/aIrh15ArofIkSUH2QW9Ub0vn9UNMjZ6
	w3Fthv15sGOF3WLO2InnpVHxhiBvepG0ssUo/O348HuSDnUtF8z8gb11ax0hOqtXXcAukOD
	zD91NCcqNWktzGrfjoTnMQgQjJ5ilL76gVILG6pZ7eSZTbdgkjxjK/cnPqjKhU4Cp45Tlc2
	qvzTNnTV8cYi148YLcIVTWpWZmOIgwFC1i4yWDKgp+n+vD/TsnmHLbjUC4bxWF5XY+8kh+K
	N7HzhAE+Iit+XvBPDWBeiduqbdlL1QtikWeym1/Cdr/zjPaw5I5z1E5XPwYt3RwcEYTAJog
	tdc81Z+l5Uqds+Q/8bkTlCe/PIzNh5XwaDPthtqM0uiwTzNHWq1Hy302HsYFQDd8+1hZLSl
	i05yObG646kxFV2B2ZN56T0Lmgw43mUHVb28JfntaD5v2aNs56RSTK5ESEmm2m+UF0FzT/M
	1icfvmIAiEf7NUmIwBGK9kBsfk0Oi+e5L+4izGeH64MYT3LMALqweL7X2h6dXAIN3zAbx4L
	lVp6tDAFnfogmjKd7k/TjxZmnuHUo6RMe+CkEGtrN4s3Bxrel+d4SrHLptJZmdcMoZ1He2t
	3GNKunryzaKy+Q1fkzjxlao5bzpYUJB7Fx6dv2pmuL4A7FT9KHFt0SaapI/54ze06ys3o2g
	/by5DB7C0y8GUKEYMiCSSee/cJk/qEdDfbvNcwbNqsq276iJAbXKkdtpefBhds/yBuW9bVC
	lupjJ01D6vnszl7nBrYR0eJNyGZyTpwNN7ONoSn/7ZY
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Add sw init and reset hw for txgbevf virtual functions
which initialize basic parameters, and then register netdev.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   3 +-
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  32 +++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |   2 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   | 111 ++++++++++++++++++
 .../ethernet/wangxun/txgbevf/txgbevf_type.h   |   4 +
 5 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 27bb33788701..6e830436a19b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2369,7 +2369,8 @@ int wx_sw_init(struct wx *wx)
 	wx->bus.device = PCI_SLOT(pdev->devfn);
 	wx->bus.func = PCI_FUNC(pdev->devfn);
 
-	if (wx->oem_svid == PCI_VENDOR_ID_WANGXUN) {
+	if (wx->oem_svid == PCI_VENDOR_ID_WANGXUN ||
+	    pdev->is_virtfn) {
 		wx->subsystem_vendor_id = pdev->subsystem_vendor;
 		wx->subsystem_device_id = pdev->subsystem_device;
 	} else {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 6619a7abd1d8..88e9ceeeecb9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -43,6 +43,14 @@ EXPORT_SYMBOL(wxvf_resume);
 
 void wxvf_remove(struct pci_dev *pdev)
 {
+	struct wx *wx = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+
+	netdev = wx->netdev;
+	unregister_netdev(netdev);
+	kfree(wx->vfinfo);
+	kfree(wx->rss_key);
+	kfree(wx->mac_table);
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
 	pci_disable_device(pdev);
@@ -230,3 +238,27 @@ int wx_set_mac_vf(struct net_device *netdev, void *p)
 	return 0;
 }
 EXPORT_SYMBOL(wx_set_mac_vf);
+
+int wxvf_open(struct net_device *netdev)
+{
+	return 0;
+}
+EXPORT_SYMBOL(wxvf_open);
+
+static void wxvf_down(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+
+	netif_tx_disable(netdev);
+	wx_reset_vf(wx);
+}
+
+int wxvf_close(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	wxvf_down(wx);
+
+	return 0;
+}
+EXPORT_SYMBOL(wxvf_close);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
index f3b31f33407b..272743a3c878 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
@@ -14,5 +14,7 @@ void wx_reset_vf(struct wx *wx);
 void wx_set_rx_mode_vf(struct net_device *netdev);
 void wx_configure_vf(struct wx *wx);
 int wx_set_mac_vf(struct net_device *netdev, void *p);
+int wxvf_open(struct net_device *netdev);
+int wxvf_close(struct net_device *netdev);
 
 #endif /* _WX_VF_COMMON_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 9e8ddec36913..9918d5b2ee57 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -9,6 +9,9 @@
 #include <linux/etherdevice.h>
 
 #include "../libwx/wx_type.h"
+#include "../libwx/wx_hw.h"
+#include "../libwx/wx_mbx.h"
+#include "../libwx/wx_vf.h"
 #include "../libwx/wx_vf_common.h"
 #include "txgbevf_type.h"
 
@@ -33,6 +36,96 @@ static const struct pci_device_id txgbevf_pci_tbl[] = {
 	{ .device = 0 }
 };
 
+static const struct net_device_ops txgbevf_netdev_ops = {
+	.ndo_open               = wxvf_open,
+	.ndo_stop               = wxvf_close,
+	.ndo_validate_addr      = eth_validate_addr,
+	.ndo_set_mac_address    = wx_set_mac_vf,
+};
+
+static void txgbevf_init_type_code(struct wx *wx)
+{
+	switch (wx->device_id) {
+	case TXGBEVF_DEV_ID_SP1000:
+	case TXGBEVF_DEV_ID_WX1820:
+		wx->mac.type = wx_mac_sp;
+		break;
+	case TXGBEVF_DEV_ID_AML500F:
+	case TXGBEVF_DEV_ID_AML510F:
+	case TXGBEVF_DEV_ID_AML5024:
+	case TXGBEVF_DEV_ID_AML5124:
+	case TXGBEVF_DEV_ID_AML503F:
+	case TXGBEVF_DEV_ID_AML513F:
+		wx->mac.type = wx_mac_aml;
+		break;
+	default:
+		wx->mac.type = wx_mac_unknown;
+		break;
+	}
+}
+
+static int txgbevf_sw_init(struct wx *wx)
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
+	txgbevf_init_type_code(wx);
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
+	wx->mac.max_tx_queues = TXGBEVF_MAX_TX_QUEUES;
+	wx->mac.max_rx_queues = TXGBEVF_MAX_RX_QUEUES;
+	/* Enable dynamic interrupt throttling rates */
+	wx->rx_itr_setting = 1;
+	wx->tx_itr_setting = 1;
+	/* set default ring sizes */
+	wx->tx_ring_count = TXGBEVF_DEFAULT_TXD;
+	wx->rx_ring_count = TXGBEVF_DEFAULT_RXD;
+	/* set default work limits */
+	wx->tx_work_limit = TXGBEVF_DEFAULT_TX_WORK;
+	wx->rx_work_limit = TXGBEVF_DEFAULT_RX_WORK;
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
  * txgbevf_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -106,12 +199,30 @@ static int txgbevf_probe(struct pci_dev *pdev,
 		goto err_pci_release_regions;
 	}
 
+	netdev->netdev_ops = &txgbevf_netdev_ops;
+
+	/* setup the private structure */
+	err = txgbevf_sw_init(wx);
+	if (err)
+		goto err_pci_release_regions;
+
 	netdev->features |= NETIF_F_HIGHDMA;
 
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
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h
index 2ba9d0cb63d5..8f4f08ce06c0 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h
@@ -16,5 +16,9 @@
 
 #define TXGBEVF_MAX_RX_QUEUES                  4
 #define TXGBEVF_MAX_TX_QUEUES                  4
+#define TXGBEVF_DEFAULT_TXD                    128
+#define TXGBEVF_DEFAULT_RXD                    128
+#define TXGBEVF_DEFAULT_TX_WORK                256
+#define TXGBEVF_DEFAULT_RX_WORK                256
 
 #endif /* _TXGBEVF_TYPE_H_ */
-- 
2.30.1


