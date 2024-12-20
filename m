Return-Path: <netdev+bounces-153827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B6F9F9C95
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 23:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587911893AB9
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2808F228380;
	Fri, 20 Dec 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pIQwnL+4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1DF22655E
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732374; cv=fail; b=pfGXQ1TSNDvz6yw8pYLAdPSomXpkj3RMd3P2BMXPx3PE12GV39BLITKsSy1BxBxLZg0NYj0RHn5AEy+AlHoBWSStOhtZtb6olaXX9QpqGL4SioCLjr8sagqX0WpAerYwZU3NfKQKdIhfzoqUicvqkATMryaB49mtK8EafZHtjeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732374; c=relaxed/simple;
	bh=Au92aeEbSsD9dPCZZlKgp+wcqqEip6T9BHrK8znS6no=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajoIGfLxiZ3blKB2/c9fx5fHNVCG73vMVE4oR8y00ukYuqFiK1TwVobV3aJ6A9St7tZBuM52pCYD6Y6bDwMCRMUqlBHrWK8elc0BeoyAF0T+MT4LvujxWoexNd3wTV2aDWbD+7+zTuACo+LZGoL/p7SDx9r2s+hDS16RGsXsKnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pIQwnL+4; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIu7SNAB9mPZeJmPwV215HuzL1HbNhkPqFqzLewOQ1lhCKyCe6nnS8iRN1BUtJpsLTcF2FiGq/eykW0+tQeXjohEE3KVv4wziqSkWHUEh+CNHkU7GJesShNfTFYIf3+I4JoeC6qsZEqNc0uCrHrT4gKj4RhcfIao6+IfQYUkgj48q4IdVfggSIB+JAG3ZqRJ3TPnysanerTkQ2TbvB4V97/BCAAYH5jqVV9nXGQ2z1DBGghWeAUsblXQ6VpRv9Vbo9kIczuTia8YiWfPuxeEoABuOxttwa6cFO5fZ2nVXH82l7zrtKSqId4hVFUBcebw1Thcl9ARWyYzuuvmHjdc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjuzavLf52+DXYIN8ietyyyR/W/HPl5UjDjvJHV2IdE=;
 b=V5riAkbUoiUDM7mcsNJx3F7pgY8th/hfe/Wud86S0GkNgnB7barTom5WFypOQk1Bw2kF3em7TtS3Xc2Kmel3rzB7Ju24vKd0J+oCO/DM/A1VvHyFkc9pGTRDDHSbSdQ3yoE7RDtL4OTYLJcjyZ6voRd4eagEu4dlSh3Pr7fB/dk0Yc0ugYfVaH89Yds06a2+DAIC4juFDNHHhx4S2GvHsTBAviF2Gge8Hu1J6Lsb4M2HiuZzRtS7iu1EuvrjFK5AOGP1RcZuCg3JODS2kR8DYSS7y98bRWTap3cLZc0tw1TkICiFyThhsWy8daRafj2gRqyv9sADtCCxvcMucMZk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjuzavLf52+DXYIN8ietyyyR/W/HPl5UjDjvJHV2IdE=;
 b=pIQwnL+4DF/xXdvlwqZZ/CLT9oB3PbpmPNGbkkOMMJIhXwR3A0qPiWsGCKCEPWzRWItRk+ylLEP4wqa6hkk7cviXfZx6IHL6gJtYEmx7JdFsSYyLQ1PC9LJ9ErhZOypl15WCmAI/l4Dh0LSCQ+PGkccme3oaBkxksJ2YREXflGHSybrbmEIYoT567mOHuo06TkVkZWlhEvzLJJUFOFC/HBZGe9wAGvRvRuSi1Gut22anVFHr1+3++YT8ZrOKjyTfDRZ6FBW7+OaX8pwt6MkFti9R4KsD5hTEFzrS1jvQNi0bCPYJakPbC4ppdC3oeZgO4IpfRPhbpScOi2JOsvYHAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 22:06:07 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%6]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 22:06:07 +0000
From: Yong Wang <yongwang@nvidia.com>
To: razor@blackwall.org,
	roopa@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: aroulin@nvidia.com,
	idosch@nvidia.com,
	nmiyar@nvidia.com
Subject: [PATCH net-next 1/2] net: bridge: multicast: re-implement port multicast enable/disable functions
Date: Fri, 20 Dec 2024 14:06:03 -0800
Message-Id: <20241220220604.1430728-2-yongwang@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220220604.1430728-1-yongwang@nvidia.com>
References: <20241220220604.1430728-1-yongwang@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::28) To CH2PR12MB4858.namprd12.prod.outlook.com
 (2603:10b6:610:67::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4858:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6d1c34-92dd-43b9-2fb5-08dd21428149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/+mAcyLrH7mvzFcH1TwE3VzPRlgRBLrX0anJUFk6TxMJrfNdskeMO2pobpU6?=
 =?us-ascii?Q?SepBeRocUUuCvt/XwP2WPAcO4djp0KcdAycK1pIapKFewbngalZ7REkVjxf1?=
 =?us-ascii?Q?x/l3TAkJb0KQRYr5M+6alhlNXy1Ev9uSdbAJcZsykz1zCAMvJFuqnzBxlNQX?=
 =?us-ascii?Q?YRhBMt8Rn470eFx1pnHDXc9DwstqxbfqgjdWv2sbcR4ghkFypLh/fZxK4Li5?=
 =?us-ascii?Q?PT9r3+MFeniRtSv7m0Mrv5L8r5r0+zHC0t9ojQjqDm2L6unHq/rloFK3f4Cy?=
 =?us-ascii?Q?B07xb1Q+2T1ciy4Mely00mJejXOuqSKPie+2ynZQWOSlb48U1NH3KWhOp8vw?=
 =?us-ascii?Q?tUAARwtTjsIui8lB5fAEP1I+QtNFteNKnTm7LNdPcK7c3NgyUzw99Oxy7cx4?=
 =?us-ascii?Q?z5itwghumWSWwdruK33HbZAYRyYyGRTFuWonPZydqncS9Rdij7UExTv3L8ZD?=
 =?us-ascii?Q?iibTCybKUFkrsPDsyIOq38jcI5RGth4lkCIdLEZsI/Kx1cxy83iKutk7Tszt?=
 =?us-ascii?Q?MrJWIjqMsNA/JrZU324JwYYFDjC6REs3vtfxba7uFU6sV6juE7IVotG/u+BB?=
 =?us-ascii?Q?Wja371jBeY7DyB6nHaMXBdEqQZkyYnRm6FGS/5iW6xwr5yjCPx1MbH7dNbZq?=
 =?us-ascii?Q?6fYNDBB6HdqFIk5cVV+kweS/jxTanE7ieA07NQgXEajGr1WOHGRm5hh9QnuT?=
 =?us-ascii?Q?ygq6AkuSDpqX7kDUntbXR6KOMCsMw4mBxI3KWG2hJqMkfk2EguVNLhI3XIPf?=
 =?us-ascii?Q?kRzUigC+s0TnuHbpQBHa06yrE9UUwGx94ePSnJCoKeUsaZmUbhK06+QW7lw4?=
 =?us-ascii?Q?BHzuBhyTL1pMnmea9lN1NAHUVesNYcA6xbGmzdhAseIbSyUpAHQg/32Iwr7e?=
 =?us-ascii?Q?UmhXYYiX1jKx7OqUKICAVZPC5dqCBwjahpjjWqXKaaBpmBUgsn6miy7TMELV?=
 =?us-ascii?Q?8FFxtgjOGEc6ZcQQ7oJiEQpJX3yDbwS+lMK74pi82deKOrpPrDQ1DbQRiZtJ?=
 =?us-ascii?Q?SH2OHhSL4AqASS8xBT1U7IRIXe2x31+53ExLWV+uv4nP1X1fGIeOfCmiRpHB?=
 =?us-ascii?Q?43i6QzA6xAe2dAaz5iuN9tWV0ywD1LrVOlRnOWhqKDS3Kq7KDNNpecmAvitx?=
 =?us-ascii?Q?nKq9Vej45KC93hBvJ+y+JZ4SFTrJfwI03piOZjmYMjHHe/1UZf1dJhTjhz/W?=
 =?us-ascii?Q?GfmT2LPCnHrH6ma713Tmmrfcee6yNGhULFesCXXXcsnZuTXKV8uf295LSnPA?=
 =?us-ascii?Q?Auhzt6a563z7d7h6kRjJfsmB3LNG6nWxVKqy26wIYUog++eYVLjfEv16QLI9?=
 =?us-ascii?Q?zImTlpnxuf8inDJqL1v5jWbIN5jVLd3Pz+1ywKN5Y44I38b6B/EUEIipSmOv?=
 =?us-ascii?Q?JkOGujURjhlAmANv0/oVCm9G/Xnx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gHqxKUDXvDHrQf/QAvQEsCrZR5Q5V16OoXpsPkYr4Rk0GFUiV1R9aQ01To7p?=
 =?us-ascii?Q?MByjApZepf4wSQgsqf5AKtDr5rT7F/dPmWPfDL0VYx5zkNX/dl/rNOnyISRT?=
 =?us-ascii?Q?LdnqVPAGi6NO16F9zZXvz2mQBkGiN3HbzZD2y8LS52F8sd7W/EJmI/ri7RTz?=
 =?us-ascii?Q?A9a9gH93R8ZqimSlTVM5uQyAV/T2Ufk35jU1CtsMeMyAXCVYpWbRADa7tuT0?=
 =?us-ascii?Q?MS83lMopztazrtNkIj4W1dQNH8iKDYCudGI8YZ39KikdOKTTLwffIh8Wob3P?=
 =?us-ascii?Q?WxaHjYEIH1Hxuvl9yBnGwZ3KimL12FK8xJ/4OaR49Qai8xeCSTSZO8AHma5P?=
 =?us-ascii?Q?ZwmQWJuVyc4WZSQgnufO9MmPC7eT19/Pu0YosKwSBJAyECXqqBl2AYMYF+/+?=
 =?us-ascii?Q?yIwac5IhqKNOAvqxNZPCBDrr0Dr46r4GGxHWzgy8cpk9l/iwz7uM7zmMBVKk?=
 =?us-ascii?Q?oEg3QGQ86XsRqF9LcJFtcobp/VcqylCBH/aSrsFOWfPBEPSgjbct9FPh+pVq?=
 =?us-ascii?Q?W5vDqf4+4vOJKHPTNfjHkiQfZ+Q4U/IL/tW6Ay7m1cb8T0IZiJbbByIZXB65?=
 =?us-ascii?Q?CuesIX4sbLs1sBohs5ypnGG2B1WX85Xu42CM5xIyuA2qNSOoTJL79cDroEP0?=
 =?us-ascii?Q?T7G8ld3gJmrPkRpC8hEZUlur63SiN/hjyNYvvhJbH3mWpFAUDkexsRxCDAdo?=
 =?us-ascii?Q?dd6SHOPcuX/DZqoi+qK0/T/Yez4Rp9ZD0XallC9Gjb7eRGHoL8Ok93ht4BiG?=
 =?us-ascii?Q?BanlZOdsZDkir1cPPicwTNcYAI10hF6Yy+cBE7Hs5eMhiuU/dcQaS3gjuSLT?=
 =?us-ascii?Q?wXynqBNFNncZRGihRzoUn8OBFA0J6I7oQX2XL3URHqSeQrG5Ztc4QregIoqx?=
 =?us-ascii?Q?u32Or+LSUD/9waML8/Kv/Ip3UGCERFNpYGWXmxZSnpbKw410IKb3dymY0I/p?=
 =?us-ascii?Q?7ZVrWxhOxkFXQiYqUQ3mM6Xs1Vo3mkim4L94fjxdHbmImI94z6HPUS9fCVjF?=
 =?us-ascii?Q?bSHOHYI3quTsRDTsI7j/a9Fjb4EZ6Bxhptw43m36EiDuFROe+vto0iRVVWkB?=
 =?us-ascii?Q?JTLOFXDlb4VPQGwZ7VM9+6tuQ9nA3wFyL3JZjmJHmkXde37oFqA/QEaRQZoF?=
 =?us-ascii?Q?Bu6NijhiNu00gsrGyYHhK5Z4nah2FuIa6ZKL/vTfdIADuKo1kVUZAblUQSug?=
 =?us-ascii?Q?awQXNf96COSi9kAniVzPna9nw6esH0doRcacXGWe3UbBTZmYjoP7TH5tFClW?=
 =?us-ascii?Q?nH9B3nKogtjs0paptmfrnfOcEp1quP44ppx2JQP3VNq9YULrcj20Zybp+pGe?=
 =?us-ascii?Q?XUWGP6zT2aN9XPlmo7EWaAXm2p5d+EHjH562PeTOOSHW/AlfG6vkea+1z7Gk?=
 =?us-ascii?Q?1ts4zoq88n3xFCyqj224yDLtRfS4W6icHAM5oNbGo5oUQidgwbl+ZD2gbGpk?=
 =?us-ascii?Q?yyE81cUZTvqE3fRlDunvu+c5YfLZTs9dcPrEl5IGeBegDHHhrbdZ+U3J/vv0?=
 =?us-ascii?Q?zLlei+5j3wlWGXtLdIrKrSrjULI9WTT0xjYDRqDa65z6z3z8+pd1EUiIjqqO?=
 =?us-ascii?Q?Z4oE30B5rUGTjCI3kejXHVp+WSrrFn+VS6hffR1I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6d1c34-92dd-43b9-2fb5-08dd21428149
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 22:06:07.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3e9jbOHdpiJRo+k+b6MN8LMGI8Lpq/BUYErbzFag1ovDG2N0sUZYnr5TKlaARw8lzNzocAwc9IbrL8Zy8viOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

Re-implement br_multicast_enable_port() / br_multicast_disable_port() by
adding br_multicast_toggle_port() helper function in order to support
per vlan multicast context enabling/disabling for bridge ports. As the
port state could be changed by STP, that impacts multicast behaviors
like igmp query. The corresponding context should be used either for
per port context or per vlan context accordingly.

Signed-off-by: Yong Wang <yongwang@nvidia.com>
Reviewed-by: Andy Roulin <aroulin@nvidia.com>
---
 net/bridge/br_multicast.c | 72 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b2ae0d2434d2..969a68a64a7b 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2105,12 +2105,17 @@ static void __br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	}
 }
 
-void br_multicast_enable_port(struct net_bridge_port *port)
+static void br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 {
-	struct net_bridge *br = port->br;
+	struct net_bridge *br = pmctx->port->br;
 
 	spin_lock_bh(&br->multicast_lock);
-	__br_multicast_enable_port_ctx(&port->multicast_ctx);
+	if (br_multicast_port_ctx_is_vlan(pmctx) &&
+	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+		spin_unlock_bh(&br->multicast_lock);
+		return;
+	}
+	__br_multicast_enable_port_ctx(pmctx);
 	spin_unlock_bh(&br->multicast_lock);
 }
 
@@ -2137,11 +2142,62 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	br_multicast_rport_del_notify(pmctx, del);
 }
 
+static void br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
+{
+	struct net_bridge *br = pmctx->port->br;
+
+	spin_lock_bh(&br->multicast_lock);
+	if (br_multicast_port_ctx_is_vlan(pmctx) &&
+	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+		spin_unlock_bh(&br->multicast_lock);
+		return;
+	}
+
+	__br_multicast_disable_port_ctx(pmctx);
+	spin_unlock_bh(&br->multicast_lock);
+}
+
+static void br_multicast_toggle_port(struct net_bridge_port *port, bool on)
+{
+	struct net_bridge *br = port->br;
+
+	if (br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
+		struct net_bridge_vlan_group *vg;
+		struct net_bridge_vlan *vlan;
+
+		rcu_read_lock();
+		vg = nbp_vlan_group_rcu(port);
+		if (!vg) {
+			rcu_read_unlock();
+			return;
+		}
+
+		/* iterate each vlan of the port, toggle port_mcast_ctx per vlan */
+		list_for_each_entry_rcu(vlan, &vg->vlan_list, vlist) {
+			/* enable port_mcast_ctx when vlan is LEARNING or FORWARDING */
+			if (on && br_vlan_state_allowed(br_vlan_get_state(vlan), true))
+				br_multicast_enable_port_ctx(&vlan->port_mcast_ctx);
+			else
+				br_multicast_disable_port_ctx(&vlan->port_mcast_ctx);
+		}
+		rcu_read_unlock();
+	} else {
+		/* use the port's multicast context when vlan snooping is disabled */
+		if (on)
+			br_multicast_enable_port_ctx(&port->multicast_ctx);
+		else
+			br_multicast_disable_port_ctx(&port->multicast_ctx);
+	}
+}
+
+void br_multicast_enable_port(struct net_bridge_port *port)
+{
+	br_multicast_toggle_port(port, true);
+}
+
 void br_multicast_disable_port(struct net_bridge_port *port)
 {
-	spin_lock_bh(&port->br->multicast_lock);
-	__br_multicast_disable_port_ctx(&port->multicast_ctx);
-	spin_unlock_bh(&port->br->multicast_lock);
+	br_multicast_toggle_port(port, false);
 }
 
 static int __grp_src_delete_marked(struct net_bridge_port_group *pg)
@@ -4304,9 +4360,9 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 		__br_multicast_open(&br->multicast_ctx);
 	list_for_each_entry(p, &br->port_list, list) {
 		if (on)
-			br_multicast_disable_port(p);
+			br_multicast_disable_port_ctx(&p->multicast_ctx);
 		else
-			br_multicast_enable_port(p);
+			br_multicast_enable_port_ctx(&p->multicast_ctx);
 	}
 
 	list_for_each_entry(vlan, &vg->vlan_list, vlist)
-- 
2.34.1


