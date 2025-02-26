Return-Path: <netdev+bounces-169765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF18A45A65
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C307D188B0D0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C93238147;
	Wed, 26 Feb 2025 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r8x5zMHe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62A226D13
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562774; cv=fail; b=nqWSjPA0LRQafyKQhS9HRW4/ZQfYpEHWJ8T9NCrFTIPK5Ld8exAK88r+YrPrD1jAESOXJ1cQ+QJuSdtGfzH6yunh/bz7s3pD5eW58dD/Y1WPdg+27UwpDNn850JnBvnQIQE847DzUiLsLx1t2D/dR7mMSd8WxiQoDurcIWmQX0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562774; c=relaxed/simple;
	bh=rKDCUBXK5YiLq5Yr0Bod2+aRB2qCSSoeEW5UMiu5aWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRHBLXGnbZn6ME4Fsxql+vYApdaOPLsfIqKGjdaAyTDeEY+HFKIChn86z8Ut5CSA+ocNUNoXhv6BStpvlFOKqy4NH6iXa1D1x6n4WeniucL6jb7WusHkLu3Zc4lB2YKVZALxDp9CMtbL5N18d3sVldC7VySNALKE7IMMR7N+vMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r8x5zMHe; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ae3RDJvHlxUf0LMjNdbju0COktj0RFSXXebnzmlIDlYoh1MYsArR7lhqB0earJOw6/oWsZUemese97g/Uys/SFg/ShMCI6Hnm+v/NXcEX0d2c/5zh3dHZSNwBmQ3n/auqvcp9ESlkxeeNzkrdp2wdcVn+u/GhyQVrIJNRMOiE0WlJLxy2fNvHGwk3kUf3uNMU0ikc+DUjlFEGAgNhdrvyIjv0Dn23zv6SUbbpIJOh0tLqvgPF543fyAR3a9mdNGhqad22Z+qDbPk3/0nQ4TYnGeKH289h2hVMNdIR6j2vnpGqTMJn0IY9ra7jjgMTKvZ7yAb96TZwKTuVXF1tk+j4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybX40IeuryRZKAdeDx3HVlIjyiZ/COXth7G6/qZl0+Y=;
 b=JUqJfgfMZBU+6s6I/LyR55ba1Xdir40W7ybD8NftDFBePe0j0fWyQpIe1/ZVXTXu45kjcaB8BTE41P7FzySSgFtLMEXH90pmOHcgRUnQVhnj8jfJ6VPcej8DuW7PMcTWci50IoDCQZjFb9NDu/IV0ayKeVe+BXP6a3Zp0tgXjNLs29sstoc4Bu3n1UI2tkT+4PSfcR4dVHZdKmXROpHa66y0Z1Hu9zFJirOtEI3fQyscxQAoamdV5C9Go72+rakbu1ltnXQRJ2O8V7IiJZD6HXrFVFlRh4I0Sd+5kPEV+nDwEYZH9IvW9Y/cZqfxDzU491LkhoAepWIHxhLhc0Llhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybX40IeuryRZKAdeDx3HVlIjyiZ/COXth7G6/qZl0+Y=;
 b=r8x5zMHekJfP9BstNdyxeNuM1HOx5lOGI/53zcc/wIfS1jE+sdd+L/6OTrJFA1Id9TV7sII09YC20uJ6WCjKJagsTeHTi6g0l0EdQHlbQ7OKuGgsrFIeUxL11JxpRkE+NPyBrugBmJaIA+RE1oOtkQyFGyZVrRjkGHPOr+hwLZ7UQRScisJY33+sREnSq4hfyL8escYWaxmVjnTLyDf/KEtGNEdD+oep4FnfY+9lU5mVXuWsaCJvZFCqYab75ucTKzM3/8yVDTX71koxqAbIiXRofAsJModLP8Dn4l5dTlhkg46Tsz5sbJq9CDNHIWDaHsVkYYNEe1EjT7HPzwi8EA==
Received: from MN2PR11CA0014.namprd11.prod.outlook.com (2603:10b6:208:23b::19)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 09:39:29 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::be) by MN2PR11CA0014.outlook.office365.com
 (2603:10b6:208:23b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 09:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 09:39:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 01:39:17 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 01:39:16 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 26
 Feb 2025 01:39:12 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Tariq Toukan <tariqt@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, "Jamal
 Hadi Salim" <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, "Jiri
 Pirko" <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Julia Lawall
	<Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 1/5] coccinelle: Add missing (GE)NL_SET_ERR_MSG_* to strings ending with newline test
Date: Wed, 26 Feb 2025 11:39:00 +0200
Message-ID: <20250226093904.6632-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250226093904.6632-1-gal@nvidia.com>
References: <20250226093904.6632-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4763b7-bb41-41d4-efac-08dd564976b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xZifwLZokzR4sclfyoo2g6+LzcuI9mZc/DDU3lWjlS7pueX7wgPq9sVjk5mA?=
 =?us-ascii?Q?yw0oKfkKRASGJkDlN3KVuOugoL5SCQKEwnVRa+g7N0IdYz4oZZ14kNkW4nJz?=
 =?us-ascii?Q?adpUzV1gTCynPlBIg6HSs+ZO29NA9ui9MOAgaRsJNfrg5BH67JUtUzDKJ3Rj?=
 =?us-ascii?Q?09ELk28a2JBlJ7gH8MlAVlU5p+ypQrsAVVuci6moZ9af2TBgiaZCpL915Kya?=
 =?us-ascii?Q?RcHsBwAF4xBM2QiJDCghQiSz4mF5uE06iRn3U1srqvDP6IabT0WVniSKg/c4?=
 =?us-ascii?Q?uExeMrkxLPya8tr5XYPpVQYt2/z8/PM4OZZGu8cEAwRcyWUumt+RvXTcnXTR?=
 =?us-ascii?Q?XlmdincFUG9hHp0rj2nsbLCuVh25RaHxRv+kFdYo4myMQWdutxEbWr9Iwqm7?=
 =?us-ascii?Q?qn3v4/lqX4kUyLU0v+OK1xcu4go97mg3xZeWUtrPaqmefm9lOAYpzIYztpV0?=
 =?us-ascii?Q?v/sOTuzYnJsuGQtJcRDY6Afot/2rGxCKFGwoHA9U7/T/+n62wEDfPHmgWc3o?=
 =?us-ascii?Q?5boiDaG4fkhnU+vNf/VYEYCxJBvgyoQ+2+fBpdaScoar1SNHUIxYMJ4TyvHQ?=
 =?us-ascii?Q?cCc2EmLhZA+xDIb7DVrKj5WzQUiJH5bpXgOkuV6e+ge/+z62SUJhx5x02mwR?=
 =?us-ascii?Q?veY6Sthyftr4HYGErSfSpoiK8s0pBCVsB8jt4+RqEa2qlVAlhMLfkNu6Udeu?=
 =?us-ascii?Q?vdapNgERCXujykCm7XZDfInl3x0iwPibQCMrtu1FH3VdERVLzhqkpm84wW60?=
 =?us-ascii?Q?r8tk/9nleHlgm93YYieDxQ1zcFaAPMRsR04r2MyjqoKypNKzGwE+Zz78Pw7p?=
 =?us-ascii?Q?htnDGdhMFq5udyjBu4n/AuhHMvCC36nP2Y6BcTTtYtFoTzvy9+SLfQvPOccS?=
 =?us-ascii?Q?i7xO0ua3FR7LqcDZzxI24H5f0FllLTjv0sShXs9TKnko4AwrcTKhqjInK/er?=
 =?us-ascii?Q?ufo5A/Y3Vu1lbXqBO5h2/ooLPZg/pwltduMwn5MD2320yXLTzZUWM69wcou2?=
 =?us-ascii?Q?/3df7Da++VRJH1eChqU4yiKc07pzH+7R+ucdgf5ugtCpHoqG7EdLhlsfNpbg?=
 =?us-ascii?Q?eIVt4IOYgV+OxBZtDGbDPEpq19yjwZxMvbXxcXMdxL5R5UPVGpbRZ06Uqghz?=
 =?us-ascii?Q?hUsxKfxklQkbTRJniSSXJo3KZSUg6MdKjQF7xkp/25+LFUEx/4rZzNa2HnO4?=
 =?us-ascii?Q?mWTGJOFOgYput8AIb28c8gNMbi1KZUtuMFVC077WGVGm2LD7FGP+74B2PvV9?=
 =?us-ascii?Q?GfsE/ta72dQ8a6ZEb06abFf9IJCrxD+7B8llVuDfCyzkKZCbchrlwgYPmK2n?=
 =?us-ascii?Q?y+qzgk8WZ7N5ptJqJCDE/Qr/x9XkiwcFm+rlSvs+EsGjgkZHqUwO3PPNtEVb?=
 =?us-ascii?Q?pIf91LvttcJMlTvrNIKdQ3yuwxPUGD/0tTobF6Kd1PvAY6FlETyD7wAutMgu?=
 =?us-ascii?Q?4ULCH/CgfxPDTRyfRUk3mDpD4LPAOfK9zMr1UeCUwSKhj7Ywyc6ZvY/5gjqg?=
 =?us-ascii?Q?AXnN1BhLQeo4UgQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:39:27.8995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4763b7-bb41-41d4-efac-08dd564976b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465

Add missing (GE)NL_SET_ERR_MSG_*() variants to the list of macros
checked for strings ending with a newline.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 scripts/coccinelle/misc/newline_in_nl_msg.cocci | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/scripts/coccinelle/misc/newline_in_nl_msg.cocci b/scripts/coccinelle/misc/newline_in_nl_msg.cocci
index 9baffe55d917..2814f6b205b9 100644
--- a/scripts/coccinelle/misc/newline_in_nl_msg.cocci
+++ b/scripts/coccinelle/misc/newline_in_nl_msg.cocci
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 ///
-/// Catch strings ending in newline with GENL_SET_ERR_MSG, NL_SET_ERR_MSG,
-/// NL_SET_ERR_MSG_MOD.
+/// Catch strings ending in newline with (GE)NL_SET_ERR_MSG*.
 ///
 // Confidence: Very High
 // Copyright: (C) 2020 Intel Corporation
@@ -17,7 +16,11 @@ expression e;
 constant m;
 position p;
 @@
-  \(GENL_SET_ERR_MSG\|NL_SET_ERR_MSG\|NL_SET_ERR_MSG_MOD\)(e,m@p)
+  \(GENL_SET_ERR_MSG\|GENL_SET_ERR_MSG_FMT\|NL_SET_ERR_MSG\|NL_SET_ERR_MSG_MOD\|
+  NL_SET_ERR_MSG_FMT\|NL_SET_ERR_MSG_FMT_MOD\|NL_SET_ERR_MSG_WEAK\|
+  NL_SET_ERR_MSG_WEAK_MOD\|NL_SET_ERR_MSG_ATTR_POL\|
+  NL_SET_ERR_MSG_ATTR_POL_FMT\|NL_SET_ERR_MSG_ATTR\|
+  NL_SET_ERR_MSG_ATTR_FMT\)(e,m@p,...)
 
 @script:python@
 m << r.m;
@@ -32,7 +35,7 @@ expression r.e;
 constant r.m;
 position r.p;
 @@
-  fname(e,m@p)
+  fname(e,m@p,...)
 
 //----------------------------------------------------------
 //  For context mode
@@ -43,7 +46,7 @@ identifier r1.fname;
 expression r.e;
 constant r.m;
 @@
-* fname(e,m)
+* fname(e,m,...)
 
 //----------------------------------------------------------
 //  For org mode
-- 
2.40.1


