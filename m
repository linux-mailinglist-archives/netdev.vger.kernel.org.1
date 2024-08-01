Return-Path: <netdev+bounces-115148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B2B9454FC
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20FF1C20FAA
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE66B14B976;
	Thu,  1 Aug 2024 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sNb7Xe/O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PtFjs7se"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ECF1BC40;
	Thu,  1 Aug 2024 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722556039; cv=fail; b=U6ge/mUuZdW4Bs0cRfYNIrextvDd1zjQXeumDN0Chwy2c2cVKOO2DeAOmslb72lKCcZNG16DXZTUdFrHn73fgVZ2qgcnT6SYs/a+Lt/bfI3TOdaDunYotGmuATKeDu7h+tkZVBNmiWMR8tJk5aOU1iIN5dso8AEvexkZ6re9NQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722556039; c=relaxed/simple;
	bh=83r1wpMs2bmA/R++Y+5MrpsJppp0fWj868BzgHUReMo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c/e9rBI4hMmlMK3To4Kc7PbV8LC1TyOCg5noEVVnoJIsV9o8HcxpdYXvHvXxsLogSgHFLucn6ZSmu4SgRv7c+UYrLv0Ga0UtqvygLJikCBlgRfQXZgFVm7xMiz/XqgkOj9oUyi+Nmm/NqQ9suj5rH+q6qrAWRof6olkHKvgz6Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sNb7Xe/O; dkim=fail (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PtFjs7se reason="signature verification failed"; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722556036; x=1754092036;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=83r1wpMs2bmA/R++Y+5MrpsJppp0fWj868BzgHUReMo=;
  b=sNb7Xe/OaVQedm4bgcbUzM4JPDTgdXf1DOTdnfWauAk0ME/ZsEm3KZZE
   z7Z2e6SCo0pe4pdd+zl56hfj9RAW5dBBF7EmYKrD+RsydWcCoI3XwPGCs
   /6W3ii4pTeawPNXWbZdv6xIDIs3CwQvzleVHzqVNrUmc/nLCfDg5Tu4Jq
   zH896SA76a0v0KEdZrJGwmDfXI2XxQkElCovYSqz5FNCFqXlDKxGi7BX9
   UCJp/tNH/fMG6oPb5z7/73DFeQUEKKGHgwNoYaZk/XPdncvGlkmMRnjLN
   OvRZXXKmfzz3rSMPEtEd+LUPX9izgkOlrCIdeSbx3lixvSMoDYEZs/cQ+
   g==;
X-CSE-ConnectionGUID: alABMp9gS9CSqEVI6RNZcA==
X-CSE-MsgGUID: TyQ/eaP5QzOmZmZtSf/f1g==
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="32849494"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Aug 2024 16:47:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Aug 2024 16:46:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Aug 2024 16:46:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhv8Q97LT5yYJEwW4YDd6rSOj8x+TxpspibhkrfOVUZdU2jLfkbIic3BlWSF/IYY1TIGIxzfarFVDSMQp6RWqC6PC1eJU2i/KQ3uQXLCDpqK89HL5m5u/f1noUSC8y27ekWM4sXe0sL2OWad+x4DZYhKLIlC7FfS1crjDeVbBwuNsvqKeHmq/c15hXPhQJPYAm0etG/tB/ZAYP/FziONBAANEWBAxbvf59SXzb1lMjPEIxqsm+ZyGkdJF9ocoanGWG51BdG3m1/3TtFAwhx6+jXrXiF7WNZLT1+NFTEtAu6otprQJVPn55qivFs8X/s8guOX9QwIsV1gD0BIBnoJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAz/cIbn2BknNaCYk8Rsh/B3RrB0pqbUSTz3w5NJiXE=;
 b=JFGnDatyGYJI8avnrxA4MZsW+1Wj/vk2tmHUjVD8o5InpHh7mbRMX+idLDljNkBbfw/WhezjxIIG5hDaEaZRqoozVrLwGMxVbgUATEWIMM6aV5hZUJHOdVWdHU67cZTVKDek6kp+hDKurQrj4SEV6C+yGlvi35csJoXeww3KRVN3b61KMQ7Y4RllJgzOtLZNEwkXQiGRd4nEj7H8JRNd6RZuyMoF2DQpV3B4N8sUsoJsOYDWWUBVoO/F7BTQ8tt6qqHZQ3UwmnksSiCAMGKPUN56e+H/4mFeISW3SrrJxMmSJx/ZFMnQHTXWMPGw/odurP+VypmqYEv9/ryOCdda1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAz/cIbn2BknNaCYk8Rsh/B3RrB0pqbUSTz3w5NJiXE=;
 b=PtFjs7senYK/wXzDukHe0ZwKaKOqgVekAmRrqJybjnT9vjiB/KQco1w5eJvsW9FK6Kxd1ZmxvY7nkKfT3/AXAMxHldTnJCxg8YWWZwh6WoaHv//qftAOVPC8J9kx8gU4tXGk2SGSIcnQPNB8TwIfVQYKOL6n1nMK9P6u7ttUCOIJTlr1bIIaPckb70HdAIlupxODd7K3CiOkqVy25bZetR4XKryNkU4nv4cairT2FAqFDo5dDuyvpYogGcMpdjRD3Fv2evmIcq9s8mZ2tzWpW67U51yYdlp5FEVSek4t7JI/+5oiByEFYptjiDFkrttaK9QehIE6YGsKpsBignABDA==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by MW4PR11MB6713.namprd11.prod.outlook.com (2603:10b6:303:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 23:46:41 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%2]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 23:46:41 +0000
From: <Ronnie.Kunin@microchip.com>
To: <linux@armlinux.org.uk>, <Raju.Lakkaraju@microchip.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <horms@kernel.org>, <hkallweit1@gmail.com>,
	<richardcochran@gmail.com>, <rdunlap@infradead.org>,
	<Bryan.Whitehead@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net-next V3 3/4] net: lan743x: Migrate phylib to phylink
Thread-Topic: [PATCH net-next V3 3/4] net: lan743x: Migrate phylib to phylink
Thread-Index: AQHa4oo5BwbfSBGoKU+hL6P+F4sZeLIPXFSAgALjZYCAAFqPAIAAdOaw
Disposition-Notification-To: <Ronnie.Kunin@microchip.com>
Date: Thu, 1 Aug 2024 23:46:41 +0000
Message-ID: <PH8PR11MB79655D0005E227742CBA1A8A95B22@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
 <20240730140619.80650-4-Raju.Lakkaraju@microchip.com>
 <Zqj/Mdoy5rhD2YXx@shell.armlinux.org.uk>
 <ZqtrcRfRVBR6H9Ri@HYD-DK-UNGSW21.microchip.com>
 <Zqu3aHJzAnb3KDvz@shell.armlinux.org.uk>
In-Reply-To: <Zqu3aHJzAnb3KDvz@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|MW4PR11MB6713:EE_
x-ms-office365-filtering-correlation-id: 373d9b5d-3e01-41aa-9c83-08dcb28431a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aDUJYtDaLo2LZnZi9Av7+BW0SthLmL5QQ3zsK1yGCCaA9/0DaQ7wlnDjtZ3M?=
 =?us-ascii?Q?ds/KjcWXNmaaaTJb5jIKCJXWZPQL6BtNgrzFnBoNZNzomFpiq/tdv2rxgvMb?=
 =?us-ascii?Q?N9KHBs4DpmSIS/GHwgaS4Ny7HbqXLBc1CZvuLdZkOG6Ha8Gg0zons48O27EV?=
 =?us-ascii?Q?iggQ3DVzo4EjxBxwN+YhRr2ZkcBjAezT8qeFgQ3YAs1y5q6NhnJClnJ3IX3d?=
 =?us-ascii?Q?DFVBTzd4WjxGQ39M6AgU/pp4ErveM9y9UYcjIKwejfDTV4lCBMw/Ku+cWoS3?=
 =?us-ascii?Q?iIyP7AuetH79hHL3zuHGQQvMeb4/5gTYQVRk7urrZ6RFkY75uyUGLOuY0dcj?=
 =?us-ascii?Q?k7KxJS0yhEgDatQqSe8Yr/+dnlzv6HEd1Sv7IptcpSnVZAeED4AuIBhDBv+O?=
 =?us-ascii?Q?8sprnesythVLS+9cO4Jyn2W2F0N4ANB0/bfRtX2/xo4kUDno8zrKE7LY/3VV?=
 =?us-ascii?Q?egF3RPCTQOFv8aUbWNRodwJY+ZYKN68pE39V3Vx3Fwoc57UuYEiCl9O6/HOO?=
 =?us-ascii?Q?0XVJnbWCYsWSAE+ZwFMVDeB7wMXQDCAGd/S+bd21q2qF7lqKMbrNxO/Wewro?=
 =?us-ascii?Q?S2L0HQZ1iOu7a3d9Wq0HyYsxGEW0GJsSap+rKDzwgSHPV6dXKwcjw2XYB2zB?=
 =?us-ascii?Q?l4n64T9xg2Y1q8r1TJxd7NDHWl+JTXWaXHvM9yYNrdF4cezIF8FM7XG1tygm?=
 =?us-ascii?Q?neWYTrq8y5d1lxB+yU+L8oN9G3jA7uPt3jv53cJ7tfdgSBBD79tBBpy/OcO4?=
 =?us-ascii?Q?GcO/R7ZLnNYSUpKu0GjS6OrmTw1Nypjv1AW9Ny+jXxj1bt5MjErfjR+bzWRn?=
 =?us-ascii?Q?KUTuMBBoxN0u53LrRfDdAR7B7n/DiqEuMZ9G71YJ6NSRRuuF8oT4HxNYSRok?=
 =?us-ascii?Q?p7i7/XwCkjkBFAjSHl8h+WsNqQcJoMXkz5qko0BfbQj7jHyjkeJTEK+lg9GV?=
 =?us-ascii?Q?OIup8wGAAbKkYlkOtb56GjcdRvKkV3zsGtmdjRNKGFdJDypUk77RJY0tNhsh?=
 =?us-ascii?Q?tmlaGWkLax+rKhg9p+2ModyfPAvDaur9vOqDbhBbq6Fbsf7mnjJz8ykjJwe6?=
 =?us-ascii?Q?XhSiOYgz/vPWubLpb8NZr2hDtiTKl+hA0RGDbcDPZaX7PvGov115MZUndece?=
 =?us-ascii?Q?vMj8KmaI1ijOwE00HKJOScsHxoMqk189u0audNefP0R7IlzfC5PQn+czK3C+?=
 =?us-ascii?Q?a432WY205CiGthzi2455T2gMnnfXRF2hQgSCGfYJ2LRo/zE4uZzzpGgBmk8o?=
 =?us-ascii?Q?CwwJxxo5tkWDihmC+fe8ptaR6ophDYBqvgq1pYZi58IQiiK2SEDQzIvKEQbO?=
 =?us-ascii?Q?s+wEu+jY4VuYrPdUodLVN2E0qtPivv2AyoOK9C2QBsQMyrqulqJm0u09zxgS?=
 =?us-ascii?Q?BUcFR6Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LrpQmoHHqvi1va+rP9lCRqRPgSCC6hbgU/G38xNjpAQy0HJo5g4hwMm3WVPD?=
 =?us-ascii?Q?tj8rJS5aX5rSoR1FsDj9u6Y2/zwV0lKjr3nGFTJXA5//30rTR8AULLA1AjRl?=
 =?us-ascii?Q?8j01OT23CgE25zE1rAa2LGnZO6+R64MGpC7MckKUSGYOuoFJdDTJt9eUkCp0?=
 =?us-ascii?Q?/1QEfXpWBAE/VUA4S7rTdgetXaIQeuk43Srf5pMRn5gnf/3GRxRN+j0N+KwF?=
 =?us-ascii?Q?cuCN0S4+F93RjaaoX8lbxqe6P8rHNE4Mp2IpUgv7Ayr04Bon65nZNz532OhM?=
 =?us-ascii?Q?J4rjDxU/gz456cuQ9oRGI0T+KQVRztMec5tKqBbuwWP8afeAD66gHITXU5ID?=
 =?us-ascii?Q?MJhPcW4a7YK/0xd0lAwrUF8SRzOMkUKFigGQYIRKxpNEHT8NDNntjnJmI8PP?=
 =?us-ascii?Q?WDI8l1eiwFqWtS7yg3xaaMuP9vr/HpO8yRTTWkmDIXp+sOyPvZ7YXorPzo2S?=
 =?us-ascii?Q?4RAZVbLRpp9z/dmCRv5UrNpdFaiukCaNUvte70ggYRJ1GDsGNF3FadxJ9Zs3?=
 =?us-ascii?Q?fWvoiXGN5CzGA/FsclZAzpUdzJ3ZyLJidlSsZtUWKbRwQqapbOXHN+YjfVlA?=
 =?us-ascii?Q?sio91saExL8S0LjtOgjp8RInc1bTslelZGk7SwXDSpvxKt/glQzfBUfbMEX3?=
 =?us-ascii?Q?3K0hXY7YvgggAn9/CM64/IczDwu9Cf0kYqpfSODhH+5Z23t0pUAQ1TRzwKR3?=
 =?us-ascii?Q?djyGyhkjbgOLLuren3pIUPJ/xkeuI8SBsiQq9b2ifPBgO79RKE0FbIZ35hc7?=
 =?us-ascii?Q?URArMEN6IFGuFqFFCrwYanWFoV+2/IaVSw+7cByksQXgRUjAait25Di3vnEz?=
 =?us-ascii?Q?wGNl0PFLHmoBgQjXgmg/EywGeVuKIH4H74RiG9nsNa66yaYmCznn4RZCaur1?=
 =?us-ascii?Q?pvqckAM1sbrRGIIrl1e3il+7nmspG9Fe+5F3ti5KF4FKCRyyBhdM3mZlt4Vz?=
 =?us-ascii?Q?wG/rPTvxcW5PLmh+s9JewCujIZ2Kv8Ux70DIG4XohSRtUhVpbFcn22ZhvnQ0?=
 =?us-ascii?Q?QFQq+FChgptbSSCjzmYJM0sroOp82eJokBB84h2n3n6WWr73KATT8Jy8T6eC?=
 =?us-ascii?Q?QVpb/o0Rte58O27T0c+Pl4GxaW/nORAarV69CD380eB9/IFjyE6gGk/LuaOJ?=
 =?us-ascii?Q?KhyqWBcFa9K0Zk4OtM74xPX7Pohdq4Pgp9wDvF12hSFsm0omVXgLh7Wp8OAH?=
 =?us-ascii?Q?qSWY0Z1D75W+MxUiZB+dAG2HyiU3KEm+y3W6Gz3lEZ0Y6n8wDIFztmqey5Xf?=
 =?us-ascii?Q?jCo+Hf5SWkp/b+tHWoWFIjralES1PyiRZTxpe3KZhsxezQ99cMtoRL6qniAq?=
 =?us-ascii?Q?j7Z8yVSF2Sy4w7TyVJdWPgUE5f96ARtLjL+wp4B4P3MpSNCAGZQ2wW+xkDAC?=
 =?us-ascii?Q?XpD/wR/eUkwL43PccOc0WQiSqN/LzcVbov3XQnfDXyIG60IB/X+g92HLrL4e?=
 =?us-ascii?Q?8RMkbvgn58J+fEsUY8sxcgzqfGn4fij2vvohO1wxuh8p/JqNULmXg636vyY1?=
 =?us-ascii?Q?e3ZPIIMRBXprpdFUCAMqMlDlq8SaLQuxNgk1UyyJQXLB9VJrqyu8xSn/A890?=
 =?us-ascii?Q?15r0ojsEQ2gQWWnjtHOg6/xKZuMrZveMEm2i/UAz?=
Content-Type: multipart/mixed;
	boundary="_002_PH8PR11MB79655D0005E227742CBA1A8A95B22PH8PR11MB7965namp_"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373d9b5d-3e01-41aa-9c83-08dcb28431a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 23:46:41.7427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMvYjzFIsQUL9MP3LKJQQQ3+zaLJEmp0k3Il6kAinNYWkTQKq18ZaTB/VCpltBOJArVIlHmCXt1riZCVlxCNehAgee4s14ghTHlWcxZY5Os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6713

--_002_PH8PR11MB79655D0005E227742CBA1A8A95B22PH8PR11MB7965namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Russell,
Raju can comment more on it when he comes online tomorrow (IST time), but I=
 recall this was discussed with you last year and my understanding is that =
the outcome was that as long as the need to use the dynamic fallback from p=
hy to fixed_phy mode is explained in the commit message - which Raju did in=
 the commit description - , it was acceptable to do this in phylink. Unless=
 the "mechanism where a MAC driver can tell phylink to switch to using a fi=
xed-link with certain parameters" has been implemented since then (apologiz=
e if it has, I am not a linux expert by any means, but don't seem to see it=
), I would guess the reasons for doing this are still valid.

Attached is the email thread with that discussion and the relevant comments=
 are copied below.

> The reason this should work is because the fixed-phy support does emulate=
 a real PHY in software, and phylink will treat that exactly the same way a=
s a real PHY (because when in phylink is in PHY mode, it delegates PHY mana=
gement to phylib.)
>
>Using fixed-phy with phylink will certainly raise some eyebrows, so the re=
asons for it will need to be set out in the commit message - and as you've =
dropped Andrew from this thread, I suspect he will still raise some comment=
s about it.
>
>In the longer term, it would probably make sense for phylink to provide a =
mechanism where a MAC driver can tell phylink to switch to using a fixed-li=
nk with certain parameters.

Best regards,
Ronnie

-----Original Message-----
From: Russell King <linux@armlinux.org.uk>=20
Sent: Thursday, August 1, 2024 12:27 PM
To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org; andrew@lu=
nn.ch; horms@kernel.org; hkallweit1@gmail.com; richardcochran@gmail.com; rd=
unlap@infradead.org; Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.co=
m>; edumazet@google.com; pabeni@redhat.com; linux-kernel@vger.kernel.org; U=
NGLinuxDriver <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next V3 3/4] net: lan743x: Migrate phylib to phylin=
k

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

On Thu, Aug 01, 2024 at 04:33:13PM +0530, Raju Lakkaraju wrote:
> > > +     if (!dn || (ret && !lan743x_phy_handle_exists(dn))) {
> > > +             phydev =3D phy_find_first(adapter->mdiobus);
> > > +             if (!phydev) {
> > > +                     if (((adapter->csr.id_rev & ID_REV_ID_MASK_) =
=3D=3D
> > > +                           ID_REV_ID_LAN7431_) || adapter->is_pci11x=
1x) {
> > > +                             phydev =3D fixed_phy_register(PHY_POLL,
> > > +                                                         &fphy_statu=
s,
> > > +                                                         NULL);
> >
> > I thought something was going to happen with this?
>
> Our SQA confirmed that it's working ping as expected (i.e Speed at=20
> 1Gbps with full duplex) with Intel I210 NIC as link partner.
>
> Do you suspect any corner case where it's fail?

Let me restate the review comment from V2:

"Eww. Given that phylink has its own internal fixed-PHY support, can we not=
 find some way to avoid the legacy fixed-PHY usage here?"

Yes, it may work, but fixed-phy is not supposed to be used with phylink.

--
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--_002_PH8PR11MB79655D0005E227742CBA1A8A95B22PH8PR11MB7965namp_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Thu, 01 Aug 2024 23:46:40 GMT";
	modification-date="Thu, 01 Aug 2024 23:46:41 GMT"

Received: from DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) by
 SA2PR11MB4922.namprd11.prod.outlook.com with HTTPS; Tue, 26 Sep 2023 08:12:28
 +0000
Received: from DM6PR08CA0033.namprd08.prod.outlook.com (2603:10b6:5:80::46) by
 DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Tue, 26 Sep 2023 08:12:27 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::70) by DM6PR08CA0033.outlook.office365.com
 (2603:10b6:5:80::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 08:12:27 +0000
Received: from email.microchip.com (170.129.1.10) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Tue, 26 Sep 2023 08:12:25 +0000
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 26 Sep 2023 01:12:06 -0700
Received: from esa.microchip.iphmx.com (10.10.215.10) by email.microchip.com
 (10.10.87.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 26 Sep 2023 01:12:06 -0700
Received: from pandora.armlinux.org.uk ([78.32.30.218])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:11:52 -0700
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34088)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ql3AZ-00027Y-0q;
	Tue, 26 Sep 2023 09:11:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ql3Aa-0000ES-6C; Tue, 26 Sep 2023 09:11:48 +0100
From: <linux@armlinux.org.uk>
To: <Raju.Lakkaraju@microchip.com>
CC: <Ronnie.Kunin@microchip.com>, <Woojung.Huh@microchip.com>,
	<Horatiu.Vultur@microchip.com>
Subject: Re: [PATCH net-next 5/7] net: lan743x: Add support to the Phylink
 framework
Thread-Topic: [PATCH net-next 5/7] net: lan743x: Add support to the Phylink
 framework
Thread-Index: AQHZu5jKz5hU+U5EsUisMgycR1M/w6/D6TaAgAA0gQCAaPBdAIAAHOsA
Date: Tue, 26 Sep 2023 08:11:48 +0000
Message-ID: <ZRKSRG3L8fAZQD1i@shell.armlinux.org.uk>
References: <20230721060019.2737-1-Raju.Lakkaraju@microchip.com>
 <20230721060019.2737-6-Raju.Lakkaraju@microchip.com>
 <ZLpGgV6FXmvjqeOi@shell.armlinux.org.uk>
 <ZLpyjNJsQjOw2hfj@shell.armlinux.org.uk>
 <BYAPR11MB3366DCFBD68E5A319AB7F7169FC3A@BYAPR11MB3366.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3366DCFBD68E5A319AB7F7169FC3A@BYAPR11MB3366.namprd11.prod.outlook.com>
Content-Language: en-US
X-MS-Exchange-Organization-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-Organization-ComplianceLabelId: bebe2ced-2e97-48e5-b828-9699b2c89684
X-MS-Has-Attach:
X-MS-Exchange-Organization-Network-Message-Id: eb730cae-262b-4363-c613-08dbbe6851ab
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
x-ms-exchange-organization-originalclientipaddress: 170.129.1.10
x-ms-exchange-organization-originalserveripaddress: 10.167.242.41
received-spf: None (esa2.microchip.iphmx.com: no sender  authenticity
 information available from domain of  postmaster@pandora.armlinux.org.uk)
 identity=helo;  client-ip=78.32.30.218; receiver=esa2.microchip.iphmx.com;
  envelope-from="linux+ronnie.kunin=microchip.com@armlinux.org.uk";
  x-sender="postmaster@pandora.armlinux.org.uk";  x-conformance=spf_only
x-ms-publictraffictype: Email
authentication-results: spf=none (sender IP is 170.129.1.10)
 smtp.mailfrom=armlinux.org.uk; dkim=test (signature was verified)
 header.d=armlinux.org.uk;dmarc=pass action=none header.from=armlinux.org.uk;
x-ms-office365-filtering-correlation-id: eb730cae-262b-4363-c613-08dbbe6851ab
x-ms-traffictypediagnostic: CY4PEPF0000EE35:EE_|DM4PR11MB6480:EE_|SA2PR11MB4922:EE_
x-forefront-antispam-report: CIP:170.129.1.10;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:email.microchip.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(230922051799003)(451199024)(82310400011)(356005)(26005)(426003)(336012)(966005)(70036008)(7846003)(81166007)(9786002)(9746002)(1096003)(4326008)(34206002)(8936002)(8676002)(4006050)(75640400001)(83380400001)(5660300002);DIR:INB;
x-microsoft-antispam: BCL:0;
x-ms-exchange-crosstenant-originalarrivaltime: 26 Sep 2023 08:12:25.8363 (UTC)
x-ms-exchange-crosstenant-fromentityheader: HybridOnPrem
x-ms-exchange-crosstenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
x-ms-exchange-crosstenant-network-message-id: eb730cae-262b-4363-c613-08dbbe6851ab
x-ms-exchange-transport-crosstenantheadersstamped: DM4PR11MB6480
ironport-sdr: 6512924f_tOccynPjFxfgR0UwVJRqdxoY/d8t6Fz6KqBf93wNMkqb8q3
 zVqZkgVq1QM4yPqCNuBJrESjAhayhx5KyWZPQXA==
x-ironport-av: E=Sophos;i="6.03,177,1694761200";    d="scan'208";a="6600944"
dkim-signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ns0o+MQreHRCG812WhuFhWaAb4Pj/ndJaElRTM3XswQ=; b=GhAhq6+WNh7EHZ79X2xazXMFFi
	+sLlObHZr2cCqc2QGdKZSwuYkEd8HxbBdrNmN2TINgfxHg6oCXrxyUOvOdH84eRgS3eY6RkqX2QHY
	WVqJ64L/nt+11O80QNOQ11xB3DLEj+4B9WQWuwR+yQBpz4ZNuGmTiktYik+90eJmPPZqGFFs83kGu
	aZNX0vYrwx4z3VNSJRdpdQ571gx3KiAQciIUutzhNm4v/OCssnsD31N1lc8xgcazsWP66L6iizgkA
	Ri6aO21JKCKMa1a9j0B17sg1pBxH51a8jlxAxX7AhYQgkOSnBiiCdARvIJNgYd5SLbsnsdR5PTnnv
	eb2c7WcA==;
x-crosspremisesheadersfilteredbysendconnector: chn-vm-ex02.mchp-main.com
x-organizationheaderspreserved: chn-vm-ex02.mchp-main.com
x-eopattributedmessage: 0
x-originatororg: microchip.com
authentication-results-original: esa2.microchip.iphmx.com; spf=None
 smtp.mailfrom=linux+ronnie.kunin=microchip.com@armlinux.org.uk; spf=None
 smtp.helo=postmaster@pandora.armlinux.org.uk; dmarc=fail (p=none dis=none)
 d=armlinux.org.uk
x-ironport-anti-spam-filtered: true
x-ipas-result: A0HfAQACkRJlkNoeIE5agQmBT4FlUgF4VTEEC0eIIottggYdA517gg0BAQEBAQEBCzkIAQIEAQEDAQOCDIl7Ah4GNgkOAQIBAgEBAQEBAwIDAQEBAQEBAQIBAQEEAQEBAgEBAgQCAgEBAhABAQEBAQEgHh4nhWgNgjckO4IHLA14AQEBAQIBEhUTBgEBNwEECwEKGC4QRxkbB4JcAYI7IwQDDaR+AYErPwIoAUABDIELiRJ4gQEzgQGCCQEBBgQCBH2xbgMGgUiICgGKBicbfYEQgRWDKz6FEYV2iUmFPQeCV4NZinMqgQgIXIFqPQINVQsLXYERgkQCAhEnEhNHcBsDBwOBBBArBwQvGwcGCRYYFSUGUQQtJAkTEj4EgWeBUQqBAz8RDhGCRSICBzY2GUuCEUoJFQw0TnYQKwQUF4EUBGofFR43ERIXDQMIdh0CESM8AwUDBDYKFQ0LIQUUQwNHBkwLAwIcBQMDBIE2BQ8eAhAaBg4pAwMZTgIQFAM+AwMGAwsyAzBhA0QdQAMLbT01FBtvogBtgx0DelCBCgtYOsQ3CoQLoSAzqV+YLahGgWM6gVxRMASDIk8cD5oSiABDMjsCBwsBAQMJhUYBAYNagicBAQ
x-amp-result: SKIPPED(no attachment in message)
x-amp-file-uploaded: False
x-ms-exchange-transport-endtoendlatency: 00:00:03.1197354
x-ms-exchange-processed-by-bccfoldering: 15.20.6813.027
x-ms-exchange-crosstenant-originalattributedtenantconnectingip: TenantId=3f4057f3-b418-4d4e-ba84-d55b4e897d88;Ip=[170.129.1.10];Helo=[email.microchip.com]
x-ms-exchange-crosstenant-authsource: CY4PEPF0000EE35.namprd05.prod.outlook.com
x-ms-exchange-crosstenant-authas: Anonymous
ironport-hdrordr: A9a23:HSCSd6BUwr1QplDlHemp55DYdb4zR+YMi2TDGXoRdfVwSL3+qy
 nOpoV+6faQsl0ssR4b9exoVJPufZqYz+8S3WBzB8bGYOCFghrKEGgK1+KLqVDd8m/Fh4xgPI
 hbAtFD4bbLbWSS4/yV3DWF
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;auth:0;dest:I;ENG:(910001)(944506478)(944626604)(920097)(930097)(140003);
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YcODbPJqiRgc/QhjY6mawn13lsO8BRymyjt1YqH2jLk0eFlskmFQXhdKyq0V?=
 =?us-ascii?Q?QnWOzrp3TOMbMqd6wx7fo8y3N6sC4pwd1X/2IlhH5IOj+gBZVcYapzgOZHgM?=
 =?us-ascii?Q?ckyje7k1DBaqr93hI/mTkNx73JdeojY0bdT5ELl9RZbCUL22MzorvbFWNNQ0?=
 =?us-ascii?Q?FMF8htK5e+4SwhpR/q26K9r+7HNC/wtinXy+vIO/0Obk7d3xPO7dn9ShFol9?=
 =?us-ascii?Q?bSA4Ov4NycsDMvUFPx3FgvOt41lqE6QNY4FHkWeC9byQ1/wlC21rgWrK2Hyh?=
 =?us-ascii?Q?cOa5XgGVnhfwv30MMkKyRBFvuiI8Vodbrz6FrCEduQ793hVsJHllevcbQRBz?=
 =?us-ascii?Q?A8sgjbVfq4JHtDPRjNnx3ZYluWsQfb+19kgtvhwv0k8ajw5S4B8r7Yuswvh+?=
 =?us-ascii?Q?bqkZf29i9DoCQDtysoCS1XsQ156njhC/My72PDBcBvYQ7dgUi4aKwFDE5qSy?=
 =?us-ascii?Q?zoh7MmHMTqww44RzvvVgHrtjWLf/EZ52VylznpvbR2SKiCCVm+61gt1zf0kF?=
 =?us-ascii?Q?xcnENoFImBzWinFU1CZ5u+i0jLc7IjSUV69+1Q6G7HaIqTxhjqR1x+aoxDLy?=
 =?us-ascii?Q?qFgbZfMIa8jWhli4uUWfyf3bkqxbwAApbVS7wENvrWCskk8I1/gtrBOPen8J?=
 =?us-ascii?Q?IGId10zHO9ZlMtZ3BLzW7NkAbrfs53qRH1xhCcoocRr3FTdEmeQoZm5ThNkh?=
 =?us-ascii?Q?/7tZ8zL4MUeYPKwAF+T8yr4pasPTMse2m8vnIq4pSf8MojLnqhNQhBLOshJK?=
 =?us-ascii?Q?kkhQn9wJUlTOEmP1ySA7tZXyK03ehmSMvR28tgcFZ1zcCaXMt6b7x5LB4f7Q?=
 =?us-ascii?Q?AreOroEXWn1jZOfMh/1aNF0bjrtl6ixAB0Ws8/KlJPmHOFS/vZcJL0mfTOe4?=
 =?us-ascii?Q?SLkYKEZbg4GCou85g9JnPxwCzFw2ymAB8Vv3rOQG6LXVo52C44lm0PZmphEj?=
 =?us-ascii?Q?7lesBEFH2CsfgaKihUML35zsh4nf6xtZNzgxMjLiiASJPr4bv/b9v2aVDkvE?=
 =?us-ascii?Q?B9KKBkwMGCZreoxESPhsFCv0PoqOFXLVQqAjIUdQmDRaD6ZqOoWhHY+MT2m+?=
 =?us-ascii?Q?n09dTAbDYnZkygWS//Ir2v3VxNFaUhfz0SBwBMoM44suAjNvFm2974Orptqg?=
 =?us-ascii?Q?UDMpJG7yatrXpNJZgtuSnAPPDZuicDkVyzlN+jLAc7y1ra08ME0UbA55POUa?=
 =?us-ascii?Q?dhDeifvZA4JV6vjSPG7LILuzqjCcBA45CwnhFs4CRCXWvn0ToQk7Rj0O8w3w?=
 =?us-ascii?Q?JcmDuUiQpvvIxj88egOdARJRdFwyiw0f0afINWMKw1+6qIvvGQHMIE+K4c8C?=
 =?us-ascii?Q?3J9ZGnJSGDkKTdyiZRwx9PUkmhQ9akm0aQ5XMSUII5ZLPxdTTKAtJVSeIZIq?=
 =?us-ascii?Q?BBlTcWDggblMp2BXX4Nfnby9H/lLoCUwmMsbvJDdTmbXbBa2S7P/zmX9Lxw3?=
 =?us-ascii?Q?lfakEp6RODS8gh3g1MA+M+w92PtZK49sHP25UaN2wsnaae9QkyYp2A6DXOeO?=
 =?us-ascii?Q?b3b1aq/K0ePiQy4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9FA47BBD27E7CB4CB16656F432ACE1F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

On Tue, Sep 26, 2023 at 06:28:18AM +0000, Raju.Lakkaraju@microchip.com wrot=
e:
> - As you mentioned in another thread (about phylink bindings) a few
> days ago, our current lan743x driver using phylib has a dynamic
> failover dt -> find_phy -> fixed phy sequence.

You mean this:

        /* try devicetree phy, or fixed link */
        phydev =3D of_phy_get_and_connect(netdev, adapter->pdev->dev.of_nod=
e,
                                        lan743x_phy_link_status_change);

        if (!phydev) {
                /* try internal phy */
                phydev =3D phy_find_first(adapter->mdiobus);
                if (!phydev)    {
                        if ((adapter->csr.id_rev & ID_REV_ID_MASK_) =3D=3D
                                        ID_REV_ID_LAN7431_) {
                                phydev =3D fixed_phy_register(PHY_POLL,
                                                            &fphy_status, N=
ULL);
...
                ret =3D phy_connect_direct(netdev, phydev,
                                         lan743x_phy_link_status_change,
                                         adapter->phy_interface);

> My understanding is that with the current phylink support you need to
> specify ahead of time whether you will be using PHY or FIXED_PHY
> support and cannot fail over from one to the other, which will break
> the current support we have for some of our customers.

This is not actually correct - the fixed PHY support hasn't been used
with phylink because we have a better solution in phylink itself for
fixed links. You rightly point out that this assumes that we've parsed
DT which tells us whether to use that or not.

However, this is possible:

        /* try devicetree phy, or fixed link */
        ret =3D phylink_of_phy_connect(pl, adapter->pdev->dev.of_node, 0);
        if (ret =3D=3D -ENODEV) {
                /* try internal phy */
                phydev =3D phy_find_first(adapter->mdiobus);
                if (!phydev)    {
                        if ((adapter->csr.id_rev & ID_REV_ID_MASK_) =3D=3D
                                        ID_REV_ID_LAN7431_) {
                                phydev =3D fixed_phy_register(PHY_POLL,
                                                            &fphy_status, N=
ULL);
...
                ret =3D phylink_connect_phy(pl, phydev);

The reason this should work is because the fixed-phy support does
emulate a real PHY in software, and phylink will treat that exactly
the same way as a real PHY (because when in phylink is in PHY mode,
it delegates PHY management to phylib.)

Using fixed-phy with phylink will certainly raise some eyebrows, so
the reasons for it will need to be set out in the commit message -
and as you've dropped Andrew from this thread, I suspect he will
still raise some comments about it.

In the longer term, it would probably make sense for phylink to
provide a mechanism where a MAC driver can tell phylink to switch
to using a fixed-link with certain parameters.

--
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--_002_PH8PR11MB79655D0005E227742CBA1A8A95B22PH8PR11MB7965namp_--

