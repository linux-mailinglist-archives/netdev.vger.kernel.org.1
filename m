Return-Path: <netdev+bounces-193027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164BDAC23C7
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5D31C05F2E
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA21291169;
	Fri, 23 May 2025 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wjL9yVwj"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547CE1FDD
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748006799; cv=none; b=n7XoE2WQjpUvmiacDK9Jt2mVuE2OKUvh3e7HpLvBYp23tLxEYSQ8Z/+ePEnJmQJiSTWToR36rH7Hfh4lvZCLIZINfgBrqDPj0L83RQCfVK9sI2XgJl+uMkMO8DZXFU6Nz5HYx1wHM+h3UeeP3sPX/3C++hYznrnvPRPg5mSEG20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748006799; c=relaxed/simple;
	bh=hl8X2acmHMO6KmiHT6RV7Az2pRAzxdafh4QMGCM63nI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hhYB64alokvDynjo/CHxbbaaH852YnYZo2Fveachuyj7sbrrpLQYim2datflm46+/zl+UlVqMZb7/9azQhstA7HJ5me7jtGSnZvDtnNXvW61r5tuSmAqF90xkP1j17lq9wrgHfWEl0HLD4zPXUmudADRTytmSSeQLBfxnEyVcIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wjL9yVwj; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748006784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YHM8UbBSJvcdfK4Kdm7M9Q7vGmBWfQnpZzojYQ/jzD4=;
	b=wjL9yVwj9ja77ckyTqtn5mCZVUWq7/9LfPpZDIEEmqV8GcItBv/JU0iSUlw6wXk3CjrxF1
	K4f5GfQ2lSxEF5eporHgm6ks2t6EL/kMCDro8wFg20sbyLBAE3blA4z1KPapEAzMfCuqi/
	7rHpdLpU/+/fxAGnPyjCeHLEy1+kek0=
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
Subject: [PATCH net-next] net: phy: Add c45_phy_ids sysfs entry
Date: Fri, 23 May 2025 21:26:06 +0800
Message-Id: <20250523132606.2814-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The phy_id only shows the PHY ID of the c22 device, and the c45 device
didn't store the PHY ID in the phy_id.

Export c45_phy_ids for the c45 device.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 .../ABI/testing/sysfs-class-net-phydev         | 10 ++++++++++
 drivers/net/phy/phy_device.c                   | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-net-phydev b/Documentation/ABI/testing/sysfs-class-net-phydev
index ac722dd5e694..f6194fd6927c 100644
--- a/Documentation/ABI/testing/sysfs-class-net-phydev
+++ b/Documentation/ABI/testing/sysfs-class-net-phydev
@@ -26,6 +26,16 @@ Description:
 		This ID is used to match the device with the appropriate
 		driver.
 
+What:		/sys/class/mdio_bus/<bus>/<device>/c45_phy_ids
+Date:		May 2025
+KernelVersion:	6.16
+Contact:	netdev@vger.kernel.org
+Description:
+		This attribute contains the 32-bit PHY Identifier as reported
+		by the device during bus enumeration, encoded in hexadecimal.
+		These C45 IDs are used to match the device with the appropriate
+		driver.
+
 What:		/sys/class/mdio_bus/<bus>/<device>/phy_interface
 Date:		February 2014
 KernelVersion:	3.15
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 781dfa6680eb..eecd8273111c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -581,6 +581,23 @@ phy_id_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(phy_id);
 
+static ssize_t
+c45_phy_ids_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct phy_device *phydev = to_phy_device(dev);
+	const int num_ids = ARRAY_SIZE(phydev->c45_ids.device_ids);
+	unsigned int i;
+	size_t len = 0;
+
+	for (i = 1; i < num_ids; i++)
+		len += sysfs_emit_at(buf, len, "0x%.8lx ",
+				(unsigned long)phydev->c45_ids.device_ids[i]);
+	buf[len - 1] = '\n';
+
+	return len;
+}
+static DEVICE_ATTR_RO(c45_phy_ids);
+
 static ssize_t
 phy_interface_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -618,6 +635,7 @@ static DEVICE_ATTR_RO(phy_dev_flags);
 
 static struct attribute *phy_dev_attrs[] = {
 	&dev_attr_phy_id.attr,
+	&dev_attr_c45_phy_ids.attr,
 	&dev_attr_phy_interface.attr,
 	&dev_attr_phy_has_fixups.attr,
 	&dev_attr_phy_dev_flags.attr,
-- 
2.25.1


