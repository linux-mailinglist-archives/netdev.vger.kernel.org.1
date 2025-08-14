Return-Path: <netdev+bounces-213702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E25B266AA
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79FE1692F1
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC932301471;
	Thu, 14 Aug 2025 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WEiuwHRn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F323002BF
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176913; cv=fail; b=phO5qx/ikKxiQBepTP6ayqwALina+SaZEVOGZ5hnS4rDi1DA6vmnxQtG+eqnTeJqExW3N5h8b6ipWiC/1AFotbpyUtLc4Go6FlOfBo7txgPihGXTZiEnNwLlo4Ihl0nv+ErOmH5O4ybw82JAs7L+NkaVhtoH6FiKi2m2TkqOvZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176913; c=relaxed/simple;
	bh=5J/OtmE9lJQN+30MFeQ3G8kFIsqqJ4NBgUmeXa1EJ/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apVCBs+n9rW5HICWeTQZ9SAYLET1WzF0/W0kGXl5g4kNMyCWiNVDN1PECiuaYyRk3AEz6WSgfIAONnW1SozcnHpUfOpPC0A/TOjQm1fXBPGHjtBq3rD2slKmKWvU4V0P9dB0eN6iqnRGwpG5xKSCgWf5kgvaGAYMmvyUXi+63rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WEiuwHRn; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bd2ctz8K5J1q4rzemszbQi2W5laGg6EMA2b1brjOz3DxQDmPU1m/BhvXESurgwF+e5c0PWriBrFreHzgjBtu23JMuQ0jyEn3W3LspB2XLkL7UfGOEBLYygS3fa2IWAMuAG0BCAu/BluRY3L3GA1FsY8AUSNMvioBgc5fm/RECkqHaTVYVI13KkspOgRu0aLMW8uRqJXTW6yR2PBQABrKAoKfyZQlgT4Bn5E/I12GxAFQHgPo2ppWBcpNRbJL64qou/0MQpKZanM9yPF3Cza30HwrU/LvpWjDB64sAOslzkT00/3D8w8J9V97S/iAEcpfyXlpcfS9YH3IEuh0uUk4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrTb4vTcWyEmiTTl7x6sQqYVnqbOkn1Lnfi/6zmT5bM=;
 b=i83EtBPTUQEWPXrfiAMA5uE75RXDM/2SHuxtbHgjuheqO5ySGM1kfC545wKbWz1yNFB2a7A5mOaxCSpUEBb8UdsJWLcOiXE0HB1JCQyAiixr7gcoBOynUPg09OF0BpfD5+xOU7C09D13CyDsAdse3oeyHQ/fk7C7wiQIv+lf+Z4eIeLULr+gNWfiOBsVztjouBZRg9X8IIi9wEt/fJyldidqFMsKJdfxuop6y5NtL86znUNFxFtdRdTBa0FCXCBtIlI3wfO5newKSVew117MM7P027C5dbexvgNhXdKU3JQOAAzInQDMHM9V13Bp/Pr+O632T6eEoSNZeuwxuRZtxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrTb4vTcWyEmiTTl7x6sQqYVnqbOkn1Lnfi/6zmT5bM=;
 b=WEiuwHRnkvCkVzTwUIXN/HVnzRal0NtKBW1LmnxMWN6WzBLhO1u64419iplrh53fX0lPI4PVhG9RFC0+cvpjTrXkCK9cKcsDI49dBXqf2frrpjXe2mEXEm+Izc7CT5FwDDQDNFHcCZF+MuvTCOX82EUHr5eJR42i9m1uVTkeW1jWdrEmBj5poebnZsfP+VEYmysYIDanR7vhg5UoX04VbOZ8mRVccOquO+2ZDgWDjmUHG/hMyrhewTGZaczuvOKb7JZa6F0Rs7AYwxV8MoUwRNCwmDeeiq7H3wN1YvgzjDV3NIHVszPmOdrBg2hYOBxpwnjtJDUS23Wfwxxes/G7Fw==
Received: from SN7P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::28)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 14 Aug
 2025 13:08:26 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::e7) by SN7P220CA0023.outlook.office365.com
 (2603:10b6:806:123::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 13:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 13:08:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 06:08:15 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 06:08:10 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	<mlxsw@nvidia.com>
Subject: [PATCH net v2 2/2] selftest: forwarding: router: Add a test case for IPv4 link-local source IP
Date: Thu, 14 Aug 2025 15:06:41 +0200
Message-ID: <3c2e0b17d99530f57bef5ddff9af284fa0c9b667.1755174341.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755174341.git.petrm@nvidia.com>
References: <cover.1755174341.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: aea4cc9a-2ef6-4172-f709-08dddb33a78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SUGRLtLflKnAy5O0DllkSrY29gm6tBu44bJiD/fSrJ3ieryoIcmNOxZFgTmr?=
 =?us-ascii?Q?+HMYafiHih+kBrQaAIgpphNN3tIbCV9sFJE6hFOnuZcnwUEsiPgi1B3mVUQt?=
 =?us-ascii?Q?2n4Nvn7S9Rq1D0kFPjOkwekuxEhPhIbmxB4u+cV4DDdJVuCqivZ3nV6Bt2YX?=
 =?us-ascii?Q?HTYRxc4Y3xdJ3OsFvOyUFXuHfblfpJxcHMnw+z93xaOgXpw12Mt9mCnkyiwU?=
 =?us-ascii?Q?ocxALjKYadvlnkz1C8ZKAkGuKiyKJ+C18Czn5cyC5TKjqgn7+yoJREpYvBl8?=
 =?us-ascii?Q?NLB74GVchYzlT1/jhfu1+ZamqtpBFv/7whzZrZE5esRdieT5gKonXdxs3aKe?=
 =?us-ascii?Q?OnV1VPAcb223RBgoXE2LKkxWmAt+fpXWvLkfXQNzGXIL7K4MiCyR/+6FLVhU?=
 =?us-ascii?Q?HLl631BGvhpfafDJtGCx6mqvSbP6gybIKRYlTGTcwLiMtEy5+/fGaZBqAX0n?=
 =?us-ascii?Q?dN5CpI9dWBld4ubjMXhes4qOPjgo1OHSCu1AA6J6yPzNi3sJSBv1HUvzAONB?=
 =?us-ascii?Q?O2qdVdX8FkwaEO03OGOCwp1WnJf7QW7U+0h5Z007433qvXi2sV/Yqy5SwwX0?=
 =?us-ascii?Q?Ac3AwTqqf/2ShQrLdPmY1wKLzfxLMzW4+0ktsVpdX4x3zx0rvKXlLm1lllc3?=
 =?us-ascii?Q?rdvcgt2+P3+vvSAFAQlSRs+yaYCnO74KSGLbIP3TUBXIWoqVPXVC5TJ995+K?=
 =?us-ascii?Q?6US6b2USu39D8IT2KJL6X9B8y0N91FzFBS6BuKuaGRbUMM5jAkeWvcM/7Tyz?=
 =?us-ascii?Q?aV1IYxdIcTsJrzniZHRa4XMb7xr+5ryPCCrcBvk4+aN3ocryVBzvSGEFR+a6?=
 =?us-ascii?Q?YjpbVMqOwFd2v7BNLgceseN2SUWAVkFqwyqeRFVbpcH4GkYWUq7d0wNpb6/N?=
 =?us-ascii?Q?f9P53KaNE/hnCMY7ojruP6cZ0endxwKWTJA1nRmM79YsDU5oax7uTSSHMyHk?=
 =?us-ascii?Q?6LL3ZHZe+psRevBRJFEde/PqYn4JtqbCwuY6gZCpIA0abAuLJXSZglTQuCup?=
 =?us-ascii?Q?WsubUYGa7o8YnGjaV1Ij/kRXvb1YdWDdkqXQHsMUvrb+oqFDrJNB6qTr/DPq?=
 =?us-ascii?Q?unBUGYxe7ZH91+Ls1eb6rDVO73ULhURv5b81P+hWuLkrRMWdMRXxFZhMzzp9?=
 =?us-ascii?Q?AYZXHARwfNUs6XGXIE229ZWXOtiDH8Nu64IQ4lt3WiSbhkiyqzr6drxI6ZB7?=
 =?us-ascii?Q?Y0aVTO00DkDUUdCzB7wt7eW9AwUxAcVlVfakr9xk0dnLJIlMFHjxj1e/6jjk?=
 =?us-ascii?Q?lKYgedpxnhMh6iCXPMO4quZPnC1fjtI+OTpZQibD0p7tAclieRMYjQYsHgTI?=
 =?us-ascii?Q?nk4q0OEyp+6yjzVtn2KWBVLWiYIgg/JpO33UnWE1lzQOaiF9Sr8vi5yeD9p3?=
 =?us-ascii?Q?IcBUZXcoadV27Z1ADfIH2sRoeOHUR9hGcw1aVx9yislMubKqKta2v01cYRla?=
 =?us-ascii?Q?5UvbGEOEISfq68ihgcTpObCJDr1j09oWFUL8PO3aqBdeQADPywFRMeBuOpqx?=
 =?us-ascii?Q?WqG/yP9DoGTmREpzcmhjqaIt+j6nptPHv/mV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:08:25.6139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea4cc9a-2ef6-4172-f709-08dddb33a78d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869

From: Ido Schimmel <idosch@nvidia.com>

Add a test case which checks that packets with an IPv4 link-local source
IP are forwarded and not dropped.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/net/forwarding/router.sh        | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/router.sh b/tools/testing/selftests/net/forwarding/router.sh
index b98ea9449b8b..dfb6646cb97b 100755
--- a/tools/testing/selftests/net/forwarding/router.sh
+++ b/tools/testing/selftests/net/forwarding/router.sh
@@ -18,6 +18,8 @@
 # | 2001:db8:1::1/64                             2001:db8:2::1/64   |
 # |                                                                 |
 # +-----------------------------------------------------------------+
+#
+#shellcheck disable=SC2034 # SC doesn't see our uses of global variables
 
 ALL_TESTS="
 	ping_ipv4
@@ -27,6 +29,7 @@ ALL_TESTS="
 	ipv4_sip_equal_dip
 	ipv6_sip_equal_dip
 	ipv4_dip_link_local
+	ipv4_sip_link_local
 "
 
 NUM_NETIFS=4
@@ -330,6 +333,32 @@ ipv4_dip_link_local()
 	tc filter del dev $rp2 egress protocol ip pref 1 handle 101 flower
 }
 
+ipv4_sip_link_local()
+{
+	local sip=169.254.1.1
+
+	RET=0
+
+	# Disable rpfilter to prevent packets to be dropped because of it.
+	sysctl_set net.ipv4.conf.all.rp_filter 0
+	sysctl_set net.ipv4.conf."$rp1".rp_filter 0
+
+	tc filter add dev "$rp2" egress protocol ip pref 1 handle 101 \
+		flower src_ip "$sip" action pass
+
+	$MZ "$h1" -t udp "sp=54321,dp=12345" -c 5 -d 1msec -b "$rp1mac" \
+		-A "$sip" -B 198.51.100.2 -q
+
+	tc_check_packets "dev $rp2 egress" 101 5
+	check_err $? "Packets were dropped"
+
+	log_test "IPv4 source IP is link-local"
+
+	tc filter del dev "$rp2" egress protocol ip pref 1 handle 101 flower
+	sysctl_restore net.ipv4.conf."$rp1".rp_filter
+	sysctl_restore net.ipv4.conf.all.rp_filter
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.49.0


