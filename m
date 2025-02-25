Return-Path: <netdev+bounces-169365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C50E3A43937
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3D919E1AFA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DC52676C1;
	Tue, 25 Feb 2025 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aA9NpURB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5D266EF7
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474669; cv=fail; b=Rwxl0SKD9n7anq6MfQgkd6zwSX9XhYs5YZo5DGiGQzGUtQxx3R416E5dsW0b/FgpyIqwf5nEzCbRX8OKAF7rMKczqorBUjorfTvv3KLFbJDjggiRWisbHtZ/3IPZM6qIijcD1ejOPSnL5nhCrLdAmLjFhSf8cEqCPO164M0ACVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474669; c=relaxed/simple;
	bh=Cq9f1gQjooFsSduhXofgZieiMr+Zxas9pjcSkbAqGbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WD+Ryp5P0YWFyqsaYtvmRZNYRiQwdMTIMiW6F0sq43iycL9oYQGVzZebPSpNTqVBgzhs/YoCKPkW2Tp6h7DqjeuB+nbKsQ4TfTpvrGGpmQJhD/oYiNkkJm8u/xS+IpWwbMXlgW9lGmvwGwYjQQkWNBCzc4Uk0bRoD2Oc/5rH0ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aA9NpURB; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIYjrI+0vN2i1mpqju5whQVmxqs8mxYROy1AkdMC4OVTRXSSdhb29/Mjn1+QEYydNv7sd0FlspSEh9MDR3hvhRndEqg6XIUF1sdUTjiAzu4QjQbb8JGnoO0da1p1Q4vj/r8T2FBxntDJ4eJKd9pflpX1QtWVrdqWj/78fZQFDFo8+bqMX56GA8BRwcIMe1SeHyFKaSzeuYDlvhjZJczJE3ChV+trx+Eq0aSZpYsU9TLk72EB9wE6Zrd1cmtyOOTONWEGMm6jZkQ7QdOJT6m3xhhoULZ1WEy7uibeT9kjYzPbN2VLmqPArxrzEMD4Tk7y8GkQGLVAE21l5m4P6FXSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks+PMvczbLnUo7KOn4L0GlQp8MBRHLCiVVj92m60gUY=;
 b=VOtUuk+6cVVmqJpldXChJaRqQn3ZQd+2NgAHcwfV4DF5NRea8AEy9KRB8F43zb7wQgM7ERxcqooUQDEJt6/kneYDfRsTEaaSDGepEFbTSOYRtQ/NEkMFGkOhU/5mb2O31mVKl1DSPJdZLFDKN6Demax0pheg1oIIqBeRJRWiR2S9U+cs1CEZQ2xfnjIoY8WHhM50jFtgoNAZHnSSSy/SySodNVd4eVdFwamChEZxLO/m5hFaFg6HePUBiZ1t7ZgvFfdLL8WhVQJ7/wK2eBiDbsScu+razzAzN9Y1hF+DlwJxbBb446Of2cRVRfD4h5gHg7x07JDsf/GE/OxvI64d/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks+PMvczbLnUo7KOn4L0GlQp8MBRHLCiVVj92m60gUY=;
 b=aA9NpURBLbCsUTz76xttiUSNQYBYDrFVFZEPtwSDPYHKIAypLtmGqUnN1P5J1S5dF9Rhch0Gl2nlOLwZWvlvEznQnKvsKuKRrZl7yu0Rvj8cQDQ1KdQMETHIVIxCUtSawsxBiJBkrJCPlqqVLzGH1DpWkurwuwRg19Sl5qevehIUywryZfluDrLXmNWZMiDx9Tl0Sbuj+zaH7s/KF/P7oF95xJmJUJXfPtpVpyoiWNYtS4oOs/2LIhki41cfGSNJLlL7QQsW07fJkyasHhcqhkskseytqG2x1pIbXVSncENKU4Kn4Dk6SI0xmNo6qVtFuzzaZbg/6hTyGN+VUZM95Q==
Received: from SA9PR13CA0161.namprd13.prod.outlook.com (2603:10b6:806:28::16)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 09:11:02 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::1d) by SA9PR13CA0161.outlook.office365.com
 (2603:10b6:806:28::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Tue,
 25 Feb 2025 09:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 09:11:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 01:10:51 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 01:10:48 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next v2 4/5] iprule: Add port mask support
Date: Tue, 25 Feb 2025 11:09:16 +0200
Message-ID: <20250225090917.499376-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225090917.499376-1-idosch@nvidia.com>
References: <20250225090917.499376-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: a432d89c-f8d8-48e4-21aa-08dd557c5370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n22FXny3XIYB/m9T9Ilv01bQVsgNW30eq2KhJ+qBQVDvrHM38qCYufzEMoNo?=
 =?us-ascii?Q?nI4b2i1/fUyIQleaUwQcun/5cBmAvkCcp76qiqRCApDC1cE9jL2Dm+pdIwxO?=
 =?us-ascii?Q?TQdphVu7+IxFQcbeRs8u/HfHiVCwV7cmIE2Z6x66U/mhors2NMgZt7cp6AF+?=
 =?us-ascii?Q?2gqsOvvk6rYu1uqJwH3Xt+zH29Eza3TeZtMxFQvSqd2Y1h5iSicfGdgQcETn?=
 =?us-ascii?Q?hnaghT9pcmox2drRfbMc+gn6OdQ4Je8J0HTBS+1lutsROCqSeoXCnbo9DTUj?=
 =?us-ascii?Q?XX/++tqF1qzxEkiMdrQEILWmVxJJiXWKqLRXtCowTY8INGdXNInLJRapbEQx?=
 =?us-ascii?Q?Qndx1Vv/OsZpDzJU4Zq+NO9cnOg2AcLxgJ0/OPpFUCZ7J8T9Bw2H63toUJrG?=
 =?us-ascii?Q?IPLzedAoeXr2RMxW/FEIl6upPtaxRUFKYueM6vjUqyq/rEqo/a9zLYRIsaUt?=
 =?us-ascii?Q?DxuIKm/gltadTV5EegCk1CPDvjv6E4xxf9Co6EC4GRFYeNnoGczuaW9FFsl+?=
 =?us-ascii?Q?FCt6yw1jYhP1adcDjnCDCcQLHpzHmZLCIKWeg1Vq29DvG+ZxfZGYTZ/DJSbd?=
 =?us-ascii?Q?Mvg5AGlQqKmjX0I8pAm3mjIZA9OQ0zMRuH3XLN51/FSSwmby1lZhnlJDv0OE?=
 =?us-ascii?Q?gFLjDVavegP2E76LvaG64wYfrDE26bDai4shv3yGsFd0ddzRVswzYRT9kJbh?=
 =?us-ascii?Q?0fpAru7jjKi0ZwVo+9t5y2praMQkP0yGkB/vaUeO+2xDz8krxig7q5pA7CU1?=
 =?us-ascii?Q?q1vX6N+cOT3diBENdM3rx5xWpPvlPmho7ByxeBPnf5jO1yi8YzztgCHSgol2?=
 =?us-ascii?Q?EJXmXDp15xJikLIm2HuqYcEusvlnTRQ8k+ORBCiXE5IgrMwysJGmvNiTx6IK?=
 =?us-ascii?Q?ZAb7Rat7eARaU48TEIxTbqi3L/J7Q7M6MvWsIRf4/JuTl4uaeTrCVeXID2gP?=
 =?us-ascii?Q?562t6h5eqGgTKc4Dxx8yj3SLKXgAYqMe+i6oqYLqlvVf69AxaKaAYeXKp3Nj?=
 =?us-ascii?Q?k0s8jkERAxf5VYFyaV0P4KCHdJaR4f5SXPDKDB/QBE/awqG5A8qMmEIAT6OU?=
 =?us-ascii?Q?PpNIEETBFzjxk0CyBE2Ea+AEScUFA0QIz+el1B40FWHLwqzw46XHzCXp+Iad?=
 =?us-ascii?Q?jo/KvMdH+YjeP+6F7l89V+xEEH26Br191tX/YXswpC0GkQNjLxKOzQ85gPYb?=
 =?us-ascii?Q?7N55Y7uXLi5zGi5+MLVpHZsjJf2NlqoWReDfd6qZqLvlELkrxaz1Oy7nbBuK?=
 =?us-ascii?Q?fsHB6vdmCDv3tthOTYDVHQ1QZUkFriu2zRdrISfIHstUf10wAh3M5ww5dMny?=
 =?us-ascii?Q?OaB6mMt5EbNsl9i2Rt+w0G0peZ8IabXThiGvCLGUN/DSKmapfzlh6HGbVRHh?=
 =?us-ascii?Q?trRshEJpfk2j9RMSy1Nnl9v31SBNb7D36wH1Yrlb6wmWzNurtzX/cQx6IQHA?=
 =?us-ascii?Q?9tTu7ngjRH75EBU6FMMltQyKA1YbXxOWz1QFkkT6Hhnpq7JlJ0BmpjRjA08c?=
 =?us-ascii?Q?c+KE48ij5VQD020=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:11:01.8923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a432d89c-f8d8-48e4-21aa-08dd557c5370
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562

Add port mask support, allowing users to specify a source or destination
port with an optional mask. Example:

 # ip rule add sport 80 table 100
 # ip rule add sport 90/0xffff table 200
 # ip rule add dport 1000-2000 table 300
 # ip rule add sport 0x123/0xfff table 400
 # ip rule add dport 0x4/0xff table 500
 # ip rule add dport 0x8/0xf table 600
 # ip rule del dport 0x8/0xf table 600

In non-JSON output, the mask is not printed in case of exact match:

 $ ip rule show
 0:      from all lookup local
 32761:  from all dport 0x4/0xff lookup 500
 32762:  from all sport 0x123/0xfff lookup 400
 32763:  from all dport 1000-2000 lookup 300
 32764:  from all sport 90 lookup 200
 32765:  from all sport 80 lookup 100
 32766:  from all lookup main
 32767:  from all lookup default

Dump can be filtered by port value and mask:

 $ ip rule show sport 80
 32765:  from all sport 80 lookup 100
 $ ip rule show sport 90
 32764:  from all sport 90 lookup 200
 $ ip rule show sport 0x123/0x0fff
 32762:  from all sport 0x123/0xfff lookup 400
 $ ip rule show dport 4/0xff
 32761:  from all dport 0x4/0xff lookup 500

In JSON output, the port mask is printed as an hexadecimal string to be
consistent with other masks. The port value is printed as an integer in
order not to break existing scripts:

 $ ip -j -p rule show sport 0x123/0xfff table 400
 [ {
         "priority": 32762,
         "src": "all",
         "sport": 291,
         "sport_mask": "0xfff",
         "table": "400"
     } ]

The mask attribute is only sent to the kernel in case of inexact match
so that iproute2 will continue working with kernels that do not support
the attribute.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    
    * Do not duplicate port parsing in iprule_port_parse().
    * s/supports/Supports/ in man page.

 ip/iprule.c           | 96 ++++++++++++++++++++++++++++++++++++++-----
 man/man8/ip-rule.8.in | 14 ++++---
 2 files changed, 93 insertions(+), 17 deletions(-)

diff --git a/ip/iprule.c b/ip/iprule.c
index 64d389bebb76..3338c7d6773a 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -23,6 +23,8 @@
 #include "ip_common.h"
 #include "json_print.h"
 
+#define PORT_MAX_MASK 0xFFFF
+
 enum list_action {
 	IPRULE_LIST,
 	IPRULE_FLUSH,
@@ -44,8 +46,8 @@ static void usage(void)
 		"            [ iif STRING ] [ oif STRING ] [ pref NUMBER ] [ l3mdev ]\n"
 		"            [ uidrange NUMBER-NUMBER ]\n"
 		"            [ ipproto PROTOCOL ]\n"
-		"            [ sport [ NUMBER | NUMBER-NUMBER ]\n"
-		"            [ dport [ NUMBER | NUMBER-NUMBER ] ]\n"
+		"            [ sport [ NUMBER[/MASK] | NUMBER-NUMBER ]\n"
+		"            [ dport [ NUMBER[/MASK] | NUMBER-NUMBER ] ]\n"
 		"            [ dscp DSCP ] [ flowlabel FLOWLABEL[/MASK] ]\n"
 		"ACTION := [ table TABLE_ID ]\n"
 		"          [ protocol PROTO ]\n"
@@ -80,6 +82,7 @@ static struct
 	int protocolmask;
 	struct fib_rule_port_range sport;
 	struct fib_rule_port_range dport;
+	__u16 sport_mask, dport_mask;
 	__u8 ipproto;
 } filter;
 
@@ -186,8 +189,9 @@ static bool filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
 			return false;
 	}
 
-	if (filter.sport.start) {
+	if (filter.sport_mask) {
 		const struct fib_rule_port_range *r;
+		__u16 sport_mask = PORT_MAX_MASK;
 
 		if (!tb[FRA_SPORT_RANGE])
 			return false;
@@ -196,10 +200,16 @@ static bool filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
 		if (r->start != filter.sport.start ||
 		    r->end != filter.sport.end)
 			return false;
+
+		if (tb[FRA_SPORT_MASK])
+			sport_mask = rta_getattr_u16(tb[FRA_SPORT_MASK]);
+		if (filter.sport_mask != sport_mask)
+			return false;
 	}
 
-	if (filter.dport.start) {
+	if (filter.dport_mask) {
 		const struct fib_rule_port_range *r;
+		__u16 dport_mask = PORT_MAX_MASK;
 
 		if (!tb[FRA_DPORT_RANGE])
 			return false;
@@ -208,6 +218,11 @@ static bool filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
 		if (r->start != filter.dport.start ||
 		    r->end != filter.dport.end)
 			return false;
+
+		if (tb[FRA_DPORT_MASK])
+			dport_mask = rta_getattr_u16(tb[FRA_DPORT_MASK]);
+		if (filter.dport_mask != dport_mask)
+			return false;
 	}
 
 	if (filter.tun_id) {
@@ -390,7 +405,26 @@ int print_rule(struct nlmsghdr *n, void *arg)
 		struct fib_rule_port_range *r = RTA_DATA(tb[FRA_SPORT_RANGE]);
 
 		if (r->start == r->end) {
-			print_uint(PRINT_ANY, "sport", " sport %u", r->start);
+			if (tb[FRA_SPORT_MASK]) {
+				__u16 mask;
+
+				mask = rta_getattr_u16(tb[FRA_SPORT_MASK]);
+				print_uint(PRINT_JSON, "sport", NULL, r->start);
+				print_0xhex(PRINT_JSON, "sport_mask", NULL,
+					    mask);
+				if (mask == PORT_MAX_MASK) {
+					print_uint(PRINT_FP, NULL, " sport %u",
+						   r->start);
+				} else {
+					print_0xhex(PRINT_FP, NULL,
+						    " sport %#x", r->start);
+					print_0xhex(PRINT_FP, NULL, "/%#x",
+						    mask);
+				}
+			} else {
+				print_uint(PRINT_ANY, "sport", " sport %u",
+					   r->start);
+			}
 		} else {
 			print_uint(PRINT_ANY, "sport_start", " sport %u",
 				   r->start);
@@ -402,7 +436,26 @@ int print_rule(struct nlmsghdr *n, void *arg)
 		struct fib_rule_port_range *r = RTA_DATA(tb[FRA_DPORT_RANGE]);
 
 		if (r->start == r->end) {
-			print_uint(PRINT_ANY, "dport", " dport %u", r->start);
+			if (tb[FRA_DPORT_MASK]) {
+				__u16 mask;
+
+				mask = rta_getattr_u16(tb[FRA_DPORT_MASK]);
+				print_uint(PRINT_JSON, "dport", NULL, r->start);
+				print_0xhex(PRINT_JSON, "dport_mask", NULL,
+					    mask);
+				if (mask == 0xFFFF) {
+					print_uint(PRINT_FP, NULL, " dport %u",
+						   r->start);
+				} else {
+					print_0xhex(PRINT_FP, NULL,
+						    " dport %#x", r->start);
+					print_0xhex(PRINT_FP, NULL, "/%#x",
+						    mask);
+				}
+			} else {
+				print_uint(PRINT_ANY, "dport", " dport %u",
+					   r->start);
+			}
 		} else {
 			print_uint(PRINT_ANY, "dport_start", " dport %u",
 				   r->start);
@@ -600,10 +653,13 @@ static int flush_rule(struct nlmsghdr *n, void *arg)
 	return 0;
 }
 
-static void iprule_port_parse(char *arg, struct fib_rule_port_range *r)
+static void iprule_port_parse(char *arg, struct fib_rule_port_range *r,
+			      __u16 *mask)
 {
 	char *sep;
 
+	*mask = PORT_MAX_MASK;
+
 	sep = strchr(arg, '-');
 	if (sep) {
 		*sep = '\0';
@@ -617,6 +673,14 @@ static void iprule_port_parse(char *arg, struct fib_rule_port_range *r)
 		return;
 	}
 
+	sep = strchr(arg, '/');
+	if (sep) {
+		*sep = '\0';
+
+		if (get_u16(mask, sep + 1, 0))
+			invarg("invalid mask", sep + 1);
+	}
+
 	if (get_u16(&r->start, arg, 0))
 		invarg("invalid port", arg);
 
@@ -770,10 +834,12 @@ static int iprule_list_flush_or_save(int argc, char **argv, int action)
 			filter.ipproto = ipproto;
 		} else if (strcmp(*argv, "sport") == 0) {
 			NEXT_ARG();
-			iprule_port_parse(*argv, &filter.sport);
+			iprule_port_parse(*argv, &filter.sport,
+					  &filter.sport_mask);
 		} else if (strcmp(*argv, "dport") == 0) {
 			NEXT_ARG();
-			iprule_port_parse(*argv, &filter.dport);
+			iprule_port_parse(*argv, &filter.dport,
+					  &filter.dport_mask);
 		} else if (strcmp(*argv, "dscp") == 0) {
 			__u32 dscp;
 
@@ -1043,18 +1109,26 @@ static int iprule_modify(int cmd, int argc, char **argv)
 			addattr8(&req.n, sizeof(req), FRA_IP_PROTO, ipproto);
 		} else if (strcmp(*argv, "sport") == 0) {
 			struct fib_rule_port_range r;
+			__u16 sport_mask;
 
 			NEXT_ARG();
-			iprule_port_parse(*argv, &r);
+			iprule_port_parse(*argv, &r, &sport_mask);
 			addattr_l(&req.n, sizeof(req), FRA_SPORT_RANGE, &r,
 				  sizeof(r));
+			if (sport_mask != PORT_MAX_MASK)
+				addattr16(&req.n, sizeof(req), FRA_SPORT_MASK,
+					  sport_mask);
 		} else if (strcmp(*argv, "dport") == 0) {
 			struct fib_rule_port_range r;
+			__u16 dport_mask;
 
 			NEXT_ARG();
-			iprule_port_parse(*argv, &r);
+			iprule_port_parse(*argv, &r, &dport_mask);
 			addattr_l(&req.n, sizeof(req), FRA_DPORT_RANGE, &r,
 				  sizeof(r));
+			if (dport_mask != PORT_MAX_MASK)
+				addattr16(&req.n, sizeof(req), FRA_DPORT_MASK,
+					  dport_mask);
 		} else if (strcmp(*argv, "dscp") == 0) {
 			__u32 dscp;
 
diff --git a/man/man8/ip-rule.8.in b/man/man8/ip-rule.8.in
index 6fc741d4f470..6a2a3cd848df 100644
--- a/man/man8/ip-rule.8.in
+++ b/man/man8/ip-rule.8.in
@@ -52,10 +52,10 @@ ip-rule \- routing policy database management
 .B ipproto
 .IR PROTOCOL " ] [ "
 .BR sport " [ "
-.IR NUMBER " | "
+.IR NUMBER\fR[\fB/\fIMASK "] | "
 .IR NUMBER "-" NUMBER " ] ] [ "
 .BR dport " [ "
-.IR NUMBER " | "
+.IR NUMBER\fR[\fB/\fIMASK "] | "
 .IR NUMBER "-" NUMBER " ] ] [ "
 .B  tun_id
 .IR TUN_ID " ] [ "
@@ -270,12 +270,14 @@ value to match.
 select the ip protocol value to match.
 
 .TP
-.BI sport " NUMBER | NUMBER-NUMBER"
-select the source port value to match. supports port range.
+.BI sport " NUMBER\fR[\fB/\fIMASK\fR] | NUMBER-NUMBER"
+select the source port value to match with an optional mask. Supports port
+range.
 
 .TP
-.BI dport " NUMBER | NUMBER-NUMBER"
-select the destination port value to match. supports port range.
+.BI dport " NUMBER\fR[\fB/\fIMASK\fR] | NUMBER-NUMBER"
+select the destination port value to match with an optional mask. Supports port
+range.
 
 .TP
 .BI priority " PREFERENCE"
-- 
2.48.1


