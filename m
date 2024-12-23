Return-Path: <netdev+bounces-154007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD309FAB8A
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 09:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68171662A1
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B5C1922F5;
	Mon, 23 Dec 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JPUcQQH1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB31925B9
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942605; cv=fail; b=px01mR3yVkVFGvivYIHAwHeKVdSuzAI/3BTLb+5XIAxJxrE+7/y0D5+sRTiSXm7DO1bS0GUQP2x6WmSfwrkroXvVgtZy//z1Lq9fM3N0LphzMkuhdGs46MD5X6XERNZh9weDRYY4dWr3c6DD2/dMXp6VYdGJJnCQrE6UhbQrCKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942605; c=relaxed/simple;
	bh=GNiBFIm1mXe/l88qtBnU02HW5yPDIBvjh5hJ6WK2I0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1EUnfiG6/DNawkOOiCT7aKh2JytvCf44CX/n5aRcJL7BHDiVhbgcPmFCcX2SOvK6WJo5VZhWwO+bfQpp90KdY6+WAPQ4c2NIr04y50cP/z7VoPb1X7eMAoCgGqAXoP5BYqgFRvCDv4aoBI/ViqqOPKWZ88SQGUJhzlChbxy/dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JPUcQQH1; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjS9O6j7Vvd5sP95BBgfXUS0uiC9oECEIqDe3weA+8+Csex+63FbNsARe0hbISJxUzFeQMpb57lzK5FZEPpNdZhBynz37HLzYs2RtsIh2Xqv+qiGxVSyVvBdSiFrsg5WfkjhLayAD3WtYkYUl793F3oB2jep0G0oP/u8mTaO8kamtlD+Q/QzQxp6Vn7WvE3Os7MmfxNezegKFgrlmnUVY2gnnCgmHKeKNvBb7yOL5gC7U0vx7ZErmHcS4thBFwRX0XwL7nC9pz+BgrFEwJFpr7sAHS76YMzopQ7a6tg0KxHIoHchV24aCxBf8agPYhPUA2hTSeUN/ObmTkQtAgfmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20H4kODyFWVr4HKY9vpRBYN9FLg8MNUJ1U8jaifYEwo=;
 b=JoGmUQ+CdOzZagMjJZt0Gs08wjUm1TlrRBE5crDlpU5REh/aXLUgtRLLYPbWOSuPoOzAbmZw/t+MRworeBd6DHdW8qHqDS93bohezoqCn9NFuyPd73I6i6bsVNW273XHJmwI4gWMIE9ARif0TonBoa88+pW+UmEFja+5nsVcbBuCEW4icGG7/Q1KpcEGGQDIr7MB3IPE7c5eX3su3Ws/xB9A41QGRoc0+BnbdUwl3guKa6J3L9C1ZuiNeHcsAKJqpkbDVGJMIEC/pA0hAkj7581nIdeAXrz2bPki7b+5V93xyqi3tGQWthc/xskzPsLc1M0zAX2PyeVBmqVXEkuVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20H4kODyFWVr4HKY9vpRBYN9FLg8MNUJ1U8jaifYEwo=;
 b=JPUcQQH1DTGz8lPBG+BIL2exZnwZ+sBiGdISCRUfD7o5ZYv3c0E83F/1SeGNF37gvzijmJGT3O1OMRKmNzFLbUIp8jSC+RM8EtqJ9asw6LCVJJhB8rJKLdvidQHgepbFJIxuQOiClO4t56flU9ewJltv6WYqOL+cZ5yKIIUVr5CJVAHWine7veNy3L9AtjNI9ScIwRflGDA3LIvNRh0FydHjIEhvotj7qk2LOL8vksm8SkzD5CU+UJcXQHPO8k15JIM1VUPRE+hudWgAUWoMeeVf4cdqBtQ6NorAh+O5W0rmkOD+YIBLuALnjRJChi1aGH6C/pu/s8zlXwDNUXBPJA==
Received: from SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) by SJ2PR12MB8158.namprd12.prod.outlook.com
 (2603:10b6:a03:4f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 08:29:55 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:803:41:cafe::15) by SN4PR0501CA0069.outlook.office365.com
 (2603:10b6:803:41::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 23 Dec 2024 08:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.12 via Frontend Transport; Mon, 23 Dec 2024 08:29:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Dec
 2024 00:29:43 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Dec
 2024 00:29:41 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <petrm@nvidia.com>,
	<gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 3/3] iprule: Add flow label support
Date: Mon, 23 Dec 2024 10:26:42 +0200
Message-ID: <20241223082642.48634-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f85e52-1501-479b-d507-08dd232bfaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tXoy8Gqn4IJWxpEljxgQcPw0JO9rRGJ4SUlHAi4egdMb3oOyNRzHX+DPNHVM?=
 =?us-ascii?Q?1UBrir7R+nsQUM+GV0ZYBFVMhZrxCNVH717RxjD/y1OURUZGyclKIDU2Qo66?=
 =?us-ascii?Q?jn+CSR20LMfnhJy2FOziNTuExHdeYzDtOhWCn7CFSxwx7JxHfePiYiT4v0r5?=
 =?us-ascii?Q?qZjN+26XoB9R84Ju/T+TPlp0dtETGRRhQKh+fLBHV613+fggfezton1YFJvs?=
 =?us-ascii?Q?9jmLhCBZj8WMWaPE83WUbvZ6rM0Uk3FdhAbJj9L0jmuPWrv9IgKtjbfn/Uaz?=
 =?us-ascii?Q?UlKpfeyPE2EhoMmb+z6RNbZFDtw8Zb9JDaEJOaU4grsb3kophtgtKRMvOpfJ?=
 =?us-ascii?Q?Seclw15ys8lZkEIqWZStTaG1Qw1d3rvrES5NMLA0kEo+bsPi3pRQ/qJe8F28?=
 =?us-ascii?Q?WwuhD7OtnkiUscVmDJriZYBnW0ViPeLp9e4iDagreebLWUivnmpF1THyG3va?=
 =?us-ascii?Q?o7i6RiZcFEtUuxs9eC0H2GQQcXVd3cMyVopKNoedFxGe7Q2zdZcJPjeFD7+7?=
 =?us-ascii?Q?+bD77jR1rnRNbVPufjOcDhW3lgx34QZJUbj6p0d6DpTfAJa8+gHJ91QQHkh4?=
 =?us-ascii?Q?r1rxJsfZlzF3cKdcMxyeGTo97WYiDHN/M65UTSjVs/B6S+u0LFHtBVSxO6It?=
 =?us-ascii?Q?ruNcXXirTvpjxaJPmahX/1YWBR5lPvh9XbDYOTM5tAqkG0bjDJGIz0DfWVNL?=
 =?us-ascii?Q?5a7ngsP3Dcckq3TUhKmHCiu7S7QnoX2IYjbE4Z4ey3Mpkqk4WRT5rVfUJP+m?=
 =?us-ascii?Q?aKumYwqgA5g2GhN9Uat7HGH86UzeGBbBJm3gma/ZTYZZpsZGTMDYaHN6/yW3?=
 =?us-ascii?Q?jm8CJLpYyhHrfLDv2OklIqEAKHp4pJTz/s05366AzwgEcMk85ihXsq/37uX+?=
 =?us-ascii?Q?JG9uO2Pst+ZyOjJgV8uie2G3tOx3Co86pMVfxbUgH/z6Xc0khd4g3MmxYTHZ?=
 =?us-ascii?Q?FmqTtLelDau+5BUhsY95YZWYN8KT6T6bJL8Sk7aZfWr6B61bilp0v7CUUp3k?=
 =?us-ascii?Q?BfaQ33CpJOboWUnG8/zCYv3ejCXX/q6w5Zm02U7kMp988U9D+F+0akIQKwoo?=
 =?us-ascii?Q?8pX4Evjq7hdgykAi8P9dko0iRU5vUgRgHQyoho0s7SreqSu/5bCNJOjfLd2L?=
 =?us-ascii?Q?bOTijFlM5J0e3veqftRYYcobYo0fgOEdDRToc0Q+mx6x6eyZHfAx8IH1zeuD?=
 =?us-ascii?Q?rAQMPNqk7t7OABoOlD83hE9GpXVDSW3gaLgeCh4vh2fvfTQI8G7vupoenfB9?=
 =?us-ascii?Q?aRYNJl3l72Fm8MX1IaCV+oaBCmuywGNnhU6YBHZJE9VSgCSO442130ig2AGg?=
 =?us-ascii?Q?WJ3uhpuAZozbluhkvsbDelr2JQe9d5ViAzzdCjYFd970GI8BU9l1KoqIoum8?=
 =?us-ascii?Q?wHosCrEzJiFBYSa3uuUjD4D+PqMNJQPrcksCUCRlpb7u+MaITGxg8r1hw4+I?=
 =?us-ascii?Q?4eoeU9AbXeXUR5Hi2oM2bjOshvnE8RWZ4iZnpcjsAIAcrqjvd6DElYRavXZU?=
 =?us-ascii?Q?zYBxXUvtw+az9iU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 08:29:55.0613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f85e52-1501-479b-d507-08dd232bfaa2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158

Add support for 'flowlabel' selector in ip-rule.

Rules can be added with or without a mask in which case exact match is
used:

 # ip -6 rule add flowlabel 0x12345 table 100
 # ip -6 rule add flowlabel 0x11/0xff table 200
 # ip -6 rule add flowlabel 0x54321 table 300
 # ip -6 rule del flowlabel 0x54321 table 300

Dump output:

 $ ip -6 rule show
 0:      from all lookup local
 32764:  from all lookup 200 flowlabel 0x11/0xff
 32765:  from all lookup 100 flowlabel 0x12345
 32766:  from all lookup main

Dump can be filtered by flow label value and mask:

 $ ip -6 rule show flowlabel 0x12345
 32765:  from all lookup 100 flowlabel 0x12345
 $ ip -6 rule show flowlabel 0x11/0xff
 32764:  from all lookup 200 flowlabel 0x11/0xff

JSON output:

 $ ip -6 -j -p rule show flowlabel 0x12345
 [ {
         "priority": 32765,
         "src": "all",
         "table": "100",
         "flowlabel": "0x12345",
         "flowlabel_mask": "0xfffff"
     } ]
 $ ip -6 -j -p rule show flowlabel 0x11/0xff
 [ {
         "priority": 32764,
         "src": "all",
         "table": "200",
         "flowlabel": "0x11",
         "flowlabel_mask": "0xff"
     } ]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 ip/iprule.c           | 66 ++++++++++++++++++++++++++++++++++++++++++-
 man/man8/ip-rule.8.in |  8 +++++-
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/ip/iprule.c b/ip/iprule.c
index ae067c72a66d..f239f91573a7 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -46,7 +46,7 @@ static void usage(void)
 		"            [ ipproto PROTOCOL ]\n"
 		"            [ sport [ NUMBER | NUMBER-NUMBER ]\n"
 		"            [ dport [ NUMBER | NUMBER-NUMBER ] ]\n"
-		"            [ dscp DSCP ]\n"
+		"            [ dscp DSCP ] [ flowlabel FLOWLABEL[/MASK] ]\n"
 		"ACTION := [ table TABLE_ID ]\n"
 		"          [ protocol PROTO ]\n"
 		"          [ nat ADDRESS ]\n"
@@ -69,6 +69,7 @@ static struct
 	unsigned int pref, prefmask;
 	unsigned int fwmark, fwmask;
 	unsigned int dscp, dscpmask;
+	__u32 flowlabel, flowlabel_mask;
 	uint64_t tun_id;
 	char iif[IFNAMSIZ];
 	char oif[IFNAMSIZ];
@@ -232,6 +233,19 @@ static bool filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
 		}
 	}
 
+	if (filter.flowlabel_mask) {
+		__u32 flowlabel, flowlabel_mask;
+
+		if (!tb[FRA_FLOWLABEL] || !tb[FRA_FLOWLABEL_MASK])
+			return false;
+		flowlabel = rta_getattr_be32(tb[FRA_FLOWLABEL]);
+		flowlabel_mask = rta_getattr_be32(tb[FRA_FLOWLABEL_MASK]);
+
+		if (filter.flowlabel != flowlabel ||
+		    filter.flowlabel_mask != flowlabel_mask)
+			return false;
+	}
+
 	table = frh_get_table(frh, tb);
 	if (filter.tb > 0 && filter.tb ^ table)
 		return false;
@@ -489,6 +503,23 @@ int print_rule(struct nlmsghdr *n, void *arg)
 			     rtnl_dscp_n2a(dscp, b1, sizeof(b1)));
 	}
 
+	/* The kernel will either provide both attributes, or none */
+	if (tb[FRA_FLOWLABEL] && tb[FRA_FLOWLABEL_MASK]) {
+		__u32 flowlabel, flowlabel_mask;
+
+		flowlabel = rta_getattr_be32(tb[FRA_FLOWLABEL]);
+		flowlabel_mask = rta_getattr_be32(tb[FRA_FLOWLABEL_MASK]);
+
+		print_0xhex(PRINT_ANY, "flowlabel", " flowlabel %#llx",
+			    flowlabel);
+		if (flowlabel_mask == LABEL_MAX_MASK)
+			print_0xhex(PRINT_JSON, "flowlabel_mask", NULL,
+				    flowlabel_mask);
+		else
+			print_0xhex(PRINT_ANY, "flowlabel_mask", "/%#llx",
+				    flowlabel_mask);
+	}
+
 	print_string(PRINT_FP, NULL, "\n", "");
 	close_json_object();
 	fflush(fp);
@@ -569,6 +600,24 @@ static int flush_rule(struct nlmsghdr *n, void *arg)
 	return 0;
 }
 
+static void iprule_flowlabel_parse(char *arg, __u32 *flowlabel,
+				   __u32 *flowlabel_mask)
+{
+	char *slash;
+
+	slash = strchr(arg, '/');
+	if (slash != NULL)
+		*slash = '\0';
+	if (get_u32(flowlabel, arg, 0))
+		invarg("invalid flowlabel\n", arg);
+	if (slash) {
+		if (get_u32(flowlabel_mask, slash + 1, 0))
+			invarg("invalid flowlabel mask\n", slash + 1);
+	} else {
+		*flowlabel_mask = LABEL_MAX_MASK;
+	}
+}
+
 static int iprule_list_flush_or_save(int argc, char **argv, int action)
 {
 	rtnl_filter_t filter_fn;
@@ -726,6 +775,11 @@ static int iprule_list_flush_or_save(int argc, char **argv, int action)
 				invarg("invalid dscp\n", *argv);
 			filter.dscp = dscp;
 			filter.dscpmask = 1;
+		} else if (strcmp(*argv, "flowlabel") == 0) {
+			NEXT_ARG();
+
+			iprule_flowlabel_parse(*argv, &filter.flowlabel,
+					       &filter.flowlabel_mask);
 		} else {
 			if (matches(*argv, "dst") == 0 ||
 			    matches(*argv, "to") == 0) {
@@ -1011,6 +1065,16 @@ static int iprule_modify(int cmd, int argc, char **argv)
 			if (rtnl_dscp_a2n(&dscp, *argv))
 				invarg("invalid dscp\n", *argv);
 			addattr8(&req.n, sizeof(req), FRA_DSCP, dscp);
+		} else if (strcmp(*argv, "flowlabel") == 0) {
+			__u32 flowlabel, flowlabel_mask;
+
+			NEXT_ARG();
+			iprule_flowlabel_parse(*argv, &flowlabel,
+					       &flowlabel_mask);
+			addattr32(&req.n, sizeof(req), FRA_FLOWLABEL,
+				  htonl(flowlabel));
+			addattr32(&req.n, sizeof(req), FRA_FLOWLABEL_MASK,
+				  htonl(flowlabel_mask));
 		} else {
 			int type;
 
diff --git a/man/man8/ip-rule.8.in b/man/man8/ip-rule.8.in
index 51f3050ae8f8..6fc741d4f470 100644
--- a/man/man8/ip-rule.8.in
+++ b/man/man8/ip-rule.8.in
@@ -58,7 +58,9 @@ ip-rule \- routing policy database management
 .IR NUMBER " | "
 .IR NUMBER "-" NUMBER " ] ] [ "
 .B  tun_id
-.IR TUN_ID " ]"
+.IR TUN_ID " ] [ "
+.B  flowlabel
+.IR FLOWLABEL\fR[\fB/\fIMASK "] ]"
 .BR
 
 
@@ -322,6 +324,10 @@ In the last case the router does not translate the packets, but
 masquerades them to this address.
 Using map-to instead of nat means the same thing.
 
+.TP
+.BI flowlabel " FLOWLABEL\fR[\fB/\fIMASK\fR]"
+select the IPv6 flow label to match with an optional mask.
+
 .B Warning:
 Changes to the RPDB made with these commands do not become active
 immediately. It is assumed that after a script finishes a batch of
-- 
2.47.1


