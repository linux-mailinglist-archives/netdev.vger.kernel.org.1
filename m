Return-Path: <netdev+bounces-151795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA0E9F0EB0
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7889283B50
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48E11E2306;
	Fri, 13 Dec 2024 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VsP0ehcv"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058A1E25E7
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098964; cv=fail; b=ascpZRZIgxZ1/8I8cFYfJsw5BaG6aKK3t8qTyhMA5CMrJNRw7iFU8SB/cxEoH5SmeoN5Fad206tF7JkrqyfWQfIEQ0m9q/1RZwIeTc001ZdIHUApF4lxgMfKPKRPXy79c4F7aH8Cij0sR0KAQeBE9b89aEmmJ29BqTxhr24gn80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098964; c=relaxed/simple;
	bh=N/8ciaZAOIwCZOH/8WkkEcnpAVYkB7b0fEoEOwChONs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OdwUJscBcrNdGEJ4IhdUOGCqsaRlBymZb0IrooaAGfqd/eSXV/aR+y7aVdP0BwncNfHJbyDBrDMv8tvnjy7iC+PcDT7Jb7SxA+mKfG5UWg+x7z3HEXLFfb92wIp6TaR/5+Plp6y8wlXS6Y6nfr8oqhq5SBtuc/b1Bw+nt+/PG5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VsP0ehcv; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/MdM9SsiAefqhgR15crSLhEr28GUdRLlYBelUxM2eNBP4HVZLlFbS2fhT81sFDbUVXTITXoulld8UWtC2gAqKv6CiWm/AXDRyZ8+l0o7grILPpRPi6ZmfRn77BXqHM4NvCCfeTPuda4+oqgXY6zSNyqszETJvwmUTA2TxxnvYmBvSfWWo/vxiycMuNMOnL/ka0hcV/c5YTiuCqtstxepg2JmPwbmnEg7k9duXaHc4Cohax4H3deRI2VFqsaRE+zQk1ebjIGl/9aKwygJ4gjVaTKLx4qXUL0UG9EkjQWOihipDQP2rah5S1L0Z8G+gi/qj1yzNP5CbOZXhl/tzdJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouD43Bel0llkt9tlkg0dhfIVy/RXCQhWfbTcqDk8zR0=;
 b=q9Va2KrG70hyBA2EfV1AHsEJqdKZj33kxjPNDhxNm0/NrXkZPaTZ5aGqNo90+ulQSwpvvIjvlU7xN/CrAfWv6EMQtwII5n0Sq0G4caP8OLp1f6FUvWd+ucdy7SS/KHOf52k0PpxcUgfrhfY/TyRnuhytHUy6lvtdVeGMeOcrXaLsx5L2jUR+7AocC6IQBFJ+MJoFBxpBJ3wanaz8BNrt1e7fDHvjnu4xjDrsHty0lilpV+OM0H01Phc1RfYRm4jsRE4JMiBT+0vG3Iu5ZpyXk/TAAMk7W9wazsev0icrQoQixxCPUzvJDpY2Kt02dJIjTCo6oEXAbCEBHxUjreW3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouD43Bel0llkt9tlkg0dhfIVy/RXCQhWfbTcqDk8zR0=;
 b=VsP0ehcvx4Q1uH89huKArx1zCEdyv6tkpdfcu7TBJPng7bD1bGaDMg4LyhKZ3haGHj1s0BwiAtPXYJFcE4gKQJJYslNsZs2yw0BdHoMxrWEmGAoOjhzc/hQy3tOBSS11JLbz6N3YIqOZW5fj416VaWq1ANo4A41BTwIIVHwdBaj1mNpb1ZZDrWt4BVGbpzkuJbTGgQuF2M9vMvTnPJx5gIt1dx36rSGsrPONDL1cC0BqybZEOwaaQbY7NXwplxpoM93urSQGSVOe+wFOL4D9Qg1yY0f09kkn3rkjUKfWgIrpt6UAEFjFFMpbKA9CiMHy4iHNCbI8ue3rkzN8ghfYCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8780.eurprd04.prod.outlook.com (2603:10a6:20b:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 14:09:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:09:15 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next 2/4] net: dsa: implement get_ts_stats ethtool operation for user ports
Date: Fri, 13 Dec 2024 16:08:50 +0200
Message-ID: <20241213140852.1254063-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213140852.1254063-1-vladimir.oltean@nxp.com>
References: <20241213140852.1254063-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbc92db-c764-4e7f-5e2b-08dd1b7fba26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9VWCsVf7w/vLaWIwei5UdJtlrJSnGtLkkKeFF56TMZd+eZ6kk6AZ4lMmpc9D?=
 =?us-ascii?Q?iJUlRozT22na42918IihT+fd7b1S4+4m8+Qj6T9gTTxcCCm9ypDrbx5YE/GW?=
 =?us-ascii?Q?xlgUA4A7H5ZHJ0Soc7Pi5hfkkNDNHFUHSsFoNjKBaZiimFgr3mtuJ6XBffk6?=
 =?us-ascii?Q?M9QauLKyS5ncpmFgY4QlktlCJFJNmwVHNEFlJCZShWh/01WSXrQUrOY4QfBM?=
 =?us-ascii?Q?YhguasxIqQGxJCJFWUxbCdhwepHgBu1hTnVGuwolo9J9Q2ciO3ZFvJZ7wehq?=
 =?us-ascii?Q?Lac0igVCmhjsCV6NPQkmQTtSvS2dhuhpYnxoSo+48vjn5G1oPPEhT8QTJiPa?=
 =?us-ascii?Q?1vmvgaLI1QJHrz/IGAqqIT/bhvt6t1bIB6r+g1aNEC+VVYvit7ifT1aZ+dmF?=
 =?us-ascii?Q?znGYfHmHNDTiCS0gPic0N8N4ybpjFWRM5GuvjzslMuSNij/XN02PE+Ds45PL?=
 =?us-ascii?Q?WnAzKD0aYFzJgYTqxgd7G1Mev6/UQncBvRWNt04SglATCSFfg3VW5vik17bU?=
 =?us-ascii?Q?oNU9Q2eEnJXA6ZblK3aZPpJ1hW9BI4SotA83Osj5KBqA5UzX50jOQJyeJksv?=
 =?us-ascii?Q?vGoT8L09e7Ldl/mvSpjFpZ8HWWm1Vup9Cf6i2yRWHUarA3S3TFxtR/EuUCjO?=
 =?us-ascii?Q?LmjfUlAslXEyDsJeE0XGogbWeR/kJMpJfon4DWgTeaZVgDiqD5fRZiY2gaw+?=
 =?us-ascii?Q?l2bzrnGsfw0HIS9U9+fX7/TG9g63rvjnh8deRrVUEF+lm6zw2oQ1cru46rvV?=
 =?us-ascii?Q?FiZIxQU+TmXVeZHJ6K34AJnCZRUk5c6XQnDofzna0JCDAbOYheAGnyc49xJd?=
 =?us-ascii?Q?6KHRndva0DIxEVT93gyWN+aL6sY4LrUqUQn3WKolh8ewY3yMExC+5jzl2d94?=
 =?us-ascii?Q?c9TiRgnvKidufS+DJPQKL/1NaNVksUp4nqyJeDw09+g9+1nQ8ENUnq3EfBaB?=
 =?us-ascii?Q?RgymdjGSftpqRu87IQRO0j96pp0h06EVY19RyFy3vNlqun45LQjNZaoiXvST?=
 =?us-ascii?Q?80aiS/cwHCL47p2n47980S0dPZZmhSpnrYtBHbr9k+TyhmzvlE7mVlsteHuZ?=
 =?us-ascii?Q?tzO6nhjI0wALM8P4EreZl+rFfyd07QyUIf/ZDoutiF0PaD0m/ZlTz170GKEI?=
 =?us-ascii?Q?jzssuu7klzL3YPkWARMixaT307vNzAc0UwauK09m5HFoQF2PtCzZDNN+Z1ks?=
 =?us-ascii?Q?yU4KONY3ONWtEqM6V7gwGwGyp5nVpQyetuj3CayLebC09tQwNLGFKem694YF?=
 =?us-ascii?Q?kXIeJyvBIsZEdu3j1MWJoYImj1/oGXrqT2pIk1rFQo68ZLi7cqW8oy0wEsjb?=
 =?us-ascii?Q?gnAmoVh5pX7nmb1QoaXA2hkGnL8apXtQwXr/0DiqNkNgZdr6lrtdPvrlwfi7?=
 =?us-ascii?Q?dgIvqltbnXItMFpbp/0pevQSj6prSNV+IIfi+R1TfMeISqSZrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ovL/ji+q9OQ/rHeWBOJypnEOnHvXN9rK90gHZAnVKB5bnusK0LcAfi3EM/N9?=
 =?us-ascii?Q?zGePmZvgoRkv7bAIUhG3+KaVUn+WagcSk2x+LkydKoutgnVOjA/hEa0eZ9Wv?=
 =?us-ascii?Q?QSsr4Uk/VcjuabPyI69+XQwibb0xL6V6YjZXE60BnuYDv+bDSgWYnScuhDx0?=
 =?us-ascii?Q?xC+Oo440rDyeBL5g/Ef0OjKvANcIAPPQFZG5YkNghIPVpQwUmUOeCTPHB8Kp?=
 =?us-ascii?Q?9Smr5NEfePOmqeAXaHFPNn4aU1hUtiR4vHvEaKm4TZiKwh1ZLDAGgbnZfSCE?=
 =?us-ascii?Q?sZgGMdql4c8c3sQ/KteOJxOPI5jzNme10wyLnAA5KO5gpc+Uul9JEZhqRCjk?=
 =?us-ascii?Q?o0QhyL2FAh80zBDXI6mcAlILm0dmTJI7JkPH8j4RgPjz4HT8IHy4dpfPTdZS?=
 =?us-ascii?Q?hD3JWAmtPQNKUZAAJ2Qz7QvKLyWXaV+CHZUR4ypSZBvSKEHVR1NQmLatWyYV?=
 =?us-ascii?Q?+vK74sh1kWZpiXIczq3qslRtC5TNuVrKjqFGh4IAUpCEK8brhpNVyUDfxfWe?=
 =?us-ascii?Q?YOhcfu2lOO79bSv6n7Xfts2gxYaW5aQb80GneWpGIYyHjrFM09TNaK04Ztir?=
 =?us-ascii?Q?av0C7WpGrh20cEK0WFErqicIPIbKgrBALQfYwqcdrlAHyfuBqX67e63gt9lH?=
 =?us-ascii?Q?0nmYZdbgx0qQbjHW/OovY1P20nFBjefT5O+oQ3n/Ubpq1GCSabZwV7Xzok2G?=
 =?us-ascii?Q?pvBJwJjHdpZXnpNjEr9EvdSbcFbH5CSw+9zRLBMVbLS+ui1bZMVPmqfTrh9O?=
 =?us-ascii?Q?H2Ab+396DZzmRmR5ELyiie+i/n+q4lAuTZRnTOkIOO/IymXT/wh4ofcNNF4Q?=
 =?us-ascii?Q?UvaznMevW/uKvMfwvWWLm0UZhLtKRta+LLyqAZy2L8V5OcRRCLqvFRI6sEgE?=
 =?us-ascii?Q?jyT7KqyvpUYyWqALcIR+0g/aM15Y/mX9EADJEZMjNdxBlQzA5JXH7YpdLfYO?=
 =?us-ascii?Q?SxXLHNIExmYyJtXsPgxc6JgSORGBrtUL+a525UiJI+Jt+eE3vlfo9Nh9V05g?=
 =?us-ascii?Q?aX5c+VH6n2l/ZuKa6DZIgPcsQc6jfPI6Tcw+t/GsGh151svV8rp2B+E4EEVn?=
 =?us-ascii?Q?Y2fe+03jZ+gcLTdxUEoaS3v8y5EcoDgXCsQiNXVozNivd56yS9WtvfVD6Nep?=
 =?us-ascii?Q?vpIP8K59eHl/peH3oGdjasqQ6gOF85VnHODJ1Eea7Avst6x3hjy9IHWq849J?=
 =?us-ascii?Q?9VfUoqhV0bHn6kZgY98I3RjhRSx9IFFFPgs8Vdnb7xL9VI85ZHS4BYGT3c8f?=
 =?us-ascii?Q?Ai8BGBUzYfQyHug1IIBncqLeyKJ6pYoqCvIftBfOGAKEjSUYs+TSgSaqwHoI?=
 =?us-ascii?Q?tjt1WUGLdXI4l0IwDaaXGNF7LeEfKITk3MjzhIuMQ2gJppOHxXcL12ELK0wp?=
 =?us-ascii?Q?VQ/ofG9IRUi2Ik5OEcD26DdYF3xcSfv0sNKuGAJElUtOYT3TnbW9r+r2usGT?=
 =?us-ascii?Q?x06GlmdT2yJvJef/3y5xzLWkgEjnKC70Zva6dljIialb6ui2Ahp/UXEkRgkt?=
 =?us-ascii?Q?drqnYxKIr2rKqS9jo/qXQEiUpRCcAC6LXQJPouYBuVA1xutm/aMfGoVCzrtV?=
 =?us-ascii?Q?1PZUVDjWqcGi7WBqRmwwazlW1mzufCN2V36fXlyvl40BMH5uYJIQOhIMO+Rf?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbc92db-c764-4e7f-5e2b-08dd1b7fba26
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:09:15.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqcswDYUDFtdawmINkM4VnWNFxoNZ1W0uLzxHVI3kuDW9/YVMMJw2HnCfoHtPwPZXuDvDeeRcPLD6QMSWxQf2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8780

Integrate with the standard infrastructure for reporting hardware packet
timestamping statistics.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/dsa.h |  2 ++
 net/dsa/user.c    | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 4aeedb296d67..d9dc1eb6dcd7 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -906,6 +906,8 @@ struct dsa_switch_ops {
 	void	(*get_rmon_stats)(struct dsa_switch *ds, int port,
 				  struct ethtool_rmon_stats *rmon_stats,
 				  const struct ethtool_rmon_hist_range **ranges);
+	void	(*get_ts_stats)(struct dsa_switch *ds, int port,
+				struct ethtool_ts_stats *ts_stats);
 	void	(*get_stats64)(struct dsa_switch *ds, int port,
 				   struct rtnl_link_stats64 *s);
 	void	(*get_pause_stats)(struct dsa_switch *ds, int port,
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 4a8de48a6f24..b777e0727036 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1150,6 +1150,16 @@ dsa_user_get_rmon_stats(struct net_device *dev,
 		ds->ops->get_rmon_stats(ds, dp->index, rmon_stats, ranges);
 }
 
+static void dsa_user_get_ts_stats(struct net_device *dev,
+				  struct ethtool_ts_stats *ts_stats)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+
+	if (ds->ops->get_ts_stats)
+		ds->ops->get_ts_stats(ds, dp->index, ts_stats);
+}
+
 static void dsa_user_net_selftest(struct net_device *ndev,
 				  struct ethtool_test *etest, u64 *buf)
 {
@@ -2509,6 +2519,7 @@ static const struct ethtool_ops dsa_user_ethtool_ops = {
 	.get_eth_mac_stats	= dsa_user_get_eth_mac_stats,
 	.get_eth_ctrl_stats	= dsa_user_get_eth_ctrl_stats,
 	.get_rmon_stats		= dsa_user_get_rmon_stats,
+	.get_ts_stats		= dsa_user_get_ts_stats,
 	.set_wol		= dsa_user_set_wol,
 	.get_wol		= dsa_user_get_wol,
 	.set_eee		= dsa_user_set_eee,
-- 
2.43.0


