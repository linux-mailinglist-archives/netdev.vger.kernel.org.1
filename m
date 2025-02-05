Return-Path: <netdev+bounces-163038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14E3A29490
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E70A3B2BB7
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A2D1885BE;
	Wed,  5 Feb 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nD6w2Ye4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F223216EB42;
	Wed,  5 Feb 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768808; cv=fail; b=XG80H70/7yc9Ub0fNcQN5muEIBWyXKETzHcQfHOh2jL6l9nJ7RqL3JZpuyFIS03WArtwoLu7226z4XonQCiasaxnikztNmeua7Pqnb5tow31PhOkqgDyPSII7lamkpD2300d0L8Eejvw5frF9Jf/149xG1pjMZHleiWTsXCtEdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768808; c=relaxed/simple;
	bh=uEQG7eyiEnWK+2P1Kn2wBiKXh6ROB6SnOAJkGryBrM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guRYIg9lJLhcuUG77Wcn06hQZzv9DAeLHa9L+SiFCAfZYIRsMFXfRV893sPx0XWjg1GzvmU9G0JUpw3ZsAlohw+EOSwHQFjPVtirQGsCjA0/lKcVDmrLyq+2CACftC+zIKYENCgmU5BQb0++s251MrNpt66xpTO2GsevKfCOTSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nD6w2Ye4; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsJsZxJTaDggUMAEIdr66V+AhlfNZwbAM4GZSNyWT7cDdt3PzMpkevfmUl382RHOsiWZpGabEzkV3evxu5KoYZMKNLGPpOi+ao82f6j5uuYfExY9XJQuf4RSMl4GLLJOp9o504OiLZ3YAEb7bxp5AbmpRcRYgblGnZyBZMHzQuxhSfoRWVSPE8NoFZllWm56rkvgb7ziplP+e2fkefhQvPAfjq20299CLscwy0HuUpownbKG5GW4RKDnneaWLlVTU0SqzzLQVIpNdLg4ZBCOyd34xcPLgJyETPi8k+jrJESq1a+z+IR0/QbTiJH1nyx5W+V9gFcdemHQDlXyocf1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is+OftmeNehlUYnmb8nJo5C56TAKmkfhBleXT9Oc8qU=;
 b=vzeMkK3S31djspmLx5HrxNYwmz8F50iGGeCuCQLlZECEsTxjUwzjjk6criTzYss6YG9BNqsZVF+sU9glaKXW0tMOqAFFtsS+VstgL/00CWnwoCY61sw775LoH0BF+WAUjSN/KJUEWG50At+HuQgqNbREDPexBKhosFCy0o3UR98u9Rk3m6IetHhMxR8slE5/XYR4OCX+3wOiGbURemG8Uz9Aq1YgpYuRdeznOU2vvibRVF0dKzOHGLb5RYPppzA+3rNh9C5CH41Rso3ee+a3TkaRnfQWhOUeLTckOs1sPmvEOxpO9nEE+4nYLOiYftOri6Zm6OmOS11XVlGRp2dfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is+OftmeNehlUYnmb8nJo5C56TAKmkfhBleXT9Oc8qU=;
 b=nD6w2Ye4v/9TapQqBPara1qKtGJG8lmQn7x81yHoaArOBtQ0Ci4pBaIYyZOmI85mIXEJrq3RlUeXZY2N6BkrLs52czOL8U3FeiaUJhKYBHys8yotBgdnpCt9qc3m4lVHsM/i2n34xjdzoAEPn22VdPtONITSoGZv8S4BXYTSWv4=
Received: from DM5PR07CA0110.namprd07.prod.outlook.com (2603:10b6:4:ae::39) by
 DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Wed, 5 Feb 2025 15:20:03 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::77) by DM5PR07CA0110.outlook.office365.com
 (2603:10b6:4:ae::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Wed,
 5 Feb 2025 15:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:02 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:02 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:01 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 03/26] cxl: move pci generic code
Date: Wed, 5 Feb 2025 15:19:27 +0000
Message-ID: <20250205151950.25268-4-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: d14b1d66-8dd5-4f69-a9c1-08dd45f89082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KwkpojzqrgSut4avc1AU5mIz0rVkzfz8ZvSXn+fu9bpYi2wuFgC/1C3golHn?=
 =?us-ascii?Q?otNciQI0XP+zsjWrJ02fjhw/90mr7fI5BsfnvGR9yWrVFpDPaf3/WufZ3Tc+?=
 =?us-ascii?Q?9mKMf5jrUwZkfcszXBf9hTvWWS5j8sstlBj7b5R5aqpwjQslr+OwORA2LYQx?=
 =?us-ascii?Q?VQK8BybtjY2Yh4P1IWf1EnQBsOuhiZPHF+GGTE5JaTe5myYuaig3q3eATeKA?=
 =?us-ascii?Q?hbIFM0474yl2rCKRFQbN5D+S/acYYsoE3CTKJdDCdj85dJmCeJJlXqHJUs8t?=
 =?us-ascii?Q?jX0tjI/v5NuaQkQA5rBgFqLRMCYgJSskevcTMH3AqA4yDqPwt9zH/DbVsGYL?=
 =?us-ascii?Q?5kHaFuX8C9xxfQNUEqYejDvQwwdY+VNRznUGMPcZss4jPWd5FicNEdEFfnWF?=
 =?us-ascii?Q?1NhWmEJCd/Tpr02y3cxlpcllAHQftInIcrcfTIYwFgCK+IbRpDiDjF+tr3kn?=
 =?us-ascii?Q?/SptJ4GLiBQT7uss7lL+HNrEfegQaj+vE/rQOzd7fjsakkbSI4mJ2QnfEDMD?=
 =?us-ascii?Q?MpqEy9DN6rdHR1KS8aBrNTOiloz4u0gD2QihKHNPGaJMgbz7ocleLTPNbbcB?=
 =?us-ascii?Q?O8QhEXMgwVkD/REzy8EmPfzNtQgx78nm/hY/CMghuC1zGmDFtLQiHZqX6QEx?=
 =?us-ascii?Q?+a33IyT05bZr14W4IwmDsN/0rvoG8WkCPY6QQkkTDE/X7fQNX0yhYwYOgNSo?=
 =?us-ascii?Q?8ZvD3gV59Y/WU6DsbS353/Siy7xgI0iJGwLVWLQBQVOUNxsOFt5KIZD+pApg?=
 =?us-ascii?Q?MZHusAhJerlATQd3LS0MlclPcg+CoBYLyal0fDdvq+No/4OS+5KoX7OFWOP7?=
 =?us-ascii?Q?4K1GGrs4cAJhjgjAfg5dLnLAqDGGMbCNdnpKb5dhAmGL8pUgbgbU0cr3I5RN?=
 =?us-ascii?Q?Wp1+Lver0LqHNTw+43iaYKxtSIPT/wqaQPukjETggCPp46ySQ9RA15MAmSpg?=
 =?us-ascii?Q?W5xCWdXZUzjKnnFkOkPCTXefk/kO9fJ39BNWhHVz2XP0UBABxbLlv7cyP3w1?=
 =?us-ascii?Q?ZU67udTWYPamIJsaLSQc3OYhHbaCFCTr3NTyQqr/+ORsqrkz6v6MQZl3Xeba?=
 =?us-ascii?Q?Ktrew+47pWNp+/lNYquPssRTVFcWoZbED70gKWQ8PlgMt2trFXxRB1hGO7GD?=
 =?us-ascii?Q?BF50PIPBec6rs7y7t3xJAhnH8LIHEazHbTUhn74FcTkoEAudcd8YJMar6+ks?=
 =?us-ascii?Q?7uTOFgBYu3WV7JeuxfDFRS6NpR64roe62O+oVwP1N87uiT6uJDZ4cFY9BSxP?=
 =?us-ascii?Q?vOThP3R/K1V7feem7c6sbSI5C8Y6NwySqEN5QKnNpSwyZpkSj62uqCuy8KMJ?=
 =?us-ascii?Q?a3n8zCYRLDPxj45YCMPmKrfuxcmMESMathfKV66Sx44P0F015fJWbtjeCTvi?=
 =?us-ascii?Q?E1PwdgVK5alqdSdqspLxGziGersdOIpC9yKN8at0V/HFzKg8HR0sdQ9Ci0yk?=
 =?us-ascii?Q?cHar2jTHjpfO3p+K/vs5u6dtLcKytm2VtIax7fzy15vldpmT09+Lb/6rC6ca?=
 =?us-ascii?Q?JIHQL63kHhJ51WU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:03.4072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d14b1d66-8dd5-4f69-a9c1-08dd45f89082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci.c implements the functionality for a Type3 device
initialization.

Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
exported and shared with CXL Type2 device initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h       |  2 +
 drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c       |  1 -
 drivers/cxl/cxl.h             |  2 -
 drivers/cxl/cxlpci.h          |  2 +
 drivers/cxl/pci.c             | 70 -----------------------------------
 include/cxl/pci.h             | 17 ++++++++-
 tools/testing/cxl/Kbuild      |  1 -
 tools/testing/cxl/test/mock.c | 17 ---------
 9 files changed, 81 insertions(+), 93 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 02971e0115c5..9bcc7aa7d434 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -107,6 +107,8 @@ enum cxl_poison_trace_type {
 	CXL_POISON_TRACE_CLEAR,
 };
 
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a5c65f79db18..f153ccd87dab 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1032,6 +1032,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
 
+static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
+				  struct cxl_register_map *map,
+				  struct cxl_dport *dport)
+{
+	resource_size_t component_reg_phys;
+
+	*map = (struct cxl_register_map) {
+		.host = &pdev->dev,
+		.resource = CXL_RESOURCE_NONE,
+	};
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return -EPROBE_DEFER;
+
+	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return -ENXIO;
+
+	map->resource = component_reg_phys;
+	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
+	return 0;
+}
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+			      struct cxl_register_map *map)
+{
+	int rc;
+
+	rc = cxl_find_regblock(pdev, type, map);
+
+	/*
+	 * If the Register Locator DVSEC does not exist, check if it
+	 * is an RCH and try to extract the Component Registers from
+	 * an RCRB.
+	 */
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) =
+			cxl_pci_find_port(pdev, &dport);
+		if (!port)
+			return -EPROBE_DEFER;
+
+		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
+		if (rc)
+			return rc;
+
+		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
+		if (rc)
+			return rc;
+
+	} else if (rc) {
+		return rc;
+	}
+
+	return cxl_setup_regs(map);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 117c2e94c761..7d025d38da07 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -645,4 +645,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6baec4ba9141..74bccf55c8dc 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -311,8 +311,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
-resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
-					   struct cxl_dport *dport);
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 9fcf5387e388..735668f8cca6 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -120,4 +120,6 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bd69dc07f387..39df0ff3af50 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -465,76 +465,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 	return 0;
 }
 
-/*
- * Assume that any RCIEP that emits the CXL memory expander class code
- * is an RCD
- */
-static bool is_cxl_restricted(struct pci_dev *pdev)
-{
-	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
-}
-
-static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
-				  struct cxl_register_map *map,
-				  struct cxl_dport *dport)
-{
-	resource_size_t component_reg_phys;
-
-	*map = (struct cxl_register_map) {
-		.host = &pdev->dev,
-		.resource = CXL_RESOURCE_NONE,
-	};
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return -EPROBE_DEFER;
-
-	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
-	if (component_reg_phys == CXL_RESOURCE_NONE)
-		return -ENXIO;
-
-	map->resource = component_reg_phys;
-	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
-	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
-
-	return 0;
-}
-
-static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			      struct cxl_register_map *map)
-{
-	int rc;
-
-	rc = cxl_find_regblock(pdev, type, map);
-
-	/*
-	 * If the Register Locator DVSEC does not exist, check if it
-	 * is an RCH and try to extract the Component Registers from
-	 * an RCRB.
-	 */
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
-		struct cxl_dport *dport;
-		struct cxl_port *port __free(put_cxl_port) =
-			cxl_pci_find_port(pdev, &dport);
-		if (!port)
-			return -EPROBE_DEFER;
-
-		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
-		if (rc)
-			return rc;
-
-		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
-		if (rc)
-			return rc;
-
-	} else if (rc) {
-		return rc;
-	}
-
-	return cxl_setup_regs(map);
-}
-
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index ad63560caa2c..e6178aa341b2 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -1,8 +1,21 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 
-#ifndef __CXL_ACCEL_PCI_H
-#define __CXL_ACCEL_PCI_H
+#ifndef __LINUX_CXL_PCI_H
+#define __LINUX_CXL_PCI_H
+
+#include <linux/pci.h>
+
+/*
+ * Assume that the caller has already validated that @pdev has CXL
+ * capabilities, any RCIEp with CXL capabilities is treated as a
+ * Restricted CXL Device (RCD) and finds upstream port and endpoint
+ * registers in a Root Complex Register Block (RCRB).
+ */
+static inline bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
 
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index b1256fee3567..e20d0e767574 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -12,7 +12,6 @@ ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=cxl_hdm_decode_init
 ldflags-y += --wrap=cxl_dvsec_rr_decode
 ldflags-y += --wrap=devm_cxl_add_rch_dport
-ldflags-y += --wrap=cxl_rcd_component_reg_phys
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
 ldflags-y += --wrap=cxl_dport_init_ras_reporting
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index af2594e4f35d..3c6a071fbbe3 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
 
-resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
-						  struct cxl_dport *dport)
-{
-	int index;
-	resource_size_t component_reg_phys;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops && ops->is_mock_port(dev))
-		component_reg_phys = CXL_RESOURCE_NONE;
-	else
-		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
-	put_cxl_mock_ops(index);
-
-	return component_reg_phys;
-}
-EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
-
 void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 {
 	int index;
-- 
2.17.1


