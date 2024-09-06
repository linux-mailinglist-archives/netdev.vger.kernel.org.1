Return-Path: <netdev+bounces-126046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80F496FC1E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C671C21CAD
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 19:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D07B1D2206;
	Fri,  6 Sep 2024 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mf6aZkEe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB21B85EA
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725650788; cv=fail; b=ivQ1MEWphFoDcZ1dH0PuWAinxxC1GFwcE6HlH0EiYXU+7gf1lijZI4NUhbAt+KxdLerfB+wJl9BdSvR/U864FlsTexjvA0YnGOVicWAX5XfDJWKfTpKJPiTuonm2TswutjJTqGh1cEfWCyJOd18cZNcHI8AzIbkQyUUI8rVbmA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725650788; c=relaxed/simple;
	bh=suFKDTm5OWYGDf9y8lCdmpkzFNZXtpb0tEIvhSQgf88=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mHylnwjADwUk8QgqgA1ZYYN01VTvy+3aYuVnGZ7yW9Qo1aFqtcJt84uvJoAxuzBtP4Ikgmi+8PXb2TFOD8sAdDbAHY75xpe2YVmn12xUI2lypSlk1irSOfea9jJdc3bwuhUJNvjVAkmUSCBi8lZZUWshehw2LJhsvSx33ZRTtDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mf6aZkEe; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pa0tN0UKzGFySMMZcv4gz++vcRkQjUMjDtULmAD61/lSHK1IXXYyuBYQ+W7tO4fhYRAzT1tL1rQaazmoep//k4MJTo+TLwFbH8c88bILWOIiwWqgkv2bE4nd7WEHET9u1LQdzwIlbDqOcKVL7oJghQkunKThH+G3PlEv/SX9MxSxvPOg3uvQdn3AbxiXus4eORqe3vHUMaCZYMCddaiaiT9UA5y2+qqMmfJ8E5T3s1KOAfW6c0CuJezB4Ndl1D120gaYPKQIzMuL5v09H34jsYy83TzUdc1EB91y6GzS17hrNxb6Q1MaQGjasKSfR6RaoxGZpey1Wt7kycJ2Jub9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3oS7ynspt/NzM2dV2HGgfqZm4Zlr04CngOCUEzM470=;
 b=fxgueWmtik+SX3gc5w/RfuJ+VWuQWjsafM3/VTvJ09eCQs359gO10twFqbaKwPbSk2Tq3ksWIduaMEtQRjfBnfwy3MXlRjFWEcxDxV+UO6x/wuvttu1GOUVYne40VvgB7sEaFk+CLQyOgZW4T0awqcH6ViHJ5d9uTkbEvYlMV3jQ3iZQ1vfzLWBDzO4aytG02bqFCBgWFK+aG/GjmJgcX5sqoGJxhjVpwqf/Zh2rJGlGvT1vg4JvfckdYPO58t3jIwcTu60hNmraxQqj50XNzrzQcm/YoZl/pbyZdRmKR7arXH1tyzLwJzykY1NK9EIFw7daHjxuAKPWlFyj01uzBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3oS7ynspt/NzM2dV2HGgfqZm4Zlr04CngOCUEzM470=;
 b=Mf6aZkEeywFo8HOwzIS2r2W05zgx+Zdigrmm9qs6v1ZcM7SYRl5PSQUsJbqR3PrhYXfBEU+HbrfrENVwo0dYGWKlxV6/Y265HdrVGV9M4K6ndyPerlL9WDz81IpFl/LM5FkXdHAJ1CYa/GkI3ArnNWfWUSjJGvggi7p6Kc9pV9BAGxfwmQgeBVHL5Bpxbfd0iC9TxKxYm0aavEm/FG0tVmLJCnXDrxEyuuDxfKa17JkmzGOviN+a0vhTk+E+7TsvU7CUT5jREDAJPUGwAKbDudDqzD3TzfopYIugj8fR6cz8aeMpQszh1sV3TY+nIJ4EgPhsYI/PG4oQNgpIBQL/Dw==
Received: from PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 19:26:20 +0000
Received: from PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe]) by PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 19:26:20 +0000
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
To: Simon Horman <horms@kernel.org>, Saeed Mahameed <saeed@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: RE: [net-next V2 11/15] net/mlx5: HWS, added memory management
 handling
Thread-Topic: [net-next V2 11/15] net/mlx5: HWS, added memory management
 handling
Thread-Index: AQHa/1zLZyHwne0VmUmVh+Q19e0SObJLFSQAgAAQiCA=
Date: Fri, 6 Sep 2024 19:26:20 +0000
Message-ID:
 <PH7PR12MB590362C95F9FA2AA14BDF849C09E2@PH7PR12MB5903.namprd12.prod.outlook.com>
References: <20240905062752.10883-1-saeed@kernel.org>
 <20240905062752.10883-12-saeed@kernel.org>
 <20240906182356.GK2097826@kernel.org>
In-Reply-To: <20240906182356.GK2097826@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5903:EE_|DS0PR12MB7557:EE_
x-ms-office365-filtering-correlation-id: 6195bf7c-0097-4805-f7b3-08dccea9c9b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?V/0oAIV6yVnGE+EiCDrB4V1o0RgqzWaRIJodCepWZnobEqeXFhEWz3PbgJWS?=
 =?us-ascii?Q?JzuuDh4tJ7RASZ/gSkuOiO0di0n1b7OIBin3Stt/R1GzXOgG2ruoWj8fF46K?=
 =?us-ascii?Q?u9561ZNw5Oyuz0NNqsP2PseLHatSkVplX0znB2ofwVZy46jjO4L3BDg7jlEQ?=
 =?us-ascii?Q?C5ylutFYErQFJX5yVPKuR6wQDDjZ8deJeEb+x9S3PxyResto+yB317T5msot?=
 =?us-ascii?Q?5kvjieS26B2czVJhLPvyxIRGtKnOFnM1wiKMSvxupvP0P+tAbmqzykTvZq3w?=
 =?us-ascii?Q?BJkeaR5fub1JpGHoGKWOsydw/Oh0lO0e0w/b1pe3DFMnMlL98IXxLU6ZtAaN?=
 =?us-ascii?Q?gRxlO78idNr8o+WUA005X1ZPoQvh8KF8hfxZWLB/bw0B9zSjfWVDe446H7ez?=
 =?us-ascii?Q?Nf+CReOP5eWbjFrWQdQjba2qjyuPFkXWR4L7x6uAF2DniyFSe3PTyYYLrxSb?=
 =?us-ascii?Q?t1U27Lg/ggKondVfFhMq07aRxn+PC0QVbyKK/g1bnDaA/3R/hWaLgXJzdk+N?=
 =?us-ascii?Q?HicBKOdlvl5UeUAuXqsR4ikb1WVWYIyUKDvOwU5Yh21yEVvw7eKiqtBC40C3?=
 =?us-ascii?Q?b8iEoC19Ug4URAKHn0juFSaymhlT9QJFbRF00ITzKeD0HN8Y7LG5KXYwnNo3?=
 =?us-ascii?Q?KkoPYw7sZTpBtSFy5ddjWuckD3fGDT/yhAfHVQe6/lfU0T2B+uuYhh30vF59?=
 =?us-ascii?Q?4YVTgtCCzgi0mz+LPXDVawQhOkXDyYeuFi+wIzXik2NQaIc+eiuWwNReZup4?=
 =?us-ascii?Q?j5eyPrIihv2HCKmFYKnpEIAwmHY3EVk5kc/IIDrhl78e6s2q0odTjQsu4Dmw?=
 =?us-ascii?Q?97yxuJVmtJBpOs+e4jAPrNiALLEfuAk3O2cgeCoLL2FKOL60HtHXx9ZWReXv?=
 =?us-ascii?Q?3Rq3VaBkU2auvUk5Vg8FRmuYDd3OcBbZNtKs0qFlHULtN89tMmTapectfSaN?=
 =?us-ascii?Q?+MGxAf0U+Iw7EYqLqToaOJgnH+7LhXWFIQuogv97kzZotsGrslLJHxdXbEy8?=
 =?us-ascii?Q?jUP+JSUYFWzhQctsQP0GFUuYbd1E6QHjfniB+RMHfhzlcAKDgZ7WF2fyOoWE?=
 =?us-ascii?Q?LcJPBpxz5COSqFIHbNZqjJP7j1QA2Fev34RQSwkNN9pruDP8dJ9QLr9LDDRG?=
 =?us-ascii?Q?SuLq3B+LN/TXHcf4eFahDwY02P1gCeGRHlypFbZ8/D5LmytZNi8gj+/fnrXJ?=
 =?us-ascii?Q?TAnS1QytUbAKgxlq8yR3R3gadKrJ3n507gkYdKkGPKR+bGnugerYilnJGGha?=
 =?us-ascii?Q?YyMqdAWmSd55GepWaTrNUWgh8N/b+grQzOcuMpvJDhJVcddKUBcdcIIrBlg2?=
 =?us-ascii?Q?LYKh1wt0/1wVSUT3fDd91DD/hq9qepis1pB/QGudRDy50QMKvXJVWC1NVCSS?=
 =?us-ascii?Q?7Dsl/SoSr3ysG3q0jUie/+LHNxAYElxtQL21rD7ORauvq5fAYA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5903.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gqfF9x9RRdlo+xN2g+GcZs3Hujv3Dev9d9nP8F8YoBUpIJochfH6rBhhxrZs?=
 =?us-ascii?Q?OfSuXoPZCZYh3cLDdw4BCtWYc06mKcBGqZ2o7dLeHAADdJnNzWvsydmML4wm?=
 =?us-ascii?Q?Dlg802MWbwZ4u0geRWfEPpiMokJI2u7m3oA1voqqjC+tWN6j6f1uQnXoi2OO?=
 =?us-ascii?Q?kRa/qoOZN3yxp9AYOTEvC33VqynMzc2ukj23RsDWudPfKuHIonJROLkxpo0N?=
 =?us-ascii?Q?UUfdQoE4Yh+9qp+vgq6IfUpIL1Aez5DBNRDCMc6svR/Cfbn/AzttPEiOFXry?=
 =?us-ascii?Q?MbK0gjfq2W1sBvS+whebdKU07MPowWbgEt74DUEIvaMH3DTRCd7WqqdPz6Zg?=
 =?us-ascii?Q?jMto/rPZboWipLkKH67BoC7GSierIoW6g/3a+dCDqfFw7xnv8oTNcWJV+ITC?=
 =?us-ascii?Q?e0Ei89mlaRyDQ79Yv72coSuckGpcCP+QxfkalQfWqtIaG3+fiAM9zt1l8m9k?=
 =?us-ascii?Q?AAX/L0Fwlhjtt6b+24fLnI0aVwJEFHm6iFG8+XsAoKpx9QYPBZinvFnMGR7l?=
 =?us-ascii?Q?SC64gBrmJIPd/dEx4nmA3JKavdBAimGYpDGnlp6fTwDtxrLvbRnKTKxNQs95?=
 =?us-ascii?Q?UZBOgtzyfHGxEy+NsY2XByynmb5DtUgzyDyw7RDinGTCvGrw23UT2yn7cCNF?=
 =?us-ascii?Q?UezHdDoX67CGMOu06Tym/8obp5e7KxzZXhIUO4myYongYkJwrotWSKxbUHGv?=
 =?us-ascii?Q?NXmraMownM4cJzLnyRcurMBtwGbhrHfoa5VpxtJ7MLSSflyu4Z5RQfG11ZnT?=
 =?us-ascii?Q?GquUmrJHkSDUrXZKY0bRFPSJIzuJTm5yAXSHPijVuPFBSSwNc/uzKKDBCxeb?=
 =?us-ascii?Q?k/8Ap+QrH3vZ7KNio/XpYYVJOr7oGgqr/xmodLLsaliUN60pUcoL1WxXoZP0?=
 =?us-ascii?Q?aGog4qb+hfWBW5mNUDDgQV+ytLP6ULOCU3CbgfGem/tuadzJH/djJZL/Y/4O?=
 =?us-ascii?Q?41nFP1wnVXKJDKuQ/2K0CktomvlUCoWqOhK4D3KSlHGWaEtVht7prU1q96yj?=
 =?us-ascii?Q?WQPsdqx54mGnV/Hf+/iulsqsTarUXlxnR/HpnpuBZFq+hIxH4X5sTNRwZldd?=
 =?us-ascii?Q?kn+Jqkn/cYz/8fYoe/9ns43tPg+aLFeFC2n4dIki3SZI+D8yWyFQDSZsRfk5?=
 =?us-ascii?Q?lSn4lLlrHSQiKF3K/NHsQ6XotQjVEjfTm0z+R1XUAaB4IQz3R46weR6pBZqI?=
 =?us-ascii?Q?Ckiyos3iRxKx7lsy4CI5rM7DFDysblpzqOAT56yIM/ljkr2HSSMD1m3xemZW?=
 =?us-ascii?Q?2jQ/mjzhriLtnnj9/+C7PCGbeQ1rBssZ9B/L+OO599SMMGvSGNPH4t0QZzH0?=
 =?us-ascii?Q?rbNxVjBCkIKGHVSct7A3dOR720osit6vDl/MF8ZZ2KCotm6Gbvu7aEblhn+q?=
 =?us-ascii?Q?1v9PzY7RE77rVecravb9dsLmQ57tH59zpuD6+AeIvVwghOtwUkRCoCsCkh02?=
 =?us-ascii?Q?2senTf73k2sm3kXYuhOIwIkq90WhpvoRizuxaOqY+/p8of4FBmchRLE3Gc0n?=
 =?us-ascii?Q?dGeLck7D5Yo2ToWRKWyRWtlXQgLr5GDVJp3eTqaE9JSATkUq6vMI+0sWAkFa?=
 =?us-ascii?Q?pEmQwzjFxWTyIZ3Mx3Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6195bf7c-0097-4805-f7b3-08dccea9c9b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 19:26:20.8322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0gVvEUsK67FvWKE7+5jg+A4tbsbCNYauIe54RXB9Q4PaFRuDYazKndjqKN12QNiYpQuKybvnhXxldy3MsEVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
>=20
>=20
> > +static struct mlx5hws_pool_resource *
> > +hws_pool_create_one_resource(struct mlx5hws_pool *pool, u32
> log_range,
> > +                          u32 fw_ft_type)
> > +{
> > +     struct mlx5hws_cmd_ste_create_attr ste_attr;
> > +     struct mlx5hws_cmd_stc_create_attr stc_attr;
> > +     struct mlx5hws_pool_resource *resource;
> > +     u32 obj_id;
> > +     int ret;
> > +
> > +     resource =3D kzalloc(sizeof(*resource), GFP_KERNEL);
> > +     if (!resource)
> > +             return NULL;
> > +
> > +     switch (pool->type) {
> > +     case MLX5HWS_POOL_TYPE_STE:
> > +             ste_attr.log_obj_range =3D log_range;
> > +             ste_attr.table_type =3D fw_ft_type;
> > +             ret =3D mlx5hws_cmd_ste_create(pool->ctx->mdev, &ste_attr=
, &obj_id);
> > +             break;
> > +     case MLX5HWS_POOL_TYPE_STC:
> > +             stc_attr.log_obj_range =3D log_range;
> > +             stc_attr.table_type =3D fw_ft_type;
> > +             ret =3D mlx5hws_cmd_stc_create(pool->ctx->mdev, &stc_attr=
, &obj_id);
> > +             break;
> > +     default:
>=20
> Hi Saeed and Yevgeny,
>=20
> Another minor nit from my side (I think this is the last one).
>=20
> If we get here, then ret will be used uninitialised by the if condition b=
elow.
>=20
> Also flagged by Smatch.

Thanks Simon, fixing this as well in V3.

-- YK



