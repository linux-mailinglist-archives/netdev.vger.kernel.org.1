Return-Path: <netdev+bounces-86245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CECE89E30D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EE71C21939
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72623157A60;
	Tue,  9 Apr 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LyM4b/uO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C8157A5D
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689761; cv=fail; b=Z3KX2ZQAWAQohAJLDTokUtBsAJ5+t7GmQ9EZ6FBFgtl6gqpISxnp3tmgnIS5kDSSi3vX0sAjFPRRwQ6+vdcavT/UVSr5PH0bUMZD/eChA7pxwnKFL58uRKRT1OjtRHG83bShXKUSyN4LBY7cMVvNpV0hHDWD09MwWlVZjkn0OsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689761; c=relaxed/simple;
	bh=waBp2CIJFpkfiPH7RwQcCTuGx/KZZaHE8vE06GdMJRU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TgE1PdoXL2DNZ1VSLkfryYRXmi7TvQ89MdqXUqsd/JXmfn9SiNtC4JvHz8kKzjE+yeFBh4kfjHczQNfTYMa/mMuUIsaUMNx5zX1YRrkxfEw34ZVOw8ElNjUmUP7gdP9Iw/gnXymbK2g9bZpJdnpzTub8hWf1NAJvYEyqKMHEcls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LyM4b/uO; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PELtxGoDJUlbRdxAFMFDsCftsGfE3bjAW5MJ6+vhT1n5R/8SiePKHmGrDzogrGaDq0ZuJDrqtAg38t+CiFaiYC+W+FQk8mstVo2Roh78GBG/8ovS+Mp7PX64WaNQV2ktHzyfFqNFIJTHPHbxOd0rrwCpXdRtAAvhdG8paVQsmO70G2z24zuQUS2ebr06dbb4ttETlYm62bNfkE1W8/zWixTSKXl7hL2mi+yOFuILO4hdcsDgKUWD3zJcIj3G6qHeb1Mc6gT/EyKHVDt+d7lsUzjsdQHd32zQQxJZ8EY7BIsL1xf6lrN/I61XGpBGgBtfjwCPIiz1nAGlJ/ZsO3wblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYzrOlrrLbxgZDc1gWbS+/4xPQLWK9s253iL4wwo3Qo=;
 b=hQMuyw0eexeiWwxQl3kVgw+hFNWroG5cy3r0pEgNhSFxD3bpfyVm3ZvO0Z6bzTHMRSseayOShoOP4yII2++jPLAnNztcYg6N3qiC2EobmpapzHgjaabt+mSsi4JFyYdvm+37LvK4yioDio5vtPIZtYIVB/lLAsa0nUjTxFua3x5GatuQXI/ERcwIJKCyJjtsd20485O6ANWCXq3nHlX/hkxb/YkSueniPEBy64lY6rqW9VrWTG2KuL/HtzC76IKaA42gMzXXJm7TupkW/+A+7qoFYvGA5KK3LHwTpDJxJ+Th4MqyYE2BKPxMdltfYelBrUsuyauCHXxz0fIJqwzM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYzrOlrrLbxgZDc1gWbS+/4xPQLWK9s253iL4wwo3Qo=;
 b=LyM4b/uOT9wKRjaTNKDbjdjrxHV7SCmzB1VwwjUInp6RUZgnSFRJczO5tGZgWU2XC1+B1PUw5/Q2/8PC+a4etiwOoQ2my50cA5OmxQxu1OhrnUfdsgHxvikxILOvkRz/lhNGgz4hDj340SBoC8CPk9XCAZa0r0lPVyG42rECxVGfgeT0r5woubr3juLXit4NmwvOTUZLasoXp2g3ALZOB35XT7q/KxKkL9UzWXFQ4HAt9F9Csq43KZAzOC/aFZXl+0Qsifm6JKowzFARemBYIez6uT63GXhsyuw7Zvz9ZQdfa4598fBdsbgw2Ow2Rp3+cQzrOQL2aiyp9yXUsPHalQ==
Received: from BY5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:1d0::25)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 19:09:15 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::d2) by BY5PR04CA0015.outlook.office365.com
 (2603:10b6:a03:1d0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Tue, 9 Apr 2024 19:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 19:09:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:08:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 12:08:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 9 Apr
 2024 12:08:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 00/12] mlx5 misc fixes
Date: Tue, 9 Apr 2024 22:08:08 +0300
Message-ID: <20240409190820.227554-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de4191f-0480-4982-0aeb-08dc58c88c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gVr8mpQLEwxBestH7ALmiwS+LZqTBFQe5wYGIw8/x3Z0NvBdTJZmv7RSM0TSXeY8BYudzo4utCAWV3vRasGb2ago4X+j3M7t6VBy3qdFsEoHzBI4xu/QyRQrFPgRcc9OBcitAY+OLhzJkdwhcuH6fekfWISKwNXwCaYqihSiu/COZ7ubPYzaBgOFo9qdoOX/UubtrujBQIknzC8ZWTNd7ZdHWam5P8baPVg9dCRD+bUChS2TmOHJWdPkvxZwBlIXBkBFkl+qnPFNNQQKtLmmE+g4TZYvM/KCvv6K2p2fFUQN41Fgrzp3C5zz7ob/lt26XMRUto8WrcKqHVXB3gt4U/iz2DhCrOlZNdMzgwJAPqIo1alJ5aUcJUA6gqRSQgJqnoUkpO64ULJH+xPJa/vUGBjyYqTXk/nbmBnBsjF5Y7ZH7QqYcY6GHBFLUqCE0CqEku64WPhSMZr4CRJieazV0ZnJtKLkyuS0a/CBqD3VyFmYuwaAPbqsjniMIWheLsgOh36lbUx5c3b0ugA5Iymbr5cq/9J3O4XStJ8nGVL8og4m2V8j5yzzdFc4w5q8YfCkoO7KUaIJ0beCzILSnBGT+hrWtppvcx+CG1tz5gTYy0VCzLUbOtgsdU1/7cALB8lYUG68hDfIm65foGJxMJ4jhvgRJA2ezXQJVKUKX9eLYlhGQ0fJ4tgC5x5CzpnY2LBxmKNj3rAE70oSMVcMx2CsyZfuJ37jqBfAlwYYk/9HiICJ/FeaePW6wM00E6a+UWp1
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:09:14.9226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de4191f-0480-4982-0aeb-08dc58c88c54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346

Hi,

This patchset provides bug fixes to mlx5 driver.

This is V2 of the series previously submitted as PR by Saeed:
https://lore.kernel.org/netdev/20240326144646.2078893-1-saeed@kernel.org/T/

Series generated against:
commit 237f3cf13b20 ("xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING")

Thanks,
Tariq.

V2:
- Updated patchset #6 per Jakub's comments.
- Added two multi-PF (socket-direct) fixes.

Carolina Jubran (4):
  net/mlx5e: RSS, Block changing channels number when RXFH is configured
  net/mlx5e: Fix mlx5e_priv_init() cleanup flow
  net/mlx5e: HTB, Fix inconsistencies with QoS SQs number
  net/mlx5e: RSS, Block XOR hash with over 128 channels

Cosmin Ratiu (2):
  net/mlx5: Properly link new fs rules into the tree
  net/mlx5: Correctly compare pkt reformat ids

Michael Liang (1):
  net/mlx5: offset comp irq index in name by one

Rahul Rameshbabu (1):
  net/mlx5e: Do not produce metadata freelist entries in Tx port ts WQE
    xmit

Shay Drory (2):
  net/mlx5: E-switch, store eswitch pointer before registering
    devlink_param
  net/mlx5: Register devlink first under devlink lock

Tariq Toukan (2):
  net/mlx5: Disallow SRIOV switchdev mode when in multi-PF netdev
  net/mlx5: SD, Handle possible devcom ERR_PTR

 .../net/ethernet/mellanox/mlx5/core/en/ptp.h  |  8 +++-
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  | 33 +++++++-------
 .../net/ethernet/mellanox/mlx5/core/en/rqt.c  |  7 +++
 .../net/ethernet/mellanox/mlx5/core/en/rqt.h  |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/selq.c |  2 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 45 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 -
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  7 ++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  9 ++--
 .../mellanox/mlx5/core/eswitch_offloads.c     | 11 +++++
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 17 +++++--
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  4 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    | 37 ++++++++-------
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  4 +-
 .../mellanox/mlx5/core/sf/dev/driver.c        |  1 -
 15 files changed, 133 insertions(+), 55 deletions(-)

-- 
2.44.0


