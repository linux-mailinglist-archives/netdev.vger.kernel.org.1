Return-Path: <netdev+bounces-155319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E13A01DB6
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 03:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B772161C00
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 02:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61F7158DC6;
	Mon,  6 Jan 2025 02:37:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A6C4FDDBB;
	Mon,  6 Jan 2025 02:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736131033; cv=none; b=D6yjE82han4y9QCWyaMe0zagtlNNezwkxcE01QfHmMCM4K4bQbsxydiSJ8ZEFXDUx/crG80RU2hs4N7LGV3FphSvHchNnU1VcXfh6V7y/a0Iwm7cXmgCFPxxJpa4bgrp3zWujiDg99fQEfrqMIgS/q2qiHm7yGxCiDc1ZRO30Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736131033; c=relaxed/simple;
	bh=mZoeeXeM1CE/WJpT7ky+BmsMOLhsfNoXOJFjLqB9WCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eIlSKPtQ2jiq8PDNYqqVw2k4f/14qlo/yV8jAb0q5QMJokmfOwqg7OsYzWWh7UnKu622dX2IL5X4MJvg9GMt/XkYT17fS7ApkQ3Zc6S+XrlPzCpaR98+6GhvRcJOx1f/MxegAIT5HjSZkHKN+/GBV8244b+ru4XfWT7UwrcTG1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id C4A5660107E1F;
	Mon,  6 Jan 2025 10:36:52 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: alexanderduyck@fb.com,
	kuba@kernel.org,
	kernel-team@meta.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	michal.swiatkowski@linux.intel.com
Cc: Su Hui <suhui@nfschina.com>,
	mohsin.bashr@gmail.com,
	sanmanpradhan@meta.com,
	vadim.fedorenko@linux.dev,
	kalesh-anakkur.purayil@broadcom.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v3] eth: fbnic: Revert "eth: fbnic: Add hardware monitoring support via HWMON interface"
Date: Mon,  6 Jan 2025 10:36:48 +0800
Message-Id: <20250106023647.47756-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a garbage value problem in fbnic_mac_get_sensor_asic(). 'fw_cmpl'
is uninitialized which makes 'sensor' and '*val' to be stored garbage
value. Revert commit d85ebade02e8 ("eth: fbnic: Add hardware monitoring
support via HWMON interface") to avoid this problem.

Fixes: d85ebade02e8 ("eth: fbnic: Add hardware monitoring support via HWMON interface")
Signed-off-by: Su Hui <suhui@nfschina.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v3: 
 - revert the whole commit.
v2:
 - remove the whole body of fbnic_mac_get_sensor_asic().
v1:
 - https://lore.kernel.org/all/20241224022728.675609-1-suhui@nfschina.com/

 drivers/net/ethernet/meta/fbnic/Makefile      |  1 -
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  5 --
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  7 --
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 81 -------------------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 22 -----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  7 --
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  3 -
 7 files changed, 126 deletions(-)
 delete mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index 239b2258ec65..ea6214ca48e7 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -13,7 +13,6 @@ fbnic-y := fbnic_csr.o \
 	   fbnic_ethtool.o \
 	   fbnic_fw.o \
 	   fbnic_hw_stats.o \
-	   fbnic_hwmon.o \
 	   fbnic_irq.o \
 	   fbnic_mac.o \
 	   fbnic_netdev.o \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 706ae6104c8e..744eb0d95449 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -20,7 +20,6 @@ struct fbnic_dev {
 	struct device *dev;
 	struct net_device *netdev;
 	struct dentry *dbg_fbd;
-	struct device *hwmon;
 
 	u32 __iomem *uc_addr0;
 	u32 __iomem *uc_addr4;
@@ -33,7 +32,6 @@ struct fbnic_dev {
 
 	struct fbnic_fw_mbx mbx[FBNIC_IPC_MBX_INDICES];
 	struct fbnic_fw_cap fw_cap;
-	struct fbnic_fw_completion *cmpl_data;
 	/* Lock protecting Tx Mailbox queue to prevent possible races */
 	spinlock_t fw_tx_lock;
 
@@ -142,9 +140,6 @@ void fbnic_devlink_unregister(struct fbnic_dev *fbd);
 int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
 void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);
 
-void fbnic_hwmon_register(struct fbnic_dev *fbd);
-void fbnic_hwmon_unregister(struct fbnic_dev *fbd);
-
 int fbnic_pcs_irq_enable(struct fbnic_dev *fbd);
 void fbnic_pcs_irq_disable(struct fbnic_dev *fbd);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 7cd8841920e4..221faf8c6756 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -44,13 +44,6 @@ struct fbnic_fw_cap {
 	u8	link_fec;
 };
 
-struct fbnic_fw_completion {
-	struct {
-		s32 millivolts;
-		s32 millidegrees;
-	} tsene;
-};
-
 void fbnic_mbx_init(struct fbnic_dev *fbd);
 void fbnic_mbx_clean(struct fbnic_dev *fbd);
 void fbnic_mbx_poll(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
deleted file mode 100644
index bcd1086e3768..000000000000
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
+++ /dev/null
@@ -1,81 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) Meta Platforms, Inc. and affiliates. */
-
-#include <linux/hwmon.h>
-
-#include "fbnic.h"
-#include "fbnic_mac.h"
-
-static int fbnic_hwmon_sensor_id(enum hwmon_sensor_types type)
-{
-	if (type == hwmon_temp)
-		return FBNIC_SENSOR_TEMP;
-	if (type == hwmon_in)
-		return FBNIC_SENSOR_VOLTAGE;
-
-	return -EOPNOTSUPP;
-}
-
-static umode_t fbnic_hwmon_is_visible(const void *drvdata,
-				      enum hwmon_sensor_types type,
-				      u32 attr, int channel)
-{
-	if (type == hwmon_temp && attr == hwmon_temp_input)
-		return 0444;
-	if (type == hwmon_in && attr == hwmon_in_input)
-		return 0444;
-
-	return 0;
-}
-
-static int fbnic_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
-			    u32 attr, int channel, long *val)
-{
-	struct fbnic_dev *fbd = dev_get_drvdata(dev);
-	const struct fbnic_mac *mac = fbd->mac;
-	int id;
-
-	id = fbnic_hwmon_sensor_id(type);
-	return id < 0 ? id : mac->get_sensor(fbd, id, val);
-}
-
-static const struct hwmon_ops fbnic_hwmon_ops = {
-	.is_visible = fbnic_hwmon_is_visible,
-	.read = fbnic_hwmon_read,
-};
-
-static const struct hwmon_channel_info *fbnic_hwmon_info[] = {
-	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
-	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT),
-	NULL
-};
-
-static const struct hwmon_chip_info fbnic_chip_info = {
-	.ops = &fbnic_hwmon_ops,
-	.info = fbnic_hwmon_info,
-};
-
-void fbnic_hwmon_register(struct fbnic_dev *fbd)
-{
-	if (!IS_REACHABLE(CONFIG_HWMON))
-		return;
-
-	fbd->hwmon = hwmon_device_register_with_info(fbd->dev, "fbnic",
-						     fbd, &fbnic_chip_info,
-						     NULL);
-	if (IS_ERR(fbd->hwmon)) {
-		dev_notice(fbd->dev,
-			   "Failed to register hwmon device %pe\n",
-			fbd->hwmon);
-		fbd->hwmon = NULL;
-	}
-}
-
-void fbnic_hwmon_unregister(struct fbnic_dev *fbd)
-{
-	if (!IS_REACHABLE(CONFIG_HWMON) || !fbd->hwmon)
-		return;
-
-	hwmon_device_unregister(fbd->hwmon);
-	fbd->hwmon = NULL;
-}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 80b82ff12c4d..7b654d0a6dac 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -686,27 +686,6 @@ fbnic_mac_get_eth_mac_stats(struct fbnic_dev *fbd, bool reset,
 			    MAC_STAT_TX_BROADCAST);
 }
 
-static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id, long *val)
-{
-	struct fbnic_fw_completion fw_cmpl;
-	s32 *sensor;
-
-	switch (id) {
-	case FBNIC_SENSOR_TEMP:
-		sensor = &fw_cmpl.tsene.millidegrees;
-		break;
-	case FBNIC_SENSOR_VOLTAGE:
-		sensor = &fw_cmpl.tsene.millivolts;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	*val = *sensor;
-
-	return 0;
-}
-
 static const struct fbnic_mac fbnic_mac_asic = {
 	.init_regs = fbnic_mac_init_regs,
 	.pcs_enable = fbnic_pcs_enable_asic,
@@ -716,7 +695,6 @@ static const struct fbnic_mac fbnic_mac_asic = {
 	.get_eth_mac_stats = fbnic_mac_get_eth_mac_stats,
 	.link_down = fbnic_mac_link_down_asic,
 	.link_up = fbnic_mac_link_up_asic,
-	.get_sensor = fbnic_mac_get_sensor_asic,
 };
 
 /**
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index 05a591653e09..476239a9d381 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -47,11 +47,6 @@ enum {
 #define FBNIC_LINK_MODE_PAM4	(FBNIC_LINK_50R1)
 #define FBNIC_LINK_MODE_MASK	(FBNIC_LINK_AUTO - 1)
 
-enum fbnic_sensor_id {
-	FBNIC_SENSOR_TEMP,		/* Temp in millidegrees Centigrade */
-	FBNIC_SENSOR_VOLTAGE,		/* Voltage in millivolts */
-};
-
 /* This structure defines the interface hooks for the MAC. The MAC hooks
  * will be configured as a const struct provided with a set of function
  * pointers.
@@ -88,8 +83,6 @@ struct fbnic_mac {
 
 	void (*link_down)(struct fbnic_dev *fbd);
 	void (*link_up)(struct fbnic_dev *fbd, bool tx_pause, bool rx_pause);
-
-	int (*get_sensor)(struct fbnic_dev *fbd, int id, long *val);
 };
 
 int fbnic_mac_init(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 32702dc4a066..7ccf192f13d5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -296,8 +296,6 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Capture snapshot of hardware stats so netdev can calculate delta */
 	fbnic_reset_hw_stats(fbd);
 
-	fbnic_hwmon_register(fbd);
-
 	if (!fbd->dsn) {
 		dev_warn(&pdev->dev, "Reading serial number failed\n");
 		goto init_failure_mode;
@@ -360,7 +358,6 @@ static void fbnic_remove(struct pci_dev *pdev)
 		fbnic_netdev_free(fbd);
 	}
 
-	fbnic_hwmon_unregister(fbd);
 	fbnic_dbg_fbd_exit(fbd);
 	fbnic_devlink_unregister(fbd);
 	fbnic_fw_disable_mbx(fbd);
-- 
2.30.2


