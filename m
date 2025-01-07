Return-Path: <netdev+bounces-155954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F27A04660
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810BF18883EA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B261F7545;
	Tue,  7 Jan 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iNfbYn/K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475B1F8688
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267367; cv=fail; b=UrEUmFh/B7r1i5b9EkoFUSEgbqajTd6h07MLPZJMYh2wcfbin4FP8JtxNd37zNbh4JKv77vAW6o4ZbIfIF/IyXqEW8heSGa0JD0iqYv9Eeo+z2TK9MJ8HTSPzLgk73JsV4CW0NrbvCYgTacxPnBiwQJhFYvry3uFUfoWEYWx0Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267367; c=relaxed/simple;
	bh=E3ts1HoJ8Zbe4U4s7TCKeh0W/NfBKDDnsdDF6LrvVH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sM+7YZo1nJc2JI8WfmQOiVXP1kIaOQ8a5rRC+1d4g6CinDRXXUurk54aZQHFCKdVHo9NqutZKnl7WLXMcybyQ9BS/PJeUtxtOgF8LywPnGPX52JwIq9yyX3exf5HawouMDwWzx8OKuPhO5IgA1yhYcOg9V3St+dAowdXPLZ9tNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iNfbYn/K; arc=fail smtp.client-ip=40.107.102.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCLbb5Q5oToNbVpdWJnseuGSzJFxJKHhzqSHB5BY+CFhOXreSvb7dGmf0LPC4Vq4ga/caTvfDp0VGFcIsxGZkX3S+Eh52GOp7ySiOHrTf+SqjnSQQYjIYCrXmH0E/iys/ms03EAz8QCX2Ys3hIP1IOIZo+wS+xg3y0MFQsBk5HzjM/F/1jFYTkBBBRbiaGpbHqBlny2vEYuiQqeQiNs8vJY0zaeNbPp76hEcjf5DH09G//7LbP3ShjkaxW59CR2DPLWjUlA6Z975iSX9ef5KZugBJLYjh8axYUx6tyRSygz3PalgXpmcFzEj566d0BxRc6Yyh4LhfvlNx5zYpByANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3ts1HoJ8Zbe4U4s7TCKeh0W/NfBKDDnsdDF6LrvVH0=;
 b=RkxFYHPrmIxdP/B/xGghqOcI2iLiwj3ZX2LtX6jOildEWL6SUPvRxFWgiq2dUQWYamkRDcsDPQRZn4z/d0cL0MoeJT8/vGlAEib3sWdygtXvlL9ZLnjWEm44RL0kpAHybmbwtJ4GMjWZBLSYZ6k2lMYJ5TEml3HgUSic6OgrTEYHCtT62FvoSTw5uibUHDKjov++oAtHbg3wS1S6qR2ryyjqJj22XgbRc4eAZUQjpVfVXO2M9YTCRy873PBpDoG9ultw7w6JtdSLD/X9rjb7jGb9wnKKnqqubdkVIddgY5sj9dVjiK313LdXNeYTUaXS3BXOnAB6pLDjVD+Vesz7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3ts1HoJ8Zbe4U4s7TCKeh0W/NfBKDDnsdDF6LrvVH0=;
 b=iNfbYn/KqAikEHXJhukzfoEU58RF5F096a/12quNhBrnCUzwK/C2NLH/E1vQl7ZzYhU2V7PDyxDE625d1v+bH4SrOEiiWjKqgg7JtCi74o+jTvcejLxmYIK5cpVfAS79NT+Ru6b+ESbjW8WhVSGCLo6YygMgPvCGSXJAytwExRaiksMKkUXGLDMZ1p+LV+j6AH3upRfQ1HA68l5u1lHDACOugPLvO5p8IraE67twyhuzL83EPUi+UBNsvMJB47RFDPwo4q+Qr4ZFNRDQxIAXnbbC3xLd60+IgtjaQq/vK08Daf5SUJTOHtF4gBLt+GNEGPJWgUdFP5tVLIBiZyhLWw==
Received: from SN6PR11MB2926.namprd11.prod.outlook.com (2603:10b6:805:ce::19)
 by PH0PR11MB7634.namprd11.prod.outlook.com (2603:10b6:510:28d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 16:29:16 +0000
Received: from SN6PR11MB2926.namprd11.prod.outlook.com
 ([fe80::8fe6:84f3:2dcc:80b7]) by SN6PR11MB2926.namprd11.prod.outlook.com
 ([fe80::8fe6:84f3:2dcc:80b7%6]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 16:29:16 +0000
From: <Woojung.Huh@microchip.com>
To: <kuba@kernel.org>, <Rengarajan.S@microchip.com>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <Thangaraj.S@microchip.com>
Subject: RE: [PATCH net 2/8] MAINTAINERS: mark Microchip LAN78xx as Orphan
Thread-Topic: [PATCH net 2/8] MAINTAINERS: mark Microchip LAN78xx as Orphan
Thread-Index: AQHbYFuyrVcAlX+vYkCLN6Uqrkp8arMLWwrwgAAQIgCAAABOIIAAEcCAgAADWjA=
Date: Tue, 7 Jan 2025 16:29:16 +0000
Message-ID:
 <SN6PR11MB29264E3220B873B6CCC4C318E7112@SN6PR11MB2926.namprd11.prod.outlook.com>
References: <20250106165404.1832481-1-kuba@kernel.org>
	<20250106165404.1832481-3-kuba@kernel.org>
	<BL0PR11MB29136D1F91BBC69E985BFBD6E7112@BL0PR11MB2913.namprd11.prod.outlook.com>
	<20250107070802.1326e74a@kernel.org>
	<SN6PR11MB29266D59098EEEB22ED3BE86E7112@SN6PR11MB2926.namprd11.prod.outlook.com>
 <20250107081239.32c91792@kernel.org>
In-Reply-To: <20250107081239.32c91792@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB2926:EE_|PH0PR11MB7634:EE_
x-ms-office365-filtering-correlation-id: bf12ef6d-ee7a-46c1-8059-08dd2f386dff
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2926.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/SDKxXtxxPLSX4yIiPBCTgFZ9SEFrTdmjnb6lhPNO3+swFd7q8YMBbnY2jzE?=
 =?us-ascii?Q?qs8w4iL64iTQgh3oHRzedM5D9izDKPj97toRgWs/PN+rRm1bix3AidiPZzIx?=
 =?us-ascii?Q?CQzCV8FpMpE0IZcFgyua6f2I1irGskseqytS1HdbFHcWlQO3EHspiclWACcT?=
 =?us-ascii?Q?Z4XweqN1893/C8/+bq9hSZ04JQe+C8IG3M+lyYH7JRZBNbebT1I6CT1zOtQi?=
 =?us-ascii?Q?zaHSzkgDqoBM89oi4i+sCoMt3BQzYi1IR6VrpL6wikpkpiHRTib0nA2ouQ3v?=
 =?us-ascii?Q?kxUQDPhcnYfwtPdLSKPZdduiE/t9VWcTd8LfO/1dT21ut32beZ4stVze/lGE?=
 =?us-ascii?Q?nQTHj0SjFn0FhYeZN9JyfogzcuzvI07Mms+AZjfvdXZ7EHmHW/5R8dtc9A3k?=
 =?us-ascii?Q?glHOD3ckOTfIHsss82ygVaUsk/ZoPObYWVGoXo69B3OvD0jCHchlZeUDXLLV?=
 =?us-ascii?Q?yMTEt5iG7I5gEruEXqiuDQkaOrdI8UHvxBPLjXbdexW7F9IDlyrqkumPr+bU?=
 =?us-ascii?Q?FxF9KBfJ7EUvmjZxZoU2VchN5MQ+rwbasSBQ+QwCbUYRP682YjK8KopMOQPu?=
 =?us-ascii?Q?Q5E3l4RZdgPrJ20eluHcKQ+zbs+84o1V+0NhYKVuMX5ihbJn6uTeh/dYoZil?=
 =?us-ascii?Q?wQ5tA57c0L0E5kaYi1Dd3c4xzsvSKd13tqA1u3aI4pRUyUT1+Q26wOuN4Pxm?=
 =?us-ascii?Q?NXKi+glyY4XQn6t0Ws3ZDcCUMQQfdHVj6lu82/WE7/UQ1bJsTh+0664O6dfz?=
 =?us-ascii?Q?JGc/yNpFS44o0bU2VT5bbLR6ZtVDRveh2QIWMEJ6xAr9b+PrAkWzUjgyWMYM?=
 =?us-ascii?Q?Qn4lRvyQVXtwekFoSID9gt1osaqVZeBgepJ81Xeilxh1HJ5BCn0IMMgKhXI0?=
 =?us-ascii?Q?WK5jZhxzuqC6iFOtaUtrpv4YY88P6nwLJn18cSLasl37ptzRdSUtSw1vFdgo?=
 =?us-ascii?Q?weYx/+9NsyAepsP5V2aIkjzdr18qhaeFfKrBhUWt9yYZvdgVK0lSizxWQdwp?=
 =?us-ascii?Q?s1e2mGgoSElAwEX51gIqD429tRDwQY8zlgjVaKt5Lno2olhqHgLw8gXqbB+Q?=
 =?us-ascii?Q?pZ2IaOIL6DY/FUu+YtpWqt7eJ4ernj/QQfV4CGNnFWT4mk75kShb+7P7+/Az?=
 =?us-ascii?Q?T8ArHe+nRUuXc8+tqMgl6ZBAa6kkKhz8uojIGngiR0Ih/xz4du/ijiJSYmM/?=
 =?us-ascii?Q?AUVtxrERdmcaC32ht9MF6bi/MjVWKQ9HkF0ShPl03cH8kxfv0J18Tv7d+VAM?=
 =?us-ascii?Q?d6FlLq/XcEpLG+4ZEw63XyUDTVvWJatySnyZjG1CXOtJuSY6hVE91RGqwT4g?=
 =?us-ascii?Q?lBmgRbhuTUDaNoADCQgSaazXCPdg72LVCBjNz4QOaxo3Gf2oWIa9ziXMVB/W?=
 =?us-ascii?Q?L4PrRI5v3wBJg1ffpKHasei3yb+hNd0qXtzXjMmH963PqMI/1/L1RCyrd3My?=
 =?us-ascii?Q?uACdOW5Yk8npkUkQJDxlfcPuMBZg+RSg?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v7aprIDvszfIo4DqCUMg4yOhoN1+Re1Rv/L1PGVqTVEbE77iVK1EvnIxduv/?=
 =?us-ascii?Q?5qdRf3GUv6G4wSxbUBeOJNcTJGr0N7GZS2/8mZU+thejt0s6+BsNV7ec1tV1?=
 =?us-ascii?Q?qi9bFBfSeQI9/WYQpO1DI7+hcUOaKQ2WmeFtsQcYk3SnA7gq1BrmloS9/0dv?=
 =?us-ascii?Q?TbswuQj4AsF/5j+o9pYL7Y1QdR+7SO9sLut+YELOOhHoT3isQUO4KJiOPt3d?=
 =?us-ascii?Q?ihH4XlyzzsP1fJgmJTmZqLXCkiTNDHX3/IRsfchiATXq/f0aDxeH7fxMinaX?=
 =?us-ascii?Q?bBVM/z/PCm/on0ZQ23F5VdWmSF5vQo9UCowqfPu+dfZIv6w/VaETIw85ToS5?=
 =?us-ascii?Q?4iTyhImWADj0cCqXKQkP3/W2+H8Wgq9zTeGFfNyQuXBYzLWLG8t5muNZ1MEu?=
 =?us-ascii?Q?E4RLv+4QYyqpju0jSp5kE0v06DfjCpizPwakAuOvIj24lwqLZTqT0PZE0l4Y?=
 =?us-ascii?Q?z0LmIfqqIYUZAsdBbyedV+eRQnEc0F2jGpe0gvfSZBAyCjrXWIAyxO835K6L?=
 =?us-ascii?Q?ayy7Z3YyH7ThR6xPsHlK6nKQwvgfS8XTMr2YOXQgXuoKMx6VKSd4dkVYXsO0?=
 =?us-ascii?Q?WEfiGoPKwgmk1VKCm/mLtSlHRFF+P/cTGEzwlXRk0n+g2N6LK14pksGSUziJ?=
 =?us-ascii?Q?h8ESrnbV3HzYTzbk7j+jc3eFUAb7fmALJ/RqY7NhtNiWX9Dl676aAE6Om0cr?=
 =?us-ascii?Q?Nmw25bqg6Wwj7eS/5vkYaIvAzs06vum7fiAae18p6aBv1wiBtEx2DHOXRa8i?=
 =?us-ascii?Q?9p1g6UHVZepzaqw+guAvQuC2Qmr5aKTbA5nrD2P54Ji/ILhBU+Td9kwDwYup?=
 =?us-ascii?Q?aOol0R7Zy1dgpGFZ2eDyERrZvTsDrp3Y9Qopc+JWuvCjqAE8HzofMfHBNxgk?=
 =?us-ascii?Q?3LZUknHcA8/dStQqZtdrAC76D4VrjN3teQk1jS94hkSxxeWOTTbCqUi9S77E?=
 =?us-ascii?Q?PLla7G7hpRErly9HTUEsHQvSWiu8zLjsB6Ei8CQdTzDA7VbfnH1h90PM/Dci?=
 =?us-ascii?Q?H4ohEyBWhfK6+m5Vf/4NCnQG9LNC+zuXKw9gNwSPx2r/LpegCM+OvtrP0NUX?=
 =?us-ascii?Q?5vh/NwzzMdeJe1fkHtLit30/iuhx1tSIUkm8CcDPn6mMav3npgrzgO47nW8P?=
 =?us-ascii?Q?SBZ3fdpVlPzLWAP5hYm/levIwWdrctbcaw/9IWYrHYp60DrgyHfTPvmjT+zE?=
 =?us-ascii?Q?0M07qssZP1NYPhbBmXKTdlPopmjEWqgPp2cbfQ2kGeCO9lit4Gm6pn6m55B3?=
 =?us-ascii?Q?neihVcLaHPYLYjgR8FY0ktzXWUsth8AHklSbQtOgwodY+N79HFdEsKbefgqM?=
 =?us-ascii?Q?9H3qzhcBBoo1g8d9C02QCiEiNQTf4N+uwK/Tl4Acs9LbA11gMglosiPIlIjI?=
 =?us-ascii?Q?zegm5TcIxIRKI8JfaMn0NiDld3001oakfalfdzlVpas8cizN5M6flXEUiK3B?=
 =?us-ascii?Q?I7n9ncR3v/aRDZmYznKzXbp74iOwPhBvfu94EDRiMx4Eevk0WPJ2x44AnZB6?=
 =?us-ascii?Q?ItN4fWm/caOe3229T1GnicWW3JlPN5Ut56O6VvuQxMFn8PuDDKv1stkq1Dcn?=
 =?us-ascii?Q?KUH5QZG4ZbIFESiGNY8+hSNRnQHZB7HLSqjiPwDS?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2926.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf12ef6d-ee7a-46c1-8059-08dd2f386dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 16:29:16.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNs4IiB4abYGKrnamFgMxeYxoRBp0h1SpmAsNQEviiciqM1oaPrtil81yvoNhMhfvSOCNcaw5LyDvQsYjExImhNJfG+dQny8z0xMvhIfW8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7634

Hi Rengarajan,

> On Tue, 7 Jan 2025 15:10:21 +0000 Woojung.Huh@microchip.com wrote:
> > Hi Jakub,
> >
> > > On Tue, 7 Jan 2025 14:14:56 +0000 Woojung.Huh@microchip.com wrote:
> > > > Surely, they should involve more on patches and earn credits, but
> > > > Thangaraj Samynathan <Thangaraj.S@microchip.com> and
> > > > Rengarajan S <Rengarajan.S@microchip.com> are going to take care
> LAN78xx
> > > > from Microchip.
> > >
> > > I can add them, I need to respin the series, anyway.
> >
> > That's great! Thanks!
>=20
> Could you share the full name of Rengarajan S ?

Would you share it?

Thanks
Woojung

