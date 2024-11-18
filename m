Return-Path: <netdev+bounces-145941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 921949D1595
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC09FB26BCD
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0833E1C07F2;
	Mon, 18 Nov 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PfuPjvMg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B611BD9D0;
	Mon, 18 Nov 2024 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948297; cv=fail; b=Fs3SkTReD/rUB9jD9oPePDHJaPlBgnZPMUsq35YUkglFXoHbunpaK1QOClws1WWycZjGzlrUZK9+EsN5LdLxGAg25RC5SS+h2Tu/208KbgCkhJCx3vUUJl+c/6gMmF2SrxrIelBhta9tJuYRFoY3JIIJzG7az12gKEYparyPCMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948297; c=relaxed/simple;
	bh=S/58Hr0xBVKot8uvjqN6SJjjuuOPAWvdEXKhhDbXWiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUwzBrZqp6Qtiv2LZOsnaOlnNTUYNqP1Rrw4HT8HNrT7Uj7u3hH5E9hZMWVQiC+OLElvQKwtGZDVec/qjfS38nEzfK3J8CvhumBJM5IGP7SDL7NOiuMWAj0In7TdH4DOZ3+LTjcCrBarRyH8VhW4KQKDajkUA94+6qzin7bm/3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PfuPjvMg; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxSsyBfUfiHCt9igesmaxBVqFtYl2P8lcpw2V6oH/7l+9xd9rH20xJYr7ohQigU6MFtbuw83JfN/rqANTfQaaNka7VVP2rpE6qFvYKfVVNFeX8HAIKJtGAPiS9ofn7gTq0B1+SpXAweXcs88vuaBLwgUBXQSAOVpKiVDbPKRFK5tZGP4Pe/gvUH5qwbF5671IehHvZP+jJWLLwLIgBfKcVZ1dNAsHbbOFTHQ4TyiL6Fgdy24vSH8Drna2C8L0aS57ITog+vybNUUgB0DIAMZbmbPN92jy2gMuMp2RwmtehgDKnRW3sNgv5M46CdaUtbyNnXrqFMvyYhlyL0S9fcsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6VlfZ7IazsGr05GRcYRjRa39OQhxfMSYkTWCJfz5xo=;
 b=jF+r1YsIbollh1br0jtt8KoPXXuAFaLrEiLAyWfnnzHV5vwQAHP1Z5mmMDdy59jvKBJoJb3Sjug4ZfUfaG5Dt4oTP6B0LfQ2t0ZmEYqbA5Vjd3yGQ4EUfT90EgiHUfWKeHMvB3XP1MXQ4AbO59M7RtSxjsiamiJxw6OTCEiGoY+Zx5Sm1fJqmIIdyt6dKsBzNzE07OKcbNX0Sa7ORlMx3tDIhOlcgSZ7VPP7zYthVAkpj+43lHM97K8rs/fByulVcavWtD3k5JRdTJH6UabxzOHyPR25YfkRE0/5MSVKwyZzCttSXoDBGWXTrGG77DlrQN2kRxJYpZts89Ybd6MEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6VlfZ7IazsGr05GRcYRjRa39OQhxfMSYkTWCJfz5xo=;
 b=PfuPjvMg7jIli1JQAvOwl8Nr2sB1/XmmX6jHVCPvJOvYL1jCYvqjCbXRPKT042KeBr7ofd01WsZibu7rI29tb5i0DVc6c14NW1aeHEae2fm00WeHJIASJC6dOJMjc/ia7Kpfd3aaHdJokANasPC2M5GyzefkicXPRTDEmIuaiqs=
Received: from CH0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:610:cc::29)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:44:50 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::b8) by CH0PR03CA0084.outlook.office365.com
 (2603:10b6:610:cc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21 via Frontend
 Transport; Mon, 18 Nov 2024 16:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:44:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:49 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:44:48 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 04/27] cxl/pci: add check for validating capabilities
Date: Mon, 18 Nov 2024 16:44:11 +0000
Message-ID: <20241118164434.7551-5-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f70ad99-3ff7-4897-ef17-08dd07f051f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i52Jy4ieD8m73coEaCUkT0Wn9mpSBXugNgenZQJHUW5JydQZ1vo6TngNIqRv?=
 =?us-ascii?Q?mTY0jK8XRIa2YzzRxpezpGNGmEjgY6+bu/fp0GS2rU7N/ty1+T77YEtQcnPx?=
 =?us-ascii?Q?yziDH1lUqZRup35tobgiSqQszZeoF0kMxpGBmuZu/Qhv2msmSwu600yLoRT2?=
 =?us-ascii?Q?HdV1jfNDzDgRf6hl0Ie6/H1ok9zeCSnf9ncjrlWoml7c1RI5LNSjruaJbvHw?=
 =?us-ascii?Q?cbHNZ3dn/qr+KCkJU10Y7oKVmcNeAwJjorfUUtlZ/m/oaz08tP1FIouzB3vK?=
 =?us-ascii?Q?qz41+RFED3UdelxDbXvk8NzDuqGhZB2V/SoTdYEMt26XEVhB6OzL/XR08b4y?=
 =?us-ascii?Q?rWs8dDAwd8gSONF2PJM/Coo4xXlsp98WCEDGmO2C5oXON59pAoSF7g20DfwO?=
 =?us-ascii?Q?qYgFsarEkCd7danAzcgZJjte3g6ez05fLrXXJIKyuoMGPL6TyAq2Gn7T4lWa?=
 =?us-ascii?Q?GbWJijbzZlFxTyPerqioR5Y3TICK1jUqFmiC4M62wzfvR4DqJbTufEpclVlH?=
 =?us-ascii?Q?q4UVOLSpXKyYUKAlMwgHuGbpVUhLljNy2YGuKDM8D24MDTH/WAtZTjWMogIP?=
 =?us-ascii?Q?HYwX3vKGhIs9CWOuYl/aXiPAkDDyHC4ri0dAYL+2RLtH/i5Dmbp41RqSx4+y?=
 =?us-ascii?Q?qrvRUjikXeqqPOcshcQINJNpTLFedWtXJptHcozCrY2N/J1qp35+/hR3v6i3?=
 =?us-ascii?Q?POBtDHWF2D4jNHgvpyprrOy0m1dS8CkiKF5ynUjfK6T2C6Jm7PYNtr6KNyiy?=
 =?us-ascii?Q?1oNaI2vOky2jtOvqDXHVAeY2LL+Cb+rXTSn890Fx/wFYaQjwgXB8CNggW/zt?=
 =?us-ascii?Q?vRpQRy/FxhFlQeI6CLEZFaskj7KzB8O2aXbIgGY9w2WkhKkez4pL2nXpVF3w?=
 =?us-ascii?Q?t6S/sUQwggqCrZQMPqoJJkLYUiD6r6ybx03Mi07edTkYiXrwtN5qIKhNcEpn?=
 =?us-ascii?Q?I8prwbUqQQRFcb0Loq9od1VmyNPZCmLjh3yejPuknrDULPTblREyOQy3rSYa?=
 =?us-ascii?Q?HYy8T6ZqeClvzqW7CLpEVAvwhKAl81OFFNbLHrjjrxquU7HnRa6M7V/8S02X?=
 =?us-ascii?Q?FCn+LncY6Fbbp2Y1ZWlN61mirTol2t+F+RdDW+7eJRQ5NsX0xiS6QwmHZ02r?=
 =?us-ascii?Q?KKF5dZBWUruMNRqDp9aQwL/GvF9zq+9kjBR8zquKphqPAoEgG7VivEIUFBbW?=
 =?us-ascii?Q?e5xha62dde5OdohRpuN2xRTF7jhczEuDHj/fvZVCRL6bHUj5wkW1Z4JoE4zz?=
 =?us-ascii?Q?TlYE9mFSdNu5dnCX6X7nBF3SHTgCtdcv/Hm+5g3bNgc0k5ZtkRgO7sOfT3Lz?=
 =?us-ascii?Q?KO+ijg87phGJ2zIYfGBWnSfkc+xry37EfxDb2WlQ1orVaLOQ0776EtT2WCcr?=
 =?us-ascii?Q?c0Hc3NhosX/+Iv3m1x418jBA4+2V/Qkmp21suh7mT/hXri44wQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:44:50.3740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f70ad99-3ff7-4897-ef17-08dd07f051f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532

From: Alejandro Lucero <alucerop@amd.com>

During CXL device initialization supported capabilities by the device
are discovered. Type3 and Type2 devices have different mandatory
capabilities and a Type2 expects a specific set including optional
capabilities.

Add a function for checking expected capabilities against those found
during initialization. Allow those mandatory/expected capabilities to
be a subset of the capabilities found.

Rely on this function for validating capabilities instead of when CXL
regs are probed.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c  | 22 ++++++++++++++++++++++
 drivers/cxl/core/regs.c |  9 ---------
 drivers/cxl/pci.c       | 24 ++++++++++++++++++++++++
 include/cxl/cxl.h       |  6 +++++-
 4 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index ff266e91ea71..a1942b7be0bc 100644
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
@@ -1055,3 +1056,24 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 
 	return 0;
 }
+
+bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
+			unsigned long *current_caps, bool is_subset)
+{
+	DECLARE_BITMAP(subset, CXL_MAX_CAPS);
+
+	if (current_caps)
+		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
+
+	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08lx vs expected caps 0x%08lx\n",
+		*cxlds->capabilities, *expected_caps);
+
+	/* Checking a minimum of mandatory capabilities? */
+	if (is_subset) {
+		bitmap_and(subset, cxlds->capabilities, expected_caps, CXL_MAX_CAPS);
+		return bitmap_equal(subset, expected_caps, CXL_MAX_CAPS);
+	} else {
+		return bitmap_equal(cxlds->capabilities, expected_caps, CXL_MAX_CAPS);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 8287ec45b018..3b3965706414 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -444,15 +444,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
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
index 528d4ca79fd1..5de1473a79da 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -813,6 +813,8 @@ static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct cxl_memdev_state *mds;
 	struct cxl_dev_state *cxlds;
 	struct cxl_register_map map;
@@ -874,6 +876,28 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
+	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
+
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (!cxl_pci_check_caps(cxlds, expected, found, true)) {
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
index dcc9ec8a0aec..ab243ab8024f 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -39,7 +39,7 @@ enum cxl_dev_cap {
 	CXL_DEV_CAP_DEV_STATUS,
 	CXL_DEV_CAP_MAILBOX_PRIMARY,
 	CXL_DEV_CAP_MEMDEV,
-	CXL_MAX_CAPS = 32
+	CXL_MAX_CAPS = 64
 };
 
 struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
@@ -48,4 +48,8 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
 void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
 int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 		     enum cxl_resource);
+bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
+			unsigned long *expected_caps,
+			unsigned long *current_caps,
+			bool is_subset);
 #endif
-- 
2.17.1


