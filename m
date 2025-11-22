Return-Path: <netdev+bounces-241011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8054CC7D68E
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 20:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AAD3E3538E1
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 19:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6D12D7DC2;
	Sat, 22 Nov 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l+ZU8Vqg"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477C32D5C61;
	Sat, 22 Nov 2025 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763840058; cv=fail; b=Oo/5z7gJBEB3/3hXY/KLG2vJeihQ3y13MAcTVIXl4tIWXSImStos7NUzFYzbM9wXHWIuOSv2WKR4JgLJwo2g6pKHmWMTy0dfrSZ8MYSKv7e7PU6fL0KRdW+LHTSkb7YLF2Jt0sTBe3psWzX2+cT1CBF5wCIHKMqNMEIS9SvYCrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763840058; c=relaxed/simple;
	bh=icdw+QltzsJUYVfjrik3pAa5BNWMBY7EX+w++3FE1BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KlCOZ8LV2oUQX7B/QfT41a7CNLnOUTqPaV/PbhjaftcevEQ85U2oKz7R2zcy3USwGOC9fjN7D00bpQkps7avbPPtvSTe1ovAXcZo1wMT3crWLGRt8+n07xgQuqmQpWNIqV/GO1RiOpEwYKiswNthIisC8wqwuRloUNJyIM2iS6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l+ZU8Vqg; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gu7RwojVZZBsUoT82PLCCo3UQk9QYCpB6tlB2889wS3p1ahsvLAGPAdMYYLTo4PBlu7Iz3s4c4GIgPdZcqNsupjWU0cDkmny3MSPNIpN1e6WSFWrfxfYt1iq4vE9VB2bMq246M4W8qv7Li4iFHQ1PIgUstkPKSr0l2+ja4/NZPE3CmTuACxjoal/oUsPo83/8rSRiekWHf2Dee6UNghIoTL/ZEDg/ovSVjYygp+Y6Re/WfLAVRm5f5nd0n4TvdBKRnl8TsFMWjpHcS4Ldhw9YoxXPFcaX9RkOVo/AW+2+dwITgayG7iUGXO+g1FKiZuZ6gq+E6JKO7TYuHg1iQ+Yjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq/HeBQEdaCCuuIDgy8p2wlxviQxJ4081hF2xP4Evww=;
 b=KstEjcB31/DejCcAYMXa06nWFzrqemuhCqQ82b7BNZGkSet2/hBpeNCewJTOKc4Lh0K6jGxQp+2n0l/IXjDbwf8QYRcW3gJKYnOwcHHr4q7TXlG+W6qwRIFTPTiXf6XT0o6DApaYlc9UCaYpqL03uoWeWVMoLClzcmNUCd3VpgihN8oDQT5ltNjfh1nr/fPqdkxizx5846yOzkVvZCFRzQ6EzDdMBjcWTbonGQG035dpd7/E3e9URVrhM00WaowVOLjTB/vY7TSJCoWfNCoYhy25VtFfyamWGNoyoDISA+bmA8rsfIPbBB1RjfWh8Agax9nxNcLyPgBknCrD2SkFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq/HeBQEdaCCuuIDgy8p2wlxviQxJ4081hF2xP4Evww=;
 b=l+ZU8Vqg4Kzad+/BJU4W/MgwGaP+g5DR+19t+juKpLQbnMKh8KFPL/g8ZYGTz9KcZEKZM64eXwLGNoyuNm/cak2a8N+AWqnL+eHK3OFUV5GElQo6JhOzfA9E0T+IGJ0no1U3tuqfGkBhbzRnKL/guVeLXBFEmVw/mYrpAYdy1NkA9i7dsp0zCUkfSCZvpnAIS1DsiXgS13TYH9LT52sn1PZld0o6+8zHEnjKtd415F1T6B8Pog6YgtcEaOepsKI6l6pMi0L5KcUIt8CTJzSrdS7KiVPpqGd7weiiid1lG7I7FNkvVG9uidnU3bQkWei4/4L3MmpkJjzAywj2mu7iwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sat, 22 Nov
 2025 19:34:05 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 19:34:05 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH net-next 5/9] phy: add phy_get_rx_polarity() and phy_get_tx_polarity()
Date: Sat, 22 Nov 2025 21:33:37 +0200
Message-Id: <20251122193341.332324-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122193341.332324-1-vladimir.oltean@nxp.com>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f76958-61ae-405a-4128-08de29fe18e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|10070799003|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mqst/QTafdhFXaNp5MGoU6QPFVFZ8wq0sri1AilnFvUFcvAL/0PTarWjksyd?=
 =?us-ascii?Q?PS2/Pu8aiAdKYPkPIBVYwMz+7StvidSU6j+QXLqGdJq8swEOE+gbzp8xxm5b?=
 =?us-ascii?Q?9cFzD9oYRjtAwPtuuTNy10t9G0KOjSOmWcbznGhtXeZmq2eAy0TbicYGuIWY?=
 =?us-ascii?Q?iTeBm1iRbiQZ29K0Agt32ySwd8e5Y1sld2tozBH3/ynYg0yDnOk6J+BDsKRS?=
 =?us-ascii?Q?TSo9T9Gkh7zVg/TpTR4xRm2Y4ICuU6I+ZFUxmkUSCFflBiBSXG6BQxrI/7Bn?=
 =?us-ascii?Q?vmpTyyxq5nlcR8x/huz04mP1n0DlMzjw9yKw3Hd6GSwEHLS+ISt4aXOSDCxT?=
 =?us-ascii?Q?dI9d79IWe016pg4HPRxKTcErsRqfV+f/njYvm6S2Qo9M/5kYOrS4gWKO4H2r?=
 =?us-ascii?Q?uZZUMaByE2ClD+DTgMVHt8DucKWniMpqePqbwy8ASaFHHxRaOauD0Vvr/Bbr?=
 =?us-ascii?Q?qwWU4ITE/ZEvG2vcEe6/7UFkGTKEiiqu98avucViN8dgsoPb9C7o7GFJOLJM?=
 =?us-ascii?Q?QPXPob0SjxYnOksk8su1vNu7RuK7E9xuyl/FHtygrAT8Djp7017cVEyOXfuz?=
 =?us-ascii?Q?tcUkI83zy1HBj9RDKc06bYyC0XeiJrViC4orqhWJMh0ZrcmNgwhS//mERWJW?=
 =?us-ascii?Q?sY+JprdC6lv1k3iAvjEQ/uKMkfxoIfI3+94NSUnYFCGN7ETD2lehpe52Gs7G?=
 =?us-ascii?Q?Z+ndozUYQLUfg4yn1dyDzwD1SMiutsfVMd4DBy6kFjYXorqU8B+dWCLsEko7?=
 =?us-ascii?Q?nYMv4USRt0BAM+I4gWPz/UHAWIFZ9ndNT+/hOgDbF1QiHtHSs2HsveuC+hv1?=
 =?us-ascii?Q?95HNN8KLTxOR41mBh8VsXMbnrzSEtSGQ8MrVJG3u3YpZ26G4T7wk8AU22wa1?=
 =?us-ascii?Q?iFdGY342q3Zqsg+LhU6RTI4SG6hjC/zgi5eUKs1gs1OrIJr6UYYhb9ucR57c?=
 =?us-ascii?Q?VhRh+y+vEXFj5DUoEZZyRKYRcCLgVWnbPCYCJ3gaFHK371W+1jpmmeVoqbEG?=
 =?us-ascii?Q?4uiHk7BHDdV0pLLK44f0zPPvyX5k5rmvpmrcjBGPT1gnvAY/wsgLN7P0N0Lt?=
 =?us-ascii?Q?BbatTCxlwq/HSc7+HRN5V1yK0iguCsg65syVXlD5xU3O+9ZUIk0YDNaV5cHd?=
 =?us-ascii?Q?OhagamRVbhoP1VB3+Ie6rZfU0mYTKEyEVrUG5n6DnDYaLzCjlPQUMOnDokpb?=
 =?us-ascii?Q?4KGYsth73ZZvoxEJoXhhxVsYZlfY8vVsW0qFmaPD75R4riItZ2L9fkW9pFJX?=
 =?us-ascii?Q?CbcvVlqEs9BmWcb5wr6uIXPi0kgLM9ANmZMXrTLoYRNOVs0ShJWdNKQtyTXG?=
 =?us-ascii?Q?yRz7lFEkQ0194SgEOt7QugSWZ2e8csFgf0IuV/K0v0L/+t5RqzoG6XIHnIK9?=
 =?us-ascii?Q?ZVyAciP6X3PodKWgdkdvnQ6U5XjsK+K1qRXrhXztW7/du9yP1Du2XovIUADi?=
 =?us-ascii?Q?2r/JK1VPMrw8rX96XMeS9zbXL956W1hm29WUVlO6XZzm7jT6V2C0bg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(10070799003)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1M9hfcc5xAoTn21Z1yK9OWqGVhq8qUUudWwivpwdzEH2lnEGoN9heNkGF5RD?=
 =?us-ascii?Q?zKDULOFS1JBHxVqlOPUu11GpXDBLJIjIQc+jdfXGzl+8Zw3T8A2X8qvBOXVy?=
 =?us-ascii?Q?5kqfq0MFJ40iiQlfX6HTTkSzQVLPQnznnzNhgwywelYZ4F4nlVD6d+sPrJfm?=
 =?us-ascii?Q?F8DvP2OBZOkvN2m/gsdHl6oyLwe94NE7nTqYm6+4bL9EDMIV0dpxczoKI2pQ?=
 =?us-ascii?Q?qsyFx9MpS0sXcKn7PVRvLC4J9TWUjLg7NZLHq6++hKDI+/g7pK/yEzz4LcAM?=
 =?us-ascii?Q?rOnQud5S6s3tTZa4CyuFVmR9q1zoAzhDVfCB/iY5cEf5YtDyrTMVCW5nG6UG?=
 =?us-ascii?Q?Rt9Oo7KteuvKF/YZybsniocm+lkSJjClCDvsDLGPkamMFyfwnNOGTOEazIOO?=
 =?us-ascii?Q?AZCi9GqnEGvFvXUsQR4DtM/CvYZNxilATTEqO98jbyUXz+mtjoKKWUhVsJ7v?=
 =?us-ascii?Q?pA0eXtP3LavbdbgCFkTeTrcoUZwKT0ziUe34+Z9WlliI+4mQYCju7QqitZNC?=
 =?us-ascii?Q?XVd7W6t3JvBQBIZ4ipduX+68opv1GYq6ET4Al//DdEwQ332rFIEA2/WXUEQN?=
 =?us-ascii?Q?Fg9vqjtiIPVelyd52STTKmqR2FfKp1MompQbPaVrSpdY8rtOIOgsVNIf8B3L?=
 =?us-ascii?Q?Ee2OJDemm9lE98jb7H700suwJGSeBpaPgdnmvpMAEPBrlxvCQFf7QxrxodcN?=
 =?us-ascii?Q?ld1LEEz1tbsogyiNZ/P57NjahsOTnSBEQQ4x19R4+wHPN2m1d2KL4UcA6qsK?=
 =?us-ascii?Q?J7CMv0jgP1ecqRY8VLlMb70EKcOn6g0uSSDspRFfV9Nxnl17hSI17O1JACng?=
 =?us-ascii?Q?kEplOc/WT+AVA5eYvBBZpV5HNQ616dTW7oYX9iE8VWPrP8RFqYyN8687xnTk?=
 =?us-ascii?Q?7m1W0Pqit5zwGldU8lmuIPQKVsjPwUXL2r2cAwpPLddlqlNIgHp1TIm6CsE2?=
 =?us-ascii?Q?XJ2JOG988UZ+uLDyKjSNpO/c91bhomQV9GCmRywUdrB/UQsUAGCaKk2i2LhU?=
 =?us-ascii?Q?dkhush9fx1Ghovt8+jxlNR3CHcfLqQZxBll7nHQ5nMvwrLZOHAo69GwXDTo/?=
 =?us-ascii?Q?1x+MVh8rg+gL1IswUno/u02qkqPozvgi4jnXLHNm2MnhSz9PovbAw4BJbD5j?=
 =?us-ascii?Q?K2j0Q8SnbIuwtEI51+7bEzQu7AoSzfRlJbknPWWE2PYQNKT/DokC8TEs1KAb?=
 =?us-ascii?Q?q04k+5Pz1x5M4EZXuuWeeEMgpcvYOs6EkFy5wYiEyUYFR0cI/vYW+IRCMqM/?=
 =?us-ascii?Q?ezuE8vqvtxdr66uV3hCIp7GQHzdcKKMLJB27aYbc6I/0KjNg/JUH26vuP7yL?=
 =?us-ascii?Q?iTNGnObHx2eLG/W/AKbE4+XrFDa3HzUrTJDl8dpx+Ohw6f+Y1V5GS5axGXDu?=
 =?us-ascii?Q?4eKF/R/XOYOfzSceR9qbafzDY94MQxHeAci/s5EQJhU3doPtkq3zwYtQWBcY?=
 =?us-ascii?Q?62eLECKmGEZlWw8o20ccolSeqN1t/o9QxIZqeGZksfWeju59qDICo5n1LUG0?=
 =?us-ascii?Q?mcXfUKWsi8tcYsxQqhMeRQEniJWhP4NuUb/OOJrEFnBWKBmcnntAOCS8Uh4L?=
 =?us-ascii?Q?XmyXw/vvqZXwtrMokXF6HhSqI5E76IdqI8FPShidfBjY5leBCdRYCnJGt0U2?=
 =?us-ascii?Q?ofZ3TnnSju95JncXjbf0J04=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f76958-61ae-405a-4128-08de29fe18e8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 19:34:05.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZEGcNHnJ1A62VNTnMLWH7tQ//41/iAqpS0WutCiOFCyKRWNx6huO+xPwoIPC9kNYXgHD0wMJIqUveKzdPqmvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

Add helpers in the generic PHY folder which can be used using 'select
GENERIC_PHY_COMMON_PROPS' from Kconfig, without otherwise needing to
enable GENERIC_PHY.

These helpers need to deal with the slight messiness of the fact that
the polarity properties are arrays per protocol, and with the fact that
there is no default value mandated by the standard properties, all
default values depend on driver and protocol (PHY_POL_NORMAL may be a
good default for SGMII, whereas PHY_POL_AUTO may be a good default for
PCIe).

Push the supported mask of polarities to these helpers, to simplify
drivers such that they don't need to validate what's in the device tree
(or other firmware description).

The proposed maintainership model is joint custody between netdev and
linux-phy, because of the fact that these properties can be applied to
Ethernet PCS blocks just as well as Generic PHY devices. I've added as
maintainers those from "ETHERNET PHY LIBRARY", "NETWORKING DRIVERS" and
"GENERIC PHY FRAMEWORK".

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 MAINTAINERS                          |  21 +++++
 drivers/phy/Kconfig                  |   9 +++
 drivers/phy/Makefile                 |   1 +
 drivers/phy/phy-common-props.c       | 117 +++++++++++++++++++++++++++
 include/linux/phy/phy-common-props.h |  20 +++++
 5 files changed, 168 insertions(+)
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/linux/phy/phy-common-props.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e9a8d945632b..658feb06cc29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10445,6 +10445,27 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
 F:	include/asm-generic/
 F:	include/uapi/asm-generic/
 
+GENERIC PHY COMMON PROPERTIES
+M:	Andrew Lunn <andrew@lunn.ch>
+M:	"David S. Miller" <davem@davemloft.net>
+M:	Eric Dumazet <edumazet@google.com>
+M:	Heiner Kallweit <hkallweit1@gmail.com>
+M:	Jakub Kicinski <kuba@kernel.org>
+M:	Kishon Vijay Abraham I <kishon@kernel.org>
+M:	Paolo Abeni <pabeni@redhat.com>
+R:	Russell King <linux@armlinux.org.uk>
+M:	Vinod Koul <vkoul@kernel.org>
+L:	linux-phy@lists.infradead.org
+L:	netdev@vger.kernel.org
+S:	Maintained
+Q:	https://patchwork.kernel.org/project/linux-phy/list/
+Q:	https://patchwork.kernel.org/project/netdevbpf/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
+F:	Documentation/devicetree/bindings/phy/phy-common-props.yaml
+F:	drivers/phy/phy-common-props.c
+
 GENERIC PHY FRAMEWORK
 M:	Vinod Koul <vkoul@kernel.org>
 M:	Kishon Vijay Abraham I <kishon@kernel.org>
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 678dd0452f0a..479986434086 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -16,6 +16,15 @@ config GENERIC_PHY
 	  phy users can obtain reference to the PHY. All the users of this
 	  framework should select this config.
 
+config GENERIC_PHY_COMMON_PROPS
+	bool
+	help
+	  Generic PHY common property parsing.
+
+	  Select this from consumer drivers to gain access to helpers for
+	  parsing properties from the
+	  Documentation/devicetree/bindings/phy/phy-common-props.yaml schema.
+
 config GENERIC_PHY_MIPI_DPHY
 	bool
 	select GENERIC_PHY
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index bfb27fb5a494..d07accc15086 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
+obj-$(CONFIG_GENERIC_PHY_COMMON_PROPS)	+= phy-common-props.o
 obj-$(CONFIG_GENERIC_PHY_MIPI_DPHY)	+= phy-core-mipi-dphy.o
 obj-$(CONFIG_PHY_CAN_TRANSCEIVER)	+= phy-can-transceiver.o
 obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
diff --git a/drivers/phy/phy-common-props.c b/drivers/phy/phy-common-props.c
new file mode 100644
index 000000000000..4c9dca98d23f
--- /dev/null
+++ b/drivers/phy/phy-common-props.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * phy-common-props.c  --  Common PHY properties
+ *
+ * Copyright 2025 NXP
+ */
+#include <linux/export.h>
+#include <linux/fwnode.h>
+#include <linux/phy/phy-common-props.h>
+#include <linux/printk.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+static int phy_get_polarity_for_mode(struct fwnode_handle *fwnode,
+				     const char *mode_name,
+				     unsigned int supported,
+				     unsigned int default_val,
+				     const char *polarity_prop,
+				     const char *names_prop)
+{
+	int err, n_pols, n_names, idx = -1;
+	u32 val, *pols;
+
+	if (!fwnode)
+		return default_val;
+
+	n_pols = fwnode_property_count_u32(fwnode, polarity_prop);
+	if (n_pols <= 0)
+		return default_val;
+
+	n_names = fwnode_property_string_array_count(fwnode, names_prop);
+	if (n_names >= 0 && n_pols != n_names) {
+		pr_err("%pfw mismatch between \"%s\" and \"%s\" property count (%d vs %d)\n",
+		       fwnode, polarity_prop, names_prop, n_pols, n_names);
+		return -EINVAL;
+	}
+
+	if (mode_name)
+		idx = fwnode_property_match_string(fwnode, names_prop, mode_name);
+	if (idx < 0)
+		idx = fwnode_property_match_string(fwnode, names_prop, "default");
+	/*
+	 * If the mode name is missing, it can only mean the specified polarity
+	 * is the default one for all modes, so reject any other polarity count
+	 * than 1.
+	 */
+	if (idx < 0 && n_pols != 1) {
+		pr_err("%pfw \"%s \" property has %d elements, but cannot find \"%s\" in \"%s\" and there is no default value\n",
+		       fwnode, polarity_prop, n_pols, mode_name, names_prop);
+		return -EINVAL;
+	}
+
+	if (n_pols == 1) {
+		err = fwnode_property_read_u32(fwnode, polarity_prop, &val);
+		if (err)
+			return err;
+
+		return val;
+	}
+
+	/* We implicitly know idx >= 0 here */
+	pols = kcalloc(n_pols, sizeof(*pols), GFP_KERNEL);
+	if (!pols)
+		return -ENOMEM;
+
+	err = fwnode_property_read_u32_array(fwnode, polarity_prop, pols, n_pols);
+	if (err == 0) {
+		val = pols[idx];
+		if (!(supported & BIT(val))) {
+			pr_err("%pfw mismatch between '%s' and '%s' property count (%d vs %d)\n",
+			       fwnode, polarity_prop, names_prop, n_pols, n_names);
+			err = -EOPNOTSUPP;
+		}
+	}
+
+	kfree(pols);
+
+	return (err < 0) ? err : val;
+}
+
+/**
+ * phy_get_rx_polarity - Get RX polarity for PHY differential lane
+ * @fwnode: Pointer to the PHY's firmware node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @supported: Bit mask of PHY_POL_NORMAL, PHY_POL_INVERT and PHY_POL_AUTO
+ * @default_val: Default polarity value if property is missing
+ *
+ * Return: One of PHY_POL_NORMAL, PHY_POL_INVERT or PHY_POL_AUTO on success, or
+ *	   negative error on failure.
+ */
+int phy_get_rx_polarity(struct fwnode_handle *fwnode, const char *mode_name,
+			unsigned int supported, unsigned int default_val)
+{
+	return phy_get_polarity_for_mode(fwnode, mode_name, supported,
+					 default_val, "rx-polarity",
+					 "rx-polarity-names");
+}
+EXPORT_SYMBOL_GPL(phy_get_rx_polarity);
+
+/**
+ * phy_get_tx_polarity - Get TX polarity for PHY differential lane
+ * @fwnode: Pointer to the PHY's firmware node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @supported: Bit mask of PHY_POL_NORMAL and PHY_POL_INVERT
+ * @default_val: Default polarity value if property is missing
+ *
+ * Return: One of PHY_POL_NORMAL or PHY_POL_INVERT on success, or negative
+ *	   error on failure.
+ */
+int phy_get_tx_polarity(struct fwnode_handle *fwnode, const char *mode_name,
+			unsigned int supported, unsigned int default_val)
+{
+	return phy_get_polarity_for_mode(fwnode, mode_name, supported,
+					 default_val, "tx-polarity",
+					 "tx-polarity-names");
+}
+EXPORT_SYMBOL_GPL(phy_get_tx_polarity);
diff --git a/include/linux/phy/phy-common-props.h b/include/linux/phy/phy-common-props.h
new file mode 100644
index 000000000000..0b8ba76e2a15
--- /dev/null
+++ b/include/linux/phy/phy-common-props.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * phy-common-props.h -- Common properties for generic PHYs
+ *
+ * Copyright 2025 NXP
+ */
+
+#ifndef __PHY_COMMON_PROPS_H
+#define __PHY_COMMON_PROPS_H
+
+#include <dt-bindings/phy/phy.h>
+
+struct fwnode_handle;
+
+int phy_get_rx_polarity(struct fwnode_handle *fwnode, const char *mode_name,
+			unsigned int supported, unsigned int default_val);
+int phy_get_tx_polarity(struct fwnode_handle *fwnode, const char *mode_name,
+			unsigned int supported, unsigned int default_val);
+
+#endif /* __PHY_COMMON_PROPS_H */
-- 
2.34.1


