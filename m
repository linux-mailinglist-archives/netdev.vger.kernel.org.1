Return-Path: <netdev+bounces-132234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDDE9910DB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B0A1F22E35
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCD61422B8;
	Fri,  4 Oct 2024 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpGkaCSP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE71B231CAE;
	Fri,  4 Oct 2024 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074997; cv=none; b=IOUc4En66h4XWtVZNSlQObLQRUF5B0Ph0LceeWAOGLGTIAxeg9zJY12vS8iWDh0FxGHGrISbw6SVq44amD9yKBoRkImkLNvc7O/1lze+Eoi8joQwSgJKKTmbUv/pRz4GFgA+Ajbjvo7evOz5oipGiiJJ0wSJnH3KZK5sHd8i8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074997; c=relaxed/simple;
	bh=SM0CYrcQjxPMYf1KRht8hBSSCSoHsAB5T7yKTWkZjC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1xYfSSQoT0zRMYSdz2et3StUZ+1DBtuv5AYKrzlr9sJakAoI5gPnUgU39Q6jguhXjTjoYX/HWc7CHaDerjdPhocgYYK9bQG4u76/IPGg9elKwAfMN0Z37703zOkDgo9HiY4BxLPj2X0tfzMupdqVQ7rj9EHu88+9MI/W1j/vQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpGkaCSP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b6c311f62so23258085ad.0;
        Fri, 04 Oct 2024 13:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728074995; x=1728679795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HgpvSyUUdK9JXwe/u4hdh5CwvYKQnt7yikjt5TAUPNQ=;
        b=KpGkaCSP3+FaS+Mic36eUEf6bNI7Mq6E0qKDZLUf3AaDaTaV52qtg4OuFFQyKxPLVK
         ZUqs7GVwCrZ1tVNqi/RG4KAroRxv7guSo17YHUke+nAwrqtay4LfvDqBNVf14CMXC+KC
         COsaoE/VwqFYpEbWPJLtYnXjSrLJ1ej/D6919w+xMCCY7rnQxj8+GW1+FHug6BN6XIyo
         vJE2a1FmwqwUg1J+2xqD+opvfmBOzuJ1fQ5/eQHrJRMYMsMeiq3gcAjvaHN1o4G6jmpT
         r/ZsyIi1Bf4hAHBC18cWD7177li/nsyDx1GF0gPFQSuY4S8EEB/ScU5V9Q5u+oYOi3Y0
         DuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728074995; x=1728679795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgpvSyUUdK9JXwe/u4hdh5CwvYKQnt7yikjt5TAUPNQ=;
        b=PqT2Dp40rHZdYhu7AlvQLyUAgWyVgY1d5SER4M9F/odvTAp3rrZaLyVQTQprsOaC66
         ccVkhYFW/ip14SqvxSOF9Jbr7LUg5AF3tIYsUjt4WzNLLM6yDFxFwQ40fgzAmDhfJ4ys
         R1GJxjAmvTvNfVSf6dXbzX87rNIovZPRN+8feKDpVYmrNbyhVqGNMv4hb3EsQmOhgMJu
         qTQ/YxNBwkkgLo0e3UNSkrabCK1w+Shr1K/MRW8ht3W8kuycTQzctPtl2Y7eGU1x2yPa
         Tu+n/4GrkjoE8pEjJmTWCE9RkR4YrO/0kZ6UqX1kJsEH/iKwHF/unNmMFgIPhq/ER0Wy
         DSrg==
X-Forwarded-Encrypted: i=1; AJvYcCVicBR8f8r4Kkci6QTo9yyB8xWUPoKHPqDiwCKpAAa5k9FzTc5MpiF6wviqgJIQ6b4UdoGUFPRbL83lbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3NpWkYvxCnNF3B60UAVbnIJbaBMGXb7uYN4e+A5v4cs72KdK0
	JkkPf5Urr4BpfsGh8QtLQ5RoX+dVaK/Y9sxqyE87l/KD/RMCJCL1nHcpQ+6P
X-Google-Smtp-Source: AGHT+IFAZBpnm6xPVxGVl/IofgmfAFqNq1i8ftRGdcDWNI1f1JIpxEHy9LH3y8dLFJd8z+RdDnYhAw==
X-Received: by 2002:a17:903:22d0:b0:20b:9c8c:e9f5 with SMTP id d9443c01a7336-20bfe2a03b0mr40156085ad.25.1728074994730;
        Fri, 04 Oct 2024 13:49:54 -0700 (PDT)
Received: from localhost (fwdproxy-prn-000.fbsv.net. [2a03:2880:ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138b13a0sm2689005ad.50.2024.10.04.13.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 13:49:54 -0700 (PDT)
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
	sanman.p211993@gmail.com
Subject: [PATCH net-next v3] eth: fbnic: Add hardware monitoring support via HWMON interface
Date: Fri,  4 Oct 2024 13:49:53 -0700
Message-ID: <20241004204953.2223536-1-sanman.p211993@gmail.com>
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
v3:
  - Add missing "id" initialization in fbnic_hwmon_read
  - Change ifm_hwmon_unregister to hwmon_unregister

v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241003173618.2479520-1-sanman.p211993@gmail.com/

v1: https://lore.kernel.org/netdev/153c5be4-158e-421a-83a5-5632a9263e87@roeck-us.net/T/

---
 drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  4 +
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 81 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  7 ++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  7 +-
 5 files changed, 99 insertions(+), 1 deletion(-)
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
index a4809fe0fc24..debd98ea55e2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -289,6 +289,8 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

 	fbnic_devlink_register(fbd);

+	fbnic_hwmon_register(fbd);
+
 	if (!fbd->dsn) {
 		dev_warn(&pdev->dev, "Reading serial number failed\n");
 		goto init_failure_mode;
@@ -297,7 +299,7 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev = fbnic_netdev_alloc(fbd);
 	if (!netdev) {
 		dev_err(&pdev->dev, "Netdev allocation failed\n");
-		goto init_failure_mode;
+		goto hwmon_unregister;
 	}

 	err = fbnic_netdev_register(netdev);
@@ -310,6 +312,8 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

 ifm_free_netdev:
 	fbnic_netdev_free(fbd);
+hwmon_unregister:
+	fbnic_hwmon_unregister(fbd);
 init_failure_mode:
 	dev_warn(&pdev->dev, "Probe error encountered, entering init failure mode. Normal networking functionality will not be available.\n");
 	 /* Always return 0 even on error so devlink is registered to allow
@@ -345,6 +349,7 @@ static void fbnic_remove(struct pci_dev *pdev)
 		fbnic_netdev_free(fbd);
 	}

+	fbnic_hwmon_unregister(fbd);
 	fbnic_devlink_unregister(fbd);
 	fbnic_fw_disable_mbx(fbd);
 	fbnic_free_irqs(fbd);
--
2.43.5

