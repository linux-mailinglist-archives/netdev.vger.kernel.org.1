Return-Path: <netdev+bounces-67300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7096842B13
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 18:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A89B23EC6
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67814E2C6;
	Tue, 30 Jan 2024 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n4UCLTbE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5E14D42D
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636041; cv=fail; b=GkgGAco6eWkOSuOmAkiWFNPbY1dqsyn9ZTws6+rxMOyunuPLvbRIrqokJTL0jBdQKlbQEG+UsBzXIk7DPeK1jYV0GmtgF+qU04XCD+6yCLnXVKcR8FE6l9NvlsHscOvpccKcJ3COfBCHwoRjdXtZ8ZktioZu1a2QSFEp08mM+rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636041; c=relaxed/simple;
	bh=0bobV7zFZiOskAffg+cfsczOk/TYWYpJmvqZZH7QmLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ObukbdFDI3Si9Q17sA28q0UuKug0x2ekQM65FfVR4Ff4z4Pw4GUr+X5SSCF+SjkJRSr359cZuUeCcwDfXWIuvBi6La8hP7Fyd1QdspQMYhjBJ826xtXBtC+BkBpoy7U1RrdlNJks0TFAsirxFIocuIO7Tfwb9T1urgi/Xpt71OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n4UCLTbE; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9StF9JtA2qc92VsMTwuxL4h5sqTYE5MniBcGfkDd2sErZln3Kc/cPLD52cq0TDPyyG+jZBQZb5Z5ID8LnNUTpEBSJeS3A/a9zMwrCuXVLyqHSRmXuSHf6ELNLi0BiaOu6tuo9m0M0b9aItQbSYOdT/ClYUZ2b+DEtocR9e2eAZZbrNT6br8PBpTfZQJoeGuUke/PL43q5RJPVclV5Y+RrR9KKmhuD80v45IGx79N2xUqZlJUdZLtHZ0+usdcp+e5pGNR5PasrLig+lpUN+NeKqiUsAXAyAhI8RfteSbcY2wqjUKO87f6tkrQ6pJq3JFEk255B6n5q9nDus4Ng9uPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtuHhEJICMjSX01Pm///wKP440qaK6V3dj8NCP/gciU=;
 b=FNgcDdgOBnCl8/kBoqxnO43OnIHHKugMsb4kSiHFc5aMUwtcvRLAZvgacoAb1qHZiobpWQ02qsf7tDs8tLnG2XQiZQ22CutaRtQMc4VavMHMvKoF5d5KRtMzCn1QQLparZ+HUkhMFX1UXRDWICI8jEKMM6RxJMQqnMECG/ddJIF2L5xKlwrihWvmqsIm8uBcK2m2FwgfHqbeU7wxW6AvtOGU/XQ8IKogPnChMZzd8qpfIdXF030iWmff3ECiUqDVVytMvfpijk9V12B0rTD8C7sxFaW6jNNkNTPxJoI/1xXZg0sLXbyGm12KDxzpPv4jEsfa4sR0kwtnRjew9Arirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtuHhEJICMjSX01Pm///wKP440qaK6V3dj8NCP/gciU=;
 b=n4UCLTbEu7qJE9ukKUaJzTy2wJGb9oqpkbzmVftIbHGC6PyZ0JqG7/ourWYDJTdTX6QW3FkGG/V3IAYjBt9VoQyDx5s4b89VXYwl4N1suLXX+o0YfY4LORi3XnSFF55Xqg/rXWbvQhKI3WarHZY6Y5aLxi52MPOguG/1/yZ6deiHfE7/k/F3eTFvHuIPtdP819GNs4IaeGOGr+KVUYiKs4e6J4sO8fsU9aMU0jn5bKX4rXlZPTWyYT+iTAQmjjD6cqA8VpDmpYm5SLne4rBe8QfUfsugH9Z+6eiyOTOZO1Rzo0oGQppkD1BgEPjk6q2gaAA6vib28BGR9oGQkQG1kA==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.32; Tue, 30 Jan 2024 17:33:57 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 17:33:57 +0000
From: Daniel Jurgens <danielj@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "abeni@redhat.com" <abeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH net-next] virtio_net: Add TX stop and wake counters
Thread-Topic: [PATCH net-next] virtio_net: Add TX stop and wake counters
Thread-Index:
 AQHaU4g6jvRyzH1tPUCIs6q7Q9im2rDycmwAgAAGRTCAAAXXAIAAAcJwgAABlYCAABui0A==
Date: Tue, 30 Jan 2024 17:33:57 +0000
Message-ID:
 <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240130142521.18593-1-danielj@nvidia.com>
 <20240130095645-mutt-send-email-mst@kernel.org>
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org>
 <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240130105246-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|DS0PR12MB6439:EE_
x-ms-office365-filtering-correlation-id: 1a434541-2220-4ea8-d2a9-08dc21b9a354
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BnBuX7FD5UbwHd0wx2Imdhks3uLCYLaXdFcOqTYQLnOeR5xtH59/alc7fJgx/v5ouTfXuKZdkTmBzWxQ7k92Wqg9A7uoKf3CvOtmeLKcDzIgeThW+6VeQGxYOyLn5R5MDt0oucnY44wXoChqFJV3dAOxmeQtLA8Cwt5rSPRIYEyOt02kNrhEeLyPFlV0ePaz7GI7yRRaVaeY3WRhJHAeJke+XvHAri9x2v0Cg1BahjvtwTyE1UQCG+nVk4Yv1iXALQmrr649iIvS+me32jlfDxB/W3RczZKm+Gb3Z06bRr9RP8Q/ZHLvPekM5bpcWu44RUiKbrXkNJM/w4Od/oHBBDNHgvvG+qo8nCTIkQLgX/jhrR3cSgaKtyackhlSyJUaYk850nWwLKrn7cJc8UYpZUEuIkNlX0mFP4uqYwGh5o110/VvvHUyuGEE3QuvbiKNOWh7Ricwvoc8e7p/4vXWaEfdbC9+1XrdhOgQF1w/X0M8AZQ04SA/71PwkdN9YDC1R7fjfgH2CF8aFPOCyp0dmlvhiMnWdjtSQsP4nuZgFAvZGBHH9XyP8mCLUCskA9+WVBsuY5j8NTHbE+uZEO5F77Y82odD1OrvCnih3DXwOhOR3HirOc07uQhD6XB8vt6y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(7696005)(6506007)(122000001)(66946007)(478600001)(9686003)(38100700002)(71200400001)(107886003)(8936002)(316002)(41300700001)(5660300002)(4326008)(52536014)(2906002)(66476007)(8676002)(54906003)(6916009)(76116006)(66446008)(64756008)(66556008)(26005)(33656002)(86362001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o2r1YEM+MJ7WChvPq4S8hvGX6x6+8RXx/J2U1NnjK+1bxyEiNQuPy4LWnHPu?=
 =?us-ascii?Q?Hu15s8R5Czz3QR6SQoA1dzWE693gTAs/oaki238S9vf/evvEJPQzyfAx1ux8?=
 =?us-ascii?Q?8+BEEkAjacjl4tWqqVTKr5aIzEH2FHrsT5pEeYc9xvirB8vCfmSBJCWZtWhh?=
 =?us-ascii?Q?BN5/R94YJgsAc+FeiOzNo50JF67VDr+pHkhKDIUJ7E2pl7ljmRF4fUpKib9c?=
 =?us-ascii?Q?o56CR+1set1cQcHdbxqRvvYTSP+8d3UAH9Az2UIQSV/OziKytqHnHoHeWma/?=
 =?us-ascii?Q?W4PnRhGtr84OFKLrrAWuX7ACf8RWO5Mno8kRrTcHpyHuOynF2sT9/l1bF6g/?=
 =?us-ascii?Q?H+zsgu5VAZZT0NdzRmT24EAo05msNqqZzwjgst39B0l0yrzFYupZm5sBuxgn?=
 =?us-ascii?Q?1dVzFVtFDg386f8e6KBF6ACq1Mp2Djh2/Acjp9cqs7zT0+kCvk+05pxO/NF4?=
 =?us-ascii?Q?iMeLaRxprzO7nrHiIZ/1GmdoiQn8I4EM7VH/c7lHA3SB2MYfkLB69oASR03t?=
 =?us-ascii?Q?XsYUszyT/p++YpNWmuMWpraaIM4aFtmdXezc3W8wRb/ljLeiUMBqLuK8HgQM?=
 =?us-ascii?Q?dGS0DWdYDAxYXurNwC4U9yvzuA6s05JwD4DFG6WwZ2S37F69w8yD1f+dLRnM?=
 =?us-ascii?Q?nZfnuLEzRyjW5oKlhcc1tn+xzPo9ij0Tg/2PSVFA8Z+A0fkWpmzEZE7Thd8U?=
 =?us-ascii?Q?s5QLUy1sLFQ+HldP+IR/LpgFxBm3aeSKaRQGP7yQmMoGuCt6/klMiGcrVwYz?=
 =?us-ascii?Q?v3r/7ySHKA78xMlwPlJhsFDcLXBObjEGkrlvpe5YL1r+7iyit0uE0g13rb0a?=
 =?us-ascii?Q?/YxupOL02XQqXndMxqXfX6oRiW37an9a3mrRMzghmBzU3yPtLD2Lk+kXKUj2?=
 =?us-ascii?Q?hfCosFqVowow4qclCeAr3N5e7Uzgz5fJ7s2/Sa7kThEWx1G57VnPe6Bvkrny?=
 =?us-ascii?Q?jEfdkDoVx1jLb1rCwx10RHfncd6xYLS8uIuL3tJFvgu5V5TI8JZHVNRwSvPm?=
 =?us-ascii?Q?i9YItue1uxIkc91ixmDQnDrNHWO1CWBx4QlutxRhcaJ3RZWcqfhF0XxB0DfK?=
 =?us-ascii?Q?4LOdvCSDt36Zpcz0jBaypVSnwuuEsJM0MV6XUByeVYjjn7Morp3wUjQS3lmg?=
 =?us-ascii?Q?rwio0CAskLXd6OIB5jm/fSbij8HF8L7DoiZfwPmYzeaS4vr7CTvqdo1aJnO9?=
 =?us-ascii?Q?MI6MSBBAztVmCpBnrGdeJ+VQAdKLRdNgsIQ7FexPRtCXWDTh0iRMEz5UTlTs?=
 =?us-ascii?Q?7sAzWeDMqs51hkYxx6NWEa9i8JL92CKiI5oPbBQ9Hhirc8MLULMJdW00Hj+T?=
 =?us-ascii?Q?lKTrq0fbMaM5SedBM4HuBrZHfzoS5849WZISLuU1wNKOERwN3zU21F4XLbxP?=
 =?us-ascii?Q?URbAZ6WD0Bwj44XeQh48j43VEPv6+mMowOCE+ZwF+OboG2KbE3D3quOm4iOB?=
 =?us-ascii?Q?xWo+kGbIL0p12+8aA0hFUgnDPxu+5RbwDJ8aWT3GfU440JepYENxCfZQv+9F?=
 =?us-ascii?Q?kBpTZqy6iICF5e0v78NsumXkOUwLqu9sWHgfdhovK8XKi6CZXkDyI8XqL+Ew?=
 =?us-ascii?Q?DjjgfsBT44B6nBt3BKE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a434541-2220-4ea8-d2a9-08dc21b9a354
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 17:33:57.2038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I0KQ8LNLPLiD+pRO6tzI8WK56h16/cvXrpJW0L9Icszp2EKWGxsxA8uIcki2+Dh8r+8ZJzwIx7wEKcODU8NUHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 30, 2024 9:53 AM
> On Tue, Jan 30, 2024 at 03:50:29PM +0000, Daniel Jurgens wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, January 30, 2024 9:42 AM On Tue, Jan 30, 2024 at
> > > 03:40:21PM +0000, Daniel Jurgens wrote:
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Tuesday, January 30, 2024 8:58 AM
> > > > >
> > > > > On Tue, Jan 30, 2024 at 08:25:21AM -0600, Daniel Jurgens wrote:
> > > > > > Add a tx queue stop and wake counters, they are useful for
> debugging.
> > > > > >
> > > > > > 	$ ethtool -S ens5f2 | grep 'tx_stop\|tx_wake'
> > > > > > 	...
> > > > > > 	tx_queue_1_tx_stop: 16726
> > > > > > 	tx_queue_1_tx_wake: 16726
> > > > > > 	...
> > > > > > 	tx_queue_8_tx_stop: 1500110
> > > > > > 	tx_queue_8_tx_wake: 1500110
> > > > > >
> > > > > > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > > > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > >
> > > > > Hmm isn't one always same as the other, except when queue is
> stopped?
> > > > > And when it is stopped you can see that in the status?
> > > > > So how is having two useful?
> > > >
> > > > At idle the counters will be the same, unless a tx_timeout occurs.
> > > > But
> > > under load they can be monitored to see which queues are stopped and
> > > get an idea of how long they are stopped.
> > >
> > > how does it give you the idea of how long they are stopped?
> >
> > By serially monitoring the counter you can see stops that persist long
> intervals that are less than the tx_timeout time.
>=20
> Why don't you monitor queue status directly?

How? I don't know of any interface to check if a queue is stopped.

>=20
> > >
> > > > Other net drivers (not all), also have the wake counter.
> > >
> > > Examples?
> >
> > [danielj@sw-mtx-051 upstream]$ ethtool -i ens2f1np1
> > driver: mlx5_core
> > version: 6.7.0+
> > ...
> > [danielj@sw-mtx-051 upstream]$ ethtool -S ens2f1np1 | grep wake
> >      tx_queue_wake: 0
> >      tx0_wake: 0
>=20
> Do they have a stop counter too?

Yes:
[danielj@sw-mtx-051 upstream]$ ethtool -S ens2f1np1 | grep 'stop\|wake'
     tx_queue_stopped: 0
     tx_queue_wake: 0
     tx0_stopped: 0
     tx0_wake: 0
     ....

>=20
> > >
> > > > In my opinion it makes the stop counter more useful, at little cost=
.
> > > >
> > > > >
> > > > >
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++--
> > > > > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c
> > > > > > b/drivers/net/virtio_net.c index 3cb8aa193884..7e3c31ceaf7e
> > > > > > 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -88,6 +88,8 @@ struct virtnet_sq_stats {
> > > > > >  	u64_stats_t xdp_tx_drops;
> > > > > >  	u64_stats_t kicks;
> > > > > >  	u64_stats_t tx_timeouts;
> > > > > > +	u64_stats_t tx_stop;
> > > > > > +	u64_stats_t tx_wake;
> > > > > >  };
> > > > > >
> > > > > >  struct virtnet_rq_stats {
> > > > > > @@ -112,6 +114,8 @@ static const struct virtnet_stat_desc
> > > > > virtnet_sq_stats_desc[] =3D {
> > > > > >  	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
> > > > > >  	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
> > > > > >  	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
> > > > > > +	{ "tx_stop",		VIRTNET_SQ_STAT(tx_stop) },
> > > > > > +	{ "tx_wake",		VIRTNET_SQ_STAT(tx_wake) },
> > > > > >  };
> > > > > >
> > > > > >  static const struct virtnet_stat_desc virtnet_rq_stats_desc[]
> > > > > > =3D { @@
> > > > > > -843,6 +847,9 @@ static void check_sq_full_and_disable(struct
> > > > > > virtnet_info
> > > > > *vi,
> > > > > >  	 */
> > > > > >  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > > > >  		netif_stop_subqueue(dev, qnum);
> > > > > > +		u64_stats_update_begin(&sq->stats.syncp);
> > > > > > +		u64_stats_inc(&sq->stats.tx_stop);
> > > > > > +		u64_stats_update_end(&sq->stats.syncp);
> > > > > >  		if (use_napi) {
> > > > > >  			if
> (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> > > > > >  				virtqueue_napi_schedule(&sq->napi,
> sq- vq);
> > > @@ -851,6 +858,9
> > > > > >@@  static void check_sq_full_and_disable(struct virtnet_info *v=
i,
> > > > > >  			free_old_xmit_skbs(sq, false);
> > > > > >  			if (sq->vq->num_free >=3D
> 2+MAX_SKB_FRAGS) {
> > > > > >  				netif_start_subqueue(dev, qnum);
> > > > > > +				u64_stats_update_begin(&sq-
> >stats.syncp);
> > > > > > +				u64_stats_inc(&sq->stats.tx_wake);
> > > > > > +				u64_stats_update_end(&sq-
> >stats.syncp);
> > > > > >  				virtqueue_disable_cb(sq->vq);
> > > > > >  			}
> > > > > >  		}
> > > > > > @@ -2163,8 +2173,14 @@ static void virtnet_poll_cleantx(struct
> > > > > receive_queue *rq)
> > > > > >  			free_old_xmit_skbs(sq, true);
> > > > > >  		} while (unlikely(!virtqueue_enable_cb_delayed(sq-
> >vq)));
> > > > > >
> > > > > > -		if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > > > > > +		if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > > > > > +			if (netif_tx_queue_stopped(txq)) {
> > > > > > +				u64_stats_update_begin(&sq-
> >stats.syncp);
> > > > > > +				u64_stats_inc(&sq->stats.tx_wake);
> > > > > > +				u64_stats_update_end(&sq-
> >stats.syncp);
> > > > > > +			}
> > > > > >  			netif_tx_wake_queue(txq);
> > > > > > +		}
> > > > > >
> > > > > >  		__netif_tx_unlock(txq);
> > > > > >  	}
> > > > > > @@ -2310,8 +2326,14 @@ static int virtnet_poll_tx(struct
> > > > > > napi_struct
> > > > > *napi, int budget)
> > > > > >  	virtqueue_disable_cb(sq->vq);
> > > > > >  	free_old_xmit_skbs(sq, true);
> > > > > >
> > > > > > -	if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > > > > > +	if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > > > > > +		if (netif_tx_queue_stopped(txq)) {
> > > > > > +			u64_stats_update_begin(&sq->stats.syncp);
> > > > > > +			u64_stats_inc(&sq->stats.tx_wake);
> > > > > > +			u64_stats_update_end(&sq->stats.syncp);
> > > > > > +		}
> > > > > >  		netif_tx_wake_queue(txq);
> > > > > > +	}
> > > > > >
> > > > > >  	opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> > > > > >
> > > > > > --
> > > > > > 2.42.0


