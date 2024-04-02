Return-Path: <netdev+bounces-84034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB513895577
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052B01C21779
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD9D8615E;
	Tue,  2 Apr 2024 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r/eCg6SG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A585C7D
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064761; cv=fail; b=h+iMDFDy8LW4nDKqmxeZvVOmc5ZF9ab+xyUpjYTkSh+6QFQCMMEjABjpiGzS1wGXR3tL5RTzHYdeWgvQI2t9jqbU3Q3O/BDcFTPa2+KcFKr7TQi50sddd3qkooxzLLZyTUv6ATa5ZvqIHMQFpar0Na+4iIq/4MVOSR2dbKb0LtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064761; c=relaxed/simple;
	bh=LDGwKc8JdPr6A94zdXr5SghK3Qosxj9lspgnYgIHgn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B45vYpThX6/hvQUJv1HQRdBrqT8ZPXHDFxefXbuJ9IWx7E7IR+sQwyZz/BzFQEH16fLnFycmEi2hXO2G/nPBIycyliUu5QkAbeJdCRg9I2aHV5j0JMWErhuigy6ywFAJpM0YdUDPF7bDbeFoDWKwVhb1MEas8+Y/nm1VVPtGb+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r/eCg6SG; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYUqJa1sY1EnWkoYqAKF9DXUhHK+kPfD9tKkANoav1RqM09z5bgZi7I3RAEebVIVlZ6CVj8YdV3axkIXjncg18nW7oLSUUSOQaoR4p8nNLeCFFp0emNmGFzEJzAzPFWg+KD187vog3rExqhiYuzU+m/b8ymSZUWbS8ZQuZ6j2jlmLbsG6QNIGY8TqNL63/3Q3b5UOyzaF1crpd6n9tgEJcAA72ikoTVvitwSYTS6s9vpaP6FbsSFFqbvmiAGC9Btk/eN/f4kf/j3fp5A7YsQceY1xbjYIRkOvCSj5qsqmXmwHkXdHHO6VS76rVEGsh2Wux2j90PD7tF5sCdwK0hpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvQxTb3r5+YBb2kLFSi4VtRye6DjfD0UC+aNwBOSV7w=;
 b=MvnuV9DGLhhmIk2jMpK9obS67JWYbEA/gEt5fvz/FJpTneV1Li/gP3xVf/nlYx7U060DODlzqiU81uqQM0ed+VSDnNKQn7Z0JXDnAGaFlvcm4WRV3yogDu+Kx59xuE2OvrSuieRSGFY9Gt+UAxll2jpsJsjLtMkHn1KHc/yFnDwPuFHvX0hEUGplZBRhEp1weGZ6GaNwzkNM8cJbE29DXPhcQIKVFrjexbl3eCeYEetrBUYMQGCJEtguBrwv4kDFaDC4tgx31bHgWLLLhELekRQ7jKsH5d3K0Z33WdqrykB45laZI2oXuSJJWsl4tCmc4ygXJDRkYAZmmlm8hqicKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvQxTb3r5+YBb2kLFSi4VtRye6DjfD0UC+aNwBOSV7w=;
 b=r/eCg6SGtcK2ysS/ahLoqN084vaC9a2v+/9Nqa+/vxmUoKErmDdhOcBdC43kFIofp3AOGU5BUiuC9j9nmgCLVBTK9tA+ezpnXz+KR4cstQSGBUuxdGODxphLbRbE+MDleDIA0ZjhkV80ILdFiQsPxiuWW3ZvfZ8rB2LmGABDuysTMOXIMq5Q2KhN6aZLyaJjh+7MtmcMqrDf3WC1MRprzEm41W6qbuQzign3tg8ijbnoOWvVZMyv1gKNyKiQ4MTeo9GuRXsuu2OVnD6Z+IuwnlxqWLEMo8ekpDJEHrKbOiZbunibptjIBquyZUJm5BDcD3o+i8vGZ0i1Z7cSwNsiuw==
Received: from SJ0PR03CA0093.namprd03.prod.outlook.com (2603:10b6:a03:333::8)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:32:35 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::7d) by SJ0PR03CA0093.outlook.office365.com
 (2603:10b6:a03:333::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:32:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:32:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:32:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 2 Apr
 2024 06:32:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Parav Pandit <parav@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 10/11] net/mlx5: Skip pages EQ creation for non-page supplier function
Date: Tue, 2 Apr 2024 16:30:42 +0300
Message-ID: <20240402133043.56322-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402133043.56322-1-tariqt@nvidia.com>
References: <20240402133043.56322-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: da2c087f-c427-46c1-a922-08dc53195aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	crv22lbPU7osbvrExo0mcZPn9cUcC2fQogGnPm2SQLhh01wcpkiabR7k6i+sWqRjy/vOzAm4JLLOGqUfV5XvuddH84ks7DW+cPS7eCpwLixgiKrcSSPwtyZA6/UbuNoc5UzWaz/OuB/YSh6N0m6Qn4QpoG04mQltFBKFCBMNVVnZTn8Pg5TFaqU0NyQcP9QnqSwTsyhWF2IJ64S+soFv+CrHagdDx3wrC3xvw0Zw2y2tvWNwmGKjbUswnW2PZ2IPOyOwuuribg+62nd8P4xbhtqBee6oBDoGuInCmQ71bH7C8VYCNu1ZaDUF3PVysZ/Tl0kbARIGmvJjmjaRoKlzKSRN4+orT/3xcVQGY2VnmKM5WrMRrMGdK0zp7XzrksTNEXgXlUKbZZgM6KxryigNvyIb7uUDfgy/18D7SLZdIA2+/HQ+QzwKJzCZwJlNIPRzltWkgM7utQOv7meG2OShCZZS1pQzFYeBnCMcF9QQoN3wKOrEU2LwB1jxq0g+jRP1dsMTbVK0Ulq9Fwhxhs6ynm7awgVYmP8rYVickjvh/fZqhbl2BY14VL1icAl6f66y3Gb4SKBTp9d3YbASVn5Pk0raG7SNE8a4F42J00q0xk8l8rFLDyy5b+FGolXHPXWH/OS6JeV3Pfqrs1ySX+aRwEn1jqJWJTqxbZJmg3PG8wlx78nyd011+unRnSCjRiGrPrPF1mkTx1RS9/SnlPVoYmuSlVy/1TXzH+XujsH4Py6LBY9Y8XiMzZJ0MXZfpcLV
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:32:34.2523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da2c087f-c427-46c1-a922-08dc53195aef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324

From: Jianbo Liu <jianbol@nvidia.com>

Page events are not issued by device on the function if
page_request_disable is set, so no need to create pages EQ.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 9 ++++++++-
 include/linux/mlx5/mlx5_ifc.h                | 4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 40a6cb052a2d..5693986ae656 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -688,6 +688,12 @@ static int create_async_eqs(struct mlx5_core_dev *dev)
 	if (err)
 		goto err2;
 
+	/* Skip page eq creation when the device does not request for page requests */
+	if (MLX5_CAP_GEN(dev, page_request_disable)) {
+		mlx5_core_dbg(dev, "Skip page EQ creation\n");
+		return 0;
+	}
+
 	param = (struct mlx5_eq_param) {
 		.irq = table->ctrl_irq,
 		.nent = /* TODO: sriov max_vf + */ 1,
@@ -716,7 +722,8 @@ static void destroy_async_eqs(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 
-	cleanup_async_eq(dev, &table->pages_eq, "pages");
+	if (!MLX5_CAP_GEN(dev, page_request_disable))
+		cleanup_async_eq(dev, &table->pages_eq, "pages");
 	cleanup_async_eq(dev, &table->async_eq, "async");
 	mlx5_cmd_allowed_opcode(dev, MLX5_CMD_OP_DESTROY_EQ);
 	mlx5_cmd_use_polling(dev);
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 40f6fa138e27..cc159d8563d1 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1485,7 +1485,9 @@ enum {
 };
 
 struct mlx5_ifc_cmd_hca_cap_bits {
-	u8         reserved_at_0[0x10];
+	u8         reserved_at_0[0x6];
+	u8         page_request_disable[0x1];
+	u8         reserved_at_7[0x9];
 	u8         shared_object_to_user_object_allowed[0x1];
 	u8         reserved_at_13[0xe];
 	u8         vhca_resource_manager[0x1];
-- 
2.31.1


