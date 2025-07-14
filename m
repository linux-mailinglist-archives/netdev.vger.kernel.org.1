Return-Path: <netdev+bounces-206494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C22B03480
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E44718990F8
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 02:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4D71D54EE;
	Mon, 14 Jul 2025 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n3y+48IE"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB213B7AE;
	Mon, 14 Jul 2025 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460406; cv=fail; b=NPwO6PyMemA31RHAaXBbruQZxZIkxYpkmlKW91Z8M4d50VKhvVlrrMEhG+XBNGPvrBpNFp0zDL8Xhzmxa7yGpwZWVFw3RR1WwVTUfUKeWM37Lqn1RZiqGYMc+vE7Fa+sIoPbRpB2pnxlBzzJYk9a/VnCtUbQCcu1DVV1vncB7JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460406; c=relaxed/simple;
	bh=HwyYGLGKMSRTvfwlH9NR95z0IRG8imweL6YFRtWLZ4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lWTCcx6ukBccCB55xIfuwRUAMgIr9/Zl5uw7DMqcnPyL17uNiJhKPcacUMHyF3JjbrIPrTG1fSvUU3h8+YWfLrYnZjE8l+nZjy38Dlp+uamuw3AV0Sqo+5fr+qzMFtS/wBl4vFF6dO0j4C6paXVfKAWMJs3nbihlRH9770qjNu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n3y+48IE; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRGXCN9FHb8UBHKHvUnEWXpkEgiqv0AuVVG7PmxTqqhPney56nqEHin202u/yZpr+9eaU5bf+I16QAs8HEtwpwoEFyGeyZXQFLwVACEXuonfLsvnmBfjBWcid1EHt1SYgDjIX2vwJ8f/KlSg7wcLadwxd3NFpRwj/sXXa7z72OF8Ydn6PcLJKtjI3Tkf7j0C/57tzX8hHE5+20y27UmtUJAp8ohp1T3quaiX0ZiiaeBRXPiJkXWUSYbw2XAFKAKx1nkLd8yUBxu66eEGWOaRCqrAuHpXJh2BxTx0xV42nIO+YeAsA0rpPEg8CU3uWDrPlnUbqrF56/D9Yt4AfOT47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcKtFR0VlOWbPYVAmVEbWAAelEq2fXn3b1k7kf9Pc8Q=;
 b=xFnXMYPCpEaz88gl0khkR75WR6sX7jGbZVU01xPDYijCHUbBb44q6IRjdfYQX+qwhOyd6h6lIC7U1VzTjs5g1XFOxJN1V621wpzHs0glEan57AT0Fv7CjytXfR4t53HraxgUQykNUM/TxyAw2M3EJdarB9pdmU+Iqtkw+pU4Z71VqS9N51dlpxpZyU45hHMMP5FLv9WSfPq0qnkHNFFm5exflBOhgLiq/NO2UBMmdARhFFpkDqIwfWfJG+JwfKUvZ4aQxr0Bp20nKm7QRmqRx8gTGiA7GkhzrHIriz15HfjFE9k2fs1T3ad9CPqQC31jm3HU/SsH88PXS9InP+3K+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcKtFR0VlOWbPYVAmVEbWAAelEq2fXn3b1k7kf9Pc8Q=;
 b=n3y+48IEra8bzMzRSd8KqXTodYm8x0iGlNWM+BhncTdj44+krj/h31Y1ySWYETBUfV0cfTktDObynpx2wBcbf+rHWG8YrwrAkU65wGyfQdTL/sfJniO9KF+hLc/oaYz3t6EfpTZv8H/UwQ8VZgMeE68Ms337GP32EtNoyGm6ukvEuabYm5x/pnfNJHn/HrlC7L+XoGhbdNfR+o15mumq03vD2W+7GUFLvcGg5k7MrrMCzX5dwBrkXFhXw/qJenNNn6dEEwDucpPq5poKlliXZFZIdWnjtHHXSaY/QGHEvg7X8n9erzHvedSZ0qfkp1MPXw634zfCTR34U/DVfBkLGg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7633.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 02:33:22 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 02:33:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "F.S. Peng"
	<fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next 06/12] ptp: netc: add debugfs support to loop
 back pulse signal
Thread-Topic: [PATCH net-next 06/12] ptp: netc: add debugfs support to loop
 back pulse signal
Thread-Index: AQHb8jPmgdLLfL1nT0akuzvUbcxyr7Qs7FSAgAP+eYA=
Date: Mon, 14 Jul 2025 02:33:21 +0000
Message-ID:
 <PAXPR04MB8510CEA485EAE319AD743C728854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-7-wei.fang@nxp.com>
 <083ef067-b628-4dc9-a3e5-ccbb37de3976@lunn.ch>
In-Reply-To: <083ef067-b628-4dc9-a3e5-ccbb37de3976@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB7633:EE_
x-ms-office365-filtering-correlation-id: 230b770e-34ba-4fb3-d6d3-08ddc27ecd16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?COgOtRQBa8+vI3fVh0rhzs9Kt9PFd3/7fb2vc7sYfNCTr71BnB1HaI95Ljs/?=
 =?us-ascii?Q?+6k5En/TTQulq3QK9MZeFEf1LD4WUK5JwAqoYkycngoC4VVMbsj5aXxQkgKi?=
 =?us-ascii?Q?untL6v88UhBAs2Qk+IjHeLU9R7Pl2C95TTdF//lws0zWRZkufLmqaVw59bov?=
 =?us-ascii?Q?8NEJrCt9SQeIypLa94QIPVrvbw/esgHK5oUj6Lfc4h8qQy/G9WIVzsIKZV2l?=
 =?us-ascii?Q?TWk3CAsNSthaysuqaDIGVH62coZN/1kp8bO6HHR4PF3cpes68MdXjrBTEFFT?=
 =?us-ascii?Q?0BjE1jMpxeuWNUx9G1EU0jvfgry88nYPzWEOU+nmQ2bh9RyeeJ8s6+GpK2e7?=
 =?us-ascii?Q?6C/g+of2GpeYjcuNV8DNznb+VYLk3HAbF4Mw1iL7/7s9HN5yCz2wUlqlVTb7?=
 =?us-ascii?Q?zdA7XkLP53UVy0T64SniJWkFCSFXJ/gRfQpxQR/YgKEffTx4erM2XqjBVJfn?=
 =?us-ascii?Q?qGVVPQTWr++tHdh7LMgI4PNMHO6s45TaezKQ8kbdtikjB+XiYrpD4jl/WcKf?=
 =?us-ascii?Q?QQWZOlLVZKIVjygWN6yc/P82Eh2yb1Cp1tlZX0xplkgmQzQ5IxCB2JWf9InF?=
 =?us-ascii?Q?NYlV3oT+qLNToTT9i2k9WHtB+XSVM+gu7UyeaJaY1qQBauTQOvY93px7Idhk?=
 =?us-ascii?Q?0RjhMrUClKfz/b/VcrhUJYS0/luzSTbI0p13BrZeVCII/kE2Zeah+zij4UTC?=
 =?us-ascii?Q?f4gz5eYCJsR9j5FRA8VAyFgDyywnAI8kv2yhnc7lpuNa7EvwXBCnWx7hvgXJ?=
 =?us-ascii?Q?Sp+X08qlj0L6tABONT+VT2PPJ+H9lM8tWLWHvCUxTB5hJdsxUvN79st1Rm79?=
 =?us-ascii?Q?a6wzesKc4YFChepaPYRqB1rsJZ+Eh3hXoH91Y25fVlXBrQh9BMTsJR42zNGf?=
 =?us-ascii?Q?bMRBWKjHRvGe7OyyoNtbOnvejbtP9YbZ1L9rFsHbmzrRoiiNlUDN5xCAcLWR?=
 =?us-ascii?Q?1FY2U9iGvG0tmfr0YyrJJ2GxqEFmtwFZKBFwuUbissQux7hQg2o67qN266T0?=
 =?us-ascii?Q?ol2XNaquKYI3Bx1EezDeAaeknWoPYu98efU3SLR89QmHNZzY95JbvvDYfBHZ?=
 =?us-ascii?Q?qm2085NbWwbST1OCgxDpTcgMrxUGK/aQjwKg54a96vHe66P6vC3NIFjx/wPa?=
 =?us-ascii?Q?U+KEFJbCYhVPL4o9bzygK85vK/UylIKNro3Mdb6qL/M5uaQNlPBvaMEAPWo/?=
 =?us-ascii?Q?KjHr4QF7hkvmpmM7UB/RyPAjM74gkr76I0IV5/5u5to4bDFP0CsYQy5gD9ck?=
 =?us-ascii?Q?gdw7C5LE3+CRCWrgakQBVIl6FDwoTuPGHv6CEAy68gdVprIC6ac26X4uH3NI?=
 =?us-ascii?Q?v3O15yI8/kz2M7ClUWzebbo7MZFfiroFR+1x/+7pL71LLw418OWSfpPDw9Iv?=
 =?us-ascii?Q?Rq78tzTShrIj7SJe0uZ+MXG7ORZu81A4olLIZp7hFVSyZdtdhd872sfmcQ4T?=
 =?us-ascii?Q?2lKkzIBBC1oJ4TGNfGzjA0irDv0+R63GTN3BuiFTltMQhJNDMDNyZA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ppueyYc79N1Ne9UoXDBuCIw1hTQRMpVFNt5QOXafvCeBemQdv3QHrEj9TskD?=
 =?us-ascii?Q?4CKpIHKW12Oekhs1HZOXG6iBWN2vzPIgy7ZZmRAHqXOZKxlya/eaVa5K/u7p?=
 =?us-ascii?Q?nTTIm9gXp4AZTidXE/mfyH1A3yG/sbAfK7PEAPa+fl4gaLYNMSzOUIr/E47n?=
 =?us-ascii?Q?ckpknxYWFKn5iR3PO0WKbX7KKJT6UAJlLsM9tAHg6bTHpr5OYqdsmN3vQLlt?=
 =?us-ascii?Q?5himeRCUsXnLiZxbFZlMKpYqcqCReMoiCG5eMTodtwYCZL8RhfrBTAOSOIdV?=
 =?us-ascii?Q?Z0MG9BlaF16qzQ2DS3FCa2Faq/POo4wBBxuO3UrAP254POoZbh1UgL0YYcl+?=
 =?us-ascii?Q?KMNWh645YMsbL91iJ0h5woebbyNAqX3I2rlk/Pts9p8VDEzAIVMNuJkh1G1D?=
 =?us-ascii?Q?OThphTUX93iBTEYNDnZ3/31vfn44Pi+88y4x3Wr+cPBiqyDLl/ssP867NJLi?=
 =?us-ascii?Q?AccKW1mBaevqH4bsHNkE0HAm6PQHW6M90vzP6Gx2L1D4jqaeUW1zrHOEtDfD?=
 =?us-ascii?Q?nyIy7UPLhaCahOFkrvwfieSx8B8qVvRFXVazO+3Uue65+ljHrJU8Jcv5D+VI?=
 =?us-ascii?Q?AkxVRHYtCAC8SNdrqY9RxPr2vAy4pxQTwpaFNF7QN09cYLgt1yCqJbIz2hSG?=
 =?us-ascii?Q?3AvD6+LkBRpKRrX5Qte9B0qi9RU7FuxZF9o+A7hpcMj9W/7yXVbuCMkaOB5s?=
 =?us-ascii?Q?HvyOStdBasHH6n2WUD4I0k7NcSxZubyMfjoeBqt14t/6KNJH4zqcyve9XUbk?=
 =?us-ascii?Q?QM7KSoNIIMmvsPmwoeLx4Xduh83NJ4gPJ4k0jJo+sqvi0TNvUNITPfE0KVwR?=
 =?us-ascii?Q?CnFRRpfaZ+Tkvrs4CA5shByemkF6kvBzoVrVPEJY6rgi77sLGdtdJj+ez1eU?=
 =?us-ascii?Q?HswE3j2VCH9rvSgY5I0GaqTZaFH47Ip+78qoHRrkROVdywX7kyl5Vo3X1jvi?=
 =?us-ascii?Q?xlZ7cgqSEUUaXWptEN/90nqkPc/nYNzzo6GW3GRbWM1tHBjKEwGSEQVRQLds?=
 =?us-ascii?Q?OT2Vc4ialExo0GIN30VnNb7fdXk1etk4nKcxWg6/+942qYng5pFAboEeKha2?=
 =?us-ascii?Q?TKPMX2eRGXYkEJ62zETdoe+uD4o00JCY8vQBszLZZjRjXlW/npKivmdFwkGx?=
 =?us-ascii?Q?TtyQg4Z2euDCsYYK1dw+15MVGa0who7Cx11zrp35g/OTZ2QhouQPgbdUWuWY?=
 =?us-ascii?Q?3yvTSm13ZNfrWVX0uCX9ppJd8NkDaACI+qVyX1ZJ4Mexfiw05aAM7DEvL/3g?=
 =?us-ascii?Q?8l+r+EsC2qSwsujF9pt6a1qIovWNIF5W+7M2I+38L3ijF4CDUoOVnFbHlCQ/?=
 =?us-ascii?Q?sjkzxGGFsbJLFEvk1oZ9LoSoYYPynun1QXfMUHzAQVJNB6CGmJxz0kOtNBPw?=
 =?us-ascii?Q?QECDAc4S4s3JNOFwMiWTNeJJUljX64hFCn76Nsc5mu7LcHvU/epaEvLGv7F7?=
 =?us-ascii?Q?9KSlzyPsxkGSzavse67/VqI4xUQVUZ5WQAEwOi2KZS6dvqJkUeGkwzdsRB1k?=
 =?us-ascii?Q?ynWipn8L0Oe3+b0P2mqET6+CqWimt8ayN1Hqev/nFRPU9g6U3FVITyfSF7fk?=
 =?us-ascii?Q?luR/OmZ8VsTQLzOjJ14=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 230b770e-34ba-4fb3-d6d3-08ddc27ecd16
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 02:33:21.8778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZDjUeMhHsB8Dtmtg5InsrBr4c2HpDSnxdjBfFWrEPhlZmkDLG8NNC+ZwV8QgmjToM2Sci+xqCt0Q4aemU+UPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7633

> > +static void netc_timer_create_debugfs(struct netc_timer *priv)
> > +{
> > +	char debugfs_name[24];
> > +	struct dentry *root;
> > +
> > +	snprintf(debugfs_name, sizeof(debugfs_name), "netc_timer%d",
> > +		 priv->phc_index);
> > +	root =3D debugfs_create_dir(debugfs_name, NULL);
> > +	if (IS_ERR(root))
> > +		return;
>=20
> You should never check the return values from a debugfs_
> calls. debugfs is full optional, and the driver should work without
> it. debugfs will also happily accept a NULL or error code as a
> parameter. So even if debugfs_create_dir() fails, keep going,
> debugfs_create_file() won't explode.
>=20
You are right, I will remove the check, thanks


