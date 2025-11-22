Return-Path: <netdev+bounces-240966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2577FC7CE73
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 12:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3713A9ED1
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 11:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72722FC88B;
	Sat, 22 Nov 2025 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z/XOZM3s"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010004.outbound.protection.outlook.com [52.101.69.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08F41A8F
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763811292; cv=fail; b=rXtQIDzcdvW7YZIVykSpGl/E9Gq8CclVLpZbG4jIECF2COqqeTg71Ade6JjBTcXfxE4DPQgsUkHLxXdXAIC84FWKdSQ2uHntfV1HwlXVyoIhKkk5neTIe5rTdkozqORXf42ajpADafDgI1xPKvkz5IEgJNHrAIEoH+TtwBK7BcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763811292; c=relaxed/simple;
	bh=oxj5I70POeMnjpHRTsvBIvpWp5K++Zt8btaUUBRpeBs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=T6X0hirI3CPJ3IcHLhOWP3pu2xR0kwExIJI2giu0oNW691Mus3XRHnAdhds4xpCZbZpxhX/r1DnxJ710g0KL136KKFFP3FRgGw5N/WL53SxJgU/74tdEXcL4ZKd9gWv2pvj0Owoe3vOap8FoGQVeztxYO+evIsYpGG3tnKA5Q6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z/XOZM3s; arc=fail smtp.client-ip=52.101.69.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POE9RxgpbHem9SGakIx0H5AvBR/EtcdcyyXkeB4bcFD5hcRcfmQWkQIlUDkQyXx4XmvndG7dSkPTaJW7chVP7Uw8tLBIg1Xufr90WaL1gukrSLYXNtjkh2BgX1rEG3mrUBawg/oF0++gAqzYbcMoO41fjxxC1A2IhcONESU624x+XFGJYacgqUdYPi8zEOmXaqx8cvd3/iKyVj0Th3nk6RsZ8WS2UBXOD1lvj2ajXeSqgNOU5XFtAtuVraCURBLA4fW3PwxP7BK0wABnmuT2LXeMrqnmvwsycCZkWyM6M7sf0R2/QqJppqvclqL5TBS1qvIBVJMbCKWcngL1zuOTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWq8TnYWYu0NW/CY4l5Zs6WlxosJutjBNvj9Klxf3NU=;
 b=y4mpj9epYsK1TkmC8tKSSs4TzSMYy0d+xJmhH06pAC6NI/Vnt3puQtv//OuLTSlfbleC4FV7hgy4wytxhTLqhq/OWcbrtU8VfXsbuxH6APc0wYKz1Py0zo2jn/1IKKPh34Z3UBjbrEOWoIYkHOX4N9wy790JXCmQM4WDqM5yHn0k/ZjflGHLZn7gl/SkAANY+3JXNyLbAvtjHOHwTvBZjbelD6UGmNhBuz/CxHWkH/9FL9FRRcQVqLrkkYVO2iY/vuUFLofixSCRwtUmio2w6t+5H4ua4KeRDZqjd2OiXilnj0LANLwBHzeJgtqSJn3yn2LFqEcVt1wnnYSlIdRlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWq8TnYWYu0NW/CY4l5Zs6WlxosJutjBNvj9Klxf3NU=;
 b=Z/XOZM3s4cSj4duo4vVwiKHV9bJCM5zvAPXvli1ICPdXL3NdTNr37f3wF/zQyF6sJe8OplQaH+Gp+JQRYnZloKDmVGb1AhBTmz6GOCt4UFj5K4HLQMtMHREaZtvpc572v/XkpCwyf/tXzjIZXjiAY7ipo9qg34aMAVDQoKjwsQEeDeLCDGILWd/B+yEwAFe1gI3AmdSvAORCm7i9UF2wAUXWHsqBgvD9PgtZ6viPP+1kfhbbGav26S0UBpMIIL9EmA0TOsc1F7tqiEKK5REn7wrvjse7MjzqhU5365Bu4ZOFTaBceQaISAa+DO/YBesctMKxCSmLkLdBfqMmdIZJ/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM9PR04MB8424.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sat, 22 Nov
 2025 11:34:47 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 11:34:47 +0000
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
	Alexander Wilhelm <alexander.wilhelm@westermo.com>
Subject: [PATCH net-next] net: pcs: lynx: accept in-band autoneg for 2500base-x
Date: Sat, 22 Nov 2025 13:34:33 +0200
Message-Id: <20251122113433.141930-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0024.eurprd03.prod.outlook.com
 (2603:10a6:208:14::37) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM9PR04MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: a396ff09-9555-4b0e-37ec-08de29bb240d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tyoEIDOWZzSAKAGY5NW2VGaLUZdJJmclCAV6zgXhkNANSmU9iP4P1uEHllTS?=
 =?us-ascii?Q?++H0UlfL5Y7oLhyL3rbwIbMhhO2u2i3KtrZ02jVnXTdoOQdrweTQaATipaGq?=
 =?us-ascii?Q?EcUZv0PUPolyEOitkAlqDrklRFvKEQ/DbW4sUb0ZleS1Nc7/lxdLS2dETD6p?=
 =?us-ascii?Q?Owv5QRK9kz+wxwUMB9nMo34Q+KxULVzfx/3HwWTYqgl3C0bLWE2GAaQMBmgb?=
 =?us-ascii?Q?z5/7OYJ5COdkOly+i7LmO+vCVe2TbSsEeTdUeAM62fqtmJ5Z3SwGVDKDTmEi?=
 =?us-ascii?Q?vM/CHRQuAdC9VUy1aCCUeLFtjcDG1FavmACDh4/BfzN/5Wzt99KOJKQ2H9Fa?=
 =?us-ascii?Q?lp7DukM7KbDgmivXbIO8aC5TRo50C20lSZOFQAYMTCxl0Vb1oRpuxTxedR0u?=
 =?us-ascii?Q?MkA5RaE3H2agEpxwz0I76Iae3BNxfJXBzLYkjOGdQAW0mFe9xuGrgoAkVOmV?=
 =?us-ascii?Q?jTRvQsNlgOAZXq37uiR3+wyNgwfM6yBnMJbdKLIrajoqgknVv85rtNlAdOdA?=
 =?us-ascii?Q?JaruOqOxE52uDRBYWmMtwl+a1H5BIjPMwuS/5Z8C4xlwVgNoD+1hjJLKjOJx?=
 =?us-ascii?Q?gcp7AhPVl+iTcfbvCa0qD15Hv2aaB8FEDgtoaHzJ5GSHH0DPTd4nfvRLYPqG?=
 =?us-ascii?Q?f4hOiGWxjUJsehYDikIQ190Fxfx851gRspttnV++uP5LA4tARoudQtKoAoPz?=
 =?us-ascii?Q?gEEfRJ7OF8Je/nn7oOV/WHgqG0nwfU9ZhMxXi0T+8ANfxB+LmKyDTCzL70YH?=
 =?us-ascii?Q?Qx0PqltNkB8I8UjjuWkEv7oJiA70ScNEi8IPiwpBtcAJa5gqTgJYbdBNSs4A?=
 =?us-ascii?Q?KzW3J+Hn1bnLyi5+2CSYVWxAbU27+xFsTw25+UyS8KJ45Ccj/mkDSZqoEgPM?=
 =?us-ascii?Q?n7rXHgifDag2hgr6wjBI8OJkP8vw19jnXU+UOpypR7eDl042CJhv8jkIU0to?=
 =?us-ascii?Q?blcTCGejxuyfCSmGOwKZrUj4JAkoO/xX8JKCQUI77Iat0ePAY0xiExaoKcU9?=
 =?us-ascii?Q?DTHFc+sy0ddz5HaKKnbS1FvAMWAUu8NuF8kD+Dh+Vxyxs50VeLCpc8zSxYcu?=
 =?us-ascii?Q?HyhRA71whq5mpGC7b2tRxfUZ3M2wfbtytp0kOf1QpTDI83mIURs/fVoiTxEM?=
 =?us-ascii?Q?jPcnbinVKdvRxxCsr5UWRjTYFZfS2BbbNWBNooGMGZplgm5o+DuXqk8rkmv4?=
 =?us-ascii?Q?LD8T1cOpnnQI16QTa7+civt7ColElFdmPJUqDBjpZZ1X5OyAKi0uVJRrx7KB?=
 =?us-ascii?Q?+Ik1kBpMJjEFySx/EIo+sG/+V1I331AEsxw58WVlJdROQvzM1r7QOZASGbR2?=
 =?us-ascii?Q?QcGOLNPC0QsBDSeZkkbvbBO8l0ed/Yxa0RNq+O9PCY8CoixS8W/ZM768zV5H?=
 =?us-ascii?Q?qVIt9QBkXOql3Awf7pogtt/jc4aLZgGSg5AG0tniClIgKeXBm2z0WTvVma4m?=
 =?us-ascii?Q?SzPAPbA+0bA7gnmaluAd2fmMcLo6SSl/980s/ZbaGczutY1OdSFEaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?StZ6RRAplGVFWfkBGLOu7UktJBwZj8WQIRZUSoSzYEBKXw9x2aQ5iyVPkSqW?=
 =?us-ascii?Q?hekwQnBXwbrkUNTTUxVj+Q+JegQG5uUTiHDca/xqI+uuCClFSilXfU8R4ODG?=
 =?us-ascii?Q?UtyqWaVKd1xGhSDfLyLa0KVf0qk0RVb3o+Xphz8f2xKEuUqiU9jol+M7o/dL?=
 =?us-ascii?Q?lIDVUBSyoT0GU5fWszntD+URs45vMTnKUP6+NvMwp359JmigHfQOO2I4BHtV?=
 =?us-ascii?Q?L/6sTEwj8zsMmaLAkmtH0uOEGk0RbYOlRLrIjC8zy+gD3XazPo5FltksxrX9?=
 =?us-ascii?Q?7yXVjfcIIMYm86XY3WwLQo6xB0nvKMa4yOxjUzaTNrCTlC5tJq27m+ixUMml?=
 =?us-ascii?Q?Ejdw0b93vjx8gSfKiCCJ6JJD7lDuh0aRRRjVDZ3t9trlv3+P152Rg1+qUZAe?=
 =?us-ascii?Q?Nkqz84fw+7sc74riUqMoFJAuuMK9ljYMvR0wOaeG8QCOMWkCXkwItGuckvpc?=
 =?us-ascii?Q?1R5Fi0DHEF0fOSolUjApkinUUqzCgkCZgB2Ew5DfTQ9hgf+oEaoUSVcWtLTN?=
 =?us-ascii?Q?TzviOG577NOxCSa5hzZZL17UTlOEdGzLHI0kSFeu5DTMc3T32WlfPz0pr+fp?=
 =?us-ascii?Q?WrOHQTnHAVowD23Kk+6DJAu030mkCVttrkCZR2b2cwI7skfkAYauMpDzMleX?=
 =?us-ascii?Q?gF+Bw6imoX+MhGiwwcLXYaP6SUj//e/zPHCrm0gtBZC85hH9hvNzGRcBcCgT?=
 =?us-ascii?Q?+qVN8mJveckSxq6mQgyszNWmbze0Pg1BWdZQEN05aK03mgppIlkAErF8vx9H?=
 =?us-ascii?Q?zCQQ4M0O8AWUkqud0BF+cYOJ30tslpgeBfprr2W4YQdNg6Uit3V699LvVUtn?=
 =?us-ascii?Q?NPCkZK6Is6blMTT/T+ENjfA6WAN11QPhrKVXXFMm8KMSrcEOPG8nME089MTb?=
 =?us-ascii?Q?6lNm3Z4RJh5lyWQiCkh75yidMxoXPHfq+eGljGhBKM9WqR9dfvFUAnSkeLk9?=
 =?us-ascii?Q?A1FiwoYu5dMH2pehgaoCilOidsfeTotsJAo+uhcTcP18tfhxXC6jB4b0jCXU?=
 =?us-ascii?Q?f4KtKZGiZvUqw+PGtKznTPTMvWhp5KWTk5EYYwtsKU0vmT/e+/nyv2O+zJgD?=
 =?us-ascii?Q?M8fiLjHqCb7kXcRAXbV9cyNA7j4GpvWBbt7TESRLYMhMTnhLZ/SXdAADP8CJ?=
 =?us-ascii?Q?L8Dj4zEqYkmh5F/+b2s+5YgA04xPB0vIjBSbheQCTYPqvSDYpqdh7T+e4ZwM?=
 =?us-ascii?Q?RIKZSM5kJonTcemVhRsIJOCXw4+280VTnLsICnFgFUIQvx1sfPNTbNS9roOu?=
 =?us-ascii?Q?hEC37A9nkUwY7xoof5iPO+4i95NG9YPiTNVaZPaFx5JzFS7QHpo+Q2k3YXvT?=
 =?us-ascii?Q?6hETruSqTmFC5u3Nt34PTMpFIbvrO+nOIW6ZG6+28b/+iR22dvtoxTO2K7Pz?=
 =?us-ascii?Q?ZF8z1VZl03hQGbJaROybuy93FVaN5P1wCQ6/qg8ROotDH1HunxfcKQEIyGkU?=
 =?us-ascii?Q?YJkmNiZe67NyHlVMkI4wDsDHnZVAje2OWeSNxu0U6HIK0uswFZfm39RcGSLV?=
 =?us-ascii?Q?NYAkesifPLc2okaZ4q38iwtX8MHpjbfLT37DBlb4tf3EzIhT+gxjlA7zey4i?=
 =?us-ascii?Q?mc7H5/ajd2dK5g6WvG3mxjIWWnYSJ4Xo7jU63jCWQj0OaiAkyqrr2Vx9SOVy?=
 =?us-ascii?Q?TvlRf8GZtoNWqqiviGv7MwM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a396ff09-9555-4b0e-37ec-08de29bb240d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 11:34:47.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCUILKyqdy8eo8jCoMc0Fykb28/2jyzb8OJsP4NlOGfqGOnBqDfWy7Q/kHvuJ/RmZ0znNK9ylXthpyRrkk/xyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8424

Testing in two circumstances:

1. back to back optical SFP+ connection between two LS1028A-QDS ports
   with the SCH-26908 riser card
2. T1042 with on-board AQR115 PHY using "OCSGMII", as per
   https://lore.kernel.org/lkml/aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX/

strongly suggests that enabling in-band auto-negotiation is actually
possible when the lane baud rate is 3.125 Gbps.

It was previously thought that this would not be the case, because it
was only tested on 2500base-x links with on-board Aquantia PHYs, where
it was noticed that MII_LPA is always reported as zero, and it was
thought that this is because of the PCS.

Test case #1 above shows it is not, and the configured MII_ADVERTISE on
system A ends up in the MII_LPA on system B, when in 2500base-x mode
(IF_MODE=0).

Test case #2, which uses "SGMII" auto-negotiation (IF_MODE=3) for the
3.125 Gbps lane, is actually a misconfiguration, but it is what led to
the discovery.

There is actually an old bug in the Lynx PCS driver - it expects all
register values to contain their default out-of-reset values, as if the
PCS were initialized by the Reset Configuration Word (RCW) settings.
There are 2 cases in which this is problematic:
- if the bootloader (or previous kexec-enabled Linux) wrote a different
  IF_MODE value
- if dynamically changing the SerDes protocol from 1000base-x to
  2500base-x, e.g. by replacing the optical SFP module.

Specifically in test case #2, an accidental alignment between the
bootloader configuring the PCS to expect SGMII in-band code words, and
the AQR115 PHY actually transmitting SGMII in-band code words when
operating in the "OCSGMII" system interface protocol, led to the PCS
transmitting replicated symbols at 3.125 Gbps baud rate. This could only
have happened if the PCS saw and reacted to the SGMII code words in the
first place.

Since test #2 is invalid from a protocol perspective (there seems to be
no standard way of negotiating the data rate of 2500 Mbps with SGMII,
and the lower data rates should remain 10/100/1000), in-band auto-negotiation
for 2500base-x effectively means Clause 37 (i.e. IF_MODE=0).

Make 2500base-x be treated like 1000base-x in this regard, by removing
all prior limitations and calling lynx_pcs_config_giga().

This adds a new feature: LINK_INBAND_ENABLE and at the same time fixes
the Lynx PCS's long standing problem that the registers (specifically
IF_MODE, but others could be misconfigured as well) are not written by
the driver to the known valid values for 2500base-x.

Co-developed-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-lynx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index 677f92883976..a88cbe67cc9d 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -40,12 +40,12 @@ static unsigned int lynx_pcs_inband_caps(struct phylink_pcs *pcs,
 {
 	switch (interface) {
 	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
 		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
 
 	case PHY_INTERFACE_MODE_10GBASER:
-	case PHY_INTERFACE_MODE_2500BASEX:
 		return LINK_INBAND_DISABLE;
 
 	case PHY_INTERFACE_MODE_USXGMII:
@@ -152,7 +152,8 @@ static int lynx_pcs_config_giga(struct mdio_device *pcs,
 		mdiodev_write(pcs, LINK_TIMER_HI, link_timer >> 16);
 	}
 
-	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
+	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    interface == PHY_INTERFACE_MODE_2500BASEX) {
 		if_mode = 0;
 	} else {
 		/* SGMII and QSGMII */
@@ -202,15 +203,9 @@ static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	case PHY_INTERFACE_MODE_1000BASEX:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
 		return lynx_pcs_config_giga(lynx->mdio, ifmode, advertising,
 					    neg_mode);
-	case PHY_INTERFACE_MODE_2500BASEX:
-		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
-			dev_err(&lynx->mdio->dev,
-				"AN not supported on 3.125GHz SerDes lane\n");
-			return -EOPNOTSUPP;
-		}
-		break;
 	case PHY_INTERFACE_MODE_USXGMII:
 	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return lynx_pcs_config_usxgmii(lynx->mdio, ifmode, advertising,
-- 
2.34.1


