Return-Path: <netdev+bounces-182292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B56A88722
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5483B1903465
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBEB27585F;
	Mon, 14 Apr 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="buTvhw9C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435EC275103;
	Mon, 14 Apr 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643646; cv=fail; b=aJDhROFUWYIdsGeqs5XFX7g0KYaWi73y2CaWS2fsy4NRAinzo3pRFP8PiJh8qt7CW+o9z19wNjeejUteIuPwWPu/sjqqD3kgNW6s/39w+wkbHPtGov2Z7fCv0am1ReAKkA+i4DVo1JswsRPMmTPbktFLRdnT8KOzqsZnC2Sgbik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643646; c=relaxed/simple;
	bh=/kDjHR6SAL4H2m/0rrBZIBy9OFZt3djM1840EPcuED8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MW7dyIIQo2sTt58GFPRaLL+V2c0GTiZ2YOWA2HSTFo3peIGIhW6ZOmIq1QHjwr/uexPhepwXiNDANAMl26zDFK2NNH3LwdJNYMmQ2ouux1VqCIjHt8u4dUD4Al3paGE5VZEqlPYaEWnrmO8uRHsBumHfK9/hotSGkEYyABMnA3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=buTvhw9C; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWNM3eLMH1my0fdOY9JP55Rl0FImaHBOVSRe+7fZEoW5StHj7uqdOSoKuEKsbOQ2Px3StEvFni6K9xN2zrc/FQf7MLrLa3HCC/xgKKOfewj+vxJVFHHg4RYgQWHH0OAd0oTcmPsS/tRN94uDuOgqV3bqZV7DuwIf6Wln/iTICvhPBQt4PJa559IRpqW/+mb3zXizQbSOD1IdRqE6Tws9kJmrLHB6cu5UbSzjJ2nYoEESoa9ElGPFRow0GHej//0eyZFIHb7m6vFN+XyuAPxxPw7tnTfZHm6fboM7rzL9V/LCcV7WgQ9/9FDPKPaO1NCoZyBIdLoXlD83raTlk/yslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubn1UGFg1YMQj4/G8Sqt+gTVEnOfHtYSKdVvvTAvnO0=;
 b=Yq/ndeu9WCUAS64oJMaDNVsPuWMk8uOUBvm6IKpaqWUOc86fiKIRmt/9RCnzCjqA7TPaxukTnzsDCEasA3XHkB8SfXpPL2Q7vk8qq3X6iwTRZpWM+fM5aJOYuVn7hC3s5Cs1fRelhC4d++5f+ONjMICujQypw6AZ5uBO1F+y9TnBYcUBDXO+u+fHp9kXYb70N3rSr0Iag39DaQhqGonLrsVtgECCoNilmBRIV1P63TUFT3HpqBzITjCGJrs0lvN4WXLqPVL3E+iiIsJTQo6MjZjcep5a4Ey1Wq/CNrg8NEsbNcA6t1Ort1/AYv5OYMkMMTR+rd43LSpFzNhJCNVTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubn1UGFg1YMQj4/G8Sqt+gTVEnOfHtYSKdVvvTAvnO0=;
 b=buTvhw9CdLNhsh/667zMaA5s0BLR9bJ8qmpZoaqylJhFTbm7Z9+UJSppkY98sVaXNvf2H00B48N/QpDLY5DwZG/LwU6f3MfmRnNJVinaz8MP4K9YR5B+8eAA99IU+eoBeZ1N3cUA2WLu7KqHs8VvzzUFcDeSjLXsbzQkGk08iAQ=
Received: from BN0PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:143::25)
 by PH8PR12MB6866.namprd12.prod.outlook.com (2603:10b6:510:1c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 15:14:01 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::ba) by BN0PR10CA0007.outlook.office365.com
 (2603:10b6:408:143::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:13:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:59 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:13:57 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v13 09/22] cxl: prepare memdev creation for type2
Date: Mon, 14 Apr 2025 16:13:23 +0100
Message-ID: <20250414151336.3852990-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH8PR12MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: b4bd5b55-6631-4cbf-018c-08dd7b66fbed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eODAWID+Wf2JkawNEjJzi67sECHFTaotKWVnUBBjzlWhKxLZA9BqH5leXUSB?=
 =?us-ascii?Q?NY/Eu760PtrYHbQTZpExM+HkmHXNR1TKO1nsaYVznipBlbSg3PddY13ZPSYh?=
 =?us-ascii?Q?DYdbQuH9wdlF/oGi4KU7rAR7A/Qqkuan9LiCOyWmMWRaIN9wmCBkd/m4HQLC?=
 =?us-ascii?Q?rjQEoV9PycXd6pzZrptZo9rzzSl4aorXOciPHPjhlJSgdbsaTN4E2pXK5CQw?=
 =?us-ascii?Q?dz8++BqGGpPFbbr8VqXtN4dfMG1Q2C3VuCI/pjk0YTBIel2BdksXIzvUrthx?=
 =?us-ascii?Q?Ad6fN3KXcEsH0xB8+yWwaCJLXqGS8T0neX5HRShxAcLPYhgGp6lWYA84K5Xx?=
 =?us-ascii?Q?o/c2S0hGowdKgkQxtTrSZYJAA+Z+uTm9h+XiaDfZm5ZSMAeo1lPN+3mmSUkt?=
 =?us-ascii?Q?Ia2N3jMvU/vnf1SJvZG9EkZHuySvSWKB4YbxdyUNdlflUZcmqNEQQcVTNnPT?=
 =?us-ascii?Q?hlPhw0RbUmtlWWivNMzZabdlpTWyV2riDceQwSRKUY8B0LyjzI26S95LlhSf?=
 =?us-ascii?Q?ajliMvGq4pJDMNLk61sLAdKE45NCUe63Yaukv5Bv7eKQXCRfroV1+/v3M+Wi?=
 =?us-ascii?Q?jBTqH8EV+v3KCPLaoYx9s8bick6MToAnznG47NUS1/VG3eT2vE50q9I2iBFd?=
 =?us-ascii?Q?8Xfoy0zF1IqGs22n72olKPdhyM+wkcS1zYsMOuizwOLxJ29u6OqYsEO+s6h8?=
 =?us-ascii?Q?OvFYbChaozbVwoM5GJJW5lm3PloDes+w1A5ESu+OmfPQCv9uRcNGehrbRYJi?=
 =?us-ascii?Q?ena4s9m0FBVHWhjNAozHNhmFjeR9NJIN+p+hObc6yuXx39beXWIVpbb5at7F?=
 =?us-ascii?Q?Fvxb5HMowJTj4wKg3PX1agvwx0qFJ2LoW9Ohe7Xn7vBMFeHBa8tbnruDpl47?=
 =?us-ascii?Q?r3pD5IB64QKJxCsHt6vnlx8M4HjFAZxoLCJHBiLHTR4+9b3EqxRBjqCAU+Tw?=
 =?us-ascii?Q?+m+P5/Xj3w8x7lkERFeVhMBu5c3PNdggsMwxRpxL08XC2riKfDc7PdIYuYPr?=
 =?us-ascii?Q?+rSIQlkNsHLV7rGn//MBr9FWqHmTeA9hGqFc2sZ+fi+1OsE9nC5m2vJkZlQX?=
 =?us-ascii?Q?PfT4sC/oifz3suiHT9wTq4khHR9ULIK8EaCn275noTGDhW+bb+oX9d5Q3ANL?=
 =?us-ascii?Q?c7Vos5YkoQZXw141gaHR393/IxNG5P3rjQwjD4NS2YPsP82bZx90mIVwN0BY?=
 =?us-ascii?Q?OGIeCQI1lzmE6Q5ybCBoA/r8ZM5fWB4nbapn5MaqrwLvt3qY3BygXiad76Va?=
 =?us-ascii?Q?isSrnK1WKUGTROgb9e2lGjzFuRcCr11b9nAkUk1yubMQU7OycnbqoKBbLWaj?=
 =?us-ascii?Q?lqDHHNRKkXwtKOH39cYrBHwZhmxpi6gRNaMZatebifOwArFY+lLcZj4/8Yor?=
 =?us-ascii?Q?hH87Kvu2xRVhQH37Gi3LnpD1su7JOsL10T1WRITv9Ju7sxGgqCKCRu30NwaL?=
 =?us-ascii?Q?04x2OsQSF6dK0Dfap0kt7lMPB4TfkhAhoqhUqa6SR/OnTdlibnmahO3kLNAE?=
 =?us-ascii?Q?Vm/3MgZTfI7W43DIeyFS5Yc5pS9BQGUu7WWD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:13:59.9660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bd5b55-6631-4cbf-018c-08dd7b66fbed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6866

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
index 6cc732aeb9de..31af5c1ebe11 100644
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
index d1bd136fe556..879725793f38 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -249,4 +249,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
 void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
 		      u64 persistent_bytes);
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlmds);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


