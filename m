Return-Path: <netdev+bounces-183917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEF5A92CA1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8422E92451A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1A52116E0;
	Thu, 17 Apr 2025 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uOfFVuDQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D6120E021;
	Thu, 17 Apr 2025 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925386; cv=fail; b=OAll6eCzDsd/ki8IVzQ5qMuxGHMJ9kFcUAW/kZ42mmOEVTAj9+2Gc0dsR+0zO2zPwRF3nyiFZjnCmCOOUw0LuVghX3FaNYY0/dIThGs0q3EDdy4qJwt412EpCZMExAcgGZvbU/3dV1K4PIOfJf+MFeLCtvVXAZ4UCz06vUsMMIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925386; c=relaxed/simple;
	bh=0W6hF12lxjQoL1/Ak+0hhoWvb4E8/aytZ0eJF4/LA4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeDkkrvlZvLqBsFzJE1eVv2igVnudBB1ygkUD1ydg8LdiblIY1Ha1zqy40V0U7hBh3wPYLTztbbi78+egJHOXmmmno0uUysHjruAf8I9iYILu1CiECtlzA8Bm0SkSkh17DZVSu50RtS2PBvOp7tuNa2KFPQACjUXkdqjB2yjjgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uOfFVuDQ; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UESyk+IrsraCkDwuTOn72+ZniujUEDblJlt5kkqnqyHuA2QQiAOEnmfdBTO3V0PrvQVxXiysWJEzu83BTmfMgtD4gG0lFZViQj1Csm1QejWrl9dlY+8KZTTjIBIwk2RWqyMf7GElJbZTK2ddQG8cptrIiE18Us4r5M7xLbSp3Dy6ITh9OAohlPdJa/fXp2geysLw9F7APRmjYzgSqiPpM60kX0bPjhDHHdpG1v2Q0R0aASqs7IApuE6piRAlnV2p+4zhcdo02pR7+0fg1KdoYnStf7smcxSSIT4gbll/FVVQF5EZQvLsAvV7sqWLlwoOAUPcOhWDn5Du6ea5A0MFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHF6QgPLi/C4nsmheLzABJx7ncfuBtWrjo2go0hS5j8=;
 b=Pd9IE3I1KK7pJVETQwn7C6p45qqS2/VZys8vz/VUihiUgzpX93cvGaRjOHlm3vE0WFQW6HxqNmXyzps7WAur/XZG3Mt9kJSFT2SkdKbFecawMMn4aAkiHRuu9IArrNh4L2mPdpNoVY4nZuZ27RC+6vg5+4Or8pmzbTPCnANT50k6TIZ3MFR6Arsg1CIVNKnxwGV0x1pc6+3cODJSjjBu3aHSGXqdZyOBvjNdvdhFMN9PuKRg/rp3QxQTFGW6Ol41wJJl3S+nKuRzHiK2fBldHs4g+3lvU6i9gqyeQE9vMrX4hSVIeCcazfhf4nrdaoBr1IHZIamp6DP8VTst9umGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHF6QgPLi/C4nsmheLzABJx7ncfuBtWrjo2go0hS5j8=;
 b=uOfFVuDQvPMGA0IENWDm4OzsYygd5R5dcujA6jPjMQNgDQjYUrhmJE4METAtF2QNxfVfVw2+r7fzeP+IgiscaPsBjMo6d62J6KS+a7PlfySm4p7Xaf1zcI6zrRMLefutzwxedyqVCnfzZIAFGIFO7RubNy+ke10gn5y7Nl1atQI=
Received: from BN0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:e5::9)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 21:29:40 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::e1) by BN0PR02CA0034.outlook.office365.com
 (2603:10b6:408:e5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Thu,
 17 Apr 2025 21:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:39 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:37 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 03/22] cxl: move pci generic code
Date: Thu, 17 Apr 2025 22:29:06 +0100
Message-ID: <20250417212926.1343268-4-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 253b42b0-df10-461e-51db-08dd7df6f60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jzp1Cq9oTvwDHJHKGhfwWzVG9qK5br7RvLMhXcDbO/vK7ixmtniDxjKepsbr?=
 =?us-ascii?Q?OT7RsEAkoMk12bXl/vRhKRnadVb6ukvPo39mr8IOlJpwxPDfeVM4xTyGg2Kj?=
 =?us-ascii?Q?j+OKHO3y+dOHmxgYCiubOBGblbsegV24Cx+0GPDPGVCvqFCfKAUErnQYNA7k?=
 =?us-ascii?Q?/fuJPIpL7wqkk7/jcViJnR1S1U3ImoCDj+g5SiDwgN/pl0uF8ytxF4xB97Ut?=
 =?us-ascii?Q?9zKtCHwc7zTMRAB5oYejd117A3VCuEBlQpE+gCtbHHsZ5E+oDgJ2aRHvoEGY?=
 =?us-ascii?Q?1rFfHTwSsm/Q0Kd0SuDrLDKYkMso8ALzjyA5idP7kpNFlyEeWtOxe+Si3SZa?=
 =?us-ascii?Q?Yb11i925hMimnJ5RNlQuQXt0jmpbvW8SILF18yOj/b6v16rPijCsM0s8OvKL?=
 =?us-ascii?Q?kkcZ/XS+bi37s3Q4fpOudaCztbJ151pJLucp0/q4aZw1L+8dIML4K7iKv/Ib?=
 =?us-ascii?Q?7Ifs/K2bYzoN+sSOa1wVe51KW5Fn3U+tuCVq5+x9BgzgD7HP1DE7V24LqeYf?=
 =?us-ascii?Q?5ziZiGo+tC7VtDqMcvtesYhen5R/2p40NJUkahReOm7y9JiHUxk4MfMwJGfm?=
 =?us-ascii?Q?gR6LtM+s/cvS9q5wZG22fUwOUmKzAteW2M7h6nfmao1bnN20fsWmglr8On7V?=
 =?us-ascii?Q?4fg283FjGO/CUg0P3ulpTSHsd9lMtoiX/WFvs5pEEmCOerlTMDRwMViEiI3v?=
 =?us-ascii?Q?Qe/a0fppnhh+Ayb32I37Zlplk+LBxkGcgeGDUeEvSID4McjvBEqpox6YsSZs?=
 =?us-ascii?Q?JjLlZ6AD8Pv04ADlCO5YxOicEiYlNKD+VJgMAMCwrMV5o4S+Obf0NEl6WkyN?=
 =?us-ascii?Q?DanGk9D27Ljk04BB5cmPjnNM87BouP+oHQeX4qR94X/QKfuxV9c+VqydpLo7?=
 =?us-ascii?Q?VF4V2m/RCMTOPH+lMqzWcw3iu+B2q4IjDOmS31JgCv65I2vYOPaE0ENhWlEx?=
 =?us-ascii?Q?dZwE07OLL9le0t5q3NPMF1mAuzKTNmGzqy+t963svW8FAEoTvsiTh5goWM5W?=
 =?us-ascii?Q?LpamN+bdiPL0dG70hZO6e/O4sOTN16wGndVemXY2Qcu9mdpKDWrOUou8SqXz?=
 =?us-ascii?Q?VGgmSwEJWyUK+CLOiBeAkKjZZTgSxj/8kFsboDzOVsFRr3h45cZ/5xXpJUsy?=
 =?us-ascii?Q?xdoWZv40s3WZ9AHuqZwz9DN9bWZfJXrcprwZjtwnHeLqNWrTHeEKmET3U2fY?=
 =?us-ascii?Q?e8iKhsSWGYz77/VPXNl72/M6s5yXRDCC6Hg7RLBqFnDjdJ/854p17oKtRB3W?=
 =?us-ascii?Q?b25aVaB4yPNzSIuITzN7u8j9YRNujWSKOzpp80jw9ysKxl61b/GuCxhfb6LF?=
 =?us-ascii?Q?HjW3cUMeZpohMhfzSS9JgXvd80D3J/L0GsuflA8Cc8X9v5+gAtPfFAAagaPy?=
 =?us-ascii?Q?dPv/4qkqEuXWjjU6Ewt2zZb+BoImpvKBo5yql1nwxMNyOUZ3OuNP+rQQJfo/?=
 =?us-ascii?Q?dVhJtGDaMIfuFr1InffQYvd/38cz0QPE6sju7uQNAEds/ABAEsOecJjONP0B?=
 =?us-ascii?Q?PWp7HwPge5oV4X/IJpWQm7PmTdchn83615A1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:39.9385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 253b42b0-df10-461e-51db-08dd7df6f60b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797

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


