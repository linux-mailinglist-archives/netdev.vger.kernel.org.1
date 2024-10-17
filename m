Return-Path: <netdev+bounces-136654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B94A9A29AD
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB561F20F96
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DAA1DFE04;
	Thu, 17 Oct 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f8puWzne"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1C1DFDBC;
	Thu, 17 Oct 2024 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183966; cv=fail; b=eLFP9rhYANSHlRV2Gy0Z1W4eoPbITxlTpJjgWXewGXRr7eM38MzpnMQ6vy2K7kcayXPo27C9pdyoPN30JFi4PB3BKae6uKlmXmy+wTkAETlugQOE6YaXOhh0Wpt8+PQkuTPHoPqxh336jX5YWYJYq28uRkQ2lE6sqH1UOfMIshs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183966; c=relaxed/simple;
	bh=wIUrTrhNW8voTbt7S2N3DcUQZCOS/LFgQAKEzuNP3bU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AgOxWo9ofachCqasO4LWuaq7KoZu6Fps/Ei/qKCbP9Po+K/5ZmsLG9Oi1T/GwU6EnARBymTttlGXeEuAUdFWZ5JtlTRZryFd64lVYX5ZmNI37uQ7cDZRQnLDuBAHt3J2r3dFfVutC8PULkrLFdy0cHWdvfzrg0FsK1oCNPH2D4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f8puWzne; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+o72XIEoun/GlFhqC4bYelIEf96gehlQHtxidVIr2WwIbQgMnRBwscsPU/3iAUyVcMeYNNRUO/tnxNXTapYXFhjIiaiqOUyQ4Wvy9tefImvlhHcrNhrSTqJjRcAfC5LHxI2ljvm+qKHolVoJho291Tom4nfaVXt3RWniigFXjWXufnLgnESzTEW1xtUJt695p2aAHk7pZcCGjhaZmM3J6GbJDDzqguYIpHHBV5hBuK52TvTPT6TqKth6JBPMeE6bVXSGndvtTLd8c90Q9lfb34S1ALOvDkyWS9GU5ea0S34ulgVatP7EKUcYne9M2vbBgZ9TdniP8g+rrvVp0EgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kHuAfVJGiwARpJ/2ZCLFs8aKUZwVnoBIImRC0rBwNA=;
 b=NGnf2VN6jRWIlsHGMzdgkt51ife3za72Xgub+Wdw+N8jhsV/aijePPp3pvWifhXPQTntproLqcXPET8p5D8eav3qt1CFtVRCZ7WO2yHvIn+uGz0HeaTdDGUGtNXjnDGX92pjP1ldCvjYcUfs+ykcHe7dIhb2uLtxJRgkIcxVv/DcOqmcXPIKTGEu8YfIb5+W2/1kMrPL+Xftno8Q5z7nIJohwVcXaVnvCfXRmMzkz2Cy9NJCljZCP77NbxhvNcmYFZh68dHscEEupPaU18/KWVz6nIYVxzeZiHdh8529+WHWHL6JVE3TVSWHAUx4Bpn824GFYkIFNy9ItvbHXJ8IuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kHuAfVJGiwARpJ/2ZCLFs8aKUZwVnoBIImRC0rBwNA=;
 b=f8puWzne1e3F1gDI1my3RecEH9jF7555adZ6S4qPYMdzmxOp6Y/nLQxbwrwKbo8FqUxXkJldTkqS1n4TYcKe1KZ0WSaOgjy/12N8S5jnS7V0q9qajeR1qAqzNtSTSIb+NqRH84eKps8PJgwDZTVyGlH3gL7GXwDWhOPBmSgM0FrfdnJ/to1u6kgdrdJYcjHEUbqNMEcR2hDzxVI1iVqD4SMBaCwb7RkZVTJtnpJTZGI57F2oxWjeKrI5P3p/jVILt95QV77V6P09GyXbgRI05n2hAUP0EHXzPX89wBr1jlTq92eNb5QLLoC6lkjLiB4txn9IYx+YWL91IwDRCeNJDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7456.eurprd04.prod.outlook.com (2603:10a6:800:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 16:52:41 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:52:41 +0000
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
Subject: [PATCH v2 net-next 0/6] Mirroring to DSA CPU port
Date: Thu, 17 Oct 2024 19:52:09 +0300
Message-ID: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: 856dee91-c94f-4364-b27d-08dceecc1d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cj8i+K/ACI9IZcO7Slqn6N3IY33L5QpyQR3mT6q4TGoJHU+3nSgOK7l3r5R/?=
 =?us-ascii?Q?qQyiPt40tMW6BvKw22kby23Aro31FYAzk7G7b9rrYV4wThoW7pEMVBCYf3fX?=
 =?us-ascii?Q?NChBj55ow15vJ5wMYeZ2CSI+DDusRk1pKWGLW+49zdg9sg5zyr33lLIZJoqn?=
 =?us-ascii?Q?yrD5XhgQy3YZuLLmyY9mJkEY5lg2+YGOZaQwXcAvj9fFdRKFr+cVwXZFSzm5?=
 =?us-ascii?Q?0GQbvmT3lb7OA1168NvswNvUbOF8Whma7E23W4fuZf3OmN/g2UMBSI1I5gVr?=
 =?us-ascii?Q?fzjOxAKN0pCOUsYeytCWCkE2PuGzbLNUbFy9mAboljTRAAmoqFQUFc6N4Ye2?=
 =?us-ascii?Q?dIPD0r/VdsbUVzj09HdI6prjGx73AJR0qAQtoNrMnG3qLZnN2QdsSj779LMM?=
 =?us-ascii?Q?C2EnDM59lMq6c0Og0YcKzWAeQljlTY7kDRp97gCB2Qk+LDox42gBYIQNOqPo?=
 =?us-ascii?Q?zvFtFaaJHq5Uwnz0F3+FW7FNZzEGPvtndNF2bvHYXxD9jxHxzczdnTwEJ7Iz?=
 =?us-ascii?Q?57VeiroNH8vLqYg1+eDDPLLoxMcvkQUlbPV4nvmUdGymHvbooTJoNn5Gw/aG?=
 =?us-ascii?Q?QTKhG5npJGUOziqM1gnPVbiDf9QQeTs/1KHaNapSLdm42CLdsr+q/IkTt2Ke?=
 =?us-ascii?Q?4q36FL+QJ25Liv866RKD1z9KsgQT1mTB6E/XAK2pyiElF28wRAwmOshCs/cW?=
 =?us-ascii?Q?Sci3nmHwXpmrR/1MVkCqCAAdCHjiT6JSE2+SZ4iGWyXU6qjC0T9gHMIAyhA6?=
 =?us-ascii?Q?CRuPcC7R1gEvjPT/LwRiU3k6mcnwEjytHN8RB+aMTTJOrJt7iSvGUKZz6X8P?=
 =?us-ascii?Q?QrVxyXSDpKWimnfCBNeb+mwIe+JWVafOSlH46iME5w3UuCFaPm+XVxNAwDlt?=
 =?us-ascii?Q?LSvxdq7f8lu2vTucNR5FIEFfeWD0F6YNsYIMKPHLG5UdDplZ/93tG/g2AKf6?=
 =?us-ascii?Q?Hf0pvBc8ueE86pHv3fQTQSrSiAzKH6W2OwbNi8dzgzTUPa+4bETAzfMkDp2h?=
 =?us-ascii?Q?LkStLJg3en7U3fU19n9YDLVorKd18xt4YkAGTB9aW9dus/uP74wH06SPeLME?=
 =?us-ascii?Q?C3aZRYZ9f9wXNx0z0sWcCSE8u+N5/s4U0NTON6oYTXr3TVvBSaMJr/Y9mkRQ?=
 =?us-ascii?Q?T62KVWmOxbBMe6QtOOV0xDYgsBoYrR7cMixi36SEyTEAhjoX3DWZnahPGpM5?=
 =?us-ascii?Q?OsOpk6ER/OpDQ8w21a2ElEbBix59WqrNXO3/p0VA3jWJma0y/NExx2/Sn0Xo?=
 =?us-ascii?Q?8Xv0tJdMVFefLDMl3XBIFvcX7ElTVwPT7zEN071+fCp2ZG4XBG0W3s9TRzbd?=
 =?us-ascii?Q?Om7nNuApbfgSxx9SVJWY80gbZ2XHdXgnK7AwOR69yDiHu859OEb3wsjU/x3j?=
 =?us-ascii?Q?Fbcr3ZSJMMOIUCqUP4cpHb7x9i41?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xs4AqKR6c4hdLgqrPkIEpW4m8pD/61JsaePpQZrNP5PXGlEmCwU542PsKuZT?=
 =?us-ascii?Q?VShgXqB64Ik99jOpFQiPonpy99YOeW/iDqHjEDe2vC6hdy+77AAJ3eu+aukN?=
 =?us-ascii?Q?KulHQWOf8e4/zE/CMSdDmnvmEKACXrsPcDC3UHwsl4cj1N7CE72O22s5PjHR?=
 =?us-ascii?Q?EVmso9O00AI7rg7x5+ddWNJ6MDj7m3F1uozm7qWIoAjVTb3HccST5UUBRbln?=
 =?us-ascii?Q?5OF6J7yKoHQt8uuw7m/wWkK6bSZ2IkE8NIyiw81wCQagD4L6HNtORzTDCJ95?=
 =?us-ascii?Q?XzbzhntZNfebH+zTDocGEzr0FOj+Oa48B6Ja2Yj/w69d5F5D93dMN5u+Yi8x?=
 =?us-ascii?Q?eor8XHA61eocyDAHHgo06YbRkeJY2EP43YrqlCI2sHaRbehpOr3rNosHhg3M?=
 =?us-ascii?Q?GS5BioUXzjUSexbF9FBlzRkhlPeShh+iTQHUEhLuOh4BvrN0S4rjaAUG0a1d?=
 =?us-ascii?Q?wkFkkk2lxsuxBkwc46JOcNYSlIVwkNRPmFV9D+qpRO0kg/LeUrY+WPEEgHPf?=
 =?us-ascii?Q?TntLSuaXwYWyC+uGyw7fiLac38uhL26rhpzHDXNpJgKccuNw5+g8OZSCbniL?=
 =?us-ascii?Q?9U/GjcXNjA1sXCYOvp8eLFtCCmfyz0lSFMCh3T3QU1ouQDAbJQn25INMAB78?=
 =?us-ascii?Q?q0V8NZ0xjlcSiJL/LRceQtVJLRi67/RShZBLPyQHQRRtShBJkvcnBP426ELI?=
 =?us-ascii?Q?gRjEp0+ljnQ6JQYCFncFrdgbQoh74rUjpJaYhBGdvlvCxgKgiM+vnHm5mHwx?=
 =?us-ascii?Q?AfAWhLzKDf3C4aq7mpPvvqL2sdXTglkjOou6kUXPXW4oQ3sH8lzHQbBvZWJ1?=
 =?us-ascii?Q?2KOe22P9Au5YhTfeJ2RLBKD57MYIsuEWJepsZkorxocLJUqaZohos0+uwasz?=
 =?us-ascii?Q?Zd83jBUwM6yrjgE7z1JO8zY0BDBm9tOfuXNZHLnlt+lUTQxTQiRDxiv67sn/?=
 =?us-ascii?Q?mJL7hVnIy3TrT41CGtH2mp3HCp1e/2LRHgX14R9CGQ2sBdE/x9KVWoZFsyHS?=
 =?us-ascii?Q?CKY8jgQ+kgbMXn9cm0G2SHiouqqmxsiLlfXQOcIZl3Df+C19LxvQR/26wWgH?=
 =?us-ascii?Q?wPyzUnkvqFFbuiGBFAcyIMWQacFt95PsHb0nrvF1cwx2slIJdlSnmxb+ydr1?=
 =?us-ascii?Q?1iMaGJlVz2cVBV6L+y4c1SFXLo5j7BWrDLcYkIkQUmag4X34EttRaD7/vuUK?=
 =?us-ascii?Q?cgKcgNpzJEAAdXF6/WB95dT4gr4trzr3ATm3ASrpdnnN5RlexUXFTE9Lcc+h?=
 =?us-ascii?Q?DK6RMwYnjWBiEJbkfbz/py/M1kjqFASISHej+zU4EkZocgPQnTscICBFRoy3?=
 =?us-ascii?Q?W31P82QMJCIb+XV0SIfkf6xC+YyhqeeprhUBUQ6R1bjul6e4l5b591ENT8RH?=
 =?us-ascii?Q?zHfCbhpv7o7EQjk+6LEsiaKtsZfZjMEn7H/rutZfE/Ne4U/ZeH9lk4O2wEQV?=
 =?us-ascii?Q?oJH8c05qlK2hhoVGEIUZ9+7WrrC6d4dhr1RCilqVY6iJJOYSUzxA6StTW2zi?=
 =?us-ascii?Q?1sq0LVWEx0mxDON7NSNRtxgPzkKUrzxlfrgb5solPiEnvuoLKwZsjt0f8UkH?=
 =?us-ascii?Q?c/RN62AQpmiQpdtlPJ/n3aD1tsfqzhu8et9LVMXnrutC9YlKncp9W66RI+r4?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856dee91-c94f-4364-b27d-08dceecc1d34
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:52:41.1726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYtqqLK5TIc4OBNiVntmWsyYGb2yTCXADvlGGK+RfW1lstzzQPU+jZ3XqV5dO1td9t0YUDyJRCYGrbugWSuRXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7456

Users of the NXP LS1028A SoC (drivers/net/dsa/ocelot L2 switch inside)
have requested to mirror packets from the ingress of a switch port to
software. Both port-based and flow-based mirroring is required.

The simplest way I could come up with was to set up tc mirred actions
towards a dummy net_device, and make the offloading of that be accepted
by the driver. Currently, the pattern in drivers is to reject mirred
towards ports they don't know about, but I'm now permitting that,
precisely by mirroring "to the CPU".

For testers, this series depends on the following bug fix:
https://lore.kernel.org/netdev/20241017161049.3570037-1-vladimir.oltean@nxp.com/
otherwise it is possible to create invalid combinations which are not
rejected.

Changes from RFC:
- Sent the bug fix separately, now merged as commit 8c924369cb56 ("net:
  dsa: refuse cross-chip mirroring operations") in the "net" tree
- Allow mirroring to the ingress of another switch port (using software)
  both for matchall in DSA and flower offload in ocelot
- Patch 3/6 is new

Link to previous RFC:
https://lore.kernel.org/netdev/20240913152915.2981126-1-vladimir.oltean@nxp.com/

For historical purposes, link to a much older (and much different) attempt:
https://lore.kernel.org/netdev/20191002233750.13566-1-olteanv@gmail.com/

Vladimir Oltean (6):
  net: sched: propagate "skip_sw" flag to offload for flower and
    matchall
  net: dsa: clean up dsa_user_add_cls_matchall()
  net: dsa: use "extack" as argument to
    flow_action_basic_hw_stats_check()
  net: dsa: add more extack messages in
    dsa_user_add_cls_matchall_mirred()
  net: dsa: allow matchall mirroring rules towards the CPU
  net: mscc: ocelot: allow tc-flower mirred action towards foreign
    interfaces

 drivers/net/ethernet/mscc/ocelot_flower.c | 54 ++++++++++++----
 include/net/flow_offload.h                |  1 +
 include/net/pkt_cls.h                     |  1 +
 net/dsa/user.c                            | 78 +++++++++++++++++------
 net/sched/cls_flower.c                    |  1 +
 net/sched/cls_matchall.c                  |  1 +
 6 files changed, 105 insertions(+), 31 deletions(-)

-- 
2.43.0


