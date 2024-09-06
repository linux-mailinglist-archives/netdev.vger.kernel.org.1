Return-Path: <netdev+bounces-126045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F74C96FC1D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77BC1C21717
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23481C86FB;
	Fri,  6 Sep 2024 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PStYtkMB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1101B85F0
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725650751; cv=fail; b=EDog+CSySnxyjMJHmAvxo/geABoDxs/Q4xLyz7It04xoKP+RbWqhUesRgPnPTYILf0KUgJKmSa7PrZ8WWq18fegffljj+HM3IFjQKffxTQ7d/2fsWZ6EoJTRi9X1YRNtLmXrssN4ftiQuLPkMhUJ36xY8V1svCHV1k1/gT8E1ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725650751; c=relaxed/simple;
	bh=XFzlpMvk3Ebdr4fPr/aNsKB9QGJB1kLSVi1xKMczFBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j2k/YMaYrbGd9D0NG11pTn++zsbA9CktvYEY1nGbu7O9Cy0XYiMxoo56go1bQsKI+plSuFxM+XsDL1YsQjr0hDKkeQ1rul4wn80tGJRaqjlwQ73ayM+l5JAWefrcDPd4D5fzC6vkpMSHdmws2WeBKekViUV/fXUiNV+RVJq+PQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PStYtkMB; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aH5DwcOXaM6Yc0SOyWPFsB6Lq0xaCTlxP9At0rDxbcg7RwsavcPhAdxx3HnPkoqYYCOJhb18XlQ41eM5TeK1X4Mg0C99w8YujAF3LvXvNLI4wEQL4uqJqeRVTCNGSgxE61xYjlW9K7KCdzSPzpODFvS2W7aYkPnEaTLfHUx6EImanrEgkxDUtz+DPN6mTvw78ie+dow16P1FCt4M02gO3bxdJkD0kIPSx+giL2FTCpq9ZJDCTjeSAP8e+wPAur2MjWnDl6B8d+pu9fO9Y/Rxv+fSEcQerF5LlWtla8G4kLmy0EHdBbLhEC0Zwu8KeczIiBsVSuMfhdurzeCsk86ihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QCZ5LQzoLIlkJ+yc7OrKWGESa6WOZPTcf1hsuvJFks=;
 b=cnDmrmIjwDCZjLkUSnSRB3PhCsvLLMFWrpSLh7Mj+piUC/d420LJp2wy2Cf3UpGyaiGtl8xpEt2Dc/yXauY0ptsOGvfEWwmwxCnCJFZ+Fc/sdtr5VetzAty20fXFzYMz1cSa09qcBHtaM8836KvMQDr+N+25b74ULpMNbcGQ8WFQH0GDILC5pT1mUx4Ew4g0lHPcAIZyxLwu8nPvy4ahk9wOUDjsrN0k2FAdJmAfiDL1xH1jvNhX5tthMrH4/dHxn/WfPoAjlHyMe7psz9NuUzksnuY9G76SRCbkylY0xR1/FJfZx8VS78wsi8OK5kXsJblnRuSs0YdMja1OGpdh0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QCZ5LQzoLIlkJ+yc7OrKWGESa6WOZPTcf1hsuvJFks=;
 b=PStYtkMBUrfUwtaZq8j4qzhXrNRLyPxLyvDZsjxLnmkrvFIkPznfif3GoUMckZmA3xnYSeMSS76L2Kw3Q1h4SlF4f3ftg3wNXGW9zlJI7RoNOVEqXrF5JuhC/vjX8QUYMknHGdf3SPPxaIWlHZ98K6VbWTl4NKFjKQrkba69bUfzS8Auf/I6wVAf8MZCcRjH6rdjjFFmLhHqfh9E2NPNojmynUokrH3KaOaMkywZGOQr29KePzKJ7EPbqT+C9Zw/HbNyeNaXAVz12bwAl03Bw9w6xwB68WgZICkdy1GIgWnJf95Pg2rloLJo4wy5er3U59SOhPp4729Nm64iSHfxPA==
Received: from PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 6 Sep
 2024 19:25:47 +0000
Received: from PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe]) by PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 19:25:47 +0000
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
To: Simon Horman <horms@kernel.org>, Saeed Mahameed <saeed@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>
Subject: RE: [net-next V2 14/15] net/mlx5: HWS, added send engine and context
 handling
Thread-Topic: [net-next V2 14/15] net/mlx5: HWS, added send engine and context
 handling
Thread-Index: AQHa/1zOk2aVthDVwka3Ol12+g7GnLJLFGmAgAARonA=
Date: Fri, 6 Sep 2024 19:25:46 +0000
Message-ID:
 <PH7PR12MB590332BF2B4CF7F7E3D0D8B9C09E2@PH7PR12MB5903.namprd12.prod.outlook.com>
References: <20240905062752.10883-1-saeed@kernel.org>
 <20240905062752.10883-15-saeed@kernel.org>
 <20240906182119.GJ2097826@kernel.org>
In-Reply-To: <20240906182119.GJ2097826@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5903:EE_|MW4PR12MB7287:EE_
x-ms-office365-filtering-correlation-id: 99908ca6-3151-41fb-8675-08dccea9b581
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zepAKjVLRw+psvYHtjCaolvPWm69la6zq57dazwII5VGpFJUzfSdDsmPXLOX?=
 =?us-ascii?Q?cUzwfvZUFBLXEw0Fxs8+tYdylG/ut42DsL6KYcVgCVvtT/PptwlA9E/SRjAl?=
 =?us-ascii?Q?tCkzemPe1eNT9uSN+ZZw6lr204YjJkLO5KDZp6oX0lifi//DL2ZSGWwW5Pp4?=
 =?us-ascii?Q?yO5sOvdS1/hldKRyyX7HXFCvHEH27EeMzRG+m/LStZshYf/wVg6qmJpq/+vx?=
 =?us-ascii?Q?nJ2u5RS+6x5JRC2Cjpm0db90yWCwZN3iDG7LsAIMvikyFblOuKLRunmyM3Xf?=
 =?us-ascii?Q?Rqo8CYP8BehoJObf8WNuUsNh/DdhktLPxon+ALRdwJGRME0rSm1RaAk6dAqO?=
 =?us-ascii?Q?rSiDPxELrV7lMxybPgByvzXcNLmhUuwC6ODi3ivBo8ke2J2bTR1+/r1P6EP0?=
 =?us-ascii?Q?rUCVKkR2miPoiVwVrFIrfcJW/bShdrInSirezKNQFSX3RA5RXDRxe2fdqg4h?=
 =?us-ascii?Q?53pmTu7iYGPnyZGLjHDDnbbpOCHmVf1EJMACYIuD9R2AQ7/7e6EXTPUUBSee?=
 =?us-ascii?Q?J8ydRXrgq/eDwryYCRjaMfG76yXmrH6H4jrVjwmUSMb8CdpP6HxhQVAOs3WU?=
 =?us-ascii?Q?rSTxuLfs40b5Mi0Dr0NWMbiVkmJnWRCIYO6rFPYS1+MJKDpdnX1xq2t02vwh?=
 =?us-ascii?Q?ZTDT6VWPVW/lFBJoU97qsAJygkksmhPpgTsDh18oIxJtt0vk/9Nxg/xooS32?=
 =?us-ascii?Q?O4/H8VbE49W61yQjqDlT7yBsvTk0GuhD2oRpz4Z34cUHMW2YGrVJEj7AOa9Q?=
 =?us-ascii?Q?WX4xyrfASVLEi34HoCnNQTuhO4Q31YoEYRo+1RjPDvhKBX8ieprGXINDArwc?=
 =?us-ascii?Q?cfQIjWk2DLBiXPHpH1gokJpcUMe2xThKzy93i51AJ6oCJVnl0cjG5uILsXr2?=
 =?us-ascii?Q?l3zxxDNm32x9eo86uzObl296a8yWc3xY13c9APjXbjTCIB1kVsHomLq3FGtt?=
 =?us-ascii?Q?YuhEWktyzxp6EwSKjoRySTnDKzxQaXGL/BoDswIia8JmfCVts5K8x4NZwBNc?=
 =?us-ascii?Q?R0eBhEi1aXGGB0ypG9FAE+Rmava1UyAZ6/6JBjUqlefqdCVHwxrCPmXVoxtP?=
 =?us-ascii?Q?jplZLS/UlOK1GKaEzCg7ijxSlTiMUCbTkfTtRiO+1Ad25X7oeN/BBLgU48BG?=
 =?us-ascii?Q?/NF3KHzs5ec7E56v6c3ZYLLjHbGPk0EJB1k8ANwF2itynKFcJlg1QEi2QsJO?=
 =?us-ascii?Q?A8eTjS276taEKeE82dYrW9BtFBlyWu7+taUjffRUvkyI/zDxI/6gKmI6LO6N?=
 =?us-ascii?Q?D+N6b2NwDZHkFJy6rJ50XTlZyjAwxeu7P5M1XXShf4ngoy9nQXKcouZ3ihI0?=
 =?us-ascii?Q?I++OuTt8Yntq108st19Zmupj/sGUVq01Wp7IGlvjm3K76hsKYUmHDLCNyUbM?=
 =?us-ascii?Q?t4MuNnQFuCGctpRB2XA6SP5lDOHAVrj0GaXScx7YXM+uYHLbKg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5903.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SNKCslBnsre88pvKLl2+DEVDz7cRipDSiWhX/pQeYQSOVg+xPBVNeVc43UN+?=
 =?us-ascii?Q?JOon/aPZlHfx1M2zQQZU+uWiHyfsOBAOHGGu2HZVLKwc2SXaKwy2sPwZHRkE?=
 =?us-ascii?Q?WJHmZ8ofiZIikbWFjBgy0bmnguquXOe1MXOh6oYTLh/jbWhpoVdVDVJMSg81?=
 =?us-ascii?Q?FKdpWQ3Sjtd5js9nBjQgSXAdZ57En2W2fZTc0VzW20UJpuTHio63pT8y89HQ?=
 =?us-ascii?Q?SqrUZoHVRUIqRgXpWsyc7o/ZBld6cSJQ8cQ3L6iaeI2fuHCmxKJqfI0i6Sqh?=
 =?us-ascii?Q?fs/yWltRmCHK4AvO7r+t4QBEfu12cOadj7olXO0WYzMwQOfEPLJvZTUekhrD?=
 =?us-ascii?Q?vR/G/H1798/q+KOaEpQu3v0QvTONgd4yg+cqFfp4/mGTxM1V2aK20wPju6hL?=
 =?us-ascii?Q?LyjB4freGsv+E8W349uDVcGv/l9M/kOrUqeCGAKiF2MA9uqskkDnmkYrBHnc?=
 =?us-ascii?Q?8Zd+HOsxkRwddiVfmmdCDOQ7ytTHrIKiHkV88kYvpe1zySQ4eaMaO1Ve3Yck?=
 =?us-ascii?Q?MCdjF6/Hxev0pzvXANww+E6vU2LfB8xrVAgDJBWpxqO77XdujwlSstSaQv3X?=
 =?us-ascii?Q?aFQ15J/832ItlPmAtOAuEkM3VPvES6D6aAK6vZGlbgvQ4l+yrCWQKljLWTqT?=
 =?us-ascii?Q?qNk1jPkd0hlxkblA2fTRdhN4MFyM/MFkCK0zPrxLNhBHvkC3HFPTFpeHBzlF?=
 =?us-ascii?Q?PJiguXRXKyC/Q2dNzJDdLtaBW4h/gEfgzR5y8lPaDv/sbqj9x+ru0chmvgtv?=
 =?us-ascii?Q?D6SbXC2I9VSKWsawfiFMjheGUUj9DeOl7GaFy2rz3LoumTChkveCYRYQ1602?=
 =?us-ascii?Q?yYr7+afFlJGZ1+x2XCmqVOncMjWdsHurOk3MvR6wfBm0fdBTDrJnWW6BvNCJ?=
 =?us-ascii?Q?tbd8UsDAYerl5izKCGyvRsqvkLW96q5PEx6jeD3T0sGq4AMoV8wxRY+R+KWk?=
 =?us-ascii?Q?he3MFHbapmDSxbJBZLKrwwLO1srPWH4iqGu7qKfEE3WZJtIlDJreirC4k9jH?=
 =?us-ascii?Q?KUqio/LLkYAkAeKjd46LqPmhtJJNTnTDp0++2dDFE9UmDhnQyVF/HTkTcr/s?=
 =?us-ascii?Q?ds75CG37JbpuG/POByA94G2QkZwhiTm5/+8crfMDHBFgdR5XHBDbJ8nWdc++?=
 =?us-ascii?Q?2y4sTkHrLiYXVWpfaJ12p93xqNbxWypqfUuP12fwLU3y+qinSzFbw7KLi0F8?=
 =?us-ascii?Q?++YlSfrzcbviu4lJBKuDU1MhmEoETsbF+c3lS5EFliD/KsLaxyjlewWnbd1/?=
 =?us-ascii?Q?7gt1TIyAGDOqISaN0+JcaZ12tptBz7s6vDUEJ2bybukgrYhHa7HXW6pqVlqG?=
 =?us-ascii?Q?o/WhF1HfBjkWHZgG3JC1b/OKLo6qQtBkL2eRTDAgDnOkNGCJsLFPXQXGeJ5I?=
 =?us-ascii?Q?1tks7RT7CRHB5UwQAchAzDcNUbsnSa12p3pwgqMCxwe0jXdnNdTShlGnV+hS?=
 =?us-ascii?Q?8Q57sn2gePjLBtlCiuJLHd4VdxwSsChRX12+Cad4TQk6qlm7TckfkynZMZgT?=
 =?us-ascii?Q?S1txnuiKWxGdI87Gw4YtYfeVxX24S2hEyk7q3lh9TbqKfM6B1inU1kT8ZBsN?=
 =?us-ascii?Q?BD89ecDiE6ALrvp4Tbw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5903.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99908ca6-3151-41fb-8675-08dccea9b581
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 19:25:46.9366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJCyMV8CoyASjr5zRB1MgV3+0SoazfzMaxt01qqWgeUPOzri7lYxqaRVHsYdb+emLdsRlu3vhD0y/QWu7haIjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287

> From: Simon Horman <horms@kernel.org>
> Sent: Friday, September 6, 2024 21:21
> > +
> > +     err =3D hws_send_ring_alloc_cq(mdev, numa_node, queue, cqc_data, =
cq);
> > +     if (err) {
> > +             goto err_out;
> > +             return err;
>=20
> Hi Saeed, Yevgeny, all,
>=20
> A minor nit: the line above cannot be reached.
>=20
> Flagged by Smatch.

Thanks Simon, fixing this in V3.

-- YK

