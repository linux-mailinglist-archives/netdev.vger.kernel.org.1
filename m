Return-Path: <netdev+bounces-196943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A479FAD7049
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69FCE7A3265
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BA2218E9F;
	Thu, 12 Jun 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lupvk0yF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76FC1917ED
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731092; cv=fail; b=lGBVG7PYi0mevIu/L3IFaPpzm63IZ4ZQL5WIPOg/aN0VpU0Z57TmCkAe3mV398FhJGtiFk3IQL4JZIrrRrJk5luOYC0cV5CEgwHSso7T3jFTrIhha/EBvPPems9zxd/otP9TkDpk4TshZCT0tICs2gaJBB5Hn3KNOT6fmRK2JxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731092; c=relaxed/simple;
	bh=3kw6yN5QgoIjy9oLBzx3rrYfdJ/e1U1FxAb6FnyrAy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtlaOE3flA6BGltnw5niv8fS2ZLW2FaGgVbQaMK/zbtCbJmarqvsfu1NM9FnRHK28sh/lleM65kjYOOS46seLZe2VDdkMV2ZAc4OxHDq3CXvXyMQWhfW0Rf0inqPwc8XIMV363bHxGxpdDft7MiyIVmrtPqKgYme5m2SZtyQWhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lupvk0yF; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWJgsPrnWpXywKKDCv9A2b7P3JNYGfuv1sEqXqOosycUJo3g57pZsQhNwN1dxU6vsaRMEkO385Q8tV42gNN6VgymLJiF2SDAX58HqBCc8XUCcnJRYVxa3lnkm8BDGXn3nCVcrOPXAkiDKfUVlm+ZoaKOtVvnV9yUn7XA0/WxEd1nAwqJ0U8DrtpXVHfahIPaguABU6HUcL0FbViA+LFRMbiCtUjCgO1Uzd7g8Lc7xV28SmLZHxJWVgqF2CoGHUkWAIRXOWXF/lYaw1gncyXF82esTlDNb5iX8K5em5Y6HQw7DUJeRoA/NHBtWn6/MpRUNAZcTv/mo+JZ1M6zBZKfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fk4sk3JUrDEvO7prY44bkVpvmf78XNQyc4Db4ofeKhk=;
 b=QzG/4LmCbCq+QIceWhz5IJz/0HKgkncSNHpZvpGgyq6mb42ZKjAGDgYP4Ny5ZCHm0M8PCU+PmGX+uQZ4P2aSVHS8KGpc5ban6KzrY91FMtD9z2cO3QspfZ8ctuWZ7nV7KPN3JCrXgGjYKskL8IVIQvnCmNRVsBX11xCUudIjB9bXDFp1RhXHjTD5JNlM94OGiFxEqWqkFSRc4Se3SxxsrWQAq8DqoV54H6o4xR2GaY3nKFOxwnhjEznJF63SVQTLld6U1Au/VlhvCJG6DVEqUTC1d9WmrHjUhIAop0GInT5bmviWQu7kqc1m80QgsoglekypFr0/gFKPqmDPuJ1fpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fk4sk3JUrDEvO7prY44bkVpvmf78XNQyc4Db4ofeKhk=;
 b=Lupvk0yFkoQtOePF0nIT6sa9vhPWO8tuaWJxM4Ukt/GuskA6THeSb52ihkIuI2rTDEQN5rnYTbMmf/T3epmHZSMcqGk+LJ/wolKl3h1dWnpY2P9II/hIOklRHA2D63xYl9LtROStHS/VWlV29WhlRN6gJpaF8fzxJ0uQgD74NwHX+LnMskMVsm3SiKtdjO2o7VAYCjJOz+U2EkfPlUTE1qVawqwLUvU/qDmTaQ06utVTT44E49R6CQ1f5sBbwaame7aoNFu2zGNYPVF9fLsd/zXm2BVTGbyB5fu8fazd/MwWOAwmPJN7+OGZdJJIqZqZcmhPnWshBmC8D2osCWmrUg==
Received: from BN9PR03CA0397.namprd03.prod.outlook.com (2603:10b6:408:111::12)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Thu, 12 Jun
 2025 12:24:45 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::dc) by BN9PR03CA0397.outlook.office365.com
 (2603:10b6:408:111::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Thu,
 12 Jun 2025 12:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 12:24:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 05:24:31 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 05:24:27 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrea.mayer@uniroma2.it>, <dsahern@kernel.org>,
	<horms@kernel.org>, <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 4/4] selftests: seg6: Add test cases for End.X with link-local nexthop
Date: Thu, 12 Jun 2025 15:23:23 +0300
Message-ID: <20250612122323.584113-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612122323.584113-1-idosch@nvidia.com>
References: <20250612122323.584113-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 3250364c-1fa2-4998-a7dc-08dda9ac1da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7OQI7E0L38T4YdylPb4jY6ZuhgJesQ+2jLSpCklQLfSqKV2KQqIkJvw55MZZ?=
 =?us-ascii?Q?lcxp4u1SbPrhxMmHCvna5ECZokCdlbhhUek9I2bJw5gG9B1daB4UslbrBIaa?=
 =?us-ascii?Q?BnskYdf/+TH8G/tr265dP+Ef07gJeSVUHhXkKRAlYCSnFfi4Ed8tnhQXDhww?=
 =?us-ascii?Q?e+6rpqepqIvWERYcRmHyMU8V5Lu5kzTX0IV0lPbcfXFkkwmXJXy03oRdRJuc?=
 =?us-ascii?Q?fJPovvRx5aXx98ZF1CeRJ+TlsIBFuRH4WyZIwZEfHrcxfg6C4cEEpznPEv70?=
 =?us-ascii?Q?XLasnToUDpYJiJeDtlj39I/0su8XBg7J9FfnPf+jn2pSFOO5p93kZBCutQLZ?=
 =?us-ascii?Q?IJZ6oetOD6FuxiCKsdmIazLWaKojUVQhJWBLQi2KN4Il6niEOelsxK9I7gFG?=
 =?us-ascii?Q?MVzdOF5DQVh1sZlnZRgfsODA/19X9UUaTMT/RsE5Z15AGRe1fLuSD6CXdLGj?=
 =?us-ascii?Q?yC44pW8MgP8D0awCSksM6rwo25aB7KAwRShm8/VyaoEoUtZCcc6fqemXtMhk?=
 =?us-ascii?Q?DTJoKZqZUTFdofTgmQMMUj3+esTXiJP7FzZHCeWhUF0O4gRIqALkNUrD8F5I?=
 =?us-ascii?Q?+7lgVFBg3J0DnHKnTppcif5R+kd0rBuMeD+oXxCgT8vbUUSAE6AtY1uxhey6?=
 =?us-ascii?Q?3WPiCnwaMlRGib68HHqmb3AOe3U3Ca7MiB/1VFzAC68P/qUBWwvrzs1IBLeO?=
 =?us-ascii?Q?FaRvbR2tgf9tQOE38YeoJxhZOaMOdzvNVQDprOG8ccyjdl+0PdgS/8SrF+a+?=
 =?us-ascii?Q?RFRM8VqleEgEzjjFMo3T8PjBPHummCUwSfC/fY4QtKV+e4GEpf/NzvTBeTVD?=
 =?us-ascii?Q?PwVmOookLuTqhpL5sYBV3GD2lfyzSajNhjyodyuAOe0uoKYD5Z0T7gfsnkja?=
 =?us-ascii?Q?+qivwFOvzGOVTuBbo3Qi8BANxp73djqPflAXYNVk7wJVbF0+ZuUpaDQqWGz+?=
 =?us-ascii?Q?Gr9+9WIGsRsn/Hynaetip5oTNdMJ+Vy5b9uVVQLBxNKp0oKBemnXJzvFfLZr?=
 =?us-ascii?Q?1f1mvRcqgi5AORkDX0JKY26hF2WJ/hWKAon0YOGYDhjduVdNpL9amNSsiy1w?=
 =?us-ascii?Q?yY6wXnaUM0XpHGaV4ulfNY+lXaOHQdNK5Kmn7rD117+N8AgSEIkbIkA8Nn/e?=
 =?us-ascii?Q?UwJ8ZA/Z3U9vVk70kZhKZBLusjt0oQauOG5vQpfhsfdn0xqq4ohmNlszwePO?=
 =?us-ascii?Q?F5YnLmIDue918zpK6E9PrOQ/BWJhL9KlbT0qBO/W1QyUWCgRDpIv3plmbutc?=
 =?us-ascii?Q?+cDGRJGINyhiOFS2wx4ve9v8m9Ke8lX4+MNJPSZxg/hHJ/WXospVZngrdNTp?=
 =?us-ascii?Q?rqpYmYfWILLZH2dYHB5ACLfiVCo/fBXtI5K8xDaCnzMQqfP+xug6lUcmFG1u?=
 =?us-ascii?Q?i8siLzgHZq4gzOH+aN/NOmeeN6rdlue773yrc+iv780XjO9B4hxAoUOlkIjT?=
 =?us-ascii?Q?E+x/uW0kJtQRoPFcXGoCcvjk/vw4AH1eu6Ac+XKNJdiZwY2kTDvPb5j6XCb+?=
 =?us-ascii?Q?VtyBYoPSpSyUvFkV8QDjPdjJwoLI2Fs3XGtD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 12:24:45.1532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3250364c-1fa2-4998-a7dc-08dda9ac1da8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353

In the current test topology, all the routers are connected to each
other via dedicated links with addresses of the form fcf0:0:x:y::/64.

The test configures rt-3 with an adjacency with rt-4 and rt-4 with an
adjacency with rt-1:

 # ip -n rt_3-IgWSBJ -6 route show tab 90 fcbb:0:300::/48
 fcbb:0:300::/48  encap seg6local action End.X nh6 fcf0:0:3:4::4 flavors next-csid lblen 32 nflen 16 dev dum0 metric 1024 pref medium
 # ip -n rt_4-JdCunK -6 route show tab 90 fcbb:0:400::/48
 fcbb:0:400::/48  encap seg6local action End.X nh6 fcf0:0:1:4::1 flavors next-csid lblen 32 nflen 16 dev dum0 metric 1024 pref medium

The routes are used when pinging hs-2 from hs-1 and vice-versa.

Extend the test to also cover End.X behavior with an IPv6 link-local
nexthop address and an output interface. Configure every router
interface with an IPv6 link-local address of the form fe80::x:y/64 and
before re-running the ping tests, replace the previous End.X routes with
routes that use the new IPv6 link-local addresses:

 # ip -n rt_3-IgWSBJ -6 route show tab 90 fcbb:0:300::/48
 fcbb:0:300::/48  encap seg6local action End.X nh6 fe80::4:3 oif veth-rt-3-4 flavors next-csid lblen 32 nflen 16 dev dum0 metric 1024 pref medium
 # ip -n rt_4-JdCunK -6 route show tab 90 fcbb:0:400::/48
 fcbb:0:400::/48  encap seg6local action End.X nh6 fe80::1:4 oif veth-rt-4-1 flavors next-csid lblen 32 nflen 16 dev dum0 metric 1024 pref medium

The new test cases fail without the previous patch ("seg6: Allow End.X
behavior to accept an oif"):

 # ./srv6_end_x_next_csid_l3vpn_test.sh
 [...]
 ################################################################################
 TEST SECTION: SRv6 VPN connectivity test hosts (h1 <-> h2, IPv6), link-local
 ################################################################################

     TEST: IPv6 Hosts connectivity: hs-1 -> hs-2                         [FAIL]

     TEST: IPv6 Hosts connectivity: hs-2 -> hs-1                         [FAIL]

 ################################################################################
 TEST SECTION: SRv6 VPN connectivity test hosts (h1 <-> h2, IPv4), link-local
 ################################################################################

     TEST: IPv4 Hosts connectivity: hs-1 -> hs-2                         [FAIL]

     TEST: IPv4 Hosts connectivity: hs-2 -> hs-1                         [FAIL]

 Tests passed:  40
 Tests failed:   4

And pass with it:

 # ./srv6_end_x_next_csid_l3vpn_test.sh
 [...]
 ################################################################################
 TEST SECTION: SRv6 VPN connectivity test hosts (h1 <-> h2, IPv6), link-local
 ################################################################################

     TEST: IPv6 Hosts connectivity: hs-1 -> hs-2                         [ OK ]

     TEST: IPv6 Hosts connectivity: hs-2 -> hs-1                         [ OK ]

 ################################################################################
 TEST SECTION: SRv6 VPN connectivity test hosts (h1 <-> h2, IPv4), link-local
 ################################################################################

     TEST: IPv4 Hosts connectivity: hs-1 -> hs-2                         [ OK ]

     TEST: IPv4 Hosts connectivity: hs-2 -> hs-1                         [ OK ]

 Tests passed:  44
 Tests failed:   0

Without the previous patch, rt-3 and rt-4 resolve the wrong routes for
the link-local nexthops, with the output interface being the input
interface:

 # perf script
 [...]
 ping    1067 [001]    37.554486: fib6:fib6_table_lookup: table 254 oif 0 iif 11 proto 41 cafe::254/0 -> fe80::4:3/0 flowlabel 0xb7973 tos 0 scope 0 flags 2 ==> dev veth-rt-3-1 gw :: err 0
 [...]
 ping    1069 [002]    41.573360: fib6:fib6_table_lookup: table 254 oif 0 iif 12 proto 41 cafe::254/0 -> fe80::1:4/0 flowlabel 0xb7973 tos 0 scope 0 flags 2 ==> dev veth-rt-4-2 gw :: err 0

But the correct routes are resolved with the patch:

 # perf script
 [...]
 ping    1066 [006]    30.672355: fib6:fib6_table_lookup: table 254 oif 13 iif 1 proto 41 cafe::254/0 -> fe80::4:3/0 flowlabel 0x85941 tos 0 scope 0 flags 6 ==> dev veth-rt-3-4 gw :: err 0
 [...]
 ping    1066 [006]    30.672411: fib6:fib6_table_lookup: table 254 oif 11 iif 1 proto 41 cafe::254/0 -> fe80::1:4/0 flowlabel 0x91de0 tos 0 scope 0 flags 6 ==> dev veth-rt-4-1 gw :: err 0

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/srv6_end_x_next_csid_l3vpn_test.sh    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh
index 4b86040c58c6..bedf0ce885c2 100755
--- a/tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh
@@ -72,6 +72,9 @@
 # Every fcf0:0:x:y::/64 network interconnects the SRv6 routers rt-x with rt-y in
 # the selftest network.
 #
+# In addition, every router interface connecting rt-x to rt-y is assigned an
+# IPv6 link-local address fe80::x:y/64.
+#
 # Local SID/C-SID table
 # =====================
 #
@@ -521,6 +524,9 @@ setup_rt_networking()
 		ip -netns "${nsname}" addr \
 			add "${net_prefix}::${rt}/64" dev "${devname}" nodad
 
+		ip -netns "${nsname}" addr \
+			add "fe80::${rt}:${neigh}/64" dev "${devname}" nodad
+
 		ip -netns "${nsname}" link set "${devname}" up
 	done
 
@@ -609,6 +615,27 @@ set_end_x_nextcsid()
 		nflen "${LCNODEFUNC_BLEN}" dev "${DUMMY_DEVNAME}"
 }
 
+set_end_x_ll_nextcsid()
+{
+	local rt="$1"
+	local adj="$2"
+
+	eval nsname=\${$(get_rtname "${rt}")}
+	lcnode_func_prefix="$(build_lcnode_func_prefix "${rt}")"
+	nh6_ll_addr="fe80::${adj}:${rt}"
+	oifname="veth-rt-${rt}-${adj}"
+
+	# enabled NEXT-C-SID SRv6 End.X behavior via an IPv6 link-local nexthop
+	# address (note that "dev" is the dummy dum0 device chosen for the sake
+	# of simplicity).
+	ip -netns "${nsname}" -6 route \
+		replace "${lcnode_func_prefix}" \
+		table "${LOCALSID_TABLE_ID}" \
+		encap seg6local action End.X nh6 "${nh6_ll_addr}" \
+		oif "${oifname}" flavors next-csid lblen "${LCBLOCK_BLEN}" \
+		nflen "${LCNODEFUNC_BLEN}" dev "${DUMMY_DEVNAME}"
+}
+
 set_underlay_sids_reachability()
 {
 	local rt="$1"
@@ -1016,6 +1043,27 @@ host_vpn_tests()
 
 	check_and_log_hs_ipv4_connectivity 1 2
 	check_and_log_hs_ipv4_connectivity 2 1
+
+	# Setup the adjacencies in the SRv6 aware routers using IPv6 link-local
+	# addresses.
+	# - rt-3 SRv6 End.X adjacency with rt-4
+	# - rt-4 SRv6 End.X adjacency with rt-1
+	set_end_x_ll_nextcsid 3 4
+	set_end_x_ll_nextcsid 4 1
+
+	log_section "SRv6 VPN connectivity test hosts (h1 <-> h2, IPv6), link-local"
+
+	check_and_log_hs_ipv6_connectivity 1 2
+	check_and_log_hs_ipv6_connectivity 2 1
+
+	log_section "SRv6 VPN connectivity test hosts (h1 <-> h2, IPv4), link-local"
+
+	check_and_log_hs_ipv4_connectivity 1 2
+	check_and_log_hs_ipv4_connectivity 2 1
+
+	# Restore the previous adjacencies.
+	set_end_x_nextcsid 3 4
+	set_end_x_nextcsid 4 1
 }
 
 __nextcsid_end_x_behavior_test()
-- 
2.49.0


