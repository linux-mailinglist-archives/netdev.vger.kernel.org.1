Return-Path: <netdev+bounces-145938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4574A9D1591
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F1BB25BE4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C341BFE0D;
	Mon, 18 Nov 2024 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KZeXl5gW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254C61BDA8C;
	Mon, 18 Nov 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948291; cv=fail; b=azUOPlHtszUSxtFmeBQlx4uWwV7/0qREb1lH7Ul7mTJ5ZWj+emvngMlOg5JJBxCMaMTsrTbrrWnX3GhGgX1TRJszd7UBQVl1dxpvHpIAo+R7d+s7JnajhMEPQp77KYrLg1/JRsBazr7u+4F75/61N5GFz3ceAPh2pTMqWr8i2Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948291; c=relaxed/simple;
	bh=jiV93matfl+5luOOZpVWubepIWkWlQi4HO+DxquRdL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULmkfU9MXQlyeYErGe6FEIbH/v9LESdSB/Sm+tqJoo91WOZn/htGmggFMLdovRxAEvdy5RWxnGcyZe6xp7DliAiYHzjvcWvW95uooUGVbhqMKV9GiqWaKLDq77niefi4KZ4GGbDy0+KvAy99at1uoRizH59/Cf+OIbz8xVzOnEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KZeXl5gW; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqvbTGQKtNiG7BCaclEs3MTvKj04BfZ1wFrTIfRU6oZmogMHvyBjCLBBMEEGjyvN6hHwFP7RcSSegBntyAJj8buMyCFgIGMTDzmq2tBG/MVRMBtVQnYQ85qelceF5nKo81iKyRRtsqh0K4FhVZfjYck1hc261NqUcVwMlkf6HeKPIRxfybvy9DFmcp9d7998UZOyh5hSFp9cyDmokg0CrcEbVr9i5oFZv2dgLmhg/ucJfzAsmQ59brZuLQiTiKZxFPj2M8TsWpeWqNGxlPOVIOYYUIt+ER9HZW/2JyHu/6obCMjkg6/NN9p9CXORQRnbWaMH1/8uvm6qb33j7FGZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/1sGgI0p0Ba3uyAscDtlaUYBJMXgMq2Dm+Xd3OWci8=;
 b=zRJEzO26YObd1MrfRkDjdrqFtGMoeMAawGZksA17EEyR5OAVNY97M+pvNiN0DzaIl/n9kBwTpwxWf/i6yedBg1Abc8FdB69xLJh/3mfFp84ByqyOKgQp/4ug3meAABMkJdUIJ+76VcA3pKrw+0ZWWX4Ye9cZNZt7w8hCRPWcL50TQlmN2xLui9keeEmJwzEynbdbjRUB8DPrLry+WEEB9VGBUKD4yjyANL6owQB48bOLp7wgW0UTQuaCeSyAdGJ+NpCaZbussTtVxdbIVbDPzCwA9BuhbmYOzW5P8NicvVva5OR8WBmsEMCWSTKO6jVCDYXmoiTb9rOpzHXXypwbJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/1sGgI0p0Ba3uyAscDtlaUYBJMXgMq2Dm+Xd3OWci8=;
 b=KZeXl5gWmnuhLigIKjO781JoL0DlG2GO92yyuv8Pmc5HyAEHW4B5xXIuzrl+nCiWSAzO9FYYy2tzjtb1JscbbyLTHnelpLCn/8XaPJPhBzhh4QPn+/KyUGVDx1s4I672sJyRzANR13WYi7hfRdGtem5q386S+jNZznCsCxMH6ss=
Received: from CH2PR10CA0029.namprd10.prod.outlook.com (2603:10b6:610:4c::39)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:44:46 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::ec) by CH2PR10CA0029.outlook.office365.com
 (2603:10b6:610:4c::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:44:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:45 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:44:44 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 01/27] cxl: add type2 device basic support
Date: Mon, 18 Nov 2024 16:44:08 +0000
Message-ID: <20241118164434.7551-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b6c13b-2748-4849-f915-08dd07f04f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V9RWlsvCwpApW8oGETKk4+FjynVdjyilwQSCxBZqnMO2WJOdrBxmQysZ/+Yp?=
 =?us-ascii?Q?20baOpDTKX8a7X+eUXm4/7AulOz3i4+fQBPq/RUga576ZChtiTQPuyN+SiLk?=
 =?us-ascii?Q?8eKsHUqlSx3OmdBKr42NGUK/ceO5gh4PEG6ISMYsnRh6hesPYj7M3fSjCGfk?=
 =?us-ascii?Q?ERWqu5qlR6T/eF/QJnbRrGerQlCL0xFVSKQVJ+o8d2Flj4/fKn5Yt0whleFK?=
 =?us-ascii?Q?SRxuln3frEME/bvxPstyBzzWf+IWKE3CajS9a+9qJAvLsjCqXGkpleUVfPR3?=
 =?us-ascii?Q?xErGQTnhufY8MSurJQTvXgGgTaJZEnLctXiFTx3JplIBNQRVht5/RRBneR8P?=
 =?us-ascii?Q?TOggTZlW0JDo8wTJ2vKZx+2vdgA68Q1gQunGzoUTb2dVG6Fp/lPYPxautI/d?=
 =?us-ascii?Q?LdGvJWH1zJPn5cc2iRuaeXk8xYaid6Fs9/xwWBSp0c6xFOzYqdA/WoiRRzpK?=
 =?us-ascii?Q?healn+UYBRPTFP7k0wOuc0oRdn8ONEMm7BhrtvQHxg+J2LuzdDXLx6Ual735?=
 =?us-ascii?Q?l59a5N2IUr/4uz9/ZwR3Am0t9/NRhtKzdX6Zrcwtpu093M4AjuwMTJd69AD0?=
 =?us-ascii?Q?eYlYZzuBYRfwQoUYLXlc8UH9D4JektDFldV6RmA9+N2fEtPIg9P/21BEIuPC?=
 =?us-ascii?Q?12C6CV6cinYKOou5Q1mbSm+IZ1X4+peQ55tr4pEFCebE8cBAaJGR3hCngNYE?=
 =?us-ascii?Q?TK1N/EaJjZNgNnVGKbfCnVTttPwsq+J7DU4PJVhQoqZV+ilKl3aQ0eE/abSS?=
 =?us-ascii?Q?PciTpd1kpjgzhY8ILPwTuAhWcRilEvwCuJKC0Rhy0zcMWHbekB4Tc8p74hTe?=
 =?us-ascii?Q?EflD0Qd6x3rrqtbd0lbH4gFIoP1wRAgVpLlMqFLYPCzKLH8xIOyy0IOOXp94?=
 =?us-ascii?Q?GF0rWITvfpHSHcKppQ938Ecl/5Qdy70GS07XXIt0lL/C7/j3rlnhm5qnn3Cs?=
 =?us-ascii?Q?rLqm8QKSklqQosg9iRSvguEi4NdMKEvnZkNOKdilCZih+Js4adOVo77a3BCA?=
 =?us-ascii?Q?1TIontfto9DrJyAknrMycoZbDwZwlEmvJWLcZhsdCHGBTEXPXqLwsHDoFhSC?=
 =?us-ascii?Q?DQNjxBaPzIMHH14GvdpRJJ9/wYHjG/smUxE5T0nPL3Vyy6SpzNyq8vDlRb4S?=
 =?us-ascii?Q?DxVlOJYFbek/XqOquCf5JL84+bx6ANe3A2X+ST5RxD9tzNA8EfFiDIzxteBa?=
 =?us-ascii?Q?GNCWqNt6tm3I9L+z/Ozji+RfkV18N9C+Q1wga56zEaJ9Yab7m/66mYhpAjh3?=
 =?us-ascii?Q?5YAFw7fe7vOTKqg96DxZRvPnKFGeqReYxJLcFDH/26UqwHaSxIuQh76tdzcO?=
 =?us-ascii?Q?AyJOCnHJbkHSugDig5rqCd591mG7Ss5eK4INgrsJEashidllY2/4rCO8BuDs?=
 =?us-ascii?Q?J/0epkv7gXFiBaZQRySjYiFOQ9yKlTXr24FhQpZVsvuvf90l2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:44:46.2152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b6c13b-2748-4849-f915-08dd07f04f74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130

From: Alejandro Lucero <alucerop@amd.com>

Differentiate Type3, aka memory expanders, from Type2, aka device
accelerators, with a new function for initializing cxl_dev_state.

Create accessors to cxl_dev_state to be used by accel drivers.

Based on previous work by Dan Williams [1]

Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
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
index 84fefb76dafa..d083fd13a6dd 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. */
 
+#include <cxl/cxl.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/firmware.h>
 #include <linux/device.h>
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
index 420e4be85a1f..ff266e91ea71 100644
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
index 188412d45e0d..0b910ef52db7 100644
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
@@ -816,6 +818,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_memdev *cxlmd;
 	int i, rc, pmu_count;
 	bool irq_avail;
+	u16 dvsec;
 
 	/*
 	 * Double check the anonymous union trickery in struct cxl_regs
@@ -836,13 +839,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


