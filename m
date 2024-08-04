Return-Path: <netdev+bounces-115592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C0C947090
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 22:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A96C1F21722
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 20:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76C513A3F0;
	Sun,  4 Aug 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tHuZeLIZ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8315E137932;
	Sun,  4 Aug 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722804630; cv=fail; b=icTG5xszmrq4KtCE98E/zbSDcaxYitZDroGstJlfGwaXSQwDGOFhVSiDzRbclHkUJABwdbxJ21bfkIHxHxMqSov7VW+TJHWV4Gm1RcqzrQ50Xr8q6pHbna7ymn5kD9m76Pr9YBekbe9sM3GycNqaSI0fc/iG8cdfGbXYn++O7PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722804630; c=relaxed/simple;
	bh=zSt5RuGrCAB03t8wJRaHtFuSXUZq8vpdAvTJioGHhag=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e8tQf3NVDmrbGMCg67m7VprJOXa67Lo0Z04/n/0vYsaKXzhW/coI/3YO1HgfC/Q25EhXWCOdnoOFrKlqvHxJjbvYnGnLEo5/y5aYFZKdctKluLtxAGDrskBrzPNqfrAr63FzE7R/YB8Gxfc/JOOE6VNrHFZanYf9TFogZ+YX100=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tHuZeLIZ; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI1aNdeu/fT68LdJ9MonaXUERBbtAehru6/kxYdGGbXcOicU1lclLaIVn0kcqJXAPPA6NwRxnfRoWXoemtxOQFVlJe69qeWDAnAlBz8Fm7nMs/lhiQ/rNAiEKMdWY1wC2oGfiqpYe8PumSbPQQbo506cZLoPtGh9N+sKMJAvmVB/PDXW05do8hZ5Mo2SPLt3OEvvsz/uOi7EacDv9aL0gj7jSK/aXZJswzBtdMgzXzKI1L00D6UfAQILr+JHjexXEwjYnSqJN39sW0hSfC1FdHQ2YCVFIFtV6CYE/Wf2BnXUpX7LRjsTBAmXHK2GFpB8oUOY5xwnCie/7AHTHuOOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pk684LV3ynuEpTxv6M+A6nHw0iSspAsQbxmxZm6K8rU=;
 b=R6jIOnC04q1B8JIyW6vt+aEXc26Tz6SR81jCIhHnUUeCfDXn+1AAvVfjGg3bdCxFOpjr7UxxxAXJR7+xWlilWDNStrNVPDs3LfR/6YaAzKe3Lib1YGqnEdZqbVRGvlkbaGrvDWOKNAZBtTpdP33ftwaoqCaW//KbFFhcIMhiLm7kMNfWIIXcRvmjGK0H226wWaWYPi+cwCSAp9H1QzKwGUQpplMGPb224cb2VCu21d5Rus6BTdI7fFwwcDFR+17hRrGLHFugJ4NMCfvje0l0g2z/KLhNZxy6rhsMZzPMvr8wrhMUQ+IgSibNO4/Jj9d6qZre31As1sjgp0AjEeRnjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pk684LV3ynuEpTxv6M+A6nHw0iSspAsQbxmxZm6K8rU=;
 b=tHuZeLIZShKmjMHA6jNRtXVhTCFFwSWZrwC+ue+AS5wvxri1ihfH6aHYiIUS6UIUvasTwwI2wwbXxaPv9BE1luj6Sgl09hTG2nF3VDSgHb36mn4DqcNqkAW0wyIu4N6Az9Nx6FuR/wS0XpelEFSdI365eLJnAbzfn4KmcdMHBcmbPYlhCNyWeKLGI+htGgAHI/uK7fjAOtk0LXF22tkR1LzKFw9FIzf3JfYt6dE4lPpLAnDZcEs+tRKlW2YJWwqu0QWzq8CTxgTi0Uv3UXYicEEEddpaaNA8sIlVRDmIUbiS8yOCTuRIuzJJSyqCi0W0ppp8Irva0S0qPsUlEI86Pw==
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by PA4PR04MB7965.eurprd04.prod.outlook.com (2603:10a6:102:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 20:50:25 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27%4]) with mapi id 15.20.7828.024; Sun, 4 Aug 2024
 20:50:25 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: dl-S32 <S32@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH 6/6] net: stmmac: dwmac-s32cc: Read PTP clock rate when ready
Thread-Topic: [PATCH 6/6] net: stmmac: dwmac-s32cc: Read PTP clock rate when
 ready
Thread-Index: AdrmrgHXkavt0RGESJ+P/uF7MetJwg==
Date: Sun, 4 Aug 2024 20:50:25 +0000
Message-ID:
 <AM9PR04MB850624C6D994A879E395D3EAE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|PA4PR04MB7965:EE_
x-ms-office365-filtering-correlation-id: 3e2d5d09-4b3b-4f3c-3a6d-08dcb4c710c7
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?K29UH49iorDjiYOA3R6kAjAedIOD2+I2AqMsy7/nmj2wwz/DtdcdjQ6q2pPN?=
 =?us-ascii?Q?5msSHpC3LN+oodA0yW7EYAHS179jl/X4i4fjkaTQIBHxlzv9UOQg/QKOpBN+?=
 =?us-ascii?Q?8CvuEIOyEJ+Z+evsS1o2Xabtxjsp6OyBEmIlB/DrFbStOWqAqf92D7THLU5k?=
 =?us-ascii?Q?cvmfiz0FOZLs6k6FaQrUyu80+c5RTFvr1wyM4p+hsdFSzn+/iZlInPzsKd3v?=
 =?us-ascii?Q?cpTkh9Kng7RL2J3ZZLii3VCBYk2oBPArvFncwvN9FljCA5M8rz0vg4BTAC0L?=
 =?us-ascii?Q?0FXIPm+P+gPF5oU1C6Y32707XTn/yOrQnjc8B5M1+n8bcBHiIxpmrvPvJrBd?=
 =?us-ascii?Q?uV3++TeuRHc4j5DZS22pH48CDJ4ks2k7iGSlv+nfRky+LNmifEm9VzWOcRrK?=
 =?us-ascii?Q?+Yt/yXB6jiYVnkJ1bOcQTPdbCrGPSPsJKzNzQWK+nA1ZQ1LAK7tthQ7i35lP?=
 =?us-ascii?Q?K3agtiv8NA5lOuw685cSNmUaEjjJVWQ7v8ZYkRX/2DsDatwmzehb6n8tshTr?=
 =?us-ascii?Q?28OBZJkVdnA15UZMMV4eurGzltsJcJPQdqE0z5DEus0JY7QuBA5CQ8tti6Mu?=
 =?us-ascii?Q?/aH917+EC8j8qJXCbOZRFIn/MsLTNd1sEnwObSf15n6xEtTiFP+N+gW5U9CK?=
 =?us-ascii?Q?TMGjc5q5ZML5LKTI/ejiL7AGDlnJPNjLTvFQ9zhZS9LjpF3RD+KYmE2UMpHH?=
 =?us-ascii?Q?pN886gtt4BhSwrMo4r3SxJyF/kQd4BFCcS13vUm06/KTCSov7hvrEAXlBwQ2?=
 =?us-ascii?Q?57+7FOJycX3PFEAWs6M333OZ6sQo+Ej8GalOKQzOWmxeIey5tlwRNrjR5jym?=
 =?us-ascii?Q?QYyqGdS9Xuh6AtExa8wO44JA0IcU12u/gPVbfvClPHgVHTJkIQXfhp1XKdDd?=
 =?us-ascii?Q?mldgclq0e4diIqhuSDmy9rCpwKTOT7xSm3U7ekiC9/h1y+srme9wCDffBgHX?=
 =?us-ascii?Q?S63x2/RcgznWsHNxCSVsMykWa4wvQ+wbQIv8H0ksT6XE45ZIhZQIHuAHZKzS?=
 =?us-ascii?Q?CkQad8wY74oElu55qsZGPx2RX5Wo6842azeRLxjdHH+FDd79h5vC9CFgjk3j?=
 =?us-ascii?Q?5Db6T2YBrtRvwPrQiLKfIZMb1RzlbZSnWavIulIOwJAsuxdFYWvEZXZjbfMG?=
 =?us-ascii?Q?FJXs2lkGd7vnN//ggTMUj0zsKT9MFKyiYrPRxvgABtH4xW3z6pxT6wBELL5n?=
 =?us-ascii?Q?sz+6ay13X0NN3Rnshf0IV2wn+40Btfni/+zDL/kFdU6jDJ2L9ey+AgkTuOT2?=
 =?us-ascii?Q?6o0jZ0bpOfduv0zMOpdWIEx4Vn92Y4TihcVinjsdw4IyuRp/4eM/bJSKvtvC?=
 =?us-ascii?Q?/C449WFRkbCK2F5s06sopZWJxMD9NhOi563p46IOPzMGcrRpU7fWiqmWNu4i?=
 =?us-ascii?Q?quKBHqxHSJbYMtVX8CKnoT1eiU632BFU7un0aw2l26PSfOnC0w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rwJiN/hwSTt/sLrNysZVruLj3jKxjbI2DbntMju7nRuu0pWhYZwqi3E5z8+X?=
 =?us-ascii?Q?xz9lI3f58dN80Y7uopN1yyG8bRLkY4gE0ACUl5nMGFdDPsKYVyKzOIRA8dTy?=
 =?us-ascii?Q?9qmdvYGXadWPR3EzDii6KxqmM+EVNJP2O2/9r95ueFTn1evMcrrTwlysBKH+?=
 =?us-ascii?Q?lnfKfmIDrxGPyAQ7hOhDIxNfv0U/I9Xz06v98ediN986EiPsdhJHymNKLOD0?=
 =?us-ascii?Q?1FFG1cMhCTKvwKIAt3uIBPLcQcqgkKRHY4FhKNg3qgJS1Elvs4B3XtaZVt0V?=
 =?us-ascii?Q?zOD5dl7nDv7/nW8cvJlsNefmvokM9e6+YkDQQrf56xhZNyzGcdOyW0fvR+PX?=
 =?us-ascii?Q?D9HUtaIpUAeShtcW1y6eTiRSISId5Jq/EYoUgWYSNgtBsZ0yE3T3aF3Yv1lF?=
 =?us-ascii?Q?ha82kTnk5OeX3VBxtwDxCUsDMOmC34IMtK0AMFA2lYEolCwllRe8GvXzgCqx?=
 =?us-ascii?Q?tTGiGoHjVSCm16lRvp8xLbMLgDtEBqcBq1RFxRBh0XU9///Yr1yrPB82x1tl?=
 =?us-ascii?Q?R7YdoCsNd8DKauAk8qUR9El8aVOBNyeR8nQGgUMO5kqXw3sTxkzsRmKm3rPz?=
 =?us-ascii?Q?F3sUFrPNBEAY71q2NcwdlM6PywAWPkeQKLkcpP+OKlTek+UScmsMGzljHGdF?=
 =?us-ascii?Q?S/WOjso5fEtUQZI6Xe7HpEfLMNRyhmBNL1T/EL6lJZoLUmC3aa907omz69Gc?=
 =?us-ascii?Q?VSrkv5tZFrWc/dM7e3mrcWtfoqv3gfLy25GMhOmwGs+mdOTyRBxYfo3X4tMt?=
 =?us-ascii?Q?NnZP2PZmVDJFP4Nf+TddRaBhxWb6PZLQOsCTS/ndQdfN0iXyhtxjKnilbL+s?=
 =?us-ascii?Q?qypRiUKTt/sdPgpayxroEETyQ+2wadsgkr8ru6bj0YFf0wijirzzWRPXHow0?=
 =?us-ascii?Q?/wIuTWgtyUe3iCo/aIGy4yfC1KHDR48fQqLjXGn2zU01c9MFBgsldv/88aC1?=
 =?us-ascii?Q?Tki1eZ0+m6rEunWwBICYTEgVaep1UHh0bn9CpRKmzo7OsS19F/Pvn2AAphgc?=
 =?us-ascii?Q?+Ll1eNb4uYAkc/uqvu71akafSDa1vB1VVTM40ekyi5AtdjImVtGG1rcO9c37?=
 =?us-ascii?Q?cGS4xInoNSoCE9dFPJ2Jer7fTcqhYixJ9W4i3adtqwK5FrjyLttElkho8Ri7?=
 =?us-ascii?Q?j0+F71cMerPvob1ejnkLRKL7vESKMIU64nn3ME/574QMXmDjBksK9xVSJaic?=
 =?us-ascii?Q?o8PYoGueSQclUK2XeTQGdx71I0/fCWbgBiYEhGDbqZPQYpa4ycCMnexCyMMO?=
 =?us-ascii?Q?hJX+Mrw92lmfn4YSGVoIGB5bD95gzHWaVJh2i6RSQeIgFbp4+CUM0oay0ZBa?=
 =?us-ascii?Q?JbwnhDe4FcMBbPs2aB4oFv+MCgOGI39rBb/nRxzNpFDezkbcfdX4mG2/3CPK?=
 =?us-ascii?Q?bt8Xij+1ErcBP+6GwUEWx1BRYClZ1M3zPr/Dtw+HVOmbgFFSCzsKpKdmPYtA?=
 =?us-ascii?Q?38z02uQs7GCKIPMJUz5EZBpiJO9KQx+NSjrsJRJypOmGbNjSmKPMkyxh+HSx?=
 =?us-ascii?Q?ipfq/6IrvytenZdb3Ab3B/y3y/x9AVf+Rs6EqCVkUripleO9Gd26FGSEXIlv?=
 =?us-ascii?Q?Oa2UuZPvS7JTBXpOh1I7pjZWQcJsaI5UFAOCZVy2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2d5d09-4b3b-4f3c-3a6d-08dcb4c710c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2024 20:50:25.2581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbhsZ0uD8PuqvxheAmmy+KZ67/iT/ox44KEhza25TebgbEDvVdiPOZ+IPqWWe/nZgEZH0uHvDiDEsvJzZEUIrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7965

The PTP clock is read by stmmac_platform during DT parse.
On S32G/R the clock is not ready and returns 0. Postpone
reading of the clock on PTP init.

Co-developed-by: Andrei Botila <andrei.botila@nxp.org>
Signed-off-by: Andrei Botila <andrei.botila@nxp.org>
Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c b/drivers/ne=
t/ethernet/stmicro/stmmac/dwmac-s32cc.c
index 2ef961efa01c..ad05f72fefbf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c
@@ -149,6 +149,18 @@ static void s32cc_fix_mac_speed(void *priv, unsigned i=
nt speed, unsigned int mod
 		dev_err(gmac->dev, "Can't set tx clock\n");
 }
=20
+static void s32cc_gmac_ptp_clk_freq_config(struct stmmac_priv *priv)
+{
+	struct plat_stmmacenet_data *plat =3D priv->plat;
+
+	if (!plat->clk_ptp_ref)
+		return;
+
+	plat->clk_ptp_rate =3D clk_get_rate(plat->clk_ptp_ref);
+
+	netdev_dbg(priv->dev, "PTP rate %lu\n", plat->clk_ptp_rate);
+}
+
 static int s32cc_dwmac_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -204,6 +216,7 @@ static int s32cc_dwmac_probe(struct platform_device *pd=
ev)
 	plat->init =3D s32cc_gmac_init;
 	plat->exit =3D s32cc_gmac_exit;
 	plat->fix_mac_speed =3D s32cc_fix_mac_speed;
+	plat->ptp_clk_freq_config =3D s32cc_gmac_ptp_clk_freq_config;
=20
 	plat->bsp_priv =3D gmac;
=20
--=20
2.45.2


