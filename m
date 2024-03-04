Return-Path: <netdev+bounces-77220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CC6870BDC
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C331C2090A
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 20:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17784E54D;
	Mon,  4 Mar 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c/8gbn7x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3128FC
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585530; cv=fail; b=SeV5oiFgDFOlhSg1IKeMgmn6IV7i8RX7U3g6GKHEWN2VqSBql4arB5C6+/i7v/FBhy0h0t5W9itpihQv6kO/Us9ZmNfGRPXyN9cC5QdYRwdIQisRTBf5jXE7c2Ec9i5KSvOs5rX9i/sXtmU1LtLHa90PCNKwMcWNUihKGNGFMjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585530; c=relaxed/simple;
	bh=OGcngtbF9V+1zfzKCfgTD53uOq3m3iYJM/caCoJ8QAA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CnYOlVUE6xfaHHzbmrmbfeVHWpd99MBTdyHGPeeVj5c/xt88TuffRAUMzsyr3SnVTtKuGmcTP6cOdIxGjQjuXfdd3tYfuJeD30R+Jd0fW5n++0BmVPk51Zkyxe+yquFO45zGy9BEuaSLN4VIzYqFNdiMdKmf7dKwUEjFRPZIays=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c/8gbn7x; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEj9d7cv+CHRZh1b2BhW+vZJwuPl8Vb1QX7DBZavxG9MKw+9Ak+C8BhlXIajNIy5ojQbDUa5OuRi2SdwdDIoG8ca6+sM97+h2LbpqgcKGvJBBDEM5ux8HVNp/6lDHTWWlTvwyXC6GAAgEsKR074FibW8CGPSWkUgqpeUFWISLcPRHYeOcgZw/JvE2j9q02IHEtfspKkprVNM/Su7mLXeZVHE+Xc6FTA8Be/afYNHwTwOU+BNFujrUt235DnwcKFU+T/vQpHIseZsDW9mtB0ybp2fQhdZYCl9an5nCXTkeZKchro8V4sEao5f7M8kvUgSqfXpGUFMu4++G6tfmVUGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAIbb7KlIUsN9VhGOTh59NfIQnwcvRENlcRiJgL9Bt8=;
 b=TgHdNPxAFTopmavs33c8HQTk/duij9NbkbpFwr8Gx+il/8JrqDXEVSYHuP1nKRN4DetcM/HRF+j4cusk32SrFrRIrAnKDqGjzezGM0Sfse4O6wTPZ0B/Yuy1WDc7Xx8ksdjS+Z4EXVBdUt5S6vzc/h0eUrESb3p6+8/qbvgv++/VFYtRYs6w5r/+v1ST2/UNECEpZt6uINYBD25PVMzslwhU6iJCPoBwgLXL+NfaCZmC5B2SWCzgzr9RLlsGHSkM3YZvvaBwY/Uvb5c4N4w3sbiPAfO/E5lmLhGbPh7zCxWjjmHSDuwMMhiekIdLdrqE2gJWfZr1QamHKzihCrdPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAIbb7KlIUsN9VhGOTh59NfIQnwcvRENlcRiJgL9Bt8=;
 b=c/8gbn7xP/ayzKa9Unmt5H3Hphay3US5sfYMphoUSY61JhkUMwR9QDdmBI4iPfNYJlSP3GptjZd4oC1I8sPSJ7Fxp2J0jbrSdDmMmkDT+nI0U+mWcEKsxfGhKyU94YAnSnl8Qiez2eM/72M3Bn6PEbY3TWw3CVrHd4lN1fBQM52qjN0//wNQGSYsz0yadgT/3zris59Lj9NnmnbJWXL9eKa0dq+ziELy+3WZMWGnDK142roL5ZZ0hqYc86ioTZMOgdZ/CD6c60M9uk7BAatxUUp+XqbE726+H4hpiLT/thNyXPwYTa9vJGSXJwb4Osu+Hp3j9lVWVqSkZRjMppLSDw==
Received: from SJ0PR13CA0183.namprd13.prod.outlook.com (2603:10b6:a03:2c3::8)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 20:52:03 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::3e) by SJ0PR13CA0183.outlook.office365.com
 (2603:10b6:a03:2c3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22 via Frontend
 Transport; Mon, 4 Mar 2024 20:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 20:52:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 12:51:48 -0800
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 12:51:43 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v3 0/7] Support for nexthop group statistics
Date: Mon, 4 Mar 2024 21:51:13 +0100
Message-ID: <cover.1709560395.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2b5337-b6d3-4017-0625-08dc3c8cf1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eGUwpiVpAl7wyq/UhjGnu9GPYuXl4l5li5OuqXo09ApomG8P9GmOw/l0MPHFlM8XHa8MSqmdU/5EXX8T20ypr+jLTFYYGrgIPhFKBfFMjDBTsKl29L6FMhB4sgyYAGqSDvlw+UWItmcgApc3zB1AHS4eXvbi0O56rwcpYpCF4ynY3gTv1zXSWsHZUwyRTAmJZtY2cJ44ZWqan3egrrtAv3MEJmnkq9oukc6+gaFYtUd85zWr+J0UeDp/NvEXTo2KF/O1plUEbsIoPepv19I64vDLsyhYFcGoT+7cv812U8xbCSGQCmxzt6aiDRrlk2yaZAiya+jGsW5supl1gcVJyYR/Db3J9qRTc5x1CxEy+y5FeFOlVphtm6KOKXpSwylCmR1oqLk/myC9+pHocP/8M5Y8EF70O8/Umz1p/JsiGyVT4ibR5McvZKMnOj+smgoLcG6lhGlg7hDnymnQewPI+UJLmlNCPBqJCTYS1myoL2cRGB7rElFxilIrdACcQD2JcBIkHq5E76A/fx9FKWpfAGx6S0qfzDEgyAfr/v1zdaVBiCIp4TgrUMup8tD2hFC0qkk1SfFaLlKmBuPLFL9ncDvS5Yh3Bc2N+Sfq2u9wlczbPu3AsiLvzN/EoAfX5DX2+jRM4ZRv1jCVDwzhZQJZmK2QJ7dkQxw5Sohdn9CzWgPmtHa8259/Ia5pHRh1LO2ADXg5Gv277xQ5Y3QTJm84g15rd82TYVr3wqiC1UYoA0jE798LEUYkp/SDv4qYNWtc
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:52:02.8169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2b5337-b6d3-4017-0625-08dc3c8cf1cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631

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


