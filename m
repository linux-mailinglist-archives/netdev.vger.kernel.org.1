Return-Path: <netdev+bounces-180356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FE7A810B1
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C328A6BF2
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CA6EEB3;
	Tue,  8 Apr 2025 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pnKQ67vh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6851C3BEB
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127010; cv=fail; b=mGGjUt9d8SMCmOVq7/tdtDY4yt15uDPgkGtRrIIyT/2k2PzVg0YejxUkbkB08WN0JmyLZ09Zmqwz1FFNPRDPytxDSP0uRo9Rs6afOYrSgISGw04M611V0ACCTVGgmOsLt7Md9N5V2GrsbGwd+PtYU3RFIXh3M8WPLoK5cTP+Xaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127010; c=relaxed/simple;
	bh=DinMjHVpJUwy5/mEaNF2anzgdTLViLt30HkQVK+pKDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCvvFy14NCF2VKPXykTSLrtwPy0l+aiSbHqZhTOv9nA8SmIO+m2M9icoAJeotrRKzeSP3zebJmWAuePFU9mEgIl2RIQ7YDByxCoApotZWHEgRJZ2s9zIr5imLJA5rwoJ2qLlet26zKxsSibe9zxv91PXwSFgFEpLOMIKjvWPL9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pnKQ67vh; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLJnOv9goN+BP2t2M2VBQ0v91mVAAD1D2S58/CEPtTrkvoKK0iSs56x+J7ERgKt3RtcF+x+yghWR7eE/QjzGRX9lDtQnaEySua+O4Fn2pEL3DdmUgZpplxAkKKaFMLQ9Ra23R04RpjfyJoQK6bZAvV8F57y4SH58EaCTBXCNfjf7bVrmEbvwn3sFv8+79KLjetFXFaHoL4wBHXwhZGWISR/GkvGtsrGvx0LFHqit9eo/LaonOXIE1ICNMUr/ejQyWWrS39mxT+x+6cP6Rjv4Pullr32bH3BIxNV/o6eQjI6vNOFuxSGqbGy1SN96T25RdMqw4RG/fZOPHmTevTWqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH/1Xbrdpx9XRHa25eZvdq49ZEIGht2surVaHjOxxtU=;
 b=wABwNqIZ3wA0xGceuTfz5BKdle4zmmVvuzRAY71BKHW56I/AQu/pMHvV3h0oAZ4IG+mJ9+ZnZlSvpeRtJz/OY7wG0IvF5UQRpntEgMnDrlpvaL93tyrffivWufpieVbSwUjxxGbiz0bWBCcyJVfsxXhbJxj6M9oCM39sz7BkpDfDJtBruSV7zWkTPdikr5jOJBxp5tURCxRFc466MKdIQcCD5NDGOpPDyvndDbbcFjO0NDm6BB+vABSSaA0oS19pZJi+sA5tkP7QbUBovEX5PINpObUQUae49AyySNHE7l3bNbt2gNYwO9/5RHjlNj2jTJGXO6XiO+hp37YU2RVPZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH/1Xbrdpx9XRHa25eZvdq49ZEIGht2surVaHjOxxtU=;
 b=pnKQ67vh90VqcBsoGTFEWsJ3HSwvcif5RBVqdx0gRVvXjsXscEnB65RKecu4pe/TZfrXyXKdP8KVqLR04UVZtsPMryODT5IOpfJZvR4PS2OAgYUIq98VOnmF3pfz3mhbpKRD9uKehgjk1e+k3mD77O3puQey96AwyBY8SMk2M0dcq6FxCRTVb9nvBnTHdGUPlDMoUcjykPHvqlSyVtRqlNbxKH3LyRE3XKmUK0fzGGa0V8dIGzvQ7MVybJkOqxWUyKFLdUW2ZvYYF/QfoUwWuOJ/MbrzCdc7lt1soKE7Y9UZiANNhVWATLx8/JvXttR1q+Ms+kSTm+S7dE0ZBpfahQ==
Received: from BL1PR13CA0285.namprd13.prod.outlook.com (2603:10b6:208:2bc::20)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Tue, 8 Apr
 2025 15:43:22 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2bc:cafe::53) by BL1PR13CA0285.outlook.office365.com
 (2603:10b6:208:2bc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.10 via Frontend Transport; Tue,
 8 Apr 2025 15:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 15:43:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 08:43:03 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 08:42:58 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <bridge@lists.linux.dev>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH net-next 2/2] selftests: test_bridge_neigh_suppress: Test unicast ARP/NS with suppression
Date: Tue, 8 Apr 2025 17:40:24 +0200
Message-ID: <dc240b9649b31278295189f412223f320432c5f2.1744123493.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744123493.git.petrm@nvidia.com>
References: <cover.1744123493.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bb7882-709e-4f7a-ca1d-08dd76b416d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UXFR+3lf+uTuH8gSMehGNILkwZNlZVCfYGr8gWZiRXv+tpz/l54KCZbuctGa?=
 =?us-ascii?Q?m8WtX/vUPThQT/BseqVdxg68SZE6uhzWvXFgIvv6Fgenwf7Poe46uKtNqFlf?=
 =?us-ascii?Q?lkf1zRP9rOwYyBv7VQhK+ARZzyivT2Tf6xnuMcshFY9UDMNt5mztIogQuqT3?=
 =?us-ascii?Q?MWcKB+hsDi6zZ/cfGGXscXeABB9jfSqja3IY64ywudXr2xUYxRh6CrotMCa7?=
 =?us-ascii?Q?9WkBNfYp5ETJRQ5Rturtz7j/F1vCZF/QhL/okTxSseIouzulCJti+UnTjKV0?=
 =?us-ascii?Q?jfUekFFoNglPuEfHgensIziWydwMUU0AqxGYibj/1yT3AvloumxiQ/SZhgHZ?=
 =?us-ascii?Q?rupDMXwL305P3rb/7uKnf2o9NPwnp3oIZWlfZZjlYGrkjOvYK5VcEuwK+t4j?=
 =?us-ascii?Q?VbC6ju9o7xNWfwN5TTUtpDC9vX10GeKE6roY7zXbjl4oKVL1SMQYq1ssIQU7?=
 =?us-ascii?Q?P9TojmI+aumy9rzaRp0FD5BWv3/QgIpSupPTzcro72sDP7c9ZIPBeaI1kkXF?=
 =?us-ascii?Q?LTE7PhwfwNs4vwl1JVOflqyj34h9c1CF7pRXnhOK1r21r17o9pkyCmJJhAS9?=
 =?us-ascii?Q?7Q4adaEhYTnXynIXAvPaqeMMRDxEEGdOPX0VfFYmzEiIGA8djizVwMMuH/kB?=
 =?us-ascii?Q?jB/XctGR304UdjH4wgG4hi9TLPA1X2FVYF2yZmp4qb5JzgKYL+mt2e5/SZte?=
 =?us-ascii?Q?QQmeCUG6Cn4xLK0TBGoUstN8CjUOdmkOxBnvShBRftBCasxaKrgk/9z8P9aE?=
 =?us-ascii?Q?ah3wp5VW804rz4ajeqyVKlUVCrQwSwnKuUCI4cizMvAsDPRj3mHPCdvN4O24?=
 =?us-ascii?Q?LO+MuDATqXFSSOH513gMLNKOvUenq1uPrGRHJiUkn3TMLK4U3qnuFDAMBL6/?=
 =?us-ascii?Q?+ZyUw8cAhKuDPaKi6UoZ3tKjcXY6OTOYOxl3CK4RmDn2V5jj0C/iWmKdmPet?=
 =?us-ascii?Q?ugsCtAmuqrX0Ax6F/wggHWXPgJCC3m/lOUy+xNWcKM/GgsjCMwZXO0X5WlUz?=
 =?us-ascii?Q?IP3MMClQqhXtKqgq6lI0J5qtALx6uuTs30IbNoRwGNN0StFfuiTjSfCikp9f?=
 =?us-ascii?Q?8phrLIf/Yeug2GjgZcBkaA9pABi7OljTxeczxVtptxcbd2EkHC6Q4BF3c9fu?=
 =?us-ascii?Q?D25ZwuTHDraHfynJEp+6kMIWp2lAzWItR5LhsHt/xGW3tmJi1mE+akX1lpxL?=
 =?us-ascii?Q?drS7jc2eqptelMsTKC9F/CxrEKYRJPRLvopXbV2Ax2I6mB9kZogI8KLaUQTs?=
 =?us-ascii?Q?2E8L+gssM9rCConHJJ/R1hwPPTvg6XxEAtiL1XhLDL3jB8B3iPlr9VzzQ5Nu?=
 =?us-ascii?Q?tVLOsuJhm+ShjLWJsbI9CG8bvt9YXS+1ixIjAT1jDTTQMGfVUin0rltXZec5?=
 =?us-ascii?Q?n58/o4nX7imC+kbdleO8jvY466wBvjioyt59uTkul+SbpABRPH5qLovR5N0V?=
 =?us-ascii?Q?/MXXcMv6kiAYgtcKq9lraBz0gPQYE7Hux3oLNWXgE7RZRs5J9axb1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:43:20.3903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bb7882-709e-4f7a-ca1d-08dd76b416d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870

From: Amit Cohen <amcohen@nvidia.com>

Add test cases to check that unicast ARP/NS packets are replied once, even
if ARP/ND suppression is enabled.

Without the previous patch:
$ ./test_bridge_neigh_suppress.sh
...
Unicast ARP, per-port ARP suppression - VLAN 10
-----------------------------------------------
TEST: "neigh_suppress" is on                                        [ OK ]
TEST: Unicast ARP, suppression on, h1 filter                        [FAIL]
TEST: Unicast ARP, suppression on, h2 filter                        [ OK ]

Unicast ARP, per-port ARP suppression - VLAN 20
-----------------------------------------------
TEST: "neigh_suppress" is on                                        [ OK ]
TEST: Unicast ARP, suppression on, h1 filter                        [FAIL]
TEST: Unicast ARP, suppression on, h2 filter                        [ OK ]
...
Unicast NS, per-port NS suppression - VLAN 10
---------------------------------------------
TEST: "neigh_suppress" is on                                        [ OK ]
TEST: Unicast NS, suppression on, h1 filter                         [FAIL]
TEST: Unicast NS, suppression on, h2 filter                         [ OK ]

Unicast NS, per-port NS suppression - VLAN 20
---------------------------------------------
TEST: "neigh_suppress" is on                                        [ OK ]
TEST: Unicast NS, suppression on, h1 filter                         [FAIL]
TEST: Unicast NS, suppression on, h2 filter                         [ OK ]
...
Tests passed: 156
Tests failed:   4

With the previous patch:
$ ./test_bridge_neigh_suppress.sh
...
Unicast ARP, per-port ARP suppression - VLAN 10
-----------------------------------------------
TEST: "neigh_suppress" is on                                        [ OK ]
TEST: Unicast ARP, suppression on, h1 filter                        [ OK ]
TEST: Unicast ARP, suppression on, h2 filter                        [ OK ]

Unicast ARP, per-port ARP suppression - VLAN 20
-----------------------------------------------
TEST: "neigh_suppress" is on                                        [ OK ]
TEST: Unicast ARP, suppression on, h1 filter                        [ OK ]
TEST: Unicast ARP, suppression on, h2 filter                        [ OK ]
...
Unicast NS, per-port NS suppression - VLAN 10
---------------------------------------------
TEST: "neigh_suppress" is on                                        [ OK ]
TEST: Unicast NS, suppression on, h1 filter                         [ OK ]
TEST: Unicast NS, suppression on, h2 filter                         [ OK ]

Unicast NS, per-port NS suppression - VLAN 20
---------------------------------------------
TEST: "neigh_suppress" is on                                        [ OK ]
TEST: Unicast NS, suppression on, h1 filter                         [ OK ]
TEST: Unicast NS, suppression on, h2 filter                         [ OK ]
...
Tests passed: 160
Tests failed:   0

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/test_bridge_neigh_suppress.sh         | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
index 02b986c9c247..9067197c9055 100755
--- a/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
+++ b/tools/testing/selftests/net/test_bridge_neigh_suppress.sh
@@ -51,7 +51,9 @@ ret=0
 # All tests in this script. Can be overridden with -t option.
 TESTS="
 	neigh_suppress_arp
+	neigh_suppress_uc_arp
 	neigh_suppress_ns
+	neigh_suppress_uc_ns
 	neigh_vlan_suppress_arp
 	neigh_vlan_suppress_ns
 "
@@ -388,6 +390,52 @@ neigh_suppress_arp()
 	neigh_suppress_arp_common $vid $sip $tip
 }
 
+neigh_suppress_uc_arp_common()
+{
+	local vid=$1; shift
+	local sip=$1; shift
+	local tip=$1; shift
+	local tmac
+
+	echo
+	echo "Unicast ARP, per-port ARP suppression - VLAN $vid"
+	echo "-----------------------------------------------"
+
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
+	log_test $? 0 "\"neigh_suppress\" is on"
+
+	tmac=$(ip -n $h2 -j -p link show eth0.$vid | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $tmac dev vx0 master static vlan $vid"
+	run_cmd "ip -n $sw1 neigh replace $tip lladdr $tmac nud permanent dev br0.$vid"
+
+	run_cmd "tc -n $h1 qdisc replace dev eth0.$vid clsact"
+	run_cmd "tc -n $h1 filter replace dev eth0.$vid ingress pref 1 handle 101 proto arp flower arp_sip $tip arp_op reply action pass"
+
+	run_cmd "tc -n $h2 qdisc replace dev eth0.$vid clsact"
+	run_cmd "tc -n $h2 filter replace dev eth0.$vid egress pref 1 handle 101 proto arp flower arp_tip $sip arp_op reply action pass"
+
+	run_cmd "ip netns exec $h1 mausezahn eth0.$vid -c 1 -a own -b $tmac -t arp 'request sip=$sip, tip=$tip, tmac=$tmac' -q"
+	tc_check_packets $h1 "dev eth0.$vid ingress" 101 1
+	log_test $? 0 "Unicast ARP, suppression on, h1 filter"
+	tc_check_packets $h2 "dev eth0.$vid egress" 101 1
+	log_test $? 0 "Unicast ARP, suppression on, h2 filter"
+}
+
+neigh_suppress_uc_arp()
+{
+	local vid=10
+	local sip=192.0.2.1
+	local tip=192.0.2.2
+
+	neigh_suppress_uc_arp_common $vid $sip $tip
+
+	vid=20
+	sip=192.0.2.17
+	tip=192.0.2.18
+	neigh_suppress_uc_arp_common $vid $sip $tip
+}
+
 neigh_suppress_ns_common()
 {
 	local vid=$1; shift
@@ -494,6 +542,78 @@ neigh_suppress_ns()
 	neigh_suppress_ns_common $vid $saddr $daddr $maddr
 }
 
+icmpv6_header_get()
+{
+	local csum=$1; shift
+	local tip=$1; shift
+	local type
+	local p
+
+	# Type 135 (Neighbor Solicitation), hex format
+	type="87"
+	p=$(:
+		)"$type:"$(                     : ICMPv6.type
+		)"00:"$(                        : ICMPv6.code
+		)"$csum:"$(                     : ICMPv6.checksum
+		)"00:00:00:00:"$(               : Reserved
+	        )"$tip:"$(	                : Target Address
+		)
+	echo $p
+}
+
+neigh_suppress_uc_ns_common()
+{
+	local vid=$1; shift
+	local sip=$1; shift
+	local dip=$1; shift
+	local full_dip=$1; shift
+	local csum=$1; shift
+	local tmac
+
+	echo
+	echo "Unicast NS, per-port NS suppression - VLAN $vid"
+	echo "---------------------------------------------"
+
+	run_cmd "bridge -n $sw1 link set dev vx0 neigh_suppress on"
+	run_cmd "bridge -n $sw1 -d link show dev vx0 | grep \"neigh_suppress on\""
+	log_test $? 0 "\"neigh_suppress\" is on"
+
+	tmac=$(ip -n $h2 -j -p link show eth0.$vid | jq -r '.[]["address"]')
+	run_cmd "bridge -n $sw1 fdb replace $tmac dev vx0 master static vlan $vid"
+	run_cmd "ip -n $sw1 -6 neigh replace $dip lladdr $tmac nud permanent dev br0.$vid"
+
+	run_cmd "tc -n $h1 qdisc replace dev eth0.$vid clsact"
+	run_cmd "tc -n $h1 filter replace dev eth0.$vid ingress pref 1 handle 101 proto ipv6 flower ip_proto icmpv6 src_ip $dip type 136 code 0 action pass"
+
+	run_cmd "tc -n $h2 qdisc replace dev eth0.$vid clsact"
+	run_cmd "tc -n $h2 filter replace dev eth0.$vid egress pref 1 handle 101 proto ipv6 flower ip_proto icmpv6 dst_ip $sip type 136 code 0 action pass"
+
+	run_cmd "ip netns exec $h1 mausezahn -6 eth0.$vid -c 1 -a own -b $tmac -A $sip -B $dip -t ip hop=255,next=58,payload=$(icmpv6_header_get $csum $full_dip) -q"
+	tc_check_packets $h1 "dev eth0.$vid ingress" 101 1
+	log_test $? 0 "Unicast NS, suppression on, h1 filter"
+	tc_check_packets $h2 "dev eth0.$vid egress" 101 1
+	log_test $? 0 "Unicast NS, suppression on, h2 filter"
+}
+
+neigh_suppress_uc_ns()
+{
+	local vid=10
+	local saddr=2001:db8:1::1
+	local daddr=2001:db8:1::2
+	local full_daddr=20:01:0d:b8:00:01:00:00:00:00:00:00:00:00:00:02
+	local csum="ef:79"
+
+	neigh_suppress_uc_ns_common $vid $saddr $daddr $full_daddr $csum
+
+	vid=20
+	saddr=2001:db8:2::1
+	daddr=2001:db8:2::2
+	full_daddr=20:01:0d:b8:00:02:00:00:00:00:00:00:00:00:00:02
+	csum="ef:76"
+
+	neigh_suppress_uc_ns_common $vid $saddr $daddr $full_daddr $csum
+}
+
 neigh_vlan_suppress_arp()
 {
 	local vid1=10
@@ -825,6 +945,11 @@ if [ ! -x "$(command -v jq)" ]; then
 	exit $ksft_skip
 fi
 
+if [ ! -x "$(command -v mausezahn)" ]; then
+	echo "SKIP: Could not run test without mausezahn tool"
+	exit $ksft_skip
+fi
+
 bridge link help 2>&1 | grep -q "neigh_vlan_suppress"
 if [ $? -ne 0 ]; then
    echo "SKIP: iproute2 bridge too old, missing per-VLAN neighbor suppression support"
-- 
2.47.0


