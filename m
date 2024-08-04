Return-Path: <netdev+bounces-115587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341FA947081
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 22:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80225B20A24
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 20:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD6577102;
	Sun,  4 Aug 2024 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sF8WQm0L"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013029.outbound.protection.outlook.com [52.101.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE022095;
	Sun,  4 Aug 2024 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722804580; cv=fail; b=pqwXCc0VgRIeybip9tOXwk//vak+8nqEpHk+Oy3g/zYFYhy/psWTRgXlJ43uS89DFqRf8gEOxS/d/4E9ybKTn1z1AgzPxPR3cOkP1u6/z47Kr9tJz2+LcWqMlPE4y0+YfPCe7JR7zHshzX1iG53gVpFR8kxIPsvoqipSwRRtfHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722804580; c=relaxed/simple;
	bh=ZKX7VytUsWlSGRGU3wmsS3teLwQ6HYWpc4tmuTGjNlA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kgo6CfB79X9Njx8oQu+U6/yz8uMuUXAgCcSNuS0pOopBQxIvMBzUSf6Yxzyhd+1SRzaXSgj04r1SwQkQtqCLEYtiX0fOYJttXea2hIYl4VuOf7wW6Je5jS1qoV36FEqVqTBE9kq3YEU28Estcg9VBPTf1zK/8x/9o+hUFFTOwoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sF8WQm0L; arc=fail smtp.client-ip=52.101.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwXIkNCKwXQh6mgc72/SwAe7lcYKFuJ7p978+Qx8WSZTqZjLvle17OCoP3BCk//YLQS09hccnMhTojvYB+KigDGtTpivxQDinmK7PDwJc3QDns6fP/LdOcxS2HF5/n8JQYYoE9sjJQCLJ5rF90ZLz/OTZb/UidjpQ19BxdMI7xDFyvpatsfEpCdq1f5PIPgodfEMEbgQA5O1GHqocQFEgKRiDoKmI9NUukrDIduSP6BYpKO+ZgonBaLszS8smvTov8GU61UUPOVY7Zc97aFCGmDzY9UPSVfvqO/YyD0d02GP9ab74Trg9HXmSeZJv4mnjmoo6Qqwk5scSaKIjKQSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEVTv0FWlk8JDzY0sd7BIrVpqlx3+DsdjiPVsgRhvLY=;
 b=HCiiIybldg8x9U9ZertvqjXvwM6IytRTXqGWL5MepibbU0MeMDyll8Ak8V4b/odme+5YLOr3HaLpprai4l6YxdcIfEqy5KAuWB24CmdN8AD7n3JGzRpEOdEzZIflDczYtqJSnDK0P34RPp9j+fZWv91jIGdXS75/3FmffiKTvvGi781mTRB1CE0L/ZWVE3ueAkNACgZsmmAKrLAc5ODwwh531gMU46AhjEMNX/bj6dY3LuL5bH4qXer+VTIiqmHFlVx3cMnBIEKPwtK7I6StS0SfMkyObcIEeMzxs2I+1puf+hfhOiIfP3DiD/ueg3D4mR5qYAayseQg4h3LVmdagg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEVTv0FWlk8JDzY0sd7BIrVpqlx3+DsdjiPVsgRhvLY=;
 b=sF8WQm0LyX7eOnkY+XgMaavsWxwyozQ9+ivGipunsaZI55QmVva51843X6IPiiE0wKnXJL1Bxb824EYTXNDrB9IgF2I4kjtbWTb5VsHjk1QjGDwXUNCCT+seskAv3ZqGxy6dbwzQMcCenhKS4K9wZBYPbAqdELeR4HjwJwL8jpYs9kg/InkozOVGRqop8GYBL8MtkZG7XH9rInXQw+6Q4zTu9YJT4R3lBtiYLmY979Eks5Hsjq8/oEYr+trkM2k1RV4JBa2kuAkBWgghLJezd2WJTX3yWAZKG25aYhsUfjrkzxrRtoTPKiWJHYede97gFljG2oUyScUL4csSQLw5Rg==
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by PA4PR04MB7965.eurprd04.prod.outlook.com (2603:10a6:102:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 20:49:35 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27%4]) with mapi id 15.20.7828.024; Sun, 4 Aug 2024
 20:49:35 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: dl-S32 <S32@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH 1/6] net: driver: stmmac: extend CSR calc support
Thread-Topic: [PATCH 1/6] net: driver: stmmac: extend CSR calc support
Thread-Index: AdrmqCAbIYfhhpSjQm+gwLO5S8kGvw==
Date: Sun, 4 Aug 2024 20:49:35 +0000
Message-ID:
 <AM9PR04MB850628457377A486554D718AE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|PA4PR04MB7965:EE_
x-ms-office365-filtering-correlation-id: 11c2bb2b-6ac5-4009-f34f-08dcb4c6f2e3
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8PdM7t14UC7m6kvj8gewQKYr1uGwziconZg3kMAjOPD9psoFqv3yLllHQ5UM?=
 =?us-ascii?Q?IcQQH0G34a0AY1bzzhMo/hX4lxUdU0uMwYPL8ueg6gHG1VePyvautTfO0022?=
 =?us-ascii?Q?H8AxYkIPupQDtLQ3qttTWPz9PGBLeK1UIpgvUQX2Bx55e4DAvsRodAae6ARi?=
 =?us-ascii?Q?Xfca6mYMor/xsPVkRp3HGHkYi3WBeLQNizq6Xe5Cv6GwL46VSijyb0jxH7O6?=
 =?us-ascii?Q?3ZY8Jo7L5tNHtiCIfzyllSNmW+GnJsD7Eir5hNsG47yPB1u8CiNKKz9m/Ths?=
 =?us-ascii?Q?pEdZ8ajeKJ57Kd7vsG9eg4Vdi6clvboMCQ0fb53LPtZtGBBjEi9bsRw+3fqT?=
 =?us-ascii?Q?tZ2V1fUDgVekMB9Y/vMmpnEYvnknac9Lmo1H2gKzugqD6ke7TQ3JuhxE29SR?=
 =?us-ascii?Q?83k+GHZT4HWWQipmZwIEJh5MfTVM/HuXS97N4NB4YpWE8AQMMfy86FYosNQS?=
 =?us-ascii?Q?vBMp+2sgxeDQ6o8PIk4Hof/2ackDh6m9jQEJmXqkDuQqJeUMgC//qxBko/xO?=
 =?us-ascii?Q?lcJc/K0cBZe4u3nfPnaXWnVnBpVMZt/qWMjrMHQj33t70U0qD8Z337qGuX/J?=
 =?us-ascii?Q?34LAPj/5CVvJtCSWcGYozw0Px0r9Cv8O0kmarRhhIy4DGWJPBz7k6vhrmagU?=
 =?us-ascii?Q?wviy6ZmywJl5WgdOcWvJQeJRfd9MJA5WjWKNPEc+ik4ay69vGXmJgJszyCB+?=
 =?us-ascii?Q?wVDoT+sf9TBhni08XN4Y4GZOAJ7+YDtm2pvAekvXr0oxG8tpD3m15Ac8U4JA?=
 =?us-ascii?Q?hgsETlyjxiP4uUPad7FT4AI2zmHfa7fUuTnUGYKMEG7UVn/gDYdYLRsuQK1b?=
 =?us-ascii?Q?s2K8JpZlT7rVNwMtFejEu8MQhtDTfwgUZXnLkXlWC4c8qOLay98Z0mZlAQ2e?=
 =?us-ascii?Q?fjhQGttjtXquCeeTUZ6FZOtCNE96X7LObY/N4dg3urj7ZXlDbGjYU6yYl6Wh?=
 =?us-ascii?Q?e4Rrfs0BMJqYbchg0++6gFOvHuZ5B6oDbr+OKA9CakAEOILAiG0/kGBjxo0B?=
 =?us-ascii?Q?rivVKaEVBFZSWdW+bFPvzyKmROKgMT7EExNYJh/V9NkScNRPcWcLHiZBy3nb?=
 =?us-ascii?Q?j4UkOORjBjaNUOR4PmDNrFbXxjcWG4wNYSFdlyoTpIEF2CHfIS6BK6XpCvKx?=
 =?us-ascii?Q?Y/QjLsF/s+o2MMz18nPDrL9Nqqmzg9MuvRKUFgPbw0Pm1lw40xS4aK28SDpN?=
 =?us-ascii?Q?MnFXK6KEWnVgUdSsBsPNc3/XatApi287lCEMUbungcqZXUx/9nQ/a7Q28N+1?=
 =?us-ascii?Q?cEOZjaVwTQKnGtQdl8wj994q7kqNhR5NhveaRyIZn/TTfl/pdcyEIC7AyArj?=
 =?us-ascii?Q?Nl0SdFk6tHFNMpbW/HW+q8jS46B3eAisC0MgDhOuuiEMTIAfVGkTNeYWx57b?=
 =?us-ascii?Q?2pw0qll2ZiN/HaKgiwEqxUxOqVDeauaqICZK6u4wfjloyK+wjA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?I2JiaV5EvVqLSga3PeujftYM58AZFNVnkjWlb3UarToGrHIUL1gX11iuPNSB?=
 =?us-ascii?Q?9jTmr0LSVElcgvW+fF9dCcGD9O2ipxWHvgnkgHmMqz72WadtSKhUzNnh5lzL?=
 =?us-ascii?Q?vjGprPLJI/r9GwQKPIU5f94jT8gI4bbDcFAOC1nB5jFx/He/cbapn7fWmIC/?=
 =?us-ascii?Q?D9pN3+xZgXkF7AxMzodKsVFuXz6JaEtXVNs9vFrUIADDXAkoQNGilXpU1iEP?=
 =?us-ascii?Q?Ravt9p7Q3KX0gm7X7qm7rs1k1f/+Pxy3Vl96YhMeeQyp2nHw9uJobBzU2rps?=
 =?us-ascii?Q?+bDvNU0zKbEFTI6yz1KmogmqRV93sjaIulHmayq9o6BPZvqcwNIotPcpjQFa?=
 =?us-ascii?Q?6sCK4gPEdp//SbFgse60gKHSeRZVelQhjFmmF8bBwZUa7ZEwkbgbbqest8y3?=
 =?us-ascii?Q?nQlwEdt897Q8DZM9+EDqyjgsPSykyeay+MgdrNshrxtZ3Oz/U/r7z02NzTn9?=
 =?us-ascii?Q?IMOi+alvj6PLYr/88AOlEidbInpK5zXb2buLWysXjwI6yt55aQNvjjMIdnFv?=
 =?us-ascii?Q?maP++JgnF1sxsSMvQK47cl9CxEcpkN16UkO+CPGpliMFTuqPUfsZc1mw2hrq?=
 =?us-ascii?Q?WyTLGA4AGQ44YMiySjZNOErHNoymEXYGI8BYIiWb3LgjaF/sq5g7VuLaax7U?=
 =?us-ascii?Q?fXdyLc11docmEqNbBvu/7KLwCx4Vx9Tdv4BOWFPWvLJQZpnpdxQ2BaLNr4xV?=
 =?us-ascii?Q?lTi0fsVRm3kxQQqJAE1+ga+xNP4gbsbanr2NXjGZ77vEySwItY3qJzntK6sM?=
 =?us-ascii?Q?M1CGM9YvPjRgko1dxxriBYz71SXcNla1LaTZGX12kMbMJc/X1x8ojzE11R4S?=
 =?us-ascii?Q?VDolKeFEBWVSlaEarQ2L+vjxk0EZeHquOg90rauSl1/WulIgJICR7pLkCEG0?=
 =?us-ascii?Q?wM5f4xkSdqATc+SemwG172+gqPsc9D+5mmXZ2QF2K+AQk2HMkCz6ZhkerNC5?=
 =?us-ascii?Q?0FK74Spl7DnISbP810pS5UQOVCrDXPxdArNsZxptcRtnIKR5EBF2hpUbf4CW?=
 =?us-ascii?Q?Qi5ETrxo/KmcR2NG8Fbx85Y5koMJrP2O3Hwzj/aUwoADdtEY3huBYvXJNv2c?=
 =?us-ascii?Q?OLL9nZ/ojG3BJgPLf8obVJrf4scLDBdqrGqCgMLlZyQ7un42jx3OltxnanE7?=
 =?us-ascii?Q?YDyRu7ANEkwTlfvwtPZwv56mqilBQh0ptjGGcQ+e0WDkTwVz9+nDud1TiGbO?=
 =?us-ascii?Q?Nq8psaYQm31HwJv966ceFExOdDzdwoRCqD7awZ7sRp9ILyxFPbY/tvRonZi+?=
 =?us-ascii?Q?hQG/lwl6Jyf1pQBJnE0xyjju8/2LkVGpcA49rCzfEmg+tAEzhpOeL2S2cdvH?=
 =?us-ascii?Q?HbVN4FVZqF6oRuX71tpkKjXZZ4ESeFbRB9xivT2yYucnAkerMiMQEkBdt1hr?=
 =?us-ascii?Q?gklgDJR3jZnYlapSY6eqMleNGKn3zUjtpBOI64YVk6zXA9Lef23RFetHeAW0?=
 =?us-ascii?Q?8d4AzzMKbvem6X/qhN/grRKeO+PctEYsILhgi3sD8UkAwtYPPbUrAYLnzzjd?=
 =?us-ascii?Q?XCVicsxeL0KvoB1zms+Z1YcRWBv1TeFbFw0OeFT7BUBMjb4EgGtDj0zMr6va?=
 =?us-ascii?Q?clDzqhm2cGoRAhOiKlsA6vOC3H1V0jF70ffq0iEn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c2bb2b-6ac5-4009-f34f-08dcb4c6f2e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2024 20:49:35.1159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAmvWBhtx/e9gSVQD0OGovZ1Wi8Wl3i1kakC8Sif2Hahsl+e+04T1Os7TdWp85xG6L/FpHmBKp+3npVcOCO92g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7965

Add support for CSR clock range up to 800 MHz.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h      | 2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 include/linux/stmmac.h                            | 4 +++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/eth=
ernet/stmicro/stmmac/common.h
index cd36ff4da68c..e90d3c5ac917 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -256,6 +256,8 @@ struct stmmac_safety_stats {
 #define CSR_F_150M	150000000
 #define CSR_F_250M	250000000
 #define CSR_F_300M	300000000
+#define CSR_F_500M	500000000
+#define CSR_F_800M	800000000
=20
 #define	MAC_CSR_H_FRQ_MASK	0x20
=20
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index f3a1b179aaea..ac80d8a2b743 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -324,6 +324,10 @@ static void stmmac_clk_csr_set(struct stmmac_priv *pri=
v)
 			priv->clk_csr =3D STMMAC_CSR_150_250M;
 		else if ((clk_rate >=3D CSR_F_250M) && (clk_rate <=3D CSR_F_300M))
 			priv->clk_csr =3D STMMAC_CSR_250_300M;
+		else if ((clk_rate >=3D CSR_F_300M) && (clk_rate < CSR_F_500M))
+			priv->clk_csr =3D STMMAC_CSR_300_500M;
+		else if ((clk_rate >=3D CSR_F_500M) && (clk_rate < CSR_F_800M))
+			priv->clk_csr =3D STMMAC_CSR_500_800M;
 	}
=20
 	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I) {
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 84e13bd5df28..7caaa5ae6674 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -33,7 +33,9 @@
 #define	STMMAC_CSR_20_35M	0x2	/* MDC =3D clk_scr_i/16 */
 #define	STMMAC_CSR_35_60M	0x3	/* MDC =3D clk_scr_i/26 */
 #define	STMMAC_CSR_150_250M	0x4	/* MDC =3D clk_scr_i/102 */
-#define	STMMAC_CSR_250_300M	0x5	/* MDC =3D clk_scr_i/122 */
+#define	STMMAC_CSR_250_300M	0x5	/* MDC =3D clk_scr_i/124 */
+#define	STMMAC_CSR_300_500M	0x6	/* MDC =3D clk_scr_i/204 */
+#define	STMMAC_CSR_500_800M	0x7	/* MDC =3D clk_scr_i/324 */
=20
 /* MTL algorithms identifiers */
 #define MTL_TX_ALGORITHM_WRR	0x0
--=20
2.45.2


