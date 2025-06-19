Return-Path: <netdev+bounces-199583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB0AAE0CF5
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 20:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA5F1C2581E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27918242910;
	Thu, 19 Jun 2025 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZPemnBQl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EADA24338F
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750357432; cv=fail; b=F7Z7uJmpcNEJ7t8WIwqXqnEQlfVm9iKN2HJ+mBj6izBQ0e9pk4CkKZrxoB2ClaefSImxueeA7xBR9DvLUMyYgH3DUhePBCKqQ6ARVOX/Ylo1L+DvH+Wj4iMjJv7uNZe6sq7Rvs/Dtqbv14dujixvZril6bqEsOTikAPHI8b85gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750357432; c=relaxed/simple;
	bh=WbD1SutS5/vLS2A+jx0330NFE0T7mfB8EUMkk0V69as=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r664BBqQfBS/I1YobRqb+r3W1AmdkpSeyOsEFQYMZM/nVmFaKp5OqP6z6APMM43NsOWxNmTUD4f3J0FPmYhl9MNNV8wlifCD7D02P/JrIHXxSBnr2vq56Vwr60tXeGQ9stH1HoveUIvAo8gJat9K+qETXG4xuwVuh99ONPzJpsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZPemnBQl; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNzS51og1pkFBc43yotj+M60wOhLj20ws1UVZKSut9vosWYEIUNR245Q7uEu2XEtTe/HEMtw65LtlLKcHvpcm2pEp/ZVsN+8VNLtF/idihI1+RMQfNz0veAUIYTpIhuRVL/loRSUgcAF8mt8+/PBn7zGQQSUDlWpEEsWbAXtw5Ct1o3BXP/6hw+l9pzFSjEjouRTOGCJA4x4xiwk22NbjRFHX8FdPJtR/JyPDstRp6b7LWrUDemytSnMKxOSErmRNs8S/3aI240E+MtYAqSq4o6W+1iwwKNO2zMYc3dZa10BqMhv+nhxP8aGsaXOY8gSl4y/QXB5LRugyYx15CLUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awnFavCy0d+rzXisaapQtGu7YTZT22KM+Kjp4F0QWTM=;
 b=VrK23lmSYx1BjaWvdTq8490Z0wFmHF8NSFT4gItkpD76ayb0tC1YgehvwkOoUpqPl4JiMb5e+UcuC9Z/vryB4jfu0yvY6ndBKqxV9xwTK7PAHe1WPTRIKN4HucatRpdSzn6FWjb7Boo+NkFCNHbWSaC2QCVXP4FnfOcaRQqOLLAATeyaXNnH66tjCTxAMwcSm5ap0Iu4b/RNugLJtSLarW7mezqj2VzoCpw958H6Al+CFiq9syKvtjRxar6tjAOJIpFP4c7QicWhp8XGw5RTo3X9sZjLDqOe38IlDITNpJ3h46wlr/bmmvMIgceNtNpiTaX4ZYkZfIph/ms7oG2bBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awnFavCy0d+rzXisaapQtGu7YTZT22KM+Kjp4F0QWTM=;
 b=ZPemnBQl9i9XzwPcAiY4SDQChKN3ywe9fOfP2PggORAGWScnSdsom8DbXLFOMrVxm7o6g3Vz7RRXRU2KMxAPqr2dZKEiI8QDt0PDQs8XQWMAP0pHdrlrg+qwUxG6hhr8dhJHmtbdzuvy85Ymtvk7Cgu+asnEJ2Ws+qyawawCgM9B8JAnFryJ9GQt3oa4oZy2xFij4suuS6U21VA9XIGYyj7oM0mBR0uzqo3ixsmX2qTbgvewcqomVP/2ATKs9FQLznHbV3tgahlr7p1lMpkhul5X5OdsIQzjpS+if6lXys/rmALSujKxuf8Wr/j0JVhFLl3hB3yYvlhCiqLW5bdVcQ==
Received: from SJ0PR03CA0177.namprd03.prod.outlook.com (2603:10b6:a03:338::32)
 by CH1PPFF9270C127.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Thu, 19 Jun
 2025 18:23:46 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::49) by SJ0PR03CA0177.outlook.office365.com
 (2603:10b6:a03:338::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.29 via Frontend Transport; Thu,
 19 Jun 2025 18:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 18:23:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 11:23:36 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 19 Jun
 2025 11:23:32 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux.dev>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <horms@kernel.org>,
	<petrm@nvidia.com>, <yongwang@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] bridge: mcast: Fix use-after-free during router port configuration
Date: Thu, 19 Jun 2025 21:22:28 +0300
Message-ID: <20250619182228.1656906-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: 372862e4-b101-496e-b970-08ddaf5e6e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vizgCelmzprUncRInAg7+KQB/LfaY2T2mPaKz4CS6W2U6SEH3hF/2q1dmXQP?=
 =?us-ascii?Q?p57cZLtfFJMhZNKwuN70yXLhZTpbVr3kqoMicPwbkLqKft92nIQvNeRj/FHp?=
 =?us-ascii?Q?t05vvJgO3XYRPThh6Y2xczAV0zt7Z3roUPowtom+8lAgdhMxmRAQ4K4b3vgr?=
 =?us-ascii?Q?wtNvOl7/TC++ftUpYmlawKoe9RPRRxqm/kpWRdUp5D/Hgdtpjb2SNf5Sjp0D?=
 =?us-ascii?Q?/mbVSFkVRGmplss1KWseWLXw/fhhEr8y1cMhD048+MZ6ga2VsOTWrlbvgnhk?=
 =?us-ascii?Q?81MgeU5rBuwAC9pUwBcHHh25l1/g2bzLXGZpkTbg9T6TXd47Xdzsj7y7NxIv?=
 =?us-ascii?Q?hH0haGpggwhei/OZuWekXcQnT/KIarzQ95Flx4JHLoes8pGx7VXLT5Gf78nq?=
 =?us-ascii?Q?ixdXkGa8goiKVhK5RNwaGV2BT9KhSpHAarzNp+eQ1KZ717dKz6pmYY6az9tX?=
 =?us-ascii?Q?OwmaJOumEBFCVA6vLBm/eAnGmpos9RcQt+7p94cCLhkCyyWjHzitB2DTcCb3?=
 =?us-ascii?Q?k1SmKlkoYZO9ToHOV9ivrQKBPqPrWenUq7tbTp/cv0GfE/Ms1Ti77Egrz1Kg?=
 =?us-ascii?Q?9mdgfxrbdTOazA2qtf6ZZH7Qo7qTbF3vY5jyGyHnShAsTFuZrYf1MCmOpo4H?=
 =?us-ascii?Q?nqoeT4UoMbnFVEH7OGgRnJXgUogmgPSHaYPSTymCzwuJ+auLZv36GqfXnCXn?=
 =?us-ascii?Q?oKPPOTssKcHlJgfL3r6qHQhZprI09ssPNX/3b4MszkEhEkafOntUDEzP1Nb6?=
 =?us-ascii?Q?u7d2+mnr8OlCUkYYdZcKZXYmEVtSjQaP2uI+ZXS8xwEIIcoW2rBD16x41Bcw?=
 =?us-ascii?Q?au0+cIW8v3Eu8Q9eqYjR+WuG989XD9vkT4/AICu40RhPZaOeTwAAy9Lointw?=
 =?us-ascii?Q?PmtJCrL2e/H4hV1bHK8u7ARGe47kQgpWwXnKC2F7nPJGn0dqsJI8yw1tRKe7?=
 =?us-ascii?Q?0UNU1lCOpmgxarNtdbkxJcu7vUVZex3Tallm972x1JErtHYau/IQgZ8CtAdr?=
 =?us-ascii?Q?K+0zmODCl6WSEqwj0IDupFnm3n5C/umnPx5S0mPcV2zhB12eTeC7D/rmyXZp?=
 =?us-ascii?Q?b06OSW4BYATtewQ7+SxCYz0rrZkn07hmdnRkZDscO3Fqlub0KWA/W3crKovg?=
 =?us-ascii?Q?xTf+uYWrSjEaUWdIT0nnScxhhmw/325VDditVyb/a1gCYSF+t6dqcySJatNH?=
 =?us-ascii?Q?aeNO3WQ5pwu9saLSAkzq4ZHCAk7NjoDLrBQtUdc2g0pwbEHnvGxlsBqnwGX2?=
 =?us-ascii?Q?inNKdSrfx/O9lt2UZw/AKFteA9nhYaV5uVIYKuS8/dlO2JaJI6S1d2WRmWY9?=
 =?us-ascii?Q?Je5HR2JRyKFthAX/knb37E5DH6ZnL2ECOBVmmj8fzgsUnzOfi4k02Xk69J5j?=
 =?us-ascii?Q?df3nJ6f5P988mklSaYcv2EAcU7ajScbXnAJOdAB5zv1rT3VW/+P5Srue0rUU?=
 =?us-ascii?Q?esdoC23Vot3phsCgfvI8VOEstKKpBTjSTtWNJkgUFPXOuDz+LPsoam5BNXoK?=
 =?us-ascii?Q?+o1cNKQl/ZJuNXBDoP/BhVEkt3PUkIVAKCr2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 18:23:46.7403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372862e4-b101-496e-b970-08ddaf5e6e3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127

The bridge maintains a global list of ports behind which a multicast
router resides. The list is consulted during forwarding to ensure
multicast packets are forwarded to these ports even if the ports are not
member in the matching MDB entry.

When per-VLAN multicast snooping is enabled, the per-port multicast
context is disabled on each port and the port is removed from the global
router port list:

 # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1
 # ip link add name dummy1 up master br1 type dummy
 # ip link set dev dummy1 type bridge_slave mcast_router 2
 $ bridge -d mdb show | grep router
 router ports on br1: dummy1
 # ip link set dev br1 type bridge mcast_vlan_snooping 1
 $ bridge -d mdb show | grep router

However, the port can be re-added to the global list even when per-VLAN
multicast snooping is enabled:

 # ip link set dev dummy1 type bridge_slave mcast_router 0
 # ip link set dev dummy1 type bridge_slave mcast_router 2
 $ bridge -d mdb show | grep router
 router ports on br1: dummy1

Since commit 4b30ae9adb04 ("net: bridge: mcast: re-implement
br_multicast_{enable, disable}_port functions"), when per-VLAN multicast
snooping is enabled, multicast disablement on a port will disable the
per-{port, VLAN} multicast contexts and not the per-port one. As a
result, a port will remain in the global router port list even after it
is deleted. This will lead to a use-after-free [1] when the list is
traversed (when adding a new port to the list, for example):

 # ip link del dev dummy1
 # ip link add name dummy2 up master br1 type dummy
 # ip link set dev dummy2 type bridge_slave mcast_router 2

Similarly, stale entries can also be found in the per-VLAN router port
list. When per-VLAN multicast snooping is disabled, the per-{port, VLAN}
contexts are disabled on each port and the port is removed from the
per-VLAN router port list:

 # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1
 # ip link add name dummy1 up master br1 type dummy
 # bridge vlan add vid 2 dev dummy1
 # bridge vlan global set vid 2 dev br1 mcast_snooping 1
 # bridge vlan set vid 2 dev dummy1 mcast_router 2
 $ bridge vlan global show dev br1 vid 2 | grep router
       router ports: dummy1
 # ip link set dev br1 type bridge mcast_vlan_snooping 0
 $ bridge vlan global show dev br1 vid 2 | grep router

However, the port can be re-added to the per-VLAN list even when
per-VLAN multicast snooping is disabled:

 # bridge vlan set vid 2 dev dummy1 mcast_router 0
 # bridge vlan set vid 2 dev dummy1 mcast_router 2
 $ bridge vlan global show dev br1 vid 2 | grep router
       router ports: dummy1

When the VLAN is deleted from the port, the per-{port, VLAN} multicast
context will not be disabled since multicast snooping is not enabled
on the VLAN. As a result, the port will remain in the per-VLAN router
port list even after it is no longer member in the VLAN. This will lead
to a use-after-free [2] when the list is traversed (when adding a new
port to the list, for example):

 # ip link add name dummy2 up master br1 type dummy
 # bridge vlan add vid 2 dev dummy2
 # bridge vlan del vid 2 dev dummy1
 # bridge vlan set vid 2 dev dummy2 mcast_router 2

Fix these issues by removing the port from the relevant (global or
per-VLAN) router port list in br_multicast_port_ctx_deinit(). The
function is invoked during port deletion with the per-port multicast
context and during VLAN deletion with the per-{port, VLAN} multicast
context.

Note that deleting the multicast router timer is not enough as it only
takes care of the temporary multicast router states (1 or 3) and not the
permanent one (2).

[1]
BUG: KASAN: slab-out-of-bounds in br_multicast_add_router.part.0+0x3f1/0x560
Write of size 8 at addr ffff888004a67328 by task ip/384
[...]
Call Trace:
 <TASK>
 dump_stack_lvl+0x6f/0xa0
 print_address_description.constprop.0+0x6f/0x350
 print_report+0x108/0x205
 kasan_report+0xdf/0x110
 br_multicast_add_router.part.0+0x3f1/0x560
 br_multicast_set_port_router+0x74e/0xac0
 br_setport+0xa55/0x1870
 br_port_slave_changelink+0x95/0x120
 __rtnl_newlink+0x5e8/0xa40
 rtnl_newlink+0x627/0xb00
 rtnetlink_rcv_msg+0x6fb/0xb70
 netlink_rcv_skb+0x11f/0x350
 netlink_unicast+0x426/0x710
 netlink_sendmsg+0x75a/0xc20
 __sock_sendmsg+0xc1/0x150
 ____sys_sendmsg+0x5aa/0x7b0
 ___sys_sendmsg+0xfc/0x180
 __sys_sendmsg+0x124/0x1c0
 do_syscall_64+0xbb/0x360
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

[2]
BUG: KASAN: slab-use-after-free in br_multicast_add_router.part.0+0x378/0x560
Read of size 8 at addr ffff888009f00840 by task bridge/391
[...]
Call Trace:
 <TASK>
 dump_stack_lvl+0x6f/0xa0
 print_address_description.constprop.0+0x6f/0x350
 print_report+0x108/0x205
 kasan_report+0xdf/0x110
 br_multicast_add_router.part.0+0x378/0x560
 br_multicast_set_port_router+0x6f9/0xac0
 br_vlan_process_options+0x8b6/0x1430
 br_vlan_rtm_process_one+0x605/0xa30
 br_vlan_rtm_process+0x396/0x4c0
 rtnetlink_rcv_msg+0x2f7/0xb70
 netlink_rcv_skb+0x11f/0x350
 netlink_unicast+0x426/0x710
 netlink_sendmsg+0x75a/0xc20
 __sock_sendmsg+0xc1/0x150
 ____sys_sendmsg+0x5aa/0x7b0
 ___sys_sendmsg+0xfc/0x180
 __sys_sendmsg+0x124/0x1c0
 do_syscall_64+0xbb/0x360
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 2796d846d74a ("net: bridge: vlan: convert mcast router global option to per-vlan entry")
Fixes: 4b30ae9adb04 ("net: bridge: mcast: re-implement br_multicast_{enable, disable}_port functions")
Reported-by: syzbot+7bfa4b72c6a5da128d32@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/684c18bd.a00a0220.279073.000b.GAE@google.com/T/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_multicast.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 0224ef3dfec0..1377f31b719c 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2015,10 +2015,19 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 
 void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx)
 {
+	struct net_bridge *br = pmctx->port->br;
+	bool del = false;
+
 #if IS_ENABLED(CONFIG_IPV6)
 	timer_delete_sync(&pmctx->ip6_mc_router_timer);
 #endif
 	timer_delete_sync(&pmctx->ip4_mc_router_timer);
+
+	spin_lock_bh(&br->multicast_lock);
+	del |= br_ip6_multicast_rport_del(pmctx);
+	del |= br_ip4_multicast_rport_del(pmctx);
+	br_multicast_rport_del_notify(pmctx, del);
+	spin_unlock_bh(&br->multicast_lock);
 }
 
 int br_multicast_add_port(struct net_bridge_port *port)
-- 
2.49.0


