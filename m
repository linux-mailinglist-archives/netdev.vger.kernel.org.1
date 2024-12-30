Return-Path: <netdev+bounces-154575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9F9FEB18
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1BC161BD1
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1D219D8AC;
	Mon, 30 Dec 2024 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WHaoQbrl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2519DFAB;
	Mon, 30 Dec 2024 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595113; cv=fail; b=UBs3q7E4CQm0CxTT7T7nya5SAxY0pxo3JVrKPFmtw0enJqUgD11IhETEsIlIX+EUE+j4ChLqr4f/Ff+sinXeU3saRr9oa5mB4S5wqgYU1CWVwNsURbffajSgQtpsgIPcbAcajHrc5Q5jieDplZMugLZFvkh2m123pPatsDPvL20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595113; c=relaxed/simple;
	bh=WZF3RBkxI1nOgwAVBnEubFNUl4DZVFEzOUcq3FcWJ0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPv2lW14kKflv622jWRrQ6XyA8LHhZ2NNtelw4Ei17I2P0E2JpDvC/Hw0+kM2TdL56jymtbCjih9pUwQQ1wW162n8Z2z2SOx/gFkH63m/sAC22S3HLTvb3IG4EZstDUeYXPzdvD6E1cU45WSmijS/j53cHMWybV/kup01GuKeyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WHaoQbrl; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=du3UYiYMqNOZgQS+jDbLTnQRpthOpgH3t4b3473cLNEQw/zih5D2EMva7rY0UVmPkNGYYK+Xxa067Y7UCOMPZRgbfe2BOYVaGJyt8ga+oI8zkfOX3L9Ay4iTNxMw65WVIZfpZjPkUrbbq2/4a6rMT9Kng5zytqKq4CHopjRkQlMtegbySuMDBEyY/jaltH7w4VAEbq1hnL8NvPnlnhRZNjHiF/Y0xheBgIE7Ok8X2wzFK/Li0LrLifzmY/WgjDy4tc1hrd726VE3jh03C9WgUPRTUVJ9qd5vqZF7KKgcke+QVJnz9vwsya/FDtyzC7TtNcNyToFsFiBNXudE+orndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIhDGwG0jbxgBn8GGdi4lkl9vsc7kotOnSzW1y40xvA=;
 b=uaC1mfs1580bKpgqpBT65rY1zD7ZVckeWY+raVHQ+qhNptUEoAlsc1k5qSWOLQHNVbQcJPpHmBcJgQVMgMkU0IGwFm/BhP4MINJam+1QgVazJH2kGWRxgfYf1IXxRuHUTWxiMKUIY4QeEVcNFj4Vgj4k15wBSYyGdGonl8dId1YDazKZtcYUimGum9th8XX8upIZIlVkkC5Ty8do7QD53PR4bTdvsSFQIHf/EEJUUivJIwiCibBcQxwOrsWmJ3hN/MWmyfCLHJE7Zwky9WNGUaTc/iXGtxoQ22KMEbhNtnUAEcpXTJnqbRTIWO+7grGGQSoleJQG9FYD8KtNJvwoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIhDGwG0jbxgBn8GGdi4lkl9vsc7kotOnSzW1y40xvA=;
 b=WHaoQbrlIyrpyDXlFbXSm1RR0jaTuEWeTLSgyrX9cw1wS8Th2Aqth1nYpkPcjv54hezGvRB2gX2zjUk91Holk2zWJpjm1XWskohKJRa0Q/WdfEhKgXOrshCY0wkRvbtdkxfwfq4aosWEhemwf1J4WDw8Mnd/KlBBIzaUStNw5cQ=
Received: from SJ0PR05CA0094.namprd05.prod.outlook.com (2603:10b6:a03:334::9)
 by CY8PR12MB7730.namprd12.prod.outlook.com (2603:10b6:930:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 21:45:04 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::62) by SJ0PR05CA0094.outlook.office365.com
 (2603:10b6:a03:334::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.10 via Frontend Transport; Mon,
 30 Dec 2024 21:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:03 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:02 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:01 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 06/27] cxl: add function for type2 cxl regs setup
Date: Mon, 30 Dec 2024 21:44:24 +0000
Message-ID: <20241230214445.27602-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: ace072b2-e72b-4ae6-a156-08dd291b380d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0pwd4SbmmWd6SRj5uCcFBcKXRVwThDmsKaF5VZ0tWSodDjVxpeSgCKMrQ86V?=
 =?us-ascii?Q?pqAqkH+7MSdvSDEKuFjcbruTBvFlKL1J3nD9LBBDQiaFmOz7cvqD2mcwOzhH?=
 =?us-ascii?Q?c+mX1FMNEEFAlYS57iH7SEpyv56/3Y/zpJz6aulpVS7/W2P/27ibZxXX403N?=
 =?us-ascii?Q?mqg+KsOaztBNx9uaRnHzpQDI5Or5tmEQlhbKuA2W0n+ImcYsxu9LQ3Zp+K06?=
 =?us-ascii?Q?G0VhLFPhYrl8luMrPgbdl9uhAFt7KivtlTfLgkedfCn37WjyCR/yrxtJBrJu?=
 =?us-ascii?Q?FdOy1QmXKvgKKcA6L42lfE++5/nvTYGiXg/dsEPpwkQliPeC8S7RJ15yFyds?=
 =?us-ascii?Q?Gp3fhO6urZGCdhfsMhcLvIOEbdHhoQWFSZFlIQr+6GogiR81dbC/7PzX2ube?=
 =?us-ascii?Q?QJ2gi70EID2htoQB7O2vUhsxRlwV3DGwsJNG5olpljidVXrOPB0U/ZudN2e/?=
 =?us-ascii?Q?+Rhph4ikvzKl4UDyeE5Q3eW1hq0oMRBtq2it6zGop9Tt/OsNE1IYv+b30+pg?=
 =?us-ascii?Q?v7wPMdEfY1sKIE02kCTDSOjAl3jQiFHJSp/9Zxb60n9d4h63svDcIIp16rMW?=
 =?us-ascii?Q?vi0Dr8DWkdmulSzPsbX1dh4punCVuXu2Nj5ghKOrhFchd8rn+mkU0ClJtthF?=
 =?us-ascii?Q?1wePtmuGkoe4/meDzFfh8AokWqOwg8/Gj6VDseeXPbqI2PT5zeUX3nqOG06q?=
 =?us-ascii?Q?R/xrGjL1b06CKwV8bd7q5qWAYn+43GzhS9NCKLjK27vbLPAns0eKfX/vVLJK?=
 =?us-ascii?Q?tqmooEd1CnCS0QbZlzAVGsuqbd6LzZX8XkpgoGR0rbxF12SlgQFdCyUt2c9w?=
 =?us-ascii?Q?1Ykvm4w5iULbKTtD0cJ3KD63KziI1MUvDaqiXwtk1JoLfg+H4Mx9icg6olFk?=
 =?us-ascii?Q?qbTwuwkuataJ+qI1mciwby5ris4pbiulEsiDW99SDwDexRxZ1+sR/xjCANh1?=
 =?us-ascii?Q?GziwZml36ETHncj+ezrp/C+BFkuLpAflkQPryEE9OBAXydhT6luC+PmM+7M9?=
 =?us-ascii?Q?ice1OFC8Q2+vX2iSy6eQXoQNkY01zsbMbLPypTUXJCzsjBhOzrtlJR/xaK3y?=
 =?us-ascii?Q?4+/mvqLL0x+gQRWqfgSbcxOVvNC03PU/xQVDtjuHxLG54uRPOG03BmT5xnqo?=
 =?us-ascii?Q?SzaXG+dXsN5oy9/5fX5GLNpZkl66lXdF6tpAlXsPYG0XvkpzZfBpzacRrWc4?=
 =?us-ascii?Q?L1Rb7UvHGcoBr7JX9Ga5sAB7bH1gJ7xUmhypLDDqJhJZVE8DpoERWV9WP9Fz?=
 =?us-ascii?Q?jKexjHVjHJyje3kjZJ76W88rReYXXO3MdlpZYhQs56SsPrGSv8fSdPuQTW3a?=
 =?us-ascii?Q?fnl8qOUDy2LQEioNgt+GvKhJoZUBF/R4h7zrb91YFoMt2J0uQ6Og2aK3WZdl?=
 =?us-ascii?Q?23QB393Rg9MgQAIClpo/NMlLk30l2afakk1NqfvJfvEDhouk7uY+FqR2T+OT?=
 =?us-ascii?Q?k7FkfgdX7Ya/xmjHkFTgy/g5VNa9H/782nBPreRacKmXD6exICcaDGpKajDk?=
 =?us-ascii?Q?pVdNbPVUmraVKkg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:03.6189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace072b2-e72b-4ae6-a156-08dd291b380d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/cxl/core/pci.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5821d582c520..493ab33fe771 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1107,6 +1107,57 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
 
+static int cxl_pci_setup_memdev_regs(struct pci_dev *pdev,
+				     struct cxl_dev_state *cxlds)
+{
+	struct cxl_register_map map;
+	int rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
+				cxlds->capabilities);
+	/*
+	 * This call can return -ENODEV if regs not found. This is not an error
+	 * for Type2 since these regs are not mandatory. If they do exist then
+	 * mapping them should not fail. If they should exist, it is with driver
+	 * calling cxl_pci_check_caps where the problem should be found.
+	 */
+	if (rc == -ENODEV)
+		return 0;
+
+	if (rc)
+		return rc;
+
+	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+}
+
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
+{
+	int rc;
+
+	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map, cxlds->capabilities);
+	if (rc) {
+		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
+		return rc;
+	}
+
+	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
+		return rc;
+
+	rc = cxl_map_component_regs(&cxlds->reg_map,
+				    &cxlds->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc)
+		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, "CXL");
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 464e5fb006ba..c1bb0359476c 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -43,4 +43,6 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
 bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 			unsigned long *expected_caps,
 			unsigned long *current_caps);
+struct pci_dev;
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


