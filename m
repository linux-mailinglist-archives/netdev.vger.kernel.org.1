Return-Path: <netdev+bounces-154006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA519FAB89
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 09:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CC9166192
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 08:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BB0191F98;
	Mon, 23 Dec 2024 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OBvTUVwv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815EA191F67
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942602; cv=fail; b=b3xFnWtQZume6rOezDLaiWbAuauAyvXINkab+lFxkcr6KrTgNWDNhLYxoXJ9blTTXj7pFVlFLP63eBJJ2F9/W2Gyf3Ml8cb6yRKgu+Ctbv693KtmE1YUpnVmfEnnXX4T5f+BMmYINtbr3BL6nUsuwS5Ck5bPEU9JtgDvn6BSnn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942602; c=relaxed/simple;
	bh=ooGtwzynMVy0Ylnq1vxeAexXr7Mh2pOXK5aLYxuQr6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SI2xhsVlPPmaBvr4vMeJKuWhmoBC7C/sXIETO/AqDB2J1Eh/TbuS3K5DuJGBhZkzcVBpHnLNkcbot/W+obIuMG3Dnp2+C/f34vi+hUDVila1LxHa8Ab72TQUQvH1W13fh43jnSqvtpNjDfQmFWJMwlEPJV2LOjaHVUEelB0sQ08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OBvTUVwv; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+igsS58y37YSnX/jjIiBFhM1Gt9Hu6XmOVGuzT4/9BOtw4N3/42uzOXXoZ+zH5pUBjGhOi+Oy5IdD0KVXsDrJLrswPzIp8Z8Gnw4s9W+q0ok1KPlUSKIe2ULDKLiSlO7W6yID4FR1bArYGeftQVXWWdtHCyvWnGKQKmW7n5/9qQCX+fkIwapYjNPB2Z29Rr35F8ZHtotD7IE+PcXY8Jn4mA3Tx5r6v70SCeJqu/WWhU7vohOjHXKwp6gGSoTly0TS1kkiE7HMIAKjhzahp9FmonCYj13TQ3+Wf20JgK4UbtGnP6HUU/ODpVcl2wl+a+Xkxc1HKOnWiaSgLxTCzLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fcpRXu037IrDg3Y6JLSAEggkUUQQ0dsHsHzz0eL5m0=;
 b=d9bD0HaD/DwvCLkww6YvecmwBtPkzWuebw576nrgr1fIX5g4Zgnz5rp1vgrhx6h3jNHyZ7Xb0sCVJycldJRXZSD5rr6Icdojdjg9pg3uovNg4Z21oX7J6DzW9uixaILGaNxNNuXti66QgBW5viJkkeEvNlxYoCZ7MamKd3x0RepaeWvVTApTp/tpGoOILze+VeELkhylVxuhvjumqBwCqbBK0P+/Xg0/3hHRFNn0Nga3Sw3azDWm2cc7Nv7cPA5dZXoFOqo2aNEi38eFxO8OaxvOLIfg8tc8iTDdOyc00LZ4cXoO4i0vwDUpSwAxOZuxqnKrEdf7okLEUcn+Wo3bKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fcpRXu037IrDg3Y6JLSAEggkUUQQ0dsHsHzz0eL5m0=;
 b=OBvTUVwvUvnmsIgVbfE0Y5RNq9KsOkLH3GLKkiaZb0LN652OnFsEirWIE6M+cae27aB8fIv7noLtth+U1e/bJs1kn4ljwVsU6ZV1gPcNCY3j2DmLtKDHHd3KiN8riJTVsN3YBUFami+iYoyDmYj8EeExMT2OIpSNIv87YAdnep1eAGpPz6B5/T9K2ty+40qhTBCZzg3VMnNeccsrcAtCRNY4vnGj/AqD+RVImB8CPqCA8zofiHDJJVVJ7ysv8DZGoQ63Np6tCOixvPKbtfXAM6qixnvlsEMweJnh+8N0/5C3qABv4G3ySpqWXB+00VTh76Ej41MwnfWPI+hlhcax4w==
Received: from SN7PR04CA0233.namprd04.prod.outlook.com (2603:10b6:806:127::28)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Mon, 23 Dec
 2024 08:29:53 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::54) by SN7PR04CA0233.outlook.office365.com
 (2603:10b6:806:127::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.19 via Frontend Transport; Mon,
 23 Dec 2024 08:29:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.12 via Frontend Transport; Mon, 23 Dec 2024 08:29:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Dec
 2024 00:29:41 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Dec
 2024 00:29:39 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <petrm@nvidia.com>,
	<gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 2/3] ip: route: Add IPv6 flow label support
Date: Mon, 23 Dec 2024 10:26:41 +0200
Message-ID: <20241223082642.48634-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223082642.48634-1-idosch@nvidia.com>
References: <20241223082642.48634-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 6680591b-6fdf-41f5-1405-08dd232bf993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y2gt4JLFWjEbT4ZF7RrqsYVLx38RbwP3qfXHd0N5qvjd5KjGRyNhaTjM8Ihc?=
 =?us-ascii?Q?TmIccejK7nJ/qr/DWPZcj0Y60NUk+gVfPL+rhLF5z/GKATcNcYKAO/iqK1rm?=
 =?us-ascii?Q?uMz7C28g0XsjH3rTR+VSKPMyRX0LMdSRs7V/48tX52/PT2zFFKfAjez9sho7?=
 =?us-ascii?Q?xQJy1XSKG5srqiQGOdfW2QD2CquSP9vFfDXBIXJNPmGOTnq308XefC4GIIbp?=
 =?us-ascii?Q?VG1y4yT4AbrTQpVQRec5Ii90DUR+G7XDw6mdGORpNkoOVUHryqB3ntfyOBFY?=
 =?us-ascii?Q?9Zu7fWVPR4I58+c8u4T/loQYUCZ30WaeRHTCuph2a5s2yA5z48HPULGFw0F0?=
 =?us-ascii?Q?9gOgxTLBt2VCGqTQtI9NUfj7XZYOhkBf/lTJZak1OsrYG/QxvQ9XXKrnK4yv?=
 =?us-ascii?Q?ekgbsc2uxiJ7HXWtxcjC4Sv93zOze/LeD0N9Fj5WKdPn+/tMNSREeETXQjuc?=
 =?us-ascii?Q?ewQk15w+uDLlTqEcgTkniI9S7OT4CAvKdeQ6MfNExYxkfT9GefPdyGENlHR2?=
 =?us-ascii?Q?lhgirMI2XZC/GfilXYrOkirjb1l8OE7AiCJax5GEx/NZhdAz3IqxNoLNMAMN?=
 =?us-ascii?Q?1DJeSD86yDFt6yIb1g960N+byHxZkf7/A+WOZEmd1pDF9M/9Jp6fnExGiFA/?=
 =?us-ascii?Q?/F+F1bIzdqIpW1psxbmul6YEiUq5slrBgfzeNoZ0oVzif2uiz6o2KbD7Tht6?=
 =?us-ascii?Q?lvEn8AaYomvcqfLW6jPNTfykxpLK/52vshuMsqVtnDPIuNBhu71H5hnSAr+j?=
 =?us-ascii?Q?b7AlWAKmE4s/tkGW8iwz0E5oLEEiYWmhbcmwMrmlb9EpXPzH/QhzxbKQYpqn?=
 =?us-ascii?Q?Tsa0cua+tVJXOHfSzdEYeiIuOo7PffdtmFa3AM35u1axjJGkYSJ/MwbbqATc?=
 =?us-ascii?Q?zJInKCQ8IrU7QtIvweL/hISny2QpOyojvpBATtL6x9vC6E261rddo7TZs4hB?=
 =?us-ascii?Q?PQk7C4deJtb+ln+Rp6/TrPRo+d89uGjmJDaLubefDlEP2JXV1hdDSXoiuvEl?=
 =?us-ascii?Q?lNIMQRpbzJZlZL4VnT1iObor+dD7+LAm5unsXhBV+CO2iJroLp0BwU5+ehq+?=
 =?us-ascii?Q?CqbnYIuEBjEhdSi6EWBUOAAwcoLod7pFkpaR493TKl2JZOatzSiaYoNzy9/Z?=
 =?us-ascii?Q?P3aglaSB5wOdey6oatDQNdLnFgqstDUUjq2IT2GKXhHeqhC8jwDaZOXXMoi3?=
 =?us-ascii?Q?M5Ei1J5tJ8xWRI7sRDovNpkXOXUMPxKhz268Pr1XsKAvPmQ2sWygoyWwxHX7?=
 =?us-ascii?Q?bRC9EAx855p8FkYau6VaFtuUqHqV4yodyNMTKLDJSKKVvVcPnjG5CMCqKw/s?=
 =?us-ascii?Q?Ymx2tIZqKnC7U70Z/JgjdwKA4FtxJxpRru/2k+QBSNV5bqltTn37pUsvPI9L?=
 =?us-ascii?Q?GU1pFcm1RNg97IkS2ejz6vXzp2vjaXeUPmhsrZl7D4lHz0X5SrFQVNgFxymS?=
 =?us-ascii?Q?57/Igau/gbhX1vMwoozTwoF+2IzdfePj+FHYCtcsOC0OjWgCsLbJARpY1q2A?=
 =?us-ascii?Q?sxXMlr41gVsHeGo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 08:29:53.2647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6680591b-6fdf-41f5-1405-08dd232bf993
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228

Allow specifying an IPv6 flow label when performing a route lookup.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 ip/iproute.c           | 10 +++++++++-
 man/man8/ip-route.8.in |  8 +++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/ip/iproute.c b/ip/iproute.c
index 9520729e58eb..e87faecdb714 100644
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
+				invarg("invalid flowlabel\n", *argv);
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


