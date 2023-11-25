Return-Path: <netdev+bounces-51032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7657F8C05
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 16:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A02B20ED3
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A8328DB8;
	Sat, 25 Nov 2023 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B29FF
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 07:23:36 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-250-cWnaHxeJP3Kxzg3QHFqbUw-1; Sat, 25 Nov 2023 15:23:32 +0000
X-MC-Unique: cWnaHxeJP3Kxzg3QHFqbUw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 25 Nov
 2023 15:23:49 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 25 Nov 2023 15:23:49 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kent Overstreet' <kent.overstreet@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: RE: [PATCH] rhashtable: Better error message on allocation failure
Thread-Topic: [PATCH] rhashtable: Better error message on allocation failure
Thread-Index: AQHaHmlAOmj1d1ASnU6F5GtzDO5q0LCLKOWA
Date: Sat, 25 Nov 2023 15:23:49 +0000
Message-ID: <36bcdab2dae7429d9c2162879d0a3f9a@AcuMS.aculab.com>
References: <20231123235949.421106-1-kent.overstreet@linux.dev>
In-Reply-To: <20231123235949.421106-1-kent.overstreet@linux.dev>
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

From: Kent Overstreet
> Sent: 24 November 2023 00:00
>=20
> Memory allocation failures print backtraces by default, but when we're
> running out of a rhashtable worker the backtrace is useless - it doesn't
> tell us which hashtable the allocation failure was for.
>=20
> This adds a dedicated warning that prints out functions from the
> rhashtable params, which will be a bit more useful.
>=20
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Thomas Graf <tgraf@suug.ch>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>  lib/rhashtable.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 6ae2ba8e06a2..d3fce9c8989a 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -360,9 +360,14 @@ static int rhashtable_rehash_alloc(struct rhashtable=
 *ht,
>=20
>  =09ASSERT_RHT_MUTEX(ht);
>=20
> -=09new_tbl =3D bucket_table_alloc(ht, size, GFP_KERNEL);
> -=09if (new_tbl =3D=3D NULL)
> +=09new_tbl =3D bucket_table_alloc(ht, size, GFP_KERNEL|__GFP_NOWARN);
> +=09if (new_tbl =3D=3D NULL) {
> +=09=09WARN("rhashtable bucket table allocation failure for %ps",

Won't WARN() be a panic on systems with PANICK_ON_WARN set?

> +=09=09     (void *) ht->p.hashfn ?:
> +=09=09     (void *) ht->p.obj_hashfn ?:
> +=09=09     (void *) ht->p.obj_cmpfn);

That layout is horrid (and I bet checkpatch complains).
You only actually need one (void *) cast on the RH value:
=09=09=09ht->p.hashfn ?: ht->p.obj_hashfn ?: (void *)ht->p.obj_cmpfn

=09David


>  =09=09return -ENOMEM;
> +=09}
>=20
>  =09err =3D rhashtable_rehash_attach(ht, old_tbl, new_tbl);
>  =09if (err)
> --
> 2.42.0
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


