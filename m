Return-Path: <netdev+bounces-225039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6E1B8DD1F
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 17:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282533A7CDB
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6999D1DED5F;
	Sun, 21 Sep 2025 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DGy26t6h"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7471C861A
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467421; cv=fail; b=c5PZYfvsIDKZ90t9ZyEI4JSTgl0FfIuFPx8rwmaKSfkP0uYIshcHNaEm33eACEzfb1lI2tUfQ3Xv1l0/iwbUMo6Of8AhFfQNwDtEiJP1svVU2LYpIjbOEoMhGq9y9aJx+mgw7e2L2USB8EpamP94FdShruKV4r9aOBryz0DBFG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467421; c=relaxed/simple;
	bh=9sxecU7kQx77TdquKW4+eCF0pFEZCwphvpMFs5YBIzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mmbw2rQ5mLdmUCzcYDKKsYl/sThFcjaIyEtm63s1iVfO0uL6LSN4zLwLuhwCRwHEGWltElFBzV9q1GpjWOpUc1e5ExEdyUTzu6RmWpvIAf8E2TNlO18tiKG0Cmx8iM6M0NzGJpWrRte65iN/lfWLeiUTZFv1cfUYd/VRG8sHQkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DGy26t6h; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNtm8kRXEWMrb31rwJOnNqzREDuImt+EMAz1crIMnHi+y/Vwl6UI3iWAw5NotxXPeBxedIOLy+1NzBv/Y2JoYelIKW06J2pb87y2OhBTi9jLe9znSns73USNqf8e8YlYHULQyn6R9s6ITfgtUoKNKiTF0pm3OxfffPLlcQEcQQz9l3A1ox6t9h5IZ2Q0lU+VcAmwFNOgfwE6e91Snf+2g2d6JtX32yH2NF9sGYTOYV7YmVzh5cekpL0GsV4sbQ/MAeiGozRTWMtnN6l5D+zHAbhrkylwIVBXBKhkfZh8rdDFKwKjl58Y00FvVXF6Z+ME1feYHBbxL1WDx7w85qbH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdWnyKLLlCG5KLAYnYSql8T2LywU5vH8jGUzwaUPXsw=;
 b=Lxqf/arUwwaONR8PcgGZbQJvFT8JSe0zcCeZ5KPv17hJ2/uIRLX6lhz556ItAa9C1LBQkqDfQCT1TlyzSqpxmBcLiSoZlZK04lv9aOdXkZ9j9ijHt8pBmm756sbQSPw+jRjNmIYMKauKHXleVvEe5pxAKIzJKwHpVwwfgJSMy5Zlm0hIiktUCktZHA9hkhQarF6g5/oE/USNvWC+Q8tAmx54Rw0xBZ6U2Vw3HifgBIsl7rnMRBLUIW28oX/zpp74MKq2gWKWbKhpf4czY/G7lf5Jreuj+o4S3nJ5YbXgq2cqqj/fpYWw+aHnjicDnbD0ExRHa9UiL8g+4MxpUsKisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdWnyKLLlCG5KLAYnYSql8T2LywU5vH8jGUzwaUPXsw=;
 b=DGy26t6hE4n9O20+ZSpeL6IszP0oJ4iEhGNwjQHQmcJkv2rbwuKBop8MDcaU97N8PtiBlyBpSAMATQmsJM/LORRzjmse3oL9HUZ8f5o4LTywFtqYH2gn2Hpo2L7Vdxe9Xl59bfanWJcpc8sMsqnX5UZ7CPwYLD0teYMuvhMlW1e37VEBVJssxorLgHbyCtOHYaau/SM2u10q5AmZkC+P/HdahTl13Goh/FIa/4p1UkhDPq9KolEJW2cSXigZyTnrrw5npcMlZRsocztRG2R0NaQxXwL2ZCCfIC2AadKyoWkgCNRA80079U2WLZF0D6L+Xr2OOoxK8aW5om30b6yjaQ==
Received: from BL1PR13CA0437.namprd13.prod.outlook.com (2603:10b6:208:2c3::22)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sun, 21 Sep
 2025 15:10:06 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::ad) by BL1PR13CA0437.outlook.office365.com
 (2603:10b6:208:2c3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.17 via Frontend Transport; Sun,
 21 Sep 2025 15:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Sun, 21 Sep 2025 15:10:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 21 Sep
 2025 08:09:59 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sun, 21 Sep
 2025 08:09:56 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<petrm@nvidia.com>, <aroulin@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 1/3] nexthop: Forbid FDB status change while nexthop is in a group
Date: Sun, 21 Sep 2025 18:08:22 +0300
Message-ID: <20250921150824.149157-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921150824.149157-1-idosch@nvidia.com>
References: <20250921150824.149157-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 7021c988-351b-4602-ca4b-08ddf920f311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FPkzopajC8/cinxGdhRcj9xv5D6PMf2kygnT4nCVIiPlJcXf0PQmPbVONdKv?=
 =?us-ascii?Q?tiXKGaMuAO367D6UbF+ZiKlBuJlrHpIFntGZ/Wf3wSFhWoAtS9S7pbo2ZbOg?=
 =?us-ascii?Q?IFaSf24pSSS+oi51YqgctiyeK39GRnkFdflaRsVR5ygoHMdg2bbGR0T1xSEv?=
 =?us-ascii?Q?pBSAGpcLcGVQwwx1hvX4QTadcyZXmv8OVoF2TwDc5K0/rvZzQXd4VRWVQ8iQ?=
 =?us-ascii?Q?Ega2/QH87F+8YtyfUmLmmAJD2LJQMomvaOU0QAR6QLoZtO/AUKA8tifIkfBH?=
 =?us-ascii?Q?aATWDCMXCLAHLYz2rBUw0VjHboiEwlYLeHnDJyaFTxfvYWZ4j8lRPHifDQ7O?=
 =?us-ascii?Q?31c7WJUBLDd2QVvQxog2OfFv2IjZm4twRPJscxVFBmyev1WGJT65P9Yj67Uu?=
 =?us-ascii?Q?xcHp95sK3B0UaWEHrHEn03QhqhoGTjCTk5OC2h7kO1MN2DZQ/Le5qKH4gzcZ?=
 =?us-ascii?Q?J5y1n56fBFrMNdFx9F8T16lkgjVLKWI/+EbgnBn8dAfwNDNibsq0VR9UJTPq?=
 =?us-ascii?Q?z3dxkaAFje6mcNoVuOPvgeNjHK6XuVX8mQskm40/2sKumdEHUYC+S4M/G+ak?=
 =?us-ascii?Q?WI+4psK65j+wOPsvE3QvvOozN+FQNhZlHbVCet/9XWuJHV2jG6cW7W4uBtMD?=
 =?us-ascii?Q?WvaqkBXH8DzL0wTvmBcq/JmxQ6ZKVgj/t0NgZKqMb7sX1jJB1Rw00+qM8Q59?=
 =?us-ascii?Q?V6Ou37sR+fHkLK4xGw4ex4MmcABmmtNZ9SbzIEMkWHE/NEjNVjEZqRQEhYJP?=
 =?us-ascii?Q?O6DXukz466Pl9EEHtUGVW1gvhPKjQ1NzN6Ph6U4CfZqvni0rTeR6WJPNZ6lV?=
 =?us-ascii?Q?L0ltZy3BI5pNpYX2ga3fNcr+QFbG1jf5YYtzA+vPNx0vEz1kaGxSQurAzgCj?=
 =?us-ascii?Q?NgWKQQQrwizn/ABEGc02el8GHDeu6KkIUtmp11j0O+6buYsug1AyYR3+ujtG?=
 =?us-ascii?Q?jwbquvlir7Icy5pyzqWyQbyltMcB8YygDrctQ4XITZb63erJwMsInlmU5q9m?=
 =?us-ascii?Q?ctfhLlFr+l1LV1ADC4mluwdBtsHw1sVV7Rd1NvJGWXS+euOIW9j83TT/+4JQ?=
 =?us-ascii?Q?5lkIQqJwEQX7RVUuEb0X3STgAdsHYc1iDvTRg6iNBQhV2pUbJ5XB2ZMo+2Yd?=
 =?us-ascii?Q?Z5ecOMVR7hiRYgUMbKpUjw7nxaKah+yStt55GEzQVZEJYUm/9WLMdvOiXzQc?=
 =?us-ascii?Q?FqvR87YBqHlEfiuI04m2+/gkDjBZ1ebA2ZTxgYSb71f0NRXQ53IeuMFH/6oz?=
 =?us-ascii?Q?C3dH+M2NkkQQDzTgPI1k0KacOuG6F8LZqRDLat9Zu/Qm6vNKDSNbspRbNHQ1?=
 =?us-ascii?Q?dG2SVnJusMVx8CVcRmsstjmb0dnXr0p75oftfrO9tdfbL2PE+E2KMkjjjpYd?=
 =?us-ascii?Q?EnYy6JVKu2TppCIosWF9go2ko+wKC0rOYDfuNqrqp3lh7ETmM+hMQeZxUsZw?=
 =?us-ascii?Q?hPFc0S1pMUHUZ8XYtIfbwtlPi+ubnIX/38wIrFWbAyuCzSeFj9qU07xUl2DF?=
 =?us-ascii?Q?7sBThNcllPwGTCMf47qpGu6W+5CHyvo9FsV+uaVvvJElhJ1pSfUStX0M5g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2025 15:10:06.6945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7021c988-351b-4602-ca4b-08ddf920f311
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

The kernel forbids the creation of non-FDB nexthop groups with FDB
nexthops:

 # ip nexthop add id 1 via 192.0.2.1 fdb
 # ip nexthop add id 2 group 1
 Error: Non FDB nexthop group cannot have fdb nexthops.

And vice versa:

 # ip nexthop add id 3 via 192.0.2.2 dev dummy1
 # ip nexthop add id 4 group 3 fdb
 Error: FDB nexthop group can only have fdb nexthops.

However, as long as no routes are pointing to a non-FDB nexthop group,
the kernel allows changing the type of a nexthop from FDB to non-FDB and
vice versa:

 # ip nexthop add id 5 via 192.0.2.2 dev dummy1
 # ip nexthop add id 6 group 5
 # ip nexthop replace id 5 via 192.0.2.2 fdb
 # echo $?
 0

This configuration is invalid and can result in a NPD [1] since FDB
nexthops are not associated with a nexthop device:

 # ip route add 198.51.100.1/32 nhid 6
 # ping 198.51.100.1

Fix by preventing nexthop FDB status change while the nexthop is in a
group:

 # ip nexthop add id 7 via 192.0.2.2 dev dummy1
 # ip nexthop add id 8 group 7
 # ip nexthop replace id 7 via 192.0.2.2 fdb
 Error: Cannot change nexthop FDB status while in a group.

[1]
BUG: kernel NULL pointer dereference, address: 00000000000003c0
[...]
Oops: Oops: 0000 [#1] SMP
CPU: 6 UID: 0 PID: 367 Comm: ping Not tainted 6.17.0-rc6-virtme-gb65678cacc03 #1 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
RIP: 0010:fib_lookup_good_nhc+0x1e/0x80
[...]
Call Trace:
 <TASK>
 fib_table_lookup+0x541/0x650
 ip_route_output_key_hash_rcu+0x2ea/0x970
 ip_route_output_key_hash+0x55/0x80
 __ip4_datagram_connect+0x250/0x330
 udp_connect+0x2b/0x60
 __sys_connect+0x9c/0xd0
 __x64_sys_connect+0x18/0x20
 do_syscall_64+0xa4/0x2a0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 38428d68719c ("nexthop: support for fdb ecmp nexthops")
Reported-by: syzbot+6596516dd2b635ba2350@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68c9a4d2.050a0220.3c6139.0e63.GAE@google.com/
Tested-by: syzbot+6596516dd2b635ba2350@syzkaller.appspotmail.com
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/nexthop.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 29118c43ebf5..34137768e7f9 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2399,6 +2399,13 @@ static int replace_nexthop_single(struct net *net, struct nexthop *old,
 		return -EINVAL;
 	}
 
+	if (!list_empty(&old->grp_list) &&
+	    rtnl_dereference(new->nh_info)->fdb_nh !=
+	    rtnl_dereference(old->nh_info)->fdb_nh) {
+		NL_SET_ERR_MSG(extack, "Cannot change nexthop FDB status while in a group");
+		return -EINVAL;
+	}
+
 	err = call_nexthop_notifiers(net, NEXTHOP_EVENT_REPLACE, new, extack);
 	if (err)
 		return err;
-- 
2.51.0


