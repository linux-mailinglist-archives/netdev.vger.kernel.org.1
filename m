Return-Path: <netdev+bounces-21353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E81DC7635D6
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB6C281DEF
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274CBBE71;
	Wed, 26 Jul 2023 12:06:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0BBE5D
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:06:05 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03EAE0
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:06:03 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-65-dxeZYJvvPxaSglt4r8Eqag-1; Wed, 26 Jul 2023 13:06:01 +0100
X-MC-Unique: dxeZYJvvPxaSglt4r8Eqag-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 26 Jul
 2023 13:05:59 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 26 Jul 2023 13:05:59 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'willemdebruijn.kernel@gmail.com'" <willemdebruijn.kernel@gmail.com>,
	"'davem@davemloft.net'" <davem@davemloft.net>, "'dsahern@kernel.org'"
	<dsahern@kernel.org>, 'Eric Dumazet' <edumazet@google.com>,
	"'kuba@kernel.org'" <kuba@kernel.org>, "'pabeni@redhat.com'"
	<pabeni@redhat.com>, "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>
Subject: [PATCH 2/2] Rescan the hash2 list if the hash chains have got
 cross-linked.
Thread-Topic: [PATCH 2/2] Rescan the hash2 list if the hash chains have got
 cross-linked.
Thread-Index: Adm/uYXsrlBDnyZsQsqXScrMcg4Dhw==
Date: Wed, 26 Jul 2023 12:05:59 +0000
Message-ID: <c45337a3d46641dc8c4c66bd49fb55b6@AcuMS.aculab.com>
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

udp_lib_rehash() can get called at any time and will move a
socket to a different hash2 chain.
This can cause udp4_lib_lookup2() (processing incoming UDP) to
fail to find a socket and an ICMP port unreachable be sent.

Prior to ca065d0cf80fa the lookup used 'hlist_nulls' and checked
that the 'end if list' marker was on the correct list.

Rather than re-instate the 'nulls' list just check that the final
socket is on the correct list.

The cross-linking can definitely happen (see earlier issues with
it looping forever because gcc cached the list head).

Fixes: ca065d0cf80fa ("udp: no longer use SLAB_DESTROY_BY_RCU")
Signed-off-by: David Laight <david.laight@aculab.com>
---
 net/ipv4/udp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ad64d6c4cd99..ed92ba7610b0 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -443,6 +443,7 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 =09=09=09=09     struct sk_buff *skb)
 {
 =09unsigned int hash2, slot2;
+=09unsigned int hash2_rescan;
 =09struct udp_hslot *hslot2;
 =09struct sock *sk, *result;
 =09int score, badness;
@@ -451,9 +452,12 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 =09slot2 =3D hash2 & udptable->mask;
 =09hslot2 =3D &udptable->hash2[slot2];
=20
+rescan:
+=09hash2_rescan =3D hash2;
 =09result =3D NULL;
 =09badness =3D 0;
 =09udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
+=09=09hash2_rescan =3D udp_sk(sk)->udp_portaddr_hash;
 =09=09score =3D compute_score(sk, net, saddr, sport,
 =09=09=09=09      daddr, hnum, dif, sdif);
 =09=09if (score > badness) {
@@ -467,6 +471,16 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 =09=09=09badness =3D score;
 =09=09}
 =09}
+
+=09/* udp sockets can get moved to a different hash chain.
+=09 * If the chains have got crossed then rescan.
+=09 */
+=09if ((hash2_rescan & udptable->mask) !=3D slot2) {
+=09=09/* Ensure hslot2->head is reread */
+=09=09barrier();
+=09=09goto rescan;
+=09}
+
 =09return result;
 }
=20
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


