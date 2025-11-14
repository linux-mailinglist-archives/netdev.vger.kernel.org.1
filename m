Return-Path: <netdev+bounces-238630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C0C5C56B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71E834FD732
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CD4302176;
	Fri, 14 Nov 2025 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FljQGziS"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655C2F6567;
	Fri, 14 Nov 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111932; cv=fail; b=KGe2ymXjcieIlaKeLQEgSsOb7CqEwU4upmImAqUm+C63FiMk3t7gRyRObbyBUswA8Mkdzl0gWi44cmYWfaGO0DdUQVwSa1bMUv6ywZkiISVXaeSGzhQm3+P6biOL20s4TphrnVSft6P3ms3UKBbo6fuH39lOZ8fhC4Z5gI64//A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111932; c=relaxed/simple;
	bh=Sp+fYGb5TS4MRxHE6HetfFXz4GNMtZ1EdmIvliNJQTM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bcCag5oNzXEP5hJDB5UvJ7YJV8g/+8vzQTe8xFIdElH4fVzx3XO8Vxyq7L8aJ4S0oo2Shf7ygiuQqwMrrP4JyFWf53eF+ES7By8xQaH+4X7vv+3azbALaBm8AO4fTE3QRtPdLtwTalEO04ag+nQ3jOWfdbZzXCUhjFIkYikkk7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FljQGziS; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmfjshzvOWILWip5PCOqF5yQ1msvkdWBCWwkXJ/3NbA1EV6S2dWdiFaVXA2atClv9pY6eSgJpe+DQub5QG0C8gqvli7/pTFCJSYE5ZxhaN6TtiRSb9QjPk0jeGKooyZzq7pNC+PLqQ6+jTS4mFf9XxwwBSZ2YomGSDWyrc9I5qT/Ffp3MDZGbe4di2PvcMu2OUSy3zVvjE6570ZNDQdKsNQ0o5Ntf6p8tqs52sym+zz0KEcoSvPYvUnEUzLrI4kbdTjiipqolLE2jA9rVd+pA6LW11DrSgUKmfO2gBVOTxu6mjYdIBK6mcIDze7J3TQkr4YQlKPIWrQn7TzKwlQGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp+fYGb5TS4MRxHE6HetfFXz4GNMtZ1EdmIvliNJQTM=;
 b=sPol/siS/XBw7Vo8ZGNgggQP+LGuNtrU3gRIGmCoUDiafNmzQv4JkznMlSvqR8TniZp5ErVlSk/a/RK0js2nmQ4c/+38p3lxycqtYm+kBOj+proVkNjZInYDvpviSMIIiJqwEziHD8NolbUo7K+YBwM0UNK/gY7eoGxJSR1d1qaG06zFJXw+Qpv7pCNqr9feCLOIZIAgh8f1tM0mR46Z4yx/Jg/tbTxr4YvK03aqoMQwnAX8yuj58bbBO4hjjg56K4npmoDH6+lxkPBTOGCdidli8kqxQmz6jRM8t2F79+WvnqtbGVoVZX/tB/pmss5tCqjmabcaYdmiEJLeSfib8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp+fYGb5TS4MRxHE6HetfFXz4GNMtZ1EdmIvliNJQTM=;
 b=FljQGziSLNKfJhj4ygmVdnDdc6a/psmB2A/stGi+8/gtoKreKTOHKwxSMXZljLXnrFlHTbEQD7BzcbazAMXrHu6IiMyK3q2jLKfwXBVYXqWYjsWsC2R0omSqKTja7CdxsDQytDyzy9CqT3M1fSugqxJ+cP5Fwn3Dcx/E3485pORDkqp5cbP7RyjMSL/dqRASyKVOiFTNTYXc/lpLk1Gn+x99kTicLeYNYyLDBzelZetnfPSy/Xzw9fwEKV4V1kXT2lkFhxIpUScK2Ed2yD2N5D80gEFJB+zUkzrW8I8AIAqHO1yY8vYZmlFtUVsm7kS2Mmai3KAQ+9TRUMnF84ntVg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 09:18:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 09:18:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Russell King <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "eric@nelint.com"
	<eric@nelint.com>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: phylink: add missing supported link modes for
 the fixed-link
Thread-Topic: [PATCH net] net: phylink: add missing supported link modes for
 the fixed-link
Thread-Index: AQHcVSdwds6G1+/pQkasdHEahsrlZbTx2CyAgAADDtCAAAcAAIAAAp5g
Date: Fri, 14 Nov 2025 09:18:45 +0000
Message-ID:
 <PAXPR04MB85106C44F236EE54D16730A788CAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251114052808.1129942-1-wei.fang@nxp.com>
 <aRbpKcrzF9xMicax@shell.armlinux.org.uk>
 <PAXPR04MB8510007477C858A7E952E8E988CAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <aRbxmCPDe5ybYGwO@shell.armlinux.org.uk>
In-Reply-To: <aRbxmCPDe5ybYGwO@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB8075:EE_
x-ms-office365-filtering-correlation-id: b24be9df-7c49-4bbe-5582-08de235ed026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?v8MyoWEjl8ZhpY8CnJd5+HT++ITR0A/auU5WgsnwIIOrGmmYv9a+FkmPTylP?=
 =?us-ascii?Q?4Cwm+p2IHO1nss90SYBnL5IuKidlxedJ/Fo9kNJ0R9rDKzae2FMk1dx3kG2t?=
 =?us-ascii?Q?1OY/ytJM1DYvm8aIpy52yRGpg2PAY/9cyJPggpEIgBx9L+p76gfVSFChQ5Sc?=
 =?us-ascii?Q?Soz2ykPyyKK9NIDuiUfFND2Y461exvZWn92GNMUvjNhoLqD/SNjCgkIq8rSf?=
 =?us-ascii?Q?aV8F2sjmk2h4cJ1Ca1t4d/jpiyI9257egOCkLMhzpz6piXF9+Z2LUE8Mt6w8?=
 =?us-ascii?Q?FiCNuwO9UhzB0iARmyA+7LRmanZapy2xhkJaJe7kSgqwVv8eeA4mOfbYSZdR?=
 =?us-ascii?Q?++Im5t28STq4bsRe9/GAAaFwv8hlL/7TKOaMAwi4fs7T2g2xWKPgGnfXv1rx?=
 =?us-ascii?Q?orVu9W3X+XZiprdT2K3zWeKMUR1wrgWaK0pDM1pnmzkELU6fTLe+saUZB/WY?=
 =?us-ascii?Q?+3M2cioR6CH8NZRkmT4EDETy9dUDV2CQigAT/Or/JVAGdbYcTfVQImBHaws6?=
 =?us-ascii?Q?BUvlzTw4HStJmilxYATI0xa9rb/OCfPsP7wBxIL7MtFKnX4AyFsJ14tQ2/Qk?=
 =?us-ascii?Q?maPbQ0lHaVmUjTIuCAJSGpJddE0k4MhXX8wBatCgVVcwOKurMvVBFoEDZQ+p?=
 =?us-ascii?Q?ObGftHSpCdE/OAQ6qP72BzFPlcDo+HBEHETcER3lE2YVOhNtBg1JbIsjh5b3?=
 =?us-ascii?Q?duiskLP1BIq+OBwoEHkfYR7o3JVQAjMmk/1VsofFolYQxO4JBCxshm0a5UQG?=
 =?us-ascii?Q?3oUE97ZApHiB7kHvpSrv+h8qh1j9IivOFHWiWZKRJKUjOCS7lBjvRP1kX4Zy?=
 =?us-ascii?Q?5eqCCJ9r6v+ugzdaEyxAW6UiKK/cHgHSr1BnHnk1WgIVYR9Mg+0hPmZwJWMc?=
 =?us-ascii?Q?zRpSoxnFUeKThcFVHg9Z/bSTH65avpwxDMQ3hvDGEJpXR567ww3Y8vVbf2V/?=
 =?us-ascii?Q?yRc/7Aj53hwj3FhQXPBXZPXSN6RDUGdPu3PMnA+do+MBWjP4jYYfpabVyQUM?=
 =?us-ascii?Q?oQvq6IWz097+gCnCQIFcwwvbbS/UCsSLrayHK6U+64Duzk3NWuBmTP5PtdTh?=
 =?us-ascii?Q?AJXEOhBNVGPkiyLbSlfyYFSybrLkGKVhDLFI7uZ9lkaUv6MHSEFe5KwaXoW1?=
 =?us-ascii?Q?R3ve6CqXpXzG+9QxazF6S/f13SL/Ts88bB/JzanBt7fNCyLV/2+G4QIQo9m/?=
 =?us-ascii?Q?FsBX4VVSg+rga9zjmYkj21PHHjbsuVb9cV7VAoLEFrF5Z5qmi9DzyxN+c4zH?=
 =?us-ascii?Q?X80nm5HVRjs9eJtV6eAV502es7lj+iIUJi2/rG41DVZTqM4+ibK4nbJmjVwP?=
 =?us-ascii?Q?akDSB0r6dR9YyUiWf2c2LewsxXbadRsgGJztbr9W9zRkNs+O3UX7DSniXVw4?=
 =?us-ascii?Q?/uOsGuz549Y0Bh9OeCwIjUW1F2KQod4Lq1tsp7xMyCwrxpGVVpVGKa7pPTut?=
 =?us-ascii?Q?0B5twHonHRiXwpq8iaaaiLq3X4N5lawHMuXJm+Gmc3Tj3GQ8F/d7GEAAY6d+?=
 =?us-ascii?Q?Hvgp9rUmioTRGRgOPfYxvWlDXMk89NK1ionH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PFE4ka+tlNQXxhcQgTgv1x7q0js4RjqB4fn4fKVXVuDQHyNqMxNfuLDJ1Vvn?=
 =?us-ascii?Q?ChGjrDwVk1CRNIrAWzFRxXs9+hrXESywTJIdo2TH9IK5fZjgWJ/rtXt7dskS?=
 =?us-ascii?Q?YxjbBdoBdKtNzYB4i1Y6WCm6M+nnIaJzNynPxos1axDHhkU5MUEj04JkVWi2?=
 =?us-ascii?Q?xcQTv+Pt/aaY+lAE8fRRoEduu6MWKJKjiH8a+X01H+ohh6wQiklBLHCYCQ4Y?=
 =?us-ascii?Q?9itAusWjnqvwIY1vifaI9Oss9ncVhfezpcv7D0vTfPl0nh/+CI6UwbPOWrXW?=
 =?us-ascii?Q?kb1EprUK8gmtM7kSpNT8mKFKR7pMdluZpM92Jco4PUJhz61NvBRVqYhIDSWR?=
 =?us-ascii?Q?b4Hr4HljmnMcXO4yI4k6TqrCeQd2udacfOz043/sJU8JX865OZJgvQt4j9jl?=
 =?us-ascii?Q?DnoWFy88+ddaDKw/ZW4/gN2+0GhZ6uFFNy0QsQCJzgcA5x+GuvcGwV/q2FG0?=
 =?us-ascii?Q?A5TaFUOEhVNR2MZfywuUIdxqLEp0gyk7ldi3G/fXi9c03006fSKg2C/+2YBE?=
 =?us-ascii?Q?srKb8xFpsoA1Qq403N3OAC9TweI2DuJz573zkhmo/uK3t+JjQx6ZIZiRniNe?=
 =?us-ascii?Q?LJ/2lTFmfuEf4QOtgpd4PJFHx0XE1J0Kc03HnCpvg0oN+l0K3D6c/oOg+fZ8?=
 =?us-ascii?Q?euEiYk04r1xU1I4DQfPYhyuOEYpKGU4ddfUPmiQHFTZ1hcLdhNpJYGaDnSpE?=
 =?us-ascii?Q?tzButmaCDwnoY6lwNuVkfiSNpKfe1NwvpNB/5cgqudeR1frhdqouULpuLETL?=
 =?us-ascii?Q?DBl6YMZ+tvVj+U0AcGP5C2aEAuSyNZxCv2s5TFS/qIlw3W18SeyQUj2MJi1W?=
 =?us-ascii?Q?gRIewZZrNIJGQQSpUrEvgfPsDz2R21vTuEhHxxjuuOEOPYXbX0eWyDCAUyxY?=
 =?us-ascii?Q?yigRO1wfsLCxTS5zax4BLep1axE3KzvM/aWjV8LFt5FXH9OfSVqC0xvaligB?=
 =?us-ascii?Q?W7LYDqAcXB79v7CzK0oDfRHZ5DIr90a/RKBZKHr2+Plrlow3jzUWgqdeWpZM?=
 =?us-ascii?Q?/Ml9OFX0hbnQRe6idjRjXTSyhPMpQ3T0RtBc+i8eBKaCer8r7Y3VsUodsfX9?=
 =?us-ascii?Q?lVv5xEQ7SJbAN6TaL3qxnyK5Nr4F4NUpSbXiwXtz7tjuTYnkVrTzL+SIZht7?=
 =?us-ascii?Q?Aa5PYZoYkw9rBKTvjyj80vmTgJqaY1x67uwWtGPsAFXXHdLJd+rP8Jxb0LGG?=
 =?us-ascii?Q?HJbYjJLkmjZl9pEDNNXV15pj+lEaBYTtGdZT7x/TZ9gN7CgoZgEqPiN6WlWZ?=
 =?us-ascii?Q?f2BaOc1hJMsf+GmyZkKyzI5HSPrPdFE3snCwwR26Cf41p5mzEe2O3F+gGobe?=
 =?us-ascii?Q?kI/zpcfNzZ4Fk4qd4CdCnRRsFqBBiEDBWjeLQT9q3i2Y1mmPDF1eoXIOSMVx?=
 =?us-ascii?Q?W1CP2xct/PPrviNsD383uQ22vQJ54dmwUAWwl8eSsvkkSCkPnWZGY76MogO2?=
 =?us-ascii?Q?vvpXmzENCA9ffEh+DAtiewaO+BR/qrRLwixPqlnyc7aeXs3KLRbjk9S2+f7q?=
 =?us-ascii?Q?1mPw8rw1cCA/fcRcjkutHwiL/w165NH9yd9642T/5wW0NYAGjBRshQ4VCsb1?=
 =?us-ascii?Q?oMym58JTb/r72ZObER0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b24be9df-7c49-4bbe-5582-08de235ed026
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 09:18:45.8669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwJ8kNzpNpM1xfFoy4FtBsgLkXA7AfKHy47ImQCUqofbNf2zaJ3cvoO7qnd1XdxtsiXT2QHGtjY1a3/MDFSlUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

> On Fri, Nov 14, 2025 at 08:52:07AM +0000, Wei Fang wrote:
> > > On Fri, Nov 14, 2025 at 01:28:08PM +0800, Wei Fang wrote:
> > > > Pause, Asym_Pause and Autoneg bits are not set when pl->supported
> > > > is initialized, so these link modes will not work for the fixed-lin=
k.
> > >
> > > What problem does this cause?
> > >
> >
> > Our i.MX943 platform, the switch CPU port is connected to an ENETC
> > MAC, the link speed is 2.5Gbps. And one user port of switch is 1Gbps.
> > If the flow-control of internal link is not enabled, we can see the
> > iperf performance of TCP packets is very low. Because of the
> > congestion (ingress speed of CPU port is greater than egress speed of
> > user port) in the switch, some TCP packets were dropped, resulting in
> > the packets being retransmitted many times.
>=20
> Please include this in the commit message, thanks.
>=20

Okay, I will add this to the commit message in v2, thanks.


