Return-Path: <netdev+bounces-70696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF73850101
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5519D1C245DC
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FFB184;
	Sat, 10 Feb 2024 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zIXg2b2U"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8D163
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524008; cv=fail; b=BSE/3YB3BJkBPFHPcu2KSupuTNdMF3MlYCl2MyymaDs0/s5y2BMUuw5lnRVtMZNznynXjdBb/5mLG6JrSMxMfh4BPYuC0/FHaNZrO31s1S9dr0fYcu6y8a7X9fbFXqltc4h6aQhd5sHEwAgHN4GTe1yR2Yp2wK14rW5vJcQaITE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524008; c=relaxed/simple;
	bh=vi6roGYKjWTJsgTQ8bZyfRaOOYNGx3xl5FN8A00LDOU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iFUzNv8/7FypogedPSSUa2XBMzeXymGlnHMnvyCn/gq1Vq8dxsc+Y5wBu6PmDIROMx0vppiaeSpX5E3qbxe5wNVzqE/AvzyjbeOb34Vb7dfJF1145JwOP4ftoohZFTx9bGPsWEqK7g4G1Mmta+r2BNjSaX8QxiE0M4BLKs/AS8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zIXg2b2U; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTBltkIJ3oiChxi0pVbVmgM7bFNHXFsrZErgsX97JJE2CirkbKLjIwiUIXJiLxChVs/XZUqSBr+GbjgMRSCyijaamWhzx0D3WeDKk2g9mVENAMSwxDnKE7HC2vEtNn0tdEtKkNDi4CNgVUsh3eTQUrcheRG4CPaHWmNdKbRcC8EwLAFzoEs6O+5C3FGUTogJq4sdKc666BFHGio85+Xt1cD4n7DBBDgZr19sEN83qlmWY1BjE8wHlIp1dEZdb0JDlk1Ssoe8zOzJGpZt6wk1aNSRqRP7CPekk6jrlirIBEEPZ+xmVbdjOCJwRqIj7EtQgc1JeRRckyZRvUIkShtK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2poCc+dK9V+NWj6TQHi3ulOz6tBNeMXfaLZZ3beLL4=;
 b=jW3CBHG6Dp+PysInRSrxmRZ6J7FMPxp/ZEYBwdHeLTBQO/w7aoQ9AKxXxQ29f2V9YLwlW6r4+2dPLdNJZDR5ps4KYPWtEvkGGuk8Y9WJuQTFrBjVs1X0GmYeCm0yEjQHfEjHjf1mseMYxhUCMRUij3ZFkAlkDlbKNUf3xzwGfz19DDBiaFj4icRgL4wmZFpEhbC2f8pWddKTZ1008uQ8SXSTl173EhWtnmziyaAzI9tJ+lmCjudVMqbDCPWxF6Sw2EOLV02FxRyoVGyLHOaG9BMcWncX0RIAObA2rfWgVJxEU9FpwSGdf3WyWLRReeySc0swEghPjnxcCXaNG2Hm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2poCc+dK9V+NWj6TQHi3ulOz6tBNeMXfaLZZ3beLL4=;
 b=zIXg2b2U6qa4F6z1WrS0GAsRF3moH7t4pqpOiEtWq+1uApn5hGhX44Lw8QEV4hZkOnszTj36CRScf/wOfXriSkjbhdCPqV5/bLkcoIGkScrmEx8B3cGlW6+YURgbSjU9N0casEdFvgRpwHagO9zS+Tuki15uVNLDIpZOcApT+UY=
Received: from MN2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:208:23c::26)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Sat, 10 Feb
 2024 00:13:23 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::70) by MN2PR18CA0021.outlook.office365.com
 (2603:10b6:208:23c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Sat, 10 Feb 2024 00:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sat, 10 Feb 2024 00:13:22 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 18:13:21 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net] ionic: minimal work with 0 budget
Date: Fri, 9 Feb 2024 16:13:07 -0800
Message-ID: <20240210001307.48450-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c66380-f793-4d41-d345-08dc29cd1813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mjkMWaL+F/+F8u11qj7euiYbMJmyrhJWj+Qi71ALWOzDlcbpLcD3yZVxUz3UujLa2sg+5yeRdY+y6sRnhiUC/+sSXOe9Fiipe5FBRbAJz+Fk0297Rz+KciLTieLgb4PAwF2SfAGkCd5626JoSzX8UV3pJ2DAqSfeUkdLnXSOthy1sRc4tEDgY02JPaWDDBbJcC1oiHz2LemeeAPTtn44t0GLLlqHf5LvZmhRNTARxQD0LdUR3bT/izE0K2ts7diriNXCcqi4ry6bOaEweQfpDblMq3HId8g+E+ufFweYC+kNR3zIiaNqErjV97lqW3eUETDL2tWxL4DJb5gGixqanwGDFVqDfucpQf8Xx3IJEcAXgFT0CRJ9s34LAMY9QUvJUJX6ADU+eDemhMrAILnrtDYC+1LdZIVPAIY/VUafTgOMjkSpLIRC7FlL5x7W6X0ar/2kZnj2+YmWNrxrWPLa70naJM8xzlxJPRZyx+LfPv2jhPN2HpKk+SNYoUF4edIHWZTgJ54CIC44sBLr5QVX7pZKdQ4Bm91wHzydnb9F3hSTQ0H6WWYpw1apA2F8of6w8e4uxirI9FuHWeEe2ZZ9lA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(478600001)(6666004)(1076003)(36756003)(81166007)(82740400003)(41300700001)(2616005)(26005)(356005)(16526019)(426003)(83380400001)(86362001)(336012)(4326008)(8676002)(8936002)(2906002)(44832011)(966005)(5660300002)(70206006)(316002)(110136005)(70586007)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:13:22.8285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c66380-f793-4d41-d345-08dc29cd1813
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322

We should be doing as little as possible besides freeing Tx
space when our napi routines are called with budget of 0, so
jump out before doing anything besides Tx cleaning.

See commit afbed3f74830 ("net/mlx5e: do as little as possible in napi poll when budget is 0")
for more info.

Fixes: fe8c30b50835 ("ionic: separate interrupt for Tx and Rx")
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---

v2: separated this out from a net-next patchset
    https://lore.kernel.org/netdev/20240208005725.65134-1-shannon.nelson@amd.com/

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


