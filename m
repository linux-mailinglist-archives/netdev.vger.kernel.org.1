Return-Path: <netdev+bounces-220196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDF6B44B82
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79521C80AFC
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 02:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF7621576E;
	Fri,  5 Sep 2025 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aPnNUkTg"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371713FD86
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038292; cv=fail; b=pW3MeNT4fJz7neLje9VyAKjqxjI07FJ9ZZWAmFd2KVHCuQpz48hITbUg+7xqqY9eXnVEwIXGbguGxL+awid2VbmmsOjIk/bPoz4gp1Df6wdw7KLkMUXoDJ9MOPOPoqvi9PD9Ticp8IWQt6w0hOAKo55ESmZyi+gXad+q2kzZ4Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038292; c=relaxed/simple;
	bh=Xe8DmF3vf7oh58oFWBUsWch9flfmN4NH6TDuY/m3jVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IrgfUfnz7yrY5rlnhY98rYIYiuSIMkH3iJZDMLhAMrOKIwxPtYjV1I/xns6KgE/gBRz0sVm8CQ2FT0i8FAkvOHKXbn1rgUnntnVWJVm8xR/vz3dF8oozg6WiyoC5ti96uiRnQS/voiWijWkBoxqoV7XKiv48F4ngd5UKbZtcsII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aPnNUkTg; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4SSzWeN/xjKl+Dr/xnpqiszzMIj5yAihpiuApT++XParKWZKYZC75/xbVafvUqe3ZYc8CaBu7RkwfygFJ9NAX6QZDBdETXJ+9QGrh7KS4Xqhp/2nCMYMY/4mJUGERhs9IXyi5quTkfYq+fa+iSBOUtfPAuT1EvbVFfZ7deFxjeku3bsBukFjm38cgFnNLAqE0nL6OKFTfTscA9mFDuqjrxATzth9vLURN2a0XqYSfMjX+9SAEroiUhe3IOSj9RKj6c4e4vGu7gqqf3iODDtFdha48tJAWEZTQ2uq5LbqjmiN6iOB++1qLq82H4BEFLdTMFgqiFsTwzZmZ4oTeIRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aZBu9DNAx/T+9ws3687V7uDkCm3U4+s43Ru6HuyL5s=;
 b=J3u4qhyClOmZsxnpIatscJibkVM4NEIP9iA3/87E7k/leCfeTPr8K0juos3jAq799bazT58xj4e7KtqYYQHwT/Hn5xgQRvMpvy2wPA+CRJDgMDJYOVLResEelMH+n+h0HmHEJwWqUc31OxNBSLrswUSrllY+rfPoutDNfpsaMFKwYZK4gy+v6I5Cb35TFB9d42Dgn6JM1QRVYrbHIHxHETIIiTSwt0LAyyQQQmgE1Km7UzOfLFeENhmHXmT+XLek0CVwoV6FOYGTQNLx4I1KP7rBg7sC4xBTWPZ1nh607tgLPALrjvW2Axpo7qVTJ+/xADYWq+UwezjL0A/f/nB0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aZBu9DNAx/T+9ws3687V7uDkCm3U4+s43Ru6HuyL5s=;
 b=aPnNUkTgRrAgf6vfkb0834KO95kD5WZG1WZQXUyIK9PhC/Eqp8AIToTOefEmBnTBLJLAEadh21rNtriVoQiVQPHs7IVv4J/+iX57A6adYQpGciN5hKE8eOAn2oqq5vhate8ysFJ9Us+/QSgQqhJ0nqbGojxOEAgWfSf0FAIa01eMEYJzIuwZWbG8TaVPsY0g2Da2VZkUERIRP75NEKPoI+SGhzwUOcw+dqu9qUXN++De23QIj5RfFL2Xsw6SF0eYwCikPRMCbdAx5Oz3nISk4tpNcU9qyTPTf9bWaKEvznPN+KYPF7PzjcJAfBSn/Iou+Gcza0CH5ejDR9MJcos59w==
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by AS8PR04MB7670.eurprd04.prod.outlook.com (2603:10a6:20b:297::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 02:11:27 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%7]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 02:11:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Christoph Niedermaier
	<cniedermaier@dh-electronics.com>, Richard Leitner
	<richard.leitner@skidata.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net] net: fec: Fix possible NPD in
 fec_enet_phy_reset_after_clk_enable()
Thread-Topic: [PATCH net] net: fec: Fix possible NPD in
 fec_enet_phy_reset_after_clk_enable()
Thread-Index: AQHcHXw1Yquf3BQF1Eyfcd7Pi7INb7SD2ZvQ
Date: Fri, 5 Sep 2025 02:11:26 +0000
Message-ID:
 <AM9PR04MB8505E749166E4A2E5D7489F28803A@AM9PR04MB8505.eurprd04.prod.outlook.com>
References: <20250904091334.53965-1-wahrenst@gmx.net>
In-Reply-To: <20250904091334.53965-1-wahrenst@gmx.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8505:EE_|AS8PR04MB7670:EE_
x-ms-office365-filtering-correlation-id: 6339f698-67aa-4281-f35b-08ddec218563
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?11DzgHXOygPJK85W0fE2qo3hjwHG2SGdB5bO8pdeHa2K338I+iJp/CdLFTlM?=
 =?us-ascii?Q?8WRpNQM2lG+9nI6l12GVsWvm25AJGruJNCtAW6/rJCYvpPivvRjlVt8efzWn?=
 =?us-ascii?Q?iJn8+KF/6mCKlux6iCAFhHN/M/9gm8wRe7DGU76sgORbvAxKjc/u6dO81uTK?=
 =?us-ascii?Q?yD6B7qDo0UC2P4f+Pn7cmtl95Lsq5UYIsCfD7GYJBvk3bYiLg+bJcl5U5tEr?=
 =?us-ascii?Q?6sijJjT1wLL9R05QXqoBlvMLPnOmLu9rpIloQD+f0B13ZXJJgXKge7VHGFEV?=
 =?us-ascii?Q?inpvg6hu7y6R4s+P02qmP4piqsRZcjNrCpbtmK3Xg5Xl/wY0DnLeTLHBhmUE?=
 =?us-ascii?Q?rvk7IXLSOiBrJDxMNzZYFtmJ0TosTX3Zxc9mJKoC6WsB27ycN+9CxmdaUdVp?=
 =?us-ascii?Q?TsYmBoE+guCHN/aca9cuTnD6pOtmYHiqIUjpJei8mA5KIKvZnXSm2WLFDFDq?=
 =?us-ascii?Q?kFkgCluIAtuvp9/Gu6v5qf16ohUL0V2BTm3arl6LcRfobDmEUISKEK8u3Vft?=
 =?us-ascii?Q?4+soOVcNCusVnxUfpa45Qyxs7/zZFj6vticoMig2QU97DkHlC55oTPG5wdo0?=
 =?us-ascii?Q?ELOkO7QWBLUNaduBDi8vVGJlG+NW6Kq1Hd+6EFfW5I1etkUKCEzRfdL0CYOP?=
 =?us-ascii?Q?U02jTqZ2oImO6yAov4IUjkB/CV1dWiUBpafCKy38gDDrKLcPfYQg/3aadlEH?=
 =?us-ascii?Q?9gKF9mQ3s0W80MblRv6QkxZHFRl1cXgl78pI6UTl++yWRcs7LykeIkfnTxcx?=
 =?us-ascii?Q?Y5vSow5FoACm4fwSwVw3nu5j9kPXD1HuXmj8tk3gRtNS1BOE+kwqiYNRz/W8?=
 =?us-ascii?Q?Lyd7goNTDAUzhtiDq5X8Or5cbY5L4d8zRqq0SZ4/dYi87/bOp7T4KPMDm704?=
 =?us-ascii?Q?glq1AJbmWKEkEHYjP1W01xuskrba6UH8DfmBoU3AacPLQMeYN90kjx7nc0ZB?=
 =?us-ascii?Q?tMnNWy3WXcx1eke8n0F1mTpwI7k769VbeQ34y3YwNnWtxjeixNmImlfQKG8k?=
 =?us-ascii?Q?7QN8vY6RNIc5VF2TZCcwdyhUCO6QAGFdOwqQT76ebbZ8VHHsoXYkhh8aTlLg?=
 =?us-ascii?Q?7kH+u2J6FV1hB/tj3wO0w7p/xlStk9V04cY1Vcg6CwGywZAOxn8XjM0bD1JA?=
 =?us-ascii?Q?+Nn7hrNN61z2Zbbx6pSUmVuBv7ffozg9GHQgCeikbENmGe78uUaYR1cY8do9?=
 =?us-ascii?Q?QI5Nj6AjK27sp+OZz9l9sKS5OhzPb8Mj8mt3831egu7cXrhG8HSqXwRHbQhS?=
 =?us-ascii?Q?LVJPzOVglBxDtBZf1KAg14qYZIDULVzKAJlpi0yW1zkb/5dvWzHftbUsy8jf?=
 =?us-ascii?Q?sO/gqutJIoOykJqbvxrVwCwm33OlqTaPG3pLzep/psqy6M2vIUzruvV4on0a?=
 =?us-ascii?Q?OWXB3r5Naw5/0F6a5pD3JjWN0STpqDoWOgU6fagbOZRihYRVEuWJ90XXxLnE?=
 =?us-ascii?Q?mDXSN6MC6RrziMHg7HtL4WI0U9mmNbI2m5UARSHfpXi4qJCFzu+0cg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nStc+WBPjFIltii81E7s38rK+jGWMuZZIQVaxRtnzwYp+SCDG/FDwMctrDzc?=
 =?us-ascii?Q?5xg4XTofsgO0skJKzetLg9KCwvoYYhHVwwX8EOj5HlGteAo9YT98hXVl/4au?=
 =?us-ascii?Q?dpWWpYmY7aUCpHbpR/gxysxjFaAT6FDiFd2pWUtXZ3Dy2pDLDgnakjctQmAP?=
 =?us-ascii?Q?vr1SOYFusfqOEaelLdhLDxg3IsmZGYNFog5u8Yrlg+co34CmIH5YH1Jr8Cjr?=
 =?us-ascii?Q?yVFn0TtTb24zCabgiMT5vH7z3/4+busWOfaFz6/6ytOHTfMl4qMw+RWhNme7?=
 =?us-ascii?Q?JD67lMoY41JzZMhbGO6U2XvvPLbXofO5cLPKLLUK02HAx/CTHDtDyAvDMpiW?=
 =?us-ascii?Q?+eBb0sc1NmIcHik8TkesXTSkFueTt99Pp4WtAe1nQqIsovSIGFuxtceLfTcZ?=
 =?us-ascii?Q?/MtNjkv8Q50H2RHk3Y+a1ypZgsBNKjVxgdY/DkvCkGPij2S+xaVfiXhsUkAV?=
 =?us-ascii?Q?wK4I0SDhIiGpcZuy5ghE2vlhbpU42/ip3Do+L7Z9d2tTsAk1z7lbewNwmO2p?=
 =?us-ascii?Q?32rYsJ+gDeQItuRrg0RxN6dRS9PbhTMMSVOJuVV1dPYVgWn77VqW7tabZAeT?=
 =?us-ascii?Q?U8feRMBI6deUEcOvbQGPnwaEHCo/xogfXx+M5PkcheVgREW/TqleXMBCPLpw?=
 =?us-ascii?Q?wrgEN9wtLGdSyMUNnCOYgw4E78kYOudMok5WZZZv12nbhfi6DN4J6oyqtOcN?=
 =?us-ascii?Q?KdrKfQYJhVSMe0s+dyNrnkKZw7Sl71dB6np5/V+JakmOqM9zXocM7eOCIcGV?=
 =?us-ascii?Q?zjmsf5U3bZuTTl9YZaGPHlTgx4HoeAFYzeAVJmkcmejatGLcGRIzxaFRhlTB?=
 =?us-ascii?Q?YSAOwFibOhkKdmrc1gDGcQbqU4m308xYUVs2W/q1IJdZon1QMf1Bw9UQHCyR?=
 =?us-ascii?Q?KI0kg1FaxkuXNwyp008lMFcx7t11OYH+4zJM7w2ImlnfwBXxZI683z4Q3N/m?=
 =?us-ascii?Q?E7W/qlXaHn1lSSpvfdhpGSrR36FoFu8wYkaEEY+UCrk1cWV3Dp2lkC8A7Gmx?=
 =?us-ascii?Q?6ofZ4X57yGnab9sQW9VAU7iZD2+O1bciL5AurykZacAiwC6Vd6b6ZtcjTUlu?=
 =?us-ascii?Q?sj8ULjguVqp0q6awnhGQ890Dk/otyu6hgSNH1WXtwDE8fSObimKNltJZKSZe?=
 =?us-ascii?Q?xWDnwpTt+FE3bzeeoTyEdG8XZm2DOL6oKLTOeWT6cfL5ZOKZ20cmDvtcgnW9?=
 =?us-ascii?Q?JLfSITLKnnVOpE89Ap15/yn36FUNaKSPJexeJtESUrIFkZON3WtkQn8acLKX?=
 =?us-ascii?Q?ZJYGG8RvducPA/OczfD5U9l/OMN+spyX+/zAK3Co5ilWm+QxH9jjaq1OvpGh?=
 =?us-ascii?Q?qxMbhid8jzoHOZ93/ZBlkSGEPvB3AdLp07zqmqk9rmlV/47uXANBClUwBxdJ?=
 =?us-ascii?Q?jSdDqxRoDWnkTSl16SH90uVCI1/2Tp36L+Rs4HjAKfBekOHA6j7w9IM5RqeG?=
 =?us-ascii?Q?naDtz5y5CRN7iRV1XQXg9Q5rbwVI2bUp4fVAjw3T039+FcBuqN4ugO09njMh?=
 =?us-ascii?Q?6MPbZF8w6NZ3DF/t73LVSstuVWHQ+H3ALPAlWJMjEHs8vS5e0FhLbOLigiGG?=
 =?us-ascii?Q?Fk8FnkkgxFqlYfG8rhE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6339f698-67aa-4281-f35b-08ddec218563
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 02:11:27.0457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FscjfXeBDqp0JJr7dP7JsN//M/lS9/IXikVUIQx5+EPeo61Cif4DLQBhXXr0/eVIyEaJpHkYJNgZu2w3Iy697w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7670

> The function of_phy_find_device may return NULL, so we need to take care
> before dereferencing phy_dev.
>=20
> Fixes: 64a632da538a ("net: fec: Fix phy_device lookup for
> phy_reset_after_clk_enable()")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Richard Leitner <richard.leitner@skidata.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 1383918f8a3f..adf1f2bbcbb1 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -2363,7 +2363,8 @@ static void
> fec_enet_phy_reset_after_clk_enable(struct net_device *ndev)
>  		 */
>  		phy_dev =3D of_phy_find_device(fep->phy_node);
>  		phy_reset_after_clk_enable(phy_dev);
> -		put_device(&phy_dev->mdio.dev);
> +		if (phy_dev)
> +			put_device(&phy_dev->mdio.dev);
>  	}
>  }
>=20
> --
> 2.34.1

Thanks for fixing it.

Reviewed-by: Wei Fang <wei.fang@nxp.com>


