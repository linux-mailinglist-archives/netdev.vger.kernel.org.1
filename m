Return-Path: <netdev+bounces-228525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A36BCD473
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 15:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F48189BD35
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06422F3C02;
	Fri, 10 Oct 2025 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iVXA9CDz"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715FD283145;
	Fri, 10 Oct 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103168; cv=fail; b=sJVZLKGNWDMSModdCVeNCKSqamZ9vt3tP41wqoztd65EfH/KG0QcXRNCRe6iXMthdJ4j6rhoC7KhHYDfQb6Z02GQmi925hLG91oGqC2SC2SV6rmDo6P+Tcwl3I8dINraTnoVgY8IVyF6LISBAGMdme+ctAvtjRZkV2S1+Gk5CVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103168; c=relaxed/simple;
	bh=x29kcSIYgL6XCze8ch/A3PmolzCrn+++RQRWmmrYJlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iWHjsztXLd45bUFqVD6qUovlAsweW/uh5eMJSvmsrU8l2D5jO/XAK8Uyv31Bk+BQm5mm83f9RkhS+REmYGnlfXzOZyx9HOn2G/+77WIMgjf7b1QOC7i3rEnILcACogmZFye9t0STCmn4Nhb6LpNfVpZrsmQDlBBWUo1nteKPVh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iVXA9CDz; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMjbOoFN/24f6OlnZPJr0O1xtOOAocxAowjdGnkxv7eRUUPtSw1VqBsHTbQeFZ0HZCpUM/Gk2OPKXsSC3eutUHcKetanMQxuzFK8THy9Xr4Vp7WnDbpqp5+ODyqSeszzrc6Z/307HVpSIVArvYFI7aEG5TJWpvH/cqQhkTBE2MdMOZ2U77l/paPYUGSCIqg9JrDOtacBsRKkfLCnTGSx6djo0fTg/moKjQ9Qhj1jrqRsQsWPGmAwJ4OX99RVrx09GmHn4qGpLnY/o2DTjFecWCjawuVb3p5hXZqMLPmP2cQ5R2LJiM5P7Etypp4Ig24DBexFSNE3091EtS/B9/a71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgVsIDf8HkUOR0cU0uBBDorO8NOE1RPmu9AeklVF68s=;
 b=sRPKjadnXpjezUSLZ5KvEmu6nyYGOtNr95q2Nt0PwAdoxRxbdwm3DQIWj+chRIvWygPa3c3U85pmevWbn3c0dOwGwjg2r7z4/HMlAgk1QJLscy/OObtcItmNulsvVEbUDxEzzS6YvGoFaLWmTWpGsh9qBCK1o03P8m5BG7KrpZi6dg5A/ed7oIp7Yz/4CY0/ZjWYQzsKWJ0csCxeoFRgBc4NY3070wMwwBy2wc3B1j531iKpsZIAKa0b5CgpYqkMMN7103JSJTOsL3UHHbF5Jjyf1Knb1X1UtIC3eOebZ5qrUesw01P6cgi5Eqr7RqJIXschKp5TiT0nRbV1hxBehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgVsIDf8HkUOR0cU0uBBDorO8NOE1RPmu9AeklVF68s=;
 b=iVXA9CDzn+SNkR3D0mmyinITRysjuPbIPoq7XZE4nIVa9uw769MRLe38K4GnLVg2p7001TYoqU/S4Wh+7+HcG8foKO4f0TLTDX7oEUutdajfsrE4tGeBAjvwZ9CP0YedCyBIkmIa8+2eX5Q1p9sVa40L6DLgz/NH9F882hG6/L/FBrphz1QzbfJRI3DhMUcEQtjQ5yWIsrU4w+shsCI4e3pbDEGIFzWVyvQU7pXkHs9IwV1pQPoH9ibagY37iqXY6VoR9rMxlEH/fB5nNUdOdQA8Yt9VQvNVMiuBa0EGLHM5SiyR/kzIZiruOgyrK/bUwcjKHFy2Ue4Pdi5yaVYuAw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10690.eurprd04.prod.outlook.com (2603:10a6:800:279::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 13:32:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 13:32:42 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Frank Li <frank.li@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Thread-Topic: [PATCH net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Thread-Index: AQHcOcsiKt52zsPKAk2fo+9Vq3ZFNLS7VS4AgAADikA=
Date: Fri, 10 Oct 2025 13:32:41 +0000
Message-ID:
 <PAXPR04MB8510CCAFB1849BD712A320C488EFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251010092608.2520561-1-wei.fang@nxp.com>
 <20251010124958.5fk33tb6o2m2qct7@skbuf>
In-Reply-To: <20251010124958.5fk33tb6o2m2qct7@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10690:EE_
x-ms-office365-filtering-correlation-id: 2b7565b5-1c9e-411c-6481-08de08017d19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ElXQHeJOVXGaJEyaCUvgtitI3eTORdJlxu91mdtLL/Z47FBTVbsSvITFxHJt?=
 =?us-ascii?Q?/jsRhZlwlPfNNkXiH6RHiziuv0cREEInjbKBejeFPyZVF4lp3QD6DIIjmykH?=
 =?us-ascii?Q?ua/78MPaCD1nUuQ/11kRW2IFf4xiUBwWW8QhNoNEVNbA4mkCJu8cOsR+JfF1?=
 =?us-ascii?Q?l+595FwF0mzWpcP+T+/zgUGJZDbF/ZWCLTuf4lqiEm2lkiFC5Q01dRsFc0vu?=
 =?us-ascii?Q?csUTi+GqR5iDO0DD3WDyCtpfjnpyQmgnr622XKSfD1TNzdwyzQKLyanB3CJU?=
 =?us-ascii?Q?Uc8W1WLK/OGI175AVbdA9pkJ0TLCgocFznnRH291Ygf658bpgIz1Ddk4gJTF?=
 =?us-ascii?Q?nRkWwegpnB97Px5nR2DXXtqq9CU+9Oea3UobQkcgpwe3b2enXfO9NQ7ZUIhi?=
 =?us-ascii?Q?WRHZqVFUyvRJ+3nVjD9Z0HfZiCommgSQABmF2uqPf2ef8IrbTnwuFjEAW/Lr?=
 =?us-ascii?Q?VMhdSSVqgRCFXyem4g7cCWmskFHI8PuavLlVuwh41+fvEIYpi+CVCNRi67fc?=
 =?us-ascii?Q?s6lYSwYTTtTm2TpszWnRtQaaJqlEna//vvnkcaqEQy0LMHR+kCKD/vwWxZuJ?=
 =?us-ascii?Q?h2wY/ZfWMkx74pJehi/pp4IP/3hQYahfW6+QmR/mOWyXZSXgY0YD/qWyp/UF?=
 =?us-ascii?Q?klIzjjmd49EPjFj3BHsQkeFgSExV/9xykmH8SunYSY3/hCiJpyHXWB3vL95b?=
 =?us-ascii?Q?/Rt7PSzTqCNxXu5sF0QlFalv41i8tqhfAx7TW09QhH6B9BANswZrgsUzHnHz?=
 =?us-ascii?Q?vdlfl0FEk73wpnUlw0cOVrGi9RhYe4Ay3kH28ja+lld0L1sAAlFV1N45A6w5?=
 =?us-ascii?Q?Ut/xFaZM0ZNlCKLiv40yfajVbRnPPvXTpDiR0/yWJF4NM2PBDNiCmBKeOh+O?=
 =?us-ascii?Q?wIea931QFy4NrNxI1M3AEwqvAlwvGxhAYiRRKgNkhQ/xKhn1aNjWcfnLVvoe?=
 =?us-ascii?Q?aeSt6FioLCDYcXzVzO4HfVZTUJDiZpRKqO/UNh8Y4prbhfpBjrpi/8b4Rkgq?=
 =?us-ascii?Q?oNCJSeiLTOZr2VjgiQpPdnujYolDemlfMd67v3lOkOXk1otsDOsTIzC1QD5W?=
 =?us-ascii?Q?wUQRauTexMH81vJg8ydj+hBqvIf0qj0gv8sCRC3GPIT0m1FoCFHXq6/fbQcY?=
 =?us-ascii?Q?w/JBlKev8/PS7XVp1eqBBhnPX6G0qc6+BS8G6kEthM8AUPJH2Y4tFX34I0lj?=
 =?us-ascii?Q?tnLZk1I/DkYy03WgOyKDj7Z3hXBJOiIeFYZ7AnGtsfct4YCyuw+f8KD2j7n0?=
 =?us-ascii?Q?MZnv8TEREhmlY+hD8sE+3NYCKozfnHas+4CY842YfCrzEP5ZrK/aXgZCnavQ?=
 =?us-ascii?Q?NtFYyuUF5xuU/BnIBF1M5O777i/7K0MYPUeCRzs3fdKpccA4WvnUKl5kr6Lb?=
 =?us-ascii?Q?FFLbU9RsxL/C3AP9hD3wg4/S6LQsSUAtiCtxY6PgFwfq2aB1ptGQgLxxdT0A?=
 =?us-ascii?Q?8+vHkcgF5SdF6KRwAp5Xl6pBoDY5u5AvI3mlgKym6g6cNUnCjcnViRW/j6G7?=
 =?us-ascii?Q?SKalLYHJoNIkzoXgY5ixwmMXm/YcWWcxJd/U?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CFPTxVBpOosRcle2qnqY9j9zuvujV7IegIX9IocxbR8r5DLiOATVSMT3chh6?=
 =?us-ascii?Q?Rsytm2SmzgFr5Pi5Lkmws5ErEK5tl3jFVtn4tN4ZR5hZ5BEwXCmpQyKL6Iwm?=
 =?us-ascii?Q?vB/Z9NLODyYUbwm5gp6ss95wvQ8HrcGCfBlEAsJ5cIL5CC53Ytd2gfZnm/QB?=
 =?us-ascii?Q?F+wwBpZnbv/01iAM+VHzWkqyzL1qPJtplUcMKayGKh+uBzMwrbJ8C7dnUiY1?=
 =?us-ascii?Q?BzHrVcKASTuf5zzX69VfV98zt0090NsFL/9cP3+e0eUfEJ9bkzutzGiJ9FWg?=
 =?us-ascii?Q?5nbTMoA6kY/dudWLCxkEGZ9IkXTdXkuvO3xCWgIZPyCt3QzX8Wrcl/5OluBJ?=
 =?us-ascii?Q?RdZl1ik66iFUV1IsRsZxieSU24H8kYGWRVsfEjjEAVG3RO4B1AQ1xiPXlIU+?=
 =?us-ascii?Q?Rg9RJQRfHghsW7iGsSyONpmvKCZCn439aFJMy+llObgQkjhccRhMN2YAjqQ0?=
 =?us-ascii?Q?pyckqOf6f+nMp1qQJeLobYy8E5jNge8o9mxjEz2+VwT7fpIJ5H0Ekxe6OHR+?=
 =?us-ascii?Q?/WF3NLGJDPqr+1TDjIcxgm7YwLOHkccUJhpDL9AQK180fL2vYsQL23I+fZeC?=
 =?us-ascii?Q?TBoci862Esq7RweM9HuE2w9NzYMkvfNFG++N+AHdGK0FDW5JfFfqIZVWEQ0n?=
 =?us-ascii?Q?3Ejks+MeIY+yCxP/uFT+EDRHutgplKOH++3Cc/Uq451iQav6cZ/V38ot+Rei?=
 =?us-ascii?Q?mfMtn/8/Q9fCvYaXiwjhKyzTPOEDzV/upYX55NElGlShKVgPAmoNg0mU/frO?=
 =?us-ascii?Q?+lPKOURU8qbnzt9kVv2Q/yXj9y20v3SDd43UXtDIBCL9rifWi0hyg/z2ynFP?=
 =?us-ascii?Q?I65LE3cffxWQIeJAWLCH0dindMhcw0A0W7L82pZk34V3UAFk2OyP284VdtFS?=
 =?us-ascii?Q?oRmPBC9aShf5pLQ1AR/SfMMRsNoiGrelDviPV1l4DtLYnAKIzOrMLvWS02vV?=
 =?us-ascii?Q?HAYu+FJVSyipW/iixFnq7BdfrkTlBfkGJhcviGDBDUD6/iWw1W6lq5ftMeg2?=
 =?us-ascii?Q?ZUKpeq5FIhJX6OYEI8Ee3B87dKakQ5Ve6QLJwk0lUDRYJOo4Xe9LYv/YF5AJ?=
 =?us-ascii?Q?KnWwldqLZch8K7GAqdt/wly2NYklWFWgrQToL8aUMKic+RLFGNFamAxwUCw9?=
 =?us-ascii?Q?feMnBO7W9qEugQEZpCfK8aKsJ86fsH9FwJld4xZLcDNOm5dYM3u2C0/TFdti?=
 =?us-ascii?Q?3tjlDmZuHpi45VmTYHBrnlSUn+Q/UCWixBhgLCPL50kQb4/qAlg+Ixessmbt?=
 =?us-ascii?Q?AML7vAZxs6J72jdv62yt7jbwHQE47gSS/jxrKWmv7j3k3TKOoTKDKokBU4PI?=
 =?us-ascii?Q?v7rdPHohIZrXJXcz6nV4Zh1rUp5kSfiYEbnnav6KeiGbzv2SNBtXPFnXIQEN?=
 =?us-ascii?Q?XlZXym9XcKxOsWJPpK8kv6SCSQHM09O0mXkUnrj3UhuKs0mmqKB2gSVP8pzw?=
 =?us-ascii?Q?qMJ54F1SBQTfzK5eBpi/inlEOHxN8hQ5TP1HShTjOSIrnlpPDqTrZXw/xrL4?=
 =?us-ascii?Q?3yu5EPkmr/4H9tB72ltMaXtlCYmtOpmfxuLUmC0nJ8YWzRpeMPSgm+yyVH8w?=
 =?us-ascii?Q?MBgfSeH7JTF7incfZDE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7565b5-1c9e-411c-6481-08de08017d19
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 13:32:41.9890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3R8GWZjDIiTNpyLHY13w4XzSFX5/DD77E9wz+hpHBq1skf+mIAtaMVHyGtGl8zNo95L+UymCshPKps3AbwScgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10690

> On Fri, Oct 10, 2025 at 05:26:08PM +0800, Wei Fang wrote:
> > ENETC_RXB_TRUESIZE indicates the size of half a page, but the page
> > size is adjustable, for ARM64 platform, the PAGE_SIZE can be 4K, 16K
> > and 64K, so a fixed value '2048' is not correct when the PAGE_SIZE is 1=
6K or
> 64K.
> >
> > Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet
> > drivers")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> > b/drivers/net/ethernet/freescale/enetc/enetc.h
> > index 0ec010a7d640..f279fa597991 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > @@ -76,7 +76,7 @@ struct enetc_lso_t {
> >  #define ENETC_LSO_MAX_DATA_LEN		SZ_256K
> >
> >  #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
> > -#define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
> > +#define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
> >  #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed
> */
> >  #define ENETC_RXB_DMA_SIZE	\
> >  	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
> > --
> > 2.34.1
> >
>=20
> Is this a problem that needs to be fixed on stable kernels? What
> behaviour is observed by the end user?

The issue should be invisible to users in most cases, but if users want
to increase PAGE_SIZE to use one buffer to receive one packet, it will
not work as expected. So, it is better to be fixed in stable kernels.

From the perspective of driver implementation, a page is divided into
two half pages for use, that is, one BD uses the first half, and another
BD uses the second half. But when the PAGE_SIZE is 16K or 64K, both
BDs use the first half. This is inconsistent with description in the releva=
nt
kernel doc and commit message.


