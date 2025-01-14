Return-Path: <netdev+bounces-157925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE73A0F577
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4D21886036
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 00:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E481F5F6;
	Tue, 14 Jan 2025 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUjQQpq7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B508C0B;
	Tue, 14 Jan 2025 00:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736813232; cv=none; b=gJ7EI+2gbWmfUHmE8taZzEAefxjSbVzrbyHJOiqMn2TymVNeuZf7N5gbEnL1fBF8e4Wx5uvYLnZRIAoWSIvFw40VfRVdHbEiBWtu79XvXCSabcGtqR/P6/uYYQa3ORIid/yheo6UDhJtDOxgcZAebQGi3L2qoqJQpqSAjqvaOXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736813232; c=relaxed/simple;
	bh=xdE5TPZZ7Jibsnu9ChJ0E+7B5izKvQ0wVrCKOhI9BME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4XrKVBJS+GBBS559Oi4/YPj/RXxGIEEboq0Np4MT46RB3Zw09IAm7fpfcdad6ttMWCbzkVar4OAk1lS6rpmnPewgSZyzIXXbK+fhLkNQfUHGQlgdqwgYWVgggpFx9Crjb0SeUpr/oct1EZmGv2bDzNjqGAhHEBQMmKn+R+Vu3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUjQQpq7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21a7ed0155cso83976425ad.3;
        Mon, 13 Jan 2025 16:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736813230; x=1737418030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNaWdNFIeTj7eNqwtykAY+wvCCFWg9mpXJ37B1tl9Lk=;
        b=mUjQQpq76xGxWPg72jf0PV4ER3kRelTjpUSz9hfzefZ2CCypM6Xn9EEEclFCzOHtPp
         g6VS1i3BsA24vCNve8SIHkWj+aotvGWsWRaQsNe57U+I1K2iLFeplslTQpg0gKsrSPC5
         0wCdyIIzjUAlrjaVtmPf07mo004FWFBxVEmrz/n3qG4bI9kdSXhROPyp9IQ9r8IJw0Zo
         GsU2QXjuLUxiH0mM0rMgz5PIQqHYH29aZ6hJ4tkWFmkJoiuRAdSkDnbdIxcM2Iam74rb
         za6yYRMcOFN9gIyFnmHPWWQYgY8h25sZdtJJX/OTpXzR0+89fFqYKQUaitJXInBhU8Sn
         SR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736813230; x=1737418030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNaWdNFIeTj7eNqwtykAY+wvCCFWg9mpXJ37B1tl9Lk=;
        b=lTAmNMrBcaPR0yK6Wg2bRM74c42XuDLvkf8wdSoRx1KvZQNmWTvXoFF1PtU1z+3ypM
         9yJCSWtOXk/G40y7Og6msdcpeJnfFOoxJqGv6jV32d7NS7cxEtWiJlOgw31mkqMdiL/b
         PLGMD5vSye4YOP56XTUIgKl0o/DjJgOjKgIspbERBV30TFbwma/Wqq0agRgockL1fgZS
         A2d/aUFBX22J26kPuHTqRbfYdgXPZlbLqGF+L6X5XH4QWPgoBG6Nvn0oh2RZ+NcY+RQb
         lH4dLzujcbWgKR78xL1b5jN1IsMH3ph+W+rME2r6bAehJgnDmu0iGW3+xHAp7CdZwol4
         sWKA==
X-Forwarded-Encrypted: i=1; AJvYcCUii1cRNVAtwwYwL0aPatb4fzf4qoNLmpdD++b0oNvJUgPj46aot60LDyLuwdHIvMV4pMTcL6GjZq6ro/6y@vger.kernel.org, AJvYcCX7PudBXq9m2ublt+t5f2DBIeHlp+o5BZLjSf8G1fgi/ArC/7rQUl3XCVB9sHeasGupid0AM4KpzrUXVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBHI35wWavIlrCeOMX8OJQVVGgBYRX55D9EvIc46J4qgPRJ6s
	WX8dkh18iRf+u1E5Qcnt8oFOSGjkp2S5SoHGQ4HQkXVhpDQSZiqpEttGomsYKTY=
X-Gm-Gg: ASbGncvoaAC3SeamKYsXfLo2xMdd0/2hxrlK5EkDS+kKJfjqwRmXzO4Q+6hxUxhmLXB
	TvlYIAPv15xGKhAUkV/6oRi9smtIwGC5CkwJA4A856XC6G3V1XcIobcKuEK3QLBQufPg9LqRsfr
	RWeUEwxobvJqizmHEnPtC3c51sF2M/O4CIc6SRfwNb+csPOC92VtWfyTbUgB0HzUr6q/MFOgE+6
	Phq0BCaH7D1UhpqmHy1bVWOrxrhHMlPqJlAgfLYHYSikxKVO80iAOw=
X-Google-Smtp-Source: AGHT+IG6rGCMxUTPfjgPXUbeGzRJBTT2qh0Iz4HxqJ765ewebhM4jJ/pQxh4PxVaEe73NbeEE8rMNw==
X-Received: by 2002:a05:6a20:6a0a:b0:1e0:d380:fe71 with SMTP id adf61e73a8af0-1e88cf079f0mr37406576637.0.1736813229923;
        Mon, 13 Jan 2025 16:07:09 -0800 (PST)
Received: from localhost ([2a03:2880:ff:12::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317a07cce2sm7471752a12.4.2025.01.13.16.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 16:07:09 -0800 (PST)
From: Sanman Pradhan <sanman.p211993@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	kernel-team@meta.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kalesh-anakkur.purayil@broadcom.com,
	linux@roeck-us.net,
	mohsin.bashr@gmail.com,
	jdelvare@suse.com,
	horms@kernel.org,
	suhui@nfschina.com,
	linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	linux-hwmon@vger.kernel.org,
	sanmanpradhan@meta.com,
	sanman.p211993@gmail.com
Subject: [PATCH net-next 3/3] eth: fbnic: Add hardware monitoring support via HWMON interface
Date: Mon, 13 Jan 2025 16:07:05 -0800
Message-ID: <20250114000705.2081288-4-sanman.p211993@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250114000705.2081288-1-sanman.p211993@gmail.com>
References: <20250114000705.2081288-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for hardware monitoring to the fbnic driver,
allowing for temperature and voltage sensor data to be exposed to
userspace via the HWMON interface. The driver registers a HWMON device
and provides callbacks for reading sensor data, enabling system
admins to monitor the health and operating conditions of fbnic.

Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  4 +
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 81 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  3 +
 4 files changed, 89 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c

diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
index ea6214ca48e7..239b2258ec65 100644
--- a/drivers/net/ethernet/meta/fbnic/Makefile
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -13,6 +13,7 @@ fbnic-y := fbnic_csr.o \
 	   fbnic_ethtool.o \
 	   fbnic_fw.o \
 	   fbnic_hw_stats.o \
+	   fbnic_hwmon.o \
 	   fbnic_irq.o \
 	   fbnic_mac.o \
 	   fbnic_netdev.o \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index ad8ac5ac7be9..14751f16e125 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -24,6 +24,7 @@ struct fbnic_dev {
 	struct device *dev;
 	struct net_device *netdev;
 	struct dentry *dbg_fbd;
+	struct device *hwmon;

 	u32 __iomem *uc_addr0;
 	u32 __iomem *uc_addr4;
@@ -150,6 +151,9 @@ void fbnic_devlink_unregister(struct fbnic_dev *fbd);
 int fbnic_fw_enable_mbx(struct fbnic_dev *fbd);
 void fbnic_fw_disable_mbx(struct fbnic_dev *fbd);

+void fbnic_hwmon_register(struct fbnic_dev *fbd);
+void fbnic_hwmon_unregister(struct fbnic_dev *fbd);
+
 int fbnic_pcs_irq_enable(struct fbnic_dev *fbd);
 void fbnic_pcs_irq_disable(struct fbnic_dev *fbd);

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
new file mode 100644
index 000000000000..def8598aceec
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
+			   fbd->hwmon);
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
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 2c96980d150d..6cbbc2ee3e1f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -296,6 +296,8 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Capture snapshot of hardware stats so netdev can calculate delta */
 	fbnic_reset_hw_stats(fbd);

+	fbnic_hwmon_register(fbd);
+
 	if (!fbd->dsn) {
 		dev_warn(&pdev->dev, "Reading serial number failed\n");
 		goto init_failure_mode;
@@ -358,6 +360,7 @@ static void fbnic_remove(struct pci_dev *pdev)
 		fbnic_netdev_free(fbd);
 	}

+	fbnic_hwmon_unregister(fbd);
 	fbnic_dbg_fbd_exit(fbd);
 	fbnic_devlink_unregister(fbd);
 	fbnic_fw_disable_mbx(fbd);
--
2.43.5

