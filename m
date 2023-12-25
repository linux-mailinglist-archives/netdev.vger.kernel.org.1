Return-Path: <netdev+bounces-60184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE0981DF9A
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 10:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1DA1C2176D
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889B4179BE;
	Mon, 25 Dec 2023 09:58:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C1A179B1
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-405--17qtIQCNQ-VIvzLmd8C0A-1; Mon, 25 Dec 2023 09:58:53 +0000
X-MC-Unique: -17qtIQCNQ-VIvzLmd8C0A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 25 Dec
 2023 09:58:30 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 25 Dec 2023 09:58:30 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>, "'David S . Miller'"
	<davem@davemloft.net>, "'kuba@kernel.org'" <kuba@kernel.org>
CC: "'eric.dumazet@gmail.com'" <eric.dumazet@gmail.com>,
	"'martin.lau@linux.dev'" <martin.lau@linux.dev>, 'Alexei Starovoitov'
	<ast@kernel.org>, 'Stephen Hemminger' <stephen@networkplumber.org>, "'Jens
 Axboe'" <axboe@kernel.dk>, 'Daniel Borkmann' <daniel@iogearbox.net>, "'Andrii
 Nakryiko'" <andrii@kernel.org>
Subject: [PATCH net-next 4/4] sockptr: Change sockptr_t to be a struct of a
 kernel and user pointer.
Thread-Topic: [PATCH net-next 4/4] sockptr: Change sockptr_t to be a struct of
 a kernel and user pointer.
Thread-Index: Ado3GOykMznC7Y2GTLihcf026jh1OQ==
Date: Mon, 25 Dec 2023 09:58:30 +0000
Message-ID: <18fcf82093314112a569aa8327b52f1c@AcuMS.aculab.com>
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

The original commit for sockptr_t tried to use the pointer value
to determine whether a pointer was user or kernel.
This can't work on some architecures and was buffy on x86.
So the is_kernel descriminator was added after the union of pointers.

However this is still open to misuse and accidents.
Replace the union with a struct and remove the is_kernel member.
The user and kernel values are now in different places.
The size doesn't change - it was always padded out to 'two pointers'.

The only functional difference is that NULL pointers are always 'user'.
So dereferncing will (usually) fault in copy_from_user() rather than
panic if supplied as a kernel address.

Simple driver code that uses kernel sockets still works.
I've not tested bpf - but that should work unless it is breaking
the rules.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/sockptr.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index 307961b41541..7516c2ada6a8 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -12,21 +12,18 @@
 #include <linux/uaccess.h>
=20
 typedef struct {
-=09union {
-=09=09void=09=09*kernel;
-=09=09void __user=09*user;
-=09};
-=09bool=09=09is_kernel : 1;
+=09void=09=09*kernel;
+=09void __user=09*user;
 } sockptr_t;
=20
 static inline bool sockptr_is_kernel(sockptr_t sockptr)
 {
-=09return sockptr.is_kernel;
+=09return !!sockptr.kernel;
 }
=20
 static inline sockptr_t KERNEL_SOCKPTR(void *p)
 {
-=09return (sockptr_t) { .kernel =3D p, .is_kernel =3D true };
+=09return (sockptr_t) { .kernel =3D p };
 }
=20
 static inline sockptr_t USER_SOCKPTR(void __user *p)
@@ -36,9 +33,7 @@ static inline sockptr_t USER_SOCKPTR(void __user *p)
=20
 static inline bool sockptr_is_null(sockptr_t sockptr)
 {
-=09if (sockptr_is_kernel(sockptr))
-=09=09return !sockptr.kernel;
-=09return !sockptr.user;
+=09return !sockptr.user && !sockptr.kernel;
 }
=20
 static inline int copy_from_sockptr_offset(void *dst, sockptr_t src,
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


