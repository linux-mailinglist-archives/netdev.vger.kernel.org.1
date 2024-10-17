Return-Path: <netdev+bounces-136662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4039A29D0
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902BFB2EDD5
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2CF1E32A9;
	Thu, 17 Oct 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s6cjukYd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417F81E131A;
	Thu, 17 Oct 2024 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184002; cv=fail; b=mM8nwJFLKPDNjw4crqi1/8+5pNUhOhV5g4VMBFhjqqDEZtgs4utmWeH6gFTxuQ5+PFnZenwmVClIccEqfVBKIy5zb3cCdg3IiXqNGWKAVA3iAz2fAhlEbC4E9ES6xddK6iLj3t8aMHHr5977naOD0LJGOm4T2FV4WrHIuOzS1+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184002; c=relaxed/simple;
	bh=V/PeqmFiMmzbax7tFMVcbjBmog3YEMi+9S/ChOxKmhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDrfP/GM1VVKoLzIatA+z5pzelz5C6vLeSEtGL0PW04PxiujVg/hnufuvwnoOMk3iW7EchPcy3qkil70gkHQmsHBeehoKf5j30AJlyArUKNYQFXbuWab2Ps+yLDTRF8GgrvuiZYCD7J1PwHdJXSnJJ5pKKP/00DeT1zL/lL4GA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s6cjukYd; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kK7P1+oDXQMyoM9O4WOvDIN0pmCD26adLI9Oyaktpm/FHczp6nFe9EByD/amaDSaE6vg1moma5W1spa7jSS4VFDzoVNkTtDWS65tPzyy/m21qc2H0Z2T9e2fTMMygBGEsf2uNOyvuXs4r2eVUSby6qGlhD/2nFmkUmyCuyOZTglSGhj0hX24pNpYb83OErLDdKe8NAgPYHDINfIzYExBi5R1gn20G84iDIDQQzri6CC9d/lMoxw57BAygnSh2jYOJyETaOvoSe85EK3wXEDMQcJToAu9ASOlwRHMn9kwYM3MsFzdOjagvyCOcSlb1AC01Ne1PRe8AUnlvg/5+6BuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzDWL/w2eap2Q+V6WABC483T75Xvgk6PNG5ctedIeEA=;
 b=EVoCNcmJCRIjYaUvpVL+6CMRSYM/uRQpXESVea1AWEzPYqAm+0d3TGK4JFdKF3b14Nwg0QV2J20BGP9+C7mjAlzAwASLEX/FB1yk8TKRXiaGhHL9fmul9wn8KcX8RfBFZSIgPw3c508lkVp65HwnmqJWffpYAq3be4XDjIsTQ+z50nuVl8KyXcr1+WFE37pwRyYL0AYpetGE+TxNHh7AULWjHyqZ5+B/Klu98d+QpWn6lyw63jcgQX3Cs3y4DnBYnvfe0NHkDBS6CsObv5PxlZ/dH4xlGMvBNdjR3B6AcVh6fK/yyM+HX4m4otFcyL7pAvCVCVLXLx+opWoddJzb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzDWL/w2eap2Q+V6WABC483T75Xvgk6PNG5ctedIeEA=;
 b=s6cjukYdo+GZmKz/wA+LTBNSr1nxtNxrKgmm38QN0+ZNbCGv2EYlwPtirqUaH49r4kIqyc2AytbT16Q4znP/u6howUfcpikOnorRx2XgyqKzVtNfOXnwrWeiJVkGzHZePg32Ufl87qAiDjofhCV9Y9Pp46gl4rw9tgrNq8jJ4IA=
Received: from MN2PR16CA0034.namprd16.prod.outlook.com (2603:10b6:208:134::47)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 16:53:12 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::9c) by MN2PR16CA0034.outlook.office365.com
 (2603:10b6:208:134::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:11 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:10 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 01/26] cxl: add type2 device basic support
Date: Thu, 17 Oct 2024 17:52:00 +0100
Message-ID: <20241017165225.21206-2-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 2198d29e-fed3-4dab-6543-08dceecc2fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bglZ6HwMGglzS8IdPPOVE75lFX2G6WHVNEKymBYs0qQV4/zGSBalePSoRgEw?=
 =?us-ascii?Q?vVnpHdNx1mOTmtfJoR+KKEwo+JJbDAuTrAxX1drytz8tUMiPpl/FLxWgot0D?=
 =?us-ascii?Q?eyIArk97Wdhx96u5pFlahAjB5GsJH22oIG105NDoPYaZJrmJ0znmPHBgUt3O?=
 =?us-ascii?Q?MArq7+tskn+6IwsKv/a+je/EQG28YR+AXf2plefm/A0hFSZXlv8csxHGOZyX?=
 =?us-ascii?Q?roJkBbECWZszxGR77BGjlYCAW5nvcWFRy/ScY8B/bxXYpO3WAvsBQBknlN8t?=
 =?us-ascii?Q?/itrAKaneYc4TC4fYaPOLqyRQs+a5pjG32+zUSE4cBx1PBkCFTGEWoFUhuhr?=
 =?us-ascii?Q?MPFwVexiU1EYAuHOSZGUteEW6DH6GkzBzrNqEVvJEOs5uxzmyWOF0QKSdAYY?=
 =?us-ascii?Q?DacByI//+25Jq5eLgm09Ovw7H6NBRSKSLq+tJxrMwm1qTn9lOgP7p9OdtqM5?=
 =?us-ascii?Q?Z2lKqXcv7J6nC+IxSk6/UrOWce109198zZG2edy107ybiTTbbvAK28Zhzjw/?=
 =?us-ascii?Q?hyyHPK7YVkbuwliNjGwLL0VelB4QcmJnYZ74VW2yeFllMNv4eE/asFOlu2+T?=
 =?us-ascii?Q?nRe95rPJToHLebbe3XrTQbW2UmaqlnRALWQdBzD/s8gy3pPzL4kC3TFrMYcF?=
 =?us-ascii?Q?4CCTnbwP5i7EKONDzYgcDhcZ1whOg8Y1sFvZVuLwOmmOTa2becVlSw34lImk?=
 =?us-ascii?Q?6fz4fB6LTajU1kTQdFYKsIMOJsyo8prOY9TMF4ThAZgrktLbqsGxDcT3m4iP?=
 =?us-ascii?Q?j6i2C6USrABdL8JpGrIb8d3Gf5Dty4NxT5+EJWy6+9PXvIsMubN2odG1qG2H?=
 =?us-ascii?Q?F/zYBI1Mr3ofd5Jdwd6N/dte01GvJ5od178geGFvlAW2gnZLNX8n49eDlBM2?=
 =?us-ascii?Q?HmN6ocNQy93neUMwyzmsP664uIB9Gdd7LEvwKuW+jgvVYTQ+Wd1REsZ3Q0DV?=
 =?us-ascii?Q?+TG3sXbRwzkx7Vsa4CwUDiQBzKl+IsKuPUfxc5zqijlgQnHyXvY40tkH3E/J?=
 =?us-ascii?Q?d5H2cCJzf7vO1kAyj6Whw+6O+UMzN8032TdohGrnGtwavakXcbHvOuvg5dV0?=
 =?us-ascii?Q?Var19MS3HBqEuhzbO2z4LNRe2gXv/AUOh5I9dNglQVvFh+CQM3lSORxCCcYb?=
 =?us-ascii?Q?8vWbGdLQP0ufA0cv2NHOuCckPdnni6Fkq2jCqWtE8GhzkUV6f1Ozd+tp+tNi?=
 =?us-ascii?Q?thH92sdPAEVqQC+fwsisqD2C2d2SfL22LA3oAZ9+cBXXGeNgv4zcfs+hOVXo?=
 =?us-ascii?Q?476/WOIrcnPpu5lwPdbJFSJ3NHlACcI6PffOZg1CD/hNETskmHe1RaeATSgE?=
 =?us-ascii?Q?rOCNMeg4JKG4dgutI48TvXO8iEDFCEwr+YU26IeXwqCBtzD6oRujD8CAOZGI?=
 =?us-ascii?Q?x/Pwl8oERSQ6n56XTeqpGwui4MJo8JBUzNJJgfCP1HAp6pBqmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:12.2920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2198d29e-fed3-4dab-6543-08dceecc2fdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657

From: Alejandro Lucero <alucerop@amd.com>

Differentiate Type3, aka memory expanders, from Type2, aka device
accelerators, with a new function for initializing cxl_dev_state.

Create accessors to cxl_dev_state to be used by accel drivers.

Based on previous work by Dan Williams [1]

Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c | 52 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c    |  1 +
 drivers/cxl/cxlpci.h      | 16 ------------
 drivers/cxl/pci.c         | 13 +++++++---
 include/linux/cxl/cxl.h   | 21 ++++++++++++++++
 include/linux/cxl/pci.h   | 23 +++++++++++++++++
 6 files changed, 106 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/cxl/cxl.h
 create mode 100644 include/linux/cxl/pci.h

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 0277726afd04..94b8a7b53c92 100644
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
+	dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
+	return -EINVAL;
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
index 4be35dc22202..246930932ea6 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -3,6 +3,8 @@
 #include <asm-generic/unaligned.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/moduleparam.h>
+#include <linux/cxl/cxl.h>
+#include <linux/cxl/pci.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
@@ -795,6 +797,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_memdev *cxlmd;
 	int i, rc, pmu_count;
 	bool irq_avail;
+	u16 dvsec;
 
 	/*
 	 * Double check the anonymous union trickery in struct cxl_regs
@@ -815,13 +818,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
new file mode 100644
index 000000000000..c06ca750168f
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
diff --git a/include/linux/cxl/pci.h b/include/linux/cxl/pci.h
new file mode 100644
index 000000000000..ad63560caa2c
--- /dev/null
+++ b/include/linux/cxl/pci.h
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


