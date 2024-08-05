Return-Path: <netdev+bounces-115634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3981494749B
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 07:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8CC1C20A82
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 05:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB55913D8A8;
	Mon,  5 Aug 2024 05:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S/NBYiGo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C31631
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722835432; cv=fail; b=tuvwXEb2Oh+W6x4jczLm6/fD9AO2KLEFAz7iqCcWN6z1ac0j058GVtXTUzP3xGl7ZeDV7Mjai3dPaLVsfy8/eMviEudzbepuZRQHkYG6E3KHzenE734qNB9q24/kAQHALBOlCE/gDlBJOf38XHfyGAXn4y1cbb/lvlT/CqxGiQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722835432; c=relaxed/simple;
	bh=mpfH0+QdHqbQSjeqQjDU6qEEIcEnPdofmBIdnva1jOA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EC5S8I5mvKSB3gq7JAGp1TmYzlqHGrhAoSLstd8ToEXLmwxvNIhlihyNLzhyBETD0HIPmqx3jcRjitm3leiZhAkc/c2BAfXAjATJnIvB3CevJ1JsUzaV78XFGP2vwTEVvKfeGYMGJ+m/6orHUIE1XJjJaxwUbTLn35LntN2elZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S/NBYiGo; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1gZ9ZHfckaZqHEXmA5F20YkaSKgZZ66KIgrG8k5fLsXjDmzgxmjnD8X4TDSL+WFQgcXHGIIcsgty/bcE4u7xKeQM2AKbsSwoXycUQTBWQOgXuYUJmr04lA8D8gckHIbnGEYcvceAidJ8xB+Hb3fsx0TK829TJo2yDXLA6RVLTmm/gsVTTWvF2U353wDvDs9HqMxINIxxGBehQ8d+u3lieWqPsiQKNEKw4rpJXum2m3gc/O3XB5YFVtNY86puNCmNVD9grIvOgGq5XLZPk8sj9W1lU0eGyvSbNrGc750adt4ixxXXrPa7VbHTNKvcQ6XfOwrxj3gaGDfK2LlLzTcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60K7WfmRPYvxYeJu6AdsSI1t/9BiYHiPPPGtdpIeXGU=;
 b=VZ4b/O7Oc1VJpWCcmlRLw9vBFEsvFfVwR/U58X72usTIqloTaFYftA8M7CduDUvVTcfIQ+FJ8KfJBsBCYnZ8WgEv2HXMr07Mesh7xpdZGuo+AAUZ6sOTmamXUi4CC4zWGze1VqD7bHyMedeCC1FNGJhc3bCU3IZDSXVjie4yyGeLBF3Ym82JP8SwyvG0KtNX8cU3DtRfQaHoCrIg42sjkzIqs94Fq01YUCVYu2Sk+5rbtFM5bI9ZtdZaOoRp8s1oXGgYqIkLoNuc2FVL5wiUrReR27bzVRUZTQY3P4E9Ps02YlK43L1TTLjU6TjKSgkNl4n3Oj9wVH4fsRqMBsNuBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60K7WfmRPYvxYeJu6AdsSI1t/9BiYHiPPPGtdpIeXGU=;
 b=S/NBYiGoOHzL23jPromvInTyAKL4/SsdbvTKrrBNisrauTTxFeYQUr8kK2PKy756wgZAv9r9Y2/8NpqPvokiJJMVSo74brNTTviZXxi4BBVmPrTZlirexhRnzIqbDIWHb9PIpj9YIu4AhdD8USUuI4zPNmvG3Cgx6zBe9dSDqEh00AL05968NVa0AxfWJgNYbjsYx3W+JEpJ2A2cfmObNBCuVWAnxALgzocp0NaWF63ldjsBHe0ol2tKHZgpgCTKAmkOlWpE6R0dbYzafxO+psj1ZvV89XDmWPlf4I6/W9VC6RU0C+kFFyUkimEDRw4H4WjMlcNtMp0dq4KGr6ewjQ==
Received: from BN9PR03CA0752.namprd03.prod.outlook.com (2603:10b6:408:13a::7)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Mon, 5 Aug
 2024 05:23:47 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::dd) by BN9PR03CA0752.outlook.office365.com
 (2603:10b6:408:13a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 05:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 05:23:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 Aug 2024
 22:23:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 Aug 2024
 22:23:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 4 Aug
 2024 22:23:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next] MAINTAINERS: Update Mellanox website links
Date: Mon, 5 Aug 2024 08:22:02 +0300
Message-ID: <20240805052202.2005316-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e08b79-bb56-415d-c366-08dcb50ec801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UkgJaSDxQhbLOjggRlqwLic158XZ0g9MMf+qoSOHhZYcJjCFjERAMtfRId80?=
 =?us-ascii?Q?q3b4hkppUlpVqNH2bmdDidziNzEo8Bx6XZBpIHRoA+JvHDTGFcONG3VRX/lX?=
 =?us-ascii?Q?+wH8Qyj11LNsvh9vIWSuZRbRgUbvjh2OBncLLz+MwjDSOs6YSSs3Z89hew9L?=
 =?us-ascii?Q?mIckFI23xrQcn9+aFDIU3P3f1fddQWsuoFBz5Tan6prKOpmjK/MgQLv+0l3/?=
 =?us-ascii?Q?MgzVauEf6vTEO1YYfIkBSLoMAaiD45wr+kr9El2iNIUh6lA7Nsq2G1+D0AjB?=
 =?us-ascii?Q?tiS4WhHUahHB5NORb8ty1PIB+t6IxgDQlDl76p3vNDyPUA3I1KeR/mkxMP7i?=
 =?us-ascii?Q?V4GybTE84HjmigDQCERdohHd0PfVIuEmTOmiDotF6UR+7gg422MwcSiGr5bU?=
 =?us-ascii?Q?77fEqwCaxke2HHTXNQSFOqzYSRcNljzyiduIKtffKQw4UEMLftVKRkp6b/r5?=
 =?us-ascii?Q?uLemW6BdWMDHrvWYjuwQbWQlLqN7Vf4F/+pALlsuntUa7LxuPa/+zetfZH+0?=
 =?us-ascii?Q?kNdyB8bj3GdCuw+i7IjqPuOHbVr/t06hj8pF0lhGpjnUDZXJhrdFRC43ApnS?=
 =?us-ascii?Q?56JHxlth/yy/NZbLnMdOtQjfrrcz7oqLVDvZu+AwybHOv+iEwGI+QR02p9lr?=
 =?us-ascii?Q?EE2vGqReibqwm4ax6DxrvT8raYqDcxL5f2HIe30Vi3+3TVPxYcCcJQ9c28OV?=
 =?us-ascii?Q?lmqt2jd68R57ux7Ed67Ge/KN7oY3LxnJH3p7dRAR9bm5OQN3pdceXvcqszYh?=
 =?us-ascii?Q?Kv7ZENK7OlvV0DH3AgCKyw0sc1Kcpw3I4qqPyv4HS+tZAo2wXzim0sXXoxzV?=
 =?us-ascii?Q?ua9tGDJNVQ93dj+JVeT3Lf2sAr+S0Tb+pmUJCwehVvTTr4RwN44URx9r2Kul?=
 =?us-ascii?Q?I0gLY4P1zWrrWPNJdzjLC3udF62vYlnSJbDn0vZ7PieZC76PoNRda9kjRwYz?=
 =?us-ascii?Q?BqPW++Fexn5+tsYi7LsBVjd6cRJk47xXLBB4+47L1IuVq3VkubzgguKxPOHp?=
 =?us-ascii?Q?CEE08Vm5WDRpXj1Gc+amfWNqFmqKCJ84lTpzXFjXol7ThvUC41QbcGXivPaM?=
 =?us-ascii?Q?vWplRq/oAkydVS4qogHhM+szCvCPF0sVbGQktWC1TrM6gtejCmFxvrSiiK3e?=
 =?us-ascii?Q?wlyS5vAgmWMNufHH325i0c7/9McEyvXPuPE+H/BhkMahCnWrXEjQTRJeCJIC?=
 =?us-ascii?Q?Df2KsHyWIal9wI91FwDNq3p+x6gY/kdy1VOYE+yRb1cZ7gsUlDQcffVqcFzu?=
 =?us-ascii?Q?j3NV3ku4ntltu1BNoV+iIk91w+0Er6mQArlwthnTp9Sq9GgFYKih0+aeQPZT?=
 =?us-ascii?Q?H8FNLU9poOyJ/p1Yg+PVVXQuq41z7v8XQU5wNjxllEb6MtMg3ALH6ebhFcGL?=
 =?us-ascii?Q?yYqYwIPyqBnxCq4b+uVmSvmKBio2PxBQrJ7m+gKfvCZ744a4wUgd4IaLxY1V?=
 =?us-ascii?Q?HjM9XeDR8fbDF5XjSqCmOccPvyslXZp3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 05:23:46.7464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e08b79-bb56-415d-c366-08dcb50ec801
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Point to the nvidia.com domain.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 MAINTAINERS | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..a9dace908305 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14489,7 +14489,7 @@ MELLANOX ETHERNET DRIVER (mlx4_en)
 M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlx4/en_*
 
@@ -14498,7 +14498,7 @@ M:	Saeed Mahameed <saeedm@nvidia.com>
 M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlx5/core/en_*
 
@@ -14506,7 +14506,7 @@ MELLANOX ETHERNET INNOVA DRIVERS
 R:	Boris Pismenny <borisp@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlx5/core/en_accel/*
 F:	drivers/net/ethernet/mellanox/mlx5/core/fpga/*
@@ -14517,7 +14517,7 @@ M:	Ido Schimmel <idosch@nvidia.com>
 M:	Petr Machata <petrm@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlxsw/
 F:	tools/testing/selftests/drivers/net/mlxsw/
@@ -14526,7 +14526,7 @@ MELLANOX FIRMWARE FLASH LIBRARY (mlxfw)
 M:	mlxsw@nvidia.com
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlxfw/
 
@@ -14545,7 +14545,7 @@ M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlx4/
 F:	include/linux/mlx4/
@@ -14554,7 +14554,7 @@ MELLANOX MLX4 IB driver
 M:	Yishai Hadas <yishaih@nvidia.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/networking/
 Q:	http://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/hw/mlx4/
 F:	include/linux/mlx4/
@@ -14567,7 +14567,7 @@ M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	Documentation/networking/device_drivers/ethernet/mellanox/
 F:	drivers/net/ethernet/mellanox/mlx5/core/
@@ -14577,7 +14577,7 @@ MELLANOX MLX5 IB driver
 M:	Leon Romanovsky <leonro@nvidia.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/networking/
 Q:	http://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/hw/mlx5/
 F:	include/linux/mlx5/
-- 
2.44.0


