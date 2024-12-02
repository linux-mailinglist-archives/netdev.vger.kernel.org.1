Return-Path: <netdev+bounces-148163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E44589E0989
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4AB02823AE
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1471DD874;
	Mon,  2 Dec 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tCFHl4l3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B61DB548;
	Mon,  2 Dec 2024 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159572; cv=fail; b=klRbes8K6P8DIu+bxdfC4E/l3M/XoEu8erbCr128Ak8x5227SJEA9epCNaKjCE/S3eZJyKwCqIZjzpc1/bJq5uKqsvaQXVncL/NiSrW8zVOflbbBvi94I+/cV6J5gnpVoE7hJNEUeXsqBsWUkDpmnD6salo4ZzY7EJn63qP/dGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159572; c=relaxed/simple;
	bh=t3rYvVdrMOv3CcpCo9GsKqn6bYQOMF55vOfgWHdc7w0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6gTKDTq6zQjUcOgqm+lKa9lcZ9BzABPzM3bluxbqwihTdUT3dTUlI5zIxi1I2tWQloBv4MAsi9g4XQ/N+wlGxcdkq1X41IwmYyOus79MPlBxXJQe4J7De7hib1rTuOLVuOFEEbzt3jsvySWFXbv5GflwGydZPXp64Bey79pm7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tCFHl4l3; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ov9mjRXixUkoJ4i7LA+lOB1E+FpK/hvK9i0W0BwbEv2gbLrT98JIt3fFr6F18dU/BMh7+r0OmDzfzvldKfwAjkYZoddzGkmMWqpYNZpXHO8uzItUVEClCRQYRoxKlxJ9dXLHBpdEUR4qtNLs1db/TBr49jgI5e4ybBPVfwXZMxwkjlgRpB9rfo4IOUGvZ7ET10q7TAJ7qPHizJKodPmMWI5oYtd71DK0IwuPViQo+CsTMqnUtNfIrpWW/pFwgzwJkO/NHiWWOkd5RfXbBdAnJnHwBEAnTfXoymd4rI8nDgVj1MUewZa/3Nk/vXtb5CLtkb+l+mupzJt6lSizd5ARlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG5whBR8FhJLSwMRh8QU3MJmmfRGaBgxMpehBXOItMk=;
 b=Fs4qOmqx+jGoswCIIeauqYCneHV/1PaUH3AmgS/ABMkHKsFaiGKF8edCZ/JVYp12R8CUwdOionuOOj1zheVyLTrjJH60Gt5k8Gk2QJ37S/z5T/Ph2ed7MPauoeRyQTCZ0ZduQqbdvQmHKg9nMNHAvZjbam0DmG/gL0CffmsLQmifXKZzUxcFCmVa289oPQ07nuAghzxo+WolqRDK3mfDvWuL+bjXN2KHmrCwwPd8XS8GyOVYENOGbJNCnnD1XR78twIvF/3DsPODHe81S3JY9jX4/BPxb6KcQQOuvO2SiDM437hiQULTBxtA0yk/jFsswCFqUNjmFc2W3hmpTJ+wvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG5whBR8FhJLSwMRh8QU3MJmmfRGaBgxMpehBXOItMk=;
 b=tCFHl4l3+CrKgA0GJjgJ3QVMniGspi59U/UaSh/yjyI1hF1bj+z8Kgw/wJgHSq8K/y1rQWsLbD53Vnq8H9uS42vqyEzZ47Gxj4vMGWnBW5htEhCYFX6SV9DwEeQegswnjj01NM/4n/TCGrhipSd4RXPaUwTAfPuXGBNhgmMmQ3U=
Received: from BN8PR07CA0024.namprd07.prod.outlook.com (2603:10b6:408:ac::37)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Mon, 2 Dec
 2024 17:12:46 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::fa) by BN8PR07CA0024.outlook.office365.com
 (2603:10b6:408:ac::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 17:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:12:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:39 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:38 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 05/28] cxl: move pci generic code
Date: Mon, 2 Dec 2024 17:11:59 +0000
Message-ID: <20241202171222.62595-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df08097-5ed7-4111-6f7a-08dd12f48a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qhckp5o/lphBH+DDATZl1shp/Aqv6KGUOHTxf7dVoUN0fI9Mx/BIP5RbMjFj?=
 =?us-ascii?Q?/kFWFSr0hUBQOOsYuY4FJx5EZXSsKzCOjOG/EafiW5Voasx2aGwUyNyoRU1V?=
 =?us-ascii?Q?ywi3Cps/ocjWVszNNN8v7eKGgU+kISHHJY/FWCfTYxZjHaSxczb0zu77blIf?=
 =?us-ascii?Q?CZHB5hrPNqQ0qVMfcEMQag4esEqdV52otTudwIYfwu75t+alKnJPjkDDxWBk?=
 =?us-ascii?Q?t7L30Tj9zexklgV3bgXLxdCyUdR4R1cawhyLxS+mgYgjETYodhkRyPXFykQU?=
 =?us-ascii?Q?jaoLU9CqouEoKilnG591dEc1laUNkVrWiCNYA1e+pdO64QEp98HB0zgpmPAU?=
 =?us-ascii?Q?EonZtvFm76ikxapjK853HYbIbo57SzSjOdALm2LPIN78zhO/vWMsO3kfEjZg?=
 =?us-ascii?Q?2dLWzvR7ScQrZfRQN5xQdJgBNgDwR6xVo5/flYr75XlbWUr15qf8492fjhTW?=
 =?us-ascii?Q?AaUKraPhCNOjhIMaqHwl27xbCKrcQZkRZGMYdm2ORJ1GAxnp6eLxjLkarjrH?=
 =?us-ascii?Q?GERd0LFaMBuqBSaVfe0EyV6J3fcHJUxspsCHHNLTiN9R8Gts04xLI6MkyNR7?=
 =?us-ascii?Q?RVfv6CPN8YxAVGdhnOXK2JXzIug/O4733IkulNQP3MQlyW/bppad776aRXm5?=
 =?us-ascii?Q?V1o56rbQDyqZo8arelxoPaj/6/XVx3VKfdcs8uvTUfdC8BoI5hBiF0oIny/Q?=
 =?us-ascii?Q?ivYP8+hatjkAiyI7vZlUUS6HoO2btVatoJrDVwvbn/Js32LgVh7HWhVnoUrF?=
 =?us-ascii?Q?F+M76yXxNHxZ0yaVrKqHKY7IRcsridLBw7dsm4MlwmU4VYW+s5jXtqTFrUAD?=
 =?us-ascii?Q?uDAYBsoAwUroIeiQx/d6IMbg5h4V2i0QjuLXTq38/MSQ980QIktUqfLU225C?=
 =?us-ascii?Q?fTR5HmrIXtioFQpXWQFH4f2Ejdt5gLwyOC2hFm178y++ixjRdEqAWvmMHYvR?=
 =?us-ascii?Q?/Yzko+heT/aFqcFDAb0jOZKwGltVDSDPnnlZ++RZIr8GwwV4wEFoqRS4rZBi?=
 =?us-ascii?Q?dvnjvc8XZd/1NaqBXmXPwW7VRma+eh+lWkA39I1P4ZqGoP2AI2Uxa+sI5bEG?=
 =?us-ascii?Q?1Cj+24TjzIGaUn830HELDx0gA++F6Madi3CDL/l+xQPyH4eH5pAwRigiYraS?=
 =?us-ascii?Q?rTP6r3DkuVDXf+09gc6g/vHNMNJnrQzeS3+gOWL0Mi/hbMeWjeL0dwi32bnf?=
 =?us-ascii?Q?iM6TYwxaEbJ3ierliaBpKwYiM7oXHDDnPatEy4CyZ5ahch0bukU5eComu1ht?=
 =?us-ascii?Q?gnxP2D653775baeff77+hQcESSzxNaFR3Er768oHgVNuQyVOJchnThSq+FCX?=
 =?us-ascii?Q?AG2X2AGTpmhXVS1qa0Qf9QsMVCPB0xGYEjZIroSiejOGiKujWrhCeuFYw1ZT?=
 =?us-ascii?Q?UQB056VHMs9LZeZF6r3z9Mqk3bPfgMKJugye/8U2AZyGHwKRqHe+FxH00lfu?=
 =?us-ascii?Q?hFJTUjZLRtJJs6CpwCTisSkt0vFWUbqFDhe8TgbC1z49BbiABwJWXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:12:46.2459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df08097-5ed7-4111-6f7a-08dd12f48a9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci.c implements the functionality for a Type3 device
initialization.

Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
exported and shared with CXL Type2 device initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h   |  3 ++
 drivers/cxl/pci.c      | 71 ------------------------------------------
 3 files changed, 65 insertions(+), 71 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a85b96eebfd3..378ef2dfb15f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1034,6 +1034,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
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
index 822030843b2f..e7e978d09b06 100644
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


