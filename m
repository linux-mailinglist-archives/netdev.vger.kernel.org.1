Return-Path: <netdev+bounces-239013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4DCC623C6
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 04:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC2AC4E1E85
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 03:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E0E27814C;
	Mon, 17 Nov 2025 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IjoWh8we"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA32853EF;
	Mon, 17 Nov 2025 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763349790; cv=fail; b=PntkdxZ7KbnU4O+FD8fh2zxjTkddkYS7Mgle0bIyGqMi8Z15ZFmv+14Ry3vBxHAH53hR7WexU88AJPAPi//7XVzaZNaUoYHE1wb1Plz42Otasu6tvn4S5ak6owfjffI5gVaZ5jFUtiOrpQZGIsft4ZVART9qKEekFap2+DyW5Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763349790; c=relaxed/simple;
	bh=REymtFGS8IrQJ/K4bLmtmxQDcAEBrAauvDQfn4PEx+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FNhGH44pG5PyJxUpccvuFm/CduS3NycWtkvoTBHGTlFVCLHhbLBUGH10AQRKkjdDwG+OoTQhqnQ1JFheMObLm8SkhNwsh08K7T5gRft08epC4Kssqo4LUbYukY4pJYYXfj8zf3wx4pHmtVRQvwORXXqd4UjSwSvsySaqwQ1Tp2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IjoWh8we; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGBuZ0cWvp0O4mLD+Lt4CE0Nxn/zKYB/XbnAsXlo3ekQQpvcdxLuP33TbTX6qVMCTUbqavZJAd2eVoCdrw+EWGB5PbHvAlzMn6A1n0M2GYNpi0hcz+rAjLhE4egP3kq2v7RHLes7m3vK4w+xCtM3s1Z73ef/gxu7EFF5bYY4VheEG/UCtdcKUU6wUFJn8s9VuwDEADdBQSPQzHkcBKluOhGCVe20RhO2S3ShEGJqWJOdkVaqpSJluWv+3pMn2uTTuMgt7EyXi0o19ErDggDMbIiF+orMpg1Az6hDhP2i1+5bBHwwtjWDZzvx2TTUMjYfCLZ4nxRC55rKHlEe62p1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgMXit5ouj3APQ0NUE22fNbpyszMbiqt5PkHwt12tBk=;
 b=uZMiZWrHcXSv8QH2tmLDbCToleDZWnSowA/killvK1zhJV+OV4hoDW5fQfg8waikIwSEGGF8UoJbvpfe+fTSxIxqLniOdszKQtmo56/RbR7HKWntTHqPFgUDfUcFQbLVBoppu3tCevKUwdGrUMwReYkuf9r5FJJT83iFlohjJktScFH6LWoIaGxxnSXf7muh0Fh6Siq8jmPDoahcSl2C5Orw6La/wPe8rQdJKIPQCXqLgjgzNcsyvCO7dv2Rh5rtvg9eqJL0ABs0ExDYRkwV+JBjDQg1VRoFvoZAqO3gMwIH0cY4CRMG0er6QNPV4MvBq60pjFjcC56CnvONdZnEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgMXit5ouj3APQ0NUE22fNbpyszMbiqt5PkHwt12tBk=;
 b=IjoWh8weG+Zj3rgoNzTtp06LGimdWV/NbVi2wNQnXAxHVNZmE+bD9uYA+SsHaZwSlzTVEDsx2pu+Q4iyrRh9l+buGF3MI6LT6+79/Xo0zH45pWnBHgv/AdowXiBAlvXALSOqSoX/1CbnR52KAVVt0GE0jzp7pONqYzcLqR1fdksFjEJLecoUOD3Gl8/zGsZ9pYOG4Lr9vHYZBwGNlGDXQfJ7kTYKIiWjDtOflq0vGcGFY+FruU7jBcrqiyLZ2oXGCcGmF/d7OmLmBWzSPMQfMO0dozhid2eMon/tsDIvhi5303qLHyr9sO6xPG5E2GDg+v36M/tS/pXifxyah7EyLA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by MRWPR04MB12117.eurprd04.prod.outlook.com (2603:10a6:501:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Mon, 17 Nov
 2025 03:23:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 03:23:05 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "eric@nelint.com"
	<eric@nelint.com>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: phylink: add missing supported link modes for the
 fixed-link
Thread-Topic: [PATCH v2] net: phylink: add missing supported link modes for
 the fixed-link
Thread-Index: AQHcVqH8wRDKQtD4n0GYxJSxykL38LT1eb2AgACkdeA=
Date: Mon, 17 Nov 2025 03:23:05 +0000
Message-ID:
 <PAXPR04MB8510785AF26E765088D1631788C9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251116023823.1445099-1-wei.fang@nxp.com>
 <30e0b7ba-ac60-49e0-8a6d-a830f00f8bbc@lunn.ch>
In-Reply-To: <30e0b7ba-ac60-49e0-8a6d-a830f00f8bbc@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|MRWPR04MB12117:EE_
x-ms-office365-filtering-correlation-id: 16f1856b-303f-4237-518c-08de25889f5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?n8ZScmtm91tLVd/f3twwpKEYsA2epaYcQD5J7sMCmS/vuQprBbqyKe5We05M?=
 =?us-ascii?Q?o+x6LAK/4IAU6yI5h0J/x0yL8JwD9RHcIpG/rTAuOnScyHuG+82UUmMS42Pd?=
 =?us-ascii?Q?L7xIReFhvSEi+80IUYVfTR6fzDnfvNB2hiDqm8r8aqq+ziKMA/fA4suJRrn9?=
 =?us-ascii?Q?y6aM4Gmjt3V+TNtz87a4sNX/cH5rSC9Cr4W58UgtlIKNOBxt6WTDMLQmTjFY?=
 =?us-ascii?Q?7nMt6tiv6+Ee66MrbdfBDQ5dRKc2BXgL9QhN25TIx4PmeYbMjfDZ1qaBBVpB?=
 =?us-ascii?Q?UMx+eZzKMV2hxZDv9JNh7cgqtYfALtlXFgB4f0H5yqyER1tf2OJgqwtg/+2e?=
 =?us-ascii?Q?URomctbPSCR+lJEDSZK1cwv9dHlVO11RILZIyNSdoZm9eRO8yOpZn8+i8wcc?=
 =?us-ascii?Q?y4TrMjcmBIGn/YFJ2m7ZKyLQZskUN1mK+N0mDxvEx5Z/z553nfgZ+2KfFY9J?=
 =?us-ascii?Q?zmd8hBMDtjHuybDFGRGINvtGyc4FEjj/wKZv/QZGsQqasfVw/2kj3SkJvQxK?=
 =?us-ascii?Q?3AL0WV+pSAaRJBvHLneERQKN/nvU36PBC4R0uro+30/N0TRATt1dLt8GIVsA?=
 =?us-ascii?Q?i5Q2fVHtIXtQ04XNUld6TYixV1XS1g8Td1XbqAv36ZujTqHrdNwtwwhPFY1m?=
 =?us-ascii?Q?2PbtKiINKlxjpWAotacDmF7L11iikVUaiI4L6wI4OlgeElCIp9tb2mHvNQnD?=
 =?us-ascii?Q?P+yDjo9VdOf9p3G3FscrvowY74DQifZckAI2C+OtNMTPupY/OWx/FqqWjKBu?=
 =?us-ascii?Q?bdf++6WqE38mO+v9F2dPIRxfwdAm5lxoWg8Ztp216KpcSszeqnIL104WQ1Ko?=
 =?us-ascii?Q?b7QpVFFwrdNrFYo+/nuJB72evh6SASxY7/6hQdGobcK2HF46JK97HqOUPCe6?=
 =?us-ascii?Q?gaAut0uR6WWMTbt1KTmGae8JZ7wZWNaK7d9T0Es3I+n7mwxha20jaAXMz226?=
 =?us-ascii?Q?x6gsgE9Y0Q37bKo1z+p6L6UfLikzfFcIuAGOAnhi2ls+44ohu3FNR9RzZnSr?=
 =?us-ascii?Q?nA5v3wVPsA4MEttCRmW/+bYsOL57CbUQAeNMTwGKFpSafeIZDX5Rtdy/NMug?=
 =?us-ascii?Q?+CXQXPD8c9mJEDJ/7rkcFHFdxDmPx/UWvfkpC+9oiR+prPUYXTgxPM+SZGMo?=
 =?us-ascii?Q?y9kvvu9KIzxw5BJKtca5/Xsf4FqmXG2LrkfL5AruAgMNiffuBATrs0netM3k?=
 =?us-ascii?Q?3LZHWUP6kkyJRwUquH6T/QAraOujZOTTOb6EgczT0/X2LGwq4tYj5jWlp18O?=
 =?us-ascii?Q?x5oTrUTtHWysjD393cgCVrVH2qLin4U0Uek3XEzW7Rt1gOkVc68OfLM3nCZs?=
 =?us-ascii?Q?+PCLIFR+FFFJ9fql7uMD6fASqhFnWfxUKLkHBrjg6jC/AAAFZz5g+ZNHZVK8?=
 =?us-ascii?Q?lOXevmi2LNcKG4ZgcrqWD0e6LPwWlXzkbdy5MXqqTRzY5eXIsODPd5a4luC2?=
 =?us-ascii?Q?8KZBBCnLn+5/uTMpYaRF/gRiT1zUZ+HD1nji8+WYcGqQ/XhUmEVml/Fx0eVq?=
 =?us-ascii?Q?ZqwWao7QvVtN4eQ0NgIOEQIa8e4UuV8NDj5i?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d4DFmHLjELXUq4ToBX7xTjwmDWSxCdEFPO2tjnW8wtrrUucBKVs11hgS57i7?=
 =?us-ascii?Q?0TPJMKB5l5mMYEiuEalNRwJaMO6ky7TF/k7EMpFKdYYOn9tQwDw99x0z3RYT?=
 =?us-ascii?Q?otwVfdd2gxe7UKi8LHb9czZpO3pzr8V87j8c0n9fUjVpz3J4ldIV8b8w/t4p?=
 =?us-ascii?Q?Ejn+xfSgt5BBujmQsU15o374Q2yNvel4PX34H1fJqLfYjnd5ks7PpUrM1/zC?=
 =?us-ascii?Q?rVqQ409QRnE1/nDVfeO5ZXnKBcFrRofmthQBEa7nkoRBziO1AOrDzSDr0KMg?=
 =?us-ascii?Q?C4cblKBcfTNRmkk2owr6J7Pub6buOBEMimm8iJTBjGpxb8HBG1qizcB8dwRs?=
 =?us-ascii?Q?AQJKbL1P5CoDsJ5EDthnqjHvL0GGbEvTMiSvoKYWq3JLt48V08I4bDLgSj+8?=
 =?us-ascii?Q?Cfj3Q3wUdpp42CtuMyLwKCQyV+38l+Q60gyY0UTyfKIQRcvXFUT0R1bxfWIH?=
 =?us-ascii?Q?hAeX3qaf8pBN5q6sN+Ak/4UYfAbXhFuhOV4IRZarfbtsDnGoIDIyDI8U+Uma?=
 =?us-ascii?Q?1MLi/+Xc7pkidoH5la1j4Zh3BtSkxZtuMUN3ldxzaQ7sI1UAFAcMdtYM38AR?=
 =?us-ascii?Q?kDxQ4gLniVmM6W0bTDdac37WLtSp00lPKZuMJG55bQ1Y0VzuUPprhjoWdYqO?=
 =?us-ascii?Q?XYHoqohwXugRKgXaRfx7OQ7h//NC2YGwUMYoDJjcNwZZQmptuhg3LwXsyUKj?=
 =?us-ascii?Q?ake0FfTwuUg6y+ktNSd8i1oJqcqOkEjU2AoKjfXRZT7vluzbZ9AhCCw6RXgD?=
 =?us-ascii?Q?mYuBgc2kt9S8CmlntLbrdo/ZcFbag04OgYDLx3mcvOCAsBjtoZIMaqbR57nP?=
 =?us-ascii?Q?1JtTIQq3eGJ1/1CBrjrDzP4+1RTu8hMQ30FXA3ek8IQORK6CYEUxB4D/ia0r?=
 =?us-ascii?Q?kGno8J42TZgIjQNRrDiwAKQ2vyJh4gC/BEgVto2uCOu0xKH82Ry4HAN+I7YE?=
 =?us-ascii?Q?ATWUqs+2Zp0tSdLklzfPIC76EuoAo8FM2qA6wGHifaua0FeBrG3ZvpYdnvYF?=
 =?us-ascii?Q?/CstZyNTTXOEMZQrAnujgA62Es5LSUVX7bCul2nX8pT9+PvN7KaDP9i+lGlD?=
 =?us-ascii?Q?6//u2aGMzQm2HjCTqDVaFn0cwzExgVOcj5aW5KxvhuMa/tzHVRGX8iqAcG3k?=
 =?us-ascii?Q?o3vTtRKkUk4Y56OfPf2cR3x7FijHGJHuMmMKwkIJptoP1OclweszOOpALKhm?=
 =?us-ascii?Q?M5mnuuqW1ERo41p64C2BQ1SXx6LFbtvgtB9t8ToKph/mHM1ayQhlcilXtlEz?=
 =?us-ascii?Q?EfQRIJfRPyaEe2RMXMM4jsQQBcy/sh0o7E9oKBX1+hE8rP9yiQxTdDMoQnKw?=
 =?us-ascii?Q?E4Kim6xLedon2mGicTWcBKZ8l38YgSTkNlfy0kPJRdxqFy1lvP4eTABgEKNj?=
 =?us-ascii?Q?YDec/qH8MkzcAxYB9LtQGobkfujPYqodnrzjr2ZUkdTKzPR1x9qwBU8QTKg1?=
 =?us-ascii?Q?CO8G/8OnaOsJi+aX2VP55voaMoIMJjNaAD79nFaEY69kN7xZ1CJsFWLSq/zr?=
 =?us-ascii?Q?IYLizTyZN/HT1lZTzFmStO29H2yZIasitOSZ9X+TyJB1sP5cdhjPcfvg1QOc?=
 =?us-ascii?Q?XOeVspeNpekVrQqXisw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f1856b-303f-4237-518c-08de25889f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 03:23:05.2055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KyUnWTWhpkvyBf2ojSqg7PZsxO5pBXewzKlSfDdvGJMt56UyxReiy9UqKyB0F1MFtkLKB8IUZ/n8RUxdpqZCNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12117

> This also seems like two fixes: a regression for the AUTONEG bit, and
> allowing pause to be set. So maybe this should be two patches?

As Russell explained in the thread, one patch is enough.

>=20
> I'm also surprised TCP is collapsing. This is not an unusual setup,
> e.g. a home wireless network feeding a cable modem. A high speed link
> feeding a lower speed link. What RTT is there when TCP gets into

The below result is the RTT when doing the iperf TCtestP
root@imx943evk:~# ./tcping -I swp2 10.193.102.224 5201
TCPinging 10.193.102.224 on port 5201
Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3D2 time=
=3D1.004 ms
Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3D3 time=
=3D0.958 ms
Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3D4 time=
=3D0.989 ms
Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3D5 time=
=3D1.040 ms
Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3D6 time=
=3D0.760 ms
Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3D7 time=
=3D0.950 ms
Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3D8 time=
=3D0.726 ms

After applying the this patch, the RTT appears to be greater, I suspect
that some iperf packets preceding the ping packet are being dropped
by the hardware, resulting in a smaller RTT.

root@imx943evk:~# ./tcping -I swp2 10.193.102.224 5201
TCPinging 10.193.102.224 on port 5201
Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3D1 time=
=3D0.819 ms
Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3D2 time=
=3D0.752 ms
Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3D3 time=
=3D1.190 ms
Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3D4 time=
=3D0.932 ms
Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3D5 time=
=3D1.137 ms
Reply from 10.193.102.224 (10.193.102.224) on port 5201 TCP_conn=3D6 time=
=3D1.279 ms


> trouble? TCP should be backing off as soon as it sees packet loss, so
> reducing the bandwidth it tries to consume, and so emptying out the
> buffers. But if you have big buffers in the ENETC causing high
> latency, that might be an issue? Does ENETC have BQL? It is worth
> implementing, just to avoid bufferbloat problems.

No, currently the ENETC driver does not support BQL, maybe we
will support it in the future.

>=20
> 	Andrew
>=20
> ---
> pw-bot: cr

