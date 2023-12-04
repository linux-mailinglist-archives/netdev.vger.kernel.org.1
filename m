Return-Path: <netdev+bounces-53611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C20A1803E4A
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D21A1F21187
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D073D3174C;
	Mon,  4 Dec 2023 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cb9xMPH8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3997EF0
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 11:22:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BspwJmK9FpwV3taY6qanDw1IBm1zZldockqd3EAl7RfYld2X0G0fKfEn3tTukpKmsDJ2M/39eGfq/1IBCPuFBgiv6+RancijC2Gfpe5pq5HgrfAjrAi58LPLX9Pop3d+pWgkWZJUfAR4AMl5LQ59Noytpsy4e2x+fp45BeLwYJurVbBU4R8LxWwsf2Z4DehiKmgDTAYm4YMlGTHaf6gtYAcx+bnQmUS5k0eAFnuX8u5WV5xOgS1l4TyiacEDoe1Ra3ZSEOxD/lL+uBulurlGN7+HxAuuypfzxm8zAUcPfU5PSrsgd/zkfWdOI+EL7i0dRxmdtKJzFvx5Vz75AkjFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X36LDIlfkv8iDpm5lT+aWt6qM3gdotpRQdnBVhnfpo=;
 b=KCEdqpAoK9E3ZaU4NM/NtY2VdbWOlo2zoZ0AZXvYuFVhnOmd56GLZpYtJ8a2tdixtFmcglPgLz3W1WhJ2iPHLIA4O6XrxyyOhAxr0qgyt616/XRhyNOoiSZDxkI7azycNpAkEZyZJJPWTZvn1G/WaWaCLE93+0DwLwaU32ES3KpaLfgFjszOmbhbeLA2IxCFLdFLXk00PqJrpjon1dtZMPLliQbEpASCwJxzCyhCFArXrX2w3qm1CFPOTgznD6Uujk/x53yip4FGmC3Wkz5Ywh01GEaOpJ+biLwOqJuxQTaLw3CMjDgIxtoBl84ttIbx5bbRyMvGIVQeyBO9t+wJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X36LDIlfkv8iDpm5lT+aWt6qM3gdotpRQdnBVhnfpo=;
 b=cb9xMPH8/ji6NK7BdMoPyFWJD3kOl3Fe3pgUAw8vMIdFLkVJBrg5JaiNcTWjKKfsuFnDQINOtaDRndgkiS/FR3ylbYEwtob2WFu9EZU3njiJQmetIuStfffrRSX+Lmx7xkBrBH6kNsDS/0CK6/8vHRNEvvztOSnvD1dNnTw/2gk=
Received: from SJ0PR05CA0204.namprd05.prod.outlook.com (2603:10b6:a03:330::29)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 19:22:56 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::71) by SJ0PR05CA0204.outlook.office365.com
 (2603:10b6:a03:330::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23 via Frontend
 Transport; Mon, 4 Dec 2023 19:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 19:22:55 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 13:22:53 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <f.fainelli@gmail.com>, <brett.creeley@amd.com>, <drivers@pensando.io>,
	Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net 2/2] ionic: Fix dim work handling in split interrupt mode
Date: Mon, 4 Dec 2023 11:22:34 -0800
Message-ID: <20231204192234.21017-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204192234.21017-1-shannon.nelson@amd.com>
References: <20231204192234.21017-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|BN9PR12MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df61fd0-9fff-45bb-8021-08dbf4fe6aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x24JE9jPm1FEZJPBP0ksNeXq58k7jqib/Y14RYslJ5Gv/UxZ39MYOPVsE6sdP2mv6frmHdkVRDlKbo1MEHdSA9wdZ6hgLSi5X7RH4mfL8zm3gegzFqQXWy4S/l+xs7VQ1kd3WeKIOAkDVay12I0ieQPARFqKstbKhaJn+fk1iyjqvgJu4Bn56fjaBv3xKeCctIx9dEUWIfHUjVVITjPug5+77eKLCQQbbngwnj9Bi0AJ63065F1U/k/X/0cLzlMkLZUCKV5tz/jGC3C8tcbva4XufIs8Il/JFLRkgsmCEgT65vDsgvx1cjnJW3xy5538gFnPFfQ2oaMW86WcvmDopTemBG3IhHKDJ2fbCbtfdHNnXkYxZijGkH6Bccr7y+6Vh/3CMghiDW5dw117Dv1RnEW2JYyRqlolD2SFY7EhJeZ0N61NRXHLAlWUc1bPj0PmJmqSLrpftoN/EqI5DiiA9MPxTZUTpHKe5F1c5Iku1/RbEn6k8m8R1n2d7mahxLv+X0Uk25mXC7ekiT5p5Th+X1PeKPxAbwzJ88KLjuUEgsHSdvYfRdCB0WXZ2/WHwr/hcF7CIkQWXlgCyH8F2GOyDzHu6s4AHG+/X4OwJXLi5FfzhyJ1v2xj3nfQx2mDL81ZYT81uKhuR6mShJvw9A4iK4X/6n1gQ2n90JalrOgOu9BU2EpBjj2V/cIxIfif3oEs3qWRUUdejv16WVMZfN8nWiMcw/DHQ/q9kLdPORkgpvkyBBed9c1vxudrw+xfFqoDaree4IbGKHmGzu6lbBdDGw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(1076003)(2616005)(8676002)(8936002)(4326008)(47076005)(81166007)(40480700001)(356005)(83380400001)(36860700001)(16526019)(426003)(336012)(82740400003)(26005)(478600001)(40460700003)(6666004)(70206006)(70586007)(54906003)(110136005)(316002)(2906002)(36756003)(41300700001)(86362001)(44832011)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 19:22:55.5030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df61fd0-9fff-45bb-8021-08dbf4fe6aec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131

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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index edc14730ce88..bad919343180 100644
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


