Return-Path: <netdev+bounces-190421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AC2AB6CA4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C4819E84BD
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44A227AC34;
	Wed, 14 May 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pUY+0m3E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023AE27B505;
	Wed, 14 May 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229289; cv=fail; b=Ha3ni/4n899ZSSIS0wXVilf0LwvKKm8OBfnsbH6JORFSVMypdRqIWfmsMFoCV1mo2YBcraTqVMUNpa139H5jLdSiHsGsy9kDV5mSpnvkis8WzEmNCLE7Jgx00/V462UP/cOEfUy6jHxMlL6yuZFTQnZn1PxXNUiTUVb78hwLYNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229289; c=relaxed/simple;
	bh=Gx7MjnnDD80qhBgAXsSrRQMvW1cNKkKBndBTKa3Q/C4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7NKxE16bNnj/vdbIrhv+iejoRAbTGiAmKNS+a8Uk0jJO0RQMCum+Q5M68IAMic1xGXIb1m7XkwPhjYYyAgDOQU8ly2ZAzWsouyCvFbM80XrlB3ftj340754oYDh68XG42QjrvboI59frCFv5v8j0vtgOooiMAda6i0uF/d/g6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pUY+0m3E; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipT/5Jy4vD7ghkig4ijzugzIHePdsh2B7icC1v5YSbZStZfYVhqkHpMqYWVjqGG1HwSRTkSlgwcmcNSLibKlaMKcIYh32+Nh7whUNkr1lD+dVkbVnnJoQ7NaPtMGOPWLrvLtLiduI6PvfvzOlq1eZPUAmwxmSC13/eOsbOPxLme36VzaFgjZ6/prqJgpcc1smLJQxQlemIetTpgPKlyu0pORA201UxBNFVhH3GiWB57UU5OAsvswGmjghBdJlc7dKjywUroFUSSbr6vZdfn1retXfqAqrWS+/5r47t6gs0+hAGzFM+E4Jf2Sws/AY+saUxqtdIMOTsCwU8vp71watg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNKdZZY+h8jm5WaA7+MMS/U6TufDto6387Q1nAFFJN0=;
 b=H/Tcus33JxoDZgALILxiR/IGaiGm+n01fkMiUOFffLrun3O3KTl7+wehzsbeNRk3GYcGuvblp0Pni89ETjcRE6f/bQXjd4f1R5UNjdewz5F0r2Dt0ruVig/k11HqTY7b4LOoFTeRNGIiyPNkvFJlJTZSWZfCpEc5CDvWnbLlwt4zTx5+jSnHrS/vxutgdFC9XDnt5BhDgmTHRAieXB3b35liJZ6TbdF17RAMFgCcaNwoR6dJgzAIeKhHSvnSa5ggKH2o+RNMenB+0yUMQ4TnNI8t9A4d+L8nsgJ1WeB9dSue7RiUSAeIeUoqdYpCX1bieqnXZLv2jdGfWpoQ2iVrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNKdZZY+h8jm5WaA7+MMS/U6TufDto6387Q1nAFFJN0=;
 b=pUY+0m3Eah4X0Z9nX/WQQLm6Uj7hHVp5ycsw8+GMX8yDZSHb0gfJLzEWUlHy4OncQbo71H0rjriTW/bZbbd/Z4AKk8tr82ZrreLHbc5VuWxAhsCwkO/1MaTWfIlX8/0lRDr90n/mijTp7GJTyrR1KD6myK6QyBAwFHUNrsc01O8=
Received: from BN0PR04CA0194.namprd04.prod.outlook.com (2603:10b6:408:e9::19)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:28:03 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com (2603:10b6:408:e9::4)
 by BN0PR04CA0194.outlook.office365.com (2603:10b6:408:e9::19) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25
 via Frontend Transport; Wed, 14 May 2025 13:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:02 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:00 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Zhi Wang <zhi@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ben
 Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v16 06/22] sfc: make regs setup with checking and set media ready
Date: Wed, 14 May 2025 14:27:27 +0100
Message-ID: <20250514132743.523469-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 15858fde-88fb-4931-790e-08dd92eb2736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MjvHeIh7sZpZoZmB7V1FFLnQUQSrNua6V48lBDULgXqf6SpG0vVbqFbxwNHo?=
 =?us-ascii?Q?b/nAn3gkro5xhpAW9aUb+BGP+w8Xj5QmJq2HM6ToU58WWwxiWk+poTe7whvE?=
 =?us-ascii?Q?th3jk2QyHJluuExZ34kVACunr6vWOEL43+39SZNl3+o0LLjPk0Jov1noxJyL?=
 =?us-ascii?Q?kHSy314g4Od3o7xb9p26QkOkNWCYNixdSVFqQSMz4BX7Er06WR3bCHo4UqYp?=
 =?us-ascii?Q?Yv3IrpDuWtKma1Zr1qTSakoS1NvkvYflr8uFaKQu8CE6aCzBMMt9N+AZefUt?=
 =?us-ascii?Q?GIIa98EJ6PD5LAe3Gq/kvAwUOh9rcNqAeKxSV3CBMucFMQUDKkffTG3xMiCR?=
 =?us-ascii?Q?6kmQcVsyPrc6m+uhScqsTpxQ+lJrxusllziBK8ubx3FM1kXNlbru5h67BGNU?=
 =?us-ascii?Q?yjCOq/UxrnCYkzxM/+uiBfx1UaFte6gO4VQqHarSxD4yBEOESvlqEU9PObFA?=
 =?us-ascii?Q?RoAnUZn2erUdUsJPEBFZA4hhhOweAACzRsX0/zjkYmQcYAmKdQae38tQZS06?=
 =?us-ascii?Q?BBYsaZVEVwBl6t5MMMdv8PYzhX8hLqtqAIfC4iCykwtA5uXMr7y2ARoOp2a3?=
 =?us-ascii?Q?TZBEe79DpZNZWUlrRwi/zJnKp34ErlsARoCLL46V8q+JBqKYH/vm9eQls3Xe?=
 =?us-ascii?Q?3HixlBLRqel+LCokwkpXDfSfibFo8nRA0jSvGnCNE79VVgvYr2yzqMaOktvE?=
 =?us-ascii?Q?cy4/UXbLMBjadmvVtlbUJs4DulkNenlkMAPl5HpnnAI0PQJfMmkSZkDfQEil?=
 =?us-ascii?Q?4i8J9DlsupHpGjcoKw400owm9wCGE0KVAZxddcwsNC1ujofZrxYh83pwi76e?=
 =?us-ascii?Q?eS+lWDy4XDBLg0MKhpgOtPJJEF4j5qY8xG7rU3qceJnbja7s6vRiavbFaPm+?=
 =?us-ascii?Q?YgigTu8lfq2jb5Tl/KpCXNbjX1WP47p6pEBv6LamP7EEeaIzYNuljoenh6/w?=
 =?us-ascii?Q?LnAEplLiNxtwL+nZcfu1Z6CdORP1QjCGVQIK0ooqso7WRwORb3SuOqjGVKNL?=
 =?us-ascii?Q?chsQ2qkH31KpuoWM3FTL/ZK6Yd5L0yGvE06cHrFyxg1nCsnMcG5nbt3cibnk?=
 =?us-ascii?Q?67hH6qhIXTKz7Jq87ppJ6WzEs2GjmBY24pPAVYqijmVpbkMoMNzLfmd4UHFf?=
 =?us-ascii?Q?iOGykQWEITWMubR6YfJ07bILqRGXxsPMo/3WKRBBXuzcOPNa5apoCkA8u94f?=
 =?us-ascii?Q?v1KwOXxXFG3ldEzvn+94m6k4mEAbq9je/lU0CLS3edhYgCJL2Z4Bwu5bRAEH?=
 =?us-ascii?Q?N7BklMfVboc5gRtn5WE3CxQ871ip+fF71A5xDy4+8EnpMNCJsLd9KlQWooU3?=
 =?us-ascii?Q?uT69mOErSyv9lJILrJlpBuYJIhNINF/o3zFXa2ZKAmJnxg/kQqx8p4T96QMX?=
 =?us-ascii?Q?7/rhm9tE0rf1bA9ZGuRbfzLNjco72+Z1hLBUB0TwK+69JWf2sVhQAg+TgQO2?=
 =?us-ascii?Q?8wOTJi0Yy+6nXLBpsFG9c+M9V1UNXxGcSYw+/lkO+8EeGFwCv96/a/dRuzOJ?=
 =?us-ascii?Q?DRyfVB86qY4zcX7ArlLK8A/rQQqoXnvmqD4e?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:02.8878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15858fde-88fb-4931-790e-08dd92eb2736
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185

From: Alejandro Lucero <alucerop@amd.com>

Use cxl code for registers discovery and mapping.

Validate capabilities found based on those registers against expected
capabilities.

Set media ready explicitly as there is no means for doing so without
a mailbox and without the related cxl register, not mandatory for type2.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Zhi Wang <zhi@nvidia.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 753d5b7d49b6..e94af8bf3a79 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -19,10 +19,13 @@
 
 int efx_cxl_init(struct efx_probe_data *probe_data)
 {
+	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
+	DECLARE_BITMAP(found, CXL_MAX_CAPS) = {};
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
 	struct efx_cxl *cxl;
 	u16 dvsec;
+	int rc;
 
 	probe_data->cxl_pio_initialised = false;
 
@@ -43,6 +46,29 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	if (!cxl)
 		return -ENOMEM;
 
+	set_bit(CXL_DEV_CAP_HDM, expected);
+	set_bit(CXL_DEV_CAP_RAS, expected);
+
+	rc = cxl_pci_accel_setup_regs(pci_dev, &cxl->cxlds, found);
+	if (rc) {
+		pci_err(pci_dev, "CXL accel setup regs failed");
+		return rc;
+	}
+
+	/*
+	 * Checking mandatory caps are there as, at least, a subset of those
+	 * found.
+	 */
+	if (cxl_check_caps(pci_dev, expected, found))
+		return -ENXIO;
+
+	/*
+	 * Set media ready explicitly as there are neither mailbox for checking
+	 * this state nor the CXL register involved, both not mandatory for
+	 * type2.
+	 */
+	cxl->cxlds.media_ready = true;
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.34.1


