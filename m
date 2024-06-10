Return-Path: <netdev+bounces-102392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0606F902C37
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940A32855CA
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783FC152DF7;
	Mon, 10 Jun 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s3CWsM+2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EDD1527AF
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060862; cv=fail; b=LUXN09/31vRijxN+UnO2K0p709a45iif1bDujLxLiVaZ56JlqiW1BUaFns04bJ4xrrpZMMM8JZxlUZSPYgFQYqVdNArLPeBC0vuMfXDWi9pdfRlchhBznNkNkNXv1sjnhrHYj/7A2vPe66stgKs1gl1mLEeZYaYfNXBjMsK2Qf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060862; c=relaxed/simple;
	bh=3e/V0mjIEl6WLeVi5A7mOFanfdXz9XojSdlKydXvCk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+aBtIlObcQawKbzYhisnmpSSAIZLkdwDTngUh2sxaIF46oeRgDnevI0L4oJFohbAwGTG+x9xYCm7TyIzS+lKO8oVjmJ6IqWPaiLQD/VX6sZQyGmBXOwp7nTG+wNjV9CWtI2B1aDqC5nQz8l8RugtIdjuIqxeKc2Qk0hdYqKh7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s3CWsM+2; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrPKMFGu7H4racoGW3ihHp/8XIL5mMRkQvMMXJrXnsDfkVKVLFrG5qmYaQRYsWG9InTLriF+OYlGOBY8HMpP14ZNqc5gLH3la16VR7w25mEGkgmHF0U6XO7lXN67Fgj9A3VPOmqSdRf1fQWPqCY8yInkQ6LAuBTOWhu5HcUjCaS2oPJABFoeqHQ7thnhg79soLJgQwbuB+Cy1mEswG/5YvANAaLjIXaKjAyDT8/ZUWJs5sW0UvwLj3b8yzIDqf82TiINdA9dOMbP+9CQdlKO06ZDnYCLCqE/rcfSGfZE6qIggi2QjCv7cZFFPYhgYhlOiHTo9gieebwd+F7hHK5tJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0T/uVVSF2aVSbsZl8PX1CXoTpPwdw2J9qZ1LM7y64k=;
 b=Ohtha3GlxVlH9sFcrUdXiIYwCaugkfPnuke2J3ejQgscix7RlTwcOUstWq5SQFNJ0jdizTLoYoysEhCaBFqC4jwFlCPO+4h6c8kNE636XQdeghX4Cl8ywHUjDCaHaN2TT1OxoGosZrZdmzmF/7ZD0xXp2HuvGZv9taYqRK8pt+3HsoYQ/h9VKwD4qAOqUNrCs/7TfYWI3ZI7DgEJE9LI4EFGgXZ8E+O1j6Eoaa/8uRKGA9VniGN8JrpRlCTAfvI0mK6cJkWIvpibAsBLJfDlmaCOq0ZwpWQHnEslG86T09V3VKVRwc+ehsBexHGTRQpyJpU7EJcR4sZAleMP1lUdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0T/uVVSF2aVSbsZl8PX1CXoTpPwdw2J9qZ1LM7y64k=;
 b=s3CWsM+2qGrSMeOA1b3yrKyDveS0IomHcJ1cytrZ9bcIcO0NwUILdOMNeTCflk0PGGb6oTvLnFOkYpt95jWAmr36AsIyV8ISwAS83KGKfVjDWrlQVE0tIYB6j9SxFe+gfy8jfBBpMQ6yhxMCnWNCL1KpVySkIlT+Dny6GZMZVwk=
Received: from DS7PR03CA0289.namprd03.prod.outlook.com (2603:10b6:5:3ad::24)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 23:07:36 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::6) by DS7PR03CA0289.outlook.office365.com
 (2603:10b6:5:3ad::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 23:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 23:07:36 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 18:07:33 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 8/8] ionic: Only run the doorbell workaround for certain asic_type
Date: Mon, 10 Jun 2024 16:07:06 -0700
Message-ID: <20240610230706.34883-9-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240610230706.34883-1-shannon.nelson@amd.com>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 0690211f-a3d2-420a-a0ac-08dc89a21e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nubRV2Uzy4B07lBfTNc2bVPKHHEg6og+kiFPwtSrSRaNgaT6mizA7Hk05MBH?=
 =?us-ascii?Q?2shk/v8m4LriKv9ko/UuoFvsg/hLHUIHTIsK6rOYp4E83Axq00L5tlBUP//j?=
 =?us-ascii?Q?Rvq5/yfmjVOm52NbQJBP70n2VJ8wjYTfqVvjDqTLJ/Zgf9Fo8yRd+Uh5DWL+?=
 =?us-ascii?Q?9K9WtKHZpE3xPUNwLEC9qowOSgvdt+ltLQTxCZrzqPx+yp/TmzfNklyTT9Cb?=
 =?us-ascii?Q?VNTLDBpekQlWT2wcYx+6lNYLm3TNTr7p2LKqJxq+UBPTkpfKgQuycOjXaIHe?=
 =?us-ascii?Q?K09bJHcEG3aJq5IVxmhShURlbUW2B7z/Pmdb5KTyyW8IhoK2e1iruURykop7?=
 =?us-ascii?Q?P32UE3F5/nArQ7PQrHOkdTWAfbwYiNboujuD2a22y0dtjv2U4Hmer7sxV4eq?=
 =?us-ascii?Q?hkuoHN5MyJuvRtJ3/rQuslG1IyW4B/JdEw9YyJ9msiYsmtY/ruV/r1LGnqfY?=
 =?us-ascii?Q?jJIov38DVEaIJ8Lzm6j7u8z9yoD0ivJ8L4uQOwBjlrSwoiDHE2Sa6rJgoX6L?=
 =?us-ascii?Q?j0ITn7DlOdAfbVQS/1YggpuYgDh/xWpR0hRiqXgIZbPf2lbk7g/oBfYP3ht2?=
 =?us-ascii?Q?f+k83M1NAcX49fXL6GHrQKVF5oXlvZmIxREB+d2k84MHhDRly6NjZ4Ce+Pzd?=
 =?us-ascii?Q?DcqeTY3LelaEW3aqi4L0exJzuv1Xgpr4Lh3UomM+yXAtniILOwuvzX9Sc30D?=
 =?us-ascii?Q?Cc7yxQ45zMMJIUVOhldeb9cKql+eKmrSoX4UbIiHQN3OMNA3ozJ551ibwFld?=
 =?us-ascii?Q?Yun2V8p2Z/TnwhyBOMzF5fslu/PgdmV9ObiMzhcHeAP6rr0CMG5Cj2zCHMhk?=
 =?us-ascii?Q?nYYHgD0r9pAB5FN7tEnmPWDVcBFZsjrh4Dg4/WjYyy+gnUvWG/g58iKJcnzH?=
 =?us-ascii?Q?r2wavofZGOf3VO79d42VVtJ83FZOfIeQ+jUoETFeyjaiipgOOBtgCPdHYW+X?=
 =?us-ascii?Q?eURtnsIgWtmlr59Ewc1hd5QHDq05XJ1WyU3duK+SHMnTHXoF+GYpYPsDWFw0?=
 =?us-ascii?Q?YK+8pPlZKVdCrQnpEtYNvl/CfOy3+5xdj03TqQPX6n6rMyYxdmr+cpkYcCJj?=
 =?us-ascii?Q?10Izm4t1/ho9fnXNHq6JK+jcatm9gEkqAXJMNmKXE9EdOSd1XbTVHe8XNBDc?=
 =?us-ascii?Q?zlt+P561V/62rNgDqtBsNpKnqINImOgAn2LjBAULvqPdOYsC5F+xYgjGeexj?=
 =?us-ascii?Q?RKm1lMhmyNQzU6mtpM/UHcRr7e/Jgb+fKWEAzoIFnFMFA05gE476J6i8EuZJ?=
 =?us-ascii?Q?JumBInwzuIiOebFWuDn2JVdRdi0/pm2SwCdeHGh/s5YKqh4J83UiVC3l2MfT?=
 =?us-ascii?Q?dzwYbnaW5YEpQHCbCz6IwON0OTRyn7bqiBje7ByN2wad7EkRXOAfqpeugojb?=
 =?us-ascii?Q?GVjrXfMvV6wGrSJ0KtwfarVHW8RMuYQ9Hsf18Ot87cpYbu//Ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 23:07:36.7603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0690211f-a3d2-420a-a0ac-08dc89a21e78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849

From: Brett Creeley <brett.creeley@amd.com>

If the doorbell workaround isn't required for a certain
asic_type then there is no need to run the associated
code. Since newer FW versions are finally reporting their
asic_type we can use a flag to determine whether or not to
do the workaround.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h   |  4 ++++
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 16 +++++++++++--
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 24 ++++++++++++-------
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  1 +
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 14 ++++++-----
 5 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 106ee5b2ceff..1c61390677f7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -18,6 +18,8 @@ struct ionic_lif;
 #define PCI_DEVICE_ID_PENSANDO_IONIC_ETH_PF	0x1002
 #define PCI_DEVICE_ID_PENSANDO_IONIC_ETH_VF	0x1003
 
+#define IONIC_ASIC_TYPE_ELBA	2
+
 #define DEVCMD_TIMEOUT			5
 #define IONIC_ADMINQ_TIME_SLICE		msecs_to_jiffies(100)
 
@@ -96,4 +98,6 @@ int ionic_port_identify(struct ionic *ionic);
 int ionic_port_init(struct ionic *ionic);
 int ionic_port_reset(struct ionic *ionic);
 
+bool ionic_doorbell_wa(struct ionic *ionic);
+
 #endif /* _IONIC_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index f3f603c90c94..d18ea1b4a8b9 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -127,6 +127,13 @@ static void ionic_doorbell_check_dwork(struct work_struct *work)
 	ionic_queue_doorbell_check(ionic, IONIC_NAPI_DEADLINE);
 }
 
+bool ionic_doorbell_wa(struct ionic *ionic)
+{
+	u8 asic_type = ionic->idev.dev_info.asic_type;
+
+	return !asic_type || asic_type == IONIC_ASIC_TYPE_ELBA;
+}
+
 static int ionic_watchdog_init(struct ionic *ionic)
 {
 	struct ionic_dev *idev = &ionic->idev;
@@ -150,8 +157,10 @@ static int ionic_watchdog_init(struct ionic *ionic)
 		dev_err(ionic->dev, "alloc_workqueue failed");
 		return -ENOMEM;
 	}
-	INIT_DELAYED_WORK(&ionic->doorbell_check_dwork,
-			  ionic_doorbell_check_dwork);
+
+	if (ionic_doorbell_wa(ionic))
+		INIT_DELAYED_WORK(&ionic->doorbell_check_dwork,
+				  ionic_doorbell_check_dwork);
 
 	return 0;
 }
@@ -160,6 +169,9 @@ void ionic_queue_doorbell_check(struct ionic *ionic, int delay)
 {
 	int cpu;
 
+	if (!ionic->lif->doorbell_wa)
+		return;
+
 	cpu = ionic_get_preferred_cpu(ionic, &ionic->lif->adminqcq->intr);
 	queue_delayed_work_on(cpu, ionic->wq, &ionic->doorbell_check_dwork,
 			      delay);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index be601183deff..b8813809bb75 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -346,7 +346,8 @@ static int ionic_qcq_disable(struct ionic_lif *lif, struct ionic_qcq *qcq, int f
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
 		struct ionic_dev *idev = &lif->ionic->idev;
 
-		cancel_work_sync(&qcq->doorbell_napi_work);
+		if (lif->doorbell_wa)
+			cancel_work_sync(&qcq->doorbell_napi_work);
 		cancel_work_sync(&qcq->dim.work);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_SET);
@@ -693,7 +694,8 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 
 	INIT_WORK(&new->dim.work, ionic_dim_work);
 	new->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;
-	INIT_WORK(&new->doorbell_napi_work, ionic_doorbell_napi_work);
+	if (lif->doorbell_wa)
+		INIT_WORK(&new->doorbell_napi_work, ionic_doorbell_napi_work);
 
 	*qcq = new;
 
@@ -1217,12 +1219,14 @@ static int ionic_adminq_napi(struct napi_struct *napi, int budget)
 		ionic_intr_credits(idev->intr_ctrl, intr->index, credits, flags);
 	}
 
-	if (!a_work)
-		ionic_adminq_poke_doorbell(&lif->adminqcq->q);
-	if (lif->hwstamp_rxq && !rx_work)
-		ionic_rxq_poke_doorbell(&lif->hwstamp_rxq->q);
-	if (lif->hwstamp_txq && !tx_work)
-		ionic_txq_poke_doorbell(&lif->hwstamp_txq->q);
+	if (lif->doorbell_wa) {
+		if (!a_work)
+			ionic_adminq_poke_doorbell(&lif->adminqcq->q);
+		if (lif->hwstamp_rxq && !rx_work)
+			ionic_rxq_poke_doorbell(&lif->hwstamp_rxq->q);
+		if (lif->hwstamp_txq && !tx_work)
+			ionic_txq_poke_doorbell(&lif->hwstamp_txq->q);
+	}
 
 	return work_done;
 }
@@ -3510,7 +3514,8 @@ void ionic_lif_deinit(struct ionic_lif *lif)
 	if (!test_and_clear_bit(IONIC_LIF_F_INITED, lif->state))
 		return;
 
-	cancel_delayed_work_sync(&lif->ionic->doorbell_check_dwork);
+	if (lif->doorbell_wa)
+		cancel_delayed_work_sync(&lif->ionic->doorbell_check_dwork);
 	if (!test_bit(IONIC_LIF_F_FW_RESET, lif->state)) {
 		cancel_work_sync(&lif->deferred.work);
 		cancel_work_sync(&lif->tx_timeout_work);
@@ -3752,6 +3757,7 @@ int ionic_lif_init(struct ionic_lif *lif)
 		goto err_out_notifyq_deinit;
 
 	lif->rx_copybreak = IONIC_RX_COPYBREAK_DEFAULT;
+	lif->doorbell_wa = ionic_doorbell_wa(lif->ionic);
 
 	set_bit(IONIC_LIF_F_INITED, lif->state);
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 50fda9bdc4b8..e5bcdd2cf86a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -207,6 +207,7 @@ struct ionic_lif {
 	unsigned int ntxq_descs;
 	unsigned int nrxq_descs;
 	u16 rx_copybreak;
+	u8 doorbell_wa:1;
 	u64 rxq_features;
 	u16 rx_mode;
 	u64 hw_features;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 3066eb4788f9..b381863b54ef 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -949,7 +949,7 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
 				   work_done, flags);
 	}
 
-	if (!work_done)
+	if (!work_done && cq->bound_q->lif->doorbell_wa)
 		ionic_txq_poke_doorbell(&qcq->q);
 
 	return work_done;
@@ -992,7 +992,7 @@ int ionic_rx_napi(struct napi_struct *napi, int budget)
 				   work_done, flags);
 	}
 
-	if (!work_done)
+	if (!work_done && cq->bound_q->lif->doorbell_wa)
 		ionic_rxq_poke_doorbell(&qcq->q);
 
 	return work_done;
@@ -1037,10 +1037,12 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 				   tx_work_done + rx_work_done, flags);
 	}
 
-	if (!rx_work_done)
-		ionic_rxq_poke_doorbell(&rxqcq->q);
-	if (!tx_work_done)
-		ionic_txq_poke_doorbell(&txqcq->q);
+	if (lif->doorbell_wa) {
+		if (!rx_work_done)
+			ionic_rxq_poke_doorbell(&rxqcq->q);
+		if (!tx_work_done)
+			ionic_txq_poke_doorbell(&txqcq->q);
+	}
 
 	return rx_work_done;
 }
-- 
2.17.1


