Return-Path: <netdev+bounces-220718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB2B48563
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E0217C2C2
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC812E7F25;
	Mon,  8 Sep 2025 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l6GvW6Rl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAF2E3391;
	Mon,  8 Sep 2025 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316919; cv=fail; b=b8JyKz6GFda8W2TElTjE/8RRlID1qjCBOwRYdqiRd90Ndy8Ec2c/HUCdqzu3ZAXSLQOZ3hAE1oI8sIh3qOiJ3ZsHzLDPwEK4rWG6nE+d/LILaesfGC4GKUMouN5h/vAA25MrgbN/pdfMmn4dZqOT95Ee010BlcmQ7RLxbKVbRoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316919; c=relaxed/simple;
	bh=IjEPFizYnxDysctoap9yHn5R1ikSdSip8de6mWfUeuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFVxVVaLlp2+UmG9DC/M9N0t2UZ8kquL89V8aBSl41kH+lLPnepJAFT1iCzc+HBrhY+IE+VaUunZMymnyMnltRSZNAEqYOctFoQDLrkZQO6AUWa0S/FHzTFNLut0ZQTFZ525IDb7RT6DJeK2y9xksNQl7m3hq3qajMCSf3G6GE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l6GvW6Rl; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OS9JVsHqRm329Pgq/UHibHDzoOpJ61trUGSDdctRDF3A9JlAn6PehrSWFKdjA7DJ1gONz35agF3RcDx4zFLQAwUFUZ06yItmkHS298sMwtEAVBVjxN4cJuV91j/X3Pq5AjKSYM/Ksv9XlL85zPk3KkVGAfoPZ2lWbcYr8kPbNynV4K94bWmBjxZQjaMWjuIRy7h7hsc5U+vdjeRDQngp7YdK0E8q+OSbru6OhPwPjtQBvqTmRljHXgtjjYmYYbf8K9934oO+p/dEmuvQy5DWXTbe2n4QPjFYcDu7QVMLtWB9wKU198YEkObB4oUvNsAjAcErrEN1k1GsROjUOKCSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbWErs/1V3cO5z7KTSKyLnud19YYN/Y2FnFm7fTgFLY=;
 b=qlVxszo5qL6uGUtptprUvNfwJstMQYllDn38mukvT68onRAqsAyOrYSPKz95ouyXmTO0R79aiYUTmzq2nV1jrE36cTzPVJKGNcL/F+IWgCTBIXRY5QKsld7Na1K/8pximVKnOGiZZKeKLoCwvqLdGDCW8ML+vUooRX2M0u7ATDcZHEh98+93CjV6nbL8o8f3nrffpD/sAgBrz5h3PNQ1rsfHVlU6xFeTw4NnM3i9Tk5AOIx+kB9qOMupLBZCNHByGWgIAFBT9ce/59SEJ5Z7Z4bzDAu4WyVb8HAMZOxVUR1OuGPuNiBTS7rcllkBs8YBEXuNXtPaCMQc/HKiZF/Zxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbWErs/1V3cO5z7KTSKyLnud19YYN/Y2FnFm7fTgFLY=;
 b=l6GvW6RlVYyaN3CzyyIsklplEURGQufCDR8yjSzBX7FmfG4X/Ea4U6E6ZDx0TvfJznczVUqmdHfqD8w8Er5KocBxM5EiTiT5WvxIunHvYr4nXe3jmX3HAIkyBwfwmJfHUD/zb/RPXqlBN38k0p7JaMDhcxK+HvYVWurCfUuHHDzMy3vkqu6WasjmkQFp8HIFuCG4oE5UDD1g1SyR9jNvhSSOVTQTztJm4lD50d/+pb1MX4PqQo6zfGfNSG/o0aIFPo1czW8y4XCjiQAvfDvjVCCiQx+mqM/NimIAw8p1VvXPjIMDYh9zUb/B+YDsYtxTooyXI0WdXCabeorijZ9mJQ==
Received: from BN0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:408:e4::23)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:35:13 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::7f) by BN0PR02CA0018.outlook.office365.com
 (2603:10b6:408:e4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 07:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 07:35:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:48 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:44 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 6/8] selftests: traceroute: Reword comment
Date: Mon, 8 Sep 2025 10:32:36 +0300
Message-ID: <20250908073238.119240-7-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908073238.119240-1-idosch@nvidia.com>
References: <20250908073238.119240-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: d3121ce9-56e6-4c1f-f01c-08ddeeaa3f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2C/RQ3dzBFYye+3u9Cm/Ha80prDfQuP3a8qXjE46Vx1J1dMrndFYxbaMM3+4?=
 =?us-ascii?Q?WTdwa1K2MmYEVNwjdvw15A7yqn5gfTaSAjy+rIiUX+u2D1XO7nqufDpfXjyp?=
 =?us-ascii?Q?eW4/ZWHpFeaIVPbf1K1xetL8LaI1h1xmnwi4KCJU+cxtG/Wd66vryJc2ODPc?=
 =?us-ascii?Q?KS0fCLh/LWEaSUjt9dDs+YF1sh90uTq5K2wFBhRyGB09KBhthvPBhqA3Avv/?=
 =?us-ascii?Q?UTnEt73JJZIcPzKtpVgj9iCmDOZ6gqj1V+zhuEeRTH5iBgZC5ERv4FQxIprd?=
 =?us-ascii?Q?b79saDDloL1WLs2c9+QgSmROkdHmvnRPf7kjBK1QQQFt9+RGxB7gFWY/CtK/?=
 =?us-ascii?Q?um/KWHJMq4foz6X7q1XDC5d8/+1YlI23ccUwkJwWKRLNvq5NFtUEO3WBxpCr?=
 =?us-ascii?Q?q/zDYjWBc83Diykkb4UX5mc0dWfRkVACnX3nigRQFU0aduTe7GIsyKexldYH?=
 =?us-ascii?Q?RHSCBh7cs/EXowrmgGH7Bv1j9U2PB3G3CILLrR91icQWf52v08P0t4K2ORQ0?=
 =?us-ascii?Q?FWmOcyBRtDnzU/5XjIjVbwEvdgRTc8jOz6TJAFy7WC5J/vSkPQh3YHrmvIOd?=
 =?us-ascii?Q?ECWuH4hcgBdDZH4WyvwmHYUafaOaBqPt/GjlaryQJeNkzyN8Zg+AVu0uZc0J?=
 =?us-ascii?Q?89lvqtcIAiCKXYbzrF3oq6RXQTkEgbXqXmysE7y5o1MKm8eU512oWDBTb/xN?=
 =?us-ascii?Q?EkelmdM5XsUWTg/aKEZkP57zL7TV9WGW28IHipLgn6JqrGqRgCsD5P1XkBCU?=
 =?us-ascii?Q?Zuecd9+Q0lU3KJ2BxMV1uOVfbYDfAGrF7r/JJEdMTZb4HEYj2M4O/ZiXU1N+?=
 =?us-ascii?Q?L74qjgkUmmIHFQ0hu05z694RzcTzGx8+8O/RmnzlkN51UVTxDmFfcisfTyIV?=
 =?us-ascii?Q?wKZfD1T3Cyhhw9J8W9UdtTlK8ALmyfNBvDB7ee6KwXGuHKmJdSJU0jtcAuT8?=
 =?us-ascii?Q?O+ZJVbKQAFBsciFKN2SUeuZr93uiYlAWwxiBbzp7Uv3P+4xjycZ4g5wAkY/6?=
 =?us-ascii?Q?wldo1yjqcC7lW2ZqB2k4yIYfol62Ura8r2EPAc2xci8tcx42X2a7R8F6C9Ow?=
 =?us-ascii?Q?aAsnO5jB9IZHwiXXOADAYChJD0DiuQ7MUROSbkXbv+BRNlUDJ98a3DTUXTeJ?=
 =?us-ascii?Q?z2MwKv35sjsboFC5+LfxPk8UO5Ew2DxQv9PzmINvR3bVt/drcTqoKg2BMCu6?=
 =?us-ascii?Q?Elc33CHzZRHzcLSk7eTDVi3RhKhoBD7v2VfPPnKoVGgSpPcEPl6yfV0z/EaG?=
 =?us-ascii?Q?xuoeduPMGSfyzMxlMZa8XjrMmkPufgaTsEc/1H+KT/xcsHsodeopH4439gWd?=
 =?us-ascii?Q?cTJlG4n8vz2zZp/2bKtX47oBbftvLkgBOOCoKUNF4tKwlNwaefx3phknl12K?=
 =?us-ascii?Q?ty83Q91vs4gSE7yo1Fx4Zm/6UUPm97itxFmo3ZjEoRodf3F3DPCCvHy4USzG?=
 =?us-ascii?Q?X8h39S/8XQeGy8JAlHGVUOrvYjrPreof2IcFIa9CRYcctMfUNiZ5Kj/1u+71?=
 =?us-ascii?Q?fFscdLLMjL/6j++Sv2L9r2BOqYgXw++yUmak?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:35:11.5166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3121ce9-56e6-4c1f-f01c-08ddeeaa3f06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148

Both of the addresses are configured as primary addresses, but the
kernel is expected to choose 10.0.1.1/24 as the source IP of the ICMP
error message since it is on the same subnet as the destination IP of
the message (10.0.1.3/24). Reword the comment to reflect that.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/traceroute.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
index 1ac91eebd16f..8dc4e5d03e43 100755
--- a/tools/testing/selftests/net/traceroute.sh
+++ b/tools/testing/selftests/net/traceroute.sh
@@ -203,10 +203,10 @@ run_traceroute6()
 # |H1|--------------------------|R1|--------------------------|H2|
 # ----            N1            ----            N2            ----
 #
-# where net.ipv4.icmp_errors_use_inbound_ifaddr is set on R1 and
-# 1.0.3.1/24 and 1.0.1.1/24 are respectively R1's primary and secondary
-# address on N1.
-#
+# where net.ipv4.icmp_errors_use_inbound_ifaddr is set on R1 and 1.0.3.1/24 and
+# 1.0.1.1/24 are R1's primary addresses on N1. The kernel is expected to prefer
+# a source address that is on the same subnet as the destination IP of the ICMP
+# error message.
 
 cleanup_traceroute()
 {
-- 
2.51.0


