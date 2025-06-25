Return-Path: <netdev+bounces-201059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C7AE7F06
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1DB3A9CA3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCF029E0F2;
	Wed, 25 Jun 2025 10:22:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D2D29B76F
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846926; cv=none; b=OAVT0lh44UjFAppxK445kUxt6LjlIs57LuCWsUoUj/PdGbK6OXudhGV9kvcDT/7xfKAXn65wubPNaP7fJmKY51JKi4eJfarikoWbMk7iuqpakUFlkgPRKYJ+Sj8rRUG6A5G5Qg24nfiF+nxCSX+N7g03P/k3uT3Hsrpnva2rVNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846926; c=relaxed/simple;
	bh=5TwA8Gm8MbzLVwxSbWHAQrlHXc2RS2nAAEdOnwIu25M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFHjMWZ6GHcYdhbLCNBtRtxrEXiUpdxhofWSs7rAj96OZSvO9Qgzu1zIRaiKazsJnbztGTCW3YRIR2tGldni4Iufn/oB3rvFpKlWuKsqmmjcch4Pdmu2Hfyd4kg1GfDUIOUzAbKLQJq0H3664zwtj5I+bhq+EYIOubntblhStD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz13t1750846874t257952d0
X-QQ-Originating-IP: YvB7gFbTQZ0uiCo6uVteohF96CB4iBlx+bARIcNrz1s=
Received: from localhost.localdomain ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Jun 2025 18:21:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 841510032352028657
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
Subject: [PATCH net-next v2 05/12] net: txgbevf: add sw init pci info and reset hardware
Date: Wed, 25 Jun 2025 18:20:51 +0800
Message-Id: <20250625102058.19898-6-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: NnHTGy90yJ80nZjT4UkVlmFqNvaBNKjlgRGAi5N5mSxamkhpaikgNCMD
	9KI/10gwI+egaDFv68MQ0jgg/8yu6vcOg2cg5/1hLhkmXeQ+t/xCH6+Dm303fSGouzsAco+
	4nlEf+yguuH7b22D6PvVuYUO7CmuweCb2KriC/hKKftQfB/ny8JE8sydDrDxvUIzcdpubMI
	X0gbuuuaKb/9sjazrfpajs5xWcFSYIozzcvy/f069p0lmQ5YvzgkJPsh+0Fxq9Jh//fVTQp
	HZiQtn5lQMhrsN5Ba3OmjfzWc5YcDKJs+MOCTFUSj+aEkV/k7IzmtU3YEPaHOXHXMuhynBZ
	6m9NVOuCAtk3KFN51ssFMjnfqDcnYTLIOAlC0eP0LQlp3UaBfUEEp8+kDweRHRHZPCbdy8O
	2pnPwuvwCR7yRTbhBVQkzDT0w0yhsiksPxSEJ18z1Pd8ER/H+RHSN8Yc1O2eBVI/7IalTtt
	mivu4ng9p+1VlCM7E97m8VQhogzHbXtRRYiVKeF5gxis2L7tPYBlnKm8mIx0B3OTGtgdFRP
	fFPXvwbXqWhP9ZVjdJ+ZWGf8LOpefwabl073EPSuWPCqaM6ic8RoRvae4Y2pM3sJ6EsFYYs
	yCNsipRhG3pHr0XFlECd3ZOu8fYv7o1BH2UpFCADUWWHtXMJC4fXKikmfu6zJvmYU5E6vSN
	mOq+XqYcbIXN/jGbARdjZijnoEZXCwtlu+OeyhsDOrXggXgoEWz2DMWSQqjM20m7TqnROW1
	sVzNHmJOkiI8HGMBwJzuhp4PmMS4xI8jYAOv9u3BsL1CsJuBEAEBg2ZGGKtQisV4UyXPJ/g
	lOUG+dNTna6l8d6ja+5ONqL+fwN7UYbV3pq/NNW0vK8OiD5oNLW5gJwigdzC8yUwjBT4QHt
	5uqe9l0EEh9Anl7RRuo3/pYy8kTKQL3JV7Bd4HqtXHNsaEl3geolVzWN+J1fiwcTm/mp6yM
	9sG1BSJVcIST04lUhUQu58w7izhVd5bp3LE1av4Spx35aBMuGn67W2fg4L/bVdn/7Jo+PDC
	PspQg/A/KLFHzrIkO7D4KMnQcSagpiZHGz72anDKdl+UzVMSTw/l62UQkh3EGysCjDpwngV
	qiAzFW81Z3ydk8d5f38MyD5fUkXHkee6A==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
index e317ca3afded..6714c0b88509 100644
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
@@ -231,3 +239,27 @@ int wx_set_mac_vf(struct net_device *netdev, void *p)
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


