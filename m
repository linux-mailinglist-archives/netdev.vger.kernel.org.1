Return-Path: <netdev+bounces-152520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B359F46B9
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B137D1889CB6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7356F1DE3A3;
	Tue, 17 Dec 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E3UUpHyw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BB1DE2C3;
	Tue, 17 Dec 2024 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426029; cv=fail; b=FAV+h1wOPhp4+Dlgz72PjyjzoGy0hPA3P+ca0tMyPjn9IectN4D9g0JnWCdCoO49agbSrG+aQOGz6Zc+cddL2s6sQgJeHHQyflGwGOTcrT+0Lb/pR+9vGBtlsN1IXhjKfYj5BrvX2OlCt0sfzkxOdovFx6N5Z/wJ2PYv65LCaXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426029; c=relaxed/simple;
	bh=dcFv5yyIxEdS/U1TdF3+fxSUBjWBaIBJpPPlfw1UOPY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uzsxh8HITpACrPQvQmO+6tqxnXb55t5N8YvGeNYq9CjjqPEJdYFp1lTJrEmdiXVr6yL/YOGfKwq5jfyg7N44xZaZpTCDKhLyPuvpDBD9lUtEKRMgreneYmAkzEl4gG3w1CqNYtld0L2+qLCDXap05e/ajv5LhP1qx4DMJkqjd8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E3UUpHyw; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEY7mAbRc/oz+xgwW5cXX/z1R8XBhAQc9d4LsD/TmGiM7+ZucnDPUnRlMv9fax/YATfh0UnDOUMc6uLvxa2Is41azL/6wruud2RmCOLHHkqStmttPaSxoFh8Vs8+niZB7hrC54vhOddhGwB0sb/4Rcz5a4U92oEJl510aaJIO25xh3NFDqv7lBZ3Ri0KwctnCbjvrnjTRAu1xgVmqlja73OEasfbofocvdBYJQIPlP1Jgw1v3XQi18wZFJ9VQz95hqQyrpJBy+iST+Jw+WFVNeavfwxsD10i4viU3OJIxS9dtgrAzbyxna+yMR5W5HbkD6qGGMPeahofLwK54t4S8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP4A4G8HvwgS2964AQGYn6PHxwMGDjVmjTzphc3HquE=;
 b=LxK+9UUdS+AKTTgSvV4ZF9ktk9eEWdSZVf+mFbSqjQn1WH5oD8eGYO3MWcJdA8oeIC5DJ+ygsCnuY0e5gKmz8cbgtDPmFdfQWo2XejObk7/YY+1RG6nDJYhC0olP/fhF+ZHUjnN2DsCODpiXxmMA9QTOCyH8CZgjmqz9s0DycXwWD1CLtdUvzz9L+6WRBZrcot+4RC8gOqY10c7krjeLMH8ZZz4QAjnEfmV0uc4lIfCIh3LwQXmr8KwecaoAWyj0U7TuGJNpwAa5jpQSsNFStUA9tTrg0s0e7PES6uZSdWAdeUP3Oi6+yJpRRSic71PVtjcfTLGLzxa+5Av32l9pAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OP4A4G8HvwgS2964AQGYn6PHxwMGDjVmjTzphc3HquE=;
 b=E3UUpHywuDhyo41z16eZxDKnoIQbh8hqYSZ+F3GPOYLiNlGtnCnBmXDz4KK6+XxW1FN3icNX1Pobvl2YNA7lFQiRC8YZyQyE7n+OnCjMh+w37eiRXTKERUnCIp0gNSKSlO0yZycSkqLWi9d85G7NIo8CQ9po7Ll7pli8jhDZcHo7OrrnJWtSG/k4BHUW/hwHkvDwmhlhEbspphMbSPN2aeBBG0n+GtqTX9e2hdhwl0++GZNYqjcU7r0PZ0Y8IpaEKWUBogLjE0bcnpufEYAMKh+I0ogdcsub6eseelUfuE7ZL+ayoxnUZYg+UVIGh3zjPkNfUg3te0/5Za9o1DK4TA==
Received: from CY5PR11MB6234.namprd11.prod.outlook.com (2603:10b6:930:25::18)
 by IA1PR11MB6371.namprd11.prod.outlook.com (2603:10b6:208:3ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Tue, 17 Dec
 2024 09:00:24 +0000
Received: from CY5PR11MB6234.namprd11.prod.outlook.com
 ([fe80::a2c2:d255:9d85:b56d]) by CY5PR11MB6234.namprd11.prod.outlook.com
 ([fe80::a2c2:d255:9d85:b56d%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:00:23 +0000
From: <Tarun.Alle@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/2] net: phy: microchip_t1: Auto-negotiation
 support for LAN887x
Thread-Topic: [PATCH net-next v2 2/2] net: phy: microchip_t1: Auto-negotiation
 support for LAN887x
Thread-Index: AQHbT9RAeeEzdwe+GEqr8A1nLir9O7Lph9uAgACNR6A=
Date: Tue, 17 Dec 2024 09:00:23 +0000
Message-ID:
 <CY5PR11MB6234815EB819D321645984708B042@CY5PR11MB6234.namprd11.prod.outlook.com>
References: <20241216155830.501596-1-Tarun.Alle@microchip.com>
 <20241216155830.501596-3-Tarun.Alle@microchip.com>
 <fb90188f-0f9d-4c6f-b5cd-800461dc4626@lunn.ch>
In-Reply-To: <fb90188f-0f9d-4c6f-b5cd-800461dc4626@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6234:EE_|IA1PR11MB6371:EE_
x-ms-office365-filtering-correlation-id: 5fc48937-9d64-4a7c-d24d-08dd1e793e19
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6234.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2a9rJbMXNDDyuHHERHnX1NG8DV9px3gNpxifaHnMDj4QutvoxMRH0ihx6nkw?=
 =?us-ascii?Q?MvmLHSe8R/4GfBTKsEvQvxmcUsCmlm2CiaT/l4bQhgCzWCMMnd0+3w5zK/Vo?=
 =?us-ascii?Q?ZL9WqHXSX3xnc/dQCdwmFv5dK4060nzmffqNTN6+OMD3LzUPgE2KvD015dgL?=
 =?us-ascii?Q?utkdLN29mOhHUzAyNn/9LlJVCrAwH2Wqf8De8NEjdCMwdGRsrzJwHtB1nKhe?=
 =?us-ascii?Q?XjRvdJMqay9yo1BkCocc8ZxoDaG6unyhn+plquttPwt9ba0SWpbCCLjAInMY?=
 =?us-ascii?Q?yBDy7e4zM8tXihFcMeqdoKsdDluQDy3ZSee0ygLLqrOIgBkCm5XQeXQsFgmu?=
 =?us-ascii?Q?rHe0xnyzwYB5yHD9uBuEj9iP10B0wBgLoildprCoRoM0jUZsC5Lj9mPwQ0ro?=
 =?us-ascii?Q?FmU3B3lSI5HoCx4Jv/OtHsYAXWMdBHpzR6fnQmdxtE4mntdWMazlBios3we6?=
 =?us-ascii?Q?E0MOWW+WPD1g1zx/CQzmZtGN1eClaHwMOiVE4E8S/5BqpXQZOW1fzCYIvih8?=
 =?us-ascii?Q?Jrm5uFi05+ZxxO2inWLzSBIfOgb0ZK4u+YM2RVQCkdGlA/AKUgcJkc3vIKDh?=
 =?us-ascii?Q?hSN6y1My4/tGvv8zrMxvNaTdc9zZ2Op/mFpRcPpW83aakkkHQCQMZyPsTjDT?=
 =?us-ascii?Q?wGOL1GgndBzHorwL343NEpwdxIF7kDV7A/6pOZN72CjDf/QM7G6mMdnarWq1?=
 =?us-ascii?Q?9aHUpuoF6atUPqiz8fPYXUoJWofmlvnxIR0nXavDZ6SU0I13Ko0Mf8J0hOVh?=
 =?us-ascii?Q?lqGl67t1xp7mKtyS6XuAWTlcKKClJy7dlfgcde9fSk3AgWFDTxc/JKMAEYeD?=
 =?us-ascii?Q?UyNzVBwKHFw4OQ1kufBOQi4ToplrHuXfSbklyCYPEjl+/kG9b/iuxJZ3iI4g?=
 =?us-ascii?Q?N9b//qTCywPtYeeIYxhIGwIjAcJK3h+DHei9ohatX0/TyIDw0O0dSoD8GsKH?=
 =?us-ascii?Q?d5lw8a61hDGCVSstwwUI0Aw6XDpFfNZmvqfCzq/bIjZW0ENQnHXYq7K4Ai02?=
 =?us-ascii?Q?HNUFAP3kuwzoQZUUvXHqa6fm3dAaf5rUzVZX6KQOT77twCnGCbH6T9qjZ5bP?=
 =?us-ascii?Q?cZfNeJYLfCIr3tipAhnsdRbXpb/gNfyzjJRlI2nKTZv2A7jdoedVgJ6BXJpr?=
 =?us-ascii?Q?PSIfEHXwg2vxXV1ECyhZUyaSvFvYwgXfcqCrXKspQL3o/PPmVuEFSmAThsUD?=
 =?us-ascii?Q?qeCzECv6/fxo60YIcqAi4QNaoYUDtTS3Rv0TCrisNOpiWItAh3jhNQWwC2lE?=
 =?us-ascii?Q?/CIzw/6M1QozLiipjIwo4o3j4KrsnoxqPQTJCHIAr9uCHFoxgibFQnzK9zl0?=
 =?us-ascii?Q?GHKuaINcRcdkVEVYF4UbuVT0exMkOo4PrKHR6kXvmkBMoDshCwJDrb9hAHxp?=
 =?us-ascii?Q?Mro+i8RVGm+Dq6mprZC73QViOUlWGcTIHT04kY93HmBNEK1rXofvxSZG/FZy?=
 =?us-ascii?Q?aJbimusgVFOc1v3xxM3y4v98jiUm1/eO?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DrV1+JY5LGgxdQGjHMBhOmHZ2YXSExw2soc+UPEMUlQ+eK2sjFJfoKMDAe17?=
 =?us-ascii?Q?LdGEqCG01Cdo4StwAg7VL0rJ2rhzidLoNLI5VS1JptDRuL6zC2cVadWkIu/8?=
 =?us-ascii?Q?lgSEkyAeHhWpqzUGLA+3kiA6c6R9hMooBMs2ULp/8dlEFcGkkaDOQpGxt7Ip?=
 =?us-ascii?Q?lhbHTkJejIsh/XbWFmJtuNw3J4CYNgLwTVBX4AKo2RxT4JzDxQJJvSdIpthI?=
 =?us-ascii?Q?Dq5jWqb+AwRpNfFxVzsdGVk2VBNUkgvxa3PROunhmpyvAm4/ELiwOR3xlFuk?=
 =?us-ascii?Q?S0PQsbJM5vkI+xvQ+BMOWdfzzMrW1mWmG+2aAzsLHPIx4pohxJ80DrYvRC3S?=
 =?us-ascii?Q?S9RIvmrGnRosBj/eP9Gok0EXf+yjtYJccs7UYm6Z9oWHq0nzsqXjw7RtsVdi?=
 =?us-ascii?Q?7GvSY7q4Q3JbQFZkCC503NEtSMHf3tJ7INII+p+sFnN5JJcMpK8AypNvspyG?=
 =?us-ascii?Q?89IwVbZc/6vuGUsvN9QRFagV9uCJhtoOggXPvP1lCDrBZQqgKzthSn6FMOiP?=
 =?us-ascii?Q?vv3NHAmvLW0yjZRiXqZS9Pon0mJqveszexFI/N2KaSM3KrYHZVro7Ke03IcE?=
 =?us-ascii?Q?B/fsExOLxlkFnka9eI7iVLw1pCTGoqaOo2DUtUC7P7IpRY0ltCySqiplIIuR?=
 =?us-ascii?Q?SjUqjKv22wIHMKqy7YK4MqbUItZ/TnJtgyTd0TgXpeoFIz4hADPKKNouup9X?=
 =?us-ascii?Q?f38VbfUuqpIPQw3wQHwQ4dfHk5K19E1oEevs57jJAQDC3hF0MSNKIpycKn4G?=
 =?us-ascii?Q?N6sGo+/CFNYUS+U8PEAsjeUmNZuo4G7wlqGK+LrVfyuDJDrOpfDR0G8ocm1o?=
 =?us-ascii?Q?+riHzuBU2oSsS/toomYX+xgR/2vi/LjiMTJqKYj2nyff5FNcoAVuYbLQ2IxS?=
 =?us-ascii?Q?7F+PvGNUbjyV3QP00CT3YSRhyDZ4QiftB75VmSMMqJrwxaEB2LVtNfivSXH1?=
 =?us-ascii?Q?enneDrM4GHN5ZHYSOY1owYO8WsQPx8eOJQkB/ND+QDJNm6qJPiaX06MQdV8q?=
 =?us-ascii?Q?QjdTSltBN5S5A1uHVcXlO20s1sgSOHoKOx3mRlyqCaU1prvAGu8+UYjB0n04?=
 =?us-ascii?Q?2LEYNYNl+TYAmUBH2z156C8Yldc73i6g62yODNPpBdIHvqAKkcxn5+FoOa6G?=
 =?us-ascii?Q?byzwDZRPw/Ev7ouj/vtm2vvDOsawQ33v0y3DVr6StCVcOmh1uA8fIRKKDiU5?=
 =?us-ascii?Q?CFHgzS5YzxIYUDdIy16xLm+LVteS/yY5wZb6PdzMUhGnFf/0bsCivQ8BR4HB?=
 =?us-ascii?Q?oFcknsCHCxPAw842cFtOt4X7h+CTSt0jxlekoNYOGtvKt0gNxmFaPZHMGoTg?=
 =?us-ascii?Q?iUpGhS9N0fcEeXT9UhbNpkDqceYpt//wsB6kIS2zrfZ6OcZfFkTreUFHoQ67?=
 =?us-ascii?Q?5nsNf08dGqrUrJtloKYt8lExHYbqaUR+RjfbPE7nZ7ZhDaBFPD1PLleWSvs5?=
 =?us-ascii?Q?h8W9TjoN3UqObyJtyYjhl0JBMNpYAZMwd/TiqyPPP3fbFI53ufG5qZ8t3CCe?=
 =?us-ascii?Q?RmiwtZkjfTi5jMm3qD2oeemrL6ICGjJFJjxoIAVm0sASLUmq8KQSICnJkn50?=
 =?us-ascii?Q?1IwtEum3YI5YVyNnWukwgm+6LkOrOJM2r/9fjF2F?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6234.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc48937-9d64-4a7c-d24d-08dd1e793e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 09:00:23.7765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WTQFGbyczljETWfgDPGupM0lmIqSfc/aaJVN050fFuMCcGI6rCjVSiHDObInngCHp+dTpyaaY4fgT6XyD1569zMnCKot0OseLBCTEBmD9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6371

Hi Andrew,

Thanks for the review.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, December 17, 2024 5:10 AM
> To: Tarun Alle - I68638 <Tarun.Alle@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next v2 2/2] net: phy: microchip_t1: Auto-negotia=
tion
> support for LAN887x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Mon, Dec 16, 2024 at 09:28:30PM +0530, Tarun Alle wrote:
> > Adds auto-negotiation support for lan887x T1 phy. After this commit,
> > by default auto-negotiation is on and default advertised speed is 1000M=
.
>=20
> So i asked about the implications of this. I would of expected something =
like:
>=20
> This will break any system which expects forced behaviour, without actual=
ly
> configuring forced behaviour both on the local system and where the link
> partner is expecting forced configuration, not autoneg.
>=20

We confirmed that there are no customers who are directly using the net-nex=
t.=20
Hence, we are setting this to default auto-neg which is also chip default. =
But if
any regressions on T1PHYs are dependent,  we will address this default sett=
ing.

> I think we also need some more details about the autoneg in the commit
> message. When used against a standards conforming 100M PHY, negotiation
> will fail by default, because this PHY is not conformant with 100M, or 1G
> autoneg.
>=20

I should have given the same errata details in the commit message. Will tak=
e care.

> I don't like you are going to cause regressions, especially when you have=
 decided
> regressions are worth it for a half broken autoneg.
>=20
> I actually think it should default to fixed, as it is today. Maybe with t=
he option to
> enable the broken autoneg. This is different to all PHYs we have today, b=
ut we try
> hard to avoid regressions.
>=20
> What are the plans for this PHY? Will there be a new revision soon which =
fixes
> the broken autoneg? Maybe you should forget about autoneg for this revisi=
on
> of this PHY, it is too broken, and wait for the next revision which actua=
lly
> conforms to the standard?
>=20

I understand your point and I agree with you. We can drop this patch for th=
is chip=20
revision as we have plans for new revision.

>         Andrew

Thanks,
Tarun Alle.

