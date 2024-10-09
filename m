Return-Path: <netdev+bounces-133886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FCA997581
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 21:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3485B220BE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF7E1714A5;
	Wed,  9 Oct 2024 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1dGaH2u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71286178378;
	Wed,  9 Oct 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728501622; cv=none; b=AAGS+itOCH9EzvAjnta0+0RB/VEYosE5hvWw6VTgkJXaahkUQJzcc/80W/HDvv/ersMz3foy02m9CBpw7RO0dc5rkpyAL430JV5wgWH4HyyMQdeLG6jZCQhmd5ZhIFavPFWvaf63U+SXr+Yj1GfxPcjC1vym0siW+DbTcVjjPEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728501622; c=relaxed/simple;
	bh=IWJ+joWcbxEjc5vmr8FrcsLUPOFIrcSoKDwl3HL2oiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPZLhWJ4MgX9PfgT9WCO2rcjnxVJhrC9eQJI+U0vr88CcZXFWahTCQkjgU6d527hI4y20+MGdbllrQetamKb0N/8R6ExeJTsKOZw6D7aL3LLH8G5O/hE2TIDvBkZnG2jsq7CSdGlj2CRVrgkp81LV5cgwiwqUCYghGEELLBxgBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1dGaH2u; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso94531a12.2;
        Wed, 09 Oct 2024 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728501620; x=1729106420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f7gxaELvNEFT5M2VIuGKrg16utiwOuClRCF4Ot5zkoA=;
        b=W1dGaH2ue7TKBDueoZiqNh1oo1IJLFEPRGbSiMvDAzCnQkLFDpmkCGq1Noci5qUOi6
         Ix6X/qJYDUrdnEhwicmLflgh2EuhnXAd/Ndb8rtzmzMD3eViJhGZqPdpMK5FwzOiQSH5
         UCQgneMvQo6wAdQ+b4Tiya/kqAlJouOjm4GB7j2MCkRDk4pqTwhNT/TPh9hZu8v2cZN3
         n8yn9uxfRVqTKG/MG1h0dT8Sf+/KkCaFuexI7NJ966EhawrUtVfFWar1dDYH4yI+7YP9
         nll0p+Da6c6a81Cbr1AaP+31ChFKSQN6k6FXIJlEEXCj7ywMHzER+kBMS6ZrC0gj16aM
         gbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728501620; x=1729106420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7gxaELvNEFT5M2VIuGKrg16utiwOuClRCF4Ot5zkoA=;
        b=Gx84VISSWQmtZBWlVlZmw5PcGudKofTUym4oEInwajchRaI9HyP1LbwZ8PaZYxlCuS
         x4rwhB13OjejAiOwQggsizt4BJWGz9iIx+mysoIz45HAhpcv8OkmLQ9LhIGPKB9t+1d8
         SqgBQbwdmqrTB9sdrsuExuYdWdUbW7GlG872sFGtNDCuS29vVmzgnMnP4H/9Ra6Eq2mn
         cGWz7OQrKhHe+mz/H41Rp44dlpxIhF8QenxYJgBndX+QgA5UQ79pLmSxgDwW6YoSkFy8
         Qydf2YPE/jldutOezC+RKwpVCwkiIiEmHMwtFXa+MvQ8kib1bAJyb46XhqMU3M54LIx1
         BqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTh1rVGNasIAOfEvkhB1yNRDJd9z5aGGCYq0u7VDKlYNAuQnbIlDMrF20nxeLHjIZAZeleYaLL5P89iioW@vger.kernel.org, AJvYcCVs+6uwnErxFR8oU04sy/qpK/HfE4jEDktKkVw1JfrBRNZaIWvYFizHR4NINi5zc4sLlrWxabN6Yv3k2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkdLh3HUYWlOBZN/8hhpS3ZWfZQ3ZCt+q+Y8hriYIzIGnditRy
	2FwmDsQoatqtffklQjUO7BRKGK1TpHtwRo010qHITsouzVDO3jeFl6hHmoTB
X-Google-Smtp-Source: AGHT+IHi9T66i4vzoFuac6fUCJSS5dD1g+T3MdMOTGUOUUhH5/ZWr/CEMJzgKmZ50eLt60hmBtz9Ig==
X-Received: by 2002:a05:6a21:3511:b0:1d8:a3ab:7220 with SMTP id adf61e73a8af0-1d8a3b5cac9mr5390238637.0.1728501619571;
        Wed, 09 Oct 2024 12:20:19 -0700 (PDT)
Received: from localhost (fwdproxy-prn-012.fbsv.net. [2a03:2880:ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d47804sm8112688b3a.137.2024.10.09.12.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 12:20:19 -0700 (PDT)
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
Subject: [PATCH net-next v5] eth: fbnic: Add hardware monitoring support via HWMON interface
Date: Wed,  9 Oct 2024 12:20:18 -0700
Message-ID: <20241009192018.2683416-1-sanman.p211993@gmail.com>
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
v5:
  - Drop hwmon_unregister label from fbnic_pci.c

v4: https://patchwork.kernel.org/project/netdevbpf/patch/20241008143212.2354554-1-sanman.p211993@gmail.com/

v3: https://patchwork.kernel.org/project/netdevbpf/patch/20241004204953.2223536-1-sanman.p211993@gmail.com/

v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241003173618.2479520-1-sanman.p211993@gmail.com/

v1: https://lore.kernel.org/netdev/153c5be4-158e-421a-83a5-5632a9263e87@roeck-us.net/T/

---
 drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  4 +
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 81 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  7 ++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  3 +
 5 files changed, 96 insertions(+)
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
index 0f9e8d79461c..2d3aa20bc876 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -18,6 +18,7 @@
 struct fbnic_dev {
 	struct device *dev;
 	struct net_device *netdev;
+	struct device *hwmon;

 	u32 __iomem *uc_addr0;
 	u32 __iomem *uc_addr4;
@@ -127,6 +128,9 @@ void fbnic_devlink_unregister(struct fbnic_dev *fbd);
 int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
 void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);

+void fbnic_hwmon_register(struct fbnic_dev *fbd);
+void fbnic_hwmon_unregister(struct fbnic_dev *fbd);
+
 int fbnic_pcs_irq_enable(struct fbnic_dev *fbd);
 void fbnic_pcs_irq_disable(struct fbnic_dev *fbd);

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

