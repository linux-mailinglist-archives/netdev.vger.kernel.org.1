Return-Path: <netdev+bounces-183919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91249A92CA3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F4119E7C4C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9482144B9;
	Thu, 17 Apr 2025 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y/4C1Dsl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57A213E67;
	Thu, 17 Apr 2025 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925389; cv=fail; b=ttvjAFyA6lCEoIn/wy/6uE5/aLrIj26iT8hXne9RNVc3MGHNyJTwCFaZ2qhjXUvG/tvxM9bW3YkEoztGrMpvz2dsHwbyb8rpYZu2IB2XWVd6ZsWJG0EFnJq0nmSB6XidE96Ys5Bkh1zPv3PdjPXts4HAehuxbKgFM2u3/pRijiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925389; c=relaxed/simple;
	bh=xmW9GeCBaD7gnV/sDT4RNbHVJX5GhOCOfJxtuo/EKsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5Ux61C5/IZSlrUiTbM97ndEoN3R1fEO8NXEybsnXBjN4HADv8xmuDL/p3r1IE9/hufE63LPl+fUzvTxKLyRzpBww1eI2hsZe12HNcTHRhytx27Zs44NrHig+4Hga49q686ZqXMR0DcBFGd5GEH7huANf4NYnsGFkAFhGcVN/aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y/4C1Dsl; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoZ/HImBGJQmikgK7TVxXkBauvnsUofDTpVJY0qYOWFDLqIwGcDygdVRpM7uOMGMsfth9tkrc6UcksczoPQn69RWjY3B1fk2tTgDT7sFqU+ho97Zhn+ELwyFbwVQZMO4nk1pGEWHrLWoKXgbZ9+zC+DpelcrsQ7C0YA5c0PxViTykSsxzGf/xt4TZrOQ6O71EZRUufjqSukyrR+BMsO/HHOv0MpfYoOtUjwlv4Q8zU86fK7xuzXl1rojTTrlcgAB6iQSfqSEst42+GG9SCYRU5VSHd8QXj5Sq18WYpbg7lBgKa/CeVuj3mcbMZylyrqPvAw2PEXLOYjyfT2uyQ/PLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CktgpoyAsrLwbKcHeF2nDTd74pHqj6ALI2Nr24H5F+s=;
 b=IughgssRe26GKuG0N2Hv0Nx4t5jt2yDxoNm9zqa+zfM4iWvxAC7F5h5tzNqP3A19R+HogYFWEmrqoaOR4WilF+YFb3HWuY2BNsXgCnJ5UmEoqhs6L5RPCVrPjYWxkZD8t8871Vvz8IyN0cr7odQvhd47o8YGebfCKd2J31Txq9OCQ8O+rdQaF/mXhHjbyEmd5ePmEJSwwf5XRu9utHEBEUzdOCrOd64HgMEW72D6vLoAQtpB76HZB3z1uH+lJGv/S1a+zYpFKm8EyA/d/msuOKqeeA+p+NDC5s6Nx5uK64RdMeQaddW281O9qnklnWTOX+Lg1B0LkQGSfS3qRJxI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CktgpoyAsrLwbKcHeF2nDTd74pHqj6ALI2Nr24H5F+s=;
 b=Y/4C1DslFW4u+ge7HMRe9DRcKlYH+02GbXUTTo73FJmpPuAPG25QIBolJGlc6D1jJ/qz6D68AV9M40/rRIU4tvp+vPcZTvI+9sxjzFNnCX2jbkpJaIFgkFZVUrrtGejiGKIIj2mTfES7XVlIn/FVyNkohAo/dmLKB2rckEg5GQc=
Received: from BN9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::35)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 21:29:41 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::b2) by BN9P223CA0030.outlook.office365.com
 (2603:10b6:408:10b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Thu,
 17 Apr 2025 21:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:40 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:39 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 04/22] cxl: move register/capability check to driver
Date: Thu, 17 Apr 2025 22:29:07 +0100
Message-ID: <20250417212926.1343268-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 570942f4-ec42-4924-31c7-08dd7df6f6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EYS+lbJ0dJzirlpycwGOdoO+RJVufCtLc0QjA/QZ2aDM98Tx03vpSoub2Vpf?=
 =?us-ascii?Q?sqR9YfwsZ9qgpo9I2uiOTHpRq2sBTLWT7aB1VO0s168mOoVVbW2B32R+Wv+k?=
 =?us-ascii?Q?+PeOCsdVqHnEjpW7rONtGSsY65Bd9TWGHZgGSZLmYiBgyGLH9I93zBIeUj4P?=
 =?us-ascii?Q?reQ3VQLwRwo9d1CQ2zpTaRSWeoZzL9X5iHmxia8/NOE69ZQIEZsz+/wSFGnL?=
 =?us-ascii?Q?WteI5f+oS5uLeQuy3l3dgc3WugJCqflPvxmecfP6xR+JR2NlsXwDub2JjJx5?=
 =?us-ascii?Q?dhDdq1dgQ9LtHNAW9DXKMO6/Qcld1KJq1GW/5M2aF+KNBXoJ4VuHEhjY2p/A?=
 =?us-ascii?Q?aWmHSPrEySbs4tvM89WTZPTtWqBP7FJOLtDmP1YCRn3E3PtGInlrzCh/Z8oo?=
 =?us-ascii?Q?tm2XzNzSFaUW7L5rVeWRhzIFtgGrb3bl0M66CYNM0+wz4R5CssWiK/+84HbK?=
 =?us-ascii?Q?oEkCogSPd7qlvjhhzIfDk68LjCv+NcZMfS27YxM/xIX9haOg4vigSXrGGUCu?=
 =?us-ascii?Q?6I/sJccyHJw3+Da1G7rY/fGPnZ1NYHm8ZMRZ0XLg+wzxMs/pbby4ozBfO8c7?=
 =?us-ascii?Q?r1kQwo3GG/iaOShwJ1jfpoC6tkZZWQDAx2KewHe2gTauqsOotyb8/2Wv4LVz?=
 =?us-ascii?Q?yU9TqCeoXkRzBQXKeWgzF1LnvUwLoYZJyGM+ln0vyNCVh1Q0U+OAcyBQPsXS?=
 =?us-ascii?Q?W++58f/BzQ1qMEtZFl2X6bGSlIabveRBU6DQMzveoWT2LLHBgYgSviL/PYxY?=
 =?us-ascii?Q?3He+jHO61K+JQc5tCBB+FHqG1eyjC2tpai8oLchjHCGQbkqUfMuVy3eIxW21?=
 =?us-ascii?Q?oASYbFRXeSwjGQ72nhTQsS5QVKz5584HMQRr2mYWkC/F9MtH+uUZ4cl9i8XR?=
 =?us-ascii?Q?vb3nBUOYVyZwpCd2OKI3axfO4n2nfVoAPgac7QCm43xgiPOOCnaffOesZb9f?=
 =?us-ascii?Q?K8J3KQ7eMMYGmdXFNm3NOXOBhuQn5y/Rl7WiEORT1cyjxAYFxGV+hwQiTlIv?=
 =?us-ascii?Q?9P2vgIo5qo6PL3VgPrGupPbwJNrouHyUxc1QCBDzLmX9N0ImcwWh68HeaR3K?=
 =?us-ascii?Q?xrRrHWw1puzUZhzESBbl7mmczVUl4NqSNeSz15yNvpnNAuyFL3LmXPn+iC5g?=
 =?us-ascii?Q?ZY9pDEdr59MUon+qYKHA7kZf/TLor78+atli1tTcAXpZ9aVT13bCbxdLLYeF?=
 =?us-ascii?Q?yTPuA2c8xDvyxrmJ+ZjM+N3U1/I+sa4OcFsvOjpWVcXbqP6kDHzZsWGRS0Zj?=
 =?us-ascii?Q?YiO9V3mMFBtbCCL/QHCz2sqjW6gfu0uorBHFNERzpQDVpDPXoBbMgFq2Im0u?=
 =?us-ascii?Q?uklGdrhiz9LeKoIpAfAFtbvkviSwae9Fay7c/U3l+y9w1NBbL16YpJW/+nHV?=
 =?us-ascii?Q?QXy99+BUibqP8portOBTZar6ERcCmwZCvIjy1YuZ7CCHMP5v18Q//4J2qjWR?=
 =?us-ascii?Q?V7k70eZ6U2o2zZBX2ilHcpQRLMUSlAGIujDgMwnFO+v1u7zPz7JUZRIojhuZ?=
 =?us-ascii?Q?EMYyyFErg5o4AYM/fED/iKUeLg9dcFREiJ4k?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:41.3033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 570942f4-ec42-4924-31c7-08dd7df6f6db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

From: Alejandro Lucero <alucerop@amd.com>

Type3 has some mandatory capabilities which are optional for Type2.

In order to support same register/capability discovery code for both
types, avoid any assumption about what capabilities should be there, and
export the capabilities found for the caller doing the capabilities
check based on the expected ones.

Add a function for facilitating the report of capabiities missing the
expected ones.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/pci.c  | 35 +++++++++++++++++++++++++++++++++--
 drivers/cxl/core/port.c |  8 ++++----
 drivers/cxl/core/regs.c | 35 +++++++++++++++++++----------------
 drivers/cxl/cxl.h       |  6 +++---
 drivers/cxl/cxlpci.h    |  2 +-
 drivers/cxl/pci.c       | 24 +++++++++++++++++++++---
 include/cxl/cxl.h       | 24 ++++++++++++++++++++++++
 7 files changed, 105 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0b8dc34b8300..ed18260ff1c9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1061,7 +1061,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 }
 
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map)
+		       struct cxl_register_map *map, unsigned long *caps)
 {
 	int rc;
 
@@ -1091,7 +1091,7 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 		return rc;
 	}
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, caps);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
 
@@ -1214,3 +1214,34 @@ int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
 
 	return 0;
 }
+
+int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
+		   unsigned long *found)
+{
+	DECLARE_BITMAP(missing, CXL_MAX_CAPS);
+
+	if (bitmap_subset(expected, found, CXL_MAX_CAPS))
+		/* all good */
+		return 0;
+
+	bitmap_andnot(missing, expected, found, CXL_MAX_CAPS);
+
+	if (test_bit(CXL_DEV_CAP_RAS, missing))
+		dev_err(&pdev->dev, "RAS capability not found\n");
+
+	if (test_bit(CXL_DEV_CAP_HDM, missing))
+		dev_err(&pdev->dev, "HDM decoder capability not found\n");
+
+	if (test_bit(CXL_DEV_CAP_DEV_STATUS, missing))
+		dev_err(&pdev->dev, "Device Status capability not found\n");
+
+	if (test_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, missing))
+		dev_err(&pdev->dev, "Primary Mailbox capability not found\n");
+
+	if (test_bit(CXL_DEV_CAP_MEMDEV, missing))
+		dev_err(&pdev->dev,
+			"Memory Device Status capability not found\n");
+
+	return -1;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_check_caps, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0fd6646c1a2e..7adf2cff43b6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -755,7 +755,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 }
 
 static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
-			       resource_size_t component_reg_phys)
+			       resource_size_t component_reg_phys, unsigned long *caps)
 {
 	*map = (struct cxl_register_map) {
 		.host = host,
@@ -769,7 +769,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
 	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
 	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
 
-	return cxl_setup_regs(map);
+	return cxl_setup_regs(map, caps);
 }
 
 static int cxl_port_setup_regs(struct cxl_port *port,
@@ -778,7 +778,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
 	if (dev_is_platform(port->uport_dev))
 		return 0;
 	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
-				   component_reg_phys);
+				   component_reg_phys, NULL);
 }
 
 static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
@@ -795,7 +795,7 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	 * NULL.
 	 */
 	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
-				 component_reg_phys);
+				 component_reg_phys, NULL);
 	dport->reg_map.host = host;
 	return rc;
 }
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index be0ae9aca84a..e409ea06af0b 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <cxl/cxl.h>
 #include <cxl/pci.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
@@ -11,6 +12,9 @@
 
 #include "core.h"
 
+#define cxl_cap_set_bit(bit, caps) \
+	do { if ((caps)) set_bit((bit), (caps)); } while (0)
+
 /**
  * DOC: cxl registers
  *
@@ -30,6 +34,7 @@
  * @dev: Host device of the @base mapping
  * @base: Mapping containing the HDM Decoder Capability Header
  * @map: Map object describing the register block information found
+ * @caps: capabilities to be set when discovered
  *
  * See CXL 2.0 8.2.4 Component Register Layout and Definition
  * See CXL 2.0 8.2.5.5 CXL Device Register Interface
@@ -37,7 +42,8 @@
  * Probe for component register information and return it in map object.
  */
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map)
+			      struct cxl_component_reg_map *map,
+			      unsigned long *caps)
 {
 	int cap, cap_count;
 	u32 cap_array;
@@ -85,6 +91,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
 			rmap = &map->hdm_decoder;
+			cxl_cap_set_bit(CXL_DEV_CAP_HDM, caps);
 			break;
 		}
 		case CXL_CM_CAP_CAP_ID_RAS:
@@ -92,6 +99,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 				offset);
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
+			cxl_cap_set_bit(CXL_DEV_CAP_RAS, caps);
 			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
@@ -114,11 +122,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, "CXL");
  * @dev: Host device of the @base mapping
  * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
  * @map: Map object describing the register block information found
+ * @caps: capabilities to be set when discovered
  *
  * Probe for device register information and return it in map object.
  */
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map)
+			   struct cxl_device_reg_map *map, unsigned long *caps)
 {
 	int cap, cap_count;
 	u64 cap_array;
@@ -147,10 +156,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
 			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
 			rmap = &map->status;
+			cxl_cap_set_bit(CXL_DEV_CAP_DEV_STATUS, caps);
 			break;
 		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
 			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
 			rmap = &map->mbox;
+			cxl_cap_set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, caps);
 			break;
 		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
 			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
@@ -158,6 +169,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
 			rmap = &map->memdev;
+			cxl_cap_set_bit(CXL_DEV_CAP_MEMDEV, caps);
 			break;
 		default:
 			if (cap_id >= 0x8000)
@@ -434,7 +446,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
 	map->base = NULL;
 }
 
-static int cxl_probe_regs(struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
@@ -444,21 +456,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	switch (map->reg_type) {
 	case CXL_REGLOC_RBI_COMPONENT:
 		comp_map = &map->component_map;
-		cxl_probe_component_regs(host, base, comp_map);
+		cxl_probe_component_regs(host, base, comp_map, caps);
 		dev_dbg(host, "Set up component registers\n");
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
-		cxl_probe_device_regs(host, base, dev_map);
-		if (!dev_map->status.valid || !dev_map->mbox.valid ||
-		    !dev_map->memdev.valid) {
-			dev_err(host, "registers not found: %s%s%s\n",
-				!dev_map->status.valid ? "status " : "",
-				!dev_map->mbox.valid ? "mbox " : "",
-				!dev_map->memdev.valid ? "memdev " : "");
-			return -ENXIO;
-		}
-
+		cxl_probe_device_regs(host, base, dev_map, caps);
 		dev_dbg(host, "Probing device registers...\n");
 		break;
 	default:
@@ -468,7 +471,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	return 0;
 }
 
-int cxl_setup_regs(struct cxl_register_map *map)
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
 {
 	int rc;
 
@@ -476,7 +479,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
 	if (rc)
 		return rc;
 
-	rc = cxl_probe_regs(map);
+	rc = cxl_probe_regs(map, caps);
 	cxl_unmap_regblock(map);
 
 	return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5d608975ca38..4523864eebd2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -202,9 +202,9 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
-			      struct cxl_component_reg_map *map);
+			      struct cxl_component_reg_map *map, unsigned long *caps);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
-			   struct cxl_device_reg_map *map);
+			   struct cxl_device_reg_map *map, unsigned long *caps);
 int cxl_map_component_regs(const struct cxl_register_map *map,
 			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
@@ -219,7 +219,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
 			       struct cxl_register_map *map, unsigned int index);
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
-int cxl_setup_regs(struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
 struct cxl_dport;
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0611d96d76da..e003495295a0 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -115,5 +115,5 @@ void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
 int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-		       struct cxl_register_map *map);
+		       struct cxl_register_map *map, unsigned long *caps);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0996e228b26a..0e6b63db684a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -836,6 +836,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
 	struct cxl_dpa_info range_info = { 0 };
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
+	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
 	struct cxl_memdev_state *mds;
 	struct cxl_dev_state *cxlds;
 	struct cxl_register_map map;
@@ -871,7 +873,16 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->rcd = is_cxl_restricted(pdev);
 
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	/*
+	 * These are the mandatory capabilities for a Type3 device.
+	 * Only checking capabilities used by current Linux drivers.
+	 */
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_DEV_STATUS, expected);
+	set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, expected);
+	set_bit(CXL_DEV_CAP_MEMDEV, expected);
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, found);
 	if (rc)
 		return rc;
 
@@ -883,8 +894,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
 	 */
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
-				&cxlds->reg_map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &cxlds->reg_map,
+				found);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 	else if (!cxlds->reg_map.component_map.ras.valid)
@@ -895,6 +906,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (cxl_check_caps(pdev, expected, found))
+		return -ENXIO;
+
 	rc = cxl_pci_type3_init_mailbox(cxlds);
 	if (rc)
 		return rc;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index a8ffcc5c2b32..afad8a86c2bc 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -26,6 +26,26 @@ enum cxl_devtype {
 
 struct device;
 
+/*
+ * Capabilities as defined for:
+ *
+ *	Component Registers (Table 8-22 CXL 3.2 specification)
+ *	Device Registers (8.2.8.2.1 CXL 3.2 specification)
+ *
+ * and currently being used for kernel CXL support.
+ */
+
+enum cxl_dev_cap {
+	/* capabilities from Component Registers */
+	CXL_DEV_CAP_RAS,
+	CXL_DEV_CAP_HDM,
+	/* capabilities from Device Registers */
+	CXL_DEV_CAP_DEV_STATUS,
+	CXL_DEV_CAP_MAILBOX_PRIMARY,
+	CXL_DEV_CAP_MEMDEV,
+	CXL_MAX_CAPS
+};
+
 /*
  * Using struct_group() allows for per register-block-type helper routines,
  * without requiring block-type agnostic code to include the prefix.
@@ -207,4 +227,8 @@ struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
 		(drv_struct *)_cxl_dev_state_create(parent, type, serial, dvsec,	\
 						      sizeof(drv_struct), mbox);	\
 	})
+
+struct pci_dev;
+int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
+		   unsigned long *found);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


