Return-Path: <netdev+bounces-217244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A36B3800D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0CE3B9FDD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89D29B78F;
	Wed, 27 Aug 2025 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="T4uzSmTo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F582E7BC2;
	Wed, 27 Aug 2025 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291281; cv=fail; b=BfxSBNf/V5W5UfkVjmCAjBsGOigecbSAYRgYuTonVU4flGr+3ENohCX/nQFHBAg4eZ5Hbf8BCX2ONgdm6zylDZfMzhiTUWAT7yw1/wBbTUXgha60MG5CevMfDnAOzlYj5dIwJycsaL+cBDjP0qJwq0y5Tms5knwypmHQI7D6gys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291281; c=relaxed/simple;
	bh=Nus2mIpWZvaKUFVgH7/gEoMb5vigne2/U77kFurXmh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arS1IUDAuVSmlrFssRghLx+jNFQ7ATLXtmlvDUkmOswPS9jzZhA4al+6Tj7pL0A6JmCV9FIl6jbkUT7qr++bEaljT2szqCsDLj73brhikSCIyN/AxjxRgdxxrknsPBZNDOACpe3iMTe0qfkOAkHgDxMElsBc7sOMXruWFeWH1cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=T4uzSmTo; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZr+J/4FoC3Wsfc0mhjDYFb4ARYeiiTBOByeL10sZWTyOJE9TbSdXFxHv6PHij/6FzNOx7Dnjbrxd6rugvnZq7FyrZKomfwTcHc/n0yG1LtgnBhexa0kvmHmraSqj7Eq1e2CgU+0zL4ho0mST2Jg0SQ6QmiTSf1PmtnD+VLEcuGd/qCnLH3ApMKKab/NhaFZZs6znCWmRLhxJnwx3CkhkU49oxRG1HYXHPeUUGrJGFjOqR39fJKmXvnnmCRL1jDiEqCWtMmUdU4T5CRusG3/GBJElWncmwGxFivFpXswn7CDf59Xy+0+i1aux4jaQ/wDcfFlpmzjy5xkg78Y3+D3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nq3dw65/cPQ0woFdgKMOyD9yQsj3HKxlkduBYxe98gI=;
 b=LpOgjTuDbtV0WjxY8ixHp3dwXS2nBgcNOlb+F+lwPvV161K+PH+6nT8AbNErcNSgYZKeZxmhhTkuYLJennnYZIkm7SoH/q71ZsAO4bRtpSM9cBkSSuElpvXYZyncvKlEVPI2njEKwoOQrExGK/PtA6VAH8OQyvxqF+jMcRQg1VwLdZdgQuT0ddOOsOuBO5ssPjK+P3+aT65Iak8FTQH0p0UNHETkuu0/z4D6BAudzrMU15ZrG6mnhr9n1LzGgvFi//vVgXQY/CWnKJqYKbmmrlWIoeexx54d+fqTNmyKAhMs2nUftTUVl6Aw+ddpGT9Yhkc6bT8rE8xBI19WVayAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nq3dw65/cPQ0woFdgKMOyD9yQsj3HKxlkduBYxe98gI=;
 b=T4uzSmToBWCbmq6a2sg8hYiDxJ7TOv+d3tD5bsm46Z4+tUmGU5PpsOQIlCgna3ghkWcPDW9LdbuvmjIY2Yh/2jl+smKv0/93gPbckjNn0JsV0//AD7SLqLoIVEOGzrYiprc4ajH7yZ5mEYiiTvhfsMNOMaUEx7S7B7nDYQTELHkNiXNi3lLhGwpL/VCyhcs2HmcuD0psEa2h/pMk1ABrigXgHIa7htlFVryx634sGRLIuIrT19sYJxicK9eLGOPN/ryfkM4N1ZB4Nt1KlCvKpIWZqM3p537Wmm9APXizTGTJCWQNp4vOThlOxIrObHSJCWE1WFeZnl4xQ/DWAQE7wQ==
Received: from PH7PR19MB5636.namprd19.prod.outlook.com (2603:10b6:510:13f::17)
 by SJ4PPFB04496E67.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Wed, 27 Aug
 2025 10:41:15 +0000
Received: from PH7PR19MB5636.namprd19.prod.outlook.com
 ([fe80::1ed6:e61a:e0e1:5d02]) by PH7PR19MB5636.namprd19.prod.outlook.com
 ([fe80::1ed6:e61a:e0e1:5d02%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 10:41:14 +0000
From: Jack Ping Chng <jchng@maxlinear.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Yi xin Zhu
	<yzhu@maxlinear.com>, Suresh Nagaraj <sureshnagaraj@maxlinear.com>
Subject: RE: [PATCH net-next v2 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Thread-Topic: [PATCH net-next v2 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Thread-Index: AQHcFjcUqM/WV1D1mEmYPi61TjxC27R05xsAgAFkXFA=
Date: Wed, 27 Aug 2025 10:41:14 +0000
Message-ID:
 <PH7PR19MB563654EF8D30DFE723775340B438A@PH7PR19MB5636.namprd19.prod.outlook.com>
References: <20250826031044.563778-1-jchng@maxlinear.com>
 <20250826031044.563778-3-jchng@maxlinear.com>
 <4a3c0158-eda0-42bc-acfe-daddf8332bf3@lunn.ch>
In-Reply-To: <4a3c0158-eda0-42bc-acfe-daddf8332bf3@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR19MB5636:EE_|SJ4PPFB04496E67:EE_
x-ms-office365-filtering-correlation-id: 3db1246b-9979-4de7-3c10-08dde5563f5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2N0cUlBGZTqVdcOiqB0KBXECyU5m0l1zk0sQNMdKCeDWTK3PwCEKRXDnNP89?=
 =?us-ascii?Q?CgaH4sxwXRmc5eZY065nCWDXGJoAwrVFMkHlW6Wp9a6BmO1vmU8fSREhCXfh?=
 =?us-ascii?Q?TfgO/kfhUNrCDJcr/eabu2F60Dc+yhy/9vttYgkkeldMw9sIwPDnIYUTiTht?=
 =?us-ascii?Q?LIYVEsw6WVCfN2Vz23LH6JmZmigfhej2qbM0/UPPOCIVULxGkpMhwE6vS6MK?=
 =?us-ascii?Q?QwrxpKRZaTjCJH9Ov16rejWmuPxAWpNTIAJB4umlISwlN0IJa1nfwzpsJqsZ?=
 =?us-ascii?Q?AurE0BBY+UUQXEOR/L1Cv8A+yeamMjBLJ6TlYC1f9N4lnyXM1HccCwC/hl5x?=
 =?us-ascii?Q?Xh25z6JK+70Elg232hXwEmFU62BFlUNgF85j8B2ojl8dFQ8CTLiPkqX0PUAy?=
 =?us-ascii?Q?PFBulX7JzJUc4W0/x3HSOZjsDPXBBn/qA4OcUHzi4GUWg0vAizzAxT6TCVuc?=
 =?us-ascii?Q?9sY8Nqkn6wdqmJeG7XMta1VWu+O8dTf9v1Erp0PioKUJPg+2it1xqCweyVZg?=
 =?us-ascii?Q?JK3Xp9vAw9qgedoGj8jfVUoePCdgL9ElzFNvn3NnSt9DwjX88BxXcOAT/ikd?=
 =?us-ascii?Q?YYsxNzzS7kq8UPQ6C9PIXZhtU3xl0IdPRgjbOJ94Uc9/MJo5+4/eliHmAyAn?=
 =?us-ascii?Q?h4vg/Nh6MTXCsRi7voWp7EP+4p9rv7l9YQBSfyx7xIlAOOSxMBHVGU4br6i9?=
 =?us-ascii?Q?uEOUnOf4VECi4WORkkYdySpXozBTH9GMplwRLmzcE/Dfw6gqh7qRhRxd9Wew?=
 =?us-ascii?Q?IcznnrHvgq3H46VkSeuXE/DoA7BYZPEm8P/JojtiCz28yMA++Dgz+rXW7QuL?=
 =?us-ascii?Q?WtYhu7fzM8vJHNuLrSb2eAxoTlWlwgEwpzScaXV9jTm7V5mFq6iqr8VYEBn4?=
 =?us-ascii?Q?CAJHZ0OE9saAzJumSwd6+dWa51Cdg5quVRPFYfLLq7Bi042HniK0U8d83jww?=
 =?us-ascii?Q?ZKvaId3bwNhNRnJqPR6RTn3+eHTTlv5HAaFARX9i/6pW6dwLWaNXl9jl1zxG?=
 =?us-ascii?Q?ZTpf0ekvqgBykJ6iYET+obfPxy8TOsCVeG4nh3NPIBbfiZjDsKqSZK+33XjP?=
 =?us-ascii?Q?JrOMKNrengkylq4V3UuRFRw860uOdi5unNimjN9fiz7KuSX9HAzKp7kmAZTo?=
 =?us-ascii?Q?DFR85WmMZPxFX7Qt7gF0r3cGIjqvUhhNKblvOVvPD4SIgsNGEIZjV4rEOmcK?=
 =?us-ascii?Q?d2zgxi3B7Wqoj5i6FktP53HgkEdRiPY9Gp0AkqN9OmWI01BvtdiRrDad36Hp?=
 =?us-ascii?Q?VuvUsXDyXYbHZo12QFps+Mx0B4o4U2Mnj1kxSsTCcL+O61Y6IIyO4mnO7FcV?=
 =?us-ascii?Q?+2llyc8JzkMCwj8ZdWF+MaPQksdUg2IYqyuKBR6NMQRfPCSyg6GGSZ3aP7rJ?=
 =?us-ascii?Q?dmA7lmUqpnJID89VfxUIfWK4m2uxIOfPpNfrbCV3SRyNosFRWNzRDfec3Vyi?=
 =?us-ascii?Q?vr36FblJqAGwB47qNtI0Miq3HFJ8tKcJdrVoHwv/5UVijo3ikAeDeA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rSv0ZmKFL2ZGyXSm0qzuKuRjMBeAfjKwRllXokZKtg57TWqt04DRonqwRmYs?=
 =?us-ascii?Q?eLsc3V7QYCQQxoVvOvvAWtnSs0Os2EAFyYx1e+bKSLmJrW/ocR0aLFR7l8XI?=
 =?us-ascii?Q?tBIovRhNaDTBwfimelE1tdM8XIzc1duJm6lbdftT3Vnd54Q3u03ff8d5pB7o?=
 =?us-ascii?Q?wxBEflp44Bk5eewq3lTBfdXPqW9tWPi89oq2tzmAhvJh2MdG+a/So/wLsR1Z?=
 =?us-ascii?Q?etqkd1IrR/eRtxf5/FYv9Nk+5+JJ7cxfMRCkpjG7yDF4YCul0KVr4gTxWOx4?=
 =?us-ascii?Q?tEKIlMRw/Zt9YfbPm77I+SIqyrMyWIX8eAsk6Vim3BGFR1FSVGM9QVF6e08E?=
 =?us-ascii?Q?KeK4O4veMrghuM0Xlm30LNqhDfuL7zKpoZolLyi/kgEVz/h5XuXxteT1vQQB?=
 =?us-ascii?Q?rpHLCReiiU34Sc/x2T72M5Kze1IxhJRHVhCvOkqtlg6lCZtVqSe0U4unAp9X?=
 =?us-ascii?Q?saZkofUnuPYM2AJw4bHsLl1gpsncac3mmZmY9L4uE+h0/1jTfLiX7wWHMOKR?=
 =?us-ascii?Q?8QD4B47BmrgHlegExohF4xtqAcP264qBrFiTxtIRaSVBGmqmv+LVycEGbeuA?=
 =?us-ascii?Q?67RzVTRjk4sT6iiUAsjXTNtvcy8+x+CsCP5jxdBVdFJbVhq7TmsHIPBmsw+b?=
 =?us-ascii?Q?ryGe61iWYbyy4S6NxezznQfokVhN3hf8anZ/pCFkKNbtPurbA/fp9IG8mmFw?=
 =?us-ascii?Q?7T4Ty2OjVMwCzPbncM1CV6SsKzMdSTrNjgp8GYuS5+eiZzSR1fNWBAWrqrgH?=
 =?us-ascii?Q?zIK+Dk7BT0T5pWdXHDIxhqKwPuHobumkrXb6aXKUXzr5ECJgPS3KvYuFiEW4?=
 =?us-ascii?Q?lD06S2aP32h2lrlpooqM72aXbhzFMu6kKaCkVXCjHqHukbWCugAVuIq2Hz3+?=
 =?us-ascii?Q?rFL+KgduOSrfCmKaMb+mFslbtJ7HeI0nXCkCwJyFiKJ0EinSmEXQn4oCZODX?=
 =?us-ascii?Q?05qiV23KQSCLN01ucU7BnFZXgp1vP+uCkLXWrSvvbck929kO8MFdaelAovrU?=
 =?us-ascii?Q?kTlPRw+y5qcOdXz2vERzEzSk1WgpMDBitWL6Mh861DEzUiXOvunDfUViFLVa?=
 =?us-ascii?Q?rxVUPxcAgT3kbNAkdnL94Mx4WmP/hJrt9zy++e4A1w3N0lTlsuGVRXBAlVoR?=
 =?us-ascii?Q?llsdZkP1Ofs9loTKPB1Dlpe6XzygjhBv0ptBduHk3aau0IvpHCzrUi2WIZV/?=
 =?us-ascii?Q?UbGjDVddLR7nKkm/MFxIGzOLKaT2c4xwN/fi/BiUL7ansI2SSr8JRWAayMSh?=
 =?us-ascii?Q?4Kn7YIQX72hC8r46lm6UkzuOQhhXqvTjZKo5XOwNE3/fdzYX3Ve8hWTyvOB/?=
 =?us-ascii?Q?pOh/o/YzOnYsbBP04gkGYcoRX50h1+ZUSIme8puusj/YYDtkGZ+baSk7etIF?=
 =?us-ascii?Q?iLLTMnw/bMq1TmZFBDne6oSWhiC0B9Np5q3NT973scv8xpvRrUzykUnhE9An?=
 =?us-ascii?Q?rgPDIKxB8mKNvgNf6IEbhiWdeE1ch2qMPMvTa4aAdiA0sZBcScj9E2QJVb4o?=
 =?us-ascii?Q?uqrHtM0E32CYnsAxbw9iOJEHL2Bnkvc5OLxkuMC4/+8wX4+T3sbDmzZhi5IS?=
 =?us-ascii?Q?jgwWltBrFl5WnrXg+Uw46a2nyuDu5pcRdbQs+Il/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db1246b-9979-4de7-3c10-08dde5563f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 10:41:14.9012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+n+2SA0TM1nQ+uCjcMBwXGWdQp5r/YD+hw9Sj59nIDUPff+mv2AzPBb2SJPvef/xYVuffP5pEjxh9rUPZ8hOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFB04496E67

Hi Andrew,

On Tue, 26 Aug 2025 15:03:08 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +     rst =3D devm_reset_control_get_optional(&pdev->dev, NULL);
>=20
> Why is this optional? Are there some variants which don't have a
> reset?

Thanks for the review.
Will change to devm_reset_control_get()

> > +     i =3D 0;
> > +     for_each_available_child_of_node(pdev->dev.of_node, np) {
> > +             if (!of_device_is_compatible(np, "mxl,eth-mac"))
> > +                     continue;
>=20
> Are there going to be other devices here, with different compatibles?

Yes, other devices will be added in the next patch series.

> > +
> > +             ret =3D mxl_eth_create_ndev(pdev, np, &ndev);
>=20
> Shouldn't you validate reg before creating the device?

Will add of_address_to_resource()

Jack

