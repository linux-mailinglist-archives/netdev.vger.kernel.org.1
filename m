Return-Path: <netdev+bounces-136668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787AA9A29C3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089851F21CA5
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5981EBFEA;
	Thu, 17 Oct 2024 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ioY7Vunw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD71E0DDD;
	Thu, 17 Oct 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184011; cv=fail; b=sH6fvuERtVC/7bFUrWj5ihuFtqoentt2unWCrhYBR17JWaP1FrPhcpCiffrlzqtXVm5YW1OWKzTR6X22PM8d9moIyKKus8qwo85uf9MpmmT2155MANG9bSXx6rZzhFOxp4dWpaVHt5C1GPAA3wI1cFsjG00pc9/qX+rMq6n41dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184011; c=relaxed/simple;
	bh=6OlpLnttcrF7j37dtrBqQLHk98Es5Nts6eZaeLVS05Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOECruQZTePjXSFcBXNWvcWzRr6G10yN90ZQxqGVU8MxelqIYQeIDmwQOcQ+ocTdLFlNJRs3HJzjcVPJe6jwE9Y6ZX1inTfHO6fXwk5WCb0i88/xAqBUUY9v+N51yVbqCxk5lWP5hAAJZ/6VAF1Qn7FIW6v+UzUEASVDVhQsST4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ioY7Vunw; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z953D86KEK5XskH7YgW6Jn2G2TM8OYTmyXecoZqCga4UKdhuHpY6eMg1GDCQUo6D8Ed35rsOUCxBalGzDCbAPpr/m2jpCWgsV1sgvnxEAuJGUtP9Bb9uUWfccHOdJslTcGirUZusWXSW5Inwq5tlxeB9z/R9IGge5R6KkFKk4bB4lmknhbU3ajGCNJJocyOdogBcyHkNFXAaVXEz8k9xbeBwCo50lPhzv/QNIhz85D8isjDZ7f9Lc1dXY5SJPQc7GtCM5fyPqHh6J4t2b/oBeOeQfj48Z41SY+45Q0OjCmWnXMbjAEk/l8S0AyqqdxlrZLaaAiuR+JLkZHFqtwmP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oltp956Ct+SEFySljHfdJ4/G7ijETooxzrM3WcNNhx8=;
 b=TuDbVEC/PnveLbChb6U6snRYAkMSAC3JbPdnjHU81rl4jJf5Vl3flPMEVjmOTHK7h+HLFm2dw4FGNqWBNw20jfmMXvp1NbKxx2tjHIfsxoolM/Fdfg33Jp6nJkAOjyL3xMMsaFfL+XYG7cjtp08SfdOOMS0u43Qo5jdYf0Iy6win1qNW2REt0yhNH5nQc+l+PdyUjH22cGmjlg4h5KOdRHXg23c85BdTbvTwesinaGOvx1xmxx0VSJIsPUOXnUB+sPodLiWqN2TblDXj1VZcdXQlsFrUZlkDPzizfI9mMkQyKGNYIV/Cfhg4mC7JCf5LLF4lZRs/laVQ7/DsywpUdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oltp956Ct+SEFySljHfdJ4/G7ijETooxzrM3WcNNhx8=;
 b=ioY7VunwbWiE0pWgLLpUyY1PYpf4ZmKt6XDHtHsu1aGkur4f95VkqWyJtz9OJNBuoT+6E1HXZ3DWpgmL9RIyJhWVuGcD97P6X+ah/oD3zxWVyLYsPAuGrxvgex3Foua1aHHcTQ/aCb+rF8wbdZnfq9hOV2ZQDbVkkGPNslYCNis=
Received: from SN4PR0501CA0131.namprd05.prod.outlook.com
 (2603:10b6:803:42::48) by CH3PR12MB8877.namprd12.prod.outlook.com
 (2603:10b6:610:170::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 16:53:20 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::5) by SN4PR0501CA0131.outlook.office365.com
 (2603:10b6:803:42::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.22 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:19 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:17 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v4 05/26] cxl: move pci generic code
Date: Thu, 17 Oct 2024 17:52:04 +0100
Message-ID: <20241017165225.21206-6-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: d21cd61c-ad96-4e08-ac88-08dceecc3462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PZzZUTOHEXxvNQ0wY8VMuJHVeOjzYCa6BeRRQTl0zOqJOu9bKppxEGxmQEAH?=
 =?us-ascii?Q?z6xZ5gvwOzlb2CkAkyJiw4fp/NMe1jneXJtH6w4mUVo8qVfutTDkLxttqNgL?=
 =?us-ascii?Q?STz6t2m5XHcl3ULhbFd10OFfc6ChcV84OW9zRz53PYhPGq/HEEXGrsxNC41C?=
 =?us-ascii?Q?Zwm0lA3sGeebXYRE6dlQ+X9ej267eESOdKz30bnEiGsOHZQDl+N21jBFdZLP?=
 =?us-ascii?Q?trvwEphE7f/ziXZyk21xF4LeP8CiYRTX8HRQ1/MgRqOKVMlOxrBIrncDhz/Z?=
 =?us-ascii?Q?G65VX02+pcsmsXdtq+7cIB4PPBNPXxvvq/0MmSPsmiHn331Lf83Lzj2+AI7z?=
 =?us-ascii?Q?HEebLtRrcwWGM60hS8nv17zyIw7/zOQzzvvUytoNm39JBSiK7+HgOhZblKM8?=
 =?us-ascii?Q?YPQKgz6zYZuWhjCgAqH1+ylmyBF25jyOpC6XPGtllU9aolyhrE0+d+lqgMhe?=
 =?us-ascii?Q?IsqZJxAkiVABJBj22jURhBe7+8Ev1ncBxcxk4cTJNwjvnlH6KdUoME1issyz?=
 =?us-ascii?Q?Wt9r2h6tV6wYZ0PGFBOQS/WJ4PEhSU093v33uCdJaIFGGTj2w3zQlRXYtZvH?=
 =?us-ascii?Q?RWbwqFFjywKxyfZx1r6dFQB2CSJ0DIWDbx+I9/T+QGBNflpHznZVMTodo+mJ?=
 =?us-ascii?Q?dSnxwywLdV3MFzCdODkiOkYXLx5pU67CJQn84/R8QS9GE9jdGY3MevKccilk?=
 =?us-ascii?Q?7XF38A5kCOcu8zlWX4y6OP15bPJHTVshRm52E+jV8Xo+BCDBAT0H5bI5DrT0?=
 =?us-ascii?Q?1LIII1TV4psRpekABKUFMQw/IuhQjsZG4LfN+6/KfxStkq75ctkN9MIXz29Q?=
 =?us-ascii?Q?6W33dyTYo6Q5Cazisu/t/QzI4hGRcRODYGJXlMtr3sFY6pDWtFLCmpNbTEP3?=
 =?us-ascii?Q?7251DXw8IpjHZSLa42AN/C8uD36IP+fwhrXwyNO/AbdEhzlB3agrroh8xxfm?=
 =?us-ascii?Q?1JWFWEGIXe0lg2Cc8sOsUhHy0NdE+USsXco7VEtZBPTUEnGR3ixJYM6k0LnH?=
 =?us-ascii?Q?WjSkyVdO5spdTMBKUIK+yySJJnD8zEGIt6b0F9uIOpG+7tgaPuO66dkTXXGI?=
 =?us-ascii?Q?R1+C8ZcUG7HyH8X/lbZmU+byYe9OxcQuxPInik+73uu82UBTx38GH1f5gUs/?=
 =?us-ascii?Q?FxM/X4EZuX2IgbBlhIk1m4g5ay6cj8RQj8bBlY3wlRYvywwQfmWryIMN5Zgy?=
 =?us-ascii?Q?5J+Fo+uUtlS3aIMuLvhReagDUEonrrczvAc8QkKgocYlNHghcJZ5/S812NtN?=
 =?us-ascii?Q?0TF5cZIud6xCx/3+b9DW4MF7k8vqCB92I2LJcKaWUJE0IxNsPKn4IZsq1Pk5?=
 =?us-ascii?Q?SFyb2QFTjgvT2qTs4743I677k975foA0jPhchpJ/Fr7gV/bJ8TVSXIpm8E12?=
 =?us-ascii?Q?fWZv2eA33UvUi1bYA++oNXIdmpXINL0V5uvJ344Ou+PzQuxUFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:19.8607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d21cd61c-ad96-4e08-ac88-08dceecc3462
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci.c implements the functionality for a Type3 device
initialization.

Move helper functions from cxl/pci.c to cxl/pci/pci.c in order to be
exported and shared with CXL Type2 device initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h   |  3 ++
 drivers/cxl/pci.c      | 61 -----------------------------------------
 3 files changed, 65 insertions(+), 61 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index fa2a5e216dc3..99acc258722d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1079,6 +1079,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
 
+/*
+ * Assume that any RCIEP that emits the CXL memory expander class code
+ * is an RCD
+ */
+bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, CXL);
+
+static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
+				  struct cxl_register_map *map)
+{
+	struct cxl_port *port;
+	struct cxl_dport *dport;
+	resource_size_t component_reg_phys;
+
+	*map = (struct cxl_register_map) {
+		.host = &pdev->dev,
+		.resource = CXL_RESOURCE_NONE,
+	};
+
+	port = cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return -EPROBE_DEFER;
+
+	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
+
+	put_device(&port->dev);
+
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
+		       struct cxl_register_map *map, unsigned long *caps)
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
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
+		rc = cxl_rcrb_get_comp_regs(pdev, map);
+
+	if (rc)
+		return rc;
+
+	return cxl_setup_regs(map, caps);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
+
 bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
 			unsigned long *current_caps)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index eb59019fe5f3..985cca3c3350 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -113,4 +113,7 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+bool is_cxl_restricted(struct pci_dev *pdev);
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map, unsigned long *caps);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 89c8ac1a61fd..e9333211e18f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -463,67 +463,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
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
-				  struct cxl_register_map *map)
-{
-	struct cxl_port *port;
-	struct cxl_dport *dport;
-	resource_size_t component_reg_phys;
-
-	*map = (struct cxl_register_map) {
-		.host = &pdev->dev,
-		.resource = CXL_RESOURCE_NONE,
-	};
-
-	port = cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return -EPROBE_DEFER;
-
-	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
-
-	put_device(&port->dev);
-
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
-			      struct cxl_register_map *map,
-			      unsigned long *caps)
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
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
-		rc = cxl_rcrb_get_comp_regs(pdev, map);
-
-	if (rc)
-		return rc;
-
-	return cxl_setup_regs(map, caps);
-}
-
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-- 
2.17.1


