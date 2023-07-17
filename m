Return-Path: <netdev+bounces-18369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3034A7569CC
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E181C20B5E
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C91FD7;
	Mon, 17 Jul 2023 17:01:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703B1878
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:01:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E7FF7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+mbhWw1Xwb2BNlMi68EfIisTI9ag47mbWELh206lsqr/12i1ELSnt9T+rk3MOYJKFeHKMtNq2ZwMddCnWuM1cO8Kxx9su3z3hiQucnrk1xLwHanakcS+Tk19lYqqI0mJuRYIKDPQeua0ReYeC/rZX4vB+Dp09n9fcCUdq+D8zYZ9hDsb5/XOnpYsdBCL/gFDqoI2ZpwhXDfTNmNf/dWqMtlZ0T4MzGCePxthqq0BSkhrTojM0LF63NWaoUh4FqGjN67BRGCX72j3+wHf63EqnrYw0WJQHiMToLg9Hsm8r2UPNsqJ32124zGmw18OILkJsuV3xLw9cIdtU5n5ziMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlRzQPKX0GCRdl4J0We4dPIv8uiVTa48synp85cJtWw=;
 b=e0LfhFZR/OrT8EN3IOpVPf2cSQ7grbWGE0aVLVOlOtviQSUkCEmeZ62yp8jdypB6R8sa3hll+fIK64VpgUDA2LeQqilV/yb83AxdOiFIz+nAr638iButk5h5U9A5tbiWlYk/fR+Lq6gSl/DTW0pmytqnZblFi7sLgioICoxV0F82aw2wOV6a/SyiJ2YT9C2TJut02eyPece3+05Ul5r6DCsDkKx+SIIcLNxQNK+X7v3kfavAtMW5OaYV6NBnTAfTeDQQLnH9BV54omSDkS1quNOwAcu8BN4qsKsdG/RVCGgnoD8t+sgYgcUm5/7VjwUZ44OfqGvFpvSueev2Z/fFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlRzQPKX0GCRdl4J0We4dPIv8uiVTa48synp85cJtWw=;
 b=4TXVS4E5fbpVQBI/70pbZtegF02L8wkhk2o976wsig44BACZWyuUOM6/0YJahlNrfHheCBgoUA/sJEY6wuhpe2JsHqUglN9E9ZKqViO6QC09r1rR18VmDNa5Goh8oWT8PcSFmk8o+IXPyxDQn84iX3NTXve81q9ATMrHFF2F5qM=
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 17:01:28 +0000
Received: from CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::4b) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 17:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT102.mail.protection.outlook.com (10.13.175.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 17:01:28 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 12:01:15 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3  net-next 4/4] ionic: add FLR recovery support
Date: Mon, 17 Jul 2023 10:00:01 -0700
Message-ID: <20230717170001.30539-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717170001.30539-1-shannon.nelson@amd.com>
References: <20230717170001.30539-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT102:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: ab469709-5787-4763-5451-08db86e7766b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UI3OuXP3euNIJj39RkT0Tm7K+8ZvDDbXSQRJD9y8xTm5LlFgDHR/tn6uDlTTqPld/TTpP1+dmecHqLKUG7ZhnFhZGRESKgCfY6a8T3UuItgOYcb/44DdHF+zdAL/yQ3s4KhLdQlQR+yUgK9afRY/4DTMxiYDS3va5Ro6TnGlzGv+i0NrH0XtV9YEhx8zyhDEtg29z3ww3NOaCUDPflfZ7Qs2WSWtyjCGBAY8fL3RuVADnIVjRk5JPPf8hJ2+/gZQQbGnCGAyX0S/Tst+hub47ZMUfTs7ghiBFoOsjJVfE9JBBp8hFFvlDK9/m6Ez6M3sMkaJ9doi9kCJ+LCgDU2BPaVqqDMuJwyhHeaKYmiG6915d+wUlcwz3DC6X3XBw/eBaflODS6BChKAwgzJ4ngCtnQduEQwAR5mYX/2uXulKVtU7i6NQF3XGv1qSxsy/TxpdayWaMg17IsuKCcrl3KWNsFac+psunzdrd51fLSWB/XxIW50CfARF8g6rL/A/g2FGIBrz7M3jls1EPR2VNxsx2J7fHJ4MxV7oyvpv/Rz2LlRlo69zMy+bTAmn2D3iP+3z7YNg8I0aOkl7+pPVO62EqKS8ai2Fyhgj6IWJ00kzFAzvg2zyx7vfXMR5IrG8mqHtjdnUOzWgrLZTTmCAa05ldW6EoJBBgvefHscZezoT8iwoQgyk9xHCkir47gA2i3rTsF0c8VGT/IZ/RPTF5wth7mXtEIBfJNu3zKcYsXMCFgQlzO3QsIax0QPDb+5P81MUIJLf13nhsjRtl/Xv68jnw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(336012)(4326008)(47076005)(426003)(36860700001)(83380400001)(2616005)(186003)(26005)(1076003)(16526019)(6666004)(478600001)(82740400003)(356005)(110136005)(54906003)(81166007)(70206006)(70586007)(2906002)(8936002)(8676002)(5660300002)(316002)(44832011)(41300700001)(36756003)(86362001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 17:01:28.3963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab469709-5787-4763-5451-08db86e7766b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
index b141a29177df..3fb7925c2d47 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -408,12 +408,65 @@ static void ionic_remove(struct pci_dev *pdev)
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
index 94b14ea6ffee..9a10458f4a31 100644
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


