Return-Path: <netdev+bounces-237242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69961C47980
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCE4188CE3F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616043164A5;
	Mon, 10 Nov 2025 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pHIo5cb0"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81AC315D36;
	Mon, 10 Nov 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789062; cv=fail; b=XLHH2ldWcqDdUkORjrCHQgc6U7PeTQCYSTnY0TRZgB6i7ODHWWQRnVdzx5VPpbhaaPu4arEbtgsCTJYYmuQHygIvD+jZcWudejSCBEYZBzc4OxJiVlsArhRnt023Xrhn0ZBWFgHVXjYugorIkDCz5twg0HyZ4MneCUQUNFl8MJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789062; c=relaxed/simple;
	bh=lr0DgB0xbJ3sTMY1x7NgdX9Z+f4WhvhR8e0VY53bpVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dj/WQIsUe7MhN7k10rVfpSh6IIr62FRKUCGXhcVUeE0HmqzZU7S51qnKN0bSTqRfY0l8F9wyYNgsf1U1CakeH4E7/EtXcAmdhEf2NYO52y7drk6e4x30jWm2eWKfkBF+r1kMWLoyjwJZgGj73bVZPu0tapmje7h1JtDLHM3GiC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pHIo5cb0; arc=fail smtp.client-ip=52.101.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEgqmt74tpVaHe6opG2cjHIva7iXF5DyTe83maXBdhzXPM8I0OuqzD6ZZW9q8jrousv0OkEDTbgi36JQbWtF1vSBiaJo1Q1F5IyTIGM094GDxoYjJ0R0oumTc5GqaoiYByi01Cu8l63xnaPX6IOsxW6u3j+uPQg6N0I5MKpYjWotyG6hrAuMQmJps1KHIW4052VSDVtL2s5tAIKH70fyB/T7g3kXeEC8Yq6Oi7Nr6j23pdN7icpsCcpUzObkIvLtOkPNEXLku0CaOEemnqemHCpGYFKbvh4DGUnGbS9ZQBqww7AoEUaz/WNsZqG+zNTMwrhDfGE9PE+v/XKv/KcLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m52sU8vXcGsooOSFk8Fo0bVsSBXtWo7K5s+owlORotE=;
 b=tJLrwu7TDJq7+PDbYoS5z+uI+T+6V8y1o4a82bGYitktnQ5HJffy9al3GO8l6o4FSL9G8HkKGEGYD14khmQPNPA70Sqcdzbg3i0lcxRnWwsBWYg7z7Ibdxs5qijv6vKd2z6c8hGbhYiLRZekP6VjQwDHMqlrovMMP9NVfVB5F0BCqVnKHKQwxr0xLl3E981cDTP2ggmvTtDxyLAKHEPA0hopSSGQUXYJEmKJOytTTTRtMoxQimx22xNA+xkHPpTF1yDjRMjEkQIPX6QO8EfgqyQLzNLFjACOvdp41UwkGpNrL6iZOD6UHvrnMjrtU5gLdNityiPkZXi+tUMYroOTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m52sU8vXcGsooOSFk8Fo0bVsSBXtWo7K5s+owlORotE=;
 b=pHIo5cb0402W97LeIhlsVrhip0Gj/8eq1V3oVeVjtXyUxvDxG7AkqhXTC6cJPcc9UqhpV8eux6Ri5KSpZOWwcscqj73f3mZAXrlAHQ6qXjR3EvI5rmLJK796qeTj2q4DguhtrTBI+C7Vm8jAx3pGOSQb6kWnKUNvu4gCw5uxYPg=
Received: from BN9PR03CA0915.namprd03.prod.outlook.com (2603:10b6:408:107::20)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:38 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::65) by BN9PR03CA0915.outlook.office365.com
 (2603:10b6:408:107::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:37 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:37 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:36 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v20 20/22] sfc: create cxl region
Date: Mon, 10 Nov 2025 15:36:55 +0000
Message-ID: <20251110153657.2706192-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 8245257e-6046-403b-0a2b-08de206f13f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ac0a4xkrRGnpYF/MZZpu2C5XwpK/1FKkM3JeBUvRgIFt3X47sE46n552BJBb?=
 =?us-ascii?Q?uoY65iwse2kMwcFUcyvwkvM3go0nOTtqMihP8Cp02ppm0DwshGtnhyS+gbm0?=
 =?us-ascii?Q?sGtzNUdhIPEz88AyGpRUF2H6O6nVVlizWABqk6Qb9W/tCS8YPvMuQd8pbWwy?=
 =?us-ascii?Q?6NFMQuPiZZ6PdXq9zeIjYh6waGz48qJchtQM1GEW6APMFo0XzgvvsxVPpR+W?=
 =?us-ascii?Q?OYFmHhoasTJ/MODVlo0PoHOwmIoxeOsTQTxVEsQoovfWpvGDLfKhEGtJCKeQ?=
 =?us-ascii?Q?b8xWiP2Zu4+039LuWYrTfbjaTIxYp1zS7KyXvmWaeFrP5nju9+qfXNZprxzT?=
 =?us-ascii?Q?w1C28W+d01IfrbWlrJLAt5wwFXIRYEcM+SOLmkmjeFf4WIGOtWOVEtrnfTsu?=
 =?us-ascii?Q?wLkUYEFnwgHz5owzKIH/KZWGMuANcNLgm44MLCyfrzJw01YFe29NAN8xU1S/?=
 =?us-ascii?Q?RMbUGc93EycvJo6no6hNYeDgMSL5moIepU1BlEKFj8OM7I2FY9rB4HdvXiZF?=
 =?us-ascii?Q?YnfuP6CoVktxv82baxp32lh0VSaxuW+P8MsDTALu/5hWxMKrceMeWtM4IeM8?=
 =?us-ascii?Q?eeR/Fe725E2uIsAxxWBP4p/0tVNIHBOlmdnNvC77USuC+iKuRaIwQZduZBUW?=
 =?us-ascii?Q?V5bysNCui6uHxC2GzDYbopywbK7eQvCkhEzZ5o0+FQuL2fvUqXTZ5U/kGiF3?=
 =?us-ascii?Q?XOU/tikvXC/O4I1o+kT0nn2DIH856eHjUZOT4tbdsMBLWjIuwH1ZGHNmKv6y?=
 =?us-ascii?Q?vkZ7bgXPHbb5aq5DWfIllRoByKpV6wtiH5QEjjzOTHceLxAojETVYi5AtuSJ?=
 =?us-ascii?Q?xdjTyejQT+23UYseRMsXxYvK3hv3vhGQ1x2xl85tEk//hgAhvAkvTAFmouXM?=
 =?us-ascii?Q?ixxipDtuIlFxelNlmLiaaqGqaUrZVGI0CRQVxhTUljutsv7E4NAZy7UcLhHJ?=
 =?us-ascii?Q?Ycvngu5PD86Htq0IhaNjY6VivfxyRA5wnIVWai9BTgamICocQljzmgh3ihjT?=
 =?us-ascii?Q?MdPJDBlOmMuJAg51JJLFVepB059V9gkeCZp8+QZdlTgIsgqhhXJWM2b3Gnmn?=
 =?us-ascii?Q?7fy5RNpD/1WDPY7v8aSzW+IhGnFl/YinIJQMv3lnAIBLXhIdyZCTfxzw/o6m?=
 =?us-ascii?Q?9WPdiDlM0AfJJpGaQr+5Mj9sLiklKQffIdlS3JXuAJ7SE+tfWtA130eYByTd?=
 =?us-ascii?Q?UT45WwsdeA6XEdl7o6iidaetmrgJJxkI3rpFHtiaqSr47DIL9xgknFH00lxo?=
 =?us-ascii?Q?ZXSe10C+FBjxnSExEVSXLaWyMbpx8R8xwTKqmZfwryOw+hiwrRYN3R2ld11m?=
 =?us-ascii?Q?YKsSMEiy/Hg0P7f4eLbE5TiyQxLXBkDtOaH+OR4IHJzxr1RLkavzNF4S8BSz?=
 =?us-ascii?Q?tglLQtGcf5hhjmYfwHEQPdvkuWQS12fa/Y2cIhP9LaiiZwaV86AWWSnNKuYF?=
 =?us-ascii?Q?KlynXs20mtpSn9A+OyQffCLLXfxHHe2OGVw9aqFPilqXr4HLuo400g7ND3dY?=
 =?us-ascii?Q?1DGz9I1frJCGxLS/GwKoq+zdw/mlQ+us4EbOsEmT7rYofTVWF+4g1L+XxOVu?=
 =?us-ascii?Q?T4tyQ3w4R+yOs7hAGAg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:38.1280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8245257e-6046-403b-0a2b-08de206f13f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960

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


