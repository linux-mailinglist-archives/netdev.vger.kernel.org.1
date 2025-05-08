Return-Path: <netdev+bounces-188934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35E6AAF732
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2390A7A4564
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE15519D087;
	Thu,  8 May 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LgPZCNMK"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA64B1E48;
	Thu,  8 May 2025 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746697981; cv=fail; b=Hsmfe6JAudNoFaSRr9DNIbcvNEdJpfrQHhdF0Pe1bnGNhHbDTHgaB0oqXga/fONYuaAE8wH9glLXIOa8GzxMsOiYwNGmQKeRk8flKYeo8p8d4Z3DXsxDzD6TCcT8xkz06kc+MgnxT8sLg8y2EPuNwIH/VijBknclVSNQO9zJ7ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746697981; c=relaxed/simple;
	bh=ao5cvOnwTetk9fRyzyOBNsgf2mg+bb60hyiAzyj078Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UG/VDVfAq1+9WdfsBgxGrjuNJDOATJjTQQlnCN5d/b0TKhQj03qv7sYmPGSPGg0kYK+ps47wHF3KFe8LHQo4ffujSbtSrh3WCBUDMg5UJKetRIgsyBOmkRklK4wZ2GFVynDyXryzCsfZNiCbC3Ay4d7Vq782Qy+6dAEVCkhcPkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LgPZCNMK; arc=fail smtp.client-ip=40.107.247.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dsv/TreZZGuOi3+dqANubq88YzufekjQB0w6v2ARVF6OWgdeuOUVvoobs54pcr5EiiN+jJODvTERjpc0/4wcG+OTy1kUvtdax0oeEDp+yrIYvokcmNF7Ys5gBq2rM1R/MCDq31j06ndAtILQIBrRibjYVwpYGXOpvyosjyQfBO2z/JHUwYdaF2xMDP+kSgSH2bvJnzIJrjvM5AFHdL935mh7TLRZRDWuug8Jsq+ELPMgNLrvHKDHwj11q/N+Rbm1/JOJI4IffemLgG6kODBFeD36vRtehNuwr1PHuA6gNUzu4V9z3Nctf9cSm7mWSi/+nvu3dAt4POK/2ilBVKnd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgAgz13nr1UeQxxn2/oTbRdWsysuey0u7OLUf/xTxfc=;
 b=yWYktPYjnVump6SvpMIYDLOLwnlUi191qvp5xrOV39Pc3RHqh6J5gyvuueHLFbTu/HvUW6zEW6geqr6bVZdQT+MhkmeSau5ME5s0ouQwPaD0/05zuQ0GJMiRHL7tHTUefXr2vUu1OgtORaRAzIQMRINlNbyhpJ61HNFbmlcWsrbbGS376i5vwOelckozT1d7aVkw8yIZUbd9waB58MdaX6/PbBioMpsfZQpwVQoYP0U5hOAybOxkwJMZLjOtVMCM2zMrwLeILcMHafbrjDaUg/lb4mwdAZhaJMZ0lwqh/Voeh1i41QeP1Xu6N0/kqZ9Yk9A7KrIjMGBytE1wUyqadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgAgz13nr1UeQxxn2/oTbRdWsysuey0u7OLUf/xTxfc=;
 b=LgPZCNMKDNwEpwYb3lGzsgEMx0br+XzPDtukouLdyTyUVTdfexCSRgHOjHaPgeI8+nRMS+svyIqXe1UGy3sRaKVW3h49qns4PqDF4MsfqBhmrNTn0jMRJ5YwMkclIWBMLTDoybxD7EbAK5cAaRLmMyHhTD57SxXkbkJ/odDYN8OlXZe9HNVQMpTSjcP181XEExaqUId60cIC9JToFM1tD+bU0ngQ89b8oq/KRylYksQOHiLh8irm3ap5EpoO2ddqZluCMc48YwWYJZaGf1OvA0zPN+Lv0euy3wy/4KvkBzsGG7Fw0LRUKcelQu/mNt3AaL9tldlaNzde7GZRzXmePQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DUZPR04MB9947.eurprd04.prod.outlook.com (2603:10a6:10:4d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 09:52:52 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 09:52:52 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Thu,  8 May 2025 12:52:36 +0300
Message-ID: <20250508095236.887789-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0044.eurprd03.prod.outlook.com
 (2603:10a6:803:118::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DUZPR04MB9947:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3ed512-d557-4208-794e-08dd8e16194e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dk5AhT34AOfQJHv4ZFAIWdLurPCB4DoSkCO3HzQGchcUIR73bpA5Fw2Vt4of?=
 =?us-ascii?Q?0lro8ujWvF9107X03ap0+Jm3pon5kH3kZiFF8Qoly2agCXQhDHJHvJAo1e+f?=
 =?us-ascii?Q?9P77VJJZS4k1VroykUFzvS/usJJwoUd2T07+/vbVW3I6HRAmFIPS/bcKJCl2?=
 =?us-ascii?Q?8RAnXBhfhmxNAx4TUPvTJkKSMAQ0d+lcrko3d2/m19gRIDxEYxXaRXxnTinH?=
 =?us-ascii?Q?D2DFWxPjzlGzbjK7jgP2Mt/qZDxCAxmUT91MK8cYO1+F2BDv4XLOi4+oWr0w?=
 =?us-ascii?Q?Fvj7w1nQCRifTZJZ5eq6fKy0S3nFZBcE3IIcra1Ltzyl0op99xvZwOQ7YA0A?=
 =?us-ascii?Q?/tK9dAEsO9UVBAXK3EgGk6Myhl7/MtfNCrlSq+IeNLic6HsPwZTKNiA/0+X9?=
 =?us-ascii?Q?NwBLpxFZ6tEHaNdxFivP4cuU8z3RrXHsLbI5P8wz7pAQqVWBXrfM09FC57vL?=
 =?us-ascii?Q?gaVOD3AJ1OJzFs5Nhsb9Zh+snbhV78xvxLE7nQ7HVfeUQB1uVP+w0sPgyf+D?=
 =?us-ascii?Q?9KqjCGXl/wq9uEwmkawzdKcgwHJgFCfy75CNdnZdPNCnhR+7kWy54PkmAPDD?=
 =?us-ascii?Q?r5oCQt83lJpcvo6Y6R2ptvds6V80lrskK4E9Wv6QjKCHgZIcE84AampoWSPX?=
 =?us-ascii?Q?TGniUTuNFsQe+ofOqsVc6ORX6cUDN4nt3pAZiuJ8zKTjw3AfpeODUevMJFU+?=
 =?us-ascii?Q?cYqsPLCFnH6YKEYstwvXmA1adk7OofbOqttgkARhKXvV0Yyx+vo2yyIXAQZK?=
 =?us-ascii?Q?/0UHPfeztETcJp2LyI6VpuomqAlEe4m9u56i/LwnAvfB11ccgaqMD/dwHUCy?=
 =?us-ascii?Q?9HCfh9+LaWb1JnKxeiwkgxkfwrNtggungHrhze7DZL38o26iQAdf2E2QBtSJ?=
 =?us-ascii?Q?jrQUrhpKr113oUryyu9clIboHBMKK63yAm/RBjsWAzI35SkbOQLUL3vfAoK9?=
 =?us-ascii?Q?RU5gOL2Afp8AAXMtsG97i/WVo0PzcrWy9V7rxCISa2c+7FaHLoBKy9iNB1U9?=
 =?us-ascii?Q?Q9hEeyNDQLHou2SToWta36Zk1DZmhZiujjxoiKx33PRBVGPr4oTxTEHiThxI?=
 =?us-ascii?Q?9NtlRTEgITEvCT3i6Ld7qmf5+S4O8Z45r1VsBuufa8vMPSPf7lWxpLrIexCs?=
 =?us-ascii?Q?Lpr/8nhAzIGZJehz4z/vvVbsUhw00ZhPEcWAm6x2xWWFSjcwCBmIoQNM7imN?=
 =?us-ascii?Q?koLQ/BtDez+CWvU49PzkKbb26b2sQNUgRSNk5B5Nv0D8MVDr8ub8UF70GQLu?=
 =?us-ascii?Q?yzKbCBCSGuQ2IZNmkRoNqYB1YTuH7vyYdmnFhuNZMgINjS53TGOEfw8jo9Xc?=
 =?us-ascii?Q?23qaaN73K6DGtEtPgj/uxvnFCu+zWevXpcM0IDpm6dIONKru+sWl1gmPggMu?=
 =?us-ascii?Q?bKEL6g9+8B+HdF43e0iNUktrRgNDd7Ot1BIOHA8vjdkw7Jo+pdq3ES3QfYMn?=
 =?us-ascii?Q?lYoFGZqmN+k3inGrvDHi03g6TV/dFbENyxXK57SGD7zYA6rjw+oDKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8DvyFwCSmMEB8yEvht9NhxmPmQfS+KTIrxusJnGgq77jmJoObcjWirKIzAl2?=
 =?us-ascii?Q?mbyfgsklVjn4t/YgIAiARVjBy2+rFTP2W8Q8RfwDazqVgA3vgmK4QTqaq/tA?=
 =?us-ascii?Q?p8JxpKpI7sxHl9k2D3xtWiVg3nn2NKXm9DtL2aNJSCy4GAl0QKXIzEfs0ppU?=
 =?us-ascii?Q?sCn8HsUOst+YOhIgy1Ct1dB5056heu78GGdU0W45pyuT+E7nIAoM17K6Mzye?=
 =?us-ascii?Q?cLmliNztX7ZTPoQPNQcdxaBRZikg7iDR/cFfDVd4ZeGbl0+xJnU2BL80sueY?=
 =?us-ascii?Q?rI3+via3deaQ5WAsQZEx7Kg/vs7kssd8dfmSreyRVGI3MnpITfhIiqiouRbe?=
 =?us-ascii?Q?HQnRcUaqYjvjrSGszCWKzDYm8kjfNkxhQM/KG7t888iqptRZMkFbBDr4vP5W?=
 =?us-ascii?Q?mr1hEFs1aBAX2otekeL/QB4ZbLGOIs7pwR+StR7Q0z2MIuX83WMLXO/lkskT?=
 =?us-ascii?Q?wEdFbj4/kSNgFznna7mAPQsF5PvsHqxa6Whxoza3KCZoNr5xCbKVq7FG2n+w?=
 =?us-ascii?Q?Yyl3+27QCiBIu97MFow0lBQvRD3H0GIHMqQQrmZrjuPD3fhbpwGfcGUEaWWa?=
 =?us-ascii?Q?9r0pGgAW6386SaGhmYx8z7PfMGfDKplMNtnMxyM1V286vBAtyL3CPQD7UXkx?=
 =?us-ascii?Q?AvuYyWsU6MqZGYw132T8gm7ueNsOnk5uhDgTYVqzwYNpDoYA3+F6sHMe15H4?=
 =?us-ascii?Q?lKWiwRe9IFgjQmn70e+4YTv3ImLXI87tO7kyudkAVnYQ95Gp5/Ip0M9ItSE9?=
 =?us-ascii?Q?mLW4nVjhUDZVovMvC80WzeMVd+ppMA1ITfLk8B1lGTeMGztQd/8D/ysDFFbP?=
 =?us-ascii?Q?DIHq3ejGk6lwi2eWrKiZH3pkd1wNJafyYbis7rZsYP26pZQJwvbiTtMmAYq7?=
 =?us-ascii?Q?93ABgQEsIBGzgrl83sVvUSjasSc9CQDvZKwotnW5FDv+klHZsIgCPqXgb1yr?=
 =?us-ascii?Q?IiUB8sMg9rRRwIzNOqMIx8qwZI9bPGRBiSTDsf9zULYPRwfMxeRExzOI52Yh?=
 =?us-ascii?Q?mCCO8yd4+Alg3/nFikRauBAUl3m0i2ZnMoCCN9dwNiePjJrmjt9hyYonAVak?=
 =?us-ascii?Q?6T+PAYtNz19rLWxgYCj70Js5LmbsG3a1pv0V/7b2WMlPAgeWK8JZScmJz2XO?=
 =?us-ascii?Q?tSPVTotc8nnUO78WWCh0NPTJBmmzmKrtjTzNtDKOljiUo60wfV1EY/4MPRoi?=
 =?us-ascii?Q?OfS/VZ+T8xiEUGsXWdSd2uV/6ww/o5v2e8SBkUemTi3PRa3uTk4/jwzkWqGD?=
 =?us-ascii?Q?+Vd2+XiwEqmCv9JxRFOwdkrzH/p2vfsE3oF4J4ioGKvXxwJOTYVF+wVPNJtY?=
 =?us-ascii?Q?DE2ur/LT61PzpqVYLp6GNzHmrnANRkHo5GGeAhIg9OL2P8YN2U4cBIl4CU/u?=
 =?us-ascii?Q?juiiHf97gwmjgHTZWLo3PcM5+tJs/1kPgIiwmx8rtf+03u1/FcCRX7zwsd1a?=
 =?us-ascii?Q?NxwjcXiiM8Ph1DiBMJKuAvSiaoH+eKLjQv7OnPPp4VKU6CANWm4i7+Qw5gA4?=
 =?us-ascii?Q?OoS/Jm7+0vUMt3Hl2nz4BdXJ4n48SVlYcgOnU4SePGE6VS30n0cFSume0Nb2?=
 =?us-ascii?Q?JhaMcGQRoB6JMGxG5Yyj+9xdrvl91lNHN7sIbGnbTipavhNMsEjv86FXupUI?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3ed512-d557-4208-794e-08dd8e16194e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 09:52:52.5876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uh0ioVsDBbRLJwYxt9eSemEKvuvJHtIatWWCo2vHP+GHj02sVLCd7FB6N48RhausoC+Hiv9gMsh7KV26uzbbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9947

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6. It is
time to convert DSA to the new API, so that the ndo_eth_ioctl() path can
be removed completely.

Move the ds->ops->port_hwtstamp_get() and ds->ops->port_hwtstamp_set()
calls from dsa_user_ioctl() to dsa_user_hwtstamp_get() and
dsa_user_hwtstamp_set().

Due to the fact that the underlying ifreq type changes to
kernel_hwtstamp_config, the drivers and the Ocelot switchdev front-end,
all hooked up directly or indirectly, must also be converted all at once.

The conversion also updates the comment from dsa_port_supports_hwtstamp(),
which is no longer true because kernel_hwtstamp_config is kernel memory
and does not need copy_to_user(). I've deliberated whether it is
necessary to also update "err != -EOPNOTSUPP" to a more general "!err",
but all drivers now either return 0 or -EOPNOTSUPP.

The existing logic from the ocelot_ioctl() function, to avoid
configuring timestamping if the PHY supports the operation, is obsoleted
by more advanced core logic in dev_set_hwtstamp_phylib().

This is only a partial preparation for proper PHY timestamping support.
None of these switch driver currently sets up PTP traps for PHY
timestamping, so setting dev->see_all_hwtstamp_requests is not yet
necessary and the conversion is relatively trivial.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # felix, sja1105, mv88e6xxx
---
 drivers/net/dsa/hirschmann/hellcreek.h        |  2 +-
 .../net/dsa/hirschmann/hellcreek_hwtstamp.c   | 24 ++++-------
 .../net/dsa/hirschmann/hellcreek_hwtstamp.h   |  5 ++-
 drivers/net/dsa/microchip/ksz_common.h        |  2 +-
 drivers/net/dsa/microchip/ksz_ptp.c           | 26 +++++------
 drivers/net/dsa/microchip/ksz_ptp.h           |  7 ++-
 drivers/net/dsa/mv88e6xxx/chip.h              |  2 +-
 drivers/net/dsa/mv88e6xxx/hwtstamp.c          | 24 +++++------
 drivers/net/dsa/mv88e6xxx/hwtstamp.h          | 16 ++++---
 drivers/net/dsa/ocelot/felix.c                | 11 +++--
 drivers/net/dsa/sja1105/sja1105_ptp.c         | 32 ++++++--------
 drivers/net/dsa/sja1105/sja1105_ptp.h         |  7 ++-
 drivers/net/ethernet/mscc/ocelot_net.c        | 33 ++++++++------
 drivers/net/ethernet/mscc/ocelot_ptp.c        | 43 ++++++-------------
 include/net/dsa.h                             |  5 ++-
 include/soc/mscc/ocelot.h                     |  7 ++-
 net/dsa/port.c                                | 10 ++---
 net/dsa/user.c                                | 41 ++++++++++++------
 18 files changed, 147 insertions(+), 150 deletions(-)

diff --git a/drivers/net/dsa/hirschmann/hellcreek.h b/drivers/net/dsa/hirschmann/hellcreek.h
index 9c2ed2ba79da..bebf0d3ff330 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.h
+++ b/drivers/net/dsa/hirschmann/hellcreek.h
@@ -244,7 +244,7 @@ struct hellcreek_port_hwtstamp {
 	struct sk_buff *tx_skb;
 
 	/* Current timestamp configuration */
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 };
 
 struct hellcreek_port {
diff --git a/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c b/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c
index ca2500aba96f..99941ff1ebf9 100644
--- a/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c
+++ b/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c
@@ -40,7 +40,7 @@ int hellcreek_get_ts_info(struct dsa_switch *ds, int port,
  * the user requested what is actually available or not
  */
 static int hellcreek_set_hwtstamp_config(struct hellcreek *hellcreek, int port,
-					 struct hwtstamp_config *config)
+					 struct kernel_hwtstamp_config *config)
 {
 	struct hellcreek_port_hwtstamp *ps =
 		&hellcreek->ports[port].port_hwtstamp;
@@ -110,41 +110,35 @@ static int hellcreek_set_hwtstamp_config(struct hellcreek *hellcreek, int port,
 }
 
 int hellcreek_port_hwtstamp_set(struct dsa_switch *ds, int port,
-				struct ifreq *ifr)
+				struct kernel_hwtstamp_config *config,
+				struct netlink_ext_ack *extack)
 {
 	struct hellcreek *hellcreek = ds->priv;
 	struct hellcreek_port_hwtstamp *ps;
-	struct hwtstamp_config config;
 	int err;
 
 	ps = &hellcreek->ports[port].port_hwtstamp;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	err = hellcreek_set_hwtstamp_config(hellcreek, port, &config);
+	err = hellcreek_set_hwtstamp_config(hellcreek, port, config);
 	if (err)
 		return err;
 
 	/* Save the chosen configuration to be returned later */
-	memcpy(&ps->tstamp_config, &config, sizeof(config));
+	ps->tstamp_config = *config;
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 int hellcreek_port_hwtstamp_get(struct dsa_switch *ds, int port,
-				struct ifreq *ifr)
+				struct kernel_hwtstamp_config *config)
 {
 	struct hellcreek *hellcreek = ds->priv;
 	struct hellcreek_port_hwtstamp *ps;
-	struct hwtstamp_config *config;
 
 	ps = &hellcreek->ports[port].port_hwtstamp;
-	config = &ps->tstamp_config;
+	*config = ps->tstamp_config;
 
-	return copy_to_user(ifr->ifr_data, config, sizeof(*config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 /* Returns a pointer to the PTP header if the caller should time stamp, or NULL
diff --git a/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h b/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h
index 7d88da2134f2..388821c4aa10 100644
--- a/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h
+++ b/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.h
@@ -38,9 +38,10 @@
 #define TX_TSTAMP_TIMEOUT	msecs_to_jiffies(40)
 
 int hellcreek_port_hwtstamp_set(struct dsa_switch *ds, int port,
-				struct ifreq *ifr);
+				struct kernel_hwtstamp_config *config,
+				struct netlink_ext_ack *extack);
 int hellcreek_port_hwtstamp_get(struct dsa_switch *ds, int port,
-				struct ifreq *ifr);
+				struct kernel_hwtstamp_config *config);
 
 bool hellcreek_port_rxtstamp(struct dsa_switch *ds, int port,
 			     struct sk_buff *clone, unsigned int type);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index dd5429ff16ee..a034017568cd 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -142,7 +142,7 @@ struct ksz_port {
 	struct ksz_irq pirq;
 	u8 num;
 #if IS_ENABLED(CONFIG_NET_DSA_MICROCHIP_KSZ_PTP)
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 	bool hwts_tx_en;
 	bool hwts_rx_en;
 	struct ksz_irq ptpirq;
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 22fb9ef4645c..bc54a96ba646 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -319,22 +319,21 @@ int ksz_get_ts_info(struct dsa_switch *ds, int port, struct kernel_ethtool_ts_in
 	return 0;
 }
 
-int ksz_hwtstamp_get(struct dsa_switch *ds, int port, struct ifreq *ifr)
+int ksz_hwtstamp_get(struct dsa_switch *ds, int port,
+		     struct kernel_hwtstamp_config *config)
 {
 	struct ksz_device *dev = ds->priv;
-	struct hwtstamp_config *config;
 	struct ksz_port *prt;
 
 	prt = &dev->ports[port];
-	config = &prt->tstamp_config;
+	*config = prt->tstamp_config;
 
-	return copy_to_user(ifr->ifr_data, config, sizeof(*config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 static int ksz_set_hwtstamp_config(struct ksz_device *dev,
 				   struct ksz_port *prt,
-				   struct hwtstamp_config *config)
+				   struct kernel_hwtstamp_config *config)
 {
 	int ret;
 
@@ -404,26 +403,21 @@ static int ksz_set_hwtstamp_config(struct ksz_device *dev,
 	return ksz_ptp_enable_mode(dev);
 }
 
-int ksz_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
+int ksz_hwtstamp_set(struct dsa_switch *ds, int port,
+		     struct kernel_hwtstamp_config *config,
+		     struct netlink_ext_ack *extack)
 {
 	struct ksz_device *dev = ds->priv;
-	struct hwtstamp_config config;
 	struct ksz_port *prt;
 	int ret;
 
 	prt = &dev->ports[port];
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	ret = ksz_set_hwtstamp_config(dev, prt, &config);
+	ret = ksz_set_hwtstamp_config(dev, prt, config);
 	if (ret)
 		return ret;
 
-	memcpy(&prt->tstamp_config, &config, sizeof(config));
-
-	if (copy_to_user(ifr->ifr_data, &config, sizeof(config)))
-		return -EFAULT;
+	prt->tstamp_config = *config;
 
 	return 0;
 }
diff --git a/drivers/net/dsa/microchip/ksz_ptp.h b/drivers/net/dsa/microchip/ksz_ptp.h
index 2f1783c0d723..3086e519b1b6 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.h
+++ b/drivers/net/dsa/microchip/ksz_ptp.h
@@ -39,8 +39,11 @@ void ksz_ptp_clock_unregister(struct dsa_switch *ds);
 
 int ksz_get_ts_info(struct dsa_switch *ds, int port,
 		    struct kernel_ethtool_ts_info *ts);
-int ksz_hwtstamp_get(struct dsa_switch *ds, int port, struct ifreq *ifr);
-int ksz_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr);
+int ksz_hwtstamp_get(struct dsa_switch *ds, int port,
+		     struct kernel_hwtstamp_config *config);
+int ksz_hwtstamp_set(struct dsa_switch *ds, int port,
+		     struct kernel_hwtstamp_config *config,
+		     struct netlink_ext_ack *extack);
 void ksz_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb);
 void ksz_port_deferred_xmit(struct kthread_work *work);
 bool ksz_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 86bf113c9bfa..7d00482f53a3 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -241,7 +241,7 @@ struct mv88e6xxx_port_hwtstamp {
 	u16 tx_seq_id;
 
 	/* Current timestamp configuration */
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 };
 
 enum mv88e6xxx_policy_mapping {
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 49e6e1355142..f663799b0b3b 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -89,7 +89,7 @@ int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
 }
 
 static int mv88e6xxx_set_hwtstamp_config(struct mv88e6xxx_chip *chip, int port,
-					 struct hwtstamp_config *config)
+					 struct kernel_hwtstamp_config *config)
 {
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
 	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
@@ -169,42 +169,38 @@ static int mv88e6xxx_set_hwtstamp_config(struct mv88e6xxx_chip *chip, int port,
 }
 
 int mv88e6xxx_port_hwtstamp_set(struct dsa_switch *ds, int port,
-				struct ifreq *ifr)
+				struct kernel_hwtstamp_config *config,
+				struct netlink_ext_ack *extack)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
 	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
-	struct hwtstamp_config config;
 	int err;
 
 	if (!chip->info->ptp_support)
 		return -EOPNOTSUPP;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	err = mv88e6xxx_set_hwtstamp_config(chip, port, &config);
+	err = mv88e6xxx_set_hwtstamp_config(chip, port, config);
 	if (err)
 		return err;
 
 	/* Save the chosen configuration to be returned later. */
-	memcpy(&ps->tstamp_config, &config, sizeof(config));
+	ps->tstamp_config = *config;
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 int mv88e6xxx_port_hwtstamp_get(struct dsa_switch *ds, int port,
-				struct ifreq *ifr)
+				struct kernel_hwtstamp_config *config)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
 	struct mv88e6xxx_port_hwtstamp *ps = &chip->port_hwtstamp[port];
-	struct hwtstamp_config *config = &ps->tstamp_config;
 
 	if (!chip->info->ptp_support)
 		return -EOPNOTSUPP;
 
-	return copy_to_user(ifr->ifr_data, config, sizeof(*config)) ?
-		-EFAULT : 0;
+	*config = ps->tstamp_config;
+
+	return 0;
 }
 
 /* Returns a pointer to the PTP header if the caller should time stamp,
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
index 85acc758e3eb..22e4acc957f0 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
@@ -111,9 +111,10 @@
 #ifdef CONFIG_NET_DSA_MV88E6XXX_PTP
 
 int mv88e6xxx_port_hwtstamp_set(struct dsa_switch *ds, int port,
-				struct ifreq *ifr);
+				struct kernel_hwtstamp_config *cfg,
+				struct netlink_ext_ack *extack);
 int mv88e6xxx_port_hwtstamp_get(struct dsa_switch *ds, int port,
-				struct ifreq *ifr);
+				struct kernel_hwtstamp_config *cfg);
 
 bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
 			     struct sk_buff *clone, unsigned int type);
@@ -132,14 +133,17 @@ int mv88e6165_global_disable(struct mv88e6xxx_chip *chip);
 
 #else /* !CONFIG_NET_DSA_MV88E6XXX_PTP */
 
-static inline int mv88e6xxx_port_hwtstamp_set(struct dsa_switch *ds,
-					      int port, struct ifreq *ifr)
+static inline int
+mv88e6xxx_port_hwtstamp_set(struct dsa_switch *ds, int port,
+			    struct kernel_hwtstamp_config *config,
+			    struct netlink_ext_ack *extack)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int mv88e6xxx_port_hwtstamp_get(struct dsa_switch *ds,
-					      int port, struct ifreq *ifr)
+static inline int
+mv88e6xxx_port_hwtstamp_get(struct dsa_switch *ds, int port,
+			    struct kernel_hwtstamp_config *config)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 0a4e682a55ef..2dd4e56e1cf1 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1774,22 +1774,25 @@ static void felix_teardown(struct dsa_switch *ds)
 }
 
 static int felix_hwtstamp_get(struct dsa_switch *ds, int port,
-			      struct ifreq *ifr)
+			      struct kernel_hwtstamp_config *config)
 {
 	struct ocelot *ocelot = ds->priv;
 
-	return ocelot_hwstamp_get(ocelot, port, ifr);
+	ocelot_hwstamp_get(ocelot, port, config);
+
+	return 0;
 }
 
 static int felix_hwtstamp_set(struct dsa_switch *ds, int port,
-			      struct ifreq *ifr)
+			      struct kernel_hwtstamp_config *config,
+			      struct netlink_ext_ack *extack)
 {
 	struct ocelot *ocelot = ds->priv;
 	struct felix *felix = ocelot_to_felix(ocelot);
 	bool using_tag_8021q;
 	int err;
 
-	err = ocelot_hwstamp_set(ocelot, port, ifr);
+	err = ocelot_hwstamp_set(ocelot, port, config, extack);
 	if (err)
 		return err;
 
diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.c b/drivers/net/dsa/sja1105/sja1105_ptp.c
index 3abc64aec411..fefe46e2a5e6 100644
--- a/drivers/net/dsa/sja1105/sja1105_ptp.c
+++ b/drivers/net/dsa/sja1105/sja1105_ptp.c
@@ -58,19 +58,17 @@ enum sja1105_ptp_clk_mode {
 #define ptp_data_to_sja1105(d) \
 		container_of((d), struct sja1105_private, ptp_data)
 
-int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
+int sja1105_hwtstamp_set(struct dsa_switch *ds, int port,
+			 struct kernel_hwtstamp_config *config,
+			 struct netlink_ext_ack *extack)
 {
 	struct sja1105_private *priv = ds->priv;
 	unsigned long hwts_tx_en, hwts_rx_en;
-	struct hwtstamp_config config;
-
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
 
 	hwts_tx_en = priv->hwts_tx_en;
 	hwts_rx_en = priv->hwts_rx_en;
 
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		hwts_tx_en &= ~BIT(port);
 		break;
@@ -81,7 +79,7 @@ int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		hwts_rx_en &= ~BIT(port);
 		break;
@@ -92,32 +90,28 @@ int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	if (copy_to_user(ifr->ifr_data, &config, sizeof(config)))
-		return -EFAULT;
-
 	priv->hwts_tx_en = hwts_tx_en;
 	priv->hwts_rx_en = hwts_rx_en;
 
 	return 0;
 }
 
-int sja1105_hwtstamp_get(struct dsa_switch *ds, int port, struct ifreq *ifr)
+int sja1105_hwtstamp_get(struct dsa_switch *ds, int port,
+			 struct kernel_hwtstamp_config *config)
 {
 	struct sja1105_private *priv = ds->priv;
-	struct hwtstamp_config config;
 
-	config.flags = 0;
+	config->flags = 0;
 	if (priv->hwts_tx_en & BIT(port))
-		config.tx_type = HWTSTAMP_TX_ON;
+		config->tx_type = HWTSTAMP_TX_ON;
 	else
-		config.tx_type = HWTSTAMP_TX_OFF;
+		config->tx_type = HWTSTAMP_TX_OFF;
 	if (priv->hwts_rx_en & BIT(port))
-		config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
 	else
-		config.rx_filter = HWTSTAMP_FILTER_NONE;
+		config->rx_filter = HWTSTAMP_FILTER_NONE;
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 int sja1105_get_ts_info(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.h b/drivers/net/dsa/sja1105/sja1105_ptp.h
index 8add2bd5f728..325e3777ea07 100644
--- a/drivers/net/dsa/sja1105/sja1105_ptp.h
+++ b/drivers/net/dsa/sja1105/sja1105_ptp.h
@@ -112,9 +112,12 @@ bool sja1105_port_rxtstamp(struct dsa_switch *ds, int port,
 void sja1105_port_txtstamp(struct dsa_switch *ds, int port,
 			   struct sk_buff *skb);
 
-int sja1105_hwtstamp_get(struct dsa_switch *ds, int port, struct ifreq *ifr);
+int sja1105_hwtstamp_get(struct dsa_switch *ds, int port,
+			 struct kernel_hwtstamp_config *config);
 
-int sja1105_hwtstamp_set(struct dsa_switch *ds, int port, struct ifreq *ifr);
+int sja1105_hwtstamp_set(struct dsa_switch *ds, int port,
+			 struct kernel_hwtstamp_config *config,
+			 struct netlink_ext_ack *extack);
 
 int __sja1105_ptp_gettimex(struct dsa_switch *ds, u64 *ns,
 			   struct ptp_system_timestamp *sts);
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 7663d196eaf8..469784d3a1a6 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -869,24 +869,31 @@ static int ocelot_set_features(struct net_device *dev,
 }
 
 static int ocelot_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	return phy_mii_ioctl(dev->phydev, ifr, cmd);
+}
+
+static int ocelot_port_hwtstamp_get(struct net_device *dev,
+				    struct kernel_hwtstamp_config *cfg)
 {
 	struct ocelot_port_private *priv = netdev_priv(dev);
 	struct ocelot *ocelot = priv->port.ocelot;
 	int port = priv->port.index;
 
-	/* If the attached PHY device isn't capable of timestamping operations,
-	 * use our own (when possible).
-	 */
-	if (!phy_has_hwtstamp(dev->phydev) && ocelot->ptp) {
-		switch (cmd) {
-		case SIOCSHWTSTAMP:
-			return ocelot_hwstamp_set(ocelot, port, ifr);
-		case SIOCGHWTSTAMP:
-			return ocelot_hwstamp_get(ocelot, port, ifr);
-		}
-	}
+	ocelot_hwstamp_get(ocelot, port, cfg);
 
-	return phy_mii_ioctl(dev->phydev, ifr, cmd);
+	return 0;
+}
+
+static int ocelot_port_hwtstamp_set(struct net_device *dev,
+				    struct kernel_hwtstamp_config *cfg,
+				    struct netlink_ext_ack *extack)
+{
+	struct ocelot_port_private *priv = netdev_priv(dev);
+	struct ocelot *ocelot = priv->port.ocelot;
+	int port = priv->port.index;
+
+	return ocelot_hwstamp_set(ocelot, port, cfg, extack);
 }
 
 static int ocelot_change_mtu(struct net_device *dev, int new_mtu)
@@ -917,6 +924,8 @@ static const struct net_device_ops ocelot_port_netdev_ops = {
 	.ndo_set_features		= ocelot_set_features,
 	.ndo_setup_tc			= ocelot_setup_tc,
 	.ndo_eth_ioctl			= ocelot_ioctl,
+	.ndo_hwtstamp_get		= ocelot_port_hwtstamp_get,
+	.ndo_hwtstamp_set		= ocelot_port_hwtstamp_set,
 };
 
 struct net_device *ocelot_port_to_netdev(struct ocelot *ocelot, int port)
diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index d2a0a32f75ea..88b5422cc2a0 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -514,47 +514,42 @@ static int ocelot_ptp_tx_type_to_cmd(int tx_type, int *ptp_cmd)
 	return 0;
 }
 
-int ocelot_hwstamp_get(struct ocelot *ocelot, int port, struct ifreq *ifr)
+void ocelot_hwstamp_get(struct ocelot *ocelot, int port,
+			struct kernel_hwtstamp_config *cfg)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
-	struct hwtstamp_config cfg = {};
 
 	switch (ocelot_port->ptp_cmd) {
 	case IFH_REW_OP_TWO_STEP_PTP:
-		cfg.tx_type = HWTSTAMP_TX_ON;
+		cfg->tx_type = HWTSTAMP_TX_ON;
 		break;
 	case IFH_REW_OP_ORIGIN_PTP:
-		cfg.tx_type = HWTSTAMP_TX_ONESTEP_SYNC;
+		cfg->tx_type = HWTSTAMP_TX_ONESTEP_SYNC;
 		break;
 	default:
-		cfg.tx_type = HWTSTAMP_TX_OFF;
+		cfg->tx_type = HWTSTAMP_TX_OFF;
 		break;
 	}
 
-	cfg.rx_filter = ocelot_traps_to_ptp_rx_filter(ocelot_port->trap_proto);
-
-	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
+	cfg->rx_filter = ocelot_traps_to_ptp_rx_filter(ocelot_port->trap_proto);
 }
 EXPORT_SYMBOL(ocelot_hwstamp_get);
 
-int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
+int ocelot_hwstamp_set(struct ocelot *ocelot, int port,
+		       struct kernel_hwtstamp_config *cfg,
+		       struct netlink_ext_ack *extack)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
-	int ptp_cmd, old_ptp_cmd = ocelot_port->ptp_cmd;
 	bool l2 = false, l4 = false;
-	struct hwtstamp_config cfg;
-	bool old_l2, old_l4;
+	int ptp_cmd;
 	int err;
 
-	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-		return -EFAULT;
-
 	/* Tx type sanity check */
-	err = ocelot_ptp_tx_type_to_cmd(cfg.tx_type, &ptp_cmd);
+	err = ocelot_ptp_tx_type_to_cmd(cfg->tx_type, &ptp_cmd);
 	if (err)
 		return err;
 
-	switch (cfg.rx_filter) {
+	switch (cfg->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
@@ -577,27 +572,15 @@ int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	old_l2 = ocelot_port->trap_proto & OCELOT_PROTO_PTP_L2;
-	old_l4 = ocelot_port->trap_proto & OCELOT_PROTO_PTP_L4;
-
 	err = ocelot_setup_ptp_traps(ocelot, port, l2, l4);
 	if (err)
 		return err;
 
 	ocelot_port->ptp_cmd = ptp_cmd;
 
-	cfg.rx_filter = ocelot_traps_to_ptp_rx_filter(ocelot_port->trap_proto);
-
-	if (copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg))) {
-		err = -EFAULT;
-		goto out_restore_ptp_traps;
-	}
+	cfg->rx_filter = ocelot_traps_to_ptp_rx_filter(ocelot_port->trap_proto);
 
 	return 0;
-out_restore_ptp_traps:
-	ocelot_setup_ptp_traps(ocelot, port, old_l2, old_l4);
-	ocelot_port->ptp_cmd = old_ptp_cmd;
-	return err;
 }
 EXPORT_SYMBOL(ocelot_hwstamp_set);
 
diff --git a/include/net/dsa.h b/include/net/dsa.h
index a0a9481c52c2..55e2d97f247e 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1131,9 +1131,10 @@ struct dsa_switch_ops {
 	 * PTP functionality
 	 */
 	int	(*port_hwtstamp_get)(struct dsa_switch *ds, int port,
-				     struct ifreq *ifr);
+				     struct kernel_hwtstamp_config *config);
 	int	(*port_hwtstamp_set)(struct dsa_switch *ds, int port,
-				     struct ifreq *ifr);
+				     struct kernel_hwtstamp_config *config,
+				     struct netlink_ext_ack *extack);
 	void	(*port_txtstamp)(struct dsa_switch *ds, int port,
 				 struct sk_buff *skb);
 	bool	(*port_rxtstamp)(struct dsa_switch *ds, int port,
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 6db7fc9dbaa4..48d6deb3efd7 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -1073,8 +1073,11 @@ int ocelot_vlan_prepare(struct ocelot *ocelot, int port, u16 vid, bool pvid,
 int ocelot_vlan_add(struct ocelot *ocelot, int port, u16 vid, bool pvid,
 		    bool untagged);
 int ocelot_vlan_del(struct ocelot *ocelot, int port, u16 vid);
-int ocelot_hwstamp_get(struct ocelot *ocelot, int port, struct ifreq *ifr);
-int ocelot_hwstamp_set(struct ocelot *ocelot, int port, struct ifreq *ifr);
+void ocelot_hwstamp_get(struct ocelot *ocelot, int port,
+			struct kernel_hwtstamp_config *cfg);
+int ocelot_hwstamp_set(struct ocelot *ocelot, int port,
+		       struct kernel_hwtstamp_config *cfg,
+		       struct netlink_ext_ack *extack);
 int ocelot_port_txtstamp_request(struct ocelot *ocelot, int port,
 				 struct sk_buff *skb,
 				 struct sk_buff **clone);
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 5c9d1798e830..082573ae6864 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -116,19 +116,15 @@ static bool dsa_port_can_configure_learning(struct dsa_port *dp)
 
 bool dsa_port_supports_hwtstamp(struct dsa_port *dp)
 {
+	struct kernel_hwtstamp_config config = {};
 	struct dsa_switch *ds = dp->ds;
-	struct ifreq ifr = {};
 	int err;
 
 	if (!ds->ops->port_hwtstamp_get || !ds->ops->port_hwtstamp_set)
 		return false;
 
-	/* "See through" shim implementations of the "get" method.
-	 * Since we can't cook up a complete ioctl request structure, this will
-	 * fail in copy_to_user() with -EFAULT, which hopefully is enough to
-	 * detect a valid implementation.
-	 */
-	err = ds->ops->port_hwtstamp_get(ds, dp->index, &ifr);
+	/* "See through" shim implementations of the "get" method. */
+	err = ds->ops->port_hwtstamp_get(ds, dp->index, &config);
 	return err != -EOPNOTSUPP;
 }
 
diff --git a/net/dsa/user.c b/net/dsa/user.c
index 804dc7dac4f2..e9334520c54a 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -578,20 +578,6 @@ dsa_user_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 static int dsa_user_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct dsa_user_priv *p = netdev_priv(dev);
-	struct dsa_switch *ds = p->dp->ds;
-	int port = p->dp->index;
-
-	/* Pass through to switch driver if it supports timestamping */
-	switch (cmd) {
-	case SIOCGHWTSTAMP:
-		if (ds->ops->port_hwtstamp_get)
-			return ds->ops->port_hwtstamp_get(ds, port, ifr);
-		break;
-	case SIOCSHWTSTAMP:
-		if (ds->ops->port_hwtstamp_set)
-			return ds->ops->port_hwtstamp_set(ds, port, ifr);
-		break;
-	}
 
 	return phylink_mii_ioctl(p->dp->pl, ifr, cmd);
 }
@@ -2574,6 +2560,31 @@ static int dsa_user_fill_forward_path(struct net_device_path_ctx *ctx,
 	return 0;
 }
 
+static int dsa_user_hwtstamp_get(struct net_device *dev,
+				 struct kernel_hwtstamp_config *cfg)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+
+	if (!ds->ops->port_hwtstamp_get)
+		return -EOPNOTSUPP;
+
+	return ds->ops->port_hwtstamp_get(ds, dp->index, cfg);
+}
+
+static int dsa_user_hwtstamp_set(struct net_device *dev,
+				 struct kernel_hwtstamp_config *cfg,
+				 struct netlink_ext_ack *extack)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+
+	if (!ds->ops->port_hwtstamp_set)
+		return -EOPNOTSUPP;
+
+	return ds->ops->port_hwtstamp_set(ds, dp->index, cfg, extack);
+}
+
 static const struct net_device_ops dsa_user_netdev_ops = {
 	.ndo_open		= dsa_user_open,
 	.ndo_stop		= dsa_user_close,
@@ -2595,6 +2606,8 @@ static const struct net_device_ops dsa_user_netdev_ops = {
 	.ndo_vlan_rx_kill_vid	= dsa_user_vlan_rx_kill_vid,
 	.ndo_change_mtu		= dsa_user_change_mtu,
 	.ndo_fill_forward_path	= dsa_user_fill_forward_path,
+	.ndo_hwtstamp_get	= dsa_user_hwtstamp_get,
+	.ndo_hwtstamp_set	= dsa_user_hwtstamp_set,
 };
 
 static const struct device_type dsa_type = {
-- 
2.43.0


