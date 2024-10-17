Return-Path: <netdev+bounces-136657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B71E79A29DA
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4602B2FDF4
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880511E04B0;
	Thu, 17 Oct 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TYxUOJLO"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE41E04A2;
	Thu, 17 Oct 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183983; cv=fail; b=BeDLwZr+rdbqzYoico5J/j4/kfQ4gxch7jpdXUZVXiRWHrE3HTl3SvZFKbLoYl2QfaGrXO6WjDAywlyCIzwdyI9PUio94pOczmOnVI/25a6g5HmIcq8zFo9V8vB1k3YdRbeu9IgSylUnOQTLH5J0cF4GfeOLVtg16I+fRj0r5g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183983; c=relaxed/simple;
	bh=8b2lBFWMZFnDB/CmIFrwVlT5saDWlM7kb5KDGDNG8Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QXYbOaP4GRQtiWgJho75+9k0LhhypIkB6fmVVZe2oyYIaaPPjRKpeXB/XF9V/U6VKYalksWIwzd8KLI48FUX96cMKuh1Lz8o8D2xtNurCaf2wY4WDfLEYlXSvtPFvr9FKLyHn3s0UKiUCV/fFcyV9ieJif1+Q4+DrlJ1He/YcqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TYxUOJLO; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kg4m7SH0a7KLXO6c+jk3+QbQt6q/EmRMLq10wwJgH8sasTfJeeOzosZJ6MNMuM+zk8/iEipooORXpuG+XvCVWABpKAIjmsJdc9Jmbr9PW/jRylviq79hO8UL1T1bgrVE9b4EryeXo6IBLxaM5O0noYy7byDsee0SOmSBdQzlehZxoHEyXa1WqR5G7FCdY1fWfyfMiYRzJ/23idn79X940ET8XF6vFSHPmuBv6IyF/UviOBNNohsd2+T4M0jFDdV1glaKYybs5FLBAVym07379o4Vzo9QvdSvHiumUEtFvm5Beg4IHWAy9/1XxJbYO26/zxIEWBy4d1/rvkFW7ouLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZVLzQwC4jPpGj/O4aSD6GwfDxudDb60l4OfODEf6o8=;
 b=xVMNpsvyoj7QKwj5X2E3tRCINjyEUUhwiBn8OIzX9NuItMJJ9HkWJ0TkcZQPwptEG5Ad3C4YaHnLBNpy5MDP4+W+Ojdg7jzRn1MwmaoDKuOiAPeEVTnD5B0VEri0BFbMiNiDeaiVKXZyLD7sec71SJCkVNgjXIqA8nSyHQbfjRzB5EH12LYqRmn+5ZNJZ9InG3YMLzRRTKlZTs9URUEhcJ85xxUY8/6X74tnjDkoE2RfdDeBcHdsOHrkaWHvENAjNCQmf98V5fXciYb+4S+6rYhLPnX2Y9xsuFyBn5rarPA2oao2dluFYKPOcEoeLdmnmfR0iL5m5hNdLhHlDre/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZVLzQwC4jPpGj/O4aSD6GwfDxudDb60l4OfODEf6o8=;
 b=TYxUOJLOmEg90Sxz7q0JNTDwzIuwBU5d+Mo8n9IusXu27LMQFfRW7SwyRy6ccYNzoQA2/ci2PJMP4U4sWSpCWNqBOAF3vfutTwYGUVxpZhedemWANtT4IwLqFp+/a6hmuJYPh8kdt0OMTgE181gmlFSrwwd4WgYdVJ290OeG91MgCNBFbsS6DYXPpfxyWu5dyZ27XSIn9kF9UnpTvxCfwuWOGfsIAU7GQAbsqy3r9uFgPH6PRKN1nKuBIQNVXEKCcXg38BVINAdXkYfJuosEC3ZSWaL27R72t0ldS8T2voClOKo7S0+7H26OxSL2mFYwF23bjC/Te6d744MHfVjStw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7456.eurprd04.prod.outlook.com (2603:10a6:800:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 16:52:45 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:52:45 +0000
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
	Vlad Buslov <vladbu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 3/6] net: dsa: use "extack" as argument to flow_action_basic_hw_stats_check()
Date: Thu, 17 Oct 2024 19:52:12 +0300
Message-ID: <20241017165215.3709000-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
References: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0259.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a217a5-e6e6-4bc5-b66c-08dceecc1fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nwJTQTYmue3rmqx4mdUP+FS1z7YLkOsP+xgN1C987uYGWUoBXQ7XtnpbvR9z?=
 =?us-ascii?Q?cZRr8Z0Apwzd2GtPT0fXwX63CaZDnpJAM33I8GQCLBdkKyZpXMJvBDKzZtPN?=
 =?us-ascii?Q?T3UT8nUf68322tJNfd7pgmXqqj0JQX68DCeLddp1Q5e+VFFyQE69tK2usda5?=
 =?us-ascii?Q?CJdIGjWFxLhv32aFOEf0ZZSpetXy+Q3iaIEeZmdfERHWfOlbRH0yP57+nr0e?=
 =?us-ascii?Q?7srAzAWhLVajKyCpkvLV+qphetnhoqCUy9mDSiVoWTpcbjG9teY8ChoK1P8D?=
 =?us-ascii?Q?1PTyX8ECfIflEksD7YYt3j+H+Q3U7upCNpJR1J8D94VWQzjYZ0S5NuY2kRw0?=
 =?us-ascii?Q?VRR0WtNHSumbzpMRl94w8d1+yFq4qsK4PdLb8arvHOMhKkzsik1ZVfnJVr2I?=
 =?us-ascii?Q?AhdQf7oBe0LEvpiSoi2KmK5tTGnUf4PJRZypRpx1dmjB07PCt/66/Xbz0nhe?=
 =?us-ascii?Q?V5uuf1txKDhpcV6XlaRwzJnm1hJhpT4GlwYs+GUwjY+VJLx2sFu9fuOWFeSo?=
 =?us-ascii?Q?KF0vsSv4iBVotR2BiuWN8x8ZKOYdRg14GPMTGho1oEGvuSg7AWQ5dmEn3RNm?=
 =?us-ascii?Q?JfCvpIVdfwP2KkiVf4Iv4JEvbR+Ix2lEYqIxwN+q2KSNlovMr7buShppo4M3?=
 =?us-ascii?Q?DG1x7Tbm1yJTBTpIxCBANXMbFBAuBpLO8IskY7z05WgnWTAWpfFSaLo2/9KE?=
 =?us-ascii?Q?+2guMO84k1SMtD3450ZXaH2KJhJr72bu373b2GkIILX3hqX9NLw+xyk+5U+3?=
 =?us-ascii?Q?uuEzAdhxSHCRrNm7GdY4PZH4bktM4CbJhttWrVLHlK0sEVB1xs+F0M/O0zzo?=
 =?us-ascii?Q?ju696RY3oQT2VpMqLlYZLunFdqK+4XJq8SlSUd5wOnh64oa9qADn4sy+wpSL?=
 =?us-ascii?Q?fUKxOLQAjef0vznbwcFdGMgHqvLoEhDB9gbC5NXLZaZkF3AxabosBq8zCCC/?=
 =?us-ascii?Q?C5wuFst7BRRKycGQQo2N3k6TCC9CA4DHjwdEAcCtRq8/SGlOCCtwa3GeZMsP?=
 =?us-ascii?Q?WCIFsV3kT9B2ZlEyz/5Gx0POdAcNyslAI64gdnbgaqGAJtVblA9s1/WSJrsg?=
 =?us-ascii?Q?hGoNGF353G/6zD6L1nbBKbecLGvOqxiCImHl61s3zSokRvKX4YBUAn/mY9nA?=
 =?us-ascii?Q?Fz5dMKFbeANELSH+0xHUq7A3rJAVZGDaI17ac7wM08MycXCLqECEgRZZ2GqJ?=
 =?us-ascii?Q?aWh0Iz9I86eD6HJv24/dNteAfA/YvhTpUD4EKbsu/r3xt4nrMp4V2/4vnzDA?=
 =?us-ascii?Q?+2BGtECYjbfRWfgWNcwHQrIRglPF2EmN02LwASmMtqMkOPrQgGKRciqTsaCS?=
 =?us-ascii?Q?D+s/1kPl9X4/lZktbQtXYoqjx9J1Vjll6U2Z1XNCIiXh5YumstqLWm9vHXA1?=
 =?us-ascii?Q?IyfURZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xjN4XW+RgcpRFWKTuV4sJC/MCVGq4dNLeoLHaZhpaSa4q7Qc4e0627Pt6l1n?=
 =?us-ascii?Q?Z3+Brm8S3UeFc1IQc7hDwH4ZaNfAR96py5lNbhknqtf7XDapingSVkiU1KLY?=
 =?us-ascii?Q?pV9ZfAmh/9gasbOO/gEaLRQJ9H7jBiAECOlUV9IO7Tjsu3gZXYgS6DSrd5cm?=
 =?us-ascii?Q?gyTxht4bBNfR8+7ZAT9sXtjNIpd8iJBz6WkFWlhRliZfIIFLIDV4/jx8Xp/4?=
 =?us-ascii?Q?LTqVPxQBFijStTEbx/NUB1vQmWM9gwayG7V+8uJPa1voDmgE6udN0N3CK8O0?=
 =?us-ascii?Q?0K04Ge9MlT7TdCrVoswjL+9hOjtN6QH061CdITkxyhMVSKo1lKkQ7fDNTUcf?=
 =?us-ascii?Q?Rx8wIjfr5dvFtVrwAiinFLrF3iVIwkCsVTcghOY4aCMRFv4Or9hMMsVppSKz?=
 =?us-ascii?Q?lVGbhj0+4i6oNbbHQ+wdl9JZj6APTqLhPv28h0kp/VMADv+xhWnXgKx4D4q7?=
 =?us-ascii?Q?Xn3DpvNuBtNhqwVjck77TRaoSmwP93PkoO8p1YWghs6S62sx2UPTSFWOBiGY?=
 =?us-ascii?Q?2DB3M9FaNKsZpd/5yiEo1/CXL3vh2lRxZ2K19CfGf2kA3RkmdPSbwPp7zE6U?=
 =?us-ascii?Q?l2+liXtj9NcnkzI2a3LRSSntx4YUhBhuRTJKg4TL7xcQpuxm+zyzyv4RkhcW?=
 =?us-ascii?Q?xVcFNj9G/2fgw8AJht9B4nieeW/FcI0135ffPkhwecZwo4zNoCF6+4jYNDSy?=
 =?us-ascii?Q?M2Z0DwY2DzmZ/U/Pil7R4VwmDi7QjsdjnKBGVLEYcjYsjEFbs7rg7G3651P5?=
 =?us-ascii?Q?6BPdAYSI1/miSWm2/u6ilWSxwGBKR/qeSr6yQvA88O0r+glR1JdVSh0rKVCG?=
 =?us-ascii?Q?0fxJCKWHnnvny4apNfk2+rOp6xAMEB0D2rBRLveFY0vJoCq9S8p1G/cE1Y5s?=
 =?us-ascii?Q?AR6X7XBjV6Ushcaqjv7qMpZgXtBWou/r2WwpYOW3eDD3C5L9i2wUG6xUnYi7?=
 =?us-ascii?Q?JaBb6nr4aj79VsAJHM+LrmDfnCrvo7Y91TaBVFHAaSSAaNo5Y3iEoklyVpVl?=
 =?us-ascii?Q?156gNUThvKZfVdEkOQmXH3o5twcXaiyLdwRM5BZrGqt9BNMcCIZCxcsWG2Ft?=
 =?us-ascii?Q?Re5cmMMO9pB6rky2Xtr0Ke89FZaRzU0FxPQuSa6m3ZiLan2EgkIgFqR7gjNf?=
 =?us-ascii?Q?mk+FbjLD2fesRKPFHM45jvGEs9j2AWpMVFXIQGS3duyTW/3k6GxLxMZMpdCv?=
 =?us-ascii?Q?Qf+Vc0lX/q6gWbAsgiaTHzH0HVmCy5IlsHltazBjeBfuMT6kGKXMuC0Mfm6u?=
 =?us-ascii?Q?XnM0Lq2zz1WwZshVKCYmwG0ltXPG9KNkaxItQD7hX1DOLUHdQ82Xc9aC8hKG?=
 =?us-ascii?Q?j8UYDTev3kAiOg2S5kW3R6wr88ajZvLeZR113BpfraMu2w2sFUKSU2y23+Zh?=
 =?us-ascii?Q?vmT7ZMXAry4TLlWgiVGpSNwKRYVjoJRV07j5jfV8m6SY+RWUMn3Y+tniipdT?=
 =?us-ascii?Q?nbfhsUUzfaCP+kp5uvNCl9MukLxIsfswIU4D6Ay/oKQR/UbcMDBXTxdaO/qT?=
 =?us-ascii?Q?9pCej5fjd6XNfd25+d5LwCI75+3M/ElR98Kqg/JdtK//e9/rbgSNKL24J283?=
 =?us-ascii?Q?f7QeTEKszjPMgsJveO1zAov3AIbW/luVPHUS623AUkAj7M1sSRXQ+32fKtN4?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a217a5-e6e6-4bc5-b66c-08dceecc1fad
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:52:45.3964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55uxQ0Cyrwb4cuXRrvrolpCJ6guERlvps3/GdY3sek26MT3e3Bw00bH//I6LuCq0KpTrKamWoR0ecNljCXpzlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7456

We already have an "extack" stack variable in
dsa_user_add_cls_matchall_police() and
dsa_user_add_cls_matchall_mirred(), there is no need to retrieve
it again from cls->common.extack.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 net/dsa/user.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 5d78a881ddc2..c398a4479b36 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1383,8 +1383,7 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	if (!ds->ops->port_mirror_add)
 		return -EOPNOTSUPP;
 
-	if (!flow_action_basic_hw_stats_check(&cls->rule->action,
-					      cls->common.extack))
+	if (!flow_action_basic_hw_stats_check(&cls->rule->action, extack))
 		return -EOPNOTSUPP;
 
 	act = &cls->rule->action.entries[0];
@@ -1450,8 +1449,7 @@ dsa_user_add_cls_matchall_police(struct net_device *dev,
 		return -EOPNOTSUPP;
 	}
 
-	if (!flow_action_basic_hw_stats_check(&cls->rule->action,
-					      cls->common.extack))
+	if (!flow_action_basic_hw_stats_check(&cls->rule->action, extack))
 		return -EOPNOTSUPP;
 
 	list_for_each_entry(mall_tc_entry, &p->mall_tc_list, list) {
-- 
2.43.0


