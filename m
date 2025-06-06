Return-Path: <netdev+bounces-195352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752CEACFC30
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 07:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3387A1A4C
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 05:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302BC1E2853;
	Fri,  6 Jun 2025 05:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PhkmIptm"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F21C860C;
	Fri,  6 Jun 2025 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749187602; cv=fail; b=bSUr2CnfYPz0P3Ce74aNHdJhBGrwWjmw+GBNPv2mo4Uh0RoWo5/O7HsPzd/PHJJCMuVURD9zK9wqgnFFcgvikxiyQ1KCacGc2Vaccjxxrx5FyDI8xRGV3dFP9Gf3Jcu91ugYC71UZnJMep/+BTzKXu5V4Q0yvIG4VfXmIgA6F3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749187602; c=relaxed/simple;
	bh=AMs83/eHu16tUOQrXJUdKJTmr1ZEUrRfuv5RSa+fq50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hnvoROd80cDg31Bx0YDwnCcxVM2/6GaHbf46kOExWMxwt6Vmzx15ndZTxuQYAYr/2CutAufDooUTgA5UVilPqnP3ygsB8JDskRoPL7sjUQzzGDQdgUwxnh0YDRzWA32fmSbVf3RRixTts9IO108PQYnEcJt12KnKYAuGEaFYdPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PhkmIptm; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVoIH2UOZtSQGNsIp85Ie4wCfcVBkpz/u+5iNY0SB4Wr0icJntqSNP5y30R8W4ENAtFnOsYN5Cq4Ue6LZ39sIdQh12qjbOENN+HmMRIkhVWH4y7SHHcAqme3oaKa3vJ8HTcNV8ekfSGaTRRHdv+mHVb+1xmlO9oDgXZztFmpYjz8e4pjm+7vdgVFtbfvwm3LHHF9d5lfWtTrCSkuiaNGXv0QBvPEnEj8phkIs0aIr7Pi4VvFfdD1vVmQ0i8nFQwyfbY+bnt/xguKWfQO8lfIsSLqnNoIhdI78l0SXTMMMjK9wxpGq6z58r2xUA6KN0zGNPe+AeqVbbW/I7wqq8JxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMs83/eHu16tUOQrXJUdKJTmr1ZEUrRfuv5RSa+fq50=;
 b=FXXmq1vwZy8bGKLmPlpbl//YSieRRGhmr0b4qnRqYgEvYxnQyNfzxDfQynpTHv/VVXUGQ7k4i8P2+D9jQ24vcVqLgh4Wud/on2hkDtZbhcAXtz8Dz4RDLXWSxcg4Hbe2nQMwLfoen5ZJR/K5Ps+A7zdb+07To3qxebfpqjjjnA2fHsGkziGvE1yRnZxl8mapXf2K39J8ZNM2ViVWDcSD5DaD8/vCRChA7RRxU4M0wsIB4c6udAJrQBxeWMeto8Vk63nrDpQzwS7JvY/I3xYKnbyomoRTUKh6jjO1fV13MB16NWHn/UMPrB0S2pulRd12eLhqnmp7z4q7CDO7OHeN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMs83/eHu16tUOQrXJUdKJTmr1ZEUrRfuv5RSa+fq50=;
 b=PhkmIptmDl0N5hOkjy5qow3Qrk91srXuzAQiSxsPnZdAOpa2Xs6hCQ49ROzubs5nWn3kOQXmaKDAHqYlTj9YEQvd22237FmBONW3sG3QGlo7q+W9jSElsxFrA2VLm2FOhGqtJIQ18DHwYai/1HDbOxOQuT3buskyCzLfNseUikGkm07NFKK2sEyegDpQvhrcY32a9sRuu7RN1BPaEW8pP0jhUn2V4VSeYULy0P4R3BOYVmrg//0sEz0+ea0GwbkfU5H01lbAZmcmN+pNIcpVdXoZeRFrSvjkqYqF8YgkP9GH5oJDhYBPSOSMsWNEWAJFqtp39iCtSoC9pB/iSdytiA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7981.eurprd04.prod.outlook.com (2603:10a6:102:c0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 05:26:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 05:26:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, Russell King
	<linux@armlinux.org.uk>
CC: Florian Fainelli <f.fainelli@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "xiaolei.wang@windriver.com"
	<xiaolei.wang@windriver.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Sarosh Hasan <quic_sarohasa@quicinc.com>
Subject: RE: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
Thread-Topic: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
Thread-Index:
 AQHby8C/1AHS0HJUFE6a7bJae4mQobPgVKIAgBGjJoCAAG4doIAAUgsAgAA/5PCAAms7gIAAS1Yg
Date: Fri, 6 Jun 2025 05:26:36 +0000
Message-ID:
 <PAXPR04MB8510EB0E0EC299D4A76C0DEE886EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250523083759.3741168-1-wei.fang@nxp.com>
 <8b947cec-f559-40b4-a0e0-7a506fd89341@gmail.com>
 <d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com>
 <PAXPR04MB85107D8AB628CC9814C9B230886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <aD_-xLBCswtemwee@shell.armlinux.org.uk>
 <PAXPR04MB851003DFCAA705E17F7B7117886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <808b7ab5-dc30-483b-81cc-397f14683963@quicinc.com>
In-Reply-To: <808b7ab5-dc30-483b-81cc-397f14683963@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7981:EE_
x-ms-office365-filtering-correlation-id: 05d1dffa-fd27-4aac-8914-08dda4bab502
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4S9OZ6VhrtqfHZ6N/LN4yRqJte12iFmCpAdESigOEAMJ9rOavIB23KiVUUcT?=
 =?us-ascii?Q?+LUwXM2otUFAOPgI6cjbzjR9vwYBGhNsy9VOFflOPVs1pLuAfzMXuX0wVfBD?=
 =?us-ascii?Q?loz+UmoNlIEd6/BpanzXDLxPDbTWWDjVnHbPzot+yGOdAPgY2Fw1xsBRPy5Q?=
 =?us-ascii?Q?q0+HxyHSCNMW8LIBO44KO4w5Q4ClLKXOUfVu2dTfqElOj/BDx1Si4y3F7OaB?=
 =?us-ascii?Q?RKE6Pk56ZP9UkS8/sgaubrqgqVbhcjXyvITZEJH1ndlzMRNn+rdDk7NearY/?=
 =?us-ascii?Q?9RZAkXm1bZLg+ctwxAqNOl0uJA3/oPN09D59LtSpJWwMntyCw0+zXgBzaPSb?=
 =?us-ascii?Q?C/lLtctd9kNKTeHPlDMN/zHTQi2W5MzCzqkL+5D/TOA0L2zvILn4ziF/4NSL?=
 =?us-ascii?Q?pbVUcKv8vDqjY+qusgfwjv25EF31PdwloZSHZbEteQpHeRUxs81MS4PpIJPK?=
 =?us-ascii?Q?3FwLEyqC8emDZFBJMyCio5yx/H10iwuL2dg6JSwCniKiEacD2069vupJ+lx3?=
 =?us-ascii?Q?qu78p2RTZhsJD808a8YFLvvVMVP6KFvg88YH0JGJTaMXpwVU0AInG3Kk6XJ4?=
 =?us-ascii?Q?2sDtxphJhmIY3VxdUrVojkm6zRdQ/NdWQ1R9NJcjTTYY4aHh1K5Vkw3EWzSE?=
 =?us-ascii?Q?x5jglkYwuiunn17JbDxADFc/S/Wv9xLa7RZUmJyuNzEdLqhQ12nORfycPDwn?=
 =?us-ascii?Q?mnCeEGJ/LVdxSF0oNIb+fWumcCRxmDf6cjWSqSkMjyvH3AFIqrKVzOCfGGYX?=
 =?us-ascii?Q?5hItGvoMGFwpdxVSfTdXPZc8tgmpWWDeOrjebwxeISPVRQiuiGaTyh7DklMQ?=
 =?us-ascii?Q?RO8zj3LBpGT1660iQtiiULWwgD7hLKjRYNrsImAqwHZc/JWUSTIH5t3s1qhI?=
 =?us-ascii?Q?4LSkr/CRbU4C3us+Jl4T8ws9nfdjs3DxscL/e1ObFcL8qQI2ziopJcOl7GUF?=
 =?us-ascii?Q?yzXom7KsBeBKz2uzikNYyz01InYIa689KE5mZnMdRX+wVeiNIrp3MWyA7zjE?=
 =?us-ascii?Q?BSpFwM1t2d9J86ngk72wExSQbjc0TNvIX6dFSRAY4bKmH5F5LnilYy+m2GIL?=
 =?us-ascii?Q?LLUpJ+TqENEqRTdS0FfSrS2lvZeWs/YXhWUS6wuZv7clWGl7oX6/3e1AN6S/?=
 =?us-ascii?Q?BkyWRxMoJOYihljin58fBkRTyJWaT3EfXTfEk/fw42JFj9V1ZvyHHZEulMS+?=
 =?us-ascii?Q?RWpVQIMN1fcWLoNZxvEgtMVr3xgzcpGa95BXNa7LfCH15csKI+nVA8WgowMA?=
 =?us-ascii?Q?TI3edSdTMDAAIX35hcSfkQo6M88rEs59J2THc0/AfnXazfGnYMWhPd+n/HCP?=
 =?us-ascii?Q?8FOJzjRYR1bftPAnY36YLlCEY9h1drUXTp26jgabJjLFTgRgQI4Eyt2aJosl?=
 =?us-ascii?Q?Q94lK8pxvGx8H08gW4Bc7vbilFaL/XWgYID3Ku+FV01zfZwqocGda7TqWCya?=
 =?us-ascii?Q?rlJjaeO8PF50cG4JB5yG5mmbQY+9wYleGd90OSl2+GwGl6hKZotASkNTq0Xy?=
 =?us-ascii?Q?p4up9RHfxDAMIlQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cg02FTghX7OSuPzW8OhuJ7Z6TYgsNXARel+0srECI6LOQXI4X55DkbrzsBE0?=
 =?us-ascii?Q?lRL3ROe2hi+Ufk5qQrmH0i3F/NMYa+g3LB3yj8bqnUiYOQez5J06TXLH+3u3?=
 =?us-ascii?Q?pDScTmdEfuONDgTud1AUFJAxERLPSb21inFUfBILaQBPksqpzH5Sarlcw+ZW?=
 =?us-ascii?Q?dO8RJ5ooQQIHzeEDic3J6VEHeiCUpXHeSn6U4dWv1BS3bsi5mtudOvz9eaq4?=
 =?us-ascii?Q?vWCTql07uxoXGGHaVCgjzhETZg+QhKnmEDDbeBLKaK0PqmMUf3Dk9UEZKwyO?=
 =?us-ascii?Q?ss8Zz6hJpB+bR8ZUwvYa56MBCGHFGnz4mQX6nHX8Yd1lakci948s73k3cJmU?=
 =?us-ascii?Q?5vw+bBsqpi2t2hIaBjlWg2NpbIJNfLHNit2Mxsy5OGXzW7cT9hISVrnwi2ea?=
 =?us-ascii?Q?sqsQXxa+zgG1BtIIcCNW3QKFqQ2Hsu7VNVGkphDwAHAto6RJHUbwBAhRiGxU?=
 =?us-ascii?Q?+7FVnwV8gPvqwho/4SEL8q1DIre9jphG2VfCNrhgrRddawblc/POoeogBlPS?=
 =?us-ascii?Q?UNdn7WUspNlkf1TtCBKe+Khvy8uppUZr855Wmbs66z2PZPFRcFX3I09IiVhL?=
 =?us-ascii?Q?x/77W4yhWe5XQeLKJAeQvf9L6FgjGOJP+1eYA2A6/zEDVtUiRfjVLHSdXzTV?=
 =?us-ascii?Q?XTI1O0AVy04SeZasuCtg6DNOco3L+JfFzZjjuE1bAQB5zdr5Ow5BfCp3ER4k?=
 =?us-ascii?Q?d9DtatjExUY8itn6LZ5IcXxm2oRei/+7Vz63e0n/gPVMLNymjwkud9R2NN1U?=
 =?us-ascii?Q?ZE4Qqal4UqwWiVDHHqjJ3SIBwf1hjUpOmBPBvUor04TQnetaNE/AqwwQyDip?=
 =?us-ascii?Q?EkrE9+T7n9ZM0WTDUTE8U9VYYHfQDvBGCuo2cyO/TeZUgqNfB7WwUBv2T/sw?=
 =?us-ascii?Q?n3FA6Sa5UbhRNOVkee5FypvyBhPeGXCg08yrhKKkablrlKUZgsz4OXMFqszI?=
 =?us-ascii?Q?uphax1vL2VfRRXxytnFShQyn19zG68Kkn6GqQzS1I82Lo5aMIzIEP2uMf/Gm?=
 =?us-ascii?Q?DQsut9hDkIrvbggVHfogTczfSHrDPYwjE2PyQgyjmnkmzg2rNRuGKGkHfXkx?=
 =?us-ascii?Q?/d/y52PgJoOuDCvh2xEyU9LOrCjN2tGIR2EcWqoFj6fpYhYQgEPUGWucc+/Q?=
 =?us-ascii?Q?jGcDCdoHybZPRiZGZgPkSJRXUKLadUviWpz8pLXAJ399UPadOfEUcwu3OeY4?=
 =?us-ascii?Q?O74llRveTkkaDrvLTw8fDMcXgnANoYEeBjUY7uPI6npuJSjF0lj/+u77QVSX?=
 =?us-ascii?Q?TKjvYyFns3p4SBFl63Q4RF2UjVP6FsIQFIwXZBkC7PUMIRbpwnP58tXG4xh5?=
 =?us-ascii?Q?z8tK8tE6nLP3s2kTnt5OtE4f8mHcjf2EHNrGcBriI5DvONOf3yE0gAwgyI2V?=
 =?us-ascii?Q?Y2AEKy3lAu+bK0x8uuyYAznk8QWZ6joT2plYiLAwRDDs8YKkU+dFRiGdi8Nf?=
 =?us-ascii?Q?wOHS8zqxQUjb7Kf67LA5dS8bGGukrxyqtvN36O42rmbEbbiF8OwMat4lcMhm?=
 =?us-ascii?Q?p/Ttt6r/2vbfYfMOItY8klJo4/t0nvtcGps9k/VsXRnDWdPqjRaEulwolhkL?=
 =?us-ascii?Q?AETOB7pZkirZgywClX0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d1dffa-fd27-4aac-8914-08dda4bab502
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 05:26:36.3979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h93KgpJrdAUKSFOK7nhUCzumoTOZe0mUFoQRDG5CwjrSpktBA0l94Amw5epRcnwZ70juSkMNwFbC+JAbo/faVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981



Best Regards,
Wei Fang
> >> On Wed, Jun 04, 2025 at 06:00:54AM +0000, Wei Fang wrote:
> >>> I think this issue is also introduced by the commit bc66fa87d4fd
> >>> ("net: phy: Add link between phy dev and mac dev"). I suggested to
> >>> change the DL_FLAG_STATELESS flag to DL_FLAG_AUTOREMOVE_SUPPLIER to
> >>> solve this issue, so that the consumer (MAC controller) driver will
> >>> be automatically removed when the link is removed. The changes are
> >>> as follows.
> >>
> >> I suspect this still has problems. This is fine if the PHY device is
> >> going away and as you say device_del() is called.
> >>
> >> However, you need to consider the case where a MAC driver attaches
> >> the PHY during .ndo_open and releases it during .ndo_release. These
> >> will happen multiple times.
> >
> > .ndo_release? Do you mean .ndo_stop?
> >
> >>
> >> Each time the MAC driver attaches to the PHY via .ndo_open, we will
> >> call device_link_add(), but the device link will not be removed when
> >> .ndo_release is called.
> >>
> >> Either device_link_add() will fail, or we will eat memory each time
> >> the device is closed and re-opened.
> >
> > Below is what I find in the kernel doc of device_link_add().
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feli=
x
> >
> ir.bootlin.com%2Flinux%2Fv6.15%2Fsource%2Fdrivers%2Fbase%2Fcore.c%23L7
> >
> 11&data=3D05%7C02%7Cwei.fang%40nxp.com%7C078b59e45bd54f13cfea08dda
> 49477a
> >
> 4%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638847679768356
> 722%7CUn
> >
> known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCI
> sIlAiOi
> >
> JXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DiFtK
> o%2F
> > NfwPVYbxLBtZM8Y15Aa9eomUNhPTRfnEb0L7c%3D&reserved=3D0
> >
> > if a device link between the given @consumer and @supplier pair exists
> > already when this function is called for them, the existing link will
> > be returned regardless of its current type and status.
> >
> > Therefore, it will not create new link each time the netdev is re-opene=
d.
> >
> @Wei,
>=20
> We were able to verify the suggestion what you gave us.
> No crash is seen now.
> Should we raise a patch or shall we wait until this is clarified and Russ=
ell has no
> more further questions. ?
>=20

I'm okay, but I don't know if Russel has any other concerns. And if there
are no more comments, you can raise a patch. :)


> I am okay with anything.
>=20
> >>
> >> If that is correct, then we're trading one problem for another.
> >>
> >

