Return-Path: <netdev+bounces-21351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE347635CF
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16607281E13
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19519BE60;
	Wed, 26 Jul 2023 12:05:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A302CA77
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:05:13 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694AAA
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:05:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-140-3WAb1yA1P6OELqLW_7NEXg-1; Wed, 26 Jul 2023 13:05:08 +0100
X-MC-Unique: 3WAb1yA1P6OELqLW_7NEXg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 26 Jul
 2023 13:05:07 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 26 Jul 2023 13:05:07 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'willemdebruijn.kernel@gmail.com'" <willemdebruijn.kernel@gmail.com>,
	"'davem@davemloft.net'" <davem@davemloft.net>, "'dsahern@kernel.org'"
	<dsahern@kernel.org>, 'Eric Dumazet' <edumazet@google.com>,
	"'kuba@kernel.org'" <kuba@kernel.org>, "'pabeni@redhat.com'"
	<pabeni@redhat.com>, "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>
Subject: [PATCH 1/2] Move hash calculation inside udp4_lib_lookup2()
Thread-Topic: [PATCH 1/2] Move hash calculation inside udp4_lib_lookup2()
Thread-Index: Adm/uWROjgkE4udKTdiQAS8haeW/0g==
Date: Wed, 26 Jul 2023 12:05:07 +0000
Message-ID: <5eb8631d430248999116ce8ced13e4b2@AcuMS.aculab.com>
References: <fbcaa54791cd44999de5fec7c6cf0b3c@AcuMS.aculab.com>
In-Reply-To: <fbcaa54791cd44999de5fec7c6cf0b3c@AcuMS.aculab.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pass the udptable address into udp4_lib_lookup2() instead of the hash slot.

While ipv4_portaddr_hash(net, IP_ADDR_ANY, 0) is constant for each net
(the port is an xor) the value isn't saved.
Since the hash function doesn't get simplified when passed zero the hash
might as well be computed inside udp4_lib_lookup2().

This reduces the cache footprint and allows additional checks.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 net/ipv4/udp.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 42a96b3547c9..ad64d6c4cd99 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -439,12 +439,18 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 =09=09=09=09     __be32 saddr, __be16 sport,
 =09=09=09=09     __be32 daddr, unsigned int hnum,
 =09=09=09=09     int dif, int sdif,
-=09=09=09=09     struct udp_hslot *hslot2,
+=09=09=09=09     struct udp_table *udptable,
 =09=09=09=09     struct sk_buff *skb)
 {
+=09unsigned int hash2, slot2;
+=09struct udp_hslot *hslot2;
 =09struct sock *sk, *result;
 =09int score, badness;
=20
+=09hash2 =3D ipv4_portaddr_hash(net, daddr, hnum);
+=09slot2 =3D hash2 & udptable->mask;
+=09hslot2 =3D &udptable->hash2[slot2];
+
 =09result =3D NULL;
 =09badness =3D 0;
 =09udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
@@ -495,18 +501,12 @@ struct sock *__udp4_lib_lookup(struct net *net, __be3=
2 saddr,
 =09=09int sdif, struct udp_table *udptable, struct sk_buff *skb)
 {
 =09unsigned short hnum =3D ntohs(dport);
-=09unsigned int hash2, slot2;
-=09struct udp_hslot *hslot2;
 =09struct sock *result, *sk;
=20
-=09hash2 =3D ipv4_portaddr_hash(net, daddr, hnum);
-=09slot2 =3D hash2 & udptable->mask;
-=09hslot2 =3D &udptable->hash2[slot2];
-
 =09/* Lookup connected or non-wildcard socket */
 =09result =3D udp4_lib_lookup2(net, saddr, sport,
 =09=09=09=09  daddr, hnum, dif, sdif,
-=09=09=09=09  hslot2, skb);
+=09=09=09=09  udptable, skb);
 =09if (!IS_ERR_OR_NULL(result) && result->sk_state =3D=3D TCP_ESTABLISHED)
 =09=09goto done;
=20
@@ -525,13 +525,9 @@ struct sock *__udp4_lib_lookup(struct net *net, __be32=
 saddr,
 =09=09goto done;
=20
 =09/* Lookup wildcard sockets */
-=09hash2 =3D ipv4_portaddr_hash(net, htonl(INADDR_ANY), hnum);
-=09slot2 =3D hash2 & udptable->mask;
-=09hslot2 =3D &udptable->hash2[slot2];
-
 =09result =3D udp4_lib_lookup2(net, saddr, sport,
 =09=09=09=09  htonl(INADDR_ANY), hnum, dif, sdif,
-=09=09=09=09  hslot2, skb);
+=09=09=09=09  udptable, skb);
 done:
 =09if (IS_ERR(result))
 =09=09return NULL;
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


