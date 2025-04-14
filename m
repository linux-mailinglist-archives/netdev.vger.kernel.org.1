Return-Path: <netdev+bounces-182287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FD5A886DF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6B13BFFC2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A36274FD8;
	Mon, 14 Apr 2025 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QCn67jEe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4C2741C7;
	Mon, 14 Apr 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643639; cv=fail; b=mVoyN1t8ikLd+qo5gPnFgsl5k2OvQwGUpXH+xoRb0wM9II9PunizqxZE5WFTP/KejlsHCFPv288UonVEIDMX0Dmc2DrT851EZCOf6oARvlHT3ftB7eDfgsF0AvMtkuqlhGK+emGHLhGjNCl5E6vAfRvvjNNEtz6wQLQ4mwhg9ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643639; c=relaxed/simple;
	bh=U5POwTZTy9gEsYjyTZ4ym6P+VIpTYPPC0MJj+BIczqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sY2fwkEs2osesjcKnG1p5aUhuO0B/pBTSKaSl7VywPhfWX/hMfpd4gT/po+PGQe51TqJ9gcLhhYakr+bAXX6kBT6cApazuQsKMq8qpqgSdfjMfNXPGN8ObCQzYczTrrjA0rG+wR+h73lQCP1zuDEmloco07/G6IlxzDZZpqFn6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QCn67jEe; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmmpGsiEWa1A9HlsjfUguWJf0DzBlxhc/v1QF10JrkO7wtBRQLBG3WuCXtAkiQUdS1ujCe3O15kqlyhKapYZDUdKy60AHeWim0XX530esHoFeeUmRq1uJTrb6loC6QtXOEzpzLdrGgvUIR1sIVS3Yh2FUWrrNrUKmQqKgiPie4tJjcBoKOaDwICNpfIsrOs8691zovXepO1B48nD4WP5OWs/VNi95REHrfa/FuuoSkpBrCz8pGi9z24QITWqj4qhQZh5TjEtNqAAwV8/5rRSqjrusBulJqtAB36MqMZ99BVPWCdjce/i/lF8Ts/99ckkmdhHr8tim7BOW1o357H8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHgggfVbJPKT0do7M0a0Kw7M4TYgNJFqS44lmNZQK2I=;
 b=xxUusKGHR75ukx7ObV0Jm0oP9paHMgjq0no5UPZldj+HZtjuVyfbj9ysIjzKX3ZdLgw4MbsgjljIFCDHh0fXsnZtZbu5mSc9dohwJ2EYtceCOQ+NVTJwLa9OMTGl7L0KNpfmBG+ZKS23P2RZLwZSmWpXhT84ahnN19t6zHiFutv5vk+NLFSM8g2F3tlt4I4uI3X/dQ+vTr5CAFqfBwVDOx8F8VAbe1Rhe2sQUF+T3dlvkBUPcGQSfqZks4/JjqU86wh0/BHlhj/xSfNkYW9JLq9r/P1F0SVLn+neCou/PV/afaxuOhO2OxpFDJGdtIoGGIsju7Iz1fqbv36xdEHK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHgggfVbJPKT0do7M0a0Kw7M4TYgNJFqS44lmNZQK2I=;
 b=QCn67jEeRuLp7Av6xg8GM5GIpHBLWqrkYTLLd1S0C4KTU10nL7K/l3a7MTNBQ9KgrJYT/pkcuWx9H6geK8QBfRApAG68tssWjc17YoEacGy06ljoie4U9QFrmIdnZFV0wo7n8QTvwHH19+iJz58cPGpoK59FSIAF+kTIp3gQ1EU=
Received: from BN1PR12CA0003.namprd12.prod.outlook.com (2603:10b6:408:e1::8)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 15:13:52 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::c) by BN1PR12CA0003.outlook.office365.com
 (2603:10b6:408:e1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Mon,
 14 Apr 2025 15:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:13:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:51 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:13:50 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v13 04/22] cxl: move register/capability check to driver
Date: Mon, 14 Apr 2025 16:13:18 +0100
Message-ID: <20250414151336.3852990-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e21627-c04b-47c6-a3ea-08dd7b66f71c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VLfjJMO8yzVkRAMqVLGljm2lasFhp7wxqsTrhjz3qeGA/EEywsknYu2XFWBf?=
 =?us-ascii?Q?R76JQ6Hwmrtg/mbSWku+kG20xm5tde+pwodfieyC4GWpOk8M3x7Ry9lR4FmE?=
 =?us-ascii?Q?ZverkNFOOfL2ItGuAmbYjDMQX3cAUu7bGTHuBkjARy8c8xgLHP0ZIJ6sdm80?=
 =?us-ascii?Q?BygTeUf2ht5n+d5L99MglUKhCGE1OQKmoebWkfkD1hgS1dSWSNF4VxuvT8v+?=
 =?us-ascii?Q?YCjJANfh/8snhivVCqnlC1UVj3m4oYGVEymHQdlGBaaG/cVLRJguloUrng6M?=
 =?us-ascii?Q?Lvms0xN6+u2JDruA5XcGBg5x5JU8zz9LcenDjqjLZjJQfd+qb2fYBn1/EspP?=
 =?us-ascii?Q?msemoaLfoTWl7l8HUSOrOMbn+UzYQ4fyHSOw/MwcXR6bIBS2vyEQHXxoaIxF?=
 =?us-ascii?Q?P5myHwBH+9tc6erO1LhHTYwFaGWky7M3ZZxQWnchvA+GFIQmXUhPIi1tSL+/?=
 =?us-ascii?Q?bpjtdTfhmiw1XqlL2SrfTZQ+eYiHUu2lVQmmsZsaN/LLc7QPsbaWYl/VaK0W?=
 =?us-ascii?Q?AwQnWxLDEq6Owchfr/vLIsXoYPHeO6M3rcm/FfjVgNza0jjssQW/wCEM5XNC?=
 =?us-ascii?Q?087qiWfyB69ivGqFoaNgbpa8Wd8QQ8cKw43TvYEM1rYh/eNSDvG1Sg7By3BA?=
 =?us-ascii?Q?8VVqsa1AvioeaG0lxTfB5tDBgYxw4k0p+p8uDGNA3CQHEeCN52e9HuXRDZQK?=
 =?us-ascii?Q?/hj310EFXlK0Xk8jFoky6cGj4fQMP5RScyoA/qOfltmKCWAT+SdY4xFPPrhn?=
 =?us-ascii?Q?WJR4zK7okxlvMAm6icJCNGLQXsDFTgBcasHPZM3LL47BQip3u0LEycu7kWl0?=
 =?us-ascii?Q?zAmM2DlJrgKFZ2TsYRZnTOVSFdEW2/iENLXFgieJALeTSupP50aaTIoIAVUG?=
 =?us-ascii?Q?klU+z29A48ujnxpxiCquJrs5GzNTm57MKrzD+lEnhEjnZjgDvyk0PzfX7pZu?=
 =?us-ascii?Q?epZcHM7YR87oaXrN3syyn4VQdHwmvHxgScfZSiLYWPaJch8VkmHAR5VUBcVy?=
 =?us-ascii?Q?Yt+Qiqdnq6u7oGW6jvJle3dRoBWU6o0/oriRnN9EaQDtKt9R76S3dMYc45a0?=
 =?us-ascii?Q?FAAjkr6v1zvCOIPVA44X61I8jY7bWkEHKFfLDSvrHG3TkBND5cSdc7jdXTk1?=
 =?us-ascii?Q?fRlEGQa3529DcUoHtdxjAkwQroHzh5rMjnsAQbOLyGmZKWGLO0KcdgLTcP/Z?=
 =?us-ascii?Q?h/Focxc16hE1OjxmJhD4bSrPVMeeQek6IO11Bx5BHAVCq8+yXE4WoNOvjQjR?=
 =?us-ascii?Q?W0deGEK66LfBJfo7MMosrXHNFy3Cm6KDA0/lDFo88KL7OkbY0KmLEqi/WbVa?=
 =?us-ascii?Q?8/yTjRSqYKvcktAmIzjbtPmbxqgogWKv0BN9Jj3QGzAWtuUYUVjccUYclDjo?=
 =?us-ascii?Q?XEn5XD5/p/NBY1vlXNBPNkpfwsQM1DCmNXlnaXiz3TL1KzyAoJ1i5oxZu8hX?=
 =?us-ascii?Q?E4xVHCHmU7eNZcYQVj3vU0Sze0as50tg5H7udTZRtZQCuRBJBsTtq0T9w30o?=
 =?us-ascii?Q?71z9FBIY0Rb6KmkzDJPAv3/zMrKfHCbBpNo8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:13:51.8895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e21627-c04b-47c6-a3ea-08dd7b66f71c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140

From: Alejandro Lucero <alucerop@amd.com>

Type3 has some mandatory capabilities which are optional for Type2.

In order to support same register/capability discovery code for both
types, avoid any assumption about what capabilities should be there, and
export the capabilities found for the caller doing the capabilities
check based on the expected ones.

Add a function for facilitating the report of capabiities missing the
expected ones.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c  | 35 +++++++++++++++++++++++++++++++++--
 drivers/cxl/core/port.c |  8 ++++----
 drivers/cxl/core/regs.c | 35 +++++++++++++++++++----------------
 drivers/cxl/cxl.h       |  6 +++---
 drivers/cxl/cxlpci.h    |  2 +-
 drivers/cxl/pci.c       | 27 ++++++++++++++++++++++++---
 include/cxl/cxl.h       | 24 ++++++++++++++++++++++++
 7 files changed, 108 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0b8dc34b8300..ed18260ff1c9 100644
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
 
@@ -1214,3 +1214,34 @@ int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
 
 	return 0;
 }
+
+int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
+		   unsigned long *found)
+{
+	DECLARE_BITMAP(missing, CXL_MAX_CAPS);
+
+	if (bitmap_subset(expected, found, CXL_MAX_CAPS))
+		/* all good */
+		return 0;
+
+	bitmap_andnot(missing, expected, found, CXL_MAX_CAPS);
+
+	if (test_bit(CXL_DEV_CAP_RAS, missing))
+		dev_err(&pdev->dev, "RAS capability not found\n");
+
+	if (test_bit(CXL_DEV_CAP_HDM, missing))
+		dev_err(&pdev->dev, "HDM decoder capability not found\n");
+
+	if (test_bit(CXL_DEV_CAP_DEV_STATUS, missing))
+		dev_err(&pdev->dev, "Device Status capability not found\n");
+
+	if (test_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, missing))
+		dev_err(&pdev->dev, "Primary Mailbox capability not found\n");
+
+	if (test_bit(CXL_DEV_CAP_MEMDEV, missing))
+		dev_err(&pdev->dev,
+			"Memory Device Status capability not found\n");
+
+	return -1;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_check_caps, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0fd6646c1a2e..7adf2cff43b6 100644
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
index be0ae9aca84a..e409ea06af0b 100644
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
@@ -11,6 +12,9 @@
 
 #include "core.h"
 
+#define cxl_cap_set_bit(bit, caps) \
+	do { if ((caps)) set_bit((bit), (caps)); } while (0)
+
 /**
  * DOC: cxl registers
  *
@@ -30,6 +34,7 @@
  * @dev: Host device of the @base mapping
  * @base: Mapping containing the HDM Decoder Capability Header
  * @map: Map object describing the register block information found
+ * @caps: capabilities to be set when discovered
  *
  * See CXL 2.0 8.2.4 Component Register Layout and Definition
  * See CXL 2.0 8.2.5.5 CXL Device Register Interface
@@ -37,7 +42,8 @@
  * Probe for component register information and return it in map object.
  */
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map)
+			      struct cxl_component_reg_map *map,
+			      unsigned long *caps)
 {
 	int cap, cap_count;
 	u32 cap_array;
@@ -85,6 +91,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
 			rmap = &map->hdm_decoder;
+			cxl_cap_set_bit(CXL_DEV_CAP_HDM, caps);
 			break;
 		}
 		case CXL_CM_CAP_CAP_ID_RAS:
@@ -92,6 +99,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 				offset);
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
+			cxl_cap_set_bit(CXL_DEV_CAP_RAS, caps);
 			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
@@ -114,11 +122,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, "CXL");
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
@@ -147,10 +156,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
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
@@ -158,6 +169,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
 			rmap = &map->memdev;
+			cxl_cap_set_bit(CXL_DEV_CAP_MEMDEV, caps);
 			break;
 		default:
 			if (cap_id >= 0x8000)
@@ -434,7 +446,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
 	map->base = NULL;
 }
 
-static int cxl_probe_regs(struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
@@ -444,21 +456,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
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
@@ -468,7 +471,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	return 0;
 }
 
-int cxl_setup_regs(struct cxl_register_map *map)
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	int rc;
 
@@ -476,7 +479,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
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
index 0996e228b26a..7d94e81b2e3b 100644
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
@@ -895,6 +909,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
index a8ffcc5c2b32..afad8a86c2bc 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -26,6 +26,26 @@ enum cxl_devtype {
 
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
@@ -207,4 +227,8 @@ struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
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


