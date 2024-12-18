Return-Path: <netdev+bounces-152896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5527A9F63E0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22B118834EB
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B7319E7D1;
	Wed, 18 Dec 2024 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0Mq2A9jW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170AA199EB2;
	Wed, 18 Dec 2024 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519182; cv=fail; b=j2HEFPxOGTJdjNJCBSMtCWewH1zHa10wD+3WQS6ZXPWUirVjBgR1JLwlL2tJOaCxkpjIQiUF+N8edLjCQCMIj4i1ruBWQoXUlCKowO32VV0qL68n6OQ0erq8XKdyZyP/3vIIsVBvQOMhgZ9F7VzD2ATS0yFWh0X5i9poYa64bc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519182; c=relaxed/simple;
	bh=2tiPJuFxEsEF9tZ7hs5kiA7B2ltNJGMIB2fm3S3RQ5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ftroIFzCGr+Ku0KvH7V/Jzyc3T96hMrKHHCurYVMgg716Wnt06qekEdFPbDN53QgwCc08ReNCwKC9yazXfgPEgNWnG86XvuTUmMtekctwBQEIT8lP4vetVUgWCjLz4z8biGVLysW8ZtOMJUHKF80bDoJltQ/7NnDKNWFWuvAqas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0Mq2A9jW; arc=fail smtp.client-ip=40.107.100.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJDu7WUSP/c7zBy4Vf+0Rzz+S6K7q989ILYEq6xy7zUcM/HWgYSJN6Ko3y4SrajFjfdDWgWw3mBvYpwU+v5WsbAWTR+E774A2m6I8uSAPyJzr5SVBfSwZL4ibmfdOAzG141h7SSKGRi2/czWSZgp3L482e60BNCvcuV4ywuNXOu7UJR+UFbplXqA6XfHt5fcP7dAkRhEUaclRO9iyB/SpAvcYk8oCPgr7Gq3SE2ks7/sYxqVxS9m6aqZY67AMYnGj4inDIQQmlEAfQLybk+F8RiZsPFg20lukO7Qbon3PM+JrY4kGB6yU7g5NlefupmfsKshsS8HwkCN7/y2+cJtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWcnyssSQ12CRUkWcmviYagnnAIUUHOCmZzLsFfFvxE=;
 b=Bbc5b7KT6UMMQT6crXt3xiqQXW/QoDiEb5SGg5AZ1UchPq8I76vLcsfvvyTzhGb5uMgNDpbVTnkxP1V/AiRKMyz8qMa0982KZZtI49xpAx35kNwRfC578TlU5A+iWUHPQ5uaFrovrlIFKdAi1X31fIbrYdfrbtNyqnVNntSXgQD/LYlCk73UMZony0bdAf1zis2EeO1euQX9DsV7PRtc6U0Dtcf0lWYSO5J6ifK2BjhOfu46Fb6jMBegywTrh1S+N4yatffLXssbAeF8DlU1YL2TcQiuOEXDFgjyNmjx/Ja4XRfEDiibq3fNlMZVUe1/7PMciJeLk6kZljwrh80D+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWcnyssSQ12CRUkWcmviYagnnAIUUHOCmZzLsFfFvxE=;
 b=0Mq2A9jWcrg5QM9NElNrfyk0oMVCG8lGTtxcf3if3SW/XcMpsiOTqX+IwlH59yZsCm65B3qznwBsqI1PXejLmi4cxdwZc/F9JoivRMagKID11Xxk1EFw9NlftRv4xGAaBoJSu0qFF3jsigENTqaN78cemaSQzudClTdGdpCrCVI86ufjB1f8nCtJJ3c1xmN4oopMS8N7pITkN83PoVX02ZCGnkEbAx8KHT0xKNFARbFsgUA+Yr6CO7d6Eg6/6HzmZ3VrK7wLOQ3nXjw2QPBHL3AdMmXh5MnHBe+IEQUwKtlEoXVcKYUPFB7VKUWOjJ+Xt02X8yMDHyjNZtG+XIInsA==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by IA0PR11MB7791.namprd11.prod.outlook.com (2603:10b6:208:401::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 10:52:56 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%4]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 10:52:56 +0000
From: <Divya.Koppera@microchip.com>
To: <kuba@kernel.org>, <richardcochran@gmail.com>
CC: <andrew@lunn.ch>, <Arun.Ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <vadim.fedorenko@linux.dev>
Subject: RE: [PATCH net-next v7 2/5] net: phy: microchip_rds_ptp : Add rds ptp
 library for Microchip phys
Thread-Topic: [PATCH net-next v7 2/5] net: phy: microchip_rds_ptp : Add rds
 ptp library for Microchip phys
Thread-Index: AQHbTVioH6zIUkCJu0CrnJebL2w0LLLrXYUAgAAG1gCAAAL8gIAAb76Q
Date: Wed, 18 Dec 2024 10:52:56 +0000
Message-ID:
 <CO1PR11MB4771ED94C34E6A15F87AD812E2052@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
	<20241213121403.29687-3-divya.koppera@microchip.com>
	<20241217192246.47868890@kernel.org>	<Z2JFwh94o-X7HhP4@hoboy.vegasvil.org>
 <20241217195755.2030f431@kernel.org>
In-Reply-To: <20241217195755.2030f431@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|IA0PR11MB7791:EE_
x-ms-office365-filtering-correlation-id: 11aec3e0-c3c0-49cc-7469-08dd1f52215c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tZPQv1gxum6ZooD1wlQiP4mLWIFY0WP9mmqdn2hhVB9XN5tua3vRf/dmWXds?=
 =?us-ascii?Q?l/5M3B7b7ESGJFxgAdlRZJz22AVUEp7WIvvIFSk0NAe/l6s1ttZLZO7I2s7+?=
 =?us-ascii?Q?z856pJwO+afBAzC/+14WtBDxzPV/5xqEZ3bryBx34lDdFBhyHAYgYvcZsTWf?=
 =?us-ascii?Q?5vsSFu5rTkHmqJXfZSa3epAxlZvJVc8CZYMzUrC27+4XY4IfQ6nHaekV9RkR?=
 =?us-ascii?Q?hVpqytA4G0aqZ42inmPjyHfHmaDzjTHAL/lDg4eLNxvP+Adj1yU4dAzThaZt?=
 =?us-ascii?Q?jRwKe8/fx/PJiYzr2ixnhk1qYlbufArNp/tZTc/EQqdiX2KH+Q0gP2U2Er7l?=
 =?us-ascii?Q?svvQo5TO9hb6sxNFO/Y/Aia6zwsOxA9mgHtP1NLjT55dTbxbgcVfUbK6zD4P?=
 =?us-ascii?Q?bk6JN010d0tliaKN/sUxsH2BkR9ld6lfJ0JKx7gX/+7C25ieFlBg4g3YK/8i?=
 =?us-ascii?Q?H3vgGkSE7JwtpSl2HBRpBEFBsdtGiWrgVZ0ON89etzNH6pjzqyHJotewZN0f?=
 =?us-ascii?Q?51cLvBHazWKxH8TmpFXHR0d3LsmQ66Nl5znO22UJO2N5juUa++4lvT+a/HIP?=
 =?us-ascii?Q?goeTeZ3c1Rn5OOH2jRko9fOVDeSQ8cREfaDf/dHNmjZUUlfD2sLnaaPITGD8?=
 =?us-ascii?Q?ixq31Oeq0Sobsu7kUD84yEPLAdvVmMH3zFAKgJat/PCZPQX9Ml7z4ckXL/pq?=
 =?us-ascii?Q?HZ3zSwijsvP34FFV2qd2/r41Tiuuk++vsGp/J6wfWTi+tKUDwaB1o2BOoDK3?=
 =?us-ascii?Q?2GJhTfH+NZAk1gdQ8T0ivkbxvDads70fVY3XHMRiE6wG6YbQqUR0qgPCo8wJ?=
 =?us-ascii?Q?LExaw3XU9d1wPKwOxpTJNC0lz1LElPtEBm1iRwxeINmZkuZu9A8dNzinBoZ3?=
 =?us-ascii?Q?tVeT3OxlcdWvyr2SLyD4UwpX+2MBsFBaLHReYv5htFmxjKe3nuLGq1Az0q5x?=
 =?us-ascii?Q?DNzSNqfwepB1jqSHNtNK5pwDjJ27iD4tbytIUqOnYQia1vzcU7m0+ufxHe0L?=
 =?us-ascii?Q?vDWmSsUy0nngDyiNnTczhs3fiRTI/mof327ZXuatEkXGmSMijR0fis5XVxn5?=
 =?us-ascii?Q?x4T4Wk3aiezwvZuLbTW1ZBooAr/s7a/8zcXuSivknsYt3kC46CyHzFCTYELD?=
 =?us-ascii?Q?OUTw3ck6cAHdStNWz+lE9NbeAkYKh+LDtFLUAEDd4wPNlZ2u41hbXhf16aoZ?=
 =?us-ascii?Q?NUqJRxeld4Xex02IlayUANa5w7l1KU2FlNeVW1wTfgIf40ImiuBWJyKplGdy?=
 =?us-ascii?Q?d6iH0wBI2B7/OA1ER1uvS0NaViZvV40smMu0yw6bBUqHah9AR69GyrrY/oSX?=
 =?us-ascii?Q?lxcGiLe3xLGaRKN14uo97C4x8wkjeI+R4Hc3wKyhVg+0Ee65eDQ6l9zthgNi?=
 =?us-ascii?Q?7dPBkbyOyTutjD90zFQYsLuDOL+gKaUQy8JzS+gNEu/qzT9EWYcEN524EnFs?=
 =?us-ascii?Q?gvA8oUcHB6A=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?puMfD+yJfYOe2bn38Zh/T/SGUM3HvcXBcjWyvUtf0FpERMW5LGGOsRovD//W?=
 =?us-ascii?Q?+/3N8yoKbbJGtELxpQkiZyCFL2sHZRuOTTdwiTbYsqhcwxRUUGPkG5pBXNnk?=
 =?us-ascii?Q?2JHyliUq4ZuGRDlIRqS9mXaNGiS5ozx5h8FJrfYRA/xo2cIGFwCKV+JA9gYq?=
 =?us-ascii?Q?BzKdyS9a/qIOk4rbglra6RQNR+aNhvP+E+mf3GIxlLKJTMNT7DjuoES7Vmuv?=
 =?us-ascii?Q?BNVvTshMHuSpm6EvLZpI5UsDtxcVyeNw4y+52piUNv8NtiG2rw8DS2Kb49lm?=
 =?us-ascii?Q?6wn35A13FrtnWi+lM7da7JY9FMNBknkWZQf+Sq3Pxo2VrdkcxTHnrN6OiFaw?=
 =?us-ascii?Q?hPUvFMBHtJFk2PH8iWHTgv3qMmCKhxXixLEef7pg7VmyZt5nsrL9JtZu/RI9?=
 =?us-ascii?Q?XsYSdegDeysxdMu0lk9JEvF+Anzq1rEKuCOj96rrsTrtZithCXLv9u3/ViyF?=
 =?us-ascii?Q?Xk7cG8b311XkHQ8+wzyGxQcKMdxQleiOcQj5CegJNi3xX6j731gBOTDwisqo?=
 =?us-ascii?Q?OI9y5K0nRaZev1yKKc3Ox8bgLInwRf3RM+Eva/89p0rK2U8UoMVVP0fD6MTQ?=
 =?us-ascii?Q?/zZqqJUSK7NgVL/dx9/4RlTsuZTXdQz30btZ6UcwdtAZxgNQ5FKq/JGF8GDZ?=
 =?us-ascii?Q?XT4rLB39j/pLXYG0ZyfhpbPWE9M8nBuj2unsxa7gfobW60wjYX2ntroD/DLv?=
 =?us-ascii?Q?l56E9SghrEdzO356qMq1emr9mQcTyRxSMz7HAkEDDi81Ss1E2UlcnAhr2RJv?=
 =?us-ascii?Q?fMFz5P79+kdjcaurCep0e3P1BrvpUKmT2x4jvx9wOPzgixfxDeW69yTdBbf3?=
 =?us-ascii?Q?e8kGFKxp1JoUZwAH5KVT0dVNRTqZbruAzmUVUnng6jSBtkRQyTt7OtPsyVxo?=
 =?us-ascii?Q?LtTqnNDN9UgnN/7vmN3SlLND6uO+MQcyqE+VI0UgrJRwXyZW1JZuVzV+2zHM?=
 =?us-ascii?Q?bFKmYzxyQAneh5iwo6X+MrsGq/W+OL4Lxn6w0JQ68bz5R4ev7bnRvANtrmQc?=
 =?us-ascii?Q?SqADZpuEmsFdEwC8BTAO4zezEPDe13vNcYNBChLXogFMCwzFs/xcTiAsYnr0?=
 =?us-ascii?Q?WyYV/Hv1e5NjVXePrVZ8zfm/MblHuaYyu5Zjqf6JWe0kxn3y8imb3J0XZM1R?=
 =?us-ascii?Q?6dseOGUMtkgZ4V6L72+uSdheb4mA4aawh9pSLXkNA19vTZBg2JpF9mOGXMCA?=
 =?us-ascii?Q?54xNpbuqei9CN6loE/2CeE8g95WBV4tyVLmVy4XkjZInFItsYmi4m5IVeuW6?=
 =?us-ascii?Q?Kd+xRCOo9C65LpE6eqNMHbiiOHnBouiP6xSE8YTPd32ciSigc0acxieakWVm?=
 =?us-ascii?Q?YYzhjXNU3TAkCuBd0yfmqAd2lUtGtofkbwkJpJN+RuyUTKvSNqHNtuS6It/O?=
 =?us-ascii?Q?MN51EIVYOQWDwjhklhJbwqbfVzIGcm+QjqYuJu+X7b8dggDoa8glBeU9JYbE?=
 =?us-ascii?Q?Q/0BO1iiNPpoToAq9l3Yg7CX66WS2aB1GU9ohyn4F7ut2nCh44JmgadSDuKo?=
 =?us-ascii?Q?+J73hn360jBj4X4ko9IC9HeSUPimx6i2KRjilPGhD+XbU2RY3H5S8Pbwik6l?=
 =?us-ascii?Q?nKhJRn6z0rkTbzEjpJ3eFFLmm9RpzyKzkfEnkKDlz/oP2NNEGQSpniTb/TQ4?=
 =?us-ascii?Q?MQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11aec3e0-c3c0-49cc-7469-08dd1f52215c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 10:52:56.3563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgdFNJzscmRFubGlnt6VT6mnTi9gCo0t+mMddOPKODtktQ3Es/Pi4qumkZqNQM/fEPKxCI5nu51ekB8KBBj1PCuGxb+yAiUuVwYTXxIEUgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7791

Hi Jakub,

Thanks for the review.

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, December 18, 2024 9:28 AM
> To: Richard Cochran <richardcochran@gmail.com>
> Cc: Divya Koppera - I30481 <Divya.Koppera@microchip.com>;
> andrew@lunn.ch; Arun Ramadoss - I17769
> <Arun.Ramadoss@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> vadim.fedorenko@linux.dev
> Subject: Re: [PATCH net-next v7 2/5] net: phy: microchip_rds_ptp : Add rd=
s
> ptp library for Microchip phys
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Tue, 17 Dec 2024 19:47:14 -0800 Richard Cochran wrote:
> > > > +static int mchp_rds_ptp_ts_info(struct mii_timestamper *mii_ts,
> > > > +                         struct kernel_ethtool_ts_info *info) {
> > > > +struct mchp_rds_ptp_clock *clock =3D container_of(mii_ts,
> > > > +                                               struct mchp_rds_ptp=
_clock,
> > > > +                                               mii_ts);
> > > > +
> > > > + info->phc_index =3D
> > > > +         clock->ptp_clock ? ptp_clock_index(clock->ptp_clock) :
> > > > + -1;
> > >
> > > under what condition can the clock be NULL?
> >
> > ptp_clock_register() can return PTR_ERR or null.
>=20
> Fair point. Since this is a PTP library module, and an optional one (patc=
h 1 has
> empty wrappers for its API) - can we make it depend on PTP being configur=
ed
> in?

Null check is not handled for ptp_clock_register. If that is done there, th=
is is redundant.

Will fix this in next revision.

Thanks,
Divya

