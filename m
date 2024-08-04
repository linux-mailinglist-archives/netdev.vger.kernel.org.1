Return-Path: <netdev+bounces-115590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A3394708C
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 22:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38DE8B20BA8
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 20:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF12139D0A;
	Sun,  4 Aug 2024 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qWQmQIbC"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011067.outbound.protection.outlook.com [52.101.70.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C261CF8B;
	Sun,  4 Aug 2024 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722804616; cv=fail; b=PU0agBPIj0R783TWXiMcdaJptlAs4FiY9pLbvtVg8QFpaPYIP/+x1p7hT5TTzM0/zBgSTXn1VA/zv6pt1OGHABjz/yzcXi6ISRviTy+HA/0DgVt7C5K7ieT2p0mAnNPfCVs0ga5qB+fcs3RyLrnq3RWu2Iye7CffYviviKoFBFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722804616; c=relaxed/simple;
	bh=sTB18sPciT/bNyq5XCIJM9I/CtJ5y5lkn7tdhyW/Wis=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AAYXIA1+LUtQFjSDi7sv7IauB5+AzdSDbxJyWAq1fM2+RL+vA+ErDRdCxYVhoWrsUHhZyvEZ0w06IFLv+ahl9nnX639TdfyAvyycWWP/UMJ+KQhMtQlN6AI33OWenEcAelBl+AqkIby8qyK8BAvaLmkPdEBkrnztuY4pNnXkAog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qWQmQIbC; arc=fail smtp.client-ip=52.101.70.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8i+rOUk2h8E1djyAmgQ6pRx8cKp2kWYeFsec2W/OuCpoMkFxuyp9ArJXIR9/a2yOiaqxyBbLV84Yje33VQJrMk7T0+Qe7bwXHoPtByPzBXHcFFIpSBt746Kz7b/r9FKE2/5tCMvnjUsYoksS16vLqhkauEUGX4yVs/WI0jlMWAdW7VmZ47boDyddUEXlqWc/GxMZtC5bfhNIdtZnqswjep9t+zlqIMCCW6UOJdVMTRLQarjX9dS4DcmzHHAgkbRKi8ayx3h15RkNnMAHjDDgl/ne2qUQDFvRmmdDL9R5I3g+AGgudzbrRZhIjQHHXa0q3AsxCf3+PK7x4Fs8fRRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMB8mNVRjdVqv2i9GDwiXIMh+SsN9kN0r8pyi7oJWD0=;
 b=iC+VhPIVXjuMkHYDvGwofyRSuGhebuUcEmdxlbgunr67MGi5AUdf3xCwNAFz1p/XZgcUtp3oh4xe5yn3E6Zhj0AwX4SphwO1WKWfX9qacuu9UUEDgmrg1nnzHke94VbRHl257zXrY3sSdnacVE+q5KxQLC2N17S7XJbMaBzD65gvYoGk7WuUyaBH9u1UGp/L20KWLApoyKoxS9Dkjh547ks6t393ab7OB3Flkr/ljkr0HHgZ6jt7CJOCHMb20KN0t+llDt8Hfa5fNxJaAtBtDYpT+m3Im6bGXpgVDz/dSu7kOtVs0orcOSA7ZSBKf6LlkWLAJ5s3/1gqy/RE3lmcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMB8mNVRjdVqv2i9GDwiXIMh+SsN9kN0r8pyi7oJWD0=;
 b=qWQmQIbCgh3jZqL1k6DjoQStNQtRqHgcWNsX283JCqppUR2tuqTFd9FyANj59yvXb0LN4bL1NdzDDIRWayj0a5M5J7nrqMCHgPn9P8Eqp7LAuPkFonLXzAHHiur1ofm+Eyv5J44KOIzz1yOLSp3TbaZ9fD1is4brBCOhp/QPyoWoZA4Eo/QdrG4vIqTUeHz4gZZBuKIblXndUDMa+UCI3SLqDpnVrA0vBR57FWjfT/CzuED5wGsGX09vYk5tdCPi8BqORzzMjhGeJdvab/11BX5ez3boIi6wR4gKq+b/BtFc3D2BqExnSe+WH+5PsMX3x6BKvgbF6Y6+XjH8F2emfg==
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by PA4PR04MB7965.eurprd04.prod.outlook.com (2603:10a6:102:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 20:50:10 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27%4]) with mapi id 15.20.7828.024; Sun, 4 Aug 2024
 20:50:10 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: dl-S32 <S32@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH 4/6] net: stmmac: dwmac-s32cc: add basic NXP S32G/S32R glue
Thread-Topic: [PATCH 4/6] net: stmmac: dwmac-s32cc: add basic NXP S32G/S32R
 glue
Thread-Index: AdrmrVyUKT3e9hhXSvuIq/Wc0/85TQ==
Date: Sun, 4 Aug 2024 20:50:10 +0000
Message-ID:
 <AM9PR04MB85064D7EDF618DB5C34FB83BE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|PA4PR04MB7965:EE_
x-ms-office365-filtering-correlation-id: b8d56ecd-c1d5-4342-4193-08dcb4c707b7
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jSIjBJ9nWSoOJ+4uzv+EZfb0C7XcKCxbTUxqfxdfupQsLwcycyCP5R+oXO2d?=
 =?us-ascii?Q?yg5/WsNKP4qUsZ+zWTKcSGgPvWLl2A52tkSVlyt4GmOWFJ+K2vqinCW7K5q4?=
 =?us-ascii?Q?RaNP4Ey8RYSKyEM7+DeIt12MXJsq8gW1CqHY6N18AMjcUehxxrxKEeKmwTxr?=
 =?us-ascii?Q?HcejbD7PHXYMqa/HzjulP3D/WdKZ6BrP75wYiBDMmzIrddtpERVJMoKARXaa?=
 =?us-ascii?Q?iSp7KcR1BkUT64jiQcA53OeMpZgYOld/2mdWnr83DhVSttDuTjej+cTJFM+f?=
 =?us-ascii?Q?OoI+xmmfweYmLExuNQIE5V4sW6QcKEpXtxoBkkwGnPwQwx32sH8im4ipSxST?=
 =?us-ascii?Q?/EO3QVYoQ+XS6R9xjOmikw01WYxgIER+NzVR8CYzGRee3zd1QamVbLvkRIO1?=
 =?us-ascii?Q?5dEoWQsBO9rFph09pqgFMTWDh5aLy+3lwghm7nKZuN6tkgJUUuqmtjDNiai/?=
 =?us-ascii?Q?6m0M9IQMIfIIDRXSVxnKQ1JT+lDsa//VuV4pS7/dhZTeMmdHaiYMZ2cBmo3M?=
 =?us-ascii?Q?4lwuJSqygrlOGPoJig/YzD/CswGhc5H3tLPeQwC6xbWZK/vVKlqzsNExoUVj?=
 =?us-ascii?Q?ZzvVokB0MRnIw8hLU2l09Yhp4TpM82jXnokmtCC7MqDRcDEBxXR3UZQGlr/g?=
 =?us-ascii?Q?S+gskCVKJLmZUebq0N7JJp7TWL0LFeyXqBNGVmi9/6oJM787zbvQ52G6e6AV?=
 =?us-ascii?Q?HS5A7zu0uZXbwcREn8EYryLo4GWinTmK3XOSiWu6HAClRCZUapZE/NhzPlsz?=
 =?us-ascii?Q?NF/4HUeKBp84G0INLZaVSDKG6RkdIdo7DXXNVZ2Q1LJxMMg8drkFW+4UtgcX?=
 =?us-ascii?Q?UU11eLCH3Bymi0VDfwvrteVA7GSgCqfiklw4x0ldzXneGWCtdGUSJpeLm8ND?=
 =?us-ascii?Q?NWI2nNljP6k8xdjqbFgjeoQEjLVnSv8aknihFtG6MDl4dat0TCe1FW0+AZfj?=
 =?us-ascii?Q?Esm1j5MaBLcCPBtmCnBZGM+J5uusYUp5HYBou/q11bg32pKq+Fx03i5lzwFC?=
 =?us-ascii?Q?1mSC0CUtF+pxoY9QMBkw3gGuoK1zd+SiW6wG57DznANXVxMYe8D7wIXXUOm3?=
 =?us-ascii?Q?y/whnoVVyJWucy8Mr4UdU7Ev1dVixRCPdLvtpEHcN+WqjqRb2l0Q5qptr+mc?=
 =?us-ascii?Q?wAuVytahu7JqjZbonSQOUPzRxKMyYasq6nARyyKB7h+Ld4iVt+kx1Jx6iiKL?=
 =?us-ascii?Q?Ws5RJNq7WiqLEa9sl31O+sOYDkhExsOKagkhC89vXteSixCw1LO8EPe5Ijv+?=
 =?us-ascii?Q?Cu3Y3HOZKrFZlaJ1hujPYDmf7QbtIhiTsdNMsAIrAFbAM0I6iCAfR1yMXhzT?=
 =?us-ascii?Q?nSyjSuQu8HVuS82lYCs6KdCfLA1mheik/Sv0cg6GLm/WF1r24cqrkgP82zX0?=
 =?us-ascii?Q?UrcPsouCrzFeaPOJhaWStDWfg4qTwaJHol2wruzUF4FkMvCIyw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qvKtB3F+fwn4IyLaSz/iMs77WRkxt+DrFBZ0B7n64Tk1q3706VXb6AB++jDS?=
 =?us-ascii?Q?B1PDaT1A2laDuKdAKT1SV/rYAlfHL9ik1UvuUcYJIEVfvfkFK9vt+ChzqQ7/?=
 =?us-ascii?Q?qtuNkx7VuOdm52ax2aLgsfQ7HTOJDdADJWNYLofXFz35YiwIGz8OQxd2lI80?=
 =?us-ascii?Q?RM09wvX48sSdzRe5PfhRZHturVja4OZXFfmck+fDTrz+MCQDUHGgpYhJoDkd?=
 =?us-ascii?Q?qlBLQCcWSNBRPcTwVP0JSo76T34aHuhpgn00eiI87DgyKDJ3zJMtiWi8sUBk?=
 =?us-ascii?Q?YRKucAirMzr+vbdv2Ko6w70VlqVHNa9hBY8yyCm1BbX9KfUhGdHgA7oBjusC?=
 =?us-ascii?Q?bDwmBINBZSMFUCY9zaQf6KuGOtJpgxvUOQ39RD+3JglsZ6UTeIrwvW1hxO/m?=
 =?us-ascii?Q?KhAxDCBymxoNd97vb7iwe9KkirHeXXE4/C9a6oI7H/y01MBBIim/bW+PrTa2?=
 =?us-ascii?Q?+J7GuROFDKktXDG3DOIM+loTN/4i0Int7Ga6LJgdY7GvyQmftd7UDAd90jxx?=
 =?us-ascii?Q?410YaDirenfWSjuKhHQiBC4brb6ZRb4gAk+x0V7z+CVB1qKjQQMjDqNkKogL?=
 =?us-ascii?Q?0RtQr2KTpDx8rhTzuIRzC1zUpjGrgoUP6NR9uU+/4QWGAzh4bORgTBb6gUnF?=
 =?us-ascii?Q?7RkqrvGI77ZCncYqbHfXLfaUDIqB+f2JvC4vbP5DzSXoHQ4GPtB5qf4RcpwF?=
 =?us-ascii?Q?4YQ107aMKm6MYzB/2WiZkYU52H/bDxIsbGPY2P5vwStxrTEfOe/l0l8exX2W?=
 =?us-ascii?Q?a+UduE7DIe9PL//lCVVcvZegrtCm/FW66nD7HdCjRTznG8miSczhZA1/qKCy?=
 =?us-ascii?Q?G3I73xaxNVxz0Nu8tT9iILZLYhoWEq1wwAOl9n1EidldzgeIzTAXUh/r0Bp+?=
 =?us-ascii?Q?SBKLaYrfWYsLXkmi0EdpTou2En8sxRi0ktn0odW9C/8Ov9CbPHa3R5L3WS5y?=
 =?us-ascii?Q?3D6j9Xf08DyCv6FAqt9Wn8y4h6uEyXulZNmFuw2L0kzJunLM1dluIx01RCx5?=
 =?us-ascii?Q?0ZCRSwrRCJosjnTbGZSm/asytTxw5PckuGjP65eN88CfFlNQeLgGR/Ztbzm+?=
 =?us-ascii?Q?rJiIGxkNWjGA+Eg8ygtyiomb60a5n8Gk8zOZmCSoBqzEd1s7WgSMi5bQTivu?=
 =?us-ascii?Q?Wk7FRUpRWzZm2hmYheK6gVm9hAJXfcevHxbVfvRiS3sxfNolvGO4vOCIJ8zb?=
 =?us-ascii?Q?dnHgya7w5zsLYMgPS717Q+YfIONO4ArsRvZdtA1pXocYlVZOPhp8Gtrfc19C?=
 =?us-ascii?Q?s4F892D6o9OqLYbnmofgW132a3ZU4kfyyxNnzEho9dxSp/daKPzMzahlZjZl?=
 =?us-ascii?Q?7nUsY6ujuBl75tBxlv2VjWxAOHCySENsrS8ZKkubc5IvqnIiQOsRHOfWE0wZ?=
 =?us-ascii?Q?VoaFki7l1W5jHyleWgDDdYqy/bxCn9jpixJJlP8C17nRej6Q15yy3MFuNC4D?=
 =?us-ascii?Q?OoH2JfFm++4TMSVZjIlPY5EMNYsi2fzVwc448+GauojLveoBtWI1TGb3DIDa?=
 =?us-ascii?Q?uN8YKfVmJJWPn+n+/PBH5vA9HXjiNlXwXsuUvFvIWf9K+n+qMaI4y7HNmGre?=
 =?us-ascii?Q?kXtGEAIpjqGkvCFUZ3bqGL2V7Q207GzQjx2yVt1Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8506.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d56ecd-c1d5-4342-4193-08dcb4c707b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2024 20:50:10.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xz/IxI7AOVA3miNaiz/6LCkkefHwCAf0U+bng/P5xf+70NoC7tHYymbyYcdpQecFlx61o2/tmte9Y3RL5EbwSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7965

NXP S32G2xx/S32G3xx and S32R45 are automotive grade SoCs
that integrate one or two Synopsys DWMAC 5.10/5.20 IPs.

The basic driver supports only RGMII interface.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-s32cc.c | 235 ++++++++++++++++++
 3 files changed, 247 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethe=
rnet/stmicro/stmmac/Kconfig
index 05cc07b8f48c..31628c363d71 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -153,6 +153,17 @@ config DWMAC_RZN1
 	  This selects the Renesas RZ/N1 SoC glue layer support for
 	  the stmmac device driver. This support can make use of a custom MII
 	  converter PCS device.
+config DWMAC_S32CC
+	tristate "NXP S32G/S32R GMAC support"
+	default ARCH_S32
+	depends on OF && (ARCH_S32 || COMPILE_TEST)
+	help
+	  Support for ethernet controller on NXP S32CC SOCs.
+
+	  This selects NXP SoC glue layer support for the stmmac
+	  device driver. This driver is used for the S32CC series
+	  SOCs GMAC ethernet controller, ie. S32G2xx, S32G3xx and
+	  S32R45.
=20
 config DWMAC_SOCFPGA
 	tristate "SOCFPGA dwmac support"
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/eth=
ernet/stmicro/stmmac/Makefile
index c2f0e91f6bf8..089ef3c1c45b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_DWMAC_MESON)	+=3D dwmac-meson.o dwmac-meson8=
b.o
 obj-$(CONFIG_DWMAC_QCOM_ETHQOS)	+=3D dwmac-qcom-ethqos.o
 obj-$(CONFIG_DWMAC_ROCKCHIP)	+=3D dwmac-rk.o
 obj-$(CONFIG_DWMAC_RZN1)	+=3D dwmac-rzn1.o
+obj-$(CONFIG_DWMAC_S32CC)	+=3D dwmac-s32cc.o
 obj-$(CONFIG_DWMAC_SOCFPGA)	+=3D dwmac-altr-socfpga.o
 obj-$(CONFIG_DWMAC_STARFIVE)	+=3D dwmac-starfive.o
 obj-$(CONFIG_DWMAC_STI)		+=3D dwmac-sti.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c b/drivers/ne=
t/ethernet/stmicro/stmmac/dwmac-s32cc.c
new file mode 100644
index 000000000000..2ef961efa01c
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP S32G/R GMAC glue layer
+ *
+ * Copyright 2019-2024 NXP
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/ethtool.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_mdio.h>
+#include <linux/of_address.h>
+#include <linux/phy.h>
+#include <linux/phylink.h>
+#include <linux/platform_device.h>
+#include <linux/stmmac.h>
+
+#include "stmmac_platform.h"
+
+#define GMAC_TX_RATE_125M	125000000	/* 125MHz */
+#define GMAC_TX_RATE_25M	25000000	/* 25MHz */
+#define GMAC_TX_RATE_2M5	2500000		/* 2.5MHz */
+
+/* SoC PHY interface control register */
+#define PHY_INTF_SEL_MII        0x00
+#define PHY_INTF_SEL_SGMII      0x01
+#define PHY_INTF_SEL_RGMII      0x02
+#define PHY_INTF_SEL_RMII       0x08
+
+struct s32cc_priv_data {
+	void __iomem *ioaddr;
+	void __iomem *ctrl_sts;
+	struct device *dev;
+	phy_interface_t intf_mode;
+	struct clk *tx_clk;
+	struct clk *rx_clk;
+	bool rx_clk_enabled;
+};
+
+static int s32cc_gmac_write_phy_intf_select(struct s32cc_priv_data *gmac)
+{
+	u32 intf_sel;
+
+	switch (gmac->intf_mode) {
+	case PHY_INTERFACE_MODE_SGMII:
+		intf_sel =3D PHY_INTF_SEL_SGMII;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		intf_sel =3D PHY_INTF_SEL_RGMII;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		intf_sel =3D PHY_INTF_SEL_RMII;
+		break;
+	case PHY_INTERFACE_MODE_MII:
+		intf_sel =3D PHY_INTF_SEL_MII;
+		break;
+	default:
+		dev_err(gmac->dev, "Unsupported PHY interface: %s\n",
+			phy_modes(gmac->intf_mode));
+		return -EINVAL;
+	}
+
+	writel(intf_sel, gmac->ctrl_sts);
+
+	dev_dbg(gmac->dev, "PHY mode set to %s\n", phy_modes(gmac->intf_mode));
+
+	return 0;
+}
+
+static int s32cc_gmac_init(struct platform_device *pdev, void *priv)
+{
+	struct s32cc_priv_data *gmac =3D priv;
+	int ret;
+
+	ret =3D clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_125M);
+	if (!ret)
+		ret =3D clk_prepare_enable(gmac->tx_clk);
+
+	if (ret) {
+		dev_err(&pdev->dev, "Can't set tx clock\n");
+		return ret;
+	}
+
+	ret =3D clk_prepare_enable(gmac->rx_clk);
+	if (ret)
+		dev_dbg(&pdev->dev, "Can't set rx, clock source is disabled.\n");
+	else
+		gmac->rx_clk_enabled =3D true;
+
+	ret =3D s32cc_gmac_write_phy_intf_select(gmac);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't set PHY interface mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void s32cc_gmac_exit(struct platform_device *pdev, void *priv)
+{
+	struct s32cc_priv_data *gmac =3D priv;
+
+	clk_disable_unprepare(gmac->tx_clk);
+
+	clk_disable_unprepare(gmac->rx_clk);
+}
+
+static void s32cc_fix_mac_speed(void *priv, unsigned int speed, unsigned i=
nt mode)
+{
+	struct s32cc_priv_data *gmac =3D priv;
+	int ret;
+
+	if (!gmac->rx_clk_enabled) {
+		ret =3D clk_prepare_enable(gmac->rx_clk);
+		if (ret) {
+			dev_err(gmac->dev, "Can't set rx clock\n");
+			return;
+		}
+		dev_dbg(gmac->dev, "rx clock enabled\n");
+		gmac->rx_clk_enabled =3D true;
+	}
+
+	switch (speed) {
+	case SPEED_1000:
+		dev_dbg(gmac->dev, "Set tx clock to 125M\n");
+		ret =3D clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_125M);
+		break;
+	case SPEED_100:
+		dev_dbg(gmac->dev, "Set tx clock to 25M\n");
+		ret =3D clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_25M);
+		break;
+	case SPEED_10:
+		dev_dbg(gmac->dev, "Set tx clock to 2.5M\n");
+		ret =3D clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_2M5);
+		break;
+	default:
+		dev_err(gmac->dev, "Unsupported/Invalid speed: %d\n", speed);
+		return;
+	}
+
+	if (ret)
+		dev_err(gmac->dev, "Can't set tx clock\n");
+}
+
+static int s32cc_dwmac_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct plat_stmmacenet_data *plat;
+	struct s32cc_priv_data *gmac;
+	struct stmmac_resources res;
+	int ret;
+
+	gmac =3D devm_kzalloc(&pdev->dev, sizeof(*gmac), GFP_KERNEL);
+	if (!gmac)
+		return PTR_ERR(gmac);
+
+	gmac->dev =3D &pdev->dev;
+
+	ret =3D stmmac_get_platform_resources(pdev, &res);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get platform resources\n");
+
+	plat =3D devm_stmmac_probe_config_dt(pdev, res.mac);
+	if (IS_ERR(plat))
+		return dev_err_probe(dev, PTR_ERR(plat),
+				     "dt configuration failed\n");
+
+	/* PHY interface mode control reg */
+	gmac->ctrl_sts =3D devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
+	if (IS_ERR_OR_NULL(gmac->ctrl_sts))
+		return dev_err_probe(dev, PTR_ERR(gmac->ctrl_sts),
+				     "S32CC config region is missing\n");
+
+	/* tx clock */
+	gmac->tx_clk =3D devm_clk_get(&pdev->dev, "tx");
+	if (IS_ERR(gmac->tx_clk))
+		return dev_err_probe(dev, PTR_ERR(gmac->tx_clk),
+				     "tx clock not found\n");
+
+	/* rx clock */
+	gmac->rx_clk =3D devm_clk_get(&pdev->dev, "rx");
+	if (IS_ERR(gmac->rx_clk))
+		return dev_err_probe(dev, PTR_ERR(gmac->rx_clk),
+				     "rx clock not found\n");
+
+	gmac->intf_mode =3D plat->phy_interface;
+	gmac->ioaddr =3D res.addr;
+
+	/* S32CC core feature set */
+	plat->has_gmac4 =3D true;
+	plat->pmt =3D 1;
+	plat->flags |=3D STMMAC_FLAG_SPH_DISABLE;
+	plat->rx_fifo_size =3D 20480;
+	plat->tx_fifo_size =3D 20480;
+
+	plat->init =3D s32cc_gmac_init;
+	plat->exit =3D s32cc_gmac_exit;
+	plat->fix_mac_speed =3D s32cc_fix_mac_speed;
+
+	plat->bsp_priv =3D gmac;
+
+	return stmmac_pltfr_probe(pdev, plat, &res);
+}
+
+static const struct of_device_id s32cc_dwmac_match[] =3D {
+	{ .compatible =3D "nxp,s32g2-dwmac" },
+	{ .compatible =3D "nxp,s32g3-dwmac" },
+	{ .compatible =3D "nxp,s32r45-dwmac" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, s32cc_dwmac_match);
+
+static struct platform_driver s32cc_dwmac_driver =3D {
+	.probe		=3D s32cc_dwmac_probe,
+	.remove_new	=3D stmmac_pltfr_remove,
+	.driver		=3D {
+			    .name		=3D "s32cc-dwmac",
+			    .pm		=3D &stmmac_pltfr_pm_ops,
+			    .of_match_table =3D s32cc_dwmac_match,
+	},
+};
+module_platform_driver(s32cc_dwmac_driver);
+
+MODULE_AUTHOR("Jan Petrous (OSS) <jan.petrous@oss.nxp.com>");
+MODULE_DESCRIPTION("NXP S32G/R common chassis GMAC driver");
+MODULE_LICENSE("GPL");
+
--=20
2.45.2


