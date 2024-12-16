Return-Path: <netdev+bounces-152281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256C39F3579
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C3D188BFD4
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90394206294;
	Mon, 16 Dec 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ldr2RV1s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECC1509BF;
	Mon, 16 Dec 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365465; cv=fail; b=f+NUKzv4aEAj1XfDFIdW6Iv6xfCYGdMDcCdZraR8E73xAHC0qYZbfilLTB4XDPUwOXa3SszmJoQzpq2pT2FxfgVdwNsk/n9BBmUvSpMZhpVBiqMgURO09N7FhC6l0p6Fne0la3oWfOxwBvy6t/+Axp0686fHLuOiaDp/OwiVXB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365465; c=relaxed/simple;
	bh=G6nKLtxL+0TDd86S+P98N1cqvFqTjR3D/58dJ/SGS4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6rYfQqqQrpOI/XGVwvNQaUGuqTE/pvzF/NMBQT+rdFaAyDKg+qK3l2XDhuILeq8Sf6N5Op158nKdovWLBrXFCJD+tUTZ/759+V3svDU9PP/LaHZrag+Vmij1pMmGu0z0OiGS5q1hHijZj6OP1qWN3P3LSsdnxaLBaVkukDDE8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ldr2RV1s; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNycfPRDoHZYjGcfmcnA+RXXvJwx7Yfu1Rmu+9QwnMAX5mLCCh1HNJ76YFL8fr1IANBJgbVq7HenLumMsM6Gtoa36KWxMRBtgqdDN+NE3qINH5pdPu6VUQaRI2RthOSpGjxkJKzA2ju0YimD8QTyYu6nGnWyN+5qwG6CEBKfQF1y1RUeMd+8cbSfVGXZcWVCO0AWLjTLV1QJC0DVZvev9MMf0OLGS4EZBm9ELIv4wAD4VYuTL7/mNumTJFsVdsb/TnCc/vr3sP2EtOGNQXWsszWLmtoeROGT91YMMhu3lBLDQ4kKYrph5uB3DvTA0i5sfJIrL0p72EsOHviNDir1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S5mn+fhejuyGasj5r4dAx0Ys/bC0tm6HyFTrOzEndw=;
 b=PKohs015Bgb6kugnPq81SfBXKc51NvZBQLCiX9+kBJoUt548umJIOAqjLaxB+Q7k4CFGoaDn0tg+1Gy9hNz6GlAOCBXaNlJlZJPItGX7I6JkulSwPPT1nMh6A9F3zYvaDS9mROMY11wn9TiE090Ifi2JO8L5oN9Q7WM+1ZyF0dmnU08Vx4EmMOlRJKywBJyL2K5DfQZ7YYpQCaVE2xUmtRFgQttya9tgI0HTuyrO77ar/VGI5MAznwBQR7s1+E8hkZ9O9W87cXfdIKB7UAeY7G1qXfB9AEm52dlBKJbSHihJ8KuXsmGthC3BcLdxBP56zRk8GOTPXULjk3OvAAenYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S5mn+fhejuyGasj5r4dAx0Ys/bC0tm6HyFTrOzEndw=;
 b=Ldr2RV1sAO7/rr52AOfEOAeH4WmK6n5b1l39KiX0kCo3oRWct79CB0t7YvQ63zCy3IKLh6GzdF8P2UeWmuw/znQmV4JoERDOmDCQPvnDU9ri93K1xHn7fBygYKxLbofh/wccmwIYbS2e2ZIPN4qyvOOVEP+MIyjIWWt54sjQulM=
Received: from BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::10)
 by SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:00 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::13) by BY1P220CA0015.outlook.office365.com
 (2603:10b6:a03:5c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Mon,
 16 Dec 2024 16:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:10:59 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:10:59 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:10:57 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 05/27] cxl: move pci generic code
Date: Mon, 16 Dec 2024 16:10:20 +0000
Message-ID: <20241216161042.42108-6-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SA1PR12MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9310cd-b299-44e3-4cdc-08dd1dec3b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fGvRnlX/vUdvF6vt9ILclURXUbwj5NI+IQyEyRgCiEmxCwCeQjioq+ormDRy?=
 =?us-ascii?Q?dWxofc+2HTKa6IOZGiOTwaMXJuKDvzug/raNmKDvjfAmbz/jPYhMikh5fH7x?=
 =?us-ascii?Q?QIXg71w3QwB/toKiHXxUMwB5IRLR77s9iPJutxvisfJGJQ9jeOxsFBnRDrJs?=
 =?us-ascii?Q?5WsrvzNoJDJ0uScCwA0bvZXJwSS5TTErPvVUvxLoJuuIzgWuvzCtDmkP2CEe?=
 =?us-ascii?Q?Ljv25H82ey6j5cX+ScXKHOkHhuooOixH04J9wmQYPg6tEXrYjIh7u3jEiW2c?=
 =?us-ascii?Q?etgK0uRYSeSuC6XnU1pLhOa52LRW9ugAHznRr8fF1BOU72d22jqUIQk0beON?=
 =?us-ascii?Q?IGj9SFCTg8z2pCmWk42jX+RV+il+ICJjxMhazx3yuaIdErbRwmFZotks1Mae?=
 =?us-ascii?Q?8Q4TXYZBqOp8rQynLQXjXi4bNcYhDhxOwZ86ATadWAzL2aE4jkRp+2ah2WPl?=
 =?us-ascii?Q?wHXhZmSH6B51Itq8jUg+pZUjXPhksE4IK6H3xXwbgzfSKxegiXAxf6fe51Ao?=
 =?us-ascii?Q?OXg+QtplF2Jq4JM2DgJ3NKaPJOscl7GMhdz57h3QyzXPBJBBXWjFbNMcBXIY?=
 =?us-ascii?Q?tR2iZc6kD/p+NylnnSjmniWfr+y+Z8uENmcKVfNuJJeTc+v0FtjSXPLFLhQy?=
 =?us-ascii?Q?2Udo6T8BhDtGnYL8ErLrOq1A3ykOvWO0TaVK/2bC8H6M4MmeKdHrX0p0ewIt?=
 =?us-ascii?Q?tCS9P0vtHPnpp8wr5707ZOx1PFOAo/mXQUHxbiPF042/Ik1CykmX2l2jU39/?=
 =?us-ascii?Q?Jdr/LpYGUraMwbjm7oMTfp4yHOuO3s8l5dQbb4jXpHEvm/Bb9NiMCCier/AD?=
 =?us-ascii?Q?R+HP/dZ/hjytCtjgty6ZWhepoFs3BSonLxpHxAXc/Nn0WtOGxhumuq7hVWgF?=
 =?us-ascii?Q?nVRT0Xdjk6EXgL3Msr05NDt3uVP3NZaADMgs4SVWIvCVzA5oX4J9XSvz/tTH?=
 =?us-ascii?Q?eOyi2i50VqujlPwWR4QkWjdqOpvWfRoo2B0LJdDTUr+E5cZ/OnXcxfj+FH2s?=
 =?us-ascii?Q?jIZf8F4qHKl8qE8gjolik7sbaqy9BYXJZ9EVVAzvMOM8KzZjY3x/uQmo/9nJ?=
 =?us-ascii?Q?bOYOd8D0DEbhMa2Z0IlIOeAPB7YJ3wIktdT6p6E6ppL+SEdwNhY39oJSnPt+?=
 =?us-ascii?Q?sKD+imMXB+WxiQcxRgaavIrLZaBOZ7mC4hd+N9BkeXUkjoIHRfmuHKeT99dQ?=
 =?us-ascii?Q?X3K+KG8Dq8wXob85LvfrHJ7OaGJKCHHvCHHr8WPBuyXTPI52bqtIbzGPmjGB?=
 =?us-ascii?Q?WXpYPIm7aRk30beepMe5JMgUWxrknU0mAdPylbb6pGI3aooLaj3o15dhyZH9?=
 =?us-ascii?Q?vp148KaCqSwhQM034/INooTAZS33B9zIck2OBSnI4lUfKFI2EPe2RmMWQ5rr?=
 =?us-ascii?Q?Vcq8YxhqsqMZ1t98vJBjG2Lji4eBxrnt5Y7cg/j4UuM6GDIRsR6mzt9NcOoW?=
 =?us-ascii?Q?NQHvZ8brY+OOZBrvl1An1P8GI1X/xQTo7poN97f9uFTOF/CjMPC05UvG/c+u?=
 =?us-ascii?Q?ncBa0dujWZB3iSsKE47/I49uA5u3O5e6B6tU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:00.2339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9310cd-b299-44e3-4cdc-08dd1dec3b7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843

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
---
 drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h   |  3 ++
 drivers/cxl/pci.c      | 71 ------------------------------------------
 3 files changed, 65 insertions(+), 71 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index bc098b2ce55d..3cca3ae438cd 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1034,6 +1034,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
 
+/*
+ * Assume that any RCIEP that emits the CXL memory expander class code
+ * is an RCD
+ */
+bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, "CXL");
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
+EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
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
index 1fcc53df1217..89056449625f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -467,77 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
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
-	return cxl_setup_regs(map, caps);
-}
-
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-- 
2.17.1


