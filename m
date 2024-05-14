Return-Path: <netdev+bounces-96303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A371B8C4E40
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BCD1F22B53
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7C522F0F;
	Tue, 14 May 2024 08:58:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E61CD2B
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715677110; cv=none; b=Ixh/FvxorENjGsaXbhfHDl85Cd7nwFe1rlczVJPnfWu2gKq3Kyap7f3N4LAs5B71WJalp+0Y5btlNInvjnRmoOsbexk/KeI68nYBQemmilg3+5XN6mPFgzedXDQVEAjPEleEt5rn3nzhk7Z1Wcqshz+ze5VItYitirLJjLDSkbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715677110; c=relaxed/simple;
	bh=//jC5dAbq4AMaTLWDrE871ne2I2nSakUbmw8/sDw5cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Zou7P5APJA0JotCLagZ/GdXxU3FeV1LLfa8zn6VxkTRU5obGDc3sxN/QgilvuGPmkMIp9H7ymACimnSfRofGL9JXLvqy+FvxdhRK/A6EOBtcnZxXWrEpDI/Dir07+c6jPh4zDyrFusCwgX3hHimyMaWogkxDhmbUnlLkAJlviKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-aiCGn6F1O5Kf4kuc2eUkEA-1; Tue, 14 May 2024 04:58:18 -0400
X-MC-Unique: aiCGn6F1O5Kf4kuc2eUkEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29FC2101A52C;
	Tue, 14 May 2024 08:58:18 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 71C3D103A3AA;
	Tue, 14 May 2024 08:58:16 +0000 (UTC)
Date: Tue, 14 May 2024 10:58:15 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 13/24] ovpn: implement TCP transport
Message-ID: <ZkMnpy3_T8YO3eHD@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-14-antonio@openvpn.net>
 <ZkIosadLULByXFKc@hog>
 <73433bdf-763b-4023-8cb9-ffd9487744e0@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <73433bdf-763b-4023-8cb9-ffd9487744e0@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-14, 00:20:24 +0200, Antonio Quartulli wrote:
> On 13/05/2024 16:50, Sabrina Dubroca wrote:
> > 2024-05-06, 03:16:26 +0200, Antonio Quartulli wrote:
> > > diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> > > index 9ae9844dd281..a04d6e55a473 100644
> > > --- a/drivers/net/ovpn/main.c
> > > +++ b/drivers/net/ovpn/main.c
> > > @@ -23,6 +23,7 @@
> > >   #include "io.h"
> > >   #include "packet.h"
> > >   #include "peer.h"
> > > +#include "tcp.h"
> > >   /* Driver info */
> > >   #define DRV_DESCRIPTION=09"OpenVPN data channel offload (ovpn)"
> > > @@ -247,8 +248,14 @@ static struct pernet_operations ovpn_pernet_ops =
=3D {
> > >   static int __init ovpn_init(void)
> > >   {
> > > -=09int err =3D register_netdevice_notifier(&ovpn_netdev_notifier);
> > > +=09int err =3D ovpn_tcp_init();
> > > +=09if (err) {
> >=20
> > ovpn_tcp_init cannot fail (and if it could, you'd need to clean up
> > when register_netdevice_notifier fails). I'd make ovpn_tcp_init void
> > and kill this check.
>=20
> I like to have all init functions returning int by design, even though th=
ey
> may not fail.
>=20
> But I can undersand this is not necessarily good practice (somebody will
> always ask "when does it fail?" and there will will be no answer, which i=
s
> confusing)

Yes, pretty much.


> > > diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> > > index b5ff59a4b40f..ac4907705d98 100644
> > > --- a/drivers/net/ovpn/peer.h
> > > +++ b/drivers/net/ovpn/peer.h
> > > + * @tcp.raw_len: next packet length as read from the stream (TCP onl=
y)
> > > + * @tcp.skb: next packet being filled with data from the stream (TCP=
 only)
> > > + * @tcp.offset: position of the next byte to write in the skb (TCP o=
nly)
> > > + * @tcp.data_len: next packet length converted to host order (TCP on=
ly)
> >=20
> > It would be nice to add information about whether they're used for TX o=
r RX.
>=20
> they are all about "from the stream" and "to the skb", meaning that we ar=
e
> doing RX.
> Will make it more explicit.

Maybe group them in a struct rx?

> > > + * @tcp.sk_cb.sk_data_ready: pointer to original cb
> > > + * @tcp.sk_cb.sk_write_space: pointer to original cb
> > > + * @tcp.sk_cb.prot: pointer to original prot object
> > >    * @crypto: the crypto configuration (ciphers, keys, etc..)
> > >    * @dst_cache: cache for dst_entry used to send to peer
> > >    * @bind: remote peer binding
> > > @@ -59,6 +69,25 @@ struct ovpn_peer {
> > >   =09struct ptr_ring netif_rx_ring;
> > >   =09struct napi_struct napi;
> > >   =09struct ovpn_socket *sock;
> > > +=09/* state of the TCP reading. Needed to keep track of how much of =
a
> > > +=09 * single packet has already been read from the stream and how mu=
ch is
> > > +=09 * missing
> > > +=09 */
> > > +=09struct {
> > > +=09=09struct ptr_ring tx_ring;
> > > +=09=09struct work_struct tx_work;
> > > +=09=09struct work_struct rx_work;
> > > +
> > > +=09=09u8 raw_len[sizeof(u16)];
> >=20
> > Why not u16 or __be16 for this one?
>=20
> because in this array we are putting the bytes as we get them from the
> stream.
> We may be at the point where one out of two bytes is available on the
> stream. For this reason I use an array to store this u16 byte by byte.
>=20
> Once thw two bytes are ready, we convert the content in an actual int and
> store it in "data_len" (a few lines below).

Ok, I see. Hopefully you can switch to strparser and make this one go
away.


> > > diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> > > index e099a61b03fa..004db5b13663 100644
> > > --- a/drivers/net/ovpn/socket.c
> > > +++ b/drivers/net/ovpn/socket.c
> > > @@ -16,6 +16,7 @@
> > >   #include "packet.h"
> > >   #include "peer.h"
> > >   #include "socket.h"
> > > +#include "tcp.h"
> > >   #include "udp.h"
> > >   /* Finalize release of socket, called after RCU grace period */
> > > @@ -26,6 +27,8 @@ static void ovpn_socket_detach(struct socket *sock)
> > >   =09if (sock->sk->sk_protocol =3D=3D IPPROTO_UDP)
> > >   =09=09ovpn_udp_socket_detach(sock);
> > > +=09else if (sock->sk->sk_protocol =3D=3D IPPROTO_TCP)
> > > +=09=09ovpn_tcp_socket_detach(sock);
> > >   =09sockfd_put(sock);
> > >   }
> > > @@ -69,6 +72,8 @@ static int ovpn_socket_attach(struct socket *sock, =
struct ovpn_peer *peer)
> > >   =09if (sock->sk->sk_protocol =3D=3D IPPROTO_UDP)
> > >   =09=09ret =3D ovpn_udp_socket_attach(sock, peer->ovpn);
> > > +=09else if (sock->sk->sk_protocol =3D=3D IPPROTO_TCP)
> > > +=09=09ret =3D ovpn_tcp_socket_attach(sock, peer);
> > >   =09return ret;
> > >   }
> > > @@ -124,6 +129,21 @@ struct ovpn_socket *ovpn_socket_new(struct socke=
t *sock, struct ovpn_peer *peer)
> > >   =09ovpn_sock->sock =3D sock;
> >=20
> > The line above this is:
> >=20
> >      ovpn_sock->ovpn =3D peer->ovpn;
> >=20
> > It's technically fine since you then overwrite this with peer in case
> > we're on TCP, but ovpn_sock->ovpn only exists on UDP since you moved
> > it into a union in this patch.
>=20
> Yeah, I did not want to make another branch, but having a UDP specific ca=
se
> will make code easier to read.

Either that, or drop the union.


> > > diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> > > new file mode 100644
> > > index 000000000000..84ad7cd4fc4f
> > > --- /dev/null
> > > +++ b/drivers/net/ovpn/tcp.c
> > > @@ -0,0 +1,511 @@
> > > +static int ovpn_tcp_read_sock(read_descriptor_t *desc, struct sk_buf=
f *in_skb,
> > > +=09=09=09      unsigned int in_offset, size_t in_len)
> > > +{
> > > +=09struct sock *sk =3D desc->arg.data;
> > > +=09struct ovpn_socket *sock;
> > > +=09struct ovpn_skb_cb *cb;
> > > +=09struct ovpn_peer *peer;
> > > +=09size_t chunk, copied =3D 0;
> > > +=09void *data;
> > > +=09u16 len;
> > > +=09int st;
> > > +
> > > +=09rcu_read_lock();
> > > +=09sock =3D rcu_dereference_sk_user_data(sk);
> > > +=09rcu_read_unlock();
> >=20
> > You can't just release rcu_read_lock and keep using sock (here and in
> > the rest of this file). Either you keep rcu_read_lock, or you can take
> > a reference on the ovpn_socket.
>=20
> I was just staring at this today, after having worked on the
> rcu_read_lock/unlock for the peer get()s..
>=20
> I thinkt the assumption was: if we are in this read_sock callback, it's
> impossible that the ovpn_socket was invalidated, because it gets invalida=
ted
> upon detach, which also prevents any further calling of this callback. Bu=
t
> this sounds racy, and I guess we should somewhat hold a reference..

ovpn_tcp_read_sock starts

detach
kfree_rcu(ovpn_socket)
...
ovpn_socket actually freed
...
ovpn_tcp_read_sock continues with freed ovpn_socket


I don't think anything in the current code prevents this.


> > > +/* Set TCP encapsulation callbacks */
> > > +int ovpn_tcp_socket_attach(struct socket *sock, struct ovpn_peer *pe=
er)
> > > +{
> > > +=09void *old_data;
> > > +=09int ret;
> > > +
> > > +=09INIT_WORK(&peer->tcp.tx_work, ovpn_tcp_tx_work);
> > > +
> > > +=09ret =3D ptr_ring_init(&peer->tcp.tx_ring, OVPN_QUEUE_LEN, GFP_KER=
NEL);
> > > +=09if (ret < 0) {
> > > +=09=09netdev_err(peer->ovpn->dev, "cannot allocate TCP TX ring\n");
> > > +=09=09return ret;
> > > +=09}
> > > +
> > > +=09peer->tcp.skb =3D NULL;
> > > +=09peer->tcp.offset =3D 0;
> > > +=09peer->tcp.data_len =3D 0;
> > > +
> > > +=09write_lock_bh(&sock->sk->sk_callback_lock);
> > > +
> > > +=09/* make sure no pre-existing encapsulation handler exists */
> > > +=09rcu_read_lock();
> > > +=09old_data =3D rcu_dereference_sk_user_data(sock->sk);
> > > +=09rcu_read_unlock();
> > > +=09if (old_data) {
> > > +=09=09netdev_err(peer->ovpn->dev,
> > > +=09=09=09   "provided socket already taken by other user\n");
> > > +=09=09ret =3D -EBUSY;
> > > +=09=09goto err;
> >=20
> > The UDP code differentiates "socket already owned by this interface"
> > from "already taken by other user". That doesn't apply to TCP?
>=20
> This makes me wonder: how safe it is to interpret the user data as an obj=
ect
> of type ovpn_socket?
>
> When we find the user data already assigned, we don't know what was reall=
y
> stored in there, right?
> Technically this socket could have gone through another module which
> assigned its own state.
>=20
> Therefore I think that what UDP does [ dereferencing ((struct ovpn_socket
> *)user_data)->ovpn ] is probably not safe. Would you agree?

Hmmm, yeah, I think you're right. If you checked encap_type =3D=3D
UDP_ENCAP_OVPNINUDP before (sk_prot for TCP), then you'd know it's
really your data. Basically call ovpn_from_udp_sock during attach if
you want to check something beyond EBUSY.

Once you're in your own callbacks, it should be safe. If some other
code sends packet with a non-ovpn socket to ovpn's ->encap_rcv,
something is really broken.

> > > +int __init ovpn_tcp_init(void)
> > > +{
> > > +=09/* We need to substitute the recvmsg and the sock_is_readable
> > > +=09 * callbacks in the sk_prot member of the sock object for TCP
> > > +=09 * sockets.
> > > +=09 *
> > > +=09 * However sock->sk_prot is a pointer to a static variable and
> > > +=09 * therefore we can't directly modify it, otherwise every socket
> > > +=09 * pointing to it will be affected.
> > > +=09 *
> > > +=09 * For this reason we create our own static copy and modify what
> > > +=09 * we need. Then we make sk_prot point to this copy
> > > +=09 * (in ovpn_tcp_socket_attach())
> > > +=09 */
> > > +=09ovpn_tcp_prot =3D tcp_prot;
> >=20
> > Don't you need a separate variant for IPv6, like TLS does?
>=20
> Never did so far.
>=20
> My wild wild wild guess: for the time this socket is owned by ovpn, we on=
ly
> use callbacks that are IPvX agnostic, hence v4 vs v6 doesn't make any
> difference.
> When this socket is released, we reassigned the original prot.

That seems a bit suspicious to me. For example, tcpv6_prot has a
different backlog_rcv. And you don't control if the socket is detached
before being closed, or which callbacks are needed. Your userspace
client doesn't use them, but someone else's might.

> > > +=09ovpn_tcp_prot.recvmsg =3D ovpn_tcp_recvmsg;
> >=20
> > You don't need to replace ->sendmsg as well? The userspace client is
> > not expected to send messages?
>=20
> It is, but my assumption is that those packets will just go through the
> socket as usual. No need to be handled by ovpn (those packets are not
> encrypted/decrypted, like data traffic is).
> And this is how it has worked so far.
>=20
> Makes sense?

Two things come to mind:

- userspace is expected to prefix the messages it inserts on the
  stream with the 2-byte length field? otherwise, the peer won't be
  able to parse them out of the stream

- I'm not convinced this would be safe wrt kernel writing partial
  messages. if ovpn_tcp_send_one doesn't send the full message, you
  could interleave two messages:

  +------+-------------------+------+--------+----------------+
  | len1 | (bytes from msg1) | len2 | (msg2) | (rest of msg1) |
  +------+-------------------+------+--------+----------------+

  and the RX side would parse that as:

  +------+-----------------------------------+------+---------
  | len1 | (bytes from msg1) | len2 | (msg2) | ???? | ...    =20
  +------+-------------------+---------------+------+---------

  and try to interpret some random bytes out of either msg1 or msg2 as
  a length prefix, resulting in a broken stream.


The stream format looks identical to ESP in TCP [1] (2B length prefix
followed by the actual message), so I think the espintcp code (both tx
and rx, except for actual protocol parsing) should look very
similar. The problems that need to be solved for both protocols are
pretty much the same.

[1] https://www.rfc-editor.org/rfc/rfc8229#section-3

--=20
Sabrina


