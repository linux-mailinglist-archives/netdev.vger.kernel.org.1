Return-Path: <netdev+bounces-131716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FF398F560
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183C21C21839
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311FE1AAE0C;
	Thu,  3 Oct 2024 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJMBfKx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821E0182A0;
	Thu,  3 Oct 2024 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976982; cv=none; b=p1kWbvuEaeltFcPe322IcJ0fFYDjdMYBV/WS6c3RBPn8OwIfz3mbKgXY1Y/XviKE75z9KUU0GEQav9c5Y+mWGRkJdki0r4kE9eqI5YvqqYV7Y9tNqVYpoL+5F3FPYOwBWzJvwr2hsA7OGni5Z0oYGj94BV/4iwdkU1Y32Pba4x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976982; c=relaxed/simple;
	bh=rKwHqgWfxyoNze5JpILO1wpolYo/jaz+xkKZMODUz/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTY+SvftuBO3csIUCbkhLZFgrlcX/wmN0q3thBgYk+/Q//wsTYzTGWOiEcMgJV6Vqce3pDqiGX5t/F8K5PKPMX+yp6HhulPEHw+Nkwh/FjeGWo4D3ldfHyG1Rr/hgVNdwZsFYnvsASQ1F0Q/hCc9UXkPxLS3AfKyJun0QOmf9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJMBfKx2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718e285544fso1075775b3a.1;
        Thu, 03 Oct 2024 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727976980; x=1728581780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dC82U9ki1uSJ7KW+ACdAUoC+V1tgur3GONih3dm36ho=;
        b=aJMBfKx2U1Am2EkLRoIYGyrlWPziBXTUu+BhzKb5k2/6PUaYnfpFwc11DBhOe1a4HR
         6AkqMfbamVJMg8CRIg8xRwDpUBfEfszyX8B17u+MWn8ZmSndA+Ym6fTQWZfZRjMHuxY8
         CIP2ade8ePDAVH68TYCeQaD2JePX3MBOZaU1kXkyQ+6lR6SIQbQy0w3xl5tPVbIzbJGx
         0uGRtfNOf6hLnMyfeNNSimGmQ0+ryDyrpTjJ7lj6585ExgDId8m3t0ZSvnpvWqPNvLQK
         uXJDa29EepSKyRQjPbDl/p9wi+4nUZHDUMy9Ef2Wsq51z9gyBkEjvD66qUd7bl0+bmwL
         ULsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976980; x=1728581780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dC82U9ki1uSJ7KW+ACdAUoC+V1tgur3GONih3dm36ho=;
        b=mZtKSvQqxkumpc3/ovligZQVF58t1xDGq7P51pGy3zcfU0fY5VvXQz4wmJyHyqffKS
         AxoZi+7iZvSvvNnUTmmnPCAOg4p/sQAnAgjfwCwjZUAb9O+LO6GRQqWeHx5yk2DK2s4k
         Q9/X3LVolzyAV/0IL6cYPJA/k7fIP3j51QiZJYCqIFAnon4cdzWQJkOmMPPo0CGam5Bj
         j1uGrVK7RUhrAQc3saeK+SP3DZMsx37Dw085rNwjeQYG61cIFtG94u/yIehXhQOuF4qN
         0GEFYho4UXSZGlQ+oOmmODA4I4C+LSLIkGLpVm2Zg/UgUmelBkOfouWVe2u0xR6N/Q/X
         cs0w==
X-Forwarded-Encrypted: i=1; AJvYcCWVk80VoiIEIRAiyaHdy+MC0rypWfQD44pbUS8gE+5gID1azoNszQhYU+U6IlTTAewmW5NhTMBFZ7PKoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0G8d1HExpL2iDA/ua316gAiRsviibA14Ab3YpjtDHi4COvZm
	feMUjuiMVuMX6YToRTsnQVePv7vc8uWwKQ+epp0t4CnnbUABdqX236n8kJ7z
X-Google-Smtp-Source: AGHT+IEQNRXLjbTkSwd5+l9IX6TEjbibQMRih6MVWu2+8bdtZD2q77qVTB2M6J9UvijKyu2Cu9E/6Q==
X-Received: by 2002:a05:6a20:b598:b0:1d6:de67:91c0 with SMTP id adf61e73a8af0-1d6dfa46dd9mr124104637.27.1727976979304;
        Thu, 03 Oct 2024 10:36:19 -0700 (PDT)
Received: from localhost (fwdproxy-prn-005.fbsv.net. [2a03:2880:ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb51csm1618703b3a.113.2024.10.03.10.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:36:18 -0700 (PDT)
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
Subject: [PATCH net-next v2] eth: fbnic: Add hardware monitoring support via HWMON interface
Date: Thu,  3 Oct 2024 10:36:18 -0700
Message-ID: <20241003173618.2479520-1-sanman.p211993@gmail.com>
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
v2:
  - Refined error handling in hwmon registration
  - Improve error handling and logging for hwmon device registration failures

v1: https://lore.kernel.org/netdev/153c5be4-158e-421a-83a5-5632a9263e87@roeck-us.net/T/

---
 drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  4 +
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 80 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  7 ++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  8 +-
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
index 000000000000..0ff9c85f08eb
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
@@ -0,0 +1,80 @@
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
index a4809fe0fc24..633a9aa39fe2 100644
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
+		goto ifm_hwmon_unregister;
 	}

 	err = fbnic_netdev_register(netdev);
@@ -308,6 +310,8 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

 	return 0;

+ifm_hwmon_unregister:
+	fbnic_hwmon_unregister(fbd);
 ifm_free_netdev:
 	fbnic_netdev_free(fbd);
 init_failure_mode:
@@ -345,6 +349,7 @@ static void fbnic_remove(struct pci_dev *pdev)
 		fbnic_netdev_free(fbd);
 	}

+	fbnic_hwmon_unregister(fbd);
 	fbnic_devlink_unregister(fbd);
 	fbnic_fw_disable_mbx(fbd);
 	fbnic_free_irqs(fbd);
@@ -428,6 +433,7 @@ static int __fbnic_pm_resume(struct device *dev)
 	rtnl_unlock();

 	return 0;
+
 err_disable_mbx:
 	rtnl_unlock();
 	fbnic_fw_disable_mbx(fbd);
--
2.43.5

