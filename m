Return-Path: <netdev+bounces-118444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5514C9519A7
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A2DB21C20
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548951B0106;
	Wed, 14 Aug 2024 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upOt/uam"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9714D8D0
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633881; cv=fail; b=Zkydo47KXSM/p8TF6nTd2tvHOnKvtWRsAxqsLHdXOTDgxbpSQWY+hh4TgGWGojz1gsf/CoGE5ViqJViv7pLbPJ8GMRfm1PwjPDBuxUiPGCoLtYphBMpTAw7J3ictaqC9pV2TsI2dtZXDjFVb9nTIcpRdL6zMLMWT9aWoAdBGl9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633881; c=relaxed/simple;
	bh=b1uXA/Cuj4qQAA2MJ7ycngz2m3hSfwxmuhhNYT8bJ68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozx7toO9Gy1qOuQZ965KxG6rGXC4P3w0ToGofNBxS+kBNDCDz0Bq6Ta/p1o3Y3YOS4etjT+/ILW50c+42zoALu/1GgUfONwvPdEL304IVLhmPVBiFpI7qun2ybPkmYBS6vPkDXaY9b64PhhLH9E8PKWuL4ZxTKr6iRXEcol13o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upOt/uam; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuzbxXZISrF317dst4zKtqdnW3a5ie7YWOt45GLIV+J+KZ3f2tprqev7MeNXuogP8S0kU9BP54Rr7qsSMsPMoVtKzHAr3A5oyOWY4DsTApEkHwc6rRI8jRJRSVzSPVEwWITnlqIPJBiYGD0fsyvstCjc8ZIu7GvsDwwzz/1UGR3oU2NILN7ZU35ZOnEXRTfTH36uRRnCRP0lD3lGsuHaHevPPbkEyXv7+PP3yzjYU6OZLfS6DwTVfNc2vsWeD6Hq2fP43S05OFzCQCpfP/I349Pq06RH3TNaU1JCqeQoJ2jK0L1C870y/vN2FinqN0m54x8QpLVsHCFWK34egKJE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se250rGtBUF1Yb0OQz7Us5hpkaBHcB9wBVqzASmNWjk=;
 b=bBCnXntS5/QPu6avCQvgDqGEGQ+ZdWT7sJO1V3fqjWibxkeQ8ypyAh/bzmHu3SH5iktewsdZby4pbXbaNiykkwfJAb+Ch4ZeZRqHqjz5PvRsDEPSEWMG/CUvOxFxm4aiUq7lbMic2a9ruFNEUf9Oy6Um2dQ6tjZ7fP2Gzy811IKrS9zxKPI9DVakq6o2vW3ffx/xwwo9ZppiYfDMtOcFPLTxIC9dS8jDsCLa23MAyxvmxAsXw1CcYvd1hDIOXqgTXwA6WjRZkCKt8jNijPFJeCTFMujWeM3kqM/82cvQCEybZdEf5NqV4lMaOG6cgJy2jEatt0awKy/23d68PP5cyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se250rGtBUF1Yb0OQz7Us5hpkaBHcB9wBVqzASmNWjk=;
 b=upOt/uamcYOj/wSVUwk6QECdBzhi4pK4/PIfWmKXIkq9Jw8zN0jMrz5CXm+Pl7+6u92cj0EySLruNXtpdwX4d+QeSNEPB8WaqJBxusBZtaFx7EnJqiSDHqhcFgsu6NP8KZ37dVnqQedWBX83fd39oc6hoXtXwkrsJN79OBZuoi8fv9a04YSgVAT+NCNY0qrv3zRm5IEfJ7Tm/0pZ03JHqwrx/EgUQ7wdGJV+7jr/hT262Jk3AIvr1RmiFsO9S644bu0R1GqB4lgA15s6YtJBTtR0Ldnb4VO3T64o3UvWj6dvM4YjPKb6nqfK0qSae7ixDMYeU1FLPUHjShi6fy7/FA==
Received: from SN7PR04CA0092.namprd04.prod.outlook.com (2603:10b6:806:122::7)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 11:11:14 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::8) by SN7PR04CA0092.outlook.office365.com
 (2603:10b6:806:122::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Wed, 14 Aug 2024 11:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 11:11:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:56 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:54 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 4/5] selftests: fib_rule_tests: Add negative connect tests
Date: Wed, 14 Aug 2024 14:10:04 +0300
Message-ID: <20240814111005.955359-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814111005.955359-1-idosch@nvidia.com>
References: <20240814111005.955359-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f567da5-bd5f-4e80-a79a-08dcbc51d006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FurQCSbK0Pv5SF0kklMMB34cLU+BDeTsQAmtVgC8I8Q28knZoJld9SGeEReT?=
 =?us-ascii?Q?Pniuh6sa4B6vCJe0eEG01RXpT6eHp/zD9bS8gtOVQE38D4e4DJjqgUXJdJCb?=
 =?us-ascii?Q?A55OOj4eGeSPCNQ1P1HhuwzABRzZd3WaYJGtd05jwbCu9qrfAwiTEM0jhS/0?=
 =?us-ascii?Q?/VE45AoKKMZahmncu0PuLd13HzfM9rFYtOGzAb297pvwd6RAyOSPUC/d0Yuu?=
 =?us-ascii?Q?iMXpagq5d8y4qRwsja2M10MDAD9iQ1D8u/YTtczBqhSzdl+6pt4FATjG+/Az?=
 =?us-ascii?Q?UX9AyTCmuOgLHjRe5klLsJmeW2Najh5kcsO/MGo7IPmI/XKG4oEO2d9A9u6G?=
 =?us-ascii?Q?QYZefWJvfApcYrsLPOVfqyOjaK8Tmym0Q9Xnm6+mbsKrGriW86dGrUPkt05U?=
 =?us-ascii?Q?2hvOtm1yKJOkCrI9AaqBICJZxGFiP9sgVi63D4nRVPJZrUburE1Z+6vwEfzI?=
 =?us-ascii?Q?QK45TaZOZySbkRnhHcmVX8sCZSGbQvM5JLrPvxyVO4ttXgicYi1mWt7IqStr?=
 =?us-ascii?Q?xhEz/U4nlWuMDwKMwP7wR6oLQSFWDv0RsoXgMbQ5JGIq5wKCweSA7nmR+vTz?=
 =?us-ascii?Q?cFTQIj6RqIxHyTURBujsK9tD7HFfbFWsArvFlY/RNUOWC4kdSEluaA8+Q+aN?=
 =?us-ascii?Q?4OOdY8AqJtE1I+u/Qc5lN3Df8JXFEJ+6/er9/ITFLofvVq3Q2W9Zqum6TqjB?=
 =?us-ascii?Q?ey8QG34ZaFw7a47+axOONtKABWS0wKcsPi/ImANA6ZkFAytkK2/2TS7FISEq?=
 =?us-ascii?Q?OoSziwrSpEfqfcyiNMBBS4gVlq6rRt1n24hyadNrY7HiYxCYIH6yuIWgcsEn?=
 =?us-ascii?Q?l4j+A3+fAlupYRyeybEdCxEQgS9VhOG9h3sHcWMNZfl+fQGlhfbAFqyiC7gp?=
 =?us-ascii?Q?XhHWH249znNwAAcH+TAdsKPvdDAw1QI9EbNjU/jxRboRRug1hMJNur6LTS7C?=
 =?us-ascii?Q?Mnc4kHz0FhcI0Me2bqXvAEdQDRWVIkL1OneEJDjeQjx009EQb6/So08QMRMX?=
 =?us-ascii?Q?CAIbeX9XwIpggcWDX10hm6A1xpDwtgjr2iIkiqsQ9+LSsPNSATzm+SNawhJZ?=
 =?us-ascii?Q?Na6tec16IWzjn5zQIqJDjbx3iQS9+fWz+zmnRzOUWNL6rdUpFBIxxdRCMmyB?=
 =?us-ascii?Q?e4M0jK1npSOtB4UT+d6zHcl0wV2GOqdedcMKvulWA5mnXvU2TN7aZetW+B5b?=
 =?us-ascii?Q?DDSi1ZGcqrL2UgtBMDwgznRaNP652u2lIfz7W8wdCq9ql4YdKWBs+XDuuJl1?=
 =?us-ascii?Q?QKFEJGEAKc0bEcJEV8hHA4AETUhx7esqkiIPaAZIEaVNUEcHctpJIZvOcbht?=
 =?us-ascii?Q?+Zw25lObRVL8rfLy6BxM7u5gu3IHZwrLJZGnDy97NFTcL3BdPEd1eV4ng8zA?=
 =?us-ascii?Q?0D44qbSSUV6mfIzMcRS3YsNALwCDxTpraiBTnarlKVQnKeG3+WzZypgLqPKm?=
 =?us-ascii?Q?0Zolpsy3THHP8BJk+18uTjB3Zo1ih9Jt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 11:11:14.6831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f567da5-bd5f-4e80-a79a-08dcbc51d006
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421

The fib_rule{4,6}_connect tests verify that locally generated traffic
from a socket that specifies a DS Field using the IP_TOS / IPV6_TCLASS
socket options is correctly redirected using a FIB rule that matches on
the given DS Field.

Add negative tests to verify that the FIB rule is not hit when the
socket specifies a DS Field that differs from the one used by the FIB
rule.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 085e21ed9fc3..a3b2c833f050 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -325,6 +325,16 @@ fib_rule6_connect_test()
 		log_test $? 0 "rule6 dsfield tcp connect (dsfield ${dsfield})"
 	done
 
+	# Check that UDP and TCP connections fail when using a DS Field that
+	# does not match the previously configured FIB rule.
+	nettest -q -6 -B -t 5 -N $testns -O $peerns -U -D \
+		-Q 0x20 -l 2001:db8::1:11 -r 2001:db8::1:11
+	log_test $? 1 "rule6 dsfield udp no connect (dsfield 0x20)"
+
+	nettest -q -6 -B -t 5 -N $testns -O $peerns -Q 0x20 \
+		-l 2001:db8::1:11 -r 2001:db8::1:11
+	log_test $? 1 "rule6 dsfield tcp no connect (dsfield 0x20)"
+
 	$IP -6 rule del dsfield 0x04 table $RTABLE_PEER
 	cleanup_peer
 }
@@ -502,6 +512,16 @@ fib_rule4_connect_test()
 		log_test $? 0 "rule4 dsfield tcp connect (dsfield ${dsfield})"
 	done
 
+	# Check that UDP and TCP connections fail when using a DS Field that
+	# does not match the previously configured FIB rule.
+	nettest -q -B -t 5 -N $testns -O $peerns -D -U -Q 0x20 \
+		-l 198.51.100.11 -r 198.51.100.11
+	log_test $? 1 "rule4 dsfield udp no connect (dsfield 0x20)"
+
+	nettest -q -B -t 5 -N $testns -O $peerns -Q 0x20 \
+		-l 198.51.100.11 -r 198.51.100.11
+	log_test $? 1 "rule4 dsfield tcp no connect (dsfield 0x20)"
+
 	$IP -4 rule del dsfield 0x04 table $RTABLE_PEER
 	cleanup_peer
 }
-- 
2.46.0


