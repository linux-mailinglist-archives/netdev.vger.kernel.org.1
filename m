Return-Path: <netdev+bounces-218967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A4B3F1E2
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 03:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0100F189CD11
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 01:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307FE2DF152;
	Tue,  2 Sep 2025 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f9V/Upxx"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E426C3A7;
	Tue,  2 Sep 2025 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756776565; cv=fail; b=kxj8wFmqrJNF8WUZvFGpD1za/Gwfr/v6leKigxD1+YEZT2SI7ClV/SY894YF3u4mnk/uB5cbEOjsuD5H8oOeELtdnHRfGvBrYPIeh5vln+kt6OUmD2xaMBMMla4N9LeP1fNQSK26skIqR3vwitPhJbGsl+foF64sUKy3uc/LPeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756776565; c=relaxed/simple;
	bh=YKnoX3DqF7vI1j2a9fMVaKKwuOMJSvgGDoPSd1qMd/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gxVp9h1YtMrYBRsRPAO405rHFppi7fafSSlHv9FbJW716uYOBqaeRt4o70wimxbsaa4q2RxI+VEYFEq2dGjBoyouygT+YlRTGRdzT1NOnDfkhbQdHzZJzuX61w91X4M/22kDgPvUG0+lzklagdJeLi7WY9iHboOlpXUVQPGqj7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f9V/Upxx; arc=fail smtp.client-ip=52.101.84.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jks9gDLnnYrexdlPmi23Z95Zh3L4PNOsnwovXJxwYQf5vQLs+KlQlN3KITUL+r0E+IEuTMuIJBrUG6qDTPyvHH16BShhucqkvEnepTlYQbIiVaI38V5ANpOQWdRjX5pBV2telG3fz6C6LF0mM60jGwKHY0ZedH2DavXpWxnSvk4fE6sC1NdJL1rELraADAqhr2ZEyNCE7EAx2QGkOYEczbhFKb12znrJChGrnQ4KopjcT754PcacuFPI910aiNx5vUSZS0IDibFAS5jI87G05amD8otfIh55ip5/lvg4DhZW2HoGhRHM/nNvjw3yBoit9ogjMNRxfNplJdD8CsgbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RmkRNb0ACh0e0yPZWr2PmPF61/PKVBrMa0jroa0/AY=;
 b=lFyi7lYIUI07OP+meuq2PKfwsy/0Q6tUdqxztGNuHA1NVe/BF6VfFekrAqPdoKPQK1DjMif/6SinnmzY3SDiUvWP8sNnXcQKvU3C65ufyHie9bcQRCvBap34BQpC3Rn9bd62nPrwyLuyWZQr/B+SVQT3PsSwrPzE3HLv6xdXuE3vN/9pN/HrMsvLUbmg2b7KoEACcWwZ6tWm+YB04ZJPVa3pVohp9pxulz6w0EKHtrQagW/IMD3EX4B+fzWdAKasUiBCSy1V87BKoEKiRIGO2MPiFc1J1VeMf3opZI9nB1D357eKroi94XAxGoeIiAJ0pxX7PTeuZD2mao4EQMKzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RmkRNb0ACh0e0yPZWr2PmPF61/PKVBrMa0jroa0/AY=;
 b=f9V/UpxxUrDDam/T1nBmliB0VzMbRuIHqv5CnorFlJrKwj9XOSxnP/OVdgQjL6edQAV1Y3ke278X5tExOo4y165DM4gDFzBYm66f/wNGcEfY5zx2PzgwaRbNfSG4OgFMdlPt6pR4oJgDCGx/bGvYi/aGqY92XznuNFzQG7zJolEVHUUj53qfWiKnhDmkeaIkiCL5CxaRjUxkf4D0Oyi5OYFPJ2sI948nz7YNlvYKRIwXlYKVrB0gWvnSr8K/SkEQmD54o00/IZifLvVhoEzVjQQeTTQL7c2OsxSrrtJHfWOiWXjJuK3N1S0HD4qVc0QHS/bhrvuNW8qmInyLOhig3A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11410.eurprd04.prod.outlook.com (2603:10a6:10:5cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 01:29:18 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 01:29:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v4 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Topic: [PATCH v4 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Index: AQHcGryO+DVqxyerjU+TUjsu8Hl/y7R9k3vwgAECL4CAAIWD0A==
Date: Tue, 2 Sep 2025 01:29:17 +0000
Message-ID:
 <PAXPR04MB8510566654C4F2D9CF4576088806A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250831211557.190141-1-shenwei.wang@nxp.com>
 <20250831211557.190141-5-shenwei.wang@nxp.com>
 <PAXPR04MB8510EA7CD915DE9340303B0F8807A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB9185E35E7B53836BD9261A298907A@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB9185E35E7B53836BD9261A298907A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU4PR04MB11410:EE_
x-ms-office365-filtering-correlation-id: 49acb62c-91d9-4222-d167-08dde9c0225e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|19092799006|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?396QlAOz4+zEQLvuQDvYA3GvHOqXEjOr8bj4B//MIASzyAI/mFLi8miyfM6M?=
 =?us-ascii?Q?svO0ns2FZL83uh7mDNhl7oGutHbOwisgpvkpVjgPNnbYevjF8eLWTvZs3I/U?=
 =?us-ascii?Q?NMKJ0wENRo0JfUtl5oEL4cs99GqqjLIfZjbvFdRpsNU/CqvWyl3VLC5cVTQU?=
 =?us-ascii?Q?B0Bj5ajDLhQDykqttnNF+a2zE9m/bU4oF4qs0MdsOqAaxJUd8yGcpMzvEyu0?=
 =?us-ascii?Q?AtBTtbiNuKA9lm+MtAQDXXGfORQNpaiPjx2gk9r3vdAEUxMh8Z/ums1KjBbH?=
 =?us-ascii?Q?m7QWGYJqU9m2B7jo3J399awUoUTC4zC1ZblP2JjD31bRt1YpNEBTru+oZD2K?=
 =?us-ascii?Q?hjlFlC8/1+IoaGeir49hnkAB8+Buypczm+1vNPGZPQhl1yohUeBil0tYY2lD?=
 =?us-ascii?Q?W28cp27ObrdpjR+GAUV9nINLCQkpHtxjQBdicJLIlveblnWHUlist6Vnvkev?=
 =?us-ascii?Q?k5f9To5Opg3HFgCZWl7qFurdxKfRXdRJ3JTeOG2HU39nZC5wTXtXcaohui6r?=
 =?us-ascii?Q?x608RmlIesdj/1Wlhl43yHLbDyundvBZNiVwo42oMgknjOFWB62VBkonp+l4?=
 =?us-ascii?Q?UUAnDYs9zx6v91jINX+EGNzM7eoTtql76KWmsUP2qTJgc7JQ3eeo78eiEFdh?=
 =?us-ascii?Q?2xARCyk3kCpfIFeN9M0h+V3P5KIfhVQB1HrxXiC0EgFMHEcx8OnuocQPvIdw?=
 =?us-ascii?Q?WCrwr4l5/Stuu3t5cUPk0Q+5U1R2ccmHCd42qkQdOkOlut8+Trh4SeBKxWXK?=
 =?us-ascii?Q?5EV9HIHYXS/HvmGaHQ/AUX4IyToJNuDqhUtyU6rrgW/ag4LoLZTFMWvoMmEG?=
 =?us-ascii?Q?31nJydrP6oFzEmPlLckurhNR7EJSdM4kS1vdfZTDNtVEfnLxoa1zxeHG/nid?=
 =?us-ascii?Q?tgFkmoboLJ4fcIEVWZESuC02GQIzw6KHh42NdmuMaEHZnbxAh6PcV0rC8/fZ?=
 =?us-ascii?Q?Gt+UNNynfuqC6EsI2gjn9YlrND+yhI5M2k+6ezZHo6AGZqxvKAHsJ8WTtKOv?=
 =?us-ascii?Q?QL1w/IAANrEMRaKKU5gDIeiQABSOs2x/GIc4jNASolUMQJgdFUqlGOY2C0Yz?=
 =?us-ascii?Q?zeWuGkJ0xJhmaBGrFC1NxxjjV3v8CIU2qBhr+V/UNz62gTQneGHvlrM7r27T?=
 =?us-ascii?Q?xQfQmcTjQR+GNIbin3RQaU2AtYE5WlPHb/9+O6+QmvuYA8Q91JRh8T1edhBv?=
 =?us-ascii?Q?IbsF/NmoizjVIW9lyk/50Sdr4NLv7w2rs/NqsKhtccChBu/3nmWbUSa0mk00?=
 =?us-ascii?Q?91QsTBDOrEMSCEurPOL8A6ooIh2rXK9wYSqAyJ6Kd46IJDzQBHNB42hPSyCw?=
 =?us-ascii?Q?00hVTsjqXge7c2wDfHXYqf+ECupoozNyxtn1mZdgd+ZiqIcNgOdJJSUtMkaK?=
 =?us-ascii?Q?+SQsmkp2yDDuFfETKRGuU7hBNrD9mePbqeuMnSplxEtNVEfNuMTRI2pI5Ska?=
 =?us-ascii?Q?gZq4rjrrGHEs1Vbx0N5dHcsXM8Z/sGXle79ElFTXhRwkvHa3Dh/UrQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ocUTZ0pHvtNIMr7ZCIwwoDippCM3lEPy5xL44T02bxlwZy4iG+eOcAwGtAxU?=
 =?us-ascii?Q?jx/FLjU2bHauGy4jpFwvX2KSVbd5RqaihD2PT0rrt1cHD7wVyDuVi7e3Jn46?=
 =?us-ascii?Q?AO5cjKDzNtt435t3nY0y766dKQeOg088kRwTl6Vtm5QWWZXwrRM2naLVsVLv?=
 =?us-ascii?Q?n3jWvY8E+KWgTFBU7AEb40a+iznySQJBtCU1WdM+0FzuPNAQnPmiv4isKsQM?=
 =?us-ascii?Q?ot9cxCNZ6OkjYWq9LrNDdvzGaYBWKtWydnMJV6vLQvNzAaGSZTWL0P+zCNU/?=
 =?us-ascii?Q?a9ghmfQol978ZxKdxvNt6Tg75PZZsDHP+joa3ayPYQs0lSR5OO4zmf4sMz5n?=
 =?us-ascii?Q?aqXba/el8x+7qvr5BhGIgTIOlh4S342PC4dDjr+9/QqA7etkq8X16HHallLo?=
 =?us-ascii?Q?ASfBi4sl7LZqbxmjPlDYrbIgd6MflwMieVZ/Sq0WdkOz9J+9mFwRmPQF+/XI?=
 =?us-ascii?Q?3LNghffjzFNFQZgEhLI71criUOHcAHrdJk+BGfpv1ay1he04UCANWlORLz+A?=
 =?us-ascii?Q?vwuOUh6JAbRFPQB7HMJq5Lo0KuUOUtjRMdXMMSHLkkcjFCsWvN7uWDt3Aw6T?=
 =?us-ascii?Q?QOaUFUNlM7VkneBmYmN6xO4SPRcNW+mavh0qTnQhJeh4lssEjHgfu/3ZhYpD?=
 =?us-ascii?Q?iCbvy1UkjmJENmJZg1gtNBs2foyrI2nf3RVycQU4hD8uPt5VJ4hJAFIh0RVQ?=
 =?us-ascii?Q?wfCX4dqhWpcJ3Y2Z5l/vpCENcWDdzcA6KcbMhsfEzPVc1tQn+rfZJ9qPfa8G?=
 =?us-ascii?Q?kCBEIl5MMua+vcnJTXIymPSJmms9KfcKXBgvDdpyWrPwrlxJI0w49OakusFA?=
 =?us-ascii?Q?Zx7XysZNj7QbICGfNttwVK3ZYnRXCpzfsk18AFPYZqIIY8E8PLRgEjXhVD48?=
 =?us-ascii?Q?2anSDrOt9rH3m2h/sG8XPMBzTMmHWR5rbeXBKf5SqvmWtcEWDe+6Ud9APfZ9?=
 =?us-ascii?Q?rYfn0I+Y1EMHWDYE2irm6Wee7KdlUcrsiL1LIdk4gaShHrq0+WHTajqWZtK+?=
 =?us-ascii?Q?ElzGw5gdp+q2Dt4hEaynctgGCEcozo5T+6ubqpRy4bOLYb3eNUAxRu1R3wZR?=
 =?us-ascii?Q?wjKqdr7roonzfrUy4P/gh1kQ2HBg5bwYtsRQQZS86snzmbd+20fi1ZCCmjux?=
 =?us-ascii?Q?i+ILYJjijCcpcmXEINKxTNvjzar7DuBoXy8DRn1A3rYXrBPG00efkw8SdjkB?=
 =?us-ascii?Q?EjquDXKbSYmEh0K2VTrdX/2gc7GRhMnppt1ttLH9+i8/BhwMvQtGe1+8VF+y?=
 =?us-ascii?Q?t7TtVvpqc13nUSyCzYuNn1GVd0gEK5CxDejSzBDwD1Xla7E5nN/zXgNhsSZN?=
 =?us-ascii?Q?FuyS2tIAoWLiCKLjDT2ISyeUUl/epDlOEyYakOy2JhlAT1h+Xdu1faZ18ytv?=
 =?us-ascii?Q?IIn8GnuNjrZbmSYVPv7GbosudxMBqJQpRjwCtMFNwkEBeMHq3j7dCj+YY2kA?=
 =?us-ascii?Q?tRAAhVg+PeSf2RCrhENyTk2AFgc56m9EfRO0cBdY82SRNYkN24oxY3/W0afo?=
 =?us-ascii?Q?MQcjiopD6SVq+GEeYF/PAnXF6ThdGrxide2gW/R2x3p6j2UjvWCWUIE+ssXa?=
 =?us-ascii?Q?m38T07whT2RyAMe4fWw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49acb62c-91d9-4222-d167-08dde9c0225e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 01:29:17.5833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f/Gcapv7aC4MMV9Zti/FYQ/sHWqRGPaAcBxkgWdEWjCc1RqS48KEdvdIbJFkadP7FOyl3FQ7Cu+JtjxZolBftA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11410

> > > +	/* Stop TX/RX and free the buffers */
> > > +	napi_disable(&fep->napi);
> > > +	netif_tx_disable(ndev);
> > > +	read_poll_timeout(fec_enet_rx_napi, done, (done =3D=3D 0),
> > > +			  10, 1000, false, &fep->napi, 10);
> > > +	fec_stop(ndev);
> > > +
> > > +	WRITE_ONCE(ndev->mtu, new_mtu);
> > > +
> > > +	if (fep->pagepool_order !=3D old_order) {
> >
> > If fep->pagepool_order is not changed, why need to stop TX/RX?
> >
>=20
> The purpose is to update the MAX_FL based on the new mtu.

Thanks for the explanation, it would be better to add a comment here
to make it easier for readers to understand. :)


