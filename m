Return-Path: <netdev+bounces-219613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1B6B42568
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450AC58675C
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07AD2836B4;
	Wed,  3 Sep 2025 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UvGcHZ55"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971723C50A;
	Wed,  3 Sep 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913052; cv=fail; b=iev17IPKsE2OAcLQopK15m/MTZnk0pr1GMVsU4dsWMXTpFhlH+UtEnQOsp/cn5k2clCeKJWG4DAvE4G330ILNJVfMgqKbn9/qdKX8TSgKVuHQoaNz4hORq29q619zI+HUYzr9hSUIx81+MIq97BztJxVAQ0yLFS5bz+fejwps5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913052; c=relaxed/simple;
	bh=9s4yWBNJ1YZsLJOfFAsxvYo3EW8DDXEak6lu4roKkhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HxrIB6X02LwoK4b5KzGBnHWnbKrbpxo3sz8K1Ro6KfBBohbWJJnfdISxmOrtuVLLKwtwA1YaAYT7aPm83yOc7uOwUtp90ywTPhva5X72akaGRq8l2DqWRx8dx7EzDLrc+WQeeoo5+IkYJMmVszgEfRiGNBUQTolNvMy8JM9N/Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UvGcHZ55; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3dgOsOMjC7XpcymiDmNvSUTnuNdvBIvKU9Q5WJ3USsTIkjlIlamv71eNzvx6w6m8ROajlqt5xSG3+fWY3kig8JzfyUWudmjivMW9ZCrYmihrCrBFk1WtvWJX6MXmaNpXhkc0EG0W7fymbe1BwjW531Ud3D+TBwIuxPn5wwVAMEDedkNNFJBcVYdI30u0Lt4/GUKyUxO/PjDXnTs00BDXONwMFg/scCBwqH1Ub0JyXLx0irAMunj9zeZCMUdXKc2xG2TRRpCKvwLgKqboDWnJ6r0UOF8Sa7AXSGzY4qb1G9GZ81XYkIfcS2pJqFRa01Uf4nJMKj55abuhd/vpzhONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URAi3rwwekwRPzwFaclvhZHMjY2v9iXJqu89TvUVxRI=;
 b=vVK27F8u0Z65fErs66JzCxXqaSI2wK4oLYeTtqtk4XxyMB6jZQe9wTNq0B1TS9Ky2zAaHRS9K36F3yNLY81vUkhD9ivYFy1CXmYzHuGvW3mdeYFOWlc5OJfEzJ87aTy1B6TDyEOvimGVsUNzdgm/ghqXVv8X0ymcoLioU6CWUdQ/AzGE/ZJlpaYFiM3BsNrJ7vkhhze6qOOMeplm7tKqgbVIbvEL5LFDZVURG3K8jeChMCxSjTiiD8IV5ISaqBEvPcH81PRri09Y1rNhJdWMWsGvP60xgWmHLYE2bZ76QuneNgPbVxDcQRs9IIEliyJbENleLcuV4Aw/PfjKNHbuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URAi3rwwekwRPzwFaclvhZHMjY2v9iXJqu89TvUVxRI=;
 b=UvGcHZ55j2aIg+XQm7T7pbdAbc5x5s+hqTUexbWJU3TVJPhRpkZNqS0DIKGJZ7t7bNyz7w++4mqJAilHPq7SckDUqHebOpJxgeRRpo4yClztB9Hc2+eqF4t/ZM4I/Xl5MRg28kIdi58/R4TOF+CPH4+ZUCYvTaZdQWjIVkKM6mUNl7SUagi2kbJPH3q7kgm08X+0PCmxoVYH4b0NOMFRlIqZvIlZgVIhbkztp/LsAjRRumQbBZbPpynWmvqTP9Tj3GMmHJyUda777u99i4ZSNyvpDqReDvg7kJiKVuRjnJOrg6sXYJ+katTd8ntjIjh+dqh0C/vDnoOL3PGfF1PWVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB11484.eurprd04.prod.outlook.com (2603:10a6:800:2c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 15:24:07 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 15:24:07 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 2/2] net: phy: transfer phy_config_inband() locking responsibility to phylink
Date: Wed,  3 Sep 2025 18:23:48 +0300
Message-Id: <20250903152348.2998651-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903152348.2998651-1-vladimir.oltean@nxp.com>
References: <20250903152348.2998651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0016.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::29) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB11484:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d09e81c-69d1-4e85-d8c6-08ddeafdec7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VM+O+R6cXzD0cZE0oUeR+ucE6d397xZV9l7QZJKXKMwCan67+QJo7vPvldZN?=
 =?us-ascii?Q?zmloYKs5PxZFLKyPvrKLb/h+WSo6s56JoFDzGSJlezlLmc3bpAcw3hGoTPbQ?=
 =?us-ascii?Q?gWhKiqiP5es8ts/yXx5nMWchBEabc46FrS97JxHvM+bchDBAOqfWjYINML5u?=
 =?us-ascii?Q?8riXBYp1aUu5Q0dFHzc5LM3vSNtczn+eEQ38UC37a3Rdlh9+8PgEyC8B8/43?=
 =?us-ascii?Q?6UMQ0blt0YGbF/OM3ct2YoDNmO/P/hwto8loHRHy7cBQi3mxdRkj7JjrqYsR?=
 =?us-ascii?Q?5BOauZ1xoYJylDDSbsixP00ulNp0LiM4GPIrnLaRkqm2xxcBTjLPvLHt3hi4?=
 =?us-ascii?Q?PPtp4zfMjv8BmCVlsS43rpiyOVrb3ERDjDahjic24/ClP6vLF4JI63vUFWyP?=
 =?us-ascii?Q?G51OBbMU9IUXyMO698QIDrPqYGS/YuxoK4ag6AHXVImGutGZRF0GZ2VhKA6K?=
 =?us-ascii?Q?QvO80z8Mok8Pf/SkNgueC3B6MYXtDP4ojt8dSnOU+QzfzZhIFyS+Sb+tGREe?=
 =?us-ascii?Q?kzWchwXKhSbBUifg1h4AgSFjMIQLjMxEg0cskKre5ld72Mk3uISW7pXQeC1Y?=
 =?us-ascii?Q?uK5qaaokj8Ybis4Y6QPhZMD7TNR0kaVRqcw9j2omUzHoq67e4w7WgK1+4aBK?=
 =?us-ascii?Q?6/x1geWe7Hz4/skP02fnyMuDro8qCSLjvocp7KSVK/yVsKZFLVwfCooXXSfa?=
 =?us-ascii?Q?PfHnGZYJVbkBWC36rrl1cDk1XCDLbOd5992FW4ZyAqjtzu0c6geEbBpoA5cb?=
 =?us-ascii?Q?yE9DZyUumLvM1rhrP3r3XcL7YiIowu+T+F+WbPH8Qtdk50E1i+QAr4w15nai?=
 =?us-ascii?Q?w0JMgOiyTKy+qovCxATd3o+1sxvsjemqfHJdFckw4pEQzUs2THpqy6Nf2ZLJ?=
 =?us-ascii?Q?tgkijSj6lC9VPc8IFcKz65PtUui5t1u69+Epq0FWjuH48UmctaLx0yn5D2D0?=
 =?us-ascii?Q?WnpKk6Z62qhZwF1HRtYvJouye1mC57uJf1ogTOt6HXYbmbvPPy1iGONCmY4k?=
 =?us-ascii?Q?M/i61gxomwnW5U/Pf1TX5HGOm9//B4IJ1VUyoMPfgkOxcM+qzif/GiW3//d0?=
 =?us-ascii?Q?vq5a5Sq6yTAgEBq2BnPlZeGnrSgcN3by1Qis5Bne5yPt6sIPkbfivVV8bpX4?=
 =?us-ascii?Q?hosNjeJUkIqv6Vo9QFAaOJrmhW1QV2R42yXdLMuwpSP5bXWSkFbIB8iGz6ZT?=
 =?us-ascii?Q?lusI7N7DbFiCUUCGM4AQPZn8EyGuwbSftbIp0gurreluTGSY3wSQwY4o4Inw?=
 =?us-ascii?Q?QX6lUMgghyQXo4PfOjyNHHTekI8TQlwcWwYkG7+zbcJr6ChLfXWCVBNI7kSI?=
 =?us-ascii?Q?kEBDUsRg4R17UcV6ltTYFLnculw7FKljE0srcGjA/S0AYBr/34Jgi/sKhBZs?=
 =?us-ascii?Q?6pWLIjs2OqjvnYoKaXGkmk+h2yg3+eSXuZJpi5tD1h3em4TTj6c65bqDjJxa?=
 =?us-ascii?Q?9rb6t1Wr4Y0DFQcEGhAMCaD1/ZeZ6gB2GO/ObZJas3V68V+7G07NvxCZ958y?=
 =?us-ascii?Q?yX1KpkRItgpLwWQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CqgQk5cRRSZ3Wu09P8k10HtCeFJTK6IUcxpczf5SqoflYdKpPEaULyDm/llk?=
 =?us-ascii?Q?rIxq+zhOiZp4vLtVjczW2S4y3uFwqmhcMVvfEubr2wTYtXzNPePWXmUuh8wo?=
 =?us-ascii?Q?ZQ2Xeg3Bn7vbwGoKXulYAOxvzVG3Kx7qnUZbkBUUxymjnePMgYM1OOR5TE0g?=
 =?us-ascii?Q?pYASLI8mEWEIG1QGtQgMPooJwhvSkt91JwJlvpVQ/vqZjI5MJ66xfKTum8o2?=
 =?us-ascii?Q?P3+h8hkCr4TyPEKTc1xalSKdZ5RHqBzGGDwfYIZCtYOr4MfHtMSF2Zu8u6yY?=
 =?us-ascii?Q?VbzDSYJmsJN9WnqK3VuXvkoB6EDYVJg7vVFTYeV1JwRWHBVA58oLTLLeGVA4?=
 =?us-ascii?Q?K1ZlI1Ae3xm+npJTPyN8IdnGoTEEOoKEGWyFwgnm7ZOvnZxZ1iOMkSSjuapB?=
 =?us-ascii?Q?po3U6n7IRAS7kR4mpiFEnMs86GV7bAqjrh+SO7tB/G/rRtiafv2ZXu8B/TjA?=
 =?us-ascii?Q?s8jeQniHAan91P95YlTjmlUGDij4id3M0o4zp9rQ/cRPOSpngUwcV6s4Ay55?=
 =?us-ascii?Q?ilWpir8oJ9ZQPaF+vo/7Fo8iirouWNCeNE4tSfoXhsl+jN8Yv2i8BdHLMFfr?=
 =?us-ascii?Q?y57xHeRTkZB2Kn1/zqq7rGn/sHdtRe4utfiaPoO3/2+sG+tXQZRkMZSR5GRC?=
 =?us-ascii?Q?O5SxJLy1Kk23r62JHcoUj4inAZym3ojX970uFGGhU8pcxzrzGZga6jeaqXxZ?=
 =?us-ascii?Q?qHOdhNQqv9gae+OdYdQhVJUxexdb/hOqSMeHe/BAMssliowjxoRZRrKHdQ2a?=
 =?us-ascii?Q?X0nZOtRy8d8v567YJ2/nMcYhNFn3xy3VzHLvtc3YoBmg5nkpnwo7/EoxxDZq?=
 =?us-ascii?Q?6LxZ6UUW4SihvU5s/1uCEA4d40BS9+W2+TedCiak/S0AzDa2E1G14YNk6x2c?=
 =?us-ascii?Q?WQQzaaqhv21mb2alAmTHRJjDmeIdgmN7RK+knS9JQVeGBHZUgzbhJHmvySaB?=
 =?us-ascii?Q?hLZrot9+0AVnqQrQm2HGVXzBCesCWzBEhtF2lpMhDQ8QMIWROWm0Mys0dr8d?=
 =?us-ascii?Q?XjN5CgyjSXcgTuVdsZU/9goQUJ5LBpo7JAyYBuYWI5puv3U8rZP7ECVsHd5c?=
 =?us-ascii?Q?jepsqXJAWJRTXkMyrimzW5j3GM63u6pA12b0x6qcBQiWubT3bsU0K5w0Sz/X?=
 =?us-ascii?Q?OcK7s9YYyb8uhg72B6J8zXtrNeiCA28Q3BkxoIJ1fRzJEL1H0owDy3ypXEeL?=
 =?us-ascii?Q?iRd8BunJ/Gm4ZZWVD9bEdUyVjLZZTQ/uXIlulQ51x3NEU3DXHwbpJdpdrAWv?=
 =?us-ascii?Q?hvUeTMCpjy/cRbR8nGGvumKnN144JjPiJHdXEWdWiahsC5irms71sFWJ+miS?=
 =?us-ascii?Q?NiI1am4b5qZKDng/FJI3HWhM0ITd6AkltVTa0QnQbTSxS3YR4fPAQW7jgCDW?=
 =?us-ascii?Q?NxkTtDHLgJO8YJLdO6BByb8z0S83gS5D3Xj9wXo7a9ZcGWeBc+dXaKdW1cDf?=
 =?us-ascii?Q?/8OZ/ICD2+wGrs9qBs0Oj0UZ5MlADQPz5nrIP/TtLk/QaWIQs7ZS1inO8s34?=
 =?us-ascii?Q?OQQPEhCyvFz/JjdWXXjUY/FKFEZpnCGV9QWFDXb9t/U9+1Z81GbAevkdC0OG?=
 =?us-ascii?Q?VC7YodutOhuXAZAe5TApJkFTH/XtOiYG2k7kdrL2XqG6CR7V+LVcZfivEeYn?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d09e81c-69d1-4e85-d8c6-08ddeafdec7d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:24:07.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U62BWUoantPkDYSlryYjXNgzQH5JtgX6pONAKZGWD3rK4zQ6AaLhoWahQCXiQY2I7bMjlnLb8VVDDSCIPB3NcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11484

Problem description
===================

Lockdep reports a possible circular locking dependency (AB/BA) between
&pl->state_mutex and &phy->lock, as follows.

phylink_resolve() // acquires &pl->state_mutex
-> phylink_major_config()
   -> phy_config_inband() // acquires &pl->phydev->lock

whereas all the other call sites where &pl->state_mutex and
&pl->phydev->lock have the locking scheme reversed. Everywhere else,
&pl->phydev->lock is acquired at the top level, and &pl->state_mutex at
the lower level. A clear example is phylink_bringup_phy().

The outlier is the newly introduced phy_config_inband() and the existing
lock order is the correct one. To understand why it cannot be the other
way around, it is sufficient to consider phylink_phy_change(), phylink's
callback from the PHY device's phy->phy_link_change() virtual method,
invoked by the PHY state machine.

phy_link_up() and phy_link_down(), the (indirect) callers of
phylink_phy_change(), are called with &phydev->lock acquired.
Then phylink_phy_change() acquires its own &pl->state_mutex, to
serialize changes made to its pl->phy_state and pl->link_config.
So all other instances of &pl->state_mutex and &phydev->lock must be
consistent with this order.

Problem impact
==============

I think the kernel runs a serious deadlock risk if an existing
phylink_resolve() thread, which results in a phy_config_inband() call,
is concurrent with a phy_link_up() or phy_link_down() call, which will
deadlock on &pl->state_mutex in phylink_phy_change(). Practically
speaking, the impact may be limited by the slow speed of the medium
auto-negotiation protocol, which makes it unlikely for the current state
to still be unresolved when a new one is detected, but I think the
problem is there. Nonetheless, the problem was discovered using lockdep.

Proposed solution
=================

Practically speaking, the phy_config_inband() requirement of having
phydev->lock acquired must transfer to the caller (phylink is the only
caller). There, it must bubble up until immediately before
&pl->state_mutex is acquired, for the cases where that takes place.

Solution details, considerations, notes
=======================================

This is the phy_config_inband() call graph:

                          sfp_upstream_ops :: connect_phy()
                          |
                          v
                          phylink_sfp_connect_phy()
                          |
                          v
                          phylink_sfp_config_phy()
                          |
                          |   sfp_upstream_ops :: module_insert()
                          |   |
                          |   v
                          |   phylink_sfp_module_insert()
                          |   |
                          |   |   sfp_upstream_ops :: module_start()
                          |   |   |
                          |   |   v
                          |   |   phylink_sfp_module_start()
                          |   |   |
                          |   v   v
                          |   phylink_sfp_config_optical()
 phylink_start()          |   |
   |   phylink_resume()   v   v
   |   |  phylink_sfp_set_config()
   |   |  |
   v   v  v
 phylink_mac_initial_config()
   |   phylink_resolve()
   |   |  phylink_ethtool_ksettings_set()
   v   v  v
   phylink_major_config()
            |
            v
    phy_config_inband()

phylink_major_config() caller #1, phylink_mac_initial_config(), does not
acquire &pl->state_mutex nor do its callers. It must acquire
&pl->phydev->lock prior to calling phylink_major_config().

phylink_major_config() caller #2, phylink_resolve() acquires
&pl->state_mutex, thus also needs to acquire &pl->phydev->lock.

phylink_major_config() caller #3, phylink_ethtool_ksettings_set(), is
completely uninteresting, because it only calls phylink_major_config()
if pl->phydev is NULL (otherwise it calls phy_ethtool_ksettings_set()).
We need to change nothing there.

Other solutions
===============

The lock inversion between &pl->state_mutex and &pl->phydev->lock has
occurred at least once before, as seen in commit c718af2d00a3 ("net:
phylink: fix ethtool -A with attached PHYs"). The solution there was to
simply not call phy_set_asym_pause() under the &pl->state_mutex. That
cannot be extended to our case though, where the phy_config_inband()
call is much deeper inside the &pl->state_mutex section.

Fixes: 5fd0f1a02e75 ("net: phylink: add negotiation of in-band capabilities")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- rebase over new patch which introduces pl->phy_lock
- add "Other solutions" section

v1 at:
https://lore.kernel.org/netdev/20250902134141.2430896-1-vladimir.oltean@nxp.com/

 drivers/net/phy/phy.c     | 12 ++++--------
 drivers/net/phy/phylink.c | 13 +++++++++++--
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 13df28445f02..c02da57a4da5 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1065,23 +1065,19 @@ EXPORT_SYMBOL_GPL(phy_inband_caps);
  */
 int phy_config_inband(struct phy_device *phydev, unsigned int modes)
 {
-	int err;
+	lockdep_assert_held(&phydev->lock);
 
 	if (!!(modes & LINK_INBAND_DISABLE) +
 	    !!(modes & LINK_INBAND_ENABLE) +
 	    !!(modes & LINK_INBAND_BYPASS) != 1)
 		return -EINVAL;
 
-	mutex_lock(&phydev->lock);
 	if (!phydev->drv)
-		err = -EIO;
+		return -EIO;
 	else if (!phydev->drv->config_inband)
-		err = -EOPNOTSUPP;
-	else
-		err = phydev->drv->config_inband(phydev, modes);
-	mutex_unlock(&phydev->lock);
+		return -EOPNOTSUPP;
 
-	return err;
+	return phydev->drv->config_inband(phydev, modes);
 }
 EXPORT_SYMBOL(phy_config_inband);
 
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 5bb0e1860a75..a3559f6fcd02 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1425,6 +1425,7 @@ static void phylink_get_fixed_state(struct phylink *pl,
 static void phylink_mac_initial_config(struct phylink *pl, bool force_restart)
 {
 	struct phylink_link_state link_state;
+	struct phy_device *phy = pl->phydev;
 
 	switch (pl->req_link_an_mode) {
 	case MLO_AN_PHY:
@@ -1448,7 +1449,11 @@ static void phylink_mac_initial_config(struct phylink *pl, bool force_restart)
 	link_state.link = false;
 
 	phylink_apply_manual_flow(pl, &link_state);
+	if (phy)
+		mutex_lock(&phy->lock);
 	phylink_major_config(pl, force_restart, &link_state);
+	if (phy)
+		mutex_unlock(&phy->lock);
 }
 
 static const char *phylink_pause_to_str(int pause)
@@ -1589,6 +1594,8 @@ static void phylink_resolve(struct work_struct *w)
 
 	mutex_lock(&pl->phy_lock);
 	phy = pl->phydev;
+	if (phy)
+		mutex_lock(&phy->lock);
 	mutex_lock(&pl->state_mutex);
 	cur_link_state = phylink_link_is_up(pl);
 
@@ -1622,11 +1629,11 @@ static void phylink_resolve(struct work_struct *w)
 		/* If we have a phy, the "up" state is the union of both the
 		 * PHY and the MAC
 		 */
-		if (pl->phydev)
+		if (phy)
 			link_state.link &= pl->phy_state.link;
 
 		/* Only update if the PHY link is up */
-		if (pl->phydev && pl->phy_state.link) {
+		if (phy && pl->phy_state.link) {
 			/* If the interface has changed, force a link down
 			 * event if the link isn't already down, and re-resolve.
 			 */
@@ -1690,6 +1697,8 @@ static void phylink_resolve(struct work_struct *w)
 		queue_work(system_power_efficient_wq, &pl->resolve);
 	}
 	mutex_unlock(&pl->state_mutex);
+	if (phy)
+		mutex_unlock(&phy->lock);
 	mutex_unlock(&pl->phy_lock);
 }
 
-- 
2.34.1


