Return-Path: <netdev+bounces-144999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFCD9C9036
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC27281334
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E5718A6BA;
	Thu, 14 Nov 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fjNwQCOi"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2067.outbound.protection.outlook.com [40.107.241.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2218452C;
	Thu, 14 Nov 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603246; cv=fail; b=RguV9yP757CP7mOjyP2sUGlmtw8e8mbHWPmI5TTTwZLxZzz3zazk+BJl6vCJXCYOp8SX7lXqWkpP3cv69QO3pNetFl7C88qA8IAI4nU8DyM7aszkIyDNIKSnNP9YSgfV0P1IO4yn3PzsTKto0+ZvHxk7/UHGMquKRHOKRpAni6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603246; c=relaxed/simple;
	bh=Qo6lEid32CMtpYkIpdZh+YTwohSDhJ8rTaJOlloDgVU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EwNQz+X8JxZbCjYxRwprJgz1XbrXWyeE9Ix8IHzXak/PUkJeBXXLY1yFppE0KQU4tIOU3gHZjKVtec3qFaF+wglJtTxxaoR/fqg+5yPCO+GBIB6AzbsTunhIuKvuuSNFcU3cvgDxDSxa/EQvYWxDtCWAOfyHZcdhRqSk4rr3UFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fjNwQCOi; arc=fail smtp.client-ip=40.107.241.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hlx/2grmOQvew6AZzLCgG+/3ruKDnPZeYEjffkYICMo94fcFRuqQJxwiIaZtgrcDAm9ZuqBZS8eYLIs4MS4pDQC7rq7q2q0SGhEyZXpZvIWj1YXzzw4fcQ7rEK+U5UGvPwZjOYKdbrs91Y3jDFtggJjtnuSw1QNjAHVzD1Eay6QKg9otb3X+nkBSq0QwhaTjCtk8cvSHaaI+8M3E7olIahJPY5ELecVqWSy3BNu5rUs4hktMv0xWSuYyIAodMRt869BplvpuauMiLo/Dxzx03OI8fDtWkppRLJcaVkwma8yOrIHS6M6CMfbwC1KddR7y4xtEzGBDiIp33fiC4QCSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8itPxhGt8LSVukskLOOYxa93KNMaMi0v8ISbfABsKc=;
 b=sZYhOsa+I0iA99nfZMmq7Za2apMf9BZ1ECIHxz9sM/X5OoIMru0USVA7Cpo9tcdGzQJWEtqERvsevDCehVD8iFm1V88+bGX8DiW/YqBFWbEXGcz511ZbugAXoeHGWjS8kiOFdMJwQmvUBOu8qbL9st8krG8zRspCn5GcFfwJGDzWD/6P/CQkoVlMCZmRVB1zvzgplpatNkzBNlwGTKtUZAkxPeXmjWS4iu8KvIJl5FiKqJTZWXuY6HVxIo9VXWiKPha89gqhU2jdWyIa91lGDsuRcJr7/vFdewMWu+f4UmAajgLq/x+tV11YeH7CZ/7Bw0r5xNcE942MDiTGHhtqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8itPxhGt8LSVukskLOOYxa93KNMaMi0v8ISbfABsKc=;
 b=fjNwQCOi3bTDlF+B1vqLXxu5G2OadBmURIsawLe4yzWnqLVfeiTyMyD11JQ8ZUBPE8DqjPoh5YH/8hQIcFLpqtodsIQwjnFrtveB1EoQuc6NXcpDIFO3DOR6H4vu9qnxQRMCAFYgIP/OfLBk2MKdIUIAx9RoRGmWJFoHVN1phTRXsS6A57Va7ZjuNr7EGgGXCCCEYRT99GVtPiezk31p7qlvkSV21PJXvnQ17ig764xlhohFXyElS6U+CN5m7UjqPsXl4VNYmCxIBZSHk0NaIe8KWjCuTRegROs3QC0tLVlABkOiv4gsnVF+EHBHtQs5G75cQ168U6RIgBTAX6wyzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA2PR04MB10376.eurprd04.prod.outlook.com (2603:10a6:102:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 16:54:01 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 16:54:01 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next] net: phylink: improve phylink_sfp_config_phy() error message with empty supported
Date: Thu, 14 Nov 2024 18:53:48 +0200
Message-ID: <20241114165348.2445021-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::8) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA2PR04MB10376:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce2a918-7a74-4143-885b-08dd04ccf041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fczv8//CmlsZtL5OVSD0ahIV+WkEYb9FYeT11P5G7MnEMOrbI+sb5ZlvUvqb?=
 =?us-ascii?Q?86J122WLKMLvoC/q2x53pSjSvFyjyYLrFEkT3tAvGgPbjOLjTwKbzEp0/BeX?=
 =?us-ascii?Q?bqj7DRV2jUzqa2HGAN6dBD2Vyd/oEZywGwk+FWgQn5dosYFsi3OhXto88UAz?=
 =?us-ascii?Q?Bx2vXbTkwrGpeMODWgp666P8hQkMP39VRusZqJ5WTdKWiCuo6UxliS3tTmdW?=
 =?us-ascii?Q?4B4P8q/f3zpYIIE7Mm+yJriDh9HwTOsTywEhkv6K/6LzbTuTX6h6YJHNS8/V?=
 =?us-ascii?Q?I0Dz9n9PEuWYWzgEiyk7frmje7fUVKFgW/DvrDgD2cD4dFSQ4uE0L+btJ3e3?=
 =?us-ascii?Q?gbs3V4/yvt6oW7lBvdo44V7eAs1meczgq7lx1v5GbzUpQP8KhhuR1uBRLxg3?=
 =?us-ascii?Q?A9SMUPK/iz9FZKr2P4Zsvf6fwpcmjIiJnFZCtjuPamYv7OSN8lhvMSSVzBln?=
 =?us-ascii?Q?of4gq3d2xyCZNdA8b6Se0GqjoK/SGQD0edTYWN5Nh6CpJbbL+IpiE6VbECIi?=
 =?us-ascii?Q?aOl1Lg+ZqrDEK+yRmwEpN3jTp0VwTmMkFu1m9DwavKwnQB+xH/H1Lca+s5Je?=
 =?us-ascii?Q?qadxZTICNoZ9qSCO5qmBFwtcAVLUZoPUPCQpKmJ6i50RnociXpWCOD3cE9uC?=
 =?us-ascii?Q?E+wB72mV14lc9ZGCaX3o0hj1J/ykWAbQcMXx4Rqw8H+orjdvNXxfxpeGDlCk?=
 =?us-ascii?Q?d6bwr3xIYSRtIn6omYDk4hwyzHi8DJPD+OQLpyQ5kGwEi726qx+wOQSRQE7w?=
 =?us-ascii?Q?JxGH4BxTjUO78moe5j43/De1sGIXo/dgtARkqj4JgWBCukUJ2a144AthC1L5?=
 =?us-ascii?Q?FWaIuYNpR69Pq/TIaz5AWrAZhLOq/KfQ9Np8A3GTf/K/MlDF9Ep2542QF0pv?=
 =?us-ascii?Q?lpQ0w0UAazEnM2YB+4plg0R5QXWnA8k9jbDcR9fvy4nlI/btnZ8t3mUFgnZG?=
 =?us-ascii?Q?vAnIuDymLwxUaDOZszeNuCLuUhr0lySzgptTDD6Eh6pL5HjVJ3DzS9nApd0i?=
 =?us-ascii?Q?byoWW39J3aPvZVHh5SUoM6k7VGlKUSJnogajVVyNN3CHNL967LvLJmDhyqBr?=
 =?us-ascii?Q?6G/G9GE48O1pRqcZBQumhlRH9Uf4ZxsDX3/u2dedi/K4YJBSLcaR64YwBCs0?=
 =?us-ascii?Q?NpDpPoL5mnEua6MiPOzxHue/S1H5kW7ZedhHW1g3rGQ5mz4yIGy+JTBqcKeu?=
 =?us-ascii?Q?zshT8ao4r3yOpWLnQx2gD0McSd7v0rv5U7Swzqv5tUJENBsy6HuCaPQN3OGu?=
 =?us-ascii?Q?TCdRCTO24OuWRFVwTZqdbb+Zb8jNA8rCFcHFwlUtRgHUVmr/wmrGX4bvhrql?=
 =?us-ascii?Q?HT2YdOsi65aNucab7qeo3kSW5RboPDrR81LGLAUphONyX//FAnUvxuPQwRCz?=
 =?us-ascii?Q?xFzC8f8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e+mv+kZbbyfqHBHY8NFYE3mXBvUhgrDV9qmAfSE/x9y9NRcfExkprHUaQMFm?=
 =?us-ascii?Q?YKbTTzCjwSk78rmMh67nSR5jZpRwfHXnrmImEIovtB+VXj0LK7sd7Cvptd9N?=
 =?us-ascii?Q?GYeMj8liqhHNQwsYTLydNjMr/q3MRUsS/UymY1iegM3+3CHjTy+IfEY/PIFR?=
 =?us-ascii?Q?XPMtq0wR3CW4Cwh0BJSLD1oMelP99qLqUvvsELNumwnQwT1bekB84HFvUqGw?=
 =?us-ascii?Q?oul1kf9JAh/awQrNbR2z+jiDv2e32N+XwxvU4vwlg48AsnNLkryUw3abub8i?=
 =?us-ascii?Q?BkS16xTYQE/CR3flZEutpr1OZqzbI9JogJYqfBy6v6pbmj5Himn/nnkBtq1q?=
 =?us-ascii?Q?OwC9i/sq4VPW5EI2PXX7Sea6N5aUpU3vyGc787F0RCHTyludmt9M59BWo2bH?=
 =?us-ascii?Q?SENufWSSsyXU3GlvrAmevyNuCJAsaLBxp8Byuj6PaQRgXKPza38EQsmzwg+P?=
 =?us-ascii?Q?PPpsnuPfOfm34ykOCoccGiftX1KsRtO0A+dBoU+ObCr83ZzfwgUx+XaT4Qql?=
 =?us-ascii?Q?EJJUX5LBfet6NFQsu2I1MlENzuRWupBWBkk92sb0O7ogqlGTvMCmn+Ihy7rN?=
 =?us-ascii?Q?BoUe52xd/8xmTXMO7njWKyEizQhCk93xKrGTRDdo1X7Z7zsh6Q5Yasvwd5hw?=
 =?us-ascii?Q?BAWU7elzFeKJ6smgh8JOBJG4zVqtf9/gI5KeYavYCKJD1MInaAsWV7rrF+Eh?=
 =?us-ascii?Q?oOqlZzutFYyzbghrHIHJw9gAosIQ43riUd0v562BNhU4YPTxDLEFk+OjZImR?=
 =?us-ascii?Q?Xdpqacarfb9RtGd4uVzcEhCWHyaU+FPA5G6CIDCR88SSCeIcbaE+g2fVLM4X?=
 =?us-ascii?Q?FhPIh0oCl3X01srS2rDxCVESlTNFHd2JgmwMFuRDWRU6xNy9TSiV9YzaXgrp?=
 =?us-ascii?Q?h9gh66TdvGNEEk0gz98owB5vuYfFi2Ia3gLeXWOUD03KfM1Rujfe9o5nKUOv?=
 =?us-ascii?Q?Dnx++F+6ZOMoNVRcpoAYuDpMzxQftTHga2xHdth1vlgobJ4ZhRWhtXvAVoPx?=
 =?us-ascii?Q?uVKBKJMkxjFIWP8h+f9pFFlJiJOFRRvc1cZx7ULniMBVfohiUHWZ3+to0CS2?=
 =?us-ascii?Q?GV207m/PmkbAZ6J2Y3Pw/RKYCRpPuHLLReLKAKseYsiItecggjfTPMpvs1Wq?=
 =?us-ascii?Q?LMF6KmT3ZhgTDRZ89xTNJLgpXpjfwQnwiDj1mK/AK+klz+6KOdJPTzgs2fPl?=
 =?us-ascii?Q?vH+tvY3a9mov2m+8I3hGEcYKoswQe53eZ6hL45zvbwJ9xBCX1ewV6pfvVaIS?=
 =?us-ascii?Q?x428cFwAb1ttILLbJj4ozHdX8lXkoGhNIWv3CdSRgUgNNfcngp3NBUPrP2P4?=
 =?us-ascii?Q?QWXj5Z3kuA8RN0emGGqpJAmuklb31VAj9SGEqceUAoDqUwSP9jSaF8nslDGR?=
 =?us-ascii?Q?ZkMsFKsOUDUkD/u1OdhY9Ug6qPLjgjpcw9C0QLXSZmaf846M9HUTzzcCh4Bp?=
 =?us-ascii?Q?9xJXWx4USch55NSFNTOu3LCeE3xmNcRu9rJCiR1bamfcJd5nswgOpW04JBig?=
 =?us-ascii?Q?+fMR1VS1b0POHIxViQiku1xD0mcs+f5vAHJ5t6pZkiKSdvwrTxzNUPiR/6Ib?=
 =?us-ascii?Q?1S8Y78/XRAu0ZaiyXivNNMP5hhyiHcqpRCCq9zvUsYmhJVwGo8h+7ZkvwO9G?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce2a918-7a74-4143-885b-08dd04ccf041
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 16:54:00.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1P+yftd+uMnqWzfcjVvTam08PrN6pFRksTauPWjWot8A9iQdyz1YeGX6ETHK435SBDKLAbQEdNNbJcvyrZ0dhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10376

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

[   64.738270] mv88e6085 d0032004.mdio-mii:12 sfp: PHY i2c:sfp:16 (id 0x01410cc2) supports no link modes. Maybe its specific PHY driver not loaded?
[   64.769731] sfp sfp: sfp_add_phy failed: -EINVAL

Of course, there may be other reasons due to which phydev->supported is
empty, thus the use of the word "maybe", but I think the lack of a
driver would be the most common.

Link: https://lore.kernel.org/netdev/20241113144229.3ff4bgsalvj7spb7@skbuf/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/phylink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index b1e828a4286d..efeff8733a52 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3219,6 +3219,11 @@ static int phylink_sfp_config_phy(struct phylink *pl, u8 mode,
 	int ret;
 
 	linkmode_copy(support, phy->supported);
+	if (linkmode_empty(support)) {
+		phylink_err(pl, "PHY %s (id 0x%.8lx) supports no link modes. Maybe its specific PHY driver not loaded?\n",
+			    phydev_name(phy), (unsigned long)phy->phy_id);
+		return -EINVAL;
+	}
 
 	memset(&config, 0, sizeof(config));
 	linkmode_copy(config.advertising, phy->advertising);
-- 
2.43.0


