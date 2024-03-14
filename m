Return-Path: <netdev+bounces-79901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C2C87BF5E
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32671F22729
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD17A51C3B;
	Thu, 14 Mar 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C96j1HZk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C429CE3
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428191; cv=fail; b=EixnJJsaP5FEXZ+mp5SClrfnhpxn+3NSSZyEWVexvCrdxAFlJd9RGAfN07snqIYP7xnabjyvvIC55j9yCMEAZuhGntyYEjUpe8a+1wp0icnwBxAmMD60ieBqDhgDXzOSMGCKvzcFLoVAPwF73rx5jAQNR/P7P5akYHxXGLnMOFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428191; c=relaxed/simple;
	bh=OYsd7y/+EzcmS9JOznGACWalf5o+aSWwmK4UxacAP2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QuVI++X2/i3rbhUKGZz80nslZkHA0JWFtZVL4vTGg3j0Pw6015oATYhWyj3P1qozhpt80tYRkj9aEH1e3v/E1PdeTPmbwgN+Ba1YPlnLxcCMmEAMu5uBX+MGKA9H7qB49HouJYCqEnsnXLY61QFTpZIT3QsB2gl38v1gFj3qTdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C96j1HZk; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErSWb1aWvVej1XLROjR7Mo/f8wWG2P1tH7ZtmGYbsXAu2DiZEK5g6xj4pDRcKu5CCLJL31MpoGx8Y9680Ps65j8frrOBQuYsTOCoAo/nIodoxptlcZtqZmLjsl7IrKCOtciQ43Kq6jrDwkp1JvWM1UwyP53c6hHzhF1O8lG5fBu62TsSGWcruoXTl+t5Oxg6HJL1Dpl2L01A2nd3ZytmuznfDOBIss/UCcRpEGtMXLlDRQi3SdUoMwZBsFxdqvg45r0YI0AlLlPjNbY1AD0Ng1DoZOLw9qRvg6tg684Bw2YYaSzCaFm+oNylXvF4GPHryRowOy9pW1frNrHAUAf+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUsHSDDEx1swruY3bfxLHQTnrDufM7QCPF2Y/rBrRUw=;
 b=Yy0msQNFrmm4xtb+p96AO+4y2ocHsOEKCwy/4k8BjGzHti3nT75HYqb2CZ22MPSTexkYA30jY3st6IsL/8zK0fhxnN3q5RP6fNsc8rjBi7iWpcUraVP+q4HM3vSCupMzbqZFHeq5b/syweBRcgLeY049y7WD4H5QKt0WOJaCGCqX3K+00hgmW0I0PdA3h+2f/INpJExhJVR2EIcgEAThYCk8mBW2YARksArrKZaxltj21k3cz54b0+GPi5EE57dfV8Z/L4z2mouQTiqqWBtrBVVd0R7/sTkhqiCowSmBHYw37rnKrr88XYAFivTi8yY9hZ4cG54JYYVPSA4jrNq8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUsHSDDEx1swruY3bfxLHQTnrDufM7QCPF2Y/rBrRUw=;
 b=C96j1HZknq1mpbQGtyYIBy75ktXmrfSzUgXcQji9U1Kzrrd9JX6e7OVQrXPRuGuUtEKDRFbRApxM/4YYk0vZu/vZCl1oIQTXnXmNaNQ1mE+ou4tU3LPEkqlL8IJlst6iQ02yHzXZKT0gHO5YwoprA6PKEbwPbfL+71JO6Au5tI3F62cTK2/BfBeZF/VKXdGvzFjTdaDNQJLO33nMhtUX8Co+ChYB+X3FNgQoy0veQGNPu/OkYk+K6ziQWrdpl7aAsShUqkp1jRzmbFv9PrjKgmMmLzgulw+yfrF5sNsbPf3ErsSGr4LJtL8G6K8+Jd6JDZnrb0m227r7PBuvcgh48Q==
Received: from SJ0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:2c2::11)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 14:56:24 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::2c) by SJ0PR13CA0036.outlook.office365.com
 (2603:10b6:a03:2c2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Thu, 14 Mar 2024 14:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 14:56:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Mar
 2024 07:56:07 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 14 Mar
 2024 07:56:04 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Jakub
 Kicinski" <kuba@kernel.org>, <mlxsw@nvidia.com>
Subject: [PATCH iproute2-next v2 4/4] ip: ipnexthop: Allow toggling collection of nexthop group HW statistics
Date: Thu, 14 Mar 2024 15:52:15 +0100
Message-ID: <88f549693a2699465ae7c9bfba68cd2b8495e9df.1710427655.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1710427655.git.petrm@nvidia.com>
References: <cover.1710427655.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a1f941-eaa0-43cc-0afe-08dc4436eb4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B6/OTbTPmP/yagP3DTwajdnbo+iTmSAYp4W092Vee4763suKf4rNvPY0yepz7TtmeN4v6uvUesNdbLnwfHImbKMHgTyiqAzJ+r//FT72R0r9+p9qyU1q+V5Ug4cvTY2kWNyiFJE7s7dtteCRXj5y9zKE3D0UqKjkfjWg6c4K56tNGHPfsqTV4HvFuuiDjLVDTEz/8FU8qWqkdHed7noxs/tqvChVaLXA+P+UJgK+262n4zF3eSqPtdGfLep0xULOI7ZfKLvR7rxk89bQFLoi62+am/33rOHTP0eUajZGnYnG4HL4vNrAaqiAri91suxZpsNKnHgQatZyJoL+ovqCtCaUUFn2i3/2kqrFTHg2BV4G0fT7Q/Twsn93crqIrLiJZpBpsEheRcNOHiXRgHSibcrstm+dJH75dO0TULlBOntcnYFw3LkzkuH9Whoy1783UU6hd+JWglkehrU78J8yHlME6wOHLPhn9cIsoKx3bclq8j7sHIZeuW9qSb7Pr1eAHXvW9lIdqSm/L23BMDgDjTyUoxPx0UOqffYraKeef/+m1hw7l+yiSlfYTf8UA5yuMAsv+VeiKx/izTqgtgS1oXZvWCk+1NgcJw2Kjgtx3nzfYIY+FomtWo0APuWjccNEC9o1977kJ1RWTmZgMRHZaClejqxebLnPLjG0zQALR3HitU9Hir2D5AKwzN0LdvuW6+Y7yO6zowsjOm46LWnN51EFy3cRAogymnffzGg3ddTuIObkF8XHfIdJKRdOmJB8
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 14:56:24.5851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a1f941-eaa0-43cc-0afe-08dc4436eb4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954

Besides SW datapath stats, the kernel also support collecting statistics
from HW datapath, for nexthop groups offloaded to HW. Since collection of
these statistics may consume HW resources, there is an interface to request
that the HW stats be recorded. Add this toggle to "ip nexthop".

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 ip/ipnexthop.c        | 12 ++++++++++++
 man/man8/ip-nexthop.8 |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index 6c5d524b..8aa06de0 100644
--- a/ip/ipnexthop.c
+++ b/ip/ipnexthop.c
@@ -56,6 +56,7 @@ static void usage(void)
 		"        [ encap ENCAPTYPE ENCAPHDR ] |\n"
 		"        group GROUP [ fdb ] [ type TYPE [ TYPE_ARGS ] ] }\n"
 		"GROUP := [ <id[,weight]>/<id[,weight]>/... ]\n"
+		"         [ hw_stats {off|on} ]\n"
 		"TYPE := { mpath | resilient }\n"
 		"TYPE_ARGS := [ RESILIENT_ARGS ]\n"
 		"RESILIENT_ARGS := [ buckets BUCKETS ] [ idle_timer IDLE ]\n"
@@ -1102,6 +1103,17 @@ static int ipnh_modify(int cmd, unsigned int flags, int argc, char **argv)
 			if (rtnl_rtprot_a2n(&prot, *argv))
 				invarg("\"protocol\" value is invalid\n", *argv);
 			req.nhm.nh_protocol = prot;
+		} else if (!strcmp(*argv, "hw_stats")) {
+			bool hw_stats;
+			int ret;
+
+			NEXT_ARG();
+			hw_stats = parse_on_off("hw_stats", *argv, &ret);
+			if (ret)
+				return ret;
+
+			addattr32(&req.n, sizeof(req), NHA_HW_STATS_ENABLE,
+				  hw_stats);
 		} else if (strcmp(*argv, "help") == 0) {
 			usage();
 		} else {
diff --git a/man/man8/ip-nexthop.8 b/man/man8/ip-nexthop.8
index f81a5910..aad68696 100644
--- a/man/man8/ip-nexthop.8
+++ b/man/man8/ip-nexthop.8
@@ -68,6 +68,8 @@ ip-nexthop \- nexthop object management
 .BR fdb " ] | "
 .B  group
 .IR GROUP " [ "
+.BR hw_stats " { "
+.BR on " | " off " }  ] [ "
 .BR fdb " ] [ "
 .B type
 .IR TYPE " [ " TYPE_ARGS " ] ] }"
-- 
2.43.0


