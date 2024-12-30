Return-Path: <netdev+bounces-154570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EEA9FEB13
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EEE83A26DF
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C7119D07B;
	Mon, 30 Dec 2024 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sk7L76yG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74219CD1D;
	Mon, 30 Dec 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595105; cv=fail; b=CDES6T1E8RuRZqJcZpgQwWlV9Hr24H/KM14p9Yr8MPzDt8dnEkXMly8kaFYbnSowtO5AkYq5tj7I+Ov5A/U26Ab8P27Sisto3iR8FbA3reuzEk5fYU0gMfIok7psyJbZCLfNGzZ47Oa8k1Rggm/P3nzsuXrYsWIpB8r5JvQQfjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595105; c=relaxed/simple;
	bh=f3hbEpqEMA/WeQBiMHWwptz2Tn8zglmMjTgtqks1QyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRlnWoiI2gySZN4MSrxQbcMyYI2WBPEV0WKwlfTrRSlilK/ZFgCEF4GvssX03Wh6dfvrbh2f6iAKc9Qm1YldTOY/OD7xmWrmAMoZf6uinE4xy+Wz4ipci6VCr+SqapFaZ0PJzRdiU6hw8zUQ8/33Ky+usirskL+mAg01rkxHc+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sk7L76yG; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4s1MV6fvjMiaJbMq3oWWQKMYx1TeZY9EsP5rCh6v1MmIPIe0XtOnfZCSnnbphvkmUpVHdV1JtwbMp10Ypy7R/6YdFJXLEZyHLvalfizNNz3LC3r1GuDVqCUTQN51y/4rDKaMPxWQbF6oXBblhxy8VVh/q5u1YUI9PePcIJ9Sz5tUIltdWJsUIahDhHnoHcSSI+FQY08jfnBP8JhrQ8/g4SKx/IpJw2mvpgzWzhrXc4OnS8p6/5gH206ExEEFVjYxDJKvmrW8emJ7XkQamPqY5rW0YeM5EJRfmbE/zyTfy/XfvrhGigLKV6eslfvF2G1V0tiyEBhyuHgDFuE0cQRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtE1tmOprB1iIdgjb3GxGY5TBVGKAvyolASjvfxQKtA=;
 b=BVBmp8pibvYqGzcQeUibd7G0fRPgMU1sJm3U2JLkbONO0Q74LsFgmA0XF5mxyMS8/jqKv/jmjKN/rfeqmuITwsz7tmjVhAicGhNSQGCO/JtZUh++d+cI40Y2Li7GthZvU/+Qdw0TwyMI48sII98Fkz/COEXdDh8Ajsuv0hmBVuSRDsohLo1Scd9efU8LSjKw9pKLZelsw1cC0Cd9QMbAyzl6UUTtfQA28bAcp2/hs78n+j+AeDHinnyM419YuSF3IbGXBvDqfSgILk3OHsmO7zyp7qERvs9DO11vKKCx4HEtzo/TslJ/CwQHpNjKCcN1EWwvyDnX53gfV+x0ri8NEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtE1tmOprB1iIdgjb3GxGY5TBVGKAvyolASjvfxQKtA=;
 b=Sk7L76yGQcIHHsXcayQkoioB9aSMdpPnls73OTahzG6SMie2TkexU7+u8jKTMJmD7ZkeDKIDfq0y5BqwGUhJC6mnqtDMbUNwxdopSJrRBClhI/Zij6fA90/mk226Z7V3SERDZgGsBZhJQn36ZaE2W5og0Ms9YS4n98poCaR6eyc=
Received: from SJ0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:2c0::20)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 21:44:56 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::5d) by SJ0PR13CA0015.outlook.office365.com
 (2603:10b6:a03:2c0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.7 via Frontend Transport; Mon,
 30 Dec 2024 21:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:44:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:44:55 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:44:54 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 01/27] cxl: add type2 device basic support
Date: Mon, 30 Dec 2024 21:44:19 +0000
Message-ID: <20241230214445.27602-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fc898f-a4fd-425e-aa9b-08dd291b33a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1F1ce+Au/rkn4+8POp2bw5gqyWXSEvvAk9i/day9Lxduh0cDgbAouzGe+9mf?=
 =?us-ascii?Q?EL5arqUBJjm1tt2BisS40Hfe0+JAeYoDE/GfeYwnS5iONLuuHKhjLwZGNP8A?=
 =?us-ascii?Q?9kiEVxMieULZmPMPEJQBpWSM9GaK0w8wrHY7bJ+dQoQFuWAYG1BVo2SMzqDS?=
 =?us-ascii?Q?6nw4sOV6Ze68pUML872qma/yWsCe5GuQqImpLuQ5/Ul7QcSayYQYbAomJNCv?=
 =?us-ascii?Q?kkepmDJ9L9dshvUwviVIfs7ElPn2Koz3ViCXfKLBzSHvlobKfr935VoC2kRg?=
 =?us-ascii?Q?YCwOWiTZFFWecX5AEdCiDlrp/J/0GbNXlevgJzDlIcu+RKMEKzYMEKZnqr2G?=
 =?us-ascii?Q?3zpJY9f+E8lziCv/t9FfXA183QKOY8xdxcd+QnsPZECcTayRLD/7FMs7ITxa?=
 =?us-ascii?Q?OYgDWdCvMDdYZhwNOfsO97nh642b/KhxP6BVQET2zkx8Mp0vnFlAINuZCbnb?=
 =?us-ascii?Q?1rIBHUU/q6O4DjqBHHchvy52CaC+D25lc2zU5LG115Te+f6dsDRz5KUMDkAC?=
 =?us-ascii?Q?yj/C2TcGePYHABXiVRa4dBvdXnKayXfdTIoJCoUCZDbHc7q/VxX6XrxWJaPL?=
 =?us-ascii?Q?AyvxxLsf4dSq1whO+ZaWY+pfMJP4arzX4rAGpdRdGdB/RWO54YuTaGS/ZdHz?=
 =?us-ascii?Q?yeOeSSv91h/CgARB76bkET02449Kg3vywzR9B36gBEBpaFKJQ4MPV+dRR4ZV?=
 =?us-ascii?Q?OlOau/3UWj9oM1b7VhmeLdUUNo+piTSJWLSUkCa90hEeq9Zv89k3tKTreANX?=
 =?us-ascii?Q?KFXUJEqcwt+VwhhxvEE+kdZZGP8Pnvv/cl/V47FMAx1EUr5RdZEwe8fDBUMX?=
 =?us-ascii?Q?0DIMcPOw0EheX4VPmwpaIlQjqIAUpQIZ3peQEf4JpcZChGkMSinZDFuPtNew?=
 =?us-ascii?Q?m04Q95Sijk8JMkmys1AXmDMrS4NZVqXpAGiov+03zEHMSeDvTGH7S6Lg/qN4?=
 =?us-ascii?Q?h5ORIfAadj2uOqDRsbMlO7BY+U/RsQ51+KEldXJBXSMCCMtK4/ydSdGWpZwg?=
 =?us-ascii?Q?91I7+xGM4+d4dTUPxL06h+S5G4gam6J/hIYtDuI1UslkJO8upHb9CXJa90AS?=
 =?us-ascii?Q?eckG/7jHy9vZBlMmmlcuvauctB4Urd0oDPNLF2O4jKKpDU+GO5ek7soFv9oq?=
 =?us-ascii?Q?rUjHtNH+RQgiqC/wbuScPe1O2uZtLIzPxOyJFadobsl932NkZIagt+hF5zKY?=
 =?us-ascii?Q?uhnXeLZbshvhIOeeCTAttwrqVzhX+Cab9etKK2XlOF8wGL9M6giJUdtiy8OR?=
 =?us-ascii?Q?0sVDxIrMIn7QzNbUpGWuaR/qmoSMT/C/6A3LVF9JWKTc1lME+oB4du3HPOKf?=
 =?us-ascii?Q?Af+v0lAHBqW1xcJ2Zdw+fjwDkV01JC9uqT0DjPHKmUBPbGRNQdgz5CW7umqj?=
 =?us-ascii?Q?nLRzVAib7IgT5iWt3KIeKLA2W3C+8kokJyNw1VYhFGW5Z1MTTQEQIRxHwEI+?=
 =?us-ascii?Q?tU0cvveJVhzBxj5Gb2aOh+e3ytw1Pwv6D3Kj9NEOHhoROOtU5uOZtEFtm6Ut?=
 =?us-ascii?Q?9OGNbMLQhNoYZdM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:44:56.1979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fc898f-a4fd-425e-aa9b-08dd291b33a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891

From: Alejandro Lucero <alucerop@amd.com>

Differentiate CXL memory expanders (type 3) from CXL device accelerators
(type 2) with a new function for initializing cxl_dev_state.

Create accessors to cxl_dev_state to be used by accel drivers.

Based on previous work by Dan Williams [1]

Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c    |  1 +
 drivers/cxl/cxlpci.h      | 16 ------------
 drivers/cxl/pci.c         | 13 +++++++---
 include/cxl/cxl.h         | 24 ++++++++++++++++++
 include/cxl/pci.h         | 23 ++++++++++++++++++
 6 files changed, 108 insertions(+), 20 deletions(-)
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index ae3dfcbe8938..99f533caae1e 100644
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
@@ -616,6 +617,25 @@ static void detach_memdev(struct work_struct *work)
 
 static struct lock_class_key cxl_memdev_key;
 
+struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
+{
+	struct cxl_dev_state *cxlds;
+
+	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
+	if (!cxlds)
+		return ERR_PTR(-ENOMEM);
+
+	cxlds->dev = dev;
+	cxlds->type = CXL_DEVTYPE_DEVMEM;
+
+	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
+	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
+	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
+
+	return cxlds;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, "CXL");
+
 static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 					   const struct file_operations *fops)
 {
@@ -693,6 +713,37 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
+{
+	cxlds->cxl_dvsec = dvsec;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, "CXL");
+
+void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
+{
+	cxlds->serial = serial;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_serial, "CXL");
+
+int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
+		     enum cxl_resource type)
+{
+	switch (type) {
+	case CXL_RES_DPA:
+		cxlds->dpa_res = res;
+		return 0;
+	case CXL_RES_RAM:
+		cxlds->ram_res = res;
+		return 0;
+	case CXL_RES_PMEM:
+		cxlds->pmem_res = res;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_resource, "CXL");
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b3aac9964e0d..ec57caf5b2d7 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <cxl/pci.h>
 #include <linux/units.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 4da07727ab9c..eb59019fe5f3 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -14,22 +14,6 @@
  */
 #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
 
-/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
-#define CXL_DVSEC_PCIE_DEVICE					0
-#define   CXL_DVSEC_CAP_OFFSET		0xA
-#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
-#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
-#define   CXL_DVSEC_CTRL_OFFSET		0xC
-#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
-#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
-#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
-#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
-#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
-#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
-#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
-#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
-
 #define CXL_DVSEC_RANGE_MAX		2
 
 /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0241d1d7133a..36098e2b4235 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <cxl/cxl.h>
+#include <cxl/pci.h>
 #include <linux/unaligned.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/moduleparam.h>
@@ -906,6 +908,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_memdev *cxlmd;
 	int i, rc, pmu_count;
 	bool irq_avail;
+	u16 dvsec;
 
 	/*
 	 * Double check the anonymous union trickery in struct cxl_regs
@@ -926,13 +929,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_drvdata(pdev, cxlds);
 
 	cxlds->rcd = is_cxl_restricted(pdev);
-	cxlds->serial = pci_get_dsn(pdev);
-	cxlds->cxl_dvsec = pci_find_dvsec_capability(
-		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
-	if (!cxlds->cxl_dvsec)
+	cxl_set_serial(cxlds, pci_get_dsn(pdev));
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_DEVICE);
+	if (!dvsec)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
 
+	cxl_set_dvsec(cxlds, dvsec);
+
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
 		return rc;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
new file mode 100644
index 000000000000..aa4480d49e48
--- /dev/null
+++ b/include/cxl/cxl.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
+
+#ifndef __CXL_H
+#define __CXL_H
+
+#include <linux/ioport.h>
+
+enum cxl_resource {
+	CXL_RES_DPA,
+	CXL_RES_RAM,
+	CXL_RES_PMEM,
+};
+
+struct cxl_dev_state;
+struct device;
+
+struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
+
+void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
+void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
+int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
+		     enum cxl_resource);
+#endif
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
new file mode 100644
index 000000000000..ad63560caa2c
--- /dev/null
+++ b/include/cxl/pci.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+
+#ifndef __CXL_ACCEL_PCI_H
+#define __CXL_ACCEL_PCI_H
+
+/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
+#define CXL_DVSEC_PCIE_DEVICE					0
+#define   CXL_DVSEC_CAP_OFFSET		0xA
+#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
+#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
+#define   CXL_DVSEC_CTRL_OFFSET		0xC
+#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
+#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
+#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
+#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
+#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
+#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
+#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
+#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
+
+#endif
-- 
2.17.1


