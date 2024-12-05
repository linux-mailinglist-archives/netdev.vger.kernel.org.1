Return-Path: <netdev+bounces-149423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062EC9E58F9
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03CA283B64
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501DB21C18A;
	Thu,  5 Dec 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bIn9iAfB"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589F1C3318
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410545; cv=fail; b=k4uQLvfjBQ8T7iITPI+VuXrnqbe4dbDX3EP6WLz2kEpBMQwVT4h1ixxH39zj1Y0dncHdsZrJnIbuK/1JGz76Icn+dSflI+gYwpY/rL4OPj8GlpNy9M/2EThR0RkIwKpGmw18fOHyDcNd4czoF2dvdEO4Q0dz+bbu63vfmwm3IYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410545; c=relaxed/simple;
	bh=a3EnQarBVadnfjB7uu+6XwatrbHQuNLvmVyFVvVEmjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sJrtSUIIPc1zIa4TXay4256kIg2zA4twv1Z01xdq1U3FZrSf3H7yDEztvxDQLeA7wbHY5MeOK3z7yBw6Sp7ndZ2ztzMkjHQ+KN+82i4PQW2oc7tU/fR0M1/WMTcYYZ9vUDQ+MQNTeIlBSS7Wo32kU/uQP07YTKW4KgOIcYtdvBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bIn9iAfB; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFOm37OjeYZ/ScpbqMb65AS5uXpVl88LOnK/W+Nq6l4FzuD3s/vmGrTYzJ/bAO1eRDy+0ypl4MEltJ+6H+KnZnOG1b1FYgS5vDZsA4PTG7UzfRQmBDLZ41Zj/GonsrBwP/KS5QwLNz/qOQ6jpO9D+2bGgoa3Vak00mM8F/7RlDDObvwRA8KQ0nouIz1L69zgU/n9Zl8OWDbXlXBU0y8lnHoIP0aK6uZJMWoosjDqE0s5kCK+JC5XqrReJT9RY3BT1nJlmy3mtgSLwvx0cRz41YC8BkGLjQMbrq4tAxLQ896ej1S/Khj0IeuzJtD2wIYbM/4ZWnax8i5i7UfVd8kI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP1NoR+xynMilC7rSKFyQDApZ8YVb0KNUckj1ClsAwY=;
 b=oDnlNEbXF1XUPKVIw6WUNnah9MWKNu5O8WXKOZO2o8b0lgqtfqgeJrONb5D1Hy0kNu16TyymgmxoYsSokuqgp49kZc7tEWPzTr4O1vtxOiStPYhlD+7zEzBhgM+SCW0kfjMvD+vgF++2a5ivtmxDgxa4jV2b0KCX7RdP8ymcTaMcjJkzarEVF/n/xjOTt32L4vGU35WQqSEnbQ4kvezyyaj8Gr9KbBhliA0ZB+Bptxe0Xfpmya0t1tCqpQKZvzvzGtQL1GL/bU3FSGvCsI2JhrgHcBZFzT8bvNRRffFsBss84W8+Tfmz6eEpZRYMHtDd44vx25WuHvd6nLFeE/lJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP1NoR+xynMilC7rSKFyQDApZ8YVb0KNUckj1ClsAwY=;
 b=bIn9iAfB60UCPmpjzP1J6QU0soP+1jcJDUzgtb6VteOfEZwAp2uqa2Yw7saQ0Oya+eCrN1imFHi0G/r7JMA6AcMQe2xKHY9ecrObVQvuhqhTBRyN0t+b0We7ZKz+vp2XB638+v58m4cymd1vdDwRg5RYtH4b5Wrji161AC6SwGCE498p4+pnpuwz15tLO76H70DZTxh5NXC6LIGB+EIvfJ0WEVPjN6JHDJPSgk4w/6XfwelCN6e4qfgQSccsEwGsHNotC7xqPiRsnomrd/PK7ZrSjh4MpFSORLQvyDmIeo3hN8HFbOWuCNtCCS/jqi4P1d9UQBgYaOGj87WY3W3JLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 14:55:33 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 14:55:33 +0000
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
Subject: [PATCH v2 net 4/5] net: mscc: ocelot: be resilient to loss of PTP packets during transmission
Date: Thu,  5 Dec 2024 16:55:18 +0200
Message-ID: <20241205145519.1236778-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
References: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0118.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10443:EE_
X-MS-Office365-Filtering-Correlation-Id: 950a1675-d536-448d-2b33-08dd153cdea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bzq1QcEac3qLTN7i9zMHiTfgxGId8Law82bPAyuTOW3LccToSszbzCQmrD2q?=
 =?us-ascii?Q?jq7nqyciL3W8yVW2D3h6eDhymAYD36ectykqYBCqctPitnaaHfaN5kKz7wxC?=
 =?us-ascii?Q?LFuG3ImsGe67FjGSQllyR2MslsG4aYg36zLrnht8zDdUEmm/uKHDcTmBhihp?=
 =?us-ascii?Q?dMY/6mkuLcrbDhHsOEZAchl4rOR6vuYFLToLMX3wOX4tcBSj/+alO5Cm+ItV?=
 =?us-ascii?Q?WfBYs9UW1g0WWasn15dWvtszyklJOGQZhyE22PSjL9y4KGau6Jq1C2Z2VusK?=
 =?us-ascii?Q?cK2GZwffG3MsVtGc9Z/q3eeHKPvNVA2tNuoWsdtyB+CTvKXXUIODWcSHRyKK?=
 =?us-ascii?Q?hSESRaSUtttiYxHfEe5BERxpXVfeoxAveZWEZ5ikzz3N9SFp7f0DUfhRcmT/?=
 =?us-ascii?Q?iCajXBM8gPKHuiY8B0CZ187VYKlT+hTtPzXApnkxjGOsoW63YyJ6EakSGJ4D?=
 =?us-ascii?Q?djd/LMHN3WoaGQiK3NU/d6C16K+XiEukWPeVfNPSr8QoGkzOBCs6h4B11e4I?=
 =?us-ascii?Q?oRm6137sKG5R0qHuVVyKwwMU/nTk2+nRlymX7uwsGQjAMVCOqAgtIQplpDh6?=
 =?us-ascii?Q?hIEhss3xgPL6ripgipD/EKBYvO7CZwnxbIX22gACuzmqZWAhnq1c0RGTzpgT?=
 =?us-ascii?Q?HC6yu0L1TMT4NhzPcb0TGOFBg6JGOeJqNw5DIPHsHpJV4z2rgEYz7RaKHZgb?=
 =?us-ascii?Q?V681fd8GAIquUiMYs3dKItt6hOB4lP8jpeHyo92uYtUmLcXWOxmky+8dUIOP?=
 =?us-ascii?Q?2af4zJgx8rHkSg5w/N2TNXlXxK4b/w8TfmLOmqKEBuZFgjQhl1ufoS35oFkm?=
 =?us-ascii?Q?y7ywrc11NdFoXvbw+rtmlqhAbTmNnEhMk6s+7QHjIRmu8C9iDRPcyWSiJ4tn?=
 =?us-ascii?Q?89TQAgRbdyCer+mBMHJM5j+AIYIkzqdVsJz2Zj7UjLcjgSZ0mTqUD5I6qmHb?=
 =?us-ascii?Q?aAhY1XUi7wvAyQ9F4nOpoRpUYBdk/VMC9x6Wkd6b6p6w6BXejMmQKgvP1vlZ?=
 =?us-ascii?Q?uOqHShJxKsqApo7MzoZV4NOKkNwIaElO7rFdfOZ5Zk5B2P/I0MU6qFRDEIMc?=
 =?us-ascii?Q?e02i9hCM6dBEitRGZvbHooQJ+UZpomim6Ak2kNOH6K9A9+BhZj1XKLxNn3wp?=
 =?us-ascii?Q?I9QEYdDEM9g1ei/Cq948z4ttbsoCia89yQ5lPw8hM/36ExlErwiUJi7FukMm?=
 =?us-ascii?Q?1QWa1MkYkZPY/YbfAV5Vp2NoF55ssE2XXctAQ5O//RyLFm9Gvh7MCXutdei7?=
 =?us-ascii?Q?5T2QU8ItGC590KnY8t7jqUXnWfpmI3Ibbu0kvdfoMofCQCDY+a+n+W0gXvA4?=
 =?us-ascii?Q?18ovcLW7HR5sWu+IbDtWqtBOeGRDB5oh3mzrmMGLPskOJ321eeP9AukcKK8r?=
 =?us-ascii?Q?L4hSnGLfIZgDF1Le0aAVDWxTcvc6OSlfE11s0nNPZ0sb+rJNPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXcFKlC4p+i/vacFpQXvOCr/trouZB0RzCthagr+FWk6zBdVzJm6ittUTb1y?=
 =?us-ascii?Q?/ziYhjT+w3Vpv/ultA98ahVBLpwo3ZvshfKx2M/zHhSkefOfIDNlveVqe5wh?=
 =?us-ascii?Q?XoQyTQrSPyzk+5ONJ4e6zNlsB6UVpLKwIG4SblSU3ebPFTMaE4CXwy4xqk+C?=
 =?us-ascii?Q?dDZDDlifGP1TsmMb/mARpE8sMv6pbOnLvQ9bcFvCuYo34KZG4KtZE+eI9DxY?=
 =?us-ascii?Q?04Buf52Xo4hhr1GtSmjHlEw579yl9HyQZE3H4etT84UtP/uYyM1GPT29JSxz?=
 =?us-ascii?Q?fsdFZRbL7E9p45rjaznOgDwGKnCgqM6vBSZ7DL/sBLSEjBVs22JP7RKX3tKu?=
 =?us-ascii?Q?whkDnH1u7gczmL3+swSMIZH3CcKHrH8NGNM8n76jFZ0bUnBD2b68V94hLvFv?=
 =?us-ascii?Q?iZLb566bqpFEVzIo+p7lXfYDnCSTb/lx2GGzkiJPYi3YWHqkC9ffYCq42Vng?=
 =?us-ascii?Q?3pZJrgt5OomQa4e4eEipEriMkWhfpRcCcpdV0I5+YRGNPTIb8csbd6nRRsLg?=
 =?us-ascii?Q?VQlOMUBlsQVI0yGrUelZfg94E9WD0FppBcd7Jo64RTQTwNykng+OQWqH+eYe?=
 =?us-ascii?Q?9EgpmxL7gRQGG3AeGhAKpQ0choFvzUJphoe5gWP5FD8FtkOhm79rx//eWsfd?=
 =?us-ascii?Q?LMsO5oEXhKzQbTso3h4A09RPbwPU+Tm1JBJ23t8pz1RiC0usONO+5/RptLZO?=
 =?us-ascii?Q?1oI0DomUBqX9dakxC5iQ80S2kN/blaBmejwEGBKuC3KtrYtTvYvGdw0iB3rm?=
 =?us-ascii?Q?ziBbtpA0rmN+ieTz0sK7EDEC9GrcFO6uuuiz6k9cwnEGlJNiUMEyZE7nk7Jn?=
 =?us-ascii?Q?8iiVY79TyW2GUfzC2yJHMjzC69d9wlYXdOVmkqRC1UwWFYLKvQbV98iMeuJs?=
 =?us-ascii?Q?NG52E7L/6PqUAavrZ/pPW6U9LIHR8fZ4+O/9IOS2+li5OdZBzOWvTEIGJTLc?=
 =?us-ascii?Q?2esvuu//0qRHrRwZZCT9RH8UOxm2WknDbNGtGpbynehWkU8EGkl2VGY9W4vA?=
 =?us-ascii?Q?KtUu8F/6JiAsmUirCfz1zWzHMvMG9cLnBqZrNaOSSiL7lY/qJe/POL5Ika9K?=
 =?us-ascii?Q?scJ7sB2VFtyyI8502oznIABx8a6zt6x8edBPVO+RYLftvTpOl6gmVEgwZoIJ?=
 =?us-ascii?Q?+PjgV3IJHH6Bdlma4h1upWO2ANfCF8CosV93g0iMlxVYQ9V0ZVFdlsmjgOCM?=
 =?us-ascii?Q?7ai2KKzSsjDq7DYimvheiYm43DrytcgZwlpoOJzOAgxAuglfjIUrRx+AuUuD?=
 =?us-ascii?Q?tWb3Y9MEsxMLc6kjgAil/kSiL0iv28Aka8o4s9LxRnVbjqhbJp4SepfUCu/O?=
 =?us-ascii?Q?zKIjfXxBcgNtLEayosEF5Pp0PmGgA6SpoMT0C6eFO54qPlqMnsQm+vTrSha9?=
 =?us-ascii?Q?YxxQ0ilYSCKw5ojWVPItcNse4ctMr9YwB83kUQpfJbIoRboHwv54scvdEW8c?=
 =?us-ascii?Q?0tg/dNuFvpiKW/JD/3l4V36M2CCkR84wmevsW8byLml1CFAiZ1uKxNhE1PlD?=
 =?us-ascii?Q?9TJOARNJEG7mvfiykiv76o3dHwuSaEsaovhYymGnnbFBN5p4N3ab8GicDpjl?=
 =?us-ascii?Q?UDYkRJmDhTHoYt9IIDea4rRFSTHankRnPhquUuDJ24usC9ieIp2Q+goQJJQ6?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950a1675-d536-448d-2b33-08dd153cdea8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:55:33.6169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJR2+IvPumd067ds5mniNMQUojtZ9KIgfsNtdumcDZXo+uQuw7vdQJUV8RNOJPYajFcNxTclQPbz4x7IKEe2sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

The Felix DSA driver presents unique challenges that make the simplistic
ocelot PTP TX timestamping procedure unreliable: any transmitted packet
may be lost in hardware before it ever leaves our local system.

This may happen because there is congestion on the DSA conduit, the
switch CPU port or even user port (Qdiscs like taprio may delay packets
indefinitely by design).

The technical problem is that the kernel, i.e. ocelot_port_add_txtstamp_skb(),
runs out of timestamp IDs eventually, because it never detects that
packets are lost, and keeps the IDs of the lost packets on hold
indefinitely. The manifestation of the issue once the entire timestamp
ID range becomes busy looks like this in dmesg:

mscc_felix 0000:00:00.5: port 0 delivering skb without TX timestamp
mscc_felix 0000:00:00.5: port 1 delivering skb without TX timestamp

At the surface level, we need a timeout timer so that the kernel knows a
timestamp ID is available again. But there is a deeper problem with the
implementation, which is the monotonically increasing ocelot_port->ts_id.
In the presence of packet loss, it will be impossible to detect that and
reuse one of the holes created in the range of free timestamp IDs.

What we actually need is a bitmap of 63 timestamp IDs tracking which one
is available. That is able to use up holes caused by packet loss, but
also gives us a unique opportunity to not implement an actual timer_list
for the timeout timer (very complicated in terms of locking).

We could only declare a timestamp ID stale on demand (lazily), aka when
there's no other timestamp ID available. There are pros and cons to this
approach: the implementation is much more simple than per-packet timers
would be, but most of the stale packets would be quasi-leaked - not
really leaked, but blocked in driver memory, since this algorithm sees
no reason to free them.

An improved technique would be to check for stale timestamp IDs every
time we allocate a new one. Assuming a constant flux of PTP packets,
this avoids stale packets being blocked in memory, but of course,
packets lost at the end of the flux are still blocked until the flux
resumes (nobody left to kick them out).

Since implementing per-packet timers is way too complicated, this should
be good enough.

Testing procedure:

Persistently block traffic class 5 and try to run PTP on it:
$ tc qdisc replace dev swp3 parent root taprio num_tc 8 \
	map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
	base-time 0 sched-entry S 0xdf 100000 flags 0x2
[  126.948141] mscc_felix 0000:00:00.5: port 3 tc 5 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
$ ptp4l -i swp3 -2 -P -m --socket_priority 5 --fault_reset_interval ASAP --logSyncInterval -3
ptp4l[70.351]: port 1 (swp3): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[70.354]: port 0 (/var/run/ptp4l): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[70.358]: port 0 (/var/run/ptp4lro): INITIALIZING to LISTENING on INIT_COMPLETE
[   70.394583] mscc_felix 0000:00:00.5: port 3 timestamp id 0
ptp4l[70.406]: timed out while polling for tx timestamp
ptp4l[70.406]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[70.406]: port 1 (swp3): send peer delay response failed
ptp4l[70.407]: port 1 (swp3): clearing fault immediately
ptp4l[70.952]: port 1 (swp3): new foreign master d858d7.fffe.00ca6d-1
[   71.394858] mscc_felix 0000:00:00.5: port 3 timestamp id 1
ptp4l[71.400]: timed out while polling for tx timestamp
ptp4l[71.400]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[71.401]: port 1 (swp3): send peer delay response failed
ptp4l[71.401]: port 1 (swp3): clearing fault immediately
[   72.393616] mscc_felix 0000:00:00.5: port 3 timestamp id 2
ptp4l[72.401]: timed out while polling for tx timestamp
ptp4l[72.402]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[72.402]: port 1 (swp3): send peer delay response failed
ptp4l[72.402]: port 1 (swp3): clearing fault immediately
ptp4l[72.952]: port 1 (swp3): new foreign master d858d7.fffe.00ca6d-1
[   73.395291] mscc_felix 0000:00:00.5: port 3 timestamp id 3
ptp4l[73.400]: timed out while polling for tx timestamp
ptp4l[73.400]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[73.400]: port 1 (swp3): send peer delay response failed
ptp4l[73.400]: port 1 (swp3): clearing fault immediately
[   74.394282] mscc_felix 0000:00:00.5: port 3 timestamp id 4
ptp4l[74.400]: timed out while polling for tx timestamp
ptp4l[74.401]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[74.401]: port 1 (swp3): send peer delay response failed
ptp4l[74.401]: port 1 (swp3): clearing fault immediately
ptp4l[74.953]: port 1 (swp3): new foreign master d858d7.fffe.00ca6d-1
[   75.396830] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 0 which seems lost
[   75.405760] mscc_felix 0000:00:00.5: port 3 timestamp id 0
ptp4l[75.410]: timed out while polling for tx timestamp
ptp4l[75.411]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[75.411]: port 1 (swp3): send peer delay response failed
ptp4l[75.411]: port 1 (swp3): clearing fault immediately
(...)

Remove the blocking condition and see that the port recovers:
$ same tc command as above, but use "sched-entry S 0xff" instead
$ same ptp4l command as above
ptp4l[99.489]: port 1 (swp3): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[99.490]: port 0 (/var/run/ptp4l): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[99.492]: port 0 (/var/run/ptp4lro): INITIALIZING to LISTENING on INIT_COMPLETE
[  100.403768] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 0 which seems lost
[  100.412545] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 1 which seems lost
[  100.421283] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 2 which seems lost
[  100.430015] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 3 which seems lost
[  100.438744] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 4 which seems lost
[  100.447470] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  100.505919] mscc_felix 0000:00:00.5: port 3 timestamp id 0
ptp4l[100.963]: port 1 (swp3): new foreign master d858d7.fffe.00ca6d-1
[  101.405077] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  101.507953] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  102.405405] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  102.509391] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  103.406003] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  103.510011] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  104.405601] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  104.510624] mscc_felix 0000:00:00.5: port 3 timestamp id 0
ptp4l[104.965]: selected best master clock d858d7.fffe.00ca6d
ptp4l[104.966]: port 1 (swp3): assuming the grand master role
ptp4l[104.967]: port 1 (swp3): LISTENING to GRAND_MASTER on RS_GRAND_MASTER
[  105.106201] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.232420] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.359001] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.405500] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.485356] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.511220] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.610938] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.737237] mscc_felix 0000:00:00.5: port 3 timestamp id 0
(...)

Notice that in this new usage pattern, a non-congested port should
basically use timestamp ID 0 all the time, progressing to higher numbers
only if there are unacknowledged timestamps in flight. Compare this to
the old usage, where the timestamp ID used to monotonically increase
modulo OCELOT_MAX_PTP_ID.

In terms of implementation, this simplifies the bookkeeping of the
ocelot_port :: ts_id and ptp_skbs_in_flight. Since we need to traverse
the list of two-step timestampable skbs for each new packet anyway, the
information can already be computed and does not need to be stored.
Also, ocelot_port->tx_skbs is always accessed under the switch-wide
ocelot->ts_id_lock IRQ-unsafe spinlock, so we don't need the skb queue's
lock and can use the unlocked primitives safely.

This problem was actually detected using the tc-taprio offload, and is
causing trouble in TSN scenarios, which Felix (NXP LS1028A / VSC9959)
supports but Ocelot (VSC7514) does not. Thus, I've selected the commit
to blame as the one adding initial timestamping support for the Felix
switch.

Fixes: c0bcf537667c ("net: dsa: ocelot: add hardware timestamping support for Felix")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Daniel Machon <daniel.machon@microchip.com>

The problem space seems to be very, very similar in
lan969x_ptp_irq_handler() and sparx5_ptp_irq_handler().

 drivers/net/ethernet/mscc/ocelot_ptp.c | 134 +++++++++++++++----------
 include/linux/dsa/ocelot.h             |   1 +
 include/soc/mscc/ocelot.h              |   2 -
 3 files changed, 80 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index d732f99e6391..7eb01d1e1ecd 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -14,6 +14,8 @@
 #include <soc/mscc/ocelot.h>
 #include "ocelot.h"
 
+#define OCELOT_PTP_TX_TSTAMP_TIMEOUT		(5 * HZ)
+
 int ocelot_ptp_gettime64(struct ptp_clock_info *ptp, struct timespec64 *ts)
 {
 	struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
@@ -603,34 +605,88 @@ int ocelot_get_ts_info(struct ocelot *ocelot, int port,
 }
 EXPORT_SYMBOL(ocelot_get_ts_info);
 
-static int ocelot_port_add_txtstamp_skb(struct ocelot *ocelot, int port,
+static struct sk_buff *ocelot_port_dequeue_ptp_tx_skb(struct ocelot *ocelot,
+						      int port, u8 ts_id,
+						      u32 seqid)
+{
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
+	struct ptp_header *hdr;
+
+	spin_lock(&ocelot->ts_id_lock);
+
+	skb_queue_walk_safe(&ocelot_port->tx_skbs, skb, skb_tmp) {
+		if (OCELOT_SKB_CB(skb)->ts_id != ts_id)
+			continue;
+
+		/* Check that the timestamp ID is for the expected PTP
+		 * sequenceId. We don't have to test ptp_parse_header() against
+		 * NULL, because we've pre-validated the packet's ptp_class.
+		 */
+		hdr = ptp_parse_header(skb, OCELOT_SKB_CB(skb)->ptp_class);
+		if (seqid != ntohs(hdr->sequence_id))
+			continue;
+
+		__skb_unlink(skb, &ocelot_port->tx_skbs);
+		ocelot->ptp_skbs_in_flight--;
+		skb_match = skb;
+		break;
+	}
+
+	spin_unlock(&ocelot->ts_id_lock);
+
+	return skb_match;
+}
+
+static int ocelot_port_queue_ptp_tx_skb(struct ocelot *ocelot, int port,
 					struct sk_buff *clone)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	DECLARE_BITMAP(ts_id_in_flight, OCELOT_MAX_PTP_ID);
+	struct sk_buff *skb, *skb_tmp;
+	unsigned long n;
 
 	spin_lock(&ocelot->ts_id_lock);
 
-	if (ocelot_port->ptp_skbs_in_flight == OCELOT_MAX_PTP_ID ||
-	    ocelot->ptp_skbs_in_flight == OCELOT_PTP_FIFO_SIZE) {
+	/* To get a better chance of acquiring a timestamp ID, first flush the
+	 * stale packets still waiting in the TX timestamping queue. They are
+	 * probably lost.
+	 */
+	skb_queue_walk_safe(&ocelot_port->tx_skbs, skb, skb_tmp) {
+		if (time_before(OCELOT_SKB_CB(skb)->ptp_tx_time +
+				OCELOT_PTP_TX_TSTAMP_TIMEOUT, jiffies)) {
+			dev_warn_ratelimited(ocelot->dev,
+					     "port %d invalidating stale timestamp ID %u which seems lost\n",
+					     port, OCELOT_SKB_CB(skb)->ts_id);
+			__skb_unlink(skb, &ocelot_port->tx_skbs);
+			kfree_skb(skb);
+			ocelot->ptp_skbs_in_flight--;
+		} else {
+			__set_bit(OCELOT_SKB_CB(skb)->ts_id, ts_id_in_flight);
+		}
+	}
+
+	if (ocelot->ptp_skbs_in_flight == OCELOT_PTP_FIFO_SIZE) {
 		spin_unlock(&ocelot->ts_id_lock);
 		return -EBUSY;
 	}
 
-	skb_shinfo(clone)->tx_flags |= SKBTX_IN_PROGRESS;
-	/* Store timestamp ID in OCELOT_SKB_CB(clone)->ts_id */
-	OCELOT_SKB_CB(clone)->ts_id = ocelot_port->ts_id;
-
-	ocelot_port->ts_id++;
-	if (ocelot_port->ts_id == OCELOT_MAX_PTP_ID)
-		ocelot_port->ts_id = 0;
+	n = find_first_zero_bit(ts_id_in_flight, OCELOT_MAX_PTP_ID);
+	if (n == OCELOT_MAX_PTP_ID) {
+		spin_unlock(&ocelot->ts_id_lock);
+		return -EBUSY;
+	}
 
-	ocelot_port->ptp_skbs_in_flight++;
+	/* Found an available timestamp ID, use it */
+	OCELOT_SKB_CB(clone)->ts_id = n;
+	OCELOT_SKB_CB(clone)->ptp_tx_time = jiffies;
 	ocelot->ptp_skbs_in_flight++;
-
-	skb_queue_tail(&ocelot_port->tx_skbs, clone);
+	__skb_queue_tail(&ocelot_port->tx_skbs, clone);
 
 	spin_unlock(&ocelot->ts_id_lock);
 
+	dev_dbg_ratelimited(ocelot->dev, "port %d timestamp id %lu\n", port, n);
+
 	return 0;
 }
 
@@ -686,12 +742,14 @@ int ocelot_port_txtstamp_request(struct ocelot *ocelot, int port,
 		if (!(*clone))
 			return -ENOMEM;
 
-		err = ocelot_port_add_txtstamp_skb(ocelot, port, *clone);
+		/* Store timestamp ID in OCELOT_SKB_CB(clone)->ts_id */
+		err = ocelot_port_queue_ptp_tx_skb(ocelot, port, *clone);
 		if (err) {
 			kfree_skb(*clone);
 			return err;
 		}
 
+		skb_shinfo(*clone)->tx_flags |= SKBTX_IN_PROGRESS;
 		OCELOT_SKB_CB(skb)->ptp_cmd = ptp_cmd;
 		OCELOT_SKB_CB(*clone)->ptp_class = ptp_class;
 	}
@@ -727,26 +785,14 @@ static void ocelot_get_hwtimestamp(struct ocelot *ocelot,
 	spin_unlock_irqrestore(&ocelot->ptp_clock_lock, flags);
 }
 
-static bool ocelot_validate_ptp_skb(struct sk_buff *clone, u16 seqid)
-{
-	struct ptp_header *hdr;
-
-	hdr = ptp_parse_header(clone, OCELOT_SKB_CB(clone)->ptp_class);
-	if (WARN_ON(!hdr))
-		return false;
-
-	return seqid == ntohs(hdr->sequence_id);
-}
-
 void ocelot_get_txtstamp(struct ocelot *ocelot)
 {
 	int budget = OCELOT_PTP_QUEUE_SZ;
 
 	while (budget--) {
-		struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
 		struct skb_shared_hwtstamps shhwtstamps;
 		u32 val, id, seqid, txport;
-		struct ocelot_port *port;
+		struct sk_buff *skb_match;
 		struct timespec64 ts;
 
 		val = ocelot_read(ocelot, SYS_PTP_STATUS);
@@ -762,36 +808,14 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 		txport = SYS_PTP_STATUS_PTP_MESS_TXPORT_X(val);
 		seqid = SYS_PTP_STATUS_PTP_MESS_SEQ_ID(val);
 
-		port = ocelot->ports[txport];
-
-		spin_lock(&ocelot->ts_id_lock);
-		port->ptp_skbs_in_flight--;
-		ocelot->ptp_skbs_in_flight--;
-		spin_unlock(&ocelot->ts_id_lock);
-
 		/* Retrieve its associated skb */
-try_again:
-		spin_lock(&port->tx_skbs.lock);
-
-		skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
-			if (OCELOT_SKB_CB(skb)->ts_id != id)
-				continue;
-			__skb_unlink(skb, &port->tx_skbs);
-			skb_match = skb;
-			break;
-		}
-
-		spin_unlock(&port->tx_skbs.lock);
-
-		if (WARN_ON(!skb_match))
+		skb_match = ocelot_port_dequeue_ptp_tx_skb(ocelot, txport, id,
+							   seqid);
+		if (!skb_match) {
+			dev_warn_ratelimited(ocelot->dev,
+					     "port %d received TX timestamp (seqid %d, ts id %u) for packet previously declared stale\n",
+					     txport, seqid, id);
 			goto next_ts;
-
-		if (!ocelot_validate_ptp_skb(skb_match, seqid)) {
-			dev_err_ratelimited(ocelot->dev,
-					    "port %d received stale TX timestamp for seqid %d, discarding\n",
-					    txport, seqid);
-			kfree_skb(skb);
-			goto try_again;
 		}
 
 		/* Get the h/w timestamp */
diff --git a/include/linux/dsa/ocelot.h b/include/linux/dsa/ocelot.h
index 6fbfbde68a37..620a3260fc08 100644
--- a/include/linux/dsa/ocelot.h
+++ b/include/linux/dsa/ocelot.h
@@ -15,6 +15,7 @@
 struct ocelot_skb_cb {
 	struct sk_buff *clone;
 	unsigned int ptp_class; /* valid only for clones */
+	unsigned long ptp_tx_time; /* valid only for clones */
 	u32 tstamp_lo;
 	u8 ptp_cmd;
 	u8 ts_id;
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 462c653e1017..2db9ae0575b6 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -778,7 +778,6 @@ struct ocelot_port {
 
 	phy_interface_t			phy_mode;
 
-	unsigned int			ptp_skbs_in_flight;
 	struct sk_buff_head		tx_skbs;
 
 	unsigned int			trap_proto;
@@ -786,7 +785,6 @@ struct ocelot_port {
 	u16				mrp_ring_id;
 
 	u8				ptp_cmd;
-	u8				ts_id;
 
 	u8				index;
 
-- 
2.43.0


