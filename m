Return-Path: <netdev+bounces-19780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173275C3C1
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D151C21655
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740AC17758;
	Fri, 21 Jul 2023 09:53:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F714F9C
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 09:53:45 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459EFFC
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 02:53:18 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-317-0nzHMNa9O-mcATlUMwzBYg-1; Fri, 21 Jul 2023 10:52:08 +0100
X-MC-Unique: 0nzHMNa9O-mcATlUMwzBYg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 21 Jul
 2023 10:52:05 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 21 Jul 2023 10:52:05 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Richard Gobert' <richardbgobert@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "tom@herbertland.com"
	<tom@herbertland.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"gal@nvidia.com" <gal@nvidia.com>
Subject: RE: [PATCH v2 1/1] net: gro: fix misuse of CB in udp socket lookup
Thread-Topic: [PATCH v2 1/1] net: gro: fix misuse of CB in udp socket lookup
Thread-Index: AQHZuyb8Dgvvf3H/5Uu3VMX13B7+Z6/D+W5A
Date: Fri, 21 Jul 2023 09:52:05 +0000
Message-ID: <09f45decdd92494f9ef5abb2c5ce13f3@AcuMS.aculab.com>
References: <20230720161322.GA16323@debian> <20230720162624.GA16428@debian>
In-Reply-To: <20230720162624.GA16428@debian>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Richard Gobert
> Sent: 20 July 2023 17:26
>=20
> This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
> `udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch th=
e
> device from CB. The fix changes it to fetch the device from `skb->dev`.
> l3mdev case requires special attention since it has a master and a slave
> device.
>=20
...
> +/* This function is the alternative to 'inet_iif' and 'inet_sdif'
> + * functions in case we can not rely on fields of IPCB.
> + *
> + * The caller must verify skb_valid_dst(skb) is false and skb->dev is in=
itialized.
> + * The caller must hold the RCU read lock.
> + */
> +inline void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *=
sdif)
> +{
> +=09*iif =3D inet_iif(skb) ?: skb->dev->ifindex;
> +=09*sdif =3D 0;
> +
> +#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
> +=09if (netif_is_l3_slave(skb->dev)) {
> +=09=09struct net_device *master =3D netdev_master_upper_dev_get_rcu(skb-=
>dev);
> +
> +=09=09*sdif =3D *iif;
> +=09=09*iif =3D master ? master->ifindex : 0;
> +=09}
> +#endif
> +}

You need to make that a 'static inline' in the .h file.
Otherwise the code generated will be horrid.

It would be much better to use the return value - say for 'iif'
then have:
{
=09iif =3D inet_iif(skb) ?: skb->dev->ifindex;

if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
=09if (netif_is_l3_slave(skb->dev)) {
=09=09struct net_device *master =3D netdev_master_upper_dev_get_rcu(skb->de=
v);

=09=09*sdif =3D iif;
=09=09return master ? master->ifindex : 0;
=09}
#endif
=09*sdif =3D 0;
=09return iif;
}

The compiler might generate that is inlined, not inlined
it is definitely better.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


