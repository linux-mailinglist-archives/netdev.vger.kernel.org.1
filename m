Return-Path: <netdev+bounces-134897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE499B89B
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CA21C20D4A
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5FD7A724;
	Sun, 13 Oct 2024 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h8yUx8in"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66B77104
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728801992; cv=fail; b=PIueTZZwfiuZN80aZQn15v2p89hv8pNnmTxdu+RGLp/SElO9KhmaiSb5my0ek2sEaGOP8s1WMpoycvFXNMXAxYOUQPZh5mJWcQDFOxFKBmOW+7Bwq8CrrRHJgZLR5Ececc92NBwWrrWlZhkI1mu1sqZcRDWUyjKhZOQry2H5f38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728801992; c=relaxed/simple;
	bh=RE2R1SIKZdPxRaatf4+t0scqrf+9XOboc/p7fBckThs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p3uDJlZL/asy4SDLIxA1FLN0pP6O/DUP4xIbCoknALncm5twq/sd2VUPXDzWQM7lFJ3BxAQ7FlCgqaNlb977SSIkFQUhy0/HxkDDv7ZvlGwhd2atqEF1msKPWWBftPNjhi3egoyo6R7d57RBr4B9i0q/B3R0Rk6Xz958xGiOmWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h8yUx8in; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpEW8Ps+Bg2wXSwFT/d1YHAG3V2kneXX20efqySShmLdc4RoTXI5sBOKTKzTQ5gUsYVdHU7UADWYwe+K6YSEK4xHRdJQTqEg7dspVQ7Sikje1DaezZ+Zdv4c0CPw59Bna5lk4XOarJkyfGBNzxYWLvklpV1C5zyPn/RYmHQwgIvJTAGq/o7n1sYBYSxYGtQxd431MeGgE0CK9PRlX9Vrb6Wqo9mq5cA/zzR1qH/wlWpQ80+eTAAy5UuQRlv5nzpap79L0eNwFLvCvy3tAsMT1bUJK1xt2oO/2juvM9q8RimLe5asiR3ONKraBecy7xpLag4M4RYhtHakzqcK0QAY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuKZODEEGIc5U60mhZLA9sZu3RuIualSa6OJItIXDm4=;
 b=HBc1LGQC2/pseJE9QDgeIS5t9O9XHavLNsOP6tTCaQr4NDdbnCxdV1Mv0IAQraMNkz2hPqfLFRbuFXWcYGnwIjGgcw9Jnd10pj6oFuIfwQ4OPBo5lcgpDnrEJMo7D//zGR/sS9xq6iiQLI7aA96v1D/JXg/Aub3SpUsXnuQ9wA5VlngmCwoyx7EedgFtEd2BNhIGAdyF48GYi1IlhFWU9/YYBABrVVFOUUFp95C/CuwJQ8QVsdqIV6dnGkO1OFbLrw72Z8UnYyuOGyuHtuBO1OqQg/Z+TeA47lRM7TkhTj99B5zY3IeusMni1P6sp1kCFASuRiTMJBa7yhYHON6e+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuKZODEEGIc5U60mhZLA9sZu3RuIualSa6OJItIXDm4=;
 b=h8yUx8inu70fhqgPHsNnggAEnP3o8J3qZfpN+4PNnsBd67c9qJX7x3I/bpd3wh5JS8nGnxTpQWmgtiAtRlFbnAHQrUpgl+ZejBjR59osC7U+mVgaljQx+5weQsug4uB6V8cnW2lsuOMQNZxdDi2Xiz+bx5HrCKAsoFXmb/1FUdGNWzTzH/Bz7ACTcYNs4REKTk1C+KI+KWpM9JNRYi415uCkYV6czaEpYA53jFwPp7aF8XlykMvgQC3S++DRgl6VP/RMNvViG53VvFLJrW4rhA107/nDUFpcrjyXoLVxghwEpX7wzlcuQc+QTCG0V6pbkyrNgki/72qq4L5nqGxjgw==
Received: from CH3P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::20)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sun, 13 Oct
 2024 06:46:24 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::3b) by CH3P221CA0025.outlook.office365.com
 (2603:10b6:610:1e7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Sun, 13 Oct 2024 06:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:46:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:15 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 00/15] net/mlx5: Refactor esw QoS to support generalized operations
Date: Sun, 13 Oct 2024 09:45:25 +0300
Message-ID: <20241013064540.170722-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: d0124452-b153-4cfa-8ed2-08dceb52c0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THlNVXg3TFJQS04wT0gzU2FEbmZTWVJSeXZaUm5QVG11U29obzF0YzdrQkRx?=
 =?utf-8?B?djltUUlXRTJ6NDdNdjNxclBsYXFTOFBGSmlwUzJHaVczN21QV0lYbWUwZVhq?=
 =?utf-8?B?akpPYmpUVkg3M282ZXFXTkFwSnM5N2lrd0kreWJKdU9QaGtrZ0h4S0RWWVpJ?=
 =?utf-8?B?akxtVHMrWmI2L1hHV2MrS29VY0NjUU4xb0plajFRd05rL0N6ZTY3MGQzbzhr?=
 =?utf-8?B?b2lHRlhMajRuTVdWYUk5WVplbHhxVENnNzh0MnVRRzhSMFIrQ0ZDd3c5WUdK?=
 =?utf-8?B?akNRYUJzeTFUTVJVdjAyRTZNVnA4TGwybW1kUmI2NW9LcXUzZkNrNDlyWDN0?=
 =?utf-8?B?ZUtheDEzTEJJSklNTWxvZmpWNmZrVXcwRExKMVpjWWR1SVduV2U3V05mNGI1?=
 =?utf-8?B?NTRlbkhKbWJrMHdqMFZCRGJIOUZZRWl1UC9vajFLbmJQNjc0eWJmUVlxWGJV?=
 =?utf-8?B?N2FpMlk3Wi9QS2Z6c2pYOWVqaFdNZWlMcEk2RjVBa0NQaWxyU0U1UWV4K09H?=
 =?utf-8?B?M00zZzBwd3NYKzI0UkFXbWsvTkhESzY5R1M0U1F5bnJTbUxsMlNPbSt2R1k1?=
 =?utf-8?B?K2IrMXBJZWhXTDYxMFJnd0YydFRodGNXNmlIQlVGVnEyWFFCRWtGazJWU3Ju?=
 =?utf-8?B?eEpUUzZSQ0FoNGNRNkZMWWdMOWRYTlZmSWZVQ21GTzdta3VhQmFyNUlrbnBK?=
 =?utf-8?B?VDU3TWVDMm5EL2d3MDl5ckpsWE05UzZYdml3WkZld1p3LzVUMmRUcXl4UVVk?=
 =?utf-8?B?MzlqdlpuQUZENjJzMWhxbCtKREtLZ2VaQ0JpaEJldGxrY0RQL0taTE54K0Jj?=
 =?utf-8?B?RWducmhOZXJYanh5R1N2YWxKTGVWRjVVQjdFUm1zTUduN0ZXZmhwdGJzUk9D?=
 =?utf-8?B?MTVEaXlwREJUQkJkS1FGeTlOVWNJSFFxUVN3YkphK2lrTy9rK2p2OTBURHdU?=
 =?utf-8?B?K0NLU3NnelJnQjlHYytoazR6dzcwTm40OGlUV2h0YXhVRXNYUUVTYzg1aGIv?=
 =?utf-8?B?OEN2SmM4dFo2SWFIQ3BBOW5vK0loaFJkNU9ZWkt3aWJONStrVjZYU2NMVmFZ?=
 =?utf-8?B?N3E5THdTelIzNGs5Z0xzMkNTcVVyQUl4TGdOeWYxd0w1NWhOUFRBTHdsTnJM?=
 =?utf-8?B?N3RRWE1zOEdFKzc4MDZGcHVCM0dFOXRTOURHNEFBNGJWT2VCWldpZ2NlSVk1?=
 =?utf-8?B?ZjNUQ2VrMzFtSXVJZTlOdVhFM050ZnpKTjRGSmQxekU1dXdaSzh0NEdqZS9u?=
 =?utf-8?B?eUhVV3FlbnQwZVlXclM1aHdPUSthaDcwcVZqcjlZVS81ZnRrVnpra09PSm15?=
 =?utf-8?B?dmxYamZnL1FnUkM4M3pGcW5pNFVtQk5UcG4vNFpBRFdldUxDc3ZhdnVjNFd3?=
 =?utf-8?B?TTFIdmRHWEwxVFBmWml3NVltWnhWbnIraXB6N250enN2dUVKTXVpODFHUjhv?=
 =?utf-8?B?UlJncUdOYythUURiMjVTRXgwRkhkVGZSaGJ0R3FmV2tzSmxvTUJWTHVzUUxw?=
 =?utf-8?B?b0w2dDd5Z0o0SkJXbU1SMmc4bUJnbithNXd4dkltM2pTOC9qV2pRZUJ2UUd2?=
 =?utf-8?B?eVowOXJBZ3dPT3BjeDFRajByaHozK1BHWEZmTVZ2U2NxcnhjTzZscUx4YVRD?=
 =?utf-8?B?OUl4aGM4RVJRUkdtb2hnck9QVGJ3VjRuNnZTdWhyVmlhTVByUWpaQS9DZjRI?=
 =?utf-8?B?TEtVNWw2aC83bEJlOW8vcUE4eitWa0RhNm5PVUVKcDlObUZvaEp1b2xEUG5n?=
 =?utf-8?B?d2hSSWMzd21nK1NJaFNxR042RnhnUTcxZTJGVzdlZFhjR2NNcHdxN0xYSVBW?=
 =?utf-8?B?Y3FJLzZUcUVBQjFHS1hYd0tmVDFTUW9sMnZjUHFsNmJERDd2SmNQOFNReDhI?=
 =?utf-8?Q?2ph46KyVhm9K/?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:46:23.2354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0124452-b153-4cfa-8ed2-08dceb52c0c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524

Hi,

This patch series from the team to mlx5 core driver consists of one main
QoS part followed by small misc patches.

This main part (patches 1 to 11) by Carolina refactors the QoS handling
to generalize operations on scheduling groups and vports. These changes
are necessary to support new features that will extend group
functionality, introduce new group types, and support deeper
hierarchies.

Additionally, this refactor updates the terminology from "group" to
"node" to better reflect the hardware’s rate hierarchy and its use
of scheduling element nodes.

Simplify group scheduling element creation:
- net/mlx5: Refactor QoS group scheduling element creation

Refactor to support generalized operations for QoS:
- net/mlx5: Introduce node type to rate group structure
- net/mlx5: Add parent group support in rate group structure
- net/mlx5: Restrict domain list insertion to root TSAR ancestors
- net/mlx5: Rename vport QoS group reference to parent
- net/mlx5: Introduce node struct and rename group terminology to node
- net/mlx5: Refactor vport scheduling element creation function
- net/mlx5: Refactor vport QoS to use scheduling node structure
- net/mlx5: Remove vport QoS enabled flag

Support generalized operations for QoS elements:
- net/mlx5: Simplify QoS scheduling element configuration
- net/mlx5: Generalize QoS operations for nodes and vports

On top, patch 12 by Moshe handles FW request to move to drop mode.

In patch 13, Benjamin Poirier removes an empty eswitch flow table when
not used, which improves packet processing performance.

Patches 14 and 15 by Moshe are small field renamings as preparation for
future fields addition to these structures.

Series generated against:
commit c531f2269a53 ("net: bcmasp: enable SW timestamping")

Regards,
Tariq


Benjamin Poirier (1):
  net/mlx5: Only create VEPA flow table when in VEPA mode

Carolina Jubran (11):
  net/mlx5: Refactor QoS group scheduling element creation
  net/mlx5: Introduce node type to rate group structure
  net/mlx5: Add parent group support in rate group structure
  net/mlx5: Restrict domain list insertion to root TSAR ancestors
  net/mlx5: Rename vport QoS group reference to parent
  net/mlx5: Introduce node struct and rename group terminology to node
  net/mlx5: Refactor vport scheduling element creation function
  net/mlx5: Refactor vport QoS to use scheduling node structure
  net/mlx5: Remove vport QoS enabled flag
  net/mlx5: Simplify QoS scheduling element configuration
  net/mlx5: Generalize QoS operations for nodes and vports

Moshe Shemesh (3):
  net/mlx5: Add sync reset drop mode support
  net/mlx5: fs, rename packet reformat struct member action
  net/mlx5: fs, rename modify header struct member action

 .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     |   4 +-
 .../mellanox/mlx5/core/esw/devlink_port.c     |   2 +-
 .../mlx5/core/esw/diag/qos_tracepoint.h       |  53 +-
 .../ethernet/mellanox/mlx5/core/esw/legacy.c  |  27 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 661 +++++++++---------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   2 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  25 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |   4 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |   9 +-
 .../mellanox/mlx5/core/steering/fs_dr.c       |  35 +-
 11 files changed, 430 insertions(+), 395 deletions(-)

-- 
2.44.0


