Return-Path: <netdev+bounces-133154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544C19951C2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB8D1F23D67
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6601DFD93;
	Tue,  8 Oct 2024 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwjPt5NG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F51DF971;
	Tue,  8 Oct 2024 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397936; cv=none; b=ZtT6PtawdHEYzGPlrz/BiKj4bwJms+OlxCnLcGzYOiUX9jp2lc8qPQi6bZxd1o6xsyrB629Yj2N00pxkv90OnOAsSjdkyjf4AF17ELrgVEyFaC1SMKwwxTovXTob/aFHngm0Wul6fwBO/0q8IfHSYIKnB3phahzuz/o4z5UpDnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397936; c=relaxed/simple;
	bh=fjrCk4137L88teoPYU5iGZn05p+Bd17ibV8LwmzJA8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NYn50I+je1vV5anedMKd9lXW2lAl4yUtIMdaSUUKHZRvFtoDDTQeYRVejTHR5QF8PHQXQiHQL0xYLKGXSxf2ALAaQQybHpmnwXy4DYEKUUyUTdwEjVFDGYa1RvMrR70fcjUHbDOS0/V0CVAWLGnC+yAdD1Y3CKiipKCzJk48ufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwjPt5NG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3692766a12.2;
        Tue, 08 Oct 2024 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397934; x=1729002734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JzBu+H68oIXTmVQw8lkIZpXB/OximB10KQD3/i1Dy70=;
        b=UwjPt5NG3/cAjvc5RQwdxvw/wfXYlyxnTQ5megSM/X9PmtD0TIZD5jk2KS5UgFvQ85
         6A2uJ79hAPbE6/WjUdtWRYOyoNsT/IwIdnbK4NcYlhj1pIo5PfelkeWJsj5PCn/fT/Y1
         X7azX+xcBTTwbdoOQVSzW7h/U01ofqzV/tfzg5qWbQ+FTPjKsrPvOOYkbKhaovKxvLww
         5TmBOQO/8dqX+GLdcEZI3kLZtUnVafF6Te1+5L3j/2P/2X9wX8y5ZYewLs9JSLplTjQt
         +LTD0UKPzkgaMf/6zZdu5DQ8FyxpipsCUbXqx2J4c0gtgUndX2xSklEei4c3Puzbciby
         SKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397934; x=1729002734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzBu+H68oIXTmVQw8lkIZpXB/OximB10KQD3/i1Dy70=;
        b=pgSvvHoZsJ3MVdCZJ/rPb45qQZTbCSfoY6xSNK2EY2arPzDm/jwhULWblI3RBqYzTn
         0TLLlQWgFvRbTmkpYeB7bbNEUadRLUEHH70A2QdUN5rhHlHTuKw/NlsslSB4v7ACyO+v
         ZVo/SWYox3bMq9/TMy2dLaSNX+g0O/xGRFclUBJEFNXjWvZSqXVvwfWfzRBM9Z2j76IV
         jDV/H/ppkCH25zO7PoZGoc5DI2rjWMLED63EtsBnoAAckkpC9daiuFeMWcuQZEW/GgmI
         JQLOpiaQFl0ST7A45ti/K1E7kzUlt6L/pSjaCoSxmTdc4M7a4s10rFUN53mfjP+APWMk
         hdrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuKgwS6PGi3RyqEphShTYr+0/EJL1A+UL9iy96kCk0DZcNrRDOMv+6GrB8WS/zzpPoSi6DGPKc/sN0tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9gup6GezCB9X3VGtH7PwrCJ4Cs0cejNnM97gjsJq4vdrT6qUl
	ZWE5+mhUG7/erIKQ2VXTdjQFn//Dz13Nk9qdN79iTD1OOS15KXU3pGpKcJrD
X-Google-Smtp-Source: AGHT+IG/8lA/LWd+fkkMRiXuYRetqQiq7+arMEg4Al8kZSD8GbI0n7V9a+U4z2aLLvRggmvs3yFeoQ==
X-Received: by 2002:a05:6a21:478a:b0:1cf:6b93:561c with SMTP id adf61e73a8af0-1d6dfa3a780mr25117637637.15.1728397933756;
        Tue, 08 Oct 2024 07:32:13 -0700 (PDT)
Received: from localhost (fwdproxy-prn-019.fbsv.net. [2a03:2880:ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd0b5bsm6200586b3a.53.2024.10.08.07.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:32:13 -0700 (PDT)
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
Subject: [PATCH net-next v4] eth: fbnic: Add hardware monitoring support via HWMON interface
Date: Tue,  8 Oct 2024 07:32:12 -0700
Message-ID: <20241008143212.2354554-1-sanman.p211993@gmail.com>
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
v4:
  - Fix label name in fbnic_pci.c

v3: https://patchwork.kernel.org/project/netdevbpf/patch/20241004204953.2223536-1-sanman.p211993@gmail.com/

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
index a4809fe0fc24..10b9573d829e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -289,9 +289,11 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

 	fbnic_devlink_register(fbd);

+	fbnic_hwmon_register(fbd);
+
 	if (!fbd->dsn) {
 		dev_warn(&pdev->dev, "Reading serial number failed\n");
-		goto init_failure_mode;
+		goto hwmon_unregister;
 	}

 	netdev = fbnic_netdev_alloc(fbd);
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

