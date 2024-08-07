Return-Path: <netdev+bounces-116509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0213C94A9B5
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F8E1F2A312
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEFD5473E;
	Wed,  7 Aug 2024 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JT6ED+P7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB30F4AED1
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040095; cv=fail; b=tXj8HBS6yx1AGYLeEQY4KkvfDmy9l8lbA8ulmnpvN7XFRii7crradj13xng9oMrKA4Npegn7IMBzYkMAjj4AFcoqkDspf7FnTfvXPbRcTQXi+KBML30D1yqp8St8XN1cvfNIlKgqJkxtyFtyRM/G2/14PQb6ti5hr+a6nIOCPt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040095; c=relaxed/simple;
	bh=9VxgnFTpEZIzf2GqBuv2unGsG1sVzfJI6mo+XG4e7Ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3NK95Ex+sW217u0ZT3qFmKUgyT+0pdeNeWe1gVX9kNwg8xM4n+F2VwwgUxK4ULSaXOqOUQGGN0VCGVL1gOUjE4W2Fg8qi9O0xFlIuqdY3G2HjS0ko9RdfB/IfCoXW/EtPAhe/KlvH6bKPq8fkhyiNg+T7Glp3KmN9bxNd8XEEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JT6ED+P7; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHPn2Veozc25LXXNvFcitjbb9rkXnZN+PTAHQKGhe+aAuPFOL++xLQoLexmti8TMO1zXGk2FPBumhkJEkKKi7PuyblbTM/oEXS4BboBRBekGqwhzKvcFuG+if2uVjS9qhKwThlVcNhlO12s6vok03l/cMVpjfETBlo3EIF4kwfGFz+iaR4r0t52GT4BIYXudsNT6d5xBdP2nRWrzoNPqi3Jo8NdBzxEHSESNFXQVJHD0iKqdjEEZRokfue8Q18VamlDnMwL9xkCbmSGQg2EN2Xhl37v5E0m4eMv16gBBhhCTs5O89OnKFo91iPowAJx6QQkNGxrd2yKLePIqljZ+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BD9D5g7wPFyoMWxJhHTuaePtksyLnJAfZjWpYga524s=;
 b=ZiWcJ330BivqOv7wdXOnYZzqPNz76XgJtolSvT3cL0+zDuWhH57SeYqG36BL3BdJHNjOiLufaG7uJOXWzx4YJvfCSDHXoO4e+TpdvTFGjNaSGPaqV17tXwPDITxf9CTJXiQVbryCkAgVgbTD+k1RM/9ER2RqvtwWjC+OY6+2L4aacKnaMCX+GRjJsbM1JsuvvwwGaoPDXtu+9FLI8f9M51ZJfs/HbygDiDKQXnW237gTlaR/GiDqqVENJjqtGxoX/082PKlL1F5xfIuc7PaEOrLKUle6jYvF/y305cIHgWS4crpzG1uCxfX/EwEfkLsLDSpKQMu0mJyFxPuWa27mng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD9D5g7wPFyoMWxJhHTuaePtksyLnJAfZjWpYga524s=;
 b=JT6ED+P7w2xWmNgESQsXNt8Izdx/T3LKY43r/0UDEpMw0ZZJbZq9TvPPONGnY/IRcwTHVif9XTng0y84Xs6jZHdqyu5DQG7B3WngWGV/Jfmq3qn6unEkJtlXvkUOJjnBHePmzU/EncvO1Uj2cg2oh7hSQ5h8qZZw2agQsx1Ig7qPPvKQc+1fSD8LpGmdeV9SQ87zBzo0MM2ptHe6D0BxkZ+5vOhOdiYUt5I3U6kOhqJp7fWqfovEEfp0dPTTnqv56CLc5JUhDwfoRLex+UxdHPJ/TQidek8MyYUKuJeZTQqKkSkHMwtMlsPUsvG+qpjeUj9UoairWmOEJZ1zAL2vpQ==
Received: from CH2PR08CA0015.namprd08.prod.outlook.com (2603:10b6:610:5a::25)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 7 Aug
 2024 14:14:50 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::67) by CH2PR08CA0015.outlook.office365.com
 (2603:10b6:610:5a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 14:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 14:14:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:28 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 07:14:22 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 3/6] selftests: router_mpath: Sleep after MZ
Date: Wed, 7 Aug 2024 16:13:48 +0200
Message-ID: <8b1971d948273afd7de2da3d6a2ba35200540e55.1723036486.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723036486.git.petrm@nvidia.com>
References: <cover.1723036486.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: ce439836-b82c-4a47-5be6-08dcb6eb4c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kq2n+/P5odSwcRhPT1cKB57aEwZpxWMw02s/eaSDmU9a8N6eGuQ1VOglcLr0?=
 =?us-ascii?Q?G4aeoFfdZiARJn5ezjmT6tHAWsYFDqon10OMx6b/NLYcb/AV7VOuGPyeL6lB?=
 =?us-ascii?Q?KiRuxfSUh2q7s0LatheluQKzKiMncBrBzh6ABrgBHxeCtrke4fQ/PLr0bO/7?=
 =?us-ascii?Q?+JH1nu64BRoo9pytR+PeUZbUolpS9PhcOkA8LrITENi9qC2vWwf0+beTkHEX?=
 =?us-ascii?Q?mOzRgGeP7yFu/oCi7VDA+17RweGsMAujFWOSzDgEXxl337jYQN7QECylTw9g?=
 =?us-ascii?Q?SAG1DoffpaJM0wFL0qniqGvU1sv34EZq/SZstzv+w4DXbmvTg55GeVjTK4VU?=
 =?us-ascii?Q?bK8lbpe+10Ut7rOTasEii/JyQ4XWeSkYzRa/lGKGbK8S9Rx/rfCjafDvZJsS?=
 =?us-ascii?Q?0AqZAYkDMc64hhMWJZ6Q5kszUcfOMmVjuH9kBhAsHaLgz2Cs6rDtEE2ZSd3Z?=
 =?us-ascii?Q?zfQ0vLw2OMjXlJSwOMZxGmEIrszbXyHcTGULbDgOUVGv1DAY6ddvv+9B0yPG?=
 =?us-ascii?Q?ZOw78mGnLATchGryYVnNXkr9lk5LNUj388rOwVp9ZaRolyvOJcXYRxiBZZGm?=
 =?us-ascii?Q?5CB/SxJuqNPm1Izai98NDO3sZgKHiuj+RAEH45oC9SZiyn/O43mKWvrQoH2W?=
 =?us-ascii?Q?S9s1TLJBMweJwZ/Fi1wpO6jcl4xtI+fFXgKpRNG+xnZUWGg+5GFUTQW5BYTr?=
 =?us-ascii?Q?K9L2iOcZfRVr8kEA7funeT3BlyB7dVWyGpZNPvwf9bbz8UTZHi5z5HYKJBE3?=
 =?us-ascii?Q?837l+v01GaCDL0GAuRHuijXsKhGD0o00k4AlQ7S0Y5ZQKXSC/h/028kzxp3i?=
 =?us-ascii?Q?xP9A5ysH2l7zChFiX99TsIhI08FnrUthR13ag54FWH8tES9jdYyXYsaXnrlK?=
 =?us-ascii?Q?lePCKwfUqvmNG2OsB6I+gffHBvGT14c8PLuLZKDqxXxCRNi/wN+3VfHVsAtB?=
 =?us-ascii?Q?EvjdpHWZB2nfzyjss27Alt7AcZE+lMdEt0ojhkcs03SxyzXZbQyOidokUfJJ?=
 =?us-ascii?Q?ATZTRK0jKIZZBNBG6nBkF/pk9hLB2Bv5rpRJ7DdD/RqsuBDuw4eGdbr1VgeU?=
 =?us-ascii?Q?lpr+4vag7zGW0Tbb+IU4+O0967bs7Dh8y+UlIChwFJMJJh/u1KFNyvBl0HAc?=
 =?us-ascii?Q?Mk1Zddq8Pm0eS04NXQVoij983owsabDaaqmw3CxGU42jGFjPyN1FqLztT6e6?=
 =?us-ascii?Q?IQP1l1ZeF3+odAZY6oHJSC2py/6bwzJOUroxKujEQj8b8e5hFt7CJu1Qc2Ca?=
 =?us-ascii?Q?xvsX0xx/LcOt974ylFgLLQiaV77UCcPaXUtPdLi51qDP2Lzci4uoEoQenCQB?=
 =?us-ascii?Q?SkIWsKvZFS6SQgxNgO4Hx5XVbnbtgqkz2SFblx5GPB7qm+n/mEnooe8sIsg6?=
 =?us-ascii?Q?hESSGHJupEkr9DcOwxhCFGqEXnUqWoEEAwLi7xGzsXWb+mr0EMHOgFr70eMT?=
 =?us-ascii?Q?icLj65Gjk+wnlsqN2OMOsmqg57nsC+V4?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:14:49.2372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce439836-b82c-4a47-5be6-08dcb6eb4c54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676

In the context of an offloaded datapath, it may take a while for the ip
link stats to be updated. This causes the test to fail when MZ_DELAY is too
low. Sleep after the packets are sent for the link stats to get up to date.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 tools/testing/selftests/net/forwarding/router_mpath_nh.sh     | 2 ++
 tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh | 2 ++
 tools/testing/selftests/net/forwarding/router_multipath.sh    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
index 2ba44247c60a..c5a30f8f55b5 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
@@ -243,6 +243,7 @@ multipath4_test()
 
 	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
 		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
 	t1_rp13=$(link_stats_tx_packets_get $rp13)
@@ -276,6 +277,7 @@ multipath6_test()
 
 	$MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
 		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
 	t1_rp13=$(link_stats_tx_packets_get $rp13)
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
index cd9e346436fc..bd35fe8be9aa 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
@@ -244,6 +244,7 @@ multipath4_test()
 
 	ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
 		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
 	t1_rp13=$(link_stats_tx_packets_get $rp13)
@@ -274,6 +275,7 @@ multipath6_l4_test()
 
 	$MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
 		-d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+	sleep 1
 
 	t1_rp12=$(link_stats_tx_packets_get $rp12)
 	t1_rp13=$(link_stats_tx_packets_get $rp13)
diff --git a/tools/testing/selftests/net/forwarding/router_multipath.sh b/tools/testing/selftests/net/forwarding/router_multipath.sh
index e2be354167a1..46f365b557b7 100755
--- a/tools/testing/selftests/net/forwarding/router_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/router_multipath.sh
@@ -180,6 +180,7 @@ multipath4_test()
 
        ip vrf exec vrf-h1 $MZ $h1 -q -p 64 -A 192.0.2.2 -B 198.51.100.2 \
 	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+       sleep 1
 
        t1_rp12=$(link_stats_tx_packets_get $rp12)
        t1_rp13=$(link_stats_tx_packets_get $rp13)
@@ -217,6 +218,7 @@ multipath6_test()
 
        $MZ $h1 -6 -q -p 64 -A 2001:db8:1::2 -B 2001:db8:2::2 \
 	       -d $MZ_DELAY -t udp "sp=1024,dp=0-32768"
+       sleep 1
 
        t1_rp12=$(link_stats_tx_packets_get $rp12)
        t1_rp13=$(link_stats_tx_packets_get $rp13)
-- 
2.45.2


