Return-Path: <netdev+bounces-169363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B9EA4391C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B909C161380
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CC7266B7B;
	Tue, 25 Feb 2025 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kP6oEJmt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA824266B73
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474665; cv=fail; b=kQHBtlXxsMZXGNeE2NAO0R7LXGKTUYvjTAVGeV+20BHZ+mOW9S7r+gy5tc1pMmEAIyAQIAaxKHY26ZDHQUmXOhP6qOaaLeokl14R3Yyrej4aNGQ8Cb2a09HkQeS22cezed1pNnaTfWksXRqWZn5Yaxf1jm1+V/t6xeDXaJpn0+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474665; c=relaxed/simple;
	bh=fupC4esfworhHEjmPkpqPHZ+ad7YpnRxCEa9pkavoEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQ5KXYl9UKJGsMnQUWm7MJvauQokOyy4Kb22EXEzr+9uMxvDFaiw81+1PqcbmV6JGSqm/sjemZMQbwbU2tID95ZxmbWpi4ZMV3R+rmegUBnXv+2AA5rCqL4SNqrRd0JoK4yrGd7p4yOi8rJv000Vhl00DGLp7x0JCJ3GHdiLSQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kP6oEJmt; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXVH5fWsdR9Na6oiR5eUm3pOSL7BDR2dynWpccR4WDVYQk6JzW50BtPSl+qB8X1ek9MOacDi9iwDGdXiMDkHTxZ/2mCYK7GBY+HggUzNTmnzT5tbyfUjTG1ZlG/qen/Lh+m7iNIB98L+dZuhzjB3FkESfWJqxwC/TBYuJaK3e9qpiBvBD8KLzBZnub7SDg0+3lR7O5iFU9LSI7RtFaEWw3SvMbVnwm/acgXoc4q3SXmQWm7ZrkJXf6Kydgyy/gqDaYhkfhuoBNUz4CBWpjb6n7SqHyphWwWX0Am+icqy8nHON7eRQI9KBPmuroi+kc05QFZfh45LkHGuClmBnuBgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MERM86zKVjL2yeSEH1F8dUjCdME2aIigL7i9ig4xj4s=;
 b=G0dpnfzINMC+ExJfeu9BS/at7u85asfHRnx6acftkysqL/JosPY88KZlV4XgPXffHvOl57lyy+s+H/ZU2N9r4K9piGNpjsL0kTQlPS1v4LYQzdM2DZYmjGHuGo3M3KmK7LdlVLxP6wmOGOZKTmxceLeE/Kk95Rt6h4KuRmsF0N5zSkXPrCyYJQ/4sqP7PXk/FfZV+To8Cuzk3R4fLN+YscDWaINUHzXVTXl0JlXSN7jDc5CFPV2AsPzVGyw6rpC+Zg3CYocqsleU1rrtfDrho6VKmX4vmAZ3+OGd3VQdAGBYnLtaZb0i26nUH0+NWHLFlOlPzHuto7ugovNS1VqfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MERM86zKVjL2yeSEH1F8dUjCdME2aIigL7i9ig4xj4s=;
 b=kP6oEJmtX5xob9CCbuLWFu6jTdu6aXNO1SW/3tKvE7G1ZNsUMVhn4hNfTCDo8FZZi7uqOUFHOvytcru9zmritTePX5fro4OXd8ce7PpTWpNn20c85FCu7Y/ygRT8eEtwlINh0QFhlxoxVOyxKHIWHL60q+kkbNsq6QQ7IXwLaPI5y7iwgUm5WVQWFVNOodSK0e+jj6toJohsgsPc51FIgBy1ZCXdXwYy9v2SnuMYCxL6vGJwsDEmqvHup7gFiSuX299wApmsALp2XYeso+InPkQQfCEo73vkVT8gM/fmIrEBAQYv68/L2ym9m8EXibITV7fN+xqncMn3G4UHTyH6uw==
Received: from BL1PR13CA0397.namprd13.prod.outlook.com (2603:10b6:208:2c2::12)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 09:10:58 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::44) by BL1PR13CA0397.outlook.office365.com
 (2603:10b6:208:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Tue,
 25 Feb 2025 09:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 09:10:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 01:10:44 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 01:10:42 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next v2 2/5] iprule: Move port parsing to a function
Date: Tue, 25 Feb 2025 11:09:14 +0200
Message-ID: <20250225090917.499376-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e48610-83fc-4b29-202a-08dd557c516a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LVZ9cin/0Fkl8A7Dl7seE3ynLCvxW9tAMK7Zr242vJNDWlNrWwLhlEfIMQcP?=
 =?us-ascii?Q?zSQPDzocNQcxvxSiq3Vs6riVGa9ixDzjWeAx45ZiL94+a1eIzfCvkW3KG357?=
 =?us-ascii?Q?nlBCk+TUPBPLYHXZnoQQOfwop/MaOGaMUn6NSM+4FRHM12kvw3D61H70zIux?=
 =?us-ascii?Q?gmwQmMH0zd5n9b5EA6iXIYPiHzXCjFETR3ikAcdDd37d/2vXTWL3+UJog5ZP?=
 =?us-ascii?Q?/WOgXkwAMck//4MDWNJD7MtblpK/HmPCfTDmvG9oRIzB2zlqsREmSHc/OeFJ?=
 =?us-ascii?Q?C+/n5BBEPd3shqVPoFah3kEkgtD64zOGsBLOeLFhsmSlTTIfRe37osgW+wTr?=
 =?us-ascii?Q?gOUEDWAOh5zM/CLjBdjOM6zlhiMnAByJAfzZv33gWnk19xjaCyTIFRPREdu/?=
 =?us-ascii?Q?BHRKeB4PqS+xBiLb7h2+1kiMr1ov70N1cLnOXTVVwWbCmniAiQPzUW8I0rYk?=
 =?us-ascii?Q?/GGHjwPbj82IAYFYnbew60olimrJ6TxspOHuc5KEy2f3jYGJ1Du6zxCCSO8V?=
 =?us-ascii?Q?YH3IBjy4wdOL9D9g9qEW24D67lr2K15fnr6vr3XIvnvlSkSzBCBbumN5K2eN?=
 =?us-ascii?Q?i1vngIcVgpUyZgEbRP+rIADVAgsSECzZX1LrCKMH1wFSu3mGYSv40O3/yNV7?=
 =?us-ascii?Q?EfwGa0+2PI1Wd+1WO0XFJekjllRJ1igIwuwI1Jx3MOFAjvSH7tfXaJ1QpiQn?=
 =?us-ascii?Q?nD2LTKmyf7dj6TUAH3FxvYpFSeDvj3J9RMpnyoqEqgHrmnMuzaznV5besE2k?=
 =?us-ascii?Q?U7bvOeOosVIozA1rCMCU4H2ySgE009gb2g00FxP4FSI0Acte4dtAXfebknYc?=
 =?us-ascii?Q?u5PTm6oIODtea86Ggyq1mDXN7nvHPuVE8x7JYsxo1XDxA8Jveiuk5ObGbYzO?=
 =?us-ascii?Q?//2Q9KtqCf1JfVhjeI5lvfs3yyx6cim8wmJ6kaCMkbR10YdV6xZz/UXErJcQ?=
 =?us-ascii?Q?m0XZ3CzTRyoraSQRoI+SES5SRjhkQ8e3eIIyfdKWwBYKh+evIe4OCZVd+QL6?=
 =?us-ascii?Q?LcI/tnwj8zR0SbgpGmc0I57EWPJbzFmEY33qP2CKx/8DcimXGvOixGdMnG69?=
 =?us-ascii?Q?unZz+BdAnnDIqQpsjDS7lKMeMdHYC9SYh5QBVatinzK7WLsU2Jdm9p5Pj0lT?=
 =?us-ascii?Q?PqtVpioqpjJnhYkXsMIzb+3jZcbmTLXuySsUB7kbn2ZYmqdBWcRBSiV7u0pN?=
 =?us-ascii?Q?9SE4OTsIpzCqDgLnuZXPZk6bzMpZau4htGJMD3jKvAtSbUWCuNoiQXyet3bW?=
 =?us-ascii?Q?LjsljOWOqDmT7ATRyNsl9xi8vcwHpIdQZckLqEP4aK9hLhS/38TcVLPqZC4k?=
 =?us-ascii?Q?CeDJvF0jXXG+3ywDSGpVY9/GNg2uD7QsvfF1ZZv11Oa+XonSZYFe1nF4x6DD?=
 =?us-ascii?Q?4tSUc2FeBGc7JM1g/sSXPUTdlWDKvlDNe8+9rGShJ4r8RwprQHhegEz+Xw/+?=
 =?us-ascii?Q?WHFK5AGb1fEbZM0tA7uMJLrLW4omXAl3vb2RoYE8TQ9nHOXrI+R2DFTek+WP?=
 =?us-ascii?Q?TcIuor1KOcr5LL0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:10:58.4506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e48610-83fc-4b29-202a-08dd557c516a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

In preparation for adding port mask support, move port parsing to a
function.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 ip/iprule.c | 57 +++++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/ip/iprule.c b/ip/iprule.c
index ea30d418712c..61e092bc5693 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -600,6 +600,29 @@ static int flush_rule(struct nlmsghdr *n, void *arg)
 	return 0;
 }
 
+static void iprule_port_parse(char *arg, struct fib_rule_port_range *r)
+{
+	char *sep;
+
+	sep = strchr(arg, '-');
+	if (sep) {
+		*sep = '\0';
+
+		if (get_u16(&r->start, arg, 10))
+			invarg("invalid port range start", arg);
+
+		if (get_u16(&r->end, sep + 1, 10))
+			invarg("invalid port range end", sep + 1);
+
+		return;
+	}
+
+	if (get_u16(&r->start, arg, 10))
+		invarg("invalid port", arg);
+
+	r->end = r->start;
+}
+
 static void iprule_flowlabel_parse(char *arg, __u32 *flowlabel,
 				   __u32 *flowlabel_mask)
 {
@@ -746,27 +769,11 @@ static int iprule_list_flush_or_save(int argc, char **argv, int action)
 				invarg("Invalid \"ipproto\" value\n", *argv);
 			filter.ipproto = ipproto;
 		} else if (strcmp(*argv, "sport") == 0) {
-			struct fib_rule_port_range r;
-			int ret;
-
 			NEXT_ARG();
-			ret = sscanf(*argv, "%hu-%hu", &r.start, &r.end);
-			if (ret == 1)
-				r.end = r.start;
-			else if (ret != 2)
-				invarg("invalid port range\n", *argv);
-			filter.sport = r;
+			iprule_port_parse(*argv, &filter.sport);
 		} else if (strcmp(*argv, "dport") == 0) {
-			struct fib_rule_port_range r;
-			int ret;
-
 			NEXT_ARG();
-			ret = sscanf(*argv, "%hu-%hu", &r.start, &r.end);
-			if (ret == 1)
-				r.end = r.start;
-			else if (ret != 2)
-				invarg("invalid dport range\n", *argv);
-			filter.dport = r;
+			iprule_port_parse(*argv, &filter.dport);
 		} else if (strcmp(*argv, "dscp") == 0) {
 			__u32 dscp;
 
@@ -1036,26 +1043,16 @@ static int iprule_modify(int cmd, int argc, char **argv)
 			addattr8(&req.n, sizeof(req), FRA_IP_PROTO, ipproto);
 		} else if (strcmp(*argv, "sport") == 0) {
 			struct fib_rule_port_range r;
-			int ret = 0;
 
 			NEXT_ARG();
-			ret = sscanf(*argv, "%hu-%hu", &r.start, &r.end);
-			if (ret == 1)
-				r.end = r.start;
-			else if (ret != 2)
-				invarg("invalid port range\n", *argv);
+			iprule_port_parse(*argv, &r);
 			addattr_l(&req.n, sizeof(req), FRA_SPORT_RANGE, &r,
 				  sizeof(r));
 		} else if (strcmp(*argv, "dport") == 0) {
 			struct fib_rule_port_range r;
-			int ret = 0;
 
 			NEXT_ARG();
-			ret = sscanf(*argv, "%hu-%hu", &r.start, &r.end);
-			if (ret == 1)
-				r.end = r.start;
-			else if (ret != 2)
-				invarg("invalid dport range\n", *argv);
+			iprule_port_parse(*argv, &r);
 			addattr_l(&req.n, sizeof(req), FRA_DPORT_RANGE, &r,
 				  sizeof(r));
 		} else if (strcmp(*argv, "dscp") == 0) {
-- 
2.48.1


