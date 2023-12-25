Return-Path: <netdev+bounces-60181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E8081DF93
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 10:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E5D281790
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 09:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A73168BA;
	Mon, 25 Dec 2023 09:51:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FF5171D2
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-244-x8rLeWhFMJGStfkOYzIxSQ-1; Mon, 25 Dec 2023 09:51:52 +0000
X-MC-Unique: x8rLeWhFMJGStfkOYzIxSQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 25 Dec
 2023 09:51:30 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 25 Dec 2023 09:51:30 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>, "'David S . Miller'"
	<davem@davemloft.net>, "'kuba@kernel.org'" <kuba@kernel.org>
CC: "'eric.dumazet@gmail.com'" <eric.dumazet@gmail.com>,
	"'martin.lau@linux.dev'" <martin.lau@linux.dev>, 'Alexei Starovoitov'
	<ast@kernel.org>, 'Stephen Hemminger' <stephen@networkplumber.org>, "'Jens
 Axboe'" <axboe@kernel.dk>, 'Daniel Borkmann' <daniel@iogearbox.net>, "'Andrii
 Nakryiko'" <andrii@kernel.org>
Subject: [PATCH net-next 1/4] net: Use sockptr_is_kernel() instead of testing
 is_kernel
Thread-Topic: [PATCH net-next 1/4] net: Use sockptr_is_kernel() instead of
 testing is_kernel
Thread-Index: Ado3F/wSVSUpvrk/QWmUk3G1lq6geQ==
Date: Mon, 25 Dec 2023 09:51:30 +0000
Message-ID: <29578e9120b344b6b20f0efb107323b7@AcuMS.aculab.com>
References: <199c9af56a5741feaf4b1768bf7356be@AcuMS.aculab.com>
In-Reply-To: <199c9af56a5741feaf4b1768bf7356be@AcuMS.aculab.com>
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

Some changes to option handling directly accesses optval.is_kernel.
Use the sockptr_is_kernel() helper instead.

No functional change.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 net/ipv4/ip_sockglue.c   | 2 +-
 net/ipv6/ipv6_sockglue.c | 2 +-
 net/socket.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 2efc53526a38..94b2f8c095f5 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1647,7 +1647,7 @@ int do_ip_getsockopt(struct sock *sk, int level, int =
optname,
 =09=09if (sk->sk_type !=3D SOCK_STREAM)
 =09=09=09return -ENOPROTOOPT;
=20
-=09=09if (optval.is_kernel) {
+=09=09if (sockptr_is_kernel(optval)) {
 =09=09=09msg.msg_control_is_user =3D false;
 =09=09=09msg.msg_control =3D optval.kernel;
 =09=09} else {
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 7d661735cb9d..64fc52d928c1 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -1144,7 +1144,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, in=
t optname,
 =09=09if (sk->sk_type !=3D SOCK_STREAM)
 =09=09=09return -ENOPROTOOPT;
=20
-=09=09if (optval.is_kernel) {
+=09=09if (sockptr_is_kernel(optval)) {
 =09=09=09msg.msg_control_is_user =3D false;
 =09=09=09msg.msg_control =3D optval.kernel;
 =09=09} else {
diff --git a/net/socket.c b/net/socket.c
index 3379c64217a4..8821f083ab0a 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2366,7 +2366,7 @@ int do_sock_getsockopt(struct socket *sock, bool comp=
at, int level,
 =09} else if (unlikely(!ops->getsockopt)) {
 =09=09err =3D -EOPNOTSUPP;
 =09} else {
-=09=09if (WARN_ONCE(optval.is_kernel || optlen.is_kernel,
+=09=09if (WARN_ONCE(sockptr_is_kernel(optval) || sockptr_is_kernel(optlen)=
,
 =09=09=09      "Invalid argument type"))
 =09=09=09return -EOPNOTSUPP;
=20
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


