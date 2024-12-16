Return-Path: <netdev+bounces-152283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED119F357B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2EFA188C13D
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F172063CB;
	Mon, 16 Dec 2024 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="08B5eZEq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F7620627E;
	Mon, 16 Dec 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365467; cv=fail; b=jEVR/Xp8414byQYI2bTcGXC3rFv6xQU1MEeOOcCKvdzmtbzVTo5krgdQl7Lhw0Hz39XFbYMwItSquOzYYbdvqG+gW4toVaDy5I2LNxj0pTsSJXxtWKTEpwFJuWSWUmg1xwHdB7HKhlaOGmzkVwWHokUBxe0Y9KahqNeLQpPEVJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365467; c=relaxed/simple;
	bh=TLYIrCrelPPlhpeBIPYvXjCI08W0aGFhJTTjJoJOJuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFvRcMLN68TdbLuF4xKB4iaAg2KED8X/vsjOQesodrdaYvLcmAnbH8IOBVM+b/WolG8yqpdr8TktNU2Il4EgcPiChZqKGiRULxdepk/xcYqx3g4AJn9MgbNN0IGOl7v7Zz09CUyn9RVibm/402Fj0pUCYce2/dUQwbFOqD66Us0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=08B5eZEq; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkZvoKMmUDTmRBFv7bwv67s2r8LNDL2qnhDG/PVaBNstzlkIFPIqJIgTsOEimRSqRR5etFbYU8ZxcfQHaYKVnhyVUDFcSKpPIhcODg856eJyKdGKrc+42t1h0D+PY+d4CGncGpagYD0hIappEx1Etu/3q3LijaiDtncEYmPfzLEgQWTGoeOEV2FwfYYsvauWN/towE+Hy3lLwv4RsfOcFUfApzpKudoyTLSFo58lufBRc5KMdE1w0uZajxVgSHTc62ezSlSYgzm4tDI7BKJqgLVe3eEsLxvN40uNX51xhQH+ALYEt8tdoQjBgNYFfxVsoGuKRWgpT9TxEYvjPgNmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2smvPSeFjaCNPDe8r652KORVWFswPfjIKbQxDECHXGA=;
 b=QEC4//8UXT6sn6t3zgg/y9R4Qoj9p+vhvK2XlPe1lzCrIEibsNFRsP90qW6uaLbYzGWIq7Hu8vmJgIuholeDB17IFubyMICekjXA2aWRL45lkHkpCYga+Ru3KwGLOER9prTfmEyiKb1l/cHgQ5/3Wh8Ci5ZH1ea6OYXmGiRx6eZ9meGT3NCQ6CXwzsuQk158YgSaEgwx031WOqXSDm2q6fYCu8ZBRIYG3zLu/Sts4rV2QaY822v6O4aK1YfISEMLe5r/PlaWa+l+1j/oCjRMlDercpT1vpuodzfj6EUQ7yJGB/F9YFGP5TYUdfB1+lSMdPq9Ms2Tv3b3vrJGXePFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2smvPSeFjaCNPDe8r652KORVWFswPfjIKbQxDECHXGA=;
 b=08B5eZEqQr8zWuZoKrcYOIlynkFbiAdHfCbqun/cRg9Dc0eBvzygZhle+pykC8CmiHxL2SXtsrv6ibHN4KPq/N3j3Awqk1ueF4jZfJjUthQfSWbg+rBg6Ga3VnVU1cgoHDHXkQsfg2mr6ym5Z1bRXc0TgkSNK/FSzG05v//wvHM=
Received: from CH2PR05CA0064.namprd05.prod.outlook.com (2603:10b6:610:38::41)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 16:10:59 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::5a) by CH2PR05CA0064.outlook.office365.com
 (2603:10b6:610:38::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.10 via Frontend Transport; Mon,
 16 Dec 2024 16:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:10:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:10:57 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:10:57 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:10:56 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 04/27] cxl/pci: add check for validating capabilities
Date: Mon, 16 Dec 2024 16:10:19 +0000
Message-ID: <20241216161042.42108-5-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: b602c374-1a18-44c4-77c3-08dd1dec3a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yGgQfYYpw5qY7p9uAyN2IZHHKh95dgS3vt3zK4GMepejY5id40/SzMixqtCQ?=
 =?us-ascii?Q?XYF7+2BB337JPGo31ky6Sx7ehTOhXQGSpDbh3Dr4qjw9KhfXCB9DSYxnqBOY?=
 =?us-ascii?Q?0QvcLUF1zOp0P2lvjUjOG/qJj294lgbsvd6lhL9ai/84Ct/yl81Df5KTFGw/?=
 =?us-ascii?Q?vb6zYFyOI/RxB+VI/yj8QwPBaU0eJoBZozvLJzu+7bDXPi33kS78tI/3gUSF?=
 =?us-ascii?Q?h8iQhbkPXXl6rKnX5alynOZsuNxPPxGfQT99LoFCkeXS1hwQQZkqcifpa5/V?=
 =?us-ascii?Q?P/GMK1J69HG9MPFVFUzyGTYBudEwEK60EOr0ypnfIbxoO/Wt+5wI2IdaZ/e+?=
 =?us-ascii?Q?GEzPvB7Y+z7qSwDcelQQEm6nBLvUydqL32zwCLlJk+CGRbnpbUhGv+ZIA2Il?=
 =?us-ascii?Q?+K7OtMaUnKX+eDw9Tw5mjIur9za+iG5HoPF75KENI8xUSYjnN8xM9n2LLhP2?=
 =?us-ascii?Q?TE9qJIgxjT8o1NLhIJJTiYkxekPNDe9D5lVGrcybolKj3AqXGccA0fnMVF/u?=
 =?us-ascii?Q?yssQkHnM0KhsoQYGb9ZudmpGYAKqPYM6kutLaOsDVclqWe22BBxwuiAC1noL?=
 =?us-ascii?Q?qxehqfCMHvdY64hb7AG+i0PQ0g/oD/YSrLwxoDJqLgatx7zH2r9lsELvYE5A?=
 =?us-ascii?Q?f3tD2AJne0h0ccl83Yhwj6PWj1J/2e5G2pw+YxqUgnDoPNL2Rb+vxlSzGhKh?=
 =?us-ascii?Q?FMdR6lnuUlr5XPKSMvC8SZah5yq8+GUmUdNVpC3uGOXOqeCtB49ExhYlMLgs?=
 =?us-ascii?Q?AhwL4O5S1lss48oN4uxlA+uaMwQeu7Scn6PCiwdJGp9c9rUpdb0DSLVHTXJY?=
 =?us-ascii?Q?9Sr7HnY6PscSM/hYZX8QuEeZEp3oU4TWyxQeqRI9VoAaUXNu3aH4iCodWRao?=
 =?us-ascii?Q?lQoeObYGZ5ARK8+vH+aPss+a0HcAOpF13y4BmbxK3YMRrOIewD1WegSE32Jj?=
 =?us-ascii?Q?t5Gn4AH1hq9u+FmmxqA0i/ikWZ0QIA0YSJm2/Y0Z6yW9JtIqCrLrwvX+Z6x/?=
 =?us-ascii?Q?Up8qtX3RN381T/njSlWZCCtaufWzGEUXbltBUofbL5AHrKAkfaMdZX/r1503?=
 =?us-ascii?Q?ESiiHxZYAFEfi5foNBiIULm/2hEfkLXeMvn8ITKbAeoq3bMYdyQhvzApSd2C?=
 =?us-ascii?Q?lspYDp5rdFT7MT3Xo3/5omPr6l/8mdXa3zfFCxCR08w1AeVkSbNTKZjhAXvW?=
 =?us-ascii?Q?jR5sOTxCtyN+dQMqBl5ewOU8B7gQd0X4xEPzOry0y3O4RP6tq5msqiZxixLy?=
 =?us-ascii?Q?v5B6Hnx7b4s5DaUfcqhWILrNRiafr+Yd00tNmgWLotBiXLycH3klG6CmvGaB?=
 =?us-ascii?Q?nBpbzkZ5/LZC/3ppQ/FgRJ2ErZyUdGxptU8YMO5BRetRlK6cNmje0mBNo+Wr?=
 =?us-ascii?Q?/rm4GwVOKQTQS0TF7xNPEIk8FKDbmj31OfrQUgNFa2npki0Yk1u4nv+DrHyw?=
 =?us-ascii?Q?6AutJqEtyLCPV0nJS1pJ/JS/KWd3a3hMxeDjD0hX51YOqGViN2TgyVo20UJY?=
 =?us-ascii?Q?bWKkQoGA8sUdk7g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:10:58.5175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b602c374-1a18-44c4-77c3-08dd1dec3a69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

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
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
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


