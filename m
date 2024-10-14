Return-Path: <netdev+bounces-135251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7581D99D2C8
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CA71C22916
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394081C9EDB;
	Mon, 14 Oct 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMSkLeh4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE881BB6BB;
	Mon, 14 Oct 2024 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919633; cv=none; b=Q4A6igsfvZH5x6R6v0N3SpY/BqLjea2++yYI3jKwY8qRnfYO/9pLhKQTINvsXxPUUr3iFC4CelHc29k72RQT6q9OUsYIzFOo/YjoQQHCHox+yb0So0Kye4D4/i3Av1FipfR++tgnsy8EaLtLM2YY4ql/s/KF5Ah0gwGIgIOe9sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919633; c=relaxed/simple;
	bh=/w9Os86l7FHNJxysUUeMiY+H+cHaR+kLKaoHZu3+CsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Op8dnkwGmkaKTA4SX1pHa6h69oDwC1VCHPA2xBtIFAsTIA6Zvbd+GipuFYnZT5JQTAa3718LGlcS2ctd3hTT5Ut03vKUlraC7ESBc2sh/8KmRNiUPRQ5TSC1OB8ttklXws9VtKfMPz1kVcdpJUtqyjK116cwBSC0eo78iCWtfuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMSkLeh4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e52582cf8so1229056b3a.2;
        Mon, 14 Oct 2024 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728919630; x=1729524430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOAdM2vRa0WDPcot4d5cPlMIUWLYDpNWkruyJ5KeQW0=;
        b=WMSkLeh4N8n6PIyn8EtOcG4i+oKhylt4D2/XH+gn/miXxQbwB86/izNdGA94wemL67
         Y7GZN2mbnAaH2SGcEBOcs41wJEBVcCMOtJcstu181D8ZJQ+vWEAVxkd+shT+7QFl+T5T
         8h0CSD7Vqxkn5BqH+TbEnkWXiDzyxhbhvZ9ycB3nGimktX/0mCD4meXyHS+H7JKjSqwg
         zjoIDhlo//GXhEmAsovW9FpLvLkt2QhD9ZT2dpjW2xzFSu8JsRBCtFbdKc/C5mXXRRpg
         D2HGefMji1mnPGGPabzs80nws87MuOO6eLL2RvO9n45DEy8IWvJMaL2kBotB/L0giOze
         gwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919630; x=1729524430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOAdM2vRa0WDPcot4d5cPlMIUWLYDpNWkruyJ5KeQW0=;
        b=PFdEMcb6a5l9OlWGp3Gu3NdkFkv7pUoHVf1D7xq5GaXJPy6oi7jMxTYQ9/DpBYI2+r
         q7YTcvXPj+WMufK6v8YGKESjvVWk68hUK8ajiPJx++JfE0GHPw6/2/EEwPDf7K4tXsD6
         nyRHyEQFpqSTbJVZgWQHCD9fKYqq/k3/owgSzy9zjkCRhMij5rPTxvO0+y1cvXHH+2YG
         1wY4ZA/b+MRYghUrOT+G1HpGgwvySwlvNlFi6i2sWjXxrAfiiPBfz0jwPf2kVXRPOw6/
         NUv8MlxFDXV+MDIXKposWztIAi7PIH/1G4ulMXRa6byy2K6Io+/YFPC+/0zE8IUzPFPu
         a4TA==
X-Forwarded-Encrypted: i=1; AJvYcCVDhpZ5nAQblgusMSFFTtpZiGrkkhdw/C8U4lukbDWoWpFu7JIRpoDaLu8hHLmIuh3Ih+S2Dayo4XJMsg==@vger.kernel.org, AJvYcCXQPONjeZPM4G741bAhZQ3r1kc83m2aOtw37u4O6UWRUXwyFbOJba3GZmW2TWxzIyUcmfenPz0KVUtNxQq7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy732QNH/Hv6HQ+k9m3IdEDgedQQA1qHU6iuEGBTaLaSHA3pNf8
	QBmkTjQrcah7uYcs8RR9XnR7Mmg756cNaARbs/0fuufVdONnRA5KEwGNnIeL
X-Google-Smtp-Source: AGHT+IH6nXvsp3J8kgQ2EVC0PM9s96sJEUTLd55W/4f6yKvrLIhLm8lb9t5nR33RpPwbz5c78SB2WA==
X-Received: by 2002:a05:6a20:d808:b0:1d7:8fd:2df6 with SMTP id adf61e73a8af0-1d8c9577029mr13103445637.1.1728919630292;
        Mon, 14 Oct 2024 08:27:10 -0700 (PDT)
Received: from localhost (fwdproxy-prn-113.fbsv.net. [2a03:2880:ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea448e3eaesm6934758a12.19.2024.10.14.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:27:09 -0700 (PDT)
From: Sanman Pradhan <sanman.p211993@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	kernel-team@meta.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	horms@kernel.org,
	mohsin.bashr@gmail.com,
	sanmanpradhan@meta.com,
	andrew@lunn.ch,
	linux-hwmon@vger.kernel.org,
	sanman.p211993@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7] eth: fbnic: Add hardware monitoring support via HWMON interface
Date: Mon, 14 Oct 2024 08:27:09 -0700
Message-ID: <20241014152709.2123811-1-sanman.p211993@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanman Pradhan <sanmanpradhan@meta.com>

This patch adds support for hardware monitoring to the fbnic driver,
allowing for temperature and voltage sensor data to be exposed to
userspace via the HWMON interface. The driver registers a HWMON device
and provides callbacks for reading sensor data, enabling system
admins to monitor the health and operating conditions of fbnic.

Signed-off-by: Sanman Pradhan <sanmanpradhan@meta.com>

---
v7:
  - Address local variable err

v6: https://patchwork.kernel.org/project/netdevbpf/patch/20241011235847.1209435-1-sanman.p211993@gmail.com/

v5: https://patchwork.kernel.org/project/netdevbpf/patch/20241009192018.2683416-1-sanman.p211993@gmail.com/

v4: https://patchwork.kernel.org/project/netdevbpf/patch/20241008143212.2354554-1-sanman.p211993@gmail.com/

v3: https://patchwork.kernel.org/project/netdevbpf/patch/20241004204953.2223536-1-sanman.p211993@gmail.com/

v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241003173618.2479520-1-sanman.p211993@gmail.com/

v1: https://lore.kernel.org/netdev/153c5be4-158e-421a-83a5-5632a9263e87@roeck-us.net/T/

---
 drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  5 ++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  7 ++
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 81 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 22 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  7 ++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  3 +
 7 files changed, 126 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index ed4533a73c57..41494022792a 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -11,6 +11,7 @@ fbnic-y := fbnic_devlink.o \
 	   fbnic_ethtool.o \
 	   fbnic_fw.o \
 	   fbnic_hw_stats.o \
+	   fbnic_hwmon.o \
 	   fbnic_irq.o \
 	   fbnic_mac.o \
 	   fbnic_netdev.o \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 0f9e8d79461c..ff0ff012c8d6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -18,6 +18,7 @@
 struct fbnic_dev {
 	struct device *dev;
 	struct net_device *netdev;
+	struct device *hwmon;

 	u32 __iomem *uc_addr0;
 	u32 __iomem *uc_addr4;
@@ -30,6 +31,7 @@ struct fbnic_dev {

 	struct fbnic_fw_mbx mbx[FBNIC_IPC_MBX_INDICES];
 	struct fbnic_fw_cap fw_cap;
+	struct fbnic_fw_completion *cmpl_data;
 	/* Lock protecting Tx Mailbox queue to prevent possible races */
 	spinlock_t fw_tx_lock;

@@ -127,6 +129,9 @@ void fbnic_devlink_unregister(struct fbnic_dev *fbd);
 int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
 void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);

+void fbnic_hwmon_register(struct fbnic_dev *fbd);
+void fbnic_hwmon_unregister(struct fbnic_dev *fbd);
+
 int fbnic_pcs_irq_enable(struct fbnic_dev *fbd);
 void fbnic_pcs_irq_disable(struct fbnic_dev *fbd);

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 221faf8c6756..7cd8841920e4 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -44,6 +44,13 @@ struct fbnic_fw_cap {
 	u8	link_fec;
 };

+struct fbnic_fw_completion {
+	struct {
+		s32 millivolts;
+		s32 millidegrees;
+	} tsene;
+};
+
 void fbnic_mbx_init(struct fbnic_dev *fbd);
 void fbnic_mbx_clean(struct fbnic_dev *fbd);
 void fbnic_mbx_poll(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
new file mode 100644
index 000000000000..bcd1086e3768
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/hwmon.h>
+
+#include "fbnic.h"
+#include "fbnic_mac.h"
+
+static int fbnic_hwmon_sensor_id(enum hwmon_sensor_types type)
+{
+	if (type == hwmon_temp)
+		return FBNIC_SENSOR_TEMP;
+	if (type == hwmon_in)
+		return FBNIC_SENSOR_VOLTAGE;
+
+	return -EOPNOTSUPP;
+}
+
+static umode_t fbnic_hwmon_is_visible(const void *drvdata,
+				      enum hwmon_sensor_types type,
+				      u32 attr, int channel)
+{
+	if (type == hwmon_temp && attr == hwmon_temp_input)
+		return 0444;
+	if (type == hwmon_in && attr == hwmon_in_input)
+		return 0444;
+
+	return 0;
+}
+
+static int fbnic_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, long *val)
+{
+	struct fbnic_dev *fbd = dev_get_drvdata(dev);
+	const struct fbnic_mac *mac = fbd->mac;
+	int id;
+
+	id = fbnic_hwmon_sensor_id(type);
+	return id < 0 ? id : mac->get_sensor(fbd, id, val);
+}
+
+static const struct hwmon_ops fbnic_hwmon_ops = {
+	.is_visible = fbnic_hwmon_is_visible,
+	.read = fbnic_hwmon_read,
+};
+
+static const struct hwmon_channel_info *fbnic_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT),
+	NULL
+};
+
+static const struct hwmon_chip_info fbnic_chip_info = {
+	.ops = &fbnic_hwmon_ops,
+	.info = fbnic_hwmon_info,
+};
+
+void fbnic_hwmon_register(struct fbnic_dev *fbd)
+{
+	if (!IS_REACHABLE(CONFIG_HWMON))
+		return;
+
+	fbd->hwmon = hwmon_device_register_with_info(fbd->dev, "fbnic",
+						     fbd, &fbnic_chip_info,
+						     NULL);
+	if (IS_ERR(fbd->hwmon)) {
+		dev_notice(fbd->dev,
+			   "Failed to register hwmon device %pe\n",
+			fbd->hwmon);
+		fbd->hwmon = NULL;
+	}
+}
+
+void fbnic_hwmon_unregister(struct fbnic_dev *fbd)
+{
+	if (!IS_REACHABLE(CONFIG_HWMON) || !fbd->hwmon)
+		return;
+
+	hwmon_device_unregister(fbd->hwmon);
+	fbd->hwmon = NULL;
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 7b654d0a6dac..80b82ff12c4d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -686,6 +686,27 @@ fbnic_mac_get_eth_mac_stats(struct fbnic_dev *fbd, bool reset,
 			    MAC_STAT_TX_BROADCAST);
 }

+static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id, long *val)
+{
+	struct fbnic_fw_completion fw_cmpl;
+	s32 *sensor;
+
+	switch (id) {
+	case FBNIC_SENSOR_TEMP:
+		sensor = &fw_cmpl.tsene.millidegrees;
+		break;
+	case FBNIC_SENSOR_VOLTAGE:
+		sensor = &fw_cmpl.tsene.millivolts;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*val = *sensor;
+
+	return 0;
+}
+
 static const struct fbnic_mac fbnic_mac_asic = {
 	.init_regs = fbnic_mac_init_regs,
 	.pcs_enable = fbnic_pcs_enable_asic,
@@ -695,6 +716,7 @@ static const struct fbnic_mac fbnic_mac_asic = {
 	.get_eth_mac_stats = fbnic_mac_get_eth_mac_stats,
 	.link_down = fbnic_mac_link_down_asic,
 	.link_up = fbnic_mac_link_up_asic,
+	.get_sensor = fbnic_mac_get_sensor_asic,
 };

 /**
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index 476239a9d381..05a591653e09 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -47,6 +47,11 @@ enum {
 #define FBNIC_LINK_MODE_PAM4	(FBNIC_LINK_50R1)
 #define FBNIC_LINK_MODE_MASK	(FBNIC_LINK_AUTO - 1)

+enum fbnic_sensor_id {
+	FBNIC_SENSOR_TEMP,		/* Temp in millidegrees Centigrade */
+	FBNIC_SENSOR_VOLTAGE,		/* Voltage in millivolts */
+};
+
 /* This structure defines the interface hooks for the MAC. The MAC hooks
  * will be configured as a const struct provided with a set of function
  * pointers.
@@ -83,6 +88,8 @@ struct fbnic_mac {

 	void (*link_down)(struct fbnic_dev *fbd);
 	void (*link_up)(struct fbnic_dev *fbd, bool tx_pause, bool rx_pause);
+
+	int (*get_sensor)(struct fbnic_dev *fbd, int id, long *val);
 };

 int fbnic_mac_init(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index a4809fe0fc24..ef9dc8c67927 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -289,6 +289,8 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

 	fbnic_devlink_register(fbd);

+	fbnic_hwmon_register(fbd);
+
 	if (!fbd->dsn) {
 		dev_warn(&pdev->dev, "Reading serial number failed\n");
 		goto init_failure_mode;
@@ -345,6 +347,7 @@ static void fbnic_remove(struct pci_dev *pdev)
 		fbnic_netdev_free(fbd);
 	}

+	fbnic_hwmon_unregister(fbd);
 	fbnic_devlink_unregister(fbd);
 	fbnic_fw_disable_mbx(fbd);
 	fbnic_free_irqs(fbd);
--
2.43.5

