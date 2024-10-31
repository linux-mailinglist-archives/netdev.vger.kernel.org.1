Return-Path: <netdev+bounces-140717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6E69B7B39
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02C9B244AF
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDC719DF62;
	Thu, 31 Oct 2024 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LwTQmRXr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1730113A869
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379612; cv=fail; b=nzZDkT+ij6b1C7qWg2w2GHbRcYap4s3yHNT1LnNyR93vwTtE0UYhhpGX7p+LIQ0cW1oEnmY9AlglrsIRhzoVyHr1DiekchW/KYGKMNwasQQqJfMW1o2TCuGh5+OtEgpkag+5MVbH2S4K6wOT7OZ+Gkxl5hKYvUBmp/pi8pGRvmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379612; c=relaxed/simple;
	bh=KTlyehCMoteILaO4no1dxh5NJGJ0ps0QTgbrCGLfj0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxS6GufymH6fUxZJC7EX0G0VU7XTzpvCU225kGP7bTcdCesbSurvBa9AOzfl8xmkG9ct0cGpwZhZ0GXdwct0IvxgE0HwPGxgxjVZHHCQIgTHErEBfd8Y83z71Yd5jfJJUT0zptqSAwCyZw+n773fr3Py8pHDwYSSTUYCeC4TaWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LwTQmRXr; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6H9btShBELhiP3FsC623kiHgzdzxzxbkXW0Jj1AI+9djggy3TYTchSycdlpe8zu9eDMdIV2pTaCtnZ8dOe4JNO/Kku8F6dRsd84upCG2TG/Zm7HcuFeQ33luGflvKK3L79bCz8W2zAuJAcMjgHw/XiuQnkxu/RaXWJthHWWzHrxIlnJxMNm/OAlAcRmM13PaF6MzhxQoApy4zKaBRQsegFSmqATjZ25SGj891NJM4h1eo7FJe88Er+KMiMsBPdP0aNgcUdBS53OTrI9kCQ/5hCNAs9oZY9A94QXdXwC1/3GJac5QTLaTLfoIuZJqGYCVotLTUMp2pcRCUIgOtdTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3aH6lmSvTGn4+vS3tK6im0pJRifgtrLtUAApFnhPss=;
 b=ALJIA9u4Y5EKJoC53bmvn1/4U4J9KY9iCu433Hx1mTDOvwlpt/nTb4RGnjwcOusJ4BvRb+iKN6N+1mdwVWRoqzp87TRPYC81ThT0c2TLy0ZH+rpwPhDQCfnfrCeNXlpmdP1ChakAqZTf40hPv7/qwkIRNfd9mJQyptTGFsuRbGnuM1GfxkOX575mI40SeT+fVQd/RJiPskl2v3vQNzbNxL2Pxqb+EsqwBusUNIC9wTchgIROiIoCFOn99tEBCiXZOdln4tNXmk9aJq2+Jxm2NNbLJA9+N32G2+s868/Ze+RlxUdhEhNld3F7U3L/c8pJGjSdBe6DQCijr2P1leuDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3aH6lmSvTGn4+vS3tK6im0pJRifgtrLtUAApFnhPss=;
 b=LwTQmRXr0Bp+HCzdZTVZJhWGAbhkPKD5fLKVJWjNvLW5rWijOG9eAWD5RiOb989H0he2rJ5MZJZtlStwsJn9DIufiqZ2+uqpNJBlc1AMkedt6X5Yp8Uy7Ua8aVKUPBvFIu9E0s+oe7lpKvPWBEV9StrcpT87jm6gvQU/oWYG9OKVXPb6EoqRx/thyYhy1rKmkP16F5ggi1ZWoema7fIQKV9+lz+Gl1FYDPyWsPuRgWr/kDUCYocWxaNJWX24BNzvG+lr3a7DhF2ix3OerMSIiAACHzLmMpj940YwqzuzWxQrJbprIcv7wj3SpmBxwc3L3VH6s2lISFYEKiLg8EKsTA==
Received: from CH3P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::33)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 13:00:01 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::dc) by CH3P221CA0024.outlook.office365.com
 (2603:10b6:610:1e7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Thu, 31 Oct 2024 13:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 13:00:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 05:59:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 31 Oct 2024 05:59:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 05:59:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 2/5] net/mlx5: DR, moved all the SWS code into a separate directory
Date: Thu, 31 Oct 2024 14:58:53 +0200
Message-ID: <20241031125856.530927-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241031125856.530927-1-tariqt@nvidia.com>
References: <20241031125856.530927-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 630a449e-dcf0-477d-6ac9-08dcf9abee42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UbUhari+kvxDrqqFf4wss4l8kJBgW2ZB3/VvwM6qRKO95t7m3gIdw6nX2RbD?=
 =?us-ascii?Q?Pkegah4IbtoMxu2V1qGPkJBLkI3p987YgcvMOXwc+Xeajurah4qz0zaipRMo?=
 =?us-ascii?Q?HPB7g3Qi3h9PY06uyvkf0YVDmXpmFFiaaYBn/FZw0COum98003WmqFtjmk4L?=
 =?us-ascii?Q?9x6lT7GRrd9g9kqXkIzNzCpG4UXz3Kl/oFySzscTkfdtS9aFHnz+WFrGQTp1?=
 =?us-ascii?Q?wZj9lmpawAjdRFwTUzboLlVFuwzUTvkRADYr8kf2/AUjZvawTzTlhH/ZirvZ?=
 =?us-ascii?Q?p8TXDDdZLbrWAr4Ny8KihJlIVNHh4OFMPRB4KhJxvF1e60tmaAmCRaG1iDtL?=
 =?us-ascii?Q?cVS0GQp+/LqtXmwc92CKgyjPPUaXvWzufVW/opkGZAd6NPyEPLmFTiQroBIq?=
 =?us-ascii?Q?xpOdMAiPJmSXz0w8lEz9FFYV2SDnJrxgA84cr6TQcJfLxHMenWhWfkeNCADM?=
 =?us-ascii?Q?1YrkL+SIKKazBOj7isy6sFA1cbE5hfSkvzcQlCdwqAN1XyjxNKs8VQW53fUc?=
 =?us-ascii?Q?KO1+DFrhLIuKhm3BemKHf2kKq27HKUk2Ea0AF0lUcoesVP2jpnV0Urq6XG6D?=
 =?us-ascii?Q?EFC4lsatk4qrt3d4xJterwyg8IBnDFe4//brJw5Tda+4Y9cgRywPhGaTCGDD?=
 =?us-ascii?Q?aQ0Ki9auFc2jeih6iza2DBes8ZYaIJOVptWw6RLlQJzA3AsfvXG8tEa+dGYk?=
 =?us-ascii?Q?RTaQCrexw9N4RUyuDr48h+Jm5XOn7hhxT+38RYJKfqyQ2f2IgBB0UFe2aS8J?=
 =?us-ascii?Q?28fAMRGNAZQRnx4PwcW7sBcxBpYmj2x3YjAvo8VNU+2wGepa1/g4mdBvBu/X?=
 =?us-ascii?Q?Tjbq+rubE3kR3uLU5iTTtCHniBQ5cwO/S4FhTllQeSR2trOsH6yTr5j2NWii?=
 =?us-ascii?Q?Hg/eMg1OF3YDiwgWLPMAS9twcd/G6epoiAoWfnDJzD75vxPv9FUATAn3tBjf?=
 =?us-ascii?Q?CfONLPqHv+MJbZplqJS1N/sAAN61ou6le3M7qHh6qwyitki31mIMYkxxYzEe?=
 =?us-ascii?Q?1wRZ2Mb/q7knrYEobhwPjGot+eCEP+yvHY1gwysyc4ckh5/LrrvKv0OVcWvH?=
 =?us-ascii?Q?Ttl9paIC+tD9QJ+IxcBzsX/vKTx14xWpoQ+x6nH1wgTtmOiAXO8lNh7gx4BI?=
 =?us-ascii?Q?l4o4jocHDMlqwilx4V0QwthQPeuElBGMHUdorRDPoIQ9OWTgV7fpwM1LGmO8?=
 =?us-ascii?Q?h8RBEGG/suc/WJJ1bwXP/gU4fA+Yw7TRiGwCYrM//qAnzdqNsc3tqUDF/Mjp?=
 =?us-ascii?Q?065UMEt+1VYP3jK/O1gMscvn/4ntnZp/ZZNHa21nf8U4IU/7l0VCkN+c1P0z?=
 =?us-ascii?Q?88QDcYg+2fQ0jK89aEh3PzgKpNUO6CLsTRD0g9hUfvbC9Cc7MYkY+CvdSdcH?=
 =?us-ascii?Q?OXpC9A03iHHuK9hVt50emnqyvqzTRfNM8OdbWXuXUbmdWArr4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:00:01.0572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 630a449e-dcf0-477d-6ac9-08dcf9abee42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

After adding HWS support in a separate folder, moving all the SWS
code into its own folder as well.
Now SWS and HWS implementation are located in their appropriate
folders:
 - steering/sws/
 - steering/hws/

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  | 33 +++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  2 +-
 .../ethernet/mellanox/mlx5/core/lib/smfs.h    |  4 +--
 .../mlx5/core/steering/{ => sws}/dr_action.c  |  0
 .../mlx5/core/steering/{ => sws}/dr_arg.c     |  0
 .../mlx5/core/steering/{ => sws}/dr_buddy.c   |  0
 .../mlx5/core/steering/{ => sws}/dr_cmd.c     |  0
 .../mlx5/core/steering/{ => sws}/dr_dbg.c     |  0
 .../mlx5/core/steering/{ => sws}/dr_dbg.h     |  0
 .../mlx5/core/steering/{ => sws}/dr_definer.c |  0
 .../mlx5/core/steering/{ => sws}/dr_domain.c  |  0
 .../mlx5/core/steering/{ => sws}/dr_fw.c      |  0
 .../core/steering/{ => sws}/dr_icm_pool.c     |  0
 .../mlx5/core/steering/{ => sws}/dr_matcher.c |  0
 .../mlx5/core/steering/{ => sws}/dr_ptrn.c    |  0
 .../mlx5/core/steering/{ => sws}/dr_rule.c    |  0
 .../mlx5/core/steering/{ => sws}/dr_send.c    |  0
 .../mlx5/core/steering/{ => sws}/dr_ste.c     |  0
 .../mlx5/core/steering/{ => sws}/dr_ste.h     |  0
 .../mlx5/core/steering/{ => sws}/dr_ste_v0.c  |  0
 .../mlx5/core/steering/{ => sws}/dr_ste_v1.c  |  0
 .../mlx5/core/steering/{ => sws}/dr_ste_v1.h  |  0
 .../mlx5/core/steering/{ => sws}/dr_ste_v2.c  |  0
 .../mlx5/core/steering/{ => sws}/dr_table.c   |  0
 .../mlx5/core/steering/{ => sws}/dr_types.h   |  0
 .../mlx5/core/steering/{ => sws}/fs_dr.c      |  0
 .../mlx5/core/steering/{ => sws}/fs_dr.h      |  0
 .../core/steering/{ => sws}/mlx5_ifc_dr.h     |  0
 .../steering/{ => sws}/mlx5_ifc_dr_ste_v1.h   |  0
 .../mlx5/core/steering/{ => sws}/mlx5dr.h     |  0
 30 files changed, 26 insertions(+), 13 deletions(-)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_action.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_arg.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_buddy.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_cmd.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_dbg.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_dbg.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_definer.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_domain.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_fw.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_icm_pool.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_matcher.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ptrn.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_rule.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_send.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste_v0.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste_v1.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste_v1.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste_v2.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_table.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_types.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/fs_dr.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/fs_dr.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/mlx5_ifc_dr.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/mlx5_ifc_dr_ste_v1.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/mlx5dr.h (100%)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 5912f7e614f9..42411fe772ab 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -109,16 +109,29 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/dr_domain.o steering/dr_table.o \
-					steering/dr_matcher.o steering/dr_rule.o \
-					steering/dr_icm_pool.o steering/dr_buddy.o \
-					steering/dr_ste.o steering/dr_send.o \
-					steering/dr_ste_v0.o steering/dr_ste_v1.o \
-					steering/dr_ste_v2.o \
-					steering/dr_cmd.o steering/dr_fw.o \
-					steering/dr_action.o steering/fs_dr.o \
-					steering/dr_definer.o steering/dr_ptrn.o \
-					steering/dr_arg.o steering/dr_dbg.o lib/smfs.o
+#
+# SW Steering
+#
+mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/sws/dr_domain.o \
+					steering/sws/dr_table.o \
+					steering/sws/dr_matcher.o \
+					steering/sws/dr_rule.o \
+					steering/sws/dr_icm_pool.o \
+					steering/sws/dr_buddy.o \
+					steering/sws/dr_ste.o \
+					steering/sws/dr_send.o \
+					steering/sws/dr_ste_v0.o \
+					steering/sws/dr_ste_v1.o \
+					steering/sws/dr_ste_v2.o \
+					steering/sws/dr_cmd.o \
+					steering/sws/dr_fw.o \
+					steering/sws/dr_action.o \
+					steering/sws/dr_definer.o \
+					steering/sws/dr_ptrn.o \
+					steering/sws/dr_arg.o \
+					steering/sws/dr_dbg.o \
+					steering/sws/fs_dr.o \
+					lib/smfs.o
 
 #
 # HW Steering
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index b30976627c6b..bad2df0715ec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -37,7 +37,7 @@
 #include <linux/mlx5/fs.h>
 #include <linux/rhashtable.h>
 #include <linux/llist.h>
-#include <steering/fs_dr.h>
+#include <steering/sws/fs_dr.h>
 
 #define FDB_TC_MAX_CHAIN 3
 #define FDB_FT_CHAIN (FDB_TC_MAX_CHAIN + 1)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/smfs.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/smfs.h
index 452d0df339ac..404f3d4b6380 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/smfs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/smfs.h
@@ -4,8 +4,8 @@
 #ifndef __MLX5_LIB_SMFS_H__
 #define __MLX5_LIB_SMFS_H__
 
-#include "steering/mlx5dr.h"
-#include "steering/dr_types.h"
+#include "steering/sws/mlx5dr.h"
+#include "steering/sws/dr_types.h"
 
 struct mlx5dr_matcher *
 mlx5_smfs_matcher_create(struct mlx5dr_table *table, u32 priority, struct mlx5_flow_spec *spec);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_action.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_action.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_arg.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_arg.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_buddy.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_buddy.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_buddy.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_buddy.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_cmd.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_cmd.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_dbg.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.h
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_definer.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_definer.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_definer.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_fw.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_fw.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_fw.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_fw.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_icm_pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_icm_pool.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_icm_pool.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_icm_pool.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_matcher.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_matcher.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_matcher.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ptrn.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ptrn.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ptrn.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ptrn.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_rule.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_rule.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_send.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v0.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v0.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v1.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v2.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v2.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_table.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_table.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_table.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_table.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_types.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_types.h
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.c
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.c
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.h
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5_ifc_dr.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5_ifc_dr.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5_ifc_dr.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5_ifc_dr.h
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5_ifc_dr_ste_v1.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5_ifc_dr_ste_v1.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5_ifc_dr_ste_v1.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5_ifc_dr_ste_v1.h
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h
-- 
2.44.0


