Return-Path: <netdev+bounces-52428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CE17FEB59
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 10:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809FAB20DC5
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82BE321A3;
	Thu, 30 Nov 2023 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA4B9
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 01:04:41 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-258-7sZ5_6P0N8a6Y_sMVfxPCQ-1; Thu, 30 Nov 2023 09:04:38 +0000
X-MC-Unique: 7sZ5_6P0N8a6Y_sMVfxPCQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 30 Nov
 2023 09:04:37 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 30 Nov 2023 09:04:37 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jakub Sitnicki' <jakub@cloudflare.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 'Jakub Kicinski'
	<kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Stephen Hemminger
	<stephen@networkplumber.org>, Eric Dumazet <edumazet@google.com>, "'David
 Ahern'" <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH net-next] ipv4: Use READ/WRITE_ONCE() for IP
 local_port_range
Thread-Topic: [PATCH net-next] ipv4: Use READ/WRITE_ONCE() for IP
 local_port_range
Thread-Index: Adoi+bAva1sBL8lHT0izPKjl5W7JsAAB2DuAABo0W/A=
Date: Thu, 30 Nov 2023 09:04:36 +0000
Message-ID: <a00cb120e5224a20931dcba10987cc80@AcuMS.aculab.com>
References: <a4f5b61c9cd44eada41d8f09d3848806@AcuMS.aculab.com>
 <87r0k82tbi.fsf@cloudflare.com>
In-Reply-To: <87r0k82tbi.fsf@cloudflare.com>
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

From: Jakub Sitnicki
> Sent: 29 November 2023 20:17
>=20
> Hey David,
>=20
> On Wed, Nov 29, 2023 at 07:26 PM GMT, David Laight wrote:
> > Commit 227b60f5102cd added a seqlock to ensure that the low and high
> > port numbers were always updated together.
> > This is overkill because the two 16bit port numbers can be held in
> > a u32 and read/written in a single instruction.
> >
> > More recently 91d0b78c5177f added support for finer per-socket limits.
> > The user-supplied value is 'high << 16 | low' but they are held
> > separately and the socket options protected by the socket lock.
> >
> > Use a u32 containing 'high << 16 | low' for both the 'net' and 'sk'
> > fields and use READ_ONCE()/WRITE_ONCE() to ensure both values are
> > always updated together.
> >
> > Change (the now trival) inet_get_local_port_range() to a static inline
> > to optimise the calling code.
> > (In particular avoiding returning integers by reference.)
> >
> > Signed-off-by: David Laight <david.laight@aculab.com>
> > ---
>=20
> Regarding the per-socket changes - we don't expect contention on sock
> lock between inet_stream_connect / __inet_bind, where we grab it and
> eventually call inet_sk_get_local_port_range, and sockopt handlers, do
> we?
>=20
> The motivation is not super clear for me for that of the changes.

The locking in the getsockopt() code is actually quite horrid.
Look at the conditionals for the rntl lock.
It is conditionally acquired based on a function that sets a flag,
but released based on the exit path from the switch statement.

But there are only two options that need the rtnl lock and the socket
lock, and two trivial ones (including this one) that need the socket
lock.
So the code can be simplified by moving the locking into the case branches.
With only 2 such cases the overhead will be minimal (compared the to
setsockopt() case where a lot of options need locking.

This is all part of a big patchset I'm trying to write that converts
all the setsockopt code to take an 'unsigned int optlen' parameter
and return the length to pass back to the caller.
So the copy_to_user() of the updated length is done by the syscall
stub rather than inside every separate function (and sometimes in
multiple places in a function).

After all, if the copy fails EFAULT the application is broken.
It really doesn't matter if any side effects have happened.
If you get a fault reading from a pipe the data is lost.

>=20
> >  include/net/inet_sock.h         |  5 +----
> >  include/net/ip.h                |  7 ++++++-
> >  include/net/netns/ipv4.h        |  3 +--
> >  net/ipv4/af_inet.c              |  4 +---
> >  net/ipv4/inet_connection_sock.c | 29 ++++++++++------------------
> >  net/ipv4/ip_sockglue.c          | 34 ++++++++++++++++-----------------
> >  net/ipv4/sysctl_net_ipv4.c      | 12 ++++--------
> >  7 files changed, 40 insertions(+), 54 deletions(-)
> >
> > diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> > index 74db6d97cae1..ebf71410aa2b 100644
> > --- a/include/net/inet_sock.h
> > +++ b/include/net/inet_sock.h
> > @@ -234,10 +234,7 @@ struct inet_sock {
> >  =09int=09=09=09uc_index;
> >  =09int=09=09=09mc_index;
> >  =09__be32=09=09=09mc_addr;
> > -=09struct {
> > -=09=09__u16 lo;
> > -=09=09__u16 hi;
> > -=09}=09=09=09local_port_range;
> > +=09u32=09=09=09local_port_range;
>=20
> Nit: This field would benefit from a similar comment as you have added to
> local_ports.range ("/* high << 16 | low */"), now that it is no longer
> obvious how to interpret the contents.
>=20
> >
> >  =09struct ip_mc_socklist __rcu=09*mc_list;
> >  =09struct inet_cork_full=09cork;
>=20
> [...]
>=20
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection=
_sock.c
> > index 394a498c2823..1a45d41f8b39 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -117,34 +117,25 @@ bool inet_rcv_saddr_any(const struct sock *sk)
>=20
> [...]
>=20
> >  void inet_sk_get_local_port_range(const struct sock *sk, int *low, int=
 *high)
> >  {
> >  =09const struct inet_sock *inet =3D inet_sk(sk);
> >  =09const struct net *net =3D sock_net(sk);
> >  =09int lo, hi, sk_lo, sk_hi;
> > +=09u32 sk_range;
> >
> >  =09inet_get_local_port_range(net, &lo, &hi);
> >
> > -=09sk_lo =3D inet->local_port_range.lo;
> > -=09sk_hi =3D inet->local_port_range.hi;
> > +=09sk_range =3D READ_ONCE(inet->local_port_range);
> > +=09if (unlikely(sk_range)) {
> > +=09=09sk_lo =3D sk_range & 0xffff;
> > +=09=09sk_hi =3D sk_range >> 16;
> >
> > -=09if (unlikely(lo <=3D sk_lo && sk_lo <=3D hi))
> > -=09=09lo =3D sk_lo;
> > -=09if (unlikely(lo <=3D sk_hi && sk_hi <=3D hi))
> > -=09=09hi =3D sk_hi;
> > +=09=09if (unlikely(lo <=3D sk_lo && sk_lo <=3D hi))
> > +=09=09=09lo =3D sk_lo;
> > +=09=09if (unlikely(lo <=3D sk_hi && sk_hi <=3D hi))
> > +=09=09=09hi =3D sk_hi;
> > +=09}
>=20
> Actually when we know that sk_range is set, the above two branches
> become likely. It will be usually so that the set per-socket port range
> narrows down the per-netns port range.

True, I'd left them alone, but would also flip the first conditional.

I can edit the patch :-)

=09David

>=20
> These checks exist only in case the per-netns port range has been
> reconfigured after per-socket port range has been set. The per-netns one
> always takes precedence.
>=20
> >
> >  =09*low =3D lo;
> >  =09*high =3D hi;
>=20
> [...]

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


