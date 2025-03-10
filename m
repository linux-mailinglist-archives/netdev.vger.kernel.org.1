Return-Path: <netdev+bounces-173655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385BA5A57E
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C1E175057
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14811E0DDC;
	Mon, 10 Mar 2025 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iSJQkvui"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A551E0B66;
	Mon, 10 Mar 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640640; cv=fail; b=i64G5BNuBIB0cCTdfdnKJwlXNZfNtATXaLqpaA1fxE1nE+AOdgcbiCpORTXZ/77XpvJaLUQr2WcaV46SIBuyLwiB+Lxj6SFDcJK9M69CWibxOyHv5hqUaedWyRp/DHMGGdwTzjKlJRaQ4FjsXG6eqlJxFphWEO71d+R4vgpa3Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640640; c=relaxed/simple;
	bh=jwmUpEQF8U7FhVr8E/asAudAZgEQqcMxp4/H0vD94YA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anzYx4w8QenZpRh21aZ9lzO5PuYdeCW01N/9qV/gOFdR/o1nZ32uWUdNNlFDqzYqMxlYRS8VjMbr0PKyabxEgXuuQsji64HRzFp9EmDoo4/Uf1RFiuoXvouhIRVr3aGnw8pwcrMzjl/cV768tskr1f5w1mLdKsvPK3Dk+T0k/+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iSJQkvui; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RijxcrWVLil8RO9QVRpy/ueKtyo7P5cc2Ouq9o+zHwvDeXwXX2KPGseSD4eBCIvqnXiQ5OOYbYNTVmd4yJ8+kU3M+eF9mhbIoi1iZZHDRhWXvc1pliVX7gamvcgap4g3+TuKWwgSILJuCA9WzYX0+DtDymLKa11uPrbAOIql4TUfcQOo7FjZ+mQiGTv7RefP6boTrWSYY/GRpDc6UUvsLG7fCkoAmE5N3Y6mHSdGfKI8nI9pj/09mYWnT9I4oc6EZsJPqkaPnv3L+5trkJ/k+ROfQDUkkhFBpZpBgusg1rbVbsvJkNrYkToNaRQ01EuDOVtSVfJ4yccTK7ZK5+X3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RsSjQtmDXW/qCqfXVVLV2kL0RdmhHL3xGIEpVixYu0=;
 b=r6qJ7UFykUY3rwr0xNolOEZM6t6mT9Zmvo39hbcDaKNOVbJ3lTCMPGt7IZQahjCAiEbo79xNSPGDmAr0t62MK+KUOL98AiqQ71/zxqfletu1dyDxieTIhXJkj5Sub/e+XYNKhYuDBriDitk9dcwcMNuWLBSIstN/PaPSazhcNSSBCRsT+pPyvENDsUzoko9d22CwaUrFIURMHrk5x6NoDiyAv9qxM0EFu+S3QGvFk0Bgp7V4KQmpM/ir1kibO12szLOAhQgNsfCHT3OkolR8TaeL3hXmshq7YVMxgPjGzjiz5AMVgssfsjGps0DUDDA9BGEZOcS1PdGZu4jg8OhdMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RsSjQtmDXW/qCqfXVVLV2kL0RdmhHL3xGIEpVixYu0=;
 b=iSJQkvuiBAx6ebiTWYTDcieJ+r7ToNbWF/0W/SjUOU+/LZwy0mWTFs9hRTiP7sZs1UnW/vjc4ZBFj7lPASXtIAEfkqPk7KmHJKjdkQqyNxGwjP2ozbk9WPhdKHMWQtaPdk1YsZwHpsdL/bw+231Q5qMcjEa+ZDAzfSPUaOSVi2A=
Received: from CH0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:610:11a::29)
 by SA1PR12MB9489.namprd12.prod.outlook.com (2603:10b6:806:45c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:03:55 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::f4) by CH0PR03CA0345.outlook.office365.com
 (2603:10b6:610:11a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Mon,
 10 Mar 2025 21:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:03:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:03:54 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:03:54 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:03:52 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v11 03/23] cxl: move pci generic code
Date: Mon, 10 Mar 2025 21:03:20 +0000
Message-ID: <20250310210340.3234884-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SA1PR12MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: cd44f330-d83a-4e2a-ec5b-08dd60171168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3qSl3EVVac1V9GSceMdPc4K+CU/rRRoGNnoFFeawPoVVgSgbv7AXxQuyXFCz?=
 =?us-ascii?Q?wSCHJbAKtk8KKlSCxECHCxWELHX3r3iHcfrjIHSqhOso5ekcJcpvp5g34FyV?=
 =?us-ascii?Q?si8f1dFVTgcs7T8v0bt2Iq3ErlfDONXab6x+a3rjQH2XhXWcPKisEi1x7/Yk?=
 =?us-ascii?Q?km6lHgKUvhm680gyKhehMgloxRurc3d4ONXqC7U6/nAHKPSf2t3OOuqdZJKf?=
 =?us-ascii?Q?YAPpdJxQ2BVe31YKtv7V8bT4E7MqB1MSSXZ/LZuOopiW7AC7Tfxv/lOR/Z6a?=
 =?us-ascii?Q?+ooo29VTs2G+WlnlBqa4sPrzNj1i1WcNgKs9Uz2BZBaJOyGdHDpdgfROSi7I?=
 =?us-ascii?Q?AMjUwAlfLILoxAuP/ORCmy+BUcVonWXOrOUR7uFSfTEQtQC7WrUW2YnVsC4r?=
 =?us-ascii?Q?+eVnDIq4aLOw1o57unkDcqvY+Tm7S4CbuL8eLcR7yDXuwbfiiLDSH9izcGzh?=
 =?us-ascii?Q?KoqgiisVzQh2H3UrgzFMtRuxIHzYe6WQ8JdF+TqrY+pO6NEJwQPZrcyd5U/y?=
 =?us-ascii?Q?8uiBTzy0hixxUxihhOtDX73KWTaNKgWcRL6EdBV8AgezyhbW9nNa9B765SN8?=
 =?us-ascii?Q?mcfOPXHRBprpGrx8Epgf7x/rWdDV0Fzkrtc7s6UUisZdlk5xhVBQSvvnukjA?=
 =?us-ascii?Q?kzXVHI2O8eaWgFuuD5klE/iy54xlkIG0rQqiYAxYm+ZgFf+d3624up8oKfH2?=
 =?us-ascii?Q?mad31BBMK/mOPFFRcbdZZkfEnmY/lbOhRp5pNr13//7UmxTOuM1WsuBD+ySa?=
 =?us-ascii?Q?QffL9C9aZKq/jhj4AC8KoBWi7YLUsr3LQQQMtDq3XhEuzOLPA67+Ac0ixW4T?=
 =?us-ascii?Q?mxguMjRkwDCtSMjpGEj6P8Z0luN46sak4vUX5Mvae3Y3ELxgok4estrgwgb2?=
 =?us-ascii?Q?vsBRqx7jJXzT0a3FY4mf9KzERXkNT/+zbrsphwOuHVYQgPP4lITiDRDNUFP9?=
 =?us-ascii?Q?DbbRSQrXrHrE096LAOA0AiWTkDbu89nAwzKIaq3QwIAIT9k+EjyGHp9QKBzP?=
 =?us-ascii?Q?hUdC4y9OmGLDAZ123amBWqLL9Y0ZTDBT1UJ98CiYfdTbj8gqKhrQ1HtZBz1S?=
 =?us-ascii?Q?DNhyfNtoZ12PvJWw20sTOUEpD91Nwie/PZ74xNYuGuYOnwYMaqJ7ZicQNZWP?=
 =?us-ascii?Q?eoUnng7QHoQPXtrJ1ux/I3P1PdJ+yUOBcU3qXjJ1ncF3e+Prb+7t2WJksgG2?=
 =?us-ascii?Q?vFeToQvasggqgd9fz63Ggrr33uu3KFo4WO6S8GZmH2wo/GJUYtc9G/oYFmeA?=
 =?us-ascii?Q?vb0DM3Co6bF3jV5pe7ZaLgwgCa4yNTFFcQUVbB7PDIPIJ0i0wQQHAsv0wNGO?=
 =?us-ascii?Q?UXXgKjuQEFH9xL1MF4IUIXv5/62p1fE321u304fC+HSVFCuNKvP7Xqxf6CvJ?=
 =?us-ascii?Q?NEkH3+18uSK2E2oT4KKztuTLypnKTkmtwhcWbkUT29sY431x7vqElcagKhN2?=
 =?us-ascii?Q?+tortbjJCzg+gE+It5FJze5rgSiMRnDy5uAC7Z8Ol2IWUWiNa87pS06w52Pm?=
 =?us-ascii?Q?H3fST3Cg2Fo96Vc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:03:54.8300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd44f330-d83a-4e2a-ec5b-08dd60171168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9489

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
 include/cxl/pci.h             | 17 ++++++++-
 tools/testing/cxl/Kbuild      |  1 -
 tools/testing/cxl/test/mock.c | 17 ---------
 9 files changed, 81 insertions(+), 93 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3d3b00835446..167553d8f10b 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -109,6 +109,8 @@ enum cxl_poison_trace_type {
 	CXL_POISON_TRACE_CLEAR,
 };
 
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
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
index 769db8edf608..e8c0efb3a12f 100644
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
index ad63560caa2c..e6178aa341b2 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -1,8 +1,21 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 
-#ifndef __CXL_ACCEL_PCI_H
-#define __CXL_ACCEL_PCI_H
+#ifndef __LINUX_CXL_PCI_H
+#define __LINUX_CXL_PCI_H
+
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
 
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index ef10a896a384..f20df22bddd2 100644
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


