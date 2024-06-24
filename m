Return-Path: <netdev+bounces-106017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABBD9143B9
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE7AB21778
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2D7376E1;
	Mon, 24 Jun 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TzurgOSd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E213EA83
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214288; cv=fail; b=hFGWnXDEZmrr8r827ceTHnxCqHO4kHpWlNA3K8oTnfMOH3XzGOsb75pP+4b1nxN/aYA0bh5k6D1NCxMpY9IB7AmW1OoNnDJhhCQ1fHPiNISWSXHwBfLAq9FunKyiHSt7Mn18x7Tmu/qbRscuAaq0qD5LAnGmuZ9hA9GuAO0yKhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214288; c=relaxed/simple;
	bh=izgBM7UrxIUFUTIjn3r66tKFZKZ25ckV7wt+xeTT5Cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tl6j1pqyS3A+Xcz53U1Iak/c46ZaAvLEQiIw5HJncZWGIOCVXBgarAvxYpcWrAmv0zwzKBedCShWtxlcQtYUpq6XxWux46ocpo6w0EnuDm66w/WIdGqpgEPvnAdGtkh8iatQg3eVHX/LfbwwXzF9OH6c48NSXaRwSA5ZOqI/U0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TzurgOSd; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nj7eE8uk56Hn1dMKb2Az86LBQpRgwTxbOLiwe1uKJ0RZ9uuw1KzmHod84cJ0xu+DzJqiiItJVvx9+OpaSR7/Ew9FOYqfwK4t5eM7cd9j0w/urwg2gFP4EE8tbkBxUWvX4YS1u6jSJ/cfc7qfKTOGICCtbFhojc/VvKDA0lqzZILuoIsKlZu3dICwwmKQJZk3oC2PXtjcTAGl7Pb9dOs1z/t3+kRPqWmGa9CLhsA7fCzAWETtFEGFlWHH5/G0XiYZaPo5I4snU1UP0ds1Jf/aoUgnGElpdUOiUoz3C4u08DI+l2snRMUcJF8gogNrtix9uhZXSzQVA9RAs2AfYEevZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO7PjPpw07uz0p2M9ZXfLFgYMzDlHf75tvNXyyuDoSQ=;
 b=ErCqSPt6andbrOTWkyn1ZOAFXHkxlUC+rz3w9tLD2g7pUX+gLGzma3fHHZWQjh3Ih46dfb7CmZ5vPc59EMI/rUSM3XpZiQSTTPJhTCf44BPuavAAO0Q48tLulLtvHfriaKVSEo9xzG6F1fpYqEwvy8gIM62kX86Sqan73qH5fRSyppK3ClqVCnZE9PL7tF8uEd3FU4lydaFGR1IJkTUnDw1nRvoEVsqw1XZRBcFJiNe5kCpOWji9zWxPLAL6Tr98pLuzMbViXVCt1EElDY8CbFmp04XzjHgk/nwhJAybH/fKcYgYWn5YKJh9GLhBcrg2Kq1nVoTHok0HbrpPkWTPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO7PjPpw07uz0p2M9ZXfLFgYMzDlHf75tvNXyyuDoSQ=;
 b=TzurgOSdGWQyPAKeUa/9blYQc6UesqrncfDOC5ce7QZZTEw6sJ1iajKgv5v9iPqjOFbVI8DBsP7K2Gm/cbQl7D9DAEx7id5g/AvTLfjljerKTUaF8TheIyiC1J2UYEzz+KVjZo22Xyzk6RJcA6SM8Z4z4/i/oV/T4sxBlIin9J+m4Wo3OtFn1O4cvM8luUGmyoemymj/9xAiKxfCtXB1GZU58l9KB8lK+Tbf4/OHXdJ1ww2ClgXaYUC+mGhxHaFgVibau1MH74+1EZ3blMfYpjJLuGlGGN2buzyWxfXxTGtLXH9XkpZ1ccLl87U0Z+UEfjHnLVNTHJ7cCsRBCgh2WA==
Received: from MW4PR03CA0229.namprd03.prod.outlook.com (2603:10b6:303:b9::24)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.27; Mon, 24 Jun
 2024 07:31:24 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::f) by MW4PR03CA0229.outlook.office365.com
 (2603:10b6:303:b9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 07:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:31:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 00:31:14 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 00:31:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 00:31:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu
	<witu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 1/7] net/mlx5: IFC updates for changing max EQs
Date: Mon, 24 Jun 2024 10:29:55 +0300
Message-ID: <20240624073001.1204974-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624073001.1204974-1-tariqt@nvidia.com>
References: <20240624073001.1204974-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fbb8bd-af90-4fe8-cb48-08dc941fa6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z5Wz656WGyoBFAzajnmaDB1Vh/oBKeARTXx7OdGlE1eDNZbu/QGU14gyCHIP?=
 =?us-ascii?Q?Dj6j0yq6EMgJKaLjxu3UP5jJkpAv0rmauHnengDVQAC2hBCWpYEIowDeURmw?=
 =?us-ascii?Q?Uhq5Ro/JzcPTV2924db+C6jHceaptfYGwoWCv4vx7z4h876d/T9gpErvQ67c?=
 =?us-ascii?Q?wgMnVDtAClPPp98/udpTnBbPNfYFgsLFS3xFHWEdfqc3FrQl8cJkhsjJfXTf?=
 =?us-ascii?Q?apU1io0BDo/sb6z+9Tlex4jXuJYkPDXmHzXorlqxQNsI1NmnIqREwVdkfyxl?=
 =?us-ascii?Q?czKDHTQvH3ZQfAU6qj8FcTPvGsg4fhKvqRtS/Xcukh16AFg9RqttVW38mRlE?=
 =?us-ascii?Q?Qo1l+JGUWHUohfv5MqNKVg3pmr/oUOA4l2ERVJr1NVPs5eizUGZOiRHfShIS?=
 =?us-ascii?Q?yHHlJOtv/PEJUp3G8y929aUW+GeOW6SuGu0cFYwKvaVcU0h8bZ3GhpSEnGWV?=
 =?us-ascii?Q?niBcpFbS5xrrH6Ei81LhK5Y/uF+AC8v7JnGT1/ee8/Ly/KjhiDDJYIlCJSVg?=
 =?us-ascii?Q?NB4afp5bIOEdvc2TOzAYhHtotKR5+Z7U7HK/W/zdLHZS/1gud3LDlK8E0rbg?=
 =?us-ascii?Q?uoACVqLl4DWfTaRwlLqLaTCNEU0VXGK+ZerQfbqvzc4lZYBu9mfrosRHtfn3?=
 =?us-ascii?Q?FFWnJ7fOWOwUMwywoc0jc65QVMnAs7qjPjU39/w+AqhjwL9e94NE6YrdjWQb?=
 =?us-ascii?Q?iNOmhkn65rBXn5TqrRWdCIBeYqDfPXn2ig9AYRz3kThZjKanDSyC2PN6+r0k?=
 =?us-ascii?Q?gdBli2yWnhHSOppvWisCJxPeiwFLdNx3bEFPySOrZnyXJXMtU2OVCEBGvefS?=
 =?us-ascii?Q?Dz7mqyYzxlbFsERKTtsSVJYNaQ98Jq+MyTupQU2Y9o2A19npIekOSiZpW8yw?=
 =?us-ascii?Q?RraRmGOM0f81VL1Aqcpm4QmEUan5YNh2a9kCcvAlwyd8K6Vc2XsDbDRn3BV4?=
 =?us-ascii?Q?AE5N4Jj/GEKgxgEJYOFU/mEZYiRNKuvji/Lly8vf61lQlynrvm9VW/j/ujsa?=
 =?us-ascii?Q?9WbC1T0xCXfTKN1E+epO+G4HcXFfPeXGRg0VrtYZZ7RPLd6OJQ8zsxywOZTB?=
 =?us-ascii?Q?NFL+Vv5o9G7QyjS6jS5tjXphl1FinaEOA4QlYOMgz5yRcRM+6lEq3xuxa3UG?=
 =?us-ascii?Q?f5E2E54yQgfJMS7RmYv3JWdbYz2ZXyLGuv8PH62Hd6vuqgogvkgxEm6KYWUe?=
 =?us-ascii?Q?Zj44lkhlG7eS0+uFvUHNmkIxyn/EHlsV+j1r747E7C3ip2kAU1ZRdnS4d21t?=
 =?us-ascii?Q?xVb1ER2+O/R4wY9t9rAj03I26JxDCPHDYiJpSWYaIT12pw+nO7aWbDM8sOae?=
 =?us-ascii?Q?sQ5VSTO3cVTTBC9xqgVv5863Dn9JFfV6UvGe0GIRz5vfJDgXtc8Ep0fPLAqL?=
 =?us-ascii?Q?jLiYdTAOBDMHT4Xw2ItD15Lorq+XaJi+h1vq8a4Y1CCEV61EzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:31:23.9938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fbb8bd-af90-4fe8-cb48-08dc941fa6aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985

From: Daniel Jurgens <danielj@nvidia.com>

Expose new capability to support changing the number of EQs available
to other functions.

Fixes: 93197c7c509d ("mlx5/core: Support max_io_eqs for a function")
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 5df52e15f7d6..d45bfb7cf81d 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -2029,7 +2029,11 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   pcc_ifa2[0x1];
 	u8	   reserved_at_3f1[0xf];
 
-	u8	   reserved_at_400[0x400];
+	u8	   reserved_at_400[0x40];
+
+	u8	   reserved_at_440[0x8];
+	u8	   max_num_eqs_24b[0x18];
+	u8	   reserved_at_460[0x3a0];
 };
 
 enum mlx5_ifc_flow_destination_type {
-- 
2.31.1


