Return-Path: <netdev+bounces-126214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F072F9700CE
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDA31F22C0F
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2221547E4;
	Sat,  7 Sep 2024 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rkuG7rs9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0E11537CB;
	Sat,  7 Sep 2024 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697176; cv=fail; b=Bs7IbEfyNDg8crNhlheqETIgjRfeHrWK3nJGzQfQgjHdv4LchYKrwPVRgz0XtzcMnwNkn/PJ8hc4WMsMgNZ8oIUZVD8TmF2adPR3QK0bn06ezebani2q9yHO1L1Y8TOMLbvOAezTO7vV5BXLAiM3f1eEGrRQ1j7f93+LdN5uX30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697176; c=relaxed/simple;
	bh=VGF91VQY93JxXvSVsOW5atcR5uKSCIkDV+ZsueoQERc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXcJuOvRJZTPYI2dyDfwOOjID9SmSA6ZYtjWMHeY3W9Db3/XMy+W4xlzwmusfgeIpfDUALNzQDacFwgLakrYW2QaA36J0sW6msWPjSq9e+K4bKYtslDyG9yIgOjrBpglJachw3J23vHS09TBrHdpAacRCnf4n4U+8eD3RdlTeOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rkuG7rs9; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/IeyWspm2wn7xu12ZkEN1nwfZ/TGpYtTAlImK5c1hk5s0rauxDrhv53cL+snlEj2+Zw0GqpDZa98Eag/QLHHwlOQlvIGHOydjGFyyim3ieDNfMldW1IKi35DMR/oZyWsGjNiPQCxEWM8sXlz0HMnaKN3BYh6l3V6SLZlc/5h8aBFWUqeZEKmDO/x04gRgs5aPMD5WNzsFaiO5zIrKalmfVVCmRqTlIXudGNwf99Uwt4A3zq/LlVAOZWSFPFHjK/H6pcAj1pAaZMuiHJ3+FZ9NvJ5n5qyqypM9bq0TtCchflX9lXpXai37g43wbjTHWM/qoWV68aIey6IF8PAwo2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiPHZnn/JvdYqd28Qu0Rxr3PspmDvs/sQvyl/CdeqFk=;
 b=Gs2b1JxGGxSRtmz0LJFidgz6cuC2qvD2vQnUnYMvnFmjPsXHi58kSPP1OGu6Z2kJncr4uU4VehWLn2bGzygpnUMBwA12eswlj5l7l3K+dfmIsZnMF4PFHEMzI/AxactKpZXJApA1JbdHz4eKh4md2xqQ15BIbQ8VsyWQR9hWxVo7aPyaQ0K12NmTtEgCKGaMCgovo+lINeVjWXkK1ZqoVsYv+sAdnaFznHoyUtsGAIFXeteiRjTTAy7Gpuvs3EQXvhe7VKNd9w30xVGp2WbUGWYuFaUklIfqsHkVYWoknbscBonEPd0rAsa5qLGYoc1qqIMRAEAX+kaNt20P/T9WKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiPHZnn/JvdYqd28Qu0Rxr3PspmDvs/sQvyl/CdeqFk=;
 b=rkuG7rs9Fx4CP6dLfIev8v4FEFXgV29t4WOXGzmplNKKPTycgPOenHiwtaNGi2IZXaDzMa39tKagQ55vn7xxIq7u+Q7CcGBQyRDjeLYjC0pcaY/8ddzF6/u5onJkZVAqW7UOCpUJfankJUNnrFRRoOWwcZqbcpSGAYfKqsEeOx4=
Received: from SJ0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:a03:39c::17)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sat, 7 Sep
 2024 08:19:29 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::47) by SJ0PR03CA0342.outlook.office365.com
 (2603:10b6:a03:39c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:27 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:26 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 05/20] cxl: add function for type2 cxl regs setup
Date: Sat, 7 Sep 2024 09:18:21 +0100
Message-ID: <20240907081836.5801-6-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: ae98a0fb-2cb8-4ebf-5c29-08dccf15cb08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x9cu+eEwwpxD023VgpcfeTNHDwUDejGrbZTAWV3MBhipIXXScL15Qds+lnws?=
 =?us-ascii?Q?lAvlh06E/n/1EIu9cXtPZyuWvksn5QWT7BOtT1pQ1Wv0ON41Rb6KG5nwO6qh?=
 =?us-ascii?Q?PqAaKL3GY1KvUE5E9Vshd8BjqWwwgRwtqKdCSJeN/JM2LyVj3btIAGr7MT5W?=
 =?us-ascii?Q?OIGzfEB5Suus3hWfkyI4kKQBd1fc/SYTKGCwN8hlljZ33/KY/hdTuZZrYbjl?=
 =?us-ascii?Q?9gQswGkJTPoPjIMOdhYgLuJGEXeLibAXLZQfSDScMVwVtQP9XzmKn2apZms7?=
 =?us-ascii?Q?5vE2UxSu00p8Ro2AZ9gABzAwAP5gBjf9SKV5xkN16cI3WDeIoVHXJY9Vrsui?=
 =?us-ascii?Q?8x7DgmnmcPhQ3ioH9WdxaHcVtw5/opPy5WaPIE8PBr+uuPypzsjYV5JGpcZx?=
 =?us-ascii?Q?IaPB0ffBWFXfF8SuPv1Z9ZaR7iOgU3C+oEa4ZChrPwwch5vq1vd7Ab5jpp1/?=
 =?us-ascii?Q?QsWhQx8HCHMKTaiby5muiOkYtYDpPJ8EmUQyWMKFNn0uJ3aOGsl935qf8WL0?=
 =?us-ascii?Q?WKrZQy94MValS1mxshkap9TKUyWbh9wU+qNRM+pBzn3q10Kuj9pXo0PwhOZ0?=
 =?us-ascii?Q?qTafwK2n7XYWdhCgj2I+EDGNCztHWnl4Ry4unbwd0cbR+h3tcMtUN85FJN54?=
 =?us-ascii?Q?nJ2wD3Ez+Y8Ys1TuuucT+bF//9Q48yCBvY2qOwAf0+mjrkU12wnlf34qHFdl?=
 =?us-ascii?Q?8NV9nvv0dOZlJolCuIr4PWGxuUMndcGgjYVQpAejH1bLUbEPu9iuHyIdzJn0?=
 =?us-ascii?Q?5P4h3kKcH9f4mfOqQLiDXwrdxVUf+KCuJUP057s86DeF9kG6cWG2C97RNH/9?=
 =?us-ascii?Q?tZtgOBhIu9oFFAh7MZ+uYSI354M6DyUJkyZoPT8fkc+aibQmtS59J5JfJQxK?=
 =?us-ascii?Q?BwXpuCHcb2v+IQyqfb2Bi2fYbmefNG0mFtzVrkRNv3PQylGJUD8S0JBqQyPQ?=
 =?us-ascii?Q?k1yGtCZFMQsiTkERj476eXBYP2qZaIpVHFabZLqtUcjALiJYgzfLtodiWDEO?=
 =?us-ascii?Q?JA0r7xm/oFyoe1+EqPlGVH9Q3RjspSRAYoyiINtylYHNw/NVmFX9bDdMDnqw?=
 =?us-ascii?Q?pFWBc4+4i0tyLF5K3nq5Y9rB2oFiCrKdoVhUJZqHZXp5gs4WRs+ODiaKhiOp?=
 =?us-ascii?Q?dxAyk6Kjl05/taSzDjO2NR1d1gE5NVHEKaaHVT9S8OdwGykr63HA89/GGPzj?=
 =?us-ascii?Q?Ui5R2x3BhlW4p4hWLYj7BNfyJaTHuOxF0rNZLazKyM2Ctc0WXb1UXhBUgiVX?=
 =?us-ascii?Q?RGuHmj1Teb8xFDHSS+/dBpziaV6ewWbtWJFgvd+IFtXaPqM3BBHj8WDDQeAe?=
 =?us-ascii?Q?/gaTuUKL7lsUQKHU2/7NDHGk5YgqL7EO5aTIzi0JtaqHitkZgV/RDujfFPZo?=
 =?us-ascii?Q?bTZGSdRJgG38RSXVLLQ5OGNQZ0lVPxXIwcKpcrqHYAa1/TFh3HhoCNscFP0+?=
 =?us-ascii?Q?5t+qcG5WsPWpXjH6Eo6Y9+5A2HgsCmL+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:28.5790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae98a0fb-2cb8-4ebf-5c29-08dccf15cb08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c             | 30 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.c |  6 ++++++
 include/linux/cxl/cxl.h            |  2 ++
 3 files changed, 38 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index bf57f081ef8f..9afcdd643866 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1142,6 +1142,36 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
 
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
+{
+	struct cxl_register_map map;
+	int rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
+				&cxlds->capabilities);
+	if (!rc) {
+		rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+		if (rc)
+			return rc;
+	}
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map, &cxlds->capabilities);
+	if (rc)
+		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
+
+	if (cxlds->capabilities & BIT(CXL_CM_CAP_CAP_ID_RAS)) {
+		rc = cxl_map_component_regs(&cxlds->reg_map,
+					    &cxlds->regs.component,
+					    BIT(CXL_CM_CAP_CAP_ID_RAS));
+		if (rc)
+			dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
+
 bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
 			u32 *current_caps)
 {
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index bba36cbbab22..fee143e94c1f 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -66,6 +66,12 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err;
 	}
 
+	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
+	if (rc) {
+		pci_err(pci_dev, "CXL accel setup regs failed");
+		goto err;
+	}
+
 	return 0;
 err:
 	kfree(cxl->cxlds);
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 4a57bf60403d..f2dcba6cdc22 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -5,6 +5,7 @@
 #define __CXL_H
 
 #include <linux/device.h>
+#include <linux/pci.h>
 
 enum cxl_resource {
 	CXL_ACCEL_RES_DPA,
@@ -50,4 +51,5 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 		     enum cxl_resource);
 bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
 			u32 *current_caps);
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


