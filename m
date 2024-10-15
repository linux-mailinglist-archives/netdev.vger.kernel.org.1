Return-Path: <netdev+bounces-135513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1425C99E2D6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE89C2839D1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483D91D9A5E;
	Tue, 15 Oct 2024 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="loE4PFx2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9B1BF2B
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984788; cv=fail; b=mzRWkQTTSb0OiO1NtjWnzSdiMGfCH4siReUMDCnz9klOV+NhF0qfmqcMecwb/X8W0T+MQewCt5hyuEOd/Spro296t9u2gbc/Ro8Kxt3bwNf4eZZKMhuYu/D2d45jExKMQLIfcmsbZIgy81iy1301PEoP51upuhx65esQXTYjtkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984788; c=relaxed/simple;
	bh=e6f/yQefTBLo+FsG3jit9kIUP3jqVrOcxOir2T72iNY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kgTh1meoRWbnM2U3MTzRNOp+ufAfarO46SlNLQ33Or0X36fS8BO0nLPihFuCZKKB/FAr/i3eC5oz8mcckcEnxU/O5oQCRZzTA7KVr+fYAON+l5qxS4YQxC89DPtozbOwmiY3prmXi/g0dEmCk5TMMmhyT5pblR6OpJRWvltJrUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=loE4PFx2; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQcMrxioetjGGgRO1hNlmx5cmF4AgVQp3bVUhpPbREtx56E2yipTUngPV4lrFdeygSxbFTBoOq6MQBRPGcYO37/iDY0FudmlY71u5ztVK8T6J4ihAaZX41XW6ue6w9BUch21ipSs87qiKqZf5c01RuJJx8UrsiH0k6MP48OzanT2OYmc0yN/M0luK8IFlhiqQK7tgVeqDgKP+E1icEauIa4TvLyGh4HP8fzDxB2XKRjrTtxZiHDCAKPSwHzhvfoHSEnuHyzRq17HaEFtznoWs2PDlHqf06sKEshgNRxFpOVd4+QbwdZHFOph1U2VJweqOSWr7Ukg31Tld9VBIN4hhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UE84fNSGe9SAEtuGsa7LqrhYbBdwYt/vSH4j2TuUjr4=;
 b=aHoH2YeOYfheWsTS4qkqUd10dVxvph+45vKWgGoQ50nQQ8S6u3bzdF/twJTAX8rG7tV5YCztu8PuOYG+98Ntl85TplJk6SYXQXpOpplxxYiDoh0lxsYrenKoZFWBj9YenWF4e/R0wuI3kfy0RXR5OBM4K09GZdTUA02xPDi5uAoHCBTmZm4+6z2vs1be3mfJiIu4I5PSMm5PMi1xe1Vs30+lpIx1UK5HdSPuQxFvauueBvQYfAIYTd64btrTeRve9PpAh9HQWUYSoMTjrUfBhJkjH58MxBUu4Y5yr7YWdoOn9+lfUA0xA2BVnFV9tLxFfD6Z1ilR6e9QPtpbRuYuxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE84fNSGe9SAEtuGsa7LqrhYbBdwYt/vSH4j2TuUjr4=;
 b=loE4PFx2v8WecV7hGSLkBx/nnEjfqyo/WJTQdRc6guAJORVFYBRFZv6AtJfTzHoO/tpdUTnOUaZvcDdtG74X4/LSk4VwWT+8iue+bW0UkCGACJS6FvCPSHSein1IgaAddQBpp0pI4XvT+T9SnQ9hxX3LkWS/3mqA9DdNs73Es+cNz5cUlYerWBJuyTLwnmOJF9EOb3SYPO+4OFdJAG7oB8BYAMxMpWk/XMrJRzxjHCHP7QdMagn/gXL9LIv51n3W3zIxn4e3f6hICUBLA/OeT7OSwd4PzELV3KuI/eNa/7GJMy+E7pFRwrpxwOInE8ZCLVSWTve4pSd184QnzuOTcQ==
Received: from BYAPR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:e0::41)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 09:33:03 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::bf) by BYAPR05CA0100.outlook.office365.com
 (2603:10b6:a03:e0::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Tue, 15 Oct 2024 09:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 09:33:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:32:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:32:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 15 Oct
 2024 02:32:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/8] mlx5 misc fixes 2024-10-15
Date: Tue, 15 Oct 2024 12:32:00 +0300
Message-ID: <20241015093208.197603-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e42f49-8f38-4f6c-3d66-08dcecfc5da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wujuad1r72ZyrzciWj/GIvTmHH0WiyxFpGSLQJtk+//aouttk2PhyufozHW5?=
 =?us-ascii?Q?iKLMeFA1HZTy9siVD0yr55CMZ+vQQg4iWPmzt9Y88l4S7thacXnZwBjthVSz?=
 =?us-ascii?Q?yGFzJAXQjE5Pb6AKcAbROJedmMa021lK02+CDlqE0KxwYdHDZz246zK8Hrq0?=
 =?us-ascii?Q?JbKQOWL5ueZst133lbzE+GftEojIsLw5B7ixmGEgexNkBbjtiKKZ9avxA+Ez?=
 =?us-ascii?Q?ULVEDW8Ej46UW9tLxEjOXJ556polfXZRNve23zJ1WB8NOku9c2h4xdQDwTC8?=
 =?us-ascii?Q?0nqsSu8qcjZO0btEdX0O3BZIN/dqYoraqXt2o55gGX0wdt1z0lWq3TfcXzKW?=
 =?us-ascii?Q?S254TMm9Ov24eKK6AjQ7ErrakuGp49s5rNR1bNZBgNEtc5fpJ8UBDYQsCRVy?=
 =?us-ascii?Q?6EgA3KyT/8hKnJy2crrw7ZKi8JaEQHrSGEcmmLEAN1n+WkybOM12oUS0amOQ?=
 =?us-ascii?Q?D22ezVwL6Rhssgeh5wMy3eHvQA+pKRAR92yUkvGe4uo7G57IXE4n8avMJQsW?=
 =?us-ascii?Q?aC1fRU913qcf9pdwQCHbLqoPfJ9PXe8IyPUyVGGSqFXDEuJPfJFrGo6KZTlP?=
 =?us-ascii?Q?AcwkHfkRF8DCk7bm4Zik4aUtJ6n1SBQd91koj7n9e3FaexL3qSlWO18iFDel?=
 =?us-ascii?Q?AsC8ZnFMZbH05K+WOBP0217DBhiRVfBI3odXum0v/CFJReCl9gJrnC4ZZYDN?=
 =?us-ascii?Q?zoxE+1unN+6NEjQMg7c34BLQOW+uTFQToiHxC+O07PLx7NroMQKjWv40sTl7?=
 =?us-ascii?Q?tMOc5hgC/U4yhqJo3H4FzBPtvQBQ/hSM1hkvkWFc0WYwKd3dQf3JC6wxfWAO?=
 =?us-ascii?Q?tTunEI/xaR+8a5odUcTjbiVPMdmbj9Hadavbs0afL/4J0m4TphCq53tn4oAS?=
 =?us-ascii?Q?0s9XuX+TSg22DsOoI4KhiekZzzI7+vTl4xtmdZtkP+b8M0ByzjbXpv1rJuYp?=
 =?us-ascii?Q?TF/Q6pFvgqO7X1GoZSTM7qxYYQwFFabSaam0lPznbTh5bJgfpMVeVIH1v/JX?=
 =?us-ascii?Q?kw/v7JxbtB4o1jpMeW4kODNIrBxVNptoqQZ2is9DVQ1DPdeB8zfQRigkrbGs?=
 =?us-ascii?Q?WpIESXdLPmeAGeJFvR1UcCviFLY9OxaB0FEdmLfZ3LaIs2Nld0qf+ZhrSnfa?=
 =?us-ascii?Q?lTizmInicidnWNSl+PUzrIn44iM9cYC+6WbvUIPqyuoasFF+5DVQ0q1bojaQ?=
 =?us-ascii?Q?9otNsa9+zUeqLcB5HQoRq7I9IrVLoOeiKk2pNiiNMJXEZwaBwgDSRIKZqic/?=
 =?us-ascii?Q?O3JZIZfopEKiKAMiSmTbTBQMn+VvRF2OLMd+EQf0bL0V7o5SPCoRAgr3tmT2?=
 =?us-ascii?Q?qMPFv+A+zyXx/uiBK8pZG5xkawPHomZ1vRDX+S7WgFEdYK8BHpd4MNqOIzCu?=
 =?us-ascii?Q?gRonivVt0OY09ih1rNsetOiu9GL3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:33:02.5294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e42f49-8f38-4f6c-3d66-08dcecfc5da6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Series generated against:
commit 174714f0e505 ("selftests: drivers: net: fix name not defined")

Thanks,
Tariq.


Cosmin Ratiu (4):
  net/mlx5: HWS, don't destroy more bwc queue locks than allocated
  net/mlx5: HWS, use lock classes for bwc locks
  net/mlx5: Unregister notifier on eswitch init failure
  net/mlx5e: Don't call cleanup on profile rollback failure

Maher Sanalla (1):
  net/mlx5: Check for invalid vector index on EQ creation

Shay Drory (1):
  net/mlx5: Fix command bitmask initialization

Yevgeny Kliteynik (2):
  net/mlx5: HWS, removed wrong access to a number of rules variable
  net/mlx5: HWS, fixed double free in error flow of definer layout

 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  8 +++++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +++-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  |  6 +++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  5 +++--
 .../mlx5/core/steering/hws/mlx5hws_bwc.c      |  4 +---
 .../mlx5/core/steering/hws/mlx5hws_context.h  |  1 +
 .../mlx5/core/steering/hws/mlx5hws_definer.c  |  4 ++--
 .../mlx5/core/steering/hws/mlx5hws_send.c     | 22 ++++++++++++++++---
 8 files changed, 41 insertions(+), 13 deletions(-)

-- 
2.44.0


