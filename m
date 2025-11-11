Return-Path: <netdev+bounces-237456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB6CC4B8A7
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 06:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF3D3A429F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 05:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B636B283FEE;
	Tue, 11 Nov 2025 05:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cZ6lR0GZ"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E8237A4F;
	Tue, 11 Nov 2025 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762838956; cv=fail; b=sgA4n3nUVlbiaLHSpYEDgpi1X56mYlI9J1A/KAoQM2RJNIbI6cuTy8llAokTopxIqy6t+98e06jjaK2lDvlRBmzf4/W468acrzfCWUGDWPHSLjetAFRZeed1paHEirmCmI05P1bFz/viEfTTjBVsfFABeYypzoE8RTojJl97oxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762838956; c=relaxed/simple;
	bh=P12yW8ZWr5ZqXJOgInu0Qke7Un33B82AFc5v2jha0mE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r0XuI/6X8WDufYIbkXrOmodVn8wUs4ZTHQEYvyX9rnTrSCQMgtlbEbqdW71Zr8o17AuNyq5EffioFdfX7mnzwXH+XXgy0XT6NBq7pTWql6pP3zX3SrnHMDEScagW+1fq6vdjYRSfqzakJbs44uZopXjx0MyQOSkwGAuqj1PgJig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cZ6lR0GZ; arc=fail smtp.client-ip=52.101.84.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBSUfiZ/0ZrfGwN4gHrMS+D9aiTOna6JJJuEDQiV/lpNRiBw15h8t/nRYhbBzRVLkZ7t1dEWMYjTE2J3l0P5oDw32dBAWs0ot4w0aedmAIPvScahAoM4K0aqfpRkJiUUNm8pHyOyOgtqjNJXn+m0nOYKPMKBfp6YwysnIrwEQZlBok6hEdkkDfWdkJo4Lwhd5e+7eFwHI7vEOnIwrExtWd2+1jc+cS0Y4KblhAKPL/MYcvkb5wCVpDD1yQABe0ZpVqo0telAc4trtrpFeFVkVbkgNfi45Q8QgqXNQjYdhhANmCOB/hiZjMaCyJ5KbMdu2Qy0U9uryWJ2+PkYCNoBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmTOKdY6iRpHFjUBQpZZ8kGwnKkBbWpp+Fn5tL6kQyQ=;
 b=ig0QEAlSAFjGkxPq0ThWXTARnEzJ4uRmmh9EtdQaikHg2YQij3NQDeZZ0B3d0Nwr1XLc3EnapIHMoLaF6P3EvzUQjn2sglzQ7pdbZjICfzbJFariKfQMcqvp4x98HCvRgSW8Hjmqiw3Ng4UtonbR2LKjghRmf4vFt2burcABiGMfiiFJnCbuZkOPGEK2jfr5NZhfxbBYUR8m+hDK5RfbjqAyNq56KXk9H6hKYlG/HxLIb/+O4Ax7mMH1DHXDWznS0heG61GWsN1lmey4slXKJ/DKx8uGuJYPaIbZHVPlkyTic6oPd8lMVqmrhHFNo9G1KaHN8kDV2IusaJq84NKdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmTOKdY6iRpHFjUBQpZZ8kGwnKkBbWpp+Fn5tL6kQyQ=;
 b=cZ6lR0GZWXvhs3YLNAZ7Np+4t3aHMZ5fPTsjhe5r1wZEL+qKDMTzTUfRYpQjgpLvTazafp/dlEM+5VszKHHCkX9HjLSHObuajUXqjWMAm/k1pyVLq/c7nqPDEbHBaxfNxGLxM6n1jN3xEkGi4LR29zTxb6klvtZP8dnJvTKNHAkwFGQGXPUq+CzL4NqWgDemRbPdFjYV8hw8cpyR8k/qnlkVPAsvhL5ho2XiXRSrb7HitlEdkvZY5HfRB3yQeVGN5J/FFzpV5kfjez6F2tnmr98ThiYFFIWCSDcPjp83a+CZmaS3axlP/I19tTl2wN7qwi6LmwL1ZbbMIkLkXIra6Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 05:29:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 05:29:10 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Aziz Sellami <aziz.sellami@nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 0/3] net: enetc: add port MDIO support for
 both i.MX94 and i.MX95
Thread-Topic: [PATCH v2 net-next 0/3] net: enetc: add port MDIO support for
 both i.MX94 and i.MX95
Thread-Index: AQHcThB8B/EmTKsCu0Wd8Fe2HUqMMrTs2uCAgAAVb+A=
Date: Tue, 11 Nov 2025 05:29:10 +0000
Message-ID:
 <PAXPR04MB85106ADEC082E1E8C36DA65188CFA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251105043344.677592-1-wei.fang@nxp.com>
 <4ef9d041-2572-4a8d-9eb8-ddc2c05be102@lunn.ch>
In-Reply-To: <4ef9d041-2572-4a8d-9eb8-ddc2c05be102@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|MRWPR04MB12069:EE_
x-ms-office365-filtering-correlation-id: e5c74cd6-121d-4309-9ad6-08de20e33e2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GMgwH0RRpaX8EpaFvSG+Q3vGsn53BVEnr8pNXlapglsRktWNU7qKYugIh3/4?=
 =?us-ascii?Q?IzsKcBkrVpYthS6C3RNTniacd7mrCxtJ62uEIVKPehaImqm3/i14bRbDu/kc?=
 =?us-ascii?Q?dTDKpmrQHwvHPKS5FqJFfTRlu0LqFfmewrCWZm7MrzdfIDoYbjjfAMfuOgrI?=
 =?us-ascii?Q?jJppllB75HBwa/dgzFaaXc2u0HOX4x/r71CEf0L3B20UEh8OakFOVa9HkhmX?=
 =?us-ascii?Q?umUo+z1EYxGYxJ7JX8+7rZb/z7tRZTaP3FW+5liRVMJxRcb55nVvvWMGIJaA?=
 =?us-ascii?Q?1HGEhDaFQ1JzHoCmi6JztqSIoomXRkDm3XkmRELJFI8+XMIVupcH8z7eojkW?=
 =?us-ascii?Q?B0/GEhFnn04NYaV5JcHYx85bokPlfVB3hptGEIDh0pVn+SadobBi9W/hoa9b?=
 =?us-ascii?Q?qrp3F3bL9aGwNUP1SVRNFNfmqaG0eV7S+wAtV3YXOLnaQsqACfnbRCNP7aIc?=
 =?us-ascii?Q?XFDxFWCD5825CaiymPuRBzi4p3iWT2Y3BbOjQRliC5M1To+H0PCzrZHG8fD7?=
 =?us-ascii?Q?BHA7j3plWIGsAZk8oiC6eC/8l0Vh3p87QR04rlp8y5+TP1THM6vmlAZh/qZY?=
 =?us-ascii?Q?ZsYzAPTawQGFlG+kT9tgklGYdKR40/PTa2qBzjVk9EiQuYrnOPkfQGvf7HwH?=
 =?us-ascii?Q?ENN3Xtp+X/4jX7GquSmJ6lMsjpOTe735AMAAKD0g+utblbGQ/KslBc24V7D5?=
 =?us-ascii?Q?zN7UUEs/8saunFn4G0S9yD2d4mEedu2VrCj+/Qe73juFlGLOVDH+nBUD5OHJ?=
 =?us-ascii?Q?qYFvPknrg5cPQ4fO4lCw8dpkAVmsFBVNcGYWtNQbsoYYtes22at9473KRLu6?=
 =?us-ascii?Q?gZ6XKt6bV0WcBNMKHydwYvvSOC81y8VRb8xejGU/yiNxmx8O6X3NL0SRCpbs?=
 =?us-ascii?Q?ZO6pUGNxFAKKFM+l/ugf9MN0vm6R5O+caSHP3ilzfLMuhiNfhPXdPtSi/kDh?=
 =?us-ascii?Q?NlTrOx9VZxuTGkpYMVbnlHjH6hVQM9YzMsECQmXmwiU8EogK2h0dPwSdm+nM?=
 =?us-ascii?Q?LZFtcu8vjDnZX0w2c6ALExQ3Jl4jmvKBxIpdBwcdIziS9WcN4hEQBA415a3y?=
 =?us-ascii?Q?9xM/pjJlQmK4Bh1jN16XOo5l6AUp6QG4Jyj0C7xA0EInu+bPKO33Mafblf+H?=
 =?us-ascii?Q?jV4I41PFYFCsF6Pa8/oCRjNVahmUX/DgSUJMfVlFLJ5nFBvDOQQbU2QCIE+V?=
 =?us-ascii?Q?ngfQWYQdIR9X2HvDnPR82ZPXScNqUFiYjvL6JU+GkUIpTNEzlRdwdD/q5wZm?=
 =?us-ascii?Q?FYM1wF7RcSV1v2dCmEKVTaAvTfSlaBm6cqLJgMBedyVwRrw/flD0G6X8okZR?=
 =?us-ascii?Q?ZZfqQyNYumZpwEK6PwS1zgaWMhqpwdtAs7Eih0B/2oCf5GjPJEv8LhAhLTeH?=
 =?us-ascii?Q?y/b3yUYGNBnsXVvEqSXy3CVBI6tH/MLeqLjTn3XlUA4jBlXx+nPQcNY4guuV?=
 =?us-ascii?Q?0J1BBevgQqupt7SuyCsybXLqPWNsMBTAxa3YmVW5rrsSn9dsG8CpUQrY1j4f?=
 =?us-ascii?Q?kn5dtcOTzEx7MAEEyH3qsal5Dr/OED++jk0y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?omjVWsUWZ4VQTCCldLRo+v6F7iEPOKhbuI8E4CCaU99eAigR6kTKLiUok1Af?=
 =?us-ascii?Q?kL+8o3yZ3n0Krnid0evT+sVuDQOA5L4DwKkSo+30o7uWS5P9jvghTixYVERB?=
 =?us-ascii?Q?asmxIQ94jHcSKfTZds2Lc/mtzjbmV1+b4Rm/yaOiUmFEyZJE1O4Cj5jTx19x?=
 =?us-ascii?Q?I1motEBWnOG8hbXOh0DQcllnjQ/+aGivld5kUSuEImj5FSBye/A5tlHbzRDd?=
 =?us-ascii?Q?qv40ash0W+MtIyD5ZKt/Lq7SNGqod54HhpuSzBBhapkdVJ3viNnKUXZfWYl7?=
 =?us-ascii?Q?PNgkYC+nMD6CYrZLHQC/0mSfBLuHgbq9Gv5LOK2Uj2NYwAQYOQZWgl3BGQQJ?=
 =?us-ascii?Q?eIVmLs5ELmA/jzY1gjdBRikLbKT8UednSJ3d5CLhLq7nJaMhef369hRqAj0G?=
 =?us-ascii?Q?SSZd8dSVsJjtKM+31QWvfMJr3hPTzTAQldj8kWwCXjiAH6n2TpAwTwAT0noF?=
 =?us-ascii?Q?w7JGIrZyDZ+CR1d5BvvvPqmZ+GDRl1r4ltMEM8BMe2vjUDp/M8JOJxqzYcl0?=
 =?us-ascii?Q?4VEK36FAAoXzCqGx2iADQkDrU8OO2eUZ6VyH2aNMcc3+/ppxowvaz59uJMFQ?=
 =?us-ascii?Q?/sZ+LMBDi4as+ZuwSVVC43U9SVY+P/NdzAxru4XlQcwpLp0aHUY6pEcOZcNh?=
 =?us-ascii?Q?5U6NYKRbswqN9s0bMawfCA8dHCEp4+Zteeto7eDlrYF2OHpnnqdddxUmame/?=
 =?us-ascii?Q?BOFiF05mEPRqWbd8m4h9+tNOuf5Sn9WUo+GhU9TDBaJoQN8GWcvvnHvpr+Ay?=
 =?us-ascii?Q?TyYjVsa7vnxcm9B2ziekP7Nk2bvjTv57wQqllG3JZ6d6HSfPTrAizq3rCdnv?=
 =?us-ascii?Q?0LCFePL5SMwRyz+ImFoGu5/S4Tf7zwq1T9AtUnn0Wfw7MwkNGW/lF9ONGPks?=
 =?us-ascii?Q?JMlrmW3G8H5wZcRi+Ebw4ZLrTNizTCCIGofKr6MUeL7j/esFWLlvsCc8bGc3?=
 =?us-ascii?Q?3r14shNilJwSSQ9sP+D9riqvBga06Y3U7zLGrctKXR0eZH9PYngu0hnSE1ro?=
 =?us-ascii?Q?xNkonYl5dmPQIVcPsgk13CPuNlahbC2Xy8gr7x2hK8tqOM6S4fn7TxS+abEj?=
 =?us-ascii?Q?PHEwfzmH/M3Xp16dLXxFYVSIgsk+Ncf6U+8q+76P9VpV/kPTrzpo2I05DlF9?=
 =?us-ascii?Q?UBuTifi0Sj/vtJu0uPizhIkSNx8UW4zI2Wms2c5ic0tVwQ5BzA4rISYrruqx?=
 =?us-ascii?Q?dbk243Lk7NWLBXPBR8GhZbO7NwKS+IUBRzIiyHQRv6KfYEpAeP07G/2kx1vd?=
 =?us-ascii?Q?wWFpETTh4KKjKdqqvZxx73sZ2+bPmkoZKPh/pvw4M9lAx6H6YASuzbMlf+gE?=
 =?us-ascii?Q?lKiQqyddG0lErjlOmDNPXWMTWcRx7fXwdiUBZxY2QnFwAtALEpbqtvIKgCr3?=
 =?us-ascii?Q?t4K7EX8Eqx5+sAelohP9OYF8NwJ6JBoXRIO70g9L00pipC19FcBTOn55EgOF?=
 =?us-ascii?Q?K+/Gj93HBehbjjs4K7YJrzEm7lLZQTdFDUXuEuVwnXq4P6xFRl2ceGtonT5q?=
 =?us-ascii?Q?SULtBna1qVP4IELxlzm2aKUOyhlwlTIIWou8+nAgHvMOXzc8hpuiAvo9IN7t?=
 =?us-ascii?Q?0Ed7jUi2Pw+/XOFOrbQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c74cd6-121d-4309-9ad6-08de20e33e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 05:29:10.5462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dm18Eshjo/Afn4wyW6dvCIa14sUcmgLgR25HAKD2bFtmR4yvZdRYA8R2xz2uwFhwBcAp9P3GJkpkVOpYWrhRmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12069

> On Wed, Nov 05, 2025 at 12:33:41PM +0800, Wei Fang wrote:
> > >From the hardware perspective, NETC IP has only one external master MD=
IO
> > interface (eMDIO) for managing external PHYs. The EMDIO function and th=
e
> > ENETC port MDIO are all virtual ports of the eMDIO.
> >
> > The difference is that EMDIO function is a 'global port', it can access
> > all the PHYs on the eMDIO, so it provides a means for different softwar=
e
> > modules to share a single set of MDIO signals to access their PHYs.
> >
> > But for ENETC port MDIO, each ENETC can access its set of registers to
> > initiate accesses on the MDIO and the eMDIO arbitrates between them,
> > completing one access before proceeding with the next. It is required
> > that each ENETC port MDIO has exclusive access and control of its PHY.
> > Therefore, we need to set the external PHY address for ENETCs, so that
> > its port MDIO can only access its own PHY. If the PHY address accessed
> > by the port MDIO is different from the preset PHY address, the MDIO
> > access will be invalid.
> >
> > Normally, all ENETCs use the interfaces provided by the EMDIO function
> > to access their PHYs, provided that the ENETC and EMDIO are on the same
> > OS. If an ENETC is assigned to a guest OS, it will not be able to use
> > the interfaces provided by the EMDIO function, so it must uses its port
> > MDIO to access and manage its PHY.
>=20
> I think i'm slowly starting to understand this. But i'm still missing
> some parts.
>=20
> What prevents a guest OS from setting the wrong value in its ENETC
> port MDIO and then accessing any PHY on the physical bus?
>=20

There is an Integrated Endpoint Register Block (IERB) module inside the
NETC, it is used to set some pre-initialization for ENETC, switch and other
functions. And this module is controlled by the host OS. In IERB, each
ENETC has a corresponding LaBCR register, where
LaBCR[MDIO_PHYAD_PRTAD] represents the address of the external PHY
of that ENETC. If the PHY address accessed by the ENETC using port MDIO
does not match LaBCR[MDIO_PHYAD_PRTAD], the MDIO access is invalid.
Therefore, the Guest OS cannot access the PHY of other ENETCs using
port MDIO.

What patch 1 and patch 2 do is configure LaBCR[MDIO_PHYAD_PRTAD] for
each ENETC.

> I assume there is a hypervisor doing this enforcement? But if there is
> a hypervisor doing this enforcement, why does the ENETC port MDIO need
> programming? The hypervisor will block it from accessing anything it
> should not be able to access. A normal MDIO bus scan will find just
> the devices it is allowed to access.
>=20
> I also think the architecture is wrong. Why is the MAC driver messing
> around with the ENETC Port MDIO hardware? I assume the ENETC port MDIO

The MAC driver (enetc) only simply changes the base address of its port
MDIO registers, see patch 3:

mdio_priv->mdio_base =3D ENETC4_EMDIO_BASE;

Patch 1 and patch 2 are not changes to the MAC driver, but rather to
the netc-blk-ctrl driver, which manages the IERB module. We need to
program the address of each ENETC's external PHY into this
hypervisor-like module.

> bus driver knows it is a ENETC port MDIO device it is driving? It
> should be the one looking at the device tree description of its bus,
> checking it has one and only one device described on the bus, and
> programming itself with the device the hypervisor will let through.
> Not that i think this is actually necessary, let the hypervisor
> enforce it...
>=20
> 	Andrew

