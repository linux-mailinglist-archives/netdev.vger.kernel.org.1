Return-Path: <netdev+bounces-238561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D44DBC5AFC2
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 03:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AD58347378
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394321E51E1;
	Fri, 14 Nov 2025 02:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OSEA8vGM"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5391FBC8C;
	Fri, 14 Nov 2025 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763086667; cv=fail; b=f7jFDJH/oiMJT51Crm1UKbRu7pp4VWqAtXtm/itjXpUAzrvYPCwLSdgMqD0D1DU1uzk+Yt6U4t/IcSQNYf8tEHAQHEeBbDS7yQh0P5yNvHbyvpCKu+f4g+HraYqywUOgqOGClYwVjkd4ro4jdWf7lefhEScak+FInkKEruxwL2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763086667; c=relaxed/simple;
	bh=TSBMtJV7XOihkReyU353WP99jrTpcH0y46Pf8wRELhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VTPuL++fNVJkMCbuDAqahtvlaAhocQP7OJG5ObeBpft32fuYll7HIfCx5/ds3vIQV2XueS0X0wkyyQhImlr2rvMAnSUd9E0y6bKV0X00WHubEelNc0FmQOa41+gS2W9r/ujebtehI+uMToTiVjIuIRXuqK1l0/qss2r0Ax2wQXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OSEA8vGM; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFF5dFMOfv3+jS5bDK0jOyBpApOGAJcuAd84KOQcEm9eJ3C5VEaDN1GZJOKBeRRrEQP2SnSdfReMPfO9VNywfRaDnBhUGT4CYSaV6Bx8ilRyRU3HHjUPknj8xLDH+xOVR9QApPllc4exzwTbT14k9bXTr+X5YV2cj0dVJWR0tITFkplRXQ/uIHVFaAP+M5Pn1NjwYyuo9f4/GSvWgRotcCKBqpuzn13iOGr1uicRdprL6MJm0cjfuFAJpNrQyQhSPtIfTvqILrkQqapY2UfBX/laPF4YcK39OitLo+EAOrNa3icw29gbqOhdsiUtoEgWU/elkudCddinf7K06fvi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSBMtJV7XOihkReyU353WP99jrTpcH0y46Pf8wRELhU=;
 b=kAVQCLN7Ty9k/NkctpIE4lkKK/wWnRR0cnSrcchtnmv49F3SdLkr7EYhH066iIFHhlINavth2tKo2t+aGLoPmXbdkS6GaQHXu77VT4GnvICCqIHZDWFffnWrEdvJ2AHxZJbgOFv5B8JObNVnUB+Zb/CvC4ERc7iIIPmqN4K6SRLz/innEjopiKcbkuotYeyzcN9LnZHWxMijQHAPGiMJCtIN7CYEx63usEgowhXLCgc+uEJtCs70QMLiFwxplQVqQnQI2qI4cG8pRkP4EMCKKrkm+BIBh+/DuMwsMVksM89xfjnjdF/+29jAmlN9M1X9r7+kWxI//7bPFsroaRcr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSBMtJV7XOihkReyU353WP99jrTpcH0y46Pf8wRELhU=;
 b=OSEA8vGM31BMySYipo7suCZ0zRjwb1zE+XeQdrJF+yc1Ltyib0erG1vNanLnXb9CXOMiEh3eSwyfHxkgZwfo3eZXyaJIVau2m1YVUCoXRzbx6uq58z/lgkpYMk+qpLksJbB0S8USWqakUOuB1Og2h3erKk1BR+866dl0AqG4PBHvETNNP1v6HkRJRKoy/75MJFGpocOczF0ydJHGMxbmymx7Om/3eraG3eLmfSfObnkTZoZlKBligsSy/NHZBh+FogpThST0UqQ72SlFc50bciualmFmBPPIZxCe3a6bwbyLygkc+O0GMn007o3NZgtHuEnkpWsxbVT+LST0obuUzA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10573.eurprd04.prod.outlook.com (2603:10a6:10:587::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 02:17:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 02:17:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 4/5] net: fec: remove rx_align from
 fec_enet_private
Thread-Topic: [PATCH net-next 4/5] net: fec: remove rx_align from
 fec_enet_private
Thread-Index: AQHcUvIMuEthEp4yc06FM8zZbactabTvfvOAgABW4jCAAMH/gIAA29+w
Date: Fri, 14 Nov 2025 02:17:41 +0000
Message-ID:
 <PAXPR04MB8510249AA3A61BA2853C708E88CAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-5-wei.fang@nxp.com>
 <116fd5af-048d-48e1-b2b8-3a42a061e02f@lunn.ch>
 <PAXPR04MB85109979C5B15727F510F87188CDA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <808e68e6-ba0e-4a2d-8b20-8555f53c586f@lunn.ch>
In-Reply-To: <808e68e6-ba0e-4a2d-8b20-8555f53c586f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU4PR04MB10573:EE_
x-ms-office365-filtering-correlation-id: 0be9fb23-9599-494a-1c3f-08de2323fda0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?70y5H/WNFsIJZ4ut03Rx1FhHNS5DOeYMQPj8r5/PABuvAdvd/9VUguSL7vAo?=
 =?us-ascii?Q?P4Bq4pQYjIuD2M30HluloJ45IZS3n6Zge7XgWxHktzpNFtxMs9vdr/TQXPTT?=
 =?us-ascii?Q?S3bY0k7THXNbxhyRhckgxFtVRiiBNmhTB8v7lUkkJVcrxKDwsc4oI6Yfb05Y?=
 =?us-ascii?Q?LiTkXAkuzysieRURH1wCXtz5FKlzopGtZsONwv479GLUx7sHg21O8aSTgYdZ?=
 =?us-ascii?Q?uoRz/k4uDwHJ14yR0Q88UfUwM4VerjcwWUpQjQJhaJJIIjCruE33jpcEqK1Y?=
 =?us-ascii?Q?qnNo5NhQsvqeTbM/KTs0V9A2bjZ0GAafDduLD0m4UDcZvn7nk2CK7h3ys9Un?=
 =?us-ascii?Q?YWAqf9yLJ5uvZ13BdNpHpJ+BmkIsa8raJcmPgxSXRAgb0Ly32b1u+R2K8l6m?=
 =?us-ascii?Q?K7ljVYbsV6D2Qbv35Thblf2Vzg5mmje1hUyh/erf1IzXpxcVlrYk2BBZidYv?=
 =?us-ascii?Q?HyawwDhLCZ+gVkkOiP8yukLyl92fNDNA2RSukdvCPZ8YniAWdk2148cXI9tj?=
 =?us-ascii?Q?9QkJeaOEQ8GUe1D4R4rINkRpHZT0Bu3qBJ9EMz+xoUrJv9Ag2xTex6doK/Xn?=
 =?us-ascii?Q?JuS0XVcYC/AyUh/9uNf1ru9VM4IJX3F4wRRiAgJNcKvy+Yvt2Em1TBvgZtpF?=
 =?us-ascii?Q?0CqKNd6nESSCS9ysB1smlOVkgj+fc8346Xp/FJ4VrzJjlfPsbjDXJaEeQKw4?=
 =?us-ascii?Q?VbGEg44tHrsC2llABzCOvSGE3SjHQflyClF/by7AO4Fk5Xnk+FHZhTn++cyV?=
 =?us-ascii?Q?5vfbAC/W+5bF+i9T0uKii52TTcZZaFKpLvhFfjdfKgIxywds9B5cHoB1umMo?=
 =?us-ascii?Q?EtfS4bvr0Y15LOImsSJPwz3rTOMSiNC05DLp7/weUUioEwIFaPQ8iI9GV9SZ?=
 =?us-ascii?Q?adheghxI1pxw+3WtNLhNzFND5BJTLMfnTZ36YEFVGlJ58Ji9Cq0IKOguu9Zc?=
 =?us-ascii?Q?dT8jm3Ub3cDly8O645f1ZM/0kSw3r6mKHCkmpAkCTaW4E9Dw6BoCIxd1/HJO?=
 =?us-ascii?Q?F6a+FPt1hwfM+krATPBNLv7/oM3PpaVEI58sNjxIGgyI3/pdElX/MhkMRfQo?=
 =?us-ascii?Q?Ebajy2StXG61cR8lrLAguQXrq2h001PSqBGtVv+VbU8Oj4MlAtWMwBM8Gyf5?=
 =?us-ascii?Q?c6xSiVSGgnpOlOEUckb1/BF4O2VYUuJ7cShJC6ADXpP2EIFLY1UjgXamcI3r?=
 =?us-ascii?Q?ZpKrWr/BX1S1CVT49G6r4j30p/5FzQnJjEmtxDwHFVeHaCY3kd4OoBwqE2FI?=
 =?us-ascii?Q?z988j1MRYop97ercupJ+M/HKwfvtSBf2EN/fK/OE+BnWtAIYZeG6ogNHGSBW?=
 =?us-ascii?Q?72AvawoFz48kuxz0Get6rjnFyhycvUG4vIAi9k0kpeMXu2U2lxftXskT3uIN?=
 =?us-ascii?Q?zymQ/JGWrP/Ru0YyJIED0jG7RGEzQApB1/1h6hFYEFPcC1OiaZp+1AsAqK6/?=
 =?us-ascii?Q?1OpdonScboQlDXZaKAEVo5RlEDfIWdlkqrV7ONTps8Pld5Jrf5dD0uHTCS2L?=
 =?us-ascii?Q?xqM+BJtmrmF6DGGrKaJo+2yPMxds6ibj12In?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ewN5JjSCY4mlHxZBZh0GfoB9eKyus5xXshOACHRFOpuXo1cAYU/IFiao70sc?=
 =?us-ascii?Q?a4WmgqjAvTitw8JCrS4lhjqIsGPdn/VkLq035/CDd8FGIG2PKK56l7SOs6/s?=
 =?us-ascii?Q?ixEWLJHQpsoCmWwPN6fQiY7wsWl7tXYJn9rac5gn7IVQ7/z9/Dpuumg4eEXN?=
 =?us-ascii?Q?Etb6p3SoQ6QAtXy2f4XLxuoDiqREM9mtK2ojtnMdlrjmcsCQaAg0KMdjNSvn?=
 =?us-ascii?Q?R4XpDvTGPSuYwX/aOc+So8k7hci14GMDXDctuWDv36xLRO/v5Qqm+iX4cV+B?=
 =?us-ascii?Q?NN3LQPdHgPbArACMDoXW/jL/ttU8tgMPrGwhEIQSORktpZ6WD7SoDVwkos3Q?=
 =?us-ascii?Q?ZlRphIPauDYJy1hN5TY811mvnOdEzF6kmpCvHbADvCGAETy/car8FWaFIXzP?=
 =?us-ascii?Q?6LbHJ3MlwjJlT4ykGb0i6XuPe0wz08pldMc0tksyaoeTBCh7RAlm83NRDoUt?=
 =?us-ascii?Q?G3fA7ASOfxxWUFEKz4f4IDz/bguoLFbZ5kcbtXNFgs6DEnuGyCqp+5nHR1wO?=
 =?us-ascii?Q?zhqlZvhewrXxCwm2VmWTUabNIHtHk/E3QXZzmoF8aMty14fn3wVtYv134+bR?=
 =?us-ascii?Q?IV7m2bHiDdTzV56W+ahQ3oKJ0MXLv71HyMhR0HylfEgoW/3iuxUfuwOBydKc?=
 =?us-ascii?Q?T+x1109QKRnkGQZhyxN7OwC+7xTcwU+51Bpdvtw+TWQ5P7ihIvKJUVMPnjx4?=
 =?us-ascii?Q?14tsMiazk3/V4iFpee9MitmkpNbtbUrbPsRq8RLISf0EvKNcA4RjA362u1xD?=
 =?us-ascii?Q?uatAojOkWFmDk8W4lxjJ8XA7cseZVmIVzDMA0v2mztjJ8dueD3mmgZDwzkg1?=
 =?us-ascii?Q?GHuh9Nh2/8/1AjkQCr3UdS//QKKL9BQcCYB1vJD3vr8elboRtgMYGZS1b1qM?=
 =?us-ascii?Q?9U6kJOFrNg6v9+BogRWqNPQqVPmxnHL4zZLTbaX5ZZOB8XIltGaQnyDl3VRj?=
 =?us-ascii?Q?wSO1wfM8yB5Vrm1Mf+By0Sx2cz4wyXGDaEItmZVoS7SgwbNI1MEtavWpLxjG?=
 =?us-ascii?Q?oAzS96LvTVtFZ/4R0qzjaH8nF0GHpLxCTxs/dCvCvYH47wsvd+IONF6R+7Y7?=
 =?us-ascii?Q?2vZH8P3v5UngNKyn9YVLtvh3EXQ1OxV+ivmbD01ew0WGVlLdcY8zLtYDb6GG?=
 =?us-ascii?Q?QFFKESmNCiFUwCjyMXSU7sMOlaQpaCVumTe/et7Lwj6B2EuUHUVna9rrdxK1?=
 =?us-ascii?Q?GJp71RgeCsr5QDr62lblNbVU8dsUrl/GT/NqhjGyBUGont246/HC5BoCcIAs?=
 =?us-ascii?Q?pDmhV7nLSFuuJbKRXVkTXGiLhysm7UjRfwrgHYleRGgGASHo8eUfEYBeUAJ9?=
 =?us-ascii?Q?JZMZeX6Z4eWfcGHy/Z9rhgCVFgXaNMhhAKfGvDOl+LRaOTDR0lLdV0pyOiEZ?=
 =?us-ascii?Q?UVcB4cXyjk18s9hkvoPnaqICP3CwI1CV0HebRLZLJs5zxNnNxwYkU2Oup6F/?=
 =?us-ascii?Q?VI1YRfQ0NxM8R2WORuPeSLHPL8BgCutrFem0MbzIiS5CTz9xGDfYOR7LRj23?=
 =?us-ascii?Q?J9bSxwhDcbGohcTSMuxDJfxNMYLT59VEqmRmKI9G8xOWf62c1jftCHohMZRT?=
 =?us-ascii?Q?48bIsVbYap5922mhTrM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be9fb23-9599-494a-1c3f-08de2323fda0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 02:17:41.8633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7pVL0LTgKYR1HQs5F9Eu36d1HkryRLcnYxga42Yc+WkmVuTxhV367HRa0cri1qKfq38KQyEnRYDs71qEC2YOwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10573

> > Sorry, I misremembered the value of XDP_PACKET_HEADROOM. it should
> > be 256 bytes.
> >
> > See fec_enet_alloc_rxq_buffers():
> >
> > phys_addr =3D page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
> > bdp->cbd_bufaddr =3D cpu_to_fec32(phys_addr);
> >
> > I will correct it in v2, thanks
>=20
> So you could add a BUILD_BUG_ON() test which makes sure
> FEC_ENET_XDP_HEADROOM gives you the needed alignment. That way it is
> both "documented" and enforced. And it costs nothing at runtime.
>=20

Yes, I will add such a check, thanks


