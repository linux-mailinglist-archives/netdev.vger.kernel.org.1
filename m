Return-Path: <netdev+bounces-244922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EEFCC2746
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 12:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5012E3020C27
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6297355037;
	Tue, 16 Dec 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1xE751hN"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FB935502E;
	Tue, 16 Dec 2025 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885985; cv=fail; b=eKUkS61h68bxsrxxwvbDnOAS1ue1+q6qeSBh1CVqCbiX/viubS+yz8iTlWl+gbOiV+LvbjkN2LtrXyG+QQEauOqwPKJxZqNIGGuQfyiuIhr7Xi69VJy5HLSgaj/1RfbGBFrHKC4Ei6Y2otOmR2la0QhDFlAFCXnEneZlQIquYaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885985; c=relaxed/simple;
	bh=DCXq77A1bC5U1LHBJ0x1feZ35vBwbpLtRATpG9SgxDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JbYRJjF1frzYcqZrepc3hBLYkergC+wP3/r2/gULgc590HYT+pfzQ4sBArZ69Iy2XLpeynmzPBgI+73mqM2jvFiqzWXQQDlSIWWeS0uviC92hl7WnPT9Skh7tlu262iTfKscM0POpuknkiw9dtOEZYon7JqtXWgLQPHKe9JJGJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1xE751hN; arc=fail smtp.client-ip=52.101.46.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOVsACo3sxZM6phT02v9NJmnr3SujvraIG6RxJqqS4RlLI/gIlVUKPcPDm4F9uOfKDuaxjlmlpt68A09c07LHWdo3FTgZs9an477Mt2O71JRouuVpofUIQvoWjXl7Z2bG8I3WhpKd8iRjcq8nXNbV/Pt0F6GoeCCBEcU+rb4WSlBd+QdxxUf1PBMlW6wcdq8nqyzp0T3x0IbTsMf3UKaEHW/yKLYz89iQGGo+l2du1b2EZvdnZ3ESR/60PfjZJrfr/6+tnleUZLP7TJ28v76txS4ad9P+C0HBr+ryk/CUiidi2ymxxICfoXZ9vodXmnz6Bkh+BnvKT6pET8nH924kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92IUoiyQ+g0wF3pP3KoCai+Z4a0aoeAZ+G6a7cNUhWo=;
 b=R2QSOf72XAa2wK0epAOZ+ctGZprVfN9pyNeNj4OrnQWpNvaGFECsTqIjqyCMlI2XhVSUPGVQYZaSIVtjQxJtlnfojFssnZfxmsHuo8Y+XYAhTP8VCs0yLVTR7dPW557y16Ff8Y/CPPblX0fvZvauUxKa+IXvd6ku51BRWe+p7FH7Kpz7dZPuG+BANq61HAelufjOvpV3CsjkQD8Ff70F0rqOErHVN82FQB+GvTwAIZtjgMssh7oeebp9VPm1zIKkzO8C1UaFxezSk1mDZRrdGxZDf9wdXz7YvEKRoepjbHi4XV7Mglz7UwwTa8B28F+6eGQA7PxJbL5m/z8C7SzvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92IUoiyQ+g0wF3pP3KoCai+Z4a0aoeAZ+G6a7cNUhWo=;
 b=1xE751hNJbkacsGAK0hUFbQ3NX7Yp1LdYmzaTuNsnCinE8i1yHXBhSva5EHoP+2VeezSPXo8D2WdUPVKcCNDNNAadN5TIqquKqtGYFzrXas2tUJ8R+bNLlWE3lYBFOLs96TV1meSbA3X9g2pQccbCaarZcw1R00UZKTOmXLXDMY=
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 11:53:00 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::8ccf:715:fdc4:8a14]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::8ccf:715:fdc4:8a14%3]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 11:53:00 +0000
From: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
To: Andrew Lunn <andrew@lunn.ch>, Sean Anderson <sean.anderson@linux.dev>
CC: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Simek, Michal" <michal.simek@amd.com>, Leon
 Romanovsky <leon@kernel.org>
Subject: RE: [PATCH net-next v4 1/7] net: axienet: Fix resource release
 ordering
Thread-Topic: [PATCH net-next v4 1/7] net: axienet: Fix resource release
 ordering
Thread-Index: AQHcBh6NB1zOK0xHhEe++mX6YOWKfrRUi1iAgNBro3A=
Date: Tue, 16 Dec 2025 11:53:00 +0000
Message-ID:
 <SA1PR12MB6798CD01D26F4A68D6F7A214C9AAA@SA1PR12MB6798.namprd12.prod.outlook.com>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
 <20250805153456.1313661-2-sean.anderson@linux.dev>
 <9572f798-d294-4f24-8acb-c7972c1db247@lunn.ch>
In-Reply-To: <9572f798-d294-4f24-8acb-c7972c1db247@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-16T11:47:32.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6798:EE_|BL3PR12MB6644:EE_
x-ms-office365-filtering-correlation-id: e9a3f3f9-7016-40d3-0e92-08de3c99a98e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SnipfefM609m6sWys95l/unkHDLvyoH9HR/XH07DMUoJHO9IZi0lKclrc8rB?=
 =?us-ascii?Q?n8OaJlWKt3/b4kOM1DSEchb8KyJbubaclGZPdOwdhKQgGcfDijyy1ZcDF4no?=
 =?us-ascii?Q?ZNTj1JPSK9nHSlSG94JYgb3NC64T8bLTKVhppkErSwlm+MxyFt2e+Urc7Ydm?=
 =?us-ascii?Q?6LmYDELhdhYQnxcPuW6mkQ7TWvwGXKLHa0pXOL/OMVVbXkwwSLrSeTxSosw+?=
 =?us-ascii?Q?ks88ovuV5F26hQ/Zh172+igR8f0gFRjRZ0OZdvcUB5ak8pxDAXLtw4wmy32h?=
 =?us-ascii?Q?BGARTx0ZrUO/MYlvke2EyS9NAZFl/UEJkpc8795LloVNyNyeN5pv3AuHENnQ?=
 =?us-ascii?Q?z8EVYEuoaYuFHf+kflfSNvjPu2bZkmiHXRO4sbSjF32VW7Tm/QpaN8rCE5CV?=
 =?us-ascii?Q?JGmR8Xpwi+pNRm6YyequIMFQcMD4Yg/YR8VheyluZMTxvE2awFO4i18+ZpxT?=
 =?us-ascii?Q?aoLbBHI4zbHm+0Ahshm+rZIjnhOM3BpoQ5q5xp4OR1nabDmph30+CkfUPtSw?=
 =?us-ascii?Q?4kNR4KRsofVR54mR68n/vKWFePk82NA7kQIZ5SvQKe1p6u9WnOnxCy0XZVxI?=
 =?us-ascii?Q?KYVEJm4UubARLEQ3VCX/U0uy1Fzkx4WHWq2dHITpDZsvPGzB3/0e4wecC1h5?=
 =?us-ascii?Q?hguVAQlKu+nSgCw1u2UH2SKPCl7ulJB7NstMc+lP1+BuA3F6TaqrXhFYxohN?=
 =?us-ascii?Q?WS6QJsjMcyM1wch3Bh0jMGtxLrgTWta/ignKTPBIQBmY+Vu1509+DvzaZXtu?=
 =?us-ascii?Q?tAUPD1bxlDtJ2xdTLZtscxAiItfIMEezkfgip97Mk2la3LzKgOwuqR6dLEvy?=
 =?us-ascii?Q?03TrK9miJl1+NGReocO4Jtr6eio1r1arEW8gMfmYs3kRv4HUdK+MquHhgdte?=
 =?us-ascii?Q?aa2DubSLxzpu6c57rualEaU0x2c104Na5H3MXKqwzwlpR6FoKWxZe60KPTqF?=
 =?us-ascii?Q?z9tiyJtxvWtMWJ6WvZXNcO8dKgifFwJ5NYvjx6yjgbYnnZoNMXV5lM0xehdj?=
 =?us-ascii?Q?y2qDNL6IC4pQ7Jys1lxRqU7uLA48oMXDb2aUUuDrhqhfKG1YXRdeOTEWPiXi?=
 =?us-ascii?Q?Wz+ooEVJN5jB/GKjNTEQ9IUPkG8n4Hy+QPgrTzWdzFn964WXQMXaY5/qVNSd?=
 =?us-ascii?Q?S8TLt+E9iup0Uv6BuyFZS2uCViFn3M5G4r4fRsp9g1Nt0hQ8BsY8qgILArYe?=
 =?us-ascii?Q?lt1dkp9zdj4cIBEPGoPFocdj76Vton9Jd9ObFgJ6+tIesrJRxQHQ/CE6Hu58?=
 =?us-ascii?Q?zJFO7HxS621muLPxgUcF8MhA6ryhE7t0S4u6qj1dOYkufrOB+VgHGTsUIdUE?=
 =?us-ascii?Q?XEm/kizbriFep39es3kc8nP2NKuw+r9aNC54usnANHXAPfpfAwkkyu2myInh?=
 =?us-ascii?Q?TYZ6fZz8kcHe5uqGxDGtkDW9HaW8Y4XfHTB2EMSaAdOA2vZ+yEmW8pnkUCBq?=
 =?us-ascii?Q?5mlNGfvywFTPuDenBZbbFr5hWELES3cC0JxL+I/gbKUNPp20sNqYOSOTHwhx?=
 =?us-ascii?Q?JQKtFtJ8BiUxO34s6h2M4HwpJ+3Ks6TmRez6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?b8dwEBgWnAy5yX9zP+O3tpMTnmguRkYWXNd6/stBbrfkAN4p96aQ7uTIb+B7?=
 =?us-ascii?Q?Bu8oYObkYen8OSsZY6gsh0+2GI4ngTaYBmtEVPDX0QpHEtV5ky6N8Dz8JBgE?=
 =?us-ascii?Q?ELlUNZJjivP9Q5h3qre/8UAoishD0cmNWrSX3VM8Ce0LqjUKHc1gVOjYWtat?=
 =?us-ascii?Q?cs0mH3kcca2aK0ZFdh0ZDPuhjX/7Kf7Chz7oE52+Fevhd9NvdeyP9tZ7aRaL?=
 =?us-ascii?Q?h51pIfJnHD7d+77/AJASeawOeZEsgH7YMhOQd2J40znuGdpLZDL5DkYGlLf4?=
 =?us-ascii?Q?FsNp9uyT5m2CGhAstjGU5uZUHJRR93SvXCTkkKmi8lHPkpsYKHZ0gNcNM4qZ?=
 =?us-ascii?Q?5r9lUXDDks6/gu0/ZfW7BcWb3FraCw+yhWKeiN6K7DXT7SHty1CLlwK02TKy?=
 =?us-ascii?Q?VzI3RmipwqlBieV2i5ys8Pm2O69j/h+oU+4o6quAAX7pRonSK6EhRMaqV9Tx?=
 =?us-ascii?Q?FpjwshLrtbN59+JHQ19bczZnpxw+e5zBqy5eUo8SbXAnvKbCa7rH5kWCYu89?=
 =?us-ascii?Q?V73hxOGgtgNjtiuGV1Oz7r0gnXFl79eC6cSwnldT/H20JKlaEJVSK6jgYkxo?=
 =?us-ascii?Q?aaF1izQWDiW0NsC7cCJ0jg9QpKkk8gkTPk7TOwmYhov8is53ik7dzI+7qaDg?=
 =?us-ascii?Q?gN1+zQA6zpP0rFBfn0H/Ayj+G1nTfyDXR1beNp5LND8VEtHsyCKBwqWuomzm?=
 =?us-ascii?Q?whsOJq3zbqsVXMHfWWfKvzFFNuLydMF6oXuKZyjAsFUh9nb91otsBZe1sgeq?=
 =?us-ascii?Q?wK8k5ZsFHbyuZHDT61rNaaVCmjXt97x4E9WE5hkNig8+il53YgDpY/6r6VaB?=
 =?us-ascii?Q?BCh4ZYTobKbHNzgl9I44TW6D9tEPIR43mt+4xdnJtW2pigIx084WGeZzzYa9?=
 =?us-ascii?Q?ak7iP5Foy/BPLyVTl9DXV4hEdb1s4VYk60RF2ZnIK2nO7tt/pWWCm3TW5NYo?=
 =?us-ascii?Q?IJr7ylW6b8gtgbLHDSyT+fKzMfFPyzYLGncbfBMLivTqSXV0D2rWI8jm8IKx?=
 =?us-ascii?Q?Z4nPYuByulnsxNFl3RB1yOI5WI1vzNpEd5ZKoVA0IsCsRnzxhpCfwEJ+yYmD?=
 =?us-ascii?Q?OVSLaDbaS2pfeHe1UO0FQDuhSV6KFgzsPJWTk9vRaXcPghoZQnSCFMZjV5FX?=
 =?us-ascii?Q?Ju/AYiOyfPnNhSwM1lIdiA5kdFZTV9ikxRm4HLd7l2mAWz+hdRbf6Dqzd1Xz?=
 =?us-ascii?Q?yHYmK0FckNTaGSBAIEI5rWnyBWWlOoDK9kztv+kbA5F1Y6ag47WsqM/2eY60?=
 =?us-ascii?Q?DR2vTM2/FuciETDiSL4ThPBBHSWHaXJBDc/LFJi14e8eeQDEzHjPJMSQJr2U?=
 =?us-ascii?Q?2w6XJM1FMkeLC/3GvNVt6eRDgKYDFEloOjaOq/FZ+yE4uz1aAcLOOptt9Hgo?=
 =?us-ascii?Q?90Q1E6zWrx/bWvg9iySZX7zKh2R1O7j9U5GVPlBZZzimVMpfyCoylQqWoi26?=
 =?us-ascii?Q?IGeyvjjqGZuJbjNELuGWZrZHavkzLpia8NQ2p1DbKIRa/UzxasBHTDXl+RE/?=
 =?us-ascii?Q?B2D8XRkFDer6qUrMDeU7Kr8XjnSjbl3GH+LsgiKjTrpDVaADxzPoKGor+Z+j?=
 =?us-ascii?Q?3f3XrIIUC2LKL4L55Ao=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a3f3f9-7016-40d3-0e92-08de3c99a98e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 11:53:00.5071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teUc3EDzycXnewLsefIZ6H2lmJWZFBPW7QBGi8M8851L5BVMQDhzMJhp+db52Oz78X0rAu7gplUZ2ie2mKt3HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644

[Public]

Hi,
> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, August 6, 2025 2:29 AM
> To: Sean Anderson <sean.anderson@linux.dev>
> Cc: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; netdev@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Greg Kroah-Hart=
man
> <gregkh@linuxfoundation.org>; Simek, Michal <michal.simek@amd.com>;
> Leon Romanovsky <leon@kernel.org>; Gupta, Suraj <Suraj.Gupta2@amd.com>
> Subject: Re: [PATCH net-next v4 1/7] net: axienet: Fix resource release o=
rdering
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> > +static void axienet_disable_misc(void *clocks) {
> > +     clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, clocks); }
> > +
>
> ...
>
> >       ret =3D devm_clk_bulk_get_optional(&pdev->dev, XAE_NUM_MISC_CLOCK=
S,
> lp->misc_clks);
> >       if (ret)
> > -             goto cleanup_clk;
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "could not get misc. clocks\n");
> >
> >       ret =3D clk_bulk_prepare_enable(XAE_NUM_MISC_CLOCKS, lp->misc_clk=
s);
> >       if (ret)
> > -             goto cleanup_clk;
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "could not enable misc. clocks\n");
> > +
> > +     ret =3D devm_add_action_or_reset(&pdev->dev, axienet_disable_misc=
,
> > +                                    lp->misc_clks);
>
> It seems like it would be better to add
> devm_clk_bulk_get_optional_enable(). There is already an
> devm_clk_bulk_get_all_enabled() so it does not seem like too big a step.
>
>         Andrew

We are interested in this patch to fix AXI Ethernet probe path and can coll=
aborate on upstreaming it.

Regards,
Suraj

