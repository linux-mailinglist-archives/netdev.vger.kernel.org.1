Return-Path: <netdev+bounces-169915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EE6A466FB
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82A4C7A9368
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22CD223711;
	Wed, 26 Feb 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QB0yDl3Y"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF3222587
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588419; cv=fail; b=oc4RheLv0kecLQ1Ua1Josu/kRLur3bYPejrA2uGEEuspFqChbd0cBAimzbJ8Z/JWpv0bX9AOfjk9fODcNCPT8Jguf7fz76FhWg6HzMz4RVGdeMD3qiHGrqqZZ3sQ3WlVDyJpyhXIb6ehpuL+UW5Dp7EqxiD0gk7kcP3cAVXeGiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588419; c=relaxed/simple;
	bh=vzXc8gQ2+zqhVt7mOAuPiTKMmDMGl/FT05WWEDKh6vw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=havj/aekBw+3oD+yMlWq88lKLg53k/MP/0XP2kVkwfjXOV1p54u9BJN4reNriMaL6mYLoggxvnjtRVC4M/EICeua/DPqRho9Nh8gqLX0j9hBMQU0m083QRU2Vm8G3Ic+qREbslQEU58ftEPCcB7To35gwioQLkHE5dV8lUQe4Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QB0yDl3Y; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0Hv5GB/zPtx+uiTPKmpauqpSZH7m1GYlipuQTkDgM/zGgbz8PJbKdj7FI0dwuQA6HRHy+D6Egq7C/YKFeq3usmbCM7u8sVtP4F5EdNU4FpVJ1dtRHGuaWRuRPjra4bLLhFEx+iXAy/jYhdPHQg41ySabayFU0PHPdMkl2dGuloKqPzbItLF8JdHNW2JdZJq5A9ne4hq7f+t6m2qHUBSSaqjV/10AAIQ9PWujN8tkPaPYn2sb60H90Ic/QQOUpYEOkI6v5L3Kci53bCOXnyp/t2TflAcRsuL0/q+TCZwzgwZ7LojMZ/9+qslFDDj92NqwswcuFMqCBlECsTYmokt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zALojGJ6/OEr47afuFHDZWnkuRbG5DKErBcj4RXHRWk=;
 b=YUZn5QAbp9sdq1NtPrXeEo9YEArQur2QGIoMKkYTn80TVJwoEDB+0IOt0CU4YG9bNpgOEpNOdO5ISmpSVXIs/umEIbcktFdXDpmWuA6+x597DHXdMV3IIsBaC9wfXKDKIybwVS8yQozRyxCvVWhLQd/RQBn2W1gxgQJNHe1K0HCAcu2oz4TvpzpwbobOLb56eeVXsXoCqzt89Sr0CdTLMRIh5GDchDzWbE1/F0rDUsILZnPQqS3AUBzTfxAGfN8w3zjVu9X+2Of7ztl/fQlCbR4cLo0yL7mp2NMpgVlJiDv/M71IzChbjhdgndjY1B4IZctonbVPRA6JgBROO9t3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zALojGJ6/OEr47afuFHDZWnkuRbG5DKErBcj4RXHRWk=;
 b=QB0yDl3YPFHtJkeD3/rnvf0uq3UuuAZGTTh+6TUPquooWJS4ZqE5KXP6+8506fWz4D6YUy/TBkNVBSIFRf0qBtW9bN8PnSZc2CqgGa+yA5+08ICYXls5LUAdY5S/WPVZr7LRsiEJxIRBVxcgRpRA8NSDAM83sRitimdTl1gnxTYqUoJ0sUMLtN2f6t0Q293YM3NoYF9Zc1xntXyUuaj05m12eWE33er6hQ6h0K8ztTPMGeR8nORKF3MXwcid94HoZN4rs4KWq1ADqX0bUsxUPYcrOZKuP45s8uQM8aL588ATnXLZ4ixST8lk8q4B/RpRL2O8t/iCbZVBXXhJWyXoGA==
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7)
 by AM7PR04MB6949.eurprd04.prod.outlook.com (2603:10a6:20b:102::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Wed, 26 Feb
 2025 16:46:54 +0000
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::4fa4:48:95fd:4fb0]) by AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::4fa4:48:95fd:4fb0%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 16:46:54 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH net-next] net: enetc: Support ethernet aliases in dts.
Thread-Topic: [PATCH net-next] net: enetc: Support ethernet aliases in dts.
Thread-Index: AQHbh86Qxhmr48lZHESm1vGKxIPiSLNZvAB5gAAFn9A=
Date: Wed, 26 Feb 2025 16:46:54 +0000
Message-ID:
 <AS8PR04MB91761FDBD0170D8773395E9289C22@AS8PR04MB9176.eurprd04.prod.outlook.com>
References: <20250225214458.658993-1-shenwei.wang@nxp.com>
 <20250225214458.658993-1-shenwei.wang@nxp.com>
 <20250226154753.soq575mvzquovufd@skbuf>
In-Reply-To: <20250226154753.soq575mvzquovufd@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB9176:EE_|AM7PR04MB6949:EE_
x-ms-office365-filtering-correlation-id: 1a71ad9f-2b7b-4889-e882-08dd56852cf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?40uCp/UE3Snp4lqV9Ne0Jlh8taq4X7Apn71rQ3UaR6/ruLdIL/wCWi5wZnrf?=
 =?us-ascii?Q?/nLkLxzJRUYqvwmVL1dhIC7b87KrKaLDx6lF5agF1kS/2Fr1Z52YN3kZywH8?=
 =?us-ascii?Q?Px56fZLM1yQWixEguwgl/wAd0ToAtMH4R1s44el2IqvihffmN+8w7aamo1FG?=
 =?us-ascii?Q?U4j0bIWHidkLXFbgBWmUongPEnLyeG8xC0nTQoou9JQT8DuGEWTxWrVMHa16?=
 =?us-ascii?Q?0ihCA+XdmB5DDNEQ/ZWhLwRqWT/2HL3XasmfcY3oRgDI3jEaWRoBn2BdWimB?=
 =?us-ascii?Q?i4V4QPwR/qn/JfXg59R9HlMlGU7ON9NEMKc2Q8YAOLhBI5K0WdWBqhUn0x2m?=
 =?us-ascii?Q?hbTB+RJB/wKF/Yvy4o/1nnmKtpG8Va/kQKguYuUJ3awmjhcau0C34z0R+Bud?=
 =?us-ascii?Q?MV0LFvBA3brYRhea035NL7aIq8GVC8ga2cUpJcvsU9vnzB05AJEaHOSO6BwT?=
 =?us-ascii?Q?ap3JLbav6zTwYOomwxhv67urV39EwM97ywRUV43mUZl3pl9iTrZoJzcnA2Ga?=
 =?us-ascii?Q?SDv6t+w78ahivs9799AVvsDK9u9+B8U6TMQnTohYiicUVQybch5EXvaubXXM?=
 =?us-ascii?Q?SFbMVfUE5uRsPKaq4z4elYc2N+Y+mT05Tah/y85j3wGn438oGvNUs/cwCJfT?=
 =?us-ascii?Q?WmdDHrdW8x2jZEHLl45ZuQArnWgn5xx7OSZYrQrQsxQetCdMT8jimNUZrJ9A?=
 =?us-ascii?Q?ryRLG4OuqL1uf4A7wzcCs3gp6MWq6mGrUOHOLeM9NR1z4qXsc2ljV+O4MZrX?=
 =?us-ascii?Q?xbUUgID573pm+ySqgHI5zQdF91TT4CGHXGR9hMC2skYAyuQMcq/d0L28Vq3n?=
 =?us-ascii?Q?LyBUQmBw9Ms78k4FGy71E+jzJi7/Q6riW87bKfpBeCxshHY1PReM53uznnq5?=
 =?us-ascii?Q?jmsrnVmtDVXiuNXMGyI3TDh6sjoXa/sLfrQXGGi6Klc3CftnVBavXNjKiyJ7?=
 =?us-ascii?Q?EYssO+lKl3NkxwT1xrk3hT3hT2EzietDEpO66CFUs/Vzeg1ExfaodjOiTy+v?=
 =?us-ascii?Q?SQ4z3oQDcGac1Jk0DdcFTVwcw3TXARYXUqert6THyPYuC1lufRDGlniNwMhL?=
 =?us-ascii?Q?nqidRDGkuwkUQclcTflora13iIoA32Rap0nWbQL7/uGjaGf7VRSgaGDvcLbD?=
 =?us-ascii?Q?ePkFu98XpUzBor/TYcMC6wBFff+j3aXclG0FS/e4+hRdWZhC8YtI4GLOTWAN?=
 =?us-ascii?Q?KPsNtKYfE3hxVjFh/dbntgTVtwra1NdGCMtrFAIAj7AaOnTtM8+lj9LU0WD4?=
 =?us-ascii?Q?b80Cyd55YHX251shF3OiAeaDVSq2DdiqorJpa+baohZbdxvYaV61D6mGXm63?=
 =?us-ascii?Q?wF7zWsJrpUqr6BvMC99E00bzBVvlpdqvch2dv364Gt9PfNeJDoq1smdzAg0Z?=
 =?us-ascii?Q?uQ37WiEhved8rfaLZevLUCr2nEgyhDkHO4tKM/vjZrixunfkbLrBVyShXPL+?=
 =?us-ascii?Q?9g5IS1hm+I5jhLfvJ8Rk2BPLB5Is7Xt+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9176.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vgE0oDVRCOXRWaF7h6ZCniquyux5dd1nDkfmRr8fk6RWl4dF5kShUXiOogOw?=
 =?us-ascii?Q?ac2yfzMxxO/vyaNWsSHiA8ssOTmJCPI+KfdotsL5aJpu+BqP2LQpeyU6mA0t?=
 =?us-ascii?Q?J+awFSQFC9y5Ai3eM/7+cSw9Qj1IQtnS9/N9Gc4p04YNpFIWKZAkWUjKe6GE?=
 =?us-ascii?Q?BCAir/zk/JW85GIyroWmFigM6otndQelcYERJoWJ/ZLxGw+TpD5+yBtTlLvt?=
 =?us-ascii?Q?M896FP9l3VFrWZ7azA5Ptx6xGMpXwpFg8faA5uRSGhA3rJnlIHxn/u+W/Z52?=
 =?us-ascii?Q?UnQ1T88e1PCP+mSyONeUhAEZzghLT5norYANQvzeVl6j/9pCYwSV9ggJ0Wp8?=
 =?us-ascii?Q?hiKKeWH4+UIQbPryBJNiB/fKkjTVTTp4/4E9g99yRSdtTFZ7RZ24fiHI04Q/?=
 =?us-ascii?Q?AypMy90OOn6rNg2YdZQY+66niQB8ZF7IvfFVzaEKNKZoGWA3jO0pZda7/kFf?=
 =?us-ascii?Q?nYhEqmisCO7MEP2qA3JUU1Bo5RR4RjL1X1cSwBmqCq39/ST4hxsMzQylEFJ+?=
 =?us-ascii?Q?Ss1t3E/irUQvygYkyJZsSF4/FQecnpokwNklCCA+ZjqwUfgCUaUhG3MzsjV1?=
 =?us-ascii?Q?DziF8BDaAmZROnbqM8XLm1ic5P014P0XbvE6G25CtT8mp9NcnAWOh4It8CFe?=
 =?us-ascii?Q?X9BnSxLTP3wOdmRwvTpBwGF3ke9n6A7m2X5tbGDuFfUjzUeQ+ekNvanYNk+E?=
 =?us-ascii?Q?nNHRzVrJbWyRp5pSBnIXaaLbJcUiXNs7jPhjMrDzj31W3kkybvkH779GlreS?=
 =?us-ascii?Q?7I82sO3V1fYaDb0XW3w3QrjiRQ6M5jlYDEGH9hU3+C/SPAWQDD6WEY70gj9L?=
 =?us-ascii?Q?eW7jUxKuW4V5Hn++YxmsCeUiOGMky7e0xkaeg0GmbxY6phyD7p0gWSaSx0Rw?=
 =?us-ascii?Q?CoBaoHmZLzHnYuKbsOZmSV1yFEILSOj++FIe1frbAppy0MNiOnH5lXvv6JP5?=
 =?us-ascii?Q?EmV3PzyLmb8wy+7kngs79XPC9+1nelJ3INva08xkOY1vmCyJJNkETTk1MP1Q?=
 =?us-ascii?Q?Jt1JEXSSlMoLmiPSoXfDKc/YYu0YjFUAWFbpCGYxudXvhhguJBfa9hEYbtZl?=
 =?us-ascii?Q?r9ATbc1jYdO4tDImO/BlcxhqII6TUqDZO7jvy9q5GeLpnDza7A4KAS1i8zLU?=
 =?us-ascii?Q?g28jxtTxShIg3u9qXZQ+st5azoaxXkxRcNfYnJDtU+GS0PvLlEs1OLVm2ogl?=
 =?us-ascii?Q?aDdkwoKBpaSHaY8wUQOUFIDLOsRMfQwlO9MX3fD3cTGdcmvvHo21cnDCZ4N5?=
 =?us-ascii?Q?w660NDlmaFjOyTX9Z72iHTnCrgp+iUlyDTIuRn1eFeWt58KqRe2FoFOTBQMO?=
 =?us-ascii?Q?KYdaP+S6X/KBz7ogw6ehcxnax6cY4skaWMare628/UUPkb4ZD8cvO1SuOzBf?=
 =?us-ascii?Q?LciGak7d1nP7ckmXJlLFX9ggd+btDVv+Z+w8Rw/HfO6jEBWSofu4B7JJAzr+?=
 =?us-ascii?Q?/kJ9lJsjofmcbDDoo88W7fRt51gz15XRdDENdo9SozpRgfiBXtx8bVUCFI41?=
 =?us-ascii?Q?lDPJ9ov2gG5y99yxca/SVwFxUTNZhuKOXWJPvX95B6dT1cDDfmrqmjEKlEza?=
 =?us-ascii?Q?CTrjPEWa8HCVzyDBGcj1UB1AIKBfgK/CFdRCEChf?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9176.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a71ad9f-2b7b-4889-e882-08dd56852cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 16:46:54.1385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Bx+poLc9OZf9zC2YdzxJu7DGX0or7h57U4KwXKPr6mybfhIl1t/+m93WavB+MXWH5NHr7cVwJx0NbxsWeonrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6949



> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Wednesday, February 26, 2025 9:48 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Wei Fang <wei.fang@nxp.com>;
> Clark Wang <xiaoning.wang@nxp.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; imx@lists.linux.dev; netdev@vger.kernel.org; d=
l-
> linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH net-next] net: enetc: Support ethernet aliases in dts=
.
>=20
> On Tue, Feb 25, 2025 at 03:44:58PM -0600, Shenwei Wang wrote:
> > Retrieve the "ethernet" alias ID from the DTS and assign it as the
> > interface name (e.g., "eth0", "eth1"). This ensures predictable naming
> > aligned with the DTS's configuration.
> >
> > If no alias is defined, fall back to the kernel's default enumeration
> > to maintain backward compatibility.
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > index fc41078c4f5d..5ec8dc59e809 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > @@ -622,10 +622,20 @@ static int enetc4_pf_netdev_create(struct enetc_s=
i
> *si)
> >  	struct device *dev =3D &si->pdev->dev;
> >  	struct enetc_ndev_priv *priv;
> >  	struct net_device *ndev;
> > +	char ifname[IFNAMSIZ];
> >  	int err;
> >
> > -	ndev =3D alloc_etherdev_mqs(sizeof(struct enetc_ndev_priv),
> > -				  si->num_tx_rings, si->num_rx_rings);
> > +	err =3D of_alias_get_id(dev->of_node, "ethernet");
> > +	if (err >=3D 0) {
> > +		snprintf(ifname, IFNAMSIZ, "eth%d", err);
> > +		ndev =3D alloc_netdev_mqs(sizeof(struct enetc_ndev_priv),
> > +					ifname, NET_NAME_PREDICTABLE,
> ether_setup,
> > +					si->num_tx_rings, si->num_rx_rings);
> > +	} else {
> > +		ndev =3D alloc_etherdev_mqs(sizeof(struct enetc_ndev_priv),
> > +					  si->num_tx_rings, si->num_rx_rings);
> > +	}
> > +
> >  	if (!ndev)
> >  		return  -ENOMEM;
> >
>=20
> Shenwei, you don't want the kernel to attempt to be very smart about the =
initial
> netdev naming. You will inevitably run into the situation where "eth%d" i=
s already
> the name chosen for the kernel for a different net_device without a predi=
ctable
> name (e.g. e1000e PCIe card) which has been allocated already. Then you'l=
l want

The driver just provides an option to configure predictable interface namin=
g. IMO, all=20
those kind of naming conflicts should be managed by the DTS itself.=20

> to fix that somehow, and the stream of patches will never stop, because t=
he
> kernel will never be able to fulfill all requirements. Look at the udev n=
aming rules
> for dpaa2 and enetc on Layerscape and build something like that. DSA swit=
ch

Even with the udev/systemd solution, you may still need to resolve the nami=
ng
conflict sometimes among multiple cards.

Thanks,
Shenwei

> included - the "label" device tree property is considered legacy.
>=20
> Nacked-by: Vladimir Oltean <vladimir.oltean@nxp.com>

