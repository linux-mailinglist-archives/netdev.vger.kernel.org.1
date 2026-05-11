Return-Path: <netdev+bounces-286477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wImvLjGDAWoFcAEAu9opvQ
	(envelope-from <netdev+bounces-286477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:20:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A8650906C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74EFC3023A5B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B7D377EA2;
	Mon, 11 May 2026 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TVYAyd9g"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4019374E6D;
	Mon, 11 May 2026 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483840; cv=fail; b=QOOjVtGQWt6ottHyMtxRrtZwXIsLWzE0YMLe+7B2ORzutJleRG3FosW70UBks9P2cyEeyCSPjerHjVs56uD1vDIb1H8x/X3U5Y6o07EB/5tqSzl6MKP9ZMSA5WAr7763bTDvNbkS/tJ9hU2EQaa7LPT7g54QuMD1P3r7qNTEiBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483840; c=relaxed/simple;
	bh=HR4SoSWWK7/pVFDq3BAtnNaWbeD9av/0GFD99p6U3as=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jN+8irToIdnVWRGqc+7GigXR3vOvlQuvMkVcQEc0ZUtlUwFu31Seasc8d+0rM1hmyBBGS8vtOkgaHumdwGwFi5Yl1BYMlpQGlb6t13+I6rrAfPeZoMKEebyZ8y4QcakFcv4o+CRoW8Zmovs+FxLfSu8gwuYpFvBOnFk0fpKi2AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TVYAyd9g; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyVfVZvuHsnyX9xhgCIG9NPPkpoY1ldx2nTgat+OYrgFglxn6eeavP2rkrCFSA+Eg2ZXRmcYfULJY/9V66AVdugk3T7QEQDVE6dOK1czFU74AJm73hv78xTlNCzVLcsTlohnkQcWKIPkryOJSYFxrIPtv1+rqRD5gHCmTT6VsiXsUDzqnMrJNDOq6gvD5SOe7dGvQspiRwU29vOyve0kEkuGdBMnDk/yJwjPUqvBhU0rz5BgZ08h3qchxQaBl3BwVg9n6Sqc+BtE/7ULtU5k/OQO5PPelU2Ea8+UKkanQKYBfkCuiDWcI/kGVXp/I5DozpdHh7XRPrL7v+izR9WLuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRS5TmrEKg7RXytcTXcpaOCY2vFS2mVxZ12suOM8L/w=;
 b=k/Qn7glTF+rIO2hWMdjw/+slAlGTNTuxs5vTyt/T9mrCX1MyGvrU25Di+1qZLza2QJZVNd1XC4LTCjsTB3HjMe/r7Ainl0avIqSKHYHfQPDSqNxbp6G9uxRq+n9qEbvQ7O82PlnCAuSsksZufdCqpUR0O27b+PBdnfFUT7VDHg6YaTSOKdfyRLmi8AcQpVOh4lTa+QJ3rERq0bdNJaDcpjwPDSkrNg5ND6BAn7qWZN3JXHHQSZo2Vvwi8N4PWhC/kR81hdp72i7MNZwt30bHgoRmfPUq+MIjwJfXQVqysPUVF5i9ACYwhN8PurKTnGc0YYMSljH/LPvvmkw0kxR7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRS5TmrEKg7RXytcTXcpaOCY2vFS2mVxZ12suOM8L/w=;
 b=TVYAyd9gC3/vh8oB6KX88SGfAq2dtXBmZSucH88hwC+PHT6cz1nyd6mvf4hRAXWSKrqP0KVjop6BSzRbSzvv/XnKDGqpdolIkSSGAryucghyRqaY4Z0AV3zOrzONAeIwd4SrMWDeRa4Q2+e9uVRJ0SVk06vU2Ny3idpeQ/6xKgCAbIyZ2CyAbSVXyRF3JiUarn+QJyfgcqt6QpzeXLYDDVCjqeIG1R1QXmH/AGuoGvuple/XUsx9XiLoimoo9oFyxdmlvb9MknmgsSd92cDBo2q0GaS13iuiLr2mHCV6pZrvQ3Qold1iaxQzRtU0gJjQGIenyjLo/5YF4rIL9A8iPw==
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by GV1PR04MB10893.eurprd04.prod.outlook.com (2603:10a6:150:209::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 07:17:14 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 07:17:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH v6 net-next 10/15] net: dsa: netc: introduce NXP NETC
 switch driver for i.MX94
Thread-Topic: [PATCH v6 net-next 10/15] net: dsa: netc: introduce NXP NETC
 switch driver for i.MX94
Thread-Index: AQHc356gdXpPrsGmkU2EqCuxvHl7wrYHFd0AgAE+JsA=
Date: Mon, 11 May 2026 07:17:14 +0000
Message-ID:
 <PA4PR04MB750282C2004F177F08BF602A88382@PA4PR04MB7502.eurprd04.prod.outlook.com>
References: <20260509102954.4116624-11-wei.fang@nxp.com>
 <20260510104836.BDD50C2BCB8@smtp.kernel.org>
In-Reply-To: <20260510104836.BDD50C2BCB8@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB7502:EE_|GV1PR04MB10893:EE_
x-ms-office365-filtering-correlation-id: 3ac4a773-f464-4049-a7c6-08deaf2d53b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 7DvbVGtLk5Yh6HY4gpCkhhfgg3M+njX4SxM9WA1o62VeZIHAeaDGqDPYyxqsfWPmsxIQb8iyQp16p/vA0NPglJdFesclGav11BpWhzJjY8gVizfxvYmYvPHszn73SbgZM601S5QepSzfd3/BJg0YkSWryxOlcqhcxOo3N1H8MMa0DPFG9xM6mtcPX4gaCA2zD1sO+rMlyIeBGkzL8aW58rYHucNZlcG635NqI+chiKN/WfumDKCJ7VA4A3xKsK5q6j7afeAdu6ySZ7005FqXb3mFaa/VPzNWGdGEB1397JR7biEAzVcuFC6K5+gSgTVdiBnmfv5BPbsAYlt+2KqYg//3fRKCtMAd2NUg2Gtr67ydt0WU37kNvi62N0EsI/uYoM747+DVzSKe8Ltj+jsOApdjYQkGxNn3FiXMtcDUcWVhx5sxMQnxp+8TgaDMiW0fKl+mvYdvoDl6MBN993rSpX24DavKZual+ehS73IeRmcwgabJuN3kMuB9rvLaB78CZbWwV8my6exPeRogyQZ8iG03MCe1DIg1y1ly36vIf2hHFkJmkRtmnkdDxyS/F6o3SVgW0GoStjyPHPJVzERh+Ycm/fIss9oFXyjEZ3Pokj8misFXGrRyc6PlSAFKFapCJ7Cbet/u+0bsdJ8ReBCDjsHU+a5cPpEtK8+ojg+ZwDt6SpdlrerJEVP6iKi67h6ctB1qU1rKObarvba19cEgzbIfg4fJQ0+P4LTp8wsOi9xx3oPGQ9zT9j21ZFf/Tn2H
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?koi8-r?Q?kUyjXHYXYSvhhQs1wEiXkSKUNjjAyMgjIrGKzIYNCUFjrTWjKlMKET5hDXuf3T?=
 =?koi8-r?Q?OusyUTIsv29KT+WhBOo1zgF2ECz815eP8z0sh1xILXQQD718CAL86iqiJJbxvM?=
 =?koi8-r?Q?do1+ulFhAsSWF0OHwMSXkS7mqDrPt5Xg/OAxo9pqaw2SY+8Jeh3bet57IdulU7?=
 =?koi8-r?Q?0vUawicQ1VF26ogkwN6Jo5GumWqCtVKZHrAdualcqrr2gfGNYi6icQ3OqzYShG?=
 =?koi8-r?Q?pq0uJZD/vBWpP7Fptpq1A0CYj/XyMotFumlnbL9dCzrq0kW6d82HrQqGNcZlrc?=
 =?koi8-r?Q?mwo4SewBPXBvM8juGbel8LnThSNjXJ4BhOw6K+rD4pyQPudGc/QP1k5HTDEPus?=
 =?koi8-r?Q?JZRhs0bfm8F7DeBqBDIqM9KDh7ca7u3ZUhoY06q0b0CE+5EtkAvV4Jjzr+M5D/?=
 =?koi8-r?Q?Ivct6mQ0NuOolzUZ2hjNAqDhuxfBpGvkavNvM137Zo+efWQz+RvGQGblzD9xo+?=
 =?koi8-r?Q?sMJIRJQXdrc6JlpIFUG0qaoLo0eyC/suiFDlV8X80nvyrIYjr8ojrcILsdkDQm?=
 =?koi8-r?Q?rz49gEmmfL797ZOZevBnMSrMi/oio4EgAoBQ46BL1R1ZoBPVliPOt+xnvSbzZ5?=
 =?koi8-r?Q?Y51RAxVHSeO299eaqRxSgMnmKaMXBhQ0XiZcALUY0r+/8t8jGzaJDegmyrBLN+?=
 =?koi8-r?Q?el/Ki42BjqWAv5u3Rde4wtPRra3mL6ux1ORWBVmvfNBWmTIWKG7sZ8KOYihY46?=
 =?koi8-r?Q?ooZRm5abYldkOb2n9geGC8YWfnzeBrsNE7GTyog9bVonEjrG8wc1M4izQT4iHk?=
 =?koi8-r?Q?S1GOeh3u0MAApL9mf3R7i3dGDfrpClzk3q9WF78dFk2EQKQM9tWJuQid6ORUX6?=
 =?koi8-r?Q?xXxOZd2IIYHRMeZEeoIQvde7T0swBdZ89WNlChMb6YF+xm0dB57VHMrMf4iC6L?=
 =?koi8-r?Q?L/USvmrrImqUjL/QcfhodTrRmGbeW6A9qbBveXUzvnzY44bAOMJa3A+MYeXza5?=
 =?koi8-r?Q?7E8mXueuR3nJPzdmXwHCTu/CjV4PgYt7TFHDPKvaXmA/yTPy5m1+s0Rf70YljR?=
 =?koi8-r?Q?fQuC8TGvnFuy1UcDsSqLawBNTwFHISzgPcAh+7+DY6J7pQpuCNgQvqeYfRndH/?=
 =?koi8-r?Q?YtwOhHvcS6heSJr4i4TeLhjo2Rda0OW6CDjj0Is9nEZmgtJ5n+6gXgNsJutxDt?=
 =?koi8-r?Q?XvUXMgy3+fZeHWvWSwOq73Qwv1Qv1Lz8UohMFI21A6LlnmNsAUznv6VYaPzrX6?=
 =?koi8-r?Q?0dCMkXv1AVjVSPbGQo/3N/omjwkyAqrnDU1ZpE5gi6Flw1hnoGuarBGMd10A3y?=
 =?koi8-r?Q?2nqfBi+ftgLzrnMSJiPEgRGldNvWFO0GL23nzFa8NsPcQgqsFNnKtgNd9m3gUL?=
 =?koi8-r?Q?U7Hj7v+NdOIXVB+glfoMV1u3iirGUyBZRaYxNmqRkYfm+jqgRDwINTTa/k5hWZ?=
 =?koi8-r?Q?24ZchDljLFmbp+L7gkGuVF03y0013aULlYEven/Xt9yxku85cKFPBwGKLg0206?=
 =?koi8-r?Q?ZDSlvS3Y6jC4j64DBQ8PeQjrPkIC257q4X+HAHEOeymSudOAaA4MlROjHN3IZ5?=
 =?koi8-r?Q?O95uoSoTAhuJkTocpegA2Jv24RJsxNFLRmz/NM2izdv0w+rNCj4oubg2gKXZ33?=
 =?koi8-r?Q?9wa1lIXp+xOOk2x/B4uEMQn23v1otVqmwms2K8hVmBk4/t4kO74bpLOn0D8BSH?=
 =?koi8-r?Q?EvI0Ks2LbXaRns225DxKHuVDldQWVl16qRpacgG+y+ftdTbua8mFkS?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac4a773-f464-4049-a7c6-08deaf2d53b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 07:17:14.5819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jlpj7JQaL0eALSBCp0Lp1PbVMY2pO1ieH6zcDUUSlQWn1zHq89l8nds8nrlEoMODQAgvDr9AjPksl7ViPBNrBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10893
X-Rspamd-Queue-Id: 59A8650906C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286477-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Action: no action

> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to
> consider:
> - [High] devres-managed functions are incorrectly used inside the DSA `.s=
etup`
> callback, leading to memory leaks and MDIO bus registration failures if t=
he DSA
> tree is unbound and rebound.
> - [High] The driver's PCI shutdown callback fails to stop hardware DMA ri=
ngs and
> leaves PCI bus mastering enabled.
> - [Low] Clearing the PCI driver data via pci_set_drvdata(pdev, NULL) in t=
he
> shutdown callback breaks potential subsequent unbind operations.
> --
>=20
> commit bee0164d1f3476eab41d58efbe3baf540bb03cda
> Author: Wei Fang <wei.fang@nxp.com>
>=20
> net: dsa: netc: introduce NXP NETC switch driver for i.MX94
>=20
> This commit introduces the initial NXP NETC Ethernet switch driver for
> the i.MX94 series. It provides basic probe and remove functionality, as
> well as port capabilities and basic network setup.
>=20
> > diff --git a/drivers/net/dsa/netc/netc_main.c
> b/drivers/net/dsa/netc/netc_main.c
> > index 0000000000000..8e3a3230226c3 100644
> > --- /dev/null
> > +++ b/drivers/net/dsa/netc/netc_main.c
>=20
> [ ... ]
>=20
> > +static int netc_port_create_emdio_bus(struct netc_port *np,
> > +				      struct device_node *node)
> > +{
> > +	struct netc_switch *priv =3D np->switch_priv;
> > +	struct enetc_mdio_priv *mdio_priv;
> > +	struct device *dev =3D priv->dev;
> > +	struct enetc_hw *hw;
> > +	struct mii_bus *bus;
> > +	int err;
> > +
> > +	hw =3D enetc_hw_alloc(dev, np->iobase);
> > +	if (IS_ERR(hw))
> > +		return dev_err_probe(dev, PTR_ERR(hw),
> > +				     "Failed to allocate enetc_hw\n");
> > +
> > +	bus =3D devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
>=20
> [ ... ]
>=20
> > +	err =3D devm_of_mdiobus_register(dev, bus, node);
>=20
> [ ... ]
>=20
> > +static int netc_init_all_ports(struct netc_switch *priv)
> > +{
> > +	struct device *dev =3D priv->dev;
> > +	struct netc_port *np;
> > +	struct dsa_port *dp;
> > +	int err;
> > +
> > +	priv->ports =3D devm_kcalloc(dev, priv->info->num_ports,
> > +				   sizeof(struct netc_port *),
> > +				   GFP_KERNEL);
>=20
> [ ... ]
>=20
> > +	for (int i =3D 0; i < priv->info->num_ports; i++) {
> > +		np =3D devm_kzalloc(dev, sizeof(*np), GFP_KERNEL);
>=20
> [ ... ]
>=20
> > +static int netc_init_all_cbdrs(struct netc_switch *priv)
> > +{
> > +	struct netc_switch_regs *regs =3D &priv->regs;
> > +	struct ntmp_user *ntmp =3D &priv->ntmp;
> > +	int i, err;
> > +
> > +	ntmp->cbdr_num =3D NETC_CBDR_NUM;
> > +	ntmp->dev =3D priv->dev;
> > +	ntmp->ring =3D devm_kcalloc(ntmp->dev, ntmp->cbdr_num,
> > +				  sizeof(struct netc_cbdr),
> > +				  GFP_KERNEL);
>=20
> [ ... ]
>=20
> > +static int netc_setup(struct dsa_switch *ds)
> > +{
> > +	struct netc_switch *priv =3D ds->priv;
> > +	struct dsa_port *dp;
> > +	int err;
> > +
> > +	err =3D netc_init_switch_id(priv);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D netc_init_all_ports(priv);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D netc_init_ntmp_user(priv);
>=20
> Can these devres-managed allocations and registrations cause issues when =
the
> DSA tree unbinds and rebounds?
>=20
> In the DSA subsystem, the .setup callback is invoked when the conduit
> interface becomes available. If the conduit interface is unbound and rebo=
und,
> the DSA tree goes through a teardown and setup cycle, meaning netc_setup(=
)
> can be called multiple times during the lifetime of the underlying PCI de=
vice.

This analysis is wrong, the switch driver will be removed if the conduit in=
terface
is unbound. A device link is created between the switch and the conduit int=
erface.
See dsa_conduit_setup():

if (!netif_is_lag_master(dev)) {
		consumer_link =3D device_link_add(ds->dev, dev->dev.parent,
						DL_FLAG_AUTOREMOVE_CONSUMER);
		if (!consumer_link)
			netdev_err(dev,
				   "Failed to create a device link to DSA switch %s\n",
				   dev_name(ds->dev));
}

For NETC switch it does not support LAG, so the consumer_link is created
when dsa_conduit_setup() is called. netc_setup() is called only once during
the lifetime of the switch device. The call stack is show below.
netc_switch_probe()
	=84=80=80dsa_register_switch()
		 =84=80=80 dsa_switch_probe()
			   =84=80=80 dsa_tree_setup()
				     =84=80=80 dsa_tree_setup_switches()
						   =84=80=80 dsa_switch_setup()

This is a false positive, please ignore it.

>=20
> Because netc_init_all_ports() and netc_init_ntmp_user() use devres functi=
ons
> (devm_kzalloc(), devm_kcalloc(), and devm_of_mdiobus_register()) tied to =
the
> PCI device, their resources will not be freed when .teardown is called. W=
hen
> the tree binds again, netc_setup() will execute anew, leaking the previou=
sly
> allocated memory. Also, devm_of_mdiobus_register() will attempt to regist=
er an
> MDIO bus with an ID that is already in use by the previous unfreed
> registration, potentially causing .setup to fail.
>=20
> Would it be better to either move these allocations to probe(), or manage=
 them
> without devm_ helpers and explicitly clean them up in .teardown()?
>=20
> [ ... ]
>=20
> > +static void netc_switch_shutdown(struct pci_dev *pdev)
> > +{
> > +	struct netc_switch *priv =3D pci_get_drvdata(pdev);
> > +
> > +	if (!priv)
> > +		return;
> > +
> > +	dsa_switch_shutdown(priv->ds);
>=20
> Does the hardware continue to perform DMA after this shutdown callback ru=
ns?
>=20
> The netc_switch_pci_init() function enables PCI bus mastering and sets up=
 a
> 64-bit DMA mask, and netc_init_all_cbdrs() initializes the Control BD rin=
gs.
> However, dsa_switch_shutdown() only closes the logical network ports with=
out
> invoking the DSA teardown callback, meaning the hardware BD rings are nev=
er
> disabled.
>=20
> Leaving the hardware rings active with bus mastering enabled during a sys=
tem
> reboot or a transition to a kexec/kdump kernel might allow the device to
> continue performing DMA into memory that may have been reassigned,
> potentially
> leading to silent memory corruption or IOMMU faults. Should the shutdown
> callback explicitly disable the rings or call pci_clear_master() here?

NETC switch is PCIe device, what I learned from pci_device_shutdown() is th=
at
it is unnecessary to call pci_clear_master() in netc_switch_shutdown().

See the comment from pci_device_shutdown():
    /*
	 * If this is a kexec reboot, turn off Bus Master bit on the
	 * device to tell it to not continue to do DMA. Don't touch
	 * devices in D3cold or unknown states.
	 * If it is not a kexec reboot, firmware will hit the PCI
	 * devices with big hammer and stop their DMA any way.
	 */

>=20
> > +	pci_set_drvdata(pdev, NULL);
>=20
> Could clearing the driver data here break subsequent unbind operations?
>=20
> If a user manually unbinds the driver via sysfs shortly after a shutdown
> event, netc_switch_remove() will read a NULL priv pointer and return earl=
y,

I believe this is a technically possible but meaningless edge case, and the=
re
is no need to make any changes to this meaningless situation.

> skipping dsa_unregister_switch() and leaking the DSA state. Is it necessa=
ry to
> clear the driver data in the shutdown path?
> > +}



