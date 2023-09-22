Return-Path: <netdev+bounces-35890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B7C7AB7C7
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 19:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 330972827E2
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E1A4369B;
	Fri, 22 Sep 2023 17:36:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3955E436BC
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 17:36:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01932BB
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 10:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeAi9UwZ/RPdUs/JWALsi6EPD4Xb2B3X1KqNd9LBDB096o6pDYXXf6fo64emAcx9z5guFLMnzXI687rJCyRefPoaqCnfghV1mrx487yuhQW6/MSoCCPRbhHrDMoFV5hrWluZsC7GU8ZQ7Cx1gNSjvu3U3ChvfUrxIgfnqrNA6PwamR/rohrQA8l5gdRqP0HDrAGnMswMajjAv9vJIii4uJ84wN5auYRlZErJ/LqkEmY1lriDqaNIoIbQbAkyOAJutEXGo87iacTv0sGxPLyo7akkYHLHH6E9vXwNBn3RznQ0XJE9RZmIHLpw5Eb8rQiuP4msRQB9nQG+tkCgOLE4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KuBG0U57bFsw1LscDqWRGJSctwVGzm3KbiudP6gOlM=;
 b=PA5th01J3WWziWmsJdq9bXuYVA/crlJNKClN87ARBFopFyyegCk9mWMmMgOnbjBAmWBn6SBSZYbAHWV4VQKG8WYjMXt3NnQv4nHifgZ7wVperTt+vC/oxIeHVzlzj0ipiSLu4oECwDyIMVLVs5rBoPApRaN3EzKXKQx9MFWx9TifRae361PRgutV0Z00LV4m3V+DGN5K5LMoDhi+Ko01QAc3uV8AXsCDuh5JDw+ep+9KFrUYGtP1yH0qzBieDxft27PQLpVZOTFIL/v61OS6lfUhrM5RJO0707S2QnGNHRdzUcUsqHJ8YmtwjAls1R0K3jqFrHNz1b9vHCUbFeYX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KuBG0U57bFsw1LscDqWRGJSctwVGzm3KbiudP6gOlM=;
 b=gAgRhTTuSzTeIpKBhgjm56ab4uJVo0KB8lSvjbjk/nEAy7SDza/XPlA+2E6WaZJsrjV0hel4ZjW4K+LyX9rUBFPG6uI9tb3cXDUyRMXsNRkEEwDxR/ZzbwDjDNIuwbekYkQbQh9oSsWAT4HA9t8i9VA377qz/OjoZw4Mz4ZXEeaZdWofOfIEQRTc/c8wfLJRffbKVtOZe43utNy/9SEV2m2rwp9ZamKDLihYP+NdeW+Mt+10N7eXBgkSaSpS51uLhWT0KEGPpaeiBmGtAcCEGr/SAwxGjf6XBTfndDwDrf/j2HdfsJsje1MALynrQO5SPjAiB6ohT56By5QVzL1yMA==
Received: from MN2PR17CA0027.namprd17.prod.outlook.com (2603:10b6:208:15e::40)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 22 Sep
 2023 17:36:47 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::8a) by MN2PR17CA0027.outlook.office365.com
 (2603:10b6:208:15e::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 17:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 17:36:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 10:36:36 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 22 Sep 2023 10:36:36 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Fri, 22 Sep 2023 10:36:35 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <olteanv@gmail.com>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<davthompson@nvidia.com>
Subject: [PATCH v3 3/3] mlxbf_gige: Enable the GigE port in mlxbf_gige_open
Date: Fri, 22 Sep 2023 13:36:26 -0400
Message-ID: <20230922173626.23790-4-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230922173626.23790-1-asmaa@nvidia.com>
References: <20230922173626.23790-1-asmaa@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: e78f8e46-9d0c-4749-079d-08dbbb927f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AsVFGYpTJPpB45wUOnUAmULoGbnOPpzwCaJ7BLpEBihOFU5qmkGis47FCqkPJS4RWdfJVWF0oIQPO9OgApiXzlcxsuXGQ7a76f6zD8jhO6yMO060k+olMuqWPVRUSBw2EZau1n+Cq9gvOAJbEwvesK8Jplx2sJVPwnvE75hhYHo4JHXxj784nX0mt0kMVulyiNbMxydyAlLnmOHc1f8J5O7HOfIGxbIGi2syFChID7iqHxsNGKCBfVEkziR+4WjHyapv/5yq0u5xyhQupd0KKpv/NQZXHjyR3pL4ZiL5deQsQOYQLLYdFsg5aaT9skrqVlVrM/tEuuKP9ZDzOoVmjKv65vGZPpCz+TQVrcVA//FE12+lnMBc7KmhgTbwHhloaaJJPsiZECElqfZb0vuoW6BlVKSNLoyJ+DdORv5WqfPTe5woEazrDqIfMC/DCiq000cJz3nv3/h+3gdqFcCMu58U/JMV2ZjkbTiN8qsVv7fIAC3ipmwHMKHJdbiCHJJCU7xJC1PV9OIxKpvAhwc2Y94mKdJliKuU3S2kphIxZmkRHYX48mlLBGo0/KJE31kXU2cCs5Bj7eNp22zEiTypqEhMkGCV84okrMsma1GtgkvVSgGi9bSWqDP5TpplnJyJFiqk1uBFk8glEV243fikCP9wYHObnrBBX0ITervKcoUWRSV0shYANU/QUZ1zHYntm3wpzmo9oKVRGeixKEXxA4oFMIxJe7S/A5xQzzkxDkdGaNJzHmnfmcMAfkJuxVj5kvd+EQZOX2FX7pqP+ecuhQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(1800799009)(186009)(451199024)(230921699003)(82310400011)(46966006)(36840700001)(40470700004)(83380400001)(82740400003)(36756003)(356005)(47076005)(86362001)(40460700003)(5660300002)(41300700001)(478600001)(7636003)(7696005)(6666004)(8676002)(40480700001)(4326008)(110136005)(70206006)(8936002)(2906002)(54906003)(1076003)(70586007)(107886003)(2616005)(36860700001)(316002)(336012)(26005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:36:47.6793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e78f8e46-9d0c-4749-079d-08dbbb927f53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

At the moment, the GigE port is enabled in the mlxbf_gige_probe
function. If the mlxbf_gige_open is not executed, this could cause
pause frames to increase in the case where there is high backgroud
traffic. This results in clogging the port.
So move enabling the OOB port to mlxbf_gige_open.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
v2->v3:
- No changes
v1->v2:
- Fix typo: "base" to "priv->base"

 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index fd4fac1ca26c..e74946b802a9 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -130,9 +130,15 @@ static int mlxbf_gige_open(struct net_device *netdev)
 {
 	struct mlxbf_gige *priv = netdev_priv(netdev);
 	struct phy_device *phydev = netdev->phydev;
+	u64 control;
 	u64 int_en;
 	int err;
 
+	/* Perform general init of GigE block */
+	control = readq(priv->base + MLXBF_GIGE_CONTROL);
+	control |= MLXBF_GIGE_CONTROL_PORT_EN;
+	writeq(control, priv->base + MLXBF_GIGE_CONTROL);
+
 	err = mlxbf_gige_request_irqs(priv);
 	if (err)
 		return err;
@@ -365,7 +371,6 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	void __iomem *plu_base;
 	void __iomem *base;
 	int addr, phy_irq;
-	u64 control;
 	int err;
 
 	base = devm_platform_ioremap_resource(pdev, MLXBF_GIGE_RES_MAC);
@@ -380,11 +385,6 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	if (IS_ERR(plu_base))
 		return PTR_ERR(plu_base);
 
-	/* Perform general init of GigE block */
-	control = readq(base + MLXBF_GIGE_CONTROL);
-	control |= MLXBF_GIGE_CONTROL_PORT_EN;
-	writeq(control, base + MLXBF_GIGE_CONTROL);
-
 	netdev = devm_alloc_etherdev(&pdev->dev, sizeof(*priv));
 	if (!netdev)
 		return -ENOMEM;
-- 
2.30.1


