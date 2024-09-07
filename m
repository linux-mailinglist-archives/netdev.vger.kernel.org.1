Return-Path: <netdev+bounces-126210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 988D49700CA
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14468B21AB0
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5257312E5B;
	Sat,  7 Sep 2024 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="41ErD8sz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804DB14B96B;
	Sat,  7 Sep 2024 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697170; cv=fail; b=tmMXGCjRE5N12mhwYUGjDM5jpZs90FAiob8xfBOwMzAA1FCQoSzZnwS/CZpFudaS6OHTpnGRoiPBXQ8m2XtU3ORUza3PGCAtP0FmA7wPZyyurNHNFZORoSYxdqn6UwNLXlWH9Pe4u/qoQ2G7tZfo4xlZukts+hsSEZWB7YzrVTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697170; c=relaxed/simple;
	bh=6K0hrWWR7B1zKP7PvYH56V/znPOvBLtluCp40C0wLys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puYROAnZTSk1oVV3tf0oVcxc3XZWc3iBsFqaRv/I5ACJZdYeGpyd0dKE7CyjKmkDm2zU7fetZLmcVzaxhLP8e8U/HCJevmDSYG99iz5lqnkyeqSi1ARdFiKpyxCNI7UTX5MDke4bmbsPCG80M519VEXXNKsV77sEZUF71T4Dexc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=41ErD8sz; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZjFIHX4ARaETuMujd9rOIHxgjRJvg97QZv/o3TZyp1l8cUb66EzPo6/EWcVluOPzAsmg/vxlNeRVm/ki+OgKMHCpg7UAlSS173UE/gW7ngSQ2KKgjR7JJQo8wv8aw6qQ1rAupCMr5TkiZts7LuhuHwxu37rAj750KNeZ0q+VmqXgpfAnFnng3rhn/BbKvNe70MU9l6IuQRKMWoLF1OvWqroMbwBL8apNsNchuO5QZbytSVROdXJ6QlT/sXOH/aTgmuTeoSVqaiKD4xPQFa2EtOSsbOGiBJEjMwu8+ecOKg/oIxmmx3F4yiESRdxdtGvJPah7p2ZTtYloYmFk6TgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VinIpL1SUbfp0fzsP3+HGIGxY2UZaPwTS7QEsb+qHTw=;
 b=LKJ5DNl0iFmjHetk3Jjf+FLhzX4WtMHPyqxAXQfTamFqpbcDlH26I0xRHw6gzGTjM9TYYnpShvIevAZvz0qWjMmuNObrxzNX6RS/DAxaqLKREQR9t83WU1x6m850j+A3NXOKo78rt8Yxm/s/f+vyYPoDAd9ggRxY8CW2IyxElpTPmRXF6NIxtmm5K5IbLFX3EjMGNCSBwDUYpeujgRcSLaJGmDbJfvDhYww2m9a7dp7QdGnkoyDwK12Fp/WM/66AzRSYD13rAi0hQX3+BGkQVlzVxs131cE9C2r+/kh70Rv78rOeIV5cJEC6QWmdfVy9Gn91EETdLNkZgq3MrROF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VinIpL1SUbfp0fzsP3+HGIGxY2UZaPwTS7QEsb+qHTw=;
 b=41ErD8szAo+TNivPsfs4n4I1VP+lAmWhN+Vwk1UR03XN0qU2keDitHtAWeCWTlcDPNcvNkTlBSJy/p2ukrjKZFc3wI/V6RTFYqWLOxN5iClYRhsEEYIVn3iNmIukdLs+jgDYg/YP8vQBPaE7sYjvELJ7MjJ1tJ6Aq/YE1RiqDco=
Received: from DM6PR02CA0101.namprd02.prod.outlook.com (2603:10b6:5:1f4::42)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sat, 7 Sep
 2024 08:19:24 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::8a) by DM6PR02CA0101.outlook.office365.com
 (2603:10b6:5:1f4::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:23 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:22 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 03/20] cxl/pci: add check for validating capabilities
Date: Sat, 7 Sep 2024 09:18:19 +0100
Message-ID: <20240907081836.5801-4-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: e450b5d3-8568-40b5-f999-08dccf15c858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g9dpocshBMwM3YKrfYPR1PzgldIgljFlBPAT3CZjG60hZ4girt/RzLSpGiiw?=
 =?us-ascii?Q?uUUH4OdFndggb1lWEP0v+yN/A6CWVufsqy+yEm1H/toBuWIfd9e1DgkbBqA1?=
 =?us-ascii?Q?NB0UaCu5N7Yq7YcTl+4Ut1vBS5fl2BN09l91vl0Yga4X76ZTuFR8zhuY8Pg8?=
 =?us-ascii?Q?5ro6KaNf0gG6nr8lPby3urPkGPOew1pl9zPuqLknV0YMGgbVSI4vNCPuQM5y?=
 =?us-ascii?Q?VYk8pHX6t41oeGHymaRunGQH1rm1KOOQ2HYSPiGOyFwyf2mjYOLmrmeqCdK6?=
 =?us-ascii?Q?pTBo79SRAhbToXu0GcmJ76in4y5sBEtkY59+9sEJ4Lm2diz/qzT0AMxTEiFz?=
 =?us-ascii?Q?3WIdY94fj9i650aftBHSDENr8xyguQGQvMD4/GGuZc12VlElEZ2elQ00ff3h?=
 =?us-ascii?Q?G43ciG4UKkgsBDoUfZnFmC4ZDx/qz2cpq+i06+XxkNjvKE4kXSvnQFGBNJ8o?=
 =?us-ascii?Q?GEipOaBD4iD9hBaAsnCEzxvvj3u8tH0f7Se0gTcYh0iQZ7zkIt3kBYeYamK4?=
 =?us-ascii?Q?iFAeuYXyIuljrg2u0PRNc98DfIuEFdW99lGoAm/8PHbWlkfplfdielmas/km?=
 =?us-ascii?Q?kw5p3WK+DyvTINDZfNEHmk2bYAlhIWur3ZQzotsZb2Zle01capGUw837IJ96?=
 =?us-ascii?Q?CtGDewabA1nv7Ahf4XOe6aAtEGn3kj7EdmetJCfuaL+NIH/x8kPPf5y33sj3?=
 =?us-ascii?Q?acOt0+SnQfOVkTAPcTSYQWIb/B+X5DdLmMfxuoxL+LzV3T6dgarWmOwyzCAN?=
 =?us-ascii?Q?bGewtpDCDtgku5JPRfdGTYkE8aseFu9pC22lYUvUojAquQC2rsyqWN50Lj+9?=
 =?us-ascii?Q?fEIMwgv5rFCkbmjfSevqDYY1icSqpVXbc41Il2G2NFjCiWBERYklD9VGKH5g?=
 =?us-ascii?Q?pa/Abn2XGFoPTVB/9WHR1pQeNapcVNuWz0QryBmVl2tokGlCfSW5YsvlkqpS?=
 =?us-ascii?Q?jGLPnefYo4zOWt88uI0uIKTU79KJKsmadvn2MNZzFGa5eKsITF3z7uBFsAXd?=
 =?us-ascii?Q?n97soNDeFOeeZQDQdqyRlatxJrhU6cbdeh7HMofaxmM5pmmToqGNR+5tWPwg?=
 =?us-ascii?Q?m4f9Eo5fwJIVcoxEkFiLuyTB3yJpDhKKiC53NntnKSJ3yD1i7ulfJYOZIwoN?=
 =?us-ascii?Q?6jCuwOPbA8tWTuCmmXs4tl7HKD+aLthxrCI9qbWScoZpb/TEDoeOgaRQ6/XR?=
 =?us-ascii?Q?/E4z2zSny8/HP1PrXaEbFWMat9TgUy7sU9E2IIaAmVZxnCxZaadUTDFnbP69?=
 =?us-ascii?Q?8FOenU6IvE9uTaCyvfBuY5U8N8cOfA3z5LfuDUyyXFKWiMkcIREhmsUawNaz?=
 =?us-ascii?Q?TuOC//3ZVrmztmCxut/aSOk7+IvxKYbG2CYGokgzL1ltIHZdy84DC332UzZ/?=
 =?us-ascii?Q?LQCGYfeKg0F3/xVLSA0yJrHfjy6DpoSS/bZXUpbidCVPhQYu9AZjl227yD3c?=
 =?us-ascii?Q?BbZSw3Hb4yICB1uik5bwl3/s+Io4J9bb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:24.1211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e450b5d3-8568-40b5-f999-08dccf15c858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959

From: Alejandro Lucero <alucerop@amd.com>

During CXL device initialization supported capabilities by the device
are discovered. Type3 and Type2 devices have different mandatory
capabilities and a Type2 expects a specific set including optional
capabilities.

Add a function for checking expected capabilities against those found
during initialization.

Rely on this function for validating capabilities instead of when CXL
regs are probed.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c  | 17 +++++++++++++++++
 drivers/cxl/core/regs.c |  9 ---------
 drivers/cxl/pci.c       | 12 ++++++++++++
 include/linux/cxl/cxl.h |  2 ++
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3d6564dbda57..57370d9beb32 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <linux/cxl/cxl.h>
 #include <linux/cxl/pci.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
@@ -1077,3 +1078,19 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 				     __cxl_endpoint_decoder_reset_detected);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
+
+bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
+			u32 *current_caps)
+{
+	if (current_caps)
+		*current_caps = cxlds->capabilities;
+
+	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08x vs expected caps 0x%08x\n",
+		cxlds->capabilities, expected_caps);
+
+	if ((cxlds->capabilities & expected_caps) != expected_caps)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 8b8abcadcb93..35f6dc97be6e 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -443,15 +443,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, u32 *caps)
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
 		cxl_probe_device_regs(host, base, dev_map, caps);
-		if (!dev_map->status.valid || !dev_map->mbox.valid ||
-		    !dev_map->memdev.valid) {
-			dev_err(host, "registers not found: %s%s%s\n",
-				!dev_map->status.valid ? "status " : "",
-				!dev_map->mbox.valid ? "mbox " : "",
-				!dev_map->memdev.valid ? "memdev " : "");
-			return -ENXIO;
-		}
-
 		dev_dbg(host, "Probing device registers...\n");
 		break;
 	default:
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 58f325019886..bec660357eec 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -796,6 +796,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
 	int i, rc, pmu_count;
+	u32 expected, found;
 	bool irq_avail;
 	u16 dvsec;
 
@@ -852,6 +853,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	/* These are the mandatory capabilities for a Type3 device */
+	expected = BIT(CXL_DEV_CAP_HDM) | BIT(CXL_DEV_CAP_DEV_STATUS) |
+		   BIT(CXL_DEV_CAP_MAILBOX_PRIMARY) | BIT(CXL_DEV_CAP_MEMDEV);
+
+	if (!cxl_pci_check_caps(cxlds, expected, &found)) {
+		dev_err(&pdev->dev,
+			"Expected capabilities not matching with found capabilities: (%08x - %08x)\n",
+			expected, found);
+		return -ENXIO;
+	}
+
 	rc = cxl_await_media_ready(cxlds);
 	if (rc == 0)
 		cxlds->media_ready = true;
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 930b1b9c1d6a..4a57bf60403d 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -48,4 +48,6 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
 void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
 int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 		     enum cxl_resource);
+bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
+			u32 *current_caps);
 #endif
-- 
2.17.1


