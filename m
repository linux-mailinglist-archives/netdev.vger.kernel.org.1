Return-Path: <netdev+bounces-188776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA19BAAEC30
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 21:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE96D9831D5
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756B820B7FC;
	Wed,  7 May 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=palmerwirelessmedtechcom.onmicrosoft.com header.i=@palmerwirelessmedtechcom.onmicrosoft.com header.b="xy1B4jqw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2134.outbound.protection.outlook.com [40.107.220.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6257263D
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646166; cv=fail; b=C2BwvCtbLz7cihm9mTmOlK8kWZVbyunvdJqttLScQvDt3MybGi+Iv5t5nbHq55cYJU0RXsbYsPsyMiItaZ1P3Wr1Q6orM//jUEx6D22HPyp+0KM4TjKRg/UZsZ6aGJpp5+i+L9pvh9AF/c1H8pLBg4KyT95dLMtZiwdS2rfEqns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646166; c=relaxed/simple;
	bh=OVulbXSLdftBCKS0WjxDvLPtU831T69+gbhGd5nRvik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EPwt3959szvV5DkEK5YKBmEdMBblnyBXa/kC8yPbHuNocWaQ+odnD0Rfwic37ufmt2uWYwqlbqhwKaR55HCyeOTP3FyJloKcZflHvVXOP0bnf36E8VXX+1B/IIFPT8/3NeFfP4M9ffI5hMpBw2lrR3otQfPhjeWcBpw0f++4JtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palmerwirelessmedtech.com; spf=pass smtp.mailfrom=palmerwirelessmedtech.com; dkim=pass (1024-bit key) header.d=palmerwirelessmedtechcom.onmicrosoft.com header.i=@palmerwirelessmedtechcom.onmicrosoft.com header.b=xy1B4jqw; arc=fail smtp.client-ip=40.107.220.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=palmerwirelessmedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=palmerwirelessmedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1so9is/g46FriRav6l0bHXyYz6bJqybFySTL90k4r/N0L3pHgulJQe7z15jL5RaxJox5TIGkyiW4ZMDEZX9A0HxZjH4i3cbSi0a9zP5pj8/cR9j4nXQOX9/eVUIwVKJdrR7guqrtjvXZvTsf+Vl3g44EFBt2K2cPUVPBlco8BoyTCr11EvEQaKpNl6NA4O3jkuTXrk8NrEQgLA2h2ldNKL8JjF0o8YiRUN2yx1qg73Q6dnkRtfRH9ZuB7Cbr51yoHuR3GKbO+k9wIwmdD1CRIJWAzrMDXD2ySz0ttwX9RGk0kx1cs/h2JMjGA0UIjDOur23tI0S4bihvz+awXSEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpxL+MJ0CG0eOU1HoV0RNroM8ctBzGK+7GPteQuOsuI=;
 b=PhqK5iJSLooVKDM7QIlOQwV9lvaUks2srmD+gKjJ02lnC6Yc5ixFQGiAohPorBrce8xMlJysE0KzHot4/kHTlpJaz4sCWzJcP4gO4blmAQOIiZP82A9Xc7210AtBieZoVz9tiGNJM5PdVml51KOO3xOZz73kqRD2RGE6x85f5FlWex4Tk8VuEWNzQL6nwBHPbDVULCbST3Vw7a762eRF+HRvm0zkwgUlOGML8DpE1OVTW8Cz7VdWnYL0aK+dS4GQ94A44aBdMA7sV9WoJ4VISkDFGEnMObh4zbVE+Yx2LzB7P4HuArWh+IknBbq7jRm+h+VQsreOZi2cMC5HCka1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=palmerwirelessmedtech.com; dmarc=pass action=none
 header.from=palmerwirelessmedtech.com; dkim=pass
 header.d=palmerwirelessmedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=palmerwirelessmedtechcom.onmicrosoft.com;
 s=selector2-palmerwirelessmedtechcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpxL+MJ0CG0eOU1HoV0RNroM8ctBzGK+7GPteQuOsuI=;
 b=xy1B4jqw0NBK/M6Rc/ujL9Lb3EZqalOmNqoxmsomBfEYCDinn8S+uwZoUyEKrj4O4PXTyPXkOUKEAGX4CCRTWRVT/ziVnasojY4J8ExRBykchwQWfXv9RWiydorpL6SIJzB9N5eX9YPx4COqH+8T+9IvTwUTrmMZJGkjoyGA0WQ=
Received: from IA1PR15MB6008.namprd15.prod.outlook.com (2603:10b6:208:456::5)
 by BLAPR15MB3971.namprd15.prod.outlook.com (2603:10b6:208:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 19:29:15 +0000
Received: from IA1PR15MB6008.namprd15.prod.outlook.com
 ([fe80::a280:9c40:1079:167e]) by IA1PR15MB6008.namprd15.prod.outlook.com
 ([fe80::a280:9c40:1079:167e%3]) with mapi id 15.20.8699.034; Wed, 7 May 2025
 19:29:15 +0000
From: Steve Broshar <steve@palmerwirelessmedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Edward J Palmer <ed@palmerwirelessmedtech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: request for help using mv88e6xxx switch driver
Thread-Topic: request for help using mv88e6xxx switch driver
Thread-Index: AQHbv2Bc+TYavxBZNEG3KPwJ+KHfDbPHRtgAgAAyN4CAABGqgIAAAnHA
Date: Wed, 7 May 2025 19:29:15 +0000
Message-ID:
 <IA1PR15MB600846DAB00BD9651A0276F3B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
References: <20250507065116.353114-1-quic_wasimn@quicinc.com>
 <d87d203c-cd81-43c6-8731-00ff564bbf2f@lunn.ch>
 <IA1PR15MB6008DCCD2E42E0B17ACBC974B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
 <0629bce6-f5eb-4c07-bff0-76003b383568@lunn.ch>
 <IA1PR15MB60080519243E5CCD694FCBD4B588A@IA1PR15MB6008.namprd15.prod.outlook.com>
 <86c1f4b8-8902-42ea-a3ae-9b0633f516ed@lunn.ch>
In-Reply-To: <86c1f4b8-8902-42ea-a3ae-9b0633f516ed@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=palmerwirelessmedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR15MB6008:EE_|BLAPR15MB3971:EE_
x-ms-office365-filtering-correlation-id: b4b08c33-2980-4e99-769a-08dd8d9d743a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R6K+La+vLRo3ZWrlNQVHCsMluEn0j732ujHha8AuG/Nl/6CyJp6YQQXu78rZ?=
 =?us-ascii?Q?sf+/KON45BRVaENv8rPiXeFOmTQoqdtc+Fe3idDgXfKLuaQ+yNwTgOK+S0HH?=
 =?us-ascii?Q?mKd8uEBwsASYXOShOa6b9DLxlk/xB0+Nq1icyHTN1ABEtqJDwhgdIkqGObwF?=
 =?us-ascii?Q?O05aPSZMYkWHFrt1U/D/vbsoD0wnivWy/0vJdkaLIxaS4D+1bIFsL0OFfl+Y?=
 =?us-ascii?Q?E7b6BZK3/gJdsQMibxhGrU60F9QTFnKUbhjqhyzxWuaxxK2EHmEVGjiEoLAV?=
 =?us-ascii?Q?qyl4WyIA0SwJynFi5vtE7NcqNh5y/kddlG0EI3SxeLYqUdWkFsAcgRpvTfwn?=
 =?us-ascii?Q?4l8pA/mmg+7rzn+zJNIO+mw564I/GZW6+OD9wYl2F5/I+87YBPN2s4fKeB2Z?=
 =?us-ascii?Q?vPci0KmZcZ9Gh2RnkjPtlaYWQsRj4mz8ZZlCFBHTl7iTrXFFwZHWElMpp68C?=
 =?us-ascii?Q?r5AHrTnouyANQtgYFUl3lvM/WdsFUQBEhIcbGaKr4lhc62Wdt5/jBor43CTj?=
 =?us-ascii?Q?uR7YJrZKn24yeT0zX8rkofUQPnviN4yQdB2AtHCsdrMblAZ9O2Qet2oBHQxf?=
 =?us-ascii?Q?0+o3brDT/tOtAd1SK1GU4WQrpJNw7UODdMOyIrQ1BJ7gO2AC5gBAG+Dgr+7L?=
 =?us-ascii?Q?jHd4XC5RcZboIimEduaeKeRPueWl+xglUYCoeAiQQ1YYFy+jYiU3V91kDjPB?=
 =?us-ascii?Q?1aqIB363V1HcSfHL6sPPiwzriyuK7t61JxI32n1dg6TftMUa+Px4qusesp2n?=
 =?us-ascii?Q?/lYkNbXEWpJXK6IlUzpDIPeNeeZi2+rQt8jySkFGXDdrRNmwFwnGnXdOjDFk?=
 =?us-ascii?Q?DKcRotMffGFwOO/0L/cw5uW4xxIiHNbvRjiww62aapfeih2cz/jWh8FG7U+8?=
 =?us-ascii?Q?8gSDI4ELMifA/QfawUG68vGM+R9ETDyq3LetwvUrIbjljYrvAdvRxHqGm9Yr?=
 =?us-ascii?Q?ObfEoPiBM0chKcA+fCLYTjCQ4lee1IkMX94LxcCs93LdWCBfiCYplEMVsBZe?=
 =?us-ascii?Q?6EEhXWEVgE3spQleURN5RXCuDeGq5d+o5iDYQ4Fngob9QT3UJ9B2Dp4m/9yo?=
 =?us-ascii?Q?cvZnMYUryXsFWG99utTOPnGf2t2AyHJHrE8q3FWhV8K/Rarlfbz5WyP0r5L0?=
 =?us-ascii?Q?C3CYs7NvKBfCkevxKa5tr/DI4STfCz/eXmLd7mafRoPp3p+pO9fSIYP+m3aA?=
 =?us-ascii?Q?yceiCcynp4J5T67iFRpEjkTk4OjvuBZV8yjrBGxaNNK8PJ55AR+01xOnEWg4?=
 =?us-ascii?Q?PG69RF9kTTC3A6JEVFBsfoKoKzB8mBba46sIxZRf3q5T6ATGZ0b/1c95SnUl?=
 =?us-ascii?Q?EVKyu5g8nBb6rsNjCbN1tchpLKttbLr360xTYlP8GKWEMJDXvZNGNkjMLHAF?=
 =?us-ascii?Q?xvfb0BwJ9WjwEbvqEgGGWZzDmjFpPl8GOAJXq6xKrUb3RZTaAk5vxKFrcMnH?=
 =?us-ascii?Q?V15vrLe04H7nzVEEOBjN9etSfTATDbAGMm2yYZsJGGlQxCYzGkHGYA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR15MB6008.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i+/jkJ4Nkc+8fyNL5BoxJsdgrFPgOC8iwjFdcnX/HFukYJVBQet/4C/MSGZR?=
 =?us-ascii?Q?a90LwJsi+eebZ3orUO8/Ql0G/PNBuc7NACVVw60MPx4pnjXpT3T1p3/oKakZ?=
 =?us-ascii?Q?HXLer0P1mhXVYf+wabFYCOMCyLvHTDXrsale6jZkiSKC9LXLQeVcAActAz1Z?=
 =?us-ascii?Q?E/5ofE+QO8Rn2cdr0FbZePBCDzrq+56gk/j9lvZwNX5Oc04p3zSZ+ZLwZXA7?=
 =?us-ascii?Q?y8/dsSZXOAYEUm3hoz3aJUMZQiI+phmkD1Vz5tshLn2Z48vgjTcTBB2eSyxm?=
 =?us-ascii?Q?BuWYCjt9adgFrIqmSeOtIHWyzF2wduprv8deQ0hk2kusaLcqsGLGhs/EFrvN?=
 =?us-ascii?Q?epUIdH6NW63JKHDyRD+3Fgpg5kZUh7bzn8JxrSx4W6krct6mP8bCNp/MtsQb?=
 =?us-ascii?Q?LkumgdPbMdXyyHh4CIBQqngZUkSjoYcqaE6++SK//NTMuZRSJ91m7oOkSOCG?=
 =?us-ascii?Q?dlyu1vAHHn9BOODaPv7M84bzG3kDP9rN4IlS1daB3PFGaxUH7PBRsAvvxEs6?=
 =?us-ascii?Q?e1JbSpzuZxpO4zlz4x1KkGrz8XtCo9rwXZCettOiOEIClNSymx4Yqf1Aez5g?=
 =?us-ascii?Q?IlqtMf0Zw4beB356nACvaR9P0uFWMyoTxAo4QBhpAI03d+2084dULGDdBIN4?=
 =?us-ascii?Q?0xjcL4JGm9H/w0pHeP6RvddIthtcylbvDz2bogA0jKbobMpq9Xmi3Mnv48hH?=
 =?us-ascii?Q?Zq/5snqaS8Wh1Mirjs4GXfJkJxonMLt5eObEm881zDI4xtptevdIwkO4pU7P?=
 =?us-ascii?Q?n6dWCIUPPLyXQZxiHBXtIfk/0DIph67lK0Wg1LENzaHLFOhVXWPaD7glmxYZ?=
 =?us-ascii?Q?b6EyQk6Io0t4ooEmrnjNBDsc43XYmleZOGUn6rJQdoMFdN5eiOuQJSroynPU?=
 =?us-ascii?Q?C3REDkoJOyydCLBKOugNHsuYLjHVexA9IhV+8etNVfNcnC+hRnUiK/mDSbqc?=
 =?us-ascii?Q?0GShau1TWV5tUXIYCkJzfxLpa6j+k5oqazqaVG1fB4OgzWJwokjO0YvkAwIl?=
 =?us-ascii?Q?fwyN07YDRpCG6G3nONSyrYbWyV3dBSD5HVcvc2GeHmHK+puSElax1jV3C7zJ?=
 =?us-ascii?Q?KdhK02YVBJYQrxJNOBFzbMbtvYgnTYkZNS9MU4pekdaQiICFzjplpLoACViP?=
 =?us-ascii?Q?ieC8nEemEM99vnHDLbgx21jDrr0DXseqL0Avy94bZcmLWBSeFypfYou2octm?=
 =?us-ascii?Q?P87rQDEPcKSSzGXvcwEyD/eE6krFBIw8yvu7A9f0W7AQ7EhAeSVgiYxrwHwT?=
 =?us-ascii?Q?m78Epvfw0aKV0cyXJuFXOTrpb8P/fg+M/H5XxHtH/Z5gOOEWEyr7cC2mugt1?=
 =?us-ascii?Q?Nx1mVW9JIiM4tIIdg0jIt/sEZVYU8Aa/pwV2/+313tFYwTE40ZYKoEbpJGE7?=
 =?us-ascii?Q?8032gA8XSbH62BGnruv3ha7IB1YGL3aoSA3cvAXAcGwNPWlYsXNaXvdZVbpI?=
 =?us-ascii?Q?/GIEqVaoKJNirUxChWrSLn5WPqONu9t7/1WPVzNnErtohujhCzKQNeEoc2YP?=
 =?us-ascii?Q?Qk1ZFP0k/YkYQVdoWItgOlHk8EP0uJhGpW2SVuCpP7zJlmYr2P2Hc5/Cdond?=
 =?us-ascii?Q?ZQuBVg/3wkb9KH69UYI4IF+R81Y6YPfl1+AZT1IW34uObcUVfFrcmxIT6W/s?=
 =?us-ascii?Q?nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: palmerwirelessmedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR15MB6008.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b08c33-2980-4e99-769a-08dd8d9d743a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 19:29:15.5390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18187d5c-662c-4549-a9f0-3065d494b8dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhDx6RWt1j1qdlI/I0zc3449FNVq7gFd0MuzhcUDKeYBE5//4FKf4X/rJoMccmhQio5Rjh13wR3VtykQBJDlwXgsvnHkvZlKSdJmoYJKqpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3971

Thanks a million. I have an appt at 3 today so I may not get very far with =
trying your suggestions before then but I will get to it.

This is the most useful info we've gotten about the driver.

-steve

-----Original Message-----
From: Andrew Lunn <andrew@lunn.ch>=20
Sent: Wednesday, May 7, 2025 2:18 PM
To: Steve Broshar <steve@palmerwirelessmedtech.com>
Cc: Edward J Palmer <ed@palmerwirelessmedtech.com>; netdev@vger.kernel.org
Subject: Re: request for help using mv88e6xxx switch driver

On Wed, May 07, 2025 at 06:29:18PM +0000, Steve Broshar wrote:
> +Ed (hardware expert)
>=20
> Ed, Do we have a direct MAC to MAC connection between the FEC and the Swi=
tch?
>=20
> Following is the DT configuration which has a fixed-length node in the ho=
st port node. TBO some of these settings have been verified, but many are m=
ysterious.
>=20
> &fec1 {
> 	// [what is this? Does this tell the driver how to use the pins of pinct=
rl_fec1?]
> 	pinctrl-names =3D "default";
>=20
> 	// ethernet pins
> 	pinctrl-0 =3D <&pinctrl_fec1>;
> =09
> 	// internal delay (id) required (in switch/phy not SOC MAC) [huh?]
> 	phy-mode =3D "rgmii-id";

You don't want both the FEC and the Switch MAC to insert the delays. So one=
 needs to be rgmii-id, and the other rgmii. I would suggest the FEC does rg=
mii-id, but it does not really matter.

> 	// tried for for Compton, but didn't help with ethernet setup
> 	//phy-mode =3D "rgmii";
> =09
> 	// link to "phy" <=3D> cpu attached port of switch [huh?]
> 	// [is this needed? port 5 is linked to fec1. is this link also needed?]
> 	phy-handle =3D <&swp5>;

This is wrong, and the cause of your problems.

Copy/paste from the example i gave:

        fixed-link {
                speed =3D <1000>;
                full-duplex;
        };

The FEC driver expects there to be a PHY there to tell it what speed to run=
 the MAC at, once autoneg has completed. But since you don't have a PHY, th=
e simplest option is to emulate it. This creates an emulated PHY which repo=
rts the link is running at 1G.

>=20
> 	// try this here; probably not needed as is covered with reset-gpios for=
 switch;
> 	// Seems like the wrong approach since get this msg at startup:
> 	// "Remove /soc@0/bus@30800000/ethernet@30be0000:phy-reset-gpios"
> 	//phy-reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;

No PHY, so you have nothing to reset.

> =09
> 	// enable Wake-on-LAN (WoL); aka/via magic packets
> 	fsl,magic-packet;

WoL probably does not work. The frames from the switch have an extra header=
 on the beginning, so i doubt the FEC is able decode them to detect a WoL m=
agic packet. If you need WoL, you need to do it in the switch.

> 	// node enable
> 	status =3D "okay";
> =09
> 	// MDIO (aka SMI) bus
> 	mdio1: mdio {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
>=20
> 		// Marvell switch -- on Compton's base board
> 		// node doc: Documentation/devicetree/bindings/net/dsa/marvell.txt
> 		switch0: switch@0 {
> 			// used to find ID register, 6320 uses same position as 6085 [huh?]
> 			compatible =3D "marvell,mv88e6085";

Correct, but you know that already, the probe function detected the switch.

>=20
> 			#address-cells =3D <1>;
> 			#size-cells =3D <0>;
>=20
> 			// device address (0..31);
> 			// any value addresses the device on the base board since it's configu=
red for single-chip mode;
> 			// and that is achieved by not connecting the ADDR[4:0] lines;
> 			// even though any value should work at the hardware level, the driver=
 seems to want value 0 for single chip mode
> 			reg =3D <0>;
>=20
> 			// reset line: GPIO2_IO10
> 			reset-gpios =3D <&gpio2 10 GPIO_ACTIVE_LOW>;
>=20
> 			// don't specify member since no cluster [huh?]
> 			// from dsa.yaml: "A switch not part of [a] cluster (single device han=
ging off a CPU port) must not specify this property"
> 			// dsa,member =3D <0 0>;

This is all about the D in DSA. You can connect a number of switches togeth=
er into a cluster, and each needs its own unique ID.

>=20
> 			// note: only list the ports that are physically connected; to be used
> 			// note: # for "port@#" and "reg=3D<#>" must match the physical port #
> 			// node doc: Documentation/devicetree/bindings/net/dsa/dsa.yaml
> 			// node doc: Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
> 			ports {
> 				#address-cells =3D <1>;
> 				#size-cells =3D <0>;
>=20
> 				// primary external port (PHY)
> 				port@3 {
> 					reg =3D <3>;
> 					label =3D "lan3";
> 				};
>=20
> 				// secondary external port (PHY)
> 				port@4 {
> 					reg =3D <4>;
> 					label =3D "lan4";
> 				};
>=20
> 				// connection to the SoC
> 				// note: must be in RGMII mode (which requires pins [what pins?] to b=
e high on switch reset)
> 				swp5: port@5 {
> 					reg =3D <5>;
> 				=09
> 					// driver uses label=3D"cpu" to identify the internal/SoC connection=
;
> 					// note: this label isn't visible in userland;
> 					// note: ifconfig reports a connection "eth0" which is the overall n=
etwork connection; not this port per se
> 					label =3D "cpu";
> 				=09
> 					// link back to parent ethernet driver [why?]
> 					ethernet =3D <&fec1>;
> 				=09
> 					// media interface mode;
> 					// internal delay (id) is specified [why?]
> 					// Note: early driver versions didn't set [support?] id
> 					phy-mode =3D "rgmii-id";
> 					// tried for for Compton, but didn't help with ethernet setup
> 					//phy-mode =3D "rgmii";
>=20
> 					// tried this; no "link is up" msg but otherwise the same result
> 					// managed =3D "in-band-status";

Managed is used for SGMII, 1000BaseX and other similar links which have inb=
and signalling. RGMII does not need it.

> 				=09
> 					// ensure a fixed link to the switch [huh?]
> 					fixed-link {
> 						speed =3D <1000>; // 1Gbps
> 						full-duplex;
> 					};
> 				};
> 			};
> 		};
> 	};
> };

The rest looks reasonable.

	Andrew

