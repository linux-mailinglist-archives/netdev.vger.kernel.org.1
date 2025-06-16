Return-Path: <netdev+bounces-197927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9A1ADA616
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 03:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B947A75F5
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 01:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31682882B6;
	Mon, 16 Jun 2025 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G4GXZbHK"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E1F28DF1B;
	Mon, 16 Jun 2025 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750038134; cv=fail; b=eifWaw4A2t1Kg2GC4bvd5RtooM8VLxDCCDYGEOK7Gzsf0o3OUBEOLn93b7wGd+LUeQPxktEB5FG5qm1EsqpDOfqItfCNWSunYiKxfHecjLTz4YWYjd1OcDTF2+DSAn65kBYAW7WTcp8f1Zp7zZVoFFeXl3WhJ+HdeCX7+NJmOGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750038134; c=relaxed/simple;
	bh=hFWUh/3gdvJUhWTOOfvOKplgwt1QF6rIClBQNXDTEQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gbGXvqHjGDI56gtaAL9i+nn/pjDap93ZcAyLbI2BAnBEKbtUwf/ocQjysgYyI9KmcYjSHLMCC9w6HVBEkq5M/Jn4CJsROrtr/lEyKg1P9YgnE0RH83Dy+Ekupod+7QhBJBby3zn7HxghmWNyDt3e0F37iF8zzA5IPl3Udg3wyKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G4GXZbHK; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbJkcctC7ikUAc43DRYs73DfchsD+eWcScV4xjOlKsFdihPpE7Oo0watKt0/2P2fkmaAedvNOE2kGh0iLLZYk+UN3Xy0tEvi18m5dH1yGYU3S4lY2BZ2SLJg/vNBFq0vSIoOPQyDAALOoFvzVh07aAoXNea47O6FHFkqjYOVXyEEfPaisFLLkceEyDP9MpyN91/tYwFPm9knxVIbQ+lezpBHoxvRuI/LcYTt/jwEheVemrhZpha8VJwz2QCrE+ucM1zofDIeG6hKDyJIcURVNAw+gGedAsUL2lEkfieUcJEVHdzkLF5Zlc1xs+iPxdjh3EPD9+bURAG3cFSCrQT4Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm36xLGOLvYHQQyVdVnyBfLpcdvm0KYHkIU0QNK5P+w=;
 b=kkveKcuM/olv6VIA+vyfdVBoJBugpoxsSdmKK/rIObLsHvThGsM9n3jCsJ3eKtJ4I0e+G+G6bwyZYsAVtStX+aSxJXWr+M6P+qP4/yqtKcLr/5BnHdtJERURVvNxBR4gdy0xZDt1VrpvxsSLfWdy9NhJOSe7ouNSCHerLtsnYQS5ZebvRzfyyfOOfn/Q9SQ/j+0F0V1aLhYrRBIb/KNyW3j7926+/JWc3OsUPEO8CM7UCjl9eo8LPCgHqjndXedwXC3tpDG+so1eTfKBi0TnlSgoHJ5Y7D5FAAvW3bkllWaihHJ69cGNkgKmCTCmU0PClvHyR/+NI1TSfjpN5yRzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm36xLGOLvYHQQyVdVnyBfLpcdvm0KYHkIU0QNK5P+w=;
 b=G4GXZbHKO39IhVf4aJphCUZQRfBTIAJuIRq5tP4bbSTsHHPNxYV+1HuoaqbO1xmE0huM0dBA1wnGRBK+KoqvE0v3YMM+wxXITkAf6X+RSGYEnhskv0+2f/B+Rq1azbmn5rg3seVd12pEYjPI8Z2q1JJNw3MhBWtIZIpkerJ1uSN/Eung2CMRfUpHuR4no4rR0qFKZ5KRgw1XC1OFEF4onZMFUCxJ6grarDfyulWRzH1TQgpBHJCYRoYvMn1ImhyvutOvcsarHX3f/3iVcIDN9DGV9ebsB7vSE0RHKkul/523cF4PfsbXUbhs9q35LRfp6y4YnWbnTozGFwEePDzoPg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Mon, 16 Jun
 2025 01:42:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 01:42:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, Marc Kleine-Budde <mkl@pengutronix.de>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH net-next v2 07/10] net: fec: fec_enet_rx_queue(): replace
 manual VLAN header calculation with skb_vlan_eth_hdr()
Thread-Topic: [PATCH net-next v2 07/10] net: fec: fec_enet_rx_queue(): replace
 manual VLAN header calculation with skb_vlan_eth_hdr()
Thread-Index: AQHb26Wpjf5c6C5QHkK87JMa7bSPSrQBbS+AgAOYj5A=
Date: Mon, 16 Jun 2025 01:42:08 +0000
Message-ID:
 <PAXPR04MB8510A1946372F37B5F97E9F28870A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
 <20250612-fec-cleanups-v2-7-ae7c36df185e@pengutronix.de>
 <729dfa8c-6eca-42c6-b9fd-5333208a0a69@lunn.ch>
In-Reply-To: <729dfa8c-6eca-42c6-b9fd-5333208a0a69@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8070:EE_
x-ms-office365-filtering-correlation-id: e8daff0a-fa09-4530-c32a-08ddac770193
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/NcoV1mKH8p6/RkbsTi4D6VYlf+VwpWQ/L6f9BW0p502X540U+eOnKyf5dnn?=
 =?us-ascii?Q?j8CHV3+UG+prpemHVbSmLjkCSZkxagLfq+cOe2+e2LinnRKtpDG5uOy9G54k?=
 =?us-ascii?Q?G1TGPKBwJ1IATFifRtLsnuF6wqZS2SJlzrX+0Dl7DF3/XsbNhsUivtkH5aaX?=
 =?us-ascii?Q?fnnTKcgcFXWkdUGEgunvl7Q9zB+i3t0YP7FmBGDOt7K6vFBuPD5sX0hN39lP?=
 =?us-ascii?Q?yQsy//xAY+OT2PizcUkhxXch3+T5dfCeQwKasTevwGyQibiPKwHHxT9zdZ5W?=
 =?us-ascii?Q?V8GgBllWRaWNTlm1nexu0ftjHF66Kx8hwvtbaD4U/5LtgLkm0yDq05iqQBzY?=
 =?us-ascii?Q?r0C8WDk+5IxJDvoBTDau9Xq+Jo6PR7XDkH28df6jd6UL1EdoRv90iz3pOz+5?=
 =?us-ascii?Q?F63tjLgsF/zNu36JIa7Dh4oQ6KrT4+rR3JD+VP/Dl2AOxmCI0GLY9+jiE0SC?=
 =?us-ascii?Q?WXk979nB5cveaRutzhkcrPwnZpZryAEdkLAeRGJuZhkjg5DPlN4u4X2/FWE2?=
 =?us-ascii?Q?1pVnEF4gUxiz9P7eCPKVLnTnn1+JYi0gkE5LuyEwLfdR4jd/7bHkehUsFKqF?=
 =?us-ascii?Q?Pmm/OYAkFZOxS+qZ+BRZ0QvPDOPNeAItDbY0I4yYwnY937PYJqHmL9NAqrGM?=
 =?us-ascii?Q?FI+ikrhEPAHzdqlK6dLraiaaVuhzAEtyfNyGCElT2OpxGkOPoB//imHHvT2O?=
 =?us-ascii?Q?E2nq8nmfo9QR6nw/QiX5WP6LiD9qW0WcyS3xw2hlT0mitOewQLs/Z4DZ0zz9?=
 =?us-ascii?Q?X6OcjGQmlBrEZI8L0KEfpa4wpxDc/DTEBM7c4bux/1QQssHaC1sKpYXJzR6R?=
 =?us-ascii?Q?m6DDW4PV2NjnxttgkupKmgsHeyBYRe6rFoUJ5moF6lb1CoPRLiuSjR7heNS5?=
 =?us-ascii?Q?7hGT3X9hyZUgPxMFiUPWtbe3bmAFepZX4Z77I9NMfhktakSWcZe0mRupHRAG?=
 =?us-ascii?Q?Mmb1nHzhbupycLoMYK9ZxM6ko4Yyw/QlZXA0NZOalzEG7Pmhzqyv18EcDMKW?=
 =?us-ascii?Q?+vJ42Qdm1toHuMj505ETS9CEmKZazrsVrdIohWwmIV3fdW3I6ANU8UD/UkfV?=
 =?us-ascii?Q?zGissXnPgUBQVX1Xu0RSh2Gj3ZlHP2BYHitiWhi0SYek/kHAMK8vDZ53ZHDU?=
 =?us-ascii?Q?r804X3JMDYlwPs2Q+5gu0Zc259xB022d1Oq9Ko1rQbJhzDNX1pe8CXk561qJ?=
 =?us-ascii?Q?wbZREq2nh4ntQvrjp6Wtff/vG0kqNI3hBA4g9jvw9NuGdhOM9iyCCTFueSxR?=
 =?us-ascii?Q?7HcClOrnE74TIs+g5W+nYRjFffbgCB3yrzalyMCQI4yMx7SU07tDugyr8D+h?=
 =?us-ascii?Q?sa0lcDl52N40pzp1iJfKDtRsU5XHPM3ebJNEYiUwrFvXv+9WP0zj2xoRBbvS?=
 =?us-ascii?Q?zZ1dP/oWCJq0tPSlBVWy0dDiTrBI6QXWQtbZCJTFTVNXCDpmVDHg9yMSFJHm?=
 =?us-ascii?Q?SGLIcF9jK44ZIUqJrGPJIKI/X29QNlwC28fStyEdMcoo5ZcDkpmZ7A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?460tiHiDx27E3Pya63HJjEwH0aa7HVONJdgpaIq8vXjvceFCdH7nzQ+whTRw?=
 =?us-ascii?Q?nVRelaESiiSyPXawQT43K5S9QRtuOH1DKbCmOXdk3UVBmS+IBnWENr9mFhyl?=
 =?us-ascii?Q?nmrXuAEPrEL9zlkzjL5+S2kdX0Evw5MBshYHMHhslQ5oDnfsJYgpLJLW2FDA?=
 =?us-ascii?Q?VVtUVAZGQIPDlU0l4mMnpcNwvgBW00wYqk9ORWnkJEczhQQbXAGTZPFN6G3X?=
 =?us-ascii?Q?eSD0tWPKaoXHIa2EcLATOzWfMnNwUY3dXn9ea7WS0TWwpdt/9inwB0X1M5yw?=
 =?us-ascii?Q?HG1p9WxRQjJslgaWEe/VjmYd7dQHcLy1PGk71dAjUwq2Z6fdtEctgBQOIFN6?=
 =?us-ascii?Q?jbTCNtqEe6dXO4/O/Rz0TRNjTxdDUhDV/pam8Ih5+YHjrnBLX5HsS49Ueqsg?=
 =?us-ascii?Q?JplrcNxtH1w4TBeXJtrKgDWioquKXUle6qWC0ccGwX1Q5a19QABbwh2pFEcp?=
 =?us-ascii?Q?YkLJw3unmH9AZIYY7Ei6TXjZFpkYOhrMDx8cFuy2ODoOKdwATF9LzxGcMH66?=
 =?us-ascii?Q?HFzNSNDn862RBvI6K2Vk37v8WqhT4sMZQfT5ExI66oX4+7MFKhoWjD7BjNKs?=
 =?us-ascii?Q?/pX4lJiGstTkVgJsFKdfiyETN02LlGBOmzLiJH5P+1k+4ZKYF1kr+mUmQHQ/?=
 =?us-ascii?Q?fZLo5goqyyrXDyYezp1ogPE6m08Ld8vT+qa5VipnjihaTdZhj6xdWQjdJgvg?=
 =?us-ascii?Q?vXKYQVaqdm7R0FOi5s9ob9dkt6G5Zq93iY7MMJIItuLPbRUVy70Sipop56MA?=
 =?us-ascii?Q?gbzG0naJusOsXo/PloF4vBfzpKjzlJTMc3OEj1BHExDWw+8U3/RQbiFfnYbl?=
 =?us-ascii?Q?KxVp1Yo5KK7fdZOuNsBCCRSgEKvV4kyaacGbeT8cwIhvQ5KaZAt6u3ePpxrz?=
 =?us-ascii?Q?bV4HSuiAxOsyCBtLx+E0EWjsuksjaBekaDlsVWvPPjghjIkSntKb17CmfpFB?=
 =?us-ascii?Q?hAuiWmEBrpbMa4aWaJDg225P++1tvUPH0v9L9hL3wTvgXtisaHyrOhc+Vmjr?=
 =?us-ascii?Q?iV0Ru4Amlj+DeIOPjR7evp4O47vFJMLPU3toYOOf9eVBsYUnzdOILw0/rJpL?=
 =?us-ascii?Q?eq4JF/VXlSRXm9b+2Q2z3gnvRDs1vFht0hDd4IBfe/MOL9qigddGzWQ02ZuL?=
 =?us-ascii?Q?d3EflbbuqiiheYVIj1JFhhZh5+OmS3e1Cw1P/4HdSaEKI4ImlkJhctENAL81?=
 =?us-ascii?Q?BrR0LnMvmG5ALIAaQVM2YtpU/vEAjzq9awuPtAZJpL01NFZHLMilscBt+9Wl?=
 =?us-ascii?Q?b/Ql1oT49XDFD9xBlUb5u5jt6pnL28pCS26Ye7NAqS2mT7hYGEvqZt3HkW4j?=
 =?us-ascii?Q?79+ADYkjMTs7ElxGLkbxv3u8NxaYON+RTJKuMokytpnKPABLgb1Z+Xk7zLJn?=
 =?us-ascii?Q?OoXbjcMElpgru7cgwQo5upNGl+3jd9aD7V/mMSf9vP9In4WL/AlQ8Fk4DwXA?=
 =?us-ascii?Q?q7gyEDjxaT3sJ6aGW5Ym8VYfjcEmaKrk0OGI9fnegpetbR9fllq/nQDbofQq?=
 =?us-ascii?Q?S9AJ1eSIQiPZqIckwBICchsAqDBqsXz/gEUClWIRSB/ke/cX7YqsVx2PWCtu?=
 =?us-ascii?Q?1obcY8jT5bzqTUTPA30=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8daff0a-fa09-4530-c32a-08ddac770193
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 01:42:08.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: omiIOoLNJfeP8PSSTYRZimUKLB+VN93MX1S3SFuvY9axA5GhtqbN7sQ3n1IcuOWEL7Q2csyQ+LdN990mECpc2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070

> >  drivers/net/ethernet/freescale/fec_main.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > b/drivers/net/ethernet/freescale/fec_main.c
> > index 6b456372de9a..f238cb60aa65 100644
> > --- a/drivers/net/ethernet/freescale/fec_main.c
> > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > @@ -1860,8 +1860,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16
> queue_id, int budget)
> >  		    fep->bufdesc_ex &&
> >  		    (ebdp->cbd_esc & cpu_to_fec32(BD_ENET_RX_VLAN))) {
> >  			/* Push and remove the vlan tag */
> > -			struct vlan_hdr *vlan_header =3D
> > -					(struct vlan_hdr *) (data + ETH_HLEN);
> > +			struct vlan_ethhdr *vlan_header =3D skb_vlan_eth_hdr(skb);
>=20
> This is not 'obviously correct', so probably the commit message needs exp=
anding.
>=20
> static inline struct vlan_ethhdr *skb_vlan_eth_hdr(const struct sk_buff *=
skb) {
> 	return (struct vlan_ethhdr *)skb->data; }
>=20
> I can see a few lines early:
>=20
> 		data =3D skb->data;
>=20
> but what about the + ETH_HLEN?
>=20

The type of vlan_header has been changed from "struct vlan_hdr *" to
"struct vlan_ethhdr *", so it is correct to use skb->data directly.

struct vlan_ethhdr {
	struct_group(addrs,
		unsigned char	h_dest[ETH_ALEN];
		unsigned char	h_source[ETH_ALEN];
	);
	__be16		h_vlan_proto;
	__be16		h_vlan_TCI;
	__be16		h_vlan_encapsulated_proto;
};


