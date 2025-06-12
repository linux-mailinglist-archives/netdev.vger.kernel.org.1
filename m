Return-Path: <netdev+bounces-196941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DADAD7044
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8FE17F7A1
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A222222B6;
	Thu, 12 Jun 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WLM9FCyw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA731442F4
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731088; cv=fail; b=p2BGfKGGAE9TdXpiQZ5xz/SxLWzw9a+gDQXMg9W0skMmsDq/IYksiSwRrgJFl6j677clU7oJOtnw6MvWcNQdnUD4r87uvnzxIvrWcDCESFYHtf6iGlYCretLqdNwU6Q0Fiuy5sJxoDRIZ0XYE2aylDD/uLofvrGNY09gJ+qJozw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731088; c=relaxed/simple;
	bh=E9M0YfpA2zXCRP1We9sMrNfl9JiwS+0w6n57B68hj1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QutrHqWi655wyqT7g9yVl2eqeR9AqkEpGek/4xRVuhntC9R+E5J3PZQB84WIVaX76iv5ZP22lLQxgLjelu8EeqxND2n1VBFYBgF339wsp5eMydIEHpR4EeqfojPPQh465Vk1saqKIboLh/l/Sr5PAV1zfFrzZ1XXcbSjklP7YMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WLM9FCyw; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPCRdGbtUMVwmwmexL6PMIWEDUtBLwr9FotuDnqJQ21Xm0TFhcg2u1BR1vEPYsj6993u3JI6goUSTIeagWh6L7eQiqGOSymcoFg9Qeeqc0L56DIctEbdSw/2h+FpcI7f2MIxuYqGgIBDAg9Tbsbzohntg24dS7KWv9RbjJTVrOQzhzsVhP3Em2smPeLvlTHWSuIMtw4S06t3OzB12RYaJuUo7gPHFMJ3T8y/OADiPmbf9W3YfrHccH3NdwYGs+OIr7nBdNHzCNrZDfLfCZa/rWFKi/6JdCzYbsRezzBniA9nHid1scsfX5NrBLf8BS3ru2bnqm4FHjsj9+wLhuGyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O33Ij6wHTBpVBNqGtEPC4wiW43+Sw52hR/heV1wQFHc=;
 b=nu/IaGZNUaRo9aWhqK49nBlXPyZnDDFgkUcfn2lkZpwEcWV+yJDxyYKgRiRDxbULhnGYzka8ofvOpZDsg6u/gmDEZspjJMxMD5tJxKHZU/0JME3G6zqUHiPuAe5vA6e+gOHmFSENVS8Q9VjPlH2mH+JDmVlz7ARMkdLdm/PwNSW61trjLCa4bumGFtUsA/VbV4axGmk9anMABCgKY5M+7yLKBoM8gSfqREi91001EP43IAEEXYyMfLg7i+FTYNwf+KA2yxuncXb7NM+hdpBJBtpWnKnVF1eJIdSgZmF29Y10G4YdliZ9JOFUbCJk9e0qAovhngfVGa4rcQyyXEGrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O33Ij6wHTBpVBNqGtEPC4wiW43+Sw52hR/heV1wQFHc=;
 b=WLM9FCywl4BRYp2//20NQmE1p67hFRDCQ6OqBrpH+S+N3TvAeAEDZADvVYHXocSDnJ00Ryrzp841DaWFiIma3nfoqZWDJ8cUEeW4aqkOJkNtVHEnJ0vfEEG2WrMbxJ2gZgsLE+IZDDqqUCdu8PTcDzUERFUVe9PEiSUcMhr+mEf3kJuZ5MXGUGQkgj/lowMpa+Walyi5Z+GNdjxzSSZPAOJExvURUHzx45VfddAET8wuPBCjyUlRSgWl1/SVCIw+P9YtgLqrJKIkW6TtTEHstPOXKxy0l/vImuoY2yY2CZjNHLn6GL6Z+JYuygDw8kSZY0C/h+fj0LAE59rUQsdCVg==
Received: from MN0PR02CA0012.namprd02.prod.outlook.com (2603:10b6:208:530::9)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 12:24:43 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::12) by MN0PR02CA0012.outlook.office365.com
 (2603:10b6:208:530::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 12:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 12:24:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 05:24:27 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 05:24:23 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrea.mayer@uniroma2.it>, <dsahern@kernel.org>,
	<horms@kernel.org>, <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/4] seg6: Allow End.X behavior to accept an oif
Date: Thu, 12 Jun 2025 15:23:22 +0300
Message-ID: <20250612122323.584113-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612122323.584113-1-idosch@nvidia.com>
References: <20250612122323.584113-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8a857f-0f85-4a0a-a570-08dda9ac1c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p6vibdLJbXygiax+J/FvyeGOQBVZmycmOowpPhVZahIhMOPuL8RBb8X/OQVe?=
 =?us-ascii?Q?gVdE2GTczfZGxCa99pxDpiLIE1/RmFxoNhj7skOiZoOF+08rIpy69f3iOak5?=
 =?us-ascii?Q?xmtgwzUPK8dtlM0RcyWuC4rxyuLMy7qOI0VTCfMmLiQ9lcpUg6VJi06B9c6d?=
 =?us-ascii?Q?FNgtQjy8VFk0sYo+Olcs/zFKRoqg6KrVNI5XLUF7JG/SeK5TW3ucDUOEhMtj?=
 =?us-ascii?Q?8fpK9SzdnEH9/TT0xN5UGARDyBr2IcqiMKaFADLc0qvYekef24ur7i48Uakm?=
 =?us-ascii?Q?VShOMkZffied0HfxGjLm0st+NEciJpr1zVAem3lsTgZ8z1fIDWGW2nvK5KGB?=
 =?us-ascii?Q?Ol6g5f22DxN8G/XOkMASE4LpDJLE0gKgkzEpzrTca7+ja57YribE3jQC+okb?=
 =?us-ascii?Q?7neTkJPYqI0o8nzu/cSHRafLkkTKHFur9NhoDY8GyGYghNQQw5PvjOOboJ+R?=
 =?us-ascii?Q?0YL6iMptRVaPs/c3q4O44HgoXpwZSaD2DF17zIQWqDfgBK6ADkLsc1eDwQ3a?=
 =?us-ascii?Q?x30bJUFfwnQY+cDRLxfMHGK0i6rbNcwPLwN71N8WhtVTlXeI9ZMuyxsuSc2J?=
 =?us-ascii?Q?DqoGn5MjyYMDAyJT6jjL7xsdyFvHPBU2yU/iM1wpW5/18yXw9YJNY7JEIqBV?=
 =?us-ascii?Q?J5i9Jbf88c/+nZpoE6ikuOQEuzSuew9hhFi1d30fwQCW6cBvikwAiq7ky2do?=
 =?us-ascii?Q?ox/1Jto2j5ZTV+FTuuQEvn6pX4ROft2ASmSPoxaMS4XMGwU/Hgd+mLH/FC9f?=
 =?us-ascii?Q?fWG7q7vBY1otQUQsotgjq5J5sPuyhJT2N+NDqEsc4auOgztvJEktVYRF/e80?=
 =?us-ascii?Q?y2kJCVpyAUsRnWaj0voxmo+pFI0wRtCW1X6H5xznJ0ActIgvPBbgVKCLJ78l?=
 =?us-ascii?Q?cFnZ2oytvBtxgGBPYs50TmuTZ898VHVF3+YRvQYn+5M/Ce42o3lx0tswyiRA?=
 =?us-ascii?Q?bjaO1LDXV8YyzkqXZhytxsmg7TAWzgP+lQFL+jwO993mDHLY4mId507q3qmi?=
 =?us-ascii?Q?asLF4cCBCDel+WXpaG2erJ9KlY3wxA+xpWz2Pxqh9xbvif29yJfwgtAjIS9t?=
 =?us-ascii?Q?gLN0BAmduvljYS95DWlzDAJ6vlU19Jcp2IJq2GuY6gKvlRqZUYI8CNLx8oop?=
 =?us-ascii?Q?1PpCx2IX0S44/A7WMTpik+qtUlT2RWysJVq0Aw4FxqA51xQzm4S7DHRotpWa?=
 =?us-ascii?Q?yUS/BCUl+OtcVA/I3YKrZApCk79InFCiJ4nORB5+gVvGiZTehd6Vsd9ux7CP?=
 =?us-ascii?Q?XzP8T921sCbSnKmAxDP5PeGflVqfOKgN2ckMOaXt/lScu/3dHiItmdzcribK?=
 =?us-ascii?Q?/BaHclsZVcmbwzB5kfT4vPCSJC3sxIhtXJ8+v7xEL8VJdmcIXqvhKQyh5wa+?=
 =?us-ascii?Q?AUBlR1lo0900Zwer9B6bhrBpGHV4ApN2a+S63AEmZVWcbaL6fGOMAwXZdvCt?=
 =?us-ascii?Q?+LZ3JmIU3x6OOyCLu0wdiQ55iTRmdr0IFTsd3CI8nh33cL+lYNYc0zGifMlK?=
 =?us-ascii?Q?8Jhxv1MWFNhhkEgOQYkTZbokfrQBZYx83U2g?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 12:24:42.9355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8a857f-0f85-4a0a-a570-08dda9ac1c5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101

Extend the End.X behavior to accept an output interface as an optional
attribute and make use of it when resolving a route. This is needed when
user space wants to use a link-local address as the nexthop address.

Before:

 # ip route add 2001:db8:1::/64 encap seg6local action End.X nh6 fe80::1 oif eth0 dev sr6
 # ip route add 2001:db8:2::/64 encap seg6local action End.X nh6 2001:db8:10::1 dev sr6
 $ ip -6 route show
 2001:db8:1::/64  encap seg6local action End.X nh6 fe80::1 dev sr6 metric 1024 pref medium
 2001:db8:2::/64  encap seg6local action End.X nh6 2001:db8:10::1 dev sr6 metric 1024 pref medium

After:

 # ip route add 2001:db8:1::/64 encap seg6local action End.X nh6 fe80::1 oif eth0 dev sr6
 # ip route add 2001:db8:2::/64 encap seg6local action End.X nh6 2001:db8:10::1 dev sr6
 $ ip -6 route show
 2001:db8:1::/64  encap seg6local action End.X nh6 fe80::1 oif eth0 dev sr6 metric 1024 pref medium
 2001:db8:2::/64  encap seg6local action End.X nh6 2001:db8:10::1 dev sr6 metric 1024 pref medium

Note that the oif attribute is not dumped to user space when it was not
specified (as an oif of 0) since each entry keeps track of the optional
attributes that it parsed during configuration (see struct
seg6_local_lwt::parsed_optattrs).

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/seg6_local.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index c00b78f3abad..dfa825ee870e 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -421,7 +421,7 @@ static int end_next_csid_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 static int input_action_end_x_finish(struct sk_buff *skb,
 				     struct seg6_local_lwt *slwt)
 {
-	seg6_lookup_any_nexthop(skb, &slwt->nh6, 0, false, 0);
+	seg6_lookup_any_nexthop(skb, &slwt->nh6, 0, false, slwt->oif);
 
 	return dst_input(skb);
 }
@@ -1480,7 +1480,8 @@ static struct seg6_action_desc seg6_action_table[] = {
 		.action		= SEG6_LOCAL_ACTION_END_X,
 		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_NH6),
 		.optattrs	= SEG6_F_LOCAL_COUNTERS |
-				  SEG6_F_LOCAL_FLAVORS,
+				  SEG6_F_LOCAL_FLAVORS |
+				  SEG6_F_ATTR(SEG6_LOCAL_OIF),
 		.input		= input_action_end_x,
 	},
 	{
-- 
2.49.0


