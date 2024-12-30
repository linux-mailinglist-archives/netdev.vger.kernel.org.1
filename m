Return-Path: <netdev+bounces-154506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEDE9FE3FE
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 10:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0134F7A0836
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D9C1A23A8;
	Mon, 30 Dec 2024 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CZdtrAoY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600B1A239E
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549182; cv=fail; b=KSAtCwYBVQAUMMaV4xFJ4erHj7C2JzaDhQg9WtU6cc/DrzSNJn2zaM1PZl1y0BJHs2BrYGsWTY8qxErDrK8fNP1OmGFHbzflJcZoTh7+EGq56epDNm26P8Zyuuk9wYj15sNX+odDKGN60WDew23u+qarbAkgE6dczuAENYYUyI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549182; c=relaxed/simple;
	bh=cFzJbgkEeg2c9r21Ub61Xbr3XWVZmzxzJbLCgd5PXmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ey8dw3j4LCcKuy2J6oEH8kYP5/WQdCyjTodAZx0COt6kQ41yC5ltZpAdYJRs4X5v/QNe1/rzBsOdaE0MxHYmwhaLlFcYnMShaavBRlahC33qx4XpSTlu2eXRaHxstV636MM/AKCtJ5Nr5e1m+PNZDnqMBe5uYhHeul6SfwQCK/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CZdtrAoY; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLr4ecxBbMWcaqxWP+TWmuJ2s7LIiL9I58YnYpZSWb1dSs4TfuVAkO1fYFZaznzwe5F19nGvfzSnHdpOuvfDqwbzsp6AowtP8K049Ccw02ONUWhhcg7chKMOX4jTCoPrptU/aqrdnNxW0Pgz0OaK5JNjBp12Ptr3BhxTI3cfzB5sOYt8lVOR3NnqlmDE7lyrw062eOgFACun2gSevEFCWJutZlWnjtRtICpqOWlRx/tYgD1H2RuhfCfRRLgI20WtvF/DsIUVb4GZuE5PxYNRCXk9tUfinoBf4avwU9Z/1fMlFmrV66hF4/+iYD7Za8n/uNQfuDes70Besd+1IMUFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lEyPvPXUhOzictXE4A+CSqPmZUcmArk8LelsmVHiXY=;
 b=gzesNDM2i2G3PEYqyLFwcxdq8GNRZIC+uASYCz0NLgbMPlmrquGENVHBz9D6b4wP7WR/e9gjSh6c0wK4pERQ5ON9XOfYNaMnuUmqtbvRelK+GKx15uldoeHVyhFnFMA2q33vgzXT5I72AkU4zBYFJpUTIo8praWEKkBum+N8gLLZLTgNsACrUbTkDfTN0GucOYhMnEavGS6seD/HlNPJ1h6Ql0M0qnfKpDBvk5hy3q/Kw+PmOexTjZm68ARGsV4Tpcn4sqxbNmVgDLnXtChy/fSJYBfEpJ//GBOLHTp4Nxki3J4aFPFd4nzoiAjzhsZ/lZcgTFAebsGtj/S+LOHGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lEyPvPXUhOzictXE4A+CSqPmZUcmArk8LelsmVHiXY=;
 b=CZdtrAoYzuyVu+m06O5p7cfNetuvFVZb16Mg1q8FC+tgUhFotcnbdK7uS56bquycNrxUFLQztEapTZUK+Wbj7rm/lgj08GtQo0Ml6MRMB7qCbJlTE0ltuTYqy+nxYxecbLLQx+oh1Uow6FbQtHdn8LaLPhrdfqAweREYf9vBDlVFUrgwcGR5pszVh30HDFita0QJUcaXOuhj/R7YdIBnMNd66lq+kn61KpmgIvlJcFtcxkQtRQWUi4imgjyobpYEU8d+iTHhE12ndvV6uuWkSI5JIEw67+UlzUptTPcdy2RM9P2uNHLYq5hcfs3o+NyYThALrXYXDHsG8/p+A+rNjA==
Received: from BN0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:e4::19)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 08:59:33 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::e8) by BN0PR02CA0014.outlook.office365.com
 (2603:10b6:408:e4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 08:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 08:59:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Dec
 2024 00:59:17 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Dec
 2024 00:59:14 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <petrm@nvidia.com>,
	<gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next v2 3/3] iprule: Add flow label support
Date: Mon, 30 Dec 2024 10:58:10 +0200
Message-ID: <20241230085810.87766-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: faefd1db-6425-4bd4-6282-08dd28b04725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aa/C2Gab+96ljRJQU3AkojBv8ePHDGNefMoMOpghPnUCFAVWAC3BGgSFVSC8?=
 =?us-ascii?Q?3iM8iCKd9QDw1eTuUx5w9wKlMr0y0zsdTvxifYqPk/eJoBmNMobsyvm/+heo?=
 =?us-ascii?Q?uuzrR1pXLlseQE0R3USMASyTEmDv9bt6fIecI0ypWobKOD/vXimKhvETImJe?=
 =?us-ascii?Q?o8che2K9SL7l4H4CUrJiMjf8rY86xbpX1GzRG3+YfmO8t9hvOD8317bvvtj0?=
 =?us-ascii?Q?N/eHbFI4Z3X6b133tfjT/tIrCV/ewUOHHYZZOpGwDrVUFC6C7+X9OaDyjQsj?=
 =?us-ascii?Q?NxazogwkiBiNOsC8nj4q1F31tChLWHrNJ71CpbVp8X232b5iEDTLOqdji/yy?=
 =?us-ascii?Q?dOPQEuzx0ir+biynPtmLIdW7L6SJSRqz7fq8ruxiA5jJy93GZ/ys1RckTcCA?=
 =?us-ascii?Q?MLFv1p4l1H7JzQkxP/ISPPLsblpJyKp7xuB2TqBS2B1+BcCA4Sh53R/efBMG?=
 =?us-ascii?Q?BHJyIqg5Ik/Qd9gZT9mTOd/jgCH7znFG5LG4O00YFzRN+Xo2XqUu/WldCpZn?=
 =?us-ascii?Q?Kntvi8Q+5lNlO44qrOf6ZaKVamt/CE6RI5OO8nKuze+vDe2nKh9oKAEru0zI?=
 =?us-ascii?Q?lbvT3crfDvbswD56rTE5qqzO7BH2C2B+8gwiTFgnSp1GCzCSiF40Xl1ZecUd?=
 =?us-ascii?Q?kSiKTviEo5OL56972cnysNGkCHrbqkDwxe2wMcxWkdD3m9D405VcBUbL7Jqe?=
 =?us-ascii?Q?YdA4bW5xaXG2DgCGBoipwBAk8DlV6tIS1Q9csbYLFLWABjju43HAlQip3XAJ?=
 =?us-ascii?Q?/lA4x31+bG1jgARKaaS0p+zdcRTpbRNaRcV9s7lfWoPBw49VwRoq0wkKg4/W?=
 =?us-ascii?Q?RnDU+WMUsgm2YQah4XQF73bNwy6KgDE7nqhxgxRAI1XM1RF/9nHMyf+Jxyvp?=
 =?us-ascii?Q?RYqqwlKJgjmvrB6rjUwyrofG214sGRtpsD3xJPxhtaAimqE7dedc5VcD2j3B?=
 =?us-ascii?Q?iR46K2A5+KOirlDfL3k6pL5ILbDwBHVyvhq7WhSuyPQyW5cgdSSU2o0bJ8ce?=
 =?us-ascii?Q?DF5SnblDWNOO3k2PnoCGCX+4Rmd3RuTwYs4BIQktAGuV0uAAaK/PJF7zwCSM?=
 =?us-ascii?Q?9rL9sXCx3NGQtIcfOqkMkKOFKjKuAmfKPbKMDgSCw4RigV9xePxvgY0dXq4B?=
 =?us-ascii?Q?gk9rojcq/oH0cSaALUJta/pElcXgzp9oSG+f0VXYU8w5izOFUwP7qhfHu760?=
 =?us-ascii?Q?HY4+oNjKCGj3mdrtLQYgHH22Dijy5rya6VWmZCKOSZRZeHpsSz2AabGO354U?=
 =?us-ascii?Q?GuAbIGsezWFy5NZsKKE0vstr7WkJYF19Tc7O+vzP+q8f1sDUlk28PA71oEYv?=
 =?us-ascii?Q?KhJigTHsczKzqykGddbHLN/fJHgAyy1G2ZmW2wzTsEG7DTdRPJECuXmhy7gD?=
 =?us-ascii?Q?Db6uQoE0vWLlG8AoeqNOMuMKvrE351YvThD7YDZOx1o8asBu/Jr3kMYMevZS?=
 =?us-ascii?Q?KSOMjD6E3YmuIQqS9dQsi0SlwfHNymuu5k6KxfhM6TQzZKp5qEMJfCW/EdfH?=
 =?us-ascii?Q?Vrs53/bz60IWBmk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 08:59:32.7434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faefd1db-6425-4bd4-6282-08dd28b04725
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002

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
Reviewed-by: Guillaume Nault <gnault@redhat.com>
---
 ip/iprule.c           | 66 ++++++++++++++++++++++++++++++++++++++++++-
 man/man8/ip-rule.8.in |  8 +++++-
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/ip/iprule.c b/ip/iprule.c
index ae067c72a66d..ea30d418712c 100644
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
+		invarg("invalid flowlabel", arg);
+	if (slash) {
+		if (get_u32(flowlabel_mask, slash + 1, 0))
+			invarg("invalid flowlabel mask", slash + 1);
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


