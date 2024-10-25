Return-Path: <netdev+bounces-139136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3009B05C9
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6361F23C90
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88C81FB8B3;
	Fri, 25 Oct 2024 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GXEDTVIF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2501F754D
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866462; cv=fail; b=OhynVreUnxvWou1DTDqr7gX4uwoq7OTwa1e0d4lxqij1QHaI7xupv1hdL9NdDASY+mWiOS+etBVeBQTs9GSj6/v+fPjXr/Ki8hCsVMTAa53MxL+Un6uiNAz1faolG/wIi9FXWHKO3SB97srnMYqa1ZG2wkCremB9iTQ7Oip/jVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866462; c=relaxed/simple;
	bh=ujVDe+l8VoGswtd07mC+bTvPvvqe0qStfYnkDUSiDpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahpghff8+Qjtynn49ja9K4ww4EgqYmU+XJDjcsAylVkcY/2vabuDObiHsQXJVdoHZWCsvIyggOc3RYVFby+2uDIn82HQGiThRB+naXGC/r3pzAS0iw79DoPp3Im51ySdt4pzFku6V9bqMRfDSQ0NEiD9/Ja/4LInDPQJ+UOeTT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GXEDTVIF; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atBfpYQmWC+yNFkiP2+eapzT25f17hAKVW8F7jpiBehVJdxTLIf3fNClWBojvGvpagHW7ZPC+Ei3wCEgxuLbNYrguOv+Fn3xp6J9ZqSc8Ow6ZqeDGH8qQeHwa8AIXrjqV9ZnMjTuQX3zrmQ38CMz3QuYFNHiZyvMfeh0sCmfxCw8cEB0zJs7Gh1O6dCH3nM4frCLSjt+m8YpLZjWKGKs1nESWZ3mjVP0MxjsA7fxkM6ebQfGT+7teViMsWfTl/CI1T+Zt4Im8kWliY+TfI52SJUEutg2rMh5joF0me8gCo27x3NL7aiX5/PS94SWtiITXAHdkFfC2VvfPKiRs74JFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm+GMsVl1rVfD7wNT8XZJDSA0DIT+oZ58oiaSsr4nCk=;
 b=HYUYTeScC2BQsVYoLzBv/elyg9O3Dh0i0xr9oitNuP9tsgZv/syHkVD99ZO0EnsCRQesbbhdkjyPdaplQGN/qgPPgkOVHTvWNCzf3OgtsBiH0AKXFMc8UQ6KrHokg6DhWwBgCzpugPanlQZ48sx0IAIS5l+N0muJLKONmaHdx8kjRhmgQxbyw0+lPGW0dWJu625Y1geEnNeHY/IhB/5aJ+pmAUwQMze8PAfGo4/dDTmUfm1LhWkKcUQfPB8hiEXIDQxdqToHAgcwcJ1P62epBjNq5qQIQM84OevBov59VUT67o8pzzPoU211PCguI1z7ZeLgEiMOHDxksUNQX7iXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm+GMsVl1rVfD7wNT8XZJDSA0DIT+oZ58oiaSsr4nCk=;
 b=GXEDTVIFEPjAdttOzIcVIAvGzoazc1x6ablYco9Pgw8A7iWbakbIB6mSmFGlCgH393l3AvLA+OblAlHbohv5xwOMI5BdcJNcfWEMaCqSfGXFB1RtG1Bc+DKTtfsvYMt8U8LLWf1iFO0LJ9sOB8fS5eUqMvjH7OnFy1uBrz9bWWeUuSxHtGtLr44PiGSByEj5J7G3fNCfQSiNujDQMa1K22pSlks0LZRRWS6dIhAk7+gckrhaeRailA7eZDBP/ZYlyHdsKXs+rChnWWOMGgYzZgYCFDgiILL3/D7FPVmGrGLFfSW11JBYmB9U9z25bn8ZDfuAMOUf53OJPDCYsDHiSA==
Received: from BLAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:32b::27)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 14:27:33 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::6c) by BLAPR03CA0022.outlook.office365.com
 (2603:10b6:208:32b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 14:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 14:27:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 07:27:15 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 07:27:10 -0700
From: Petr Machata <petrm@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, <mlxsw@nvidia.com>, Maksym Yaremchuk
	<maksymy@nvidia.com>
Subject: [PATCH net 4/5] mlxsw: spectrum_ipip: Fix memory leak when changing remote IPv6 address
Date: Fri, 25 Oct 2024 16:26:28 +0200
Message-ID: <e91012edc5a6cb9df37b78fd377f669381facfcb.1729866134.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729866134.git.petrm@nvidia.com>
References: <cover.1729866134.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: c5266d95-b0e2-490b-9650-08dcf50128b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NI59LuWt3QMowb6OgoBR3PtPfoCBMURYV9BVYIR0dgphUl5Ot7f0grmoYJBy?=
 =?us-ascii?Q?jWsGOkx2Plb5ucvik3OLTzkZ+sfeEXwCRsdieeoXHHeR0FLMiwJBn2pX3SD0?=
 =?us-ascii?Q?50RElrejndtw42x8AOp9oImTtmcirGYAblzd4mFJPDkF/1dj/wbCIvgV1ORQ?=
 =?us-ascii?Q?ZY2yKIgzxuA2ivsyqzGzYdjMB432Sk6rLwJnXFDdNXCab99BEQHT22xch5+2?=
 =?us-ascii?Q?NJcVwvGbLpDkygPcugiZMKCuccNLjCDvNzTbcxgluRyI5cWtZbRhhc3xTgd6?=
 =?us-ascii?Q?F2ZszpB5Mk3VfB4s156C5Z0+KYzUrDTDPSpmDf55PpjaLPcUwnb+Ph2yFPjU?=
 =?us-ascii?Q?iqk6ZimBeZtNxbkrGI12BTeAaLDYaSMEwH+WxZ7Y0ovvpoaEL80ZKjklcZHN?=
 =?us-ascii?Q?U9zX4liztPy3WVSxUfv6g6ZpoMGxKMQk8wQYK9BVl4yhWSNW/AmhOvE0TqJa?=
 =?us-ascii?Q?JfyMa3xriJ+LIILaxGRBuYESURfPUK5yDkwmYFVVStMwSnwowJkN4jOUNszC?=
 =?us-ascii?Q?YauJkzoTEjjDFQUITIY/JK2OlNN6Kz3XDsV55jhPNNEx6KU43sJbGM0aT7jL?=
 =?us-ascii?Q?ItujWSQUcpdY9hhCSInRT5ImrGR7IBraUMGl1u/n65O6EFHM0TuYrE+ylC5z?=
 =?us-ascii?Q?aOIA4kXkuGhow5eWGH+3b8TfnXS+hyRGTgvsQEO5YDmQ8kYv7R3UH5/ke2Ms?=
 =?us-ascii?Q?6BI5+AFNavoesUw2D9YYzWWI/fqj9XKt/nnVFdExBJes8s8RQ0ArzW6UvxG0?=
 =?us-ascii?Q?ne6t89kx8bMJKJe2XEjdrkcorjI1L8wX6V8T+aUimZ2vokO+17E4TGe1Z1dP?=
 =?us-ascii?Q?739JK+xmnjpMNhTK00dSddTVXAgc9mQYKVFY476Xk56ze4rJyEntwH7D1hg6?=
 =?us-ascii?Q?AwVfn4+rCvAj95bZe8+5d+ZGwDKXEQ9QgJeldi0ibM5HBvEOtDFuM4FP2xYl?=
 =?us-ascii?Q?nlQaWjCJyUmu5ifw09V4QTOOU/yFmWgsC0MJnpud2bm9ZuAfHmFoNXS9gV2F?=
 =?us-ascii?Q?OT0pwwIN4dxi8kaZbm5N5u3QvX1OLoIxPSz1L96ZA+XGaMve1pajKS2liSeh?=
 =?us-ascii?Q?3s4FvAbgJ02eeN/rlH+TKhRlqkhl32Bdhak5pgBqrI8TwgNW1XX/M30wPqOL?=
 =?us-ascii?Q?Ee+nj6hzVrIVuzFgUbaQhT9uovG6hqSZ3iLGxJSmRnk1plMKkIVDQxoU+U0o?=
 =?us-ascii?Q?7//kPb5wd6B7/Elzf/GQlwFqXJHXUaVssXMvsXhVLI6NagfhgezsJSBCK8dZ?=
 =?us-ascii?Q?SC2de0nKcK27rNz7yVS8GI9oOryTi0CuNcnU0FrBTCDD7gPRa6O0UeGmaKcM?=
 =?us-ascii?Q?yDZL3Lpp61n9dRb+PuI66g1WrflLS9fzGLiTfIIL3Y7WrehQJ85b8FED1WyG?=
 =?us-ascii?Q?fQZtALoOowmEx6ZNbOrITRkX05CqvvY+ajxIniIP+9qdSCyWAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:27:30.4523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5266d95-b0e2-490b-9650-08dcf50128b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215

From: Ido Schimmel <idosch@nvidia.com>

The device stores IPv6 addresses that are used for encapsulation in
linear memory that is managed by the driver.

Changing the remote address of an ip6gre net device never worked
properly, but since cited commit the following reproducer [1] would
result in a warning [2] and a memory leak [3]. The problem is that the
new remote address is never added by the driver to its hash table (and
therefore the device) and the old address is never removed from it.

Fix by programming the new address when the configuration of the ip6gre
net device changes and removing the old one. If the address did not
change, then the above would result in increasing the reference count of
the address and then decreasing it.

[1]
 # ip link add name bla up type ip6gre local 2001:db8:1::1 remote 2001:db8:2::1 tos inherit ttl inherit
 # ip link set dev bla type ip6gre remote 2001:db8:3::1
 # ip link del dev bla
 # devlink dev reload pci/0000:01:00.0

[2]
WARNING: CPU: 0 PID: 1682 at drivers/net/ethernet/mellanox/mlxsw/spectrum.c:3002 mlxsw_sp_ipv6_addr_put+0x140/0x1d0
Modules linked in:
CPU: 0 UID: 0 PID: 1682 Comm: ip Not tainted 6.12.0-rc3-custom-g86b5b55bc835 #151
Hardware name: Nvidia SN5600/VMOD0013, BIOS 5.13 05/31/2023
RIP: 0010:mlxsw_sp_ipv6_addr_put+0x140/0x1d0
[...]
Call Trace:
 <TASK>
 mlxsw_sp_router_netdevice_event+0x55f/0x1240
 notifier_call_chain+0x5a/0xd0
 call_netdevice_notifiers_info+0x39/0x90
 unregister_netdevice_many_notify+0x63e/0x9d0
 rtnl_dellink+0x16b/0x3a0
 rtnetlink_rcv_msg+0x142/0x3f0
 netlink_rcv_skb+0x50/0x100
 netlink_unicast+0x242/0x390
 netlink_sendmsg+0x1de/0x420
 ____sys_sendmsg+0x2bd/0x320
 ___sys_sendmsg+0x9a/0xe0
 __sys_sendmsg+0x7a/0xd0
 do_syscall_64+0x9e/0x1a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

[3]
unreferenced object 0xffff898081f597a0 (size 32):
  comm "ip", pid 1626, jiffies 4294719324
  hex dump (first 32 bytes):
    20 01 0d b8 00 02 00 00 00 00 00 00 00 00 00 01   ...............
    21 49 61 83 80 89 ff ff 00 00 00 00 01 00 00 00  !Ia.............
  backtrace (crc fd9be911):
    [<00000000df89c55d>] __kmalloc_cache_noprof+0x1da/0x260
    [<00000000ff2a1ddb>] mlxsw_sp_ipv6_addr_kvdl_index_get+0x281/0x340
    [<000000009ddd445d>] mlxsw_sp_router_netdevice_event+0x47b/0x1240
    [<00000000743e7757>] notifier_call_chain+0x5a/0xd0
    [<000000007c7b9e13>] call_netdevice_notifiers_info+0x39/0x90
    [<000000002509645d>] register_netdevice+0x5f7/0x7a0
    [<00000000c2e7d2a9>] ip6gre_newlink_common.isra.0+0x65/0x130
    [<0000000087cd6d8d>] ip6gre_newlink+0x72/0x120
    [<000000004df7c7cc>] rtnl_newlink+0x471/0xa20
    [<0000000057ed632a>] rtnetlink_rcv_msg+0x142/0x3f0
    [<0000000032e0d5b5>] netlink_rcv_skb+0x50/0x100
    [<00000000908bca63>] netlink_unicast+0x242/0x390
    [<00000000cdbe1c87>] netlink_sendmsg+0x1de/0x420
    [<0000000011db153e>] ____sys_sendmsg+0x2bd/0x320
    [<000000003b6d53eb>] ___sys_sendmsg+0x9a/0xe0
    [<00000000cae27c62>] __sys_sendmsg+0x7a/0xd0

Fixes: cf42911523e0 ("mlxsw: spectrum_ipip: Use common hash table for IPv6 address mapping")
Reported-by: Maksym Yaremchuk <maksymy@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_ipip.c   | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
index d761a1235994..7ea798a4949e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
@@ -481,11 +481,33 @@ mlxsw_sp_ipip_ol_netdev_change_gre6(struct mlxsw_sp *mlxsw_sp,
 				    struct mlxsw_sp_ipip_entry *ipip_entry,
 				    struct netlink_ext_ack *extack)
 {
+	u32 new_kvdl_index, old_kvdl_index = ipip_entry->dip_kvdl_index;
+	struct in6_addr old_addr6 = ipip_entry->parms.daddr.addr6;
 	struct mlxsw_sp_ipip_parms new_parms;
+	int err;
 
 	new_parms = mlxsw_sp_ipip_netdev_parms_init_gre6(ipip_entry->ol_dev);
-	return mlxsw_sp_ipip_ol_netdev_change_gre(mlxsw_sp, ipip_entry,
-						  &new_parms, extack);
+
+	err = mlxsw_sp_ipv6_addr_kvdl_index_get(mlxsw_sp,
+						&new_parms.daddr.addr6,
+						&new_kvdl_index);
+	if (err)
+		return err;
+	ipip_entry->dip_kvdl_index = new_kvdl_index;
+
+	err = mlxsw_sp_ipip_ol_netdev_change_gre(mlxsw_sp, ipip_entry,
+						 &new_parms, extack);
+	if (err)
+		goto err_change_gre;
+
+	mlxsw_sp_ipv6_addr_put(mlxsw_sp, &old_addr6);
+
+	return 0;
+
+err_change_gre:
+	ipip_entry->dip_kvdl_index = old_kvdl_index;
+	mlxsw_sp_ipv6_addr_put(mlxsw_sp, &new_parms.daddr.addr6);
+	return err;
 }
 
 static int
-- 
2.45.0


