Return-Path: <netdev+bounces-76313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2F086D369
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E201B243B5
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4EE1428F8;
	Thu, 29 Feb 2024 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="re77U2a5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1713C9D4
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235626; cv=fail; b=Zgqc4F9vwI6fbg0TBPStqxRCzD4qUDxqkltex/05u3hvo+4rRCQRn4DcsoD9fRDeO4/0m7NodZd4btLeZs8gmyOHSikrWZRacTz/BrPRyFOPtLuA8koAt62fwJ0bqzhgLlhP7WtYJlEhECYCoEOlZEPb2Og5d67DMcHRPZ9nncI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235626; c=relaxed/simple;
	bh=T2zDl+l5lFCg9nnP/krKnUHILhazTM3PYP6RjGPO74M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCBV/z8VGsMKiugUoMFuGDmzMBtm1F5+SGvy9Ty0xnFMy4e98hKHCKV86I7CqL/Tebt+W7GSyQkZsiwUHAgmUQ8BEAU9mkVgbNFeAQt9DH2XO+f1zApBMW10MnN/s+Jzk1dasYI4i7HR+elSgud6KgO1Sl/S1yV+dHfxqbwyFkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=re77U2a5; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBlyy1G8B9dJ0R0f/eoibGUiwrxI+s/X0IA+qMuC2hjOuZCm0iy7J0PSngEyrOwF4HeqsUMa++fBkzV/svATeVhMGfH/YiMLrxCqofdtX950xmO4l6Lnf0fJHxB+Ds5y7z/ZkACPHQBE983jf23u0+2RloDWvR4PevvG50q8MZt5Q0XFPiS02Tmf+i5n2vTmx9Mi+qX8mxv8IIz//0m+szIBngZT1lBviCS2nUint1Y8xt/hUi/CDs1kAYqO9HPFvoPyi2eaOBY08K1IXA43mPxlrR3U+G2/G5a9qJo152RJc2n7cGwLpgjK8/PtvMfrudaukF+miwddoF4GAS4C7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC+StlCIB9+KDRVOJvrEntnD9TGvHfsZVjOf3rSpah8=;
 b=FBr9/meHmDI/37McJAjCw5ElTTf4zOilnR3mxooP6wZu8cM0vwLmhVPxbUl+hPkEiKGngGSYNr+fLv2ohWhQPv5CdaYbunWYbR0HLkTfGi/buVBSxzV2KEvOPHbqi/ZerQ83SO9UQAZuPhBmEpnrM+vVYFuaLeaEG686n2YkChJ8SF19PeDUyVvNaQLeh7HiAXjSjGuCQlOtMCtjRcgimQbJYGUes2YPHXGjmiPd+fvr1y78edDI5QAkvkgYhDviY0eCwH/6n12rFSBE0Z2aJpHn06TsHYPV4Bcuo5RFVYg/NAunkIQRXu2MHUq2mKD/Q7Wc1IzuzWfH77odt3cy0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC+StlCIB9+KDRVOJvrEntnD9TGvHfsZVjOf3rSpah8=;
 b=re77U2a51jiUbKMVHFwP7ntY5/7GY3n6jTqWJuX6ujufBJRmvVDgbauXMwxWCjU6qyh/E58Ypgw3vTyeVaKoVyQ4tK9Qbiz4MbCNVPqMRGj4qH46kY7uvjU8ztbX03RmsjxPX4v67m0iCPKy12eQQKKSYbWBiQrJaHddbXzxVGw=
Received: from BL1P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::9)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 19:40:19 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::96) by BL1P222CA0004.outlook.office365.com
 (2603:10b6:208:2c7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.29 via Frontend
 Transport; Thu, 29 Feb 2024 19:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 19:40:19 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 13:40:16 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 10/12] ionic: Use CQE profile for dim
Date: Thu, 29 Feb 2024 11:39:33 -0800
Message-ID: <20240229193935.14197-11-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240229193935.14197-1-shannon.nelson@amd.com>
References: <20240229193935.14197-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8389ec-c9a4-4cbc-d4d2-08dc395e4319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YRGsxvIX73qWRCtdr8oI5dwFBFwUQiLQAjiLlF4CE9/9kzLksH+qehJ+JzHdnqlWXk4Sd6yNMKV3AGZIAS7Qu+//fOqmMlgBu7StMd8qgIlqu2zyX117gbSZyZCvvFMoMKUeX9w5+slFjHtHAJFNWYGa1E3qEBwBz2J0nJBJE0ihOxshktTabQgTAaTBFBkcW7fKFNBtZhRDQwZlnsdYjAGl1pRjekJXAqb/k00Lc8EmmhFwgFh1D7rmZ622ukrhHz7M7IyRGBJ3Wcqp1VeI3E7NjC9IKCO9HPg+7iiFjMq2ohoSs2uruJN1Aq9Z6JxH9B7jON17ek6Iczy3WoRaU49Jd1HXdmsN/+ZWmFWM4YQoYse4w6joaLQ4vPhH5ObXqSbZnFadVv0UvT6Gg2SxxTy37K4EsvP+6WNlGh2YLDxOL7j629eoFEuchcnnObAqaXmkUjo9JL/mF0cxYLa8CwyB+YHgJPmnBlJ7cWCo5kHnjKyD75Hlj+51XX8CZ9la9gmdzYOziWQ/UVfgY0Ts9nfa6Us5Nv3/6NdwL/V8Nud0OtwMKWshm80ObhxN5rcqQenzKoNrejl9VPJwwigSN3l68ja/sLGgzRmi0BbPzbOxqsT+GmG+tsEN3c+tQLB/KMEjXxTTS+4ZrfadVOTp23xHJpBs1UyGLgke5MYc8yTf9oM2dg/DUg5pIRNi2FRp5WQX7o1G/jwOoKxiLaSs123WIettwbvSlX9z0bqa5ryE1G+bsLdnuIo6vOB7RvAd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:40:19.2743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8389ec-c9a4-4cbc-d4d2-08dc395e4319
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448

From: Brett Creeley <brett.creeley@amd.com>

Use the kernel's CQE dim table to align better with the
driver's use of completion queues, and use the tx moderation
when using Tx interrupts.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 35a1d9927493..85255e5e8ad0 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -52,15 +52,20 @@ static void ionic_xdp_unregister_rxq_info(struct ionic_queue *q);
 static void ionic_dim_work(struct work_struct *work)
 {
 	struct dim *dim = container_of(work, struct dim, work);
-	struct ionic_intr_info *intr;
 	struct dim_cq_moder cur_moder;
+	struct ionic_intr_info *intr;
 	struct ionic_qcq *qcq;
 	struct ionic_lif *lif;
+	struct ionic_queue *q;
 	u32 new_coal;
 
-	cur_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 	qcq = container_of(dim, struct ionic_qcq, dim);
-	lif = qcq->q.lif;
+	q = &qcq->q;
+	if (q->type == IONIC_QTYPE_RXQ)
+		cur_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+	else
+		cur_moder = net_dim_get_tx_moderation(dim->mode, dim->profile_ix);
+	lif = q->lif;
 	new_coal = ionic_coal_usec_to_hw(lif->ionic, cur_moder.usec);
 	new_coal = new_coal ? new_coal : 1;
 
@@ -685,7 +690,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 	}
 
 	INIT_WORK(&new->dim.work, ionic_dim_work);
-	new->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+	new->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;
 
 	*qcq = new;
 
-- 
2.17.1


