Return-Path: <netdev+bounces-224699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C275B88788
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F15AC4E0336
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B322C028E;
	Fri, 19 Sep 2025 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WqUpVnr6"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013032.outbound.protection.outlook.com [52.101.72.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E7C2940B;
	Fri, 19 Sep 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271742; cv=fail; b=uXCtqZTkzCUIcXJCsjAMjLuZ0+5J6gVK6NcEh6AlwJaH+wGxsdftvYvfZVSvmWjjhRyrhEenYekssvwikxgj4JxVVILeC+Ua/SYhEnZ5MIkShy3RXdeDD12ufclf1kpy6UJX12/LcFvEdDte3Emvl2SQqgsMX+cPqeiGrmq8ybc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271742; c=relaxed/simple;
	bh=lvEOAmczBBUOOndAZaMJs7H94T/AraA/NEza6/FkBXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TL+0w/9G5CqxXUURFdUB999UxuyMKNBgt6/WJ8nW5Y2/LzDYyaPy+/OBvxOk2DaNbRjDWyU0c2FzNHsT9dNcapahFaVjCAAn3rQSrmd5c4PZ8SxPWwuC+Eue4bv0sDt2wz1Oa0GjZF0hTgTJImtF8hdWeaa2wrbJbF2RYVo6jBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WqUpVnr6; arc=fail smtp.client-ip=52.101.72.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6izB/qicKRP0fejYW0twyN5oRHsNYIcKkwChq3AaDwCTG2ltXyr3buzlNe7n9bPPFrsnM2NNBmDgqkRz5Prvzmx9OuiM7Gm+tfDqV6hYOTQEdWv00k2A7PuBj1sqgzPmV9X3yF8OJ/Xip3Uq3jNUkUA+REC5QVfXPVyjKg14DA3Vz7qWGyZfCeA7MHc3YBfWQy87rKu3c8SoCS60ffmVOw1eJi4ZN7UM6lxNRi2//JtdEY4nBPSwCG9s3ZELNUwIUodUcosa3yduQJwr3xDpcIEXEjMNsFsd89alCyO0QlxLrIoM71vWAgL3aDkzL8SNK7qblZHTATiitsElzMY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvEOAmczBBUOOndAZaMJs7H94T/AraA/NEza6/FkBXA=;
 b=qDgPzNBEquzrbNOPrsKNzeBAO4MdVx7elOGZ1tAcUFkKTO3r7bVjF6LK2FEJJpjgzOCzvKBMmi3F9pOxGHfqqQjrYGwuJSJArcwS5XOqswdLKgM/0DHSS7+Mkwl2GTEmfmWhpxfIaHM6qh47InUULTF03VtH4wgFgqIhiCWRuKyUwRrYfQR1v4M4NxRAKv+bgGvCM8B9cHZ5OuRxHKcEoY35C5kPLqtGOzO2WvpA/4/hg+PRMt70fl3wUQYDYV3bIECq10ChHfqmGFFXk9DwSM6aRB6pWMAtOzrWRIBE6afGC876cNjCzX0Y5WUOVOxf1BzEVrOik3k3isr23/VmZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvEOAmczBBUOOndAZaMJs7H94T/AraA/NEza6/FkBXA=;
 b=WqUpVnr6s73/eqH6uqZ1Hg0STmSmHAUFVF9l0mZMQo1wrYc9Mn/Y4rdbROH8lxs58lL9VRHXJrFvSCDK95r1Yo6lxR6BnhHi+hBW7hLcf4PZZAmOu9XMt0KOhQ9/TX9+XsBzJKcFwlBlOAPTDdhmHDzLyKFv3zSET28RsFo2AGL6i7So3llOl//g531pkY02sV4xuzLsxPWPzr76S0Daj2W5QLUzrKiftjhKBBU7PmePUBUF2CR0H2uDz8TZ/lIAECh4OT3FOyBtE2umXBpuiD/FhGH3Xathm1upu5CuM1cUAOGW0gWBr+N4/KKX7DN8BDwszojoV+Kspd2rVf/iZw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Fri, 19 Sep
 2025 08:48:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 08:48:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Kory Maincent <kory.maincent@bootlin.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: enetc: use generic interfaces to get
 phc_index for ENETC v1
Thread-Topic: [PATCH net-next] net: enetc: use generic interfaces to get
 phc_index for ENETC v1
Thread-Index: AQHcKHMk1MYmn1GT1kyxTm+DYIWS7rSY5COAgAFK2QCAAADGYA==
Date: Fri, 19 Sep 2025 08:48:57 +0000
Message-ID:
 <PAXPR04MB8510ABEC85E704D1289A0E098811A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250918074454.1742328-1-wei.fang@nxp.com>
	<20250918124823.t3xlzn7w2glzkhnx@skbuf>
 <20250919103232.6d668441@kmaincent-XPS-13-7390>
In-Reply-To: <20250919103232.6d668441@kmaincent-XPS-13-7390>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBAPR04MB7285:EE_
x-ms-office365-filtering-correlation-id: 5e8da0a6-8956-44fb-aee9-08ddf7595f13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mFXVPapaKL5JQ5gsT5MfqUXNPHfezlB2lltO6CGrG1SpCHtBYelFpWRSGQ?=
 =?iso-8859-1?Q?pirykcuqVi86GuAUntixbM/DztQvRNoXer92EtXGpEf2CK+kiHT9hqQknO?=
 =?iso-8859-1?Q?YXssCQ3vUqQWCo2ceYldR4HZ7UrN6uQ/EKA65jWxhbTPJA4Rpuq0yY+HFQ?=
 =?iso-8859-1?Q?iuO/C4VMlC4evB3a9nbzrl1mxtVvt0jsqY0sPkbaT60AAiedspBZAksbPL?=
 =?iso-8859-1?Q?6w7Wjtifp/9+WDmx2TjYeNdsXVoT9XwZUXMGTxuzIx+XFOY81qoT0DoZYB?=
 =?iso-8859-1?Q?is2M6kSxo06XosyLidF5+40iU2g9yQ3v1VdNVVEqAofyjOqtFLnFQTYeJj?=
 =?iso-8859-1?Q?0FIasfYMFOrGPJYo21izGfRZLB/t86pstX3rISwEbonkENflYDIMQDjdyB?=
 =?iso-8859-1?Q?RrdGtaiUIC/dICStlHjj35p3ABHCiP30Ky36L4daBhz0cl4o7atIiiirHj?=
 =?iso-8859-1?Q?yJzQ+6aIuGF3BQ+B/yzp5sr2CmISiOhGSDn5WbCa19pt8E3hK7VQBszq/o?=
 =?iso-8859-1?Q?18ny3twjQv9NWW1k3+f+v5+dyQe+cuHhs1040ymLLJu+1nygFGUW73kdF9?=
 =?iso-8859-1?Q?lQ2nWn3psi2adc42DnaD9ouSCGNOSujzCWQ6dB2mTSid4iXLuNTHc/RL/O?=
 =?iso-8859-1?Q?zOYZLYWFBKXfftNTbgbLNIVAUO5iqlsIdNuiwIdgKB8Cxodc1sYH5+h2f7?=
 =?iso-8859-1?Q?JI+bV8Kv4xl3MCrtz5dGnrw+zamHQ1rS6/e7iNdNjfNVdZmF+kkI1lP/AV?=
 =?iso-8859-1?Q?42wtgCGFBCA0fDB8ZYUsuf++BOW73xgvSeumc6Tebpz3jf/pwSpk/JeUKH?=
 =?iso-8859-1?Q?axeg740OvqvMIpeYmM8olCpoI1q44hU9TfClOsMVMEqIO0VEnZO88CxMnC?=
 =?iso-8859-1?Q?PaVBRhVYR8uZFzyhYfrv465sZMyB6Dwzn734zJpVVF/XsVhiecv7JGMxCn?=
 =?iso-8859-1?Q?i1nskk6YQt2cf4pXaa1BOKXAWVW9BOlzT8KZQYcWe0Kw6b9FwADIZVZWI1?=
 =?iso-8859-1?Q?HxlgsxYs94QPGwX5Q4S7tH3aC+BMFjkxJHiTWQi8aBBr7ZiuJvJar7y63r?=
 =?iso-8859-1?Q?ZXdjs1Ulx4i2kyzxOzdkl1323yr6IaLuPoCRWYsaNfXFfjzwtlPlg+/31o?=
 =?iso-8859-1?Q?xpUq9wtD8uAnz/DQAmz4qsfVrZCcWUtgyaHbpiA2BeqoofF+5ngcv2aYzG?=
 =?iso-8859-1?Q?BXTXbmf0I6Fg1aszsNtqGl6CkX3v9mD4QT6okPdaHGm2sExMdpHgf8X9+M?=
 =?iso-8859-1?Q?P9hX1P7Rixzu1EK+wDBYJ3H/vUcvPWkXfggQvj4OWqvqt/4iHoyKGVdbL8?=
 =?iso-8859-1?Q?o4lx1UicgpfBIJ7yaEEBVyCzx2UmMCo+3B3RAm7mI5JwKC+q3ZMFy44UM/?=
 =?iso-8859-1?Q?dS4Anha8N24golsvpOMItbE3L0M1O50VQlILwyz8gTOHnU9jlZnBqfyi1M?=
 =?iso-8859-1?Q?XmA0UG7bumd0rc3hxw4uXN1zIO6KUsZRmXgjxWdfJcOHWCsqZwhIP0fM/S?=
 =?iso-8859-1?Q?M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Z2Qf7WQoIFPqm38Tl7P6VrDov86ppVdsamSqtsiW8XW7pkBxpXxWFS0rzE?=
 =?iso-8859-1?Q?ZMA0wZ64WCKQ3Ppg0K6gbpfEOyg2MkmKdfT+pr0gxhCootN8OVGYyI/dmp?=
 =?iso-8859-1?Q?ZqycXVKsPn98tcen+Gc0MahctkItqSAn4e65lmjOgwcvFiCqpuNwTudHCf?=
 =?iso-8859-1?Q?0GKiuEAzKlvSORyT6dnNwVO6VeX7TWVOJg9nrjJ0ZvWmDKOlUgmio4Y2XQ?=
 =?iso-8859-1?Q?miWYkPB5YF8j2qSFqKa3WUkAkuSBAmVryQe32bPOlP7TlvjfDej6OMOdV3?=
 =?iso-8859-1?Q?RDn0NUH9FEjvkXTagpcTcDKsFgc/kFn3eKs50DkWwIVt+U1ACV4zU0Q7P+?=
 =?iso-8859-1?Q?zOWv4a74s/UHzGGsERKKxmGaeHutQ3vIO6h6sPNfkKlOSOLx2i87Tbegxo?=
 =?iso-8859-1?Q?DAEhz0NUE/NX9yN9fKBTij5VRzpJFfVjS6RuRt3K8RsKICtwvO6Rg5DfL6?=
 =?iso-8859-1?Q?0rBYlYRYYbbDmWdIyI7UPer4sttBbQ/g1iD2H3t44z7VvgcUMmEKgJ1zx9?=
 =?iso-8859-1?Q?QYOyfrejHJazdBtM6FrGmC+GGqkXtNLz1y0ECgb371U9f8x1whP0oJo9Cz?=
 =?iso-8859-1?Q?cetHBMiUWKxL+56hwGY2HnS1OBHIDXVysh7uXZVqcvXoTHuvKilz/utz2N?=
 =?iso-8859-1?Q?bm4NjyBBzJIepRfayXXE34gBs+g32U7Abi3yHwlFPPrpVhPAEvgI08TXkq?=
 =?iso-8859-1?Q?Um5xNoRp61k113Zmqg6dE3nludoQ6tPs0NOGBcQeG1bq7QGCa+0B2VgZ4r?=
 =?iso-8859-1?Q?VsFTQx0/zQEkREn/jDhvEZdGPvrNc2MJ1A7fL7684QIZR2fNe0jMyKozcY?=
 =?iso-8859-1?Q?G6kq3XvSdRNDCynR35Z3ja1/wjGmDPqGCSqLlPLHo2/Cf1SIazgrJTr9gr?=
 =?iso-8859-1?Q?dYpKrJYfXs7e6f/GURYSmjYDLhKQ5DB+Ylo5z/ebe4EcvgMEFYYZIsBzdN?=
 =?iso-8859-1?Q?7CO3E0c3rZd9OukManoSTZFcl0XmJ6s2D697mS10xERunS92qVob15jmXh?=
 =?iso-8859-1?Q?ELICQBGBzhPUA9cFUzV0+ZJSKFBB7Raikahsa+VNWqDULf26VPFtxUa59w?=
 =?iso-8859-1?Q?JVAMBxQFRP0mpTV+D2MMDbFMZpocx3h5WegPC8dgfJiZFT8/hJRE00E70H?=
 =?iso-8859-1?Q?afRcJFIiMLe23Z4Z1YaPsHugsZrzHJKg4/3ardEov6fN3JqhuY+vIu6PBs?=
 =?iso-8859-1?Q?3rTtfgTkSVYNFpPqSV2uLi19ycnZdcQwFscrltVemwXk6dWhFnIeOMlUpz?=
 =?iso-8859-1?Q?dOwNMFvlarUbicMJvBLKRHGwUbDrBeklnBA2fACqoYpaaq/5R7N/qKAWCj?=
 =?iso-8859-1?Q?EG1Yupqhw2dWYT+CSzU8aagI4xSjPgJzDLoWSgyd+T9y+sALykNWMsipqb?=
 =?iso-8859-1?Q?BwEqdS5hoJS66aVdT+dxD6G7mQX7PojUONjQSbylXex6bhETSY8PU6szcN?=
 =?iso-8859-1?Q?lVqPD7djeFadoOGcU6/p2N4QEHSLs9OIh1HisoWRa73//HD/uqvvBFeBcW?=
 =?iso-8859-1?Q?y5rrWvCwMWcENEOYCp33tewq6sFm3GxoL8d/WWBSJDc1sIvSHuuiKXuA+X?=
 =?iso-8859-1?Q?VZxNu8krDlGjwzppcycdNC4enl7It9xSxYrBEpI4IZHJADjNxnTu4YypRq?=
 =?iso-8859-1?Q?fXS7RcLjqPVqk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8da0a6-8956-44fb-aee9-08ddf7595f13
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 08:48:57.5058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: moUCCrQhqwK83WwnWBcR6sVCeXTPgvgnMTyHbzR0BgMKCd0xQHD2I4eEqpas4RShyf+clurjRglAXRepzZ4B6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285

> > It looks like we have a problem and can't call pci_get_slot(), which
> > sleeps on down_read(&pci_bus_sem), from ethtool_ops :: get_ts_info(),
> > which can't sleep, as of commit 4c61d809cf60 ("net: ethtool: Fix
> > suspicious rcu_dereference usage").
> >
> > K=F6ry, do you have any comments or suggestions? Patch is here:
> >
> https://lore.kern/
> el.org%2Fnetdev%2F20250918074454.1742328-1-wei.fang%40nxp.com%2F&d
> ata=3D05%7C02%7Cwei.fang%40nxp.com%7Cca70608eb6c9487d98e108ddf7571
> de6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63893867571474
> 2481%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjA
> uMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7
> C%7C&sdata=3Dh6rMPPxArsYdoPOz95UZRU88Oz9IJ3sD6lRjqC5SHMU%3D&reser
> ved=3D0
>
> This is annoying indeed. I don't know how this enetc drivers works but wh=
y
> ts_info needs this pci_get_slot() call? It seems this call seems to not b=
e
> used in ndo_hwtstamp_get/set while ts_info which does not need any hardwa=
re
> communication report only a list of capabilities.
>

The ENETC (MAC controller) and the PTP timer are separate devices, they
are both PCIe devices, the PTP timer provides the PHC for ENETC to use, so
enetc_get_ts_info() needs to get the phc_index of the PTP timer, so
pci_get_slot() is called to get the pci_dev pointer of the PTP timer. I can=
 use
pci_get_domain_bus_and_slot() to instead to fix this issue.

I do not know whether it is a good idea to place the get_ts_info() callback
within an atomic lock context. I also noticed that idpf driver also has the
same potential issue (idpf_get_ts_info()).


