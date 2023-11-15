Return-Path: <netdev+bounces-47982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA367EC21F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A9F1C20B73
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B137F18AEF;
	Wed, 15 Nov 2023 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B2YkA2zg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDACF1B271
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:20:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9E711D
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:20:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdIVDZsxqZi6KqFYRhc3murv/wIcBDAsg3h7L5SQ5Q841tVnrhIJWs8vv5RRXhBTOruHNjephniBL2em5R1nSnPZ67IPFHK6/+/lMta2I3YBhI4/pyGEDVs90leFnh9YrztHD7uFnH6OqzRRzMPHIrmEIvRn6TOEXXgQVyj8Mt50ILXoJFApu8+yVoP0kRPNS4e7J+lfG/LJ6d6qeYUsfxV2QkH6AGfKDHsdeVLqgl/erFgR8gfSuDlUmTgg9NojPrAhQFSBOKqL6ROhqFQZalzySe8ObJ0/g//XB2KQqU3zeXt1hmgaAM6p7KO1ZbPTBGrh2subOuev/BvBzplOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjSUijVixc1BrvwImTkt7FoIu8fz0pfyFbjm1UeU8hY=;
 b=EZB9ygQY2Us/7jntQRdDuqeRdY4A0PgupzOndNJLh7QN57RPEgN9mi/FX3KrzpgPqRPROR83qXkLXxunYm1ucTwebM4oA4TsiNY83UFE7r00UATgTaZ18LJ6ewgTSa6+8sMQtwXC5LuW5T4z8Ant7yGwPVd3EIbKG2+O/4KvE4QsOqJJemx1g4UesJqwzi9BShlXxZwiXoj6IyG8tT7B/0qBVulB+bqJm2eIUDOFtDWGQIO2g/ckOHlty7sE9B6NXFlfsKAKi4giKfgTwABShrmmVB5DK4lfbpHlQQrGYkFfJazbO3MHyFnQ+LoDCUVKO4LLk1BSDKcusYJvnN+iVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjSUijVixc1BrvwImTkt7FoIu8fz0pfyFbjm1UeU8hY=;
 b=B2YkA2zgvofrNzFSroTviPiDpHeuTSV/AcxidauYrM1WGhb7UtmJBC/QTYUJ5kR2UQppfNKM8cAfcHHTnVm9f3llCK3ycPxmOY8UY9j9d1QPXJlgxEbU+znCzqikU/u8RdShawH2E6/vBzMEKlWep5PPk1jmIGXlaRDnTpgI6/ilo8NNUsGS+08e9ddpHoUmlB61jK2mUkeaN8o+E2U4y+PL7t/FbXJj7Y7w6/jALyY0+qvSAai/VggpzEf9C/EmvMCMHXxbkW59UYqAHBbbd6KZ9VQmdVsh5U1dznz+HP7EX7jU2n1giPESbHuP106+70HlGNbhjWrDgCD27aStBw==
Received: from BL1PR13CA0416.namprd13.prod.outlook.com (2603:10b6:208:2c2::31)
 by CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 12:20:15 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::1f) by BL1PR13CA0416.outlook.office365.com
 (2603:10b6:208:2c2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 12:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:20:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:20:01 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:58 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 13/14] mlxsw: pci: Implement PCI reset handlers
Date: Wed, 15 Nov 2023 13:17:22 +0100
Message-ID: <3bb150e9efd7fbf2ced0a2fb6f3ea321fbcf6046.1700047319.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700047319.git.petrm@nvidia.com>
References: <cover.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CH0PR12MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: e4284965-87fc-4e53-4783-08dbe5d53946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dpgMDDK3XebWXK/cuTbXKdiu1MnNIF78yhImZsijtlgrLNIQdpgleX7sBn/74HDjQa+isnvcSctyatu4GeyDs1PiWJSS/3nguwou0c5xdF1LUY8Ls3gPNNsBTJhPWGLPeX3Dacy8t7gN+kACyL5ld5VdVow9TlxOhfL22VE/74+mMQdMFZEtUVO5zNwdH8vpQK6zOPhQOxyNcmII4/Dg/lmvjNjQxdnRe0AEqdByA+N+6AiVHLffwDu7zuFszMPbNd9g4dv5wJcA9lu44l7U9LsMbTwfYhruNdccqk4kdzRtpfmPNTh8bVYTa/duMgFRK8ioPWQxXryuvBMEeaiHkpDVRz7Aw1VzAlnx9NV77n8Iy4ERg57EyXoDRtiSrgzkJ0CIuvTHDghG1AjmTqy1OyozbOrK3qjbd6FUQQa4BlaH/68MJr+fSx86g1z0AcismrLoIQjsZDGfi3erzhWfuN462lL4qMOat5BXL06+IB+Xyhkt2A8d9pCc/41cD3XiuWWrVBTpo33oTmuii7v1ESW4N6YrY/OG5rKb+6+i3b8TmIVcsjtX92nOqekjaljG+BwNDLy481qMTjPVFonvjqLbSnRuJOuZHJnm1JQdi2qekklUwFc5KgF2DTbTq25xWmnE89+JCKt85faGzBD2TefArL+Jsp6K1IJ7B8eRPZpU1wLXGjZ7uQ+z7lxVkt21bQ24YETVL0LnIMDXe5sC4SzD4a0sFN8ijKfdvIjUyc2xXeLry309qUPshmJIGNuI
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(36860700001)(47076005)(2906002)(356005)(5660300002)(7636003)(86362001)(16526019)(336012)(426003)(82740400003)(107886003)(26005)(2616005)(478600001)(6666004)(36756003)(41300700001)(110136005)(70586007)(70206006)(316002)(8936002)(4326008)(8676002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:20:15.2884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4284965-87fc-4e53-4783-08dbe5d53946
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027

From: Ido Schimmel <idosch@nvidia.com>

Implement reset_prepare() and reset_done() handlers that are invoked by
the PCI core before and after issuing a PCI reset, respectively.

Specifically, implement reset_prepare() by calling
mlxsw_core_bus_device_unregister() and reset_done() by calling
mlxsw_core_bus_device_register(). This is the same implementation as the
reload_{down,up}() devlink operations with the following differences:

1. The devlink instance is unregistered and then registered again after
   the reset.

2. A reset via the device's command interface (using MRSR register) is
   not issued during reset_done() as PCI core already issued a PCI
   reset.

Tested:

 # for i in $(seq 1 10); do echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset; done

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 726ed707e27b..5b1f2483a3cc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -130,6 +130,7 @@ struct mlxsw_pci {
 	const struct pci_device_id *id;
 	enum mlxsw_pci_cqe_v max_cqe_ver; /* Maximal supported CQE version */
 	u8 num_sdq_cqs; /* Number of CQs used for SDQs */
+	bool skip_reset;
 };
 
 static void mlxsw_pci_queue_tasklet_schedule(struct mlxsw_pci_queue *q)
@@ -1527,6 +1528,10 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 		return err;
 	}
 
+	/* PCI core already issued a PCI reset, do not issue another reset. */
+	if (mlxsw_pci->skip_reset)
+		return 0;
+
 	mlxsw_reg_mcam_pack(mcam_pl,
 			    MLXSW_REG_MCAM_FEATURE_GROUP_ENHANCED_FEATURES);
 	err = mlxsw_reg_query(mlxsw_pci->core, MLXSW_REG(mcam), mcam_pl);
@@ -2107,11 +2112,34 @@ static void mlxsw_pci_remove(struct pci_dev *pdev)
 	kfree(mlxsw_pci);
 }
 
+static void mlxsw_pci_reset_prepare(struct pci_dev *pdev)
+{
+	struct mlxsw_pci *mlxsw_pci = pci_get_drvdata(pdev);
+
+	mlxsw_core_bus_device_unregister(mlxsw_pci->core, false);
+}
+
+static void mlxsw_pci_reset_done(struct pci_dev *pdev)
+{
+	struct mlxsw_pci *mlxsw_pci = pci_get_drvdata(pdev);
+
+	mlxsw_pci->skip_reset = true;
+	mlxsw_core_bus_device_register(&mlxsw_pci->bus_info, &mlxsw_pci_bus,
+				       mlxsw_pci, false, NULL, NULL);
+	mlxsw_pci->skip_reset = false;
+}
+
+static const struct pci_error_handlers mlxsw_pci_err_handler = {
+	.reset_prepare = mlxsw_pci_reset_prepare,
+	.reset_done = mlxsw_pci_reset_done,
+};
+
 int mlxsw_pci_driver_register(struct pci_driver *pci_driver)
 {
 	pci_driver->probe = mlxsw_pci_probe;
 	pci_driver->remove = mlxsw_pci_remove;
 	pci_driver->shutdown = mlxsw_pci_remove;
+	pci_driver->err_handler = &mlxsw_pci_err_handler;
 	return pci_register_driver(pci_driver);
 }
 EXPORT_SYMBOL(mlxsw_pci_driver_register);
-- 
2.41.0


