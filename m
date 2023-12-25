Return-Path: <netdev+bounces-60179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E216B81DF90
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 10:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115BA1C2176D
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2969E154BA;
	Mon, 25 Dec 2023 09:46:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FD12E401
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-208-Cs0Dl5VhNx-9eQZLK7BORg-1; Mon, 25 Dec 2023 09:46:46 +0000
X-MC-Unique: Cs0Dl5VhNx-9eQZLK7BORg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 25 Dec
 2023 09:46:23 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 25 Dec 2023 09:46:23 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S . Miller"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>
CC: "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, "Stephen
 Hemminger" <stephen@networkplumber.org>, Jens Axboe <axboe@kernel.dk>,
	"Daniel Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH net-next 0/4] sockptr: Change sockptr_t to be a struct
Thread-Topic: [PATCH net-next 0/4] sockptr: Change sockptr_t to be a struct
Thread-Index: Ado3FihDgm7OKd4BQLS3SCVxCLscZA==
Date: Mon, 25 Dec 2023 09:46:23 +0000
Message-ID: <199c9af56a5741feaf4b1768bf7356be@AcuMS.aculab.com>
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
This can't work on some architectures and was buggy on x86.
So the is_kernel discriminator was added after the union of pointers.

However this is still open to misuse and accidents.
Replace the union with a struct and remove the is_kernel member.
The user and kernel values are now in different places.
The structure size doesn't change - it was always padded out to 'two pointe=
rs'.

The only functional difference is that NULL pointers are always 'user'.
So dereferencing will (usually) fault in copy_from_user() rather than
panic if supplied as a kernel address.

Simple driver code that uses kernel sockets still works.
I've not tested bpf - but that should work unless it is breaking
the rules.

The first three patches just change the code to use the helpers
from sockptr.h.
The functional change is in the fourth patch.


David Laight (4):
  Use sockptr_is_kernel() instead of testing is_kernel.
  Use bpfptr_is_kernel() instead of checking the is_kernel member.
  Use the sockptr_t helpers.
  Change sockptr_t to be a struct of a kernel and user pointer.

 include/linux/bpfptr.h   | 10 ++++------
 include/linux/sockptr.h  | 15 +++++----------
 kernel/bpf/bpf_iter.c    |  2 +-
 kernel/bpf/btf.c         |  2 +-
 kernel/bpf/syscall.c     | 12 ++++++------
 kernel/bpf/verifier.c    | 10 +++++-----
 net/ipv4/ip_sockglue.c   |  2 +-
 net/ipv6/ipv6_sockglue.c |  2 +-
 net/socket.c             |  2 +-
 9 files changed, 25 insertions(+), 32 deletions(-)

--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


