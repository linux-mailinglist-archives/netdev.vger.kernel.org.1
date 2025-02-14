Return-Path: <netdev+bounces-166494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5605A362DE
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C5D1890373
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947122676CE;
	Fri, 14 Feb 2025 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aWB4bzcS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D62753FD
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549960; cv=fail; b=AtUoBzpFIA19/AQ6TK5no/aDZGhZGNcWgvgLgMGC+uyKMDiC6W9/5Tz6pX2t0mBg+uPM+Gk9HpZzdRAG8G4wnuvmyPcTYS/dM2+fU55HGuzrlGiOUqGOlBU0tsqGTq37fR78CnNwX9DbpBcpRjBt9G1CxsCLu/pci/7+j7T6EGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549960; c=relaxed/simple;
	bh=wSymqzz7rxwOlVJ/pbjKx++OCr227vtTEVuyoxDP2Ek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnpqx9/hZpdhYsmUL5qqsRMqZiw6gd7XTlaIgGMXPIJPAZP0+C+CRjlu0YtFZfGIVyWmkqId3xAGcurITOXpMA6AgGv6HdORVlyEevAYVZRkXUDaaHPOww0BUeH89z2NVUWa2CtGXWoRj3tSSQ/3tx2FrkiyS2CzsIfMZXoZHNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aWB4bzcS; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiq26Zse6T6HLc5DW+uhhTqrDy51MLYnSC8OI4CCINjtofvMni69uKvUSZAbTSCeUnkTAPim3AjoDn4U8+0mx3o6kl6yZo2VGtumuc0WOVVYyXv29ph5c3cLzYA0S8yoAwXM85wkQCqIZsPxvkkkuykyoB37xb7cGith3983LcFOsInXh6eGCce+qd9HvvGD5a2/dDvHNauPi90FJJBof5pJIjIFs5N1eUaMvYxnYRRaDCAqFv1UjzQzzCyVCJDcPGNDnjyM0YbEibZWNnXHyF2eA3gvFeKDK6SrYwIrpPiaX6tpYi2iFcrdfKIDRIHPK3LOlMReuJA9XeUU4nA+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dx31xe6hJ7OkeovnABQgl2ODAJmzdf3zz+eTNYke4k4=;
 b=dMgwtEFj9EthAoJG3XYRCbV1lxMEvXc6DcHXnbBubzEQ+hvJv6YJmkTg5LpeHDJW1VG+7sS6Jl+on6mLSg7/jSDA5WUOjRRZe2jYpzvycbBcTpVuXr4f3LoBp8Xg4w2xryaqMIvD54gaa7Txjkpl9pt49yFHMocGpJEqFO83i2Sp4HWOctpoFB7E3vGN5ycCEtCAKK39s2gY2is241Fa+6Q0Ry9uX5QJC/Pboyl/VWGKJkiOXd1hXRwrmZV0suiMy93qvrVAi1DOS/1Lhd9AtL8SwwrvjAVuAzSSpawIivi9RYXcGv4tBRmC8oNGcKcs/x3j2dXPq5p7bh08ruqm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx31xe6hJ7OkeovnABQgl2ODAJmzdf3zz+eTNYke4k4=;
 b=aWB4bzcSxI9PfsHLF0u3njZAvoIFtcGM0bt4A3/EORdP9RTadjEpkyDuF8D1MnTPbVl41VjCidxlls3frXXSi54swgHmLHaWbVk8orTLktKlny9hNWQgnmzo5+y15JmCBQmcRnQa3+LeruzfqFWbiDpJEPkIPdXxv9uOHhjGbo51Vqhi2y+RQH99l3m6YopRj3+F2QoZs2uS7nXu0CMrRXZAW5AKAdrzQIJ/E69EMvAm0lTTeKZvdIw9vYGhwkgqpOvlOEe3qpYHH63Jkx4Xt6/PZWs9MC8VH9b4aBAPBY4YPW5ylXJX9YG1jJebdB3BwU+rlYdIddTGuUCVjG2k9w==
Received: from CH0PR04CA0033.namprd04.prod.outlook.com (2603:10b6:610:77::8)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 16:19:14 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::dc) by CH0PR04CA0033.outlook.office365.com
 (2603:10b6:610:77::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Fri,
 14 Feb 2025 16:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 16:19:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Feb
 2025 08:18:59 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 14 Feb
 2025 08:18:53 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>
Subject: [PATCH net-next v2 1/5] vxlan: Drop 'changelink' parameter from vxlan_dev_configure()
Date: Fri, 14 Feb 2025 17:18:20 +0100
Message-ID: <a3a3ceb6e4ef0952a3339a5a613f333f92958292.1739548836.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739548836.git.petrm@nvidia.com>
References: <cover.1739548836.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: f43a08de-33b3-4b4e-f077-08dd4d13523e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RzBJJK4u6D79huWBeCC8M9FQq96FzPbzJniwCOH2LGy0YlQc1R4qftJrbpks?=
 =?us-ascii?Q?rUw8vsgDtAkxrMdlDV6RBjJojhMO5dxtNtslq+ZXICRIDNirruAmWGXVjPRE?=
 =?us-ascii?Q?ZtEBMid0XRmDmpO8LwrGnd7h6kspcMSfiwEn06s2TVTwZLqGE9CSKHtufVs5?=
 =?us-ascii?Q?nDfZeAHlB2aUYO9KIRMK+XDI6tS8OjyT190M9Ol5mCRLC74mm2uZ06ZOkoPD?=
 =?us-ascii?Q?/0kX4NhGpiUoCn/V5nWlb6kezXmrah2ReniHpA6B9GmxR4dcD8irMQodzqDV?=
 =?us-ascii?Q?4Sum59rVw6n9kNwwrVavThSrJ23lnTcgNNj9B7Gqne/hViNGzj1nwvEmyZm6?=
 =?us-ascii?Q?ffscKOtiA1no7das2OaoKT8aIyohlSfB/ioaPXSJyY5tKfAH03YkFoD0ce3T?=
 =?us-ascii?Q?pZrXmEOtHm65yrLl3MBk7cUIScEM6YAZu8RsRWi2yXpBmDiLwTmXwRu/cj2x?=
 =?us-ascii?Q?6ftEDLDnqpUajFMF2pVnWRq1BwbF5JikIONedQTX4qxc1aHc9Y8j7Fz0o6eI?=
 =?us-ascii?Q?6GqiKMPHzpBWBwogumThuhyErS0nfgiW/LKFDXtOle+FVxQLzSVebfcWwtS9?=
 =?us-ascii?Q?ZhlAxM9JIhvzwBhKquJaH3eZzEglqcZV0qUafcD+sLloE1TM9rG2t0Yhwi6i?=
 =?us-ascii?Q?7Ewn44+Vp0rfN2SU52zFEjxrT/XQ7VJe8H1z4HOuOr2pLmHatOAFMzEsj/4/?=
 =?us-ascii?Q?6MEapy94FkpWlehbZyXo4rOjiFa8JKyPpkUiMbNWtmA6ixYMymyBl2yQZbOU?=
 =?us-ascii?Q?1t0sBa7+sTjeloZNfxSClUGmQZqb+0qspEFgzVxyk8G6Sv9LfpaVI3etwl69?=
 =?us-ascii?Q?/IL1mcEUQ0KDan4no37sCNzIQoUkeYHCGusW9NBE+C7YzlZz7BQiPvddAqPu?=
 =?us-ascii?Q?l79BXlxsnGFAmEIx4oai1JbU+qBM1qmGfU0lTIRVPlDA6oBZLker9H2/hemp?=
 =?us-ascii?Q?sQ3giJ9HHdg5r8WxX42jbRWWjsRAGnVr5p/pCRC8tw/UV30MbNYQz+TGDpSb?=
 =?us-ascii?Q?4p7OkO5KbIH+GguqUWTaRDsYIp3U8W4o27lKzMFc2kL+lJzOlDS7pE3pb93V?=
 =?us-ascii?Q?ynSA2cyKBNdpoohWKUmr/dWZ4YcV1VT0U0eLKfRz5I6t5O2Qlh5Q4xQvNM5L?=
 =?us-ascii?Q?ASBTu2CwDlmfzLvrrDbAJVzAaCI/sGpyQBFExjK/0w/TE5uzjQzzBtZzSCTn?=
 =?us-ascii?Q?bBlme/kssnekFhtQLov+Weqnx88RceGZa54Wt+4c/u29QpdsHIFFfAVaj9yt?=
 =?us-ascii?Q?Eb4nXulsDbaIEQoewXm3Jac7JxhIUECv/RVU7SV+K+rQEhr7D8Vyx7MFaZnQ?=
 =?us-ascii?Q?Sh/KAB4FyOMd9imaTwn70DzxqoGtr/780nicjEIVxpVJI2HWjsoMhhzu9X6g?=
 =?us-ascii?Q?ZARttFEwiPMflz870csSRjfI4zlkq8hr+xqqhypfZh1fcd+MnCFMIgzXYOWV?=
 =?us-ascii?Q?VZ+OjYcoKUcGfrPGcpwquIUwWgwIirWrD1Z6Y3wZlhHW2WB6SdjR0v6Tmvuq?=
 =?us-ascii?Q?7RHTHywrAUjT6YI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 16:19:13.4333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f43a08de-33b3-4b4e-f077-08dd4d13523e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713

vxlan_dev_configure() only has a single caller that passes false
for the changelink parameter. Drop the parameter and inline the
sole value.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    - New patch.
    
---
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Nikolay Aleksandrov <razor@blackwall.org>
CC: Roopa Prabhu <roopa@nvidia.com>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>

 drivers/net/vxlan/vxlan_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b1158a1bb855..ec0aee1d5b91 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3936,7 +3936,7 @@ static void vxlan_config_apply(struct net_device *dev,
 }
 
 static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
-			       struct vxlan_config *conf, bool changelink,
+			       struct vxlan_config *conf,
 			       struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
@@ -3947,7 +3947,7 @@ static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
 	if (ret)
 		return ret;
 
-	vxlan_config_apply(dev, conf, lowerdev, src_net, changelink);
+	vxlan_config_apply(dev, conf, lowerdev, src_net, false);
 
 	return 0;
 }
@@ -3965,7 +3965,7 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 	int err;
 
 	dst = &vxlan->default_dst;
-	err = vxlan_dev_configure(net, dev, conf, false, extack);
+	err = vxlan_dev_configure(net, dev, conf, extack);
 	if (err)
 		return err;
 
-- 
2.47.0


