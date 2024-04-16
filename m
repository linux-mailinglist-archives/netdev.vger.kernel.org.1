Return-Path: <netdev+bounces-88158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65DD8A6157
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 05:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87AA1C214C9
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 03:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F380D14F78;
	Tue, 16 Apr 2024 03:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EnhmCxA3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C04C17BD9
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 03:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237341; cv=fail; b=nadpI9TLqq1IafTAb+Ei2WZxY6hE3/Adsy7wIBJOEpfjs/o0tGBCyBJD7iebBYzvlYsrJ+GzVpznw4Jfbpiygtdx5WDzXd+addPpD/xg+34KMTQN51td8LdafCOu/l3V2LvnKmziX86nAfvlfzFfuMwBDwKj1LXNC7g0ug2T78E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237341; c=relaxed/simple;
	bh=eiUjVPXeSEKQ458CW4XlSVh7Hf2MEK/2C7N6f0AK3wU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tIkbO5aqxTOabXCQEJ/r4fm9JlOXcOZhKMz0FzlaEtlF7r/m2Q5gkv7A6E5t3OeVXgFzur4pgulfhTfBFND7WIaSCTEn+eoXfmModUZe1wW2BuFkONrNciJpz6U9aF4k+KVzkyPF9VsUtTYLwE6xepoOiK2lcVt/wP5ldZpP8pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EnhmCxA3; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IB+Kt5b9YeZJcfBjG8VQfVac3a1Cs4rqx6NZlJJHdXpyb7Zn2zaR4bq7yYusbBPVH/m3pLWiT+aPnt1FYdAfbOwQO0SjVzmQkLGiiuDe9wYAn8WfwID0Jk1vYuC26LBBxFYWKs0ymC7to5Mku9in9WpGyAiavdjfI3lI1srC+tI5k/YKI4OcI3/rehVaNKkgMx96IfgyO+zu8bdthBUqRzsuFt1lk65Ftjv6pkKyoorTy9JfaL91eeXCXFx/fhSogXcDARmSiTWDGVwOR3BTM5jjP1+L2U2Kj5+S+UuoBPUzN7Dr1Uja+I9EfPGdpD9cORfsKsAFnsvJ0oXfpt1qaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSlfIzMn5LaSBfa0FCCcc2bBItXmUpogAU6ZAIsecvA=;
 b=GzN3yarJwEx03xOaZydr8o6mh042wjrz5QCGY2dN8w77JrsZtT4XgK9wBDXjvfg0mYoJplc18yae01Uo+P65Y0B6+SRcZ8EEfc8FZrKFU/VF4RL/2TAM2fYLLT+uFNf80aRJ1cNPdIxYVbFDmdVs0qZYvxsXmACMjZFPKjg+63xLHoyXalnLnlwToUwqM+cGYO8cdh4Kl68AK1CnDBqZS1kDyZMPgoiQ8vuuDCrpwiX66UWpt5W4LzfrM6tRldLi+Wqb6b7lFvH0puNubPpR7vB4xV+7MHVvoJF3UhGgSYCPaNs8GUZEWiFbqF2X74V3FW6ggw0GAd9ljl4KUjBn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSlfIzMn5LaSBfa0FCCcc2bBItXmUpogAU6ZAIsecvA=;
 b=EnhmCxA3fUvpWPuMlOhweUyWoy+TOuKWVm4PzEL+1Xj/iCLaX1ndbi0DRYQWrPU2Jxu+QDtmr5XIeDVBFoq1zfcvEVTyUWdudOqrc4kEIdSsoxY1pUD/wn1xNtjIzvrsRbooZtd0lQzu4cDCtvkJg746R5PrVPD1MOot0rFXmun8l5mPNJEFQ2LKorS2I9Liq2EmV84YpV0/13v1l9I8FybZdqsnMV2UDC9NHNurZYKr3jxnuu6T2D6SmARcYzIZilFYV6FXjrTe6OxvLuDnMyFO0S8D+KUzFUVdxdxNuQD0gOpnP8bJ72/j4N3aD9tJU877/41Cb7omfu4KCZKzUA==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 03:15:35 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 03:15:34 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: RE: [PATCH net-next v3 5/6] virtio_net: Add a lock for per queue RX
 coalesce
Thread-Topic: [PATCH net-next v3 5/6] virtio_net: Add a lock for per queue RX
 coalesce
Thread-Index: AQHajRMmdbHwvvoxokersDJY/cIzq7FleFqAgATEznA=
Date: Tue, 16 Apr 2024 03:15:34 +0000
Message-ID:
 <CH0PR12MB85808460795C1BC5FE4EF6A7C9082@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240412195309.737781-1-danielj@nvidia.com>
	<20240412195309.737781-6-danielj@nvidia.com>
 <20240412192111.7e0e1117@kernel.org>
In-Reply-To: <20240412192111.7e0e1117@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|PH7PR12MB6490:EE_
x-ms-office365-filtering-correlation-id: 85a1e335-e3a0-4ad0-a82b-08dc5dc37b50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Z5Ss378xvYak/vP1G6DKu51tpzt2nDTL+nWn2nDfEgaGkEkPsKvDDd2oT3f+6ZJpqK3MT3iFFwX2192vF5zVIMI1yC191xv3/2ZCE9G5kqkJDlzemuRHjjnKtldr1FoGHPIHzN5dWjbQI/1pQl1e3EKgMXJKWdf8Yvi0AOJBkumerJypudTSg44hk/w8q7+82k1UKOxVTNv7OvifXorQb2dUXMRV9EYzOA+YqXbGarZGBg0sOVioL1SWj9E7+CbG0XCcFF8AWRCpWoZ2zSVOU2JM5ZPNtb9eh6jHo1Zdkl7oIkehYvPwQqdDT7N9sTUumgSZ2qsGgLJ5kFGufq9/oRgqDFdC17xFaXeUXr/DmqqUQBbf52eNr4jFDqmC9tXlVF6kMlbzLlYOC+KL7cMgHI46yFWRJLli72LCh5nKxZcILU4RXAVqGX3e9slsrpARmWHpKcZvMLBPtXn0WUGU/Qw8Oik/yOiDwAbBvQmwB2rLS/c9Mv51E8ihuc7+VR7HLcgjcZb4NJC4WdWLPkD31VDYQ2kyCQz/Fsuwo9O0HuiOtOkP8lqzgTvEP70946nm1Nj/zzAa41fmhjwZASmCampnHObxvds4LCO6MI2P+zhcLut4fb8+X5H2ZQazD3VlOYpGVpQ/kLjdvPZ0yePUVloEs3u9ZD5P5saASXJcsJE6KKyX+SrnFn5w7lA6+N1BA4BPIt7/vvXaNR1zckazE+4fBc+96dp8cr6+6CYYXoA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+r3kSe5Z5p2I/AcY7BBEIU4q7V0hTh2tf7duwyy8wpxCtj1kRTCa83dmhakw?=
 =?us-ascii?Q?vCVrBPSonl6k5gCk4MPGOQfNVE5nl9EO/Jfawi59L0PVWYeePb0+kHYMW7KA?=
 =?us-ascii?Q?VLrTZMlMnPktMRRxKb9Pwe57Sg9NlsPtTW8y0BpSkIZeO2VOWMBzNNzQwRdY?=
 =?us-ascii?Q?E4ovKZEwCJgfos0tuPFFQY9HJf5/UDUs3LK0GgZengnl1cW0vR6CXMOiJGIK?=
 =?us-ascii?Q?CuUgv4MoggiGfI2slzs5VMEzYwDeuEgV/NQN8B6wQKJdv4Jxgv5JHJ521STX?=
 =?us-ascii?Q?72Y+c6SsvAb61uJqdJG0ONiAC2pzh/klZNuMZ1uvDWl1eGj5dR5LvNhr34py?=
 =?us-ascii?Q?/NxECIeH8i3pE1hiI/ozW8vr6i5pdQmSuuOtU50jRK5YQXA1PhPMifI4FAlU?=
 =?us-ascii?Q?k2+UzSs18egGWGk4+jEBZZfVcZK1fD3Sqau7JSE3ozlCiB8XWpoZf2NPHPcA?=
 =?us-ascii?Q?LBl4BHZks6I/uUilreqJ4DoW61bWqIJZnlfah5RYT3eHyg/D90/QBdnrDc31?=
 =?us-ascii?Q?iPcOUoKr4bHF2WETXDyUWjiLwg7lhczszWeOQXBHcLfGAw0o2zdOvpYucd4c?=
 =?us-ascii?Q?MHSvyfngm+bAy9LeSN0N5z0WkflrkxbcDke9sUVgW47e/k5luQxZI2hBHTdG?=
 =?us-ascii?Q?5DuYGghJg+PWUTJjFrOXvNcX+m4e0HFX6cbRd4HUBpCFtmmeGwX1rEMcVwBb?=
 =?us-ascii?Q?MBibnesIsQRHjwOfCA7UHI7R3gFetRE6a4kEaSdAEu64bRlWYPrM953TrNKr?=
 =?us-ascii?Q?EaDCF+uVy7SBf4entwmtK9iC7yl5bV2NvIdGNNTz8oNN0Ikrk1UAtkh+RfJB?=
 =?us-ascii?Q?1P4ZGVgXggLeZvDyOjwCyD2eLBe0u4VPr0tfLBPbUgCkgV+LTE6H0cJabpJl?=
 =?us-ascii?Q?XJTz8c0OlZ5IAHNLi3YVtZoDbkEUjoQZymfzCN6iukbuxzu/zZGm/UF3Scmb?=
 =?us-ascii?Q?+Cdmz+Xhw+dB3bWYeJSBCBeRj9k/1RPusHodhj1KfNdbLvhIoqSBMJjLKTFw?=
 =?us-ascii?Q?6LaF7eSqdfLEQ1dBujyS86aE1k7qgod8YU+Xev0ZfvrEM1TlTQkPaJ4ITnrj?=
 =?us-ascii?Q?50vdmSj1/6NDYT2OoHBxudouHzS/hyl8iK2jnPUI1P7Iog+Ouu8mUtit3gjZ?=
 =?us-ascii?Q?TiQ8kAv+Mm3mJFPBMxrrLRmlHXrV6EtA+VIipTXBVrkGTyRugBpqh5RYnG2T?=
 =?us-ascii?Q?bIOFX2J/I4MQCy6szD+NQqfGGqqqlj16CmNj/Z5LR8kGrsPm/NZqNzlSifUT?=
 =?us-ascii?Q?dyArCoGSl4esobDESjUQRe0rcNVxhB4Usliu7xHsJc8aRY20DLYtaWFgf1wW?=
 =?us-ascii?Q?r2UfBXDxdqM206VZXFcOq+4L6r2iYHMvDEOo7CFDyY73bNgT0kNg6TJDks2d?=
 =?us-ascii?Q?6ZCCk1OeIL+PqchkyPowz9rABIAz5yGG5Yn8dHI8zmQ3Bu0nnRDbOk7zycJ4?=
 =?us-ascii?Q?5sdr3tGqg85Pjw0HHcUgXAPfMz6te4lASM051tyCwQO+2WQpXoCkoF8Jd8Jc?=
 =?us-ascii?Q?rkDImZdOaiZZvLHu8Jr1oUAG/CS5u1Jw4boqY/um7hwY5IEv49T3j527OZ8l?=
 =?us-ascii?Q?jWaG0sx3QgPIpVqLH9A=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a1e335-e3a0-4ad0-a82b-08dc5dc37b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 03:15:34.8136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UTnOmnmvbU3Qqwsd8dNdQE/kmrFiAxnKh9CccrHCxbDMKvkqhGmgFiM46kgMGi2ROn0li/8Lfp988Kxwn6PB0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490

> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, April 12, 2024 9:21 PM
> To: Dan Jurgens <danielj@nvidia.com>
> Cc: netdev@vger.kernel.org; mst@redhat.com; jasowang@redhat.com;
> xuanzhuo@linux.alibaba.com; virtualization@lists.linux.dev;
> davem@davemloft.net; edumazet@google.com; pabeni@redhat.com; Jiri
> Pirko <jiri@nvidia.com>
> Subject: Re: [PATCH net-next v3 5/6] virtio_net: Add a lock for per queue=
 RX
> coalesce
>=20
> On Fri, 12 Apr 2024 14:53:08 -0500 Daniel Jurgens wrote:
> > Once the RTNL locking around the control buffer is removed there can
> > be contention on the per queue RX interrupt coalescing data. Use a
> > spin lock per queue.
>=20
> Does not compile on Clang.

Which version? It compiles for me with:
$ clang -v
clang version 15.0.7 (Fedora 15.0.7-2.fc37)

>=20
> > +			scoped_guard(spinlock, &vi->rq[i].intr_coal_lock) {
> > +				err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
> > +								       vi-
> >intr_coal_rx.max_usecs,
> > +								       vi-
> >intr_coal_rx.max_packets);
> > +				if (err)
> > +					return err;
> > +			}
>=20
> Do you really think this needs a scoped guard and 4th indentation level,
> instead of just:
>=20
> 			..lock(..);
> 			err =3D virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
> 							       vi-
> >intr_coal_rx.max_usecs,
> 							       vi-
> >intr_coal_rx.max_packets);
> 			..unlock(..);

I'll change it in the next version.

> 			if (err)
> 				return err;
>=20
> > +		scoped_guard(spinlock, &vi->rq[i].intr_coal_lock) {
> > +			vi->rq[i].intr_coal.max_usecs =3D ec-
> >rx_coalesce_usecs;
> > +			vi->rq[i].intr_coal.max_packets =3D ec-
> >rx_max_coalesced_frames;
> > +		}
>=20
> :-|
> --
> pw-bot: cr

