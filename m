Return-Path: <netdev+bounces-218658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0424B3DC79
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F8179826
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3F32FABF6;
	Mon,  1 Sep 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E6EH7phG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB712FB611;
	Mon,  1 Sep 2025 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715590; cv=fail; b=Sx3K+2VIBZemiTsa30SH4ZAswRTiRlfqdmZe0F2AmGrk1mt0T5oF0wq96B3zSb/hzRqES18vnxD7Wb1TYMzTiGm991FhzkCxUT2hwiS3VlgqI/dbtHxe5k9IuzR0t7FxTmolcyzIaruX4dbCgrdrGRoeEm0R8M+r62uDJQTVtc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715590; c=relaxed/simple;
	bh=wIFqirhbhARaywliQleKu98+zkVnYG8hxHYXMgE4NWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNkIFPkGWjJDJfkolbXqOKkXFCkqlqSm8GfzU5uN7bD9J/jjwq9DtjMiCvlTJC82bDOGZ6Hd3iooo2UbabudLcv4lAMQGlHFzwKspnscS/+IgkRwNpD6lqtA4TylliLxMVpZ+wdvCQWdFZogamwEDn3jWSUOt9wfC5oYkdV0ORk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E6EH7phG; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGLtXyY6Mbc7UyKfiaL6WHAeGRqfn1pi3hqi0Ldc+JPymcR9nFEnTaJRh3Bt21yurhDUbyxqDk/afqn8zfncX03VTujLrH1LR+YYoqKqGQwzALqRwaIy3LBaFCIdXsHicFAt/JkcsS0UIpmaOF4N1+7g8YQQ0kjoHRIrkGfWnVlIGU7eiIlPaItWOVkGfadbWFViJvekQvcSv/8z4BkLlLTYAzk08vwf9S4w3VeLEqYx8q5wulxdymJkg6Boy7TQDLz3sA5KUVXoyy2/wkwY/dix59naXBxD76DUBZpI+XSfSVxGBWeHXX0FD282YpEoHiM7p+juDop2oV+j0xXgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuXLzdXDJ1mWabC/UatO08rYrHglUsmBMuqVWrxodIE=;
 b=JLYfot92LvIbadaF9IikHvxEscprK/6D0l7qY2619aP6Zw5Mnzv5E1KWiNV8tetJBwTxgAn4s8MROzPM6Z/cS8xkR8sSo4/jUmHD/PPlnGUrbhr1xeZ8SdZHuMCLzdxsxqEXxVbU70wHXWVGBZvUBh0YVqG34vRFRGws0AURLzJX8BSs1j0cBw8nCJIS9gc/+z1Qdp6zV95HCUdz5sjBWojnpIwrUJrbqPGa2uXMufceJK572XTne4tfs6Tl1aAddeET3dP8tQm8E4tbx77lWbrPnWyKIHBKG2kkLyeNYwUvDBjN8tBkweqa3Vn1oMXWwlStL4kP0eAVi9WSqUuXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuXLzdXDJ1mWabC/UatO08rYrHglUsmBMuqVWrxodIE=;
 b=E6EH7phG0VGWrqBxn71LCjGhAVwVRnCj4NGtt0ndtdTNeWINkQOpZfjA07uJmZfVdY4i0xTjnkdMFhvAgospcVOH1YM6l4CatfBUue76dBOP6qvLNIBfiOYh/RJHuLjy2WgGBRtQ4jSc/YABFzQAAWqPk5pSDx3XgB0EySZ041IGkH5RQ8+1cheXU0k6YFHYnkPTj/ir8lXW0M7RrrZZ0gJx99Zv/5U1pJMaYcrsQGn8xT1zEtUJqtUvV/Ahu57Qq0qx1IljKRvb2lYSHhyKAYWtBw0MqrJmTLQ4ZVFO3+EpMdBs3+8YSElZrZMVAgXon6bGRjt6XEe0BWf9QU2pkQ==
Received: from CH0PR03CA0119.namprd03.prod.outlook.com (2603:10b6:610:cd::34)
 by MW6PR12MB8707.namprd12.prod.outlook.com (2603:10b6:303:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 08:33:03 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::48) by CH0PR03CA0119.outlook.office365.com
 (2603:10b6:610:cd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 08:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 08:33:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:48 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:45 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 7/8] selftests: traceroute: Test traceroute with different source IPs
Date: Mon, 1 Sep 2025 11:30:26 +0300
Message-ID: <20250901083027.183468-8-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901083027.183468-1-idosch@nvidia.com>
References: <20250901083027.183468-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|MW6PR12MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9c2850-102f-4148-4f76-08dde9322a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xuACdEGRVLgOm+aXGRACqVyRdDJm03pqT77JQBw5aGujD7RjuvZXtKbeVbyT?=
 =?us-ascii?Q?xonvS31iJTAF37hEQRO3fg0FPWDriW2KorGdC5aEmkvXKkq6YTMfzm+95LbN?=
 =?us-ascii?Q?VDzrEg5rt0eqEh0oUEzKxpIwygQ/93o4D2jEUdJTyDK3KHWzRlTuw4PuNKRr?=
 =?us-ascii?Q?+ithKSPAhd+N+LVzIZmK47S0gBhzekcQ5O04SShVayGRnq+LLzxkd/IhdtTA?=
 =?us-ascii?Q?FeLWeuLqdIUZRVOdc8zTA5zTM/Vn+lU5rbqJB81+zgRzP0hHH+4rwGZTkzDa?=
 =?us-ascii?Q?IQNphmqgmIT25MSh9nHgOLrJJiA0d15qJs+Ab5fURt1RZG59jz8aOtsLhMC8?=
 =?us-ascii?Q?xUnKIK+EeQ4jkoG/7VimlCOW4qBh8nQset+VDq7h+DrsU1i6mli/sqGr5bsG?=
 =?us-ascii?Q?oN5D8QIt59+0ZVIWrWmFlTIv9hxhk9FYV8ANTxQXuDBRuDybgpFSAHc1XL+S?=
 =?us-ascii?Q?wo8XytaBy2y3TeoLqM7gRM0m8aUAO/iR+2T4a8FJlS5ZS5N/oie9fOGZY+y5?=
 =?us-ascii?Q?WwR+DkdmJKiK0d9igldENabc/LG4dvKS0LIzooQz7YkB/VRiWxnBfAT+5sRl?=
 =?us-ascii?Q?HfCrhAzGUpvI1oPr9IpWir6YWI+9mMeWMNc/LGdDFKRRg178rzn4W+SolVWo?=
 =?us-ascii?Q?2uBehuupp44Tocv/k2ivadAVlU6w62OsobM5Xa+f0IymbBovhj0aRzDFLOQx?=
 =?us-ascii?Q?CiM4UAq73I+uXKAt2k7vykGpHc6bFaZDI2YMgclMvJTJREzt5LULUe3l7rlT?=
 =?us-ascii?Q?0tsaa6igL4TdmDxFFrnIrGYiqeX46S25leVHOQR57WeQ5fOfYbglOT3srVA3?=
 =?us-ascii?Q?yuwxA8CCepT1uaK27Vtb/HzEWZWN3/TAZUMsb/Xp500r+pTEWsxg7ENoybeE?=
 =?us-ascii?Q?ezltIkvvvQUrDyFTopsH5rpfU/5wPpP0O+9H6vMGSInxgBL0SvFCFkXESlky?=
 =?us-ascii?Q?tjJq5RpPhq66fGOvzhjPwA0DnXCCFmomOSzKbsIW9bmtkhW51AwpGCreu2L2?=
 =?us-ascii?Q?WdYJGQDxDnz5vQz8SI27HmEFgcx9pRly5800EbtwKji4bcpCi/rTYzA1mWCY?=
 =?us-ascii?Q?uLvEGBA+vdqE67qFj38zJE1wyqIJD75akG2eK6r6tdmZ+3xLlpLb0idSagrU?=
 =?us-ascii?Q?xzWnnsPP2s7kGEKuGjsZdit7kf6NZWKGrnEBAMm1aPFzhAvc174TdoVyLtIu?=
 =?us-ascii?Q?jBxG4LR2mA/kG5ppq3Bhc5wwi8tqJrRl7yiesgFwSg8FFQfKnhwK+ihOOs1a?=
 =?us-ascii?Q?dg1CtmQnAjNmjfj/H244WBRX3lvKxJx6rKDuzwZIWRrbv5C4bQftv4B76rIe?=
 =?us-ascii?Q?sds3G0tEVtZbmsI9ZCz4lR4V1+brHHGJMbFi9ki4LZXZK0j5edtcFyLaEvsd?=
 =?us-ascii?Q?N2T3nGmdpM6BGTUonuBP1aADlUDTqvT5D9FD1/+0c+wmPVJoRPHBARJEE0k3?=
 =?us-ascii?Q?FlY0skkxtVmX491EhpeOJIN4fBhPjcS+BirjnuPea+4uCDIwz6eGzAixD8bl?=
 =?us-ascii?Q?vNfvBxO7+vVtW1bIu+24++nqbDDHUerfQlGB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:33:02.6216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9c2850-102f-4148-4f76-08dde9322a8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8707

When generating ICMP error messages, the kernel will prefer a source IP
that is on the same subnet as the destination IP (see
inet_select_addr()). Test this behavior by invoking traceroute with
different source IPs and checking that the ICMP error message is
generated with a source IP in the same subnet.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/traceroute.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
index 8dc4e5d03e43..0ab9eccf1499 100755
--- a/tools/testing/selftests/net/traceroute.sh
+++ b/tools/testing/selftests/net/traceroute.sh
@@ -196,9 +196,10 @@ run_traceroute6()
 ################################################################################
 # traceroute test
 #
-# Verify that traceroute from H1 to H2 shows 1.0.1.1 in this scenario
+# Verify that traceroute from H1 to H2 shows 1.0.3.1 and 1.0.1.1 when
+# traceroute uses 1.0.3.3 and 1.0.1.3 as the source IP, respectively.
 #
-#                    1.0.3.1/24
+#      1.0.3.3/24    1.0.3.1/24
 # ---- 1.0.1.3/24    1.0.1.1/24 ---- 1.0.2.1/24    1.0.2.4/24 ----
 # |H1|--------------------------|R1|--------------------------|H2|
 # ----            N1            ----            N2            ----
@@ -226,6 +227,7 @@ setup_traceroute()
 
 	connect_ns $h1 eth0 1.0.1.3/24 - \
 	           $router eth1 1.0.3.1/24 -
+	ip -n "$h1" addr add 1.0.3.3/24 dev eth0
 	ip netns exec $h1 ip route add default via 1.0.1.1
 
 	ip netns exec $router ip addr add 1.0.1.1/24 dev eth1
@@ -248,9 +250,12 @@ run_traceroute()
 
 	RET=0
 
-	# traceroute host-2 from host-1 (expects 1.0.1.1). Takes a while.
-	run_cmd $h1 "traceroute 1.0.2.4 | grep -q 1.0.1.1"
+	# traceroute host-2 from host-1. Expect a source IP that is on the same
+	# subnet as destination IP of the ICMP error message.
+	run_cmd "$h1" "traceroute -s 1.0.1.3 1.0.2.4 | grep -q 1.0.1.1"
 	check_err $? "traceroute did not return 1.0.1.1"
+	run_cmd "$h1" "traceroute -s 1.0.3.3 1.0.2.4 | grep -q 1.0.3.1"
+	check_err $? "traceroute did not return 1.0.3.1"
 	log_test "IPv4 traceroute"
 
 	cleanup_traceroute
-- 
2.51.0


