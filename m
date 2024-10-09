Return-Path: <netdev+bounces-133457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD2F995FAD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8398281C2E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 06:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5591A17ADE8;
	Wed,  9 Oct 2024 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tcWpO0Xg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EFE154430
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 06:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454907; cv=fail; b=q6Ssbx7vbpzijKgr3mLkdJQw44LWnZfzHC+c8hB5d8h7fO7xi+Y2zlq6cmFUIYuNSy/GA7FWw75emRZmlGb2HuI3HtRKRiLuf9ju1sgwvN1e/MtPQJIylPth9qPnelqqt0CijQhhLp8oE1KkSsipdTHJS6XEkT0mrwbgxoEqNXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454907; c=relaxed/simple;
	bh=qQ+Mnve5WlVMTKlOImLyYdURcYvVuIGJceZ70t+Y6Ds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVpV0fRAP7wl1tnhmXayUa/zRBHXYWPyO0onLO0wUZTYNh562qcbnX+knECT2V4f2n5bZwHxYCmZ8JON0HUaGJ1mUIIHmb/cGQhfW4aQROUgpLTuPLXkHRvRfebFvpNLmaTwjDt6srL3P+pCRjbdrZoYERB2n/b1nUHC7ioQGbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tcWpO0Xg; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSu/7cl9d2ZWK4fPwOQM4z5q/VIoJ9H38+WaphXwMbTBa9AX2ha4Nd6uwcrjQH8aAt6wzsW4GxZ2TCm9qrTv4XXuC97f2T7Cc4VBQ9IFxt9FYyE/JrDpXmgQIwRs+UdWkr1d1PXnCSV+PBwd4HdR0qPvwdBB/yMwP3biZ+ZpD93n6dMsZATFEAHtMy+cUET9tKtq/VbXvOpcKyxt4SYY2x7idGolA1DOmhipwecgrYNmhTYwSjhvVipv+uzFrWAZsXAStLvjXXabjhR+kq6CMJBStzoZFo8LsyyEKpYLh9TJuogLikgo3zRY8FkDqJZLrt8pYlYn4W+RDTqydM5qHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KutYbeJavs1NGXtMnfbp9/JByNeI5wZB/7N6v9QLZVM=;
 b=Q9XvqrIbPkk/akNHvEKXoaBXEPbzSfGtPTXvwzkleqztaqAcoc0V9ylg7hygcj4bDCS1ChVbGehA4uBCCgHxos6vW0tPU9hsDd3nC5k0DuZ5USweKQUw34Vbdwt/SMga33WZBONxKH5MR4CHTR6RFPlp0TbXR8EGLNYWcWGe2Isfeh71VLYu1gNWShuV2aWqHGVxM9YU0yWPEIFKyiFS4t65LqkJ0xhdmV81CebxISpoMrJ0EzowwB3kw8diQmDKh8HQyLi5bY1LV4o5mw5DfxRLcAUiFec3+LeU+IDTL8cGP9vEs8P73jlUppbJD+vT1E2ZS1Yu3ePD1ni0ZgKaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KutYbeJavs1NGXtMnfbp9/JByNeI5wZB/7N6v9QLZVM=;
 b=tcWpO0XgZG15D53nOKHFZGwNObrkio4AU1+RsIjL3xH/el50PYb+PGl+Y5p8eQ3PibiRtOII08zKioEe9lBLRT4ofX4eiUqlyg/AxEj/xGNttcsqdEQsGczFW4nVBajXILAX+SPY4FxGV7k6nFEijpJJJGI0bUzRisasmb/ybPeWA9xnjo7b/UItJF/7xi1t3vYohmD2MgPjxdoftFv+f9dTW3DET77JciNO+MklcddQrdiD5KxljCkAM8/nUphnN3WrYx+dYGW39zK8AOVkb+frSuL+fhvXG7jhGjRASTnsJlm7h36Ap8S6xDyeWu7sLtHc8VNkaIdFwawLEA0qNQ==
Received: from BL0PR02CA0121.namprd02.prod.outlook.com (2603:10b6:208:35::26)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 06:21:41 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::29) by BL0PR02CA0121.outlook.office365.com
 (2603:10b6:208:35::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Wed, 9 Oct 2024 06:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 06:21:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 23:21:21 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 23:21:19 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 2/2] iprule: Add DSCP support
Date: Wed, 9 Oct 2024 09:20:54 +0300
Message-ID: <20241009062054.526485-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009062054.526485-1-idosch@nvidia.com>
References: <20241009062054.526485-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: a0930b3e-435d-455e-eb52-08dce82aa3d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GkEwwD7ZzM0ROapwHsguaY2nQWqEUMtPBx/Pi9wp7TkafoesRtTXbkjbntHo?=
 =?us-ascii?Q?n+F5rdBM8RwZhYK6am1sYT1M2kZ8qMwVTE4vIuURQp/j01XWGxu9n8SxR5aQ?=
 =?us-ascii?Q?93o8QgEZids3FJRpK6mAm/lVZRXOmmHYeSra+Dw3kGQZ0f95PXke5wra9Op1?=
 =?us-ascii?Q?THRyrbrkr8pK22RN0afCj1s6M+7YKl6wlpJvpcQl7BCdeufgzbNsP44nPats?=
 =?us-ascii?Q?7w3iltec3kFvdn+N6ScaU+3HyGM7+EUut+8uDEKC7h4z7F7Uh+7sfzNso06U?=
 =?us-ascii?Q?PtCyN5x7Xw6I06mko9611swgk1p5CVyoMjP3+inu1K+dEviXIWZPZeR5Qwk8?=
 =?us-ascii?Q?DwNmPhYiI1altVIWNouo8DDngD1JQN+rBrhjN/wolbukkolrN69kgzkFcZKY?=
 =?us-ascii?Q?z9BVdOwbho2Exyc8v23CJgEGwyHUkToKE9fmAY8m9Xtf4MoFzJ0VQG9Gt7rK?=
 =?us-ascii?Q?YFO6hDYf5cAVEaDdnmvKhO7E4afqI3+SKOxonSwPnJNNrdy7Kp1//VyHF0f8?=
 =?us-ascii?Q?p8dMagKLkMEzOjl/guklGCtUUikOny2OFF7mJzaocSDdUoPeRTqQkQs5Q7ya?=
 =?us-ascii?Q?8p2NwrWldkN6LZiWlcOzrDs4N+lKe7nnkQVGMFW/gxw0bKCQuQE+8bY2XtQT?=
 =?us-ascii?Q?GPO7JMGal8wPw2nRegHcM4iOtCPKY3GMETOCon2gmX4qWtintWEUFNK8scDZ?=
 =?us-ascii?Q?weZUpxIBRfgBxKeT4hHrm1UqYSok22gmLm7IuS/wEy/0fn3LcQY7Okffk4mA?=
 =?us-ascii?Q?E4SvzyyoE4ksPj2UjWhaoLby95Z71/GUz67+DEYgZz+v+3a0uSmOEAJiZwRB?=
 =?us-ascii?Q?lSfehWbtVBjVqHOqJ5Ci2qvhoDICNeZ5MrWJIEunYqTT3BZAfOdyzNZ5Xtl/?=
 =?us-ascii?Q?re7TzR4yM2jO0b4bcunFuZGt3p3mfMtmQ/NTV0NWsJnssKccWhJMV87MdzIi?=
 =?us-ascii?Q?y9J1EMhIzu7aToPj4Gf3ew22l7MmyKD9ScQQyIy+lbUy+Cf1Fkt9Xxx/jQxm?=
 =?us-ascii?Q?+t6fJAhU+KJ6FybX6IXuV0qiSdKegFyOs328sVw2+E0BrWChesUz64KoPP/j?=
 =?us-ascii?Q?Tkm5CN/sn47aEobNT3VbD0kPc+kghe+MBvF0gRgUnnFMWnZI10+8sBjUg7xr?=
 =?us-ascii?Q?T0AzRlgPwM/NLq0KZKiG62QHHA6mBd1ssoeSGYQrvWa66tku7hdzf6IIwgeY?=
 =?us-ascii?Q?G7lNEZw+CxtHNH67R29POpEVQTAiqpjt9svJYzv8jti5tymja81NYIMr+E2a?=
 =?us-ascii?Q?jFIiJLxMf6fgrm8cxm6NaQEVQeH+0QH/cP+vGwGCZGU1wm9DSX+H9J/QIqcu?=
 =?us-ascii?Q?ZSOWhr+OTmcVrW2Tua4jBml2X2fFt+UHm5iAxWj7xQYYr2fmIHn/dEmlh2se?=
 =?us-ascii?Q?rTK1Pro=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:21:41.3065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0930b3e-435d-455e-eb52-08dce82aa3d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993

Add support for 'dscp' selector in ip-rule.

Rules can be added with a numeric DSCP value:

 # ip rule add dscp 1 table 100
 # ip rule add dscp 0x02 table 200

Or using symbolic names from /usr/share/iproute2/rt_dsfield or
/etc/iproute2/rt_dsfield:

 # ip rule add dscp AF42 table 300

Dump output:

 $ ip rule show
 0:      from all lookup local
 32763:  from all lookup 300 dscp AF42
 32764:  from all lookup 200 dscp 2
 32765:  from all lookup 100 dscp 1
 32766:  from all lookup main
 32767:  from all lookup default

Dump can be filtered by DSCP value:

 $ ip rule show dscp 1
 32765:  from all lookup 100 dscp 1

Or by a symbolic name:

 $ ip rule show dscp AF42
 32763:  from all lookup 300 dscp AF42

When the numeric option is specified, symbolic names will be translated
to numeric values:

 $ ip -N rule show
 0:      from all lookup 255
 32763:  from all lookup 300 dscp 36
 32764:  from all lookup 200 dscp 2
 32765:  from all lookup 100 dscp 1
 32766:  from all lookup 254
 32767:  from all lookup 253

The same applies to the JSON output in order to be consistent with
existing fields such as "tos" and "table":

 $ ip -j -p rule show dscp AF42
 [ {
         "priority": 32763,
         "src": "all",
         "table": "300",
         "dscp": "AF42"
     } ]

 $ ip -j -p -N rule show dscp AF42
 [ {
         "priority": 32763,
         "src": "all",
         "table": "300",
         "dscp": "36"
     } ]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/rt_names.h    |  2 ++
 ip/iprule.c           | 36 ++++++++++++++++++++++++++++++++++++
 lib/rt_names.c        | 23 +++++++++++++++++++++++
 man/man8/ip-rule.8.in | 17 +++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/include/rt_names.h b/include/rt_names.h
index 0275030704c1..a5c73f3872a3 100644
--- a/include/rt_names.h
+++ b/include/rt_names.h
@@ -11,6 +11,7 @@ const char *rtnl_rttable_n2a(__u32 id, char *buf, int len);
 const char *rtnl_rtrealm_n2a(int id, char *buf, int len);
 const char *rtnl_dsfield_n2a(int id, char *buf, int len);
 const char *rtnl_dsfield_get_name(int id);
+const char *rtnl_dscp_n2a(int id, char *buf, int len);
 const char *rtnl_group_n2a(int id, char *buf, int len);
 
 int rtnl_rtprot_a2n(__u32 *id, const char *arg);
@@ -19,6 +20,7 @@ int rtnl_rtscope_a2n(__u32 *id, const char *arg);
 int rtnl_rttable_a2n(__u32 *id, const char *arg);
 int rtnl_rtrealm_a2n(__u32 *id, const char *arg);
 int rtnl_dsfield_a2n(__u32 *id, const char *arg);
+int rtnl_dscp_a2n(__u32 *id, const char *arg);
 int rtnl_group_a2n(int *id, const char *arg);
 
 const char *inet_proto_n2a(int proto, char *buf, int len);
diff --git a/ip/iprule.c b/ip/iprule.c
index 81938f2ed80c..ae067c72a66d 100644
--- a/ip/iprule.c
+++ b/ip/iprule.c
@@ -46,6 +46,7 @@ static void usage(void)
 		"            [ ipproto PROTOCOL ]\n"
 		"            [ sport [ NUMBER | NUMBER-NUMBER ]\n"
 		"            [ dport [ NUMBER | NUMBER-NUMBER ] ]\n"
+		"            [ dscp DSCP ]\n"
 		"ACTION := [ table TABLE_ID ]\n"
 		"          [ protocol PROTO ]\n"
 		"          [ nat ADDRESS ]\n"
@@ -67,6 +68,7 @@ static struct
 	unsigned int tos, tosmask;
 	unsigned int pref, prefmask;
 	unsigned int fwmark, fwmask;
+	unsigned int dscp, dscpmask;
 	uint64_t tun_id;
 	char iif[IFNAMSIZ];
 	char oif[IFNAMSIZ];
@@ -219,6 +221,17 @@ static bool filter_nlmsg(struct nlmsghdr *n, struct rtattr **tb, int host_len)
 		}
 	}
 
+	if (filter.dscpmask) {
+		if (tb[FRA_DSCP]) {
+			__u8 dscp = rta_getattr_u8(tb[FRA_DSCP]);
+
+			if (filter.dscp != dscp)
+				return false;
+		} else {
+			return false;
+		}
+	}
+
 	table = frh_get_table(frh, tb);
 	if (filter.tb > 0 && filter.tb ^ table)
 		return false;
@@ -468,6 +481,14 @@ int print_rule(struct nlmsghdr *n, void *arg)
 				     rtnl_rtprot_n2a(protocol, b1, sizeof(b1)));
 		}
 	}
+
+	if (tb[FRA_DSCP]) {
+		__u8 dscp = rta_getattr_u8(tb[FRA_DSCP]);
+
+		print_string(PRINT_ANY, "dscp", " dscp %s",
+			     rtnl_dscp_n2a(dscp, b1, sizeof(b1)));
+	}
+
 	print_string(PRINT_FP, NULL, "\n", "");
 	close_json_object();
 	fflush(fp);
@@ -697,6 +718,14 @@ static int iprule_list_flush_or_save(int argc, char **argv, int action)
 			else if (ret != 2)
 				invarg("invalid dport range\n", *argv);
 			filter.dport = r;
+		} else if (strcmp(*argv, "dscp") == 0) {
+			__u32 dscp;
+
+			NEXT_ARG();
+			if (rtnl_dscp_a2n(&dscp, *argv))
+				invarg("invalid dscp\n", *argv);
+			filter.dscp = dscp;
+			filter.dscpmask = 1;
 		} else {
 			if (matches(*argv, "dst") == 0 ||
 			    matches(*argv, "to") == 0) {
@@ -975,6 +1004,13 @@ static int iprule_modify(int cmd, int argc, char **argv)
 				invarg("invalid dport range\n", *argv);
 			addattr_l(&req.n, sizeof(req), FRA_DPORT_RANGE, &r,
 				  sizeof(r));
+		} else if (strcmp(*argv, "dscp") == 0) {
+			__u32 dscp;
+
+			NEXT_ARG();
+			if (rtnl_dscp_a2n(&dscp, *argv))
+				invarg("invalid dscp\n", *argv);
+			addattr8(&req.n, sizeof(req), FRA_DSCP, dscp);
 		} else {
 			int type;
 
diff --git a/lib/rt_names.c b/lib/rt_names.c
index e967e0cac5b4..723f0917b0ae 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -625,6 +625,17 @@ const char *rtnl_dsfield_get_name(int id)
 	return rtnl_rtdsfield_tab[id];
 }
 
+const char *rtnl_dscp_n2a(int id, char *buf, int len)
+{
+	if (!numeric) {
+		const char *name = rtnl_dsfield_get_name(id << 2);
+
+		if (name != NULL)
+			return name;
+	}
+	snprintf(buf, len, "%u", id);
+	return buf;
+}
 
 int rtnl_dsfield_a2n(__u32 *id, const char *arg)
 {
@@ -658,6 +669,18 @@ int rtnl_dsfield_a2n(__u32 *id, const char *arg)
 	return 0;
 }
 
+int rtnl_dscp_a2n(__u32 *id, const char *arg)
+{
+	if (get_u32(id, arg, 0) == 0)
+		return 0;
+
+	if (rtnl_dsfield_a2n(id, arg) != 0)
+		return -1;
+	/* Convert from DS field to DSCP */
+	*id >>= 2;
+
+	return 0;
+}
 
 static struct rtnl_hash_entry dflt_group_entry = {
 	.id = 0, .name = "default"
diff --git a/man/man8/ip-rule.8.in b/man/man8/ip-rule.8.in
index 48f8222fe193..51f3050ae8f8 100644
--- a/man/man8/ip-rule.8.in
+++ b/man/man8/ip-rule.8.in
@@ -36,6 +36,8 @@ ip-rule \- routing policy database management
 .IR PREFIX " ] [ "
 .B  tos
 .IR TOS " ] [ "
+.B  dscp
+.IR DSCP " ] [ "
 .B  fwmark
 .IR FWMARK\fR[\fB/\fIMASK "] ] [ "
 .B  iif
@@ -234,6 +236,21 @@ a device.
 .BI dsfield " TOS"
 select the TOS value to match.
 
+.TP
+.BI dscp " DSCP"
+select the DSCP value to match. DSCP values can be written either directly as
+numeric values (valid values are 0-63), or using symbolic names specified in
+.BR @SYSCONF_USR_DIR@/rt_dsfield " or " @SYSCONF_ETC_DIR@/rt_dsfield
+(has precedence if exists).
+However, note that the file specifies full 8-bit dsfield values, whereas
+.B ip rule
+will only use the higher six bits.
+.B ip rule show
+will similarly format DSCP values as symbolic names if possible. The
+command line option
+.B -N
+turns the show translation off.
+
 .TP
 .BI fwmark " MARK"
 select the
-- 
2.46.2


