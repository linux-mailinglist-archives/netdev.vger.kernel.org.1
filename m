Return-Path: <netdev+bounces-173658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6723A5A581
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F5D174A18
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDB51E22E6;
	Mon, 10 Mar 2025 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wcF0wN9G"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507741E0E0A;
	Mon, 10 Mar 2025 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640643; cv=fail; b=afo+Z5GucT4qJahEp667+WRiAK3V1LOXbY4dcDdsz0q697JpOUuD96zGIOAXEPuyBJSzCkNVTF5/ofGGTPSnI32L2OOUHCUz4MfiLClH5rveqgxIlmFX75KksGdM1Zh0CKUTu2MEm3J/88LbAIGpKWDbwRFDuSrwbcLfe3mr5Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640643; c=relaxed/simple;
	bh=WKLC0z6onooCQF9taXwO0NOc5rh/Pquu/u6FJJyJcWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bC8xI+u/9Mnq11uL0vOTstrAywKajaRLssUG5BwYDRWc8trbOhSLEcuImnToib3d5dTGStHzNfjXPrAZtvBfys/RcBdOHAuDOvz3wkVdEcA5HHSj5cBz6d/vQ429H2JzmAO/A8Ru0NtrIVml82LrzVm+90XU0m1ldqWAMRR0MOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wcF0wN9G; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6UnSAjxKcvxnH/q7sschouL/MlNGdZYOvVnTOmKLfQO0im1UicFRhzZRWb4KiGgbvmPeHj8lL21ODyJhq7vB+fCnNWL9ESJ0sXxooCzY0a4DMy5Y6ZWTHqqr/uRbOwwWAixUHPJtTwbPDOfKh6Z9fe7rGq9LU+eaE/sXT/bD5bucKVnWZhVTA8zrmqXUAhm4ced3tOeBCXtLS+tyfgEiAQZ5Wg86LGmaQMu6HuUi24kSmn9WoQeUUKYsIw4pKYYWrGyNdMsJn7Dz/z5o6ISx0QvFh8zjdfJ5PjleiccK7dk+VDBml5xE7k9/tV7c+2IABBte6VRDqASdDgsJOrlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XortSuHTPxVEwy+w8m7gOiQ3VNZ6KSWjSO+jBw/ocVQ=;
 b=DaCsOEnkJoykS5SwR/1NNQjMXfvsG+6HghDKOCm994lMRK//gSRpXwHYdaQa95s9JnafgTX2XFww0xuv5AnqGlZm7oRv2axGYwYhJT5cMuNsi+E1PA4k2mJl+6XPm+Suf9uULhBghoyCmR1NddtUlybnzjJKkp8EKF0nrrBR+qIYEztFt4ExnkAjhM4OG7lgL1bF7NTTStRH3R+XJvsksIhm3unwlz5xGgSm+TVBFP3jZI0mfXSBxbzw+y/d6fJSMa+IV8P+wPIKXWFexZX5Dgi5TZMKOvUAduv3vU9SR1q68x56E5Xs4+oXapIqePhabEepahc6ZNgBL+OFAZ//lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XortSuHTPxVEwy+w8m7gOiQ3VNZ6KSWjSO+jBw/ocVQ=;
 b=wcF0wN9GhEIcd3DvSvFf5FbQ3wsu1IF6Jg5aXmi7/B7OLk/HyAtgqLLfE9jKm9mflaLDdzei0AuPSYTA2EPPH+pCvhmLUlBYbKsJ6IfI0BGDNlOR8ab2G+qYe6OgpZTSDZYRHHT/9WyX5FmzQIGsQB255Jvrr32+S6mRCUZWuZM=
Received: from BYAPR07CA0040.namprd07.prod.outlook.com (2603:10b6:a03:60::17)
 by SJ5PPF6375781D1.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::995) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 21:03:56 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::40) by BYAPR07CA0040.outlook.office365.com
 (2603:10b6:a03:60::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:03:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:03:55 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:03:54 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v11 04/23] cxl: move register/capability check to driver
Date: Mon, 10 Mar 2025 21:03:21 +0000
Message-ID: <20250310210340.3234884-5-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SJ5PPF6375781D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 644330d6-ac15-4578-eb4d-08dd60171273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Xj8OZE/UnLjxyZ9SImW2qZXAaF6w0oWucU/g3RTLZ+6mFPXVtvmnCfGJpxa?=
 =?us-ascii?Q?6bRXBDy5Q11a9sQ8GLivgjrd1QL9UYP4pJwKoE5qfT5djKxwguJz6Bl9fmh4?=
 =?us-ascii?Q?LH/4PM2gDm3OlZ1ZxBfg7n9CBPIIAh6cq/4hWeVMktJOXh1zZa7fInClqDpS?=
 =?us-ascii?Q?o+YuftoSqjx0gkhAZTDSCRW558Uxlv5as0Z+MiM3VHYGbts5J1WfJl3Hu5yC?=
 =?us-ascii?Q?/Dq8C4y65HQGT50kRSRJoH9Wjxph0wBMmFDNolKUy5jdHlTkDFGtdqKc+LxP?=
 =?us-ascii?Q?E5JM/nTUxmFyARjqWjTu9XdnBJt+APKzmoAmJG10MSU9JX9uQYzLjq2SZDfh?=
 =?us-ascii?Q?3pf7QI8/NVJMb+Fx1Ynl89XVeO8dWzwnA5IvKknZWFMbu6IkJx6XqlNXrhY7?=
 =?us-ascii?Q?6pHvv5jwK3/Fao+Q153mw57+LPRikQTSFTxv8Kj67JUMJwIKL0EuD7LIDXPm?=
 =?us-ascii?Q?8L6iTBfifwiCfFcbrXVCl4p+3EqgDPRnKuveR/l/GlBcUMRc4xhZKKQJFZnn?=
 =?us-ascii?Q?c8lFi5v+hALXjV7X1GnekFrGxi+wYlaVsUoidOA3hADLH6cW365Mhu3V/Om0?=
 =?us-ascii?Q?lA//u9YfgBrv+xu0Cov09h56q9U8erg+HC6gfquUbyeVgaNzaVJ4T29W8jOU?=
 =?us-ascii?Q?5nxAjekdoWAdIZedPoa1weX+ONMdkoERkgRxKVn5nN/0VbyZkvt/PdBdZZM2?=
 =?us-ascii?Q?b8YtXCEMYAI7B4PYH02J07vNWVB3/y2LZ2ylkcy6amlJN/pQmwfkKGH+Zzae?=
 =?us-ascii?Q?Pog3Zuo1cpjUZUnWNvIfBDnf5H9OBu+a+nVk/I67l8G1b8fMeUOsUrA96tLv?=
 =?us-ascii?Q?tw7Bwqvf5/n9MHJkuWKBf3VtchkccV0jT/8XsW1+4ZRnuN/tMYUvlOYUfDLO?=
 =?us-ascii?Q?4iDCLFHJ3CdcaCz5vn55h39NI/qR3+y3wg5F0G7+1mC05tsKLU3LvSTGGQF4?=
 =?us-ascii?Q?Myrb6AzQF9frrD3nyi6H6Jy8fdKglas6Cl03ngAYRl4B/UxwTuJgp3C/PGa5?=
 =?us-ascii?Q?9iHKQhVocwc72u2ybKhoDxIenlZKM1LzWrVATs5ZzpsDYvkMzjPbOvBi94Dk?=
 =?us-ascii?Q?vHUYCE42hbUrgbNpI5Gw+RvM3fGmj6Ry3XPV9YGiEOdmgU6sfiNJNMyZZltx?=
 =?us-ascii?Q?xKas1APGbJD1TRRVqLXur7/denerFpsYkJuwHdlC9KbVe3BHKXuCOXSb4+ie?=
 =?us-ascii?Q?ft9cHKz8V5bAhlqtvE8zF5WEOp/vywnQ8pDRYE0+EET5kC2BNYO3ynJLtCzI?=
 =?us-ascii?Q?QLKFz2szRYeY3eCfHsHptOG3EbcFVQUrQQvkBAug1bLL7NjVMTDXiuWn8KA/?=
 =?us-ascii?Q?U8+JuMxhYr+RkOCKKJVr/v4ahXNuQGCg97qnnYA9cbR2uRO6QsZxPb534mhc?=
 =?us-ascii?Q?6yF3zUYSIE5ctBtzdLLTT25f43WJVY/OdK5TbCyZh/NkwEJbfY4Sn447Idyu?=
 =?us-ascii?Q?AwftPB+MalgunAnnii9bIiLJNgIexUvGI92UnbvtuAuaPJbyA61HaOmr8mGi?=
 =?us-ascii?Q?wSwJZwV5LbxRpZA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:03:56.4704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 644330d6-ac15-4578-eb4d-08dd60171273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6375781D1

From: Alejandro Lucero <alucerop@amd.com>

Type3 has some mandatory capabilities which are optional for Type2.

In order to support same register/capability discovery code for both
types, avoid any assumption about what capabilities should be there, and
export the capabilities found for the caller doing the capabilities
check based on the expected ones.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c  |  4 ++--
 drivers/cxl/core/port.c |  8 ++++----
 drivers/cxl/core/regs.c | 37 +++++++++++++++++++++----------------
 drivers/cxl/cxl.h       |  6 +++---
 drivers/cxl/cxlpci.h    |  2 +-
 drivers/cxl/pci.c       | 31 ++++++++++++++++++++++++++++---
 include/cxl/cxl.h       | 20 ++++++++++++++++++++
 7 files changed, 79 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0b8dc34b8300..05399292209a 100644
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
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6a44b6dad3c7..ede36f7168ed 100644
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
index be0ae9aca84a..4a3a462bd313 100644
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
@@ -30,6 +31,7 @@
  * @dev: Host device of the @base mapping
  * @base: Mapping containing the HDM Decoder Capability Header
  * @map: Map object describing the register block information found
+ * @caps: capabilities to be set when discovered
  *
  * See CXL 2.0 8.2.4 Component Register Layout and Definition
  * See CXL 2.0 8.2.5.5 CXL Device Register Interface
@@ -37,7 +39,8 @@
  * Probe for component register information and return it in map object.
  */
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map)
+			      struct cxl_component_reg_map *map,
+			      unsigned long *caps)
 {
 	int cap, cap_count;
 	u32 cap_array;
@@ -85,6 +88,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
 			rmap = &map->hdm_decoder;
+			if (caps)
+				set_bit(CXL_DEV_CAP_HDM, caps);
 			break;
 		}
 		case CXL_CM_CAP_CAP_ID_RAS:
@@ -92,6 +97,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 				offset);
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
+			if (caps)
+				set_bit(CXL_DEV_CAP_RAS, caps);
 			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
@@ -114,11 +121,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, "CXL");
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
@@ -147,10 +155,14 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
 			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
 			rmap = &map->status;
+			if (caps)
+				set_bit(CXL_DEV_CAP_DEV_STATUS, caps);
 			break;
 		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
 			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
 			rmap = &map->mbox;
+			if (caps)
+				set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, caps);
 			break;
 		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
 			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
@@ -158,6 +170,8 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
 			rmap = &map->memdev;
+			if (caps)
+				set_bit(CXL_DEV_CAP_MEMDEV, caps);
 			break;
 		default:
 			if (cap_id >= 0x8000)
@@ -434,7 +448,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
 	map->base = NULL;
 }
 
-static int cxl_probe_regs(struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
@@ -444,21 +458,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
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
@@ -468,7 +473,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	return 0;
 }
 
-int cxl_setup_regs(struct cxl_register_map *map)
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	int rc;
 
@@ -476,7 +481,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
 	if (rc)
 		return rc;
 
-	rc = cxl_probe_regs(map);
+	rc = cxl_probe_regs(map, caps);
 	cxl_unmap_regblock(map);
 
 	return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5d608975ca38..4523864eebd2 100644
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
index e8c0efb3a12f..17ac28baa52c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -836,6 +836,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
 	struct cxl_dpa_info range_info = { 0 };
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct cxl_memdev_state *mds;
 	struct cxl_dev_state *cxlds;
 	struct cxl_register_map map;
@@ -871,7 +873,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->rcd = is_cxl_restricted(pdev);
 
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	bitmap_zero(expected, CXL_MAX_CAPS);
+	bitmap_zero(found, CXL_MAX_CAPS);
+
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
 
@@ -883,8 +897,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -895,6 +909,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (!bitmap_subset(expected, found, CXL_MAX_CAPS)) {
+		dev_err(&pdev->dev,
+			"Expected mandatory capabilities not found: (%pb - %pb)\n",
+			expected, found);
+		return -ENXIO;
+	}
+
 	rc = cxl_pci_type3_init_mailbox(cxlds);
 	if (rc)
 		return rc;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 5c6481136f93..02b73c82e5d8 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -25,6 +25,26 @@ enum cxl_devtype {
 
 struct device;
 
+
+/* Capabilities as defined for:
+ *
+ *	Component Registers (Table 8-22 CXL 3.1 specification)
+ *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
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
+	CXL_MAX_CAPS,
+};
+
 /*
  * Using struct_group() allows for per register-block-type helper routines,
  * without requiring block-type agnostic code to include the prefix.
-- 
2.34.1


