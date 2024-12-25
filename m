Return-Path: <netdev+bounces-154230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7359FC32B
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 02:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A45E164DD8
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 01:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931C101EE;
	Wed, 25 Dec 2024 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HFnd05zA"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D6A935;
	Wed, 25 Dec 2024 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735090743; cv=fail; b=VSkSH2AKoN4gCs9DSM8WNeN2Ic0ILWkZOGJBQZ+jymKW1+hoqsv845n1C6AE9MRUOgq/m6XWzW3mCBImIxOVigTssouoxL6BCaUNR+TCjQa7IxJas3FNi+e6mxn3g1qEflH4BslRjjjWP05zdn9Tgio7XeQar0Ktg7Fs883WD7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735090743; c=relaxed/simple;
	bh=klB02zbMi394dJ9zw751zI0yhKbZvoMe+QxmHhEPFxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fnp7nBnmKpf+2/2m5WypTKXrX+Uf0JznbyxGJ/Fb9ckMrPLzWW9AMLd3AM8gGsstbX6MLShgRyZvMr4TYEaIKHaR+5lSffVGWcwYjxR+FPjvWydkYVwQI5asA0TQ2IXVHN92RdEzaqx6JscIr954nbJmEOtE6NCGRTjm4HDYYkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HFnd05zA; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+iOmFBzziU4Z4JtVvEvacdyFgeuw5cOmm9XR/4mRF5/2lqqh2fHLTo0v9Cr4d/ETgICQFhSEb7su2vrzePv+i1yvXkH06O01uIKxwJi2AaFmGhsN8JfXDRU59P7pNEy+aSGSRRVB8kTO2ziXbL/dgIiBCRSuSpdHHD4EfVWWxQZEPF+SYBojVhl+Q9uxABOpRlL9a2Dw3boEUUew00ePNdYr0OsvWgK6S8tdzpP4hEtcfAH1MhlVymYmoLSNPU6TAYotmUtq0iXow1DVA6D7UFovSfreGB7XYFlKS4QxQ9TsaqwlzJ3+se3Fyl2/CNOYHwvJW8Rh7VxkQyq6y2kWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvTbSFyr2I4M9ErI+PXD2bGbOeCjVjMl1HQRm7LNNeU=;
 b=cdqQDEKDdFPjlZ8uiZ3xaOnDFad/cP79nSugBOzbL/5OAmYldGBxY750D5157Rp2CWPeH0kRsS0LqFY7OmSkhD4iTLU5cFTu/yFGcl1rmDUXNpeAciB3Ty9eHv8xZRxZgtnVQ3EI9tQG1OvLA+mX2IDZ6arviERA8pe6XKsmijaP8yfcp0Eg+vHHKy1IoLv+YXx3IkoXNaJo1TqZm6pCg36Wn8M0igMzXJ9Z6DxO39b29AztoIcwFxdxQwxDk+GVCfM575r+z3omw/6rLHsk+UyIoZZWddk8sO+DnbWv2iFwX68FHwkIp56+DYb0Nmw8LL97/G6feuCM2ygyToqzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvTbSFyr2I4M9ErI+PXD2bGbOeCjVjMl1HQRm7LNNeU=;
 b=HFnd05zAT2BeXdrVyErpPOCSVGiB6u/BHejfUDJ65MULBUs8zxnPRuhks+eWwlKy/gCs4ZqRil6enwzzZoDLFD/a6/cRtYeq7JwlLQ1XP+EyhuLO6d+poQ8WSFCsVkYgYiTOKtcpkkTr9l69mfB/IiOKe778mqeDMyT8QgyhswET3dsMdPvLNaaK9yrjSwNvZGDi/PPw5p7fejouan6dWYPAci2Mes8iAWJi9XL1KfuAqQepHg093he3GGw1tLdSIrC+f3F2ngauKpbIGVNVNXBLgrUhQBM2goGDJnlVwserWTdsYCiwgpsS//iIXSbtk1s6ddgyprVUUqWvXwXS0Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Wed, 25 Dec
 2024 01:38:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8272.005; Wed, 25 Dec 2024
 01:38:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Kevin Groeneveld <kgroeneveld@lenbrook.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: fec: handle page_pool_dev_alloc_pages error
Thread-Topic: [PATCH] net: fec: handle page_pool_dev_alloc_pages error
Thread-Index: AQHbVXTL9rxP31UEeUuKxD7ADuRne7L1H4PwgAC4EACAAFgqoA==
Date: Wed, 25 Dec 2024 01:38:52 +0000
Message-ID:
 <PAXPR04MB851008E9B50351D84CD89A8D880C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241223195535.136490-1-kgroeneveld@lenbrook.com>
 <AM9PR04MB85059A742116F7E57D0DC32288032@AM9PR04MB8505.eurprd04.prod.outlook.com>
 <bef66501-f769-4196-924c-1ec9ba2cfc93@lenbrook.com>
In-Reply-To: <bef66501-f769-4196-924c-1ec9ba2cfc93@lenbrook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB8PR04MB6956:EE_
x-ms-office365-filtering-correlation-id: b43af35a-41ad-4278-b6a0-08dd2484e348
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?w1jBJutED8f+x01WTfg/+WfVIyqfN5HnS71vkD3lFKZ1P808s95a888v9gG3?=
 =?us-ascii?Q?NfneFnOMJnR9PWdxG7q60eLTETeeOdi+bheUR5OXa+ZEBCgvoJPbrHSy/seA?=
 =?us-ascii?Q?IT0VRweKsc0a/AJD1CtUa1l9vN5JnWpyTNVDoBWfoEHpKCu4/GKL3CQACKJA?=
 =?us-ascii?Q?p7C0508Oxe3PTRGtaW1zvMQXppf3YGagj94CSwLoQreMx4FEMuqODz3ALfkO?=
 =?us-ascii?Q?VpNGbkWqqr2KHir61osK9/dl2upfqAagTIYw3fjJIShYnlqqTz5UTDymY1Jm?=
 =?us-ascii?Q?RAiKKWx77JwV2lzf5VeQLYetG9nN8zzC9VT9PuS6J/rVeYAvDqMWXq/Q51de?=
 =?us-ascii?Q?yq+Zz2VrUmk+JjSZR6cHRShLcMCvDMyo0Nj5um9GwLg1Hbwb3PY6Tsd//Y+V?=
 =?us-ascii?Q?Sj5V0tN2zNoX0HaAk3Bs7PPyzVbaj7iG1am8yDR54sdIt1tmaZTOAAhacmv5?=
 =?us-ascii?Q?xcLHfHNAiQhwDqvmorTgQsc0atVlWC9IQ8b9CnZgKDi2BRCpenEq9+IQ7rAQ?=
 =?us-ascii?Q?f5PguE2bSmbGzWn1GcOZioTFUnwwYiiihhb5N3GDUjHoIFURdGMG9ruECDFa?=
 =?us-ascii?Q?PNPwqt2NbjWcx3EjrFExyY1iVlePRki2fseznWoZifwg7hPVX3kTpoD5OoPA?=
 =?us-ascii?Q?tGvN16O644rp02vZgdl69DaVHL8pkSlolA+dtMQ5yOMA1cNjb8Y+LkxzERW6?=
 =?us-ascii?Q?BhHIHlpmz6/sy/JtXo9dasbOGXA/ajXUx6PKbG5u4Cp99/dMxh8Im/e08gGH?=
 =?us-ascii?Q?65TfmCOKTS5qsHWybX3xHI8mJ10HH8gHagErXhxnkYGCh9AT5vtkvabF3+fw?=
 =?us-ascii?Q?i4dHKJab9diBRnS2edFMk8lrebEHoV+A9y+OoxFt3MIXd/UcmTUZfTsttPnf?=
 =?us-ascii?Q?6bCeWeg0CMYCHs7yMZ5UAIdTGKgbzlVoDacgOv60RWg4GH2rfvVtDVOt89qW?=
 =?us-ascii?Q?HN6Hko4syLBgLiMB66Se8Ppind9xzlvwElchSawkvEXWJotvDTJhVdaOnZvy?=
 =?us-ascii?Q?lKFiikW5DU2Vn8/IyJdn/5OubmtSDeR3CyD2ILrlfGjank/1CfOCU8WOgW5q?=
 =?us-ascii?Q?5zRvirLcPlu2YlMOpWdXSQABlPmqSfP68qV6TAG3xIMoPl5WyGJnQBIEkRQb?=
 =?us-ascii?Q?SNuESWxtH0938+ppeu/CnYSP/FP9AJRfwrv0UFcOUOXI9F2uBpKnTiWtavp0?=
 =?us-ascii?Q?n6/nzOIYl/qXw97OEoyrJhO6KKFNXyXcrQtVzqade4+rGxhcG6sX8J1d7rNl?=
 =?us-ascii?Q?R2kXyQ+g8+2CqTJUJN+eJdl3n5uGw+f8n+rk3bNGLR+LtfjBhk0fKZ+n3Chf?=
 =?us-ascii?Q?pqwZFUmDp0cfLtUSHO4btEr+jeQanQZiSuRB9wVAl2xS1ERlj+APPSU13rRc?=
 =?us-ascii?Q?qL5im7229big2G3yNOdBwMHbJWB+P9maiKIh+bAS9pa4YTaboxdEOikk6cB2?=
 =?us-ascii?Q?wXzKFyWrqIBOeKlRgqyCOrTaAaMwEsZo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zXKcM6wKzzLTcQFdtz6HJE/YcOfzp5MHf+x11YchJlpfq6jqp3FRcT7jLX7r?=
 =?us-ascii?Q?hkrdsBNX+t6Ar8OXToK1/d4t6vgh5Bi8FxNWaIPKcvxGQyiOeqXiew0GNpM2?=
 =?us-ascii?Q?xGDwTUgdLpfU3xtdqce4ec38GLsekN9hgS8h22rRzMG2KdVGTEfcIixvrprR?=
 =?us-ascii?Q?G2ASjyjTifSVLq/i1yA7DfS8feHBv461o1dT6W4nWwHxZMX7aoCuDC3jR3iT?=
 =?us-ascii?Q?DFnjRbDRR2WZJwMU/aLBKE+oKUZjoo8J2pgSqA0kiANoObn4/fUUWq5VVmuz?=
 =?us-ascii?Q?CHoabtxfjD2RPqhN5BVivDykWM2XySBwgj0Z6cSZQDFDvHuR2KQKpqUqSp9S?=
 =?us-ascii?Q?F4FjA3CB5n43Dw160D7UXU92HUeERbW93TTOqd2yrkbjL2SOkDyzMGdwa2je?=
 =?us-ascii?Q?1uhEG80ALG8HbINU4406AK7cVSLRfac6sFH+AvnfQxebXuodww1L6+TUPBmp?=
 =?us-ascii?Q?Q3s/dyMia6vTsN/fnVE9KhgNWNR/7/s5wgBUsLuWvlbllc532pywIwBsc0gC?=
 =?us-ascii?Q?7zbw3AY7VqWxLXAWugXLYllaU8zflgh/0GgzwCmiFWOHNVrTIWw8tShggM95?=
 =?us-ascii?Q?F++OpT7mbRHlC4ik0nANzCcSjUPfHCnLBHrxMOiGsECT3DU5mo3eai00+xju?=
 =?us-ascii?Q?JX1AdXSQuI84gQa5wVl28thFLJmCVFsGjeh9EeQJRz1kSzprKzVUJvotLInL?=
 =?us-ascii?Q?CfVCpjHs5n1zyB5Ox5gJaF3/96MLnChE9Q1YXD37soXv7RkecSMsL/MhSkV0?=
 =?us-ascii?Q?mR8N4HnIV2iEO+vLjClzJYVM4rqWVccQI47bIxFYHfS2XyzuUrORpQDMhDbh?=
 =?us-ascii?Q?nb1bg/lszdITHqp6bhJSLcLyk5agQfhdZO7NgiLeYmSPdUnWYeTdGUb3Mq6Z?=
 =?us-ascii?Q?tOlHgwBrliNBs7P+umAgSN8aJw8mhBlhiuHM6QmXOEYs6rOUJOL5rYbjadfh?=
 =?us-ascii?Q?gk8ONM1IPxrytaVQma+ColuM/Zs2ejfmncqPjCiOPy/RQ6NFHGIR/hjsZ7HC?=
 =?us-ascii?Q?YZcbj79HuMlrVVWvSXGBLrc+V5Gd50sByxzPJE4iAM2yyQIdz4xMJAnV4kiB?=
 =?us-ascii?Q?7KcY/p9FDVtEyCg6J92ZiZwkawMAvnWPDRB6+xqvOt7ugI88cCuiA4FilBNL?=
 =?us-ascii?Q?Uv9/MkV0wjrR2CHZeFyViNjJEMFCuARXHUtVLn6M5zmghU5kgaUEmzzd0/E5?=
 =?us-ascii?Q?+d8NKlWbIrkd+To90tpVTP16YpsvOGVXP7rXbDTfIiqaWI2mvo9IeI473bJf?=
 =?us-ascii?Q?LN34sdbQ6nIYpAWynaSoiiatSNXMuRGMKfe4/xoIwhxVPihEfzIoCD590TQa?=
 =?us-ascii?Q?RGXueP7AveqabPuPMg2LB3nrP7tpzApPttCHp4BFrGWdPA9xlt9A4yRRXkGL?=
 =?us-ascii?Q?Eubg9T0s7B4uEx/f5dOc5BbS4x8732ZdkYu0wrXb3cgOAfgeH/9PkdTlD9kU?=
 =?us-ascii?Q?MToai2VsQvzq0k1+woLvjaggz8OR9WY22vHIMpcB7/S3R+ddSpWX6smWVMCH?=
 =?us-ascii?Q?cF+CkVYfm4Cos/Z/E2zXRPaWO98o7zAeY0bQjIccWTQXmIxSPwypwRXAeRpw?=
 =?us-ascii?Q?mZf7Wn+Dib3NHiDgoGQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b43af35a-41ad-4278-b6a0-08dd2484e348
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2024 01:38:52.3801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vE9okn0LHSbPinfZk4whZUrCZWjOF7ZtvMOsEBxs3SQrBEU8E6j4ZuCfSlT/+7YyBludVShUp+/wQzs3j1cQtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6956

> I will simplify it.
>=20
> >> @@ -1943,10 +1943,12 @@ static int fec_enet_rx_napi(struct napi_struct
> >> *napi, int budget)
> >>      struct fec_enet_private *fep =3D netdev_priv(ndev);
> >>      int done =3D 0;
> >>
> >> +    fep->rx_err_nomem =3D false;
> >> +
> >>      do {
> >>              done +=3D fec_enet_rx(ndev, budget - done);
> >>              fec_enet_tx(ndev, budget);
> >> -    } while ((done < budget) && fec_enet_collect_events(fep));
> >> +    } while ((done < budget) && !fep->rx_err_nomem &&
> >> fec_enet_collect_events(fep));
> >
> > Is the condition "!fep->rx_err_nomem" necessary here? If not, then ther=
e
> > is no need to add this variable to fec_enet_private.
>=20
> For my test case it often seems to loop forever without making any
> progress unless I add that condition.
>=20
> > One situation I am concerned about is that when the issue occurs, the R=
x
> > rings are full. At the same time, because the 'done < budget' condition=
 is
> > met, the interrupt mode will be used to receive the packets. However,
> > since the Rx rings are full, no Rx interrupt events will be generated. =
This
> > means that the packets on the Rx rings may not be received by the CPU
> > for a long time unless Tx interrupt events are generated.
>=20
> These are the types of things I was worried might exist with my patch.
>=20
> > Another approach is to discard the packets when the issue occurs, as
> > shown below. Note that the following modification has not been verified=
.
> >
> > -static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
> > +static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
> >                                  struct bufdesc *bdp, int index)
> >   {
> >          struct page *new_page;
> >          dma_addr_t phys_addr;
> >
> >          new_page =3D page_pool_dev_alloc_pages(rxq->page_pool);
> > -       WARN_ON(!new_page);
> > +       if (unlikely(!new_page))
> > +               return -ENOMEM;
> > +
> >          rxq->rx_skb_info[index].page =3D new_page;
> >
> >          rxq->rx_skb_info[index].offset =3D FEC_ENET_XDP_HEADROOM;
> >          phys_addr =3D page_pool_get_dma_addr(new_page) +
> FEC_ENET_XDP_HEADROOM;
> >          bdp->cbd_bufaddr =3D cpu_to_fec32(phys_addr);
> > +
> > +       return 0;
> >   }
> >
> >   static u32
> > @@ -1771,7 +1775,10 @@ fec_enet_rx_queue(struct net_device *ndev, int
> budget, u16 queue_id)
> >                                          pkt_len,
> >                                          DMA_FROM_DEVICE);
> >                  prefetch(page_address(page));
> > -               fec_enet_update_cbd(rxq, bdp, index);
> > +               if (fec_enet_update_cbd(rxq, bdp, index)) {
> > +                       ndev->stats.rx_dropped++;
> > +                       goto rx_processing_done;
> > +               }
> >
> >                  if (xdp_prog) {
> >                          xdp_buff_clear_frags_flag(&xdp);
>=20
> Thanks for the suggestion. I had considered something similar but I was
> not sure it was safe to just jump to rx_processing_done at that point in
> the code. I will try your patch and if it seems to work okay I will
> submit a new version.

Okay, but this is just an example, the official modification still needs to=
 be
improved, such as moving 'goto rx_processing_done' statement before
dma_sync_single_for_cpu().

>=20
> I probably will not have time to work on this further until the new year.
>=20

Ok, thanks a lot for helping fix this.


