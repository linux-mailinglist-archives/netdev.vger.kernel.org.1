Return-Path: <netdev+bounces-231550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEC6BFA5FC
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 867FE505D21
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 06:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069A2F28F2;
	Wed, 22 Oct 2025 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NyEmZARs"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC572F2613
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116172; cv=fail; b=Y0wOh/UpoKUNMsDkHQMwDXxKdCrLhR7wOYWP+Jx5F6pgFULWaZVDRNAI0N5YEBg5hjWESd5W1jvVfjAJKavp58aylIuZrC0XvuI33gf9OEOUhWrxCjmVIuyLjF+25feGeQGYS09mwi9KzUTyRhulZQa8vBSlLya9KBYzWCY6glg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116172; c=relaxed/simple;
	bh=HW2RByHvSVIkDK3WNriJ48IkqJ5KavN7yW2wBlhbCBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFpqB6u+3XUqnfdnQE4hxaAmEIZzQi32eM7/DjEN34qBV6yB7VkdV1aT6a+XLU1oPgNsn63rbo252VJQWs+Qp2YM1OTHdZVc8iUEBtVmwmM4guq05gwE7rJy43C5tBVr95cnWwixlTXTrXfr3FgMeDFrAzxLHzViwvlPA3r9Eag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NyEmZARs; arc=fail smtp.client-ip=40.93.194.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6oo/mH1xNYbF/vzkA2jnucCDoQpSy1mVOBN+cdEfbdATysfngzlwFVEQUKX2whayiH23Az/CbNaTSCXpb5hOJCwxDHRJvBVRlUrZRQX+MnPPcDJJIKRVfQeq4GBE2Yn7pCM825Bx/rKyWEIVxDbvXNHBrhM4fD4NLuHZhxXnyLWHh4sdsb2zgcNdGqXgg0PVcv2FH0Ea8aQFwASSIuXUTI/Py8BkHzJ+W3Zk8awedvZvhUWq43mZEMnjViiAbIBp8Ph85Gyl1JrlZXnnin/jf3Qvmoc3vSgItLqthjtAdBw/vlaPmlUvQ6m8ZnL6S8SObhREu5GlP0KUE5HDj8VDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MRuYUTTsUYGGvklDACeFEHkkdQ4b/sjei00768fHzc=;
 b=WDtkExwkX+gu/oAu9CdatqPUdKK+L1tcst0mbbS3fhZISPuq9zvwT+5UARjAeqOO9PaFOX+uxFLiuBkYx7iqWC0p9BY12l+8AKgAZAi9ifW+VwYyZVpLhMLFPuYe0CO2SIvX0DQfzb+0g5d6cN+GtE/+Q2jjKvbEsE2L10j5Xzjc3RuxdA4OYHQt1Le1AG7DMp2uIvwUa7LcldYZcuJ/9+d1j1E7N82UXVaC2Jd/aizohLyFL+q0FeRSviAAuNj63VlBUicfUQf9VU2BuLfTgE+W4t873QvjgjReB7l1w0Nfo+dq5aJ3jS0XpTfm0rf0439McBPl0PdfHKf3E4F5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MRuYUTTsUYGGvklDACeFEHkkdQ4b/sjei00768fHzc=;
 b=NyEmZARs1MLHb6fRNxs5MZvm39FBxXUhuTlwdaYD4PzxJDx/Z5ciU7d2uVxc4BlPBUJMvTEiYGe4uKKeRlZIMQ3rQhRoQcEkMwkWfA81Xy8IpxpCERgOze+492ZX1zq8Hz0V/2LL56bwI4ShtngeHcLHCyRM8lSVhgNgsuK5f1QJxukscs2DClwZ0fmQk9XgBIdaDltE53kA7GhgsWFxpcdCvJD2yqsbb94nrnxPG1RLb8r7BoDQyAfHYniNvaAvdLLya5bJcmicuLSqlwcadYz8iM3HrcApgFsEvNtzlXm4of/DX2Fx7244A5BElV7RX2ITb+EsGnKkJRBX7DGwNA==
Received: from MN0PR02CA0012.namprd02.prod.outlook.com (2603:10b6:208:530::9)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:56:02 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::69) by MN0PR02CA0012.outlook.office365.com
 (2603:10b6:208:530::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 06:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 06:56:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 21 Oct
 2025 23:55:43 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Oct
 2025 23:55:39 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <dsahern@kernel.org>,
	<petrm@nvidia.com>, <willemb@google.com>, <daniel@iogearbox.net>,
	<fw@strlen.de>, <ishaangandhi@gmail.com>, <rbonica@juniper.net>,
	<tom@herbertland.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/3] selftests: traceroute: Add ICMP extensions tests
Date: Wed, 22 Oct 2025 09:53:49 +0300
Message-ID: <20251022065349.434123-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022065349.434123-1-idosch@nvidia.com>
References: <20251022065349.434123-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a26087-b9d6-4885-02ca-08de11381029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7UkwBcfDjlO3gny6sX05zgKioIHguIf4smxxxQZVkHyuPK5z4ira0Ime2NxC?=
 =?us-ascii?Q?ca1ULFF04sUxnKHOqhi4YizQ+gHy4wKoVB1St+YWcacvDQJDDfg5hzk0SDMq?=
 =?us-ascii?Q?KeErSud3JOuF8i+kAMFA/7gF5pkN5l5BkmImmFtoRe6Ww53PVDfEbunJJXsU?=
 =?us-ascii?Q?G6qGwhZX+r97rbFYMLLX2InGn3xQhVZXDKxQRyDbNVOsUPD6QWC+VMvGdg9/?=
 =?us-ascii?Q?iiOiwNj92DFwzuLsHDyhinqzSlPVxAjLd/WoVd9UmmFN1O1XNTZdN9IaPiAY?=
 =?us-ascii?Q?lB9wA6w8rRt45/3OcD4V98nmSZV4bDBtj/NhQ9iP08+s/T0xbWhZC+DnkZul?=
 =?us-ascii?Q?7A3KWej/v+/+vm73xKoEd290ZOVAL6UQkWl0q7RAEep9BdLcKSHi8W1FmbKp?=
 =?us-ascii?Q?xNgsUK5SSWEo15HTHQAGHHCK56zeCFK2VcUl7ft36dLwkbT3Jd2VwX7g5hBh?=
 =?us-ascii?Q?ZQRI2WIrakUOpRYVzcklaI7KpFKKi0gmHUSM8dR/yUhoM0//G8P29kf2ICBP?=
 =?us-ascii?Q?fRzgNMRZtGy/TO8ZgVe65fEBsQt9goVewZFbXrsXfSWWqPijTjDK1ZI497OE?=
 =?us-ascii?Q?vKFgezwjk0K3yr8lxHjBZb990tZIHsGG7kUPccMmXfv8hDbT4YY5umqJkqp3?=
 =?us-ascii?Q?KUm85cleQdc96Glq6gg7dFxRqvvVBtzTWf+h/affQiRL0e9PXOq2Lb7oZZ5s?=
 =?us-ascii?Q?31iQa1U2C7OxMG8Mu7tZ4Ej+nCNUPfxjAVb0r1jqaUGtsUSyDQJ49VO2osAJ?=
 =?us-ascii?Q?W7bhfgtvzIYdPscjpqWUc5jkujY9NRAG+sRiXl1XgCSOhF39C5fi0PXnmXux?=
 =?us-ascii?Q?Lpys6Jp2j8S/s21cAYFkZ5pjAvUGkhXyA6MkCGd2d0h5eRZlxyYFie8YE7qf?=
 =?us-ascii?Q?SQhSlvsWrK790oKKQSDWzoCc0vwUjs7Q7XIWygtVFvIEcrH0qdkbey6tbxNl?=
 =?us-ascii?Q?PW6IxNuI8BH52EEq5poP7XnhOBRoyjIVhLGdtqS5C4efvn2uLyHUG4FNbD4c?=
 =?us-ascii?Q?/xOpKVp78KBoVlkocYobmZ4F+o6m8Gg7oqs8hRU4kQ9VRW32VE+qZRSTO3Ww?=
 =?us-ascii?Q?2p3SPswCLhfS5RheUskpJPlCGvcNoNW2fAbgeUFAGXYf0V2EnwFniEJ4V4IY?=
 =?us-ascii?Q?SviqdTK9HheMEQU2cAW1Q9MFZoEFlm/wdiDNUJba8T/3CAY8XidNvNNMMKCT?=
 =?us-ascii?Q?yyGOsa4E8+QfXL5jd2CMrmVwGNA1vBkHDYZMnntTWzGUF1JlkJljJ9qHIq1M?=
 =?us-ascii?Q?dAHrm/sO46Bo5L2HRTL3u9tQkdoJQjj3edQvyg8/05XtaVoJnTSYqT7yK7aJ?=
 =?us-ascii?Q?khraXovcZ8ptC9w3nujjL7wQDrX3xBLXKYole1EzRlOR/HrdNZ4vpdqxhair?=
 =?us-ascii?Q?U9yxpYOHIPYotuItudrffFCrbvBDiR6ANZAi1yFvPt4fvEXf9Pwn4dmvbcOq?=
 =?us-ascii?Q?QeJ/fGhfCthq7tgEMMNjIxSsa9C7Fs0qH5TMS+zdH3uQLsD6gbi/cU4foicK?=
 =?us-ascii?Q?o2ztk3S5kH1ypa3Ca06q2lNx3FJqRvAAoJvjlD0a1r1LLrwduBofuuri3FPV?=
 =?us-ascii?Q?Z00ToWexDoWlxZjVAmY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 06:56:01.8205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a26087-b9d6-4885-02ca-08de11381029
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522

Test that ICMP extensions are reported correctly when enabled and not
reported when disabled. Test both IPv4 and IPv6 and using different
packet sizes, to make sure trimming / padding works correctly.

Disable ICMP rate limiting (defaults to 1 per-second per-target) so that
the kernel will always generate ICMP errors when needed.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/traceroute.sh | 280 ++++++++++++++++++++++
 1 file changed, 280 insertions(+)

diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
index dbb34c7e09ce..a57c61bd0b25 100755
--- a/tools/testing/selftests/net/traceroute.sh
+++ b/tools/testing/selftests/net/traceroute.sh
@@ -59,6 +59,8 @@ create_ns()
 	ip netns exec ${ns} ip -6 ro add unreachable default metric 8192
 
 	ip netns exec ${ns} sysctl -qw net.ipv4.ip_forward=1
+	ip netns exec ${ns} sysctl -qw net.ipv4.icmp_ratelimit=0
+	ip netns exec ${ns} sysctl -qw net.ipv6.icmp.ratelimit=0
 	ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1
 	ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.forwarding=1
 	ip netns exec ${ns} sysctl -qw net.ipv6.conf.default.forwarding=1
@@ -297,6 +299,142 @@ run_traceroute6_vrf()
 	cleanup_traceroute6_vrf
 }
 
+################################################################################
+# traceroute6 with ICMP extensions test
+#
+# Verify that in this scenario
+#
+# ----                          ----                          ----
+# |H1|--------------------------|R1|--------------------------|H2|
+# ----            N1            ----            N2            ----
+#
+# ICMP extensions are correctly reported. The loopback interfaces on all the
+# nodes are assigned global addresses and the interfaces connecting the nodes
+# are assigned IPv6 link-local addresses.
+
+cleanup_traceroute6_ext()
+{
+	cleanup_all_ns
+}
+
+setup_traceroute6_ext()
+{
+	# Start clean
+	cleanup_traceroute6_ext
+
+	setup_ns h1 r1 h2
+	create_ns "$h1"
+	create_ns "$r1"
+	create_ns "$h2"
+
+	# Setup N1
+	connect_ns "$h1" eth1 - fe80::1/64 "$r1" eth1 - fe80::2/64
+	# Setup N2
+	connect_ns "$r1" eth2 - fe80::3/64 "$h2" eth2 - fe80::4/64
+
+	# Setup H1
+	ip -n "$h1" address add 2001:db8:1::1/128 dev lo
+	ip -n "$h1" route add ::/0 nexthop via fe80::2 dev eth1
+
+	# Setup R1
+	ip -n "$r1" address add 2001:db8:1::2/128 dev lo
+	ip -n "$r1" route add 2001:db8:1::1/128 nexthop via fe80::1 dev eth1
+	ip -n "$r1" route add 2001:db8:1::3/128 nexthop via fe80::4 dev eth2
+
+	# Setup H2
+	ip -n "$h2" address add 2001:db8:1::3/128 dev lo
+	ip -n "$h2" route add ::/0 nexthop via fe80::3 dev eth2
+
+	# Prime the network
+	ip netns exec "$h1" ping6 -c5 2001:db8:1::3 >/dev/null 2>&1
+}
+
+traceroute6_ext_iio_iif_test()
+{
+	local r1_ifindex h2_ifindex
+	local pkt_len=$1; shift
+
+	# Test that incoming interface info is not appended by default.
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep INC"
+	check_fail $? "Incoming interface info appended by default when should not"
+
+	# Test that the extension is appended when enabled.
+	run_cmd "$r1" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x01"
+	check_err $? "Failed to enable incoming interface info extension on R1"
+
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep INC"
+	check_err $? "Incoming interface info not appended after enable"
+
+	# Test that the extension is not appended when disabled.
+	run_cmd "$r1" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x00"
+	check_err $? "Failed to disable incoming interface info extension on R1"
+
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep INC"
+	check_fail $? "Incoming interface info appended after disable"
+
+	# Test that the extension is sent correctly from both R1 and H2.
+	run_cmd "$r1" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x01"
+	r1_ifindex=$(ip -n "$r1" -j link show dev eth1 | jq '.[]["ifindex"]')
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep '<INC:$r1_ifindex,\"eth1\",mtu=1500>'"
+	check_err $? "Wrong incoming interface info reported from R1"
+
+	run_cmd "$h2" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x01"
+	h2_ifindex=$(ip -n "$h2" -j link show dev eth2 | jq '.[]["ifindex"]')
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep '<INC:$h2_ifindex,\"eth2\",mtu=1500>'"
+	check_err $? "Wrong incoming interface info reported from H2"
+
+	# Add a global address on the incoming interface of R1 and check that
+	# it is reported.
+	run_cmd "$r1" "ip address add 2001:db8:100::1/64 dev eth1 nodad"
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep '<INC:$r1_ifindex,2001:db8:100::1,\"eth1\",mtu=1500>'"
+	check_err $? "Wrong incoming interface info reported from R1 after address addition"
+	run_cmd "$r1" "ip address del 2001:db8:100::1/64 dev eth1"
+
+	# Change name and MTU and make sure the result is still correct.
+	run_cmd "$r1" "ip link set dev eth1 name eth1tag mtu 1501"
+	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep '<INC:$r1_ifindex,\"eth1tag\",mtu=1501>'"
+	check_err $? "Wrong incoming interface info reported from R1 after name and MTU change"
+	run_cmd "$r1" "ip link set dev eth1tag name eth1 mtu 1500"
+
+	run_cmd "$r1" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x00"
+	run_cmd "$h2" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x00"
+}
+
+run_traceroute6_ext()
+{
+	if ! traceroute6 --help 2>&1 | grep -q "\--extensions"; then
+		log_test_skip "traceroute6 too old, missing ICMP extensions support"
+		return
+	fi
+
+	setup_traceroute6_ext
+
+	RET=0
+
+	## General ICMP extensions tests
+
+	# Test that ICMP extensions are disabled by default.
+	run_cmd "$h1" "sysctl net.ipv6.icmp.errors_extension_mask | grep \"= 0$\""
+	check_err $? "ICMP extensions are not disabled by default"
+
+	# Test that unsupported values are rejected.
+	run_cmd "$h1" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x80"
+	check_fail $? "Unsupported sysctl value was not rejected"
+
+	## Extension-specific tests
+
+	# Incoming interface info test. Test with various packet sizes,
+	# including the default one.
+	traceroute6_ext_iio_iif_test
+	traceroute6_ext_iio_iif_test 127
+	traceroute6_ext_iio_iif_test 128
+	traceroute6_ext_iio_iif_test 129
+
+	log_test "IPv6 traceroute with ICMP extensions"
+
+	cleanup_traceroute6_ext
+}
+
 ################################################################################
 # traceroute test
 #
@@ -437,6 +575,145 @@ run_traceroute_vrf()
 	cleanup_traceroute_vrf
 }
 
+################################################################################
+# traceroute with ICMP extensions test
+#
+# Verify that in this scenario
+#
+# ----                          ----                          ----
+# |H1|--------------------------|R1|--------------------------|H2|
+# ----            N1            ----            N2            ----
+#
+# ICMP extensions are correctly reported. The loopback interfaces on all the
+# nodes are assigned global addresses and the interfaces connecting the nodes
+# are assigned IPv6 link-local addresses.
+
+cleanup_traceroute_ext()
+{
+	cleanup_all_ns
+}
+
+setup_traceroute_ext()
+{
+	# Start clean
+	cleanup_traceroute_ext
+
+	setup_ns h1 r1 h2
+	create_ns "$h1"
+	create_ns "$r1"
+	create_ns "$h2"
+
+	# Setup N1
+	connect_ns "$h1" eth1 - fe80::1/64 "$r1" eth1 - fe80::2/64
+	# Setup N2
+	connect_ns "$r1" eth2 - fe80::3/64 "$h2" eth2 - fe80::4/64
+
+	# Setup H1
+	ip -n "$h1" address add 192.0.2.1/32 dev lo
+	ip -n "$h1" route add 0.0.0.0/0 nexthop via inet6 fe80::2 dev eth1
+
+	# Setup R1
+	ip -n "$r1" address add 192.0.2.2/32 dev lo
+	ip -n "$r1" route add 192.0.2.1/32 nexthop via inet6 fe80::1 dev eth1
+	ip -n "$r1" route add 192.0.2.3/32 nexthop via inet6 fe80::4 dev eth2
+
+	# Setup H2
+	ip -n "$h2" address add 192.0.2.3/32 dev lo
+	ip -n "$h2" route add 0.0.0.0/0 nexthop via inet6 fe80::3 dev eth2
+
+	# Prime the network
+	ip netns exec "$h1" ping -c5 192.0.2.3 >/dev/null 2>&1
+}
+
+traceroute_ext_iio_iif_test()
+{
+	local r1_ifindex h2_ifindex
+	local pkt_len=$1; shift
+
+	# Test that incoming interface info is not appended by default.
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep INC"
+	check_fail $? "Incoming interface info appended by default when should not"
+
+	# Test that the extension is appended when enabled.
+	run_cmd "$r1" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x01"
+	check_err $? "Failed to enable incoming interface info extension on R1"
+
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep INC"
+	check_err $? "Incoming interface info not appended after enable"
+
+	# Test that the extension is not appended when disabled.
+	run_cmd "$r1" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x00"
+	check_err $? "Failed to disable incoming interface info extension on R1"
+
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep INC"
+	check_fail $? "Incoming interface info appended after disable"
+
+	# Test that the extension is sent correctly from both R1 and H2.
+	run_cmd "$r1" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x01"
+	r1_ifindex=$(ip -n "$r1" -j link show dev eth1 | jq '.[]["ifindex"]')
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep '<INC:$r1_ifindex,\"eth1\",mtu=1500>'"
+	check_err $? "Wrong incoming interface info reported from R1"
+
+	run_cmd "$h2" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x01"
+	h2_ifindex=$(ip -n "$h2" -j link show dev eth2 | jq '.[]["ifindex"]')
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep '<INC:$h2_ifindex,\"eth2\",mtu=1500>'"
+	check_err $? "Wrong incoming interface info reported from H2"
+
+	# Add a global address on the incoming interface of R1 and check that
+	# it is reported.
+	run_cmd "$r1" "ip address add 198.51.100.1/24 dev eth1"
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep '<INC:$r1_ifindex,198.51.100.1,\"eth1\",mtu=1500>'"
+	check_err $? "Wrong incoming interface info reported from R1 after address addition"
+	run_cmd "$r1" "ip address del 198.51.100.1/24 dev eth1"
+
+	# Change name and MTU and make sure the result is still correct.
+	# Re-add the route towards H1 since it was deleted when we removed the
+	# last IPv4 address from eth1 on R1.
+	run_cmd "$r1" "ip route add 192.0.2.1/32 nexthop via inet6 fe80::1 dev eth1"
+	run_cmd "$r1" "ip link set dev eth1 name eth1tag mtu 1501"
+	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep '<INC:$r1_ifindex,\"eth1tag\",mtu=1501>'"
+	check_err $? "Wrong incoming interface info reported from R1 after name and MTU change"
+	run_cmd "$r1" "ip link set dev eth1tag name eth1 mtu 1500"
+
+	run_cmd "$r1" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x00"
+	run_cmd "$h2" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x00"
+}
+
+run_traceroute_ext()
+{
+	if ! traceroute --help 2>&1 | grep -q "\--extensions"; then
+		log_test_skip "traceroute too old, missing ICMP extensions support"
+		return
+	fi
+
+	setup_traceroute_ext
+
+	RET=0
+
+	## General ICMP extensions tests
+
+	# Test that ICMP extensions are disabled by default.
+	run_cmd "$h1" "sysctl net.ipv4.icmp_errors_extension_mask | grep \"= 0$\""
+	check_err $? "ICMP extensions are not disabled by default"
+
+	# Test that unsupported values are rejected.
+	run_cmd "$h1" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x80"
+	check_fail $? "Unsupported sysctl value was not rejected"
+
+	## Extension-specific tests
+
+	# Incoming interface info test. Test with various packet sizes,
+	# including the default one.
+	traceroute_ext_iio_iif_test
+	traceroute_ext_iio_iif_test 127
+	traceroute_ext_iio_iif_test 128
+	traceroute_ext_iio_iif_test 129
+
+	log_test "IPv4 traceroute with ICMP extensions"
+
+	cleanup_traceroute_ext
+}
+
 ################################################################################
 # Run tests
 
@@ -444,8 +721,10 @@ run_tests()
 {
 	run_traceroute6
 	run_traceroute6_vrf
+	run_traceroute6_ext
 	run_traceroute
 	run_traceroute_vrf
+	run_traceroute_ext
 }
 
 ################################################################################
@@ -462,6 +741,7 @@ done
 
 require_command traceroute6
 require_command traceroute
+require_command jq
 
 run_tests
 
-- 
2.51.0


