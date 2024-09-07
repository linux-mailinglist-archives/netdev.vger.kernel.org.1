Return-Path: <netdev+bounces-126209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB4B9700C9
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41A31C21BAF
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB784381BA;
	Sat,  7 Sep 2024 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IgNYnSgw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1712E5B;
	Sat,  7 Sep 2024 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697167; cv=fail; b=kodMGZJ3qwIcL1DtbyXCJn4YPwI7uYlFD+rydoZJcRFqGxOdx49xVnZzGWdfIndW46wsqX+pRZT+XB855OqBucls9ZgdjdzAxclVbVRw0B0PRuzzkho+jEsQXvsgWEThE9DUwdnZiJKP6OqtZAWQ3kSdmTqtzh82+HDyFLATiQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697167; c=relaxed/simple;
	bh=jbQhunVL7odg8AabHxc+yU6LGMZ6hJp1LfOK0r/tMsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oA1B//Ek5Q+IEfjQrOCubU9DNRsZJP0AkL2LSDvbtlX4TFo6mu+3VjpffrHFHvQwLRuSRDZnR9Cj2FzXdJME9LVPrfaB9+SHmVfZKP97QAAYMwEaSZHPyysIJGXwijW3PHBjX0iaUC9iqIwc1zLUVCbRyPpBrduqZP7/wzkFLNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IgNYnSgw; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6iPmOxfiZO69MzXjf9gNilXQnW1U1/JKGIMvQSOTp5INnb0z1BISATGF/QtAX7DnlyJ/QVssNaWHUCxVVwB1xVp6X3GpbVN+Y7fRl9nQgyomKelzvHFUqcVtepnMMpRjUPtREh7j+ff/c8vLn+6Byf8dKkfDdHP4bLWy+capjEpDd0jJLM/3DDkuw4FlchcBehgT78S9Yf++6QAwRIdyZqOlVLlvCxLqqda+hNM7OYKc5SG+VWTjVsAf6PbMq69pND6W2FgEjZApSFFlFWA7x3honN+3o0AjapXZ7TdfkrMvJL/gnth24AK8gqXnZo0UJTp5c4ae8Lv+27L5gZsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abaUXHyq1h64r/cdcONIRSTYLX8igp5kmIILyS97b0I=;
 b=AL2loyOvYBJYKxkTOqBkDeKMh9H6lSOGFqaz6SVnSmyxzItp9XVNmowcUK7funJMH1PMUe41yxm9qI200hmotVrRAbMAogmYyDCz+c8+JxjsYiGLUrNOmv5K6FP8TWwzzXJcYDmiOL9zAQkbHbKA3we1RUg5r0tkFIx0DcWc13J4BXtQRbyFpqjqbdYYWoVdCLRvraS+UO29ruXR1ld3bz7GQ1XtvzlORnfySYWEJEjyqqjiYn7RYNZVYUY9rU9DonQWcRrbA+b3/bRrwcj2bmgRr1WGvX/7tQ4c7cvyB5kChycC+mWz7cta5jcWAm4cYv0bW0bZj9yxHBdTrxXJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abaUXHyq1h64r/cdcONIRSTYLX8igp5kmIILyS97b0I=;
 b=IgNYnSgwxX+Kg95bbuCfaQL/puKGQy+hEuUDGnLVA8Ijnt4elCjaPSsUvOknOc0TAvGtlE0Pg/PKqHvu1/gI8lFwC9a6qI2NqZfY29S0sZpQBFmzEIDjETqjCu/0RWq4abFEMaCnqLZiWgZITHPsQ4N34AQa88Yz+0b+xVWIR5o=
Received: from DM6PR04CA0024.namprd04.prod.outlook.com (2603:10b6:5:334::29)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sat, 7 Sep
 2024 08:19:20 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::4d) by DM6PR04CA0024.outlook.office365.com
 (2603:10b6:5:334::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.19 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:19 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:18 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 01/20] cxl: add type2 device basic support
Date: Sat, 7 Sep 2024 09:18:17 +0100
Message-ID: <20240907081836.5801-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: befc506e-5065-404d-ffbc-08dccf15c5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?suJ9Ir30o5qkV2RUoBcZm6t71PSyHSj8PSU4LIHJ6ogPSA6NR8+eCB/gkhI6?=
 =?us-ascii?Q?DqIXfkeQb66nLdPdk7zGvgmHX9KcfKKBBOePmE6+KA2rFOPA0lws8jqHiYIg?=
 =?us-ascii?Q?02ohQwFono49pb5kjo7dZ1aTwgO8I5JPYgpSJ5h8qGNqfXVFCqfzRfMn62eP?=
 =?us-ascii?Q?R6V4I/kKbKSbxtQUnNcBBTizmiPP2FPvC1xAvrHMD16VV/+wGuRPNlYGXygZ?=
 =?us-ascii?Q?yKPgKmhawJD/l31TYDGVKJ9N3Cb3+CmToPWqRqps7/CrcnpvIitRGul6nXUV?=
 =?us-ascii?Q?om2DDA8BaD0AVewRuHh5/Zu3q/9nGGqQgSC+WTeFCtK6hFoeIYDN+N+k0nP4?=
 =?us-ascii?Q?CzwvfOd/My1roY4ReVZlKuRDbCTdurgSCSOGvqXOLnzkjGs7Hdk27TbZ/0n5?=
 =?us-ascii?Q?lqbPPlHGV1aFEiz3S/7Emi+3xT/zsr8T6UGCmZATbM9b4D/T3zww4D0U7gbQ?=
 =?us-ascii?Q?eTPBY3+61ZFth4EGkQpZgjXcHyLEgA9FfszMckPbDVrHaw7xwNaOlx/Wfb6z?=
 =?us-ascii?Q?wKWUD556ErIoSmZhPAEorGXnyvs1Vl6mHV9Ohc9UdHoZV3bC3nHGHhJUEfPo?=
 =?us-ascii?Q?a3DZCWhncoLxavuMuePNhAePMKYAxtpeFDjEQmHpDry2TJkU29MI9CQ5KO6/?=
 =?us-ascii?Q?n68YSjS6uT3x1PJrr12AXYb3aoflPFZygoGHMQ2d6tzduZkJhof3SrTfXr/+?=
 =?us-ascii?Q?LdYVV4EvTh9CpXbfUTJBItb7AqueYZkyMnJYxMIuBmissixoB4mLJZOgEMBf?=
 =?us-ascii?Q?vLMlTR10C24RBAMZZ1qmkTZWzEKJ17DQqe9LtgKizCIj3HhoOMpC1vnlG/8b?=
 =?us-ascii?Q?Wtdv+P39ommQiwP0MGFGLriR/CKiNWTU6vxUtl8XZ1YEaEns8yBw5uybW9EY?=
 =?us-ascii?Q?Jt9rGKRxJuwAfiaKIke0Or0+9TMHqght0KOU4/iIdXx/glGK5STKbHfWrQA6?=
 =?us-ascii?Q?YIucSdok+YrI0BGkIxv/Nelhrv2Cz/u8jJmoahTWwcwAio/cxgehOWMf9s06?=
 =?us-ascii?Q?qYj1tF0pBI4no1Si1HoJGHL/tek8gWb8U0hGY5BPAeYm4H/ZfBug03wUQKhl?=
 =?us-ascii?Q?AwsYaPoYdgfPjxzLbc3QHiTsb+DMjeYCtASSKwBszF+VnVWY5Ot0Auiwryzq?=
 =?us-ascii?Q?Ub4HFVSYLCVx2Mte5AIrZCCIcWQ9dEXTuW4PJ4uIcez6nz42+cK08Pd4rFT1?=
 =?us-ascii?Q?icC0ABIxNItSLue6pzqixBPtIfGN+LGD18ofon8HP4diNHA65idlzuTuW0DR?=
 =?us-ascii?Q?DN5BWxX71IRvSwszSTDQFP8GVUvFYAQQngolSVB97j/tlaH1Opb6GFQspQNn?=
 =?us-ascii?Q?lhwvrJVkZ1CH6IR1Gub4yhvgYCxsH3GQEjVQ9OBv58rYGSOkDbex/FfCUS+9?=
 =?us-ascii?Q?NxteSvUaX+dQxT+iGttRkrr6ieHOJ7o31SWfw2+ZG02dw9G/lNrzX4xUI68e?=
 =?us-ascii?Q?rcAc3Q5pB/zoaVxI4zflckEGb4RspYXH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:20.0711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: befc506e-5065-404d-ffbc-08dccf15c5ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864

From: Alejandro Lucero <alucerop@amd.com>

Differientiate Type3, aka memory expanders, from Type2, aka device
accelerators, with a new function for initializing cxl_dev_state.

Create accessors to cxl_dev_state to be used by accel drivers.

Add SFC ethernet network driver as the client.

Based on https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c             | 52 ++++++++++++++++
 drivers/cxl/core/pci.c                |  1 +
 drivers/cxl/cxlpci.h                  | 16 -----
 drivers/cxl/pci.c                     | 13 ++--
 drivers/net/ethernet/sfc/Makefile     |  2 +-
 drivers/net/ethernet/sfc/efx.c        | 13 ++++
 drivers/net/ethernet/sfc/efx_cxl.c    | 86 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 29 +++++++++
 drivers/net/ethernet/sfc/net_driver.h |  6 ++
 include/linux/cxl/cxl.h               | 21 +++++++
 include/linux/cxl/pci.h               | 23 +++++++
 11 files changed, 241 insertions(+), 21 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/linux/cxl/cxl.h
 create mode 100644 include/linux/cxl/pci.h

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 0277726afd04..10c0a6990f9a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. */
 
+#include <linux/cxl/cxl.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/firmware.h>
 #include <linux/device.h>
@@ -615,6 +616,25 @@ static void detach_memdev(struct work_struct *work)
 
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
+EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
+
 static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 					   const struct file_operations *fops)
 {
@@ -692,6 +712,38 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
+{
+	cxlds->cxl_dvsec = dvsec;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, CXL);
+
+void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
+{
+	cxlds->serial = serial;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_serial, CXL);
+
+int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
+		     enum cxl_resource type)
+{
+	switch (type) {
+	case CXL_ACCEL_RES_DPA:
+		cxlds->dpa_res = res;
+		return 0;
+	case CXL_ACCEL_RES_RAM:
+		cxlds->ram_res = res;
+		return 0;
+	case CXL_ACCEL_RES_PMEM:
+		cxlds->pmem_res = res;
+		return 0;
+	default:
+		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 51132a575b27..3d6564dbda57 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <linux/cxl/pci.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
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
index 4be35dc22202..742a7b2a1be5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,6 +11,8 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <linux/cxl/cxl.h>
+#include <linux/cxl/pci.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
@@ -795,6 +797,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_memdev *cxlmd;
 	int i, rc, pmu_count;
 	bool irq_avail;
+	u16 dvsec;
 
 	/*
 	 * Double check the anonymous union trickery in struct cxl_regs
@@ -815,12 +818,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
+	else
+		cxl_set_dvsec(cxlds, dvsec);
 
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index 8f446b9bd5ee..e80c713c3b0c 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -7,7 +7,7 @@ sfc-y			+= efx.o efx_common.o efx_channels.o nic.o \
 			   mcdi_functions.o mcdi_filters.o mcdi_mon.o \
 			   ef100.o ef100_nic.o ef100_netdev.o \
 			   ef100_ethtool.o ef100_rx.o ef100_tx.o \
-			   efx_devlink.o
+			   efx_devlink.o efx_cxl.o
 sfc-$(CONFIG_SFC_MTD)	+= mtd.o
 sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
                            mae.o tc.o tc_bindings.o tc_counters.o \
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 6f1a01ded7d4..3a7406aa950c 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -33,6 +33,7 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#include "efx_cxl.h"
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -899,6 +900,9 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_pci_remove_main(efx);
 
 	efx_fini_io(efx);
+
+	efx_cxl_exit(efx);
+
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
 	efx_fini_devlink_and_unlock(efx);
@@ -1109,6 +1113,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto fail2;
 
+	/* A successful cxl initialization implies a CXL region created to be
+	 * used for PIO buffers. If there is no CXL support, or initialization
+	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
+	 * defined at specific PCI BAR regions will be used.
+	 */
+	rc = efx_cxl_init(efx);
+	if (rc)
+		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
+
 	rc = efx_pci_probe_post_io(efx);
 	if (rc) {
 		/* On failure, retry once immediately.
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
new file mode 100644
index 000000000000..bba36cbbab22
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ *
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#include <linux/cxl/cxl.h>
+#include <linux/cxl/pci.h>
+#include <linux/pci.h>
+
+#include "net_driver.h"
+#include "efx_cxl.h"
+
+#define EFX_CTPIO_BUFFER_SIZE	(1024 * 1024 * 256)
+
+int efx_cxl_init(struct efx_nic *efx)
+{
+	struct pci_dev *pci_dev = efx->pci_dev;
+	struct efx_cxl *cxl;
+	struct resource res;
+	u16 dvsec;
+	int rc;
+
+	efx->efx_cxl_pio_initialised = false;
+
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_DEVICE);
+
+	if (!dvsec)
+		return 0;
+
+	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
+
+	efx->cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
+	if (!efx->cxl)
+		return -ENOMEM;
+
+	cxl = efx->cxl;
+
+	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
+	if (IS_ERR(cxl->cxlds)) {
+		pci_err(pci_dev, "CXL accel device state failed");
+		kfree(efx->cxl);
+		return -ENOMEM;
+	}
+
+	cxl_set_dvsec(cxl->cxlds, dvsec);
+	cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
+
+	res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
+	if (cxl_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_DPA)) {
+		pci_err(pci_dev, "cxl_set_resource DPA failed\n");
+		rc = -EINVAL;
+		goto err;
+	}
+
+	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
+	if (cxl_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM)) {
+		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
+		rc = -EINVAL;
+		goto err;
+	}
+
+	return 0;
+err:
+	kfree(cxl->cxlds);
+	kfree(cxl);
+	efx->cxl = NULL;
+
+	return rc;
+}
+
+void efx_cxl_exit(struct efx_nic *efx)
+{
+	if (efx->cxl) {
+		kfree(efx->cxl->cxlds);
+		kfree(efx->cxl);
+	}
+}
+
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
new file mode 100644
index 000000000000..f57fb2afd124
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef EFX_CXL_H
+#define EFX_CXL_H
+
+struct efx_nic;
+struct cxl_dev_state;
+
+struct efx_cxl {
+	struct cxl_dev_state *cxlds;
+	struct cxl_memdev *cxlmd;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_port *endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *efx_region;
+	void __iomem *ctpio_cxl;
+};
+
+int efx_cxl_init(struct efx_nic *efx);
+void efx_cxl_exit(struct efx_nic *efx);
+#endif
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index b85c51cbe7f9..77261de65e63 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -817,6 +817,8 @@ enum efx_xdp_tx_queues_mode {
 
 struct efx_mae;
 
+struct efx_cxl;
+
 /**
  * struct efx_nic - an Efx NIC
  * @name: Device name (net device name or bus id before net device registered)
@@ -963,6 +965,8 @@ struct efx_mae;
  * @tc: state for TC offload (EF100).
  * @devlink: reference to devlink structure owned by this device
  * @dl_port: devlink port associated with the PF
+ * @cxl: details of related cxl objects
+ * @efx_cxl_pio_initialised: clx initialization outcome.
  * @mem_bar: The BAR that is mapped into membase.
  * @reg_base: Offset from the start of the bar to the function control window.
  * @monitor_work: Hardware monitor workitem
@@ -1148,6 +1152,8 @@ struct efx_nic {
 
 	struct devlink *devlink;
 	struct devlink_port *dl_port;
+	struct efx_cxl *cxl;
+	bool efx_cxl_pio_initialised;
 	unsigned int mem_bar;
 	u32 reg_base;
 
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
new file mode 100644
index 000000000000..e78eefa82123
--- /dev/null
+++ b/include/linux/cxl/cxl.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
+
+#ifndef __CXL_H
+#define __CXL_H
+
+#include <linux/device.h>
+
+enum cxl_resource {
+	CXL_ACCEL_RES_DPA,
+	CXL_ACCEL_RES_RAM,
+	CXL_ACCEL_RES_PMEM,
+};
+
+struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
+
+void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
+void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
+int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
+		     enum cxl_resource);
+#endif
diff --git a/include/linux/cxl/pci.h b/include/linux/cxl/pci.h
new file mode 100644
index 000000000000..c337ae8797e6
--- /dev/null
+++ b/include/linux/cxl/pci.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
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
+#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
+#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
+#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
+#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
+#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
+#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
+#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
+#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
+
+#endif
-- 
2.17.1


