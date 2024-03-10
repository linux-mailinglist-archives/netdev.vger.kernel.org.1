Return-Path: <netdev+bounces-79032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791F28777C5
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 18:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D1F2814D4
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 17:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEA339870;
	Sun, 10 Mar 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K1woLndj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197DE39855
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710091992; cv=fail; b=gIoKZB8gdpi6i+00ioE8LccMTyTZlXbeWF5dyx7nfVf7ilEsO865P8T13tGwChaYR/txZcnvxVe9oAGqC9M0lL05ecXUu4vsUqUnxVKjPqdrsnOkwdS/TKohJbQRIsGHBOUqTML83ApndK9kBaSXpMNpkWJ34hFj7/vBQEHPCCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710091992; c=relaxed/simple;
	bh=g0+CBKfvbi395mrWFJkpbYlAsP5wVwZO+1rwRKGdDRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jutqt3nUC0GJU3PYd8bxhXXQLaWRycLngN5BRv5w+Mxb2oN/eQSIDCNt/jsoV7ajljK3dw/JaFaLvQ/FH5Xm1Ymb6Kn78951UzhDXaT7vYCdaTecS3NY3dOOzJxjOkjUXZmnqKqEoMIB6fUoRBl4RTz5m9jybQwl63zYpM71+q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K1woLndj; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggT98nAL7wG2p+MpYPK5O/ma9SSOHmoawhJDoybHSvlwxZM9JgmzBfXDHvCI3j1i5rklxfwWfThXLJhn2XuvaPunBFjwfe8V3d3dAFGlStdbol9oH7Qv+v5klywZ5O0m9JYMAQPl2K/L5gs7EUy+JtaA/UG/XlI4yM7VVP1XOvuoSIOUjqa7YMDa1zGQpdhbyV1OkTlmNcgiHkRbtqnTUEFjHftUdxUkaWVbmVCcRgZBY1Mws5p3Demry2ieY9PCrUW2xZKRuNtMNxkFrQ2TzhmmSNbbSpFzfjMcTWf2Z+c2UqDb+dUzraLb8vhxCd/AMszb/cpvNH5zwreqrCZFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbbHS7NdcJZqG86evC4uEx3mDVsAKtCveNi4/m6LbhY=;
 b=hWDJy4WUTngSESEdxdPdVwZuM/MnRI8qEC/O3xXD/dyG8mEG8jWO7l7BWPDbQ3KLPPV0MTmaYP3aVJozigVNL9/VnDUjNL8D2Xa+HINqdOx4uuNrD0zgMEuoMZT920H6FWBQp2CM/gd701f0L9SsNdBq6UN/+aObbHMwnJb52D3VjoJTOc6EruEy7oRST8HNyCalBTCu/FJeek5f6QhzIXRHINOsUkF+axTKyNCnMJyY7H1JUPnLkb3WSZANCahX/xBVSOjQFHvlCP2SHN4mZ/s6dZBhvhiz7W0gXeWBuq4StMNwR8YPkPKtegJ4v0z3YhV7KSs8/pjuBUIfXEni/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbbHS7NdcJZqG86evC4uEx3mDVsAKtCveNi4/m6LbhY=;
 b=K1woLndjp1Bct38vk3BOr6US4ojNwK/nAyopmUKJ5g95GA84XyqGypErppJRWv9307Pykal899ujehKKr8ZNEp2tDWSot00n3O3DdUSXlKzJew2RGnnPq0V870JDlk0P8SwZmB1FDS2Jqo8J774RQV28dftA17OsKBWRBTh3F5jrxEokVb23R4M0wpKCfIe8D/oj/CP+7UP88oBCyWE2uvZYA9ITXP2CL7EX+gKvgbFYvRpn4ErhrlNlrOKsQ8Wlyitet3CqRYIPVjkfDOK9FwkLjMopn3gkmsPpyN1V76KrVCbnF7Ywuay6pyVaygoHR+avR2VPM6+S96aAw719dQ==
Received: from CH0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:610:b1::34)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Sun, 10 Mar
 2024 17:33:08 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::d) by CH0PR13CA0029.outlook.office365.com
 (2603:10b6:610:b1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Sun, 10 Mar 2024 17:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Sun, 10 Mar 2024 17:33:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 10 Mar
 2024 10:33:00 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 10 Mar 2024 10:32:58 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 1/2] nexthop: Fix out-of-bounds access during attribute validation
Date: Sun, 10 Mar 2024 19:32:14 +0200
Message-ID: <20240310173215.200791-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240310173215.200791-1-idosch@nvidia.com>
References: <20240310173215.200791-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 4843eadd-29db-4e83-1297-08dc412826db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YYF6z9EzOBnJR5AmqWNCI8wh5oBojI6MDtZS9YMXJFPigmEteI3aGPY9ZtzqaHpMTDFf6jbEOunzyAmXye1ZsRwYy9wiJNXwLwLZArWFQdPKIPBMLieBeX2GiiNhpeb8F7apn9fYfPDlMuwFk4RYqJcozKjvFB/SyATAwHq0JmYFOv/ugW7qyxT7G1MOz4k2W3h1fic6KwqLChFaSfDKAS1inMnNUbMtEjfQhVoaPqwNExd8OuX4LW4xSHTtpZ2WrD8ZPNIfZESw9/g4CWwxGOCP+dwfVUMBIzBWolzjJKPyRV3oSOgw6VwGP0t4ff0Yd5cwssRn1Q8ZI1UkpzUeGiOscbqK6DWqljVlQkOnC0P8A+oOKPf7T61NwrkmAruNNVv7N+RoFTJSb7Q7MiImjz7qbgGSG2VEv8pwVZzypIw75wRYcR4vEcnWSQV8hFwFOwNCkdnGD/Qw9/9fKwbNKYL7II+Cg3/uAU2/uUOomJrM/XZqtW0K0b20yk2FOBZSOkJfiSQe2Mh9RiSvm5LK237QbqGUChTj7XBMwOODtIyIZxgDrbtxBEaUtxJ4KG8OduLG22bWNOd3iyv6Tjxr/HZsR2e3LjNMqXYecOZ4l/A9AKs5kYxHwgnBE0n+CuCUa2c8ThtxvCLhsGk9VzmnB+5LJzmbnKPh+vtXpNLSVxo0wGvl0QzW5EOqYC/r1ZsFEbnHkgVPzTbFtRwFEL9mBMbetgz7Gzs8u2w1+pZNNIU6tCJMzmmxD+Rp4l6EMfF47HzjD2w6rxuwGELpfsJmKg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 17:33:08.4593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4843eadd-29db-4e83-1297-08dc412826db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547

Passing a maximum attribute type to nlmsg_parse() that is larger than
the size of the passed policy will result in an out-of-bounds access [1]
when the attribute type is used as an index into the policy array.

Fix by setting the maximum attribute type according to the policy size,
as is already done for RTM_NEWNEXTHOP messages. Add a test case that
triggers the bug.

No regressions in fib nexthops tests:

 # ./fib_nexthops.sh
 [...]
 Tests passed: 236
 Tests failed:   0

[1]
BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x1e53/0x2940
Read of size 1 at addr ffffffff99ab4d20 by task ip/610

CPU: 3 PID: 610 Comm: ip Not tainted 6.8.0-rc7-custom-gd435d6e3e161 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x8f/0xe0
 print_report+0xcf/0x670
 kasan_report+0xd8/0x110
 __nla_validate_parse+0x1e53/0x2940
 __nla_parse+0x40/0x50
 rtm_del_nexthop+0x1bd/0x400
 rtnetlink_rcv_msg+0x3cc/0xf20
 netlink_rcv_skb+0x170/0x440
 netlink_unicast+0x540/0x820
 netlink_sendmsg+0x8d3/0xdb0
 ____sys_sendmsg+0x31f/0xa60
 ___sys_sendmsg+0x13a/0x1e0
 __sys_sendmsg+0x11c/0x1f0
 do_syscall_64+0xc5/0x1d0
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
[...]

The buggy address belongs to the variable:
 rtm_nh_policy_del+0x20/0x40

Fixes: 2118f9390d83 ("net: nexthop: Adjust netlink policy parsing for a new attribute")
Reported-by: Eric Dumazet <edumazet@google.com>
Closes: https://lore.kernel.org/netdev/CANn89i+UNcG0PJMW5X7gOMunF38ryMh=L1aeZUKH3kL4UdUqag@mail.gmail.com/
Reported-by: syzbot+65bb09a7208ce3d4a633@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/00000000000088981b06133bc07b@google.com/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/nexthop.c                          | 19 ++++++++++++-------
 tools/testing/selftests/net/fib_nexthops.sh |  6 ++++++
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 5eb3ba568f4e..f3df80d2b980 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3253,8 +3253,9 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int err;
 	u32 id;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
-			  rtm_nh_policy_del, extack);
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
+			  ARRAY_SIZE(rtm_nh_policy_del) - 1, rtm_nh_policy_del,
+			  extack);
 	if (err < 0)
 		return err;
 
@@ -3283,8 +3284,9 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	int err;
 	u32 id;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
-			  rtm_nh_policy_get, extack);
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
+			  ARRAY_SIZE(rtm_nh_policy_get) - 1, rtm_nh_policy_get,
+			  extack);
 	if (err < 0)
 		return err;
 
@@ -3411,7 +3413,8 @@ static int nh_valid_dump_req(const struct nlmsghdr *nlh,
 	struct nlattr *tb[NHA_MAX + 1];
 	int err;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
+			  ARRAY_SIZE(rtm_nh_policy_dump) - 1,
 			  rtm_nh_policy_dump, cb->extack);
 	if (err < 0)
 		return err;
@@ -3549,7 +3552,8 @@ static int nh_valid_dump_bucket_req(const struct nlmsghdr *nlh,
 	struct nlattr *tb[NHA_MAX + 1];
 	int err;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
+			  ARRAY_SIZE(rtm_nh_policy_dump_bucket) - 1,
 			  rtm_nh_policy_dump_bucket, NULL);
 	if (err < 0)
 		return err;
@@ -3718,7 +3722,8 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
 	u32 op_flags;
 	int err;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
+			  ARRAY_SIZE(rtm_nh_policy_get_bucket) - 1,
 			  rtm_nh_policy_get_bucket, extack);
 	if (err < 0)
 		return err;
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index d5a281aadbac..ac0b2c6a5761 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -2066,6 +2066,12 @@ basic()
 	run_cmd "$IP nexthop get id 1"
 	log_test $? 2 "Nexthop get on non-existent id"
 
+	run_cmd "$IP nexthop del id 1"
+	log_test $? 2 "Nexthop del with non-existent id"
+
+	run_cmd "$IP nexthop del id 1 group 1/2/3/4/5/6/7/8"
+	log_test $? 2 "Nexthop del with non-existent id and extra attributes"
+
 	# attempt to create nh without a device or gw - fails
 	run_cmd "$IP nexthop add id 1"
 	log_test $? 2 "Nexthop with no device or gateway"
-- 
2.43.0


