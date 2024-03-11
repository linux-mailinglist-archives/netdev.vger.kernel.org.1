Return-Path: <netdev+bounces-79225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023D787856C
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDEB1F217F8
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A24AEC0;
	Mon, 11 Mar 2024 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nTlfH6mR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A374F1E5
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174256; cv=fail; b=FJ8h6NEB3Ef3nqlPUhygn89EGbhYISB6D3YSBwUCmdBA/8uSFcTa/W3AT+WR8sSK7jusd07CBkrOpADUXlXqvTPdtHz+pFntfOaEBRX0rhYVN29B9wDt0WaftSd5JBlZzJJZ6ERFDJ49I7+jUZRJtTRBVmYusVmZqG4T4Oh73Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174256; c=relaxed/simple;
	bh=bR5REPjw1FjZrdC2h/AfjWvhvyVpjvknj5OV+Jh5w5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SW3q7DSQi6zLl1d+41dz3uqmK7QA8FriKDLlyIniMsuTu/oidxCcdvAXNHZVRkxLDSuw6MW+Lfv+FS2YwDiPARNmUyU5+KHa2nQcqYZA2gwIlatQBYBCHNPbaNK6aE6WVXL9R7TmZ+pJRrpcnL60YK0Gr23bsBtCt5oiga5lg9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nTlfH6mR; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7AF8MPXxRXBEUXb9fdMwadquZhoik/kySe6qXH1deDTQv0qbRnzfNf5Lhtw7ZBtj/rLeFBWBiN9w4Db/3WfMF55URu8YqHXvw7upz45JQplLrhyrUcYglYXPEoXVhlwuqVI8g/Fc4l2CQErfMuSGuyw4vjs1kQ+xGCqI4isodcQxU8f+kMKya/ZNmYjoO7JlKyPaTyIKU/oZbEqUSEz86JrRTZ7Y7u4GvQCZ6It2kcWfTUjiQuHoarw9ipr+jNueUZy/Pwp6UOt9Vde6T4GFmLfqz6874eyb+A0VSyqXS5rcjIj82ZdIPDfca+xek/5vdyThnvzZZWT/lFZCW6eFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXWSRFjXEDssIRmhqC/MZXA+fWmhyOO66AJI6QyO8i4=;
 b=WuqY4bEwA77NwCzBwjyGsGF5DXSRHK/z4GUozmOaIRWCMPFoc2hX9wJEfzFOzcQpbsgCoHm7dQMJOHb/jwJGTTz0DoKdMZfW034q8MZ5kUKr6dnwsQpfIDhV+VumRhCjbLfo/oabqPi+aLJPJt0TrrSxPm/tMboYU93wU5OTVDOfWM5Wil0zPg90/fBSvH70+OqSx2Qzm0DP7OOWm8DglXaCs3/lU98kkiciY2agoqkTEmiJWfk7WyqBEX6QuppCMPDBmcXpDvyYnrbKbC7GQJ+QyxYB4IRtyA4nh/Jdl7sA5WoPBkYmAMU2HZKX0ylGZTm026fMrTKYezZ87qbMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXWSRFjXEDssIRmhqC/MZXA+fWmhyOO66AJI6QyO8i4=;
 b=nTlfH6mReefH4tCksGWun3/LFKGT0jwBqgoAdGVbJPPIvTfrNteD6d7eY4xkKE5B7/NBqSR7f9MiHoo39WcL4hV0jMPyg2C+6CbEMU0zAhLDmgq6UVaX7NhtllEKE7XdhQW1wFTyeV1xPnUO18DklAVAXGGtuMfyKuKenAwCwaKMkM7/W8dQ2KKRU0Ofcgf33orAxx0p5Rjbr3v0fusiWmLhF44SfLFxLqXDa507qRvnlzFHN+HyzJMA1Z2BpcATi4ABOhrTQ2gTMw7Kb0BnWqqDTlctrmMlnM9RTM7z58CrPB7K6MsLBlnvjaYz+fhGrSMiywLqdlX6xbqlX23z1Q==
Received: from SJ2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:a03:505::23)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 16:24:09 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::cf) by SJ2PR07CA0021.outlook.office365.com
 (2603:10b6:a03:505::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 16:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 16:24:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 09:23:53 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 11 Mar 2024 09:23:50 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next v2 3/4] nexthop: Fix out-of-bounds access during attribute validation
Date: Mon, 11 Mar 2024 18:23:06 +0200
Message-ID: <20240311162307.545385-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311162307.545385-1-idosch@nvidia.com>
References: <20240311162307.545385-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5fe2f3-d1ed-4ba5-9c61-08dc41e7adb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qWViTuaf0giqRzk8soV0tNKY+kr385525nFz7NzS1uGu92xA1QNojWR29dvYRNKgCs8d77Hv7Gs9rvY3R23SDQCzdsKTi3FcQfp+j2U6HoS3bHUmX29kI+s1bL9gzMfCCAI0+G866Y1jH4GHYjgIbRb2Zmz/K2FnhIxW5JyrzA2MEYlr8bgLimj2XudH752wtBHsl00DMY3v7hbQMWw2K6u4iEE8tiWt8ORCgUFSgUl6PSCwy7iyuX5+XnbvfyZvPxKpXloybvIvlAEQkMr/Z87GTZBdcwHgrDO86eOIA6x9IzTOIaLuV2G3+lGacbCanl5t/wTTs6sMEebTwU/hxsI8sDJLmRZ5LadLV+stfmfwKk0vFaDu/0aKwq0D53zYy3n/53U4Ti8JNiTbbEtNe7b9wKBblbx5eEZ12SazDQRBlvSC9b2IEO40KhWIdKAMOkWno9wkwUs55o6edpqrmemCwjSywVnJvZC3H7EvK8xdojMHqdFR9ruflQ7GBSJYoduiXGiZb43KUB5l9/aBQLSI2d33S06uw4Mzkp5kAe6TTBWArvGXY5StnOOJ5ZlFy3myk/ZkfNB5318S+NRPw7T2NxnBfjxv28moXa4qf9RktzIMPXZtct0XHpYcVRMVeLDBuxlPTqTZLa+LGEExx67dUbbN93zSyQsHTvLof+GKCWGUGeJOBuzhJsNJSZHmcCjjE6BUlrm5tnM0zIw/+vl5e8A44tlmtkuXrwbRcw7qSvDHHX+1ojeiW6lh+KfbyF46xomV5BgP3Ug29tmYWQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:24:08.5866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5fe2f3-d1ed-4ba5-9c61-08dc41e7adb1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

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

Notes:
    v2:
    * Resize 'tb' using ARRAY_SIZE

 net/ipv4/nexthop.c                          | 29 ++++++++++++---------
 tools/testing/selftests/net/fib_nexthops.sh |  6 +++++
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 573da3660cb3..0011b0076c5b 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3243,8 +3243,8 @@ static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
 static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 			   struct netlink_ext_ack *extack)
 {
+	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_del)];
 	struct net *net = sock_net(skb->sk);
-	struct nlattr *tb[NHA_MAX + 1];
 	struct nl_info nlinfo = {
 		.nlh = nlh,
 		.nl_net = net,
@@ -3254,8 +3254,9 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int err;
 	u32 id;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
-			  rtm_nh_policy_del, extack);
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
+			  ARRAY_SIZE(rtm_nh_policy_del) - 1, rtm_nh_policy_del,
+			  extack);
 	if (err < 0)
 		return err;
 
@@ -3276,16 +3277,17 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 			   struct netlink_ext_ack *extack)
 {
+	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_get)];
 	struct net *net = sock_net(in_skb->sk);
-	struct nlattr *tb[NHA_MAX + 1];
 	struct sk_buff *skb = NULL;
 	struct nexthop *nh;
 	u32 op_flags;
 	int err;
 	u32 id;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
-			  rtm_nh_policy_get, extack);
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
+			  ARRAY_SIZE(rtm_nh_policy_get) - 1, rtm_nh_policy_get,
+			  extack);
 	if (err < 0)
 		return err;
 
@@ -3404,10 +3406,11 @@ static int nh_valid_dump_req(const struct nlmsghdr *nlh,
 			     struct nh_dump_filter *filter,
 			     struct netlink_callback *cb)
 {
-	struct nlattr *tb[NHA_MAX + 1];
+	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_dump)];
 	int err;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
+			  ARRAY_SIZE(rtm_nh_policy_dump) - 1,
 			  rtm_nh_policy_dump, cb->extack);
 	if (err < 0)
 		return err;
@@ -3547,10 +3550,11 @@ static int nh_valid_dump_bucket_req(const struct nlmsghdr *nlh,
 				    struct netlink_callback *cb)
 {
 	struct nlattr *res_tb[ARRAY_SIZE(rtm_nh_res_bucket_policy_dump)];
-	struct nlattr *tb[NHA_MAX + 1];
+	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_dump_bucket)];
 	int err;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
+			  ARRAY_SIZE(rtm_nh_policy_dump_bucket) - 1,
 			  rtm_nh_policy_dump_bucket, NULL);
 	if (err < 0)
 		return err;
@@ -3715,10 +3719,11 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
 				   u32 *id, u16 *bucket_index,
 				   struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[NHA_MAX + 1];
+	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_get_bucket)];
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


