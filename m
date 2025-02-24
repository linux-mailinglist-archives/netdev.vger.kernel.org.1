Return-Path: <netdev+bounces-168899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC9DA415B4
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 07:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCA33B530D
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA00E207DF6;
	Mon, 24 Feb 2025 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mSaNLWEY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF201C7009
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380024; cv=fail; b=HUHPBDDyqSyhzFCNpwvde8lX0S2vrUmGhSFQltOZO1gtlQh25VvQ91HeFqqgasDeApbwxiyA0BX69nWaAEGWZpsuEVE8494xLGXur/K0oRgzcQw3nyCEEkzkP3fyh1WXQvEumQjVipVlpvn67zCh8a0WWG4/26mCxGQxZtn9vO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380024; c=relaxed/simple;
	bh=onXKdqAJCppFXrjmikuJOjLqCGYjnrupK7SCeHf0Mmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5SgnpQhwZXgGhiZTe+DJszbf1QCzYvFBJJFIJ+NZ8+7A5y58X3xp4xIEDMLy+ZsXrlFNK5/8M8A6ZssdRclWFlY5fQg1kxumYaLACsiukqd39OdfjZh5kHfxGzj2zuT7WUkMS0OuvtOa/1sfLPuqIlwDpurqz2U+YiTWljpMYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mSaNLWEY; arc=fail smtp.client-ip=40.107.100.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8WooEV8NkZSiRf2bC77+PmrrT01Hfiar+zmCFA7NIHP4Ft2ym51VyhE0jpckolcDT/e6bBEdiNTRkWruTmoWei54P49ojw44D7s7g9SNHqXCTKLhgyLMRLBSIC+mcyDud6ko0N3a2fPDhSguYSDmLqnh90nu/ZiuXRUr5mg0cETC9aEo21NCQngdHTf+BPtO+GAxVEfHgApcb1ZlaocuYIAIi7FBmYx0TqSiLdaSTIT9guVYS4jKoH1p47ZV0/sdZ94R1yCSrc0iHvzbnyikvGb+ke2NU42sDIo9epIycmE/IYYE8I2+clZzpj6iHF2TmMS3VqzsKeaS335d0dfBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBAOq35ipO0L8n7kk5ISuVlFnjbyDIU5bKAFOeeb8XU=;
 b=OuHpI7WTo9aOqpOXTq7PbSkG/2f4TbU+Wf5m3ZoWcmbpEinNi7g+PyvO0zrES7s72lcSHeYOohIW+gzstBsxK9R6ZDM3e/ah5MkJRq3a52utZFjr36QPj9qfQYkGK2PgBypcb+Q+K5cQieUZMr0AeBqCc+yu2rDBqShz1yYw/bSB7wTHVbh+Nnbo5vJsXM88Kd9XqAUDvezX4nqResPtvctf4WoGjC+gtti3zu5OQ4hCnDPcDFhHg4dke5IqvfJ2twkgDxt0FXeLcW44a2MXnfnph7IiWfTcSzcVdFUMz6svEGuLldb8DesiH6GXkvn6dU3X0nAkTgT9EpQXBidp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBAOq35ipO0L8n7kk5ISuVlFnjbyDIU5bKAFOeeb8XU=;
 b=mSaNLWEYcr/vTRhtGb1QVoOok5DpYQ0+1XZ/Yl63ZPzUdKxbr/uvqtGUdeH+MYdaRNk9+/9Cyq97yPEGus1uEYql7ZUPyAS+86usCxsDWURdsBoPdmZ9yQKw/f6E8/M134bCLIRZ4nobiuaB1yTzChe60sVcZM9IoBdJhKRony0y2HdMhF6NQ1d8Ok7sF8W6GzoJqe+pRNOYFTFO4t9f3LbIZ2vlY+InoyjR4zjSRccoDNseyVE/lJ+xSeN9t5SmAY8Bz3WJPaUNT0/HH1JHJGoEgdhJe6cpVGRk8blBn4XJSr8ZQlLpuFvM0nZRs2jCYuPWHd/vBwKpHKEX+Y03Uw==
Received: from DM6PR14CA0063.namprd14.prod.outlook.com (2603:10b6:5:18f::40)
 by SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 06:53:34 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:5:18f:cafe::7a) by DM6PR14CA0063.outlook.office365.com
 (2603:10b6:5:18f::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 06:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 24 Feb 2025 06:53:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 23 Feb
 2025 22:53:23 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 23 Feb
 2025 22:53:21 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 4/5] iprule: Add port mask support
Date: Mon, 24 Feb 2025 08:52:39 +0200
Message-ID: <20250224065241.236141-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224065241.236141-1-idosch@nvidia.com>
References: <20250224065241.236141-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|SA3PR12MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1bd203-b961-49e3-435c-08dd549ff4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZwyNcwCSaT43gONREItkgWNMmgv0WUV6eO0IVZbksug+9XH+IXK7cs3p2Xij?=
 =?us-ascii?Q?w0uA0cZ9pD2jaEjwaK6g/+drUkqu7VycA5HpY8L9CkgPfugvkQ1qmJnlnqsQ?=
 =?us-ascii?Q?AS5heYImgAtuNXzyzFYMvQsoyJmmo0iDXN4Lhr+B+/7W2UTHmYXI4eX7vAN2?=
 =?us-ascii?Q?nGXXGTa/2L95z9P2mHVoLJ4cURrYuMP2L7V8LAeWq5k2/iTdMUuscQhNsgAX?=
 =?us-ascii?Q?lf1KJ13bZORdmpoU5/wQ6mfmzoASjlacpM6bhyk2CM6eSuqFVNMmhKP6iyKS?=
 =?us-ascii?Q?1iJEhNf1lqQZZ+u0oho/oCsQsWF1vNK9CfYVbo3e1oEaKQ3PrKxNMjaRgQ8k?=
 =?us-ascii?Q?1AsCFfBg0fDKODY+jns37a7Q//o1EOuLArURtHLSa1iHbZSLRlnFHgd825Wm?=
 =?us-ascii?Q?7Uxpj5WPoTOQTAhZDvVurxslbBoX/1ywgo1+uT7RplmZfjKjbPBzBTwjiK7z?=
 =?us-ascii?Q?159aEASnPdEBvExADR0BCGHW1MN4z2e/sxjtfAPQzI7UxnevBvddK/Wo8UeB?=
 =?us-ascii?Q?UMW7RdVDDaRr31AesGvNmddQwPq+NlMXn/Y3n+tbpmMBn+IjQZMtCo3ns2xd?=
 =?us-ascii?Q?uQduHJzmB8rrJPNutfQsZYhhyvTSifMWUynaWiis3NwutICiKQ0YMrxm5Phh?=
 =?us-ascii?Q?XjK3iJlcIRSne5g2uQmUFC/OydSsdkOQOFzmsbl5R4XryxPBW7dDTUxbBHGY?=
 =?us-ascii?Q?q0tPMUTAFedWVWiAu7Qa+3s4cUb5ChwNtBJ2yZOwize93npl+6V6iBR0pwIz?=
 =?us-ascii?Q?r8ieAV+NuNxBBnly8CTv9O/GpSHlnR9J9bDNASOk7TwKV/2obgQ/EYXacWjl?=
 =?us-ascii?Q?zvJk1oEc/pLobpkVugSde+8AKu1rbzRCzBToGmfg0gi13BHJdlD+Cj06AaYI?=
 =?us-ascii?Q?pu82138bHP/JAneTiHodDjoPgrDqvOXhDk7IPHQFhTMEv8uY2Dmm0CT8gTMx?=
 =?us-ascii?Q?+uoTUjWhknYc0Q6q7Cw9XBqcWQOmGNGIAwxLlgQKT9oNIRwaCwEGlrX9OPV1?=
 =?us-ascii?Q?YsckP30JOgWT5wu5nwOsVNjqRauDEBhXdzaEO0tXtMyewAq2AqR80sWPb1YS?=
 =?us-ascii?Q?TlXBa+pKMVMVJC0vcLNIN68VG7ed6dmETnQOk/D9SigT75XvLsD3O8VNcM2P?=
 =?us-ascii?Q?B/6ibf+ZSJUZi6wkZKidlC09x275aQK7aD8JaMKfUHevl8FHqqR9wnvnB5f/?=
 =?us-ascii?Q?Uoju/I3Uva+Zlwrzf/9ediTlccpsrQy6D4JwOuP5mDTEq/I0u+YfNjHHWJHv?=
 =?us-ascii?Q?pAW9F+CAmPfn6Tej8pA9Vpj+LqP21DdhDhpsJsSCzgOVfc9VkKTfVvQKFbUN?=
 =?us-ascii?Q?d22dzR1USS3XoDQaBcF4MjILe53ODfwUPZE07tB5R4rHmvfaevd8ESnsIShM?=
 =?us-ascii?Q?s8sk8tzchPbwwH6+Ky/HpuUwGswJt42LhQ4Hyhb8UX0Uga76tGAMUhPpoch2?=
 =?us-ascii?Q?IHbcEE2gFEs5pG0T4InDqyMZJhtxQLwdr1HcK1qIGwZvMMR4iH5eqesQKHre?=
 =?us-ascii?Q?ld0a6T2vraiZg9A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:53:34.1556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1bd203-b961-49e3-435c-08dd549ff4fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951

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
 ip/iprule.c           | 103 +++++++++++++++++++++++++++++++++++++-----
 man/man8/ip-rule.8.in |  14 +++---
 2 files changed, 100 insertions(+), 17 deletions(-)

diff --git a/ip/iprule.c b/ip/iprule.c
index 64d389bebb76..fbe69a3b6293 100644
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
@@ -617,6 +673,21 @@ static void iprule_port_parse(char *arg, struct fib_rule_port_range *r)
 		return;
 	}
 
+	sep = strchr(arg, '/');
+	if (sep) {
+		*sep = '\0';
+
+		if (get_u16(&r->start, arg, 0))
+			invarg("invalid port", arg);
+
+		r->end = r->start;
+
+		if (get_u16(mask, sep + 1, 0))
+			invarg("invalid mask", sep + 1);
+
+		return;
+	}
+
 	if (get_u16(&r->start, arg, 0))
 		invarg("invalid port", arg);
 
@@ -770,10 +841,12 @@ static int iprule_list_flush_or_save(int argc, char **argv, int action)
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
 
@@ -1043,18 +1116,26 @@ static int iprule_modify(int cmd, int argc, char **argv)
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
index 6fc741d4f470..4945ccd55076 100644
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
+select the source port value to match with an optional mask. supports port
+range.
 
 .TP
-.BI dport " NUMBER | NUMBER-NUMBER"
-select the destination port value to match. supports port range.
+.BI dport " NUMBER\fR[\fB/\fIMASK\fR] | NUMBER-NUMBER"
+select the destination port value to match with an optional mask. supports port
+range.
 
 .TP
 .BI priority " PREFERENCE"
-- 
2.48.1


