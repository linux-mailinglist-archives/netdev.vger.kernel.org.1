Return-Path: <netdev+bounces-154574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 496689FEB17
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F23161EAB
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968E119F423;
	Mon, 30 Dec 2024 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wKY1E5oZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A46319DF81;
	Mon, 30 Dec 2024 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595112; cv=fail; b=iMFId8oFxm36vghFCSg4mK1/lQ4lhnqsu37UNcvjcpplJaBbnjLvHXrvfQ47hXLCQWdoPMVFNifKyB1KMTWcjTWACGeNVi8xR5+Wa3+SyrLxKC8WAnw3e0fv/xCOSDP1QEDloyiJx38JfJJEX+KYA0PtALiCTiDZeevRetHfcTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595112; c=relaxed/simple;
	bh=YX6Ey//s6CczAE1bVz307bJZaDbNp7q98Q+J1V1Q3Tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPW58Y/dF8CZrdyPCeNCYr6ek1J9C4qaMUqlZfZznDOHqa2EzSAKArkERUVdrsWleMHdY7o8w27w/+FZRbJJgH9m5y5hjrD22t64znWrl2OR25pZPNKNU61bt5+WPX98HQS8k0UiwDln1E/ei5jZkOk+HjXpl5/r1YaI36xx/GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wKY1E5oZ; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5dBS1o5e7amDoZaU+zNphntPGbzttTRZXuqstwfPxru6KfF2RavrRJPJGKJIEg8Y2PMwvJLaQfZcv+Ph5ugP2Y/SOrZeFkiUDuGZXg/fFP3hI41Qen8nnYoo+1wQAsgofhAKkXijj5dITbYKXMY88k1uWkIcT+58alJjzBrQDNTGLIhe738llzIf+rXHvYtVtAH49nme4O5gnUca4lUSBN2ImsLcvjGf3twxtFdx9ANTm7gySPnuHKStKLMCLWUM9kIQPchbHYI9Mo4I05ZX/6kLTaJ3+i9seKOyYOqW6D9nAOgrIYtd+Rxj8R6JAATmQQ6X8pxSIBFEBBZaV27/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=be0bszA6xSarW4w/SYPDQwBNa+TIsKwXq05+7CGk0ps=;
 b=xxPJnpoori1ycs3B7yPo+CxuJf5lz5c96fOkBeEXvXRbjdvGm/1u2envo/colL0oEKhXOPq5/htL/f/MHSTewrXHdyim1V8jG05UC6aTtCY6XLLPn+YAONDEEURxisH5fW86vaewI2/uaKqVhzWqsb8gf2fgo4ePvqRsPmapeXRSuRN4eExLkdTzJLtCsP2Z5SLawamkbKM1RvG8J/ieOTAwZN4w8zAsZ2iElRZC1+/lYEfVA5sy/zMCf9PRpdvJjBjvanSJktTq0VRId9t/+NHJOusLGf5M/5nmbKfzIcEhk4IIAQjPTLzAwzmX3yi6lPWRcJOYjvk7auvkZZJJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=be0bszA6xSarW4w/SYPDQwBNa+TIsKwXq05+7CGk0ps=;
 b=wKY1E5oZ3K2lMcXFWAACbd19o0ujJjrw24UvAQQaItSydMHeeBMLq1qkKM8pqCmTC71BLvpRewyJEvHQiyptZsXcUzfKmZ/Z3zbLRvLadniwyTPPjp8OiigGc5axsNk96O6KcoEBJvqxjIuzeusXapyulVcdtw6d8bJCbcWD/H8=
Received: from DM6PR17CA0028.namprd17.prod.outlook.com (2603:10b6:5:1b3::41)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Mon, 30 Dec
 2024 21:45:02 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:1b3:cafe::a4) by DM6PR17CA0028.outlook.office365.com
 (2603:10b6:5:1b3::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.16 via Frontend Transport; Mon,
 30 Dec 2024 21:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:01 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:00 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 05/27] cxl: move pci generic code
Date: Mon, 30 Dec 2024 21:44:23 +0000
Message-ID: <20241230214445.27602-6-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: b54f97bd-c9b7-42bf-1f26-08dd291b372b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aMg4G/giMbo74L+Lna3j4eLEwW9PdKdbBtTanSqKXiUJiikQAJZteyIDL/uJ?=
 =?us-ascii?Q?5yOdXUvAVVA8WmLCj7pA5AwIafd03t79DN6jVLbDPYB19D6+PDjllA0JWwa5?=
 =?us-ascii?Q?Bv8EUn00vruLFXh8IvCjim7SRtMj3OCKqACG9wY3axwUoj0BFBevv1236UxX?=
 =?us-ascii?Q?z1N/iFl+j2a038cB9/WtqD4Pq+Qu5l1E7SxEqB6qgj4bqCJSPykwamAiGp34?=
 =?us-ascii?Q?BvLa7R3htgZ1bOoryC8JN8S2yqxwnmITb2WigOPwG69zS0DToVByPL7SxXC1?=
 =?us-ascii?Q?+p273AUUS+PLYqsSqJg1DBEGQBzZE+jFLVrDDStCIElZBiycb8ofGE33UTsH?=
 =?us-ascii?Q?+DV/Z7l01TXIbp54LVAucOfBqyVYLQqemtBX1hezEkeS3s/hKKG9o3BCr4oU?=
 =?us-ascii?Q?21/WB54RrUW0ZpvP0J9e0Sf+nwVui/lIB6/anmmQxlY2U61yJWWcKRVskuRZ?=
 =?us-ascii?Q?e8kETX2Ob/XNMaktyM/qhS0dXoBZlmhEhC74Tu0UtNB96ogdcJb7xv29rTNw?=
 =?us-ascii?Q?K1SYc7Di8j4CbuFrBmFaptcmDFaJujnh5TdlUCzOYq31Pnuf6/REcK1pFL4u?=
 =?us-ascii?Q?VVi4mW3/c/46g3hjjIRrFLLxU9BfdhaY6j2YxPgx/4nQHdBDJ8Ell60KVMLj?=
 =?us-ascii?Q?EtdsOBhZ99w0PZtFkGKDJwW3PLDphyo0I/QuyxhSf2qqtEn1uUlNWsV9kmYc?=
 =?us-ascii?Q?zKVUru+ui6JcOAI2ux9iTWa3FoR5vM/eSnCIDIO+6DeevoD5lqp/r9P8Xbuk?=
 =?us-ascii?Q?b+oL6c6WYZcF85TvSTOXgpIPc6+Cs35F41CpW2BkTKF+NJ97mzf8g12aT+Mu?=
 =?us-ascii?Q?1fDEN9i22eu6Ozh9m8SN1YT+BZ22zm8HkIAjQ+VW2NdUyyV9OuKWeH1NM8Jy?=
 =?us-ascii?Q?sTacf6egcz9C4hcYd0SdeU+cqvHfgjSTPtJtFfj5YPCl3zhCR35RRkBoCNO4?=
 =?us-ascii?Q?WV6sDFcD+1/JTZdGS96ED6BSN6epkWODTuRyevCxYj+2maZzsuQ6oak2WVzo?=
 =?us-ascii?Q?1yCRkhj8NL9qd9giLNlufrr7cTQpS7zdez4KRyybtuKVEuzXkP+Ig19gPfjy?=
 =?us-ascii?Q?kfQnfbmgyern/6MBZnJbJiz/gK7KnGNMAHz9djWUQmpcVDXQn7ouaQUP/n9a?=
 =?us-ascii?Q?7Z7TKkOFafRqI9NGVcj9V6CiacxwS8SAkM8D4Uls3FaLzN47sBlVfaq+2VZa?=
 =?us-ascii?Q?I3xEO0FsHwBMBXEBXhzUoi9oxJe3YlVyY6PChPFdmrXEdXWNlmReYsNHZHg5?=
 =?us-ascii?Q?nVE0HSVvoWyYc29gRUizZRSZQ+MTS5EjvrQmGfXqNV53OGasXw0egOQjn9c9?=
 =?us-ascii?Q?cNS9SrFiktsSJXovRI4b0YYPTmfSvidF8I7eE3OvSOOXBgGAoUVUGflY4SHJ?=
 =?us-ascii?Q?kJfLsWZFNuCHhv6xmcx7UmDlfXl7kstbLUHpLvm2Ns4b/rKatrPTx1KsUX7S?=
 =?us-ascii?Q?aK08d9kbMbQuGyELEXOOC8WkcWEeF3k6cfuh90ulivK55CRFvcvqRGmn5zlQ?=
 =?us-ascii?Q?tAlX5Z0T35UIulM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:02.1813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b54f97bd-c9b7-42bf-1f26-08dd291b372b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348

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
 drivers/cxl/core/pci.c | 73 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h   |  3 ++
 drivers/cxl/pci.c      | 71 ----------------------------------------
 3 files changed, 76 insertions(+), 71 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 57318cdc368a..5821d582c520 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1034,6 +1034,79 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
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
+			      struct cxl_register_map *map,
+			      unsigned long *caps)
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
index 9e790382496a..8612c3c30e9b 100644
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


