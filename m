Return-Path: <netdev+bounces-70053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6474784D75A
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 01:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC56288250
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1B14A98;
	Thu,  8 Feb 2024 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JC6sI34W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848AC1E87C
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353873; cv=fail; b=Bf0GloNbb2BAPFddwggo3AJptRLE00sBFDlN80txhUcQl5q8S+sAydYxApKF9hlZNc0gETcVxX3uedKoeWAF5uyUxQXHIBl4/MnQt4H37hmL6hBu6aHf6SSgSSmduVx8cSXFPEcY5oWxWiXAvPKd+bVQmTrLzFHJkkq9QG10smQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353873; c=relaxed/simple;
	bh=1Hx6jvCLfZi3QUl7Zhv+Hb3Qwi3nSou2ZYR/ysS3GaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbo0o5b3KgPC0aT9a7tYa1nfamghX2xStlPmZXtt7Q/VB8zS9T0jEEd/zPrFGvxKMe0iWzphS68jLJBYiNPrym5Kjpc4ujeClrdANFneOtMwdkfnDhTGCoUwb2fOLQ6XNMA/3vEGBYk+lh5CDIMYnwHs0h7nyFI0/uzGkP4Cw5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JC6sI34W; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKhr917vUC1kdA9XGoiWyVVs5FyIqCRNQDeQAm7+axm3u2UnYoTMPA75zp07cKF2L4s7Io9GwvEyrSRNqBbYuPcJIahtdi2O89tGlzomqNovp51IiWHwMf/Hg808c+GrKjqaVQj+y1G3Z+CkedwRqbg5zVWPUW8zvgx8Ivf3g6TbfcO5XjU+AsvUfxUuMVQWC5WPBNExoFJ4xxg8htOFOIgIefeyaWwIGTW0aFFzTe+qjJO34OeltA79XDP5fhdJGb7IJWXTunpavNw/why68bmAF5AgmQ8TQMaHtzn4Cw6iI/ZoMccDtX8toyQNVjQFN+WOrJvdQkfjy1kPrfetSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWBDBZU+t5qV0/ss2PHyLjQOrWw+uX9ln9M6hrAX/EM=;
 b=nTurvsTm73jc6y8IRLUwjovGVzbYE1iDyzWhMgeCNicgagFUHvPqMXM+281kj1F8ibcVFgQjZIFSThBD+d94qLXx+4Yrl3DuI8QKTgYdzLwZl3gjSkwzcqIKBdiwyIPPe9mtnRVmQkCTtyIVW9XPxinkzui705TwD9AjboJcZdJSqhfMu6sGjkw7sBgzELnhbwo4KVpZ7T5CznE9m32Lyn1Sr4fD9kWiPA9lwmdeMMwfQnqzfLI2brMGJZJqJvo1PrIXoVyV6JhXHJl6VVHuDkf/ujOtdbDK8FX0CQprn4aPDhIAGdRieOlOiQ7MAsY6KtJHe/NBYsq+QIhW+up1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWBDBZU+t5qV0/ss2PHyLjQOrWw+uX9ln9M6hrAX/EM=;
 b=JC6sI34W8jMkyd78Jr1q2heePE4VNmYtO6AEmMQVU6L+6iaoyf92Jzahre4j5apyevJWeOAxMkEBRRb537zS7k0IhT+CoHs2RFfDF4PMlgMumuPYl4KncCKzfIRLXSLGlpqnIScdGo/3qVlry74IMt/Ib5lzYcBQUzLw0MXaRBY=
Received: from DS7PR03CA0314.namprd03.prod.outlook.com (2603:10b6:8:2b::26) by
 SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.16; Thu, 8 Feb 2024 00:57:47 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::67) by DS7PR03CA0314.outlook.office365.com
 (2603:10b6:8:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 00:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 00:57:47 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 18:57:46 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 01/10] ionic: minimal work with 0 budget
Date: Wed, 7 Feb 2024 16:57:16 -0800
Message-ID: <20240208005725.65134-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208005725.65134-1-shannon.nelson@amd.com>
References: <20240208005725.65134-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b01e939-f180-423f-625d-08dc2840f770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PF1QjHkrP+YLHD4U1/GXB1utfxfPTvwCp8tfPFbAnt7vKBZnA/ixNXbuGMvg6bxnQYak5sVnwLdlRzHIXT6XhT2LKm6a0iDAZ3aHGro2UAgXx2hAls8exTEXzD3h5fPVVSMghfKm5zS6LDHLuOC+9MNQhI7rnKhp9WKRFOCvth0679B2ficQ7tUttitxXrFuNaZCnNvEuFMBfexOkZdmYU3TiDA7smYfOtyuU8Hqj6miY47mVohaf/TDaWZ7cm2RQqDGsJTlO0e5qCBfYn9DmKxWSB5zqCU0bbtwaXk+hCcPGEm3w8C7YLZ0BlyK5v5Ee0QCaMhghN6baDdY5xOaBDXDzBatU1OjGA/IuvDLCGEZi6IqiJYcCSHyEsJY52MOnUyIjAHiIs7AgqzcPSIclqEQhp8fahi9ToAr1mwurJajudx1HpAAn43KcMty9cETFgGronlZlZFT7RTVa2fNpDhafAUgL0Tz8lUKMQ490p0hxFyuVyHMGBZNkM4SfzBqSEWse8TPhagAWsoCMYX46whOUcrbCAiIePF4n8wztw1nOmc9TJCPOCt5aKsXqCj8nQlmAdhnWH2oxCOYgKqYAQi4dd0+XgZ6WcwHyp/PqjQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(316002)(86362001)(478600001)(16526019)(83380400001)(82740400003)(426003)(2616005)(81166007)(2906002)(356005)(1076003)(26005)(8936002)(6666004)(70586007)(336012)(4326008)(110136005)(5660300002)(8676002)(70206006)(44832011)(54906003)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:57:47.3185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b01e939-f180-423f-625d-08dc2840f770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986

We should be doing as little as possible besides freeing Tx
space when our napi routines are called with budget of 0, so
jump out before doing anything besides Tx cleaning.

See commit afbed3f74830 ("net/mlx5e: do as little as possible in napi poll when budget is 0")
for more info.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 54cd96b035d6..6f4776759863 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -579,6 +579,9 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
 	work_done = ionic_cq_service(cq, budget,
 				     ionic_tx_service, NULL, NULL);
 
+	if (unlikely(!budget))
+		return budget;
+
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
 		ionic_dim_update(qcq, IONIC_LIF_F_TX_DIM_INTR);
 		flags |= IONIC_INTR_CRED_UNMASK;
@@ -607,6 +610,9 @@ int ionic_rx_napi(struct napi_struct *napi, int budget)
 	u32 work_done = 0;
 	u32 flags = 0;
 
+	if (unlikely(!budget))
+		return budget;
+
 	lif = cq->bound_q->lif;
 	idev = &lif->ionic->idev;
 
@@ -656,6 +662,9 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 	tx_work_done = ionic_cq_service(txcq, IONIC_TX_BUDGET_DEFAULT,
 					ionic_tx_service, NULL, NULL);
 
+	if (unlikely(!budget))
+		return budget;
+
 	rx_work_done = ionic_cq_service(rxcq, budget,
 					ionic_rx_service, NULL, NULL);
 
-- 
2.17.1


