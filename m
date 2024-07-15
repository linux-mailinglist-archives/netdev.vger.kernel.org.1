Return-Path: <netdev+bounces-111515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EDA9316A3
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A887B28157B
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5BC18EA68;
	Mon, 15 Jul 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MwsIcguU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85FB18EA62
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053542; cv=fail; b=Gx+z4q8zNSMyr/TlnoFCsJ4qV9qbUNJWcqqN/k0MoaN81xpcRUM5S3DxCqMUBWH01aIpYEgANBlKkHt6ziJ0GCi9VsnlyX4XTbGKwuf/tQZRyAZkX/TnTlRK0rcPGQXiHKCdhgOowJVC4BLuRv2VDSHv3cSSjxGXcxPm/SnCqxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053542; c=relaxed/simple;
	bh=IKVtjLITyK//ne4q2Mu8idvwNQ2tYAM2x0498dPIExs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFdVjxnskhnM3nBVmyBFygJcmJZSSaSlhVAPBe026wiLutookNnQvLeGNak7/r8N+1Wd0LUvSpVb30cTRs97KFrV7udu/sHFuM8BzVLlRx0WhfjDPo3/bTRnfT/44HeiKB6v1Hf3yelZzJFI2+IY3vq8gKnMrlTVpjdZXTiAQGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MwsIcguU; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k18cSNViAFVF7lkY5HyYyocuhIgi7Lu51uco8HHnktKCDBdBL6g25MvTxFzUPTIziw8MGcWiJGIod53oBvEPHFNXjWOUTwsrz4Mdo81kFE25KNvaofC1kGDWvlvwwf2peySo3DVd5ErVRJyGN4YAhp0hNnYd3RSnYyT+2/9g7ce7TJGgLr+PeCrMT4JXFE0aKwANmKt3Zik1wPklivnzrQXeoOxjfGSRl9/+TTzMRGLVdAPsIWedYdMidcorxFABEjqr+1US+uDimZwW3MiS2bvFeU897UJWsTvHYcobdr3K8eHbXnkF9VkJuMjRr/UHOA+RQGnsnNfQM4NsOC0LJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65Dm9BwACDetKrifQv2kSQo5WOZfl8ms8rAi+1u3fPk=;
 b=Ag6vo9ArCJQzAzDKnOqt6Nf5M1tj8XrArAy5wz53Z2rP+AaMQWa5j69rQJqpsMwGgD4KM9bItiOa7cQ0wHy3dlD6u6jsm5pjxTbo74/yP7GrXMCXGF/LmluRreEh0lLsQHdG8TeC9qD6+bjQxf+gYk9POIBvyzrWkC8TuVxJfhHS0vvrT3pJAOXC8POU/y7Q7kPxXYBWWL6qH2U8oFDk7faCQqyJ33BXnIkR9ridKAxUCPmQObcB94nkDfK6OIU+CqnY6FCwz99Vcqm3jHJ5iH2lF52PofW0FCDIBhqj0iGd0C16A5M9cnI6wuJce53cPTfd84fn/vM1Cw6YeGiIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65Dm9BwACDetKrifQv2kSQo5WOZfl8ms8rAi+1u3fPk=;
 b=MwsIcguU5hunNrMS6KRWsC6lxgSLPfiwQU8EbYoIqu0f/WKgOAtSwxPkoWMUE/3jnKXehc/lyvOWM8NQqyUCFWg5JiXOz2NJ6R2uu7nsaKp0zfneDLa7Si94TMk1DYZ5/SSVkryy1U0wD4AhunJVD2jj/wCWJic57oi6uSK+E48JEZprYKTlCG21x13QTWrFcPhM4y51hC9DlugKerLNPkKOYI8biry11a8RFw8Ux0MqaQKRhbHtlNKbPwyskBs5yJQH3A8p4tVLKkPtQ4ciUDNEg64h2iICZMFXsebNqmJf6kGRv9aAirhUxO5C8upkYFw7tKCydd9aF9UXf9WGhQ==
Received: from PH8PR02CA0022.namprd02.prod.outlook.com (2603:10b6:510:2d0::12)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:25:34 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::1f) by PH8PR02CA0022.outlook.office365.com
 (2603:10b6:510:2d0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 14:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 14:25:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 15 Jul
 2024 07:25:17 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 15 Jul 2024 07:25:14 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>,
	<roopa@cumulusnetworks.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 2/2] ipv4: Fix incorrect TOS in fibmatch route get reply
Date: Mon, 15 Jul 2024 17:23:54 +0300
Message-ID: <20240715142354.3697987-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240715142354.3697987-1-idosch@nvidia.com>
References: <20240715142354.3697987-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0e6013-54b2-4355-5407-08dca4d9fd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r4rdoc6fblm9qvsE8r8IcWcvLRUsSlKjV1eDFvEW4LaJJkxq/OJjv9hZN8Ii?=
 =?us-ascii?Q?L8JN5qO6BE90Xy2hTosg8zyLnHgFERk97iEfunYnsYkjLt6Af778mC44TMfr?=
 =?us-ascii?Q?qkKQNjwjmR1vCW/jJTmNZVHJBt/Q9rJd1rAnbYj2/ddi3V64SvKgyVI8Omm7?=
 =?us-ascii?Q?P0a23BcCXrfEBHgoKUBaJiXZqE0a4hgmm3Q6lEmvFerFUdE6I65td+cgVUoO?=
 =?us-ascii?Q?jeMMv+iau4jGm6B7fgfX6l6/dbDuUkk7pMNKq1sIMEkwTWip078dJettHd6s?=
 =?us-ascii?Q?m+L0wiVqE52KYJ67rsCLNbvjZAvfZMoQ7W/pZXgsupVDrPAVypF5zMh+RBmN?=
 =?us-ascii?Q?fyfNXUeIYJBI8m1ZtC3pOHt9Oo9f79hwfFdkFLRf4Y67j/NgC+SiEAiw+aLg?=
 =?us-ascii?Q?PgML/hbLCp33UuLX59rZwwdGrd3E2StbG+yZgEdcFAi2sJW3zXrYv/pKiA9e?=
 =?us-ascii?Q?YCiKPnC3Q6mnS0Stt/623p9BY8RTpeix/PK/O1xvm/Aw1lS0hB3c5TLoovfn?=
 =?us-ascii?Q?SkNmH2rXW5SV9gWFcHnZ6cYgnP2QyD3QvZCjGIp2OVt/y4msWatWxU8FKfsI?=
 =?us-ascii?Q?pJdsFvGaZGiodsX76sHQITvpS5mLTx9y5iI5d2DndJe1ebyOR9exQhPoPqkl?=
 =?us-ascii?Q?OsyV3vtw+c1s06t7bF1Wrx6qF8lGv2lVwM6VUv3nJAyWFkyusx1HC7NyG/Vb?=
 =?us-ascii?Q?OPBCc8shOs4FpL/oyXmmjn8wAu7nmfcsdT/pxnfqjYi6eBQQ/X8EcBao8W/E?=
 =?us-ascii?Q?17Z/StY6mlpe4OfWrAihXXHodyPSb/wKHb3Qsv319UgZpHBcst7MPx7hoUC3?=
 =?us-ascii?Q?xX1R9l7XYIpiZeWmG/dSHrxmZ5jLHs6QPksfMwutPhSd/X7bwm1lKNuoTkZb?=
 =?us-ascii?Q?1IIb2LI2r2uLTjGD1B5EtVm2oup4O34H/mYY0KwGnJSylOwS3iw9T+RQFsZj?=
 =?us-ascii?Q?FLW0EGLiNhn+ZS4VzjbUXII4jg+9XLposHF3uekyj/uxMxbqN8RF8I3IvUIv?=
 =?us-ascii?Q?D1YqAin85Qxl8FxABpzu2x6Vy5zUk0g/bb5IEQkh6Ampm6O+f+07Y3cPrUN2?=
 =?us-ascii?Q?p2iO7ZGl4nrtRkLSnWtuGJ/91r6tZvGn+M/6NPQmwkxo5XtPK4bcZ9AuPGoo?=
 =?us-ascii?Q?+PdA+TDNAENS03HGMc8KLQFJjl+/bSDPrnEs8BCtD3EnSjI8wpMbpNiWxM1J?=
 =?us-ascii?Q?d4peB3sm87zA/eNUYjTFcLcW8grw2ie3n8/FxrujD3G9VBio8dReIu5krWG+?=
 =?us-ascii?Q?0/k5yyHS5MxT8ONM+cm2cVCyqxdqjStMsfSZM3lpjchFNFUvLs951km1tg55?=
 =?us-ascii?Q?yOUiWZohYOuNj0vtmn0QmWozsp0BWTTbElk5Yc+KXOKVO3qQA1nnmgeubgpP?=
 =?us-ascii?Q?lPxJrYegwd8dlOs5hX46L2AYCTBICQDdFFZnjAQG8vNMuVaizzXHG7aSktqR?=
 =?us-ascii?Q?6kfUnjlhppVWI0MCTNxsuZi5fvtoZIG3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:25:34.1663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0e6013-54b2-4355-5407-08dca4d9fd35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

The TOS value that is returned to user space in the route get reply is
the one with which the lookup was performed ('fl4->flowi4_tos'). This is
fine when the matched route is configured with a TOS as it would not
match if its TOS value did not match the one with which the lookup was
performed.

However, matching on TOS is only performed when the route's TOS is not
zero. It is therefore possible to have the kernel incorrectly return a
non-zero TOS:

 # ip link add name dummy1 up type dummy
 # ip address add 192.0.2.1/24 dev dummy1
 # ip route get fibmatch 192.0.2.2 tos 0xfc
 192.0.2.0/24 tos 0x1c dev dummy1 proto kernel scope link src 192.0.2.1

Fix by instead returning the DSCP field from the FIB result structure
which was populated during the route lookup.

Output after the patch:

 # ip link add name dummy1 up type dummy
 # ip address add 192.0.2.1/24 dev dummy1
 # ip route get fibmatch 192.0.2.2 tos 0xfc
 192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1

Extend the existing selftests to not only verify that the correct route
is returned, but that it is also returned with correct "tos" value (or
without it).

Fixes: b61798130f1b ("net: ipv4: RTM_GETROUTE: return matched fib result when requested")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/route.c                         |  2 +-
 tools/testing/selftests/net/fib_tests.sh | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 7790a8347461..3473e0105e29 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3332,7 +3332,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		fri.tb_id = table_id;
 		fri.dst = res.prefix;
 		fri.dst_len = res.prefixlen;
-		fri.dscp = inet_dsfield_to_dscp(fl4.flowi4_tos);
+		fri.dscp = res.dscp;
 		fri.type = rt->rt_type;
 		fri.offload = 0;
 		fri.trap = 0;
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 73895711cdf4..5f3c28fc8624 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -1737,53 +1737,53 @@ ipv4_rt_dsfield()
 
 	# DSCP 0x10 should match the specific route, no matter the ECN bits
 	$IP route get fibmatch 172.16.102.1 dsfield 0x10 | \
-		grep -q "via 172.16.103.2"
+		grep -q "172.16.102.0/24 tos 0x10 via 172.16.103.2"
 	log_test $? 0 "IPv4 route with DSCP and ECN:Not-ECT"
 
 	$IP route get fibmatch 172.16.102.1 dsfield 0x11 | \
-		grep -q "via 172.16.103.2"
+		grep -q "172.16.102.0/24 tos 0x10 via 172.16.103.2"
 	log_test $? 0 "IPv4 route with DSCP and ECN:ECT(1)"
 
 	$IP route get fibmatch 172.16.102.1 dsfield 0x12 | \
-		grep -q "via 172.16.103.2"
+		grep -q "172.16.102.0/24 tos 0x10 via 172.16.103.2"
 	log_test $? 0 "IPv4 route with DSCP and ECN:ECT(0)"
 
 	$IP route get fibmatch 172.16.102.1 dsfield 0x13 | \
-		grep -q "via 172.16.103.2"
+		grep -q "172.16.102.0/24 tos 0x10 via 172.16.103.2"
 	log_test $? 0 "IPv4 route with DSCP and ECN:CE"
 
 	# Unknown DSCP should match the generic route, no matter the ECN bits
 	$IP route get fibmatch 172.16.102.1 dsfield 0x14 | \
-		grep -q "via 172.16.101.2"
+		grep -q "172.16.102.0/24 via 172.16.101.2"
 	log_test $? 0 "IPv4 route with unknown DSCP and ECN:Not-ECT"
 
 	$IP route get fibmatch 172.16.102.1 dsfield 0x15 | \
-		grep -q "via 172.16.101.2"
+		grep -q "172.16.102.0/24 via 172.16.101.2"
 	log_test $? 0 "IPv4 route with unknown DSCP and ECN:ECT(1)"
 
 	$IP route get fibmatch 172.16.102.1 dsfield 0x16 | \
-		grep -q "via 172.16.101.2"
+		grep -q "172.16.102.0/24 via 172.16.101.2"
 	log_test $? 0 "IPv4 route with unknown DSCP and ECN:ECT(0)"
 
 	$IP route get fibmatch 172.16.102.1 dsfield 0x17 | \
-		grep -q "via 172.16.101.2"
+		grep -q "172.16.102.0/24 via 172.16.101.2"
 	log_test $? 0 "IPv4 route with unknown DSCP and ECN:CE"
 
 	# Null DSCP should match the generic route, no matter the ECN bits
 	$IP route get fibmatch 172.16.102.1 dsfield 0x00 | \
-		grep -q "via 172.16.101.2"
+		grep -q "172.16.102.0/24 via 172.16.101.2"
 	log_test $? 0 "IPv4 route with no DSCP and ECN:Not-ECT"
 
 	$IP route get fibmatch 172.16.102.1 dsfield 0x01 | \
-		grep -q "via 172.16.101.2"
+		grep -q "172.16.102.0/24 via 172.16.101.2"
 	log_test $? 0 "IPv4 route with no DSCP and ECN:ECT(1)"
 
 	$IP route get fibmatch 172.16.102.1 dsfield 0x02 | \
-		grep -q "via 172.16.101.2"
+		grep -q "172.16.102.0/24 via 172.16.101.2"
 	log_test $? 0 "IPv4 route with no DSCP and ECN:ECT(0)"
 
 	$IP route get fibmatch 172.16.102.1 dsfield 0x03 | \
-		grep -q "via 172.16.101.2"
+		grep -q "172.16.102.0/24 via 172.16.101.2"
 	log_test $? 0 "IPv4 route with no DSCP and ECN:CE"
 }
 
-- 
2.45.1


