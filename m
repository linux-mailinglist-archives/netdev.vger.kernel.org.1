Return-Path: <netdev+bounces-47979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD4F7EC21C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B111DB2084C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3781A703;
	Wed, 15 Nov 2023 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K+F852Eb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7208918C20
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:20:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3889B
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0BoWxuYzfbKapaB4TIMzLWgvQv8ja+ptDDDlUYIhVVZ1zgR46MDgHkg+Ag2wwSehxFNI4CG0PGciINaE25WgU+jOOunLuQ11ATddsbX6sJbKEkCWLtEMOSW3zfMk6Bf6BVDzJCn/hHqelAR1pgucT9vLtn/JYj3XOGD2b1FNMsznW/4nSf96ra99gsgCh9+GIzUqRi8U9+YZXQqg45W9smB0ykHZdEBDcH8yQcDkDJJjDFHyymCY+iRv+iLx784210j2ujJAJXK8ad1Va06j11aUFFRyur4557mHjT4xz3VMQM4YZkbqkkCobjEFKM0ju4Dy6aA+yUr6r+KPaYbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8XJ8jANFuaNoE1pfD31vx7ZGCTIZ9IWuJGwI7evcMo=;
 b=kcA+UaQvvGS6VmsViUYOikAzj+vxewbKMgvD2dWRGpR8VGTx2WGblMt8jTu4Mv4UrJ3CYPrNJS86a7Y+38ZNK93jKUZ0LawsTpRtf/Xi38CWxzvm1wSsGw99ZrqV3ow0Ih4jEPHVZZ1pXV1jsB/HloYETGOAy6/9PT9nkEu+h9HkLzPmbZCzqcp4tybePaJXB5QgpyykBtbaBRJTZGCmnofMfrS/w4yswld3GthzpSOPx6KeiT8WDFetixWfmoqUYoTNPul5cm1kYneqR1+dgJL9ezt7XonltPfppYrHeNGTw7RlE2HOKl/WC/y9BreuB+HROR9O99veqGRdpUgUxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8XJ8jANFuaNoE1pfD31vx7ZGCTIZ9IWuJGwI7evcMo=;
 b=K+F852EbW/VRM+ZeU+8aWUGblLb+nrRZ7/ahVkhlwlJNvXk5ANv65zDcKmLVn+bQ1KZw0WoCJlWvtmzPOSpdCUjKIGQarpcTW0dp5bqlj0Ph9Gy7IJEguQmgin2fRBEhIgFGVD6Z8kKjScGDvw1sjE/uCg0hQLSmg7BrWGk31hY6weRYQiLJpqhk+qN6xwPu3zFg9bFh+fU40rW0M7Gz4wZ7N4MqEHhBiII0d5iXzkeZE90tTmNXSOLBQutu5Q+vLhY4mOiNBAInL5sB1lfIxWI7Q7DbkpbG7U+a83/azWPCskuZrP6rF3s1bb7lUOzcvMI5BbA8a63PBlVAHGaNSw==
Received: from BL1PR13CA0246.namprd13.prod.outlook.com (2603:10b6:208:2ba::11)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.35; Wed, 15 Nov
 2023 12:20:07 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::23) by BL1PR13CA0246.outlook.office365.com
 (2603:10b6:208:2ba::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19 via Frontend
 Transport; Wed, 15 Nov 2023 12:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:20:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:53 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:50 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 10/14] mlxsw: pci: Rename mlxsw_pci_sw_reset()
Date: Wed, 15 Nov 2023 13:17:19 +0100
Message-ID: <b0b1c4a725714f8f70f114226f6cf114d4537062.1700047319.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b9d4cd-b564-41c9-3a54-08dbe5d53442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	brk3oSKOqNPbbcBEJnml2LKJaXDkDq5qkDZz3aVCbrXVUiycIRBTLHpOAd7CLsYibVqErHLE+H4GY/DQbiGIDVPZq4X8NLYCDQpR4UfWHqEu3PZNoxfDpUdh8MmFR009ZX6E+6MAzrElC6fZUMGcka/czJAcKP85B77nidig69Brs9KVz9IurIKPN6VkbDS0puOP85j32w+SZzfBvRXL6fq1+5GkMey9v680hwxYt9BQDMlSebx+r+WdN1NNAaOAv8vhjvmTRS1d47Mf2czs6VIYFcBw0jde5s3ay5MvbZ6xJsWcGqKPVLv1j21u5bPbTCNmzOpPnQnesK0hrnITW9uVETu95V+rxx4eIzg6BXn+WjgPqnc/45VC6R2/zcFp8Qsn1sqRnAUsKHS2fZW2xdx3dPsp2WzIYaSrBq8jVdTQh5AmoVGiWkDH+tuetpIW2Lma6zC0D8M9iRIhd8LOh+iw/pHDx4mrwf3o/K3Cvz2x5QYDaS1R55LCmu7vWjJic18SmqMh82P8lGgCkBe7jD0Gu2Q7gOI9x9cvmiUeyyAAlKjpMLv6gYZW22llUj2Rp51yQJpL33+weE2oESiWgVmwSxDPrmbvSTceMOSXg1/f3bbynsiUHIFS3EPs6/r61zXKWTOx55U3t6fYypBPEhVqO+Q3UJJQGDmhmet7EcsNi1TPCMpoX6aPvZ1zH2Bk3SZCgA1XF6T3f3o/WDW3JDwzAdNxXcv4KFL0YZoQ+u6r/ijf+ckHs/TGvd1SEDrs
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(40470700004)(46966006)(36840700001)(2906002)(41300700001)(36756003)(36860700001)(356005)(7636003)(40460700003)(86362001)(47076005)(5660300002)(316002)(478600001)(2616005)(70206006)(54906003)(70586007)(110136005)(82740400003)(26005)(16526019)(107886003)(336012)(426003)(83380400001)(40480700001)(6666004)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:20:06.8576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b9d4cd-b564-41c9-3a54-08dbe5d53442
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256

From: Amit Cohen <amcohen@nvidia.com>

In the next patches, mlxsw_pci_sw_reset() will be extended to support
more reset types and will not necessarily issue a software reset. Rename
the function to reflect that.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 7af37f78ed1a..fe0b8a38d44e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1476,8 +1476,8 @@ static int mlxsw_pci_sys_ready_wait(struct mlxsw_pci *mlxsw_pci,
 	return -EBUSY;
 }
 
-static int mlxsw_pci_sw_reset(struct mlxsw_pci *mlxsw_pci,
-			      const struct pci_device_id *id)
+static int
+mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
 	char mrsr_pl[MLXSW_REG_MRSR_LEN];
@@ -1537,9 +1537,9 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 	if (!mbox)
 		return -ENOMEM;
 
-	err = mlxsw_pci_sw_reset(mlxsw_pci, mlxsw_pci->id);
+	err = mlxsw_pci_reset(mlxsw_pci, mlxsw_pci->id);
 	if (err)
-		goto err_sw_reset;
+		goto err_reset;
 
 	err = mlxsw_pci_alloc_irq_vectors(mlxsw_pci);
 	if (err < 0) {
@@ -1672,7 +1672,7 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 err_query_fw:
 	mlxsw_pci_free_irq_vectors(mlxsw_pci);
 err_alloc_irq:
-err_sw_reset:
+err_reset:
 mbox_put:
 	mlxsw_cmd_mbox_free(mbox);
 	return err;
-- 
2.41.0


