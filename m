Return-Path: <netdev+bounces-190428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ACBAB6CA8
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9CA7A97E6
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4274627E7EA;
	Wed, 14 May 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u6TXcZ5o"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA96E27A905;
	Wed, 14 May 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229303; cv=fail; b=boPbTGtsXUlwG5VciBO+hZRxiKupeTyRZob22CV5GliJjy8PsL5zrB2ScYi8zS8TflZKzAPiUQh2f0Ete3/If2vIYaMkhg7J3uB8W76l7kfzO0PVCz5UG+NeWXOahpdbfHWbDSioAJWlDHWBwp5GI+dkooz243G0z80cl4ya0os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229303; c=relaxed/simple;
	bh=oR5nuy5nsW3fenJd2QoQBbNlDMg7byAT6ai13Hf2WPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLQ59WMrcadD8MePje1Ptkpd9eJAyHtAhjP7fNiUXiHiatikFbOTmBKQfPrXGRGWLIBKLLwTOC/9oMrNQ4fLQbqmgqniDeVd2FOJTYWayFPG2xkdS8L7emXf2qnU6R808p0pBeEATB8dhEVb4yKDy3i+AVQDSvC506GLj4oi8xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u6TXcZ5o; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1cmf91fY+E5gZsvoU5RyruN1/+TDa4wAzXRYi+cIATcjsSelQaNNBzTd1aQliP1H5EVDd1Mbzl+ui9F6yfKrjIxOL9WGUl8S2NCdBJFhOOqgrs0FfsD1vn1kbJdY5A7bEK1jc1pePFQHqxJuyYnE/wPXSFnmbDHzL5S6T2iFNq27ooNP2SWYiVIgKFkUD5ZXNUp0o/tUXYIy0VpRI1mzYXZ6NJy7eMVBv4ffJp0UHjLTrsAvLtsA8ki/fzLrxwZXnsWTBshLfy2nLKRz0/aAZJOPeh/BuGx5CNCbmWhOblU/DSf0Kd08pHJaR8BJqrZ6Vwwo502mgIJKDVmCt9bgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOZ2XJTZ4mS+FcIR+scOA37cl4Nm1gquQEvxNimIVkI=;
 b=OVfYwce+QAbqaETw94cjLfJi6TUMIkQzOpKbk1LFg0geGkWSaUrxIYsEUbiHvXyxLSpuRjcTUoA2oXZfxZeoiJAfpvdI9uNIH3a0IHLaOVp2eptATCnGJy3Rfz6sVXQV+WEz2r/yENiG6glTXLszMvcxahJEJxRhMmJOpKwzRpF1d6tfVQaOn4HSkcIBNAQZrGJFy1IyjprBwONh6QEreRTtZT8HF2R/cjp6KD9iTfSkgvTEP8uBZ5/qEE/AgFpdPlE8+ZUQ6/a2NdOa1YkqTZg2hzLXlAiSqe7Ickw8ZdFGLUJHFQYF3lSevOyIlV+l2cAiMvlZN4IEIzYNMmxNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOZ2XJTZ4mS+FcIR+scOA37cl4Nm1gquQEvxNimIVkI=;
 b=u6TXcZ5oPhBnBxL3lQnzzT0K4a97vPk1eYMNU2LNzovXtVBq+fRF6wkP93cuqS5gGzj7ikH4fmlVJUatTilJMeAbfLx5wIeytsD5W4dP6hc6bpmeur6lCS2YiXEH9j3lth8SeezEHvetwm0leFyBLDxit/fE+xqQq8gspSgmdws=
Received: from BL1PR13CA0128.namprd13.prod.outlook.com (2603:10b6:208:2bb::13)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 13:28:17 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::fc) by BL1PR13CA0128.outlook.office365.com
 (2603:10b6:208:2bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.16 via Frontend Transport; Wed,
 14 May 2025 13:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:28:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:28:16 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:28:14 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 14/22] sfc: get endpoint decoder
Date: Wed, 14 May 2025 14:27:35 +0100
Message-ID: <20250514132743.523469-15-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcd4af8-22ac-4e24-3422-08dd92eb2f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sQRh+EpiLjQ1uSwH/29v27o1d7ASo6FvA018LtvTJluohlFkzku0x3MtfMgZ?=
 =?us-ascii?Q?vi8+AmELNY4oq0Ov2q8GePMyt167dQvWGouQWDSy7NZAIceAfbhe7SvSDfoj?=
 =?us-ascii?Q?3spHS5/CHzNCK5D97iH1ykUV0qQ3c0Ej5OLkv5xcDny1zfkLx8YIDPn2SOIX?=
 =?us-ascii?Q?Q7Yx8/SnrshaOgVTxX2OK3aAUKnXJBVcUSKJNBdoN15+ukW7Rx8PcmFiLMbz?=
 =?us-ascii?Q?RQMfIoieI1Bo2b8ULOxQNg9V9NGE468B64KRrZUFgJclWuxr/YHFadadgR9K?=
 =?us-ascii?Q?AvWfMqc+ZUckTr38Nrs7JAZfpYx/EzYofwtTdU/GcYPx8fGa5Qk2qzSpCRXw?=
 =?us-ascii?Q?fCjjz1W9gafwLl51yGK9125AYwy+MEMDD5GYZF4xtc/fg//jb9mmkwGUK3PN?=
 =?us-ascii?Q?d3zg5u5punYE8szjyIPrJJmPw7F0DKd6157Lp7IZ6mNGS1BDLlMu7VXrxicE?=
 =?us-ascii?Q?5J+g5xrmeBLlSDeYB6hM/A+5267FjeA7z21qEVtXEyXnStq1uwcmuIfJ/b2A?=
 =?us-ascii?Q?AwZcQRhtwHGXKOLgV0BV3Ac8hj7sSJE4Nu2igoTkiFLZBkaWgdNqSa+q9UJU?=
 =?us-ascii?Q?jYyxJ7nSpA6VoM5t86Ep4qjag18IKVUow9bI87+7d4IAllRTeYyHiiGSb+2A?=
 =?us-ascii?Q?nmEUcOMcc6znSLp5o3a6vxoFEHstYG2yK1R1FOVdi6Lo/L03eGkKQbm1Ui1G?=
 =?us-ascii?Q?72gGPMm6y5RzGq3Y7tCGyW///He+1AJW1+IA15J6Px05lcK/9wFgyrde+UdG?=
 =?us-ascii?Q?g8M7FPjGux+UiRUduYYJ12+vwGVbaGeQV+Zidz/bd01e9FkwHsj2NeUC8f/s?=
 =?us-ascii?Q?YePzL0u/i9eCY9pPS4a/REjmqtmMoUhAPQ0/CE1pG2HRs6Tq5n96N/XyBwkM?=
 =?us-ascii?Q?Q2dJuo9T+6dUkoMUf+emZGke5RJJ0lHN7eM4XILncH8WHwnex650b46OvMF3?=
 =?us-ascii?Q?54EDvM+AnpPT9AOgFLZ6G0fMXyBsloNpNW5Y33cbBekTWrEGcl/kvY4SIXbU?=
 =?us-ascii?Q?elGmxtPOhxqXlRFGYCtSjA6L1T7xRdEZZlpcrrksqrd2mbTNjK+JF00Oe/Yu?=
 =?us-ascii?Q?SitKbASXz19JPTO40jkMVz5ODfVxiFYVau8PBGyBUZw7593X5z2kQ3ORwVB1?=
 =?us-ascii?Q?iPaEOrDaJe8PB14EMUDCHATZUnPCmbWR2XKXWjYppSEipsR5wKnxRSUC5q/a?=
 =?us-ascii?Q?o4TFbiNJhqgVjYui162ziK36qQ4efj3Po2x0HBN+cv8tbrlifJ6CqglcpPrv?=
 =?us-ascii?Q?+yK2bjma0L3SK76UMrTnHRB9a4PVde2xjxnJqAy4+/QsOFrT73UduPqBlQ6K?=
 =?us-ascii?Q?jMrIlEl5fhBDMMwTAInTA7GyqmZZ4ojHKA5vEGtMDt7lCW0wt9iFWpubWtri?=
 =?us-ascii?Q?RoMNggMixOkj22xGGrqFJhZH753CaIWWhB3GLNRpXYOklIGhu1Xp26TGc7Uo?=
 =?us-ascii?Q?NTLIEopmS+KuZ9ES9Ui5wIrigmMXcIWE0N9p6hdHMtVVkXRI5PdI/kfGk3vd?=
 =?us-ascii?Q?vCuosz+cyVAibjKvJAGly0cVx22y8yklrYNf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:28:16.8906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcd4af8-22ac-4e24-3422-08dd92eb2f8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 5635672b3fc3..20db9aa382ec 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -98,18 +98,33 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
 			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
 		cxl_put_root_decoder(cxl->cxlrd);
-		return -ENOSPC;
+		rc = -ENOSPC;
+		goto sfc_put_decoder;
+	}
+
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxled);
+		goto sfc_put_decoder;
 	}
 
 	probe_data->cxl = cxl;
 
 	return 0;
+
+sfc_put_decoder:
+	cxl_put_root_decoder(cxl->cxlrd);
+	return rc;
 }
 
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
-	if (probe_data->cxl)
+	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
+	}
 }
 
 MODULE_IMPORT_NS("CXL");
-- 
2.34.1


