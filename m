Return-Path: <netdev+bounces-154505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392359FE3FD
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 09:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5888161B31
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421931A238D;
	Mon, 30 Dec 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oxx+Dzr6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C711A2397
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549181; cv=fail; b=TzWRkN9v7mIRwQnH8QEfzbszyjo8UaVbN606s8KUBFpxOL++cNVciWRNEPgXNhfaAOwnUPyEbBN5ostuM8djy5LSinRSK4JE9fTF+07ylinDhuiJZxnG3i3MG4W3AoyRsTB8kJXc8Gj87ggNx+NSTLniPit+cUEg+60KCpO1hDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549181; c=relaxed/simple;
	bh=LTzqzUXAcQ0eO4e6h4fbZjRhBdqCaOlyTSSUxKUDunE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLk9XwP7xH0mvuAheQIVIbeMf1OcRBzZ4jXdVywD4MQqLZ1vGKh9C3fI3I6QGKqJ1eKMMYcjodXq4fdISR+lZvkC+1Zw5xuS8nOs5NhEWbq4GnDOzcBkZOP6QJKr9NuHYkWdQLqb1lWMDE6IdoZ7VQ462pp2jR+h5q9ohgMLI/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oxx+Dzr6; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXnmR6fB7bEfj4fURWeOT6QTmaw1jjYQ88WNLwgnxtEPaxNFSg07z3QA7fOgvCZbgLPrHRJxjxp7Bl7JvY+UNBcHtxCm9Q3afN6Xhw0CDT7hydOVNYlXfiyWYvv9mc9dDm41LqpqNNaoKAnpcQWr3t8HKdUBhVmkkj0wEOcT23uqzgr6ZA26RZngs+eVypKuCPaUUYUxMimcwEox/7gWYWHS1oh0wgU9TcP+h/sZkKBYQrwZ2namFmSsuTawTtFvEdz/peDTEE8836CXL9UzRa6RzWpiWNXyXG09qfJiFpakPcSlst9kPBgccCJluu57BlZ3nY32YzgV0UDn9kKGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5381jDYk5P2h5SS4wPh6xE4nVN6bX43m7+OG9j9Kzhs=;
 b=bJMNM1KqDPK2dxs9giZ5d33yPU/uGLSIALCNYoo1yh3xMenO6hZv43UHaBBPyhjUgphyvQqzX/Pa/rbYPYOjGC74MNKwzLrpKPvB3SXFypQyoy4FoQDKFkaY94A8+Jn7jjh5LQVEwiKMolCOvYp2pAACkhs8boIeREh54Fetlp3etvY5rG804x8cmM7s1S7TvbvfgPbPLpCi7aCW7bIUP32GGJMQjVMOoSHy1JHQKeBWUAk8I0QeSLKz6HjnD5jcvuBbYuZCYLr8p2nlJNdMN/tNUTEiOoA60Vyuhq0L6i3RkyXkzRGSsbDbF2b90awggdFaGjDVvTky6b67G0Ep3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5381jDYk5P2h5SS4wPh6xE4nVN6bX43m7+OG9j9Kzhs=;
 b=Oxx+Dzr6NfkJLuAKV6Ft08Jnm6PZQQWIBbnH69qExx6zwf8PO/1rD5BO6LRoJQ9HTonYsNMpXryINA/zUXI5MZiE84m8s48l8X1O6TBqsKzJ6tD83fE6zwL0Q7cxMGnpqwjQBCg83Y2xfp3PgKKibQW9ViKAjqQbO8Sj9kv/yG2dHHgTXew8Q3z6tyt8eWQKxc5BS2hE6KSvwp4vFtoSpSPRaq4QF2TVEc41Qwapx4nIWkE7JPW0Rh7m+SD45SsXXnuQfD7ZlziLyZN4bzKKXWFJ2jKG5RYa9Rd1ChVBlnIad32/ubjVexKQLw0lU7jcl4H8WGsktFHnA8ldOc9rZw==
Received: from BN0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:e4::19)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Mon, 30 Dec
 2024 08:59:32 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::dd) by BN0PR02CA0014.outlook.office365.com
 (2603:10b6:408:e4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 08:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 08:59:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Dec
 2024 00:59:14 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Dec
 2024 00:59:12 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <petrm@nvidia.com>,
	<gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next v2 2/3] ip: route: Add IPv6 flow label support
Date: Mon, 30 Dec 2024 10:58:09 +0200
Message-ID: <20241230085810.87766-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230085810.87766-1-idosch@nvidia.com>
References: <20241230085810.87766-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|PH0PR12MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: 4daa88a0-ad25-44d0-3007-08dd28b04670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vOyFKY91kIqpJyxB95qaQUYfgVD+nsDuOKc8C5sEzTQtVqPJJ6GkCMXp3FB8?=
 =?us-ascii?Q?JlF5fkr03nJxA9WKeqsfyfgkFl62Si3vF8gT1ZCpXQWBW4oy0ax2G5EwUS3r?=
 =?us-ascii?Q?C695uLymXFa6aGKI57IyZbfOSNqAnLVj67tSxBzzvdgRyE2qSjkLp002teON?=
 =?us-ascii?Q?rvdMSHob5RRPxM/GUCSfIxh063mKQ07OXMNPsM7OczTjpV0bB286FnwDc4/S?=
 =?us-ascii?Q?NC5Xan44F5PQ7ihPobD0g1ub21aA/oodrRW8jGiVqsQ5McReBgRFGKdKsu92?=
 =?us-ascii?Q?k/4cStP4sTOlIMG7sselDHOrG7ZStRbOCK9SfogB2hieoJYCI2+VljnYN6am?=
 =?us-ascii?Q?66cEexyzmuhqiietA72P8Tj46qe6Zf+sPJghic3svW29lNenU7uw5a4Ll9LK?=
 =?us-ascii?Q?EIvi7hmnStWrIPDglDC/QUBVfd8i15Z/VNbPjpoGPkC6UlDEdfMTmXtXTp1D?=
 =?us-ascii?Q?KYt+o96UACLJsg2Ti6QPz2agSJy9/zeQF3e7pGg/vi7YQExXVfDy3xqxGe2T?=
 =?us-ascii?Q?o9OXp9RpnQZhHEM7DEJ66IWmabbjN4vSbP+TSQXl65nhHrz0RMquTx5epR6g?=
 =?us-ascii?Q?OUUdezWAdJdOQBYhSFI44RYZkP8bDZi1/r7nrJhTYAG8Cn99zGynLsPIBBuv?=
 =?us-ascii?Q?GAxmIXXBK4vxl+8SR3IqulExEXAPTEXR1F0VQidkCApYiZzejrwglA8Q8s2Q?=
 =?us-ascii?Q?VmZKtDaQkThd3eEC6pVF24sNlU9E/27AZDyQZ+MyRlndD7KJ71R1hw5XEeIg?=
 =?us-ascii?Q?Wjvgy87dJ427qRUwOm5VODMWX6EV7NuuOW3nuPBlC4qjGNLFmUv3Jfqpnmzd?=
 =?us-ascii?Q?+whrZJEze9y/6BNylfRX6SNdFFJ2RQMTFdLQELF8rJVRYJVTazu6xnIZYsW2?=
 =?us-ascii?Q?t486Syy9fvSXalATxAt1F8uRI2MKYZlHC3tR8BUDsGd6qcFGupNPEgNtL1BX?=
 =?us-ascii?Q?KhqF3A8X539BqB7xf0McUESjxWG4yUd5bjTQok/xbVJee1H/hDnfdKmxpXsS?=
 =?us-ascii?Q?Zp60U1oWKhT3hGiqxZ583LJPwZrpj1NfcAbzBY4SUgBkUjorc0qneAog7dIb?=
 =?us-ascii?Q?BNT19oK46TP5+o0XgmBeD/ilWff9Q4A0GD+MBrRzYgsAsxrx+o8Txdrb2JW4?=
 =?us-ascii?Q?au3yyI7MHMwrAWO5hWveCIi6hHvx3/1v1e8HNz3nQUCVyqam5+Uw7xHS5Dfe?=
 =?us-ascii?Q?afiUU0H0OlVd3aPy8CI8xr+3hiflipk7jiUnYjzZATYUYkOy3MQ+CYg1Lsjr?=
 =?us-ascii?Q?CGpoelO3F+dWp84ovrosNVFo/6Smt7fm3DpQPL1XmwIAYZsMHbenC2tFrafs?=
 =?us-ascii?Q?PkUjoP6Ue939DClQBEMOILPDELRVmkUVWmbB8mwPa3h0quUNkWv0urXCWUDQ?=
 =?us-ascii?Q?kMwvu9lpOiDJK6Rar+9Eq36m6P6xpRS0qTlHz5PakEvQJR/bmG/imeBAkGYc?=
 =?us-ascii?Q?vXP3FUCAxIPP90YcYmeISVHO91x6SW4+zg0g1IDWmBc91kD7RWjiswds3m4Z?=
 =?us-ascii?Q?pg+25UhQ9TYQ4kQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 08:59:31.5559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4daa88a0-ad25-44d0-3007-08dd28b04670
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824

Allow specifying an IPv6 flow label when performing a route lookup.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
---
 ip/iproute.c           | 10 +++++++++-
 man/man8/ip-route.8.in |  8 +++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/ip/iproute.c b/ip/iproute.c
index 9520729e58eb..e1fe26ce05d0 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -67,7 +67,7 @@ static void usage(void)
 		"                            [ mark NUMBER ] [ vrf NAME ]\n"
 		"                            [ uid NUMBER ] [ ipproto PROTOCOL ]\n"
 		"                            [ sport NUMBER ] [ dport NUMBER ]\n"
-		"                            [ as ADDRESS ]\n"
+		"                            [ as ADDRESS ] [ flowlabel FLOWLABEL ]\n"
 		"       ip route { add | del | change | append | replace } ROUTE\n"
 		"SELECTOR := [ root PREFIX ] [ match PREFIX ] [ exact PREFIX ]\n"
 		"            [ table TABLE_ID ] [ vrf NAME ] [ proto RTPROTO ]\n"
@@ -2129,6 +2129,14 @@ static int iproute_get(int argc, char **argv)
 				invarg("Invalid \"ipproto\" value\n",
 				       *argv);
 			addattr8(&req.n, sizeof(req), RTA_IP_PROTO, ipproto);
+		} else if (strcmp(*argv, "flowlabel") == 0) {
+			__be32 flowlabel;
+
+			NEXT_ARG();
+			if (get_be32(&flowlabel, *argv, 0))
+				invarg("invalid flowlabel", *argv);
+			addattr32(&req.n, sizeof(req), RTA_FLOWLABEL,
+				  flowlabel);
 		} else {
 			inet_prefix addr;
 
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 676f289a6d26..69d445ef8b5c 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -47,7 +47,9 @@ ip-route \- routing table management
 .B  dport
 .IR NUMBER " ] ["
 .B  as
-.IR ADDRESS " ]"
+.IR ADDRESS " ] ["
+.B  flowlabel
+.IR FLOWLABEL " ]
 
 .ti -8
 .BR "ip route" " { " add " | " del " | " change " | " append " | "\
@@ -1316,6 +1318,10 @@ was given, relookup the route with the source set to the preferred
 address received from the first lookup.
 If policy routing is used, it may be a different route.
 
+.TP
+.BI flowlabel " FLOWLABEL"
+ipv6 flow label as seen by the route lookup
+
 .P
 Note that this operation is not equivalent to
 .BR "ip route show" .
-- 
2.47.1


