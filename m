Return-Path: <netdev+bounces-207691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAB8B08361
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 05:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D16C07B4012
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 03:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BFB1EA7DD;
	Thu, 17 Jul 2025 03:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oXhre5G0"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAF07E9;
	Thu, 17 Jul 2025 03:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752722608; cv=fail; b=Ie/Kv+yarkT2+6HIA4P3PZJwqJQn09fH6NgyE7oXa6fnqSbh800HiJC3tQFM1tjRwVHw2fzYQp+srcsufwUquJYvBt7s0o1jSfVwiNAUHtNx16MIMfozcBnKw5xNqw2JVMIbygC1jI4WGc1VEZLC8+VMttufjxcoXbssv3S8OXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752722608; c=relaxed/simple;
	bh=C7KYOXhYLrnuhnx8GMUR2PXqPYaUZCMkaN2wBXeVhWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=srS1iFMjXn45542j/4lkDvTAuKmUVvUJc+Ud1hPQr96GoDLFzI2NX9giFYAd+5brqV2j2EgQbYW0iAKZMD96gTyf+ghd6lBRNvIZdNlpw6QHgn0nLvWJfAiFxJByiO7xT3C9Hu9Y0QmlF4oB6imSBLE1ir5F/f2GGRKBiuc6eS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oXhre5G0; arc=fail smtp.client-ip=40.107.162.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFbUtW6QWZSNPJuszw+EO8AbQHTfKrzvBzvUQhtN52k12oq8HT3euseCwU3hc+mzzg+hbqWog7pJ5TD91ClPTwbb9Lvt90fMYmYTHr7wFURtgEBOX9/c2b3EZF0XaxvezluI9ZosIyQHITnPgaWfC4Mhn8DonvOTZuQUnvr0ofcyuo/VaBftkcVhxGg87jj80Rummv0m97BepTJP6u7J5Z1lGpy0ZjkkHMOXYgqeeV7qi3qJ2ICG5ogKqcqywHKWnkNjOthPLUx0iHd8o00c3MxbQswRwvaqWf/uQeh81GvGxcfjBG3kp7Y4hgJD1UB/BICdYSbcCt1Hjxb4o6PJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKrmIM5jfx8i35B3FTH9wpLFdwZawSv8EpBNWdSE9Bo=;
 b=FYCL4I1/IiloV1bCpv1V6IN/UgXnFhVcPIUWTlG8GjbJBewxWwpAAbPYQRmXfxkZBrRYmckq0dYNVxdJj+wbaJ8CiCcjLuDetZyigeLZKHLgENcXaiLexuZKXJHURz8dS5iDlzNzbu8+bR4CvQ1+YZzd7O8RZ8YFPK+uXQR/Ks4T2JI99zBQzj/3H+V18S86Zbmk1GImApWQxfgB7vp0GT1rFP8gEx0sk1q6nSt8StLKep246Kg5H/2ot8nS9nUnuctHFzzOsrxPY5/bh7pFLNYOgQSsQlt+eKhNSVokRNMq3AkKIzKhd7oqxmg94pus7o5K/dM5dkirGrnCF+S8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKrmIM5jfx8i35B3FTH9wpLFdwZawSv8EpBNWdSE9Bo=;
 b=oXhre5G00c54cm4csvr0plmdxwPB4Sb5G+D0BgSKfRN69Ss2wMNv+kpjRRsmbvQc8KSbEE3cXiN1PAfjoNwxCKNqi3+0pCIXnkoAoWgMEkVTLV1ZRceWwOlOCv6Dr37jk547nqp7wPG3sfEc2L0D0zv27MzAMpHnKV+9Y0QsZYeouisinEs4yHZpKVNEfgABj9OxgqsOeab8jp6+a7LFkcH1HkOd9fEv/+JbX0aD4CzpnxtrbUP1sor/K1KOTEqBFn+pPWEa0MkLsMPQf7tFaJ4oXgv6d/h+dk+pybJpko0EuPmtJlG7zU4e1tyuGVygwVwo+I2JpDN5m2d9Uzt8DQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10096.eurprd04.prod.outlook.com (2603:10a6:800:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.37; Thu, 17 Jul
 2025 03:23:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 03:23:22 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "F.S.
 Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Thread-Topic: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Thread-Index: AQHb9iZmm/EQyWHMi0uUtvbMzlnJDrQ1I0KAgACC2tA=
Date: Thu, 17 Jul 2025 03:23:22 +0000
Message-ID:
 <PAXPR04MB851091A05F842B7E3CC33D3E8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-3-wei.fang@nxp.com>
 <aHf9UfUQggd/Oxh/@lizhi-Precision-Tower-5810>
In-Reply-To: <aHf9UfUQggd/Oxh/@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB10096:EE_
x-ms-office365-filtering-correlation-id: ae34df72-1c1d-460c-e076-08ddc4e14916
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?seIKh+Tf4R2KMBsowIC1S3qDa4si+qjwfB74edb0SfHm89t+sawnmB8jW1Jx?=
 =?us-ascii?Q?bKefVRK3tcMF9Tu6dOM+HTc7FGJbYjGtJ8U35AP3Q+RwUKmXCYoLArs5eH7o?=
 =?us-ascii?Q?UusXRjmNNJ+gW/2GPXN8Y9QpDDqEnbvh6+dqM+hj/O7EQ1quB3xdNI7V46kM?=
 =?us-ascii?Q?V3MONFSIyqvc50/hTfC3XS9WMAMnHYBdEy8lT53f2tXYYK551l0p5SLwG0rn?=
 =?us-ascii?Q?msZ+iGPyIZBgVSRmqCH34R0fEGDEst8YyD8F5vZyK3I6QVWpYOylAg/Ulksn?=
 =?us-ascii?Q?fytcUEzBGPBGfZ/+YbFftYuoNbLrOBlVVNL8kDaQFee0qWT2V3l4SbA9ksVx?=
 =?us-ascii?Q?hJU/q+hhqoEt7XSAao2EOMBZWweumPWSNFDBx0/lrYXaYo9woNBC3ACXMQvk?=
 =?us-ascii?Q?o9EO3MeXjQg0O3x5PzzhrRy5DzXEp00hHRT7XNj04AfSlN1FLXhSkh20ULPT?=
 =?us-ascii?Q?JV45JY/V4KkcU7WaoZqp7WEXklRMFmdJ8oiMjgq+iVpus8RSPba6/OA3ZZnQ?=
 =?us-ascii?Q?rEozSCA0hA1ipoubYu7POPD5D6v57zVDNO4rtx24mlD+BFbisU/dxVzwZmtR?=
 =?us-ascii?Q?mS61QYK/K5DbUcDIdmNxFrZV7a7UbxRAySwnJ2k3NJyGto4QRS1M6CTZL8cn?=
 =?us-ascii?Q?YUNaBBvjW9Z6g+vRUnI/WeCvq5EBn/M/e2QvQ5PFW2wJOfmZjnK64i096sY6?=
 =?us-ascii?Q?TF3Ulu2hx9DN8x4yOvRje3XUbKYaB4vPwj6uwt3OxSazRw6PxDL7ORYlYosk?=
 =?us-ascii?Q?PiXmvcrWp25ZEZgPLRxGzWQPrCUOHY4GdqItPjE4rAzxXnbW/vwRtAYysFXJ?=
 =?us-ascii?Q?ffrLP7+AMQixc7/PSUc9KbAIOWYfDTOzkPBABrsifYA7qNeCpNKy1V8C13/X?=
 =?us-ascii?Q?LII0kQqMzzUBHWZthoD4vjFh9IxHxyLvLf7KAU9bRT+k5NAggOtcN4uotVNz?=
 =?us-ascii?Q?EtMitjyyfjNu7Z/fJMizSdlZffbsRvCe08u4dODfqiAzJpN41wlWBFl5pO96?=
 =?us-ascii?Q?hJQGTwTpT85Ttls/Ee4HUk36pE7nTCqHMUmAFlqW0yGJ6FhGUVXYrGI+WkTg?=
 =?us-ascii?Q?APH/GQAq2S4HhRzhqUP8gqo1Q96mIV+9BaI5Jz9dE1rVhw/COSdQmlqWRcYR?=
 =?us-ascii?Q?2R/FTQj8fhChTtNOflADqwXGMprlyrBclyDU5aT5tQnhcRDGbRG4SC6+nDpm?=
 =?us-ascii?Q?+04TAudivRUSO3ve5obqtyzz8CLkFUwCYo3keQ85oKy38kHJpe3KADsWks9/?=
 =?us-ascii?Q?+SJ6OTJdpbEuGtsrGpU9ZD0jCvbVzX7D74Bh5+oyhykVVYHa79cRv8KAFM7V?=
 =?us-ascii?Q?69E4J0AJU/XsC3mOP8CahPeqy/hqmTeh4bGZ0GZJX3T0FxoJTHWPBmFGfUVC?=
 =?us-ascii?Q?makRRVnxJTFhOnlkkdeBI6yJzNC4jGYsfoN5H6g453JpcJ7BoaqrTmGl0lJL?=
 =?us-ascii?Q?vTw8WyiliiI83ToiIs0KY53HTvAiCKjqQjfnaIlaTZ+aA8UANtfrvg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AJI0h99qykXg+/I/XQaPau5bCy/uG7CVlxGy/sMzIfNo3UT4ydLXvlhAwqt1?=
 =?us-ascii?Q?aHvKPhhJdzrwr4XvYe+mSfx33b5ZPFlc7oXi2Sm+/EOzePKkTZPmzS6cwsX4?=
 =?us-ascii?Q?IINHBeypy5R5G804Aeya5VgN/WgO4DCIW8FO9IwaBU3uQ7xYDn1UsGkHNeFM?=
 =?us-ascii?Q?jyBH4vKPiZqT13ycNwHtStL+50oSYdUiy2AzlCxVFEHDd+cmqQ03mEyn8BL/?=
 =?us-ascii?Q?O0RGZJEtBOr7LjU1FsWuwJVsuvRNXdb29SOx2u+Bs31Tm3V9XGCh7Ngm01+d?=
 =?us-ascii?Q?bDDgs73ktA620ya3hfecOOsCAPzrmcUXYsVIwPf/u8BQCRZoh5gW/DYx6TdO?=
 =?us-ascii?Q?dj0hYcea5Cx4gz+hUNAR4JDrCb/XI5HQKyuKKNZA4MsF90kllmw2PWff24cl?=
 =?us-ascii?Q?CsdH05qOLcIu0NH4Fcqlg93/jutRg3GAJQaNNBlODJmSDPnw8cmvQEVZs2BO?=
 =?us-ascii?Q?2GF//LsOvuCvGVr4WHXZ/FdZpiG00JJXEFNwqBaksX/pTqC0iol4iOohRsyu?=
 =?us-ascii?Q?WwDBB3uVLz5t9QZDi7GGnbyZns8rdOJAJ8Z0RwZ8LCQyoUkH/XaPBIwbkfXs?=
 =?us-ascii?Q?cjorxZ9J3EgTQQJjS7WdHMzPYQzqM0ws1DmvAlFBGr5bJkCOgIIMGgf5a0sH?=
 =?us-ascii?Q?vCmU/tlL/HzejKYTAI3S7SUegAMwSOG79tSzY1TW9NTbRKgFCLqHnw81b9kV?=
 =?us-ascii?Q?MsWGhNEGIcGwn5Ek3rIJG2rmfOxJQIBuBA8b7Ook6KDadZ2C29/HLv5pAE/L?=
 =?us-ascii?Q?4IQwLHsci8nMTR0d5M0n06A6HJdMAVDa+WEwVXe8kyeQoBzwwwIfuwu6npFv?=
 =?us-ascii?Q?yqNAAfvaes5ao5EqGHcSujBSjYAzVwdsGz2z/DR0oIJ7eb1dENRRDvcd5ciN?=
 =?us-ascii?Q?s1ui0khdP2PVwpsdFtyw13ut7+a7LF7ay6lJZf/5CG6TrtL6mmXJEVj+aeq5?=
 =?us-ascii?Q?O4uUcDBHkHwRwqiox8IlCO2X/DYaMjs/ity/HEohIiJtKjvVbKu6SK2kKA6F?=
 =?us-ascii?Q?Y7/+TVwxPQOZZvb++1n0/zustlUGkDfF65cdOdbVLolU2YcuRuBkajUYrdg3?=
 =?us-ascii?Q?5Me7zq+pfGG01u+JAZRfrRRQFBRtDo2a/i+ii8f2FVWm5P/j8C0UOlcuC4Mj?=
 =?us-ascii?Q?R+CkHqLZ/+hIcIURtrLxPAaalKKZolAbh4udeFNoRFi0jtmZoO2uWZMqw54/?=
 =?us-ascii?Q?6d31nYOxxnpPMOTv6h29sBCZRwlly/eFli19ShMGuzGrAFIzW2bmp/rIWAz3?=
 =?us-ascii?Q?LiL3VzNsxQx9G8NkkrpZSxMb/mSVQrlnDd7fewxfzk2oGQSFVkrVU5gEeUu4?=
 =?us-ascii?Q?lR4lHWbajjdCDr6+NXNDyUF5VrpLISxybH8SYq3RmOXInHx5nFS8vAfOHQqo?=
 =?us-ascii?Q?TUw59b7ZVayjoUyUF3j2dxJBH0glO9rx40uzrxUnbDaaherZ6ZTcywtCWAex?=
 =?us-ascii?Q?zVTR5DlJR98CRM0o4fNSQJg+JS68SsgAnMdar3vj6ZSPNx5UbeyP9vUseO2x?=
 =?us-ascii?Q?qEyhXeFrviVYeui5fCEg8/YxU7NZ7aeHbt6P2UTp2YhfWeUwQ7267ulL5Ptd?=
 =?us-ascii?Q?UnBMLEOeBNzBdbQc8cw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ae34df72-1c1d-460c-e076-08ddc4e14916
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 03:23:22.9217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p54ZBZGIJCaA553jQRpwdopWx9P1aEqmFgdY4NkPhG3aQRgwInAGx8MlDUzRs561ZVxMXtNdwyzgXY2Oqq5zmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10096

> On Wed, Jul 16, 2025 at 03:30:59PM +0800, Wei Fang wrote:
> > NETC is a multi-function PCIe Root Complex Integrated Endpoint (RCiEP)
> > that contains multiple PCIe functions, such as ENETC and Timer. Timer
> > provides PTP time synchronization functionality and ENETC provides the
> > NIC functionality.
> >
> > For some platforms, such as i.MX95, it has only one timer instance, so
> > the binding relationship between Timer and ENETC is fixed. But for
> > some platforms, such as i.MX943, it has 3 Timer instances, by setting
> > the EaTBCR registers of the IERB module, we can specify any Timer
> > instance to be bound to the ENETC instance.
> >
> > Therefore, add "nxp,netc-timer" property to bind ENETC instance to a
> > specified Timer instance so that ENETC can support PTP synchronization
> > through Timer.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> > ---
> > v2 changes:
> > new patch
> > ---
> >  .../devicetree/bindings/net/fsl,enetc.yaml    | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > index ca70f0050171..ae05f2982653 100644
> > --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > @@ -44,6 +44,13 @@ properties:
> >      unevaluatedProperties: false
> >      description: Optional child node for ENETC instance, otherwise use
> NETC EMDIO.
> >
> > +  nxp,netc-timer:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Specifies a reference to a node representing a NETC Timer device=
,
> > +      which provides time synchronization as required for IEEE 1588 an=
d
> > +      IEEE 802.1AS-2020.
> > +
>=20
> I think it is quite common. add ptp-timer ethernet-controller.yaml?
>=20

Good suggestion, but I'd like to ask for the opinions of others.
Rob, Krzysztof, Conor, what do you think?


