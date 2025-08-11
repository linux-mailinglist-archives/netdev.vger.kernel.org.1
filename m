Return-Path: <netdev+bounces-212598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EDFB216C0
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 22:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE1F1A24887
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE9B213E90;
	Mon, 11 Aug 2025 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AEZ9xLCs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A981311C12
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945285; cv=fail; b=SJUx3nvsHMpY6wenAOuOv4Lwt9VjvViaq4cVYa7gyGw4YufL41eLQoieeaF47dXlU5wUQmFh28XqvnppxcNx0Y9FBn6z5Ov3LO8TngEsxnWQrrrnwF25Ts4jWjNh9+9SzDBdd16h1edHcvgDvfWsaKBPomYvZkFk4eMETAw6QAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945285; c=relaxed/simple;
	bh=mEkBC8/JxVeHkSTCS1PbyyUv8FjplsdUae51cCMlKzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S6tXgda9HlRr8BLaG5R+KpzmNoG0Mf2ADcrrcjI4TOA8/0ja9lFokDRepfu95EkNINy2SIt8tu3HMs3ysEgwJY5n8jUAD/HmwgXAGU/wlrCs5N2WtJTluIcwXMFfUTx5roD0C/ERRnriaJw7+5ApH2D6EQRRLN4rWMeARU83olE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AEZ9xLCs; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/tZNRUjon4f2ThjqqwBse++ctb4Yk2vTNzbpbEig1vd001xAKS0K5GAiF6jp7CcDHVMuUg3cZS2QAK+73fO1VF/f17LTLFAHh0aTZh6xN1RUs8yAuOkGAczYJ8F33Lcv/6FlcQACg+2zCZbuKcd64aGz89BUOpxxMBdt7gDExYU9Wh20rDBnufb2R7rdldGJR+emFDjEv7oHo5gr7gVOdIR+3ZzsN9IZ+JIozVhQ8kWjFwMju7wiHDP+kpxfZqUS4B4ROnf+Sxkyy39r5EsnC2UBvd3okJNRlhJniqXwqnlk+rf3eM0WJDJjFd/fJg8syQ9WQQP82dUEyHNfMlaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AY53gPPhR4qBfKVhqZkQ2yERe2QSCnYzSxZlq3xbau0=;
 b=fP34m5YtTHpUkRurnSFppac3GfS+a+WUTPN+Tz2dSchIuhM1wY8BJikb25n+q4SxdIQQjAVdaF+IjXd7CQXRWZfpkn4UKfx1Q96Jb2/exuhVicMhxgF36sv0clHSEZWfMFFj84oB/Vs9LMgMAxxWRT+jF8LCbnsV3UqcexobK32bbVDq9fDtHWFpAsPIp+wFgQquY/PhMjUbdKKnXc/ImXBtrnPDdBRnuFc76ze6bxFpqaC2JMifDpN/25KncVa+jDBX7voYiqqpUkgfl83mj9XFEm3Lhed0goTGCOEHHv/O8PWsvbgc7VFO+sn/isdADZVWBPCjlb5ORa4qts/Gnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY53gPPhR4qBfKVhqZkQ2yERe2QSCnYzSxZlq3xbau0=;
 b=AEZ9xLCsBbq9hQfkq4ETAViBsyj44y2WN4AY3JInZZEIHhPsclaZRS5YBCPAd6pJOORVPtT7ejwykfwzi6fgPZmmzVcOc+KBwR7XqabFMh18Hwa2KTBo3cSMWDpOBaUSqWmGPPptIRw7ThbrO4a/t3EtQXXOKJjd5t4Gme9NC5YPH7bayIJbPRhXjSQms0Ajxo7JfLfdIw96Zgcdk5v9fZv+t+OGIy5OQfV8geOsvqmAoTxYgllZvKBbVKeF4gLm2glyveqrv8rjbjye/qsu8pC9yMU/W7e/+4ahwGxZNTTimYSwUZUd1++WQ7oKiio5sb32Wy5yNEBLJKGxCnVVWg==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 CO1PR11MB5170.namprd11.prod.outlook.com (2603:10b6:303:91::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.22; Mon, 11 Aug 2025 20:47:59 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 20:47:59 +0000
From: <Tristram.Ha@microchip.com>
To: <marek.vasut@mailbox.org>
CC: <andrew@lunn.ch>, <Arun.Ramadoss@microchip.com>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<olteanv@gmail.com>, <Woojung.Huh@microchip.com>, <netdev@vger.kernel.org>
Subject: RE: [net-next,PATCH] net: dsa: microchip: Do not count RX/TX Bytes
 and discards on KSZ87xx
Thread-Topic: [net-next,PATCH] net: dsa: microchip: Do not count RX/TX Bytes
 and discards on KSZ87xx
Thread-Index: AQHcChE4b1dqM1jPbUue9pY0XZUvtLRd6bDw
Date: Mon, 11 Aug 2025 20:47:59 +0000
Message-ID:
 <DM3PR11MB87364054C23D4B64069F4639EC28A@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250810160933.10609-1-marek.vasut@mailbox.org>
In-Reply-To: <20250810160933.10609-1-marek.vasut@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|CO1PR11MB5170:EE_
x-ms-office365-filtering-correlation-id: d4ead4db-5dd1-4079-ad66-08ddd9185b79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MFMVTq9glAxJNKJYGMAVx1d0pwkGnNxTCEF93SPaIXGeARRnZaJbRFocOnQT?=
 =?us-ascii?Q?d58Kp1lULdRHHQ/uz874L7Lag2OTRFjmUxevPcQ3l2Tj6awcfHFCZb4k5+i/?=
 =?us-ascii?Q?BbWJES97gJaVLXllfGWwhSbZYNRgFuVYhUlYTQdDGYxpBi7sn/gJiFhM1F2u?=
 =?us-ascii?Q?GECON4uPmPOnLuf0oAj+lnplm6oRTZPqLOVY0mao6pRCku6BfFR5kaJ7w2kG?=
 =?us-ascii?Q?VSsH5mUg+OQ59jtoQFbyt6QFZv+iHnIjCSri0I7S99MM5J9UutDB15Gfbps7?=
 =?us-ascii?Q?1zR6hTQyR/akNyx9NIPoc9pVV+TIaizBS/lqDcFOOoMvakedmgM3m0fAXqhR?=
 =?us-ascii?Q?WJ7A8DfQ+CKhjgUlmzDZqznuAIBA6rNgpcJO1QmyMIH4XPJkZcUGfRDgvPmm?=
 =?us-ascii?Q?Po9fjALA+p7t9sOfScUGCO2wYPYgCVgJQO+wWmtsBg6azH/qV4hYbL5mbtW6?=
 =?us-ascii?Q?P69qOcSrAAbUK8ZjMbeonH0xSMepxRJpvPrP/osP0jEwwTEVIB9n43IRSAGU?=
 =?us-ascii?Q?f9k7OC3kr9Vz0xPr9Cm5b4oj9ebEnlxzhPGQIBzIYxX8BI3hU/O4Cfsw9IEc?=
 =?us-ascii?Q?ohFVDBq3dp3az54oMkXGfCPmSQvFRnvdijIPKxKb174ciYxTc072xyBKvjpq?=
 =?us-ascii?Q?j5PejplqJIK9jRIxjSKhac3iKGBoucfa+C4nbJcJjLBU6zhQsPbRV+70tiCi?=
 =?us-ascii?Q?c2kZiVikmVdOpMoFNuVZYa0esIvXLtSDowZwXMXkE8zrywaEsuWJjbI1fgQ0?=
 =?us-ascii?Q?sj6CgTf48+I1X6qBpJla5WzTJ+ltccOlVkmZtxzuDBnHEAJ6C3301iHqA8+1?=
 =?us-ascii?Q?UqEaS7RvxUzy1AVKIo/JjclDzD7VxtHjpLNpmUiReeqxe92mrTl03DBk78da?=
 =?us-ascii?Q?748Fz9RcvnOiv0KNUJdtobpJdn6rQwvL86a9MIQ/Nq+R2E9uYUj+Me/rvdlC?=
 =?us-ascii?Q?QBZd4w0SLoXJk2MSD50ZpNn0Ye0jCLLEDTi8mWWMWdY/IVjFcWwaSUNxL/17?=
 =?us-ascii?Q?WcBczNQlhbY+3Z+XrMnmFJevZjDMkZrKOXlcCoyria4korut3UR13G42Uxvu?=
 =?us-ascii?Q?PieGpjVTkVepW5wYcDDy38p/qGbz6bZXErecLse7PK/nC5y0y6BNruyCKTDH?=
 =?us-ascii?Q?eDaqRr4SE9Ww6hbqoFkYX/Wrt8a+JTFHqPMqGIrr1hrrOjw02N7Lky2kjm7M?=
 =?us-ascii?Q?cCCed1YTiIawts+Vi9R5b8YzXQK1ufgyThFy2U640ehH0UyZaNp5fEI1/e0J?=
 =?us-ascii?Q?UUTOzNfDRuNkOipCjIhBfz+PYKnD0KOl4ItG1JWZ2HCKrdynF43nnuSaAnPv?=
 =?us-ascii?Q?pZi+11hySuzI9iVM0Aj01qL4lFV1/jP964HW+N0oueMiOKroCXcSpXwhLfnl?=
 =?us-ascii?Q?ubNnX1w9uRImCQf9mHQzC758kUz8I3HrmLLxUt1mz9hsIylshKBAvY7XkTZs?=
 =?us-ascii?Q?M7mNcc/miQO7qTe87yNSYv5u2rzzhyDxccp+TgVMteJl9NIggnH4Gw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2//LVPrY1crqzUpRF4NI6DxqivWMjARUgY5ZMVFbIO3HxG5yARY6Nq1mWjl1?=
 =?us-ascii?Q?AEeGcXJeYkK5NWmDiYIGcNRCdm2+SKVFep7hW8ySssWuZvIeVxSwXU7cp//D?=
 =?us-ascii?Q?mlWDelIT17Rn1m2WJErhJQrxmjK/lhtgNGrw+lpgykrgWQte8MA+qvX6CA77?=
 =?us-ascii?Q?oMU6p+//CgIKFbp7LVZhpl16Rc8Oy3C0Aqy0cUi4wSKRC3ZOjSbDCVZirb5a?=
 =?us-ascii?Q?cdHh6CgWYOMQgf/dcDnN+PyTZDX0+lhll3CPSOQnBbIWYAJg7tF3jDPHHwZR?=
 =?us-ascii?Q?IWsEuhF6+o+LuVK4g8kmz1qi6/kunvd/qQplCveyne7ovN0xp/nBp4ot5vXB?=
 =?us-ascii?Q?UUA1Qs/iMvXkij8cidzphD8N4Tc1vrKkoYrT/TeuDEVI6wkvhVHmRysURN/F?=
 =?us-ascii?Q?spjxvw1JbJUXzo9O7CHYQZlqNaAvJwxI96S+BtxX6yw0CHPHQlsyLjwTbovr?=
 =?us-ascii?Q?pbTJtt4kX6mEJgj/zEwD5B8uPeHHgtU6r6jyJIMccRd0EGOrlgxDq0MzOU7I?=
 =?us-ascii?Q?wOQApM2d4aMFn2r6m4CqWv5onmDTfF/FiwTSn6c79j1m7jcCLq4COKhZbBB0?=
 =?us-ascii?Q?leISG1918iKxTeyRiusQJBauH4WXfoiTvXm+TvuRjLqRSjuT7oaqwSTMV4Mh?=
 =?us-ascii?Q?20SvALPGMvH+oenj1PeL+RCVV6CyCtyQehE6D45+0b5s6QN6yc0HPbfyFNhv?=
 =?us-ascii?Q?cKff+5mPvMlS3rd/C6kY0e4kw9AHKpTz6Vvaprsoy3WxdhNnzQ7C4Wp39/EU?=
 =?us-ascii?Q?tW3tZTXm/O0vn95/caK/zTQvqZE4acOca+v3/o5RohmEDz21qnndKj/xr8Sg?=
 =?us-ascii?Q?A+K4fxZQxxBLh+QfFfTlAM2HQtg9gLw0gzHE8xXy/ZaUd2ekezklr3ptSTu4?=
 =?us-ascii?Q?aUcAWB6Rsve2M9zr1uoIa3U8pfyyCuITul87tr01oEd4SSUFT+1qMyIVEAmD?=
 =?us-ascii?Q?mgLsp9E64cC67naerYgk8po7ytK2UyV1snBW+XyiocJJh/LlyC3JcGyhZLDF?=
 =?us-ascii?Q?2rX7k+uL5/PxeNy7cYRGtyDaDI65EIGV3LTwN40I8Bc17RGodsbR+bABqphA?=
 =?us-ascii?Q?2+qYtsQBQ1KydrcSz4mKJVPoDn8PEQJBRqFq/uHSci9c5m+mQwGpwggzIQyW?=
 =?us-ascii?Q?NE0YX1Y88ev9AY+q56jLVoVj80XYGqs/zoEaEKQxVp+yGyz6mhfgPlBYI5+x?=
 =?us-ascii?Q?8EAKivWHF176XhIOD1blQlujiuEGABV39KRbbv9kpjZWCXaWznGZ+X+HHM+R?=
 =?us-ascii?Q?RP/1RVZEbHadRRFzrbd3tuII2YurgBnTAg8uvfDcv2iYKXoFAnPnfwdSQ4gj?=
 =?us-ascii?Q?h7fPvGbJoyvCGfPCdJ2X0T0Zhd3+htb3yF9A+QEi/MSaoestKqPTQVaYj8ne?=
 =?us-ascii?Q?0soTG7KQnnqsPYu/8jDR2LkR/RG9WxaY7h3J89CfCN3C3egJnVl0CAsCz0wP?=
 =?us-ascii?Q?dWAqHI5Qs9nO4SdocGloEc8uyU/eqMf4rMdbsumZBr1XX4VKiNS9cI9BDUPT?=
 =?us-ascii?Q?XwW2/zXQ26IWUcTbD1Trz1LVButqK23gv2PdRhP3CYXoaxmBc7K0AZU12qfK?=
 =?us-ascii?Q?y8ziK7NNZ8cPJgQUgO7A2jnnzrmKRbrFuiPSF0i/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ead4db-5dd1-4079-ad66-08ddd9185b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 20:47:59.3334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qw1gmp4bkabPEmoO62DMIxypnCkL1+Ud8ihCotI/qDTM3qLTuG8fcx71jfBOkbcfRbPF8Dr7mxZnSxOGy+zl+cGMdlGuCLEcy1s6Jo6tYIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5170

> Unlike KSZ94xx, the KSZ87xx is missing the last four MIB counters at
> address 0x20..0x23, namely rx_total, tx_total, rx_discards, tx_discards.
>=20
> Using values from rx_total / tx_total in rx_bytes / tx_bytes calculation
> results in an underflow, because rx_total / tx_total returns values 0,
> and the "raw->rx_total - stats->rx_packets * ETH_FCS_LEN;" calculation
> undeflows if rx_packets / tx_packets is > 0 .
>=20
> Stop using the missing MIB counters on KSZ87xx .
>=20
> Fixes: c6101dd7ffb8 ("net: dsa: ksz9477: move get_stats64 to ksz_common.c=
")
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Arun Ramadoss <arun.ramadoss@microchip.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Tristram Ha <tristram.ha@microchip.com>
> Cc: UNGLinuxDriver@microchip.com
> Cc: Vladimir Oltean <olteanv@gmail.com>
> Cc: Woojung Huh <woojung.huh@microchip.com>
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c
> index 7292bfe2f7cac..9c01526779a6d 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2239,20 +2239,23 @@ void ksz_r_mib_stats64(struct ksz_device *dev, in=
t port)
>         /* HW counters are counting bytes + FCS which is not acceptable
>          * for rtnl_link_stats64 interface
>          */
> -       stats->rx_bytes =3D raw->rx_total - stats->rx_packets * ETH_FCS_L=
EN;
> -       stats->tx_bytes =3D raw->tx_total - stats->tx_packets * ETH_FCS_L=
EN;
> -
> +       if (!ksz_is_ksz87xx(dev)) {
> +               stats->rx_bytes =3D raw->rx_total - stats->rx_packets * E=
TH_FCS_LEN;
> +               stats->tx_bytes =3D raw->tx_total - stats->tx_packets * E=
TH_FCS_LEN;
> +       }
>         stats->rx_length_errors =3D raw->rx_undersize + raw->rx_fragments=
 +
>                 raw->rx_oversize;
>=20
>         stats->rx_crc_errors =3D raw->rx_crc_err;
>         stats->rx_frame_errors =3D raw->rx_align_err;
> -       stats->rx_dropped =3D raw->rx_discards;
> +       if (!ksz_is_ksz87xx(dev))
> +               stats->rx_dropped =3D raw->rx_discards;
>         stats->rx_errors =3D stats->rx_length_errors + stats->rx_crc_erro=
rs +
>                 stats->rx_frame_errors  + stats->rx_dropped;
>=20
>         stats->tx_window_errors =3D raw->tx_late_col;
> -       stats->tx_fifo_errors =3D raw->tx_discards;
> +       if (!ksz_is_ksz87xx(dev))
> +               stats->tx_fifo_errors =3D raw->tx_discards;
>         stats->tx_aborted_errors =3D raw->tx_exc_col;
>         stats->tx_errors =3D stats->tx_window_errors + stats->tx_fifo_err=
ors +
>                 stats->tx_aborted_errors;

I am not sure why you have that problem.  In my KSZ8795 board running in
kernel 6.16 those counters are working.  Using "ethtool -S lan3" or
"ethtool -S eth0" shows rx_total and tx_total.  The "rx_discards" and
"tx_discards" are hard to get.  In KSZ8863 the "tx_discards" counter is
incremented when the port does not have link and a packet is sent to that
port.  In newer switches that behavior was changed.  Occasionally you may
get 1 or 2 at the beginning when the tail tagging function is not enabled
yet but the MAC sends out packets.  The "rx_discards" count typically
seldom happens, but somehow in my first bootup there are many from my
KSZ8795 board.

Actually that many rx_discards may be a problem I need to find out.

I think you are confused about how those MIB counters are read from
KSZ8795.  They are not using the code in ksz9477.c but in ksz8.c.


