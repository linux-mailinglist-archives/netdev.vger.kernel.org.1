Return-Path: <netdev+bounces-126212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9B79700CC
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D222B2096F
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719B14AD32;
	Sat,  7 Sep 2024 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w3/TTOC3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FC11514DC;
	Sat,  7 Sep 2024 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697174; cv=fail; b=bFtLOVl0DJyP/6V7GC/SqqNfQo8TmwinGawUdcjPy6hVLqGECTtQBUr/yIkrDQPOCL+kKqlS2VXTkWrfB2k0DlqM77aolbs6Sg7eBE7NFylSmQEl2vu1wkbJTMC96f7ZWUTDMJq3lzVTU9zHbnDfpUhQaeSeMxbH9OwCJ26kgJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697174; c=relaxed/simple;
	bh=3otBWoLSGTBRjmiQcv76bn+la33Im3oe3W7WLWidPNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/T1lKrm7SHoCiYYGnCB7Zc4JeoEOFCPEWxF+u7qnaazsccBXlIhkiXV8cbgGtIW5Y1LmsIwuYlyy0+s932b1aeMe1KZI92p6PFj9Um8v8sLw1CU/dhGWhctfvcQl2K35foFVap/jSwJlomHAgPXYq5Ap0g26IXlOZGcKJTY5+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w3/TTOC3; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFBXLeNAOUet0pFGRcMh7WJBJAVikOQVMA9zNtiTP1qabwMwoWjCbjNKXESU/u82wSnk/a6cxwhNhmQjtrFLQC4mhs5CuP/d9BPCCONcwaN6fVt42m+z6Qo49ojCGzFhu4oCFnwJ6u6yOn2FKYGkj4JHw+61h72kwAjo1LqZbzsMDLhgyfv9bqT2QojE/EnM7lPdxEBZq6vyhOO9CidzDWxx+Cgw/q34UFzNZ0y6+5ZQjSBo8tTn1sCy7aM6mMgcyPJRG7uOpqGIxBBOS6vmUx+vkDu2e9T5gHCfnkRaXZJlFq/mGVYqAFEF2ymuSaXFuIjtEc2oyJFMXEkAU7vSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXCSOC+JS45vGXTZsoVuhC+AKDjV+94ZBsPvmyQX/s8=;
 b=aKi6rc8xh7JqYKAkm1P6XuMJ5t/mCBwd9SsGgnptX3EJOt91t0LUdY+hP9Ju943DIa38V86Oi3/5/6hR+4vwnf2RRYmjS2cxzrGUzjW62yXBlx1+6iKLL8JCocgcMA4DO5NkFCRItInUEN/0ZcIds2mbCQx3SuOz9zV0R8+iJjsGiz+S1tUU+ehDm+mEgUUKKmQdDMqiH6qCNwX4pB7seAHlvw//QY6TsYA6W2gF3qeeObRI5xR0JlAU4g3mA7oysEMaL8f6EFs1BTcOgfDCgc9I37PL83ewvjW4LONSGrcUNfLWjn2YUU0CH+HZoncQwJVfBFmMVKxJTYnvqow+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXCSOC+JS45vGXTZsoVuhC+AKDjV+94ZBsPvmyQX/s8=;
 b=w3/TTOC3bdNMwzOPaXZcgLnVMjOSomP3IFN+kd/B6xeDvMRF0YHmEroxT3OCcGIkGMoW2MEF3CekJLKlnUSbBYsK+Ov2PdTEWsIGhf9eAP7ZOuZ/3JIa/sOkx5Uo9HlIXabJnlB/KjH7MWMiJOmAOqnTMmN5K7oS95IS7nonzxI=
Received: from DM6PR03CA0050.namprd03.prod.outlook.com (2603:10b6:5:100::27)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sat, 7 Sep
 2024 08:19:27 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::23) by DM6PR03CA0050.outlook.office365.com
 (2603:10b6:5:100::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:25 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:24 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 04/20] cxl: move pci generic code
Date: Sat, 7 Sep 2024 09:18:20 +0100
Message-ID: <20240907081836.5801-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bd8324-dde3-4341-a7b2-08dccf15c9b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bMeMRUPQspkDvaOdU08H6f7T5bnheRzbdgp7uImCYcEi5i+/gJa0AXBE1bA2?=
 =?us-ascii?Q?VNo6/geWLLet6+HZqXWt3fbXljilDjSwHwgQjkLbKBN8XiTyelBHl+MUo+te?=
 =?us-ascii?Q?gG5YRk077jkGsmMIxVQo1nvHvYB9TRwzE/v1sGijGeaJnkrPb3Tdg4jfJWWX?=
 =?us-ascii?Q?vE+1a/K6zFW10Dw1a9irV48Y9oR+uEc87z1G57NkYf9h6OE85gn7a4CEIKwc?=
 =?us-ascii?Q?61W9ri7+53GT61a/4eJrG/oDtmLIEJSy8OCV7a4DpXGafLpfHhQBZsc/y612?=
 =?us-ascii?Q?jdYh3ZZpSipyFc96uY3cJxQ3geB3gb0VFMslmlykXYg+NaqK4eL1ggeYOdeM?=
 =?us-ascii?Q?ftYpVA7cQ5CvgxRcGoQP3xP6rXH4u4StcMWfj17sPATe2FWm4FoO74fDVXYc?=
 =?us-ascii?Q?z6z3sQeTiZoZQ2aLATmkN5E0/XG9/mHNiEtpJ6mjHQ2uvLvOUGyUfdjCLHNF?=
 =?us-ascii?Q?xvB4Ds8b8WKGpcB+6dcubIs+bgtumPckZkccb4J5tC7ryy+K/USsNcjFlW1G?=
 =?us-ascii?Q?Y7J3112ic9JyleJilAw9Ag7w/ES6vjN/oU1NpMQq1nYV8MfUe+koLZwZvp3e?=
 =?us-ascii?Q?8YSwXFe74znu0HhvpK3EJc/odG/mNTqtLTz55GRYUa0O1fDJmBnYyAMe+OT6?=
 =?us-ascii?Q?p+NCTJMOpRDZKQ2KquVd7RxxSPDvCQXICo81k98tNi25RSoHd4URxeevhG6V?=
 =?us-ascii?Q?Hx4jUOMKgAa+GDbJ70iyJHo0L1NDz1pxd9T0uG4Kfcc5AoRrOvvawZsCHCBg?=
 =?us-ascii?Q?bJb7pWtjrc3gHIrGpmromTYcLtUeCT7io10CUd70x6p6mm2u8DVA5bCSsW68?=
 =?us-ascii?Q?imOwCNA93Pu5I1IgsO7Ak8FbwTAA/dEhe1fCdzieLjDTjt+Rmk6vdXNAhI3R?=
 =?us-ascii?Q?Aycb5GPi9Xv7RWeo0sUgl+pienAXgJ4zCcRevee9lD7zAtEwzfMZLVpYjIjM?=
 =?us-ascii?Q?l0+ju3+W4v4J6I74Gv3vBz5lDD3SjFxkUV6x5gTKPyEoCLV/U5DEEtR5RYMv?=
 =?us-ascii?Q?IQRL2TJuL9drfvUdzgqPjd07RwqPQHzFNTT2AwAauPKt8LzqT7b8UTy4sKrG?=
 =?us-ascii?Q?qMSuyaOG8S8hJC0cWPx0bNfMj3xHXBNb/bOnlZRH1NP/SCHjyV3woFfA133Y?=
 =?us-ascii?Q?GQb+CxbNnE8zkpXX4PDYugx5+il5gbaMf76AN6c1GsPr5BWByAnzPuxnyTtc?=
 =?us-ascii?Q?kjvjKbS+SMxktgFhEfWZ3L+VSG/53KI8MWuE3hWdu/u/OqdIEpwtcD9DUNvd?=
 =?us-ascii?Q?5qJrGFMGpj7B+u2CZyLqD11sMFMhGvLpjpfEWTIQ/c+gQIXxyMAGBYIzHzLG?=
 =?us-ascii?Q?Jl4aViVrmCuX1eHhMM7eRe/XzQ1rThSwwg0C1ANmb4+sAgz8nfVx2lKhozM9?=
 =?us-ascii?Q?AB5FN5NUhBoLq7fdbVqvo3Uo3xvjHd6XEWPmLWj2xI+bKXJzmqeiGvDmEQ1p?=
 =?us-ascii?Q?xiv4NTNGt9uxtoY73UgDSH0QTDHk2bBb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:26.3578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bd8324-dde3-4341-a7b2-08dccf15c9b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci.c implements the functionality for a Type3 device
initialization.

Move those functions required also for Type2 initialization to
cxl/core/pci.c with a specific function using that moved code added in
a following patch.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c | 63 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h   |  3 ++
 drivers/cxl/pci.c      | 60 ----------------------------------------
 3 files changed, 66 insertions(+), 60 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 57370d9beb32..bf57f081ef8f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1079,6 +1079,69 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
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
+		       struct cxl_register_map *map,
+		       u32 *caps)
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
 bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
 			u32 *current_caps)
 {
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index eb59019fe5f3..786b811effba 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -113,4 +113,7 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+bool is_cxl_restricted(struct pci_dev *pdev);
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map, u32 *caps);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bec660357eec..2b85f87549c2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -463,66 +463,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
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
-			      struct cxl_register_map *map, u32 *caps)
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


