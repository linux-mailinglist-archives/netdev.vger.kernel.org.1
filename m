Return-Path: <netdev+bounces-124552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE177969F7E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4C21C23EFC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0DC1DA3D;
	Tue,  3 Sep 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cSrk0Hqb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AA71CFA9
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371683; cv=fail; b=eLhTwoWg3S30R+lgNeiH5nxslG/EQ3QGj0g/QhnmZooHY1bPwkC2d+bzpZA/VblsnjthvsVichDaqpePGMVpaFTM/tjWZH1L5AefNbHbrvSfTiqP9XdN2Tuto+LVRJWNhHFoGDshXf7u4oEaGB+wxz3P2Iw20Ge9iyoG7rnRRGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371683; c=relaxed/simple;
	bh=GYc8IKPZvtcLyVOmuC46VFadGESXTi0hCphx35Rxep0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxibrs+PZato0eqLIxF44iNblWqClZGLvoI1I47c1jL78CA+lc446Fj1WbRtJDxj9SqtuBfNfsxv5gXWOGGb5rR065wJYTdQaeWJoghmfWGq+zgDdW6rsU5SQmrFCOz37uhLgIM5/Bf7MT05mdkOgVPyQ8v3vfppISOnGEAJSXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cSrk0Hqb; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZnfYNyZZOyyBqnrOZmdoNGO2Gf+7gEINHNjXwBeYlitZ3OF+iPlCu1H4Xp6l1zWf2i65WSDDmtHAJ0JeDMHAeF+W6t1gFwMlkkQh3iaCByB2lb7AbGcHKnexCo0A7/LEFMvgQZMQVu6OPaauZ/I6r4NQFg6aQMlgBcdhr/xhzAwIqdo4FqjzUlVFOgPAFgcRFYiA1qVfhZ9sHsKYWNMN5vOwVyK6yhaR3AjLo9/dOyFpW6B2uzrDz2S23ZeSJMr2uAtl3tgBHRgSZTyGCJNMzuzOs11NCBA9ZnBXyHyMOx+dhLmCVc/AL236YP1Y3NQsguOPHmfmn+M33kD3viISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOfAtJT8nKV47tMWOg4d0zdjRTb8hlR2IndH9yc3HcM=;
 b=ckwYoCMT7LNFWUPvw+4z5lyLKzE80KtL6lMRZ+zFZYtUExtunp8OJX6NygdLWXYz9EvXGOlXSXv01MxYvtrG19Ij2qRx58wTpo9CbM5Y+0AZhrqsGHfHLT3sY3MbGjNnly/iPOdEIPg+kpLLvOy02JvIMxCc+pfOLUeXKI7Yd084xVchL+wjLlX6s836VOa2a+qSdVZKPZl84BRx+JWHtcrxG81hHR8FH9xEFIuvajOpTvuCXRIYZHNmCvsKSVxPO5ZKNeeck82x4LxRXJzYVhyvysD/cL59TF7Px4vqfib0o6lo/iYRRQpQqRecSRYt+xkoGCA3mZnHak+ibCdttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOfAtJT8nKV47tMWOg4d0zdjRTb8hlR2IndH9yc3HcM=;
 b=cSrk0HqbuPiBTT5gp9xze04+Cmln2bXBg/Jcbk4gBI+qJ4UKgYzxnu7f1Dph5nocColjrDB/j6BJ5BFM9ZdVsQVjtZick3MCGj4xjQkp5pbxqys6nppClxN8s7I925O3w7E2t124Klyz+Xr3aLpWzXWacaxQdkYiTKZF4r6DNudQ7OM6OMh4qyGR4gAHbUnrbOTpQjGDrZJEILivgiWYBqauvwTKuIFIeuRRi5FzshDGfoEPScG03vhz0lZghs2VypWwj+0C7fUfczb0g62eM9CLsOSSWDe5SBSxui2+siRVpwiCiIFFcnKJfRDgoAcD5JCgi6QmeIVo9mS5FvJHFg==
Received: from PH7PR10CA0012.namprd10.prod.outlook.com (2603:10b6:510:23d::26)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 13:54:38 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::1b) by PH7PR10CA0012.outlook.office365.com
 (2603:10b6:510:23d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Tue, 3 Sep 2024 13:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 13:54:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 06:54:22 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 06:54:18 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 4/4] ipv6: sit: Unmask upper DSCP bits in ipip6_tunnel_bind_dev()
Date: Tue, 3 Sep 2024 16:53:27 +0300
Message-ID: <20240903135327.2810535-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903135327.2810535-1-idosch@nvidia.com>
References: <20240903135327.2810535-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: ad43c263-35d5-4693-f0ed-08dccc1ff363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q19mqk/pXkcY0kxeQts+FaeblYfRAOQJuoKY20Knf2Mf2HN2uHo14RqTBXsM?=
 =?us-ascii?Q?NkF95QCKRfZQ879EqlmaEpiBirN2U/ldy407p0uraGyfJOMULvgqhGiR+7sm?=
 =?us-ascii?Q?6ztd/4wChWHMMpNdl6SnmJ0vzw8w+C9XqO0VH8NXVw3n0QbpoOFq3EVOrh55?=
 =?us-ascii?Q?srNq4wotgO8RO01QZ9a34zDC4wKmBVPuALl2kXe0dhcVPDCPt5gSnNz+RnKT?=
 =?us-ascii?Q?h379FQDaw4jmq8KIZX1DYfKYqtuHutSJ0aew5u5mUsLJg5jpu1udKQJqYF2u?=
 =?us-ascii?Q?NYnIpa+ujqTkeVkLD6oI9UCw6chrkyYvby+RCNJt5l7zzuIkuAZg9i7x2UL4?=
 =?us-ascii?Q?FoDqcY783/7n5mnQNSwETC3+YVBKxkObHvGnxMq0Y2Hw3E8sitaoe25YxRGP?=
 =?us-ascii?Q?dBnZ5Nd7n6D6Jz1hUyFiOgdKTtPLO/yid3jrD0NN2gz6pVhHdR0aNHZ+96sv?=
 =?us-ascii?Q?9xLnDPCZCYL2byQhAZpWtrkgi7oYM5HOEd6GQo91/Bi/giKwyPVtgmbC90XQ?=
 =?us-ascii?Q?S+H46571SZp808+BN0dO6vDI4g/+Dn64i578HR4MrAwUlZ5TOuARi9C41ADT?=
 =?us-ascii?Q?6uB4XqLaViHtUUVGZq+uyPmBFT97CNhwR2t59apkxd/pdcEH99EC2OYNvmOh?=
 =?us-ascii?Q?cZt0PiV5B6vsJxJTWpiEIIJEf7rz7GfcE9ukwUzjjxpa5yzthRG+jKhloDwG?=
 =?us-ascii?Q?wZhuovEH9zacR5xfoOoOEZKiGqyfE8crFGrVg8Qzfwt4TLsJyd6AbYOIDyYz?=
 =?us-ascii?Q?/xWs0zp+Kn1Uuo1P5jXC+rHQczl4U3WSVDa7MfnMK1y+U6gVhcJePcSiS5qK?=
 =?us-ascii?Q?JKvCp9fy4fJDRqze5qhu0N/DEMBduIB3IyB9VIkcE4Vrt+cNB/Ukm8XBDK3u?=
 =?us-ascii?Q?pfWCas4rBCangu6l61aiZ9KjctFRAnO/oIgrIR5KCGaaKDwVnhrrxCveUP6O?=
 =?us-ascii?Q?YfvPz8dgAWN44TO3i5APGaPs7OaJWNciAUn44Xq3LR8p7P7cy40JcagCOCfy?=
 =?us-ascii?Q?6USBqXpfEg86/1TwS99QjN517br07gea4/SUpRRIS+R8et2bB/zWyAB/ZNgS?=
 =?us-ascii?Q?/sCch1ADF4gkqkEo2Aq0S7hvxtc59xpmmJsUjhjnzPiB84gCjoa+U/VQ3vsj?=
 =?us-ascii?Q?G4ig3AAEphFgNScnztYF07HufilaEs9bBgjWozlFw4+1tAwqj5Pa10YAyUGZ?=
 =?us-ascii?Q?lUOngFSS7brPnQ563xCmHaiHrJRnxQYIn5jZTv1CFi20JNZWH1AoSKdVUoPS?=
 =?us-ascii?Q?SiGEQ6o5+hyZnxJ6mytYfIj2uWyWUG/b11S6ZTgUlqMAtKeSQe40zxjkXxQ8?=
 =?us-ascii?Q?NKq42my6fvY2OijzDT3QXSp4IFqOfLRjZUp1jpAnS84pv0hQMIhqbh48gfra?=
 =?us-ascii?Q?5CQwCX8Fdkre9uvArwfehD4AGGPvgO2e+12oE4l3amoou6gy6DCGZSWda2ye?=
 =?us-ascii?Q?6Xpljf5UuuadAyiY2uBppfja/40j2VTp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:54:37.7670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad43c263-35d5-4693-f0ed-08dccc1ff363
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975

Unmask the upper DSCP bits when calling ip_route_output_ports() so that
in the future it could perform the FIB lookup according to the full DSCP
value.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/sit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 16b90a24c9ba..39bd8951bfca 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1112,7 +1112,7 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 							  iph->daddr, iph->saddr,
 							  0, 0,
 							  IPPROTO_IPV6,
-							  RT_TOS(iph->tos),
+							  iph->tos & INET_DSCP_MASK,
 							  tunnel->parms.link);
 
 		if (!IS_ERR(rt)) {
-- 
2.46.0


