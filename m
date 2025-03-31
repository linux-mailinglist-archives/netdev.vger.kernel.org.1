Return-Path: <netdev+bounces-178317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56492A768CA
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07DD16B0C6
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0163F215F48;
	Mon, 31 Mar 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wezPnHwH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700C1EA7F0;
	Mon, 31 Mar 2025 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432391; cv=fail; b=e3L/VrXJ37czXldGNb6+SYCUPZG4Tj33d9qtoKQdHDH1WXd0EA93c3DwWuF8j2QtiYP530UdQtCskMS3OhkVByr75flTVlwgOAyhUaC9sUPmCMTLiKgTVsRgfgLtuG1UWVXIIz7KBneqS/GnY7+KmbUoBFumJCCdk79Y6wdHFWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432391; c=relaxed/simple;
	bh=GCIuICqPhbKOB9kyP79xnMRqcAv1v1oeL5onikb0Zq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoPHX9bL/NfyNL8CSDwJfdqdXJ5GMcKnautXlmXv0NPk77uCwlCGyCVax4GC7HJh4282ivlp1h+0pIbYVCHBLnLZOopZSIdfnpi0uS9IBjFS8xWHWwmFjPQZGi+4Us6O1PAdETQDNfbxtJ4nu2Cr9FBTRborFMxgAH3+JVNpA2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wezPnHwH; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfdNQWOEoMXtSwfJXcvCeYBJzzHNLP9XL19n9cu7laINHPA0qq1egx6kH9ayXyQ3nemaQWl1LdwWIiP75i6xlbDGg2v60XTtrS58GBVBr4THrXtBJKeyx8SP0eMa/gFmsv49pIwWeSXx2GwFacUDDvDLCfwF0tMD14LFa21byurmJL6hOId8X2L07p5Ibgkl+nnjJs5lkT83ocXaASCYukkI29jLIw9TUPn4G/Mz0uFXTNaVlF5ZJfcUvcATAjt1odPpx9zuuFvrJQrd3beMB4HJDJJre3Z0J7gyz7Vrr/KAsU/MyM5ht9p9lnoYJXTUs9y/DY7+IJ77e+LFi7hV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFv/p75PSkTUv7looTSVIYGNiIlUexIVrpZXQ4Gr8kY=;
 b=irW9YwC1U9EQasEMmOYqrHsZbO64AiJnIrHa+TtUdDZ/Tcr3BVwEeB5q4DsiYIC/D72nQ4QmuQjW5awvXYKJ2lh3mvk3uKO64xD9IXxY9ZTlVgfbVvxky5QmGipxjdIXYPtDhJCKUrBrGfmxbQ7FmrxhJvfKYGaXPlxKis9WzwqtdmhPkOjkl1CmnvgMdEbRNlZTHA7G4JQlKJkh35iGe4hYU/HJ0O08RPFSEYuJ1d+153CNCo43h2MtQRpkX32biobeAWbD4XOoHwUu6DhL5YFJGnN+0x7z0N7QF1kcfa3qqs9yf/pfAhdkLGWdpK9e+s3+hoA5tUtwdOUVNZ7XWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFv/p75PSkTUv7looTSVIYGNiIlUexIVrpZXQ4Gr8kY=;
 b=wezPnHwHFxzJJvUUyjuaJH6XUkTlzT4OyzL/Y6WuP46Es8cZ+2bVwbljg3WpikhY5LCCJ6b2i1+4lXoupAoKqDdP6vHrivwYMeAIY4JKZv+j5fcGOgR4I/CsE3820cj+TdzHBgZsHp5z4e6VVoDL8O5Aq0bG1H4x5IuHddryndk=
Received: from CH2PR05CA0032.namprd05.prod.outlook.com (2603:10b6:610::45) by
 MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:24 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::c9) by CH2PR05CA0032.outlook.office365.com
 (2603:10b6:610::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.20 via Frontend Transport; Mon,
 31 Mar 2025 14:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:23 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:22 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v12 09/23] cxl: prepare memdev creation for type2
Date: Mon, 31 Mar 2025 15:45:41 +0100
Message-ID: <20250331144555.1947819-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 4192499f-dba4-4db5-d171-08dd7062cf43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|34020700016|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OSOv0Ev1TUeZTWapeMX6rC1+hoSd380UoEdQ8ZReKTEiGEQZsNC82YKKbUFf?=
 =?us-ascii?Q?fWb2Z4Ogv6fpLdzx1JWIluCh1zapEwlkgsZLA1GCE+7YVBnjkRFyek/xSP0y?=
 =?us-ascii?Q?I6q28yomifaVo6LWN7yEygmLrxXyJdFz9QtLKGt+MoVC6EUtuixXV29An6nA?=
 =?us-ascii?Q?v0K7M3fQ0thclaIjYyLODI6OiROb84LKv365YIzY+/zXUGbttgLSOcqQtm33?=
 =?us-ascii?Q?dVtqz9hMU9xZzA+zWeDD6kWCkWOgs9O4GITJxSlzlW+tE7AD/RPaUqEmZUtd?=
 =?us-ascii?Q?jxMlygMx77m0e6svsRNCm6AAKCtbBZXvooQ/mqgU6m73+VqIuNDDKeDZFnFs?=
 =?us-ascii?Q?cf7zaqFdpe5I460IxE0ZpIMyafqcaoUKVzDdFS7LC286gYV6olErtRcpLZYh?=
 =?us-ascii?Q?BDFxWrpAx14LR79laVEO6BO0GTZ+hEutAiyO1TdP1I/b+SVl0ATyOaCfxfxV?=
 =?us-ascii?Q?LCPA8XkGgAtSHCNVfDgQ5+J743TLTwLVqggCSN/eqMdT5rA7As/4OqG7MWjJ?=
 =?us-ascii?Q?/xzcBug7IT0TJUNYY462Ue6sFquzK+wG7GAV1tjAKrMNgOEW1klY059/+l7G?=
 =?us-ascii?Q?H5cSjdEetThkEE6wk3ogz7U/1rooiCqUY+f6fEWQOsT2bQX2+FRtxlvIU8Pm?=
 =?us-ascii?Q?/Ube2fa560glX2Xn5g4PPpoDTchPk77gH+zuuG7Ls4gSb3kZKOAv9r0C3uU4?=
 =?us-ascii?Q?E3myYoawUuewPgJtiZXtvwdtfYMB3o8xrm+MVcGK0t6j4Vuo75Hcu2xF+LQn?=
 =?us-ascii?Q?8RzbvL7cvW5sjYbyer+y+Joku42z6aNyO0U6ukZpez7yGMAIBQoXicsCYSPK?=
 =?us-ascii?Q?KzzJ5peodI6rfxs/uf8uY/QQgb4VbKK6d3fyf5aFONML5a75xsmxdaWwP2Kx?=
 =?us-ascii?Q?Z3FZ5I5L9grWGXW+u9xHaRM7MAn32Nf3e1KlMGPOW9xH0lJagw5EpVY2/h2/?=
 =?us-ascii?Q?xj9w+up4i0Dqgk5NaOaHAkip41T/jcxtwvynXPnh0iudPg90eE09EJC5JtEW?=
 =?us-ascii?Q?Fl96bcAhgA7bu6ClJ64Uo4gKMM5Ea7FP2a4FLenuhnULt8D/vdsA32CJoDIf?=
 =?us-ascii?Q?lLvPEWN5uZdCitDRpsHVooUI4WQFafykj4IRkHdoUJcVmdW5tHGsOoh+BjLU?=
 =?us-ascii?Q?W48W3LHa/O8Qk47rgDrBv6+ipj2KuF89wD1uIa4W0cEdiSHjxnbRPijGr0cw?=
 =?us-ascii?Q?cdsC+ajTZwI920UVMAunDPjPJx387OjqPTtLhvf4er7EP0LnHkIQi9PgFVvI?=
 =?us-ascii?Q?pi0KzRXtkuuqZCeDHHwjm4zuJ86Vd2jPMbqxROooUtLpVYPtgkVe832/2jWB?=
 =?us-ascii?Q?zsd1mC85vnL9sMB45wEPJkdy/CNahVsQmFL4pglwBQzFKzKl8Ld9qqZWek57?=
 =?us-ascii?Q?B5gTePa5XwftyK7VjUvVLkPtLP8gXr2mwfxNs1M9XBqq2Z1B9tby5IJ03l5j?=
 =?us-ascii?Q?BOSDwgYTYNPnu2padRVKVTwgB/c3jddNNiyG32rioPWLC8wF+KJvVJ64qdvr?=
 =?us-ascii?Q?omU2e+gVzafwneI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(34020700016)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:24.1975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4192499f-dba4-4db5-d171-08dd7062cf43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type.

Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
support.

Make devm_cxl_add_memdev accesible from a accel driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
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
index 74f03773baed..3686a9532d55 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -245,4 +245,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
 void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
 		      u64 persistent_bytes);
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlmds);
 #endif
-- 
2.34.1


