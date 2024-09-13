Return-Path: <netdev+bounces-128154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4F39784E4
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0272837D9
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACAF811F1;
	Fri, 13 Sep 2024 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kmls93rO"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013057.outbound.protection.outlook.com [52.101.67.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544678274;
	Fri, 13 Sep 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241402; cv=fail; b=VNoIAj+w6oO419wKZuld0MOGDppcYvZDKf9nWwrOtOtmmg9XGz+Js+62usHH8P5HSFtUeupeln6Vty90W4Q6G+mKsTwQkMajeuqP5NVvnINTi7/6WOHfEN1UFJGrT8QeaHZroQOiRpcT1ntTztK7IwWwsNydy443wnHzlLGG+cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241402; c=relaxed/simple;
	bh=2Se3rDJhvDhtVigxdSwLsLYyZRn52VwmRM21FMzMJOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mzkfkw2wtfvgF6D9T44O/rxTHD0x9ZE9YBOePNqthX8PmHWe1m89kt//MdDlCPw0q3jXZNyUU7cQ0NvUHgSuPV5ofhaO5TXyvUUb6+wsbF3JA1AbtAbTqPVMl/W3GJNr3Nc0dWqhffAwQJfAN9cbTtwM/rrfBjVVf9uVbF8CI7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kmls93rO; arc=fail smtp.client-ip=52.101.67.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0tuXL+Zb7huInzHxpzH27Ch521isbm630LD4DyMiWzkuFqTuTp4cKzMZ4kRlIiNkMixBOA1YdIQSg77Iq96lWvoQlk7X9vGX67jFsJUT58gJTY9bqPzOWPTPEzMP0QQzyQ0PLMZoeX/q+/PHjy2iY2ZR3ZC80F7zriuXleRntWJbr8nl6L19hQCWss5etxfStor4NDyARIW4bC7ZcrugNFjEEBAJus/MToFO0I3YIb7oZrfWLrFeAf+osKwN28ESODJWK9S7F/TdPv2O4h1EwDFC0KvLRgQj8SBIiZhjs+GyHz51oKjaSSFrr4EF0b2kiMdrdpzWhcbAeV8h/q8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DchtiU/jQuHINxUB9m8ahl7bth2S63ZrtTh0jYxO1D8=;
 b=RFz4PH+gh0jReZ5ZXzg6Y4HAIj8yIAoWh3VQs7wfnVM9tExFOlZfx2ivX2uyDq0wg8+fb/OyCtkcvgLU9/KR+A77GN9KuCBq60poc2+4s+oF5q3UcpUTNBz5FJ4sD/l2o56g+6PWbsm3ayJtuLJewtocvTCY+PWAA7zNCc7V3fmsD7TvFqhm+Kn7t5RmBm5thuonGJtnQqf7ELBlPoNR82kFAZH9wckXLaBb8/i1g3nq2vzqKgim0FOlUewAMaTK7TIls4bVxg0563+BNB24yR6YR3Ao0ETBjglTYQtbZxyE+0V36ivjR+XSsEPxTnaFMg7bFZTjI5ZRVXBBtdHM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DchtiU/jQuHINxUB9m8ahl7bth2S63ZrtTh0jYxO1D8=;
 b=Kmls93rO/V5rA6iwSASbXY8GMtEpg9VIAZGcjA0wNam5hbCvOmZCgDa6GzBF9S+er4iySAc7PClsQtgzYFReelTdt+DVPizFV1Ur2CrBtPAiQpZcOfJmUX2goXHFHPZY1KIKZzyMSuj4fnFprOl8Nk5ao1HU4JpJw3zEos9Nh1XEhdgg8w7YZeO6YEqfg3wm2sfKqrcaom+HJg2G2JtdmONXSDdIoe6RrAQk7X1NBOrkbr1ihkLzNz+IG3aDcYY0cZXHpAWVjN35cdiTf4lqP2VlxPLY9mWZnpkY6Pp7Gu1LvLgQRGt/5/DqGT27nF9Ruxha9Elx0gsFkUpu0AfygQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10859.eurprd04.prod.outlook.com (2603:10a6:800:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 15:29:53 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 15:29:53 +0000
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
Subject: [RFC PATCH net-next 5/6] net: dsa: allow matchall mirroring rules towards the CPU
Date: Fri, 13 Sep 2024 18:29:14 +0300
Message-Id: <20240913152915.2981126-6-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7deef44c-d956-46e5-deb0-08dcd408e9f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vs7lg7YsTeyUa8sO7owIQp10CloYJ4SaGukZkXtUCRyFcZiwaT+VW1B93IMK?=
 =?us-ascii?Q?KrhJ8ZZOTKXxvvqp0lxevv9QKHh9ug+GaHiBRE45t/x/JTSm+2HCKKeMhXsk?=
 =?us-ascii?Q?TpmmJuZ4ZPcFXpbnbTRigx6ovDs3SIHeqj4p1tYMYTUdWgDG13i0+wZuciWt?=
 =?us-ascii?Q?C2cfeVeLyGbGz+IHUKtAnm7PoF6KLRKYBkR0O7cDqwnrtuAtBd5GQDyDVT5B?=
 =?us-ascii?Q?jzksPtpTdrtn85M1eF/AC/drL9t3iswAOkElgLnPIw9YvhrTkBlEXDoR+bgp?=
 =?us-ascii?Q?AAisEB1KAsS7/23YMbgsWcEVTYdnf/nl2l5VOIcq8S6yieMal5d2P1zwKptu?=
 =?us-ascii?Q?teukmy8+ZJpYTPNX1YZGr7lGj9BoWLZ7YAR9xDZpOcA1P3tzZNwjbe5Cmo4N?=
 =?us-ascii?Q?3qF1ZLI6OFuWT+6KZan7FuW/Qt3YQxj5d6ZWCoMf2upGQ627ACqgMIm4Nyvt?=
 =?us-ascii?Q?ds+BtHkEugx37n9diGsAMOgdAT6UJqIkMqvc/nsWgZtxtpEf5pHurhJFtvK3?=
 =?us-ascii?Q?fEeubNzfEMEQine2Vc4Gj29KqCob+2XS4VZPaH39GLLj2BK0CqnuZYypQIzY?=
 =?us-ascii?Q?MmvrPJCU9tbq0nSzbQidPA/bydLCtu/sI8aEwgqdWmdWapYmOoXMNIGd2eii?=
 =?us-ascii?Q?HzBJps2G3PKRaQnv9b70WAs5ul38SU69Jns7mwgmFfp9jsg6QR6l/Umj8DXB?=
 =?us-ascii?Q?oDo4wJFUZ/zG7YxeYrxVFW2YHt4N5Keslo32o1Wwv5KieAxfQvs4jm75vwia?=
 =?us-ascii?Q?+FWQElknSrze1FpojBxl/IZ4TDCm7uUh9zeyX0J7Ctj9HCyMi5F+UbtCHUNM?=
 =?us-ascii?Q?9YKjYvNdOsQZsx8+1Mmasnw+bhElAuVjm8+vH5KsArzS7iJ72fE2u1qERs+y?=
 =?us-ascii?Q?Xf4wtzi7j/Aa7xTg+zMd6gLMHkleonWzdREM/CLKjzwkUf6oirltdyzR7thV?=
 =?us-ascii?Q?IMb2IQoEMBaf8MWrr9oNuvoJbFzMP5OlaZ1a9Zb1aVC4Aho7cRJDfi94FOum?=
 =?us-ascii?Q?CYZ2zjGfYXzZzIk64jvk6IKGVlIPbOoapWAvxWneNtOrhIuZxugm7I+eNd3u?=
 =?us-ascii?Q?Z1KCPRtQpvT5IU6qhRJbvc1yevdbrurLenR7Cn3PH168dnZjNbIzhY6R1POg?=
 =?us-ascii?Q?7Cg6dfuKXT0lWYZNSr0QPUAswqYEtaBXi+1m95Obgv1fCSs40iClRFwUAEeT?=
 =?us-ascii?Q?IpexG5NqSkyMpwCAchXvGLINYlMRTF6FSjWCnMGv69WlBwrzoSiDg5o7vFXv?=
 =?us-ascii?Q?sIOhKamVfOwlKYwV+UHnuYw32+27fasALolO6smFyE4bfSXiuu6BDq4fkRFw?=
 =?us-ascii?Q?HFkq27Dp+zlpFNBR+dPxrsRniaS2XG4LGfLuFfsXkhQgAbqTTvd80+nfPj4J?=
 =?us-ascii?Q?ordTc5z1GSm/IuEkyeMjPlP6He9IgAN0YARZ5YRbf0Z70f3yYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TgB1rIaTvbAg1KxdipKrkj6GiDpRs8C7nWAYes3qpQG43/SuEHCqfVHjroSo?=
 =?us-ascii?Q?UMObHNo6J+EY1G2JH1s3T8pyPHd2oZSn0FQLPR7jra7uDptEcne2kvh2w6hk?=
 =?us-ascii?Q?x9qmiFX4c4opJoiHnpct7Cc7J70JhrjauU0/plG1SsAgKAbXorY+OcqToVpt?=
 =?us-ascii?Q?YPgIoKuau+egxBV9mUPUwfKPOIEJZ5BmhWCtkt4BDotOHBCHoj2R9AUCVB8Q?=
 =?us-ascii?Q?SaCqg2QQyKyIt3zHwHdUBBjdvDN5hKmqmkQWXGV5VXOjzga/9u+uYgIdrqHH?=
 =?us-ascii?Q?Fhuy50rg+JDjeP1pkzeW4Vek41k9Jyo+foub3MbUqVKWanhgFj7fgMe/G7W6?=
 =?us-ascii?Q?X/8MaWDmPXzTF9lkscnPp8sczBB5vev4JZrFJUmg2LDwkp1S9rCbrxYw2KuN?=
 =?us-ascii?Q?TSho4sYskHh0xGVVhCljs926zvi9smRgzrhMFKXl5FWYV6RurbGrYpaDc6OY?=
 =?us-ascii?Q?0A/JIWMwZC5lEPXZpcDknG1C5tQOpSCCxKKwm2zpasAU0GjqJI5E7PuDvvJu?=
 =?us-ascii?Q?s3zKQbUdyedE2o0MN9ET6602epzBkEUeFM4PsMHZJdvfx1Ib/8oOfGSFi/2b?=
 =?us-ascii?Q?XAYYubQa5zOzmzwii21zVUiY6HqrthTgHCJXlwmbT3T7yHG7sf5eLoX4FW4/?=
 =?us-ascii?Q?+lrg7rdyy1jjux/1DQw2KGsvK7cfttdAee9G1bGvUYgEHLw59hFCuMcy2eUV?=
 =?us-ascii?Q?ow5MNWwKFgtzsZgTQjHZmTGoP1F8nhAnbd1AKeGfotphqWAkTZGnpf4lVY42?=
 =?us-ascii?Q?DfPltTYM8qUt1YVL4zWBzcgtkfk4jZh8Nk21R5ykXttlqq1IX0NkCrsNFrkX?=
 =?us-ascii?Q?coIwwYdqoP0PvZH3R+gkG/rcr+w8xs+Msp3Ak/4pf8XdH0DQ/yWLvz76Ol//?=
 =?us-ascii?Q?D5Qz4nBIn36AsKwiW+WO2sx2w2IT1XFd7am5q145I0arYZMQi8EMatAqLJzd?=
 =?us-ascii?Q?6XArzXyfclXfG6GGHFAUf5UuHuAwdWyKEDuTW/39150894vrLjKAKDVBj4rQ?=
 =?us-ascii?Q?ZHRChq7CzvO49kLw5lmKo5Ap4k3XZf3yKxS8I1X8K66NZB+0i/JcjttqxreW?=
 =?us-ascii?Q?DMMZUinDWQPO/LWSlVqxOLp35+cmnrzGZesxQzStp9YpHhQNVubQYfUKa2OZ?=
 =?us-ascii?Q?+JYMxCfBCPgYAuJ4SctgMD251M9UElInDjekQcOaBxqabPuQQn6jzVPiuIBZ?=
 =?us-ascii?Q?4Q8RNpjLFQcUnNcrKpzQnHKdhw+7biz1vGStqIG1rUQI5+5lWcyeEA7C4D84?=
 =?us-ascii?Q?3+IXm8jDxcKGAbWVnE+Fy27zAc20H1AP8OntgSxabwiJBxPlun/hpiqPZkws?=
 =?us-ascii?Q?LEa4UaBVnF0uWRdGW+Xm20PTL5hGXrOClz+qSdFE7aU8YwZWL0uBGr484egW?=
 =?us-ascii?Q?zGeNJmyD9t/u1vKIcvOD8w4qraXGZvRzsyI7QwsOY3+m+sTgeBTynel7+z6Q?=
 =?us-ascii?Q?FXLI0Aiko0lGB2MDOx2IUGhwVT85XwhrW7Spd2cXfgaEytuWkvbetg5h3BWX?=
 =?us-ascii?Q?Gc4aaZBrDFA2oMeLmEFCC0ZLylC2y2kjwE/sZoEOEfbMQCyb5nhGvWaPIPCR?=
 =?us-ascii?Q?sngGQDdZJFBzSZDZ9hd1sfQX9UqIxQylVeMvy5z3Eb7GNdk4SNlaQQZd9r7v?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7deef44c-d956-46e5-deb0-08dcd408e9f1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:29:53.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEGs//RPpBJrvTo6bo7Uw79bddCFJ+oyyX6fKb9e9VoutGGs74HDR10V77wdJgbkPS9L1llnAn9sQldRvwfdAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10859

If the CPU bandwidth capacity permits, it may be useful to mirror the
entire ingress of a user port to software.

This is in fact possible to express even if there is no net_device
representation for the CPU port. In fact, that representation wouldn't
have even helped.

The idea behind implementing this is that currently, we refuse to
offload any mirroring towards a non-DSA target net_device. But if we
acknowledge the fact that to reach any foreign net_device, the switch
must send the packet to the CPU anyway, then we can simply offload just
that part, and let the software do the rest.

Example:

$ ip link add dummy0 type dummy; ip link set dummy0 up
$ tc qdisc add dev swp0 clsact
$ tc filter add dev swp0 ingress matchall action mirred ingress mirror dev dummy0

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/user.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index c8ddbe22d647..bd3e3944931e 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1365,7 +1365,7 @@ dsa_user_mall_tc_entry_find(struct net_device *dev, unsigned long cookie)
 static int
 dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 				 struct tc_cls_matchall_offload *cls,
-				 bool ingress)
+				 bool ingress, bool ingress_target)
 {
 	struct netlink_ext_ack *extack = cls->common.extack;
 	struct dsa_port *dp = dsa_user_to_port(dev);
@@ -1398,10 +1398,25 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	if (!act->dev)
 		return -EINVAL;
 
-	if (!dsa_user_dev_check(act->dev))
-		return -EOPNOTSUPP;
-
-	to_dp = dsa_user_to_port(act->dev);
+	if (dsa_user_dev_check(act->dev)) {
+		if (ingress_target) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Cannot mirror to ingress of target port");
+			return -EOPNOTSUPP;
+		}
+		to_dp = dsa_user_to_port(act->dev);
+	} else {
+		/* Handle mirroring to foreign target ports as a mirror towards
+		 * the CPU. The software tc rule will take the packets from
+		 * there.
+		 */
+		if (cls->skip_sw) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Can only mirred to CPU if filter also runs in software");
+			return -EOPNOTSUPP;
+		}
+		to_dp = dp->cpu_dp;
+	}
 
 	if (dp->ds != to_dp->ds) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -1506,7 +1521,11 @@ static int dsa_user_add_cls_matchall(struct net_device *dev,
 
 	switch (action->entries[0].id) {
 	case FLOW_ACTION_MIRRED:
-		return dsa_user_add_cls_matchall_mirred(dev, cls, ingress);
+		return dsa_user_add_cls_matchall_mirred(dev, cls, ingress,
+							false);
+	case FLOW_ACTION_MIRRED_INGRESS:
+		return dsa_user_add_cls_matchall_mirred(dev, cls, ingress,
+							true);
 	case FLOW_ACTION_POLICE:
 		return dsa_user_add_cls_matchall_police(dev, cls, ingress);
 	default:
-- 
2.34.1


