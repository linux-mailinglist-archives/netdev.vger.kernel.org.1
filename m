Return-Path: <netdev+bounces-136207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462D9A10C3
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF301F22957
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EEA2101A1;
	Wed, 16 Oct 2024 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ir7ndUXd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3A18660A
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100241; cv=fail; b=WEuAs5nZ4fHbSK8Tb1qnNpG8DQ8Iu2m+mFH9rQxWc3yxP5Ct9UiQ6pOoNdS68sh2wnIHkYkctVksax6Xxnj3psWry1dDkYvBx5Mwowl7ePJxgZA+HHV1B7iRyXS/oSsGY8bQxeqhOW4otedtMFEXTeT4YiPxKL7eec/C6PEAwxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100241; c=relaxed/simple;
	bh=0XX1Srr05XvdZrBpJ7KCiqIjDCznR/0++qYNN6wAWXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=APieKhMR15/tMCxe44v8wWlrN7ZiMhmqnVvLUZ2MN2RLthaMmf4Eh0p8fxhpDrlZgkqHTtcW5daB9zq/a3pci0oGjR19GZ5OPmbzCpfXTU1I+QMhYVuUeZPj9q3epcHI3vq4Tq8ZaFwKQVuotpexqz4CsB/ipTvEkUaRnS5NpJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ir7ndUXd; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXM1NN88/kkARQX5lTryuy8QZYLN6geqPTEA9KDfnOpl4EneGQiZtRJ3W+B5WG5oWzr+fo32+zGFExArci9xR+YFujZTxZ702AzinhXl+Kyrl/M2eKqcGO0axytjXjirzqWk9dNTQXEUoOJh0mg18RSb07GsgL3yRK7uKR9tOOMbcjyCCvFxbLD9or8TN/pjebr+ZBnMWYXSjJY1EwAqpfaUNEQFK+qqdNs9HgFPKeUOuFC5YJ7m8lSx2foioni6hUe1FzM3o14QhXUJa8uIwT729RdsKdRvHv7joY2Fib3KVw9bMszTGvS8KOjO6AQ13hMd3MNBnuNqXZbRGeDCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/sM26cgFuys+5OHimnAL3/AnvQrTGJXro/CUkgXMMs=;
 b=YMS6u6EdHbscI/282BhXWcxtHiuXBljTlH8C+AXm8rc8IDRsMA6NrgKLv835/10r3zxt9J4+yD3XTsNEXTGKeHSf+Ux1cI9sosCaNw5GLra5qCb2WeW0nt+UoKoYynQ5HRDGyxo70pVuTbC303+iRM9I2wlgA8f2dPMnj2c2pTIJIeKCnaLOCIg15kMQfnO4VQK4QfxG/giTZkis/eOphlN52ebuU72UV1r/GIH0GrElKY8mMtu0UWukYhlC9h9lX/ItchmVKXBvqXmVlqjyRA4EkR5yfWF5XTeu41OoHV9N9JWEbKmsdoKUpLLrf8BGgSFJao87zXdKpOjJAtfbrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/sM26cgFuys+5OHimnAL3/AnvQrTGJXro/CUkgXMMs=;
 b=Ir7ndUXdFNMzRrt8hX4cGURHg9OCi4TwhFUfuFVrIoHjF+u81lb8w2stLoB97bq1s3LiWsf9JwYwcKjLczn8R3eUAkqMrf9YSsaEC8G0wpeqhdM++IGccOCpI9lDZbICnP25vwZsAdokf47ZtdZrrnxy++I8MCojRmHkN98iGILVB/8lPHWYT9xZ1IqDkvA5CsiIPjAerb0dmA2zOC4SbIxxnfk5eU9Om9m7dxKuqzXXhJob3i4/bB62TOk3lR6IXnEXPDvuCkLjzEZ2sd4cab4z36nh2o37LF5mhA0O358jaiQHqdb9AxCFzC2Trbht/0clrxNqAAa5CobgNgAeOg==
Received: from BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 17:37:13 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::49) by BY5PR03CA0010.outlook.office365.com
 (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 17:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:37:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 00/15] net/mlx5: Refactor esw QoS to support generalized operations
Date: Wed, 16 Oct 2024 20:36:02 +0300
Message-ID: <20241016173617.217736-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ec0779-4aea-4a56-3152-08dcee092b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjVERi8wRm95NG9UYlhNc2Z5ditkRUxqTUlsR0tDUUNCRElBL2hEUnZGb0JB?=
 =?utf-8?B?U25aUnkrd1BWcXZxL1hMbXlxLzFXaHJaWWFvVXAvNkxobGtKekx1QmNDYVlF?=
 =?utf-8?B?d2VTWUNQWVlPUEZiL0dVRmxvSWpBb20zaHRzNUw2cnAvMmxlNnZWMWwwZ3RJ?=
 =?utf-8?B?RC9ZcHBjeWxaRVZyYklxSGdhMkltenNKcnI1cDNiNFJKTmJqVTNwTU1KU1R6?=
 =?utf-8?B?Sm5jcElOa0dLd1h3aitoTXQvVFRMVzdKSXFJaUNTRUtjazRaaWFmaTZvYm0r?=
 =?utf-8?B?MEhEanBZYkVJeFVIeVJTckhxTE9yV09KVGpHUE04bW0rMVV2clg1ZGZuMWRv?=
 =?utf-8?B?c3U4N21zS0FpeDRDUnhTSmRGeEJVVHJJNkxPQXptc2xHaVJ2bm10K1h1VUU4?=
 =?utf-8?B?TnFFSDVTRTBjanZkaGtIRENuR0NNRlBKVms1bEhhdzdQdXhvVFBoQk9VbDFK?=
 =?utf-8?B?SWlKY3FEZlR6SUczTmRSNW44ZWgwWGY0SHlPN2pXRE0reG1zcFF2My9lRjh6?=
 =?utf-8?B?d29qcUI2LzFNWXpjanBOMFVQaDJPeDNZME1hbXM1cktTaXhaSXVsc2xpNGEr?=
 =?utf-8?B?MHlVbHVTM3JKZjdnY3RyRFlUQWo2bmx2NnhScWRWU01WaG04TkFKYUNLemRF?=
 =?utf-8?B?YWYzNS9VUFdBWEltblNRTGNDMk5SWXVQc1FVMGZUcFpvNUUwMXRBWjgvbFFN?=
 =?utf-8?B?ZjdXclNNazJZM1VabEJRaWlCSWtvNHdvTDl5ZUI5N3VnWDE2RVNHQkVKS284?=
 =?utf-8?B?L1JGVVhjRU0yUmpPbVRtWFkraXQ3SEJuTUdrUXpnbHppRWhnR2VyVWdwMEt1?=
 =?utf-8?B?SmxZUnlFeWo4MFNwQ0hWcktMMlh0b1pmSGU1TWZVcmh2TzZHNEJKbE5HQkJp?=
 =?utf-8?B?dzcwbUxEYjZ5Q3dmNzQwZndtN1FuR3VDdjBMSFp6YXFEQmhMQ2ltMWIwTTVJ?=
 =?utf-8?B?SXZTQ1NqQ2VBSlZVUE5ZME5HVkJ3ckRtVVg1MEN0RzNXM1FhZWRrZm5ockFz?=
 =?utf-8?B?N08yV1NwSHc4NWJHSU00anNxT0RVcGpmT0dtamhkS0pQNnNnQko0OCs5dU1k?=
 =?utf-8?B?aEpsNWQwZ3FIc2JTeVlic1pqeUJ3UVRNeHJkcHR6RUJiYm5aZGNsT2ZZZC9Y?=
 =?utf-8?B?QkVTWXFYWFQxazRkblhPaXZ4RktNNWEwYU1vNG1TK3F2SjhlMGI1ODV5aENZ?=
 =?utf-8?B?d0ltbTMrZVc3TjZocURZaGx0bHh5dUhLQWFKaG9RaW1SM3dDVmNsL09ucjM0?=
 =?utf-8?B?ZUxDYUVSdkNoWU5hNlNKNmdUd29qSjRyQ2tyaVl4TXhUY2Z6Nzd0dnFMdGxs?=
 =?utf-8?B?Vnd3SWdhOTU3bzNqMCt2Um5wY3QybUFxMEE4MHdnRmczQW94U2NRRlkvYU5w?=
 =?utf-8?B?VmV5eGh4bktsbGJYTmRvWUFzdVQ3dHkxdWNPeGNnMGFEMlhCS2lWcGlRUS8w?=
 =?utf-8?B?KzBwN3M3anBJMC9pVC9GblNQTENqSndEVGVkT3c5WDd3bVp3MHRyMURlUmEw?=
 =?utf-8?B?MUZuaklYZXM0emg5akIzZzdERXE2NU5jcDZuU3hNeTQ0TkVFd1dUTnFIcVY1?=
 =?utf-8?B?UTVGM2ZEL0Y5YXNWOEZBVytyZVhZUFBXenZSL2FoL0E1Z3FTMUF6Zmw2aGYw?=
 =?utf-8?B?ZHhoMWZWcTRWWGk5VlFCK3ZjNG1CZGxBRnVPVTgwNzh6K3JqakpwU211a2xW?=
 =?utf-8?B?Yng3UVpMWjNSQ0FnZngrVFhLaGtOc20zUjZHTm5vWlFMV05vVEZMQ0VDRC94?=
 =?utf-8?B?dzlFN3VBS2VscXZpYitadVEvaWNreThVSExCS3hDOGU2M3Jjdk5ZZXpmLzhx?=
 =?utf-8?B?V2pUT2I3RVBmMXNRaVFFclVzOEhlWFF0Nmp5ckdEMVM0V1Bzc2xwNTROUEhp?=
 =?utf-8?Q?Xcjb3N6Pkoap4?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:37:13.0500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ec0779-4aea-4a56-3152-08dcee092b70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

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

V3:
- Fixed potential NULL dereference for vport sched_node.
- Updated the check in esw_qos_normalize_min_rate to stop on leafs.

V2:
- Declared int err separately to fix the type mismatch with u32.
- Fixed potential NULL dereference in the node allocation error path.
- Removed "rate_node" renamings, as it referred to the old "rate_group".
- Replaced 0 with NULL in mlx5_esw_qos_vport_get_parent.
- Fixed vport node allocation error path.
- Initialized dev in mlx5_esw_qos_vport_disable.
- Access vport_node->esw directly where possible.


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
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 669 +++++++++---------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   2 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  25 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |   4 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |   9 +-
 .../mellanox/mlx5/core/steering/fs_dr.c       |  35 +-
 11 files changed, 435 insertions(+), 398 deletions(-)

-- 
2.44.0


