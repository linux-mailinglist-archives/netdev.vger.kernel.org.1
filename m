Return-Path: <netdev+bounces-178350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBE1A76B3D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8363AEB1D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6AC218EB3;
	Mon, 31 Mar 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SYXoWuZ3"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2049.outbound.protection.outlook.com [40.107.247.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77E7218EBE;
	Mon, 31 Mar 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435565; cv=fail; b=Z+avrlWMIafFO+hID/PFZDYcwcGuQWknDYuG679rIP7qGe+I+k8oyf3dKexkeBfm0tap5WHEh9m4KqPKIRXmmI/dTP2rtjHs0yGj9RvEMGibGq1uE+oJdAqpYhiucWdx53FvBoeuNKD0TVHBviS+Ria2VhJKz5p2oSTxIjKj2kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435565; c=relaxed/simple;
	bh=CHWkmzpLKDU5qrd3PWC5/ezaSVvXyCMjTVbNiWWefLs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=olGAFTvDXo4bzGqAK8Nbjqc4QvwN5qF7mogGlQLYe1ipCFHVPGlBDVBnxZ5/TQTXLaOzVZ1eOjBoSydqehCOXiHDEKmR32ILjGZCTSvk8an/nzVkK3N9zB3YNCmZ/CTdFi6pk+5tQBDbq2On7ACe/oEE3yv2DzNWjNkepdVHF7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SYXoWuZ3; arc=fail smtp.client-ip=40.107.247.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obuOJLEf8sUw3gRnt4h29PDxMCb+fkfBiqhckv177mPbaxkK00XJQCvvH1nblYm8ScSGXRI7rL6BLx3i1AuuABZ9gUu15bSn6zW5D0qUeePMRgTx1Oo0yNKz6LlmtYfavXQa5gdFqWqR9mIDe/957XEU8qhr01ytKyFveEHiIeikQeNonoWtBxyKF0MNm72BOd0+zmZZLGx0aJOH5qaf15Oy4BzIeWhDntmanVopuBExRhlorSTT0m0RWoQ/mhqvZwrBoa7S9z4gnzO/MBRleAJpRRbKZPsgA9smMuV44s6d+NsBmW9ov7AGq70HhQBYRXGBNc275AqiSUOtcVAWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y95unQB9meFHPmFlKQuD63xkRywz1bRc72oY0lHQRvE=;
 b=IN5tY08zwpfcApshHyfd6/hix/1YsCrZHeEV3h44lFG9y43KghGjJl/s5D17PYu897XTM6x88XRFqXUFOGuBSMObp1EREbGKQ5HxhHP+/derlcbCQSvteACvAs6kEksQ5dDzvH8zK+cO/sB7ZhfBcHQiHe0bbtM7/uS4JRcyrKN4ZToLPMETQj6+vRaeTRva7xyaYuL/NsApnJv8hrDOYJVyJQlDIq1uyt5vmuuYTdM/vrPRIETxsRPnV44547EshuLoTlW58Al41vrzsz7XVM7NHNXVgCPtvCRQI+GQIbZIUbGuH+qxm4xAvIozd7Z24ZjfhIiaQrSLGzqg9VuyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y95unQB9meFHPmFlKQuD63xkRywz1bRc72oY0lHQRvE=;
 b=SYXoWuZ3F3t0MlOh/n6WUN3RI8xsgEg2DGYE047vMF9/1WDAqiNPVXL/zbkP+EbXkcWR+hhscV8yzwQq6Td4TBpvrBwKTZS0JKZwAbm/KJ1pQoyAvGwy6B9rOJFC7So+71F5Fvya6aCUNyFbrhM4Jl+zamcD3jNtnsKmkzg/vyLwgpksBNI85vAPpJ0X1+Ph77Q4Nooo9VMCfZCP3FHKRxFRWpc69bj6qBVHaaZ5J944hV4X0l/bQ+PohY9i4eF4GupU8lPXQjX0LRV6cDtfFlQ1uqUvOCb3V4x0nWuOw47yu2p75Uxk5qrqVHaGOOgU+0mEuEmK1w6Mm/Z39b5BxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB9891.eurprd04.prod.outlook.com (2603:10a6:10:4c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 15:39:20 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 15:39:20 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: pcs: lynx: fix phylink validation regression for phy-mode = "10g-qxgmii"
Date: Mon, 31 Mar 2025 18:39:06 +0300
Message-Id: <20250331153906.642530-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0005.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB9891:EE_
X-MS-Office365-Filtering-Correlation-Id: 5127f606-fe71-4d9d-d21d-08dd706a344d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ihvystSMb4l1Vi2goZtaJewGiYC7afcsQn+JJgld3mPe2aoQtS2Pd+L6dIiQ?=
 =?us-ascii?Q?h/j4o7d+S13bUiCbHxkvc3zhdiabk4qsLCLsmG1Jwq1TfzItDuf+aY1JrIEW?=
 =?us-ascii?Q?byLpqsOb30PI+WUr3k2YBU9otQ3go38oOePkT2t/nHRiY0iw0/ZOqVW/2rFF?=
 =?us-ascii?Q?RYRhXwIh1RdiCngPgYmCB9kamHqKaKCU5/B1yDnT/l2jxuh4naVFs4Dyi6u9?=
 =?us-ascii?Q?19bJ08pZl6W7sQNXhjM1/a6yXRREq1ftHfdKYF5sYQGYtCCujHdMRx2J2XPy?=
 =?us-ascii?Q?f/EVweT0ex05O2RqI5QOMi2/qV/Irw5fr7+wX3nfm0lDuFAFSJfvqQhtMwMn?=
 =?us-ascii?Q?IgkEJdyY+Zi78Egga0WZpSxjNAF5L+iZJZxiwKM8CGkoUuel+2+1FKiGae6P?=
 =?us-ascii?Q?s+9IaU59VN3IulCWRlK/613EyIPI7kZqoK602wJ9lQdlSsqY/jlGeMsyeIk9?=
 =?us-ascii?Q?hPpq4U9dZzRXAujfYTnSotf+/8ffuRckOlL3JpiSiEcwwG1YHWSF9bWt9Igt?=
 =?us-ascii?Q?88M0hUYlJGjf1TMxplZs+1+Dxt33Ac8TS9LEW9Vt2st5MFf/TYGJDwyn3U00?=
 =?us-ascii?Q?v4hcY2beyQTQasHN4CRjyvKYiTGQbZS0g2MrBvG9AB/zixHHVa9cBEhQeN1J?=
 =?us-ascii?Q?9TNJmOjKPXhzGZKwXOf7VJpgddlm1IkzAJMrL2begAhxkwpG9soBU08c3q2u?=
 =?us-ascii?Q?DZIlKy93TxhFhD80OSwd2srP72+UxkLR109JoiTEZPBc+3fDA5u/y5OqNaiH?=
 =?us-ascii?Q?5HTKvnsgAaB9k9JAWS7rEoJ/klZTB2v7m6NnOL9z7FwNeuFYdJak8AW62A1h?=
 =?us-ascii?Q?cmy6kjTqAxtxsp/1jBdUzS4Df5hfwDpwCeYPiQTIToMaesHGTg3YXd7uSCbS?=
 =?us-ascii?Q?EfX8Wcdo3J6O7xNgRUe/0DjWEWDOuD1qCUEr0/MWqsgRlvspHEbEucAryy/5?=
 =?us-ascii?Q?210Rg3UXcAkmJPPpd25hLJgq60qTD2sB/fmm71boGIe074RB8l+DwDwAQUOJ?=
 =?us-ascii?Q?9c76CUaz2H5Y5aKlGFd7s3ig4LE+1fuQHRByCK8fuqWrEY3tKOyODmFoE3XC?=
 =?us-ascii?Q?r1bQK5aziW2YODlCk8phoj/KspK07tuV4i6dkUwC26JCBJ1EYvnEnMvV3KnE?=
 =?us-ascii?Q?W1pOk9dtGmw0u8hjHywbZBpNofasJBEHB5++DUo2gt2JPA9w+9k+E2FpK7Wn?=
 =?us-ascii?Q?U518xAubY3flaDXBwp4XhUkWEGjxClwO1XKbUrj8FHUazozpeYbJ5rFUh9Fq?=
 =?us-ascii?Q?U4NG6F0B2kFv0vkktvbNCyDRKwePTEfHtusHJnXUgutHMaT22DBhp4YMyzy/?=
 =?us-ascii?Q?0oyHA+yzacnAXx84CyusH3r1jKyYN6CGH8VsgxtRNRvRZ6u7zAlhf2VerPv/?=
 =?us-ascii?Q?/7yK63q6zC4AXVXJlIx3MfCVj3/oVJBq4Hsh8nv1AzI0RN8o8waNX9gxxw1C?=
 =?us-ascii?Q?vEbsO1kUQ/yrE46fy17Cfvntk4DYC+fKTkyPQbq6tNEctVC+Lc/hZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xBzW+TkkR+yON4r7688Vtdu8/LlLn0e8YvnViwoiBahAd7ZWdfO379FJV4Bl?=
 =?us-ascii?Q?hjfXHrpN2j8VtjtSCNafYMxzJ7t4RxXg8Pol1wUPtv4+zRftuyogvxdftyct?=
 =?us-ascii?Q?V7OtoOKotKkIISki8CRa9ISjH5x5ID+UZSU2wdQsMwviqreiEez1FKJVG1cH?=
 =?us-ascii?Q?KAqithzJGnUKCQXGFdmr7HIj+qr4H6FK/rQleIYGHSwzgm+1U/LvKi8lUJvs?=
 =?us-ascii?Q?KWuiV6iPYSZGl4PZ6AAr8WNiPIjUi57f6UmD0mPGxVgtmHxX/MqoSl/73yeS?=
 =?us-ascii?Q?Sd2RBh5APOOKy2WZ8CpfNnyD+Yxw5ebeyYJ+efWqoInerV4EvKEfaGkfB3Fi?=
 =?us-ascii?Q?bkCfID3uS9j1r98VVccDI4d+3D+UmRJygGISAlN8wpgBEoaT1jO6y+E48V4i?=
 =?us-ascii?Q?oQwvdXbjlIRUERTqXfZJv/lEpmVt4jmzaxmqPiVDPU28F2tTRLeKJeZTKEkI?=
 =?us-ascii?Q?oLm1uEpG0SizRWT/jIIspaq5GYPMFh72UQjPThDy21fyC5pojXY9/oKtlLqL?=
 =?us-ascii?Q?XSogcTRJdSEImcd3fxSOI6SvvJWU9rxKJK7QnnzPdTPsOVGgRVNhnVviwftD?=
 =?us-ascii?Q?EK8eSiXfIkYLHls4hRZrRqJbPgQ4PzjtQhdXVZxi6SI2aTf5RmaxwpG8wyQM?=
 =?us-ascii?Q?JkFERFJm3svXn0Rh7lHtRR859xkK16VEIqLU42WmcHYhiuBUwJhckyNgcBO8?=
 =?us-ascii?Q?G1xZ7XxCXdtP2Nw5M1LvwBZiuV6ZhW/tbkqrX7BGYmJU4AsNa1xT2kr/3LKt?=
 =?us-ascii?Q?Tx01zSmO/ggcuUSrlE2AZ038mUqUBDhQAurwb3V5+2XTzXitZo2LJvczpmb/?=
 =?us-ascii?Q?ZSXaH1spXCGQXp+CkokZqFmtFU2ZGhg2fO3ZiLiN1hOQS6Doq/SW2yV1E2/W?=
 =?us-ascii?Q?0b4yV+fFqIyVNH+x3yJHQOAUYDo0xWEq+ORfIAifPnjYkyUy7Pv1erUD+3LR?=
 =?us-ascii?Q?+V160h6wnhI0R4qIGCk0iRrbfGEbKwgpYDdQdlVXLzv7k7ypy3HaJto5Mrda?=
 =?us-ascii?Q?d9P2zvxB8mWnsX+yx4jBLoqzjDcCKemwxPhvkGvwP8wj2QJjsxEV7I7SZ9uR?=
 =?us-ascii?Q?7YIOoFXvRFz4vrufJiI7b8X49ySK2vv6psIsriqaErEvA19nZaZhcDPOHKAy?=
 =?us-ascii?Q?Slbp6W43j75m1YhL+nvUdghxYy60YiyCBZPtpmt7uYxnXwV5hqYweH/Po/9v?=
 =?us-ascii?Q?Kx24YXZR0cQNKVn8RSmD3sS7mb2txniXWJxhy37l6sh/u3ghNboQHQ4vfNtN?=
 =?us-ascii?Q?A3XKFthvXRhHrJGoDnKnuaFcM5SdppWZglCseFAH64nuXpO1XllHQjcxipJ5?=
 =?us-ascii?Q?Ckf64shO8a8Kl2onSyzh2dCswNKiooADz2GJGeB9Bn8V3a1wCZKwm/j+GcgH?=
 =?us-ascii?Q?G4u0N0FXGW4sw1g5oqw8Y8/gpZAoQXv2yRLvCWqpWQRg+E9OVv1HKlkr+OkJ?=
 =?us-ascii?Q?BgM9Vxdzn/QsOoO1U6Rbu/IMTDsStYIqyIJyjU911wjAYyLKWkKalNmPsD/V?=
 =?us-ascii?Q?7Szz++UmfPaHkiBEt3zKQJnfwRfBkAsWzEszEVXiU9FYPA5dRA3Qd8m8HVtG?=
 =?us-ascii?Q?7AKbE/o0rsdf6BzXKRNVfxH7rIVbrm+dzxIyicCc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5127f606-fe71-4d9d-d21d-08dd706a344d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 15:39:20.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9gwr8huDBlAn/8lSt8sjI5K6mPxmzM3GdU/9KFQ/W3KC1qFOw4w27TtYbnHkuEuuEwUhW/zO9q0s9jJaHnXdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9891

Added by commit ce312bbc2351 ("net: pcs: lynx: accept phy-mode =
"10g-qxgmii" and use in felix driver"), this mode broke when the
lynx_interfaces[] array was introduced to populate
lynx->pcs.supported_interfaces, because it is absent from there.

mscc_felix 0000:00:00.5: MAC returned PCS which does not support 10g-qxgmii
mscc_felix 0000:00:00.5: failed to validate link configuration for inband

In reality we should be querying the SerDes driver of the attached lane
to restrict which PHY modes are truly supported, but we currently lack
that infrastructure upstream, so just add 10g-qxgmii to the array.

Fixes: b0f88c1b9a53 ("net: pcs: lynx: fill in PCS supported_interfaces")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-lynx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index c0238360eb40..07c570e2d7c1 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -536,6 +536,7 @@ static const phy_interface_t lynx_interfaces[] = {
 	PHY_INTERFACE_MODE_2500BASEX,
 	PHY_INTERFACE_MODE_10GBASER,
 	PHY_INTERFACE_MODE_USXGMII,
+	PHY_INTERFACE_MODE_10G_QXGMII,
 };
 
 void lynx_pcs_set_supported_interfaces(struct phylink_pcs *pcs,
-- 
2.34.1


