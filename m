Return-Path: <netdev+bounces-18367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A459B7569CA
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C330281BBE
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F38B1FAD;
	Mon, 17 Jul 2023 17:01:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFEBA53
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:01:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86AEF7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXf7x0roaEZ7yygrXjHmZQGuDy7bVAf8vHs+dAfYF3bfjAMOcKgq2UW6MpPbwoa2kaNDnTufrkqWPwiBFWC6FKnRwNcvkGZ2/CKlIQ+tY2EzefCUtihToQpLh1wWKAxlSGu43QaDSXQ5TXjP0M874ENEg2BxNy+t9man+cMrcbN3qzsN6YlS3cWGqZKt0eWlFf2cA29tXhmY43nejSyIvzHTskvo+m3nDLENGG039f+sNMGWSmfinsi2Ow6hlJhZYKeNE2nwBvss1l4aYunI8FEhfPJ99NjMmrZ0pfc1UUx2swiyohaETa9ri/GFyNfhgBnsLy5sRQJbpjM8TM9ciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnyeEAsZ+PXRzIeRfU9AXImqgcQaAMhVyW6nhLZtEpo=;
 b=HTo4eg+0FX3U2V8IYIdfpV+r7CV4Vut9R6xlzAfjqAYR+iaP3BYHRR8mKMG2POsTke72RKnio8UuQLw0qoYtJr2o9uWBmburgHdcavW7Lg7zpap1eb5luhT0RCgV3t8oF0ardJvp//P9xk9vDGidBclWzZnSxK26dSS/XvjATlgQmIkhVJOmvZ35im6nsJQrGQrm/MduGZVDKvFkajd9HUwcvYYtA/6yAVlTbnrLaygNc/i1jXCQFSCmVi9U05qsCpkEZ+CNK9HtjHIAweIz1dSQUV+0wIgOUTJPXpcAyum65sMHx2BEjw1TJkEkoH2P3Fr3g/+32E5A3bIAxJ26/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnyeEAsZ+PXRzIeRfU9AXImqgcQaAMhVyW6nhLZtEpo=;
 b=AH6bIpsiUhtahKi7wsq5JJSfT+FO3nPRNnNEGAtWfgaPmovs62rPU51Nx8fN6P2kqsAzYRplc1V3AMicx6C56d4ffLiPUEPzwRh2/zJhDd82RsinfpLCdln/H/55sjih+DMwTd4n7RpxPuVmNC73k1AioJ6ECQKsEzBPjATMZW0=
Received: from MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Mon, 17 Jul
 2023 17:01:15 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::de) by MW4PR04CA0302.outlook.office365.com
 (2603:10b6:303:82::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 17:01:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 17:01:14 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 12:01:13 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3  net-next 2/4] ionic: extract common bits from ionic_probe
Date: Mon, 17 Jul 2023 09:59:59 -0700
Message-ID: <20230717170001.30539-3-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT082:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 839f83d8-f75d-40d6-0304-08db86e76e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NUrK4wqoY0IvaAftwn5lSdc0sm7HJwY4143qlzoQInUBzf4Q2n3X5UFabnim+0jhql3MnIeWNZOfnsffK1YCFq2oEZ9B/AbGE/HddR9mHkC7u5g9nHqIqLlJQhRqF0ql3ZimH84Whe/ANhMhRish60kYY5fdiqPlJtL8G8U7XdU0Az0kmRAT/7ZCXCnPyf/fK6FONhcSqaRsYrx1H61J2DKCXOIaHUnbNRJ9OiKPVrOYw9l7C3hoqGrOf9rqPw+834WlJ8UMq1pjttWw4kW+7E9R3wPxrAGKM5ZSOJlqdVKZmcxDQQtNe7L/hkMz43QWO9hmmlgikDjrFO2pKUaplkScSe7LhjyXXIucVyH4XhjMBjGl7D0vXJK1tybpm6DhknIXMD51m5tLIddzHjAEy3vLk+mgHzv3OD2T9AYkz6PI7PtXH7WviBp7ip3ZsJxeK/vqmNcur09FAr6kR2eFSFLpkNdTwNZYjOtDCU1BUN1FpEmH1p+LbiBViU6Zwp1CxGp5qG6vlT4RsmRwBV7pZiC7FnXzvd0E4uG4ycHTHNjyHjjM2hFULFvfkCbwaxLBiK7VdeK1I1iQ/6g8eU3bJ2sDVwhdyAkQimh+59Zyb6rtQffihhHETvgBZVnQWwJoJX5sCbFBe2JLAWumrBVmIAYp2Ol9P0bD4jZdSS5EkHeh3m+m3LXKeYn5h/VVMDy7T2GJkdZhvtd3Fk4LhoESQBpF91iDUl4DTfzVLyAuHrMyyl5fHdloK3UQka1uxmTDv8OD4YH+mOf+8KzGucYYgA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(110136005)(54906003)(6666004)(478600001)(36860700001)(426003)(2616005)(83380400001)(47076005)(36756003)(86362001)(40460700003)(40480700001)(356005)(2906002)(70586007)(1076003)(336012)(186003)(26005)(16526019)(81166007)(4326008)(70206006)(44832011)(41300700001)(8676002)(8936002)(316002)(82740400003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 17:01:14.8545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839f83d8-f75d-40d6-0304-08db86e76e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pull out some chunks of code from ionic_probe() that will
be common in rebuild paths.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../ethernet/pensando/ionic/ionic_bus_pci.c   | 85 +++++++++++--------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 2bc3cab3967d..b141a29177df 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -220,30 +220,12 @@ static void ionic_clear_pci(struct ionic *ionic)
 	pci_disable_device(ionic->pdev);
 }
 
-static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int ionic_setup_one(struct ionic *ionic)
 {
-	struct device *dev = &pdev->dev;
-	struct ionic *ionic;
-	int num_vfs;
+	struct pci_dev *pdev = ionic->pdev;
+	struct device *dev = ionic->dev;
 	int err;
 
-	ionic = ionic_devlink_alloc(dev);
-	if (!ionic)
-		return -ENOMEM;
-
-	ionic->pdev = pdev;
-	ionic->dev = dev;
-	pci_set_drvdata(pdev, ionic);
-	mutex_init(&ionic->dev_cmd_lock);
-
-	/* Query system for DMA addressing limitation for the device. */
-	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(IONIC_ADDR_LEN));
-	if (err) {
-		dev_err(dev, "Unable to obtain 64-bit DMA for consistent allocations, aborting.  err=%d\n",
-			err);
-		goto err_out_clear_drvdata;
-	}
-
 	ionic_debugfs_add_dev(ionic);
 
 	/* Setup PCI device */
@@ -258,7 +240,6 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_err(dev, "Cannot request PCI regions: %d, aborting\n", err);
 		goto err_out_clear_pci;
 	}
-
 	pcie_print_link_status(pdev);
 
 	err = ionic_map_bars(ionic);
@@ -286,24 +267,64 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_teardown;
 	}
 
-	/* Configure the ports */
+	/* Configure the port */
 	err = ionic_port_identify(ionic);
 	if (err) {
 		dev_err(dev, "Cannot identify port: %d, aborting\n", err);
-		goto err_out_reset;
+		goto err_out_teardown;
 	}
 
 	err = ionic_port_init(ionic);
 	if (err) {
 		dev_err(dev, "Cannot init port: %d, aborting\n", err);
-		goto err_out_reset;
+		goto err_out_teardown;
 	}
 
+	return 0;
+
+err_out_teardown:
+	ionic_dev_teardown(ionic);
+err_out_clear_pci:
+	ionic_clear_pci(ionic);
+err_out_debugfs_del_dev:
+	ionic_debugfs_del_dev(ionic);
+
+	return err;
+}
+
+static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct ionic *ionic;
+	int num_vfs;
+	int err;
+
+	ionic = ionic_devlink_alloc(dev);
+	if (!ionic)
+		return -ENOMEM;
+
+	ionic->pdev = pdev;
+	ionic->dev = dev;
+	pci_set_drvdata(pdev, ionic);
+	mutex_init(&ionic->dev_cmd_lock);
+
+	/* Query system for DMA addressing limitation for the device. */
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(IONIC_ADDR_LEN));
+	if (err) {
+		dev_err(dev, "Unable to obtain 64-bit DMA for consistent allocations, aborting.  err=%d\n",
+			err);
+		goto err_out;
+	}
+
+	err = ionic_setup_one(ionic);
+	if (err)
+		goto err_out;
+
 	/* Allocate and init the LIF */
 	err = ionic_lif_size(ionic);
 	if (err) {
 		dev_err(dev, "Cannot size LIF: %d, aborting\n", err);
-		goto err_out_port_reset;
+		goto err_out_pci;
 	}
 
 	err = ionic_lif_alloc(ionic);
@@ -354,17 +375,9 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ionic->lif = NULL;
 err_out_free_irqs:
 	ionic_bus_free_irq_vectors(ionic);
-err_out_port_reset:
-	ionic_port_reset(ionic);
-err_out_reset:
-	ionic_reset(ionic);
-err_out_teardown:
-	ionic_dev_teardown(ionic);
-err_out_clear_pci:
+err_out_pci:
 	ionic_clear_pci(ionic);
-err_out_debugfs_del_dev:
-	ionic_debugfs_del_dev(ionic);
-err_out_clear_drvdata:
+err_out:
 	mutex_destroy(&ionic->dev_cmd_lock);
 	ionic_devlink_free(ionic);
 
-- 
2.17.1


