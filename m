Return-Path: <netdev+bounces-128155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 919EA9784E6
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DA31F28E28
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188FE83CD6;
	Fri, 13 Sep 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I53Qhe10"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013057.outbound.protection.outlook.com [52.101.67.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260FA58ABC;
	Fri, 13 Sep 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241405; cv=fail; b=ZqmJuh6wA8WjP+MR3SafzfT51ofzww3f88vrTkZh+tV5Na1+mTOUY6lvJ2ShEbnJIzQnAFOvqnA7pnSi/xHhIws8O4beOAKEUVprah74eWRtJ2Zwwgr6ncOn+OmhajVI+JLsSTIolNNtBn3QBu4TJT1TZzX7PQ0YSFGYzsC6m3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241405; c=relaxed/simple;
	bh=CFTQkXARLrbiWK5Fjt+9IWoCYC7i0aLvyV97d58THWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=leBg/SuEuqdXPj/Zfl2sRpgVu2LvS5XpjcoG3M4hJg2yu4nxtayGZ0ZgGVKFMd55OF8ETHfNkxrOgpW+Syk0COu0ix/1pDe1bodowpf8nOtmk5boR3JVIjl+ijgPYuY7ieCaIv+8rTGBawXhuAFneka2hSKB1h9eGg1b+2SRjeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I53Qhe10; arc=fail smtp.client-ip=52.101.67.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvS3f+pSXVYMy3nIyOlTAtjnf7HB7WjAq4Y+DzK03lrJUNPD423/iW4cCNTD3S64fLL9khyhygsEIagpck4DEhV+RHGH9BXMgeCHmx9F8/y2wU9WzIB5BiWafYggoFKNR1EqelABsU326M0//PeVz5G5hCSPMDd4NjS2f4isjQ/EZDhz7RhIYnqTrmaZa4bR0wExCa3vGQq2OfQc3/ji5a9H/DcePqKLBDNq+mdttSOr92Dg1W6LzMtlNhtAzqO0SBsXa7oNCtHAbLQI3F+gLxngAer0n1PzomtrxiNb8AiCm2jILHNllc6Hh7yrjOK5j2KUOHXBQ6QnkzSD+Ds0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vp3n0w8kiu08ys3ePnJtcAdFwmPlCL8Ag7hSZf169v0=;
 b=QL3NSWS+qwETmCy9pDG3oSstzElPKkihaqvQSXl68PsVxfw9o10rG8lmHfnPSRU8aYawOp1nM5nrkzjg1B0s0XpNnXgdNcl619CvrmLeY8PM8Bv76LlkzvP7dHi3gUyOQBK6h4jn6vx5WbC8XsqIWH7aqRIjJaafPmYJVfwHFkBgcSEv3CrZ2jk/rMlrKjpES4kwYS2e765xhUO0fE8DHOynl2BhwCUsaduqYp/XSovPhzKpnGX0HIGNurNxpx4V224cGXQEYUkstdxKwxf2R9U09QVfm5lfvoJgedjGbacvHzTqFMGeqOmvUzHJ0+DXSx3GqKshDhT88urSvwepLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vp3n0w8kiu08ys3ePnJtcAdFwmPlCL8Ag7hSZf169v0=;
 b=I53Qhe10swltE+KtkPW0aZ02H9z4SHm4xuCAePALm+KDkJWABjVQy7Zyu9Phzw1KlrWsYgQcgPSgME+g18TrGKsoukHXKuSqV0wJdN4pkIFw4QqRkCtmj0pG9tdQzGk5HUkkwxt/R9CXQ79cDDbX6eaIlkOMZZQqk8XbTbuJMrrHEF4+zLhbpFqRAiZveMuJVdgnjNJZrxHAHFHM1IICQfIIa0T874qnIQhlTfwZrXc4BmOHAcHSETkKeQb57JQoAlOWvO2XKnl8IUZTOuUE/zdvwlTZC8OmugwxIdJX/R0cL2oeS7SErMQ+5nTlYkzIeRPn4c2rtIhdWhkCKltZDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10859.eurprd04.prod.outlook.com (2603:10a6:800:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 15:29:54 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 15:29:54 +0000
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
Subject: [RFC PATCH net-next 6/6] net: mscc: ocelot: allow tc-flower mirred action towards foreign interfaces
Date: Fri, 13 Sep 2024 18:29:15 +0300
Message-Id: <20240913152915.2981126-7-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1deb5022-b4e8-4512-bf17-08dcd408eaf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WSW9zz8Mq6YRv8MJe6qC7IYzY4BDm1eFy/9PQbLaIlxy5GLnJiUno9RRbhXe?=
 =?us-ascii?Q?dAQQ7vBBzTWKNdA72j9rrAh3VIO5UMw/EtOtOXkBSWlpNjahQ6+77b9TH4za?=
 =?us-ascii?Q?plDe+y1eK2Z99yLPY1vBAg+Hge7UC5cDUR6Er9U7RlKCSOl1RVXoQ760XJQ/?=
 =?us-ascii?Q?HDSE61mla/Ce5m7k5lym3dtW7IN4K3SGKa+8Mwl1wqEidHWlFcQchNvIDUAo?=
 =?us-ascii?Q?JbnS9XwIjrecX1YX3/vtLwGrFNcJINrLxGRqN920aXEzY3DgeS4roS9CPvb5?=
 =?us-ascii?Q?TP6qogik2wJyDOhlm76B1++0UuSMA4p2Ra8cyeYs3dpMZtW39i9CvmkDV5dc?=
 =?us-ascii?Q?u68Q17Xg28H7ZbwQzhVzkvbX6ijI/i7/SFu8uUmpOx/RnopoUKbPIKvmrzLd?=
 =?us-ascii?Q?QnmKeSbzn4uLzOrLDr0sVtjZJt/UybZE8JSHzQ6Jx1efjYo51BKzX+UM2QAO?=
 =?us-ascii?Q?KkiAzkUIVHT/S82qE4CAODDOk0CbhVunQsqTMtieYM66g21H0vw7c7h8md5E?=
 =?us-ascii?Q?T9Lgf+7AhxFrVoHpNNzNSF625gdTd1vEuBVequ/DU+t4cMMZKRP5uGJAys/o?=
 =?us-ascii?Q?xR9gFPnotBrCn/nFxv+qGyBh6qPM/4lCDfL0DkFBP/FV76firpjqwWSm4tmM?=
 =?us-ascii?Q?qRblg1XUNlbWqNGOmuWzi3wBBZ8NvhERtpHp/oqIguelZxYDPcLmqyzs9dQj?=
 =?us-ascii?Q?QGQ3fa3LoWF3pKsGe6To9yHqX2kqyjuQ6CDXig+nDDn8S099fAlPuDij9P4C?=
 =?us-ascii?Q?yFZ1X3QptwLT65GmJYE6T4lczr/RUVfgDzipTok9u41zlMcQi3NPzO0fvhT/?=
 =?us-ascii?Q?IwSFWLR3bRjaYWLr2EAda6WB8ap2aDhTJKYEGyk3q48ut1uocMNAwXLEXkTE?=
 =?us-ascii?Q?6H7C8fMF21EIfU5oKywlZxurYt1AEYEAP4HuXABkDzJ9DLySsonNLFtRwxXq?=
 =?us-ascii?Q?ra+r1Bt9ttlHjHme3nc5lm7Wwt6aGW1J/w/nWsXCuSu00iolWexbCdMQLtAc?=
 =?us-ascii?Q?FdWXIaHwMxEPM5fUrt1LGfmDDBnMA30NJ+i+OpBeoDaUamVyIos2CoO1i98r?=
 =?us-ascii?Q?AINqsJZoT3BtLbvnVZ7KG5PTbWlzqPgWDftdSHLombESDdncafU4Pg6aXFrk?=
 =?us-ascii?Q?BS3iB4nINI5RfJF08op8coWnmm0rVEeG04cZfRRBgm+PsmppLmbJkfJZYtzI?=
 =?us-ascii?Q?L0fhm+sRGcPWrjuDP3Q78ThwvveDNlr8dLdayeL8NdkwZSdYnyYVKJcg40iD?=
 =?us-ascii?Q?WRDzt9UtSMbrvslGPRpBVtdb4CeQ9Nntu8sktzqb2XcCfwEMHwgmvOzU8LYq?=
 =?us-ascii?Q?KRF2RRvChUlBb8iiGGtiz5qe9oluh8cRG7Afge1tnQaVpZAnBuE0DYHLqf2Q?=
 =?us-ascii?Q?EFNCur3wINEVVMkPebnTklcVfqSoo2joSPXkuT9OQ6v0yEcTxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kKCbjCgtUp3/5wDdCGQEXeNywbG+uTf/tR72vUhl0v6e2v3eCL2GXChX3xni?=
 =?us-ascii?Q?O2YM/BmcfuQRvJxx77gVYSh36Zg7dgmO4l3MXegMW7F/SSGtZfW87cDel9lA?=
 =?us-ascii?Q?GUlfQA477emXgjZX/TfOvgkR0Z+uziIAIKXrTDvcmNj78Vyz2vTDVqW9pIpg?=
 =?us-ascii?Q?oxwXwrQPwqif/fFgckV8nIfdDl01iDkQoD4qRrcO8mpyjkrgd5qjKd84FasP?=
 =?us-ascii?Q?joNRcN5TLBR3rIyQaZLUL1CHeYu7yFff5PN6PvJN66fRbvEX0Ut9zHpdSyP6?=
 =?us-ascii?Q?+VEN12rjlhqHsAqGIF/yoViMxAy1/bcRiYpV9afQNNOirFgPFDgldAQtKoJS?=
 =?us-ascii?Q?vfhMK2yaEAtc6aUfZxUweNML4uk43bez4oggTpg0rm1KbUwKdCfLdoN/muqA?=
 =?us-ascii?Q?vRD2/q5wdidUsHzNB9r2hb0CQGPrG2jHAXJPdhp3SsaU25cqYLwfAOhCtwpl?=
 =?us-ascii?Q?FLaE+e/jGKW/GvKWh6Xgd4pgq+dGV4RqRAB00dpZBS3NtmjvQTgPV1luCY0O?=
 =?us-ascii?Q?t4EPLzvX+7A5rGfPyn2HUN7hTYrGZLAoRkVH1Macc5o0GyE6Nx33lEk/ZBGC?=
 =?us-ascii?Q?oX/1GDrAH5P8w5l6yYVfxkqEgIB/Rxi4jE0buWymjH+M6Bwqkx93WACjDrXw?=
 =?us-ascii?Q?sfv66wKsRiwtVdZgWqsljcatgBXk2VqL3YMBGDijZywVfSesCo9muvj9PVdM?=
 =?us-ascii?Q?720H8rSrLc/4BW4Wkdutk0P6iXUORHCVKO1nRs6+NK10VJWO6Vv/bd7mbMNJ?=
 =?us-ascii?Q?8k0Tr27VmPL3c+yBPbWP6kE5jBJ1U/6dGi7SxcrzE9JW6y8QWbHwVbVYxpox?=
 =?us-ascii?Q?FrwuOECQJxnhsh57n1pgh/D5gmLwmdg3Bz8g8RNJ+gWWWvWCDEfKwNTzXLox?=
 =?us-ascii?Q?ho2x/lAgBX05zDmZgCPEardD87R0XaD5LyBrjq0eh+1l4lIr3MPbWz5ocXxV?=
 =?us-ascii?Q?TxmLTMuC8XGnY+ZBmHI9HgicK5nxaCW1l3nNzG/DLb0RKo9VrRf16r6Y5Llj?=
 =?us-ascii?Q?hzSAaTeSJQ0/p/1aTA3vwoZ1s2+7Wq1omR2/g7/yM/0XLNQJeOZEFkK8w2Ol?=
 =?us-ascii?Q?wkR0pVJeV7b6xy4TyBBnemcx5HAXGcKz/YYC1ub8vMDWvcdpG2+QacJXssnW?=
 =?us-ascii?Q?C4DUCNu7ZVEHtSxsJ/j4ZhmO1z5USkbKZMgaQkJFS3HLwrbHBRFHFP/VeivV?=
 =?us-ascii?Q?mIuKgerIjrqASP+kQ9FfG+H9+ncumwypZvqeERSk5LuMpp9Af++2TqzLIoH9?=
 =?us-ascii?Q?awru5XbuDG5SuLCZg1pTTJGufY7hkYiUGQiiBy4aqOYAkEehb44pbYMRdwLC?=
 =?us-ascii?Q?F8Cm+hAUtL7YmG9SuTVUFAir4zr/FFVpgVKNVTXqVjew+88N65/+JmBBfnmC?=
 =?us-ascii?Q?VN4vpujdU9jWTeVmInx3ROOzqPiapSAoBV/+0+5GeLJ9qKKZaSVEjCKumrlM?=
 =?us-ascii?Q?Hy4QMbbFCtQB9YA0/A8d73NBUt3R0XACAJ5zqO1FoVVJWIbT6Q26ymvF0q0i?=
 =?us-ascii?Q?5FUB1eDyhWBc+emxDEubU8OX/NZgnTISUxYo+DwFdQenCZfXo1Ti6JbhG/3X?=
 =?us-ascii?Q?0iiGcETmF6inmLn0ExvGoZtizNJJDsu3AGcnFHUN33ufBseHJzxZQE2hJL6j?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1deb5022-b4e8-4512-bf17-08dcd408eaf2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:29:54.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M29167tPjEEa2YeE0tuUnYotwCTJSEAQ9PHAhPm07NqhaqE4+oRaltQhIvUzUE2Kf/knN65ZYsLEF3+gWqZpVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10859

Debugging certain flows in the offloaded switch data path can be done by
installing two tc-mirred filters for mirroring: one in the hardware data
path, which copies the frames to the CPU, and one which takes the frame
from there and mirrors it to a virtual interface like a dummy device,
where it can be seen with tcpdump.

The effect of having 2 filters run on the same packet can be obtained by
default using tc, by not specifying either the 'skip_sw' or 'skip_hw'
keywords.

Instead of refusing to offload mirroring/redirecting packets towards
interfaces that aren't switch ports, just treat every other destination
for what it is: something that is handled in software, behind the CPU
port.

Usage:

$ ip link add dummy0 type dummy; ip link set dummy0 up
$ tc qdisc add dev swp0 clsact
$ tc filter add dev swp0 ingress protocol ip flower action mirred ingress mirror dev dummy0

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_flower.c | 58 ++++++++++++++++++-----
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_flower.c b/drivers/net/ethernet/mscc/ocelot_flower.c
index a057ec3dab97..d03a7e636290 100644
--- a/drivers/net/ethernet/mscc/ocelot_flower.c
+++ b/drivers/net/ethernet/mscc/ocelot_flower.c
@@ -228,6 +228,36 @@ ocelot_flower_parse_egress_vlan_modify(struct ocelot_vcap_filter *filter,
 	return 0;
 }
 
+static int
+ocelot_flower_parse_egress_port(struct ocelot *ocelot, struct flow_cls_offload *f,
+				const struct flow_action_entry *a, bool mirror,
+				struct netlink_ext_ack *extack)
+{
+	const char *act_string = mirror ? "mirror" : "redirect";
+	int egress_port = ocelot->ops->netdev_to_port(a->dev);
+	enum flow_action_id offloadable_act_id;
+
+	offloadable_act_id = mirror ? FLOW_ACTION_MIRRED : FLOW_ACTION_REDIRECT;
+
+	/* Mirroring towards foreign interfaces is handled in software */
+	if (egress_port < 0) {
+		if (f->skip_sw) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Can only %s to CPU if filter also runs in software",
+					       act_string);
+			return -EOPNOTSUPP;
+		}
+		egress_port = ocelot->num_phys_ports;
+	} else if (a->id != offloadable_act_id) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Can %s only to egress of ocelot port",
+				       act_string);
+		return -EOPNOTSUPP;
+	}
+
+	return egress_port;
+}
+
 static int ocelot_flower_parse_action(struct ocelot *ocelot, int port,
 				      bool ingress, struct flow_cls_offload *f,
 				      struct ocelot_vcap_filter *filter)
@@ -356,6 +386,7 @@ static int ocelot_flower_parse_action(struct ocelot *ocelot, int port,
 			filter->type = OCELOT_VCAP_FILTER_OFFLOAD;
 			break;
 		case FLOW_ACTION_REDIRECT:
+		case FLOW_ACTION_REDIRECT_INGRESS:
 			if (filter->block_id != VCAP_IS2) {
 				NL_SET_ERR_MSG_MOD(extack,
 						   "Redirect action can only be offloaded to VCAP IS2");
@@ -366,17 +397,19 @@ static int ocelot_flower_parse_action(struct ocelot *ocelot, int port,
 						   "Last action must be GOTO");
 				return -EOPNOTSUPP;
 			}
-			egress_port = ocelot->ops->netdev_to_port(a->dev);
-			if (egress_port < 0) {
-				NL_SET_ERR_MSG_MOD(extack,
-						   "Destination not an ocelot port");
-				return -EOPNOTSUPP;
-			}
+
+			egress_port = ocelot_flower_parse_egress_port(ocelot, f,
+								      a, false,
+								      extack);
+			if (egress_port < 0)
+				return egress_port;
+
 			filter->action.mask_mode = OCELOT_MASK_MODE_REDIRECT;
 			filter->action.port_mask = BIT(egress_port);
 			filter->type = OCELOT_VCAP_FILTER_OFFLOAD;
 			break;
 		case FLOW_ACTION_MIRRED:
+		case FLOW_ACTION_MIRRED_INGRESS:
 			if (filter->block_id != VCAP_IS2) {
 				NL_SET_ERR_MSG_MOD(extack,
 						   "Mirror action can only be offloaded to VCAP IS2");
@@ -387,12 +420,13 @@ static int ocelot_flower_parse_action(struct ocelot *ocelot, int port,
 						   "Last action must be GOTO");
 				return -EOPNOTSUPP;
 			}
-			egress_port = ocelot->ops->netdev_to_port(a->dev);
-			if (egress_port < 0) {
-				NL_SET_ERR_MSG_MOD(extack,
-						   "Destination not an ocelot port");
-				return -EOPNOTSUPP;
-			}
+
+			egress_port = ocelot_flower_parse_egress_port(ocelot, f,
+								      a, true,
+								      extack);
+			if (egress_port < 0)
+				return egress_port;
+
 			filter->egress_port.value = egress_port;
 			filter->action.mirror_ena = true;
 			filter->type = OCELOT_VCAP_FILTER_OFFLOAD;
-- 
2.34.1


