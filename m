Return-Path: <netdev+bounces-56046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E25180DA0C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10B61C2169E
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31B3524D1;
	Mon, 11 Dec 2023 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VGtw/Uof"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961BEBD
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:58:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAf6VxRxfb60G97PBOJYi9bcEZmAw2McMBM7YfjDfTLQpu8qNL62G+LesERhVo5wuUGbzbF+BHcZm9scxrHnMyjHgjDjiJ18UK4Qt/HKGyq7Fmbt8Lq3QfG7+TIBGzrbLThrZhOa2e3rr1fBqm5eG9fqCSmfZ9Hsjh9c/tIvMU0qW41ptIAFDyy+y5lQcg8tzppdyt3liNFMjt7KzytGnow4yfwFaCZjUCXlkWUR4O7fUfrT7hh+G9zFCdEY+CPpC/lxE6HFWA1fyoY87+ye8AY/r4L7PnPDi186Rrqi8zJOxKldMEAAbTlR6cRGSCne2h3jpsstU1gGkb0c/heEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seSl7s9oP1JPLhymbI9TmGiMbBy39Fjmiz9t4JtSfJM=;
 b=I368h6q0Mc81jeFH8fG2ri90HDqqcgWOXxlqJolLsef5aC3KXH3oMxkC14EEXluDwE0Orx+nh1i2EW+xKXEZ/axXD3VwfQ3jjCO4f8nVTXOT17Q3pkGZtvNKOVchjSmgqV4A1h6x+urxny8ocYLvs/GEs9GAxf1JfOA1cuU3jxZ0k5afPXNQcnP023QWp3Oyqz2AA66fDO9UuL+rkCR7txa2cuMgp3Z7EmbMrA1HI+nTGaW4LUIIb7o2OP4tpc4KzCGNa1E3aRuoFht5Ud0FSqas5V9ch7uO8/FMSOf/p7V9lZxeyRxy1vLCNUZjTycvQZ7Mcjs98oEo87SCf5LJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seSl7s9oP1JPLhymbI9TmGiMbBy39Fjmiz9t4JtSfJM=;
 b=VGtw/Uofa1pEh6OynXlUNghbhS2E+QYT9YxzpzHYIHi7APTW/iW0F92WmF+t4q/XnesvDNGnUcR+SrrmRd25kPckl099daw/xGd6insU8+b744FO6jnFlSZXbJ7NyKoGn9fdWo/ipYtrm1Xdt/D7bYNo7eRicvjfsrwJrtx6ezA=
Received: from CH5P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::15)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 18:58:25 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:1ee:cafe::f8) by CH5P222CA0001.outlook.office365.com
 (2603:10b6:610:1ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 18:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 18:58:25 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 12:58:21 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 3/8] ionic: bypass firmware cmds when stuck in reset
Date: Mon, 11 Dec 2023 10:57:59 -0800
Message-ID: <20231211185804.18668-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231211185804.18668-1-shannon.nelson@amd.com>
References: <20231211185804.18668-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac7587b-76ca-4056-d254-08dbfa7b2760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nJTzB1dgpX7JWuCmumI7SoIqexsj2FKbLqbl9wihazR6ND9AFfKp4AkfsPk4VeMvTWjaaEEjkMT+QTRF1VeG86/ZJtYiIVem2DVhfZQICtGfHengYVGNe5U0a4r1ZFr1VCtNWqxcF2IDTr2sbx7ci/AVmx+e0ihLrYZXYVacr1Z9uDV2YSBn3ZgyCkaCb9OG+iFE93PtL53jcUUpvuURQTVEssb25V55PMmarQv+5WGunL/q02gv8H+WXYrNRprv/6p6a55ZLL/BtyP+IQziP/fgmqRgN4i9abGQEMqI1M5lFV0UPtqPJKQN7VveZGzRGin0BEvD2SgE2Fex+xN9RkJ+vER7T4dQbdEFH3BJHwXA5jHBf09PrUoZ48Q4WyyP9fm9mVLosAIxnyUj/8bGZaPy2DwUCkeE8dN3LPxW220A3OloGXysSURPzxeYNBdZ2x6oCXfjcu6RtodeQDtxsfGoGC/H4Z8w2bF8724KhFpl7QnwUGqbx11t6p/irfrwFQWBpNbao09E+PbTWUyDrdDn0q/J++h8f6o+dKm9ZUEwd3jwn0jO5Zx3qIR00JKcCm6PCsek7K/wJlzzVB5PhjOqQmkuJtumbzAUXiXLPPZd9foIijrWT32pJdNiRcFZbMJAW8BGDExE+2eAD62eDBIF2cTWLjpGZyBL5tNLpFSpxDLTYv0PoKIijElPyaRMNmKJiF3s6rshkX9CCwbmApCLc/AQjgT6ATyJcJxeV8nLoIm+hhiz/mHckdr/ZRivUee34iitPyLMjGoN/DwqmA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(1076003)(26005)(426003)(16526019)(2616005)(336012)(40460700003)(82740400003)(36756003)(81166007)(86362001)(356005)(47076005)(5660300002)(83380400001)(44832011)(6666004)(36860700001)(316002)(70586007)(70206006)(110136005)(8936002)(8676002)(54906003)(41300700001)(4326008)(2906002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:58:25.0541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac7587b-76ca-4056-d254-08dbfa7b2760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076

If the driver or firmware is stuck in reset state, don't bother
trying to use adminq commands.  This speeds up shutdown and
prevents unnecessary timeouts and error messages.

This includes a bit of rework on ionic_adminq_post_wait()
and ionic_adminq_post_wait_nomsg() to both use
__ionic_adminq_post_wait() which can do the checks needed in
both cases.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |  4 ++++
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  3 +++
 .../net/ethernet/pensando/ionic/ionic_main.c  | 20 ++++++++++++-------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 43e7967ad1c5..f69178b9636f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -392,6 +392,10 @@ static void ionic_remove(struct pci_dev *pdev)
 	del_timer_sync(&ionic->watchdog_timer);
 
 	if (ionic->lif) {
+		/* prevent adminq cmds if already known as down */
+		if (test_and_clear_bit(IONIC_LIF_F_FW_RESET, ionic->lif->state))
+			set_bit(IONIC_LIF_F_FW_STOPPING, ionic->lif->state);
+
 		ionic_lif_unregister(ionic->lif);
 		ionic_devlink_unregister(ionic);
 		ionic_lif_deinit(ionic->lif);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 6842a31fc04b..6669c5e52c71 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3161,6 +3161,9 @@ static void ionic_lif_reset(struct ionic_lif *lif)
 {
 	struct ionic_dev *idev = &lif->ionic->idev;
 
+	if (!ionic_is_fw_running(idev))
+		return;
+
 	mutex_lock(&lif->ionic->dev_cmd_lock);
 	ionic_dev_cmd_lif_reset(idev, lif->index);
 	ionic_dev_cmd_wait(lif->ionic, DEVCMD_TIMEOUT);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 873a86010b27..165ab08ad2dd 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -388,22 +388,28 @@ int ionic_adminq_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx,
 				      do_msg);
 }
 
-int ionic_adminq_post_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
+static int __ionic_adminq_post_wait(struct ionic_lif *lif,
+				    struct ionic_admin_ctx *ctx,
+				    const bool do_msg)
 {
 	int err;
 
+	if (!ionic_is_fw_running(&lif->ionic->idev))
+		return 0;
+
 	err = ionic_adminq_post(lif, ctx);
 
-	return ionic_adminq_wait(lif, ctx, err, true);
+	return ionic_adminq_wait(lif, ctx, err, do_msg);
 }
 
-int ionic_adminq_post_wait_nomsg(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
+int ionic_adminq_post_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
 {
-	int err;
-
-	err = ionic_adminq_post(lif, ctx);
+	return __ionic_adminq_post_wait(lif, ctx, true);
+}
 
-	return ionic_adminq_wait(lif, ctx, err, false);
+int ionic_adminq_post_wait_nomsg(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
+{
+	return __ionic_adminq_post_wait(lif, ctx, false);
 }
 
 static void ionic_dev_cmd_clean(struct ionic *ionic)
-- 
2.17.1


