Return-Path: <netdev+bounces-204117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F447AF8F2D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72E64A06A9
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0682F1FCC;
	Fri,  4 Jul 2025 09:51:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB72EF9DA
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622713; cv=none; b=BTqvQFQ6+X2TFCf70GhtgvKGBRfcW3gcYgLMiCt0/oav0OD+SvrFiO0D0vP95Z7ybcZOBMpdMfDZuKYQYcgymVL+rxsJDQoOoHixAXJUUcbXL4EFfFWU3XfyX7Eo5rI4keBAvvpqRb6D/DrYMLq40wd/uahCO4eD9u5vu5KJepw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622713; c=relaxed/simple;
	bh=VH6LcZQ87oA13NTtcuK4mzyH2jos9CoDOOQZGpUnUiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqnBKbOYpsUzVlSuPQrJgutBLolPLtwJvHFMM4KBRY7TMZRBPh62uJPx4oQ+wygh1912rdJgA6ZqwDcbeYHT37CmPVl5+yKdz7z0NQvMyQfdZA/uzYQlKydxtlxIKCqAH9LkTZrxFd+7YxMh4QjhNhdpq84AS8b1gOEiirf4Wa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1751622648t9fd10a27
X-QQ-Originating-IP: sWU/pnXycx1p18K/+nQ+VBTI/q42jGIXjqStUEtTDBw=
Received: from localhost.localdomain ( [156.146.53.122])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Jul 2025 17:50:43 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17738686573472729539
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
	jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 10/12] net: ngbevf: add sw init pci info and reset hardware
Date: Fri,  4 Jul 2025 17:49:21 +0800
Message-Id: <20250704094923.652-11-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250704094923.652-1-mengyuanlou@net-swift.com>
References: <20250704094923.652-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MRPscMwXVhqxDvnXp+TGEd8Qx92dcfkxyfAQVsc9GeMO9LklnCvjnSm0
	GhhWbOLQWtrJaDdwY6tdVwuiiHWw8/Hr7qAxUejMk/Y+smimsdMjO4PB9z2afZS7h1fsPtC
	MbYgYaCHBT6N2yNjpaz1jAiqtNe0SB2gz7AGsmh/IFR9pGhjxoPzH3P8MeeTt7eHtcpHV8Z
	mJwUeRIeUZMELSTePKVelBbLAPtPFSEvhcsLFpoeQquAC9bH4TXyhifRRg2LWNzPgy4TIh5
	kxHhmJlp6Kfss7RebQKdYyUYxFtsLUO0Agj7o5pS0FmFjGStfJ24Y25DdacNmPjtmFQpCbK
	YqJ3v9kScQcif3GpM8iPxpRW8dJEMGfwyYVRmRHYmDEM7wEXfh8jE7yS9Fzt8SyOwbTyv2S
	3Y5AriV8/bQzx7zHnYShjevA/8OaDt/p8jMhR6gQZ2D5EjGMUwIBW35MFfTjGO/KOihxBQf
	bjogh7UPXczaj7Kfi6ByVxIP48lIm6HoaIyIeJCjKa7XsvE04FvEY/w2BsIKuWQVdjricnj
	pVAOWjQVbjWEhjUkNPw+q+PghTYNCUiLra58Pnmkcs7YUGSVJrkE0NobJ2X5r16ZgHqBy28
	EYI/pDHpyTSxQo/OqkSfP1TUT465yjZOd+2nchs80kng6Azem9eLlf9jL4TNlQd11m+e4hd
	QNZfkd3Llub1Wutpbn5nrnrRk7DnQaM5a8b2oOCky6WRpRAmWNcqJ7bHMOOph7B8Zj0JjCk
	/DlR34fDJ7A91iqYBgiN6z85LcC6QvcHhbsS2SoM4CLg5Cg7oIN6i1zWDIiGPVrJ3YwV4f8
	l4vIHOLr57ZNhTycnUHB7LrqReqe+0SBy7M3vJtyzgUtMaiFHJ9PEsaQh0+i5g8xFT2wnDL
	qp/fp09u+ldPdcYzMVNlf5taEt5HTPXhhNOXXxlihGedta8ambuISYAQ+wbhFdU+dfHV3G7
	d0fsNZ7WZSMTWGQZO1VM/fgwoV7FfjRLjVUKDoptUgehF+RW3pYHQYYVT0vNhdvJxoYUJkj
	iEkZok35T52aPKNvkLWFmX9iJZDZmormeXBCR5KAzaZK5s5EjJRohzOL6nBFy0EkKdyF4ZO
	K/B0TIf2ZOfUyIaOh61A3f1LBqilJcAqEmZQgFfJS77nIiPboYPwFY=
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


