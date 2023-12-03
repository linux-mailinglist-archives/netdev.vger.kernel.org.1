Return-Path: <netdev+bounces-53309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B780236F
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 12:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501A3280C2F
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 11:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38ABE60;
	Sun,  3 Dec 2023 11:45:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FCE173B
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 03:44:33 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-196-tOXvKNADPYeckOMH02Xuyw-1; Sun, 03 Dec 2023 11:44:31 +0000
X-MC-Unique: tOXvKNADPYeckOMH02Xuyw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 3 Dec
 2023 11:44:11 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 3 Dec 2023 11:44:11 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mat Martineau' <martineau@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Stephen Hemminger
	<stephen@networkplumber.org>, Eric Dumazet <edumazet@google.com>, David Ahern
	<dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "jakub@cloudflare.com"
	<jakub@cloudflare.com>
Subject: RE: [PATCH net-next] ipv4: Use READ/WRITE_ONCE() for IP
 local_port_range
Thread-Topic: [PATCH net-next] ipv4: Use READ/WRITE_ONCE() for IP
 local_port_range
Thread-Index: Adoi+bAva1sBL8lHT0izPKjl5W7JsABtrriAAEsZ3VA=
Date: Sun, 3 Dec 2023 11:44:11 +0000
Message-ID: <d2c3d038ddd7405d8089aebcd7b0f343@AcuMS.aculab.com>
References: <a4f5b61c9cd44eada41d8f09d3848806@AcuMS.aculab.com>
 <896de7c3-5d7f-4b06-5159-ed58c350bafc@kernel.org>
In-Reply-To: <896de7c3-5d7f-4b06-5159-ed58c350bafc@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
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

...
> > +=09net->ipv4.ip_local_ports.range =3D  60999 << 16 | 32768;
>=20
> Hi David -
>=20
> Better to use unsigned integer constants here, since 60999 << 16 doesn't
> fit in a signed int on 32-bit platforms.

Or 64bit Linux for that matter.
I'll drop in a couple of u.

...
> > +=09case IP_LOCAL_PORT_RANGE:
> > +=09{
> > +=09=09const __u16 lo =3D val;
> > +=09=09const __u16 hi =3D val >> 16;
>=20
> Suggest casting 'val' to an unsigned int before shifting right, even
> though assigning to a __u16 will mask off any surprising bits introduced
> by an arithmetic right shift of a 32-bit signed int.
>=20
> > +
> > +=09=09if (optlen !=3D sizeof(__u32))
> > +=09=09=09return -EINVAL;
> > +=09=09if (lo !=3D 0 && hi !=3D 0 && lo > hi)
> > +=09=09=09return -EINVAL;

I'd rather leave that block alone since it is just moved from
further down the file.
Although I may remove the 'const __'.

...
> > @@ -54,22 +54,18 @@ static void set_local_port_range(struct net *net, i=
nt range[2])
> > {
> > =09bool same_parity =3D !((range[0] ^ range[1]) & 1);
> >
> > -=09write_seqlock_bh(&net->ipv4.ip_local_ports.lock);
> > =09if (same_parity && !net->ipv4.ip_local_ports.warned) {
> > =09=09net->ipv4.ip_local_ports.warned =3D true;
> > =09=09pr_err_ratelimited("ip_local_port_range: prefer different parity =
for start/end
> values.\n");
> > =09}
> > -=09net->ipv4.ip_local_ports.range[0] =3D range[0];
> > -=09net->ipv4.ip_local_ports.range[1] =3D range[1];
> > -=09write_sequnlock_bh(&net->ipv4.ip_local_ports.lock);
> > +=09WRITE_ONCE(net->ipv4.ip_local_ports.range, range[1] << 16 | range[0=
]);
>=20
> Similar, make sure the value is cast to unsigned before shifting here.

I think I'll pass the port numbers as two 'unsigned int' values
rather than 'int range[2]'.
Passing them at u16 doesn't work.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


