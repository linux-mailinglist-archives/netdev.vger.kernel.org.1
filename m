Return-Path: <netdev+bounces-155397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B55A022BD
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD19161044
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FDA1D9591;
	Mon,  6 Jan 2025 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="czCNw0YF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D8B676;
	Mon,  6 Jan 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736158446; cv=fail; b=oJVCwGAl2BybZ3avSq8vDbJUCsPPrkz12hhKhDRDe13hzFbWTJ7UOwrRuYmcvMtoc2VgrAqcVr22xTbA1q9QFIqeGneOqgnXUo1Eyy814g1YLPEUbl4SQxHcMZpk6CSO20Io32QYy4V1QJnvBOzBq/oiK5VDc8UsrChGVkNuS7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736158446; c=relaxed/simple;
	bh=USo/hakTXz+mha+mIcz5wi8q5by2BcqyPEDtAySchBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lsEiVoX6raV+1SiaFzJErj/NPECVSi3XMZStMFqVmqjnwGb+t8wpusCJ/zYzGkDsibfKD7vC03Wtl8BmNZS+2p/UDk6KgC4tHzdf9jDL/zA2Rh4PjXflLiiCBrVzGA5bB9Fpkdq8fckQOjt3BzyldwLq42EcUrcWooW6rR8mUaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=czCNw0YF; arc=fail smtp.client-ip=40.107.96.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGwkLX7Oi2OkdBSW5XFf182yojkfFv3mdR9B99FlarBLUCUdpUGKM4DikE0Axk6OUMaS1EmRhne9+sCT415ilZ8rRgjSrMwzrPoylzVakns/V2XgQ0Qknw7eJTbjTdS0NiwJ/24cg+lg93JW66q/rXOtmeqTOLEghICBDkWMjYBB81r5q0J0PzZ9w3oYTbFAnijcbZQv8VQViF2EvHWBulM+W+YfcRvA1fmnFDcrNBjuCNnh40IZPzzB/Y6Mymjf4wjwiXNQf4OL/9DZsyjZsHZcu9Rfxh+9wKVolAMRx6E3r63L0WzTQBYd24xukC8qvB0B1Sfjs/1qLJZjpWLAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqS126dQ6dovlyTfH8qyZz3WvHZx1RPU4nPJcQlyl8Q=;
 b=uehXaKSI12uhqiavMnfp1lweaM5b9W1ja1gNMhJZ/navJ1T5HBYvDk5Crk74iFCO/IiwDwSmMVEQ7uoI+IqBFawqpdzwCApNobKtR6nWEEV2OUI/rMsNzazvr5TihxKr5QhU49UrUnu0yzF/2wUIf3Hwdpd859HELoDt1ru/YYwGTRp/jlufZPBSdb7ILSP6OAwSEHCZp5LZz/iFiovDgPVLwF8PebZQdlqtuMvvu8LhchUVD3c7ucJN3O/f8MiPRdox44O/s1fQzToc+fuMLtb6hA6+JbTRNjPtOe8D0616PlqCnWom4Dg9FwIrwPaZreYuuICUPSm4wI+eowBwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqS126dQ6dovlyTfH8qyZz3WvHZx1RPU4nPJcQlyl8Q=;
 b=czCNw0YFyv5Z6fa3Jak8DeYK0lqr1RwM9mDZsg6CD/eUizhKeHXKoIP9fBxfE2m1ReiM3l/QksG2N6H/sE7QoRAOHW0621QjqcqtbAVCLze3dgvjPnwaU+BQk+5Mzab33HtHvki6XT86218OshJGx/so4nQx6J++aw399j1SFrInzEDEbueGvxnOQbuSWp35L/fexwKEpbOcj/q9CPMgyVLuCq431vjZQYfwf7EBnRZ0Apgeu9Af07Q/zWQRR9aWdfpNJB3ZqXCO7HnP/2SrIwmHlqIXw8npNxqR3gzqYp9A7BwWIeooxl/nefgAFJ2Sxh/6L+shR3zzcEHuw/VjbQ==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by CYXPR11MB8709.namprd11.prod.outlook.com (2603:10b6:930:dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 10:13:56 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%4]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 10:13:55 +0000
From: <Divya.Koppera@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<richardcochran@gmail.com>, <vadim.fedorenko@linux.dev>
Subject: RE: [PATCH net-next 2/3] net: phy: microchip_t1: Enable GPIO pins
 specific to lan887x phy for PEROUT signals
Thread-Topic: [PATCH net-next 2/3] net: phy: microchip_t1: Enable GPIO pins
 specific to lan887x phy for PEROUT signals
Thread-Index: AQHbXb8C2bYMbu7M1EiwiFBR/Kym97MFFZ4AgAR1fwA=
Date: Mon, 6 Jan 2025 10:13:55 +0000
Message-ID:
 <CO1PR11MB47712D530FA8F49E68340533E2102@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20250103090731.1355-1-divya.koppera@microchip.com>
 <20250103090731.1355-3-divya.koppera@microchip.com>
 <0c121fff-a990-46e5-b250-8948b717f816@lunn.ch>
In-Reply-To: <0c121fff-a990-46e5-b250-8948b717f816@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|CYXPR11MB8709:EE_
x-ms-office365-filtering-correlation-id: 5568392e-2e43-4dae-819a-08dd2e3ad412
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7055299003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7055299003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5g0zHjBsjU6Mt+u0iSxqzFuTaRjr/MurGny4PH9I1idgrKX1QBgYcVaYMJTM?=
 =?us-ascii?Q?ALbPvZzHH40QxGfjBBjvF5PZu1hoYJckbW6Eq0uNzkbAClOQNVlQx+qISC37?=
 =?us-ascii?Q?LHheJGlmq3io+69Ss0NHAulbTgdpzNE5gY+PXL15thyMIgO6f3OtUP0VhE5X?=
 =?us-ascii?Q?lg6r2V0YBy5NIUFYdzVbXm5MlswI6gUeasL7xRFgsFLUCulUg071nKyJHvCg?=
 =?us-ascii?Q?WFWqvRoorAlvcDI0DzVvjnUXlh6YsLiHdUjRCQtE9DMkUQ9WALPlG3dcl9CB?=
 =?us-ascii?Q?yUZT1qJ0Qh0IzAGTHOFiryxaVUpTW58yM30TC14RbkWEOTbW1f9MYqfSjqOC?=
 =?us-ascii?Q?g4lHpyc9LTYYBioY+L4apALbjtYx64fX0teh4r3uSJRdNpWkzQR8gvRKyPxV?=
 =?us-ascii?Q?OqFDMQsKJKpMe4UVW3GK2Joghf0eMIPS/GRQAQQ98aLYCmfZ2xvxENxLjfVn?=
 =?us-ascii?Q?02F2AQ1WII+MWIOZJu3rpg5C31XrADUtpuFUjUs7xAz/LBIZ56wDXSPOB/9H?=
 =?us-ascii?Q?gV52PiDA5y1rGmhJJcIQABjGwfW8pHkfb/cgaPR5OW0eMiBVx9gxUzrIXQ+b?=
 =?us-ascii?Q?Zygy9ntK3FWwKfd38c7/qht2uYxP8mi4eAXWVigX1UzIUNBrFZgdoHPcZ3O7?=
 =?us-ascii?Q?2fOxFQJXD3JDXmZa2S4i5CUv8YFAtgbyuHOgpDiLdMAb4NZVDV6HXmIVx7xR?=
 =?us-ascii?Q?YLhYQi8oFIhnBQgLWld4TO7UG+qqVu4VCLAU8RGZOtdm6cO44KkUoHeTLT00?=
 =?us-ascii?Q?/Rm8BsLtMuslz4H6Nm2T5i2CwsmDlz7+QaFk0ILCSrWIA37WpzzkmfRfh9rc?=
 =?us-ascii?Q?Gz7H1NqhHcIe2aO6XJJoIrJRkKyvNa2IxXkdw6aUtVAgV75k9kkMo4FMotbm?=
 =?us-ascii?Q?yIc7l5EDOJsXUhNKhjhOgnOIwwDjCgKrTPF035PbF/NoC3noobQnUbwy8mjW?=
 =?us-ascii?Q?RGnpZJZnQ97CrBtq8V78kFUegx4Nz8InbJlh53zFDXAJZVxE/iu6g4UkmGMy?=
 =?us-ascii?Q?0xQw6ZQJQsp5XRdBFAxkSQfn27bnrOJoKq9RSkksvQspfBNR+mrUBJ/jcuz4?=
 =?us-ascii?Q?wFla9d3IcVlDSOYkJ/B7s/VCi1Ro0+cAPDmKu3h1QhjvaaERZ4xtZ742On/L?=
 =?us-ascii?Q?I8q1u1H8qU8QlFGQA8ZG69bu5x6LWqZkHiNiy6wS1ImwJ4xPO5Sjj5G9Ng+O?=
 =?us-ascii?Q?zqAn75s+KHmY44/rI+eq7A3XxrFiTkW9epaZewqF0olxHmziC4tmdflEn1uI?=
 =?us-ascii?Q?SUzXxLFKfvH35Sio3DS5OWHASfj1YDoLaDvlU3A64gm895TUd+MTdttXHM3w?=
 =?us-ascii?Q?0URVCtKujRRKsP55RIn7tyuFHRVedirLnBGaykly6CIRezINQ2bH+kd3v0A9?=
 =?us-ascii?Q?Nc1F6yd3tH4VUF/WCytu2m7E7GBnw9G00vQLlVKYgv56eVX6SokkR4ZtEhbZ?=
 =?us-ascii?Q?Qu6VWmdsOjnRj09kZUh9KCsFgfMZTTK455p/vV5+FtMWAQlpe7UwMg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?//o5XkYMUb3vruWfAV59fwBmcgM2A86nAfX8tay/DlPP7FPmHPEElMEhwWjZ?=
 =?us-ascii?Q?mzVzIk5pJqOEJ8Yn/Q/cEMjoz0HUbqlXTOxzS0nkh/pa34TwR7RFkzL02Lm7?=
 =?us-ascii?Q?uX8ntX/SZ9kReUc8F4osKpKb+NLOZvQSUv4BTuRmcdRWE1p7iEaxB53qFCU1?=
 =?us-ascii?Q?iXhUmyhj0KBCz9meXMUJCZgV/dFsDKLL95pxI3L3e1PKX10kcPNtbI6qdthz?=
 =?us-ascii?Q?K/tZege81zn+kY1IIZBy2ZAF3pY+owtP68Ctfl+SHG5ZndCv/FiFpsrE1nbp?=
 =?us-ascii?Q?teKZfMXXSb0lQ3Qh0n3nrp5nRe09isrjldzTxyP6lIMTwSElUI+tFSnx3Ic7?=
 =?us-ascii?Q?9W2GdM4L5Cnc7JeP216xa5VwKuKgSNoa18gi2qNdc6eFIHZmDgxydSXTxEXr?=
 =?us-ascii?Q?JTVi9kh1rQBGYfazR5Nhpifz/XZEqiSC1PisL3tyUf2UjT5cARMDJovwuJrY?=
 =?us-ascii?Q?V3c476DQ79nifNOpNL0LPMn1L3RxMveNdlkLCSYfi3T2/zSikmoJz2lGvVA2?=
 =?us-ascii?Q?K2u1m+SsGjDz3vtOyVZkqfT/e1FEQMyFNtt99eKBfPNzugm2W7vQj4WrJD/n?=
 =?us-ascii?Q?h59mPXNfm5ldETvLsGsnOjcaKs1tBqrv7+MTuinpHLNnhRuDiTIsSsh4ssen?=
 =?us-ascii?Q?0zasE5ldJxCDBSoLXoC7aXrxmqXsv56JyOTm72lq1uBLuBemJexl5qj6hvKy?=
 =?us-ascii?Q?IMrTfTvrjo5TLM9QuttuEKeDrQ5vlRvf8pj9unW6RumJTecXCXXosUD03W+v?=
 =?us-ascii?Q?MlPs2a9xwebibQkUDm4vegOBUtxrQXgouB6OeZdhyo5blUS7cZgZS5fqQe2h?=
 =?us-ascii?Q?fgs3cigbMNpRyGbV96/GpV9VFbHNg1qXZHmm3b2F3F5Zl7G7jsyTfFnmAR97?=
 =?us-ascii?Q?22Z/9scvCPZdJa6DpwVW48MF5gjvOghzjHVjDcuGWacQy6y2PO3szAKY0LEN?=
 =?us-ascii?Q?bZymySSlUnfP8o7X+fNO/V+Le1wo7Yz8RfU/ShyCC2sbSUNAn1HDp+jRSp+l?=
 =?us-ascii?Q?w/Ckh217X6q/BINdyRpm95qzH9Mg/acNrRUXUK9kp8SOYBzR+V/eNmxrXDnu?=
 =?us-ascii?Q?3oX3DfaZ+uvgDf87hmzn8i6SPifs1YRHj8zJWg98Mh38ZZiva7+g6oIqzLks?=
 =?us-ascii?Q?W3SbeKQG8NkEHoRU53jWHqgP7bHWDbvL0WAv9exXuteWKKPRnfWWjWkiK8bS?=
 =?us-ascii?Q?0GMOJgEkHLo5HygnEvXrnuqrerqJEgKkPoJGF05R8Vxj/K5BX5lKOs4pFl4K?=
 =?us-ascii?Q?Q9tH/wSK6I8OA92GtdmXQU1Un2iorAq0YWD29sE7KE+FRUfdqfb9B0OhWahc?=
 =?us-ascii?Q?F04pn4ulQbnTYDvLROaVJWPWbQc6hQagyXJQegXXSWL1IJo4gRLripwyUZmX?=
 =?us-ascii?Q?AnIj0KSsKgDmRtH+jupU5XgSbvIzGMWMC3mWP2+e9/yxz1ovN9LaZNQxlbEq?=
 =?us-ascii?Q?itsoSV8wnPMi0/TCdMXC5iQFGvc8t8c2KZyPivGXW1/yaR4WqtSd1OfNvpuD?=
 =?us-ascii?Q?I2H2CXVnxBbq55ETAw99YyOkSJHURFZi86Cd+wrCqOxpmwe8szaOqfODGEIo?=
 =?us-ascii?Q?gLlvg7JUt1jP0XvYVDT6Di/6Y3eKJihJb3B5QGOlZ0RHpwlVWyMtCpACRS2Z?=
 =?us-ascii?Q?rA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5568392e-2e43-4dae-819a-08dd2e3ad412
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 10:13:55.6977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 991lcFX4pQIXrc8gRy2HOe/Uta6I/LCMGrArbLvAKiagz6hicKoJd73UVDf+e+Z5yHoQV1GhFyn2fy98n4E7fNyfXH8iQ1Z0uDUBb7ZsXGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8709

Hi Andrew,

Thanks for the review.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Friday, January 3, 2025 7:36 PM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; richardcochran@gmail.com;
> vadim.fedorenko@linux.dev
> Subject: Re: [PATCH net-next 2/3] net: phy: microchip_t1: Enable GPIO pin=
s
> specific to lan887x phy for PEROUT signals
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Fri, Jan 03, 2025 at 02:37:30PM +0530, Divya Koppera wrote:
> > Adds support for enabling GPIO pins that are required to generate
> > periodic output signals on lan887x phy.
>=20
> Do the GPIO have other functions? Can they be used as additional LEDs?
>=20
> I'm just thinking about resource allocation...
>=20

We are supporting 2 events(PPS, REF_CLK) out of it PPS is default.
REF_CLK is a GPIO pin which has led2 as alternate function.
But lan887x uses led3 as default led.

Yes, we need to have check if the gpio been already used as led for event 2=
.
We will take care in next revision.

>         Andrew

Thanks,
Divya

