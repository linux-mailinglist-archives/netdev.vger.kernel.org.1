Return-Path: <netdev+bounces-148507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009FD9E2572
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8CCFB273D0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEC31EF08A;
	Tue,  3 Dec 2024 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Wy9e5s7o"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-japanwestazon11010071.outbound.protection.outlook.com [52.101.228.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914451E531;
	Tue,  3 Dec 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234714; cv=fail; b=l4yiwWfz8VN8VE2KCJdp33gHCgO3j1mCZxBUFg7S4CxbuctVeTSSFANqjkwUcldRduXWlKW2KUe6y28+nvfRnEosfm1FQnOp5tX+o6SdPaUVjUph7fy0GMmp1eS4VfGj/NsqI6cwKJshEAvzJc4JvbrdFdLp3BdXO903mu0hKjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234714; c=relaxed/simple;
	bh=hV3Z4Bowy9gYIKhXaCrom6gkUPKiUEGx1CTO3+GDqT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QT89361XUAzkWWCgnReSztdXm74u+sQ740cpLr2zORZvW6l3gIOeUMyrhCL31iu4X8dM8Vkc3Y3me/X0bfC7Wt1NMWPuUoO4fZ41Y4fJjrl/EjSnZLneFE/34tQaRiWUrersNeg7+G1QXIyMNNDw+AzxrRDcXL2Q2eWBqKWvw+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Wy9e5s7o; arc=fail smtp.client-ip=52.101.228.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNS/jGyqN8bD9ZfAgL2LyIHu1DXff4CInBtx5slM6xa/I5t99cWctRs5jajIYPsB8T4wWMrZKlwHw2M4TVMGjAILWPSE2dtD0Sg0S15W7auYUW5zkXOGxnq5bgzKKNiwU5e/UEAwxFSmJRUoFOEqIKr51Up87nvXQt5X1TqywtamlYn25V90g8Ocl9d3NejIf2Eiqvqz+0nEpihWz6t/gjK0Ynp0B5IF2hfEVFJlRbCKg3hqGyySlAL9QD6e4IaTVogQNnZ5nqzkv9C5Nrw8817HE4JeKyxzYlb5n3n0a3fzLe8TvKD67I2QVz80wAIoUxa4AAhCunGLKWyQre2HGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2IDGpbrzqKND77b6sFP0omAiGBMv34uMimVs5+S1XE=;
 b=OWb+1cJFbGH6ZMonyFEcoKmDohC6sKBHbQPw4XcqtZ6tI+VNYLYW3Gs4Ov+XnW2RobmtzedlEJ7m0T/ndg36nURPO5yPo1HnxRyV6/b3UbT4A4d6e3OgRiKuDwawX6SlqELKzu5gdouezcLthsahg8PGfKD5rNsUlqEsGvTPlZ4rx+WRwIBJZvkQ4b8fbielE4iST2QrH0mbQ+8kMn6N6YHGYO6/dM6m7H58aI1DBKBov3IrIS+mvZc2yEeYkC6SbyVjGWKvhUDl8ythqDUZFJrarn+tKlk3KT2m03hRCUcWGI0ygJ7nT9a8JY73QmvZTWoJagan58ZK4n7F+Wff8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2IDGpbrzqKND77b6sFP0omAiGBMv34uMimVs5+S1XE=;
 b=Wy9e5s7od7SWRbzFEBsfBRncNi8tqEugfjH59PCIvFwE7ZpDZjkyTHJS9VOHMh5z7CCY6JdMTQe6eIAXXdqQNBO5JcyXpJF6dqsxR/J2H7kkEV989tTDhnT74qWKINXa8Cags4NNnEjc9wtJVdBjgCM/KEPkjhAM8iR0zVnCkC0=
Received: from TYCPR01MB10478.jpnprd01.prod.outlook.com (2603:1096:400:306::8)
 by OSZPR01MB7036.jpnprd01.prod.outlook.com (2603:1096:604:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:05:07 +0000
Received: from TYCPR01MB10478.jpnprd01.prod.outlook.com
 ([fe80::2b3:d75:3bd7:6e5f]) by TYCPR01MB10478.jpnprd01.prod.outlook.com
 ([fe80::2b3:d75:3bd7:6e5f%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:05:07 +0000
From: Dennis Ostermann <dennis.ostermann@renesas.com>
To: Russell King <linux@armlinux.org.uk>, nikita.yoush
	<nikita.yoush@cogentembedded.com>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>
Subject: RE: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
Thread-Topic: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
Thread-Index:
 AQHbRJT08duIfcsT8UW0RkYAJNJ20bLSqPcAgAAErICAAA3ngIAAAfsAgAABxoCAAAzrgIAAFnMAgAA4WQCAAAMzgIABcAlw
Date: Tue, 3 Dec 2024 14:05:07 +0000
Message-ID:
 <TYCPR01MB1047854DA050E52CADB04393A8E362@TYCPR01MB10478.jpnprd01.prod.outlook.com>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
 <20241202100334.454599a7@fedora.home>
 <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
 <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
 <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
 <Z02KoULvRqMQbxR3@shell.armlinux.org.uk>
 <c1296735-81be-4f7d-a601-bc1a3718a6a2@cogentembedded.com>
 <Z02oTJgl1Ldw8J6X@shell.armlinux.org.uk>
 <5cef26d0-b24f-48c6-a5e0-f7c9bd0cefec@cogentembedded.com>
 <Z03aPw_QgVYn8WyR@shell.armlinux.org.uk>
In-Reply-To: <Z03aPw_QgVYn8WyR@shell.armlinux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10478:EE_|OSZPR01MB7036:EE_
x-ms-office365-filtering-correlation-id: bed01a72-55e0-403e-a0be-08dd13a37e02
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?pIcULrRPKoEXVPSMJndIuTP4+/hkOgbkOF6TTAO+M8+s5aMGcTgeHHz3?=
 =?Windows-1252?Q?OIdqtCsdIAYBJlX6OlruB9NEvr1PGrS2HHyPGyf/ykvNNVVueTHSdg9D?=
 =?Windows-1252?Q?EalnwaWQH6GrqFyecN4JoGO0WnWFwTFNWnVdK++esM2q/HmtFtsI65g1?=
 =?Windows-1252?Q?SQet9wfrYj9JNVeuYiHeIBzkyzTZjg4GiDoedME3jN321pSkuouuUpdi?=
 =?Windows-1252?Q?zgEmEyXE7hH7KqRCGQn9o0nHeEehV4gaYpLXdk9IsdIUzKw7T7QxRcp1?=
 =?Windows-1252?Q?UqeptGu5Ee2qK0ym/qbBnrd17ekzuCSFsWajjPuTiozvifUJ/oJN+oA9?=
 =?Windows-1252?Q?8cagOYOeRErRiNUJgFexhnFfAf8aRjXFrBQvVu3a/w2CdCUaPDlTW5oZ?=
 =?Windows-1252?Q?FAFAT3E7H7kxi58qCxsD4XAEHcVqYTLdlARREEkyTyuRP10D94wBv2We?=
 =?Windows-1252?Q?7+gbRwAulusxUPk2GvGqki670x1AhGoikncy04N/a2ZErNUQ/L9fJ0g8?=
 =?Windows-1252?Q?LU06q5uwUk8OU9FN2yzkEMvPi+yzHkA3wqAqv9kmFKFpj03CVRRrp8MY?=
 =?Windows-1252?Q?prdjigVwbd31DBQ/tK+wGXiI+RE2EL+7NVfbzvF1RRoBdvOW/3Mgo3e0?=
 =?Windows-1252?Q?ZS6ldEdSXKfEXK8GgMHg996NhdB8LyCtQeJ+f9QjvyeRIZ01koQbLN07?=
 =?Windows-1252?Q?wZwyKKZ9vd3SX0u7cHCJQMx1PvT51e4KRllvF7Qyqa0fYcJlHgNgoR+F?=
 =?Windows-1252?Q?Q7EKLUwrAxLNbQZNIUUsd7NdITkJlX4+PxlH8JtGAE7nIfNd/MV4G1lS?=
 =?Windows-1252?Q?qb2bZsH4j70P9W71kTzQbwTjouDAXgG1evpQoqAICLvFVDjjKWgYNM4b?=
 =?Windows-1252?Q?CJGZ97uPYlRAxOsX1mTthz9W4l2DwiCS+XdkpaKzbFbKAtLDhYjG+KGL?=
 =?Windows-1252?Q?hwJrJ590PIu8qE05cV6CZeNw8DWF7soM148SGB/B3BJyqDCJJ83FS/P4?=
 =?Windows-1252?Q?m0Eorp8nITdnrn7VXmia+VipAMEQ29Xg8d9NdBkzPLrJlN0+SAyjzuQH?=
 =?Windows-1252?Q?lGbzJeH12Zsz5vgk9ikiV5+kFP2ohbewhqG7TckBiW3AMqBhtYg4i+cd?=
 =?Windows-1252?Q?a0jC1zvslF23HVBdCeznf/Hhfn9KxRBdE2XF+BqtQ64CbnvXymSQbdas?=
 =?Windows-1252?Q?gQAF8eEZXxkPpRKdH1UhQTIRN5v+/J2FbIpxkp+0UC8wiD0rgJkDaxde?=
 =?Windows-1252?Q?MfIviM4cGcLwRAS7FLzmGj2uDokY+hDvFZkDETwmdq2cS3HlVGXGJgRc?=
 =?Windows-1252?Q?D8groPNT3+v1M4J906bNan18YxwKKK75zuRn7H1rLWcCiIekYPVMZwu1?=
 =?Windows-1252?Q?hfMRuT35gb2Fk6cqPXr9oKyrQJ06bYwuC1Vl8fEFYsOyLvNHLWUHrkRB?=
 =?Windows-1252?Q?euxZNeZLpMrmsGIuy1ZZX1CwIyxfMa3YnE5VDAs63RY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10478.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?PYux4FM1wqlb27nakmiOos6Qk43bdz1aXjskXQ2sI1MOZjLajkSNcR3l?=
 =?Windows-1252?Q?ootvG0zjpJkpDF1gm0/gH9FZajhV3k4GYMlcLEUr7/y4AJg8861yVwI/?=
 =?Windows-1252?Q?NAAUfYuq2mGBr/pfl57TJAHmwnveicLpxLAniKSew16iHXv52cjI57Ok?=
 =?Windows-1252?Q?wnOqEKbmkgGXLoxDghgXJBfQVvQ9qBcchhGTwG4gc1UMRgbmkTtSl0Mm?=
 =?Windows-1252?Q?ssDn6Cl8wONXNgdHhuUGHJkv4cZ/mKtMMutxLwxcLnBXkwr+oqlZtpj5?=
 =?Windows-1252?Q?c+RDWao0bfEbF+42zdY0RsfRN13NNMUXzDI5z4YzX/LUYhojfvI/9BXy?=
 =?Windows-1252?Q?sLESF+DXwrRJY/ULk6bXqAJqIllzmjnMwFcZsds8HDh8Ahm2lsRjGjfu?=
 =?Windows-1252?Q?jXWmFH4ZcZtfJx9vy+7iyK+QjlT7yQfhROH7Zq9tEey2LIyF4YNdQ+bc?=
 =?Windows-1252?Q?Pe1tJt7BxcZuPof4JmE2kqntGg31iEZM9/H3Zvaf0pNEEf3iMITuCqFn?=
 =?Windows-1252?Q?8GvEmibhEpZvbG+zddcyPzQPciFLNtQIEMaXYm+NND38XN9kMJVzUL9i?=
 =?Windows-1252?Q?z5X95MzUO6dWB11NUFgLVJCttzT6khN/cITgnEUQXoLIRmeTqrsd91Z2?=
 =?Windows-1252?Q?YsdwSajp0TNUeVHhdXqXSpu0Vbl3z87RO6FQc1YkTclY/dIUTJLORRvW?=
 =?Windows-1252?Q?Uq76oj6QgGCHzigX3Ev98OiybF9Xegg+WllDyQnxbqVUKuxq3FFrLKWy?=
 =?Windows-1252?Q?dSlmW+QSmdIDdDrjNdrvroat+3SVNmwM6Urhw/UVT1vMSb4nx2kJ9IXf?=
 =?Windows-1252?Q?oPSQ8cpxssbxowymPLfDra60rpXXBQXhEjOnf63J8hbDev/USThM6P8T?=
 =?Windows-1252?Q?hbPrqU7wjA+RpbY6JNs8TugKhjaE7iL9PdEO3xSPbWyBOV2dq9XnRANs?=
 =?Windows-1252?Q?dbTP3UApGQEK4AcfRUi6I9vEDufQZucTEX/dPUeAMFMtCpGtNp4XUxvM?=
 =?Windows-1252?Q?rDtgcLPO2aVSAodkpGXL8hMEzixLXpMJA8XFjBesAgG9fIElBKVTM9+L?=
 =?Windows-1252?Q?ku/KxKamLZjDPwASkwmjA5972bmki0xMqn2JohNzQZzCZ1Gg/8DaGxI2?=
 =?Windows-1252?Q?EyNaTe9qMbBRHVsDX7h8xOVutQ3/gllgkpWtyjOoHc4iQWeBqRRDzESB?=
 =?Windows-1252?Q?ys+WtlkauhnK4VvKFrAasBxDK84/2h5eOe9OiL8ddzoaYqq4qseXxL12?=
 =?Windows-1252?Q?eQOcXu2ATWCzKYDaT1MZwHdRCImdIwQtsbDYrMA9rPHEtqJGcnvaGHKq?=
 =?Windows-1252?Q?9ygOEAFkLAcF66l88tva0UxgkfP1ZVH4K26NAjsaL8UOXLu+IqF6DvU8?=
 =?Windows-1252?Q?JKUlVyPIP/gVxCWCj0eJ0uu97DFTUFkXn6guV/3EgcEjsTMsOjP/sX43?=
 =?Windows-1252?Q?uULNnZaMuoq/UPN838mUfK/JW1d8wr8s9zW1tCgi2/itx2vgOk+uhgPs?=
 =?Windows-1252?Q?R8kW8FPDQsN6MzkA4Dk89VGfbjbvik+qqVeqZUOxzIDWzQAQrLtAUUll?=
 =?Windows-1252?Q?bdH3BKA2Zf3Wlt4H6yQ+QAvYEkIP2YV+vMDLncsuMy0Ar2FpiOdhUxZ+?=
 =?Windows-1252?Q?Sd+bRQVmvngdVZV2Eck/xeZ9B5LVboR/irxVHYZ3YnQvVWn7PJLzfebe?=
 =?Windows-1252?Q?K/T8dYpk1jR3alOTGVtTClq8Rffc3kt1IfNeLuyut7G5P4ghcSekVQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10478.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed01a72-55e0-403e-a0be-08dd13a37e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 14:05:07.1092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPu5kOKHk8CXjOyrGCZ813DHC5bh4ZMJKZB9N5eWUXpn1O4HIY86ZJsW11Xt/2cDbuEdyond01Arxx/xJa2onhuMHcxAvlVJAXHuDQWkKdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7036

Hi,

according to IEE 802.3-2022, ch. 125.2.4.3, Auto-Negotiation is optional fo=
r 2.5GBASE-T1

> 125.2.4.3 Auto-Negotiation, type single differential-pair media
> Auto-Negotiation (Clause 98) may be used by 2.5GBASE-T1 and 5GBASE-T1 dev=
ices to detect the
> abilities (modes of operation) supported by the device at the other end o=
f a link segment, determine common
> abilities, and configure for joint operation. Auto-Negotiation is perform=
ed upon link startup through the use
> of half-duplex differential Manchester encoding.
> The use of Clause 98 Auto-Negotiation is optional for 2.5GBASE-T1 and 5GB=
ASE-T1 PHYs

So, purposed change could make sense for T1 PHYs.

BR
Dennis Ostermann

> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Monday, December 2, 2024 5:03 PM
> To: nikita.yoush <nikita.yoush@cogentembedded.com>
> Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>; Andrew Lunn
> <andrew@lunn.ch>; Heiner Kallweit <hkallweit1@gmail.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Michael Dege
> <michael.dege@renesas.com>; Christian Mardmoeller
> <christian.mardmoeller@renesas.com>; Dennis Ostermann
> <dennis.ostermann@renesas.com>
> Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any
> supported speed
>
> On Mon, Dec 02, 2024 at 08:51:44PM +0500, Nikita Yushchenko wrote:
> > > > root@vc4-033:~# ethtool tsn0
> > > > Settings for tsn0:
> > > >          Supported ports: [ MII ]
> > > >          Supported link modes:   2500baseT/Full
> > > >          Supported pause frame use: Symmetric Receive-only
> > > >          Supports auto-negotiation: No
> > >
> > > Okay, the PHY can apparently only operate in fixed mode, although I
> > > would suggest checking that is actually the case. I suspect that may
> > > be a driver bug, especially as...
> >
> > My contacts from Renesas say that this PHY chip is an engineering
> sample.
> >
> > I'm not sure about the origin of "driver" for this. I did not look
> inside
> > before, but now I did, and it is almost completely a stub. Even no init
> > sequence. The only hw operations that this stub does are
> > (1) reading bit 0 of register 1.0901 and returning it as link status
> (phydev->link),
> > (2) reading bit 0 of register 1.0000 and returning it as master/slave
> > setting (phydev->master_slave_get / phydev->master_slave_state)
> > (3) applying phydev->master_slave_set via writing to bit 0 of register
> > 1.0000 and then writing 0x200 to register 7.0200
> >
> > Per standard, writing 0x200 to 7.0200 is autoneg restart, however bit 0
> of
> > 1.0000 has nothing to do with master/slave. So what device actually doe=
s
> is
> > unclear. Just a black box that provides 2.5G Base-T1 signalling, and
> > software-wise can only report link and accept master-slave
> configuration.
> >
> > Not sure if supporting this sort of black box worths kernel changes.
> >
> >
> > > it changes phydev->duplex, which is _not_ supposed to happen if
> > > negotiation has been disabled.
> >
> > There are no writes to phydev->duplex inside the "driver".
> > Something in the phy core is changing it.
>
> Maybe it's calling phylib functions? Shrug, I'm losing interest in this
> problem without seeing the driver code. There's just too much unknown
> here.
>
> It's not so much about what the driver does with the hardware. We have
> some T1 library functions. We don't know which are being used (if any).
>
> Phylib won't randomly change phydev->duplex unless a library function
> that e.g. reads status from the PHY does it.
>
> As I say, need to see the code. Otherwise... sorry, I'm no longer
> interested in your problem.
>
> --
> RMK's Patch system:
> https://www.arml/
> inux.org.uk%2Fdeveloper%2Fpatches%2F&data=3D05%7C02%7Cdennis.ostermann%40=
ren
> esas.com%7Cbfa991c0ba974db7c9ea08dd12eadd3d%7C53d82571da1947e49cb4625a166=
a
> 4a2a%7C0%7C0%7C638687522161126854%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGk=
i
> OnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D=
%
> 3D%7C0%7C%7C%7C&sdata=3DEBEG33bbhh3A7DQMfoVJNOXeGyJsQ%2FaVk8xjS8DK17s%3D&=
res
> erved=3D0
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
________________________________

Renesas Electronics Europe GmbH
Registered Office: Arcadiastrasse 10
DE-40472 Duesseldorf
Commercial Registry: Duesseldorf, HRB 3708
Managing Director: Carsten Jauch
VAT-No.: DE 14978647
Tax-ID-No: 105/5839/1793

Legal Disclaimer: This e-mail communication (and any attachment/s) is confi=
dential and contains proprietary information, some or all of which may be l=
egally privileged. It is intended solely for the use of the individual or e=
ntity to which it is addressed. Access to this email by anyone else is unau=
thorized. If you are not the intended recipient, any disclosure, copying, d=
istribution or any action taken or omitted to be taken in reliance on it, i=
s prohibited and may be unlawful.

