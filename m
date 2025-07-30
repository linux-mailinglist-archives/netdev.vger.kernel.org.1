Return-Path: <netdev+bounces-211020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E9B1634B
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 17:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DAF3174D9C
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 15:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92972D9EC5;
	Wed, 30 Jul 2025 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b="eEZ+uNn8"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F617C21E
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753887827; cv=fail; b=cGF5lx70sqMK3bw7T83inVzIxmYoP18BvW71hRsTPdsiKBBRHWqjDLi9lewCX2f969raUtmTjHL+0voJL5K4ussFCiMLAfEYTxt4WuPJtovAyNy+luae83/XAu9/gzgKOvYUrJxhMfqEnk5DTy3QvF1L4U4NE62ocOHpdptP0LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753887827; c=relaxed/simple;
	bh=k1b7VnuijS8EN09EX0Xm49B1LlDUWt0Lr24zHLjWZsE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bAxrJ2KdhxpmRmNGgjffRYGoM4C8+f5sPMzFzPolGMZEQWd4kDoqwlP6ybPA6UX7R6rYBbVJ13F1ZK1WqkQSKWmBxOT6RuI67mDY6Hy3mVdclgI+kdt0XpIFjW3NBwgpRohMrycQXJ4mxKYWzLnrhTGKlVV1NbSXCC1VeuH8feo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com; spf=pass smtp.mailfrom=kuka.com; dkim=pass (2048-bit key) header.d=kuka.com header.i=@kuka.com header.b=eEZ+uNn8; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kuka.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuka.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwYh9equIJKytLelqoXBy4ygVJByAkbHSeUn0UsoB+nI6l90YXNVAb8B6c3xFIczl++JQQfML6bsHds5etRtDWWjB+zFZ66A0NwegSias9U8gQWftgqaxxyZzgWVM91U/xLUGeF2UKw5gfqvlQoqp6uYoEYhuNhxjyfhRbqXru1yalHRJ7m0F1R0LmVH0jUaZj60VKLDknZMuuzsIJOBBpXZI5e770ZqpA9rbfVeBJPeuszXF+NjpVcHLRWhzdVVPMZYYl4sWHcevGaK/T0zWykt2WBobd39hvuNihZ10eL7Irc8kmIE/FoLo3ebzkMTocI/B6+Bf4mAQ+IZqIpQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1b7VnuijS8EN09EX0Xm49B1LlDUWt0Lr24zHLjWZsE=;
 b=Y3cm/zXbzCA0nlqZi5RffP9UDCqXCqaGj+DlKRMdGQYDvHy2BGLDrTOc9Nx0Lr8KoCDcxvyKhJDJXXiLz/ZyH4aYyBc8/+G7TH/hsa6oXqBLoeKRtaGoAM9S4gZm7Psu3piNI7RRVhBQYpdgidHyOolR5h3gOWH3athTed5oFHc95fEGINhEhP2R0scnAWfhPITq95loA7fLyoSlUfEVEdROAYUmMB883Iqt/0CX6VRQDkN2CfHkWm4AzF2Rs6+Z4get8M2XjCQEDMXE3gHfYhqI6nc4WOzFrTpYb3u/AkqSpADufAUKW+r7oK/IPecqucLDWWTWA98hkAgzLmJ19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuka.com; dmarc=pass action=none header.from=kuka.com;
 dkim=pass header.d=kuka.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuka.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1b7VnuijS8EN09EX0Xm49B1LlDUWt0Lr24zHLjWZsE=;
 b=eEZ+uNn8EfxlJdFehSSIUokjnOIsAsiRorsi6hqbe6WDaZ/tgPolf7/crIomGJaO+iHiYVEdv4QhdSzmVul5fgzVSUL0eH2EoV4RD3/rjN1mv/ZFmT3Db3VzqkcuqKlCRLuHo3Fz5/xIVXTUDrpuSPUkN58ld/Fy4LK1OqqcULPsS/d+6Qw9pIGbhIPFlRBP75Nf91CqH3IZhtTtcITh4fimP4nTcWGc998iBKE1PODqxl/7ol1iX7kikQ8frW/Pio5UYzUcn5ontIDE0sW4I6MWVCelLyV3SyRxW9hJj6ukgAMka67nZ1pJSNd5m65Pbj1SjNpT8vZDpDWOnXGE9g==
Received: from DU2PR01MB8701.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:2f8::14) by AS8PR01MB8090.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:379::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 15:03:42 +0000
Received: from DU2PR01MB8701.eurprd01.prod.exchangelabs.com
 ([fe80::835:aea2:4874:b42c]) by DU2PR01MB8701.eurprd01.prod.exchangelabs.com
 ([fe80::835:aea2:4874:b42c%4]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 15:03:42 +0000
From: Daniel Braunwarth <Daniel.Braunwarth@kuka.com>
To: Andrew Lunn <andrew@lunn.ch>, Gatien CHEVALLIER
	<gatien.chevallier@foss.st.com>
CC: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Heiner Kallweit
	<hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC ???net???] net: phy: realtek: fix wake-on-lan support
Thread-Topic: [PATCH RFC ???net???] net: phy: realtek: fix wake-on-lan support
Thread-Index: AQHcAS0PTqrXikeSVkKm8+dSQmInlrRKsf4AgAAG/QCAAAfRgIAAANxF
Date: Wed, 30 Jul 2025 15:03:42 +0000
Message-ID:
 <DU2PR01MB8701360F4AAB1FB50A98368E9624A@DU2PR01MB8701.eurprd01.prod.exchangelabs.com>
References: <E1uh2Hm-006lvG-PK@rmk-PC.armlinux.org.uk>
 <a14075fe-a0fc-4c59-b4d3-1060f6fd2676@lunn.ch>
 <27e10ba4-5656-40a8-a709-c1390fee251f@foss.st.com>
 <a1c121e1-cf56-4798-b255-96f29cab80ec@lunn.ch>
In-Reply-To: <a1c121e1-cf56-4798-b255-96f29cab80ec@lunn.ch>
Accept-Language: en-DE, de-DE, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1b46921f-d37c-4222-b9ef-5dad63b5080a_Enabled=True;MSIP_Label_1b46921f-d37c-4222-b9ef-5dad63b5080a_SiteId=5a5c4bcf-d285-44af-8f19-ca72d454f6f7;MSIP_Label_1b46921f-d37c-4222-b9ef-5dad63b5080a_SetDate=2025-07-30T15:03:41.8890000Z;MSIP_Label_1b46921f-d37c-4222-b9ef-5dad63b5080a_Name=Internal;MSIP_Label_1b46921f-d37c-4222-b9ef-5dad63b5080a_ContentBits=3;MSIP_Label_1b46921f-d37c-4222-b9ef-5dad63b5080a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuka.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR01MB8701:EE_|AS8PR01MB8090:EE_
x-ms-office365-filtering-correlation-id: 34540afc-ad39-4564-3ae0-08ddcf7a45ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?U/QuTWZDIEGczPxl5BsYScuT7tI33PUcUak4hZ8Vrim5cDelVQcuCz6GaP55?=
 =?us-ascii?Q?vDTkpg/tjeK/qZaGDDlVGemQTGgGxtO4++TrHYPdWA6dKgMmF9Xg8MLZLiKy?=
 =?us-ascii?Q?hCwuEmNxwjcec7/Z8jhIiieG9IzUgIKbCfiqrr1dBsOXVg8M0dRohCzkDG2W?=
 =?us-ascii?Q?PywoPlwIe15fwKzrh2iz82qCdaApPcbZm6KsHS/+KcFhO6hLxUp2fp1tDZ/q?=
 =?us-ascii?Q?+So1vcmxtXoM+aiMNZ5Ov+qKjajfMnAGRjdvcrhreg2wwE9GwoKTyrPKZ+on?=
 =?us-ascii?Q?SiDLScKzzEgm7xljbCmXAY5B5u9fTftIIFv8NQRp6bOBTNcQkpscGpPh3ROt?=
 =?us-ascii?Q?tfwuufalvnmuw2ChNorDy3frAvPhUeFQ2txaSB/LmZAVS756zRtObuavSxMe?=
 =?us-ascii?Q?kmZNAkIP2aXES9uSRNmDUSEF1aWeCVrxOZDVGigovoqm8DMrsye5F2gGx77C?=
 =?us-ascii?Q?CSwW4LOmQVRdAGGkuonaan0lBTx8EP1sGO6mpOXz9N85bL6pluwUPtkFxWHS?=
 =?us-ascii?Q?N4V84RjMKSUxbEj7ZwU8bucUs0dF0pcBqlcJbovveCO3GHi+0hrWjbRZsZik?=
 =?us-ascii?Q?/n15gfvrEYlmKXliCrHxRVTp5I10Le4H5TCkK9k+BJrEeXBWX/NlrCn47taI?=
 =?us-ascii?Q?UXNFKzD51mb/0BkOpQeGS7V6Q9UlhKMFGcYvdiRMzoo12QAyXePrCkTzjKW1?=
 =?us-ascii?Q?PEp+GP8nHvi6DIrAXusp6pl/hf/RhPuT877B0SGYc7d90hrgNdyO/mnSNhb8?=
 =?us-ascii?Q?LXCwep5ZbBBSrN/jRUHqCxDMUzfUDvnToJajWUR1vIZOvRWA5TNJ0fKYHCUP?=
 =?us-ascii?Q?+AwSAfOfCGBu6eFJ3etXg14RaOxA1+2VhEtrgLwx28qlXqND+A+WhG2h/oJ7?=
 =?us-ascii?Q?7uU/W/10c6Id+pB21WtYtws25H+fq8FTcs1Gq4BlUI7cOyM+NSYT5/hGkUX/?=
 =?us-ascii?Q?ZnQvTWokxeZBKmIfPf7NhrqqLN34VMAnAPsmYr6cbS5XeyTTX5vsAaD97scp?=
 =?us-ascii?Q?YSgWuxYOVlSPpDy6Lyjv7Y2WEuvo31q30sh0Bfrd1mrls5BuBFvgM4JRlZmK?=
 =?us-ascii?Q?Qqm7wICsdJiNAsdY8h4yjTqRnPHBGtaOflMjCQvn8TvHYqDG3t8fJz7rF942?=
 =?us-ascii?Q?Lr5OO7dmoJbb+g3B2t5CQMnq3DOxKUJ5EIPOXYEW9WakOH588IFY3S2zEsXN?=
 =?us-ascii?Q?jdTkLVuK8ZzZtUGhArY/Vo9+z0IzemDvp6+5deZ1uPuX2NzcLUP9MsOsuTCb?=
 =?us-ascii?Q?oKqoQ+SFu/MXs5wcYg0HYiGZpArKg9mb2MZUo1SgHX2WDESfK68Bw4AaTKip?=
 =?us-ascii?Q?wjCqdM2dzccNKlLgB8XIr8uDpYoRmtCPn96Qq8wSpPafnvuXBvjkocr86gwt?=
 =?us-ascii?Q?FSwyHe9fCKfizVz4UmUL9kECunb6+jV5MQc8QYO01hWV9zcZnmlza0KtwcSy?=
 =?us-ascii?Q?Eg7fcRNPp87JHXTROP5Uxynmx40xt3p4NM2TAn7a1eKZmyYgZzTWIg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR01MB8701.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?S9T5DCN0oM1O8QdivE/G5qi+q7xxzdijX4td/BOZKYwNLaqYkxvmkazQyCFd?=
 =?us-ascii?Q?EyKSvcu5Oz/ohq+bL03ZnoeUY71r+wR2ErrQQqV0MWf0ijHQ6ZHp/VS8dBpF?=
 =?us-ascii?Q?KqB65maMwaxhSq9477zELkDf8s9k5/rXaUgcsIXvttw50re+nBi81+xc7hXt?=
 =?us-ascii?Q?qU/v86z8IpGmNOIpbj5mocwXR7hUCVtsQ1m3m8uWQ5vPYblxlaI9hqcpylfj?=
 =?us-ascii?Q?TERyO7r8aKkDsFbfdQxl/ZcwhUXIPF5p+XCIVwIecjlC4MRslSorXEedW4UR?=
 =?us-ascii?Q?hzKMkn0PiX680nzYfrrxa9bLKL1ilbvPbQvxDmgG9oZwGAxa7K8G1zuZ5DI2?=
 =?us-ascii?Q?8o7sl702brMdIoDtBCAxTe2eHBhGIdDHBVjeYbR0d9U4J35bmv7uHRPTsTTb?=
 =?us-ascii?Q?kdTvKLbq7352CrMtLt1krgWDGrppr7wSN5/ZEuvaqHhpx8TKtlDQeoaz94vl?=
 =?us-ascii?Q?B+IpvRm++1dAUmtgUjZx1kWmQuKjMMaHOwXUtcBDLQQIICBDuEYPbps2TdTn?=
 =?us-ascii?Q?b4oHPzYrICK0QEyB6xA38VKxPjXoFsl44zOzj3p0IzBJgklCPpLPy9KyGlsu?=
 =?us-ascii?Q?u1/AzVp4hdVhbYwZoFQuJdUhl3tOtSf1OT3qkKTv6kfXCKZ3uHsrqlV7kcm3?=
 =?us-ascii?Q?dDK+lHhDrsFknBASqV/fP+bffdwrw8Py009sboRGVitLRT6D0ysdmsXErcpi?=
 =?us-ascii?Q?1SYpNrtNEvtUbwnxuSb6rXg5Nau84iGsuYwpC5a+uzvWMGh+56nQZh1iqlPT?=
 =?us-ascii?Q?qUzwoMUg5/O7GUD6QZ3VX+g899DGcnPN8WaWjvgsnEnX9nb2uo+XWM91n0aK?=
 =?us-ascii?Q?t6mZ2CZraj7NuOdM4AUK5q64feC6Lj78sCSLMp+bLrQ0AgmgshbYMxS9VaEc?=
 =?us-ascii?Q?93Y113UST0sOSKIJ81I0Feh+y1SkluhcB/g58Aqmq001FtSyuF58nsAuBkaA?=
 =?us-ascii?Q?WOiXy8KH3yuIbaQ1XdOnpWHxtVHo6KaT98l7+OI5MQldQsRPXTLXdC4yr7z8?=
 =?us-ascii?Q?p8Z16mzL8jR8eT4VEiNGRwIx683Kw7Qwhzt3F/qh0qRNzuB9jysXBKEjUX+G?=
 =?us-ascii?Q?BUngYWU/EjPs5/2bPfN0BZH/TAb0a9b+eEZInfAMwEQ+ewchLeUxgDQGQM0v?=
 =?us-ascii?Q?zJ6zgoLXWbcl3W3Pq7OgyUCkWkLFD/4tgLFy2aovU0CJvgVaXbDi0gYG4GLD?=
 =?us-ascii?Q?j0HNe0RHqqEVKcyKo+p5dljSPj+Hg659eRg7vTS3x70yRbH2AYY21Acpg1p3?=
 =?us-ascii?Q?z2kMvka/LBxxUTDKMJyyGEki9P2PDZc9DsU7R6iJo23h6LjPFJgHDwCUVpAY?=
 =?us-ascii?Q?9r38fCpRWgCVGn6ONKEwPOfaIoEjFiz3iWdz/6pGqAGX7zSuUDvntDpYccpN?=
 =?us-ascii?Q?FUTqt42ZUPwzweQUPFjX5Kk3tH4alldCBd6dBaEWINfeXUujzsVaIH0P0aZo?=
 =?us-ascii?Q?F7XdbDoo929vta+nOXphTi8RKGaiN1obF3apCxzIHZuWi9CkhdREtTEY5oeR?=
 =?us-ascii?Q?NS49/shnaKtukjjCa60c3H9O8TSWI5Nl5CbCGG8PEfxcSax/QN4Ma4Gd9Rm/?=
 =?us-ascii?Q?VMWd5rkx0AZ/lihzH40JDPGQjxI8n0iBfwO6fHHC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kuka.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR01MB8701.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34540afc-ad39-4564-3ae0-08ddcf7a45ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 15:03:42.3741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a5c4bcf-d285-44af-8f19-ca72d454f6f7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FC0+te7eIKaKUv7RFiqBOOnIOd9lajf6vbFdQUwEhBqlXQms6Iw8fvNNrGlxP7eSPF0IlzHEJiocHBOpQPQVYfILbQZerypKabWKTcl6eCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR01MB8090

>> IMHO, I think 3) may optionally declare another interrupt as well
>> for WoL events.
>
> The 3) i've seen is a Marvell based NAS box. It is a long time
> ago. But as far as i remember, the SoC had no idea why it woke up, it
> could not ask the PMIC why the power was turned on. So there was no
> ability to invoke an interrupt handler.
>
> I've also seen X86/BIOS platforms which are similar. The BIOS swallows
> the interrupt, it never gets delivered to Linux once it is
> running. And the BIOS itself might poke PHY registers.

That's like our hardware looks like.

We have a TI J784S4 SoC which has an integrated 9 port switch. One internal=
, and 8 external ports.

It's similar to the device tree in arch/arm64/boot/dts/ti/k3-j784s4-evm-qua=
d-port-eth-exp1.dtso.

The PHYs are directly connected to the PMIC of our board.
We don't have any clue **why** the PMIC wakes the board.
Could be a WoL event or somebody pressed the power button of our robot cont=
roller.


Regards
Daniel

Internal

