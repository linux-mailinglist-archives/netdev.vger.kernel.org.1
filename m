Return-Path: <netdev+bounces-127314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EDC974ED0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2101C22605
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F365176ADE;
	Wed, 11 Sep 2024 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p69pqr0w"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A3176AC5
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047533; cv=fail; b=tbaLEcakb73LQ0fefssSaCt/JDwK7fVQc6S7nbmavYcBQbmgAlfi9fWfN4YOV9kWcIH+PMK8i6DlaIdCodgrXClRWapei9+dUd73IJ7XrZhM9IV18qksr6XoKoCMdJENfn29NH2VieT8XMB0DjO9z0BnOmbHkDabkKjfUDe7Nfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047533; c=relaxed/simple;
	bh=mvcnCQIv7Bot9l35d5nrSDF1+L0C163/INu2hDitmgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnROfUGMWYeXTgD+dYC1CecFF2tuc67x1vW9sqCoyNzX6OJ8E1L2OWbZWY95lRUBVLUhhAibZR2nXG44/Ie+I9pqkaUVWVnaSJB41DwtfdQOzZcyc+6l3w/njXb6QlqKyD4HtF10gVMyf9wf/nFcRm1EpsWXz39gZrefOnD5qyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p69pqr0w; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyOPfeZU75IP7B1/JUHQpgTeKkFvzZdjjo2PeAvLuNlcmOOtkfcSyQgvLwPRFSeQbuP6K45j9fghKJjmslmNPbbdSn+La7TuBZFVd50S689fLOMVfKoJuIRx7h+hb8gRMwURsRlyQI+O/hSqKFHHI0rkrXtWckjCs+94Nx2YJLSYssyWpG9fmY0QcnRkVfW0j6ePc82fCbKQ6m1kDwdUo9o1iyTXvShIDkRGGA8QROjhhMF5/JickhSqmFzkiOuynrthjuRzLWq5O5Un16g1uy02b1Uc3sVvZo+1GN4RoAafYrLrymqBEYb+TK9r+XOrp2b15o7TxVYm6jt62GDAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=li5CGoewwjlj2ejoOdFksKXFG0m4EexWo5PhUoZM8cM=;
 b=G1QF5Y9BFz1487Hle/CnVoecQBEVKdr5W+Rbis8DwpYgMvhNfF7zGXtFndN29+ulOeNPSyY3aWbSHa2pBaBHabKybXf9Y2GqRtQ38DHE1WNu+PMZP/XujoUbZPDjny4TDXH99FtIbaB0oeQFA7CqsItDYZfPwcOSpj6DUDm/QF9mhNibmimJuTIDVX3c9ZefuYjMTOhBdrCtvjNAxXQ5id58wtNC5BjJ9x+lNIVKVnzGtPHiT5Oz+5+0JstZgxc3dau7NA1eP6UFCLowaKZRHAwwcNVUO/4NeEYyvmfCe14sjlytbqFin2/E4jNZOfMCZCVLzYfXgsa8uFn+ZziqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li5CGoewwjlj2ejoOdFksKXFG0m4EexWo5PhUoZM8cM=;
 b=p69pqr0wAyNFvuajamKBnYSXcQahPl8bw7dCO4AOqAuJnmXA3CBrl/IdiDBtlVQ+xhwLNgxanCss9V24D4a+11Af5Dmz56OO19y70QUgF8+ml1/mfWwYe1r/15yaeXpWimwgSJE6bx6hI+oJmnEd4MNPRELsfSuIqYxMP0x00106BHSdIdYJ2Uc3gAtIGi+e4sz80nnvGhn4RqQuYwCQb+uL7lznW/wnhNs9rh4kZm2XrOwtLBnVMoILBW0mF749g3Dp7x5DZMgLsWKu5b4XS2UPFJkCs6o3kSV+2JkZpS7gzSx4Fhp3oT10FzYAZlVB7HWwbX0g/2a6gy4ernHXuA==
Received: from PH8PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:2cf::17)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.17; Wed, 11 Sep 2024 09:38:47 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:2cf:cafe::1) by PH8PR07CA0037.outlook.office365.com
 (2603:10b6:510:2cf::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 09:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 09:38:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:29 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:25 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next 5/6] selftests: fib_rule_tests: Add DSCP selector match tests
Date: Wed, 11 Sep 2024 12:37:47 +0300
Message-ID: <20240911093748.3662015-6-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd77258-7abc-4e81-ba9e-08dcd245890e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Exo/JjSyDOfyS5ELEE/9Dczm/NvtZhVFqhv36yvwGjGVdega0zjfH1iP4kY?=
 =?us-ascii?Q?prwiWJfdueAwdWXtL4NBRtv3jtFUlp6r7Ph0Y7L6Ze/9IjMURY0o+M2w07nG?=
 =?us-ascii?Q?JvQc9Rdvu2RrjPVG+AUUO8B/+u7OPAxaRXsZPim+vYxwNbKEtkitRqDrHaAD?=
 =?us-ascii?Q?2BjyRmLuSravLs/veE/nUrfw4Nw1ND+5JBT3EI4k/wxHpVKUtgGAms1qVWCR?=
 =?us-ascii?Q?IBvie3FUYx+5uiGJoeUM2TMVJ7UiZE5nu4mc9Qcol4aMfM+HLtWpzMyKNhCc?=
 =?us-ascii?Q?5BghXsSR3leweXzBWxI3RHJpCowQV6NVfGxquenbfEAz4Jk7b6/e6kYler+P?=
 =?us-ascii?Q?iQSgXK52g6U3GHWhqGmeGbXgE7dHw32xy2oy5sVzIsOdDMEOkG6AMxzx7Pdg?=
 =?us-ascii?Q?E0du/rtrwx4ue7Usq1xwXs/CHZrWEiT/0q/I1k2m0uX8Dav5wG2uaoqSw2nC?=
 =?us-ascii?Q?sTulcOaPGQMHrl7rk/AIPCPJtqcrRSW7AESMRUfHKuoa+PM7pcONzLQJOHjW?=
 =?us-ascii?Q?CUOMSl6p5wT+eOGy8N2nkPqQBEYK2WUR7x/VftdnQypmvFtnMR22iho5i7wb?=
 =?us-ascii?Q?NaAbEQX7GDphke5GpwMBZrLb4dIKjnv36yy9Q7Bnk1l3jk59WbwgynmGuTQ5?=
 =?us-ascii?Q?dJ+Khz3cNfydiu4DCz5NzeTh5Sh+86xBem/Y4vZzl0xI3rNFpWGOzUuv4PRX?=
 =?us-ascii?Q?icBuFSS5OwI6LVl4VZflyw8MMuGkhl6hGFQQT+BfT9NBMUo+R6o7QneUKN6N?=
 =?us-ascii?Q?fR4XDCNri2ZVr1bpAY6YViesgajY9m+b5+2aAAlpMcfKFMQHNB74uWrfmkE5?=
 =?us-ascii?Q?YuMw1lnuO3lQgkKDl7ynA0FJ6dm764B7SYG/ZbGIGPxTiIcT4XAvJAKM6N4z?=
 =?us-ascii?Q?SGLK0ZpdWgngMnwLbSj2jJH7pKktGp9BNNhqUZTBcT5x0Zz3ATJKsD527i70?=
 =?us-ascii?Q?U9+a96T0yRMu9nhQWgJDtRDSroGKlBhwfcFiLV0lPos2L6bIwza9YcwUpyxn?=
 =?us-ascii?Q?GK93gRPBXLUeQa70yPNkvRWQLiBVgzqVdap1Oi1TePUvkbQWq61hAgYcG+4b?=
 =?us-ascii?Q?7JbcnJ1rk5QFKxFMW/NU1LWfhZ0O4XHcPoxofeDEIVH0izkd6s4LXdNVo6F9?=
 =?us-ascii?Q?xGV8yUIxzWDJi1aA4nHJFleIJBkc2AXoEC57kk5G/l5bDPL34Q4FMaQhUSYo?=
 =?us-ascii?Q?Ic7FN5DR0zAaPPE3TrpyoQyh8JiGphB3mUUX2jGaq6eNWddZl8I757t7w5R0?=
 =?us-ascii?Q?YpethBokVW8yzPFIji2bDBXb82WZc+VqA3P4WeVNDBlTysl9FAtP+WUvfeer?=
 =?us-ascii?Q?7ciBw3kJfBdtGxJYpxgLsvG7/ezMrDlKgIlKtDX/Im8zfY89YQELKm7JgGYx?=
 =?us-ascii?Q?+tQmWlqNkDnMfjM5r7Yv05qLYcvi0opAcZxsQacBK4gcVLhY+pM+kkl6RzON?=
 =?us-ascii?Q?hifLDxN6i7bsDKlypYqWzjPJwat2prFl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 09:38:47.2850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd77258-7abc-4e81-ba9e-08dcd245890e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435

Add tests for the new FIB rule DSCP selector. Test with both IPv4 and
IPv6 and with both input and output routes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index 53c5c1ad437e..21d11d23fab7 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -274,6 +274,23 @@ fib_rule6_test()
 			"$getnomatch" "ipproto ipv6-icmp match" \
 			"ipproto ipv6-tcp no match"
 	fi
+
+	fib_check_iproute_support "dscp" "tos"
+	if [ $? -eq 0 ]; then
+		match="dscp 0x3f"
+		getmatch="tos 0xfc"
+		getnomatch="tos 0xf4"
+		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "dscp redirect to table" \
+			"dscp no redirect to table"
+
+		match="dscp 0x3f"
+		getmatch="from $SRC_IP6 iif $DEV tos 0xfc"
+		getnomatch="from $SRC_IP6 iif $DEV tos 0xf4"
+		fib_rule6_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "iif dscp redirect to table" \
+			"iif dscp no redirect to table"
+	fi
 }
 
 fib_rule6_vrf_test()
@@ -468,6 +485,23 @@ fib_rule4_test()
 			"$getnomatch" "ipproto icmp match" \
 			"ipproto tcp no match"
 	fi
+
+	fib_check_iproute_support "dscp" "tos"
+	if [ $? -eq 0 ]; then
+		match="dscp 0x3f"
+		getmatch="tos 0xfc"
+		getnomatch="tos 0xf4"
+		fib_rule4_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "dscp redirect to table" \
+			"dscp no redirect to table"
+
+		match="dscp 0x3f"
+		getmatch="from $SRC_IP iif $DEV tos 0xfc"
+		getnomatch="from $SRC_IP iif $DEV tos 0xf4"
+		fib_rule4_test_match_n_redirect "$match" "$getmatch" \
+			"$getnomatch" "iif dscp redirect to table" \
+			"iif dscp no redirect to table"
+	fi
 }
 
 fib_rule4_vrf_test()
-- 
2.46.0


