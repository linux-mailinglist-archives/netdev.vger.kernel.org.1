Return-Path: <netdev+bounces-67266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5177842866
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500D0286A7C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FA186138;
	Tue, 30 Jan 2024 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bLjGr/Ow"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0B286159
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629837; cv=fail; b=bZz0D+fk50APt+s8uuof1RrdPZ93pnA8gt6AHwHgHAvlQA1w7Ezi5brunmwqlolaP3LyVuDpnwed7jN+sjUC8Yjq0VpdrqNpvw5DaY2/aau1PmftA9rVfyW32YYFj2cPxUQVXM8ESarJFTDJ3acWrxVdFLgDqGOm5o2ZBcZUO/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629837; c=relaxed/simple;
	bh=uB/KrsXCp7H6Vx8AAU6JACo0cRqoMq0z0blB9Y0li0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CVmCaUjgPBEfzFx8nWRd0uDGPbQH4kpynqRJQnDsGq6MHp0IdERDLBpoJj1yvODhCfnh+nrwfVMkbYbcto7BzRo2JJJk1f8fT3P66B2udsiiDne9liFJXjuTtqWUXcWcT/8vP59UI40pHlj3snQ8Wr8yW7b38Jvm5jNAiPyRwNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bLjGr/Ow; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEw0lO1CjFHEJrIWuIj/n8pPODKTv9dN4PuvztQuX5jUkLCQQQGcAmNh7Fd5vL8R14zkOG/gvMTDdMsSRjMk9HGR+T29hitplZTAMlv3Pyg7jB6FmRoHsIYa+dW/Rm6zrMVMIhspXHj6Sx7sLhGEe3RXdz/H4Xb6WLkQ8hEKJqgL3C3keJoJXoo2TgnZ8CcqfjMdwqtAqa/n4bWsswAHlEKGfa6BGPrxm1vlnUJk7xNtBPrxE2zlvTO0Ii9HPJj0q1HjBTXYBavdkqqTtv9q9/rQ8H7+aU28qVDCFhe7mCCnFxuJbiYhtRBjT1IejT8tiY9p5uJnD8tNNykL03yOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIFoAJ7C3Rq04rPRHqHDhb9Z7bNJhCVGa65cjuxpG34=;
 b=iYx4qTo0+2lTnKI50lmSSssfZ0a4yQEaUSq77tuoWoX6OFA81m+4I/FjJWhbFMzDHtZcVSdkaJTkIOYfz+vJn19NbiiA5GjP47+w7xujV7H6OgwBExIMN33edeUoHRr6P+90PZ8KNDuBdc92loa+ysM5wbKXQfdvBM9v+5Ax7FBjrTEncW3dB/suuVOZuenVzXSU3fik3WC7EQ0xxoLAzKnW9tmLs/WSTuHY8gicKc33QORpvb7fyrR8nzKAW+MqKKkQE7tU82b2FHg9x3z/xLK7z5w3S67P7rFxcvBqK+ADFOEOssG4865n+Sl9STuFzb0yNbBzE/0C+Z0WBDWzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIFoAJ7C3Rq04rPRHqHDhb9Z7bNJhCVGa65cjuxpG34=;
 b=bLjGr/Ow2/uBRDQBwRXGtqYE5Kins5BCaD0OlASRaSAxZqbSJTy/PFVZSwruycRqPB1RBRbbkbB0Pb31hWrLmpqRgivCt4JmcBYjAysrO8IrWAkGM14Rw7zCSNUjF45hKT+Xe0R4BDTfkgddIxKcTW0A3apuS906FQ7soR3vmwD4nu4luE8C4d4lrUDdrSkFPH12x6NvP6agPR6KXjEVzfnLZcYeBQ8u+vl88c0V0Id63Klau6WEfiBWSxzCCz72XsAY0v1sUB5mwROb1JH5EQvIlgUMXjsZvu0pO5hkLxu4CXyoSIqkrIYeUPWPdzUo4BDIpgDY6gkxFIdFGuM+Dg==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 15:50:29 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:50:29 +0000
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
Thread-Index: AQHaU4g6jvRyzH1tPUCIs6q7Q9im2rDycmwAgAAGRTCAAAXXAIAAAcJw
Date: Tue, 30 Jan 2024 15:50:29 +0000
Message-ID:
 <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240130142521.18593-1-danielj@nvidia.com>
 <20240130095645-mutt-send-email-mst@kernel.org>
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240130104107-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|MN6PR12MB8567:EE_
x-ms-office365-filtering-correlation-id: d4030667-661a-4a3d-6fff-08dc21ab2f28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bwZziXmLQHG5ZfepSniQ02vhILWwIeawUfaJj3srXXCmUb3l8WIbhxO5DAPaJgCm0hCq6ySWZzwsXO8qKEScbzVZIhTuoqoS4ePgUiB7Dq3CFG7X6AIkGQxqMVyVivp55+J2RGIYoz7TR3trCLIf+XAPDmvYYKjYVx9vHjRHygmpvAx39tEjEVao3LKLOh7eKVUtFz2Y7Iu2U+cS+vsxJn7K6+uddgihxCYoQ0XXbfug/8b1x8c0bDRlv+MqjnNzDU/+VTOe3uxf/aaZIMVtW9ozBy72lmwhU0fOI4Bm/VucWLuPdvLj7a9Q5BOr4wCLOm+GCvCHG6bM5jPU8kNRVowiN+7th9JMh6Qi2jihiX5/n28toHTRG2cFOTL0dHhrtWcp8x2oZU3X1r+DgJhNddYxvjdUMuvOsYKqLYr17coMRKgV1IHBv6RmMPreX8CJuKgG3SYD9MOODjOwg1X5fAgyZ+4RudmOaLV3PXQSOF/umMLISRbEoKPC1N+bcqNxLdZJt2aPxGsZXf3SgpEHhvwbkVXR2JxW6+eydaK/5oDZ3lItjA/12nuRiLaICgBjMGoPITUE/85qJZiwr8X8IAjboSBdA+eItl1ypGzHCtvKyzpX0ELhV7tQibDM/Dd5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(122000001)(86362001)(6916009)(38100700002)(26005)(107886003)(9686003)(71200400001)(6506007)(478600001)(7696005)(5660300002)(64756008)(83380400001)(55016003)(66946007)(316002)(8676002)(52536014)(66476007)(66556008)(66446008)(76116006)(8936002)(4326008)(2906002)(38070700009)(41300700001)(33656002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hepvDBy6lzqI0MlOrc0vK8R9iWE+tX3VTjAQOOcuTjLKBwnmg2+8h4F3Gg5Z?=
 =?us-ascii?Q?6RZKS1KrHLKLJs+8pJLdTv7Yfz895cqa1+lPREYeq6u2JWDj3Kx8ozj3KRX/?=
 =?us-ascii?Q?xkF3sfrCC0jHfeAMSlpdR68IvIbh7b7tDL6xXjgFdmXLNd2icaLIZKsj/u2z?=
 =?us-ascii?Q?bKxooz1iHOXq7qNrzzdE/o0yGBogIYdSRlIqCn1k+CS/+c607OkXx9Ve6+fI?=
 =?us-ascii?Q?8h8Yr+5C4EujpJhy+FN31XzURI6/g1Ki6I8P/Yh/IWYo1E62Jhuj1DwJ7ant?=
 =?us-ascii?Q?D5oVAWdI3d5nt6xOMU2wfO/D/h3fzqjvzrbpKlQ5WnG99kgAhap6Fd+m5Vkh?=
 =?us-ascii?Q?cKzK3vw3VpKWlVjXKYaIIdY8dREfKCGgWReo98CMxOOoL0XYTE4Qj1NZXe7v?=
 =?us-ascii?Q?4SlNaYWjePC5MbGFZNgnPqrcTbaLDpEn6I7lvGmAdY9mvgqg0Ko89c5PSArX?=
 =?us-ascii?Q?rVJbK69jLmAlYnYECborWAizA8fIKNwtyR201diZ6vunRpE7O2U75vP5++TM?=
 =?us-ascii?Q?d97CZHx5CjFcrbdMdweAtJNSr/0Mo/nugDndj3OcEhmqeYHldC2maqouZL4Z?=
 =?us-ascii?Q?0KQizwrIaaKvCP7s8Q7l/S8bdEgVcpW/BOO8qxIJ38v3iND4qreLLGH1OZTY?=
 =?us-ascii?Q?WGkxbf5S0fmbK36A5voakKC3DrokYabtYaNrYNArZ3KXY94J/LUT+9OeZxA4?=
 =?us-ascii?Q?lfpg7/gdp1zryZT/flIKe2DAdFMR3RlF/Vy/LPeebkAQD63NkXQWQNUiIwVT?=
 =?us-ascii?Q?oxMMx51Dn1MEjd649QBBV8SIWPXsx8sg1a0Av+b4Mvk85llYOVNT2iTJBoxQ?=
 =?us-ascii?Q?Su01/OlfDolea5FXkY8aqKS++NMGKfacjfF82myojKLsE1ws/KBOWrcGrDUH?=
 =?us-ascii?Q?Efo3DAV55zxMql5skU3oDt+a7jIVMsXp2xEvhU8TX9vSaAeJDMhOXGUj8Z5f?=
 =?us-ascii?Q?Lvu8zXx2WycBGlJqNjpCo9BVAVM5YOVZL0LGd1TH66T4nSnC5MSpkIQHEvbF?=
 =?us-ascii?Q?MWwYri4CVwucnIY0Uxa5eiDdXry251tHa+OYf2C+EjIZhFk4etD+WmKYPM2U?=
 =?us-ascii?Q?33zwWjxz58crGOYCRi/r59P9RgQRZUpOKhWtQcumAlrhzP8uuOD6nq8qxiUS?=
 =?us-ascii?Q?jCycFWiNLyRqYv3zUACIMJZx7OFkyoGDV6tWz3WF4jPKucr5oHRGMK6AL3V2?=
 =?us-ascii?Q?ZC3elvdznIVFRkt6CmHB3Ef3hfPmlRMhrNh9UDRQNbr7Lo35yN/3cB69nTYs?=
 =?us-ascii?Q?0lJmN8QiSh2c7eMG58qFn96HDa4NCvTPXghyRGwrTY3Kbf83ZZHJNldwYBV7?=
 =?us-ascii?Q?Zagiiil+fprtVy6WJ1nxRRRLkCsRs7jS5mvqnEkEtmnvHbvZ2RHtlrqnSS4Z?=
 =?us-ascii?Q?MloFHoMwzQXaEtVRGQFCcstQzMn13o9R39oaRskltonNzqiH6OLMHxL3li+5?=
 =?us-ascii?Q?pI4rDLN+UcU3rWnpPiyYjuhUD5LZB3swL9uMDePY+HbkQDrR3ferpKbKn01b?=
 =?us-ascii?Q?rKHFoJEYyOqr5/PJMXtL7I2Vo85Mqxw3rmbun1EWc1jPRdEXCjmIxYXVtP/r?=
 =?us-ascii?Q?6UrWeh4Ef43kwFmKeJU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d4030667-661a-4a3d-6fff-08dc21ab2f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 15:50:29.3912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/r/6uPEKI7lkXUGD5KOhVUD8WhdRDgSJYNcJ5LC8s/TJb3oaM5ZZ6dUe3fZP4ZEY8RdkmE1PsHswpE/ZHt5gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 30, 2024 9:42 AM
> On Tue, Jan 30, 2024 at 03:40:21PM +0000, Daniel Jurgens wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, January 30, 2024 8:58 AM
> > >
> > > On Tue, Jan 30, 2024 at 08:25:21AM -0600, Daniel Jurgens wrote:
> > > > Add a tx queue stop and wake counters, they are useful for debuggin=
g.
> > > >
> > > > 	$ ethtool -S ens5f2 | grep 'tx_stop\|tx_wake'
> > > > 	...
> > > > 	tx_queue_1_tx_stop: 16726
> > > > 	tx_queue_1_tx_wake: 16726
> > > > 	...
> > > > 	tx_queue_8_tx_stop: 1500110
> > > > 	tx_queue_8_tx_wake: 1500110
> > > >
> > > > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > >
> > > Hmm isn't one always same as the other, except when queue is stopped?
> > > And when it is stopped you can see that in the status?
> > > So how is having two useful?
> >
> > At idle the counters will be the same, unless a tx_timeout occurs. But
> under load they can be monitored to see which queues are stopped and get
> an idea of how long they are stopped.
>=20
> how does it give you the idea of how long they are stopped?

By serially monitoring the counter you can see stops that persist long inte=
rvals that are less than the tx_timeout time.

>=20
> > Other net drivers (not all), also have the wake counter.
>=20
> Examples?

[danielj@sw-mtx-051 upstream]$ ethtool -i ens2f1np1
driver: mlx5_core                                 =20
version: 6.7.0+                                   =20
...
[danielj@sw-mtx-051 upstream]$ ethtool -S ens2f1np1 | grep wake
     tx_queue_wake: 0
     tx0_wake: 0

>=20
> > In my opinion it makes the stop counter more useful, at little cost.
> >
> > >
> > >
> > > > ---
> > > >  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++--
> > > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 3cb8aa193884..7e3c31ceaf7e 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -88,6 +88,8 @@ struct virtnet_sq_stats {
> > > >  	u64_stats_t xdp_tx_drops;
> > > >  	u64_stats_t kicks;
> > > >  	u64_stats_t tx_timeouts;
> > > > +	u64_stats_t tx_stop;
> > > > +	u64_stats_t tx_wake;
> > > >  };
> > > >
> > > >  struct virtnet_rq_stats {
> > > > @@ -112,6 +114,8 @@ static const struct virtnet_stat_desc
> > > virtnet_sq_stats_desc[] =3D {
> > > >  	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
> > > >  	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
> > > >  	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
> > > > +	{ "tx_stop",		VIRTNET_SQ_STAT(tx_stop) },
> > > > +	{ "tx_wake",		VIRTNET_SQ_STAT(tx_wake) },
> > > >  };
> > > >
> > > >  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] =3D =
{
> > > > @@
> > > > -843,6 +847,9 @@ static void check_sq_full_and_disable(struct
> > > > virtnet_info
> > > *vi,
> > > >  	 */
> > > >  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > >  		netif_stop_subqueue(dev, qnum);
> > > > +		u64_stats_update_begin(&sq->stats.syncp);
> > > > +		u64_stats_inc(&sq->stats.tx_stop);
> > > > +		u64_stats_update_end(&sq->stats.syncp);
> > > >  		if (use_napi) {
> > > >  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> > > >  				virtqueue_napi_schedule(&sq->napi, sq- vq);
> @@ -851,6 +858,9
> > > >@@  static void check_sq_full_and_disable(struct virtnet_info *vi,
> > > >  			free_old_xmit_skbs(sq, false);
> > > >  			if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS) {
> > > >  				netif_start_subqueue(dev, qnum);
> > > > +				u64_stats_update_begin(&sq->stats.syncp);
> > > > +				u64_stats_inc(&sq->stats.tx_wake);
> > > > +				u64_stats_update_end(&sq->stats.syncp);
> > > >  				virtqueue_disable_cb(sq->vq);
> > > >  			}
> > > >  		}
> > > > @@ -2163,8 +2173,14 @@ static void virtnet_poll_cleantx(struct
> > > receive_queue *rq)
> > > >  			free_old_xmit_skbs(sq, true);
> > > >  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > >
> > > > -		if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > > > +		if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > > > +			if (netif_tx_queue_stopped(txq)) {
> > > > +				u64_stats_update_begin(&sq->stats.syncp);
> > > > +				u64_stats_inc(&sq->stats.tx_wake);
> > > > +				u64_stats_update_end(&sq->stats.syncp);
> > > > +			}
> > > >  			netif_tx_wake_queue(txq);
> > > > +		}
> > > >
> > > >  		__netif_tx_unlock(txq);
> > > >  	}
> > > > @@ -2310,8 +2326,14 @@ static int virtnet_poll_tx(struct
> > > > napi_struct
> > > *napi, int budget)
> > > >  	virtqueue_disable_cb(sq->vq);
> > > >  	free_old_xmit_skbs(sq, true);
> > > >
> > > > -	if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > > > +	if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > > > +		if (netif_tx_queue_stopped(txq)) {
> > > > +			u64_stats_update_begin(&sq->stats.syncp);
> > > > +			u64_stats_inc(&sq->stats.tx_wake);
> > > > +			u64_stats_update_end(&sq->stats.syncp);
> > > > +		}
> > > >  		netif_tx_wake_queue(txq);
> > > > +	}
> > > >
> > > >  	opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> > > >
> > > > --
> > > > 2.42.0


