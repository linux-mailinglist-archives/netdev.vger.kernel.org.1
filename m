Return-Path: <netdev+bounces-99474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7748D4FEA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762C5282FB2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E3E286BD;
	Thu, 30 May 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iwU9nXXr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722B3D982
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086849; cv=fail; b=o9SlGXoUc/RSrCNS8A87/ID8Y+2z9CjMZvJjShLgVxnzBd5d+JMSJkjfRiknKQb4l7bVeY4/atg24R0fCa9x5LBaaavzbCdsGfPWww9F9qeNc6E/jacSeKhjj901Q4gY6TtVlRiq6ZN9sZNHeBGEiVg7v9bY8Q1we+3ieUmgUCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086849; c=relaxed/simple;
	bh=9eFbGwv4Lbw/3RuorxZafYd8L/vbh1YOVo2vVn18RN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aoJnHWRZaIszDKmyyAZeV0m9KGU1POACyjUtNjLneUqSJpTC7nI7J0bdd+5LhKXGSyn+1nzbPyl6Zxu9bs8Oudr64pJ0sEj/W7PCnMcXMmeA5uUZ0iVUlZ9yIBFTA/xnNft7e7gjpBgShtxaMvRiZbOogbyTFzNH0CV6z0vNUqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iwU9nXXr; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJ9VuXcdA9A1WaJzQmXJeK7q9uA6gfMfToof81pzUq3P+/gxm6DzNmC8G24WFKntEe2Qc5EAjREO2D5FIh9lu2Cnpo0N++cWmWeAXmFux+jvIaYB2qwdXaMV92W7WRsMLlOIwgSd95oTvL9r9oblqa5kpSbAGWRibw0DvVYbZF0ci0YcW8tHq/uL2JoXWqPUHc7TDxAU7if3KVm+uoTjgFtRpGvt/xOhIZjzavwnWncSYHnQ3jQflebvfSymS4LN7L3AiPfOOogvA7rVySa4xINO7tMcu0RlhMqrN1g8sHtGk0Way9dOH3A0xAvwwVc4hX9F/otQ7DR0ORbhamEZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7U267Jp9rFsBb6JJXqh9bVBdo4Mz0U0a7WLpahhbxw=;
 b=e16+Bpu06YTUVLBpYOa6lyamivZ8NFxDI2y34M6oH2PRfC3UgHfJKYc9gS8l12/QuYqMrTyOJ2BYk/B7ayRoX9nlL+87MTO5WNRuwgJGRNxKDSAsN2Vp4YREsz5hR2xratkGy+e6rfEb/a+seiNC3Q8L+qvvT34HFOL9f7RTswjYk5lyL27ia4DaJPH4LaSB6keIAm475KEjGq9Zj2xHbNwrhOexgOTFLs94otorLoUjYlMtisyRY1Z/dmd8YipwHi3wuydPbuydyIogZTpgeDMc+Ug4pTrztEus720QMdUiVD3KtwBI22YVIe0z7C62RWjhxOgQ+CY/kA0B3YXm9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7U267Jp9rFsBb6JJXqh9bVBdo4Mz0U0a7WLpahhbxw=;
 b=iwU9nXXrcc/ixlIUwgoLcrUE6AeUePCcFlI02RBFW/aaXomHeQwBM8iZL0VoU3jmjOLNw2flDuDxSTbkmBcVJZM1Drk1+dY4PE30SPaNuZkRtBpJiGaOj/sy29E55oJJIylL3RihXbHK/6ymRhMEq3ur9QQ1Jgy4p4VpAV+KANE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Thu, 30 May 2024 16:33:58 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 16:33:58 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next 8/8] net: dsa: ocelot: unexport felix_phylink_mac_ops and felix_switch_ops
Date: Thu, 30 May 2024 19:33:33 +0300
Message-Id: <20240530163333.2458884-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::20) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|DU0PR04MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5f8a2e-a91b-4911-f011-08dc80c64e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tVGYs0rvWfEY1POJlmzmHhVQpcwBJ109Ka+DbwJsG8TL/gP6NV82hO6RXrta?=
 =?us-ascii?Q?imzbZ3S5TmXyEZfgxdO8A4HX3kDzPfnWlTZpbkDURNoWM95eaDXyJQd+1Ovy?=
 =?us-ascii?Q?rtVdpudwtPtmzsizj5W4+bb2VTShEmSA2fA/PlelbqVnCtopqvJITlTBioZS?=
 =?us-ascii?Q?Uuc9GNVy2sPwLzuHw2t1Eu3L0wyWQssoe7o7cljDrU0XPEF/E0sK152hq0c+?=
 =?us-ascii?Q?j5osWuasnNurZ0DLLIws6Dh21eJPi4oanzPR1hL7sImKjbzw8WiafMyB6juI?=
 =?us-ascii?Q?AnYC3Dn4woRjxrsPjYj6QfrRCjaXLYw10zOxgJ3yG3OSVyKL5/8vUyeLZZm8?=
 =?us-ascii?Q?WlKj8Jn4+L2L4ozUilToFEbWfKiBAhNp6tdo+/UV8q2/GlOdI9YVjWFvAL0n?=
 =?us-ascii?Q?0Dg/zkhwwgDPADqzPMjKlsEwajA1u7U8biCzKEhSoJ+x09nNBo5wjUpSLo5r?=
 =?us-ascii?Q?mRSOu5jgA0ggjY+K9WuBYvBZEYom7tqaeI7no9Lf3QvxBdn/HS/XSmF27rgA?=
 =?us-ascii?Q?Bk6QmO6fvpqiFYeFroIG0vRfBbNrHtlq4kejKhlRutx16SZoo+qfx5U6Bpam?=
 =?us-ascii?Q?KmBWIL1sVCDXY+y/3zw9h86MLp42xGCTkEGbBhuBM7M6v66raRhxZIY6/k8v?=
 =?us-ascii?Q?FVdbH72hnauSTy5XZnL+9El2cbvkBHWAamL9WBdfnGIcN/1BVUPRZPm9gNVT?=
 =?us-ascii?Q?HSlA0MJWJn77pX6PMVj4Xr7aXzgZsKAVsV0Q9sN7t1YNOCqr5zrSGLutA6R5?=
 =?us-ascii?Q?Oi7t9xeemL4mEJJOolLySkhLcIfOxQyqnK7PpqyJ7/7sKtQ5lc+lvdtkpqZ+?=
 =?us-ascii?Q?t1xh8l+87iWDNjShVqs3tE/r81W93Mv5KuX4qGHOT4Z4Z+zUWgYOaPLSK7F4?=
 =?us-ascii?Q?qf7bfpXZ3QoOaWX0OLW1Kv6Kx2UcKGu/TQYIuV9vBkazVc53zu/w3kjqJxWA?=
 =?us-ascii?Q?bRmQb97EKR0tgF5fM2eRA/nFtiokii8WmQHGcRxVjxoGK4IgmE/tdt87oQCU?=
 =?us-ascii?Q?avgVUjwmm9o2UpFtEFZ77jQB6diC2X/9U4gDg07XKFN24dYi6LmrBP4gzauh?=
 =?us-ascii?Q?z9fvhBEHKXUMea452c5AZN0KRS98fT8RaVk1jNgL5zTSBJmzsJFayFrLOrPW?=
 =?us-ascii?Q?td4pp32pycEePFiuwYetjH7cdtvgMcd7kHtUE1GpJmiHKpBpa48X2TIfeeYa?=
 =?us-ascii?Q?0FtE0nHdfXmQ2+2XMa5R3uiSvzO8Amb3UTrD1T+gnvmnmg3OilWfQI01UIWW?=
 =?us-ascii?Q?7UNm/6JRSms7dYV6EyFOeqZBnLhcGrRA3+8YD0TE/qi94v59ha/VxNKarbXU?=
 =?us-ascii?Q?HuVOobuvpQPzsAf5WKLE4LA9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NH+tCVY+x2qQaul3lXpypuDgK0tHt16SvzU3I7v7PmEye+LqmPU4YB6YsBMk?=
 =?us-ascii?Q?eOXT2xs/lf3h4Y38oxENbtgz40giAqvfEAY58klqn6Pr+RZnAz6PfWqebjoB?=
 =?us-ascii?Q?xrExyY3RUbgyzAT7x5xXGUHqV9kipeU7IngLRy8vYkfOgFMAk8SvCX5EdBbW?=
 =?us-ascii?Q?7m8I+rofI8efbq+22Ow52nJE+0/naY6xQ+C/gOiTzWT9/BEBLPQG6jtXOxSX?=
 =?us-ascii?Q?DxRg41WUcAo8NRGNE/HlL4fMHuBVUhc7yEB9O5rFX0PeBTYZCXjd9oMGXU7v?=
 =?us-ascii?Q?J2uO1T66HG/c7NOhx7V7lq2KJpCtJ4m17BZjsIDx0nSIPsI70cEc/ZB5Kxeh?=
 =?us-ascii?Q?WzCdpHXtLKkEtIVDoH5ljSBdqr1S3pwCI3/SzgagQI6w0mKy8h3VOk4iHKPk?=
 =?us-ascii?Q?6WfNx2ATsyMHUZe6uOlaRe1z06b2ZzUxQdmpSBZKLEw5atVPxUmeI5/pl5sG?=
 =?us-ascii?Q?eGoR38cV8bFzRFl4XaRZA4x2S/Z8KudkJukdXDzYZMRDyjsJE1kTQLovTSAi?=
 =?us-ascii?Q?Bjdshm66ubDkwwRGXZJ2mi2m7UCUsu8kwHI4sLigLnYGgj4mvogd6c6vBhAp?=
 =?us-ascii?Q?KUqXlICeY0J4VScyKTSjR+uJwdfMXw8VBLVRJXZFYSuml0TzFSJ253xczAPF?=
 =?us-ascii?Q?PJ6bPrnE7km4Xlkizrb4xtRYl6xjnXsKj5uAZCRY+WK4CsWIGX9UtHLb5hmh?=
 =?us-ascii?Q?hVXJ1QurM8M4hm7SbfmIEQ9vA3MDiEvOkAFhwRFrC0xxxZueIYIUcbpCe9dD?=
 =?us-ascii?Q?dvInhL+Z+ip0fNWd/Gl1v3zD9zcPJlBWFoppBNDbyNISYxqR+/LEHBVVPsZH?=
 =?us-ascii?Q?OMu5ugKSAjIJIRHSx23idJfKvB6cppmg8brJCrKH2gcE/u4XS6WCYgP24Jdj?=
 =?us-ascii?Q?/T7Mpi3sJBRuwJjyrMoBBx0DwWCGwRUNVR1Glw8ZJbRwXL0L3TU1g97ss7Kd?=
 =?us-ascii?Q?eO870yvV9gjBSH5bgdj6cFATNIsKQfoHKSF6LNgeg3n/29Sm27H3hbLzosXa?=
 =?us-ascii?Q?RyklojZI0kOpmnPpiOU3lrY5OLNbDiuXfhEmNJe3IRKxFOJsG7UPixB+bOVV?=
 =?us-ascii?Q?eCx9Jy9BQVzjeHB7yMdp3JiOMQAv3GqfWa7a6WqbXaT6BYEI9PVque1E3aBr?=
 =?us-ascii?Q?TiB4bbBPbIoInt8qolBDybCqBwD+XfAdJtIJrIwd+F644Qd8rQ+4ds9bEXPG?=
 =?us-ascii?Q?gulVMUVh71RogaCJc0PNtRm0ugVWd1UnAPypSlYmvtf4uVgYcdU8gUv4E/8k?=
 =?us-ascii?Q?kFmyuyCU4LXatHThdAB1xJ2fCl6gFMTr6sd5pG0Yprk8Uv9yrimUSfF3bH0i?=
 =?us-ascii?Q?CcmyQ+i4Fc3s+MoMPf/ppi4lwg18jvt8Rrsc8oRAiHEzd/O37NI4wAS58VYH?=
 =?us-ascii?Q?fqz4V8dyOsR4Os2bRYoKjfAk0LSZmDocesDEWdKYD0Y3nvNpsbd80AIPxTFK?=
 =?us-ascii?Q?Dx9XP2/pZQHRRKKgAr7igdIenhPfLjlYORIsdGa00/wZthCHfMdYEnDy/UP1?=
 =?us-ascii?Q?DqpjYumGbFRbGg/zQ/iQ9QiA9GeQ8warCx1zFGFHB4tbFoYqQoTBBXqj8Y16?=
 =?us-ascii?Q?Cg/2X5zbVEEmBGwGmIYKCsKcnXAaCyYYRyVino0YKbQz5eX71SE4KE5ga3va?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5f8a2e-a91b-4911-f011-08dc80c64e52
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:33:58.6733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mc9fH361sZ4GLwWmQiraD4AN1EoTyE98WZj5yFmtFM2wZEBiSQwWmhjXPCfiaUY1LrjEGPC5jGDgxnSRlILUTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

Now that the common felix_register_switch() from the umbrella driver
is the only entity that accesses these data structures, we can remove
them from the list of the exported symbols.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.c | 6 ++----
 drivers/net/dsa/ocelot/felix.h | 3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index accf737f7b69..d12c4e85baa7 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -2106,15 +2106,14 @@ static void felix_get_mm_stats(struct dsa_switch *ds, int port,
 	ocelot_port_get_mm_stats(ocelot, port, stats);
 }
 
-const struct phylink_mac_ops felix_phylink_mac_ops = {
+static const struct phylink_mac_ops felix_phylink_mac_ops = {
 	.mac_select_pcs		= felix_phylink_mac_select_pcs,
 	.mac_config		= felix_phylink_mac_config,
 	.mac_link_down		= felix_phylink_mac_link_down,
 	.mac_link_up		= felix_phylink_mac_link_up,
 };
-EXPORT_SYMBOL_GPL(felix_phylink_mac_ops);
 
-const struct dsa_switch_ops felix_switch_ops = {
+static const struct dsa_switch_ops felix_switch_ops = {
 	.get_tag_protocol		= felix_get_tag_protocol,
 	.change_tag_protocol		= felix_change_tag_protocol,
 	.connect_tag_protocol		= felix_connect_tag_protocol,
@@ -2193,7 +2192,6 @@ const struct dsa_switch_ops felix_switch_ops = {
 	.port_set_host_flood		= felix_port_set_host_flood,
 	.port_change_conduit		= felix_port_change_conduit,
 };
-EXPORT_SYMBOL_GPL(felix_switch_ops);
 
 int felix_register_switch(struct device *dev, resource_size_t switch_base,
 			  int num_flooding_pgids, bool ptp,
diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/felix.h
index 85b4f8616003..211991f494e3 100644
--- a/drivers/net/dsa/ocelot/felix.h
+++ b/drivers/net/dsa/ocelot/felix.h
@@ -82,9 +82,6 @@ struct felix_tag_proto_ops {
 			      struct netlink_ext_ack *extack);
 };
 
-extern const struct phylink_mac_ops felix_phylink_mac_ops;
-extern const struct dsa_switch_ops felix_switch_ops;
-
 /* DSA glue / front-end for struct ocelot */
 struct felix {
 	struct dsa_switch		*ds;
-- 
2.34.1


