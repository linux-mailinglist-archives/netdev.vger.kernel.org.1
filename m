Return-Path: <netdev+bounces-19628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF77D75B78B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAFB281C11
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179701BE7A;
	Thu, 20 Jul 2023 19:08:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28A1BE78
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 19:08:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E231731
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB52wpOtUUkw1ANn+GBys7fRm2fuiSul/sLtXcAIr5BAd25XB4MxFMI+MsMFjE2GX/TRpj7BYHMyqK1VLPlAgdap2+Ezdhp9fX8EFfvtqw7uc8eWI5u8xpwMN4wDSPJ3nMWVaSv5WzLGg+NElRfO88JKBJLr3rXjDqI72bpNGH09/8bD5vm6/QABa1OWiPjFiio3MGwAAvacDhbD2yU1yMxviSuRW7nwTBNq5rHbMukClU0x+BVyh/Dxgt7Wj5XwsWBYR1TPRXvFdTAGt4aX9Py3upseQu0MfbdnGlfdZD4eQk6fS7Zbwzt7HMLVx4xnz7IP9MSKyY6nJFS1KyxbrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgf8XHuID+V8m5lp2qUr1xdplpkPPnWhoe4FgH+cgEI=;
 b=HxDDemxS1Avl/IuL15lLc835F6YnNPdzMBTKjPIb+CnaKTMzw1I/OPf3SCjzC6pDeQS3ODfPVn1gpxHa/JMKEzwXqaIsVh+cSqapGAl0qeiZjbyRuupaLnhVBdQdIptV3USNjUIgQzVu6gDgR661IJ99Wn3G9ek6d8osS3k9TVleVwhNeWMVqnF3j7ZGaJguFdhBZ+GP4cBSs6QscFR4mv1g2qcFKcciljKBhSwsV7aZymVTFg7VY53iTO7CQKGeIhZsDoiT99ohvxKtJCuDRCFj9S4IqcKpduDdRexrP+XzBFVtK4StQvt0wO8/P4d9E/+sX5tsQJEqYN41SLDpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgf8XHuID+V8m5lp2qUr1xdplpkPPnWhoe4FgH+cgEI=;
 b=RLLO5Z8TFaRJzAi6Zo+lQCFzvBX9frBD2uyzzw4XoenxGyFZhvJaT24IwV3rpNNTZM3ujk6h7zF0m/v9ZpDY6ZssrF7H1NjMYSll0s7x7IuU+aYJoNAAEZtIFzNIuXzgdNGGzoLs7/QZ45ruQltGF6wW3HWlw4aiAcVABcBCpBw=
Received: from DS7PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:3bb::17)
 by CH0PR12MB5297.namprd12.prod.outlook.com (2603:10b6:610:d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 20 Jul
 2023 19:08:43 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::cf) by DS7PR03CA0072.outlook.office365.com
 (2603:10b6:5:3bb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Thu, 20 Jul 2023 19:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 19:08:43 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 14:08:39 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<simon.horman@corigine.com>, <idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v4 net-next 4/4] ionic: add FLR recovery support
Date: Thu, 20 Jul 2023 12:08:16 -0700
Message-ID: <20230720190816.15577-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230720190816.15577-1-shannon.nelson@amd.com>
References: <20230720190816.15577-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|CH0PR12MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dfa3f6c-dd2f-4fcc-96d6-08db8954bc66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zB/WmRx+cH7hDGUzzt8GJjO5R8OagiIroSoXIcT7XeRL5wSEN1fsR09qkXwRVaz4bqsYVyTIcOJ94AGPUtYDO0zReYBE5kungT1Nh8zDmMFuItEFB7y0qlVlUsBkoc25qG06+//9JDZ1kVR09DrwNNtL8XwSYSNjy+Av95WbmlE/cIo9meIv8MMFjdWdMLWBvFHLMGnhsxGkspIuRFfU044ya/x38IStrcDkXkiTJ6Jcn2ww7g3Yt/rNAG8yKlBKBbKa1zPKTiADfs1K2Hp2lplKiEoPDrc0vOXhuKbcqY5QyzoG9vSiGUKjQFP3ITouNjNPEhQRxP9dTWpzXy7jL2X26H0K/9UWi/xYrzYgVHO6Lm+hw2ULOXwHwY8n8AIbQVcBwsPsRuaJo3HuotBPLUiQLvQ5tl2TQ3SFT2vf/rsc81rHtlk8Y2s8AgaGZ1Y9xYhXK+p9GyH5zUWEZfjNjDiGnBw2TW7KOwxQAOS4EO16qT8GEK7lJ629sJ710Tc9VBsTUFdRapmqKiBZz2OJRg/ax9qFDxRehT23WpGNdPvcFpP+d6E888HhweuUN7NDjqdxNUCYjo2MkvSgFKORWlHj3/vVpSSVPb4ebx+TFz1E2u6oww1/UVuWTw0E18HmEYsa9/AXnbIf0nNqV7D6bM0xoA7m4uQFKkjFvPE52iG5geYqEEJcF6AebWeidUv6fZ3gNZ7BUYcAR7JWrJf469w8XKqam9fX05K3zJHi/Wq7E+m+XvoWYM0sn3zAs/OpI1fy4iWkPB0rWrFGYSmG9w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(40480700001)(70586007)(356005)(82740400003)(86362001)(81166007)(83380400001)(2906002)(36860700001)(8936002)(478600001)(8676002)(2616005)(426003)(47076005)(70206006)(40460700003)(36756003)(1076003)(5660300002)(26005)(336012)(186003)(6666004)(16526019)(44832011)(4326008)(110136005)(54906003)(41300700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:08:43.3374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfa3f6c-dd2f-4fcc-96d6-08db8954bc66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5297
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for the PCI reset handlers in order to manage an FLR event.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../ethernet/pensando/ionic/ionic_bus_pci.c   | 53 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  8 +--
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  5 ++
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index bcce613449c2..d6ce113a4210 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -409,12 +409,65 @@ static void ionic_remove(struct pci_dev *pdev)
 	ionic_devlink_free(ionic);
 }
 
+static void ionic_reset_prepare(struct pci_dev *pdev)
+{
+	struct ionic *ionic = pci_get_drvdata(pdev);
+	struct ionic_lif *lif = ionic->lif;
+
+	dev_dbg(ionic->dev, "%s: device stopping\n", __func__);
+
+	del_timer_sync(&ionic->watchdog_timer);
+	cancel_work_sync(&lif->deferred.work);
+
+	mutex_lock(&lif->queue_lock);
+	ionic_stop_queues_reconfig(lif);
+	ionic_txrx_free(lif);
+	ionic_lif_deinit(lif);
+	ionic_qcqs_free(lif);
+	mutex_unlock(&lif->queue_lock);
+
+	ionic_dev_teardown(ionic);
+	ionic_clear_pci(ionic);
+	ionic_debugfs_del_dev(ionic);
+}
+
+static void ionic_reset_done(struct pci_dev *pdev)
+{
+	struct ionic *ionic = pci_get_drvdata(pdev);
+	struct ionic_lif *lif = ionic->lif;
+	int err;
+
+	err = ionic_setup_one(ionic);
+	if (err)
+		goto err_out;
+
+	ionic_debugfs_add_sizes(ionic);
+	ionic_debugfs_add_lif(ionic->lif);
+
+	err = ionic_restart_lif(lif);
+	if (err)
+		goto err_out;
+
+	mod_timer(&ionic->watchdog_timer, jiffies + 1);
+
+err_out:
+	dev_dbg(ionic->dev, "%s: device recovery %s\n",
+		__func__, err ? "failed" : "done");
+}
+
+static const struct pci_error_handlers ionic_err_handler = {
+	/* FLR handling */
+	.reset_prepare      = ionic_reset_prepare,
+	.reset_done         = ionic_reset_done,
+};
+
 static struct pci_driver ionic_driver = {
 	.name = IONIC_DRV_NAME,
 	.id_table = ionic_id_table,
 	.probe = ionic_probe,
 	.remove = ionic_remove,
 	.sriov_configure = ionic_sriov_configure,
+	.err_handler = &ionic_err_handler
 };
 
 int ionic_bus_register_driver(void)
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 2d03c1b995bc..adc05f944c14 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -434,7 +434,7 @@ static void ionic_qcq_free(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	}
 }
 
-static void ionic_qcqs_free(struct ionic_lif *lif)
+void ionic_qcqs_free(struct ionic_lif *lif)
 {
 	struct device *dev = lif->ionic->dev;
 	struct ionic_qcq *adminqcq;
@@ -1754,7 +1754,7 @@ static int ionic_set_mac_address(struct net_device *netdev, void *sa)
 	return ionic_lif_addr_add(netdev_priv(netdev), mac);
 }
 
-static void ionic_stop_queues_reconfig(struct ionic_lif *lif)
+void ionic_stop_queues_reconfig(struct ionic_lif *lif)
 {
 	/* Stop and clean the queues before reconfiguration */
 	netif_device_detach(lif->netdev);
@@ -2009,7 +2009,7 @@ static void ionic_txrx_deinit(struct ionic_lif *lif)
 	}
 }
 
-static void ionic_txrx_free(struct ionic_lif *lif)
+void ionic_txrx_free(struct ionic_lif *lif)
 {
 	unsigned int i;
 
@@ -3266,7 +3266,7 @@ static void ionic_lif_handle_fw_down(struct ionic_lif *lif)
 	dev_info(ionic->dev, "FW Down: LIFs stopped\n");
 }
 
-static int ionic_restart_lif(struct ionic_lif *lif)
+int ionic_restart_lif(struct ionic_lif *lif)
 {
 	struct ionic *ionic = lif->ionic;
 	int err;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index fd2ea670e7d8..457c24195ca6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -325,6 +325,11 @@ void ionic_lif_deinit(struct ionic_lif *lif);
 int ionic_lif_addr_add(struct ionic_lif *lif, const u8 *addr);
 int ionic_lif_addr_del(struct ionic_lif *lif, const u8 *addr);
 
+void ionic_stop_queues_reconfig(struct ionic_lif *lif);
+void ionic_txrx_free(struct ionic_lif *lif);
+void ionic_qcqs_free(struct ionic_lif *lif);
+int ionic_restart_lif(struct ionic_lif *lif);
+
 int ionic_lif_register(struct ionic_lif *lif);
 void ionic_lif_unregister(struct ionic_lif *lif);
 int ionic_lif_identify(struct ionic *ionic, u8 lif_type,
-- 
2.17.1


