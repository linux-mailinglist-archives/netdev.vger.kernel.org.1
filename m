Return-Path: <netdev+bounces-19624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BE475B779
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBC4281F7A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CD619BD0;
	Thu, 20 Jul 2023 19:08:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4A19BCD
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 19:08:45 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C0A2128
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkyKSn5gKAReHLj5MdDaiXFhvg/jI/bZ7nKt7FRTIYQcVmiK3kpXiGVvp0TZYsgNfuOP6J5miHClQOBJ34h1kojUY35SMXPtNHHO7StrrgOU9WZhqD2DJyFG7/DcuUJ4Y+EPEUpckTBjxZa44D4kwxwThJAeaG8EMYckONFSaAcRCevduVHh0CF73w/0W8NvKKKmr79ann5YSvv6UAoU4bIsK93dBhJa2ztgMc2h5XVOX7x1WtvOp1gs4ZTjR+lseyITnFBy0UD8/89iis6WZ4I+dp29zoHFlNFDcQzVnThlyoSqq1j9yPDoXl/MKlLtEuw9bAl34lwQx+GS2JxfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wd2epHwBfqBXOAvsv91YuWoVCS95c0F8uy708TH7L8=;
 b=KonZkWB82Lh7IutnMeiYf7v0687S2kGWyOZyDR9dQcWo0oJ5p72gJ7mDSN9JedKxaTo7aeuebjOumg9MPssXO+tUi9Xvi9F9wcyaOTU2HBipiVdzId7lW9K4b2uLWWgTxMK5nYXJNZoM+YpmIL8M8HASx4gRF21KDpUUidxGWdnSnwmhr+H7nwK8218typwdbNWHWVFDr9TzG2qRRbRtPt1Pt+QGRKQEjQedW3nZabMUZ958m3TE5+jHEdVwMHZojojDRh3YOLP7C0NmEAopkafNoSK6cGCIigRdgBm3Wvnb7Xcy1jVmvnwfuuP0LuH3OMyLDKMTR2kB3Lx3xydzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wd2epHwBfqBXOAvsv91YuWoVCS95c0F8uy708TH7L8=;
 b=PPaeusD/dRS3u+KA2rZfNr8L8J/LJDEGFgSafEcjTbxrrtRq+1U3zHMbw8GhLGgm6Bn2h0ZuvKZXqZDyfKDtUo5pEVSF3TpbnNewToqpxd0US3Wt20THB7OTT3u2SlterxN4UuxgyKSQEpLaHuczX7VLSD8qJHEOJXR/F/9V7zY=
Received: from DS7PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:3b8::26)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 19:08:38 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::2b) by DS7PR03CA0021.outlook.office365.com
 (2603:10b6:5:3b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 20 Jul 2023 19:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Thu, 20 Jul 2023 19:08:38 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 14:08:36 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<simon.horman@corigine.com>, <idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v4 net-next 1/4] ionic: extract common bits from ionic_remove
Date: Thu, 20 Jul 2023 12:08:13 -0700
Message-ID: <20230720190816.15577-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: ede97630-c8b8-4859-4a0d-08db8954b959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2tcqgbHXeG3llpyR2IdN5vuffShpzI+zMN8RR59tVHuPmEOGiWZGafMxZNnIrusQ1B7SjA+BiJTcyy1tcNkh2QgcoPkF0ep0LT7QvfER9apAPqRKKo9Pc6rebrpnwcR1orh5AvMGiBOsF1ytZ9iwDWCdMeEvoLh2yhyxMy8ZWIhANDiUUaSYZxZWzhf10eIKhwUEGwhM5eb+LkDAVfFNZ47FZiS9k/0xmvQMx8MeGnouyh6MRtEAdJpoAzy+QAH8U/fVFc/vDa2oyYUT95zsu3JI6O/GfTvc8t89AeS/bIqHUULlIvtqWXSeWo43e5cVCNpXun5Zz1caDNz5wT5Vvrqv6x6H1E0A5rYuED2QPcNx8+ylIObE1proeQEXnEADRNYRmrtjrpvyzc5JQdwrSp6uH8OvxkidUbTRXfnp8S9IQeKVVErG1rugCbdm3NofM/yowJV17nhey+ItIpY1AO8ygBC7e7zOxXjRLYhQnm5UIYzQke129uDcq/Qn42oAAfiYylNondbuK9usMMUgIM+EehJwhHqhggUyOrcWaFN5kzB9Uti9dDOk8Tl7j7z0WI/Z8r5j+UkwfgGGLXmTILleZ8AUREJhV6Lo2nf7Sw6xfV3lhqhuds9QDnsTa86AekEj1VgFORWpYmJdg42WtzrIxNJj34TBmsQurZwyqre9ESikYEiDQd3f3OBBH3PJDn2YZEFYM9XaU+ks+JPLGWSYdslgsyfQifxpYwIhvkgeWfEvjRJEw4rmGYk9iOEcJwVa22Kiav5nexUJpaIjrg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(70206006)(110136005)(6666004)(478600001)(54906003)(16526019)(186003)(426003)(36860700001)(86362001)(40460700003)(36756003)(40480700001)(2616005)(83380400001)(70586007)(5660300002)(336012)(82740400003)(47076005)(26005)(356005)(4326008)(2906002)(81166007)(1076003)(316002)(41300700001)(44832011)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:08:38.2170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede97630-c8b8-4859-4a0d-08db8954b959
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
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


