Return-Path: <netdev+bounces-227920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E56BBD906
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2E71894B17
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C187121C9F9;
	Mon,  6 Oct 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t+meO9k6"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A721885A;
	Mon,  6 Oct 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744945; cv=fail; b=QAj10wxOOWToyHCI4okYZ4E6C2jzRPiOpmtnl87rya1U8Y309aPQDyEyv4uCjDea0sz8bN1Nk9EDJss0npGkCihEtQ8HcR5VYKWV23M1lfthBoBIcoeQ1Nxzwe3G/QgHmZJqecgI3fQLlwj3b5j8np9gtzKTFCd8XqACC+XzxCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744945; c=relaxed/simple;
	bh=4MDTE4whANPdauSEv9LR1BfnqsE6WIiW4Z9WwQTuwzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EizPOx/HwmduOZaVC5nA+OLc8HkWfaSjBU2qmC0Lu0kdOjuBm2ydnzn76KUpzEmmyEC8WS6H/pv+J0v4szUMo5dJN9Z4k8LI18KVRc5RuVxBTprOQAqmooPccH6v/8ua194uqsrlX84NSBWfs0cQNx3KuffwoZ2pQ087/Wg2eII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t+meO9k6; arc=fail smtp.client-ip=40.93.196.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7wiuKokG8B7mr/r5KqzHdKnHrKwKyuOX3TFISZOX9X5zTAHIJSswQLviKwPNpSyeXLchsKOpjUdLNDJp0Ehc/8kyBaOCBZy6kDXLEo8ihm3ykGy+QEs62AXforsml5KyFgDDwhVYfBLDTf7VZ68GCavdq0i4woWhbhlMfkWMCFVf+dfcNvYWS3LFFcW6bzShe8ei4ck+bWcxi4yMVcBhVYAjRYeQpDyAH8Dy+PSfPxlvh3gPCvrMFotKDkM3d90YyLmtfjpp196E9SE2bLs04quiTsZMWkhi9Ubn96K50z654QRHjaly1NN4V8Z1ZNzdk7qc1lhLhFr1esY0vp59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcQqz9xc4F5R9vaGGPaKgORfDPo2L6ORftz4dZjSTcg=;
 b=PZo/rjM2cv2shNy/3uHhmmACHVtzrMnbQvqn7PJYz5T9Djh15I1v86Lzahdpzal+n5sACGsD1sSyrx5RUOfnwA4MVZdzAnrWWxJ+YduxHAJoaH49EfD0Vw2wLohA5DSNad4SBPXBuFSccRWwpR5Z+378fU1+96iY5hMH8D43lVmDMiNrz0tzTUh+dIROGVUV+y2LYxkWdySkKG2t+J82X/c0W0OeRlRcCiniLxKPrYwG7z8R9buEFa24V0SG1Ps/2GInisicERk2i9NiPQBKl3rxlYHlC9jv8wcJFt9IuMR2iDlGIHKe/Pw7hStuZndYWgoYoL9IVKv7srkzRxdJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcQqz9xc4F5R9vaGGPaKgORfDPo2L6ORftz4dZjSTcg=;
 b=t+meO9k63m6t2MUVdfPyeIbcNtlbSJBtY39642c1Y8DQ7Liae6SPyqkGLDUmJ7CdOiTMSiDWs5YCd9L1KeC/wc7ILgXJCOkdsHZEiVVs5JQC+d7QEOnec6X3mq1uu0q+0WcaMGU5S4VFznxIuRtXG9OPwmUaSQGoFl59o4t/16Y=
Received: from CH2PR20CA0011.namprd20.prod.outlook.com (2603:10b6:610:58::21)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:02:17 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::51) by CH2PR20CA0011.outlook.office365.com
 (2603:10b6:610:58::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:02:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:09 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 03:01:47 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:01:45 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v19 02/22] cxl/port: Arrange for always synchronous endpoint attach
Date: Mon, 6 Oct 2025 11:01:10 +0100
Message-ID: <20251006100130.2623388-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: f9533f14-f59d-4153-4ffd-08de04bf6ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qSNN5lJSr1/8x5cbcewbnrmS71PjHiaxYb3Cty4qFyLIIpykvUyzd0ZlVVOL?=
 =?us-ascii?Q?67fV5NbrE9JGhyjqeUlOjGjGfmlFAZHsRsEWnstwrncrkcJ9ZZK4TbO5qibU?=
 =?us-ascii?Q?ln5DlPUzcz6nXEI54XcyMRDGalNtvbFx+vkEqS+ZMq2xVMTBTIC3wUbKVkmr?=
 =?us-ascii?Q?koNpquC3NdhZz9LY4uOWRHC61DKsmEWA5Da+tbV+7HcI6AaCw+u/eJUJiTJe?=
 =?us-ascii?Q?Rmad82O23DU+JowelwFpHsFYmhVonfZAUeyOR9NIT35ZMEuTh8s9za3wFXLd?=
 =?us-ascii?Q?8m+dCWkZaXzI5bcX190znrkY1SbICqOX2lWkPz/5BTnK4uGQH+LsKgM3s+xX?=
 =?us-ascii?Q?vQGLHcrdbxIHDVZQC7KdOPo80UBSlOzNNwPjvEdOOftr+MRfNVXORYIy9yh8?=
 =?us-ascii?Q?qIuJwaTTjBPDekXFrl0DTr3JghB47A/1tetHdeuwDypOp4jlmIafZgbkNMY/?=
 =?us-ascii?Q?VYrKojRxQWNE84UcIF6cZMGOd6If231uEohQ25oFs10lVm/NGYq4fy1MH4pe?=
 =?us-ascii?Q?RJtyI2LbUXNKYu/fM7M36ZKjTxhJqnUZr5vnOl2k7KhSfG8PE+ZFX3DmW2uU?=
 =?us-ascii?Q?toX5Bdnm5Lie3yptO7oGFiC5ICi5lIiQR3Wun+nE5Od+gfVxS99cGrFGLXk5?=
 =?us-ascii?Q?7rtCQqs1KGPlFN9xchZFeXyQzyQVi7kQ4XZlpiSYrxYTFLp82488wXlohD9Y?=
 =?us-ascii?Q?KonoGbmSoSRveVpp2wAWBrgUanD2IAEufMX7CZWC8gMsyeJc9/ke6wgwpTH1?=
 =?us-ascii?Q?uDijav0qzN6SEQ1S+6sDf+LjeR1g8bEqYG3yz5Ack1SCF+6a5GlcnSnGuKCk?=
 =?us-ascii?Q?0HV86gBEFj0sYpMU5VIXxZ+VpKkosVj0nUSm8H0ZITUySaPQmoCCSyETLkXV?=
 =?us-ascii?Q?X52FSWPiHQtS82l+WhB9W2hHG1fh6JH/tF5wweRXMMjgrkuYxWUw/TGKfNll?=
 =?us-ascii?Q?XCfc/kxjGRstnWL1xmqFeQ8nyG93TqlMadXhYWjqefyqxtdBl0QdB+u7cks+?=
 =?us-ascii?Q?AX5ewUwPObKv5izd29CLbbp9CNZe2NVZz4R1+NilpjVxnYe+dTs9i5oSFpAm?=
 =?us-ascii?Q?B13gI3GKUwJXSCneC0ZjcAEEBmQVrsH1FTXIJoKOrm13hVPKVpRghUkbseUg?=
 =?us-ascii?Q?J5+frq+NP8hWM48ulbUYawctsLHY4CWi7/ttqThxUA9Bs/L6YtGoQYS3Olwh?=
 =?us-ascii?Q?32EIWux7Z6DJrL9G60HO1TnWGsYHfqdNenTAqfWOzF58JgYgzGeAF3Wa4Iej?=
 =?us-ascii?Q?2T5/MZ+azyJeb0K8k4P1ye6yRZTTP5DGxoJ+qLQDDUgTtyZaRKjv2hVTVKAL?=
 =?us-ascii?Q?JqmrA7JSeNmfg9zksFnFrhDdiHWaTk2+J+LBHk145TW//KcblK7a6OOik8XP?=
 =?us-ascii?Q?flLHTME03G/NzXroSAAZBIyXpzYfQziwYs+XQ09weRWquQ/Tnf7caaBzWdUP?=
 =?us-ascii?Q?HnKUYKfV8LXH/TBI2gpsoAfLPPpeWvILvKs6Ao6nSRRXpVc1E6/mh135ilWM?=
 =?us-ascii?Q?E5VBlXq7C78ObSSUN7tUBDEb4BZGXNCH6+s6gvcO/b17ueVnGuIoh0vhr/3E?=
 =?us-ascii?Q?HDZX6ZjTu2X6dJLKA1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:02:17.4250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9533f14-f59d-4153-4ffd-08de04bf6ea5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590

From: Alejandro Lucero <alucerop@amd.com>

Make it so that upon return from devm_cxl_add_endpoint() that cxl_mem_probe() can
assume that the endpoint has had a chance to complete cxl_port_probe().
I.e. cxl_port module loading has completed prior to device registration.

MODULE_SOFTDEP() is not sufficient for this purpose, but a hard link-time
dependency is reliable.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c     | 43 -------------------------------------------
 drivers/cxl/port.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/private.h |  7 ++++++-
 3 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 144749b9c818..56a1a4e14455 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -47,44 +47,6 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
-static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
-				 struct cxl_dport *parent_dport)
-{
-	struct cxl_port *parent_port = parent_dport->port;
-	struct cxl_port *endpoint, *iter, *down;
-	int rc;
-
-	/*
-	 * Now that the path to the root is established record all the
-	 * intervening ports in the chain.
-	 */
-	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
-	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
-		struct cxl_ep *ep;
-
-		ep = cxl_ep_load(iter, cxlmd);
-		ep->next = down;
-	}
-
-	/* Note: endpoint port component registers are derived from @cxlds */
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
-				     parent_dport);
-	if (IS_ERR(endpoint))
-		return PTR_ERR(endpoint);
-
-	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
-	if (rc)
-		return rc;
-
-	if (!endpoint->dev.driver) {
-		dev_err(&cxlmd->dev, "%s failed probe\n",
-			dev_name(&endpoint->dev));
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
 static int cxl_debugfs_poison_inject(void *data, u64 dpa)
 {
 	struct cxl_memdev *cxlmd = data;
@@ -290,8 +252,3 @@ MODULE_DESCRIPTION("CXL: Memory Expansion");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("CXL");
 MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
-/*
- * create_endpoint() wants to validate port driver attach immediately after
- * endpoint registration.
- */
-MODULE_SOFTDEP("pre: cxl_port");
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index e66c7f2e1955..83f5a09839ab 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -6,6 +6,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "private.h"
 #include "core/core.h"
 
 /**
@@ -200,10 +201,50 @@ static struct cxl_driver cxl_port_driver = {
 	.probe = cxl_port_probe,
 	.id = CXL_DEVICE_PORT,
 	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.dev_groups = cxl_port_attribute_groups,
 	},
 };
 
+int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+			  struct cxl_dport *parent_dport)
+{
+	struct cxl_port *parent_port = parent_dport->port;
+	struct cxl_port *endpoint, *iter, *down;
+	int rc;
+
+	/*
+	 * Now that the path to the root is established record all the
+	 * intervening ports in the chain.
+	 */
+	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
+	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
+		struct cxl_ep *ep;
+
+		ep = cxl_ep_load(iter, cxlmd);
+		ep->next = down;
+	}
+
+	/* Note: endpoint port component registers are derived from @cxlds */
+	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
+				     parent_dport);
+	if (IS_ERR(endpoint))
+		return PTR_ERR(endpoint);
+
+	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
+	if (rc)
+		return rc;
+
+	if (!endpoint->dev.driver) {
+		dev_err(&cxlmd->dev, "%s failed probe\n",
+			dev_name(&endpoint->dev));
+		return -ENXIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_endpoint, "CXL");
+
 static int __init cxl_port_init(void)
 {
 	return cxl_driver_register(&cxl_port_driver);
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
index bdeb66e4a04f..e15ff7f4b119 100644
--- a/drivers/cxl/private.h
+++ b/drivers/cxl/private.h
@@ -1,11 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright(c) 2025 Intel Corporation. */
 
-/* Private interfaces betwen common drivers ("cxl_mem") and the cxl_core */
+/*
+ * Private interfaces betwen common drivers ("cxl_mem", "cxl_port") and
+ * the cxl_core.
+ */
 
 #ifndef __CXL_PRIVATE_H__
 #define __CXL_PRIVATE_H__
 struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds);
 struct cxl_memdev *devm_cxl_memdev_add_or_reset(struct device *host,
 						struct cxl_memdev *cxlmd);
+int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+			  struct cxl_dport *parent_dport);
 #endif /* __CXL_PRIVATE_H__ */
-- 
2.34.1


