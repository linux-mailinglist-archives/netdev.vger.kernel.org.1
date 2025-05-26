Return-Path: <netdev+bounces-193445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A34BAC40F6
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F177AAC0F
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11F0204F99;
	Mon, 26 May 2025 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="geZPHyLb"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133343C465
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268375; cv=none; b=d67CSRtwzZyeeIQrwfwiIGlzH6CA5yl+wFP3Q9ji93jYlQOEQZv1neuUgKq3o174LrwqaWEszU2rhwUjnf78cIsLo67H9jxl4ftf2+g1oUH+MuhmEf+IXNrJkb6iRa/BWaZS4RPU3aMfpv3P82pR8r1Quv2+g81UOgvxAfVQUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268375; c=relaxed/simple;
	bh=KzhaOxqOJsWeZIeq7vo6rI0JW45k0M6z2V5NAlTmR0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NR77hhLU74eVzV3i+Taq5eEXGa60P0uCRXTPG35JUP8/x0LAV7TTMdvm0Vkwlw8aD3adWt5gilhtBE7q2FUWykpsf6+r9+wY3Kh6Fu8XwqtTtYAn7/hcPHeuB51yJFHc4fgHeB253qdiUWFhO/NhBuZ3Lg/Nj5MKiV1Cbt1OsYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=geZPHyLb; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748268360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4/sGzOaVUDnFa7JhGT/QLWfv+Pie+2XGZOuEFBnSP9Q=;
	b=geZPHyLbkIGxuqAKl7X1cdpupmFcJ3Jo7W1sGAfOWtS8+/kIogQu54+Rn4YQzmI69qgHHA
	Q+qPn7nag/Seu0pu2TIKVEXTAn4CTHEVXo5UUGDt6fxZd7ebMU9iODBsrYds0nX0lQQhfN
	P4x81ucPmbNSsPJZ5SMPNAwFSM6AsnM=
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
Subject: [PATCH net-next v2] net: phy: Add c45_phy_ids sysfs directory entry
Date: Mon, 26 May 2025 22:05:39 +0800
Message-Id: <20250526140539.6457-1-yajun.deng@linux.dev>
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

Add the new phy_mmd_group, and export the mmd<n>_device_id for the C45
device. These files are invisible to the C22 device.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v2: Only one vale for per file and invisible to the C22 device.
v1: https://lore.kernel.org/all/20250523132606.2814-1-yajun.deng@linux.dev/
---
 .../ABI/testing/sysfs-class-net-phydev        | 10 +++
 drivers/net/phy/phy_device.c                  | 62 ++++++++++++++++++-
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-phydev b/Documentation/ABI/testing/sysfs-class-net-phydev
index ac722dd5e694..c97029d77b16 100644
--- a/Documentation/ABI/testing/sysfs-class-net-phydev
+++ b/Documentation/ABI/testing/sysfs-class-net-phydev
@@ -26,6 +26,16 @@ Description:
 		This ID is used to match the device with the appropriate
 		driver.
 
+What:		/sys/class/mdio_bus/<bus>/<device>/c45_phy_ids/mmd<n>_device_id
+Date:		May 2025
+KernelVersion:	6.16
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
index 0f6f86252622..5678191fb283 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -645,11 +645,69 @@ static struct attribute *phy_dev_attrs[] = {
 	&dev_attr_phy_dev_flags.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(phy_dev);
+
+static const struct attribute_group phy_dev_group = {
+	.attrs = phy_dev_attrs,
+};
+
+#define MMD_INDICES \
+	_(1) _(2) _(3) _(4) _(5) _(6) _(7) _(8) \
+	_(9) _(10) _(11) _(12) _(13) _(14) _(15) _(16) \
+	_(17) _(18) _(19) _(20) _(21) _(22) _(23) _(24) \
+	_(25) _(26) _(27) _(28) _(29) _(30) _(31)
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
+#define _(x) MMD_DEVICE_ID_ATTR(x);
+MMD_INDICES
+#undef _
+
+static struct attribute *phy_mmd_attrs[] = {
+	#define _(x) &dev_attr_mmd##x##_device_id.attr,
+	MMD_INDICES
+	#undef _
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
2.34.1


