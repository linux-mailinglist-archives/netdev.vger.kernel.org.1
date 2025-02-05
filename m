Return-Path: <netdev+bounces-163043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947FCA294D3
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444BF3B0FBF
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9441918FDBD;
	Wed,  5 Feb 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y6tCe/5Q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C418E756;
	Wed,  5 Feb 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768814; cv=fail; b=GyD1QM9WYxhQpQoo6ft92bYDn2pHEu4ATqm0buMerctpMF3EISYF6ux4hI4Pu/qS/TKAyAeCPCzaxv5L9PMugF+MDJvzw23G/oehSpOD9faur51PqfVUPCIWQcVOTUiKNOw+giv1G2ar7peM0mNgwMIYk0cdbFM+dfOwVkUoFco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768814; c=relaxed/simple;
	bh=yBYzvQAZNMJYLRMc7pgJINp4ZHGRuJKIaI0PFgOmWn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJAuhWiVfOlqHssAd/WelaZOJ2CCVpU9EhVx3SVJj+3sxGmhZXty/cImRZ3evaDHWMvBxw9MmeHEHNRnK1t+BlPhktyeXGwoO3lDbDkWgxqmYR2f4bJtVb2/H+nb0O9kbb0DGJYc+cXmcGCzFGKUevRPC8lWZLOto331TbsRTnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y6tCe/5Q; arc=fail smtp.client-ip=40.107.100.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMxzSzZsa4mmdgajeMzPe4WdmD5es1wXNVfXXQ0UTrgipnZvxClatjHzwTkSiU4RXAiYnjuNb1SSO5KbRBEvI/wtE6FnQR/b9bp88DSa4LfrKSIS0TinaCqx8LXHuUXPEPoitwxMwH9/X/G91z9xltbnLE3xMkw7monVNTVbWQ5CEaN4rMUYjxdqlerzRNfeNE1MHH5W7ua7tDDBLm6vNoxeEZ8+Uzdk0qekbPDv5kIhvANyF07o/QlobCEJl6F6TnTvHnRz/cnkGga9oR5gr1l0/MJy902B7SIZsGBsu5d0NwbeGo/TbjCTnHa0F9bXSS1Aoc2/VZJQT5t9AvaY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdrR4Crt36NSjzIwRKQswa1ScHWLc7npWhcd7KCQ+20=;
 b=u/ETHbdGOf4OBVgIriqoYjUvFXgb2VRGhpIlFxa0QrGGdNpS8ES/0JhBcsOf+RB67VjWPb5KX2IwMJauUO15EWHwX+nYA1phEOHuLfeFdUVPAzotbNDpwVJveZ0X4sbCRNg/tx+/4hYAKfZ1LCKDib2gNaQFxY+mnFZcp/lY0/DHzdYOh4qp00gljL4Ymcs+LfD8M2kwKmrlkeUUGZ5WDA6tkUKKY0PHf4mXDk8cPfM5MYn9AMipEo9pI8SUZRvoTvk2ETnwxtVaFynhH5W2ZgHqbVJU/QO0DbKtVNHeUgGlTVOJ65aanIW7ygYM/YTZ2FPkIgKmDNXTRzs7bFjFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdrR4Crt36NSjzIwRKQswa1ScHWLc7npWhcd7KCQ+20=;
 b=Y6tCe/5QWgsM1Va1aMUlMh14dtkE6Ad0qZe9cswPOd2VVXiHs6FaSSTZihGoZSI2SD4kYRg93p6xsxjC/O54ahsaZ8fHfR/HL+j7+kFgWuGz/NWKDmIt7DaRhj0uS1u/YSsMT7/vmHmyIQQtKISwdKuYLR4EZpyqNVzw7EMcUCI=
Received: from DS7PR05CA0097.namprd05.prod.outlook.com (2603:10b6:8:56::26) by
 SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.20; Wed, 5 Feb 2025 15:20:08 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::c4) by DS7PR05CA0097.outlook.office365.com
 (2603:10b6:8:56::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 5 Feb 2025 15:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:06 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:06 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:05 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 06/26] sfc: use cxl api for regs setup and checking
Date: Wed, 5 Feb 2025 15:19:30 +0000
Message-ID: <20250205151950.25268-7-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 9271ec02-b98c-471b-d1cc-08dd45f892f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y24a+irEZd7YKwkJ9Bp4bTB1CNgf7slkJy0ZQbo9heEk1Lt2VvLGnxxbbU/3?=
 =?us-ascii?Q?6Km4w+fTFLTdz2jllkaRGTzl4tBrynJwYYewOTKpAaEBevKsEsFAoNOny6qP?=
 =?us-ascii?Q?HfeypqEuEjMK758jpLEzNQZb6/xDMZT34kWE7trN7xF3SWKeBsjNfEodopnW?=
 =?us-ascii?Q?gXFs5PnOvE6/7SD0uuUABBfGjKk7jDoxs1/9RX7nrHqFnzF+81y0pOydzh72?=
 =?us-ascii?Q?EKecCWJ0DRZhlGuFmByBHX4/COEY8/PEiST35frk2NuVHNv6ETzJsGLoUaOw?=
 =?us-ascii?Q?u171X0SgyhHdnpMpESuBYy+0Uqv3XJONsh7ctX1LNSAsJb6EYQpTvuJfpARP?=
 =?us-ascii?Q?66r5x4X5rbZ/lENOfRItqqnGB/l8JculXXAWDUX1uJa2KWmGaCgMktKNB+dw?=
 =?us-ascii?Q?7z+kWYQFPHO55dvzTbI5pogdzNrDuHjiz2fi1P5DRmohr2dV6+9iuNlLILrK?=
 =?us-ascii?Q?4s2Cao0UTR6Qdt2Cc4urEm7pb0gWV/YLhdOXXCaG5AdpAPSXBO8nJXtT/ViL?=
 =?us-ascii?Q?lz7xs7T5lwcMahW2m61k6INQc0wOV9yJD0XuxH73uey8NWRd4Aopxln4MX0o?=
 =?us-ascii?Q?zB3P8xk+rV1vm58bWmDK1wUbFw82HYsbx1+iDF5J4fb2O62jAZg+H/TWlORC?=
 =?us-ascii?Q?EFIUite4QJKfLNFJfk8wR1vaqyBA3NgP2juD3uHo5WE6RGErSk6EMzm/E6ih?=
 =?us-ascii?Q?Po/uQC49CPdryZJ+q/pUNOH8X8ADP8AJfhH3exmOBmDMKE3I5kIZi0oFkJ+a?=
 =?us-ascii?Q?jZs/LubyQjHmm0FZpAsTRklfVN1ylrTpBPtblb/EgY7s9uoCyitAkkbA9Jkx?=
 =?us-ascii?Q?nRX9lgBdt550dKNKFhxH0isnJDnH1zZ8Mwr4AksmD8wnH1+r7uN2PKmA3oni?=
 =?us-ascii?Q?hejCFMEPJBUgbWcLUYXraBEgrPNCCrPdc8+5f0UfT2EbLWtqsm3YZkjabKny?=
 =?us-ascii?Q?09Zrmxo0IycRB85FJRnfO86Zpm0dv+tShLTUhx+oZjQ82wPq2Mexsok6ntml?=
 =?us-ascii?Q?2uc+gfj4J8K7GVSIwsnfGv6tpxWn0WzHmrwbZrmE7hZa6ANCQnEzjQhJrRsP?=
 =?us-ascii?Q?eU94I/h2WAt/Qg4g4S+/Om/eUayP5USB9xTWLLspJXrZSyYYKBWr/Y4pKd2Z?=
 =?us-ascii?Q?ZJKlOTyIab7YbzyXmOvoBCc9Uv8j5vqBoNe6bJF+UH36qDGvlAPrAOAVndEq?=
 =?us-ascii?Q?jmwoeJesu5trndNdomtxSbLiVrHlHER+ZUusVdlvBuDogpQTcI9E1z2juIHy?=
 =?us-ascii?Q?JtD0/ZQq6456vFCHPtiLOJ7by/1iJIn+2VpoCwvzxSwPcECwl+YDhf7hXwJB?=
 =?us-ascii?Q?BnyufTvT8GOAgMBVn+uO99ov9d7KkYlR3FI2uSiO8h7RoE4n5V9gprS0119F?=
 =?us-ascii?Q?paaye7UY06mHDfyKIeZP5dbrLFIMJhNjL/J1Q9e9kb9HLehFQH/m4x1LGquP?=
 =?us-ascii?Q?wYlvmnXivkcpbpJFf3DubHGzzvVeXmw0X3csnFTKShtfvDmBzfOvLCqMBbNh?=
 =?us-ascii?Q?Lcq3pS2zAmsjcbc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:07.5239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9271ec02-b98c-471b-d1cc-08dd45f892f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272

From: Alejandro Lucero <alucerop@amd.com>

Use cxl code for registers discovery and mapping.

Validate capabilities found based on those registers against expected
capabilities.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Zhi Wang <zhi@nvidia.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 69feffd4aec3..06d5ac531f34 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -22,8 +22,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
+	DECLARE_BITMAP(found, CXL_MAX_CAPS);
 	struct efx_cxl *cxl;
+
 	u16 dvsec;
+	int rc;
 
 	probe_data->cxl_pio_initialised = false;
 
@@ -46,9 +50,37 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxlmds);
 	}
 
+	bitmap_clear(expected, 0, CXL_MAX_CAPS);
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_RAS, expected);
+
+	rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlmds, found);
+	if (rc) {
+		pci_err(pci_dev, "CXL accel setup regs failed");
+		goto err_regs;
+	}
+
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (!bitmap_subset(expected, found, CXL_MAX_CAPS)) {
+		pci_err(pci_dev,
+			"CXL device capabilities found(%pb) not as expected(%pb)",
+			found, expected);
+		rc = -EIO;
+		goto err_regs;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
+
+err_regs:
+	kfree(probe_data->cxl);
+	return rc;
+
 }
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
-- 
2.17.1


