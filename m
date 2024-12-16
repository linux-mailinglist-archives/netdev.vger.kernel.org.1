Return-Path: <netdev+bounces-152294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29C99F3585
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA37A39AC
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7C41B87C4;
	Mon, 16 Dec 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eVgv1IPn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4355C20767F;
	Mon, 16 Dec 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365483; cv=fail; b=e97AFRLNvCRdd4Q55IO/AbDELYmG1Ns7kd/FGe+FnrmlcjsyNNd5hdCmhk4XX6EouZVTerUXPc3O0ExYD4sGSJ35NKLFFCKmAv6ilm++OA9D42q4Pwyb03xrvzNAmUIywNG19HZb6fILgsRissKwxTNTlmuKDKO0EzO4cXjhFtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365483; c=relaxed/simple;
	bh=x+EwlOZWleWKP7BhmhMk6HoVZOXf8rJocYNOcglvS8Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLE4nPK83W+d78OffMbEY7tQKZ3tqzi5e7CiTOkR6aLIKHPam9mqPGPbKB+B7WdjN4I2QtwCWIQmljR4Acvxrf8hjo8qeAji0lnqp+bnbRxeJYahWrBsLFNSvG6nvUwIJL2FL2AxQIwtH/rIN3R83jkVA2uzxs4nrpIUVYjNBRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eVgv1IPn; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7X0nL8oAELLVnwSjpPX7unhzgF+uQS1SGbYPsX19UUiDKpMkvvuXNw/bcih8Sm4WhJV5f+KLkZhAWGImP8hNFmvogWcfsVREtCX/MBWyGyFzBzuqfvZQzNzVbhN4NQksknRYqOnJPlRVISGEYDxlbn0lc84R2uiFFs/4o4Cyb1Ys3EHG7jv18f1gQrX0dJOTXsM4Ta/pSMtUuIcmhEdcwluFaxqllAQlplpmBFyoooWM9nlNPE62w1y6AF0DZo+WnfuajQBYp/sNhwjJFHbEYdiRV5xg3VhVeG6uL1L15/8v7Nl5PWkJV6MV6rvfemDOHimMIe1dQLk5YfdEh0A5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WmX8sKR0E8dlMhjvqfJmMQlknXfqa7J+mN/2lecfEg=;
 b=mw2x8S31O2JDVouZ/ticYxTd3OsQqpQitWgduKZpS2IsJLW43uACRS4/GBNjAb4dYSoQP7dfRlsmg9Jk07fd9EJL+UGnX7zhzXuTZB3RN4Dby6YryEAvB8qdWSCbnCd+o2t0aAQfzO37e18ZPLv+YrRZXSh1vUdbrZBMHyjLwql6/KoVnfCW/cUerAsCSBN4N4SOIrqYVSeAA+FGwGSZS7Udp1481N9fOAvFOR3OsHLEQ4ncMYBs3k+V+/gTF3y7nnuLhGss5/Qyb4KRv0ntpcK4rp9RaGGyUiN28IkXcikjdPQ3Y62BngwS/po/XSJ7iX2bBHYIHFqCblUJFKI57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WmX8sKR0E8dlMhjvqfJmMQlknXfqa7J+mN/2lecfEg=;
 b=eVgv1IPnYd0geW/wLJJGxB5TQGL6QiWC6t/DX/CIU5z8cCmjiEHZbyTiV0byAs+n5ZGumrmE423nKsoOyMcnr2fUM+6LBQ4/JX0K4WNV0//tpaypN6NOSI4k1/uiwEcx/wTdW+Pogw6/a2DCJH/CRyC0kem3T7RSU++aPmgNuiM=
Received: from MW4PR02CA0013.namprd02.prod.outlook.com (2603:10b6:303:16d::13)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Mon, 16 Dec
 2024 16:11:19 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::d) by MW4PR02CA0013.outlook.office365.com
 (2603:10b6:303:16d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.18 via Frontend Transport; Mon,
 16 Dec 2024 16:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:18 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:16 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 18/27] sfc: get endpoint decoder
Date: Mon, 16 Dec 2024 16:10:33 +0000
Message-ID: <20241216161042.42108-19-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb88d7a-5473-4050-091f-08dd1dec46bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+nlhjMBWgiDFkRMXtKqoA+NRLvxABw2rls0NeT1HF63Hfh/8R+uUhlM6b1Ex?=
 =?us-ascii?Q?FG7lXbH4/MzaJzE8Z9FjqTI6UX3yAOjjjHckP7a4Ze32ALpMXq5aFLcm2e4s?=
 =?us-ascii?Q?icYxP5aNXdTWtdC1KWpmcH2EeecK13NS35jBrC/3ho+XcmgQgwmDpBTRWuJP?=
 =?us-ascii?Q?+cCixqeS5eRWgfqlEtXmrqleC92MrAKkKH6oH+Mc+gDrkxBmPaWnF6BwFBW6?=
 =?us-ascii?Q?GDMC3Mt8MeliQVy8xqcZP+ZUTpN04iyfVQfCPZO4uOI267Kib+5X8z9AfWx3?=
 =?us-ascii?Q?dY+Zatt1dK6DM3u28hyRqUY1Yqu4aRWr8DYM0WzH5Iqgv5ZSNZ25RzIcWt/n?=
 =?us-ascii?Q?mFTQUVnz2Zsg1qF15wtL2H4WJzkjIlnq67V9g1BnRDetgYSiKTmFJeYhoYVP?=
 =?us-ascii?Q?KEsxCruBapr7AY0FO7CtOqaIGLwJM96F3p+VGDDKbEeDh+RLvzjlJ9eayO9a?=
 =?us-ascii?Q?aIQroMNklXXLyrzBqEEPiykVF06M2nOfz8tDaxa93MFtbGbuOlvULPGGEZs5?=
 =?us-ascii?Q?uvYeOkOPna5v8iavbkS/hQB1vrbb3QSovuGGOwyTdzmAi/SAjRaBajnlgfmV?=
 =?us-ascii?Q?NwEht9Hq5onnhv+VjGyKMAmDLBfq9PCFMsRXm1VkzghKb+RuRifL6BtPqE0x?=
 =?us-ascii?Q?hgEyphmWZxTg2sG/F6TBAExGj5EEnCBbYv+2+xaH/BT/lzj3KezqoDN3TX73?=
 =?us-ascii?Q?g900vX3FBdJcxXyjpoZd1wB7KxkGTQdqhwebq+E5Ga/9nPipQ0lgYZdnTw/O?=
 =?us-ascii?Q?Kurvoyh+pLqTc+9X9Wb0vCm8fIqwVov7zgXc3pS0+HyzN3U+0r+eJYi6UFiv?=
 =?us-ascii?Q?lgDYTWUk9ROmmm72qvlJhEXegHxEKI2yVHR7eszngLPLGWWX4uhpKTN7gNsr?=
 =?us-ascii?Q?MKmFZ1Bw33RvyX8fQcWa7bBuysLfcKb1R0R+flUx7oebbEEfVBn2wXQobMkM?=
 =?us-ascii?Q?1/93Id/8fr6EZ7yhR04MHC1ovVofHhEqpTzNkhoTwGgedUt2jzpe0JD+mm8q?=
 =?us-ascii?Q?j7ENLlpjR8sZVFLg9g4SNuniwgJp0hTCiWwHZvvVVfICNtyg5nKsvwWOtzeF?=
 =?us-ascii?Q?pz37VnscS/rNqkITTh9GlYvwwnFfEccLeyPeCNHUGLQBgL4hZf5EAa4vNlyC?=
 =?us-ascii?Q?sghDh2NDVuxIOxfb42ilHp6RtaXYroQmTBV2sEBb6q4IVujIC9OluHfdmYvV?=
 =?us-ascii?Q?RplmD29iLIytK4IjX5qNWjV5Q95a/Ys0A3QeCZdwT4SKf4oFQL1wmOZ840yZ?=
 =?us-ascii?Q?BLO7DDDukkITD4sigFdhjNGa2GmCSllgQVv/r+HkzPyLgC+QwpfuGKZoI8IJ?=
 =?us-ascii?Q?UQ0tVHsR4zxn2rM7mp4trm2uUgyuPIEsCoDXgt0cooCW4fv/G1mGbU+6MLwU?=
 =?us-ascii?Q?48expIx2j3IeL24gjADg0YugTR+ToWtk5hrEUsBSqIudlUjI0+vRPqiR1x1g?=
 =?us-ascii?Q?sCi6niGzAyfGaw4BQnk8dBDE96RZ5cvZ99sYmxjmKzbIlnjxod1PGbzIczuv?=
 =?us-ascii?Q?YwRw7SztJF6uhHMOaqnZZdjsT45/xqIUGiqZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:19.1066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb88d7a-5473-4050-091f-08dd1dec46bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 253c82c61f43..724bca59b4d4 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -121,6 +121,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_memdev;
 	}
 
+	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
+				     EFX_CTPIO_BUFFER_SIZE);
+	if (IS_ERR(cxl->cxled)) {
+		pci_err(pci_dev, "CXL accel request DPA failed");
+		rc = PTR_ERR(cxl->cxlrd);
+		goto err_memdev;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -137,6 +145,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
 		kfree(probe_data->cxl);
-- 
2.17.1


