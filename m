Return-Path: <netdev+bounces-138267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873E59ACBB3
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DB01F2491F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB1B1C3039;
	Wed, 23 Oct 2024 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bewmE+0L"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA51C2432;
	Wed, 23 Oct 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691595; cv=fail; b=X7/0LPThonbgIWtc6rDLOVb3JHZkYMI9C1qWS9eJanKj5lbwFG431MPlVGm66BkLei0l9al9+5yn3423Pi9jUB8Z8Ij5eAA6GjKoYtinss80d9NzaRAk8xaKSYadULU5CISmAnDD2AlmhhpXg+GseT71j51WebzEt/kRubC8wQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691595; c=relaxed/simple;
	bh=uqehQ4dw8+6/V/ZBC3WY7b9QmihmGeiBooNsGJgwZZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ejjLBIN1zvHKjAsP5aPIxWD6XDHroT3fzgQCBUC2zd2jOEJvDOSk+4H3deb1kMDh53TZ4KJUd4bv1WALLpNvgfoXD63QdV+7YW6gl2KJMCbc5ToXjHobcXEPDLOPVQ9N+uvnBOnSqZF7z7i570K9+U4R+V19GUO+7eR7XNtcbP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bewmE+0L; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrtCSw2U489mmYHxk4xmI+UfFI/43gu9xWYAera+/DSfx0bR4dqayTQqG71/tN7fTTcbemZeGJUdrOcRYKUGbe4HJeaeuf23WJs2iP/nph0BVB6R+94k52I2lnnAfSgzdGBEX+tVJJf6bdtCDLvg+4OwzL+KSTa5Pv+Hf97gLuSnQXlJc3M1V/qwSNIfxlE+v2rmSP5sEKVL3VxJzwGYu83K+aEc2Uwqy6T176TUE1F+MsmRyHYCWWUIVCFNHozwUUchTNrts/jioj1rWvaZ9N4Q2Z/17gdJy4ViXrTJpvTcssBq6jK5qN7tMOcbD4pFm1gYh+GPlyKfyOsAvIcG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLrDmDYggFUEiQ/FfLYjaS5I+I5mtrq6iqwDabYM/J4=;
 b=jQAgLwNLWnOGTB68WhJtO8ow9JGsiZCHNYGAayrUJ2rwL8mg3fcrw4VEoc034D5hCI0mg2qp2dz6OaLRbmeSkSR2OHxGs2uNCZzxQoNhK41rdDkhsIr7gF96CV84ZeGKzlwLBGuyT+qt/oX5IZRw2yLI6P1T8msV4sHNCRdBs5r8i0brC7heCiTOv5s8gEI37kyvBBKSLDWVJPBs3OSgwKz6eozm2NIciEtdRh4ISaXcz66EPck4x2XMXijhbmnLRhxnUeHLXPOSZGdmjG2QJ3mxRlDJwcWcsJksYu5bp/rucE+T60HxRpeAgsX/MZpbCeaCcXZEcWBB17Ux9ttQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLrDmDYggFUEiQ/FfLYjaS5I+I5mtrq6iqwDabYM/J4=;
 b=bewmE+0LAtrb13hMPt5eM4OSdKUxqHqT1ovLRxgoMnVm3QKHAjsOGQaWe9pbru+bPHrJF1dSJX9rpnRsuM5Lu7X4r8m8WohLkcydRbPgjNNEFgNnm9jon/AZrddRPGtZScUe4fVUbLkzddWiLcoYFAk9uMnJWaREaBXF1ZfY4C/iiHjks6Lxm4Pojj4hvZyfM8QvNWhLZ/HV8EAjb0HP1NI9ufN/oQGWJ38W9iV/PMq8gU31qXMfbuEecloqjwdP5kPN6gQBKMl6AyqGxHOmf5yzhLlZbApdjwJ72JTx72kYwgalQ0kwRKQuDl5OsitoSrBw6p+gS8Ica/js7czl2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS1PR04MB9683.eurprd04.prod.outlook.com (2603:10a6:20b:473::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 13:53:06 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 13:53:06 +0000
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
Subject: [PATCH v3 net-next 3/6] net: dsa: use "extack" as argument to flow_action_basic_hw_stats_check()
Date: Wed, 23 Oct 2024 16:52:48 +0300
Message-ID: <20241023135251.1752488-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
References: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0105.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS1PR04MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: c345ed73-b4b1-4d4f-7eaf-08dcf36a052e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?apG/GKaPQOIdtbDlj0RCRpa+shkkc0SB67KDrZLjEUE5f4x2aSi2PdyKNn0k?=
 =?us-ascii?Q?oYHn6YbBpgSJQbKYVIGylUzi6+F8FAXh06gf+fOE8VicZfBWYod0GOnn3YYE?=
 =?us-ascii?Q?PZmBymKC2tv2/p0bQYgmwfpJqglRi3U6KHnBeZvJyp2jcrvSsPq4V8wlpDLH?=
 =?us-ascii?Q?unFH+kN7DTRaQicUHHrgbDM2yFABx/f9VTmTtXhedu7PGCLxOOZhBll/t65+?=
 =?us-ascii?Q?qRd40zJKFBoEPSJ+8YhmeCwbN+kfKUshEq4cxGnQeAUdNE6KZzAsBcOGULPP?=
 =?us-ascii?Q?40SPqK22K38CV6dlUJQ8NPCasL6oxj5TI1FVpAnjeWsK6zDSqfjQ9zslZWOf?=
 =?us-ascii?Q?onRv4z/hHgxXeaqu1ABbVo5c3ONN3ndjwzookZeS/m51IrlrrySbWQyCzbwO?=
 =?us-ascii?Q?zPt89VVvoUL1KLVCxRFPIqhpISoRnUYdlZMRuZj72x3DhMMiglRw+/EDeAn7?=
 =?us-ascii?Q?kU9MRm3TU9XkVemKAVyNpWax4TfNM2rHSLHS6UqxAYLLdtAS9/g8h65lHOve?=
 =?us-ascii?Q?axoJRK5mQ6boPvnPi+95gKwqX6z5Aox8ywNAhj2MZojCC17RYkt/HJSC+2UM?=
 =?us-ascii?Q?8m7Sl2V51nN79fL/de05xwN9Ic4jm0G7nBWoqlxYlUJh5CVH6d3cv8AFflMG?=
 =?us-ascii?Q?kP51gbF2Kc0NS/JU1b/2HQrMbFBfEwhmzEbzNkA+w9pGqV09SYD1iU9BXlkV?=
 =?us-ascii?Q?BknJdkFegWbwru+glb76TPX5fdfT0uAEtF3YcnkzMzq1XTJyO9kOeTgLEwcj?=
 =?us-ascii?Q?8hFJ7EaZYEzkr7YjymNBJQfR6bvBqbqYkAEr3YZSyG9ZinwPaMOpK3ixtbbP?=
 =?us-ascii?Q?z6YYKHpCDbb8oFsITN5L1I+dPfVuySJ6Oekua69DL9SDK4UwknSMx/XvyQVP?=
 =?us-ascii?Q?BDkgEwhjVrgfzuFodPM3SbdrKCc7sUQcRZ7pg0QzEWsxzbrK42L4zjdAhJQg?=
 =?us-ascii?Q?BMv7qYCJBsLr2pRphHpjdJZ1V/pU1ztxMmP9+DZW2rKVPttb2EGpjmWJ74Y6?=
 =?us-ascii?Q?2Jeium1vRFzSe3ddHHhQlDmxpfdldk6bPzWaEp9Bz8GgdD0CZLwa1D7DZ/cP?=
 =?us-ascii?Q?/sXm62s2e9G8Usd3GYwQjORfhTRNuIya5ZdUFAdGFc5JUF9S/gpfiTEF5ZrJ?=
 =?us-ascii?Q?7x2Rl804B2WyG2/+wJC7dWTj5qegAZzvBeEDjeFAlU9CHV4/uHTc7r9hyB0H?=
 =?us-ascii?Q?IsRG4BgkGNyDw4kGLCBqqxAbUZL5R0SSVjvNf3J9nI3Ps/YFue3urkx2xqxj?=
 =?us-ascii?Q?Ev8CkpGzrLG07yrZuKSinPoe5zwQa0ALIdABmJ+mLkIwTEpc60BchMdKPbcY?=
 =?us-ascii?Q?jY2B//9GcpmDy86A9mrcXRNNWPXTpQMFgnmefcgPlDTl/GnkaBfZ6DPXZo65?=
 =?us-ascii?Q?5fe0mUo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/KO3QERwpQ55xydBfrUVWMWvpcdBNayqQHGW3JK+F5kSZl9KdkJTuueUYpSH?=
 =?us-ascii?Q?OGudRSrzfnes2xfrOuR66bhSsDLq/yCK/0EIhlIKkjleEuT6zd32ic9Gdmoz?=
 =?us-ascii?Q?yVqa2JKcRcGRZ09ksI7tucghpfxl72KIrlh10bwQ0Ygllz2Nu/erDecmVony?=
 =?us-ascii?Q?PuR4Lf/y642CBVoK1+h5VOxLkLksAXg2BOzf7jtlbqWThUYamYFzjQYB+9VT?=
 =?us-ascii?Q?IOsTg83zvxy/YhXmQDIxZMqQPAdpRpID2n5vMaCIX+jwY1uqivvCyEWgaWJn?=
 =?us-ascii?Q?uceU0vhD3f2eqhGfxaI1u8vCRdMYXHL3qQZillKL+BbrdwpxeszJwikZWD/c?=
 =?us-ascii?Q?6JHqXX3a41BID/XdPeNRidJG6vHoqxckD2vDOGQqCdoUQN795g4u4H3vIC2N?=
 =?us-ascii?Q?3EdH14XbUFDTdiwzrrISQmv/NfjDSlRZZVGAUHjcnA/n65iTsXGoTf0IUOhs?=
 =?us-ascii?Q?v5M62BrPAdRRX/2ZywcL4Z+jwYnuxgRhe2fdH8y+7pFR+14vQBkAQvycqLDX?=
 =?us-ascii?Q?CCjxnoLK/lLaubFQc5ID1EHerBM+mvDgm22ViAsi2LDHT8TFUswD/FqtwVJf?=
 =?us-ascii?Q?bYJQsSUDQ9uVmw+2QdWBLfcO6l8UWG6op6snxE1UgZE/u54GqasNCbc5cQq7?=
 =?us-ascii?Q?eL0XU525hcDge6FzidB/ZEgrrttE2LlTstmSGgBqLjBPzdcQtgPL9K6sz8N8?=
 =?us-ascii?Q?Mj3EFXlkRCgk7xPhZNxflinPpA+TBYpSfNJ7GN0BzpGG//QA10JvE7shx2ek?=
 =?us-ascii?Q?SztCuhcLQlfAMKNqJObUUk5jxry8xfrSF9fkIKjR3IkTlRcN0QoZ0rf/elMs?=
 =?us-ascii?Q?bXKv1wZXF/lScLzAwPFpNaChF1B+qzPrRyi4LUQgACKV1UOLPZy606r0Hjrr?=
 =?us-ascii?Q?4GEi7zSqirwMJLW40NCSR0hSg83O0X2AW/iNc70UFVgjV5gJQjWnSITdvxU8?=
 =?us-ascii?Q?pDgwqRqnOwj8zTj2AWaLZJwTOY2RIBmoonqSDadx6CtvREEb/CErLcDcMt23?=
 =?us-ascii?Q?+5LFFBaJGjuWRLU5sxn1cfq1AjGtClYXfpyUswaOzyXmnsC7hEKv2Zx0aJgk?=
 =?us-ascii?Q?ALNh9P3ro4fl3fVOjuFOTdmxIKkbDLuH3sTLQ7vKgYnk/F7XwQAQGte9UhrL?=
 =?us-ascii?Q?AdAO9chgtI11JEz1bxRKDSEQ4fDrQe/haAqZRb0MklybR2o7NcmdINFxbTuf?=
 =?us-ascii?Q?l8KpO68hLIP/8oiMx5dLNUPphQzdWJeGrvSqfPvwHIzVh0aJskskpg+lYk7U?=
 =?us-ascii?Q?j9xyPC8jjYQ7x4jPrU2f2eW4wzxsmgYDCN57opCR9Df8iut6KfVuoGrrijw4?=
 =?us-ascii?Q?n4tWpIhxpSD5xciisZsZ8TBNPncUgE842CcG0+OcWkvsoyo2Rd0v8dIHmEvz?=
 =?us-ascii?Q?yp2aDAUDiB9HgsikqeF5ZSl3/WJC0ilNasDcI2O7Z9uOKhwF8pvh720xmiZM?=
 =?us-ascii?Q?6AfIbLo8DJzkEIs6tdcdt+d4vWJopx7TMUtD+0KQ9cq3UyB6kqElef1axlN6?=
 =?us-ascii?Q?gjFw58r5xkjQW5Ks1wYTXkYSrCDW+Zbd+vYfPQayHtE/hP8LgeYAfYATJDbT?=
 =?us-ascii?Q?0gvUBfrH6SdbII1LudlaJghODZIXZaDTnQzOFQjrRDoQTaIuAJVLmr86+gO/?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c345ed73-b4b1-4d4f-7eaf-08dcf36a052e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:53:06.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cxufpt6MxTYzkZOniscfEq8teBnygjcHK/aU9xusaH9GrfmVpEh0ty1Vd/Mcee6lK4YxijV+izwM2cYYXtoqKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9683

We already have an "extack" stack variable in
dsa_user_add_cls_matchall_police() and
dsa_user_add_cls_matchall_mirred(), there is no need to retrieve
it again from cls->common.extack.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: none
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


