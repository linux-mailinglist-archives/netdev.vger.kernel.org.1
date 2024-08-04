Return-Path: <netdev+bounces-115588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4C2947084
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 22:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3EA28115A
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 20:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116C9137C35;
	Sun,  4 Aug 2024 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lXvq/buU"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013020.outbound.protection.outlook.com [52.101.67.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014C22095;
	Sun,  4 Aug 2024 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722804594; cv=fail; b=QEKaeHuipnDbmpIWWyAA2TTYktdgDsbtfP9Xk0QmE5Ujlwz354XOQ0/Hem8/4KDu/2Pzxd6cRBDjccCBBgezWto/xQ4ZOCxdZYJogSk0SfqbQXFLvCCUot9dni/N17+KMITEDJH5EslFSn5Th6F5HlspLFnKMw7Xq2/T18YgQ/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722804594; c=relaxed/simple;
	bh=VcEYml2Z6QxrQIjfc1b9ysKDpIESjKw5ISWEWGK8bpI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZP5CtHRC3UHAFS7uo9cJIXu4uT9USbuE1KkfNCZvgPttERMjEHF3py5M8pOHOF1TFy0dN8EzJZoXvMidb3pN/nVXoPuOwv9WvgmrHjLUnzqPPxOjWqtzeM0VpioFGIlTjGp4Li8b/kpzbbJX4NmU2CkzC6Spta7mijHTDCIq5Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lXvq/buU; arc=fail smtp.client-ip=52.101.67.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqRY/FxU6ImvBcX8p21D90k+yjtct+otYR0i6JA7FdIbH4MeU8R52nyQ0oEM6SlJtDCV1uNuBHaCpIHkNQJJFvAC5bkpZp7E7fMTGUwFCebUYOex5OOjmpOfsGmiOaWzi3lF0OdKFXCHlARQbvF5EdDUlflQFUpou90EYDUm95TPgaD3u2DvPEA849uKg4Oo0NmWfFgN+9+npcXLFxuXYcZdReid28zsgjq4f517FrWJAQB1exX1VinNrOQtAftp5hiOeRB2vwY/3KAYuQvfHPIkx0RrvnWk5trXXILD9fBYi8c9iuMv55FDGzsmBE2FX01WJHNKtJDO64T0oMdBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/OCgEgTxC3St53drlLN828a2omQ4ZUJEeU2RiR6h/0=;
 b=r90+zLya0i96dnBUplmPiFAyd+Cfaay6Va6vPBlD4JDzA/cmhtZftVwtwcvArYwnOcciMCDl/6bJIlASxLUe13OAyax5MLjvH3zCcK0UuY/40p5FwguXsSYBAE71zoipjRMmdtzJN32vCQNrBK+7mbL6rumkzRRRtQXX5wBCov0biESaYnPHOoGA/o+sffV/2JfCl+sf0sH2PLE+dfYuskKqTrcntRnDLfkMhN86agKTcb4Z/1L67l52xS5XSYzvC0c06M8T1oVbr5uu05ZiqLis6FvtphT179Cxkuv4CpaQxnXRX0kGM0wcoC1chwFxSqm7AKA5x+GKRnz0C3QasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/OCgEgTxC3St53drlLN828a2omQ4ZUJEeU2RiR6h/0=;
 b=lXvq/buU/phRItTrxzR9AV3WTEbgg/OrgM9F70RGbK9GcKLETbAu+UebB6OojJ3roFq2j9DMDHpWwzgrIRjdCbb3CaLwyWsX5g7A74lxle8Wtlfc6nDAj5KbrAaOqwbrw7APfjBUT/f5i43HjivBz9mwhikmJF8xqkdzjVc6euN2Ukv0MlCeTpBnKsOOJFfaZnaD+g4g92YWNac5CErL0URLygiI+K/sIl6I0bxBHzpM5Xcu+tkw4pbloBeY0ouK2CZ56rrUGlaZ8fjSdq7KAFOANLp+zdFxCixBOupgC1pS7M7QeWmd6B/n3BvUess5YscEah2e86ZgxsnbrvfmWg==
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by PA4PR04MB7965.eurprd04.prod.outlook.com (2603:10a6:102:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 20:49:49 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27%4]) with mapi id 15.20.7828.024; Sun, 4 Aug 2024
 20:49:49 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: dl-S32 <S32@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH 2/6] net: stmmac: Expand clock rate variables
Thread-Topic: [PATCH 2/6] net: stmmac: Expand clock rate variables
Thread-Index: AdrmqsaM0WqC9DJ8TumkGgCGdwvf/w==
Date: Sun, 4 Aug 2024 20:49:49 +0000
Message-ID:
 <AM9PR04MB85062693F5ACB16F411FD0CFE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|PA4PR04MB7965:EE_
x-ms-office365-filtering-correlation-id: 3e517082-a172-4f82-2316-08dcb4c6fb92
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?s2vJFxvmvb0+W6ADrT/gNdAXY2X+hruw2n7RrhZ2nkRTjy3jTcdHDAoGzf0Z?=
 =?us-ascii?Q?da6JXr1L2Q3b6NmtQViPgtXDc/eF7oHDypkJTxIOnPtFc2LVX8L2fznLHzkP?=
 =?us-ascii?Q?LET3ZjZwzEIaaPhw0vP/SsXeEG6Z0yuersF5mIZ2/UiaEfKPi8EUzhXQgKrU?=
 =?us-ascii?Q?HVPNrYrhg+sZ41AmrRxU/91Sv+X0+kGRlLKp231IlUNufwozNMrDI1NClToP?=
 =?us-ascii?Q?+fcYu8RO7/aF8k5yba2i79BA0OSjCTMiLC/mGV4YwLg8l07Uoyv3zdWhzbul?=
 =?us-ascii?Q?TvpX7bd1+RbOzsskOjkPcPddk7sSKie10cgJQK/Twm+92d9cgy7Yvohoviag?=
 =?us-ascii?Q?NkT3rkYu6tiq0xNtUA/QHxgWxaecb4qIDThRpo/f2iAfbj6OKuine/7Y1oBI?=
 =?us-ascii?Q?N8QpQmWmhEMC+dVOWmiCMoSL2OSiqdLZL6DZhfon5Qxv7baeGlbRCYCgtndA?=
 =?us-ascii?Q?gLKUF3yTZrgSGErN/Z/CYYPnhyBWiZXgKhYWZgSI58byG4GWo5p6VjBqN9Tj?=
 =?us-ascii?Q?JCl/hY5Y2wfWoCakRIReaEk0JRn2Kh6pPAZsbXc+JHMxm1zM2tSCaMF/Hb5k?=
 =?us-ascii?Q?K4SnNMv0wi2wz+mL7dN2wB0UUfGb7ofE8JXpkjQ7qxnbqKdbeO+hduruobrI?=
 =?us-ascii?Q?oWEvR4BVe5qFNH1klGrAqvEBd0n0hlZAXsZchSjqDCXlyKQZcILI+/ShTZb7?=
 =?us-ascii?Q?CZgdHMkk3N7keegVepuzSYqEiGB6RVfB9Tc6RXTiBvXAaKn3/k2ICVBsphcA?=
 =?us-ascii?Q?3BDIR5/ETz4B1d/ce0m0dxYazhE1lqwhFFAOTP/IvOvz0FrEYbYujMT9Lr8k?=
 =?us-ascii?Q?JRMnI03zIW0tjQ5/TYA4inVBUjOT7YDhBRj45gDxs/iFXz7VVsyHJAh5HQJm?=
 =?us-ascii?Q?C/P2Fmcs2S3MKdYQoVHTY6wHCrF1yWZWfBR92cbMhGznMj7fH8rLaeSiW7Lt?=
 =?us-ascii?Q?N4mnZnZSWh4lupfreNkZQLqVLfHtYxgVZr45vYJzhK81yzLThK3gPn010NqC?=
 =?us-ascii?Q?ORPlC1HtL5G4OaLQVk6OfeO2pSKm5SVe/t3jVSCQ/OXpU15Y6oQlJFJ+tzrk?=
 =?us-ascii?Q?Z0gjHQEoZSr3FqKk3szmPdErEdVgT9tDPelkVpSpx1cMhnYq6iWpHkOPu/6z?=
 =?us-ascii?Q?kYddgdtVLvQ4CkmVt8Yl/CZncrIXNmv0PrNcBdliUaWvO89/9w/891ICev5w?=
 =?us-ascii?Q?CfuJi1PacQNQ1HhOAvbPbFifhktqs1Yrj90hkVmrf359yHRvPF5IveEwVgAN?=
 =?us-ascii?Q?z/3zjdAISHD012VyOG73YBCtImmy+GMa4ROpMtN5lCieTymc8IuyH6ug+Ln8?=
 =?us-ascii?Q?3hzC6vwXsW/56vVu68r94KfI50Q1MLg/lOUDqZIer+Xd3Yb1lJCUTzmd2Er/?=
 =?us-ascii?Q?3sppEDXx4bGOPExthWdLLHLUQG7HqrqcYsWTuXKIr2fK3SmyhQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DlD+PusbAnObo1UJRM+QodCAuT8coSZq+T3nHaZuokB4+kpt/qP/dccyU9iS?=
 =?us-ascii?Q?M1Hz/FGJ2+LLl76uIo7LzuRxvcgTTz8AuvRh34Io+RcKP23jQ5+d46+MFHho?=
 =?us-ascii?Q?X5fqvtT7am6ThTbQa85b+hmHZCqAU/noI2wh5VfSzoQ16wXXIYk/gCjlD1VN?=
 =?us-ascii?Q?BViLipdcCcWe71JQOVGVeE1MBrGSom+xXExPasXhWIPp29H3REYrBJW1/DJH?=
 =?us-ascii?Q?ZFJwCAWVu9e67dRXWLLXkJyAilg8TBdWV705vq/vrdFr4jEcKWSNFcg1ZE1l?=
 =?us-ascii?Q?lt++1gmaLtPfPk5quy89dKcWwnqdpbzQ07f5ngSO+5AMv1HgzWECHWz2Vzuh?=
 =?us-ascii?Q?N930t4Ukp5NjRT8Cxx1LZq9ZEwgNZlg/ES2kN/1WJXDIHbvecpvrz0i/h0J8?=
 =?us-ascii?Q?y8riyd2wo2/1u+EMe4sbPcwkqI3FNalYfbCAZbS2xiGbPIghdglas0+qD/fD?=
 =?us-ascii?Q?GVPbpKy91solux2XmF2s3tfQ788VA+rHIUnVf6LznK13luQRuY0WU+WNdcLa?=
 =?us-ascii?Q?3lUh2kivv6NtaT5bwsj3LXJhG/Xk/7mW0hJyD7o9qBHZl8GQojbE60F051/1?=
 =?us-ascii?Q?t2896a8XpU2PC33CbSnNQ3d9YK2VZahuUpLyd+oYEqmACCT0zEfYiVeXNKvX?=
 =?us-ascii?Q?8SNAXu+SiUW4NCZE4ITa2YdgflYlhSKbEhcJEoU2kSFmbdcW8Ziv9BeAnu/s?=
 =?us-ascii?Q?+hdfqWYVEKmhOs2U/cHRea8ToCD2I4qqQG53zyLDfTVMcqf1HumxKS3c9l06?=
 =?us-ascii?Q?906Zv686zPAHPizvRNJZ+uZsXREFjNU0kYx022DyDDwrZlPwP0VG+c0pmF1y?=
 =?us-ascii?Q?oPWjkgHuGALKWt3lGY6//rC+bLY7fbwc1S9ZD+0JvBIg3CqCXw2Lygzx4RsV?=
 =?us-ascii?Q?Rwqzc44XgZZJGpl7G7ujCmvcmjNLUAlQCa8vgINSfh9sPPTEiIB1yN5E7XuR?=
 =?us-ascii?Q?3W1Gz5Z7tu2Cpk7h3Rloxnh8k63oDY/6T4xaGaF1yBAAPP4/4wp2XHWfRzxc?=
 =?us-ascii?Q?YAqjYVoxOg0foAW1VzNwW6ewfOgqHXrLwqE5l2vo2d3UJOookeLKWND8/dsc?=
 =?us-ascii?Q?DDbzORJ5HFauE6qCccG6u4ONdc8DdhnkWo+t3o2WBeskv2/6vBGJTGXjAJN3?=
 =?us-ascii?Q?6bsENerqH+tQGZN54VUFMmeXtFrwVW821E84w6SfUmRni5BeZQoUba5sZJ6U?=
 =?us-ascii?Q?+OCssXffyuE+0fKe9D4JC5S7yAkdT/4Jw+01uQOzrtcdLvI7H5NqVcew7KPj?=
 =?us-ascii?Q?hezNCRIPtRJeAWuP/i5oIyzAZaKAvPW5pKlknUUBcPyi5hvvp4dyVUsYePVX?=
 =?us-ascii?Q?gA3PTTVjfzAGwJt2pXeWh4Bj15GluKhn3j2ttYA3DO2H+EsJ5i/hag83MI5w?=
 =?us-ascii?Q?CMXrdxWdNs5957RG4bqHkXjf9KMd2kPuF133dNPcL24xXCXvTk92DyjV2aDh?=
 =?us-ascii?Q?7/X4JJgJh5N5Dq1qJY+I11UYvONZ5u9d+Sfuk9mVlgdE9NhV9gVU0cfyWJDf?=
 =?us-ascii?Q?nXRv7jEo9FKrRaMrGipwejyRIjjXm656Q6gmrp4eHOGQEY4waCTTzhxXfbt6?=
 =?us-ascii?Q?SMYACOLjQEUI68r+pNhR0UvIPa16Co/kCQ80Bu3h?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e517082-a172-4f82-2316-08dcb4c6fb92
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2024 20:49:49.6665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MvjY9BChH6JNreqE3unT0fAWCqtV0dYrrRsSNn0PALnCGjtgvR1PJh+QwJsx7NwYv+tQYsj2/iJEzhzqQERfGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7965

The clock API clk_get_rate() returns unsigned long value.
Expand affected members of stmmac platform data.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c   | 2 +-
 include/linux/stmmac.h                                  | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/driv=
ers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 901a3c1959fa..2a5b38723635 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -777,7 +777,7 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_pr=
iv *priv)
 		netdev_err(priv->dev, "Failed to max out clk_ptp_ref: %d\n", err);
 	plat_dat->clk_ptp_rate =3D clk_get_rate(plat_dat->clk_ptp_ref);
=20
-	netdev_dbg(priv->dev, "PTP rate %d\n", plat_dat->clk_ptp_rate);
+	netdev_dbg(priv->dev, "PTP rate %lu\n", plat_dat->clk_ptp_rate);
 }
=20
 static int qcom_ethqos_probe(struct platform_device *pdev)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/driver=
s/net/ethernet/stmicro/stmmac/stmmac_platform.c
index ad868e8d195d..b1e4df1a86a0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -639,7 +639,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8=
 *mac)
 		dev_info(&pdev->dev, "PTP uses main clock\n");
 	} else {
 		plat->clk_ptp_rate =3D clk_get_rate(plat->clk_ptp_ref);
-		dev_dbg(&pdev->dev, "PTP rate %d\n", plat->clk_ptp_rate);
+		dev_dbg(&pdev->dev, "PTP rate %lu\n", plat->clk_ptp_rate);
 	}
=20
 	plat->stmmac_rst =3D devm_reset_control_get_optional(&pdev->dev,
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 7caaa5ae6674..47a763699916 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -279,8 +279,8 @@ struct plat_stmmacenet_data {
 	struct clk *stmmac_clk;
 	struct clk *pclk;
 	struct clk *clk_ptp_ref;
-	unsigned int clk_ptp_rate;
-	unsigned int clk_ref_rate;
+	unsigned long clk_ptp_rate;
+	unsigned long clk_ref_rate;
 	unsigned int mult_fact_100ns;
 	s32 ptp_max_adj;
 	u32 cdc_error_adj;
@@ -292,7 +292,7 @@ struct plat_stmmacenet_data {
 	int mac_port_sel_speed;
 	int has_xgmac;
 	u8 vlan_fail_q;
-	unsigned int eee_usecs_rate;
+	unsigned long eee_usecs_rate;
 	struct pci_dev *pdev;
 	int int_snapshot_num;
 	int msi_mac_vec;
--=20
2.45.2


