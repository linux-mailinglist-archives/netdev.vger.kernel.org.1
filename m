Return-Path: <netdev+bounces-19859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AA775C9AF
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2A7281F9F
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278091EA80;
	Fri, 21 Jul 2023 14:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C7D1DDDB
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:20:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::624])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364E92D58
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idxVcEqgJTT+PAP3a3qLYSvECFrg/W2mmQxUl+bVnIOsn824WMYegM8ut94xnsTS4LCzN2T7pPjoyqNrcZNF6UhGoihbBph/n4zjvuD51AkSYb7iD0eael65VoU7sFQqfL/1k5r+tRq6XtMhYzf6WzA1Mf7Td1ag8EKHzZMnSb11dLe7u5XFcW+cUZ/ZnSdiExthVDVT7Fe8Iq0fs8CPNtQfqjgvMwAAnSGn5IhrxXBTd1V9jaHaKOL3a7Ld185VWjnxkeUjc1zIoghK8PkWCB9Gw+u8TTs+tCkhNM+abaVtv/k4yAw3oKzbZUzCm1ho2/67OzvofEXNW5EcYY4eVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lgj24xseSDhqD74g9EwaPYnWNr4J9IWDTx7O6tu1it8=;
 b=j6JnDpyv5bDbdZK+rxWLiBYD9PuLnrONSbpD2feHvHSAkqp/SqdaAbYKZOluZ9f7ZeT+UrBfqqUc9x5x8VJLPoGapxyuwZ0EMf8+8jFtPKCsldY5RBiaFWgJo5BsJRIjsb09aF0MYMsSDgjeWX7WwsqIvOZS0Mnp/BVcmFLV0uneZ+z5se0ckBJlc1P+YZtX3xKP8IaV9CwvXTRmHfPEYFmSKY826jbb3TtB/z0XdqYzHfCZknJn8l5o3LJD25/EA2DZ14kXllXa80+Tqv1P+u0NuCqOGp9DUHzy1erDhpoj706AnFUaiORHKlljQTTLVJliconTXYFggn49M6Hgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgj24xseSDhqD74g9EwaPYnWNr4J9IWDTx7O6tu1it8=;
 b=ebO3vl++ukwHUVMK3XpUw3l4oNEopwqa2MibMJpnTzYdnvKLzlhuHFYPutX+cWf/BF1ACL4e/QTLvsn8Op/T85Bs8h0LvBVD59+BY7cLFecpwsvgrCCUEpBnmG1KoHk/Yl7x/oQUEL9lIfH/Dw3WrJcjWUKibveCbZJRMJyfgj1QuGEpbAzln103Y+VO35aMPnNLYoOmllUjY7iFPLyREj66XRmXl5/oimaJAEB3HPyY+jqQufD8GvvWyLl2dzzmnDGx8S8C8xwdsoW7dYzcbSdkXuj70Ieq9ztqBrehdijV2oMkaVddIRbbM1NmK9vYU4KlW2b4nb/YReTyoDPQnA==
Received: from MW4PR03CA0337.namprd03.prod.outlook.com (2603:10b6:303:dc::12)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 14:20:06 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::a6) by MW4PR03CA0337.outlook.office365.com
 (2603:10b6:303:dc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Fri, 21 Jul 2023 14:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.43 via Frontend Transport; Fri, 21 Jul 2023 14:20:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 21 Jul 2023
 07:20:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 21 Jul
 2023 07:19:59 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Fri, 21 Jul
 2023 07:19:58 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<sridhar.samudrala@intel.com>, <maciej.fijalkowski@intel.com>,
	<olteanv@gmail.com>, <davthompson@nvidia.com>
Subject: [PATCH net v4 1/1] mlxbf_gige: Fix kernel panic at shutdown
Date: Fri, 21 Jul 2023 10:19:56 -0400
Message-ID: <20230721141956.29842-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 484b284c-61f6-4a28-2c3c-08db89f594c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bt098SRrK9twK0gFalpFr8SnUsmrUdsGIP3/V2DkcePzbZF2gHhdkjvwiemUvgPrQ8LexMWGKZjzCMy9nxVmtp/D93KuajUipvG2QR/nfr2jFyPp/XK8CtroudYRSpsb8c/i4nzM5z4q3uHOpmmz+vL2yF5BstElIwBWra3phnGtVkDcT5bQBj3ZXspLB3rBVfWIoq+a6mRwHngAvvNcrr5otUsKzAkQ6y4KwMbAeO+N4xNwsjjGK8Ywsp9h83PusjcDRqRVld4FlGEPs8A+IzN+b/wKrJ1Y5skrHDFZWU92J4PXaTnheIYD5ciMLHjs1/JNuV6keoSnO7nsKcy2XXbVPvvi3NvhEqJXRtVd+NZbaYOeGJujA1STFVsE6D7ar7m5rK2iCJmoLHaedzgRQNocLemZcFwyWUqWF3ak94ugH+NBVKzyk7GUhCPgjaxHT6JI97kNhNrOShOBRo9KNl3Sp1d3ZmGBINtDWrC+lFxFwd2HVmLS9Onl+cXXLyxUQ9Ko+/3jmWKdoKFro6y3bETmrcrbIvstsjMQuZkMNlZYm460noJ7FnsuOWpzP74H1edA/3csqjPcA/cEste0Djf8I++8W85CG3IdiotagO6Jtzii1PfYQewEA42btvSXZkslqLFOAozTsfpVknr9G6UPXPIbBGckjfkJPFi9JxLnLcSMDH6J47xmU/yrVvvHk3hlXRiGqVJUdgB7eqm/tefsXFubE6Jgw5mU+6LbN4e69nuPs1Zq9JXlm4lYGs7v
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(36756003)(107886003)(54906003)(356005)(478600001)(110136005)(7696005)(40480700001)(336012)(1076003)(26005)(186003)(86362001)(40460700003)(7636003)(70206006)(316002)(4326008)(8936002)(70586007)(82740400003)(8676002)(5660300002)(2616005)(47076005)(426003)(2906002)(41300700001)(83380400001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 14:20:05.8062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484b284c-61f6-4a28-2c3c-08db89f594c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is a race condition happening during shutdown due to pending
napi transactions. Since mlxbf_gige_poll is still running, it tries
to access a NULL pointer and as a result causes a kernel panic.
To fix this during shutdown, invoke mlxbf_gige_remove to disable and
dequeue napi.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
v3-v4:
 - replace .remove with .remove_new to be able to return a void to
   .shutdown as well.
v2-v3:
 - remove mlxbf_gige_shutdown() since it is redundant with mlxbf_gige_remove().
v1->v2:
 - fixed the tag from net-next to net
 - check that the "priv" pointer is not NULL in mlxbf_gige_remove()

 .../mellanox/mlxbf_gige/mlxbf_gige_main.c     | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 694de9513b9f..5e677bd32956 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -471,24 +471,19 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mlxbf_gige_remove(struct platform_device *pdev)
+static void mlxbf_gige_remove(struct platform_device *pdev)
 {
 	struct mlxbf_gige *priv = platform_get_drvdata(pdev);
 
+	if (!priv)
+		return;
+
 	unregister_netdev(priv->netdev);
 	phy_disconnect(priv->netdev->phydev);
 	mlxbf_gige_mdio_remove(priv);
 	platform_set_drvdata(pdev, NULL);
 
-	return 0;
-}
-
-static void mlxbf_gige_shutdown(struct platform_device *pdev)
-{
-	struct mlxbf_gige *priv = platform_get_drvdata(pdev);
-
-	writeq(0, priv->base + MLXBF_GIGE_INT_EN);
-	mlxbf_gige_clean_port(priv);
+	return;
 }
 
 static const struct acpi_device_id __maybe_unused mlxbf_gige_acpi_match[] = {
@@ -499,8 +494,8 @@ MODULE_DEVICE_TABLE(acpi, mlxbf_gige_acpi_match);
 
 static struct platform_driver mlxbf_gige_driver = {
 	.probe = mlxbf_gige_probe,
-	.remove = mlxbf_gige_remove,
-	.shutdown = mlxbf_gige_shutdown,
+	.remove_new = mlxbf_gige_remove,
+	.shutdown = mlxbf_gige_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.acpi_match_table = ACPI_PTR(mlxbf_gige_acpi_match),
-- 
2.30.1


