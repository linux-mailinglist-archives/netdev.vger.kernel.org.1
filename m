Return-Path: <netdev+bounces-149690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548A59E6D6E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8F92811D8
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C5D1F9F7B;
	Fri,  6 Dec 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NB1HCdDb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A031DF99D;
	Fri,  6 Dec 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484630; cv=fail; b=BgMbAxjkA/LHEx/UmqNG7hciTGUgM5+VF4zlQmD+6TA90c1weuzt16I4loro1EJEU3PH/Xo0zQqcZH3ok5hLvRTBO8eatqiqO+XDLiKrtvmXBYa58/5/dDU9LY3KkiJE/uhFXAamh5RRF4Moj7R+ChnvLCKJfJb8xanzFKOIH94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484630; c=relaxed/simple;
	bh=iwL3JbdVUEEWEETxRq2rZ7yum0GZFyODIDxjaHvfYh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ctAqKpbiuEgu9npRhujQiyH+tFv0yg35Sl0VQJDOLyl5dvFcZFrXFjlANXo60UsvBaqCqflph703ONHShk74gFAxBR5qnrKL+wU4XjYtjurXIFPPBT2kB/JL1acPqoEr1RXc4lVU5MYJrTxhet0rC7zbviwnLAttMzT5xyAo0rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NB1HCdDb; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCngjTuy5a3xoQdmzAcpFfOqPQrixZbhY6dFi8tWJrDb4sW1dj142HEKqx/i0oAzhv9vBOgxPI63m9CucxrGyKn2f5Ya4Vw/nFzDlH/iUEm/5g1ZQOsIbB3o+z+ud9wWElyhIptG0rz0ewbbh6Z0MStquf5wMSzlJ5Pso9a/ruMVbakzfW8s3S4cb5LABRWlR5Cj72lK8vbeDwrmEQ2CO5cH4wH91XJ4VMsYFPudnPERltA6gWSRE/0Ce3ay+tAR0E2a9OLymP15IkwQl3OTbxQt8AVclqO1OcZVRDl79YFIl/3H4PcZgnx+3J9y0KjhyS80whYxyHC7MBkyvDQmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UPxRa7cUiNNzMeuWBLDukxs2HucC5sSEBITWbj6kDI=;
 b=QA7jbFRwj9UAGZR8xGRMPPwWqJwBikRJBiBU134RYo/17Fz1SLsk13YHTV3ml+pTQ7CrROCP3699UYnzUjzA+89cMKoiD/AiW1D/dHi1JBTwOnfY6kWuE+g/SkYkIgB1LBcPyzoP602wyXbLj7ct7XcvZZyw/91pVUtp2WoYT1uC196MwNzUxb5X78rlcIYKADzyXAZkR1/elUYR2TSonDAh4Xyo81soRB7y/gswIxFLOWvNNzUHGCku56nXBL9NX9RzY6Z8CTT5qLXT2YPn3N5Ay9dpRJft6RM/vC82JgLch6g/hHEoX0z+ej79qzQ3+UZsQd9LNAr6HVZBSKPunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UPxRa7cUiNNzMeuWBLDukxs2HucC5sSEBITWbj6kDI=;
 b=NB1HCdDbHMr+xXwVjqBGXcsSiSzJ346ytYMejZfDXfoxAZEyZLPb5tyrzN0LgiaBWk77LNS8pmCAXoU4VQKp91gWNGixVFDRw7wzAkkQLwT/pfDfBa/XGi59OVqgBTS4wwnsswbblYXu9OeZK7RyM47jFR2UVSg3It416RiZcJ7SAs/KKKhL0khSIPO66i5N96SFeRF+XW3tUP/OsNYChQqKXpjlFqqp5Q19RZNZKD5cBJOBiSeVf+bpP1qEI6ZCy0Azq9CKUiqdMMQU9dvq+aqLpkNLHtSttpbfNJ0Zo8/S6PgZFwG3oD2lDaZvYezHohUxxq2f8v2SPRi7dF1plQ==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 11:30:23 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%4]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 11:30:23 +0000
From: <Divya.Koppera@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<richardcochran@gmail.com>, <vadim.fedorenko@linux.dev>
Subject: RE: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
Thread-Topic: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
Thread-Index:
 AQHbRWDdzNo+Cnt01kOqIfdpKniGbLLVUBQAgADphTCAAAeQAIAA4dWwgACYKQCAAVytMA==
Date: Fri, 6 Dec 2024 11:30:23 +0000
Message-ID:
 <CO1PR11MB4771E6936F63727B53F187B2E2312@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241203085248.14575-1-divya.koppera@microchip.com>
 <20241203085248.14575-4-divya.koppera@microchip.com>
 <67b0c8ac-5079-478c-9495-d255f063a828@lunn.ch>
 <CO1PR11MB47710AF4F801CB2EF586D453E2372@CO1PR11MB4771.namprd11.prod.outlook.com>
 <ee883c7a-f8af-4de6-b7d3-90e883af7dec@lunn.ch>
 <CO1PR11MB4771EDCFF242B8D8E5A0A1E0E2302@CO1PR11MB4771.namprd11.prod.outlook.com>
 <05eecef6-f6be-4fcd-9896-df4e04bbde19@lunn.ch>
In-Reply-To: <05eecef6-f6be-4fcd-9896-df4e04bbde19@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|SJ2PR11MB7546:EE_
x-ms-office365-filtering-correlation-id: 5a0e8065-fc74-4e50-8410-08dd15e95fb8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3iqyZYZzNpbIge7iymZM8k6ZB8aj18xow8W4PozfiZVkksDodAPEaKSJjb+e?=
 =?us-ascii?Q?61MqSyCuMA+w/iaSDEsgxAKQyYn3N37zgrYPU8+XKlpl2tG0nERxWjKRux1y?=
 =?us-ascii?Q?NP2YXynQNdaiVeFIIO/njnT+F7lbmH0g/4qYqKepmGSiHWGSC6azbnoxgsDR?=
 =?us-ascii?Q?zVKaMU9cf6coJ8Y7o55+BL9TmoODF50ZcAUKZOU8uzIkD7s84m0xzgW+7IXb?=
 =?us-ascii?Q?WWKXNwpAG3eKBb1ak3XhW5Dgk4BlBMZAhY1haAObOVPd38oURaeBHcLm/hsu?=
 =?us-ascii?Q?gzRmaPf8zXPD/j49gOBcLVaGdZ7Lo7XDTaHHrtow8iK0TL39Rzu4gkYhabdz?=
 =?us-ascii?Q?QC+f+gE3FRGMXHHt4wXJbP15flpuS0t+aTcf+6neFLHL9XTQ3hCtd8d1N7PL?=
 =?us-ascii?Q?j1auaWRJwx84F2ni6GHnJ60TKP5WnbLo9RpcxjktQa78wJexJfyh5+i79XYC?=
 =?us-ascii?Q?WjaA29vZCPcMr/USjHzdPO0Jig/WEzskSlXSuWkoZElzCnS1+XK1b8oIzk5Y?=
 =?us-ascii?Q?044ppudiCIQt2hHLRea8ie+5L0XC87xdUO8DoeirHCux7p8M4jWcOQzWi9/q?=
 =?us-ascii?Q?dGDesmumbd9PM/heKz/C9j7pZDgK8/kZNsdMw6n4ENbXFMMMBnogZx7u+yQM?=
 =?us-ascii?Q?UngeVmMqoxrbmPlPIqfge16w6uHhM54lKC+BufjmRYfaKqaPjYKyKZelTLNT?=
 =?us-ascii?Q?M5fp5h2cehUoRXOlNLLcjDF6L66K4RBNrOV9h2etkU/BI5xg7XBQ/YwTx1lS?=
 =?us-ascii?Q?ppfbvIBnqxi5tYnpg9UNVUtnLcJgOtpAgb39aQGZeKSHwbX56X7mzSWixjEh?=
 =?us-ascii?Q?XLm27zLz63Yig5eCTvuLS7t1jx5Y+pWlqOOq2H0/vSRx+puc9FzyCIfCTXYW?=
 =?us-ascii?Q?dueYWuCdT2CL5rvZIE3nZl+EsgWs+HSCWNuifedx7+6OTh/648+IVAfz4WUN?=
 =?us-ascii?Q?QJTrjZi+hwsReoDPmQ9305/Qwi9Bvhq5Vt+lNDl9U4ijAdK+U9/5VBf9yPnU?=
 =?us-ascii?Q?husM130us9kJyp4Yp4cDKtvPGfU1qNvYzDiO5oMfZPSE3WcRGlPbF14xQNtJ?=
 =?us-ascii?Q?54NVUa3OQ9RXFZoOwixcHM01Hi1lCa+Xb3tqtPSjxusISXLCy5ZU8CR5p7Ds?=
 =?us-ascii?Q?D4IWWUxCnl4pNNwUWkWqhNVyW2I/jzw7oAmEFOeK7GuWfNECmtHDSPxxLjHr?=
 =?us-ascii?Q?pZ1W4oinkk1p6dFEw28H+vlkLpHQmryugCLYBa4A3OEmV93DTqhQHoJwnM6i?=
 =?us-ascii?Q?VMGLhXTLKZVPIkJE6WV/PsjDM4Ra6jmdwqJlzScu8w4UoTD/qtW5Pe4MGcvr?=
 =?us-ascii?Q?QX18RqllnU2rT8j/cq/gPbwQY73qNEy1d+0OShNprtgsD+TG58Apw1BZxrWy?=
 =?us-ascii?Q?YRU/767lVbh4vnlJbascVNnTy+860/rnuTh5mIc4hx3MlHJsXQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qqlQdI8n7eop6tWWmjgYEGSjClJZxsesUqpA6ZARfO46qQl3X/IMX4+T0iPt?=
 =?us-ascii?Q?5hvqsdoaqsFP6LswfbUwJDwjND8OEnxnH655oaht9uokLxGiiA9yW07hM/uJ?=
 =?us-ascii?Q?dbmQLfwvqdTeEpraRed2Yhk/CoaKynEgz98k9a0dlJMzZaPyf+cqrM50+IEh?=
 =?us-ascii?Q?ZhNKZhoZRwKMEvYHBzOB7cMhsimdizaMd7KEJcFRz9wfizVATuR/axU54Vz5?=
 =?us-ascii?Q?AHM9RDx/GLBfd7QGSA/BBfOx7ec/Q6zky0ulDBBh2SIXaSN2Y6NN3DxJhMdL?=
 =?us-ascii?Q?p79gRkOHl2vXjwDFAh7TkQWEutxbudu+j7jZxBCK0Ca1TRhfqTPkQlS5z/YQ?=
 =?us-ascii?Q?hnhOioCg3qL7QekvUPoFeBhI2xI3UyLRrUyJxYgNrItsrbg1jcute17cv5X6?=
 =?us-ascii?Q?yxJcLC+346iASsJ3QIl/DWpyVLQDVaRLDJr0rUS+VLWHzPBq6ezJW2wsNyks?=
 =?us-ascii?Q?DudTIdSB2IXff8CMssE6VEpy7xHWkr7pIrn3ZmcGm3Rig8iop94NLCUTwfow?=
 =?us-ascii?Q?gxCdeb2RuK1oV0Xi+KbNpYtej+bNDtXtjZ8tJe9P22qoG9VN5L/vayjRj4vL?=
 =?us-ascii?Q?P04yZXaMD3n7X8t5Bydmvy/tF/R5hjj5TmkyUHVtEdL87KBUuivDjphldeZp?=
 =?us-ascii?Q?0AWlin0pOyOqfaylPwo0HxLvqliZkeQAo8PI5fgim41MsHbqi1lIHkqfGi0f?=
 =?us-ascii?Q?Iqy+3NoueKE/wBFupWMPDWrT0Y5MjgMKiLJ9ZZty+GMoBIYAvsRD6Jyf5y3d?=
 =?us-ascii?Q?/35fhf/2sPgkWsWQgfjPZwjpBCRZRiDeKLsQyfViSV7rbdrXsnc5aELq9tlK?=
 =?us-ascii?Q?nVg7M+p6f6OC9ecogZsKfqY10uwf2OZ9+02K338yEmWz1vJeHMoThOa5jMw0?=
 =?us-ascii?Q?b4BqGCuj3qWxoxBnExhYMUPzTbkfgVbWO4psHo5DiG1ty6QIZ/cYMsrcU84V?=
 =?us-ascii?Q?R7jH/SjnphzDVsbap3P/SHx8nnDGRm7hNsesMgi2Ykj9oN06yBchr7bcMdIV?=
 =?us-ascii?Q?882cV35JDOqDXiQDRm+yYEaD+fKKt/4XwGDlftTGwB0iYqaxXrtxmxSgHq8I?=
 =?us-ascii?Q?mO3+sJi2IAHV5Y9TjQ72l3DmBvhJv8hMCVaWvnN3I5YHMjehu46MRY2sUGcC?=
 =?us-ascii?Q?zRm6V8533I7uM9O5li/xE+PbD6YeLftN6lZEAxRtl6/I7cu/LTTZOpf3G1pJ?=
 =?us-ascii?Q?2U9910nKR1p/oriFNjAWaGYwiyKqC738Y71JVx6fpBVku2bQhVMqKG3H9jOM?=
 =?us-ascii?Q?uDhTMLWsFmrNoFGOujLhA2WFu2NbkA4Ry81d237VGY1CzVvgXrLPLPRCSfAR?=
 =?us-ascii?Q?H1DrMa7VIwUrnDCZHrpU7SvPtsmoothi3onftcoNnb3+q2Tl4pUHRW4Wqqxb?=
 =?us-ascii?Q?9nAaaN8zoBzUXslgqd5cTbkcVsl+16FYKrLaxrHLfjagnQ92qoDpRuowwKR6?=
 =?us-ascii?Q?6izxObGEmp2W92QHRTJyXudLpBQGADU/A/j7fMe0WhzyKoc2fvDWbbr/r4TK?=
 =?us-ascii?Q?KbODY9bz9kFGqh6ezDUOa0hj3z07qPDe+XqPE1ynpa8Iqa8hodjgPODgQ9sy?=
 =?us-ascii?Q?XtqoeGI2qLummWjVzltrlvZyrWVtJmq8L/zfQzaO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0e8065-fc74-4e50-8410-08dd15e95fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 11:30:23.3809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZH4G0QDaVOvl5qhE0b7zJoqXBuzU3F7TkfcPsqgnGD+r1KRmWf4zRkbXdsAGwrNZiNIdt8UvGVihdLT3dD8wAYjHH1r3a4SiLMx9YT5YFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7546

Hi Andrew,

Thanks for your comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, December 5, 2024 8:06 PM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; richardcochran@gmail.com;
> vadim.fedorenko@linux.dev
> Subject: Re: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library s=
upport
> and 1588 optional flag in Microchip phys
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > > And has Microchip finial decided not to keep reinventing the wheel,
> > > and there will never be a new PHY implementation? I ask, because
> > > what would its KCONFIG symbol be?
> > >
> >
>=20
> > For all future Microchip PHYs PTP IP will be same, hence the
> > implementation and kconfig symbol is under MICROCHIP_PHYPTP to keep it
> > more generic.
>=20
> So you would be happy for me to NACK all new PHY PTP implementations?
>=20
> Are you management happy with this statement?
>=20
> Even if they are, i still think you need a less generic KCONFIG symbol, i=
 doubt
> somebody somewhere in Microchip can resist making yet another PTP
> implementation.
>=20

I understand your point.

I will change the Kconfig symbol to "MICROCHIP_PHY_RDS_PTP". RDS is interna=
l code name to identify the PHY PTP IP.=20

I will also change the file names, macros, and functions to reflect the int=
ernal code name as per macro.

>         Andrew

Thanks,
Divya

