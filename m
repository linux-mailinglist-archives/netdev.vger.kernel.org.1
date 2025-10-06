Return-Path: <netdev+bounces-227918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C27BBD900
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A3634EA57F
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A521C9F9;
	Mon,  6 Oct 2025 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qhinL8UW"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFF1CF96;
	Mon,  6 Oct 2025 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744922; cv=fail; b=BH/j501S3IcEx40VVAichUEkNWvMmkF5ogSWEhcZpy4FXkVlI53W2yFdvizW4AJC4mFqAZCubL5J6uO7RL1qBJFKY0H3nmlrzaooGaGYU5Ft9pLjlw/QFVVZ8xSWFqyaXW0wYZB6RV66xxa5QET7bWOPcFRxmPuf39VEi6ZdjgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744922; c=relaxed/simple;
	bh=LF8xDuKU1DSwtKnPKIeulRAoKY8OYNWMasU6vxkwOpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNLCbzK5t6oJHAHfZ+YppUap1P6lG/Ix0CTWeTcAWeYx4fz1KIYA5ug0ylSXKyObY+FXqYFbXHLoaILQcHneMQjgAA4eHPM5btq8XXrduDxaBaa1Tmvb9tXHXeYhFiKgHQNQe1HauLTgmcAquWOdGCi6TlY4pPLYubjsHFUFjcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qhinL8UW; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVwKsG7CH0Q8yxUZSv+six36F/pE9So1C0O0fliIrwkYgtGNWYZRSaGDgg/6I/BaOmQBAzl6eSeUZFNwU4qWk32a/zSzt3Aoy45NhbMiHivyesq5zocea0VoybAhLVSqwcXrKj18v/Y/bvMDkC7OQOxD9GM181kqqbv6kTodp911qiaoi6zBpfl70vbB0vpAxJbe7i1KjgCkpaW/h92n/kqQ/Z6JdFjeRgQv56AZ6I7tCUCULg5IpxIioXz+Lyp49UF3Jxef/aDnmGZwOmrEBaE4fUx9rOOGT6fGTxn2oHupCPeNHYCxm3JjTltZZ562R81Meddn/FbLuhbHucHn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei5CNKePP3+HnA6hHAVqCfZTFRfqDBPYb1y66EVlTfY=;
 b=NOkWuv8gQ0DKYD/rs9jUkh2Kc6YFRC/uFGh/WkS+wzvfOyILJju9n95LVeG8CY2yniLZMIlShPTd55zeIXph8IJd57ppswOn00ntft6POzFQ0bw+IkcDuQeNNUAAFdHGxm8/jiVtpvVmArn3xybUnhtPWfNrhc5h7UIV1UHKcZhjlOJv8mlMlqbTQo/myvBeHsWyP4ckAoA2sB2gu/UOIo2ld0KAWZwO8i12nf9K04CBsoMO/2xh41mIXU7lAiTXvJzkEX6uLfBXLWokitYjpvoHx1DS72KCxBZXfKpN8z8/bBV2kJeqFExBOVva7CHgxqoFesY8peDb2KmaOQkcmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei5CNKePP3+HnA6hHAVqCfZTFRfqDBPYb1y66EVlTfY=;
 b=qhinL8UWT6+7zP32DU9yPqANfvx/GDAh4ifdaDvfsQR3yZpLBFTGLevKRNIa3rqR2HjFNs49vFHJaaTuTjAheDv6jNWgC9MyGi90+juAoePyY7f+OxXZHY5+uxJ8iBYyxizmJdAm0hfcsUL4EK+V9UJQdmQ10Wm187GrMIzOs3M=
Received: from SJ0PR05CA0122.namprd05.prod.outlook.com (2603:10b6:a03:33d::7)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:01:50 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::72) by SJ0PR05CA0122.outlook.office365.com
 (2603:10b6:a03:33d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Mon, 6
 Oct 2025 10:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:01:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 03:01:49 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 03:01:45 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:01:44 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v19 01/22] cxl/mem: Arrange for always-synchronous memdev attach
Date: Mon, 6 Oct 2025 11:01:09 +0100
Message-ID: <20251006100130.2623388-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: dd55c74f-69bb-4edc-3883-08de04bf5e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AZQoKjmR26bwBggSCxqjBRlO5OlKUVQ4u2cwsst83FpjnE9qn5ZSfwTguuCZ?=
 =?us-ascii?Q?d0e48scy+2576Ye1sMxywb4LOvogsfmBIUNgWS9nDzdm+jksUZe2WPKIMGPp?=
 =?us-ascii?Q?GdXbvwP4o86jhvxCb9rbKWXjuWHwTqRg3KGLFZ0QMZg0taxtPExQSixyPLee?=
 =?us-ascii?Q?H6Nv+kXEfXd0/27le67zbywfgAtjzx0bSSdYlXK/R0JoaKilxktRZzZQ3yGI?=
 =?us-ascii?Q?FGSeDibNC1uvsGs409QQb+eWONXtMz79W/I1tBakUlF5j8BDFWUurhObv9sS?=
 =?us-ascii?Q?KiEjvbYk+cbfJgprT2gEc55aSBYLZVs1vEnuB1zV/B2xlezlI24n6qgXTTC+?=
 =?us-ascii?Q?59bSVQ7JBLspaFBCo2KMb6lbL6+yc3AvVucueEr74QlBdG4poXdjEUeVQDwq?=
 =?us-ascii?Q?Juap5uqJGGLSXLb+a6VaXHyoLpq7u2OSeq0+3e3fsh1Zq4ZXObZAFao/cVmC?=
 =?us-ascii?Q?3UJNnEZUnV+Alt5rb2GwEobjzytFRqDJmg/YkQh2O/IyRW17MtQKGhaC+F7I?=
 =?us-ascii?Q?C2U7YkwO+pRurufTJJ4FCP+JczUPDkfXwpeJ6zhM3f+ze4EoPf3Ag47KZb5E?=
 =?us-ascii?Q?3IDsJqtj1wDUq7MXUymvQGUOp8a8EzwiJq5Zb3803SyHXu4jbOdrHCF8Es9l?=
 =?us-ascii?Q?nvkSV+yz/1YE5/cRhMaFfL2JKMU4mfIqNfRZF4BTcf6lcqTii1Fi1G6owYJ+?=
 =?us-ascii?Q?r1pkIIMvT4Eg7qYT0lt0sUz7jMIVVNtPJ3h89tCT2ErVLSqhfIade6XF/YfS?=
 =?us-ascii?Q?vuOZ1/DVlexmAqWSYxPKRwLbre9bMKZgWBaYuPQShmf1xfvz68zrCPcPVaNo?=
 =?us-ascii?Q?cW7Sq0wREf1zpcXeLF55EY09/HITHs3NBt1W5+8h53NuialF9LTImL6XW7fl?=
 =?us-ascii?Q?GnbMxMuP8chtu0hocGsvAvTV+b25vbdZTyf2z40NvijQODUTTqFNg1qenO9d?=
 =?us-ascii?Q?HN57lhVKJeYyrfIyX8c5bdmfBZfji8BBWu7dcfZmYePhGva1pKH/8ysJNdbz?=
 =?us-ascii?Q?YJC+3dA1GrOjbwNCJSwLp6ZUzuN5ZgGKb2EGqGl9o5s5fEWXMWPfwQOpRQsI?=
 =?us-ascii?Q?efDJogRZsBZmigytKckzirv7enM/dLGY2uF1JN3ryYyTopu0xuDcmV+53W+0?=
 =?us-ascii?Q?7yTow0RZChOXduqEykrUvCQaFbtmopf760ovHlNkmsidTb4m1BwXkGnpQpw7?=
 =?us-ascii?Q?OcSr5SMiQnaPf4IDSuRRMPUe4RpGjDugCmTJHNI2dgVdyKq+YbVEmeud6MKO?=
 =?us-ascii?Q?x3CqESdUN/693PZPvDEFBRAKgS+Li5A+X+ZgSoQnWgBUPF9QSv9rNBk2q4nj?=
 =?us-ascii?Q?N6men+i425Rs1bFd8VLWdcFVnTQOFC4r4pi/rRzXwDmdJZFaMgZxGKEPRktM?=
 =?us-ascii?Q?PrGfSuSOQLY4VZ+10DIEB94lfDYXsg0amkBCQVHf+xva9DTAJuQ2FFRp1s/U?=
 =?us-ascii?Q?URqaElZ9ivw4ZeQBFNibvdOieRrjhDXlikLiUKxpQd15Un0XNqPEU5ypdpCb?=
 =?us-ascii?Q?RJ12bVeuZgjmyPJxNpNiJOnajAX0w0YY4nWkMPECqMSS0GXJL3JQhgq8b5W7?=
 =?us-ascii?Q?o5PCXUz+XtJJJUC1c4U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:01:50.1263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd55c74f-69bb-4edc-3883-08de04bf5e6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285

From: Alejandro Lucero <alucerop@amd.com>

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
 drivers/cxl/Kconfig       |  2 +-
 drivers/cxl/core/memdev.c | 97 ++++++++++++++++-----------------------
 drivers/cxl/mem.c         | 30 ++++++++++++
 drivers/cxl/private.h     | 11 +++++
 4 files changed, 82 insertions(+), 58 deletions(-)
 create mode 100644 drivers/cxl/private.h

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 028201e24523..111e05615f09 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -22,6 +22,7 @@ if CXL_BUS
 config CXL_PCI
 	tristate "PCI manageability"
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
index c569e00a511f..2bef231008df 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -8,6 +8,7 @@
 #include <linux/idr.h>
 #include <linux/pci.h>
 #include <cxlmem.h>
+#include "private.h"
 #include "trace.h"
 #include "core.h"
 
@@ -620,42 +621,30 @@ static void detach_memdev(struct work_struct *work)
 
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
 
-	cdev = &cxlmd->cdev;
-	cdev_init(cdev, fops);
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
@@ -1023,50 +1012,44 @@ static const struct file_operations cxl_memdev_fops = {
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
-
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
index f7dc0ba8905d..144749b9c818 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -7,6 +7,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "private.h"
 #include "core/core.h"
 
 /**
@@ -203,6 +204,34 @@ static int cxl_mem_probe(struct device *dev)
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
 	.probe = cxl_mem_probe,
 	.id = CXL_DEVICE_MEMORY_EXPANDER,
 	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.dev_groups = cxl_mem_groups,
 	},
 };
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
new file mode 100644
index 000000000000..bdeb66e4a04f
--- /dev/null
+++ b/drivers/cxl/private.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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


