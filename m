Return-Path: <netdev+bounces-136665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6236C9A29BE
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7DA1C22278
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43571E0DF8;
	Thu, 17 Oct 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SzRPbhel"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D0B1E1317;
	Thu, 17 Oct 2024 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184008; cv=fail; b=EriB5onZ3s8JBabnxsTVa5uTV/ZWpjklpiMVVhmupo/hWE/ROPeaxYmh/zZGVUwxWwikUIVruKyqi9r5cHhWmvXOb752P6Q4ehKt6+eCQbEUrQ3lVx4JlA3unf/tcIid7xLYGTs0FYscjlkw30g68XlLYlUuK2ZKW6jYMmS46y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184008; c=relaxed/simple;
	bh=7ml1znhRgWXjj9iwaD1vA9IOjwrFIB2nNTyr6CskMhM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4OgFtPkIxB1dxBSrPWXFF8iIDoelon3GXhBr0DWgekgy1s7cc5MHDOVEbaRmcFWq2v0YVrcYN3GrsNN2Akgof9XTpGNMVTVZs/qW6nmJKZzvaBTkLFdSjYmwP2xyekZuDAFPQFF+B9a6jEt0UGnr1BAz2tjNowdndGbI2Nyfkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SzRPbhel; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgsxVLfl66YujyoKADsxTKGpDeLi1DZG91us3IeLJrAW2CXUL/vblqLL415j1vGtRFuhTnyGWp7PrnpX2eyvQj4FN91+bZjTGJd023ONiUOqdpm7EtnT/N9TdbR+I+pvDFmzw45/OzXfn2MBdLJDeYFqmGU7dAZ6EwpegMv3hJZc5w94CkSoDXH4mJDmy931iWBmUI86lUA+BrNGsu3JHxMSyjThRzXPdPk5QCrbOu76FCZuGJMqLO+38aAn9XrBjda4Xy+G0r2w5X9gTfnPg+/P+SfVMy8B0PjNbDqV0gbDKP1yaENasa3Pw/egxp+JpFSQmxGqqqJWvAfc76uzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfWDMQR8JLxM+JaXy5/3W28XJKfjGRzlGf6w/z9YP24=;
 b=OKyLeRolhWtMqjIJJ94Rp7cDiyioZiYe8HpiR4XdMZVubPR79nYPqLk49wM4c5K4PB4zwYn1FhJFjtuKBx4vwhbrbkm4qptqMxx8oFESPp+BSr7iNGtamZzcoiBQQjGrkJQVapZdav57GBLF7kV9WVBG96uebo4Tf9oQl84bH0YJJm2/zaWyotvMjsgoAwKjFsKulykOhzqSfqbq1zmOVG5Yslf1xdqDGAvOz7SWXG/GlljjdiYK5BDYFJdirb26Jsk22+DozM+HwcG6B9c2q/kv8BDCaA+VeHR3qVx/Rb54nee66dgLkDOjN4VchYdoCoBeaeiYFivYvDHsV9Yneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfWDMQR8JLxM+JaXy5/3W28XJKfjGRzlGf6w/z9YP24=;
 b=SzRPbhelPfEyLWIO/fFbvL/n7nmoePVR4+0AiFCIykj4ruGNlJwUjUOxe87j59eocm4nTFwIhYbs49BgsfZywwKuA2Avf21HspLIoe9jWIpBK+kCqOIQLmvrQQM6Hu4J3H2k1Z9kkT6crfb3OegBGmYxIMXXTnyepz1Flu2RCh0=
Received: from BN0PR04CA0166.namprd04.prod.outlook.com (2603:10b6:408:eb::21)
 by DM4PR12MB6615.namprd12.prod.outlook.com (2603:10b6:8:8d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Thu, 17 Oct 2024 16:53:18 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::50) by BN0PR04CA0166.outlook.office365.com
 (2603:10b6:408:eb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:17 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:16 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 04/26] cxl/pci: add check for validating capabilities
Date: Thu, 17 Oct 2024 17:52:03 +0100
Message-ID: <20241017165225.21206-5-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DM4PR12MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: e79ac55a-7bfb-495f-046e-08dceecc338a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n3wKSLLIvP8MQ4KSSj4LsSq64VPPIobjPyBr5iLBG1iMzmQYPY8sHBnYoMOD?=
 =?us-ascii?Q?wNbGICHGHGC69X0vEGildZhA+fsVsdEo3u2dwVEUkFdjSIT8R/O0s+t7bCoc?=
 =?us-ascii?Q?l+6lyHeVJNLk78gjWlCEBJ7t7irp4HVQb3M3LOJuVuFt2XuO68ccLbviLZ5w?=
 =?us-ascii?Q?pDr4A12YWCJZlVFTbnrlDR25bnw7joCwxiYfk4HWDiEqq/sqmQ1h6WEqVz2L?=
 =?us-ascii?Q?l/UbzH6ChitAfPa62rT3NoJRCtxUZNoZH+uhKrVDmxPGJByGlFIvIHuqZd11?=
 =?us-ascii?Q?063XrFcF0APVgrbxtjHSwWze8Dm2UtYJiH+s42LmtcXDl7xLTCWMqLM6xVc3?=
 =?us-ascii?Q?+LMGd9RrB42J+9Wv5fiZFrPuSaHG92+q0xvWUV7/sdofSInangLFFT4NgdBu?=
 =?us-ascii?Q?dtcI7JvfZyPSo6Z2T8+TkJiPhJzIK8RshpbKJxgZDLNrcThcpQajywyHz0qo?=
 =?us-ascii?Q?edcO9kKY5a6FETzxYCNSihxUMFJ1j4cXYfa9NCBtS33kwoN0pqYmiqsBVeNb?=
 =?us-ascii?Q?31hbT0GvXvVz6kW0QeueZUENtvKaQZA8W3PqJ5QpobB5mY994Tp46JeGcm1G?=
 =?us-ascii?Q?PMXa61XG6PVz+MyA+eoYLd8mT+bsFOz8H7MaNj5wkZtenM2Gtix7bFeickvO?=
 =?us-ascii?Q?NDDo2Wdrr5sFPPagSEFO7yMQhnPk9zeEHvcsEb6upaGriAtGSisJ1AN3EI9K?=
 =?us-ascii?Q?W2oXCwa3PB2AtZp0uBKuK1HW0VkPsMpDJdZtIqOKgDOrvPf/Bn4VkXpfEa1b?=
 =?us-ascii?Q?ENA7g8T8iW+PMZt6sF99NSwp2zD9yxvhKGK3+rHGx5hE0cH4XibwBlpx7yye?=
 =?us-ascii?Q?fW+l/eLTSHtUXEyN1Qb0hCGfZDMGw/Nx3sKbnGJUvQBucLeBECsZbGN3IA0S?=
 =?us-ascii?Q?MrQfuQc5IZAJl08rcPQDhneOy43QqlKs2h4hEQBIZoymvxjUD4vQMkfLR35X?=
 =?us-ascii?Q?wf4eIH40eTStGxJXtdGlhBw3lvNwjEppRfJPzFs47NLbqQCbgalm8F4GI9z8?=
 =?us-ascii?Q?SlzqP774b9NaoANzAC67chziiNs91tufiAZ1F/IJncU5B7vkfQrC1vgkzT7G?=
 =?us-ascii?Q?crVMSmJ835LsLHpMSv8FpyaXMOUIP1NrDfQLcijcrJIwykXCmLh9lxq8vDMP?=
 =?us-ascii?Q?grhqFpa412yOmdAGr7xoKHd+pEN74evob0Kxe5te8PnfWzCT9GNfdJkYk6yX?=
 =?us-ascii?Q?cqS0/vwXAYUA5j2s8k+pNhJUNzxsgr+kOtzGPB14QxAlLYdLciFqh39Bnhjp?=
 =?us-ascii?Q?emWs1sEHryL5eax81JwlmBqAnd6cN5wS34+HfJH/UGAcr4rXfdhMBCnw6SgP?=
 =?us-ascii?Q?JCHUka3dd1FffeQEn2LEYbaQWVaA3mztnUolVczQOFYLKHxnbww0gahU9c6H?=
 =?us-ascii?Q?dqXTzz7E5NuzNcl2tybSWIFYjnsa5vR12WWxHj1t0AW7yodGxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:18.4565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e79ac55a-7bfb-495f-046e-08dceecc338a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6615

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
 drivers/cxl/core/pci.c  | 14 ++++++++++++++
 drivers/cxl/core/regs.c |  9 ---------
 drivers/cxl/pci.c       | 17 +++++++++++++++++
 include/linux/cxl/cxl.h |  3 +++
 4 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3d6564dbda57..fa2a5e216dc3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -8,6 +8,7 @@
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
 #include <linux/cxl/pci.h>
+#include <linux/cxl/cxl.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -1077,3 +1078,16 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 				     __cxl_endpoint_decoder_reset_detected);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
+
+bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
+			unsigned long *current_caps)
+{
+	if (current_caps)
+		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
+
+	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08lx vs expected caps 0x%08lx\n",
+		*cxlds->capabilities, *expected_caps);
+
+	return bitmap_equal(cxlds->capabilities, expected_caps, CXL_MAX_CAPS);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 9d63a2adfd42..6fbc5c57149e 100644
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
index 6cd7ab117f80..89c8ac1a61fd 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -792,6 +792,8 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct cxl_memdev_state *mds;
 	struct cxl_dev_state *cxlds;
 	struct cxl_register_map map;
@@ -853,6 +855,21 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	bitmap_clear(expected, 0, BITS_PER_TYPE(unsigned long));
+
+	/* These are the mandatory capabilities for a Type3 device */
+	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
+	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
+	bitmap_set(expected, CXL_DEV_CAP_MAILBOX_PRIMARY, 1);
+	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
+
+	if (!cxl_pci_check_caps(cxlds, expected, found)) {
+		dev_err(&pdev->dev,
+			"Expected capabilities not matching with found capabilities: (%08lx - %08lx)\n",
+			*expected, *found);
+		return -ENXIO;
+	}
+
 	rc = cxl_await_media_ready(cxlds);
 	if (rc == 0)
 		cxlds->media_ready = true;
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 4a4f75a86018..78653fa4daa0 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -49,4 +49,7 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
 void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
 int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 		     enum cxl_resource);
+bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
+			unsigned long *expected_caps,
+			unsigned long *current_caps);
 #endif
-- 
2.17.1


