Return-Path: <netdev+bounces-107412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D53BF91AEB8
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B722B252B8
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB0219AA53;
	Thu, 27 Jun 2024 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dBCosMJm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6634F19CCF2
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511461; cv=fail; b=rYeuF5Nte46NQAk/sm1XG3ioTvw6AqslKToqly8Meu504+C52iUWku8n1qLFdniKMMVjGz4wA3Pi6yqFoOLSBXrOrl+NB/jsGcl7ekSUPbVVldqMUETVHmEdVhKWoPkWwFStkRY2+uJ0kkJXbG8oMZTnaxwTzMghcnlW3T4+IgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511461; c=relaxed/simple;
	bh=MA8cFgriOiA+hfvHDdRKLEbBijMbLUMpshqnysmifl0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BxsZsd3x6cfpP29dgJEU3rR3lTvrKLhcmBDUZzRuGM0d2oCM/2XyRVk8eWftBHs7JyMvpARhIa40hCJ5kjC822CvzM93mjKSOsSbHf9suZ4tg+Z3QnKV7Emp5ohSLNkdK6Exsv7TN3ZypYF0fNebk4BlVc43GJJA8QM+bNfVTs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dBCosMJm; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLHlWPPNdbBbOj7/E7uBbdLJsaLKcUDdAvIMjHmU6m7Val2cJBGjXmJfZSkVBhPlOy+vfcD2efgTA6/IB7wLcVZAfHyR7esnaucKgjY/50v2Dw47phYiDdo7vns58PlKgbRene43YxDWFvWBtADH4Oyaef1uIRDbM9PDb3kBw4pWxW9EXILyv3oKQdA4+4EwnMG7iv+f6xjTpEfkJPRL50OfDHrR+W7H8c1L5zKL1QpLESd1/HxjlQt9wa/phohLKoLm49rKrETwDisAE7C6sQYRA6ECvxQdkbH88YjRtRDo6vzUUPJDEd69xTsWQqhAKbfarOYm3V4cj1jqE5FGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MY+Ud7xwcsFDiCinx8O32hW9MLTrTpcU8cWx/aIGtk=;
 b=Jd3lDJ/Ekko5wDNzY0DkWObF4ExdwYk1maI2cF4dx4+jG8i/NVyAVTwphsO6RA73ot0DvYGKZk+oRfeGTlIqCkOf/UqU152o9lrC87ocVh32H7HCyUbHrFXWX/d2YOQToE1gz4h8fNlHkzZmbP6iTkeiMXPe2A2UzMiihTwKWPbPH7CzBs6pCB3waY+JyfFqg8At8qNoACAodLwO7lPZ+Ub6SsdN0wa0Yw7rQFqOVcerL1VKqmP6DsHAP8FmxkVpxZ84A1gTwjqIMB67k5ho/D+ou7+j/wrs4z/dTrMq1+T5xLv/gVUaTcfjeavbcGBg/PbUCaqB0b4pQsMJRGDCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MY+Ud7xwcsFDiCinx8O32hW9MLTrTpcU8cWx/aIGtk=;
 b=dBCosMJmlI1zf/WPYMdXEGqWIafoE/t3r8vvddCjPeY9/vOT8QQ1EVNnrvHU9MuCxcULG1YgvOlapx1SuTyV3ekJ/L1FOCf//pNBgKupUdl1HgstZd4hscIZj0E8fg6XTs6qo2qzjS+HvEEZjgfrWaa4dgVhTcbBaDW2/VWaqJIm4xiEi4y5qoEMzS1sQ8rJEnXhPQzetp1g/mDSgXEOaXVTowOYQcPpnPrT/F3zBnIkJ/HSbixPm8XQH4QCbUBxekVsgQDX400ddMXjU+EDYYADsb5LFjhGhiiLhtwaKaU3NiOWrsOQvjjm2dCcX7UDUKOAcd8pHht8TFl5R9PtEw==
Received: from MN2PR20CA0038.namprd20.prod.outlook.com (2603:10b6:208:235::7)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 18:04:15 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::97) by MN2PR20CA0038.outlook.office365.com
 (2603:10b6:208:235::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 18:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 18:04:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 11:03:50 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 11:03:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Jun 2024 11:03:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 0/7] mlx5 fixes 2024-06-27
Date: Thu, 27 Jun 2024 21:02:33 +0300
Message-ID: <20240627180240.1224975-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: c94078b8-ddbb-4017-d62b-08dc96d38e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/iMIGQOUBKfOtH95FBiEWT8PRV0EecNGOH3ZHHlJEcVW9w97Bz5H6x9RSTkk?=
 =?us-ascii?Q?xd8/QA7bczvGucpzSGujaUcxMyDmL1k5ntbnj1rp/umOT1ZCZxci7+nBgVBX?=
 =?us-ascii?Q?rhT+b1tTQeKyszeIScoivpQmBWApsfJkpZWDxbaOe8XVjuEf648Sp7ni952H?=
 =?us-ascii?Q?yApzEuNApLfhWzZV6YztdRm3bI01S5B1pwzvGGdf2s7Bqd8Fyj+IuKqHwI7M?=
 =?us-ascii?Q?sBcdI5e1iwIiXrYxMorAQufOlCfSPGUnvTqmLpLWp2k7BKrb+hpg1xb0tq5W?=
 =?us-ascii?Q?xK2k18OuEsdBPG5qUhNy5sW30L6mTOb6qJmyFre+zUOpYLTOdnLBIURLx+3+?=
 =?us-ascii?Q?gqgl5/6sv2nk6aRMh2lQ8/hpdxpu0Vw4Vmmyn9CKJcpFBepdCGCaeVmhWdOY?=
 =?us-ascii?Q?6h3eQK1qZS/RRIHzRmstWEoJQ9vBhoz04gaRCRrqtKuBLJ4+sWd1NrYghKWz?=
 =?us-ascii?Q?j8WBob/4XrPqrq2lgRpBUQlAsodLtzcMl6PtUPC/OXpeWZd7uJl8hcNTzm9f?=
 =?us-ascii?Q?mz6ChxFQ1zfUD9KX/iWimND8hGAaEYIJ7MXC8DdR06mAU4TwR10LXf+/1nzh?=
 =?us-ascii?Q?fzX6ADqV7LFAeM0xx2V1gA6+3/b7oRLJhR9oVMKszJj8dV1Mpw+NZXXcwhqa?=
 =?us-ascii?Q?ri6in+3DuTGS0xOwXFXkujlBQwBgDdnNm2qP+PHid0OFzkazH01rv/hy+pX1?=
 =?us-ascii?Q?B/WsnQ1hL/zRR/XhJ5M/pciSc9Ech3htf7P0NHu8SerhKsSfGbYw9Pep0PWo?=
 =?us-ascii?Q?SqdHfBxWp+Mp5/yrNCgInx3/VQHVHHhPDPLs1k4rOHPPBKt+kfJnySaL0ezs?=
 =?us-ascii?Q?hlDE6mTUxHOXBvxFnEcNeyX3BrqwmR0Gfy+bvvW29taBiT5lTC7zARws/CCC?=
 =?us-ascii?Q?f5fYaEeUVKzRauw3MxE/2kemkGzkXVrFphwtw2tj3TjAoN8qYXK2RMZQEVsH?=
 =?us-ascii?Q?wWQIbAm5LxizDpCzYX00Zp+0MW1kIwGNZDLC/yef/hzbi1S+6DNEAMRQgM7T?=
 =?us-ascii?Q?DY2gAqwjfhKl6ThXDBNIWPNHdihnBwsBo5xD2b8Z5ehyBajjOOYqIjbo2ZRO?=
 =?us-ascii?Q?95Ga15//D4EOfrrFHe+jhXGw7pNQyLU8f+U//mnX7m88IE4tI7M4BUNcjb5C?=
 =?us-ascii?Q?w4fgd/D2OxoKW9xiBMUHK/HfMDvAPgDVI0awU8r2mHDX7EvHupvBZs1xFSwX?=
 =?us-ascii?Q?foOmmHiocCV+GXhqUJDLmBBoYZegZuLOdeIFrcwieNFrzfx7NB8Vbh3LhJrr?=
 =?us-ascii?Q?0EBI2z11fn6MsQvYSVQnh+8Obq6ygAWmnJUlKN88rCE4GY9CDMFCTJZkH77G?=
 =?us-ascii?Q?AzmE6ps7AqNXeLQEE+MQ2zmEKKXiW1+ZRlGdIZZ13VFK7S5x1mFWMJohsn/d?=
 =?us-ascii?Q?THnVzqPFXdbpb9mPHBHes1hvAntuZCgm2ATU1ZGob+/dAliTwYyCVeFsg7v1?=
 =?us-ascii?Q?YDGFAEadnTcmJi0GZwh8brP3vTviocJE?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:04:14.4322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c94078b8-ddbb-4017-d62b-08dc96d38e1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259

Hi,

This patchset provides fixes from the team to the mlx5 core and EN
drivers.

The first 3 patches by Daniel replace a buggy cap field with a newly
introduced one.

Patch 4 by Chris de-couples ingress ACL creation from a specific flow,
so it's invoked by other flows if needed.

Patch 5 by Jianbo fixes a possible missing cleanup of QoS objects.

Patches 6 and 7 by Leon fixes IPsec stats logic to better reflect the
traffic.

Series generated against:
commit 02ea312055da ("octeontx2-pf: Fix coverity and klockwork issues in octeon PF driver")

Regards,
Tariq

V2:
Fixed wrong cited SHA in patch 6.

Chris Mi (1):
  net/mlx5: E-switch, Create ingress ACL when needed

Daniel Jurgens (3):
  net/mlx5: IFC updates for changing max EQs
  net/mlx5: Use max_num_eqs_24b capability if set
  net/mlx5: Use max_num_eqs_24b when setting max_io_eqs

Jianbo Liu (1):
  net/mlx5e: Add mqprio_rl cleanup and free in mlx5e_priv_cleanup()

Leon Romanovsky (2):
  net/mlx5e: Present succeeded IPsec SA bytes and packet
  net/mlx5e: Approximate IPsec per-SA payload data bytes count

 .../mellanox/mlx5/core/en_accel/ipsec.c       | 48 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  5 ++
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |  4 +-
 .../mellanox/mlx5/core/esw/acl/ingress_ofld.c | 37 ++++++++++----
 .../mellanox/mlx5/core/eswitch_offloads.c     | 22 +++++++--
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   | 10 ++++
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  4 +-
 include/linux/mlx5/mlx5_ifc.h                 |  6 ++-
 8 files changed, 103 insertions(+), 33 deletions(-)

-- 
2.31.1


