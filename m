Return-Path: <netdev+bounces-227939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B10BBD99D
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCF6B349E91
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9012264C6;
	Mon,  6 Oct 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kHnI0IEg"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010038.outbound.protection.outlook.com [40.93.198.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF64221572;
	Mon,  6 Oct 2025 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745078; cv=fail; b=RsAVWX7MjVn8Bz5QZN9qBiwAy5vgpK0rcpmxgtLM97qvT5QR/SaV/1JyP4hhkusPZZn22hnyF9FKNtK3E+SqMGa+L0a387lqWhxBEqOQ2PBdeNS/lLP0g57CRrIzRAT4/xvPQc0n1/KdzYMY5N05pSk3j/R1w7R4TE2VPTlXlJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745078; c=relaxed/simple;
	bh=lr0DgB0xbJ3sTMY1x7NgdX9Z+f4WhvhR8e0VY53bpVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvdsbU2Nfd9rL7KHFOoPlwBQK9hZZEyRxpQFGVgI1IJoQ+NJD5/xH/IVLtP6YcfIFVyJAwU2qH5OTUahmxE7Ob15Ae2Ot6cLlq4Ot0k9oO9CVGMWytwFuqHH3aNPLhNunw1qkDFqi6cV40WY4cSKcnDyiZFPoCQh7o1i+DFkBMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kHnI0IEg; arc=fail smtp.client-ip=40.93.198.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULE8yzPoHGbQgUDZwukQQlK4B2dS75sRFYB6CvbmIW2MwnV9Pv+dZy9BI6Sc7IrXqj9DxFto9DqjzYHk0SlOZfuRsb+wS2MrAbhaZdUpKHHS/+qnds1V3AsmhALrZzEdds18Nl3zKL5MrdMIi4BuYz+eokQtqmIp7uyaQ1VIpfiKAonu/IwD7bJZKmGEbadjlBwf0kd4gU5kfe7dqbhJAyoVab1iCX66A8iXFEYeAGjXED+tCNugI0hq5p7iaUSMN97WKdQ0sgHYRQp46837XYh2NiXWP3iIll/N5fDvYMIl6van925ikVXJQ8W3PiNrBlcQEcCTDymHHwz8Y/2D9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m52sU8vXcGsooOSFk8Fo0bVsSBXtWo7K5s+owlORotE=;
 b=EvqcZQK9CjEzPBdce2C80NnA9ldxKdVZsbZc3m0Q6aEW+W3dxBQSiaGjinE9VIHzoGHYvqjKtuzQ/PPxD1EN5+rbpk0hy1ZaHfAHPBNdkQbC3Hc6M2j7kZI7uYFoIyJjkwSN70Z4gbnwjbjoMvLq7rsUEMfUrzDdVwKKnvYGVJGSxprc0gw/vx+GnN4VKJgdnKP/zppGUYNYwoh3HlMwKPjEiUZgpmCFoqQEgAhCGd8Ga1e9So1l1utCNqc3y1neadqpSxxt2uFJ6iF5Z6ph3JEovM4A18zOrItVxaQwHxP8xKRV4tU/CD66aYPs60xgA3d93dlvH0w8F+IbQKwAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m52sU8vXcGsooOSFk8Fo0bVsSBXtWo7K5s+owlORotE=;
 b=kHnI0IEgYa6WaeS2a29KU35jiXj7QOyQWYy3kbEYlnd0x2UO+GbGwoQ1ddK3cj6drCsLRIjcULzs/2ttQagWF6ObZYGxjxv11kgeq/PBMyRFUblxR1AXNHGhULvTJqZflgaf0ic+5iw2884hZd91c+DttQ47KksHkIsosN5WQcc=
Received: from BY5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:1d0::18)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:04:28 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::fc) by BY5PR04CA0008.outlook.office365.com
 (2603:10b6:a03:1d0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 10:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:04:27 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Oct
 2025 03:02:40 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Oct
 2025 05:02:39 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:02:38 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v19 20/22] sfc: create cxl region
Date: Mon, 6 Oct 2025 11:01:28 +0100
Message-ID: <20251006100130.2623388-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e55bae-2179-4c7f-47ab-08de04bfbc6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?feGd41aSC8v/rU8OnD74afcMEZ18HI/qOdRRK/PDyj2yxMzQqgh3Gfi+yDD8?=
 =?us-ascii?Q?/lpGeZM3Y4a6lQln8g50lGUZPhx1WpIMZ1TxM1yYPfjoSqRDpW7+oMpCl9Bx?=
 =?us-ascii?Q?11+aPPvqyTeSnAAW164VtE7QVOOLdh0nm4W6CIrknorzv+GJIMepgH0ggp8W?=
 =?us-ascii?Q?9+yE7V7LKnSRy3bP1/9XSV9io5Ctdcfi/tjL3aop/vFxfNBOTz6ahSOYkYKm?=
 =?us-ascii?Q?8/Y8MGIT9EwxGDJck/FMtx0EotgkpnhO4UFXtUV7bvBSAceybMUTlbkJgPyg?=
 =?us-ascii?Q?JoQTzpRWtZtkAciVMswtKHdKeIpKcxItgO3nshiZePuwu9r3e9h3btc0fE0W?=
 =?us-ascii?Q?B6INADY3JCS3/rdTZvwox7nnZ0U3yWQOuANUr14hd1lte8DPzpsYwqGtxmK7?=
 =?us-ascii?Q?fz+XsyXVmqFXQKO6M06h6NQ6tXl70hPwQwxTE741K+TYzkqN46DE6E169yQl?=
 =?us-ascii?Q?dFyPLBDk8vUuygiFaTMHRSO5GmhLRC5Cwumga77W8f8ha1Zv3vXpQM7IfGY+?=
 =?us-ascii?Q?JSysK4kgMQEfHtyEAb3jybmV2wa7Cqhyjgdt4NXiA/Hr9tCTaypDLvuNspPw?=
 =?us-ascii?Q?NGwZarXouR7TfYlvEaegGLiK0GWjgjLcXK+HLLc4tGtIz/s9lOrEARScBWY2?=
 =?us-ascii?Q?QbExIevbzi8wZd6ug0/+ySuT5LyVa06FJFwYGlYDIGlQ6PybzFAIhQ03YZyr?=
 =?us-ascii?Q?hPEjSsg4GvnmjETzgvgpmgRPDqnzBGgfu29N02envm69TT3w6tB5129Gc6n8?=
 =?us-ascii?Q?H0npO3oRJtDcMmBJ6Y5Xs25ajPXB8jeQT+qzZYe07nh37HPgfGikCPbHtzN4?=
 =?us-ascii?Q?LFoj+Q/YOEkHhAfxhm0sLnOGBvGwBLs8NZEacoLlqnjKcBhm8zecS/xylJVJ?=
 =?us-ascii?Q?EiS2nqcPgXMh/BDVVoYxFR6Omy6V/SzQMG6UBfhgyt46DYXyyXHvPlo6v5o4?=
 =?us-ascii?Q?zV6mYX8+fUGqOTXw8yGLgfHxIVT/EvC5Ay13eUrkrGzpaIRT4oX3PO4syLco?=
 =?us-ascii?Q?Z215cJsSxy1QARSqfKTPR3Pn6kY7HmXLnF7+8iCFECT88V5DhSQIIP6u3kie?=
 =?us-ascii?Q?GgtnZ+G6D9hhG7EiwJAR2bX0szCd1vr1OYPwO8FYBNnVRQ2N4EPfsRaORDda?=
 =?us-ascii?Q?LeRywn8sSisk+bw+PT5BSGka807ra1gs0nt0IgnRuDJc6yphSBW3V1H6Whl/?=
 =?us-ascii?Q?G0LPFxil6ssNchmApGBxuVYxOrVImyeGAXtuays4V4HDHXrWw/3QJQRqvP9H?=
 =?us-ascii?Q?7XPJTCqhrSgDM40IF7cw1AMmpVLvVRb8LjRaNLf+Ld8yGd2v25RsAaVPQlEJ?=
 =?us-ascii?Q?r4umDSwr9bEaliX19Y+Ij1KtvtqxXEmr0ogMKKHMuiX6TVVfB16U+Yez4JYi?=
 =?us-ascii?Q?F2n31p0jUxFu/f6NN5mhm5TstN0FbhuPyCK2DGp9ItTmiWupdrykUrsd0Im7?=
 =?us-ascii?Q?UMKTtPZmd7yf0ioBMOYCX03UNcPMC56sP2xN8Yci3X4zBNtaIAwjdHmWuptj?=
 =?us-ascii?Q?j52CfJ/i0rSvm9R53Xq0qRZdlbRJUO+AdfxTQTa/81feIBVurABD7UzIrp0P?=
 =?us-ascii?Q?Y349KzNcKRfX4SpKtN4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:04:27.8321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e55bae-2179-4c7f-47ab-08de04bfbc6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range.

Add a callback for unwinding sfc cxl initialization when the endpoint port
is destroyed by potential cxl_acpi or cxl_mem modules removal.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 1a50bb2c0913..79fe99d83f9f 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -116,6 +116,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return PTR_ERR(cxl->cxled);
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
+	if (IS_ERR(cxl->efx_region)) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		cxl_put_root_decoder(cxl->cxlrd);
+		cxl_dpa_free(cxl->cxled);
+		return PTR_ERR(cxl->efx_region);
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -124,6 +132,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
+				   DETACH_INVALIDATE);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
-- 
2.34.1


