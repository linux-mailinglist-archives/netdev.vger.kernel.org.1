Return-Path: <netdev+bounces-151383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31B69EE86C
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8BC1889188
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EE921576C;
	Thu, 12 Dec 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m1ZKK3gH"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79C2144A2
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012529; cv=fail; b=RaGkj87A1l0szyed1nfjPdJoRZVEH8+wWgHpWHKxDRkpIlr3NovNCbexYCfcJQr1F3JmSB2f+IjNkQapZJu8XLlFK3JmfFmVa2b7NXv1fPdbBdCCXMnD+UgJmYjOaPu0itfhcCx7sVQggUGXfqtPNsseB2EaBQTHWnSYW4SpRNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012529; c=relaxed/simple;
	bh=gLidDEWrzwqnOGkhb25NmD+f/+CLhZy90e3Olq1XapM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bGNcJnrcKhjZc5pI9D9BoJLAaDxwMdg4+VwYB64LZBdPygG/SOZxLiU+A2EztpRMYWH8/IHNmpHfYttXoJwhaMIvBFGbEA6JZR7RQdCrJkACKKld1WTgVA8o+8LEvXzJKdVrUgVedvzfeLaw7YwQM4oe0JKaVUvbhTI5bdozjvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m1ZKK3gH; arc=fail smtp.client-ip=40.107.159.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lz8FklMOLmXJ6TsGJ0M4FwdsGt0X9v+/GM2bLalM4Bivw3nFQJP9TcrETw4s89P2A+FCAmzfXqJvfCDZ0HHUDNh910mC0ObQGJ2KHId/gUVktifQIIMwxJiBRlEWN3XX+jO0NeylhOz1zmUizRfaRQ/7focA2eLLhx3TJS7j4B+Rk1bXuwZAqCI+4EoBWrSf5Ckt8qdAN3KJAb9XUt2aKPsEkWqTEugsbBDshNPml5EpfLf6+M4cGpzcxNXzlixJq+2+WN7IpmmhZn/K7F3j3AP53telCeEGooWfKJ2yAL6/kAVSJV/a6NoT98CehTQKWjFSIPraj9zf2kyTTyYEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyDAAskNd+4MLJafa+eSg0txv8UkZ5iWuf5N7IQLXBg=;
 b=khM5POZZwAY5Z1oI/xnoD3uttF2VHXxlnI9c+GeDavVQY+VBdrgUxqd/bL4dhbQBhla7RvADK0fWhKswmKcZB1RErLVCpancbGT/8b597P1zM0otglnWSdL94huUZcvXtanGGFD8B+N1E2FsGEuGkvTcqyRTvQGezulB6oE9mMJL4IKFWQX/dPl/3sw/nqunab48ZWTYtZ0/s5hfIVnxAeMaVQcGgZ/I3G0XFTmW8Wu7ZP0hxAoF0QCuYASjQPjj6Bw86wKPeNhPFyk+/5TNTVX8i8lZT+htChhckyvAfP1uaxva4EikzP0we7/E6rMmaY3N/Z/h1znsibNf4i7mRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyDAAskNd+4MLJafa+eSg0txv8UkZ5iWuf5N7IQLXBg=;
 b=m1ZKK3gHnxcuGVVDjklVlmLyqFMEuzQzRNUgU5o/nsFDEFsMg5O5cljHbGJgvC8GTebw2lRPUIdkLrxRUWEEGSB+ko3Fstb1EjB69J0rPDfhffS9B9QuuDef2jbbA5rB82if8y7qt2adRo9J7kAAPI9kx1dymglpSmJJww2cq76YmyX+NnTPP93tTQTeI4KJMIVjD6y28AgZz14AIC5rV+vrlhQj5IZ6k66SM+GC9RfBNGhpgfME8IbX29DSVWpYQpjVgRXh/xuJ6ZxL0B2mZWT35S3GsXH4rf6k0FexRNaLuqIrEd0hoBWGFedSlk/9uUdG7YPGn6hpAxyI7Uj8/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7655.eurprd04.prod.outlook.com (2603:10a6:20b:292::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 14:08:43 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 14:08:43 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v3 net-next] net: phylink: improve phylink_sfp_config_phy() error message with missing PHY driver
Date: Thu, 12 Dec 2024 16:08:34 +0200
Message-ID: <20241212140834.278894-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::19) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea4abb1-afe4-4665-e46d-08dd1ab67c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5qQtlba3JrkYUBhafbITU6B2YwaK8gGaIt3pM/PGTfsUpr2fzBlinf/H/3Rb?=
 =?us-ascii?Q?W9ViglS06bXozoTFJJlhgCPiJ3PsjnhkiOVwVuJuCleV2Jwy7X2xPwoMrnQw?=
 =?us-ascii?Q?ENBa7bYwSTzj/xusAkXAmaYUonnPAF1GuFeerX3NXc/WtmW6mmcmlzlWtq6i?=
 =?us-ascii?Q?QNCEGfoUJheLoVSlOb9w88Fw/gCsb/FW40crh0e9Z1KF7s5X5RijQ7pyBWPR?=
 =?us-ascii?Q?1Nrtdw+s8sjnNa1vg96hmrTiTZtn4dCNIzEcDwQBrdJQJdiZJai5KVJd5AgC?=
 =?us-ascii?Q?+Wq2xmECjWvBSTV5bQ94e2To5zG2MpjBdicvHgzKDhZXhhRH5v91n2w4LnS/?=
 =?us-ascii?Q?n32MYT3jiu3/nLvKPRMYB6CCf0jijbTIFtZ5sQ9EFaArX+yODcJLs6JbAbep?=
 =?us-ascii?Q?9glxqxQb/9sQOzox6wuRVQDZVfQP1NqUqm7V5L27gOCmVFqej7ebXrErmdY7?=
 =?us-ascii?Q?rgybxsV0HBf3aSzYOZ+u7KkqBVuDv2OjCx8+q4b7hGbL4PANxnGNhBJ94vkI?=
 =?us-ascii?Q?fnEKXMyS2R5c941uYe7TstQ5CjPawi8lrY414Pde6FiubG2+qBhOMYxOl/uu?=
 =?us-ascii?Q?58I5R/FOByi/ExtvhfUQHS/3RWCY92L9sR9Pi6KfBpXV2DkZcUp6CuUASt+i?=
 =?us-ascii?Q?IBfFVStfHZD/+/q41guPQZVXvwTi2dgI5NohDbS8hL/S6QM2G8CuCpCV804n?=
 =?us-ascii?Q?O6P56/mrDj6pCuGTWlUT1f5p8c7Gp3519+ZtS+JY8zca6Q8TzXWK4+zmhvW5?=
 =?us-ascii?Q?YXKtgwUDuKk3wQIK6InklZf/WH1fRZI3hYZ90TUzr3xH/zWlD3QFCgZ5EKNk?=
 =?us-ascii?Q?FUU1UlmXJD+EyjwfwaOCu3j0SVst+BVQzkX68bU8GSPAJSHGWfMNR645Alp7?=
 =?us-ascii?Q?h/Cx+b0MIq8R4gv7btlwKVO9v5fEfgoea/eJgCHB778XP0brTsVgqw7YMvje?=
 =?us-ascii?Q?BdS8b9PG89jvVrRza3rDPmHF6qY7ufaPAEcM6ui6IEaVYboKtHtk0Lm7TLGr?=
 =?us-ascii?Q?17mtlBb+1hCLhMAjkGCGCa/GIjujYAFErLAojy2x9LjwC9L/PvEwB8bJ4dc8?=
 =?us-ascii?Q?xXU8Mai3PbFN0u4mgZr5ZRYoiZCLXSSlDt7TFfolY0uMy7eo6muu+SHJWkmG?=
 =?us-ascii?Q?BNfU3arMi5QthIm1orBtQauMpgRfYhF/QQcSBs2jFndgnKH2TlHV6mjqCt2i?=
 =?us-ascii?Q?4XIP6guWaaZcG4TcGAanD4eSViHR4zhKRMaVwMFZ/tUUvJSuUIDSdZsyvEsx?=
 =?us-ascii?Q?Or24F7SaaBDEFPl2i6cLTEYoaAbneaO7ulB7Aj+HEOH+ottBO3ILqKifkIGD?=
 =?us-ascii?Q?mdx/Pz62Y2qWc3+86cMmODxzYPLgySTl1VJWBdWNMmzlQZ1xsU9+GRNpUlzq?=
 =?us-ascii?Q?BUC9aGwoVQ0CbVDZJs78RfQmad1kzxR5SFOlTohwT9CO70d+jA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3HECfLDBjBLvtltYJH4+8G5vTGYIarwcxPWdJF4s8IKnv1eCVh93vMDGTMH4?=
 =?us-ascii?Q?4M8dEDsKFBn4ISFE4nEOWl+JFhppXzmodjr/8cBKlRUYPEu5TZ3U2+7Ycdkj?=
 =?us-ascii?Q?r2HSdEAZxZz4ScRIMz9EgpCfo5JXHiN+5nAQFhUD+TYXA+4flx7B5fJbLUak?=
 =?us-ascii?Q?+T/6KwrmeNNZ5TwcNPH1lsSouObjun8192wpMAkfPQzBWvM4GhWm72FeQrRk?=
 =?us-ascii?Q?ciQQ3n1M0+xHoV8cSz4CUxKIu6k+l1N0Rh4Ao6JkR2Hka8QM85ECqsokMEFB?=
 =?us-ascii?Q?qL0yoiEM8vXRrS3NPo+wW2x2VTk1FJeUmGAi2HVetYU36umqdn5FbluhI4ti?=
 =?us-ascii?Q?n82YpwUHo/Px2h9h6agNRK8rW4xwkPXV1GUdyo6izKZStK9QBtdbCTWqx5ZM?=
 =?us-ascii?Q?Jwigw4h78RgLGavpdC8JZBewjndJ7FtIfI/rBtPHzb74d/SfduSCpdYNbgN0?=
 =?us-ascii?Q?Ojv2wpanxQOQD8pQKL/kCBJdnNd4KQtTC+SVpXbwn9c3Fd/XRfRmwteqylbN?=
 =?us-ascii?Q?TMwHZD4h9iq7rUxVdFqdpN38w7PmE8c+C2pqJqDNjPh3W5ldQpIbv1I6KyjG?=
 =?us-ascii?Q?p5/lU2b87gkRLsDW/zYd0uCwDAbNF7VGDY37P9P6S61Agqow8D+LDajJhKbI?=
 =?us-ascii?Q?G+pP+KHRvQaBG6/7d+UH9nmUE7pIC0ouRB8U3EaU3VElNcAShxHGAUtRo3ei?=
 =?us-ascii?Q?1xx6ZrAfN23kCjLgUSogq2fHoqi2lrtofEV0tHg9iv7nDpnBh/W8ZI0CXqhx?=
 =?us-ascii?Q?WB69IH9D2Xw5V1PzENe2oa/wKbzgbvrbNk9zqbFcJO+xE3Nn8ZFLGUFoGIz+?=
 =?us-ascii?Q?sNoWlcBmN78DV/y5LUTd2CsKIjMFb2dXTHMTlXVpVt+mhPl8i6RvpzYpPM2H?=
 =?us-ascii?Q?Uq4B+YAUJOhAdBtz8sZPmaEELaFWrKb8P2H4LIdKVjusGLxgxI61SST0MQnP?=
 =?us-ascii?Q?0Mt1Ab52EGnLyOdUypioasm4UXlhZLuFyNgjDVp5m44y6wGBtzMV0LkqVrih?=
 =?us-ascii?Q?7CgDJGK1I4nhJjXEED/dfPLl0jwgDemeFIvOSSQ2nU4gabzbDFp3HLg4dplq?=
 =?us-ascii?Q?slj07f2eLhwD2Tpk2ZGl11Pg/yzZpxuFha2rUNzaHVKeyB48wrW3EtbvZDdm?=
 =?us-ascii?Q?Wf3KEJdfhT863oDzcsoLfyC0d9pab2zShuq5mM2JXCd0n/zH5H7CPhYWj777?=
 =?us-ascii?Q?5bZc5bmTQ8LZDNqkbnok0Lt3gsfYOTmQSgylO2AgQNBOMqmT25YjtZlxGWl5?=
 =?us-ascii?Q?HOtKtqTzjoXzIsWWz9JzY43tkpUCPlrJ0I4WOL6ea9XTHngUM3f6YTGIoFcj?=
 =?us-ascii?Q?YqcKHdJQFmMjKGtLrTE0M/rC3GQ0FssL279y/9B6kiTAFb4E9wResHLL3YR7?=
 =?us-ascii?Q?D0vzs+1lE5yT5x3f0YPnJniRUGQwfVKdzETvp6Zs8eMHwN/0Ffa0xKBF0eER?=
 =?us-ascii?Q?PgVqvrVVrudemLt13zx0RxlEXFENjDORmcXi+N3dyWSfhHVDZTpMF1Ue0MhY?=
 =?us-ascii?Q?T12DKE8755U8h2URJAbIpqlgakzqP/bxY1vQxoJCZqtORaluVt2JGbRlxWbV?=
 =?us-ascii?Q?KCb/yRFstnpUy7i0kaaqrE1nji14nbhwLwU4D/rDpvKBAHkldCMBqk0t1Ecs?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea4abb1-afe4-4665-e46d-08dd1ab67c87
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:08:43.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yT7k2Sq54oUgCqkyITKrpSYaInBsHbY2ymTEq1rodUyvbdYlD6ZKQDng3uAPKUCFyvDBmhnTTLAngWafLAN4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7655

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
phylink_validate() fail anyway, and that this is caused by a missing PHY
driver, it would be more informative to single out that case, undercut
the entire phylink_sfp_config_phy() call, including phylink_validate(),
and print a more specific message for this common gotcha:

[   37.076403] mv88e6085 d0032004.mdio-mii:12 sfp: PHY i2c:sfp:16 (id 0x01410cc2) has no driver loaded
[   37.089157] mv88e6085 d0032004.mdio-mii:12 sfp: Drivers which handle known common cases: CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY
[   37.108047] sfp sfp: sfp_add_phy failed: -EINVAL

Link: https://lore.kernel.org/netdev/20241113144229.3ff4bgsalvj7spb7@skbuf/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: test specifically for the NULL quality of phy->drv, to avoid the
"maybe" in the error message.

v1->v2: add one more informational line containing common Kconfig
options, as per review feedback.

Link to v2:
https://lore.kernel.org/netdev/20241211172537.1245216-1-vladimir.oltean@nxp.com/
Link to v1:
https://lore.kernel.org/netdev/20241114165348.2445021-1-vladimir.oltean@nxp.com/

 drivers/net/phy/phylink.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 95fbc363f9a6..6d50c2fdb190 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3623,6 +3623,13 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 {
 	struct phylink *pl = upstream;
 
+	if (!phy->drv) {
+		phylink_err(pl, "PHY %s (id 0x%.8lx) has no driver loaded\n",
+			    phydev_name(phy), (unsigned long)phy->phy_id);
+		phylink_err(pl, "Drivers which handle known common cases: CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * This is the new way of dealing with flow control for PHYs,
 	 * as described by Timur Tabi in commit 529ed1275263 ("net: phy:
-- 
2.43.0


