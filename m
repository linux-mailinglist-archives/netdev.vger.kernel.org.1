Return-Path: <netdev+bounces-163045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790CDA29468
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FBC16DEDA
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B01A190472;
	Wed,  5 Feb 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tHTYD4Vy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63007191F60;
	Wed,  5 Feb 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768817; cv=fail; b=mngYD4of1VnIqreBaB5+xm20wG+QlhBIrWAmbKoIhJfvg3HlAb3SZTBBBrzGN4OveyHf38DOEmCtFi0B+VHx8IyE9i34dwUlvRCn7p/M4tUqQlCfeo4o9EljEPzucxnuIEQegBzr1w9M/w5pBvOJBAqy3Gdbi0YsfJeSnlhJ7lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768817; c=relaxed/simple;
	bh=LikaEKKyFDklUlEi6RwRn6mqzYFstwXWyBVsavdzLRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LU/gCR3okVbrctxEcNUpIM+oJb8Tk9ecoBYlZPcqmP2sjjIfQM6g5EBuFiXmkiEavuMOnaxpYIn3IzrBsFqbqONuxusGu8Rp5w8slSrI1pO1KFsFH/ulViFrEzzGYrSd8A0KcWR7W9tDoF4fIg5Bq7msG8BsjCLnVfwkacyDBmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tHTYD4Vy; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1czfdlUnHhGQOSw1E4odS5MTlv0QP5xDdUQG4bvD7XQq8i/aEQ6PeR8iHYeJ4yvRcS6r908Eln+wJ9Blz7gQkdBX6t4Ll8O92utfBnZXyR2svoJtsEMuXH/5ytO6Z/Kv4jpODTh/9jLG0ClxnqnjXRNADb7KgYwCgs5WVpY4zuytEN9ynCe5Uc3fAjkj59GdqU92hS6m2wCChfBnCJ6Ba1GWOzDxaRtyF9gToDVpH6do6yps/Pc6T0xXuRoAAyh05o2uzPhWm99IrBab9dxRDr69cUcdTMuf3A/cPm7c3QL2UwmpRCdg0zZtqMwbrw/cbLxLfHf6Yq30Ptv90KDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNEJ1DbfihwTHLOKOhCmRT3MGOWd2MLAoKqMCzN2ZmM=;
 b=IO64eKJZ1TYaZOmjLX8vcX90T6M4ZoA1yPBrtQUQSRO5nrko0DIQ1Kr60mItVXJdlCVKNmOEK0yLL5Y3yWAH4/NyWGpfGYqoijG1wNx8DMA7n7JoA3cEyJ6cBAZj/uZg7t8AebOZNE9JULtDWxsFQucVDb72AVpx35sxLPn045dq57mo53hOikXveNAgPfLd3SwiULTiLr4+IJ235qg/KCPd7xj264R5/9Ycvsqoz3Nu4RtM5l/1ZCV8aa7eRfvzqZKBmZ0rPq5FHcQPHYDYs+RzvyRNsEEeGmB8m/Ieea6LNyJzMFxK6bIAFaO+BaHBcDQ8XY8qox3B/cnvighvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNEJ1DbfihwTHLOKOhCmRT3MGOWd2MLAoKqMCzN2ZmM=;
 b=tHTYD4VypL1nXVWyw381fYdggzfWNVMDdeEY2I2yXKPNyNtfvnF96xpRCwZo9VQQlT9ajYEUD4Pl89yrQ59AT4nECoIva/mS6lTpo/kyNHqUpAyukMKnEfIRxBq92wS50989xtPiozZGyIOH4bcEs/RXO+py/4JkeuDlr2dLXms=
Received: from CH0P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::9)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 15:20:12 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:11d:cafe::12) by CH0P221CA0025.outlook.office365.com
 (2603:10b6:610:11d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Wed,
 5 Feb 2025 15:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.2 via Frontend Transport; Wed, 5 Feb 2025 15:20:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:11 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:10 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:09 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 09/26] cxl: support device identification without mailbox
Date: Wed, 5 Feb 2025 15:19:33 +0000
Message-ID: <20250205151950.25268-10-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ffd53b-f4e2-4992-953b-08dd45f895aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?glmE/cQK2BkxNPNbwIgeLHGKYkEzBMviE7h4yFMmbWu7M8M8Jwb/V7/6HGtZ?=
 =?us-ascii?Q?8nTn1K2AG3f2VZZreDobip9qz3IWjRG/g6Y6BiyobeamC4CZjd/Ej4ZNK2jA?=
 =?us-ascii?Q?6KoUC//Mdr7fvAk2sbihjG3lI7yLWE6NsEOT80xv6XsQsGvfJS/F5KLXJ5Qp?=
 =?us-ascii?Q?KxgRD9FGT9og3BpUOLbg69jK+4q9CuZ5T4AGLhN7K+M57L2deeZhguIAiANp?=
 =?us-ascii?Q?bMmAi5Ro/FHc+JvtUy1efKMm28ADbghCyb/QV8B1pDeXP/OsRWPgM8tHoTRc?=
 =?us-ascii?Q?Jt9eNPvUuLvDnCr/QKELS59uykL7QzsxdFnSyOh/RdSYO38yl5P1T4cTSbdW?=
 =?us-ascii?Q?ceREr1EThFycLv/tYoymH1vYj11fyc8AZKP/He+ixoyhNiGvVbO67qOtWM0C?=
 =?us-ascii?Q?lCQ6So7ljLKg3PSApbIl2b0Cx2FoZxVMZdwlXZmOfcjo9z5EGdzW7cNaw3Bc?=
 =?us-ascii?Q?heLMizS9Lz3Qe29TMRepYUTWqUu5GZh5yoT9h6pFNmhjfRDtleA4idAqgkWY?=
 =?us-ascii?Q?46x2aPGF5PoGLG+fCGRKIUSEsd3BRPWKq1czkgS93BanLpQim5ogiJU71wZJ?=
 =?us-ascii?Q?CCD5a+VJccsHfufeaio+z9xN6vFybV1/+3gs6t0r128PpVmZLXoT2HvfGiqH?=
 =?us-ascii?Q?6N1bsIM+DHL1T9FUKHn/PsgjDpPkThVQHljAor3c5VAhp1849DLQqF0w0eRC?=
 =?us-ascii?Q?RnKgn83I7ybr+g84J8zoBqqkBdFUxMc5piew3s/Zr9x6PkAqVZwb4VIvwBJ4?=
 =?us-ascii?Q?VX8GA99x4sZ6b27CjdvWdGiMD5N+C6t/0nMzgDBagKP92TH7xK4hgvd5hyi5?=
 =?us-ascii?Q?aQn7i1C1++7LftXwAzBHEZTth5QeN2EsKbRmOCXRScFjtBc1Bw3CsyN7EI1T?=
 =?us-ascii?Q?OTCaSgcCSqftnX9ibmPN4HzHTQtZzTcx+9PWMM32NENlmZivHzK66D+FwYjm?=
 =?us-ascii?Q?sD96eIDkBoKgnGdEOMMIO0Rc5cQiU0TJf3RoqPsKEkvDpKOxHn6yghGxIZAj?=
 =?us-ascii?Q?CC30OUW1YhvHnblNmYsp6ListWHDbnT1ynxOGakrYQlVdu/SSQNleWrCaHPx?=
 =?us-ascii?Q?ZVAIZBL2SUFLGirRHmF5UskqVAeG094dHm+Aztj6zZLvcYAW/pzLqhZWztQp?=
 =?us-ascii?Q?y94l2mtpdiJtR0dfTbwM4LVSpch4tfLxxfBVlq4pqDGjsppsVAF+lodjItQx?=
 =?us-ascii?Q?5tnCJWNAJYueI3uGEUAqDdOwbKS6syRZC4mo+i0bNN6NO/x4TPijk0mhTtYA?=
 =?us-ascii?Q?NXFfO42Q6792bteuXg/fBlISWDY4M30KnpZGINjVmaOR7sutior2RhIs6D77?=
 =?us-ascii?Q?SWl+D+258CIyBniSa6U/sW5MVECRcBZc3P9sM0L7nn2r5GKE4CKyn+M80uZF?=
 =?us-ascii?Q?A7xRhb9YrIqq6cSQKI3Hca3SD+1Ud39FRiaivNBOiuZzy9+iOwJWZOqnO6wq?=
 =?us-ascii?Q?wL4Vjk8TlTT03S/Y6mkOPMc8x7l4cKUhnQyR42QtI4OpKQx4sBY7GyibfM/U?=
 =?us-ascii?Q?EaTdxSKXRoASTmw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:12.0731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ffd53b-f4e2-4992-953b-08dd45f895aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135

From: Alejandro Lucero <alucerop@amd.com>

Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
memdev state params.

Allow a Type2 driver to initialize same params using an info struct and
assume partition alignment not required by now.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 12 ++++++++++++
 include/cxl/cxl.h         | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 456d505f1bc8..7113a51b3a93 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -655,6 +655,18 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
 
+void cxl_dev_state_setup(struct cxl_memdev_state *mds, struct mds_info *info)
+{
+	if (!mds->cxlds.media_ready)
+		return;
+
+	mds->total_bytes = info->total_bytes;
+	mds->volatile_only_bytes = info->volatile_only_bytes;
+	mds->persistent_only_bytes = info->persistent_only_bytes;
+	mds->partition_align_bytes = 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dev_state_setup, "CXL");
+
 static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 					   const struct file_operations *fops)
 {
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 955e58103df6..1b2224ee1d5b 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -39,6 +39,16 @@ enum cxl_devtype {
 	CXL_DEVTYPE_CLASSMEM,
 };
 
+/*
+ * struct for an accel driver giving partition data when Type2 device without a
+ * mailbox.
+ */
+struct mds_info {
+	u64 total_bytes;
+	u64 volatile_only_bytes;
+	u64 persistent_only_bytes;
+};
+
 struct device;
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 					   u16 dvsec, enum cxl_devtype type);
@@ -48,4 +58,5 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_memdev_state *cxlm
 			     unsigned long *caps);
 int cxl_await_media_ready(struct cxl_memdev_state *mds);
 void cxl_set_media_ready(struct cxl_memdev_state *mds);
+void cxl_dev_state_setup(struct cxl_memdev_state *mds, struct mds_info *info);
 #endif
-- 
2.17.1


