Return-Path: <netdev+bounces-216251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB61B32C12
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 23:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF309E814B
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97B1221FCA;
	Sat, 23 Aug 2025 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ll80zdvF"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010027.outbound.protection.outlook.com [52.101.84.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA9A55;
	Sat, 23 Aug 2025 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755983943; cv=fail; b=ERIX5PFVu+JkD0EDcDAHzjHUgoYNhuojUVU9hflCS3nwVo9KqXR3eKM7jKbaEOkdNEjbPsxbm/uccSf6l42epMI8/zgutXBQTJlIheowkgZ2eW5WxI+m9meU7PpsH3FyJZ1k7eYiry12IcW7UWrw9O9RvpjbwMDrTiaCOo7wXDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755983943; c=relaxed/simple;
	bh=R+ZpBdZx1QxrcDl/NmHskajzsmdtdcA4Wn0IrgECh0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kb5xYTMFDnJqkhBQcWV106jbBg9BPyubl/TsLJ6L54I3pvWqPqqL0b3dWQnPRUcUhn0ixUBvVpzCtNBip2f+LR5t/5PrwzLrmskHTdK3KseZICNE9eD221OTSc9BAmYsRr349FuGf9Q6GDLA8TZ4eNt7c1YuwgWvNOed0Z/dLMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ll80zdvF; arc=fail smtp.client-ip=52.101.84.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xInGcGj5fGUtTObkoNW9jx8QaZODF7NLcExYfQ0royVGE8BQ1iQ7zvO9FlAjAQ4dTo3T0P0dBnxVJAFNKqqY9W7MekiMCPFECSXLK3wYYfFI/kbV9dKcVYPiIGqwqK8FIAc71hvQLQa3szaTSU8z0qCuMyr6kmsKYaNbLJzknXVHn3NiyQ+Pb6BI8I0y3y2T/dRjQSynEAnL/BKVsJWh0dtxEPHVTq/fhTqvS4rAR/rey/QctRplb2zz6vQ8OQAB7ca/X9rwNmHoAZ99jE9r0+idbrXvZeY8z7CulhzxqDEqdTnGdSnXnx2r96xUEydNQ1sRQSjXXMhgy6DcxyAV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFATJolEbaBn1++88ENQ0R8DLU0NSsrgYZTfYhEh4i4=;
 b=m9q1WIV4QuaVzLKmH/s4xhPT1NcuGJ9fTvLjOLGureFiTLaDr1inm/GAmemkgfqUioKy7LtRuF5TS0DXQYg7MmRRNDCdJK0F8RA23cFnROkZYlDpUjCxHBaGvoJwrtgtomZhZVx39PywWa4exPMgItLgpNts9JyvAaVhJTwxk6BTl8kW3iPRVx/Z03VX0PH41gv+yG1bgii03hSNsl1t51frnuy7IVUZuIID8Z9hrP4noCHJZa+UBtD/xjjnNGdHVGttqRp7Xp5Uc194agcCKrYDwf3vfxeWfsY2WIGivY1xTxzCZcVLq279P57uWH6m8AZQuQ8HEl29FjosQ5Guqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFATJolEbaBn1++88ENQ0R8DLU0NSsrgYZTfYhEh4i4=;
 b=Ll80zdvF/dBfHjgeDXTiBXP4/+gb7VoX8N4GcwFs3g8qTwtGi40bqfoLmFlnLYIOdM3ToMwYy1XrKIN+LwDwhYRZI8BiTwV+VP5auU7blXxGu0xXkwXDYR70gXgnpyEC8mS04U5wJvzwJbfJC/UUSNvDpwW2+pG7h2VsACFf1FApYQilFjFwPb7JftbYV8v3bUmYGFHSAmroZEFp8iZcWe7A6Y/DNoeVSlWcNLva6E1a4pLPr/4pGKLwDIuEab3WJkJSTtfoo3RvuoXSpjNyPgIBSfWXg50+AcenM/RBox+lnLS3zmzTqOpznXxxyupG0H1YmEihH4mABSlcLrBPpg==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB7944.eurprd04.prod.outlook.com (2603:10a6:20b:28a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Sat, 23 Aug
 2025 21:18:58 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 21:18:57 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to support
 configurable RX length
Thread-Topic: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to support
 configurable RX length
Thread-Index: AQHcFHOJyhsaEQKFPU2s3N5FYBrGig==
Date: Sat, 23 Aug 2025 21:18:57 +0000
Message-ID:
 <PAXPR04MB91851EC6E79D76E8220C5251893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-4-shenwei.wang@nxp.com>
 <0abb2c91-3786-4926-b0e3-30b9e222424d@lunn.ch>
 <PAXPR04MB918577F27FD6521B23601219893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <6b1f5bcd-e4d7-4309-becc-de4a12bdf363@lunn.ch>
In-Reply-To: <6b1f5bcd-e4d7-4309-becc-de4a12bdf363@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AS8PR04MB7944:EE_
x-ms-office365-filtering-correlation-id: 3dee52af-e9bc-4acb-3fa1-08dde28aac26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LVbWjLEIOCJmEDzF363GKwv115Dywvy1yBAzbtzKZZWWeUvczmtL42bY9Akm?=
 =?us-ascii?Q?tPqC7J//6v95DpixZdEGNHCar9U6Q1tjtkl1p/E4eF3bJmgWL9vjWuqhulCP?=
 =?us-ascii?Q?Kl4UjtRU/y6/jILPGfnT68675k61heYY/shF5J9EizmezuGKylVskaj9VRSy?=
 =?us-ascii?Q?78/ljCzFhpjNyOS+tsT8Yhgay2XlDIpMXI1u3egNGrtOxj1Z7xB0Hhg7fBHE?=
 =?us-ascii?Q?pPSMdFQ0EBKKNNg7twVUNzYx25g8kKU+sqMq/W/0qZCvVQWLjC/W0gpPyYGJ?=
 =?us-ascii?Q?s/H/p5edwmtzAYNbwaty2c0H8vQ4+2dIyOXYU+mU2i16M86YTFGSPwO9Kd0k?=
 =?us-ascii?Q?OtTIr+OmKM9GOiXOT/5IEZrereAQrtGhuF9Emgmcfd+eXilngHUl9vKqXwmL?=
 =?us-ascii?Q?2oMGr+kDfMgB7RgIHZq0dPykYJb/s9Hm07JDAlMuL1cWRDrCi6QmSU7n0PXe?=
 =?us-ascii?Q?XU5RZOVpMkZh5EERIXD0w6Qjnqz3Of+3vVs1rGas8AOhQLRKl6OBeJ5x0/VS?=
 =?us-ascii?Q?AUoMv2datcA77C78f5j6aCtPG8uWZfK28Q2tbHVWatG0w9yd5GfBwwqOoxBh?=
 =?us-ascii?Q?rA0HzlqgkBQW8+l1DXIfQh0mlPPA59OWwYvZV8LfAdugvfxdM35xxAIT1M0J?=
 =?us-ascii?Q?ajElNWO6q2IWLDIdqrI5ceeP01QcO5TTf8p/C8IHVAmwM72cWDxUqCqvsjLA?=
 =?us-ascii?Q?DN7H3qoZOv2JInESQ//v8vCjHd1F83UsAKq5u5MRAUqewj+U/KRBmX+PULj9?=
 =?us-ascii?Q?Tf7mPFPtppfAcPKEiTX35J9/xz+hXdNU3frljEvy3jA5BowgmOVmBKW9nEPH?=
 =?us-ascii?Q?ymzmZ2LyHYPOwnGkM+n5yxHVfoih2tlfUa7bat42V9tFWj/KUqkZAY+V8bti?=
 =?us-ascii?Q?yXb1JCYz8YM0HLE7L5vOYIBDIhFImsblqVQjG2vl4XpNpXAZ4/+wIPKVFA9Y?=
 =?us-ascii?Q?JLLULCFijQylBJQk11THTducFq8PvlkDqp1TKBsShuGuUxaoFX3cpcl73I+N?=
 =?us-ascii?Q?cdB9hKPzbc650MbTM4K2ryP25BTDYutZNcaEphSvBuHktFOL0M0rxshKDkIV?=
 =?us-ascii?Q?RWCEMZwAx2HGo9me5jxj+O/tgNKNDDXj/s2iI+8TtZoU/TaJbNOtzGdtZ4k9?=
 =?us-ascii?Q?Ga1GomG7OG+j8JDrttRgpnC+7xeYvy7sx3X79ZBD/iInsqBNdvaNIqebPdW4?=
 =?us-ascii?Q?KLgRZ5sDXP4IRaHPHCTo6WmGn6or0FrSrhElhtorWPV7nxkRJtSKxzb8178L?=
 =?us-ascii?Q?ycI2mAuspqHTDGay8o0Wo2MPJSrDkIUhroWC0Zqo1l+SBNdPmPckOL1+WdaG?=
 =?us-ascii?Q?qm+DBvkyECQhrUjPrZHdUys5Slq+hi10LkSlwnW4h599OrKC+pE7liwJAN+L?=
 =?us-ascii?Q?pWRRzLYYws7Znq3JAD2yyx+FYravHIDBOp5/Ze2aqCW5diceS8PY9qHcUDKR?=
 =?us-ascii?Q?h98Tcq4qlSoucnua6MntOkIO/Y39xwT/Biqjw9fYXS8yFCZFk3bbsg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LNZ41xYTpRPzNEFNQ6EqUAxmTYKUb6YZV/hhaYjlGwqhHMOQ+LY2t9GngPyH?=
 =?us-ascii?Q?iPlIrgFN03R7V1HXGaqyWZ+xQVAOjmGJ0/sENNC6zDdwqTl+HDkLWLcCDRyX?=
 =?us-ascii?Q?c009VQNRKWDMSUPahM8cK+PHqZWHq/jsvvhI1Nvgjfh+s69LnIHBQ36zpnvD?=
 =?us-ascii?Q?m+awFc5hpx2G4pYtQ/kxX8e/2ZIdhPW8h2/w9du92TrOR/P843vuMVx8XGvf?=
 =?us-ascii?Q?GkZPSLoWEHc5dzBa+5Prqe4KKZuIOQxS72XfSn64FPlA6jBiQwGwiPTvkaGx?=
 =?us-ascii?Q?ItOfQ0ukPrUn7K5xSizYuW/qGkZkXL5OWDaDw8tngG3wcYSVCgwSv4TvwcEA?=
 =?us-ascii?Q?dY0R1s/jGOS05ckjPqM7fOkJksfP/6An6dt2ZAiV6onG0P6S9IjdmNZR7gHF?=
 =?us-ascii?Q?lxBsoYlDR6He+EbsQeAa0BC5gQlmk+TzFpirCBq06h3Gy5Wc9xjJ9p10sCxN?=
 =?us-ascii?Q?w1F4LWguDNWBfcN3KhGRoWhNizdwdNDWrcu8j1ZVFEirZGmNVi0R4ReNdVha?=
 =?us-ascii?Q?9Ep3OY0rEmr9Mq3jl5/VYiBzrKHtJC0A8ZfUr/UqUX/NABstekeFDcA8J90c?=
 =?us-ascii?Q?0NSTVV3mD1nIyRVJhNShsUieuHmNAFRwonlLjL9ey20jrNgurogBgyyN9tOD?=
 =?us-ascii?Q?YiGCSbBBrRdVuM1XvYm5zztj/hbiPtnYyibvOgPoTdpzzotk7zYAsTySyF4Q?=
 =?us-ascii?Q?rQNn0r4VelU1HcRfFzytiKqUZGTnrZ0Xw0gbzGQErdmU29HsWg13jVko2dum?=
 =?us-ascii?Q?VBQ+iaqPeJ6ncsQE7t0nrgMAizO8EvSKa4pSZ71sHII/zSZalg1Q6gIEWJek?=
 =?us-ascii?Q?c1AOk+KRG5be/VbIxz9PiLrsINv6Sph6lZu2u+5w0rNS6L+TPedvR2K2otUl?=
 =?us-ascii?Q?CcKhYvGGWp33pBaPxDo5xkAlTf++jLhRsyMRTPNufuW5qYPpzFE3erUoWlJN?=
 =?us-ascii?Q?S2GIzfTs0BeYSOcrlVqSNs12NXEPmwzYwXgyrR9UjtdNnP6/PQ136wnjFfkE?=
 =?us-ascii?Q?iT9wLAQG5LN1dn4kNv3XieWcbWmgOBq3bjyxYLn3OroVk6i7K1yzB5fXoE/A?=
 =?us-ascii?Q?orzCHIDGj9WVS/Ku8Oz26lnqJTVDioLDSo0n/e0xiCezOmH4aJoL5e4LG+SS?=
 =?us-ascii?Q?gtsN0pLRfybFs0w/Fx33pcxOQCbU8XGAct/R0ZZ6gHiQrhW9AeXMPnmtvG3S?=
 =?us-ascii?Q?Cqpicl4dpsThzriaVrmwgMGtGnQ39ATKmpanQb/LgRsj355CCkoFVgYsEld5?=
 =?us-ascii?Q?CRZiNDZ1RS6CvE1sUtHX2JXLFtNWzyFTMCDwJkh7KVH5fTs/gK7nuFz52IDl?=
 =?us-ascii?Q?i/xX5/4AW/n7zp8ExPHIxHuJwWQy7djeh+r4Cg4XVDU00hIA3mWAUDd//sNk?=
 =?us-ascii?Q?v2UlULrSr0lBqWjWjUOd66LrudGww8lnqOmjNR8xNgILQAdtl12rNJHHlICv?=
 =?us-ascii?Q?IAyhQ+CvjJgkzudPtzIhsolHmf7kPKBHDIS6dehrrY6jdV/lyHOWSuoIuKEK?=
 =?us-ascii?Q?AEf3oWU7plRSPaq9kTBhaasFF6SITZfOD/w/e1+a88cJH3CpmMkOwwxv73V4?=
 =?us-ascii?Q?pPm4CQLI3cjCeWdU8DY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dee52af-e9bc-4acb-3fa1-08dde28aac26
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2025 21:18:57.7945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8OOHnJ2qadZ70nWlFqfNQ1uxQGTgvf/tr2pteQNBqZWD+fxmy7QhqhcpRwTEdbhKFzS3LJdc235+YcKgWlPZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7944



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Saturday, August 23, 2025 3:55 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel Borkmann
> <daniel@iogearbox.net>; Jesper Dangaard Brouer <hawk@kernel.org>; John
> Fastabend <john.fastabend@gmail.com>; Clark Wang
> <xiaoning.wang@nxp.com>; Stanislav Fomichev <sdf@fomichev.me>;
> imx@lists.linux.dev; netdev@vger.kernel.org; linux-kernel@vger.kernel.org=
; dl-
> linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to
> support configurable RX length
> > >
> > > Please could you extend that a little. What happens if the received
> > > frame is bigger than the buffer? Does the hardware fragment it over t=
wo
> buffers?
> > >
> >
> > The hardware doesn't have the capability to fragment received frames
> > that exceed the MAX_FL value. Instead, it flags an overrun error in the=
 status
> register when such frames are encountered.
>=20
> And how is this useful for jumbo? Why would i want the RX frame size bigg=
er than
> the RX buffer size?
>=20

I would say this is purely a software implementation, as the driver simply =
sets MAX_FL=20
to a fixed value, PKT_MAXBUF_SIZE. The patch does not alter that logic. I a=
gree the=20
comments need to be rephrased.

> >
> > MAX_FL defines the maximum allowable frame length, while TRUNC_FL
> > specifies the threshold beyond which frames are truncated.
> >
> > Here, TRUNC_FL is configured based on the RX buffer size, allowing the
> > hardware to handle oversized frame errors automatically without requiri=
ng
> software intervention.
>=20
> Please could you expand the commit message.
>=20
> I still don't quite get it. Why not set MAX_FL =3D TRUNC_FL =3D RX buffer=
 size?
>=20

That's the logic in v2. We added a logic to change MAX_FL.

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1148,8 +1148,8 @@ fec_restart(struct net_device *ndev)
 	u32 rcntl =3D FEC_RCR_MII;
 	u32 ecntl =3D FEC_ECR_ETHEREN;
=20
-	if (fep->max_buf_size =3D=3D OPT_FRAME_SIZE)
-		rcntl |=3D (fep->max_buf_size << 16);
+	if (OPT_FRAME_SIZE !=3D 0)
+		rcntl |=3D (fep->rx_frame_size << 16);

After further consideration, I think we can simply keep MAX_FL set to max_b=
uf_size and=20
only update TRUNC_FL as needed. This approach is also sufficient, so the lo=
gic introduced=20
in patch v2 has been removed. Let me know if you want to add back the above=
 logic.

Thanks,
Shenwei

>         Andrew

