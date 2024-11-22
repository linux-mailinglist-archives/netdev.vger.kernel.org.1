Return-Path: <netdev+bounces-146753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CADF9D57D2
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 02:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A40B25C90
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 01:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818231F949;
	Fri, 22 Nov 2024 01:47:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396251F94D
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732240070; cv=none; b=ThkxVdqvtFUphozenE56mtzWeXzUu/BDVSjRg1Qt8v1QUs+UvLGKv5OPvjtEc1TauI9VY1i1h7i213Rnzz/btl4NFeC0dl3LwXpA42Alm6tSY0UjnneJbmHJPFDPZDvNNmvj+94EYEqm9Q7Vh6VkGFFDCBve+qzAobxRoSxz7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732240070; c=relaxed/simple;
	bh=UworaByP5DVggPZL/l6utqftZ44MGBAnHkYOurrLFks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IPN69RhmiEAx3um8OKBtMK34Qfj5GNZFCv4oD8pK3ybHtFT1OlT0eFQqEiNLeQc6K4hK9WPissYtFY2KSWCXCihorip2dZt9gWAKkif2jqeBLPjgFrGiaRS/hsQVHhUoOO92j0wsSiRH49l/8RJGnBmqPTrxGluKx1h8piMKeXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 4AM1lhCE021139
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 09:47:43 +0800 (+08)
	(envelope-from catdeo.zhang@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4AM1jj1H009539;
	Fri, 22 Nov 2024 09:45:45 +0800 (+08)
	(envelope-from catdeo.zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XvdF14RRJz2KvmnS;
	Fri, 22 Nov 2024 09:44:21 +0800 (CST)
Received: from zeshkernups02.spreadtrum.com (10.29.35.184) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 22 Nov 2024 09:45:43 +0800
From: Catdeo Zhang <catdeo.zhang@unisoc.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <catdeo.zhang@unisoc.com>,
        <cixi.geng@linux.dev>, <wade.shu@unisoc.com>, <jiawang.yu@unisoc.com>,
        <hehe.li@unisoc.com>
Subject: [PATCH] net/sipa: Spreadtrum IPA driver code
Date: Fri, 22 Nov 2024 09:45:41 +0800
Message-ID: <20241122014541.1234644-1-catdeo.zhang@unisoc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 4AM1jj1H009539

This is a first patch which upload the ipa driver code. IPA is an IP Packet Accelerator developed
by Spreadtrum included in some Socs, which can provide packet filtering, forwarding etc.

Signed-off-by: Catdeo Zhang <catdeo.zhang@unisoc.com>
---
 drivers/net/Kconfig           |   2 +
 drivers/net/Makefile          |   1 +
 drivers/net/sipa/Kconfig      |  16 ++
 drivers/net/sipa/Makefile     |   6 +
 drivers/net/sipa/sipa_core.c  | 345 ++++++++++++++++++++++++++++++++++
 drivers/net/sipa/sipa_priv.h  | 177 +++++++++++++++++
 include/linux/soc/sprd/sipa.h |  86 +++++++++
 7 files changed, 633 insertions(+)
 create mode 100644 drivers/net/sipa/Kconfig
 create mode 100644 drivers/net/sipa/Makefile
 create mode 100644 drivers/net/sipa/sipa_core.c
 create mode 100644 drivers/net/sipa/sipa_priv.h
 create mode 100644 include/linux/soc/sprd/sipa.h

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9920b3a68ed1..c5066f6c046c 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -518,6 +518,8 @@ source "drivers/net/hippi/Kconfig"
 
 source "drivers/net/ipa/Kconfig"
 
+source "drivers/net/sipa/Kconfig"
+
 config NET_SB1000
 	tristate "General Instruments Surfboard 1000"
 	depends on ISA && PNP
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 13743d0e83b5..3fb3b3c65a50 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_FDDI) += fddi/
 obj-$(CONFIG_HIPPI) += hippi/
 obj-$(CONFIG_HAMRADIO) += hamradio/
 obj-$(CONFIG_QCOM_IPA) += ipa/
+obj-$(CONFIG_SPRD_IPA) += sipa/
 obj-$(CONFIG_PLIP) += plip/
 obj-$(CONFIG_PPP) += ppp/
 obj-$(CONFIG_PPP_ASYNC) += ppp/
diff --git a/drivers/net/sipa/Kconfig b/drivers/net/sipa/Kconfig
new file mode 100644
index 000000000000..bbf91aa25fee
--- /dev/null
+++ b/drivers/net/sipa/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# SIPA network device configuration
+#
+
+config SPRD_IPA
+	tristate "SPREADTRUM IP PACKET ACCELERATOR"
+	depends on ARCH_SPRD
+	help
+	  IPA is a hardware block present in some Unisoc SoCs, choose
+	  Y or M to enabel it if you are sure current Soc include it.
+	  IP Packet Accelerator(IPA) is a programmable protocol processor
+	  which can process L2/L3 network packets, its mainly used in
+	  5g scenarios.
+
+	  If unsure, say N.
\ No newline at end of file
diff --git a/drivers/net/sipa/Makefile b/drivers/net/sipa/Makefile
new file mode 100644
index 000000000000..1a64b9621394
--- /dev/null
+++ b/drivers/net/sipa/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the SPRD IPA device drivers.
+#
+
+obj-$(CONFIG_SPRD_IPA) += sipa_core.o
diff --git a/drivers/net/sipa/sipa_core.c b/drivers/net/sipa/sipa_core.c
new file mode 100644
index 000000000000..77d97c236ac8
--- /dev/null
+++ b/drivers/net/sipa/sipa_core.c
@@ -0,0 +1,345 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Spreadtrum pin controller driver
+ * Copyright (C) 2017 Spreadtrum  - http://www.spreadtrum.com
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/kernel_stat.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pm_wakeup.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/soc/sprd/sipa.h>
+#include <linux/tick.h>
+#include <uapi/linux/sched/types.h>
+#include "sipa_priv.h"
+
+#define DRV_NAME "sipa"
+
+/**
+ * SPRD IPA contains a number of common fifo
+ * in the current Unisoc, mainly includes USB, WIFI, PCIE, AP etc.
+ */
+static struct sipa_cmn_fifo_info sipa_cmn_fifo_statics[SIPA_CFIFO_MAX] = {
+	{
+		.cfifo_name = "sprd,usb-ul",
+		.tx_fifo = "sprd,usb-ul-tx",
+		.rx_fifo = "sprd,usb-ul-rx",
+		.relate_ep = SIPA_EP_USB,
+		.src_id = SIPA_TERM_USB,
+		.dst_id = SIPA_TERM_AP,
+		.is_to_ipa = 1,
+		.is_pam = 1,
+	},
+	{
+		.cfifo_name = "sprd,wifi-ul",
+		.tx_fifo = "sprd,wifi-ul-tx",
+		.rx_fifo = "sprd,wifi-ul-rx",
+		.relate_ep = SIPA_EP_WIFI,
+		.src_id = SIPA_TERM_WIFI1,
+		.dst_id = SIPA_TERM_AP,
+		.is_to_ipa = 1,
+		.is_pam = 1,
+	},
+	{
+		.cfifo_name = "sprd,pcie-ul",
+		.tx_fifo = "sprd,pcie-ul-tx",
+		.rx_fifo = "sprd,pcie-ul-rx",
+		.relate_ep = SIPA_EP_PCIE,
+		.src_id = SIPA_TERM_PCIE0,
+		.dst_id = SIPA_TERM_AP,
+		.is_to_ipa = 1,
+		.is_pam = 1,
+	},
+	{
+		.cfifo_name = "sprd,wiap-dl",
+		.tx_fifo = "sprd,wiap-dl-tx",
+		.rx_fifo = "sprd,wiap-dl-rx",
+		.relate_ep = SIPA_EP_WIAP,
+		.src_id = SIPA_TERM_VAP0,
+		.dst_id = SIPA_TERM_AP,
+		.is_to_ipa = 1,
+		.is_pam = 1,
+	},
+	{
+		.cfifo_name = "sprd,map-in",
+		.tx_fifo = "sprd,map-in-tx",
+		.rx_fifo = "sprd,map-in-rx",
+		.relate_ep = SIPA_EP_AP,
+		.src_id = SIPA_TERM_AP,
+		.dst_id = SIPA_TERM_VCP,
+		.is_to_ipa = 1,
+		.is_pam = 0,
+	},
+	{
+		.cfifo_name = "sprd,usb-dl",
+		.tx_fifo = "sprd,usb-dl-tx",
+		.rx_fifo = "sprd,usb-dl-rx",
+		.relate_ep = SIPA_EP_USB,
+		.src_id = SIPA_TERM_USB,
+		.dst_id = SIPA_TERM_AP,
+		.is_to_ipa = 0,
+		.is_pam = 1,
+	},
+	{
+		.cfifo_name = "sprd,wifi-dl",
+		.tx_fifo = "sprd,wifi-dl-tx",
+		.rx_fifo = "sprd,wifi-dl-rx",
+		.relate_ep = SIPA_EP_WIFI,
+		.src_id = SIPA_TERM_WIFI1,
+		.dst_id = SIPA_TERM_AP,
+		.is_to_ipa = 0,
+		.is_pam = 1,
+	},
+	{
+		.cfifo_name = "sprd,pcie-dl",
+		.tx_fifo = "sprd,pcie-dl-tx",
+		.rx_fifo = "sprd,pcie-dl-rx",
+		.relate_ep = SIPA_EP_PCIE,
+		.src_id = SIPA_TERM_PCIE0,
+		.dst_id = SIPA_TERM_AP,
+		.is_to_ipa = 0,
+		.is_pam = 1,
+	},
+	{
+		.cfifo_name = "sprd,wiap-ul",
+		.tx_fifo = "sprd,wiap-ul-tx",
+		.rx_fifo = "sprd,wiap-ul-rx",
+		.relate_ep = SIPA_EP_WIAP,
+		.src_id = SIPA_TERM_VAP0,
+		.dst_id = SIPA_TERM_AP,
+		.is_to_ipa = 0,
+		.is_pam = 1,
+	},
+	{
+		.cfifo_name = "sprd,map0-out",
+		.tx_fifo = "sprd,map0-out-tx",
+		.rx_fifo = "sprd,map0-out-rx",
+		.relate_ep = SIPA_EP_AP,
+		.src_id = SIPA_TERM_AP,
+		.dst_id = SIPA_TERM_USB,
+		.is_to_ipa = 0,
+		.is_pam = 0,
+	},
+	{
+		.cfifo_name = "sprd,map1-out",
+		.tx_fifo = "sprd,map1-out-tx",
+		.rx_fifo = "sprd,map1-out-rx",
+		.relate_ep = SIPA_EP_AP,
+		.src_id = SIPA_TERM_AP,
+		.dst_id = SIPA_TERM_USB,
+		.is_to_ipa = 0,
+		.is_pam = 0,
+	},
+	{
+		.cfifo_name = "sprd,map2-out",
+		.tx_fifo = "sprd,map2-out-tx",
+		.rx_fifo = "sprd,map2-out-rx",
+		.relate_ep = SIPA_EP_AP,
+		.src_id = SIPA_TERM_AP,
+		.dst_id = SIPA_TERM_USB,
+		.is_to_ipa = 0,
+		.is_pam = 0,
+	},
+	{
+		.cfifo_name = "sprd,map3-out",
+		.tx_fifo = "sprd,map3-out-tx",
+		.rx_fifo = "sprd,map3-out-rx",
+		.relate_ep = SIPA_EP_AP,
+		.src_id = SIPA_TERM_AP,
+		.dst_id = SIPA_TERM_USB,
+		.is_to_ipa = 0,
+		.is_pam = 0,
+	},
+	{
+		.cfifo_name = "sprd,map4-out",
+		.tx_fifo = "sprd,map4-out-tx",
+		.rx_fifo = "sprd,map4-out-rx",
+		.relate_ep = SIPA_EP_AP,
+		.src_id = SIPA_TERM_AP,
+		.dst_id = SIPA_TERM_USB,
+		.is_to_ipa = 0,
+		.is_pam = 0,
+	},
+	{
+		.cfifo_name = "sprd,map5-out",
+		.tx_fifo = "sprd,map5-out-tx",
+		.rx_fifo = "sprd,map5-out-rx",
+		.relate_ep = SIPA_EP_AP,
+		.src_id = SIPA_TERM_AP,
+		.dst_id = SIPA_TERM_USB,
+		.is_to_ipa = 0,
+		.is_pam = 0,
+	},
+	{
+		.cfifo_name = "sprd,map6-out",
+		.tx_fifo = "sprd,map6-out-tx",
+		.rx_fifo = "sprd,map6-out-rx",
+		.relate_ep = SIPA_EP_AP,
+		.src_id = SIPA_TERM_AP,
+		.dst_id = SIPA_TERM_USB,
+		.is_to_ipa = 0,
+		.is_pam = 0,
+	},
+	{
+		.cfifo_name = "sprd,map7-out",
+		.tx_fifo = "sprd,map7-out-tx",
+		.rx_fifo = "sprd,map7-out-rx",
+		.relate_ep = SIPA_EP_AP,
+		.src_id = SIPA_TERM_AP,
+		.dst_id = SIPA_TERM_USB,
+		.is_to_ipa = 0,
+		.is_pam = 0,
+	},
+};
+
+static struct sipa_plat_drv_cfg *s_sipa_core;
+
+/**
+ * sipa_get_ctrl_pointer() - get the main structure of th sipa driver.
+ */
+struct sipa_plat_drv_cfg *sipa_get_ctrl_pointer(void)
+{
+	return s_sipa_core;
+}
+EXPORT_SYMBOL(sipa_get_ctrl_pointer);
+
+static int sipa_create_ep_from_fifo_idx(struct device *dev,
+					enum sipa_cmn_fifo_index fifo_idx)
+{
+	enum sipa_ep_id ep_id;
+	struct sipa_common_fifo *fifo;
+	struct sipa_endpoint *ep = NULL;
+	struct sipa_cmn_fifo_info *fifo_info;
+	struct sipa_plat_drv_cfg *ipa = dev_get_drvdata(dev);
+
+	fifo_info = (struct sipa_cmn_fifo_info *)sipa_cmn_fifo_statics;
+	ep_id = (fifo_info + fifo_idx)->relate_ep;
+
+	ep = ipa->eps[ep_id];
+	if (!ep) {
+		ep = kzalloc(sizeof(*ep), GFP_KERNEL);
+		if (!ep)
+			return -ENOMEM;
+
+		ipa->eps[ep_id] = ep;
+	} else if (fifo_idx > SIPA_CFIFO_MAP0_OUT) {
+		dev_info(dev, "ep %d has already create\n", ep->id);
+		return 0;
+	}
+
+	ep->dev = dev;
+	ep->id = (fifo_info + fifo_idx)->relate_ep;
+	dev_info(dev, "idx = %d ep = %d ep_id = %d is_to_ipa = %d\n",
+		 fifo_idx, ep->id, ep_id,
+		 (fifo_info + fifo_idx)->is_to_ipa);
+
+	ep->connected = false;
+	ep->suspended = true;
+
+	if (!(fifo_info + fifo_idx)->is_to_ipa) {
+		fifo = &ep->recv_fifo;
+		fifo->is_receiver = true;
+	} else {
+		fifo = &ep->send_fifo;
+		fifo->is_receiver = false;
+	}
+
+	fifo->rx_fifo.fifo_depth = ipa->cmn_fifo_cfg[fifo_idx].rx_fifo.depth;
+	fifo->tx_fifo.fifo_depth = ipa->cmn_fifo_cfg[fifo_idx].tx_fifo.depth;
+	fifo->dst_id = (fifo_info + fifo_idx)->dst_id;
+	fifo->src_id = (fifo_info + fifo_idx)->src_id;
+
+	fifo->idx = fifo_idx;
+
+	return 0;
+}
+
+static int sipa_create_eps(struct device *dev)
+{
+	int i, ret = 0;
+	struct sipa_plat_drv_cfg *ipa = dev_get_drvdata(dev);
+
+	dev_info(dev, "create eps start\n");
+	for (i = 0; i < SIPA_CFIFO_MAX; i++) {
+		if (ipa->cmn_fifo_cfg[i].tx_fifo.depth > 0) {
+			ret = sipa_create_ep_from_fifo_idx(dev, i);
+			if (ret) {
+				dev_err(dev, "create eps fifo %d fail\n", i);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int sipa_init(struct device *dev)
+{
+	int ret;
+
+	/* init sipa eps */
+	ret = sipa_create_eps(dev);
+
+	return ret;
+}
+
+static int sipa_plat_drv_probe(struct platform_device *pdev_p)
+{
+	int ret;
+	struct device *dev = &pdev_p->dev;
+	struct sipa_plat_drv_cfg *ipa;
+
+	ipa = devm_kzalloc(dev, sizeof(*ipa), GFP_KERNEL);
+	if (!ipa)
+		return -ENOMEM;
+
+	s_sipa_core = ipa;
+	dev_set_drvdata(dev, ipa);
+
+	ipa->dev = dev;
+	if (dma_set_mask_and_coherent(dev, ipa->hw_data->dma_mask))
+		dev_warn(dev, "no suitable DMA availabld\n");
+
+	ret = sipa_init(dev);
+	if (ret) {
+		dev_err(dev, "init failed %d\n", ret);
+		return ret;
+	}
+
+	ipa->udp_frag = false;
+	ipa->udp_port = false;
+	atomic_set(&ipa->udp_port_num, 0);
+
+	return ret;
+}
+
+static const struct of_device_id sipa_plat_drv_match[] = {
+	{ .compatible = "sprd,ipa-v3", .data = NULL},
+	{}
+};
+
+static struct platform_driver sipa_plat_drv = {
+	.probe = sipa_plat_drv_probe,
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = sipa_plat_drv_match,
+	},
+};
+module_platform_driver(sipa_plat_drv);
+
+MODULE_DESCRIPTION("Unisoc IPA HW device driver");
+MODULE_AUTHOR("Catdeo Zhang<catdeo.zhang@unisoc.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/sipa/sipa_priv.h b/drivers/net/sipa/sipa_priv.h
new file mode 100644
index 000000000000..a131d4067a86
--- /dev/null
+++ b/drivers/net/sipa/sipa_priv.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Spreadtrum pin controller driver
+ * Copyright (C) 2017 Spreadtrum  - http://www.spreadtrum.com
+ */
+
+#ifndef _SIPA_PRIV_H_
+#define _SIPA_PRIV_H_
+
+#include <linux/alarmtimer.h>
+#include <linux/skbuff.h>
+#include <linux/interrupt.h>
+#include <linux/cdev.h>
+#include <linux/regmap.h>
+#include <linux/kfifo.h>
+#include <linux/soc/sprd/sipa.h>
+#include <linux/spinlock.h>
+
+/* common fifo id */
+enum sipa_cmn_fifo_index {
+	SIPA_CFIFO_USB_UL,
+	SIPA_CFIFO_WIFI_UL,
+	SIPA_CFIFO_PCIE_UL,
+	SIPA_CFIFO_WIAP_DL,
+	SIPA_CFIFO_MAP_IN,
+	SIPA_CFIFO_USB_DL,
+	SIPA_CFIFO_WIFI_DL,
+	SIPA_CFIFO_PCIE_DL,
+	SIPA_CFIFO_WIAP_UL,
+	SIPA_CFIFO_MAP0_OUT,
+	SIPA_CFIFO_MAP1_OUT,
+	SIPA_CFIFO_MAP2_OUT,
+	SIPA_CFIFO_MAP3_OUT,
+	SIPA_CFIFO_MAP4_OUT,
+	SIPA_CFIFO_MAP5_OUT,
+	SIPA_CFIFO_MAP6_OUT,
+	SIPA_CFIFO_MAP7_OUT,
+
+	SIPA_CFIFO_MAX,
+};
+
+struct sipa_common_fifo {
+	enum sipa_cmn_fifo_index idx;
+
+	struct sipa_fifo_attrs tx_fifo;
+	struct sipa_fifo_attrs rx_fifo;
+
+	enum sipa_term_type dst_id;
+	enum sipa_term_type src_id;
+
+	bool is_receiver;
+	bool is_pam;
+};
+
+struct sipa_cmn_fifo_tag {
+	u32 depth;
+	u32 wr;
+	u32 rd;
+	bool in_iram;
+
+	u32 fifo_base_addr_l;
+	u32 fifo_base_addr_h;
+
+	void *virt_addr;
+};
+
+struct sipa_cmn_fifo_cfg_tag {
+	const char *fifo_name;
+
+	enum sipa_cmn_fifo_index fifo_id;
+	enum sipa_cmn_fifo_index fifo_id_dst;
+
+	bool is_recv;
+	bool is_pam;
+
+	u32 state;
+	u32 pending;
+	u32 dst;
+	u32 src;
+
+	u32 irq_eb;
+
+	u64 fifo_phy_addr;
+
+	void *priv;
+	void __iomem *fifo_reg_base;
+
+	struct kfifo rx_priv_fifo;
+	struct kfifo tx_priv_fifo;
+	struct sipa_cmn_fifo_tag rx_fifo;
+	struct sipa_cmn_fifo_tag tx_fifo;
+
+	u32 enter_flow_ctrl_cnt;
+	u32 exit_flow_ctrl_cnt;
+};
+
+/* common fifo information */
+struct sipa_cmn_fifo_info {
+	const char *cfifo_name;
+	const char *tx_fifo;
+	const char *rx_fifo;
+
+	enum sipa_ep_id relate_ep;
+	enum sipa_term_type src_id;
+	enum sipa_term_type dst_id;
+
+	/* centered on IPA*/
+	bool is_to_ipa;
+	bool is_pam;
+};
+
+/* ipa hw information */
+struct sipa_hw_data {
+	const u32 ahb_regnum;
+	const struct ipa_register_map *ahb_reg;
+	const bool standalone_subsys;
+	const u64 dma_mask;
+};
+
+/* endpoint which access to IPA */
+struct sipa_endpoint {
+	enum sipa_ep_id id;
+
+	struct device *dev;
+
+	/* Centered on CPU/PAM */
+	struct sipa_common_fifo send_fifo;
+	struct sipa_common_fifo recv_fifo;
+
+	struct sipa_comm_fifo_params send_fifo_param;
+	struct sipa_comm_fifo_params recv_fifo_param;
+
+	/* private data for sipa_notify_cb */
+	void *send_priv;
+	void *recv_priv;
+
+	bool inited;
+	bool connected;
+	bool suspended;
+};
+
+/* structure of IPA platform driver */
+struct sipa_plat_drv_cfg {
+	struct device *dev;
+
+	struct sipa_endpoint *eps[SIPA_EP_MAX];
+
+	/* avoid pam connect and power_wq race */
+	struct mutex resume_lock;
+
+	struct delayed_work power_work;
+	struct workqueue_struct *power_wq;
+
+	/* ipa power status */
+	bool power_flag;
+
+	u32 enable_cnt;
+	bool udp_frag;
+	bool udp_port;
+	atomic_t udp_port_num;
+
+	int is_bypass;
+
+	phys_addr_t glb_phy;
+	resource_size_t glb_size;
+	void  __iomem *glb_virt_base;
+
+	phys_addr_t iram_phy;
+	resource_size_t iram_size;
+	void  __iomem *iram_virt_base;
+
+	const struct sipa_hw_data *hw_data;
+	u32 suspend_cnt;
+	u32 resume_cnt;
+	struct sipa_cmn_fifo_cfg_tag cmn_fifo_cfg[SIPA_CFIFO_MAX];
+};
+#endif //_SIPA_PRIV_H_
diff --git a/include/linux/soc/sprd/sipa.h b/include/linux/soc/sprd/sipa.h
new file mode 100644
index 000000000000..f4107b8bdea1
--- /dev/null
+++ b/include/linux/soc/sprd/sipa.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Spreadtrum pin controller driver
+ * Copyright (C) 2017 Spreadtrum  - http://www.spreadtrum.com
+ */
+
+#ifndef _SIPA_H_
+#define _SIPA_H_
+
+/**
+ * enum sipa_ep_type - names for the various IPA end points
+ * these ids used for rx/tx data with IPA
+ * NOTE: one sipa EP may related to more than one sipa_term_types
+ */
+enum sipa_ep_id {
+	SIPA_EP_USB,
+	SIPA_EP_AP,
+	SIPA_EP_CP,
+	SIPA_EP_WIAP,
+	SIPA_EP_PCIE,
+	SIPA_EP_WIFI,
+
+	SIPA_EP_MAX,
+};
+
+/**
+ * enum sipa_term_type - names for the various IPA source / destination ID
+ */
+enum sipa_term_type {
+	SIPA_TERM_USB = 0x1,
+	SIPA_TERM_WIFI1 = 0x2,
+	SIPA_TERM_WIFI2 = 0x3,
+	SIPA_TERM_CP0 = 0x4,
+	SIPA_TERM_CP1 = 0x5,
+	SIPA_TERM_VCP = 0x6,
+	SIPA_TERM_VAP0 = 0xc,
+	SIPA_TERM_VAP1 = 0xd,
+	SIPA_TERM_VAP2 = 0xe,
+	SIPA_TERM_PCIE0 = 0x10,
+	SIPA_TERM_PCIE1 = 0x11,
+	SIPA_TERM_PCIE2 = 0x12,
+	SIPA_TERM_AP = 0x19,
+
+	SIPA_TERM_MAX = 0x20, /* max 5-bit register */
+};
+
+/* rx/tx fifo attribute of cfifo*/
+struct sipa_fifo_attrs {
+	dma_addr_t dma_addr;
+	u32 fifo_depth;
+};
+
+/**
+ * struct sipa_comm_fifo_params - information needed to setup an IPA
+ * common FIFO, the tx/rx are from the perspective of IPA
+ * @tx_intr_delay_us: timeout value for interrupt
+ * @tx_intr_threshol: threshold value for interrupt
+ * @errcode_intr: enable/disable of errcode interrupt
+ * @flowctrl_in_tx_full: enable/disable of tx cfifo full interrupt
+ * @flow_ctrl_cfg: flow control config
+ * @flow_ctrl_irq_mode: flow control interrupt mode
+ */
+struct sipa_comm_fifo_params {
+	u32 intr_to_ap;
+
+	u32 tx_intr_delay_us;
+	u32 tx_intr_threshold;
+	bool errcode_intr;
+	bool flowctrl_in_tx_full;
+	u32 flow_ctrl_cfg;
+	u32 flow_ctrl_irq_mode;
+	u32 tx_enter_flowctrl_watermark;
+	u32 tx_leave_flowctrl_watermark;
+	u32 rx_enter_flowctrl_watermark;
+	u32 rx_leave_flowctrl_watermark;
+
+	u32 data_ptr_cnt;
+	u32 buf_size;
+	dma_addr_t data_ptr;
+};
+
+/**
+ * sipa_get_ctrl_pointer() - get the main structure of th sipa driver.
+ */
+struct sipa_plat_drv_cfg *sipa_get_ctrl_pointer(void);
+#endif //_SIPA_H_
-- 
2.34.1


