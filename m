Return-Path: <netdev+bounces-220036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702D0B44401
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A80D484EE5
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DD830AD04;
	Thu,  4 Sep 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tn2Yo7Ni"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881C3148C9
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005766; cv=fail; b=hex2IfOsXgZOAE99Sq76h2DYSlDmUGsz3r7i7FSdriM0z+dwMhXFi0mErqnQ+svzUa4CWc9CrCUtjLMQ+g9aniC8ryRL4Q4nErzlB07zRZ9gmV00nWGSnoJrhnLfRjiGHN3OdzUP6WqfA836dsNAS2CLCF1gq/JFfkvYC124BAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005766; c=relaxed/simple;
	bh=sWSErDq9TOAgXKGlH/u8potZnuP8iqRWxjJPGFx8No4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qMgni17zf2RtXP7ikS+brJRuKcsL+3nDpt19lhODLo4rEOa8eYMesVGAqtWQjykwZfQ94amiTqPytFFj2IPHx5FAya1ePocGXS72EtZN0UAmAbY6q3GoMP9f2XyDTbgczhWW9zXO3lVkTpeytQ/4B0hlFPy0FDQpoBEBTtJfeD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tn2Yo7Ni; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Np3iaJ1+d1asVESp3kbJuTjWQ+nEdSCErhCJ8tx2QU+v7shjWjHYG3Mk7/ZhZtxFrKUtRCn9m2dSS861B8PuhJmmZDf1Q+1HbP756x47u7OK+YNf/f+MTUwHwWN4Zu6ofQqBElg4LRghzutEenlOOKJJXjX3dbWsnmkjC1ShhDSDmcmLVo+dE53Zo5gnTcWginDRVXo8xzIcocUf+DHORPNQSu49XpdH/h+wL6zE/TpKv9Sg7z6p5RYy4cY2ltbCl/lf3L66pCpbFiIF9yhSErBRe9SEa0TC06cRRB2zARRpqdhcQRf+5lDWHcI2djyaCPUU8vy9qPzCkGumMbZnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDgPfmNfkhTf3BzjMvnWrJ6Dl31CB/E51A2ypWibQkg=;
 b=ww93E3HnJ+w5gGKbJOH5j7WPQnBezkeWS29D4+c7u1sucYaG35bk47N8rUcGNqRsvEGXiqiAep+40y+xUuO8akzX1acr7Hhih/qo5FxUp4UCTzJuyLqA+crZXRP5g+rgvq5/T8vRmDLED5N4Q6Yg7Y5MLCkMcYJbXbJT0HGxfeS1r9pLv5zcYMUoctDbiGHLY3eyBef3Tk0yvh6xbgL66RdZVU2TlS9XmCgNQjQH/RYKtq3CXJN5olPVk6mMgXHWOurLsacJvA+DYh0l/W7+43tj4BH6YYB43qCx1tSzfWWzbWDFsfnjENGV3N70IJVZ79Gm79YWWv+ewgmMewbyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDgPfmNfkhTf3BzjMvnWrJ6Dl31CB/E51A2ypWibQkg=;
 b=tn2Yo7NiUOrHl5rVAFxV+XamWgK2EwAz+YE6KGYvvl+eg4ribP8vmQU/QrSdlXtamn4yO9GhcxR431Y5XADLCuycHaAvrDGUMCHJR4VQgRgtzJUm62pNjTgksGoFfezKS+7oHqZsmla+D63QdNbpghugp2p9b/dHUKI1bMFK+pdb2/HsUg9wV01A437aRB0JSKXl/0zGderjAyPqLv5yrVrRnS4PIs+IXV4U84PeNWR2z/21s1bDJ1GqHvb0cDaH6B+aKPnjCMHTbzyWe7uverX1o41B1Ms05Gk/BUBGsUIB96k8tOfQZ7UznETZKZnTledOEWgqQlBGHPGXdIT4yg==
Received: from BN9PR03CA0338.namprd03.prod.outlook.com (2603:10b6:408:f6::13)
 by CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 17:09:21 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::12) by BN9PR03CA0338.outlook.office365.com
 (2603:10b6:408:f6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Thu,
 4 Sep 2025 17:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 17:09:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 4 Sep
 2025 10:08:46 -0700
Received: from fedora.docsis.vodafone.cz (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 4 Sep 2025 10:08:41 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 00/10] bridge: Allow keeping local FDB entries only on VLAN 0
Date: Thu, 4 Sep 2025 19:07:17 +0200
Message-ID: <cover.1757004393.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|CH2PR12MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ea3ac0-7ee4-4c6f-a7dd-08ddebd5ca06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sfzGe4l04mxGSNlFA37ZiDX17lNAiSoMTBFUzwAyEaMixtFar5LxcUY4N1pr?=
 =?us-ascii?Q?W4QvLlx0Ow2Pr88Ml9Q1u64COZxtgOAVLamd+naY0+n6w4o/mxP3W5678jnP?=
 =?us-ascii?Q?MGCszabvgOD6jgNVe36CFJN6Oe0NyZKtSwb16J5s2vm96Kp3yEAxrW1LXfYs?=
 =?us-ascii?Q?zf9a47FeBiI5LqIZTX4QOpKhjn7XKm6CNuoIZ6ytVu95ZSCd0qNOxjuzadPG?=
 =?us-ascii?Q?OYOb94XE/Y2/GoGnFBkeEmh76pmYt1jC+HN0jK9lAQZg+YERRWYSiAb93+q3?=
 =?us-ascii?Q?yYn/WAXOPtXP4KJTq5HeY6owlDyx4iIDMYyUX+niHtvlhYk+AY8Hfd/8E5wS?=
 =?us-ascii?Q?ftBwxcBTvnkVzcn1UHXhCeetpjUGlnxAKE6SVv/OylY+joyo5oxaW1NlJP0G?=
 =?us-ascii?Q?0slpALy50B8lVSRYUIF2Ku72byvlqbt6xvKbrGdNA1OrODLEFhRRW9mroQmw?=
 =?us-ascii?Q?iH2Zhx9wMTrlNWF+kDW0VplGD6mm4dKgsT5a6OBqU6+abLxfNuITz+0/iEfC?=
 =?us-ascii?Q?pGLxzm8MEy5oj2G3ZkXZIlM2uHKW+cnqCxC0MHe93IA1s0nwVWWwNrA1YsD1?=
 =?us-ascii?Q?lsqI8aDcc72acT9kd7HTvG/HxF+sBO9Wu9yUAovHq8P3TVgpCQd3cZWrwyYv?=
 =?us-ascii?Q?QB6uWaEvySnZ3LoVlJaAiTbEWsmIcOTWWABgEehXBw7t1+sBSNHoCpYHmeh4?=
 =?us-ascii?Q?ZldccGUEkFS3JyrquQRjAPn9d9ju8KffnzsLHfVU/2+/5lvmBLTlruNuQhaX?=
 =?us-ascii?Q?xj1FmMysh2eqXO4q4DXRGHOGwUzeTQMrs1mfdy+VALeiCWHs34k6zr7n7Nu7?=
 =?us-ascii?Q?mGNqt9797egwu2JNskjuPUqexWCmg8adn5wDDCkFDFBKj8xiRtsNoxYYkzJ/?=
 =?us-ascii?Q?QOh1ziBlZ50h1573zGVfjS+nyrDOog/skFrVLd9mRG5p4M8Bk0DXc4OSi+Ze?=
 =?us-ascii?Q?KtQoE3/2j9Q9wsW6BtPS5RfeRxxM7sLuOwtXg3Lx86PQpecTfBMS9BbxUKXe?=
 =?us-ascii?Q?0SvEo59YKlnm1nPfU+EWc78en8itq5pcdWAZWdZ1XwbTXAy0xDWvpnm/J2BO?=
 =?us-ascii?Q?gRHKr7TV20oSOuCMEsVk86izDR/TJCfXDWQpa3esUue2kRnQbgfrX0EUR89U?=
 =?us-ascii?Q?hkLGRrAp7hCcASev62x0IcCNBo5PqYGh5ROEGyN29qxXUiQr5Jyja7crWImv?=
 =?us-ascii?Q?jjZj/LzYlU721CjL+5vrmMGrkd0ZDcBIET8182DgUEf3iE2E4u1qIyA9DhZK?=
 =?us-ascii?Q?SahwW8+tSMEOUR0/Yt0alL143JbHyJH50p5uYBJJtHmLlMFoWPX0ye+/8P+/?=
 =?us-ascii?Q?yqabBNMn0OF/UxS1EY8scFVQwp3ewGklY6YB7Obq6e6dzcq1NSBcRt1Y0/pb?=
 =?us-ascii?Q?fyx/FYxz18KPpMOFHbXXgfM6bPkJlLc7MwMOrr7H3Wsxwq9+SsTg8t5DJjxu?=
 =?us-ascii?Q?3MaB6nzcGdMEof3HI28SWxCRkyKXmKaTIl6ZxWzlOdW11Zewp6yZMTk0PCEc?=
 =?us-ascii?Q?K8q07BCHwc2C9TCBhv1RRh9STni8wNg52T9z9/AhmOrrjYXjM+VAeKeTZA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:09:20.4415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ea3ac0-7ee4-4c6f-a7dd-08ddebd5ca06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519

The bridge FDB contains one local entry per port per VLAN, for the MAC of
the port in question, and likewise for the bridge itself. This allows
bridge to locally receive and punt "up" any packets whose destination MAC
address matches that of one of the bridge interfaces or of the bridge
itself.

The number of these local "service" FDB entries grows linearly with number
of bridge-global VLAN memberships, but that in turn will tend to grow
quadratically with number of ports and per-port VLAN memberships. While
that does not cause issues during forwarding lookups, it does make dumps
impractically slow.

As an example, with 100 interfaces, each on 4K VLANs, a full dump of FDB
that just contains these 400K local entries, takes 6.5s. That's _without_
considering iproute2 formatting overhead, this is just how long it takes to
walk the FDB (repeatedly), serialize it into netlink messages, and parse
the messages back in userspace.

This is to illustrate that with growing number of ports and VLANs, the time
required to dump this repetitive information blows up. Arguably 4K VLANs
per interface is not a very realistic configuration, but then modern
switches can instead have several hundred interfaces, and we have fielded
requests for >1K VLAN memberships per port among customers.

FDB entries are currently all kept on a single linked list, and then
dumping uses this linked list to walk all entries and dump them in order.
When the message buffer is full, the iteration is cut short, and later
restarted. Of course, to restart the iteration, it's first necessary to
walk the already-dumped front part of the list before starting dumping
again. So one possibility is to organize the FDB entries in different
structure more amenable to walk restarts.

One option is to walk directly the hash table. The advantage is that no
auxiliary structure needs to be introduced. With a rough sketch of this
approach, the above scenario gets dumped in not quite 3 s, saving over 50 %
of time. However hash table iteration requires maintaining an active cursor
that must be collected when the dump is aborted. It looks like that would
require changes in the NDO protocol to allow to run this cleanup. Moreover,
on hash table resize the iteration is simply restarted. FDB dumps are
currently not guaranteed to correspond to any one particular state: entries
can be missed, or be duplicated. But with hash table iteration we would get
that plus the much less graceful resize behavior, where swaths of FDB are
duplicated.

Another option is to maintain the FDB entries in a red-black tree. We have
a PoC of this approach on hand, and the above scenario is dumped in about
2.5 s. Still not as snappy as we'd like it, but better than the hash table.
However the savings come at the expense of a more expensive insertion, and
require locking during dumps, which blocks insertion.

The upside of these approaches is that they provide benefits whatever the
FDB contents. But it does not seem like either of these is workable.
However we intend to clean up the RB tree PoC and present it for
consideration later on in case the trade-offs are considered acceptable.

Yet another option might be to use in-kernel FDB filtering, and to filter
the local entries when dumping. Unfortunately, this does not help all that
much either, because the linked-list walk still needs to happen. Also, with
the obvious filtering interface built around ndm_flags / ndm_state
filtering, one can't just exclude pure local entries in one query. One
needs to dump all non-local entries first, and then to get permanent
entries in another run filter local & added_by_user. I.e. one needs to pay
the iteration overhead twice, and then integrate the result in userspace.
To get significant savings, one would need a very specific knob like "dump,
but skip/only include local entries". But if we are adding a local-specific
knobs, maybe let's have an option to just not duplicate them in the first
place.

All this FDB duplication is there merely to make things snappy during
forwarding. But high-radix switches with thousands of VLANs typically do
not process much traffic in the SW datapath at all, but rather offload vast
majority of it. So we could exchange some of the runtime performance for a
neater FDB.

To that end, in this patchset, introduce a new bridge option,
BR_BOOLOPT_FDB_LOCAL_VLAN_0, which when enabled, has local FDB entries
installed only on VLAN 0, instead of duplicating them across all VLANs.
Then to maintain the local termination behavior, on FDB miss, the bridge
does a second lookup on VLAN 0.

Enabling this option changes the bridge behavior in expected ways. Since
the entries are only kept on VLAN 0, FDB get, flush and dump will not
perceive them on non-0 VLANs. And deleting the VLAN 0 entry affects
forwarding on all VLANs.

This patchset is loosely based on a privately circulated patch by Nikolay
Aleksandrov.

The patchset progresses as follows:

- Patch #1 introduces a bridge option to enable the above feature. Then
  patches #2 to #5 gradually patch the bridge to do the right thing when
  the option is enabled. Finally patch #6 adds the UAPI knob and the code
  for when the feature is enabled or disabled.
- Patches #7, #8 and #9 contain fixes and improvements to selftest
  libraries
- Patch #10 contains a new selftest

The corresponding iproute2 support is at:
https://github.com/pmachata/iproute2/commits/fdb_local_vlan_0/

Petr Machata (10):
  net: bridge: Introduce BROPT_FDB_LOCAL_VLAN_0
  net: bridge: BROPT_FDB_LOCAL_VLAN_0: Look up FDB on VLAN 0 on miss
  net: bridge: BROPT_FDB_LOCAL_VLAN_0: On port changeaddr, skip per-VLAN
    FDBs
  net: bridge: BROPT_FDB_LOCAL_VLAN_0: On bridge changeaddr, skip
    per-VLAN FDBs
  net: bridge: BROPT_FDB_LOCAL_VLAN_0: Skip local FDBs on VLAN creation
  net: bridge: Introduce UAPI for BR_BOOLOPT_FDB_LOCAL_VLAN_0
  selftests: defer: Allow spaces in arguments of deferred commands
  selftests: defer: Introduce DEFER_PAUSE_ON_FAIL
  selftests: net: lib.sh: Don't defer failed commands
  selftests: forwarding: Add test for BR_BOOLOPT_FDB_LOCAL_VLAN_0

 include/uapi/linux/if_bridge.h                |   3 +
 net/bridge/br.c                               |  22 ++
 net/bridge/br_fdb.c                           | 114 +++++-
 net/bridge/br_input.c                         |   8 +
 net/bridge/br_private.h                       |   3 +
 net/bridge/br_vlan.c                          |  10 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/bridge_fdb_local_vlan_0.sh | 374 ++++++++++++++++++
 tools/testing/selftests/net/lib.sh            |  32 +-
 tools/testing/selftests/net/lib/sh/defer.sh   |  20 +-
 10 files changed, 559 insertions(+), 28 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh

-- 
2.49.0


