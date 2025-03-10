Return-Path: <netdev+bounces-173661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3A3A5A585
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3CC175303
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3A41E379B;
	Mon, 10 Mar 2025 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pJKsPunt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599B1DF987;
	Mon, 10 Mar 2025 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640648; cv=fail; b=FNYMSWyjLZDAx7uY48KdpKa+jyp4XEduybQ6VzF+LNZGBNhyE0CQKI1LMhXbjF+sEtDj7grtCVDwAuX5/Tfll+THjUpDJd7wCGVrBqEMVjpj4jq7WQW2TgLaAiHaiYL1T85UgHKhg/OECUg03wWoKXyvP9YbtSAB3O93VIbjGiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640648; c=relaxed/simple;
	bh=XgHqMk9QF9wWrxOkbqkB6x99pWftSHx9SVdXDXoPVI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQhc/JpjA4MBBKeVNBF99oYxNYpq13oZ7pBGzVrCQhXhuDvDpsrBLUWUYcuseju8JLUuqOg3I5fPmpTGHKxcVRxY0ju2SksaEjScCIgfqUHggoot/ENQEwsq1e97OwgT9Z/Ih9Lyt8q6H8zfdy0QdoPR5VUPXW94As85f70TTIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pJKsPunt; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrmmgWMnL6Tzb+iHV1uv7SL/iBHwWU1FkrFHNjVnC3Bti8ZEKl6VLkg572AlxJN+woXFUu4YaVphLG9VqaXOEmGt3A/31/p14U+dfGmZjD7hRswX9FBmpFt+xH85w9UKMlog4MgKKLGpNAaxyepGvppREaKeh7Nt3Fu6zT7mGbQppzj8lZtwlBxDWJjsYIvthjf7q5/8xH3sIUUAssVlXTPCpvIWs5WTt+ARsqRdD3BKDCZRgj8gSl2BPdYBIzrHt2tvdiD5TCKcC9UgKOZxTu8fa0oWK4mGq1/mqCuXGDynXoimQRnsGx09Jt2bQ3xONDAvHxt23VqYE+F8P+xHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TK9Bn45YaDDtiO/2TijnxVTAQhE6VPIQy6bqbyljiPg=;
 b=PfgRgpFg8JrxRXohEoN7nnF7XVl8W7rRQqw0bAO6qqUcicpmwuKi5cHQrZ2cMaB4aFMO/VlCiFue2aunCphMHEN5z6iP4CFSc3OdhqHuFwIKhG6SBwHpkDS7C2Z/gWQN3HZyxNo/75oxw08usL+kWCW26bDy6gmnLEtJ0DekLlLkc30KQ9/8O7JctQRjmWdPC727CZkaQ0/xHXQdtUFfnzG+pFfeMCEZ3lpaGKEraPGUDprKAS0+COYZXRgOYg5zXThXMIJ+j9LlXgPwlPK+ERXe4zvjiBOXc4VghzgTzpvp2SfkP9ebRXf4NLrKL2AIoPfb/TEPonRY8rpzcK+17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TK9Bn45YaDDtiO/2TijnxVTAQhE6VPIQy6bqbyljiPg=;
 b=pJKsPuntSQBBdgmF91Sadn9FxFt9/0G1snYqu2wyXA/rJRlhkQVAsQV97ViPSwkT3/RWh9yPYGpV9nuJQndJYhqUhaArTg4mcxN9jyUx4AzDHoIY++zjYfuPP3Nc+9GQ1kyWQKq3cEDQI7w3efB+ZSnhGXzNZKFwKeibKdtDsJQ=
Received: from CH0PR08CA0006.namprd08.prod.outlook.com (2603:10b6:610:33::11)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 21:04:04 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::9a) by CH0PR08CA0006.outlook.office365.com
 (2603:10b6:610:33::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:04:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:04:02 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:04:01 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v11 09/23] cxl: prepare memdev creation for type2
Date: Mon, 10 Mar 2025 21:03:26 +0000
Message-ID: <20250310210340.3234884-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 06cccf58-447c-4448-767c-08dd601716c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pikG1/7k1jLSuX9xea3vKuEo6pm3gWqf6iGUblmYovMacjdk2FqFlut0q8/j?=
 =?us-ascii?Q?9w5pIKaKiVJyZ5lrWUxPqpCO7nvC7dG5VD8KteLWpEk0E9pj+AK7TsUnADjD?=
 =?us-ascii?Q?OvLX07PuJ1uoCkTcx11GwsE72Xb1QNlAPjpNcznSdhlXIF3tyt18pjQGZO5g?=
 =?us-ascii?Q?Wlq/4gK4saoMeWiSOK+Wi3QaBq7F+vGY+oYtBHndmn2rmD2ghWxruRPtYjIa?=
 =?us-ascii?Q?qsUd3tA+bgv+V0E0V7/HMZwamM7F2qCNKg4zuO/dnvWM/WejqunXFOJw2c42?=
 =?us-ascii?Q?6PrTr4sax6IuhPbrDsfEfT67AsU1fMiWANQavf2v8N4VzE9ytYoZR/SSrTrc?=
 =?us-ascii?Q?PlZ2cblcD4SW8JWO0jrlfm99lPJWIPSSnJ8D5yi4wy81pxCjkwIZdDWs7JS9?=
 =?us-ascii?Q?nEPSr1OIqMomOrJfFG6UnXMM2061hsAvSjx53crYaGmNWlmetUQE6CgoglW5?=
 =?us-ascii?Q?ebddPD0fwWN/+1Ls8cpcGSoSnyI5VlQd5jnwfJ15dsz2ivPruY9MUEpI/8ku?=
 =?us-ascii?Q?Lf4L1l0Fa/MOY/UTvu0RY+9I2I7Q3sWEVqju5Ix3EQT30qWkbcq1m6t9/vuJ?=
 =?us-ascii?Q?zKduE+QZgyGZvGQdry0XxzGyOQDz4OgvGtNAZdW55KHa/wsPkxqV11/Tn4qz?=
 =?us-ascii?Q?phC6VUKivAlXRyfBQwR9LWcZsd9Xs0FrTlvH5Db1LICa7N3JOhh4Ufu6Inuz?=
 =?us-ascii?Q?voLEXa748VUl7YsW6faSqmOPpuMRaBuTKxN4+qAnkrdgHBXEbEiJIAcBef+Z?=
 =?us-ascii?Q?zOzadrWFYZFsu40ALJPZlyNRNOzdJDCiu1zgGbHTneibsDNUWAXo2eV9JKe2?=
 =?us-ascii?Q?FV55pscIqqaoQucUyvYf3phLIFqeDgut/SpvwPvxOWYm3kPYByXSeY/Vcn/W?=
 =?us-ascii?Q?arO3H/eF65l1CttlH9TZJjUzonGfzj6c26Y098iyDwPJNsZWneuXHylZUXyJ?=
 =?us-ascii?Q?RYLiCHQ+G5u0a5mske8/IwLDEBBDLoVseU0XX4JZFKHF9OkYz0HcemHOvWnF?=
 =?us-ascii?Q?Kq22yNAfhL81IxK9qDrPHD15TeMKcxLGP4C9EiMvouRZ/wFDU+QSRDuK0xJf?=
 =?us-ascii?Q?fJThYzRfI+3rsks+ejMIrtsKpOpCKTjqlFl7yoodKTc8XVnVsMmZgukqPtGi?=
 =?us-ascii?Q?VUB4siDLFT+Xc9zBNXJfd7ZBzMeTJe1WD+dSEYqSraSGUlQIQXa2jxmwjeiA?=
 =?us-ascii?Q?ty4O2N4E0bmFUqMJBcWLj+Im3BDnKLI7B7vvSnovxCxHwrbc2XJcqFtFuF65?=
 =?us-ascii?Q?amM11mJlR2hpekOebiySotfCWKyFcNvmS2mpG++oIkoMdqLWhzooLg/DHhxy?=
 =?us-ascii?Q?ac8rpApJQS9nBOe72aXXGMAIXgoq7CRBe5RR6t4lEQSOFvWq+i8lO0RU4u+K?=
 =?us-ascii?Q?abU0DR2xMp9Z2+WWx9mX48z3Rq1tPgeoVdmGDJ5FTLALfwoFve18TafPqqIr?=
 =?us-ascii?Q?JJsHdO4DjBjaYdrumuURHFfyzfXsGPvRY5xanDZj6gwLI1qX5KKg75MD48kW?=
 =?us-ascii?Q?d8Z8kIFma8yVAvk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:04:03.8447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cccf58-447c-4448-767c-08dd601716c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306

From: Alejandro Lucero <alucerop@amd.com>

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type.

Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
support.

Make devm_cxl_add_memdev accesible from a accel driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 15 +++++++++++++--
 drivers/cxl/cxlmem.h      |  2 --
 include/cxl/cxl.h         |  2 ++
 3 files changed, 15 insertions(+), 4 deletions(-)

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
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index af7d3c4d8142..340503d7c33c 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -242,4 +242,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
 void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
 		      u64 persistent_bytes);
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlmds);
 #endif
-- 
2.34.1


