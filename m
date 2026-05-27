Return-Path: <netdev+bounces-292083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH6RM55jFmpamAcAu9opvQ
	(envelope-from <netdev+bounces-292083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:23:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E5F5DED9B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B57153016C84
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4659E36728C;
	Wed, 27 May 2026 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bcdrGBjk"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14053C1F;
	Wed, 27 May 2026 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779852188; cv=fail; b=IHmC4VrBF9L7Y7RsdO5SPeekpwf//e6wwywQLsOnYa4HxV0pEn8ydwJDWXDtjl1hBQFOCKWRDj3GZOzqnWDXAh4HaDay0Vuu6vJiv3hXhCblrr3gXdUSz/mTSNK52pdhZTodtZFPHdQjp4QhBe/Z7yI9D80D9RspB12Ur6EZfII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779852188; c=relaxed/simple;
	bh=lLSNdzMnyesReRNkTa59THhbQ6A+AJQ8w1DPttSOWHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CY85gmU8XHtt+gr2IJ9kJZYauLFt7QRqomfLTLX/TutDCoEcSy4a7ReGTt1Y3JqLcjebWl1thyeBam5SSWqe+TNXJUU3qgfG6+yVpiMXfFRKr9gJoGaAAjU6HtbfLG/VdoCqCESSe/joE48cMrubX+ygA5SPNZRzEsIGzatzgt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bcdrGBjk; arc=fail smtp.client-ip=52.101.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrv0BzmknP+xQNLYk80dS5/MWbjlWre4YpOIaUZMHVCzotK53iwKJbdbg0nnPtWj/6Xh47ipWMKb2RKipHGyKG59lsxjZTBNq9Jbh/hRwlrVPUsQCf7IRuQUpviyVh/V9MdHh+IdD+nXdsAytVUaXPBnPn7RFSjQMbno7OR0Aky16bhUmc1+axTxL8hlaUofpy8rlmqnG8BH9VbNHboY6pdNZSSv/yy0noSbcI4V7NCbHrw2IWqKHdvydFMUfx78cI2cUhfboHjw5GZCoeiOSncePGwsRVPdnhpFlO04W+HQu3RlVJ7hqhXzuLm/7uEN8xnihFD+vXM9UC/l/VG/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPMxfuCal826F4bipTLtS4Rthh2g4dwbaYcBoVdOUOU=;
 b=DYKH6AAONoR94DU2VqfbjBNIUngLnLCYv9CE4P0Ajbdwb+2f/PBDghft8Rnn31p8jwokEH7x9YRSKpVOnLcIzJAYAhuzNoerJNgc89x1nDODkF7M+mWmF3CTmqMEoV5Dy0q7VQMLsPBVUzBuImI+zQdYSEw+m6y7UjQhDhJ1WPwFSL2YkFV8JKe8VZNGoGTo5c98vDRPxsruSSUQyTlYE4OB027/9u1fnAmkoeFc0Fj8N3+av2Wryo3pAn0i4QfQt6ACQtAbKch+eezSn166QBy8COKhmTrC8ye34n3CaTtYWrBF3YgOa7o4dZQ0HA+zP5TpfV984MsR3iDTRiNAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPMxfuCal826F4bipTLtS4Rthh2g4dwbaYcBoVdOUOU=;
 b=bcdrGBjkhdptrd4N3qoAxFC8ULpjb7gt1KAu7dyehARqeORorae07i2qfDS7pEVcc72XJVHfcVtPYwfHtZ9eVIX09LXeOnIPwk2rHAeOz8njqjKdryMhSKbaeVVqBZT+AyqFm9fdTR+IDtUoKILVD3tQj5CTDq6ZFQ7ADSR/g80xAw+2iHM/cSqcPCCwNPvvjBKAuwxop/74fkK2nvGvt5m3dfpqi5acbOFOQC1P8kN3BthHdnkHsvtGUsCmPsCctd6IzeTaJN18POpNhuGWO7iO514HyAV6G6kJav6QFr832Sp3Er9LzKcqZ7HrqDdGRa7YiZkEEnQu29IGFv7AeQ==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 03:23:04 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 03:23:04 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/2] net: lan743x: add support for RMII
 interface
Thread-Topic: [PATCH net-next v2 2/2] net: lan743x: add support for RMII
 interface
Thread-Index: AQHc7SYY7K7nzphLWk+Z4GbXNT9dzrYghQ2AgACwd2A=
Date: Wed, 27 May 2026 03:23:04 +0000
Message-ID:
 <DSWPR11MB9715BCD8A66000325EB6EBA3EC082@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260526154054.19829-1-thangaraj.s@microchip.com>
 <20260526154054.19829-3-thangaraj.s@microchip.com>
 <48510d22-bc14-427a-b12e-17655ca95ad5@lunn.ch>
In-Reply-To: <48510d22-bc14-427a-b12e-17655ca95ad5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|PH7PR11MB6836:EE_
x-ms-office365-filtering-correlation-id: 2207c506-5b93-4816-922a-08debb9f43a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 42qkWYIw0oRkdaM2/lWYyidPN+GmGLl0rF8cBzVwjgwVlHFkYf92kFc4RuD+8OVwKWhFXGUCW1Sw7GRe3dMRtDZl2gcd3hgXFdwgLXZt+ShDUIWeDxdijxOMRg5uaH+bgEQZlfuiEHCT+gsHVTNMn+gaz/IUqD294bBHhruwpGe5sjq2f5wi8MY7iQsm/zNdD37JgWDKd36lM9blcvga9ZX6QTBOtTL695uEtq+SlR3AUdy6oLX5VwziFyhNKUDhvaa2zSDUsxfJqIvhhlSlx0K8HxC5VxtwMj6FqH7MHM5ktRhodDhg1/LS4UM6V35lt04EDOPJckM9CqFxHK3SnpryVht7W3K1k4X8wRLj66aW9BpaemU0zbv0x4PxU1VBg6i48DDcTY34MY4H22T90R9SF9f/FaZigxcur92YEqDgDXtYQs0uvRtFADFghbgaKMbBEuoNd1s66LaQloqPurXUMFLv1G8lln9x364PXxQ+b10TnYeBR3qBVcegbGWYS75l+86t6mEIt637ghXOJYYGgiPIiTx3C0oM5c5Io0ntNvi85EDrFy/8IvIUir7Zy+Vabg9CjTUj4nVwSttAr3tNuylNrA53ZT7gkvotOdvQFusTt6Pmz1tovLoZwKZz68jMLEm3l+vfLJoU1vqf8+IpRptZl2KAGjDVVE4oLYzCVCAGE4p6vnZEkeQvJYkg5lhieB62nOzDoQwm4qPWgeV1o064xZpsRreLpCiwIMUIoyV44PBpLR9KT7PL3e9g
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rlTuBfzC9qB0+GgHHJmN2y+xYLcebdsv+5Qe9mquCk5nmQy7OqYKMJmFMAgB?=
 =?us-ascii?Q?JeMRycct7YbvYxkLs3wZWV86LW5VjtWF3SWaZaiTIfjUzcbNorz5at/ZLydp?=
 =?us-ascii?Q?dspSY9Dg4bpQI2LIbw5Ctb6asTno90ASNjI/4W7A5dAIyB8axVETvUEBsyme?=
 =?us-ascii?Q?/1486rlG5vK+EvWetSCb4RmspyXjkZ+0XrE6go5X46TfcxfnwHImSoGCH9n5?=
 =?us-ascii?Q?s45eADfQ2OtqXrxEFsTDmNnOjAizdJEHtOPMMVNeysvAA3VS3y9m4nMGlLtX?=
 =?us-ascii?Q?m5URicAL6mchCUKWyCR6yBqcWfrlnvpfVuNKOExraz1rtdu9aq3YDilMb/AF?=
 =?us-ascii?Q?cV/Q7eoMK6J+gK9uoZu2Zg+8ph+nMBp63uyP/2oD4e7SIXMeNuqk7119HpIp?=
 =?us-ascii?Q?eSt0pU06UR9tedcCUm5MQPnF7NPcYwSf+RZSl0lquWsFgNUHDB/f2e+O3Pb9?=
 =?us-ascii?Q?lsHlvsVCi8JHeOKhFL3WUTkLp16SNUg9lKCInKsQ1P6SSfFNQ2zme6Qsxqjw?=
 =?us-ascii?Q?UfitxXo1OKnVSVob7LeqqPlarxMBHBDViHJtJz6rF9S8vQBeVxjf8moPLkvc?=
 =?us-ascii?Q?mO3KGZSa0AtyZ8oDf+uWHgW7CfPhwxgoEa5MifBzb4etM1st6R+VVhgGqL8i?=
 =?us-ascii?Q?DY0+nhiCTlu6YJr9wUlfBegB+/fTYA+/Q9kxejxefyBI4Ske5JCt5kwc7XZf?=
 =?us-ascii?Q?goD2opX8uvAE4s0J9HY1tMCuL/rtSsslijfcL7tBFxpkWg4g4LJ5qepb5yfq?=
 =?us-ascii?Q?6cqvwioq5kpVbHvqcKt68UmcEyvDJGnGy6J6Q4eKXd3GSj2569EtcDzhFy3q?=
 =?us-ascii?Q?3M5gmrgURInNi12r9KRfNsQZka+pA7J+4mD+UvlHdr2z81scCm4ch0o0X27+?=
 =?us-ascii?Q?dKsS7LtYiC2PDKyFQIfQP0XFtuChsJbMljQtBO7QHHCCgE//J1Oywd8+TZym?=
 =?us-ascii?Q?VV02CuvrIqrlNA56p/UUNk8kj/M+TnW65qwJjZSPHYloIwkDef4rtASYQdy1?=
 =?us-ascii?Q?CnXv+YPe+zqSvn2pejWJ/nYsUqauE0H2npDBHUmaih5DGZZq+teyxrbl/iPD?=
 =?us-ascii?Q?ncOOJpQgrMvH/zpdty7RWqqezPhEMwXLBuG5uiN2JCFrMvAAa9CsI5vjfhJr?=
 =?us-ascii?Q?MUDZhr7+BozxiWZdSIIvbxosXNCvES/bY09KssJrfa0XeV434kKsB/Hjux35?=
 =?us-ascii?Q?EEfhBoNhay87i6c8pY4Bj4IvwOgiHFPuVt9fHCGwyre3sCO5TKwHL4jOjzcS?=
 =?us-ascii?Q?3c7+mVYe7Afmyaz34meIu8Ls6ebxWZaWYZK5gPdOaZJ+BY1YMT5TiwNvQ95c?=
 =?us-ascii?Q?6bYnqsQuh2we7DWZvQYEce/iE0GTyXUrURfZ1eKlOSJUVjp4B2/rPqN2aIYw?=
 =?us-ascii?Q?z7KkOJ+ZV2J9taUcYx3Lq6zIcF7GB0Usrl+LqWiaxxCF/7L9O/K9v/Dd68kU?=
 =?us-ascii?Q?FJGvIGDhDzP2i5+KMP9k47s70OuEs0NCZ7NzGa7jli3gxHOBXzTGF8fKQXeL?=
 =?us-ascii?Q?qW+xm/CG84fJcBsOAP19/kwXUz0O2wfxl3O9yW5WCL45uohOE5PGYQRCp23H?=
 =?us-ascii?Q?Kpwu77fusTgTCKTiJW3b68d7oITj5YOmplLKbZM+5eDDmu3MGl+bf+lyus0x?=
 =?us-ascii?Q?/8JUY8+x0SgtTZ5RDdd4AioQI/AfcPhqQEy6LUBJ3Zs2qw02Lgfhk/iwEclj?=
 =?us-ascii?Q?27P0Ux0HbI9ts3DwSXeBkgqSD22RjV/SlRtptw3BKHVHc9AVy6a/gazEmwq3?=
 =?us-ascii?Q?498yGTED1g=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2207c506-5b93-4816-922a-08debb9f43a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 03:23:04.1789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jBVglP/1nKuD6QI90duEsZ6LGvPBfTd+h5AOMXeRIvvjuyK9WqK+3bZ/ZHeKJdi6FKunFn1MQe4Q35HcZgbzkYPo8ZbjNelJdiJFZAqpIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_FROM(0.00)[bounces-292083-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,microchip.com:dkim,davemloft.net:email,lunn.ch:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,DSWPR11MB9715.namprd11.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 29E5F5DED9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,
Thanks for the comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Tuesday, May 26, 2026 10:20 PM
> To: Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>
> Cc: netdev@vger.kernel.org; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next v2 2/2] net: lan743x: add support for RMII
> interface
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> the content is safe
>=20
> On Tue, May 26, 2026 at 09:10:54PM +0530, Thangaraj Samynathan wrote:
> > Enable RMII interface in the lan743x driver for PHY and MAC
> > configuration.
> >
> > - Select RMII interface in lan743x_phy_interface_select().
> > - Update phylink supported_interfaces and MAC capabilities.
> > - Enable RMII via RMII_CTL in lan743x_hardware_init().
> > - Define RMII_CTL register and enable bit in lan743x_main.h.
>=20
> > +     case PHY_INTERFACE_MODE_RMII:
> > +             __set_bit(PHY_INTERFACE_MODE_RMII,
> > +                       adapter->phylink_config.supported_interfaces);
> > +             adapter->phylink_config.lpi_capabilities =3D 0;
>=20
> So EEE is not supporting with RMII? This is not mentioned in the commit
> message.
>=20
> Humm, is this an 802.3 limitation, or a limitation of this hardware?
> If this is 802.3, then this should be in phylink, not drivers.
>=20
[Thangaraj Samynathan] No. This is the limitation of hardware. Will update
The commit message in next revision.=20
>         Andrew

