Return-Path: <netdev+bounces-78176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 138618743EE
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E08BB23F22
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F5E2263E;
	Wed,  6 Mar 2024 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CzcEm6sY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB01F944
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767829; cv=fail; b=Ufj5EevdAOhbO9SHmQucFYDSLtorFlsQVw22MMGVlf6ILL/t9A3/yTBQAzDwCmfgQNz9iMf+EsvY49hIS1OiDL90dBHN3p9XGvTGiKrgHxMP6Oz1UuMPhQDSAnxQl8fx8A1kL6fGkEPElVViHAWKpi+jsLo9e/wVRH13AmsCEuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767829; c=relaxed/simple;
	bh=oUIqAFCigqwvSrq3fZcOl7Np3REKLVl4S9qknqj0UO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/b319UKhIIRQUDVKQpHcRpqKwRKtmhrtjeUd9Rb6SJh+k4lFG9waB2bvzBFJfNwyL4T1DAKNBvBZbxURbiRHn2V+qKFx2ZLbvKQnGGJxzSH983ILv/8L+CUTxR4G1H9k7wYs0dJ0r3ooM2H1lXTBKWQ682PhwnfbGvszzBFXAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CzcEm6sY; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPdao0z93puZebTRLq34CXCssm5GXNA2W3m0QnGOXTmfbp6Nr0B2XXXq8scQzL+TIOfVWVnCAoZukNbwKntFw7IHtLswQ6qMOUw38FLkCZOVDKkj6lxxH7njQEaa5YIzTfHknwd5Aji63RD2oG5s8SYo7oXqLtmiQqvM7FsoXTWhRv2IiRBz5WClk1MVia9y55ez/402doKm6DMlmuwKBgSd6OTDbNaYRcJw91a8Hyvw3kMccTC+1+fdNkiplmIwRFttVu1cfU+1eu79ntEPsX1By0s2ZVPBBjkh7H035LfYgKBPDokkbBG+G5/L6rC+5I5l7G+MqT5hCbCaPM7sMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfd498ooDtVk0LkWgOPDLRWzotymokumYHttW6K5TvY=;
 b=c/pSRijU8+y0WOgakcPxzUOsSp46sbG3PPaLC4GsRxIt4XCCfg3HN6+0noQrYib2l/SlLXZdS0BglPoeQlscsjC3tBdEyqoULQU8gcOpnInwBnB42xn758dFEmjs2RP1W3I5yDXPG8XMqtJgFCGfSNHeljLTuUbESjw5OPiGadX1ZVDn7+i42jjgzH5amocTy5iGZ2vQnxl5Pr457EXecBGprj4t6Ak/EMglXFPQjVY4Xz1F9L/MO39vwyE1n02ihMEJ6UwxFv+8/opCRrLMGif7aW7/qSfpkGdU7pgdSbqLBYc0sPlsmRWV9xiw3elw3sRBYYK10nDUuB35FpgsWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfd498ooDtVk0LkWgOPDLRWzotymokumYHttW6K5TvY=;
 b=CzcEm6sYEf/QTQJ4AkUUE7VEYy6dRCBXNB2EWYVrWs5rt91fQRxPzDELkqWjcaTnVB8mwgoSGHnbfFiBMumd6QYehogKQEhlJO4fWqyOlBQs0RXzh45Wa0ymqRfghLG7YS/4+Bf8c+IBscuqivgera4uxOrKm8cVx81XsB34FYs=
Received: from SA9PR13CA0026.namprd13.prod.outlook.com (2603:10b6:806:21::31)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 23:30:25 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:21:cafe::3b) by SA9PR13CA0026.outlook.office365.com
 (2603:10b6:806:21::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:24 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:23 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 09/14] ionic: carry idev in ionic_cq struct
Date: Wed, 6 Mar 2024 15:29:54 -0800
Message-ID: <20240306232959.17316-10-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306232959.17316-1-shannon.nelson@amd.com>
References: <20240306232959.17316-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a91abe2-ac6d-4d4a-022c-08dc3e35663e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C3Tu4GH4bUakCRQPrW0jOG7WzUP+7pyTsFractbRN8D8MsZFLXrG3MYENZW8WJ900OdDpBE858/NBeJYmeQaTEAsMD8Fl3wvO/MsIANd8FOb80BXrnPD+CawOMpFfn+EYWHTXg8+b2/Qj4BlVhuMibIOC/avQcz6BMDtb2Oy78OpzvT5XmUzeRVKh8fSykkUKRbtXiM0WG4KWOPgXpi0YEHvuu4+93icnOzr4DA29IqxwF955jaq2O5ftBb4ixONskeMiqlSybD5Elkp9KStt9g7/G2SQ0uiayf4puE96MARRj92LyREzAFP3T7/tIjbDrA7NBB+fk5qDLCY+kp9r8j2qJtDTnp696xrFos4On+KcP2dl4BU9yJRS+g7+KqIpv6zQ9wBUkk0usx+D3YbkCuulYfF2Y9gfB3kzHCfO2J28GFmyhesvR+aRcR3sChDO9XI4fhh1gU8LDtasWOwERbYGe+fRmv2LHMJDhznYHmfYNFwTd1XzcLrJmweW6EM1uL20hjHYYDHdgi5/m3IyUG2rqvoswKJFhRHcq2K13Ll4uotBPsQybBrnRbWfVRLiDmh9/XHIXe4m9VwJnUxXFYm7sO8ooGSFR2EP5Nu6P5j7xmcheQ5WPoWFKZZe03byYsZa4SGM8xNAZpuJzIN6BCgNrEFMygwn7a4ayCVeLs9/UT9LRdsEK2tevSBp1ASWZAXc9/lH5zlOCNYNjzRkhkuOjF2pTFXK7VCdfNcp7tLl3nM1A4ujzuj31dVR4RI
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:24.8827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a91abe2-ac6d-4d4a-022c-08dc3e35663e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133

Remove the idev field from ionic_queue, which saves us a
bit of space, and add it into ionic_cq where there's room
within some cacheline padding.  Use this pointer rather
than doing a multi level reference from lif->ionic.

Suggested-by: Neel Patel <npatel2@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.c   |  2 +-
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  2 +-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 21 ++++---------------
 3 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 8c961689b768..874499337132 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -629,6 +629,7 @@ int ionic_cq_init(struct ionic_lif *lif, struct ionic_cq *cq,
 	cq->desc_size = desc_size;
 	cq->tail_idx = 0;
 	cq->done_color = 1;
+	cq->idev = &lif->ionic->idev;
 
 	return 0;
 }
@@ -673,7 +674,6 @@ int ionic_q_init(struct ionic_lif *lif, struct ionic_dev *idev,
 		return -EINVAL;
 
 	q->lif = lif;
-	q->idev = idev;
 	q->index = index;
 	q->num_descs = num_descs;
 	q->desc_size = desc_size;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index e76db5647690..2a386e75571e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -240,7 +240,6 @@ struct ionic_queue {
 	unsigned int max_sg_elems;
 	u64 features;
 	u64 drop;
-	struct ionic_dev *idev;
 	unsigned int type;
 	unsigned int hw_index;
 	unsigned int hw_type;
@@ -296,6 +295,7 @@ struct ionic_cq {
 	unsigned int desc_size;
 	void *base;
 	dma_addr_t base_pa;
+	struct ionic_dev *idev;
 } ____cacheline_aligned_in_smp;
 
 struct ionic;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 269253d84ca7..af414707d614 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -948,14 +948,9 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
 {
 	struct ionic_qcq *qcq = napi_to_qcq(napi);
 	struct ionic_cq *cq = napi_to_cq(napi);
-	struct ionic_dev *idev;
-	struct ionic_lif *lif;
 	u32 work_done = 0;
 	u32 flags = 0;
 
-	lif = cq->bound_q->lif;
-	idev = &lif->ionic->idev;
-
 	work_done = ionic_tx_cq_service(cq, budget);
 
 	if (unlikely(!budget))
@@ -969,7 +964,7 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
 
 	if (work_done || flags) {
 		flags |= IONIC_INTR_CRED_RESET_COALESCE;
-		ionic_intr_credits(idev->intr_ctrl,
+		ionic_intr_credits(cq->idev->intr_ctrl,
 				   cq->bound_intr->index,
 				   work_done, flags);
 	}
@@ -992,17 +987,12 @@ int ionic_rx_napi(struct napi_struct *napi, int budget)
 {
 	struct ionic_qcq *qcq = napi_to_qcq(napi);
 	struct ionic_cq *cq = napi_to_cq(napi);
-	struct ionic_dev *idev;
-	struct ionic_lif *lif;
 	u32 work_done = 0;
 	u32 flags = 0;
 
 	if (unlikely(!budget))
 		return budget;
 
-	lif = cq->bound_q->lif;
-	idev = &lif->ionic->idev;
-
 	work_done = ionic_cq_service(cq, budget,
 				     ionic_rx_service, NULL, NULL);
 
@@ -1017,7 +1007,7 @@ int ionic_rx_napi(struct napi_struct *napi, int budget)
 
 	if (work_done || flags) {
 		flags |= IONIC_INTR_CRED_RESET_COALESCE;
-		ionic_intr_credits(idev->intr_ctrl,
+		ionic_intr_credits(cq->idev->intr_ctrl,
 				   cq->bound_intr->index,
 				   work_done, flags);
 	}
@@ -1034,7 +1024,6 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 	struct ionic_cq *rxcq = napi_to_cq(napi);
 	unsigned int qi = rxcq->bound_q->index;
 	struct ionic_qcq *txqcq;
-	struct ionic_dev *idev;
 	struct ionic_lif *lif;
 	struct ionic_cq *txcq;
 	bool resched = false;
@@ -1043,7 +1032,6 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 	u32 flags = 0;
 
 	lif = rxcq->bound_q->lif;
-	idev = &lif->ionic->idev;
 	txqcq = lif->txqcqs[qi];
 	txcq = &lif->txqcqs[qi]->cq;
 
@@ -1066,7 +1054,7 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 
 	if (rx_work_done || flags) {
 		flags |= IONIC_INTR_CRED_RESET_COALESCE;
-		ionic_intr_credits(idev->intr_ctrl, rxcq->bound_intr->index,
+		ionic_intr_credits(rxcq->idev->intr_ctrl, rxcq->bound_intr->index,
 				   tx_work_done + rx_work_done, flags);
 	}
 
@@ -1310,12 +1298,11 @@ unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do)
 
 void ionic_tx_flush(struct ionic_cq *cq)
 {
-	struct ionic_dev *idev = &cq->lif->ionic->idev;
 	u32 work_done;
 
 	work_done = ionic_tx_cq_service(cq, cq->num_descs);
 	if (work_done)
-		ionic_intr_credits(idev->intr_ctrl, cq->bound_intr->index,
+		ionic_intr_credits(cq->idev->intr_ctrl, cq->bound_intr->index,
 				   work_done, IONIC_INTR_CRED_RESET_COALESCE);
 }
 
-- 
2.17.1


