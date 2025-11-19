Return-Path: <netdev+bounces-240136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48307C70C8F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98E804E11DE
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2927314D3C;
	Wed, 19 Nov 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jfEXduXw"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3444A31AF18;
	Wed, 19 Nov 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580186; cv=fail; b=VO+qm5PoFg/pMmkOvzoW4bF7xS4+nfkftPQ1WDK6YIQmYMCquix/ugHty1cvmfVNB6Wz+KXB3wAV/JY5OeDqjW2PghHvpSdaVakVsE43H2p6sFMUcO8a5ZsLLYQzbSnRvoE8Enr/xFIehLqWvYnSs8cusLr/1RD0EDFjwBm0eu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580186; c=relaxed/simple;
	bh=Y9WhOJUomB0toTSBHKnHg8tKkX55Opuo5AohMRZlb2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k610vy21a+h0M6MUZDZImYYvkNcw/hese0QRqyhfBPIxTCQXqiowZXid7INWjnwZxhvaOI8E0iE/akpMNAx5ve3FxOO+S3VvQWjslljzl0qAnnyboDQwFoGlZtrnqb1MwPz2WjstIaYRQJAZjbNLIQrylfFLSTSgff2XMGWBMfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jfEXduXw; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHuCyHNax7c9Vkbf6uWhlFNP0AlxL4gO3ePtiwgRggWkG4Q3w783YlbH+TkhLOENcq7sXPPO7AUT5vHdG/G27sPJWLQoX4S1de1sFdICNJ2rpDey5RJS9aHrKjTJ9eqIC4Ilr3gXz8bR4XPFcx3YAnI88eJicMyEQaDnVVKLR/0qz2tb0NqBq9e7U1uMmCRCMujNIbEKSaUMR3lYgFiltTMTQFJejQ8VhaWA5gPDj2fa82a3Xlh2q6ktxHGi57TlQs+kE5lVUhlvSOSmVfcxuV/pKxWou9CadFQLN6xTBqFFIdJugNqXYbwD9eG/9+HpKg19+FI0FZaEj67yKh9GOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD8H/aDSNkH1ZTS7mjGE9YTw9nvkvcTWqKiUmEPKSrE=;
 b=sw05yblRLIzUaxtKgb/fXiITZIVGeUCYCsztE1sDXwQkvkpjbeSUpvJPrTBPCzFDtJLtTcNSL+0s2nBWx3d9KyOhJelRr6n8WvXNx8+DTZZyhSBNy7uMUfT6kfCw94Oc2h00njFgO9nLo2DqwN/DwquHP+2xyWVUgEzQxNBg1BHeF77slhleMkUR6RAARLmmQXkD2BRtbJsPkTQSGdK/nXCkGsHmWUnhvQwaeSpRZRx/D3/Zf/O8lAtTIut3edIr18Bai3MQD54vKH/ZY7z00c9rcGISt/uelTZD+B9ZIE2WM5pk1ph/YiZO77f17YA2t1Z06to58FdNF4l/RXnY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD8H/aDSNkH1ZTS7mjGE9YTw9nvkvcTWqKiUmEPKSrE=;
 b=jfEXduXwdpzWi8GKSHIk5s1nLIEsuuVEVuPqbgGii3Z2WmUWe+iAX7tQRhyT1kt/GRLTW9T/HR9l+E9QkHjk/ARzZ7wfaly8tvvmcb40nLjOwWmcdlOIWekjd9qMymyX3NvKYJ3guAiydNQeLQ2H/F/7cdg2iPCQ+Maf8/czcXE=
Received: from SJ0PR13CA0204.namprd13.prod.outlook.com (2603:10b6:a03:2c3::29)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 19:22:51 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::2f) by SJ0PR13CA0204.outlook.office365.com
 (2603:10b6:a03:2c3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:22:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:22:49 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:22:47 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v21 03/23] cxl/port: Arrange for always synchronous endpoint attach
Date: Wed, 19 Nov 2025 19:22:16 +0000
Message-ID: <20251119192236.2527305-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e18d10f-f2c1-452c-0c28-08de27a10826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HhwQ7ij4H98AdEAr+33bg2flqkh+tPA3XqqjIp9m/gE/eYzluonCaXeAmizm?=
 =?us-ascii?Q?4Vb7tfbzsNumizEboszI5roNw6BGM8dRW/84nCKYz3ejYILLLzqhdGwgsJPD?=
 =?us-ascii?Q?H2Ngq/vcVGRpHLxlvyJMgCNEkaGkzgC85EZt+EXpbFZCUUPuX1kNSlHTOMnu?=
 =?us-ascii?Q?UQmH5xODRfnAnNK6bwtnoKz7U/sgo9fwQnAlyCegvsm4seYuwMObWa3omfGK?=
 =?us-ascii?Q?qbDcUeEuqlXNqcl3WDoPrTtEfLKRNGW393PY8/sTdmPJdU3LrUltLlMFHAU8?=
 =?us-ascii?Q?UGfEZU3vIMZ0iNqdbZH5Hosa0Djkfd58EOnNiMTukzvIm7HbLfXapbSbBdyZ?=
 =?us-ascii?Q?9/89fHBDEWQSEPiUWGY3wcKx+MOhr1nLrxo3oLxTcnejR2zcjXxShDUFNxj0?=
 =?us-ascii?Q?nEovk4TIYGV6eRsxdO0IMEQDB2R9fqtdHiXg+BQwyN4mT4mK52JCvPnS2a/8?=
 =?us-ascii?Q?UmIlgrX74bESviRFUYu3vW9oj8Ri/SBYbaQw/lGPEU84W2dzo1n728udgUwe?=
 =?us-ascii?Q?01ujKgbZvDCUS7KXUHilVVuQoQGy0rieaZ48VlfxZcjR622jYpWlIXk66YOp?=
 =?us-ascii?Q?Gvl5ULtPJbVZdoFvT5u+n1I1Wuu2Lz7yCo0QBlcSG7sbrwy0n5FVlMN+a5Zo?=
 =?us-ascii?Q?riwP0aDwlpv7WiQn1WUhJgjh/Yz1jdf3RId2Sn3F1E4Eu/7g2CjfZQrOXY+e?=
 =?us-ascii?Q?1fjtN+qC6Hst6hXKOzbpw5hvSeXArd0YAr+sW5gH2xAXMv2Ps+LzLzbpv2yl?=
 =?us-ascii?Q?Yt0JdaTFj7rny4A0+ujmMXfsDUVr/XHSxeSqrPh2Dl8jDMHIq+OMFkvWKcbx?=
 =?us-ascii?Q?OuzAoWpIt/DYVsXTp483QHZk2KCivsSCKzWi8F0XlDX4I9oYtccxllHqfmxG?=
 =?us-ascii?Q?Ybd2VeBt1gBuo5k/OVtXjHa0Lt6nIkTMYasa2lxs/YEtvkgoYjXWlw8aYWFh?=
 =?us-ascii?Q?VcWrknQn33ad/NUPaNigillONhJ1ikVkJPqV5sRoyVDxPCJjibCOhI9rdcDF?=
 =?us-ascii?Q?KMmgOkVL5ybi7qKFs5pC9v9J1V6ffdC18GgMjNN9bpOtGMZ7gW21UsyRyL/Z?=
 =?us-ascii?Q?ZN86hQcw4ce3Ug2NG9Dzf9ltL1tAZ2X5I3oBwSIVZMzzavtXMuwOjmZy5DAr?=
 =?us-ascii?Q?+26FaJT2Sn80YMRBrmlOjYF+YhAFYAJ01FCnmU/aoQ1HbH2Ge+wOQyBTNSQU?=
 =?us-ascii?Q?gIE5Nt9GpzBUzBZleJvIGq/jvVEUS2sjKpkJBVslCp6jzru/bN7vwa/mxTsL?=
 =?us-ascii?Q?mg63BTD6/o07M58K9lzIN+CdPWL8yOW607FJmQIAMGBOgy4Jfj1BgWFk74Di?=
 =?us-ascii?Q?outQBk9oYEKzxSl1ZaAFI2fkO0PkFJrYtlE5lqV2WhXDSjpqfgmap429SZ93?=
 =?us-ascii?Q?B8Z5gUtOWTsSlGfxwExVfiHEapJ3SYQCiGLVTDv4FJ8Cqd3GbbsbRptxSrYP?=
 =?us-ascii?Q?gioojCEVsWx/VZ+hl6+/E3Ay35MbbuU45Oh972vjgs4h5G8d5ZIIQnz9xCnV?=
 =?us-ascii?Q?Vr1vvMM90g90ch0FsIQ1/fDUgDwaHFolT0PTrsKCQlcJz16fORHhpcCES8Ig?=
 =?us-ascii?Q?LrIbmb32PhJtgnFUcZo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:22:51.1789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e18d10f-f2c1-452c-0c28-08de27a10826
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956

From: Dan Williams <dan.j.williams@intel.com>

Make it so that upon return from devm_cxl_add_endpoint() that
cxl_mem_probe() can assume that the endpoint has had a chance to complete
cxl_port_probe().

I.e. cxl_port module loading has completed prior to device registration.

MODULE_SOFTDEP() is not sufficient for this purpose, but a hard link-time
dependency is reliable.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/mem.c     | 38 --------------------------------------
 drivers/cxl/port.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/private.h |  7 ++++++-
 3 files changed, 47 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 3f581c37f3ba..cb16adfa56c8 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -46,44 +46,6 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
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
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 51c8f2f84717..ef65d983e1c8 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -6,6 +6,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "private.h"
 
 /**
  * DOC: cxl port
@@ -156,10 +157,50 @@ static struct cxl_driver cxl_port_driver = {
 	.probe = cxl_port_probe,
 	.id = CXL_DEVICE_PORT,
 	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.dev_groups = cxl_port_attribute_groups,
 	},
 };
 
+int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+				 struct cxl_dport *parent_dport)
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
index 50c2ac57afb5..f8d1ff64f534 100644
--- a/drivers/cxl/private.h
+++ b/drivers/cxl/private.h
@@ -1,10 +1,15 @@
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
 int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd);
+int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+			  struct cxl_dport *parent_dport);
 #endif /* __CXL_PRIVATE_H__ */
-- 
2.34.1


