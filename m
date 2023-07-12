Return-Path: <netdev+bounces-16990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33D574FC10
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04441C20E25
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A819190;
	Wed, 12 Jul 2023 00:20:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5D7F9
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:20:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9BFFB
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoX0QHbBwSP/tUY4oNOJxxiUe1Zzpq1NmcLM82iMeuRumXYBUNpbGWUZoqw5pwT8zGYgOv7TZojhns1d+q/TYKTe6DcNn/6UZ66Nqnv287AITYdAg6HSkQO5YZyl4ZNX3otEYVjL1WAQqGWYzhYP+6uf5+UsIYFEJHwdFF6zIB0Wz/lSi4GGzPtliMsWoOTofn7FyM3XpamNC9yrY4R07PYkOkl84Wp+3OJfqKQT1QIoxKUA5qk+73fswhNjeR+aziYixoR6Eh0EMqDv5hcaHiWxb/AdusXLeL52V6jp38ATQ4byv6msj0P+NwXpRVHPxN+vhzXGgr/8bbGqUu3ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnyeEAsZ+PXRzIeRfU9AXImqgcQaAMhVyW6nhLZtEpo=;
 b=mnWL90SVL19f30EnWcvIJJZlULWQ0n7KZOoWu8KwQcY6yzdnJtIfmfZxID4JJAfkfOhWtXwszIiEv2dB6txA3hgX3tVO7J1KCvB/uEd4UADBcSptSiJ+LxiXzyCI4iGQ3IdIpJ0caXkI/+QWdKVOV6LQ9ATWAFj7SUkwnuozniIbqNJSK8Q9pN/t/wPKOzAfeTpk5FnShlWPa8IN7AhC08ZlTlmenrmVQHBrDjPxfs1Mmbrzz2MwGR6fM+aSxZXfQMToaNAcQnSmTkOxWJVYdgoFSPsTh+Z8nNkABSGTKMzL8LEP0J3JsCBi2RHRw94PquA2j80UDMYM1AtQFl/RpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnyeEAsZ+PXRzIeRfU9AXImqgcQaAMhVyW6nhLZtEpo=;
 b=W7RCIvM1UtDugtLCem/sjK0SEhOtv8erMUkVSHv57dSlpSIfA+yck6cNhUYjJsYQ9xEhnTWJu3s5c8LPW4tN6x0jtqe713XlTiX6AxUIMNybfjM2svGdzKrm8R+vBJvXZHSUev7Mu58XaWnG3olkANoTYp0XNc5DvxmV51XDQb0=
Received: from BN1PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:e1::33)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Wed, 12 Jul
 2023 00:20:48 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::6e) by BN1PR12CA0028.outlook.office365.com
 (2603:10b6:408:e1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 00:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 00:20:48 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 19:20:47 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 3/5] ionic: extract common bits from ionic_probe
Date: Tue, 11 Jul 2023 17:20:23 -0700
Message-ID: <20230712002025.24444-4-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 910c193d-3629-4990-3063-08db826dd7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8AKH98wmKoXI6ZTSv0fcFIx9+g/0+H4JYq9tVRXFfZfk534AnkONw/mBz/I7ysPzgQz9u2RDCxR31DQJKXh4kfvOQ8FsrkJD8h9X8FMOIlw8uRrbQMOp/8cRBkhORnbnaaBf5EwZwQsqqiCU5qevXtG+6KJN8UohvUeqWUw3vwXzplIx/3bVCwiPCKS71xBpT4U8hoen4dQZtEyqHVeY265e9Vhk4LPr01d664zQ9IqL+WzSgRbYwkfL9YQWegG9bnrtDYcK4dnMKi5ixwPi0uhx8rhFx11JBi8ahKHZrVZIRMV4BWNkr/dFy9g+jzWl0VoFRrLyI+Jj3+gaEYqyofLBLDD65veFLN+6Zn4pLl4PEz87mGzXsDDvjknmZSDwTKD+uD5SirzrOQozpJghmz53G76ev9MyzpDLlCZZVBmWIkpcg68EcqWxkq3P5oq93KCuwqImhgHEK1z5HwEIniKrZYWXvcjTohVwRuuhnM46QqebNiZ6zZXj5ml6IX9DrkdCEDBKEh2aipDbNPmJPDRvs6wnmcxvTtbohjBlvvaY8tYSBDfA1nK+GTB10wDX3o5cNRZhPFJFW8gMTAL69r4XpcEjdT74lq9bHuxaM6uHB0hF3lExeFtASBoVEbF4/vQ84SaJ8WqlVZ6GBnZuNrtF30KsbLbav/caWA9dqcFC3RxBLUvQDYDBzlRgwc0X2569IgFwlUe141xZnL+HurxNf2XDS6PO+qZ2WBuRr1taDjJM2u7lK2/P/ue9qXdUStjcrfURWFhxD05sWZ4ziA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(47076005)(426003)(336012)(83380400001)(1076003)(26005)(44832011)(186003)(2616005)(8676002)(8936002)(5660300002)(36860700001)(16526019)(316002)(2906002)(41300700001)(40460700003)(40480700001)(81166007)(6666004)(36756003)(82740400003)(356005)(4326008)(54906003)(82310400005)(70586007)(86362001)(70206006)(478600001)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 00:20:48.5462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 910c193d-3629-4990-3063-08db826dd7c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
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


