Return-Path: <netdev+bounces-137757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0549A9A12
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBCE286419
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 06:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E89B1474B2;
	Tue, 22 Oct 2024 06:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pCcP5QT6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7052136664
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579170; cv=fail; b=IEKCphXKCV+dyNX03/IMA8XUK43ccio6JRzgH7sTXSAps7ZaFAXlbjMQbdtOe1i5QpF50tNQbYVZt7BoiOhTeR6QglfMa1wh4Q0Ob6xzbyoIv04+AXYISAall/CMJQXAFu2mEw/gEDR7CiCTBb7Lz6yzUPSAoI9sZgOPk0FiuGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579170; c=relaxed/simple;
	bh=MVxjG8AMQ5206jlm2B0W40Co03lP6nlpHIi1+w6hJPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RZWmlZgQWE7JhGPhftpOiCYkaDhRsQkJne+eO4i8FJqGrF8X1FEip6N2Oi2pl22j3pC1XKbPPQjFa61ZBG3QhN4tOLgVMyDw/XgbUqlSNTvduh2cgAkbDtm6SzV7yI9/Q98KKTDJDEH4vJ5WKQfxNmcp6oQLPyadRsAOKNdf5UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pCcP5QT6; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=semSgaRYpE8Ro7hrdJFnJmnrI9ksR0LlR1Lf6v56OScVtGGoI6S2UpJQKhWPv+L0Xgjrr4hrYsQ3Q6F8/zJTgdbWSACg88ESk1gbbR1e4GUbXHRXf/11Dw/jIN4z75F3+bko8HuL2YrEfiQkA5roPin4ZP4b9B3s4xXHamXvVY+7UAzCyaglUIMK1gqJx9Uf52TwlgxT7EKRBg/qH3Bh1qnA6hKajbD53JAMUlqFbiW9BXGwJC3JvazSQH6uO97x2XVfjpb/pmrG5fqcCJScA/fdR/AejFcSFkqsy7C93C//CoTz916liGDmzZky3xmqpmaQXS3PMDlqAssgBiuKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7zhI0BtAFNV70HAskzwMOSI8SOBinf0cWhLTUSlBq8=;
 b=cKCCzKetCYyMffNjwCdfoab2x0/0VqPIb422YNXvr9j28zjSevohdppIhwVT+OhlYFi5pmWYAj426Z4+uJ1KrT35DDzSB3Rhk/PGwd6NRxYkC4aBZ9bskVswTGsQ4DJZ8gQzROGKExiz2/W+AMoiP69IPv8M6AmJnzo+TnZuA/2VgwSVQ8jNDulpi8rLrPbp93kEuASK87WZ/3oCnHUBcaUenzRHoXTwv0ZtDMQGjHXhpYqynMy6xWkNchVOS1NrXdeL5X3nn+ZHdcCpMtrt4D9Qx1ZPXSTM8SnxJboSdIgUROS/t4QZha4LmygY/dcbZLTgqVt0yDwolOj0jeEGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7zhI0BtAFNV70HAskzwMOSI8SOBinf0cWhLTUSlBq8=;
 b=pCcP5QT67qXZdgcdIM7YVGAAlwzAxDtWTRh3qy28hV4hWOFd0yml8PRmOabSs7qnL6IiGES/kJG+kiMv5vP9tlOS8aqjwJTIbCO5qZrrU7k5QkqLKE/YECqQF377TTKkh0R9w34pRhb6Ytbrm+eq9STAtv7a26ySDYPdo+CRHzbrnPo71Dh5KG89ptXZBAkwcPtjctjV/wS/YJqG8foPwcJlKs2HRuJ0CQ32XbVmyHzGEGgVdqLa4bClExFI8jmQ1r7imv+/I7ANCOXtSAOKwsDHThYSWZgVC0oAfnsqHO+gch4+IioxHiIBINXFMPlroC5H7DfkPAG1ceyDWG5SjQ==
Received: from SA0PR11CA0062.namprd11.prod.outlook.com (2603:10b6:806:d2::7)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 06:39:25 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::ad) by SA0PR11CA0062.outlook.office365.com
 (2603:10b6:806:d2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 06:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 06:39:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 23:39:09 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 23:39:06 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_init_flow()
Date: Tue, 22 Oct 2024 09:38:22 +0300
Message-ID: <20241022063822.462057-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8c0d2f-7915-4086-7596-08dcf264457a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5kgo/WEXPcqUu+iaHkBn5UJdxRnklGvXyzrypCWDnJt6B/NmeltP4YpJ3M7M?=
 =?us-ascii?Q?1dv7Po6h5HJ/cEF/CXdz+d4LufIakbHnm58SMb+odPcaVRE18xhMmvPu2M0d?=
 =?us-ascii?Q?Z9fqdT9TbTe2LYCqCL/V8FOd6/Q3olYSVRCE/ycoCaS5oBx10opqMYn18BQz?=
 =?us-ascii?Q?IB4RafeqEaM6fv5hWXrMp1ErTakPOqBAUNNpKq/tWEi5ELaXOlgrtuTFrXy5?=
 =?us-ascii?Q?VYdbMd5EosoxpnRPH//OGL0vkFNeBW63GVDkVN5RMr6hBxMcDFH5/zyUUWfJ?=
 =?us-ascii?Q?170T2n5AObPHUYACi22EKCwaQokJBrfe59qeezFeb5Zot7z7cck5DCrYYRox?=
 =?us-ascii?Q?nUVjR7B2rZ3Liep99Fg3f9f1YvRq0AGxwbYtGEaW8RkBk7z8B+CvuzQNeo7E?=
 =?us-ascii?Q?lH/HH5LVX06TBzQIIHWG+zthOUTqy8ndK7snAhksIF+wE9XliNRgnyBug+A0?=
 =?us-ascii?Q?jTfXmD0H7z303OT4DDppfQm2y+SuMSlUrOBYHSigo+zjJY68tgOjgYSSU1vn?=
 =?us-ascii?Q?72bq6aE3eIegxu7MnFV7wahQkc4H/HoeBJoSs5KsICT8WKFJse/9x62viZwq?=
 =?us-ascii?Q?BysjGXmVA3oe7r6JhUE+4cj0VhtNZiEyeD7eHkPHtINztkahefHyyNqgtzQY?=
 =?us-ascii?Q?2YrWgJedVS3L4Bawqbjbr/tjBS6nOpkaa1PZ5lHX+jgRCuKC+kBYhaJXToff?=
 =?us-ascii?Q?cqPdO3eQ/M+hjdZ/8x9AgW+kedCLDtNJskcJKYMwboydG2E1Y6xPSkXTqrhU?=
 =?us-ascii?Q?ztNR+SpC/L7B3vJ5pkDpnyOa625FRq/yVrNkSG1uTPimTy8tQYKXXcawM0gO?=
 =?us-ascii?Q?/lztxB/km3WorDUyFuF64Sr3HS71P7aLt9S+/pykduFpheZ3BLnHF3kzA6Mf?=
 =?us-ascii?Q?K13UrWZW7qz49ygZP1C2lP3PmBVZjDGvJW+c4VcdYcYpSMOQPdUBt+pjk+kV?=
 =?us-ascii?Q?76P8Vc7nc6d8jstFEVOU6KZX0hcAWs9iEPr0BdYN1CYAbXR6TSdzkqh6Ruo5?=
 =?us-ascii?Q?gfg6GTGTLi9uTVPAdoCsBV+PunfGX73A5msqtZqspDJuLTrGY/Ym/ZotYSwc?=
 =?us-ascii?Q?1EK0deSKeJD5fwl79OJgVgQVyY8f0W6mV3hp+4MQLB6FmmyzpU3h2WdVV8xU?=
 =?us-ascii?Q?Tah74f/sLV5CMtf1/OxVskliBwV5hRDTTQ8Rlj+F/Kp9JC9cHt0apOqxFlDf?=
 =?us-ascii?Q?qkDkWn6vElNPBNe/E+lpDtYyGnLvkJJ4M3FrP4Q/V/FNWt8sKLVAa+4fL8AE?=
 =?us-ascii?Q?MH5y0pZdVVIvlrby6LnXRZNTRFL1aShr2Or5SnOweRidiSbX4zmcjWbIKVdH?=
 =?us-ascii?Q?l/tMJ+pwFgd6a07QJpex2Z0+lutYByV4BihjCt1V130kFof2fhoIzBg5FiFI?=
 =?us-ascii?Q?ltegYz8/LQvfI0jFuCQFUyPalNfKE9Igo2yVie6jWS5ZyyB03g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:39:25.4510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8c0d2f-7915-4086-7596-08dcf264457a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456

There are code paths from which the function is called without holding
the RCU read lock, resulting in a suspicious RCU usage warning [1].

Fix by using l3mdev_master_upper_ifindex_by_index() which will acquire
the RCU read lock before calling
l3mdev_master_upper_ifindex_by_index_rcu().

[1]
WARNING: suspicious RCU usage
6.12.0-rc3-custom-gac8f72681cf2 #141 Not tainted
-----------------------------
net/core/dev.c:876 RCU-list traversed in non-reader section!!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by ip/361:
 #0: ffffffff86fc7cb0 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x377/0xf60

stack backtrace:
CPU: 3 UID: 0 PID: 361 Comm: ip Not tainted 6.12.0-rc3-custom-gac8f72681cf2 #141
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 <TASK>
 dump_stack_lvl+0xba/0x110
 lockdep_rcu_suspicious.cold+0x4f/0xd6
 dev_get_by_index_rcu+0x1d3/0x210
 l3mdev_master_upper_ifindex_by_index_rcu+0x2b/0xf0
 ip_tunnel_bind_dev+0x72f/0xa00
 ip_tunnel_newlink+0x368/0x7a0
 ipgre_newlink+0x14c/0x170
 __rtnl_newlink+0x1173/0x19c0
 rtnl_newlink+0x6c/0xa0
 rtnetlink_rcv_msg+0x3cc/0xf60
 netlink_rcv_skb+0x171/0x450
 netlink_unicast+0x539/0x7f0
 netlink_sendmsg+0x8c1/0xd80
 ____sys_sendmsg+0x8f9/0xc20
 ___sys_sendmsg+0x197/0x1e0
 __sys_sendmsg+0x122/0x1f0
 do_syscall_64+0xbb/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: db53cd3d88dc ("net: Handle l3mdev in ip_tunnel_init_flow")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/ip_tunnels.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 6194fbb564c6..6a070478254d 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -354,7 +354,7 @@ static inline void ip_tunnel_init_flow(struct flowi4 *fl4,
 	memset(fl4, 0, sizeof(*fl4));
 
 	if (oif) {
-		fl4->flowi4_l3mdev = l3mdev_master_upper_ifindex_by_index_rcu(net, oif);
+		fl4->flowi4_l3mdev = l3mdev_master_upper_ifindex_by_index(net, oif);
 		/* Legacy VRF/l3mdev use case */
 		fl4->flowi4_oif = fl4->flowi4_l3mdev ? 0 : oif;
 	}
-- 
2.47.0


