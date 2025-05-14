Return-Path: <netdev+bounces-190419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C435AB6C9F
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D8619E80B4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9406627AC36;
	Wed, 14 May 2025 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vGTNyqZ7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EB0221DA8;
	Wed, 14 May 2025 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229286; cv=fail; b=jHE/F/QuctqSvKlbr3T7Aoz82EkekyUP/jKGpvv+pHvCT7CujWOHbi6l3HlidcyTAUjIR7fQ15VtEtfUOHMzE3KdVvGdHAKwYQBAtdaTMfvpNqRaPOCPlY6GDwc64nQNHurOnQnvR5whEmKu9nzvUBHtIzaVCUbGPWjiV6tUYxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229286; c=relaxed/simple;
	bh=0s1/PNFKRh7ODPhuyqzNBYMf8MvcXtVrB5iCKJupHGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFwamBdhW3JDSaDcA87l7xJ9IcO3TAjP7/YsQYXs0rSY3iUdRh6t7z0RiL37IB3tsVXmSfAACzKDf8g+oDbCPWrSQKlo+w5V3OzfqQnA5qgnt2z2/p7Gbg2H9flnB9D7czrXR7h+ZP/zw+VXfEjWAokRLIALbrl3N8zHgWVlLhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vGTNyqZ7; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nriHV3BVX9cRQaJHvrdgZA0gMsKZcy7FUAfWErylMS5x85XYcVYboE5GQx0MskGA0cj/lFPZBRmRDjwmoCoRnSsz3qrSnXSi3PQLfunNQ1DFh+y6e+OKXQRyvKnIb0rcloN3xvY6N4fjVMclGSbwYTdxo9FIQ70PNrnLHqF1CcYVNqyHLJBN5x6J1AIOzzO8092mybATwmH6laFglpiFCWeaUqHmh/RtGTdCBp50p17AqIReezPSJeJWCLxtS4WhByTgz90E9b6JqJ9qrJTKYTh5FrgrkdnkWPCV5YL0UGKrgD0+h02cc9LZDf7f2LbDggoWgMAbA8P/+2S1Tjs3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29OJu1qPQ0fxiArIHkhP/13UYYpjX6R2d2Rj8B4kBUM=;
 b=yb8Pm4wL0wh4UHbryQ+v2XY4bLL3qySklIdiEX1crdewcdFv8SwkhBoPaHmC5M++KzVaCHocwuZA7SidK+wM+u7Th/BysMEgj8qr4RzlS19ZEpsL0u+yZAO7BVJli8WjEoZhcokHWoEHJIwnE7BTI6sAOjfrbQSE0L/CsF4fgk4QLN+Q9h96776Wsr8Wn3KD738zTIGUORei1JDgo1UrUooIubAJxlbNSVPC+FKJk1yAZF/YyvocNbnfUnay9z9GUVyGYQIVc8P3DmlUs0Hw5RAlkjp9iCMCmVlpvl6O+eIci1NEq6TYljf0W2jFBtxoCVs5Y2EYPEgZZ3583n445w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29OJu1qPQ0fxiArIHkhP/13UYYpjX6R2d2Rj8B4kBUM=;
 b=vGTNyqZ7gc+NRhrXOH7oeDdoBqJdEzCgrlWPwIVrNremlAhCpsHEDcM0hdTlwTw7FAaisLZ9HwvYhQwHpGplg3YGtEMB7Ckc4UCEgtimDsO3izm3gRzu6Eu9J9QA2Kn2M3q8wiOjceJKweGDnh28RnV+eOIGoOJm32BDgYka9RM=
Received: from BL1P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::22)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 13:27:59 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::49) by BL1P221CA0006.outlook.office365.com
 (2603:10b6:208:2c5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Wed,
 14 May 2025 13:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:27:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:27:58 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:27:57 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 04/22] cxl: Move register/capability check to driver
Date: Wed, 14 May 2025 14:27:25 +0100
Message-ID: <20250514132743.523469-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: da17281c-8263-4bcf-ba6c-08dd92eb2515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q4y0mHddfKkzNNXfzCI5MZIzshSF55g8I+59pVb+gIpHu1tQjO6ZrOBLEU2Y?=
 =?us-ascii?Q?oR06eFmO3zsB1ycRGT4TJa8M4uzV/IU1sSFVYu4riH6yZ0MefxtNvQ/wT+3t?=
 =?us-ascii?Q?qispAynS/kh1U6C+6wGYzNotJqYAUMwtoFLPi1d++cHP6pieOh7UIhNxWWtA?=
 =?us-ascii?Q?AG7sVKq0XU4wWAoA//NFWrFn7FlL4uffcvTtcXhlm6G8Oy+QmSyeSp9ZQ4Mm?=
 =?us-ascii?Q?ZJyHjbo/i6PHAKA+P0iHadtIb8sSf7uVrgmMR9fwakvYgfSTWZ93u/dXIPxq?=
 =?us-ascii?Q?G2BCafz0mx+b5rPYz1DsU6z8iyacTj/DdYbwG7UCWL3zsCoMwcvBAUpAMiqD?=
 =?us-ascii?Q?0ljlG3/WkiXymFDJUm4+OCNlADDNK0/OP1ZfnBot2/ixkpxdarXgPAlCSkYs?=
 =?us-ascii?Q?2UA4oxa3aPCHe/wDQwWSjsnCkX5GoyW3La5luP7RC3Fxe/fq46d40HI2HQex?=
 =?us-ascii?Q?z04pdboS5+vrOLeFFynIJfZM1vuU05NpMLioFtPDrsmetymyMDxI9/C2jcaE?=
 =?us-ascii?Q?NSaHhALQs7SPfBofjp3/YiCXKyly+Goq5wUZiOL0o3/nc7DJmaJXcuShAinH?=
 =?us-ascii?Q?RJzwHXN45oJd9iiuu+fzgknOLmUjIYcl8biiqW/LZHb2EBTXvWVPr9EPdBHN?=
 =?us-ascii?Q?WPWABMgFBmAaOqzBzywxh3/Y1kxi8A+UjFqmszyCeBkHbaQ6Y1/6j2U1giAC?=
 =?us-ascii?Q?ubdbgXKHEplJoFBJD1AtjJ1kmDIPY8qqtBO3QLjbBQUqrgdKqoNmHFnfWtOB?=
 =?us-ascii?Q?Avfar1jdkD5DsPa5rbJwTojwXJ41tsDeMLqQQ475fe9H6ONYnUczjA0j7c3s?=
 =?us-ascii?Q?4dSf9u6MuicWfLE2usED/1s3cXP9Y+FtFZABmE7Unjtzt/kqg0NLbV/g7eEi?=
 =?us-ascii?Q?mXudAiq0rlxLhT4PShfmr+8elqStsiTFn/Zwa7vxTP3OYMSLasCsKYAzFAvZ?=
 =?us-ascii?Q?+as9B9qv5tRS+SAWnRxo3xOSEjGIdQYgnkiT7WxDUTCg8tWoCgww1m5C92Zi?=
 =?us-ascii?Q?IHSiclPPfVhBSbHHxEza0B2OSLVQv93ot+kHpv1ebwyPdlUADuOlsg0Vyx/8?=
 =?us-ascii?Q?MLTXA1FGGXFf7AkWYuKH/4SGX0pv57668Pk+387CljvJEaWFJLispfz737Ok?=
 =?us-ascii?Q?MNC3Ms8RkcUJeiINnhZ4SB0c27jQx7ps+VR5uNhthcZ/gVY1ptULmnPilE56?=
 =?us-ascii?Q?lnGkzhAsio+UGpAbLxeQNXMXiCJK9zDg962/BoOqsdqfTgzO6dy3MDxEZoyL?=
 =?us-ascii?Q?F5fOA8mKw4tUkngHBAD5A3DBQ4csDIXuRiPJtgG3k0gJXAbJOVRkJMU0g0Ii?=
 =?us-ascii?Q?Yyxd4oEfr0PBOWPjDGV+Nm8Lo8IiP2VIWS6nqSrY9qvMzLndcETWahcpIPfy?=
 =?us-ascii?Q?NcoCZ9OMyD7LhYVjLDIvk36qsA4UDsuCgslR5m5czSLUxQ2H/GRy6njxkn2b?=
 =?us-ascii?Q?2jAJ+nFFQtWUQeeQQ1Ff2r3OZlVi5PwWDBXLM/QdAlIeIiMZmqfS7hlpTKWn?=
 =?us-ascii?Q?ftAHysaRfEFXOpaAyAFHgPWVaDfXPvPotz9R?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:27:59.3182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da17281c-8263-4bcf-ba6c-08dd92eb2515
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833

From: Alejandro Lucero <alucerop@amd.com>

Type3 has some mandatory capabilities which are optional for Type2.

In order to support same register/capability discovery code for both
types, avoid any assumption about what capabilities should be there, and
export the capabilities found for the caller doing the capabilities
check based on the expected ones.

Add a function for facilitating the report of capabilities missing the
expected ones.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c  | 41 +++++++++++++++++++++++++++++++++++++++--
 drivers/cxl/core/port.c |  8 ++++----
 drivers/cxl/core/regs.c | 38 ++++++++++++++++++++++----------------
 drivers/cxl/cxl.h       |  6 +++---
 drivers/cxl/cxlpci.h    |  2 +-
 drivers/cxl/pci.c       | 24 +++++++++++++++++++++---
 include/cxl/cxl.h       | 24 ++++++++++++++++++++++++
 7 files changed, 114 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 447dc8d3138f..e2b6420592de 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1061,7 +1061,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 }
 
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map)
+		       struct cxl_register_map *map, unsigned long *caps)
 {
 	int rc;
 
@@ -1091,7 +1091,7 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 		return rc;
 	}
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, caps);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
 
@@ -1218,3 +1218,40 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
 
 	return 0;
 }
+
+/**
+ * cxl_check_caps - check expected caps are included in the found caps.
+ *
+ * @pdev: device checking the caps
+ * @expected: capabilities expected by the driver
+ * @found: capabilities found
+ *
+ * Returns 0 if check is positive, -1 otherwise.
+ */
+int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
+		   unsigned long *found)
+{
+	static const char * const cap_name[CXL_MAX_CAPS] = {
+		[CXL_DEV_CAP_RAS]		= "CXL_DEV_CAP_RAS",
+		[CXL_DEV_CAP_HDM]		= "CXL_DEV_CAP_HDM",
+		[CXL_DEV_CAP_DEV_STATUS]	= "CXL_DEV_CAP_DEV_STATUS",
+		[CXL_DEV_CAP_MAILBOX_PRIMARY]	= "CXL_DEV_CAP_MAILBOX_PRIMARY",
+		[CXL_DEV_CAP_MEMDEV]		= "CXL_DEV_CAP_MEMDEV"
+	};
+	DECLARE_BITMAP(missing, CXL_MAX_CAPS);
+
+	if (bitmap_subset(expected, found, CXL_MAX_CAPS))
+		/* all good */
+		return 0;
+
+	bitmap_andnot(missing, expected, found, CXL_MAX_CAPS);
+
+	for (int i = 0; i < CXL_MAX_CAPS; i++) {
+		if (test_bit(i, missing))
+			dev_err(&pdev->dev, "%s capability not found\n",
+				cap_name[i]);
+	}
+
+	return -1;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_check_caps, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 726bd4a7de27..7a105687d450 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -755,7 +755,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 }
 
 static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
-			       resource_size_t component_reg_phys)
+			       resource_size_t component_reg_phys, unsigned long *caps)
 {
 	*map = (struct cxl_register_map) {
 		.host = host,
@@ -769,7 +769,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
 	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
 	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, caps);
 }
 
 static int cxl_port_setup_regs(struct cxl_port *port,
@@ -778,7 +778,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
 	if (dev_is_platform(port->uport_dev))
 		return 0;
 	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
-				   component_reg_phys);
+				   component_reg_phys, NULL);
 }
 
 static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
@@ -795,7 +795,7 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	 * NULL.
 	 */
 	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
-				 component_reg_phys);
+				 component_reg_phys, NULL);
 	dport->reg_map.host = host;
 	return rc;
 }
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index fdb99d05a66c..2ba997106434 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
@@ -11,6 +12,12 @@
 
 #include "core.h"
 
+static void cxl_cap_set_bit(int bit, unsigned long *caps)
+{
+	if (caps)
+		set_bit(bit, caps);
+}
+
 /**
  * DOC: cxl registers
  *
@@ -30,6 +37,7 @@
  * @dev: Host device of the @base mapping
  * @base: Mapping containing the HDM Decoder Capability Header
  * @map: Map object describing the register block information found
+ * @caps: capabilities to be set when discovered
  *
  * See CXL 2.0 8.2.4 Component Register Layout and Definition
  * See CXL 2.0 8.2.5.5 CXL Device Register Interface
@@ -37,7 +45,8 @@
  * Probe for component register information and return it in map object.
  */
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map)
+			      struct cxl_component_reg_map *map,
+			      unsigned long *caps)
 {
 	int cap, cap_count;
 	u32 cap_array;
@@ -85,6 +94,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
 			rmap = &map->hdm_decoder;
+			cxl_cap_set_bit(CXL_DEV_CAP_HDM, caps);
 			break;
 		}
 		case CXL_CM_CAP_CAP_ID_RAS:
@@ -92,6 +102,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 				offset);
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
+			cxl_cap_set_bit(CXL_DEV_CAP_RAS, caps);
 			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
@@ -114,11 +125,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, "CXL");
  * @dev: Host device of the @base mapping
  * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
  * @map: Map object describing the register block information found
+ * @caps: capabilities to be set when discovered
  *
  * Probe for device register information and return it in map object.
  */
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map)
+			   struct cxl_device_reg_map *map, unsigned long *caps)
 {
 	int cap, cap_count;
 	u64 cap_array;
@@ -147,10 +159,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
 			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
 			rmap = &map->status;
+			cxl_cap_set_bit(CXL_DEV_CAP_DEV_STATUS, caps);
 			break;
 		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
 			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
 			rmap = &map->mbox;
+			cxl_cap_set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, caps);
 			break;
 		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
 			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
@@ -158,6 +172,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
 			rmap = &map->memdev;
+			cxl_cap_set_bit(CXL_DEV_CAP_MEMDEV, caps);
 			break;
 		default:
 			if (cap_id >= 0x8000)
@@ -434,7 +449,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
 	map->base = NULL;
 }
 
-static int cxl_probe_regs(struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
@@ -444,21 +459,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	switch (map->reg_type) {
 	case CXL_REGLOC_RBI_COMPONENT:
 		comp_map = &map->component_map;
-		cxl_probe_component_regs(host, base, comp_map);
+		cxl_probe_component_regs(host, base, comp_map, caps);
 		dev_dbg(host, "Set up component registers\n");
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
-		cxl_probe_device_regs(host, base, dev_map);
-		if (!dev_map->status.valid || !dev_map->mbox.valid ||
-		    !dev_map->memdev.valid) {
-			dev_err(host, "registers not found: %s%s%s\n",
-				!dev_map->status.valid ? "status " : "",
-				!dev_map->mbox.valid ? "mbox " : "",
-				!dev_map->memdev.valid ? "memdev " : "");
-			return -ENXIO;
-		}
-
+		cxl_probe_device_regs(host, base, dev_map, caps);
 		dev_dbg(host, "Probing device registers...\n");
 		break;
 	default:
@@ -468,7 +474,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	return 0;
 }
 
-int cxl_setup_regs(struct cxl_register_map *map)
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	int rc;
 
@@ -476,7 +482,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
 	if (rc)
 		return rc;
 
-	rc = cxl_probe_regs(map);
+	rc = cxl_probe_regs(map, caps);
 	cxl_unmap_regblock(map);
 
 	return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b60738f5d11a..dfe8a04b0ea2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -202,9 +202,9 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map);
+			      struct cxl_component_reg_map *map, unsigned long *caps);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map);
+			   struct cxl_device_reg_map *map, unsigned long *caps);
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
@@ -219,7 +219,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, unsigned int index);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
-int cxl_setup_regs(struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
 struct cxl_dport;
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0611d96d76da..e003495295a0 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -115,5 +115,5 @@ void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map);
+		       struct cxl_register_map *map, unsigned long *caps);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 57f125e39051..694bdfc5b7ea 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -836,6 +836,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
 	struct cxl_dpa_info range_info = { 0 };
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
+	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
 	struct cxl_memdev_state *mds;
 	struct cxl_dev_state *cxlds;
 	struct cxl_register_map map;
@@ -871,7 +873,16 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->rcd = is_cxl_restricted(pdev);
 
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	/*
+	 * These are the mandatory capabilities for a Type3 device.
+	 * Only checking capabilities used by current Linux drivers.
+	 */
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_DEV_STATUS, expected);
+	set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, expected);
+	set_bit(CXL_DEV_CAP_MEMDEV, expected);
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, found);
 	if (rc)
 		return rc;
 
@@ -883,8 +894,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
 	 */
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
-				&cxlds->reg_map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &cxlds->reg_map,
+				found);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 	else if (!cxlds->reg_map.component_map.ras.valid)
@@ -895,6 +906,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (cxl_check_caps(pdev, expected, found))
+		return -ENXIO;
+
 	rc = cxl_pci_type3_init_mailbox(cxlds);
 	if (rc)
 		return rc;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index b7f79313409b..412c45a2f351 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -25,6 +25,26 @@ enum cxl_devtype {
 
 struct device;
 
+/*
+ * Capabilities as defined for:
+ *
+ *	Component Registers (Table 8-22 CXL 3.2 specification)
+ *	Device Registers (8.2.8.2.1 CXL 3.2 specification)
+ *
+ * and currently being used for kernel CXL support.
+ */
+
+enum cxl_dev_cap {
+	/* capabilities from Component Registers */
+	CXL_DEV_CAP_RAS,
+	CXL_DEV_CAP_HDM,
+	/* capabilities from Device Registers */
+	CXL_DEV_CAP_DEV_STATUS,
+	CXL_DEV_CAP_MAILBOX_PRIMARY,
+	CXL_DEV_CAP_MEMDEV,
+	CXL_MAX_CAPS
+};
+
 /*
  * Using struct_group() allows for per register-block-type helper routines,
  * without requiring block-type agnostic code to include the prefix.
@@ -223,4 +243,8 @@ struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
 		(drv_struct *)_cxl_dev_state_create(parent, type, serial, dvsec,	\
 						      sizeof(drv_struct), mbox);	\
 	})
+
+struct pci_dev;
+int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
+		   unsigned long *found);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


