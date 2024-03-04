Return-Path: <netdev+bounces-77033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7731386FE29
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDAB282B16
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B4A225DF;
	Mon,  4 Mar 2024 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EjkPJaTS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28602225A6
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546230; cv=fail; b=M4EbnIQ9L5bUfzB+7p6qSNq8u0C9RWURnQJnQPyB5okSZS7jTuw7DZNtlLxmxs7mfjDVW2/+xzr5RSHRXOiwOHvh7Ize+/enq7hUfIQGAm7nFRFpYlo2HMkdJccoy7BTx7iadEiv7OGYZCaiC+l4MgVrp561zIQevU/qAHf/ySU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546230; c=relaxed/simple;
	bh=SA7H098RTxFVhKvjhsdmDwSKyJQjMzWUO3QZuen3ChM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfLPv3OZJ6kOaKgAwtsXicuD3nBtG6EcHxHZMVGMCWDT0gfBnXX5jMbRrb9RhjzWJstmZeBxGExAQl+I9kAzEIsAzT6zrFyS/mgC55VSH8GlZ1fKiYUDSBwVftJJ6eMaGxDB0UFodp0b279BfN5bnLcyqKQUktGMaPfEL24FeqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EjkPJaTS; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCMNBlxIZEGKaRNZyuCXVh0Z7FZyUUFpZJDwLWr9wRdEFxAf8gnpTGR0J5BO4AS5Y+fxLE6p0rG3RAsUlgqQ76V3q7x9nvSkQWVUv3LQkwsyeAkXBiAPv4eImdYGpchohPq98mo8dAWcdAyr0bd5AJWULjXVYpBfhqwY2v8bQTM94xiWOjCjoj5Ldk3YfLXUkvnyzY/1A6nehP6UuCoF+Oozfpb6eNTcRlHvKEfMjSZjITpECT1wMwQlZ2aCmr3oAqFSi8NoTQJAgNRcOn8++tDEyMiE8GTWGUPrTiUVr1itG5o14XsQzM/3z/74gxSQCgVhotoXVz5zK9vP9D0vUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLp4RT1HjJD3MmOpm5EDNQIiZUphAlGmlUpViucm/xI=;
 b=OeRdwG/jubMRYogn+TPmQXR9YLQF/TPwyqfMRRSBlEbLZzpOCIJpmMyYykOZmW6Q3ddF+HoIar9Sm371IY2kN9FMGavlYNgQ1XPNR2IMKSn8IjbbvDFQVEi29fySkNNR59gefLlAbO/qqMpUIRORKGPl4sGNvjcmlA8cG3vRVbHMQMUY0BGRloiVKj3Yrl6n43skiOUi14ocAEk3HMCrFK75DmKcZGb3fRmIhNNUZMfgggZbFcIbnf4OnrhW+RimrzCssGBvVpB3h29z9sdvKCl1wi1v+2lqt/+5i1xVjAU6Olhn6kgoMifzhrW/D8utIAN/Je6yjnIREhL/OZjWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLp4RT1HjJD3MmOpm5EDNQIiZUphAlGmlUpViucm/xI=;
 b=EjkPJaTSoXt/Pn/LE749LBtllLO4tNqqtuFlrWKEA4Sr4+piX3560y1k0FqSQgUckeQ2lLUNIRRDDN7qmJkcUNkf3S3dzqw+gGv3cnLnGEaUujrxjzQhhICYGY+Yr1wf7Zcb2dylR8YvuJ27Cv/35Iy6/3mhk2LGidHmuI4Z7+Kd231H1KAS0Lx5HWPv2QKk+zkeigANTQIwFMOcVNQ0lEwZ5/3t8/42k0j9sVGTH4nWSx1GYupNcRCFoXnS33oMOj2OwLU9SjLMbi/fyfhtdzQUndLWYGDW2S+PPLp3UTitxSkNUKTuD9TTv0CTwO7jw3Ku8+5UkNpBdsqxwJDuPw==
Received: from CH2PR07CA0042.namprd07.prod.outlook.com (2603:10b6:610:5b::16)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 09:57:03 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::e8) by CH2PR07CA0042.outlook.office365.com
 (2603:10b6:610:5b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 09:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 09:57:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 01:56:49 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 4 Mar 2024 01:56:46 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>, <bpoirier@nvidia.com>,
	<shuah@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/6] selftests: forwarding: Parametrize mausezahn delay
Date: Mon, 4 Mar 2024 11:56:08 +0200
Message-ID: <20240304095612.462900-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304095612.462900-1-idosch@nvidia.com>
References: <20240304095612.462900-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d93b14-e647-4968-64d8-08dc3c31719f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w9cySi1axcd1KtpJydMpbHgefI9R82kNNJjTUcFgS/cwMdU4Bj0Z55TCfxuOcgdE0skAS4F9t+Gb3yvNawpsIQZqNW8EdsXegd7yJ7c6QCwOucSSwJTTsKXo9cvrz4BSqjD6bgOAkWQCNs3inzP6ig2Ue+7qwQAoS1A0YwAjNMyE+aj49WfFVK1PzGv/cHZGjKrGGqrKjFHUXmJhTbldAHJDkvnr1br9H7Ami592FMt/RvdxN9HvB48ZJVRocyfjkfU1DtUnm+qM0J+qy5IZ77CMBaEYaa2FOOGU4412joGAimegKoPtkUIYybKuIzZm6V04WNiNhyePu146SPVQG9xcVhSZSM75PmtGeea2bpOY7qiijSWh3JCgKlxlV9UX8OW7h+d5EprQRrolPbkVTi2bjVeOsFQdMMdpEiI8R4n1t0PuYGITASH4ji716R06Cs92XFhjR/DIboBXJ3guRrCzVOpK3js7KvYxGLE2Qb96SG3RuCDE3Q0s9pUUjHpc+mKU2J7CPcNKArse9a7ZLdTF1T/v3JofCrYQTBQa02zmfgFAW+ut45xGmoMLRFP/64CssZKZfo92P+t3vNpJmgfHqNWO0JFYObchw1C8pY6WF2GNOkgZLSy1z9khcKw1b3KW42mI5G9yhGd4//m1ucVl1Uh4/SbkleyW7PcEoK7bFQPFm4JS/u9v9UkQjAZmmfHpKrvyXBNSAaBbg68meNPS0WYTA11fW8kAqjy+S3ZLkuHAOWyPTivJNIgmnlLZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:57:03.5697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d93b14-e647-4968-64d8-08dc3c31719f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089

The various multipath tests use mausezahn to generate different flows
and check how they are distributed between the available nexthops. The
tool is currently invoked with an hard coded transmission delay of 1 ms.
This is unnecessary when the tests are run with veth pairs and
needlessly prolongs the tests.

Parametrize this delay and default it to 0 us. It can be overridden
using the forwarding.config file. On my system, this reduces the run
time of router_multipath.sh by 93%.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/forwarding/custom_multipath_hash.sh      | 16 ++++++++--------
 .../net/forwarding/forwarding.config.sample      |  2 ++
 .../net/forwarding/gre_custom_multipath_hash.sh  | 16 ++++++++--------
 .../net/forwarding/gre_inner_v4_multipath.sh     |  2 +-
 .../net/forwarding/gre_inner_v6_multipath.sh     |  2 +-
 .../selftests/net/forwarding/gre_multipath.sh    |  2 +-
 .../selftests/net/forwarding/gre_multipath_nh.sh |  4 ++--
 .../net/forwarding/gre_multipath_nh_res.sh       |  4 ++--
 .../forwarding/ip6gre_custom_multipath_hash.sh   | 16 ++++++++--------
 .../net/forwarding/ip6gre_inner_v4_multipath.sh  |  2 +-
 .../net/forwarding/ip6gre_inner_v6_multipath.sh  |  2 +-
 .../selftests/net/forwarding/ip6gre_lib.sh       |  4 ++--
 tools/testing/selftests/net/forwarding/lib.sh    |  1 +
 .../selftests/net/forwarding/router_mpath_nh.sh  |  4 ++--
 .../net/forwarding/router_mpath_nh_res.sh        |  4 ++--
 .../selftests/net/forwarding/router_multipath.sh |  4 ++--
 16 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
index 56eb83d1a3bd..1783c10215e5 100755
--- a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
@@ -183,42 +183,42 @@ send_src_ipv4()
 {
 	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
 		-A "198.51.100.2-198.51.100.253" -B 203.0.113.2 \
-		-d 1msec -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
 }
 
 send_dst_ipv4()
 {
 	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
 		-A 198.51.100.2 -B "203.0.113.2-203.0.113.253" \
-		-d 1msec -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
 }
 
 send_src_udp4()
 {
 	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
 		-A 198.51.100.2 -B 203.0.113.2 \
-		-d 1msec -t udp "sp=0-32768,dp=30000"
+		-d $MZ_DELAY -t udp "sp=0-32768,dp=30000"
 }
 
 send_dst_udp4()
 {
 	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
 		-A 198.51.100.2 -B 203.0.113.2 \
-		-d 1msec -t udp "sp=20000,dp=0-32768"
+		-d $MZ_DELAY -t udp "sp=20000,dp=0-32768"
 }
 
 send_src_ipv6()
 {
 	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
 		-A "2001:db8:1::2-2001:db8:1::fd" -B 2001:db8:4::2 \
-		-d 1msec -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
 }
 
 send_dst_ipv6()
 {
 	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
 		-A 2001:db8:1::2 -B "2001:db8:4::2-2001:db8:4::fd" \
-		-d 1msec -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
 }
 
 send_flowlabel()
@@ -234,14 +234,14 @@ send_src_udp6()
 {
 	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
 		-A 2001:db8:1::2 -B 2001:db8:4::2 \
-		-d 1msec -t udp "sp=0-32768,dp=30000"
+		-d $MZ_DELAY -t udp "sp=0-32768,dp=30000"
 }
 
 send_dst_udp6()
 {
 	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
 		-A 2001:db8:1::2 -B 2001:db8:4::2 \
-		-d 1msec -t udp "sp=20000,dp=0-32768"
+		-d $MZ_DELAY -t udp "sp=20000,dp=0-32768"
 }
 
 custom_hash_test()
diff --git a/tools/testing/selftests/net/forwarding/forwarding.config.sample b/tools/testing/selftests/net/forwarding/forwarding.config.sample
index 4a546509de90..1fc4f0242fc5 100644
--- a/tools/testing/selftests/net/forwarding/forwarding.config.sample
+++ b/tools/testing/selftests/net/forwarding/forwarding.config.sample
@@ -28,6 +28,8 @@ PING=ping
 PING6=ping6
 # Packet generator. Some distributions use 'mz'.
 MZ=mausezahn
+# mausezahn delay between transmissions in microseconds.
+MZ_DELAY=0
 # Time to wait after interfaces participating in the test are all UP
 WAIT_TIME=5
 # Whether to pause on failure or not.
diff --git a/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
index 0446db9c6f74..9788bd0f6e8b 100755
--- a/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
@@ -278,42 +278,42 @@ send_src_ipv4()
 {
 	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
 		-A "198.51.100.2-198.51.100.253" -B 203.0.113.2 \
-		-d 1msec -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
 }
 
 send_dst_ipv4()
 {
 	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
 		-A 198.51.100.2 -B "203.0.113.2-203.0.113.253" \
-		-d 1msec -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
 }
 
 send_src_udp4()
 {
 	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
 		-A 198.51.100.2 -B 203.0.113.2 \
-		-d 1msec -t udp "sp=0-32768,dp=30000"
+		-d $MZ_DELAY -t udp "sp=0-32768,dp=30000"
 }
 
 send_dst_udp4()
 {
 	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
 		-A 198.51.100.2 -B 203.0.113.2 \
-		-d 1msec -t udp "sp=20000,dp=0-32768"
+		-d $MZ_DELAY -t udp "sp=20000,dp=0-32768"
 }
 
 send_src_ipv6()
 {
 	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
 		-A "2001:db8:1::2-2001:db8:1::fd" -B 2001:db8:2::2 \
-		-d 1msec -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
 }
 
 send_dst_ipv6()
 {
 	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
 		-A 2001:db8:1::2 -B "2001:db8:2::2-2001:db8:2::fd" \
-		-d 1msec -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
 }
 
 send_flowlabel()
@@ -329,14 +329,14 @@ send_src_udp6()
 {
 	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
 		-A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d 1msec -t udp "sp=0-32768,dp=30000"
+		-d $MZ_DELAY -t udp "sp=0-32768,dp=30000"
 }
 
 send_dst_udp6()
 {
 	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
 		-A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d 1msec -t udp "sp=20000,dp=0-32768"
+		-d $MZ_DELAY -t udp "sp=20000,dp=0-32768"
 }
 
 custom_hash_test()
diff --git a/tools/testing/selftests/net/forwarding/gre_inner_v4_multipath.sh b/tools/testing/selftests/net/forwarding/gre_inner_v4_multipath.sh
index e4009f658003..efca6114a3ce 100755
--- a/tools/testing/selftests/net/forwarding/gre_inner_v4_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/gre_inner_v4_multipath.sh
@@ -267,7 +267,7 @@ multipath4_test()
 
 	ip vrf exec v$h1 \
 	   $MZ $h1 -q -p 64 -A "192.0.3.2-192.0.3.62" -B "192.0.4.2-192.0.4.62" \
-	       -d 1msec -c 50 -t udp "sp=1024,dp=1024"
+	       -d $MZ_DELAY -c 50 -t udp "sp=1024,dp=1024"
 	sleep 1
 
 	local t1_111=$(tc_rule_stats_get $ul32 111 ingress)
diff --git a/tools/testing/selftests/net/forwarding/gre_inner_v6_multipath.sh b/tools/testing/selftests/net/forwarding/gre_inner_v6_multipath.sh
index e449475c4d3e..e5e911ce1562 100755
--- a/tools/testing/selftests/net/forwarding/gre_inner_v6_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/gre_inner_v6_multipath.sh
@@ -268,7 +268,7 @@ multipath6_test()
 	ip vrf exec v$h1 \
 	   $MZ $h1 -6 -q -p 64 -A "2001:db8:1::2-2001:db8:1::1e" \
 	       -B "2001:db8:2::2-2001:db8:2::1e" \
-	       -d 1msec -c 50 -t udp "sp=1024,dp=1024"
+	       -d $MZ_DELAY -c 50 -t udp "sp=1024,dp=1024"
 	sleep 1
 
 	local t1_111=$(tc_rule_stats_get $ul32 111 ingress)
diff --git a/tools/testing/selftests/net/forwarding/gre_multipath.sh b/tools/testing/selftests/net/forwarding/gre_multipath.sh
index a8d8e8b3dc81..57531c1d884d 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath.sh
@@ -220,7 +220,7 @@ multipath4_test()
 
 	ip vrf exec v$h1 \
 	   $MZ $h1 -q -p 64 -A 192.0.2.1 -B 192.0.2.18 \
-	       -d 1msec -t udp "sp=1024,dp=0-32768"
+	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
 
 	local t1_111=$(tc_rule_stats_get $ul2 111 ingress)
 	local t1_222=$(tc_rule_stats_get $ul2 222 ingress)
diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
index 62281898e7a4..7d5b2b9cc133 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh.sh
@@ -244,7 +244,7 @@ multipath4_test()
 
 	ip vrf exec v$h1 \
 	   $MZ $h1 -q -p 64 -A 192.0.2.1 -B 192.0.2.18 \
-	       -d 1msec -t udp "sp=1024,dp=0-32768"
+	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
 
 	local t1_111=$(tc_rule_stats_get $ul2 111 ingress)
 	local t1_222=$(tc_rule_stats_get $ul2 222 ingress)
@@ -271,7 +271,7 @@ multipath6_test()
 
 	ip vrf exec v$h1 \
 		$MZ $h1 -6 -q -p 64 -A 2001:db8:1::1 -B 2001:db8:2::2 \
-		-d 1msec -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
 
 	local t1_111=$(tc_rule_stats_get $ul2 111 ingress)
 	local t1_222=$(tc_rule_stats_get $ul2 222 ingress)
diff --git a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
index 2085111bcd67..370f9925302d 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath_nh_res.sh
@@ -247,7 +247,7 @@ multipath4_test()
 
 	ip vrf exec v$h1 \
 	   $MZ $h1 -q -p 64 -A 192.0.2.1 -B 192.0.2.18 \
-	       -d 1msec -t udp "sp=1024,dp=0-32768"
+	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
 
 	local t1_111=$(tc_rule_stats_get $ul2 111 ingress)
 	local t1_222=$(tc_rule_stats_get $ul2 222 ingress)
@@ -275,7 +275,7 @@ multipath6_test()
 
 	ip vrf exec v$h1 \
 		$MZ $h1 -6 -q -p 64 -A 2001:db8:1::1 -B 2001:db8:2::2 \
-		-d 1msec -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
 
 	local t1_111=$(tc_rule_stats_get $ul2 111 ingress)
 	local t1_222=$(tc_rule_stats_get $ul2 222 ingress)
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
index d40183b4eccc..2ab9eaaa5532 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
@@ -280,42 +280,42 @@ send_src_ipv4()
 {
 	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
 		-A "198.51.100.2-198.51.100.253" -B 203.0.113.2 \
-		-d 1msec -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
 }
 
 send_dst_ipv4()
 {
 	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
 		-A 198.51.100.2 -B "203.0.113.2-203.0.113.253" \
-		-d 1msec -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
 }
 
 send_src_udp4()
 {
 	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
 		-A 198.51.100.2 -B 203.0.113.2 \
-		-d 1msec -t udp "sp=0-32768,dp=30000"
+		-d $MZ_DELAY -t udp "sp=0-32768,dp=30000"
 }
 
 send_dst_udp4()
 {
 	ip vrf exec v$h1 $MZ $h1 -q -p 64 \
 		-A 198.51.100.2 -B 203.0.113.2 \
-		-d 1msec -t udp "sp=20000,dp=0-32768"
+		-d $MZ_DELAY -t udp "sp=20000,dp=0-32768"
 }
 
 send_src_ipv6()
 {
 	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
 		-A "2001:db8:1::2-2001:db8:1::fd" -B 2001:db8:2::2 \
-		-d 1msec -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
 }
 
 send_dst_ipv6()
 {
 	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
 		-A 2001:db8:1::2 -B "2001:db8:2::2-2001:db8:2::fd" \
-		-d 1msec -c 50 -t udp "sp=20000,dp=30000"
+		-d $MZ_DELAY -c 50 -t udp "sp=20000,dp=30000"
 }
 
 send_flowlabel()
@@ -331,14 +331,14 @@ send_src_udp6()
 {
 	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
 		-A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d 1msec -t udp "sp=0-32768,dp=30000"
+		-d $MZ_DELAY -t udp "sp=0-32768,dp=30000"
 }
 
 send_dst_udp6()
 {
 	ip vrf exec v$h1 $MZ -6 $h1 -q -p 64 \
 		-A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d 1msec -t udp "sp=20000,dp=0-32768"
+		-d $MZ_DELAY -t udp "sp=20000,dp=0-32768"
 }
 
 custom_hash_test()
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_inner_v4_multipath.sh b/tools/testing/selftests/net/forwarding/ip6gre_inner_v4_multipath.sh
index a257979d3fc5..32d1461f37b7 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_inner_v4_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_inner_v4_multipath.sh
@@ -266,7 +266,7 @@ multipath4_test()
 
 	ip vrf exec v$h1 \
 	   $MZ $h1 -q -p 64 -A "192.0.3.2-192.0.3.62" -B "192.0.4.2-192.0.4.62" \
-	       -d 1msec -c 50 -t udp "sp=1024,dp=1024"
+	       -d $MZ_DELAY -c 50 -t udp "sp=1024,dp=1024"
 	sleep 1
 
 	local t1_111=$(tc_rule_stats_get $ul32 111 ingress)
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_inner_v6_multipath.sh b/tools/testing/selftests/net/forwarding/ip6gre_inner_v6_multipath.sh
index d208f5243ade..eb4e50df5337 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_inner_v6_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_inner_v6_multipath.sh
@@ -267,7 +267,7 @@ multipath6_test()
 	ip vrf exec v$h1 \
 	   $MZ $h1 -6 -q -p 64 -A "2001:db8:1::2-2001:db8:1::1e" \
 	       -B "2001:db8:2::2-2001:db8:2::1e" \
-	       -d 1msec -c 50 -t udp "sp=1024,dp=1024"
+	       -d $MZ_DELAY -c 50 -t udp "sp=1024,dp=1024"
 	sleep 1
 
 	local t1_111=$(tc_rule_stats_get $ul32 111 ingress)
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_lib.sh b/tools/testing/selftests/net/forwarding/ip6gre_lib.sh
index 58a3597037b1..24f4ab328bd2 100644
--- a/tools/testing/selftests/net/forwarding/ip6gre_lib.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_lib.sh
@@ -356,7 +356,7 @@ test_traffic_ip4ip6()
 		flower $TC_FLAG dst_ip 203.0.113.1 action pass
 
 	$MZ $h1 -c 1000 -p 64 -a $h1mac -b $ol1mac -A 198.51.100.1 \
-		-B 203.0.113.1 -t ip -q -d 1msec
+		-B 203.0.113.1 -t ip -q -d $MZ_DELAY
 
 	# Check ports after encap and after decap.
 	tc_check_at_least_x_packets "dev $ul1 egress" 101 1000
@@ -389,7 +389,7 @@ test_traffic_ip6ip6()
 		flower $TC_FLAG dst_ip 2001:db8:2::1 action pass
 
 	$MZ -6 $h1 -c 1000 -p 64 -a $h1mac -b $ol1mac -A 2001:db8:1::1 \
-		-B 2001:db8:2::1 -t ip -q -d 1msec
+		-B 2001:db8:2::1 -t ip -q -d $MZ_DELAY
 
 	# Check ports after encap and after decap.
 	tc_check_at_least_x_packets "dev $ul1 egress" 101 1000
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index db3688f52888..d1bf39eaf2b3 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -8,6 +8,7 @@
 PING=${PING:=ping}
 PING6=${PING6:=ping6}
 MZ=${MZ:=mausezahn}
+MZ_DELAY=${MZ_DELAY:=0}
 ARPING=${ARPING:=arping}
 TEAMD=${TEAMD:=teamd}
 WAIT_TIME=${WAIT_TIME:=5}
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
index 2ef469ff3bc4..982e0d098ea9 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
@@ -204,7 +204,7 @@ multipath4_test()
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
 	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
-		-d 1msec -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
 	t1_rp13=$(link_stats_tx_packets_get $rp13)
@@ -237,7 +237,7 @@ multipath6_test()
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
 	$MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d 1msec -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
 	t1_rp13=$(link_stats_tx_packets_get $rp13)
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
index cb08ffe2356a..a60ff54723b7 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
@@ -205,7 +205,7 @@ multipath4_test()
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
 	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
-		-d 1msec -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
 	t1_rp13=$(link_stats_tx_packets_get $rp13)
@@ -235,7 +235,7 @@ multipath6_l4_test()
 	t0_rp13=$(link_stats_tx_packets_get $rp13)
 
 	$MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
-		-d 1msec -t udp "sp=1024,dp=0-32768"
+		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
 	t1_rp13=$(link_stats_tx_packets_get $rp13)
diff --git a/tools/testing/selftests/net/forwarding/router_multipath.sh b/tools/testing/selftests/net/forwarding/router_multipath.sh
index a4eceeb5c06e..e2be354167a1 100755
--- a/tools/testing/selftests/net/forwarding/router_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/router_multipath.sh
@@ -179,7 +179,7 @@ multipath4_test()
        t0_rp13=$(link_stats_tx_packets_get $rp13)
 
        ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
-	       -d 1msec -t udp "sp=1024,dp=0-32768"
+	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
 
        t1_rp12=$(link_stats_tx_packets_get $rp12)
        t1_rp13=$(link_stats_tx_packets_get $rp13)
@@ -216,7 +216,7 @@ multipath6_test()
        t0_rp13=$(link_stats_tx_packets_get $rp13)
 
        $MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
-	       -d 1msec -t udp "sp=1024,dp=0-32768"
+	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
 
        t1_rp12=$(link_stats_tx_packets_get $rp12)
        t1_rp13=$(link_stats_tx_packets_get $rp13)
-- 
2.43.0


