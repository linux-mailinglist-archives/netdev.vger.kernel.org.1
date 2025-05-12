Return-Path: <netdev+bounces-189822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF46AB3D32
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BBE166DE9
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43442257433;
	Mon, 12 May 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rg7m9fHZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B202505CE;
	Mon, 12 May 2025 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066287; cv=fail; b=VN3/e3wQfO8wNkiLNAuVhXFPS2Zb5kJRthy2rT0TV/DH0W/GqIOx/15w6pHyf6QCXLB6ItrB4+Gih81zZv+xPTRf2eirRNwVbDIaTwPUeCliCekNH6xooludhNEPZRcOJdyT0xtXe42WF6rrxpKCCTgJ1dMeq7P0zt3uoAlnPG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066287; c=relaxed/simple;
	bh=ihvy9Q4oFhmcOlcR/L2WkaunR5vYuFuDE5h8gzD3Q6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYfIDSBUN1JUFmajrKgGPY1a/SDV0bJluSK5hrOEmxJud3YgChSkxoEpKI/JdciF3V0TiNsi2p1IrYXcZOvNfCiCGQyiMQn/ECXVDTjDycMkOYSRg88zFSvYyIEJ9UuaadjjWr9r0n+KE6APTZ/Cwks+JSV9nZnQWK5AuHjmdTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rg7m9fHZ; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sC9IxH7awd7XdRQhWO8eQPV20L2mAGxoAylMiFrTMQHcjlnumQ4WtVtxsVSxudDvCWcHzQNCNxYzdugWJ/z66ECaHHP8Wir9xxngj2SQ16f6Y/P0pKgoQlmOYW3NlJWKeyojOoDgtDT75SyApduRyV7IULY0mCki2QtADzB9QK/fzofjhVImt5rbKhUGlna5GcZHRbU0ZGFbqa8BdX0K2VJzQzpw8lNlCT4UT5jc0D78QQ0wnmBsYXy3GH5herfBOCd+Qu7gZmTVamYhKN3RYmYc7vp9ppu3iJhGhkX6gUZe2LMDLGUvL9W3caeUx91UpGlp7Jf965mNHJK5K0ZHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3Rd3FKw3eFprmeaFR1j0SzichImCpNusB6pygQO174=;
 b=X5sP9kq5E6FFc6z2xuvG2xbizEfNroZFARGI0of/5BEKKlkcUNL8Z9QWpbQLcVawUgsGCjmnu1prw1OtbxBsUg2sJW1Vh7GNIuAuSBZ62yUFeKpuxulAIsOgRBBIlM9l59mukLohsgPCI70KM3cMPhjX5CCI1M2NLtNAUsRwpyFVtEU9taNbzPoYOsC+BrwhH0X8dF70+ol4yJI/PyYEG9L2anROjWagEwCclyDpO6E2WtGm9q/Wlq6E7n2wu48os2p9VAfZdCNNwsg9tIX5YKgON9+tSQ6OQXsCITcpsA/bCzyiFLPr2QEEp2i4gHRbBFt1LfWCNz1/LQC9sTQC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3Rd3FKw3eFprmeaFR1j0SzichImCpNusB6pygQO174=;
 b=Rg7m9fHZm0rMIcgZ3PvNy1160pqjKHLkexhNSiJcrCJZ6nq5zG6VCWsLVJwKPmbbaNDHPfSG9AJBgE6ubGjiWCtjx/jgd3aL2q+xfzZbrJJb0Zv/tttFONp+5lrkobGQwmm/BT/uPPUQTZR9+PqqZ/iFZxHNZ3QDj2k7DrrTlPY=
Received: from PH8P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::15)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:11:22 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::d4) by PH8P221CA0042.outlook.office365.com
 (2603:10b6:510:346::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.29 via Frontend Transport; Mon,
 12 May 2025 16:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:18 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:17 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 09/22] cxl: Prepare memdev creation for type2
Date: Mon, 12 May 2025 17:10:42 +0100
Message-ID: <20250512161055.4100442-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d0933f-bfab-4867-1261-08dd916fa27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p+rFzeFWnG88yNbe4gTkW5ONdn6HMBkMH2auLzt3fBc9LdvXAC6181d9eyVw?=
 =?us-ascii?Q?uG9C8xDugAoLuraLiHkF+TXO7DODpSQE6bMP09uTGvMIBYNq6I5M4xGTKvAq?=
 =?us-ascii?Q?Cct+C8pcC5G2dn362FFvGoCOfQ3khkUSZWDVXe9ZHPaBFB1f+nOuS1NDS9TI?=
 =?us-ascii?Q?ujYJ2xxUfTuxM3Fa48b6uU97qJEaY4MorCWx9d+Nx2aBrPOK59NDtD6O2GPe?=
 =?us-ascii?Q?UwrJj+evlBUlPaTlQX5uyM9NbmAtTy2apgu28/tmQXua/WMz1u/fki880Dzi?=
 =?us-ascii?Q?ykvZWp1ANH8j8djdRvXajOqmLMTVLspI92oqmDPU9CTAQOZzowMIl2w613I9?=
 =?us-ascii?Q?4iH3rjq1Zz+fzEwcHD9nnvw3ikttb6P1/38lSpQEKnXOWR2kSVjIgm3zYiSd?=
 =?us-ascii?Q?zdJt9g7FNLELVHuqDt0UGJRfHXt8MBOUMNayTzjjDd/leumjGnUxnFOhTNoP?=
 =?us-ascii?Q?5CAx2bbwmH1ivbgSQi0bwLbqJBs6Jvr2ppOuj/h1qC6UdJUKMMtxcN+YwJ+S?=
 =?us-ascii?Q?gF/0QTFZsccGvz48qNM96lKAHLPLK+4t5NaOM718Ski6Wu+uRwwIPyWG1s7B?=
 =?us-ascii?Q?A5WrMjEneg88iLO31Eb/hbnuOCrpkbNalMroUJ6oQQoiJaMim88CwXn8uAvH?=
 =?us-ascii?Q?UhuSaU6HfaH7G4L2sQt+pmITc4GbvsjG6M/SdCoM6K+opzU4Ws12bTl+9tUP?=
 =?us-ascii?Q?QyNUyleZxjP0KQTCU/WXW4wNtrqMbx18j5KydBphi3u3hF6V4w/G9h7B5V7i?=
 =?us-ascii?Q?3vZh9bP+/D6eqO1pTT3bapk4cIe+Mszh22AoXUGkQ5iuExQtmt9uc8SRpAZ4?=
 =?us-ascii?Q?vvxbQzfgMc5LMXF6nR/8wg5AYiMl5Hf1rgkQjeep2HzQdVoUZdN6AxZwkSsj?=
 =?us-ascii?Q?leaqd9KZLdx7RVg6k21qAbPoE4J+sqK2gRfnXITJEqzIWrP99GidMTh/NJED?=
 =?us-ascii?Q?9JrHYd75X5i23Zj/jCqtLNs3vVNYehP9TyPUqQLA4P8MDMvnbQ4M0gLiqyQ+?=
 =?us-ascii?Q?yM63rPfWbARgN1o2HRJl39BOH5fVg60xwDejP/ixhPoPSvqPhGnJKYJ3ZpPn?=
 =?us-ascii?Q?B3WqscQJi4340KTmkU/CfmrLoRX8MYfOpkYOqelYlfcftSkmq5mPuhLIga5T?=
 =?us-ascii?Q?vN4VU97A3/gNcS11yXP8soN51Ml9bs7nA+eVIdlg1iC9TOY3nbFh4aYvvsE3?=
 =?us-ascii?Q?B7Us97WsmZfJ5wFPfKd+yIWsF9aHKaTNkVadi+j47QBzL+8sOlOVxvJBZHHh?=
 =?us-ascii?Q?EZ7Ad0YSJ0weIjnAqNiWcO++FGqpzi76KPG/upSGjGOkWQhs9wCMPjY4lr6+?=
 =?us-ascii?Q?PgDx6zwjjEiK58/OGj8w8SgnJuH+UL2QVbSS7BCAirjZx2aat6k4JW9WjyFn?=
 =?us-ascii?Q?enbWRN5W0O55tkV1UpHOW2pRWgMr+qWsLU0+Q4q7ZXfUcoFa0IeHIYitCLx/?=
 =?us-ascii?Q?xWMdAenJAhTIpvcXrxz89dlz1aEcti4Ub7d8RFib9Aqk9LaRyw361NjXvo3V?=
 =?us-ascii?Q?mSbjke5txfPSr7vKdeD/0Y06i6pR8o7jXwEM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:20.9134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d0933f-bfab-4867-1261-08dd916fa27a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type.

Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
support.

Make devm_cxl_add_memdev accessible from a accel driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/memdev.c | 15 +++++++++++++--
 drivers/cxl/cxlmem.h      |  2 --
 drivers/cxl/mem.c         | 25 +++++++++++++++++++------
 include/cxl/cxl.h         |  2 ++
 4 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 8e0b68b3be79..5629eda6a589 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <cxlmem.h>
 #include "trace.h"
 #include "core.h"
@@ -562,9 +563,16 @@ static const struct device_type cxl_memdev_type = {
 	.groups = cxl_memdev_attribute_groups,
 };
 
+static const struct device_type cxl_accel_memdev_type = {
+	.name = "cxl_accel_memdev",
+	.release = cxl_memdev_release,
+	.devnode = cxl_memdev_devnode,
+};
+
 bool is_cxl_memdev(const struct device *dev)
 {
-	return dev->type == &cxl_memdev_type;
+	return (dev->type == &cxl_memdev_type ||
+		dev->type == &cxl_accel_memdev_type);
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 
@@ -689,7 +697,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	dev->parent = cxlds->dev;
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
-	dev->type = &cxl_memdev_type;
+	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
+		dev->type = &cxl_accel_memdev_type;
+	else
+		dev->type = &cxl_memdev_type;
 	device_set_pm_not_required(dev);
 	INIT_WORK(&cxlmd->detach_work, detach_memdev);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e47f51025efd..9fdaf5cf1dd9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -88,8 +88,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 9675243bd05b..7f39790d9d98 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
+	/*
+	 * Avoid poison debugfs files for Type2 devices as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (mds) {
+		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
+			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_inject_fops);
+		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
+			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_clear_fops);
+	}
 
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
@@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	/*
+	 * Avoid poison sysfs files for Type2 devices as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_trigger_poison_list.attr)
 		if (!test_bit(CXL_POISON_ENABLED_LIST,
 			      mds->poison.enabled_cmds))
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 1698b2f90a4f..138a0b69d607 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -264,4 +264,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
 void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
 		      u64 persistent_bytes);
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlmds);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


