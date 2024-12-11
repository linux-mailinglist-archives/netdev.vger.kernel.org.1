Return-Path: <netdev+bounces-151165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7A89ED357
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 18:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A366F281EB5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 17:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB131FECAF;
	Wed, 11 Dec 2024 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QuJoGQtF"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEB91FE479
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937957; cv=fail; b=hgspvMH/VSJog8jEt4tGdDHzUcsUNhuxbJMTfG4girz9g8zTM11guQnr3TPdsy6CLhWkkC2jXHrabtTeIM4olOngc87w9m6YtjSqzw9qSc0Breu/HwHG9Zra8VyLifs70S060iB8hwmBbWutNag3xVjXI7cfg/ePU1t631bP65A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937957; c=relaxed/simple;
	bh=HvhaNYJqGh+i122Yl8uDhQIl9b24h4417ZtUnXpBHO0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rZSRIep+c2clNTv7XYJ3sTt+RWlme3rwoh5jzuBLYvYX87EBcUcyYFNlQhCI2EWk02Wtjn6SJTCVJSPeDi3LjMGTc3DYzlvD3s/IajHJTezn+uyTqWdItbOYntMsNMSfmx563+6Oty6NNsBgWdcQR6aoigvKBl0yx+sJrt/ZZII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QuJoGQtF; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBoifRuzekz6WPunnn/SSGJUVcUqZgLl1ALC8KmUaUVoWjA5dLjVSWiyNqg35Z8+ctacAq8MW/EQpurDzkNQFILBFnrCLR+KE50Uqxoq8rJOnj2g9u6CirWE3MopN7VroVWCQm6OHiBypiM/Wikqo6mgGiAL5pkLjPQ5FZ59XP7JQ90SeUyNLC6eHRyLe6BraBPb+3ep0ha8HDNHAoyVNNwvoI/YiAgAxcgtVy/VJadUzFOZ5ByOuklZiLpglQJ6OfDjD8PEOr9Fq4g8ahZnka1ErjL6nMrI3QseUuhfW6WevCQTrqOJGg09CRW/mYRBNQpbaBElWx7p1ePUOz0UNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gUcVwlWQ8sXlz69ZWxT9HAQsgIbKlWyYK8o68eaBd8=;
 b=pujEbZ2X0jQAt6MEzD0I26vP+tGXTW3t/3dj3SbjBE4E3FmPr0sj37ZmSo4Cr7elKvoIh7EEwFx9xp8AML0ebjFqPu23P6VaTMFIHmvIVLTJDWjLnyXPyIAvr1v5BJ2zWw80vrmTq+Drv9fle0ZUENOV7G9SCZW1yX0L5K+CdxtVk1ZFnGH+16XOkFgY7/FN0m8hH5QETwcUazkSiAmQzJfcFO/0/nGgDRg2JmdHsb0nnxAO89B4so6QMDW8g2iAXmrpquTG9snf72kg7QaCW8GgtwHJYNXFKdLxgDo7VTBWCncPd7i65rV1uTU+Rl5niIoSFfOV46/acwja8ZOHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gUcVwlWQ8sXlz69ZWxT9HAQsgIbKlWyYK8o68eaBd8=;
 b=QuJoGQtFmtsZqQS/LO9cUwjzQ83XAa3j4wb7PRchL0rHeZM48iuzP/J+QpeGjp7HwmTYpKiOEJ66itC1cOfrY1qZjE6AZDgUZTTZw51igJEokEbtQ8RCJqVNAQttfM3Mjz9DCWpZ0nEXCm8ZMb9sZgewyXbCasZn/vozclpaTCDu4q/vTDdZl3GuFbNu2/V13BiY8+1rYtNOthtKQ4HVwaAfeb62YIGy9diJWEmZfBll8BNPynacSAL561gYh9XNtaP9n7YjF6Zlak/4kntFrnLOy/bw7lMNQBV7rKfcT78LENorHUIMeeiApCiBjMuELTGHRv9SxWmYaR/FAaeJ+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10789.eurprd04.prod.outlook.com (2603:10a6:10:588::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 17:25:48 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 17:25:48 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 net-next] net: phylink: improve phylink_sfp_config_phy() error message with empty supported
Date: Wed, 11 Dec 2024 19:25:36 +0200
Message-ID: <20241211172537.1245216-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::40) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10789:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e47de51-f9b7-4c50-b7f0-08dd1a08da8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?syXR0jJDkUyQqCaCqbfPYLsEQcXYaZ99OfTwx1Gkpm8uueKs8SfMyaT4luwK?=
 =?us-ascii?Q?tIuePAxldRqFzLJs7v6986ee5VAEcGnZmW+FN/3aJfuyw2gyfyO0oLz1ULJ6?=
 =?us-ascii?Q?VLfJVynh42t6mKG+TDwIawEtCdBJZr5hMpbAcsG4vsfd9QNmVxFqSuFjL9Eh?=
 =?us-ascii?Q?mrcjaJov4GXKAU91iblaDfO4yAHySKykXpxB8XctTQlR9oHfiT+EpFga7bf1?=
 =?us-ascii?Q?Xf1YNl6HRz+brv9mNMW6qOGVUOlapaJKqmp52XP7s0cKxJ8IYZYh/xAESzDd?=
 =?us-ascii?Q?a8m1yhKw6j5hitzT7lLlAWk6QsvFKbDIjArhPl8vI11u5AzQS0n835Z1JYPb?=
 =?us-ascii?Q?OFe/JVKZOciCpoY5YRJnk6UjaiTJeGW3eUHFLUoLArLCYAa+Gd5hVTCKL74l?=
 =?us-ascii?Q?FcJwMxvcBmt8RKv5UZQWXCUBQ7xS9TG+aZN56jE6dQcX13bRKyS1ew06nwAa?=
 =?us-ascii?Q?78mYFes2ONbF1QQkeO8bTCWq8KScL2uwHwmtG8SPo28GDfNYZq7oCEtEJD8/?=
 =?us-ascii?Q?JuublXFY32lCWSTv5mG5tDHsPI3pSBQQ8GXopsMSn69/mZlk1zY+RfqSVIAa?=
 =?us-ascii?Q?NEzaKcotfijLlmN3AHHW9rByOe3E76JkTyArZqkNvxI6CaJcTIxl2NWFoFO9?=
 =?us-ascii?Q?+APg0rBbgBtLZZlAfHYN3KMMrFRqg1LH7+kAO7qnpetx03x7xRQoabKaPMxl?=
 =?us-ascii?Q?4QQDad3K3oWuy+XcEWU2buMLMFlfr2e5i+eF8tOba1i5uot9K9P0Q+A2/oS0?=
 =?us-ascii?Q?wg7abnHs5aGFWUY50eIqkRxNE0UABteAVnNseC2xtzg7TP5bgLid2KdnElPu?=
 =?us-ascii?Q?PF3GeSi5bR063tOSx7NWV0YiwT3zEyL9cx4ImdmvIMKKm/YekqPN11J8Kmju?=
 =?us-ascii?Q?Xx26kzBG+cRILO2ulMUPTYPSpBQSLxmprl/hfU/+cdQA+8fHa7GArbXWiQ3N?=
 =?us-ascii?Q?UaRupjfwVMBmcZj9eYHH2KhBCR+EBs243YBzfn0oh8wSW+8ZZ4IsKaV5kVHD?=
 =?us-ascii?Q?DS+7mNccj6IQvYImC74raaHAZxxdxJ+cHvuhWppy1rs0y/f4rhLpl02o9Cpg?=
 =?us-ascii?Q?CzNGvI1t07yDiJjSvR3xx/+5vJycdlCDdHRUgPBI+dhr3PU8C91drLTWZAN5?=
 =?us-ascii?Q?IfYfRCmU0vJXYCxKA7CjZlgVBTyxbuKf6MzRY3qdMqDRaBYjOE6IM2MttLGK?=
 =?us-ascii?Q?1nAOad3AF/qxYSF259pcCvboo9poTXJBhqkK9XmvV4Shcot/WmXeZElwNBL7?=
 =?us-ascii?Q?Ewa/C8mYFG6JhN0UqbT2aVTCwJe+q3l7+aGVCHnhct690VgWFr5eKjetRGHa?=
 =?us-ascii?Q?x6VtmCMV9ScDueHadVgEg8UDgbCHXoqbr0hRc84avXva7Qn+6AQPjXc41thT?=
 =?us-ascii?Q?x+gTx+oU1U0xC9XWnJ7uxldSIlu8xDe5gTlc0XK8IqDndRTFvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VhykPMo3hjqKxs9eBRc5EiB2LriYdq6oNPNEyDFHgDc3hteRlhn4rQFPqo9A?=
 =?us-ascii?Q?jZJoSz+aWYezGhQ4JXp3vuu1mc/mzJmTPj4/KK6ff2ukBmjupWKJwRGN2cOA?=
 =?us-ascii?Q?09eK4VKmyGD+Di1ClEZtnbjLe8NQiqZVA8mUW9Q4tNzB44cP6k8Dn5/317wP?=
 =?us-ascii?Q?M//833iKNO8F2Af4ruOgU5lTX58+7/fiuYHNe0BcaBWTXO7rHLoputTvcNuc?=
 =?us-ascii?Q?meGXWxZhXnlanutiJmM7fclG/wtzjSrE+08Nvw89AhurhHf6lH6A1spzVrlj?=
 =?us-ascii?Q?gBfGMIVcmRN7ygoortJGSj87zzKg/gkaZNTDXNLY++9GV/EdSKYiAmRQS93S?=
 =?us-ascii?Q?XkoWBTqEn6qQc6ItvWaJH/VrfFsCl+hwq5Cni62JHyl8bTDOylWEUV43jyBn?=
 =?us-ascii?Q?ZSSs+lOWMym5UV3GhRztcl3sWf4ICpGKml8LwJxWdSPNifrdbf9Y9rXjl4Xq?=
 =?us-ascii?Q?MgIK0z2SWcez+0qTam4AJQm9gqgICvbvl4LBwhQjF6gdRkKNWTHeiqfTDNX+?=
 =?us-ascii?Q?WGWPSpnkAq+Mr5SvIk/CPxb93ZW6S840gw9XpW57Y/FzTbInVI7ApRCFgRg6?=
 =?us-ascii?Q?ioOQb13IHZYUnFyEfO09qOFTQwBXO/7oxkdldO1xUxP8wmMOFqWjfvGJYVpc?=
 =?us-ascii?Q?fqRNKS0lqfxALdlGAWdojfo2sRTbo+5+GuQk1Hp7NJ6zXu2Gow9D8LcmlIY8?=
 =?us-ascii?Q?D2Ho8rmVfy6TTrOZDKWxhfSFisSqANjzlKMO9WcDyNyQ9YjeCBEnJLKQ/yp8?=
 =?us-ascii?Q?WIi4RtYJLAuQJ55uGTX5zMjCF9wgiv3VLOQw0OJV1maRxZ1jwbxnl1Tvo/6z?=
 =?us-ascii?Q?BgQeA+EtIYCQ8bCaW553cd7oghsAtlxssI3ECMMIgKXKaTF4+OPcW61GOUMg?=
 =?us-ascii?Q?wRuMKceQ6ki8WrdXA0Ai+gLPKhJyLv9X7e0G5GDJnf1YdvIU1eBA4kVm3/cv?=
 =?us-ascii?Q?QOLExne9FTZchx6Y6zTSWVTT9aaQbgXCCz1yOA6eOrjxMeJSy3eYa/8lQsI8?=
 =?us-ascii?Q?XjoPNyMwU/oT/HpbszaKFJ3ap1WLT/dcyzhNnYj6AKeML1CmWArPBSN0pXy+?=
 =?us-ascii?Q?XO+MuqCeMZ3rQ35Eg2pj31IorM2zPngBzW7e+YLkv5aF2nJej+n0nIj9BMbu?=
 =?us-ascii?Q?Un6wY9zeaCRWj1kx6KoLnUZ8GGwklV+gy6dMDbMJPUTCsjsvW9470rBv7Wsa?=
 =?us-ascii?Q?bRpObmqROwTs6P+eaAV4gKRhhDNgNcI5jYs1x6fNo6OEF8nWk8Lazw/hSc2R?=
 =?us-ascii?Q?/ItbM0av18LTLc0idXGtTF78PiKnLLvaE9rprNSr5/5nM8ENd8e/nHvYxbgi?=
 =?us-ascii?Q?JF8VdeXQin8QlC2hCdvKF1X34eseqt30fwfhzW5IOex2P56jsxWWDQzJe5GC?=
 =?us-ascii?Q?+Szsa1zdVLeGfB3U72xqaOTDsIbEE3ejQi5LfKCF/rOABQGg3N+sL16SpZNg?=
 =?us-ascii?Q?z63KR4mbKbDtGvc7Y1oH1BIPnUnaJk4mf3CHwngEak98McMVFwjEFL/kqcso?=
 =?us-ascii?Q?qt/mEs/3hzDRs8rrIN55qhW+F6/xrado8LNf75Oei+FEJ/UzrlQ0cD/obua4?=
 =?us-ascii?Q?1Q/NW/5e0a7mckgtmNYfNg01tB7mDi5NUyICM7jXCIuoEqgNlJmYfSKBHEWs?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e47de51-f9b7-4c50-b7f0-08dd1a08da8f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:25:48.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wI/gC10bKgnnVwd6jWNseUudl4gPVhg03k2d2h7yg4FgqWVBZKbBxJDJIZCg4R9bCYy37TG7VNmJljVENhyNyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10789

It seems that phylink does not support driving PHYs in SFP modules using
the Generic PHY or Generic Clause 45 PHY driver. I've come to this
conclusion after analyzing these facts:

- sfp_sm_probe_phy(), who is our caller here, first calls
  phy_device_register() and then sfp_add_phy() -> ... ->
  phylink_sfp_connect_phy().

- phydev->supported is populated by phy_probe()

- phy_probe() is usually called synchronously from phy_device_register()
  via phy_bus_match(), if a precise device driver is found for the PHY.
  In that case, phydev->supported has a good chance of being set to a
  non-zero mask.

- There is an exceptional case for the PHYs for which phy_bus_match()
  didn't find a driver. Those devices sit for a while without a driver,
  then phy_attach_direct() force-binds the genphy_c45_driver or
  genphy_driver to them. Again, this triggers phy_probe() and renders
  a good chance of phydev->supported being populated, assuming
  compatibility with genphy_read_abilities() or
  genphy_c45_pma_read_abilities().

- phylink_sfp_config_phy() does not support the exceptional case of
  retrieving phydev->supported from the Generic PHY driver, due to its
  code flow. It expects the phydev->supported mask to already be
  non-empty, because it first calls phylink_validate() on it, and only
  calls phylink_attach_phy() if that succeeds. Thus, phylink_attach_phy()
  -> phy_attach_direct() has no chance of running.

It is not my wish to change the state of affairs by altering the code
flow, but merely to document the limitation rather than have the current
unspecific error:

[   61.800079] mv88e6085 d0032004.mdio-mii:12 sfp: validation with support 00,00000000,00000000,00000000 failed: -EINVAL
[   61.820743] sfp sfp: sfp_add_phy failed: -EINVAL

On the premise that an empty phydev->supported is going to make
phylink_validate() fail anyway, it would be more informative to single
out that case, undercut the phylink_validate() call, and print a more
specific message:

[   33.468000] mv88e6085 d0032004.mdio-mii:12 sfp: PHY i2c:sfp:16 (id 0x01410cc2) supports no link modes. Maybe its specific PHY driver not loaded?
[   33.488187] mv88e6085 d0032004.mdio-mii:12 sfp: Common drivers for PHYs on SFP modules are CONFIG_BCM84881_PHY and CONFIG_MARVELL_PHY.
[   33.518621] sfp sfp: sfp_add_phy failed: -EINVAL

Of course, there may be other reasons due to which phydev->supported is
empty, thus the use of the word "maybe", but I think the lack of a
driver would be the most common.

Link: https://lore.kernel.org/netdev/20241113144229.3ff4bgsalvj7spb7@skbuf/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: add one more informational line containing common Kconfig
options, as per review feedback.

Link to v1:
https://lore.kernel.org/netdev/20241114165348.2445021-1-vladimir.oltean@nxp.com/

 drivers/net/phy/phylink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 95fbc363f9a6..b9dee09f4cfc 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3436,6 +3436,12 @@ static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
 	int ret;
 
 	linkmode_copy(support, phy->supported);
+	if (linkmode_empty(support)) {
+		phylink_err(pl, "PHY %s (id 0x%.8lx) supports no link modes. Maybe its specific PHY driver not loaded?\n",
+			    phydev_name(phy), (unsigned long)phy->phy_id);
+		phylink_err(pl, "Common drivers for PHYs on SFP modules are CONFIG_BCM84881_PHY and CONFIG_MARVELL_PHY.\n");
+		return -EINVAL;
+	}
 
 	memset(&config, 0, sizeof(config));
 	linkmode_copy(config.advertising, phy->advertising);
-- 
2.43.0


