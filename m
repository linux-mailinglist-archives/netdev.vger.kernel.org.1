Return-Path: <netdev+bounces-152278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2E29F3575
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 658217A331E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC27205E04;
	Mon, 16 Dec 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bIfOdJgn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254A7205AA5;
	Mon, 16 Dec 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365461; cv=fail; b=ILoyn5oT/X/0CuKDfrzaQg9B53p1ezLC8r5USg2O8GD68RHaUyWI+K4ykRAGGrHvlcZSWpOsGaC6YY7CBIUE4DZBZ7xJwZ8KI5mV/lYCeO8clo1RF0Q4F115x9DBywIz+4n4TaYa/jIV7fBEbjhqZVWM19cip94mExUae08ilMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365461; c=relaxed/simple;
	bh=MDMS2/RzLdIBAeeTu9/dlneAWhRhWPbnHi8F3R5j2Ic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpvDG1Cp25H8TJaKAMON4yf3l0DZzYJLkkZ3HQ7ASyfR/eeEJYLWsqonZZQruM5OGXTPmxgN31X3lOdW1vHA0A5lVNgLKwi9e/hxWtunHD+cTuts1NYKzmO0x0Q6jVjLkDOnFEGICjIIqKnk/fWeQGN6aRCbjZNLfujRIjq2tZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bIfOdJgn; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEx/7A6dK5WX7BpZ6sfKihDknd3/x8yaZ+qU5J8H9LIKAht5WUL7Ucu+kUsdGbVLV8bBT4gJepG/sT6BH+Cqez89WtsvDNLwM8q5AbbODlE922nSF6I6KUwNY3C06CtWIeQWX2eBU7HdehPermTAXwCZfy90V37bP2xkzkpLN3DtkXFPUeBXUTq71uy6nZM3ZjdLVlSHTMzzBchRATqTfsLvjgIN0cRQRwedP8h4ZoFEybB8d+aEDKBltKjmjAnsGxrnxxDhcRK8V+OAB0Otq0LTRwdbwdfJuwFrcfnStkPsBkVbR8eL25xmh2xgCEmTqHByPWn9CxFpBhuNqrjNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XojQknrj0L/R9l6nsXKtgk34ToZauL9dD+jgpspN7ws=;
 b=oTFL+jE0oT6XxijFtNHKrrirwP0gpY4jdQK2U0RrLnCNKEmQBD6Yp+ce/T2rs5yVEGllloGkA47ogXV5XO+D1YVFGbjKYrQ7dIRtaAMP/I08mZFQvnQsx+dXTmu1D/ezPCijlvssWuDt3tAytmEt9YktlZk7h4Mtz3aDvwp6j5JUgPrvZi2Fjqt4ywjerkrvgQz0Ui2bqaR5DkGSxQcBmkJtHbNvbIOlXuhsHVzHnyrMzve782QLFcXkO08yCPJiJ7IZJDbZitDtzIlmnMcRTj+KWOk6cfuhfJBp1tAP+YydlsLdQL4KAHkDpfuylevhmacd5ZnNVHVwIjSvycz3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XojQknrj0L/R9l6nsXKtgk34ToZauL9dD+jgpspN7ws=;
 b=bIfOdJgnbUtu7aWFZ7gvGcPiITPPGs69yWdVEgi77x7rhceTqZ4UYnd+2aeN0KTZs1K929mmXvYnQ69j6LZJniRyaBA1iuueIpUYvTL+rz+intdPJK+WD4ZJXE25rNx7FPbmUJFxtFcAmEjyuTqRU//mQCSct6aYU5IWqD3dhbM=
Received: from BYAPR21CA0004.namprd21.prod.outlook.com (2603:10b6:a03:114::14)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:10:54 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::b3) by BYAPR21CA0004.outlook.office365.com
 (2603:10b6:a03:114::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.10 via Frontend Transport; Mon,
 16 Dec 2024 16:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:10:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:10:53 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:10:53 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:10:51 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 01/27] cxl: add type2 device basic support
Date: Mon, 16 Dec 2024 16:10:16 +0000
Message-ID: <20241216161042.42108-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 860fd82d-dd05-412e-4b74-08dd1dec37f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o4UvcgK1nCplY3NOAF9TxPvC8o/66cd6NTCNEYXUqEYYF+RqXFM3r7s/dSRV?=
 =?us-ascii?Q?jfyREn3qw4ZBD3t6PRSEGcAyOnU+A6X0DxhUhKieSB/xMDp8gJP4ncCOPD7H?=
 =?us-ascii?Q?nlWKjnGaNPlosPx4UxLmKtSkEMdnZDCFJ/DvE50KxyN+D/ugFHKJRE6orY9B?=
 =?us-ascii?Q?NhDuoSuz1sb8QC6Sp6FZCtS6hq0IWl/JlkGVpM/pYvm0bRLouYHE+/1MxWUw?=
 =?us-ascii?Q?9Yn0pyndxOompgfCQr+XytCsoZIDV5bhPDu+u7JRbwABZEh2Qwh/OGbOim8W?=
 =?us-ascii?Q?O/UJss7yCENuP4G9kw2NWy59cayQMuWCfwAYIjq59L6J6gojbxnflzk3tNcB?=
 =?us-ascii?Q?hQ0fLpuvSBjFT6NNwZKYi9Q16x0JcRMnVWIiVSENYWSVxpSaz2vbGxtpTLzj?=
 =?us-ascii?Q?Y00tigsuCdkEYuium9CHBZDKna/gcHR+EIr1iLe1mkwtGMvxnmgNrxtNO+MQ?=
 =?us-ascii?Q?7hANZXNxbzZkItXL4PF+D/OqlL6FwtLrc36VajsDGy49bobRRno3c34e31NE?=
 =?us-ascii?Q?b/tVYn8867jUvu1zwES9mQ3UOpPYyPKk5nYk+pL/4Vi0Sdix0nVCFmAcRtAC?=
 =?us-ascii?Q?LhpvGPxA0dwtStlGN5J/Wd1ee3gf4WtswVIm07oMsW07dptLlJM+ZoNvHNqY?=
 =?us-ascii?Q?BVZ5AGDa/rHACpOshnhGEA2X8AOWXl2IQ1YChxNwtPNRvX9253iKZVcMWi5i?=
 =?us-ascii?Q?sulFIGUdjvrjSovNMee/X+CKsvA3lQnh1DFP9LsVz2Oxjjhgpu3W3omeC2XM?=
 =?us-ascii?Q?M0zbSQna3eU58zVqvG0rlyYDAMkKh2lbF68FXya+DdUcLxh0d3UKqLccQLx+?=
 =?us-ascii?Q?8XMPST5DRpaOkKe92kOOdzruSGaj5si+vmSnTwGjQhKaOP71eP1TUki8fMQm?=
 =?us-ascii?Q?LD8aT6j92a78b16uq3OddXrUQZ5IY4VExCnc9FyypwwJzAfivcID1nde2b23?=
 =?us-ascii?Q?VBe4G0rjbY2QixJ/gahby4fWizWuuNikdq/QSb7xqkNZBt5bWuaG2snDjjW1?=
 =?us-ascii?Q?QXI0z0j3jERKWLJaMzrcMO6nUEk2x3NEX4pXROcPwzJyWPUUHg4NZO+tdRPx?=
 =?us-ascii?Q?BKtI9auSbTbAo0xlhFkW5uEu3963/ANveQNwUFSdgHSJcu9HNrQry6SR9ZXX?=
 =?us-ascii?Q?dHZidXUtL/Y8OIPwOVy2PX+KnCSpvYLnXjOnhAkPITTQzdQFqmoBzEfUoIrJ?=
 =?us-ascii?Q?krgaP12Qb2mnzD9/QW7040pnTfTfyog1xyX9Manqq1OKTTYkNcazG9hfGiHu?=
 =?us-ascii?Q?5LPBLtADAEVij0WtrLCvgfPtwYBXTAanzynALCNHyLzdMoDQrekyWXML08hL?=
 =?us-ascii?Q?wzUylZrVogDBfzQxQPQba2GJkpTLDIcH1bLjAlvD2e7+aIhyke1sy2FGljs/?=
 =?us-ascii?Q?1MDl3DvDiZqYWKg2rJWj7drbQjNBUgmVIjrioZNqz/cXmohxSZ9Pwm/g02Vn?=
 =?us-ascii?Q?jYdrFDRTqgM29CiIUoMvd4JTz9P4e1eR1VU7bX8X4fgjH3Zaqz96LQGWlzI7?=
 =?us-ascii?Q?vkl/HhKTj9pofiadThugy2VJuf+xs2Tjegxp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:10:54.3487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 860fd82d-dd05-412e-4b74-08dd1dec37f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732

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
index 9d58ab9d33c5..c07651cd8f3d 100644
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


