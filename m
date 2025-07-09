Return-Path: <netdev+bounces-205572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED289AFF51A
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A147A5392
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FFC1E9B3D;
	Wed,  9 Jul 2025 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ifql+e8v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3EC16DEB1;
	Wed,  9 Jul 2025 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102159; cv=fail; b=XYLvCFYskGKlja1u295HKQRvt5M9jKqJjs8rA3xQcVnIrCISUQkkA5mIDQIT0FFmCZC2NC/4NOeD3B1VpvxSbbq4S+oDfmUoVO6w6xi1NiRxRWyXPW8uEbswpIas9WkfeDzmRS+QhBDs+HjwPRjnDP1tt2WlJclx4MOolsBq78g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102159; c=relaxed/simple;
	bh=I6iFhh3PgPo4vtodElybyr/1GbrHO4+5solziWcONrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KbWb9pkudR6p3DKY4d24LCEvtSm2Uu5Vq4dc08o6Y34yDocPbNFAm9MrHuNV73FiXpsYWMx/wk8v+1TWlsTNfuBXuWO50nhEos/b2k9knnKlg6l3ToUBiCbUSEgI1FTR+4+GcKIPd4dWXgPfM46GHDA4zJDBlxq3cV25OEbYPLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ifql+e8v; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oh40CnfovN3f95tutPplgfau5Hncns7tR2GCqMdWgHiXw1UzgtgaC1Qntb15ty8t3hYSnTRRSi2qB65Pr9LAENE+RaqJvVuZA85efw9bavsWwYmri53+Qsl68Qdn19asKxMCKeg72Q2iEt2njG7z/jkNCFEanJf/h7Sc4hluEsCIOsn9izUnEyBSdArFKOgPT0JUDI4XS2OGXql0OMP9c82kqMjeP/sFLkxBPCKbUZLyVeWycdFHGulKY5V1bN5UNv+9Q3AUNdM5kYDn8EuUnJsF6wWGUEBW7d2A1kCPQEXqmWKngECib5Heg5cS/XcRneWlcDfIHD0083i0trzT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdQE/6TEGHHVjlXz/ztUv7sfux8yajDe0hQHKdBg1l4=;
 b=shqkURvUUDCrN7kFdhlXqrguOA6R/QI3MFeVKRRj8I/2p6Cd5ngw/gKT0qHLd9Y85UBYUMjYbWm3e7zGsiG7vTA0dG3mKWyVK4M+cOT+WaW9PxRK4bGzldFLF30o6Eb4RpnQGnvpmZlMFR71OZ4vEZaI6XRguzyjNtAfPsbdKVd/PfACKXxmXf3vBwdOqoz9uSzklV6D8pz6cKak8Zyp4sjlAzuphpBKmQUZQWiFsQ888PvLX9BUntmWTYyWrtjXB4DkKKGTsspag6MEjDAoQZAny6b3LhQDlUp1z2me/IFycFdP28Bk0oNvt5CUqkfgoLF771BfK72YCcOVFGI5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdQE/6TEGHHVjlXz/ztUv7sfux8yajDe0hQHKdBg1l4=;
 b=Ifql+e8vNyjMTt/7ZdM8nGPH91V+jywA+9eghLu5Jkj5pEJVVLtCp7G7HOfScpGPJR6ibYF+XaJ2jnyvzRJhcLHKQMoZDKeCFfCutBg6RY83O1gV99bmHCCOBwK3X1VW0UEthvzEcrj5jvjkGeHZfeNEJvTB9OJq9HeLnImNacQkSE3YvkTYyQeUkc8a3+lUya60BSbHQdLP9V2QTrxrxHxe1/qgG68giDGJmeZVBZu6ljAQMvIUO8DZb56+Rj7mx834U7Dd+m/uXnjNdvDZATPj2VdUxCn7JwVGqDwONaMDoE2XSnD4JCZKHwusrKtTlAGs8ZzAkHljCSTpOacHOw==
Received: from LV3PR11MB8742.namprd11.prod.outlook.com (2603:10b6:408:212::14)
 by CY8PR11MB7827.namprd11.prod.outlook.com (2603:10b6:930:77::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 9 Jul
 2025 23:02:34 +0000
Received: from LV3PR11MB8742.namprd11.prod.outlook.com
 ([fe80::d5c5:fbb6:36fe:3fbb]) by LV3PR11MB8742.namprd11.prod.outlook.com
 ([fe80::d5c5:fbb6:36fe:3fbb%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 23:02:34 +0000
From: <Tristram.Ha@microchip.com>
To: <maxime.chevallier@bootlin.com>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 6/6 v2] net: dsa: microchip: Setup fiber ports
 for KSZ8463
Thread-Topic: [PATCH net-next 6/6 v2] net: dsa: microchip: Setup fiber ports
 for KSZ8463
Thread-Index: AQHb77bM67Dkv0j6akiDuvLgerj6T7QoBQaAgACcTtCAALAVgIABGc4g
Date: Wed, 9 Jul 2025 23:02:34 +0000
Message-ID:
 <LV3PR11MB874233C067E17B585571948AEC49A@LV3PR11MB8742.namprd11.prod.outlook.com>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
	<20250708031648.6703-7-Tristram.Ha@microchip.com>
	<20250708122237.08f4dd7c@device-24.home>
	<DM3PR11MB8736DE8A01523BD67AF73766EC4EA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250709081217.368e1f7d@fedora>
In-Reply-To: <20250709081217.368e1f7d@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8742:EE_|CY8PR11MB7827:EE_
x-ms-office365-filtering-correlation-id: 23e22107-bb0f-4e1d-a6a1-08ddbf3cb0bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mGaWZkrefzUDpuPFnBexkGptNBq7XQH5mSl0mjMK9EuKqAvzBvoZaJrKSCo+?=
 =?us-ascii?Q?KU2+P41ZO77BWRrYKBkho3yDBK1JsTlVV032TKqcMRe60jjDc+BcylGtuI9K?=
 =?us-ascii?Q?8ZmodAddctVT+IQaDC8KhZG/4Cm/Xa5iyI+OTPSh4ntodpoUwmyey3tqc8On?=
 =?us-ascii?Q?xGZmgAbPIbmd4GuqC7QHgK7aV5ngMLpedWZwcbT/xTO2/iRicrim5f/RNeZv?=
 =?us-ascii?Q?F+CMiADxX1+lXvWupG+QM+I5tZFaBYPvkAontHaMJz2rzql7kRKPm7HIlGmw?=
 =?us-ascii?Q?g5ptzYQR0bgQUnXUXyTAYG+byxaM5JAn/6GElNmZqS+Qp9sFHXcZXGD9DFjC?=
 =?us-ascii?Q?xGPcethIg3y7m39mmwom/SB8xJH/Y28n2FsZD2XYAf9cy8dCB1O592gBjuxG?=
 =?us-ascii?Q?jNqVGUdX5JAdCu/K2H0K2T9WUuu/9GfK3I4dsGz+9r/wTgRULfosRGnks373?=
 =?us-ascii?Q?4DPVPP3nTa8CXE6ZtUlmDE/yG5Y7Dymkl1VVt6OfPsFqiBXad3hzhn1M1YmK?=
 =?us-ascii?Q?q0Kib2+b3W0oLbMHWgOw30fiioi20xIC+TfZIhALqWBp3YYbjKYdRt3HqbVs?=
 =?us-ascii?Q?m8ajTTm9HZRZ5MnzLb+dG3SM7uBQeTvfnF4tHgfaQD5i2iKZydtEGYQnCSEX?=
 =?us-ascii?Q?YR++C6GSUBXyZrRopCS1N+6l5Oko3ONKx9bo9wySs6atLpjUy+FYCFpK5pd8?=
 =?us-ascii?Q?KkyV0P4ZmcS313J+Ekj6SFw4qox8VXydgegyNKcpB1OrvIrcO5GJvkolwwhs?=
 =?us-ascii?Q?1un+4yzi9pwc8Zq1MwdrkqSQ/jmi0/57rSrBgePa6FlfaBjwzQEy/GH01L/o?=
 =?us-ascii?Q?YbDTPjiErhf4UhIycKu6LHhpg3EylHqFzW3cBafDm889x/DM9c7I2KePBGMD?=
 =?us-ascii?Q?WXlI6XA0du/N+h2F4XHTKcsgJNZb3wYODb1VZiTGjP7+d2a/a1/V9il70lud?=
 =?us-ascii?Q?LG+PU5J31RMZmoOnKroZ7fFo4pL3vu//3Hq9lhb4lLf8LzP5wqkbF87/jhs6?=
 =?us-ascii?Q?WI+X35YqWyqIUsWhtyThq+Z/eWXBoGYcptjJBXN9HMDUSkggWTmOH2PeesNg?=
 =?us-ascii?Q?8wQMTNJfri0zMHc0CkF1jfiTLoD1nSXpCPb7vODm2FCAIyAkWyZC9fxt8mkd?=
 =?us-ascii?Q?oFkHBYX9m4USHIzG5dWn8/aO5po/6q0bW1ynjAROOjxARdn5/RzFdM1ca/DL?=
 =?us-ascii?Q?FPNPoTNg8Vx1Cv+UIp1oycUeFnd1O3B+AOPKXJAgmHnplwG359mfCmIJhTgo?=
 =?us-ascii?Q?J4BAW7pGeWUY9yrZKAAy362u7xLU9AjT0cnthSawP0PSoUUwV5MTiV1uUdhI?=
 =?us-ascii?Q?ZT6RoQApALVRpB2Kfifuro2llR9YjDlZ7IXle8ys3+h5slE4M9uBNXt/xK34?=
 =?us-ascii?Q?Gc4x1VlLnQ3+qZllKM1+UL1YDZK5wpZCcNSZ/7u2msydg7z4xC65AFRV7bm9?=
 =?us-ascii?Q?LsFJQ8k82bHnbbZeFv5ZOtj8I/qJZyoiLN2ECPvNomcF0IA5KfAE4g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8742.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RoTB/g05+SxYa7DSu114rJj1oK17KJoszHlFM9dFMvHrxS46bjOtakvqiUBs?=
 =?us-ascii?Q?BhuZ7bJuBIxpvjtgBlwFWPCgLA+46Qp0KaIS4kcLlH94Aufsf7HE7MQzBStK?=
 =?us-ascii?Q?blr58T4MjVfZXb45P6e0zguHj52+WaM53ejDOCnUlULWCklgALqejIVH9cRX?=
 =?us-ascii?Q?d5qjLlj6F/ISmncqw1ommRNuxSonTP6k7eajcU+VSnygMVEb0jYpKD27Dw/w?=
 =?us-ascii?Q?jlg/7OeVYvsOBc5nAmRZgiSusKjiohGEFQEj8JSPkLTiFeno+pD5D0PI8r5F?=
 =?us-ascii?Q?2htPl2cBRdFjazVxlLUn98I2OJGWZKTVuovasXvMRo5AHytLTgVmnzi26SWj?=
 =?us-ascii?Q?jqmrgVZs0qCzIp4FON/wJFdFSPYMRIiFmH3GU2bo2XcQu+7DloUuypc617c9?=
 =?us-ascii?Q?Ner0NOEgzFLEVs9N/KGgq78u3m1m6uA/FDhMFWnkdnTfzTz1f8ht2GfkjKKN?=
 =?us-ascii?Q?1mljl3QcWEfocLC66HAUULkSuSjFVQygc9YO/jsXyvr494GQZXqiy6rAG5mT?=
 =?us-ascii?Q?21LQUhvkVLMY9GU5Fq0Q5n0c1V0+eNDx5xDTApnkGN2hSX87uvE+V4boXdmO?=
 =?us-ascii?Q?NGpURTC1D1jX0PIRThuT6M39aaczb24VMTgu13eFbmZCzkrSby5MNSHtxP8O?=
 =?us-ascii?Q?cy1joHrARvFW46dQn9KFa6oJ5H9XF1KI5R366WcjH/mHloL/n8yb/GJSqzPW?=
 =?us-ascii?Q?LM0+w2HQI64iJ4w7Q08uudrYB5XGCHMTg6TECDszPkJtukjAB2ixlqFvHzVQ?=
 =?us-ascii?Q?Jaq+S7OPxjC/04mI0cjUCg+iaGBAYCDBv5hrHXcTkTsSOEl8Pn72GZK0KEW9?=
 =?us-ascii?Q?cb/Rt/b7pd1VOWP5Prah5eHOhmLQJSpzeHCykD8O9Y+guJlOse4IQ9hOYq/I?=
 =?us-ascii?Q?k++rkTUJlrqXU5S06SEaoWnZ98doAl2ao3OhM4Zos12RcgtGhK9TBaH9vGSQ?=
 =?us-ascii?Q?Peb3jqowGd910tV+Xb3WNJAovh+SCFZkJI4k2combjKH84MpoL9W2Ei3lHSk?=
 =?us-ascii?Q?TZ/n+Caai6y+z0mJacQAMWKxDfyu1iZCe+ra0+a8Hd6lVElmAayJRCHDmjYH?=
 =?us-ascii?Q?kKqFf1ZoNQBuW20kjhthW2+0i/nXwCTA/fKonIPdA4KnUCAHJShp8TAx4TiK?=
 =?us-ascii?Q?Mh5Tm8BNB5RURvCvhyBDk9+q2xDGN+oEOJmVFvXwmAu00B3G/miQTZ8cwFqB?=
 =?us-ascii?Q?HpwNQkG3hPIXmtjrUxZ4ThzeStWO81JuYnhLrG8XcGtWln8cdbd1RFUILCf7?=
 =?us-ascii?Q?QfA91+iCj8yVMu9+EPuJTzOM9NiFpT01p6NtmyE6fCX8dVDSQxzyA1z+v02N?=
 =?us-ascii?Q?hBG2so123CxI6SseZ168beT5RHWo8jRi+s9Xn4E8iMWmScpdM1WSfM3UhFMS?=
 =?us-ascii?Q?MS+b3ucmQF3pPdUw19n47165kYpnhE2Jrucjqj5+1Q2f80v4XIxG+EaNfRPh?=
 =?us-ascii?Q?JA63TZzj9WTUTN6myHBwEORVvJynrU7aHj9PhKqPx9yJ9GQhjEOZcoutsm3h?=
 =?us-ascii?Q?RIBn3E9N0Bd2XfaCIKTFrBsHR00nCcoEYi1VvJtxtGG0PU/nSd8PsYWux8Jx?=
 =?us-ascii?Q?nDmTP5gz2HKh4qf641SeewQb10SdPZcLenkQlU//?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8742.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e22107-bb0f-4e1d-a6a1-08ddbf3cb0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 23:02:34.0573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8gOo/8GgCRl5RneTUI8P3bABKGrcvekefB3ZewAPtxGxc3e6+zCbnEbaQE+mXAqql+NcbSmPmFnRrtPFX5jlta3EqdhiJ2U6THLcpk4ofA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7827

> Hi Tristram
>=20
> On Tue, 8 Jul 2025 19:45:44 +0000
> <Tristram.Ha@microchip.com> wrote:
>=20
> > > Hi Tristram,
> > >
> > > On Mon, 7 Jul 2025 20:16:48 -0700
> > > <Tristram.Ha@microchip.com> wrote:
> > >
> > > > From: Tristram Ha <tristram.ha@microchip.com>
> > > >
> > > > The fiber ports in KSZ8463 cannot be detected internally, so it req=
uires
> > > > specifying that condition in the device tree.  Like the one used in
> > > > Micrel PHY the port link can only be read and there is no write to =
the
> > > > PHY.  The driver programs registers to operate fiber ports correctl=
y.
> > > >
> > > > The PTP function of the switch is also turned off as it may interfe=
re the
> > > > normal operation of the MAC.
> > > >
> > > > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > > > ---
> > > >  drivers/net/dsa/microchip/ksz8.c       | 26 ++++++++++++++++++++++=
++++
> > > >  drivers/net/dsa/microchip/ksz_common.c |  3 +++
> > > >  2 files changed, 29 insertions(+)
> > > >
> > > > diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/mic=
rochip/ksz8.c
> > > > index 904db68e11f3..1207879ef80c 100644
> > > > --- a/drivers/net/dsa/microchip/ksz8.c
> > > > +++ b/drivers/net/dsa/microchip/ksz8.c
> > > > @@ -1715,6 +1715,7 @@ void ksz8_config_cpu_port(struct dsa_switch *=
ds)
> > > >       const u32 *masks;
> > > >       const u16 *regs;
> > > >       u8 remote;
> > > > +     u8 fiber_ports =3D 0;
> > > >       int i;
> > > >
> > > >       masks =3D dev->info->masks;
> > > > @@ -1745,6 +1746,31 @@ void ksz8_config_cpu_port(struct dsa_switch =
*ds)
> > > >               else
> > > >                       ksz_port_cfg(dev, i, regs[P_STP_CTRL],
> > > >                                    PORT_FORCE_FLOW_CTRL, false);
> > > > +             if (p->fiber)
> > > > +                     fiber_ports |=3D (1 << i);
> > > > +     }
> > > > +     if (ksz_is_ksz8463(dev)) {
> > > > +             /* Setup fiber ports. */
> > >
> > > What does fiber port mean ? Is it 100BaseFX ? As this configuration i=
s
> > > done only for the CPU port (it seems), looks like this mode is planne=
d
> > > to be used as the MAC to MAC mode on the DSA conduit. So, instead of
> > > using this property maybe you should implement that as handling the
> > > "100base-x" phy-mode ?
> > >
> > > > +             if (fiber_ports) {
> > > > +                     regmap_update_bits(ksz_regmap_16(dev),
> > > > +                                        reg16(dev, KSZ8463_REG_CFG=
_CTRL),
> > > > +                                        fiber_ports << PORT_COPPER=
_MODE_S,
> > > > +                                        0);
> > > > +                     regmap_update_bits(ksz_regmap_16(dev),
> > > > +                                        reg16(dev, KSZ8463_REG_DSP=
_CTRL_6),
> > > > +                                        COPPER_RECEIVE_ADJUSTMENT,=
 0);
> > > > +             }
> > > > +
> > > > +             /* Turn off PTP function as the switch's proprietary =
way of
> > > > +              * handling timestamp is not supported in current Lin=
ux PTP
> > > > +              * stack implementation.
> > > > +              */
> > > > +             regmap_update_bits(ksz_regmap_16(dev),
> > > > +                                reg16(dev, KSZ8463_PTP_MSG_CONF1),
> > > > +                                PTP_ENABLE, 0);
> > > > +             regmap_update_bits(ksz_regmap_16(dev),
> > > > +                                reg16(dev, KSZ8463_PTP_CLK_CTRL),
> > > > +                                PTP_CLK_ENABLE, 0);
> > > >       }
> > > >  }
> > > >
> > > > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > > b/drivers/net/dsa/microchip/ksz_common.c
> > > > index c08e6578a0df..b3153b45ced9 100644
> > > > --- a/drivers/net/dsa/microchip/ksz_common.c
> > > > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > > > @@ -5441,6 +5441,9 @@ int ksz_switch_register(struct ksz_device *de=
v)
> > > >                                               &dev->ports[port_num]=
.interface);
> > > >
> > > >                               ksz_parse_rgmii_delay(dev, port_num, =
port);
> > > > +                             dev->ports[port_num].fiber =3D
> > > > +                                     of_property_read_bool(port,
> > > > +                                                           "micrel=
,fiber-mode");
> > >
> > > Shouldn't this be described in the binding ?
> > >
> > > >                       }
> > > >                       of_node_put(ports);
> > > >               }
> >
> > The "micrel,fiber-mode" is described in Documentation/devicetree/
> > bindings/net/micrel.txt.
>=20
> Yes but that's for PHYs right ? Yours is under the DSA "ports"
> node.
>=20
> >
> > Some old KSZ88XX switches have option of using fiber in a port running
> > 100base-fx.  Typically they have a register indicating that configurati=
on
> > and the driver just treats the port as having a PHY and reads the link
> > status and speed as normal except there is no write to those PHY relate=
d
> > registers.  KSZ8463 does not have that option so the driver needs to be
> > told.
>=20
> That's what I understood from your comments indeed, what thew me off
> guard is that all ports's fiber mode is configured in the
> config_cpu_port() callback.
>=20
> I'd like to one day be able to deprecate these
> micrel,fiber-mode/ti,fiber-mode properties in favor of the ports API
> that's being worked on, but I guess we can roll with it for now.

Is that required to declare the parameter in the device tree document?
It is just a bit of hassle to create another one just for KSZ8463.  The
other old switches likely do not need this.  And the new KSZ9477 and
LAN937X switches use the SFP case logic.


