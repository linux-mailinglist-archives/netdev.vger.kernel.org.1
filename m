Return-Path: <netdev+bounces-116701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E95F94B66B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D341F23718
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BF47A724;
	Thu,  8 Aug 2024 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U7PLOJXq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44354623
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096881; cv=fail; b=hwWV6Qp4g3n/a4MNg5ndPh3Mm1NvoUQCRz5tGeHD95ppcyDqXp37Zi65FAtNmBjBTSMtv9s1S0I/9IQ3Qx/mu0RD7Yub6slJO1l/0DTZMUNanEvqzT0EWXXRmhYBRKdC4JnbwQ6WDdeZpiO/TNAMyLCRXi2ff4JN5EJvlhLebNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096881; c=relaxed/simple;
	bh=9LPkdBiljgPaTgHPBl/Yx7CFNV+tKPdld7ajsa1svi8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D7CChU9ack8qCgV0UEY+6M5I4jKMhBqz0PeXlYYNbqt8P5GbZ0cHr/mJUY7LXsr2eTqYJoTpLY40gR8Gi1W0uIy/AbMcYvcp1l32dnVueifm9nasrwqW2pkexMdz+ZXCxPOd3yc2uoQZIit+xsYIWoBznpTbJ/lmR/NS7ZK/QXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U7PLOJXq; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Se4PHaPHPshtHfT72T/RVv+RKSlf+HTDc1Ut4xN8pOHJYGVkq9MSfCAgsVOJznR84COrkFcuI5mPPsql99JKNZRSOx4ktx6q0YDkYGOiqGQYJxLjXLXcn3WZzzyaWur65gcyvXYL9WAyAPuQ/S8qiZT+Kc8XSoAwMl+SYgKei/txcHJQ5pPes9Uimng9a4Z7+NaGjNHyPK02DA3i9BJ1+Qc1FsGgtDaezmAXAK+34fMogJJAqdnwxnfbdtEp3Q91U7XDAJRaUYIJ2ePNQEnYuJKka46m6iS2pITWM6bTzLN94x3EJChnSZPR6Q0kuTYSkvli3eep7iaHaPyGq9F3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e324TDgJ+KS/RVsLliF46AepV7JclSWvf+ZQM/K9dVQ=;
 b=tjiJoWoPzaJxkQQrw6qZgcx5YgvgLAR0bMi/imAcPsiFVfg3JYt3C9SbyyQD8XK3H0ZBjtmMAv85TY3LNXrS1KidM44IikX/fb8TEAMMenSJYCHS9EZ4tp31Le1UXLJCExD31IyLDPtdspBMtoqAClJ06NTdMUQW6e1GQEYmUjxZYmMdH9cPqL8pZBCZ1teK30JqE3TMkqbUTySB7uBWyS2od9seUN0cREu4GCkY4MBR7cEC/KLijQnEiAOyJL9y/7LWBC4WFspHgusxRkgo+aEKzqbAO9uUHOsKyt9Lu4BwvJDk4TiS28ytluXLldRUxBQj/pX9obiABPmHDyihNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e324TDgJ+KS/RVsLliF46AepV7JclSWvf+ZQM/K9dVQ=;
 b=U7PLOJXqlSFfoOd5yNfvDVbGmYBaU24ZyrTCBeC0WA8F46mV32dk+6Uma+utbGQ7rI6Sw9GH4Cd2WOfDkzu6EyOKRm1aTIbmBC+IQ3XUHnGCH8Q4o3dV+GwYdKaQcxxtp9Y120QfjkOayFAiHeQsgoH8Yx/h2elwag8uAgrBcchF+SeUvC2E5wIYnVDgCOATKKs6Cqh5SW68B2RpoWT0nNnYGko6garhfNC08pSS2UrMyKrAmmb2nc6qRcHZBn2ykb+PepjKiF5dwPzl3pjpQ42gkBdCi6wLK0C0nmnLQMBqXnJMBRFJLSZbXQm6qiNWmfLYAktuRspDLHWGLiifpw==
Received: from CH0PR04CA0052.namprd04.prod.outlook.com (2603:10b6:610:77::27)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 06:01:15 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:77:cafe::47) by CH0PR04CA0052.outlook.office365.com
 (2603:10b6:610:77::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Thu, 8 Aug 2024 06:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Thu, 8 Aug 2024 06:01:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 23:01:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 Aug 2024 23:01:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 23:01:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 00/11] mlx5 misc patches 2024-08-08
Date: Thu, 8 Aug 2024 08:59:16 +0300
Message-ID: <20240808055927.2059700-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 13cb9256-c131-4b80-8484-08dcb76f82be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ro9X/Yt/yL99MXOtt8sQhYmQbeRyG55gL16gCgWXkwVcfrM0CY7iprGeOPqx?=
 =?us-ascii?Q?FMmP25sUNHDHQuy6oYUm14b6nBYB8mdjE7+Od9MGC08E4fydeJOGq9uct0IH?=
 =?us-ascii?Q?I3oFux1g30IfekOuM//JLt7qq2urS3P+j7zI/MTB6aMaimQXW9d50OLANBj2?=
 =?us-ascii?Q?MM5qes9AxFYyQ+UGwfvx25VQTflBxV1c2SjEKbphj7OmzJ/jZPFW86faBZ3w?=
 =?us-ascii?Q?5V1ptRyleWnZad1co1gtsi1G47ctqeKOItEPldGKAm3Vb7M4ffQHlfzjeEYp?=
 =?us-ascii?Q?tRAf6PPlvH0qPDdyRBidJyKGHu/S42YSrOnNM2o4AXK51Hl5djDvlHSgoXGt?=
 =?us-ascii?Q?+wyBzAwou1q1wrzEdSwleucyJ1bfq46bRTf+lO2yYvuwOZ/y9IVdvekpfIKJ?=
 =?us-ascii?Q?Vzl2xcnADL6RysZMuDM5PMoHioy6cuQ5X+R3CFdXNFdnx9N1TQu86vAQL+3z?=
 =?us-ascii?Q?tVc0HLM+C11HxOTlSN0t76vuF+w6rAFhcC+ly1VughRW+9nFrJ+MiCx2JO25?=
 =?us-ascii?Q?HOfBQDWR3KiwFFkurINfpx348bqP377+b+RJ3+mPxtTlaH5E1PUFNXy3Z2S9?=
 =?us-ascii?Q?UlqIxtbMtN8gPopyb27SXMwbrAWp83yz++fs/pGp6yfPcngC2oZpYj9xADYq?=
 =?us-ascii?Q?ifAc96U7E5Y0N70GjJDPvEN5e/MSfZywF5XevpUBhG8lj2IaM1R+xRPhVk+R?=
 =?us-ascii?Q?w7npMr66qwKqbxVC7NBgrfogAOb9X8IY0JQkr7b7C9l2WD3PrIrxUtXTKZoS?=
 =?us-ascii?Q?N9NnyE+lmIj3XEJPkwH1jxP/BwcLwsLT1aLjvrq3aJ6xnrFj/BDeo5aJWcng?=
 =?us-ascii?Q?ID1Z4G22uQUFaqoDyrIjUidPWs4qGmENVnaKEG1T9mVWKS6Ex+xsT79B9o6q?=
 =?us-ascii?Q?ckneeIqORo7jT9Kj2BRwaECZzB/xPUKl1Fzqj86i9lw/asatG2qphnECFKOQ?=
 =?us-ascii?Q?sB3vlWM7z12y1kZRUMQeEJISydyE7sERexs2jPGQl/cDz/dybWd70NJ7X70R?=
 =?us-ascii?Q?yDufNerKl7Pz4nTlJffeDNtvN45UYiQc9udAR8Y2BKXyWTBTljSjSHfjsTR+?=
 =?us-ascii?Q?A07E2Ir+bkgRz0oFNKGfPbXOvNaXgLTQOvaPM8OkVvJ/yD1fRlOpIFkWS0Op?=
 =?us-ascii?Q?UhvxqZBxgXV3Iu3IarlIWNAK26PdmLYkN4qN287QoecQ7NE8IyBWNLB+NhRk?=
 =?us-ascii?Q?JM896lRYRZU1Fnh4BdKuwlnWgzz+5ilj9k934rNx+ZNnYUutWSAvME4emDiB?=
 =?us-ascii?Q?0JW67CVPri98VkVDro85fqZOab3YFr4D1sMWCy2Y04G+l9Buy/+1CFZmbt3b?=
 =?us-ascii?Q?twz206ZYsdbQAjxWfdXP+5ZQSiYarCHtVj+OR+MZ24H7KBB0VtcXo0tFnvtN?=
 =?us-ascii?Q?4Q8K7TTruonCsba57IXUQe5YsppdZXl/KSi8grgXXfAOeU2cGiZjws75Kmlf?=
 =?us-ascii?Q?fDJAM37IW1QPV329R8M0TCuXEd6De87j?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:01:14.1294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cb9256-c131-4b80-8484-08dcb76f82be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891

Hi,

This patchset contains multiple enhancements from the team to the mlx5
core and Eth drivers.

Patch #1 by Chris bumps a defined value to permit more devices doing TC
offloads.

Patch #2 by Jianbo adds an IPsec fast-path optimization to replace the
slow async handling.

Patches #3 and #4 by Jianbo add TC offload support for complicated rules
to overcome firmware limitation.

Patch #5 by Gal unifies the access macro to advertised/supported link
modes.

Patches #6 to #9 by Gal adds extack messages in ethtool ops to replace
prints to the kernel log.

Patch #10 by Cosmin switches to using 'update' verb instead of 'replace'
to better reflect the operation.

Patch #11 by Cosmin exposes an update connection tracking operation to
replace the assumed delete+add implementaiton.

Series generated against:
commit eec9de035410 ("Merge branch 'mlx5-ptm-cross-timestamping-support'")

Regards,
Tariq

V2:
- Address dead-code comment by Jakub on patch #6.

Chris Mi (1):
  net/mlx5: E-Switch, Increase max int port number for offload

Cosmin Ratiu (2):
  net/mlx5e: CT: 'update' rules instead of 'replace'
  net/mlx5e: CT: Update connection tracking steering entries

Gal Pressman (5):
  net/mlx5e: Be consistent with bitmap handling of link modes
  net/mlx5e: Use extack in set ringparams callback
  net/mlx5e: Use extack in get coalesce callback
  net/mlx5e: Use extack in set coalesce callback
  net/mlx5e: Use extack in get module eeprom by page callback

Jianbo Liu (3):
  net/mlx5e: Enable remove flow for hard packet limit
  net/mlx5e: TC, Offload rewrite and mirror on tunnel over ovs internal
    port
  net/mlx5e: TC, Offload rewrite and mirror to both internal and
    external dests

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   6 +-
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs.h |   2 +
 .../mellanox/mlx5/core/en/tc/ct_fs_dmfs.c     |  21 +++
 .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     |  26 ++++
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    |  46 +++----
 .../ethernet/mellanox/mlx5/core/en/tc_priv.h  |   1 +
 .../mlx5/core/en_accel/ipsec_offload.c        |   1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  86 +++++++------
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 120 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_tc.h   |   3 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   7 +
 .../mellanox/mlx5/core/ipoib/ethtool.c        |   4 +-
 13 files changed, 253 insertions(+), 74 deletions(-)

-- 
2.44.0


