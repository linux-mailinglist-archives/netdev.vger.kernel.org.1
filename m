Return-Path: <netdev+bounces-243786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C74CACA7788
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80803307314F
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EAE32F75D;
	Fri,  5 Dec 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ovskkzyB"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3323074A0;
	Fri,  5 Dec 2025 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935600; cv=fail; b=n0DE41kLXN0FC6tRP+BO+v6c1fCkM7HC2yHoAIdsBC42iGrStU6ss3CLbsPK1ZE+YfnNZl1K+jN5GfWSsgBLZU5lwggpr6AIjN8Y0KTuSx5Ag5eV9bC7XycI0Ps22BJ8cSnvS95HUxkKugoYCZTrgafwRK0JXrxL2yab3DEV7O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935600; c=relaxed/simple;
	bh=o2JWyj1Zdxy0MHRhoIzJR6mSDb2f4S8SxKgNdpsPsJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhPVgujmYCzbGgMCh34VWLl7z1WtJbf+W3Vh3x8ZoGD2u1fCI19R6E20fyMAiz/+/solecQn77e5J+2IC7yUJfmvLqOnKJ5ytTgUyxK0Goo1y5yRqx1ppcCVSRij+qP0F6sOYn5GYFu7fTC0tVFcm/cTSasqJnB3Cy+X509odZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ovskkzyB; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOxTpz+Dh0X0vdq3xav5XwoXe195QnBmrsOAP1WBGcE0cOjCRL+1CGSM+ygm8drhJKpv4nzPgVPGVGhGTKdmDMidnNDZO5jUgNe3IPBqMciEdp31fkm53B8BMYJBEUgCeidthjwi2NG6jIgCNG3BtpJxQna8ttkkpoEDIBVbqW/eiOaMihhLA5+2eHV5fCibJnCA3D4LcaQApnBaQB/W/BhiKmVSiQEolzWAq5kpqy7RZnRV0kq1+2ACQGGozxCI33R6/UicDA5WZXpJRJkeO9wU+xV5jxh2Xk1+auSxfotNiNnlQIpEFrU6DifuyWhZo/xhwnNWN/PX6nf43IUKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rugJN8DBAzJx5rL22Xco+GWffluJnFwMQ7fEjbLXhQk=;
 b=cqUS2u5BAy8yvIHwXZoWmx7ch0DU2M6pJWCoN4S3bH42AdgKJFg8wJGAphjDkauYDzwP91cr+ku/+Ws03S0fu72pG5rWGqcqVA6hBcM0dgAr/NuFj4kZd1cELZY0gTkjDR9wNPI4GguvhsrV2L3QsuptjsDnEnx83RaKZKwjIQI7cBgVdvDMVVVqtjHHGMHOaInSCseiUOChZXSAnpGSkPolY0iJzNX3ptUfEAbeEEH78CTUD7FmrZzIqGtQxVPCtATuZ1RfnComyPjJpravpQ80XnSZSQIxzGSVLMZkBzRbVm47LSj8L0BmzlppIiF1hx/hiSXx8i3iJDVdE+3XMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rugJN8DBAzJx5rL22Xco+GWffluJnFwMQ7fEjbLXhQk=;
 b=ovskkzyBUnaM1gObRXF14dArffB6d0bfvTb7DXqMokgamOwXHVgL5aBxFv+Y14plQHSfhEEa1ZDvyGDm7j4/NFH+qSEOsJWB9B+JEm5ZToVo/N5FaKLfd3W+Z3zgkTiRxIhpYUNopPtf9a6MzijrCxKVvTQGaRtdqHeTPdZjpcM=
Received: from BY3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:39a::6)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 11:53:09 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::b0) by BY3PR03CA0001.outlook.office365.com
 (2603:10b6:a03:39a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 11:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 11:53:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:06 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:05 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v22 06/25] cxl: Move pci generic code
Date: Fri, 5 Dec 2025 11:52:29 +0000
Message-ID: <20251205115248.772945-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d0923e-65a5-4fab-aa70-08de33f4dc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HTMhNM7IPw4MM6m+JV2DLmUAr8e6MwBlbXXgvT3SMhtgCEh3xCdVXafOSFKH?=
 =?us-ascii?Q?PEt/pvxuvCrS6X8N9ss6MMiqJxFjJlKQYKpKepCiHzzXMdEiV/tVTn1IPHYl?=
 =?us-ascii?Q?yORR9y4kC7TiyZhb5ZKHiBlCkkfX/Nbi1eqGmgqcuQnBSFQJ1jLzPCkK3GmC?=
 =?us-ascii?Q?wmHPF5eD1jW9zbp9oCaRVW4lplbqznyDffdj0p4By+gVIcQUvVrCsdIhF31P?=
 =?us-ascii?Q?u53ksz5gsO3Nn/h8nJzSoQ4LZiGmIjqmVWeG15diiPOBD2Fab3zFpndfEvVZ?=
 =?us-ascii?Q?EAzOeSi4hoydcRkr1qqr8jXxQNUa9U4jVSbl7eRyfeZzj4lS1QuIhXFw2Tg2?=
 =?us-ascii?Q?LRy9e/QhreSd6r9Osju+ZD6btv7SsSAFhaEe/TubEN61VQ+HxuNSPZqUCqNQ?=
 =?us-ascii?Q?uqUUEzAMO7HxCkiSFCsvmUOfiIihUDHHDLJfj3XgLn0enZhNxuK7AvRjcTcA?=
 =?us-ascii?Q?7snOgfx1AZwnfkmh2PWb5OQ5njuyGNlUavzOQM+wkIcy3pUl41T7xlkaCM7l?=
 =?us-ascii?Q?MSyMzh6uqaJMY6mT8B5LVra6lUE/E21QJyy+sBlEjcHMQnLXkeN9rETa0P6v?=
 =?us-ascii?Q?/lA/6HCSxaEdvDiBVrCmpIYfR09/wTHcCp+QNi/s9pLwJ6/z1Xb4sgrpxgei?=
 =?us-ascii?Q?OvHd+jC8tlYd5VgJg48O/3dmQapLmOIX16cdVlz48X2POaYpaB2xHeGthvIY?=
 =?us-ascii?Q?Xgx8728XkNSc0ItvgFkp4QWeD4IuxkaNkRhQWduUP2R9xrFvSm418jBbiBzY?=
 =?us-ascii?Q?SQMQC0pdewROt8HZVENVZM+l6WCtj0PVxzc6oXxBA3lu3/RtY5YFMUXCUktL?=
 =?us-ascii?Q?n2GSJaN8vQsRgbPM5D+usAClAOlV6sTzWt4ItxG40wcQujnaaYgXkbvWLhG7?=
 =?us-ascii?Q?F0LY8jSCsZivy0j5GEfE7bE/CMJQsq8tfdf6qP4EMTIilig2+2tgBQCR/21w?=
 =?us-ascii?Q?5fRQ6lgUp4jS6lSsUzinxYLi/kevIuWS9ozDSClOUdP2jJWmlOuuuWMM45NO?=
 =?us-ascii?Q?XiCQSnvAQEV5Q4rNL5u/dl0eLCFjMCBMfEeUKGfzUvv4mSrM42wf2/bIe0uU?=
 =?us-ascii?Q?wmqhYCbyqGrvGBLHC/7wZUHs8xVYTyJ0NXscqqOh3ygyQTf42xE9o5pV3+V2?=
 =?us-ascii?Q?Ka61aadLe9UTaU+LAzcSkLQY3mZahM6ynnnQpkz4AsQCCETU6R77cQ8XR4Fi?=
 =?us-ascii?Q?2KugNPUCp/arxH87ixcY7gSp9lwDi/McjVM0h1IWsMChVGNdxGqDTyN6y7Jf?=
 =?us-ascii?Q?mRGsNNEANEAqCR9LQabDoVK6lAgPT6fY1yCIdEjU2eVhijXYBd2y0zC9ZlwX?=
 =?us-ascii?Q?CWLCy2EJBVjPjG/iZeQb7TzsiFJ9MMiPOmUb8YO9jatw54WWtVFOxRLjUM5M?=
 =?us-ascii?Q?5jPqspPbZS82t5M/0yOpsFYABy9kiFjsdW01NCFcFsSyNSRZHLQVXklPofl5?=
 =?us-ascii?Q?jGd9InICmC15LgXmZvsg+GrH9aK7KpEv64y9FuaktPnPxJO7hODYRLsE1Lvm?=
 =?us-ascii?Q?eYPLktJC++kXAkMXzL7xZH/FwTfkqQ4orvpMHYOCVC0DcC4LpJRHvm+UDcy4?=
 =?us-ascii?Q?32avapBD4G4/ADwZAhE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:09.8399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d0923e-65a5-4fab-aa70-08de33f4dc97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci_drv.c implements the functionality for a Type3 device
initialization.

Move helper functions from cxl/core/pci_drv.c to cxl/core/pci.c in order
to be exported and shared with CXL Type2 device initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h    |  3 ++
 drivers/cxl/core/pci.c     | 62 +++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci_drv.c | 70 --------------------------------------
 drivers/cxl/core/regs.c    |  1 -
 drivers/cxl/cxl.h          |  2 --
 drivers/cxl/cxlpci.h       | 13 +++++++
 6 files changed, 78 insertions(+), 73 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a7a0838c8f23..2b2d3af0b5ec 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -232,4 +232,7 @@ static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
 static inline int cxl_pci_driver_init(void) { return 0; }
 static inline void cxl_pci_driver_exit(void) { }
 #endif
+
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a66f7a84b5c8..566d57ba0579 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -775,6 +775,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
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
diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
index b4b8350ba44d..761779528eb5 100644
--- a/drivers/cxl/core/pci_drv.c
+++ b/drivers/cxl/core/pci_drv.c
@@ -466,76 +466,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
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
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index fb70ffbba72d..fc7fbd4f39d2 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -641,4 +641,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1517250b0ec2..536c9d99e0e6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -222,8 +222,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
-resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
-					   struct cxl_dport *dport);
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 3526e6d75f79..24aba9ff6d2e 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -74,6 +74,17 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
 	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
 }
 
+/*
+ * Assume that the caller has already validated that @pdev has CXL
+ * capabilities, any RCiEP with CXL capabilities is treated as a
+ * Restricted CXL Device (RCD) and finds upstream port and endpoint
+ * registers in a Root Complex Register Block (RCRB).
+ */
+static inline bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
+
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
@@ -89,4 +100,6 @@ static inline void cxl_uport_init_ras_reporting(struct cxl_port *port,
 						struct device *host) { }
 #endif
 
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
-- 
2.34.1


