Return-Path: <netdev+bounces-133379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC42A995C42
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6DFB24166
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACE512B94;
	Wed,  9 Oct 2024 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="kiQj3R7h"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2433D11CA9;
	Wed,  9 Oct 2024 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728433230; cv=fail; b=tbsVKwsjGq4ClCRWXpxg4SxtJtLlAFue/4yUoH7BrQ98UzfWMsAng2L+DgvBEA4kVfMOidIDVlwLM89E83m0TCFaiK4OqFdZ/QB6toqeKTiWzV2hBXLCyNTNJV3GgbhiCoRaXjjWYEqwjxA9Giphv6Xi1wjLNxW58xaMWX9Mixw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728433230; c=relaxed/simple;
	bh=f1d1D65EL3r6YIHqpwuMhzF1UFOLY4Sk2xXJQjCOM9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kyOW1hD5GAUWr0IWQIGEmpBtVdW2SQdhOU0YXkhvKdXavYsInvt3JCk9yZENDbHqK3N5JuXHhCx/97+15mDjqzIJO6g0meERypKdRJVRg+ntbl0FtVEDYFdGwYFqdb6H23EEZHKEyiTZoOv1gfYv1lZMTOs7q2ViF/CSfyPRliw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=kiQj3R7h; arc=fail smtp.client-ip=40.107.249.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt9Yk86IPX3rn7PSDDzYraCFfG2kAg0LaGcYqEZVY0+4sqOIbx7pNRwzr5PbFN4Wv+b8tYz10kHnqx/H5tA9wx+6Yen5sTa4ioXma9V7M4/agoBHwGNw4x533A8vMOTsGt/PtuHHULL3XiOAg23vzkdkJOci87PeX3SNX1wunDYvKf4RU4B722H6Ntdk6CVHgSzqkRL4uTFFUbs0QZhyosmRhmdYEYRZoFNohKmo5TNJGZsE97orQOg42X8Zu5QqG2NABbusP7fKVCRiphZ/G9RAQdW9py5MGUY8Rjr+f1c97iVBnsNesMMgu/ezFxzPd6Rg7P4qV0EtdkIhGax9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eawqXiFX60mkB+uFhuWCzT1Znvv0sZq3zKrpT00clA0=;
 b=HsFmRWTdMRLDDQr8DgoSjW3K9j1z3F69rg7iXMm/pBvvJakPc93KahhshNBsXKXolxRJzRsRq10P0L65l1ZP66f2ZZV9BezZDuTH9xqwYGxKznn5eLgyCZQmby3dt/IDOQte4SCLJOfVFGKdlcC29WFlYjHd2rD3Oyv5xFHUz1X1LbSjEdriyBuZsTvBgQPA83naHXW9GcxndEVHKbTpKN2Bpxy6wQ8rzFdsmqWiLGqH0vMzHv2oDVbecvScjUlfgXph5qV34rycdJDKxdYQHQTDawM3PJlvbsaCMo5L7hZ1y6VlhKJJS3ZKSdcQkpuyjMNg8FSTccpadSORtBtWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eawqXiFX60mkB+uFhuWCzT1Znvv0sZq3zKrpT00clA0=;
 b=kiQj3R7hoaoiL0npknj0qNVGup7QlziqdZMUl/bP0HQzntEnty3StoKdE1VV1q50OpPBWuhcm3lowYcfT0FCpntfu1HS4qT+n0S8wpfRXx+V4UKicMnMPrGTZwAwLWwtrAuWs5MP5MQasHEA1Zwo4bcGZ6Nqrl78JoQstgXV2gE=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by DB9P189MB1834.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:330::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 00:20:22 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 00:20:22 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Dent Project <dentproject@linuxfoundation.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 00/12] Add support for PSE port priority
Thread-Topic: [PATCH 00/12] Add support for PSE port priority
Thread-Index: AQHbFOYypdriGqfBF0imTPrJ4BWVpLJ9mBcA
Date: Wed, 9 Oct 2024 00:20:21 +0000
Message-ID: <ZwXMFV5SaIGgVoCU@p620.local.tld>
References: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|DB9P189MB1834:EE_
x-ms-office365-filtering-correlation-id: 24b6715f-cbe3-4f6d-6f86-08dce7f829db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?taFy6+jDGVUuR2+AG0FHGmBbvm/G34jcCFw7GkZ+ro6uue8SpAC5yMsTe3UK?=
 =?us-ascii?Q?m3ArgusMqjzulzRsSSq+k1ZR1tz2ECOVEaVNS9RWBfTBh7SatLETVP0BduXQ?=
 =?us-ascii?Q?RvMWNHL7lyaUPL6sFHx3qiwVdICC+0HU0iCkF931SGgnfG5n78x4+alv4hK9?=
 =?us-ascii?Q?wf4UmBrFVPeetalLqYQbnBN8vYnq7x+UL1tQNDGgllvJNxnP0SGUMUlFknvJ?=
 =?us-ascii?Q?6Xriy1E6jh4pqAcBcSNRiS7S1ArLi9953GLIykopCQyU/1WWTQjTcqWAt2db?=
 =?us-ascii?Q?xW/YFqeRNKf3LXO4X1p7L4ws+bg6U54h9N61uG/kc54jnKwlZowUulZjBVt0?=
 =?us-ascii?Q?uBXK3XGagh/ynoOQhEfbUitDnQfCoyRMynyHB9KBNhwKr4D6jdw7WL8uHnKn?=
 =?us-ascii?Q?kr5PKymDYKIXsw2A2tg4iFyOkaB7CoBnVQWWunzOQG07jqTIqsagmKUZ8WOB?=
 =?us-ascii?Q?Hap982BlFDyzHb3qS0MHVrvfyEO0sK2KVqyIJdOrv4HKiYcz1ecbfRT0XQ7d?=
 =?us-ascii?Q?+hjfpNBSJDN9YCpvzPu62zH4sMlZddYMkGCfeErpbXMbhVrHr3FvMIHx6/Lx?=
 =?us-ascii?Q?RwqAtXJglLEFrf+KKcHZzawoYphkcUqvv9psQ04fTLs7zMA82HpXEVz/vxp/?=
 =?us-ascii?Q?fx7NBkav5+Ln9+WmcgdqFKaUgKKMSCs9YPUtGV5/zHfqHBsAfwTkC/P+Faj1?=
 =?us-ascii?Q?ckIQVr+56RdUjlLuBl3ubqPkXqxbEkEJ/ivj/jZG0R8jZ5wcfeGwQzTRQfey?=
 =?us-ascii?Q?Hh+l0tAF0pmuIY5MRUxPguCsnkkQ47PAzktwGMpdWRTKhbQ50nTVe3+xCabN?=
 =?us-ascii?Q?9ubWlSYBxLYrDLweS0krgTiGVFZu6x1jUgODgFDqaHltPM9MOHHDB/ZgH5Kj?=
 =?us-ascii?Q?TWvO231K4+dD8MyLR5OzdB34yOyn48azmxY33HYao3jT47TYNEyeche9bvx8?=
 =?us-ascii?Q?WH11NCeATz+P3c/sXNLAnhWfgFaQak2EzPNtd1YAtKShj1DDxkYW0t9X03Y7?=
 =?us-ascii?Q?KQOhI9LOG0oK+c3tuMjDbkffe5ZcxeVLp7Ws17Cx6eiC9NN4cZmRFpd3Zik7?=
 =?us-ascii?Q?hfTE2JgngzHEsjkdtPQ7R+YlBZ7HJBsSFsyA34fuRYJMZoL+JElfNO0HTX6w?=
 =?us-ascii?Q?uJyBo0NmvoP1W5g0AZZIlvyOwjUrythwpu0pV8GRJ6oJHGLuY02Ps39qrIjE?=
 =?us-ascii?Q?UJ80FTalHtqyVq/IZ77Ca3BD73SC+I1cpDf7T8H/cD0uhuOIeSZSzNP/NTd7?=
 =?us-ascii?Q?uISpix91YW6vcdXvK3w+MEJDSbiUxtcEn9/wMqZHHc7zhSAP3fgTCvOCHJ5i?=
 =?us-ascii?Q?pBd4+OpD4NBi7tmWTg7dhBh0IkdKGyNHr5bq59DhmQJrmQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?osTMLPOQ/Al5mtNNzG19F7x7wJFlVv/zJuHHsp54UYXlmlGsSIc89tNmS9oJ?=
 =?us-ascii?Q?23HshGiX03o8GLK/FPZTH/o/lV0TMDj6S1R9YRGHz7dLhFdcQepw1uOnAFFM?=
 =?us-ascii?Q?am/Y/4VNpvt398Bdqme2hf/JUm63yd3Qv3EUtLLNWGSBH6O4Uc4i6balUhhB?=
 =?us-ascii?Q?2kQziJk2oorQoo62WSi+RIaa+NWCpHddjO88XgjO0uBfdoOoIGJgtTO5LXn7?=
 =?us-ascii?Q?neNCUpPW3h6JDebc10ULX4n4Oa+6vj0Pz1uDkwkEUQirKkbbLvyaM5H09L5V?=
 =?us-ascii?Q?MZ1BMy6QI3oNPI2EtyyFGM32xDGs7Zd6mg716F7pTNAQJwTBApLG43m9rNmp?=
 =?us-ascii?Q?jpLjE10cHNzKlgsgswOaVkFFFwM6CNN+2tdGFQrFPWNu+gEpHAlAdlQdk0Ru?=
 =?us-ascii?Q?LVZXacVFeekP1Lcemo584iuEsUOazg9AbqVz7xFvnRQueWEwQrAZkVZKSuAj?=
 =?us-ascii?Q?59Zn4T+yi9SliEOvPbaIVxZxvfJXWWX1lQAac7BZshDufDAVdgjpLQ9Tk6lD?=
 =?us-ascii?Q?CKxOqBtaauBn4lEOw0JxrZbZN+vhYKW0VsPZtRR3/70d0cdqiUruFTdGVsFA?=
 =?us-ascii?Q?flvansVSLIAj7Qwlg8d9LaPwebbfntRQFMQpVAdhTmv3u05/67MXD0vci9VZ?=
 =?us-ascii?Q?FX0NWVyWMbO6Xf15HF92wKFTH7TpBegWgVMydNjUSg2aPCdLP0OYN6VoT1Hp?=
 =?us-ascii?Q?Wwo2fGiYwW0ryGaAdVVNJa4cDJUW0vWw8p06veKMxQOwpREcA9fCpeLPlPY3?=
 =?us-ascii?Q?pObRBouojBUhob++cAAeV6avFbmI+CumdkNkSzzD+Or8M3GJKeDyGRCRVRHn?=
 =?us-ascii?Q?zJu2YK4cqHZeke8HuNU50fgxKKq3ps+Xv8R6nXPq2XghH33jD+HOh8CgpFn2?=
 =?us-ascii?Q?qJjgq0fdY/RWnzBcQBAq9M/BvTKHWrMQyOhbkT/2QgJPViip4nyN2LQFYSTK?=
 =?us-ascii?Q?6516AzM8EZ6857MHBRa7WUDfmmsRIycBMbQIEHQDSBtmdcrzUOBQ7ArSmXB/?=
 =?us-ascii?Q?bdtabuqvfktpQZa0g1c1HcuhK9cBFcR4PQNpzAi9c1c1s8SxDv/1HYYW+c9c?=
 =?us-ascii?Q?+mHrM0qKtmgu3jAXhsxRzGASA7oHAzWkLowZk+L2b0h3MRk1A9JD39OnHPnv?=
 =?us-ascii?Q?yqHY/INntXM6liKEpCMEoK0aye3uV95KDURhUeOUsioPSI0pRSsxReuq8Vso?=
 =?us-ascii?Q?0OkhpdVqW/i0UmATHEMgP4jgQWkprDPCe7mjYdWgTkevJS7yCdZj88DB858u?=
 =?us-ascii?Q?QEglr0puNxHjr6UMmiZf3Ku7yxJZpngTb2Nd1Dl5fjgeAiOjJHPcnKvppAV7?=
 =?us-ascii?Q?Uw9/wUYNjdTp+85p3kXw2HWvojLQ0Q5NO0kOUhhfyDdz/7bq4fRAn0blkwG0?=
 =?us-ascii?Q?6bDXF5xHKSCXyuUIPqUHl8Unq9FCpPUCZI4zRbg3FFyJagMrZBPE3iz6Lc6L?=
 =?us-ascii?Q?MlNAFtSFycAwbFuNQBDcemDJkTO06c7+Z6OITTg5QR9sB6Kyn8xzijDNdOrt?=
 =?us-ascii?Q?ze/Wz6lLtRFj1P3wXuqTpfMlDGDftrNAEPYfXpOD4MeUXBrIUzs8ZyksT9mO?=
 =?us-ascii?Q?uS2ZquBDiK91o9cFZW7osiHrtVAEtigCE63uq0qy?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E82105127CC49F4B9D43E8743CFE8E35@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b6715f-cbe3-4f6d-6f86-08dce7f829db
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 00:20:21.9823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z8uMQPk58GR3VMLhXkhPW1lSI99QvxnMJxB2tJyvcZOg8KTcKK0aVtXj90ukv0mRIgEzUXXZgPYfkl1sk2rOjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB1834

Hello Kory,

On Wed, Oct 02, 2024 at 06:14:11PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> This series brings support for port priority in the PSE subsystem.
> PSE controllers can set priorities to decide which ports should be
> turned off in case of special events like over-current.

First off, great work here.  I've read through the patches in the series an=
d
have a pretty good idea of what you're trying to achieve- use the PSE
controller's idea of "port priority" and expose this to userspace via ethto=
ol.

I think this is probably sufficient but I wanted to share my experience
supporting a system level PSE power budget with PSE port priorities across
different PSE controllers through the same userspace interface such that
userspace doesn't know or care about the underlying PSE controller.

Out of the three PSE controllers I'm aware of (Microchip's PD692x0, TI's
TPS2388x, and LTC's LT4266), the PD692x0 definitely has the most advanced
configuration, supporting concepts like a system (well, manager) level budg=
et
and powering off lower priority ports in the event that the port power
consumption is greater than the system budget.

When we experimented with this feature in our routers, we found it to be us=
ing
the dynamic power consumed by a particular port- literally, the summation o=
f
port current * port voltage across all the ports.  While this behavior
technically saves the system from resetting or worse, it causes a bit of a
problem with lower priority ports getting powered off depending on the beha=
vior
(power consumption) of unrelated devices. =20

As an example, let's say we've got 4 devices, all powered, and we're close =
to
the power budget.  One of the devices starts consuming more power (perhaps =
it's
modem just powered on), but not more than it's class limit.  Say this devic=
e
consumes enough power to exceed the configured power budget, causing the lo=
west
priority device to be powered off.  This is the documented and intended
behavior of the PD692x0 chipset, but causes an unpleasant user experience
because it's not really clear why some device was powered down all the sudd=
en.
Was it because someone unplugged it? Or because the modem on the high prior=
ity
device turned on?  Or maybe that device had an overcurrent?  It'd be imposs=
ible
to tell, and even worse, by the time someone is able to physically look at =
the
switch, the low priority device might be back online (perhaps the modem on
the high priority device powered off).

This behavior is unique to the PD692x0- I'm much less familiar with the
TPS2388x's idea of port priority but it is very different from the PD692x0.
Frankly the behavior of the OSS pin is confusing and since we don't use the=
 PSE
controllers' idea of port priority, it was safe to ignore it. Finally, the
LTC4266 has a "masked shutdown" ability where a predetermined set of ports =
are
shutdown when a specific pin (MSD) is driven low.  Like the TPS2388x's OSS =
pin,
We ignore this feature on the LTC4266.

If the end-goal here is to have a device-independent idea of "port priority=
" I
think we need to add a level of indirection between the port priority conce=
pt and the
actual PSE hardware.  The indirection would enable a system with multiple
(possibly heterogeneous even) PSE chips to have a unified idea of port
priority.  The way we've implemented this in our routers is by putting the =
PSE
controllers in "semi-auto" mode, where they continually detect and classify=
 PDs
(powered device), but do not power them until instructed to do so.  The
mechanism that decides to power a particular port or not (for lack of a bet=
ter
term, "budgeting logic") uses the available system power budget (configured
from userspace), the relative port priorities (also configured from userspa=
ce)
and the class of a detected PD.  The classification result is used to deter=
mine
the _maximum_ power a particular PD might draw, and that is the value that =
is
subtracted from the power budget.

Using the PD's classification and then allocating it the maximum power for =
that
class enables a non-technical installer to plug in all the PDs at the switc=
h,
and observe if all the PDs are powered (or not).  But the important part is
(unless the port priorities or power budget are changed from userspace) the
devices that are powered won't change due to dynamic power consumption of t=
he
other devices.

I'm not sure what the right path is for the kernel, and I'm not sure how th=
is
would look with the regulator integration, nor am I sure what the userspace=
 API
should look like (we used sysfs, but that's probably not ideal for upstream=
).
It's also not clear how much of the budgeting logic should be in the kernel=
, if
any. Despite that, hopefully sharing our experience is insightful and/or
helpful.  If not, feel free to ignore it.  In any case, you've got my

Reviewed-by: Kyle Swenson <kyle.swenson@est.tech>

for all the patches in the series.

Thanks,
Kyle Swenson=

