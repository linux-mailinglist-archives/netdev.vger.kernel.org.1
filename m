Return-Path: <netdev+bounces-152291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01C79F358A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A7F188592D
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E58820764E;
	Mon, 16 Dec 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4+Bnjz+4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B220764B;
	Mon, 16 Dec 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365480; cv=fail; b=GEntTacGdXRXrec+rqYqu1eseemK9ArcaQhlvPpMzblzg3yTYT3VH6pPFrCvySvWIwCG75fRafsohg7dZl7gaqB+JIOLU+uJPxwUvuwHPQMpMhYEtb17hqdy3p8mGKYqF4g9is2WnQEZ86k6CGccUO5fNgQpBm3FF9mOVxmWTSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365480; c=relaxed/simple;
	bh=TkXVkaHNgvARJof2axZoX2tY1SSFlmXDfqr/G4t8C8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwxFmvHHUSrplaGSPZlb3HHpe2+hSGmq3L2AbX/2f/CS7XUUtZ69n4EGn6+Ui9GuNyLzGmRpHGh6W7FjudHTF6f7879oWAZ2mAgRSTsix4R5s+Zfht3lXpsfFzsXH2G4D82ZqTSljGxfSSu4Z6fMnmV0Gv4/SIL6BC3atfMlAyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4+Bnjz+4; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGJpe++4V6DgJpPOa+vPgY92Z2VInmGKh7ESdevVF4Tdt3DXrxjtUn2z53uXBfiRZ0TSTVp2OuJc3OzkXnrbbZqCfetoBEptzDVMezA9WFExwnurUxoUeA77xyOAo01catGETN6MhxBfuCEI0TAn2LD2hg/SiyMkBr7kNcJku9E23+zLztcKoMnYXZDm3LoxBJrad86WbI0AnbQaiz5Z94pNIOPpGAoSayIVVAhEi0ffH9Abet5PSfhEeVVGga2z0365gVDncYUW8MCZBUEr39qMt6DKf6EhmWzwjZejs3w+JmS81+AZNKgGIOlYqL3Y/3Fu6QFKifigtdbNBip1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i4/u4I42T4Bmn4KAnv69eF6vmNFUrY7EKamCD3pDXU=;
 b=n0ODI1CqHD/cZvwVtTpIXoARwLiBWQ2RRSbebGmcKN5QtmUYwpX23KoVGirQ5JbRzSgw9p8ZRqaXMjOSuT3DJUtSzKpfZc0Op7Wja2lroYgiC2E9XKHxwSw0DgPbKy5rGRUvah+q2/zpO9NnYTHcKMtnZv9PU4aOQ3vwx2uPodLV4/FCNZveB5MEsNXpTqiGzSMrYHCoHEcO1Sdszf4QnbIvTMyOFllERaAp+dsScNO3NxkNP0bL3geF3+/wdr4MvRP5viA0acnVnwMYbuidd/sZ8qrMQpxtDBnPl+NT798h9ZfZUy63nzEJNuRKxprWgI8a0913CgPP6PZo5g/enQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i4/u4I42T4Bmn4KAnv69eF6vmNFUrY7EKamCD3pDXU=;
 b=4+Bnjz+4s0ce/XWGZJCA23Jz828qkHVuLOsoR/tUfBBCiFNo7dXzm+tGRRffiweVhqdAFq/oZ9tH69uKUyG2DRlaFErfAhiLxA/2AnxikjdSQlWx73VmHCEGROe1s9VL1ltjG9TBW37+y75dhm3ydokNVA84+9Na69sF/qBuf1Y=
Received: from CH0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:610:b1::14)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 16:11:13 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::2d) by CH0PR13CA0009.outlook.office365.com
 (2603:10b6:610:b1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 16:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:12 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:11 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 14/27] sfc: create type2 cxl memdev
Date: Mon, 16 Dec 2024 16:10:29 +0000
Message-ID: <20241216161042.42108-15-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|DM4PR12MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 26722352-6044-402e-0fb6-08dd1dec42db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lbYMpM4PE5rlHiW355y3hhTAtnyAIi0CZlk2vvny7mlDEHISfnTwAG3zwMHP?=
 =?us-ascii?Q?bxR8gh7GHthbW9E4dAlrdo3WGZoxhEM2rnl9OtQjmfFYe9BQdwi1mKKUoUgt?=
 =?us-ascii?Q?gV6I7NI0GCpz36pSnZddPNryC0LrUs0K6evOo60WQAk9r82ap65PCv3RnDOy?=
 =?us-ascii?Q?iq+2jax0vWR+vf0oSvxZm5O5/p8UNMlfIvLm32oh7rttd5in/hL8M4EP/szi?=
 =?us-ascii?Q?6Cuw5lsmR9MfEzWXn/cu9Tr5Bcwxwfnu1WHzAIgMD4noDnogZ4FZn+24giGd?=
 =?us-ascii?Q?GeTFY19D2vXQuDh7Jfv0uXY15SbZLIWjT/USU3klOPMLtpQf/OI+zABQmTNz?=
 =?us-ascii?Q?5aLLz6bn4ayxO8pcCYxXDWZ6D2aBKBpTj6wLqC70lhOAaQXrLfWyKS8H/9Dc?=
 =?us-ascii?Q?coWNFCooM2VevAOZTwknhyPA7MbrN7ZnToUgaROQxbr5QwH0pqA5ue86Oc96?=
 =?us-ascii?Q?0xraYFV7+PrXU3wgJN9/0tSU5HtuGz3geDYg60g1Z9A16RVkWUAxfLabYkv0?=
 =?us-ascii?Q?D5ucKeLS8ZcIgnwmguRn31nNkKktlfveDCXSTgjs94MsclwUOovW2J/ZASrg?=
 =?us-ascii?Q?JTDNcpAs3k2ZQ+MaJAwsmvmjpvTo5pIB+eqaCZ4Tig6JZKqYcujkbw2jCeS/?=
 =?us-ascii?Q?/O65Q9T3hG0Q7uWGce4J1HG5RaajMQcFMCvr4tE3vEQAWOuD7+uPDqa1wGVv?=
 =?us-ascii?Q?F43XfqJfIpMCns9+s1/qplKWXyA6r5uzWbgDtcyWtdD+6COkH04X1YmyE55e?=
 =?us-ascii?Q?lhjv5H2whafao7wWOEw3oVN0w3kuAUOJPYF2+xVbEgUOXudLKLlGU3py5BgC?=
 =?us-ascii?Q?8WUAfPFiEsaCGwr27Viy0rD5/Y0EMW6ejekazduseNMibX6yTqUZAHJ+ADY8?=
 =?us-ascii?Q?M80siOIPwCwWemIQKpAznjYPH93HDqrIis8c3NFVBWmxjlCFeTQoRL4y6TEA?=
 =?us-ascii?Q?6C478dYYXJAspnhBla0qU6qNy/IDjbZchRRMTmNsQmm9QjNAI0aTpCgHgXBr?=
 =?us-ascii?Q?usI42yPH6p+M+3Zm+JWZHGgDXIZ7F9dFHvIza6ipbBIBHRhVAS6llaMGIxTA?=
 =?us-ascii?Q?Z8lhiICDlN6MR0DVOi0aXSmb2BoI7PfvWBTxWVSSFmVKgQMaNHG9kE2Xvo65?=
 =?us-ascii?Q?8vsdZx4Y+j3HzNZu/rDaCwMBSASGaI1tIZWOiC9OOdXbG3M8amSzcpwQ3osv?=
 =?us-ascii?Q?UsWYJ633XyeCP/9up32RYPyCX+bY5T2qH5onUZTW1LXcPLLSemrA0mttBMJe?=
 =?us-ascii?Q?poTV+Nk9+/LKyItfZl001C9ARdN0s2z9qIrXKw6DDkgnxRCxMoz2B+QIesER?=
 =?us-ascii?Q?6HdV3m2I+O8Vn2oMF83uAnXPMD6SwPblh/WOfWHqp/I8nXg+BmB+bpEX9yGu?=
 =?us-ascii?Q?Ka3o0W+iSEqt80xpMnGgZbCe8w1S7y1KXSj/t3DD6u7yTGsK2Dy366iXjAho?=
 =?us-ascii?Q?pgLTYOxK5oTBepb5JgqgcK3gOETk5tlGTz5RAVlb4mhF/eB80cMkIyXAPkqM?=
 =?us-ascii?Q?3F+BFfv1Et4EX4vLG/SwhEDpQyOmYqTlTkOE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:12.6681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26722352-6044-402e-0fb6-08dd1dec42db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index c982a4cc1119..70b47b7f4d5a 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -96,10 +96,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl_set_media_ready(cxl->cxlds);
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		rc = PTR_ERR(cxl->cxlmd);
+		goto err_memdev;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 
+err_memdev:
+	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
 err_resource_set:
 	kfree(cxl->cxlds);
 err_state:
-- 
2.17.1


