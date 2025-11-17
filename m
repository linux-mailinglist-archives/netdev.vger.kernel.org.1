Return-Path: <netdev+bounces-239082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E171C638BD
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C943AD68E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5875E328B6A;
	Mon, 17 Nov 2025 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mmL45psH"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859A32825D;
	Mon, 17 Nov 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763375400; cv=fail; b=kaZ+zF+hsn5pZz1hW5cpTxYWoM1clbGPruPvPqnJnTAHo612yvWWgp2h5buHBXCYvmIiiqX6bH+FiJ0X3YiM5YeBkLmCdG5AbSZIXi4t6/VBZfHak4Hq+JHVmv9iSDz2ajdqpduM/I/DliqU8RSsR8wmo9Hy6d68JVbsk02vgTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763375400; c=relaxed/simple;
	bh=ebExVToGt69TetFtkeRwXxQboia3Vi3wH217OiMmsKU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=t/s1/PqxCseDEdmEq4z6x7TdDfeHleNQorhS97gSS7uJFhLoX8EV+ryxC+Lc6ig8gtQrSAEuPSpm/WliQuCtjFNTpIlRd0jn1FS2nm7YqtwclZF0RHP/u6KxzIubnFao2cWf0pd66GO45lN8cZ+mMpkMjTPrv7/pIfB3rkqs76E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mmL45psH; arc=fail smtp.client-ip=40.107.159.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXQzlUq6MRVdTRIlafJwdIdH5DlJJJXVw4n0q+E11hz5HyVFffv/VZNpmzsR+znj2Hu2xVBNtOUjlPK09yKCM1ixB96ZVNdJluMeQnzNuklGHS7p4+1fkIzkhf/pxGTDZNHElnaCdNPMZ1AGgP6RVVo67COULvMQxPQ/wbBYpxb84AEr9qN54P4TLPX1kjwbYR2umCfXdNzrPgqxgrXUNoYnL7lmfTgub+dx/e6AWQGnjUAe/4ZsGlXNH2+Vfnr6ScCyCF0/0MhFLzZR+gE0wMcFCUrkxgsuisvyuu322+F40RRUyi10Q/3hRN+LlY9v4LcC78DfyDxaFRKrceruCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1GaAOFydlpvX7Q0/2IOU6FvYN9GcRZZZa073PnCyMo=;
 b=bPt4R4+hpUGMK0Oda76+qkPzGE+mtSRyiQ22viuOPL1nwkT2VCww+HReBlOHP7oeulj0txHxEBQvn4m8cYkHjIQ9G17hWypo6olgzz5L+FgjD6j4gvpe2aY7E6Tl79vlu3tPdPOwgu2fMXlzXw50t/u8DO41AixBtR7EUROdwTSdIW5YCBdaplHE/p9VFHEWIYZEceg4zG06kz7MGWpL7TISnL7XdLbCwfWUR8vJwTmmx4yZ56cPvZ6Z9mARsUUH1zxZ32FB6hNUWn16oqsLobUwQTF+TdjZaFts6SmxJemJZ8rJc0ermDojjE2acUin+vjMsKUhTuST5M7s8QOV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1GaAOFydlpvX7Q0/2IOU6FvYN9GcRZZZa073PnCyMo=;
 b=mmL45psHqfakB1sRWOMUIhA4WVvMm6gXmrss9fqoFHqwJEBm02LsqDGL8BagDfcH99Grx/WQdmnwHEJncIBIRtO8Ht68v/HYWPcFJJCrdPc4tHe7R35dS5t0BqVJmFCVRo3IuGq2bjVjuk7Iyveyl9TN1aQGN96QtHBagf3waKSPPd5KJnDbqkMWe2XvsklVMdC0jt5XBn0KoUYFd+p2lWyaYjusYhT2ARXELyESZi17Aj77ZlWspwbrSu4DQLwOLaS547bnKr3BhEDD9I+z7uyxJWVH91k/3/PTQkRGUxg5ZbDCZyU1X9Zz/mrl/aTf6OdEgFIsWEnOons8IJaAZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9728.eurprd04.prod.outlook.com (2603:10a6:10:4e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 10:29:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 10:29:54 +0000
From: Wei Fang <wei.fang@nxp.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net] net: phylink: add missing supported link modes for the fixed-link
Date: Mon, 17 Nov 2025 18:29:43 +0800
Message-Id: <20251117102943.1862680-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DUZPR04MB9728:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b00560a-0508-409b-40a9-08de25c43fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X5ZfmMsk59UigVrhSJ2kAhGhHO4MH5umfAet0aTA2yOayUh2AxUpNcIhCAFy?=
 =?us-ascii?Q?AXq5eHXFzbpoHjxC3PlPmu4G7ytgxmjDg1P+ShYQms7r3tUEpHrulm9aBKNg?=
 =?us-ascii?Q?Peo07ck9V+xXyH0IWi9+UYWs+WOjME3rVTXgEOww6GCxF6z5Zt6/zsWUuyyk?=
 =?us-ascii?Q?DMyTcM5o5JA5Mm7uMaRSxlZ5xKpBAzlOscoLVaXj5htSPhwpYNkSCO8k9YnS?=
 =?us-ascii?Q?0BMuMPnB4T8F0qeXWGkhRayHyCRuzQxAhEQ6+9U0Pt1/zDgHKefKu+VkR/Af?=
 =?us-ascii?Q?a+4+S6wPIQq5isZBDmYQGPFWc1zCmrbDWiMTVEq5outiANx7a3VYaRQphqWu?=
 =?us-ascii?Q?hZen7bPZbuZl6+dhhnY8pLbN4W/klO+Mxb/iEeVcKzKyiIW1M6M8dF+pLdPX?=
 =?us-ascii?Q?TCsj8ozIGUhRk5qPjuUmf/dRqCwQdXOqd9A4GTQe19SPebbDqeVM2WIGZidN?=
 =?us-ascii?Q?NFsO9NjkumjFpmvdGqZ6pgKsDirCJqBoE0wFf+xTpmLcw5WCmNPhnBYVx+kK?=
 =?us-ascii?Q?IIR3S2iDP7OJemcDUiEn5w4WPiIsnqXgT53l832Y+jBHfgsNwyc7vgimLPP7?=
 =?us-ascii?Q?MCugV0G0fXnvAMbsbx6GhXY6IwmTKJtrGLe39W0T+4bdvdAeVrp4qUPwSVsW?=
 =?us-ascii?Q?STiG4ESkdI6qsS7TVH4Sdabme36G6mXiya7EMtMLE7pa2d9tqxr19L82ca0n?=
 =?us-ascii?Q?UIX2SkRTzawTGEBMqEXMeWnypePoXNVGYAnZ0l6E5FD9CtgQ9SOYNAptsORW?=
 =?us-ascii?Q?IlIbgwx48WGjFhuG8+O37LfBDpFa7Fo3sJhFNnDJz2xOOBoCxd2AMPvAqDHa?=
 =?us-ascii?Q?oSPKC8KXUcO63yrIGHnx8o4pv9Gq1BUfN3aBzal8lvAEuyRaVBAPr7nZPxRW?=
 =?us-ascii?Q?cJZJB4ZiMPNNrM0aZTY9D21m8EV6tk6lch+5rMpRD1TsDv3A14NzMuvXTO1H?=
 =?us-ascii?Q?ur07eZwEWlWk396zR4xxH604trXyH1YCXDlJJakKMiHYHqQrQ2D7iogbwHLN?=
 =?us-ascii?Q?AOtyCOzUjPwmGWwn5uOCLNwNEZZZokJOeJpvggXYKLHcfvMD8WCYLidcF8Fg?=
 =?us-ascii?Q?UCtvlfb0Z7nPH08f7tNinPn8/9fjU02cbHWa50XeFADJJ3V3ZHium2JyJqw/?=
 =?us-ascii?Q?EBdl6d3XJkJu17grWyO0P9XEcdstcNWMmSP/mWdfr5s4KDJDutoV9KACLOkn?=
 =?us-ascii?Q?/je1ZHiHXWzxpXtV5oIi1YQ7U+KRQehz1hd8NcQKGswtfeVnoxg0fjSIcyE2?=
 =?us-ascii?Q?q/9OPCb3Oa+eDWGUPb+Yo5NB1IGuzyARKHuYzthkoUJXWsfTApj9xQGIyU1u?=
 =?us-ascii?Q?747rMdmYgOGZxKEknu2Pmbk60iSyCHDMTtrd6y+jKGmJcVQiQaF6APMUpxkY?=
 =?us-ascii?Q?2oJGmRavg4LfOp2y7l/4NLbIa0pmLDI02QTeqLQLx3depN9aLcxY7H7FD0tl?=
 =?us-ascii?Q?AwWnmx1vZTaSmtklJAyu7m9HxRk/R2XrPKa6LVLWn1ZCczb9qQ5c6GGB6sfp?=
 =?us-ascii?Q?3ik2nJc0hKAZEZ4Gt3dzWRERUWzj11FKlfPWj8fKCWypX5HLc6eIA/xV+g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H3aIvHcczChNJ/JrJXRw04FMb81QrVa2fxtIZjpRyKoPWhna471wr0Paij8M?=
 =?us-ascii?Q?fVeWdN+iqLbQ3vjz0BgAgchkPtkqo55a4e5LfjSKEweZ2mCinVuF0YYELIgR?=
 =?us-ascii?Q?vdexQMUIYVNw5duRaSvG31dvM+/PA4vhi+OGYVykU/fhJKlNU+ktw4vGrRPL?=
 =?us-ascii?Q?+YpSi9XnFY4w0DX3gJg93ZFNtgFaJdwwoTPxtztLCSnvZAL4+usBiZaYlu62?=
 =?us-ascii?Q?XSrcmNCNVqS+HZUJJGdBdzRQ+1yedBNPDku9Ese2YRkIdlayyPmErueFWm4C?=
 =?us-ascii?Q?R+/qmZXzGl1lN/9WPqvxyp7zy0dtT7nQw+zJ+tAKrR7QwSpahwORBXQOcz6J?=
 =?us-ascii?Q?gIX2RDUyrCfkVy/3dFNmazoK/mn4gsRoQlQOTaV1WFaLVKqZeMeVDsbRsDEV?=
 =?us-ascii?Q?jJ3qNohpqGY/EbE6q8IoBHae39WzWTyF8Y6M5U4qi+PthO8+BH/IYPayXPtc?=
 =?us-ascii?Q?cNsbdh47zZ7Wq5W/q7bf9o2eXL/3ObL8hWCpFrqEohd+uqrfGXDKU0MovsiL?=
 =?us-ascii?Q?OgGQ3VP0hENIgAal6+g++/3+4vl8m3KNJ16GBjIRUjmJ75AbWY5AiVaCoUup?=
 =?us-ascii?Q?AFgblYUbZ3oW8m1CY5YAgVm0imDlv2RehObhxY/DZdtY0ynIPv23fE63RLim?=
 =?us-ascii?Q?13rTJ6FCMOpvkid7Sv/HT5vtJ/rUGXDzyhBbRzyWsRnHPw0LKA7ui0yr80j7?=
 =?us-ascii?Q?PwwgKFL4mcMPstfP3ypgL68Byumsec2cbsOFT4OEvIBz3gP+ETncGV1f6qpj?=
 =?us-ascii?Q?YEUPoKLVDi2+BR4dQSK1JeVxBkRBzZD+O0AZISf5sMCnsxoaKAld6htgV5uy?=
 =?us-ascii?Q?bevOS3L/fMNq2y6WwiBxBg6IBAYTjcjSMM3luknghoJffMpdRShUsISSD6h4?=
 =?us-ascii?Q?oWuq1McxOPevvFygsgnXFnurpwXiplEQqhgDiAJOz2exjsZQ8usjPTE3Pq6p?=
 =?us-ascii?Q?f6A5xaPVSTzOa95NcA8u4RTu6jRnJJ5YS5lSTQ4TrKkL6WkGC4uGXwzqas4T?=
 =?us-ascii?Q?bkxYxKYJF/LoGNDna8lPz3LgnIL1khCnji2bsEGZyybPWj9woNLh/+mPnenf?=
 =?us-ascii?Q?47gfb65El/CaRAOesxGMvE8m++mLOQ2o/eLD+BE+/THDS58fJU/2FUp3CVMk?=
 =?us-ascii?Q?rnhh9g4PEREoAnUSd5iUr+s2BwMmnljFPaaK2Nue8HVpvmbZpa2I9Os+TGWM?=
 =?us-ascii?Q?xt24Oq6NnjGYliC3DQyh3p87RZVZKa84Jd3L1szrq66Glfuyn7V00+mWiTTC?=
 =?us-ascii?Q?AwwjRKtu2nezTwJ+hX1/z+u/vrgqYXVMPJ0iNlkx7gKxLH/CmUPA3wSwACsO?=
 =?us-ascii?Q?yaRXpoJQaJqP1yFaRkMq6MZx45pIHN2qjjKUQKDpFPHhSwz7nM7LK8a+F0Zd?=
 =?us-ascii?Q?OwxykVM2gz6q3gy8L1LIC0sB+nicfpHtR5BUgJCDJ6IqaTOHU1ITsIEDFkra?=
 =?us-ascii?Q?gKQvFWOd1ZQxxBO+AXVR8LNiM8tN8Ax1LkH3m7s1ZJnOmjICbH5P2Khf/8+y?=
 =?us-ascii?Q?z+mtlYqJ09pHuyFfrleyxbYeACtIgoz/NxEv91sigqgmhEoudOlpzDUK6O9q?=
 =?us-ascii?Q?u5s0Kvsm6onYM9R7F9xpw6bRMSvychQJGcjKzTTS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b00560a-0508-409b-40a9-08de25c43fac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:29:54.6643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xud/2g291iMC5Z3P6WAA4ip6rGEQHpUP6+5o35F0gpm3n0/zR3xvWuF1rD0KWZTSTq0vOgS4t5FWi9zV511qNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9728

Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
initialized, so these link modes will not work for the fixed-link. This
leads to a TCP performance degradation issue observed on the i.MX943
platform.

The switch CPU port of i.MX943 is connected to an ENETC MAC, this link
is a fixed link and the link speed is 2.5Gbps. And one of the switch
user ports is the RGMII interface, and its link speed is 1Gbps. If the
flow-control of the fixed link is not enabled, we can easily observe
the iperf performance of TCP packets is very low. Because the inbound
rate on the CPU port is greater than the outbound rate on the user port,
the switch is prone to congestion, leading to the loss of some TCP
packets and requiring multiple retransmissions.

Solving this problem should be as simple as setting the Asym_Pause and
Pause bits. The reason why the Autoneg bit needs to be set, Russell
has gave a very good explanation in the thread [1], see below.

"As the advertising and lp_advertising bitmasks have to be non-empty,
and the swphy reports aneg capable, aneg complete, and AN enabled, then
for consistency with that state, Autoneg should be set. This is how it
was prior to the blamed commit."

[1] https://lore.kernel.org/all/aRjqLN8eQDIQfBjS@shell.armlinux.org.uk/

Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
v3 changes:
Add Ressell's explanation in the commit message
v2: https://lore.kernel.org/imx/20251116023823.1445099-1-wei.fang@nxp.com/
v2 changes:
1. Improve the commit message
2. Collect the Reviewed-by tag
v1: https://lore.kernel.org/imx/20251114052808.1129942-1-wei.fang@nxp.com/
---
 drivers/net/phy/phylink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 9d7799ea1c17..918244308215 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -637,6 +637,9 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
 
 static void phylink_fill_fixedlink_supported(unsigned long *supported)
 {
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
-- 
2.34.1


