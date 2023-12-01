Return-Path: <netdev+bounces-52736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACB27FFFDE
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 01:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E79281660
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 00:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8E7138D;
	Fri,  1 Dec 2023 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gM0v/e3p"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F52139
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 16:05:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLQV9SVwfIjeUe66iFFpC1H8Gn1fTiPiiZnqmZLhQookN59j4F1sF0FXe2yGaUz5CJhEQmjv4gIx0tTyEAv+/UWYh3qHZeN6T476tAHW41EIYzf+INCunMNfmQXS3HCe3IlsTfu1JNSwNF/hrP52XAwSUgxh4ABkxocSkUiRajzGsvD3sbZQRyPPMoiwMyhzkwxi4DgTFo1COFmKk0ZTbvK2tgN2NfJSoJHXeBzzIftX5wn/SpJb+zVvqu5WxgWq3YB+LN8S08aNh0Z3LAyFI8gLQ8ORv9oEwfjf7mswd5KcOwDgZvVxmfk1zhKTpPMmhHvuVmO8Wtd9XxppJ4XbrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6cse56ROhVyA5nkJIO6k0iEB18tWmvlVLhsqMTQpDE=;
 b=Aj/R47/orViOVG5vjQLPzNbuwp9jN3UiYxFnl1cWVJ1M3XpLgIVG4Nd0K0IRXLHGZf0bcmiRxmtlLmiZu4xWwfXd7MV5npia2eWN4hULqJwS2t3trGhzJoviHltrwNHhxGhX07QdgnrIGifWSZZwiF1YrLBavQhzt2xS3NLc8Ugl5o0r6D92ysM3Q4EbVogX6HBPKO5aMONwat35sskFk/6xQBDs7VCII/dmW37QnmVNO5uOJsI/iHkBQq/VnkxTXPw8e/AiWuJ+O2Ns0ZMYOeShOx9BkwmzUIQw8mQ4brfRiUJLP7POvdpBJuCMCzKLm/mBrxsUxDe+nu+6YbqHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6cse56ROhVyA5nkJIO6k0iEB18tWmvlVLhsqMTQpDE=;
 b=gM0v/e3px8LADPRifFcHDOgDM5/bLJkH3xlgh80v3/BMYwLiEHQnShoSIfGtjOXM2eYvFZaomhM0e+qIP9LdEGxW+iR1PcIRMhYHKRS+MG/ckyDKgqSenQVD/ZTBSs43ngxs4h6AvzYpZcbnJ6c80p25MNAGrkd8mhHZ/Zt2zFY=
Received: from CY5P221CA0098.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::35) by
 LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Fri, 1 Dec 2023 00:05:45 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::21) by CY5P221CA0098.outlook.office365.com
 (2603:10b6:930:9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 00:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:05:45 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:05:43 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 6/7] ionic: Fix dim work handling in split interrupt mode
Date: Thu, 30 Nov 2023 16:05:18 -0800
Message-ID: <20231201000519.13363-7-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231201000519.13363-1-shannon.nelson@amd.com>
References: <20231201000519.13363-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c67335-0e19-4162-e5f3-08dbf201440a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f66Q82Axkc/Lx/Z8obk9k0Z6u8tlSGM7NxgPyxlvXkk800+FUY3BAMC9v15iCb9+f7aedwpSFks4MyVfIeYbU4AEEgVc5LOjlgAHA9v0wwbJdav2XYHjFwYX9rJJ1rCGD0ruqaUThfcrM7LR76DVrrPLKkAtBOpqXlcrqDoUuET8/9WRMznkAZ7jgZuAjqWkY+nGTyqy4sNB2bXYvM7DQj6aELUDXq1yVRVG+CckZzSSknE9PmEvSxqvoiNyDZoBkQciKbQazP4NkRP//Cbug1/iRfpvH1lVinHwmdZ62XOFWWdFMqftGZtL/K9xTP8TBLpeLR1vJ2rkMwPnoVX4qbVrVTr8ajMF8XvFOCSuLOZbadDNURdSRo1/v3BVQ3WnzdxrVuRE8asFXTZB4D/jWPt3+Pl9tsmg71mCx9neZG3/HtDZO/l/T4UabeN4JGglCwDCn6AO6teKCmzZ/sl8Rj1xpKK97ThXeFZpwMPGvvYv3JqpKmVNagxXLWaDIxOEVAf8RlajslefPhq7RGUGQDM8RUInp/Lzlcx00qodA2PnGsPusaRi6awBhisrNZwom0ObEVMeMzAYvpVCRIwgm6G3RE+0XSPew+q1y6gA81o463BUIbeuZ2+ut/WICMV0yu3w2ZZWVSorxhnoEMoJpiZ/xTe1vAqaNRVK3IKcNhtH3c74bbJSo985rgeJ2CRos2Xj27adEnphhhLTBSh0t+jA7woiuAjtCmYVYGzm33Ew99wtAskWp/LIaDiawfI+kectEnUshTV90qTRrABYXw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(83380400001)(26005)(1076003)(6666004)(2616005)(47076005)(426003)(36860700001)(478600001)(44832011)(8936002)(5660300002)(8676002)(41300700001)(336012)(2906002)(110136005)(16526019)(4326008)(316002)(81166007)(70206006)(70586007)(54906003)(36756003)(356005)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:05:45.2417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c67335-0e19-4162-e5f3-08dbf201440a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135

From: Brett Creeley <brett.creeley@amd.com>

Currently ionic_dim_work() is incorrect when in
split interrupt mode. This is because the interrupt
rate is only being changed for the Rx side even for
dim running on Tx. Fix this by using the qcq from
the container_of macro. Also, introduce some local
variables for a bit of cleanup.

Fixes: a6ff85e0a2d9 ("ionic: remove intr coalesce update from napi")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 6842a31fc04b..3bb0cfc40576 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -49,24 +49,24 @@ static void ionic_lif_queue_identify(struct ionic_lif *lif);
 static void ionic_dim_work(struct work_struct *work)
 {
 	struct dim *dim = container_of(work, struct dim, work);
+	struct ionic_intr_info *intr;
 	struct dim_cq_moder cur_moder;
 	struct ionic_qcq *qcq;
+	struct ionic_lif *lif;
 	u32 new_coal;
 
 	cur_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 	qcq = container_of(dim, struct ionic_qcq, dim);
-	new_coal = ionic_coal_usec_to_hw(qcq->q.lif->ionic, cur_moder.usec);
+	lif = qcq->q.lif;
+	new_coal = ionic_coal_usec_to_hw(lif->ionic, cur_moder.usec);
 	new_coal = new_coal ? new_coal : 1;
 
-	if (qcq->intr.dim_coal_hw != new_coal) {
-		unsigned int qi = qcq->cq.bound_q->index;
-		struct ionic_lif *lif = qcq->q.lif;
-
-		qcq->intr.dim_coal_hw = new_coal;
+	intr = &qcq->intr;
+	if (intr->dim_coal_hw != new_coal) {
+		intr->dim_coal_hw = new_coal;
 
 		ionic_intr_coal_init(lif->ionic->idev.intr_ctrl,
-				     lif->rxqcqs[qi]->intr.index,
-				     qcq->intr.dim_coal_hw);
+				     intr->index, intr->dim_coal_hw);
 	}
 
 	dim->state = DIM_START_MEASURE;
-- 
2.17.1


