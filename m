Return-Path: <netdev+bounces-127315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47FC974ED1
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C13B29DC5
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2941317C230;
	Wed, 11 Sep 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nX0f4olZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77844185936
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047536; cv=fail; b=mOJeNemA6ECfIo6MT53Rs33Dy9V5DgXklLfkcJeUzt8pxSKb5EY9+huMl8o5BBfCUxVW6e0xkWUVf/yNoYdnTaET/imW7cEmfUgKgSeYIWKfGytCqw0XbDvIn9MA65WXgqjQRFZE+pIuqfVHCS/qetkYvdSkacMpw6XtehfHrSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047536; c=relaxed/simple;
	bh=FjvS3YsxC6EOn/OQhrIcX+fg+Rx5TDIhpAjE7XRKnG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsDpXNmq8ZP836kgX64q+qKBGfK5x4zdST8k6kToYVP1Av1Vn61q+nWau7C3EN6noDKaryGR0SWIS7FTLPa914JHTTztBQ4yJ+Dql6XoiY9iNDDcRG1iqlFLk9FKk5AhogKwZjze7VWpoBRADP72fsjiTFDrunPqQDGRo4Gh3Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nX0f4olZ; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5FZ+kzs5QoVNY7L6DM5IccNb1y7NWrItyXFKN6MynGNGgJ+uLylCrjUmpUQmyusPm2DrXy0JaII3RSeKfBDxOISrZrugltOGH8MasQTBK0sH/Ct1PoTSJ2BmMug8A4bMSsUUEiwpkgE6RDrW0OTq0vCAF1gBt2418N4sYOSFaJzM3N03lBWzTVj2kDW/bQdBButEJ5pC5CNJ4BDIUKCcZ1xyTyp2PT8YS5v2lf4re3RSgVp5GA0z1CKGziLwSVOtLUdipn9Tb6XEhpfJCL6E2CiAt8Hx/+U6FFScDCOi5Q0oHsN7eXg31AgIUhwE2NtcV1aVekavTfmqARejMhDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly4GeywsXVWLfCWKV1E4FpddJHNk96y9a74uUL1IFMI=;
 b=y30CYMeN5DCn9JJI22/mHXcwDfwufYmDo6GR3cBJjfiDQPitVKD3c9l2ZXyOKXGBlE+y8mR+hIPeWAKX29bAgX21JkAb4GaOGUnFC6vmtRo/afcJyu/nXhO5OaVmiTAzAamdHLZ3iayA+4xwLK6jgMWD/TVgNn89JTplXy8jxThN5ne9j3ZjSKfp+m63pZPZ2TQsKpk4R92cT6ZFhnIs+awrYaPJbKZrr7KVtRTFF/lDgegzwqVJTHZLV5NIS0ptAK1HEyXku7U3Hwfruq7NujLPxGmlNTpdOxleb7elNVqM2+Nk2S0jiWWe+DcnvEee0fW/9Hwf/Ad89rtZLIEXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly4GeywsXVWLfCWKV1E4FpddJHNk96y9a74uUL1IFMI=;
 b=nX0f4olZcdXHygawHFQENtC5ZPI4BerD6QlCjmV8WaelRdKR/dLxUrLrF4Ahu93T8cP2/YH6ArqFSIhhUsO5v/u6kaIAMwzuJtD9C4X0XXTxil9Ey27uBFXCJnUTIzpYPh7x1hFrYUqp+wZWHqNMdfkQzyLujvb9GoYIpW1na8cSuy7nY+2xdv1/yrF8C0E6/AH8iSYnu1aJiwaMm3SCx1AMNWaqxGSrazOZO8jKazlvb3gO1yeD2J/Jn1L1K69Z1M8QsA7A3TMhrXp7XRFFd5o7TrAk/WNvOm6xGuFNP49brLqnrIODJE8+yvNk29Cg7kkeDqNsAy4fVHzpwVOkMg==
Received: from MW4PR04CA0295.namprd04.prod.outlook.com (2603:10b6:303:89::30)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.33; Wed, 11 Sep
 2024 09:38:50 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:89:cafe::ed) by MW4PR04CA0295.outlook.office365.com
 (2603:10b6:303:89::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 09:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 09:38:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:33 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:29 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next 6/6] selftests: fib_rule_tests: Add DSCP selector connect tests
Date: Wed, 11 Sep 2024 12:37:48 +0300
Message-ID: <20240911093748.3662015-7-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911093748.3662015-1-idosch@nvidia.com>
References: <20240911093748.3662015-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f22d90f-7efa-4d0a-7bb0-08dcd2458aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UxX0CPK1tpMsEmKaseLu4v0fwlQFsY7YNuyPmYOGnQmwPzz/o9rI+doWDuaH?=
 =?us-ascii?Q?b2iGHIkfk/wn67el/T9ioniEcOcrHh6ayprVayxRxX+O6aSWze/kKGRL+Njd?=
 =?us-ascii?Q?PhoMBMDSlE9Gxeqs2DmFx1h3dhenHOjdjUWvbfg0k5CI8Ms4OAcNiyEGBBGn?=
 =?us-ascii?Q?8FoIoBvNXRZwbMrTWVPQ6l+N+j97EMmp203/lbwC4qDvcUooiU8+wXYXxHDo?=
 =?us-ascii?Q?iWCEg+9y/tef+XeUfdEs6zm/KJ8bcZXutTUj+oWxXeNVh1TCMJyPnyURsOFi?=
 =?us-ascii?Q?ZgZUmda1MNrpoPeOXqaHU8DSFRkvA9QVRoJuB5bQpgW+gyuivISAmt67jrzG?=
 =?us-ascii?Q?9Bt2ihZBxUaENnKNYQPjjIouF/jBQwjHfLEJSRAMu/5QITL8JK74bodZj/sz?=
 =?us-ascii?Q?RfdZv5MCJYa8jf99Jtw3uyCECL2lBNNEvQcFSTctmKgz3nZtRK/yL0n3Cfax?=
 =?us-ascii?Q?agoiO2Nbr+hb0sIRuJY2rvJsCUTtUuAvIb5Mqoyb/9GgpBq8hIk29yUGGtZt?=
 =?us-ascii?Q?sM7krNDzYtNBJImtL+mp56z9udaujKVqqgqUCID72lnCIe5JukEPlqLp6Gzr?=
 =?us-ascii?Q?wgGpIhRNgrKvFXwPPWsRXjUyoEVVUwlP6d44dWZsT8QRgquvMWuMWQPLSrxF?=
 =?us-ascii?Q?kz0G8Q02dWxWAxrfvMT/WTXaeQnzZTyCvG8uhOcX55GNfXbZws2hKT/ZrM4d?=
 =?us-ascii?Q?unG1RVQqEE5yw5loBJsveTdLcX4a95yptqwY2tbvSeMHwK+YU/Pzvnv84jKR?=
 =?us-ascii?Q?yy1EOKVCRXyvIY0EsHu2Zh1iovYmp/ZKyDNPQXWh5V2bUO3RKSMBr8LewCH6?=
 =?us-ascii?Q?/QI7Wh/g6gLKFGnnF3DYPSV3lBTBV4sVearJA/MPGWM/+kqULndRvq2rWDUx?=
 =?us-ascii?Q?gdftTkQnTwsd+ekMnvkw+gZGu2RJAY3JSFYXcOXYwqLXqE43MiXA0QwCs+Ob?=
 =?us-ascii?Q?rOqEG4PHSS6bDgnN+CRlht+PFMImrc54x7R59J6hYhoES6rpCB8D5CZ/O0C+?=
 =?us-ascii?Q?9wkeB4f85fK7axIGsxwqvePytpclUa9oebfLvJtBO+PQTgbayPcA0Q4wrzwc?=
 =?us-ascii?Q?XpJnYcG8Gb4v8KZt+gOim8fSJndtVp38w9uPG0vvgxHzdolEl0DfNKrUaKqM?=
 =?us-ascii?Q?CTo6ejLLKyVvBdZFh5lIm2qnrxdkZYjnHGQwt/qWxltmCGNS4sFdZ/W1cioL?=
 =?us-ascii?Q?peamJaTSDNiQM8pLooMQvnkjFAfODAa+sVQBi/HUjWgW451eijc8b/eOK9Oi?=
 =?us-ascii?Q?wJMBkuW3iEj29Tl0N1Rdvn6sabcjlYl8N5coK0g77nhAsXvCxAIkPWDoWlp1?=
 =?us-ascii?Q?g+kqP/X+HDyXeyQ7XuvccrudV/7ASj/5A/90LsCCmgVSzgSPQUdt+3qVWFZi?=
 =?us-ascii?Q?lORKWLnMdYGZKWQrn0Y4XxoDcbJ9Jue1zpHv8jafllTZVAN1VUpsC+xkDNhV?=
 =?us-ascii?Q?z1cU26Z77z7BDnQxeqmHhi7+UJ8eMJ7H?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 09:38:49.9401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f22d90f-7efa-4d0a-7bb0-08dcd2458aa1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566

Test that locally generated traffic from a socket that specifies a DS
Field using the IP_TOS / IPV6_TCLASS socket options is correctly
redirected using a FIB rule that matches on DSCP. Add negative tests to
verify that the rule is not it when it should not. Test with both IPv4
and IPv6 and with both TCP and UDP sockets.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 21d11d23fab7..1d58b3b87465 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -336,6 +336,34 @@ fib_rule6_connect_test()
 	log_test $? 1 "rule6 dsfield tcp no connect (dsfield 0x20)"
 
 	$IP -6 rule del dsfield 0x04 table $RTABLE_PEER
+
+	ip rule help 2>&1 | grep -q dscp
+	if [ $? -ne 0 ]; then
+		echo "SKIP: iproute2 iprule too old, missing dscp match"
+		cleanup_peer
+		return
+	fi
+
+	$IP -6 rule add dscp 0x3f table $RTABLE_PEER
+
+	nettest -q -6 -B -t 5 -N $testns -O $peerns -U -D -Q 0xfc \
+		-l 2001:db8::1:11 -r 2001:db8::1:11
+	log_test $? 0 "rule6 dscp udp connect"
+
+	nettest -q -6 -B -t 5 -N $testns -O $peerns -Q 0xfc \
+		-l 2001:db8::1:11 -r 2001:db8::1:11
+	log_test $? 0 "rule6 dscp tcp connect"
+
+	nettest -q -6 -B -t 5 -N $testns -O $peerns -U -D -Q 0xf4 \
+		-l 2001:db8::1:11 -r 2001:db8::1:11
+	log_test $? 1 "rule6 dscp udp no connect"
+
+	nettest -q -6 -B -t 5 -N $testns -O $peerns -Q 0xf4 \
+		-l 2001:db8::1:11 -r 2001:db8::1:11
+	log_test $? 1 "rule6 dscp tcp no connect"
+
+	$IP -6 rule del dscp 0x3f table $RTABLE_PEER
+
 	cleanup_peer
 }
 
@@ -547,6 +575,34 @@ fib_rule4_connect_test()
 	log_test $? 1 "rule4 dsfield tcp no connect (dsfield 0x20)"
 
 	$IP -4 rule del dsfield 0x04 table $RTABLE_PEER
+
+	ip rule help 2>&1 | grep -q dscp
+	if [ $? -ne 0 ]; then
+		echo "SKIP: iproute2 iprule too old, missing dscp match"
+		cleanup_peer
+		return
+	fi
+
+	$IP -4 rule add dscp 0x3f table $RTABLE_PEER
+
+	nettest -q -B -t 5 -N $testns -O $peerns -D -U -Q 0xfc \
+		-l 198.51.100.11 -r 198.51.100.11
+	log_test $? 0 "rule4 dscp udp connect"
+
+	nettest -q -B -t 5 -N $testns -O $peerns -Q 0xfc \
+		-l 198.51.100.11 -r 198.51.100.11
+	log_test $? 0 "rule4 dscp tcp connect"
+
+	nettest -q -B -t 5 -N $testns -O $peerns -D -U -Q 0xf4 \
+		-l 198.51.100.11 -r 198.51.100.11
+	log_test $? 1 "rule4 dscp udp no connect"
+
+	nettest -q -B -t 5 -N $testns -O $peerns -Q 0xf4 \
+		-l 198.51.100.11 -r 198.51.100.11
+	log_test $? 1 "rule4 dscp tcp no connect"
+
+	$IP -4 rule del dscp 0x3f table $RTABLE_PEER
+
 	cleanup_peer
 }
 ################################################################################
-- 
2.46.0


