Return-Path: <netdev+bounces-151065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FF39ECA2C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8912A1613CE
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2BD1ACECC;
	Wed, 11 Dec 2024 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="jzwVbHdA"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2045.outbound.protection.outlook.com [40.107.103.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1871EC4F4
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912345; cv=fail; b=URNPDleqUQTw3JTU4FChQNFirlrqGV4gnnkgQjEP0W+LuA1eg8nDv1xybkSl0UgvQ5Ar6GBI7Wic/IZKKCgs21lb+/+0qEE95uHmNq3iCZQTvv9n2PUrMrKRstXVfvTj1ZxZ0DiwPTVcAubXlXhD/GgMBAKd4GfkJ05rPoH/NAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912345; c=relaxed/simple;
	bh=ad/M4YEHJFtLOHpzQhFM2oPDLlxJzeN10+SB8z0IVQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgWU3vjSNyhJqz5NeDMgGb//UU3Lfam89ItgOvYogTBerHjSAch4V8V9uhtFM9OmJAfP8XkQWe/pbsOyf+LSR0AzD5C4LXtcHN5iAXrbtE+gLy+/h6Dkfl3SYDRIbQ5ogo+rrm+kYyYDlVp/ryTg3PS5Tbn7/RUd3K7e/hiSA2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=jzwVbHdA; arc=fail smtp.client-ip=40.107.103.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFiqTJISqsVrEzhUsVQ4BFDEDQT3IDYLxyDZiQYUS8VDFqfPr7q8dKVjBAWzmu2i9qtI/OVrGpWh7cQ7zwo2pL3FLD4TUyEGeO0jIuZ6kG3eQiV4/ugK4BJ7sTcx7CDqpqMyRMQfpo4NDag70QjhYD5UZkuuuPeTlO3w5NJjaImag9xpGC7O4P9KA9/We4e8JOQcsCviJxuXOSbWBwjVw8JnOXaH58EK4l5kvu4wJDIP5PLZIiKCtJI8Ue/mxzRQwZjEZ3HDwC+7szDfKvAQ80T0vq8pVr4dWaPb2oijgZ3OvEFVCgm9WPp5DTFzt7bwMBM34x2YEXkmKDyq0KnGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lS07DEkij0siyBFgtqV+onP5vPnua80KVNIVtxpdqyA=;
 b=ZdovlQCeh4qISufMN1KPYW4pruA67o4/HABwQovXtVA/cOJmPUhIxEXQTcfYX1GBTt53MfW09h7/vZ05DJNpve7Vy1nOOT/pwBZnKsaN8aWpwkSUpX6vsbQG2WNqydgAUADapUoHojuV3Aavrpu7yezWWrH2NPPCf47GLUPZ5rMro+XHI+HgDxov9yd1um9taG8BqOxixEMaY/cRt2NWM0zWYLlycuPTccBBrSJZxK8qFjgc0PWVRYGuWN8V5wzH6NVaX5Yq7gnHD0RtiTSS8jd77j3yuM24GPsjzt82AOb/jniHjZmho9tn5FyxuREl7Tau6+iRD22agYRJ57cEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=jo-so.de smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS07DEkij0siyBFgtqV+onP5vPnua80KVNIVtxpdqyA=;
 b=jzwVbHdAQhMXXZgMttJLdu/T2hG36F+/XPeUPITaYHK+LHxURmnBxYSGPeJz4B6mzAFmSg4g/8yvOzm92pLNvYUGV/wxYYMHiBFmTmnPkIo0n2UWXKhONYfYk7FveRsCHHzvicSyRYhrzOB7bsSEzCCsQCLumWabtE0E0FXXJJ8=
Received: from DB7PR03CA0078.eurprd03.prod.outlook.com (2603:10a6:10:72::19)
 by DU2PR07MB8346.eurprd07.prod.outlook.com (2603:10a6:10:2e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 10:18:59 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:72:cafe::33) by DB7PR03CA0078.outlook.office365.com
 (2603:10a6:10:72::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Wed,
 11 Dec 2024 10:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 10:18:58 +0000
Received: from n9w6sw14.localnet (10.30.4.231) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Wed, 11 Dec
 2024 11:18:58 +0100
From: Christian Eggers <ceggers@arri.de>
To: =?ISO-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>
CC: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>
Subject: Re: KSZ8795 not detected at start to boot from NFS
Date: Wed, 11 Dec 2024 11:18:58 +0100
Message-ID: <5708326.ZASKD2KPVS@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <njdcvcha6n3chy2ldrf2ghnj5brgqxqujrk4trp5wyo6jvpo6c@b3qdubsvg6ko>
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <zhuujdhxrquhi4u6n25rryx3yw3lm2ceuijcwjmnrr4awt4ys4@53wh2fqxnd6w>
 <njdcvcha6n3chy2ldrf2ghnj5brgqxqujrk4trp5wyo6jvpo6c@b3qdubsvg6ko>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8D:EE_|DU2PR07MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ae2107-5526-45af-f461-08dd19cd3a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?kz1wBk1bmDE5wIZOd0j/DLVfx+yp68io0qw/lV4xq2rv7z6W9KDM4+tQgf?=
 =?iso-8859-1?Q?cspUb5PRHpJsFYzRsn9c3k2bKPi3ZA0b5nNB/2TmzSPAtgec27FtjotM5V?=
 =?iso-8859-1?Q?t3wdPUXrXF64M+uwarCFQDcmAZ1ZspBZNe3X0FFrbQTCYLYX59Cl01fWoc?=
 =?iso-8859-1?Q?WBeTfA2OLFtih9OHVDZCiVGvrFuaf+MQNneHB1bLc+AE832n9CPtgf9zYO?=
 =?iso-8859-1?Q?D2Gi2PrBBrCpfIcp7BNExzIpmweHqqXo3rGHEf5uqngjTaavgMVYXG+DsO?=
 =?iso-8859-1?Q?TZLbRULqhyD7GxKCg5TyEIIg+sPpkiojA1AcsI7iwbHgb6jiSqa8evIN2w?=
 =?iso-8859-1?Q?GzFJsFglya0g2i6gKh1FTRYO7FFCyc3+PBp+OM3hcgEHPY7xzS4/dbd+RQ?=
 =?iso-8859-1?Q?2XVlvR+yXuewlIb430nEKdBHbVI2kYMC2H8hLWKDwzMrzdrxaB2QBSSiLb?=
 =?iso-8859-1?Q?39g7SDsRoYzFtub93nXdtedOP/BDfXRXankoi5sdJ33h8ept1eM5Pgztxf?=
 =?iso-8859-1?Q?o04ySqL6brGIBiZJjCbibjFjC0drExaxqSZd3JiLsCTrHPExr7Y5Vm2mzw?=
 =?iso-8859-1?Q?44hmD/O7qRNaHhWVp9mMYU0/+qXZFdUyNuGwde0hoyaKfvlvPxIRFndTNk?=
 =?iso-8859-1?Q?H7MtiiLfAGgLOmZ1bniFNmtv4G7QUPaLEIr5fSniS612Wpx4EZ7yIcdFSx?=
 =?iso-8859-1?Q?PKD7laI8rJC0sDskcwkvDVqTzbAL5GoVaNXYkf8g7d7smFqR22MMIESzNx?=
 =?iso-8859-1?Q?3pdutDW8UjDGwN4B2aeLi7woZdpJTl55FaIKK2wdZG+vnCRf2bdTNZt5q5?=
 =?iso-8859-1?Q?TWw55QT/o+NeCJGz1RIQAR+tGAuNJQC8Z5mpm1OLXLhS3U9DlqezT+4NtP?=
 =?iso-8859-1?Q?MmdzE98MDOmf63tAVbuTG+3MFMczo9AFF9CNwlQ4+rOkaD2QD3RCzEHS7Y?=
 =?iso-8859-1?Q?uOTscoHWvYtdBt/eMmxycwpOBwmKvasoEWY8OPosz6nAADC39GCoNPA6Dd?=
 =?iso-8859-1?Q?dMmxbOHYwLtP/4ZXJiRqzejKRg949/ou0wCtzEij3QvvPbKVlSZOZODaJL?=
 =?iso-8859-1?Q?06vqijrulywMpJO3IR+3bSnjcBkxLco3SUx2TIADo8QhiKTAxL0Vmgg3fz?=
 =?iso-8859-1?Q?PeQhErqNeOy41sMysqbHXkh9n6MUjeFjhsEe8eWP3LBbuTAofVQmKj7oGI?=
 =?iso-8859-1?Q?F0W12kLIRS4t0+agUYdwqfVcfL5zoBZkWdQcRDeC3uYpLChMJCwu64nXuE?=
 =?iso-8859-1?Q?p9zLBOXpzS9dSpGclzHtvrsUMF8XUgqdSMvbKulMQwTPWpa6imdVVqNGgm?=
 =?iso-8859-1?Q?7AqWxqQufO2QDpSPXBEynI9uNd/r712fYF3M7KkMfOv3+0gdbLwsWtE0Zo?=
 =?iso-8859-1?Q?m4TgIUBjuQ2mG6YKIwAQNh1Tnt9ZyncN82pxIQ6/IvxKnre/m3G5mR73NH?=
 =?iso-8859-1?Q?hgXJT8HbfEYL6p7EfjqX3jAdLBkcXntkc78a+VSix/BOEJowR79dVXc8NG?=
 =?iso-8859-1?Q?WCX24okb0d9IoqfnDF5jGlchYvndObhj9MLQ6NCzBvhjQ4l+EKUoFqz95O?=
 =?iso-8859-1?Q?Vm2Ls2Y=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 10:18:58.8942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ae2107-5526-45af-f461-08dd19cd3a11
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8346

Hi J=F6rg,

On Tuesday, 10 December 2024, 17:43:01 CET, J=F6rg Sommer wrote:
>=20
> So I think it's a timing problem: the ksz8795 isn't ready after the SPI
> reset, when the chip ID gets read, and this causes the probing to stop.
>=20
> Why is SPI_MODE_3 required? At me, the chip works fine with SPI_MODE_0.

I tried to reconstruct why I actually did this change (sorry, I am over 40):

1. I was working on the PTP patches for KSZ956x.
2. It was necessary to convert the devicetree bindings to Yaml.
3. There where objections against keeping "spi-cpha" and "spi-cpol"
   in the example code:
   https://lore.kernel.org/netdev/20201119134801.GB3149565@bogus/

On Thursday, 19 November 2020 07:48:01 -0600, Rob Hering wrote:
> On Wed, Nov 18, 2020 at 09:30:02PM +0100, Christian Eggers wrote:
=2E..
> > +        ksz9477: switch@0 {
> > +            compatible =3D "microchip,ksz9477";
> > +            reg =3D <0>;
> > +            reset-gpios =3D <&gpio5 0 GPIO_ACTIVE_LOW>;
> > +
> > +            spi-max-frequency =3D <44000000>;
> > +            spi-cpha;
> > +            spi-cpol;
>=20
> Are these 2 optional or required? Being optional is rare as most
> devices support 1 mode, but not unheard of. In general, you shouldn't
> need them as the driver should know how to configure the mode if the h/w
> is fixed.
=2E..

It seems that I considered the h/w as "fixed". The pre-existing device tree
bindings and the diagrams on page 53 suggested that SPI mode 3 is the only
valid option. Particularly the idle state of the "SCL" signal is high here:

https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Sheet-DS0000=
2419D.pdf

But the text description on page 52 says something different:
> SCL is expected to stay low when SPI operation is idle.=20

Especially the timing diagrams on page 206 look more like SPI mode 0.

So it is possible that my patch was wrong (due to inconsistent description
on the data sheet / pre existing device tree binding). As I already mention=
ed,
I did this only due to the DT conversion, I actually don't use SPI on such
devices myself.

N.B. Which KSZ device do you actually use (I didn't find this in you previo=
us
mails)?


On Sunday, 8 December 2024, 17:44:49 CET, J=F6rg Sommer wrote:
> Or am I missing something in my devicetree to set the SPI to mode 3?

The idea was that for "fixed" hardware the SPI mode should be setup in
the drivers probe() routine rather than in the device tree.

regards,
Christian




