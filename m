Return-Path: <netdev+bounces-21346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9017635A2
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786A21C21236
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E371BA50;
	Wed, 26 Jul 2023 11:51:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42410BE5E
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:51:24 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7F12707
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 04:51:10 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-23-n_gsjf-cO9y4kYTHGY7s8A-1; Wed, 26 Jul 2023 12:51:08 +0100
X-MC-Unique: n_gsjf-cO9y4kYTHGY7s8A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 26 Jul
 2023 12:51:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 26 Jul 2023 12:51:06 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org"
	<dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH 0/2] udp: rescan hash2 list if chains crossed.
Thread-Topic: [PATCH 0/2] udp: rescan hash2 list if chains crossed.
Thread-Index: Adm/tzLjTa0Xped3QGK8HLejyxiyjQ==
Date: Wed, 26 Jul 2023 11:51:06 +0000
Message-ID: <fbcaa54791cd44999de5fec7c6cf0b3c@AcuMS.aculab.com>
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

Commit ca065d0cf80fa removed the rescan of the hash2 list (local
address + local port) during udp receive if the final socket
wasn't on the expected hash chain.

While unusual, udp sockets can get rehashed (and without an rcu
delay) without this rescan received packets can generate an unexpected
ICMP port unreachable instead of being delivered to a local socket.

The rescan could be checked for every socket, but the chances of
the hash chain being diverted twice and ending up in the correct
list is pretty minimal.

This is the 'smoking gun' for some ICMP port unreachable messages
being received on long-lived UDP sockets on 127.0.0.1.
The failures are rare and being seen on AWS - so it is pretty
impossible to test the patch.

David Laight (2):
  Move hash calculation inside udp4_lib_lookup2()
  Rescan the hash2 list if the hash chains have got cross-linked.

 net/ipv4/udp.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


