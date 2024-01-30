Return-Path: <netdev+bounces-67260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DD0842830
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E2F2829FB
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6425E823C9;
	Tue, 30 Jan 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eLs7gp8R"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9151B82D7B
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629226; cv=fail; b=DyRgDCzJwB1yv/s2S7psngoaaonaFDuajcKUMmHa04Aa7LX3QPJ0MLVAl8s/TlOoGcj/WeMOWVGtQBCOibOag8jmaP4PKSAV0bjMBHKdNo6PGKaWUzXALFM+6Ulh6nf+O69rTyfBLEqU+TRyjjnZxk+UyQygwpTP5Z7xBNGitgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629226; c=relaxed/simple;
	bh=cc3pwuEAIn7+uDI2uYLgNEZx4x7XFL4W5m8q1TVtBRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FyINV5lZlWEdhp84N6Rx9Ynq5lmXzqh5W65SZA6oMsZYOXOrHaMyu7da6iOdSA6vCF6t7SY0h1oivJhCFDkAhEpNCdkdxakcaPITGUkz9PMuSKLTDkYpqXmYctdDGi3EDqfLq0qo/gWKetULDkwrBSYwOvQ87AQJ4AdwTKbBEwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eLs7gp8R; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyzImqZELmJSwpVS77U7o2NBnduJ5iUJiXZGd9wp3GnHJoMRppJuxzNAtgOEr5mBhhI0JkN/wIXY94JCCZ8IUQpo+Su8Q0bTxb6+dyKY6fT6eeX4cY3soRZHFLH+4URRfJF4B2MYlxmq3W5rH/4l7LJcTxzs22PtJrmAiu/ivcZVooJsP/s6AkV8Wdkk3685qVcg+jdTH0yhmz/Q2h0EPz3RI1r85HhfPiXzu9ByvrpQiRBAeVKXje6RfBhmPp2CAls1b6G5c8LHmTDSMsNqAyGGOFXiQy/bf/oQcPBwafeLYBA//c5ZjzGUnoVfkNau9i6zQz30nYAn8Wyi01E1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQC2FG8QixVMaHL/7YL2B45EeAMq5mGO3/zBFuy0kcY=;
 b=epXqrq3SqXzQZ0eeArxZmibASMqumbBk0FHpoooSi4oncwfkubcn8DcyVFNqgOvwh6y3GZze0EwBTBdlW99JEP1tx1/Xfh/2Oo8TjsnTR8l4txMF9OXY3FLDJqOiOiTG5h551d1vrj+YonjlsP67uHu+vgvZc08NghCoxG9/D/TeTqSGmXsM5V1+B2jxeKckSCOhbWKcJbJZcoyT8gzlLc+2XapLTGX+Nb3eU8nLXUM+wkkg3lBGYgUr/tY19wzIG58ysn03BXmhNotqx5hU1QFbu/a8B2HAAIO2kLQ5ZR7YePjn7syLZ4AZ1Nz6jFnUP9xHoEeiapOWsCqXlnCxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQC2FG8QixVMaHL/7YL2B45EeAMq5mGO3/zBFuy0kcY=;
 b=eLs7gp8Rws1/Cg3LYQQZtHTK0vkbe9afYOPXxhnjbBPiwm4KlzyVjtRU5TlykT9oVnTo7mRPIywXwbQjsdSYs5voR7+Z7Um2q5ggQIqSicoWlaqeibnX1iL3Y7OffYVcYYX6NKERGrZuK2gehTPh4za/fSGbN1YphwYfy9clhDECWOoYkI6HToW4r5z6VFNQW5CdrubHUaXpI41Hqs84srIF2cZP/JvnMl+XSo3Eggh9QukXPfiC6+qgXI+ot259gwGyfK04TG/PlyL923WbpyykxEtjkZAgiR+ZujB04qM/cL0T8So/XtEJbOKff6ztT1eGrZhFuhKiKeld6OIJaA==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Tue, 30 Jan 2024 15:40:21 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::8825:1827:3273:bbbf%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:40:21 +0000
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
Thread-Index: AQHaU4g6jvRyzH1tPUCIs6q7Q9im2rDycmwAgAAGRTA=
Date: Tue, 30 Jan 2024 15:40:21 +0000
Message-ID:
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240130142521.18593-1-danielj@nvidia.com>
 <20240130095645-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240130095645-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|DM4PR12MB5745:EE_
x-ms-office365-filtering-correlation-id: 07ab6b98-3dc0-42bf-06e9-08dc21a9c4d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VrF5CBmZjmezdUdjAqtktBZs2qamQHKyrrA7VjudkvOu6deoNIeV2n6qJV+iaZtMXniLZgxWZRnEQAfO3GXGenXp5/TUgnxT4+jjbF5lw/3MsxarDXc/CcqCnHiPKsgbNe/xk6Kr4RqRRj7XzWi8pIhei3o6b8+CgoEo0p8j3C4V5aV8ChsugaSsYQw1y50noEIcMazK4qPfpGBEElEpR2VZcozZizseNPZpovmy7PT/HvSG0vuEPVKgJSBCeahf867je5fl9ceNJv5U4pEOVrNM0UQBxdsghcoi4XY+uZ/uIAeG7i9TafCyBorBzLTZ0aHRTF8NjjuQAjneHByIhBctwI/9h9ptPSET6tTvt9waCktymb7hwFuI0FdBbcbxtFc1rrvbhLRERi6O50t5ZBJp0NK/R3BrfACNJ1WrBWivdrNiZcII7a3g4LlVOdsibnwfwwmWeAMbKNkL6RVsHsI+EFfvBGf6WMpom9nTDsbYvkaMBlKm0v9kv3LabGNpmB1xejnfoZ1BZvejFnf4POF1r9oQNdfOxBfSy7HS416MYNAAQjDdzEp2obEeq0H9XnhPpQipNg7w6VVjJU/Y4pkCzdCZQ83+bOKQ6YjNxhAjEfTjejBJbtVVJgVJycXw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(107886003)(41300700001)(55016003)(478600001)(38070700009)(8676002)(7696005)(6506007)(9686003)(71200400001)(83380400001)(26005)(38100700002)(122000001)(86362001)(316002)(2906002)(76116006)(5660300002)(66946007)(54906003)(64756008)(6916009)(66446008)(66476007)(66556008)(33656002)(8936002)(4326008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KDfjHTEkll3SmsL3HNazK/Z+e1dwR4KMLP+57rm74PDwt1L5lMaRH7dlRoI5?=
 =?us-ascii?Q?2yZtz3wBwj9Qe7bE4nNLSWEl4VsJzfLTl5TvKwM9DLPgTUHNXmQYdtSzZZxZ?=
 =?us-ascii?Q?bAyGRrjS5PO4fii/hzbngfbe4mYzeLMaiIVSrpR1HsRdukpkflj1SWs93ax3?=
 =?us-ascii?Q?C8zL4M2n3E98StwzeLixeoTG0cmWA3kCJ8URNyG8CGNkNWo8GIUQHwl16Uun?=
 =?us-ascii?Q?enxvO2bU1NfXFmt4q5zB6KO/S/mJdahi+S2LzHR4HfvajgxfcVtK4Kt9vwZd?=
 =?us-ascii?Q?CRV+Btq8S+oKUXIih8PG2K2WAJdYvYDkktT5wbIxO150WLy4PaLbnNIme8UW?=
 =?us-ascii?Q?VuQ+RadyPHGgAAHrl+VfmSF+LyVPBYE3uYbz9nbb0TPy/dl9eu58GACOUCbD?=
 =?us-ascii?Q?cu0QIaM7d8lsgJ5qU8AEVfrX3HJa3vzC52tLu9fo3jTx2x3+hFo5JXBn0SPs?=
 =?us-ascii?Q?9nKxQ7b4D8WG70rSQPHAsgvhhMnLM8j1NkXDEN5SlVZn23kcIXlfxvu26/IG?=
 =?us-ascii?Q?eCYzouweKW1VC55xe1Mxmpszar4nmE98nER0tmqliVz/EcpUenvUid1K2Abq?=
 =?us-ascii?Q?V5YJy1sBqFYcBvfnaD/iDHf8P6FXYYEtrYwvIAZkqvM5Jcon8TC/I5lzBGgZ?=
 =?us-ascii?Q?KkatS8oMmULPd38QseX2pSq0viv8sZ8enBtq2A1rE9MHM2fk/OKjUvAC4THw?=
 =?us-ascii?Q?qUHKu4ZvH8Sm54IZ2t9AG0jcDzjKN+bINAam64oulhmRpQYcLOXjDaf/7y0Q?=
 =?us-ascii?Q?HNwpd/ynYg+k4naRtiUdPLqN+qDdahB+10LleT9SLfxI3QsVOLGw5w9ArAD0?=
 =?us-ascii?Q?EJ28eoMKo26F1gbBhyOrN61vzMKAZpFptn5Wst6nVlb+3FBycgNjydt6H2V5?=
 =?us-ascii?Q?/BnxRElp7dlv3zyMpeFX5WlnX057cnKCu6HZns7pZYUCfC/Vhumtfke7sQ3J?=
 =?us-ascii?Q?FiAgdge+a8CiF46V+XCEu+3jsrIJmnA8rQlCdJ2ZA4TR/hZuS1OmxlqGjBB6?=
 =?us-ascii?Q?bvlxhVb04xDq+m1xjei+C1Bdc6OZTB7pyFbuNmth3DhwRqkwIubuVOhDOY0U?=
 =?us-ascii?Q?cL6rlGuIYrEG7+Suine1EHQT56+cVks5tko4qSN/LY5XZfyMjnKk/BYeL8kC?=
 =?us-ascii?Q?veCQOWmWOrehrTpIbRrM/TayNk3l0zxPCNFMOho9O8wSy43wJ2A5Y2CdKJ85?=
 =?us-ascii?Q?qLSgw5+XWVayoM8G8hdRBikMUCeWe/Xk+mGrVP6KXnrsFPARKlM/yDnUzMtD?=
 =?us-ascii?Q?+gbI9rHrFzoMUG35nFxlPJzU/sStJ6vJYXZ0YD+7dgWsrzLp1XNwgkPdtI13?=
 =?us-ascii?Q?uKJl5mernzWVRrB4nF0u9sQT4QvobiAzaMsqET+AhS4S8Xq3gl7ZyWo01eeW?=
 =?us-ascii?Q?0/3KBOeavgFHTUXcbHvZFXria3Rj3eqO+ozjBKOTr6RVCqR+vKLHNrFHeZxe?=
 =?us-ascii?Q?/9goUA9HCr5h3u4gxm390sZju/T2DCSfT0OCoJA0vZUSXLGygt9c1gv26mde?=
 =?us-ascii?Q?8LrqGa1hgAEqrSpBvsCRpQy5bnqEvYw+EhR7Yvwwd/Xy1wx/S1jBPfNw2B8K?=
 =?us-ascii?Q?Zkw1U5uTS2SedI7BObU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ab6b98-3dc0-42bf-06e9-08dc21a9c4d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 15:40:21.4914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdgX3NTEl8xlsdfu60wHrST26CiawnNGcpH1yo3gbgE1IbwpNN0LWpPTxltuBXHRYQ7lZY/Mq4vnfd9FS4U5Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 30, 2024 8:58 AM
>=20
> On Tue, Jan 30, 2024 at 08:25:21AM -0600, Daniel Jurgens wrote:
> > Add a tx queue stop and wake counters, they are useful for debugging.
> >
> > 	$ ethtool -S ens5f2 | grep 'tx_stop\|tx_wake'
> > 	...
> > 	tx_queue_1_tx_stop: 16726
> > 	tx_queue_1_tx_wake: 16726
> > 	...
> > 	tx_queue_8_tx_stop: 1500110
> > 	tx_queue_8_tx_wake: 1500110
> >
> > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > Reviewed-by: Parav Pandit <parav@nvidia.com>
>=20
> Hmm isn't one always same as the other, except when queue is stopped?
> And when it is stopped you can see that in the status?
> So how is having two useful?

At idle the counters will be the same, unless a tx_timeout occurs. But unde=
r load they can be monitored to see which queues are stopped and get an ide=
a of how long they are stopped.

Other net drivers (not all), also have the wake counter. In my opinion it m=
akes the stop counter more useful, at little cost.

>=20
>=20
> > ---
> >  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > 3cb8aa193884..7e3c31ceaf7e 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -88,6 +88,8 @@ struct virtnet_sq_stats {
> >  	u64_stats_t xdp_tx_drops;
> >  	u64_stats_t kicks;
> >  	u64_stats_t tx_timeouts;
> > +	u64_stats_t tx_stop;
> > +	u64_stats_t tx_wake;
> >  };
> >
> >  struct virtnet_rq_stats {
> > @@ -112,6 +114,8 @@ static const struct virtnet_stat_desc
> virtnet_sq_stats_desc[] =3D {
> >  	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
> >  	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
> >  	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
> > +	{ "tx_stop",		VIRTNET_SQ_STAT(tx_stop) },
> > +	{ "tx_wake",		VIRTNET_SQ_STAT(tx_wake) },
> >  };
> >
> >  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] =3D { @@
> > -843,6 +847,9 @@ static void check_sq_full_and_disable(struct virtnet_i=
nfo
> *vi,
> >  	 */
> >  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> >  		netif_stop_subqueue(dev, qnum);
> > +		u64_stats_update_begin(&sq->stats.syncp);
> > +		u64_stats_inc(&sq->stats.tx_stop);
> > +		u64_stats_update_end(&sq->stats.syncp);
> >  		if (use_napi) {
> >  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> >  				virtqueue_napi_schedule(&sq->napi, sq-
> >vq); @@ -851,6 +858,9 @@
> > static void check_sq_full_and_disable(struct virtnet_info *vi,
> >  			free_old_xmit_skbs(sq, false);
> >  			if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS) {
> >  				netif_start_subqueue(dev, qnum);
> > +				u64_stats_update_begin(&sq->stats.syncp);
> > +				u64_stats_inc(&sq->stats.tx_wake);
> > +				u64_stats_update_end(&sq->stats.syncp);
> >  				virtqueue_disable_cb(sq->vq);
> >  			}
> >  		}
> > @@ -2163,8 +2173,14 @@ static void virtnet_poll_cleantx(struct
> receive_queue *rq)
> >  			free_old_xmit_skbs(sq, true);
> >  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> >
> > -		if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > +		if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > +			if (netif_tx_queue_stopped(txq)) {
> > +				u64_stats_update_begin(&sq->stats.syncp);
> > +				u64_stats_inc(&sq->stats.tx_wake);
> > +				u64_stats_update_end(&sq->stats.syncp);
> > +			}
> >  			netif_tx_wake_queue(txq);
> > +		}
> >
> >  		__netif_tx_unlock(txq);
> >  	}
> > @@ -2310,8 +2326,14 @@ static int virtnet_poll_tx(struct napi_struct
> *napi, int budget)
> >  	virtqueue_disable_cb(sq->vq);
> >  	free_old_xmit_skbs(sq, true);
> >
> > -	if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > +	if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > +		if (netif_tx_queue_stopped(txq)) {
> > +			u64_stats_update_begin(&sq->stats.syncp);
> > +			u64_stats_inc(&sq->stats.tx_wake);
> > +			u64_stats_update_end(&sq->stats.syncp);
> > +		}
> >  		netif_tx_wake_queue(txq);
> > +	}
> >
> >  	opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> >
> > --
> > 2.42.0


