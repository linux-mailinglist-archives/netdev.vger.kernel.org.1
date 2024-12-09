Return-Path: <netdev+bounces-150349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A79E9E94
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89342282149
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B91A08CA;
	Mon,  9 Dec 2024 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n4gRKPRT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876C1A08C4;
	Mon,  9 Dec 2024 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770511; cv=fail; b=pdxZa+Uz54CkMRABnYptw3lir5EbD2ZYpNjP6MWnuKjzNcDuiBDuuxJpeDSTUxqpd2bxUobtJMvadRo6RRHuNkrwvybz5QsHyd/bQ6UXyOVmLaIbxJ2DuxgSnav5RO4R0r8CkOHPsndOJISFocybOse6GKC5hBNfrUrrD+SMY5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770511; c=relaxed/simple;
	bh=SSd9vE/VdjVRDLhTvA0xBpo+TJc/YIv5GDXYqIqokqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2l9DMv2yB+5u6Remx9l1oVZ+YqurRA1RpbtR0upI89HgiwPG4K4zqSDwuryNkhMKUGMlawGnLQvDyL5ZZD5Ef21Ss385cSRNDzdgiyWa9LOMbwJdbWjyantg5FPsYWqAwD7K956Py6C8WiOMnDxQ8KU6ovfkylYMHmGb6HLUT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n4gRKPRT; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCCzLSh+ZMreR11EbC2CipiYvnbYZoEqTiV4ZuUqtV51kKp1qCzbL4VfBbCpC8Ilrh9JDViwCuk22iG4FyDE6EkrMsNOVuf5jf1RINJpgysVtfgbZy2SDBUd1/yOMyldPiqXzw55gQmJCCvQhBDiEHDWYZ+CFkxdvK6/U84Q0jHBbvUlilZuANIS6zzjGbfm7aiongP10vNGsU+lKgGmb1s+Bb7m7x9bNyUNILS6T0Q7UzVJwrZxw/zgS23gBAtJVpqbaJIHkD3ltUnGiE5cakjx0Xe6yE1YEVu+LiYmOw64eKuoYhCVFT9A4/TkPz42yz6sd8aiytuhUHjmYRUX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggsJIMOTMshP/CgIkPZk9NWm2uuV+eOAvwBt7o+Gigk=;
 b=HZo1yGyLHgAjgUnnLmyewv/lmXODfqsv70XrNV44Q0pspf3wTvRWkMX2eJeca64YzbvSyJoyLidEgHpFBBgisxyrFlAMY6RLZOfr3o5vmAq3YFYWetoePGzGDiFzX99pw4Kir/KbekCiwxqMuuAtGhMb/o68tRBZQVvBojeebsPJAEquJbbLBit0MpaNmyi2FAFt//FzWPjXUa+BjMt1PNGFr81mWWh3ANzmTb1fwp3xX5q5VAPnZ5BPJr6zMZqQzTrMOrUfk/cwUBvrf7pdUq+fW9ExNsBiC4iIR2a7idBvcoscp2PXHEBMnQqFW6w5ZK4EA4IKz4lME89MEZJFBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggsJIMOTMshP/CgIkPZk9NWm2uuV+eOAvwBt7o+Gigk=;
 b=n4gRKPRTA1fp7JwzRfw/yOM8E1tCVAyOAj92D+oglXTTWxLGVI4a/wybNXAEEw4gW/bQpmG7wZwISpShjh9EhMR/PKoQHk/xpp3nv5eZs4A1UGV6ApiSw7BwrukLYI8T78A3/66zLpl6yxwtORIiI+cIzIT5Q4cos0PP9ouufVk=
Received: from BN9PR03CA0806.namprd03.prod.outlook.com (2603:10b6:408:13f::31)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 18:55:05 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::9c) by BN9PR03CA0806.outlook.office365.com
 (2603:10b6:408:13f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Mon,
 9 Dec 2024 18:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Mon, 9 Dec 2024 18:55:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:05 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:55:04 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:55:03 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 18/28] sfc: get endpoint decoder
Date: Mon, 9 Dec 2024 18:54:19 +0000
Message-ID: <20241209185429.54054-19-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c90886-c42d-4df2-72fc-08dd1882fe9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WB/VUvgVdv4Cr4PxUq112gqh4aAQS1jVozt3oVGaeBFCkqYBmQdhGmPhc+bV?=
 =?us-ascii?Q?YACk7826zSDbffWUSiCl/NGS2O9cBQdJlV96Vm5BaueW59OJZ3YCXsp74hNr?=
 =?us-ascii?Q?V5Fq2ziNjVd15dlFgERVXJdR/XBe9sBQfNDO/UKZX6O8p+ldZYP6W1KtvS7J?=
 =?us-ascii?Q?aMIcuP/ifIHxpNd4JsegwEWLARfJECZ/axu3acPDLXzYLFwvaRYhLo0bRdok?=
 =?us-ascii?Q?VvN8Tr/U3btOukD9YpZ+CA8yhW19+rrG2d/PATfAcQY1N7w/KrYJVlQrAUAB?=
 =?us-ascii?Q?C3P2VCurk4ei2FDZJ2MMzxwuWEYqMfphif4VKFUzF63yNHmygBN+Oh1o9h7Y?=
 =?us-ascii?Q?buMNLbGrzuvpgHrPZcSQlPs8V5yxDtqn5GdcOToyvVObHXH+MLrY2yq8/xkG?=
 =?us-ascii?Q?gm0Uo1ZrrVvCWVfuLKXd1I0Wd3p9SOca+zDGUFoYXKLPN8Ufwre3VJ+FUY36?=
 =?us-ascii?Q?Mc2URx5N3KCBSpTV0h2AeCZBFOOVkwc7cR+gGLaGWJUmFeFEAFhtxI/f4rPU?=
 =?us-ascii?Q?TfmbLvW7vkUSaxrtPF9EWmKwbVvDwp2wQTkz7HORwIHXgGGrKAx5FhyCVuZ3?=
 =?us-ascii?Q?0Lf9PLcjScZGlyHp6bIV/0uVFNFmAudEd6ik6kOTO8+lwlZad99Q4fwc9vUU?=
 =?us-ascii?Q?rwnZwBF22tjEBsSVvIRcFhDtEIZcDrcPQrUD2iJcX8AfBfMeg89hguh+Nguf?=
 =?us-ascii?Q?YWWr1uXWFxbrR/L1+VWIUdA8CONTuyQZeXlJy3XCPzpGoE3ZHDojxxKLXdBm?=
 =?us-ascii?Q?OrFB38IBfu9QDOKUvsmapcVl8leC9YNedl0UZJlOUraNvIp+vEUtMdUXn29c?=
 =?us-ascii?Q?RH6ihst0njK7+VvsOjQMJ6TPAYoZkP9jVSVGk7i36z8HkDJT7UTX781DoXHz?=
 =?us-ascii?Q?LvsVF0+bKQEHVYq/KLtBUnkn1iMyNRbBMY3tr59hy/txp/c0rgwhPY+sbdTO?=
 =?us-ascii?Q?jcbGLOQplpd+cIa6CNAwwpYqY/k5FSDXjyxSdRnKUZ8cpe05fQP8EgxNvsur?=
 =?us-ascii?Q?dg+gjfkU+kFOflZmEYq/eH/crg8UHXh1QREn9Cmn2ytySrVgkT+t4qQKlZTG?=
 =?us-ascii?Q?2mEuUoqlVfisnqy1X1cT+dIRYI6aZ1NVWpnT0IrknMnpcrZUvutHoc4GuBRs?=
 =?us-ascii?Q?4F8QU9xBQiTkK+Nj4lpVenCxAGepvDO3UM2+LN3ZSuwQu0kTRW5S42SnOayl?=
 =?us-ascii?Q?68txH4U9/bBg8VsZjtkvzwZT++KFLyWn/jMW6ZAY1AScgvV2E7nLiMQJhKaF?=
 =?us-ascii?Q?by8gPKiniq/+GvpKCoNKZG8pPaJoHfM2MBSjDOtadGuNoWtURedmUWF6blrC?=
 =?us-ascii?Q?7ww2lGoWIHGLF8zJW7ny69s7rHRau5CwINp1J3CdQquEQ58RYiWG9ZXHRrBY?=
 =?us-ascii?Q?2YXKUQSvIDPL+05PV0a1ska5rj/SWz7pGk+A0b93ETLdK69OpqMotyoBz9YC?=
 =?us-ascii?Q?IqAB90T3dmmgSo7iuwwfdNpQSWgHWMnGu/X02RMhJpAPSmNxkUiQ3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:55:05.2243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c90886-c42d-4df2-72fc-08dd1882fe9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index f2dc025c9fbb..09827bb9e861 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -120,6 +120,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err3;
 	}
 
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR_OR_NULL(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err3;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -136,6 +144,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
 		kfree(probe_data->cxl);
-- 
2.17.1


