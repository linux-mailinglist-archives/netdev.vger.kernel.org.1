Return-Path: <netdev+bounces-19627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C2C75B78A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3071C214AC
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9D31BE73;
	Thu, 20 Jul 2023 19:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CFF1BE6F
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 19:08:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7BA1BC1
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMSqKBCdcoGPCMWl+/Xplrs0WWg9LiazDf1s/nEPmfNDnnDCwwPiNNgG9bAYWYRyZChekyF7ek5AV1Pdss2/QMFPXsAbPhjtYc4G9VZsqDsKMTxeH2DbiGK0qkl2NhBbQNKB6hNOiPBkTcg9LDVbI2C/QDY9XeAQHTMKANWlRpL1yzoLT+xn1yP7hnU7XhSdDD9MFC2S3J0gvTcKinF6FEk6YMWhKLu8YrxjTYpkdApHzvfbpSCqMGJlPpuxe++Qb0BUVoRrlDt/PLdxAF8O6PQXEuSNKZI2UVIjbg+VV3DRctgkE3r+7rduP7xPLRJx7ZA2DfulHFSdk2DESCjusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etMMNfcLcrUdufIV1PkhmTmjmvo0YKUU3ANWeNFwX0E=;
 b=A9cmkxfdEk06n3XaMXnJGYj2SDxoU8VItbm9J66oL2r0IVu6UJHfYjK4i0UWX6aK9+OJ53DLYjRLmTi+xlacJamR0jkQz9Vr95ijWEKWWXQN3roy4PLP6p8almtYe9Sw3KfkA3wHVXfrMfoi137osZ6+Rx52FxxGp7CcecJMGkz1OGTvrTAOMtIY5amdIccZ8fUfbZ29KrkIi7q+CvqLtwQiJFtuQClwt/CMijnzNkEoKQ3EO9Kr295EmN0l+p2o79QnaDtu2iWCA5NU9ay0f4X3EgEAIx0ME/06wmqpEXY6MMxqyQOVSpRsXEaJO95e8ONb2uxzUP67Ot15Nn+urQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etMMNfcLcrUdufIV1PkhmTmjmvo0YKUU3ANWeNFwX0E=;
 b=GTuS9ip05iAxlDYAWeKUlOHVCTGej6LsxVBqeIR/UCNmwYbsSFK7p2ol3SziHR2m0eWPchGpPfAMlPXdhjzS60oYUQXKqUyQO8wNUeDZUV7HFxuUQx1QVE4xYvfid9kn0EnKsiYLGUKH5GnYqsIG61lY5QRZc6mZWmfuqJ+AaHk=
Received: from DS7PR03CA0028.namprd03.prod.outlook.com (2603:10b6:5:3b8::33)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 19:08:39 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::25) by DS7PR03CA0028.outlook.office365.com
 (2603:10b6:5:3b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Thu, 20 Jul 2023 19:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Thu, 20 Jul 2023 19:08:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 14:08:37 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<simon.horman@corigine.com>, <idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v4 net-next 2/4] ionic: extract common bits from ionic_probe
Date: Thu, 20 Jul 2023 12:08:14 -0700
Message-ID: <20230720190816.15577-3-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 63679935-5636-43b8-404b-08db8954b9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dgFGgwpHA0FUvnFaRTt96znvV++uMgpWb2UWYL3Mr0XpjIBDAjbDqXri8Z11If1U6RZlzfM6kqpLV+DfNDNWFLu1fkYsPXr4gQsLgdOuyF+uTR5BNJgUGoHvymb918lvkpRwkTE2T+8IWmKCREBvhhqBEX2fGoQwxNRtkdH8jZGB2dLO7oqnZrMBPIjx5egdKIWL6gtMBV+xgHiP6NIRok18VQp77YM8e9kOWR7/OPwwoZp5cEA5fj4R3+4y3CIGDIq7f5ytsSAq1Hx7d4+my+dKG2gcBh3pwZBay/oyt+vPdEXRYINhM3+C/izoY/2E4J6jSC6NauOvEBf+DSmgAi147YDqWz4DZ6loU4cGBS8DJTPWMtvgddXv8RvhFvvO2PxmnHAQSo8XxO1Xsd39c8rOIVLQCzPr4JxdYQi5V56iRn09I2z8mPEeYhFccmH92hvt7PJqYFqdjw3gu1dvVIvfyqfQJTlPYFOpVB9hBdXGLwSLT1zoxvXkn9TbaptW786HMMrQdic3wD5J5Wj2EghqE+XzyJjRt/tnKZ3OWD81YZVwPJBp0fr1wHMzraB2GrmLbwFDOGSWNDxkn/uqhS3LJClx9Uz00gS1x3LQ9FSEVAOSJ3tUBLhf/KAyMRhF/FoKj9jUQIrGAWUdgRBD3q0NClH2cYDMrQ0/i7rLL4zo23cCEiWwP7JHZFx3PlIkEahM1Uld4dNMHKjBfnZ29XQDXR6OFqiyT2vmD5WL3pGryCLKsKEANJUGlRCOEaOirXc4slP0Ng8rU6j+RljKxw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(6666004)(478600001)(54906003)(110136005)(36756003)(83380400001)(426003)(36860700001)(2616005)(40460700003)(40480700001)(86362001)(2906002)(82740400003)(26005)(1076003)(336012)(47076005)(186003)(356005)(16526019)(81166007)(8676002)(5660300002)(70586007)(316002)(44832011)(4326008)(8936002)(70206006)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:08:39.2326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63679935-5636-43b8-404b-08db8954b9f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pull out some chunks of code from ionic_probe() that will
be common in rebuild paths.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../ethernet/pensando/ionic/ionic_bus_pci.c   | 84 +++++++++++--------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 2bc3cab3967d..bcce613449c2 100644
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
+	}
+
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
 	}
 
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
@@ -354,17 +375,10 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ionic->lif = NULL;
 err_out_free_irqs:
 	ionic_bus_free_irq_vectors(ionic);
-err_out_port_reset:
-	ionic_port_reset(ionic);
-err_out_reset:
-	ionic_reset(ionic);
-err_out_teardown:
+err_out_pci:
 	ionic_dev_teardown(ionic);
-err_out_clear_pci:
 	ionic_clear_pci(ionic);
-err_out_debugfs_del_dev:
-	ionic_debugfs_del_dev(ionic);
-err_out_clear_drvdata:
+err_out:
 	mutex_destroy(&ionic->dev_cmd_lock);
 	ionic_devlink_free(ionic);
 
-- 
2.17.1


