Return-Path: <netdev+bounces-200482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E98AE5946
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 03:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B4F189B1F1
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D4F199FAC;
	Tue, 24 Jun 2025 01:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KwuxS0B3"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07CE3FE7;
	Tue, 24 Jun 2025 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728871; cv=fail; b=k2A6/Bo25E43/7D2OKs71Rg3Pory8lY9v0yqMirJHqO8xGbiAcJmCzawusk8CwkpToWepKBdJo9mkLJmiw1RGRb86AER68DuPh0pCM0jQ0SavDrsoBCJP4rR/jXltgerVsdIAcACGuc/01PZ2nR5Mb2Dasc/MpixEHO6B/fNRd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728871; c=relaxed/simple;
	bh=qQznMYr5gkCCCDMSX9Mj2RbFUVtz9w81aDhgJGywR78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GQWjJlxjKLnd3uI4uT2hKLiI2dvWqG7cx19JKpmhRDClyh/J7tLPWGUQbOe1GdYkCU6HrcHkgyr9wJm5/bHy2o3dgC3RU+l903zHIgSswc5Ku6/KDB2xPDHYbTA8bAVwq8SuHImWlI7R3me8QJzucNo7k5eCx3CF/EoDV9rb/8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KwuxS0B3; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUVuMfQkLWAbRpoZ0HZqMf+8k3ifsqUqmNByyKtXKfEKj17BBbBQhoq6sPlm/z4DMArbOwZJ5r8qdqrCGgMroKLq7E5k/o0/x9PE+8LJ4XDk3lmpLNAgJZC2Auzp15sgXYJG84+R30iQVKwkb5RmeSnnmjWp0EjQwL3wS/Eq3LfJbSEerpiNT3caeW6LBFV/TpRgfzqGN2kn4nrREmghRIHn8DYfgACVvdrvgYhttY0i8M4D/+6TVNDNzeEY4kMsL0lJ4zZSaNOLHlQS7t9+HgcOO9CFpcOc8rHsHELF6kbFUxGcAQevZjN030iHCwnc3+EeFXHZR8pWP1i9LILq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtr/uvXP+07SLeQydcQL/gNxDwRP+Aj5IyygAbKUUnY=;
 b=Prl21L3zSDMTeFx/ZuUF6fFDSZxgv1kIUCJldtXDvOXxYduCxS3HzOi0IzXUcQDLsp2W7yvhtB/epcrSeMu0umzkexVHbDuu+i0IOUDcDzA6rVyYriHQVtEL3368UnwT8fZ6M2B1CTBcFeeP9/i8r5ZU5Xb9D5R4ZlVmNyvOuCU+zhCQe07rTqGZYQMLi7wdqiVICDkO+z7cEugbSztOXOWdL7u7/5n6uewF+MoX/PGGSNoO/G35S/FpeB73zvjdoukMfnw+cnb4/JxCeG6FNy6j5lVKFf8n+RRBZJuBnJq3TEnnK5VLvkGmOEYYhabD/8zNcPEToUBcFiCmln6Sdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtr/uvXP+07SLeQydcQL/gNxDwRP+Aj5IyygAbKUUnY=;
 b=KwuxS0B3a15qV/8YotgU2vKa4/YSdNqCJkPtdadPSHI5h3ginAxbsUV917qkEb84KaHe5HERmET0JZq18IhQ6C4sRo+LMBNl+3lzcrXI6W7364lB4cHA3KzMWl5bzpbQk/2q92jEfQcdVVipD6YtI+4LexQEB8DdbeYqzNdlIEJ3+TK92xzmiNXqS+TQMFf5xbADjlTFPMzCzMkgHs8s9tLmcm3JQ8I3dbV8mhsKGzAxVjn71wawYpQiY13k7tw4jDrv1PsTqbEqRSpfgE8uMecMs67lcqo6UcK7TYoSnM7T5LuSyyPcwz47xFUKm+IrOYGoKyO8AzwxZDJjMGTWLg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB7589.eurprd04.prod.outlook.com (2603:10a6:20b:291::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 01:34:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 01:34:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next 1/3] net: enetc: change the statistics of ring to
 unsigned long type
Thread-Topic: [PATCH net-next 1/3] net: enetc: change the statistics of ring
 to unsigned long type
Thread-Index: AQHb4czJKeEuJfMl4UaViP+KlTFofbQNYN+AgAKcFdCAAPcrgIAAlwIg
Date: Tue, 24 Jun 2025 01:34:27 +0000
Message-ID:
 <PAXPR04MB8510FB925B67BCBBE0ADAAEA8878A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250620102140.2020008-1-wei.fang@nxp.com>
 <20250620102140.2020008-2-wei.fang@nxp.com>
 <20250621095245.GA71935@horms.kernel.org>
 <PAXPR04MB851070E3D67D390B7A4114F88879A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250623162833.GD506049@horms.kernel.org>
In-Reply-To: <20250623162833.GD506049@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB7589:EE_
x-ms-office365-filtering-correlation-id: 623d230c-a8d3-4412-501b-08ddb2bf41ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fyxTSzCsTdYTcuuYmq5/izwkNF/CLPuotq5Lh5Xa+tfUTCzSEdie5OfxxElB?=
 =?us-ascii?Q?aXz8K0cdBknILvl5yVnB46WY0WWicYIzIrTfFK8Gw4d8jJI/cCuFof7lbfbw?=
 =?us-ascii?Q?YItVFg6i1J4I10LnWlM0hX7bRjI9J8yLF7QZaHJ22QAOgcYje8FA8RJnH41j?=
 =?us-ascii?Q?myQ8iiAiQArqUWi/q/WJxJQcov8DMSxQgCNR3P4JPuJfm0zS9T4Y1wts26/H?=
 =?us-ascii?Q?G4q61LMvM9oFJLhwrbXQqeo+y5wzMcqauSi7iYKPKa9D41zWi8XalDGQ7WCK?=
 =?us-ascii?Q?nvpic8g6YUkktwXF2w2Z2TE8LukIC9ugrRwkALtS+PInXVPO4/DuYN0JsoPA?=
 =?us-ascii?Q?Z4BMerJYEEb90GeAgG+ITL4NnQSgpgX/95SQA9fSe+Wiw4Us/Ye6UY3J95Y4?=
 =?us-ascii?Q?WVmMMRppS0EXXnW3fX1/5YNScqqQCJta6A+1H7xQTPl/1KQxEqDtFldL2oOB?=
 =?us-ascii?Q?luk9eIsTmQyk8V3LooTfcSUTvC7vRz2Yp95DHhpg64qbx8IqR88SZEiqEAuk?=
 =?us-ascii?Q?TxqgTe35T73WLfMX4KM/Qww+aBkaGnySpb1aGUZ4wTDjlxU7i8KzX7QlJalu?=
 =?us-ascii?Q?eiocUGJWX4PzzLfffI+JYSWDf8+GeM86OgUfwh1GlCcs2+B6IuWFTtjBchry?=
 =?us-ascii?Q?8xmRKqTrMuyWcCf0d13YtJSoNFvWxrrnF+/nkeHH7CF5ka7hKQls3NVwRU7A?=
 =?us-ascii?Q?BNHowP23PZONc2ZCzOZBET1CucuBucTYHQLMGrqqaI1vADR6BlDoaa6/J+7Z?=
 =?us-ascii?Q?/x1Ho2+NxHM7mxhF0ysYrLg5TAX6JQIxCp400K1jakKgqYHpP4PnaAY+9Kfy?=
 =?us-ascii?Q?AubolqWQEFm+dSFgss1+ufqn8Ole+ZW7aQMzrLtymiovhd7tt9OIKtDGpMPL?=
 =?us-ascii?Q?9b71DFSfD0IFKDOeDMyX2VJXHab6C1VdF3AoAdU81k8GOgm3dA64VmoflkUF?=
 =?us-ascii?Q?I7OJVlHw/R3rhx6hWat6tkXjCDiWoWLEn4IOQPbcVCHNwZefWCfPfnpsytUT?=
 =?us-ascii?Q?A3rMb0VF5uh63XrknOMOLCFVhky+m5aOFhBcSCeAnM3k6hhPjIWHlV+GBuEt?=
 =?us-ascii?Q?7MVdSsXj0VXB7NlnuOHSOs5vJDPSf/gNu5eUGwbmYe23czbwOncdIqKQebUr?=
 =?us-ascii?Q?Zu+0MnN6GyVLAm6g0dvaUSeEkLHVl3aOFhPYdFiY1vbnwjgh2tLUC3ICU6EM?=
 =?us-ascii?Q?hsALHZu649TxVwTynSFgjZ87bz9NsQtNYlekQXKlQiW8DzaryFUMxMmkMiah?=
 =?us-ascii?Q?fzLzckV5aLWSIdgM1c7MvbsxsnMyyo66eO5OBgwuaUBe2FWRPYP2VC1p1UCy?=
 =?us-ascii?Q?B6TSqrJP20uOjX5a7yVuRkJFeN6G/4hRst8F2QtL6i8pJO3Bm2aY8aKQMvH7?=
 =?us-ascii?Q?Ijr8K61xsITSnEm0cu0WPPACmES++JL+qDVGBKcLSSFExuBeXRNIGcsgLKCI?=
 =?us-ascii?Q?9UB+JaNC6jh1EFoVjY3FZGXb94eukQ+pHRa/q3sb5tXpZL89euA/0g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iJZlRBnRtTwzc1lThelbXzMtYiRyb1MLGante7Dsh0ZBVtpNK+YH7uUC/wSo?=
 =?us-ascii?Q?tbkDEsGp9dD6RaDHSK5iZ95IIjkL1VgVGQ6mOLEDj883A1Bqo6pi5K1Gbxgc?=
 =?us-ascii?Q?oqArMDUnP5iYn/DQQhChWiTP7K+wRFE6sgnlmpdXlWfx0BEZDRJrXioPbQZp?=
 =?us-ascii?Q?XPuks7pL/HtxlsoOKSwwa8kOKh5RvbFMiZU0V73AnzMW0CAjGtCFEXFpiAhU?=
 =?us-ascii?Q?TPUrsEIWYDlmxar2dbt9JSpAk45xRF3su8H903Gv26yZ0ieMB4rEJ9aDRNap?=
 =?us-ascii?Q?r15sox2HNE+XAwo3AjO0qil7nziQm5HflBS4HqK2kqqqKU3IOMFgBOOSnWYJ?=
 =?us-ascii?Q?fUnCbM54EvKKXYfdvOMngvO858G88bmtfrO2CY9Q91DGVWVIYmeDlE5bdhoh?=
 =?us-ascii?Q?4vUE+7xsgYFJEEXCgFkBtEZ3iHIguK/KHkxmYY6i7K3hCeg2gmALLl5XRHyB?=
 =?us-ascii?Q?+40VZ1mso4klh66WvN96Isz9Oxg1p7FHzpXUqfg3Ai2OrR/mWT9UPkUI3SO9?=
 =?us-ascii?Q?XpyYK6/mlAFZmWSjTdqSNKstA/Uqxf+cbpgMRD96xeQL2V2ZQFWksCgcMxNd?=
 =?us-ascii?Q?PljQpGrBRI/YaPfomTMcqf2c0J33CKzGHYEUC4DfT7x/CKrM+2GAhUlvnAn9?=
 =?us-ascii?Q?4ILr5IeZqUZSWgjRV4zIWB2x7idY74yxd9/zCN1HWr894eDz5BR23SfCByIG?=
 =?us-ascii?Q?LTosW5GWLCSMqdx/+p44HJhksHiIB4XDpfi9C4ZlVD0NQeDrF0DuxcyV6ypn?=
 =?us-ascii?Q?Nes/0onBECZRX8BlosFWJwKX+G8YYmn8judbWtG6/wXouUzwpFwPkMe1V57S?=
 =?us-ascii?Q?BlLUh1tvUtpjIB19/UpGSzHqT9lZvX5iefHi9ZaqeDaiuCSRPYAEMm+UKngo?=
 =?us-ascii?Q?uTMOyY9vauwNgxDKHAMXrQeWOgkEck4pZoBhMeIqNFpNxShPJ5patWDzweld?=
 =?us-ascii?Q?NA/3JPm3lwYXGisH+x8sBj8wGZ49oCjWQvGRIuUBsV5orclrRP5QO+oYHami?=
 =?us-ascii?Q?7kLKG4r0tWmojB7j1QM/Vc3j7rOfzisKDLPIxIcC8p9Pv4+s2v4JSL65+Zxv?=
 =?us-ascii?Q?fQbLzTHtVGDZ3fhaiRHtWEzWqXA2lo3EZObTYKFe9hmmScVdeIw9pY1Aq23+?=
 =?us-ascii?Q?XC968u4YgU6jHoLV5X5ZlX8Vzi0mTtcp7ZJm3llfQoMUGFWCqvRoyzjrFpvX?=
 =?us-ascii?Q?UlaZj81x1pzrTy+MoiAdyWJlmyDjv11PE6OX/Bz4fDmElqAXLA6PhAFT0hXe?=
 =?us-ascii?Q?4dj1EJarA1R/wyYW+2qv3VNWSfqg7g4O4d2U4hxBtHb4SQCuy0mF9I7+Qd2o?=
 =?us-ascii?Q?u0RtvNvfkaugjNYQqgZOilthyzmVi0SHkWzAB8rjidghhbsVnDSGswH+lkic?=
 =?us-ascii?Q?0ZLYZ7Yurk+FghjcvzQp6/1cAPfNJQudiVmZsbjqGJI6+vjQeBBo0gVbrCJp?=
 =?us-ascii?Q?CWE+aSFs2oTN7myJ8qnQ+IESUKJiiIfy2oLTEgC7lkNoNYKUA+pxUahrr+dy?=
 =?us-ascii?Q?i9cX4FZvUekW+4cPdvOp73+bKG1Sdb+L/E8Mu6VTPCpUJimACSDEcHDVf/xN?=
 =?us-ascii?Q?h+EM6L5jELJ7iXfpI0o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 623d230c-a8d3-4412-501b-08ddb2bf41ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 01:34:27.0820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7RYk6pMsnVjJh3OJYHhF836ncYPkUsv6y3S4k/OPCLCkXZ/7jE6GVx5miw7LczGMthBUPcTwQTezeTnFGYNKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7589

> On Mon, Jun 23, 2025 at 01:49:59AM +0000, Wei Fang wrote:
> > > >  struct enetc_ring_stats {
> > > > -	unsigned int packets;
> > > > -	unsigned int bytes;
> > > > -	unsigned int rx_alloc_errs;
> > > > -	unsigned int xdp_drops;
> > > > -	unsigned int xdp_tx;
> > > > -	unsigned int xdp_tx_drops;
> > > > -	unsigned int xdp_redirect;
> > > > -	unsigned int xdp_redirect_failures;
> > > > -	unsigned int recycles;
> > > > -	unsigned int recycle_failures;
> > > > -	unsigned int win_drop;
> > > > +	unsigned long packets;
> > > > +	unsigned long bytes;
> > > > +	unsigned long rx_alloc_errs;
> > > > +	unsigned long xdp_drops;
> > > > +	unsigned long xdp_tx;
> > > > +	unsigned long xdp_tx_drops;
> > > > +	unsigned long xdp_redirect;
> > > > +	unsigned long xdp_redirect_failures;
> > > > +	unsigned long recycles;
> > > > +	unsigned long recycle_failures;
> > > > +	unsigned long win_drop;
> > > >  };
> > >
> > > Hi Wei fang,
> > >
> > > If the desire is for an unsigned 64 bit integer, then I think either =
u64 or
> unsigned
> > > long long would be good choices.
> > >
> > > unsigned long may be 64bit or 32bit depending on the platform.
> >
> > The use of unsigned long is to keep it consistent with the statistical
> > value type in struct net_device_stats. Because some statistics in
> > net_device_stats come from enetc_ring_stats.
> >
> > #define NET_DEV_STAT(FIELD)			\
> > 	union {					\
> > 		unsigned long FIELD;		\
> > 		atomic_long_t __##FIELD;	\
> > 	}
>=20
> Thanks, I understand. But in this case I think the patch description coul=
d
> be reworded - unsigned int and unsigned long are the same thing on some
> systems, and on such systems there is no overflow advantage of one over t=
he
> other.

Okay, I will improve the commit message. Actually both LS1028A and i.MX95
are arm64 architecture, so for these platforms using ENETC IP, unsigned lon=
g
is 64-bit.


