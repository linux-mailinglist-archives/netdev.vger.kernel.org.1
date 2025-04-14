Return-Path: <netdev+bounces-182284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E003A88725
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9ED188DC1B
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A92274673;
	Mon, 14 Apr 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AzfInUzN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5523D2BB;
	Mon, 14 Apr 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643637; cv=fail; b=jyWJvHvZUFnhur99QRDb1P3zzK4mz27KpUINfCeYYWWdxGKYRYFa7/PBDxxEKgT0WaTjw59TUI3o5TTaf9xafL66qf3S6bW8FuTGwjrmthR7sNzCmgzq/bLIuT1MEW2q1iPvJsy2uqTA5+CKC8tTLfwvxeN1SAdZzNQYylUFfP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643637; c=relaxed/simple;
	bh=0W6hF12lxjQoL1/Ak+0hhoWvb4E8/aytZ0eJF4/LA4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mf2SlvENdC5SLBzEyvqTmm7SJHKWUXRkqcN7unMFNS1oAYD8vRA4Hk9zC6kcpL9fSPSW8985wBswnvNIKV09KPGJhfw5ohGuVDPOJpnm236nPrN6e4yLLNu2U0lZo8sUJTuceU+H6sTXW/fqQfWSUC/ai12mRWhxHvMhhx0yLgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AzfInUzN; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQ0welOVu/IbXGBiNUAd+jttCmo67OFYq0rnW0BAb5jwsqIQhKSvjXaEIVS83iLLloricevDQhOsd2pJBGRjsLOquETTHPqGttTiGO2IxKF3hRVLJ0JS6hKYtuujFigtUgZsM064BIBg1iSVyWrM4SDKY41EwzIkbymLrJKkjNvdLcygVe/fveOWBeNivNUUZZ1/491O3jbCzY/J/4Dvhi6hNBkS+AFVq5NiqsqycM7xV+emp6XcVpmLaup6ZhnOPlC68DXSe4xer1iZfJ4RXgDt8me8B4rFN9qf3KOi534tPxbyyYp7qqA6LviJhOskGhdHINu6kAURphVr1JmyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHF6QgPLi/C4nsmheLzABJx7ncfuBtWrjo2go0hS5j8=;
 b=WVLnuCS/o1Ohcb/1RgQWjU+FZbjIPzuxL0ch7gDoxskl1ewj9XZ2vN3xsG1PenPDwWJs8SKV41LTOpvaQhEUo0qWwqZchPsl4Fvv7b9eryUAith0cGcDawFO9eBD7xwwL4HAghyJ2bZeeyxu+CNOmqg4wNkselzKe+G7TrPnvUd/lyD6EPsxYdpr8/rNCPaBAdzMkq1YB/u50+nW1WElutJ0ENEHW2uDtYgp27nIKc+58wl3FbMSfptYk90Mm0C4QAd5kH5SgS0knCysG4HTjGVn2HVy9bsyqy3hfSdtItDj2ZlpEdrrnSgVUwMwUHZ0Wcv0Af32LtqD7/EqT1QaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHF6QgPLi/C4nsmheLzABJx7ncfuBtWrjo2go0hS5j8=;
 b=AzfInUzNTFQ40iCbSbtU5ngiJD62aH015dCTh3MvTutj7w5cawnCQ/MUi7VGO6GUHV1dc5m8OVVT6fxOv4VRGR9YLi6HMODgQvQjRYDhjM/soC8wJ/DZKgBLBk4zJyLQIn0+yeZr/qm0AhMbBDrPqFZJVaL8eT7kiWGSA5XUneo=
Received: from PH7P220CA0119.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::6)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 15:13:51 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::4c) by PH7P220CA0119.outlook.office365.com
 (2603:10b6:510:32d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:13:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:49 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:13:48 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v13 03/22] cxl: move pci generic code
Date: Mon, 14 Apr 2025 16:13:17 +0100
Message-ID: <20250414151336.3852990-4-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bfb9dcd-6d9c-4fc9-e13a-08dd7b66f677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pp7GpjBS43nlppSMazNRa/fcg36268H6GdrDu5C5iceosU+dSHXrDabzkFPz?=
 =?us-ascii?Q?sLGPuIBUcYLE7f5LPny5BYxncTf/XG/R3Sw2dh6XWHmxQPaarY37jSwCBaFv?=
 =?us-ascii?Q?jysmn3desuYOhO3KfiHhFe/5kDcXG0cSftEjWLJT/0aXnMeahcCM9EZqFNAQ?=
 =?us-ascii?Q?Vsb8sdE/YUaFCJyigQkRiC7OrXzm4IADqJrOlaxaR6V2kRN/SJwvR4xtOEyR?=
 =?us-ascii?Q?8Emiaq3HXuOCuA83adsKoBDjV/MFW6cqF3QpX3jun/7OecIyY8K7K6QeesFT?=
 =?us-ascii?Q?aFHM6h7fs8U/qvEu4/8+ITsL4z2oidBW1sRojJ/rnZNzxOEXCWD7rmaZvyFv?=
 =?us-ascii?Q?p7uM5rIzQw2ldCIiSWxEN6kJn5GqPemNVXockGN7ZGy/061qRTCUlIxJiA2i?=
 =?us-ascii?Q?TYy6GO0yvp5Mr9n/tEqULUdnozbcDJ5jpSCn4ur2NlbctDb63vFh5i6deof2?=
 =?us-ascii?Q?UYpvzy+ouwWO1csR6ejXvMc/jCvaJDszOnJ9ElGgz5sjcu6ds6mw839jxEvR?=
 =?us-ascii?Q?ydgQaacP8pX6bDeUiiiRGD0N2oZGvTF5yL8pTGQ88K6ogFBHn8EmEEQ9aH60?=
 =?us-ascii?Q?MGtoxi2kc2exvk23iE0Cy4YxR8ZzJYLTgmrOQaiRrXxwbX0nzx4SS/sdpYGn?=
 =?us-ascii?Q?UYzipP3cYH5klKTK3KDUALPi8GFRHFxp6/B5sBiIwAnFTOGwl0ERPsX+P+gs?=
 =?us-ascii?Q?n2TZAXlUl2Nc5WNP/h3bEQk9Wjf3cDsqOk7y0kujlJ6DFchuc7ZC53APPF6E?=
 =?us-ascii?Q?uZ2AvIOiwjKuLkbprlboR5W/kxtbKv4IElsDdbUK63X31DfJc7UyQ5T/Q3cf?=
 =?us-ascii?Q?5hE8m/nE4CjVYqXJ+ajzz2x6EiX8EJWRsmJaHzUUFciJJlch3epaDVr6i1QA?=
 =?us-ascii?Q?pDFmxDT2P2CPGVe5QgugraVYdDv3ijzNKVFBdsR4x1Rww/jz1/hN8fJr0FX/?=
 =?us-ascii?Q?WMFcfGCEKpziLc61QjzzFrQPAXpfV5UdJAGUObXXh5Szjfy0tcotiGa+D/5w?=
 =?us-ascii?Q?PhA8tBERFnPHsIMGl7VyF/oEhcWCLQhGOwd1ayE/IFVoU9pZSNgmwqgZh7mg?=
 =?us-ascii?Q?YNd1i9ADPkReNaavrm+fX+Feor+hCDXz3ahgS3KTF5/OMmNP0+USWidCsN9n?=
 =?us-ascii?Q?b3x3yV8ltXYH3tD17JprIcfvHGzZDPW9GfHEUxtStdS7nvTyJ3cmodr7JZfF?=
 =?us-ascii?Q?XcCJuLToRb86gj1pcdohkI19S6rHbe9Jz10wvvRVHJsFQhQPryaZQMngjZTj?=
 =?us-ascii?Q?flkM+wza8j1Iv2zVc5ZIeyWwC5IACQwZsAkmAbnBME4v2qN+PGWXc5PHx1V3?=
 =?us-ascii?Q?j+35BNP0g6OrIyYW4ATm5ZU8DZ2KpnWtAUXtk3Cj/uf1M46od7Ydw5DfLbZ1?=
 =?us-ascii?Q?nR5gY+ds4yv0fFtAuQjGscSi2+DZzW3TSA71xL0cSV/xcKO6phvKgqcX/iMd?=
 =?us-ascii?Q?S9WCVA7RG1Ix2XvEmtUct+3phXDAqrp9SfFOhGiNtX8sMMQZj6W39McF/JGT?=
 =?us-ascii?Q?uzG0Rdy5WASPAOPZtjDn2warydt2TvwwVf7H?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:13:50.6848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfb9dcd-6d9c-4fc9-e13a-08dd7b66f677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252

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
 include/cxl/pci.h             | 13 +++++++
 tools/testing/cxl/Kbuild      |  1 -
 tools/testing/cxl/test/mock.c | 17 ---------
 9 files changed, 79 insertions(+), 91 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 15699299dc11..93f00c7a94a1 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -134,4 +134,6 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif
 
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2e9af4898914..0b8dc34b8300 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1033,6 +1033,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
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
+		       struct cxl_register_map *map)
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
index 58a942a4946c..be0ae9aca84a 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -646,4 +646,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fd7e2f3811a2..5d608975ca38 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -221,8 +221,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
-resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
-					   struct cxl_dport *dport);
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 570e53e26f11..0611d96d76da 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -114,4 +114,6 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0da1d0e9c9ec..0996e228b26a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
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
diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 5729a93b252a..e1a1727de3b3 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -4,6 +4,19 @@
 #ifndef __CXL_CXL_PCI_H__
 #define __CXL_CXL_PCI_H__
 
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
+
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
 #define   CXL_DVSEC_CAP_OFFSET		0xA
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 387f3df8b988..2455fabc317d 100644
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
2.34.1


