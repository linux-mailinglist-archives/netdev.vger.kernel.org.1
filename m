Return-Path: <netdev+bounces-169102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F777A42983
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7277D188D1DB
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5181E264A6D;
	Mon, 24 Feb 2025 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="J4bi1/if"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-37.ptr.blmpb.com (va-2-37.ptr.blmpb.com [209.127.231.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA5F265609
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417888; cv=none; b=vBE7Fu9pCMhphElBFAphKDH0VTTCzNKAL5qPTREwVy6dqrZLG65aXaLMswV59FDCDHMy7uMo/KXX6KuuqZ4Bm6At+KlaDI/qfzhLddRdIUB2qDkAfO3Vpqicl3Tr2M2IjBWKUH9AJDRSCU4AkhmtIo3QpTDbOTjV0tSkMR75hRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417888; c=relaxed/simple;
	bh=5uY+kvIT85UGVh6ElEeO1LULy+xaAUawOsTNJDAIoqA=;
	h=To:Subject:From:Date:Message-Id:Mime-Version:In-Reply-To:Cc:
	 Content-Type:References; b=o1z/qjUHOyUHudUnCQ/w6YWNnF42wMh5cGdaWsj5dUnSWTXyK6y4uIHG+0u5intOEGJmctlxKxYfSdq/qG2K7bIbseG5mQ9i/nfZrUAwiZxzTPTCdyWLpblsY1oG6dQjGvgZkdf/FmyoxP9yyBja2tM4PwLkCxBQQvhbaMCUT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=J4bi1/if; arc=none smtp.client-ip=209.127.231.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740417875; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=m39T5dA573KDvecKGhEC+Ej38N1ikwbRr1YncP+Z/zg=;
 b=J4bi1/ifmFfO4M9IpC5xHuifeCOAKTz5clehnJkK9GspMfoiqskc5Y9wq0ngCNYCah5Pa4
 kVfIGlfAohlxSTDJXjWVi77gSUHsGQjhcno1OUnrZU8aVQTruptNu/6BPxmlG1E1xgSANy
 1cisOcZ0zMNEbbsqTr8K7Dy1mjAdODIeXxvCUH5myiezs6fwTmoEukibsGshnev+azgYsd
 U9qNGF6YoovuT7ZxgzCMAysBurihjnhEFPRV2SAQK/1xY+o3G086oULovqEnTbH1ZxlCAk
 HFDdQUWp+RVEfHUo10XpDzsr4TvVDE3I1KWGGlTOCz8YP3B/4RClPmFZvdgbsQ==
To: <netdev@vger.kernel.org>
Subject: [PATCH net-next v5 08/14] xsc: Add ethernet interface
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.25.1
X-Original-From: Xin Tian <tianx@yunsilicon.com>
From: "Xin Tian" <tianx@yunsilicon.com>
Date: Tue, 25 Feb 2025 01:24:33 +0800
Message-Id: <20250224172432.2455751-9-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20250224172416.2455751-1-tianx@yunsilicon.com>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
References: <20250224172416.2455751-1-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267bcab52+75d4b2+vger.kernel.org+tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Tue, 25 Feb 2025 01:24:33 +0800

Implement an auxiliary driver for ethernet and initialize the
netdevice simply.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 drivers/net/ethernet/yunsilicon/Makefile      |   2 +-
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 100 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |  16 +++
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  15 +++
 4 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/main.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h

diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethernet/yunsilicon/Makefile
index 6fc8259a7..65b9a6265 100644
--- a/drivers/net/ethernet/yunsilicon/Makefile
+++ b/drivers/net/ethernet/yunsilicon/Makefile
@@ -4,5 +4,5 @@
 # Makefile for the Yunsilicon device drivers.
 #
 
-# obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
+obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc/pci/
\ No newline at end of file
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
new file mode 100644
index 000000000..da309dc63
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/auxiliary_bus.h>
+
+#include "common/xsc_core.h"
+#include "xsc_eth_common.h"
+#include "xsc_eth.h"
+
+static int xsc_get_max_num_channels(struct xsc_core_device *xdev)
+{
+	return min_t(int, xdev->dev_res->eq_table.num_comp_vectors,
+		     XSC_ETH_MAX_NUM_CHANNELS);
+}
+
+static int xsc_eth_probe(struct auxiliary_device *adev,
+			 const struct auxiliary_device_id *adev_id)
+{
+	struct xsc_adev *xsc_adev = container_of(adev, struct xsc_adev, adev);
+	struct xsc_core_device *xdev = xsc_adev->xdev;
+	struct xsc_adapter *adapter;
+	struct net_device *netdev;
+	int num_chl, num_tc;
+	int err;
+
+	num_chl = xsc_get_max_num_channels(xdev);
+	num_tc = xdev->caps.max_tc;
+
+	netdev = alloc_etherdev_mqs(sizeof(struct xsc_adapter),
+				    num_chl * num_tc, num_chl);
+	if (!netdev) {
+		pr_err("alloc_etherdev_mqs failed, txq=%d, rxq=%d\n",
+		       (num_chl * num_tc), num_chl);
+		return -ENOMEM;
+	}
+
+	netdev->dev.parent = &xdev->pdev->dev;
+	adapter = netdev_priv(netdev);
+	adapter->netdev = netdev;
+	adapter->pdev = xdev->pdev;
+	adapter->dev = &adapter->pdev->dev;
+	adapter->xdev = xdev;
+	xdev->eth_priv = adapter;
+
+	err = register_netdev(netdev);
+	if (err) {
+		netdev_err(netdev, "register_netdev failed, err=%d\n", err);
+		goto err_free_netdev;
+	}
+
+	return 0;
+
+err_free_netdev:
+	free_netdev(netdev);
+
+	return err;
+}
+
+static void xsc_eth_remove(struct auxiliary_device *adev)
+{
+	struct xsc_adev *xsc_adev = container_of(adev, struct xsc_adev, adev);
+	struct xsc_core_device *xdev = xsc_adev->xdev;
+	struct xsc_adapter *adapter;
+
+	if (!xdev)
+		return;
+
+	adapter = xdev->eth_priv;
+	if (!adapter) {
+		netdev_err(adapter->netdev, "failed! adapter is null\n");
+		return;
+	}
+
+	unregister_netdev(adapter->netdev);
+
+	free_netdev(adapter->netdev);
+
+	xdev->eth_priv = NULL;
+}
+
+static const struct auxiliary_device_id xsc_eth_id_table[] = {
+	{ .name = XSC_PCI_DRV_NAME "." XSC_ETH_ADEV_NAME },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, xsc_eth_id_table);
+
+static struct auxiliary_driver xsc_eth_driver = {
+	.name = "eth",
+	.probe = xsc_eth_probe,
+	.remove = xsc_eth_remove,
+	.id_table = xsc_eth_id_table,
+};
+module_auxiliary_driver(xsc_eth_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Yunsilicon XSC ethernet driver");
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
new file mode 100644
index 000000000..0c70c0d59
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_ETH_H
+#define __XSC_ETH_H
+
+struct xsc_adapter {
+	struct net_device	*netdev;
+	struct pci_dev		*pdev;
+	struct device		*dev;
+	struct xsc_core_device	*xdev;
+};
+
+#endif /* __XSC_ETH_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
new file mode 100644
index 000000000..b5640f05d
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_ETH_COMMON_H
+#define __XSC_ETH_COMMON_H
+
+#define XSC_LOG_INDIR_RQT_SIZE		0x8
+
+#define XSC_INDIR_RQT_SIZE		BIT(XSC_LOG_INDIR_RQT_SIZE)
+#define XSC_ETH_MIN_NUM_CHANNELS	2
+#define XSC_ETH_MAX_NUM_CHANNELS	XSC_INDIR_RQT_SIZE
+
+#endif
-- 
2.18.4

