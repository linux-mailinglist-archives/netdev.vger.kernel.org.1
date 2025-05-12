Return-Path: <netdev+bounces-189830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F75AB3D39
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FEC189862F
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2817293460;
	Mon, 12 May 2025 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uOIgZyC5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC6248F43;
	Mon, 12 May 2025 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066301; cv=fail; b=jQwUhez+aG3KEEpL1SfBDHwuSOLf5UKee29OXrUaYDufH0ZmZ2wSBXQkEi6DH9DfSXM/0SDO21lXKKpWgkbdSRrEAKyzOlM4UzA14i0brhbf43CFUFegHa2dJNXGgfyuHalJJ6Th8KHQRRoTy9druzFtTBBEfDSBUvyw1Klc+Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066301; c=relaxed/simple;
	bh=3ZEtjft/lDIX0aA3kgi14zsHzPvPrLZi3YpmSO9deuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPLmVTYWasPChgp1WDeL3clZYYNtUsAKdLKHMu+YPYpVJ54869uqiqD3yXlq84oXh7S+lTEJBE8HPDv6zepWD3f1kWHpylSC3hZvUs7/R7I7+Qow3XnjIhaCEqSNI6BkWEjVrdWF4+gH8GLtA/5Wix/k0UxxQiWUpT2ZJN+bw2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uOIgZyC5; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz8xY7003ac3ThmT04XaSxqgqHM5PsuDbQkh0Ro7uz9BnMeK0joXYN5mom5haIaN0VJ5kspgNEA+5FyhRUZ+GMgMph2f902rWH23Ab/eY0NYAXoMfbh6QkJmEJbZ4i1I1Df2N7wnXVgxiMMA+Fv7lvRHQ/OoVOKBrTlcxEzNM21wPSUAN0MBkcJ2oc1qG/O10vsuE5cUzsEWIRKMZ72gWvoU9SYLiWqPhsKzBXIGqZYpruqwcuD7eiopMhpwJ5KHqsRPKMhTkvVLMxLKncSEKlH97EM7IQ/lm7gUrbhWoRrKJOxCUH0EWzAr5/8zBM0rDg5Hx1K5NJyyVKEtUjOp4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynfdElytJtuBZ3r1qvFAtdm4S8RXlZs4WJ6ScBSU3Fg=;
 b=S17TX8tYcMgnuBvhGHewJzVxqfn9T5L3DdkgZbV/1wiMgU4zYj2i8Xq7tWM3ie/kx4kUWUYDlghp+d5HPvcc4oauocv8HE+6Dgq/47QKMRKdnRw+V0bo2beGxpOZuW2pnmYFkmvfZyHcqMB/x58nk2oJQAu8tcmtRnOS1I7U1/ywwdgA9JGMK7tgioeSHOOI8Nn9jO/K0fQBHdvsjcDzA5oYoRa/OnDlloHR32TaV08lnb++1AP4XNsPcxSBsjwdAbEHxUpG+69vGVE4StAsAgOriBPSj8N44Q1BdF7lbL0XrtT5UfR8GhPzydcfIOKs2d4TPGCl16YH1EJMtLu4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynfdElytJtuBZ3r1qvFAtdm4S8RXlZs4WJ6ScBSU3Fg=;
 b=uOIgZyC5ni+VeH7Ob4UEX+/KUgR7T3HWj76UxU1Ay3BkwXa8L7SmXc8XGk2L0HYUbtg2/AA5ljwHe0I4sIPWd+hqB4bGBqVJFZrxbnFiW949UGqY0XR1Krt3oipiwgmIbksjts6ER5q9v8AyTRbAW3cakW6GJBxldbqmWsrLzk8=
Received: from CH5P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::25)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:11:37 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::d1) by CH5P220CA0018.outlook.office365.com
 (2603:10b6:610:1ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Mon,
 12 May 2025 16:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:36 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:35 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 20/22] sfc: create cxl region
Date: Mon, 12 May 2025 17:10:53 +0100
Message-ID: <20250512161055.4100442-21-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: fcff1860-6482-485a-e1a8-08dd916fac39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oi2hP3ui5sepGDyD8/eEsB47wF8zK+nw2W08txzfuauYGHqsKm5y1jUPR1ZE?=
 =?us-ascii?Q?IzOw94JopmAc1fV3K8NEqmMwMsfEUIuW/E3Nz8OhLXeoXoMd0a2kASJosyDk?=
 =?us-ascii?Q?LnDyo0Xla8f4tC1gaQ7GtK2GkTdRg9ZqY4rX/lQ3rtobtY2JQrKkmItR28dH?=
 =?us-ascii?Q?Lk5+UYGu4y9dw653qg8wRRxGoG5et/oysVTS/RM3aUSU8oQ61aurDR9Yafju?=
 =?us-ascii?Q?hqsYFOKKTWs9zejfWYBuXqEDNC9p8NPF6H8T9A1zkkvxAp0cT75GQsJCkX69?=
 =?us-ascii?Q?IoY7PMDoD/1KAy0nKb2UjccxU+j/M/tstvN4Pwp2qUCwxWkr27pQQBXeTg0E?=
 =?us-ascii?Q?JqqC8L8ObhNYgPNGrSvC7kGfxADpS/RLk+cRTGJAIoiawWB/vocMrV/1OCo2?=
 =?us-ascii?Q?h9g3Ttj80yemvm3bJV+WEZ8V7QyrbRpY65Xo8ZFl1j1iTpbk0BM+4EpmfIC8?=
 =?us-ascii?Q?WWPTDsGjTppNws0E9leHIbDjnNTmeBOvYvu3MFkFdnk4VI+AvC964oOv85Pa?=
 =?us-ascii?Q?o/AoBHnQe1+SsaSF54rriQ7in2CLbRSIFIa31dTLgqaiLjznuqyyIG65BWlD?=
 =?us-ascii?Q?D562OesNKhlLZZWI1HaIT4BednbipaCQcFHVpJR7oQ7Smn+m+HKp3++X2zxb?=
 =?us-ascii?Q?4DKM5rCLN/R59xY62fgp5G77H0D8POzO94oLbXpPUXHgNrQC6nOyKXlCwlIs?=
 =?us-ascii?Q?3jXFEujcC3nXLlUNg+MPRPwuHi5TxOvKDX00N4ccrNdbuSmlbLEb8O++B1mJ?=
 =?us-ascii?Q?GBe5Ouhv/e7a/A7Low4uOwu+mbelUllzTL5Fpr9dmJSgN1h7SX/6fGiV0OId?=
 =?us-ascii?Q?3JXmFhC01bMey4bq5CBVCnpgp4hOj1hRPVaqjHvuBRaghCK3tqheqCnAEVFs?=
 =?us-ascii?Q?avOK5oxIt94K9jBB/moEN9tjooxJrlsQyW9B/NGoilap466Ylf7X5m8MR/lR?=
 =?us-ascii?Q?YuZ3zdbyL2Eoip9ibNsw/WvXm6IzqNpTzAnoIVsx6V7r3UzJqvt6ZiPZLVGc?=
 =?us-ascii?Q?/9Xjzk7xcTnwoPhUaqpCNAYcezIT+xCqA+vJPhtXaB3YLy1WLSNSd5YriQvM?=
 =?us-ascii?Q?xVhtHhhBi5FFmqr1SpqGvJJ8CfHNclWqkq9RcFz7RYMcqmYdG7j2KggtoeC1?=
 =?us-ascii?Q?owG0Vg//BxcpUpbSOSMKxJFTXL8gUEgPSNoq5Mg6uA6yBiqB1z8xBTgNrnRV?=
 =?us-ascii?Q?P0K78BeEN3FXgWA8Pbn+Pi0LsI4iZ7+6pl+KZjJWtZMGu+GCDfWCOb4ZnQcG?=
 =?us-ascii?Q?7IQKZoTqa/zfxQbT/YUxGvQ6Yn9GZ+SGcjJd9W4qXuaoOLw9E3G6mtu0nM0e?=
 =?us-ascii?Q?8ZEIoFIv28yVK2WixYjw/sYzH8ds/7DAmsc/QH+TVQHI9HmduO+mEEpLgSjq?=
 =?us-ascii?Q?BOIn3kwR/4P4I+c8DugtxyVc6NUwMtEC2XutyUvPBEwcYJPOaYSIfOO7uyP8?=
 =?us-ascii?Q?ASsOcRvpnaxMbINyTPSzJf3kBldeOY7D2Ud2BxjprAgdRgokORDS0om+ht8U?=
 =?us-ascii?Q?Y3t65OeG0VyKICUPEL/sHUjDT5zhKBERlbND?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:37.2544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcff1860-6482-485a-e1a8-08dd916fac39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for creating a region using the endpoint decoder related to
a DPA range specifying no DAX device should be created.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 21c94391f687..4323f1243f7c 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -111,10 +111,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto sfc_put_decoder;
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled, 1, true);
+	if (IS_ERR(cxl->efx_region)) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		rc = PTR_ERR(cxl->efx_region);
+		goto err_region;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 
+err_region:
+	cxl_dpa_free(cxl->cxled);
 sfc_put_decoder:
 	cxl_put_root_decoder(cxl->cxlrd);
 	return rc;
@@ -123,6 +132,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_accel_region_detach(probe_data->cxl->cxled);
 		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
-- 
2.34.1


