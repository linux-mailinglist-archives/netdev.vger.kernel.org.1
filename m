Return-Path: <netdev+bounces-150335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEE49E9E89
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8E01888816
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EF3199FC1;
	Mon,  9 Dec 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DXjY/I92"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494EC199391;
	Mon,  9 Dec 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770492; cv=fail; b=KhEV306iTKkB6C2uJx92EHCBJfkfQbm+73Jsx8oiH0ODJ2vH7BbrIZUkt6fKN4MgUprP4znvbV7wf+YZDpwhsVBL0HvIX5J7d+v6fjpYWoyWkk0/DvaDprOZlLqqENV64Lhzm1EQytAOdP15j2sPAyBkCd/vKgxUsZ1/HFrCLZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770492; c=relaxed/simple;
	bh=G6nKLtxL+0TDd86S+P98N1cqvFqTjR3D/58dJ/SGS4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izNxyp1YifT9QmoRlewaQ2TLg4YOloCCzf+EF7e3nebbR4lBnLmPtWmSQCZaaqkumctG6i0oM0VD/kIgSwIjChCxAm6ko4cw7WOaI03SiQxBkMzJieucSVbpMFIwM0fvs2V7rHea3uxNxeSJ8Ow73BeoPMnPQ2CQ2mHQq0x/6b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DXjY/I92; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5wjka+3gTwKKJ3jprBOI8d9fZdHkFweaCCq0GD8BwwodwBXhvwjd8/SdEez5iEobuqZz6uuoiyIywfUpvoGc7qfi4kQinlFkwA4OZWVIK34K+Bc2USfFtlrePaLNAN/y0I9b3wwAugLRI+pMUY8/iVeZkYLg0Fy+VwdWwwYtDWvMPZnTeT6D7xvXKsUIFAEmLhQIpgQo/lUZHa6DBZ2UwoPjgx+CD7SsjIeXzFjL31xfaHIcOUkYGrgTI/7zUWLmfjX1Q9m89qNrocu2VN1wDyCs2PbrqK7Tl/CSygV7YYY3X/b5ooENkOGH1W3hVJ8hvAMMOdYT3pNxS86eA+W/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S5mn+fhejuyGasj5r4dAx0Ys/bC0tm6HyFTrOzEndw=;
 b=VwoINh4XPbweeHOunDPTeZo2M9gIs1ZpUKlcel1/vb4mrC1uKMTOykWc0xKKq+ZYvPG6paviv3KQM3B9AZAtUD3QLzuPheZ2//YKlo8AXxBgM4kOmkz7aABBk2hTrVtWUHxVM8jY//t5/u9rEcHrxsyH1dNQoZT5uNdX6L9pyqgCSKysptaFbqi5jrTUhP0BOhHM981mlrnCOPjH1JRmVMlxgSTXc+eCxHZeENqleLO1DCK7qfl3c/oKLi+L6ovJ9JaYVEbno5stH2M9Ufz/WsC6Dr97C3Lx5LdGw5Nv2qgi+q96e0iDxXDSjT7GhJRrVjby0Q73xzmkJ7zHJS9cUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S5mn+fhejuyGasj5r4dAx0Ys/bC0tm6HyFTrOzEndw=;
 b=DXjY/I92cF8Mvn0QUVykglgyAo95tc3Bsl4WcPALK0bRcbkfPl/WkESA/gVVgiGstqAmNIU36E8sAxiTB0WtnYP5USZRwjIqIMPfSNavQpBIDVjCywJ0AMqb13lE/EX2ZYGyLVGVTZ+YGIVgE8LUUuf6ARO2mS6fegukErhgzwU=
Received: from BN9P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::7)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Mon, 9 Dec
 2024 18:54:46 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::74) by BN9P220CA0002.outlook.office365.com
 (2603:10b6:408:13e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Mon,
 9 Dec 2024 18:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:45 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:44 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 05/28] cxl: move pci generic code
Date: Mon, 9 Dec 2024 18:54:06 +0000
Message-ID: <20241209185429.54054-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f1b885-c6c9-4fa4-a09d-08dd1882f34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M96ncfLRa20fLyBKok4btjov979s6XQ+7+i7I7/5goW35NvbPFEdQEqKxA9v?=
 =?us-ascii?Q?tGVy4GzrO31YrXth32nNfI1KSpYgu03SSztuIj73FErrzxXn1oumDLB6qvQw?=
 =?us-ascii?Q?2xmykAiquoY5+xpPGC63yqdf3UH75LreH8sOTTjCqZpx7w3TCYlwPZQVQ9Xy?=
 =?us-ascii?Q?KqbgzA+C3AncrE/J52o2tJnx98oYnW3UNE1ObbclHAHa/xtOS8gF56/flSed?=
 =?us-ascii?Q?pPwS1uEa6fMs7tkxN90bwHIyuHkNSfM9Mci4+pnhi5BO+p2vzSv7IZDKxE3i?=
 =?us-ascii?Q?83bFELo+k+2UpTRc6HjwzHqUWu+H4iSAioUMnkSfCN6xf26NAv45WTqwPpEN?=
 =?us-ascii?Q?RMMrgzp9a6KqleTmySUobmu/UMavkFEJouaRw4Lv1lTYSMqykNq9jyQxxP6w?=
 =?us-ascii?Q?PvCyU4cqb1JATfMyQd8+kdmHxRcuWE5o7ZXCV2YTgehaM84u9nawJ8pHQABV?=
 =?us-ascii?Q?52GjDW17Tzzz2WZNu0v/1CNajloG+8VQmoxFZtDIAt6SUGZVQj/N8FnxRvPa?=
 =?us-ascii?Q?i0NYq456Mu2g08U4DgF7HuNwVcZLDb59RbAbWRhGcakL0WMDzxPJ6+nIWhYn?=
 =?us-ascii?Q?J7xgqQjyjZ2uo4RN2H/PRH1ZUIHEftA0+TPBkZekj5KDczA75fFlYMcgmLOQ?=
 =?us-ascii?Q?NtMED7fVtNNT74oKM31ZP4FOMhnOqOuCn4zvGACHo+HMvELfJBmSedz0WP9i?=
 =?us-ascii?Q?qV8OnaFhmeo1zCdrnsLpQ38XWiCePADlQql66DgwHvu8Tcn8AI9nVfMev2ud?=
 =?us-ascii?Q?M1Agj0dG384g02t51Zi62rnEcD5q1HIEdwSmYR4r1HX77b4MB48T7jh5cES5?=
 =?us-ascii?Q?M8yaMeVekDyTLWtskVJLz/F0qhvhkQFDdigXplapahwHVQMGtnFvfWlsW0Ti?=
 =?us-ascii?Q?IVRYQTpmMQZp6Tr2xP7UTGNKv7E6Sit0tmX6T8Z+Ya0Xc+aZRXIzXw7wxIGB?=
 =?us-ascii?Q?Tl7xrcfN4lo8GmSTAB/yz6vj2FVBF+Dxgmt5XhApMFRF+h2Mws3BKLpQ/bWO?=
 =?us-ascii?Q?bAcZKyyv5Rhg7zDOwl8ukl3fFejofuUHlncx7Etv3qPhTubdisSlJHuak4Em?=
 =?us-ascii?Q?HluMoxo0NHcAEgM6jgyOssjciNHx3T2jAE0oHnzCsZ3o7hC1qKM58kCzWiy6?=
 =?us-ascii?Q?TvLhM8Ye3GpqG322usfvyttNkLCX0jNQVTmTXDthIXEKFIauWi72sJP9kKGV?=
 =?us-ascii?Q?c+26+0TFpPmBDTATvz5d/UyA1mVyNVly9Jfx9Z5tgnv/XE4G0feAzlQeZNk2?=
 =?us-ascii?Q?itXgyrFlHfvIq6mFKX/+zLF62F6zkA5r3IpBoq4jVHrLMEtnkrg7Wii3+8tB?=
 =?us-ascii?Q?pvggMfKtOtnF1J0218cXS9ajWj+KWRFckECOKyIjm8XcMHKOkUeNydWetbYz?=
 =?us-ascii?Q?tbGWxRtEI2NPJCk36WvrVn1CdJIYh8XcRj3uTacKyz5c9sSApF7MlLa23hKN?=
 =?us-ascii?Q?AL97LfFPBhQtFviLodjGT/mD5L5h63juySnTWAyT00GYESo3By6DBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:46.2684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f1b885-c6c9-4fa4-a09d-08dd1882f34e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

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


