Return-Path: <netdev+bounces-197497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FACBAD8CFC
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9383B3E8E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401EA224CC;
	Fri, 13 Jun 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wWmCCZO8"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480DC2F22;
	Fri, 13 Jun 2025 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749820767; cv=none; b=A/AfmF5s+bGbkjuGT5P1d4WBJVaJ5RC3q9d+brZbEVD+NCoObrOF8VOlKLdwsadPnkJrf/kHZrEfpU38udJb4X4y7d/etwSUlrCp+vuuFgQ/e/xD8Zjnw0YqLF4HKB4YaMUzRuuA2M3T9c7qH1mF1J3Kwcu4YLUJajuDbSK9k+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749820767; c=relaxed/simple;
	bh=e3+7YlD19HZodM0ZPNmbIt24WnlflgEnLjO5QggBlVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kKLOOIAQ46JdxF28OfvD5ymsIJLvfznu7HJug29Tychm6oE6ZZjM6+SLG7YXiKwZCXOqvtK4FSXZ881z/q0BvTymrghI3iD467dGVHHyd7shmKTh32dKvACBQDXeN8oenRgk44xxuuRAXoIp/H3KHCOPt9NER+8vSk2UoKfDojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wWmCCZO8; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749820761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UTpqzx/I7knYrEQNLnovX3S0UrarEkhfBlmvyVvUnXc=;
	b=wWmCCZO8LOjQRGy22/OSuxjsJ1wP56n3XaUFlPsx97hH5hdjeqGYrtPbnjHzdJxeiRMICe
	Bfi8W3e8xpqGYsO2riTNUghrKZAY82QKiXCFoxgElWgyjAjFKQIUwhGZqM9usiHn42GYEb
	uegnSYCHuN5O0rteaj4+tl865P4fcio=
From: Yajun Deng <yajun.deng@linux.dev>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next v3] net: phy: Add c45_phy_ids sysfs directory entry
Date: Fri, 13 Jun 2025 21:19:03 +0800
Message-Id: <20250613131903.2961-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The phy_id field only shows the PHY ID of the C22 device, and the C45
device did not store its PHY ID in this field.

Add a new phy_mmd_group, and export the mmd<n>_device_id for the C45
device. These files are invisible to the C22 device.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v3: Make code more readable.
v2: Only one value for per file and invisible to the C22 device.
v1: https://lore.kernel.org/all/20250523132606.2814-1-yajun.deng@linux.dev/
---
 .../ABI/testing/sysfs-class-net-phydev        |  10 ++
 drivers/net/phy/phy_device.c                  | 112 +++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-phydev b/Documentation/ABI/testing/sysfs-class-net-phydev
index ac722dd5e694..31615c59bff9 100644
--- a/Documentation/ABI/testing/sysfs-class-net-phydev
+++ b/Documentation/ABI/testing/sysfs-class-net-phydev
@@ -26,6 +26,16 @@ Description:
 		This ID is used to match the device with the appropriate
 		driver.
 
+What:		/sys/class/mdio_bus/<bus>/<device>/c45_phy_ids/mmd<n>_device_id
+Date:		June 2025
+KernelVersion:	6.17
+Contact:	netdev@vger.kernel.org
+Description:
+		This attribute contains the 32-bit PHY Identifier as reported
+		by the device during bus enumeration, encoded in hexadecimal.
+		These C45 IDs are used to match the device with the appropriate
+		driver. These files are invisible to the C22 device.
+
 What:		/sys/class/mdio_bus/<bus>/<device>/phy_interface
 Date:		February 2014
 KernelVersion:	3.15
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 73f9cb2e2844..d03f706d004b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -645,11 +645,119 @@ static struct attribute *phy_dev_attrs[] = {
 	&dev_attr_phy_dev_flags.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(phy_dev);
+
+static const struct attribute_group phy_dev_group = {
+	.attrs = phy_dev_attrs,
+};
+
+#define MMD_DEVICE_ID_ATTR(n) \
+static ssize_t mmd##n##_device_id_show(struct device *dev, \
+				struct device_attribute *attr, char *buf) \
+{ \
+	struct phy_device *phydev = to_phy_device(dev); \
+	return sysfs_emit(buf, "0x%.8lx\n", \
+			 (unsigned long)phydev->c45_ids.device_ids[n]); \
+} \
+static DEVICE_ATTR_RO(mmd##n##_device_id)
+
+MMD_DEVICE_ID_ATTR(1);
+MMD_DEVICE_ID_ATTR(2);
+MMD_DEVICE_ID_ATTR(3);
+MMD_DEVICE_ID_ATTR(4);
+MMD_DEVICE_ID_ATTR(5);
+MMD_DEVICE_ID_ATTR(6);
+MMD_DEVICE_ID_ATTR(7);
+MMD_DEVICE_ID_ATTR(8);
+MMD_DEVICE_ID_ATTR(9);
+MMD_DEVICE_ID_ATTR(10);
+MMD_DEVICE_ID_ATTR(11);
+MMD_DEVICE_ID_ATTR(12);
+MMD_DEVICE_ID_ATTR(13);
+MMD_DEVICE_ID_ATTR(14);
+MMD_DEVICE_ID_ATTR(15);
+MMD_DEVICE_ID_ATTR(16);
+MMD_DEVICE_ID_ATTR(17);
+MMD_DEVICE_ID_ATTR(18);
+MMD_DEVICE_ID_ATTR(19);
+MMD_DEVICE_ID_ATTR(20);
+MMD_DEVICE_ID_ATTR(21);
+MMD_DEVICE_ID_ATTR(22);
+MMD_DEVICE_ID_ATTR(23);
+MMD_DEVICE_ID_ATTR(24);
+MMD_DEVICE_ID_ATTR(25);
+MMD_DEVICE_ID_ATTR(26);
+MMD_DEVICE_ID_ATTR(27);
+MMD_DEVICE_ID_ATTR(28);
+MMD_DEVICE_ID_ATTR(29);
+MMD_DEVICE_ID_ATTR(30);
+MMD_DEVICE_ID_ATTR(31);
+
+static struct attribute *phy_mmd_attrs[] = {
+	&dev_attr_mmd1_device_id.attr,
+	&dev_attr_mmd2_device_id.attr,
+	&dev_attr_mmd3_device_id.attr,
+	&dev_attr_mmd4_device_id.attr,
+	&dev_attr_mmd5_device_id.attr,
+	&dev_attr_mmd6_device_id.attr,
+	&dev_attr_mmd7_device_id.attr,
+	&dev_attr_mmd8_device_id.attr,
+	&dev_attr_mmd9_device_id.attr,
+	&dev_attr_mmd10_device_id.attr,
+	&dev_attr_mmd11_device_id.attr,
+	&dev_attr_mmd12_device_id.attr,
+	&dev_attr_mmd13_device_id.attr,
+	&dev_attr_mmd14_device_id.attr,
+	&dev_attr_mmd15_device_id.attr,
+	&dev_attr_mmd16_device_id.attr,
+	&dev_attr_mmd17_device_id.attr,
+	&dev_attr_mmd18_device_id.attr,
+	&dev_attr_mmd19_device_id.attr,
+	&dev_attr_mmd20_device_id.attr,
+	&dev_attr_mmd21_device_id.attr,
+	&dev_attr_mmd22_device_id.attr,
+	&dev_attr_mmd23_device_id.attr,
+	&dev_attr_mmd24_device_id.attr,
+	&dev_attr_mmd25_device_id.attr,
+	&dev_attr_mmd26_device_id.attr,
+	&dev_attr_mmd27_device_id.attr,
+	&dev_attr_mmd28_device_id.attr,
+	&dev_attr_mmd29_device_id.attr,
+	&dev_attr_mmd30_device_id.attr,
+	&dev_attr_mmd31_device_id.attr,
+	NULL
+};
+
+static umode_t phy_mmd_is_visible(struct kobject *kobj,
+				  struct attribute *attr, int index)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct phy_device *phydev = to_phy_device(dev);
+	const int i = index + 1;
+
+	if (!phydev->is_c45)
+		return 0;
+	if (i >= ARRAY_SIZE(phydev->c45_ids.device_ids) ||
+	    phydev->c45_ids.device_ids[i] == 0xffffffff)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group phy_mmd_group = {
+	.name = "c45_phy_ids",
+	.attrs = phy_mmd_attrs,
+	.is_visible = phy_mmd_is_visible,
+};
+
+static const struct attribute_group *phy_device_groups[] = {
+	&phy_dev_group,
+	&phy_mmd_group,
+	NULL,
+};
 
 static const struct device_type mdio_bus_phy_type = {
 	.name = "PHY",
-	.groups = phy_dev_groups,
+	.groups = phy_device_groups,
 	.release = phy_device_release,
 	.pm = pm_ptr(&mdio_bus_phy_pm_ops),
 };
-- 
2.25.1


