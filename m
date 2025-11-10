Return-Path: <netdev+bounces-237227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA21C47953
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FB318893FC
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7101B153BD9;
	Mon, 10 Nov 2025 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NJ16JCWs"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322825B663;
	Mon, 10 Nov 2025 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789034; cv=fail; b=qYr8xdqNyyoQwvSvZLROJ+Ntv8hO1h57/KRFWk3v1PbHy2ACyOro5wRM0dZRYIyojtea9huv20N89PwB2N+r0A2GLc2cRz02EXywcl3ZH56KLki+mFE3604L112numdKCUjXgZXv0pRNFJyBrUxZH+xPj0sPg0BNds03orMb7SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789034; c=relaxed/simple;
	bh=WZYOGMBxSTtW8PWNWdf7dKTHneeXu2KQ4+WKAkJLPnE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQ7g3R8yGxW9z4cKVHpSVQWmZAtpBX2+QA4EbpwJX4Zl1WZlz3icBUuO/THEeOKp1nHPZ0no03HbrF08EuOGvyhgfqIXlQd1AnKe756iHhMjTMyMGYG4A2eTEfmvtmWllZ2GrqbKC/DMGpuhY5cS2D9H9NFhY85gxutigBnqc7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NJ16JCWs; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rU/adG6YP5949OvsNZwJKdfzR326dtp39jcYxKyj+kXLcvzjSA1ivXEfqWwWeeeSupbqJeSduTCcajSfSGQ06gQMO4R0HfU9JBTSYxgrd+qImfQh0i8I84wdjp4bi5U/rVukF1+ggTGJgKNduDEy9RN3qwbHCXeycQNvkZ4GYs01L7+jcTfMTyx0oJcofZbK/1okwYmk2RMisSXYs08EjO9lK9XSospIZ4Gl5JY5GQsX5CaoOAaexe4LY2+Gj2tPyBQr737CcdPyvUiQkK7XUql/kzW10OK63n0MJnLRZ+QjuDaTnXjZFvI7iaflcpbwOMdEIxQfpr2PwSauBbQ9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svLZMRrlcVRBrU6xXPpeIqLdNLHjtje2mQCA8Z/eIN4=;
 b=JcTBKXIvHYr7Ytf0y7nu0+epH6YvcGE+GU9rCpcu6BCQACJak14Dso9v6eUL9xjirMecRXxrIpgxXmTTT4Y+AYxJMmfxe0IPwutXT7W0oU16KGpO3EWrAT6eH1Whcqeo7/6npCOV/8lMLTfr4sH09lvKVa94g8bFOm6znujT9WKpSSGvzfQVG7EVrdnWcncjBFMOStRPIjFWsB6FDBvN9+AmrWeUenPh0/Gk+zCCMIwepCZ9S8CWhjcqtPn4+Dru7Puv46JEykK0fDiPGC31wF5zkE5rhzRmFcWj4rD9ajgksJ42pk9PbFmg24Rx9mysuWcs4Vox79aX2U5NmeES2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svLZMRrlcVRBrU6xXPpeIqLdNLHjtje2mQCA8Z/eIN4=;
 b=NJ16JCWsi3VfqtDvaR2qy93wDqI5UMELqkSUwSTHnH7g7Hm+CUdocbnG6x6Ltu9chahOWloDD3MnyUKzQ32MlhHoKJqfr2wf6rx+g2z3D71liRzruXs4dOyFSjkdx3ZWnOprS8Bj7YoF1XnT0q+vcHIc4opLX1BFq//qbxgpwWc=
Received: from PH8P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::8)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Mon, 10 Nov
 2025 15:37:08 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::9c) by PH8P220CA0027.outlook.office365.com
 (2603:10b6:510:348::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:07 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:06 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: [PATCH v20 01/22] cxl/mem: Arrange for always-synchronous memdev attach
Date: Mon, 10 Nov 2025 15:36:36 +0000
Message-ID: <20251110153657.2706192-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f55bba-af19-4340-8a0a-08de206f022a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hDGkxSYU957Sule52gDfdgrsHhQS/SJD8kCUylAbNRenaJb5Ao07WTGdHAjW?=
 =?us-ascii?Q?Jk6Owe2oEnRFEFeVG8Y6my1VwAyaqCfr+ATb5PmVyLhXvcIMBVqJRdoAuGz7?=
 =?us-ascii?Q?XbQSjsyAyiG4Re1FOzpfTS7NLLsA9+P60TPwgs/mX2UNgTjAPBaqzNm/1I5j?=
 =?us-ascii?Q?lEf2Z0JElRjsWdSlLGOJQvXN2A60rsIXC+mIngHTLLAPbjaYsAUNxNaYWf1F?=
 =?us-ascii?Q?Rrxha57YXH4KOXc2Xf2tKH51o7WHxSLN3vJjl+BHJgE5sjG3l0niTomeghPi?=
 =?us-ascii?Q?v6Kn9F21nKZYb2xGp7AG2sIHp+hzBmT/H8O96sV5Z8koxyiHh4WLixwlt0bF?=
 =?us-ascii?Q?t+TA0F+EO2+h0M89UyAzU8jA42PSwTWEkRC2rgJBeY0JiZixR/sy0gKL3WKy?=
 =?us-ascii?Q?Fm544rpavLOwRns2sVnt21Uwc+6jcrN0+p7tnErORKBTBnXCZ9TtwKRBq/hc?=
 =?us-ascii?Q?bg+9Lf8kiPAiAq6jmJX9mNi2g+VJA4xYZP+fVlzXc4CCK4GslFmaSEVo+FC4?=
 =?us-ascii?Q?eetB/MR3gq7spT6uhYfQNdnnGUVAjNF+1LJTXABHFo9Nk5Ebdebr5sSH7O4h?=
 =?us-ascii?Q?YlJfBdD2237+/DH3jGiJFdRof96TtW/iQVLKn7GV61g3X+5mmTy761V6EYCX?=
 =?us-ascii?Q?7EkB3Cc34CEC2n7Jo6pvphd39f8FjJBiwI3SXubLRu7o2/yjov3DZaH2DD6N?=
 =?us-ascii?Q?UwC8tpI9A7EdVHN1bybHSFhjJA7gUgP0mX0NVXtLYbQmkaMX7IOwB/auKLQM?=
 =?us-ascii?Q?w2DKQ+yCU+4ETwyyQ55+AylUYUaQkdNwRP4wMqEHgGcY5rvnQCjzetn4QtGT?=
 =?us-ascii?Q?CBXYUKxY7aq/1mdjv/f2Z+6fS1F9WYK+buiQsiQf8tGH3UjjbtKS2rkL6ypM?=
 =?us-ascii?Q?k7dFeeDvP+6/MG/JfiuDApXZkYnioNTe98yAPx13w3hI1Y1su4+aeGkllOtk?=
 =?us-ascii?Q?B6+ydARraVjFfHMCGblziumjDbnqHGjoInfMfaXDO3u3hsbolRVnWRGXDkCF?=
 =?us-ascii?Q?cqi3/IxeuD5yfRx78ujxRxiV2mL/XrTVvsEaS+hqTA4jvZkRA4FQdhfxifGW?=
 =?us-ascii?Q?q6z7lTIuaQwMtQhRuXqcoocP9VITGycKb4OO8qTx7w4e7uawzI5bUh1jXdEH?=
 =?us-ascii?Q?ISQc+vSjec7bmd4Nk7j6VgI8bMdtMa4fwCh/0nuYPsfOjylH94mxnCBH8pmj?=
 =?us-ascii?Q?s2LPHvmWpdgEWPyt7RoUTi+26APbZv4uL7poOTmLGNUba2qE3QOv+6vskw+T?=
 =?us-ascii?Q?WmGRJjT+htSAurANGD9YkU/VP9BZ0ZbDoHobpLB+IGl1rKjLC9k4kCqe/kAu?=
 =?us-ascii?Q?D7pPZt5DaUUfOfOCoiKjNtm32gKtfqDNXWnTUzI5RlrCpLtSDugphPNV/oHA?=
 =?us-ascii?Q?Dwaj3XPpXexLmwhhFYL1ntjppLTiqhzhbDXaAJYBJXeGS63nz9YXNrwfnd60?=
 =?us-ascii?Q?EsPBdrXl31YtvCyD5o+zmrfxWUXC7eawzYh1BQE7V82y2pgrANHEIjhsz0dU?=
 =?us-ascii?Q?9GABXrjqHSRVa/6NaMUA+AVeXN3opTprzd8q6jcukUBzHRWYbLQDZCM9dxAa?=
 =?us-ascii?Q?H9krGkOPOVXPkpdGsME=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:08.2354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f55bba-af19-4340-8a0a-08de206f022a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493

From: Dan Williams <dan.j.williams@intel.com>

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
 drivers/cxl/Kconfig       |   2 +-
 drivers/cxl/core/memdev.c | 101 ++++++++++++++------------------------
 drivers/cxl/mem.c         |  41 ++++++++++++++++
 drivers/cxl/private.h     |  10 ++++
 4 files changed, 90 insertions(+), 64 deletions(-)
 create mode 100644 drivers/cxl/private.h

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 360c78fa7e97..6b871cbbce13 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
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
index e370d733e440..14b4601faf66 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -8,6 +8,7 @@
 #include <linux/idr.h>
 #include <linux/pci.h>
 #include <cxlmem.h>
+#include "private.h"
 #include "trace.h"
 #include "core.h"
 
@@ -648,42 +649,25 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
-static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
-					   const struct file_operations *fops)
+int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd)
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
-	return cxlmd;
+	rc = cdev_device_add(cdev, dev);
+	if (rc) {
+		/*
+		 * The cdev was briefly live, shutdown any ioctl operations that
+		 * saw that state.
+		 */
+		cxl_memdev_shutdown(dev);
+		return rc;
+	}
 
-err:
-	kfree(cxlmd);
-	return ERR_PTR(rc);
+	return devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_add_or_reset, "CXL");
 
 static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 			       unsigned long arg)
@@ -1051,50 +1035,41 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds)
+struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
 {
-	struct cxl_memdev *cxlmd;
+	struct cxl_memdev *cxlmd __free(kfree) =
+		kzalloc(sizeof(*cxlmd), GFP_KERNEL);
 	struct device *dev;
 	struct cdev *cdev;
 	int rc;
 
-	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
-	if (IS_ERR(cxlmd))
-		return cxlmd;
 
-	dev = &cxlmd->dev;
-	rc = dev_set_name(dev, "mem%d", cxlmd->id);
-	if (rc)
-		goto err;
+	if (!cxlmd)
+		return ERR_PTR(-ENOMEM);
 
-	/*
-	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
-	 * needed as this is ordered with cdev_add() publishing the device.
-	 */
+	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
+	if (rc < 0)
+		return ERR_PTR(rc);
+	cxlmd->id = rc;
+	cxlmd->depth = -1;
 	cxlmd->cxlds = cxlds;
 	cxlds->cxlmd = cxlmd;
 
-	cdev = &cxlmd->cdev;
-	rc = cdev_device_add(cdev, dev);
-	if (rc)
-		goto err;
-
-	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
-	if (rc)
-		return ERR_PTR(rc);
-	return cxlmd;
+	dev = &cxlmd->dev;
+	device_initialize(dev);
+	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
+	dev->parent = cxlds->dev;
+	dev->bus = &cxl_bus_type;
+	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
+	dev->type = &cxl_memdev_type;
+	device_set_pm_not_required(dev);
+	INIT_WORK(&cxlmd->detach_work, detach_memdev);
 
-err:
-	/*
-	 * The cdev was briefly live, shutdown any ioctl operations that
-	 * saw that state.
-	 */
-	cxl_memdev_shutdown(dev);
-	put_device(dev);
-	return ERR_PTR(rc);
+	cdev = &cxlmd->cdev;
+	cdev_init(cdev, &cxl_memdev_fops);
+	return_ptr(cxlmd);
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
 
 static void sanitize_teardown_notifier(void *data)
 {
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index d2155f45240d..fa5d901ee817 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -7,6 +7,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "private.h"
 
 /**
  * DOC: cxl mem
@@ -202,6 +203,45 @@ static int cxl_mem_probe(struct device *dev)
 	return devm_add_action_or_reset(dev, enable_suspend, NULL);
 }
 
+static void __cxlmd_free(struct cxl_memdev *cxlmd)
+{
+	cxlmd->cxlds->cxlmd = NULL;
+	put_device(&cxlmd->dev);
+	kfree(cxlmd);
+}
+
+DEFINE_FREE(cxlmd_free, struct cxl_memdev *, __cxlmd_free(_T))
+
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
+	struct cxl_memdev *cxlmd __free(cxlmd_free) = cxl_memdev_alloc(cxlds);
+	int rc;
+
+	if (IS_ERR(cxlmd))
+		return cxlmd;
+
+	rc = dev_set_name(&cxlmd->dev, "mem%d", cxlmd->id);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = devm_cxl_memdev_add_or_reset(host, cxlmd);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return no_free_ptr(cxlmd);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
+
 static ssize_t trigger_poison_list_store(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t len)
@@ -249,6 +289,7 @@ static struct cxl_driver cxl_mem_driver = {
 	.probe = cxl_mem_probe,
 	.id = CXL_DEVICE_MEMORY_EXPANDER,
 	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.dev_groups = cxl_mem_groups,
 	},
 };
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
new file mode 100644
index 000000000000..50c2ac57afb5
--- /dev/null
+++ b/drivers/cxl/private.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2025 Intel Corporation. */
+
+/* Private interfaces betwen common drivers ("cxl_mem") and the cxl_core */
+
+#ifndef __CXL_PRIVATE_H__
+#define __CXL_PRIVATE_H__
+struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds);
+int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd);
+#endif /* __CXL_PRIVATE_H__ */
-- 
2.34.1


