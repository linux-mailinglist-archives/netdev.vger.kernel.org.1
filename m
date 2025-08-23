Return-Path: <netdev+bounces-216229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C338FB32B69
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198CF56474D
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 17:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15F824A05B;
	Sat, 23 Aug 2025 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d0RBMFZw"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E448F40;
	Sat, 23 Aug 2025 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755971849; cv=fail; b=SDlDpHofvsvpuOz+kj3ZotNzO5n4uxkqRwXX9MyGJJlsj9Q1v9sDqMoFWA2zX0q7lNGtNte/6teqRo5x0Gawo+UihUzJX0MGglbzjZTRmxMUrHtcx6RK5REMSn0b6rphLDs7zmfkQCg0l9jrxv0PPRbahGp7PP/OtNt7KmPyNpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755971849; c=relaxed/simple;
	bh=cRvpuU6zbklGRJkPA6rcEWZdXjmXfXJ66Rywup5f+4M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZE89gTjIMa2QszhA+b2mwN2AovS5C2S1G8879uwaIhr59qtssK0GnByo8FFU3FCmsmT/R/ccCmx+a9fO2WyZbUNCMSMrc6Gs+YYXyCPEAfR4VVCVFe3UEmj6EU7jngKXVSYGt/DnijR6KJd8gHessj4ehGDD1LC3ymSLVJccDs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d0RBMFZw; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9pQ8LhJEWvESdsmbhmFCOUfBY0CIfdjIk1SqIgQMeS7Y5Ui7FYnCRMKfqRuumOoDir5iw2KIe8qSwnMYCMIDApsu3azwOCcVpMuZMhkpaJ6h6+yuUa7JwEVkAQeW0BJ2rW6MlhzbRLzP7v/h6/VOMb1alPOxRNITt1j1czMytAEGHJ/rrlIV2qMrmD/ZspRp6U1qWFe5IdS08J0hRkKDQtpn0mr/BLXEZwPUOVORk0d1tJTBn/yY0M0NeePy6J4lvTXnPMy11bNKPIPkE3i8h2Eobfo9U2jfVVDh/p1YJRPzhYrVXRDAKbqt/u1iVU5jDa6b49gVPB/uXxwGuqwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvrkDjBqQZYO7eybhgac7vsBqXIcBAzxEwliXX0exNQ=;
 b=b8pUBOnB+cN5gYBIGnhp4s5zCuw+aFfNa3Cp5dhDwvd3VezfrNjbgLeLcsUrUaNTvvL1cDm/r4hbGIoL5GIa3zdC5BaCzOpDcPPH7IoU36/kei+LR+xqcQUesOEZgLdeN6l4gMhxuFkKi/LLL3fJLXXOvyIQR4pEB9nS4T2/uN/Z7RtTo/YiQ8/h+c2mDD4LANETjCg7okp0Zmz+CKUxzdJTnj+0bmYpuYE4e0P98iapijG23pcuC3lkfLKrH6EB5Cab604gYP8fc6VNZOoX+oEOEzqeflhNpJnM76HcxmXqIEsbmAMDD72XxH82ezxPWyM7RCo/9rsln0jC4GK5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvrkDjBqQZYO7eybhgac7vsBqXIcBAzxEwliXX0exNQ=;
 b=d0RBMFZw1bC4eBUTeJd6ffC90RhUa7K1rgHghjTKKHfFkawDVgCNO0G/e3+YikDP42ERnZwWZZ0qoRFlrdBRgdB9lqw4m7s4t/haS4MawDDkHlU+SgG7EKHEWmtiu3PzlXgwo74pTWjCJJMDRzKVG7xma347BXfRln1NR9m159M4ABj0krrci2zb3v+jN+fRf/VTtS5AXxTIpyfMupgoNUS0fUXn0bzVOnGT+tJoN5qS78H9UZujNeBHxgTNCqkOr6kvcchTI6wtiqHVyZJbBIDfpZbnv/GSU+cSFOaDhVyX3KrTFvG70qUt3/Pf5U+bJRY0lELmXa4bN8MLemoZrg==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PA1PR04MB11358.eurprd04.prod.outlook.com (2603:10a6:102:4ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Sat, 23 Aug
 2025 17:57:24 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 17:57:24 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Topic: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Index: AQHcEso09J4T5pZDZES+itLWSHrcIrRuXGoAgAIseYA=
Date: Sat, 23 Aug 2025 17:57:24 +0000
Message-ID:
 <PAXPR04MB9185F42CDE16107E3A29FF0B893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-5-shenwei.wang@nxp.com>
 <PAXPR04MB85108182AB184083B5F32D3B883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB85108182AB184083B5F32D3B883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|PA1PR04MB11358:EE_
x-ms-office365-filtering-correlation-id: 8b9e57e4-5acc-42a6-fffe-08dde26e83e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BOaRRkG3UJ5KkpPbuDwmfweMioS/ebXJEHngNsOXs60LsU+KEWN1wddZoNaw?=
 =?us-ascii?Q?+4XZQUfVPTaWuZbxPpeaREZvQv1qSB9/spTiEer9p2jK/OVO/spGl/Kf4I8U?=
 =?us-ascii?Q?jpCdybAe6Lo8jsJDSnC1cVOmZFGbdpfD7D6gpeWGCZ4b7XHswje82Ho7+1oM?=
 =?us-ascii?Q?kkQ1ciKcHy83SQ1BWQx3myPY/SwPn77kFR8xvCOeYH4LCFd/S+kJAtdev9jV?=
 =?us-ascii?Q?m1TYR+LMw0UHUGXwCD2PayF0qq2tAKCzneF6YEMByjJ1ccWCzwqUhkfNmWvT?=
 =?us-ascii?Q?rrQ32kkDmXg+odC20+QBoU2sciy8eSYx4Oh3N/mzt04vuZ7poq+/XEiPkZvH?=
 =?us-ascii?Q?MdTYYYO8WMR+AX2rx4Gh4PRbwnoXusrrgeTJfvM8+xBsjpTtmYm99Ukvp2U/?=
 =?us-ascii?Q?pnjWN4gHSF7OjbOC1HtB0okrvLTS5rmryfR9hHzsjQ58OGVyQSoYKN/KGkiF?=
 =?us-ascii?Q?+hm1lTvfregK77zSf00N4+w/Kmak/xyj7OpSrec97SYN8eTdkjSIWmKrlLti?=
 =?us-ascii?Q?MjLDBUeFUU6+6iBEpOehAeAHBRY83+PGJIbmgMyCICIc1lPtTZM3La8cl5Nf?=
 =?us-ascii?Q?Miy4ms5H5pHxngc/LpyjjCJMKC46TRmtfO0NKVsqph7s/YzzQxc7a3FMwvr+?=
 =?us-ascii?Q?7MEHACTCejmd7hknwH6WKBmhxgzGPVXZHdNpu7zXr0y+QUAfY/0CUaq7iEGV?=
 =?us-ascii?Q?oTizkfq2/kHepGHoO1hUNCUZ2W+NcwfGrWCkRm/07OqsIeZu2eGkv7mHZADM?=
 =?us-ascii?Q?qf1TtsiKuqKGmVbPa2h4WmTDGyk6e2BLnoSAQMvjPtGXWyDLU0Ukfym0OcU6?=
 =?us-ascii?Q?PX/q6HP2NLHnU5S2GGME1SuaU6a0Y9JoRjJ2VhAp6ewICIc4ImAYq01lsnWt?=
 =?us-ascii?Q?JrAXzkj2DGszDekQDz5FD/rxigHh5oaWGVVc+2WR+BIRoMmjlRKysHj3tfiO?=
 =?us-ascii?Q?bcPkuKA8LSwA4rTviAAbYoRDEuDCO6R59Nuvh2a3FPysSS6vJxJiNr0RaSmz?=
 =?us-ascii?Q?9u4sr0pm/KpoZcxUYpqknTyuQhSn7cNylw49rFGQxU77UXsraGm1t83eltJM?=
 =?us-ascii?Q?uku5X/twliMlr7PM2s1JTGUVWfM9S7j57mqQZGkhw/G01bM7usJ5Pk0PToA/?=
 =?us-ascii?Q?xzsWy+VSwNK+znkIK4KH/jEaSoLx3QHobaElIASSNHBx5AYDx0atqE5YXMmN?=
 =?us-ascii?Q?Ab6jRc2C3zCgKD1G5Ze5ixttn8c2351nRpcsrn3+MHetn6qa+HzNba/+NCrh?=
 =?us-ascii?Q?pjb8zGXs9YPnpTaIoxyJlwdIVdwKpb4JBtBTTC7XyP25yH3SVbqvteeghDLT?=
 =?us-ascii?Q?UPeutUoAV3nhyA9a/Fk2zGE8AclJ959IwItzL6mgB03vFU2v3mP1pv84F4wz?=
 =?us-ascii?Q?P64B3z1kN/j8wa+OnvkJnfjqO+FY9C71y0ibh7e14hgb1O55DCzforXXHkUQ?=
 =?us-ascii?Q?4Um5ANUZ3SuDw4EEIv8gzFsDcHbVC2xU0JXgQar6zcRjUdqgLzS9Yg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G2IEVkuEO7tM+J7TCt2h5vGZu0c1m6kxbezqBMZa9TY/4CgpsDHc6tDYxRP4?=
 =?us-ascii?Q?8m4btsK/x1UPOjbZ7K7T35Kn8ODe2m89PSvGppnf9/HQZ8BwWj9xrLYOOMoF?=
 =?us-ascii?Q?GivZz5qxSbRuUd90EsiQ0gBf/u3xYOn2rAye4mwQ6wqQOKBoH9zPvvxv5HAv?=
 =?us-ascii?Q?Ob3m6E9pkVr6QkHv3sF2xGOwm+9180gBk5QwwmhAyj4OB6hggZeKmCW3XXgy?=
 =?us-ascii?Q?Geee26ZYj/m626KaBzaPEgchPCtCd20UD4OIiVHqxheLW2QsWfNEb4x30XYY?=
 =?us-ascii?Q?865Jga6ak7lU+UfIt6gL1IvjVMeRXVU0Mah+0N4UykJD6ndxAR9IA3ErJeRc?=
 =?us-ascii?Q?XwMfSW14R8shMunv4rRcAFb/lBIh6yEqOM0ixzgj9OqGWO7mvbpgZUjgVzZ9?=
 =?us-ascii?Q?/MnchBn/xkcogoBU3vYHi/8CIqTzlb7l6NpoHcYrxw2DI5u/v0fP74UeQCg5?=
 =?us-ascii?Q?U42IdtsLY4eXUdetIGFXY+QfDaClv+5KWXVqQX7/KugCaDqNDYJtf5BX7PZL?=
 =?us-ascii?Q?At3fQaY7vrARd2CgxqYFA3WO8f34RPfQATkISULlkAtEXBzeTfIMqFf0jqxq?=
 =?us-ascii?Q?dtQv2YBvFmPx4DnDkluqDkwJ0H6GueQGSAU7YiPlwyEYJeGaw2uJDuiS+/FT?=
 =?us-ascii?Q?y5XvFy+hLswNpX8EmqFAyViAb1GTBUq3PVmWl6YtBH0Zl1eZbtYjZnwcg9lc?=
 =?us-ascii?Q?uPyjs+14KhKMfSeM4XhJUrQg8EBd/3MHzM7h6rzfD+9c7UaeZtIwW0jVjoIO?=
 =?us-ascii?Q?TqV0+NUn9B+c4MIUGdt1+1rWMd/L+QPIo0NkxlA9CzYTOZK1Bh6BStdiqGXn?=
 =?us-ascii?Q?yXBlkt7w54KPtBjI/xpn8Wl5pwBd+mJ3iBER+W+vsox6FoEe1E/Px+cZtoYN?=
 =?us-ascii?Q?zMYKMXYPY9tm00DATI39NxW2s4X3pX43rJYweDXWCrA0WL7rxBHSVxkw645y?=
 =?us-ascii?Q?2Pv+/kqLkgSa6vcOlcwuoiHzJlrLaL+wAAacbzhfXtTW3jOHORB/sPtVQmzb?=
 =?us-ascii?Q?mYcEt+8qifneZSEQMhE9nPTXtR1YmUPx5aw2ZRUqLF5IlkBwDTbvmZmqSqw9?=
 =?us-ascii?Q?HD+A4kvFbFBf787OcLwxG2S8UratDtIFkA0GVCDW//OFh+4DYd6UQy70ThXA?=
 =?us-ascii?Q?hEKLtfoSWphfngMNPGUQAjk3y+DXkTnKL49Mce01NlNGSN5JfrDaTp+p0Bm3?=
 =?us-ascii?Q?w5fK8SQeORuHBCjXDmroPJ/0dIk5Jbl6kWP+Alh0TUvJYhjiHCHg6U1Xs2Dr?=
 =?us-ascii?Q?BBgaGeDwZpoSO4SoCdKJTg/E1CzbrcVY3fFMcNmibJPajmFBIkgQG2CvnNmS?=
 =?us-ascii?Q?H4+TEAyWC/+uOvmdsUoWO4BhbcZcXRksT544LLrF4upZLi4enyIHUpgJtjZ9?=
 =?us-ascii?Q?CVaDr7LCeQKJeaz02nie+xKPTBXF1kvRD4NPOk4i3c20yIHUVgvyPfiTB8GJ?=
 =?us-ascii?Q?adap7XY2oEw6I+DG/efLBHus1Kc6JpRb3bfGrRqyE4NPQEOftAHcr5zXUfzv?=
 =?us-ascii?Q?+FXZUsUd7BzkaLczBOGPBaQZQSvc13LX6TDfNeSAQQu/04yeltqkuvkQKuOr?=
 =?us-ascii?Q?aPQII2+cqJ5YGcPui2Y=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9e57e4-5acc-42a6-fffe-08dde26e83e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2025 17:57:24.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XyauQrNrQrbkHhA8LewgSlwV2MRJ6hXKvQqAzKyLKni4NdNOC8xTozCzy7bQHgxnFaxMDw42mBvoEFcIrzzkFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11358



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Friday, August 22, 2025 3:45 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Clark Wang <xiaoning.wang@nxp.com>; Stanislav Fomichev
> <sdf@fomichev.me>; imx@lists.linux.dev; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>
> Subject: RE: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
> dynamic buffer allocation
>=20
> > +static int fec_change_mtu(struct net_device *ndev, int new_mtu) {
> > +	struct fec_enet_private *fep =3D netdev_priv(ndev);
> > +	int order, done;
> > +	bool running;
> > +
> > +	order =3D get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN);
> > +	if (fep->pagepool_order =3D=3D order) {
> > +		WRITE_ONCE(ndev->mtu, new_mtu);
>=20
> No need to write ndev->mtu, same below, because __netif_set_mtu() will he=
lp
> update it.

It will only update the ndev->mtu if the driver doesn't have its own chang_=
mtu handler.

int __netif_set_mtu(struct net_device *dev, int new_mtu)
{
	const struct net_device_ops *ops =3D dev->netdev_ops;

	if (ops->ndo_change_mtu)
		return ops->ndo_change_mtu(dev, new_mtu);

	/* Pairs with all the lockless reads of dev->mtu in the stack */
	WRITE_ONCE(dev->mtu, new_mtu);
	return 0;
}

Regards,
Shenwei

>=20
> > +		return 0;
> > +	}
> > +
> > +	fep->pagepool_order =3D order;
> > +	fep->rx_frame_size =3D (PAGE_SIZE << order) -
> FEC_ENET_XDP_HEADROOM
> > +			     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > +
> > +	running =3D netif_running(ndev);
> > +	if (!running) {
>=20
> running is only used once, so we can use netif_running(ndev) directly to =
simplify
> the code.
>=20
> > +		WRITE_ONCE(ndev->mtu, new_mtu);
> > +		return 0;
> > +	}
> > +
> > +	/* Stop TX/RX and free the buffers */
> > +	napi_disable(&fep->napi);
> > +	netif_tx_disable(ndev);
> > +	read_poll_timeout(fec_enet_rx_napi, done, (done =3D=3D 0),
> > +			  10, 1000, false, &fep->napi, 10);
>=20
> I'm not sure whether read_poll_timeout() is necessary, because I get the =
info
> from the kernel doc of napi_disable()
>=20
> /**
>  * napi_disable() - prevent NAPI from scheduling
>  * @n: NAPI context
>  *
>  * Stop NAPI from being scheduled on this context.
>  * Waits till any outstanding processing completes.
>  * Takes netdev_lock() for associated net_device.
>  */
>=20
> > +	fec_stop(ndev);
> > +	fec_enet_free_buffers(ndev);
> > +
> > +	WRITE_ONCE(ndev->mtu, new_mtu);
> > +
> > +	/* Create the pagepool according the new mtu */
> > +	if (fec_enet_alloc_buffers(ndev) < 0)
> > +		return -ENOMEM;
> > +
> > +	fec_restart(ndev);
> > +	napi_enable(&fep->napi);
> > +	netif_tx_start_all_queues(ndev);
> > +
> > +	return 0;
> > +}
> > +


