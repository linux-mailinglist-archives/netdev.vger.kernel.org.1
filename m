Return-Path: <netdev+bounces-138758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0C49AEC69
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5792835B0
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E59F1F80D3;
	Thu, 24 Oct 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="db2VoXm7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DEB1DD0D9
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788143; cv=fail; b=CASnvkoXTf3Kx7dpEGs7vMB/I8KLQ+RIl9Q/gOxt786rG0vQ8ifJJy+fUZwbf5Z8KB3phGivu8hRCBTo4/XrydVlEuKOZqOMLmVol1fGRXM0LD1NrzPfcAH/so8lF5j2ItDTqxbfpRZqK+glJg7sUo55x3VuquNwxCLK8j61kx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788143; c=relaxed/simple;
	bh=WFz+DOlVNWfMS6cybg7w2POSEJ3IrMQBJRnZOAzo9zQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IUbvbuaWpfezEf2AQ31rwJCjjGffifFMFVNhHuJbUn3Mb3tSD3CET10PNo26KDQcyycu6zGpGJH8ILT9q14QdiMp6Y/AAziwOOY//XZUmoZrd7Iq+fa830ig1PDNaUAyMxj/RM3AtBrIvHCBCIz7j0A0Vh+cpqsQkT651eTgwqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=db2VoXm7; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8ykTG/7ohUlkmlM/uHJ8MixuSfNvd0NCEpe+FbkWEgar8gsP9KMYyML8dR5W2zAOM3W8UjxacECd/pvHcQlTJGxMc5MspSeJfoKT3QepvAGZn81QKSuSmlF2nMz4pNK7Tg3QfTKq9widaRwsmgB1+IZsI5aCOi/aRCTbI4HU1ZdHDzq4ZZHfqOz1ESMf/vK4ff1bLK1pkYi7Q6mC+9YR0/nHY8JWaGpDzCJA/+/hOULRLJC1GMppMUw9TvYn2eGybV/BbA+RrU0WdK4gU8/+hJ1+Mx9CTED9yG4dLZgFiyz8e+PuYJvPFXN3ckdUGQ5Muns203/CLBVoJ7jzvMCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5NWLWtzth9cFZSwAeYtjQK3IqFDNr0vEOt5vUqWrPM=;
 b=iQymItfZPCy+SYvqnH+sc+bTc7ef5iy05vn6aJIM0ypTooqpv8zmyU6PWiG/vmgkub7mXnKkNh0bSmWpJgttgnhKviC6GtPAGMX569mxcIktaRQ1oVVUIz/knw8tMfDt3Dt5iW9OFXVDOE22HPKy8dyrkhFLjAh+K0SJAjpAE65NMXs8Q2KkfIMCHJuMJIiHv5V7mnm+VvxuaJGM9H81L+XyBUfGqMdMszepYS9wgnnYuaq0auhJ/+HAHkTCbWtcoJYUSt1ubJzzrxk39UasaqSZvn2FdGFPqm/retafxq6X4+KQpC4k6SS9B8VBV7k6HGHrUxDgIgbL6pvBNYu8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5NWLWtzth9cFZSwAeYtjQK3IqFDNr0vEOt5vUqWrPM=;
 b=db2VoXm7nGGO34s8KgwiatVU7eIqAlfkqDQVw+rWCZImtaZIdnkQrwBWuHuyrHDW/WTwLpJZMBUVmZXvAmvXv0n5VuYoZiSS3PWOZCbLA8BXwTZLqZmStxcVozpfb0RGRSR6kkRTaVfu8rCUMbuCFnp0dtnPnyb9ExEHi+qEEpZDeTf3AX8ygzOqo+881jbMNCM9BESMCTCYaKpMbBk+T5S+2OAS1FAYYGZd6rsJZ+nPy3I+yNSQ5uwdZ+fdBIdLbufsdCRXF816usE5v+FU44yb5cVTyN1wdh1DZ9wwLgA0Fg9mBvR6i6+cnHpeQlsVf4tJW5Laj3E/mHOUdqv/yQ==
Received: from PH7PR13CA0007.namprd13.prod.outlook.com (2603:10b6:510:174::17)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 16:42:17 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::31) by PH7PR13CA0007.outlook.office365.com
 (2603:10b6:510:174::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.7 via Frontend
 Transport; Thu, 24 Oct 2024 16:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 16:42:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:42:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Oct 2024 09:42:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Oct 2024 09:42:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 0/2] mlx5e update features on config changes
Date: Thu, 24 Oct 2024 19:41:31 +0300
Message-ID: <20241024164134.299646-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: edc75e31-55b5-4e77-9c7e-08dcf44ad1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4coRjFqeHSV7akemW0UnqvM527Rly1RJuFhINZk7fXrStX0tfMVIvdkr1Lo/?=
 =?us-ascii?Q?/9SiGq5Uw8Q9ddITxwNQbTM17C1sWo92R8HbMusrDRoIvr5pZOX3KZR3Qz7p?=
 =?us-ascii?Q?dSMIew8Xg8KlhR5r5VFIPeMHCB/pcUAzZEIjSfCOb5Z0Q51+RTY6zMBUI3Bp?=
 =?us-ascii?Q?Pd0mHKdwcR41RZOZAPmD615AqqqyenBys0CQTPSvjGpcaUJiDhXmB5XJEQd7?=
 =?us-ascii?Q?f0JjF9FhZAhGFPAGoUyLLd/eOABF6SF4Rum6H01iWrxl/9Hpav+F4M8ZzF83?=
 =?us-ascii?Q?Mlb+UHZCEygSudLS28T7/5Mw3xxqv+Sq20j5PgbsCCGITqIUXij+vg0ltYNM?=
 =?us-ascii?Q?oQYGXgw4pUfb5Eg9KQzdJ6OAr5iASrihZQ5a6ctt6VVqdvIHKX5+l0RRvgO7?=
 =?us-ascii?Q?WtdHrPvoLdbxUZdhjfQelxMItOhZjjRcL5Xfe2w0w5NJgrccGHrYnAq6btLg?=
 =?us-ascii?Q?8mtR6luQ9H1JG+q84cX0XLFRYInVYq9wLfZdcVCzuSxnkeSAws4u5RDtwUi8?=
 =?us-ascii?Q?dGkg5VNYe4EyXDSiFixdbiNcA6bFs51jY3NiB/daax35R/JWi9Pig5zb2uM5?=
 =?us-ascii?Q?pfb96wcqXwcNSMjJS+AdN3ltH9Ap/3Y7Gix9Eq0/4wdbgbm0hPn+knCfbi2o?=
 =?us-ascii?Q?nnOkNVwPAW/NfLJhcA/uDhMlWVy+ci7DXqmFmolKqw3aiVUBghu2IwglMVYw?=
 =?us-ascii?Q?OE+7yHFiye8Nnk4oqLn36Tcc0Y4S4l/T4hj5ZAGlry2aTS4PI14AsUrJbGdI?=
 =?us-ascii?Q?8lZ/X6zeSsXFpljUqYoFgIiiLFFrrXJR1JjxWsZr8NAY6+HvutQwPEC68E0e?=
 =?us-ascii?Q?WCvZfBXLIU8obwOS2CFmETKkf2qkhtmXFdN5NsQQjpH4VXdAtkOTH0nY/16I?=
 =?us-ascii?Q?+vP+JdJ4z5VDfKNyCUa0oDcWmyYFaYWk/Gt5nJZPP2lsoCxXctJsqjMri10V?=
 =?us-ascii?Q?aElxwIUjq7WCjbxiJjfgmUdZF6u312HfLPxpj1DB78toDmZQvYhUeugqUKgQ?=
 =?us-ascii?Q?vuGDMQX0PyL25J37/rPpl8WNlQNsbmdzmYpZ5d5FnyaPzjOMipDc1jjzJ4nl?=
 =?us-ascii?Q?uWVBnVwIckbug9Xo8ITJHiilikY/Ia3VBbzIPTB6+Ghj0NTg5tCGwec7nA6h?=
 =?us-ascii?Q?WXubiW48Dl8wuIYPPOEy+lZV3K74gF5My4CT2wh/pxRCZ28uzuIvORz65zlh?=
 =?us-ascii?Q?TsYPnVhi47be3PgkLdYnULgOdKEbLigc7SDsx0axalUnQnOTeApvQDmPHKep?=
 =?us-ascii?Q?i4U/dfc6wOh68ogBsEKShTicTTSjeURqtK3L06EOZF2x5K1QwakDcz88YFzE?=
 =?us-ascii?Q?7ngSU+50nTaRXKp20b5y41iXFHttFDoKYDuQSK/kmzGLpeuWRlA4+pZO615j?=
 =?us-ascii?Q?bvNYNzbcpD4UenyPsq03On8m1FLyrNupQvinHcJh6AsZyTwzvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:42:16.3843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc75e31-55b5-4e77-9c7e-08dcf44ad1d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736

Hi,

This small patchset by Dragos adds a call to netdev_update_features()
in configuration changes that could impact the features status.

Series generated against:
commit 81bc949f640f ("selftests: tls: add a selftest for wrapping rec_seq")

Thanks,
Tariq

Dragos Tatulea (2):
  net/mlx5e: Update features on MTU change
  net/mlx5e: Update features on ring size change

 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c    | 4 ++++
 2 files changed, 7 insertions(+)

-- 
2.44.0


