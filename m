Return-Path: <netdev+bounces-150337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CDA9E9E8B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A207118813F9
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4077E1991CA;
	Mon,  9 Dec 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qfHztlr1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA7199EB0;
	Mon,  9 Dec 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770493; cv=fail; b=lxUnA6yu46CT9FT2mZluTzNk45f9HdhBdRzaRg8jhY3u3w74Z5pVrZGf01fHoiZYpqqagB4l6LQJPM3HIKVk1HFAQcRQLEYhuawElkRVsRQpdXnShNeurn/pmm6HOiLuy9TrWvKkmkmYFAhuhKa+ON36lPBC5TD2TGoxmCHP4c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770493; c=relaxed/simple;
	bh=vuTJCzoAdb2sPP9RkPL8a+28xxYYtg55Buv0g/J0viU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWw6yOMbIoHg6Ul59x8YxK7fkSZY6ajsIIlQXTM/du8WNkIfWOpJnq1wIe1AauZcPO2vq/U3aE/tyNMZbbAiiJEcpG2C0vVST+13nNGWzzPqcgFJPBPMd0Z4n30TrNlm+ArFPKVYYaXpqEiVG+ryx6lItvhWm5rgBEQNRRYe30M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qfHztlr1; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gb8qsmJ8K2ehRffmx8DK+y6IpnI239z9ElZUgG5Hooa/EYHQuKV7USfROC/25IBX2U/c/OJZxKgrVCHIu6shHVeegaLn42LTMo3mNa5xa1DsYllqqOQJ/4SRYbj0d7KnhsmwtHpXs5Vq3gvHYwXEnlerGxCYTFIxH1dGLSw5pnejjx3HBNlqjTARIPIh/tilDxjSGeJGuw5SxZ7FbARtc9jRWs/y+waEeppFgFV9ce6oCgU4jXkv4r8AcaCS5/22Rq5nik92rpZwK1oFp88LAzXlhOYDNrhE748ipAGeDaUeivDPEDEJIFA8y0BW0drA3eL/4rZ8Blew6H+yDYo1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J5x9a13+QBI5MGEUsKHM9zHIiQdLCw6kj3ozShX7dg=;
 b=Jn4UiJ1Xt5NvVQyvUo1HSehcDJ96OIqIuV5o+02+PdX8F72ph0JpKP3xqcuFKfyrdvln0al24Tv1GxSACj/8XlRlqiwSpjg74bLQCMtP844/9+Zpg2h8v9avxh8jsr/G2PhfXrac6gDxtfXP73BeoMuTUbh4KIjnacbHNEYh7Bz4LsBkWIRXhaeG1iZeO2QEjUbmIJnsj/UkH1ED++fXGRgToyRLJShZ9mV63HyBcGPDkxP//ihvIBExh+NvEPkMSgGFDUmvt3Zb8H9a7KQZn1FTmzb9+45pJcAExeh1LPeTyc55kjj1fpmqhq3AVqZOkdbREWPylDzROhvZJvS5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J5x9a13+QBI5MGEUsKHM9zHIiQdLCw6kj3ozShX7dg=;
 b=qfHztlr1+sHJ+J/BubzSVYhHDxoEk5PswtJYSt8w2gLtAa5L8kM7Agulrsyq78esq22HyJZqVfvCT6DM3D2xDaLaIc3Y/USiBq02yK6iXBIUWnPjRK0q7+Yyy4DErSYEr4odqPA+LTRbAcBP9YokxVg1ryNj+vjHiSeiHOZXMBo=
Received: from BLAPR03CA0051.namprd03.prod.outlook.com (2603:10b6:208:32d::26)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 18:54:44 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::da) by BLAPR03CA0051.outlook.office365.com
 (2603:10b6:208:32d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:44 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:42 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 04/28] cxl/pci: add check for validating capabilities
Date: Mon, 9 Dec 2024 18:54:05 +0000
Message-ID: <20241209185429.54054-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd1fad1-2b9e-430c-8220-08dd1882f262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lreg3FO1P0gTYSoUeXuFBlF4y1+6krApV+4PrWgf9VfYEoyrOyxoMfNeIrXa?=
 =?us-ascii?Q?zxyBs1SL301g4k/k81npG1BGlC3dVuqN8Nbx2dWBI56uY1J9RuasoJJTgBZB?=
 =?us-ascii?Q?cQztgpqRHIy1l+UbsRp+q2d+2kBl68SGL+vvBwYdC7On/PrzQ7DiW6RGYBIZ?=
 =?us-ascii?Q?+4mxYUM4DIK8scA4ClnCkC99Ed8Lje77k5TqL8QJjwzOxCU4ZIDUo4zlguPF?=
 =?us-ascii?Q?nzjHRBc9aGn3bXaBl10fUg5XoRAqCEBhSkvnErRl4s5GAxTwJ+4Ffff8txh4?=
 =?us-ascii?Q?C7TW6AL0IANoEGzENa+o13T6BRiiVlvAPLlkBpavsQ8suGcbqcalbve7fnQd?=
 =?us-ascii?Q?wjOKFLOq9barDlXjmXWY9HjpEisgVMchNa4jOMFothW1lNbXaLw6o5SKUi3C?=
 =?us-ascii?Q?Yl8J1ULfbbfOkpeNtbSzo76iqynTv6eQetnMwlDdhW+G5rzvUYkvZU6Imxsj?=
 =?us-ascii?Q?QwKbwhoO+1v+aN3/rVfl+tmohZSjBE7yqwEJvwRMQZM3/bGVuEbfSjHUsqNl?=
 =?us-ascii?Q?YAC0GWThN39lfx4G/jzNZ1skQyakkuNcZ368A3B4B7r+mi2EAAFQhrT15Pv4?=
 =?us-ascii?Q?ngjWP08JJmfajjgsrHoscioD3farUTXK0nBbETApNslHWpKKygFsR0eunp9p?=
 =?us-ascii?Q?NGQh+s+x83ixzYfVfZsEqTGGjvEUaYNnGxcunuk0VfxQnl0V5ugeQkVrwpsV?=
 =?us-ascii?Q?SFErviHKBkDoLlD4+1DV5wH4A765Xslyxd0TFN6mADIoRmWTwGbGA2MIM+WI?=
 =?us-ascii?Q?2MovYVcz7Q3MiPdNyav3MHzuDS8ocEfH6Yl9glixfzTG8jYch48rd3Za2qZH?=
 =?us-ascii?Q?ZNIga2v3PXg5QhrHJrGQGPB+w+vWTA6WQukX7FvyirAbubeUH1wClPR37VW3?=
 =?us-ascii?Q?iBLgt8JYxn8KzN4g1bRWNIwPiG5UpLzBF0zYVzBBNzE4e2kDsmQ5gux4Qmst?=
 =?us-ascii?Q?7J1JSltjuQY+IWz5aAuWf2ZDd3BbiYIH/t3NOCThxdV6lalyA/ArF8003aHR?=
 =?us-ascii?Q?E8+e91rfTZ5adI1odmj9NqcduZDDAFmtQ0lfgRq8hwEJ+HJ6MU86oby2Hg9Y?=
 =?us-ascii?Q?SuALF2ELXW1tQWoVs2jq9WK0xRUxMJjXnoseoBXKi9+ygptN+ysN1b/Qu/cV?=
 =?us-ascii?Q?pjIpTOcZY4U4AyOUlhNzG712DPI4HswRHw9XlnNhIBkZ8BTI5bJm77FBfkw1?=
 =?us-ascii?Q?nqNhny068U49IQ8Rv5uiiEDaXI7bXZtklUbWidqLTLbA9xgOayn9Rqnf+Y1w?=
 =?us-ascii?Q?lNSFM3DvltNHnI0vlcLvzUw1qxKnzVlxg59m/UmMRr3l4hVIOWNrcb0a3BpB?=
 =?us-ascii?Q?Jo1+uFT1SHUSDmEsp6wgQqwxQN6rBsXGmM19V1RLIf3A6HbYMG7je2x0CCuY?=
 =?us-ascii?Q?qazOPTMFmKi9nOI2wPwwYhCE+L2mPNl7aLr+t1vkOIqnvATZQmSRvnUYOjiX?=
 =?us-ascii?Q?wwZI6TFxSHkb+KnBxHaouVOf74DWbq6yQDPX6EuJBnittar1U4WscQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:44.7210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd1fad1-2b9e-430c-8220-08dd1882f262
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532

From: Alejandro Lucero <alucerop@amd.com>

During CXL device initialization supported capabilities by the device
are discovered. Type3 and Type2 devices have different mandatory
capabilities and a Type2 expects a specific set including optional
capabilities.

Add a function for checking expected capabilities against those found
during initialization and allow those mandatory/expected capabilities to
be a subset of the capabilities found.

Rely on this function for validating capabilities instead of when CXL
regs are probed.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c  | 16 ++++++++++++++++
 drivers/cxl/core/regs.c |  9 ---------
 drivers/cxl/pci.c       | 24 ++++++++++++++++++++++++
 include/cxl/cxl.h       |  3 +++
 4 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c07651cd8f3d..bc098b2ce55d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <cxl/cxl.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -1055,3 +1056,18 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 
 	return 0;
 }
+
+bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
+			unsigned long *current_caps)
+{
+
+	if (current_caps)
+		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
+
+	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08lx vs expected caps 0x%08lx\n",
+		*cxlds->capabilities, *expected_caps);
+
+	/* Checking a minimum of mandatory/expected capabilities */
+	return bitmap_subset(expected_caps, cxlds->capabilities, CXL_MAX_CAPS);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, "CXL");
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index ac3a27c6e442..deaf18be896d 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -446,15 +446,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
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
index dbc1cd9bec09..1fcc53df1217 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -903,6 +903,8 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct cxl_memdev_state *mds;
 	struct cxl_dev_state *cxlds;
 	struct cxl_register_map map;
@@ -964,6 +966,28 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	bitmap_clear(expected, 0, CXL_MAX_CAPS);
+
+	/*
+	 * These are the mandatory capabilities for a Type3 device.
+	 * Only checking capabilities used by current Linux drivers.
+	 */
+	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
+	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
+	bitmap_set(expected, CXL_DEV_CAP_MAILBOX_PRIMARY, 1);
+	bitmap_set(expected, CXL_DEV_CAP_MEMDEV, 1);
+
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (!cxl_pci_check_caps(cxlds, expected, found)) {
+		dev_err(&pdev->dev,
+			"Expected mandatory capabilities not found: (%08lx - %08lx)\n",
+			*expected, *found);
+		return -ENXIO;
+	}
+
 	rc = cxl_pci_type3_init_mailbox(cxlds);
 	if (rc)
 		return rc;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index f656fcd4945f..05f06bfd2c29 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -37,4 +37,7 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
 void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
 int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 		     enum cxl_resource);
+bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
+			unsigned long *expected_caps,
+			unsigned long *current_caps);
 #endif
-- 
2.17.1


