Return-Path: <netdev+bounces-240140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6570EC70C95
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2088729244
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A8836CE0E;
	Wed, 19 Nov 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ev4s+b36"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034336921A;
	Wed, 19 Nov 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580196; cv=fail; b=phSXZOxO4+Z9DLH7sq2LONlgTtt+SZER9FlLfge7V2ZNArJLRGTXo7QKD/EqRr+Td0sQKIDQ66dw7rdw+XNBwOKWclJNLc9e2t0dtXLSaO7XdLhd2wQmHaHmdx6BjXjheQNv9bjJKEYasRZHmkv2gg5MNQYQv5JwRgtbRWzlcPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580196; c=relaxed/simple;
	bh=l3b/kQ8UIqS+wJUQxZG2qG2ktnbKoiLUcgGm7LPVy4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYy6b73kZ97AiqirCCZ/PwlGXLEMPuKLsLP2wzaaWkIVVjmaYcYgqFXbfNjf+tP5uzfz0YLhXwAuK0wVRUVvtke+02aSSMAd27Zek0RkdYATzi3p5IkcplurP36JeHYLo4wYwhBPpA9lyR1WKH0ATrGOvlCa4n2uDA44LtWgbD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ev4s+b36; arc=fail smtp.client-ip=52.101.52.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3CasgVZheObO+wOO16O3u5KcOciy415ZEHItCGKel9T60C1IzIPmxM8/TZxS5NXm5JBse9HkHuPLxD4/zX7cBGLPWCDQIyi+P+vKPg6fSk2AiDX8xOh8rZKUdvGTV69oITeczgJVILg0ifLvl3Jl4XE7y74KhHS1JurD6IUUXepyATvM+TeZZT+F42zUSGA8xK7ysYMg0HG4JlwraVEJl//lT4dONCd8Bq2sao11FvDulQ68LaUn9hU7C/oBYifF7bJrE/ZiH/ZUunWqF9mu2TAVdQX2kH0RfBCPqx+VvhF0voowF4/wuyc/DgGpirlBLVA5kFBrSlJfrRBw+/Jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1/E7L70i+dTStSBSfy5r9u/ENQEO0pKfngWjftXTKY=;
 b=K7MTD5pSZw64NrTGt3y08Gn/r5nZV3VX/WaHlEORxKQrvzsezVjp4Mys3omwxxXVnnHaHSv5atQnL6aoRep3tttKLWL85LpHuTVoMWGfiuh3W+I/RZ6wN0U74S5XwaxLOMgM199t6U3T23qcV+Kc3mFNb35qfsd7b+8mggHejonw/4soNx0fyOVAiTYcadMu/Yr4rTaDJKpJUXbS1hRdVq3sinn+y/f0dqCM3Wq5C2f67uY1J+rvFq8x1gpfVeQOkX8k1R8luAkwdeH8rm0i73jpZXH+1dz3ygGCeBa68SSTGhjogkCKrEc4LvGExkbhXUuHUEpeq4BQeR3YiGIbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1/E7L70i+dTStSBSfy5r9u/ENQEO0pKfngWjftXTKY=;
 b=ev4s+b36zqBbA/PIMTTdYUG/VhR4JGUfwx+6LplVJUhaQ26FJ2Lac3kaRLunSS5B3Ttrfu7JJzkefXw79QzJOqi/4CkcLd4tEjrtS05pCy46R3L7F5iyPKPxso5FtWn32wBvXNc0rem4DQKrTSyJ+YdOyh+1XmDuBPEhOE4TyPE=
Received: from BL0PR02CA0055.namprd02.prod.outlook.com (2603:10b6:207:3d::32)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:22:56 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::f3) by BL0PR02CA0055.outlook.office365.com
 (2603:10b6:207:3d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:22:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:22:56 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:22:55 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:22:54 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v21 07/23] cxl: Move pci generic code
Date: Wed, 19 Nov 2025 19:22:20 +0000
Message-ID: <20251119192236.2527305-8-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DS7PR12MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: fea7782e-418b-47a4-e9c4-08de27a10b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eS+9LDQI5xRz381PtOrIt+auVKGOuwo5QuRKLes76rhUMrJZDrf/h4laqh/Q?=
 =?us-ascii?Q?bopIYO4y4cxvmeWH8KpSb7LCqFK4+0o4W/dpvSI1Ogf9RLZ2hbRchycjDskg?=
 =?us-ascii?Q?OXnbtomKcv7CL2jqtGunwjNZRFnLrJtdmclKUERok1sTs88iCFLU0eocYCu6?=
 =?us-ascii?Q?RgTgnGcpdMh/U0NoY+3/DIV+V54+RfDCRWuWRqc5Fj1iaMv07VEV4pRVoCkQ?=
 =?us-ascii?Q?bpJs7XuENVbdZQlZDgO0ZmILmufBFrH23tB08LB9ys+w95ytKgu0iymyO51a?=
 =?us-ascii?Q?v79wHYhfv5NxX3fpY3+nUH8RgZcKTU+csM2xoQDyuMWR3paufxkAfkqkBsNo?=
 =?us-ascii?Q?u4TLvZYPWrNT7xxSE8aCYVpT5hcKJkMK8RW2hvwrM+NkOZc4Pe34JAnjl3Yg?=
 =?us-ascii?Q?dOTReM+T03/egymqs0EJHTFeamMbt2lb3rYXald9DGIPMIWxCFZFPozgdwaG?=
 =?us-ascii?Q?fH3drZCkouYkaL/fAWJSkwRkhkBCPNkNL+w6Y8TLRvLHQP9D84ujXDtnY9Bg?=
 =?us-ascii?Q?afQNzs8Wvqd5Hpj6sh8WX5n9fAbXjijd9KrVwkiWqKuEifT+FjJASuEXmFPW?=
 =?us-ascii?Q?kKgXB4gdD5EtKB2mqON7SuuiqnCNvHO6o1SiVHsg4aGxvBDNR+5y1broAQun?=
 =?us-ascii?Q?Ri+qZA9vX6hRIFwelzWwpayeLkpoMaEkr3TalDOBQ2ED/5QLfbUQlX8g4mo1?=
 =?us-ascii?Q?7f66A5QIAiixEvnC4FNvw1ySCd1eJ2+h4q4Wa8+9w0lj1KgY4tVQaxsQLjtf?=
 =?us-ascii?Q?byy4livsKr688/Zgy5j9wbt78ENq8LTD5V6JKGl1BH2dA4wwWZOwYX9h2+74?=
 =?us-ascii?Q?WeahkEXnheqZfkLbHVdKMOXsrjCHBeXTOLIQbeKWvbpicOAYSbS2GAvT4DOq?=
 =?us-ascii?Q?4a9AZdegsRY8jJPusViu/x2Z0K4EpIyK30yDWTqPgzJTmgaq2gew2GCTXUzF?=
 =?us-ascii?Q?oQl+m/Ej5R31rnHQs/Uk8iublzZlMxt3UUqcd5LoZR1lgEej8iYcOU//Q2p0?=
 =?us-ascii?Q?XTcVf5KSqQ37zMuo9bgUpmz+zyfnD2utQJJIaJa01ylkrn5CMHnEbjtmyTnn?=
 =?us-ascii?Q?Egf8bstKgnAmIur0cSNBkZdjKMily7cV2LW/CF3GbxvPp6fR/nCHBALuAtuE?=
 =?us-ascii?Q?kp+6xM7CKiN+cSv1vVU1487AGdYhe+KeDxqg1oU9XVq2ublZcjrgwMklWc4W?=
 =?us-ascii?Q?6NxxTApCqMuOPQxjskwrf0KjHPt8+MpZ+0S6RAADCLeIKm43f8C40s3XNVwL?=
 =?us-ascii?Q?jFz1Ff+usnWY7PjmtuEI7FtbTLDosTaC/Huhh9lXrixu7q8Xgd0546WxLc7S?=
 =?us-ascii?Q?LUo55RT0jQffLZhAmk26EHFGyEJNjqr0mKD1ssaFxsiMFZa3xEi8pU4AKcf1?=
 =?us-ascii?Q?vpuRaAs25ZHogkvTKl4r387+EK3Vi1HUoJ8TgcOGwVxQnSZg76DyEzS0TVog?=
 =?us-ascii?Q?dNvtmGgC3Nf/phgwT8sY54PUamFzOl0T8I49UIQvYYJkE38Y5zMjW48v40ur?=
 =?us-ascii?Q?CE1pgj4ny+YUJ1rexiYrjgU2tGtMeejbvCfT1onkcbTfT81XCsE6PaiMRneR?=
 =?us-ascii?Q?a5J78d0Mrp216CClvDw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:22:56.5428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fea7782e-418b-47a4-e9c4-08de27a10b4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984

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
index 18ed819d847d..a35e746e6303 100644
--- a/drivers/cxl/core/pci_drv.c
+++ b/drivers/cxl/core/pci_drv.c
@@ -467,76 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
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


