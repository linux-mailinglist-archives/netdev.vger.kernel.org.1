Return-Path: <netdev+bounces-111563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37A7931942
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799DA280F0D
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C05746522;
	Mon, 15 Jul 2024 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C9badfe4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5403482FF;
	Mon, 15 Jul 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064532; cv=fail; b=Rzi816VMm2rn9NqoTpg02+vP+OdpIA7ET7awVmyvvNEuUH8sgP26tWLZIiRKCFZQDPEw9t9GymM6hFp8Pm6fVCNM9AZUKjMqmVJHq+eLJB8tMzKql/T9C0pYSXb63oKHlYO+yIEHizLC66AOWyDWL04Yh+eQzCVO8QxjVMqex1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064532; c=relaxed/simple;
	bh=JiZD/sVW0oMAP22Ldy3xtseUJoplCp0JQCJVzAEJrpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+CG4QyIkucoeloeB0tS3afEbffofql5bsiQzYrmCZyAhbmWf942nrFbOMMl/Mhe8AJOBkonkRtiTil4KSDmiZeS6SRLK6Pn41R1Q7kqrFBuQuLo9zYGk3RCOHYUdocjjovwNPLbR/33vekFYkjrsksK0tQ2hQMtUb4e64KHttc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C9badfe4; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1s9u9NXJS+5Ju7309QqLCO6AprZlPdUPhCljezSV0drUbWoGfuEgwY2BQp4hKC5Btq+PTuTUXvLlRurjtFb9gVb+nJQfWZN+dweuQUpf96rGs4ssprWHovgN3dndIK0rTn4N0qwle+2vsiUgR2hEO1uJYQ3Sup8b4iCZgLUnkZbG1tFfktRmG2HiVUPfbn91jH4DX6OYOIbRNuo7fgSfJrqeDAggXLKmwzkxdG3fDmb76s5YNl2TazMBSO4zaHeAITCloAfY6FFucvLqRJo9plucQuP82OOpLUFq1TPDCtj4cRUs+GDONb3sPcJ1kpu8MT5KqW7n/s+wxUkpiAT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX2PANqmejnodiJ8QBVFxKSGeEKF7jqaqv/zITOH6i4=;
 b=NbQon9xZQki8yN1VehObGxbO//r7NPTpkcpPOXiccO9PRk64HQw/CckeBSgXGPKN7ih7Nx+8pKxcskPDi2mAPCSXYP1ctQf0wiv+vDkR5YTzlmpVY33gwyQlKeMluZXjZuhSk6b9wZWhrCgtwF1KuguQ9N3HoNpq/zP10ig5XlQDwJeSapDQNV0iOwmF5K/HWHmByWvWxj58wWu7yta9024QKR/aC29+oMtwgMXd0tjw6HHaFK2Z2vihnKxTFFts8UNSwpjPZe+t7Ai+6M8Jg314NfxwMJYJPAz8IpLX3XBnLxYGeqAmpIKzXrWIrekipfavJMQOWK+Yrsn8gTWcEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX2PANqmejnodiJ8QBVFxKSGeEKF7jqaqv/zITOH6i4=;
 b=C9badfe4fpoCD7En26d2icJhCjPwZopuP43Zf/W+LQ7t5any65XMbI7gxcS5/vU8lYB2JzLudp7TqlmpfCbGocIFLPXu4u9ueBkbwrhAePBLW6KTGrAVOIY6D6ele5G6LoxwyBFZu/Gff0VOtNHv7XbH8B8pq88xiShJp486A+8=
Received: from DM5PR07CA0085.namprd07.prod.outlook.com (2603:10b6:4:ae::14) by
 SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Mon, 15 Jul 2024 17:28:48 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::ac) by DM5PR07CA0085.outlook.office365.com
 (2603:10b6:4:ae::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 17:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 17:28:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:45 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:28:44 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 02/15] cxl: add function for type2 cxl regs setup
Date: Mon, 15 Jul 2024 18:28:22 +0100
Message-ID: <20240715172835.24757-3-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e8ae9f-2cb1-43b2-d1f6-08dca4f395bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?83hoWr5eG3agCsHUGtRgGFXzC2v58wvk8H/DTNdECfDWkdrn2Ic4bSCyWO5B?=
 =?us-ascii?Q?aCF3jKGSE2Ui7ouFhCdyAnk2zgAZW6UA1uMsl46mVM9Q12xgwKMvEHtx6SpO?=
 =?us-ascii?Q?DAsoctQ4pHUAv+Q1iLFZiR1RBD46ZmkIBHBF2gObjUmm2Kj55G76oTw238x6?=
 =?us-ascii?Q?VNaoNF8t5SRaDxmEJ3AOojD6whnaEIYYocg4P8V8krm8C4AYuUkgyIDAY1Jm?=
 =?us-ascii?Q?zIOTZmHvF8Y3AiqGH6OoyQHXTnKFOPKl5BYx9Q2FZfiLct7KL6Qy0bkm+juh?=
 =?us-ascii?Q?BZBQmqAesfk88L2w1xT98PA82TleiviQiD2gs4i49pByCIoYHBisvRgxAcxZ?=
 =?us-ascii?Q?/I0m3Pur9e1p7Mu842vb3xXsC8wnK46fphhpyxyBKUNhx+2T8TAE9YOZvxxB?=
 =?us-ascii?Q?goZ5hAc9/424xYRHZ6rAr4CBYkxV+f+4Etv+Es3so7036r5sfcXuWeFU/NB/?=
 =?us-ascii?Q?rGwU+g0lG2aspkbjS53hyxNh7vIFCH4yJllSJZsySkZME6GYxnhpyvQVqc8t?=
 =?us-ascii?Q?9rEjFKHhm9VEP/TpK6eWN/NA75uKTA61MJaVlX8TFReiInrAY57ih2SqQ/YH?=
 =?us-ascii?Q?LtIEf/8b1UkVXati0Go4MzuXGoR7407sWj53bYVBh1fba8IKr0dvSxDB/C2t?=
 =?us-ascii?Q?Do97mggaOjhZ96764FTvDrlfG5IzPylETFK60BPNBJSswvW5xQH6H6xVPTNC?=
 =?us-ascii?Q?6My3+tAwXPMj+1lYwKrQih39+MkPu26ftWYlDA7t85GYcX+K1vYq8ZHDzamR?=
 =?us-ascii?Q?6F1txQc6yIIcjiih4AXb7L0unX3kT8d1J7ZKcthNhW1ARwXJ7b0EtXQaIF4l?=
 =?us-ascii?Q?M7mf8sRiqNJBsmJrZU3g6HeYomN1IdCAJElM0Q1cFNP+k63UP9JrT+5RvOWD?=
 =?us-ascii?Q?YCX5PeWiIJbsc9dWmTmBY07aA+Hvp0ONyjO5cinqbjkiiPBFLP5cYgxCnMkH?=
 =?us-ascii?Q?GS0tQQ1qpZotQZvzURa8Kg1yj3oQqGxgKYyfZcx791nMLQDJhaYeFlmqy0Oo?=
 =?us-ascii?Q?86V34qTlw/KJvKJXAiQ8VjOxky9Tz7nobTGhEegdeWLuJZuMp1HUq3JIAMfb?=
 =?us-ascii?Q?GipyogJ7HrmxLb9Wj6roof7Nai/2htqV9qI1euQw44OmcmV/sWG/nOD0P58W?=
 =?us-ascii?Q?WFSQiVpwWzlE4TJiPYFCchtUph+YsZ5v9Yky9IH5LuFTuYvKQOiEiSDFdl0i?=
 =?us-ascii?Q?xmYgQ0+AV/+qoYcM/GuWbf6JOjkSjAbp/M0UW7wZqBTYZXxmLpaPAUW+aKWL?=
 =?us-ascii?Q?/n9Zb3jC375PD31mVpTipUzaEKKrjBylhjGFzIhtal+E0qto12qlBOz5G5nd?=
 =?us-ascii?Q?2Pzktr/ZLu/ObQ1Chvog6UkrPiz46kyQS553qmCMgXIEanl38eMjXZQgd+yd?=
 =?us-ascii?Q?YPzoaG4Sv/L+UK0Jfbd9kW98vrVOQURpXIsMtH3WRdadSwhlEioM8seFBYB+?=
 =?us-ascii?Q?5lsUUBXHDC1vg52+UhmOLKCbbQvzg6pxxQN4e5RQLmn34L/cRA2zhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:28:46.9483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e8ae9f-2cb1-43b2-d1f6-08dca4f395bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising the opaque
cxl_dev_state struct regarding cxl regs setup and mapping.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/pci.c                  | 28 ++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.c |  3 +++
 include/linux/cxl_accel_mem.h      |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index e53646e9f2fb..b34d6259faf4 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
+#include <linux/cxl_accel_mem.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
 #include "cxl.h"
@@ -521,6 +522,33 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return cxl_setup_regs(map);
 }
 
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
+{
+	struct cxl_register_map map;
+	int rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	if (rc)
+		return rc;
+
+	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map);
+	if (rc)
+		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
+
+	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc)
+		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
+
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 4554dd7cca76..10c4fb915278 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -47,6 +47,9 @@ void efx_cxl_init(struct efx_nic *efx)
 
 	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
 	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
+
+	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds))
+		pci_info(pci_dev, "CXL accel setup regs failed");
 }
 
 
diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
index daf46d41f59c..ca7af4a9cefc 100644
--- a/include/linux/cxl_accel_mem.h
+++ b/include/linux/cxl_accel_mem.h
@@ -19,4 +19,5 @@ void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
 void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
 void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 			    enum accel_resource);
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


