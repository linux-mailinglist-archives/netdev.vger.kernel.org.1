Return-Path: <netdev+bounces-153617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB28F9F8DCA
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAA916804A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8A07082B;
	Fri, 20 Dec 2024 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f33nFot7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65C1804A
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734682567; cv=fail; b=k2SxD8uMP8spsmfvUOb4dVK+TO399Q8K1J01upfZgpTocRbFhbdau4+IQQMsiZFqf/0KOTSg8xek0srDysU2u5x4cA1xOxqKZqLpcmySTmHrd6iHgEa8wlaSD/ECSodFwlRxMUfkDmzDCeu5egDH7DxhIHVg77XshiQhbnVImSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734682567; c=relaxed/simple;
	bh=cZZ/Ry8VsWv6wFT2j3RI5e44fkK+ZDO4piE0ZCMOSN0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=epiVDXZd1yHcv/c19xibgCQYk6A7TxFV8umfvEYS6IfXkmw6W1Rr4pzEaJ2HHxoRQlM8EczWwODTgMwHeG9zcugQ/jXap9GBy7LUEw+3jFNQQ6SRFVeDsVqiq3K01XCwM5lp4JQRdpyMNhCMt+BezYsDlJSHgWMpDWu2VT2Xq9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f33nFot7; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eET2orDg0brrajhiKMZ8M9dfPZIlVGLSn1NyRoV4Vp87l9oNPkjLFAmjqFY+JJHVsFpdzynALwbY+9txYElcyGKUxcWyjgXoXxl6GM/Ytu9Dtr2xsxjp5wPQ0x87rqgHAW91aLJT608khGSm6JcpO1eaSbIdAnZ/O0Oiw26S2RtrNqsMTBLOyTDORDVYOGseQiMfalu2Gzp1muMWGyf+wR2XUdGRIS7MkuzU3xvBeVjZHrst0AMFL28OtFtZNzaPyt7Mc+qKeXTZVtCzUM/JiW4c4RPzV2ljcRyz82GljjYKa7QLUCWAZ+v0CI571SdICBCbzlumNWtm7arAfNYaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBF2WTmgFWdviYi3OJfT6fFRxjVBeQiYlExGTT1/a4A=;
 b=HE8le44RJM2RMebPmhDEb/SflW2uZMJnQ0A50Fm6SPlRhVbAgsp2DNqYiJWNrzMiQBEEUNee8bPPxSN2Q60u/35WYj3XX86URROJuX3HVx7RA1mf531jixIUzQEzloC0OB8AlRIXSGvyM6tmodj4jvIfT3kiCweQtfw76x8HyX7P4TO1j1AwtkYgPTMGG5BKsjfBygSzThjR7L6Udapkl5uiM1WOtUTWt49P289kk7QHueDxXlxeyHuYGw/q4Ei5H8+dOJfOcVZmENjLofogJakuCD26wgt1wVXP6D+iGIqwXwBHmLIGDH3xUDIhJBrs/ZP9OuHTiYkUa3ppUUNqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBF2WTmgFWdviYi3OJfT6fFRxjVBeQiYlExGTT1/a4A=;
 b=f33nFot7udfLC6ndt39flvJZNaVO6kL2AFNnOgJ+5VZoMfAvhm5gSJ6vsrv9JQQNeQ6h2B7CFRMhBbpcH7PB8Y3vPuLQPhgXbqYIcMbzulGb1xN6fMk46CMFidUCgGEnYjaj0OiPcRc8G9KHi5fBWJEZvtBPxhBYhUqyukt3m8B952zHl6A9hrN69mHn7k+gTleJVHFthO0izUuRBLn7sQWVlPRuTT9DdieprbIqAwSZp1CGupGCqoTrlckqrjrdjELpC4E7WUU/TWICNHEVu04kp2ICMye38wqfmbvVPIaxrcjAit9H5GcLgDbgd+yDSq/Ea7vAA1vSwEgw4yMmOA==
Received: from SA1PR05CA0015.namprd05.prod.outlook.com (2603:10b6:806:2d2::24)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 08:16:00 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::cc) by SA1PR05CA0015.outlook.office365.com
 (2603:10b6:806:2d2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.9 via Frontend Transport; Fri,
 20 Dec 2024 08:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 08:15:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 20 Dec
 2024 00:15:49 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Dec 2024 00:15:49 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Dec 2024 00:15:46 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 0/4] mlx5 misc fixes 2024-12-20
Date: Fri, 20 Dec 2024 10:15:01 +0200
Message-ID: <20241220081505.1286093-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac1ddc2-197d-4180-5287-08dd20ce8971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n6YY+7gn+AIVZI5H8Tr+d3iDMDsIDhq0MqD9gImvx02gk4wu0FTo0HzOlBrk?=
 =?us-ascii?Q?KGleV9oXCxRIZCAyeqRBc0slcByYxOsBRpe8dI5KWveZ3Mj0lkVXrPFsI6uK?=
 =?us-ascii?Q?hnI17r9ZR9zYy7/p3yrixYnufHNq+nlnWkZRLwyfnmurhdyXT3MPDp0pyZEM?=
 =?us-ascii?Q?ydxpFfl1dL7oSQjipYYFsu5ah8mD7ibjYSHH3vKC9yUa7BGxZ5tKM+MsbLx0?=
 =?us-ascii?Q?U6TddMsNiV6d4GH+WqLlc62fEL5pPfXQa9inv7rzWn7t6J5D/4WPJ3WzpSk+?=
 =?us-ascii?Q?hTrHKmD7PipO5qfH2i9i698/TPvgJgStWMDPUk/FxvswgSh/mUI30ACe8oGu?=
 =?us-ascii?Q?U9Clu08SBwhLLgxrYiCrj5qNP99uJPX6UaGzMGrtKDMqCzCQoHMN9BWbOxeT?=
 =?us-ascii?Q?dnvXYK7RWcxXy/Bmb7cFoVmy2u8bNqIjTPH5Q7DDtO8vWD8DXO50nZPBf+UL?=
 =?us-ascii?Q?X/PZiBwHQ9t/eWtDEqGNMfigoUr7MTzf0OLxsCxBY4TdwOYMhdxGk/x+8uPs?=
 =?us-ascii?Q?l72pxtaJJNG6mLyqfk7/UZQiwNhoGWoboHfGEMVOA5T48ME1lcu8hvXib0gp?=
 =?us-ascii?Q?sq9qXIZP0fixB66fao5NOxfTKWbuF+muDahzW92aP1fgeATymZaQCfahE1Pf?=
 =?us-ascii?Q?wOX8KO8vYl2nk8M8aOnDdZLgc1Xtu/2anewzAtKMiHYWDqUVAZKMeOj0RxwR?=
 =?us-ascii?Q?EQoLYjp+pRROOdTtBrXuHYMDFUKtR00N2J7HlDAFLVQOwryz9cR6TdhJvST2?=
 =?us-ascii?Q?xwciwfO8xl/Jxk2h6IcMjsshwP2JV8CCkDDPq0PjnNV2W2ry0ekud2S6gXtJ?=
 =?us-ascii?Q?A4NWDMpf+FGJZddUp/sFO0rsqjnUA+st7T8V9SxrkEmsz+cg6oiHNaC05IhQ?=
 =?us-ascii?Q?qchZCQNtJMfJB+NYWgVoh47zWdD6rwXmgElM++PS7bJ6+DW4P1OAIPf/4IWD?=
 =?us-ascii?Q?76qw0fpqqn67ayzEhi0t2SxTzJHxyR5aMYaG0w7G/gqjfHNbkDaOy8PF+OcO?=
 =?us-ascii?Q?MMqezLWlyhsrbGCx6H0/bvkHLqBNOlQqrrvd0ptJIFe6AEjuUsyBRP6qTxas?=
 =?us-ascii?Q?Wgi2vGVRZE7ahX7I9/3nPY2uetRUkVGmf1n1/+sxRbzCOsodddxcf1+XbTz6?=
 =?us-ascii?Q?pDa3AolKOhThW/ZSEILLQeuZvpo3MGKkTRF+Up+63E//cUQPBTNmwNIX7cik?=
 =?us-ascii?Q?u1RZpBs4SOolbCngjsdcn3L1MOmaZvlSNcHOmgw2JhYrGJ2iHx5RFN8mh2C2?=
 =?us-ascii?Q?GnzAIr8duzozg8K6XeeXUQzBnE7QHt8pI4vVSyxRhaOxxzU8AlAZYgyCd2ep?=
 =?us-ascii?Q?7TcRNI0tRXZEAYxGT6FWZW1Ty9lp+IJ3uDUtG0mJ3WanURUV7faC64DF8u43?=
 =?us-ascii?Q?2GEUaQ0CLSG/HOBt2jErrBJbohRtQebmlmH0iUBZYSS6EvCackF6GYLQEZwn?=
 =?us-ascii?Q?fUKNUxT7mw1GFwYBefQE5gYFsLR3nqYdStNvD8QNRYO1QriRynAdH8eXzD30?=
 =?us-ascii?Q?g0/VHQHNePq0PXY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 08:15:59.6329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac1ddc2-197d-4180-5287-08dd20ce8971
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768

Hi,

This small patchset provides misc bug fixes from the team to the mlx5
core and Eth drivers.

Thanks,
Tariq.


Dragos Tatulea (1):
  net/mlx5e: macsec: Maintain TX SA from encoding_sa

Jianbo Liu (2):
  net/mlx5e: Skip restore TC rules for vport rep without loaded flag
  net/mlx5e: Keep netdev when leave switchdev for devlink set legacy
    only

Shahar Shitrit (1):
  net/mlx5: DR, select MSIX vector 0 for completion queue creation

 .../mellanox/mlx5/core/en_accel/macsec.c      |  4 ++++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 19 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 15 +++++++++++++++
 .../mellanox/mlx5/core/esw/ipsec_fs.c         |  6 +++---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  3 +++
 .../mellanox/mlx5/core/eswitch_offloads.c     |  5 ++---
 .../mellanox/mlx5/core/steering/sws/dr_send.c |  4 +---
 include/linux/mlx5/driver.h                   |  1 +
 8 files changed, 46 insertions(+), 11 deletions(-)


base-commit: b6075c80537558b16ff72861af4c0539c375e11b
-- 
2.45.0


