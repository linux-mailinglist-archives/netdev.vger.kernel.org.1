Return-Path: <netdev+bounces-109760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446E8929DDD
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F231C21E2D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246D73A1B0;
	Mon,  8 Jul 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NwtfotXC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2025634
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425711; cv=fail; b=l2Hds/wLlI9af/Ig2dPCiCqZ1JjzEaaYlgPHYl9J3hkoiR2/5f0OSf6Br6BGH9U0eZyUPlDYW+qM9mZJaJCphn2bopBdRV/rk+lj78Zbsd2VcVPGx9QvM/JrN5tCzwGpZ1FXChFWBUlFH/IPy3/zwOvV/hTYy11Ehg8DtdrYvwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425711; c=relaxed/simple;
	bh=AnhjgvGIV82k24KRmrNwKdWUz1xIsA9OC2t7P6HGyWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9vghe9qUD4gyoD8u9P/CbwVb6qxnwZULl3rjUdWMc0Ag8k0GZuHLioHO8Hz3VHXkWQCh6RAovyaAtkj3+GXhX4vyKOvi7Wwz7eoDVYkKWEwef+aoeRAMZtvkXJJ40pMnAiLM2Zx4ro6fy/e57lfJZVROPEsN/DljogogpxRSpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NwtfotXC; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ga5KvBR5m22o6k1NjZcVtdbQ6XajL7RLuFagyETQEvMKNWCKf2DUjiQQSzfQ5+2d/Fnr8Db1a6ast0PSZMxoXxc6I/oeQK9M8DSAsmAq0l3+ZGSTads4K8WeQO/bzeg6/8gYTHn67Zz188N5wEmJETVpTEwfh5GDEsKFPoEiejNv1U6XqeR6SgZTJww055YLEuzOFYxlpkB85HixYY1jySw3XV/jmLIe1jwUvmiZjxqZIpV4BE7gAsSim9dr+Oy6NVzyIppnC/1NsHAt9vW4cQ/z2evRIy0q6havK4VtwJXTFgdP2M3CsrDfdbW5lrzHV5rFTQem2JRJuYZRPuVwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHKFhVc/yEW9RV8BNv/0lEwVfAPcgMqyKxr9icBTMBQ=;
 b=d1bp8CFZr4CrrA4K/v540iBve9jNUpH9+iv4evGPJLZPdbF/gvw95G4VooaDNH1uBhevUauTu6Ku2VUZuXJJ0L22gBwVF8FqxSjEP8R0hIB1VbXgnW0uhmrJH9bOV5NK74rpW68Fo838MU/09M4rwf5yTVDiDcC+OditXf/lv7cdPDHh39GULxxyUDcobZZnkkVaW0/hB7h4WJR96pG6aS3ikgzo9v4/BNODJfbXwaYKXirAzS45ci6dPhRg8pWYb39RtQnN8zfQ94vgL3ZbccywjjeCHAkdpCp7RWvFIALAFnDB1foQ1yFpSOdf86yaBD43Uv1jjsjejkjmjjT4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHKFhVc/yEW9RV8BNv/0lEwVfAPcgMqyKxr9icBTMBQ=;
 b=NwtfotXCwVD8OVVxPbr7vA+lAQjazJd3B1zj+CORf/cEJQHd6nGhKeQF5pdh+NGyEcU5N/DJVZwP0L+4J7hVxFW19E3/4js03UsFscf9Zr+uMV4pC3o6SWjxqS91vNCk6D2Bh+vXLSTWGE/0qQiegbW7DOPnYDLBo52m7wcf024D7kZIqdvqlgYrRHxTArdgziA3QZaxBcGOqPCyJpoXFf2TAn+RuWVW3k6vDeT/UIoMaFOfJyfz09f+cOvO+x499ElwvN3+wiSO7w3qcydY2WMKgwoOTGcSaVV9VGJ9rrlLaEB/tX7dvchy/8cwRfXNGtHTJqcjkuGIurnlF4LjHQ==
Received: from SJ0PR03CA0139.namprd03.prod.outlook.com (2603:10b6:a03:33c::24)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:01:45 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::7d) by SJ0PR03CA0139.outlook.office365.com
 (2603:10b6:a03:33c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 08:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 08:01:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:34 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 8 Jul
 2024 01:01:31 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, William Tu <witu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 01/10] net/mlx5: IFC updates for SF max IO EQs
Date: Mon, 8 Jul 2024 11:00:16 +0300
Message-ID: <20240708080025.1593555-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240708080025.1593555-1-tariqt@nvidia.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce7b30d-1b6e-4709-86dc-08dc9f24361f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eMbB3G+hzTco9iMFc6W0JFYweM8qz3osxO9hL/kWHZEFwZ3eadYlRMSscUUs?=
 =?us-ascii?Q?5fjokwpdRw7ol14v/1JIxcPWeNMbNd17NQl1lTAdKNnae/NK3mkcTkZkOrBS?=
 =?us-ascii?Q?gGvWJ6XEgBClGlP9Bfa5jyYrBQidmv7qjqq1ZsoFe7HzOtK/TH/wlpBKIxoq?=
 =?us-ascii?Q?syNxe72SVgaEI8QaqH8gLpOQ32B8sqplVBaaLp8SKqOuOokCOl+OP0qadYae?=
 =?us-ascii?Q?WeOVezgl3Qy+Idoh25eFi8dmTZi48cwSWv4eGG/dL5iau8p1sDEn29OqVB2Y?=
 =?us-ascii?Q?/Zvb+Q+W8A3pAqCYXSP4gbY1zuQNVd0lS9xGsf6codIaP83hkdKrCGlIhGHu?=
 =?us-ascii?Q?CDTPreDWeCKM04rgmgG4h1QRyEv9oyd2ac2zWQjfckPlI+qYQmlalE3j0ZMM?=
 =?us-ascii?Q?ZB0xZDD7SYi6QwnkUpdzErLu2poj7WERQFd7tdaPhoxcT7H2nEpo+Up49NAM?=
 =?us-ascii?Q?h/T7XnVALnXGsGstNq90rBfEd2BYbyNGxXdpXzfz9Z6EdjzX1kGLaPn5MyOu?=
 =?us-ascii?Q?uiqmrdklwYW1GrMeoJB61TV9LmNPfWuDZKHbr6oCeAML+wM0cedAjRAJUmdi?=
 =?us-ascii?Q?q12bmhELoMGXsIxnDBOqleFTmFD+LxkvrdBkAP77n/ajQj8KVbg2Q+PRbCar?=
 =?us-ascii?Q?sjLDu3akzH6sW6gXbmrTT+/gilByrSRrYQYnbDzWEP9Iy2ZBW/ehOULS/Z1H?=
 =?us-ascii?Q?XiEaMz3XO4j5EBpTC8lmFyLHhtm06Jm2zHuzQFZe3h8dkeQi1M5J0cKj1MH9?=
 =?us-ascii?Q?8eXz00AAJ9lfG8deGDNDDSzn59/Lv6qusVIEWuIt1KkYwJeV4E+zqk2BgtQO?=
 =?us-ascii?Q?ITXs2hk+XE6LyCZFic6/r8Ot3xhPNnVLmRN4uROC7jOvAksl17Ij1EeCbyuN?=
 =?us-ascii?Q?y52ebs+peX/7ke8da4mDXw0YyTLGGuUYdO6SGH/khS7fJtldMB1ex4XiK/TL?=
 =?us-ascii?Q?0QVBSr5gHPwEF4vkgSQRcVndIq0DvC5chT5D4wJX/Pni3+1uKeOzLdGBwjkq?=
 =?us-ascii?Q?rNQUNBAPTeUnZgQGQyiW1Kz8XawpBZxC+YTm5dJJ7ke5qSJIoyp/pnWLIbir?=
 =?us-ascii?Q?3ZRxljt7zh34YJrlCpk2WPXttPFO2vuekMt18i2XxxxvtRtPSGsRnhh7NxK+?=
 =?us-ascii?Q?Sidp0wINUxrOhqbiDATK2uwA5rG+rTs+Izqh2tZH//TbaR9e5YS82m0js/h9?=
 =?us-ascii?Q?0rATgkHWzqn7hekWlZRhbRFirx7duC7J7aBRuqbtW5RGX3yjFkxAATff6X4H?=
 =?us-ascii?Q?IiJoWyAZ5jUQviJzaZqpfZXrTnNK9yN4a+loDU/ZZH8YKwgJvioYt2DWs8Kd?=
 =?us-ascii?Q?N5JdTRy/6ZtZF9xye9OKHT2TshfC8QQYG8Y6PgzJz5fpa4NayyLoCjmjbJdl?=
 =?us-ascii?Q?aUPSCiw05gMSiBi4coHCkmu0aEG9AKrSIeu42QLA+vVPKDUQkXMRmitos8ho?=
 =?us-ascii?Q?v9oE/xAJPIRBDixpegik1dIKGjYqV9dZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:01:45.5286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce7b30d-1b6e-4709-86dc-08dc9f24361f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225

From: Daniel Jurgens <danielj@nvidia.com>

Expose a new cap sf_eq_usage. The vhca_resource_manager can write this
cap, indicating the SF driver should use max_num_eqs_24b to determine
how many EQs to use.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index fdad0071d599..360d42f041b0 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1994,7 +1994,9 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   migration_tracking_state[0x1];
 	u8	   reserved_at_ca[0x6];
 	u8	   migration_in_chunks[0x1];
-	u8	   reserved_at_d1[0xf];
+	u8	   reserved_at_d1[0x1];
+	u8	   sf_eq_usage[0x1];
+	u8	   reserved_at_d3[0xd];
 
 	u8	   cross_vhca_object_to_object_supported[0x20];
 
-- 
2.44.0


