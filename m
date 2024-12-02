Return-Path: <netdev+bounces-148159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D159E0985
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7AF16277D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F2E1DACAA;
	Mon,  2 Dec 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xye1VvnU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265821DAC90;
	Mon,  2 Dec 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159564; cv=fail; b=Gc+pL/mu8ppLUS3aMgq8bwUmiYvV9jvu9Z0hmA48aNN7qpYLo+TA5zjdb0TXJ3xRljzWZ46l433Bjg1Vcvxsy8qWTsKOsccerv/P3oOHcGiKggFmh0u4yR60gRk46qIlilLyNjnZMB/Xg3+NFyeTW2DWb8hDb92BnIV9qIVrWX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159564; c=relaxed/simple;
	bh=42sOjJh5kJ5puS/E2737hg4pta35sh7/SVQmnuqHh5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8PKdSI59OMlNPQF0qgivSx5B1t8AS1CULkmaGH4nL7cRn4qzS0jqPAJAbRPvvf3EGi8Dz94/L9Lxai2qlmvWYyJS5uYXHR2B6SQtNuU8/ZQTCD/Qpq8qOdvvkWPG7lPBHEQXlixxgu5BLMa84NJ1WJpI2i+iUJUUc7BZX+L4Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xye1VvnU; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrE0EE1Hu/iEbWofTzlvwqJo4n+PhUMHGk6OYgNjClqoBklzqS1pR3PsnbOETY7sJklr6U9kEDAMENbMcA7/4MR0EDzPLNv7vP8Hen56mlVOHRwbEY2Ln7zTN8sWN1s+n326JL43KYb0Y/dxMF8xQBVWJ5fR+76Ja96Yi05IKzLZsXSXygXwEAW1rqFY/KCUDTbmARnYhYLN++z3Q8CsvC0UVf55Tolw/lh+wqhaBY1pKokReQsRV4wEgIlINVXdesOYwtGDdKfR43fmAn31wHmUduO6GzQnZb/kUaZ4Xmsc0INE7TIciUeBghFSGWpX/Z4A0xP/7+8AktEl++VijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vd48k+FYqHP+OCWS2VEpoXonK44uVxCGHm1hDITlENQ=;
 b=GXyKhkPkwdip4G1QTyslxnPHEFwYBp5EDHY0pW5PISYAiFsDyLHZTGNJ+g33t3xuvezMb5yhlBjz2uZuVLpx1Qp0M0RkJHdLq8Bo014Vf9jecf0SmjN83QYhOQ3qqBxPgr7I8sG7wtHsyAibr5EJEhWhA1TKtbwLN3fp1nVdXPqIZI/YLmzBg23wr5uR3GLm1F1JkCVPKWO0gOHeGsXGy0DDGtvarY3+c/T1gp2u2+cu7xTE7196T/DiD86YNYhmulmLsXZTcDhsPNEr+BtpTNnC1cyaKvhLmSZCHQehovOq8Bh5Kwi+FGP8kQiFg0OsTqnoezfGF75HZHwJMOGM6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd48k+FYqHP+OCWS2VEpoXonK44uVxCGHm1hDITlENQ=;
 b=Xye1VvnUEZY0xL9sWbjyv+vq5UdDHWquuyubIrgewrCYYHI1qxeiVkJrjifmib/2wI4yN+yA7SrIe0eQ2KCzx8n5bir/V/b9izEtSNLH4ByMjCIXcUP6bYoJJ0vv8cIO5I6JlurOExyxlQFNvLE7FJBfmj+hZW7nFLoQdc51Qyk=
Received: from BN8PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:ac::15)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:12:34 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::54) by BN8PR07CA0002.outlook.office365.com
 (2603:10b6:408:ac::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Mon,
 2 Dec 2024 17:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:12:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:33 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:32 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 01/28] cxl: add type2 device basic support
Date: Mon, 2 Dec 2024 17:11:55 +0000
Message-ID: <20241202171222.62595-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dcefbb-c4b0-4ffd-bcef-08dd12f483b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BMMoansH9SsmxXFJj5296V5GeF2hcWg0bGOeCP3FXldlVQ0ood931vpXnstc?=
 =?us-ascii?Q?CiF/xkRKTQZnsspyOsJ2ATFe7kOs/NV59d9fDui7Fm2pQHIhCWxYvhI2oNOF?=
 =?us-ascii?Q?pWuWjFb1KXKoVtzswI6Scx9fx/uvIk/lcrgunh1VnuSwH/Y0qDcXA+4s4CQ8?=
 =?us-ascii?Q?/j3QXRihaZnjc0i4iVsb0ZH+qJ/AF0/u3eXglilhWVu/rfAyGuEQd46BbqSj?=
 =?us-ascii?Q?XmNPXBhhpTO+8XsTBrkAqYP/aNTbBfFsMYrKxOCyGvJYyyloVHwzBLFGPpPU?=
 =?us-ascii?Q?Dl6tp1Wkd59Si4PAGSgPhaA3WJsdq7sTIne9trAOilMW6N2fYer+FrsbU44p?=
 =?us-ascii?Q?1BkwuEqVW12lrH0a3nJdFqh1o+hJooOXPUwhjJZYoPgEg6yZ7sw56UacFZ2r?=
 =?us-ascii?Q?wDTEkum/J5tHDMaaBBxoYnkduYzq3mKCXNsTiyN1Nv7EtlJWjJPcZD32dwYp?=
 =?us-ascii?Q?euzkzntXSyrlm5F0pTcvMPgpQVvokDsqKPcucI6gPL7WYUbWhpBOu4mZ1F0A?=
 =?us-ascii?Q?212dBFA01+7IRRlyWnfNnIFGsXSJM4RIqTMoz5IroLLfkiUebor/9YCIDqoF?=
 =?us-ascii?Q?l/8WuEqOw68hwlfO2CjLkVKGoYCI1RNiLLRccVHZzJVCjL1NGX+ikBmKusuN?=
 =?us-ascii?Q?CuecZ2A1NOxDdheLBRchWhcph2xVdHR1OIHEN3JdlqwHJHRX5hM2pzFGPfl2?=
 =?us-ascii?Q?rkfKRXjjrUUnnlboJsg+uAUyq2YSc7trQtY0alZYhA1Im1h3kEkNhzfCWhnP?=
 =?us-ascii?Q?jbdx4g1I+qiYBstEnyvSfG6vbPrTUoYzpDXI9RSdwvFQBxIjP4D10QZep2/J?=
 =?us-ascii?Q?rumJzhm9EpdlOuCpVMEOkFhto+etuhISJZ95zL8/4q/aOMtHP+lojYn1jXpP?=
 =?us-ascii?Q?t0cN+M6DCu0P8GhlLasVW9Ih/Sxsb3GimzPINAgZNzq7P67LhBBjPLrhCah8?=
 =?us-ascii?Q?nslaAfAVkVDQZhwueU2JfVmJYB44ZcDahvNuQzrHei50aMQGDgfff2NeOtFv?=
 =?us-ascii?Q?uoytayW7GMYMoMY27MCTYFLwAMr12FxaY76Zv0jFgSzD74bbFZ03XtpYuqg+?=
 =?us-ascii?Q?Gk9YZR+pWSofFPqdAisjXslviGED69Kjlrz5zzKs8Rnqichrsw19omqyW7Zp?=
 =?us-ascii?Q?SOejrhI5ax2GZQNeYUpGYEucOP3WLBaxjqCEylhEZ47AkTVJuSkfulG2sqPX?=
 =?us-ascii?Q?IpKLhQXGc/VeJUqbM1789DkEAVBWzjYNNQgP7Xs0rYILr7IiRnaOR624Lgl3?=
 =?us-ascii?Q?37INFtox9mwDsOO0NhzEor80P+tbxJIRFtE4Pdgf5RyzDt5nMx2Jhgs1pJUL?=
 =?us-ascii?Q?mpILIqv+82uMB81hnP2iFW2md5a6lgYjxfQS3Ct2O9kGNMnJPycI6aT2E9fS?=
 =?us-ascii?Q?6hkl45Vy8z64dUSZdAh3lAQSs6XdpaRxz+r+zJ3yb3CQbJEtQV/XX4l9ROlg?=
 =?us-ascii?Q?kWOHv22EE40SoEU5SYMITBJEvhP2Sq+PMWCWQXtt9WhrpOYkive+TQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:12:34.6677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dcefbb-c4b0-4ffd-bcef-08dd12f483b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745

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
---
 drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c    |  1 +
 drivers/cxl/cxlpci.h      | 16 ------------
 drivers/cxl/pci.c         | 13 +++++++---
 include/cxl/cxl.h         | 21 ++++++++++++++++
 include/cxl/pci.h         | 23 ++++++++++++++++++
 6 files changed, 105 insertions(+), 20 deletions(-)
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 84fefb76dafa..8257993562b6 100644
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
+EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
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
+EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b46bc46aaa9..7114d632be04 100644
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
index b2cb81f6d9e7..6c9a6fb38635 100644
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
index 000000000000..19e5d883557a
--- /dev/null
+++ b/include/cxl/cxl.h
@@ -0,0 +1,21 @@
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


