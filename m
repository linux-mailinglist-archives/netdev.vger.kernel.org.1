Return-Path: <netdev+bounces-175591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE18A668BC
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 05:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0377A8418
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 04:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34291AAA10;
	Tue, 18 Mar 2025 04:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rknx6ArM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070.outbound.protection.outlook.com [40.107.241.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0B538FA6;
	Tue, 18 Mar 2025 04:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742273688; cv=fail; b=GKmjKQooLRlJn4yYS3Nki5R5MlVvFEY9sb2MbjrPDDLLtiyJgSnYZoQ8RxzsWqXXwyXegB2t+44NuV5w/yft+UwCGZ7Y07WhQq1DggPycdGf/QHB64HxAQhChAqY+1H0Er/EGvSu0HTZxOws/lCmPvIRwBntf5p82dsPBfIOReY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742273688; c=relaxed/simple;
	bh=QRnID8O5FTi3+OOLrDx2ECSe14S2VNy7NZ0ueqfLYd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tj7iXWV6TgKOXvCTbyVCzgSfu6750Yusv6eET7+U/YVzftqLqWeabTkocBvpszuXgVdg+x2+xvVP55q9AmSd+9/cNcB7byUenoDXkQ8ICa7Lroii4wZH/mqVgCOiwgUlIrY+jK82fbHu9mhKWzRF/8KkB025jQnFRoL2M5fN4nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rknx6ArM; arc=fail smtp.client-ip=40.107.241.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2y19z6H47WGpaJ6128HqpxVnCrBm9qiTOeYhlrcJ9GRGLCeJpmaPvh2wQTYwf+Y7ExaQ6kowWhyIGt2RoI0blgZ9B+L3f8VEdf5diYGmuN3ygiIYXDAxqr03Jo4egP/kbGF68KWMqDAEc8ML9sLeuhaHWJERjJFSxy2V4VgxrQaTO/IcZsFZpLLQi4m3HPND459E73GiYCNqM2bqUZk+fc/J7JpRMdoRWRlyDnoq5UrEOv01BWLeLIndVsmVY+fDysZ8BDp1/mlzbT6xZqk50nsyYFj2hdJ8PaFlpXiFkd67nyVITVsURKNC0hGEBcr1hI1Bon0wLhYPSuwn90GlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lv6xv+1GELkaZwJSBhkwsdjQNFBEPGqLChne6i+zBjo=;
 b=MrxE6jyxwleIs8e2QSTBQgV8IbRLOuZoUfHubXlLUZAh95Ziac2BxWrBXt/ekxCbCEvsdChaDwMUw9RejhSWQAUTY0CGdcFOTRnnCw1b5pj9MlTPMwL2sHOeJq9U7NP3KldKpUyLgpmapkYirILhoVR74uGZuclDQm2q20e2g9WRAvQnKvGFc0ug6jOx3g632dgRO/5xrgHsFzh2DzZlScgy06+ac95fKccBQ9bHcu1nTWldXLSEPqQgpEng6/C8/Maw8nDeInCUTAS/uUJCMq+EM3bs3o3+14oI8whaR9CKqWoNiOAqm666F9DRsruMkXa9z/axGlgX9CurC4hSlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv6xv+1GELkaZwJSBhkwsdjQNFBEPGqLChne6i+zBjo=;
 b=Rknx6ArMwDc6wG7d1+tjY+p5n4MDlbRptOd0Gtqhf1vJA1S9n+C/Or4FPiCv1n6AZoKVNzQqng1PdYJ09lln17VSTzyA1RBy5ElBwgycSnnpr7md948Wb6z+BcNGeJvGY3dZcDphWMnUKJTpNKKrqsVlzk8Ck6WeYJvmxdxCQQbCrIM1Bev7qBe0bZt6VQCX7unWwn9UGxVsCE0fJcWPTi/HvSp+G8NUhiKGxVarB+p1WQBrj/sSdzC/h5HraHQSH9CPyehdqYhxWlQF+j2xVv/xLZK9j8GhPtkcU8V0CqswL6uSixquqIUdf20KcTIMDRWFLSPfNc5NBlqmpKQOjQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.30; Tue, 18 Mar
 2025 04:54:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 04:54:42 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 net-next 07/14] net: enetc: make enetc_set_rss_key()
 reusable
Thread-Topic: [PATCH v4 net-next 07/14] net: enetc: make enetc_set_rss_key()
 reusable
Thread-Index: AQHbkkpZ4ba4h6RiQEKqqP2e95OWGLN3jg5CgADPXsA=
Date: Tue, 18 Mar 2025 04:54:42 +0000
Message-ID:
 <PAXPR04MB85100C7CDC7F0A915BF35AC188DE2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-8-wei.fang@nxp.com>
 <20250311053830.1516523-8-wei.fang@nxp.com>
 <20250317162617.glikwbcey3s3isfn@skbuf>
In-Reply-To: <20250317162617.glikwbcey3s3isfn@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7966:EE_
x-ms-office365-filtering-correlation-id: bd4aa68e-cd4d-4745-48ad-08dd65d8ff69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QeloQmGPEWfbKCeSrRQu5M7q0BGENXuqYaCjYdZD/Unq5t6ELtw12Aq/Tuau?=
 =?us-ascii?Q?RTzhj0lmArAs1nfngi24LFET2lB8EmFwnlX37J6c50W3tBTxgTDLU4YkNiBo?=
 =?us-ascii?Q?PRa65OxGfgwMJjGaY3+qIXuzNhDZTWpzJDD5CdaLOsJ8o+9QWwi9crcQKXvX?=
 =?us-ascii?Q?2q7i2a11DOmFNczjVjMtNVCxxr8H5/qNixQMkhuoHFyw6eV6bPRkQoTzZoOO?=
 =?us-ascii?Q?E37XZRgR7+vTQGqKHnsQxOpMi82vdxEry8bkk72KdNMW0q9nCLbOrB3cBukG?=
 =?us-ascii?Q?eeJlQUXqx8KwnMC98QUyGPjVy2NIQWvzUHYk3BPMnIXOztFluNM7eU73lH8V?=
 =?us-ascii?Q?oC3i9An7nD2dwR+SH+cqLvFfk9ZVUenUsZBXqKuq+bt+53jvaOxYWrAdEFrh?=
 =?us-ascii?Q?5lz+E+zU+uWj3dBLXnSxYWncjUbi6MKIipr6rYfn3VZlqYoAC/rib0m/FyPd?=
 =?us-ascii?Q?uT8LXOwkUNYETEOoylK3NSnx4YrZ+xqjsvdt2ULb6wt8iTHSjBMRVmLGOQ7H?=
 =?us-ascii?Q?XMUR7nXHULoJ/KIgUdQvGoImBW+6UxYO6l2zxV01GblH7ylI4MCXw0D1F8dx?=
 =?us-ascii?Q?/1wo4WMqIPVQ+aWc+UD5e07sSKxT5Sakm7STFyp2sS6pkq5hz2ctxstBfXAZ?=
 =?us-ascii?Q?wTXhxBQwjkROL+omlxfh31km/M6Xyb2Uk3qKuQqgYVqUvNGiXfguv3ccAMP/?=
 =?us-ascii?Q?t+owvxo3GWRngSgK2wLpohzfeSPIYmmAHjrRzRF7uSWHCnunWl+q3YaiUzml?=
 =?us-ascii?Q?iVUuabXHMjo4lxTSMRjlObqLLRT3vwtTPfhYvTrQQc6cYU7UL2qFcX7Vj8Eu?=
 =?us-ascii?Q?TTjBVuWvwWP5pxiK/fOPJiH/ZnZHKsQplVehlcYvovb9qNeLmNhyNtlv+N0R?=
 =?us-ascii?Q?c7cJ0z0YINNxOKvDV18k1eB16mkzjCphV9Em/mIrufRaPX+H6MdBBUVBi0pN?=
 =?us-ascii?Q?mPgpZv34TX7e3ST/Unf+cIa6v+o7GToyS+0n+dqB1KNiRs1bGan1MQX4YFPh?=
 =?us-ascii?Q?Ov6E/IsjAjOyIQnYLL2IvDHCpMerQpgLUVuRpcXY3FWkDe30BJj0Sk5JXUJR?=
 =?us-ascii?Q?vw/4+vtNh29nFDcYvhwX81ktDbFaB+X/08VtKjN4S2X9S0EbmODYz4E4dldP?=
 =?us-ascii?Q?quNZjZ8xC9DSB47YMrLzdXhrPsd0Y6OG2sbAovBnwxF382F4c+nXB1spqsvZ?=
 =?us-ascii?Q?Ie9XDs1iXYAftPRO+FsEVpCLMwiIN5LHAZWmRx74OMVmK1/HNKIJOM9Y4Rby?=
 =?us-ascii?Q?3EBDRdQ/bE43+iIHO/SybJRL+/Lg96g0cAQWYTrkJI8BfbzHPux5UY0AV7RK?=
 =?us-ascii?Q?vSeZD2kDzcu04D2LgxZzlKveoyOePq6NEiz7D1J0mbLC4SbnRuYnPrpgDs85?=
 =?us-ascii?Q?FNj2dGBCpM+jHO1WrZs4gZdtZLCeScdv7WKHJ6kVcjwruH1UKbIUJhQKq/Zv?=
 =?us-ascii?Q?/ESzOH+har0EevinMO9hZ3VVZ6ig+TmC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ocqKbs6wdO+xnQ+yjAuX2AG8juj+zMt5rGTIkl8UhuhK+bhc88Ack8g6pBTa?=
 =?us-ascii?Q?U18kL3EnE03/L2hpJYcjEObqtKp2W/yUFTWuJhVp8Bbgw8W+XoqeYtheevLp?=
 =?us-ascii?Q?NSJ4aYe4VCjPNj3yKaczRlBqgk0YEQnCMparF9kQLcGb22ZiCMfK1YGiLiOX?=
 =?us-ascii?Q?z3AXtmDOv3vz5IYGe7fyzJ5YaBtmPwQBQyRL1QrDl0i62Druxl/vzqSH3CiC?=
 =?us-ascii?Q?G6A6aiJsdXm5i/JfInOQzIwub/HSVTJX/MrAayyp28kCr5Lxssg/vn+OLSgZ?=
 =?us-ascii?Q?39Ejs2wTjnZjMq3oHDY+fFHNb+l0JZnDl5M70zQi9h1gw5qvpSbYAQ5ifMo8?=
 =?us-ascii?Q?PEZYL2/6vjpJodeuOFfOChhvbzETHHNdeYKzp4DMfYzD6qEtg49aL9np+W3B?=
 =?us-ascii?Q?3IaOg8lppBXe31yw83ijkdwtMqULsYIbS/ZitEskq79mz05VN7SUyH0oPBzW?=
 =?us-ascii?Q?ekWio7VAL1AXROTGhjVwS/ZXB5S1WPvbBh/UJeJCLMooi59bjZtJJhm5ZvGs?=
 =?us-ascii?Q?K614ocMoRRN2GkRZPKgOrwHEAAVN841qZv4GUC6T+Zi9ur+pTkOEPKHc5P7y?=
 =?us-ascii?Q?0/rjWAQd70cnJKloO49bq2SnirEU5SIw9xD4Bj1XoSPHywgqG4vNLgbKZe1M?=
 =?us-ascii?Q?tS1Y23NTahI3yoqelF5F82Oyj++XLne8o0K+SS4sqzxZqXr2pdcSA0EZhiW8?=
 =?us-ascii?Q?GtBpl4EayciYVBFP1VH1ifmnrpx88eBB0LjyfqjQtnhVv8WYFoFP1MGtBALJ?=
 =?us-ascii?Q?/d6RgmqCfqmcXnWo50IbbkKAJ4t9H1znIBXl7rjEvtonBfhSjwbn2xlthej9?=
 =?us-ascii?Q?qmZvarDo+wZ1pelSbEP/PIxx8Ak2DBOlw6Ov7uzevoKEgawe3pXkGXDiq+6Q?=
 =?us-ascii?Q?qYMXkzvAxt+tqTYVHyIXCZEsOHjD1LzjQjaNOTIL4NBRQ5pyIAjDPpcM8Fr1?=
 =?us-ascii?Q?sRMRz+8oUKv6bq4162K/qLQD3/VIoP15TbuIVhpprDJqPI0dT1jD7hRZ4b03?=
 =?us-ascii?Q?WSkIXFSegAQhsjW26lYMPbyXYvXMeFpRVsWLoTQTtHBFNDYMOVk4JYf2xnBM?=
 =?us-ascii?Q?Jo8Ca8aK88YRrc9/Ti+QWrnqH2ELnRJUNNS14dLPaG6YwM8G6mAoL83PTcd3?=
 =?us-ascii?Q?QsBtB/kBrXtmSl4extDq9pIm62Cqr1ac/VblADJmM75J3V6b18oklT5aIFWn?=
 =?us-ascii?Q?G5vKHHn+nd9GK9MYBj7jXxorpytN6Wqf99pBIq04AOelu9sEXGMlu19/wmjO?=
 =?us-ascii?Q?Dr10GXElxwGzp0TBDcGTZsCILQrrYO0+EX3coD+7qLg6OYFpXDFv7VdYLifc?=
 =?us-ascii?Q?ZermG4FG1u6VzkWjXj+3qENakj0X+GTpyTehVdFl472fmqK/vhqPbiEF5Vi4?=
 =?us-ascii?Q?58YT0FBRWOLb8pX7+YhU4mrn95p4bdV7YcuZuyblX7X3Xc7aggm3iWex8ONv?=
 =?us-ascii?Q?V7MUd40Pe3SIcZbNe6rMsHEAX81OiNOBkeoGhwo9zyz0SQ2+BmansIbblAlb?=
 =?us-ascii?Q?eQSpVK7KFZdmvO/cGkI6fX3a4zC2hkdeTgmJSRfFdMur01pGRP+lVO7KSnTv?=
 =?us-ascii?Q?kfOLvFY91Go6Gfo3IWI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4aa68e-cd4d-4745-48ad-08dd65d8ff69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 04:54:42.8834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytjoWAbLfPa2sVmNhWHxjCZgT41BdCU1CNyZPbtcQUeqXByIHwSrN4DLzGZ1CRRDzwTd821k8Gj0OG8h7Kdj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966

> On Tue, Mar 11, 2025 at 01:38:23PM +0800, Wei Fang wrote:
> > Since the offset of the RSS key registers of i.MX95 ENETC is different
> > from that of LS1028A, so add enetc_get_rss_key_base() to get the base
> > offset for the different chips, so that enetc_set_rss_key() can be
> > reused for this trivial.
>=20
> for this trivial... ? task?

Sorry, it should be trivial thing.
>=20
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +-
> > .../net/ethernet/freescale/enetc/enetc4_pf.c  | 11 +----------
> > .../ethernet/freescale/enetc/enetc_ethtool.c  | 19 ++++++++++++++-----
> >  .../net/ethernet/freescale/enetc/enetc_pf.c   |  2 +-
> >  4 files changed, 17 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > index a98ed059a83f..f991e1aae85c 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > @@ -583,22 +583,13 @@ static void enetc4_set_trx_frame_size(struct
> enetc_pf *pf)
> >  	enetc4_pf_reset_tc_msdu(&si->hw);
> >  }
> >
> > -static void enetc4_set_rss_key(struct enetc_hw *hw, const u8 *bytes)
> > -{
> > -	int i;
> > -
> > -	for (i =3D 0; i < ENETC_RSSHASH_KEY_SIZE / 4; i++)
> > -		enetc_port_wr(hw, ENETC4_PRSSKR(i), ((u32 *)bytes)[i]);
> > -}
> > -
> >  static void enetc4_set_default_rss_key(struct enetc_pf *pf)  {
> >  	u8 hash_key[ENETC_RSSHASH_KEY_SIZE] =3D {0};
> > -	struct enetc_hw *hw =3D &pf->si->hw;
> >
> >  	/* set up hash key */
> >  	get_random_bytes(hash_key, ENETC_RSSHASH_KEY_SIZE);
> > -	enetc4_set_rss_key(hw, hash_key);
> > +	enetc_set_rss_key(pf->si, hash_key);
> >  }
>=20
> The entire enetc4_set_default_rss_key() seems reusable as
> enetc_set_default_rss_key(). enetc_configure_port() has the same logic.
>=20

Yes, I can add enetc_set_default_rss_key() to enetc_pf_common.c

> >
> >  static void enetc4_enable_trx(struct enetc_pf *pf)

