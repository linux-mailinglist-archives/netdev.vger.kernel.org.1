Return-Path: <netdev+bounces-17685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F321752AFE
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904E91C21428
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C85520FB7;
	Thu, 13 Jul 2023 19:30:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384852416B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:30:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7BF272B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBOYcdc0rgtYXuY11BX8oJOVzXruQm7mq2yjCd1It/6Iac1mZWtpH0wBFb/aUcmdOduhKe2B97ICXaP6KBJ5TQ4XDbrWH1gz5WMt2QvtMFFQFGLQzeiWDj6ALltT1hQbzDYlUvope6l05hR4LTnO759zI++ynD9Go5F5iuS2WAfC7wI5ISssn2yCMJO4ReR55Nc+j2YPYfYAcwU0Q4VqXcK3Fdz0DZurHgOTYKnyRVw6cchA7LnOuwj5R11l+YiG8PAN88AF24xjqs4lE1ohFMBL6cryn9SQnC2tBzZnfU7X8i/QaI0YeSmjH72LPVx8mKaoyWwlcF3SLwFa8o2pLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsHTLhxjQ2OrdiHl8vFNTStB0wXlMkKXv8avppg9wOA=;
 b=PoCRIvWGVbflzatc89hr1/h8eFBESPW3ZBFMbgiG0Z59/DfM3rRaI4UqrZqp4/HnsYAmXQxmAxKxHw9bG0o6DIfyMn+FXfahnP2oP4wXSdM/BjuyMCWuEyoeHedQHBxfzPT9RovFZoQP3/iZ7sUsWgCdE3UUo4j3EtQDdPXEcMrmhh+FYkld8vN5dnW8qr71QdIIQkSW9O7JASzMmwEfUfwQmGzVpaTz3RQJJ6g0eHMiLV9FM5KPabDJmj2/0JJ8oplyhKkZMyN/p+QOGIjDRq75otFPRNyqBFTslrM1bi1hZja74sx+pKfKBxbOWMGnqejbdI9K7CIvaOyaixrIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsHTLhxjQ2OrdiHl8vFNTStB0wXlMkKXv8avppg9wOA=;
 b=RAug4BLyYirl1X41f06GGNR0H8q1SwSHb96Dkn7Aoh641b1PSdsiAl8TBm7osPzupgEMgDiwvEL+AFaScpSRaZiJaAr5V/t/armSirA5j2bIzJxVvXtOi+AQkiNlmLkvsRR81kVvnAZacKEMfdjw+65PP9mrW79Z2cmRrD3Sw/w=
Received: from BN9P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::23)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 19:30:03 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::8) by BN9P223CA0018.outlook.office365.com
 (2603:10b6:408:10b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 19:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.26 via Frontend Transport; Thu, 13 Jul 2023 19:30:02 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 14:30:00 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 5/5] ionic: add FLR recovery support
Date: Thu, 13 Jul 2023 12:29:36 -0700
Message-ID: <20230713192936.45152-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230713192936.45152-1-shannon.nelson@amd.com>
References: <20230713192936.45152-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9f1d26-440b-480a-d925-08db83d78e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sRT2cJUBahQ8hwdQstCXvG64/naOa+xKnfoF3zDuCtILmYQpCMlkmkNLPXgefbDD06ON9MjUR4PVLAYvC+etq3mcoPtD5mpYSLKkQxcAfOEEFVL18SYDFhMPHDTaHHSTmOEVrJFO/8780rZxNkU4vOS25Fhq6wII6OASkwjt8xlAMnzXLqWuy6BzD4ZWC+Vc8DwD6TYn1oYvtGtTZX39Goa5BdGc20EF9fEFT3vRSbwFDHhlxldDX7SuwUyD7W2uYIm90FVtAkB9yBluw4s1XzH9jrkylOqehSTkXyxt3J0bnOsq7/HazSHOe/j0rIh8bkQJO3vdqVeOpBUoTU131pa639cvGYkYzSq4F/InUNl/1UrEg7Blf9MUvTeFGMDkP5q09LpLQh4QLkbbDPde3B2K12i+02bu5pgeCQWBPBZxIMhAUC9d5AlVuBxAzRqwVdwBskPRFbKtK/m6gBWE4Vn0NaQ05LD7AgL2xFI8yrOl4p26U3rxfZDMFSxqu0K8OoVeo49W9dmpkI8ShiDIIkaHSxXcqF711TxGYWnEUMAcmfMIQToTI3dLpmRyOpc7VWWjtKokS0Aw0q+5lSBPmktMtj58r1mgXVCV5b/2pjC7tqQ1EDvtGG4gOr1EjYOopjVunkC8++XFvqJRoh0LjDSJ1C2Rlq/tOcQSWmYJ1F1xRNMRscR8DPdftRY5/nDOLjdwa0pZveTznZZYt/OD1sDqUtnYz5vdOKzACuHolreQBwcvIG8cl/H/YxWcvMl02l+SnjPNUqAn6mpx4ZIHCQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(336012)(2616005)(41300700001)(26005)(1076003)(83380400001)(16526019)(36860700001)(186003)(47076005)(426003)(81166007)(478600001)(82740400003)(356005)(54906003)(110136005)(86362001)(40460700003)(6666004)(4326008)(40480700001)(70586007)(44832011)(70206006)(316002)(8936002)(82310400005)(8676002)(5660300002)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 19:30:02.7632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9f1d26-440b-480a-d925-08db83d78e18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
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


