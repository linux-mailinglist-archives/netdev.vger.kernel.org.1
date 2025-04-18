Return-Path: <netdev+bounces-184094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AE4A93511
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BDEB1676FE
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D626F44C;
	Fri, 18 Apr 2025 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gVdBAYHa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F226E17A;
	Fri, 18 Apr 2025 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744967079; cv=fail; b=NU1QuFZMvslQR7dnqUzNbUkK7x7oo6ZCURTlXJTGhu1dcUOaj1k70hgCe6BpUOZJwzmCh66hSDnuKjJHYp/nkmWUtk/9JxGaM2odXnztmn0wQ5n2RR2kfc2Qf+7ITF4+ToGvxyqnYLpTewGrfbYJSj5dAIWemm6IWindhV1Bx4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744967079; c=relaxed/simple;
	bh=zzP1PBiWOmfvN9XoNTTlaxx7HLMJNX+qE3H7BZzSi70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/Aa6i08uOLwp1epZ6P6lmS00FeTEthID9wvyvT0TrJsoeFt9Foe9184ZamksfBvQGm1l/oPnVdGNxA/D2ztITek6T4VsSybKFUYTWlD59EzUvTr/g5bsidolvFYe+YdL+CohiIO9/5n5zVN8pEIBz6pUZxym8FIIn46061ZmEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gVdBAYHa; arc=fail smtp.client-ip=40.107.102.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePRCgIHqRd8axIN8vCdj/31h7Fps6f5mJ3siwj+GNQQUxAtdBMFmjT7fzdAgBNK5H/+9md8BSr86xuaSKd5x8STzD2cjb8F5uMZSmtYV60LQrXYqiJw2f4mD9YQr/iZibhYtP+ivfayFWc0BUvgid2tKx8lcsoOibokLpLiFv74oAqhkwFsWbljmyYzpeK625OdHxMPQmbXIn6OUthnm3weeCUgp5L/rRQzFSLnptd0HmRn+02V7371/IG8WtPKMeQ89+nRkbLzjuO39UbYvpswt6+YinDhQxwPsxE0zTrXxuIKaQLslMuR2USLVNFBh9WfWsSeEJyUpcO2FeOJWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgNZO51cE073xhtN1qRfxG5f9g5dtcyayw6TrvoJFrk=;
 b=AbsVwpR7ZTfVP0w/SOxT5P7gjVKPqKlyT4DcX2rKnbRJPky5xcwAP4y1ZJis2W8pwOqS4gz0+ZnnlA+BHZGMPgxdunYeeLmq7hTg6nclA+AndBy2Zo9gvEGim4x15q6+z86/8sOrTuMeToLk3nyk4wLsL0YM3PiTXDYnQDbkCMm3h/5PH/L5H7bFJknO/IuWBJ90uyQkwdM848CAge6LeIGVqhlQFTiHTdR05QNv3EkcGG3GIyK/YqlScsLkrUZfAL5hFGRKI/sQ3VRR+2FJZXfdFI9X+7W3ZxNbCul93GHyuyHWiyu6j3Sa+EiaYEUbNoY7eILEG+tbNYav6tx4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgNZO51cE073xhtN1qRfxG5f9g5dtcyayw6TrvoJFrk=;
 b=gVdBAYHafoESh0eP2kTJKBnSjOf55bxBCSjHCsSFoHk5Zib1xUp/qi/rDhXYcs8ZjvISZGMlqIavKTOwqPa7tv5wFWgKpQ55pCXY6V3cHPBW7On7iJ/QI6g7cy6qxOk7g5XHQVeP15L4RYKvPhCvBoBnySYTMtq2gnv/JGN7JmI=
Received: from BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 09:04:35 +0000
Received: from BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6]) by BL3PR12MB6571.namprd12.prod.outlook.com
 ([fe80::4cf2:5ba9:4228:82a6%4]) with mapi id 15.20.8655.025; Fri, 18 Apr 2025
 09:04:34 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>
CC: "upstream@airoha.com" <upstream@airoha.com>, Christian Marangi
	<ansuelsmth@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, "Simek, Michal"
	<michal.simek@amd.com>, "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [net-next PATCH v3 08/11] net: axienet: Convert to use PCS
 subsystem
Thread-Topic: [net-next PATCH v3 08/11] net: axienet: Convert to use PCS
 subsystem
Thread-Index: AQHbrj1bMM94Lp9E+ki+Dl54jkuffLOpI3Pg
Date: Fri, 18 Apr 2025 09:04:34 +0000
Message-ID:
 <BL3PR12MB6571383CDE95A1E40597CE78C9BF2@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-9-sean.anderson@linux.dev>
In-Reply-To: <20250415193323.2794214-9-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=09d05ed7-7c47-4e46-a3c7-915e52a0cbfa;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-18T08:57:51Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6571:EE_|DM6PR12MB4090:EE_
x-ms-office365-filtering-correlation-id: 2c8a5e6c-2ec7-4632-629e-08dd7e580a1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EZfBrhkJBCKnsd5RzVWa+DSNH12DWe/uGDPt0gkt+AQ0A9O9zPZj+Y3kN64I?=
 =?us-ascii?Q?ATkUUGGZhDVXMS28cnoM7LZ/qCf7mKzcVMB2UeE+C8liytZmG1nbPTDytBIb?=
 =?us-ascii?Q?8YukPYvCEDqmumrxEttVhOnYTENMjWw4BgTYh1YycR7500eNnxcIn1r6GMaU?=
 =?us-ascii?Q?XT6qTgiQtc7GLMtQ5gqHsqfPvtOBqIYtkjlG9quNuIRAiS3EbtSt5lBY89x0?=
 =?us-ascii?Q?ts0MjlyIQax20MeRkcWrABj+WdQhVbOfv0KOtx1pa5SUK/g3/ERulPEIEO1r?=
 =?us-ascii?Q?+ErZFVUbrhPitwsZZGy/qHuj6URihIUi0a4WS0N1nQ3lfSnCguor8Vs3t0s7?=
 =?us-ascii?Q?K13hanOJtFWZVeja4XeH+f0NYnel1SUMHLmd6UYKdn8uGQQsH7FFz7wIb+ya?=
 =?us-ascii?Q?vUm8/OAP97nOVwHP9v1ueon1aTtyTCllMRQhCzrYnvxKdg/fzDLs2EK9AWsF?=
 =?us-ascii?Q?WqPp/kZRC92PSyOJ10VSffKMxVKrViROd1pLeAP4uWnX25RS+f2kY6GJz4Tw?=
 =?us-ascii?Q?HAEfro9zrPGC6S18EoEo0XSF26N2Ftzi+yMFtoCEg6oZL9m6qs2jUuhmRzA7?=
 =?us-ascii?Q?XnozZWgjaqKUlE6TN1t0lDx4ZjUodZqnAkd/dteYIe04Y5QCQhOTc1KCeBzB?=
 =?us-ascii?Q?2fWShhFhckHMIWV0NsxtVz9zcfYk3Uw5SHHQiwEWeG2TBRc8RYVjPnFMDvqr?=
 =?us-ascii?Q?pD9b8PX5lI3oGz3b5y1h82o9M1j7yBqA19T+YjX0ulrRxoorQKrNREC1K/nY?=
 =?us-ascii?Q?pZT2jNdux9OzNL4Q8OCtaX4Xwe8vi91d7WYoiiOsbXP0kpUUWLlIfwhkGXlt?=
 =?us-ascii?Q?2wOQG8bKqLWbOXgUalXb2Vx1dHcemzICfpV9fI6suazuy3IFcQTk0MfqQK7+?=
 =?us-ascii?Q?MMndamJdqCEOzMGha7dBPX7gZ+HB6dsdDnySEhgc+AJ9afQ59pYdVnUU5APo?=
 =?us-ascii?Q?jg2ov4bWSVruUjzBYJDC1TM8s/ikXyFFOI+N7agF2O4tVGg9+GE1jVv3u4wB?=
 =?us-ascii?Q?AuPFIDHGgc0yurLxxoW0kWvDj53O4vbkc8M5QX3QpzCJWcJo00kgG49RlRvr?=
 =?us-ascii?Q?bY5tJOdkyC882hbrj7jD2yGe0OIJpmHi8dIDOvoJG/TIH+O9yV7O/lYamI8m?=
 =?us-ascii?Q?v35AV01NKAVEhx7LUKXKYOK3CiLoI7IFDl6iuzOK5XP4yczqIhQ9YCAc3Bhl?=
 =?us-ascii?Q?SKCq+RI2TBAq6kvgZrE0trkEg+/tPv2RYdqZKfUAc5u3eQANMVMBy2aQp3nH?=
 =?us-ascii?Q?UkiPANKOqBZyyf2emx7mtQ4LzgSaCXUPrVxOuV8rrZHcmTQIFNjuGMLbHlat?=
 =?us-ascii?Q?vrESF5pQ7yOAkV7Ou3KE7p+FdpO4S5Y/aCOBgGauXbgAAZHqUweJHi1KixMR?=
 =?us-ascii?Q?1hRjdKN34Lodo8R4qBQK1OrUXzyt4sBw/1WXQeY2ZmLOjhugNZtAYkkLLash?=
 =?us-ascii?Q?/co/p6WNZnZNFC2tl5ZomwrXj3UVpqFgvDP9yyGfwW+vqTITKsVFLQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6571.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SpO6xl4KWByUHz1ArVHselsfK6rUhjRybah/Z/L2L1izP6s70afgb9uy6cQL?=
 =?us-ascii?Q?HENepiGu4SUoB9yzOjHKye1nBeamREoqVV5Xn2d+t0FYnbLpuzcATob1n212?=
 =?us-ascii?Q?twzj3Di7aX3D8GZWeOQ5ymTp8SxyUpz3gfT6v582Fh6AbuDJcuZvYYtFiq5s?=
 =?us-ascii?Q?oujjW5zZtesZpoH8lGilbFn6QLiv4CsAcTC/8sIiybNO0+wcombcIuqDH6Pm?=
 =?us-ascii?Q?1d9pxDnF5hGRyEW60nn1F9T/J66+Dx8soiL/TyUEVeInUxhgcMr/otJIBWBa?=
 =?us-ascii?Q?ONoTGwau4wVM4Emxe2ua26bHTEXVVOQx8j8Z70tFHCSi6wwfqZ3TZn1peeim?=
 =?us-ascii?Q?aU6RD6oY7XzYrYPlgPAYoiUlNGepP9u9MGDgRjBeABO9zoEe+GxSa3PvO4SP?=
 =?us-ascii?Q?6usQBNAC5fM2HdqqK8Psz5H5EvGHW8w7lCMR4weN7BE9xTxc7bClOAMakO+n?=
 =?us-ascii?Q?4nQwOyJTZ4FIuE6Iwci9KHAGUmn9Z0KiIIaAqQWuvQ3RGf/4AZxCTc+eWMzT?=
 =?us-ascii?Q?jMuoiZo/Lwbf2UQMiUK+Tzoz4viMa0O9/c2vEjeXdKpCTJHuVKzXvhjEQMsq?=
 =?us-ascii?Q?UrUf0eyxx58ZzTWuu0sVNXjNkUMFCsgj71o6zXroruX7knfmvMj/MkI7T2Ju?=
 =?us-ascii?Q?CbAGSISBp0i+iUJ1hG44hV8+3ZU3diq0MqwHNStyf6QsR1XluZ3orIRAK5Aj?=
 =?us-ascii?Q?LsqgQNMDcOwmkWJ4+/nN2Yjh9qAufBuBZYlEZJHZBu7XmC24+tusIGLXwHXO?=
 =?us-ascii?Q?q09kYYegS0ynMuNAaBtIaYFEkFzMjf7m75YJlSVoNd803v8n42Qbchlo7PnW?=
 =?us-ascii?Q?u4AIcobk8FwL9tbMZifQzfa5tdSyqTDDkjvS4BYylf6RRiQejKfz5QKzqC9J?=
 =?us-ascii?Q?+L1Ph0JNnMRjCvqOjtOjOrtgAp+u15jYBDLDgLekRntXf2rjxMiPQzOnKcxR?=
 =?us-ascii?Q?tAIqqteeuKUh6wEX96GrJcoWru6WZ2v5S2fm0G97ZlVhONFzyemalY/MUIz/?=
 =?us-ascii?Q?e8mc9KrUaM/DwcwlJRT4Yw866xaMPX8GeURPmyxQbhQgryhi6zp+5R35tGRU?=
 =?us-ascii?Q?i9sCHhaYDvOJJBEei7uxVYVEXvWarTG+LNVh86H/UJOFanuBaWtsxmXThNvX?=
 =?us-ascii?Q?D7q8R5l/HQYvySboSY7RYdTCDXDijoEOeZfjMQxWpai+tUq2jrjrVeaAjPrP?=
 =?us-ascii?Q?bofdSrVqzJm2j8+Tui9RtDvueEKkh8ue4R1c4kOH5AupIR3eYEzAP+Aekwaf?=
 =?us-ascii?Q?aVqJI8PxXxzDqr5Ggc/mzvi3/sCa+7QQjY3Beo8WAyahAcu/2kr4i8i9mEyn?=
 =?us-ascii?Q?kSBmO33wwvgms7XjPrR3InwudM3IBNaC8QihhnWtafaoMU56WLnbzkP2fUin?=
 =?us-ascii?Q?bF3Z5vbUdQtS1Pe1sXm87ASoPROGgQ6Timg6JQmBGu4zQwwaWdgd2SLtRlKj?=
 =?us-ascii?Q?EeuLiEES85OsmVngDjn9ycLILZakTKPFFg4WsTdGEWR6sYiM1+e3eweu32nn?=
 =?us-ascii?Q?sESF0xkA9ML3zfVEyKWRk3kd3vRXrEmCjjhjnE6Uik86WV7HCKDseHJXQrNb?=
 =?us-ascii?Q?WjkDcoQGSKItZE1L6yM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6571.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8a5e6c-2ec7-4632-629e-08dd7e580a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 09:04:34.8092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGati5mhNxnE9alSpEpRUr3REhUbMaiXG3gptxus+NMImoseVQQRVyqx5HXIUk9ujv3HuRXcfb2/WqP/2r24zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Wednesday, April 16, 2025 1:03 AM
> To: netdev@vger.kernel.org; Andrew Lunn <andrew+netdev@lunn.ch>; David S =
.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Russell King
> <linux@armlinux.org.uk>
> Cc: upstream@airoha.com; Christian Marangi <ansuelsmth@gmail.com>; linux-
> kernel@vger.kernel.org; Kory Maincent <kory.maincent@bootlin.com>; Heiner
> Kallweit <hkallweit1@gmail.com>; Sean Anderson <sean.anderson@linux.dev>;
> Gupta, Suraj <Suraj.Gupta2@amd.com>; Simek, Michal
> <michal.simek@amd.com>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Robert Hancock
> <robert.hancock@calian.com>; linux-arm-kernel@lists.infradead.org
> Subject: [net-next PATCH v3 08/11] net: axienet: Convert to use PCS subsy=
stem
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> Convert the AXI Ethernet driver to use the PCS subsystem, including the n=
ew Xilinx
> PCA/PMA driver. Unfortunately, we must use a helper to work with bare MDI=
O nodes
> without a compatible.
>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>
>

Tested with ZynqMP AXI 1G ethernet design. Ping works fine, and netperf num=
bers are as expected.

Tested-by: Suraj Gupta <suraj.gupta2@amd.com>

> ---
>
> Changes in v3:
> - Select PCS_XILINX unconditionally
>
>  drivers/net/ethernet/xilinx/Kconfig           |   7 ++
>  drivers/net/ethernet/xilinx/xilinx_axienet.h  |   4 +-
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 104 ++++--------------
>  3 files changed, 28 insertions(+), 87 deletions(-)
>
> diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/x=
ilinx/Kconfig
> index 7502214cc7d5..9f130376e1eb 100644
> --- a/drivers/net/ethernet/xilinx/Kconfig
> +++ b/drivers/net/ethernet/xilinx/Kconfig
> @@ -25,8 +25,15 @@ config XILINX_EMACLITE
>
>  config XILINX_AXI_EMAC
>         tristate "Xilinx 10/100/1000 AXI Ethernet support"
> +       depends on COMMON_CLK
> +       depends on GPIOLIB
>         depends on HAS_IOMEM
> +       depends on OF
> +       depends on PCS
>         depends on XILINX_DMA
> +       select MDIO_DEVICE
> +       select OF_DYNAMIC
> +       select PCS_XILINX
>         select PHYLINK
>         select DIMLIB
>         help
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 5ff742103beb..f46e862245eb 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -473,7 +473,6 @@ struct skbuf_dma_descriptor {
>   * @dev:       Pointer to device structure
>   * @phylink:   Pointer to phylink instance
>   * @phylink_config: phylink configuration settings
> - * @pcs_phy:   Reference to PCS/PMA PHY if used
>   * @pcs:       phylink pcs structure for PCS PHY
>   * @switch_x_sgmii: Whether switchable 1000BaseX/SGMII mode is enabled i=
n the
> core
>   * @axi_clk:   AXI4-Lite bus clock
> @@ -553,8 +552,7 @@ struct axienet_local {
>         struct phylink *phylink;
>         struct phylink_config phylink_config;
>
> -       struct mdio_device *pcs_phy;
> -       struct phylink_pcs pcs;
> +       struct phylink_pcs *pcs;
>
>         bool switch_x_sgmii;
>
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 054abf283ab3..07487c4b2141 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -35,6 +35,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/skbuff.h>
>  #include <linux/math64.h>
> +#include <linux/pcs.h>
> +#include <linux/pcs-xilinx.h>
>  #include <linux/phy.h>
>  #include <linux/mii.h>
>  #include <linux/ethtool.h>
> @@ -2519,63 +2521,6 @@ static const struct ethtool_ops axienet_ethtool_op=
s =3D {
>         .get_rmon_stats =3D axienet_ethtool_get_rmon_stats,  };
>
> -static struct axienet_local *pcs_to_axienet_local(struct phylink_pcs *pc=
s) -{
> -       return container_of(pcs, struct axienet_local, pcs);
> -}
> -
> -static void axienet_pcs_get_state(struct phylink_pcs *pcs,
> -                                 unsigned int neg_mode,
> -                                 struct phylink_link_state *state)
> -{
> -       struct mdio_device *pcs_phy =3D pcs_to_axienet_local(pcs)->pcs_ph=
y;
> -
> -       phylink_mii_c22_pcs_get_state(pcs_phy, neg_mode, state);
> -}
> -
> -static void axienet_pcs_an_restart(struct phylink_pcs *pcs) -{
> -       struct mdio_device *pcs_phy =3D pcs_to_axienet_local(pcs)->pcs_ph=
y;
> -
> -       phylink_mii_c22_pcs_an_restart(pcs_phy);
> -}
> -
> -static int axienet_pcs_config(struct phylink_pcs *pcs, unsigned int neg_=
mode,
> -                             phy_interface_t interface,
> -                             const unsigned long *advertising,
> -                             bool permit_pause_to_mac)
> -{
> -       struct mdio_device *pcs_phy =3D pcs_to_axienet_local(pcs)->pcs_ph=
y;
> -       struct net_device *ndev =3D pcs_to_axienet_local(pcs)->ndev;
> -       struct axienet_local *lp =3D netdev_priv(ndev);
> -       int ret;
> -
> -       if (lp->switch_x_sgmii) {
> -               ret =3D mdiodev_write(pcs_phy, XLNX_MII_STD_SELECT_REG,
> -                                   interface =3D=3D PHY_INTERFACE_MODE_S=
GMII ?
> -                                       XLNX_MII_STD_SELECT_SGMII : 0);
> -               if (ret < 0) {
> -                       netdev_warn(ndev,
> -                                   "Failed to switch PHY interface: %d\n=
",
> -                                   ret);
> -                       return ret;
> -               }
> -       }
> -
> -       ret =3D phylink_mii_c22_pcs_config(pcs_phy, interface, advertisin=
g,
> -                                        neg_mode);
> -       if (ret < 0)
> -               netdev_warn(ndev, "Failed to configure PCS: %d\n", ret);
> -
> -       return ret;
> -}
> -
> -static const struct phylink_pcs_ops axienet_pcs_ops =3D {
> -       .pcs_get_state =3D axienet_pcs_get_state,
> -       .pcs_config =3D axienet_pcs_config,
> -       .pcs_an_restart =3D axienet_pcs_an_restart,
> -};
> -
>  static struct phylink_pcs *axienet_mac_select_pcs(struct phylink_config =
*config,
>                                                   phy_interface_t interfa=
ce)  { @@ -2583,8 +2528,8
> @@ static struct phylink_pcs *axienet_mac_select_pcs(struct phylink_confi=
g
> *config,
>         struct axienet_local *lp =3D netdev_priv(ndev);
>
>         if (interface =3D=3D PHY_INTERFACE_MODE_1000BASEX ||
> -           interface =3D=3D  PHY_INTERFACE_MODE_SGMII)
> -               return &lp->pcs;
> +           interface =3D=3D PHY_INTERFACE_MODE_SGMII)
> +               return lp->pcs;
>
>         return NULL;
>  }
> @@ -3056,28 +3001,23 @@ static int axienet_probe(struct platform_device *=
pdev)
>
>         if (lp->phy_mode =3D=3D PHY_INTERFACE_MODE_SGMII ||
>             lp->phy_mode =3D=3D PHY_INTERFACE_MODE_1000BASEX) {
> -               np =3D of_parse_phandle(pdev->dev.of_node, "pcs-handle", =
0);
> -               if (!np) {
> -                       /* Deprecated: Always use "pcs-handle" for pcs_ph=
y.
> -                        * Falling back to "phy-handle" here is only for
> -                        * backward compatibility with old device trees.
> -                        */
> -                       np =3D of_parse_phandle(pdev->dev.of_node, "phy-h=
andle", 0);
> -               }
> -               if (!np) {
> -                       dev_err(&pdev->dev, "pcs-handle (preferred) or ph=
y-handle required
> for 1000BaseX/SGMII\n");
> -                       ret =3D -EINVAL;
> -                       goto cleanup_mdio;
> -               }
> -               lp->pcs_phy =3D of_mdio_find_device(np);
> -               if (!lp->pcs_phy) {
> -                       ret =3D -EPROBE_DEFER;
> -                       of_node_put(np);
> +               DECLARE_PHY_INTERFACE_MASK(interfaces);
> +
> +               phy_interface_zero(interfaces);
> +               if (lp->switch_x_sgmii ||
> +                   lp->phy_mode =3D=3D PHY_INTERFACE_MODE_SGMII)
> +                       __set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
> +               if (lp->switch_x_sgmii ||
> +                   lp->phy_mode =3D=3D PHY_INTERFACE_MODE_1000BASEX)
> +                       __set_bit(PHY_INTERFACE_MODE_1000BASEX,
> + interfaces);
> +
> +               lp->pcs =3D axienet_xilinx_pcs_get(&pdev->dev, interfaces=
);
> +               if (IS_ERR(lp->pcs)) {
> +                       ret =3D PTR_ERR(lp->pcs);
> +                       dev_err_probe(&pdev->dev, ret,
> +                                     "could not get PCS for
> + 1000BASE-X/SGMII\n");
>                         goto cleanup_mdio;
>                 }
> -               of_node_put(np);
> -               lp->pcs.ops =3D &axienet_pcs_ops;
> -               lp->pcs.poll =3D true;
>         }
>
>         lp->phylink_config.dev =3D &ndev->dev; @@ -3115,8 +3055,6 @@ stat=
ic int
> axienet_probe(struct platform_device *pdev)
>         phylink_destroy(lp->phylink);
>
>  cleanup_mdio:
> -       if (lp->pcs_phy)
> -               put_device(&lp->pcs_phy->dev);
>         if (lp->mii_bus)
>                 axienet_mdio_teardown(lp);
>  cleanup_clk:
> @@ -3139,9 +3077,7 @@ static void axienet_remove(struct platform_device *=
pdev)
>         if (lp->phylink)
>                 phylink_destroy(lp->phylink);
>
> -       if (lp->pcs_phy)
> -               put_device(&lp->pcs_phy->dev);
> -
> +       pcs_put(&pdev->dev, lp->pcs);
>         axienet_mdio_teardown(lp);
>
>         clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
> --
> 2.35.1.1320.gc452695387.dirty


