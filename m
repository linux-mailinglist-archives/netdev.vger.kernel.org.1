Return-Path: <netdev+bounces-152287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FCC9F3583
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4326188B3B7
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6FC2066F9;
	Mon, 16 Dec 2024 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z/DoeQU5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7932066EC;
	Mon, 16 Dec 2024 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365473; cv=fail; b=u30KUkgBS56h08DGEfHGIMzznl9pGFOB9ZkVXNeoNEa2dMvXr5axAXpjdIfvIXj2tBsT0SV4bG2y3CEdEPjMhAApI58C/9sbLCufqcz/B+kzmozJQU/Rli5AmMASpu6u19rJB1INoqvop7tVJstlufHWyuQAeYOLE9uXCt/7vqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365473; c=relaxed/simple;
	bh=tMohENxcRG6nI8+/M1nzQ/49+kdtnv/GK87czR7Qeic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDLX9AMaxRLqbVnFkcdcYh0kapYshXYaMpIVI5VPZht4qvPapJ67fVMq+kXaj3w1htasUvGoDcQ5EVyFuhxNP7mCf1WjqSkl8ePr9Wfk2gsGKyRWu+0rY2hGJ8dUuJ1o6vMeVjRfq+kkN5Hn+p9H3n3W3ol2iwiN4If9/p4oJX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z/DoeQU5; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCNxFcOR35YlBvRLQm70Nm9+Bf3YSyHCLCBI/Qm/DwWd2Sy8ZSKq6LmS17pUcA7p8p7HeNHjFiNRQMDFWjP1iZ5HWmZ2XIIkMA//hjKheLl+X9VOw8ZTSpywBypqkIBkLuURA+tjYLoqJlZbaqRxBZgO1Zz8nJkYhBqyr0hP1RRY3OlQ+W0HYrG45tXOFjiDXnqxcRcqIwJuvLmpjhI1vN7qfnrKTvXQmtuuDY6vJgKSbTZw0I2L1/2dHyYJoy7Sl4TCVur6PttZqg0Z0e/xK60lzYtsrtt73xn4eQPhnhHW38J+SxX7U2kw1WFb5Jd3xq20Qauf8u83NudLHiLkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6CfL9QDC5NuEXTyKlnbvucUXgDEZGPvXSFQ6zaPtcc=;
 b=rAX6KZjKlP1hRsH2i5LLdHF9bL9ojd4JzJPCqOFDcZl901/NLzdIL/sfOvt+rsgDP0WfjXhaDHkqQEso9MUBGlNvuYsJj+IkGXqGhoKwQLcuAwegwEqGTuaLmsarzFgh9j3h25r8/hYEvvfKjWdH3JucydMmkLtigHeigWd8H57ndmQZJRgk8MSZgaR1j1jAsSD5dWjZ6WvsPQT0XYqh6d7XHLuOBrSmtvg5XuUlKrZI835ilWSIkcj5A3srmDLgYLZMY9UN9xKAe4ahX4lnUjp5g5VWrsp0Y/nlqkOD2YyS56EZ0x9HTqWcpd0Z6D7dqdzqzIXvUHQKdYBYtvXF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6CfL9QDC5NuEXTyKlnbvucUXgDEZGPvXSFQ6zaPtcc=;
 b=z/DoeQU5ndYRS6AYHn44DrbviTyiA9CZ4hUIX5XaRWBTawHSz+CSCO1TTHMF3HwXL01gmR/i6Uajltn5RMYos9vNzdLk+7Ox8h4MoSBHERWHOm7ZhA6WyXfitJPAjMIaD0Zfqc9YmQ3VGQm3GUXIbukUZG2YuQyeK//SByJtEZQ=
Received: from BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26)
 by PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:11:06 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::3d) by BY3PR04CA0021.outlook.office365.com
 (2603:10b6:a03:217::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 16:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:05 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:05 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:03 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 09/27] sfc: request cxl ram resource
Date: Mon, 16 Dec 2024 16:10:24 +0000
Message-ID: <20241216161042.42108-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d16355-3f49-49ea-1f26-08dd1dec3f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?adRoAzDeVWN+XPBDMLoX34Ux9hSqNwEBAS4zsxGP/VwsSOfMdl5tlpH735B2?=
 =?us-ascii?Q?c05x5qfRdkTCiDUruYku08nNucro6YW1j5w9H6C+cALTre2oVE5+tare6S3M?=
 =?us-ascii?Q?eaPVVPVM1h0jU9ZjjgzXHf0t2GpBnmLvpgPrg4f2DrJvP7YKneYyjO4054tf?=
 =?us-ascii?Q?1qYqAykec059+fFkDIErwrupQ/452ArogDumI9KJ39JxpBdglE1DI4AYGNOT?=
 =?us-ascii?Q?dpslb7z6YBnnSfT9H7g3KaSIa84dMnj+047xp3XEIkG0UerNIa0ktzCDNC4g?=
 =?us-ascii?Q?ZC4m4kESAxw6kGfoDPXmuL5uBwtPiMP949lnzI31HhU3vyq+dNIH6T9+SmL/?=
 =?us-ascii?Q?KhUtS7Ke3eF9+q4JrpSMENEDvY6kBKIsl+QjE5yQIrSOiVMhTvnydD/7V3IG?=
 =?us-ascii?Q?6p6P9H7hiIxcpgBP+NJhejjPYTXXxVhg90JKpc0aV9By0YU7i9PNYfH4YDKf?=
 =?us-ascii?Q?meIiDOF5jLgDVislyLtWSS0z3PD+EATftKcTNvyXXhSRksWACYwf2GOSPLcl?=
 =?us-ascii?Q?YdBBaMDvx8H9IeXRqmQk6D/Hbw3EDgOy45dGSkPzMW9tBjf5UhFCGeSA0yh3?=
 =?us-ascii?Q?fxEsl/g7gXFLEBEsDEiP+vZpfjqRsUTv+0ZSWPqE4Mmb+/toQ1Fx8rTLlhAj?=
 =?us-ascii?Q?AXkWbbleFmx6Bk2UY85v8l9fhCNXoFxjSRGl96vwfBlI/HTH9fRJyhs6+0gL?=
 =?us-ascii?Q?CK+X8ghSQaHZER4VJumuJFMfLI8xnxybY2eYNv3tdiB56h+u1zfzo4eU7N8Q?=
 =?us-ascii?Q?kIvuWaXU1163FWS+an6CoFVYFn9loHubk9qLfj5K+9zzbEwjTiyX9RWAGlEH?=
 =?us-ascii?Q?Z8WTuvh6lxCvCjPVJMTsCr1IgAT/Z2hoYwCi9N/2EKjPjdetz8nQX7aqCIiW?=
 =?us-ascii?Q?4uRhZCILFSnhIH+Yr8SbTgC4r/KLeVTkBUkgvMzZNsGUyuJmDJzaAMANLfHJ?=
 =?us-ascii?Q?9IZ/Ex02JxcsyQaDwNoGkBMRtNy1Cxp43HFkdvJ0045+3QsEOxlgCJ7SgY2e?=
 =?us-ascii?Q?L8BKJ7Ay3EaPqzmO78KdBZSI2iH2CiloCCtHl0pS/DZrcrTOIUjmzmGkgRxJ?=
 =?us-ascii?Q?Y2SvkorIzbJqa6+CnafTGzALZ9QyzceB9/952Cy/Y1nK2/G1M54WW56FB2Mv?=
 =?us-ascii?Q?DX1L8Ff4NUhTT46ivMg2icp8vc7u6lMl30uB9zZRMBvnI5zXtXuMfmmCXrMa?=
 =?us-ascii?Q?VvvAtkRcLkkMR1zPwR3EC9N6nGbeB6CMZsANKTUUoYzFuHVoBdOxWQ0KgkXn?=
 =?us-ascii?Q?fibHTbf0Z7XCt6c0b1n7Jt7Gw51X+K9N9d5a37zjGwrXiMJFtOeeneG64qh2?=
 =?us-ascii?Q?P64NbY22w15cRGb3nZRVGmyiwvgf74Oa+nTByssD+PDs8jNw5l3YrqbZe49r?=
 =?us-ascii?Q?sVVzL+qOuDsjg8WLpPVtdvGwNcBvc8y3xQPQ7RvWSeXoB/23DpsCMyrgVskx?=
 =?us-ascii?Q?Jc4vQGs+iQeAGYTl3eL9kSQ4xZMNReqbkLufjdDElVUIUBAQ86PPqbnFfxvV?=
 =?us-ascii?Q?FsB0I4cI1wSxEiBEkKXxKrVzjLs++tMEfdQg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:06.2399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d16355-3f49-49ea-1f26-08dd1dec3f12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962

From: Alejandro Lucero <alucerop@amd.com>

Use cxl accessor for obtaining the ram resource the device advertises.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index d9a52343553a..eaa46ddb50e3 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -85,6 +85,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_resource_set;
 	}
 
+	rc = cxl_request_resource(cxl->cxlds, CXL_RES_RAM);
+	if (rc) {
+		pci_err(pci_dev, "CXL request resource failed");
+		goto err_resource_set;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -99,6 +105,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
 		kfree(probe_data->cxl);
 	}
-- 
2.17.1


