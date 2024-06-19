Return-Path: <netdev+bounces-104700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016EA90E0F2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5BCB21735
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13DB653;
	Wed, 19 Jun 2024 00:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SLQlhKiq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE99AD24
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757239; cv=fail; b=q5Rd18R7ZO8oAG2t5mTBbxh3iPAynRgXFtRjol+hxb7PDw5k+gY8fwJrP+LkpwcrEnYfN4/2gjsTa7jd8HGk+a4KMJLVTjuSP8A+2Csx4lUJrORVGCM0Ll2jlhm6SKu8OYaHBZOqghsvk4J+LjbcgzJISmcPMsk3WM3qGDleZ9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757239; c=relaxed/simple;
	bh=dk+OeI4Axd+q4xZWbPiDEiRhPIgJ+01f41nOyqOEDo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PzPvROQS/qIcwHeq7Cibf8UwhHoHbeLvY6QEhXJrvUly2mDzFHznvuFEpY1ytrl8tLBjCQ/eBBdb2lp5YlN9KZyojiF3vG3wl1J8Xv03tjxHLIfLu2jsyq5MLqI2hYxYtfwX1nQ8pIVgiUZ/yF+J9Rku99wi3w2nVVDYqtUirmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SLQlhKiq; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOdt1HnQnYA5MfIUmv6iiv2TAJZvhrmToPM+1qzns3M2TDOJoZ4JdQoP9FtjJGhMeIvJy5bQqgrnlOKPwF4CWYUVAAvFPNMZrThyV/sLDkFBJ/SboGpuL+N1/uUpwSUyzSboqTbR2lFcv84EA3RSJNdlYHOWPR0y4n87SOALEKZAliDXal0nkSO5JfahogLQj7DnuSJhJqk9hKImhMcVqM2mCCVOhmCHhzWV/ycia2YauBPHSyimKIplUi2KShOeUq9C66QIlnYeRAsRUrsF+53U7ldAMeY8XO9sVlzEznsnE3Ek//7g1WBylQj05sSZsEmaM1eKLFn/DJIaUW/q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHdZ8pIWR4ByGpmQpEW7B7hDoQrcrlbhJge2W8yTnZk=;
 b=LsOlxGBOUGeJmymiYucF2EiRdVXyVVHoyF0Wd0C0hwGcPKIfMHBjdORDQGaymTHPTaPFzXlnN33xMG8tCShylAvrpKfQLxPn9HZmtRGcBMPGJezf7ax6uOT6FXceACNRl83tPPLJnf2PC7GCu3v96Dvr9ea15C4me613ENPPkSaHvYlQxAakAFdkYnIhWwFNS1gtt25cLE1ec3aT9KqWn8sFQ9qtMor/OIURESGEksgFaETFBmbof52YDJCSwm3njHZD95aCtlEPK5FKexZpUTQgfpM/ySEwNWnccArMOZn1o9Zv1idigJpvg3RzRSqjoPjl3cXk+9ki9v1tlnsBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHdZ8pIWR4ByGpmQpEW7B7hDoQrcrlbhJge2W8yTnZk=;
 b=SLQlhKiqen49lVxYyqodhQrq/07T0yAOoZZj+q6l5P6Vy4ZCh0+XNxxjZPOhM2S4Bqc5IZ9Xbyifnu277ZNkiEQmuRFmu/lMJr8viOs5PWMN39WLMvUqNUvDATmZuQxRuoXoC+KafpuIXLa9UtLTiephPRkSjzxaL/A6nZPQ77w=
Received: from PH7P220CA0112.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::33)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 00:33:54 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::81) by PH7P220CA0112.outlook.office365.com
 (2603:10b6:510:32d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 00:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 00:33:54 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 19:33:49 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <David.Laight@ACULAB.COM>,
	<andrew@lunn.ch>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 8/8] ionic: Only run the doorbell workaround for certain asic_type
Date: Tue, 18 Jun 2024 17:32:57 -0700
Message-ID: <20240619003257.6138-9-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240619003257.6138-1-shannon.nelson@amd.com>
References: <20240619003257.6138-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ed6d0b-d492-4c10-d834-08dc8ff77fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aC5U+EOqhW/X6ce5yCoztUXigqEUrZqeRbE+DntjsXQ6C7anh1b3VkWZSmLc?=
 =?us-ascii?Q?tHuu5zFVameTZYUayelqlYfuYeSSAEZSy9nQWCWkRDawRAx3s5ZbEsTL0pSk?=
 =?us-ascii?Q?OgvJ/CjlElxnNezU4o5dKKhq2IjkTsjC98if9t8QqHJzFhDzfmJa7asdM6Js?=
 =?us-ascii?Q?K/8AbtbBp8L29t7hd/p3vqOOWHet9jv5TC4FAEafld9kipRf5n1QJk7HzNi7?=
 =?us-ascii?Q?JmZ88mCoAL7g6Ht15CW3BUV27qrmFjNeevFjIo3yen9T5tUPy6Rlas5HsoIG?=
 =?us-ascii?Q?xmDLDJbdCCglrzYOJ3TerET+lfbJsl1x4/mixxXjXS7u8KFxnHTDqIq9mNhE?=
 =?us-ascii?Q?baP5ZMir6d+sfUiKO/i6m8sgiOwwW4pxNWX2KoHCCpdcxXZki6FVwIoZttJi?=
 =?us-ascii?Q?oBkqFfNgq7PzS6aAVkwOBcjamNHc36jU8khM3cSUZrd+1IA/wW5G/5dtDRp8?=
 =?us-ascii?Q?2ThxIWYrj0co6g79+fLN29XxcnfamV302O/neNk2Pz4YyVlMrcZ+qOQjq/vW?=
 =?us-ascii?Q?L9SV4whuOdabk93gwg0fyvExWvOhfgNOuKDQUT7Z2iWL5xHa2FUi2OpKNF3n?=
 =?us-ascii?Q?znKEh3RaBtp3+ZwAm/3pRRMD4M4Z29Bemu6bsAx7g39t21DS1dr1wWZXKHCF?=
 =?us-ascii?Q?wuCgcGXO2vYupAe/oKm0pagOHE5x5RMDyxf89jnsm78I7hSEJ9Q6vTxvbu+G?=
 =?us-ascii?Q?AtN3Jym7n+yiTKkISkBdYAFyay8fMjKjt+ERuTVELMgH0MaQTg4nH5NBug+j?=
 =?us-ascii?Q?yKfIDgF532LV4ovKZwwYN8qBI0jxLtTDLglBBk04R+xfb9kLuxucuM8dxu48?=
 =?us-ascii?Q?Bxi2DSG2VoQ5lxriddNaHCJdG0/u9dzu5gV1gmOK5g9Maz5h35fl3svz0Jia?=
 =?us-ascii?Q?AAv1TX2WCF/Q3XK7jv+gLVxbpgW3E0qJVnswswV4l+cX6VVIxJZV18SW4Ztu?=
 =?us-ascii?Q?3uj0Y5R/WQc7Lj7udN+hZtXmHWvNuvheUvrEShQeVPiqgbGK+2xVHzDSBYYM?=
 =?us-ascii?Q?KxF1H59sp1ySfwCxIcuUa5UsByF1g+scBBTilrzwz/23hgnL+3gGE1BnxEwj?=
 =?us-ascii?Q?foQujHGejN0lk3jTp9PG5mXu5tUBRBV5seY8e3sGCRXjeAhuW0QHF9nfK+jN?=
 =?us-ascii?Q?bO6v8ev0thkxkYGvCwgmYfDb5IF/TvUwCr9VPgvf/7XXVSS0CYDjrcmpAqc+?=
 =?us-ascii?Q?4gs+1VtUgVZIxdfS0SC1F85wcW6LpLYmgT82/6ubvUnQPBPB/sKOKkYKGpi6?=
 =?us-ascii?Q?4TxKCP9l8ukSIKlQMSzqnCFQsJldU5pavKpGHuamiHJGvYQdbDBvd4V/zJLc?=
 =?us-ascii?Q?7NJqzVbNMrbLONczbCEtLvJXRjgIzLBMcc0RjDrqUk7UQ6dScKcj1iXWTynx?=
 =?us-ascii?Q?3HGs8BzQiuexEKpZW/kDiLlsIszRxTUtl8z6XCstNovPg8UeEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 00:33:54.2736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ed6d0b-d492-4c10-d834-08dc8ff77fd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055

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
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |  3 ++-
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 16 ++++++++++++--
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 21 ++++++++++++-------
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  1 +
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 14 +++++++------
 6 files changed, 42 insertions(+), 17 deletions(-)

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
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index f362e76756df..b93791d6b593 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -412,7 +412,8 @@ static void ionic_remove(struct pci_dev *pdev)
 		if (test_and_clear_bit(IONIC_LIF_F_FW_RESET, ionic->lif->state))
 			set_bit(IONIC_LIF_F_FW_STOPPING, ionic->lif->state);
 
-		cancel_delayed_work_sync(&ionic->doorbell_check_dwork);
+		if (ionic->lif->doorbell_wa)
+			cancel_delayed_work_sync(&ionic->doorbell_check_dwork);
 		ionic_lif_unregister(ionic->lif);
 		ionic_devlink_unregister(ionic);
 		ionic_lif_deinit(ionic->lif);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index ec36ace6d010..9e42d599840d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -128,6 +128,13 @@ static void ionic_doorbell_check_dwork(struct work_struct *work)
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
@@ -151,8 +158,10 @@ static int ionic_watchdog_init(struct ionic *ionic)
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
@@ -161,6 +170,9 @@ void ionic_queue_doorbell_check(struct ionic *ionic, int delay)
 {
 	int cpu;
 
+	if (!ionic->lif->doorbell_wa)
+		return;
+
 	cpu = ionic_get_preferred_cpu(ionic, &ionic->lif->adminqcq->intr);
 	queue_delayed_work_on(cpu, ionic->wq, &ionic->doorbell_check_dwork,
 			      delay);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index d7abfbe05f2b..3b32228cee1e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -344,7 +344,8 @@ static int ionic_qcq_disable(struct ionic_lif *lif, struct ionic_qcq *qcq, int f
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
 		struct ionic_dev *idev = &lif->ionic->idev;
 
-		cancel_work_sync(&qcq->doorbell_napi_work);
+		if (lif->doorbell_wa)
+			cancel_work_sync(&qcq->doorbell_napi_work);
 		cancel_work_sync(&qcq->dim.work);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_SET);
@@ -691,7 +692,8 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 
 	INIT_WORK(&new->dim.work, ionic_dim_work);
 	new->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;
-	INIT_WORK(&new->doorbell_napi_work, ionic_doorbell_napi_work);
+	if (lif->doorbell_wa)
+		INIT_WORK(&new->doorbell_napi_work, ionic_doorbell_napi_work);
 
 	*qcq = new;
 
@@ -1215,12 +1217,14 @@ static int ionic_adminq_napi(struct napi_struct *napi, int budget)
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
@@ -3749,6 +3753,7 @@ int ionic_lif_init(struct ionic_lif *lif)
 		goto err_out_notifyq_deinit;
 
 	lif->rx_copybreak = IONIC_RX_COPYBREAK_DEFAULT;
+	lif->doorbell_wa = ionic_doorbell_wa(lif->ionic);
 
 	set_bit(IONIC_LIF_F_INITED, lif->state);
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 5bd501355670..3e1005293c4a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -211,6 +211,7 @@ struct ionic_lif {
 	u16 rx_copybreak;
 	u16 rx_mode;
 	bool registered;
+	bool doorbell_wa;
 	u16 lif_type;
 	unsigned int link_down_count;
 	unsigned int nmcast;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index a4e923376484..5bf13a5d411c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -950,7 +950,7 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
 				   work_done, flags);
 	}
 
-	if (!work_done)
+	if (!work_done && cq->bound_q->lif->doorbell_wa)
 		ionic_txq_poke_doorbell(&qcq->q);
 
 	return work_done;
@@ -993,7 +993,7 @@ int ionic_rx_napi(struct napi_struct *napi, int budget)
 				   work_done, flags);
 	}
 
-	if (!work_done)
+	if (!work_done && cq->bound_q->lif->doorbell_wa)
 		ionic_rxq_poke_doorbell(&qcq->q);
 
 	return work_done;
@@ -1038,10 +1038,12 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
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


