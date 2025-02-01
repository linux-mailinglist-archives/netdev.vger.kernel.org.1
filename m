Return-Path: <netdev+bounces-161884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A41A2460E
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 02:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D6A16782F
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 01:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED0215AF6;
	Sat,  1 Feb 2025 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wgpzPXaC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6720330;
	Sat,  1 Feb 2025 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738372325; cv=fail; b=je37osb5UHlOwfQHmvqjv0YAU5gIyrOI3WR9Ot4mCgOCiKzU4GtouTB8N6JHxkwieELOBBFoIK8RHvBAzsmWY3BsvxKyfzAxOprb43/lHVUODuznJajcmUbHqQBbR/PSNqciqzWH5A75qZLR9xe2z9PU//2kAsGt1Ar3OZ7T1ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738372325; c=relaxed/simple;
	bh=7YIuMUwE5xXmUbTqWAk14Q99PZxE4Xa6CyhkCPte8W4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OowbhrB8jDHdu8XubweZwnnDDjpyE/oytbNcoBuZqZtAIWb+mi2ezDXpmHYxoTOjA20zLqtjw+6j7Zw3S0dw7f8zHMhdZNwgDqsXFh0D3rUCIGnEQ2kPtmr/rKsYkK5IoT4xrxwA3XeUjKHC5jyPKbwKkQZsKnaFrpp4zNsjBs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wgpzPXaC; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOoxwJQAKgNG+zAk1QwyjOlVCQ1Ki4BkczpEjK7NYymzL+sPS9JW6hhMSjlNvAqlfj/R95nSQ8MM/cto/yLdSc2OobbzX4xTL7HRqp7+AEHj14j3gUyJMlyXMNEIzcky0bUkFyMKw0yaF4jNUHFw23GW3It6pfu9IcCYFKC6dIaMx6c+ZEsnQ4V5Psmae0MEUP3nZeNxZqQh79fatL0s12RDk/zDNAE2tDXvYHejy1Lnd4slDui3nubnSV1ZlwLtXyrtmIDp3h8e2BYKC68w4MqBzS+67oqIpOGNqTm4pPdk9SaLJGK6P3Yz+41zmSTftEg7mnENmoo4Cu9jMsQVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7xYkCIrowuCqCnBI8dNq51pmimZrlFds567xyMMlgU=;
 b=ruRgGNOB6Eb4HXCZOooARBkHAc0jC2CjMazWNOnGpITf55iEaSf4CGlKDneXmoF3osUBAOqrEZpND2QViTvBQyyIlQ6TwzhYZnDvGviRvwfqHEvciCDqIlFCv4kPM0EaBjIuOYL0G2RqFAD89vgHisa7pz/InEXFZ42z3IEdLJHBWheftxGOlRY+gp8ugAWxO8RfRsmku1Dfecn4mouU3lKAVa+5SFplGa/UWDZ/5fL6BwYPntXdub4bgYsqGyk+rFBKKwv9PY16GmWn2CRdC2ubNCRTcWwM4X1M0Ba4bQTA8Hq8rBbrE5bCEhx4dQQspdOBBjPU3O1YD9ULeti0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7xYkCIrowuCqCnBI8dNq51pmimZrlFds567xyMMlgU=;
 b=wgpzPXaCvO5dDXez1i0H6LgXFYSOe/EU+Jx8aIi3m8f1rJjW7AKeRN1jzmnb2kIMcihc0pMFuJx48eTFqsAddp2S4c3aO06bl4ITZf3p16MEz0f7nk3KXQQON2YqhyWx+SGybtRSPrZXGWqhw3068NJh5/wWY8j3eHQYIuURfdI6GBv6uDTjUxMN4SdatVlrZEXRv18hsPlljY7B1H1l5AB7nyyWhUrcS9bGxUtnBRDHjPgkcy69625arasI0EL7FwidEKqlrEiQ9SHoTtPLEUr0dWvVgaoi1LhTceOH/X760HNW1MrXZcPV1ZLDdj7+0KDA8RwzKlB3vr+8hv9CDg==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 IA0PR11MB7911.namprd11.prod.outlook.com (2603:10b6:208:40e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Sat, 1 Feb
 2025 01:12:00 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8398.018; Sat, 1 Feb 2025
 01:12:00 +0000
From: <Tristram.Ha@microchip.com>
To: <linux@armlinux.org.uk>
CC: <olteanv@gmail.com>, <Woojung.Huh@microchip.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <Jose.Abreu@synopsys.com>,
	<maxime.chevallier@bootlin.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sadhan.Rudresh@synopsys.com>,
	<Siddhant.Kumar@synopsys.com>
Subject: RE: [WARNING: ATTACHMENT UNSCANNED]Re: [WARNING: ATTACHMENT
 UNSCANNED]Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Thread-Topic: [WARNING: ATTACHMENT UNSCANNED]Re: [WARNING: ATTACHMENT
 UNSCANNED]Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Thread-Index:
 AQHbcTVTuivbdfDuaUSUZ/9LsKZxAbMr6oWAgAAP2ACAACTNgIAAL48AgACPMRCAAWS5zoAADrgAgABkpMCAAGO4gIAAEKMAgAHOWoCAABRQgIAAmV5Q
Date: Sat, 1 Feb 2025 01:12:00 +0000
Message-ID:
 <DM3PR11MB87369DE499570C4D4A6E3C9FECEB2@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
 <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250130100227.isffoveezoqk5jpw@skbuf>
 <Z5tcKFLRPcBkaw58@shell.armlinux.org.uk>
 <DM4PR12MB5088BA650B164D5CEC33CA08D3E82@DM4PR12MB5088.namprd12.prod.outlook.com>
 <Z5zxC3hwk4C0s456@shell.armlinux.org.uk>
In-Reply-To: <Z5zxC3hwk4C0s456@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|IA0PR11MB7911:EE_
x-ms-office365-filtering-correlation-id: d350f2f8-69cb-4cc9-9907-08dd425d6e65
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AiV/rxreLvSVpjgbjif0EgwpSBmJQyeHHQZGSJ886/Mjh/Eb5SlYMC3uVWxg?=
 =?us-ascii?Q?CdQ2Abr3MvwT7CjB4gdhg8QU1M6OQlj+Tj9g8vN0yLe4CbuiORbe++Y9F6dj?=
 =?us-ascii?Q?3OSugaS2112hIFkvp7wlYIDYcfyBI25wfeFmDE2bO9e8QKggJhALwJlX+cnz?=
 =?us-ascii?Q?0LQ/VGOE6JPvgEyB9dyLYpzgGSsLQFGnK9sLz2RjUhhgP9gWiqZBHdke6jzx?=
 =?us-ascii?Q?obgeCG9I9tbyUCfVQeWR7PtGdY26bAqmrORxhA8+voHOFtAq+JfHlQZzQ2ol?=
 =?us-ascii?Q?uUELhyTEHAfLf2/iiTiSjfW8VB9OrVEk2XaW7SgaiYlFCoXVZDs/YDV6pGq5?=
 =?us-ascii?Q?C2lDoqXrz1szQxY56dko+wogDQx6fVPtwoMux5xk0phKt7O3F16fissQinQn?=
 =?us-ascii?Q?4MBA6owhaj7MKwSwp5+ud3yWaf+wtJIrULyLBycUBI8lvBaF1mUXpZlZmP0F?=
 =?us-ascii?Q?jvrQlEYbZePcRRCW/LPvNr3D19vhI3gcsmSqL8EutTg4fyO2lg6HEbg+6r0C?=
 =?us-ascii?Q?8qugPR9IopKIhhcYBXm1oZCXSEFlGR6zKJJxaV03JldZQZC3UyjZbKKLOupy?=
 =?us-ascii?Q?EDLxwM9+/j/ZzSzbUEuXkHa+vKzp8+OYlif5XSB7JFqs3cHnz33z73vHep4+?=
 =?us-ascii?Q?Lhqx2TTLE/cuVlrMoOD3LnNNNy97mcNeAn0b2PuGnPOKNGfQYSvmKEE/HaIQ?=
 =?us-ascii?Q?PK8KYS2zH6MB0pQZSCuWsnjdarW3WbZqM6LymKF06YRDm3+Y4UMEKcuv1/0l?=
 =?us-ascii?Q?rjRx2IDhreiQEgVNILWgyeUhF7HOuVHscdGO5esvXXX3bmZbIE97/68eoKHZ?=
 =?us-ascii?Q?d2hZUDkkEkl/b1MqWx15cyQQjXVyBjWKJD3MHQdsoTzbKOlzWdZGR/OwvKm+?=
 =?us-ascii?Q?hQQEhpqBpCwfG5NCgqpM22BNUyIY5n9/9s+6+A0nkl7JmsvSpvhbfQVuH2cm?=
 =?us-ascii?Q?SXAcqeJo2qGgQ+fIpsdPH6wEpcDUBUeg1JgvvcS+sRYroK0FR3eqrhGYlM0e?=
 =?us-ascii?Q?BYMb6er3hYBYYMKtr1HQBZ/mvIUyWxkL0fwd0W59NCDLRIEArWchl/hD42Ac?=
 =?us-ascii?Q?HJwyqvVYATeLSIWqkUiMlnCzYvVt0pHZ46Dm8HvTfzdYDdPKZVh01jo1uPL6?=
 =?us-ascii?Q?7hMxPU04KvFlqMj9WA2MNkL/QQBaAttFzdf5zSxm+0d/zrYl1t7TQrmM4Cpv?=
 =?us-ascii?Q?mqbvhlWyfpcOpwnmo3MPUVgueUYvaoQIvscOXhEJkLjXzodIGeUvgEPh/MpZ?=
 =?us-ascii?Q?7MwX6lNJPuNmp0fLy/hJ9I2Os5gKLLmQAMNENoN2Jv7xufyzgpwKPUVdV+DA?=
 =?us-ascii?Q?fPkBUsj/zydXYyry3231APU2P2bdU87F1fPyaVFW5U9nsUUg0+hctCisvJlB?=
 =?us-ascii?Q?n59XwDMRnNBzS8iilQiIz/pawbVbD5KqO9RunbZIDzK6RAKDALGbEhiYszcb?=
 =?us-ascii?Q?opT/yzS9DzkxM9NKZ8XbWhDX8j7ZU3yU?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rr/aModUaKbTz8zUSA77y3sc7IPRuuJIxbI8DPBiisb5/RSVE5rzyui+0M7S?=
 =?us-ascii?Q?Dql4WQxN2DUITsFaQSX2oUk8LB8Tz/xxBoYRKuVj08iTrtQzaprWefCMWXol?=
 =?us-ascii?Q?XCtA6rQ0cK4wdMST6g/Z0rBvo9rU0hSDsHL23HOE7za3uYtFwZlxGKlM4G9U?=
 =?us-ascii?Q?Zj17RX4XvDe8NLx9Yf2IywJXos/Vs00YmDXM8pdM0mlBDb8sFGP7lCP9uDxQ?=
 =?us-ascii?Q?Eua2aB0rzx4mGZ8FAQ8MfyHwBYlSQ8Z/7C690+YqIS/NRLmBH4n26Dqss9to?=
 =?us-ascii?Q?HrrBoWTSdlN8BUkjBL2dOIzr9dO7YVE2kzfwbRtFAzOIsopPZX002IHfXW79?=
 =?us-ascii?Q?Dx+5s11Y+lXftbgK2oOI8GBTwBDNBhLtc70dcivuoQZxk94t8MpNfybnQAne?=
 =?us-ascii?Q?jlAFHyRhDzG24Ctv/8RHjWBJ7bIPbWXcldmZyFFWPIJLbo23SLO1f9XniJSg?=
 =?us-ascii?Q?HraLwQ4qqpLBMdoasAqtgQgWe3SUyxoGGc2/fyH5mMNWTxFYY/wDxxSprqMP?=
 =?us-ascii?Q?rvM6FmY5/A56UYtmCxN32iRMYymcjiZSvvaxXefKioU3RQPm6SlNPklc6sne?=
 =?us-ascii?Q?y3MjEmcctk9+JK6MdZY68Jrs7/aHs2KOJJR4xk7hJ48DFL5SoIb8QSmXKE74?=
 =?us-ascii?Q?q4jEeuxK7clwqprDDom5wlRZ7fNNik1HcHNE1ZkiPtBBFkWanJQ69ghPEqUL?=
 =?us-ascii?Q?Mf+KmjYMgGntzPIg5NwOVmpgLamw9kZ8yXteaoW+k08LhvU2mjX+wr3w2XpY?=
 =?us-ascii?Q?93eB6oK/FrIPztabwgKdoaP+0lUJrv2U3h9V9Qfce7AH8WytCH6Eyjdvxg8N?=
 =?us-ascii?Q?EWTSY8Sx66ZZlX1ZRgRxern2AIGk2DaVtUSF8/bUFgZ+IrQOsoRJmTFRsrKU?=
 =?us-ascii?Q?lN5VZGvzgxHODdwliKbE6s0ISu0nOccMzuBAnweeJmoc8sDKJyKvdPfUu2ZN?=
 =?us-ascii?Q?KNvgmRy2upa4nmHLLq35LZTaiSH5UGjTkl5EtlO8B4ghbtBX7c2nljW3thfK?=
 =?us-ascii?Q?X30UUCMiRKUocyVM44IOabD2FFFtm7avku/J0JHe2ovfxvkyPkPjCC5+Rpcp?=
 =?us-ascii?Q?+t2JSRUMvumbjVCuKXQocuGae645PkeIGpl9cUHy/Am4LXqeOcIWUDUExRvz?=
 =?us-ascii?Q?/dcBLpQ8Qhh6V2YxegL7KywY2PC6WlznLy1m+JV7KcuF4h9hQIJVHTRxwS+H?=
 =?us-ascii?Q?YXgHCUJfsTY2GoW2iGlF1rX4IEzQnb4PbwXyw2iVzyaNOkxGhV92Mb4otkjE?=
 =?us-ascii?Q?LAUparP9Zavj95yyzH6mEY5WWmEIo4tixja8PmJM7f2V8Os+Tev1fEy0nanW?=
 =?us-ascii?Q?1Og737LhSnHGlJ7spSPtc2nLOxTv9vkYLRVyB61h5ea0+OwwAlO/AscY4dUx?=
 =?us-ascii?Q?0Oa8H23Qa8Hbvx6UOf7ygWACClrNKTg3N3kbw5crBuYdw0AWyi5s8GKgw2ef?=
 =?us-ascii?Q?muIs6T1ZH1bEcOAEIk5IDZpkku4E/On31fygLwCb12ZFCyRCs9tq/Ab0uDHW?=
 =?us-ascii?Q?DMIXIq6oHTty5T3xfUALqwVi8RPkB3Fo4XRJhc7gYBrN79PK96RuPjJTn2na?=
 =?us-ascii?Q?Dx3sJVa/gtsnMJj0gd7Kiva1Kp64/Gtix93jcokc?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d350f2f8-69cb-4cc9-9907-08dd425d6e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2025 01:12:00.7646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOKKMqIcnsOK3i/h4aAMwMEWS1CLN/NaJixoa1iemhXzxmTBgllicUOj56S5Ru+qiB/JUkeFwZ5Yt6hHir6ZD8rwfayjvwtr3XXZaMtJxR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7911

> On Fri, Jan 31, 2025 at 02:36:49PM +0000, Jose Abreu wrote:
> > From: Russell King (Oracle) <linux@armlinux.org.uk>
> > Date: Thu, Jan 30, 2025 at 11:02:00
> >
> > > Would it be safe to set these two bits with newer XPCS hardware when
> > > programming it for 1000base-X mode, even though documentation e.g.
> > > for SJA1105 suggests that these bits do not apply when operating in
> > > 1000base-X mode?
> >
> > It's hard to provide a clear answer because our products can all be mod=
ified
> > by final customer. I hope this snippet below can help:
> >
> > "Nothing has changed in "AN control register" ever since at least for a=
 decade.
> > Having said that, bit[4] and bit[3] are valid for SGMII mode and not va=
lid
> > for 1000BASE-X mode (I don't know why customer says 'serdes' mode.
> > There is no such mode in ethernet standard). So, customer shall
> > leave this bits at default value of 0.  Even if they set to 1, there is=
 no
> > impact (as those bits are not used in 1000BASE-X mode)."
>=20
> Thanks for the reply Jose, that's useful.
>=20
> Tristram, I think you need to talk to your hardware people to find out
> where this requirement to set these two bits comes from as it seems it
> isn't a property that comes from Synopsys' IP (I suppose unless your
> IP is older than ten years.)
>=20
> That said, Jose's response indicates that we can set these two bits
> with impunity provided another of Synopsys's customers hasn't modified
> their integration of XPCS to require these bits to be set to zero. So,
> while I think we can do that unconditionally (as per the patch
> attached) I think we need a clearer comment to state why it's being
> done (and I probably need to now modify the commit message - this was
> created before Jose's reply.)
>=20
> So, I think given the last two patches I've sent, I believe I've
> covered both of the issues that you have with XPCS:
>=20
> 1) the need to set bits 4 and 3 in AN control for 1000base-X in KSZ9477
>    (subject to a better commit message and code comment, which will be
>     dependent on your research as to where this requirement has come
>     from.)
>=20
> 2) the lack of MAC_AUTO_SW support in KSZ9477 which can be enabled by
>    writing DW_XPCS_SGMII_MODE_MAC_MANUAL to xpcs->sgmii_mode.
>=20
> We now need to work out a way to identify this older IP. I think for
> (2) we could potentially do something like (error handling omitted for
> clarity):
>=20
>         if (xpcs->sgmii_mode =3D=3D DW_XPCS_SGMII_MODE_MAC_AUTO) {
>                 xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL,
>                             DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW,
>                             DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW);
>=20
>                 ret =3D xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL=
);
>=20
>                 /* If MAC_AUTO_SW doesn't retain the MAC_AUTO_SW bit, the=
n the
>                  * XPCS implementation does not support this feature, and=
 we
>                  * have to manually configure the BMCR for the link param=
eters.
>                  */
>                 if (ret >=3D 0 && !(ret & DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW=
))
>                         xpcs->sgmii_mode =3D DW_XPCS_SGMII_MODE_MAC_MANUA=
L;
>         }

The IP document says version 3.10a and has date August 2013.

Indeed it does not make sense to use SGMII_LINK_STS and
TX_CONFIG_PHY_SIDE_SGMII in 1000BASEX mode.

My thinking is there may be a hardware bug to prevent 1000BASEX mode to
work when auto-negotiation is enabled.  And somehow setting those bits
workaround that, and those bits have different meanings.

In order not to use those bits auto-negotiation needs to be disabled.  Is
there a way to do that in normal driver activation?


