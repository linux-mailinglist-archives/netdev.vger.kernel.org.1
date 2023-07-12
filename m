Return-Path: <netdev+bounces-16992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C8974FC12
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562631C20E69
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7FB374;
	Wed, 12 Jul 2023 00:20:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AC1A34
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:20:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD50FB
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hrkdr3FspaCrpssgP0Nt9MadFUnLDwJs+LJuk6Fd5gEyK24WweT5JxCHrf0FTZNJvctw/EQwiQoACn3S9QA4wwVRQxpZ+cuENUHk7wA1CpsI593m3v5pDKnmAgQ0H159xVlCNGX/jUYb4pwcFBM9O8I82IZPiBah+nN1evMj+VRN8iYwByxL7s5u9imvlG26qVr3DKFkYHxRTz54Cs0O7dwE318K5WFP1MB5rJCvjaZEDCN5thQ2DP+oD2wTiY6UviIxad5aCmUC0hMQAse5gyodNmuAB9DkMmFdtoWt96h5pNSXL7F1IScQtE00fpomD1vuMCUM45yyrX0QTzIALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKzGaYaEYrAQYe+xrWtcXi6pabrbtUZ5KH8DW24jpTg=;
 b=Ri/B/BzBxMLo05NSzhmJpQCCF0qY04Xj3yG8pePSyIYOBsDBdN2TsFozj2hdW1dlfiPrJLvGezH/5Er9N5EmLd6FoQGf1FKSkSfLQCf+wvcILYrTBHdlobJ4sQu9Ipx3JV5TNJDZc/1MNVs0dxVW+Eh0SfDX1p5JQiZvQAniOxNsb9ZTQqk6X8qgyYINFrzwmrazo0U4t0HpL8xeG0qySnjIdTNfSuPkxTCv/DinMogabGVMq9UWo3lhLu2mZ+VWu0dVo/9wVe6TxlOSZx+hh/4/Z0Qvawyrhx25XZ602VAPjx1ffzRUn71n/9j8Rg4bGMPYfTxsrZC0lEtyMocrEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKzGaYaEYrAQYe+xrWtcXi6pabrbtUZ5KH8DW24jpTg=;
 b=Hu0h9+p3yW7b7PvFBT1WWnAGSKYgdo9IB4eMFAtxWjYSh9UrRUgVAgV03x0gUUvSpUNnrpjjUuazayeUdFY3Ky7pjd+OtUFAcz9Bjlqs0GC0mFDX3pvdTLNu1R53AhE91jZOCcpmgp7u7BPH0Vcy4R7f9frRY0wgEQ1T2R4kPh8=
Received: from BN8PR15CA0055.namprd15.prod.outlook.com (2603:10b6:408:80::32)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 00:20:50 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::28) by BN8PR15CA0055.outlook.office365.com
 (2603:10b6:408:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Wed, 12 Jul 2023 00:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 00:20:50 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 19:20:49 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 5/5] ionic: add FLR recovery support
Date: Tue, 11 Jul 2023 17:20:25 -0700
Message-ID: <20230712002025.24444-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230712002025.24444-1-shannon.nelson@amd.com>
References: <20230712002025.24444-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a34de2d-e4eb-4576-6fbb-08db826dd8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YVXtm9oVwsyDBt7KSJ1yt5NIEpyis0fg0GNCYnt3awBxNKmKsr3g/l9KVS6CUwO2tC4Kt4hDYLp22HgIoyAjQoK0PipWFBQOawUZqwzdoAcMfZGX4It9ShkHaryo2VOEZ1sGXAMtxY/w/R+O2PgLEwg/ra2FrnEQgVS/o2MdegO+rolX95oH6YeRSqIWnhpphoMT4W5LXI96jrgfKcudk7GKd08qdADXEjFNDoeDx9hODw+rFYNlPWBkULHdSqZUImPEuxhyh1M0YECaZVkQEVCOwYY5zEELvCOSpAOGP3uoocTW3sFnteSBEbqzEjYh/CigqJPmfD71X8EduSH74YJPVzwleH8PEZGt2tJZbfyKq5ucE5ZhkMiWfITD6fmwHs/Ap1C4+Zlto8SJ6Wo3c+F5GB7g9bM3II74g9tApx0kAjT0qa+clOjMRbBRgXStl59L7jTuM1NjiqCXFYmsqOE3eSgP9c5FfenBuZVW/b3OPW+fl0VcVqSM9/yZeQtUjx00YBeRiHk0taY0ZJpZWbOJeOI+RkZYwgapi9kxrCuM2K2iBpvIIt3Nc1hRARJi3kEoYDzkw2StgW6Lx3K1huLRwxGtxLMwo1rp1grs6+TUfeIcbvCEHKDYX534XbVKlPaShWRiZl7Dcp02vRcDahJMb9AWs27S8PdENMlr6Zigw/mRx+WNrnPu1SfRQrQMDVA7ordUPcYctzsZKPS65CYWcSO9Iapitp34LnpL2XGia+HLkcn0F6Xw8gUqi9sP+5OGVxYUJdKjNeL1KYnmmw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(44832011)(316002)(70206006)(41300700001)(70586007)(8936002)(2906002)(4326008)(6666004)(8676002)(54906003)(47076005)(1076003)(26005)(83380400001)(16526019)(186003)(2616005)(426003)(336012)(36860700001)(40460700003)(110136005)(478600001)(82740400003)(81166007)(356005)(82310400005)(36756003)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 00:20:50.0814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a34de2d-e4eb-4576-6fbb-08db826dd8ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for the PCI reset handlers in order to manage an FLR event.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../ethernet/pensando/ionic/ionic_bus_pci.c   | 58 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  8 +--
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  5 ++
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index b141a29177df..8679d463e98a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -320,6 +320,8 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_out;
 
+	pci_save_state(pdev);
+
 	/* Allocate and init the LIF */
 	err = ionic_lif_size(ionic);
 	if (err) {
@@ -408,12 +410,68 @@ static void ionic_remove(struct pci_dev *pdev)
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
+	pci_restore_state(pdev);
+	pci_save_state(pdev);
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
index 57ab25b9108e..e70952e508bf 100644
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
@@ -1759,7 +1759,7 @@ static int ionic_set_mac_address(struct net_device *netdev, void *sa)
 	return ionic_lif_addr_add(netdev_priv(netdev), mac);
 }
 
-static void ionic_stop_queues_reconfig(struct ionic_lif *lif)
+void ionic_stop_queues_reconfig(struct ionic_lif *lif)
 {
 	/* Stop and clean the queues before reconfiguration */
 	netif_device_detach(lif->netdev);
@@ -2014,7 +2014,7 @@ static void ionic_txrx_deinit(struct ionic_lif *lif)
 	}
 }
 
-static void ionic_txrx_free(struct ionic_lif *lif)
+void ionic_txrx_free(struct ionic_lif *lif)
 {
 	unsigned int i;
 
@@ -3271,7 +3271,7 @@ static void ionic_lif_handle_fw_down(struct ionic_lif *lif)
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


