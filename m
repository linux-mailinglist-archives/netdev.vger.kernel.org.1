Return-Path: <netdev+bounces-243780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2791CA776A
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D9EB307B08F
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50F232C943;
	Fri,  5 Dec 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pzhBQYOr"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A03271E0;
	Fri,  5 Dec 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935591; cv=fail; b=AXr1BIrbbao4ZEoHPcfO1ypg0Blrk9KWHlQUtH/IXWzV3HNuzVX1R0qwnDv6nwm+FX0KFmUsMhSUga+Qljh2/CfE6c4Wvv40RPLyaV+b3wGAQHEcpUZfDhYCBdvIxtzCq2dHJykxrlyYcodGqwPRsRTjIZjO0xt09aEBfmTTDVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935591; c=relaxed/simple;
	bh=Ny2Q8I/XA6CPb1JnSBnRnt7TjOi8CeOOPQ+3LATAv3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdcIarntEjKI9CPtrNRMWXrnmBMXlyRdJWnnnLItWXTuimBbzHRC1aCfas/OHF1isLMnw7RckjZANiMqEQ7es/TFfUO/JD+uMt3tVSZ0HJU/LjpZq9GKa3+PrVOiAHsQKfKsEMojWA4Q/mWnhXjhXYkZRCxHSsnjiyw0k/eQjHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pzhBQYOr; arc=fail smtp.client-ip=40.107.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVExOa9uh20OpRzoAIJzLQn3Bl/wWGrFPTFQXoqFdf9tXW5LkWWV+CI2HrC/lZ4S0igDqQCawWGUfpspvrFx19HChzDN9VCw5eUGT91FJ1c4/wz+xfwXskRS82XmUa5RDP/5x04kkwniyDPESneGzXZVZ33qGlZOD2AZI3eEjmJ0xrB32DCGjmmcqj0vy8ZKqjfGV/oR7HO9LWt1sJjczRu5aerY6ZFstvqv8VzwGHDXHmne/N8g+/p5bKrOTGZHTCdF9jK4zbx8BdefxUjnsY6C28KWrFPguUHnKUUU2eS7pkQvhJ/2tgv1ocu3Z6OkYtTryjxjbBccDvH/XNdtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz/oiL98v37KpMevfJcO1UlN5t1krYQZ5BMuQTbCu9U=;
 b=V6Tyx6iHmaWbLJGEs6R2s9nSOca4kzlqCgUQkDFy2aOFegg0qsNhUf1jm/G2bv6pzhfmZTQLZXtIernsH2+LrHLf8EwiLa35t+9sa0w7bjFY0HZF7Rb44e30zv/9Ewf8GSg26xFjVCi+wluP5uvT7YuugbGKsg/kshOw7OOjDDkev3EVP8RXUt84KlA0OE7s8OSZsFjdldYiWu7X4swwtLaTgUri5oPEjgXHoSBSKF8Fw1rBbDl+I+FXNSDn9LWmzqHi1v2sr6rbeAP39jLwe5ehKWWEs8ggVTqheN2Vzs3L6KjnTHHNR1WPWV+gd8ww49J/TbqXZ1lWt/o13sGgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz/oiL98v37KpMevfJcO1UlN5t1krYQZ5BMuQTbCu9U=;
 b=pzhBQYOrgdNNszZQiZoB3I3OfM7mFQXNaJRuXM9brj1TaVNOWTFzo2O+sXzbzV+W5G+hhIfXYWwOHEi1+9voAR2SXOnDZNdVcynVXQUbP3tzJyLcHc5tSO4dTzEVdX6m+1gyk06OCGMPRizLf+jxX8o7Pxiv7XDpz68RYNheSJ4=
Received: from BY3PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:39a::12)
 by DS4PR12MB9562.namprd12.prod.outlook.com (2603:10b6:8:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 11:53:00 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::9f) by BY3PR03CA0007.outlook.office365.com
 (2603:10b6:a03:39a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Fri, 5
 Dec 2025 11:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 11:53:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:52:59 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 03:52:59 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:52:58 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Dan Williams <dan.williams@intel.com>
Subject: [PATCH v22 01/25] cxl/mem: Arrange for always-synchronous memdev attach
Date: Fri, 5 Dec 2025 11:52:24 +0000
Message-ID: <20251205115248.772945-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DS4PR12MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 311ae2ad-19f4-4ef8-f704-08de33f4d6be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?on8peyKfmMV55vtrzySH22aUbKG1NFJ0CUdSAmS7XtPTKyHzqC7lEZPNEHw+?=
 =?us-ascii?Q?zKr2UvBJNyBvF1qc6acb+Q/6+nmaoqKD32w9UQX6+FgADi9Xt1pq4K3oTgK4?=
 =?us-ascii?Q?UUBgiNCqN0ZS+kDlX2BuSTQETa3htUZdTJN+6+hNWDsZ8IYvF1bIDufxXG6P?=
 =?us-ascii?Q?D8+IWHTHQ4z3Q3eoi5mdReEds7DdDiz0vAI5qooziPAN3NRnvjV9nT6f8RW6?=
 =?us-ascii?Q?L2bPg5gstgw31jPSA6jSPFXwyJFjGKQH88egmliyyfAhmGC3Ha23VjAuAe0i?=
 =?us-ascii?Q?nPcDfKi5C5s6rnCKUqHKZDIgRHx/WVNi1qUJpNAhJ/oCfcxil94Bx4/UIf1M?=
 =?us-ascii?Q?lar4/e5caIAyPolcFZSHVW9vSIVmkP4u3p0QptTUsk5l5a2SiV8Z718wtG8d?=
 =?us-ascii?Q?QLop4SYPPMDot7ynQEp4dcc95cO2Yu+9dJ5o6klfSSfcrbVijMDGxhrHjqYx?=
 =?us-ascii?Q?pyVozbvVN6VSNsuBnWnPbrDoNrpJvH+q1a7jIGk6SrrBzOunn+NWRK3NdkTH?=
 =?us-ascii?Q?NwXlSdC0tA7GZYt7pH+omXoGbrXpj/OirxvHECk/5vsGv1bjxoMcy4RaFBB9?=
 =?us-ascii?Q?BAbfADauHb02zdpXAitypll/TnXilg/IPnGQmLc+neeYI385N2jSVhoZGxGR?=
 =?us-ascii?Q?SwDvNbnBXMxdTJtQzWC8DosbkonblLZLV8Jy3iKJBnb1Qzc1sj3QbRmv8qvx?=
 =?us-ascii?Q?hBB+WsJICCMxjU53LSmOkENB8zaaIHE183FZGWGrykO9Y1rrGp5xH1oxHE5W?=
 =?us-ascii?Q?XVM+BkKfas6BwZl7aigWungMVQb4zn3dap9z8s2M+T70j84pbNZ+LAtVUdZU?=
 =?us-ascii?Q?L5GnsjWZ8blpS2yPwJrhv3emMLVhDc5F6osHmmDv8qMR+DuD/FesIgWb6pXb?=
 =?us-ascii?Q?3zL9kqpxwwjyeOdY6Fer3looYgr1s08vYYvjA+BLq2Tx19Niw7ssZoLOoCyO?=
 =?us-ascii?Q?iVMIN/lWtjfZ6/+xSkZrT/4XOEHDks59F5FFAaEZhylJP9CxSmf7aEBlCY5j?=
 =?us-ascii?Q?5xQERPLQx8uODgckZntVSWKawSXLzErLZ4taeMmBfI3z5kF+oGJgjdzgGpn3?=
 =?us-ascii?Q?dX8amsLxQ7V24EJ4jVp0pFSdLcgYLHfNsl0fOUgX44cBVre6JVriXqL50NYt?=
 =?us-ascii?Q?R6rClDtkbw/6UZwD12T3nttgPF0PaJ/4U+TnQBmuw/iFf3dzwZ975MGQUDUr?=
 =?us-ascii?Q?doCeF4SLN4jOFskxwzEoVPPn8n+yJtwLLoBDlKtYEzQosliCErDqbhRWG8Y+?=
 =?us-ascii?Q?5ZDs6cEslzYRifaLoVGuIZTTm0OxdGfsXLykzVnphFiI8G1NiZhbuLuDRT3m?=
 =?us-ascii?Q?GFG9DSg6WZqqal0zqS/YeHXyE+KHJKWn9rdXNY5zwD7vkWIGDOZKN//BJoJW?=
 =?us-ascii?Q?iBVZyxazmx533rAw654A60s45mGilYpRAzZJO5xjCYhTZSv00C9aVeVwcxcm?=
 =?us-ascii?Q?NRxjXJ1yao6EkByekxqXBurL4m9926B4NfkqH3cAVBS7DwqVC4qD34or4g7i?=
 =?us-ascii?Q?6wZXoHp4qrxlFMWFdogp8vFvgNqIhKIvjJHeiP1PHswKAlb5e3spDUf58wWg?=
 =?us-ascii?Q?MKn62BidOh6MQa79Dbo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:00.0274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311ae2ad-19f4-4ef8-f704-08de33f4d6be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9562

From: Dan Williams <dan.williams@intel.com>

In preparation for CXL accelerator drivers that have a hard dependency on
CXL capability initialization, arrange for the endpoint probe result to be
conveyed to the caller of devm_cxl_add_memdev().

As it stands cxl_pci does not care about the attach state of the cxl_memdev
because all generic memory expansion functionality can be handled by the
cxl_core. For accelerators, that driver needs to know perform driver
specific initialization if CXL is available, or exectute a fallback to PCIe
only operation.

By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
loading as one reason that a memdev may not be attached upon return from
devm_cxl_add_memdev().

The diff is busy as this moves cxl_memdev_alloc() down below the definition
of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
preclude needing to export more symbols from the cxl_core.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/Kconfig       |  4 +-
 drivers/cxl/core/memdev.c | 97 ++++++++++++++++-----------------------
 drivers/cxl/mem.c         | 30 ++++++++++++
 drivers/cxl/private.h     | 11 +++++
 4 files changed, 83 insertions(+), 59 deletions(-)
 create mode 100644 drivers/cxl/private.h

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 360c78fa7e97..94a3102ce86b 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig CXL_BUS
-	tristate "CXL (Compute Express Link) Devices Support"
+	bool "CXL (Compute Express Link) Devices Support"
 	depends on PCI
 	select FW_LOADER
 	select FW_UPLOAD
@@ -22,6 +22,7 @@ if CXL_BUS
 config CXL_PCI
 	bool "PCI manageability"
 	default CXL_BUS
+	select CXL_MEM
 	help
 	  The CXL specification defines a "CXL memory device" sub-class in the
 	  PCI "memory controller" base class of devices. Device's identified by
@@ -89,7 +90,6 @@ config CXL_PMEM
 
 config CXL_MEM
 	tristate "CXL: Memory Expansion"
-	depends on CXL_PCI
 	default CXL_BUS
 	help
 	  The CXL.mem protocol allows a device to act as a provider of "System
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index e370d733e440..3152e9ef41fc 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -8,6 +8,7 @@
 #include <linux/idr.h>
 #include <linux/pci.h>
 #include <cxlmem.h>
+#include "private.h"
 #include "trace.h"
 #include "core.h"
 
@@ -648,42 +649,29 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
-static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
-					   const struct file_operations *fops)
+struct cxl_memdev *devm_cxl_memdev_add_or_reset(struct device *host,
+						struct cxl_memdev *cxlmd)
 {
-	struct cxl_memdev *cxlmd;
-	struct device *dev;
-	struct cdev *cdev;
+	struct device *dev = &cxlmd->dev;
+	struct cdev *cdev = &cxlmd->cdev;
 	int rc;
 
-	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
-	if (!cxlmd)
-		return ERR_PTR(-ENOMEM);
-
-	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
-	if (rc < 0)
-		goto err;
-	cxlmd->id = rc;
-	cxlmd->depth = -1;
-
-	dev = &cxlmd->dev;
-	device_initialize(dev);
-	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
-	dev->parent = cxlds->dev;
-	dev->bus = &cxl_bus_type;
-	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
-	dev->type = &cxl_memdev_type;
-	device_set_pm_not_required(dev);
-	INIT_WORK(&cxlmd->detach_work, detach_memdev);
-
-	cdev = &cxlmd->cdev;
-	cdev_init(cdev, fops);
+	rc = cdev_device_add(cdev, dev);
+	if (rc) {
+		/*
+		 * The cdev was briefly live, shutdown any ioctl operations that
+		 * saw that state.
+		 */
+		cxl_memdev_shutdown(dev);
+		put_device(dev);
+		return ERR_PTR(rc);
+	}
+	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
+	if (rc)
+		return ERR_PTR(rc);
 	return cxlmd;
-
-err:
-	kfree(cxlmd);
-	return ERR_PTR(rc);
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_add_or_reset, "CXL");
 
 static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 			       unsigned long arg)
@@ -1051,50 +1039,45 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds)
+struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
 	struct cdev *cdev;
 	int rc;
 
-	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
-	if (IS_ERR(cxlmd))
-		return cxlmd;
+	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
+	if (!cxlmd)
+		return ERR_PTR(-ENOMEM);
 
-	dev = &cxlmd->dev;
-	rc = dev_set_name(dev, "mem%d", cxlmd->id);
-	if (rc)
+	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
+	if (rc < 0)
 		goto err;
 
-	/*
-	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
-	 * needed as this is ordered with cdev_add() publishing the device.
-	 */
+	cxlmd->id = rc;
+	cxlmd->depth = -1;
 	cxlmd->cxlds = cxlds;
 	cxlds->cxlmd = cxlmd;
 
-	cdev = &cxlmd->cdev;
-	rc = cdev_device_add(cdev, dev);
-	if (rc)
-		goto err;
+	dev = &cxlmd->dev;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
+	dev->parent = cxlds->dev;
+	dev->bus = &cxl_bus_type;
+	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
+	dev->type = &cxl_memdev_type;
+	device_set_pm_not_required(dev);
+	INIT_WORK(&cxlmd->detach_work, detach_memdev);
 
-	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
-	if (rc)
-		return ERR_PTR(rc);
+	cdev = &cxlmd->cdev;
+	cdev_init(cdev, &cxl_memdev_fops);
 	return cxlmd;
 
 err:
-	/*
-	 * The cdev was briefly live, shutdown any ioctl operations that
-	 * saw that state.
-	 */
-	cxl_memdev_shutdown(dev);
-	put_device(dev);
+	kfree(cxlmd);
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
 
 static void sanitize_teardown_notifier(void *data)
 {
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index d2155f45240d..ac354fee704c 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -7,6 +7,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "private.h"
 
 /**
  * DOC: cxl mem
@@ -202,6 +203,34 @@ static int cxl_mem_probe(struct device *dev)
 	return devm_add_action_or_reset(dev, enable_suspend, NULL);
 }
 
+/**
+ * devm_cxl_add_memdev - Add a CXL memory device
+ * @host: devres alloc/release context and parent for the memdev
+ * @cxlds: CXL device state to associate with the memdev
+ *
+ * Upon return the device will have had a chance to attach to the
+ * cxl_mem driver, but may fail if the CXL topology is not ready
+ * (hardware CXL link down, or software platform CXL root not attached)
+ */
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds)
+{
+	struct cxl_memdev *cxlmd = cxl_memdev_alloc(cxlds);
+	int rc;
+
+	if (IS_ERR(cxlmd))
+		return cxlmd;
+
+	rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
+	if (rc) {
+		put_device(&cxlmd->dev);
+		return ERR_PTR(rc);
+	}
+
+	return devm_cxl_memdev_add_or_reset(host, cxlmd);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
+
 static ssize_t trigger_poison_list_store(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t len)
@@ -250,6 +279,7 @@ static struct cxl_driver cxl_mem_driver = {
 	.id = CXL_DEVICE_MEMORY_EXPANDER,
 	.drv = {
 		.dev_groups = cxl_mem_groups,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
new file mode 100644
index 000000000000..eff425822af3
--- /dev/null
+++ b/drivers/cxl/private.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2025 Intel Corporation. */
+
+/* Private interfaces betwen common drivers ("cxl_mem") and the cxl_core */
+
+#ifndef __CXL_PRIVATE_H__
+#define __CXL_PRIVATE_H__
+struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds);
+struct cxl_memdev *devm_cxl_memdev_add_or_reset(struct device *host,
+						struct cxl_memdev *cxlmd);
+#endif /* __CXL_PRIVATE_H__ */
-- 
2.34.1


