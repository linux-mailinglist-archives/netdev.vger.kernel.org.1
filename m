Return-Path: <netdev+bounces-77900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1058736E1
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9A2B20D8B
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172585291;
	Wed,  6 Mar 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umfstCQe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75478B43
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729417; cv=fail; b=sSkACzjNjaMEf5yZyAsVcookUMwwAK/JCmmJJsIQ/odXIG/u89merQLdz+kvsJvNP8QcgqdVV3wkOjA1kaBROi++PEOxxzVy6cuX1wODNeQY//RPkupyKJSg29HaxBhKwfMoPPx1bp5WkEIijvkqYmQAafHkj6y1olTDWmGFkKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729417; c=relaxed/simple;
	bh=Mc7u9FMrWWriA8+rzwmDYX/DCmm/uZ0nEloCt9Z+Kz4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OwMBEqH+oygCkmBwpTdAsvr+yaHyeRDUFzaOsnaQxCEUdrizcZwshrf8unJ+RFqyxW7pfhh6/QfqF4k2c5U+K7KY9WsLOYTiWn8DaoEzKQeBD+7ehIdUsW8YEkMgpMP6uZrkA3a7E/9tHWv5uJxSKGc4dKiLBZoiNaGXtVdBRyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umfstCQe; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUKh5Yzhu1AH7SFRKllBU2Ngi5o+HvAEJAe4H1KwOR0eT8w/NMEYHSstGyOso50UFgKC93ldtRNG1VtMX1EbcDY4yUzh3XI57JXkZNw5mizQTZaAuyN3GJMIzG+xxsrjcWQvgdWTLFspnNL/Bd0I1VflMIsqCzZmxclJ9ZALaQstGyXLLfa7sUoyGEbi9kUtLCTZ2cJ/+l+J6rq0ns9o3PfNmgzBZjZRPmTJB+jy/DexZLpgMWySY2p0bjDOIE3kqSda9o2uNi6Uq4uKmuHEV6Zh3N/03/KvxmDFp1mFcE4lITFIgn3RudLrBGtbC3THhvioKGN+z9vIrWqk0Zm9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDuttWEeU1svZdwSBvLV14GlWTCaq/1NhLGA2z1KT7U=;
 b=Pshx5HE+n1tSyMS8IfOWjDLQBwmE3kL5D3EfS05ED/0/5ODsUW+CvgtP+lL4yqK509WweMKWos3pnp0diP4j8sUsAi98FRR6w2h3TiUsAp1UroE5WVvEuHEf7J9wF3MBNDpNOxwlLGQncwN6vgZ6zfPLOFrfQBr8KYW6adpajNH8kT72wr7ZJgf/11DEp+jX5+UE0XqYpzjOWA7w0Y8zmlwLCH+Wl9wmO011lRHPMJcAxJkjEzZ0vbMBCJZC9Dd5xYqGpnEF/wPkDcJOy2hE+7dWu2pXRmG7Ge3hV0n3JyCT+Ox6h+Ra23WHc30FZRtDt46KRpfy2hyRAO7+Z1A93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDuttWEeU1svZdwSBvLV14GlWTCaq/1NhLGA2z1KT7U=;
 b=umfstCQeUF9wCWdxNCf7bZzq8QujdpLJEgwwIeTHq5pRP+hU407XW2cSlFTerULefoBe/7IIhOxAZnehCJ4s+Z76JAJUUTUDr2E4RkPI+yklXcv6uTusHeJYbM+80Gsq95jIfmOVemkae5swjHgRKkOTsNFQKDqazppjxcpOQOxvFkSO3BDWYW4ucRqlTm0znsuXpIqTWeLD3tHibv7ZE1u0FKkdgZrY49ExyEzLg3WvWwdztJvte4x2SjRD/UtUqhZOsvNd+ZqODxfaUzLUUVhDN37F23MpbZw7vPgL3nhqKTOdOuOgRSrt2yUhBdexTKLzqluQw1nl5c9fDi3L2w==
Received: from SN6PR16CA0046.namprd16.prod.outlook.com (2603:10b6:805:ca::23)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 12:50:12 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::bc) by SN6PR16CA0046.outlook.office365.com
 (2603:10b6:805:ca::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Wed, 6 Mar 2024 12:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 12:50:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 04:50:03 -0800
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 04:49:57 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v4 0/7] Support for nexthop group statistics
Date: Wed, 6 Mar 2024 13:49:14 +0100
Message-ID: <cover.1709727981.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SN7PR12MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: b5de9f32-c091-42e5-096e-08dc3ddbf683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b/WrTSFKxAfZckLngaMvQstKM6e/xNAR9ddOYIASNoMeU1Ey6stDkgWsUmVqk82BAUwTwyalgZ4HaAK0iFRk+o31x6kWfs536huQtq004wGYmCsZNUjD3ZfP5Z7YlbRMBo9LGgAWmpQrkgyQ8/oC95Yv5J4Y/RrH2SA6RSs6CjrLLu6q7hmEizIto3PCJAsrPLNeXwL/jwziXrw96Mb4Io5YhOtb8RoV4DaGwgpK+Nm9NcGZ+H9b488TRyfI20RKEFea4doJuDUz4n97FrTGFObD62m9oQi90iidZxyOF0U6bZUm+6omLZG1ZJNnH6Tpo2TvbbN2/KBkPkt1iij+2gbSo1XQugZ9KSEa6q311VhMXq0gbhWTT4RhFzVzoP3bAhedZCqA10qF6/7KwwmarIRE14Mc4VsxQSQtPtzBxGY7TgfgJXBP96TitmDQkNyw8Cu6Nk0A2UUxnDwpRUEcymr0W3bzYTgv2f02p9BzVawCBxhztBGWdqNMcLwtQUa7otLr+5+jbF0f/lQLJA6kczyr4CEqVVELLJVM0NQ7sFI3PBsKZir95qynfIK4UUA6LNPbgN0/Cck2U5qrucrye564SB6a1PD4RO8Bf2gr+vB44ANWPjy5MPkmkH15VmDJYOzJz/qvixj3QkRTIJ36Cu4OR1ZerOB1r2jCU02Garcl4sKXlMafrtEBxihB1dEkGFJXy4qlb+akuycyCrI+4a0DkNwoxdo7R0W5tb+B+dF6HWJZP7G3maTpq6bREEDS
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:50:12.1276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5de9f32-c091-42e5-096e-08dc3ddbf683
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935

ECMP is a fundamental component in L3 designs. However, it's fragile. Many
factors influence whether an ECMP group will operate as intended: hash
policy (i.e. the set of fields that contribute to ECMP hash calculation),
neighbor validity, hash seed (which might lead to polarization) or the type
of ECMP group used (hash-threshold or resilient).

At the same time, collection of statistics that would help an operator
determine that the group performs as desired, is difficult.

A solution that we present in this patchset is to add counters to next hop
group entries. For SW-datapath deployments, this will on its own allow
collection and evaluation of relevant statistics. For HW-datapath
deployments, we further add a way to request that HW counters be installed
for a given group, in-kernel interfaces to collect the HW statistics, and
netlink interfaces to query them.

For example:

    # ip nexthop replace id 4000 group 4001/4002 hw_stats on

    # ip -s -d nexthop show id 4000
    id 4000 group 4001/4002 scope global proto unspec offload hw_stats on used on
      stats:
        id 4001 packets 5002 packets_hw 5000
        id 4002 packets 4999 packets_hw 4999

The point of the patchset is visibility of ECMP balance, and that is
influenced by packet headers, not their payload. Correspondingly, we only
include packet counters in the statistics, not byte counters.

We also decided to model HW statistics as a nexthop group attribute, not an
arbitrary nexthop one. The latter would count any traffic going through a
given nexthop, regardless of which ECMP group it is in, or any at all. The
reason is again hat the point of the patchset is ECMP balance visibility,
not arbitrary inspection of how busy a particular nexthop is.
Implementation of individual-nexthop statistics is certainly possible, and
could well follow the general approach we are taking in this patchset.
For resilient groups, per-bucket statistics could be done in a similar
manner as well.

This patchset contains the core code. mlxsw support will be sent in a
follow-up patch set.

This patchset progresses as follows:

- Patches #1 and #2 add support for a new next-hop object attribute,
  NHA_OP_FLAGS. That is meant to carry various op-specific signaling, in
  particular whether SW- and HW-collected nexthop stats should be part of
  the get or dump response. The idea is to avoid wasting message space, and
  time for collection of HW statistics, when the values are not needed.

- Patches #3 and #4 add SW-datapath stats and corresponding UAPI.

- Patches #5, #6 and #7 add support fro HW-datapath stats and UAPI.
  Individual drivers still need to contribute the appropriate HW-specific
  support code.

v4:
- Patch #2:
    - s/nla_get_bitfield32/nla_get_u32/ in __nh_valid_dump_req().

v3:
- Patch #3:
    - Convert to u64_stats_t
- Patch #4:
    - Give a symbolic name to the set of all valid dump flags
      for the NHA_OP_FLAGS attribute.
    - Convert to u64_stats_t
- Patch #6:
    - Use a named constant for the NHA_HW_STATS_ENABLE policy.

v2:
- Patch #2:
    - Change OP_FLAGS to u32, enforce through NLA_POLICY_MASK
- Patch #3:
    - Set err on nexthop_create_group() error path
- Patch #4:
    - Use uint to encode NHA_GROUP_STATS_ENTRY_PACKETS
    - Rename jump target in nla_put_nh_group_stats() to avoid
      having to rename further in the patchset.
- Patch #7:
    - Use uint to encode NHA_GROUP_STATS_ENTRY_PACKETS_HW
    - Do not cancel outside of nesting in nla_put_nh_group_stats()

Ido Schimmel (5):
  net: nexthop: Add nexthop group entry stats
  net: nexthop: Expose nexthop group stats to user space
  net: nexthop: Add hardware statistics notifications
  net: nexthop: Add ability to enable / disable hardware statistics
  net: nexthop: Expose nexthop group HW stats to user space

Petr Machata (2):
  net: nexthop: Adjust netlink policy parsing for a new attribute
  net: nexthop: Add NHA_OP_FLAGS

 include/net/nexthop.h        |  29 +++
 include/uapi/linux/nexthop.h |  45 +++++
 net/ipv4/nexthop.c           | 329 ++++++++++++++++++++++++++++++-----
 3 files changed, 363 insertions(+), 40 deletions(-)

-- 
2.43.0


