Return-Path: <netdev+bounces-19011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEB475951C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 14:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105C52811A3
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 12:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818D8569F;
	Wed, 19 Jul 2023 12:30:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760E814A88
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:30:30 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C1013E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 05:30:28 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-196-TmQF06h3N0mgSpi61nJSKQ-1; Wed, 19 Jul 2023 13:30:25 +0100
X-MC-Unique: TmQF06h3N0mgSpi61nJSKQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Jul
 2023 13:30:24 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 19 Jul 2023 13:30:24 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>
Subject: Unexpected ICMP errors for UDP packets to 127.0.0.1
Thread-Topic: Unexpected ICMP errors for UDP packets to 127.0.0.1
Thread-Index: Adm6NH7v7EHG77rAQpq5zHt2O6xZeg==
Date: Wed, 19 Jul 2023 12:30:24 +0000
Message-ID: <225a9a92c82a4654b10cb8db68abfc3a@AcuMS.aculab.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We are seeing an application (running on AWS) failing because in
is receiving an ICMP error indication for a UDP packet to 127.0.0.1.

It is very rare - 3 instances since the end of January 2023.
No errors were reported in the previous 6 month with much the
same workload (or for several years without ipsec).
So we suspect a kernel change between (about) 5.10.147 and 5.10.162
(the last fail was with 5.10.184).

The loopback UDP sockets are created at startup and are never closed.
The sender is an IPv6 socket bound to ::, the receiver a connected
IPv4 socket.
(All the traffic is actually IPv4.)

The sender does a recvmsg(... MSG_ERRQUEUE) and gets a
SO_EE_ORIGIN_ICMP indication (we don't know which type!).

AFAICT this is only generated for a received ICMP message
(ie nothing in the transmit path can generate it).

The receiving socket is still there, it later reports ECONNREFUSED
as a consequence of the sender closing its socket.

We think the trigger is changes to the ipsec config (changes the
xfrm tables) for some tunnels on eth0.
Somewhere this must be causing a transient error in the routing.

There are 10-20 ipsec connections with a lifetime of hours.
There are 100s of other UDP sockets and lots of 'host unreachable'
indications being sent.

So either the kernel decides it can deliver a packet to 127.0.0.1
received from lo0 or the udp socket lookup fails.
Could the latter happen (somehow) if the 'dst' address on the
socket is somehow different to the one in the skb?
Perhaps due to the effects of rcu updates?

Early dmux is enabled, and there were some associated changes
prior to 5.10.162 - but they don't look problematic.
There are also some additional checks in the fib lookup code
and in the xfrm code, I don't know that code at all.
But AFAICT the xfrm code causes silent discards - not icmp.

Any ideas as to what to look for?
This is a live system on AWS - we can't use a test kernel.
There is also a lot of UDP traffic (it is processing RTP audio).
So options are rather limited.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


