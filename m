Return-Path: <netdev+bounces-151010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6099EC5AB
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 08:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A74285D7F
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B2C1C5F1C;
	Wed, 11 Dec 2024 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eMiU/Z8C"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900842451E2;
	Wed, 11 Dec 2024 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902655; cv=fail; b=jxG+ia7NV97b9m245OmjijNFs68QAQ7Z3q7tCHXqqjlVKVNKgZvyoj76DTqfoL44yMLNkB4KVMSEDC1/hY5DYwf7aw5m1RkrVuVUwODfxWRFCelhDz9sGXoZeL7mzttBP1nw3J+Y4aqexfw5WmyvwQOlOfd+HDhaEp+BWPUiqLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902655; c=relaxed/simple;
	bh=jyyCTKq4aGZ0aVR4oVdXeDT6EhcZ2jLCmo83wwRiFaI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FuJ5EEE5heZ+7yzLPLSbSjvHGfwwxf77ghFPiZA/OM3Ndpz14qTZYyOcMcGZbhNBQ5K6QsMr7T3D+aOfz5BbyhV3/hpT+IP17gCjMwsm4FbhMaaCeWH5yVw79njrllR4ScCIzB0OGgrjTCALZqzP1yunVCCfqJDzhc3QhA271Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eMiU/Z8C; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGLbOQMtWg2Z28iYDEtr2WNfTdwnz0jXFjSqEOg0QP1vgXDxVuY1X0ov/+6EG0gxDH2HgiEzaoxI8vEKLmZVXRH9s5HGYkiC2C0RK/T92DnyxbjCr/oPeq+TLrsa9QwLCalQdhc+EHUdYu9VqjMxx/wSzUI90j8vVHtjP6gHTRGAwE+2aV3KZ0kYTxbXdrCNNnuPh6TlrfMJYpMJV2W1CJzT3BexsHi3LwhG+VQFILfZJAwhJgFmpH4zDYWWqHsWB8NnNjsrBGR3coF70s3KoMpMjLZf3LNHeU8l/4qLcjcm1NbhOQ2+tCmdnEE9hVIG3P5PYW8Lzv2QR2KdULdGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hQnq0AwNbgrJ5UYvpAvDnWZ2nh3LhJYq+A63POWdW8=;
 b=JNGvA/NqfzYfpERPwMf2ZOmawCv3FEiONB2TPNyEkOy9Gan00TZ2mQLxAEHiKmxIIxfSPTiU2HS8UANGBRyurLPdY/ICidIi1VyRGYsNV5a7iq8OC/gHJU4/YOHcFcPne6iMRznRHVP88ktbKyT3dy01NIAzS/7g3eq8hcmOQ6nS63scwxBVnuM+2U5vV0hibGGgERHJhWEcoqB44Mmm8D4zroU6/GBaAzdl3ln5+h6ElMDy4ycHvDLx6aCEGir0IPuurfL+KlNb1rHSlouoEE08ELunHrqeTDjPYm52HSVpNBag4hpQusxEKE4VGCnFnwMlgi2DKWiPFZaabugcyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hQnq0AwNbgrJ5UYvpAvDnWZ2nh3LhJYq+A63POWdW8=;
 b=eMiU/Z8C/yQvDObF3xHdoGOW6/L9hPfboGZP69orQi1VPFTGRJ0WxMM8KSZHciax3tUBucGYwk2Y8pRvviKkZNgG0h9CRFYBr8nEGC0F6oYxsVexRXG2MOD7yNpYgjEDOTAGhRN5cRfNJh77EzwmKuFay0WAfi6HkRcfVck6MD0NILor7naB48itnHQAmxbAkt+2y+HNu+4JRcrdAY+PgPpaievcKDaGTpSD/plDRo6Z+hG50v2345Q7TEit3O5AgTzRRdCXfakXFThAtYg7X7Lo+JmLeq9UCCBVjAd1lGfqxf2vXriyagnxgp5pum9hbN745Zr2KJ9flA4s6+bm9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10187.eurprd04.prod.outlook.com (2603:10a6:102:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 07:37:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 07:37:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	florian.fainelli@broadcom.com,
	heiko.stuebner@cherry.de,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 net] net: phy: micrel: Dynamically control external clock of KSZ PHY
Date: Wed, 11 Dec 2024 15:21:36 +0800
Message-Id: <20241211072136.745553-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR04CA0030.apcprd04.prod.outlook.com
 (2603:1096:990:78::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: bac103da-885b-49a3-f9b8-08dd19b6ab04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PM1H7voAnzPBnDDLNx3tkP7pLBrT/fFZivgAPpj2RjdK/4lMolgmnnQ4a6t8?=
 =?us-ascii?Q?9xpJuk8m5L8KCduUivJx0D+CMqCJSN150aYRrKmeVpHQHJYiMv3KBTBydc9D?=
 =?us-ascii?Q?+NjxIEQ7uG8B3R4V+Pp08wCY9vs38gwNidAA6XdSFYNneTuYuwopYxieF05a?=
 =?us-ascii?Q?/1XD0kzQWLGr6az1QmtXV/2bzV2E3l4Wc4v3UbC9by4kWG4vYxNhaEZ3/LiN?=
 =?us-ascii?Q?jU2U2+Ole6cnerC4u9zEE3k5EaZU8lENDKBecyE28+mOiWVcAaLLJPFGBIrA?=
 =?us-ascii?Q?IDyW9d4ZExnW4LQAPHgPyO+5BI2nRP1rPYMIVEUUij8elpPajrDnicq5LYwt?=
 =?us-ascii?Q?AtUj31Rsc95Yq0rQ9YR3jJ7REt3WZiYrHklgodNCZGnG/yOwTglbL1Zft8eG?=
 =?us-ascii?Q?RlFTiR0gWJ/qBQS0U9yBbAt3MZ6yAb8+FxFn+nlkc/V1YpaIgYB9W1v0x8H0?=
 =?us-ascii?Q?PfsQLQYfcTwnMp3IzpzCMio3o2KSqCpngvlxdLCKdIOTSMdB8dqQO7WNnA/i?=
 =?us-ascii?Q?XFuwvloqxYsmKzaW0EyuASk3jxAM1brjR6+x179DvLaObQVNoPs3GbDQMSup?=
 =?us-ascii?Q?ZlqMQe9gC6Rx0Nxg/0u+UjLsw0mA9VsYTHUzyzCzE76qgxkP++KQI/qfWDuD?=
 =?us-ascii?Q?nTWB1SdnQ+stCcdAQT/yBaXOQXSI4jI9B9T6o4wuPXXAqUELI0gdT9fH51KE?=
 =?us-ascii?Q?O7/K0sBqg74ksQfcEh95mr7LhbUqix/Y6AbvjQRJHqwxMpEp3sgKQ2FnBciG?=
 =?us-ascii?Q?egHSSupL3ROn+Daq6jGlctgEIpU8agwVwYG8PqieWkUanjY9xnfgNr8SOjOq?=
 =?us-ascii?Q?JWqNro2Bod2il1n1FB8X6vAidcqE8Rn2mYDCdypOxrOhx9C7VYd2XXpkpic6?=
 =?us-ascii?Q?QpPzlQ/IWMcx0ioI9MYTXunfaKw7NVG0YOas7bj/P1L6KZjMGHoXha3+uhlR?=
 =?us-ascii?Q?/dTb1efS6sgpTipMyH6BLgZTLwhzyiCeMdOstnVez7yoahyglGTGOveRF7I/?=
 =?us-ascii?Q?kVu4dmGRTwJFiNFHLig7Y0dfBk7ehPlnXU75KLAHse3ryG5SSYd9a7dZxzxF?=
 =?us-ascii?Q?YkX2BpC4Sl0kMgnQucGxkGhbJYCoO8eSdI9Slv1P+XWayKHHtDCFyVX2agKP?=
 =?us-ascii?Q?4RYigoFh/HI4uVMxQE5KVixxyWsel3rHzNTIMrGf+I7Nthumy1qPyLYbNT4L?=
 =?us-ascii?Q?R1YvWTrVqjm7tzq+OR9h+LxfY/kZvQ+9OxpwH6f0jHWjo9nZsN8bbb4RAoeK?=
 =?us-ascii?Q?7KFCQVUkboqgFNJpYa63T3M+ywsOMoqh9v8E7iJm4LH130h3UcpcpmR+YvzE?=
 =?us-ascii?Q?752RsyG0MRvIlkyVSXcoVcoiPwrF9fx77HbpfrmWZvQEray+SU7iTi/PjI49?=
 =?us-ascii?Q?jIyjBcoHILDyUflmiOhihxACvH6UUHbOcpHHRNOYjiuzoZqjUYbQX1T/7Zzo?=
 =?us-ascii?Q?r4QkCy5OpKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q2jj5qnKr1aI9874LBBM6PIrtPIi5dWX7KT8n8fdRrOsrJhoqRuO7UfmFaMy?=
 =?us-ascii?Q?ukR3LYeFeGETYNlOWhOQ7gZrYTvwRUQ7Evea0GV8qTRE/z3ofZKUS1DNDcHD?=
 =?us-ascii?Q?OSLJ8ibNJHVwpAgW2rskkv77YoXNOKIfpBXzGBnsgS15VFQAd+Nz0pRmSplr?=
 =?us-ascii?Q?rdXF8NLeNouzhStk+VyY5CHYIs+Dw3FyW40YYLW6vPdT+6mV5WHkFvxDFYtc?=
 =?us-ascii?Q?+vet9EziZlqH4MLY2xjQH52xhC83NipWXP9CZYmfVs+kIHFY1gEffldKsxZT?=
 =?us-ascii?Q?vXYdKVYnRfcvKzTZhhHuCfAB6ZGgiDEybsORiswHjbYS85Vtp60MrafKG1TP?=
 =?us-ascii?Q?popc0Y00mLq6pYH5fvWCTo2lQldnAxjcQlj2dsBaT8AOH11ASUd8+VcRwSEM?=
 =?us-ascii?Q?NJgsZcCi5+ZhHHxouvhl7emhV+p+7QXmUegvdOP2rXE0moO8Yc0185+PpfXC?=
 =?us-ascii?Q?37lgiC3ZYGcUIvB2L/9fBhcGn6UZpquTPg9YPggWD1PI41w+7CTpfEL6Zl4g?=
 =?us-ascii?Q?Vn9VurBQamdPZfOxdcwNKGxXInJpXuqPOVadpgLpGDDYt1sZvaeu2Mz73Ow/?=
 =?us-ascii?Q?fS/9ipQwhzJ/VwFUGICXCQWhOIu/FQCbMOrrwQpKq41RK30XIiKDKWJltgNX?=
 =?us-ascii?Q?x9e4ZDqYlI3z2hFNUV36CUQ28wZhGfPHEtci9fB7jPus3s3bBifK8ad+AYUO?=
 =?us-ascii?Q?VKWFN4RP9DD90kk4nzQnK0LRFWYjO4dvDuFZp/fU3K7zTd+XB0b14wu+rZ/c?=
 =?us-ascii?Q?kfR4IKO6uk74dY8qnG98NKwyMbEb3R6OlFj/7RpO9P23bz7GLOk8cGCAwrMH?=
 =?us-ascii?Q?DBp9XNjCa67SwJKF2nmosU7wWV2UZxls8VfzJkAV4CviPpGIxDb1yszcA+DQ?=
 =?us-ascii?Q?+FfZPYVZsnC0KwzIV7f6vdgSjdFoDykiKbR/HDzlMNTeNIo9I2umpDrZZZ6Y?=
 =?us-ascii?Q?aV2WcuUDyaeE9pA7mquF4cHVcoXaHVBBcU0iyb902o/YxZ2G9gdZq0CmCuTf?=
 =?us-ascii?Q?iqqzsQ2g589LsKlxO64IjgAEtdPoHAdmzT84GeGbCfDZpNx6u8Bl/6m/1zE5?=
 =?us-ascii?Q?pFaQIIVdvDe/Ll/h+ebk1ZrpzSZsRy3SKxW+Y5qdbD05xCTGNb2wSUtnhmS/?=
 =?us-ascii?Q?6KWKX7yDCS396GpFJJWlrN8bhQNnBk9CqvpMKO1TR/7v4yUwWji/usWAHAdY?=
 =?us-ascii?Q?4CQpaj+lX93wR7guBdSHGxJu1S6aCklmcdrE2M26br+2rbyw4/oGPe6uQAgv?=
 =?us-ascii?Q?F2UxcYwgCQRPMGT7xVc4seKUwhvpuaEkeH41oKNn/gAjsmipwVxDqX5IYL/o?=
 =?us-ascii?Q?OQzlVWcN/DUFhZp7Y3HEbJwaoJgkRZWOVel8OgxAUNKuZcWithHJf59WYaJT?=
 =?us-ascii?Q?//cjyRWLySJHnTpzCGhb4REfeW8VSjWITWJ9WXkmJb/q2dfld3ts/icjPORY?=
 =?us-ascii?Q?A/fiLRsrf7QVh+OZinJ6PuNZVaf+Fv27YW3aZ26ixb8/XIS+ytGuqJoXzFB6?=
 =?us-ascii?Q?dZAl/KZrDetvmmNz76eOsk93wqqw0+1PaFaSzBj9wC89qP8P8cdS7/MsCj2x?=
 =?us-ascii?Q?Mb8fB/6/YkagPoOjb0+przxnWZYHGAK7w5M8TC4H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac103da-885b-49a3-f9b8-08dd19b6ab04
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 07:37:30.2834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kF0QmEyjd95J6IsWCWPwcTVWNLHBBaw1Ohym3lQ9XBB/GDmLGfbZd8n/QKZYCVcBui1Ke1TIra7Dgrv4vvIZ8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10187

On the i.MX6ULL-14x14-EVK board, enet1_ref and enet2_ref are used as the
clock sources for two external KSZ PHYs. However, after closing the two
FEC ports, the clk_enable_count of the enet1_ref and enet2_ref clocks is
not 0. The root cause is that since the commit 985329462723 ("net: phy:
micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
external clock of KSZ PHY has been enabled when the PHY driver probes,
and it can only be disabled when the PHY driver is removed. This causes
the clock to continue working when the system is suspended or the network
port is down.

Although Heiko explained in the commit message that the patch was because
some clock suppliers need to enable the clock to get the valid clock rate
, it seems that the simple fix is to disable the clock after getting the
clock rate to solve the current problem. This is indeed true, but we need
to admit that Heiko's patch has been applied for more than a year, and we
cannot guarantee whether there are platforms that only enable rmii-ref in
the KSZ PHY driver during this period. If this is the case, disabling
rmii-ref will cause RMII on these platforms to not work.

Secondly, commit 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic
ethernet-phy clock") just simply enables the generic clock permanently,
which seems like the generic clock may only be enabled in the PHY driver.
If we simply disable the generic clock, RMII may not work. If we keep it
as it is, the platform using the generic clock will have the same problem
as the i.MX6ULL platform.

To solve this problem, the clock is enabled when phy_driver::resume() is
called, and the clock is disabled when phy_driver::suspend() is called.
Since phy_driver::resume() and phy_driver::suspend() are not called in
pairs, an additional clk_enable flag is added. When phy_driver::suspend()
is called, the clock is disabled only if clk_enable is true. Conversely,
when phy_driver::resume() is called, the clock is enabled if clk_enable
is false.

The changes that introduced the problem were only a few lines, while the
current fix is about a hundred lines, which seems out of proportion, but
it is necessary because kszphy_probe() is used by multiple KSZ PHYs and
we need to fix all of them.

Fixes: 985329462723 ("net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref clock")
Fixes: 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic ethernet-phy clock")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v1 link: https://lore.kernel.org/imx/20241125022906.2140428-1-wei.fang@nxp.com/
v2 changes: only refine the commit message.
v2 link: https://lore.kernel.org/imx/20241202084535.2520151-1-wei.fang@nxp.com/
v3 changes: disable clock after getting the clock rate in kszphy_probe()
v3 link: https://lore.kernel.org/imx/20241206012113.437029-1-wei.fang@nxp.com/
v4 changes: add more detailed explanation to the commit message.
---
 drivers/net/phy/micrel.c | 101 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 3ef508840674..ffc2ac39fa48 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -432,10 +432,12 @@ struct kszphy_ptp_priv {
 struct kszphy_priv {
 	struct kszphy_ptp_priv ptp_priv;
 	const struct kszphy_type *type;
+	struct clk *clk;
 	int led_mode;
 	u16 vct_ctrl1000;
 	bool rmii_ref_clk_sel;
 	bool rmii_ref_clk_sel_val;
+	bool clk_enable;
 	u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
 };
 
@@ -2050,8 +2052,27 @@ static void kszphy_get_stats(struct phy_device *phydev,
 		data[i] = kszphy_get_stat(phydev, i);
 }
 
+static void kszphy_enable_clk(struct kszphy_priv *priv)
+{
+	if (!priv->clk_enable && priv->clk) {
+		clk_prepare_enable(priv->clk);
+		priv->clk_enable = true;
+	}
+}
+
+static void kszphy_disable_clk(struct kszphy_priv *priv)
+{
+	if (priv->clk_enable && priv->clk) {
+		clk_disable_unprepare(priv->clk);
+		priv->clk_enable = false;
+	}
+}
+
 static int kszphy_suspend(struct phy_device *phydev)
 {
+	struct kszphy_priv *priv = phydev->priv;
+	int ret;
+
 	/* Disable PHY Interrupts */
 	if (phy_interrupt_is_valid(phydev)) {
 		phydev->interrupts = PHY_INTERRUPT_DISABLED;
@@ -2059,7 +2080,13 @@ static int kszphy_suspend(struct phy_device *phydev)
 			phydev->drv->config_intr(phydev);
 	}
 
-	return genphy_suspend(phydev);
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	kszphy_disable_clk(priv);
+
+	return 0;
 }
 
 static void kszphy_parse_led_mode(struct phy_device *phydev)
@@ -2088,8 +2115,11 @@ static void kszphy_parse_led_mode(struct phy_device *phydev)
 
 static int kszphy_resume(struct phy_device *phydev)
 {
+	struct kszphy_priv *priv = phydev->priv;
 	int ret;
 
+	kszphy_enable_clk(priv);
+
 	genphy_resume(phydev);
 
 	/* After switching from power-down to normal mode, an internal global
@@ -2112,6 +2142,24 @@ static int kszphy_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int ksz8041_resume(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	kszphy_enable_clk(priv);
+
+	return 0;
+}
+
+static int ksz8041_suspend(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	kszphy_disable_clk(priv);
+
+	return 0;
+}
+
 static int ksz9477_resume(struct phy_device *phydev)
 {
 	int ret;
@@ -2150,8 +2198,11 @@ static int ksz9477_resume(struct phy_device *phydev)
 
 static int ksz8061_resume(struct phy_device *phydev)
 {
+	struct kszphy_priv *priv = phydev->priv;
 	int ret;
 
+	kszphy_enable_clk(priv);
+
 	/* This function can be called twice when the Ethernet device is on. */
 	ret = phy_read(phydev, MII_BMCR);
 	if (ret < 0)
@@ -2221,6 +2272,11 @@ static int kszphy_probe(struct phy_device *phydev)
 			return PTR_ERR(clk);
 	}
 
+	if (!IS_ERR_OR_NULL(clk)) {
+		clk_disable_unprepare(clk);
+		priv->clk = clk;
+	}
+
 	if (ksz8041_fiber_mode(phydev))
 		phydev->port = PORT_FIBRE;
 
@@ -5290,15 +5346,45 @@ static int lan8841_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan8804_suspend(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+	int ret;
+
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	kszphy_disable_clk(priv);
+
+	return 0;
+}
+
+static int lan8841_resume(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	kszphy_enable_clk(priv);
+
+	return genphy_resume(phydev);
+}
+
 static int lan8841_suspend(struct phy_device *phydev)
 {
 	struct kszphy_priv *priv = phydev->priv;
 	struct kszphy_ptp_priv *ptp_priv = &priv->ptp_priv;
+	int ret;
 
 	if (ptp_priv->ptp_clock)
 		ptp_cancel_worker_sync(ptp_priv->ptp_clock);
 
-	return genphy_suspend(phydev);
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	kszphy_disable_clk(priv);
+
+	return 0;
 }
 
 static struct phy_driver ksphy_driver[] = {
@@ -5358,9 +5444,12 @@ static struct phy_driver ksphy_driver[] = {
 	.get_sset_count = kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
-	/* No suspend/resume callbacks because of errata DS80000700A,
-	 * receiver error following software power down.
+	/* Because of errata DS80000700A, receiver error following software
+	 * power down. Suspend and resume callbacks only disable and enable
+	 * external rmii reference clock.
 	 */
+	.suspend	= ksz8041_suspend,
+	.resume		= ksz8041_resume,
 }, {
 	.phy_id		= PHY_ID_KSZ8041RNLI,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
@@ -5507,7 +5596,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_sset_count	= kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
-	.suspend	= genphy_suspend,
+	.suspend	= lan8804_suspend,
 	.resume		= kszphy_resume,
 	.config_intr	= lan8804_config_intr,
 	.handle_interrupt = lan8804_handle_interrupt,
@@ -5526,7 +5615,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
 	.suspend	= lan8841_suspend,
-	.resume		= genphy_resume,
+	.resume		= lan8841_resume,
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
-- 
2.34.1


