Return-Path: <netdev+bounces-95286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1258C1D0E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C4C283EF5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F91494A0;
	Fri, 10 May 2024 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ISwV0vGC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251D13BAC8
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312157; cv=fail; b=YO3KYvnI1Sqhq2pCYBTcUKOxx7k+PKGwh1tHu39DPNlvK6HqWHRqLrRjYNi+qbaFNtn8djzOJOnyO8Pd2JEwhPiTGZIgHn5DrKe3wlw2fMCdy5C65vI8JODQTPS9gaiv077LoqpLS1SuSDk1YIuQGNy672T3kCwfmzAM5xLfYcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312157; c=relaxed/simple;
	bh=436qa4gcmUobIawzk79ESMQIUpeo0lPdvsbTMAN4Gfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iCdA0TQ7kR6418WcBxpeIkpyFJg6FNjF4zKeJgagkt2754s26j2LxE1MdNd2fz5VKJFjwz2+MhVRzAsz6nNDsivN7+/SOY3yXPNuOlVobXHs8PTaX9v78T2hdoRKSwt3tZmxL+FywfYNRILQigBOwz65nrU3Q1uPOnEovy6WSNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ISwV0vGC; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US/xHubmU/0U7CBGNuf2fUwfQjkapGSPPfvjaoAi5EdCTMfMAzIB07gz3YAJOxJplHDtXryfP4YvnkygzidPm1YQImAk0fQ9ExU3Lc4uzBSwZnG8XRSdyqyVl10cUwwbeRaW/LLAJpXTJolB9YSOv3pUvFG35d/jdut/yCbTwCkBz0Q4DPenhjLk146L2IV64jR/o0sesJMbUcKTXSc9beVIrg2xTBa/fAnDwnr39SWWtcSWZnYRoBp0+cSHbUyTJ3x8jsQ01kcjfH/fz0e5q3FslfqfXAJoDoassW0zTllaxP1qQ0Nz7PGuhplgW6Gn9JjkI2QIvx5Ces0Cv/klFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWJssnuv2do0ArDppKg/tWsD9rmkO2mXGuI2xL6msAs=;
 b=C04AORULHWNrXM9vvyhvGER+ct0Bron4AKxp782BEuY2RZoaVkzbl/3baqjMLy65/Q+xkXKNkV46aMBIVeYY7b28fVmzlo3uQNHzba3gIYvUPahI17bMYMx6KkS6FZnnBVN9hovBCD223yFqDHSZ16rNQEx0o/tKJ1z8T9VPaahP7b63wv7E3M16AV032QIRFHbxK9LvZs+gIILu7g/kL33WGVUQ3R0hNkVEnXGXkMueq+Ep7vqSmhndRkVeE4w6/LcrJGNR8d3tTpUbg4xuR+9ycEVLjNH3U44RTqia/8YEB+53v3JjIpkZpszCE68OpMpYmXG7FljavWU7SY/LAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWJssnuv2do0ArDppKg/tWsD9rmkO2mXGuI2xL6msAs=;
 b=ISwV0vGCEUSoggW3DK4XoSRGPtK1yoWdSIQMdc6Q4MmVFfKKL2kokoRpXoKYVzUiiwxkuAc3lbiLsNFkbu7Fw/Mj8YUxvrkUF6eo5bTSnzlQfCW9ZSN2YshtuhsXcAX88EaU5xDpDB3QNQ3omfjNSkD7xQZXGlJ+aM78lkZ2W/GsUjLJayuGt8bSG4p25LF7QH3thSxVBVOlrghTs74SUe09GTQ3gngun1/AYbLzrjQpAxScit5LW0UtA18wGyWTZ//Oyb4fiwOCEvWjCptpeO18jUe97gbGrC6aSJF+OPxpcotdleXVGeQPxVXpQG8/k0xGfXXGn7KOTvhDJHR0fg==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 03:35:52 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 03:35:51 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] virtio_net: Add TX stopped and wake counters
Thread-Topic: [PATCH net-next 2/2] virtio_net: Add TX stopped and wake
 counters
Thread-Index: AQHaoi6J6tLvGll9VU+Q5A4TKtcS4bGPrG8AgAAlEKA=
Date: Fri, 10 May 2024 03:35:51 +0000
Message-ID:
 <CH0PR12MB858086B1DEB3F5D4015D937EC9E72@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240509163216.108665-1-danielj@nvidia.com>
 <20240509163216.108665-3-danielj@nvidia.com>
 <1715304096.399735-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1715304096.399735-3-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|DS0PR12MB7803:EE_
x-ms-office365-filtering-correlation-id: e5b90b00-2b5b-4e29-4ed1-08dc70a24a88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?udfp7XU8gvLmmjT7SXSB30kG/qB0Aq5tOtojkgiG2IWSbvALYsgmJCKxvwr9?=
 =?us-ascii?Q?DRi4GAys/YiKFbTFdfbUqbSGPCpRfulsL6ZsKprJLe9eEUdzPSKVy9ziobj9?=
 =?us-ascii?Q?/Cu7pu2fRJQC3vLnDCKhkMclhmg3msyZBD7CkRfggfBnaiQvdPTqwUxgiD25?=
 =?us-ascii?Q?e5aSX+PxqhQGGrbBkSNQPNfV4EdTS7dHumyNUSr12O9SG2ikGWy/uadTWyPj?=
 =?us-ascii?Q?LHxR+dRUcNtogUeMzezsUa3p5cbDpPDsNfWNj9h8EIx8Y9AIfxAKNgZwY/ij?=
 =?us-ascii?Q?u75GltmSbjx9kVHgka8qHkVoOAlzc4d+8J3SC3a77A20rCI2Gzx5LKW8xhWr?=
 =?us-ascii?Q?/JxDiMM7BFvyQbii8dVPJT+maqKvrt/ocHc99RHiDm25dmeQ+sRn03C8c9FH?=
 =?us-ascii?Q?PJV572tpuPH56rFkZL3Oo80AY8/VGiHv2aQxw+rJoqP4LLV8X+PW0aqLhlt+?=
 =?us-ascii?Q?NR/Ye8q6w6en3xPmWVlQTNLmtJdekCp7Kto3RvEEqPJNLH2k0AWrBXCXooMp?=
 =?us-ascii?Q?okSGmr8Wm/tzcDfgi9keQhaDwM+9EMo5OTqJidmA478Rdwn+hGOw/NhTm2qO?=
 =?us-ascii?Q?TSS6Iky/g4fHW7BX7+Yqb2PpaU6NShvbxTjAoYFyg9G+tOTxm+JbzxzO11QA?=
 =?us-ascii?Q?YvC0T48/UrIBStC/n4CIZ+ThLUri5rzME4rad/TUm3Vf1nsEk5SlXbCdsFoK?=
 =?us-ascii?Q?600bDI+zPGaeoay/1b7MsJH+67Z0h12g3nC12J5mXghiYDg2jDpf8IK3/vc7?=
 =?us-ascii?Q?7dO2YtbzvuTO4NgkoRwmEKnzaXUIkPepJJmZynQQGxof/hL8TJ8ja8qBMeO7?=
 =?us-ascii?Q?Zfir6yR0/4hnIZxXDgORXSmGWu+WY+i9U2s85hgaFM+pOek+5j+IQP/lVxV9?=
 =?us-ascii?Q?jDmV9R8/eS+0IHYWlFyPFZ6+njLdZ2OZ0SJ1pLtYaHgt1wWskIKuFFyoseV/?=
 =?us-ascii?Q?LRJZZ9gUy9LGAuxc+0Hhi+4Djc0JkXLxJZZSVlkeVo20FxMKMPFf+g4Kx/ca?=
 =?us-ascii?Q?QmXu/eKy9h3NckrImIiyy6qb9oXZTKUVk/ilnyn9h07wgEKVjL3o/nhowTcV?=
 =?us-ascii?Q?jI7/RunCT2Dd0PN8EMiIK5YZI6/Ox+Ubmdsp5bMEY/M2wgG58TmkGMc3EmJP?=
 =?us-ascii?Q?HIffZlvbbhh6TodQooA7eCXkmCVp8T/1YraV4h64BgmI4kzsoGPPNGnO7Cgh?=
 =?us-ascii?Q?Ju2ZocHXIdfGD9z1zli1m/zctAbdta5X0qzgyrqz4B14rBUvnj8oVuDfieIg?=
 =?us-ascii?Q?/xlQHLmyihwR+aYFVnQpbO7gPtCal12PJpfkE4vT9JkXRxtOnejO1ZVXMurP?=
 =?us-ascii?Q?4yqS4Qj+AvZlvfk/kRkeWmwuA6CkbNEhMv/WXVCWSdbDKw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lrkYiC1j8Jez548WnTiZGkzG6RY+bK4apWbeXJTnjGg9uh+g7dtLWm0PvLwb?=
 =?us-ascii?Q?wvLjJNusZsiFL+1dUIunKE9G8ElnPxNy4h+HDP91rDIpfzQYgWv8+qbwpW0V?=
 =?us-ascii?Q?95tF5ZD6p48A/g1fpzgiYYzdD1NZI8mjqDisIiFxbyJ/gPqRv5RGZQMZBk5H?=
 =?us-ascii?Q?XZOtYHR7M3hE1j1UqU4wgy1URKOhwXSV1Vkk8sXbsNNTOYCFilrgh5wByiSt?=
 =?us-ascii?Q?jkQIqOrfWQCUCu9eZ5KRCRcNsCJq0KUIY4PysiTBVhI3uybgDbRQGcLUn4Xv?=
 =?us-ascii?Q?0PPbe/Rq1c5v9M+KwmGzeJ8BPMgSLT8H6j1zGOI3G3EAf5HBqUwrqnjqPsS1?=
 =?us-ascii?Q?ZkXj7cahv23uy7Rq4glUTEc7s+Y9ylwiptVFP2hYACe7ramMarsT+Na877UD?=
 =?us-ascii?Q?NIGPlxh/z5Y1d3xbjyXtsxsppkB47ngZx6qOGGxOdSPHd2Ko6PpegIdi1tU8?=
 =?us-ascii?Q?kCOI1KWCjbnstSg5KLEuJbpG+cB8x8z55dI5kl1PIL2M8HxeeVq1gvOen/pG?=
 =?us-ascii?Q?3y8a680iJNUcR5cVA/G6JTsY6NH3sQrtqwupm0T1IDhS127lkDB54p7CGps8?=
 =?us-ascii?Q?/1ltjuMwirzBbIFNtULnuVpNCr8LPQDEF4jsthCgSKMA2L5b38ZYSJ7xIHli?=
 =?us-ascii?Q?Cvl6XFzCHDtwDOX73rvfV1cuMHzZ9zHbbuc8P3UxLurvQdocOsTfrJ+get2e?=
 =?us-ascii?Q?WtuXeqZjs5YYaWvo1BnX+MJVYSbAKJ2qK8JslSc6O6tMOMRUsXe9aHhBGPbz?=
 =?us-ascii?Q?pOo1yYiquM/bhYfWZJvMHx5Ku/75Xav2Ms59PJVn7a/YJ59+eEgw0jrC7gqh?=
 =?us-ascii?Q?nMDvyOyjfRSQyVtfXJHpaepZ5648x8WgQ572KTWLGucU9MHeH2LcOWO2BLfm?=
 =?us-ascii?Q?kUxkEeZ/JRB5J9IE7kahsWoD1y3d3PuXT1DoM2sAQgbsZgbc72AnawV6Jw37?=
 =?us-ascii?Q?FVQqvVdTTXnfJPBQl0UI2HCL5N5CqjiGvzQd71ip67HioWi1shdGZQu3gXKw?=
 =?us-ascii?Q?P9TheNFrghbKf/iMNIHF5e3ItO6tkh8hCHPYc5OwVBsVOAupSBE4N0L2W80J?=
 =?us-ascii?Q?cdyDRdGFKs47VVb/kzCvuHezZ2j6Xdig3EenvNr6Uh8F77A1Kr4mLFrpD9w7?=
 =?us-ascii?Q?arhGqmtXjB0y8q3pDhvfmYZhKUAprC2g+tG+UwQ3rXT16B58+9xCuOViumZx?=
 =?us-ascii?Q?rw+7Tlage24A7jX5MwA4XRqRrTv3cFmvOVlhBLzy4uqp1q9vEDUkYeTQ+zmK?=
 =?us-ascii?Q?Aes+x1XZf5352LH/EMT7uWT3RS76vR5XjL/w2aE5q7vgD3RXpRK3KOarHTNA?=
 =?us-ascii?Q?9K2b/oBWZKiXV4OnIKa2TV1fvjYf+OsRE8eiGILqmHAGCdeinD31lTl+KdRy?=
 =?us-ascii?Q?tHJwGbm1Xa0QBgzPrvJlHcP81uFjD+pqF3qEyJ9JuX3YbVn5D8cOOBY3Axx8?=
 =?us-ascii?Q?zChDsGb1HFR9LkU25gft77MaH8XWwAuMCVHzL5LUgpxdDLjdgY2zF7ydKOPE?=
 =?us-ascii?Q?O4zu04af87YUA4PJpegyFPeH+CzPxJbjAoC3cYBERNnE8BsCTyx0M0nWhk1p?=
 =?us-ascii?Q?cvVroaoBkKSeF3D1Kos=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b90b00-2b5b-4e29-4ed1-08dc70a24a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 03:35:51.7185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WQGnfvHBciD+RLiQkYBYk2GZxdh6oIkzWV+0LPB3bp3Gc4tDP+72thmbGBioKOiQ6n/NXZPO+xQiWZmEPLxqVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803

> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Thursday, May 9, 2024 8:22 PM
> To: Dan Jurgens <danielj@nvidia.com>
> Cc: mst@redhat.com; jasowang@redhat.com; xuanzhuo@linux.alibaba.com;
> virtualization@lists.linux.dev; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jiri Pirko
> <jiri@nvidia.com>; Dan Jurgens <danielj@nvidia.com>;
> netdev@vger.kernel.org
> Subject: Re: [PATCH net-next 2/2] virtio_net: Add TX stopped and wake
> counters
>=20
> On Thu, 9 May 2024 11:32:16 -0500, Daniel Jurgens <danielj@nvidia.com>
> wrote:
> > Add a tx queue stop and wake counters, they are useful for debugging.
> >
> > $ ./tools/net/ynl/cli.py --spec netlink/specs/netdev.yaml \ --dump
> > qstats-get --json '{"scope": "queue"}'
> > ...
> >  {'ifindex': 13,
> >   'queue-id': 0,
> >   'queue-type': 'tx',
> >   'tx-bytes': 14756682850,
> >   'tx-packets': 226465,
> >   'tx-stop': 113208,
> >   'tx-wake': 113208},
> >  {'ifindex': 13,
> >   'queue-id': 1,
> >   'queue-type': 'tx',
> >   'tx-bytes': 18167675008,
> >   'tx-packets': 278660,
> >   'tx-stop': 8632,
> >   'tx-wake': 8632}]
> >
> > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > ---
> >  drivers/net/virtio_net.c | 28 ++++++++++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > 218a446c4c27..df6121c38a1b 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -95,6 +95,8 @@ struct virtnet_sq_stats {
> >  	u64_stats_t xdp_tx_drops;
> >  	u64_stats_t kicks;
> >  	u64_stats_t tx_timeouts;
> > +	u64_stats_t stop;
> > +	u64_stats_t wake;
> >  };
> >
> >  struct virtnet_rq_stats {
> > @@ -145,6 +147,8 @@ static const struct virtnet_stat_desc
> > virtnet_rq_stats_desc[] =3D {  static const struct virtnet_stat_desc
> virtnet_sq_stats_desc_qstat[] =3D {
> >  	VIRTNET_SQ_STAT_QSTAT("packets", packets),
> >  	VIRTNET_SQ_STAT_QSTAT("bytes",   bytes),
> > +	VIRTNET_SQ_STAT_QSTAT("stop",	 stop),
> > +	VIRTNET_SQ_STAT_QSTAT("wake",	 wake),
> >  };
> >
> >  static const struct virtnet_stat_desc virtnet_rq_stats_desc_qstat[] =
=3D
> > { @@ -1014,6 +1018,9 @@ static void check_sq_full_and_disable(struct
> virtnet_info *vi,
> >  	 */
> >  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> >  		netif_stop_subqueue(dev, qnum);
> > +		u64_stats_update_begin(&sq->stats.syncp);
> > +		u64_stats_inc(&sq->stats.stop);
> > +		u64_stats_update_end(&sq->stats.syncp);
>=20
> How about introduce two helpers to wrap
> netif_tx_queue_stopped and netif_start_subqueue?
>=20
> >  		if (use_napi) {
> >  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> >  				virtqueue_napi_schedule(&sq->napi, sq-
> >vq); @@ -1022,6 +1029,9 @@
> > static void check_sq_full_and_disable(struct virtnet_info *vi,
> >  			free_old_xmit(sq, false);
> >  			if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS) {
> >  				netif_start_subqueue(dev, qnum);
> > +				u64_stats_update_begin(&sq->stats.syncp);
> > +				u64_stats_inc(&sq->stats.wake);
> > +				u64_stats_update_end(&sq->stats.syncp);
>=20
> If we start the queue immediately, should we update the counter?

I intentionally only counted the wakes on restarts after stopping the queue=
.
I don't think counting the initial wake adds any value since it always happ=
ens.

>=20
> Thanks.
>=20
> >  				virtqueue_disable_cb(sq->vq);
> >  			}
> >  		}
> > @@ -2322,8 +2332,14 @@ static void virtnet_poll_cleantx(struct
> receive_queue *rq)
> >  			free_old_xmit(sq, true);
> >  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> >
> > -		if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > +		if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > +			if (netif_tx_queue_stopped(txq)) {
> > +				u64_stats_update_begin(&sq->stats.syncp);
> > +				u64_stats_inc(&sq->stats.wake);
> > +				u64_stats_update_end(&sq->stats.syncp);
> > +			}
> >  			netif_tx_wake_queue(txq);
> > +		}
> >
> >  		__netif_tx_unlock(txq);
> >  	}
> > @@ -2473,8 +2489,14 @@ static int virtnet_poll_tx(struct napi_struct
> *napi, int budget)
> >  	virtqueue_disable_cb(sq->vq);
> >  	free_old_xmit(sq, true);
> >
> > -	if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > +	if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > +		if (netif_tx_queue_stopped(txq)) {
> > +			u64_stats_update_begin(&sq->stats.syncp);
> > +			u64_stats_inc(&sq->stats.wake);
> > +			u64_stats_update_end(&sq->stats.syncp);
> > +		}
> >  		netif_tx_wake_queue(txq);
> > +	}
> >
> >  	opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> >
> > @@ -4790,6 +4812,8 @@ static void virtnet_get_base_stats(struct
> > net_device *dev,
> >
> >  	tx->bytes =3D 0;
> >  	tx->packets =3D 0;
> > +	tx->stop =3D 0;
> > +	tx->wake =3D 0;
> >
> >  	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_BASIC) {
> >  		tx->hw_drops =3D 0;
> > --
> > 2.44.0
> >

