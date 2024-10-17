Return-Path: <netdev+bounces-136674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844209A29C8
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79911C20A08
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841A51EF95D;
	Thu, 17 Oct 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DFxJPfTA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78581DF98C;
	Thu, 17 Oct 2024 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184021; cv=fail; b=p0k3+kHQZ+rnPcZnsKOX3IPhqHOXFUJFt/sR6ySyerG9/F5wxDQAf1NwKdPGBKyj33gqpR8BQ0qJERJf2TfnIiHPf1YcFYCzTx2u9KOqJLH37OAO+NDNaEIRqu+V0SPrJWztuUPzON/G9zOODKYfzhLEJje9SVJyUGWGGmYxf0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184021; c=relaxed/simple;
	bh=n63jYcAcPl3haDTyWUzShLbuGZxMLhaviQUNbbzrGYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWHC6xQ7U2qoi+Az1riOnzU5PMdN0BdPKAn84ZBEZbgtayc96N9e7FA7yuGipUTOqu4D4RxAv4pBkEa5ac1LSGJCX9iyt9vxMHXDZVY6bFak42CwEKgPYMt6JwZLJsqBp31sqpQFobRKQ66x4dHSdhY84jM9gOvik6nMGRiqGok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DFxJPfTA; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ufe5DT+VsNGHACPLgC6QjsMlR3VukDJPzd+nCo/5aEovibGbSI715E7N/jMXRg1akRXS9cTpu2Ci6X2gCIJoSjMNix/CCAMyUV1hOUAx5oT/vMRxfhTiwMNT9iNsXbGQugX/nL75g3s8FpSb2yRXjJQbSOMPG2Tue+kJcOY3VTI8V8FYhmKtW5lPhYGugVBexnWK4ynsECY45vAsbaSSqeINpZ8ZMxCzIfL1R3jPEvxdcKGlK9J5w5pqTuGZlDEhYSrye4T4yc+a5CUQhEyhtnmSm33uHC9kShtJQ0QPQKV/sUDfm9hMqtrKohw/6tA+s4Q/ImMBmMJi/Vd7bRnN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/l+j8pFtpZMccxBH6H/bJUnHjbDwjXk3POT6PqYYPA=;
 b=uou0ma3x+bQwTkEyzAutNpQGGuOCsHLFHsK3QBAgY3qij3ctPlo+u4cNwMIAR037/PqE/w7EVBE7YLNYNyKB9wQc/OHL7ymh3VfBGZtI8YU66QqbeAIiij+kSvakf3+Bw0XxgGz7qBmzl4vh1+j2DFjwo3fj98PBRgYI08nLc01xpzFH070aL+AypI1AGzNVfwkaQwFE6khC/hZIjf5DD5SUUHHWg24O1egtqU5aMJzRO6BjksGS3mqvKaWEi/3xiXkiILf/o9r7BYVYhsozvE+exI3kwGwf96ZD6YFtw5ZiV59qCJcd954stqtYJdB4igUsFayWfwxy/sltf9TUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/l+j8pFtpZMccxBH6H/bJUnHjbDwjXk3POT6PqYYPA=;
 b=DFxJPfTAknwwz9wL4eh8qWYTjEpki4AFejyzkkpQSFiO8CNklGboJ0gM/T+f6KC5GxNZ8J7OdLuFuvoabvcR0n5PH1/JCWScHnnfd/w4fRjqZcnAJzv04mKEG1a+HEQ0GSh+3ooORZ/HJVyH1EQZFVmQINeGPaV4WzmTGhrBJ8Y=
Received: from SA9PR13CA0099.namprd13.prod.outlook.com (2603:10b6:806:24::14)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 16:53:31 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::f2) by SA9PR13CA0099.outlook.office365.com
 (2603:10b6:806:24::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:30 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:29 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 13/26] cxl: prepare memdev creation for type2
Date: Thu, 17 Oct 2024 17:52:12 +0100
Message-ID: <20241017165225.21206-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a31cd7-44c5-482d-d356-08dceecc3b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XGGSTtUiw21/FW4aY8D1w38N1R3DHpZmkH1KgpDWtdhtvXcEkt3hDHz+gyrj?=
 =?us-ascii?Q?ib1nxRPf0dPAuQbvZDhjguaWXcAC+jRKQGF4E7ugGrFsjyQ+wRbHN613cEqo?=
 =?us-ascii?Q?vgvsweYHNPhtannPBeuE/Ih3KjEHUQGoWUmUBnuklFR1PZVEgl7DdbbyeKSj?=
 =?us-ascii?Q?DAlxA/Dkh+lvzMBwBgXeWtDj/ypP46fgH4YPKcUuSZyak+aZQ8e6tDkzu85o?=
 =?us-ascii?Q?hwBVjz1GcK9w+2b9Gtd+AiMCMbSWjuydyBcZxxz+UowvVSe88wQImCtH4BII?=
 =?us-ascii?Q?bK8/FhVjhA0sMxzh6iafIgz/NMNWgCqn6IbYvbGl/F0VisUzE0RXEaaHWqKM?=
 =?us-ascii?Q?bcHZs3XPGur4LC2DdVgTYDyF2LoMoezimZ+xMxX1uZeS6+ZzjWbfEPgxfsUY?=
 =?us-ascii?Q?o83RbNa4k3QcD1mQgcLL7AP3qWZc7qQZUgK77nB1v9iksjxM3ZSxrjv1g/yQ?=
 =?us-ascii?Q?n7pEgyPlzjGJLcYG3mHKcK+sDC+Ke/gk7VNmKGKwOIX9XqK2nZAlM05uSBaY?=
 =?us-ascii?Q?V0WHucJC0f0w5gBnnEw3woLGUN+7NG9ujoVNDDsUR/+M2BrJbFruqDH9tBZK?=
 =?us-ascii?Q?VeUp4lPcCVmc3EZE9nbGWq7hD0pRVrmCEjQkdF5vmUMVuubS051wEd8UsOba?=
 =?us-ascii?Q?9xosLv3u+WLB/lgdTDrO6soLRZAXQSneyZZnxQW+jyTPJzx1w3z8bromgaXC?=
 =?us-ascii?Q?E5h100F3pGMZ4kyO5kwXPabzT6EV23SaNszRfZrLfUdQyFjYMA8AGa7CkcED?=
 =?us-ascii?Q?E87m7ZYr1rYMZxUfHKZI8XfxaZqKrLprZ8EiCiDpKtdd0NNdjEMkhEUU1+d7?=
 =?us-ascii?Q?dPMO8uFL/7YHm5wKatY3rr9s7m+d6b+pU8CcA5QHs/42L3SxB1/zuj4hHCSp?=
 =?us-ascii?Q?suXtBqqWYACWtX2I/uGydwxHlFRmoc6dljVleBa8jLR2oqqOj9i5XCjYSPUM?=
 =?us-ascii?Q?u8XBDuD9qsi6BBlLxgE6umIVv23CAN1BgmjbsUmLNn3TUsc9YHSLE7LEcElC?=
 =?us-ascii?Q?QIctJ27WkBbhyKj/REB8/gwLOy7QtWX4PDQvNqo1RaptaE6LCUsW9z0RqCCN?=
 =?us-ascii?Q?O3aoGvNlzzLN6ZQptd/em9oHM72XHTHnvxAf8KhQhWBcsa7ucwdLWqmP9+4E?=
 =?us-ascii?Q?iRWgHU4AHXuBIyjD4cPWeyXX+B0hDw9TjHPnz7tSfuKqfWjVOjuCVv3Y2MkQ?=
 =?us-ascii?Q?CZE2lIrr/uYaWGSSQyzVj+gH5jPpDYA8FaQQxVxsMlvHXt0tGGISF5m2zTEa?=
 =?us-ascii?Q?9NsUQVG3YbsJNhVy7kQRCzQdQ3KUBT1ngRRl+tkejIqGEkdx0loW7xNuYvI1?=
 =?us-ascii?Q?YWQP5GIqQoEpaMXz/HC7NdT32k41hImbVlDTKFK0tH52hsdDUN5Kp9Gh8+XI?=
 =?us-ascii?Q?ASVo24B9pNmWlKBEE2FyNftT1Jymv/dpBRWmcOYuFiYa3q3nvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:31.4525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a31cd7-44c5-482d-d356-08dceecc3b4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type. This last device type is
managed by a specific vendor driver and does not need same sysfs files
since not userspace intervention is expected.

Create a new cxl_mem device type with no attributes for Type2.

Avoid debugfs files relying on existence of clx_memdev_state.

Make devm_cxl_add_memdev accesible from a accel driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 15 +++++++++++++--
 drivers/cxl/core/region.c |  3 ++-
 drivers/cxl/mem.c         | 25 +++++++++++++++++++------
 include/linux/cxl/cxl.h   |  2 ++
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 56fddb0d6a85..f168cd42f8a5 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -546,9 +546,17 @@ static const struct device_type cxl_memdev_type = {
 	.groups = cxl_memdev_attribute_groups,
 };
 
+static const struct device_type cxl_accel_memdev_type = {
+	.name = "cxl_memdev",
+	.release = cxl_memdev_release,
+	.devnode = cxl_memdev_devnode,
+};
+
 bool is_cxl_memdev(const struct device *dev)
 {
-	return dev->type == &cxl_memdev_type;
+	return (dev->type == &cxl_memdev_type ||
+		dev->type == &cxl_accel_memdev_type);
+
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
 
@@ -659,7 +667,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
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
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..7e7761ff9fc4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1941,7 +1941,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EINVAL;
 	}
 
-	cxl_region_perf_data_calculate(cxlr, cxled);
+	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
+		cxl_region_perf_data_calculate(cxlr, cxled);
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		int i;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 7de232eaeb17..3a250ddeef35 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -131,12 +131,18 @@ static int cxl_mem_probe(struct device *dev)
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
@@ -222,6 +228,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
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
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index b8ee42b38f68..bbbcf6574246 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -57,4 +57,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 void cxl_set_media_ready(struct cxl_dev_state *cxlds);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


