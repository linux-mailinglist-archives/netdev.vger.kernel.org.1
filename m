Return-Path: <netdev+bounces-17680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC7A752AF0
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF26281F02
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13451F934;
	Thu, 13 Jul 2023 19:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B71DDEE
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:30:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9656C2D77
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odgoQvNouQ+1Yy75iRt8qW/ZRmM8hQpiPOHOQv5Gm2sHzFb6bkr+xBuRnXF7xVFNmDsc8o/k8s62uKo33uakhhXJTgG1/VpHVm0ek3NwUJrfjxuK7NBtYu/GspiG47kuXYZ56F8p3cIGAoYzX1WMiVIMcJZrXts5eIFLjZI4bIIln9ldTOMJLKva4oc72FOMLxvlbZ3329HCS19PvW2gXLb5wDauzJpl9VA0BUV7LhnLivoItGVukZHGn2jtBTXlhKtR6nH0XfOZJ5g8vczjF2uenpBlOaYpDBOPghoD0CLY8gBijmDA/+LR+C1m9aEN3lFUxzq/I8vaiHc8g6YuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wd2epHwBfqBXOAvsv91YuWoVCS95c0F8uy708TH7L8=;
 b=g9nuXYk99uZNeYvIL8Z5/CgtV3gHX+ULMFWfkwglVcEOalnJa+cdhJTWTWO3zCk4n5GT05VdU8pmS0LsI6b9L8NW5I5LA6kKgTeDbK2oAcSolW9SC4x5rfE+mLyO6gurPZUFP4POi7j9GGs+P0DoOhUPE3YYcLD+M1nO0qmWanzB/sGx3jlIjAPoc0VBKgwrsniMUer6FMuN4qnaCAearFv5Irfw4lWs6Bp2TSJ2PQMwqiLE1hSf7BRpMGFax+wBKDv1T2eOt34n5dN2+IoPMeQ5UzH+ABzmU+3x91PNUxI8LGGWvWpjir7W5vn7XXMkXmf5HO1N2tl/fqMAxnlKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wd2epHwBfqBXOAvsv91YuWoVCS95c0F8uy708TH7L8=;
 b=LLNxRmYnrhRzns1/E7NIQZWf2viW9B3CGfDYNgPTYCF7tLItb6lA7JrjNMyPdt5LNVIFt2IIaQOhz4f0EUhrTegkY+sJLsy185yNKtWqt75MwGQHaDzvxC9jJCcNVoMMMMei4MuEpc6u1lzqAJVCni0YQEhTfoP3exYOwGCWUJ8=
Received: from BN9P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::6)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 19:30:00 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::56) by BN9P223CA0001.outlook.office365.com
 (2603:10b6:408:10b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 19:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.26 via Frontend Transport; Thu, 13 Jul 2023 19:29:59 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 14:29:57 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 2/5] ionic: extract common bits from ionic_remove
Date: Thu, 13 Jul 2023 12:29:33 -0700
Message-ID: <20230713192936.45152-3-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 7010d8e7-7433-4188-ce3e-08db83d78c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0Hv83ltFibN00dQNSVYxypW3oUPt3O5yr9El+7dKQ1QSUURjBmBLOqrRxPOy0bEYqMg6M74mjBqZNeY6kVoe6jCktFYcY7uXm1USr0AJXMPFPeK/uqWDKyh97OngQ6KERSeCA+WY0j2isnw5MKSVwwUqJLbyqLeSiNbOomZdFrxgRd/AiSme6GQKAEhPk/2BNkEo9dsNq/1T6FC8D/qhFA9JQTF/93jFa9X69UmpzZZwokcK69BuQ7XkpzCiyHDGnNMd1JCet06G52AXp3KDKwZELCM+ZLj8udOeaZRYzHUfjZHA7y7DCk7Q7y+b7JCLMXC9s1AzeJOsIudU/dVQmY6Q0Q0AKBIZwareS+10hoLJG423jyrXINU81lZu6aavPn9p5y8qNbEvyzzGoPohJWa2FSKBzaufL+6ZytbGu8fX4a5KaDKTThCAxZO3jFbSsnvcOS8K6q9zXHvnrWXsE6kMx4vvdj+B5zK98OiIH8dco61LCCGU+8HgXvWJckmN1SxuGz5CG+0s8QdPNx3l6/mekAytwDxAunXvUGP6C1RBTgNTPY1vhxjF1lNXcaWEh438DK7RStkBtkfATd6CqNTkpEI2yQnschRkr+hvkN1qwgZxMTr9WxZSCELuqPg3n4u0QyfVyE/9lF6x6JV05+sPSzcf/aB3Ivo/HDB/XJO68DtuUYZowiaGumw0MZj4hTtCKZtL5nfnDl2xyDLGtCRrDhxpM2cBEhCwlCRBZj1Jc/cOJl//Id2mXPrmUhAZNl3+NMJS1YwjTI8aihP8ug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(6666004)(83380400001)(36756003)(47076005)(26005)(2616005)(186003)(1076003)(16526019)(426003)(40460700003)(336012)(40480700001)(36860700001)(316002)(82310400005)(2906002)(41300700001)(356005)(82740400003)(81166007)(4326008)(70206006)(70586007)(86362001)(44832011)(8936002)(5660300002)(8676002)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 19:29:59.8884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7010d8e7-7433-4188-ce3e-08db83d78c5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pull out a chunk of code from ionic_remove() that will
be common in teardown paths.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../ethernet/pensando/ionic/ionic_bus_pci.c   | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index ab7d217b98b3..2bc3cab3967d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -213,6 +213,13 @@ static int ionic_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	return ret;
 }
 
+static void ionic_clear_pci(struct ionic *ionic)
+{
+	ionic_unmap_bars(ionic);
+	pci_release_regions(ionic->pdev);
+	pci_disable_device(ionic->pdev);
+}
+
 static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct device *dev = &pdev->dev;
@@ -249,20 +256,20 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = pci_request_regions(pdev, IONIC_DRV_NAME);
 	if (err) {
 		dev_err(dev, "Cannot request PCI regions: %d, aborting\n", err);
-		goto err_out_pci_disable_device;
+		goto err_out_clear_pci;
 	}
 
 	pcie_print_link_status(pdev);
 
 	err = ionic_map_bars(ionic);
 	if (err)
-		goto err_out_pci_release_regions;
+		goto err_out_clear_pci;
 
 	/* Configure the device */
 	err = ionic_setup(ionic);
 	if (err) {
 		dev_err(dev, "Cannot setup device: %d, aborting\n", err);
-		goto err_out_unmap_bars;
+		goto err_out_clear_pci;
 	}
 	pci_set_master(pdev);
 
@@ -353,12 +360,8 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ionic_reset(ionic);
 err_out_teardown:
 	ionic_dev_teardown(ionic);
-err_out_unmap_bars:
-	ionic_unmap_bars(ionic);
-err_out_pci_release_regions:
-	pci_release_regions(pdev);
-err_out_pci_disable_device:
-	pci_disable_device(pdev);
+err_out_clear_pci:
+	ionic_clear_pci(ionic);
 err_out_debugfs_del_dev:
 	ionic_debugfs_del_dev(ionic);
 err_out_clear_drvdata:
@@ -386,9 +389,7 @@ static void ionic_remove(struct pci_dev *pdev)
 	ionic_port_reset(ionic);
 	ionic_reset(ionic);
 	ionic_dev_teardown(ionic);
-	ionic_unmap_bars(ionic);
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
+	ionic_clear_pci(ionic);
 	ionic_debugfs_del_dev(ionic);
 	mutex_destroy(&ionic->dev_cmd_lock);
 	ionic_devlink_free(ionic);
-- 
2.17.1


