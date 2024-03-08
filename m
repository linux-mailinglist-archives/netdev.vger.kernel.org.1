Return-Path: <netdev+bounces-78734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875C48764A2
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4844CB21C14
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01D124B29;
	Fri,  8 Mar 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IFBRGxs0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383C1EEE8
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902966; cv=fail; b=RmgTNUiFNnd2EsMYkx+SuGih0EVhYVaSygzI8IhGeK5AZFHe2OyleVR0RZU5LNXrj+oaGkPB9irGieaQCYGNsPvT/o1+dkOiakCRMeSB0q6P/bpGnQb30oQXf73Is6UJN07I6fbJfdUKszlN/3HbtG8EpxPga4dNTWPEv9UTzzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902966; c=relaxed/simple;
	bh=z5Kz8cJa32fQF1PWHBKjvN+PSRPmJoMbL/O9/9Q2dTQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZW+sjJoIYPalh+qHCP6KEGCH6bkqb/s0LAgoExAKlEEIoPyV7XOzsAL6YGHzNKwHk3MpH8XUzJJEQfg93WzW0rqr3SmGSjo3dY5z9q8tX/u1A2mmwJHAcikKl00lDDrKsaABcUXaBLLo5Bx8697cE5xIh5aAuUGja6jg/ZMeK94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IFBRGxs0; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtmtuwHKa9ZxuaKkzZrT47agRDQHKOx+5BYlCaAx5SdlhSibaSEruMXsSY3hsQJLFPoU+ujFfvO8bjeDFyR/S0o7Z4CLj42+LVofgbM6Fl59Z5vX1rGDaPC9jX37Dz+fB1LSAC8Scc14lytu3WJCTMWq/6PpcWlNUb8py5gfZEisC45s0iDlckw4Nx3MpSIiIAThBMXgaAnSRUSOEJTU9dorIG5YAsRTi446ykoB6ylN2SwvlyMz/hbgNXdKRaqqAX2fP2kVhTmoiCnXRBxAN4yoIch5J7vU4oM/UX7pzWONdf/i7evTW/VsrApTnGhc/Y86WfBCqmNJtddwzuHcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tEd0rEd4bWzBUuup3XBBXt8QS8mRoxqs1cFJnbXTtU=;
 b=cPMwUOo3f4lqaRtz6R1KayrTRMKmvL8MVM42MGnSVcDJsliQHMKf5+PZCp/+g8d6ZV+S2BBgyQWkvhXKgrz5XGrCzIMSBjyl7ZP362YZ9Eofmkj0caljmYWyHdMo8BGlTI5Ke3h4msCbMr84ktkOJPzCTo9Jixax07gy0GV26uSq4EaClhTGPdrZS9ONAjlXezBPujUT0lnR7W+gybCSyicPN3gp0zmqjrysXjC7TaBEElnrqk5GWrkQE2iOEUH5QjpDb8FSqXJQnVM+gw+Y/PvlqyVmxDiTwGKLFb/xRgGI0ZqA3ExfzNQhALsqyMfMynjlW3QEO9ncznL+uMaWng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tEd0rEd4bWzBUuup3XBBXt8QS8mRoxqs1cFJnbXTtU=;
 b=IFBRGxs0cdjA1jT2QJsoKVlBtPnpxYbs8c/ZLvwI7T5JAwb8CV5VGp0786/pBZmc7+Uzw07Cpv9UBSQwuVdz6K+mrYBwfZn4pbMx2ABblyf2iT9+ZbLjP5Wp1OaFN7k5AJe+bxWi72Be1b+sMWdGGyAJy0+Xwpjr4GGqYKJNX7+kfhdRzlFe/ou7/rBPyMjxXb4+25Nc3v3faZKCv2m5LwxGSvtgy1ncWnL18q2cOGIgETs5MuYNc1KgGoxQ+tfI7LMh0Az8O6R8Fx4r2tqOoI5u3gAAJjT1iug0ozKXhtWpymJc8UP9OPcIQh4wtRMlnnJvIjmlyMmrG13QimK7Jg==
Received: from DM6PR07CA0067.namprd07.prod.outlook.com (2603:10b6:5:74::44) by
 LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.27; Fri, 8 Mar 2024 13:02:36 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:74:cafe::df) by DM6PR07CA0067.outlook.office365.com
 (2603:10b6:5:74::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 13:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 13:02:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 05:02:17 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 05:02:13 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 00/11] mlxsw: Support for nexthop group statistics
Date: Fri, 8 Mar 2024 13:59:44 +0100
Message-ID: <cover.1709901020.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c85d33-0181-496d-02a7-08dc3f7006d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eGJyK9FDCzP2aqoDcJce6W9qtEd8L0gKETqhZKt67VhWakvk0mxVi46OkBLpqLXGHJVB4ZewjB6IUizEGC2AJ8qN3XID0aI32jrQcKAIq9XSfkQDVGWBEZTbxWBkGvR7a6kfHeVGpYnbrHlQfwuXhh7jEqghIhP4CswFVmmRdwtNkOB6gN+KZICc+2iUasRZ1nL5GSsB12iw6K2XzDUA6hXT6UgswgN1enyp/4qoDcDw3sq1MYwnunt4oLs4zsqtQKH9EwDsbW3pACBMhcP0EjIeeULdVjgkM/DChp1RI5mES62ES0ICf3w/L7d2ufeV3f7agPrQh7bTBRnPcML2KplBYHP5sT1aE1qen86990phEa1JUTXTsMrXnkE5+2WMQC6h4vGtgIvO98/yPL9XcqMZNGRQX8s4c1pX++MvQsz4qhPWtXORTNqlRrtNL0xyh8qsPfd19rro0cMLV23BZUa62BtiANkF8efPbOoBz68Eirnfe0xJj7ix/PSG4LDOuI0zmv6ZNQrdUr0nVcm8P5jbTG5zo2wKt46nb3EfxQLhUR25uEki3nY/S9rxoR/vBJzeCsvp7iHpHk5ATrpKguB/FSan5qYwEsHLPx7y/+iTM0OflgffxtAgLrJN42KCER47MwAzkWl8HNLWP4FEaD+FrMPQpN0R9X80OCa4CntbyT+Exfqz4A9wl40MZ3vvF8Gh9EsOGv1h492QhcHUg4lqw5COiNWnPo6Iv7zGEldfSKTwI4GoQGDW+iU0O+8Q
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:02:36.1846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c85d33-0181-496d-02a7-08dc3f7006d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821

ECMP is a fundamental component in L3 designs. However, it's fragile. Many
factors influence whether an ECMP group will operate as intended: hash
policy (i.e. the set of fields that contribute to ECMP hash calculation),
neighbor validity, hash seed (which might lead to polarization) or the type
of ECMP group used (hash-threshold or resilient).

At the same time, collection of statistics that would help an operator
determine that the group performs as desired, is difficult.

Support for nexthop group statistics and their HW collection has been
introduced recently. In this patch set, add HW stats collection support
to mlxsw.

This patchset progresses as follows:

- Patches #1 and #2 add nexthop IDs to notifiers.
- Patches #3 and #4 are code-shaping.
- Patches #5, #6 and #7 adjust the flow counter code.
- Patches #8 and #9 add HW nexthop counters.
- Patch #10 adjusts the HW counter code to allow sharing the same counter
  for several resilient group buckets with the same NH ID.
- Patch #11 adds a selftest.

Petr Machata (11):
  net: nexthop: Initialize NH group ID in resilient NH group notifiers
  net: nexthop: Have all NH notifiers carry NH ID
  mlxsw: spectrum_router: Rename two functions
  mlxsw: spectrum_router: Have mlxsw_sp_nexthop_counter_enable() return
    int
  mlxsw: spectrum: Allow fetch-and-clear of flow counters
  mlxsw: spectrum_router: Avoid allocating NH counters twice
  mlxsw: spectrum_router: Add helpers for nexthop counters
  mlxsw: spectrum_router: Track NH ID's of group members
  mlxsw: spectrum_router: Support nexthop group hardware statistics
  mlxsw: spectrum_router: Share nexthop counters in resilient groups
  selftests: forwarding: Add a test for NH group stats

 .../net/ethernet/mellanox/mlxsw/spectrum.c    |   8 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   4 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl.c    |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_dpipe.c  |  22 +-
 .../mellanox/mlxsw/spectrum_mr_tcam.c         |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 312 ++++++++++++++++--
 .../ethernet/mellanox/mlxsw/spectrum_router.h |   6 +-
 include/net/nexthop.h                         |   2 +-
 net/ipv4/nexthop.c                            |   3 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 tools/testing/selftests/net/forwarding/lib.sh |  34 ++
 .../net/forwarding/router_mpath_nh.sh         |  13 +
 .../net/forwarding/router_mpath_nh_lib.sh     | 129 ++++++++
 .../net/forwarding/router_mpath_nh_res.sh     |  13 +
 14 files changed, 505 insertions(+), 46 deletions(-)
 create mode 100644 tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh

-- 
2.43.0


