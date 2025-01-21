Return-Path: <netdev+bounces-159888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814AEA17539
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 01:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133F9188A4BC
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 00:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EB3847B;
	Tue, 21 Jan 2025 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="K+4+EplW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2882EC2C9;
	Tue, 21 Jan 2025 00:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737419305; cv=fail; b=pNLceutrv7WHnA1diUB/irMzniZR5vcUoV/nKqIrZr8ZcIRIESaloC/Rp05Alhu6AB5l8aPYN+CGCzcrns64Ikk70+gamiaA/98BXhj2DMxiqfhmL6Alot2hDU97C1EoagxOVzKVEqLdTWkyOfbDrtQfizeMW9Di2AAKqMt1jD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737419305; c=relaxed/simple;
	bh=7bzs+5+u156MO6eVM5srSQ0Hiazv2LSxnhM0UkvGhRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BzOZoDe+c7k9K7oCrQpHeSNQlU1FfII1Y8+h+guUUEbg9sM6R/L2UtzSSiRyaRUFBuA5z+YfkgmgtMjhWcRVycCTRXGYFy7kHnIY97ES4+Kyo8hG8j39VYxWGotzr+tUTdVaqpMo/azsr/wXjBVe3G6Fwe2Cv7HNKf9Nsm8xnQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=K+4+EplW; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOgI1iHY7gdjQRoSJe+sZD9694xdGnE7zkKErBnVW8YnUbvFOg2LEdoFj39HegMJphgHMcuOuHCCbsbJRMJldiEug1HZ1TmZ6NXxG0u3gr4ZIjOzK5B28Rldh8hRupCFlU7Rdk5DbaViov/LuPn1nbHvoaA9OxbacUQ8H7ko5ilMfkLiowV1mgArmQ4qfrBrboNtQIY6cl4ksJMzBHlaZO0cnLM9ZOzTqBvuebQeaM8jFt8/a87ZuYJLeAzfr6F+Tn2Lpol2Ip9VZABqxQRJRTbClMSchTGaJsX3D6yi3qC0I30cAjcQsQQjw3z5MW4qMvOU8LZvCeIf54wqDJPDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXivQK72grdCIsP+Oyb3k22v5crCxGDOxc6MPY7p2MQ=;
 b=MgO6utEaR1ZsRAyVg3v7tMRL+PDz8b+CESc21tujmla+Fiq8zU9ZtS52iPG4PZolxzoMT08gyalrZWqeUDEkbrTY2ZMERBuQu78Ba9adtSFocQWHzyL3wvcz5ehER2ZaZ1j+gneUkQfePlsc5UhypuR30ndDMIalpX8tJRNfalZkxSg8c4sr7FFKelQPn/JxunPvhrNS20g7vZ0KpWh/4WQykLR/kFCqoXPUiyXFl3f0T6fTu3fwuamLFl21Ajt7YBu3n1CZw/nSHRyRj831gI7Idm7f2V6R9GiA7hMQZkkqn2py3UTyIysDAnsmv8MEk3TWoMuqjBkOujH4WJqbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXivQK72grdCIsP+Oyb3k22v5crCxGDOxc6MPY7p2MQ=;
 b=K+4+EplWyFjKKMnlUIZs8Ci6uV1V0I4Hqz0AWtLx9lRPYYZBo/P/klw1ZzR3+XRvO66zrlQC7Oas1/PIx3XjD51hEdYp1lS55+yyc9wOYvwcXEGZX1sDQmhMZ46Nu7ySO45VJDbcJ2/9sFpHU8PHeetoXlS/xDqYlizMjk0t/J29/aeo/Wzp6jkwjXAisULaaEgcsjLeLVwh2YK7oIj6IJJYM3U7Dkhn9GIJvPoYU1lVWa5kHzJLnevrgrLYWhXW4r7kdQki35Sr0VLwfJEqCQT6P/UuXoytBH5/6rLUCySflVb/rU84PLziWpv8Flte8ilAtcIg2vHRUiG1fSYlYg==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 IA1PR11MB7774.namprd11.prod.outlook.com (2603:10b6:208:3f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 00:28:20 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 00:28:19 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <olteanv@gmail.com>, <maxime.chevallier@bootlin.com>,
	<Woojung.Huh@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index:
 AQHbZi6jUsb5OQZHf0qguVy2R8e1urMWcOoAgAEuMACAAohtsIAA1aiAgAC9nfCAAAjZAIAALAdwgAELSQCAA22VIA==
Date: Tue, 21 Jan 2025 00:28:19 +0000
Message-ID:
 <DM3PR11MB87365983C47EB7104CC4E9FDECE62@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250114024704.36972-1-Tristram.Ha@microchip.com>
 <20250114160908.les2vsq42ivtrvqe@skbuf> <20250115111042.2bf22b61@fedora.home>
 <DM3PR11MB87361CADB3A3A26772B11EEEEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <91b52099-20de-4b6e-8b05-661e598a3ef3@lunn.ch>
 <DM3PR11MB873695894DC7B99A15357CCBECE52@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250118012632.qf4jmwz2bry43qqe@skbuf>
 <DM3PR11MB873610BA4FE0832FCB3CA5BAECE52@DM3PR11MB8736.namprd11.prod.outlook.com>
 <8ad501e1-a56c-48d5-bafb-125bc1099b7b@lunn.ch>
In-Reply-To: <8ad501e1-a56c-48d5-bafb-125bc1099b7b@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|IA1PR11MB7774:EE_
x-ms-office365-filtering-correlation-id: 74adb2ac-0711-473d-5100-08dd39b281ab
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZixgJ6murz/K43BjQeUoMJan/20BCX4cQb0s/5a0/CQnYygAnXNBJMOLmkRf?=
 =?us-ascii?Q?mnvIbRwlM6XimasCkQjLaYZqJ8MAPB3pls5rlHOF4yM4lk12HH8iUux1jncu?=
 =?us-ascii?Q?Yo/WHlHg824eZdWRZM2dSlXfuV6kwJ2S1ERzz8/ef1VqUBX9/TrigYl3nlpp?=
 =?us-ascii?Q?YwFN5izPbdv53waCp9LusoATfhiqZWiJoGhDuagn/ZEC3VXS73FjKrOD8DV6?=
 =?us-ascii?Q?pi0Ik4A+uIPyCgDFsUbvG3T/X13uxGpoB9NhE7hdAL9w0jPHn3w52VKoxy54?=
 =?us-ascii?Q?XKQSsg/jJb94P3sCe7BsvZ7k8HCdcOR+TeLnnyV9hlVjCLMerzcBaxUzCJZ5?=
 =?us-ascii?Q?jw/B/Hj/umjO+t5Phroxvv4Nf4QXqLdhWW9p5WGOTxior0tSB3wAhaMLK2YW?=
 =?us-ascii?Q?MqQFJtbm43ZEwDcNGd8NUAZhErL5IGW2MHzxqtNz6BbepzC3ws1c3iiXKvjP?=
 =?us-ascii?Q?y4C8gq6NZlTPKTiOoklabwT4aj+pUntYYGkIWKC7EZIKoNgujn9k7wRnLWEK?=
 =?us-ascii?Q?CvfGIcGCsRZ4+P7DLFjRyGuPg5GHeIY/0iol4lgKaGbyLQUGw3WvwtYGQQbs?=
 =?us-ascii?Q?be3yGWcGBzDAbutJCFLpvwSjBy6ylI/+fbx9Pzh7S+kugbdpCzpND22sZyBP?=
 =?us-ascii?Q?tdX7NkgJpmtodjar1ycZkTOXCogle/X2rjJKwclAerhrV8mO7BXbbvYsF5/o?=
 =?us-ascii?Q?n51N9121t3YAyl+s6hBaLsZqtRwr9L33tCtoYm0LiLlSbFPtPxjZGoBw4OGy?=
 =?us-ascii?Q?+93tIJwlCNyEu0fpUxZMw4Ypc3CSNCZSZ7KCvFJx2aISq8M5CU+2/h6w1y+e?=
 =?us-ascii?Q?FHklo2J6Gjz+r/eaDehuljEgP5geCKmZ1E/l4VbqqvH5VSXQ/Iaf5/WYmFV1?=
 =?us-ascii?Q?LE/y4DXKz3/jW3B9UA0VNPGU4RChEVqB4mv7VLOFpWICVZXgjFQYdv+nozc1?=
 =?us-ascii?Q?s7vdkKijIIV2wYSNLObhTiDFvcSN/3TolSthoWOrrXlajMKtYF+V/0DqDQYl?=
 =?us-ascii?Q?h4PJ5HeQa3FvbZb9l938RheUvvyIqTjp/FoRofOnG0x8YiubdGbkgcv451Lv?=
 =?us-ascii?Q?N2dJ7pcuXrZKKkjx6y/d0zMp/9mtTTIH3c6AmPy/VwYcdxr/tkpp/JrViHJH?=
 =?us-ascii?Q?mBoDJM1Wv75MkZa2ENHddgMHLOTiOLeEYzk+c0l5jj+R6us7wf94kdda7CUS?=
 =?us-ascii?Q?21ULrCitGJctp1mghj2KOUT7YoN9E4zr1PGXfPFGkIoVqdTBGqmGbQ2bjTHn?=
 =?us-ascii?Q?i7xNEd4kpjqY0+ElQ6nZfUg3KcQUs/iF4j5mqLqWDajw+/jC8GclJlBmny15?=
 =?us-ascii?Q?KrEEvTxn/7xdvVrfWno7PzULmui0rNkS21jui1NqTTI0dGpaAYKwZnTQ18hq?=
 =?us-ascii?Q?T/QGgLWABspLGvjYamKdlg2v9wqrJxdPH5pdQUIgHeOmlvjiRei7Af0dPL6q?=
 =?us-ascii?Q?Y15stTX0etq1z2oBwye3Op2l0j4Qnwze?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X/iqwlMmzFjxcjkWBAUsVz8OeE/MLoCBsFqMFDlUuNIuW6GA3UOcKJzHzyAS?=
 =?us-ascii?Q?DO0X9j9XmmaFoQvLH+pFWXpFpVOCluliMG59bPfU75VJcNMeSm3Z3EBlYqA/?=
 =?us-ascii?Q?5bowelpLOpSmOmqQQXvEF01e9YkyC/FhKzwMp1Y/d0H/fR6A9Chwjcw1fI0P?=
 =?us-ascii?Q?S9hMHmi2i20jK/hpyO8cTx97INIzhuVgjS44JdFOJir9xU826yv+nK819ifO?=
 =?us-ascii?Q?MehDEN3UxjNl0sp0eQEQo9Q6odMaBNJDdq+4gfzJwwVrMro2CMusuns5MmLJ?=
 =?us-ascii?Q?2aHBGDrPh2nHJtIud8xG/d1IUYwTcbRQpKAdvJKQzSfh9bzRTjC/vayVvxWa?=
 =?us-ascii?Q?pBxvwufWn0cD4mAdy1qMVPX0NqbIJQaZZhyevg4ZSdL40a89LM45Po2TEBZm?=
 =?us-ascii?Q?QcVJgLvqnD1JKHoER1HgZLDX1A1yBdeKthjKctALSPlMlASgU3v3XsakYw6A?=
 =?us-ascii?Q?Y3QvFsprPhChR2Ge7v9uCqH6N9ib1WzHa/x5t5hz6T7j+Vowf7s1cwTyoz2I?=
 =?us-ascii?Q?O2lFYSU5NtJ8fZ+y0vC77+kKf2KrjjZYj7vsqC0hc7dUoEIDOnpSShSvU6Xv?=
 =?us-ascii?Q?P2pEvRzejJPn2JBeeZAuqdKZMxFUBWaHO0CieKviJCK6TCQoDoxMhVlMcXiD?=
 =?us-ascii?Q?6GVcXFEsZWbusKM8oakXXkqi1vdgmWs/I/Ofywl0oMeu/I8teS7FelV/G4h0?=
 =?us-ascii?Q?bgiPFz4cUxhr6/onzwHewAQqlZGM95+JbqBrYeyICB94YS3trK4pVSlhvwQn?=
 =?us-ascii?Q?UrpQQgaJ4FN5nklM4r/dpuI2Si+bZhyCcuwBTIFVxyegCp8uY8YE1Y+SIJuk?=
 =?us-ascii?Q?8uSsiLNw94Z4B7jdGtXR8kp4/8l+EVVi1wPmGcBVNcxDGP+t1AkXQoqK+/yt?=
 =?us-ascii?Q?so/0tASqQ/fBXfu1JFKkLwwqqOsZX2VtTnV3ZUBNMxgRn3IeC+VGsyk2YoLf?=
 =?us-ascii?Q?wdvDlc2s7C5E70xJiMc3JQE+rmg4lAcXgaoHHK0SPNLSmmcFfBbWid0rJ4YA?=
 =?us-ascii?Q?9pqMqIvEOkmKqcbS0RKwWO5029bpjqdqriYUYSR8ZCp8zhRrqFYZ4YWieA1o?=
 =?us-ascii?Q?PB7CNu81qx1MiOe+KZWY+JKBChZhov401SrLbKXAsS4IjXlSgo4/DVM/05GJ?=
 =?us-ascii?Q?LexyLgmndqA/WqpNn92Px6e2EnQdOrprXzaIKK0Ot0p/gJ1iFr9CIlINPtvo?=
 =?us-ascii?Q?u1XaYxaJPbmKRm1jVhOj++a5xoMgkjXM1jfHerIbn52eAFmKmklftwVHaQTP?=
 =?us-ascii?Q?T1gPK2dHyxbTFHVbtptbCpXU5MI1zS5FkvRf9YEEGIslIx0G4gwNlb8NGSwT?=
 =?us-ascii?Q?phmAtHCbr51x4YIPzKmX4qMvvNu5y2mqNDQt+5FjTa7mDKxCQ/5JKMEoUXNQ?=
 =?us-ascii?Q?Yzqscov00WdWefCBpFMS/MKtpvdoWXhwE3mdcDgp5q/7hcaz65hJUbDfU2Kb?=
 =?us-ascii?Q?O0Embe5pt36UtGy6c3wGxjrDuvuHXEh6qh2n4vIDeM+EPWv08yp0q3Be5QEM?=
 =?us-ascii?Q?QJ7oyXMOzb0G7+WEQt3hAjsmE+NjzOBMFdypPg17FpheAilDOUyobKvzlaxl?=
 =?us-ascii?Q?dGOLZyYMPbWRv8jEg6+gEU90SJHes3oIAhAmNnUh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74adb2ac-0711-473d-5100-08dd39b281ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 00:28:19.8460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbeyGVx4irAVvIMUOL1wYPM6/Pe1UZJqy+dwrK/ns0zR4OBxsOxUgFGx1t7vOsXgYcxL9U5nHX1mRqzZz7kFk92MpSVVu8jEQlKUNWn+CL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7774

> > 0x1f8001 needs to be written 0x18 in 1000BaseX mode, but the XPCS drive=
r
> > does not do anything, and bit 4 is not defined in the driver.
>=20
> Does the Synopsis data book describe this bit, for the version of the
> IP you have? Is it described in later version?

It is definitely defined in Synopsys SGMII IP document Microchip used.
It is named SGMII_LINK_STS where 1 means link up and 0 means link down.
It is used in combination with TX_CONFIG, bit 3.

It appears in latest SGMII IP document where 2.5G is supported.  To use
2.5G some other registers need to be changed to set the clock.  This
procedure does not seem to appear in XPCS driver for the Synopsys IP.  I
think a similar pma_config like NXP can be added, so I wonder if the 2.5G
support is complete.

The KSZ9477 SGMII module has a bug that the MII_BMCR register needs to be
updated with the correct speed when the link speed is changed in SGMII
mode.  The XPCS driver seems to skip that in the link_up API.

The device id for Sysnopsys is 0x7996ced0.  It does not have any revision
so it cannot be used for differentiation.

I can send a patch with RFC label for somebody to verify the code, but I
do not really know how to update the XPCS driver to not break other
DesignWare implementations if the new code is not compatible.


