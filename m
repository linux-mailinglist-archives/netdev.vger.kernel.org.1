Return-Path: <netdev+bounces-158847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB94FA1383B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506881680A4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D1F1DDA00;
	Thu, 16 Jan 2025 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iDLZrTbo"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2048.outbound.protection.outlook.com [40.107.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A461C1DE2C0
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024410; cv=fail; b=PH3Uvz/qmRoNJHkRHu5d1XGn8X/JZCVmcMs4uqrKfvNG2hUlyUY+HXyJ7t6wXoDTsb1PPhdJgz9ZBQpU1ynAzNAdqPPlCchnC512Xz5vf4f3zeV8X4fe50ON1J6DhKE/COgzRHFTlvOoFKBzCAAoNBPBktaML5SBRgXmUVl1pKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024410; c=relaxed/simple;
	bh=VyXE3Tl/IQsLvR/FQ0lQU9J40w7WfdlzxF3enZNGzps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nlr2RkQrNvkMNUijITZiQXFWlw2XihPIni8qTPfeQDgUTkCo3w8/hNEYkcKhPAh70f0TrZmgV7lNKCgyslynVLEHOOYXJiUFjvdn8pNNI/2UtLGYxrWTF8i52KBptqMbB0990BsviwXRQ4NJCUZiCp3UqsU+dHf9nkSpWU5Ffhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iDLZrTbo; arc=fail smtp.client-ip=40.107.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgmeyfKQOkaV5v0JGBcWzsBXi/4Zu/xJYNvDu5euTlg37dpwKfCF5yq6aasLfUzmKyk37tKJ/7/mSvHZNf6RXcj3dsD6qfrmqRMDJwjufzOLYf7h7X/abebfIsnGsoTCQUZ6Sk8MUSfz8zxxBUlfINji0HDSrfHjj0dI2Y8KoX83zlVUcvCnAxmofk2q6eAdx3ucs9IvEyh75OAwWi4uom5xJWNV0U56QQAsBKNvIRlPCrciV/YYyNoNMLb5h3wZ1cgmRHThbpZQeaC9QvkscTVC1/K0QV8pXlLyrbwHn7eSPbXNFgDbVhBHgqbsBsxRQq/+v/PgHK4iIqzXJri11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSlhLIJNWCPrvXAQzL2o8wT7Tqiy2uMdyVLTS3B28kw=;
 b=j07G0Fc+RtdPpj+7srgOhivem0umwHdfm+RrreO3QBsxPGcYV1yP1zXx+fnZmhVJ4lhi3Fj+scB0VVW75cExMS4Miv/JysfURIg+kJOtCZeXHv/YSMtNUtXuyQb+dRvTisAb1BCV7U0pVlE9R9FYpR3oHii+vYBgplG1mAzqnDcKiuDp7CkRrf8J+aowma/RYomfUFp+GLUr70fgpeyZrTfc9JFo0vFxg/OaR6u6B3iRXfpFlPMLcQPcO8lCarl71Dl6ODy/4bTGTEZY+opuGx6Z+TLujszwTuZWo4HFuvQ/7YzCqt3V2CbPvZrQlD+Ar+QsB1OPwqh8Fk5WHhEXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSlhLIJNWCPrvXAQzL2o8wT7Tqiy2uMdyVLTS3B28kw=;
 b=iDLZrTbodrV1qppJt+ZaAXN4g84DC2ODQWaOtPFYhHLiFSYbef2siJrfYUVKxujTOuP4usGmElzGZ/Malzu61hd08XBzUaMb5jQR4kMXjz/ztaOpAYsNmuHc+xj32JQoYlS2bc2JeCiOMFXxIXF8ozfQI7WK+jKhbwTK9IWk5VI/I5UTEgNK8Nt2doGC6o+NaL8i2rLYhkvgMbsScQ4XpJmX7Cm2rna3AeJ0ejXUxqZnG3zOCXarOKuzkMJEYPJFEPeqshRoI5zbL3yPh0K+FDrmj3FHPdaCa6325ewN16qfXLhZYYnpqY5c/LhCD6uHcDKT2Rz3AEq+PfvFRyPL6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB9675.eurprd04.prod.outlook.com (2603:10a6:10:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 10:46:43 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 10:46:43 +0000
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
Subject: [PATCH v2 net-next 2/4] net: dsa: implement get_ts_stats ethtool operation for user ports
Date: Thu, 16 Jan 2025 12:46:26 +0200
Message-ID: <20250116104628.123555-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116104628.123555-1-vladimir.oltean@nxp.com>
References: <20250116104628.123555-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: 782a339e-a6bf-4765-fcf1-08dd361b10ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ivxzciYcRLMQ3fWcHgYYoWK6dmRbNpInVXD4ssB1Ga8u0yI4z7sc89g7lV99?=
 =?us-ascii?Q?SC161WWBQGCQ8+nwAuWf4JGGb/i/O7cqZH66nqUB6YHsY1hTk2/ieaS4lcR5?=
 =?us-ascii?Q?i6YRlAPdQFZQPEbMdOz2S0vuIyJRJ3vD8v9sW0q6UZbJSSTVIVDHFcWcigpE?=
 =?us-ascii?Q?MPY7eGw5roHlZT/zpiyasQUFKHM0a+G5mN37H3K4CRY636v/LR8YJaCG7yBt?=
 =?us-ascii?Q?TaTXvtkFoDDgMtiC9tLu2OI7UjVZmHtNrySxbXL1GZbCP7Zi+lg1rXoUQZGH?=
 =?us-ascii?Q?onv06gITJO/CsOwMdXlWx+eIkKLYgPJz2R8rl9WYbTp4tlxZGqCGMoVfrrTO?=
 =?us-ascii?Q?ILvQTwxRX06p6tcl5ZZyHxHvB678VMmMPpClIZ5EMooxfFSX85QV1BQulhzW?=
 =?us-ascii?Q?kxeIDRSe0od+k2CwUtKUvE/Z6T4VC81j+khweUA5UYBSla6QVmNIl62EDpkJ?=
 =?us-ascii?Q?Xb6GdXk8dlixqOtVYBJkXSaMhUXVJQhBBfu6UM+jlenHGzidUNvmz0HaeTMT?=
 =?us-ascii?Q?DU/RHqUcDTIQHfTP73mXgWbxif1QV9q7J3J1UOUUZbeEHiHAB5KV+Elb0rON?=
 =?us-ascii?Q?fpYmby3kGVSGtCaTo0Ovp8IIHRDLzl6NxGuJEiSVXEXqn1zTgkwe69MVFUk6?=
 =?us-ascii?Q?Do7ZboGnh1OxHnifF5/cOvMOLA69AX0kAgumBZvM+vCzB58RrLZf47UPDhHP?=
 =?us-ascii?Q?JeebDE9UyvRd2t/GJgNuXxu5rjkRYIm1Yx5Z7gcQt+JQhTC4TCKzuG48H1q6?=
 =?us-ascii?Q?uK4qwfmobYIq2MAyY91th3VdvUHIYSSQUI56FnuE/eX2jTBSMZzKIcKk7uze?=
 =?us-ascii?Q?HDsoIcGFIUiskx56t80B5SflNUOdcKPRj6atFrezQ43ze5CB7j0crFUwBTSO?=
 =?us-ascii?Q?gEXNQmMOQK9coZ6pFyZTonOkRDQKiomq5+iBo38QTx3rvKZDAOonxdF1VmVV?=
 =?us-ascii?Q?+38iQ4y8OgKnWxGu/bXAq0QxaaDfg8uJsuz4JxNVgnzu5JPhLQyB0EyfMfho?=
 =?us-ascii?Q?uYnK6E6gquAgjgCKlDC3TVyQVUx7rh9ghUQvuagJA+X3MzriwBF05NO3X5no?=
 =?us-ascii?Q?6pM5GZrdUTiQLGdXeF6wDTO4pKx2mQOf67TE1tSEI15M+2M9drh4yEe/I96C?=
 =?us-ascii?Q?MtA6idHtXftWjUuWp8jaeFddkKDh9lHKvKXP+qEETd7nPeQDvRru32KOf2F1?=
 =?us-ascii?Q?TNXeyfyC2pcW7Qdnl2zUp0z9I8rRTE1lBq159pLpA78qilYuBESQbWeFNqUa?=
 =?us-ascii?Q?GK/SzfUXAW6nyexgci7DnntS5+lsgCFwNtbw8wVY2YKOOAwzrkL/WWQmq1sV?=
 =?us-ascii?Q?ZHjCewq9ioXSfKsVMz87nZDRc136QY8MCvidMyPBbcBYTZWKDyoh5PRSf1y6?=
 =?us-ascii?Q?NuoXo3z9usXiqinss9iqjX+7rNGG0FME2gV9Lz34oO0AbGILPl/rZxEG9mgz?=
 =?us-ascii?Q?LH0pEcNW1hh8JL8g0G81vwRJG0tFIBQ2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r8nXtGfsEneM/xG7c6gUWm8TVEREWGStluq4J0EGiIjUCnpOLU973QiEmnTq?=
 =?us-ascii?Q?BVpcxwRi6fcTmbUyz5Ves8GCvjlO3KfIb7HV4oUoNpGjf8aw+9HCeWXo6XBh?=
 =?us-ascii?Q?F0EymTzTI9xPwxd2eJKyMw87vpUE8FV8IrfR/XhDHxzFk8KIH18MCTS8BfmY?=
 =?us-ascii?Q?SgM9JZcNWmnCLFQjOmk5Dw+dI8oqBB+iInofeNNcqpQS6k8BP8ITQGsoHoDN?=
 =?us-ascii?Q?JWckvxwVFPHw1GL/yWTzXUXTqMdxl7rNcQAr595rCrnciaMmAgMAntKfgIev?=
 =?us-ascii?Q?GCfsx9XJNhAHzJmtUkK3iPd72jjGhLyKixFCz35hRVLKxZR7qyx+r+JWc2BF?=
 =?us-ascii?Q?wT2u7Xc9eKQR7GfueSm3RIc9vgMOntT3ahgw71dnw1VdC1Ov8NUYyJNupbZR?=
 =?us-ascii?Q?7GUOAPpDcZp3M11Q5XVYverVkgxdUbJaLVM7jgU00+0hcn2Zy78MEwV6kqTh?=
 =?us-ascii?Q?rHdeay9iJ91XCW7YAFC9qa/GjUceHqEHWW2hQCEtDOPcc4NqlDfLLVotdgFu?=
 =?us-ascii?Q?SdxFnRke2Br2jVAaLY0c2kZK+EnwCrl4+x7uUy6tERzklFRHcDzG1DnetU9f?=
 =?us-ascii?Q?LHXy3004rCE2L/yu+3kB3gHSgnnK7WbPfaoZhlJLuCf6muxNDisWkZLVQ5Hu?=
 =?us-ascii?Q?h8ZhYNt5FjjY5AbTtkbohcDMZWHJ29XLBmuMoIeBEBLlwHI2oXC/qp4N7+pK?=
 =?us-ascii?Q?+Mina1G18wsPNoYwEOIkHEfbbzQ7uqo2mrwmFtJWPllL8zHTN81ef5gEUG89?=
 =?us-ascii?Q?sQjTNDt+M0EDc2kr+iuPKK1M9+9k8lm+p/nHqwSXkBhMw2q+YmEUomN7ymZd?=
 =?us-ascii?Q?Q9oibX05scNxOdeRhEyKLOvNtfSbiYWEKjwPdU6PJlTXqqeyeNm0w0qorwYN?=
 =?us-ascii?Q?bATG7c2Hu8tiMDxcWCXvgTmsWBKpcP4AW73SEJYAUNnT2/svaWau2COfbzpA?=
 =?us-ascii?Q?MQcI2kGBqOy0h+9kfda5qL/Lsgp+1tFKuY4O76aBuG4dLz3KBw0qS+xE+lX7?=
 =?us-ascii?Q?RVyvBMDOWam3U+Dz1dcPGCzHr5WCqXr9QiJVZJLtunxkkly27wYDqY2h6j/W?=
 =?us-ascii?Q?XLrf6RiTKtxKK+wscZ0Za3xsg01unyYKKCTnAhk0Bb5Ig81zHH7AthmSAFmL?=
 =?us-ascii?Q?wUwUrcQUP4TOycUGgX1hmpD4D1e090fYzqJogDsfUlZ4t8kqTCUXmSYuHOC5?=
 =?us-ascii?Q?/5RarI5PQgttSWYtdM6GEKlZGEItmfCBLILUqO+x6ER2Np21FjiDdfRSCuei?=
 =?us-ascii?Q?YMFb6RI+F1i2eT7m1bbjG2suPmlyZ1qHjznGjObqf5RTdHC9I14CKOrZHaBm?=
 =?us-ascii?Q?/mi6Sl9PST1vgPVW5A1ovlbKHlQf8//8jISz6z+btciXS8rL7tdG2s26pxfN?=
 =?us-ascii?Q?ZT7WK1QyEjT1pKn0p16M2b9HgXF6N013UmA/2vVtqCvtSRCyDL3JhhWt/v7i?=
 =?us-ascii?Q?3K7ybLsQjyswvrySFK0MCgOP+hB+NwmV7ur8Y8P4VqA7zDjWVwzjbViFnKye?=
 =?us-ascii?Q?H//QBsnqrlpF0CAjymObVbeP6WPdPLbPpVu406lPa+7TjsNRpFNQHcBlkDUN?=
 =?us-ascii?Q?ocYQjXkc6CiLYQWUj1HmM70b1afhnTjbQB/ln/Ezm6kWzKNJmdY3AhiuvAIY?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782a339e-a6bf-4765-fcf1-08dd361b10ed
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 10:46:43.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yS29T+hBdEyzLS2P19LuUeppl9NMacxHbFWLJRZ/QZZWHDXgig6ZozxEO+atKUH99Bdop0b4LEaiPaQL5NE+ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9675

Integrate with the standard infrastructure for reporting hardware packet
timestamping statistics.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
v1->v2: none

 include/net/dsa.h |  2 ++
 net/dsa/user.c    | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 9640d5c67f56..a0a9481c52c2 100644
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
index c74f2b2b92de..291ab1b4acc4 100644
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
@@ -2501,6 +2511,7 @@ static const struct ethtool_ops dsa_user_ethtool_ops = {
 	.get_eth_mac_stats	= dsa_user_get_eth_mac_stats,
 	.get_eth_ctrl_stats	= dsa_user_get_eth_ctrl_stats,
 	.get_rmon_stats		= dsa_user_get_rmon_stats,
+	.get_ts_stats		= dsa_user_get_ts_stats,
 	.set_wol		= dsa_user_set_wol,
 	.get_wol		= dsa_user_get_wol,
 	.set_eee		= dsa_user_set_eee,
-- 
2.43.0


