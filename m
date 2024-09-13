Return-Path: <netdev+bounces-128152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FAD9784E0
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB771F28ED4
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCF57406F;
	Fri, 13 Sep 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cG4HtMqt"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013057.outbound.protection.outlook.com [52.101.67.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10769D31;
	Fri, 13 Sep 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241398; cv=fail; b=gO81eAAeQ93x5rOz5OIywvvepzrFxrf3wOb8DGFTxAenDkWuLyFKhOi7q43ZkA8U+UdixU9OQhSgxDm8ukzpOSH4FWXqrOosSIHnOaryxcS0x5BCHPfbJyNps7oo5RWOZ1o6QeBPVXUmtJ1FgjTlAqm071Ret1BuyGPHRgsI9DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241398; c=relaxed/simple;
	bh=w1jiKdaGVmJE1Xb7wA2kzHyilovYOsj6MrM2YXWpWbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qKIuH9gI/ZfKiZis4riaRSUglE5xZScW9I2iJDzakqvnwPeFIJbjwPTcBhbhgxcuV8uJCaQGtM9g/MigoaWLyVft8EXevO3T601FEkBESeE6up6QT761pPjiqvBLXhc94xzbBBUO4VoFTkz1yY9o4zS3Pvx8twbSJYaDraaXIXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cG4HtMqt; arc=fail smtp.client-ip=52.101.67.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0fs6BTtfwI3sO2iC3xMNl7Nw0AhaI5DIw1kaecNPqIZ8lLlvQiz2PYRCwAsAS/bb9VcCagkIh/FaTCJZKRD+czpPt/y8CJhgUHc2j17icKZCncJfA6ibGHYHWRZjDIbc9jnIxHgsGQP/ArqlrNooQLLeQ4eXQbz+26efobsViJ8h5xjWaKp+AROQ3Uk5LHOqOQNchLkUsBtOUtcPYJd8HT6Qaj4aIWSF359yhrFFAc0s1X5npvWAqdoInFpnad+5vAaXQUuegcG3ujz8vEwwmjcGjPJd7YSG69lN6vEBAd2Ebm7p1thRHj2fZZ40wY6D2t+cY0ZswENkuVL6LPmiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9CRiIOz405LWDfk/Rz64e69EatwwzxzYaab30d4K5Y=;
 b=VyLFTFxCXCL0mMYPmdbXA6gGI/7nES8mGmyuXMDcQlp6nUbFSca/JsewHMUFnLyZzSCEqxEUYqyi2mSIWKaDyyhQavMtLzQ4BtK433PtVy2nxYuNjGKjrXRAJzNL5vdKWCuZpHgCxFa1V0YD/CPzV78884w2vEwXiwl87e3V4CrepqxOpogP/VuazEnwFWMf6W9B2lEmJljJFibY/qQgn/mGAGluzNDn2Fz25AmtRZRtU4wUl9UGtWE58r5l+DKv/Frj9S4nIbfkrUd7R0fu4QoWaD1VgFZL75wWPp3NX2DvKGCYp/A+MNv+1C+wW2Fvjg9dAa5xKy17mNN/pbii3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9CRiIOz405LWDfk/Rz64e69EatwwzxzYaab30d4K5Y=;
 b=cG4HtMqtBYnPS6RuIaLc5seqWSXLaEV0s/BYYMJYGpsz/n3mUSjbwQ/uID61aAHiHd+bVY99mPFppAASuy+wbio7V3AqLE269SCJ9YJdFZHv2g95iHCdLRj7/9a8U4Jdy84jBV/yYXmXpXmWhOvzCYgiGpxznWX4JnO2IuXGkz0BdoocZ5d407uQyJwd3b6kvVva77tyeOwbL6AzB4Yf4/ZQGO07fCEUZnqS1pMG0x3w8HpFaMNztOtt3DSbHuKwItczdooUvfpW7+cbzlaZpTP4uunaVptLPq2A8DusNsheCfMePVlItVTzc8B6J4f3Ng5uQiJ/QqhOrxKvkT43CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10859.eurprd04.prod.outlook.com (2603:10a6:800:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 15:29:50 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 15:29:50 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 3/6] net: dsa: add more extack messages in dsa_user_add_cls_matchall_mirred()
Date: Fri, 13 Sep 2024 18:29:12 +0300
Message-Id: <20240913152915.2981126-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913152915.2981126-1-vladimir.oltean@nxp.com>
References: <20240913152915.2981126-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::18) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10859:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7c9bb8-4923-4f84-7fe2-08dcd408e814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uj8yEzgW52k4NDe0OfDJhUiDMaNyKLtwaH7yo3ecYTgpSwEXHg+/NtbHD0Ll?=
 =?us-ascii?Q?dwgODxXGT3DwSITltdBa2aeZfSt/r/rnVC5LiB0QP7CNfNq3AnDh7N8wtZOo?=
 =?us-ascii?Q?v4ji3vCKvjZ5BCmVUTcGAHZWRL3r9EOK6pS8qJqlwwJ9yuhayX7yvO4yZ0g6?=
 =?us-ascii?Q?+YmqPlKM3DMIB2x6GfyiLg4umokuwkmZMmbSe2jPIFak4z51PpmEhb7i14rN?=
 =?us-ascii?Q?Q2LK7oR59znVDmyNdDIJPOsr8mvchzqXfjNaBQMskfGYoRDLferzUJHKO9Hz?=
 =?us-ascii?Q?GTaokM/CRUw+Qhn6dt/IM+LuoXJwpBy77q5FUD8lK1LQdk5ICv9xWjBSOvkC?=
 =?us-ascii?Q?dRKA2cUykLKy8bY9aSdSF4SpHJoM9Pes9QFmzGrMBVGGkw3iML6D+sLBmZnu?=
 =?us-ascii?Q?F+YZhOQbko2kOAQcame+ce0SLEwL9FI/L2ktfTr1VqSxOIYO2/+HIe02Dref?=
 =?us-ascii?Q?qjsQmJoFJn90UF+t6SUywREL5MBZR7qzM5ny2l2TuTyzb28ap6agka4Zxp9Z?=
 =?us-ascii?Q?WaNCOr5yjugaSuKuH+lj9OE+UdmazcQzDLXwpTJQRmcT8lKlAZoJlp8wY4L0?=
 =?us-ascii?Q?qabJS3+97y0CEQlZjr22s87aQqNcQ8ebKtQXzrft4QRAUL060gQYYnlzYNZa?=
 =?us-ascii?Q?IWBOw796pFSpT5Es0qg0VXsUDryFs5u5/vVlWbKSgvWViJ3h7snDbmhFmm0t?=
 =?us-ascii?Q?jZ7+jrr8YLY4lAFPKRZ5x9DVC0lptIziRRrPYS/G3SMD3EV54uOcRE7nUDjc?=
 =?us-ascii?Q?gXpBIQ4NGNIbD+y3Az/YbSS72Ohbtep5ryTKm9bJb0CAc+CFGX0go9SRqpmz?=
 =?us-ascii?Q?L83lIrUqKRf55XlKXO20AlVufo+BWlYsgqM47jUs37o+/Bb5gu/y3CKpyaTE?=
 =?us-ascii?Q?CzVvRVAihX7oTkVPaigJhOfXp7Ca2uoQrxNV80bFipuhU+FsuWXyGW9Wbj6q?=
 =?us-ascii?Q?XlP7hA175LIs+/RmchNzBDFJSKn4TgKczSf6OfYbAaHA5simKHULeYaQDcTQ?=
 =?us-ascii?Q?UlwFhKC0RyLsERnySfld7AFZgocnF5b+zjHP6IsdswMyqqVOtma2SPRvgECf?=
 =?us-ascii?Q?3oYhYCFKEoKhYG2kndKk4uWuRjVCxLErN3GNlW8RwjZu2QR7W18FgIjFchq9?=
 =?us-ascii?Q?eic/asHauhfUYOVfcAnLWZvs1xAZZoqJ421w+VMVlz6ecR/G8EXYaUCsFQMs?=
 =?us-ascii?Q?u/JK0vTewT2+ywBBXQ+kqtlWBDyezqMjun+tEAX2TBfNW4wwgUhIWeAvXXQt?=
 =?us-ascii?Q?kGK9ihbHE33NgvmWsOnnbmloXh8JYSjH5WiCypZKySvKgaGQuUu2zDmMQMua?=
 =?us-ascii?Q?euphZq+ucZdSg+eCF791CLEJLqenfs0nXD8EW/tuk8Lo/Ry1jOGAvdwo7b30?=
 =?us-ascii?Q?gB/F84tDWBNvnsrMzmCOPLVXtYq0/bWYma+eOMPBB+VmGYJmPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4XE2l3CwBTN2nG3X6k0wjKqwqbEpeRY5G+4F2i/R+muKBgLvyleKrb0i5Vf+?=
 =?us-ascii?Q?SZi5wAEL6VhFFhrkOa2zQEAUKvPTd/ZFZBxeNjuR0piHIFaUeQuuG8RQbU3s?=
 =?us-ascii?Q?5s9gUFZ4OK934To24uznK5l1ap/2kDltui/er5ir2EqZSKu9Fxh99J15l3iJ?=
 =?us-ascii?Q?PA2lDsbr4EzcsnKUuGFw5JNo8rgmyPX5kUPUr/YyCq2rhcX7ZuIoYNsWVpRB?=
 =?us-ascii?Q?9gBJlx3YL/CKUqqDy6IafjcXf7S8ji7MOcNiiQnJ6Rw4H/qhMBn11pG0bjXE?=
 =?us-ascii?Q?d19mg7ib02ukRBAShVaICUty9Rv/JnIn4UJ2bpmNEDYBxNUVVj1/uHSTMidO?=
 =?us-ascii?Q?yrTXh6qctrtZzLgDdbt+ML15ZjdVgZ811tzLI4SYy0JifHgvZniRFIkxI53O?=
 =?us-ascii?Q?UWKvDnVdOMpNez2cuO7GPR6w7smE89HnQx0NVvBaPC+/MOxCfO+erDcs5HFn?=
 =?us-ascii?Q?UrgpxIbUENlkFDz2P7QrqC7zncr65cxQV7Cz4/wo4CTJe2LsTeX2++05n2FY?=
 =?us-ascii?Q?Iuy4j9XpdfWPDcA3A9aC4kQ08u9AUYIIpFXjIHATd2iggOn3OMIzZ43zI9jW?=
 =?us-ascii?Q?5vZRMgQ41qjyQeRKD0vE5b6c6zKX38BZaD/uDRmRMqZyBjQCeN7zHzHqX0bU?=
 =?us-ascii?Q?eli7IRulz+AcVzzVvrVrmCqHnhX3R2v9vjCrWAVrZazN1rS0Y+0t4oCTgqsL?=
 =?us-ascii?Q?VUi2NR4tg/CszsC+WcXrD7hU3gk0uQ5xS/tYAUr+I3IUtAK1WYe5clITJShe?=
 =?us-ascii?Q?xLiijQpnN6aVROsl5ppIr6aKymK/94+d7b+gd3DzGjGf0oUYYq4xzylHPFdS?=
 =?us-ascii?Q?SWEvZNK33HpnI0Ghdn3xTP4sxxwUlXTI0I0KELsqJvA3DErWQoWGqWz5qYvC?=
 =?us-ascii?Q?YdnPgE/3lOjAaypW8MWvEMV66/gBDuP7J4gKXOuDjCewbKJXLihTUNY8zC8F?=
 =?us-ascii?Q?azCnkTH8j8UTFH6gIQmmNN+uhVt9p6l1/G7XjsXic/eSgLA2AHS/Ant4yw+N?=
 =?us-ascii?Q?rVEdQcTXX/jd44mmCpSYri6Oa1W6ml8qoE9IZmIujwEBubAn28PcO4p64NQ9?=
 =?us-ascii?Q?PUJVJVMh+SjwOC8aq7gFSeP3DB3cIjkUAHv7hE95hEIMf9l9JjvaW9NoM53R?=
 =?us-ascii?Q?BWNM45lVYSHdbenx0U9G3axbpadNOC0oeODC2MsjUSWdt1M2EVun4KAJpBn8?=
 =?us-ascii?Q?dg5qSNOzCQMJyLzlpu6/MUcmQ4/wmClC8D74++FSsyPJK5N40QpYIf+DdrPr?=
 =?us-ascii?Q?jklzPxgZRMhFQWNAEcmor/pnvYc48+/GvMDPEL6CErsLiiVVcNDBXwhNJiDS?=
 =?us-ascii?Q?L/UeanMIUngkDrodC+WFluBnRSWdKuKeH6TpwI4PCfD20hhnfSWWuaiCMGuA?=
 =?us-ascii?Q?frzceQgg1NlEqQnMlYVNjTGV8b5pzOqMs6XbHK+FxbcQmm3o5HKSYpccXpIP?=
 =?us-ascii?Q?mCLe1vMu4NHqbdkQWj44eHXrtqplqeSgp0pmN3EGkORsWDgplxw4e8ACoCmT?=
 =?us-ascii?Q?EPw9hEk5r8jjK83GSHAkta5Fp1ggvWbofbTfYfyBCmY5hUqZFl/8/67l0sW+?=
 =?us-ascii?Q?wsu2+PREgqKaZdp0P9P0pM/lsbLwhJPUV//SDhhmUuJBBM1ob16SY4kQo7Ek?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7c9bb8-4923-4f84-7fe2-08dcd408e814
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:29:50.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OI3MtosZivB20CNpSA1rjsQAzGMFrMvDemOX1FUc6rB3X3Jst4FkJ2ADoGvLJkMSq3GtnvtFD1E0DEXS3Ieqjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10859

Do not leave -EOPNOTSUPP errors without an explanation. It is confusing
for the user to figure out what is wrong otherwise.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/user.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 143e566e26b9..42ff3415c808 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1377,11 +1377,17 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	struct dsa_port *to_dp;
 	int err;
 
-	if (cls->common.protocol != htons(ETH_P_ALL))
+	if (cls->common.protocol != htons(ETH_P_ALL)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can only offload \"protocol all\" matchall filter");
 		return -EOPNOTSUPP;
+	}
 
-	if (!ds->ops->port_mirror_add)
+	if (!ds->ops->port_mirror_add) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Switch does not support mirroring operation");
 		return -EOPNOTSUPP;
+	}
 
 	if (!flow_action_basic_hw_stats_check(&cls->rule->action,
 					      cls->common.extack))
@@ -1485,9 +1491,13 @@ static int dsa_user_add_cls_matchall(struct net_device *dev,
 				     bool ingress)
 {
 	const struct flow_action *action = &cls->rule->action;
+	struct netlink_ext_ack *extack = cls->common.extack;
 
-	if (!flow_offload_has_one_action(action))
+	if (!flow_offload_has_one_action(action)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload matchall filter with more than one action");
 		return -EOPNOTSUPP;
+	}
 
 	switch (action->entries[0].id) {
 	case FLOW_ACTION_MIRRED:
@@ -1495,6 +1505,7 @@ static int dsa_user_add_cls_matchall(struct net_device *dev,
 	case FLOW_ACTION_POLICE:
 		return dsa_user_add_cls_matchall_police(dev, cls, ingress);
 	default:
+		NL_SET_ERR_MSG_MOD(extack, "Unknown action");
 		break;
 	}
 
-- 
2.34.1


