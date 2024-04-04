Return-Path: <netdev+bounces-84966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B48898D44
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 19:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EAC11C22700
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA2071734;
	Thu,  4 Apr 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a+hUIC6z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE851F61C
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252084; cv=fail; b=LDsUZ056KySv75CUEKxEuP0YPfaeGNDacx78aTALWNCrtRbu65TEpv9W/lI36M0UnDv0mPJo4xSgpmEsWGIbTiRnW3KeNmPtmNx6yoa/wu+7niZS8ovDii3RX9jh6ndO+z/1m0h7xN3rXXmfqm6/ccTqiNT7e6zbNRfAIG8vLwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252084; c=relaxed/simple;
	bh=mduW4tpT4PwQxYWEX5IESrdqG1HTe6A6hB3YnjV51yM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a+LH6yTTzXFBuKonmmcLWk695N+P9B9PGJedXaV+e4NwiTIKkew/eHpT8sCy+0NTGkgrcWtLXzi31Iw7vPLIOxw9T4NIVuO4gXu+3nKe1Hdgiu8YNl+06dh0yBl+Eo4OLWpGo1XHGGsN4an5za+kYw/dR5jkvF6gz85o5MxPgAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a+hUIC6z; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTsCoqgsG16ZwMzhgtEg/fWcnGX2M2eSTBdOhlV6+9+B84PPjpFPgFFbLKNfRD3Y2O90HSd4z9CVzcy5dlZUNCka3CijXz00V7/hAB3YFzorRE8GzLXLj8ije9vjI5846KlyffC83L+/uKkwZXW5FT1mX/EcMta+tzdI/hqqdojKd04+TQsvSDC8V5LJC/U2ui9D01dKj++L8EvuvKOD8k7MXnl0gACd7eubkJQ0A/WRsIKbvF9r0pNMzRaJJa4UIArticEj1cP/Uv3lQZGGImTv0ORIVKfHE/Q8+VfpuxbkyVezoV2peni+swxwORHhWyXZlxmLEGZoY/qmZXmWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpncNIUnz846pxEjeoqpwUf0gKGwRxJeP7ZvYU3KseQ=;
 b=NWpC+HBarRt26vp+aCoHrPK8N5lEJ9yRZ4BNWWu/P4oN/gPGMEE5I3rcvGERRFs3D9ZaYrHVj5sXk6fvWOx12sdCWarkGOOXff2oiSSuW0sUITfIvD5TjI2mKSDtrV+HP/7hojT0UDVs74MMvr3ID/YT4+SfkcUgNxOZ9q+SqljpPf3kwy7fpmu2y2eNQnOnsXqC47nkCYtsqnZ8ShIGaBFcGfHdWyzKjBF00XCqQR024VnRYcx1ErUw5AtxTxSPNAakxbpL/6xg8pxmmYIsbWT/9jrcJcxRhZwVG46PYbk1GfJYfvojSbcvvFkKqmvPMDorIjiIjeTo7NSN+ux0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpncNIUnz846pxEjeoqpwUf0gKGwRxJeP7ZvYU3KseQ=;
 b=a+hUIC6zVWqwjZPw5OEibW+AzHXDL31Z6tQ9pCUwIaF4iz5S9we4lpE/WYB0TrmvmhuR7aFhQPXHsvPG/Yg4EiBTkL94RSG6vBbkf+qDiw5TE1sgtRvIPWK0Sbn9lVEkuzjVFpnJormtCiXfW5JfOabuS17D59bfTBAIT+HoX6AesPZWJLo1BWyvRvzp84NrYaUYjcMAmotv8VhXeo5NNC2ZpDSCjguCLcO8dZsoaa2MF/u1S9B8m17huR1IN7EJp7fEy9QJLpIDPN+BGVwy4JkE0TaYRid20YiiPE7Ot7BQE8P4aqLB3K9M7n6b+i08e6bY3+KNouaQOkSloBlmaA==
Received: from MW4PR03CA0314.namprd03.prod.outlook.com (2603:10b6:303:dd::19)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 17:34:36 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:dd:cafe::ff) by MW4PR03CA0314.outlook.office365.com
 (2603:10b6:303:dd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 4 Apr 2024 17:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 17:34:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Apr 2024
 10:34:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 4 Apr
 2024 10:34:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Thu, 4 Apr
 2024 10:34:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 0/5] mlx5e rc2 misc patches
Date: Thu, 4 Apr 2024 20:33:52 +0300
Message-ID: <20240404173357.123307-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c83b65c-8105-4cc1-f3e0-08dc54cd7eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1gCS0vRAsc/LzR+wNTDhnbkRzJTZ9Ky20ljco3mjZXmbbLgxzyKm2klFvAfs7M7I5oUmFjscLd5N8OmXh+wUx8N0Wy7LoAB2x10fjetUu7WD5fxa+iCEMHHDXZKoHpe0QH0rbNrsJJcf50HY3XSI1KAvyUFuaIwBNIwnOu7anZCDar3v/e+bRDWXPE8ag+4NXZsv3IdE0jmKbw8LA0YHp5bTHWGJGNDUZCb66NxZQF/kupQbCpSgEamIMwfOGrhX+9piQR1psazPhAv6As3O3uXf4tnM4d7cGBzw030NvaNUyYQbROEgj1WaF2uV0ojRqW0wtm13sLxbmK55a8fAtuZwtLIPFSv+LIoOgJpUB+po7c2jFNl/o7bMBZF9iAY+i3q8f47e0DZd0AqW2noMvgu2kzdYuWrNiIaBVa5wIK6qVn4O1fIJZEhn/XRNwhUzqtLgJ6n8mKy5d0uZO4byKe56NZY0ZiZfR3wWBynibu+fWWNbzLeUVAoWzpY6ocDn0phk+waoGkmzOKleZy5I57asAlW7OnHmOZu2uMKJ8hjkdEsGpfshLmugKvz+UlROhna6+LYDwhCqIJDL7D8LCyigUtFdDbRugkXuYr+P/ZmuTAJ+j09pGx07dIEm/JrPypK/896S8Q9vp1C0NLjdhvl1FoIG5apAZWVf90HqYWsm1XVh+yZwQlrrKk6uI5CGcKknvvC5FVjibgsmBaQ8F3+f+WXPQlOkdqkZj991a0SHoDNnPeiDLvsnH3K0x75t
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 17:34:34.8956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c83b65c-8105-4cc1-f3e0-08dc54cd7eb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184

Hi,

This patchset includes small features and a cleanup for the mlx5e driver.

Patches 1-2 by Cosmin implements FEC settings for 100G/lane modes.

Patch 3-4 by Carolina adds generic rep-port ethtool stats group and implements
an mlx5e counter that exposes RX packet drops of VFs/SFs on their representor.

Patch 5 is a simple cleanup.

Series generated against:
commit 57a03d83f229 ("Merge branch 'mlxsw-preparations-for-improving-performance'")

Thanks,
Tariq.

Carolina Jubran (2):
  ethtool: add interface to read representor Rx statistics
  net/mlx5e: Expose the VF/SF RX drop counter on the representor

Cosmin Ratiu (2):
  net/mlx5e: Extract checking of FEC support for a link mode
  net/mlx5e: Support FEC settings for 100G/lane modes

Tariq Toukan (1):
  net/mlx5e: Un-expose functions in en.h

 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 12 -----
 .../net/ethernet/mellanox/mlx5/core/en/port.c | 50 ++++++++++++++++---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 22 ++++----
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 48 ++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  3 ++
 include/linux/ethtool.h                       | 16 ++++++
 include/linux/mlx5/mlx5_ifc.h                 | 20 +++++++-
 include/uapi/linux/ethtool.h                  |  2 +
 include/uapi/linux/ethtool_netlink.h          | 10 ++++
 net/ethtool/netlink.h                         |  1 +
 net/ethtool/stats.c                           | 31 ++++++++++++
 net/ethtool/strset.c                          |  5 ++
 13 files changed, 190 insertions(+), 32 deletions(-)

-- 
2.44.0


