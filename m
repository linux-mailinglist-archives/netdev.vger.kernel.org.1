Return-Path: <netdev+bounces-225040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F5B8DD22
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 17:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA31B189CE18
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C9B1C862D;
	Sun, 21 Sep 2025 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJccyLUS"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877B1DE4CE
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467433; cv=fail; b=ZkYfMRlXQYrtzHbtP1nmZurKwp4SW0y4ifnIrQ0A6WmL6vxGqEpI7IXRQ/zy6hK5r23wYPEvzYND2dqu7wXletuWJxuwVKuOqjVMJf9vPT+3XRrhDxQsupI2+uyejHkXzZpLgr0N2ssqt5KpjJ/tLvIzZXzkPhPlgLJpmxwVuiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467433; c=relaxed/simple;
	bh=rEqR/+4LiI9/qLkPHzd4i0C8MPDQK9u91cnMa5kn7yU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvU+lAompp/OwRjis5JlJVyBFBkbHAk99vETe11QJLxm9nw10ujf8WqREtu/SM9zQOUecL/7uhqn2CZbgtH4NuPxxR4mCclFQ69iVHIHGH12uWBM96CFUqsj8afWlokL6nGHiwGH/tMjY2qjFeodexApbGFvKyg8cmQ5uboEE6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aJccyLUS; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5jG5GestomkeFrRMMbQudfHI7O2rRUStTqtRQP9zsGZeSODH5xIwUClEbuqQDti7kJfnaB3acJg2MEgatsDXSpCqRDBY6wSsKwUH3qcp+Iac3DBUDfTDzwBF7wfImjmxjhROGBhYDk+LKtDpmKtwFr81ydvrTakMrJnpOBU+U68IZ27aMROYazc6fvpSBsyhp/DU9G5TEdjYy4FlBPgPZvobBx5XMGUkoVQvv/j3PEwNJhRgGB2xj1LrmLpZ+u9tPvjqL+dMLrsr6Bp4pGkhFnspD4Ou/IqK0e6k2dUxc+ZRA/r6thjmHals0G4UfyDkA23uFXhnYFbEBYmMio5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UanMU3HQBpUEkxkFjmSu+wH9BRoRci5IxuLREFlXAyQ=;
 b=k0nyLYCzFj2WcstarQgbHwfDu1dNhJGBKObtN2ilmiDgZP1LT8NjxFSeyh3rxWkyuZGR6FRReDhnXEnNNc6MDuFQll76ZAGgsbeWsbv9BhatcnUDH6CXNAHvN1teiMduE4AMTyogibVmGUrQI3TTn0Sm4nC3EyPKLnCxEBhSXLmVluA35FK/oktVtVpehUCOiXbLncYnDX7LoXXY9gz3s75Q0ri/yOh0g42qA0QXN4KGPZmz3D5R0WmsfBJbotjSvi11iWe06rv7BDgBEJlMeozFtGccUXlm7Sa5DOJvW4kiQYZQvJY3T0dnpTSQT2BGcJHCPYNbvGiAYCDCKdnyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UanMU3HQBpUEkxkFjmSu+wH9BRoRci5IxuLREFlXAyQ=;
 b=aJccyLUSSNHuoSFYOLUTNYQ3nH6S7vA9QGOMhExuHy3EMfz/GAr3lw15WqsdDdXQmK3ZGSiXlDyx9J1BSfOTfcOI3QDb6xvPo4WQb4PNfoz5oaWvDcuRNmBrVVba/3HoBM7p1LVCi7g/b0wSJTeNBx+IxCSytRjYhsLtVoxHGAJFG7Kk1gXjSkPYf5o6NycsgPYUnBrTQ2KFNVe8ne4lmc4muFQtR41bT0+bJ2+qZrc1yoiCfMVZk4ygbUP3Y4hyiviwL+ICPPHx475yeTYLBZwse4H1ZcXzNCW8yZpTwjePTP720SCp64EPEqS6VhhcQOGAzB2zpLRGLJBdAmfWNA==
Received: from SA1PR02CA0006.namprd02.prod.outlook.com (2603:10b6:806:2cf::15)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sun, 21 Sep
 2025 15:10:25 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::b7) by SA1PR02CA0006.outlook.office365.com
 (2603:10b6:806:2cf::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Sun,
 21 Sep 2025 15:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Sun, 21 Sep 2025 15:10:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sun, 21 Sep
 2025 08:10:08 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sun, 21 Sep
 2025 08:10:03 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <horms@kernel.org>,
	<petrm@nvidia.com>, <aroulin@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 3/3] selftests: fib_nexthops: Add test cases for FDB status change
Date: Sun, 21 Sep 2025 18:08:24 +0300
Message-ID: <20250921150824.149157-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9d3e1a-88b3-45e7-f901-08ddf920fe41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QwDr2nUomb6hbmK6Agr/qypJYSbUXx8vuEDKP8Zmbqq/d08hthNkzgZ5fWHR?=
 =?us-ascii?Q?FTg601iTa+4HXNKdihLNAt2Da5pC+JcQu7Ir5ScP5qRRPAMdhM9/R3f8+q6q?=
 =?us-ascii?Q?qFLA++5Km/A8asxKB/M8YpAgeT0uXwKj+d0Dy2OF6asxXN8EJBaGQBhUCCey?=
 =?us-ascii?Q?DjJXezDheyr8tmlUeSP+yre4U2ubyVF5XG+R8AT7ZoVNCDYeYrcfIxnA0uey?=
 =?us-ascii?Q?aXJPQbU5aG0FRqh09jHl74M4CNUzmZ8kDBSaTvOMMBp6fC4hAb3OQmgu4b1M?=
 =?us-ascii?Q?4avMPRru/ZKl2X8ngrljOrnNJcpGDbh7U/E+09+AwOoyLjvQyURd75ulMFjJ?=
 =?us-ascii?Q?bSk30G4w1rOapf63wVpqHuugPbqzFdvuZrQ4gVYXyVpwnXP0wMarzW+Js3Yk?=
 =?us-ascii?Q?jjG8w+Y/uKWvqlY0VfSPTgcwZ4QknCXwWwAMo2ddqwsf2DL2X3hTUPuw63Zs?=
 =?us-ascii?Q?X0WcUjIqhEm1hgEp8egwIu0TFO6WlSXB0PwlXE2D+ENwP2OVh5hojHbP1sTQ?=
 =?us-ascii?Q?gA92X1W1abaXcp8WyTyN2EbAOJlCmMa6XZHxT5MfwYzTc+WXA4ag1u0VPrKj?=
 =?us-ascii?Q?n0yjJ4OmssCT4VO91qus1KjlIpDzZIwiuicbg+axjiZQWd5d4d46kKkvVNm0?=
 =?us-ascii?Q?CjtQjVv7Q8UmSvZVT6wR0VLNvt7GNt4E7Kq86EJsbGs9UFnq7ElkRNeoYPOT?=
 =?us-ascii?Q?zjK/Ku6ZdOIhQJBe5nYzSoXDv5z49Fa8lwgiwqUoA2nRomSo2eiRBBPqD/ux?=
 =?us-ascii?Q?cieSHJ7lbso2WAuc44d2Out9UeDcX/aeMt2r+1LLJ3jE4FtgbNu+Ur54/Qs7?=
 =?us-ascii?Q?PatYVZ1ASIpGmBHntb2VmH/fxHdtQEpDzxBCKoof3sZ1IU1YcEb2tCswbcsD?=
 =?us-ascii?Q?bPhnUzevJ9Qm/fdueCOVkj1zpSVKlevs0Y9gtxVOZmDlvT4vlbcMmNcHRmKU?=
 =?us-ascii?Q?p/yZE/0T88Tm/WqF3s25h4wh5ulOPKM+srLEBr3vZyMEDurLAKiMoXubE5nc?=
 =?us-ascii?Q?h17Wh0lNFhXJN+CJ68szo4iU9kJE+1cb9wQkMPdQVr4+ycdoXWO6XXvV4FcU?=
 =?us-ascii?Q?f/zcP2cmwbCV2CcEFaaoXBdBazFzBMM0R+mNF/4RZvX8f9Odp7CVlC19vf6z?=
 =?us-ascii?Q?oLZLeoaSs3mpLRUgKJX0n2EashJxwL1OUuPTUCZzxyLF7k2CWR3oduMJz311?=
 =?us-ascii?Q?VbFMnPClRMG54+oPml04eLfVbggblmY9dX3cDlfHdFLl8q0nbnEXCmYNLpbh?=
 =?us-ascii?Q?KAnfPvGac/L+UabDFKv1Q2jyLLPJY/uVZBX3gQVRn9g7A05CMZe9jqkrYoIy?=
 =?us-ascii?Q?8zrXw9Og6UzmYVkft5JYc1XpMpKwp90lp8MlaABJdKZ5LKFrZC8Ftjryn5la?=
 =?us-ascii?Q?7Ppfd25qa5nd+GPsFj9zYqRTD2eZcT0SaI/e3vZoarJQJ+HIzKRrOrUu1PY9?=
 =?us-ascii?Q?iTOkNdcOuT201ZBkS/Bgudz469/d8Ip4LOxQb6X2/64Pabs3kmQ9NbuZMSHs?=
 =?us-ascii?Q?8sg/Mp3ivPqx7ZDnbUOZxoy20UJ/4QOXD64Q?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2025 15:10:25.5038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9d3e1a-88b3-45e7-f901-08ddf920fe41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242

Add the following test cases for both IPv4 and IPv6:

* Can change from FDB nexthop to non-FDB nexthop and vice versa.
* Can change FDB nexthop address while in a group.
* Cannot change from FDB nexthop to non-FDB nexthop and vice versa while
  in a group.

Output without "nexthop: Forbid FDB status change while nexthop is in a
group":

 # ./fib_nexthops.sh -t "ipv6_fdb_grp_fcnal ipv4_fdb_grp_fcnal"

 IPv6 fdb groups functional
 --------------------------
 [...]
 TEST: Replace FDB nexthop to non-FDB nexthop                        [ OK ]
 TEST: Replace non-FDB nexthop to FDB nexthop                        [ OK ]
 TEST: Replace FDB nexthop address while in a group                  [ OK ]
 TEST: Replace FDB nexthop to non-FDB nexthop while in a group       [FAIL]
 TEST: Replace non-FDB nexthop to FDB nexthop while in a group       [FAIL]
 [...]

 IPv4 fdb groups functional
 --------------------------
 [...]
 TEST: Replace FDB nexthop to non-FDB nexthop                        [ OK ]
 TEST: Replace non-FDB nexthop to FDB nexthop                        [ OK ]
 TEST: Replace FDB nexthop address while in a group                  [ OK ]
 TEST: Replace FDB nexthop to non-FDB nexthop while in a group       [FAIL]
 TEST: Replace non-FDB nexthop to FDB nexthop while in a group       [FAIL]
 [...]

 Tests passed:  36
 Tests failed:   4
 Tests skipped:  0

Output with "nexthop: Forbid FDB status change while nexthop is in a
group":

 # ./fib_nexthops.sh -t "ipv6_fdb_grp_fcnal ipv4_fdb_grp_fcnal"

 IPv6 fdb groups functional
 --------------------------
 [...]
 TEST: Replace FDB nexthop to non-FDB nexthop                        [ OK ]
 TEST: Replace non-FDB nexthop to FDB nexthop                        [ OK ]
 TEST: Replace FDB nexthop address while in a group                  [ OK ]
 TEST: Replace FDB nexthop to non-FDB nexthop while in a group       [ OK ]
 TEST: Replace non-FDB nexthop to FDB nexthop while in a group       [ OK ]
 [...]

 IPv4 fdb groups functional
 --------------------------
 [...]
 TEST: Replace FDB nexthop to non-FDB nexthop                        [ OK ]
 TEST: Replace non-FDB nexthop to FDB nexthop                        [ OK ]
 TEST: Replace FDB nexthop address while in a group                  [ OK ]
 TEST: Replace FDB nexthop to non-FDB nexthop while in a group       [ OK ]
 TEST: Replace non-FDB nexthop to FDB nexthop while in a group       [ OK ]
 [...]

 Tests passed:  40
 Tests failed:   0
 Tests skipped:  0

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_nexthops.sh | 40 +++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 2ac394c99d01..2b0a90581e2f 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -494,6 +494,26 @@ ipv6_fdb_grp_fcnal()
 	run_cmd "$IP nexthop add id 69 encap mpls 101 via 2001:db8:91::8 dev veth1 fdb"
 	log_test $? 2 "Fdb Nexthop with encap"
 
+	# Replace FDB nexthop to non-FDB and vice versa
+	run_cmd "$IP nexthop add id 70 via 2001:db8:91::2 fdb"
+	run_cmd "$IP nexthop replace id 70 via 2001:db8:91::2 dev veth1"
+	log_test $? 0 "Replace FDB nexthop to non-FDB nexthop"
+	run_cmd "$IP nexthop replace id 70 via 2001:db8:91::2 fdb"
+	log_test $? 0 "Replace non-FDB nexthop to FDB nexthop"
+
+	# Replace FDB nexthop address while in a group
+	run_cmd "$IP nexthop add id 71 group 70 fdb"
+	run_cmd "$IP nexthop replace id 70 via 2001:db8:91::3 fdb"
+	log_test $? 0 "Replace FDB nexthop address while in a group"
+
+	# Cannot replace FDB nexthop to non-FDB and vice versa while in a group
+	run_cmd "$IP nexthop replace id 70 via 2001:db8:91::2 dev veth1"
+	log_test $? 2 "Replace FDB nexthop to non-FDB nexthop while in a group"
+	run_cmd "$IP nexthop add id 72 via 2001:db8:91::2 dev veth1"
+	run_cmd "$IP nexthop add id 73 group 72"
+	run_cmd "$IP nexthop replace id 72 via 2001:db8:91::2 fdb"
+	log_test $? 2 "Replace non-FDB nexthop to FDB nexthop while in a group"
+
 	run_cmd "$IP link add name vx10 type vxlan id 1010 local 2001:db8:91::9 remote 2001:db8:91::10 dstport 4789 nolearning noudpcsum tos inherit ttl 100"
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:13 dev vx10 nhid 102 self"
 	log_test $? 0 "Fdb mac add with nexthop group"
@@ -574,6 +594,26 @@ ipv4_fdb_grp_fcnal()
 	run_cmd "$IP nexthop add id 17 encap mpls 101 via 172.16.1.2 dev veth1 fdb"
 	log_test $? 2 "Fdb Nexthop with encap"
 
+	# Replace FDB nexthop to non-FDB and vice versa
+	run_cmd "$IP nexthop add id 18 via 172.16.1.2 fdb"
+	run_cmd "$IP nexthop replace id 18 via 172.16.1.2 dev veth1"
+	log_test $? 0 "Replace FDB nexthop to non-FDB nexthop"
+	run_cmd "$IP nexthop replace id 18 via 172.16.1.2 fdb"
+	log_test $? 0 "Replace non-FDB nexthop to FDB nexthop"
+
+	# Replace FDB nexthop address while in a group
+	run_cmd "$IP nexthop add id 19 group 18 fdb"
+	run_cmd "$IP nexthop replace id 18 via 172.16.1.3 fdb"
+	log_test $? 0 "Replace FDB nexthop address while in a group"
+
+	# Cannot replace FDB nexthop to non-FDB and vice versa while in a group
+	run_cmd "$IP nexthop replace id 18 via 172.16.1.2 dev veth1"
+	log_test $? 2 "Replace FDB nexthop to non-FDB nexthop while in a group"
+	run_cmd "$IP nexthop add id 20 via 172.16.1.2 dev veth1"
+	run_cmd "$IP nexthop add id 21 group 20"
+	run_cmd "$IP nexthop replace id 20 via 172.16.1.2 fdb"
+	log_test $? 2 "Replace non-FDB nexthop to FDB nexthop while in a group"
+
 	run_cmd "$IP link add name vx10 type vxlan id 1010 local 10.0.0.1 remote 10.0.0.2 dstport 4789 nolearning noudpcsum tos inherit ttl 100"
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:13 dev vx10 nhid 102 self"
 	log_test $? 0 "Fdb mac add with nexthop group"
-- 
2.51.0


