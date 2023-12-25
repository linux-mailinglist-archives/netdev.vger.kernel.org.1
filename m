Return-Path: <netdev+bounces-60183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE93881DF99
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 10:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81706B20DB2
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 09:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DBE179B1;
	Mon, 25 Dec 2023 09:57:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B65233CD2
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-103-DExrTS3GPNeLTpLIDldG6A-1; Mon, 25 Dec 2023 09:57:30 +0000
X-MC-Unique: DExrTS3GPNeLTpLIDldG6A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 25 Dec
 2023 09:57:07 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 25 Dec 2023 09:57:07 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>, "'David S . Miller'"
	<davem@davemloft.net>, "'kuba@kernel.org'" <kuba@kernel.org>
CC: "'eric.dumazet@gmail.com'" <eric.dumazet@gmail.com>,
	"'martin.lau@linux.dev'" <martin.lau@linux.dev>, 'Alexei Starovoitov'
	<ast@kernel.org>, 'Stephen Hemminger' <stephen@networkplumber.org>, "'Jens
 Axboe'" <axboe@kernel.dk>, 'Daniel Borkmann' <daniel@iogearbox.net>, "'Andrii
 Nakryiko'" <andrii@kernel.org>
Subject: [PATCH net-next 3/4] bpf: Use the sockptr_t helpers
Thread-Topic: [PATCH net-next 3/4] bpf: Use the sockptr_t helpers
Thread-Index: Ado3GLi6l4IqbB7BSMemHKk1GiWhXg==
Date: Mon, 25 Dec 2023 09:57:07 +0000
Message-ID: <631454442da243998455d325c224f2be@AcuMS.aculab.com>
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

bpfptr_t is defined as sockptr_t but the bpfptr_is_kernel(),
bpfptr_is_null(), KERNEL_BPFPTR() and USER_BPFPTR() helpers are
copies of the sockptr ones.
Instead implement in terms of the sockptr helpers.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/bpfptr.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpfptr.h b/include/linux/bpfptr.h
index 79b2f78eec1a..862e87350477 100644
--- a/include/linux/bpfptr.h
+++ b/include/linux/bpfptr.h
@@ -10,17 +10,17 @@ typedef sockptr_t bpfptr_t;
=20
 static inline bool bpfptr_is_kernel(bpfptr_t bpfptr)
 {
-=09return bpfptr.is_kernel;
+=09return sockptr_is_kernel(bpfptr);
 }
=20
 static inline bpfptr_t KERNEL_BPFPTR(void *p)
 {
-=09return (bpfptr_t) { .kernel =3D p, .is_kernel =3D true };
+=09return KERNEL_SOCKPTR(p);
 }
=20
 static inline bpfptr_t USER_BPFPTR(void __user *p)
 {
-=09return (bpfptr_t) { .user =3D p };
+=09return USER_SOCKPTR(p);
 }
=20
 static inline bpfptr_t make_bpfptr(u64 addr, bool is_kernel)
@@ -33,9 +33,7 @@ static inline bpfptr_t make_bpfptr(u64 addr, bool is_kern=
el)
=20
 static inline bool bpfptr_is_null(bpfptr_t bpfptr)
 {
-=09if (bpfptr_is_kernel(bpfptr))
-=09=09return !bpfptr.kernel;
-=09return !bpfptr.user;
+=09return sockptr_is_null(bpfptr);
 }
=20
 static inline void bpfptr_add(bpfptr_t *bpfptr, size_t val)
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


